///|
/// # opcore/registry 算子注册表 / Operator Registry
///
/// 算子注册表 + 契约校验。架构 §4.3。S0.4 提供注册/查询/校验基础。
///
/// # Operator registry
///
/// Registration, lookup, contract validation. See architecture §4.3.

///|
/// 算子注册表 / Operator registry.
pub struct Registry {
  operators : Array[@opcore.Operator]
} derive(Debug, Eq)

///|
pub extend Registry with Eq::{equal, not_equal}

///|
pub extend Registry with Debug::{to_repr}

///|
/// 空注册表 / Empty registry.
pub fn empty() -> Registry {
  { operators: [], }
}

///|
/// 注册算子 / Register an operator.
pub fn register(r : Registry, op : @opcore.Operator) -> Registry {
  let new_ops : Array[@opcore.Operator] = []
  for x in r.operators {
    new_ops.push(x)
  }
  new_ops.push(op)
  { operators: new_ops, }
}

///|
/// 按名称查询 / Lookup by name.
pub fn lookup(r : Registry, name : String) -> @opcore.Operator? {
  let mut found : @opcore.Operator? = None
  for op in r.operators {
    if op.name == name {
      found = Some(op)
    }
  }
  found
}

///|
/// 注册表大小 / Registry size.
pub fn size(r : Registry) -> Int32 {
  r.operators.length()
}

///|
/// 契约校验：算子名非空 / Contract validation: name non-empty.
pub fn valid_operator(op : @opcore.Operator) -> Bool {
  op.name.length() > 0
}

///|
pub fn registry_id() -> String {
  "opcore/registry"
}
