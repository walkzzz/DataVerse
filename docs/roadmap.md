# DataVerse Roadmap

> **当前阶段**：Phase 0 地基固化期  
> **日期**：2026-10-17  
> **基线**：架构 §6 Phase 0

## Phase 0｜地基固化期（0.5–1 年）

> 风险等级：✅ 低风险 | 交付性质：核心交付基线，必须完成

**目标**：算子内核、数据实体定型，算子契约与 DataIR 语法冻结

### Sprint 分解

| Sprint | 内容 | 状态 | commit | 依赖 |
|--------|------|------|--------|------|
| S0.1 | 项目骨架 + Roadmap + 根包重导出空骨架 | ✅ | 6ded33c | — |
| S0.2 | kernel 四模式执行内核（exact/approx/streaming/cache）+ 一致性验证 | ✅ | c53d213 | S0.1 |
| S0.3 | 基础数据层（DataObject/Schema/Chunk/Embedding/Record/Dataset/Lineage/QualityCard） | ✅ | d50dee2 | S0.2 |
| S0.4 | opcore 框架（统一契约 + 注册表 + 契约校验）+ 清洗/去重/过滤三类核心算子 | ⏸ | — | S0.3 |
| S0.5 | datatemporal 数据结构定型（version/lineage/drift/replay）+ 指纹机制 | ⏸ | — | S0.4 |
| S0.6 | DataIR 基础语法定义（实体 IR + 算子 IR） | ⏸ | — | S0.4 |
| S0.7 | DOSI 基础设施原型（Builder + Router 初始版本）+ 为 opcore/DataIR 生成初始索引 | ⏸ | — | S0.6 |

### Phase 0 交付物

- 可运行的基础算子库
- DataIR 基础语法
- DOSI 初始索引
- 算子接口规范文档
- 退化数据测试用例（空、超长、乱码、模态缺失）

## 后续阶段 / Later Phases

| Phase | 目标 | 风险 | 交付性质 |
|-------|------|------|----------|
| Phase 1 | 对标成熟期：14 类算子 + learncore ML + recipe 复合线 + DataIR 优化器 + DOSI 完善 | ✅ 低 | 核心基线 |
| Phase 2 | 全域算子成熟期：多模态 + 语义算子 + DL 算子 + Agent 编排 | ⚠️ 中 | 核心目标 |
| Phase 3 | 异构大规模期：分布式 + 十亿级 + 全算子可微 | 🔴 高 | 规模化增强 |
| Phase 4 | 自演化·探索数据智能期：探索引擎 + 数据/算子/配方/协同探索 | 🔴 高 | 前沿预研 |
| Phase 5 | 数据科学发现期：数据-模型因果规律挖掘 | 🔴 高 | 前沿预研 |

详见架构 §6。

## 迭代流程 / Iteration Workflow

每个 Sprint 执行步骤见 [rules.md §三](./rules.md)。

---

> DataVerse Roadmap v1.0 | 2026-10-17