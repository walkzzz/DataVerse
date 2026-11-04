///|
/// # core/traits — 核心 trait 抽象层 / Core Trait Abstractions
///
/// 定义 20 个 `pub(open) trait`，覆盖数据科学库的统一行为抽象。
/// 所有 trait 允许跨包实现（`pub(open)`）。
///
/// ## trait 层次
/// - `Verifiable : Checkable`
/// - `Displayable : Named + Describable`
///
/// ## 分类
/// | 分类 | trait |
/// |------|-------|
/// | 元信息 | Named, Describable, Versioned, Displayable |
/// | 验证 | Checkable, Verifiable, Resettable |
/// | 数据操作 | Cloneable, Serializable, Countable, Summarizable |
/// | 计算 | Measurable, Ordered |
/// | 变换 | Transformable, Composable, Runnable |
/// | 集合 | Foldable, Mappable, Filterable, Hashable |

// ============================================================================
// 元信息 trait
// ============================================================================

///|
/// 有名称 / Has a name.
pub(open) trait Named {
  name(Self) -> String
}

///|
/// 有描述 / Has a description.
pub(open) trait Describable {
  describe(Self) -> String
}

///|
/// 有版本 / Has a version.
pub(open) trait Versioned {
  version(Self) -> String
}

///|
/// 可显示 / Displayable (extends Named + Describable).
pub(open) trait Displayable : Named + Describable {
  display(Self) -> String
}

// ============================================================================
// 验证 trait
// ============================================================================

///|
/// 可检查 / Checkable.
pub(open) trait Checkable {
  check(Self) -> Bool
}

///|
/// 可验证 / Verifiable (extends Checkable).
pub(open) trait Verifiable : Checkable {
  verify(Self) -> Bool
}

///|
/// 可重置 / Resettable.
pub(open) trait Resettable {
  reset(Self) -> Self
}

// ============================================================================
// 数据操作 trait
// ============================================================================

///|
/// 可克隆 / Cloneable.
pub(open) trait Cloneable {
  clone(Self) -> Self
}

///|
/// 可序列化 / Serializable.
pub(open) trait Serializable {
  serialize(Self) -> String
}

///|
/// 可计数 / Countable.
pub(open) trait Countable {
  count(Self) -> Int
}

///|
/// 可摘要 / Summarizable.
pub(open) trait Summarizable {
  summary(Self) -> String
}

// ============================================================================
// 计算 trait
// ============================================================================

///|
/// 可度量 / Measurable (norm + distance).
pub(open) trait Measurable {
  norm(Self) -> Double
  distance(Self, Self) -> Double
}

///|
/// 有序 / Ordered.
pub(open) trait Ordered {
  compare(Self, Self) -> Int
}

// ============================================================================
// 变换 trait
// ============================================================================

///|
/// 可变换 / Transformable.
pub(open) trait Transformable {
  transform(Self) -> Self
}

///|
/// 可组合 / Composable.
pub(open) trait Composable {
  compose(Self, Self) -> Self
}

///|
/// 可执行 / Runnable.
pub(open) trait Runnable {
  run(Self) -> String
}

// ============================================================================
// 集合 trait
// ============================================================================

///|
/// 可折叠 / Foldable.
pub(open) trait Foldable {
  fold(Self, (Double, Double) -> Double, Double) -> Double
}

///|
/// 可映射 / Mappable.
pub(open) trait Mappable {
  map(Self, (Double) -> Double) -> Self
}

///|
/// 可过滤 / Filterable.
pub(open) trait Filterable {
  filter(Self, (Double) -> Bool) -> Self
}

///|
/// 可哈希 / Hashable.
pub(open) trait Hashable {
  hash(Self) -> Int
}