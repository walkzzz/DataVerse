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
| S5.4 | R16 门禁 + Phase 5 闭环 | ⏳ | — |

---

## 当前统计 / Current Stats

- **测试**：825 passed
- **API**：698 pub fn + 153 pub type
- **形式化证明**：50 个 spec 性质
- **编译**：0 error 0 warning
- **MoonBit**：moon 0.1.20260920

---

> DataVerse Roadmap | 2026-10-18 | Phase 4 启动 S4.1 闭环