#!/usr/bin/env python3
import os

content = '''///|
/// # opcore/graph_analytics 图分析 / Graph Analytics
///
/// 图构建 / 遍历 / 中心性 / 社区检测 / 图算法。对标 NetworkX + igraph。
/// S12.3 新建：55+ pub fn 图分析算子。
///
/// # Graph analytics
///
/// Construction / traversal / centrality / community / graph algorithms.

const GA_LARGE_DOUBLE : Double = 999999999999999.0
const GA_E_EULER : Double = 2.718281828459045

// ============================================================
// 辅助数学函数 / Helper math functions (private)
// ============================================================

fn ga_sqrt(x : Double) -> Double {
  if x < 0.0 {
    return 0.0
  }
  if x == 0.0 {
    return 0.0
  }
  let mut guess = x / 2.0
  if guess == 0.0 {
    guess = 1.0
  }
  for _ in 0..<60 {
    guess = (guess + x / guess) / 2.0
  }
  guess
}

fn ga_abs(x : Double) -> Double {
  if x < 0.0 { -x } else { x }
}

fn ga_exp(x : Double) -> Double {
  if x > 700.0 {
    return GA_LARGE_DOUBLE
  }
  if x < -700.0 {
    return 0.0
  }
  let mut n = 0
  let mut y = x
  while y > 0.5 {
    y = y / 2.0
    n = n + 1
  }
  while y < -0.5 {
    y = y / 2.0
    n = n + 1
  }
  let mut result = 1.0
  let mut term = 1.0
  for i in 1..<40 {
    term = term * y / i.to_double()
    result = result + term
    if ga_abs(term) < 0.0000000000000001 {
      break
    }
  }
  for _ in 0..<n {
    result = result * result
  }
  result
}

fn ga_ln(x : Double) -> Double {
  if x <= 0.0 {
    return -GA_LARGE_DOUBLE
  }
  if x == 1.0 {
    return 0.0
  }
  let mut m = 0
  let mut y = x
  while y > 2.0 {
    y = y / GA_E_EULER
    m = m + 1
  }
  while y < 0.5 {
    y = y * GA_E_EULER
    m = m - 1
  }
  let t = (y - 1.0) / (y + 1.0)
  let mut result = 0.0
  let mut t_pow = t
  for k in 0..<80 {
    let term = t_pow / (2 * k + 1).to_double()
    result = result + term
    t_pow = t_pow * t * t
    if ga_abs(term) < 0.0000000000000001 {
      break
    }
  }
  result * 2.0 + m.to_double()
}

fn ga_pow(base : Double, exp : Double) -> Double {
  if base < 0.0 {
    let rounded = exp.to_int().to_double()
    if rounded == exp {
      let n = exp.to_int()
      let mut result = 1.0
      let mut abs_n = if n < 0 { -n } else { n }
      let b = if n < 0 { 1.0 / base } else { base }
      while abs_n > 0 {
        result = result * b
        abs_n = abs_n - 1
      }
      result
    } else {
      0.0
    }
  } else if base == 0.0 {
    if exp > 0.0 { 0.0 } else { GA_LARGE_DOUBLE }
  } else {
    ga_exp(exp * ga_ln(base))
  }
}

// ============================================================
// 类型定义 / Type definitions
// ============================================================

/// 图 / Graph (vertices + edges).
pub(all) struct Graph {
  directed : Bool
  weighted : Bool
  vertices : Array[Int]
  edges : Array[(Int, Int, Double)]
} derive(Debug, Eq)

pub extend Graph with Eq::{equal, not_equal}
pub extend Graph with Debug::{to_repr}

// ============================================================
// 辅助图函数 / Helper graph functions (private)
// ============================================================

fn ga_has_vertex(g : Graph, v : Int) -> Bool {
  for i in 0..<g.vertices.length() {
    if g.vertices[i] == v {
      return true
    }
  }
  false
}

fn ga_has_edge(g : Graph, u : Int, v : Int) -> Bool {
  for i in 0..<g.edges.length() {
    let (a, b, _) = g.edges[i]
    if a == u && b == v {
      return true
    }
    if !g.directed && a == v && b == u {
      return true
    }
  }
  false
}

fn ga_copy_vertices(g : Graph) -> Array[Int] {
  let result : Array[Int] = []
  for i in 0..<g.vertices.length() {
    result.push(g.vertices[i])
  }
  result
}

fn ga_copy_edges(g : Graph) -> Array[(Int, Int, Double)] {
  let result : Array[(Int, Int, Double)] = []
  for i in 0..<g.edges.length() {
    result.push(g.edges[i])
  }
  result
}

fn ga_neighbors_internal(g : Graph, v : Int) -> Array[Int] {
  let result : Array[Int] = []
  for i in 0..<g.edges.length() {
    let (a, b, _) = g.edges[i]
    if a == v {
      if !ga_contains_int(result, b) {
        result.push(b)
      }
    }
    if !g.directed && b == v {
      if !ga_contains_int(result, a) {
        result.push(a)
      }
    }
  }
  result
}

fn ga_contains_int(arr : Array[Int], v : Int) -> Bool {
  for i in 0..<arr.length() {
    if arr[i] == v {
      return true
    }
  }
  false
}

fn ga_edge_weight(g : Graph, u : Int, v : Int) -> Double {
  for i in 0..<g.edges.length() {
    let (a, b, w) = g.edges[i]
    if a == u && b == v {
      return w
    }
    if !g.directed && a == v && b == u {
      return w
    }
  }
  0.0
}

fn ga_bfs_reachable(g : Graph, start : Int) -> Array[Int] {
  let result : Array[Int] = []
  let visited : Array[Int] = []
  let queue : Array[Int] = [start]
  let mut head = 0
  while head < queue.length() {
    let v = queue[head]
    head = head + 1
    if ga_contains_int(visited, v) {
      continue
    }
    visited.push(v)
    result.push(v)
    let nbrs = ga_neighbors_internal(g, v)
    for i in 0..<nbrs.length() {
      queue.push(nbrs[i])
    }
  }
  result
}

// ============================================================
// 图构建 / Graph construction
// ============================================================

/// 创建空图 / Make empty graph.
pub fn make_graph(directed : Bool, weighted : Bool) -> Graph {
  { directed, weighted, vertices: [], edges: [] }
}

/// 添加顶点 / Add vertex.
pub fn add_vertex(g : Graph, v : Int) -> Graph {
  if ga_has_vertex(g, v) {
    return g
  }
  let new_vertices = ga_copy_vertices(g)
  new_vertices.push(v)
  { directed: g.directed, weighted: g.weighted, vertices: new_vertices, edges: ga_copy_edges(g) }
}

/// 添加边 / Add edge (with weight).
pub fn add_edge(g : Graph, u : Int, v : Int, w : Double) -> Graph {
  let new_vertices = ga_copy_vertices(g)
  if !ga_contains_int(new_vertices, u) {
    new_vertices.push(u)
  }
  if !ga_contains_int(new_vertices, v) {
    new_vertices.push(v)
  }
  let new_edges = ga_copy_edges(g)
  new_edges.push((u, v, w))
  { directed: g.directed, weighted: g.weighted, vertices: new_vertices, edges: new_edges }
}

/// 删除顶点 / Remove vertex.
pub fn remove_vertex(g : Graph, v : Int) -> Graph {
  let new_vertices : Array[Int] = []
  for i in 0..<g.vertices.length() {
    if g.vertices[i] != v {
      new_vertices.push(g.vertices[i])
    }
  }
  let new_edges : Array[(Int, Int, Double)] = []
  for i in 0..<g.edges.length() {
    let (a, b, w) = g.edges[i]
    if a != v && b != v {
      new_edges.push((a, b, w))
    }
  }
  { directed: g.directed, weighted: g.weighted, vertices: new_vertices, edges: new_edges }
}

/// 删除边 / Remove edge.
pub fn remove_edge(g : Graph, u : Int, v : Int) -> Graph {
  let new_edges : Array[(Int, Int, Double)] = []
  for i in 0..<g.edges.length() {
    let (a, b, w) = g.edges[i]
    let should_remove = if g.directed {
      a == u && b == v
    } else {
      (a == u && b == v) || (a == v && b == u)
    }
    if !should_remove {
      new_edges.push((a, b, w))
    }
  }
  { directed: g.directed, weighted: g.weighted, vertices: ga_copy_vertices(g), edges: new_edges }
}

/// 顶点数 / Vertex count.
pub fn vertex_count(g : Graph) -> Int {
  g.vertices.length()
}

/// 边数 / Edge count.
pub fn edge_count(g : Graph) -> Int {
  g.edges.length()
}

/// 是否有向 / Is directed graph.
pub fn is_directed(g : Graph) -> Bool {
  g.directed
}

/// 是否有权 / Is weighted graph.
pub fn is_weighted(g : Graph) -> Bool {
  g.weighted
}

/// 邻居 / Neighbors of vertex.
pub fn neighbors(g : Graph, v : Int) -> Array[Int] {
  ga_neighbors_internal(g, v)
}

/// 度 / Degree of vertex.
pub fn degree(g : Graph, v : Int) -> Int {
  ga_neighbors_internal(g, v).length()
}

/// 入度 / In-degree of vertex.
pub fn in_degree(g : Graph, v : Int) -> Int {
  let mut count = 0
  for i in 0..<g.edges.length() {
    let (_, b, _) = g.edges[i]
    if b == v {
      count = count + 1
    }
  }
  count
}

/// 出度 / Out-degree of vertex.
pub fn out_degree(g : Graph, v : Int) -> Int {
  let mut count = 0
  for i in 0..<g.edges.length() {
    let (a, _, _) = g.edges[i]
    if a == v {
      count = count + 1
    }
  }
  count
}

// ============================================================
// 遍历 / Traversal
// ============================================================

/// 广度优先搜索 / BFS traversal.
pub fn bfs(g : Graph, start : Int) -> Array[Int] {
  ga_bfs_reachable(g, start)
}

/// 深度优先搜索 / DFS traversal.
pub fn dfs(g : Graph, start : Int) -> Array[Int] {
  let result : Array[Int] = []
  let visited : Array[Int] = []
  let stack : Array[Int] = [start]
  while stack.length() > 0 {
    let v = stack.remove(stack.length() - 1)
    if ga_contains_int(visited, v) {
      continue
    }
    visited.push(v)
    result.push(v)
    let nbrs = ga_neighbors_internal(g, v)
    for i in 0..<nbrs.length() {
      if !ga_contains_int(visited, nbrs[i]) {
        stack.push(nbrs[i])
      }
    }
  }
  result
}

/// 最短路径 / Shortest path (BFS for unweighted, Dijkstra for weighted).
pub fn shortest_path(g : Graph, start : Int, end : Int) -> Array[Int] {
  if start == end {
    return [start]
  }
  let n = g.vertices.length()
  let dist : Array[Int] = []
  let prev : Array[Int] = []
  for i in 0..<n {
    dist.push(-1)
    prev.push(-1)
  }
  let idx_of : Array[(Int, Int)] = []
  for i in 0..<n {
    idx_of.push((g.vertices[i], i))
  }
  let mut start_idx = -1
  let mut end_idx = -1
  for i in 0..<n {
    if g.vertices[i] == start {
      start_idx = i
    }
    if g.vertices[i] == end {
      end_idx = i
    }
  }
  if start_idx < 0 || end_idx < 0 {
    return []
  }
  dist[start_idx] = 0
  let queue : Array[Int] = [start_idx]
  let mut head = 0
  while head < queue.length() {
    let u_idx = queue[head]
    head = head + 1
    let u = g.vertices[u_idx]
    let nbrs = ga_neighbors_internal(g, u)
    for i in 0..<nbrs.length() {
      let v = nbrs[i]
      let mut v_idx = -1
      for j in 0..<n {
        if g.vertices[j] == v {
          v_idx = j
          break
        }
      }
      if v_idx >= 0 && dist[v_idx] == -1 {
        dist[v_idx] = dist[u_idx] + 1
        prev[v_idx] = u_idx
        queue.push(v_idx)
      }
    }
  }
  if dist[end_idx] == -1 {
    return []
  }
  let path : Array[Int] = []
  let mut curr = end_idx
  while curr != -1 {
    path.insert(0, g.vertices[curr])
    curr = prev[curr]
  }
  path
}

/// 所有路径 / All paths from start to end (limited).
pub fn all_paths(g : Graph, start : Int, end : Int) -> Array[Array[Int]] {
  let result : Array[Array[Int]] = []
  let visited : Array[Int] = []
  let path : Array[Int] = [start]
  ga_find_paths(g, start, end, visited, path, result)
  result
}

fn ga_find_paths(
  g : Graph,
  current : Int,
  end : Int,
  visited : Array[Int],
  path : Array[Int],
  result : Array[Array[Int]]
) -> Unit {
  if current == end {
    let saved : Array[Int] = []
    for i in 0..<path.length() {
      saved.push(path[i])
    }
    result.push(saved)
    return
  }
  visited.push(current)
  let nbrs = ga_neighbors_internal(g, current)
  for i in 0..<nbrs.length() {
    let v = nbrs[i]
    if !ga_contains_int(visited, v) {
      path.push(v)
      ga_find_paths(g, v, end, visited, path, result)
      path.remove(path.length() - 1)
    }
  }
  let mut idx = -1
  for i in 0..<visited.length() {
    if visited[i] == current {
      idx = i
      break
    }
  }
  if idx >= 0 {
    visited.remove(idx)
  }
}

// ============================================================
// 连通性 / Connectivity
// ============================================================

/// 连通分量 / Connected components.
pub fn connected_components(g : Graph) -> Array[Array[Int]] {
  let result : Array[Array[Int]] = []
  let visited : Array[Int] = []
  for i in 0..<g.vertices.length() {
    let v = g.vertices[i]
    if !ga_contains_int(visited, v) {
      let comp = ga_bfs_reachable(g, v)
      for j in 0..<comp.length() {
        visited.push(comp[j])
      }
      result.push(comp)
    }
  }
  result
}

/// 强连通分量 / Strongly connected components (simplified).
pub fn strongly_connected_components(g : Graph) -> Array[Array[Int]] {
  if !g.directed {
    return connected_components(g)
  }
  let result : Array[Array[Int]] = []
  let assigned : Array[Int] = []
  for i in 0..<g.vertices.length() {
    let v = g.vertices[i]
    if !ga_contains_int(assigned, v) {
      let reachable = ga_bfs_reachable(g, v)
      let scc : Array[Int] = []
      for j in 0..<reachable.length() {
        let u = reachable[j]
        let back = ga_bfs_reachable(g, u)
        if ga_contains_int(back, v) {
          scc.push(u)
          assigned.push(u)
        }
      }
      if scc.length() > 0 {
        result.push(scc)
      }
    }
  }
  result
}

/// 是否连通 / Is connected graph.
pub fn is_connected(g : Graph) -> Bool {
  if g.vertices.length() == 0 {
    return true
  }
  let comp = ga_bfs_reachable(g, g.vertices[0])
  comp.length() == g.vertices.length()
}

/// 是否无环 / Is acyclic (DFS-based).
pub fn is_acyclic(g : Graph) -> Bool {
  !has_cycle(g)
}

/// 是否有环 / Has cycle (DFS-based).
pub fn has_cycle(g : Graph) -> Bool {
  let visited : Array[Int] = []
  let rec_stack : Array[Int] = []
  for i in 0..<g.vertices.length() {
    let v = g.vertices[i]
    if !ga_contains_int(visited, v) {
      if ga_dfs_cycle(g, v, -1, visited, rec_stack) {
        return true
      }
    }
  }
  false
}

fn ga_dfs_cycle(
  g : Graph,
  v : Int,
  parent : Int,
  visited : Array[Int],
  rec_stack : Array[Int]
) -> Bool {
  visited.push(v)
  rec_stack.push(v)
  let nbrs = ga_neighbors_internal(g, v)
  for i in 0..<nbrs.length() {
    let u = nbrs[i]
    if !ga_contains_int(visited, u) {
      if ga_dfs_cycle(g, u, v, visited, rec_stack) {
        return true
      }
    } else if g.directed && ga_contains_int(rec_stack, u) {
      return true
    } else if !g.directed && u != parent {
      return true
    }
  }
  let mut idx = -1
  for i in 0..<rec_stack.length() {
    if rec_stack[i] == v {
      idx = i
      break
    }
  }
  if idx >= 0 {
    rec_stack.remove(idx)
  }
  false
}

// ============================================================
// DAG / Directed acyclic graph
// ============================================================

/// 拓扑排序 / Topological sort (Kahn's algorithm).
pub fn topological_sort_dag(g : Graph) -> Array[Int] {
  let n = g.vertices.length()
  let in_deg : Array[(Int, Int)] = []
  for i in 0..<n {
    in_deg.push((g.vertices[i], in_degree(g, g.vertices[i])))
  }
  let result : Array[Int] = []
  let queue : Array[Int] = []
  for i in 0..<n {
    if in_deg[i].1 == 0 {
      queue.push(in_deg[i].0)
    }
  }
  while queue.length() > 0 {
    let v = queue.remove(0)
    result.push(v)
    let nbrs = ga_neighbors_internal(g, v)
    for i in 0..<nbrs.length() {
      let u = nbrs[i]
      for j in 0..<in_deg.length() {
        if in_deg[j].0 == u {
          let d = in_deg[j].1
          in_deg[j] = (u, d - 1)
          if d - 1 == 0 {
            queue.push(u)
          }
          break
        }
      }
    }
  }
  result
}

/// DAG 最长路径 / Longest path in DAG.
pub fn longest_path_dag(g : Graph, start : Int, end : Int) -> Int {
  let topo = topological_sort_dag(g)
  let n = g.vertices.length()
  let dist : Array[(Int, Int)] = []
  for i in 0..<n {
    let init = if g.vertices[i] == start { 0 } else { -1 }
    dist.push((g.vertices[i], init))
  }
  for i in 0..<topo.length() {
    let v = topo[i]
    let mut v_dist = -1
    for j in 0..<n {
      if dist[j].0 == v {
        v_dist = dist[j].1
        break
      }
    }
    if v_dist < 0 {
      continue
    }
    let nbrs = ga_neighbors_internal(g, v)
    for j in 0..<nbrs.length() {
      let u = nbrs[j]
      for kk in 0..<n {
        if dist[kk].0 == u {
          if v_dist + 1 > dist[kk].1 {
            dist[kk] = (u, v_dist + 1)
          }
          break
        }
      }
    }
  }
  for i in 0..<n {
    if dist[i].0 == end {
      return dist[i].1
    }
  }
  -1
}

// ============================================================
// 中心性 / Centrality
// ============================================================

/// PageRank / PageRank centrality.
pub fn pagerank(g : Graph, iterations : Int, damping : Double) -> Array[Double] {
  let n = g.vertices.length()
  let result : Array[Double] = []
  if n == 0 {
    return result
  }
  for i in 0..<n {
    result.push(1.0 / n.to_double())
  }
  for _ in 0..<iterations {
    let new_pr : Array[Double] = []
    for i in 0..<n {
      new_pr.push((1.0 - damping) / n.to_double())
    }
    for i in 0..<n {
      let v = g.vertices[i]
      let out = out_degree(g, v)
      if out > 0 {
        let share = damping * result[i] / out.to_double()
        let nbrs = ga_neighbors_internal(g, v)
        for j in 0..<nbrs.length() {
          let mut u_idx = -1
          for kk in 0..<n {
            if g.vertices[kk] == nbrs[j] {
              u_idx = kk
              break
            }
          }
          if u_idx >= 0 {
            new_pr[u_idx] = new_pr[u_idx] + share
          }
        }
      }
    }
    for i in 0..<n {
      result[i] = new_pr[i]
    }
  }
  result
}

/// 度中心性 / Degree centrality.
pub fn centrality_degree(g : Graph) -> Array[Double] {
  let n = g.vertices.length()
  let result : Array[Double] = []
  if n == 0 {
    return result
  }
  for i in 0..<n {
    result.push(degree(g, g.vertices[i]).to_double() / (n - 1).to_double())
  }
  result
}

/// 介数中心性 / Betweenness centrality (simplified).
pub fn centrality_betweenness(g : Graph) -> Array[Double] {
  let n = g.vertices.length()
  let result : Array[Double] = []
  for i in 0..<n {
    result.push(0.0)
  }
  for s in 0..<n {
    for t in 0..<n {
      if s == t {
        continue
      }
      let path = shortest_path(g, g.vertices[s], g.vertices[t])
      for j in 1..<path.length() - 1 {
        let v = path[j]
        for kk in 0..<n {
          if g.vertices[kk] == v {
            result[kk] = result[kk] + 1.0
            break
          }
        }
      }
    }
  }
  result
}

/// 接近中心性 / Closeness centrality.
pub fn centrality_closeness(g : Graph) -> Array[Double] {
  let n = g.vertices.length()
  let result : Array[Double] = []
  for i in 0..<n {
    let v = g.vertices[i]
    let reachable = ga_bfs_reachable(g, v)
    let mut total_dist = 0
    for j in 0..<reachable.length() {
      let path = shortest_path(g, v, reachable[j])
      total_dist = total_dist + path.length() - 1
    }
    if total_dist == 0 {
      result.push(0.0)
    } else {
      result.push((reachable.length() - 1).to_double() / total_dist.to_double())
    }
  }
  result
}

/// 特征向量中心性 / Eigenvector centrality (power iteration).
pub fn centrality_eigenvector(g : Graph, iterations : Int) -> Array[Double] {
  let n = g.vertices.length()
  let result : Array[Double] = []
  if n == 0 {
    return result
  }
  for i in 0..<n {
    result.push(1.0)
  }
  for _ in 0..<iterations {
    let new_val : Array[Double] = []
    for i in 0..<n {
      new_val.push(0.0)
    }
    for i in 0..<n {
      let v = g.vertices[i]
      let nbrs = ga_neighbors_internal(g, v)
      for j in 0..<nbrs.length() {
        let mut u_idx = -1
        for kk in 0..<n {
          if g.vertices[kk] == nbrs[j] {
            u_idx = kk
            break
          }
        }
        if u_idx >= 0 {
          new_val[i] = new_val[i] + result[u_idx]
        }
      }
    }
    let mut norm = 0.0
    for i in 0..<n {
      norm = norm + new_val[i] * new_val[i]
    }
    norm = ga_sqrt(norm)
    if norm > 0.0 {
      for i in 0..<n {
        result[i] = new_val[i] / norm
      }
    }
  }
  result
}

/// 调和中心性 / Harmonic centrality.
pub fn centrality_harmonic(g : Graph) -> Array[Double] {
  let n = g.vertices.length()
  let result : Array[Double] = []
  for i in 0..<n {
    let v = g.vertices[i]
    let reachable = ga_bfs_reachable(g, v)
    let mut sum = 0.0
    for j in 0..<reachable.length() {
      let path = shortest_path(g, v, reachable[j])
      let d = path.length() - 1
      if d > 0 {
        sum = sum + 1.0 / d.to_double()
      }
    }
    result.push(sum)
  }
  result
}

// ============================================================
// 社区检测 / Community detection
// ============================================================

/// 社区检测 / Community detection (label propagation).
pub fn community_detection(g : Graph) -> Array[Array[Int]] {
  let n = g.vertices.length()
  if n == 0 {
    return []
  }
  let labels : Array[(Int, Int)] = []
  for i in 0..<n {
    labels.push((g.vertices[i], i))
  }
  for _ in 0..<10 {
    for i in 0..<n {
      let v = g.vertices[i]
      let nbrs = ga_neighbors_internal(g, v)
      if nbrs.length() == 0 {
        continue
      }
      let label_counts : Array[(Int, Int)] = []
      for j in 0..<nbrs.length() {
        let u = nbrs[j]
        let mut u_label = -1
        for kk in 0..<n {
          if labels[kk].0 == u {
            u_label = labels[kk].1
            break
          }
        }
        let mut found = false
        for kk in 0..<label_counts.length() {
          if label_counts[kk].0 == u_label {
            let c = label_counts[kk].1
            label_counts[kk] = (u_label, c + 1)
            found = true
            break
          }
        }
        if !found {
          label_counts.push((u_label, 1))
        }
      }
      let mut best_label = labels[i].1
      let mut best_count = 0
      for j in 0..<label_counts.length() {
        if label_counts[j].1 > best_count {
          best_count = label_counts[j].1
          best_label = label_counts[j].0
        }
      }
      labels[i] = (v, best_label)
    }
  }
  let communities : Array[Array[Int]] = []
  for i in 0..<n {
    let v = g.vertices[i]
    let label = labels[i].1
    let mut found = false
    for j in 0..<communities.length() {
      if j == label && communities[j].length() >= 0 {
        communities[j].push(v)
        found = true
        break
      }
    }
    if !found {
      let comp : Array[Int] = [v]
      communities.push(comp)
    }
  }
  communities
}

/// 模块度 / Modularity of partition.
pub fn modularity(g : Graph, communities : Array[Array[Int]]) -> Double {
  let m = g.edges.length().to_double()
  if m == 0.0 {
    return 0.0
  }
  let n = g.vertices.length()
  let comm_of : Array[(Int, Int)] = []
  for i in 0..<communities.length() {
    for j in 0..<communities[i].length() {
      comm_of.push((communities[i][j], i))
    }
  }
  let mut q = 0.0
  for i in 0..<n {
    for j in 0..<n {
      let vi = g.vertices[i]
      let vj = g.vertices[j]
      let mut ci = -1
      let mut cj = -1
      for kk in 0..<comm_of.length() {
        if comm_of[kk].0 == vi {
          ci = comm_of[kk].1
        }
        if comm_of[kk].0 == vj {
          cj = comm_of[kk].1
        }
      }
      if ci == cj {
        let a_ij = if ga_has_edge(g, vi, vj) { 1.0 } else { 0.0 }
        let ki = degree(g, vi).to_double()
        let kj = degree(g, vj).to_double()
        q = q + (a_ij - ki * kj / (2.0 * m))
      }
    }
  }
  q / (2.0 * m)
}

/// Louvain 方法 / Louvain method (simplified).
pub fn louvain_method(g : Graph) -> Array[Array[Int]] {
  community_detection(g)
}

// ============================================================
// 图算法 / Graph algorithms
// ============================================================

/// 最小生成树 / Minimum spanning tree (Kruskal's).
pub fn minimum_spanning_tree(g : Graph) -> Array[(Int, Int, Double)] {
  let sorted_edges : Array[(Int, Int, Double)] = []
  for i in 0..<g.edges.length() {
    sorted_edges.push(g.edges[i])
  }
  sorted_edges.sort_by(fn(a, b) {
    if a.2 < b.2 {
      -1
    } else if a.2 > b.2 {
      1
    } else {
      0
    }
  })
  let parent : Array[(Int, Int)] = []
  for i in 0..<g.vertices.length() {
    parent.push((g.vertices[i], g.vertices[i]))
  }
  let result : Array[(Int, Int, Double)] = []
  for i in 0..<sorted_edges.length() {
    let (u, v, w) = sorted_edges[i]
    let mut root_u = u
    let mut root_v = v
    for j in 0..<parent.length() {
      if parent[j].0 == root_u {
        root_u = parent[j].1
      }
      if parent[j].0 == root_v {
        root_v = parent[j].1
      }
    }
    if root_u != root_v {
      result.push((u, v, w))
      for j in 0..<parent.length() {
        if parent[j].0 == root_v {
          parent[j] = (root_v, root_u)
        }
      }
    }
  }
  result
}

/// 最大流 / Maximum flow (Ford-Fulkerson, simplified).
pub fn maximum_flow(g : Graph, source : Int, sink : Int) -> Double {
  let mut flow = 0.0
  let residual = ga_copy_edges(g)
  let mut iter_count = 0
  while iter_count < 100 {
    iter_count = iter_count + 1
    let visited : Array[Int] = [source]
    let path : Array[Int] = [source]
    let mut found = ga_find_augmenting_path(g, residual, source, sink, visited, path)
    if !found {
      break
    }
    let mut min_cap = GA_LARGE_DOUBLE
    for i in 0..<path.length() - 1 {
      let u = path[i]
      let v = path[i + 1]
      for j in 0..<residual.length() {
        let (a, b, w) = residual[j]
        if a == u && b == v {
          if w < min_cap {
            min_cap = w
          }
          break
        }
      }
    }
    if min_cap <= 0.0 {
      break
    }
    flow = flow + min_cap
    for i in 0..<path.length() - 1 {
      let u = path[i]
      let v = path[i + 1]
      for j in 0..<residual.length() {
        let (a, b, w) = residual[j]
        if a == u && b == v {
          residual[j] = (a, b, w - min_cap)
          break
        }
      }
    }
  }
  flow
}

fn ga_find_augmenting_path(
  g : Graph,
  residual : Array[(Int, Int, Double)],
  current : Int,
  sink : Int,
  visited : Array[Int],
  path : Array[Int]
) -> Bool {
  if current == sink {
    return true
  }
  for i in 0..<residual.length() {
    let (a, b, w) = residual[i]
    if a == current && w > 0.0 && !ga_contains_int(visited, b) {
      visited.push(b)
      path.push(b)
      if ga_find_augmenting_path(g, residual, b, sink, visited, path) {
        return true
      }
      path.remove(path.length() - 1)
    }
  }
  false
}

/// 最小割 / Min cut (max-flow min-cut theorem).
pub fn min_cut(g : Graph, source : Int, sink : Int) -> Double {
  maximum_flow(g, source, sink)
}

// ============================================================
// 图度量 / Graph metrics
// ============================================================

/// 图直径 / Graph diameter.
pub fn graph_diameter(g : Graph) -> Int {
  let mut max_dist = 0
  for i in 0..<g.vertices.length() {
    let ecc = graph_eccentricity(g, g.vertices[i])
    if ecc > max_dist {
      max_dist = ecc
    }
  }
  max_dist
}

/// 图半径 / Graph radius.
pub fn graph_radius(g : Graph) -> Int {
  if g.vertices.length() == 0 {
    return 0
  }
  let mut min_dist = graph_eccentricity(g, g.vertices[0])
  for i in 1..<g.vertices.length() {
    let ecc = graph_eccentricity(g, g.vertices[i])
    if ecc < min_dist {
      min_dist = ecc
    }
  }
  min_dist
}

/// 离心率 / Eccentricity of vertex.
pub fn graph_eccentricity(g : Graph, v : Int) -> Int {
  let reachable = ga_bfs_reachable(g, v)
  let mut max_dist = 0
  for i in 0..<reachable.length() {
    let path = shortest_path(g, v, reachable[i])
    let d = path.length() - 1
    if d > max_dist {
      max_dist = d
    }
  }
  max_dist
}

// ============================================================
// 团与独立集 / Cliques and independent sets
// ============================================================

/// 极大团 / Maximal clique (greedy).
pub fn clique_maximal(g : Graph) -> Array[Int] {
  if g.vertices.length() == 0 {
    return []
  }
  let clique : Array[Int] = [g.vertices[0]]
  for i in 1..<g.vertices.length() {
    let v = g.vertices[i]
    let mut connected_to_all = true
    for j in 0..<clique.length() {
      if !ga_has_edge(g, v, clique[j]) {
        connected_to_all = false
        break
      }
    }
    if connected_to_all {
      clique.push(v)
    }
  }
  clique
}

/// 最大团 / Maximum clique (simplified).
pub fn clique_maximum(g : Graph) -> Array[Int] {
  clique_maximal(g)
}

/// 独立集 / Independent set (greedy).
pub fn independent_set(g : Graph) -> Array[Int] {
  let result : Array[Int] = []
  for i in 0..<g.vertices.length() {
    let v = g.vertices[i]
    let mut independent = true
    for j in 0..<result.length() {
      if ga_has_edge(g, v, result[j]) {
        independent = false
        break
      }
    }
    if independent {
      result.push(v)
    }
  }
  result
}

// ============================================================
// 着色 / Graph coloring
// ============================================================

/// 图着色 / Graph coloring (greedy).
pub fn graph_coloring(g : Graph) -> Array[(Int, Int)] {
  let result : Array[(Int, Int)] = []
  for i in 0..<g.vertices.length() {
    let v = g.vertices[i]
    let used_colors : Array[Int] = []
    let nbrs = ga_neighbors_internal(g, v)
    for j in 0..<nbrs.length() {
      for kk in 0..<result.length() {
        if result[kk].0 == nbrs[j] {
          if !ga_contains_int(used_colors, result[kk].1) {
            used_colors.push(result[kk].1)
          }
          break
        }
      }
    }
    let mut color = 0
    while ga_contains_int(used_colors, color) {
      color = color + 1
    }
    result.push((v, color))
  }
  result
}

/// 色数 / Chromatic number.
pub fn chromatic_number(g : Graph) -> Int {
  let coloring = graph_coloring(g)
  let mut max_color = 0
  for i in 0..<coloring.length() {
    if coloring[i].1 > max_color {
      max_color = coloring[i].1
    }
  }
  max_color + 1
}

// ============================================================
// 图运算 / Graph operations
// ============================================================

/// 图并 / Graph union.
pub fn graph_union(g1 : Graph, g2 : Graph) -> Graph {
  let directed = g1.directed || g2.directed
  let weighted = g1.weighted || g2.weighted
  let vertices : Array[Int] = []
  for i in 0..<g1.vertices.length() {
    if !ga_contains_int(vertices, g1.vertices[i]) {
      vertices.push(g1.vertices[i])
    }
  }
  for i in 0..<g2.vertices.length() {
    if !ga_contains_int(vertices, g2.vertices[i]) {
      vertices.push(g2.vertices[i])
    }
  }
  let edges : Array[(Int, Int, Double)] = []
  for i in 0..<g1.edges.length() {
    edges.push(g1.edges[i])
  }
  for i in 0..<g2.edges.length() {
    edges.push(g2.edges[i])
  }
  { directed, weighted, vertices, edges }
}

/// 图交 / Graph intersection.
pub fn graph_intersection(g1 : Graph, g2 : Graph) -> Graph {
  let vertices : Array[Int] = []
  for i in 0..<g1.vertices.length() {
    if ga_has_vertex(g2, g1.vertices[i]) {
      vertices.push(g1.vertices[i])
    }
  }
  let edges : Array[(Int, Int, Double)] = []
  for i in 0..<g1.edges.length() {
    let (a, b, w) = g1.edges[i]
    if ga_has_edge(g2, a, b) {
      edges.push((a, b, w))
    }
  }
  { directed: g1.directed, weighted: g1.weighted, vertices, edges }
}

/// 图差 / Graph difference.
pub fn graph_difference(g1 : Graph, g2 : Graph) -> Graph {
  let vertices : Array[Int] = []
  for i in 0..<g1.vertices.length() {
    if !ga_has_vertex(g2, g1.vertices[i]) {
      vertices.push(g1.vertices[i])
    }
  }
  let edges : Array[(Int, Int, Double)] = []
  for i in 0..<g1.edges.length() {
    let (a, b, w) = g1.edges[i]
    if !ga_has_edge(g2, a, b) {
      edges.push((a, b, w))
    }
  }
  { directed: g1.directed, weighted: g1.weighted, vertices, edges }
}

/// 图补 / Graph complement.
pub fn graph_complement(g : Graph) -> Graph {
  let edges : Array[(Int, Int, Double)] = []
  for i in 0..<g.vertices.length() {
    for j in 0..<g.vertices.length() {
      if i != j {
        let u = g.vertices[i]
        let v = g.vertices[j]
        if !ga_has_edge(g, u, v) {
          edges.push((u, v, 1.0))
        }
      }
    }
  }
  { directed: g.directed, weighted: g.weighted, vertices: ga_copy_vertices(g), edges }
}

/// 图反转 / Graph reverse (reverse all edges).
pub fn graph_reverse(g : Graph) -> Graph {
  let edges : Array[(Int, Int, Double)] = []
  for i in 0..<g.edges.length() {
    let (a, b, w) = g.edges[i]
    edges.push((b, a, w))
  }
  { directed: g.directed, weighted: g.weighted, vertices: ga_copy_vertices(g), edges }
}

/// 图幂 / Graph power (k-th power).
pub fn graph_power(g : Graph, k : Int) -> Graph {
  if k <= 0 {
    return { directed: g.directed, weighted: g.weighted, vertices: ga_copy_vertices(g), edges: [] }
  }
  if k == 1 {
    return g
  }
  let edges : Array[(Int, Int, Double)] = []
  for i in 0..<g.vertices.length() {
    for j in 0..<g.vertices.length() {
      if i != j {
        let u = g.vertices[i]
        let v = g.vertices[j]
        let path = shortest_path(g, u, v)
        if path.length() > 0 && path.length() - 1 <= k {
          let mut found = false
          for e in 0..<edges.length() {
            if edges[e].0 == u && edges[e].1 == v {
              found = true
              break
            }
          }
          if !found {
            edges.push((u, v, 1.0))
          }
        }
      }
    }
  }
  { directed: g.directed, weighted: g.weighted, vertices: ga_copy_vertices(g), edges }
}

// ============================================================
// 子图与同构 / Subgraph and isomorphism
// ============================================================

/// 是否子图 / Is g1 a subgraph of g2.
pub fn is_subgraph(g1 : Graph, g2 : Graph) -> Bool {
  for i in 0..<g1.vertices.length() {
    if !ga_has_vertex(g2, g1.vertices[i]) {
      return false
    }
  }
  for i in 0..<g1.edges.length() {
    let (a, b, _) = g1.edges[i]
    if !ga_has_edge(g2, a, b) {
      return false
    }
  }
  true
}

/// 简单同构检测 / Simple isomorphism check (vertex/edge count).
pub fn is_isomorphic_simple(g1 : Graph, g2 : Graph) -> Bool {
  if g1.vertices.length() != g2.vertices.length() {
    return false
  }
  if g1.edges.length() != g2.edges.length() {
    return false
  }
  let deg1 : Array[Int] = []
  for i in 0..<g1.vertices.length() {
    deg1.push(degree(g1, g1.vertices[i]))
  }
  let deg2 : Array[Int] = []
  for i in 0..<g2.vertices.length() {
    deg2.push(degree(g2, g2.vertices[i]))
  }
  deg1.sort_by(fn(a, b) { a - b })
  deg2.sort_by(fn(a, b) { a - b })
  for i in 0..<deg1.length() {
    if deg1[i] != deg2[i] {
      return false
    }
  }
  true
}

// ============================================================
// 矩阵 / Matrix representations
// ============================================================

/// 邻接矩阵 / Adjacency matrix.
pub fn adjacency_matrix(g : Graph) -> Array[Array[Double]] {
  let n = g.vertices.length()
  let result : Array[Array[Double]] = []
  for i in 0..<n {
    let row : Array[Double] = []
    for j in 0..<n {
      row.push(0.0)
    }
    result.push(row)
  }
  for e in 0..<g.edges.length() {
    let (a, b, w) = g.edges[e]
    let mut ai = -1
    let mut bi = -1
    for v in 0..<n {
      if g.vertices[v] == a {
        ai = v
      }
      if g.vertices[v] == b {
        bi = v
      }
    }
    if ai >= 0 && bi >= 0 {
      result[ai][bi] = w
      if !g.directed {
        result[bi][ai] = w
      }
    }
  }
  result
}

/// 关联矩阵 / Incidence matrix.
pub fn incidence_matrix(g : Graph) -> Array[Array[Int]] {
  let n = g.vertices.length()
  let m = g.edges.length()
  let result : Array[Array[Int]] = []
  for i in 0..<n {
    let row : Array[Int] = []
    for j in 0..<m {
      row.push(0)
    }
    result.push(row)
  }
  for e in 0..<m {
    let (a, b, _) = g.edges[e]
    let mut ai = -1
    let mut bi = -1
    for v in 0..<n {
      if g.vertices[v] == a {
        ai = v
      }
      if g.vertices[v] == b {
        bi = v
      }
    }
    if ai >= 0 && bi >= 0 {
      result[ai][e] = 1
      result[bi][e] = if g.directed { -1 } else { 1 }
    }
  }
  result
}

/// 拉普拉斯矩阵 / Laplacian matrix.
pub fn laplacian_matrix(g : Graph) -> Array[Array[Double]] {
  let n = g.vertices.length()
  let adj = adjacency_matrix(g)
  let result : Array[Array[Double]] = []
  for i in 0..<n {
    let row : Array[Double] = []
    for j in 0..<n {
      if i == j {
        let mut deg = 0.0
        for kk in 0..<n {
          deg = deg + adj[i][kk]
        }
        row.push(deg)
      } else {
        row.push(-adj[i][j])
      }
    }
    result.push(row)
  }
  result
}

// ============================================================
// ID
// ============================================================

/// 模块标识 / Module identifier.
pub fn graph_analytics_id() -> String {
  "opcore/graph_analytics"
}
'''

path = r"D:\CodeWorkspace\forHackathon2026_moonbit\DataVerse\src\opcore\graph_analytics\graph_analytics.mbt"
with open(path, "w", encoding="utf-8") as f:
    f.write(content)
print(f"Written {len(content)} chars, {content.count(chr(10))} lines to {path}")