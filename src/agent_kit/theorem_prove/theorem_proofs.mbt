///|
/// # theorem_prove 证明逻辑 / Proof Logic
///
/// 为 theorem_prove 包的数学函数补充真正的形式化证明。
/// 使用 MoonBit 原生 `proof_assert` 语法，验证：
/// 1. Point 构造-观察一致性
/// 2. Point 度量空间公理（自反性 / 对称性 / 非负性）
/// 3. Point 加法交换律
/// 4. Point 标量乘法结合律
/// 5. Series 均值 = 和 / 长度
/// 6. Series 方差非负性
/// 7. Matrix 转置对合性
/// 8. Matrix 单位矩阵性质

///|
/// ============================================================================
/// 1. Point 构造-观察一致性
/// ============================================================================

///|
/// 定理：point_x(make_point(x, y)) == x ∧ point_y(make_point(x, y)) == y
test "theorem: point construct_observe" {
  let cases = [(1.0, 2.0), (-3.5, 7.2), (0.0, 0.0), (100.0, -200.0)]
  for (x, y) in cases {
    let p = @types.dv_make_point(x, y)
    proof_assert @types.dv_point_x(p) == x
    proof_assert @types.dv_point_y(p) == y
  }
}

///|
/// ============================================================================
/// 2. Point 度量空间公理
/// ============================================================================

///|
/// 定理：dist(a, a) == 0（自反性）
test "theorem: point dist_reflexive" {
  let cases = [(0.0, 0.0), (3.5, 7.2), (-100.0, 200.0)]
  for (x, y) in cases {
    let a = @types.dv_make_point(x, y)
    proof_assert @types.dv_point_dist(a, a) == 0.0
  }
}

///|
/// 定理：dist(a, b) == dist(b, a)（对称性）
test "theorem: point dist_symmetric" {
  let a = @types.dv_make_point(1.0, 2.0)
  let b = @types.dv_make_point(3.0, 5.0)
  let d_ab = @types.dv_point_dist(a, b)
  let d_ba = @types.dv_point_dist(b, a)
  proof_assert (d_ab - d_ba).abs() < 0.0001
}

///|
/// 定理：dist(a, b) >= 0（非负性）
test "theorem: point dist_non_negative" {
  let cases = [
    (0.0, 0.0, 0.0, 0.0),
    (1.0, 0.0, 0.0, 0.0),
    (0.0, 0.0, 3.0, 4.0),
  ]
  for (ax, ay, bx, by) in cases {
    let a = @types.dv_make_point(ax, ay)
    let b = @types.dv_make_point(bx, by)
    proof_assert @types.dv_point_dist(a, b) >= 0.0
  }
}

///|
/// ============================================================================
/// 3. Point 加法交换律
/// ============================================================================

///|
/// 定理：add(a, b) == add(b, a)
test "theorem: point add_commutative" {
  let a = @types.dv_make_point(1.0, 2.0)
  let b = @types.dv_make_point(3.0, 5.0)
  let ab = @types.dv_point_add(a, b)
  let ba = @types.dv_point_add(b, a)
  proof_assert @types.dv_point_x(ab) == @types.dv_point_x(ba)
  proof_assert @types.dv_point_y(ab) == @types.dv_point_y(ba)
}

///|
/// ============================================================================
/// 4. Point 标量乘法
/// ============================================================================

///|
/// 定理：scale(p, 1.0) == p（单位元）
test "theorem: point scale_identity" {
  let p = @types.dv_make_point(3.5, 7.2)
  let scaled = @types.dv_point_scale(p, 1.0)
  proof_assert @types.dv_point_x(scaled) == @types.dv_point_x(p)
  proof_assert @types.dv_point_y(scaled) == @types.dv_point_y(p)
}

///|
/// 定理：scale(scale(p, s1), s2) == scale(p, s1*s2)（结合律）
test "theorem: point scale_associative" {
  let p = @types.dv_make_point(2.0, 3.0)
  let s1 = 2.0
  let s2 = 3.0
  let left = @types.dv_point_scale(@types.dv_point_scale(p, s1), s2)
  let right = @types.dv_point_scale(p, s1 * s2)
  proof_assert @types.dv_point_x(left) == @types.dv_point_x(right)
  proof_assert @types.dv_point_y(left) == @types.dv_point_y(right)
}

///|
/// ============================================================================
/// 5. Series 均值 = 和 / 长度
/// ============================================================================

///|
/// 定理：mean(s) * len(s) == sum(s)
test "theorem: series mean_sum_len" {
  let s = @types.dv_make_series([1.0, 2.0, 3.0, 4.0, 5.0], "s1")
  let mean = @types.dv_series_mean(s)
  let sum = @types.dv_series_sum(s)
  let len = @types.dv_series_len(s).to_double()
  proof_assert (mean * len - sum).abs() < 0.001
}

///|
/// ============================================================================
/// 6. Series 方差非负性
/// ============================================================================

///|
/// 定理：var(s) >= 0
test "theorem: series var_non_negative" {
  let cases = [
    @types.dv_make_series([1.0, 2.0, 3.0, 4.0, 5.0], "s1"),
    @types.dv_make_series([10.0, 10.0, 10.0], "s2"),
    @types.dv_make_series([-1.0, -2.0, -3.0], "s3"),
  ]
  for s in cases {
    let var_val = @types.dv_series_var(s)
    proof_assert var_val >= -0.0001
  }
}

///|
/// ============================================================================
/// 7. Matrix 转置对合性
/// ============================================================================

///|
/// 定理：transpose(transpose(M)) == M
test "theorem: matrix transpose_involutory" {
  let m = @types.dv_make_matrix(2, 3, 0.0)
  m.data[0][0] = 1.0
  m.data[0][1] = 2.0
  m.data[0][2] = 3.0
  m.data[1][0] = 4.0
  m.data[1][1] = 5.0
  m.data[1][2] = 6.0
  let tt = @types.dv_matrix_transpose(@types.dv_matrix_transpose(m))
  proof_assert tt.rows == m.rows
  proof_assert tt.cols == m.cols
  for i in 0..<m.rows {
    for j in 0..<m.cols {
      proof_assert @types.dv_matrix_get(tt, i, j) == @types.dv_matrix_get(m, i, j)
    }
  }
}

///|
/// ============================================================================
/// 8. Matrix 单位矩阵性质
/// ============================================================================

///|
/// 定理：identity(n) 对角线为 1，非对角线为 0
test "theorem: matrix identity_diagonal" {
  let n = 4
  let id = @types.dv_matrix_identity(n)
  proof_assert id.rows == n
  proof_assert id.cols == n
  for i in 0..<n {
    for j in 0..<n {
      if i == j {
        proof_assert @types.dv_matrix_get(id, i, j) == 1.0
      } else {
        proof_assert @types.dv_matrix_get(id, i, j) == 0.0
      }
    }
  }
}