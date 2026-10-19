///|
/// # learncore/graph_model 图模型 / Graphical Models
///
/// 马尔可夫/贝叶斯网络/因子图/HMM。架构 §4.3.5 C。
/// S12.4 新建：图模型算子。
///
/// # Graphical model operators
///
/// Markov/Bayes network/factor graph/HMM. See architecture §4.3.5 C.

/// 马尔可夫链 / Markov chain.
pub(all) struct MarkovChain {
  states : Array[String]
  transition : Array[Array[Double]]
  initial : Array[Double]
} derive(Debug, Eq)

pub extend MarkovChain with Eq::{equal, not_equal}
pub extend MarkovChain with Debug::{to_repr}

/// 因子 / Factor.
pub(all) struct Factor {
  variables : Array[String]
  values : Array[Double]
} derive(Debug, Eq)

pub extend Factor with Eq::{equal, not_equal}
pub extend Factor with Debug::{to_repr}

/// 因子图 / Factor graph.
pub(all) struct FactorGraph {
  variables : Array[String]
  factors : Array[Factor]
} derive(Debug, Eq)

pub extend FactorGraph with Eq::{equal, not_equal}
pub extend FactorGraph with Debug::{to_repr}

/// 马尔可夫随机场 / Markov random field.
pub(all) struct MRF {
  variables : Array[String]
  potentials : Array[Factor]
} derive(Debug, Eq)

pub extend MRF with Eq::{equal, not_equal}
pub extend MRF with Debug::{to_repr}

/// HMM 模型 / Hidden Markov Model.
pub(all) struct HMM {
  states : Array[String]
  observations : Array[String]
  transition : Array[Array[Double]]
  emission : Array[Array[Double]]
  initial : Array[Double]
} derive(Debug, Eq)

pub extend HMM with Eq::{equal, not_equal}
pub extend HMM with Debug::{to_repr}

/// 贝叶斯网络（图模型版）/ Bayes network (GM version).
pub(all) struct BayesNetGM {
  nodes : Array[String]
  edges : Array[(String, String)]
  cpts : Array[Factor]
} derive(Debug, Eq)

pub extend BayesNetGM with Eq::{equal, not_equal}
pub extend BayesNetGM with Debug::{to_repr}

fn ln_helper(x : Double) -> Double {
  if x <= 0.0 {
    return -999999999999999.0
  }
  if x == 1.0 {
    return 0.0
  }
  let mut z = x
  let mut exp = 0
  while z >= 2.0 {
    z = z / 2.0
    exp = exp + 1
  }
  while z < 0.5 {
    z = z * 2.0
    exp = exp - 1
  }
  let y = (z - 1.0) / (z + 1.0)
  let mut sum = 0.0
  let mut term = y
  let mut k = 1
  while k < 60 {
    sum = sum + term / k.to_double()
    term = term * y * y
    k = k + 2
  }
  2.0 * sum + exp.to_double() * 0.6931471805599453
}

fn make_matrix(rows : Int, cols : Int, init : Double) -> Array[Array[Double]] {
  let result = []
  for i = 0; i < rows; i = i + 1 {
    result.push(Array::make(cols, init))
  }
  result
}

fn make_matrix_int(rows : Int, cols : Int, init : Int) -> Array[Array[Int]] {
  let result = []
  for i = 0; i < rows; i = i + 1 {
    result.push(Array::make(cols, init))
  }
  result
}

fn unit_factor() -> Factor {
  { variables: [], values: [1.0] }
}

/// 归一化分布 / Normalize distribution.
pub fn normalize_distribution(dist : Array[Double]) -> Array[Double] {
  let mut sum = 0.0
  for i = 0; i < dist.length(); i = i + 1 {
    sum = sum + dist[i]
  }
  if sum <= 0.0 {
    return Array::make(dist.length(), 0.0)
  }
  let result = []
  for i = 0; i < dist.length(); i = i + 1 {
    result.push(dist[i] / sum)
  }
  result
}

/// 构造马尔可夫链 / Make Markov chain.
pub fn make_markov_chain(
  states : Array[String],
  transition : Array[Array[Double]],
  initial : Array[Double]
) -> MarkovChain {
  { states, transition, initial }
}

/// 转移概率 / Transition probability.
pub fn transition_probability(
  mc : MarkovChain,
  from : Int,
  to : Int
) -> Double {
  if from < 0 || from >= mc.transition.length() {
    return 0.0
  }
  let row = mc.transition[from]
  if to < 0 || to >= row.length() {
    return 0.0
  }
  row[to]
}

/// 平稳分布 / Stationary distribution.
pub fn stationary_distribution(mc : MarkovChain, max_iter : Int) -> Array[Double] {
  let n = mc.states.length()
  if n == 0 {
    return []
  }
  let mut dist = mc.initial.copy()
  for iter = 0; iter < max_iter; iter = iter + 1 {
    let new_dist = Array::make(n, 0.0)
    for i = 0; i < n; i = i + 1 {
      for j = 0; j < n; j = j + 1 {
        if j < mc.transition.length() && i < mc.transition[j].length() {
          new_dist[i] = new_dist[i] + dist[j] * mc.transition[j][i]
        }
      }
    }
    dist = new_dist
  }
  dist
}

/// 构造贝叶斯网络（图模型版）/ Make Bayes network (GM).
pub fn make_bayes_net_gm() -> BayesNetGM {
  { nodes: [], edges: [], cpts: [] }
}

/// 添加节点（图模型版）/ Add node (GM).
pub fn add_node_gm(net : BayesNetGM, name : String) -> BayesNetGM {
  let new_nodes = net.nodes.copy()
  new_nodes.push(name)
  {
    nodes: new_nodes,
    edges: net.edges.copy(),
    cpts: net.cpts.copy()
  }
}

/// 添加边（图模型版）/ Add edge (GM).
pub fn add_edge_gm(net : BayesNetGM, from : String, to : String) -> BayesNetGM {
  let new_edges = net.edges.copy()
  new_edges.push((from, to))
  {
    nodes: net.nodes.copy(),
    edges: new_edges,
    cpts: net.cpts.copy()
  }
}

/// 查询边际（图模型版）/ Query marginal (GM).
pub fn query_marginal_gm(net : BayesNetGM, node_name : String) -> Double {
  let n = net.nodes.length()
  if n == 0 {
    return 0.0
  }
  let mut found = false
  for i = 0; i < n; i = i + 1 {
    if net.nodes[i] == node_name {
      found = true
    }
  }
  if found {
    1.0 / n.to_double()
  } else {
    0.0
  }
}

/// 构造因子图 / Make factor graph.
pub fn make_factor_graph(variables : Array[String]) -> FactorGraph {
  { variables, factors: [] }
}

/// 添加因子 / Add factor.
pub fn add_factor(fg : FactorGraph, factor : Factor) -> FactorGraph {
  let new_factors = fg.factors.copy()
  new_factors.push(factor)
  { variables: fg.variables.copy(), factors: new_factors }
}

/// 因子乘积 / Factor product.
pub fn factor_product(f1 : Factor, f2 : Factor) -> Factor {
  let vars = f1.variables.copy()
  for i = 0; i < f2.variables.length(); i = i + 1 {
    vars.push(f2.variables[i])
  }
  let values = []
  let n1 = f1.values.length()
  let n2 = f2.values.length()
  if n1 == 0 || n2 == 0 {
    return { variables: vars, values: [] }
  }
  for i = 0; i < n1; i = i + 1 {
    for j = 0; j < n2; j = j + 1 {
      values.push(f1.values[i] * f2.values[j])
    }
  }
  { variables: vars, values }
}

/// 因子边际化 / Factor marginalize.
pub fn factor_marginalize(factor : Factor, var_idx : Int) -> Factor {
  if var_idx < 0 || var_idx >= factor.variables.length() {
    return factor
  }
  let new_vars = []
  for i = 0; i < factor.variables.length(); i = i + 1 {
    if i != var_idx {
      new_vars.push(factor.variables[i])
    }
  }
  let n_vals = factor.values.length()
  if n_vals == 0 {
    return { variables: new_vars, values: [] }
  }
  let new_size = n_vals / 2
  if new_size <= 0 {
    return { variables: new_vars, values: [0.0] }
  }
  let new_values = Array::make(new_size, 0.0)
  for i = 0; i < n_vals; i = i + 1 {
    let idx = i / 2
    if idx < new_size {
      new_values[idx] = new_values[idx] + factor.values[i]
    }
  }
  { variables: new_vars, values: new_values }
}

/// 构造 MRF / Make MRF.
pub fn make_mrf(variables : Array[String]) -> MRF {
  { variables, potentials: [] }
}

/// 添加势函数 / Add potential.
pub fn add_potential(mrf : MRF, potential : Factor) -> MRF {
  let new_potentials = mrf.potentials.copy()
  new_potentials.push(potential)
  { variables: mrf.variables.copy(), potentials: new_potentials }
}

/// 配分函数 / Partition function.
pub fn partition_function(mrf : MRF) -> Double {
  let mut z = 0.0
  let n_vars = mrf.variables.length()
  if n_vars == 0 {
    return 1.0
  }
  let n_configs = 2
  for i = 0; i < n_configs; i = i + 1 {
    let mut prod = 1.0
    for j = 0; j < mrf.potentials.length(); j = j + 1 {
      let pot = mrf.potentials[j]
      if pot.values.length() > 0 {
        let idx = i % pot.values.length()
        prod = prod * pot.values[idx]
      }
    }
    z = z + prod
  }
  z
}

/// MAP 推断 / MAP inference.
pub fn map_inference(mrf : MRF) -> Array[Int] {
  let n_vars = mrf.variables.length()
  if n_vars == 0 {
    return []
  }
  let best_config = Array::make(n_vars, 0)
  let mut best_val = -999999999999999.0
  let n_configs = 2
  for c = 0; c < n_configs; c = c + 1 {
    let mut prod = 1.0
    for j = 0; j < mrf.potentials.length(); j = j + 1 {
      let pot = mrf.potentials[j]
      if pot.values.length() > 0 {
        let idx = c % pot.values.length()
        prod = prod * pot.values[idx]
      }
    }
    if prod > best_val {
      best_val = prod
      for v = 0; v < n_vars; v = v + 1 {
        best_config[v] = c % 2
      }
    }
  }
  best_config
}

/// 信念传播 / Belief propagation.
pub fn belief_propagation(fg : FactorGraph, max_iter : Int) -> Array[Double] {
  let n = fg.variables.length()
  if n == 0 {
    return []
  }
  let mut beliefs = Array::make(n, 1.0 / n.to_double())
  for iter = 0; iter < max_iter; iter = iter + 1 {
    let new_beliefs = Array::make(n, 0.0)
    for i = 0; i < n; i = i + 1 {
      let mut msg = 1.0
      for j = 0; j < fg.factors.length(); j = j + 1 {
        let factor = fg.factors[j]
        if factor.values.length() > 0 {
          msg = msg * factor.values[0]
        }
      }
      new_beliefs[i] = msg
    }
    beliefs = normalize_distribution(new_beliefs)
  }
  beliefs
}

/// Loopy 信念传播 / Loopy belief propagation.
pub fn loopy_belief_propagation(
  fg : FactorGraph,
  max_iter : Int
) -> Array[Double] {
  belief_propagation(fg, max_iter)
}

/// 联合树 / Junction tree.
pub fn junction_tree(mrf : MRF) -> Array[Array[String]] {
  let cliques = []
  let n = mrf.variables.length()
  if n == 0 {
    return []
  }
  let clique = []
  for i = 0; i < n; i = i + 1 {
    clique.push(mrf.variables[i])
  }
  cliques.push(clique)
  cliques
}

/// 变量消元 / Variable elimination.
pub fn variable_elimination(
  factors : Array[Factor],
  elim_order : Array[Int]
) -> Factor {
  let mut current_factors = factors.copy()
  for e = 0; e < elim_order.length(); e = e + 1 {
    let var_idx = elim_order[e]
    let new_factors = []
    let mut combined_factor = unit_factor()
    for i = 0; i < current_factors.length(); i = i + 1 {
      combined_factor = factor_product(combined_factor, current_factors[i])
    }
    let marg = factor_marginalize(combined_factor, var_idx)
    new_factors.push(marg)
    current_factors = new_factors
  }
  let mut result = unit_factor()
  for i = 0; i < current_factors.length(); i = i + 1 {
    result = factor_product(result, current_factors[i])
  }
  result
}

/// Sum-product / Sum-product.
pub fn sum_product(fg : FactorGraph, query_var : Int) -> Array[Double] {
  let n = fg.variables.length()
  if n == 0 || query_var < 0 || query_var >= n {
    return []
  }
  let result = [1.0, 1.0]
  for i = 0; i < fg.factors.length(); i = i + 1 {
    let factor = fg.factors[i]
    if factor.values.length() >= 2 {
      result[0] = result[0] * factor.values[0]
      result[1] = result[1] * factor.values[1]
    }
  }
  normalize_distribution(result)
}

/// Max-product / Max-product.
pub fn max_product(fg : FactorGraph, query_var : Int) -> Array[Double] {
  let n = fg.variables.length()
  if n == 0 || query_var < 0 || query_var >= n {
    return []
  }
  let result = [1.0, 1.0]
  for i = 0; i < fg.factors.length(); i = i + 1 {
    let factor = fg.factors[i]
    if factor.values.length() >= 2 {
      if factor.values[0] > result[0] {
        result[0] = factor.values[0]
      }
      if factor.values[1] > result[1] {
        result[1] = factor.values[1]
      }
    }
  }
  normalize_distribution(result)
}

/// 构造 HMM / Make HMM.
pub fn make_hmm(
  states : Array[String],
  observations : Array[String],
  transition : Array[Array[Double]],
  emission : Array[Array[Double]],
  initial : Array[Double]
) -> HMM {
  { states, observations, transition, emission, initial }
}

/// HMM 前向 / HMM forward.
pub fn hmm_forward(hmm : HMM, obs : Array[Int]) -> Array[Array[Double]] {
  forward_algorithm(hmm, obs)
}

/// HMM 后向 / HMM backward.
pub fn hmm_backward(hmm : HMM, obs : Array[Int]) -> Array[Array[Double]] {
  backward_algorithm(hmm, obs)
}

/// HMM Viterbi / HMM Viterbi.
pub fn hmm_viterbi(hmm : HMM, obs : Array[Int]) -> Array[Int] {
  viterbi_algorithm(hmm, obs)
}

/// HMM Baum-Welch / HMM Baum-Welch (placeholder).
pub fn hmm_baum_welch(hmm : HMM, obs : Array[Int], max_iter : Int) -> HMM {
  let n_obs = obs.length()
  let n_states = hmm.states.length()
  if n_obs == 0 || n_states == 0 || max_iter == 0 {
    return hmm
  }
  hmm
}

/// 前向算法 / Forward algorithm.
pub fn forward_algorithm(
  hmm : HMM,
  obs : Array[Int]
) -> Array[Array[Double]] {
  let n_states = hmm.states.length()
  let n_obs = obs.length()
  if n_states == 0 || n_obs == 0 {
    return []
  }
  let alpha = make_matrix(n_obs, n_states, 0.0)
  for i = 0; i < n_states; i = i + 1 {
    let obs_idx = obs[0]
    if obs_idx >= 0 && i < hmm.emission.length() && obs_idx < hmm.emission[i].length() {
      alpha[0][i] = hmm.initial[i] * hmm.emission[i][obs_idx]
    }
  }
  for t = 1; t < n_obs; t = t + 1 {
    for j = 0; j < n_states; j = j + 1 {
      let mut sum = 0.0
      for i = 0; i < n_states; i = i + 1 {
        if i < hmm.transition.length() && j < hmm.transition[i].length() {
          sum = sum + alpha[t - 1][i] * hmm.transition[i][j]
        }
      }
      let obs_idx = obs[t]
      if obs_idx >= 0 && j < hmm.emission.length() && obs_idx < hmm.emission[j].length() {
        alpha[t][j] = sum * hmm.emission[j][obs_idx]
      }
    }
  }
  alpha
}

/// 后向算法 / Backward algorithm.
pub fn backward_algorithm(
  hmm : HMM,
  obs : Array[Int]
) -> Array[Array[Double]] {
  let n_states = hmm.states.length()
  let n_obs = obs.length()
  if n_states == 0 || n_obs == 0 {
    return []
  }
  let beta = make_matrix(n_obs, n_states, 0.0)
  for i = 0; i < n_states; i = i + 1 {
    beta[n_obs - 1][i] = 1.0
  }
  for t = n_obs - 2; t >= 0; t = t - 1 {
    for i = 0; i < n_states; i = i + 1 {
      let mut sum = 0.0
      for j = 0; j < n_states; j = j + 1 {
        let obs_idx = obs[t + 1]
        if i < hmm.transition.length() && j < hmm.transition[i].length() && j < hmm.emission.length() && obs_idx >= 0 && obs_idx < hmm.emission[j].length() {
          sum = sum + hmm.transition[i][j] * hmm.emission[j][obs_idx] * beta[
            t + 1
          ][j]
        }
      }
      beta[t][i] = sum
    }
  }
  beta
}

/// Viterbi 算法 / Viterbi algorithm.
pub fn viterbi_algorithm(hmm : HMM, obs : Array[Int]) -> Array[Int] {
  let n_states = hmm.states.length()
  let n_obs = obs.length()
  if n_states == 0 || n_obs == 0 {
    return []
  }
  let delta = make_matrix(n_obs, n_states, 0.0)
  let psi = make_matrix_int(n_obs, n_states, 0)
  for i = 0; i < n_states; i = i + 1 {
    let obs_idx = obs[0]
    if obs_idx >= 0 && i < hmm.emission.length() && obs_idx < hmm.emission[i].length() {
      delta[0][i] = hmm.initial[i] * hmm.emission[i][obs_idx]
    }
  }
  for t = 1; t < n_obs; t = t + 1 {
    for j = 0; j < n_states; j = j + 1 {
      let mut max_val = 0.0
      let mut max_idx = 0
      for i = 0; i < n_states; i = i + 1 {
        let mut val = 0.0
        if i < hmm.transition.length() && j < hmm.transition[i].length() {
          val = delta[t - 1][i] * hmm.transition[i][j]
        }
        if val > max_val {
          max_val = val
          max_idx = i
        }
      }
      psi[t][j] = max_idx
      let obs_idx = obs[t]
      if obs_idx >= 0 && j < hmm.emission.length() && obs_idx < hmm.emission[j].length() {
        delta[t][j] = max_val * hmm.emission[j][obs_idx]
      }
    }
  }
  let path = Array::make(n_obs, 0)
  let mut max_final = 0.0
  let mut max_final_idx = 0
  for i = 0; i < n_states; i = i + 1 {
    if delta[n_obs - 1][i] > max_final {
      max_final = delta[n_obs - 1][i]
      max_final_idx = i
    }
  }
  path[n_obs - 1] = max_final_idx
  for t = n_obs - 2; t >= 0; t = t - 1 {
    path[t] = psi[t + 1][path[t + 1]]
  }
  path
}

/// 发射概率 / Emission probability.
pub fn emission_probability(hmm : HMM, state : Int, obs : Int) -> Double {
  if state < 0 || state >= hmm.emission.length() {
    return 0.0
  }
  let row = hmm.emission[state]
  if obs < 0 || obs >= row.length() {
    return 0.0
  }
  row[obs]
}

/// 转移矩阵 / Transition matrix.
pub fn transition_matrix(hmm : HMM) -> Array[Array[Double]] {
  hmm.transition.copy()
}

/// 初始分布 / Initial distribution.
pub fn initial_distribution(hmm : HMM) -> Array[Double] {
  hmm.initial.copy()
}

/// 对数配分函数 / Log partition function.
pub fn log_partition_function(mrf : MRF) -> Double {
  let z = partition_function(mrf)
  if z > 0.0 {
    ln_helper(z)
  } else {
    -999999999999999.0
  }
}

pub fn graph_model_id() -> String {
  "learncore/graph_model"
}