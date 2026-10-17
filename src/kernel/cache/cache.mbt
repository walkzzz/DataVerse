///|
/// # kernel/cache 缓存增量模式 / Cache Incremental Mode
///
/// 大目录重复处理、增量更新的执行模式基座。
/// 一致性保证：命中缓存即等价。架构 §4.1。
/// S0.2 提供缓存键抽象与契约声明；具体缓存存储在 Phase 1 填充。
///
/// # Cache incremental mode
///
/// Base for large-directory repeated processing, incremental updates.
/// Consistency: cache-hit equivalent. See architecture §4.1.
/// S0.2 provides cache-key abstraction and contract; concrete storage filled in Phase 1.

/// 缓存键 / Cache key with content fingerprint.
pub struct CacheKey {
  key : String
  fingerprint : String
} derive(Debug, Eq)

pub extend CacheKey with Eq::{equal, not_equal}
pub extend CacheKey with Debug::{to_repr}

/// 构造缓存键 / Build a cache key from content.
///
/// S0.2 占位指纹：`"fp:" + content`。
/// S0.4 替换为真实内容指纹（SHA-256 截断）。
pub fn make_key(content : String) -> CacheKey {
  { key: content, fingerprint: "fp:" + content }
}

/// 命中判定占位 / Cache hit check placeholder.
///
/// S0.2 简化为指纹相等即命中；Phase 1 接入真实缓存存储。
pub fn is_hit(cached : CacheKey, candidate : CacheKey) -> Bool {
  cached.fingerprint == candidate.fingerprint
}

pub fn cache_id() -> String {
  "kernel/cache"
}

/// 模式标签 / Mode tag string.
pub fn mode_tag() -> String {
  "cache"
}

/// 一致性保证声明 / Consistency guarantee.
pub fn consistency_guarantee() -> String {
  "cache-hit-equiv"
}