///===
/// extcore/math_pde_solver

pub(all) struct MathpdesolverPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn math_pde_solver_make_point(x : Double, y : Double) -> MathpdesolverPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn math_pde_solver_make_point3(x : Double, y : Double, z : Double) -> MathpdesolverPoint {
  { x, y, z, label: 0 }
}

pub fn math_pde_solver_point_x(pt : MathpdesolverPoint) -> Double { pt.x }

pub fn math_pde_solver_point_y(pt : MathpdesolverPoint) -> Double { pt.y }

pub fn math_pde_solver_point_z(pt : MathpdesolverPoint) -> Double { pt.z }

pub fn math_pde_solver_point_label(pt : MathpdesolverPoint) -> Int { pt.label }

pub fn math_pde_solver_point_dist(a : MathpdesolverPoint, b : MathpdesolverPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn math_pde_solver_point_add(a : MathpdesolverPoint, b : MathpdesolverPoint) -> MathpdesolverPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn math_pde_solver_point_sub(a : MathpdesolverPoint, b : MathpdesolverPoint) -> MathpdesolverPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn math_pde_solver_point_scale(pt : MathpdesolverPoint, s : Double) -> MathpdesolverPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn math_pde_solver_point_dot(a : MathpdesolverPoint, b : MathpdesolverPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn math_pde_solver_point_cross(a : MathpdesolverPoint, b : MathpdesolverPoint) -> MathpdesolverPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn math_pde_solver_point_norm(pt : MathpdesolverPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn math_pde_solver_point_normalize(pt : MathpdesolverPoint) -> MathpdesolverPoint {
  let n = math_pde_solver_point_norm(pt)
  if n < 0.0000001 { pt } else { math_pde_solver_point_scale(pt, 1.0 / n) }
}

pub fn math_pde_solver_point_negate(pt : MathpdesolverPoint) -> MathpdesolverPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn math_pde_solver_point_mid(a : MathpdesolverPoint, b : MathpdesolverPoint) -> MathpdesolverPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn math_pde_solver_point_lerp(a : MathpdesolverPoint, b : MathpdesolverPoint, t : Double) -> MathpdesolverPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn math_pde_solver_point_to_string(pt : MathpdesolverPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct MathpdesolverSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn math_pde_solver_make_series(vals : Array[Double], name : String) -> MathpdesolverSeries {
  { vals, name, meta: 0 }
}

pub fn math_pde_solver_series_len(s : MathpdesolverSeries) -> Int { s.vals.length() }

pub fn math_pde_solver_series_sum(s : MathpdesolverSeries) -> Double { @_common.sum(s.vals) }

pub fn math_pde_solver_series_mean(s : MathpdesolverSeries) -> Double { @_common.mean(s.vals) }

pub fn math_pde_solver_series_min(s : MathpdesolverSeries) -> Double { @_common.min(s.vals) }

pub fn math_pde_solver_series_max(s : MathpdesolverSeries) -> Double { @_common.max(s.vals) }

pub fn math_pde_solver_series_range(s : MathpdesolverSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn math_pde_solver_series_var(s : MathpdesolverSeries) -> Double { @_common.variance(s.vals) }

pub fn math_pde_solver_series_std(s : MathpdesolverSeries) -> Double { @_common.std(s.vals) }

pub fn math_pde_solver_series_median(s : MathpdesolverSeries) -> Double { @_common.median(s.vals) }

pub fn math_pde_solver_series_scale(s : MathpdesolverSeries, f : Double) -> MathpdesolverSeries {
  { vals: @_common.scale_arr(s.vals, f), name: s.name, meta: s.meta }
}

pub fn math_pde_solver_series_add(a : MathpdesolverSeries, b : MathpdesolverSeries) -> MathpdesolverSeries {
  { vals: @_common.add_arr(a.vals, b.vals), name: a.name + "+" + b.name, meta: a.meta }
}

pub fn math_pde_solver_series_sub(a : MathpdesolverSeries, b : MathpdesolverSeries) -> MathpdesolverSeries {
  { vals: @_common.sub_arr(a.vals, b.vals), name: a.name + "-" + b.name, meta: a.meta }
}

pub fn math_pde_solver_series_normalize(s : MathpdesolverSeries) -> MathpdesolverSeries {
  let mn = math_pde_solver_series_min(s)
  let mx = math_pde_solver_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn math_pde_solver_series_cumsum(s : MathpdesolverSeries) -> MathpdesolverSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn math_pde_solver_series_to_string(s : MathpdesolverSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MathpdesolverMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn math_pde_solver_make_matrix(rows : Int, cols : Int, val : Double) -> MathpdesolverMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn math_pde_solver_matrix_identity(n : Int) -> MathpdesolverMatrix {
  let m = math_pde_solver_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn math_pde_solver_matrix_get(m : MathpdesolverMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn math_pde_solver_matrix_transpose(m : MathpdesolverMatrix) -> MathpdesolverMatrix {
  let result = math_pde_solver_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn math_pde_solver_matrix_add(a : MathpdesolverMatrix, b : MathpdesolverMatrix) -> MathpdesolverMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = math_pde_solver_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn math_pde_solver_matrix_scale(m : MathpdesolverMatrix, s : Double) -> MathpdesolverMatrix {
  let result = math_pde_solver_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn math_pde_solver_matrix_multiply(a : MathpdesolverMatrix, b : MathpdesolverMatrix) -> MathpdesolverMatrix {
  if a.cols != b.rows { return math_pde_solver_make_matrix(a.rows, b.cols, 0.0) }
  let result = math_pde_solver_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn math_pde_solver_matrix_trace(m : MathpdesolverMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn math_pde_solver_matrix_det(m : MathpdesolverMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn math_pde_solver_matrix_norm(m : MathpdesolverMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn math_pde_solver_matrix_to_string(m : MathpdesolverMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + @_common.dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct MathpdesolverVector {
  comps : Array[Double]
  dim : Int
}

pub fn math_pde_solver_make_vector(comps : Array[Double]) -> MathpdesolverVector {
  { comps, dim: comps.length() }
}

pub fn math_pde_solver_vector_zero(dim : Int) -> MathpdesolverVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn math_pde_solver_vector_add(a : MathpdesolverVector, b : MathpdesolverVector) -> MathpdesolverVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.add_arr(a.comps, b.comps), dim: n }
}

pub fn math_pde_solver_vector_sub(a : MathpdesolverVector, b : MathpdesolverVector) -> MathpdesolverVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.sub_arr(a.comps, b.comps), dim: n }
}

pub fn math_pde_solver_vector_scale(v : MathpdesolverVector, s : Double) -> MathpdesolverVector {
  { comps: @_common.scale_arr(v.comps, s), dim: v.dim }
}

pub fn math_pde_solver_vector_dot(a : MathpdesolverVector, b : MathpdesolverVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn math_pde_solver_vector_norm(v : MathpdesolverVector) -> Double { @_common.sqrt(math_pde_solver_vector_dot(v, v)) }

pub fn math_pde_solver_vector_normalize(v : MathpdesolverVector) -> MathpdesolverVector {
  let n = math_pde_solver_vector_norm(v)
  if n < 0.0000001 { v } else { math_pde_solver_vector_scale(v, 1.0 / n) }
}

pub fn math_pde_solver_vector_dist(a : MathpdesolverVector, b : MathpdesolverVector) -> Double {
  math_pde_solver_vector_norm(math_pde_solver_vector_sub(a, b))
}

pub fn math_pde_solver_vector_to_string(v : MathpdesolverVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn math_pde_solver_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn math_pde_solver_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn math_pde_solver_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn math_pde_solver_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn math_pde_solver_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn math_pde_solver_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn math_pde_solver_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn math_pde_solver_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn math_pde_solver_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn math_pde_solver_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn math_pde_solver_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn math_pde_solver_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn math_pde_solver_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn math_pde_solver_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn math_pde_solver_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn math_pde_solver_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn math_pde_solver_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn math_pde_solver_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn math_pde_solver_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn math_pde_solver_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn math_pde_solver_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn math_pde_solver_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn math_pde_solver_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn math_pde_solver_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn math_pde_solver_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn math_pde_solver_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn math_pde_solver_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn math_pde_solver_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn math_pde_solver_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MathpdesolverFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_pde_solver_frame_make(size : Int) -> MathpdesolverFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_pde_solver_frame_len(s : MathpdesolverFrame) -> Int { s.size }

pub fn math_pde_solver_frame_get(s : MathpdesolverFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_pde_solver_frame_set(s : MathpdesolverFrame, i : Int, v : Double) -> MathpdesolverFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_pde_solver_frame_sum(s : MathpdesolverFrame) -> Double { @_common.sum(s.data) }

pub fn math_pde_solver_frame_mean(s : MathpdesolverFrame) -> Double { @_common.mean(s.data) }

pub fn math_pde_solver_frame_scale(s : MathpdesolverFrame, f : Double) -> MathpdesolverFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_pde_solver_frame_add(a : MathpdesolverFrame, b : MathpdesolverFrame) -> MathpdesolverFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_pde_solver_frame_copy(s : MathpdesolverFrame) -> MathpdesolverFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_pde_solver_frame_fill(s : MathpdesolverFrame, v : Double) -> MathpdesolverFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_pde_solver_frame_min(s : MathpdesolverFrame) -> Double { @_common.min(s.data) }

pub fn math_pde_solver_frame_max(s : MathpdesolverFrame) -> Double { @_common.max(s.data) }

pub fn math_pde_solver_frame_to_string(s : MathpdesolverFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathpdesolverTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_pde_solver_table_make(size : Int) -> MathpdesolverTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_pde_solver_table_len(s : MathpdesolverTable) -> Int { s.size }

pub fn math_pde_solver_table_get(s : MathpdesolverTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_pde_solver_table_set(s : MathpdesolverTable, i : Int, v : Double) -> MathpdesolverTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_pde_solver_table_sum(s : MathpdesolverTable) -> Double { @_common.sum(s.data) }

pub fn math_pde_solver_table_mean(s : MathpdesolverTable) -> Double { @_common.mean(s.data) }

pub fn math_pde_solver_table_scale(s : MathpdesolverTable, f : Double) -> MathpdesolverTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_pde_solver_table_add(a : MathpdesolverTable, b : MathpdesolverTable) -> MathpdesolverTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_pde_solver_table_copy(s : MathpdesolverTable) -> MathpdesolverTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_pde_solver_table_fill(s : MathpdesolverTable, v : Double) -> MathpdesolverTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_pde_solver_table_min(s : MathpdesolverTable) -> Double { @_common.min(s.data) }

pub fn math_pde_solver_table_max(s : MathpdesolverTable) -> Double { @_common.max(s.data) }

pub fn math_pde_solver_table_to_string(s : MathpdesolverTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathpdesolverGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_pde_solver_graphn_make(size : Int) -> MathpdesolverGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_pde_solver_graphn_len(s : MathpdesolverGraphN) -> Int { s.size }

pub fn math_pde_solver_graphn_get(s : MathpdesolverGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_pde_solver_graphn_set(s : MathpdesolverGraphN, i : Int, v : Double) -> MathpdesolverGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_pde_solver_graphn_sum(s : MathpdesolverGraphN) -> Double { @_common.sum(s.data) }

pub fn math_pde_solver_graphn_mean(s : MathpdesolverGraphN) -> Double { @_common.mean(s.data) }

pub fn math_pde_solver_graphn_scale(s : MathpdesolverGraphN, f : Double) -> MathpdesolverGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_pde_solver_graphn_add(a : MathpdesolverGraphN, b : MathpdesolverGraphN) -> MathpdesolverGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_pde_solver_graphn_copy(s : MathpdesolverGraphN) -> MathpdesolverGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_pde_solver_graphn_fill(s : MathpdesolverGraphN, v : Double) -> MathpdesolverGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_pde_solver_graphn_min(s : MathpdesolverGraphN) -> Double { @_common.min(s.data) }

pub fn math_pde_solver_graphn_max(s : MathpdesolverGraphN) -> Double { @_common.max(s.data) }

pub fn math_pde_solver_graphn_to_string(s : MathpdesolverGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathpdesolverNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_pde_solver_node_make(size : Int) -> MathpdesolverNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_pde_solver_node_len(s : MathpdesolverNode) -> Int { s.size }

pub fn math_pde_solver_node_get(s : MathpdesolverNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_pde_solver_node_set(s : MathpdesolverNode, i : Int, v : Double) -> MathpdesolverNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_pde_solver_node_sum(s : MathpdesolverNode) -> Double { @_common.sum(s.data) }

pub fn math_pde_solver_node_mean(s : MathpdesolverNode) -> Double { @_common.mean(s.data) }

pub fn math_pde_solver_node_scale(s : MathpdesolverNode, f : Double) -> MathpdesolverNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_pde_solver_node_add(a : MathpdesolverNode, b : MathpdesolverNode) -> MathpdesolverNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_pde_solver_node_copy(s : MathpdesolverNode) -> MathpdesolverNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_pde_solver_node_fill(s : MathpdesolverNode, v : Double) -> MathpdesolverNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_pde_solver_node_min(s : MathpdesolverNode) -> Double { @_common.min(s.data) }

pub fn math_pde_solver_node_max(s : MathpdesolverNode) -> Double { @_common.max(s.data) }

pub fn math_pde_solver_node_to_string(s : MathpdesolverNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathpdesolverEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_pde_solver_edge_make(size : Int) -> MathpdesolverEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_pde_solver_edge_len(s : MathpdesolverEdge) -> Int { s.size }

pub fn math_pde_solver_edge_get(s : MathpdesolverEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_pde_solver_edge_set(s : MathpdesolverEdge, i : Int, v : Double) -> MathpdesolverEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_pde_solver_edge_sum(s : MathpdesolverEdge) -> Double { @_common.sum(s.data) }

pub fn math_pde_solver_edge_mean(s : MathpdesolverEdge) -> Double { @_common.mean(s.data) }

pub fn math_pde_solver_edge_scale(s : MathpdesolverEdge, f : Double) -> MathpdesolverEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_pde_solver_edge_add(a : MathpdesolverEdge, b : MathpdesolverEdge) -> MathpdesolverEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_pde_solver_edge_copy(s : MathpdesolverEdge) -> MathpdesolverEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_pde_solver_edge_fill(s : MathpdesolverEdge, v : Double) -> MathpdesolverEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_pde_solver_edge_min(s : MathpdesolverEdge) -> Double { @_common.min(s.data) }

pub fn math_pde_solver_edge_max(s : MathpdesolverEdge) -> Double { @_common.max(s.data) }

pub fn math_pde_solver_edge_to_string(s : MathpdesolverEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathpdesolverPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_pde_solver_path_make(size : Int) -> MathpdesolverPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_pde_solver_path_len(s : MathpdesolverPath) -> Int { s.size }

pub fn math_pde_solver_path_get(s : MathpdesolverPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_pde_solver_path_set(s : MathpdesolverPath, i : Int, v : Double) -> MathpdesolverPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_pde_solver_path_sum(s : MathpdesolverPath) -> Double { @_common.sum(s.data) }

pub fn math_pde_solver_path_mean(s : MathpdesolverPath) -> Double { @_common.mean(s.data) }

pub fn math_pde_solver_path_scale(s : MathpdesolverPath, f : Double) -> MathpdesolverPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_pde_solver_path_add(a : MathpdesolverPath, b : MathpdesolverPath) -> MathpdesolverPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_pde_solver_path_copy(s : MathpdesolverPath) -> MathpdesolverPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_pde_solver_path_fill(s : MathpdesolverPath, v : Double) -> MathpdesolverPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_pde_solver_path_min(s : MathpdesolverPath) -> Double { @_common.min(s.data) }

pub fn math_pde_solver_path_max(s : MathpdesolverPath) -> Double { @_common.max(s.data) }

pub fn math_pde_solver_path_to_string(s : MathpdesolverPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathpdesolverCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_pde_solver_cluster_make(size : Int) -> MathpdesolverCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_pde_solver_cluster_len(s : MathpdesolverCluster) -> Int { s.size }

pub fn math_pde_solver_cluster_get(s : MathpdesolverCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_pde_solver_cluster_set(s : MathpdesolverCluster, i : Int, v : Double) -> MathpdesolverCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_pde_solver_cluster_sum(s : MathpdesolverCluster) -> Double { @_common.sum(s.data) }

pub fn math_pde_solver_cluster_mean(s : MathpdesolverCluster) -> Double { @_common.mean(s.data) }

pub fn math_pde_solver_cluster_scale(s : MathpdesolverCluster, f : Double) -> MathpdesolverCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_pde_solver_cluster_add(a : MathpdesolverCluster, b : MathpdesolverCluster) -> MathpdesolverCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_pde_solver_cluster_copy(s : MathpdesolverCluster) -> MathpdesolverCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_pde_solver_cluster_fill(s : MathpdesolverCluster, v : Double) -> MathpdesolverCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_pde_solver_cluster_min(s : MathpdesolverCluster) -> Double { @_common.min(s.data) }

pub fn math_pde_solver_cluster_max(s : MathpdesolverCluster) -> Double { @_common.max(s.data) }

pub fn math_pde_solver_cluster_to_string(s : MathpdesolverCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathpdesolverModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_pde_solver_model_make(size : Int) -> MathpdesolverModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_pde_solver_model_len(s : MathpdesolverModel) -> Int { s.size }

pub fn math_pde_solver_model_get(s : MathpdesolverModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_pde_solver_model_set(s : MathpdesolverModel, i : Int, v : Double) -> MathpdesolverModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_pde_solver_model_sum(s : MathpdesolverModel) -> Double { @_common.sum(s.data) }

pub fn math_pde_solver_model_mean(s : MathpdesolverModel) -> Double { @_common.mean(s.data) }

pub fn math_pde_solver_model_scale(s : MathpdesolverModel, f : Double) -> MathpdesolverModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_pde_solver_model_add(a : MathpdesolverModel, b : MathpdesolverModel) -> MathpdesolverModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_pde_solver_model_copy(s : MathpdesolverModel) -> MathpdesolverModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_pde_solver_model_fill(s : MathpdesolverModel, v : Double) -> MathpdesolverModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_pde_solver_model_min(s : MathpdesolverModel) -> Double { @_common.min(s.data) }

pub fn math_pde_solver_model_max(s : MathpdesolverModel) -> Double { @_common.max(s.data) }

pub fn math_pde_solver_model_to_string(s : MathpdesolverModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathpdesolverLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_pde_solver_layer_make(size : Int) -> MathpdesolverLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_pde_solver_layer_len(s : MathpdesolverLayer) -> Int { s.size }

pub fn math_pde_solver_layer_get(s : MathpdesolverLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_pde_solver_layer_set(s : MathpdesolverLayer, i : Int, v : Double) -> MathpdesolverLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_pde_solver_layer_sum(s : MathpdesolverLayer) -> Double { @_common.sum(s.data) }

pub fn math_pde_solver_layer_mean(s : MathpdesolverLayer) -> Double { @_common.mean(s.data) }

pub fn math_pde_solver_layer_scale(s : MathpdesolverLayer, f : Double) -> MathpdesolverLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_pde_solver_layer_add(a : MathpdesolverLayer, b : MathpdesolverLayer) -> MathpdesolverLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_pde_solver_layer_copy(s : MathpdesolverLayer) -> MathpdesolverLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_pde_solver_layer_fill(s : MathpdesolverLayer, v : Double) -> MathpdesolverLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_pde_solver_layer_min(s : MathpdesolverLayer) -> Double { @_common.min(s.data) }

pub fn math_pde_solver_layer_max(s : MathpdesolverLayer) -> Double { @_common.max(s.data) }

pub fn math_pde_solver_layer_to_string(s : MathpdesolverLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathpdesolverBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_pde_solver_buffer_make(size : Int) -> MathpdesolverBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_pde_solver_buffer_len(s : MathpdesolverBuffer) -> Int { s.size }

pub fn math_pde_solver_buffer_get(s : MathpdesolverBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_pde_solver_buffer_set(s : MathpdesolverBuffer, i : Int, v : Double) -> MathpdesolverBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_pde_solver_buffer_sum(s : MathpdesolverBuffer) -> Double { @_common.sum(s.data) }

pub fn math_pde_solver_buffer_mean(s : MathpdesolverBuffer) -> Double { @_common.mean(s.data) }

pub fn math_pde_solver_buffer_scale(s : MathpdesolverBuffer, f : Double) -> MathpdesolverBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_pde_solver_buffer_add(a : MathpdesolverBuffer, b : MathpdesolverBuffer) -> MathpdesolverBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_pde_solver_buffer_copy(s : MathpdesolverBuffer) -> MathpdesolverBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_pde_solver_buffer_fill(s : MathpdesolverBuffer, v : Double) -> MathpdesolverBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_pde_solver_buffer_min(s : MathpdesolverBuffer) -> Double { @_common.min(s.data) }

pub fn math_pde_solver_buffer_max(s : MathpdesolverBuffer) -> Double { @_common.max(s.data) }

pub fn math_pde_solver_buffer_to_string(s : MathpdesolverBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathpdesolverCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_pde_solver_cursor_make(size : Int) -> MathpdesolverCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_pde_solver_cursor_len(s : MathpdesolverCursor) -> Int { s.size }

pub fn math_pde_solver_cursor_get(s : MathpdesolverCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_pde_solver_cursor_set(s : MathpdesolverCursor, i : Int, v : Double) -> MathpdesolverCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_pde_solver_cursor_sum(s : MathpdesolverCursor) -> Double { @_common.sum(s.data) }

pub fn math_pde_solver_cursor_mean(s : MathpdesolverCursor) -> Double { @_common.mean(s.data) }

pub fn math_pde_solver_cursor_scale(s : MathpdesolverCursor, f : Double) -> MathpdesolverCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_pde_solver_cursor_add(a : MathpdesolverCursor, b : MathpdesolverCursor) -> MathpdesolverCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_pde_solver_cursor_copy(s : MathpdesolverCursor) -> MathpdesolverCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_pde_solver_cursor_fill(s : MathpdesolverCursor, v : Double) -> MathpdesolverCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_pde_solver_cursor_min(s : MathpdesolverCursor) -> Double { @_common.min(s.data) }

pub fn math_pde_solver_cursor_max(s : MathpdesolverCursor) -> Double { @_common.max(s.data) }

pub fn math_pde_solver_cursor_to_string(s : MathpdesolverCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathpdesolverView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_pde_solver_view_make(size : Int) -> MathpdesolverView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_pde_solver_view_len(s : MathpdesolverView) -> Int { s.size }

pub fn math_pde_solver_view_get(s : MathpdesolverView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_pde_solver_view_set(s : MathpdesolverView, i : Int, v : Double) -> MathpdesolverView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_pde_solver_view_sum(s : MathpdesolverView) -> Double { @_common.sum(s.data) }

pub fn math_pde_solver_view_mean(s : MathpdesolverView) -> Double { @_common.mean(s.data) }

pub fn math_pde_solver_view_scale(s : MathpdesolverView, f : Double) -> MathpdesolverView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_pde_solver_view_add(a : MathpdesolverView, b : MathpdesolverView) -> MathpdesolverView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_pde_solver_view_copy(s : MathpdesolverView) -> MathpdesolverView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_pde_solver_view_fill(s : MathpdesolverView, v : Double) -> MathpdesolverView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_pde_solver_view_min(s : MathpdesolverView) -> Double { @_common.min(s.data) }

pub fn math_pde_solver_view_max(s : MathpdesolverView) -> Double { @_common.max(s.data) }

pub fn math_pde_solver_view_to_string(s : MathpdesolverView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathpdesolverRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_pde_solver_range_make(size : Int) -> MathpdesolverRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_pde_solver_range_len(s : MathpdesolverRange) -> Int { s.size }

pub fn math_pde_solver_range_get(s : MathpdesolverRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_pde_solver_range_set(s : MathpdesolverRange, i : Int, v : Double) -> MathpdesolverRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_pde_solver_range_sum(s : MathpdesolverRange) -> Double { @_common.sum(s.data) }

pub fn math_pde_solver_range_mean(s : MathpdesolverRange) -> Double { @_common.mean(s.data) }

pub fn math_pde_solver_range_scale(s : MathpdesolverRange, f : Double) -> MathpdesolverRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_pde_solver_range_add(a : MathpdesolverRange, b : MathpdesolverRange) -> MathpdesolverRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_pde_solver_range_copy(s : MathpdesolverRange) -> MathpdesolverRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_pde_solver_range_fill(s : MathpdesolverRange, v : Double) -> MathpdesolverRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_pde_solver_range_min(s : MathpdesolverRange) -> Double { @_common.min(s.data) }

pub fn math_pde_solver_range_max(s : MathpdesolverRange) -> Double { @_common.max(s.data) }

pub fn math_pde_solver_range_to_string(s : MathpdesolverRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathpdesolverSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_pde_solver_slice_make(size : Int) -> MathpdesolverSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_pde_solver_slice_len(s : MathpdesolverSlice) -> Int { s.size }

pub fn math_pde_solver_slice_get(s : MathpdesolverSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_pde_solver_slice_set(s : MathpdesolverSlice, i : Int, v : Double) -> MathpdesolverSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_pde_solver_slice_sum(s : MathpdesolverSlice) -> Double { @_common.sum(s.data) }

pub fn math_pde_solver_slice_mean(s : MathpdesolverSlice) -> Double { @_common.mean(s.data) }

pub fn math_pde_solver_slice_scale(s : MathpdesolverSlice, f : Double) -> MathpdesolverSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_pde_solver_slice_add(a : MathpdesolverSlice, b : MathpdesolverSlice) -> MathpdesolverSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_pde_solver_slice_copy(s : MathpdesolverSlice) -> MathpdesolverSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_pde_solver_slice_fill(s : MathpdesolverSlice, v : Double) -> MathpdesolverSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_pde_solver_slice_min(s : MathpdesolverSlice) -> Double { @_common.min(s.data) }

pub fn math_pde_solver_slice_max(s : MathpdesolverSlice) -> Double { @_common.max(s.data) }

pub fn math_pde_solver_slice_to_string(s : MathpdesolverSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

