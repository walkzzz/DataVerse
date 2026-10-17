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