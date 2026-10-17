///|
/// # io/sink 数据汇 / Data Sink
///
/// 数据汇抽象：文件 / 对象存储 / 数据湖 / 向量库 / 内存。
/// 架构 §3 IO 适配层。S3.1 填充：契约 + 内存模拟（不引入平台 FFI）。
///
/// # Data sink
///
/// Sink abstraction: file / object storage / data lake / vector store / in-memory.

/// 数据汇类型 / Data sink type.
pub(all) enum DataSinkType {
  File          // 本地文件
  ObjectStorage // 对象存储（OBS/S3）
  DataLake      // 数据湖（Parquet/Arrow）
  VectorStore   // 向量库（FAISS/Milvus）
  InMemory      // 内存
} derive(Debug, Eq)

pub extend DataSinkType with Eq::{equal, not_equal}
pub extend DataSinkType with Debug::{to_repr}

/// 数据汇配置 / Data sink configuration.
pub struct SinkConfig {
  sink_type : DataSinkType
  path : String
  endpoint : String
  bucket : String
  key : String
  format : String
} derive(Debug, Eq)

pub extend SinkConfig with Eq::{equal, not_equal}
pub extend SinkConfig with Debug::{to_repr}

/// 构造数据汇配置 / Build sink config.
pub fn make_sink_config(
  sink_type : DataSinkType,
  path : String,
  endpoint : String,
  bucket : String,
  key : String,
  format : String
) -> SinkConfig {
  { sink_type, path, endpoint, bucket, key, format }
}

/// 文件数据汇 / File sink config (convenience).
pub fn file_sink(path : String, format : String) -> SinkConfig {
  { sink_type: File, path, endpoint: "", bucket: "", key: "", format }
}

/// 对象存储数据汇 / Object storage sink config (convenience).
pub fn object_storage_sink(endpoint : String, bucket : String, key : String, format : String) -> SinkConfig {
  { sink_type: ObjectStorage, path: "", endpoint, bucket, key, format }
}

/// 内存数据汇 / In-memory sink config (convenience).
pub fn in_memory_sink(format : String) -> SinkConfig {
  { sink_type: InMemory, path: "", endpoint: "", bucket: "", key: "", format }
}

/// 数据汇 URI / Sink URI.
pub fn sink_uri(config : SinkConfig) -> String {
  match config.sink_type {
    File => "file://" + config.path
    ObjectStorage => "obs://" + config.endpoint + "/" + config.bucket + "/" + config.key
    DataLake => "lake://" + config.path
    VectorStore => "vec://" + config.endpoint + "/" + config.bucket
    InMemory => "memory://" + config.format
  }
}

/// 数据汇类型名称 / Sink type name.
pub fn sink_type_name(t : DataSinkType) -> String {
  match t {
    File => "file"
    ObjectStorage => "object_storage"
    DataLake => "data_lake"
    VectorStore => "vector_store"
    InMemory => "in_memory"
  }
}

/// 写入数据汇（契约 + 内存模拟）/ Write to sink (contract + in-memory simulation).
///
/// 真实实现需平台 FFI。此处返回写入的条目数（模拟成功写入）。
/// 退化安全：空数组返回 0。
pub fn write_sink(config : SinkConfig, data : Array[@dataobject.DataObject]) -> Int {
  ignore(config)
  data.length()
}

/// 写入结果 / Write result.
pub struct WriteResult {
  config : SinkConfig
  written_count : Int
  success : Bool
} derive(Debug, Eq)

pub extend WriteResult with Eq::{equal, not_equal}
pub extend WriteResult with Debug::{to_repr}

/// 构造写入结果 / Build write result.
pub fn make_write_result(config : SinkConfig, written_count : Int, success : Bool) -> WriteResult {
  { config, written_count, success }
}

/// 执行写入并返回结果 / Execute write and return result.
pub fn execute_write(config : SinkConfig, data : Array[@dataobject.DataObject]) -> WriteResult {
  let count = write_sink(config, data)
  make_write_result(config, count, true)
}

/// 数据汇容量统计 / Sink capacity stats.
pub struct SinkStats {
  config : SinkConfig
  total_written : Int
  total_bytes : Int
} derive(Debug, Eq)

pub extend SinkStats with Eq::{equal, not_equal}
pub extend SinkStats with Debug::{to_repr}

/// 构造数据汇统计 / Build sink stats.
pub fn make_sink_stats(config : SinkConfig, total_written : Int, total_bytes : Int) -> SinkStats {
  { config, total_written, total_bytes }
}

/// 数据汇统计 URI / Sink stats URI.
pub fn sink_stats_uri(stats : SinkStats) -> String {
  sink_uri(stats.config) + "?written=" + stats.total_written.to_string() + "&bytes=" + stats.total_bytes.to_string()
}