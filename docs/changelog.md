# DataVerse Changelog

所有显著变更记录于此。格式参考 [Keep a Changelog](https://keepachangelog.com/)。

## [0.1.0-dev] - 2026-10-18

### S4.4 - opcore/surface 表面分析

**新增 / Added**
- `src/opcore/surface/`：表面分析算子包（3 type + 18 fn）
  - 类型：`AspectDirection` / `ContourLine` / `SurfaceResult`
  - 算子：`surface_slope`（Horn's method）/ `surface_aspect` / `surface_hillshade` / `surface_contour` / `surface_curvature` / `surface_viewshed` / `surface_stats` 等
  - 对标 ArcGIS Pro: Slope / Aspect / Hillshade / Contour / Curvature / Viewshed
- 27 个跨包测试（S4.4 系列）

**统计 / Stats**
- 测试：549 → 576（+27）
- API：527 fn + 125 type → 545 fn + 128 type（+18 fn + 3 type）

### S4.3 - opcore/hydrology 水文分析

**新增 / Added**
- `src/opcore/hydrology/`：水文分析算子包（4 type + 16 fn）
  - 类型：`RasterGrid` / `FlowDirResult` / `FlowAccumResult` / `HydrologyResult`
  - 算子：`hydrology_find_sinks` / `hydrology_fill` / `hydrology_flow_direction`（D8）/ `hydrology_flow_accumulation` / `hydrology_watershed`（BFS）/ `hydrology_basin` / `hydrology_stream_cells` / `hydrology_stream_order` / `hydrology_flow_length` / `hydrology_stats` / `hydrology_snap_pour` 等
  - 对标 ArcGIS Pro: Fill / Flow Direction / Flow Accumulation / Watershed / Basin / Stream Order / Flow Length / Snap Pour Point
- 20 个跨包测试（S4.3 系列）

**统计 / Stats**
- 测试：529 → 549（+20）
- API：511 fn + 121 type → 527 fn + 125 type（+16 fn + 4 type）

### S4.2 - opcore/overlay 叠加分析

**新增 / Added**
- `src/opcore/overlay/`：叠加分析算子包（3 type + 18 fn）
  - 类型：`Polygon` / `OverlayKind` / `OverlayResult`
  - 算子：`polygon_area`（鞋带公式）/ `polygon_perimeter` / `bbox_overlap` / `bbox_contains` / `overlay_intersect` / `overlay_union` / `overlay_erase` / `overlay_identity` / `overlay_sym_diff` / `overlay_update` / `overlay_spatial_join` / `batch_intersections` 等
  - 对标 ArcGIS Pro: Intersect / Union / Erase / Identity / Symmetrical Difference / Spatial Join / Update
- 26 个跨包测试（S4.2 系列）

**统计 / Stats**
- 测试：503 → 529（+26）
- API：493 fn + 118 type → 511 fn + 121 type（+18 fn + 3 type）

### S4.1 - opcore/proximity 邻近分析

**新增 / Added**
- `src/opcore/proximity/`：邻近分析算子包（5 type + 18 fn）
  - 类型：`Point` / `GeometryKind` / `BufferResult` / `ProximityPair` / `NearResult`
  - 算子：`euclidean_distance` / `manhattan_distance` / `buffer_point` / `multi_ring_buffer` / `nearest_point` / `near_table` / `point_distance_matrix` / `thiessen_polygons` / `polygon_neighbors` / `bounding_box` / `points_from_dataobject` / `buffer_stats` 等
  - 对标 ArcGIS Pro: Buffer / Multiple Ring Buffer / Thiessen Polygons / Near / Point Distance / Polygon Neighbors
- 32 个跨包测试（S4.1 系列）
- `docs/arcgis_operator_mapping.md`：ArcGIS Pro 726 工具 → DataVerse 映射文档

**统计 / Stats**
- 测试：471 → 503（+32）
- API：475 fn + 113 type → 493 fn + 118 type（+18 fn + 5 type）

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

### 架构补充 - Agent-Kit 工程技能工作流（mattpocock/skills 范式嵌入）

**变更 / Changed**
- `ARCHITECTURE.md` §4.8.1 新增：Agent-Kit 工程技能工作流（吸收 mattpocock/skills 范式）
  - grill-me 架构拷问工作流：自动质询设计漏洞、边界条件、依赖风险
  - wayfinder 项目导航工作流：对接 DOSI，按需加载文档控制 Token
  - to-spec 规格转换工作流：自然语言 → DataIR 算子规格
  - docs 文档一致性工作流：校验 ARCHITECTURE/Roadmap/changelog 一致性
  - changeset 变更追踪工作流：变更影响反查 + 回归测试清单
- §4.8 章节重新编号：4.8.1（新增）→ 4.8.2 自省类 → 4.8.3 探索类 → 4.8.4 工业课题库
- §10 映射表新增"Agent 工程技能"行

**设计要点 / Design**
- 不直接引入 mattpocock/skills 代码，吸收工程范式适配 DataVerse 数据算子领域
- 领域规则注入：算子统一签名、kernel 四模式、退化数据、datatemporal 时空谓词
- 与 DOSI/DataIR/datatemporal 深度绑定：wayfinder↔DOSI、to-spec↔DataIR、changeset↔血缘
- 与自演化层协同：grill-me 风险清单 → 自省类调优；wayfinder 召回 → 探索类配方搜索

### 架构补充 - Data-Juicer 对标映射 + R16 阶段门禁自动化 + Phase 1 Sprint 分解

**变更 / Changed**
- `docs/datajuicer_operators.md` 新增：Data-Juicer v1.5.0 全部 192 算子清单（8 大类）+ 14 类↔8 大类映射 + 对标优先级
- `ARCHITECTURE.md` §4.3.6 新增：Data-Juicer 对标映射（14 类 ↔ 8 大类映射表 + P0-P3 优先级 + 命名规范）
- `ARCHITECTURE.md` §10 映射表新增"对标基准"行
- `docs/rules.md` R16 新增：阶段门禁自动化（AI+FAKE+MOCK+E2E+形式化证明，通过则自动进入下一阶段）
- `docs/roadmap.md` Phase 1 Sprint 分解（S1.1-S1.8）+ 当前阶段切换到 Phase 1

**设计要点 / Design**
- DataVerse 14 类算子是 DJ 8 大类的超集（独有 Lineage/Safety/Pack）
- P0 高频对标 5 算子：text_length_filter, exact_deduplicator, whitespace_normalization_mapper, clean_html_mapper, topk_selector
- DJ 命名规范：`<功能>_<类型>`，DataVerse 同名实现保持下划线命名便于 recipe 互导

### S1.1 - opcore 补齐 14 类算子

**新增 / Added**
- 11 个算子子包（`src/opcore/` 下），对标 Data-Juicer P0 高频算子：
  - `ingest/`：text_formatter + json_formatter + csv_formatter
  - `normalize/`：whitespace_normalization + punctuation_normalization
  - `quality/`：length_quality_score + text_quality_score
  - `transform/`：to_lowercase + to_uppercase + truncate
  - `annotate/`：tag_by_length + tag_modality
  - `select/`：topk_by_length + threshold_by_length
  - `mix/`：group_by_modality + interleave
  - `pack/`：text_chunk
  - `eval/`：global_statistics + GlobalStats struct
  - `lineage_op/`：attach_lineage + make_op_lineage（DataVerse 独有，DJ 无直接对应）
  - `safety/`：mask_digits + mask_email
- 27 个新测试（每类算子正常用例 + 退化数据用例：空串/空数组/越界参数）

**变更 / Changed**
- 根 `moon.pkg` + `src/tests/moon.pkg`：加 11 个 opcore 子包 import
- `dataverse.mbt`：加 11 个子包 pub using 重导出 + version 改为 `S1.1 opcore 14 ops`

**统计 / Stats**
- 测试：59 → 86（+27）
- API：155 → 189 pub fn（+34），39 → 40 pub type（+1 GlobalStats）
- `moon check`：0 error 0 warning · `moon test`：86 passed

### S1.2 - learncore 基礎（传统 ML 算子）

**新增 / Added**
- 6 个子包（`src/learncore/` 下），对标架构 §4.3.5 A（传统 ML）+ D（评估指标）：
  - `learncore/` 根：ModelSpace enum（ML/DL/SSL/Eval/Adapt/Optim）+ Hyperparams
  - `regression/`：linear_regression（OLS 闭式解）+ LinearModel + predict_linear
  - `classify/`：knn_classify（欧氏距离 + 多数投票）
  - `cluster/`：kmeans（Lloyd 迭代）
  - `feature/`：standardize（Z-score）+ normalize_minmax
  - `metrics/`：accuracy + mse + mae + confusion_matrix
- 14 个新测试（每类算子正常用例 + 退化数据用例）

**修复 / Fixed**
- `Array::make(n, Array::make(n, 0))` 浅拷贝陷阱：内层 Array 共享同一引用 → 改用循环逐行创建

**统计 / Stats**
- 测试：86 → 100（+14）
- API：189 → 207 pub fn（+18），40 → 43 pub type（+3 ModelSpace/LinearModel/Hyperparams）
- `moon check`：0 error 0 warning · `moon test`：100 passed

### S1.3 - recipe 复合线

**新增 / Added**
- 4 个子包（`src/recipe/` 下），编排已有原子算子为复合流水线：
  - `cleaning_line/`：remove_empty → strip_whitespace → whitespace_normalization
  - `dedup_line/`：exact_dedup
  - `quality_line/`：length_quality_score 过滤 + topk_by_length 选择
  - `balance_line/`：group_by_modality + 每组 topk_by_length
- 8 个新测试（每条线正常用例 + 退化数据用例）

**统计 / Stats**
- 测试：100 → 108（+8）
- API：207 → 215 pub fn（+8）
- `moon check`：0 error 0 warning · `moon test`：108 passed

### S1.4 - DataIR 流水线 IR（DAG）+ 基礎优化器

**新增 / Added**
- 2 个子包（`src/datair/` 下）：
  - `ir_pipeline/`：PipelineIR（DAG）+ DAGEdge + 拓扑排序（Kahn 算法，环检测退化安全）
  - `ir_optimizer/`：fuse_adjacent_maps（同名 map 融合）+ remove_identity（恒等消除）+ optimize + OptStats
- 6 个新测试（DAG 构造 + 拓扑排序 + 优化器 + 退化：空/有环）

**统计 / Stats**
- 测试：108 → 114（+6）
- API：215 → 229 pub fn（+14），43 → 46 pub type（+3 DAGEdge/PipelineIR/OptStats）
- `moon check`：0 error 0 warning · `moon test`：114 passed

### S1.5 - datatemporal 深化

**新增 / Added**
- 扩展 4 个子包（`src/datatemporal/` 下）：
  - `version/`：latest + get_by_id + ancestors（祖先链追溯）
  - `lineage/`：reverse（反转双向血缘）+ compose（血缘组合）+ input/output_count
  - `replay/`：append_step + replay + trace_summary
  - `drift/`：drift_direction（up/down/stable）+ merge_reports（合并多报告）
- 9 个新测试（含退化：空塔/空轨迹/空合并）

**修复 / Fixed**
- `guard` 是 MoonBit 保留字 → 改用 `counter`

**统计 / Stats**
- 测试：114 → 123（+9）
- API：229 → 241 pub fn（+12）
- `moon check`：0 error 0 warning · `moon test`：123 passed

### S1.6 - 执行后端 CPU 串行

**新增 / Added**
- `parallel/cpu_serial` 子包：
  - `ExecutionPlan`：拓扑排序后的算子执行计划
  - `ExecutionResult`：输出指纹 + 执行轨迹 + 步数 + 成功标志
  - `make_plan`：从 PipelineIR 生成执行计划（拓扑排序）
  - `execute`：串行执行 + 轨迹记录
  - `merge_results` + `empty_plan` + `plan_step_count`
- 4 个新测试（含退化：空计划/有环流水线）

**统计 / Stats**
- 测试：123 → 127（+4）
- API：241 → 247 pub fn（+6），46 → 48 pub type（+2 ExecutionPlan/ExecutionResult）
- `moon check`：0 error 0 warning · `moon test`：127 passed

### S1.7 - DOSI 完善

**新增 / Added**
- 2 个子包（`src/dosi/` 下）：
  - `context_budget/`：ContextBudget + make_budget（配额分区）+ allocate + is_over_budget + remaining + usage_ratio + compress（超预算降级）
  - `verifier/`：VerifyResult + verify_index（依赖存在性 + 自依赖检测）+ check_dependencies + detect_cycles
- 7 个新测试（含退化：零配额/空索引）

**统计 / Stats**
- 测试：127 → 134（+7）
- API：247 → 260 pub fn（+13），48 → 50 pub type（+2 ContextBudget/VerifyResult）
- `moon check`：0 error 0 warning · `moon test`：134 passed

### S1.8 - 验证（Data-Juicer P0 对标 + Agent-Kit 接入 DOSI）

**新增 / Added**
- `agent_kit/dosi_adapter` 子包：
  - `QueryResult` + `query_dosi`（自然语言关键词 → DOSI 检索）+ `plan_pipeline`（多关键词 → 算子路径列表）
- 8 个新测试：
  - Data-Juicer P0 对标验证（5 算子：text_length_filter / exact_deduplicator / whitespace_normalization_mapper / topk_selector / punctuation_normalization_mapper）
  - dosi_adapter 查询 + 规划 + 退化

**统计 / Stats**
- 测试：134 → 142（+8）
- API：260 → 264 pub fn（+4），50 → 51 pub type（+1 QueryResult）
- `moon check`：0 error 0 warning · `moon test`：142 passed

---

## Phase 1 闭环总结 / Phase 1 Closure

| Sprint | 内容 | commit | 测试增量 |
|--------|------|--------|----------|
| S1.1 | opcore 14 类算子 | 2c9e030 | +27 |
| S1.2 | learncore 传统 ML | c2c9eca | +14 |
| S1.3 | recipe 4 条复合线 | aee56c3 | +8 |
| S1.4 | DataIR DAG + 优化器 | a589beb | +6 |
| S1.5 | datatemporal 深化 | 9e083cc | +9 |
| S1.6 | 执行后端 CPU 串行 | 24b67d2 | +4 |
| S1.7 | DOSI 完善 | ec8f631 | +7 |
| S1.8 | 验证（DJ 对标 + Agent-Kit） | 98f9a68 | +8 |

**Phase 1 总计**：测试 59→142（+83），API 155→264 pub fn + 51 pub type，0 error 0 warning。

### R16 门禁：形式化证明包

**新增 / Added**
- `src/spec/` 包：15 个形式化性质验证（proof-carrying 风格）
  - 幂等性：whitespace_normalization / exact_dedup / mask_digits / to_lowercase
  - 不变量：topk_by_length 长度+有序 / standardize 零均值 / normalize_minmax [0,1] / accuracy [0,1] / mse 非负
  - 收敛性：kmeans 确定性收敛
  - 拓扑合法性：topo_order 边顺序
  - 单调性：optimize 节点数递减
  - 精确性：linear_regression 完美拟合

**R16 五手段验证结果**：全部通过 ✅
1. AI 辅助审查 ✅ 2. FAKE 退化数据 ✅ 3. MOCK 纯函数 ✅ 4. E2E 跨包 ✅ 5. 形式化证明 ✅

**统计 / Stats**
- 测试：142 → 157（+15）
- `moon check`：0 error 0 warning · `moon test`：157 passed

---

### S2.9 - learncore DL 扩展层（Conv2d + MaxPool + Dropout + BatchNorm）

**新增 / Added**
- `src/learncore/dl_layers/dl_layers.mbt` 追加：
  - `pub(all) struct Conv2dMeta`（in_channels/out_channels/kernel_size/stride/padding）+ `make_conv2d` + `conv2d_output_dim`
  - `pub(all) struct MaxPoolMeta`（kernel_size/stride/padding）+ `make_maxpool` + `maxpool_output_dim`
  - `pub(all) enum DropoutMode`（Training/Inference）+ `dropout_forward` + `dropout_mode_name`
  - `pub(all) struct BatchNormMeta`（gamma/beta/running_mean/running_var/eps）+ `make_batchnorm` + `batchnorm_forward`
- `dataverse.mbt`：重导出 4 type + 8 fn，version → "S2.9 DL extension layers"

**测试 / Tests**
- +14：Conv2d 输出维度/前向传播，MaxPool 输出维度/前向传播，Dropout 训练/推理模式，BatchNorm 训练/推理/数值稳定性
- 总计：338 → 352 passed

**统计 / Stats**
- API：373→381 pub fn + 80→84 pub type
- `moon check`：0 error 0 warning · `moon test`：352 passed
- commit：`bab0566`

### S2.10 - opcore 多模态扩展（image flip/rotate + audio mix + video extract_frames）

**新增 / Added**
- `src/opcore/image/image.mbt` 追加：
  - `pub(all) enum FlipAxis`（Horizontal/Vertical/Both）+ `pub(all) enum RotateAngle`（D90/D180/D270）
  - `image_flip` + `image_rotate`（D90/D270 交换 w/h）+ `flip_axis_name` + `rotate_angle_name`
- `src/opcore/audio/audio.mbt` 追加：
  - `audio_mix`（混合两路音频，duration=max, sr=a, channels=max）+ `audio_normalize_duration`
- `src/opcore/video/video.mbt` 追加：
  - `video_extract_frames`（均匀抽帧为 ImageMeta 数组）+ `video_frame_timestamps` + `video_trim`
- `src/opcore/video/moon.pkg`：新增 import `dataverse/opcore/image`
- `dataverse.mbt`：重导出 2 type + 9 fn，version → "S2.10 multimodal extension"

**测试 / Tests**
- +19：flip 保维度，rotate D90/D270 交换 w/h，audio_mix 取 max duration，video_extract_frames 均匀抽帧，video_trim 裁剪
- 总计：352 → 371 passed

**统计 / Stats**
- API：381→390 pub fn + 84→86 pub type
- `moon check`：0 error 0 warning · `moon test`：371 passed
- commit：`31fd406`

### S2.11 - opcore 语义扩展（停用词过滤 + 改写/合成 + 词频 + 相似度）

**新增 / Added**
- `src/opcore/semantic/semantic.mbt` 追加 10 fn：
  - 停用词：`default_stopwords`（57 词）+ `remove_stopwords` + `remove_stopwords_custom`
  - 改写：`rewrite_trim` + `rewrite_lowercase` + `rewrite_uppercase`
  - 合成：`synthesize_concat` + `synthesize_template`（`{}` 占位符替换）
  - 分析：`word_frequency`（词频降序）+ `text_similarity`（Jaccard 词集相似度）
- 辅助函数：`split_words` + `is_stopword` + `join_strings` + `replace_all`（手动实现）
- `dataverse.mbt`：重导出 10 fn，version → "S2.11 semantic extension"

**测试 / Tests**
- +16：停用词过滤，trim/lower/upper，concat/template，词频降序，Jaccard 1.0/0.0/0.5
- 总计：371 → 387 passed

**统计 / Stats**
- API：390→400 pub fn + 86 pub type
- `moon check`：0 error 0 warning · `moon test`：387 passed
- commit：`0bc72c6`

### S2.12 - 文档治理（roadmap 重建 + learncore README + 最终验证）

**新增 / Added**
- `docs/roadmap.md`：完整重建（Phase 0-2 + 深化期 + Phase 3 待启动 + 当前统计）
- `src/learncore/README.md`：learncore 子包说明（10 子包 + 公共 API + 设计说明）
- `dataverse.mbt`：version → "S2.12 Phase 2 deepening complete"

**验证 / Verified**
- `moon check`：0 error 0 warning · `moon test`：387 passed
- Phase 2 深化期闭环：S2.9 + S2.10 + S2.11 + S2.12 全部通过

### S3.1 - io 数据源/汇适配（source/sink 契约 + 内存模拟）

**新增 / Added**
- `src/io/source/`：DataSourceType + SourceConfig + SourceMeta + read_source + source_uri + 3 constructors = 3 type + 9 fn
- `src/io/sink/`：DataSinkType + SinkConfig + WriteResult + SinkStats + write_sink + execute_write + sink_uri + 3 constructors = 4 type + 11 fn
- 策略：契约 + 内存模拟（不引入平台 FFI）

**测试 / Tests**
- +18：source URI/read，sink URI/write/execute，degenerate safety
- 总计：387 → 405 passed

**统计 / Stats**
- API：400→420 pub fn + 86→93 pub type
- `moon check`：0 error 0 warning · `moon test`：405 passed
- commit：`8e0c9bf`

### S3.2 - parallel/cpu_parallel 分布式执行后端

**新增 / Added**
- `src/parallel/cpu_parallel/`：7 type + 12 fn
  - PartitionStrategy(ByCount/BySize/ByKeyHash) + PartitionConfig + partition_data
  - ShuffleType(Hash/Range/Random) + ShuffleConfig + shuffle_data
  - GatherMode(Concat/MergeSorted/Union) + gather_results
  - ParallelExecPlan + ParallelStats + make_parallel_plan + compute_parallel_stats + parallel_plan_uri
- 策略：契约 + 内存模拟

**测试 / Tests**
- +16：分区 ByCount/ByKeyHash，shuffle，gather，stats，plan URI，degenerate
- 总计：405 → 421 passed

**统计 / Stats**
- API：420→432 pub fn + 93→100 pub type
- commit：`0ce9a46`

### S3.3 - opcore/plugin 插件系统

**新增 / Added**
- `src/opcore/plugin/`：5 type + 17 fn
  - PluginStatus(Loaded/Active/Disabled/Error) + PluginMeta + PluginDependency + PluginEntry + PluginRegistry
  - register/unregister + enable/disable + list + plugins_by_status + check_dependency + check_all_dependencies
- 测试: +16
- 总计: 421 → 437 passed
- API: 432→449 pub fn + 100→105 pub type
- commit: `b0bf3f1`

### S3.4 - 性能基准 + 算子融合优化

**新增 / Added**
- `src/governance/benchmark/`：4 type + 9 fn (BenchmarkConfig + BenchmarkResult + BenchmarkSuite + SuiteStats + run_benchmark + compute_suite_stats)
- `src/datair/ir_fusion/`：2 type + 7 fn (FusionRule + FusionResult + apply_fusion + iterative_fusion + fusion_reduction_ratio)
- 测试: +15
- 总计: 437 → 452 passed
- API: 449→465 pub fn + 105→111 pub type
- commit: `9e45553`

### S3.5 - 文档站点生成 + Phase 3 闭环

**新增 / Added**
- `src/governance/docgen/`：2 type + 10 fn
  - DocEntry + DocIndex + generate_dataverse_doc_index + doc_entry_to_markdown/doc_index_to_markdown + doc_entry_to_html/doc_index_to_html
- 测试: +9
- 总计: 452 → 461 passed
- API: 465→475 pub fn + 111→113 pub type
- commit: `4d133af`

---

## Phase 3 闭环总结 / Phase 3 Closure

| Sprint | 内容 | commit | 测试增量 |
|--------|------|--------|----------|
| S3.1 | io 数据源/汇适配 | 8e0c9bf | +18 |
| S3.2 | parallel/cpu_parallel 分布式后端 | 0ce9a46 | +16 |
| S3.3 | opcore/plugin 插件系统 | b0bf3f1 | +16 |
| S3.4 | 性能基准 + 算子融合 | 9e45553 | +15 |
| S3.5 | 文档站点生成 + 闭环 | 4d133af | +9 |

**Phase 3 总计**：测试 387→461（+74），API 400→475 pub fn + 86→113 pub type，0 error 0 warning。

---

### R16 Phase 3 门禁：形式化性质 31-40

**新增 / Added**
- `src/spec/spec.mbt` 追加 10 个形式化性质：
  - 31: read_source 空安全 | 32: write_sink 空安全 | 33: execute_write 写入守恒
  - 34: partition_data 分区守恒 | 35: gather_results 加法性
  - 36: register_plugin 幂等性 | 37: unregister_plugin 注销安全
  - 38: run_benchmark 零迭代安全 | 39: apply_fusion 融合不增节点 | 40: add_doc_entry 索引单调性

**R16 五手段验证结果**：全部通过 ✅
1. AI 辅助审查 ✅ 2. FAKE 退化数据 ✅ 3. MOCK 纯函数 ✅ 4. E2E 跨包 ✅ 5. 形式化证明 ✅

**统计 / Stats**
- 测试：461 → 471（+10 spec）
- 形式化性质：30 → 40
- commit：`3ef28fe`

---

> DataVerse Changelog | 2026-10-17 | Phase 3 闭环 + R16 门禁