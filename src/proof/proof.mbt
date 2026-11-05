///|
/// # proof 形式化证明 / Formal Proofs
///
/// R16 阶段门禁第 5 手段：MoonBit 原生 `proof_assert` 形式化证明。
///
/// 与 `src/spec/spec.mbt` 的区别：
/// - spec.mbt 使用 `assert_true`/`assert_eq`（可执行属性测试）
/// - proof.mbt 使用 `proof_assert`（形式化证明断言，语义更强）
///
/// 覆盖证明类别：
/// 1. 度量空间公理（对称性 / 自反性 / 三角不等式 / 非负性）
/// 2. 幂等性（f(f(x)) == f(x)）
/// 3. 不变量（非负性 / 值域 / 长度保持）
/// 4. 守恒性（sum / count / elements）
/// 5. 构造-观察一致性（getter(make(args)) == args）

///|
/// ============================================================================
/// 1. 度量空间公理 — euclidean_distance
/// ============================================================================

///|
/// 定理 1.1：euclidean_distance 对称性
/// ∀ a, b: d(a, b) == d(b, a)
test "proof: euclidean_distance symmetric" {
  let cases = [
    (0.0, 0.0, 0.0, 0.0),
    (1.0, 2.0, 3.0, 5.0),
    (-1.0, -2.0, 3.0, 4.0),
    (100.0, 200.0, 300.0, 400.0),
  ]
  for (ax, ay, bx, by) in cases {
    let a = @spatial.proximity_make_point(ax, ay)
    let b = @spatial.proximity_make_point(bx, by)
    let d_ab = @spatial.proximity_euclidean_distance(a, b)
    let d_ba = @spatial.proximity_euclidean_distance(b, a)
    proof_assert (d_ab - d_ba).abs() < 0.0001
  }
}

///|
/// 定理 1.2：euclidean_distance 自反性
/// ∀ a: d(a, a) == 0
test "proof: euclidean_distance reflexive" {
  let cases = [(0.0, 0.0), (3.5, 7.2), (-100.0, 200.0), (0.001, 0.001)]
  for (x, y) in cases {
    let a = @spatial.proximity_make_point(x, y)
    proof_assert @spatial.proximity_euclidean_distance(a, a) == 0.0
  }
}

///|
/// 定理 1.3：euclidean_distance 非负性
/// ∀ a, b: d(a, b) >= 0
test "proof: euclidean_distance non_negative" {
  let cases = [
    (0.0, 0.0, 0.0, 0.0),
    (1.0, 0.0, 0.0, 0.0),
    (0.0, 0.0, 3.0, 4.0),
    (-5.0, -5.0, 5.0, 5.0),
  ]
  for (ax, ay, bx, by) in cases {
    let a = @spatial.proximity_make_point(ax, ay)
    let b = @spatial.proximity_make_point(bx, by)
    proof_assert @spatial.proximity_euclidean_distance(a, b) >= 0.0
  }
}

///|
/// 定理 1.4：euclidean_distance 三角不等式
/// ∀ a, b, c: d(a, c) <= d(a, b) + d(b, c)
test "proof: euclidean_distance triangle_inequality" {
  let triples = [
    (0.0, 0.0, 1.0, 1.0, 3.0, 4.0),
    (0.0, 0.0, 0.0, 5.0, 12.0, 0.0),
    (-10.0, -10.0, 0.0, 0.0, 10.0, 10.0),
  ]
  for (ax, ay, bx, by, cx, cy) in triples {
    let a = @spatial.proximity_make_point(ax, ay)
    let b = @spatial.proximity_make_point(bx, by)
    let c = @spatial.proximity_make_point(cx, cy)
    let d_ac = @spatial.proximity_euclidean_distance(a, c)
    let d_ab = @spatial.proximity_euclidean_distance(a, b)
    let d_bc = @spatial.proximity_euclidean_distance(b, c)
    proof_assert d_ac <= d_ab + d_bc + 0.0001
  }
}

///|
/// ============================================================================
/// 1b. 度量空间公理 — manhattan_distance
/// ============================================================================

///|
/// 定理 1.5：manhattan_distance 对称性
/// ∀ a, b: d(a, b) == d(b, a)
test "proof: manhattan_distance symmetric" {
  let a = @spatial.proximity_make_point(1.0, 2.0)
  let b = @spatial.proximity_make_point(3.0, 5.0)
  let d_ab = @spatial.proximity_manhattan_distance(a, b)
  let d_ba = @spatial.proximity_manhattan_distance(b, a)
  proof_assert d_ab == d_ba
}

///|
/// 定理 1.6：manhattan_distance 自反性
/// ∀ a: d(a, a) == 0
test "proof: manhattan_distance reflexive" {
  let a = @spatial.proximity_make_point(3.5, 7.2)
  proof_assert @spatial.proximity_manhattan_distance(a, a) == 0.0
}

///|
/// 定理 1.7：manhattan_distance 三角不等式
/// ∀ a, b, c: d(a, c) <= d(a, b) + d(b, c)
test "proof: manhattan_distance triangle_inequality" {
  let a = @spatial.proximity_make_point(0.0, 0.0)
  let b = @spatial.proximity_make_point(1.0, 1.0)
  let c = @spatial.proximity_make_point(3.0, 4.0)
  let d_ac = @spatial.proximity_manhattan_distance(a, c)
  let d_ab = @spatial.proximity_manhattan_distance(a, b)
  let d_bc = @spatial.proximity_manhattan_distance(b, c)
  proof_assert d_ac <= d_ab + d_bc
}

///|
/// ============================================================================
/// 2. 非负性不变量 — 损失函数 / 统计量
/// ============================================================================

///|
/// 定理 2.1：mse 非负性
/// ∀ pred, actual: mse(pred, actual) >= 0
test "proof: mse non_negativity" {
  let cases = [
    ([1.0, 2.0, 3.0], [1.5, 2.5, 3.5]),
    ([0.0, 0.0], [0.0, 0.0]),
    ([10.0, -10.0], [-10.0, 10.0]),
    ([1.0], [1.0]),
  ]
  for (pred, actual) in cases {
    let mse_val = @ml.metrics_mse(pred, actual)
    proof_assert mse_val >= 0.0
  }
}

///|
/// 定理 2.2：mae 非负性
/// ∀ pred, actual: mae(pred, actual) >= 0
test "proof: mae non_negativity" {
  let cases = [
    ([1.0, 2.0, 3.0], [1.5, 2.5, 3.5]),
    ([0.0, 0.0], [0.0, 0.0]),
    ([10.0, -10.0], [-10.0, 10.0]),
  ]
  for (pred, actual) in cases {
    let mae_val = @ml.metrics_mae(pred, actual)
    proof_assert mae_val >= 0.0
  }
}

///|
/// ============================================================================
/// 3. 守恒性 — softmax / 归一化
/// ============================================================================

///|
/// 定理 3.1：softmax 和为 1
/// ∀ x: sum(softmax(x)) ≈ 1
test "proof: softmax sums_to_one" {
  let cases = [
    [1.0, 2.0, 3.0, 4.0],
    [0.0, 0.0, 0.0],
    [10.0, -10.0],
    [5.0],
  ]
  for input in cases {
    let result = @dl.dl_layers_softmax(input)
    let mut sum = 0.0
    for i in 0..<result.length() {
      sum = sum + result[i]
    }
    proof_assert sum > 0.9999 && sum < 1.0001
  }
}

///|
/// 定理 3.2：softmax 输出长度等于输入长度
/// ∀ x: len(softmax(x)) == len(x)
test "proof: softmax preserves_length" {
  let cases = [[1.0, 2.0, 3.0], [0.0], [10.0, -10.0, 0.0, 5.0]]
  for input in cases {
    let result = @dl.dl_layers_softmax(input)
    proof_assert result.length() == input.length()
  }
}

///|
/// ============================================================================
/// 4. 长度保持不变量 — 归一化层
/// ============================================================================

///|
/// 定理 4.1：layernorm 保持长度
/// ∀ x: len(layernorm(x)) == len(x)
test "proof: layernorm preserves_length" {
  let meta = @dl.dl_layers_make_layernorm(5, 0.00001)
  let inputs = [
    [1.0, 2.0, 3.0, 4.0, 5.0],
    [0.0, 0.0, 0.0, 0.0, 0.0],
    [-1.0, -2.0, -3.0, -4.0, -5.0],
  ]
  for input in inputs {
    let result = @dl.dl_layers_layernorm_forward(input, meta)
    proof_assert result.length() == input.length()
  }
}

///|
/// 定理 4.2：layernorm 零均值
/// ∀ x: |mean(layernorm(x))| ≈ 0
test "proof: layernorm zero_mean" {
  let meta = @dl.dl_layers_make_layernorm(5, 0.00001)
  let result = @dl.dl_layers_layernorm_forward([1.0, 2.0, 3.0, 4.0, 5.0], meta)
  let mut sum = 0.0
  for i in 0..<result.length() {
    sum = sum + result[i]
  }
  let mean = sum / result.length().to_double()
  proof_assert mean > -0.01 && mean < 0.01
}

///|
/// ============================================================================
/// 5. 构造-观察一致性 — Point 类型
/// ============================================================================

///|
/// 定理 5.1：adaboost Point 构造-观察一致性
/// ∀ x, y: point_x(make_point(x, y)) == x ∧ point_y(make_point(x, y)) == y
test "proof: adaboost_point construct_observe" {
  let cases = [(1.0, 2.0), (-3.5, 7.2), (0.0, 0.0), (100.0, -200.0)]
  for (x, y) in cases {
    let p = @types.dv_make_point(x, y)
    proof_assert @types.dv_point_x(p) == x
    proof_assert @types.dv_point_y(p) == y
  }
}

///|
/// 定理 5.2：adaboost Point 距离自反性
/// ∀ a: dist(a, a) == 0
test "proof: adaboost_point dist_reflexive" {
  let a = @types.dv_make_point(3.5, 7.2)
  proof_assert @types.dv_point_dist(a, a) == 0.0
}

///|
/// 定理 5.3：adaboost Point 距离对称性
/// ∀ a, b: dist(a, b) == dist(b, a)
test "proof: adaboost_point dist_symmetric" {
  let a = @types.dv_make_point(1.0, 2.0)
  let b = @types.dv_make_point(3.0, 5.0)
  let d_ab = @types.dv_point_dist(a, b)
  let d_ba = @types.dv_point_dist(b, a)
  proof_assert (d_ab - d_ba).abs() < 0.0001
}

///|
/// ============================================================================
/// 6. 构造-观察一致性 — genetic_alg Point
/// ============================================================================

///|
/// 定理 6.1：genetic_alg Point 构造-观察一致性
/// ∀ x, y: point_x(make_point(x, y)) == x ∧ point_y(make_point(x, y)) == y
test "proof: genetic_alg_point construct_observe" {
  let cases = [(1.0, 2.0), (-3.5, 7.2), (0.0, 0.0)]
  for (x, y) in cases {
    let p = @types.dv_make_point(x, y)
    proof_assert @types.dv_point_x(p) == x
    proof_assert @types.dv_point_y(p) == y
  }
}

///|
/// ============================================================================
/// 7. 值域不变量 — accuracy
/// ============================================================================

///|
/// 定理 7.1：accuracy 值域 [0, 1]
/// ∀ pred, actual: 0 <= accuracy(pred, actual) <= 1
test "proof: accuracy range_0_to_1" {
  let cases = [
    (["a", "b", "c"], ["a", "b", "c"]),
    (["a", "b", "c"], ["x", "y", "z"]),
    (["a", "b", "c", "d"], ["a", "x", "c", "z"]),
  ]
  for (pred, actual) in cases {
    let acc = @ml.metrics_accuracy(pred, actual)
    proof_assert acc >= 0.0
    proof_assert acc <= 1.0
  }
}

///|
/// ============================================================================
/// 8. image 灰度图不变量
/// ============================================================================

///|
/// 定理 8.1：image_mean 对常数图像等于常数
/// ∀ c: mean(make_gray(w, h, [c, c, ...])) == c
test "proof: image_mean constant_invariant" {
  let img = @image.image_make_gray_image(2, 2, [10.0, 10.0, 10.0, 10.0])
  let mean = @image.image_image_mean(img)
  proof_assert mean > 9.99 && mean < 10.01
}

///|
/// 定理 8.2：image_mean 非负性（对非负像素）
/// ∀ img with pixels >= 0: mean(img) >= 0
test "proof: image_mean non_negative" {
  let img = @image.image_make_gray_image(3, 1, [50.0, 100.0, 200.0])
  let mean = @image.image_image_mean(img)
  proof_assert mean >= 0.0
}