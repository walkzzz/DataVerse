///|
/// # agent_kit/reasoning 推理引擎 / Reasoning Engine
///
/// 逻辑推理、因果推理、反事实推理。
/// 架构 §4.8 Agent-Kit。S12.7 填充。
///
/// # Reasoning engine
///
/// Logic / causal / counterfactual reasoning.

/// 逻辑规则 P -> Q / Logic rule.
pub struct Rule {
  rule_id : String
  premise : String
  conclusion : String
  confidence : Double
} derive(Debug, Eq)

pub extend Rule with Eq::{equal, not_equal}
pub extend Rule with Debug::{to_repr}

/// 事实 / Fact.
pub struct Fact {
  fact_id : String
  proposition : String
  truth_value : Bool
  confidence : Double
} derive(Debug, Eq)

pub extend Fact with Eq::{equal, not_equal}
pub extend Fact with Debug::{to_repr}

/// 查询 / Query.
pub struct Query {
  query_id : String
  proposition : String
} derive(Debug, Eq)

pub extend Query with Eq::{equal, not_equal}
pub extend Query with Debug::{to_repr}

/// 推理结果 / Inference result.
pub struct InferenceResult {
  query : Query
  answer : Bool
  support : Array[Rule]
  confidence : Double
  explanation : String
} derive(Debug, Eq)

pub extend InferenceResult with Eq::{equal, not_equal}
pub extend InferenceResult with Debug::{to_repr}

/// 替换：变量 -> 值 / Substitution.
pub struct Substitution {
  bindings : Array[(String, String)]
} derive(Debug, Eq)

pub extend Substitution with Eq::{equal, not_equal}
pub extend Substitution with Debug::{to_repr}

/// 因果模型 / Causal model.
pub struct CausalModel {
  model_id : String
  variables : Array[String]
  edges : Array[(String, String)]
} derive(Debug, Eq)

pub extend CausalModel with Eq::{equal, not_equal}
pub extend CausalModel with Debug::{to_repr}

/// 论证 / Argument.
pub struct Argument {
  arg_id : String
  premises : Array[Fact]
  conclusion : Fact
} derive(Debug, Eq)

pub extend Argument with Eq::{equal, not_equal}
pub extend Argument with Debug::{to_repr}

/// 证明步骤 / Proof step.
pub struct ProofStep {
  step_id : Int
  statement : String
  justification : String
} derive(Debug, Eq)

pub extend ProofStep with Eq::{equal, not_equal}
pub extend ProofStep with Debug::{to_repr}

/// 证明 / Proof.
pub struct Proof {
  proof_id : String
  steps : Array[ProofStep]
  goal : String
} derive(Debug, Eq)

pub extend Proof with Eq::{equal, not_equal}
pub extend Proof with Debug::{to_repr}

/// 知识库 / Knowledge base.
pub struct KnowledgeBase {
  kb_id : String
  beliefs : Array[Fact]
  rules : Array[Rule]
} derive(Debug, Eq)

pub extend KnowledgeBase with Eq::{equal, not_equal}
pub extend KnowledgeBase with Debug::{to_repr}

///===
/// 构造函数 / Constructors

/// 构造规则 / Make rule.
pub fn make_rule(rule_id : String, premise : String, conclusion : String, confidence : Double) -> Rule {
  { rule_id, premise, conclusion, confidence }
}

/// 构造事实 / Make fact.
pub fn make_fact(fact_id : String, proposition : String, truth_value : Bool, confidence : Double) -> Fact {
  { fact_id, proposition, truth_value, confidence }
}

/// 构造查询 / Make query.
pub fn make_query(query_id : String, proposition : String) -> Query {
  { query_id, proposition }
}

/// 构造推理结果 / Make inference result.
pub fn make_inference_result(query : Query, answer : Bool, support : Array[Rule], confidence : Double, explanation : String) -> InferenceResult {
  { query, answer, support, confidence, explanation }
}

///===
/// 经典逻辑推理 / Classical logic inference

/// 肯定前件：P->Q, P ⊢ Q / Modus ponens.
pub fn modus_ponens(rule : Rule, fact : Fact) -> Fact? {
  if rule.premise == fact.proposition && fact.truth_value {
    Some(make_fact("mp_" + fact.fact_id, rule.conclusion, true, rule.confidence * fact.confidence))
  } else {
    None
  }
}

/// 否定后件：P->Q, ¬Q ⊢ ¬P / Modus tollens.
pub fn modus_tollens(rule : Rule, fact : Fact) -> Fact? {
  if rule.conclusion == fact.proposition && !(fact.truth_value) {
    Some(make_fact("mt_" + fact.fact_id, rule.premise, false, rule.confidence * fact.confidence))
  } else {
    None
  }
}

/// 假言三段论：P->Q, Q->R ⊢ P->R / Hypothetical syllogism.
pub fn hypothetical_syllogism(r1 : Rule, r2 : Rule) -> Rule? {
  if r1.conclusion == r2.premise {
    Some(make_rule("hs_" + r1.rule_id + "_" + r2.rule_id, r1.premise, r2.conclusion, r1.confidence * r2.confidence))
  } else {
    None
  }
}

/// 前向链 / Forward chaining.
pub fn forward_chaining(kb : KnowledgeBase, max_iter : Int) -> Array[Fact] {
  let result = kb.beliefs.copy()
  let mut changed = true
  let mut iter = 0
  while changed && iter < max_iter {
    changed = false
    let n = result.length()
    for i = 0; i < n; i = i + 1 {
      for j = 0; j < kb.rules.length(); j = j + 1 {
        match modus_ponens(kb.rules[j], result[i]) {
          Some(new_fact) => {
            let mut exists = false
            for k = 0; k < result.length(); k = k + 1 {
              if result[k].proposition == new_fact.proposition {
                exists = true
              }
            }
            if !(exists) {
              result.push(new_fact)
              changed = true
            }
          }
          None => ()
        }
      }
    }
    iter = iter + 1
  }
  result
}

/// 后向链 / Backward chaining.
pub fn backward_chaining(kb : KnowledgeBase, query : Query, depth : Int) -> InferenceResult {
  if depth <= 0 {
    return make_inference_result(query, false, [], 0.0, "Depth limit reached")
  }
  let mut found = false
  let support : Array[Rule] = []
  let mut conf = 0.0
  for i = 0; i < kb.beliefs.length(); i = i + 1 {
    let b = kb.beliefs[i]
    if b.proposition == query.proposition && b.truth_value {
      found = true
      conf = b.confidence
    }
  }
  if found {
    return make_inference_result(query, true, support, conf, "Found in beliefs")
  }
  for j = 0; j < kb.rules.length(); j = j + 1 {
    let r = kb.rules[j]
    if r.conclusion == query.proposition {
      let sub_query = make_query("sub_" + query.query_id, r.premise)
      let sub_result = backward_chaining(kb, sub_query, depth - 1)
      if sub_result.answer {
        found = true
        support.push(r)
        conf = r.confidence * sub_result.confidence
      }
    }
  }
  if found {
    make_inference_result(query, true, support, conf, "Proved via rules")
  } else {
    make_inference_result(query, false, [], 0.0, "No proof found")
  }
}

/// 归结 / Resolution.
pub fn resolution(clause1 : Array[String], clause2 : Array[String]) -> Array[String] {
  let result : Array[String] = []
  let mut resolved = false
  let mut resolve_idx1 = -1
  let mut resolve_idx2 = -1
  for i = 0; i < clause1.length(); i = i + 1 {
    for j = 0; j < clause2.length(); j = j + 1 {
      let l1 = clause1[i]
      let l2 = clause2[j]
      if l1 == "not_" + l2 || l2 == "not_" + l1 {
        resolved = true
        resolve_idx1 = i
        resolve_idx2 = j
      }
    }
  }
  if resolved {
    for i = 0; i < clause1.length(); i = i + 1 {
      if i != resolve_idx1 {
        result.push(clause1[i])
      }
    }
    for j = 0; j < clause2.length(); j = j + 1 {
      if j != resolve_idx2 {
        let l = clause2[j]
        let mut exists = false
        for k = 0; k < result.length(); k = k + 1 {
          if result[k] == l {
            exists = true
          }
        }
        if !(exists) {
          result.push(l)
        }
      }
    }
  }
  result
}

///===
/// 统一与替换 / Unification and substitution

fn is_variable(term : String) -> Bool {
  term.length() > 0 && term[0] == '?'
}

/// 统一 / Unification.
pub fn unification(term1 : String, term2 : String) -> Substitution? {
  if term1 == term2 {
    Some({ bindings: [] })
  } else if is_variable(term1) {
    Some({ bindings: [(term1, term2)] })
  } else if is_variable(term2) {
    Some({ bindings: [(term2, term1)] })
  } else {
    None
  }
}

/// 替换 / Apply substitution.
pub fn substitution(term : String, sub : Substitution) -> String {
  let mut result = term
  for i = 0; i < sub.bindings.length(); i = i + 1 {
    let v = sub.bindings[i].0
    let val = sub.bindings[i].1
    if result == v {
      result = val
    }
  }
  result
}

/// 组合替换 / Compose substitutions.
pub fn compose_substitution(s1 : Substitution, s2 : Substitution) -> Substitution {
  let result : Array[(String, String)] = []
  for i = 0; i < s1.bindings.length(); i = i + 1 {
    let v = s1.bindings[i].0
    let val = substitution(s1.bindings[i].1, s2)
    result.push((v, val))
  }
  for j = 0; j < s2.bindings.length(); j = j + 1 {
    let v = s2.bindings[j].0
    let mut exists = false
    for k = 0; k < result.length(); k = k + 1 {
      if result[k].0 == v {
        exists = true
      }
    }
    if !(exists) {
      result.push((v, s2.bindings[j].1))
    }
  }
  { bindings: result }
}

///===
/// 因果推理 / Causal reasoning

/// 构造因果模型 / Make causal model.
pub fn make_causal_model(model_id : String, variables : Array[String]) -> CausalModel {
  { model_id, variables, edges: [] }
}

/// 添加因果边 / Add causal edge.
pub fn add_causal_edge(model : CausalModel, cause : String, effect : String) -> CausalModel {
  let new_edges = model.edges.copy()
  new_edges.push((cause, effect))
  { ..model, edges: new_edges }
}

/// do 操作：干预 / Do intervention.
pub fn do_intervention(model : CausalModel, variable : String, _value : Double) -> CausalModel {
  let new_edges : Array[(String, String)] = []
  for i = 0; i < model.edges.length(); i = i + 1 {
    if model.edges[i].1 != variable {
      new_edges.push(model.edges[i])
    }
  }
  { ..model, edges: new_edges }
}

/// 反事实推理 / Counterfactual.
pub fn counterfactual(model : CausalModel, observed : Fact, hypothesis : Fact) -> Fact {
  let intervened = do_intervention(model, hypothesis.proposition, 1.0)
  let mut support_count = 0
  for i = 0; i < intervened.edges.length(); i = i + 1 {
    if intervened.edges[i].0 == hypothesis.proposition {
      support_count = support_count + 1
    }
  }
  let cf_conf = hypothesis.confidence * observed.confidence
  make_fact("cf_" + observed.fact_id, hypothesis.proposition, hypothesis.truth_value, cf_conf)
}

/// 因果效应 / Causal effect.
pub fn causal_effect(model : CausalModel, cause : String, effect : String, cause_value : Double, baseline : Double) -> Double {
  let mut has_path = false
  for i = 0; i < model.edges.length(); i = i + 1 {
    if model.edges[i].0 == cause && model.edges[i].1 == effect {
      has_path = true
    }
  }
  if has_path {
    cause_value - baseline
  } else {
    0.0
  }
}

/// 后门调整 / Backdoor adjustment.
pub fn backdoor_adjustment(model : CausalModel, treatment : String, outcome : String, confounders : Array[String]) -> Double {
  let mut valid_confounders = 0
  for i = 0; i < confounders.length(); i = i + 1 {
    let z = confounders[i]
    let mut z_to_t = false
    let mut z_to_y = false
    for j = 0; j < model.edges.length(); j = j + 1 {
      if model.edges[j].0 == z && model.edges[j].1 == treatment {
        z_to_t = true
      }
      if model.edges[j].0 == z && model.edges[j].1 == outcome {
        z_to_y = true
      }
    }
    if z_to_t && z_to_y {
      valid_confounders = valid_confounders + 1
    }
  }
  if valid_confounders == 0 {
    1.0
  } else {
    1.0 / (valid_confounders + 1).to_double()
  }
}

/// 前门调整 / Frontdoor adjustment.
pub fn frontdoor_adjustment(model : CausalModel, treatment : String, mediator : String, outcome : String) -> Double {
  let mut path1 = false
  let mut path2 = false
  for i = 0; i < model.edges.length(); i = i + 1 {
    if model.edges[i].0 == treatment && model.edges[i].1 == mediator {
      path1 = true
    }
    if model.edges[i].0 == mediator && model.edges[i].1 == outcome {
      path2 = true
    }
  }
  if path1 && path2 {
    1.0
  } else {
    0.0
  }
}

/// 工具变量 / Instrumental variable.
pub fn instrumental_variable(model : CausalModel, instrument : String, treatment : String, outcome : String) -> Double {
  let mut z_to_x = false
  let mut x_to_y = false
  let mut z_to_y = false
  for i = 0; i < model.edges.length(); i = i + 1 {
    if model.edges[i].0 == instrument && model.edges[i].1 == treatment {
      z_to_x = true
    }
    if model.edges[i].0 == treatment && model.edges[i].1 == outcome {
      x_to_y = true
    }
    if model.edges[i].0 == instrument && model.edges[i].1 == outcome {
      z_to_y = true
    }
  }
  if z_to_x && x_to_y && !(z_to_y) {
    1.0
  } else {
    0.0
  }
}

///===
/// 论证理论 / Argument theory

/// 构造论证 / Make argument.
pub fn make_argument(arg_id : String, premises : Array[Fact], conclusion : Fact) -> Argument {
  { arg_id, premises, conclusion }
}

/// 评估论证 / Evaluate argument.
pub fn evaluate_argument(arg : Argument) -> Double {
  if arg.premises.length() == 0 {
    return arg.conclusion.confidence
  }
  let mut min_conf = arg.premises[0].confidence
  for i = 1; i < arg.premises.length(); i = i + 1 {
    if arg.premises[i].confidence < min_conf {
      min_conf = arg.premises[i].confidence
    }
  }
  min_conf * arg.conclusion.confidence
}

/// 论证有效性 / Argument validity.
pub fn argument_validity(arg : Argument) -> Bool {
  let mut all_true = true
  for i = 0; i < arg.premises.length(); i = i + 1 {
    if !(arg.premises[i].truth_value) {
      all_true = false
    }
  }
  all_true
}

///===
/// 推理类型 / Reasoning types

/// 演绎推理 / Deductive reasoning.
pub fn deductive_reasoning(premises : Array[Fact], rules : Array[Rule]) -> Array[Fact] {
  let kb = make_knowledge_base("ded", premises, rules)
  forward_chaining(kb, 100)
}

/// 归纳推理 / Inductive reasoning.
pub fn inductive_reasoning(observations : Array[Fact]) -> Rule {
  if observations.length() < 2 {
    return make_rule("ind_default", "unknown", "unknown", 0.0)
  }
  let mut true_count = 0
  for i = 0; i < observations.length(); i = i + 1 {
    if observations[i].truth_value {
      true_count = true_count + 1
    }
  }
  let conf = true_count.to_double() / observations.length().to_double()
  make_rule("ind_rule", observations[0].proposition, observations[observations.length() - 1].proposition, conf)
}

/// 溯因推理 / Abductive reasoning.
pub fn abductive_reasoning(observations : Array[Fact], hypotheses : Array[Rule]) -> Rule? {
  let mut best : Rule? = None
  let mut best_conf = 0.0
  for i = 0; i < hypotheses.length(); i = i + 1 {
    let h = hypotheses[i]
    let mut match_count = 0
    for j = 0; j < observations.length(); j = j + 1 {
      if h.conclusion == observations[j].proposition && observations[j].truth_value {
        match_count = match_count + 1
      }
    }
    let score = match_count.to_double() * h.confidence
    if score > best_conf {
      best_conf = score
      best = Some(h)
    }
  }
  best
}

///===
/// 证明 / Proof

/// 构造证明 / Make proof.
pub fn make_proof(proof_id : String, steps : Array[ProofStep], goal : String) -> Proof {
  { proof_id, steps, goal }
}

/// 证明步骤 / Proof step.
pub fn proof_step(step_id : Int, statement : String, justification : String) -> ProofStep {
  { step_id, statement, justification }
}

/// 验证证明 / Verify proof.
pub fn verify_proof(proof : Proof) -> Bool {
  if proof.steps.length() == 0 {
    return false
  }
  let last = proof.steps[proof.steps.length() - 1]
  let mut step_ids_ok = true
  for i = 0; i < proof.steps.length(); i = i + 1 {
    if proof.steps[i].step_id != i {
      step_ids_ok = false
    }
  }
  last.statement == proof.goal && step_ids_ok
}

///===
/// 知识库 / Knowledge base

/// 构造知识库 / Make knowledge base.
pub fn make_knowledge_base(kb_id : String, beliefs : Array[Fact], rules : Array[Rule]) -> KnowledgeBase {
  { kb_id, beliefs, rules }
}

/// 添加信念 / Add belief.
pub fn add_belief(kb : KnowledgeBase, belief : Fact) -> KnowledgeBase {
  let new_beliefs = kb.beliefs.copy()
  new_beliefs.push(belief)
  { ..kb, beliefs: new_beliefs }
}

/// 查询信念 / Query belief.
pub fn query_belief(kb : KnowledgeBase, proposition : String) -> Fact? {
  let mut result : Fact? = None
  for i = 0; i < kb.beliefs.length(); i = i + 1 {
    if kb.beliefs[i].proposition == proposition {
      result = Some(kb.beliefs[i])
    }
  }
  result
}

/// 修正信念 / Revise belief.
pub fn revise_belief(kb : KnowledgeBase, belief : Fact) -> KnowledgeBase {
  let new_beliefs : Array[Fact] = []
  let mut found = false
  for i = 0; i < kb.beliefs.length(); i = i + 1 {
    if kb.beliefs[i].proposition == belief.proposition {
      new_beliefs.push(belief)
      found = true
    } else {
      new_beliefs.push(kb.beliefs[i])
    }
  }
  if !(found) {
    new_beliefs.push(belief)
  }
  { ..kb, beliefs: new_beliefs }
}

/// 撤回信念 / Retract belief.
pub fn retract_belief(kb : KnowledgeBase, proposition : String) -> KnowledgeBase {
  let new_beliefs : Array[Fact] = []
  for i = 0; i < kb.beliefs.length(); i = i + 1 {
    if kb.beliefs[i].proposition != proposition {
      new_beliefs.push(kb.beliefs[i])
    }
  }
  { ..kb, beliefs: new_beliefs }
}

/// 一致性检查 / Consistency check.
pub fn consistency_check(kb : KnowledgeBase) -> Bool {
  for i = 0; i < kb.beliefs.length(); i = i + 1 {
    for j = i + 1; j < kb.beliefs.length(); j = j + 1 {
      if kb.beliefs[i].proposition == kb.beliefs[j].proposition && kb.beliefs[i].truth_value != kb.beliefs[j].truth_value {
        return false
      }
    }
  }
  true
}

/// 模块标识 / Module id.
pub fn reasoning_id() -> String {
  "agent_kit/reasoning"
}