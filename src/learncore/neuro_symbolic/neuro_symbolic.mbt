///===
/// learncore/neuro_symbolic 神经符号AI / Neuro-Symbolic AI
/// S12 Phase 12 — 神经符号集成/逻辑张量网络/可微逻辑
/// 神经符号AI：符号推理 + 神经网络 + 可微逻辑

///|
///===
/// 符号逻辑 / Symbolic logic
pub struct Predicate {
  name : String
  args : Array[String]
}

///|
/// 构造谓词
pub fn make_predicate(name : String, args : Array[String]) -> Predicate {
  { name, args, }
}

///|
/// 谓词转字符串
pub fn predicate_to_string(p : Predicate) -> String {
  let mut result = p.name + "("
  for i in 0..<array_length(p.args) {
    if i > 0 {
      result = result + ", "
    }
    result = result + p.args[i]
  }
  result + ")"
}

///|
/// 谓词相等
pub fn predicate_eq(a : Predicate, b : Predicate) -> Bool {
  if a.name != b.name {
    return false
  }
  if array_length(a.args) != array_length(b.args) {
    return false
  }
  for i in 0..<array_length(a.args) {
    if a.args[i] != b.args[i] {
      return false
    }
  }
  true
}

///|
/// 逻辑规则
pub struct LogicRule {
  head : Predicate
  body : Array[Predicate]
  weight : Double
}

///|
/// 构造逻辑规则
pub fn make_rule(
  head : Predicate,
  body : Array[Predicate],
  weight : Double,
) -> LogicRule {
  { head, body, weight, }
}

///|
/// 规则转字符串
pub fn rule_to_string(rule : LogicRule) -> String {
  let mut result = predicate_to_string(rule.head) + " :- "
  for i in 0..<array_length(rule.body) {
    if i > 0 {
      result = result + ", "
    }
    result = result + predicate_to_string(rule.body[i])
  }
  result + " [w=" + double_to_string(rule.weight) + "]"
}

///|
///===
/// 逻辑张量网络 / Logic Tensor Network (LTN)
pub struct LTNVariable {
  name : String
  value : Double
  trainable : Bool
}

///|
/// 构造 LTN 变量
pub fn make_ltn_variable(
  name : String,
  value : Double,
  trainable : Bool,
) -> LTNVariable {
  { name, value, trainable, }
}

///|
/// LTN 谓词（神经网络参数化）
pub struct LTNPredicate {
  name : String
  weights : Array[Double]
  bias : Double
}

///|
/// 构造 LTN 谓词
pub fn make_ltn_predicate(
  name : String,
  weights : Array[Double],
  bias : Double,
) -> LTNPredicate {
  { name, weights, bias, }
}

///|
/// LTN 谓词求值
pub fn ltn_predicate_eval(
  pred : LTNPredicate,
  inputs : Array[Double],
) -> Double {
  let n = array_length(pred.weights)
  let mut sum = pred.bias
  for i in 0..<n {
    if i < array_length(inputs) {
      sum = sum + pred.weights[i] * inputs[i]
    }
  }
  sigmoid(sum)
}

///|
/// LTN 合取（AND）
pub fn ltn_and(values : Array[Double]) -> Double {
  let mut result = 1.0
  for i in 0..<array_length(values) {
    result = result * values[i]
  }
  result
}

///|
/// LTN 析取（OR）
pub fn ltn_or(values : Array[Double]) -> Double {
  let mut result = 1.0
  for i in 0..<array_length(values) {
    result = result * (1.0 - values[i])
  }
  1.0 - result
}

///|
/// LTN 蕴含（IMPLIES）
pub fn ltn_implies(a : Double, b : Double) -> Double {
  1.0 - a + a * b
}

///|
/// LTN 否定（NOT）
pub fn ltn_not(a : Double) -> Double {
  1.0 - a
}

///|
/// LTN 等价（EQUIV）
pub fn ltn_equiv(a : Double, b : Double) -> Double {
  ltn_and([ltn_implies(a, b), ltn_implies(b, a)])
}

///|
/// LTN 存在量词（EXISTS）
pub fn ltn_exists(values : Array[Double]) -> Double {
  ltn_or(values)
}

///|
/// LTN 全称量词（FORALL）
pub fn ltn_forall(values : Array[Double]) -> Double {
  let n = array_length(values)
  if n == 0 {
    1.0
  } else {
    let mut sum = 0.0
    for i in 0..<n {
      sum = sum + values[i]
    }
    sum / int_to_double(n)
  }
}

///===
/// 可微逻辑 / Differentiable logic

///|
/// t-norm 乘积
pub fn t_norm_product(a : Double, b : Double) -> Double {
  a * b
}

///|
/// t-norm 最小
pub fn t_norm_min(a : Double, b : Double) -> Double {
  if a < b {
    a
  } else {
    b
  }
}

///|
/// t-norm Lukasiewicz
pub fn t_norm_lukasiewicz(a : Double, b : Double) -> Double {
  let s = a + b - 1.0
  if s > 0.0 {
    s
  } else {
    0.0
  }
}

///|
/// t-conorm 概率和
pub fn t_conorm_prob(a : Double, b : Double) -> Double {
  a + b - a * b
}

///|
/// t-conorm 最大
pub fn t_conorm_max(a : Double, b : Double) -> Double {
  if a > b {
    a
  } else {
    b
  }
}

///|
/// 蕴含算子 Reichenbach
pub fn implies_reichenbach(a : Double, b : Double) -> Double {
  1.0 - a + a * b
}

///|
/// 蕴含算子 Godel
pub fn implies_godel(a : Double, b : Double) -> Double {
  if a <= b {
    1.0
  } else {
    b
  }
}

///|
/// 蕴含算子 Goguen
pub fn implies_goguen(a : Double, b : Double) -> Double {
  if a < 0.000000000000001 {
    1.0
  } else if b / a > 1.0 {
    1.0
  } else {
    b / a
  }
}

///|
///===
/// 知识图谱推理 / Knowledge graph reasoning
pub struct KGTriple {
  subject : String
  relation : String
  object : String
}

///|
/// 构造 KG 三元组
pub fn make_triple(
  subject : String,
  relation : String,
  object : String,
) -> KGTriple {
  { subject, relation, object, }
}

///|
/// 三元组转字符串
pub fn triple_to_string(t : KGTriple) -> String {
  "(" + t.subject + ", " + t.relation + ", " + t.object + ")"
}

///|
/// 知识图谱
pub struct KnowledgeGraph {
  triples : Array[KGTriple]
  entities : Array[String]
  relations : Array[String]
}

///|
/// 构造知识图谱
pub fn make_knowledge_graph(triples : Array[KGTriple]) -> KnowledgeGraph {
  let mut entities = []
  let mut relations = []
  for i in 0..<array_length(triples) {
    if !array_contains_str(entities, triples[i].subject) {
      entities = array_append_str(entities, [triples[i].subject])
    }
    if !array_contains_str(entities, triples[i].object) {
      entities = array_append_str(entities, [triples[i].object])
    }
    if !array_contains_str(relations, triples[i].relation) {
      relations = array_append_str(relations, [triples[i].relation])
    }
  }
  { triples, entities, relations, }
}

///|
/// KG 查询：给定主语和关系，找宾语
pub fn kg_query(
  kg : KnowledgeGraph,
  subject : String,
  relation : String,
) -> Array[String] {
  let mut results = []
  for i in 0..<array_length(kg.triples) {
    if kg.triples[i].subject == subject && kg.triples[i].relation == relation {
      results = array_append_str(results, [kg.triples[i].object])
    }
  }
  results
}

///|
/// KG 反向查询：给定宾语和关系，找主语
pub fn kg_query_inverse(
  kg : KnowledgeGraph,
  relation : String,
  object : String,
) -> Array[String] {
  let mut results = []
  for i in 0..<array_length(kg.triples) {
    if kg.triples[i].relation == relation && kg.triples[i].object == object {
      results = array_append_str(results, [kg.triples[i].subject])
    }
  }
  results
}

///|
/// KG 实体数
pub fn kg_entity_count(kg : KnowledgeGraph) -> Int32 {
  array_length(kg.entities)
}

///|
/// KG 关系数
pub fn kg_relation_count(kg : KnowledgeGraph) -> Int32 {
  array_length(kg.relations)
}

///|
/// KG 三元组数
pub fn kg_triple_count(kg : KnowledgeGraph) -> Int32 {
  array_length(kg.triples)
}

///|
///===
/// TransE 嵌入 / TransE embedding
pub struct TransEModel {
  entity_embeddings : Array[(String, Array[Double])]
  relation_embeddings : Array[(String, Array[Double])]
  dim : Int32
  margin : Double
}

///|
/// 构造 TransE 模型
pub fn make_transe_model(
  entity_embeddings : Array[(String, Array[Double])],
  relation_embeddings : Array[(String, Array[Double])],
  dim : Int32,
  margin : Double,
) -> TransEModel {
  { entity_embeddings, relation_embeddings, dim, margin, }
}

///|
/// TransE 得分函数: ||h + r - t||
pub fn transe_score(
  model : TransEModel,
  h : String,
  r : String,
  t : String,
) -> Double {
  let h_emb = lookup_embedding(model.entity_embeddings, h)
  let r_emb = lookup_embedding(model.relation_embeddings, r)
  let t_emb = lookup_embedding(model.entity_embeddings, t)
  let d = model.dim
  let mut sum = 0.0
  for i in 0..<d {
    let diff = h_emb[i] + r_emb[i] - t_emb[i]
    sum = sum + diff * diff
  }
  sqrt_(sum)
}

///|
/// TransE 损失
pub fn transe_loss(
  model : TransEModel,
  positive : Array[KGTriple],
  negative : Array[KGTriple],
) -> Double {
  let mut loss = 0.0
  for i in 0..<array_length(positive) {
    let pos_score = transe_score(
      model,
      positive[i].subject,
      positive[i].relation,
      positive[i].object,
    )
    if i < array_length(negative) {
      let neg_score = transe_score(
        model,
        negative[i].subject,
        negative[i].relation,
        negative[i].object,
      )
      let diff = model.margin + pos_score - neg_score
      if diff > 0.0 {
        loss = loss + diff
      }
    }
  }
  loss
}

///|
///===
/// 规则提取 / Rule extraction
pub struct ExtractedRule {
  conditions : Array[String]
  conclusion : String
  confidence : Double
  support : Int32
}

///|
/// 构造提取规则
pub fn make_extracted_rule(
  conditions : Array[String],
  conclusion : String,
  confidence : Double,
  support : Int32,
) -> ExtractedRule {
  { conditions, conclusion, confidence, support, }
}

///|
/// 规则提取（从决策路径）
pub fn extract_rules_from_paths(
  paths : Array[(Array[String], String)],
) -> Array[ExtractedRule] {
  let mut rules = []
  for i in 0..<array_length(paths) {
    let path = paths[i]
    let conditions = path.0
    let conclusion = path.1
    let conf = 1.0 / int_to_double(i + 1)
    rules = array_append_rule(rules, [
      make_extracted_rule(conditions, conclusion, conf, 1),
    ])
  }
  rules
}

///|
/// 规则过滤（按置信度阈值）
pub fn filter_rules_by_confidence(
  rules : Array[ExtractedRule],
  threshold : Double,
) -> Array[ExtractedRule] {
  let mut filtered = []
  for i in 0..<array_length(rules) {
    if rules[i].confidence >= threshold {
      filtered = array_append_rule(filtered, [rules[i]])
    }
  }
  filtered
}

///|
/// 规则合并（相同结论）
pub fn merge_rules(rules : Array[ExtractedRule]) -> Array[ExtractedRule] {
  let mut merged = []
  let used = Array::make(array_length(rules), false)
  for i in 0..<array_length(rules) {
    if !used[i] {
      used[i] = true
      let mut combined_conds = rules[i].conditions
      let mut total_support = rules[i].support
      let mut conf_sum = rules[i].confidence
      let mut conf_count = 1
      for j in (i + 1)..<array_length(rules) {
        if !used[j] && rules[j].conclusion == rules[i].conclusion {
          used[j] = true
          for k in 0..<array_length(rules[j].conditions) {
            if !array_contains_str(combined_conds, rules[j].conditions[k]) {
              combined_conds = array_append_str(combined_conds, [
                rules[j].conditions[k],
              ])
            }
          }
          total_support = total_support + rules[j].support
          conf_sum = conf_sum + rules[j].confidence
          conf_count = conf_count + 1
        }
      }
      merged = array_append_rule(merged, [
        make_extracted_rule(
          combined_conds,
          rules[i].conclusion,
          conf_sum / int_to_double(conf_count),
          total_support,
        ),
      ])
    }
  }
  merged
}

///|
///===
/// 神经符号推理 / Neuro-symbolic reasoning
pub struct NSReasoner {
  rules : Array[LogicRule]
  facts : Array[Predicate]
  ltn_preds : Array[LTNPredicate]
}

///|
/// 构造神经符号推理器
pub fn make_ns_reasoner(
  rules : Array[LogicRule],
  facts : Array[Predicate],
  ltn_preds : Array[LTNPredicate],
) -> NSReasoner {
  { rules, facts, ltn_preds, }
}

///|
/// 前向推理
pub fn forward_chain(
  reasoner : NSReasoner,
  max_steps : Int32,
) -> Array[Predicate] {
  let mut derived = reasoner.facts
  let mut changed = true
  let mut steps = 0
  while changed && steps < max_steps {
    changed = false
    steps = steps + 1
    for i in 0..<array_length(reasoner.rules) {
      let rule = reasoner.rules[i]
      let mut all_satisfied = true
      for j in 0..<array_length(rule.body) {
        let mut found = false
        for k in 0..<array_length(derived) {
          if predicate_eq(derived[k], rule.body[j]) {
            found = true
          }
        }
        if !found {
          all_satisfied = false
        }
      }
      if all_satisfied {
        let mut already = false
        for k in 0..<array_length(derived) {
          if predicate_eq(derived[k], rule.head) {
            already = true
          }
        }
        if !already {
          derived = array_append_pred(derived, [rule.head])
          changed = true
        }
      }
    }
  }
  derived
}

///|
/// 查询事实
pub fn query_fact(reasoner : NSReasoner, query : Predicate) -> Bool {
  for i in 0..<array_length(reasoner.facts) {
    if predicate_eq(reasoner.facts[i], query) {
      return true
    }
  }
  false
}

///|
/// 神经符号查询（带置信度）
pub fn ns_query(
  reasoner : NSReasoner,
  query : Predicate,
  inputs : Array[Double],
) -> Double {
  for i in 0..<array_length(reasoner.ltn_preds) {
    if reasoner.ltn_preds[i].name == query.name {
      return ltn_predicate_eval(reasoner.ltn_preds[i], inputs)
    }
  }
  if query_fact(reasoner, query) {
    1.0
  } else {
    0.0
  }
}

///|
///===
/// 概率逻辑 / Probabilistic logic
pub struct ProbabilisticFact {
  predicate : Predicate
  probability : Double
}

///|
/// 构造概率事实
pub fn make_prob_fact(
  predicate : Predicate,
  probability : Double,
) -> ProbabilisticFact {
  { predicate, probability, }
}

///|
/// 概率合取
pub fn prob_conjunction(facts : Array[ProbabilisticFact]) -> Double {
  let mut result = 1.0
  for i in 0..<array_length(facts) {
    result = result * facts[i].probability
  }
  result
}

///|
/// 概率析取（独立假设）
pub fn prob_disjunction(facts : Array[ProbabilisticFact]) -> Double {
  let mut result = 1.0
  for i in 0..<array_length(facts) {
    result = result * (1.0 - facts[i].probability)
  }
  1.0 - result
}

///|
/// 概率否定
pub fn prob_negation(fact : ProbabilisticFact) -> Double {
  1.0 - fact.probability
}

///|
/// 贝叶斯规则推理
pub fn bayesian_rule(
  prior : Double,
  likelihood : Double,
  evidence : Double,
) -> Double {
  if evidence < 0.000000000000001 {
    prior
  } else {
    likelihood * prior / evidence
  }
}

///|
///===
/// 辅助函数 / Helper functions
fn[A] array_length(arr : Array[A]) -> Int32 {
  arr.length()
}

///|
fn sigmoid(x : Double) -> Double {
  1.0 / (1.0 + exp_(-x))
}

///|
fn exp_(x : Double) -> Double {
  if x > 700.0 {
    999999999999999.0
  } else if x < -700.0 {
    0.0
  } else {
    let mut result = 1.0
    let mut term = 1.0
    for i in 1..<=50 {
      term = term * x / int_to_double(i)
      result = result + term
    }
    result
  }
}

///|
fn sqrt_(x : Double) -> Double {
  if x < 0.0 {
    0.0
  } else if x == 0.0 {
    0.0
  } else {
    let mut guess = x / 2.0
    if guess < 1.0 {
      guess = 1.0
    }
    for _ in 0..<50 {
      guess = (guess + x / guess) / 2.0
    }
    guess
  }
}

///|
fn lookup_embedding(
  embeddings : Array[(String, Array[Double])],
  name : String,
) -> Array[Double] {
  for i in 0..<array_length(embeddings) {
    if embeddings[i].0 == name {
      return embeddings[i].1
    }
  }
  Array::make(10, 0.0)
}

///|
fn double_to_string(x : Double) -> String {
  let int_part = int_of_double(x)
  let frac = x - int_to_double(int_part)
  let frac_int = int_of_double(abs_double(frac) * 1000000.0)
  int_to_string(int_part) + "." + int_to_string(frac_int)
}

///|
fn abs_double(x : Double) -> Double {
  if x < 0.0 {
    -x
  } else {
    x
  }
}

///|
fn int_of_double(x : Double) -> Int32 {
  if x >= 0.0 {
    int_of_double_impl(x)
  } else {
    -int_of_double_impl(-x)
  }
}

///|
fn int_of_double_impl(x : Double) -> Int32 {
  let mut n = 0
  let mut d = x
  while d >= 1.0 {
    n = n + 1
    d = d - 1.0
  }
  n
}

///|
fn int_to_double(n : Int32) -> Double {
  n.to_double()
}

///|
fn int_to_string(n : Int32) -> String {
  n.to_string()
}

///|
fn array_contains_str(arr : Array[String], x : String) -> Bool {
  for i in 0..<array_length(arr) {
    if arr[i] == x {
      return true
    }
  }
  false
}

///|
fn array_append_str(arr : Array[String], elem : Array[String]) -> Array[String] {
  let n = array_length(arr)
  let m = array_length(elem)
  if n == 0 {
    return elem
  }
  let result = Array::make(n + m, arr[0])
  for i in 0..<n {
    result[i] = arr[i]
  }
  for i in 0..<m {
    result[n + i] = elem[i]
  }
  result
}

///|
fn array_append_pred(
  arr : Array[Predicate],
  elem : Array[Predicate],
) -> Array[Predicate] {
  let n = array_length(arr)
  let m = array_length(elem)
  if n == 0 {
    return elem
  }
  let result = Array::make(n + m, arr[0])
  for i in 0..<n {
    result[i] = arr[i]
  }
  for i in 0..<m {
    result[n + i] = elem[i]
  }
  result
}

///|
fn array_append_rule(
  arr : Array[ExtractedRule],
  elem : Array[ExtractedRule],
) -> Array[ExtractedRule] {
  let n = array_length(arr)
  let m = array_length(elem)
  if n == 0 {
    return elem
  }
  let result = Array::make(n + m, arr[0])
  for i in 0..<n {
    result[i] = arr[i]
  }
  for i in 0..<m {
    result[n + i] = elem[i]
  }
  result
}
