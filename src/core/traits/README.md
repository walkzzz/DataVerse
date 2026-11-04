# core/traits — 核心 Trait 抽象层

20 个 `pub(open) trait`，覆盖数据科学库的统一行为抽象。

## Trait 列表

| 分类 | trait | 方法 |
|------|-------|------|
| 元信息 | `Named` | `name(Self) -> String` |
| 元信息 | `Describable` | `describe(Self) -> String` |
| 元信息 | `Versioned` | `version(Self) -> String` |
| 元信息 | `Displayable` | `display(Self) -> String` |
| 验证 | `Checkable` | `check(Self) -> Bool` |
| 验证 | `Verifiable` | `verify(Self) -> Bool` |
| 验证 | `Resettable` | `reset(Self) -> Self` |
| 数据操作 | `Cloneable` | `clone(Self) -> Self` |
| 数据操作 | `Serializable` | `serialize(Self) -> String` |
| 数据操作 | `Countable` | `count(Self) -> Int` |
| 数据操作 | `Summarizable` | `summary(Self) -> String` |
| 计算 | `Measurable` | `norm`, `distance` |
| 计算 | `Ordered` | `compare(Self, Self) -> Int` |
| 变换 | `Transformable` | `transform(Self) -> Self` |
| 变换 | `Composable` | `compose(Self, Self) -> Self` |
| 变换 | `Runnable` | `run(Self) -> String` |
| 集合 | `Foldable` | `fold(Self, (Double, Double) -> Double, Double) -> Double` |
| 集合 | `Mappable` | `map(Self, (Double) -> Double) -> Self` |
| 集合 | `Filterable` | `filter(Self, (Double) -> Bool) -> Self` |
| 集合 | `Hashable` | `hash(Self) -> Int` |

## 子 trait 层次

- `Verifiable : Checkable`
- `Displayable : Named + Describable`

## 使用方式

```moonbit
// 在其他包中实现 trait
pub impl @traits.Named for MyType with name(self) {
  "MyType"
}
pub extend MyType with @traits.Named::{name}
```