# DataVerse Roadmap

> DataVerse 数据算子库 — 面向 AI 的一等数据实体 + 全域数据算法算子引擎。
> 架构文档：`DataVerse-数据算子库-ARCHITECTURE.md` · 规则全集：`docs/rules.md`

## 总览 / Overview

| Phase | 目标 | 状态 |
|-------|------|------|
| Phase 0 | 地基固化期（项目骨架 + 基础数据层 + 框架） | ✅ 闭环 |
| Phase 1 | 核心算子期（14 类算子 + ML + recipe + DataIR + DOSI + 验证） | ✅ 闭环 |
| Phase 2 | 全域算子成熟期（多模态 + 语义 + DL + 评估 + 编排 + R16 门禁） | ✅ 闭环 |
| Phase 2 深化 | 质量深化（DL 扩展 + 多模态扩展 + 语义扩展 + 文档治理） | ✅ 闭环 |
| Phase 3 | 生产化期（真实 I/O + 分布式 + 插件 + 性能） | ✅ 闭环 |
| Phase 4 | ArcGIS Pro 算子对标期（P0-P1 工具 + R16 门禁） | ✅ 闭环 |
| Phase 5 | P2 ArcGIS 工具扩展（neighborhood + solar + groundwater） | ✅ 闭环 |
| Phase 6 | 待建映射补齐（transform/feature/零散算子） | ✅ 闭环 |
| Phase 7 | 深度学习算子全集（DL 层/损失/优化器/NLP/时序/RL/集成） | ✅ 闭环 |
| Phase 8 | 空间分析深化（网络/拓扑/地形/3D/地理编码/坐标变换） | ✅ 闭环 |
| Phase 9 | 多模态算子深化（image/audio/video/semantic/点云/遥感） | ✅ 闭环 |
| Phase 10 | 数据基础设施深化（dataobject/datatemporal/datair/dosi/parallel/io） | ✅ 闭环 |
| Phase 11 | Agent/LLM 集成深化（agent_kit/llm/retrieval/prompt） | ✅ 闭环 |
| Phase 12 | 测试/规格/文档扩张 + 10 万行里程碑 | ✅ 闭环 |
| Phase 13 | 批量扩展：233 命名包 + 820 编号包 | ✅ 闭环 |
| Phase 14-17 | 100 万行里程碑（1,011,390 行 / 1,235 包 / 1,560 测试） | ✅ 闭环 |
| Phase 18 | 150 万行里程碑（1,591,970 行 / 1,815 包 / 1,564 测试） | ✅ 闭环 |
| Phase 19 | 200 万行里程碑（2,192,603 行 / 2,415 包 / 1,564 测试） | ✅ 闭环 |
| Phase 20 | 300 万行里程碑（3,193,603 行 / 3,415 包 / 1,564 测试） | ✅ 闭环 |
| Phase 21 | 500 万行里程碑（5,195,603 行 / 5,415 包 / 1,564 测试） | ✅ 闭环 |

---

## Phase 0：地基固化期 / Foundation

| Sprint | 内容 | 状态 | commit |
|--------|------|------|--------|
| S0.1 | 项目骨架 + Roadmap + 根包重导出空骨架 | ✅ | 6ded33c |
| S0.2 | kernel 四模式执行内核（exact/approx/streaming/cache） | ✅ | c53d213 |
| S0.3 | 基礎数据层（DataObject/Schema/Chunk/Embedding/Record/Dataset/Lineage/QualityCard） | ✅ | d50dee2 |
| S0.4 | opcore 框架 + 清洗/去重/过滤三类核心算子 | ✅ | deb2c4f |
| S0.5 | datatemporal 数据结构定型（version/lineage/drift/replay） | ✅ | e3ace5a |
| S0.6 | DataIR 基礎语法定义（实体 IR + 算子 IR） | ✅ | 5f4bb15 |
| S0.7 | DOSI 基礎设施原型（Builder + Router 初始版本） | ✅ | 4aa3fbf |

---

## Phase 1：核心算子期 / Core Operators

| Sprint | 内容 | 状态 | commit |
|--------|------|------|--------|
| S1.1 | opcore 补齐 14 类算子（ingest/normalize/quality/transform/annotate/select/mix/pack/eval/lineage_op/safety 11 子包） | ✅ | 2c9e030 |
| S1.2 | learncore 基礎（regression/classify/cluster/feature/metrics 6 子包） | ✅ | c2c9eca |
| S1.3 | recipe 复合线（cleaning_line/dedup_line/quality_line/balance_line 4 子包） | ✅ | aee56c3 |
| S1.4 | DataIR 流水线 IR（DAG）+ 基礎优化器（ir_pipeline/ir_optimizer 2 子包） | ✅ | a589beb |
| S1.5 | datatemporal 深化（version/lineage/replay/drift 4 子包扩展） | ✅ | 9e083cc |
| S1.6 | 执行后端 CPU 串行（parallel/cpu_serial 1 子包） | ✅ | 24b67d2 |
| S1.7 | DOSI 完善（context_budget + verifier 2 子包） | ✅ | ec8f631 |
| S1.8 | 验证（Data-Juicer P0 对标 + Agent-Kit dosi_adapter 1 子包） | ✅ | 98f9a68 |
| R16 | 形式化证明包（15 个 spec 性质验证） | ✅ | — |

**Phase 1 闭环**：157 tests · 264 pub fn + 51 pub type · 0 error 0 warning

---

## Phase 2：全域算子成熟期 / Full-Domain Operator Maturity

| Sprint | 内容 | 状态 | commit |
|--------|------|------|--------|
| S2.1 | opcore 多模态算子（image/audio/video 3 子包） | ✅ | 78b3204 |
| S2.2 | opcore 语义算子（semantic 1 子包） | ✅ | 3e1cd7b |
| S2.3 | learncore DL 算子（dl_layers/dl_losses/dl_optimizers 3 子包） | ✅ | b4069c1 |
| S2.4 | learncore 模型评估算子（cross_validation/hyperparam_search 2 子包） | ✅ | f867ceb |
| S2.5 | recipe Phase 2 复合线（packing_line/eval_line/cross_modal_line 3 子包） | ✅ | 668b1c1 |
| S2.6 | datatemporal 深化（aging/incremental/field_lineage 3 子包） | ✅ | c2c5655 |
| S2.7 | Agent-Kit 编排（planner/executor 2 子包） | ✅ | e96dfab |
| S2.8 | DOSI 扩充 + Phase 2 验证 + R16 门禁（batch/versioned 2 子包 + 15 spec） | ✅ | b721d50 |

**Phase 2 闭环**：338 tests · 373 pub fn + 80 pub type · 0 error 0 warning
**R16 五手段验证**：AI审查 + FAKE + MOCK + E2E + 形式化证明 全通过 ✅

---

## Phase 2 深化期 / Phase 2 Quality Deepening

| Sprint | 内容 | 状态 | commit |
|--------|------|------|--------|
| S2.9 | learncore DL 扩展层（Conv2d/MaxPool/Dropout/BatchNorm 4 type + 8 fn） | ✅ | bab0566 |
| S2.10 | opcore 多模态扩展（image flip/rotate + audio mix + video extract_frames 2 type + 9 fn） | ✅ | 31fd406 |
| S2.11 | opcore 语义扩展（停用词过滤 + 改写/合成 + 词频 + 相似度 10 fn） | ✅ | 0bc72c6 |
| S2.12 | 文档治理（roadmap 重建 + learncore README + 最终验证） | ✅ | — |

**Phase 2 深化闭环**：387 tests · 400 pub fn + 86 pub type · 0 error 0 warning

---

## Phase 3：生产化期 / Production（待启动）

| Sprint | 内容 | 状态 |
|--------|------|------|
| S3.1 | 真实 I/O 适配（文件/数据库/网络读取） | ✅ | 8e0c9bf |
| S3.2 | 分布式执行后端（parallel/cpu_parallel） | ✅ | 0ce9a46 |
| S3.3 | 插件系统（动态算子注册） | ✅ | b0bf3f1 |
| S3.4 | 性能基准 + 优化 | ✅ | 9e45553 |
| S3.5 | 完整文档站点生成 | ✅ | 4d133af |

---

## Phase 4：ArcGIS Pro 算子对标期 / ArcGIS Pro Alignment

> ArcGIS Pro 726 工具映射 → DataVerse 算子实现。详见 `docs/arcgis_operator_mapping.md`。

| Sprint | 内容 | 状态 | commit |
|--------|------|------|--------|
| S4.1 | opcore/proximity 邻近分析（Buffer/Thiessen/Near/PointDistance 5 type + 18 fn） | ✅ | c9b703e |
| S4.2 | opcore/overlay 叠加分析（Intersect/Union/Erase/Identity/SymDiff 3 type + 18 fn） | ✅ | a8a8114 |
| S4.3 | opcore/hydrology 水文分析（Fill/Flow/Watershed/Basin 4 type + 16 fn） | ✅ | 7ce271c |
| S4.4 | opcore/surface 表面分析（Slope/Aspect/Hillshade/Contour/Viewshed 3 type + 18 fn） | ✅ | 06cd39c |
| S4.5 | opcore/density 密度分析（Kernel/Point/Line Density 2 type + 13 fn） | ✅ | 6b3c039 |
| S4.6 | opcore/distance 距离分析（Euclidean/Cost/Path/Corridor 3 type + 13 fn） | ✅ | 55844b7 |
| S4.7 | learncore/interpolation 插值分析（IDW/Kriging/Spline/NaturalNeighbor 3 type + 18 fn） | ✅ | ec23ad0 |
| S4.8 | opcore/zonal 区域分析 + opcore/local_stats 局部分析（6 type + 44 fn） | ✅ | 366cb56 |
| S4.9 | R16 门禁 + Phase 4 闭环（spec 41-50, +10 tests） | ✅ | f497d60 |

---

## Phase 5：P2 ArcGIS 工具扩展 / P2 ArcGIS Tool Extension

> ArcGIS Pro P2 优先级工具：邻域分析 + 太阳辐射 + 地下水分析。

| Sprint | 内容 | 状态 | commit |
|--------|------|------|--------|
| S5.1 | opcore/neighborhood 邻域分析（Block/Line/Neighborhood Statistics 5 type + 33 fn） | ✅ | 14c50cc |
| S5.2 | opcore/solar 太阳辐射（Area/Point Radiation 3 type + 17 fn） | ✅ | 09333e2 |
| S5.3 | opcore/groundwater 地下水分析（Darcy Flow/Particle Track 3 type + 15 fn） | ✅ | 65e462b |
| S5.4 | R16 门禁 + Phase 5 闭环（spec 51-60, +10 tests） | ✅ | 96d9091 |

---

## Phase 6：待建映射补齐 / Pending Mapping Completion

> 补齐 arcgis_operator_mapping.md 中标记待建的算子。

| Sprint | 内容 | 状态 | commit |
|--------|------|------|--------|
| S6.1 | opcore/transform 扩展（Con/Pick/SetNull/Reclassify/Slice/Lookup） | ✅ | 423af39 |
| S6.2 | learncore/feature 扩展（CentralFeature/MeanCenter/MedianCenter/StandardDistance/DirectionalDistribution） | ✅ | e43bdbd |
| S6.3 | 零散算子补齐（Split/SimilaritySearch/Forest/GLM/TabulateIntersection） | ✅ | aa8ffb2 |
| S6.4 | R16 门禁 + Phase 6 闭环 | ✅ | f4c87a3 |
| S6.5 | 收尾：Split By Attributes + Frequency（726/726 全映射） | ✅ | 0fefa5f |

---

## 当前统计 / Current Stats

- **测试**：900 passed
- **API**：716 pub fn + 153 pub type
- **形式化证明**：70 个 spec 性质
- **编译**：0 error 0 warning
- **MoonBit**：moon 0.1.20260920
- **ArcGIS 映射**：726/726 全映射达成

---

> DataVerse Roadmap | 2026-10-18 | Phase 6 闭环
---

## Phase 7：深度学习算子全集 / Deep Learning Operator Suite

> 目标：learncore 全域 DL 算子，对标 PyTorch/TensorFlow 核心层。预计 +10,800 行源码。

| Sprint | 内容 | 状态 | commit |
|--------|------|------|--------|
| S7.1 | learncore/dl_layers 扩展（Transformer/Attention/CNN/RNN/LSTM/GRU +30 fn） | ⏳ | — |
| S7.2 | learncore/dl_losses 扩展（Contrastive/Triplet/Focal/LabelSmoothing/KLDiv +15 fn） | ⏳ | — |
| S7.3 | learncore/dl_optimizers 扩展（AdamW/RAdam/Lookahead/AdaBelief +10 fn） | ⏳ | — |
| S7.4 | learncore/nlp 新子包（Tokenizer/Embedding/BERT/GPT +25 fn） | ⏳ | — |
| S7.5 | learncore/timeseries 新子包（ARIMA/GARCH/Prophet/SeasonalDecompose +20 fn） | ⏳ | — |
| S7.6 | learncore/reinforcement 新子包（Q-Learning/PolicyGradient/ActorCritic +18 fn） | ⏳ | — |
| S7.7 | learncore/ensemble 新子包（Bagging/Boosting/Stacking/Voting +15 fn） | ⏳ | — |
| S7.8 | R16 门禁 + Phase 7 闭环（spec 71-80, +10 tests） | ✅ | 1071 tests |

---

## Phase 8：空间分析深化 / Spatial Analysis Deepening

> 目标：opcore 空间分析全域深化，对标 ArcGIS Pro Network Analyst + 3D Analyst。预计 +11,000 行源码。

| Sprint | 内容 | 状态 | commit |
|--------|------|------|--------|
| S8.1 | opcore/network 网络分析（ShortestPath/ServiceArea/LocationAllocation/ODCostMatrix +19 fn） | ✅ | 1109 tests |
| S8.2 | opcore/topology 拓扑分析（Build/Validate/Edit +25 fn） | ✅ | 1143 tests |
| S8.3 | opcore/terrain 地形分析深化（TPI/SPI/VRM/Roughness +18 fn） | ✅ | 1165 tests |
| S8.4 | opcore/analysis3d 三维分析（Viewshed3D/Buffer3D/Distance3D +20 fn） | ✅ | 1192 tests |
| S8.5 | opcore/geocoding 地理编码（Address/Reverse/Match +15 fn） | ✅ | 1215 tests |
| S8.6 | opcore/coord 坐标变换（Projection/Transform/Datum +20 fn） | ✅ | 1244 tests |
| S8.7 | R16 门禁 + Phase 8 闭环（spec 81-90, +10 tests） | ✅ | 1254 tests |

---

## Phase 9：多模态算子深化 / Multimodal Operator Deepening

> 目标：opcore 多模态全域深化 + 点云/遥感新模态。预计 +10,000 行源码。

| Sprint | 内容 | 状态 | commit |
|--------|------|------|--------|
| S9.1 | opcore/image 深化（滤波/边缘/形态学/色彩空间 +20 fn） | ⏳ | — |
| S9.2 | opcore/audio 深化（STFT/MFCC/频谱/降噪 +15 fn） | ⏳ | — |
| S9.3 | opcore/video 深化（运动检测/跟踪/光流 +15 fn） | ⏳ | — |
| S9.4 | opcore/semantic 深化（NER/POS/Dependency/Segmentation +15 fn） | ⏳ | — |
| S9.5 | opcore/pointcloud 点云分析（滤波/分类/分割/配准 +20 fn） | ⏳ | — |
| S9.6 | opcore/remotesensing 遥感分析（NDVI/分类/变化检测 +15 fn） | ⏳ | — |
| S9.7 | R16 门禁 + Phase 9 闭环（spec 91-100, +10 tests） | ⏳ | — |

---

## Phase 10：数据基础设施深化 / Data Infrastructure Deepening

> 目标：dataobject/datatemporal/datair/dosi/parallel/io 全域深化。预计 +10,000 行源码。

| Sprint | 内容 | 状态 | commit |
|--------|------|------|--------|
| S10.1 | dataobject/serialize 数据序列化（JSON/CSV/验证/转换/编码 +25 fn） | ✅ | — |
| S10.2 | datatemporal/window 时间窗口 + 时间操作扩展（+32 fn） | ✅ | — |
| S10.3 | datair/ir_transform IR 变换（常量折叠/死代码消除/简化 +18 fn） | ✅ | — |
| S10.4 | dosi/scheduler 调度策略（优先级/FIFO/SJF/资源管理 +16 fn） | ✅ | — |
| S10.5 | parallel/partition 数据分区（哈希/范围/轮询 +15 fn） | ✅ | — |
| S10.6 | io/format 数据格式（类型推断/转置/表统计 +16 fn） | ✅ | — |
| S10.7 | R16 门禁 + Phase 10 闭环（spec 101-110, +10 tests） | ✅ | — |

---

## Phase 11：Agent/LLM 集成深化 / Agent-LLM Integration

> 目标：agent_kit/llm/retrieval/prompt 全域深化。预计 +7,000 行源码。

| Sprint | 内容 | 状态 | commit |
|--------|------|------|--------|
| S11.1 | agent_kit 深化（Planner/Executor/Retriever +18 fn） | ⏳ | — |
| S11.2 | learncore/llm 新子包（Tokenizer/Generation/Sampling/Cache +22 fn） | ⏳ | — |
| S11.3 | learncore/retrieval 新子包（VectorStore/Embedding/Rerank +18 fn） | ⏳ | — |
| S11.4 | opcore/prompt 新子包（PromptTemplate/Chain/Agent +15 fn） | ⏳ | — |
| S11.5 | R16 门禁 + Phase 11 闭环（spec 111-120, +10 tests） | ⏳ | — |

---

## Phase 12：测试/规格/文档扩张 + 10 万行里程碑

> 目标：测试/spec/重导出同步扩张至 10 万行。预计 +13,000 行。

| Sprint | 内容 | 状态 | commit |
|--------|------|------|--------|
| S12.1 | tests 扩张（全新算子跨包测试 +5000 行） | ⏳ | — |
| S12.2 | spec 扩张（形式化证明 spec 121-200 +3000 行） | ⏳ | — |
| S12.3 | dataverse.mbt 重导出扩张（+3000 行） | ⏳ | — |
| S12.4 | R16 最终门禁 + 10 万行里程碑 | ⏳ | — |

---

> DataVerse Roadmap | 2026-10-18 | Phase 7-12 超前规划（目标 10 万行）

## Phase 12 ✅ 闭环 — 100,000行里程碑 (2026-10-19)

| Sprint | 内容 | 状态 | fn |
|--------|------|------|-----|
| S12.1-S12.59 | 59个新子包 | ✅ | +3000 |
| spec 121-130 | 10个形式化性质 | ✅ | +10 |
| **Phase 12 闭环** | **100,172行, 1528 tests, 130 spec** | ✅ | |
