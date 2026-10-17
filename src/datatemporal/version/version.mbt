///|
/// # datatemporal/version 版本塔 / Version Tower
///
/// 数据版本塔与快照。架构 §4.4.1。S0.5 数据结构定型。
///
/// # Version tower
///
/// Data version tower and snapshots. See architecture §4.4.1.

/// 版本 / A single version entry.
pub struct Version {
  version_id : String
  parent : String?
  timestamp : Int
  snapshot_ref : String
} derive(Debug, Eq)

pub extend Version with Eq::{equal, not_equal}
pub extend Version with Debug::{to_repr}

/// 版本塔 / Version tower: ordered version collection.
pub struct VersionTower {
  versions : Array[Version]
} derive(Debug, Eq)

pub extend VersionTower with Eq::{equal, not_equal}
pub extend VersionTower with Debug::{to_repr}

/// 构造版本 / Build a version.
pub fn make_version(id : String, parent : String?, timestamp : Int, snapshot : String) -> Version {
  { version_id: id, parent, timestamp, snapshot_ref: snapshot }
}

/// 根版本（无父）/ Root version (no parent).
pub fn root_version(id : String, timestamp : Int, snapshot : String) -> Version {
  { version_id: id, parent: None, timestamp, snapshot_ref: snapshot }
}

/// 空版本塔 / Empty version tower.
pub fn empty_tower() -> VersionTower {
  { versions: [] }
}

/// 追加版本 / Append a version to tower.
pub fn append(tower : VersionTower, v : Version) -> VersionTower {
  let new_versions = []
  for x in tower.versions {
    new_versions.push(x)
  }
  new_versions.push(v)
  { versions: new_versions }
}

/// 版本塔高度 / Tower height.
pub fn height(tower : VersionTower) -> Int {
  tower.versions.length()
}

pub fn version_id() -> String {
  "datatemporal/version"
}