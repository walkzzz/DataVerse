///|
/// # agent_kit/knowledge_graph 知识图谱 / Knowledge Graph
///
/// 知识图谱构建、查询、推理、嵌入、补全、模式验证、联邦查询。
/// 架构 §4.8 Agent-Kit。
///
/// # Knowledge graph

/// 实体 / Entity.
pub struct Entity {
  entity_id : String
  entity_type : String
  attributes : Array[(String, String)]
} derive(Debug, Eq)

pub extend Entity with Eq::{equal, not_equal}
pub extend Entity with Debug::{to_repr}

/// 关系 / Relation.
pub struct Relation {
  relation_id : String
  source_type : String
  target_type : String
  symmetric : Bool
} derive(Debug, Eq)

pub extend Relation with Eq::{equal, not_equal}
pub extend Relation with Debug::{to_repr}

/// 三元组 / Triple.
pub struct Triple {
  subject : String
  predicate : String
  object : String
} derive(Debug, Eq)

pub extend Triple with Eq::{equal, not_equal}
pub extend Triple with Debug::{to_repr}

/// 知识图谱 / Knowledge graph.
pub struct KnowledgeGraph {
  kg_id : String
  entities : Array[Entity]
  relations : Array[Relation]
  triples : Array[Triple]
} derive(Debug, Eq)

pub extend KnowledgeGraph with Eq::{equal, not_equal}
pub extend KnowledgeGraph with Debug::{to_repr}

/// 本体 / Ontology.
pub struct Ontology {
  ontology_id : String
  classes : Array[String]
  hierarchy : Array[(String, String)]
} derive(Debug, Eq)

pub extend Ontology with Eq::{equal, not_equal}
pub extend Ontology with Debug::{to_repr}

/// RDF 三元组 / RDF triple.
pub struct RDFTriple {
  subject : String
  predicate : String
  object : String
} derive(Debug, Eq)

pub extend RDFTriple with Eq::{equal, not_equal}
pub extend RDFTriple with Debug::{to_repr}

/// SPARQL 查询 / SPARQL query.
pub struct SPARQLQuery {
  query_id : String
  patterns : Array[Triple]
  select_vars : Array[String]
} derive(Debug, Eq)

pub extend SPARQLQuery with Eq::{equal, not_equal}
pub extend SPARQLQuery with Debug::{to_repr}

/// 推理器 / Reasoner.
pub struct Reasoner {
  reasoner_id : String
  rules : Array[(String, String)]
  facts : Array[Triple]
} derive(Debug, Eq)

pub extend Reasoner with Eq::{equal, not_equal}
pub extend Reasoner with Debug::{to_repr}

/// 嵌入 / Embedding.
pub struct Embedding {
  emb_id : String
  entity_embeddings : Array[(String, Array[Double])]
  relation_embeddings : Array[(String, Array[Double])]
  dim : Int
} derive(Debug, Eq)

pub extend Embedding with Eq::{equal, not_equal}
pub extend Embedding with Debug::{to_repr}

/// 模式 / Schema.
pub struct Schema {
  schema_id : String
  type_constraints : Array[(String, String)]
  relation_constraints : Array[(String, String, String)]
} derive(Debug, Eq)

pub extend Schema with Eq::{equal, not_equal}
pub extend Schema with Debug::{to_repr}

/// SHACL 约束 / SHACL constraint.
pub struct SHACL {
  shacl_id : String
  shapes : Array[(String, String)]
  min_count : Array[(String, Int)]
} derive(Debug, Eq)

pub extend SHACL with Eq::{equal, not_equal}
pub extend SHACL with Debug::{to_repr}

/// 知识图谱联邦 / KG federation.
pub struct KGFederation {
  fed_id : String
  graphs : Array[KnowledgeGraph]
} derive(Debug, Eq)

pub extend KGFederation with Eq::{equal, not_equal}
pub extend KGFederation with Debug::{to_repr}

///===
/// 辅助函数 / Helpers

fn kg_sqrt(x : Double) -> Double {
  if x <= 0.0 {
    return 0.0
  }
  let mut guess = x
  for i in 0..<100 {
    guess = 0.5 * (guess + x / guess)
  }
  guess
}

fn kg_cos(x : Double) -> Double {
  let mut result = 1.0
  let mut term = 1.0
  for i in 1..<20 {
    term = 0.0 - term * x * x / ((2 * i - 1).to_double() * (2 * i).to_double())
    result = result + term
  }
  result
}

fn vector_add(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  let result : Array[Double] = []
  for i in 0..<n {
    result.push(a[i] + b[i])
  }
  result
}

fn vector_sub(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  let result : Array[Double] = []
  for i in 0..<n {
    result.push(a[i] - b[i])
  }
  result
}

fn vector_dot(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + a[i] * b[i]
  }
  sum
}

fn vector_scale(a : Array[Double], s : Double) -> Array[Double] {
  let result : Array[Double] = []
  for i in 0..<a.length() {
    result.push(a[i] * s)
  }
  result
}

fn vector_norm(a : Array[Double]) -> Double {
  let mut sum = 0.0
  for i in 0..<a.length() {
    sum = sum + a[i] * a[i]
  }
  kg_sqrt(sum)
}

fn contains_str(arr : Array[String], val : String) -> Bool {
  for i in 0..<arr.length() {
    if arr[i] == val {
      return true
    }
  }
  false
}

fn contains_entity(kg : KnowledgeGraph, entity_id : String) -> Bool {
  for i in 0..<kg.entities.length() {
    if kg.entities[i].entity_id == entity_id {
      return true
    }
  }
  false
}

fn contains_relation(kg : KnowledgeGraph, relation_id : String) -> Bool {
  for i in 0..<kg.relations.length() {
    if kg.relations[i].relation_id == relation_id {
      return true
    }
  }
  false
}

fn kg_get_entity_type(kg : KnowledgeGraph, entity_id : String) -> String? {
  for i in 0..<kg.entities.length() {
    if kg.entities[i].entity_id == entity_id {
      return Some(kg.entities[i].entity_type)
    }
  }
  None
}

fn lookup_embedding(
  embeddings : Array[(String, Array[Double])],
  key : String,
) -> Array[Double]? {
  for i in 0..<embeddings.length() {
    if embeddings[i].0 == key {
      return Some(embeddings[i].1)
    }
  }
  None
}

fn is_var(s : String) -> Bool {
  s.length() > 0 && s[0] == '?'
}

fn triple_exists(
  triples : Array[Triple],
  s : String,
  p : String,
  o : String,
) -> Bool {
  for i in 0..<triples.length() {
    if triples[i].subject == s && triples[i].predicate == p && triples[i].object == o {
      return true
    }
  }
  false
}

///===
/// 构造与添加 / Construction and addition

/// 构造知识图谱 / Make knowledge graph.
pub fn make_kg(kg_id : String) -> KnowledgeGraph {
  { kg_id, entities: [], relations: [], triples: [] }
}

/// 添加实体 / Add entity.
pub fn kg_add_entity(kg : KnowledgeGraph, entity : Entity) -> KnowledgeGraph {
  let new_entities = kg.entities.copy()
  new_entities.push(entity)
  { ..kg, entities: new_entities }
}

/// 添加关系 / Add relation.
pub fn kg_add_relation(kg : KnowledgeGraph, relation : Relation) -> KnowledgeGraph {
  let new_relations = kg.relations.copy()
  new_relations.push(relation)
  { ..kg, relations: new_relations }
}

/// 添加属性 / Add attribute.
pub fn kg_add_attribute(
  kg : KnowledgeGraph,
  entity_id : String,
  key : String,
  value : String,
) -> KnowledgeGraph {
  let new_entities : Array[Entity] = []
  for i in 0..<kg.entities.length() {
    if kg.entities[i].entity_id == entity_id {
      let new_attrs = kg.entities[i].attributes.copy()
      new_attrs.push((key, value))
      new_entities.push({ ..kg.entities[i], attributes: new_attrs })
    } else {
      new_entities.push(kg.entities[i])
    }
  }
  { ..kg, entities: new_entities }
}

///===
/// 查询 / Query

/// 查询实体 / Query entity.
pub fn kg_query_entity(kg : KnowledgeGraph, entity_id : String) -> Entity? {
  for i in 0..<kg.entities.length() {
    if kg.entities[i].entity_id == entity_id {
      return Some(kg.entities[i])
    }
  }
  None
}

/// 查询关系 / Query relation.
pub fn kg_query_relation(kg : KnowledgeGraph, relation_id : String) -> Relation? {
  for i in 0..<kg.relations.length() {
    if kg.relations[i].relation_id == relation_id {
      return Some(kg.relations[i])
    }
  }
  None
}

/// 查询属性 / Query attribute.
pub fn kg_query_attribute(
  kg : KnowledgeGraph,
  entity_id : String,
  key : String,
) -> String? {
  for i in 0..<kg.entities.length() {
    if kg.entities[i].entity_id == entity_id {
      for j in 0..<kg.entities[i].attributes.length() {
        if kg.entities[i].attributes[j].0 == key {
          return Some(kg.entities[i].attributes[j].1)
        }
      }
    }
  }
  None
}

///===
/// 邻居与路径 / Neighbors and paths

/// 邻居 / Neighbors.
pub fn kg_neighbors(kg : KnowledgeGraph, entity_id : String) -> Array[String] {
  let result : Array[String] = []
  for i in 0..<kg.triples.length() {
    if kg.triples[i].subject == entity_id {
      if not(contains_str(result, kg.triples[i].object)) {
        result.push(kg.triples[i].object)
      }
    }
    if kg.triples[i].object == entity_id {
      if not(contains_str(result, kg.triples[i].subject)) {
        result.push(kg.triples[i].subject)
      }
    }
  }
  result
}

/// 路径 / Paths.
pub fn kg_paths(
  kg : KnowledgeGraph,
  start : String,
  end_ : String,
  max_depth : Int,
) -> Array[Array[String]] {
  let result : Array[Array[String]] = []
  let initial_path : Array[String] = [start]
  kg_paths_dfs(kg, start, end_, max_depth, initial_path, result)
  result
}

fn kg_paths_dfs(
  kg : KnowledgeGraph,
  current : String,
  end_ : String,
  depth : Int,
  path : Array[String],
  result : Array[Array[String]],
) -> Unit {
  if current == end_ {
    result.push(path.copy())
    return
  }
  if depth <= 0 {
    return
  }
  for i in 0..<kg.triples.length() {
    if kg.triples[i].subject == current {
      let next = kg.triples[i].object
      if not(contains_str(path, next)) {
        let new_path = path.copy()
        new_path.push(next)
        kg_paths_dfs(kg, next, end_, depth - 1, new_path, result)
      }
    }
  }
}

/// 最短路径 / Shortest path.
pub fn kg_shortest_path(
  kg : KnowledgeGraph,
  start : String,
  end_ : String,
) -> Array[String] {
  let paths = kg_paths(kg, start, end_, 10)
  if paths.length() == 0 {
    return []
  }
  let mut shortest_idx = 0
  let mut shortest_len = paths[0].length()
  for i in 1..<paths.length() {
    if paths[i].length() < shortest_len {
      shortest_len = paths[i].length()
      shortest_idx = i
    }
  }
  paths[shortest_idx]
}

///===
/// 子图与合并 / Subgraph and merge

/// 子图 / Subgraph.
pub fn kg_subgraph(kg : KnowledgeGraph, entities : Array[String]) -> KnowledgeGraph {
  let new_entities : Array[Entity] = []
  for i in 0..<kg.entities.length() {
    if contains_str(entities, kg.entities[i].entity_id) {
      new_entities.push(kg.entities[i])
    }
  }
  let new_triples : Array[Triple] = []
  for i in 0..<kg.triples.length() {
    let s_in = contains_str(entities, kg.triples[i].subject)
    let o_in = contains_str(entities, kg.triples[i].object)
    if s_in && o_in {
      new_triples.push(kg.triples[i])
    }
  }
  { kg_id: kg.kg_id + "_sub", entities: new_entities, relations: kg.relations.copy(), triples: new_triples }
}

/// 超图 / Supergraph.
pub fn kg_supergraph(kg1 : KnowledgeGraph, kg2 : KnowledgeGraph) -> KnowledgeGraph {
  kg_merge(kg1, kg2)
}

/// 合并 / Merge.
pub fn kg_merge(kg1 : KnowledgeGraph, kg2 : KnowledgeGraph) -> KnowledgeGraph {
  let new_entities = kg1.entities.copy()
  for i in 0..<kg2.entities.length() {
    new_entities.push(kg2.entities[i])
  }
  let new_relations = kg1.relations.copy()
  for i in 0..<kg2.relations.length() {
    new_relations.push(kg2.relations[i])
  }
  let new_triples = kg1.triples.copy()
  for i in 0..<kg2.triples.length() {
    new_triples.push(kg2.triples[i])
  }
  { kg_id: kg1.kg_id + "_" + kg2.kg_id, entities: new_entities, relations: new_relations, triples: new_triples }
}

///===
/// 本体 / Ontology

/// 构造本体 / Make ontology.
pub fn make_ontology(ontology_id : String) -> Ontology {
  { ontology_id, classes: [], hierarchy: [] }
}

/// 本体类 / Ontology classes.
pub fn ontology_classes(ontology : Ontology) -> Array[String] {
  ontology.classes.copy()
}

/// 本体层级 / Ontology hierarchy.
pub fn ontology_hierarchy(ontology : Ontology) -> Array[(String, String)] {
  ontology.hierarchy.copy()
}

///===
/// RDF 三元组 / RDF triple

/// 构造 RDF 三元组 / Make RDF triple.
pub fn make_rdf_triple(
  subject : String,
  predicate : String,
  object : String,
) -> RDFTriple {
  { subject, predicate, object }
}

/// RDF 主语 / RDF subject.
pub fn rdf_subject(triple : RDFTriple) -> String {
  triple.subject
}

/// RDF 谓词 / RDF predicate.
pub fn rdf_predicate(triple : RDFTriple) -> String {
  triple.predicate
}

/// RDF 宾语 / RDF object.
pub fn rdf_object(triple : RDFTriple) -> String {
  triple.object
}

///===
/// SPARQL / SPARQL query

/// 构造 SPARQL 查询 / Make SPARQL query.
pub fn make_sparql_query(
  query_id : String,
  patterns : Array[Triple],
  select_vars : Array[String],
) -> SPARQLQuery {
  { query_id, patterns, select_vars }
}

/// 执行 SPARQL / Execute SPARQL.
pub fn sparql_execute(
  kg : KnowledgeGraph,
  query : SPARQLQuery,
) -> Array[Array[String]] {
  let results : Array[Array[String]] = []
  if query.patterns.length() == 0 {
    return results
  }
  let p = query.patterns[0]
  for i in 0..<kg.triples.length() {
    let t = kg.triples[i]
    let s_match = p.subject == t.subject || is_var(p.subject)
    let p_match = p.predicate == t.predicate || is_var(p.predicate)
    let o_match = p.object == t.object || is_var(p.object)
    if s_match && p_match && o_match {
      let row : Array[String] = []
      for j in 0..<query.select_vars.length() {
        let v = query.select_vars[j]
        if v == "?s" {
          row.push(t.subject)
        } else if v == "?p" {
          row.push(t.predicate)
        } else if v == "?o" {
          row.push(t.object)
        } else {
          row.push("")
        }
      }
      results.push(row)
    }
  }
  results
}

/// SPARQL 结果 / SPARQL results.
pub fn sparql_results(results : Array[Array[String]]) -> String {
  let mut output = ""
  for i in 0..<results.length() {
    for j in 0..<results[i].length() {
      output = output + results[i][j]
      if j < results[i].length() - 1 {
        output = output + "|"
      }
    }
    if i < results.length() - 1 {
      output = output + ";"
    }
  }
  output
}

///===
/// 推理 / Reasoning

/// 构造推理器 / Make reasoner.
pub fn make_reasoner(reasoner_id : String) -> Reasoner {
  { reasoner_id, rules: [], facts: [] }
}

/// 前向推理 / Forward reasoning.
pub fn reason_forward(reasoner : Reasoner, triple : Triple) -> Array[Triple] {
  let result : Array[Triple] = [triple]
  for i in 0..<reasoner.rules.length() {
    let rule = reasoner.rules[i]
    if rule.0 == triple.predicate {
      result.push({ subject: triple.subject, predicate: rule.1, object: triple.object })
    }
  }
  result
}

/// 后向推理 / Backward reasoning.
pub fn reason_backward(reasoner : Reasoner, goal : Triple) -> Bool {
  reason_backward_helper(reasoner, goal, 10)
}

fn reason_backward_helper(
  reasoner : Reasoner,
  goal : Triple,
  depth : Int,
) -> Bool {
  if depth <= 0 {
    return false
  }
  for i in 0..<reasoner.facts.length() {
    if reasoner.facts[i].subject == goal.subject && reasoner.facts[i].predicate == goal.predicate && reasoner.facts[i].object == goal.object {
      return true
    }
  }
  for i in 0..<reasoner.rules.length() {
    let rule = reasoner.rules[i]
    if rule.1 == goal.predicate {
      let sub_goal : Triple = { subject: goal.subject, predicate: rule.0, object: goal.object }
      if reason_backward_helper(reasoner, sub_goal, depth - 1) {
        return true
      }
    }
  }
  false
}

/// 推理 / Infer.
pub fn kg_infer(
  kg : KnowledgeGraph,
  rules : Array[(String, String)],
) -> KnowledgeGraph {
  let new_triples = kg.triples.copy()
  let mut changed = true
  while changed {
    changed = false
    let n = new_triples.length()
    for i in 0..<n {
      for j in 0..<rules.length() {
        if new_triples[i].predicate == rules[j].0 {
          let s = new_triples[i].subject
          let o = new_triples[i].object
          if not(triple_exists(new_triples, s, rules[j].1, o)) {
            new_triples.push({ subject: s, predicate: rules[j].1, object: o })
            changed = true
          }
        }
      }
    }
  }
  { ..kg, triples: new_triples }
}

/// 蕴含 / Entail.
pub fn kg_entail(kg : KnowledgeGraph, triple : Triple) -> Bool {
  triple_exists(kg.triples, triple.subject, triple.predicate, triple.object)
}

/// 一致性 / Consistent.
pub fn kg_consistent(kg : KnowledgeGraph) -> Bool {
  for i in 0..<kg.triples.length() {
    let outer_len = kg.triples.length()
    let start_j = i + 1
    for j in start_j..<outer_len {
      if kg.triples[i].subject == kg.triples[j].subject && kg.triples[i].predicate == kg.triples[j].predicate && kg.triples[i].object != kg.triples[j].object {
        let mut has_neg = false
        for k in 0..<kg.relations.length() {
          if kg.relations[k].relation_id == kg.triples[i].predicate && not(kg.relations[k].symmetric) {
            has_neg = true
          }
        }
        if has_neg {
          return false
        }
      }
    }
  }
  true
}

///===
/// 闭包 / Closure

/// 传递闭包 / Transitive closure.
pub fn kg_transitive_closure(
  kg : KnowledgeGraph,
  predicate : String,
) -> KnowledgeGraph {
  let new_triples = kg.triples.copy()
  let mut changed = true
  while changed {
    changed = false
    let n = new_triples.length()
    for i in 0..<n {
      if new_triples[i].predicate == predicate {
        for j in 0..<n {
          if new_triples[j].predicate == predicate && new_triples[i].object == new_triples[j].subject {
            let s = new_triples[i].subject
            let o = new_triples[j].object
            if not(triple_exists(new_triples, s, predicate, o)) {
              new_triples.push({ subject: s, predicate, object: o })
              changed = true
            }
          }
        }
      }
    }
  }
  { ..kg, triples: new_triples }
}

/// 自反闭包 / Reflexive closure.
pub fn kg_reflexive_closure(
  kg : KnowledgeGraph,
  predicate : String,
) -> KnowledgeGraph {
  let new_triples = kg.triples.copy()
  for i in 0..<kg.entities.length() {
    let eid = kg.entities[i].entity_id
    if not(triple_exists(new_triples, eid, predicate, eid)) {
      new_triples.push({ subject: eid, predicate, object: eid })
    }
  }
  { ..kg, triples: new_triples }
}

/// 对称闭包 / Symmetric closure.
pub fn kg_symmetric_closure(
  kg : KnowledgeGraph,
  predicate : String,
) -> KnowledgeGraph {
  let new_triples = kg.triples.copy()
  for i in 0..<kg.triples.length() {
    if kg.triples[i].predicate == predicate {
      let s = kg.triples[i].object
      let o = kg.triples[i].subject
      if not(triple_exists(new_triples, s, predicate, o)) {
        new_triples.push({ subject: s, predicate, object: o })
      }
    }
  }
  { ..kg, triples: new_triples }
}

///===
/// 类型检查 / Type checking

/// 类型检查 / Type check.
pub fn kg_type_check(
  kg : KnowledgeGraph,
  entity_id : String,
  type_ : String,
) -> Bool {
  for i in 0..<kg.entities.length() {
    if kg.entities[i].entity_id == entity_id && kg.entities[i].entity_type == type_ {
      return true
    }
  }
  false
}

/// 实例检查 / Instance check.
pub fn kg_instance_check(
  kg : KnowledgeGraph,
  entity_id : String,
  class_ : String,
) -> Bool {
  for i in 0..<kg.entities.length() {
    if kg.entities[i].entity_id == entity_id && kg.entities[i].entity_type == class_ {
      return true
    }
  }
  false
}

/// 子类检查 / Subclass check.
pub fn kg_subclass_check(
  ontology : Ontology,
  sub : String,
  sup : String,
) -> Bool {
  kg_subclass_helper(ontology, sub, sup, 10)
}

fn kg_subclass_helper(
  ontology : Ontology,
  sub : String,
  sup : String,
  depth : Int,
) -> Bool {
  if depth <= 0 {
    return false
  }
  if sub == sup {
    return true
  }
  for i in 0..<ontology.hierarchy.length() {
    if ontology.hierarchy[i].0 == sub && ontology.hierarchy[i].1 == sup {
      return true
    }
  }
  for i in 0..<ontology.hierarchy.length() {
    if ontology.hierarchy[i].0 == sub {
      if kg_subclass_helper(ontology, ontology.hierarchy[i].1, sup, depth - 1) {
        return true
      }
    }
  }
  false
}

///===
/// 实体链接与抽取 / Entity linking and extraction

/// 实体链接 / Entity link.
pub fn kg_entity_link(kg : KnowledgeGraph, mention : String) -> String? {
  for i in 0..<kg.entities.length() {
    if kg.entities[i].entity_id == mention {
      return Some(kg.entities[i].entity_id)
    }
    for j in 0..<kg.entities[i].attributes.length() {
      if kg.entities[i].attributes[j].1.contains(mention) {
        return Some(kg.entities[i].entity_id)
      }
    }
  }
  None
}

/// 关系抽取 / Relation extract.
pub fn kg_relation_extract(text : String) -> Array[Triple] {
  let result : Array[Triple] = []
  let parts : Array[String] = []
  let mut current = ""
  let chars = text.to_array()
  for i in 0..<chars.length() {
    if chars[i] == Int::unsafe_to_char(44) {
      parts.push(current)
      current = ""
    } else {
      current = current + String::from_array([chars[i]])
    }
  }
  if current.length() > 0 {
    parts.push(current)
  }
  if parts.length() >= 3 {
    result.push({ subject: parts[0], predicate: parts[1], object: parts[2] })
  }
  result
}

/// 三元组验证 / Triple validate.
pub fn kg_triple_validate(kg : KnowledgeGraph, triple : Triple) -> Bool {
  let s_exists = contains_entity(kg, triple.subject)
  let o_exists = contains_entity(kg, triple.object)
  let r_exists = contains_relation(kg, triple.predicate)
  s_exists && o_exists && r_exists
}

///===
/// 嵌入 / Embedding

/// 构造嵌入 / Make embedding.
pub fn kg_embedding(emb_id : String, dim : Int) -> Embedding {
  { emb_id, entity_embeddings: [], relation_embeddings: [], dim }
}

/// TransE 评分 / TransE score.
pub fn kg_transE(
  h : Array[Double],
  r : Array[Double],
  t : Array[Double],
) -> Double {
  let hr = vector_add(h, r)
  let diff = vector_sub(hr, t)
  0.0 - vector_norm(diff)
}

/// TransH 评分 / TransH score.
pub fn kg_transH(
  h : Array[Double],
  r : Array[Double],
  t : Array[Double],
  w : Array[Double],
) -> Double {
  let wh = vector_dot(w, h)
  let wt = vector_dot(w, t)
  let h_perp = vector_sub(h, vector_scale(w, wh))
  let t_perp = vector_sub(t, vector_scale(w, wt))
  let diff = vector_sub(vector_add(h_perp, r), t_perp)
  0.0 - vector_norm(diff)
}

/// DistMult 评分 / DistMult score.
pub fn kg_distMult(
  h : Array[Double],
  r : Array[Double],
  t : Array[Double],
) -> Double {
  let n = if h.length() < r.length() { h.length() } else { r.length() }
  let m = if n < t.length() { n } else { t.length() }
  let mut sum = 0.0
  for i in 0..<m {
    sum = sum + h[i] * r[i] * t[i]
  }
  sum
}

/// ComplEx 评分 / ComplEx score.
pub fn kg_complEx(
  h_re : Array[Double],
  h_im : Array[Double],
  r_re : Array[Double],
  r_im : Array[Double],
  t_re : Array[Double],
  t_im : Array[Double],
) -> Double {
  let n = h_re.length()
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + h_re[i] * r_re[i] * t_re[i] + h_re[i] * r_im[i] * t_im[i] + h_im[i] * r_re[i] * t_im[i] - h_im[i] * r_im[i] * t_re[i]
  }
  sum
}

/// RotatE 评分 / RotatE score.
pub fn kg_rotateE(
  h : Array[Double],
  r : Array[Double],
  t : Array[Double],
) -> Double {
  let n = if h.length() < r.length() { h.length() } else { r.length() }
  let m = if n < t.length() { n } else { t.length() }
  let diff : Array[Double] = []
  for i in 0..<m {
    diff.push(h[i] * kg_cos(r[i]) - t[i])
  }
  0.0 - vector_norm(diff)
}

/// 三元组评分 / Score triple.
pub fn kg_score_triple(
  emb : Embedding,
  h : String,
  r : String,
  t : String,
) -> Double {
  let h_vec = lookup_embedding(emb.entity_embeddings, h)
  let r_vec = lookup_embedding(emb.relation_embeddings, r)
  let t_vec = lookup_embedding(emb.entity_embeddings, t)
  match (h_vec, r_vec, t_vec) {
    (Some(hv), Some(rv), Some(tv)) => kg_transE(hv, rv, tv)
    _ => 0.0
  }
}

///===
/// 嵌入训练与预测 / Embedding training and prediction

/// 训练嵌入 / Train embedding.
pub fn kg_train_embedding(
  kg : KnowledgeGraph,
  dim : Int,
  epochs : Int,
) -> Embedding {
  let entity_embeddings : Array[(String, Array[Double])] = []
  for i in 0..<kg.entities.length() {
    let vec : Array[Double] = []
    for j in 0..<dim {
      vec.push(((i + j + 1) % 100).to_double() / 100.0)
    }
    entity_embeddings.push((kg.entities[i].entity_id, vec))
  }
  let relation_embeddings : Array[(String, Array[Double])] = []
  for i in 0..<kg.relations.length() {
    let vec : Array[Double] = []
    for j in 0..<dim {
      vec.push(((i + j + 2) % 100).to_double() / 100.0)
    }
    relation_embeddings.push((kg.relations[i].relation_id, vec))
  }
  let emb_id = kg.kg_id + "_emb_" + epochs.to_string()
  { emb_id, entity_embeddings, relation_embeddings, dim }
}

/// 预测关系 / Predict relation.
pub fn kg_predict_relation(
  emb : Embedding,
  h : String,
  t : String,
) -> String? {
  let h_vec = lookup_embedding(emb.entity_embeddings, h)
  let t_vec = lookup_embedding(emb.entity_embeddings, t)
  match (h_vec, t_vec) {
    (Some(hv), Some(tv)) => {
      let mut best : String? = None
      let mut best_score = -999999.0
      for i in 0..<emb.relation_embeddings.length() {
        let r_id = emb.relation_embeddings[i].0
        let r_vec = emb.relation_embeddings[i].1
        let score = kg_transE(hv, r_vec, tv)
        if score > best_score {
          best_score = score
          best = Some(r_id)
        }
      }
      best
    }
    _ => None
  }
}

/// 预测实体 / Predict entity.
pub fn kg_predict_entity(
  emb : Embedding,
  h : String,
  r : String,
) -> String? {
  let h_vec = lookup_embedding(emb.entity_embeddings, h)
  let r_vec = lookup_embedding(emb.relation_embeddings, r)
  match (h_vec, r_vec) {
    (Some(hv), Some(rv)) => {
      let mut best : String? = None
      let mut best_score = -999999.0
      for i in 0..<emb.entity_embeddings.length() {
        let t_id = emb.entity_embeddings[i].0
        let t_vec = emb.entity_embeddings[i].1
        let score = kg_transE(hv, rv, t_vec)
        if score > best_score {
          best_score = score
          best = Some(t_id)
        }
      }
      best
    }
    _ => None
  }
}

///===
/// 链接补全 / Link completion

/// 知识图谱补全 / Knowledge graph completion.
pub fn kg_completion(
  kg : KnowledgeGraph,
  emb : Embedding,
) -> Array[Triple] {
  let result : Array[Triple] = []
  for i in 0..<emb.entity_embeddings.length() {
    for j in 0..<emb.entity_embeddings.length() {
      if i != j {
        let h = emb.entity_embeddings[i].0
        let t = emb.entity_embeddings[j].0
        match kg_predict_relation(emb, h, t) {
          Some(r) => {
            if not(triple_exists(kg.triples, h, r, t)) {
              result.push({ subject: h, predicate: r, object: t })
            }
          }
          None => ()
        }
      }
    }
  }
  result
}

/// 缺失链接 / Missing links.
pub fn kg_missing_links(
  kg : KnowledgeGraph,
  threshold : Double,
) -> Array[Triple] {
  let result : Array[Triple] = []
  let mut count = 0
  for i in 0..<kg.entities.length() {
    for j in 0..<kg.entities.length() {
      if i != j {
        for k in 0..<kg.relations.length() {
          let h = kg.entities[i].entity_id
          let t = kg.entities[j].entity_id
          let r = kg.relations[k].relation_id
          if not(triple_exists(kg.triples, h, r, t)) {
            count = count + 1
            if count.to_double() <= threshold {
              result.push({ subject: h, predicate: r, object: t })
            }
          }
        }
      }
    }
  }
  result
}

/// 排名评分 / Rank score.
pub fn kg_rank_score(emb : Embedding, triple : Triple) -> Int {
  let h_vec = lookup_embedding(emb.entity_embeddings, triple.subject)
  let t_vec = lookup_embedding(emb.entity_embeddings, triple.object)
  match (h_vec, t_vec) {
    (Some(hv), Some(tv)) => {
      let target_score = match lookup_embedding(emb.relation_embeddings, triple.predicate) {
        Some(rv) => kg_transE(hv, rv, tv)
        None => 0.0
      }
      let mut rank = 1
      for i in 0..<emb.relation_embeddings.length() {
        let r_id = emb.relation_embeddings[i].0
        let r_vec = emb.relation_embeddings[i].1
        if r_id != triple.predicate {
          let score = kg_transE(hv, r_vec, tv)
          if score > target_score {
            rank = rank + 1
          }
        }
      }
      rank
    }
    _ => 0
  }
}

///===
/// 模式与 SHACL / Schema and SHACL

/// 构造模式 / Make schema.
pub fn kg_schema(schema_id : String) -> Schema {
  { schema_id, type_constraints: [], relation_constraints: [] }
}

/// 构造 SHACL / Make SHACL.
pub fn kg_shacl(shacl_id : String) -> SHACL {
  { shacl_id, shapes: [], min_count: [] }
}

/// 验证模式 / Validate schema.
pub fn kg_validate_schema(kg : KnowledgeGraph, schema : Schema) -> Bool {
  for i in 0..<kg.triples.length() {
    let s_type = kg_get_entity_type(kg, kg.triples[i].subject)
    let o_type = kg_get_entity_type(kg, kg.triples[i].object)
    match (s_type, o_type) {
      (Some(st), Some(ot)) => {
        let mut valid = false
        for j in 0..<schema.relation_constraints.length() {
          let rc = schema.relation_constraints[j]
          if rc.0 == kg.triples[i].predicate && rc.1 == st && rc.2 == ot {
            valid = true
          }
        }
        if schema.relation_constraints.length() == 0 {
          valid = true
        }
        if not(valid) {
          return false
        }
      }
      _ => ()
    }
  }
  true
}

///===
/// 联邦 / Federation

/// 构造联邦 / Make federation.
pub fn kg_federation(fed_id : String) -> KGFederation {
  { fed_id, graphs: [] }
}

/// 联邦查询 / Federate query.
pub fn kg_federate_query(
  fed : KGFederation,
  query : SPARQLQuery,
) -> Array[Array[String]] {
  let result : Array[Array[String]] = []
  for i in 0..<fed.graphs.length() {
    let partial = sparql_execute(fed.graphs[i], query)
    for j in 0..<partial.length() {
      result.push(partial[j])
    }
  }
  result
}

/// 联邦结果 / Federate results.
pub fn kg_federate_results(
  results : Array[Array[Array[String]]],
) -> Array[Array[String]] {
  let merged : Array[Array[String]] = []
  for i in 0..<results.length() {
    for j in 0..<results[i].length() {
      merged.push(results[i][j])
    }
  }
  merged
}

///===
/// 模块标识 / Module id

pub fn knowledge_graph_id() -> String {
  "agent_kit/knowledge_graph"
}