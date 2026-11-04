# DataVerse 数据算子库

> **版本**：1.0.0-beta (生产就绪)  
> **日期**：2026-11-04  
> **语言**：MoonBit v0.1.20261020  
> **状态**：生产就绪 · 10 逻辑库 · 4067 tests passed · 0 errors · 3 warnings · 98.5% 包测试覆盖s

**DataVerse** 是一套面向 AI 的**一等数据实体 + 全域数据算法算子引擎**。把数据从"管道里的过客"提升为"一等实体"，把算子从"上层脚本"下沉为"内核原生算子"，所有算子统一编码进 **DataIR**，配套 **DOSI** 符号语义索引管控 AI 上下文。

## 项目统计 / Project Stats

| 指标 | 数值 |
|------|------|
| 源码行数 | ~517,160 行 |
| MoonBit 文件 | 1,265 个 .mbt 文件 |
| 测试 | 4,067 passed, 0 failed · 98.5% 包覆盖（322/327） |
| 逻辑库 | 10 个（详见 [docs/library_layout.md](./docs/library_layout.md)） |
| Workspace 成员 | 7 个独立子项目 |
| `_common` 函数 | 55+ 共享函数 |
| 安全 API | 126 个 `safe_*` 函数（返回 `Result[T, DataVerseError]`） |
| Trait 系统 | 20 个 `pub(open) trait` · 2,913 个 trait 实现 |
| extcore | 826→92 子包（20 领域，-89%） |
| opcore | 121→12 子包（-90%） |
| learncore | 89→11 子包（-88%） |
| 形式化证明 | 25 个 `proof_assert`（src/proof/） |
| MOCK 框架 | 5 个 `pub(open) trait` + 9 测试（src/testing/mock/） |
| FAKE 退化测试 | 16 测试（src/testing/fake/） |
| 属性测试 | 130 个 proof-carrying（src/spec/） |
| Errors | 0 |

## 核心原则 / Core Principles

- **数据不是管道的过客，是一等实体**：数据对象自带模式（Schema）、质量、血缘、版本、时空生命周期。
- **算子不是上层脚本，是内核原生算子**：清洗、去重、过滤、评分、变换、配比等全部下沉到执行内核。
- **Agent 不是 API 调用器，是算子编排器**：自然语言意图 → DataIR 算子图 → 硬件执行。
- **一切可追溯、可举证、可回放**：算子可序列化、可复现、可审计，血缘与版本是一等公民。

## 七层架构 / Seven-Layer Architecture

| 层 | 模块 | 职责 |
|----|------|------|
| 七 | self_evolve | 自演化智能层（自省类 + 探索类） |
| 六 | agent_kit | 自然语言 → DataIR 编排 |
| 五 | datair | 全域数据中间表示 |
| 四 | opcore / datatemporal / recipe | 领域高阶算子层 |
| 三 | dataobject | 基础数据层 |
| 二 | parallel | 执行调度 & 并行分布式 |
| 一 | kernel | 算子执行内核（四模式） |
| 横 | dosi | 符号语义索引基础设施 |
| 横 | governance | 元数据 / 血缘 / 治理 |

详见 [DataVerse-数据算子库-ARCHITECTURE.md](./DataVerse-数据算子库-ARCHITECTURE.md)。

## 源码结构 / Source Layout

```
src/
├── kernel          # 算子执行内核（exact/approx/streaming/cache）
├── dataobject      # 一等数据实体（Schema/Chunk/Embedding/Record/Dataset）
├── extcore         # 扩展核心算法库（20 领域 92 子包）
├── opcore          # 操作符引擎（12 子包）
├── learncore       # 学习算法库（11 子包）
├── datatemporal    # 数据时空·版本·血缘
├── recipe          # 复合数据流水线
├── datair          # 全域数据中间表示
├── dosi            # 符号语义索引
├── agent_kit       # 自然语言编排
├── self_evolve     # 自演化层
├── parallel        # 并行/分布式调度
├── io              # 存储适配
├── governance      # 元数据/合规/审计
├── proof           # 形式化证明（proof_assert）
├── testing         # 测试框架（mock + fake）
├── spec            # 属性测试（130 个 proof-carrying）
└── tests           # 跨包集成测试（1432 个）
```

## 10 逻辑库 / 10 Logical Libraries

详见 [docs/library_layout.md](./docs/library_layout.md)。

| 库 | 包组 | 层 | 依赖 |
|---|------|-----|------|
| lib-extcore | extcore | L0 | — |
| lib-datair | datair | L0 | — |
| lib-kernel | kernel, governance, self_evolve | L0 | — |
| lib-dataobject | dataobject, datatemporal, io | L1 | extcore |
| lib-dosi | dosi, parallel | L2 | datair, dataobject |
| lib-opcore | opcore | L2 | dataobject, extcore, kernel |
| lib-agent | agent_kit | L2 | dosi, extcore |
| lib-learn | learncore, recipe | L3 | extcore, opcore, dataobject |
| lib-qa | proof, testing | L4 | dataobject, learn, opcore, agent |
| lib-meta | spec, tests | L4 | 几乎所有 |

## Roadmap

详见 [docs/roadmap.md](./docs/roadmap.md)。

| Sprint | 内容 | 状态 |
|--------|------|------|
| Phase 0-12 | 基础架构 + 100K 行 + 1528 tests | ✅ |
| Phase 13-22 | 语义包扩展 + 826 包 + 190 万行 | ✅ |
| 包结构重构 | extcore 826→92, opcore 121→12, learncore 89→11 | ✅ |
| 形式化证明 | 25 proof_assert + 130 spec | ✅ |
| MOCK 框架 | 5 trait + 9 测试 | ✅ |
| FAKE 退化测试 | 16 测试 | ✅ |
| 10 逻辑库划分 | 对照 OCaml janestreet/core | ✅ |
| Warning 治理 | 506→3 (-99.4%) | ✅ |

## 开发规则 / Development Rules

详见 [docs/rules.md](./docs/rules.md)。优先级：防跑偏规则 > 项目规则 > 个人偏好。

## 构建 / Build

```bash
moon check    # 类型检查 (0 errors)
moon test     # 运行测试 (1708 passed)
moon build    # 构建
moon fmt      # 格式化
moon info     # 生成 .mbti API 接口文件

# Workspace 子项目
moon run apps/cli/cmd/main --target native       # CLI 工具
moon run apps/proof/cmd/main --target native     # 证明验证工具
moon run apps/stats/cmd/main --target native     # 统计分析工具
moon run apps/info/cmd/main --target native      # 项目信息
moon run apps/extcore/cmd/main --target native   # 语义包探索
```

## 多手段测试 / Multi-Strategy Testing

详见 [docs/arch_test_report.md](./docs/arch_test_report.md)。

| 手段 | 测试数 | 位置 |
|------|--------|------|
| 形式化证明 | 25 | src/proof/ |
| FAKE 退化测试 | 16 | src/testing/fake/ |
| MOCK 框架 | 9 | src/testing/mock/ |
| 属性测试 | 130 | src/spec/ |
| E2E 集成测试 | 1432 | src/tests/ |
| 单元测试 | 69 | src/extcore/_common/ |
| theorem_prove | 11 | src/agent_kit/theorem_prove/ |

## Workspace 结构

```
DataVerse/
  moon.work              # workspace 清单
  moon.mod               # 主库 dataverse
  src/                   # 主库源码 (10 逻辑库)
  apps/
    cli/                 # CLI 工具 (cmd/main)
    bench/               # 基准测试工具
    proof/               # 证明验证工具 (20+ 断言)
    extcore/             # 语义包探索工具
    info/                # 项目信息工具
    stats/               # 统计分析工具 (5 数据集)
    demo/                # 演示工具
  tests/                  # 测试目录说明
  examples/              # 示例目录
```

## 变更记录 / Changelog

详见 [docs/changelog.md](./docs/changelog.md)。

---

## English

**DataVerse** is an AI-oriented **first-class data entity + full-domain data algorithm operator engine**. Data is promoted from "passenger in pipeline" to "first-class entity"; operators are sunk from "upper-layer scripts" to "kernel native operators"; all operators are uniformly encoded into **DataIR**, with **DOSI** symbolic-semantic index controlling AI context.

See [DataVerse-数据算子库-ARCHITECTURE.md](./DataVerse-数据算子库-ARCHITECTURE.md) for full architecture.

---

> DataVerse v0.1.0-dev | MoonBit v0.1.20261020 | 2026-11-04 | 1708 tests | 10 logical libraries