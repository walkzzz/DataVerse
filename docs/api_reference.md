# DataVerse API 参考文档

> **版本**：0.1.0-dev | **日期**：2026-11-04 | **状态**：与代码同步

## 目录

1. [核心 Trait 系统](#1-核心-trait-系统)
2. [统一错误处理](#2-统一错误处理)
3. [安全 API（safe_* 函数）](#3-安全-api)
4. [共享数学/统计函数（_common）](#4-共享数学统计函数)
5. [CLI 命令接口](#5-cli-命令接口)

---

## 1. 核心 Trait 系统

**包路径**：`dataverse/core/traits`

20 个 `pub(open) trait`，允许跨包实现。分为 5 组：

### 1.1 元信息 Trait

| Trait | 方法签名 | 用途 |
|-------|---------|------|
| `Named` | `name(Self) -> String` | 类型名称 |
| `Describable` | `describe(Self) -> String` | 内容描述 |
| `Versioned` | `version(Self) -> String` | 版本信息 |
| `Displayable` | `display(Self) -> String` | 格式化展示 |

**子 trait 层次**：`Displayable : Named + Describable`

### 1.2 验证 Trait

| Trait | 方法签名 | 用途 |
|-------|---------|------|
| `Checkable` | `check(Self) -> Bool` | 基本检查 |
| `Verifiable` | `verify(Self) -> Bool` | 深度验证 |
| `Resettable` | `reset(Self) -> Self` | 重置状态 |

**子 trait 层次**：`Verifiable : Checkable`

### 1.3 数据操作 Trait

| Trait | 方法签名 | 用途 |
|-------|---------|------|
| `Cloneable` | `clone(Self) -> Self` | 深拷贝 |
| `Serializable` | `serialize(Self) -> String` | 序列化 |
| `Countable` | `count(Self) -> Int` | 元素计数 |
| `Summarizable` | `summary(Self) -> String` | 摘要 |

### 1.4 计算 Trait

| Trait | 方法签名 | 用途 |
|-------|---------|------|
| `Measurable` | `norm(Self) -> Double` | 范数/度量 |
| `Ordered` | `compare(Self, Self) -> Int` | 排序比较 |

### 1.5 变换 Trait

| Trait | 方法签名 | 用途 |
|-------|---------|------|
| `Transformable` | `transform(Self) -> Self` | 变换 |
| `Composable` | `compose(Self, Self) -> Self` | 组合 |
| `Runnable` | `run(Self) -> Self` | 执行 |

### 1.6 集合 Trait

| Trait | 方法签名 | 用途 |
|-------|---------|------|
| `Foldable` | `fold(Self, Init, (Acc, El) -> Acc) -> Acc` | 折叠 |
| `Mappable` | `map(Self, (El) -> Res) -> Collection[Res]` | 映射 |
| `Filterable` | `filter(Self, (El) -> Bool) -> Self` | 过滤 |
| `Hashable` | `hash(Self) -> Int` | 哈希 |

### 1.7 实现统计

当前共 **2,095 个 trait 实现**，覆盖：
- 11 个核心类型（DataObject, Lineage, QualityCard, Modality, Operator 等）
- 409 个 Point/Series/Matrix/Vector 类型（分布在 7 个包中）
- 实现的 trait：Named, Describable, Displayable, Cloneable, Countable

### 1.8 实现模式

```moonbit
// 实现 trait 方法
pub impl @traits.Named for MyType with name(_self) { "MyType" }
// 扩展为常规方法（支持点调用）
pub extend MyType with @traits.Named::{name}
```

---

## 2. 统一错误处理

**包路径**：`dataverse/core/error`

### 2.1 错误类型

```moonbit
pub(all) enum DataVerseError {
  InvalidInput(String)       // E001 — 输入无效
  OutOfRange(String)         // E002 — 超出范围
  DimensionMismatch(String)  // E003 — 维度不匹配
  ConvergenceFailure(String) // E004 — 收敛失败
  NotSupported(String)       // E005 — 不支持
  Internal(String)           // E999 — 内部错误
}
```

### 2.2 辅助函数

| 函数 | 签名 | 说明 |
|------|------|------|
| `error_code` | `(DataVerseError) -> String` | 错误代码（E001-E999） |
| `error_message` | `(DataVerseError) -> String` | 完整错误消息 |
| `error_detail` | `(DataVerseError) -> String` | 错误详情 |
| `format_error` | `(DataVerseError) -> String` | 格式化输出 `E001: InvalidInput: msg` |
| `is_recoverable` | `(DataVerseError) -> Bool` | 是否可恢复（Internal 不可恢复） |
| `invalid_input` | `(String) -> DataVerseError` | 构造 InvalidInput |
| `out_of_range` | `(String) -> DataVerseError` | 构造 OutOfRange |
| `dimension_mismatch` | `(String) -> DataVerseError` | 构造 DimensionMismatch |
| `convergence_failure` | `(String) -> DataVerseError` | 构造 ConvergenceFailure |
| `not_supported` | `(String) -> DataVerseError` | 构造 NotSupported |
| `internal_error` | `(String) -> DataVerseError` | 构造 Internal |

### 2.3 使用模式

```moonbit
fn safe_divide(a : Double, b : Double) -> Result[Double, @error.DataVerseError] {
  if abs(b) < 1e-7 {
    Err(@error.invalid_input("division by zero"))
  } else {
    Ok(a / b)
  }
}
```

---

## 3. 安全 API

**包路径**：`dataverse/extcore/_common`

52 个 `safe_*` 函数，返回 `Result[T, DataVerseError]`。当输入不满足前置条件时返回错误，而非静默返回默认值。

### 3.1 统计安全 API

| 函数 | 签名 | 错误条件 |
|------|------|----------|
| `safe_mean` | `(Array[Double]) -> Result[Double, E]` | 空数组 |
| `safe_std` | `(Array[Double]) -> Result[Double, E]` | 空数组 |
| `safe_variance` | `(Array[Double]) -> Result[Double, E]` | 空数组 |
| `safe_min` | `(Array[Double]) -> Result[Double, E]` | 空数组 |
| `safe_max` | `(Array[Double]) -> Result[Double, E]` | 空数组 |
| `safe_median` | `(Array[Double]) -> Result[Double, E]` | 空数组 |
| `safe_sum` | `(Array[Double]) -> Result[Double, E]` | 空数组 |
| `safe_cov` | `(Array[Double], Array[Double]) -> Result[Double, E]` | 空数组/长度不匹配 |
| `safe_corr` | `(Array[Double], Array[Double]) -> Result[Double, E]` | 空数组/长度不匹配 |
| `safe_percentile` | `(Array[Double], Double) -> Result[Double, E]` | 空数组/p 超出 [0,100] |

### 3.2 评估指标安全 API

| 函数 | 错误条件 |
|------|----------|
| `safe_accuracy` | 空数组/长度不匹配 |
| `safe_mse` | 空数组/长度不匹配 |
| `safe_rmse` | 空数组/长度不匹配 |
| `safe_mae` | 空数组/长度不匹配 |
| `safe_r2` | 空数组/长度不匹配 |
| `safe_precision` | 空数组/长度不匹配 |
| `safe_recall` | 空数组/长度不匹配 |
| `safe_f1` | 空数组/长度不匹配 |

### 3.3 数学安全 API

| 函数 | 错误条件 |
|------|----------|
| `safe_sqrt` | 负数 |
| `safe_log` | 零或负数 |
| `safe_log10` | 零或负数 |
| `safe_pow` | 负底数非整数指数/零底数负指数 |
| `safe_tan` | cos(x) ≈ 0 |
| `safe_atan2` | (0, 0) |
| `safe_div` | 除零 |
| `safe_mod` | 除零 |
| `safe_reciprocal` | 零 |
| `safe_zscore` | 零标准差 |

### 3.4 数组操作安全 API

| 函数 | 错误条件 |
|------|----------|
| `safe_normalize` | 空数组/零和 |
| `safe_standardize` | 空数组/零标准差 |
| `safe_clip` | 空数组/lo > hi |
| `safe_cumsum` | 空数组 |
| `safe_reverse` | 空数组 |
| `safe_concat` | 两个都空 |
| `safe_copy_arr` | 空数组 |
| `safe_scale_arr` | 空数组 |
| `safe_add_arr` | 长度不匹配 |
| `safe_sub_arr` | 长度不匹配 |
| `safe_fill_arr` | 负数长度 |
| `safe_sort` | 空数组 |
| `safe_sort_desc` | 空数组 |
| `safe_dot` | 长度不匹配 |
| `safe_distance` | 长度不匹配 |
| `safe_index` | 越界 |
| `safe_range` | 负数 |

### 3.5 数论安全 API

| 函数 | 错误条件 |
|------|----------|
| `safe_factorial` | 负数/大于 20 |
| `safe_gcd` | 两个都为零 |
| `safe_lcm` | 任一为零 |
| `safe_fibonacci` | 负数 |
| `safe_is_prime` | 小于 2 |

### 3.6 标量安全 API

| 函数 | 错误条件 |
|------|----------|
| `safe_clamp` | lo > hi |
| `safe_lerp` | t 超出 [0, 1] |

---

## 4. 共享数学/统计函数

**包路径**：`dataverse/extcore/_common`

55+ 个非安全函数，直接返回值（不检查错误条件）。

### 4.1 数学函数

`sqrt`, `abs`, `clamp`, `lerp`, `deg_to_rad`, `rad_to_deg`, `log`, `log10`, `exp`, `pow`, `sin`, `cos`, `tan`, `atan2`, `hypot`, `max2`, `min2`, `floor`, `ceil`, `deg`, `approx_eq`, `dbl`

### 4.2 统计函数

`mean`, `sum`, `variance`, `std`, `cov`, `corr`, `median`, `accuracy`, `mse`, `rmse`, `mae`, `r2`, `precision`, `recall`, `f1`

### 4.3 数组函数

`sort`, `sort_desc`, `normalize`, `standardize`, `clip`, `cumsum`, `reverse`, `concat`, `copy_arr`, `scale_arr`, `add_arr`, `sub_arr`, `fill_arr`, `min`, `max`

### 4.4 数论函数

`factorial`, `gcd`, `lcm`, `is_prime`, `fibonacci`

---

## 5. CLI 命令接口

**入口**：`apps/cli/cmd/main/main.mbt`

支持 12 个命令，使用安全 API 和命令分发架构：

| 命令 | 功能 | 安全 API |
|------|------|----------|
| `mean` | 计算均值 | safe_mean |
| `std` | 计算标准差 | safe_std |
| `variance` | 计算方差 | safe_variance |
| `min` | 最小值 | safe_min |
| `max` | 最大值 | safe_max |
| `median` | 中位数 | safe_median |
| `sqrt` | 平方根 | safe_sqrt |
| `log` | 对数 | safe_log |
| `normalize` | 归一化 | safe_normalize |
| `div` | 安全除法 | safe_div |
| `factorial` | 阶乘 | safe_factorial |
| `help` | 帮助信息 | — |