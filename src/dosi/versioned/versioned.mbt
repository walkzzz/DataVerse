///|
/// # dosi/versioned 多版本索引 / Versioned Index
///
/// 版本快照 + 版本查询。架构 §4.7 DOSI 扩充。
/// 对应 datatemporal 版本塔。S2.8 填充。
///
/// # Versioned index
///
/// Version snapshots + queries. See architecture §4.7.

/// 版本化索引 / Versioned index.
pub struct VersionedIndex {
  versions : Array[(Int, @dosi.DOSIIndex)]
  current_version : Int
} derive(Debug, Eq)

pub extend VersionedIndex with Eq::{equal, not_equal}
pub extend VersionedIndex with Debug::{to_repr}

/// 构造版本化索引 / Build versioned index.
pub fn make_versioned_index(initial : @dosi.DOSIIndex) -> VersionedIndex {
  { versions: [(0, initial)], current_version: 0 }
}

/// 空版本化索引（退化安全）/ Empty versioned index (degenerate-safe).
pub fn empty_versioned_index() -> VersionedIndex {
  { versions: [(0, @dosi.DOSIIndex::empty())], current_version: 0 }
}

/// 推进到新版本 / Advance to new version.
///
/// 创建新版本快照，current_version + 1。
pub fn advance_version(vindex : VersionedIndex, new_index : @dosi.DOSIIndex) -> VersionedIndex {
  let new_v = vindex.current_version + 1
  let new_versions : Array[(Int, @dosi.DOSIIndex)] = []
  for i in 0..<vindex.versions.length() {
    new_versions.push(vindex.versions[i])
  }
  new_versions.push((new_v, new_index))
  { versions: new_versions, current_version: new_v }
}

/// 获取特定版本 / Get specific version.
///
/// 退化安全：版本不存在返回 None。
pub fn get_version(vindex : VersionedIndex, version : Int) -> @dosi.DOSIIndex? {
  for i in 0..<vindex.versions.length() {
    let (v, idx) = vindex.versions[i]
    if v == version {
      return Some(idx)
    }
  }
  None
}

/// 获取当前版本 / Get current version index.
pub fn current(vindex : VersionedIndex) -> @dosi.DOSIIndex {
  match get_version(vindex, vindex.current_version) {
    Some(idx) => idx
    None => @dosi.DOSIIndex::empty()
  }
}

/// 版本数 / Version count.
pub fn version_count(vindex : VersionedIndex) -> Int {
  vindex.versions.length()
}

/// 回滚到指定版本 / Rollback to specified version.
///
/// 退化安全：版本不存在返回原索引。
pub fn rollback(vindex : VersionedIndex, target_version : Int) -> VersionedIndex {
  match get_version(vindex, target_version) {
    Some(idx) => advance_version(vindex, idx)
    None => vindex
  }
}

pub fn versioned_id() -> String {
  "dosi/versioned"
}