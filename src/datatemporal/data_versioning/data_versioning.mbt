///|
/// # datatemporal/data_versioning 数据版本化 / Data Versioning
///
/// 版本存储、分支、标签、提交、增量、快照、历史、合并策略、
/// 回滚、版本策略、垃圾回收、时间旅行、DVC 风格数据版本控制。
///
/// # Data versioning

///===
/// 内部辅助 / Internal helpers

fn dv_max(a : Int, b : Int) -> Int {
  if a > b { a } else { b }
}

fn dv_max_d(a : Double, b : Double) -> Double {
  if a > b { a } else { b }
}

fn dv_min(a : Int, b : Int) -> Int {
  if a < b { a } else { b }
}

fn dv_contains(arr : Array[String], v : String) -> Bool {
  for i in 0..<arr.length() {
    if arr[i] == v {
      return true
    }
  }
  false
}

fn dv_hash(content : String) -> String {
  let mut h = 0
  for i in 0..<content.length() {
    h = (h * 31 + content[i].to_int()) % 1000000007
    if h < 0 {
      h = -h
    }
  }
  "h" + h.to_string() + ":" + content.length().to_string()
}

fn dv_join(arr : Array[String], sep : String) -> String {
  let n = arr.length()
  if n == 0 {
    return ""
  }
  let mut result = arr[0]
  for i in 1..<n {
    result = result + sep + arr[i]
  }
  result
}

///===
/// Commit / 提交

pub struct Commit {
  hash : String
  message : String
  timestamp : Double
  author : String
  parents : Array[String]
} derive(Debug, Eq)

pub extend Commit with Eq::{equal, not_equal}
pub extend Commit with Debug::{to_repr}

/// 构造提交 / Build a commit.
pub fn make_commit(
  message : String,
  timestamp : Double,
  author : String,
  parents : Array[String]
) -> Commit {
  let content = message + "|" + timestamp.to_string() + "|" + author + "|" + dv_join(parents, ",")
  { hash: dv_hash(content), message, timestamp, author, parents }
}

/// 提交哈希 / Get commit hash.
pub fn commit_hash(c : Commit) -> String {
  c.hash
}

/// 提交消息 / Get commit message.
pub fn commit_message(c : Commit) -> String {
  c.message
}

/// 提交时间戳 / Get commit timestamp.
pub fn commit_timestamp(c : Commit) -> Double {
  c.timestamp
}

///===
/// Branch / 分支

pub struct Branch {
  name : String
  head : String
  commits : Array[Commit]
} derive(Debug, Eq)

pub extend Branch with Eq::{equal, not_equal}
pub extend Branch with Debug::{to_repr}

/// 构造分支 / Build a branch.
pub fn make_branch(name : String, head : String) -> Branch {
  { name, head, commits: [] }
}

/// 创建分支 / Create a branch.
pub fn branch_create(
  branches : Array[Branch],
  name : String,
  head : String
) -> Array[Branch] {
  branches + [make_branch(name, head)]
}

/// 合并分支 / Merge two branches.
pub fn branch_merge(
  target : Branch,
  source : Branch
) -> Branch {
  { name: target.name, head: source.head, commits: target.commits + source.commits }
}

/// 变基分支 / Rebase branch onto another.
pub fn branch_rebase(
  branch : Branch,
  onto : Branch
) -> Branch {
  { name: branch.name, head: onto.head, commits: onto.commits + branch.commits }
}

///===
/// Tag / 标签

pub struct Tag {
  name : String
  commit_hash : String
  message : String
} derive(Debug, Eq)

pub extend Tag with Eq::{equal, not_equal}
pub extend Tag with Debug::{to_repr}

/// 构造标签 / Build a tag.
pub fn make_tag(name : String, commit_hash : String, message : String) -> Tag {
  { name, commit_hash, message }
}

/// 创建标签 / Create a tag.
pub fn tag_create(
  tags : Array[Tag],
  name : String,
  commit_hash : String,
  message : String
) -> Array[Tag] {
  tags + [make_tag(name, commit_hash, message)]
}

/// 标签列表 / List tags.
pub fn tag_list(tags : Array[Tag]) -> Array[String] {
  let result : Array[String] = []
  for i in 0..<tags.length() {
    result.push(tags[i].name)
  }
  result
}

/// 删除标签 / Delete a tag.
pub fn tag_delete(tags : Array[Tag], name : String) -> Array[Tag] {
  let result : Array[Tag] = []
  for i in 0..<tags.length() {
    if tags[i].name != name {
      result.push(tags[i])
    }
  }
  result
}

///===
/// Delta / 增量

pub struct Delta {
  base_version : Int
  target_version : Int
  changes : Array[(String, String, String)]
} derive(Debug, Eq)

pub extend Delta with Eq::{equal, not_equal}
pub extend Delta with Debug::{to_repr}

/// 构造增量 / Build a delta.
pub fn make_delta(
  base_version : Int,
  target_version : Int,
  changes : Array[(String, String, String)]
) -> Delta {
  { base_version, target_version, changes }
}

/// 应用增量 / Apply delta to content.
pub fn delta_apply(
  content : Array[(String, String)],
  delta : Delta
) -> Array[(String, String)] {
  let result : Array[(String, String)] = []
  let applied_keys : Array[String] = []
  for i in 0..<content.length() {
    let (k, v) = content[i]
    let mut new_v = v
    let mut changed = false
    for j in 0..<delta.changes.length() {
      let (ck, op, cv) = delta.changes[j]
      if ck == k && op == "set" {
        new_v = cv
        changed = true
      }
    }
    if changed {
      applied_keys.push(k)
    }
    result.push((k, new_v))
  }
  for i in 0..<delta.changes.length() {
    let (ck, op, cv) = delta.changes[i]
    if op == "add" && !(dv_contains(applied_keys, ck)) {
      result.push((ck, cv))
    }
  }
  result
}

/// 回退增量 / Revert delta.
pub fn delta_revert(delta : Delta) -> Delta {
  let reverted : Array[(String, String, String)] = []
  for i in 0..<delta.changes.length() {
    let (k, op, v) = delta.changes[i]
    if op == "add" {
      reverted.push((k, "remove", v))
    } else if op == "remove" {
      reverted.push((k, "add", v))
    } else {
      reverted.push((k, "revert", v))
    }
  }
  { base_version: delta.target_version, target_version: delta.base_version, changes: reverted }
}

/// 组合增量 / Compose two deltas.
pub fn delta_compose(a : Delta, b : Delta) -> Delta {
  { base_version: a.base_version, target_version: b.target_version, changes: a.changes + b.changes }
}

///===
/// Snapshot / 快照

pub struct Snapshot {
  version : Int
  content : Array[(String, String)]
  timestamp : Double
} derive(Debug, Eq)

pub extend Snapshot with Eq::{equal, not_equal}
pub extend Snapshot with Debug::{to_repr}

/// 构造快照 / Build a snapshot.
pub fn make_snapshot_v(version : Int) -> Snapshot {
  { version, content: [], timestamp: 0.0 }
}

/// 创建快照 / Create a snapshot.
pub fn snapshot_create_v(
  version : Int,
  content : Array[(String, String)],
  timestamp : Double
) -> Snapshot {
  { version, content, timestamp }
}

/// 恢复快照 / Restore from snapshot.
pub fn snapshot_restore_v(snap : Snapshot) -> Array[(String, String)] {
  snap.content
}

///===
/// VersionStore / 版本存储

pub struct VersionStore {
  commits : Array[Commit]
  branches : Array[Branch]
  tags : Array[Tag]
  snapshots : Array[Snapshot]
  current_branch : String
} derive(Debug, Eq)

pub extend VersionStore with Eq::{equal, not_equal}
pub extend VersionStore with Debug::{to_repr}

/// 构造版本存储 / Build a version store.
pub fn make_version_store() -> VersionStore {
  {
    commits: [],
    branches: [make_branch("main", "")],
    tags: [],
    snapshots: [],
    current_branch: "main",
  }
}

/// 提交版本 / Commit a version.
pub fn version_commit(
  store : VersionStore,
  message : String,
  timestamp : Double,
  author : String
) -> VersionStore {
  let parents : Array[String] = []
  let mut p = parents
  for i in 0..<store.branches.length() {
    if store.branches[i].name == store.current_branch && store.branches[i].head.length() > 0 {
      p = [store.branches[i].head]
      break
    }
  }
  let c = make_commit(message, timestamp, author, p)
  let new_branches : Array[Branch] = []
  for i in 0..<store.branches.length() {
    if store.branches[i].name == store.current_branch {
      new_branches.push({ name: store.branches[i].name, head: c.hash, commits: store.branches[i].commits + [c] })
    } else {
      new_branches.push(store.branches[i])
    }
  }
  { commits: store.commits + [c], branches: new_branches, tags: store.tags, snapshots: store.snapshots, current_branch: store.current_branch }
}

/// 检出版本 / Checkout a version.
pub fn version_checkout(store : VersionStore, hash : String) -> VersionStore {
  let new_branches : Array[Branch] = []
  for i in 0..<store.branches.length() {
    if store.branches[i].name == store.current_branch {
      new_branches.push({ name: store.branches[i].name, head: hash, commits: store.branches[i].commits })
    } else {
      new_branches.push(store.branches[i])
    }
  }
  { commits: store.commits, branches: new_branches, tags: store.tags, snapshots: store.snapshots, current_branch: store.current_branch }
}

/// 版本差异 / Diff between two versions.
pub fn version_diff(
  store : VersionStore,
  hash_a : String,
  hash_b : String
) -> Array[String] {
  let result : Array[String] = []
  let mut found_a = -1
  let mut found_b = -1
  for i in 0..<store.commits.length() {
    if store.commits[i].hash == hash_a {
      found_a = i
    }
    if store.commits[i].hash == hash_b {
      found_b = i
    }
  }
  if found_a < 0 || found_b < 0 {
    return result
  }
  let lo = dv_min(found_a, found_b)
  let hi = dv_max(found_a, found_b)
  for i in lo..=hi {
    result.push(store.commits[i].hash + ":" + store.commits[i].message)
  }
  result
}

///===
/// Version history / 版本历史

/// 版本历史 / Get version history.
pub fn version_history(store : VersionStore) -> Array[Commit] {
  store.commits
}

/// 版本日志 / Get version log.
pub fn version_log(store : VersionStore) -> Array[String] {
  let result : Array[String] = []
  for i in 0..<store.commits.length() {
    let c = store.commits[i]
    result.push(c.hash + " | " + c.author + " | " + c.timestamp.to_string() + " | " + c.message)
  }
  result
}

/// 版本祖先 / Get version ancestors.
pub fn version_ancestors(store : VersionStore, hash : String) -> Array[String] {
  let result : Array[String] = []
  let queue : Array[String] = [hash]
  let visited : Array[String] = []
  while queue.length() > 0 {
    let current = queue[0]
    ignore(queue.remove(0))
    if dv_contains(visited, current) {
      continue
    }
    visited.push(current)
    for i in 0..<store.commits.length() {
      if store.commits[i].hash == current {
        for j in 0..<store.commits[i].parents.length() {
          let p = store.commits[i].parents[j]
          if !(dv_contains(visited, p)) {
            result.push(p)
            queue.push(p)
          }
        }
        break
      }
    }
  }
  result
}

///===
/// Version comparison / 版本比较

/// 版本比较 / Compare two versions.
pub fn version_compare(a : Commit, b : Commit) -> Int {
  if a.timestamp < b.timestamp {
    -1
  } else if a.timestamp > b.timestamp {
    1
  } else {
    0
  }
}

/// 版本冲突 / Check version conflict.
pub fn version_conflict(a : Commit, b : Commit) -> Bool {
  let mut shared = false
  for i in 0..<a.parents.length() {
    for j in 0..<b.parents.length() {
      if a.parents[i] == b.parents[j] {
        shared = true
        break
      }
    }
    if shared {
      break
    }
  }
  !(shared) && a.hash != b.hash
}

/// 版本解决 / Resolve version conflict.
pub fn version_resolve(a : Commit, b : Commit, strategy : String) -> Commit {
  if strategy == "ours" {
    a
  } else if strategy == "theirs" {
    b
  } else {
    make_commit("merge:" + a.message + "+" + b.message, dv_max_d(a.timestamp, b.timestamp), a.author, [a.hash, b.hash])
  }
}

///===
/// MergeStrategy / 合并策略

pub(all) enum MergeStrategy {
  ThreeWay
  Union
  Ours
  Theirs
} derive(Debug, Eq)

pub extend MergeStrategy with Eq::{equal, not_equal}
pub extend MergeStrategy with Debug::{to_repr}

/// 构造合并策略 / Build a merge strategy.
pub fn make_merge_strategy(name : String) -> MergeStrategy {
  match name {
    "three_way" => ThreeWay
    "union" => Union
    "ours" => Ours
    "theirs" => Theirs
    _ => ThreeWay
  }
}

/// 三方合并 / Three-way merge.
pub fn merge_three_way(
  base : Array[(String, String)],
  ours : Array[(String, String)],
  theirs : Array[(String, String)]
) -> Array[(String, String)] {
  let result : Array[(String, String)] = []
  let seen : Array[String] = []
  for i in 0..<ours.length() {
    let (k, v) = ours[i]
    let mut in_theirs = false
    let mut theirs_v = ""
    for j in 0..<theirs.length() {
      if theirs[j].0 == k {
        in_theirs = true
        theirs_v = theirs[j].1
        break
      }
    }
    if in_theirs && theirs_v == v {
      result.push((k, v))
    } else if in_theirs {
      result.push((k, v + "|" + theirs_v))
    } else {
      result.push((k, v))
    }
    seen.push(k)
  }
  for i in 0..<theirs.length() {
    let (k, v) = theirs[i]
    if !(dv_contains(seen, k)) {
      result.push((k, v))
    }
  }
  ignore(base)
  result
}

/// 联合合并 / Union merge.
pub fn merge_union(
  ours : Array[(String, String)],
  theirs : Array[(String, String)]
) -> Array[(String, String)] {
  let result : Array[(String, String)] = []
  let seen : Array[String] = []
  for i in 0..<ours.length() {
    result.push(ours[i])
    seen.push(ours[i].0)
  }
  for i in 0..<theirs.length() {
    if !(dv_contains(seen, theirs[i].0)) {
      result.push(theirs[i])
    }
  }
  result
}

///===
/// Rollback / 回滚

pub struct Rollback {
  from_hash : String
  to_hash : String
  timestamp : Double
} derive(Debug, Eq)

pub extend Rollback with Eq::{equal, not_equal}
pub extend Rollback with Debug::{to_repr}

/// 构造回滚 / Build a rollback.
pub fn make_rollback(from_hash : String, to_hash : String, timestamp : Double) -> Rollback {
  { from_hash, to_hash, timestamp }
}

/// 回滚到 / Rollback to a version.
pub fn rollback_to(store : VersionStore, hash : String) -> VersionStore {
  version_checkout(store, hash)
}

/// 创建回滚 / Create a rollback.
pub fn rollback_create(
  store : VersionStore,
  to_hash : String,
  timestamp : Double
) -> Rollback {
  let mut from = ""
  for i in 0..<store.branches.length() {
    if store.branches[i].name == store.current_branch {
      from = store.branches[i].head
      break
    }
  }
  make_rollback(from, to_hash, timestamp)
}

///===
/// Version metadata / 版本元数据

/// 版本元数据 / Get version metadata.
pub fn version_metadata(c : Commit) -> Array[(String, String)] {
  [("hash", c.hash), ("message", c.message), ("author", c.author), ("timestamp", c.timestamp.to_string()), ("parents", dv_join(c.parents, ","))]
}

/// 版本作者 / Get version author.
pub fn version_author(c : Commit) -> String {
  c.author
}

/// 版本时间戳 / Get version timestamp.
pub fn version_timestamp(c : Commit) -> Double {
  c.timestamp
}

///===
/// VersioningPolicy / 版本策略

pub struct VersioningPolicy {
  max_branches : Int
  max_tags : Int
  require_message : Bool
  allow_force_push : Bool
} derive(Debug, Eq)

pub extend VersioningPolicy with Eq::{equal, not_equal}
pub extend VersioningPolicy with Debug::{to_repr}

/// 构造版本策略 / Build a versioning policy.
pub fn make_versioning_policy(
  max_branches : Int,
  max_tags : Int,
  require_message : Bool,
  allow_force_push : Bool
) -> VersioningPolicy {
  { max_branches, max_tags, require_message, allow_force_push }
}

/// 策略检查 / Check policy.
pub fn policy_check(policy : VersioningPolicy, store : VersionStore) -> Bool {
  if store.branches.length() > policy.max_branches && policy.max_branches > 0 {
    return false
  }
  if store.tags.length() > policy.max_tags && policy.max_tags > 0 {
    return false
  }
  if policy.require_message {
    for i in 0..<store.commits.length() {
      if store.commits[i].message.length() == 0 {
        return false
      }
    }
  }
  true
}

/// 策略强制 / Enforce policy.
pub fn policy_enforce(policy : VersioningPolicy, store : VersionStore) -> VersionStore {
  let new_branches : Array[Branch] = []
  for i in 0..<store.branches.length() {
    if i < policy.max_branches || policy.max_branches <= 0 {
      new_branches.push(store.branches[i])
    }
  }
  let new_tags : Array[Tag] = []
  for i in 0..<store.tags.length() {
    if i < policy.max_tags || policy.max_tags <= 0 {
      new_tags.push(store.tags[i])
    }
  }
  { commits: store.commits, branches: new_branches, tags: new_tags, snapshots: store.snapshots, current_branch: store.current_branch }
}

///===
/// Version GC / 版本垃圾回收

/// 版本垃圾回收 / Garbage collect unreferenced commits.
pub fn version_gc(store : VersionStore) -> VersionStore {
  let referenced : Array[String] = []
  for i in 0..<store.branches.length() {
    referenced.push(store.branches[i].head)
    for j in 0..<store.branches[i].commits.length() {
      referenced.push(store.branches[i].commits[j].hash)
    }
  }
  for i in 0..<store.tags.length() {
    referenced.push(store.tags[i].commit_hash)
  }
  let new_commits : Array[Commit] = []
  for i in 0..<store.commits.length() {
    if dv_contains(referenced, store.commits[i].hash) {
      new_commits.push(store.commits[i])
    }
  }
  { commits: new_commits, branches: store.branches, tags: store.tags, snapshots: store.snapshots, current_branch: store.current_branch }
}

/// 版本压缩 / Compact version store.
pub fn version_compact(store : VersionStore) -> VersionStore {
  let new_commits : Array[Commit] = []
  for i in 0..<store.commits.length() {
    let mut dup = false
    for j in 0..<new_commits.length() {
      if new_commits[j].hash == store.commits[i].hash {
        dup = true
        break
      }
    }
    if !(dup) {
      new_commits.push(store.commits[i])
    }
  }
  { commits: new_commits, branches: store.branches, tags: store.tags, snapshots: store.snapshots, current_branch: store.current_branch }
}

/// 版本清理 / Cleanup version store.
pub fn version_cleanup(store : VersionStore) -> VersionStore {
  version_compact(version_gc(store))
}

///===
/// TimeTravel / 时间旅行

pub struct TimeTravel {
  store : VersionStore
  snapshots : Array[Snapshot]
} derive(Debug, Eq)

pub extend TimeTravel with Eq::{equal, not_equal}
pub extend TimeTravel with Debug::{to_repr}

/// 构造时间旅行 / Build a time travel.
pub fn make_time_travel(store : VersionStore) -> TimeTravel {
  { store, snapshots: [] }
}

/// 时间旅行查询 / Time travel query.
pub fn time_travel_query(
  tt : TimeTravel,
  timestamp : Double
) -> Array[Snapshot] {
  let result : Array[Snapshot] = []
  for i in 0..<tt.snapshots.length() {
    if tt.snapshots[i].timestamp <= timestamp {
      result.push(tt.snapshots[i])
    }
  }
  result
}

/// 时间旅行快照 / Time travel snapshot.
pub fn time_travel_snapshot(
  tt : TimeTravel,
  version : Int,
  content : Array[(String, String)],
  timestamp : Double
) -> TimeTravel {
  let snap = snapshot_create_v(version, content, timestamp)
  { store: tt.store, snapshots: tt.snapshots + [snap] }
}

///===
/// DVC / 数据版本控制

pub struct DVC {
  tracked_files : Array[(String, String)]
  remote : String
} derive(Debug, Eq)

pub extend DVC with Eq::{equal, not_equal}
pub extend DVC with Debug::{to_repr}

/// 构造 DVC / Build a DVC.
pub fn make_dvc(remote : String) -> DVC {
  { tracked_files: [], remote }
}

/// DVC 添加 / Add a file to DVC.
pub fn dvc_add(dvc : DVC, path : String, hash : String) -> DVC {
  { tracked_files: dvc.tracked_files + [(path, hash)], remote: dvc.remote }
}

/// DVC 推送 / Push to remote.
pub fn dvc_push(dvc : DVC) -> String {
  let mut result = "push " + dvc.tracked_files.length().to_string() + " files to " + dvc.remote
  for i in 0..<dvc.tracked_files.length() {
    result = result + "\n  " + dvc.tracked_files[i].0 + " (" + dvc.tracked_files[i].1 + ")"
  }
  result
}

/// DVC 拉取 / Pull from remote.
pub fn dvc_pull(dvc : DVC) -> String {
  "pull " + dvc.tracked_files.length().to_string() + " files from " + dvc.remote
}

///===
/// 包标识 / Package id

/// 包标识 / Package id.
pub fn data_versioning_id() -> String {
  let pkg = "datatemporal/data_versioning"
  let version = "S12.11"
  let features = "commit,branch,tag,delta,snapshot,history,merge,rollback,policy,gc,timetravel,dvc"
  let result = pkg + " (" + version + "): " + features
  if result.length() > 0 {
    result
  } else {
    pkg
  }
}