///|
/// # datatemporal 数据时空·版本·血缘 / Data Temporal
///
/// 把"数据的第 4 维"（版本/时间）做成一等维度。
/// 架构 §4.4。S0.5 数据结构定型：Fingerprint + version/lineage/drift/replay。
///
/// # Data temporal: version / lineage / drift / replay
///
/// Makes the "4th dimension" (version/time) first-class. See architecture §4.4.

/// 内容指纹 / Content fingerprint.
///
/// S0.5 占位哈希（长度 + 前缀）；后续替换为 SHA-256 截断。
pub struct Fingerprint {
  content_hash : String
  algorithm : String
} derive(Debug, Eq)

pub extend Fingerprint with Eq::{equal, not_equal}
pub extend Fingerprint with Debug::{to_repr}

/// 构造指纹（占位哈希）/ Build a fingerprint (placeholder hash).
///
/// S0.5 占位：`"fp:<length>"`。后续替换为真实内容哈希。
pub fn make_fingerprint(content : String) -> Fingerprint {
  { content_hash: "fp:" + content.length().to_string(), algorithm: "placeholder" }
}

/// 空指纹 / Empty fingerprint (degenerate-safe).
pub fn empty_fingerprint() -> Fingerprint {
  { content_hash: "", algorithm: "placeholder" }
}

/// 指纹相等判定 / Fingerprint equality.
pub fn matches(a : Fingerprint, b : Fingerprint) -> Bool {
  a.content_hash == b.content_hash
}

pub fn datatemporal_id() -> String {
  "datatemporal"
}