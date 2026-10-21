///|
/// # dosi/batch 批量索引管理 / Batch Index Management
///
/// 批量添加/删除/更新索引。架构 §4.7 DOSI 扩充。
/// S2.8 填充：BatchOp + BatchOperation + apply_batch。
///
/// # Batch index management
///
/// Batch add/remove/update. See architecture §4.7.

///|
/// 批量操作类型 / Batch operation kind.
pub(all) enum BatchOp {
  Add
  Remove
  Update
} derive(Debug, Eq)

///|
pub extend BatchOp with Eq::{equal, not_equal}

///|
pub extend BatchOp with Debug::{to_repr}

///|
/// 批量操作 / Batch operation.
pub struct BatchOperation {
  op : BatchOp
  path : String
  entry : @dosi.DOSIEntry?
} derive(Debug, Eq)

///|
pub extend BatchOperation with Eq::{equal, not_equal}

///|
pub extend BatchOperation with Debug::{to_repr}

///|
/// 构造批量添加操作 / Build batch add operation.
pub fn batch_add(entry : @dosi.DOSIEntry) -> BatchOperation {
  { op: Add, path: entry.symbolic.path, entry: Some(entry), }
}

///|
/// 构造批量删除操作 / Build batch remove operation.
pub fn batch_remove(path : String) -> BatchOperation {
  { op: Remove, path, entry: None, }
}

///|
/// 构造批量更新操作 / Build batch update operation.
pub fn batch_update(entry : @dosi.DOSIEntry) -> BatchOperation {
  { op: Update, path: entry.symbolic.path, entry: Some(entry), }
}

///|
/// 批量应用操作 / Apply batch operations to index.
///
/// 退化安全：空操作返回原索引。
pub fn apply_batch(
  index : @dosi.DOSIIndex,
  operations : Array[BatchOperation],
) -> @dosi.DOSIIndex {
  let mut current = index
  for i in 0..<operations.length() {
    let op = operations[i]
    match op.op {
      Add =>
        match op.entry {
          Some(e) => current = current.add(e)
          None => ()
        }
      Remove => current = current.remove_by_path(op.path)
      Update =>
        match op.entry {
          Some(e) => current = current.remove_by_path(op.path).add(e)
          None => ()
        }
    }
  }
  current
}

///|
/// 批量操作名称 / Batch op name.
pub fn batch_op_name(op : BatchOp) -> String {
  match op {
    Add => "add"
    Remove => "remove"
    Update => "update"
  }
}

///|
pub fn batch_id() -> String {
  "dosi/batch"
}
