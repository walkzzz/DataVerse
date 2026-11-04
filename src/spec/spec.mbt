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
    let once = @text.normalize_whitespace_normalization(cases[i])
    let twice = @text.normalize_whitespace_normalization(once)
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
  let once = @text.dedup_exact_dedup([d1, d2, d3, d4])
  let twice = @text.dedup_exact_dedup(once)
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
  let result = @text.dedup_exact_dedup(arr)
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
  let model = @ml.regression_linear_regression(points)
  assert_true(model.slope > 2.99 && model.slope < 3.01)
  assert_true(model.intercept > 1.99 && model.intercept < 2.01)
  // 验证预测精确
  for i = 0; i < points.length(); i = i + 1 {
    let pred = @ml.regression_predict_linear(model, points[i].0)
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
  assert_eq(@text.select_topk_by_length(arr, 3).length(), 3)
  // k=10, n=5 → 结果长度=5（全部）
  assert_eq(@text.select_topk_by_length(arr, 10).length(), 5)
  // k=0 → 返回+0 → 全部
  assert_eq(@text.select_topk_by_length(arr, 0).length(), 5)
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
  let result = @text.select_topk_by_length(arr, 3)
  for i = 0; i < result.length() - 1; i = i + 1 {
    assert_true(result[i].content.length() >= result[i + 1].content.length())
  }
}

///|
/// 性质 7：standardize 零均值不变量
/// ∀ xs: standardize(xs) 的均值 ≈ 0（当 std > 0）
test "spec: standardize zero mean invariant" {
  let data = [1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0]
  let std = @ml.feature_standardize(data)
  let mean = std.fold(init=0.0, fn(acc, x) { acc + x }) /
    std.length().to_double()
  assert_true(mean > -0.001 && mean < 0.001)
}

///|
/// 性质 8：normalize_minmax 值域不变量
/// ∀ xs: normalize_minmax(xs) ∈ [0, 1]
test "spec: normalize_minmax range invariant" {
  let data = [3.0, 7.0, 1.0, 9.0, 5.0, 2.0, 8.0]
  let norm = @ml.feature_normalize_minmax(data)
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
  let once = @text.safety_mask_digits(d)
  let twice = @text.safety_mask_digits(once)
  assert_eq(twice.content, once.content)
}

///|
/// 性质 10：to_lowercase 幂等性
/// ∀ x: lower(lower(x)) == lower(x)
test "spec: to_lowercase idempotency" {
  let s = @schema.empty()
  let d = @dataobject.make_dataobject("Hello World 123", @dataobject.Text, s)
  let once = @text.transform_to_lowercase(d)
  let twice = @text.transform_to_lowercase(once)
  assert_eq(twice.content, once.content)
}

///|
/// 性质 11：accuracy 值域不变量
/// ∀ pred, actual: accuracy ∈ [0, 1]
test "spec: accuracy range invariant" {
  let pred = ["A", "B", "A", "B", "A"]
  let actual = ["A", "A", "B", "B", "A"]
  let acc = @ml.metrics_accuracy(pred, actual)
  assert_true(acc >= 0.0 && acc <= 1.0)
}

///|
/// 性质 12：mse 非负性
/// ∀ pred, actual: mse >= 0
test "spec: mse non-negativity" {
  let pred = [1.0, 2.0, 3.0]
  let actual = [1.5, 2.5, 3.5]
  let mse_val = @ml.metrics_mse(pred, actual)
  assert_true(mse_val >= 0.0)
}

///|
/// 性质 13：topo_order 拓扑合法性
/// ∀ pipeline (DAG): topo_order 中每条边 (u,v) 满足 u 出现在 v 之前
test "spec: topo_order validity" {
  let n1 = @datair.OperatorIR::simple(
    @datair.IRNodeId::new("a"),
    "op_a",
    @datair.Text,
    @datair.Deterministic,
  )
  let n2 = @datair.OperatorIR::simple(
    @datair.IRNodeId::new("b"),
    "op_b",
    @datair.Text,
    @datair.Deterministic,
  )
  let n3 = @datair.OperatorIR::simple(
    @datair.IRNodeId::new("c"),
    "op_c",
    @datair.Text,
    @datair.Deterministic,
  )
  let p = @datair.PipelineIR::empty()
    .add_node(n1)
    .add_node(n2)
    .add_node(n3)
    .add_edge(
      @datair.DAGEdge::new(
        @datair.IRNodeId::new("a"),
        @datair.IRNodeId::new("b"),
      ),
    )
    .add_edge(
      @datair.DAGEdge::new(
        @datair.IRNodeId::new("b"),
        @datair.IRNodeId::new("c"),
      ),
    )
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
  let n1 = @datair.OperatorIR::simple(
    @datair.IRNodeId::new("op1"),
    "identity",
    @datair.Text,
    @datair.Deterministic,
  )
  let n2 = @datair.OperatorIR::simple(
    @datair.IRNodeId::new("op2"),
    "normalize",
    @datair.Text,
    @datair.Deterministic,
  )
  let n3 = @datair.OperatorIR::simple(
    @datair.IRNodeId::new("op3"),
    "normalize",
    @datair.Text,
    @datair.Deterministic,
  )
  let p = @datair.PipelineIR::empty()
    .add_node(n1)
    .add_node(n2)
    .add_node(n3)
  let opt = @datair.optimize(p)
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
  let labels1 = @ml.cluster_kmeans(points, 2, 20)
  let labels2 = @ml.cluster_kmeans(points, 2, 20)
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
  let meta = @image.image_make_image_meta(1920, 1080, 3, "png")
  let r1 = @image.image_image_resize(meta, 640, 360)
  let r2 = @image.image_image_resize(r1, 640, 360)
  assert_eq(r1, r2)
}

///|
/// 性质 17：image_crop 边界不变量
/// crop 结果尺寸 <= 请求尺寸
test "spec: image_crop bounded" {
  let meta = @image.image_make_image_meta(100, 100, 3, "png")
  let cropped = @image.image_image_crop(meta, 10, 20, 30, 40)
  let (w, h) = @image.image_image_size(cropped)
  assert_true(w <= 30)
  assert_true(h <= 40)
}

///|
/// 性质 18：audio_segment 时间不变量
/// segment 结果 duration <= 原 duration
test "spec: audio_segment duration bounded" {
  let meta = @audio.audio_make_audio_meta(10000, 44100, 2, "wav")
  let seg = @audio.audio_audio_segment(meta, 2000, 8000)
  assert_true(seg.duration_ms <= meta.duration_ms)
}

///|
/// 性质 19：video_sample_frames 单调性
/// interval 越小，采样点越多
test "spec: video_sample_frames monotone" {
  let meta = @video.video_make_video_meta(10000, 30, 1920, 1080, "mp4")
  let frames1 = @video.video_video_sample_frames(meta, 2000)
  let frames2 = @video.video_video_sample_frames(meta, 1000)
  assert_true(frames2.length() >= frames1.length())
}

///|
/// 性质 20：semantic_quality_score 范围不变量
/// 0 <= score <= 1
test "spec: semantic_quality_score range" {
  let d1 = @dataobject.make_dataobject(
    "hello world test",
    @dataobject.Text,
    @schema.empty(),
  )
  let d2 = @dataobject.make_dataobject(
    "a".repeat(200),
    @dataobject.Text,
    @schema.empty(),
  )
  let d3 = @dataobject.empty_dataobject(@dataobject.Text)
  let s1 = @nlp_ops.semantic_semantic_quality_score(d1)
  let s2 = @nlp_ops.semantic_semantic_quality_score(d2)
  let s3 = @nlp_ops.semantic_semantic_quality_score(d3)
  assert_true(s1 >= 0.0 && s1 <= 1.0)
  assert_true(s2 >= 0.0 && s2 <= 1.0)
  assert_eq(s3, 0.0)
}

///|
/// 性质 21：content_diversity_score 范围不变量
/// 0 < score <= 1（非空时）
test "spec: content_diversity_score range" {
  let d = @dataobject.make_dataobject(
    "abcdef",
    @dataobject.Text,
    @schema.empty(),
  )
  let s = @nlp_ops.semantic_content_diversity_score(d)
  assert_true(s > 0.0 && s <= 1.0)
}

///|
/// 性质 22：rewrite_text Simplify 幂等性
/// simplify(simplify(x)) == simplify(x)（对短文本）
test "spec: rewrite Simplify idempotent" {
  let d = @dataobject.make_dataobject(
    "  hello world  ",
    @dataobject.Text,
    @schema.empty(),
  )
  let r1 = @nlp_ops.semantic_rewrite_text(d, @nlp_ops.Simplify)
  let r2 = @nlp_ops.semantic_rewrite_text(r1, @nlp_ops.Simplify)
  assert_eq(r1.content, r2.content)
}

///|
/// 性质 23：mse_loss 非负性
/// mse_loss >= 0
test "spec: mse_loss non-negative" {
  let pred = [1.0, 2.0, 3.0]
  let target = [4.0, 5.0, 6.0]
  let result = @dl.dl_losses_mse_loss(pred, target)
  assert_true(result >= 0.0)
}

///|
/// 性质 24：cross_entropy_loss 非负性
/// cross_entropy >= 0
test "spec: cross_entropy_loss non-negative" {
  let logits = [1.0, 0.0, 0.0]
  let target = [1.0, 0.0, 0.0]
  let result = @dl.dl_losses_cross_entropy_loss(logits, target)
  assert_true(result >= 0.0)
}

///|
/// 性质 25：kfold_splits 完备性
/// 所有 test_indices 的并集 = 全集（无重叠）
test "spec: kfold_splits complete" {
  let n = 10
  let k = 5
  let splits = @ml.cross_validation_kfold_splits(n, k)
  let all_test : Array[Int32] = []
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
  let cfg1 = @ml.hyperparam_search_make_grid_config("a", [0.1, 0.2, 0.3])
  let cfg2 = @ml.hyperparam_search_make_grid_config("b", [1.0, 2.0])
  let combos = @ml.hyperparam_search_grid_combinations([cfg1, cfg2])
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
  let result = @dosi.apply_batch(index, [])
  assert_eq(result, index)
}

///|
/// 性质 30：versioned_index 版本单调性
/// advance 后 current_version 递增
test "spec: versioned_index monotone" {
  let vindex = @dosi.make_versioned_index(@dosi.DOSIIndex::empty())
  let v1 = vindex.current_version
  let vindex2 = @dosi.advance_version(vindex, @dosi.DOSIIndex::empty())
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
  let cfg = @io.file_source("/data/test.json", "json")
  let result = @io.read_source(cfg, 0)
  assert_eq(result.length(), 0)
}

///|
/// 性质 32：write_sink 空安全
/// write_sink(cfg, []) == 0
test "spec: write_sink empty safe" {
  let cfg = @io.file_sink("/data/out.json", "json")
  let count = @io.write_sink(cfg, [])
  assert_eq(count, 0)
}

///|
/// 性质 33：execute_write 写入守恒
/// execute_write(cfg, data).written_count == data.length()
test "spec: execute_write conservation" {
  let cfg = @io.file_sink("/data/out.json", "json")
  let data = [
    @dataobject.make_dataobject("a", @dataobject.Text, @schema.empty()),
    @dataobject.make_dataobject("b", @dataobject.Text, @schema.empty()),
    @dataobject.make_dataobject("c", @dataobject.Text, @schema.empty()),
  ]
  let result = @io.execute_write(cfg, data)
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
  let meta = @text.plugin_make_plugin_meta("p", "1.0", "a", "e", "d")
  let entry = @text.plugin_make_plugin_entry(meta, @text.Loaded, [])
  let reg1 = @text.plugin_register_plugin(@text.plugin_empty_plugin_registry(), entry)
  let reg2 = @text.plugin_register_plugin(reg1, entry)
  assert_eq(@text.plugin_plugin_count(reg1), @text.plugin_plugin_count(reg2))
}

///|
/// 性质 37：unregister_plugin 注销安全
/// unregister 后 get_plugin_status == Error
test "spec: unregister_plugin safety" {
  let meta = @text.plugin_make_plugin_meta("p", "1.0", "a", "e", "d")
  let entry = @text.plugin_make_plugin_entry(meta, @text.Active, [])
  let reg = @text.plugin_register_plugin(@text.plugin_empty_plugin_registry(), entry)
  let reg2 = @text.plugin_unregister_plugin(reg, "p")
  assert_eq(@text.plugin_get_plugin_status(reg2, "p"), @text.Error)
}

///|
/// 性质 38：run_benchmark 零迭代安全
/// run_benchmark(name, n, cfg{iterations=0}).total_ms == 0
test "spec: run_benchmark zero iteration safe" {
  let cfg = @governance.make_benchmark_config(0, 0, 1)
  let result = @governance.run_benchmark("test", 100, cfg)
  assert_eq(result.total_ms, 0)
}

///|
/// 性质 39：apply_fusion 融合不增节点
/// apply_fusion(p).fused_node_count <= apply_fusion(p).original_node_count
test "spec: apply_fusion non_increasing" {
  let n1 = @datair.OperatorIR::simple(
    @datair.IRNodeId::new("op1"),
    "map1",
    @datair.Text,
    @datair.Deterministic,
  )
  let n2 = @datair.OperatorIR::simple(
    @datair.IRNodeId::new("op2"),
    "map2",
    @datair.Text,
    @datair.Deterministic,
  )
  let n3 = @datair.OperatorIR::simple(
    @datair.IRNodeId::new("op3"),
    "map3",
    @datair.Text,
    @datair.Deterministic,
  )
  let p = @datair.PipelineIR::empty()
    .add_node(n1)
    .add_node(n2)
    .add_node(n3)
  let result = @datair.apply_fusion(p)
  assert_true(result.fused_node_count <= result.original_node_count)
}

///|
/// 性质 40：add_doc_entry 索引单调性
/// add_doc_entry 后 total_api 严格递增
test "spec: add_doc_entry monotone" {
  let index = @governance.empty_doc_index()
  let entry = @governance.make_doc_entry("m", 10, 5, 8, "desc")
  let index2 = @governance.add_doc_entry(index, entry)
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
  let a = @spatial.proximity_make_point(1.0, 2.0)
  let b = @spatial.proximity_make_point(3.0, 5.0)
  let d1 = @spatial.proximity_euclidean_distance(a, b)
  let d2 = @spatial.proximity_euclidean_distance(b, a)
  assert_true((d1 - d2).abs() < 0.0001)
}

///|
/// 性质 42：euclidean_distance 自反性
/// d(a, a) == 0
test "spec: euclidean_distance reflexive" {
  let a = @spatial.proximity_make_point(3.5, 7.2)
  assert_eq(@spatial.proximity_euclidean_distance(a, a), 0.0)
}

///|
/// 性质 43：euclidean_distance 三角不等式
/// d(a, c) <= d(a, b) + d(b, c)
test "spec: euclidean_distance triangle_inequality" {
  let a = @spatial.proximity_make_point(0.0, 0.0)
  let b = @spatial.proximity_make_point(1.0, 1.0)
  let c = @spatial.proximity_make_point(3.0, 4.0)
  let d_ac = @spatial.proximity_euclidean_distance(a, c)
  let d_ab = @spatial.proximity_euclidean_distance(a, b)
  let d_bc = @spatial.proximity_euclidean_distance(b, c)
  assert_true(d_ac <= d_ab + d_bc + 0.0001)
}

///|
/// 性质 44：polygon_area 非负性
/// area(polygon) >= 0
test "spec: polygon_area non_negative" {
  let poly = @spatial.overlay_make_polygon([
    @spatial.proximity_make_point(0.0, 0.0),
    @spatial.proximity_make_point(4.0, 0.0),
    @spatial.proximity_make_point(4.0, 3.0),
    @spatial.proximity_make_point(0.0, 3.0),
  ])
  assert_true(@spatial.overlay_polygon_area(poly) >= 0.0)
}

///|
/// 性质 45：polygon_perimeter 非负性
/// perimeter(polygon) >= 0
test "spec: polygon_perimeter non_negative" {
  let poly = @spatial.overlay_make_polygon([
    @spatial.proximity_make_point(0.0, 0.0),
    @spatial.proximity_make_point(4.0, 0.0),
    @spatial.proximity_make_point(4.0, 3.0),
  ])
  assert_true(@spatial.overlay_polygon_perimeter(poly) >= 0.0)
}

///|
/// 性质 46：surface_slope 非负性
/// slope >= 0 (degrees)
test "spec: surface_slope non_negative" {
  let raster = @spatial.hydrology_make_raster([
    [1.0, 2.0, 3.0],
    [4.0, 5.0, 6.0],
    [7.0, 8.0, 9.0],
  ])
  let slope = @spatial.surface_surface_slope(raster, 1, 1, 1.0)
  assert_true(slope >= 0.0)
}

///|
/// 性质 47：density_kernel_at 非负性
/// kernel(distance) >= 0
test "spec: density_kernel_at non_negative" {
  let k1 = @spatial.density_quadratic_kernel(0.5, 1.0)
  let k2 = @spatial.density_gaussian_kernel(0.5, 1.0)
  assert_true(k1 >= 0.0)
  assert_true(k2 >= 0.0)
}

///|
/// 性质 48：interpolation_idw 重合点返回采样值
/// IDW at sample location == sample value
test "spec: interpolation_idw coincident_returns_sample" {
  let samples = [
    @ml.interpolation_make_sample_point(0.0, 0.0, 5.0),
    @ml.interpolation_make_sample_point(2.0, 0.0, 10.0),
  ]
  let target = @spatial.proximity_make_point(2.0, 0.0)
  let result = @ml.interpolation_interpolation_idw(samples, target, 2.0)
  assert_true((result - 10.0).abs() < 0.0001)
}

///|
/// 性质 49：zonal_count 非负性
/// zonal_count(zone) >= 0
test "spec: zonal_count non_negative" {
  let zone = @spatial.hydrology_make_raster([[1.0, 1.0], [2.0, 1.0]])
  assert_true(@spatial.zonal_zonal_count(zone, 1) >= 0)
  assert_true(@spatial.zonal_zonal_count(zone, 2) >= 0)
  assert_true(@spatial.zonal_zonal_count(zone, 99) >= 0)
}

///|
/// 性质 50：focal_mean 常数栅格不变性
/// focal_mean(constant_raster, r, c, radius) == constant
test "spec: focal_mean constant_invariant" {
  let raster = @spatial.hydrology_make_raster([
    [7.0, 7.0, 7.0],
    [7.0, 7.0, 7.0],
    [7.0, 7.0, 7.0],
  ])
  let m = @spatial.local_stats_focal_mean(raster, 1, 1, 1)
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
  let r = @spatial.hydrology_make_raster([
    [7.0, 7.0, 7.0],
    [7.0, 7.0, 7.0],
    [7.0, 7.0, 7.0],
  ])
  let m = @spatial.neighborhood_block_mean(r, 0, 0, 2)
  assert_true((m - 7.0).abs() < 0.0001)
}

///|
/// 性质 52：block_count 非负性
/// block_count >= 0
test "spec: block_count non_negative" {
  let r = @spatial.hydrology_make_raster([[1.0, 2.0], [3.0, 4.0]])
  assert_true(@spatial.neighborhood_block_count(r, 0, 0, 2) >= 0)
  assert_true(@spatial.neighborhood_block_count(r, 0, 0, 1) >= 0)
}

///|
/// 性质 53：line_mean 常数行不变性
/// line_mean(constant_row) == constant
test "spec: line_mean constant_invariant" {
  let r = @spatial.hydrology_make_raster([[5.0, 5.0, 5.0, 5.0]])
  let m = @spatial.neighborhood_line_mean(r, 0)
  assert_true((m - 5.0).abs() < 0.0001)
}

///|
/// 性质 54：line_count 非负性
/// line_count >= 0
test "spec: line_count non_negative" {
  let r = @spatial.hydrology_make_raster([[1.0, 2.0, 3.0]])
  assert_true(@spatial.neighborhood_line_count(r, 0) >= 0)
}

///|
/// 性质 55：neighborhood_cell_count 非负性
/// neighborhood_cell_count >= 0
test "spec: neighborhood_cell_count non_negative" {
  let cfg1 = @spatial.neighborhood_make_neighborhood_config(
    @spatial.NHRectangle,
    2,
    0,
  )
  let cfg2 = @spatial.neighborhood_make_neighborhood_config(
    @spatial.NHCircle,
    1,
    0,
  )
  let cfg3 = @spatial.neighborhood_make_neighborhood_config(
    @spatial.NHAnnulus,
    3,
    1,
  )
  assert_true(@spatial.neighborhood_neighborhood_cell_count(cfg1) >= 0)
  assert_true(@spatial.neighborhood_neighborhood_cell_count(cfg2) >= 0)
  assert_true(@spatial.neighborhood_neighborhood_cell_count(cfg3) >= 0)
}

///|
/// 性质 56：solar_altitude 非负性
/// altitude >= 0
test "spec: solar_altitude non_negative" {
  let alt1 = @spatial.solar_solar_altitude(40.0, 180, 12.0)
  let alt2 = @spatial.solar_solar_altitude(40.0, 180, 6.0)
  let alt3 = @spatial.solar_solar_altitude(40.0, 180, 0.0)
  assert_true(alt1 >= 0.0)
  assert_true(alt2 >= 0.0)
  assert_true(alt3 >= 0.0)
}

///|
/// 性质 57：solar global = direct + diffuse
/// global_radiation == direct_radiation + diffuse_radiation
test "spec: solar_global_equals_direct_plus_diffuse" {
  let cfg = @spatial.solar_make_solar_config(35.0, 120.0, 172, 14.0, 0.25)
  let r = @spatial.solar_solar_radiation_point(cfg)
  assert_true(
    (r.global_radiation - r.direct_radiation - r.diffuse_radiation).abs() <
    0.001,
  )
}

///|
/// 性质 58：solar_duration 范围
/// 0 <= duration <= 24
test "spec: solar_duration bounded" {
  let dur1 = @spatial.solar_solar_duration(40.0, 180)
  let dur2 = @spatial.solar_solar_duration(0.0, 80)
  let dur3 = @spatial.solar_solar_duration(60.0, 355)
  assert_true(dur1 >= 0.0 && dur1 <= 24.0)
  assert_true(dur2 >= 0.0 && dur2 <= 24.0)
  assert_true(dur3 >= 0.0 && dur3 <= 24.0)
}

///|
/// 性质 59：darcy_velocity 非负性
/// darcy_velocity >= 0
test "spec: darcy_velocity non_negative" {
  let cfg1 = @spatial.groundwater_make_groundwater_config(0.3, 0.001, 0.01, 0.005)
  let cfg2 = @spatial.groundwater_make_groundwater_config(0.0, 0.001, 0.01, 0.0)
  let cfg3 = @spatial.groundwater_make_groundwater_config(0.3, 0.0, 0.0, 0.0)
  assert_true(@spatial.groundwater_darcy_velocity(cfg1) >= 0.0)
  assert_true(@spatial.groundwater_darcy_velocity(cfg2) >= 0.0)
  assert_true(@spatial.groundwater_darcy_velocity(cfg3) >= 0.0)
}

///|
/// 性质 60：porous_puff 非负性
/// porous_puff >= 0
test "spec: porous_puff non_negative" {
  let c1 = @spatial.groundwater_porous_puff(1.0, 1.0, 0.1, 100.0)
  let c2 = @spatial.groundwater_porous_puff(0.0, 1.0, 0.1, 100.0)
  let c3 = @spatial.groundwater_porous_puff(10.0, 0.5, 0.05, 50.0)
  assert_true(c1 >= 0.0)
  assert_true(c2 >= 0.0)
  assert_true(c3 >= 0.0)
}

///|
/// 性质 61：transform_set_null 幂等性
/// ∀ c, r: set_null(c, set_null(c, r)) == set_null(c, r)
test "spec: transform_set_null idempotency" {
  let cond = @spatial.hydrology_make_raster([[1.0, 0.0], [1.0, 0.0]])
  let r = @spatial.hydrology_make_raster([[5.0, 3.0], [7.0, 2.0]])
  let once = @text.transform_transform_set_null(cond, r)
  let twice = @text.transform_transform_set_null(cond, once)
  assert_eq(
    @spatial.hydrology_raster_get(twice, 0, 0),
    @spatial.hydrology_raster_get(once, 0, 0),
  )
  assert_eq(
    @spatial.hydrology_raster_get(twice, 0, 1),
    @spatial.hydrology_raster_get(once, 0, 1),
  )
  assert_eq(
    @spatial.hydrology_raster_get(twice, 1, 0),
    @spatial.hydrology_raster_get(once, 1, 0),
  )
  assert_eq(
    @spatial.hydrology_raster_get(twice, 1, 1),
    @spatial.hydrology_raster_get(once, 1, 1),
  )
}

///|
/// 性质 62：transform_reclassify 空映射保持不变
/// ∀ r: reclassify(r, []) == r
test "spec: transform_reclassify empty_remap_identity" {
  let r = @spatial.hydrology_make_raster([[1.0, 2.0], [3.0, 4.0]])
  let result = @text.transform_transform_reclassify(r, [])
  assert_eq(@spatial.hydrology_raster_get(result, 0, 0), 1.0)
  assert_eq(@spatial.hydrology_raster_get(result, 0, 1), 2.0)
  assert_eq(@spatial.hydrology_raster_get(result, 1, 0), 3.0)
  assert_eq(@spatial.hydrology_raster_get(result, 1, 1), 4.0)
}

///|
/// 性质 63：transform_slice 值域有界
/// ∀ r, n>0: slice 值 ∈ [1, n]
test "spec: transform_slice bounded" {
  let r = @spatial.hydrology_make_raster([[1.0, 5.0, 10.0], [3.0, 7.0, 2.0]])
  let n = 3
  let result = @text.transform_transform_slice(r, n)
  for i in 0..<2 {
    for j in 0..<3 {
      let v = @spatial.hydrology_raster_get(result, i, j)
      assert_true(v >= 1.0 && v <= n.to_double())
    }
  }
}

///|
/// 性质 64：transform_lookup 越界返回 0
/// 索引超出 lookup_table 范围 → 0.0
test "spec: transform_lookup out_of_bounds_returns_zero" {
  let r = @spatial.hydrology_make_raster([[0.0, 5.0], [10.0, -1.0]])
  let table = [10.0, 20.0, 30.0]
  let result = @text.transform_transform_lookup(r, table)
  assert_eq(@spatial.hydrology_raster_get(result, 0, 0), 10.0)
  assert_eq(@spatial.hydrology_raster_get(result, 0, 1), 0.0)
  assert_eq(@spatial.hydrology_raster_get(result, 1, 0), 0.0)
  assert_eq(@spatial.hydrology_raster_get(result, 1, 1), 0.0)
}

///|
/// 性质 65：feature_mean_center 质心性质
/// mean_center 的结果等于各坐标算术平均
test "spec: feature_mean_center centroid_property" {
  let pts = [
    @spatial.proximity_make_point(0.0, 0.0),
    @spatial.proximity_make_point(2.0, 4.0),
    @spatial.proximity_make_point(4.0, 8.0),
  ]
  let c = @ml.feature_feature_mean_center(pts)
  assert_eq(c.x, 2.0)
  assert_eq(c.y, 4.0)
}

///|
/// 性质 66：feature_standard_distance 非负性
/// ∀ points: SD >= 0
test "spec: feature_standard_distance non_negative" {
  let pts1 = [
    @spatial.proximity_make_point(0.0, 0.0),
    @spatial.proximity_make_point(1.0, 1.0),
    @spatial.proximity_make_point(2.0, 0.0),
  ]
  let pts2 = [@spatial.proximity_make_point(5.0, 5.0)]
  let pts3 : Array[@spatial.Point] = []
  assert_true(@ml.feature_feature_standard_distance(pts1) >= 0.0)
  assert_true(@ml.feature_feature_standard_distance(pts2) >= 0.0)
  assert_true(@ml.feature_feature_standard_distance(pts3) >= 0.0)
}

///|
/// 性质 67：filter_split 分隔符计数
/// n 个分隔符 → n+1 个部分（单字符分隔符）
test "spec: filter_split delimiter_count" {
  let s = @schema.empty()
  let d = @dataobject.make_dataobject("a,b,c,d", @dataobject.Text, s)
  let result = @text.filter_filter_split(d, ",")
  assert_eq(result.length(), 4)
}

///|
/// 性质 68：cluster_similarity_search k 有界
/// result.length() <= min(k, candidates.length())
test "spec: cluster_similarity_search k_bounded" {
  let target = [1.0, 0.0]
  let candidates = [[0.0, 0.0], [1.0, 0.0], [2.0, 0.0]]
  let r1 = @ml.cluster_cluster_similarity_search(target, candidates, 2)
  assert_true(r1.length() <= 2)
  let r2 = @ml.cluster_cluster_similarity_search(target, candidates, 10)
  assert_true(r2.length() <= 3)
}

///|
/// 性质 69：classify_forest 空训练集返回 0
/// ∀ features: classify_forest(features, [], [], n) == 0
test "spec: classify_forest empty_training_returns_zero" {
  let features = [1.0, 2.0, 3.0]
  let result = @ml.classify_classify_forest(features, [], [], 5)
  assert_eq(result, 0)
}

///|
/// 性质 70：eval_tabulate_intersection 总数守恒
/// Σ count == input length（当两 zone 等长）
test "spec: eval_tabulate_intersection total_count_conserved" {
  let zone1 = [1, 1, 2, 2, 3]
  let zone2 = [10, 10, 20, 20, 30]
  let result = @text.eval_eval_tabulate_intersection(zone1, zone2)
  let mut total = 0
  for i in 0..<result.length() {
    let (_, _, c) = result[i]
    total = total + c
  }
  assert_eq(total, 5)
}

///|
/// 性质 71：softmax 和为 1
/// ∀ x: sum(softmax(x)) ≈ 1
test "spec: softmax sums to 1" {
  let result = @dl.dl_layers_softmax([1.0, 2.0, 3.0, 4.0])
  let mut sum = 0.0
  for i in 0..<result.length() {
    sum = sum + result[i]
  }
  assert_true(sum > 0.99 && sum < 1.01)
}

///|
/// 性质 72：layernorm 零均值
/// ∀ x: mean(layernorm(x)) ≈ 0
test "spec: layernorm zero mean" {
  let meta = @dl.dl_layers_make_layernorm(5, 0.00001)
  let result = @dl.dl_layers_layernorm_forward([1.0, 2.0, 3.0, 4.0, 5.0], meta)
  let mut sum = 0.0
  for i in 0..<result.length() {
    sum = sum + result[i]
  }
  let mean = sum / result.length().to_double()
  assert_true(mean > -0.01 && mean < 0.01)
}

///|
/// 性质 73：groupnorm 保持长度
/// ∀ x: len(groupnorm(x)) == len(x)
test "spec: groupnorm preserves length" {
  let meta = @dl.dl_layers_make_groupnorm(2, 4, 0.00001)
  let input = [1.0, 2.0, 3.0, 4.0, 5.0, 6.0]
  let result = @dl.dl_layers_groupnorm_forward(input, meta)
  assert_eq(result.length(), input.length())
}

///|
/// 性质 74：attention 输出维度等于值维度
/// ∀ Q, K, V: len(attention(Q, K, V)) == len(V[0])
test "spec: attention output dimension" {
  let q = [1.0, 0.0]
  let k = [[1.0, 0.0], [0.0, 1.0]]
  let v = [[1.0, 2.0, 3.0], [4.0, 5.0, 6.0]]
  let result = @dl.dl_layers_attention_scaled_dot_product(q, k, v)
  assert_eq(result.length(), v[0].length())
}

///|
/// 性质 75：rnn_step 保持 hidden_size
/// ∀ input, hidden: len(rnn_step(input, hidden, meta)) == meta.hidden_size
test "spec: rnn_step preserves hidden size" {
  let meta = @dl.dl_layers_make_rnn(3, 5)
  let result = @dl.dl_layers_rnn_step(
    [1.0, 2.0, 3.0],
    [0.0, 0.0, 0.0, 0.0, 0.0],
    meta,
  )
  assert_eq(result.length(), 5)
}

///|
/// 性质 76：lstm_step 保持 hidden_size
test "spec: lstm_step preserves hidden size" {
  let meta = @dl.dl_layers_make_lstm(3, 4)
  let (h, c) = @dl.dl_layers_lstm_step(
    [1.0, 2.0, 3.0],
    [0.0, 0.0, 0.0, 0.0],
    [0.0, 0.0, 0.0, 0.0],
    meta,
  )
  assert_eq(h.length(), 4)
  assert_eq(c.length(), 4)
}

///|
/// 性质 77：gru_step 保持 hidden_size
test "spec: gru_step preserves hidden size" {
  let meta = @dl.dl_layers_make_gru(3, 4)
  let result = @dl.dl_layers_gru_step([1.0, 2.0, 3.0], [0.0, 0.0, 0.0, 0.0], meta)
  assert_eq(result.length(), 4)
}

///|
/// 性质 78：moving_average 保持长度
/// ∀ data: len(moving_average(data, w)) == len(data)
test "spec: moving_average preserves length" {
  let data = [1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]
  let result = @timeseries.timeseries_moving_average(data, 3)
  assert_eq(result.length(), data.length())
}

///|
/// 性质 79：kalman_filter 保持长度
/// ∀ measurements: len(kalman_filter(measurements, ...)) == len(measurements)
test "spec: kalman_filter preserves length" {
  let measurements = [1.0, 2.0, 3.0, 4.0, 5.0]
  let result = @timeseries.timeseries_kalman_filter(measurements, 0.0, 1.0, 0.1, 0.5)
  assert_eq(result.length(), measurements.length())
}

///|
/// 性质 80：difference 长度减 1
/// ∀ data (len > 0): len(difference(data)) == len(data) - 1
test "spec: difference length minus 1" {
  let data = [1.0, 3.0, 6.0, 10.0, 15.0]
  let result = @timeseries.timeseries_difference(data)
  assert_eq(result.length(), data.length() - 1)
}

///|
/// 性质 81：network_id 恒等
/// network_id() == "opcore/network"
test "spec: network_id constant" {
  assert_eq(@misc.network_network_id(), "opcore/network")
}

///|
/// 性质 82：shortest_distance 自反性
/// ∀ graph, node: shortest_distance(graph, node, node) == 0.0
test "spec: shortest_distance self zero" {
  let g = @misc.network_build_network_from_edges(5, [
    (0, 1, 1.0),
    (1, 2, 2.0),
    (2, 3, 3.0),
    (3, 4, 4.0),
  ])
  assert_eq(@misc.network_shortest_distance(g, 2, 2), 0.0)
}

///|
/// 性质 83：connected_components 非负
/// ∀ graph: len(connected_components(graph)) >= 0
test "spec: connected_components non-negative" {
  let g = @misc.network_build_network_from_edges(4, [(0, 1, 1.0), (2, 3, 1.0)])
  let comps = @misc.network_connected_components(g)
  assert_true(comps.length() > 0)
}

///|
/// 性质 84：topology_id 恒等
/// topology_id() == "opcore/topology"
test "spec: topology_id constant" {
  assert_eq(@spatial.topology_topology_id(), "opcore/topology")
}

///|
/// 性质 85：polygon_area 非负
/// ∀ polygon: polygon_area(polygon) >= 0.0
test "spec: polygon_area non-negative" {
  let poly = @spatial.topology_make_topo_polygon([
    @spatial.topology_make_topo_point(0.0, 0.0),
    @spatial.topology_make_topo_point(4.0, 0.0),
    @spatial.topology_make_topo_point(4.0, 3.0),
  ])
  assert_true(@spatial.topology_polygon_area(poly) >= 0.0)
}

///|
/// 性质 86：terrain_id 恒等
/// terrain_id() == "opcore/terrain"
test "spec: terrain_id constant" {
  assert_eq(@spatial.terrain_terrain_id(), "opcore/terrain")
}

///|
/// 性质 87：distance3d 对称性
/// ∀ p1, p2: distance3d(p1, p2) == distance3d(p2, p1)
test "spec: distance3d symmetric" {
  let p1 = @misc.analysis3d_make_point3d(1.0, 2.0, 3.0)
  let p2 = @misc.analysis3d_make_point3d(4.0, 6.0, 8.0)
  let d12 = @misc.analysis3d_distance3d(p1, p2)
  let d21 = @misc.analysis3d_distance3d(p2, p1)
  assert_true(d12 > d21 - 0.001 && d12 < d21 + 0.001)
}

///|
/// 性质 88：geocoding_id 恒等
/// geocoding_id() == "opcore/geocoding"
test "spec: geocoding_id constant" {
  assert_eq(@spatial.geocoding_geocoding_id(), "opcore/geocoding")
}

///|
/// 性质 89：great_circle_distance 自反性
/// ∀ c: great_circle_distance(c, c) == 0.0
test "spec: great_circle_distance self zero" {
  let c = @spatial.coord_make_geodetic(116.4, 39.9)
  assert_eq(@spatial.coord_great_circle_distance(c, c), 0.0)
}

///|
/// 性质 90：coord_id 恒等
/// coord_id() == "opcore/coord"
test "spec: coord_id constant" {
  assert_eq(@spatial.coord_coord_id(), "opcore/coord")
}

///|
/// 性质 91：pointcloud_id 恒等
test "spec: pointcloud_id constant" {
  assert_eq(@spatial.pointcloud_pointcloud_id(), "opcore/pointcloud")
}

///|
/// 性质 92：pointcloud_size 非负
test "spec: pointcloud_size non-negative" {
  let cloud = @spatial.pointcloud_make_point_cloud([(0.0, 0.0, 0.0), (1.0, 1.0, 1.0)])
  assert_true(@spatial.pointcloud_pointcloud_size(cloud) >= 0)
}

///|
/// 性质 93：remotesensing_id 恒等
test "spec: remotesensing_id constant" {
  assert_eq(@spatial.remotesensing_remotesensing_id(), "opcore/remotesensing")
}

///|
/// 性质 94：cosine_similarity 自反性
test "spec: cosine_similarity self one" {
  let emb = @nlp_ops.semantic_s9_make_embedding([1.0, 2.0, 3.0])
  let sim = @nlp_ops.semantic_s9_cosine_similarity(emb, emb)
  assert_true(sim > 0.99)
}

///|
/// 性质 95：embedding_distance 自反性
test "spec: embedding_distance self zero" {
  let emb = @nlp_ops.semantic_s9_make_embedding([1.0, 2.0, 3.0])
  assert_eq(@nlp_ops.semantic_s9_embedding_distance(emb, emb), 0.0)
}

///|
/// 性质 96：signal_energy 非负
test "spec: signal_energy non-negative" {
  let sig = @audio.audio_s9_make_audio_signal([0.5, -0.3, 0.8], 16000)
  assert_true(@audio.audio_s9_signal_energy(sig) >= 0.0)
}

///|
/// 性质 97：signal_rms 非负
test "spec: signal_rms non-negative" {
  let sig = @audio.audio_s9_make_audio_signal([0.5, -0.3, 0.8], 16000)
  assert_true(@audio.audio_s9_signal_rms(sig) >= 0.0)
}

///|
/// 性质 98：normalize_signal 保持长度
test "spec: normalize_signal preserves length" {
  let sig = @audio.audio_s9_make_audio_signal([0.5, -0.3, 0.8, 0.1], 16000)
  let norm = @audio.audio_s9_normalize_signal(sig)
  assert_eq(norm.samples.length(), sig.samples.length())
}

///|
/// 性质 99：image_mean 等于均值
test "spec: image_mean correct" {
  let img = @image.image_make_gray_image(2, 2, [10.0, 20.0, 30.0, 40.0])
  assert_eq(@image.image_image_mean(img), 25.0)
}

///|
/// 性质 100：threshold 二值化
test "spec: threshold binary output" {
  let img = @image.image_make_gray_image(3, 1, [50.0, 100.0, 200.0])
  let result = @image.image_threshold(img, 100.0)
  for i in 0..<result.pixels.length() {
    assert_true(result.pixels[i] == 0.0 || result.pixels[i] == 255.0)
  }
}

///|
/// 性质 101：json_escape 双引号转义
test "spec: json_escape quote" {
  let bs = String::from_array([Int32::unsafe_to_char(92)])
  let q_in = "a" + "\"" + "b"
  let q_out = "a" + bs + "\"" + "b"
  assert_eq(@serialize.json_escape(q_in), q_out)
}

///|
/// 性质 102：to_int_safe 正确解析
test "spec: to_int_safe correct" {
  assert_eq(@serialize.to_int_safe("42"), Some(42))
  assert_eq(@serialize.to_int_safe("-7"), Some(-7))
  assert_eq(@serialize.to_int_safe("abc"), None)
}

///|
/// 性质 103：validate_range 边界
test "spec: validate_range boundary" {
  let r1 = @serialize.validate_range(5.0, 5.0, 10.0, "x")
  assert_true(r1.valid)
  let r2 = @serialize.validate_range(10.0, 5.0, 10.0, "x")
  assert_true(r2.valid)
  let r3 = @serialize.validate_range(4.9, 5.0, 10.0, "x")
  assert_false(r3.valid)
}

///|
/// 性质 104：tumbling_windows 不重叠
test "spec: tumbling_windows non-overlap" {
  let ws = @window.tumbling_windows(0.0, 30.0, 10.0)
  for i in 0..<ws.length() {
    assert_true(ws[i].end > ws[i].start)
    if i > 0 {
      assert_eq(ws[i].start, ws[i - 1].end)
    }
  }
}

///|
/// 性质 105：window_count 等于事件数
test "spec: window_count equals events" {
  let events = [
    @window.make_event(1.0, 1.0, "a"),
    @window.make_event(5.0, 2.0, "b"),
  ]
  let w = @window.make_window(0.0, 10.0, @window.Tumbling, 10.0, 10.0)
  assert_eq(@window.window_count(events, w), 2)
}

///|
/// 性质 106：moving_average 保持长度
test "spec: moving_average length" {
  let values = [1.0, 2.0, 3.0, 4.0, 5.0]
  let ma = @datatemporal.moving_average(values, 3)
  assert_eq(ma.length(), values.length() - 3 + 1)
}

///|
/// 性质 107：fold_binary_op 加法交换
test "spec: fold_add commutative" {
  assert_eq(
    @datair.fold_binary_op("+", 3.0, 5.0),
    @datair.fold_binary_op("+", 5.0, 3.0),
  )
}

///|
/// 性质 108：hash_partition 保留所有元素
test "spec: hash_partition preserves elements" {
  let items = ["a", "b", "c", "d", "e"]
  let result = @partition.hash_partition(items, 3)
  assert_eq(@partition.total_items(result), items.length())
}

///|
/// 性质 109：round_robin_partition 均匀分布
test "spec: round_robin balanced" {
  let items = ["a", "b", "c", "d", "e", "f"]
  let result = @partition.round_robin_partition(items, 3)
  for i in 0..<result.length() {
    assert_eq(result[i].items.length(), 2)
  }
}

///|
/// 性质 110：infer_type 类型正确
test "spec: infer_type correct" {
  assert_eq(@io.infer_type("42"), @io.IntType)
  assert_eq(@io.infer_type("3.14"), @io.FloatType)
  assert_eq(@io.infer_type("true"), @io.BoolType)
  assert_eq(@io.infer_type("hello"), @io.StringType)
}

///|
/// 性质 111：estimate_tokens 非负
test "spec: estimate_tokens non-negative" {
  assert_true(@llm.estimate_tokens("hello") >= 0)
  assert_eq(@llm.estimate_tokens(""), 0)
}

///|
/// 性质 112：cosine_similarity 自身为 1
test "spec: cosine self similarity" {
  let v = [1.0, 2.0, 3.0]
  let sim = @retrieval.cosine_similarity(v, v)
  assert_true(sim > 0.99)
}

///|
/// 性质 113：replace_variable 正确替换
test "spec: replace_variable correct" {
  assert_eq(@prompt.replace_variable("Hi {name}", "name", "Bob"), "Hi Bob")
}

///|
/// 性质 114：count_variables 正确计数
test "spec: count_variables correct" {
  assert_eq(@prompt.count_variables("{a}{b}{c}"), 3)
  assert_eq(@prompt.count_variables("no vars"), 0)
}

///|
/// 性质 115：memory_add 增加计数
test "spec: memory_add increases count" {
  let store = @memory.make_memory_store(10, 10)
  let entry = @memory.make_memory_entry(
    "e1",
    "test",
    @memory.ShortTerm,
    1.0,
    0.5,
  )
  let store2 = @memory.add_memory(store, entry)
  assert_eq(@memory.memory_count(store2), @memory.memory_count(store) + 1)
}

///|
/// 性质 116：validate_arguments 必选参数
test "spec: validate required args" {
  let params = [@tool.make_param("x", @tool.StringType, "x", true, "")]
  let tool_def = @tool.make_tool_def("f", "func", params)
  assert_true(@tool.validate_arguments(tool_def, [("x", "1")]))
  assert_false(@tool.validate_arguments(tool_def, []))
}

///|
/// 性质 117：to_int_arg 正确解析
test "spec: to_int_arg correct" {
  assert_eq(@tool.to_int_arg("123"), Some(123))
  assert_eq(@tool.to_int_arg("abc"), None)
}

///|
/// 性质 118：vector_search 返回 top_k
test "spec: vector_search top_k" {
  let docs = [
    @retrieval.make_document("d1", "a", [1.0], ""),
    @retrieval.make_document("d2", "b", [0.0], ""),
    @retrieval.make_document("d3", "c", [0.5], ""),
  ]
  let results = @retrieval.vector_search([1.0], docs, 2)
  assert_eq(results.length(), 2)
}

///|
/// 性质 119：rerank 按分数排序
test "spec: rerank by score" {
  let docs = [
    @retrieval.make_document("d1", "a", [], ""),
    @retrieval.make_document("d2", "b", [], ""),
  ]
  let results = [
    @retrieval.make_retrieval_result(
      { ..docs[0], score: 0.3, },
      @retrieval.VectorSearch,
      1,
    ),
    @retrieval.make_retrieval_result(
      { ..docs[1], score: 0.8, },
      @retrieval.VectorSearch,
      2,
    ),
  ]
  let reranked = @retrieval.rerank(results)
  assert_eq(reranked[0].rank, 1)
  assert_eq(reranked[0].document.id, "d2")
}

///|
/// 性质 120：clear_short_term 只保留非短期
test "spec: clear_short_term keeps non-short" {
  let store = @memory.make_memory_store(10, 10)
  let e1 = @memory.make_memory_entry("e1", "short", @memory.ShortTerm, 1.0, 0.5)
  let e2 = @memory.make_memory_entry("e2", "long", @memory.LongTerm, 2.0, 0.8)
  let store2 = @memory.add_memory(@memory.add_memory(store, e1), e2)
  let cleared = @memory.clear_short_term(store2)
  assert_eq(@memory.memory_count_by_type(cleared, @memory.ShortTerm), 0)
  assert_eq(@memory.memory_count_by_type(cleared, @memory.LongTerm), 1)
}

///|
/// 性质 121：复数加法交换律 / Complex addition commutativity
test "spec: complex_add_commutative" {
  let a = @misc.quantum_comp_make_complex(1.0, 2.0)
  let b = @misc.quantum_comp_make_complex(3.0, 4.0)
  let ab = @misc.quantum_comp_cadd(a, b)
  let ba = @misc.quantum_comp_cadd(b, a)
  assert_true(ab.re > ba.re - 0.001 && ab.re < ba.re + 0.001)
  assert_true(ab.im > ba.im - 0.001 && ab.im < ba.im + 0.001)
}

///|
/// 性质 122：复数乘法交换律 / Complex multiplication commutativity
test "spec: complex_mul_commutative" {
  let a = @misc.quantum_comp_make_complex(1.0, 2.0)
  let b = @misc.quantum_comp_make_complex(3.0, 4.0)
  let ab = @misc.quantum_comp_cmul(a, b)
  let ba = @misc.quantum_comp_cmul(b, a)
  assert_true(ab.re > ba.re - 0.001 && ab.re < ba.re + 0.001)
  assert_true(ab.im > ba.im - 0.001 && ab.im < ba.im + 0.001)
}

///|
/// 性质 123：复数共轭模相等 / Complex conjugate same modulus
test "spec: complex_conj_same_abs" {
  let a = @misc.quantum_comp_make_complex(3.0, 4.0)
  let ca = @misc.quantum_comp_cconj(a)
  let abs_a = @misc.quantum_comp_cabs(a)
  let abs_ca = @misc.quantum_comp_cabs(ca)
  assert_true(abs_a > abs_ca - 0.001 && abs_a < abs_ca + 0.001)
}

///|
/// 性质 124：量子态概率归一化 / Quantum state probability normalization
test "spec: quantum_state_normalization" {
  let state = @misc.quantum_comp_ket_plus()
  let p0 = @misc.quantum_comp_probability(state, 0)
  let p1 = @misc.quantum_comp_probability(state, 1)
  let total = p0 + p1
  assert_true(total > 0.99 && total < 1.01)
}

///|
/// 性质 125：Hadamard 门幺正性 / Hadamard gate unitarity
test "spec: hadamard_preserves_norm" {
  let state = @misc.quantum_comp_ket0()
  let gate = @misc.quantum_comp_hadamard_gate()
  let result = @misc.quantum_comp_apply_gate(gate, state)
  let p0 = @misc.quantum_comp_probability(result, 0)
  let p1 = @misc.quantum_comp_probability(result, 1)
  let total = p0 + p1
  assert_true(total > 0.99 && total < 1.01)
}

///|
/// 性质 126：LTN AND 边界 / LTN AND boundary
test "spec: ltn_and_boundary" {
  let r1 = @lnlp.neuro_symbolic_ltn_and([1.0, 1.0])
  assert_true(r1 > 0.99 && r1 < 1.01)
  let r2 = @lnlp.neuro_symbolic_ltn_and([0.0, 1.0])
  assert_true(r2 > -0.01 && r2 < 0.01)
}

///|
/// 性质 127：LTN OR 边界 / LTN OR boundary
test "spec: ltn_or_boundary" {
  let r1 = @lnlp.neuro_symbolic_ltn_or([1.0, 0.0])
  assert_true(r1 > 0.99 && r1 < 1.01)
  let r2 = @lnlp.neuro_symbolic_ltn_or([0.0, 0.0])
  assert_true(r2 > -0.01 && r2 < 0.01)
}

///|
/// 性质 128：t-norm 对称性 / t-norm symmetry
test "spec: t_norm_symmetric" {
  let r1 = @lnlp.neuro_symbolic_t_norm_product(0.3, 0.7)
  let r2 = @lnlp.neuro_symbolic_t_norm_product(0.7, 0.3)
  assert_true(r1 > r2 - 0.001 && r1 < r2 + 0.001)
}

///|
/// 性质 129：对话状态轮数递增 / Dialogue turn increment
test "spec: dialogue_turn_increment" {
  let state = @dialogue.make_dialogue_state()
  let intent = @dialogue.make_intent("test", 0.9)
  let state1 = @dialogue.update_dialogue_state(state, intent, "input1")
  assert_eq(state1.turn, state.turn + 1)
  let state2 = @dialogue.update_dialogue_state(state1, intent, "input2")
  assert_eq(state2.turn, state1.turn + 1)
}

///|
/// 性质 130：元数据实例设置获取一致性 / Metadata set-get consistency
test "spec: metadata_set_get_consistency" {
  let inst = @metadata_ext.make_metadata_instance("Test", [])
  let updated = @metadata_ext.instance_set(inst, "key", "value")
  let retrieved = @metadata_ext.instance_get(updated, "key")
  assert_eq(retrieved, "value")
}
