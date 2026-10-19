///|
/// # dataobject/data_lineage 数据血缘 / Data Lineage
///
/// 数据血缘图谱、数据资产、变换、管道、列级血缘、表级血缘、
/// 版本化资产、血缘事件、数据目录、数据字典、元数据管理。
///
/// # Data lineage graph

///===
/// 内部辅助 / Internal helpers

fn dl_max(a : Int, b : Int) -> Int {
  if a > b { a } else { b }
}

fn dl_min(a : Int, b : Int) -> Int {
  if a < b { a } else { b }
}

fn dl_contains(arr : Array[String], v : String) -> Bool {
  for i in 0..<arr.length() {
    if arr[i] == v {
      return true
    }
  }
  false
}

fn dl_index_of(arr : Array[String], v : String) -> Int {
  for i in 0..<arr.length() {
    if arr[i] == v {
      return i
    }
  }
  -1
}

fn dl_join(arr : Array[String], sep : String) -> String {
  let n = arr.length()
  if n == 0 {
    return ""
  }
  let mut result = arr[0]
  for i in 1..<n {
    result = result + sep + arr[i]
  }
  result
}

///===
/// LineageGraph / 血缘图

pub struct LineageNode {
  id : String
  name : String
  node_type : String
} derive(Debug, Eq)

pub extend LineageNode with Eq::{equal, not_equal}
pub extend LineageNode with Debug::{to_repr}

pub struct LineageEdge {
  source : String
  target : String
  edge_type : String
} derive(Debug, Eq)

pub extend LineageEdge with Eq::{equal, not_equal}
pub extend LineageEdge with Debug::{to_repr}

pub struct LineageGraph {
  nodes : Array[LineageNode]
  edges : Array[LineageEdge]
} derive(Debug, Eq)

pub extend LineageGraph with Eq::{equal, not_equal}
pub extend LineageGraph with Debug::{to_repr}

/// 构造血缘图 / Build a lineage graph.
pub fn make_lineage_graph() -> LineageGraph {
  { nodes: [], edges: [] }
}

/// 添加血缘节点 / Add a lineage node.
pub fn add_lineage_node(graph : LineageGraph, node : LineageNode) -> LineageGraph {
  { nodes: graph.nodes + [node], edges: graph.edges }
}

/// 添加血缘边 / Add a lineage edge.
pub fn add_lineage_edge(graph : LineageGraph, edge : LineageEdge) -> LineageGraph {
  { nodes: graph.nodes, edges: graph.edges + [edge] }
}

///===
/// DataAsset / 数据资产

pub struct DataAsset {
  id : String
  name : String
  asset_type : String
  metadata : Array[(String, String)]
  content_hash : String
} derive(Debug, Eq)

pub extend DataAsset with Eq::{equal, not_equal}
pub extend DataAsset with Debug::{to_repr}

/// 构造数据资产 / Build a data asset.
pub fn make_data_asset(
  id : String,
  name : String,
  asset_type : String
) -> DataAsset {
  { id, name, asset_type, metadata: [], content_hash: "hash:" + id }
}

/// 资产元数据 / Get asset metadata.
pub fn asset_metadata(asset : DataAsset) -> Array[(String, String)] {
  asset.metadata
}

/// 资产哈希 / Get asset hash.
pub fn asset_hash(asset : DataAsset) -> String {
  asset.content_hash
}

///===
/// Transformation / 变换

pub struct Transformation {
  id : String
  name : String
  inputs : Array[String]
  outputs : Array[String]
  transform_type : String
} derive(Debug, Eq)

pub extend Transformation with Eq::{equal, not_equal}
pub extend Transformation with Debug::{to_repr}

/// 构造变换 / Build a transformation.
pub fn make_transformation(
  id : String,
  name : String,
  transform_type : String
) -> Transformation {
  { id, name, inputs: [], outputs: [], transform_type }
}

/// 变换输入 / Get transformation inputs.
pub fn transformation_input(t : Transformation) -> Array[String] {
  t.inputs
}

/// 变换输出 / Get transformation outputs.
pub fn transformation_output(t : Transformation) -> Array[String] {
  t.outputs
}

///===
/// PipelineLineage / 管道血缘

pub struct PipelineLineage {
  pipeline_id : String
  transformations : Array[Transformation]
  audit_log : Array[String]
} derive(Debug, Eq)

pub extend PipelineLineage with Eq::{equal, not_equal}
pub extend PipelineLineage with Debug::{to_repr}

/// 构造管道血缘 / Build a pipeline lineage.
pub fn make_pipeline_lineage(pipeline_id : String) -> PipelineLineage {
  { pipeline_id, transformations: [], audit_log: [] }
}

/// 管道跟踪 / Track pipeline transformation.
pub fn pipeline_track(
  pipeline : PipelineLineage,
  transform : Transformation
) -> PipelineLineage {
  {
    pipeline_id: pipeline.pipeline_id,
    transformations: pipeline.transformations + [transform],
    audit_log: pipeline.audit_log + ["track:" + transform.id],
  }
}

/// 管道审计 / Audit pipeline.
pub fn pipeline_audit(pipeline : PipelineLineage) -> Array[String] {
  pipeline.audit_log
}

///===
/// LineageGraph 查询 / Lineage graph queries

/// 血缘追踪 / Trace lineage between two nodes.
pub fn lineage_trace(
  graph : LineageGraph,
  source : String,
  target : String
) -> Array[String] {
  let path : Array[String] = []
  let visited : Array[String] = []
  let mut current = source
  path.push(current)
  visited.push(current)
  let mut found = current == target
  while not(found) {
    let mut next = ""
    let mut has_next = false
    for i in 0..<graph.edges.length() {
      if graph.edges[i].source == current && not(dl_contains(visited, graph.edges[i].target)) {
        next = graph.edges[i].target
        has_next = true
        break
      }
    }
    if not(has_next) {
      return []
    }
    current = next
    path.push(current)
    visited.push(current)
    if current == target {
      found = true
    }
  }
  path
}

/// 上游血缘 / Get upstream lineage.
pub fn lineage_upstream(graph : LineageGraph, node_id : String) -> Array[String] {
  let result : Array[String] = []
  for i in 0..<graph.edges.length() {
    if graph.edges[i].target == node_id && not(dl_contains(result, graph.edges[i].source)) {
      result.push(graph.edges[i].source)
    }
  }
  result
}

/// 下游血缘 / Get downstream lineage.
pub fn lineage_downstream(graph : LineageGraph, node_id : String) -> Array[String] {
  let result : Array[String] = []
  for i in 0..<graph.edges.length() {
    if graph.edges[i].source == node_id && not(dl_contains(result, graph.edges[i].target)) {
      result.push(graph.edges[i].target)
    }
  }
  result
}

/// 影响分析 / Impact analysis.
pub fn lineage_impact(graph : LineageGraph, node_id : String) -> Array[String] {
  let result : Array[String] = []
  let queue : Array[String] = [node_id]
  let visited : Array[String] = [node_id]
  while queue.length() > 0 {
    let current = queue[0]
    ignore(queue.remove(0))
    let downstream = lineage_downstream(graph, current)
    for i in 0..<downstream.length() {
      if not(dl_contains(visited, downstream[i])) {
        visited.push(downstream[i])
        result.push(downstream[i])
        queue.push(downstream[i])
      }
    }
  }
  result
}

/// 依赖分析 / Dependencies analysis.
pub fn lineage_dependencies(graph : LineageGraph, node_id : String) -> Array[String] {
  let result : Array[String] = []
  let queue : Array[String] = [node_id]
  let visited : Array[String] = [node_id]
  while queue.length() > 0 {
    let current = queue[0]
    ignore(queue.remove(0))
    let upstream = lineage_upstream(graph, current)
    for i in 0..<upstream.length() {
      if not(dl_contains(visited, upstream[i])) {
        visited.push(upstream[i])
        result.push(upstream[i])
        queue.push(upstream[i])
      }
    }
  }
  result
}

/// 依赖者分析 / Dependents analysis.
pub fn lineage_dependents(graph : LineageGraph, node_id : String) -> Array[String] {
  lineage_impact(graph, node_id)
}

///===
/// ColumnLineage / 列级血缘

pub struct ColumnLineage {
  table_name : String
  column_maps : Array[(String, String, String)]
} derive(Debug, Eq)

pub extend ColumnLineage with Eq::{equal, not_equal}
pub extend ColumnLineage with Debug::{to_repr}

/// 构造列级血缘 / Build column lineage.
pub fn make_column_lineage(table_name : String) -> ColumnLineage {
  { table_name, column_maps: [] }
}

/// 列跟踪 / Track column mapping.
pub fn column_track(
  lineage : ColumnLineage,
  source_col : String,
  target_col : String,
  transform : String
) -> ColumnLineage {
  { table_name: lineage.table_name, column_maps: lineage.column_maps + [(source_col, target_col, transform)] }
}

/// 列映射 / Get column mapping.
pub fn column_map(lineage : ColumnLineage, source_col : String) -> Array[(String, String)] {
  let result : Array[(String, String)] = []
  for i in 0..<lineage.column_maps.length() {
    let (src, tgt, tfm) = lineage.column_maps[i]
    if src == source_col {
      result.push((tgt, tfm))
    }
  }
  result
}

///===
/// TableLineage / 表级血缘

pub struct TableLineage {
  table_name : String
  source_tables : Array[String]
  target_tables : Array[String]
} derive(Debug, Eq)

pub extend TableLineage with Eq::{equal, not_equal}
pub extend TableLineage with Debug::{to_repr}

/// 构造表级血缘 / Build table lineage.
pub fn make_table_lineage(table_name : String) -> TableLineage {
  { table_name, source_tables: [], target_tables: [] }
}

/// 表跟踪 / Track table source.
pub fn table_track(
  lineage : TableLineage,
  source : String,
  target : String
) -> TableLineage {
  {
    table_name: lineage.table_name,
    source_tables: lineage.source_tables + [source],
    target_tables: lineage.target_tables + [target],
  }
}

/// 表映射 / Get table mapping.
pub fn table_map(lineage : TableLineage) -> Array[(String, String)] {
  let result : Array[(String, String)] = []
  let n = dl_min(lineage.source_tables.length(), lineage.target_tables.length())
  for i in 0..<n {
    result.push((lineage.source_tables[i], lineage.target_tables[i]))
  }
  result
}

///===
/// LineageGraph 可视化 / Lineage graph visualization

/// 血缘可视化 / Visualize lineage graph as text.
pub fn lineage_visualize(graph : LineageGraph) -> String {
  let mut result = "LineageGraph:\n"
  result = result + "Nodes (" + graph.nodes.length().to_string() + "):\n"
  for i in 0..<graph.nodes.length() {
    result = result + "  " + graph.nodes[i].id + " [" + graph.nodes[i].node_type + "]\n"
  }
  result = result + "Edges (" + graph.edges.length().to_string() + "):\n"
  for i in 0..<graph.edges.length() {
    result = result + "  " + graph.edges[i].source + " -> " + graph.edges[i].target + " [" + graph.edges[i].edge_type + "]\n"
  }
  result
}

/// 血缘导出 / Export lineage graph.
pub fn lineage_export(graph : LineageGraph, format : String) -> String {
  if format == "json" {
    let mut result = "{\"nodes\":["
    for i in 0..<graph.nodes.length() {
      if i > 0 {
        result = result + ","
      }
      result = result + "{\"id\":\"" + graph.nodes[i].id + "\",\"name\":\"" + graph.nodes[i].name + "\"}"
    }
    result = result + "],\"edges\":["
    for i in 0..<graph.edges.length() {
      if i > 0 {
        result = result + ","
      }
      result = result + "{\"source\":\"" + graph.edges[i].source + "\",\"target\":\"" + graph.edges[i].target + "\"}"
    }
    result = result + "]}"
    return result
  }
  lineage_visualize(graph)
}

/// 血缘报告 / Generate lineage report.
pub fn lineage_report(graph : LineageGraph) -> String {
  let mut result = "Lineage Report\n"
  result = result + "==============\n"
  result = result + "Total nodes: " + graph.nodes.length().to_string() + "\n"
  result = result + "Total edges: " + graph.edges.length().to_string() + "\n"
  let type_count : Array[(String, Int)] = []
  for i in 0..<graph.nodes.length() {
    let nt = graph.nodes[i].node_type
    let mut found = false
    for j in 0..<type_count.length() {
      let (t, c) = type_count[j]
      if t == nt {
        type_count[j] = (t, c + 1)
        found = true
        break
      }
    }
    if not(found) {
      type_count.push((nt, 1))
    }
  }
  result = result + "Node types:\n"
  for i in 0..<type_count.length() {
    let (t, c) = type_count[i]
    result = result + "  " + t + ": " + c.to_string() + "\n"
  }
  result
}

///===
/// VersionedAsset / 版本化资产

pub struct VersionedAsset {
  asset : DataAsset
  version : Int
  history : Array[String]
} derive(Debug, Eq)

pub extend VersionedAsset with Eq::{equal, not_equal}
pub extend VersionedAsset with Debug::{to_repr}

/// 构造版本化资产 / Build a versioned asset.
pub fn make_versioned_asset(asset : DataAsset) -> VersionedAsset {
  { asset, version: 1, history: ["v1:" + asset.id] }
}

/// 资产版本 / Get asset version.
pub fn asset_version(va : VersionedAsset) -> Int {
  va.version
}

/// 资产历史 / Get asset history.
pub fn asset_history(va : VersionedAsset) -> Array[String] {
  va.history
}

///===
/// LineageEvent / 血缘事件

pub struct LineageEvent {
  event_id : String
  event_type : String
  timestamp : Double
  payload : String
} derive(Debug, Eq)

pub extend LineageEvent with Eq::{equal, not_equal}
pub extend LineageEvent with Debug::{to_repr}

/// 构造血缘事件 / Build a lineage event.
pub fn make_lineage_event(
  event_id : String,
  event_type : String,
  timestamp : Double,
  payload : String
) -> LineageEvent {
  { event_id, event_type, timestamp, payload }
}

/// 事件跟踪 / Track event.
pub fn event_track(
  events : Array[LineageEvent],
  event : LineageEvent
) -> Array[LineageEvent] {
  events + [event]
}

/// 事件回放血缘 / Replay lineage from events.
pub fn event_replay_lineage(events : Array[LineageEvent]) -> LineageGraph {
  let graph = make_lineage_graph()
  let mut g = graph
  for i in 0..<events.length() {
    if events[i].event_type == "add_node" {
      let node = { id: events[i].event_id, name: events[i].payload, node_type: "event" }
      g = add_lineage_node(g, node)
    }
  }
  g
}

///===
/// LineageGraph 质量评估 / Lineage quality metrics

/// 血缘完整性 / Lineage completeness.
pub fn lineage_completeness(graph : LineageGraph) -> Double {
  let n = graph.nodes.length()
  if n == 0 {
    return 0.0
  }
  let mut connected = 0
  for i in 0..<n {
    let nid = graph.nodes[i].id
    let upstream = lineage_upstream(graph, nid)
    let downstream = lineage_downstream(graph, nid)
    if upstream.length() > 0 || downstream.length() > 0 || n == 1 {
      connected = connected + 1
    }
  }
  connected.to_double() / n.to_double()
}

/// 血缘准确性 / Lineage accuracy.
pub fn lineage_accuracy(graph : LineageGraph) -> Double {
  let n = graph.edges.length()
  if n == 0 {
    return 1.0
  }
  let mut valid = 0
  for i in 0..<n {
    let has_source = dl_index_of(graph.nodes.map(fn(n) { n.id }), graph.edges[i].source) >= 0
    let has_target = dl_index_of(graph.nodes.map(fn(n) { n.id }), graph.edges[i].target) >= 0
    if has_source && has_target {
      valid = valid + 1
    }
  }
  valid.to_double() / n.to_double()
}

/// 血缘校验 / Validate lineage graph.
pub fn lineage_validate(graph : LineageGraph) -> Bool {
  for i in 0..<graph.edges.length() {
    let mut has_source = false
    let mut has_target = false
    for j in 0..<graph.nodes.length() {
      if graph.nodes[j].id == graph.edges[i].source {
        has_source = true
      }
      if graph.nodes[j].id == graph.edges[i].target {
        has_target = true
      }
    }
    if not(has_source) || not(has_target) {
      return false
    }
  }
  true
}

///===
/// DataCatalog / 数据目录

pub struct DataCatalog {
  entries : Array[(String, DataAsset)]
} derive(Debug, Eq)

pub extend DataCatalog with Eq::{equal, not_equal}
pub extend DataCatalog with Debug::{to_repr}

/// 构造数据目录 / Build a data catalog.
pub fn make_data_catalog() -> DataCatalog {
  { entries: [] }
}

/// 目录注册 / Register asset in catalog.
pub fn catalog_register(
  catalog : DataCatalog,
  asset : DataAsset
) -> DataCatalog {
  { entries: catalog.entries + [(asset.id, asset)] }
}

/// 目录搜索 / Search catalog.
pub fn catalog_search(catalog : DataCatalog, query : String) -> Array[DataAsset] {
  let result : Array[DataAsset] = []
  for i in 0..<catalog.entries.length() {
    let (_, asset) = catalog.entries[i]
    if asset.name.contains(query) || asset.asset_type.contains(query) {
      result.push(asset)
    }
  }
  result
}

///===
/// DataDictionary / 数据字典

pub struct DataDictionary {
  entries : Array[(String, String, String)]
} derive(Debug, Eq)

pub extend DataDictionary with Eq::{equal, not_equal}
pub extend DataDictionary with Debug::{to_repr}

/// 构造数据字典 / Build a data dictionary.
pub fn make_data_dictionary() -> DataDictionary {
  { entries: [] }
}

/// 字典添加 / Add dictionary entry.
pub fn dictionary_add(
  dict : DataDictionary,
  term : String,
  definition : String,
  category : String
) -> DataDictionary {
  { entries: dict.entries + [(term, definition, category)] }
}

/// 字典查找 / Lookup dictionary.
pub fn dictionary_lookup(dict : DataDictionary, term : String) -> String {
  for i in 0..<dict.entries.length() {
    let (t, def, _) = dict.entries[i]
    if t == term {
      return def
    }
  }
  ""
}

///===
/// Metadata / 元数据

pub struct Metadata {
  fields : Array[(String, String)]
} derive(Debug, Eq)

pub extend Metadata with Eq::{equal, not_equal}
pub extend Metadata with Debug::{to_repr}

/// 构造元数据 / Build metadata.
pub fn make_metadata() -> Metadata {
  { fields: [] }
}

/// 元数据提取 / Extract metadata from asset.
pub fn metadata_extract(asset : DataAsset) -> Metadata {
  let fields = asset.metadata + [("id", asset.id), ("name", asset.name), ("type", asset.asset_type), ("hash", asset.content_hash)]
  { fields }
}

/// 元数据校验 / Validate metadata.
pub fn metadata_validate(meta : Metadata) -> Bool {
  for i in 0..<meta.fields.length() {
    let (k, v) = meta.fields[i]
    if k.length() == 0 || v.length() == 0 {
      return false
    }
  }
  true
}

///===
/// LineageGraph 操作 / Lineage graph operations

/// 血缘压缩 / Compress lineage graph.
pub fn lineage_compress(graph : LineageGraph) -> LineageGraph {
  let new_nodes : Array[LineageNode] = []
  for i in 0..<graph.nodes.length() {
    let mut dup = false
    for j in 0..<new_nodes.length() {
      if new_nodes[j].id == graph.nodes[i].id {
        dup = true
        break
      }
    }
    if not(dup) {
      new_nodes.push(graph.nodes[i])
    }
  }
  let new_edges : Array[LineageEdge] = []
  for i in 0..<graph.edges.length() {
    let mut dup = false
    for j in 0..<new_edges.length() {
      if new_edges[j].source == graph.edges[i].source && new_edges[j].target == graph.edges[i].target {
        dup = true
        break
      }
    }
    if not(dup) {
      new_edges.push(graph.edges[i])
    }
  }
  { nodes: new_nodes, edges: new_edges }
}

/// 血缘裁剪 / Prune lineage graph by node type.
pub fn lineage_prune(graph : LineageGraph, node_type : String) -> LineageGraph {
  let new_nodes : Array[LineageNode] = []
  let keep_ids : Array[String] = []
  for i in 0..<graph.nodes.length() {
    if graph.nodes[i].node_type != node_type {
      new_nodes.push(graph.nodes[i])
      keep_ids.push(graph.nodes[i].id)
    }
  }
  let new_edges : Array[LineageEdge] = []
  for i in 0..<graph.edges.length() {
    if dl_contains(keep_ids, graph.edges[i].source) && dl_contains(keep_ids, graph.edges[i].target) {
      new_edges.push(graph.edges[i])
    }
  }
  { nodes: new_nodes, edges: new_edges }
}

/// 血缘合并 / Merge two lineage graphs.
pub fn lineage_merge(a : LineageGraph, b : LineageGraph) -> LineageGraph {
  let combined = { nodes: a.nodes + b.nodes, edges: a.edges + b.edges }
  lineage_compress(combined)
}

///===
/// LineageGraph 高级分析 / Lineage graph advanced analysis

/// 最短路径 / Shortest path between two nodes (BFS).
pub fn lineage_shortest_path(
  graph : LineageGraph,
  source : String,
  target : String
) -> Array[String] {
  if source == target {
    return [source]
  }
  let queue : Array[String] = [source]
  let visited : Array[String] = [source]
  let parent : Array[(String, String)] = []
  let mut found = false
  while queue.length() > 0 {
    let current = queue[0]
    ignore(queue.remove(0))
    let downstream = lineage_downstream(graph, current)
    for i in 0..<downstream.length() {
      let next = downstream[i]
      if next == target {
        parent.push((next, current))
        found = true
        break
      }
      if not(dl_contains(visited, next)) {
        visited.push(next)
        parent.push((next, current))
        queue.push(next)
      }
    }
    if found {
      break
    }
  }
  if not(found) {
    return []
  }
  let path : Array[String] = [target]
  let mut cur = target
  while cur != source {
    for i in 0..<parent.length() {
      let (node, par) = parent[i]
      if node == cur {
        path.insert(0, par)
        cur = par
        break
      }
    }
  }
  path
}

/// 环检测 / Detect cycle in lineage graph.
pub fn lineage_has_cycle(graph : LineageGraph) -> Bool {
  let n = graph.nodes.length()
  if n == 0 {
    return false
  }
  let visited = Array::make(n, false)
  let rec_stack = Array::make(n, false)
  for i in 0..<n {
    if not(visited[i]) {
      let node_id = graph.nodes[i].id
      let mut has_cycle = false
      let stack : Array[(Int, String)] = [(i, node_id)]
      while stack.length() > 0 {
        let (idx, nid) = stack[stack.length() - 1]
        ignore(stack.remove(stack.length() - 1))
        if rec_stack[idx] {
          rec_stack[idx] = false
        } else if not(visited[idx]) {
          visited[idx] = true
          rec_stack[idx] = true
          stack.push((idx, nid))
          for j in 0..<graph.edges.length() {
            if graph.edges[j].source == nid {
              for k in 0..<n {
                if graph.nodes[k].id == graph.edges[j].target {
                  if rec_stack[k] {
                    has_cycle = true
                  } else if not(visited[k]) {
                    stack.push((k, graph.nodes[k].id))
                  }
                  break
                }
              }
            }
          }
        }
      }
      if has_cycle {
        return true
      }
    }
  }
  false
}

/// 血缘深度 / Lineage depth from a node.
pub fn lineage_depth(graph : LineageGraph, node_id : String) -> Int {
  let queue : Array[(String, Int)] = [(node_id, 0)]
  let visited : Array[String] = [node_id]
  let mut max_depth = 0
  while queue.length() > 0 {
    let (current, depth) = queue[0]
    ignore(queue.remove(0))
    if depth > max_depth {
      max_depth = depth
    }
    let downstream = lineage_downstream(graph, current)
    for i in 0..<downstream.length() {
      if not(dl_contains(visited, downstream[i])) {
        visited.push(downstream[i])
        queue.push((downstream[i], depth + 1))
      }
    }
  }
  max_depth
}

/// 根节点 / Get root nodes (no upstream).
pub fn lineage_root_nodes(graph : LineageGraph) -> Array[String] {
  let result : Array[String] = []
  for i in 0..<graph.nodes.length() {
    let nid = graph.nodes[i].id
    let upstream = lineage_upstream(graph, nid)
    if upstream.length() == 0 {
      result.push(nid)
    }
  }
  result
}

/// 叶节点 / Get leaf nodes (no downstream).
pub fn lineage_leaf_nodes(graph : LineageGraph) -> Array[String] {
  let result : Array[String] = []
  for i in 0..<graph.nodes.length() {
    let nid = graph.nodes[i].id
    let downstream = lineage_downstream(graph, nid)
    if downstream.length() == 0 {
      result.push(nid)
    }
  }
  result
}

/// 子图提取 / Extract subgraph by node ids.
pub fn lineage_subgraph(graph : LineageGraph, node_ids : Array[String]) -> LineageGraph {
  let new_nodes : Array[LineageNode] = []
  for i in 0..<graph.nodes.length() {
    if dl_contains(node_ids, graph.nodes[i].id) {
      new_nodes.push(graph.nodes[i])
    }
  }
  let new_edges : Array[LineageEdge] = []
  for i in 0..<graph.edges.length() {
    if dl_contains(node_ids, graph.edges[i].source) && dl_contains(node_ids, graph.edges[i].target) {
      new_edges.push(graph.edges[i])
    }
  }
  { nodes: new_nodes, edges: new_edges }
}

/// 拓扑排序 / Topological sort of lineage graph.
pub fn lineage_topo_sort(graph : LineageGraph) -> Array[String] {
  let n = graph.nodes.length()
  if n == 0 {
    return []
  }
  let in_degree = Array::make(n, 0)
  for i in 0..<n {
    let nid = graph.nodes[i].id
    for j in 0..<graph.edges.length() {
      if graph.edges[j].target == nid {
        in_degree[i] = in_degree[i] + 1
      }
    }
  }
  let result : Array[String] = []
  let visited = Array::make(n, false)
  let mut progress = true
  while progress {
    progress = false
    for i in 0..<n {
      if not(visited[i]) && in_degree[i] == 0 {
        visited[i] = true
        result.push(graph.nodes[i].id)
        let nid = graph.nodes[i].id
        for j in 0..<graph.edges.length() {
          if graph.edges[j].source == nid {
            for k in 0..<n {
              if graph.nodes[k].id == graph.edges[j].target && not(visited[k]) {
                in_degree[k] = in_degree[k] - 1
              }
            }
          }
        }
        progress = true
      }
    }
  }
  result
}

/// 节点数 / Node count.
pub fn lineage_node_count(graph : LineageGraph) -> Int {
  graph.nodes.length()
}

/// 边数 / Edge count.
pub fn lineage_edge_count(graph : LineageGraph) -> Int {
  graph.edges.length()
}

/// 是否为空 / Check if graph is empty.
pub fn lineage_is_empty(graph : LineageGraph) -> Bool {
  graph.nodes.length() == 0
}

///===
/// 包标识 / Package id

/// 包标识 / Package id.
pub fn data_lineage_id() -> String {
  let pkg = "dataobject/data_lineage"
  let version = "S12.10"
  let features = "graph,asset,transformation,pipeline,column,table,versioned,event,catalog,dictionary,metadata"
  let result = pkg + " (" + version + "): " + features
  if result.length() > 0 {
    result
  } else {
    pkg
  }
}