///===
/// extcore/math_finite_diff

pub(all) struct MathfinitediffPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn math_finite_diff_make_point(x : Double, y : Double) -> MathfinitediffPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn math_finite_diff_make_point3(x : Double, y : Double, z : Double) -> MathfinitediffPoint {
  { x, y, z, label: 0 }
}

pub fn math_finite_diff_point_x(pt : MathfinitediffPoint) -> Double { pt.x }

pub fn math_finite_diff_point_y(pt : MathfinitediffPoint) -> Double { pt.y }

pub fn math_finite_diff_point_z(pt : MathfinitediffPoint) -> Double { pt.z }

pub fn math_finite_diff_point_label(pt : MathfinitediffPoint) -> Int { pt.label }

pub fn math_finite_diff_point_dist(a : MathfinitediffPoint, b : MathfinitediffPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn math_finite_diff_point_add(a : MathfinitediffPoint, b : MathfinitediffPoint) -> MathfinitediffPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn math_finite_diff_point_sub(a : MathfinitediffPoint, b : MathfinitediffPoint) -> MathfinitediffPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn math_finite_diff_point_scale(pt : MathfinitediffPoint, s : Double) -> MathfinitediffPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn math_finite_diff_point_dot(a : MathfinitediffPoint, b : MathfinitediffPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn math_finite_diff_point_cross(a : MathfinitediffPoint, b : MathfinitediffPoint) -> MathfinitediffPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn math_finite_diff_point_norm(pt : MathfinitediffPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn math_finite_diff_point_normalize(pt : MathfinitediffPoint) -> MathfinitediffPoint {
  let n = math_finite_diff_point_norm(pt)
  if n < 0.0000001 { pt } else { math_finite_diff_point_scale(pt, 1.0 / n) }
}

pub fn math_finite_diff_point_negate(pt : MathfinitediffPoint) -> MathfinitediffPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn math_finite_diff_point_mid(a : MathfinitediffPoint, b : MathfinitediffPoint) -> MathfinitediffPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn math_finite_diff_point_lerp(a : MathfinitediffPoint, b : MathfinitediffPoint, t : Double) -> MathfinitediffPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn math_finite_diff_point_to_string(pt : MathfinitediffPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct MathfinitediffSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn math_finite_diff_make_series(vals : Array[Double], name : String) -> MathfinitediffSeries {
  { vals, name, meta: 0 }
}

pub fn math_finite_diff_series_len(s : MathfinitediffSeries) -> Int { s.vals.length() }

pub fn math_finite_diff_series_sum(s : MathfinitediffSeries) -> Double { @_common.sum(s.vals) }

pub fn math_finite_diff_series_mean(s : MathfinitediffSeries) -> Double { @_common.mean(s.vals) }

pub fn math_finite_diff_series_min(s : MathfinitediffSeries) -> Double { @_common.min(s.vals) }

pub fn math_finite_diff_series_max(s : MathfinitediffSeries) -> Double { @_common.max(s.vals) }

pub fn math_finite_diff_series_range(s : MathfinitediffSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn math_finite_diff_series_var(s : MathfinitediffSeries) -> Double { @_common.variance(s.vals) }

pub fn math_finite_diff_series_std(s : MathfinitediffSeries) -> Double { @_common.std(s.vals) }

pub fn math_finite_diff_series_median(s : MathfinitediffSeries) -> Double { @_common.median(s.vals) }

pub fn math_finite_diff_series_scale(s : MathfinitediffSeries, f : Double) -> MathfinitediffSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn math_finite_diff_series_add(a : MathfinitediffSeries, b : MathfinitediffSeries) -> MathfinitediffSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn math_finite_diff_series_sub(a : MathfinitediffSeries, b : MathfinitediffSeries) -> MathfinitediffSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn math_finite_diff_series_normalize(s : MathfinitediffSeries) -> MathfinitediffSeries {
  let mn = math_finite_diff_series_min(s)
  let mx = math_finite_diff_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn math_finite_diff_series_cumsum(s : MathfinitediffSeries) -> MathfinitediffSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn math_finite_diff_series_to_string(s : MathfinitediffSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MathfinitediffMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn math_finite_diff_make_matrix(rows : Int, cols : Int, val : Double) -> MathfinitediffMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn math_finite_diff_matrix_identity(n : Int) -> MathfinitediffMatrix {
  let m = math_finite_diff_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn math_finite_diff_matrix_get(m : MathfinitediffMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn math_finite_diff_matrix_transpose(m : MathfinitediffMatrix) -> MathfinitediffMatrix {
  let result = math_finite_diff_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn math_finite_diff_matrix_add(a : MathfinitediffMatrix, b : MathfinitediffMatrix) -> MathfinitediffMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = math_finite_diff_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn math_finite_diff_matrix_scale(m : MathfinitediffMatrix, s : Double) -> MathfinitediffMatrix {
  let result = math_finite_diff_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn math_finite_diff_matrix_multiply(a : MathfinitediffMatrix, b : MathfinitediffMatrix) -> MathfinitediffMatrix {
  if a.cols != b.rows { return math_finite_diff_make_matrix(a.rows, b.cols, 0.0) }
  let result = math_finite_diff_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn math_finite_diff_matrix_trace(m : MathfinitediffMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn math_finite_diff_matrix_det(m : MathfinitediffMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn math_finite_diff_matrix_norm(m : MathfinitediffMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn math_finite_diff_matrix_to_string(m : MathfinitediffMatrix) -> String {
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

pub(all) struct MathfinitediffVector {
  comps : Array[Double]
  dim : Int
}

pub fn math_finite_diff_make_vector(comps : Array[Double]) -> MathfinitediffVector {
  { comps, dim: comps.length() }
}

pub fn math_finite_diff_vector_zero(dim : Int) -> MathfinitediffVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn math_finite_diff_vector_add(a : MathfinitediffVector, b : MathfinitediffVector) -> MathfinitediffVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn math_finite_diff_vector_sub(a : MathfinitediffVector, b : MathfinitediffVector) -> MathfinitediffVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn math_finite_diff_vector_scale(v : MathfinitediffVector, s : Double) -> MathfinitediffVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn math_finite_diff_vector_dot(a : MathfinitediffVector, b : MathfinitediffVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn math_finite_diff_vector_norm(v : MathfinitediffVector) -> Double { @_common.sqrt(math_finite_diff_vector_dot(v, v)) }

pub fn math_finite_diff_vector_normalize(v : MathfinitediffVector) -> MathfinitediffVector {
  let n = math_finite_diff_vector_norm(v)
  if n < 0.0000001 { v } else { math_finite_diff_vector_scale(v, 1.0 / n) }
}

pub fn math_finite_diff_vector_dist(a : MathfinitediffVector, b : MathfinitediffVector) -> Double {
  math_finite_diff_vector_norm(math_finite_diff_vector_sub(a, b))
}

pub fn math_finite_diff_vector_to_string(v : MathfinitediffVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn math_finite_diff_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn math_finite_diff_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn math_finite_diff_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn math_finite_diff_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn math_finite_diff_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn math_finite_diff_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn math_finite_diff_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn math_finite_diff_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn math_finite_diff_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn math_finite_diff_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn math_finite_diff_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn math_finite_diff_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn math_finite_diff_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn math_finite_diff_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn math_finite_diff_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn math_finite_diff_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn math_finite_diff_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn math_finite_diff_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn math_finite_diff_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn math_finite_diff_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn math_finite_diff_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn math_finite_diff_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn math_finite_diff_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn math_finite_diff_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn math_finite_diff_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn math_finite_diff_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn math_finite_diff_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn math_finite_diff_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn math_finite_diff_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MathfinitediffFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_finite_diff_frame_make(size : Int) -> MathfinitediffFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_finite_diff_frame_len(s : MathfinitediffFrame) -> Int { s.size }

pub fn math_finite_diff_frame_get(s : MathfinitediffFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_finite_diff_frame_set(s : MathfinitediffFrame, i : Int, v : Double) -> MathfinitediffFrame {
  let result = math_finite_diff_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_finite_diff_frame_sum(s : MathfinitediffFrame) -> Double { @_common.sum(s.data) }

pub fn math_finite_diff_frame_mean(s : MathfinitediffFrame) -> Double { @_common.mean(s.data) }

pub fn math_finite_diff_frame_scale(s : MathfinitediffFrame, f : Double) -> MathfinitediffFrame {
  let result = math_finite_diff_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_finite_diff_frame_add(a : MathfinitediffFrame, b : MathfinitediffFrame) -> MathfinitediffFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_finite_diff_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_finite_diff_frame_copy(s : MathfinitediffFrame) -> MathfinitediffFrame {
  let result = math_finite_diff_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_finite_diff_frame_fill(s : MathfinitediffFrame, v : Double) -> MathfinitediffFrame {
  let result = math_finite_diff_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_finite_diff_frame_min(s : MathfinitediffFrame) -> Double { @_common.min(s.data) }

pub fn math_finite_diff_frame_max(s : MathfinitediffFrame) -> Double { @_common.max(s.data) }

pub fn math_finite_diff_frame_to_string(s : MathfinitediffFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathfinitediffTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_finite_diff_table_make(size : Int) -> MathfinitediffTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_finite_diff_table_len(s : MathfinitediffTable) -> Int { s.size }

pub fn math_finite_diff_table_get(s : MathfinitediffTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_finite_diff_table_set(s : MathfinitediffTable, i : Int, v : Double) -> MathfinitediffTable {
  let result = math_finite_diff_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_finite_diff_table_sum(s : MathfinitediffTable) -> Double { @_common.sum(s.data) }

pub fn math_finite_diff_table_mean(s : MathfinitediffTable) -> Double { @_common.mean(s.data) }

pub fn math_finite_diff_table_scale(s : MathfinitediffTable, f : Double) -> MathfinitediffTable {
  let result = math_finite_diff_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_finite_diff_table_add(a : MathfinitediffTable, b : MathfinitediffTable) -> MathfinitediffTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_finite_diff_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_finite_diff_table_copy(s : MathfinitediffTable) -> MathfinitediffTable {
  let result = math_finite_diff_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_finite_diff_table_fill(s : MathfinitediffTable, v : Double) -> MathfinitediffTable {
  let result = math_finite_diff_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_finite_diff_table_min(s : MathfinitediffTable) -> Double { @_common.min(s.data) }

pub fn math_finite_diff_table_max(s : MathfinitediffTable) -> Double { @_common.max(s.data) }

pub fn math_finite_diff_table_to_string(s : MathfinitediffTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathfinitediffGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_finite_diff_graphn_make(size : Int) -> MathfinitediffGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_finite_diff_graphn_len(s : MathfinitediffGraphN) -> Int { s.size }

pub fn math_finite_diff_graphn_get(s : MathfinitediffGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_finite_diff_graphn_set(s : MathfinitediffGraphN, i : Int, v : Double) -> MathfinitediffGraphN {
  let result = math_finite_diff_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_finite_diff_graphn_sum(s : MathfinitediffGraphN) -> Double { @_common.sum(s.data) }

pub fn math_finite_diff_graphn_mean(s : MathfinitediffGraphN) -> Double { @_common.mean(s.data) }

pub fn math_finite_diff_graphn_scale(s : MathfinitediffGraphN, f : Double) -> MathfinitediffGraphN {
  let result = math_finite_diff_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_finite_diff_graphn_add(a : MathfinitediffGraphN, b : MathfinitediffGraphN) -> MathfinitediffGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_finite_diff_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_finite_diff_graphn_copy(s : MathfinitediffGraphN) -> MathfinitediffGraphN {
  let result = math_finite_diff_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_finite_diff_graphn_fill(s : MathfinitediffGraphN, v : Double) -> MathfinitediffGraphN {
  let result = math_finite_diff_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_finite_diff_graphn_min(s : MathfinitediffGraphN) -> Double { @_common.min(s.data) }

pub fn math_finite_diff_graphn_max(s : MathfinitediffGraphN) -> Double { @_common.max(s.data) }

pub fn math_finite_diff_graphn_to_string(s : MathfinitediffGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathfinitediffNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_finite_diff_node_make(size : Int) -> MathfinitediffNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_finite_diff_node_len(s : MathfinitediffNode) -> Int { s.size }

pub fn math_finite_diff_node_get(s : MathfinitediffNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_finite_diff_node_set(s : MathfinitediffNode, i : Int, v : Double) -> MathfinitediffNode {
  let result = math_finite_diff_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_finite_diff_node_sum(s : MathfinitediffNode) -> Double { @_common.sum(s.data) }

pub fn math_finite_diff_node_mean(s : MathfinitediffNode) -> Double { @_common.mean(s.data) }

pub fn math_finite_diff_node_scale(s : MathfinitediffNode, f : Double) -> MathfinitediffNode {
  let result = math_finite_diff_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_finite_diff_node_add(a : MathfinitediffNode, b : MathfinitediffNode) -> MathfinitediffNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_finite_diff_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_finite_diff_node_copy(s : MathfinitediffNode) -> MathfinitediffNode {
  let result = math_finite_diff_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_finite_diff_node_fill(s : MathfinitediffNode, v : Double) -> MathfinitediffNode {
  let result = math_finite_diff_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_finite_diff_node_min(s : MathfinitediffNode) -> Double { @_common.min(s.data) }

pub fn math_finite_diff_node_max(s : MathfinitediffNode) -> Double { @_common.max(s.data) }

pub fn math_finite_diff_node_to_string(s : MathfinitediffNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathfinitediffEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_finite_diff_edge_make(size : Int) -> MathfinitediffEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_finite_diff_edge_len(s : MathfinitediffEdge) -> Int { s.size }

pub fn math_finite_diff_edge_get(s : MathfinitediffEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_finite_diff_edge_set(s : MathfinitediffEdge, i : Int, v : Double) -> MathfinitediffEdge {
  let result = math_finite_diff_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_finite_diff_edge_sum(s : MathfinitediffEdge) -> Double { @_common.sum(s.data) }

pub fn math_finite_diff_edge_mean(s : MathfinitediffEdge) -> Double { @_common.mean(s.data) }

pub fn math_finite_diff_edge_scale(s : MathfinitediffEdge, f : Double) -> MathfinitediffEdge {
  let result = math_finite_diff_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_finite_diff_edge_add(a : MathfinitediffEdge, b : MathfinitediffEdge) -> MathfinitediffEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_finite_diff_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_finite_diff_edge_copy(s : MathfinitediffEdge) -> MathfinitediffEdge {
  let result = math_finite_diff_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_finite_diff_edge_fill(s : MathfinitediffEdge, v : Double) -> MathfinitediffEdge {
  let result = math_finite_diff_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_finite_diff_edge_min(s : MathfinitediffEdge) -> Double { @_common.min(s.data) }

pub fn math_finite_diff_edge_max(s : MathfinitediffEdge) -> Double { @_common.max(s.data) }

pub fn math_finite_diff_edge_to_string(s : MathfinitediffEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathfinitediffPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_finite_diff_path_make(size : Int) -> MathfinitediffPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_finite_diff_path_len(s : MathfinitediffPath) -> Int { s.size }

pub fn math_finite_diff_path_get(s : MathfinitediffPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_finite_diff_path_set(s : MathfinitediffPath, i : Int, v : Double) -> MathfinitediffPath {
  let result = math_finite_diff_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_finite_diff_path_sum(s : MathfinitediffPath) -> Double { @_common.sum(s.data) }

pub fn math_finite_diff_path_mean(s : MathfinitediffPath) -> Double { @_common.mean(s.data) }

pub fn math_finite_diff_path_scale(s : MathfinitediffPath, f : Double) -> MathfinitediffPath {
  let result = math_finite_diff_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_finite_diff_path_add(a : MathfinitediffPath, b : MathfinitediffPath) -> MathfinitediffPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_finite_diff_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_finite_diff_path_copy(s : MathfinitediffPath) -> MathfinitediffPath {
  let result = math_finite_diff_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_finite_diff_path_fill(s : MathfinitediffPath, v : Double) -> MathfinitediffPath {
  let result = math_finite_diff_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_finite_diff_path_min(s : MathfinitediffPath) -> Double { @_common.min(s.data) }

pub fn math_finite_diff_path_max(s : MathfinitediffPath) -> Double { @_common.max(s.data) }

pub fn math_finite_diff_path_to_string(s : MathfinitediffPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathfinitediffCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_finite_diff_cluster_make(size : Int) -> MathfinitediffCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_finite_diff_cluster_len(s : MathfinitediffCluster) -> Int { s.size }

pub fn math_finite_diff_cluster_get(s : MathfinitediffCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_finite_diff_cluster_set(s : MathfinitediffCluster, i : Int, v : Double) -> MathfinitediffCluster {
  let result = math_finite_diff_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_finite_diff_cluster_sum(s : MathfinitediffCluster) -> Double { @_common.sum(s.data) }

pub fn math_finite_diff_cluster_mean(s : MathfinitediffCluster) -> Double { @_common.mean(s.data) }

pub fn math_finite_diff_cluster_scale(s : MathfinitediffCluster, f : Double) -> MathfinitediffCluster {
  let result = math_finite_diff_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_finite_diff_cluster_add(a : MathfinitediffCluster, b : MathfinitediffCluster) -> MathfinitediffCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_finite_diff_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_finite_diff_cluster_copy(s : MathfinitediffCluster) -> MathfinitediffCluster {
  let result = math_finite_diff_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_finite_diff_cluster_fill(s : MathfinitediffCluster, v : Double) -> MathfinitediffCluster {
  let result = math_finite_diff_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_finite_diff_cluster_min(s : MathfinitediffCluster) -> Double { @_common.min(s.data) }

pub fn math_finite_diff_cluster_max(s : MathfinitediffCluster) -> Double { @_common.max(s.data) }

pub fn math_finite_diff_cluster_to_string(s : MathfinitediffCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathfinitediffModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_finite_diff_model_make(size : Int) -> MathfinitediffModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_finite_diff_model_len(s : MathfinitediffModel) -> Int { s.size }

pub fn math_finite_diff_model_get(s : MathfinitediffModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_finite_diff_model_set(s : MathfinitediffModel, i : Int, v : Double) -> MathfinitediffModel {
  let result = math_finite_diff_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_finite_diff_model_sum(s : MathfinitediffModel) -> Double { @_common.sum(s.data) }

pub fn math_finite_diff_model_mean(s : MathfinitediffModel) -> Double { @_common.mean(s.data) }

pub fn math_finite_diff_model_scale(s : MathfinitediffModel, f : Double) -> MathfinitediffModel {
  let result = math_finite_diff_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_finite_diff_model_add(a : MathfinitediffModel, b : MathfinitediffModel) -> MathfinitediffModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_finite_diff_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_finite_diff_model_copy(s : MathfinitediffModel) -> MathfinitediffModel {
  let result = math_finite_diff_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_finite_diff_model_fill(s : MathfinitediffModel, v : Double) -> MathfinitediffModel {
  let result = math_finite_diff_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_finite_diff_model_min(s : MathfinitediffModel) -> Double { @_common.min(s.data) }

pub fn math_finite_diff_model_max(s : MathfinitediffModel) -> Double { @_common.max(s.data) }

pub fn math_finite_diff_model_to_string(s : MathfinitediffModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathfinitediffLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_finite_diff_layer_make(size : Int) -> MathfinitediffLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_finite_diff_layer_len(s : MathfinitediffLayer) -> Int { s.size }

pub fn math_finite_diff_layer_get(s : MathfinitediffLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_finite_diff_layer_set(s : MathfinitediffLayer, i : Int, v : Double) -> MathfinitediffLayer {
  let result = math_finite_diff_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_finite_diff_layer_sum(s : MathfinitediffLayer) -> Double { @_common.sum(s.data) }

pub fn math_finite_diff_layer_mean(s : MathfinitediffLayer) -> Double { @_common.mean(s.data) }

pub fn math_finite_diff_layer_scale(s : MathfinitediffLayer, f : Double) -> MathfinitediffLayer {
  let result = math_finite_diff_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_finite_diff_layer_add(a : MathfinitediffLayer, b : MathfinitediffLayer) -> MathfinitediffLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_finite_diff_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_finite_diff_layer_copy(s : MathfinitediffLayer) -> MathfinitediffLayer {
  let result = math_finite_diff_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_finite_diff_layer_fill(s : MathfinitediffLayer, v : Double) -> MathfinitediffLayer {
  let result = math_finite_diff_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_finite_diff_layer_min(s : MathfinitediffLayer) -> Double { @_common.min(s.data) }

pub fn math_finite_diff_layer_max(s : MathfinitediffLayer) -> Double { @_common.max(s.data) }

pub fn math_finite_diff_layer_to_string(s : MathfinitediffLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathfinitediffBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_finite_diff_buffer_make(size : Int) -> MathfinitediffBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_finite_diff_buffer_len(s : MathfinitediffBuffer) -> Int { s.size }

pub fn math_finite_diff_buffer_get(s : MathfinitediffBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_finite_diff_buffer_set(s : MathfinitediffBuffer, i : Int, v : Double) -> MathfinitediffBuffer {
  let result = math_finite_diff_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_finite_diff_buffer_sum(s : MathfinitediffBuffer) -> Double { @_common.sum(s.data) }

pub fn math_finite_diff_buffer_mean(s : MathfinitediffBuffer) -> Double { @_common.mean(s.data) }

pub fn math_finite_diff_buffer_scale(s : MathfinitediffBuffer, f : Double) -> MathfinitediffBuffer {
  let result = math_finite_diff_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_finite_diff_buffer_add(a : MathfinitediffBuffer, b : MathfinitediffBuffer) -> MathfinitediffBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_finite_diff_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_finite_diff_buffer_copy(s : MathfinitediffBuffer) -> MathfinitediffBuffer {
  let result = math_finite_diff_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_finite_diff_buffer_fill(s : MathfinitediffBuffer, v : Double) -> MathfinitediffBuffer {
  let result = math_finite_diff_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_finite_diff_buffer_min(s : MathfinitediffBuffer) -> Double { @_common.min(s.data) }

pub fn math_finite_diff_buffer_max(s : MathfinitediffBuffer) -> Double { @_common.max(s.data) }

pub fn math_finite_diff_buffer_to_string(s : MathfinitediffBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathfinitediffCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_finite_diff_cursor_make(size : Int) -> MathfinitediffCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_finite_diff_cursor_len(s : MathfinitediffCursor) -> Int { s.size }

pub fn math_finite_diff_cursor_get(s : MathfinitediffCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_finite_diff_cursor_set(s : MathfinitediffCursor, i : Int, v : Double) -> MathfinitediffCursor {
  let result = math_finite_diff_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_finite_diff_cursor_sum(s : MathfinitediffCursor) -> Double { @_common.sum(s.data) }

pub fn math_finite_diff_cursor_mean(s : MathfinitediffCursor) -> Double { @_common.mean(s.data) }

pub fn math_finite_diff_cursor_scale(s : MathfinitediffCursor, f : Double) -> MathfinitediffCursor {
  let result = math_finite_diff_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_finite_diff_cursor_add(a : MathfinitediffCursor, b : MathfinitediffCursor) -> MathfinitediffCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_finite_diff_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_finite_diff_cursor_copy(s : MathfinitediffCursor) -> MathfinitediffCursor {
  let result = math_finite_diff_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_finite_diff_cursor_fill(s : MathfinitediffCursor, v : Double) -> MathfinitediffCursor {
  let result = math_finite_diff_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_finite_diff_cursor_min(s : MathfinitediffCursor) -> Double { @_common.min(s.data) }

pub fn math_finite_diff_cursor_max(s : MathfinitediffCursor) -> Double { @_common.max(s.data) }

pub fn math_finite_diff_cursor_to_string(s : MathfinitediffCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathfinitediffView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_finite_diff_view_make(size : Int) -> MathfinitediffView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_finite_diff_view_len(s : MathfinitediffView) -> Int { s.size }

pub fn math_finite_diff_view_get(s : MathfinitediffView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_finite_diff_view_set(s : MathfinitediffView, i : Int, v : Double) -> MathfinitediffView {
  let result = math_finite_diff_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_finite_diff_view_sum(s : MathfinitediffView) -> Double { @_common.sum(s.data) }

pub fn math_finite_diff_view_mean(s : MathfinitediffView) -> Double { @_common.mean(s.data) }

pub fn math_finite_diff_view_scale(s : MathfinitediffView, f : Double) -> MathfinitediffView {
  let result = math_finite_diff_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_finite_diff_view_add(a : MathfinitediffView, b : MathfinitediffView) -> MathfinitediffView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_finite_diff_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_finite_diff_view_copy(s : MathfinitediffView) -> MathfinitediffView {
  let result = math_finite_diff_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_finite_diff_view_fill(s : MathfinitediffView, v : Double) -> MathfinitediffView {
  let result = math_finite_diff_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_finite_diff_view_min(s : MathfinitediffView) -> Double { @_common.min(s.data) }

pub fn math_finite_diff_view_max(s : MathfinitediffView) -> Double { @_common.max(s.data) }

pub fn math_finite_diff_view_to_string(s : MathfinitediffView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathfinitediffRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_finite_diff_range_make(size : Int) -> MathfinitediffRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_finite_diff_range_len(s : MathfinitediffRange) -> Int { s.size }

pub fn math_finite_diff_range_get(s : MathfinitediffRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_finite_diff_range_set(s : MathfinitediffRange, i : Int, v : Double) -> MathfinitediffRange {
  let result = math_finite_diff_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_finite_diff_range_sum(s : MathfinitediffRange) -> Double { @_common.sum(s.data) }

pub fn math_finite_diff_range_mean(s : MathfinitediffRange) -> Double { @_common.mean(s.data) }

pub fn math_finite_diff_range_scale(s : MathfinitediffRange, f : Double) -> MathfinitediffRange {
  let result = math_finite_diff_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_finite_diff_range_add(a : MathfinitediffRange, b : MathfinitediffRange) -> MathfinitediffRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_finite_diff_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_finite_diff_range_copy(s : MathfinitediffRange) -> MathfinitediffRange {
  let result = math_finite_diff_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_finite_diff_range_fill(s : MathfinitediffRange, v : Double) -> MathfinitediffRange {
  let result = math_finite_diff_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_finite_diff_range_min(s : MathfinitediffRange) -> Double { @_common.min(s.data) }

pub fn math_finite_diff_range_max(s : MathfinitediffRange) -> Double { @_common.max(s.data) }

pub fn math_finite_diff_range_to_string(s : MathfinitediffRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathfinitediffSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_finite_diff_slice_make(size : Int) -> MathfinitediffSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_finite_diff_slice_len(s : MathfinitediffSlice) -> Int { s.size }

pub fn math_finite_diff_slice_get(s : MathfinitediffSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_finite_diff_slice_set(s : MathfinitediffSlice, i : Int, v : Double) -> MathfinitediffSlice {
  let result = math_finite_diff_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_finite_diff_slice_sum(s : MathfinitediffSlice) -> Double { @_common.sum(s.data) }

pub fn math_finite_diff_slice_mean(s : MathfinitediffSlice) -> Double { @_common.mean(s.data) }

pub fn math_finite_diff_slice_scale(s : MathfinitediffSlice, f : Double) -> MathfinitediffSlice {
  let result = math_finite_diff_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_finite_diff_slice_add(a : MathfinitediffSlice, b : MathfinitediffSlice) -> MathfinitediffSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_finite_diff_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_finite_diff_slice_copy(s : MathfinitediffSlice) -> MathfinitediffSlice {
  let result = math_finite_diff_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_finite_diff_slice_fill(s : MathfinitediffSlice, v : Double) -> MathfinitediffSlice {
  let result = math_finite_diff_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_finite_diff_slice_min(s : MathfinitediffSlice) -> Double { @_common.min(s.data) }

pub fn math_finite_diff_slice_max(s : MathfinitediffSlice) -> Double { @_common.max(s.data) }

pub fn math_finite_diff_slice_to_string(s : MathfinitediffSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

