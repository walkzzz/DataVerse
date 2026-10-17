///|
/// # datair/ir_pipeline 流水线 IR（DAG）/ Pipeline IR (DAG)
///
/// 算子图 DAG 表示：节点 + 边 + 拓扑排序。架构 §4.6。
/// S1.4 基礎：DAG 构造 + 拓扑排序。
///
/// # Pipeline IR (DAG)
///
/// Operator graph DAG: nodes + edges + topo sort. See architecture §4.6.

/// DAG 边 / DAG edge: dependency from source to target.
pub struct DAGEdge {
  from : @ir_core.IRNodeId
  to : @ir_core.IRNodeId
} derive(Debug, Eq)

pub extend DAGEdge with Eq::{equal, not_equal}
pub extend DAGEdge with Debug::{to_repr}

/// 流水线 IR / Pipeline IR: DAG of operator nodes.
pub struct PipelineIR {
  nodes : Array[@ir_operator.OperatorIR]
  edges : Array[DAGEdge]
} derive(Debug, Eq)

pub extend PipelineIR with Eq::{equal, not_equal}
pub extend PipelineIR with Debug::{to_repr}

/// 构造 DAG 边 / Build a DAG edge.
pub fn DAGEdge::new(
  from : @ir_core.IRNodeId,
  to : @ir_core.IRNodeId
) -> DAGEdge {
  { from, to }
}

/// 空流水线 / Empty pipeline.
pub fn PipelineIR::empty() -> PipelineIR {
  { nodes: [], edges: [] }
}

/// 构造流水线 / Build a pipeline from nodes and edges.
pub fn PipelineIR::new(
  nodes : Array[@ir_operator.OperatorIR],
  edges : Array[DAGEdge]
) -> PipelineIR {
  { nodes, edges }
}

/// 添加节点 / Add a node.
pub fn PipelineIR::add_node(
  self : PipelineIR,
  node : @ir_operator.OperatorIR
) -> PipelineIR {
  { nodes: self.nodes + [node], edges: self.edges }
}

/// 添加边 / Add an edge.
pub fn PipelineIR::add_edge(
  self : PipelineIR,
  edge : DAGEdge
) -> PipelineIR {
  { nodes: self.nodes, edges: self.edges + [edge] }
}

/// 节点数 / Node count.
pub fn PipelineIR::node_count(self : PipelineIR) -> Int {
  self.nodes.length()
}

/// 边数 / Edge count.
pub fn PipelineIR::edge_count(self : PipelineIR) -> Int {
  self.edges.length()
}

/// 拓扑排序 / Topological sort (Kahn's algorithm).
///
/// 返回节点 ID 的拓扑顺序。若存在环返回空数组（退化安全）。
pub fn PipelineIR::topo_order(self : PipelineIR) -> Array[@ir_core.IRNodeId] {
  let n = self.nodes.length()
  if n == 0 {
    return []
  }
  // 计算入度
  let in_degree = []
  for i = 0; i < n; i = i + 1 {
    let node_id = self.nodes[i].node_id
    let mut deg = 0
    for j = 0; j < self.edges.length(); j = j + 1 {
      if self.edges[j].to == node_id {
        deg = deg + 1
      }
    }
    in_degree.push(deg)
  }
  // Kahn 算法
  let result = []
  let visited = Array::make(n, false)
  let mut progress = true
  while progress {
    progress = false
    for i = 0; i < n; i = i + 1 {
      if !visited[i] && in_degree[i] == 0 {
        visited[i] = true
        result.push(self.nodes[i].node_id)
        // 减少后继入度
        let node_id = self.nodes[i].node_id
        for j = 0; j < self.edges.length(); j = j + 1 {
          if self.edges[j].from == node_id {
            for k = 0; k < n; k = k + 1 {
              if self.nodes[k].node_id == self.edges[j].to && !visited[k] {
                in_degree[k] = in_degree[k] - 1
              }
            }
          }
        }
        progress = true
      }
    }
  }
  // 若有环（result 不含所有节点），返回空
  if result.length() < n {
    []
  } else {
    result
  }
}

pub fn ir_pipeline_id() -> String {
  "datair/ir_pipeline"
}