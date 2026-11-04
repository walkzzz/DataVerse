# core — 核心抽象层

DataVerse 的核心抽象层，包含 trait 定义和统一错误处理。

## 子包

| 包 | 说明 |
|----|------|
| `core/traits` | 20 个 `pub(open) trait`，覆盖数据科学库统一行为抽象 |
| `core/error` | `DataVerseError` 统一错误类型，6 个错误分类 |

## 依赖关系

`core` 是最底层包，不依赖任何其他 DataVerse 包。

```
core/traits  ←  无依赖
core/error   ←  无依赖
```

所有其他包可以安全地导入 `core/traits` 和 `core/error`。