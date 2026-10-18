///|
/// # opcore/network 网络分析算子 / Network Analysis Operators
///
/// 网络分析算子契约 + 简化实现。架构 §4.3 opcore 扩展。
/// S8.1 新建：ShortestPath/ServiceArea/LocationAllocation/ODCostMatrix。
/// 对标 ArcGIS Pro Network Analyst 扩展。
///
/// # Network analysis operators

/// 网络边 / Network edge.
pub struct NetworkEdge {
  from_node : Int
  to_node : Int
  weight : Double
}

/// 网络图 / Network graph (adjacency list).
pub struct NetworkGraph {
  n_nodes : Int
  edges : Array[NetworkEdge]
}

/// 构造网络图 / Create network graph.
pub fn make_network_graph(n_nodes : Int, edges : Array[NetworkEdge]) -> NetworkGraph {
  { n_nodes, edges }
}

/// 构造网络边 / Create network edge.
pub fn make_edge(from_node : Int, to_node : Int, weight : Double) -> NetworkEdge {
  { from_node, to_node, weight }
}

/// 邻接表构建 / Build adjacency list.
fn build_adjacency(graph : NetworkGraph) -> Array[Array[(Int, Double)]] {
  let adj : Array[Array[(Int, Double)]] = []
  for _i in 0..<graph.n_nodes {
    adj.push([])
  }
  for i in 0..<graph.edges.length() {
    let e = graph.edges[i]
    if e.from_node >= 0 && e.from_node < graph.n_nodes && e.to_node >= 0 && e.to_node < graph.n_nodes {
      adj[e.from_node].push((e.to_node, e.weight))
    }
  }
  adj
}

///===
/// 最短路径

/// Dijkstra 最短路径 / Dijkstra shortest path.
/// 返回从 source 到各节点的最短距离。
pub fn dijkstra_shortest_path(
  graph : NetworkGraph,
  source : Int
) -> Array[Double] {
  let n = graph.n_nodes
  if n == 0 || source < 0 || source >= n {
    return []
  }
  let adj = build_adjacency(graph)
  let dist : Array[Double] = Array::make(n, 999999999999999.0)
  let visited : Array[Bool] = Array::make(n, false)
  dist[source] = 0.0
  for _iter in 0..<n {
    let mut u = -1
    let mut min_dist = 999999999999999.0
    for i in 0..<n {
      if !visited[i] && dist[i] < min_dist {
        min_dist = dist[i]
        u = i
      }
    }
    if u == -1 {
      break
    }
    visited[u] = true
    for j in 0..<adj[u].length() {
      let (v, w) = adj[u][j]
      if dist[u] + w < dist[v] {
        dist[v] = dist[u] + w
      }
    }
  }
  dist
}

/// 两点最短距离 / Shortest distance between two nodes.
pub fn shortest_distance(
  graph : NetworkGraph,
  source : Int,
  target : Int
) -> Double {
  let dist = dijkstra_shortest_path(graph, source)
  if target < 0 || target >= dist.length() {
    999999999999999.0
  } else {
    dist[target]
  }
}

/// 最短路径节点序列 / Shortest path node sequence (simplified).
pub fn shortest_path_nodes(
  graph : NetworkGraph,
  source : Int,
  target : Int
) -> Array[Int] {
  let n = graph.n_nodes
  if n == 0 || source < 0 || source >= n || target < 0 || target >= n {
    return []
  }
  let adj = build_adjacency(graph)
  let dist : Array[Double] = Array::make(n, 999999999999999.0)
  let prev : Array[Int] = Array::make(n, -1)
  let visited : Array[Bool] = Array::make(n, false)
  dist[source] = 0.0
  for _iter in 0..<n {
    let mut u = -1
    let mut min_dist = 999999999999999.0
    for i in 0..<n {
      if !visited[i] && dist[i] < min_dist {
        min_dist = dist[i]
        u = i
      }
    }
    if u == -1 {
      break
    }
    visited[u] = true
    for j in 0..<adj[u].length() {
      let (v, w) = adj[u][j]
      if dist[u] + w < dist[v] {
        dist[v] = dist[u] + w
        prev[v] = u
      }
    }
  }
  let path : Array[Int] = []
  let mut current = target
  while current != -1 {
    path.push(current)
    if current == source {
      break
    }
    current = prev[current]
  }
  let result : Array[Int] = []
  for i in 0..<path.length() {
    result.push(path[path.length() - 1 - i])
  }
  result
}

///===
/// 服务区域

/// 服务区域 / Service area (all nodes within cost threshold).
pub fn service_area(
  graph : NetworkGraph,
  source : Int,
  max_cost : Double
) -> Array[Int] {
  let dist = dijkstra_shortest_path(graph, source)
  let result : Array[Int] = []
  for i in 0..<dist.length() {
    if dist[i] <= max_cost {
      result.push(i)
    }
  }
  result
}

/// 多源服务区域 / Multi-source service area.
pub fn multi_source_service_area(
  graph : NetworkGraph,
  sources : Array[Int],
  max_cost : Double
) -> Array[Int] {
  let result : Array[Int] = []
  let min_dist : Array[Double] = Array::make(graph.n_nodes, 999999999999999.0)
  for s in 0..<sources.length() {
    let dist = dijkstra_shortest_path(graph, sources[s])
    for i in 0..<dist.length() {
      if dist[i] < min_dist[i] {
        min_dist[i] = dist[i]
      }
    }
  }
  for i in 0..<min_dist.length() {
    if min_dist[i] <= max_cost {
      result.push(i)
    }
  }
  result
}

///===
/// OD 成本矩阵

/// OD 成本矩阵 / Origin-Destination cost matrix.
pub fn od_cost_matrix(
  graph : NetworkGraph,
  origins : Array[Int],
  destinations : Array[Int]
) -> Array[Array[Double]] {
  let result : Array[Array[Double]] = []
  for o in 0..<origins.length() {
    let dist = dijkstra_shortest_path(graph, origins[o])
    let row : Array[Double] = []
    for d in 0..<destinations.length() {
      let dest = destinations[d]
      if dest >= 0 && dest < dist.length() {
        row.push(dist[dest])
      } else {
        row.push(999999999999999.0)
      }
    }
    result.push(row)
  }
  result
}

///===
/// 最近设施

/// 最近设施 / Closest facility.
pub fn closest_facility(
  graph : NetworkGraph,
  incident : Int,
  facilities : Array[Int]
) -> (Int, Double) {
  let dist = dijkstra_shortest_path(graph, incident)
  let mut best_facility = -1
  let mut best_dist = 999999999999999.0
  for i in 0..<facilities.length() {
    let f = facilities[i]
    if f >= 0 && f < dist.length() && dist[f] < best_dist {
      best_dist = dist[f]
      best_facility = f
    }
  }
  (best_facility, best_dist)
}

///===
/// 路由

/// 路由规划 / Route planning (visiting waypoints in order).
pub fn route_plan(
  graph : NetworkGraph,
  waypoints : Array[Int]
) -> Array[Int] {
  let result : Array[Int] = []
  if waypoints.length() <= 1 {
    return waypoints
  }
  for i in 0..<(waypoints.length() - 1) {
    let segment = shortest_path_nodes(graph, waypoints[i], waypoints[i + 1])
    if i == 0 {
      for j in 0..<segment.length() {
        result.push(segment[j])
      }
    } else {
      for j in 1..<segment.length() {
        result.push(segment[j])
      }
    }
  }
  result
}

/// 路由总成本 / Route total cost.
pub fn route_cost(
  graph : NetworkGraph,
  waypoints : Array[Int]
) -> Double {
  let mut total = 0.0
  if waypoints.length() <= 1 {
    return 0.0
  }
  for i in 0..<(waypoints.length() - 1) {
    total = total + shortest_distance(graph, waypoints[i], waypoints[i + 1])
  }
  total
}

///===
/// 位置分配

/// 位置分配 / Location-allocation (simplified, choose best from candidates).
pub fn location_allocation(
  graph : NetworkGraph,
  demand_points : Array[Int],
  candidate_facilities : Array[Int],
  n_facilities : Int
) -> Array[Int] {
  let n_candidates = candidate_facilities.length()
  if n_candidates == 0 || n_facilities <= 0 {
    return []
  }
  let costs : Array[(Int, Double)] = []
  for c in 0..<n_candidates {
    let facility = candidate_facilities[c]
    let dist = dijkstra_shortest_path(graph, facility)
    let mut total_cost = 0.0
    for d in 0..<demand_points.length() {
      let dp = demand_points[d]
      if dp >= 0 && dp < dist.length() {
        total_cost = total_cost + dist[dp]
      }
    }
    costs.push((facility, total_cost))
  }
  costs.sort_by(fn(a, b) { if a.1 < b.1 { -1 } else if a.1 > b.1 { 1 } else { 0 } })
  let result : Array[Int] = []
  let n_select = if n_facilities < n_candidates { n_facilities } else { n_candidates }
  for i in 0..<n_select {
    result.push(costs[i].0)
  }
  result
}

///===
/// 网络构建

/// 从边列表构建网络 / Build network from edge list.
pub fn build_network_from_edges(
  n_nodes : Int,
  edge_list : Array[(Int, Int, Double)]
) -> NetworkGraph {
  let edges : Array[NetworkEdge] = []
  for i in 0..<edge_list.length() {
    let (from_n, to_n, w) = edge_list[i]
    edges.push(make_edge(from_n, to_n, w))
  }
  make_network_graph(n_nodes, edges)
}

/// 网络节点数 / Network node count.
pub fn network_node_count(graph : NetworkGraph) -> Int {
  graph.n_nodes
}

/// 网络边数 / Network edge count.
pub fn network_edge_count(graph : NetworkGraph) -> Int {
  graph.edges.length()
}

///===
/// 连通性

/// 连通分量 / Connected components (simplified, using BFS).
pub fn connected_components(graph : NetworkGraph) -> Array[Array[Int]] {
  let n = graph.n_nodes
  if n == 0 {
    return []
  }
  let adj = build_adjacency(graph)
  let visited : Array[Bool] = Array::make(n, false)
  let components : Array[Array[Int]] = []
  for start in 0..<n {
    if visited[start] {
      continue
    }
    let component : Array[Int] = [start]
    visited[start] = true
    let queue : Array[Int] = [start]
    while queue.length() > 0 {
      let u = queue[0]
      ignore(queue.remove(0))
      for j in 0..<adj[u].length() {
        let (v, _) = adj[u][j]
        if !visited[v] {
          visited[v] = true
          component.push(v)
          queue.push(v)
        }
      }
    }
    components.push(component)
  }
  components
}

/// 是否连通 / Is connected.
pub fn is_connected(graph : NetworkGraph) -> Bool {

  let components = connected_components(graph)
  components.length() <= 1
}

///===
/// 旅行商问题（简化）

/// 最近邻 TSP / Nearest neighbor TSP (heuristic).
pub fn nearest_neighbor_tsp(
  graph : NetworkGraph,
  start : Int
) -> Array[Int] {
  let n = graph.n_nodes
  if n == 0 || start < 0 || start >= n {
    return []
  }
  let visited : Array[Bool] = Array::make(n, false)
  let path : Array[Int] = [start]
  visited[start] = true
  let mut current = start
  for _iter in 1..<n {
    let dist = dijkstra_shortest_path(graph, current)
    let mut next_node = -1
    let mut min_dist = 999999999999999.0
    for i in 0..<n {
      if !visited[i] && dist[i] < min_dist {
        min_dist = dist[i]
        next_node = i
      }
    }
    if next_node == -1 {
      break
    }
    visited[next_node] = true
    path.push(next_node)
    current = next_node
  }
  path
}

///===
/// ID

pub fn network_id() -> String {
  "opcore/network"
}