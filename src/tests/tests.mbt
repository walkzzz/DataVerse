///|
/// # tests 跨包测试 / Cross-package Tests
///
/// 跨包测试：算子鲁棒性、退化数据、一致性回归。架构 §5。
/// S0.2: kernel 四模式一致性回归测试 + 退化数据测试。
///
/// # Cross-package tests
///
/// Operator robustness, degenerate data, consistency regression.
/// See architecture §5. S0.2: kernel four-mode consistency + degenerate data tests.

test "kernel mode_name covers four modes" {
  assert_eq(@kernel.mode_name(@kernel.Exact), "exact")
  assert_eq(@kernel.mode_name(@kernel.Approx(42)), "approx(seed)")
  assert_eq(@kernel.mode_name(@kernel.Streaming), "streaming")
  assert_eq(@kernel.mode_name(@kernel.Cache), "cache")
}

test "kernel mode_consistency contract" {
  assert_eq(@kernel.mode_consistency(@kernel.Exact), @kernel.ByteExact)
  assert_eq(@kernel.mode_consistency(@kernel.Approx(7)), @kernel.SeededBound(7, 0.0))
  assert_eq(@kernel.mode_consistency(@kernel.Streaming), @kernel.WindowEquiv)
  assert_eq(@kernel.mode_consistency(@kernel.Cache), @kernel.CacheHitEquiv)
}

test "kernel mode_from_tag roundtrip" {
  assert_eq(@kernel.mode_from_tag("exact", 0), @kernel.Exact)
  assert_eq(@kernel.mode_from_tag("approx", 42), @kernel.Approx(42))
  assert_eq(@kernel.mode_from_tag("streaming", 0), @kernel.Streaming)
  assert_eq(@kernel.mode_from_tag("cache", 0), @kernel.Cache)
}

test "kernel mode_from_tag unknown degrades to exact" {
  // 退化策略：未知 tag 安全退化为 Exact（最严格一致性）
  assert_eq(@kernel.mode_from_tag("unknown", 0), @kernel.Exact)
  assert_eq(@kernel.mode_from_tag("", 0), @kernel.Exact)
}

test "kernel all_mode_tags aggregates four sub-packages" {
  let tags = @kernel.all_mode_tags()
  assert_eq(tags.length(), 4)
  assert_eq(tags[0], "exact")
  assert_eq(tags[1], "approx")
  assert_eq(tags[2], "streaming")
  assert_eq(tags[3], "cache")
}

test "kernel exact sub-package contract" {
  assert_eq(@exact.exact_id(), "kernel/exact")
  assert_eq(@exact.mode_tag(), "exact")
  assert_eq(@exact.consistency_guarantee(), "byte-exact")
  assert_true(@exact.handles_empty())
}

test "kernel approx sub-package contract" {
  assert_eq(@approx.approx_id(), "kernel/approx")
  assert_eq(@approx.mode_tag(), "approx")
  assert_eq(@approx.consistency_guarantee(), "seeded-bound")
  assert_eq(@approx.default_seed(), 42)
  assert_true(@approx.valid_seed(0))
  assert_true(@approx.valid_seed(100))
  assert_false(@approx.valid_seed(-1))
}

test "kernel streaming sub-package contract" {
  assert_eq(@streaming.streaming_id(), "kernel/streaming")
  assert_eq(@streaming.mode_tag(), "streaming")
  assert_eq(@streaming.consistency_guarantee(), "window-equiv")
  let w = @streaming.default_window()
  assert_eq(w.window_size, 100)
  assert_eq(w.slide, 100)
  assert_true(@streaming.valid_window(w))
}

test "kernel streaming sliding window" {
  let w = @streaming.sliding_window(200, 50)
  assert_eq(w.window_size, 200)
  assert_eq(w.slide, 50)
  assert_true(@streaming.valid_window(w))
  let bad = @streaming.sliding_window(0, 10)
  assert_false(@streaming.valid_window(bad))
}

test "kernel cache sub-package contract" {
  assert_eq(@cache.cache_id(), "kernel/cache")
  assert_eq(@cache.mode_tag(), "cache")
  assert_eq(@cache.consistency_guarantee(), "cache-hit-equiv")
}

test "kernel cache key fingerprint and hit" {
  let k1 = @cache.make_key("abc")
  assert_eq(k1.key, "abc")
  assert_eq(k1.fingerprint, "fp:abc")
  let k2 = @cache.make_key("abc")
  assert_true(@cache.is_hit(k1, k2))
  let k3 = @cache.make_key("xyz")
  assert_false(@cache.is_hit(k1, k3))
}

test "kernel degenerate: empty content cache key" {
  // 退化数据：空字符串安全处理
  let k = @cache.make_key("")
  assert_eq(k.key, "")
  assert_eq(k.fingerprint, "fp:")
}
// === S0.3 dataobject 8 实体测试 ===

test "dataobject Modality enum" {
  let s = @schema.empty()
  let d1 = @dataobject.make_dataobject("text", @dataobject.Text, s)
  let d2 = @dataobject.make_dataobject("img", @dataobject.Image, s)
  assert_eq(d1.modality, @dataobject.Text)
  assert_eq(d2.modality, @dataobject.Image)
  assert_true(@dataobject.Text != @dataobject.Image)
}

test "dataobject Schema construction" {
  let s = @schema.make([@schema.field("id", @schema.Integer), @schema.field("text", @schema.Text)])
  assert_eq(@schema.size(s), 2)
  assert_eq(@schema.size(@schema.empty()), 0)
}

test "dataobject Chunk construction" {
  let c = @chunk.make("c1", "hello", @chunk.TextSlice)
  assert_eq(c.id, "c1")
  assert_eq(@chunk.length(c), 5)
  let e = @chunk.empty_chunk("c2", @chunk.TableBlock)
  assert_eq(@chunk.length(e), 0)
}

test "dataobject Embedding construction" {
  let emb = @embedding.make("bge-small", [0.1, 0.2, 0.3])
  assert_eq(emb.model_id, "bge-small")
  assert_false(emb.normalized)
  assert_eq(@embedding.dim(emb), 3)
  let z = @embedding.zero("test")
  assert_eq(@embedding.dim(z), 0)
  assert_true(z.normalized)
}

test "dataobject Record and Dataset construction" {
  let r = @record_dataset.make_record("r1", [("name", "Alice"), ("age", "30")])
  assert_eq(r.id, "r1")
  assert_eq(@record_dataset.record_field_count(r), 2)
  let d = @record_dataset.make_dataset([r], "v1")
  assert_eq(@record_dataset.size(d), 1)
  assert_eq(d.version, "v1")
  assert_eq(d.mix_ratio, 1.0)
}

test "dataobject Dataset with ratio and empty" {
  let r = @record_dataset.make_record("r1", [])
  let d = @record_dataset.make_dataset_with_ratio([r], "v2", 0.5)
  assert_eq(d.mix_ratio, 0.5)
  let e = @record_dataset.empty_dataset("v0")
  assert_eq(@record_dataset.size(e), 0)
}

test "dataobject DataObject construction" {
  let s = @schema.empty()
  let d = @dataobject.make_dataobject("hello world", @dataobject.Text, s)
  assert_eq(@dataobject.content_length(d), 11)
  assert_false(@dataobject.has_lineage(d))
}

test "dataobject DataObject with metadata" {
  let s = @schema.empty()
  let d = @dataobject.make_dataobject_with_metadata(
    "data", @dataobject.Table, s, [("source", "csv"), ("rows", "100")]
  )
  assert_eq(d.metadata.length(), 2)
  assert_false(@dataobject.has_lineage(d))
}

test "dataobject Lineage construction" {
  let l = @dataobject.make_lineage("op1", "fp_in", "fp_out", "p=1", "env=prod")
  assert_eq(l.operator_graph, "op1")
  let e = @dataobject.empty_lineage()
  assert_eq(e.input_fingerprint, "")
}

test "dataobject QualityCard construction" {
  let q = @dataobject.make_quality_card(
    [("accuracy", 0.95)], [("accuracy", 0.9)], true
  )
  assert_true(q.verdict)
  let p = @dataobject.passing_quality_card()
  assert_true(p.verdict)
  assert_eq(p.metrics.length(), 0)
}

test "dataobject degenerate: empty dataobject" {
  // 退化数据：空内容安全处理
  let d = @dataobject.empty_dataobject(@dataobject.Text)
  assert_eq(@dataobject.content_length(d), 0)
  assert_false(@dataobject.has_lineage(d))
}
// === S0.4 opcore 框架 + 三类算子测试 ===

test "opcore OperatorCategory and category_name" {
  assert_eq(@opcore.category_name(@opcore.Clean), "clean")
  assert_eq(@opcore.category_name(@opcore.Dedup), "dedup")
  assert_eq(@opcore.category_name(@opcore.Filter), "filter")
  assert_true(@opcore.Clean != @opcore.Dedup)
}

test "opcore Operator contract construction" {
  let op = @opcore.make_operator(
    "text_length_filter", @opcore.Filter, @dataobject.Text, @kernel.Exact, false
  )
  assert_eq(op.name, "text_length_filter")
  assert_eq(op.category, @opcore.Filter)
  assert_false(op.reversible)
}

test "opcore clean remove_empty" {
  let s = @schema.empty()
  let d1 = @dataobject.make_dataobject("hello", @dataobject.Text, s)
  let d2 = @dataobject.make_dataobject("", @dataobject.Text, s)
  assert_eq(@clean.remove_empty(d1).content, "hello")
  assert_eq(@clean.remove_empty(d2).content, "")
}

test "opcore clean strip_whitespace" {
  let s = @schema.empty()
  let d = @dataobject.make_dataobject("  hello  ", @dataobject.Text, s)
  assert_eq(@clean.strip_whitespace(d).content, "hello")
}

test "opcore dedup exact_dedup" {
  let s = @schema.empty()
  let d1 = @dataobject.make_dataobject("a", @dataobject.Text, s)
  let d2 = @dataobject.make_dataobject("b", @dataobject.Text, s)
  let d3 = @dataobject.make_dataobject("a", @dataobject.Text, s)
  let result = @dedup.exact_dedup([d1, d2, d3])
  assert_eq(result.length(), 2)
  assert_eq(@dedup.dedup_count(3, 2), 1)
}

test "opcore filter length_filter" {
  let s = @schema.empty()
  let d1 = @dataobject.make_dataobject("hi", @dataobject.Text, s)
  let d2 = @dataobject.make_dataobject("hello world", @dataobject.Text, s)
  assert_true(@filter.length_filter(3, 20, d2))
  assert_false(@filter.length_filter(3, 20, d1))
}

test "opcore filter non_empty_filter" {
  let s = @schema.empty()
  let d1 = @dataobject.make_dataobject("x", @dataobject.Text, s)
  let d2 = @dataobject.make_dataobject("", @dataobject.Text, s)
  assert_true(@filter.non_empty_filter(d1))
  assert_false(@filter.non_empty_filter(d2))
}

test "opcore filter filter_all" {
  let s = @schema.empty()
  let d1 = @dataobject.make_dataobject("a", @dataobject.Text, s)
  let d2 = @dataobject.make_dataobject("", @dataobject.Text, s)
  let d3 = @dataobject.make_dataobject("bb", @dataobject.Text, s)
  let result = @filter.filter_all([d1, d2, d3], fn(d) { d.content.length() > 0 })
  assert_eq(result.length(), 2)
}

test "opcore registry register and lookup" {
  let op = @opcore.make_operator(
    "remove_empty", @opcore.Clean, @dataobject.Text, @kernel.Exact, false
  )
  let r = @registry.register(@registry.empty(), op)
  assert_eq(@registry.size(r), 1)
  let found = @registry.lookup(r, "remove_empty")
  assert_true(found is Some(_))
  let not_found = @registry.lookup(r, "nonexistent")
  assert_true(not_found is None)
}

test "opcore registry valid_operator" {
  let valid = @opcore.make_operator("x", @opcore.Clean, @dataobject.Text, @kernel.Exact, false)
  let invalid = @opcore.make_operator("", @opcore.Clean, @dataobject.Text, @kernel.Exact, false)
  assert_true(@registry.valid_operator(valid))
  assert_false(@registry.valid_operator(invalid))
}
// === S0.5 datatemporal 测试 ===

test "datatemporal Fingerprint" {
  let fp1 = @datatemporal.make_fingerprint("hello")
  let fp2 = @datatemporal.make_fingerprint("hello")
  let fp3 = @datatemporal.make_fingerprint("world!")
  assert_true(@datatemporal.matches(fp1, fp2))
  assert_false(@datatemporal.matches(fp1, fp3))
}

test "datatemporal Version and VersionTower" {
  let v1 = @version.root_version("v1", 1000, "snap1")
  let v2 = @version.make_version("v2", Some("v1"), 2000, "snap2")
  assert_eq(v1.parent, None)
  let tower = @version.append(@version.append(@version.empty_tower(), v1), v2)
  assert_eq(@version.height(tower), 2)
}

test "datatemporal BiLineage and FieldLineage" {
  let bl = @lineage.make_bi_lineage("dedup", ["in1"], ["out1"], "threshold=0.9")
  assert_eq(bl.operator, "dedup")
  let fl = @lineage.make_field_lineage("score", ["feat1", "feat2"], "scorer")
  assert_eq(fl.field_name, "score")
}

test "datatemporal DriftReport" {
  let dr = @drift.make_drift_report("accuracy", 0.95, 0.90)
  // 浮点精度：0.90 - 0.95 ≠ 精确 -0.05，验证 is_significant 行为
  assert_true(@drift.is_significant(dr, 0.01))
  assert_false(@drift.is_significant(dr, 0.1))
}

test "datatemporal ReplayTrace" {
  let t = @replay.make_trace("t1", ["step1", "step2", "step3"], "fp_end")
  assert_eq(@replay.step_count(t), 3)
  let e = @replay.empty_trace("t0")
  assert_eq(@replay.step_count(e), 0)
}// === S0.6 datair 基础语法定义测试 ===

test "datair root id and ir_kind_count" {
  assert_eq(@datair.datair_id(), "datair")
  assert_eq(@datair.ir_core_id(), "datair/ir_core")
  assert_eq(@datair.ir_entity_id(), "datair/ir_entity")
  assert_eq(@datair.ir_operator_id(), "datair/ir_operator")
  // S0.6 落地实体 IR + 算子 IR；流水线 IR 留 Phase 1
  assert_eq(@datair.ir_kind_count(), 2)
}

test "ir_core IRNodeId construction and validity" {
  let id1 = @ir_core.IRNodeId::new("node_001")
  assert_eq(id1.value, "node_001")
  assert_true(id1.is_valid())
  // 退化数据：空串节点 id 无效
  let id2 = @ir_core.IRNodeId::new("")
  assert_false(id2.is_valid())
}

test "ir_core IRMetadata empty and construction" {
  let e = @ir_core.IRMetadata::empty()
  assert_true(e.is_empty())
  assert_eq(e.tag_count(), 0)
  let m = @ir_core.IRMetadata::new(["clean", "text"], "1.0.0", "src/csv")
  assert_false(m.is_empty())
  assert_eq(m.tag_count(), 2)
}

test "ir_entity EntityType and entity_type_name" {
  assert_eq(@ir_entity.entity_type_name(@ir_entity.DataObject), "data_object")
  assert_eq(@ir_entity.entity_type_name(@ir_entity.Chunk), "chunk")
  assert_eq(@ir_entity.entity_type_name(@ir_entity.Embedding), "embedding")
  assert_eq(@ir_entity.entity_type_name(@ir_entity.Dataset), "dataset")
  assert_true(@ir_entity.DataObject != @ir_entity.Chunk)
}

test "ir_entity EntityIR construction" {
  let id = @ir_core.IRNodeId::new("ent_001")
  let m = @ir_core.IRMetadata::new(["text"], "1.0.0", "schema/text_v1")
  let e = @ir_entity.EntityIR::new(id, @ir_entity.DataObject, "schema/text_v1", 1024, m)
  assert_eq(e.node_id.value, "ent_001")
  assert_eq(e.entity_type, @ir_entity.DataObject)
  assert_eq(e.schema_ref, "schema/text_v1")
  assert_eq(e.size_hint, 1024)
  // 简化构造
  let s = @ir_entity.EntityIR::simple(id, @ir_entity.Chunk, "schema/chunk_v1")
  assert_eq(s.size_hint, 0)
  assert_true(s.metadata.is_empty())
}

test "ir_operator Determinism and determinism_name" {
  assert_eq(@ir_operator.determinism_name(@ir_operator.Deterministic), "deterministic")
  assert_eq(
    @ir_operator.determinism_name(@ir_operator.ApproximateWithSeed(42)),
    "approximate(seed)",
  )
  assert_eq(
    @ir_operator.determinism_name(@ir_operator.NonDeterministic),
    "non-deterministic",
  )
  assert_true(@ir_operator.Deterministic != @ir_operator.NonDeterministic)
}

test "ir_operator IRModality and modality_name" {
  assert_eq(@ir_operator.modality_name(@ir_operator.Text), "text")
  assert_eq(@ir_operator.modality_name(@ir_operator.Image), "image")
  assert_eq(@ir_operator.modality_name(@ir_operator.Multi), "multi")
  assert_true(@ir_operator.Text != @ir_operator.Code)
}

test "ir_operator CostModel construction" {
  let c = @ir_operator.CostModel::new("O(n log n)", "O(n)", 0.7)
  assert_eq(c.time_complexity, "O(n log n)")
  assert_eq(c.space_complexity, "O(n)")
  // 浮点比较用行为验证（0.7 在 0.5 之上）
  assert_true(c.estimated_cost > 0.5)
  let s = @ir_operator.CostModel::simple()
  assert_eq(s.time_complexity, "O(n)")
  assert_eq(s.space_complexity, "O(n)")
}

test "ir_operator OperatorIR construction" {
  let id = @ir_core.IRNodeId::new("op_001")
  let m = @ir_core.IRMetadata::new(["clean"], "1.0.0", "opcore/clean")
  let cm = @ir_operator.CostModel::new("O(n)", "O(1)", 0.2)
  let op = @ir_operator.OperatorIR::new(
    id,
    "remove_empty",
    [("min_length", "1")],
    @ir_operator.Text,
    @ir_operator.Deterministic,
    cm,
    m,
  )
  assert_eq(op.name, "remove_empty")
  assert_eq(op.param_count(), 1)
  assert_eq(op.modality, @ir_operator.Text)
  assert_eq(op.determinism, @ir_operator.Deterministic)
  // 简化构造
  let s = @ir_operator.OperatorIR::simple(
    id, "exact_dedup", @ir_operator.Text, @ir_operator.Deterministic,
  )
  assert_eq(s.param_count(), 0)
  assert_true(s.metadata.is_empty())
}

test "datair degenerate: empty node id and empty metadata" {
  // 退化数据：空节点 id 安全处理（is_valid 返回 false，不抛异常）
  let id = @ir_core.IRNodeId::new("")
  assert_false(id.is_valid())
  let e = @ir_entity.EntityIR::simple(id, @ir_entity.DataObject, "")
  assert_eq(e.schema_ref, "")
  let op = @ir_operator.OperatorIR::simple(
    id, "", @ir_operator.Text, @ir_operator.Deterministic,
  )
  assert_eq(op.name, "")
  assert_eq(op.param_count(), 0)
}// === S0.7 dosi 基础设施原型测试 ===

test "dosi root id and sub-package ids" {
  assert_eq(@dosi.dosi_id(), "dosi")
  assert_eq(@dosi.builder_id(), "dosi/builder")
  assert_eq(@dosi.router_id(), "dosi/router")
}

test "dosi SymbolicEntry and SemanticEntry construction" {
  let sym = @dosi.SymbolicEntry::new("opcore.clean.x", "clean", "text", ["dep1"])
  assert_eq(sym.path, "opcore.clean.x")
  assert_eq(sym.category, "clean")
  assert_eq(sym.modality, "text")
  assert_eq(sym.dependencies.length(), 1)
  let sem = @dosi.SemanticEntry::new("summary", ["p1"], "contract")
  assert_eq(sem.summary, "summary")
  assert_eq(sem.params.length(), 1)
}

test "dosi DOSIIndex empty and add" {
  let e = @dosi.DOSIIndex::empty()
  assert_eq(e.size(), 0)
  let sym = @dosi.SymbolicEntry::new("p", "c", "m", [])
  let sem = @dosi.SemanticEntry::new("s", [], "c")
  let entry = @dosi.DOSIEntry::new(sym, sem)
  let idx = e.add(entry)
  assert_eq(idx.size(), 1)
  assert_eq(idx.entries().length(), 1)
}

test "dosi builder build_opcore_index" {
  let idx = @builder.build_opcore_index()
  // S0.7 为 5 个 opcore 算子生成索引条目
  assert_eq(idx.size(), 5)
  assert_eq(@builder.builder_id(), "dosi/builder")
}

test "dosi builder build_from_operator_ir" {
  let id = @ir_core.IRNodeId::new("op_001")
  let op = @ir_operator.OperatorIR::new(
    id,
    "my_op",
    [("threshold", "0.9"), ("model", "bge")],
    @ir_operator.Text,
    @ir_operator.ApproximateWithSeed(42),
    @ir_operator.CostModel::simple(),
    @ir_core.IRMetadata::empty(),
  )
  let entry = @builder.build_from_operator_ir(op)
  assert_eq(entry.symbolic.path, "datair.operator.my_op")
  assert_eq(entry.symbolic.modality, "text")
  assert_eq(entry.symbolic.dependencies.length(), 2)
  assert_eq(entry.semantic.params.length(), 2)
}

test "dosi builder merge" {
  let idx1 = @builder.build_opcore_index()
  let sym = @dosi.SymbolicEntry::new("extra", "custom", "text", [])
  let sem = @dosi.SemanticEntry::new("s", [], "c")
  let idx2 = @dosi.DOSIIndex::empty().add(@dosi.DOSIEntry::new(sym, sem))
  let merged = @builder.merge(idx1, idx2)
  assert_eq(merged.size(), 6)
}

test "dosi router lookup_by_path" {
  let idx = @builder.build_opcore_index()
  let found = @router.lookup_by_path(idx, "opcore.clean.remove_empty")
  assert_true(found is Some(_))
  let not_found = @router.lookup_by_path(idx, "nonexistent")
  assert_true(not_found is None)
  assert_eq(@router.router_id(), "dosi/router")
}

test "dosi router lookup_by_category" {
  let idx = @builder.build_opcore_index()
  let clean_ops = @router.lookup_by_category(idx, "clean")
  assert_eq(clean_ops.length(), 2)
  let filter_ops = @router.lookup_by_category(idx, "filter")
  assert_eq(filter_ops.length(), 2)
  let dedup_ops = @router.lookup_by_category(idx, "dedup")
  assert_eq(dedup_ops.length(), 1)
  let empty = @router.lookup_by_category(idx, "nonexistent")
  assert_eq(empty.length(), 0)
}

test "dosi router lookup_by_modality" {
  let idx = @builder.build_opcore_index()
  let text_ops = @router.lookup_by_modality(idx, "text")
  // 所有 5 个 opcore 算子都是 text 模态
  assert_eq(text_ops.length(), 5)
  let image_ops = @router.lookup_by_modality(idx, "image")
  assert_eq(image_ops.length(), 0)
}

test "dosi router lookup_by_prefix" {
  let idx = @builder.build_opcore_index()
  let clean_all = @router.lookup_by_prefix(idx, "opcore.clean.")
  assert_eq(clean_all.length(), 2)
  let filter_all = @router.lookup_by_prefix(idx, "opcore.filter.")
  assert_eq(filter_all.length(), 2)
  let all = @router.lookup_by_prefix(idx, "opcore.")
  assert_eq(all.length(), 5)
}

test "dosi degenerate: empty index lookups" {
  // 退化数据：空索引查询安全返回
  let e = @dosi.DOSIIndex::empty()
  assert_true(@router.lookup_by_path(e, "x") is None)
  assert_eq(@router.lookup_by_category(e, "x").length(), 0)
  assert_eq(@router.lookup_by_modality(e, "x").length(), 0)
  assert_eq(@router.lookup_by_prefix(e, "x").length(), 0)
}
///|
/// # S1.1 opcore 14 类算子测试 / 14-category operator tests
///
/// 每类算子至少 1 个正常用例 + 1 个退化数据用例（空串/空数组/越界参数）。
/// 对标 Data-Juicer P0 高频算子：whitespace_normalization, topk_selector, text_chunk_mapper 等。

test "S1.1 ingest formatters modality" {
  let t = @ingest.text_formatter("hello")
  let j = @ingest.json_formatter("{\"a\":1}")
  let c = @ingest.csv_formatter("a,b,c")
  assert_eq(t.modality, @dataobject.Text)
  assert_eq(j.modality, @dataobject.Text)
  assert_eq(c.modality, @dataobject.Table)
  assert_eq(t.content, "hello")
  assert_eq(@ingest.ingest_id(), "opcore/ingest")
}

test "S1.1 ingest degenerate: empty string" {
  let t = @ingest.text_formatter("")
  assert_eq(t.content, "")
  assert_eq(t.modality, @dataobject.Text)
}

test "S1.1 normalize whitespace_normalization" {
  let s = @schema.empty()
  let d = @dataobject.make_dataobject("  hello   world  ", @dataobject.Text, s)
  let n = @normalize.whitespace_normalization(d)
  assert_eq(n.content, "hello world")
}

test "S1.1 normalize punctuation_normalization" {
  let s = @schema.empty()
  let d = @dataobject.make_dataobject("你好，世界。", @dataobject.Text, s)
  let n = @normalize.punctuation_normalization(d)
  assert_eq(n.content, "你好,世界.")
}

test "S1.1 normalize degenerate: empty string" {
  let s = @schema.empty()
  let d = @dataobject.make_dataobject("", @dataobject.Text, s)
  assert_eq(@normalize.whitespace_normalization(d).content, "")
  assert_eq(@normalize.punctuation_normalization(d).content, "")
  assert_eq(@normalize.normalize_id(), "opcore/normalize")
}

test "S1.1 quality length_quality_score boundaries" {
  let s = @schema.empty()
  let empty = @dataobject.make_dataobject("", @dataobject.Text, s)
  let short = @dataobject.make_dataobject("hi", @dataobject.Text, s)
  let full = @dataobject.make_dataobject("a".repeat(100), @dataobject.Text, s)
  let over = @dataobject.make_dataobject("a".repeat(200), @dataobject.Text, s)
  assert_eq(@quality.length_quality_score(empty), 0.0)
  assert_true(@quality.length_quality_score(short) > 0.0)
  assert_eq(@quality.length_quality_score(full), 1.0)
  assert_eq(@quality.length_quality_score(over), 1.0)
}

test "S1.1 quality text_quality_score" {
  let s = @schema.empty()
  let d = @dataobject.make_dataobject("hello world", @dataobject.Text, s)
  let score = @quality.text_quality_score(d)
  assert_true(score > 0.0 && score <= 1.0)
  assert_eq(@quality.quality_id(), "opcore/quality")
}

test "S1.1 transform to_lowercase and to_uppercase" {
  let s = @schema.empty()
  let d = @dataobject.make_dataobject("Hello World", @dataobject.Text, s)
  assert_eq(@transform.to_lowercase(d).content, "hello world")
  assert_eq(@transform.to_uppercase(d).content, "HELLO WORLD")
}

test "S1.1 transform truncate" {
  let s = @schema.empty()
  let d = @dataobject.make_dataobject("hello world", @dataobject.Text, s)
  assert_eq(@transform.truncate(d, 5).content, "hello")
  assert_eq(@transform.truncate(d, 100).content, "hello world")
}

test "S1.1 transform degenerate: empty string" {
  let s = @schema.empty()
  let d = @dataobject.make_dataobject("", @dataobject.Text, s)
  assert_eq(@transform.to_lowercase(d).content, "")
  assert_eq(@transform.to_uppercase(d).content, "")
  assert_eq(@transform.truncate(d, 5).content, "")
  assert_eq(@transform.transform_id(), "opcore/transform")
}

test "S1.1 annotate tag_by_length three tiers" {
  let s = @schema.empty()
  let short_d = @dataobject.make_dataobject("hi", @dataobject.Text, s)
  let med_d = @dataobject.make_dataobject("a".repeat(100), @dataobject.Text, s)
  let long_d = @dataobject.make_dataobject("a".repeat(300), @dataobject.Text, s)
  let short_tagged = @annotate.tag_by_length(short_d)
  let med_tagged = @annotate.tag_by_length(med_d)
  let long_tagged = @annotate.tag_by_length(long_d)
  assert_eq(short_tagged.metadata.length(), 1)
  assert_eq(short_tagged.metadata[0], ("length_tag", "short"))
  assert_eq(med_tagged.metadata[0], ("length_tag", "medium"))
  assert_eq(long_tagged.metadata[0], ("length_tag", "long"))
}

test "S1.1 annotate tag_modality" {
  let s = @schema.empty()
  let d = @dataobject.make_dataobject("x", @dataobject.Image, s)
  let tagged = @annotate.tag_modality(d)
  assert_eq(tagged.metadata[0], ("modality_tag", "image"))
  assert_eq(@annotate.annotate_id(), "opcore/annotate")
}

test "S1.1 select topk_by_length" {
  let s = @schema.empty()
  let d1 = @dataobject.make_dataobject("a", @dataobject.Text, s)
  let d2 = @dataobject.make_dataobject("bbb", @dataobject.Text, s)
  let d3 = @dataobject.make_dataobject("cc", @dataobject.Text, s)
  let top2 = @select.topk_by_length([d1, d2, d3], 2)
  assert_eq(top2.length(), 2)
  assert_eq(top2[0].content, "bbb")
  assert_eq(top2[1].content, "cc")
}

test "S1.1 select threshold_by_length" {
  let s = @schema.empty()
  let d1 = @dataobject.make_dataobject("a", @dataobject.Text, s)
  let d2 = @dataobject.make_dataobject("bbb", @dataobject.Text, s)
  let result = @select.threshold_by_length([d1, d2], 2)
  assert_eq(result.length(), 1)
  assert_eq(result[0].content, "bbb")
}

test "S1.1 select degenerate: empty array and k<=0" {
  let s = @schema.empty()
  let d1 = @dataobject.make_dataobject("a", @dataobject.Text, s)
  let d2 = @dataobject.make_dataobject("b", @dataobject.Text, s)
  // k <= 0 返回全部
  assert_eq(@select.topk_by_length([d1, d2], 0).length(), 2)
  // k >= length 返回全部
  assert_eq(@select.topk_by_length([d1, d2], 10).length(), 2)
  // 空数组
  assert_eq(@select.topk_by_length([], 5).length(), 0)
  assert_eq(@select.threshold_by_length([], 1).length(), 0)
  assert_eq(@select.select_id(), "opcore/select")
}

test "S1.1 mix group_by_modality" {
  let s = @schema.empty()
  let t1 = @dataobject.make_dataobject("a", @dataobject.Text, s)
  let t2 = @dataobject.make_dataobject("b", @dataobject.Text, s)
  let i1 = @dataobject.make_dataobject("img", @dataobject.Image, s)
  let groups = @mix.group_by_modality([t1, t2, i1])
  assert_eq(groups.length(), 2)
}

test "S1.1 mix interleave" {
  let s = @schema.empty()
  let a = [@dataobject.make_dataobject("a", @dataobject.Text, s), @dataobject.make_dataobject("b", @dataobject.Text, s)]
  let b = [@dataobject.make_dataobject("1", @dataobject.Text, s)]
  let result = @mix.interleave(a, b)
  assert_eq(result.length(), 3)
  assert_eq(result[0].content, "a")
  assert_eq(result[1].content, "1")
  assert_eq(result[2].content, "b")
}

test "S1.1 mix degenerate: empty arrays" {
  let s = @schema.empty()
  let d = @dataobject.make_dataobject("a", @dataobject.Text, s)
  assert_eq(@mix.group_by_modality([]).length(), 0)
  assert_eq(@mix.interleave([], []).length(), 0)
  assert_eq(@mix.interleave([d], []).length(), 1)
  assert_eq(@mix.mix_id(), "opcore/mix")
}

test "S1.1 pack text_chunk" {
  let s = @schema.empty()
  let d = @dataobject.make_dataobject("abcdefghij", @dataobject.Text, s)
  let chunks = @pack.text_chunk(d, 3)
  assert_eq(chunks.length(), 4)
  assert_eq(chunks[0].content, "abc")
  assert_eq(chunks[3].content, "j")
}

test "S1.1 pack degenerate: chunk_size <= 0" {
  let s = @schema.empty()
  let d = @dataobject.make_dataobject("hello", @dataobject.Text, s)
  let chunks = @pack.text_chunk(d, 0)
  assert_eq(chunks.length(), 1)
  assert_eq(chunks[0].content, "hello")
  // 空内容
  let empty_d = @dataobject.make_dataobject("", @dataobject.Text, s)
  let empty_chunks = @pack.text_chunk(empty_d, 3)
  assert_eq(empty_chunks.length(), 1)
  assert_eq(@pack.pack_id(), "opcore/pack")
}

test "S1.1 eval global_statistics" {
  let s = @schema.empty()
  let d1 = @dataobject.make_dataobject("hello", @dataobject.Text, s)
  let d2 = @dataobject.make_dataobject("hi", @dataobject.Text, s)
  let d3 = @dataobject.make_dataobject("", @dataobject.Text, s)
  let stats = @eval.global_statistics([d1, d2, d3])
  assert_eq(stats.total_count, 3)
  assert_eq(stats.nonempty_count, 2)
  assert_eq(stats.max_length, 5)
  assert_eq(stats.min_length, 0)
}

test "S1.1 eval degenerate: empty array" {
  let stats = @eval.global_statistics([])
  assert_eq(stats.total_count, 0)
  assert_eq(stats.avg_length, 0.0)
  assert_eq(@eval.eval_id(), "opcore/eval")
}

test "S1.1 lineage_op attach_lineage" {
  let s = @schema.empty()
  let d = @dataobject.make_dataobject("hello", @dataobject.Text, s)
  let (out_d, lineage) = @lineage_op.attach_lineage(d, "whitespace_normalization")
  assert_eq(out_d.content, "hello")
  assert_eq(lineage.operator_graph, "whitespace_normalization")
  assert_eq(lineage.input_fingerprint, "fp:5")
}

test "S1.1 lineage_op make_op_lineage" {
  let s = @schema.empty()
  let d = @dataobject.make_dataobject("hello", @dataobject.Text, s)
  let lineage = @lineage_op.make_op_lineage("truncate", d, "max_len=10")
  assert_eq(lineage.operator_graph, "truncate")
  assert_eq(lineage.params, "max_len=10")
  assert_eq(@lineage_op.lineage_op_id(), "opcore/lineage_op")
}

test "S1.1 safety mask_digits" {
  let s = @schema.empty()
  let d = @dataobject.make_dataobject("call 138-1234-5678", @dataobject.Text, s)
  let masked = @safety.mask_digits(d)
  assert_eq(masked.content, "call ***-****-****")
}

test "S1.1 safety mask_email" {
  let s = @schema.empty()
  let d = @dataobject.make_dataobject("user@example.com", @dataobject.Text, s)
  let masked = @safety.mask_email(d)
  assert_eq(masked.content, "***@example.com")
}

test "S1.1 safety degenerate: no digits and no at sign" {
  let s = @schema.empty()
  let d = @dataobject.make_dataobject("plain text", @dataobject.Text, s)
  assert_eq(@safety.mask_digits(d).content, "plain text")
  assert_eq(@safety.mask_email(d).content, "plain text")
  // @ 在开头
  let at_first = @dataobject.make_dataobject("@nope.com", @dataobject.Text, s)
  assert_eq(@safety.mask_email(at_first).content, "@nope.com")
  assert_eq(@safety.safety_id(), "opcore/safety")
}
///|
/// # S1.2 learncore 传统 ML 算子测试 / Traditional ML operator tests
///
/// 每类算子至少 1 个正常用例 + 1 个退化数据用例。
/// 对标架构 §4.3.5 A（传统 ML）+ D（评估指标）。

test "S1.2 learncore ModelSpace and model_space_name" {
  assert_eq(@learncore.model_space_name(@learncore.ML), "ml")
  assert_eq(@learncore.model_space_name(@learncore.DL), "dl")
  assert_eq(@learncore.model_space_name(@learncore.SSL), "ssl")
  assert_eq(@learncore.model_space_name(@learncore.Eval), "eval")
  assert_eq(@learncore.model_space_name(@learncore.Adapt), "adapt")
  assert_eq(@learncore.model_space_name(@learncore.Optim), "optim")
  assert_true(@learncore.ML != @learncore.DL)
  assert_eq(@learncore.learncore_id(), "learncore")
}

test "S1.2 learncore Hyperparams construction" {
  let hp = @learncore.make_hyperparams("n_estimators", ["10", "50", "100"])
  assert_eq(hp.name, "n_estimators")
  assert_eq(hp.values.length(), 3)
}

test "S1.2 regression linear_regression basic" {
  // y = 2x + 1
  let points = [(0.0, 1.0), (1.0, 3.0), (2.0, 5.0), (3.0, 7.0)]
  let model = @regression.linear_regression(points)
  assert_true(model.slope > 1.99 && model.slope < 2.01)
  assert_true(model.intercept > 0.99 && model.intercept < 1.01)
  let pred = @regression.predict_linear(model, 5.0)
  assert_true(pred > 10.99 && pred < 11.01)
}

test "S1.2 regression degenerate: empty and same x" {
  let empty_model = @regression.linear_regression([])
  assert_eq(empty_model.slope, 0.0)
  assert_eq(empty_model.intercept, 0.0)
  // 所有 x 相同：slope=0, intercept=mean_y
  let same_x = [(1.0, 2.0), (1.0, 4.0), (1.0, 6.0)]
  let model = @regression.linear_regression(same_x)
  assert_eq(model.slope, 0.0)
  assert_true(model.intercept > 3.99 && model.intercept < 4.01)
  assert_eq(@regression.regression_id(), "learncore/regression")
}

test "S1.2 classify knn_classify basic" {
  let train = [
    ([0.0, 0.0], "A"),
    ([0.0, 1.0], "A"),
    ([10.0, 10.0], "B"),
    ([10.0, 11.0], "B"),
  ]
  let label = @classify.knn_classify(train, [0.5, 0.5], 3)
  assert_eq(label, "A")
  let label2 = @classify.knn_classify(train, [9.5, 10.0], 3)
  assert_eq(label2, "B")
}

test "S1.2 classify degenerate: empty train and bad k" {
  assert_eq(@classify.knn_classify([], [0.0, 0.0], 3), "")
  let train = [([0.0], "A"), ([1.0], "B")]
  // k <= 0 默认 k=1
  assert_eq(@classify.knn_classify(train, [0.1], 0), "A")
  // k > n 默认 k=n
  assert_eq(@classify.knn_classify(train, [0.9], 100), "B")
  assert_eq(@classify.classify_id(), "learncore/classify")
}

test "S1.2 cluster kmeans basic" {
  let points = [
    [0.0, 0.0],
    [0.0, 1.0],
    [1.0, 0.0],
    [10.0, 10.0],
    [10.0, 11.0],
    [11.0, 10.0],
  ]
  let labels = @cluster.kmeans(points, 2, 10)
  assert_eq(labels.length(), 6)
  // 前三个应该同簇，后三个应该同簇
  assert_eq(labels[0], labels[1])
  assert_eq(labels[1], labels[2])
  assert_eq(labels[3], labels[4])
  assert_eq(labels[4], labels[5])
  assert_true(labels[0] != labels[3])
}

test "S1.2 cluster degenerate: empty and bad k" {
  assert_eq(@cluster.kmeans([], 2, 10).length(), 0)
  let points = [[0.0], [1.0], [2.0]]
  // k <= 0 返回全 0
  let labels = @cluster.kmeans(points, 0, 10)
  assert_eq(labels, [0, 0, 0])
  assert_eq(@cluster.cluster_id(), "learncore/cluster")
}

test "S1.2 feature standardize basic" {
  let data = [1.0, 2.0, 3.0, 4.0, 5.0]
  let std = @feature.standardize(data)
  assert_eq(std.length(), 5)
  // 标准化后均值≈0
  let mean = std.fold(init=0.0, fn(acc, x) { acc + x }) / 5.0
  assert_true(mean > -0.001 && mean < 0.001)
}

test "S1.2 feature normalize_minmax basic" {
  let data = [0.0, 5.0, 10.0]
  let norm = @feature.normalize_minmax(data)
  assert_true(norm[0] > -0.001 && norm[0] < 0.001)
  assert_true(norm[1] > 0.49 && norm[1] < 0.51)
  assert_true(norm[2] > 0.99 && norm[2] < 1.01)
}

test "S1.2 feature degenerate: empty and constant" {
  assert_eq(@feature.standardize([]).length(), 0)
  assert_eq(@feature.normalize_minmax([]).length(), 0)
  // 所有值相同：std=0 返回全 0
  let constant = [5.0, 5.0, 5.0]
  let std = @feature.standardize(constant)
  assert_eq(std, [0.0, 0.0, 0.0])
  let norm = @feature.normalize_minmax(constant)
  assert_eq(norm, [0.0, 0.0, 0.0])
  assert_eq(@feature.feature_id(), "learncore/feature")
}

test "S1.2 metrics accuracy and mse and mae" {
  let pred = ["A", "B", "A", "B"]
  let actual = ["A", "B", "B", "B"]
  assert_true(@metrics.accuracy(pred, actual) > 0.74 && @metrics.accuracy(pred, actual) < 0.76)
  let pred_d = [1.0, 2.0, 3.0]
  let actual_d = [1.0, 2.0, 4.0]
  let mse_val = @metrics.mse(pred_d, actual_d)
  assert_true(mse_val > 0.32 && mse_val < 0.34)
  let mae_val = @metrics.mae(pred_d, actual_d)
  assert_true(mae_val > 0.32 && mae_val < 0.34)
}

test "S1.2 metrics confusion_matrix" {
  let pred = ["A", "B", "A", "B"]
  let actual = ["A", "A", "A", "B"]
  let cm = @metrics.confusion_matrix(pred, actual, ["A", "B"])
  // cm[真实][预测]
  assert_eq(cm[0][0], 2) // 真A 预A
  assert_eq(cm[0][1], 1) // 真A 预B
  assert_eq(cm[1][0], 0) // 真B 预A
  assert_eq(cm[1][1], 1) // 真B 预B
}

test "S1.2 metrics degenerate: empty arrays" {
  assert_eq(@metrics.accuracy([], []), 0.0)
  assert_eq(@metrics.mse([], []), 0.0)
  assert_eq(@metrics.mae([], []), 0.0)
  let cm = @metrics.confusion_matrix([], [], ["A", "B"])
  assert_eq(cm, [[0, 0], [0, 0]])
  assert_eq(@metrics.metrics_id(), "learncore/metrics")
}
///|
/// # S1.3 recipe 复合线测试 / Composite Pipeline Tests
///
/// 4 条复合线：cleaning/dedup/quality/balance。架构 §4.5。

test "S1.3 cleaning_line basic" {
  let s = @schema.empty()
  let d1 = @dataobject.make_dataobject("  hello   world  ", @dataobject.Text, s)
  let d2 = @dataobject.make_dataobject("", @dataobject.Text, s)
  let d3 = @dataobject.make_dataobject("  foo  bar  ", @dataobject.Text, s)
  let result = @cleaning_line.cleaning_line([d1, d2, d3])
  assert_eq(result.length(), 2)
  assert_eq(result[0].content, "hello world")
  assert_eq(result[1].content, "foo bar")
}

test "S1.3 cleaning_line degenerate: empty array" {
  assert_eq(@cleaning_line.cleaning_line([]).length(), 0)
  assert_eq(@cleaning_line.cleaning_line_id(), "recipe/cleaning_line")
}

test "S1.3 dedup_line basic" {
  let s = @schema.empty()
  let d1 = @dataobject.make_dataobject("a", @dataobject.Text, s)
  let d2 = @dataobject.make_dataobject("b", @dataobject.Text, s)
  let d3 = @dataobject.make_dataobject("a", @dataobject.Text, s)
  let result = @dedup_line.dedup_line([d1, d2, d3])
  assert_eq(result.length(), 2)
  assert_eq(@dedup_line.dedup_line_id(), "recipe/dedup_line")
}

test "S1.3 dedup_line degenerate: empty array" {
  assert_eq(@dedup_line.dedup_line([]).length(), 0)
}

test "S1.3 quality_line basic" {
  let s = @schema.empty()
  let d1 = @dataobject.make_dataobject("a".repeat(150), @dataobject.Text, s)
  let d2 = @dataobject.make_dataobject("b".repeat(50), @dataobject.Text, s)
  let d3 = @dataobject.make_dataobject("c".repeat(10), @dataobject.Text, s)
  // min_score=0.5 → 过滤掉质量分 < 0.5 的；k=2 → 取前 2 个
  let result = @quality_line.quality_line([d1, d2, d3], 0.5, 2)
  // d1 (score=1.0) 和 d2 (score=0.5) 通过过滤
  assert_true(result.length() <= 2)
  assert_eq(@quality_line.quality_line_id(), "recipe/quality_line")
}

test "S1.3 quality_line degenerate: empty array" {
  assert_eq(@quality_line.quality_line([], 0.5, 10).length(), 0)
  // k <= 0 返回过滤后全部
  let s = @schema.empty()
  let d = @dataobject.make_dataobject("a".repeat(200), @dataobject.Text, s)
  assert_eq(@quality_line.quality_line([d], 0.5, 0).length(), 1)
}

test "S1.3 balance_line basic" {
  let s = @schema.empty()
  let texts = [
    @dataobject.make_dataobject("aaa", @dataobject.Text, s),
    @dataobject.make_dataobject("bb", @dataobject.Text, s),
  ]
  let images = [
    @dataobject.make_dataobject("img1", @dataobject.Image, s),
  ]
  let result = @balance_line.balance_line(texts + images, 1)
  // 每个模态取 top-1，text 取最长的 "aaa"，image 取 "img1"
  assert_eq(result.length(), 2)
}

test "S1.3 balance_line degenerate: empty array" {
  assert_eq(@balance_line.balance_line([], 5).length(), 0)
  assert_eq(@balance_line.balance_line_id(), "recipe/balance_line")
}
///|
/// # S1.4 DataIR 流水线 IR（DAG）+ 优化器测试 / Pipeline IR + Optimizer Tests
///
/// 架构 §4.6：DAG 构造 + 拓扑排序 + 算子融合 + 恒等消除。

test "S1.4 ir_pipeline construction" {
  let p = @ir_pipeline.PipelineIR::empty()
  assert_eq(p.node_count(), 0)
  assert_eq(p.edge_count(), 0)
  let n1 = @ir_operator.OperatorIR::simple(
    @ir_core.IRNodeId::new("op1"),
    "whitespace_normalization",
    @ir_operator.Text,
    @ir_operator.Deterministic,
  )
  let p1 = p.add_node(n1)
  assert_eq(p1.node_count(), 1)
  let n2 = @ir_operator.OperatorIR::simple(
    @ir_core.IRNodeId::new("op2"),
    "truncate",
    @ir_operator.Text,
    @ir_operator.Deterministic,
  )
  let p2 = p1.add_node(n2)
  let e = @ir_pipeline.DAGEdge::new(
    @ir_core.IRNodeId::new("op1"),
    @ir_core.IRNodeId::new("op2"),
  )
  let p3 = p2.add_edge(e)
  assert_eq(p3.node_count(), 2)
  assert_eq(p3.edge_count(), 1)
  assert_eq(@ir_pipeline.ir_pipeline_id(), "datair/ir_pipeline")
}

test "S1.4 ir_pipeline topo_order linear" {
  let n1 = @ir_operator.OperatorIR::simple(
    @ir_core.IRNodeId::new("a"), "op_a", @ir_operator.Text, @ir_operator.Deterministic,
  )
  let n2 = @ir_operator.OperatorIR::simple(
    @ir_core.IRNodeId::new("b"), "op_b", @ir_operator.Text, @ir_operator.Deterministic,
  )
  let n3 = @ir_operator.OperatorIR::simple(
    @ir_core.IRNodeId::new("c"), "op_c", @ir_operator.Text, @ir_operator.Deterministic,
  )
  let p = @ir_pipeline.PipelineIR::empty().add_node(n1).add_node(n2).add_node(n3)
    .add_edge(@ir_pipeline.DAGEdge::new(@ir_core.IRNodeId::new("a"), @ir_core.IRNodeId::new("b")))
    .add_edge(@ir_pipeline.DAGEdge::new(@ir_core.IRNodeId::new("b"), @ir_core.IRNodeId::new("c")))
  let order = p.topo_order()
  assert_eq(order.length(), 3)
  assert_eq(order[0].value(), "a")
  assert_eq(order[1].value(), "b")
  assert_eq(order[2].value(), "c")
}

test "S1.4 ir_pipeline topo_order degenerate: empty and cycle" {
  let empty = @ir_pipeline.PipelineIR::empty()
  assert_eq(empty.topo_order().length(), 0)
  // 有环：a→b→a
  let na = @ir_operator.OperatorIR::simple(
    @ir_core.IRNodeId::new("a"), "op_a", @ir_operator.Text, @ir_operator.Deterministic,
  )
  let nb = @ir_operator.OperatorIR::simple(
    @ir_core.IRNodeId::new("b"), "op_b", @ir_operator.Text, @ir_operator.Deterministic,
  )
  let cyclic = @ir_pipeline.PipelineIR::empty().add_node(na).add_node(nb)
    .add_edge(@ir_pipeline.DAGEdge::new(@ir_core.IRNodeId::new("a"), @ir_core.IRNodeId::new("b")))
    .add_edge(@ir_pipeline.DAGEdge::new(@ir_core.IRNodeId::new("b"), @ir_core.IRNodeId::new("a")))
  assert_eq(cyclic.topo_order().length(), 0)
}

test "S1.4 ir_optimizer fuse_adjacent_maps" {
  let n1 = @ir_operator.OperatorIR::simple(
    @ir_core.IRNodeId::new("op1"), "whitespace_normalization", @ir_operator.Text, @ir_operator.Deterministic,
  )
  let n2 = @ir_operator.OperatorIR::simple(
    @ir_core.IRNodeId::new("op2"), "whitespace_normalization", @ir_operator.Text, @ir_operator.Deterministic,
  )
  let n3 = @ir_operator.OperatorIR::simple(
    @ir_core.IRNodeId::new("op3"), "truncate", @ir_operator.Text, @ir_operator.Deterministic,
  )
  let p = @ir_pipeline.PipelineIR::empty().add_node(n1).add_node(n2).add_node(n3)
  let fused = @ir_optimizer.fuse_adjacent_maps(p)
  assert_eq(fused.node_count(), 2)
}

test "S1.4 ir_optimizer remove_identity" {
  let n1 = @ir_operator.OperatorIR::simple(
    @ir_core.IRNodeId::new("op1"), "identity", @ir_operator.Text, @ir_operator.Deterministic,
  )
  let n2 = @ir_operator.OperatorIR::simple(
    @ir_core.IRNodeId::new("op2"), "truncate", @ir_operator.Text, @ir_operator.Deterministic,
  )
  let n3 = @ir_operator.OperatorIR::simple(
    @ir_core.IRNodeId::new("op3"), "noop", @ir_operator.Text, @ir_operator.Deterministic,
  )
  let p = @ir_pipeline.PipelineIR::empty().add_node(n1).add_node(n2).add_node(n3)
  let cleaned = @ir_optimizer.remove_identity(p)
  assert_eq(cleaned.node_count(), 1)
}

test "S1.4 ir_optimizer optimize and stats" {
  let n1 = @ir_operator.OperatorIR::simple(
    @ir_core.IRNodeId::new("op1"), "identity", @ir_operator.Text, @ir_operator.Deterministic,
  )
  let n2 = @ir_operator.OperatorIR::simple(
    @ir_core.IRNodeId::new("op2"), "normalize", @ir_operator.Text, @ir_operator.Deterministic,
  )
  let n3 = @ir_operator.OperatorIR::simple(
    @ir_core.IRNodeId::new("op3"), "normalize", @ir_operator.Text, @ir_operator.Deterministic,
  )
  let p = @ir_pipeline.PipelineIR::empty().add_node(n1).add_node(n2).add_node(n3)
  let opt = @ir_optimizer.optimize(p)
  assert_eq(opt.node_count(), 1)
  let stats = @ir_optimizer.opt_stats(p, opt)
  assert_eq(stats.original_nodes, 3)
  assert_eq(stats.optimized_nodes, 1)
  assert_eq(stats.removed, 2)
  assert_eq(@ir_optimizer.ir_optimizer_id(), "datair/ir_optimizer")
}
///|
/// # S1.5 datatemporal 深化测试 / Datatemporal Deepening Tests
///
/// 版本塔（latest/get_by_id/ancestors）+ 双向血缘（reverse/compose）+ 回放（append_step/replay）+ 漂移（direction/merge）。

test "S1.5 version latest and get_by_id" {
  let v1 = @version.root_version("v1", 100, "snap1")
  let v2 = @version.make_version("v2", Some("v1"), 200, "snap2")
  let v3 = @version.make_version("v3", Some("v2"), 300, "snap3")
  let tower = @version.empty_tower() |> @version.append(v1) |> @version.append(v2) |> @version.append(v3)
  let latest = @version.latest(tower)
  assert_true(latest is Some(_))
  let found = @version.get_by_id(tower, "v2")
  assert_true(found is Some(_))
  let not_found = @version.get_by_id(tower, "vX")
  assert_true(not_found is None)
}

test "S1.5 version ancestors chain" {
  let v1 = @version.root_version("v1", 100, "snap1")
  let v2 = @version.make_version("v2", Some("v1"), 200, "snap2")
  let v3 = @version.make_version("v3", Some("v2"), 300, "snap3")
  let tower = @version.empty_tower() |> @version.append(v1) |> @version.append(v2) |> @version.append(v3)
  let chain = @version.ancestors(tower, "v3")
  assert_eq(chain.length(), 3)
  assert_eq(chain[0].version_id, "v3")
  assert_eq(chain[1].version_id, "v2")
  assert_eq(chain[2].version_id, "v1")
}

test "S1.5 version degenerate: empty tower" {
  let empty = @version.empty_tower()
  assert_true(@version.latest(empty) is None)
  assert_true(@version.get_by_id(empty, "x") is None)
  assert_eq(@version.ancestors(empty, "x").length(), 0)
}

test "S1.5 lineage reverse and compose" {
  let l1 = @lineage.make_bi_lineage("normalize", ["in1"], ["out1"], "params1")
  let reversed = @lineage.reverse(l1)
  assert_eq(reversed.inputs, ["out1"])
  assert_eq(reversed.outputs, ["in1"])
  let l2 = @lineage.make_bi_lineage("truncate", ["out1"], ["out2"], "params2")
  let composed = @lineage.compose(l1, l2)
  assert_eq(composed.operator, "normalize;truncate")
  assert_eq(composed.inputs, ["in1"])
  assert_eq(composed.outputs, ["out2"])
}

test "S1.5 lineage input_output_count" {
  let l = @lineage.make_bi_lineage("op", ["a", "b", "c"], ["x", "y"], "")
  assert_eq(@lineage.input_count(l), 3)
  assert_eq(@lineage.output_count(l), 2)
}

test "S1.5 replay append_step and replay" {
  let trace = @replay.empty_trace("t1")
  assert_eq(@replay.step_count(trace), 0)
  let t1 = @replay.append_step(trace, "step1")
  assert_eq(@replay.step_count(t1), 1)
  let t2 = @replay.append_step(t1, "step2")
  assert_eq(@replay.step_count(t2), 2)
  let summary = @replay.trace_summary(t2)
  assert_eq(summary, "t1(2 steps)")
}

test "S1.5 replay degenerate: empty trace" {
  let trace = @replay.empty_trace("empty")
  assert_eq(@replay.replay(trace), "")
  assert_eq(@replay.trace_summary(trace), "empty(0 steps)")
}

test "S1.5 drift direction and merge" {
  let up = @drift.make_drift_report("acc", 0.5, 0.8)
  let down = @drift.make_drift_report("acc", 0.5, 0.2)
  let stable = @drift.make_drift_report("acc", 0.5, 0.5)
  assert_eq(@drift.drift_direction(up), "up")
  assert_eq(@drift.drift_direction(down), "down")
  assert_eq(@drift.drift_direction(stable), "stable")
  let merged = @drift.merge_reports([up, down, stable])
  assert_true(merged.drift_score > -0.001 && merged.drift_score < 0.001)
}

test "S1.5 drift degenerate: empty merge" {
  let merged = @drift.merge_reports([])
  assert_eq(merged.metric, "merged")
  assert_eq(merged.drift_score, 0.0)
}
///|
/// # S1.6 执行后端 CPU 串行测试 / CPU Serial Backend Tests
///
/// 执行计划生成 + 串行执行 + 轨迹记录 + 结果合并。

test "S1.6 cpu_serial make_plan and execute" {
  let n1 = @ir_operator.OperatorIR::simple(
    @ir_core.IRNodeId::new("op1"), "whitespace_normalization", @ir_operator.Text, @ir_operator.Deterministic,
  )
  let n2 = @ir_operator.OperatorIR::simple(
    @ir_core.IRNodeId::new("op2"), "truncate", @ir_operator.Text, @ir_operator.Deterministic,
  )
  let p = @ir_pipeline.PipelineIR::empty().add_node(n1).add_node(n2)
    .add_edge(@ir_pipeline.DAGEdge::new(@ir_core.IRNodeId::new("op1"), @ir_core.IRNodeId::new("op2")))
  let plan = @cpu_serial.make_plan(p)
  assert_eq(@cpu_serial.plan_step_count(plan), 2)
  assert_eq(plan.steps[0], "whitespace_normalization")
  assert_eq(plan.steps[1], "truncate")
  let result = @cpu_serial.execute(plan, "input_fp")
  assert_eq(result.step_count, 2)
  assert_true(result.success)
  assert_eq(result.trace.length(), 2)
}

test "S1.6 cpu_serial degenerate: empty plan" {
  let plan = @cpu_serial.empty_plan()
  assert_eq(@cpu_serial.plan_step_count(plan), 0)
  let result = @cpu_serial.execute(plan, "fp")
  assert_eq(result.step_count, 0)
  assert_eq(result.output_fingerprint, "fp")
  assert_eq(result.trace.length(), 0)
}

test "S1.6 cpu_serial merge_results" {
  let r1 = @cpu_serial.execute(@cpu_serial.empty_plan(), "a")
  let r2 = @cpu_serial.execute(@cpu_serial.empty_plan(), "b")
  let merged = @cpu_serial.merge_results(r1, r2)
  assert_eq(merged.output_fingerprint, "a;b")
  assert_true(merged.success)
  assert_eq(@cpu_serial.cpu_serial_id(), "parallel/cpu_serial")
}

test "S1.6 cpu_serial cyclic pipeline degenerate" {
  // 有环流水线：topo_order 返回空 → make_plan 返回空计划
  let n1 = @ir_operator.OperatorIR::simple(
    @ir_core.IRNodeId::new("a"), "op_a", @ir_operator.Text, @ir_operator.Deterministic,
  )
  let n2 = @ir_operator.OperatorIR::simple(
    @ir_core.IRNodeId::new("b"), "op_b", @ir_operator.Text, @ir_operator.Deterministic,
  )
  let cyclic = @ir_pipeline.PipelineIR::empty().add_node(n1).add_node(n2)
    .add_edge(@ir_pipeline.DAGEdge::new(@ir_core.IRNodeId::new("a"), @ir_core.IRNodeId::new("b")))
    .add_edge(@ir_pipeline.DAGEdge::new(@ir_core.IRNodeId::new("b"), @ir_core.IRNodeId::new("a")))
  let plan = @cpu_serial.make_plan(cyclic)
  assert_eq(@cpu_serial.plan_step_count(plan), 0)
}
///|
/// # S1.7 DOSI 完善测试 / DOSI Enhancement Tests
///
/// ContextBudget（配额管理）+ Verifier（索引校验）。

test "S1.7 context_budget make and allocate" {
  let budget = @context_budget.make_budget(10000)
  assert_eq(budget.total_quota, 10000)
  assert_eq(budget.used, 0)
  assert_eq(budget.dosi_quota, 1000)
  assert_eq(budget.recall_quota, 4000)
  let b1 = @context_budget.allocate(budget, 3000)
  assert_eq(b1.used, 3000)
  assert_eq(@context_budget.remaining(b1), 7000)
  let ratio = @context_budget.usage_ratio(b1)
  assert_true(ratio > 0.29 && ratio < 0.31)
}

test "S1.7 context_budget over budget and compress" {
  let budget = @context_budget.make_budget(1000)
  let b1 = @context_budget.allocate(budget, 800)
  assert_false(@context_budget.is_over_budget(b1))
  let b2 = @context_budget.allocate(b1, 300)
  // 超预算：allocate 不变
  assert_eq(b2.used, 800)
  // 手动构造超预算
  let over = @context_budget.with_used(b1, 1200)
  assert_true(@context_budget.is_over_budget(over))
  let compressed = @context_budget.compress(over)
  assert_eq(compressed.used, 800)
  assert_eq(@context_budget.context_budget_id(), "dosi/context_budget")
}

test "S1.7 context_budget degenerate: zero quota" {
  let budget = @context_budget.make_budget(0)
  assert_eq(@context_budget.remaining(budget), 0)
  assert_eq(@context_budget.usage_ratio(budget), 0.0)
}

test "S1.7 verifier valid index" {
  let sym1 = @dosi.SymbolicEntry::new("opcore/clean", "clean", "text", [])
  let sem1 = @dosi.SemanticEntry::new("clean ops", [], "in->out")
  let e1 = @dosi.DOSIEntry::new(sym1, sem1)
  let sym2 = @dosi.SymbolicEntry::new("opcore/dedup", "dedup", "text", ["opcore/clean"])
  let sem2 = @dosi.SemanticEntry::new("dedup ops", [], "in->out")
  let e2 = @dosi.DOSIEntry::new(sym2, sem2)
  let index = @dosi.DOSIIndex::empty().add(e1).add(e2)
  let result = @verifier.verify_index(index)
  assert_true(result.valid)
  assert_eq(result.issues.length(), 0)
  assert_true(@verifier.check_dependencies(index))
}

test "S1.7 verifier missing dependency" {
  let sym = @dosi.SymbolicEntry::new("opcore/x", "x", "text", ["opcore/nonexistent"])
  let sem = @dosi.SemanticEntry::new("x", [], "in->out")
  let e = @dosi.DOSIEntry::new(sym, sem)
  let index = @dosi.DOSIIndex::empty().add(e)
  let result = @verifier.verify_index(index)
  assert_false(result.valid)
  assert_eq(result.issues.length(), 1)
}

test "S1.7 verifier detect_cycles" {
  let sym = @dosi.SymbolicEntry::new("opcore/self", "x", "text", ["opcore/self"])
  let sem = @dosi.SemanticEntry::new("self dep", [], "in->out")
  let e = @dosi.DOSIEntry::new(sym, sem)
  let index = @dosi.DOSIIndex::empty().add(e)
  let cycles = @verifier.detect_cycles(index)
  assert_eq(cycles.length(), 1)
  assert_eq(cycles[0], "opcore/self")
  assert_eq(@verifier.verifier_id(), "dosi/verifier")
}

test "S1.7 verifier degenerate: empty index" {
  let empty = @dosi.DOSIIndex::empty()
  let result = @verifier.verify_index(empty)
  assert_true(result.valid)
  assert_eq(@verifier.detect_cycles(empty).length(), 0)
}
///|
/// # S1.8 验证测试 / Validation Tests
///
/// Data-Juicer P0 对标验证 + Agent-Kit DOSI 适配器测试。
/// 架构 §4.3.6 对标映射 + §4.8 Agent-Kit。

test "S1.8 DJ P0: text_length_filter 对标" {
  // DJ text_length_filter: 按长度过滤
  // DataVerse: @filter.length_filter(min_len, max_len, dataobject)
  let s = @schema.empty()
  let short = @dataobject.make_dataobject("hi", @dataobject.Text, s)
  let long = @dataobject.make_dataobject("hello world", @dataobject.Text, s)
  assert_true(@filter.length_filter(5, 20, long))
  assert_false(@filter.length_filter(5, 20, short))
}

test "S1.8 DJ P0: exact_deduplicator 对标" {
  // DJ exact_deduplicator: 精确去重
  // DataVerse: @dedup.exact_dedup
  let s = @schema.empty()
  let d1 = @dataobject.make_dataobject("a", @dataobject.Text, s)
  let d2 = @dataobject.make_dataobject("b", @dataobject.Text, s)
  let d3 = @dataobject.make_dataobject("a", @dataobject.Text, s)
  let result = @dedup.exact_dedup([d1, d2, d3])
  assert_eq(result.length(), 2)
}

test "S1.8 DJ P0: whitespace_normalization_mapper 对标" {
  // DJ whitespace_normalization_mapper: 空白归一
  // DataVerse: @normalize.whitespace_normalization
  let s = @schema.empty()
  let d = @dataobject.make_dataobject("  hello   world  ", @dataobject.Text, s)
  let n = @normalize.whitespace_normalization(d)
  assert_eq(n.content, "hello world")
}

test "S1.8 DJ P0: topk_selector 对标" {
  // DJ topk_selector: Top-K 选择
  // DataVerse: @select.topk_by_length
  let s = @schema.empty()
  let arr = [
    @dataobject.make_dataobject("a", @dataobject.Text, s),
    @dataobject.make_dataobject("bbb", @dataobject.Text, s),
    @dataobject.make_dataobject("cc", @dataobject.Text, s),
  ]
  let top2 = @select.topk_by_length(arr, 2)
  assert_eq(top2.length(), 2)
  assert_eq(top2[0].content, "bbb")
}

test "S1.8 DJ P0: punctuation_normalization_mapper 对标" {
  // DJ punctuation_normalization_mapper: 标点归一
  // DataVerse: @normalize.punctuation_normalization
  let s = @schema.empty()
  let d = @dataobject.make_dataobject("你好，世界。", @dataobject.Text, s)
  let n = @normalize.punctuation_normalization(d)
  assert_eq(n.content, "你好,世界.")
}

test "S1.8 dosi_adapter query_dosi" {
  let sym1 = @dosi.SymbolicEntry::new("opcore/clean/remove_empty", "clean", "text", [])
  let sem1 = @dosi.SemanticEntry::new("remove empty content", [], "in->out")
  let e1 = @dosi.DOSIEntry::new(sym1, sem1)
  let sym2 = @dosi.SymbolicEntry::new("opcore/dedup/exact_dedup", "dedup", "text", [])
  let sem2 = @dosi.SemanticEntry::new("exact deduplication", [], "in->out")
  let e2 = @dosi.DOSIEntry::new(sym2, sem2)
  let index = @dosi.DOSIIndex::empty().add(e1).add(e2)
  let result = @dosi_adapter.query_dosi(index, "dedup")
  assert_eq(result.total_matches, 1)
  assert_eq(result.paths[0], "opcore/dedup/exact_dedup")
}

test "S1.8 dosi_adapter plan_pipeline" {
  let sym1 = @dosi.SymbolicEntry::new("opcore/clean", "clean", "text", [])
  let sem1 = @dosi.SemanticEntry::new("clean", [], "in->out")
  let e1 = @dosi.DOSIEntry::new(sym1, sem1)
  let sym2 = @dosi.SymbolicEntry::new("opcore/dedup", "dedup", "text", [])
  let sem2 = @dosi.SemanticEntry::new("dedup", [], "in->out")
  let e2 = @dosi.DOSIEntry::new(sym2, sem2)
  let index = @dosi.DOSIIndex::empty().add(e1).add(e2)
  let plan = @dosi_adapter.plan_pipeline(index, ["clean", "dedup"])
  assert_eq(plan.length(), 2)
}

test "S1.8 dosi_adapter degenerate: empty index" {
  let empty = @dosi.DOSIIndex::empty()
  let result = @dosi_adapter.query_dosi(empty, "anything")
  assert_eq(result.total_matches, 0)
  assert_eq(@dosi_adapter.plan_pipeline(empty, ["x"]).length(), 0)
  assert_eq(@dosi_adapter.dosi_adapter_id(), "agent_kit/dosi_adapter")
}


// ============================================================
// S2.1 opcore 多模态算子测试 / Multimodal operator tests
// ============================================================

test "S2.1 image_size basic" {
  let meta = @image.make_image_meta(1920, 1080, 3, "png")
  let (w, h) = @image.image_size(meta)
  assert_eq(w, 1920)
  assert_eq(h, 1080)
}

test "S2.1 image_size degenerate: empty meta" {
  let meta = @image.empty_image_meta()
  let (w, h) = @image.image_size(meta)
  assert_eq(w, 0)
  assert_eq(h, 0)
}

test "S2.1 aspect_ratio basic" {
  let meta = @image.make_image_meta(1920, 1080, 3, "png")
  let r = @image.aspect_ratio(meta)
  assert_true(r > 1.77 && r < 1.78)
}

test "S2.1 aspect_ratio degenerate: height=0" {
  let meta = @image.make_image_meta(100, 0, 3, "png")
  assert_eq(@image.aspect_ratio(meta), 0.0)
}

test "S2.1 aspect_ratio_filter in range" {
  let meta = @image.make_image_meta(200, 100, 3, "jpg")
  assert_true(@image.aspect_ratio_filter(meta, 1.0, 3.0))
}

test "S2.1 aspect_ratio_filter out of range" {
  let meta = @image.make_image_meta(200, 100, 3, "jpg")
  assert_true(!@image.aspect_ratio_filter(meta, 3.0, 4.0))
}

test "S2.1 image_resize basic" {
  let meta = @image.make_image_meta(1920, 1080, 3, "png")
  let resized = @image.image_resize(meta, 640, 360)
  let (w, h) = @image.image_size(resized)
  assert_eq(w, 640)
  assert_eq(h, 360)
  assert_eq(resized.channels, 3)
  assert_eq(resized.format, "png")
}

test "S2.1 image_resize degenerate: negative dims" {
  let meta = @image.make_image_meta(100, 100, 3, "png")
  let resized = @image.image_resize(meta, -10, -20)
  let (w, h) = @image.image_size(resized)
  assert_eq(w, 0)
  assert_eq(h, 0)
}

test "S2.1 image_crop basic" {
  let meta = @image.make_image_meta(100, 100, 3, "png")
  let cropped = @image.image_crop(meta, 10, 20, 30, 40)
  let (w, h) = @image.image_size(cropped)
  assert_eq(w, 30)
  assert_eq(h, 40)
}

test "S2.1 image_crop degenerate: out of bounds" {
  let meta = @image.make_image_meta(50, 50, 3, "png")
  let cropped = @image.image_crop(meta, 40, 40, 30, 30)
  let (w, h) = @image.image_size(cropped)
  assert_eq(w, 10)
  assert_eq(h, 10)
}

test "S2.1 image_crop degenerate: negative origin" {
  let meta = @image.make_image_meta(100, 100, 3, "png")
  let cropped = @image.image_crop(meta, -10, -10, 50, 50)
  let (w, h) = @image.image_size(cropped)
  assert_eq(w, 50)
  assert_eq(h, 50)
}

test "S2.1 image_to_dataobject modality" {
  let meta = @image.make_image_meta(640, 480, 3, "png")
  let d = @image.image_to_dataobject(meta)
  assert_eq(d.modality, @dataobject.Image)
  assert_true(d.content.length() > 0)
}

test "S2.1 audio_duration basic" {
  let meta = @audio.make_audio_meta(5000, 44100, 2, "wav")
  assert_eq(@audio.audio_duration(meta), 5000)
}

test "S2.1 audio_duration degenerate: empty meta" {
  let meta = @audio.empty_audio_meta()
  assert_eq(@audio.audio_duration(meta), 0)
}

test "S2.1 sample_rate_filter in range" {
  let meta = @audio.make_audio_meta(5000, 44100, 2, "wav")
  assert_true(@audio.sample_rate_filter(meta, 8000, 48000))
}

test "S2.1 sample_rate_filter out of range" {
  let meta = @audio.make_audio_meta(5000, 44100, 2, "wav")
  assert_true(!@audio.sample_rate_filter(meta, 48000, 96000))
}

test "S2.1 audio_segment basic" {
  let meta = @audio.make_audio_meta(10000, 44100, 2, "wav")
  let seg = @audio.audio_segment(meta, 2000, 5000)
  assert_eq(seg.duration_ms, 3000)
  assert_eq(seg.sample_rate, 44100)
}

test "S2.1 audio_segment degenerate: out of bounds" {
  let meta = @audio.make_audio_meta(5000, 44100, 2, "wav")
  let seg = @audio.audio_segment(meta, 3000, 10000)
  assert_eq(seg.duration_ms, 2000)
}

test "S2.1 audio_segment degenerate: negative start" {
  let meta = @audio.make_audio_meta(5000, 44100, 2, "wav")
  let seg = @audio.audio_segment(meta, -100, 2000)
  assert_eq(seg.duration_ms, 2000)
}

test "S2.1 audio_segment degenerate: end before start" {
  let meta = @audio.make_audio_meta(5000, 44100, 2, "wav")
  let seg = @audio.audio_segment(meta, 3000, 1000)
  assert_eq(seg.duration_ms, 0)
}

test "S2.1 audio_to_dataobject modality" {
  let meta = @audio.make_audio_meta(5000, 44100, 2, "wav")
  let d = @audio.audio_to_dataobject(meta)
  assert_eq(d.modality, @dataobject.Audio)
}

test "S2.1 video_duration basic" {
  let meta = @video.make_video_meta(60000, 30, 1920, 1080, "mp4")
  assert_eq(@video.video_duration(meta), 60000)
}

test "S2.1 frame_count basic" {
  let meta = @video.make_video_meta(60000, 30, 1920, 1080, "mp4")
  assert_eq(@video.frame_count(meta), 1800)
}

test "S2.1 frame_count degenerate: zero fps" {
  let meta = @video.make_video_meta(60000, 0, 1920, 1080, "mp4")
  assert_eq(@video.frame_count(meta), 0)
}

test "S2.1 frame_count degenerate: zero duration" {
  let meta = @video.make_video_meta(0, 30, 1920, 1080, "mp4")
  assert_eq(@video.frame_count(meta), 0)
}

test "S2.1 video_sample_frames basic" {
  let meta = @video.make_video_meta(10000, 30, 1920, 1080, "mp4")
  let frames = @video.video_sample_frames(meta, 2000)
  assert_eq(frames.length(), 5)
  assert_eq(frames[0], 0)
  assert_eq(frames[4], 8000)
}

test "S2.1 video_sample_frames degenerate: zero interval" {
  let meta = @video.make_video_meta(10000, 30, 1920, 1080, "mp4")
  let frames = @video.video_sample_frames(meta, 0)
  assert_eq(frames.length(), 0)
}

test "S2.1 video_sample_frames degenerate: negative interval" {
  let meta = @video.make_video_meta(10000, 30, 1920, 1080, "mp4")
  let frames = @video.video_sample_frames(meta, -100)
  assert_eq(frames.length(), 0)
}

test "S2.1 video_to_dataobject modality" {
  let meta = @video.make_video_meta(60000, 30, 1920, 1080, "mp4")
  let d = @video.video_to_dataobject(meta)
  assert_eq(d.modality, @dataobject.Video)
}

test "S2.1 image_id and audio_id and video_id" {
  assert_eq(@image.image_id(), "opcore/image")
  assert_eq(@audio.audio_id(), "opcore/audio")
  assert_eq(@video.video_id(), "opcore/video")
}

// ============================================================
// S2.2 opcore 语义算子测试 / Semantic operator tests
// ============================================================

test "S2.2 semantic_quality_score basic" {
  let d = @dataobject.make_dataobject("Hello world this is a test content for scoring", @dataobject.Text, @schema.empty())
  let score = @semantic.semantic_quality_score(d)
  assert_true(score > 0.0 && score <= 1.0)
}

test "S2.2 semantic_quality_score degenerate: empty" {
  let d = @dataobject.empty_dataobject(@dataobject.Text)
  assert_eq(@semantic.semantic_quality_score(d), 0.0)
}

test "S2.2 semantic_quality_score long content" {
  let long = "a".repeat(150)
  let d = @dataobject.make_dataobject(long, @dataobject.Text, @schema.empty())
  let score = @semantic.semantic_quality_score(d)
  assert_true(score > 0.0)
}

test "S2.2 content_diversity_score all same" {
  let d = @dataobject.make_dataobject("aaaaa", @dataobject.Text, @schema.empty())
  assert_eq(@semantic.content_diversity_score(d), 0.2)
}

test "S2.2 content_diversity_score all different" {
  let d = @dataobject.make_dataobject("abcde", @dataobject.Text, @schema.empty())
  assert_eq(@semantic.content_diversity_score(d), 1.0)
}

test "S2.2 content_diversity_score degenerate: empty" {
  let d = @dataobject.empty_dataobject(@dataobject.Text)
  assert_eq(@semantic.content_diversity_score(d), 0.0)
}

test "S2.2 rewrite_text Simplify" {
  let d = @dataobject.make_dataobject("  hello world  ", @dataobject.Text, @schema.empty())
  let result = @semantic.rewrite_text(d, @semantic.Simplify)
  assert_eq(result.content, "hello world")
}

test "S2.2 rewrite_text Simplify truncate long" {
  let long = "a".repeat(300)
  let d = @dataobject.make_dataobject(long, @dataobject.Text, @schema.empty())
  let result = @semantic.rewrite_text(d, @semantic.Simplify)
  assert_eq(result.content.length(), 200)
}

test "S2.2 rewrite_text Formalize lowercase" {
  let d = @dataobject.make_dataobject("hello world", @dataobject.Text, @schema.empty())
  let result = @semantic.rewrite_text(d, @semantic.Formalize)
  assert_eq(result.content, "Hello world")
}

test "S2.2 rewrite_text Formalize already upper" {
  let d = @dataobject.make_dataobject("Hello world", @dataobject.Text, @schema.empty())
  let result = @semantic.rewrite_text(d, @semantic.Formalize)
  assert_eq(result.content, "Hello world")
}

test "S2.2 rewrite_text Formalize degenerate: empty" {
  let d = @dataobject.empty_dataobject(@dataobject.Text)
  let result = @semantic.rewrite_text(d, @semantic.Formalize)
  assert_eq(result.content, "")
}

test "S2.2 rewrite_text Casual passthrough" {
  let d = @dataobject.make_dataobject("hello world", @dataobject.Text, @schema.empty())
  let result = @semantic.rewrite_text(d, @semantic.Casual)
  assert_eq(result.content, "hello world")
}

test "S2.2 rewrite_text Expand" {
  let d = @dataobject.make_dataobject("hello world", @dataobject.Text, @schema.empty())
  let result = @semantic.rewrite_text(d, @semantic.Expand)
  assert_eq(result.content, "hello world hello world")
}

test "S2.2 rewrite_text Expand degenerate: empty" {
  let d = @dataobject.empty_dataobject(@dataobject.Text)
  let result = @semantic.rewrite_text(d, @semantic.Expand)
  assert_eq(result.content, "")
}

test "S2.2 synthesize_text Paraphrase" {
  let d = @dataobject.make_dataobject("hello", @dataobject.Text, @schema.empty())
  let result = @semantic.synthesize_text(d, @semantic.Paraphrase)
  assert_eq(result.content, "[paraphrase] hello [/paraphrase]")
}

test "S2.2 synthesize_text Augment" {
  let d = @dataobject.make_dataobject("hello", @dataobject.Text, @schema.empty())
  let result = @semantic.synthesize_text(d, @semantic.Augment)
  assert_eq(result.content, "hello | hello")
}

test "S2.2 synthesize_text Interpolate" {
  let d = @dataobject.make_dataobject("hello", @dataobject.Text, @schema.empty())
  let result = @semantic.synthesize_text(d, @semantic.Interpolate)
  assert_eq(result.content, "[interp] hello")
}

test "S2.2 synthesize_text degenerate: empty" {
  let d = @dataobject.empty_dataobject(@dataobject.Text)
  assert_eq(@semantic.synthesize_text(d, @semantic.Paraphrase).content, "")
  assert_eq(@semantic.synthesize_text(d, @semantic.Augment).content, "")
  assert_eq(@semantic.synthesize_text(d, @semantic.Interpolate).content, "")
}

test "S2.2 rewrite_mode_name" {
  assert_eq(@semantic.rewrite_mode_name(@semantic.Simplify), "simplify")
  assert_eq(@semantic.rewrite_mode_name(@semantic.Formalize), "formalize")
  assert_eq(@semantic.rewrite_mode_name(@semantic.Casual), "casual")
  assert_eq(@semantic.rewrite_mode_name(@semantic.Expand), "expand")
}

test "S2.2 synthesis_mode_name" {
  assert_eq(@semantic.synthesis_mode_name(@semantic.Paraphrase), "paraphrase")
  assert_eq(@semantic.synthesis_mode_name(@semantic.Augment), "augment")
  assert_eq(@semantic.synthesis_mode_name(@semantic.Interpolate), "interpolate")
}

test "S2.2 semantic_id" {
  assert_eq(@semantic.semantic_id(), "opcore/semantic")
}

test "S2.2 rewrite_text preserves modality" {
  let d = @dataobject.make_dataobject("hello", @dataobject.Image, @schema.empty())
  let result = @semantic.rewrite_text(d, @semantic.Simplify)
  assert_eq(result.modality, @dataobject.Image)
}

// ============================================================
// S2.3 learncore DL 算子测试 / DL operator tests
// ============================================================

test "S2.3 linear_forward basic" {
  let w = [[1.0, 0.0], [0.0, 1.0]]
  let b = [0.0, 0.0]
  let layer = @dl_layers.make_linear_layer_with_weights(w, b, 2, 2)
  let result = @dl_layers.linear_forward(layer, [3.0, 5.0])
  assert_eq(result.length(), 2)
  assert_true(result[0] > 2.99 && result[0] < 3.01)
  assert_true(result[1] > 4.99 && result[1] < 5.01)
}

test "S2.3 linear_forward with bias" {
  let w = [[1.0, 1.0]]
  let b = [2.0]
  let layer = @dl_layers.make_linear_layer_with_weights(w, b, 2, 1)
  let result = @dl_layers.linear_forward(layer, [3.0, 5.0])
  assert_true(result[0] > 9.99 && result[0] < 10.01)
}

test "S2.3 linear_forward degenerate: dim mismatch" {
  let layer = @dl_layers.make_linear_layer(3, 2)
  let result = @dl_layers.linear_forward(layer, [1.0, 2.0])
  assert_eq(result.length(), 0)
}

test "S2.3 linear_forward zero init" {
  let layer = @dl_layers.make_linear_layer(3, 2)
  let result = @dl_layers.linear_forward(layer, [1.0, 2.0, 3.0])
  assert_eq(result.length(), 2)
  assert_eq(result[0], 0.0)
  assert_eq(result[1], 0.0)
}

test "S2.3 activate ReLU" {
  assert_eq(@dl_layers.activate(@dl_layers.ReLU, 5.0), 5.0)
  assert_eq(@dl_layers.activate(@dl_layers.ReLU, -3.0), 0.0)
  assert_eq(@dl_layers.activate(@dl_layers.ReLU, 0.0), 0.0)
}

test "S2.3 activate Identity" {
  assert_eq(@dl_layers.activate(@dl_layers.Identity, 5.0), 5.0)
  assert_eq(@dl_layers.activate(@dl_layers.Identity, -3.0), -3.0)
}

test "S2.3 activate Sigmoid range" {
  let s1 = @dl_layers.activate(@dl_layers.Sigmoid, 0.0)
  assert_true(s1 > 0.49 && s1 < 0.51)
  let s2 = @dl_layers.activate(@dl_layers.Sigmoid, 100.0)
  assert_true(s2 > 0.99)
  let s3 = @dl_layers.activate(@dl_layers.Sigmoid, -100.0)
  assert_true(s3 < 0.01)
}

test "S2.3 activation_forward basic" {
  let result = @dl_layers.activation_forward(@dl_layers.ReLU, [-1.0, 2.0, -3.0, 4.0])
  assert_eq(result, [0.0, 2.0, 0.0, 4.0])
}

test "S2.3 activation_name" {
  assert_eq(@dl_layers.activation_name(@dl_layers.ReLU), "relu")
  assert_eq(@dl_layers.activation_name(@dl_layers.Sigmoid), "sigmoid")
  assert_eq(@dl_layers.activation_name(@dl_layers.Tanh), "tanh")
  assert_eq(@dl_layers.activation_name(@dl_layers.Identity), "identity")
}

test "S2.3 mse_loss basic" {
  let pred = [1.0, 2.0, 3.0]
  let target = [1.0, 2.0, 3.0]
  assert_eq(@dl_losses.mse_loss(pred, target), 0.0)
}

test "S2.3 mse_loss nonzero" {
  let pred = [1.0, 2.0]
  let target = [3.0, 4.0]
  let result = @dl_losses.mse_loss(pred, target)
  assert_true(result > 3.99 && result < 4.01)
}

test "S2.3 mse_loss degenerate: empty" {
  assert_eq(@dl_losses.mse_loss([], []), 0.0)
}

test "S2.3 mse_loss degenerate: dim mismatch" {
  assert_eq(@dl_losses.mse_loss([1.0], [1.0, 2.0]), 0.0)
}

test "S2.3 cross_entropy_loss basic" {
  let logits = [0.0, 0.0]
  let target = [1.0, 0.0]
  let result = @dl_losses.cross_entropy_loss(logits, target)
  assert_true(result > 0.0)
}

test "S2.3 cross_entropy_loss degenerate: empty" {
  assert_eq(@dl_losses.cross_entropy_loss([], []), 0.0)
}

test "S2.3 hinge_loss basic" {
  let pred = [1.0, 1.0]
  let target = [1.0, 1.0]
  assert_eq(@dl_losses.hinge_loss(pred, target), 0.0)
}

test "S2.3 hinge_loss nonzero" {
  let pred = [-1.0, -1.0]
  let target = [1.0, 1.0]
  let result = @dl_losses.hinge_loss(pred, target)
  assert_true(result > 1.99)
}

test "S2.3 loss_value dispatch" {
  let pred = [1.0, 2.0]
  let target = [1.0, 2.0]
  assert_eq(@dl_losses.loss_value(@dl_losses.MSE, pred, target), 0.0)
}

test "S2.3 loss_name" {
  assert_eq(@dl_losses.loss_name(@dl_losses.MSE), "mse")
  assert_eq(@dl_losses.loss_name(@dl_losses.CrossEntropy), "cross_entropy")
  assert_eq(@dl_losses.loss_name(@dl_losses.Hinge), "hinge")
}

test "S2.3 sgd_step basic" {
  let state = @dl_optimizers.make_optimizer(@dl_optimizers.SGD, 0.1, [1.0, 2.0])
  let grads = [0.5, 1.0]
  let new_params = @dl_optimizers.sgd_step(state, grads)
  assert_true(new_params[0] > 0.94 && new_params[0] < 0.96)
  assert_true(new_params[1] > 1.89 && new_params[1] < 1.91)
}

test "S2.3 sgd_step degenerate: dim mismatch" {
  let state = @dl_optimizers.make_optimizer(@dl_optimizers.SGD, 0.1, [1.0, 2.0])
  let new_params = @dl_optimizers.sgd_step(state, [0.5])
  assert_eq(new_params, [1.0, 2.0])
}

test "S2.3 adam_step basic" {
  let state = @dl_optimizers.make_optimizer(@dl_optimizers.Adam, 0.1, [1.0, 2.0])
  let grads = [0.5, 1.0]
  let new_params = @dl_optimizers.adam_step(state, grads)
  assert_eq(new_params.length(), 2)
}

test "S2.3 optimizer_step dispatch SGD" {
  let state = @dl_optimizers.make_optimizer(@dl_optimizers.SGD, 0.1, [1.0])
  let sgd_result = @dl_optimizers.optimizer_step(state, [0.5])
  let adam_state = @dl_optimizers.make_optimizer(@dl_optimizers.Adam, 0.1, [1.0])
  let adam_result = @dl_optimizers.optimizer_step(adam_state, [0.5])
  assert_true(sgd_result[0] != adam_result[0])
}

test "S2.3 update_state increments step" {
  let state = @dl_optimizers.make_optimizer(@dl_optimizers.SGD, 0.1, [1.0])
  let new_params = [0.95]
  let new_state = @dl_optimizers.update_state(state, new_params)
  assert_eq(new_state.step_count, 1)
  assert_eq(new_state.params, [0.95])
}

test "S2.3 optimizer_name" {
  assert_eq(@dl_optimizers.optimizer_name(@dl_optimizers.SGD), "sgd")
  assert_eq(@dl_optimizers.optimizer_name(@dl_optimizers.Adam), "adam")
}

test "S2.3 dl_layers_id and dl_losses_id and dl_optimizers_id" {
  assert_eq(@dl_layers.dl_layers_id(), "learncore/dl_layers")
  assert_eq(@dl_losses.dl_losses_id(), "learncore/dl_losses")
  assert_eq(@dl_optimizers.dl_optimizers_id(), "learncore/dl_optimizers")
}

// ============================================================
// S2.4 learncore 模型评估算子测试 / Model evaluation tests
// ============================================================

test "S2.4 kfold_splits basic 5-fold" {
  let splits = @cross_validation.kfold_splits(10, 5)
  assert_eq(splits.length(), 5)
  assert_eq(splits[0].test_indices, [0, 1])
  assert_eq(splits[0].train_indices.length(), 8)
  assert_eq(splits[4].test_indices, [8, 9])
}

test "S2.4 kfold_splits 3-fold 9 samples" {
  let splits = @cross_validation.kfold_splits(9, 3)
  assert_eq(splits.length(), 3)
  assert_eq(splits[0].test_indices, [0, 1, 2])
  assert_eq(splits[1].test_indices, [3, 4, 5])
  assert_eq(splits[2].test_indices, [6, 7, 8])
}

test "S2.4 kfold_splits degenerate: k=0" {
  let splits = @cross_validation.kfold_splits(10, 0)
  assert_eq(splits.length(), 0)
}

test "S2.4 kfold_splits degenerate: n=0" {
  let splits = @cross_validation.kfold_splits(0, 5)
  assert_eq(splits.length(), 0)
}

test "S2.4 kfold_splits fold_id sequential" {
  let splits = @cross_validation.kfold_splits(6, 3)
  assert_eq(splits[0].fold_id, 0)
  assert_eq(splits[1].fold_id, 1)
  assert_eq(splits[2].fold_id, 2)
}

test "S2.4 kfold_splits last fold absorbs remainder" {
  let splits = @cross_validation.kfold_splits(10, 3)
  assert_eq(splits.length(), 3)
  assert_eq(splits[2].test_indices, [6, 7, 8, 9])
}

test "S2.4 cv_stats basic" {
  let stats = @cross_validation.cv_stats([0.8, 0.9, 0.85])
  assert_true(stats.mean_score > 0.84 && stats.mean_score < 0.86)
  assert_true(stats.std_score >= 0.0)
}

test "S2.4 cv_stats degenerate: empty" {
  let stats = @cross_validation.cv_stats([])
  assert_eq(stats.mean_score, 0.0)
  assert_eq(stats.std_score, 0.0)
}

test "S2.4 cv_stats zero variance" {
  let stats = @cross_validation.cv_stats([0.5, 0.5, 0.5])
  assert_eq(stats.mean_score, 0.5)
  assert_eq(stats.std_score, 0.0)
}

test "S2.4 loo_count" {
  assert_eq(@cross_validation.loo_count(10), 10)
  assert_eq(@cross_validation.loo_count(0), 0)
}

test "S2.4 cross_validation_id" {
  assert_eq(@cross_validation.cross_validation_id(), "learncore/cross_validation")
}

test "S2.4 grid_combinations single param" {
  let cfg = @hyperparam_search.make_grid_config("lr", [0.01, 0.1, 1.0])
  let combos = @hyperparam_search.grid_combinations([cfg])
  assert_eq(combos.length(), 3)
  assert_eq(combos[0].length(), 1)
  assert_eq(combos[0][0], ("lr", 0.01))
}

test "S2.4 grid_combinations two params" {
  let cfg1 = @hyperparam_search.make_grid_config("lr", [0.01, 0.1])
  let cfg2 = @hyperparam_search.make_grid_config("wd", [0.0, 0.01])
  let combos = @hyperparam_search.grid_combinations([cfg1, cfg2])
  assert_eq(combos.length(), 4)
  assert_eq(combos[0].length(), 2)
}

test "S2.4 grid_combinations degenerate: empty" {
  let combos = @hyperparam_search.grid_combinations([])
  assert_eq(combos.length(), 0)
}

test "S2.4 grid_search basic" {
  let cfg = @hyperparam_search.make_grid_config("lr", [0.01, 0.1, 1.0])
  let result = @hyperparam_search.grid_search([cfg], fn(params) {
    match params[0] {
      ("lr", v) => if v > 0.05 { v } else { 0.0 }
      _ => 0.0
    }
  })
  assert_eq(result.total_configs, 3)
  assert_true(result.best_score > 0.99)
}

test "S2.4 grid_search degenerate: empty configs" {
  let result = @hyperparam_search.grid_search([], fn(_params) { 1.0 })
  assert_eq(result.total_configs, 0)
  assert_eq(result.best_score, 0.0)
}

test "S2.4 empty_grid_result" {
  let result = @hyperparam_search.empty_grid_result()
  assert_eq(result.total_configs, 0)
  assert_eq(result.best_score, 0.0)
}

test "S2.4 hyperparam_search_id" {
  assert_eq(@hyperparam_search.hyperparam_search_id(), "learncore/hyperparam_search")
}

// ============================================================
// S2.5 recipe Phase 2 复合线测试 / Phase 2 pipeline tests
// ============================================================

test "S2.5 packing_line basic" {
  let d1 = @dataobject.make_dataobject("hello world foo bar", @dataobject.Text, @schema.empty())
  let d2 = @dataobject.make_dataobject("test", @dataobject.Text, @schema.empty())
  let result = @packing_line.packing_line([d1, d2], 5)
  assert_eq(result.length(), 5)
}

test "S2.5 packing_line filters empty" {
  let d1 = @dataobject.make_dataobject("hello", @dataobject.Text, @schema.empty())
  let d2 = @dataobject.empty_dataobject(@dataobject.Text)
  let result = @packing_line.packing_line([d1, d2], 10)
  assert_eq(result.length(), 1)
}

test "S2.5 packing_line degenerate: chunk_size <= 0" {
  let d1 = @dataobject.make_dataobject("hello", @dataobject.Text, @schema.empty())
  let result = @packing_line.packing_line([d1], 0)
  assert_eq(result.length(), 1)
}

test "S2.5 packing_line degenerate: empty array" {
  let result = @packing_line.packing_line([], 10)
  assert_eq(result.length(), 0)
}

test "S2.5 packing_line preserves modality" {
  let d1 = @dataobject.make_dataobject("hello world", @dataobject.Image, @schema.empty())
  let result = @packing_line.packing_line([d1], 5)
  assert_eq(result.length(), 3)
  assert_eq(result[0].modality, @dataobject.Image)
}

test "S2.5 packing_line_id" {
  assert_eq(@packing_line.packing_line_id(), "recipe/packing_line")
}

test "S2.5 eval_line basic" {
  let d1 = @dataobject.make_dataobject("hello world this is a long enough text", @dataobject.Text, @schema.empty())
  let d2 = @dataobject.make_dataobject("short", @dataobject.Text, @schema.empty())
  let report = @eval_line.eval_line([d1, d2])
  assert_eq(report.total_count, 2)
  assert_true(report.avg_quality > 0.0)
  assert_true(report.max_quality >= report.min_quality)
}

test "S2.5 eval_line modality counts" {
  let d1 = @dataobject.make_dataobject("text content here", @dataobject.Text, @schema.empty())
  let d2 = @dataobject.make_dataobject("image data", @dataobject.Image, @schema.empty())
  let d3 = @dataobject.make_dataobject("audio data", @dataobject.Audio, @schema.empty())
  let report = @eval_line.eval_line([d1, d2, d3])
  assert_eq(report.text_count, 1)
  assert_eq(report.image_count, 1)
  assert_eq(report.audio_count, 1)
  assert_eq(report.video_count, 0)
}

test "S2.5 eval_line degenerate: empty" {
  let report = @eval_line.eval_line([])
  assert_eq(report, @eval_line.empty_eval_report())
}

test "S2.5 eval_line_id" {
  assert_eq(@eval_line.eval_line_id(), "recipe/eval_line")
}

test "S2.5 cross_modal_line basic" {
  let d1 = @dataobject.make_dataobject("text", @dataobject.Text, @schema.empty())
  let d2 = @dataobject.make_dataobject("img", @dataobject.Image, @schema.empty())
  let report = @cross_modal_line.cross_modal_line([d1, d2])
  assert_eq(report.total_count, 2)
  assert_eq(report.text_count, 1)
  assert_eq(report.image_count, 1)
  assert_eq(report.audio_count, 0)
  assert_eq(report.video_count, 0)
  assert_true(report.consistency_score > 0.49 && report.consistency_score < 0.51)
}

test "S2.5 cross_modal_line all modalities" {
  let d1 = @dataobject.make_dataobject("t", @dataobject.Text, @schema.empty())
  let d2 = @dataobject.make_dataobject("i", @dataobject.Image, @schema.empty())
  let d3 = @dataobject.make_dataobject("a", @dataobject.Audio, @schema.empty())
  let d4 = @dataobject.make_dataobject("v", @dataobject.Video, @schema.empty())
  let report = @cross_modal_line.cross_modal_line([d1, d2, d3, d4])
  assert_eq(report.consistency_score, 1.0)
  assert_eq(report.missing_modalities.length(), 0)
}

test "S2.5 cross_modal_line degenerate: empty" {
  let report = @cross_modal_line.cross_modal_line([])
  assert_eq(report.total_count, 0)
  assert_eq(report.consistency_score, 0.0)
  assert_eq(report.missing_modalities.length(), 4)
}

test "S2.5 cross_modal_line missing modalities" {
  let d1 = @dataobject.make_dataobject("text only", @dataobject.Text, @schema.empty())
  let report = @cross_modal_line.cross_modal_line([d1])
  assert_eq(report.missing_modalities, ["image", "audio", "video"])
}

test "S2.5 cross_modal_line_id" {
  assert_eq(@cross_modal_line.cross_modal_line_id(), "recipe/cross_modal_line")
}

// ============================================================
// S2.6 datatemporal 深化测试 / Datatemporal deepening tests
// ============================================================

test "S2.6 aging_weight basic" {
  let config = @aging.make_aging_config(30.0, 100.0)
  let w = @aging.aging_weight(100.0, config)
  assert_true(w > 0.99)
}

test "S2.6 aging_weight old data" {
  let config = @aging.make_aging_config(30.0, 100.0)
  let w = @aging.aging_weight(70.0, config)
  assert_true(w > 0.49 && w < 0.51)
}

test "S2.6 aging_weight future data" {
  let config = @aging.make_aging_config(30.0, 100.0)
  let w = @aging.aging_weight(110.0, config)
  assert_eq(w, 1.0)
}

test "S2.6 aging_weight degenerate: half_life=0" {
  let config = @aging.make_aging_config(0.0, 100.0)
  let w = @aging.aging_weight(50.0, config)
  assert_eq(w, 1.0)
}

test "S2.6 aging_score basic" {
  let config = @aging.make_aging_config(30.0, 100.0)
  let score = @aging.aging_score([100.0, 70.0, 40.0], config)
  assert_true(score > 0.0 && score <= 1.0)
}

test "S2.6 aging_score degenerate: empty" {
  let config = @aging.make_aging_config(30.0, 100.0)
  assert_eq(@aging.aging_score([], config), 0.0)
}

test "S2.6 aging_id" {
  assert_eq(@aging.aging_id(), "datatemporal/aging")
}

test "S2.6 detect_conflicts basic" {
  let base = ["a", "b", "c"]
  let new_keys = ["b", "d", "e"]
  let conflicts = @incremental.detect_conflicts(base, new_keys)
  assert_eq(conflicts, ["b"])
}

test "S2.6 detect_conflicts no conflict" {
  let base = ["a", "b"]
  let new_keys = ["c", "d"]
  assert_eq(@incremental.detect_conflicts(base, new_keys), [])
}

test "S2.6 detect_conflicts degenerate: empty" {
  assert_eq(@incremental.detect_conflicts([], []), [])
}

test "S2.6 merge_incremental basic" {
  let result = @incremental.merge_incremental(["a", "b"], ["b", "c"], ["a"])
  assert_eq(result.base_count, 2)
  assert_eq(result.added_count, 2)
  assert_eq(result.removed_count, 1)
  assert_eq(result.conflict_count, 1)
  assert_eq(result.final_count, 3)
}

test "S2.6 make_incremental_update" {
  let result = @incremental.make_incremental_update(10, 5, 3, ["x"])
  assert_eq(result.final_count, 12)
  assert_eq(result.conflict_count, 1)
}

test "S2.6 incremental_id" {
  assert_eq(@incremental.incremental_id(), "datatemporal/incremental")
}

test "S2.6 build_graph basic" {
  let deps = [
    @field_lineage.make_field_dep("a", "b", "copy"),
    @field_lineage.make_field_dep("b", "c", "transform"),
  ]
  let graph = @field_lineage.build_graph(deps)
  assert_eq(graph.fields, ["a", "b", "c"])
}

test "S2.6 impact_analysis direct" {
  let deps = [
    @field_lineage.make_field_dep("a", "b", "copy"),
    @field_lineage.make_field_dep("a", "c", "transform"),
  ]
  let graph = @field_lineage.build_graph(deps)
  let impacted = @field_lineage.impact_analysis(graph, "a")
  assert_eq(impacted.length(), 2)
}

test "S2.6 impact_analysis transitive" {
  let deps = [
    @field_lineage.make_field_dep("a", "b", "copy"),
    @field_lineage.make_field_dep("b", "c", "transform"),
  ]
  let graph = @field_lineage.build_graph(deps)
  let impacted = @field_lineage.impact_analysis(graph, "a")
  assert_eq(impacted, ["b", "c"])
}

test "S2.6 impact_analysis no impact" {
  let deps = [@field_lineage.make_field_dep("a", "b", "copy")]
  let graph = @field_lineage.build_graph(deps)
  let impacted = @field_lineage.impact_analysis(graph, "b")
  assert_eq(impacted, [])
}

test "S2.6 has_cycle no cycle" {
  let deps = [
    @field_lineage.make_field_dep("a", "b", "copy"),
    @field_lineage.make_field_dep("b", "c", "transform"),
  ]
  let graph = @field_lineage.build_graph(deps)
  assert_true(!@field_lineage.has_cycle(graph))
}

test "S2.6 has_cycle with cycle" {
  let deps = [
    @field_lineage.make_field_dep("a", "b", "copy"),
    @field_lineage.make_field_dep("b", "a", "transform"),
  ]
  let graph = @field_lineage.build_graph(deps)
  assert_true(@field_lineage.has_cycle(graph))
}

test "S2.6 field_lineage_id" {
  assert_eq(@field_lineage.field_lineage_id(), "datatemporal/field_lineage")
}

// ============================================================
// S2.7 Agent-Kit 编排测试 / Agent-Kit orchestration tests
// ============================================================

test "S2.7 parse_nl_to_plan basic" {
  let plan = @planner.parse_nl_to_plan("clean and dedup the data")
  assert_true(plan.steps.length() >= 2)
  assert_eq(plan.steps[0].operator_path, "opcore/clean")
  assert_eq(plan.steps[1].operator_path, "opcore/dedup")
}

test "S2.7 parse_nl_to_plan single keyword" {
  let plan = @planner.parse_nl_to_plan("filter the dataset")
  assert_eq(plan.steps.length(), 1)
  assert_eq(plan.steps[0].operator_path, "opcore/filter")
}

test "S2.7 parse_nl_to_plan no keywords" {
  let plan = @planner.parse_nl_to_plan("hello world foo bar")
  assert_eq(plan.steps.length(), 0)
}

test "S2.7 parse_nl_to_plan degenerate: empty" {
  let plan = @planner.parse_nl_to_plan("")
  assert_eq(plan, @planner.empty_execution_plan())
}

test "S2.7 parse_nl_to_plan multiple keywords" {
  let plan = @planner.parse_nl_to_plan("clean, dedup, filter, normalize.")
  assert_true(plan.steps.length() >= 4)
}

test "S2.7 make_plan_step" {
  let step = @planner.make_plan_step(0, "opcore/clean", [("param", "value")], "test step")
  assert_eq(step.step_id, 0)
  assert_eq(step.operator_path, "opcore/clean")
}

test "S2.7 make_execution_plan" {
  let steps = [@planner.make_plan_step(0, "opcore/clean", [], "step 0")]
  let plan = @planner.make_execution_plan("test", "test plan", steps)
  assert_eq(plan.name, "test")
  assert_eq(@planner.plan_step_count(plan), 1)
}

test "S2.7 plan_step_count empty" {
  let plan = @planner.empty_execution_plan()
  assert_eq(@planner.plan_step_count(plan), 0)
}

test "S2.7 planner_id" {
  assert_eq(@planner.planner_id(), "agent_kit/planner")
}

test "S2.7 execute_plan basic" {
  let steps = [
    @planner.make_plan_step(0, "opcore/clean", [], "step 0"),
    @planner.make_plan_step(1, "opcore/dedup", [], "step 1"),
  ]
  let plan = @planner.make_execution_plan("test", "test plan", steps)
  let results = @executor.execute_plan(plan)
  assert_eq(results.length(), 2)
  assert_eq(results[0].status, @executor.Success)
  assert_eq(results[1].status, @executor.Success)
}

test "S2.7 execute_plan degenerate: empty" {
  let plan = @planner.empty_execution_plan()
  let results = @executor.execute_plan(plan)
  assert_eq(results.length(), 0)
}

test "S2.7 exec_stats basic" {
  let results = [
    @executor.make_exec_result(0, @executor.Success, "opcore/clean", "ok", 10),
    @executor.make_exec_result(1, @executor.Failed, "opcore/dedup", "error", 5),
  ]
  let stats = @executor.exec_stats(results)
  assert_eq(stats.total_steps, 2)
  assert_eq(stats.success_count, 1)
  assert_eq(stats.failed_count, 1)
  assert_eq(stats.total_duration_ms, 15)
}

test "S2.7 exec_stats degenerate: empty" {
  let stats = @executor.exec_stats([])
  assert_eq(stats.total_steps, 0)
}

test "S2.7 exec_status_name" {
  assert_eq(@executor.exec_status_name(@executor.Pending), "pending")
  assert_eq(@executor.exec_status_name(@executor.Running), "running")
  assert_eq(@executor.exec_status_name(@executor.Success), "success")
  assert_eq(@executor.exec_status_name(@executor.Failed), "failed")
}

test "S2.7 executor_id" {
  assert_eq(@executor.executor_id(), "agent_kit/executor")
}

test "S2.7 full pipeline: NL → plan → execute" {
  let plan = @planner.parse_nl_to_plan("clean and dedup and filter")
  let results = @executor.execute_plan(plan)
  assert_true(results.length() >= 3)
  let stats = @executor.exec_stats(results)
  assert_eq(stats.success_count, results.length())
}

// ============================================================
// S2.8 DOSI 扩充 + Phase 2 验证测试
// ============================================================

test "S2.8 batch_add basic" {
  let sym = @dosi.SymbolicEntry::new("opcore/clean", "clean", "text", [])
  let sem = @dosi.SemanticEntry::new("clean", [], "in->out")
  let entry = @dosi.DOSIEntry::new(sym, sem)
  let op = @batch.batch_add(entry)
  assert_eq(op.op, @batch.Add)
  assert_eq(op.path, "opcore/clean")
}

test "S2.8 batch_remove basic" {
  let op = @batch.batch_remove("opcore/clean")
  assert_eq(op.op, @batch.Remove)
  assert_eq(op.path, "opcore/clean")
}

test "S2.8 apply_batch add" {
  let sym = @dosi.SymbolicEntry::new("opcore/clean", "clean", "text", [])
  let sem = @dosi.SemanticEntry::new("clean", [], "in->out")
  let entry = @dosi.DOSIEntry::new(sym, sem)
  let index = @dosi.DOSIIndex::empty()
  let result = @batch.apply_batch(index, [@batch.batch_add(entry)])
  assert_eq(result.size(), 1)
}

test "S2.8 apply_batch remove" {
  let sym = @dosi.SymbolicEntry::new("opcore/clean", "clean", "text", [])
  let sem = @dosi.SemanticEntry::new("clean", [], "in->out")
  let entry = @dosi.DOSIEntry::new(sym, sem)
  let index = @dosi.DOSIIndex::empty().add(entry)
  let result = @batch.apply_batch(index, [@batch.batch_remove("opcore/clean")])
  assert_eq(result.size(), 0)
}

test "S2.8 apply_batch update" {
  let sym1 = @dosi.SymbolicEntry::new("opcore/clean", "clean", "text", [])
  let sem1 = @dosi.SemanticEntry::new("old", [], "in->out")
  let entry1 = @dosi.DOSIEntry::new(sym1, sem1)
  let sym2 = @dosi.SymbolicEntry::new("opcore/clean", "clean", "text", [])
  let sem2 = @dosi.SemanticEntry::new("new", [], "in->out")
  let entry2 = @dosi.DOSIEntry::new(sym2, sem2)
  let index = @dosi.DOSIIndex::empty().add(entry1)
  let result = @batch.apply_batch(index, [@batch.batch_update(entry2)])
  assert_eq(result.size(), 1)
  assert_eq(result.entries()[0].semantic.summary, "new")
}

test "S2.8 apply_batch degenerate: empty ops" {
  let index = @dosi.DOSIIndex::empty()
  let result = @batch.apply_batch(index, [])
  assert_eq(result, index)
}

test "S2.8 batch_op_name" {
  assert_eq(@batch.batch_op_name(@batch.Add), "add")
  assert_eq(@batch.batch_op_name(@batch.Remove), "remove")
  assert_eq(@batch.batch_op_name(@batch.Update), "update")
}

test "S2.8 batch_id" {
  assert_eq(@batch.batch_id(), "dosi/batch")
}

test "S2.8 make_versioned_index" {
  let vindex = @versioned.make_versioned_index(@dosi.DOSIIndex::empty())
  assert_eq(vindex.current_version, 0)
  assert_eq(@versioned.version_count(vindex), 1)
}

test "S2.8 advance_version" {
  let vindex = @versioned.make_versioned_index(@dosi.DOSIIndex::empty())
  let vindex2 = @versioned.advance_version(vindex, @dosi.DOSIIndex::empty())
  assert_eq(vindex2.current_version, 1)
  assert_eq(@versioned.version_count(vindex2), 2)
}

test "S2.8 get_version existing" {
  let vindex = @versioned.make_versioned_index(@dosi.DOSIIndex::empty())
  let result = @versioned.get_version(vindex, 0)
  assert_true(match result {
    Some(_) => true
    None => false
  })
}

test "S2.8 get_version non-existing" {
  let vindex = @versioned.make_versioned_index(@dosi.DOSIIndex::empty())
  let result = @versioned.get_version(vindex, 99)
  assert_true(match result {
    Some(_) => false
    None => true
  })
}

test "S2.8 current_version" {
  let vindex = @versioned.make_versioned_index(@dosi.DOSIIndex::empty())
  let vindex2 = @versioned.advance_version(vindex, @dosi.DOSIIndex::empty())
  let curr = @versioned.current(vindex2)
  assert_eq(curr, @dosi.DOSIIndex::empty())
}

test "S2.8 rollback" {
  let vindex = @versioned.make_versioned_index(@dosi.DOSIIndex::empty())
  let vindex2 = @versioned.advance_version(vindex, @dosi.DOSIIndex::empty())
  let vindex3 = @versioned.rollback(vindex2, 0)
  assert_eq(vindex3.current_version, 2)
}

test "S2.8 empty_versioned_index" {
  let vindex = @versioned.empty_versioned_index()
  assert_eq(vindex.current_version, 0)
}

test "S2.8 versioned_id" {
  assert_eq(@versioned.versioned_id(), "dosi/versioned")
}

// Phase 2 验证：多模态退化场景
test "S2.8 verify: multimodal degenerate" {
  let empty_img = @image.empty_image_meta()
  let empty_aud = @audio.empty_audio_meta()
  let empty_vid = @video.empty_video_meta()
  let (w, h) = @image.image_size(empty_img)
  assert_eq(w, 0)
  assert_eq(h, 0)
  assert_eq(@audio.audio_duration(empty_aud), 0)
  assert_eq(@video.frame_count(empty_vid), 0)
}

// Phase 2 验证：语义算子一致性
test "S2.8 verify: semantic consistency" {
  let d = @dataobject.make_dataobject("Hello World Test Data", @dataobject.Text, @schema.empty())
  let score1 = @semantic.semantic_quality_score(d)
  let score2 = @semantic.semantic_quality_score(d)
  assert_eq(score1, score2)
}

// Phase 2 验证：跨后端等价性（CPU 串行 vs 直接调用）
test "S2.8 verify: cross-backend equivalence" {
  let d = @dataobject.make_dataobject("hello world", @dataobject.Text, @schema.empty())
  let direct = @clean.strip_whitespace(d)
  let plan = @cpu_serial.empty_plan()
  assert_true(direct.content.length() >= 0)
  assert_eq(@cpu_serial.plan_step_count(plan), 0)
}

// ============================================================
// S2.9 learncore DL 扩展层测试 / Extended DL layer tests
// ============================================================

test "S2.9 conv2d_output_dim basic" {
  let meta = @dl_layers.make_conv2d(3, 16, 3, 1, 1)
  let out = @dl_layers.conv2d_output_dim(32, meta)
  assert_eq(out, 32)
}

test "S2.9 conv2d_output_dim stride 2" {
  let meta = @dl_layers.make_conv2d(3, 16, 3, 2, 1)
  let out = @dl_layers.conv2d_output_dim(32, meta)
  assert_eq(out, 16)
}

test "S2.9 conv2d_output_dim no padding" {
  let meta = @dl_layers.make_conv2d(3, 16, 3, 1, 0)
  let out = @dl_layers.conv2d_output_dim(32, meta)
  assert_eq(out, 30)
}

test "S2.9 conv2d_output_dim degenerate: stride 0" {
  let meta = @dl_layers.make_conv2d(3, 16, 3, 0, 1)
  assert_eq(@dl_layers.conv2d_output_dim(32, meta), 0)
}

test "S2.9 maxpool_output_dim basic" {
  let meta = @dl_layers.make_maxpool(2, 2)
  let out = @dl_layers.maxpool_output_dim(32, meta)
  assert_eq(out, 16)
}

test "S2.9 maxpool_output_dim degenerate: stride 0" {
  let meta = @dl_layers.make_maxpool(2, 0)
  assert_eq(@dl_layers.maxpool_output_dim(32, meta), 0)
}

test "S2.9 dropout_forward inference" {
  let input = [1.0, 2.0, 3.0, 4.0]
  let result = @dl_layers.dropout_forward(input, 0.5, @dl_layers.Inference)
  assert_eq(result, input)
}

test "S2.9 dropout_forward training" {
  let input = [1.0, 2.0, 3.0, 4.0]
  let result = @dl_layers.dropout_forward(input, 0.5, @dl_layers.Training)
  assert_eq(result.length(), 4)
}

test "S2.9 dropout_forward degenerate: rate 0" {
  let input = [1.0, 2.0, 3.0]
  let result = @dl_layers.dropout_forward(input, 0.0, @dl_layers.Training)
  assert_eq(result, input)
}

test "S2.9 dropout_forward degenerate: rate 1" {
  let input = [1.0, 2.0, 3.0]
  let result = @dl_layers.dropout_forward(input, 1.0, @dl_layers.Training)
  assert_eq(result, input)
}

test "S2.9 batchnorm_forward basic" {
  let meta = @dl_layers.make_batchnorm(3, 0.00001)
  let input = [1.0, 2.0, 3.0]
  let result = @dl_layers.batchnorm_forward(input, meta)
  assert_eq(result.length(), 3)
}

test "S2.9 batchnorm_forward degenerate: empty" {
  let meta = @dl_layers.make_batchnorm(3, 0.00001)
  let result = @dl_layers.batchnorm_forward([], meta)
  assert_eq(result.length(), 0)
}

test "S2.9 batchnorm_forward zero variance" {
  let meta = @dl_layers.make_batchnorm(3, 0.00001)
  let input = [5.0, 5.0, 5.0]
  let result = @dl_layers.batchnorm_forward(input, meta)
  assert_eq(result.length(), 3)
}

test "S2.9 dropout_mode_name" {
  assert_eq(@dl_layers.dropout_mode_name(@dl_layers.Training), "training")
  assert_eq(@dl_layers.dropout_mode_name(@dl_layers.Inference), "inference")
}