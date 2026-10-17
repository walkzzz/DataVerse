# DataVerse Changelog

所有显著变更记录于此。格式参考 [Keep a Changelog](https://keepachangelog.com/)。

## [0.1.0-dev] - 2026-10-17

### S0.1 - 项目骨架 + Roadmap + 根包重导出空骨架

**新增 / Added**
- `moon.mod`：模块定义 `dataverse`
- 根包 `moon.pkg` + `dataverse.mbt`：重导出 12 个一级子包占位标识，对外入口 `@dataverse`
- 12 个一级子包骨架：`kernel` / `dataobject` / `opcore` / `datatemporal` / `recipe` / `datair` / `dosi` / `agent_kit` / `self_evolve` / `parallel` / `io` / `governance`，各含 `moon.pkg` + 占位 `<pkg>.mbt` + `README.md`
- `src/tests`：跨包测试包骨架
- `docs/roadmap.md`：Phase 0 Sprint 分解
- `docs/rules.md`：开发规则全集（适配 DataVerse）
- 根 `README.md`：中英文项目说明

**文档纠错 / Fixed**
- `rules.md` 与架构 §9 的 GeoVerse 命名残留 → DataVerse 对应（geoverse→dataverse、GeoIR→DataIR、AOCI→DOSI）
- 进度表清空 GeoVerse 历史（S0.1-S0.7 几何相关），重写为 DataVerse Phase 0 Sprint 分解

**验证 / Verified**
- `moon check`：0 error
- `moon test`：1 passed
- commit：`6ded33c`

### S0.2 - kernel 四模式执行内核框架 + 一致性契约

**新增 / Added**
- `src/kernel/kernel.mbt`：`pub(all) enum ExecMode`（Exact/Approx(Int)/Streaming/Cache）+ `pub(all) enum Consistency`（ByteExact/SeededBound/WindowEquiv/CacheHitEquiv）+ 契约函数 `mode_consistency` / `mode_name` / `mode_from_tag` / `all_mode_tags`
- `src/kernel/exact`：精确模式标识 + 退化声明 `handles_empty`
- `src/kernel/approx`：种子管理 `default_seed` / `valid_seed` + 误差界占位
- `src/kernel/streaming`：窗口抽象 `WindowConfig` / `default_window` / `sliding_window` / `valid_window`
- `src/kernel/cache`：缓存键 `CacheKey` / `make_key` / `is_hit`
- `src/tests`：12 个一致性回归测试（四模式契约 + 退化数据 + 子包聚合）

**技术发现 / Discoveries**（MoonBit 0.1.20260920）
- 同 module 子包引用：非根包需完整 module 前缀 `"dataverse/kernel/exact"`
- enum 构造器跨包构造需 `pub(all) enum`（`pub enum` 是 readonly）
- `derive(Show)` 弃用 → `derive(Debug)`；`assert_eq` 需 `Debug` trait
- `derive(Debug, Eq)` 需显式 `pub extend T with Trait::{method}` 消除 `implicit_impl_as_method` warning

**验证 / Verified**
- `moon check`：0 error 0 warning
- `moon test`：12 passed 0 failed
- commit：`c53d213`

### S0.3 - 基础数据层 8 实体结构定义

**新增 / Added**
- `src/dataobject/dataobject.mbt`：`Modality`(7) + `Lineage` + `QualityCard` + `DataObject` + 11 构造/访问函数
- `src/dataobject/schema`：`FieldType`(5) + `Field` + `Schema` + 5 函数
- `src/dataobject/chunk`：`ChunkType`(4) + `Chunk` + 4 函数
- `src/dataobject/embedding`：`Embedding` + 5 函数
- `src/dataobject/record_dataset`：`Record` + `Dataset` + 8 函数
- `src/tests`：11 个 dataobject 测试（实体构造 + 退化安全 + 元数据）

**设计决策 / Decisions**
- 依赖方向：dataobject → schema（DataObject 引用 Schema）；chunk/embedding/record_dataset 独立避免循环
- 退化安全：每个实体提供 `empty` / `zero` 构造函数
- `Lineage` 字段占位为 String，S0.5 datatemporal 填充真实算子图

**验证 / Verified**
- `moon check`：0 error 0 warning
- `moon test`：23 passed 0 failed
- commit：`d50dee2`

### S0.4 - opcore 框架 + 清洗/去重/过滤三类核心算子

**新增 / Added**
- `src/opcore/opcore.mbt`：`OperatorCategory`(14) + `Operator` 契约 + `OperatorResult` + `category_name`
- `src/opcore/registry`：`Registry` + `register` / `lookup` / `size` / `valid_operator`
- `src/opcore/clean`：`remove_empty` + `strip_whitespace` + `content_len`
- `src/opcore/dedup`：`exact_dedup`（按 content 精确去重）+ `dedup_count`
- `src/opcore/filter`：`length_filter` + `non_empty_filter` + `filter_all`
- `src/tests`：10 个 opcore 测试

**设计决策 / Decisions**
- 统一签名 `Operator(Input) -> Output + Lineage + Metrics`
- 依赖方向：opcore → dataobject + kernel；子包 → dataobject；registry → opcore（无循环）
- 算子函数式：算子是 `pub fn`，注册表存 `Operator` 契约元数据

**验证 / Verified**
- `moon check`：0 error 0 warning
- `moon test`：33 passed 0 failed
- commit：`deb2c4f`

### S0.5 - datatemporal 数据结构定型 + 指纹机制

**新增 / Added**
- `src/datatemporal/datatemporal.mbt`：`Fingerprint` + `make_fingerprint` / `empty_fingerprint` / `matches`
- `src/datatemporal/version`：`Version` + `VersionTower` + `append` / `height`
- `src/datatemporal/lineage`：`BiLineage` + `FieldLineage`
- `src/datatemporal/drift`：`DriftReport` + `is_significant`
- `src/datatemporal/replay`：`ReplayTrace` + `step_count`
- `src/tests`：5 个 datatemporal 测试

**验证 / Verified**
- `moon check`：0 error 0 warning
- `moon test`：38 passed 0 failed
- commit：`e3ace5a`

### S0.6 - DataIR 基础语法定义（实体 IR + 算子 IR）

**新增 / Added**
- `src/datair/ir_core`：`IRNodeId` + `IRMetadata`（公共基础，被 ir_entity/ir_operator 共享）
- `src/datair/ir_entity`：`EntityType` + `EntityIR`（DataObject/Chunk/Embedding/Dataset 结构与元数据投影）
- `src/datair/ir_operator`：`Determinism` + `IRModality` + `CostModel` + `OperatorIR`（原子算子节点：名称、参数、模态、确定性、代价模型）
- `src/datair/datair.mbt`：`ir_core_id` / `ir_entity_id` / `ir_operator_id` / `ir_kind_count` 聚合
- `dataverse.mbt`：重导出所有 DataIR 公共 API
- `src/tests`：10 个 datair 测试（含退化数据：空节点 id 安全处理）

**设计要点 / Design**
- IR 是源数据的中间表示，不持有源对象引用，避免循环依赖 dataobject/opcore
- IRModality 独立定义（与 dataobject.Modality 一一对应），避免循环
- 依赖方向：ir_core ← ir_entity / ir_operator；datair 根不 import 子包（与 datatemporal 一致）
- 流水线 IR（DAG）+ 优化器留 Phase 1

**验证 / Verified**
- `moon check`：0 error 0 warning
- `moon test`：48 passed 0 failed
- commit：`5f4bb15`

### S0.7 - DOSI 基础设施原型（Builder + Router + 初始索引）

**新增 / Added**
- `src/dosi/dosi.mbt`：`SymbolicEntry` + `SemanticEntry` + `DOSIEntry` + `DOSIIndex`（二元组索引规范，架构 §4.7.2）
- `src/dosi/builder`：`build_opcore_index`（5 算子初始索引）+ `build_from_operator_ir` + `merge`
- `src/dosi/router`：`lookup_by_path` / `lookup_by_category` / `lookup_by_modality` / `lookup_by_prefix`（精确查询基礎版本）
- `dataverse.mbt`：重导出所有 DOSI 公共 API
- `src/tests`：11 个 dosi 测试（含退化数据：空索引查询安全返回）

**设计要点 / Design**
- 索引条目二元组：符号层（路径/分类/模态/依赖）+ 语义层（摘要/参数/契约）
- builder 为 opcore 三类算子（clean/dedup/filter）生成 5 条初始索引
- builder 支持 DataIR OperatorIR → DOSIEntry 投影
- router 支持按路径/分类/模态/前缀精确查询
- 依赖方向：dosi 根不 import 子包；builder → dosi + ir_operator；router → dosi
- context_budget / verifier 留 Phase 1

**验证 / Verified**
- `moon check`：0 error 0 warning
- `moon test`：59 passed 0 failed
- commit：`4aa3fbf`

---

> **Phase 0 地基固化期已闭环** | S0.1-S0.7 全部完成 | 2026-10-17

---

> DataVerse Changelog | 2026-10-17