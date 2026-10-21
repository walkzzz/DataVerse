///|
/// # agent_kit/agent_eval Agent 评估 / Agent Evaluation
///
/// Agent 评估指标、基准、测试套件、人工评估、自动评估、多轮对话、排行榜。
/// S11.5 新建。
///
/// # Agent evaluation

///|
/// 评估配置 / Eval configuration.
pub struct EvalConfig {
  name : String
  metrics : Array[String]
  threshold : Double
  sample_size : Int32
  seed : Int32
}

///|
/// 任务结果 / Task result.
pub struct TaskResult {
  task_id : String
  success : Bool
  completion : Double
  latency_ms : Double
  cost : Double
  tokens : Int32
  api_calls : Int32
}

///|
/// 构造评估配置 / Create eval config.
pub fn make_eval_config(
  name : String,
  metrics : Array[String],
  threshold : Double,
  sample_size : Int32,
  seed : Int32,
) -> EvalConfig {
  { name, metrics, threshold, sample_size, seed, }
}

///|
/// 任务成功率 / Eval task success rate.
pub fn eval_task_success(results : Array[TaskResult]) -> Double {
  let n = results.length()
  if n == 0 {
    0.0
  } else {
    let mut succ = 0
    for i in 0..<n {
      if results[i].success {
        succ = succ + 1
      }
    }
    succ.to_double() / n.to_double()
  }
}

///|
/// 任务完成度 / Eval task completion.
pub fn eval_task_completion(results : Array[TaskResult]) -> Double {
  let n = results.length()
  if n == 0 {
    0.0
  } else {
    let mut sum = 0.0
    for i in 0..<n {
      sum = sum + results[i].completion
    }
    sum / n.to_double()
  }
}

///|
/// 准确性评估 / Eval accuracy.
pub fn eval_accuracy_agent(
  predictions : Array[String],
  ground_truth : Array[String],
) -> Double {
  let n = predictions.length()
  let m = ground_truth.length()
  let len = if n < m { n } else { m }
  if len == 0 {
    0.0
  } else {
    let mut correct = 0
    for i in 0..<len {
      if predictions[i] == ground_truth[i] {
        correct = correct + 1
      }
    }
    correct.to_double() / len.to_double()
  }
}

///|
/// 效率评估 / Eval efficiency.
pub fn eval_efficiency(results : Array[TaskResult]) -> Double {
  let n = results.length()
  if n == 0 {
    0.0
  } else {
    let mut sum = 0.0
    for i in 0..<n {
      if results[i].latency_ms > 0.0 {
        sum = sum + 1000.0 / results[i].latency_ms
      }
    }
    sum / n.to_double()
  }
}

///|
/// 延迟评估 / Eval latency (avg ms).
pub fn eval_latency(results : Array[TaskResult]) -> Double {
  let n = results.length()
  if n == 0 {
    0.0
  } else {
    let mut sum = 0.0
    for i in 0..<n {
      sum = sum + results[i].latency_ms
    }
    sum / n.to_double()
  }
}

///|
/// 成本评估 / Eval cost.
pub fn eval_cost_agent(results : Array[TaskResult]) -> Double {
  let mut sum = 0.0
  for i in 0..<results.length() {
    sum = sum + results[i].cost
  }
  sum
}

///|
/// Token 用量评估 / Eval token usage.
pub fn eval_token_usage(results : Array[TaskResult]) -> Int32 {
  let mut sum = 0
  for i in 0..<results.length() {
    sum = sum + results[i].tokens
  }
  sum
}

///|
/// API 调用次数评估 / Eval API calls.
pub fn eval_api_calls(results : Array[TaskResult]) -> Int32 {
  let mut sum = 0
  for i in 0..<results.length() {
    sum = sum + results[i].api_calls
  }
  sum
}

///===
/// 推理与质量 / Reasoning and quality

///|
/// 推理质量评估 / Eval reasoning quality.
pub fn eval_reasoning_quality(
  steps : Array[String],
  expected : Array[String],
) -> Double {
  let n = steps.length()
  if n == 0 {
    0.0
  } else {
    let m = expected.length()
    let mut score = 0.0
    for i in 0..<n {
      if i < m && steps[i] == expected[i] {
        score = score + 1.0
      }
    }
    score / n.to_double()
  }
}

///|
/// 事实准确性评估 / Eval factual accuracy.
pub fn eval_factual_accuracy(claims : Array[Bool]) -> Double {
  let n = claims.length()
  if n == 0 {
    0.0
  } else {
    let mut correct = 0
    for i in 0..<n {
      if claims[i] {
        correct = correct + 1
      }
    }
    correct.to_double() / n.to_double()
  }
}

///|
/// 连贯性评估 / Eval coherence.
pub fn eval_coherence(sentences : Array[String]) -> Double {
  let n = sentences.length()
  if n <= 1 {
    1.0
  } else {
    let mut overlap = 0
    for i in 0..<(n - 1) {
      if sentences[i].length() > 0 && sentences[i + 1].length() > 0 {
        overlap = overlap + 1
      }
    }
    overlap.to_double() / (n - 1).to_double()
  }
}

///===
/// 安全与偏见 / Safety and bias

///|
/// 安全评估 / Eval safety.
pub fn eval_safety_agent(flags : Array[Bool]) -> Double {
  let n = flags.length()
  if n == 0 {
    1.0
  } else {
    let mut safe = 0
    for i in 0..<n {
      if !flags[i] {
        safe = safe + 1
      }
    }
    safe.to_double() / n.to_double()
  }
}

///|
/// 偏见评估 / Eval bias.
pub fn eval_bias_agent(group_scores : Array[(String, Double)]) -> Double {
  let n = group_scores.length()
  if n == 0 {
    1.0
  } else {
    let mut sum = 0.0
    for i in 0..<n {
      sum = sum + group_scores[i].1
    }
    let mean = sum / n.to_double()
    let mut variance = 0.0
    for i in 0..<n {
      let diff = group_scores[i].1 - mean
      variance = variance + diff * diff
    }
    variance = variance / n.to_double()
    1.0 / (1.0 + variance)
  }
}

///|
/// 毒性评估 / Eval toxicity.
pub fn eval_toxicity_agent(scores : Array[Double]) -> Double {
  let n = scores.length()
  if n == 0 {
    1.0
  } else {
    let mut sum = 0.0
    for i in 0..<n {
      sum = sum + scores[i]
    }
    1.0 - sum / n.to_double()
  }
}

///===
/// 用户满意度 / User satisfaction

///|
/// 用户满意度评估 / Eval user satisfaction.
pub fn eval_user_satisfaction(
  ratings : Array[Int32],
  max_rating : Int32,
) -> Double {
  let n = ratings.length()
  if n == 0 || max_rating == 0 {
    0.0
  } else {
    let mut sum = 0
    for i in 0..<n {
      sum = sum + ratings[i]
    }
    sum.to_double() / (n.to_double() * max_rating.to_double())
  }
}

///|
/// 反馈分数评估 / Eval feedback score.
pub fn eval_feedback_score(feedbacks : Array[Double]) -> Double {
  let n = feedbacks.length()
  if n == 0 {
    0.0
  } else {
    let mut sum = 0.0
    for i in 0..<n {
      sum = sum + feedbacks[i]
    }
    sum / n.to_double()
  }
}

///===
/// 基准测试 / Benchmark

///|
/// 基准测试 / Benchmark.
pub struct BenchmarkAgent {
  name : String
  tasks : Array[String]
  iterations : Int32
}

///|
/// 基准结果 / Benchmark result.
pub struct BenchmarkResult {
  name : String
  avg_latency : Double
  avg_cost : Double
  success_rate : Double
}

///|
/// 构造基准 / Create benchmark.
pub fn make_benchmark_agent(
  name : String,
  tasks : Array[String],
  iterations : Int32,
) -> BenchmarkAgent {
  { name, tasks, iterations, }
}

///|
/// 运行基准 / Run benchmark.
pub fn benchmark_run(
  bench : BenchmarkAgent,
  results : Array[TaskResult],
) -> BenchmarkResult {
  let n = results.length()
  if n == 0 {
    { name: bench.name, avg_latency: 0.0, avg_cost: 0.0, success_rate: 0.0, }
  } else {
    let mut lat = 0.0
    let mut cost = 0.0
    let mut succ = 0
    for i in 0..<n {
      lat = lat + results[i].latency_ms
      cost = cost + results[i].cost
      if results[i].success {
        succ = succ + 1
      }
    }
    let nd = n.to_double()
    {
      name: bench.name,
      avg_latency: lat / nd,
      avg_cost: cost / nd,
      success_rate: succ.to_double() / nd,
    }
  }
}

///|
/// 比较基准 / Compare benchmarks.
pub fn benchmark_compare(a : BenchmarkResult, b : BenchmarkResult) -> String {
  let lat_diff = b.avg_latency - a.avg_latency
  let cost_diff = b.avg_cost - a.avg_cost
  let succ_diff = b.success_rate - a.success_rate
  "latency_diff=" +
  lat_diff.to_string() +
  ",cost_diff=" +
  cost_diff.to_string() +
  ",success_diff=" +
  succ_diff.to_string()
}

///===
/// 测试套件 / Test suite

///|
/// 测试用例 / Test case.
pub struct TestCase {
  name : String
  input : String
  expected : String
}

///|
/// 测试套件 / Test suite.
pub struct TestSuite {
  name : String
  cases : Array[TestCase]
}

///|
/// 测试运行结果 / Test run result.
pub struct TestRunResult {
  name : String
  passed : Bool
  actual : String
}

///|
/// 构造测试用例 / Create test case.
pub fn test_case(name : String, input : String, expected : String) -> TestCase {
  { name, input, expected, }
}

///|
/// 构造测试套件 / Create test suite.
pub fn make_test_suite(name : String, cases : Array[TestCase]) -> TestSuite {
  { name, cases, }
}

///|
/// 运行测试 / Run test suite.
pub fn test_run(
  suite : TestSuite,
  run_fn : (String) -> String,
) -> Array[TestRunResult] {
  let result : Array[TestRunResult] = []
  for i in 0..<suite.cases.length() {
    let c = suite.cases[i]
    let actual = run_fn(c.input)
    let passed = actual == c.expected
    result.push({ name: c.name, passed, actual, })
  }
  result
}

///|
/// 评估测试 / Evaluate test results.
pub fn test_evaluate(results : Array[TestRunResult]) -> Double {
  let n = results.length()
  if n == 0 {
    0.0
  } else {
    let mut passed = 0
    for i in 0..<n {
      if results[i].passed {
        passed = passed + 1
      }
    }
    passed.to_double() / n.to_double()
  }
}

///===
/// 人工评估 / Human evaluation

///|
/// 人工评估条目 / Human eval entry.
pub struct HumanEvalItem {
  sample_id : Int32
  output : String
  rating : Int32
}

///|
/// 人工评估 / Human eval.
pub struct HumanEval {
  items : Array[HumanEvalItem]
  max_rating : Int32
}

///|
/// 构造人工评估 / Create human eval.
pub fn make_human_eval(
  items : Array[HumanEvalItem],
  max_rating : Int32,
) -> HumanEval {
  { items, max_rating, }
}

///|
/// 人工评分 / Human eval score.
pub fn human_eval_score(eval : HumanEval) -> Double {
  let n = eval.items.length()
  if n == 0 || eval.max_rating == 0 {
    0.0
  } else {
    let mut sum = 0
    for i in 0..<n {
      sum = sum + eval.items[i].rating
    }
    sum.to_double() / (n.to_double() * eval.max_rating.to_double())
  }
}

///|
/// 人工一致性 / Human eval agreement.
pub fn human_eval_agreement(
  rater_a : Array[Int32],
  rater_b : Array[Int32],
) -> Double {
  let n = rater_a.length()
  let m = rater_b.length()
  if n == 0 || m != n {
    0.0
  } else {
    let mut agree = 0
    for i in 0..<n {
      if rater_a[i] == rater_b[i] {
        agree = agree + 1
      }
    }
    agree.to_double() / n.to_double()
  }
}

///===
/// 自动评估 / Auto evaluation

///|
/// 自动评估 / Auto eval.
pub struct AutoEval {
  rubric : Array[(String, Double)]
  weights : Array[Double]
}

///|
/// 构造自动评估 / Create auto eval.
pub fn make_auto_eval(
  rubric : Array[(String, Double)],
  weights : Array[Double],
) -> AutoEval {
  { rubric, weights, }
}

///|
/// 自动评分 / Auto eval score.
pub fn auto_eval_score(eval : AutoEval) -> Double {
  let n = eval.rubric.length()
  if n == 0 {
    0.0
  } else {
    let m = eval.weights.length()
    let mut sum = 0.0
    let mut wsum = 0.0
    for i in 0..<n {
      let w = if i < m { eval.weights[i] } else { 1.0 }
      sum = sum + eval.rubric[i].1 * w
      wsum = wsum + w
    }
    if wsum == 0.0 {
      0.0
    } else {
      sum / wsum
    }
  }
}

///|
/// 自动评分准则 / Auto eval rubric.
pub fn auto_eval_rubric(eval : AutoEval) -> String {
  let mut s = ""
  for i in 0..<eval.rubric.length() {
    s = s + eval.rubric[i].0 + ":" + eval.rubric[i].1.to_string()
    if i < eval.rubric.length() - 1 {
      s = s + ";"
    }
  }
  s
}

///===
/// 多轮对话 / Multi-turn conversation

///|
/// 对话轮次 / Dialog turn.
pub struct DialogTurn {
  role : String
  content : String
  latency : Double
}

///|
/// 多轮对话 / Multi-turn dialog.
pub struct MultiTurnDialog {
  id : String
  turns : Array[DialogTurn]
}

///|
/// 多轮评估 / Eval multi-turn.
pub fn eval_multi_turn(dialog : MultiTurnDialog) -> Double {
  let n = dialog.turns.length()
  if n == 0 {
    0.0
  } else {
    let mut sum = 0.0
    for i in 0..<n {
      if dialog.turns[i].content.length() > 0 {
        sum = sum + 1.0
      }
    }
    sum / n.to_double()
  }
}

///|
/// 对话评估 / Eval conversation.
pub fn eval_conversation(dialog : MultiTurnDialog) -> Double {
  let n = dialog.turns.length()
  if n == 0 {
    0.0
  } else {
    let mut total_lat = 0.0
    let mut count = 0
    for i in 0..<n {
      if dialog.turns[i].role == "assistant" {
        total_lat = total_lat + dialog.turns[i].latency
        count = count + 1
      }
    }
    if count == 0 {
      0.0
    } else {
      total_lat / count.to_double()
    }
  }
}

///|
/// 对话质量评估 / Eval dialog quality.
pub fn eval_dialog_quality(dialog : MultiTurnDialog) -> Double {
  let n = dialog.turns.length()
  if n == 0 {
    0.0
  } else {
    let mut user_count = 0
    let mut assistant_count = 0
    for i in 0..<n {
      if dialog.turns[i].role == "user" {
        user_count = user_count + 1
      }
      if dialog.turns[i].role == "assistant" {
        assistant_count = assistant_count + 1
      }
    }
    if user_count == 0 {
      0.0
    } else {
      assistant_count.to_double() / user_count.to_double()
    }
  }
}

///===
/// 工具与规划 / Tool use and planning

///|
/// 工具使用评估 / Eval tool use.
pub fn eval_tool_use(
  tool_calls : Array[Bool],
  expected_calls : Int32,
) -> Double {
  let n = tool_calls.length()
  if n == 0 || expected_calls == 0 {
    0.0
  } else {
    let mut correct = 0
    for i in 0..<n {
      if tool_calls[i] {
        correct = correct + 1
      }
    }
    correct.to_double() / expected_calls.to_double()
  }
}

///|
/// 规划质量评估 / Eval planning quality.
pub fn eval_planning_quality(
  plan : Array[String],
  reference : Array[String],
) -> Double {
  let n = plan.length()
  let m = reference.length()
  if n == 0 || m == 0 {
    0.0
  } else {
    let mut common = 0
    for i in 0..<n {
      for j in 0..<m {
        if plan[i] == reference[j] {
          common = common + 1
        }
      }
    }
    let denom = n + m - common
    if denom == 0 {
      0.0
    } else {
      common.to_double() / denom.to_double()
    }
  }
}

///|
/// 记忆使用评估 / Eval memory use.
pub fn eval_memory_use(memory_hits : Array[Bool]) -> Double {
  let n = memory_hits.length()
  if n == 0 {
    0.0
  } else {
    let mut hits = 0
    for i in 0..<n {
      if memory_hits[i] {
        hits = hits + 1
      }
    }
    hits.to_double() / n.to_double()
  }
}

///===
/// 创造性 / Creativity

///|
/// 创造性评估 / Eval creative.
pub fn eval_creative(outputs : Array[String]) -> Double {
  let n = outputs.length()
  if n == 0 {
    0.0
  } else {
    let mut unique = 0
    for i in 0..<n {
      let mut is_unique = true
      for j in 0..<n {
        if i != j && outputs[i] == outputs[j] {
          is_unique = false
        }
      }
      if is_unique {
        unique = unique + 1
      }
    }
    unique.to_double() / n.to_double()
  }
}

///|
/// 多样性评估 / Eval diversity.
pub fn eval_diversity(outputs : Array[String]) -> Double {
  let n = outputs.length()
  if n <= 1 {
    0.0
  } else {
    let mut total_len = 0
    for i in 0..<n {
      total_len = total_len + outputs[i].length()
    }
    let avg = total_len.to_double() / n.to_double()
    if avg == 0.0 {
      0.0
    } else {
      let mut variance = 0.0
      for i in 0..<n {
        let diff = outputs[i].length().to_double() - avg
        variance = variance + diff * diff
      }
      variance = variance / n.to_double()
      variance / (avg * avg + 1.0)
    }
  }
}

///|
/// 新颖性评估 / Eval novelty.
pub fn eval_novelty(outputs : Array[String], known : Array[String]) -> Double {
  let n = outputs.length()
  if n == 0 {
    0.0
  } else {
    let mut novel = 0
    for i in 0..<n {
      let mut is_novel = true
      for j in 0..<known.length() {
        if outputs[i] == known[j] {
          is_novel = false
        }
      }
      if is_novel {
        novel = novel + 1
      }
    }
    novel.to_double() / n.to_double()
  }
}

///===
/// 排行榜 / Leaderboard

///|
/// 排行榜条目 / Leaderboard entry.
pub struct LeaderboardEntry {
  agent_name : String
  score : Double
  rank : Int32
}

///|
/// 排行榜 / Leaderboard.
pub struct Leaderboard {
  name : String
  entries : Array[LeaderboardEntry]
}

///|
/// 构造排行榜 / Create leaderboard.
pub fn make_leaderboard(
  name : String,
  entries : Array[LeaderboardEntry],
) -> Leaderboard {
  { name, entries, }
}

///|
/// 更新排行榜 / Update leaderboard.
pub fn leaderboard_update(
  board : Leaderboard,
  entry : LeaderboardEntry,
) -> Leaderboard {
  let new_entries : Array[LeaderboardEntry] = []
  let mut found = false
  for i in 0..<board.entries.length() {
    if board.entries[i].agent_name == entry.agent_name {
      new_entries.push(entry)
      found = true
    } else {
      new_entries.push(board.entries[i])
    }
  }
  if !found {
    new_entries.push(entry)
  }
  let sorted = new_entries.copy()
  sorted.sort_by(fn(a, b) { b.score.compare(a.score) })
  let ranked : Array[LeaderboardEntry] = []
  for i in 0..<sorted.length() {
    ranked.push({ ..sorted[i], rank: i + 1, })
  }
  { name: board.name, entries: ranked, }
}

///|
/// 排名查询 / Get rank.
pub fn leaderboard_rank(board : Leaderboard, agent_name : String) -> Int32 {
  let mut r = 0
  for i in 0..<board.entries.length() {
    if board.entries[i].agent_name == agent_name {
      r = board.entries[i].rank
    }
  }
  r
}

///|
///===
/// ID
pub fn agent_eval_id() -> String {
  "agent_kit/agent_eval"
}
