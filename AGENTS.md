# DataVerse — 项目 Agent 指南

> AI-oriented first-class data entity + full-domain data algorithm operator engine | MoonBit

## 项目定位

**DataVerse** 是一个面向 AI 的数据一等实体 + 全域数据算法算子引擎，将数据算子与模型/学习算子统一为一等公民。

## 当前状态

- **259 包** · **1,200 源文件** · **510,000 行源码**
- **212,518 pub fn** · **1,610 pub struct** · **20 pub(open) trait** · **2,510 trait 实现**
- **4,132 测试** · **94+ proof_assert** · **0 errors** · **3 warnings** · **98.5% 包测试覆盖**
- **126 安全 API**（`safe_*` 函数，返回 `Result[T, DataVerseError]`）
- **7 可执行入口**（cli/bench/demo/proof/stats/extcore/info）
- **20 领域**（extcore）+ **12 子包**（opcore）+ **11 子包**（learncore）
- 统一错误处理：`Result[T, DataVerseError]`（6 错误分类）+ suberror/raise/try-catch 机制（5 suberror 类型 + 8 raise 操作 + 4 错误多态 HOF）
- Trait 系统：20 核心 `pub(open) trait` + 子 trait 层次
- 工具链：MoonBit v0.1.20261020

## 项目结构

```
dataverse/
├── moon.mod / moon.pkg / dataverse.mbt   # 根包统一入口
├── src/
│   ├── core/          # 核心 trait 抽象 + 统一错误处理
│   │   ├── traits/    # 20 个 pub(open) trait
│   │   └── error/     # DataVerseError 统一错误类型
│   ├── kernel/        # 算子执行内核（exact/approx/streaming/cache）
│   ├── dataobject/    # 一等数据实体 + 血缘 + 质量档案
│   ├── opcore/        # 全域算子库（14 类数据算子 + 6 类学习算子）
│   ├── learncore/     # 模型/学习类算法算子（ML/DL/SSL/Eval/Adapt/Optim）
│   ├── extcore/       # 扩展核心算法库（20 领域 92 子包）
│   ├── datatemporal/  # 数据时序（版本/血缘/漂移/回放）
│   ├── datair/        # 数据 IR（核心/实体/算子/管道/优化/融合）
│   ├── dosi/          # DOSI（builder/router/context/verifier）
│   ├── agent_kit/     # Agent 工具包
│   ├── proof/         # 形式化证明
│   ├── testing/       # 测试框架（mock/fake）
│   ├── spec/          # 属性测试
│   └── tests/         # 集成测试
├── apps/              # 7 个可执行入口
│   ├── cli/           # 生产级 CLI（命令分发 + 安全 API）
│   ├── bench/         # 基准工具
│   ├── demo/          # 功能展示
│   ├── proof/         # 证明验证
│   ├── stats/         # 统计工具
│   ├── extcore/       # 扩展核心入口
│   └── info/          # 信息工具
└── docs/
    ├── SOP.md         # MoonBit 工作流
    ├── arch_test_report.md  # 多手段测试报告
    ├── library_layout.md    # 库布局
    ├── roadmap.md           # 迭代路线
    ├── changelog.md         # 变更日志
    └── rules.md             # 规则全集
```

## Trait 系统

20 个 `pub(open) trait`，覆盖数据科学库统一行为抽象：

### 元信息
- `Named` / `Describable` / `Versioned` / `Displayable`

### 验证
- `Checkable` / `Verifiable` / `Resettable`

### 数据操作
- `Cloneable` / `Serializable` / `Countable` / `Summarizable`

### 计算
- `Measurable` / `Ordered`

### 变换
- `Transformable` / `Composable` / `Runnable`

### 集合
- `Foldable` / `Mappable` / `Filterable` / `Hashable`

### 子 trait 层次
- `Verifiable : Checkable`
- `Displayable : Named + Describable`

### 已实现 trait 的类型
| 类型 | 包 | 已实现 trait |
|------|-----|-------------|
| `DataObject` | dataobject | Named, Describable, Displayable, Checkable, Cloneable, Serializable, Countable |
| `Lineage` | dataobject | Named, Describable, Displayable, Serializable |
| `QualityCard` | dataobject | Named, Describable, Displayable, Checkable, Summarizable |
| `Modality` | dataobject | Named, Describable, Displayable |
| `Operator` | opcore | Named, Describable, Displayable, Checkable, Verifiable, Runnable, Cloneable |
| `OperatorResult` | opcore | Named, Describable, Displayable, Summarizable, Countable |
| `OperatorCategory` | opcore | Named, Describable, Displayable |
| `ExecMode` | kernel | Named, Describable, Displayable, Cloneable |
| `Consistency` | kernel | Named, Describable, Displayable |
| `Hyperparams` | learncore | Named, Describable, Displayable, Countable, Cloneable, Serializable |
| `ModelSpace` | learncore | Named, Describable, Displayable |

## 错误处理

统一错误类型 `DataVerseError`（`pub(all) enum`）：

| 错误码 | 变体 | 含义 |
|--------|------|------|
| E001 | InvalidInput | 输入参数无效 |
| E002 | OutOfRange | 值超出有效范围 |
| E003 | DimensionMismatch | 维度不匹配 |
| E004 | ConvergenceFailure | 迭代未收敛 |
| E005 | NotSupported | 操作不支持 |
| E999 | Internal | 内部错误 |

安全 API 返回 `Result[T, DataVerseError]`：
- `safe_mean` / `safe_std` / `safe_variance` / `safe_min` / `safe_max` / `safe_median`
- `safe_sqrt` / `safe_log` / `safe_factorial` / `safe_normalize` / `safe_div` / `safe_index`

## MoonBit 技术要点

| 要点 | 说明 |
|------|------|
| 方法定义 | `fn Type::meth(self : Type, ..)` |
| 布尔取反 | `!expr`（`not(x)` 已废弃）|
| trait impl | `pub impl Trait for Type with method` + `pub extend Type with Trait::{method}` |
| `pub(open) trait` | 跨包实现必须用 `pub(open)` |
| `pub(all) enum` | 跨包构造变体必须用 `pub(all)` |
| 泛型函数 | `fn[T] f()` 而非 `fn f[T]()` |
| 函数类型 | `(Double) -> Double` 而非 `Double -> Double` |
| 文件名陷阱 | 源文件名不能含 `_test`（会被视为测试文件）|
| 测试文件引用 | 测试文件中用 `@包名.` 前缀引用同包 API |
| enum 变体构造 | 测试文件中用 `@包.EnumType::Variant(...)` |
| 跨包导入 | `dataverse/pkg_name` |

## 常用命令

```bash
moon check                    # 类型检查 + warning 治理
moon test                     # 运行全量测试
moon fmt                      # 格式化
moon info                     # 生成 .mbti，检查 API 变更
moon clean                    # 切换版本后必须先 clean
```

## 验收门禁

- `moon check` 0 error（warning 目标 0，当前 4 个已知）
- `moon test` 全通过
- 所有 `pub fn` 有 `///` 注释