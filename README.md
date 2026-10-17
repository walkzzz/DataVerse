# DataVerse 数据算子库

> **版本**：0.1.0-dev (S0.1 骨架)  
> **日期**：2026-10-17  
> **语言**：MoonBit v0.1.20260920  
> **状态**：Phase 0 地基固化期 · S0.1 骨架已交付

**DataVerse** 是一套面向 AI 的**一等数据实体 + 全域数据算法算子引擎**。把数据从"管道里的过客"提升为"一等实体"，把算子从"上层脚本"下沉为"内核原生算子"，所有算子统一编码进 **DataIR**，配套 **DOSI** 符号语义索引管控 AI 上下文。

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
├── opcore          # 全域算子库（数据 14 类 + 模型/学习 6 类）
├── datatemporal    # 数据时空·版本·血缘
├── recipe          # 复合数据流水线
├── datair          # 全域数据中间表示
├── dosi            # 符号语义索引
├── agent_kit       # 自然语言编排
├── self_evolve     # 自演化层
├── parallel        # 并行/分布式调度
├── io              # 存储适配
├── governance      # 元数据/合规/审计
└── tests           # 跨包测试
```

## Roadmap

Phase 0 地基固化期，分 7 个 Sprint。详见 [docs/roadmap.md](./docs/roadmap.md)。

| Sprint | 内容 | 状态 |
|--------|------|------|
| S0.1 | 项目骨架 + Roadmap | ✅ |
| S0.2 | kernel 四模式执行内核 | ⏸ |
| S0.3 | 基础数据层 | ⏸ |
| S0.4 | opcore 框架 + 三类算子 | ⏸ |
| S0.5 | datatemporal 数据结构 | ⏸ |
| S0.6 | DataIR 基础语法 | ⏸ |
| S0.7 | DOSI 基础设施原型 | ⏸ |

## 开发规则 / Development Rules

详见 [docs/rules.md](./docs/rules.md)。优先级：防跑偏规则 > 项目规则 > 个人偏好。

## 构建 / Build

```bash
moon check    # 类型检查
moon test     # 运行测试
moon build    # 构建
```

## 变更记录 / Changelog

详见 [docs/changelog.md](./docs/changelog.md)。

---

## English

**DataVerse** is an AI-oriented **first-class data entity + full-domain data algorithm operator engine**. Data is promoted from "passenger in pipeline" to "first-class entity"; operators are sunk from "upper-layer scripts" to "kernel native operators"; all operators are uniformly encoded into **DataIR**, with **DOSI** symbolic-semantic index controlling AI context.

See [DataVerse-数据算子库-ARCHITECTURE.md](./DataVerse-数据算子库-ARCHITECTURE.md) for full architecture.

---

> DataVerse v0.1.0-dev | MoonBit | 2026-10-17