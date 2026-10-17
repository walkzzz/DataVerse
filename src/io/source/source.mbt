///|
/// # io/source 数据源 / Data Source
///
/// 数据源抽象：文件 / 对象存储 / 数据湖 / 向量库 / 内存。
/// 架构 §3 IO 适配层。S3.1 填充：契约 + 内存模拟（不引入平台 FFI）。
///
/// # Data source
///
/// Source abstraction: file / object storage / data lake / vector store / in-memory.

/// 数据源类型 / Data source type.
pub(all) enum DataSourceType {
  File          // 本地文件
  ObjectStorage // 对象存储（OBS/S3）
  DataLake      // 数据湖（Parquet/Arrow）
  VectorStore   // 向量库（FAISS/Milvus）
  InMemory      // 内存
} derive(Debug, Eq)

pub extend DataSourceType with Eq::{equal, not_equal}
pub extend DataSourceType with Debug::{to_repr}

/// 数据源配置 / Data source configuration.
///
/// path: 文件路径或 URI
/// endpoint: 对象存储端点
/// bucket: 桶名
/// key: 键名
/// format: 数据格式（json/csv/parquet/arrow）
pub struct SourceConfig {
  source_type : DataSourceType
  path : String
  endpoint : String
  bucket : String
  key : String
  format : String
} derive(Debug, Eq)

pub extend SourceConfig with Eq::{equal, not_equal}
pub extend SourceConfig with Debug::{to_repr}

/// 构造数据源配置 / Build source config.
pub fn make_source_config(
  source_type : DataSourceType,
  path : String,
  endpoint : String,
  bucket : String,
  key : String,
  format : String
) -> SourceConfig {
  { source_type, path, endpoint, bucket, key, format }
}

/// 文件数据源 / File source config (convenience).
pub fn file_source(path : String, format : String) -> SourceConfig {
  { source_type: File, path, endpoint: "", bucket: "", key: "", format }
}

/// 对象存储数据源 / Object storage source config (convenience).
pub fn object_storage_source(endpoint : String, bucket : String, key : String, format : String) -> SourceConfig {
  { source_type: ObjectStorage, path: "", endpoint, bucket, key, format }
}

/// 内存数据源 / In-memory source config (convenience).
pub fn in_memory_source(format : String) -> SourceConfig {
  { source_type: InMemory, path: "", endpoint: "", bucket: "", key: "", format }
}

/// 数据源 URI / Source URI.
///
/// 生成数据源的统一资源标识符。
pub fn source_uri(config : SourceConfig) -> String {
  match config.source_type {
    File => "file://" + config.path
    ObjectStorage => "obs://" + config.endpoint + "/" + config.bucket + "/" + config.key
    DataLake => "lake://" + config.path
    VectorStore => "vec://" + config.endpoint + "/" + config.bucket
    InMemory => "memory://" + config.format
  }
}

/// 数据源类型名称 / Source type name.
pub fn source_type_name(t : DataSourceType) -> String {
  match t {
    File => "file"
    ObjectStorage => "object_storage"
    DataLake => "data_lake"
    VectorStore => "vector_store"
    InMemory => "in_memory"
  }
}

/// 从数据源读取（契约 + 内存模拟）/ Read from source (contract + in-memory simulation).
///
/// 真实实现需平台 FFI（extern "c" 文件系统 / extern "js" fetch）。
/// 此处返回模拟 DataObject 数组：根据 format 生成占位内容。
/// 退化安全：未知 format 返回空数组。
pub fn read_source(config : SourceConfig, count : Int) -> Array[@dataobject.DataObject] {
  if count <= 0 {
    []
  } else {
    let result = []
    let uri = source_uri(config)
    let modality = match config.source_type {
      VectorStore => @dataobject.Text
      _ => @dataobject.Text
    }
    for i in 0..<count {
      let content = uri + "#item-" + i.to_string() + "." + config.format
      result.push(@dataobject.make_dataobject(content, modality, @schema.empty()))
    }
    result
  }
}

/// 数据源元数据 / Source metadata.
pub struct SourceMeta {
  config : SourceConfig
  item_count : Int
  total_size_bytes : Int
} derive(Debug, Eq)

pub extend SourceMeta with Eq::{equal, not_equal}
pub extend SourceMeta with Debug::{to_repr}

/// 构造数据源元数据 / Build source metadata.
pub fn make_source_meta(config : SourceConfig, item_count : Int, total_size_bytes : Int) -> SourceMeta {
  { config, item_count, total_size_bytes }
}

/// 数据源元数据 URI / Source metadata URI.
pub fn source_meta_uri(meta : SourceMeta) -> String {
  source_uri(meta.config) + "?items=" + meta.item_count.to_string() + "&size=" + meta.total_size_bytes.to_string()
}