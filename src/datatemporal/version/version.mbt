///|
/// # datatemporal/version 版本塔 / Version Tower
///
/// 数据版本塔与快照。架构 §4.4.1。S0.5 数据结构定型。
///
/// # Version tower
///
/// Data version tower and snapshots. See architecture §4.4.1.

///|
/// 版本 / A single version entry.
pub struct Version {
  version_id : String
  parent : String?
  timestamp : Int32
  snapshot_ref : String
} derive(Debug, Eq)

///|
pub extend Version with Eq::{equal, not_equal}

///|
pub extend Version with Debug::{to_repr}

///|
/// 版本塔 / Version tower: ordered version collection.
pub struct VersionTower {
  versions : Array[Version]
} derive(Debug, Eq)

///|
pub extend VersionTower with Eq::{equal, not_equal}

///|
pub extend VersionTower with Debug::{to_repr}

///|
/// 构造版本 / Build a version.
pub fn make_version(
  id : String,
  parent : String?,
  timestamp : Int32,
  snapshot : String,
) -> Version {
  { version_id: id, parent, timestamp, snapshot_ref: snapshot, }
}

///|
/// 根版本（无父）/ Root version (no parent).
pub fn root_version(
  id : String,
  timestamp : Int32,
  snapshot : String,
) -> Version {
  { version_id: id, parent: None, timestamp, snapshot_ref: snapshot, }
}

///|
/// 空版本塔 / Empty version tower.
pub fn empty_tower() -> VersionTower {
  { versions: [], }
}

///|
/// 追加版本 / Append a version to tower.
pub fn append(tower : VersionTower, v : Version) -> VersionTower {
  let new_versions = []
  for x in tower.versions {
    new_versions.push(x)
  }
  new_versions.push(v)
  { versions: new_versions, }
}

///|
/// 版本塔高度 / Tower height.
pub fn height(tower : VersionTower) -> Int32 {
  tower.versions.length()
}

///|
/// 最新版本 / Latest version.
///
/// 退化安全：空塔返回 None。
pub fn latest(tower : VersionTower) -> Version? {
  let n = tower.versions.length()
  if n == 0 {
    None
  } else {
    Some(tower.versions[n - 1])
  }
}

///|
/// 按 ID 查找版本 / Find version by id.
pub fn get_by_id(tower : VersionTower, id : String) -> Version? {
  let n = tower.versions.length()
  for i = 0; i < n; i = i + 1 {
    if tower.versions[i].version_id == id {
      return Some(tower.versions[i])
    }
  }
  None
}

///|
/// 祖先链 / Ancestor chain from a version to root.
///
/// 返回从给定版本到根的祖先链（含自身）。退化安全：ID 不存在返回空。
pub fn ancestors(tower : VersionTower, id : String) -> Array[Version] {
  let result = []
  let mut current_id = id
  let mut counter = 0
  let max = tower.versions.length() + 1
  while counter < max {
    let v = get_by_id(tower, current_id)
    match v {
      Some(version) => {
        result.push(version)
        match version.parent {
          Some(p) => current_id = p
          None => counter = max
        }
      }
      None => counter = max
    }
    counter = counter + 1
  }
  result
}

///|
pub fn version_id() -> String {
  "datatemporal/version"
}
