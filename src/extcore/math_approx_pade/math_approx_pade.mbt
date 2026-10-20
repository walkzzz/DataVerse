///===
/// extcore/math_approx_pade

pub(all) struct MathapproxpadePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn math_approx_pade_make_point(x : Double, y : Double) -> MathapproxpadePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn math_approx_pade_make_point3(x : Double, y : Double, z : Double) -> MathapproxpadePoint {
  { x, y, z, label: 0 }
}

pub fn math_approx_pade_point_x(pt : MathapproxpadePoint) -> Double { pt.x }

pub fn math_approx_pade_point_y(pt : MathapproxpadePoint) -> Double { pt.y }

pub fn math_approx_pade_point_z(pt : MathapproxpadePoint) -> Double { pt.z }

pub fn math_approx_pade_point_label(pt : MathapproxpadePoint) -> Int { pt.label }

pub fn math_approx_pade_point_dist(a : MathapproxpadePoint, b : MathapproxpadePoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn math_approx_pade_point_add(a : MathapproxpadePoint, b : MathapproxpadePoint) -> MathapproxpadePoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn math_approx_pade_point_sub(a : MathapproxpadePoint, b : MathapproxpadePoint) -> MathapproxpadePoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn math_approx_pade_point_scale(pt : MathapproxpadePoint, s : Double) -> MathapproxpadePoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn math_approx_pade_point_dot(a : MathapproxpadePoint, b : MathapproxpadePoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn math_approx_pade_point_cross(a : MathapproxpadePoint, b : MathapproxpadePoint) -> MathapproxpadePoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn math_approx_pade_point_norm(pt : MathapproxpadePoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn math_approx_pade_point_normalize(pt : MathapproxpadePoint) -> MathapproxpadePoint {
  let n = math_approx_pade_point_norm(pt)
  if n < 0.0000001 { pt } else { math_approx_pade_point_scale(pt, 1.0 / n) }
}

pub fn math_approx_pade_point_negate(pt : MathapproxpadePoint) -> MathapproxpadePoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn math_approx_pade_point_mid(a : MathapproxpadePoint, b : MathapproxpadePoint) -> MathapproxpadePoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn math_approx_pade_point_lerp(a : MathapproxpadePoint, b : MathapproxpadePoint, t : Double) -> MathapproxpadePoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn math_approx_pade_point_to_string(pt : MathapproxpadePoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct MathapproxpadeSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn math_approx_pade_make_series(vals : Array[Double], name : String) -> MathapproxpadeSeries {
  { vals, name, meta: 0 }
}

pub fn math_approx_pade_series_len(s : MathapproxpadeSeries) -> Int { s.vals.length() }

pub fn math_approx_pade_series_sum(s : MathapproxpadeSeries) -> Double { @_common.sum(s.vals) }

pub fn math_approx_pade_series_mean(s : MathapproxpadeSeries) -> Double { @_common.mean(s.vals) }

pub fn math_approx_pade_series_min(s : MathapproxpadeSeries) -> Double { @_common.min(s.vals) }

pub fn math_approx_pade_series_max(s : MathapproxpadeSeries) -> Double { @_common.max(s.vals) }

pub fn math_approx_pade_series_range(s : MathapproxpadeSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn math_approx_pade_series_var(s : MathapproxpadeSeries) -> Double { @_common.variance(s.vals) }

pub fn math_approx_pade_series_std(s : MathapproxpadeSeries) -> Double { @_common.std(s.vals) }

pub fn math_approx_pade_series_median(s : MathapproxpadeSeries) -> Double { @_common.median(s.vals) }

pub fn math_approx_pade_series_scale(s : MathapproxpadeSeries, f : Double) -> MathapproxpadeSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn math_approx_pade_series_add(a : MathapproxpadeSeries, b : MathapproxpadeSeries) -> MathapproxpadeSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn math_approx_pade_series_sub(a : MathapproxpadeSeries, b : MathapproxpadeSeries) -> MathapproxpadeSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn math_approx_pade_series_normalize(s : MathapproxpadeSeries) -> MathapproxpadeSeries {
  let mn = math_approx_pade_series_min(s)
  let mx = math_approx_pade_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn math_approx_pade_series_cumsum(s : MathapproxpadeSeries) -> MathapproxpadeSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn math_approx_pade_series_to_string(s : MathapproxpadeSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MathapproxpadeMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn math_approx_pade_make_matrix(rows : Int, cols : Int, val : Double) -> MathapproxpadeMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn math_approx_pade_matrix_identity(n : Int) -> MathapproxpadeMatrix {
  let m = math_approx_pade_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn math_approx_pade_matrix_get(m : MathapproxpadeMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn math_approx_pade_matrix_transpose(m : MathapproxpadeMatrix) -> MathapproxpadeMatrix {
  let result = math_approx_pade_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn math_approx_pade_matrix_add(a : MathapproxpadeMatrix, b : MathapproxpadeMatrix) -> MathapproxpadeMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = math_approx_pade_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn math_approx_pade_matrix_scale(m : MathapproxpadeMatrix, s : Double) -> MathapproxpadeMatrix {
  let result = math_approx_pade_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn math_approx_pade_matrix_multiply(a : MathapproxpadeMatrix, b : MathapproxpadeMatrix) -> MathapproxpadeMatrix {
  if a.cols != b.rows { return math_approx_pade_make_matrix(a.rows, b.cols, 0.0) }
  let result = math_approx_pade_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn math_approx_pade_matrix_trace(m : MathapproxpadeMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn math_approx_pade_matrix_det(m : MathapproxpadeMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn math_approx_pade_matrix_norm(m : MathapproxpadeMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn math_approx_pade_matrix_to_string(m : MathapproxpadeMatrix) -> String {
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

pub(all) struct MathapproxpadeVector {
  comps : Array[Double]
  dim : Int
}

pub fn math_approx_pade_make_vector(comps : Array[Double]) -> MathapproxpadeVector {
  { comps, dim: comps.length() }
}

pub fn math_approx_pade_vector_zero(dim : Int) -> MathapproxpadeVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn math_approx_pade_vector_add(a : MathapproxpadeVector, b : MathapproxpadeVector) -> MathapproxpadeVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn math_approx_pade_vector_sub(a : MathapproxpadeVector, b : MathapproxpadeVector) -> MathapproxpadeVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn math_approx_pade_vector_scale(v : MathapproxpadeVector, s : Double) -> MathapproxpadeVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn math_approx_pade_vector_dot(a : MathapproxpadeVector, b : MathapproxpadeVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn math_approx_pade_vector_norm(v : MathapproxpadeVector) -> Double { @_common.sqrt(math_approx_pade_vector_dot(v, v)) }

pub fn math_approx_pade_vector_normalize(v : MathapproxpadeVector) -> MathapproxpadeVector {
  let n = math_approx_pade_vector_norm(v)
  if n < 0.0000001 { v } else { math_approx_pade_vector_scale(v, 1.0 / n) }
}

pub fn math_approx_pade_vector_dist(a : MathapproxpadeVector, b : MathapproxpadeVector) -> Double {
  math_approx_pade_vector_norm(math_approx_pade_vector_sub(a, b))
}

pub fn math_approx_pade_vector_to_string(v : MathapproxpadeVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn math_approx_pade_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn math_approx_pade_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn math_approx_pade_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn math_approx_pade_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn math_approx_pade_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn math_approx_pade_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn math_approx_pade_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn math_approx_pade_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn math_approx_pade_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn math_approx_pade_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn math_approx_pade_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn math_approx_pade_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn math_approx_pade_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn math_approx_pade_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn math_approx_pade_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn math_approx_pade_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn math_approx_pade_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn math_approx_pade_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn math_approx_pade_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn math_approx_pade_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn math_approx_pade_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn math_approx_pade_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn math_approx_pade_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn math_approx_pade_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn math_approx_pade_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn math_approx_pade_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn math_approx_pade_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn math_approx_pade_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn math_approx_pade_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MathapproxpadeFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_pade_frame_make(size : Int) -> MathapproxpadeFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_pade_frame_len(s : MathapproxpadeFrame) -> Int { s.size }

pub fn math_approx_pade_frame_get(s : MathapproxpadeFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_pade_frame_set(s : MathapproxpadeFrame, i : Int, v : Double) -> MathapproxpadeFrame {
  let result = math_approx_pade_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_approx_pade_frame_sum(s : MathapproxpadeFrame) -> Double { @_common.sum(s.data) }

pub fn math_approx_pade_frame_mean(s : MathapproxpadeFrame) -> Double { @_common.mean(s.data) }

pub fn math_approx_pade_frame_scale(s : MathapproxpadeFrame, f : Double) -> MathapproxpadeFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_approx_pade_frame_add(a : MathapproxpadeFrame, b : MathapproxpadeFrame) -> MathapproxpadeFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_approx_pade_frame_copy(s : MathapproxpadeFrame) -> MathapproxpadeFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_approx_pade_frame_fill(s : MathapproxpadeFrame, v : Double) -> MathapproxpadeFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_approx_pade_frame_min(s : MathapproxpadeFrame) -> Double { @_common.min(s.data) }

pub fn math_approx_pade_frame_max(s : MathapproxpadeFrame) -> Double { @_common.max(s.data) }

pub fn math_approx_pade_frame_to_string(s : MathapproxpadeFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxpadeTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_pade_table_make(size : Int) -> MathapproxpadeTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_pade_table_len(s : MathapproxpadeTable) -> Int { s.size }

pub fn math_approx_pade_table_get(s : MathapproxpadeTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_pade_table_set(s : MathapproxpadeTable, i : Int, v : Double) -> MathapproxpadeTable {
  let result = math_approx_pade_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_approx_pade_table_sum(s : MathapproxpadeTable) -> Double { @_common.sum(s.data) }

pub fn math_approx_pade_table_mean(s : MathapproxpadeTable) -> Double { @_common.mean(s.data) }

pub fn math_approx_pade_table_scale(s : MathapproxpadeTable, f : Double) -> MathapproxpadeTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_approx_pade_table_add(a : MathapproxpadeTable, b : MathapproxpadeTable) -> MathapproxpadeTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_approx_pade_table_copy(s : MathapproxpadeTable) -> MathapproxpadeTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_approx_pade_table_fill(s : MathapproxpadeTable, v : Double) -> MathapproxpadeTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_approx_pade_table_min(s : MathapproxpadeTable) -> Double { @_common.min(s.data) }

pub fn math_approx_pade_table_max(s : MathapproxpadeTable) -> Double { @_common.max(s.data) }

pub fn math_approx_pade_table_to_string(s : MathapproxpadeTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxpadeGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_pade_graphn_make(size : Int) -> MathapproxpadeGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_pade_graphn_len(s : MathapproxpadeGraphN) -> Int { s.size }

pub fn math_approx_pade_graphn_get(s : MathapproxpadeGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_pade_graphn_set(s : MathapproxpadeGraphN, i : Int, v : Double) -> MathapproxpadeGraphN {
  let result = math_approx_pade_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_approx_pade_graphn_sum(s : MathapproxpadeGraphN) -> Double { @_common.sum(s.data) }

pub fn math_approx_pade_graphn_mean(s : MathapproxpadeGraphN) -> Double { @_common.mean(s.data) }

pub fn math_approx_pade_graphn_scale(s : MathapproxpadeGraphN, f : Double) -> MathapproxpadeGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_approx_pade_graphn_add(a : MathapproxpadeGraphN, b : MathapproxpadeGraphN) -> MathapproxpadeGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_approx_pade_graphn_copy(s : MathapproxpadeGraphN) -> MathapproxpadeGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_approx_pade_graphn_fill(s : MathapproxpadeGraphN, v : Double) -> MathapproxpadeGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_approx_pade_graphn_min(s : MathapproxpadeGraphN) -> Double { @_common.min(s.data) }

pub fn math_approx_pade_graphn_max(s : MathapproxpadeGraphN) -> Double { @_common.max(s.data) }

pub fn math_approx_pade_graphn_to_string(s : MathapproxpadeGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxpadeNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_pade_node_make(size : Int) -> MathapproxpadeNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_pade_node_len(s : MathapproxpadeNode) -> Int { s.size }

pub fn math_approx_pade_node_get(s : MathapproxpadeNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_pade_node_set(s : MathapproxpadeNode, i : Int, v : Double) -> MathapproxpadeNode {
  let result = math_approx_pade_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_approx_pade_node_sum(s : MathapproxpadeNode) -> Double { @_common.sum(s.data) }

pub fn math_approx_pade_node_mean(s : MathapproxpadeNode) -> Double { @_common.mean(s.data) }

pub fn math_approx_pade_node_scale(s : MathapproxpadeNode, f : Double) -> MathapproxpadeNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_approx_pade_node_add(a : MathapproxpadeNode, b : MathapproxpadeNode) -> MathapproxpadeNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_approx_pade_node_copy(s : MathapproxpadeNode) -> MathapproxpadeNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_approx_pade_node_fill(s : MathapproxpadeNode, v : Double) -> MathapproxpadeNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_approx_pade_node_min(s : MathapproxpadeNode) -> Double { @_common.min(s.data) }

pub fn math_approx_pade_node_max(s : MathapproxpadeNode) -> Double { @_common.max(s.data) }

pub fn math_approx_pade_node_to_string(s : MathapproxpadeNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxpadeEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_pade_edge_make(size : Int) -> MathapproxpadeEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_pade_edge_len(s : MathapproxpadeEdge) -> Int { s.size }

pub fn math_approx_pade_edge_get(s : MathapproxpadeEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_pade_edge_set(s : MathapproxpadeEdge, i : Int, v : Double) -> MathapproxpadeEdge {
  let result = math_approx_pade_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_approx_pade_edge_sum(s : MathapproxpadeEdge) -> Double { @_common.sum(s.data) }

pub fn math_approx_pade_edge_mean(s : MathapproxpadeEdge) -> Double { @_common.mean(s.data) }

pub fn math_approx_pade_edge_scale(s : MathapproxpadeEdge, f : Double) -> MathapproxpadeEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_approx_pade_edge_add(a : MathapproxpadeEdge, b : MathapproxpadeEdge) -> MathapproxpadeEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_approx_pade_edge_copy(s : MathapproxpadeEdge) -> MathapproxpadeEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_approx_pade_edge_fill(s : MathapproxpadeEdge, v : Double) -> MathapproxpadeEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_approx_pade_edge_min(s : MathapproxpadeEdge) -> Double { @_common.min(s.data) }

pub fn math_approx_pade_edge_max(s : MathapproxpadeEdge) -> Double { @_common.max(s.data) }

pub fn math_approx_pade_edge_to_string(s : MathapproxpadeEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxpadePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_pade_path_make(size : Int) -> MathapproxpadePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_pade_path_len(s : MathapproxpadePath) -> Int { s.size }

pub fn math_approx_pade_path_get(s : MathapproxpadePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_pade_path_set(s : MathapproxpadePath, i : Int, v : Double) -> MathapproxpadePath {
  let result = math_approx_pade_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_approx_pade_path_sum(s : MathapproxpadePath) -> Double { @_common.sum(s.data) }

pub fn math_approx_pade_path_mean(s : MathapproxpadePath) -> Double { @_common.mean(s.data) }

pub fn math_approx_pade_path_scale(s : MathapproxpadePath, f : Double) -> MathapproxpadePath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_approx_pade_path_add(a : MathapproxpadePath, b : MathapproxpadePath) -> MathapproxpadePath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_approx_pade_path_copy(s : MathapproxpadePath) -> MathapproxpadePath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_approx_pade_path_fill(s : MathapproxpadePath, v : Double) -> MathapproxpadePath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_approx_pade_path_min(s : MathapproxpadePath) -> Double { @_common.min(s.data) }

pub fn math_approx_pade_path_max(s : MathapproxpadePath) -> Double { @_common.max(s.data) }

pub fn math_approx_pade_path_to_string(s : MathapproxpadePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxpadeCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_pade_cluster_make(size : Int) -> MathapproxpadeCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_pade_cluster_len(s : MathapproxpadeCluster) -> Int { s.size }

pub fn math_approx_pade_cluster_get(s : MathapproxpadeCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_pade_cluster_set(s : MathapproxpadeCluster, i : Int, v : Double) -> MathapproxpadeCluster {
  let result = math_approx_pade_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_approx_pade_cluster_sum(s : MathapproxpadeCluster) -> Double { @_common.sum(s.data) }

pub fn math_approx_pade_cluster_mean(s : MathapproxpadeCluster) -> Double { @_common.mean(s.data) }

pub fn math_approx_pade_cluster_scale(s : MathapproxpadeCluster, f : Double) -> MathapproxpadeCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_approx_pade_cluster_add(a : MathapproxpadeCluster, b : MathapproxpadeCluster) -> MathapproxpadeCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_approx_pade_cluster_copy(s : MathapproxpadeCluster) -> MathapproxpadeCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_approx_pade_cluster_fill(s : MathapproxpadeCluster, v : Double) -> MathapproxpadeCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_approx_pade_cluster_min(s : MathapproxpadeCluster) -> Double { @_common.min(s.data) }

pub fn math_approx_pade_cluster_max(s : MathapproxpadeCluster) -> Double { @_common.max(s.data) }

pub fn math_approx_pade_cluster_to_string(s : MathapproxpadeCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxpadeModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_pade_model_make(size : Int) -> MathapproxpadeModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_pade_model_len(s : MathapproxpadeModel) -> Int { s.size }

pub fn math_approx_pade_model_get(s : MathapproxpadeModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_pade_model_set(s : MathapproxpadeModel, i : Int, v : Double) -> MathapproxpadeModel {
  let result = math_approx_pade_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_approx_pade_model_sum(s : MathapproxpadeModel) -> Double { @_common.sum(s.data) }

pub fn math_approx_pade_model_mean(s : MathapproxpadeModel) -> Double { @_common.mean(s.data) }

pub fn math_approx_pade_model_scale(s : MathapproxpadeModel, f : Double) -> MathapproxpadeModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_approx_pade_model_add(a : MathapproxpadeModel, b : MathapproxpadeModel) -> MathapproxpadeModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_approx_pade_model_copy(s : MathapproxpadeModel) -> MathapproxpadeModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_approx_pade_model_fill(s : MathapproxpadeModel, v : Double) -> MathapproxpadeModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_approx_pade_model_min(s : MathapproxpadeModel) -> Double { @_common.min(s.data) }

pub fn math_approx_pade_model_max(s : MathapproxpadeModel) -> Double { @_common.max(s.data) }

pub fn math_approx_pade_model_to_string(s : MathapproxpadeModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxpadeLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_pade_layer_make(size : Int) -> MathapproxpadeLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_pade_layer_len(s : MathapproxpadeLayer) -> Int { s.size }

pub fn math_approx_pade_layer_get(s : MathapproxpadeLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_pade_layer_set(s : MathapproxpadeLayer, i : Int, v : Double) -> MathapproxpadeLayer {
  let result = math_approx_pade_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_approx_pade_layer_sum(s : MathapproxpadeLayer) -> Double { @_common.sum(s.data) }

pub fn math_approx_pade_layer_mean(s : MathapproxpadeLayer) -> Double { @_common.mean(s.data) }

pub fn math_approx_pade_layer_scale(s : MathapproxpadeLayer, f : Double) -> MathapproxpadeLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_approx_pade_layer_add(a : MathapproxpadeLayer, b : MathapproxpadeLayer) -> MathapproxpadeLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_approx_pade_layer_copy(s : MathapproxpadeLayer) -> MathapproxpadeLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_approx_pade_layer_fill(s : MathapproxpadeLayer, v : Double) -> MathapproxpadeLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_approx_pade_layer_min(s : MathapproxpadeLayer) -> Double { @_common.min(s.data) }

pub fn math_approx_pade_layer_max(s : MathapproxpadeLayer) -> Double { @_common.max(s.data) }

pub fn math_approx_pade_layer_to_string(s : MathapproxpadeLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxpadeBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_pade_buffer_make(size : Int) -> MathapproxpadeBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_pade_buffer_len(s : MathapproxpadeBuffer) -> Int { s.size }

pub fn math_approx_pade_buffer_get(s : MathapproxpadeBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_pade_buffer_set(s : MathapproxpadeBuffer, i : Int, v : Double) -> MathapproxpadeBuffer {
  let result = math_approx_pade_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_approx_pade_buffer_sum(s : MathapproxpadeBuffer) -> Double { @_common.sum(s.data) }

pub fn math_approx_pade_buffer_mean(s : MathapproxpadeBuffer) -> Double { @_common.mean(s.data) }

pub fn math_approx_pade_buffer_scale(s : MathapproxpadeBuffer, f : Double) -> MathapproxpadeBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_approx_pade_buffer_add(a : MathapproxpadeBuffer, b : MathapproxpadeBuffer) -> MathapproxpadeBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_approx_pade_buffer_copy(s : MathapproxpadeBuffer) -> MathapproxpadeBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_approx_pade_buffer_fill(s : MathapproxpadeBuffer, v : Double) -> MathapproxpadeBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_approx_pade_buffer_min(s : MathapproxpadeBuffer) -> Double { @_common.min(s.data) }

pub fn math_approx_pade_buffer_max(s : MathapproxpadeBuffer) -> Double { @_common.max(s.data) }

pub fn math_approx_pade_buffer_to_string(s : MathapproxpadeBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxpadeCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_pade_cursor_make(size : Int) -> MathapproxpadeCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_pade_cursor_len(s : MathapproxpadeCursor) -> Int { s.size }

pub fn math_approx_pade_cursor_get(s : MathapproxpadeCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_pade_cursor_set(s : MathapproxpadeCursor, i : Int, v : Double) -> MathapproxpadeCursor {
  let result = math_approx_pade_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_approx_pade_cursor_sum(s : MathapproxpadeCursor) -> Double { @_common.sum(s.data) }

pub fn math_approx_pade_cursor_mean(s : MathapproxpadeCursor) -> Double { @_common.mean(s.data) }

pub fn math_approx_pade_cursor_scale(s : MathapproxpadeCursor, f : Double) -> MathapproxpadeCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_approx_pade_cursor_add(a : MathapproxpadeCursor, b : MathapproxpadeCursor) -> MathapproxpadeCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_approx_pade_cursor_copy(s : MathapproxpadeCursor) -> MathapproxpadeCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_approx_pade_cursor_fill(s : MathapproxpadeCursor, v : Double) -> MathapproxpadeCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_approx_pade_cursor_min(s : MathapproxpadeCursor) -> Double { @_common.min(s.data) }

pub fn math_approx_pade_cursor_max(s : MathapproxpadeCursor) -> Double { @_common.max(s.data) }

pub fn math_approx_pade_cursor_to_string(s : MathapproxpadeCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxpadeView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_pade_view_make(size : Int) -> MathapproxpadeView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_pade_view_len(s : MathapproxpadeView) -> Int { s.size }

pub fn math_approx_pade_view_get(s : MathapproxpadeView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_pade_view_set(s : MathapproxpadeView, i : Int, v : Double) -> MathapproxpadeView {
  let result = math_approx_pade_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_approx_pade_view_sum(s : MathapproxpadeView) -> Double { @_common.sum(s.data) }

pub fn math_approx_pade_view_mean(s : MathapproxpadeView) -> Double { @_common.mean(s.data) }

pub fn math_approx_pade_view_scale(s : MathapproxpadeView, f : Double) -> MathapproxpadeView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_approx_pade_view_add(a : MathapproxpadeView, b : MathapproxpadeView) -> MathapproxpadeView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_approx_pade_view_copy(s : MathapproxpadeView) -> MathapproxpadeView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_approx_pade_view_fill(s : MathapproxpadeView, v : Double) -> MathapproxpadeView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_approx_pade_view_min(s : MathapproxpadeView) -> Double { @_common.min(s.data) }

pub fn math_approx_pade_view_max(s : MathapproxpadeView) -> Double { @_common.max(s.data) }

pub fn math_approx_pade_view_to_string(s : MathapproxpadeView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxpadeRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_pade_range_make(size : Int) -> MathapproxpadeRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_pade_range_len(s : MathapproxpadeRange) -> Int { s.size }

pub fn math_approx_pade_range_get(s : MathapproxpadeRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_pade_range_set(s : MathapproxpadeRange, i : Int, v : Double) -> MathapproxpadeRange {
  let result = math_approx_pade_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_approx_pade_range_sum(s : MathapproxpadeRange) -> Double { @_common.sum(s.data) }

pub fn math_approx_pade_range_mean(s : MathapproxpadeRange) -> Double { @_common.mean(s.data) }

pub fn math_approx_pade_range_scale(s : MathapproxpadeRange, f : Double) -> MathapproxpadeRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_approx_pade_range_add(a : MathapproxpadeRange, b : MathapproxpadeRange) -> MathapproxpadeRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_approx_pade_range_copy(s : MathapproxpadeRange) -> MathapproxpadeRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_approx_pade_range_fill(s : MathapproxpadeRange, v : Double) -> MathapproxpadeRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_approx_pade_range_min(s : MathapproxpadeRange) -> Double { @_common.min(s.data) }

pub fn math_approx_pade_range_max(s : MathapproxpadeRange) -> Double { @_common.max(s.data) }

pub fn math_approx_pade_range_to_string(s : MathapproxpadeRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxpadeSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_pade_slice_make(size : Int) -> MathapproxpadeSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_pade_slice_len(s : MathapproxpadeSlice) -> Int { s.size }

pub fn math_approx_pade_slice_get(s : MathapproxpadeSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_pade_slice_set(s : MathapproxpadeSlice, i : Int, v : Double) -> MathapproxpadeSlice {
  let result = math_approx_pade_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_approx_pade_slice_sum(s : MathapproxpadeSlice) -> Double { @_common.sum(s.data) }

pub fn math_approx_pade_slice_mean(s : MathapproxpadeSlice) -> Double { @_common.mean(s.data) }

pub fn math_approx_pade_slice_scale(s : MathapproxpadeSlice, f : Double) -> MathapproxpadeSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_approx_pade_slice_add(a : MathapproxpadeSlice, b : MathapproxpadeSlice) -> MathapproxpadeSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_approx_pade_slice_copy(s : MathapproxpadeSlice) -> MathapproxpadeSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_approx_pade_slice_fill(s : MathapproxpadeSlice, v : Double) -> MathapproxpadeSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_approx_pade_slice_min(s : MathapproxpadeSlice) -> Double { @_common.min(s.data) }

pub fn math_approx_pade_slice_max(s : MathapproxpadeSlice) -> Double { @_common.max(s.data) }

pub fn math_approx_pade_slice_to_string(s : MathapproxpadeSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

