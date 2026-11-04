///|
/// # learncore/bayesian 贝叶斯推断 / Bayesian Inference
///
/// 先验/后验/贝叶斯网络/MCMC。架构 §4.3.5 B。
/// S12.3 新建：贝叶斯推断算子。
///
/// # Bayesian inference operators
///
/// Prior/posterior/Bayes network/MCMC. See architecture §4.3.5 B.

///|
/// Beta 分布 / Beta distribution.
pub(all) struct BetaDist {
  alpha : Double
  beta : Double
} derive(Debug, Eq)

///|
pub extend BetaDist with Eq::{equal, not_equal}

///|
pub extend BetaDist with Debug::{to_repr}

///|
/// Gamma 分布 / Gamma distribution.
pub(all) struct GammaDist {
  shape : Double
  rate : Double
} derive(Debug, Eq)

///|
pub extend GammaDist with Eq::{equal, not_equal}

///|
pub extend GammaDist with Debug::{to_repr}

///|
/// 正态分布 / Normal distribution.
pub(all) struct NormalDist {
  mean : Double
  variance : Double
} derive(Debug, Eq)

///|
pub extend NormalDist with Eq::{equal, not_equal}

///|
pub extend NormalDist with Debug::{to_repr}

///|
/// Dirichlet 分布 / Dirichlet distribution.
pub(all) struct DirichletDist {
  alphas : Array[Double]
} derive(Debug, Eq)

///|
pub extend DirichletDist with Eq::{equal, not_equal}

///|
pub extend DirichletDist with Debug::{to_repr}

///|
/// 贝叶斯网络节点 / Bayes network node.
pub(all) struct BayesNode {
  name : String
  parents : Array[String]
  cpt : Array[Double]
} derive(Debug, Eq)

///|
pub extend BayesNode with Eq::{equal, not_equal}

///|
pub extend BayesNode with Debug::{to_repr}

///|
/// 贝叶斯网络 / Bayes network.
pub(all) struct BayesNet {
  nodes : Array[BayesNode]
  edges : Array[(String, String)]
} derive(Debug, Eq)

///|
pub extend BayesNet with Eq::{equal, not_equal}

///|
pub extend BayesNet with Debug::{to_repr}

///|
/// 共轭后验 / Conjugate posterior.
pub(all) struct ConjugatePosterior {
  prior_type : String
  params : Array[Double]
  posterior_params : Array[Double]
} derive(Debug, Eq)

///|
pub extend ConjugatePosterior with Eq::{equal, not_equal}

///|
pub extend ConjugatePosterior with Debug::{to_repr}

///|
/// MCMC 样本 / MCMC sample.
pub(all) struct McmcSample {
  state : Double
  log_prob : Double
  accepted : Bool
} derive(Debug, Eq)

///|
pub extend McmcSample with Eq::{equal, not_equal}

///|
pub extend McmcSample with Debug::{to_repr}

///|
/// 自然对数 / Natural logarithm.
pub fn bayesian_ln_(x : Double) -> Double {
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

///|
/// 指数函数 / Exponential function.
pub fn bayesian_exp_(x : Double) -> Double {
  if x > 700.0 {
    return 999999999999999.0
  }
  if x < -700.0 {
    return 0.0
  }
  let mut y = x
  let mut k = 0
  while y > 1.0 || y < -1.0 {
    y = y / 2.0
    k = k + 1
  }
  let mut sum = 1.0
  let mut term = 1.0
  for n = 1; n < 30; n = n + 1 {
    term = term * y / n.to_double()
    sum = sum + term
  }
  for i = 0; i < k; i = i + 1 {
    sum = sum * sum
  }
  sum
}

///|
/// 平方根 / Square root (Newton's method).
pub fn bayesian_sqrt_(x : Double) -> Double {
  if x <= 0.0 {
    return 0.0
  }
  let mut guess = x
  if x < 1.0 {
    guess = 1.0
  }
  let mut i = 0
  let mut done = false
  while i < 100 && !done {
    let next = 0.5 * (guess + x / guess)
    let diff = next - guess
    if diff < 0.000000000000001 && diff > -0.000000000000001 {
      guess = next
      done = true
    } else {
      guess = next
    }
    i = i + 1
  }
  guess
}

///|
fn bayesian_lgamma_(x : Double) -> Double {
  if x < 1.0 {
    return bayesian_lgamma_(x + 1.0) - bayesian_ln_(x)
  }
  let x2 = x * x
  let ser = 1.0 +
    1.0 / (12.0 * x) +
    1.0 / (288.0 * x2) -
    139.0 / (51840.0 * x2 * x)
  (x - 0.5) * bayesian_ln_(x) - x + 0.9189385332046727 + bayesian_ln_(ser)
}

///|
fn bayesian_lbeta_(a : Double, b : Double) -> Double {
  bayesian_lgamma_(a) + bayesian_lgamma_(b) - bayesian_lgamma_(a + b)
}

///|
fn bayesian_ln_factorial(n : Int32) -> Double {
  if n <= 1 {
    return 0.0
  }
  bayesian_lgamma_(n.to_double() + 1.0)
}

///|
fn bayesian_ln_binomial_coef(n : Int32, k : Int32) -> Double {
  bayesian_lgamma_(n.to_double() + 1.0) -
  bayesian_lgamma_(k.to_double() + 1.0) -
  bayesian_lgamma_((n - k).to_double() + 1.0)
}

///|
/// Beta 先验 / Beta prior.
pub fn bayesian_beta_prior(theta : Double, alpha : Double, beta : Double) -> Double {
  if theta <= 0.0 || theta >= 1.0 {
    return 0.0
  }
  let logp = (alpha - 1.0) * bayesian_ln_(theta) +
    (beta - 1.0) * bayesian_ln_(1.0 - theta) -
    bayesian_lbeta_(alpha, beta)
  bayesian_exp_(logp)
}

///|
/// Beta 后验 / Beta posterior.
pub fn bayesian_beta_posterior(
  theta : Double,
  alpha : Double,
  beta : Double,
  successes : Int32,
  failures : Int32,
) -> Double {
  let post_alpha = alpha + successes.to_double()
  let post_beta = beta + failures.to_double()
  bayesian_beta_prior(theta, post_alpha, post_beta)
}

///|
/// Beta 更新 / Beta update.
pub fn bayesian_beta_update(
  prior : BetaDist,
  successes : Int32,
  failures : Int32,
) -> BetaDist {
  {
    alpha: prior.alpha + successes.to_double(),
    beta: prior.beta + failures.to_double(),
  }
}

///|
/// Gamma 先验 / Gamma prior.
pub fn bayesian_gamma_prior(x : Double, shape : Double, rate : Double) -> Double {
  if x <= 0.0 {
    return 0.0
  }
  let logp = shape * bayesian_ln_(rate) -
    bayesian_lgamma_(shape) +
    (shape - 1.0) * bayesian_ln_(x) -
    rate * x
  bayesian_exp_(logp)
}

///|
/// Gamma 后验 / Gamma posterior.
pub fn bayesian_gamma_posterior(
  x : Double,
  shape : Double,
  rate : Double,
  sum_obs : Double,
  n_obs : Int32,
) -> Double {
  let post_shape = shape + sum_obs
  let post_rate = rate + n_obs.to_double()
  bayesian_gamma_prior(x, post_shape, post_rate)
}

///|
/// Gamma 更新 / Gamma update.
pub fn bayesian_gamma_update(
  prior : GammaDist,
  sum_obs : Double,
  n_obs : Int32,
) -> GammaDist {
  { shape: prior.shape + sum_obs, rate: prior.rate + n_obs.to_double(), }
}

///|
/// 正态先验 / Normal prior.
pub fn bayesian_normal_prior(theta : Double, mean : Double, variance : Double) -> Double {
  if variance <= 0.0 {
    return 0.0
  }
  let diff = theta - mean
  let logp = -0.5 * bayesian_ln_(2.0 * 3.14159265358979323846 * variance) -
    diff * diff / (2.0 * variance)
  bayesian_exp_(logp)
}

///|
/// 正态后验 / Normal posterior.
pub fn bayesian_normal_posterior(
  theta : Double,
  prior_mean : Double,
  prior_variance : Double,
  data_mean : Double,
  data_variance : Double,
  n : Int32,
) -> Double {
  if n == 0 {
    return bayesian_normal_prior(theta, prior_mean, prior_variance)
  }
  let nv = n.to_double()
  let post_var = 1.0 / (1.0 / prior_variance + nv / data_variance)
  let post_mean = post_var *
    (prior_mean / prior_variance + nv * data_mean / data_variance)
  bayesian_normal_prior(theta, post_mean, post_var)
}

///|
/// 正态更新 / Normal update.
pub fn bayesian_normal_update(
  prior : NormalDist,
  data_mean : Double,
  data_variance : Double,
  n : Int32,
) -> NormalDist {
  if n == 0 {
    return prior
  }
  let nv = n.to_double()
  let post_var = 1.0 / (1.0 / prior.variance + nv / data_variance)
  let post_mean = post_var *
    (prior.mean / prior.variance + nv * data_mean / data_variance)
  { mean: post_mean, variance: post_var, }
}

///|
/// Dirichlet 先验 / Dirichlet prior.
pub fn bayesian_dirichlet_prior(
  thetas : Array[Double],
  alphas : Array[Double],
) -> Double {
  let n = thetas.length()
  if n != alphas.length() || n == 0 {
    return 0.0
  }
  let mut logp = 0.0
  let mut sum_alpha = 0.0
  for i = 0; i < n; i = i + 1 {
    if thetas[i] <= 0.0 {
      return 0.0
    }
    logp = logp + (alphas[i] - 1.0) * bayesian_ln_(thetas[i]) - bayesian_lgamma_(alphas[i])
    sum_alpha = sum_alpha + alphas[i]
  }
  logp = logp + bayesian_lgamma_(sum_alpha)
  bayesian_exp_(logp)
}

///|
/// Dirichlet 后验 / Dirichlet posterior.
pub fn bayesian_dirichlet_posterior(
  thetas : Array[Double],
  alphas : Array[Double],
  counts : Array[Double],
) -> Double {
  let n = alphas.length()
  if n != counts.length() {
    return 0.0
  }
  let post_alphas = []
  for i = 0; i < n; i = i + 1 {
    post_alphas.push(alphas[i] + counts[i])
  }
  bayesian_dirichlet_prior(thetas, post_alphas)
}

///|
/// Bernoulli 似然 / Bernoulli likelihood.
pub fn bayesian_bernoulli_likelihood(data : Array[Int32], theta : Double) -> Double {
  if theta < 0.0 || theta > 1.0 {
    return 0.0
  }
  let mut logp = 0.0
  for i = 0; i < data.length(); i = i + 1 {
    if data[i] == 1 {
      logp = logp + bayesian_ln_(theta)
    } else {
      logp = logp + bayesian_ln_(1.0 - theta)
    }
  }
  bayesian_exp_(logp)
}

///|
/// Binomial 似然 / Binomial likelihood.
pub fn bayesian_binomial_likelihood(k : Int32, n : Int32, theta : Double) -> Double {
  if theta < 0.0 || theta > 1.0 || k < 0 || n < 0 || k > n {
    return 0.0
  }
  let logp = bayesian_ln_binomial_coef(n, k) +
    k.to_double() * bayesian_ln_(theta) +
    (n - k).to_double() * bayesian_ln_(1.0 - theta)
  bayesian_exp_(logp)
}

///|
/// Poisson 似然 / Poisson likelihood.
pub fn bayesian_poisson_likelihood(data : Array[Int32], lambda : Double) -> Double {
  if lambda <= 0.0 {
    return 0.0
  }
  let mut logp = 0.0
  for i = 0; i < data.length(); i = i + 1 {
    let ki = data[i].to_double()
    logp = logp + ki * bayesian_ln_(lambda) - lambda - bayesian_ln_factorial(data[i])
  }
  bayesian_exp_(logp)
}

///|
/// Exponential 似然 / Exponential likelihood.
pub fn bayesian_exponential_likelihood(data : Array[Double], rate : Double) -> Double {
  if rate <= 0.0 {
    return 0.0
  }
  let mut sum = 0.0
  for i = 0; i < data.length(); i = i + 1 {
    if data[i] < 0.0 {
      return 0.0
    }
    sum = sum + data[i]
  }
  let n = data.length().to_double()
  bayesian_exp_(n * bayesian_ln_(rate) - rate * sum)
}

///|
/// 先验概率 / Prior probability (generic).
pub fn bayesian_prior(theta : Double, dist_params : Array[Double]) -> Double {
  if dist_params.length() >= 2 {
    bayesian_beta_prior(theta, dist_params[0], dist_params[1])
  } else {
    0.0
  }
}

///|
/// 似然函数 / Likelihood function (generic).
pub fn bayesian_likelihood(data : Array[Double], theta : Double) -> Double {
  let mut prod = 1.0
  for i = 0; i < data.length(); i = i + 1 {
    if theta > 0.0 && theta < 1.0 {
      if data[i] > 0.5 {
        prod = prod * theta
      } else {
        prod = prod * (1.0 - theta)
      }
    }
  }
  prod
}

///|
/// 边际似然 / Marginal likelihood.
pub fn bayesian_marginal_likelihood(
  data : Array[Double],
  prior_params : Array[Double],
) -> Double {
  let mut sum = 0.0
  let steps = 100
  for i = 0; i < steps; i = i + 1 {
    let theta = (i.to_double() + 0.5) / steps.to_double()
    sum = sum + bayesian_prior(theta, prior_params) * bayesian_likelihood(data, theta)
  }
  sum / steps.to_double()
}

///|
/// 后验概率 / Posterior probability.
pub fn bayesian_posterior(
  theta : Double,
  data : Array[Double],
  prior_params : Array[Double],
) -> Double {
  let pri = bayesian_prior(theta, prior_params)
  let lik = bayesian_likelihood(data, theta)
  let marg = bayesian_marginal_likelihood(data, prior_params)
  if marg > 0.0 {
    pri * lik / marg
  } else {
    0.0
  }
}

///|
/// 贝叶斯更新 / Bayes update.
pub fn bayesian_bayes_update(
  prior_params : Array[Double],
  data : Array[Double],
) -> Array[Double] {
  if prior_params.length() < 2 {
    return prior_params
  }
  let mut successes = 0
  let mut failures = 0
  for i = 0; i < data.length(); i = i + 1 {
    if data[i] > 0.5 {
      successes = successes + 1
    } else {
      failures = failures + 1
    }
  }
  let post_alpha = prior_params[0] + successes.to_double()
  let post_beta = prior_params[1] + failures.to_double()
  [post_alpha, post_beta]
}

///|
/// 贝叶斯推断 / Bayes inference.
pub fn bayesian_bayes_infer(
  data : Array[Double],
  prior_params : Array[Double],
) -> Double {
  let post_params = bayesian_bayes_update(prior_params, data)
  if post_params.length() >= 2 {
    post_params[0] / (post_params[0] + post_params[1])
  } else {
    0.0
  }
}

///|
/// 证据 / Evidence.
pub fn bayesian_evidence(data : Array[Double], prior_params : Array[Double]) -> Double {
  bayesian_marginal_likelihood(data, prior_params)
}

///|
/// 构造贝叶斯网络 / Make Bayes network.
pub fn bayesian_make_bayes_net() -> BayesNet {
  { nodes: [], edges: [], }
}

///|
/// 添加节点 / Add node.
pub fn bayesian_add_node(net : BayesNet, node : BayesNode) -> BayesNet {
  let new_nodes = net.nodes.copy()
  new_nodes.push(node)
  { nodes: new_nodes, edges: net.edges.copy(), }
}

///|
/// 添加边 / Add edge.
pub fn bayesian_add_edge(net : BayesNet, from : String, to : String) -> BayesNet {
  let new_edges = net.edges.copy()
  new_edges.push((from, to))
  { nodes: net.nodes.copy(), edges: new_edges, }
}

///|
/// 查询边际 / Query marginal.
pub fn bayesian_query_marginal(net : BayesNet, node_name : String) -> Double {
  for i = 0; i < net.nodes.length(); i = i + 1 {
    if net.nodes[i].name == node_name {
      let cpt = net.nodes[i].cpt
      if cpt.length() > 0 {
        let mut sum = 0.0
        for j = 0; j < cpt.length(); j = j + 1 {
          sum = sum + cpt[j]
        }
        return sum / cpt.length().to_double()
      }
    }
  }
  0.0
}

///|
/// 查询联合 / Query joint.
pub fn bayesian_query_joint(net : BayesNet, node_names : Array[String]) -> Double {
  let mut prod = 1.0
  for i = 0; i < node_names.length(); i = i + 1 {
    prod = prod * bayesian_query_marginal(net, node_names[i])
  }
  prod
}

///|
/// 查询条件 / Query conditional.
pub fn bayesian_query_conditional(
  net : BayesNet,
  target : String,
  evidence_nodes : Array[String],
) -> Double {
  let all_nodes = [target]
  for i = 0; i < evidence_nodes.length(); i = i + 1 {
    all_nodes.push(evidence_nodes[i])
  }
  let joint = bayesian_query_joint(net, all_nodes)
  let marg = bayesian_query_joint(net, evidence_nodes)
  if marg > 0.0 {
    joint / marg
  } else {
    0.0
  }
}

///|
/// 前向采样 / Forward sampling.
pub fn bayesian_forward_sampling(
  net : BayesNet,
  n_samples : Int32,
) -> Array[Array[Double]] {
  let result = []
  for s = 0; s < n_samples; s = s + 1 {
    let sample = []
    for i = 0; i < net.nodes.length(); i = i + 1 {
      let cpt = net.nodes[i].cpt
      if cpt.length() > 0 {
        sample.push(cpt[0])
      } else {
        sample.push(0.5)
      }
    }
    result.push(sample)
  }
  result
}

///|
/// 拒绝采样 / Rejection sampling.
pub fn bayesian_rejection_sampling(
  net : BayesNet,
  n_samples : Int32,
  constraint : (Array[Double]) -> Bool,
) -> Array[Array[Double]] {
  let result = []
  let mut attempts = 0
  let max_attempts = n_samples * 10
  while result.length() < n_samples && attempts < max_attempts {
    let samples = bayesian_forward_sampling(net, 1)
    if samples.length() > 0 && constraint(samples[0]) {
      result.push(samples[0])
    }
    attempts = attempts + 1
  }
  result
}

///|
/// 接受概率 / Acceptance probability.
pub fn bayesian_acceptance_probability(
  current_log : Double,
  proposed_log : Double,
) -> Double {
  let log_ratio = proposed_log - current_log
  if log_ratio >= 0.0 {
    1.0
  } else {
    bayesian_exp_(log_ratio)
  }
}

///|
/// Metropolis 步 / Metropolis step.
pub fn bayesian_metropolis_step(
  current : Double,
  log_target : (Double) -> Double,
  proposal_std : Double,
) -> McmcSample {
  let proposed = current + proposal_std
  let current_log = log_target(current)
  let proposed_log = log_target(proposed)
  let accept_prob = bayesian_acceptance_probability(current_log, proposed_log)
  if accept_prob >= 0.5 {
    { state: proposed, log_prob: proposed_log, accepted: true, }
  } else {
    { state: current, log_prob: current_log, accepted: false, }
  }
}

///|
/// Gibbs 步 / Gibbs step.
pub fn bayesian_gibbs_step(
  current : Array[Double],
  idx : Int32,
  conditional_dist : (Array[Double], Int32) -> Double,
) -> Array[Double] {
  if idx < 0 || idx >= current.length() {
    return current
  }
  let new_state = current.copy()
  new_state[idx] = conditional_dist(current, idx)
  new_state
}

///|
/// MH 采样 / Metropolis-Hastings sampling.
pub fn bayesian_mh_sample(
  initial : Double,
  log_target : (Double) -> Double,
  proposal_std : Double,
  n_samples : Int32,
  burn_in : Int32,
) -> Array[Double] {
  let samples = []
  let mut current = initial
  let total = n_samples + burn_in
  for i = 0; i < total; i = i + 1 {
    let step = bayesian_metropolis_step(current, log_target, proposal_std)
    current = step.state
    if i >= burn_in {
      samples.push(current)
    }
  }
  samples
}

///|
/// 贝叶斯因子 / Bayes factor.
pub fn bayesian_bayes_factor(
  data : Array[Double],
  model1_params : Array[Double],
  model2_params : Array[Double],
) -> Double {
  let m1 = bayesian_marginal_likelihood(data, model1_params)
  let m2 = bayesian_marginal_likelihood(data, model2_params)
  if m2 > 0.0 {
    m1 / m2
  } else {
    0.0
  }
}

///|
/// 后验赔率 / Posterior odds.
pub fn bayesian_posterior_odds(
  data : Array[Double],
  model1_params : Array[Double],
  model2_params : Array[Double],
  prior_odds : Double,
) -> Double {
  bayesian_bayes_factor(data, model1_params, model2_params) * prior_odds
}

///|
/// 模型证据 / Model evidence.
pub fn bayesian_model_evidence(
  data : Array[Double],
  model_params : Array[Double],
) -> Double {
  let mut log_ev = 0.0
  for i = 0; i < data.length(); i = i + 1 {
    if model_params.length() >= 2 {
      let p = model_params[0] * data[i] + model_params[1]
      if p > 0.0 {
        log_ev = log_ev + bayesian_ln_(p)
      }
    }
  }
  bayesian_exp_(log_ev)
}

///|
/// BIC 分数 / BIC score.
pub fn bayesian_bic_score(log_lik : Double, n_params : Int32, n_data : Int32) -> Double {
  log_lik - n_params.to_double() * bayesian_ln_(n_data.to_double()) / 2.0
}

///|
/// AIC 分数 / AIC score.
pub fn bayesian_aic_score(log_lik : Double, n_params : Int32) -> Double {
  log_lik - n_params.to_double()
}

///|
/// 共轭更新 / Conjugate update.
pub fn bayesian_conjugate_update(
  prior_type : String,
  prior_params : Array[Double],
  data : Array[Double],
) -> ConjugatePosterior {
  if prior_type == "beta" {
    let post = bayesian_bayes_update(prior_params, data)
    { prior_type, params: prior_params.copy(), posterior_params: post, }
  } else if prior_type == "normal" {
    let post = bayesian_bayes_update(prior_params, data)
    { prior_type, params: prior_params.copy(), posterior_params: post, }
  } else {
    {
      prior_type,
      params: prior_params.copy(),
      posterior_params: prior_params.copy(),
    }
  }
}

///|
/// 共轭后验 / Conjugate posterior.
pub fn bayesian_conjugate_posterior(cp : ConjugatePosterior) -> Array[Double] {
  cp.posterior_params.copy()
}

///|
/// 预测 Beta / Predict with Beta.
pub fn bayesian_predict_beta(dist : BetaDist) -> Double {
  if dist.alpha + dist.beta > 0.0 {
    dist.alpha / (dist.alpha + dist.beta)
  } else {
    0.0
  }
}

///|
/// 预测正态 / Predict with Normal.
pub fn bayesian_predict_normal(dist : NormalDist) -> Double {
  dist.mean
}

///|
/// 预测 Poisson / Predict with Poisson.
pub fn bayesian_predict_poisson(lambda : Double) -> Double {
  if lambda > 0.0 {
    lambda
  } else {
    0.0
  }
}

///|
pub fn bayesian_bayesian_id() -> String {
  "learncore/bayesian"
}
