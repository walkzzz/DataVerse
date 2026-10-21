///|
/// # parallel/cpu_parallel CPU 并行执行后端 / CPU Parallel Execution Backend
///
/// 分布式执行契约：分区 + shuffle + gather。架构 §3 + §6 S3.2。
/// S3.2 填充：契约 + 内存模拟（不引入真实多线程/分布式框架）。
///
/// # CPU parallel execution backend
///
/// Distributed execution contract: partition + shuffle + gather.

///|
/// 分区策略 / Partition strategy.
pub(all) enum PartitionStrategy {
  ByCount // 按条数均分
  BySize // 按字节大小均分
  ByKeyHash // 按键哈希分区
} derive(Debug, Eq)

///|
pub extend PartitionStrategy with Eq::{equal, not_equal}

///|
pub extend PartitionStrategy with Debug::{to_repr}

///|
/// 分区配置 / Partition configuration.
pub struct PartitionConfig {
  strategy : PartitionStrategy
  partition_count : Int32
  key_field : String
} derive(Debug, Eq)

///|
pub extend PartitionConfig with Eq::{equal, not_equal}

///|
pub extend PartitionConfig with Debug::{to_repr}

///|
/// 构造分区配置 / Build partition config.
pub fn make_partition_config(
  strategy : PartitionStrategy,
  partition_count : Int32,
  key_field : String,
) -> PartitionConfig {
  { strategy, partition_count, key_field, }
}

///|
/// 分区策略名称 / Partition strategy name.
pub fn partition_strategy_name(s : PartitionStrategy) -> String {
  match s {
    ByCount => "by_count"
    BySize => "by_size"
    ByKeyHash => "by_key_hash"
  }
}

///|
/// 数据分区 / Partition data.
///
/// 将数据按策略分为 partition_count 个分区，返回每个分区的条目数。
/// 退化安全：partition_count <= 0 返回空数组，空数据返回全 0 分区。
pub fn partition_data(
  data : Array[@dataobject.DataObject],
  config : PartitionConfig,
) -> Array[Int32] {
  let n = data.length()
  let k = config.partition_count
  if k <= 0 {
    []
  } else {
    let result = Array::make(k, 0)
    if n == 0 {
      result
    } else {
      match config.strategy {
        ByCount => {
          let base = n / k
          let rem = n % k
          for i in 0..<k {
            result[i] = base + (if i < rem { 1 } else { 0 })
          }
          result
        }
        BySize => {
          let base = n / k
          let rem = n % k
          for i in 0..<k {
            result[i] = base + (if i < rem { 1 } else { 0 })
          }
          result
        }
        ByKeyHash => {
          for i in 0..<n {
            let idx = i % k
            result[idx] = result[idx] + 1
          }
          result
        }
      }
    }
  }
}

///|
/// Shuffle 类型 / Shuffle type.
pub(all) enum ShuffleType {
  HashShuffle // 哈希 shuffle
  RangeShuffle // 范围 shuffle
  RandomShuffle // 随机 shuffle
} derive(Debug, Eq)

///|
pub extend ShuffleType with Eq::{equal, not_equal}

///|
pub extend ShuffleType with Debug::{to_repr}

///|
/// Shuffle 类型名称 / Shuffle type name.
pub fn shuffle_type_name(s : ShuffleType) -> String {
  match s {
    HashShuffle => "hash"
    RangeShuffle => "range"
    RandomShuffle => "random"
  }
}

///|
/// Shuffle 配置 / Shuffle configuration.
pub struct ShuffleConfig {
  shuffle_type : ShuffleType
  target_partitions : Int32
} derive(Debug, Eq)

///|
pub extend ShuffleConfig with Eq::{equal, not_equal}

///|
pub extend ShuffleConfig with Debug::{to_repr}

///|
/// 构造 shuffle 配置 / Build shuffle config.
pub fn make_shuffle_config(
  shuffle_type : ShuffleType,
  target_partitions : Int32,
) -> ShuffleConfig {
  { shuffle_type, target_partitions, }
}

///|
/// 执行 shuffle / Execute shuffle.
///
/// 模拟 shuffle：返回每个目标分区的条目数（均匀分布）。
/// 退化安全：target_partitions <= 0 返回空数组。
pub fn shuffle_data(
  data : Array[@dataobject.DataObject],
  config : ShuffleConfig,
) -> Array[Int32] {
  let n = data.length()
  let k = config.target_partitions
  if k <= 0 {
    []
  } else {
    let result = Array::make(k, 0)
    let base = n / k
    let rem = n % k
    for i in 0..<k {
      result[i] = base + (if i < rem { 1 } else { 0 })
    }
    result
  }
}

///|
/// Gather 模式 / Gather mode.
pub(all) enum GatherMode {
  Concat // 直接拼接
  MergeSorted // 有序合并
  Union // 去重合并
} derive(Debug, Eq)

///|
pub extend GatherMode with Eq::{equal, not_equal}

///|
pub extend GatherMode with Debug::{to_repr}

///|
/// Gather 模式名称 / Gather mode name.
pub fn gather_mode_name(m : GatherMode) -> String {
  match m {
    Concat => "concat"
    MergeSorted => "merge_sorted"
    Union => "union"
  }
}

///|
/// 汇总分区结果 / Gather partition results.
///
/// 将各分区的条目数汇总为总条目数。
pub fn gather_results(
  partition_counts : Array[Int32],
  mode : GatherMode,
) -> Int32 {
  ignore(mode)
  let mut total = 0
  for i in 0..<partition_counts.length() {
    total = total + partition_counts[i]
  }
  total
}

///|
/// 并行执行计划 / Parallel execution plan.
pub struct ParallelExecPlan {
  partition_config : PartitionConfig
  worker_count : Int32
  shuffle_config : ShuffleConfig
  gather_mode : GatherMode
} derive(Debug, Eq)

///|
pub extend ParallelExecPlan with Eq::{equal, not_equal}

///|
pub extend ParallelExecPlan with Debug::{to_repr}

///|
/// 构造并行执行计划 / Build parallel execution plan.
pub fn make_parallel_plan(
  partition_config : PartitionConfig,
  worker_count : Int32,
  shuffle_config : ShuffleConfig,
  gather_mode : GatherMode,
) -> ParallelExecPlan {
  { partition_config, worker_count, shuffle_config, gather_mode, }
}

///|
/// 并行执行统计 / Parallel execution stats.
pub struct ParallelStats {
  total_items : Int32
  partition_count : Int32
  worker_count : Int32
  items_per_worker : Int32
  estimated_latency_ms : Int32
} derive(Debug, Eq)

///|
pub extend ParallelStats with Eq::{equal, not_equal}

///|
pub extend ParallelStats with Debug::{to_repr}

///|
/// 计算并行执行统计 / Compute parallel execution stats.
///
/// 退化安全：worker_count <= 0 返回 0 items_per_worker。
pub fn compute_parallel_stats(
  total_items : Int32,
  partition_count : Int32,
  worker_count : Int32,
) -> ParallelStats {
  let ipw = if worker_count <= 0 { 0 } else { total_items / worker_count }
  let latency = total_items * 10
  {
    total_items,
    partition_count,
    worker_count,
    items_per_worker: ipw,
    estimated_latency_ms: latency,
  }
}

///|
/// 并行执行计划 URI / Parallel exec plan URI.
pub fn parallel_plan_uri(plan : ParallelExecPlan) -> String {
  "parallel://workers=" +
  plan.worker_count.to_string() +
  ";partitions=" +
  plan.partition_config.partition_count.to_string() +
  ";shuffle=" +
  shuffle_type_name(plan.shuffle_config.shuffle_type) +
  ";gather=" +
  gather_mode_name(plan.gather_mode)
}

///|
pub fn cpu_parallel_id() -> String {
  "parallel/cpu_parallel"
}
