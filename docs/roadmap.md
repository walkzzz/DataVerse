# DataVerse Roadmap

> **当前阶段**：Phase 2 全域算子成熟期  
> **日期**：2026-10-17  
> **基线**：架构 §6 Phase 2

## Phase 0｜地基固化期（0.5–1 年）✅ 已闭环

> 风险等级：✅ 低风险 | 交付性质：核心交付基线，必须完成

**目标**：算子内核、数据实体定型，算子契约与 DataIR 语法冻结

### Sprint 分解

| Sprint | 内容 | 状态 | commit | 依赖 |
|--------|------|------|--------|------|
| S0.1 | 项目骨架 + Roadmap + 根包重导出空骨架 | ✅ | 6ded33c | — |
| S0.2 | kernel 四模式执行内核（exact/approx/streaming/cache）+ 一致性验证 | ✅ | c53d213 | S0.1 |
| S0.3 | 基础数据层（DataObject/Schema/Chunk/Embedding/Record/Dataset/Lineage/QualityCard） | ✅ | d50dee2 | S0.2 |
| S0.4 | opcore 框架（统一契约 + 注册表 + 契约校验）+ 清洗/去重/过滤三类核心算子 | ✅ | deb2c4f | S0.3 |
| S0.5 | datatemporal 数据结构定型（version/lineage/drift/replay）+ 指纹机制 | ✅ | e3ace5a | S0.4 |
| S0.6 | DataIR 基础语法定义（实体 IR + 算子 IR） | ✅ | 5f4bb15 | S0.4 |
| S0.7 | DOSI 基础设施原型（Builder + Router 初始版本）+ 为 opcore/DataIR 生成初始索引 | ✅ | 4aa3fbf | S0.6 |

### Phase 0 交付物

- 可运行的基础算子库 · DataIR 基础语法 · DOSI 初始索引 · 算子接口规范文档 · 退化数据测试用例

## Phase 1｜对标成熟期（1–2 年）

> 风险等级：✅ 低风险 | 交付性质：核心交付基线，必须完成

**目标**：算子体系可用，洗净线/去重线/质量线可跑，可对标 Data-Juicer 能力

### Sprint 分解

| Sprint | 内容 | 状态 | commit | 依赖 |
|--------|------|------|--------|------|
| S1.1 | opcore 补齐 14 类算子（Ingest/Normalize/Quality/Transform/Annotate/Select/Mix/Pack/Eval/Lineage/Safety 11 类） | ✅ | 2c9e030 | S0.4 |
| S1.2 | learncore 基礎（传统 ML 算子：回归/分类/聚类/降维 + 评估指标算子） | ✅ | c2c9eca | S1.1 |
| S1.3 | recipe 复合线（cleaning_line / dedup_line / quality_line / balance_line） | ✅ | aee56c3 | S1.1 |
| S1.4 | DataIR 流水线 IR（DAG）+ 基础优化器（融合、重排） | ✅ | a589beb | S0.6 |
| S1.5 | datatemporal 深化（版本塔/双向血缘/回放完善） | ✅ | 9e083cc | S0.5 |
| S1.6 | 执行后端 CPU 串行 | ✅ | 24b67d2 | S1.1 |
| S1.7 | DOSI 完善（增量索引 + 依赖校验 + ContextBudget） | ✅ | ec8f631 | S0.7 |
| S1.8 | 验证（Data-Juicer 比对 + Agent-Kit 接入 DOSI） | ✅ | 98f9a68 | S1.3 |

### Phase 1 交付物

- 可试用算子库 + 复合流水线 · 可对标 Data-Juicer · 可产出训练就绪数据集

## Phase 2｜全域算子成熟期（2–4 年）

> 风险等级：⚠️ 中等风险 | 交付性质：核心目标，渐进式开发

**目标**：多模态算子齐备，语义算子（评分/变换/合成）成熟，Agent 编排可用

> **实现策略**：MoonBit 无真实 DL/GPU/LLM 解码能力，采用**契约定义 + 元数据驱动 + 模拟实现 + 退化验证**策略（架构 §10"Phase 2 渐进开发，每算子做真值比对"）。

### Sprint 分解

| Sprint | 内容 | 状态 | commit | 依赖 |
|--------|------|------|--------|------|
| S2.1 | opcore 多模态算子（image/audio/video 元数据算子：size/aspect_ratio/duration/sample_rate/resize/crop/segment） | ✅ | 78b3204 | S1.1 |
| S2.2 | opcore 语义算子（质量评分/改写/合成契约 + 模拟实现 + 退化验证） | ✅ | 3e1cd7b | S1.1 |
| S2.3 | learncore DL 算子（网络层/架构族/损失/优化器契约 + 前向传播模拟） | ✅ | b4069c1 | S1.2 |
| S2.4 | learncore 模型评估算子（交叉验证 k-fold / 超参搜索网格） | ⏳ | — | S2.3 |
| S2.5 | recipe Phase 2 复合线（packing_line / eval_line / 跨模态一致性线） | ⏳ | — | S2.1, S1.3 |
| S2.6 | datatemporal 深化（漂移检测增强 / 数据衰老 / 增量更新 / 字段级血缘） | ⏳ | — | S1.5 |
| S2.7 | Agent-Kit 编排（NL→DataIR Planner-Executor 契约 + 模拟） | ⏳ | — | S1.8, S1.4 |
| S2.8 | DOSI 扩充（批量索引 / 多版本索引）+ Phase 2 验证 + R16 门禁 | ⏳ | — | S2.1-S2.7 |

### Phase 2 交付物

- 多模态算子齐备 · 语义算子契约成熟 · DL 算子契约 + 前向模拟 · Agent 编排可用 · 跨模态一致性流水线
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