///|
/// # core/traits — 核心 trait 抽象层 / Core Trait Abstractions
///
/// 定义 20 个 `pub(open) trait`，覆盖数据科学库的统一行为抽象。
/// 所有 trait 允许跨包实现（`pub(open)`）。
///
/// ## trait 层次
/// - `Displayable : Named + Describable`（display 有默认实现）
/// - `Verifiable : Checkable`（verify 有默认实现）
/// - `Summarizable : Named + Describable`（summary 有默认实现）
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
/// 默认实现: `name(self) + "(" + describe(self) + ")"`
pub(open) trait Displayable : Named + Describable {
  display(Self) -> String = _
}

///|
/// Displayable 默认实现
impl Displayable with display(self) {
  Named::name(self) + "(" + Describable::describe(self) + ")"
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
/// 默认实现: `verify(self) = check(self)`
pub(open) trait Verifiable : Checkable {
  verify(Self) -> Bool = _
}

///|
/// Verifiable 默认实现
impl Verifiable with verify(self) {
  Checkable::check(self)
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
/// 可摘要 / Summarizable (extends Named + Describable).
/// 默认实现: `name(self) + ": " + describe(self)`
pub(open) trait Summarizable : Named + Describable {
  summary(Self) -> String = _
}

///|
/// Summarizable 默认实现
impl Summarizable with summary(self) {
  Named::name(self) + ": " + Describable::describe(self)
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
// ============================================================================
// 通用辅助函数 / Generic Helper Functions
// ============================================================================
// 这些函数用于减少各包中 trait 实现的重复代码。

///|
/// Point 类型通用 describe 辅助函数
pub fn point_describe(x : Double, y : Double) -> String {
  "x=" + x.to_string() + ", y=" + y.to_string()
}

///|
/// Point 类型通用 display 辅助函数
pub fn point_display(name : String, x : Double, y : Double) -> String {
  name + "(x=" + x.to_string() + ", y=" + y.to_string() + ")"
}

///|
/// Series 类型通用 describe 辅助函数
pub fn series_describe(len : Int, name : String) -> String {
  "vals=" + len.to_string() + ", name=" + name
}

///|
/// Series 类型通用 display 辅助函数
pub fn series_display(type_name : String, len : Int, name : String) -> String {
  type_name + "(vals=" + len.to_string() + ", name=" + name + ")"
}

///|
/// Matrix 类型通用 describe 辅助函数
pub fn matrix_describe(rows : Int, cols : Int) -> String {
  "rows=" + rows.to_string() + ", cols=" + cols.to_string()
}

///|
/// Matrix 类型通用 display 辅助函数
pub fn matrix_display(type_name : String, rows : Int, cols : Int) -> String {
  type_name + "(rows=" + rows.to_string() + ", cols=" + cols.to_string() + ")"
}

///|
/// Vector 类型通用 describe 辅助函数
pub fn vector_describe(dim : Int) -> String {
  "dim=" + dim.to_string()
}

///|
/// Vector 类型通用 display 辅助函数
pub fn vector_display(type_name : String, dim : Int) -> String {
  type_name + "(dim=" + dim.to_string() + ")"
}

///|
/// 通用 name 辅助函数 — 返回类型名
pub fn type_name(s : String) -> String {
  s
}

// ============================================================================
// Trait 组合器 / Trait Combinators
// ============================================================================
// 这些组合器函数用于组合多个 trait 操作，减少调用处的重复代码。

///|
/// 检查并重置 / Check and reset if invalid.
pub fn[T : Checkable + Resettable] check_and_reset(v : T) -> T {
  if Checkable::check(v) {
    v
  } else {
    Resettable::reset(v)
  }
}

///|
/// 克隆并检查 / Clone and check.
pub fn[T : Cloneable + Checkable] clone_and_check(v : T) -> Bool {
  Checkable::check(Cloneable::clone(v))
}

///|
/// 显示并检查 / Display and check status.
pub fn[T : Displayable + Checkable] display_with_status(v : T) -> String {
  let status = if Checkable::check(v) { "OK" } else { "INVALID" }
  Displayable::display(v) + " [" + status + "]"
}

///|
/// 名称和版本 / Name with version.
pub fn[T : Named + Versioned] name_with_version(v : T) -> String {
  Named::name(v) + " v" + Versioned::version(v)
}

///|
/// 摘要和检查 / Summary with check status.
pub fn[T : Summarizable + Checkable] summary_with_check(v : T) -> String {
  let status = if Checkable::check(v) { "valid" } else { "invalid" }
  Summarizable::summary(v) + " (" + status + ")"
}

///|
/// 序列化和检查 / Serialize with check.
pub fn[T : Serializable + Checkable] serialize_if_valid(v : T) -> String {
  if Checkable::check(v) {
    Serializable::serialize(v)
  } else {
    "<invalid>"
  }
}

///|
/// 计数并显示 / Count and display.
pub fn[T : Countable + Displayable] count_and_display(v : T) -> String {
  Displayable::display(v) + " count=" + Countable::count(v).to_string()
}

///|
/// 度量并显示 / Norm and display.
pub fn[T : Measurable + Displayable] norm_and_display(v : T) -> String {
  Displayable::display(v) + " norm=" + Measurable::norm(v).to_string()
}

///|
/// 哈希并显示 / Hash and display.
pub fn[T : Hashable + Displayable] hash_and_display(v : T) -> String {
  Displayable::display(v) + " hash=" + Hashable::hash(v).to_string()
}

///|
/// 双重验证 / Double check (check + verify).
pub fn[T : Verifiable] double_check(v : T) -> Bool {
  Verifiable::verify(v) && Checkable::check(v)
}
