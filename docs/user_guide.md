# DataVerse 用户使用手册

> **版本**：0.1.0-dev | **日期**：2026-11-04

## 1. 环境要求

- **MoonBit 工具链**：v0.1.20261020 或更高
- **操作系统**：Windows / macOS / Linux
- **Moon**：MoonBit 包管理器（随工具链安装）

## 2. 安装

```bash
# 克隆项目
git clone <repo-url> dataverse
cd dataverse

# 验证安装
moon check
moon test
```

## 3. 快速开始

### 3.1 使用 CLI 工具

```bash
# 进入 CLI 目录
cd apps/cli

# 计算均值
moon run cmd/main mean 1.0 2.0 3.0 4.0 5.0
# 输出: 3.00

# 计算标准差
moon run cmd/main std 1.0 2.0 3.0 4.0 5.0
# 输出: 1.41

# 安全除法
moon run cmd/main div 10.0 3.0
# 输出: 3.33

# 安全除法（除零）
moon run cmd/main div 10.0 0.0
# 输出: Error[E001]: division by zero
```

### 3.2 作为库使用

```moonbit
// 在你的 moon.pkg 中添加依赖
import {
  "dataverse/extcore/_common",
  "dataverse/core/error",
  "dataverse/core/traits",
}

// 使用安全 API
fn my_mean(data : Array[Double]) -> Double {
  match @_common.safe_mean(data) {
    Ok(v) => v
    Err(e) => {
      println(@error.format_error(e))
      0.0
    }
  }
}

// 使用 trait 系统
fn show_type_name[T : @traits.Named](x : T) -> String {
  x.name()
}
```

## 4. 核心 API 使用

### 4.1 安全 API

安全 API 返回 `Result[T, DataVerseError]`，在错误条件下返回 `Err`：

```moonbit
// 统计计算
let result = match @_common.safe_mean([1.0, 2.0, 3.0]) {
  Ok(v) => "mean = \{v}"
  Err(e) => @error.format_error(e)
}

// 数组操作
let normalized = match @_common.safe_normalize([1.0, 2.0, 3.0]) {
  Ok(arr) => arr
  Err(_) => []
}

// 维度检查
let dot = match @_common.safe_dot([1.0, 2.0], [3.0, 4.0]) {
  Ok(v) => v
  Err(e) => {
    // e 是 DimensionMismatch 错误
    0.0
  }
}
```

### 4.2 错误处理

```moonbit
let e = @error.invalid_input("parameter x must be positive")
// error_code(e) == "E001"
// error_message(e) == "InvalidInput: parameter x must be positive"
// format_error(e) == "E001: InvalidInput: parameter x must be positive"
// is_recoverable(e) == true
```

### 4.3 Trait 系统

```moonbit
// 任何实现了 Named trait 的类型都可以用 .name() 调用
let p : AutocorrPoint = { x: 1.0, y: 2.0, label: 0 }
println(p.name())        // "AutocorrPoint"
println(p.describe())    // "x=1.0, y=2.0"
println(p.display())     // "AutocorrPoint(x=1.0, y=2.0)"
println(p.count())       // 2
```

## 5. 常用命令

```bash
moon check              # 类型检查 + warning 治理
moon test               # 运行全量测试
moon fmt                # 格式化
moon info               # 生成 .mbti，检查 API 变更
moon clean              # 清理缓存（切换版本后必须先 clean）
moon coverage analyze   # 分析未覆盖代码
```

## 6. 项目结构

详见 [README.md](../README.md) 和 [架构文档](../DataVerse-数据算子库-ARCHITECTURE.md)。

## 7. 故障排查

| 问题 | 原因 | 解决方案 |
|------|------|----------|
| `Value not found in package` | 源文件名含 `_test` | 重命名文件（如 `ai_test.mbt` → `aitest.mbt`） |
| `Cannot create values of the read-only type` | 在测试文件中构造非 `pub(all)` struct | 使用构造函数或 `pub(all) struct` |
| `Function with error can only be used inside a function with error types` | 在普通函数中调用 raise 函数 | 用 `raise` 声明或用 `try/catch` |
| `Type Int has no method to_int` | Int32 乘法已返回 Int | 去掉 `.to_int()` 调用 |
| Warning: `unused_package` | moon.pkg 导入了未使用的包 | 删除未使用的导入 |