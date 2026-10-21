///|
/// # io 存储适配 / IO Adapters
///
/// 对接对象存储、数据湖、向量库。不做数据存储引擎，
/// 只提供 IO 适配层。架构 §3 + §2 非目标 4。
/// S0.1 骨架占位，Phase 1+ 填充。
///
/// # IO adapters
///
/// Adapters for object storage / data lake / vector store.
/// Not a storage engine, only an IO adaptation layer.
/// See architecture §3. Phase 1+ fills the implementation.
pub fn io_id() -> String {
  "io"
}
