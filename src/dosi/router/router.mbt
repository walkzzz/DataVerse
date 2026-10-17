///|
/// # dosi/router 检索路由 / DOSI Router
///
/// Agent-Kit 的入口：自然语言需求 → 定位涉及算子/Schema。
/// 评估 Token 预算，只召回相关条目的完整文档。架构 §4.7.3。
/// S0.7 基础版本：按路径、分类、模态精确查询。
///
/// # DOSI router
///
/// Lookup by path / category / modality. See architecture §4.7.3.

/// 按路径查询 / Lookup by path.
///
/// 精确匹配符号层 path 字段；未找到返回 None。
pub fn lookup_by_path(
  idx : @dosi.DOSIIndex,
  path : String
) -> @dosi.DOSIEntry? {
  let matched = idx.entries().filter(fn(e) { e.symbolic.path == path })
  if matched.length() > 0 {
    Some(matched[0])
  } else {
    None
  }
}

/// 按分类查询 / Lookup by category.
///
/// 返回所有符号层 category 匹配的条目。
pub fn lookup_by_category(
  idx : @dosi.DOSIIndex,
  category : String
) -> Array[@dosi.DOSIEntry] {
  idx.entries().filter(fn(e) { e.symbolic.category == category })
}

/// 按模态查询 / Lookup by modality.
///
/// 返回所有符号层 modality 匹配的条目。
pub fn lookup_by_modality(
  idx : @dosi.DOSIIndex,
  modality : String
) -> Array[@dosi.DOSIEntry] {
  idx.entries().filter(fn(e) { e.symbolic.modality == modality })
}

/// 按路径前缀查询 / Lookup by path prefix.
///
/// 用于按模块批量召回（如 "opcore.clean." 召回所有 clean 算子）。
pub fn lookup_by_prefix(
  idx : @dosi.DOSIIndex,
  prefix : String
) -> Array[@dosi.DOSIEntry] {
  idx.entries().filter(fn(e) { e.symbolic.path.has_prefix(prefix) })
}

pub fn router_id() -> String {
  "dosi/router"
}