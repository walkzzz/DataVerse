///|
/// # datatemporal/incremental 增量更新 / Incremental Update
///
/// 增量数据合并 + 冲突检测。架构 §4.4 datatemporal 深化。
/// S2.6 填充：IncrementalUpdate + merge_incremental + detect_conflicts。
///
/// # Incremental update
///
/// Merge + conflict detection. See architecture §4.4.

///|
/// 增量更新结果 / Incremental update result.
pub struct IncrementalUpdate {
  base_count : Int32
  added_count : Int32
  removed_count : Int32
  conflict_count : Int32
  final_count : Int32
  conflicts : Array[String]
} derive(Debug, Eq)

///|
pub extend IncrementalUpdate with Eq::{equal, not_equal}

///|
pub extend IncrementalUpdate with Debug::{to_repr}

///|
/// 构造增量更新 / Build incremental update.
pub fn make_incremental_update(
  base_count : Int32,
  added_count : Int32,
  removed_count : Int32,
  conflicts : Array[String],
) -> IncrementalUpdate {
  let final_c = base_count + added_count - removed_count
  {
    base_count,
    added_count,
    removed_count,
    conflict_count: conflicts.length(),
    final_count: final_c,
    conflicts,
  }
}

///|
/// 检测冲突 / Detect conflicts between base and new keys.
///
/// 返回同时出现在 base_keys 和 new_keys 中的键。
pub fn detect_conflicts(
  base_keys : Array[String],
  new_keys : Array[String],
) -> Array[String] {
  let conflicts : Array[String] = []
  for i in 0..<new_keys.length() {
    let key = new_keys[i]
    let mut found = false
    for j in 0..<base_keys.length() {
      if base_keys[j] == key {
        found = true
      }
    }
    if found {
      let mut already = false
      for k in 0..<conflicts.length() {
        if conflicts[k] == key {
          already = true
        }
      }
      if !already {
        conflicts.push(key)
      }
    }
  }
  conflicts
}

///|
/// 合并增量 / Merge incremental updates.
///
/// 退化安全：空输入返回零更新。
pub fn merge_incremental(
  base_keys : Array[String],
  additions : Array[String],
  removals : Array[String],
) -> IncrementalUpdate {
  let conflicts = detect_conflicts(base_keys, additions)
  make_incremental_update(
    base_keys.length(),
    additions.length(),
    removals.length(),
    conflicts,
  )
}

///|
pub fn incremental_id() -> String {
  "datatemporal/incremental"
}
