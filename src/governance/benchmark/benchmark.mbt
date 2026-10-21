///|
/// # governance/benchmark 性能基准 / Performance Benchmark
///
/// 基准测试框架：配置 + 运行 + 统计。架构 §9 治理。S3.4 填充。
/// 模拟计时（MoonBit 无系统时钟 FFI），用条目数 × 单位开销模拟。
///
/// # Performance benchmark
///
/// Benchmark framework: config + run + stats. Simulated timing.

///|
/// 基准配置 / Benchmark configuration.
pub struct BenchmarkConfig {
  iterations : Int32
  warmup : Int32
  unit_cost_ms : Int32
} derive(Debug, Eq)

///|
pub extend BenchmarkConfig with Eq::{equal, not_equal}

///|
pub extend BenchmarkConfig with Debug::{to_repr}

///|
/// 构造基准配置 / Build benchmark config.
pub fn make_benchmark_config(
  iterations : Int32,
  warmup : Int32,
  unit_cost_ms : Int32,
) -> BenchmarkConfig {
  { iterations, warmup, unit_cost_ms, }
}

///|
/// 默认基准配置 / Default benchmark config.
pub fn default_benchmark_config() -> BenchmarkConfig {
  { iterations: 100, warmup: 10, unit_cost_ms: 1, }
}

///|
/// 基准结果 / Benchmark result.
pub struct BenchmarkResult {
  name : String
  total_ms : Int32
  avg_ms : Double
  min_ms : Int32
  max_ms : Int32
  throughput : Double
} derive(Debug, Eq)

///|
pub extend BenchmarkResult with Eq::{equal, not_equal}

///|
pub extend BenchmarkResult with Debug::{to_repr}

///|
/// 运行基准测试 / Run benchmark.
///
/// 模拟：total_ms = iterations * unit_cost_ms, avg = total / iterations, throughput = iterations / total_s.
/// 退化安全：iterations <= 0 返回 0 结果。
pub fn run_benchmark(
  name : String,
  item_count : Int32,
  config : BenchmarkConfig,
) -> BenchmarkResult {
  if config.iterations <= 0 {
    { name, total_ms: 0, avg_ms: 0.0, min_ms: 0, max_ms: 0, throughput: 0.0, }
  } else {
    let total = (config.iterations + config.warmup) *
      config.unit_cost_ms *
      item_count
    let avg = total.to_double() / config.iterations.to_double()
    let min_v = config.unit_cost_ms * item_count
    let max_v = config.unit_cost_ms * item_count * 2
    let throughput = if total == 0 {
      0.0
    } else {
      config.iterations.to_double() * 1000.0 / total.to_double()
    }
    {
      name,
      total_ms: total,
      avg_ms: avg,
      min_ms: min_v,
      max_ms: max_v,
      throughput,
    }
  }
}

///|
/// 基准测试套件 / Benchmark suite.
pub struct BenchmarkSuite {
  name : String
  results : Array[BenchmarkResult]
} derive(Debug, Eq)

///|
pub extend BenchmarkSuite with Eq::{equal, not_equal}

///|
pub extend BenchmarkSuite with Debug::{to_repr}

///|
/// 构造基准测试套件 / Build benchmark suite.
pub fn make_benchmark_suite(
  name : String,
  results : Array[BenchmarkResult],
) -> BenchmarkSuite {
  { name, results, }
}

///|
/// 空基准测试套件 / Empty benchmark suite.
pub fn empty_benchmark_suite(name : String) -> BenchmarkSuite {
  { name, results: [], }
}

///|
/// 添加基准结果 / Add benchmark result to suite.
pub fn add_result(
  suite : BenchmarkSuite,
  result : BenchmarkResult,
) -> BenchmarkSuite {
  let new_results : Array[BenchmarkResult] = []
  for i in 0..<suite.results.length() {
    new_results.push(suite.results[i])
  }
  new_results.push(result)
  { name: suite.name, results: new_results, }
}

///|
/// 套件统计 / Suite statistics.
pub struct SuiteStats {
  suite_name : String
  benchmark_count : Int32
  total_ms : Int32
  avg_throughput : Double
} derive(Debug, Eq)

///|
pub extend SuiteStats with Eq::{equal, not_equal}

///|
pub extend SuiteStats with Debug::{to_repr}

///|
/// 计算套件统计 / Compute suite stats.
pub fn compute_suite_stats(suite : BenchmarkSuite) -> SuiteStats {
  let count = suite.results.length()
  if count == 0 {
    {
      suite_name: suite.name,
      benchmark_count: 0,
      total_ms: 0,
      avg_throughput: 0.0,
    }
  } else {
    let mut total = 0
    let mut total_throughput = 0.0
    for i in 0..<count {
      total = total + suite.results[i].total_ms
      total_throughput = total_throughput + suite.results[i].throughput
    }
    {
      suite_name: suite.name,
      benchmark_count: count,
      total_ms: total,
      avg_throughput: total_throughput / count.to_double(),
    }
  }
}

///|
/// 基准测试套件 URI / Benchmark suite URI.
pub fn benchmark_suite_uri(suite : BenchmarkSuite) -> String {
  "benchmark://suite/" +
  suite.name +
  "?count=" +
  suite.results.length().to_string()
}

///|
pub fn benchmark_id() -> String {
  "governance/benchmark"
}
