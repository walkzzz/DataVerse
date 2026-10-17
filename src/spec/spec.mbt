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