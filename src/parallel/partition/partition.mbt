///|
/// # parallel/partition 数据分区 / Partition
///
/// 数据分区策略：哈希分区、范围分区、轮询分区。
/// S10.5 新建。
///
/// # Data partitioning strategies

/// 分区策略 / Partition strategy.
pub(all) enum PartitionStrategy {
  HashPartition
  RangePartition
  RoundRobinPartition
  KeyPartition
}

/// 分区配置 / Partition config.
pub struct PartitionConfig {
  num_partitions : Int
  strategy : PartitionStrategy
  key_column : String
}

/// 分区结果 / Partition result.
pub struct PartitionResult {
  partition_id : Int
  items : Array[String]
  strategy : PartitionStrategy
}

/// 构造分区配置 / Create partition config.
pub fn make_partition_config(
  num_partitions : Int,
  strategy : PartitionStrategy,
  key_column : String,
) -> PartitionConfig {
  { num_partitions: num_partitions, strategy: strategy, key_column: key_column }
}

/// 构造分区结果 / Create partition result.
pub fn make_partition_result(
  partition_id : Int,
  items : Array[String],
  strategy : PartitionStrategy,
) -> PartitionResult {
  { partition_id: partition_id, items: items, strategy: strategy }
}

///===
/// 哈希分区 / Hash partition

/// 计算哈希值 / Compute hash value.
pub fn hash_value(s : String) -> Int {
  let mut hash = 0
  for i in 0..<s.length() {
    hash = (hash * 31 + s[i].to_int()) % 1000000007
    if hash < 0 {
      hash = hash + 1000000007
    }
  }
  hash
}

/// 哈希分区 / Hash partition items.
pub fn hash_partition(
  items : Array[String],
  num_partitions : Int,
) -> Array[PartitionResult] {
  if num_partitions <= 0 {
    return []
  }
  let buckets : Array[Array[String]] = []
  for i in 0..<num_partitions {
    buckets.push([])
  }
  for i in 0..<items.length() {
    let h = hash_value(items[i])
    let idx = h % num_partitions
    buckets[idx].push(items[i])
  }
  let result : Array[PartitionResult] = []
  for i in 0..<num_partitions {
    result.push(make_partition_result(i, buckets[i], HashPartition))
  }
  result
}

///===
/// 范围分区 / Range partition

/// 范围分区 / Range partition items by boundaries.
pub fn range_partition(
  items : Array[String],
  boundaries : Array[String],
) -> Array[PartitionResult] {
  let num_partitions = boundaries.length() + 1
  let buckets : Array[Array[String]] = []
  for i in 0..<num_partitions {
    buckets.push([])
  }
  for i in 0..<items.length() {
    let mut idx = 0
    for j in 0..<boundaries.length() {
      if items[i] >= boundaries[j] {
        idx = j + 1
      }
    }
    buckets[idx].push(items[i])
  }
  let result : Array[PartitionResult] = []
  for i in 0..<num_partitions {
    result.push(make_partition_result(i, buckets[i], RangePartition))
  }
  result
}

///===
/// 轮询分区 / Round-robin partition

/// 轮询分区 / Round-robin partition items.
pub fn round_robin_partition(
  items : Array[String],
  num_partitions : Int,
) -> Array[PartitionResult] {
  if num_partitions <= 0 {
    return []
  }
  let buckets : Array[Array[String]] = []
  for i in 0..<num_partitions {
    buckets.push([])
  }
  for i in 0..<items.length() {
    buckets[i % num_partitions].push(items[i])
  }
  let result : Array[PartitionResult] = []
  for i in 0..<num_partitions {
    result.push(make_partition_result(i, buckets[i], RoundRobinPartition))
  }
  result
}

///===
/// 分区统计 / Partition statistics

/// 统计分区大小 / Count items in partition.
pub fn partition_count(result : PartitionResult) -> Int {
  result.items.length()
}

/// 总项数 / Total items across all partitions.
pub fn total_items(partitions : Array[PartitionResult]) -> Int {
  let mut total = 0
  for i in 0..<partitions.length() {
    total = total + partitions[i].items.length()
  }
  total
}

/// 最大分区大小 / Max partition size.
pub fn max_partition_size(partitions : Array[PartitionResult]) -> Int {
  let mut max_size = 0
  for i in 0..<partitions.length() {
    let sz = partitions[i].items.length()
    if sz > max_size {
      max_size = sz
    }
  }
  max_size
}

/// 分区均衡度 / Partition balance (max/min ratio).
pub fn partition_balance(partitions : Array[PartitionResult]) -> Double {
  if partitions.length() == 0 {
    return 1.0
  }
  let mut max_sz = 0
  let mut min_sz = 999999999
  for i in 0..<partitions.length() {
    let sz = partitions[i].items.length()
    if sz > max_sz {
      max_sz = sz
    }
    if sz < min_sz {
      min_sz = sz
    }
  }
  if min_sz == 0 { 999999.0 } else { max_sz.to_double() / min_sz.to_double() }
}

///===
/// 策略名称 / Strategy name

pub fn strategy_name(strategy : PartitionStrategy) -> String {
  match strategy {
    HashPartition => "hash"
    RangePartition => "range"
    RoundRobinPartition => "round_robin"
    KeyPartition => "key"
  }
}

///===
/// ID

pub fn partition_id() -> String {
  "parallel/partition"
}