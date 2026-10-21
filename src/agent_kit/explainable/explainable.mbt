///|
/// # agent_kit/explainable 可解释 AI / Explainable AI
///
/// XAI 算子族：LIME、SHAP、Integrated Gradients、Grad-CAM、Attention 可视化、
/// 特征重要性、PDP、ICE、Anchors、反事实、决策树解释、规则提取、代理模型、ALE 等。
/// 含忠实度/单调性/完备性评估。S0.1 骨架占位，Phase 2 填充。
///
/// # Explainable AI operators
///
/// LIME, SHAP, IG, Grad-CAM, Attention, Feature Importance, PDP/ICE,
/// Anchors, Counterfactual, Decision Tree, Rule Extraction, Surrogate, ALE.

///|
///===
/// 数学辅助 / Math helpers
fn xa_lcg_next(state : Int32) -> Int32 {
  let a = 1103515245
  let c = 12345
  let m = 2147483647
  (a * state + c) % m
}

///|
fn xa_rand(state : Int32) -> (Double, Int32) {
  let next = xa_lcg_next(state)
  (next.to_double() / 2147483647.0, next)
}

///===
/// 公共类型 / Common types

///|
/// XAI 方法 / XAI method.
pub(all) enum XAIMethod {
  LIME
  SHAP
  IntegratedGradients
  GradCAM
  Attention
  FeatureImportance
  PartialDependence
  Anchors
  Counterfactual
  DecisionTree
  RuleExtraction
  Surrogate
  ALE
}

///|
/// 特征贡献 / Feature contribution.
pub struct FeatureContribution {
  feature : String
  value : Double
  contribution : Double
}

///|
/// 解释结果 / Explanation result.
pub struct Explanation {
  xai_method : XAIMethod
  base_value : Double
  prediction : Double
  contributions : Array[FeatureContribution]
  meta : String
}

///|
/// XAI 配置 / XAI config.
pub struct XAIConfig {
  xai_method : XAIMethod
  num_samples : Int32
  seed : Int32
  tolerance : Double
  baseline : Array[Double]
}

///|
/// 构造 XAI 配置 / Create XAI config.
pub fn make_xai_config(
  xai_method : XAIMethod,
  num_samples : Int32,
  seed : Int32,
  tolerance : Double,
) -> XAIConfig {
  { xai_method, num_samples, seed, tolerance, baseline: [], }
}

///|
/// 构造解释 / Create explanation.
pub fn make_explanation(
  xai_method : XAIMethod,
  base_value : Double,
  prediction : Double,
  contributions : Array[FeatureContribution],
) -> Explanation {
  { xai_method, base_value, prediction, contributions, meta: "", }
}

///|
/// 构造特征贡献 / Create feature contribution.
pub fn make_contribution(
  feature : String,
  value : Double,
  contribution : Double,
) -> FeatureContribution {
  { feature, value, contribution, }
}

///===
/// LIME

///|
/// LIME 配置 / LIME config.
pub struct LIMEConfig {
  num_samples : Int32
  kernel_width : Double
  seed : Int32
  feature_names : Array[String]
}

///|
/// 构造 LIME / Create LIME config.
pub fn make_lime(
  num_samples : Int32,
  kernel_width : Double,
  seed : Int32,
  feature_names : Array[String],
) -> LIMEConfig {
  { num_samples, kernel_width, seed, feature_names, }
}

///|
/// LIME 采样 / LIME sampling.
pub fn lime_sample(
  config : LIMEConfig,
  instance : Array[Double],
) -> Array[Array[Double]] {
  let samples : Array[Array[Double]] = []
  let mut state = config.seed
  for _ in 0..<config.num_samples {
    let s : Array[Double] = []
    for j in 0..<instance.length() {
      let (r, ns) = xa_rand(state)
      state = ns
      let perturbed = if r > 0.5 { instance[j] } else { instance[j] * 0.5 }
      s.push(perturbed)
    }
    samples.push(s)
  }
  samples
}

///|
/// LIME 局部拟合 / LIME fit local.
pub fn lime_fit_local(
  config : LIMEConfig,
  instance : Array[Double],
  predictions : Array[Double],
) -> Array[Double] {
  let n = instance.length()
  let weights : Array[Double] = []
  let mut state = config.seed
  for _ in 0..<predictions.length() {
    let (r, ns) = xa_rand(state)
    state = ns
    let d = r * config.kernel_width
    weights.push(
      @math.exp(-d * d / (config.kernel_width * config.kernel_width)),
    )
  }
  let coefs : Array[Double] = []
  for j in 0..<n {
    let mut num = 0.0
    let mut den = 0.0
    for i in 0..<predictions.length() {
      num = num + weights[i] * instance[j] * predictions[i]
      den = den + weights[i] * instance[j] * instance[j]
    }
    if @_common.abs(den) < 0.000001 {
      coefs.push(0.0)
    } else {
      coefs.push(num / den)
    }
  }
  coefs
}

///|
/// LIME 解释 / LIME explain.
pub fn lime_explain(
  config : LIMEConfig,
  instance : Array[Double],
  predict_fn : (Array[Double]) -> Double,
) -> Explanation {
  let samples = lime_sample(config, instance)
  let predictions : Array[Double] = []
  for i in 0..<samples.length() {
    predictions.push(predict_fn(samples[i]))
  }
  let coefs = lime_fit_local(config, instance, predictions)
  let contribs : Array[FeatureContribution] = []
  let base = predict_fn(instance)
  for j in 0..<coefs.length() {
    let name = if j < config.feature_names.length() {
      config.feature_names[j]
    } else {
      "f" + j.to_string()
    }
    contribs.push(make_contribution(name, instance[j], coefs[j] * instance[j]))
  }
  {
    xai_method: LIME,
    base_value: base,
    prediction: base,
    contributions: contribs,
    meta: "lime",
  }
}

///===
/// SHAP

///|
/// SHAP 配置 / SHAP config.
pub struct SHAPConfig {
  num_samples : Int32
  seed : Int32
  feature_names : Array[String]
}

///|
/// 构造 SHAP / Create SHAP config.
pub fn make_shap(
  num_samples : Int32,
  seed : Int32,
  feature_names : Array[String],
) -> SHAPConfig {
  { num_samples, seed, feature_names, }
}

///|
/// SHAP 核 / SHAP kernel.
pub fn shap_kernel(z : Int32, m : Int32) -> Double {
  if z == 0 || z == m {
    1000000.0
  } else {
    let mz = m - z
    let mut num = 1.0
    for i in 0..<m {
      num = num * (i + 1).to_double()
    }
    let mut den = 1.0
    for i in 0..<z {
      den = den * (i + 1).to_double()
    }
    for i in 0..<mz {
      den = den * (i + 1).to_double()
    }
    num / den * (m.to_double() - 1.0)
  }
}

///|
/// SHAP 值 / SHAP value.
pub fn shap_value(
  config : SHAPConfig,
  instance : Array[Double],
  baseline : Array[Double],
  predict_fn : (Array[Double]) -> Double,
) -> Array[Double] {
  let m = instance.length()
  let shap : Array[Double] = []
  let mut state = config.seed
  for j in 0..<m {
    let mut s = 0.0
    for _ in 0..<config.num_samples {
      let (r1, ns1) = xa_rand(state)
      state = ns1
      let (r2, ns2) = xa_rand(state)
      state = ns2
      let with_j : Array[Double] = []
      let without_j : Array[Double] = []
      for k in 0..<m {
        if k == j {
          with_j.push(instance[k])
          without_j.push(baseline[k])
        } else if r1 > 0.5 {
          with_j.push(instance[k])
          without_j.push(instance[k])
        } else {
          with_j.push(baseline[k])
          without_j.push(baseline[k])
        }
      }
      let _ = r2
      s = s + predict_fn(with_j) - predict_fn(without_j)
    }
    shap.push(s / config.num_samples.to_double())
  }
  shap
}

///|
/// SHAP 解释 / SHAP explain.
pub fn shap_explain(
  config : SHAPConfig,
  instance : Array[Double],
  baseline : Array[Double],
  predict_fn : (Array[Double]) -> Double,
) -> Explanation {
  let values = shap_value(config, instance, baseline, predict_fn)
  let contribs : Array[FeatureContribution] = []
  let base = predict_fn(baseline)
  let mut pred = base
  for j in 0..<values.length() {
    let name = if j < config.feature_names.length() {
      config.feature_names[j]
    } else {
      "f" + j.to_string()
    }
    contribs.push(make_contribution(name, instance[j], values[j]))
    pred = pred + values[j]
  }
  {
    xai_method: SHAP,
    base_value: base,
    prediction: pred,
    contributions: contribs,
    meta: "shap",
  }
}

///===
/// Integrated Gradients

///|
/// IG 配置 / Integrated Gradients config.
pub struct IGConfig {
  num_steps : Int32
  baseline : Array[Double]
}

///|
/// 构造 IG / Create IG config.
pub fn make_integrated_gradients(
  num_steps : Int32,
  baseline : Array[Double],
) -> IGConfig {
  { num_steps, baseline, }
}

///|
/// IG 基线 / IG baseline.
pub fn ig_baseline(instance : Array[Double]) -> Array[Double] {
  let b : Array[Double] = []
  for _ in 0..<instance.length() {
    b.push(0.0)
  }
  b
}

///|
/// IG 路径 / IG path.
pub fn ig_path(
  config : IGConfig,
  instance : Array[Double],
  alpha : Double,
) -> Array[Double] {
  let path : Array[Double] = []
  for i in 0..<instance.length() {
    let b = if i < config.baseline.length() { config.baseline[i] } else { 0.0 }
    path.push(b + alpha * (instance[i] - b))
  }
  path
}

///|
/// IG 解释 / IG explain.
pub fn ig_explain(
  config : IGConfig,
  instance : Array[Double],
  grad_fn : (Array[Double]) -> Array[Double],
  predict_fn : (Array[Double]) -> Double,
) -> Explanation {
  let n = instance.length()
  let ig : Array[Double] = []
  for _ in 0..<n {
    ig.push(0.0)
  }
  for step in 0..<config.num_steps {
    let alpha = (step.to_double() + 0.5) / config.num_steps.to_double()
    let path = ig_path(config, instance, alpha)
    let grads = grad_fn(path)
    for j in 0..<n {
      ig[j] = ig[j] + grads[j]
    }
  }
  let contribs : Array[FeatureContribution] = []
  let base = predict_fn(config.baseline)
  let mut pred = base
  for j in 0..<n {
    let attr = ig[j] /
      config.num_steps.to_double() *
      (
        instance[j] -
        (if j < config.baseline.length() { config.baseline[j] } else { 0.0 })
      )
    contribs.push(make_contribution("f" + j.to_string(), instance[j], attr))
    pred = pred + attr
  }
  {
    xai_method: IntegratedGradients,
    base_value: base,
    prediction: pred,
    contributions: contribs,
    meta: "ig",
  }
}

///===
/// Grad-CAM

///|
/// Grad-CAM 配置 / Grad-CAM config.
pub struct GradCAMConfig {
  target_layer : Int32
  relu : Bool
}

///|
/// 构造 Grad-CAM / Create Grad-CAM config.
pub fn make_grad_cam(target_layer : Int32, relu : Bool) -> GradCAMConfig {
  { target_layer, relu, }
}

///|
/// Grad-CAM 热力图 / Grad-CAM heatmap.
pub fn grad_cam_heatmap(
  config : GradCAMConfig,
  gradients : Array[Array[Double]],
  activations : Array[Array[Double]],
) -> Array[Array[Double]] {
  let rows = gradients.length()
  let heatmap : Array[Array[Double]] = []
  if rows == 0 {
    return heatmap
  }
  let cols = gradients[0].length()
  let weights : Array[Double] = []
  for c in 0..<cols {
    let mut s = 0.0
    for r in 0..<rows {
      s = s + gradients[r][c]
    }
    weights.push(s / rows.to_double())
  }
  for r in 0..<rows {
    let row : Array[Double] = []
    for c in 0..<cols {
      let mut v = weights[c] * activations[r][c]
      if config.relu && v < 0.0 {
        v = 0.0
      }
      row.push(v)
    }
    heatmap.push(row)
  }
  heatmap
}

///|
/// Grad-CAM 解释 / Grad-CAM explain.
pub fn grad_cam_explain(
  config : GradCAMConfig,
  gradients : Array[Array[Double]],
  activations : Array[Array[Double]],
  prediction : Double,
) -> Explanation {
  let heatmap = grad_cam_heatmap(config, gradients, activations)
  let contribs : Array[FeatureContribution] = []
  let rows = heatmap.length()
  if rows > 0 {
    let cols = heatmap[0].length()
    for r in 0..<rows {
      for c in 0..<cols {
        contribs.push(
          make_contribution(
            "h" + r.to_string() + "_" + c.to_string(),
            activations[r][c],
            heatmap[r][c],
          ),
        )
      }
    }
  }
  {
    xai_method: GradCAM,
    base_value: 0.0,
    prediction,
    contributions: contribs,
    meta: "grad_cam",
  }
}

///===
/// Attention 可视化

///|
/// Attention 配置 / Attention config.
pub struct AttentionVizConfig {
  num_heads : Int32
  num_layers : Int32
  rollout : Bool
}

///|
/// 构造 Attention 可视化 / Create attention viz config.
pub fn make_attention_viz(
  num_heads : Int32,
  num_layers : Int32,
  rollout : Bool,
) -> AttentionVizConfig {
  { num_heads, num_layers, rollout, }
}

///|
/// Attention 权重 / Attention weights.
pub fn attention_weights(
  config : AttentionVizConfig,
  raw_scores : Array[Array[Double]],
) -> Array[Array[Double]] {
  let n = raw_scores.length()
  let weights : Array[Array[Double]] = []
  if n == 0 {
    return weights
  }
  let cols = raw_scores[0].length()
  for i in 0..<n {
    let row : Array[Double] = []
    let mut max_v = raw_scores[i][0]
    for j in 0..<cols {
      if raw_scores[i][j] > max_v {
        max_v = raw_scores[i][j]
      }
    }
    let mut s = 0.0
    for j in 0..<cols {
      let e = @math.exp(raw_scores[i][j] - max_v)
      row.push(e)
      s = s + e
    }
    for j in 0..<cols {
      row[j] = row[j] / s
    }
    weights.push(row)
  }
  let _ = config
  weights
}

///|
/// Attention rollout / Attention rollout.
pub fn attention_rollout(
  layer_attentions : Array[Array[Array[Double]]],
) -> Array[Array[Double]] {
  if layer_attentions.length() == 0 {
    return []
  }
  let first = layer_attentions[0]
  let n = first.length()
  let mut result : Array[Array[Double]] = []
  for i in 0..<n {
    let row : Array[Double] = []
    for j in 0..<first[i].length() {
      row.push(first[i][j])
    }
    result.push(row)
  }
  for l in 1..<layer_attentions.length() {
    let layer = layer_attentions[l]
    let next : Array[Array[Double]] = []
    for i in 0..<n {
      let row : Array[Double] = []
      for j in 0..<result[i].length() {
        let mut s = 0.0
        for k in 0..<n {
          if k < result[i].length() &&
            k < layer.length() &&
            j < layer[k].length() {
            s = s + result[i][k] * layer[k][j]
          }
        }
        row.push(s)
      }
      next.push(row)
    }
    result = next
  }
  result
}

///===
/// 特征重要性

///|
/// 特征重要性配置 / Feature importance config.
pub struct FeatureImportanceConfig {
  num_repeats : Int32
  seed : Int32
  feature_names : Array[String]
}

///|
/// 构造特征重要性 / Create feature importance config.
pub fn make_feature_importance_xai(
  num_repeats : Int32,
  seed : Int32,
  feature_names : Array[String],
) -> FeatureImportanceConfig {
  { num_repeats, seed, feature_names, }
}

///|
/// 置换重要性 / Permutation importance.
pub fn permutation_importance(
  config : FeatureImportanceConfig,
  instances : Array[Array[Double]],
  labels : Array[Double],
  predict_fn : (Array[Double]) -> Double,
) -> Array[Double] {
  let n = if instances.length() > 0 { instances[0].length() } else { 0 }
  let mut base_err = 0.0
  for i in 0..<instances.length() {
    let d = predict_fn(instances[i]) - labels[i]
    base_err = base_err + d * d
  }
  base_err = @_common.sqrt(base_err / instances.length().to_double())
  let importances : Array[Double] = []
  let mut state = config.seed
  for j in 0..<n {
    let mut sum_imp = 0.0
    for _ in 0..<config.num_repeats {
      let permuted : Array[Array[Double]] = []
      for i in 0..<instances.length() {
        let row : Array[Double] = []
        for k in 0..<instances[i].length() {
          row.push(instances[i][k])
        }
        permuted.push(row)
      }
      for i in 0..<permuted.length() {
        let (r, ns) = xa_rand(state)
        state = ns
        let idx = (r * permuted.length().to_double()).to_int() %
          permuted.length()
        if idx < 0 {
          permuted[i][j] = permuted[0][j]
        } else {
          permuted[i][j] = permuted[idx][j]
        }
      }
      let mut err = 0.0
      for i in 0..<permuted.length() {
        let d = predict_fn(permuted[i]) - labels[i]
        err = err + d * d
      }
      err = @_common.sqrt(err / permuted.length().to_double())
      sum_imp = sum_imp + (err - base_err)
    }
    importances.push(sum_imp / config.num_repeats.to_double())
  }
  importances
}

///|
/// Drop-column 重要性 / Drop-column importance.
pub fn drop_col_importance(
  config : FeatureImportanceConfig,
  instances : Array[Array[Double]],
  labels : Array[Double],
  predict_fn : (Array[Double]) -> Double,
  predict_fn_dropped : (Array[Double], Int32) -> Double,
) -> Array[Double] {
  let n = if instances.length() > 0 { instances[0].length() } else { 0 }
  let mut base_err = 0.0
  for i in 0..<instances.length() {
    let d = predict_fn(instances[i]) - labels[i]
    base_err = base_err + d * d
  }
  base_err = base_err / instances.length().to_double()
  let importances : Array[Double] = []
  for j in 0..<n {
    let mut err = 0.0
    for i in 0..<instances.length() {
      let d = predict_fn_dropped(instances[i], j) - labels[i]
      err = err + d * d
    }
    err = err / instances.length().to_double()
    importances.push(base_err - err)
  }
  let _ = config
  importances
}

///===
/// 部分依赖 / Partial Dependence

///|
/// PDP 配置 / PDP config.
pub struct PDPConfig {
  grid_resolution : Int32
  feature_names : Array[String]
}

///|
/// 构造 PDP / Create PDP config.
pub fn make_partial_dependence(
  grid_resolution : Int32,
  feature_names : Array[String],
) -> PDPConfig {
  { grid_resolution, feature_names, }
}

///|
/// PDP 解释 / PDP explain.
pub fn pdp_explain(
  config : PDPConfig,
  instances : Array[Array[Double]],
  feature_idx : Int32,
  predict_fn : (Array[Double]) -> Double,
) -> (Array[Double], Array[Double]) {
  if instances.length() == 0 {
    return ([], [])
  }
  let mut min_v = instances[0][feature_idx]
  let mut max_v = instances[0][feature_idx]
  for i in 0..<instances.length() {
    if instances[i][feature_idx] < min_v {
      min_v = instances[i][feature_idx]
    }
    if instances[i][feature_idx] > max_v {
      max_v = instances[i][feature_idx]
    }
  }
  let grid : Array[Double] = []
  let pdp_vals : Array[Double] = []
  for g in 0..<config.grid_resolution {
    let v = min_v +
      (max_v - min_v) * g.to_double() / (config.grid_resolution - 1).to_double()
    grid.push(v)
    let mut s = 0.0
    for i in 0..<instances.length() {
      let row : Array[Double] = []
      for k in 0..<instances[i].length() {
        if k == feature_idx {
          row.push(v)
        } else {
          row.push(instances[i][k])
        }
      }
      s = s + predict_fn(row)
    }
    pdp_vals.push(s / instances.length().to_double())
  }
  (grid, pdp_vals)
}

///|
/// ICE 曲线 / ICE curve.
pub fn pdp_ice(
  config : PDPConfig,
  instances : Array[Array[Double]],
  feature_idx : Int32,
  predict_fn : (Array[Double]) -> Double,
) -> Array[Array[Double]] {
  if instances.length() == 0 {
    return []
  }
  let mut min_v = instances[0][feature_idx]
  let mut max_v = instances[0][feature_idx]
  for i in 0..<instances.length() {
    if instances[i][feature_idx] < min_v {
      min_v = instances[i][feature_idx]
    }
    if instances[i][feature_idx] > max_v {
      max_v = instances[i][feature_idx]
    }
  }
  let ice : Array[Array[Double]] = []
  for i in 0..<instances.length() {
    let curve : Array[Double] = []
    for g in 0..<config.grid_resolution {
      let v = min_v +
        (max_v - min_v) *
        g.to_double() /
        (config.grid_resolution - 1).to_double()
      let row : Array[Double] = []
      for k in 0..<instances[i].length() {
        if k == feature_idx {
          row.push(v)
        } else {
          row.push(instances[i][k])
        }
      }
      curve.push(predict_fn(row))
    }
    ice.push(curve)
  }
  ice
}

///|
/// 2D PDP / 2D partial dependence.
pub fn pdp_2d(
  config : PDPConfig,
  instances : Array[Array[Double]],
  feature1 : Int32,
  feature2 : Int32,
  predict_fn : (Array[Double]) -> Double,
) -> (Array[Double], Array[Double], Array[Array[Double]]) {
  if instances.length() == 0 {
    return ([], [], [])
  }
  let mut min1 = instances[0][feature1]
  let mut max1 = instances[0][feature1]
  let mut min2 = instances[0][feature2]
  let mut max2 = instances[0][feature2]
  for i in 0..<instances.length() {
    if instances[i][feature1] < min1 {
      min1 = instances[i][feature1]
    }
    if instances[i][feature1] > max1 {
      max1 = instances[i][feature1]
    }
    if instances[i][feature2] < min2 {
      min2 = instances[i][feature2]
    }
    if instances[i][feature2] > max2 {
      max2 = instances[i][feature2]
    }
  }
  let grid1 : Array[Double] = []
  let grid2 : Array[Double] = []
  for g in 0..<config.grid_resolution {
    let v1 = min1 +
      (max1 - min1) * g.to_double() / (config.grid_resolution - 1).to_double()
    let v2 = min2 +
      (max2 - min2) * g.to_double() / (config.grid_resolution - 1).to_double()
    grid1.push(v1)
    grid2.push(v2)
  }
  let pdp2d : Array[Array[Double]] = []
  for g1 in 0..<config.grid_resolution {
    let row : Array[Double] = []
    for g2 in 0..<config.grid_resolution {
      let mut s = 0.0
      for i in 0..<instances.length() {
        let r : Array[Double] = []
        for k in 0..<instances[i].length() {
          if k == feature1 {
            r.push(grid1[g1])
          } else if k == feature2 {
            r.push(grid2[g2])
          } else {
            r.push(instances[i][k])
          }
        }
        s = s + predict_fn(r)
      }
      row.push(s / instances.length().to_double())
    }
    pdp2d.push(row)
  }
  (grid1, grid2, pdp2d)
}

///===
/// Anchors

///|
/// Anchors 配置 / Anchors config.
pub struct AnchorsConfig {
  precision_threshold : Double
  num_candidates : Int32
  seed : Int32
}

///|
/// 构造 Anchors / Create anchors config.
pub fn make_anchors(
  precision_threshold : Double,
  num_candidates : Int32,
  seed : Int32,
) -> AnchorsConfig {
  { precision_threshold, num_candidates, seed, }
}

///|
/// Anchors 精度 / Anchors precision.
pub fn anchors_precision(
  anchor : Array[(Int32, Double)],
  instances : Array[Array[Double]],
  instance : Array[Double],
  predict_fn : (Array[Double]) -> Double,
) -> Double {
  let target = predict_fn(instance)
  let mut covered = 0
  let mut correct = 0
  for i in 0..<instances.length() {
    let mut ok = true
    for a in 0..<anchor.length() {
      let (idx, val) = anchor[a]
      if idx < instances[i].length() &&
        @_common.abs(instances[i][idx] - val) > 0.000001 {
        ok = false
      }
    }
    if ok {
      covered = covered + 1
      if @_common.abs(predict_fn(instances[i]) - target) < 0.000001 {
        correct = correct + 1
      }
    }
  }
  if covered == 0 {
    0.0
  } else {
    correct.to_double() / covered.to_double()
  }
}

///|
/// Anchors 查找 / Anchors find.
pub fn anchors_find(
  config : AnchorsConfig,
  instance : Array[Double],
  instances : Array[Array[Double]],
  predict_fn : (Array[Double]) -> Double,
) -> Array[(Int32, Double)] {
  let target = predict_fn(instance)
  let anchor : Array[(Int32, Double)] = []
  let mut state = config.seed
  let n = instance.length()
  let order : Array[Int32] = []
  for j in 0..<n {
    order.push(j)
  }
  for j in 0..<n {
    let (r, ns) = xa_rand(state)
    state = ns
    let swap_idx = (r * n.to_double()).to_int() % n
    if swap_idx >= 0 && swap_idx < n {
      let tmp = order[j]
      order[j] = order[swap_idx]
      order[swap_idx] = tmp
    }
  }
  for j in 0..<n {
    anchor.push((order[j], instance[order[j]]))
    let prec = anchors_precision(anchor, instances, instance, predict_fn)
    if prec >= config.precision_threshold {
      return anchor
    }
  }
  let _ = target
  anchor
}

///|
/// Anchors 解释 / Anchors explain.
pub fn anchors_explain(
  config : AnchorsConfig,
  instance : Array[Double],
  instances : Array[Array[Double]],
  predict_fn : (Array[Double]) -> Double,
) -> Explanation {
  let anchor = anchors_find(config, instance, instances, predict_fn)
  let prec = anchors_precision(anchor, instances, instance, predict_fn)
  let contribs : Array[FeatureContribution] = []
  for a in 0..<anchor.length() {
    let (idx, val) = anchor[a]
    contribs.push(
      make_contribution(
        "f" + idx.to_string(),
        val,
        1.0 / anchor.length().to_double(),
      ),
    )
  }
  {
    xai_method: Anchors,
    base_value: 0.0,
    prediction: predict_fn(instance),
    contributions: contribs,
    meta: "anchors:prec=" + prec.to_string(),
  }
}

///===
/// 反事实 / Counterfactual

///|
/// 反事实配置 / Counterfactual config.
pub struct CounterfactualConfig {
  max_features_to_change : Int32
  distance_threshold : Double
  seed : Int32
}

///|
/// 构造反事实 / Create counterfactual config.
pub fn make_counterfactual(
  max_features_to_change : Int32,
  distance_threshold : Double,
  seed : Int32,
) -> CounterfactualConfig {
  { max_features_to_change, distance_threshold, seed, }
}

///|
/// 反事实距离 / Counterfactual distance.
pub fn cf_distance(
  instance : Array[Double],
  counterfactual : Array[Double],
) -> Double {
  let mut s = 0.0
  let n = if instance.length() < counterfactual.length() {
    instance.length()
  } else {
    counterfactual.length()
  }
  for i in 0..<n {
    let d = instance[i] - counterfactual[i]
    s = s + d * d
  }
  @_common.sqrt(s)
}

///|
/// 反事实查找 / Counterfactual find.
pub fn cf_find(
  config : CounterfactualConfig,
  instance : Array[Double],
  target : Double,
  predict_fn : (Array[Double]) -> Double,
  feature_ranges : Array[(Double, Double)],
) -> Array[Double] {
  let n = instance.length()
  let mut best : Array[Double] = []
  for i in 0..<n {
    best.push(instance[i])
  }
  let mut best_dist = 1000000.0
  let mut state = config.seed
  for _ in 0..<200 {
    let candidate : Array[Double] = []
    for i in 0..<n {
      candidate.push(instance[i])
    }
    for _ in 0..<config.max_features_to_change {
      let (r1, ns1) = xa_rand(state)
      state = ns1
      let (r2, ns2) = xa_rand(state)
      state = ns2
      let idx = (r1 * n.to_double()).to_int() % n
      if idx >= 0 && idx < n && idx < feature_ranges.length() {
        let (lo, hi) = feature_ranges[idx]
        candidate[idx] = lo + r2 * (hi - lo)
      }
    }
    let dist = cf_distance(instance, candidate)
    if dist < best_dist && @_common.abs(predict_fn(candidate) - target) < 0.01 {
      best_dist = dist
      best = candidate
    }
  }
  best
}

///|
/// 反事实解释 / Counterfactual explain.
pub fn cf_explain(
  config : CounterfactualConfig,
  instance : Array[Double],
  target : Double,
  predict_fn : (Array[Double]) -> Double,
  feature_ranges : Array[(Double, Double)],
) -> Explanation {
  let cf = cf_find(config, instance, target, predict_fn, feature_ranges)
  let dist = cf_distance(instance, cf)
  let contribs : Array[FeatureContribution] = []
  for i in 0..<instance.length() {
    contribs.push(
      make_contribution("f" + i.to_string(), cf[i], cf[i] - instance[i]),
    )
  }
  {
    xai_method: Counterfactual,
    base_value: predict_fn(instance),
    prediction: predict_fn(cf),
    contributions: contribs,
    meta: "cf:dist=" + dist.to_string(),
  }
}

///===
/// 决策树解释 / Decision Tree Explanation

///|
/// 决策树节点 / Decision tree node.
pub struct TreeNode {
  feature : Int32
  threshold : Double
  left : Int32
  right : Int32
  value : Double
  is_leaf : Bool
}

///|
/// 决策树解释配置 / Decision tree explain config.
pub struct DecisionTreeExplainConfig {
  nodes : Array[TreeNode]
  feature_names : Array[String]
}

///|
/// 构造决策树解释 / Create decision tree explain config.
pub fn make_decision_tree_explain(
  nodes : Array[TreeNode],
  feature_names : Array[String],
) -> DecisionTreeExplainConfig {
  { nodes, feature_names, }
}

///|
/// 决策树路径 / Decision tree path.
pub fn tree_path(
  config : DecisionTreeExplainConfig,
  instance : Array[Double],
) -> Array[Int32] {
  let path : Array[Int32] = []
  let mut node_idx = 0
  let mut steps = 0
  while node_idx >= 0 && node_idx < config.nodes.length() && steps < 1000 {
    path.push(node_idx)
    let node = config.nodes[node_idx]
    if node.is_leaf {
      return path
    }
    if node.feature < instance.length() &&
      instance[node.feature] <= node.threshold {
      node_idx = node.left
    } else {
      node_idx = node.right
    }
    steps = steps + 1
  }
  path
}

///|
/// 决策树规则 / Decision tree rules.
pub fn tree_rules(
  config : DecisionTreeExplainConfig,
  path : Array[Int32],
) -> String {
  let mut result = ""
  for i in 0..<path.length() {
    let node = config.nodes[path[i]]
    if node.is_leaf {
      result = result + " => " + node.value.to_string()
    } else {
      let name = if node.feature < config.feature_names.length() {
        config.feature_names[node.feature]
      } else {
        "f" + node.feature.to_string()
      }
      if i < path.length() - 1 {
        let next = config.nodes[path[i + 1]]
        if next.feature == node.feature &&
          @_common.abs(next.threshold - node.threshold) < 0.000001 {
          result = result + name + " <= " + node.threshold.to_string()
        } else {
          result = result + name + " > " + node.threshold.to_string()
        }
        if i < path.length() - 2 {
          result = result + " AND "
        }
      }
    }
  }
  result
}

///|
/// 决策树特征重要性 / Decision tree feature importance.
pub fn tree_feature_importance(
  config : DecisionTreeExplainConfig,
) -> Array[Double] {
  let n = config.feature_names.length()
  let importances : Array[Double] = []
  for _ in 0..<n {
    importances.push(0.0)
  }
  for i in 0..<config.nodes.length() {
    let node = config.nodes[i]
    if !node.is_leaf && node.feature < n {
      let left = if node.left < config.nodes.length() {
        config.nodes[node.left].value
      } else {
        0.0
      }
      let right = if node.right < config.nodes.length() {
        config.nodes[node.right].value
      } else {
        0.0
      }
      importances[node.feature] = importances[node.feature] +
        @_common.abs(left - right)
    }
  }
  let mut total = 0.0
  for i in 0..<n {
    total = total + importances[i]
  }
  if total > 0.0 {
    for i in 0..<n {
      importances[i] = importances[i] / total
    }
  }
  importances
}

///===
/// 规则提取 / Rule Extraction

///|
/// 规则 / Rule.
pub struct Rule {
  conditions : Array[(Int32, Double, Bool)]
  consequence : Double
  confidence : Double
}

///|
/// 规则提取配置 / Rule extraction config.
pub struct RuleExtractionConfig {
  min_confidence : Double
  max_rules : Int32
  feature_names : Array[String]
}

///|
/// 构造规则提取 / Create rule extraction config.
pub fn make_rule_extraction(
  min_confidence : Double,
  max_rules : Int32,
  feature_names : Array[String],
) -> RuleExtractionConfig {
  { min_confidence, max_rules, feature_names, }
}

///|
/// 规则提取 / Rule extract.
pub fn rule_extract(
  config : RuleExtractionConfig,
  instances : Array[Array[Double]],
  labels : Array[Double],
) -> Array[Rule] {
  let n = if instances.length() > 0 { instances[0].length() } else { 0 }
  let rules : Array[Rule] = []
  let mut state = 42
  for _ in 0..<config.max_rules {
    let (r1, ns1) = xa_rand(state)
    state = ns1
    let (r2, ns2) = xa_rand(state)
    state = ns2
    let (r3, ns3) = xa_rand(state)
    state = ns3
    let feat = (r1 * n.to_double()).to_int() % n
    if feat < 0 {
      continue
    }
    let mut thresh = 0.0
    for i in 0..<instances.length() {
      thresh = thresh + instances[i][feat]
    }
    thresh = thresh / instances.length().to_double()
    let le = r2 > 0.5
    let mut pos = 0
    let mut neg = 0
    for i in 0..<instances.length() {
      let matches = if le {
        instances[i][feat] <= thresh
      } else {
        instances[i][feat] > thresh
      }
      if matches {
        if @_common.abs(labels[i] - 1.0) < 0.000001 {
          pos = pos + 1
        } else {
          neg = neg + 1
        }
      }
    }
    let total = pos + neg
    if total > 0 {
      let conf = pos.to_double() / total.to_double()
      if conf >= config.min_confidence {
        let conds : Array[(Int32, Double, Bool)] = [(feat, thresh, le)]
        rules.push({ conditions: conds, consequence: 1.0, confidence: conf, })
      } else if 1.0 - conf >= config.min_confidence {
        let conds : Array[(Int32, Double, Bool)] = [(feat, thresh, le)]
        rules.push({
          conditions: conds,
          consequence: 0.0,
          confidence: 1.0 - conf,
        })
      }
    }
    let _ = r3
  }
  rules
}

///|
/// 规则简化 / Rule simplify.
pub fn rule_simplify(rules : Array[Rule]) -> Array[Rule] {
  let simplified : Array[Rule] = []
  for i in 0..<rules.length() {
    let mut dup = false
    for j in 0..<simplified.length() {
      if rules[i].confidence == simplified[j].confidence &&
        rules[i].consequence == simplified[j].consequence {
        if rules[i].conditions.length() == simplified[j].conditions.length() {
          let mut same = true
          for k in 0..<rules[i].conditions.length() {
            let (f1, t1, l1) = rules[i].conditions[k]
            let (f2, t2, l2) = simplified[j].conditions[k]
            if f1 != f2 || @_common.abs(t1 - t2) > 0.000001 || l1 != l2 {
              same = false
            }
          }
          if same {
            dup = true
          }
        }
      }
    }
    if !dup {
      simplified.push(rules[i])
    }
  }
  simplified
}

///===
/// 代理模型 / Surrogate

///|
/// 代理模型配置 / Surrogate config.
pub struct SurrogateConfig {
  model_type : String
  max_depth : Int32
  feature_names : Array[String]
}

///|
/// 构造代理模型 / Create surrogate config.
pub fn make_surrogate(
  model_type : String,
  max_depth : Int32,
  feature_names : Array[String],
) -> SurrogateConfig {
  { model_type, max_depth, feature_names, }
}

///|
/// 代理模型拟合 / Surrogate fit.
pub fn surrogate_fit(
  config : SurrogateConfig,
  instances : Array[Array[Double]],
  predictions : Array[Double],
) -> Array[Double] {
  let n = if instances.length() > 0 { instances[0].length() } else { 0 }
  let coefs : Array[Double] = []
  for j in 0..<n {
    let mut num = 0.0
    let mut den = 0.0
    for i in 0..<instances.length() {
      num = num + instances[i][j] * predictions[i]
      den = den + instances[i][j] * instances[i][j]
    }
    if @_common.abs(den) < 0.000001 {
      coefs.push(0.0)
    } else {
      coefs.push(num / den)
    }
  }
  let _ = config
  coefs
}

///|
/// 代理模型解释 / Surrogate explain.
pub fn surrogate_explain(
  config : SurrogateConfig,
  coefs : Array[Double],
  instance : Array[Double],
  prediction : Double,
) -> Explanation {
  let contribs : Array[FeatureContribution] = []
  let mut base = prediction
  for j in 0..<coefs.length() {
    let name = if j < config.feature_names.length() {
      config.feature_names[j]
    } else {
      "f" + j.to_string()
    }
    let c = coefs[j] * instance[j]
    contribs.push(make_contribution(name, instance[j], c))
    base = base - c
  }
  {
    xai_method: Surrogate,
    base_value: base,
    prediction,
    contributions: contribs,
    meta: "surrogate:" + config.model_type,
  }
}

///===
/// XAI 评估 / XAI evaluate

///|
/// XAI 解释统一入口 / XAI explain unified entry.
pub fn xai_explain(
  config : XAIConfig,
  instance : Array[Double],
  predict_fn : (Array[Double]) -> Double,
) -> Explanation {
  let contribs : Array[FeatureContribution] = []
  let pred = predict_fn(instance)
  for j in 0..<instance.length() {
    let perturbed : Array[Double] = []
    for k in 0..<instance.length() {
      if k == j {
        perturbed.push(0.0)
      } else {
        perturbed.push(instance[k])
      }
    }
    let imp = pred - predict_fn(perturbed)
    contribs.push(make_contribution("f" + j.to_string(), instance[j], imp))
  }
  let method_name = match config.xai_method {
    LIME => "lime"
    SHAP => "shap"
    IntegratedGradients => "ig"
    GradCAM => "grad_cam"
    Attention => "attention"
    FeatureImportance => "fi"
    PartialDependence => "pdp"
    Anchors => "anchors"
    Counterfactual => "cf"
    DecisionTree => "tree"
    RuleExtraction => "rule"
    Surrogate => "surrogate"
    ALE => "ale"
  }
  {
    xai_method: config.xai_method,
    base_value: 0.0,
    prediction: pred,
    contributions: contribs,
    meta: method_name,
  }
}

///|
/// XAI 评估 / XAI evaluate.
pub fn xai_evaluate(
  explanation : Explanation,
  instance : Array[Double],
  predict_fn : (Array[Double]) -> Double,
) -> Double {
  let orig = predict_fn(instance)
  let mut sum_imp = 0.0
  for i in 0..<explanation.contributions.length() {
    sum_imp = sum_imp + @_common.abs(explanation.contributions[i].contribution)
  }
  let mut s = 0.0
  for i in 0..<instance.length() {
    let p : Array[Double] = []
    for k in 0..<instance.length() {
      p.push(instance[k])
    }
    p[i] = 0.0
    s = s + @_common.abs(orig - predict_fn(p))
  }
  if s < 0.000001 {
    1.0
  } else {
    1.0 - @_common.abs(sum_imp - s) / s
  }
}

///===
/// 解释格式化 / Explanation format

///|
/// 解释格式化 / Format explanation.
pub fn explanation_format(explanation : Explanation) -> String {
  let method_name = match explanation.xai_method {
    LIME => "LIME"
    SHAP => "SHAP"
    IntegratedGradients => "IntegratedGradients"
    GradCAM => "GradCAM"
    Attention => "Attention"
    FeatureImportance => "FeatureImportance"
    PartialDependence => "PartialDependence"
    Anchors => "Anchors"
    Counterfactual => "Counterfactual"
    DecisionTree => "DecisionTree"
    RuleExtraction => "RuleExtraction"
    Surrogate => "Surrogate"
    ALE => "ALE"
  }
  let mut result = "Method: " + method_name + "\n"
  result = result + "Base: " + explanation.base_value.to_string() + "\n"
  result = result + "Prediction: " + explanation.prediction.to_string() + "\n"
  result = result + "Contributions:\n"
  for i in 0..<explanation.contributions.length() {
    let c = explanation.contributions[i]
    result = result +
      "  " +
      c.feature +
      " = " +
      c.value.to_string() +
      " -> " +
      c.contribution.to_string() +
      "\n"
  }
  if explanation.meta.length() > 0 {
    result = result + "Meta: " + explanation.meta + "\n"
  }
  result
}

///|
/// 解释可视化 / Visualize explanation.
pub fn explanation_visualize(explanation : Explanation) -> String {
  let mut result = "+--------------------------------------+\n"
  result = result + "| Explanation Visualization             |\n"
  result = result + "+--------------------------------------+\n"
  let mut max_imp = 0.0
  for i in 0..<explanation.contributions.length() {
    let a = @_common.abs(explanation.contributions[i].contribution)
    if a > max_imp {
      max_imp = a
    }
  }
  for i in 0..<explanation.contributions.length() {
    let c = explanation.contributions[i]
    let a = @_common.abs(c.contribution)
    let bar_len = if max_imp > 0.0 { (a / max_imp * 30.0).to_int() } else { 0 }
    let mut bar = ""
    for _ in 0..<bar_len {
      bar = bar + "#"
    }
    let sign = if c.contribution >= 0.0 { "+" } else { "-" }
    result = result + "| " + c.feature + " " + sign + " " + bar + "\n"
  }
  result = result + "+--------------------------------------+\n"
  result
}

///|
///===
/// 评估指标 / Evaluation metrics
fn xa_sort_desc_idx(
  contributions : Array[FeatureContribution],
  n : Int32,
) -> Array[Int32] {
  let sorted_idx : Array[Int32] = []
  for i in 0..<n {
    sorted_idx.push(i)
  }
  for i in 0..<n {
    for j in (i + 1)..<n {
      let ai = if i < contributions.length() {
        @_common.abs(contributions[i].contribution)
      } else {
        0.0
      }
      let aj = if j < contributions.length() {
        @_common.abs(contributions[j].contribution)
      } else {
        0.0
      }
      if aj > ai {
        let tmp = sorted_idx[i]
        sorted_idx[i] = sorted_idx[j]
        sorted_idx[j] = tmp
      }
    }
  }
  sorted_idx
}

///|
/// 忠实度评估 / Faithfulness evaluation.
pub fn faithfulness_eval(
  explanation : Explanation,
  instance : Array[Double],
  predict_fn : (Array[Double]) -> Double,
) -> Double {
  let n = instance.length()
  let orig = predict_fn(instance)
  let sorted_idx = xa_sort_desc_idx(explanation.contributions, n)
  let cur : Array[Double] = []
  for i in 0..<n {
    cur.push(instance[i])
  }
  let mut auc = 0.0
  let mut prev_pred = orig
  for k in 0..<n {
    cur[sorted_idx[k]] = 0.0
    let cur_pred = predict_fn(cur)
    auc = auc + @_common.abs(prev_pred - cur_pred)
    prev_pred = cur_pred
  }
  if n == 0 {
    0.0
  } else {
    auc / n.to_double()
  }
}

///|
/// 单调性评估 / Monotonicity evaluation.
pub fn monotonicity_eval(
  explanation : Explanation,
  instance : Array[Double],
  predict_fn : (Array[Double]) -> Double,
) -> Double {
  let n = instance.length()
  if n == 0 {
    return 0.0
  }
  let sorted_idx = xa_sort_desc_idx(explanation.contributions, n)
  let cur : Array[Double] = []
  for i in 0..<n {
    cur.push(instance[i])
  }
  let mut prev_drop = 0.0
  let mut monotonic = 0
  let mut total = 0
  for k in 0..<n {
    let before = predict_fn(cur)
    cur[sorted_idx[k]] = 0.0
    let after = predict_fn(cur)
    let drop = @_common.abs(before - after)
    if k > 0 {
      total = total + 1
      if drop <= prev_drop + 0.000001 {
        monotonic = monotonic + 1
      }
    }
    prev_drop = drop
  }
  if total == 0 {
    0.0
  } else {
    monotonic.to_double() / total.to_double()
  }
}

///|
/// 完备性评估 / Completeness evaluation.
pub fn completeness_eval(
  explanation : Explanation,
  instance : Array[Double],
  predict_fn : (Array[Double]) -> Double,
) -> Double {
  let orig = predict_fn(instance)
  let base : Array[Double] = []
  for _ in 0..<instance.length() {
    base.push(0.0)
  }
  let base_pred = predict_fn(base)
  let mut sum_contrib = 0.0
  for i in 0..<explanation.contributions.length() {
    sum_contrib = sum_contrib + explanation.contributions[i].contribution
  }
  let diff = @_common.abs(orig - base_pred - sum_contrib)
  let denom = @_common.abs(orig - base_pred)
  if denom < 0.000001 {
    1.0
  } else {
    1.0 - diff / denom
  }
}

///===
/// ALE / Accumulated Local Effects

///|
/// ALE 配置 / ALE config.
pub struct ALEConfig {
  grid_resolution : Int32
  feature_names : Array[String]
}

///|
/// 构造 ALE / Create ALE config.
pub fn make_ale(
  grid_resolution : Int32,
  feature_names : Array[String],
) -> ALEConfig {
  { grid_resolution, feature_names, }
}

///|
/// 1D ALE / 1D ALE.
pub fn ale_1d(
  config : ALEConfig,
  instances : Array[Array[Double]],
  feature_idx : Int32,
  predict_fn : (Array[Double]) -> Double,
) -> (Array[Double], Array[Double]) {
  if instances.length() == 0 {
    return ([], [])
  }
  let mut min_v = instances[0][feature_idx]
  let mut max_v = instances[0][feature_idx]
  for i in 0..<instances.length() {
    if instances[i][feature_idx] < min_v {
      min_v = instances[i][feature_idx]
    }
    if instances[i][feature_idx] > max_v {
      max_v = instances[i][feature_idx]
    }
  }
  let grid : Array[Double] = []
  for g in 0..<config.grid_resolution {
    grid.push(
      min_v +
      (max_v - min_v) * g.to_double() / (config.grid_resolution - 1).to_double(),
    )
  }
  let local_effects : Array[Double] = []
  for g in 1..<config.grid_resolution {
    let mut s = 0.0
    let mut cnt = 0
    for i in 0..<instances.length() {
      if instances[i][feature_idx] > grid[g - 1] &&
        instances[i][feature_idx] <= grid[g] {
        let upper : Array[Double] = []
        let lower : Array[Double] = []
        for k in 0..<instances[i].length() {
          if k == feature_idx {
            upper.push(grid[g])
            lower.push(grid[g - 1])
          } else {
            upper.push(instances[i][k])
            lower.push(instances[i][k])
          }
        }
        s = s + predict_fn(upper) - predict_fn(lower)
        cnt = cnt + 1
      }
    }
    if cnt > 0 {
      local_effects.push(s / cnt.to_double())
    } else {
      local_effects.push(0.0)
    }
  }
  let ale : Array[Double] = []
  let mut cum = 0.0
  ale.push(0.0)
  for g in 0..<local_effects.length() {
    cum = cum + local_effects[g]
    ale.push(cum)
  }
  let m = @_common.mean(ale)
  for g in 0..<ale.length() {
    ale[g] = ale[g] - m
  }
  (grid, ale)
}

///|
/// 2D ALE / 2D ALE.
pub fn ale_2d(
  config : ALEConfig,
  instances : Array[Array[Double]],
  feature1 : Int32,
  feature2 : Int32,
  predict_fn : (Array[Double]) -> Double,
) -> (Array[Double], Array[Double], Array[Array[Double]]) {
  if instances.length() == 0 {
    return ([], [], [])
  }
  let mut min1 = instances[0][feature1]
  let mut max1 = instances[0][feature1]
  let mut min2 = instances[0][feature2]
  let mut max2 = instances[0][feature2]
  for i in 0..<instances.length() {
    if instances[i][feature1] < min1 {
      min1 = instances[i][feature1]
    }
    if instances[i][feature1] > max1 {
      max1 = instances[i][feature1]
    }
    if instances[i][feature2] < min2 {
      min2 = instances[i][feature2]
    }
    if instances[i][feature2] > max2 {
      max2 = instances[i][feature2]
    }
  }
  let grid1 : Array[Double] = []
  let grid2 : Array[Double] = []
  for g in 0..<config.grid_resolution {
    grid1.push(
      min1 +
      (max1 - min1) * g.to_double() / (config.grid_resolution - 1).to_double(),
    )
    grid2.push(
      min2 +
      (max2 - min2) * g.to_double() / (config.grid_resolution - 1).to_double(),
    )
  }
  let ale2d : Array[Array[Double]] = []
  for g1 in 0..<config.grid_resolution {
    let row : Array[Double] = []
    for g2 in 0..<config.grid_resolution {
      let mut s = 0.0
      let mut cnt = 0
      for i in 0..<instances.length() {
        if instances[i][feature1] > min1 && instances[i][feature2] > min2 {
          let r : Array[Double] = []
          for k in 0..<instances[i].length() {
            if k == feature1 {
              r.push(grid1[g1])
            } else if k == feature2 {
              r.push(grid2[g2])
            } else {
              r.push(instances[i][k])
            }
          }
          s = s + predict_fn(r)
          cnt = cnt + 1
        }
      }
      if cnt > 0 {
        row.push(s / cnt.to_double())
      } else {
        row.push(0.0)
      }
    }
    ale2d.push(row)
  }
  (grid1, grid2, ale2d)
}

///|
/// ALE 解释 / ALE explain.
pub fn ale_explain(
  config : ALEConfig,
  instances : Array[Array[Double]],
  feature_idx : Int32,
  predict_fn : (Array[Double]) -> Double,
) -> Explanation {
  let (grid, ale) = ale_1d(config, instances, feature_idx, predict_fn)
  let contribs : Array[FeatureContribution] = []
  for g in 0..<grid.length() {
    let name = if feature_idx < config.feature_names.length() {
      config.feature_names[feature_idx]
    } else {
      "f" + feature_idx.to_string()
    }
    contribs.push(
      make_contribution(name + "@" + g.to_string(), grid[g], ale[g]),
    )
  }
  let pred = if instances.length() > 0 { predict_fn(instances[0]) } else { 0.0 }
  {
    xai_method: ALE,
    base_value: 0.0,
    prediction: pred,
    contributions: contribs,
    meta: "ale",
  }
}

///|
///===
/// ID
pub fn explainable_id() -> String {
  "agent_kit/explainable"
}
