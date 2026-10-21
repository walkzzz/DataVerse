///|
/// # agent_kit/safety_ai AI 安全 / AI Safety
///
/// AI 安全算子族：输入校验、输出过滤、PII 检测、毒性检测、偏见检测、
/// 对抗检测、提示注入、速率限制、内容过滤、安全监控、护栏、安全评估、
/// 攻击模拟、数据投毒、模型窃取、差分隐私、公平性、对齐。
/// S0.1 骨架占位，Phase 2 填充。
///
/// # AI safety operators
///
/// Input validation, output filter, PII, toxicity, bias, adversarial,
/// prompt injection, rate limit, content filter, monitor, guardrail,
/// safety eval, attack simulation, data poisoning, model stealing,
/// differential privacy, fairness, alignment.

///===
/// 数学辅助 / Math helpers

fn sa_exp(x : Double) -> Double {
  if x > 20.0 {
    485165195.4
  } else if x < -20.0 {
    0.0
  } else {
    let mut result = 1.0
    let mut term = 1.0
    for i in 1..<50 {
      term = term * x / i.to_double()
      result = result + term
    }
    result
  }
}

fn sa_log(x : Double) -> Double {
  if x <= 0.0 {
    -1000.0
  } else {
    let mut result = 0.0
    let term = (x - 1.0) / (x + 1.0)
    let t2 = term * term
    let mut pow = term
    for i in 0..<50 {
      result = result + pow / (2 * i + 1).to_double()
      pow = pow * t2
    }
    2.0 * result
  }
}

fn sa_sqrt(x : Double) -> Double {
  if x <= 0.0 {
    0.0
  } else {
    let mut guess = x
    for _ in 0..<40 {
      guess = 0.5 * (guess + x / guess)
    }
    guess
  }
}

fn sa_abs(x : Double) -> Double {
  if x < 0.0 { -x } else { x }
}

fn sa_sigmoid(x : Double) -> Double {
  1.0 / (1.0 + sa_exp(-x))
}

fn sa_mean(arr : Array[Double]) -> Double {
  if arr.length() == 0 {
    0.0
  } else {
    let mut s = 0.0
    for i in 0..<arr.length() {
      s = s + arr[i]
    }
    s / arr.length().to_double()
  }
}

fn sa_lcg_next(state : Int) -> Int {
  let a = 1103515245
  let c = 12345
  let m = 2147483647
  (a * state + c) % m
}

fn sa_rand(state : Int) -> (Double, Int) {
  let next = sa_lcg_next(state)
  (next.to_double() / 2147483647.0, next)
}

fn sa_contains(text : String, pattern : String) -> Bool {
  let tlen = text.length()
  let plen = pattern.length()
  if plen == 0 {
    return true
  }
  if plen > tlen {
    return false
  }
  for i in 0..<(tlen - plen + 1) {
    let mut ok = true
    for j in 0..<plen {
      if text[i + j] != pattern[j] {
        ok = false
      }
    }
    if ok {
      return true
    }
  }
  false
}

fn sa_to_lower(text : String) -> String {
  text.to_lower()
}

///===
/// 安全配置 / Safety config

/// 严重程度 / Severity.
pub(all) enum Severity {
  Info
  Low
  Medium
  High
  Critical
}

/// 安全配置 / Safety config.
pub struct SafetyConfig {
  enable_pii : Bool
  enable_toxicity : Bool
  enable_bias : Bool
  enable_adversarial : Bool
  enable_injection : Bool
  max_input_length : Int
  max_output_length : Int
}

/// 构造安全配置 / Create safety config.
pub fn make_safety_config(
  enable_pii : Bool,
  enable_toxicity : Bool,
  enable_bias : Bool,
  enable_adversarial : Bool,
  enable_injection : Bool,
  max_input_length : Int,
  max_output_length : Int,
) -> SafetyConfig {
  { enable_pii: enable_pii, enable_toxicity: enable_toxicity, enable_bias: enable_bias, enable_adversarial: enable_adversarial, enable_injection: enable_injection, max_input_length: max_input_length, max_output_length: max_output_length }
}

///===
/// 输入校验 / Input validation

/// 输入校验器 / Input validator.
pub struct InputValidator {
  max_length : Int
  allowed_chars : String
  blocked_patterns : Array[String]
}

/// 构造输入校验器 / Create input validator.
pub fn make_input_validator(max_length : Int, allowed_chars : String, blocked_patterns : Array[String]) -> InputValidator {
  { max_length: max_length, allowed_chars: allowed_chars, blocked_patterns: blocked_patterns }
}

/// 校验输入 / Validate input.
pub fn validate_input(validator : InputValidator, input : String) -> (Bool, String) {
  if input.length() > validator.max_length {
    return (false, "input too long")
  }
  let lower = sa_to_lower(input)
  for i in 0..<validator.blocked_patterns.length() {
    let pat = sa_to_lower(validator.blocked_patterns[i])
    if sa_contains(lower, pat) {
      return (false, "blocked pattern: " + validator.blocked_patterns[i])
    }
  }
  (true, "")
}

///===
/// 输出过滤 / Output filter

/// 输出过滤器 / Output filter.
pub struct OutputFilter {
  blocked_words : Array[String]
  replacement : String
  max_length : Int
}

/// 构造输出过滤器 / Create output filter.
pub fn make_output_filter(blocked_words : Array[String], replacement : String, max_length : Int) -> OutputFilter {
  { blocked_words: blocked_words, replacement: replacement, max_length: max_length }
}

/// 过滤输出 / Filter output.
pub fn filter_output(filter : OutputFilter, output : String) -> String {
  let mut result = output
  let lower = sa_to_lower(output)
  for i in 0..<filter.blocked_words.length() {
    let pat = sa_to_lower(filter.blocked_words[i])
    if sa_contains(lower, pat) {
      result = filter.replacement
    }
  }
  if result.length() > filter.max_length {
    let mut truncated = ""
    for i in 0..<filter.max_length {
      if i < result.length() {
        truncated = truncated + result[i].to_string()
      }
    }
    result = truncated
  }
  result
}

/// 检查输出安全 / Check output safety.
pub fn check_output_safety(filter : OutputFilter, output : String) -> (Bool, Severity) {
  let lower = sa_to_lower(output)
  for i in 0..<filter.blocked_words.length() {
    let pat = sa_to_lower(filter.blocked_words[i])
    if sa_contains(lower, pat) {
      return (false, High)
    }
  }
  if output.length() > filter.max_length {
    return (true, Low)
  }
  (true, Info)
}

///===
/// PII 检测 / PII detection

/// PII 类型 / PII type.
pub(all) enum PIIType {
  Email
  Phone
  SSN
  CreditCard
  IPAddress
  Address
  Name
}

/// PII 检测器 / PII detector.
pub struct PIIDetector {
  patterns : Array[(PIIType, String)]
  mask_char : String
}

/// 构造 PII 检测器 / Create PII detector.
pub fn make_pii_detector(patterns : Array[(PIIType, String)], mask_char : String) -> PIIDetector {
  { patterns: patterns, mask_char: mask_char }
}

/// 检测 PII / Detect PII.
pub fn detect_pii(detector : PIIDetector, text : String) -> Array[(PIIType, Int, Int)] {
  let results : Array[(PIIType, Int, Int)] = []
  for i in 0..<detector.patterns.length() {
    let (pii_type, pattern) = detector.patterns[i]
    let tlen = text.length()
    let plen = pattern.length()
    if plen == 0 || plen > tlen {
      continue
    }
    for j in 0..<(tlen - plen + 1) {
      let mut ok = true
      for k in 0..<plen {
        if text[j + k] != pattern[k] {
          ok = false
        }
      }
      if ok {
        results.push((pii_type, j, j + plen))
      }
    }
  }
  results
}

/// 遮盖 PII / Redact PII.
pub fn redact_pii(detector : PIIDetector, text : String) -> String {
  let detections = detect_pii(detector, text)
  let mut result = ""
  let mut i = 0
  while i < text.length() {
    let mut redacted = false
    for d in 0..<detections.length() {
      let (_, start, end) = detections[d]
      if i == start {
        for _ in 0..<(end - start) {
          result = result + detector.mask_char
        }
        i = end
        redacted = true
      }
    }
    if !(redacted) {
      result = result + text[i].to_string()
      i = i + 1
    }
  }
  result
}

/// 掩码 PII / Mask PII.
pub fn mask_pii(detector : PIIDetector, text : String) -> String {
  let detections = detect_pii(detector, text)
  let mut result = ""
  let mut i = 0
  while i < text.length() {
    let mut masked = false
    for d in 0..<detections.length() {
      let (pii_type, start, end) = detections[d]
      if i == start {
        let prefix = match pii_type {
          Email => "[EMAIL]"
          Phone => "[PHONE]"
          SSN => "[SSN]"
          CreditCard => "[CARD]"
          IPAddress => "[IP]"
          Address => "[ADDR]"
          Name => "[NAME]"
        }
        result = result + prefix
        i = end
        masked = true
      }
    }
    if !(masked) {
      result = result + text[i].to_string()
      i = i + 1
    }
  }
  result
}

///===
/// 毒性检测 / Toxicity detection

/// 毒性检测器 / Toxicity detector.
pub struct ToxicityDetector {
  toxic_words : Array[String]
  threshold : Double
}

/// 构造毒性检测器 / Create toxicity detector.
pub fn make_toxicity_detector(toxic_words : Array[String], threshold : Double) -> ToxicityDetector {
  { toxic_words: toxic_words, threshold: threshold }
}

/// 毒性分数 / Toxicity score.
pub fn toxicity_score(detector : ToxicityDetector, text : String) -> Double {
  let lower = sa_to_lower(text)
  let mut hits = 0
  for i in 0..<detector.toxic_words.length() {
    let pat = sa_to_lower(detector.toxic_words[i])
    if sa_contains(lower, pat) {
      hits = hits + 1
    }
  }
  if detector.toxic_words.length() == 0 {
    0.0
  } else {
    sa_sigmoid(hits.to_double() / detector.toxic_words.length().to_double() * 5.0 - detector.threshold * 5.0)
  }
}

/// 检测毒性 / Detect toxicity.
pub fn detect_toxicity(detector : ToxicityDetector, text : String) -> (Bool, Double) {
  let score = toxicity_score(detector, text)
  (score > detector.threshold, score)
}

///===
/// 偏见检测 / Bias detection

/// 偏见检测器 / Bias detector.
pub struct BiasDetector {
  protected_attributes : Array[String]
  threshold : Double
}

/// 构造偏见检测器 / Create bias detector.
pub fn make_bias_detector(protected_attributes : Array[String], threshold : Double) -> BiasDetector {
  { protected_attributes: protected_attributes, threshold: threshold }
}

/// 偏见分数 / Bias score.
pub fn bias_score(detector : BiasDetector, predictions : Array[Double], groups : Array[Int]) -> Double {
  let group_preds : Array[Array[Double]] = []
  let mut num_groups = 0
  for i in 0..<groups.length() {
    if groups[i] + 1 > num_groups {
      num_groups = groups[i] + 1
    }
  }
  for _ in 0..<num_groups {
    group_preds.push([])
  }
  for i in 0..<predictions.length() {
    if groups[i] >= 0 && groups[i] < num_groups {
      group_preds[groups[i]].push(predictions[i])
    }
  }
  let mut max_mean = 0.0
  let mut min_mean = 1000000.0
  for g in 0..<num_groups {
    if group_preds[g].length() > 0 {
      let m = sa_mean(group_preds[g])
      if m > max_mean {
        max_mean = m
      }
      if m < min_mean {
        min_mean = m
      }
    }
  }
  let _ = detector
  if min_mean > 1000000.0 {
    0.0
  } else {
    sa_abs(max_mean - min_mean)
  }
}

/// 检测偏见 / Detect bias.
pub fn detect_bias(detector : BiasDetector, predictions : Array[Double], groups : Array[Int]) -> (Bool, Double) {
  let score = bias_score(detector, predictions, groups)
  (score > detector.threshold, score)
}

/// 公平性检查 / Fairness check.
pub fn fairness_check(detector : BiasDetector, predictions : Array[Double], groups : Array[Int]) -> Bool {
  let score = bias_score(detector, predictions, groups)
  score <= detector.threshold
}

///===
/// 对抗检测 / Adversarial detection

/// 对抗检测器 / Adversarial detector.
pub struct AdversarialDetector {
  sensitivity_threshold : Double
  perturbation_size : Double
  seed : Int
}

/// 构造对抗检测器 / Create adversarial detector.
pub fn make_adversarial_detector(sensitivity_threshold : Double, perturbation_size : Double, seed : Int) -> AdversarialDetector {
  { sensitivity_threshold: sensitivity_threshold, perturbation_size: perturbation_size, seed: seed }
}

/// 对抗分数 / Adversarial score.
pub fn adversarial_score(
  detector : AdversarialDetector,
  instance : Array[Double],
  predict_fn : (Array[Double]) -> Double,
) -> Double {
  let orig = predict_fn(instance)
  let mut max_change = 0.0
  let mut state = detector.seed
  for _ in 0..<10 {
    let perturbed : Array[Double] = []
    for j in 0..<instance.length() {
      let (r, ns) = sa_rand(state)
      state = ns
      perturbed.push(instance[j] + (r - 0.5) * 2.0 * detector.perturbation_size)
    }
    let change = sa_abs(predict_fn(perturbed) - orig)
    if change > max_change {
      max_change = change
    }
  }
  max_change
}

/// 检测对抗 / Detect adversarial.
pub fn detect_adversarial(
  detector : AdversarialDetector,
  instance : Array[Double],
  predict_fn : (Array[Double]) -> Double,
) -> (Bool, Double) {
  let score = adversarial_score(detector, instance, predict_fn)
  (score > detector.sensitivity_threshold, score)
}

///===
/// 提示注入 / Prompt injection

/// 提示注入检测器 / Prompt injection detector.
pub struct PromptInjectionDetector {
  injection_patterns : Array[String]
  system_markers : Array[String]
}

/// 构造提示注入检测器 / Create prompt injection detector.
pub fn make_prompt_injection(injection_patterns : Array[String], system_markers : Array[String]) -> PromptInjectionDetector {
  { injection_patterns: injection_patterns, system_markers: system_markers }
}

/// 检测注入 / Detect injection.
pub fn detect_injection(detector : PromptInjectionDetector, prompt : String) -> (Bool, String) {
  let lower = sa_to_lower(prompt)
  for i in 0..<detector.injection_patterns.length() {
    let pat = sa_to_lower(detector.injection_patterns[i])
    if sa_contains(lower, pat) {
      return (true, "injection pattern: " + detector.injection_patterns[i])
    }
  }
  for i in 0..<detector.system_markers.length() {
    let pat = sa_to_lower(detector.system_markers[i])
    if sa_contains(lower, pat) {
      return (true, "system marker: " + detector.system_markers[i])
    }
  }
  (false, "")
}

/// 清洗提示 / Sanitize prompt.
pub fn sanitize_prompt(detector : PromptInjectionDetector, prompt : String) -> String {
  let mut result = prompt
  let lower = sa_to_lower(prompt)
  for i in 0..<detector.injection_patterns.length() {
    let pat = sa_to_lower(detector.injection_patterns[i])
    if sa_contains(lower, pat) {
      result = "[FILTERED]"
    }
  }
  for i in 0..<detector.system_markers.length() {
    let pat = sa_to_lower(detector.system_markers[i])
    if sa_contains(lower, pat) {
      result = "[FILTERED]"
    }
  }
  let _ = detector
  result
}

///===
/// 速率限制 / Rate limit

/// 速率限制器 / Rate limiter.
pub struct RateLimiterAI {
  max_requests : Int
  window_seconds : Int
  current_count : Int
  quota : Int
}

/// 构造速率限制器 / Create rate limiter.
pub fn make_rate_limiter_ai(max_requests : Int, window_seconds : Int, quota : Int) -> RateLimiterAI {
  { max_requests: max_requests, window_seconds: window_seconds, current_count: 0, quota: quota }
}

/// 速率限制 / Rate limit.
pub fn rate_limit_ai(limiter : RateLimiterAI) -> (Bool, RateLimiterAI) {
  if limiter.current_count >= limiter.max_requests {
    (false, limiter)
  } else {
    (true, { ..limiter, current_count: limiter.current_count + 1 })
  }
}

/// 检查配额 / Check quota.
pub fn check_quota(limiter : RateLimiterAI) -> Bool {
  limiter.quota > 0
}

///===
/// 内容过滤 / Content filter

/// 内容过滤器 / Content filter.
pub struct ContentFilter {
  policies : Array[String]
  blocked_topics : Array[String]
}

/// 构造内容过滤器 / Create content filter.
pub fn make_content_filter(policies : Array[String], blocked_topics : Array[String]) -> ContentFilter {
  { policies: policies, blocked_topics: blocked_topics }
}

/// 过滤内容 / Filter content.
pub fn filter_content(filter : ContentFilter, content : String) -> (Bool, String) {
  let lower = sa_to_lower(content)
  for i in 0..<filter.blocked_topics.length() {
    let pat = sa_to_lower(filter.blocked_topics[i])
    if sa_contains(lower, pat) {
      return (false, "blocked topic: " + filter.blocked_topics[i])
    }
  }
  (true, "")
}

/// 内容策略 / Content policy.
pub fn content_policy(filter : ContentFilter) -> String {
  let mut result = "Content Policy:\n"
  for i in 0..<filter.policies.length() {
    result = result + "  - " + filter.policies[i] + "\n"
  }
  result = result + "Blocked topics: "
  for i in 0..<filter.blocked_topics.length() {
    if i > 0 {
      result = result + ", "
    }
    result = result + filter.blocked_topics[i]
  }
  result
}

///===
/// 安全监控 / Safety monitor

/// 安全监控器 / Safety monitor.
pub struct SafetyMonitor {
  alert_threshold : Double
  history : Array[Double]
  max_history : Int
}

/// 构造安全监控器 / Create safety monitor.
pub fn make_safety_monitor(alert_threshold : Double, max_history : Int) -> SafetyMonitor {
  { alert_threshold: alert_threshold, history: [], max_history: max_history }
}

/// 监控检查 / Monitor check.
pub fn monitor_check(monitor : SafetyMonitor, risk_score : Double) -> SafetyMonitor {
  let mut new_history = monitor.history.copy()
  new_history.push(risk_score)
  if new_history.length() > monitor.max_history {
    let trimmed : Array[Double] = []
    let start = new_history.length() - monitor.max_history
    for i in start..<new_history.length() {
      trimmed.push(new_history[i])
    }
    new_history = trimmed
  }
  { ..monitor, history: new_history }
}

/// 监控告警 / Monitor alert.
pub fn monitor_alert(monitor : SafetyMonitor) -> (Bool, Double) {
  if monitor.history.length() == 0 {
    return (false, 0.0)
  }
  let m = sa_mean(monitor.history)
  (m > monitor.alert_threshold, m)
}

///===
/// 护栏 / Guardrail

/// 护栏 / Guardrail.
pub struct Guardrail {
  rules : Array[(String, Double)]
  enforce_action : String
}

/// 构造护栏 / Create guardrail.
pub fn make_guardrail(rules : Array[(String, Double)], enforce_action : String) -> Guardrail {
  { rules: rules, enforce_action: enforce_action }
}

/// 护栏检查 / Guardrail check.
pub fn guardrail_check(guardrail : Guardrail, input : String, risk_score : Double) -> Array[String] {
  let violations : Array[String] = []
  let lower = sa_to_lower(input)
  for i in 0..<guardrail.rules.length() {
    let (pattern, threshold) = guardrail.rules[i]
    let pat = sa_to_lower(pattern)
    if sa_contains(lower, pat) && risk_score > threshold {
      violations.push(pattern)
    }
  }
  violations
}

/// 护栏强制 / Guardrail enforce.
pub fn guardrail_enforce(guardrail : Guardrail, input : String, risk_score : Double) -> (Bool, String) {
  let violations = guardrail_check(guardrail, input, risk_score)
  if violations.length() > 0 {
    (false, guardrail.enforce_action)
  } else {
    (true, input)
  }
}

///===
/// 安全评估 / Safety eval

/// 安全评估器 / Safety evaluator.
pub struct SafetyEval {
  metrics : Array[String]
  weights : Array[Double]
}

/// 构造安全评估器 / Create safety evaluator.
pub fn make_safety_eval(metrics : Array[String], weights : Array[Double]) -> SafetyEval {
  { metrics: metrics, weights: weights }
}

/// 评估安全 / Evaluate safety.
pub fn eval_safety(evaluator : SafetyEval, scores : Array[Double]) -> Double {
  let mut sum = 0.0
  let mut wsum = 0.0
  let n = if scores.length() < evaluator.weights.length() { scores.length() } else { evaluator.weights.length() }
  for i in 0..<n {
    sum = sum + scores[i] * evaluator.weights[i]
    wsum = wsum + evaluator.weights[i]
  }
  if wsum > 0.0 {
    sum / wsum
  } else {
    0.0
  }
}

/// 评估鲁棒性 / Evaluate robustness.
pub fn eval_robustness(
  evaluator : SafetyEval,
  instance : Array[Double],
  predict_fn : (Array[Double]) -> Double,
  perturbation_size : Double,
) -> Double {
  let orig = predict_fn(instance)
  let mut max_change = 0.0
  let mut state = 123
  for _ in 0..<20 {
    let perturbed : Array[Double] = []
    for j in 0..<instance.length() {
      let (r, ns) = sa_rand(state)
      state = ns
      perturbed.push(instance[j] + (r - 0.5) * 2.0 * perturbation_size)
    }
    let change = sa_abs(predict_fn(perturbed) - orig)
    if change > max_change {
      max_change = change
    }
  }
  let _ = evaluator
  1.0 / (1.0 + max_change)
}

///===
/// 攻击模拟 / Attack simulation

/// 攻击模拟器 / Attack simulator.
pub struct AttackSimulator {
  attack_types : Array[String]
  intensity : Double
  seed : Int
}

/// 构造攻击模拟器 / Create attack simulator.
pub fn make_attack_simulator(attack_types : Array[String], intensity : Double, seed : Int) -> AttackSimulator {
  { attack_types: attack_types, intensity: intensity, seed: seed }
}

/// 模拟攻击 / Simulate attack.
pub fn simulate_attack(simulator : AttackSimulator, instance : Array[Double]) -> Array[Double] {
  let attacked : Array[Double] = []
  let mut state = simulator.seed
  for j in 0..<instance.length() {
    let (r, ns) = sa_rand(state)
    state = ns
    attacked.push(instance[j] + (r - 0.5) * 2.0 * simulator.intensity)
  }
  attacked
}

/// 评估防御 / Evaluate defense.
pub fn evaluate_defense(
  simulator : AttackSimulator,
  instance : Array[Double],
  predict_fn : (Array[Double]) -> Double,
  defense_fn : (Array[Double]) -> Double,
) -> Double {
  let orig = predict_fn(instance)
  let mut total_change = 0.0
  for _ in 0..<10 {
    let attacked = simulate_attack(simulator, instance)
    let defended = defense_fn(attacked)
    total_change = total_change + sa_abs(defended - orig)
  }
  1.0 / (1.0 + total_change / 10.0)
}

///===
/// 数据投毒 / Data poisoning

/// 数据投毒检测器 / Data poisoning detector.
pub struct DataPoisoning {
  contamination_ratio : Double
  seed : Int
}

/// 构造数据投毒检测器 / Create data poisoning detector.
pub fn make_data_poisoning(contamination_ratio : Double, seed : Int) -> DataPoisoning {
  { contamination_ratio: contamination_ratio, seed: seed }
}

/// 检测投毒 / Detect poisoning.
pub fn detect_poisoning(
  detector : DataPoisoning,
  instances : Array[Array[Double]],
  labels : Array[Double],
) -> Array[Int] {
  let suspicious : Array[Int] = []
  if instances.length() == 0 {
    return suspicious
  }
  let n = instances[0].length()
  let feature_means : Array[Double] = []
  for j in 0..<n {
    let mut s = 0.0
    for i in 0..<instances.length() {
      s = s + instances[i][j]
    }
    feature_means.push(s / instances.length().to_double())
  }
  let feature_stds : Array[Double] = []
  for j in 0..<n {
    let mut s = 0.0
    for i in 0..<instances.length() {
      let d = instances[i][j] - feature_means[j]
      s = s + d * d
    }
    feature_stds.push(sa_sqrt(s / instances.length().to_double()))
  }
  for i in 0..<instances.length() {
    let mut max_z = 0.0
    for j in 0..<n {
      if feature_stds[j] > 0.000001 {
        let z = sa_abs(instances[i][j] - feature_means[j]) / feature_stds[j]
        if z > max_z {
          max_z = z
        }
      }
    }
    if max_z > 3.0 {
      suspicious.push(i)
    }
  }
  let _ = detector
  let _ = labels
  suspicious
}

/// 投毒鲁棒性 / Poisoning robustness.
pub fn poisoning_robustness(
  detector : DataPoisoning,
  instances : Array[Array[Double]],
  labels : Array[Double],
  predict_fn : (Array[Double]) -> Double,
) -> Double {
  let suspicious = detect_poisoning(detector, instances, labels)
  let mut clean_err = 0.0
  let mut poisoned_err = 0.0
  let mut clean_count = 0
  for i in 0..<instances.length() {
    let mut is_suspicious = false
    for j in 0..<suspicious.length() {
      if suspicious[j] == i {
        is_suspicious = true
      }
    }
    let err = sa_abs(predict_fn(instances[i]) - labels[i])
    if is_suspicious {
      poisoned_err = poisoned_err + err
    } else {
      clean_err = clean_err + err
      clean_count = clean_count + 1
    }
  }
  if clean_count == 0 {
    0.0
  } else {
    1.0 / (1.0 + sa_abs(poisoned_err - clean_err / clean_count.to_double()))
  }
}

///===
/// 模型窃取 / Model stealing

/// 模型窃取检测器 / Model stealing detector.
pub struct ModelStealing {
  query_threshold : Int
  diversity_threshold : Double
  query_history : Array[Array[Double]]
}

/// 构造模型窃取检测器 / Create model stealing detector.
pub fn make_model_stealing(query_threshold : Int, diversity_threshold : Double) -> ModelStealing {
  { query_threshold: query_threshold, diversity_threshold: diversity_threshold, query_history: [] }
}

/// 检测窃取 / Detect stealing.
pub fn detect_stealing(detector : ModelStealing, new_queries : Array[Array[Double]]) -> (Bool, String) {
  let total = detector.query_history.length() + new_queries.length()
  if total > detector.query_threshold {
    return (true, "excessive queries")
  }
  let all_queries = detector.query_history.copy()
  for i in 0..<new_queries.length() {
    all_queries.push(new_queries[i])
  }
  if all_queries.length() > 100 {
    let mut duplicates = 0
    for i in 0..<all_queries.length() {
      for j in (i + 1)..<all_queries.length() {
        if all_queries[i].length() == all_queries[j].length() {
          let mut same = true
          for k in 0..<all_queries[i].length() {
            if sa_abs(all_queries[i][k] - all_queries[j][k]) > 0.000001 {
              same = false
            }
          }
          if same {
            duplicates = duplicates + 1
          }
        }
      }
    }
    if duplicates > all_queries.length() / 2 {
      return (true, "low diversity queries")
    }
  }
  (false, "")
}

/// 保护模型 / Protect model.
pub fn protect_model(detector : ModelStealing, new_queries : Array[Array[Double]]) -> (ModelStealing, Bool) {
  let (is_stealing, _) = detect_stealing(detector, new_queries)
  let updated_history = detector.query_history.copy()
  for i in 0..<new_queries.length() {
    updated_history.push(new_queries[i])
  }
  ({ ..detector, query_history: updated_history }, !(is_stealing))
}

///===
/// 差分隐私 / Differential privacy

/// 差分隐私机制 / Privacy preserve.
pub struct PrivacyPreserve {
  epsilon : Double
  delta : Double
  sensitivity : Double
  seed : Int
}

/// 构造差分隐私 / Create privacy preserve.
pub fn make_privacy_preserve(epsilon : Double, delta : Double, sensitivity : Double, seed : Int) -> PrivacyPreserve {
  { epsilon: epsilon, delta: delta, sensitivity: sensitivity, seed: seed }
}

/// 差分隐私机制 / DP mechanism (Laplace).
pub fn dp_mechanism(mechanism : PrivacyPreserve, value : Double) -> Double {
  let (r1, ns1) = sa_rand(mechanism.seed)
  let (r2, ns2) = sa_rand(ns1)
  let _ = ns2
  let u = r1 - 0.5
  let scale = mechanism.sensitivity / mechanism.epsilon
  if scale < 0.000001 {
    value
  } else if u < 0.0 {
    value + scale * sa_log(1.0 - 2.0 * sa_abs(u))
  } else if r2 > 0.5 {
    value + scale * sa_log(1.0 - 2.0 * sa_abs(u))
  } else {
    value - scale * sa_log(1.0 - 2.0 * sa_abs(u))
  }
}

/// 差分隐私预算 / DP budget.
pub fn dp_budget(mechanism : PrivacyPreserve, num_queries : Int) -> Double {
  mechanism.epsilon * num_queries.to_double()
}

///===
/// 公平性 / Fairness

/// 公平性配置 / Fairness config.
pub struct Fairness {
  threshold : Double
  protected_idx : Int
}

/// 构造公平性 / Create fairness.
pub fn make_fairness(threshold : Double, protected_idx : Int) -> Fairness {
  { threshold: threshold, protected_idx: protected_idx }
}

/// 人口统计平价 / Demographic parity.
pub fn demographic_parity(
  fairness : Fairness,
  predictions : Array[Double],
  groups : Array[Int],
) -> Double {
  let mut group0_sum = 0.0
  let mut group0_cnt = 0
  let mut group1_sum = 0.0
  let mut group1_cnt = 0
  for i in 0..<predictions.length() {
    if groups[i] == 0 {
      group0_sum = group0_sum + predictions[i]
      group0_cnt = group0_cnt + 1
    } else {
      group1_sum = group1_sum + predictions[i]
      group1_cnt = group1_cnt + 1
    }
  }
  let p0 = if group0_cnt > 0 { group0_sum / group0_cnt.to_double() } else { 0.0 }
  let p1 = if group1_cnt > 0 { group1_sum / group1_cnt.to_double() } else { 0.0 }
  let _ = fairness
  sa_abs(p0 - p1)
}

/// 均等赔率 / Equalized odds.
pub fn equalized_odds(
  fairness : Fairness,
  predictions : Array[Double],
  labels : Array[Double],
  groups : Array[Int],
) -> Double {
  let mut g0_tpr = 0.0
  let mut g0_tpr_n = 0
  let mut g0_fpr = 0.0
  let mut g0_fpr_n = 0
  let mut g1_tpr = 0.0
  let mut g1_tpr_n = 0
  let mut g1_fpr = 0.0
  let mut g1_fpr_n = 0
  for i in 0..<predictions.length() {
    if groups[i] == 0 {
      if sa_abs(labels[i] - 1.0) < 0.000001 {
        g0_tpr = g0_tpr + predictions[i]
        g0_tpr_n = g0_tpr_n + 1
      } else {
        g0_fpr = g0_fpr + predictions[i]
        g0_fpr_n = g0_fpr_n + 1
      }
    } else {
      if sa_abs(labels[i] - 1.0) < 0.000001 {
        g1_tpr = g1_tpr + predictions[i]
        g1_tpr_n = g1_tpr_n + 1
      } else {
        g1_fpr = g1_fpr + predictions[i]
        g1_fpr_n = g1_fpr_n + 1
      }
    }
  }
  let tpr0 = if g0_tpr_n > 0 { g0_tpr / g0_tpr_n.to_double() } else { 0.0 }
  let tpr1 = if g1_tpr_n > 0 { g1_tpr / g1_tpr_n.to_double() } else { 0.0 }
  let fpr0 = if g0_fpr_n > 0 { g0_fpr / g0_fpr_n.to_double() } else { 0.0 }
  let fpr1 = if g1_fpr_n > 0 { g1_fpr / g1_fpr_n.to_double() } else { 0.0 }
  let _ = fairness
  sa_abs(tpr0 - tpr1) + sa_abs(fpr0 - fpr1)
}

/// 均等机会 / Equal opportunity.
pub fn equal_opportunity(
  fairness : Fairness,
  predictions : Array[Double],
  labels : Array[Double],
  groups : Array[Int],
) -> Double {
  let mut g0_tpr = 0.0
  let mut g0_tpr_n = 0
  let mut g1_tpr = 0.0
  let mut g1_tpr_n = 0
  for i in 0..<predictions.length() {
    if sa_abs(labels[i] - 1.0) < 0.000001 {
      if groups[i] == 0 {
        g0_tpr = g0_tpr + predictions[i]
        g0_tpr_n = g0_tpr_n + 1
      } else {
        g1_tpr = g1_tpr + predictions[i]
        g1_tpr_n = g1_tpr_n + 1
      }
    }
  }
  let tpr0 = if g0_tpr_n > 0 { g0_tpr / g0_tpr_n.to_double() } else { 0.0 }
  let tpr1 = if g1_tpr_n > 0 { g1_tpr / g1_tpr_n.to_double() } else { 0.0 }
  let _ = fairness
  sa_abs(tpr0 - tpr1)
}

///===
/// 对齐 / Alignment

/// 对齐配置 / Alignment config.
pub struct Alignment {
  principles : Array[String]
  threshold : Double
}

/// 构造对齐 / Create alignment.
pub fn make_alignment(principles : Array[String], threshold : Double) -> Alignment {
  { principles: principles, threshold: threshold }
}

/// 对齐检查 / Alignment check.
pub fn alignment_check(alignment : Alignment, response : String, scores : Array[Double]) -> Array[String] {
  let violations : Array[String] = []
  let lower = sa_to_lower(response)
  for i in 0..<alignment.principles.length() {
    let principle = sa_to_lower(alignment.principles[i])
    let score = if i < scores.length() { scores[i] } else { 0.0 }
    if sa_contains(lower, "violate " + principle) || score < alignment.threshold {
      violations.push(alignment.principles[i])
    }
  }
  violations
}

/// 对齐分数 / Alignment score.
pub fn alignment_score(alignment : Alignment, scores : Array[Double]) -> Double {
  if scores.length() == 0 {
    return 1.0
  }
  let mut sum = 0.0
  let n = if scores.length() < alignment.principles.length() { scores.length() } else { alignment.principles.length() }
  if n == 0 {
    return 1.0
  }
  for i in 0..<n {
    sum = sum + scores[i]
  }
  sum / n.to_double()
}

///===
/// ID

pub fn safety_ai_id() -> String {
  "agent_kit/safety_ai"
}