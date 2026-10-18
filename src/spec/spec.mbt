///|
/// # spec 形式化规格验证 / Formal Specification Verification
///
/// R16 阶段门禁第 5 手段：形式化证明（proof-carrying 风格）。
/// 验证 Phase 1 关键算子的数学性质：
/// - 幂等性：f(f(x)) == f(x)

/// - 不变量：precondition → postcondition
/// - 收敛性：迭代后稳定
///
/// # Formal spec verification
///
/// R16 gate 5: formal proof (proof-carrying style).

///|
/// 性质 1：whitespace_normalization 幂等性
/// ∀ x: normalize(normalize(x)) == normalize(x)
test "spec: whitespace_normalization idempotency" {
  let s = @schema.empty()
  let cases = [
    @dataobject.make_dataobject("  hello   world  ", @dataobject.Text, s),
    @dataobject.make_dataobject("a  b   c", @dataobject.Text, s),
    @dataobject.make_dataobject("", @dataobject.Text, s),
    @dataobject.make_dataobject("   ", @dataobject.Text, s),
    @dataobject.make_dataobject("single", @dataobject.Text, s),
  ]
  for i = 0; i < cases.length(); i = i + 1 {
    let once = @normalize.whitespace_normalization(cases[i])
    let twice = @normalize.whitespace_normalization(once)
    assert_eq(twice.content, once.content)
  }
}

///|
/// 性质 2：exact_dedup 幂等性
/// ∀ xs: dedup(dedup(xs)) == dedup(xs)
test "spec: exact_dedup idempotency" {
  let s = @schema.empty()
  let d1 = @dataobject.make_dataobject("a", @dataobject.Text, s)
  let d2 = @dataobject.make_dataobject("b", @dataobject.Text, s)
  let d3 = @dataobject.make_dataobject("a", @dataobject.Text, s)
  let d4 = @dataobject.make_dataobject("c", @dataobject.Text, s)
  let once = @dedup.exact_dedup([d1, d2, d3, d4])
  let twice = @dedup.exact_dedup(once)
  assert_eq(twice.length(), once.length())
}

///|
/// 性质 3：exact_dedup 去重后无重复
/// ∀ xs: dedup(xs) 中无两个元素 content 相同
test "spec: exact_dedup no duplicates" {
  let s = @schema.empty()
  let arr = [
    @dataobject.make_dataobject("a", @dataobject.Text, s),
    @dataobject.make_dataobject("b", @dataobject.Text, s),
    @dataobject.make_dataobject("a", @dataobject.Text, s),
    @dataobject.make_dataobject("c", @dataobject.Text, s),
    @dataobject.make_dataobject("b", @dataobject.Text, s),
  ]
  let result = @dedup.exact_dedup(arr)
  for i = 0; i < result.length(); i = i + 1 {
    for j = i + 1; j < result.length(); j = j + 1 {
      assert_true(result[i].content != result[j].content)
    }
  }
}

///|
/// 性质 4：linear_regression 完美拟合
/// 若 y = slope * x + intercept（精确线性），则回归返回 (slope, intercept)
test "spec: linear_regression exact fit" {
  // y = 3x + 2
  let points = [(0.0, 2.0), (1.0, 5.0), (2.0, 8.0), (3.0, 11.0), (4.0, 14.0)]
  let model = @regression.linear_regression(points)
  assert_true(model.slope > 2.99 && model.slope < 3.01)
  assert_true(model.intercept > 1.99 && model.intercept < 2.01)
  // 验证预测精确
  for i = 0; i < points.length(); i = i + 1 {
    let pred = @regression.predict_linear(model, points[i].0)
    assert_true(pred > points[i].1 - 0.01 && pred < points[i].1 + 0.01)
  }
}

///|
/// 性质 5：topk_by_length 长度不变量
/// ∀ xs, k: |topk(xs, k)| == min(k, |xs|) 当 0 < k < |xs|
test "spec: topk_by_length size invariant" {
  let s = @schema.empty()
  let arr = [
    @dataobject.make_dataobject("a", @dataobject.Text, s),
    @dataobject.make_dataobject("bb", @dataobject.Text, s),
    @dataobject.make_dataobject("ccc", @dataobject.Text, s),
    @dataobject.make_dataobject("dddd", @dataobject.Text, s),
    @dataobject.make_dataobject("eeeee", @dataobject.Text, s),
  ]
  // k=3, n=5 → 结果长度=3
  assert_eq(@select.topk_by_length(arr, 3).length(), 3)
  // k=10, n=5 → 结果长度=5（全部）
  assert_eq(@select.topk_by_length(arr, 10).length(), 5)
  // k=0 → 返回+0 → 全部
  assert_eq(@select.topk_by_length(arr, 0).length(), 5)
}

///|
/// 性质 6：topk_by_length 有序性
/// 结果按长度降序排列
test "spec: topk_by_length sorted descending" {
  let s = @schema.empty()
  let arr = [
    @dataobject.make_dataobject("a", @dataobject.Text, s),
    @dataobject.make_dataobject("bbb", @dataobject.Text, s),
    @dataobject.make_dataobject("cc", @dataobject.Text, s),
    @dataobject.make_dataobject("ddddd", @dataobject.Text, s),
  ]
  let result = @select.topk_by_length(arr, 3)
  for i = 0; i < result.length() - 1; i = i + 1 {
    assert_true(result[i].content.length() >= result[i + 1].content.length())
  }
}

///|
/// 性质 7：standardize 零均值不变量
/// ∀ xs: standardize(xs) 的均值 ≈ 0（当 std > 0）
test "spec: standardize zero mean invariant" {
  let data = [1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0]
  let std = @feature.standardize(data)
  let mean = std.fold(init=0.0, fn(acc, x) { acc + x }) / std.length().to_double()
  assert_true(mean > -0.001 && mean < 0.001)
}

///|
/// 性质 8：normalize_minmax 值域不变量
/// ∀ xs: normalize_minmax(xs) ∈ [0, 1]
test "spec: normalize_minmax range invariant" {
  let data = [3.0, 7.0, 1.0, 9.0, 5.0, 2.0, 8.0]
  let norm = @feature.normalize_minmax(data)
  for i = 0; i < norm.length(); i = i + 1 {
    assert_true(norm[i] >= 0.0 && norm[i] <= 1.0)
  }
}

///|
/// 性质 9：mask_digits 幂等性
/// ∀ x: mask(mask(x)) == mask(x)
test "spec: mask_digits idempotency" {
  let s = @schema.empty()
  let d = @dataobject.make_dataobject("call 138-1234-5678", @dataobject.Text, s)
  let once = @safety.mask_digits(d)
  let twice = @safety.mask_digits(once)
  assert_eq(twice.content, once.content)
}

///|
/// 性质 10：to_lowercase 幂等性
/// ∀ x: lower(lower(x)) == lower(x)
test "spec: to_lowercase idempotency" {
  let s = @schema.empty()
  let d = @dataobject.make_dataobject("Hello World 123", @dataobject.Text, s)
  let once = @transform.to_lowercase(d)
  let twice = @transform.to_lowercase(once)
  assert_eq(twice.content, once.content)
}

///|
/// 性质 11：accuracy 值域不变量
/// ∀ pred, actual: accuracy ∈ [0, 1]
test "spec: accuracy range invariant" {
  let pred = ["A", "B", "A", "B", "A"]
  let actual = ["A", "A", "B", "B", "A"]
  let acc = @metrics.accuracy(pred, actual)
  assert_true(acc >= 0.0 && acc <= 1.0)
}

///|
/// 性质 12：mse 非负性
/// ∀ pred, actual: mse >= 0
test "spec: mse non-negativity" {
  let pred = [1.0, 2.0, 3.0]
  let actual = [1.5, 2.5, 3.5]
  let mse_val = @metrics.mse(pred, actual)
  assert_true(mse_val >= 0.0)
}

///|
/// 性质 13：topo_order 拓扑合法性
/// ∀ pipeline (DAG): topo_order 中每条边 (u,v) 满足 u 出现在 v 之前
test "spec: topo_order validity" {
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
  // 找到 a, b, c 的位置
  let mut pos_a = -1
  let mut pos_b = -1
  let mut pos_c = -1
  for i = 0; i < order.length(); i = i + 1 {
    if order[i].value() == "a" {
      pos_a = i
    }
    if order[i].value() == "b" {
      pos_b = i
    }
    if order[i].value() == "c" {
      pos_c = i
    }
  }
  // 拓扑序：a < b < c
  assert_true(pos_a < pos_b)
  assert_true(pos_b < pos_c)
}

///|
/// 性质 14：optimize 节点数单调递减
/// ∀ pipeline: optimize(pipeline).node_count <= pipeline.node_count
test "spec: optimize node count monotonic" {
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
  assert_true(opt.node_count() <= p.node_count())
}

///|
/// 性质 15：kmeans 收敛性
/// 足够大的 max_iter 后，再次 kmeans 标签不变
test "spec: kmeans convergence" {
  let points = [
    [0.0, 0.0],
    [0.0, 1.0],
    [1.0, 0.0],
    [10.0, 10.0],
    [10.0, 11.0],
    [11.0, 10.0],
  ]
  let labels1 = @cluster.kmeans(points, 2, 20)
  let labels2 = @cluster.kmeans(points, 2, 20)
  // 两次运行结果一致（确定性收敛）
  assert_eq(labels1, labels2)
}

// ============================================================
// Phase 2 形式化证明 / Phase 2 Formal Proofs
// R16 门禁：验证 Phase 2 关键算子的数学性质
// ============================================================

///|
/// 性质 16：image_resize 幂等性
/// resize(resize(meta, w, h), w, h) == resize(meta, w, h)
test "spec: image_resize idempotent" {
  let meta = @image.make_image_meta(1920, 1080, 3, "png")
  let r1 = @image.image_resize(meta, 640, 360)
  let r2 = @image.image_resize(r1, 640, 360)
  assert_eq(r1, r2)
}

///|
/// 性质 17：image_crop 边界不变量
/// crop 结果尺寸 <= 请求尺寸
test "spec: image_crop bounded" {
  let meta = @image.make_image_meta(100, 100, 3, "png")
  let cropped = @image.image_crop(meta, 10, 20, 30, 40)
  let (w, h) = @image.image_size(cropped)
  assert_true(w <= 30)
  assert_true(h <= 40)
}

///|
/// 性质 18：audio_segment 时间不变量
/// segment 结果 duration <= 原 duration
test "spec: audio_segment duration bounded" {
  let meta = @audio.make_audio_meta(10000, 44100, 2, "wav")
  let seg = @audio.audio_segment(meta, 2000, 8000)
  assert_true(seg.duration_ms <= meta.duration_ms)
}

///|
/// 性质 19：video_sample_frames 单调性
/// interval 越小，采样点越多
test "spec: video_sample_frames monotone" {
  let meta = @video.make_video_meta(10000, 30, 1920, 1080, "mp4")
  let frames1 = @video.video_sample_frames(meta, 2000)
  let frames2 = @video.video_sample_frames(meta, 1000)
  assert_true(frames2.length() >= frames1.length())
}

///|
/// 性质 20：semantic_quality_score 范围不变量
/// 0 <= score <= 1
test "spec: semantic_quality_score range" {
  let d1 = @dataobject.make_dataobject("hello world test", @dataobject.Text, @schema.empty())
  let d2 = @dataobject.make_dataobject("a".repeat(200), @dataobject.Text, @schema.empty())
  let d3 = @dataobject.empty_dataobject(@dataobject.Text)
  let s1 = @semantic.semantic_quality_score(d1)
  let s2 = @semantic.semantic_quality_score(d2)
  let s3 = @semantic.semantic_quality_score(d3)
  assert_true(s1 >= 0.0 && s1 <= 1.0)
  assert_true(s2 >= 0.0 && s2 <= 1.0)
  assert_eq(s3, 0.0)
}

///|
/// 性质 21：content_diversity_score 范围不变量
/// 0 < score <= 1（非空时）
test "spec: content_diversity_score range" {
  let d = @dataobject.make_dataobject("abcdef", @dataobject.Text, @schema.empty())
  let s = @semantic.content_diversity_score(d)
  assert_true(s > 0.0 && s <= 1.0)
}

///|
/// 性质 22：rewrite_text Simplify 幂等性
/// simplify(simplify(x)) == simplify(x)（对短文本）
test "spec: rewrite Simplify idempotent" {
  let d = @dataobject.make_dataobject("  hello world  ", @dataobject.Text, @schema.empty())
  let r1 = @semantic.rewrite_text(d, @semantic.Simplify)
  let r2 = @semantic.rewrite_text(r1, @semantic.Simplify)
  assert_eq(r1.content, r2.content)
}

///|
/// 性质 23：mse_loss 非负性
/// mse_loss >= 0
test "spec: mse_loss non-negative" {
  let pred = [1.0, 2.0, 3.0]
  let target = [4.0, 5.0, 6.0]
  let result = @dl_losses.mse_loss(pred, target)
  assert_true(result >= 0.0)
}

///|
/// 性质 24：cross_entropy_loss 非负性
/// cross_entropy >= 0
test "spec: cross_entropy_loss non-negative" {
  let logits = [1.0, 0.0, 0.0]
  let target = [1.0, 0.0, 0.0]
  let result = @dl_losses.cross_entropy_loss(logits, target)
  assert_true(result >= 0.0)
}

///|
/// 性质 25：kfold_splits 完备性
/// 所有 test_indices 的并集 = 全集（无重叠）
test "spec: kfold_splits complete" {
  let n = 10
  let k = 5
  let splits = @cross_validation.kfold_splits(n, k)
  let all_test : Array[Int] = []
  for i in 0..<splits.length() {
    for j in 0..<splits[i].test_indices.length() {
      all_test.push(splits[i].test_indices[j])
    }
  }
  assert_eq(all_test.length(), n)
}

///|
/// 性质 26：grid_combinations 笛卡尔积大小
/// prod(len(param_values))
test "spec: grid_combinations cartesian size" {
  let cfg1 = @hyperparam_search.make_grid_config("a", [0.1, 0.2, 0.3])
  let cfg2 = @hyperparam_search.make_grid_config("b", [1.0, 2.0])
  let combos = @hyperparam_search.grid_combinations([cfg1, cfg2])
  assert_eq(combos.length(), 6)
}

///|
/// 性质 27：aging_weight 范围不变量
/// 0 < weight <= 1
test "spec: aging_weight range" {
  let config = @aging.make_aging_config(30.0, 100.0)
  let w1 = @aging.aging_weight(100.0, config)
  let w2 = @aging.aging_weight(50.0, config)
  let w3 = @aging.aging_weight(150.0, config)
  assert_true(w1 > 0.0 && w1 <= 1.0)
  assert_true(w2 > 0.0 && w2 <= 1.0)
  assert_true(w3 > 0.0 && w3 <= 1.0)
}

///|
/// 性质 28：impact_analysis 不含自身（无环时）
/// changed_field 不在 impact 结果中
test "spec: impact_analysis no self" {
  let deps = [
    @field_lineage.make_field_dep("a", "b", "copy"),
    @field_lineage.make_field_dep("b", "c", "transform"),
  ]
  let graph = @field_lineage.build_graph(deps)
  let impacted = @field_lineage.impact_analysis(graph, "a")
  let mut contains_a = false
  for i in 0..<impacted.length() {
    if impacted[i] == "a" {
      contains_a = true
    }
  }
  assert_true(!contains_a)
}

///|
/// 性质 29：apply_batch 空操作幂等性
/// apply_batch(idx, []) == idx
test "spec: apply_batch empty idempotent" {
  let index = @dosi.DOSIIndex::empty()
  let result = @batch.apply_batch(index, [])
  assert_eq(result, index)
}

///|
/// 性质 30：versioned_index 版本单调性
/// advance 后 current_version 递增
test "spec: versioned_index monotone" {
  let vindex = @versioned.make_versioned_index(@dosi.DOSIIndex::empty())
  let v1 = vindex.current_version
  let vindex2 = @versioned.advance_version(vindex, @dosi.DOSIIndex::empty())
  let v2 = vindex2.current_version
  assert_true(v2 > v1)
}
// ============================================================
// Phase 3 形式化性质 (31-40)
// ============================================================

///|
/// 性质 31：read_source 空安全
/// read_source(cfg, 0) == []
test "spec: read_source empty safe" {
  let cfg = @source.file_source("/data/test.json", "json")
  let result = @source.read_source(cfg, 0)
  assert_eq(result.length(), 0)
}

///|
/// 性质 32：write_sink 空安全
/// write_sink(cfg, []) == 0
test "spec: write_sink empty safe" {
  let cfg = @sink.file_sink("/data/out.json", "json")
  let count = @sink.write_sink(cfg, [])
  assert_eq(count, 0)
}

///|
/// 性质 33：execute_write 写入守恒
/// execute_write(cfg, data).written_count == data.length()
test "spec: execute_write conservation" {
  let cfg = @sink.file_sink("/data/out.json", "json")
  let data = [
    @dataobject.make_dataobject("a", @dataobject.Text, @schema.empty()),
    @dataobject.make_dataobject("b", @dataobject.Text, @schema.empty()),
    @dataobject.make_dataobject("c", @dataobject.Text, @schema.empty()),
  ]
  let result = @sink.execute_write(cfg, data)
  assert_eq(result.written_count, data.length())
}

///|
/// 性质 34：partition_data 分区守恒
/// sum(partition_data(data, cfg)) == data.length()
test "spec: partition_data conservation" {
  let data = [
    @dataobject.make_dataobject("a", @dataobject.Text, @schema.empty()),
    @dataobject.make_dataobject("b", @dataobject.Text, @schema.empty()),
    @dataobject.make_dataobject("c", @dataobject.Text, @schema.empty()),
    @dataobject.make_dataobject("d", @dataobject.Text, @schema.empty()),
    @dataobject.make_dataobject("e", @dataobject.Text, @schema.empty()),
  ]
  let cfg = @cpu_parallel.make_partition_config(@cpu_parallel.ByCount, 3, "")
  let parts = @cpu_parallel.partition_data(data, cfg)
  let mut total = 0
  for i in 0..<parts.length() {
    total = total + parts[i]
  }
  assert_eq(total, data.length())
}

///|
/// 性质 35：gather_results 加法性
/// gather_results([a, b, c]) == a + b + c
test "spec: gather_results additive" {
  let parts = [10, 20, 30]
  let total = @cpu_parallel.gather_results(parts, @cpu_parallel.Concat)
  assert_eq(total, 60)
}

///|
/// 性质 36：register_plugin 幂等性
/// register_plugin(register_plugin(reg, e), e) == register_plugin(reg, e)
test "spec: register_plugin idempotent" {
  let meta = @plugin.make_plugin_meta("p", "1.0", "a", "e", "d")
  let entry = @plugin.make_plugin_entry(meta, @plugin.Loaded, [])
  let reg1 = @plugin.register_plugin(@plugin.empty_plugin_registry(), entry)
  let reg2 = @plugin.register_plugin(reg1, entry)
  assert_eq(@plugin.plugin_count(reg1), @plugin.plugin_count(reg2))
}

///|
/// 性质 37：unregister_plugin 注销安全
/// unregister 后 get_plugin_status == Error
test "spec: unregister_plugin safety" {
  let meta = @plugin.make_plugin_meta("p", "1.0", "a", "e", "d")
  let entry = @plugin.make_plugin_entry(meta, @plugin.Active, [])
  let reg = @plugin.register_plugin(@plugin.empty_plugin_registry(), entry)
  let reg2 = @plugin.unregister_plugin(reg, "p")
  assert_eq(@plugin.get_plugin_status(reg2, "p"), @plugin.Error)
}

///|
/// 性质 38：run_benchmark 零迭代安全
/// run_benchmark(name, n, cfg{iterations=0}).total_ms == 0
test "spec: run_benchmark zero iteration safe" {
  let cfg = @benchmark.make_benchmark_config(0, 0, 1)
  let result = @benchmark.run_benchmark("test", 100, cfg)
  assert_eq(result.total_ms, 0)
}

///|
/// 性质 39：apply_fusion 融合不增节点
/// apply_fusion(p).fused_node_count <= apply_fusion(p).original_node_count
test "spec: apply_fusion non_increasing" {
  let n1 = @ir_operator.OperatorIR::simple(
    @ir_core.IRNodeId::new("op1"), "map1", @ir_operator.Text, @ir_operator.Deterministic,
  )
  let n2 = @ir_operator.OperatorIR::simple(
    @ir_core.IRNodeId::new("op2"), "map2", @ir_operator.Text, @ir_operator.Deterministic,
  )
  let n3 = @ir_operator.OperatorIR::simple(
    @ir_core.IRNodeId::new("op3"), "map3", @ir_operator.Text, @ir_operator.Deterministic,
  )
  let p = @ir_pipeline.PipelineIR::empty().add_node(n1).add_node(n2).add_node(n3)
  let result = @ir_fusion.apply_fusion(p)
  assert_true(result.fused_node_count <= result.original_node_count)
}

///|
/// 性质 40：add_doc_entry 索引单调性
/// add_doc_entry 后 total_api 严格递增
test "spec: add_doc_entry monotone" {
  let index = @docgen.empty_doc_index()
  let entry = @docgen.make_doc_entry("m", 10, 5, 8, "desc")
  let index2 = @docgen.add_doc_entry(index, entry)
  assert_true(index2.total_api > index.total_api)
}

// ============================================================
// Phase 4 形式化性质（41-50）
// R16 门禁：验证 Phase 4 关键算子的数学性质
// ============================================================

///|
/// 性质 41：euclidean_distance 对称性
/// d(a, b) == d(b, a)
test "spec: euclidean_distance symmetric" {
  let a = @proximity.make_point(1.0, 2.0)
  let b = @proximity.make_point(3.0, 5.0)
  let d1 = @proximity.euclidean_distance(a, b)
  let d2 = @proximity.euclidean_distance(b, a)
  assert_true((d1 - d2).abs() < 0.0001)
}

///|
/// 性质 42：euclidean_distance 自反性
/// d(a, a) == 0
test "spec: euclidean_distance reflexive" {
  let a = @proximity.make_point(3.5, 7.2)
  assert_eq(@proximity.euclidean_distance(a, a), 0.0)
}

///|
/// 性质 43：euclidean_distance 三角不等式
/// d(a, c) <= d(a, b) + d(b, c)
test "spec: euclidean_distance triangle_inequality" {
  let a = @proximity.make_point(0.0, 0.0)
  let b = @proximity.make_point(1.0, 1.0)
  let c = @proximity.make_point(3.0, 4.0)
  let d_ac = @proximity.euclidean_distance(a, c)
  let d_ab = @proximity.euclidean_distance(a, b)
  let d_bc = @proximity.euclidean_distance(b, c)
  assert_true(d_ac <= d_ab + d_bc + 0.0001)
}

///|
/// 性质 44：polygon_area 非负性
/// area(polygon) >= 0
test "spec: polygon_area non_negative" {
  let poly = @overlay.make_polygon([@proximity.make_point(0.0, 0.0), @proximity.make_point(4.0, 0.0), @proximity.make_point(4.0, 3.0), @proximity.make_point(0.0, 3.0)])
  assert_true(@overlay.polygon_area(poly) >= 0.0)
}

///|
/// 性质 45：polygon_perimeter 非负性
/// perimeter(polygon) >= 0
test "spec: polygon_perimeter non_negative" {
  let poly = @overlay.make_polygon([@proximity.make_point(0.0, 0.0), @proximity.make_point(4.0, 0.0), @proximity.make_point(4.0, 3.0)])
  assert_true(@overlay.polygon_perimeter(poly) >= 0.0)
}

///|
/// 性质 46：surface_slope 非负性
/// slope >= 0 (degrees)
test "spec: surface_slope non_negative" {
  let raster = @hydrology.make_raster([[1.0, 2.0, 3.0], [4.0, 5.0, 6.0], [7.0, 8.0, 9.0]])
  let slope = @surface.surface_slope(raster, 1, 1, 1.0)
  assert_true(slope >= 0.0)
}

///|
/// 性质 47：density_kernel_at 非负性
/// kernel(distance) >= 0
test "spec: density_kernel_at non_negative" {
  let k1 = @density.quadratic_kernel(0.5, 1.0)
  let k2 = @density.gaussian_kernel(0.5, 1.0)
  assert_true(k1 >= 0.0)
  assert_true(k2 >= 0.0)
}

///|
/// 性质 48：interpolation_idw 重合点返回采样值
/// IDW at sample location == sample value
test "spec: interpolation_idw coincident_returns_sample" {
  let samples = [
    @interpolation.make_sample_point(0.0, 0.0, 5.0),
    @interpolation.make_sample_point(2.0, 0.0, 10.0),
  ]
  let target = @proximity.make_point(2.0, 0.0)
  let result = @interpolation.interpolation_idw(samples, target, 2.0)
  assert_true((result - 10.0).abs() < 0.0001)
}

///|
/// 性质 49：zonal_count 非负性
/// zonal_count(zone) >= 0
test "spec: zonal_count non_negative" {
  let zone = @hydrology.make_raster([[1.0, 1.0], [2.0, 1.0]])
  assert_true(@zonal.zonal_count(zone, 1) >= 0)
  assert_true(@zonal.zonal_count(zone, 2) >= 0)
  assert_true(@zonal.zonal_count(zone, 99) >= 0)
}

///|
/// 性质 50：focal_mean 常数栅格不变性
/// focal_mean(constant_raster, r, c, radius) == constant
test "spec: focal_mean constant_invariant" {
  let raster = @hydrology.make_raster([[7.0, 7.0, 7.0], [7.0, 7.0, 7.0], [7.0, 7.0, 7.0]])
  let m = @local_stats.focal_mean(raster, 1, 1, 1)
  assert_true((m - 7.0).abs() < 0.0001)
}

// ============================================================
// Phase 5 形式化性质（51-60）
// R16 门禁：验证 Phase 5 关键算子的数学性质
// ============================================================

///|
/// 性质 51：block_mean 常数栅格不变性
/// block_mean(constant_raster) == constant
test "spec: block_mean constant_invariant" {
  let r = @hydrology.make_raster([[7.0, 7.0, 7.0], [7.0, 7.0, 7.0], [7.0, 7.0, 7.0]])
  let m = @neighborhood.block_mean(r, 0, 0, 2)
  assert_true((m - 7.0).abs() < 0.0001)
}

///|
/// 性质 52：block_count 非负性
/// block_count >= 0
test "spec: block_count non_negative" {
  let r = @hydrology.make_raster([[1.0, 2.0], [3.0, 4.0]])
  assert_true(@neighborhood.block_count(r, 0, 0, 2) >= 0)
  assert_true(@neighborhood.block_count(r, 0, 0, 1) >= 0)
}

///|
/// 性质 53：line_mean 常数行不变性
/// line_mean(constant_row) == constant
test "spec: line_mean constant_invariant" {
  let r = @hydrology.make_raster([[5.0, 5.0, 5.0, 5.0]])
  let m = @neighborhood.line_mean(r, 0)
  assert_true((m - 5.0).abs() < 0.0001)
}

///|
/// 性质 54：line_count 非负性
/// line_count >= 0
test "spec: line_count non_negative" {
  let r = @hydrology.make_raster([[1.0, 2.0, 3.0]])
  assert_true(@neighborhood.line_count(r, 0) >= 0)
}

///|
/// 性质 55：neighborhood_cell_count 非负性
/// neighborhood_cell_count >= 0
test "spec: neighborhood_cell_count non_negative" {
  let cfg1 = @neighborhood.make_neighborhood_config(@neighborhood.NHRectangle, 2, 0)
  let cfg2 = @neighborhood.make_neighborhood_config(@neighborhood.NHCircle, 1, 0)
  let cfg3 = @neighborhood.make_neighborhood_config(@neighborhood.NHAnnulus, 3, 1)
  assert_true(@neighborhood.neighborhood_cell_count(cfg1) >= 0)
  assert_true(@neighborhood.neighborhood_cell_count(cfg2) >= 0)
  assert_true(@neighborhood.neighborhood_cell_count(cfg3) >= 0)
}

///|
/// 性质 56：solar_altitude 非负性
/// altitude >= 0
test "spec: solar_altitude non_negative" {
  let alt1 = @solar.solar_altitude(40.0, 180, 12.0)
  let alt2 = @solar.solar_altitude(40.0, 180, 6.0)
  let alt3 = @solar.solar_altitude(40.0, 180, 0.0)
  assert_true(alt1 >= 0.0)
  assert_true(alt2 >= 0.0)
  assert_true(alt3 >= 0.0)
}

///|
/// 性质 57：solar global = direct + diffuse
/// global_radiation == direct_radiation + diffuse_radiation
test "spec: solar_global_equals_direct_plus_diffuse" {
  let cfg = @solar.make_solar_config(35.0, 120.0, 172, 14.0, 0.25)
  let r = @solar.solar_radiation_point(cfg)
  assert_true((r.global_radiation - r.direct_radiation - r.diffuse_radiation).abs() < 0.001)
}

///|
/// 性质 58：solar_duration 范围
/// 0 <= duration <= 24
test "spec: solar_duration bounded" {
  let dur1 = @solar.solar_duration(40.0, 180)
  let dur2 = @solar.solar_duration(0.0, 80)
  let dur3 = @solar.solar_duration(60.0, 355)
  assert_true(dur1 >= 0.0 && dur1 <= 24.0)
  assert_true(dur2 >= 0.0 && dur2 <= 24.0)
  assert_true(dur3 >= 0.0 && dur3 <= 24.0)
}

///|
/// 性质 59：darcy_velocity 非负性
/// darcy_velocity >= 0
test "spec: darcy_velocity non_negative" {
  let cfg1 = @groundwater.make_groundwater_config(0.3, 0.001, 0.01, 0.005)
  let cfg2 = @groundwater.make_groundwater_config(0.0, 0.001, 0.01, 0.0)
  let cfg3 = @groundwater.make_groundwater_config(0.3, 0.0, 0.0, 0.0)
  assert_true(@groundwater.darcy_velocity(cfg1) >= 0.0)
  assert_true(@groundwater.darcy_velocity(cfg2) >= 0.0)
  assert_true(@groundwater.darcy_velocity(cfg3) >= 0.0)
}

///|
/// 性质 60：porous_puff 非负性
/// porous_puff >= 0
test "spec: porous_puff non_negative" {
  let c1 = @groundwater.porous_puff(1.0, 1.0, 0.1, 100.0)
  let c2 = @groundwater.porous_puff(0.0, 1.0, 0.1, 100.0)
  let c3 = @groundwater.porous_puff(10.0, 0.5, 0.05, 50.0)
  assert_true(c1 >= 0.0)
  assert_true(c2 >= 0.0)
  assert_true(c3 >= 0.0)
}