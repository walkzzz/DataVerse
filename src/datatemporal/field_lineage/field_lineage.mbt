///|
/// # datatemporal/field_lineage 字段级血缘 / Field-Level Lineage
///
/// 字段依赖图 + 影响分析 + 循环检测。架构 §4.4 datatemporal 深化。
/// S2.6 填充：FieldDep + FieldLineageGraph + impact_analysis + has_cycle。
///
/// # Field-level lineage
///
/// Dependency graph + impact analysis. See architecture §4.4.

/// 字段依赖 / Field dependency: source → target via transform.
pub struct FieldDep {
  source_field : String
  target_field : String
  transform : String
} derive(Debug, Eq)

pub extend FieldDep with Eq::{equal, not_equal}
pub extend FieldDep with Debug::{to_repr}

/// 字段血缘图 / Field lineage graph.
pub struct FieldLineageGraph {
  dependencies : Array[FieldDep]
  fields : Array[String]
} derive(Debug, Eq)

pub extend FieldLineageGraph with Eq::{equal, not_equal}
pub extend FieldLineageGraph with Debug::{to_repr}

/// 构造字段依赖 / Build field dependency.
pub fn make_field_dep(source : String, target : String, transform : String) -> FieldDep {
  { source_field: source, target_field: target, transform }
}

/// 构造字段血缘图 / Build field lineage graph.
pub fn build_graph(deps : Array[FieldDep]) -> FieldLineageGraph {
  let fields : Array[String] = []
  for i in 0..<deps.length() {
    let d = deps[i]
    let mut found_s = false
    for j in 0..<fields.length() {
      if fields[j] == d.source_field {
        found_s = true
      }
    }
    if !found_s {
      fields.push(d.source_field)
    }
    let mut found_t = false
    for j in 0..<fields.length() {
      if fields[j] == d.target_field {
        found_t = true
      }
    }
    if !found_t {
      fields.push(d.target_field)
    }
  }
  { dependencies: deps, fields }
}

/// 影响分析 / Impact analysis: find all fields affected by changing a field.
///
/// BFS 遍历依赖图，返回所有受影响的字段（包括直接和间接）。
pub fn impact_analysis(graph : FieldLineageGraph, changed_field : String) -> Array[String] {
  let result : Array[String] = []
  let queue : Array[String] = [changed_field]
  while queue.length() > 0 {
    let current = queue[0]
    let _ = queue.remove(0)
    for i in 0..<graph.dependencies.length() {
      let dep = graph.dependencies[i]
      if dep.source_field == current {
        let mut already = false
        for j in 0..<result.length() {
          if result[j] == dep.target_field {
            already = true
          }
        }
        if !already {
          result.push(dep.target_field)
          queue.push(dep.target_field)
        }
      }
    }
  }
  result
}

/// 检测循环依赖 / Detect cycle in the graph.
///
/// 简化版：检查是否有字段出现在自己的影响集中。
pub fn has_cycle(graph : FieldLineageGraph) -> Bool {
  for i in 0..<graph.fields.length() {
    let impacted = impact_analysis(graph, graph.fields[i])
    for j in 0..<impacted.length() {
      if impacted[j] == graph.fields[i] {
        return true
      }
    }
  }
  false
}

pub fn field_lineage_id() -> String {
  "datatemporal/field_lineage"
}