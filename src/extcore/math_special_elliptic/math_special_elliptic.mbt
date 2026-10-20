///===
/// extcore/math_special_elliptic

pub(all) struct MathspecialellipticPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn math_special_elliptic_make_point(x : Double, y : Double) -> MathspecialellipticPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn math_special_elliptic_make_point3(x : Double, y : Double, z : Double) -> MathspecialellipticPoint {
  { x, y, z, label: 0 }
}

pub fn math_special_elliptic_point_x(pt : MathspecialellipticPoint) -> Double { pt.x }

pub fn math_special_elliptic_point_y(pt : MathspecialellipticPoint) -> Double { pt.y }

pub fn math_special_elliptic_point_z(pt : MathspecialellipticPoint) -> Double { pt.z }

pub fn math_special_elliptic_point_label(pt : MathspecialellipticPoint) -> Int { pt.label }

pub fn math_special_elliptic_point_dist(a : MathspecialellipticPoint, b : MathspecialellipticPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn math_special_elliptic_point_add(a : MathspecialellipticPoint, b : MathspecialellipticPoint) -> MathspecialellipticPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn math_special_elliptic_point_sub(a : MathspecialellipticPoint, b : MathspecialellipticPoint) -> MathspecialellipticPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn math_special_elliptic_point_scale(pt : MathspecialellipticPoint, s : Double) -> MathspecialellipticPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn math_special_elliptic_point_dot(a : MathspecialellipticPoint, b : MathspecialellipticPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn math_special_elliptic_point_cross(a : MathspecialellipticPoint, b : MathspecialellipticPoint) -> MathspecialellipticPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn math_special_elliptic_point_norm(pt : MathspecialellipticPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn math_special_elliptic_point_normalize(pt : MathspecialellipticPoint) -> MathspecialellipticPoint {
  let n = math_special_elliptic_point_norm(pt)
  if n < 0.0000001 { pt } else { math_special_elliptic_point_scale(pt, 1.0 / n) }
}

pub fn math_special_elliptic_point_negate(pt : MathspecialellipticPoint) -> MathspecialellipticPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn math_special_elliptic_point_mid(a : MathspecialellipticPoint, b : MathspecialellipticPoint) -> MathspecialellipticPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn math_special_elliptic_point_lerp(a : MathspecialellipticPoint, b : MathspecialellipticPoint, t : Double) -> MathspecialellipticPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn math_special_elliptic_point_to_string(pt : MathspecialellipticPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct MathspecialellipticSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn math_special_elliptic_make_series(vals : Array[Double], name : String) -> MathspecialellipticSeries {
  { vals, name, meta: 0 }
}

pub fn math_special_elliptic_series_len(s : MathspecialellipticSeries) -> Int { s.vals.length() }

pub fn math_special_elliptic_series_sum(s : MathspecialellipticSeries) -> Double { @_common.sum(s.vals) }

pub fn math_special_elliptic_series_mean(s : MathspecialellipticSeries) -> Double { @_common.mean(s.vals) }

pub fn math_special_elliptic_series_min(s : MathspecialellipticSeries) -> Double { @_common.min(s.vals) }

pub fn math_special_elliptic_series_max(s : MathspecialellipticSeries) -> Double { @_common.max(s.vals) }

pub fn math_special_elliptic_series_range(s : MathspecialellipticSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn math_special_elliptic_series_var(s : MathspecialellipticSeries) -> Double { @_common.variance(s.vals) }

pub fn math_special_elliptic_series_std(s : MathspecialellipticSeries) -> Double { @_common.std(s.vals) }

pub fn math_special_elliptic_series_median(s : MathspecialellipticSeries) -> Double { @_common.median(s.vals) }

pub fn math_special_elliptic_series_scale(s : MathspecialellipticSeries, f : Double) -> MathspecialellipticSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn math_special_elliptic_series_add(a : MathspecialellipticSeries, b : MathspecialellipticSeries) -> MathspecialellipticSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn math_special_elliptic_series_sub(a : MathspecialellipticSeries, b : MathspecialellipticSeries) -> MathspecialellipticSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn math_special_elliptic_series_normalize(s : MathspecialellipticSeries) -> MathspecialellipticSeries {
  let mn = math_special_elliptic_series_min(s)
  let mx = math_special_elliptic_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn math_special_elliptic_series_cumsum(s : MathspecialellipticSeries) -> MathspecialellipticSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn math_special_elliptic_series_to_string(s : MathspecialellipticSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MathspecialellipticMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn math_special_elliptic_make_matrix(rows : Int, cols : Int, val : Double) -> MathspecialellipticMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn math_special_elliptic_matrix_identity(n : Int) -> MathspecialellipticMatrix {
  let m = math_special_elliptic_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn math_special_elliptic_matrix_get(m : MathspecialellipticMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn math_special_elliptic_matrix_transpose(m : MathspecialellipticMatrix) -> MathspecialellipticMatrix {
  let result = math_special_elliptic_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn math_special_elliptic_matrix_add(a : MathspecialellipticMatrix, b : MathspecialellipticMatrix) -> MathspecialellipticMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = math_special_elliptic_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn math_special_elliptic_matrix_scale(m : MathspecialellipticMatrix, s : Double) -> MathspecialellipticMatrix {
  let result = math_special_elliptic_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn math_special_elliptic_matrix_multiply(a : MathspecialellipticMatrix, b : MathspecialellipticMatrix) -> MathspecialellipticMatrix {
  if a.cols != b.rows { return math_special_elliptic_make_matrix(a.rows, b.cols, 0.0) }
  let result = math_special_elliptic_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn math_special_elliptic_matrix_trace(m : MathspecialellipticMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn math_special_elliptic_matrix_det(m : MathspecialellipticMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn math_special_elliptic_matrix_norm(m : MathspecialellipticMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn math_special_elliptic_matrix_to_string(m : MathspecialellipticMatrix) -> String {
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

pub(all) struct MathspecialellipticVector {
  comps : Array[Double]
  dim : Int
}

pub fn math_special_elliptic_make_vector(comps : Array[Double]) -> MathspecialellipticVector {
  { comps, dim: comps.length() }
}

pub fn math_special_elliptic_vector_zero(dim : Int) -> MathspecialellipticVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn math_special_elliptic_vector_add(a : MathspecialellipticVector, b : MathspecialellipticVector) -> MathspecialellipticVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn math_special_elliptic_vector_sub(a : MathspecialellipticVector, b : MathspecialellipticVector) -> MathspecialellipticVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn math_special_elliptic_vector_scale(v : MathspecialellipticVector, s : Double) -> MathspecialellipticVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn math_special_elliptic_vector_dot(a : MathspecialellipticVector, b : MathspecialellipticVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn math_special_elliptic_vector_norm(v : MathspecialellipticVector) -> Double { @_common.sqrt(math_special_elliptic_vector_dot(v, v)) }

pub fn math_special_elliptic_vector_normalize(v : MathspecialellipticVector) -> MathspecialellipticVector {
  let n = math_special_elliptic_vector_norm(v)
  if n < 0.0000001 { v } else { math_special_elliptic_vector_scale(v, 1.0 / n) }
}

pub fn math_special_elliptic_vector_dist(a : MathspecialellipticVector, b : MathspecialellipticVector) -> Double {
  math_special_elliptic_vector_norm(math_special_elliptic_vector_sub(a, b))
}

pub fn math_special_elliptic_vector_to_string(v : MathspecialellipticVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn math_special_elliptic_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn math_special_elliptic_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn math_special_elliptic_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn math_special_elliptic_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn math_special_elliptic_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn math_special_elliptic_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn math_special_elliptic_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn math_special_elliptic_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn math_special_elliptic_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn math_special_elliptic_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn math_special_elliptic_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn math_special_elliptic_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn math_special_elliptic_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn math_special_elliptic_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn math_special_elliptic_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn math_special_elliptic_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn math_special_elliptic_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn math_special_elliptic_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn math_special_elliptic_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn math_special_elliptic_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn math_special_elliptic_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn math_special_elliptic_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn math_special_elliptic_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn math_special_elliptic_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn math_special_elliptic_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn math_special_elliptic_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn math_special_elliptic_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn math_special_elliptic_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn math_special_elliptic_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MathspecialellipticFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_elliptic_frame_make(size : Int) -> MathspecialellipticFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_elliptic_frame_len(s : MathspecialellipticFrame) -> Int { s.size }

pub fn math_special_elliptic_frame_get(s : MathspecialellipticFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_elliptic_frame_set(s : MathspecialellipticFrame, i : Int, v : Double) -> MathspecialellipticFrame {
  let result = math_special_elliptic_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_special_elliptic_frame_sum(s : MathspecialellipticFrame) -> Double { @_common.sum(s.data) }

pub fn math_special_elliptic_frame_mean(s : MathspecialellipticFrame) -> Double { @_common.mean(s.data) }

pub fn math_special_elliptic_frame_scale(s : MathspecialellipticFrame, f : Double) -> MathspecialellipticFrame {
  let result = math_special_elliptic_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_special_elliptic_frame_add(a : MathspecialellipticFrame, b : MathspecialellipticFrame) -> MathspecialellipticFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_special_elliptic_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_special_elliptic_frame_copy(s : MathspecialellipticFrame) -> MathspecialellipticFrame {
  let result = math_special_elliptic_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_special_elliptic_frame_fill(s : MathspecialellipticFrame, v : Double) -> MathspecialellipticFrame {
  let result = math_special_elliptic_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_special_elliptic_frame_min(s : MathspecialellipticFrame) -> Double { @_common.min(s.data) }

pub fn math_special_elliptic_frame_max(s : MathspecialellipticFrame) -> Double { @_common.max(s.data) }

pub fn math_special_elliptic_frame_to_string(s : MathspecialellipticFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialellipticTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_elliptic_table_make(size : Int) -> MathspecialellipticTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_elliptic_table_len(s : MathspecialellipticTable) -> Int { s.size }

pub fn math_special_elliptic_table_get(s : MathspecialellipticTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_elliptic_table_set(s : MathspecialellipticTable, i : Int, v : Double) -> MathspecialellipticTable {
  let result = math_special_elliptic_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_special_elliptic_table_sum(s : MathspecialellipticTable) -> Double { @_common.sum(s.data) }

pub fn math_special_elliptic_table_mean(s : MathspecialellipticTable) -> Double { @_common.mean(s.data) }

pub fn math_special_elliptic_table_scale(s : MathspecialellipticTable, f : Double) -> MathspecialellipticTable {
  let result = math_special_elliptic_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_special_elliptic_table_add(a : MathspecialellipticTable, b : MathspecialellipticTable) -> MathspecialellipticTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_special_elliptic_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_special_elliptic_table_copy(s : MathspecialellipticTable) -> MathspecialellipticTable {
  let result = math_special_elliptic_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_special_elliptic_table_fill(s : MathspecialellipticTable, v : Double) -> MathspecialellipticTable {
  let result = math_special_elliptic_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_special_elliptic_table_min(s : MathspecialellipticTable) -> Double { @_common.min(s.data) }

pub fn math_special_elliptic_table_max(s : MathspecialellipticTable) -> Double { @_common.max(s.data) }

pub fn math_special_elliptic_table_to_string(s : MathspecialellipticTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialellipticGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_elliptic_graphn_make(size : Int) -> MathspecialellipticGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_elliptic_graphn_len(s : MathspecialellipticGraphN) -> Int { s.size }

pub fn math_special_elliptic_graphn_get(s : MathspecialellipticGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_elliptic_graphn_set(s : MathspecialellipticGraphN, i : Int, v : Double) -> MathspecialellipticGraphN {
  let result = math_special_elliptic_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_special_elliptic_graphn_sum(s : MathspecialellipticGraphN) -> Double { @_common.sum(s.data) }

pub fn math_special_elliptic_graphn_mean(s : MathspecialellipticGraphN) -> Double { @_common.mean(s.data) }

pub fn math_special_elliptic_graphn_scale(s : MathspecialellipticGraphN, f : Double) -> MathspecialellipticGraphN {
  let result = math_special_elliptic_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_special_elliptic_graphn_add(a : MathspecialellipticGraphN, b : MathspecialellipticGraphN) -> MathspecialellipticGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_special_elliptic_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_special_elliptic_graphn_copy(s : MathspecialellipticGraphN) -> MathspecialellipticGraphN {
  let result = math_special_elliptic_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_special_elliptic_graphn_fill(s : MathspecialellipticGraphN, v : Double) -> MathspecialellipticGraphN {
  let result = math_special_elliptic_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_special_elliptic_graphn_min(s : MathspecialellipticGraphN) -> Double { @_common.min(s.data) }

pub fn math_special_elliptic_graphn_max(s : MathspecialellipticGraphN) -> Double { @_common.max(s.data) }

pub fn math_special_elliptic_graphn_to_string(s : MathspecialellipticGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialellipticNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_elliptic_node_make(size : Int) -> MathspecialellipticNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_elliptic_node_len(s : MathspecialellipticNode) -> Int { s.size }

pub fn math_special_elliptic_node_get(s : MathspecialellipticNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_elliptic_node_set(s : MathspecialellipticNode, i : Int, v : Double) -> MathspecialellipticNode {
  let result = math_special_elliptic_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_special_elliptic_node_sum(s : MathspecialellipticNode) -> Double { @_common.sum(s.data) }

pub fn math_special_elliptic_node_mean(s : MathspecialellipticNode) -> Double { @_common.mean(s.data) }

pub fn math_special_elliptic_node_scale(s : MathspecialellipticNode, f : Double) -> MathspecialellipticNode {
  let result = math_special_elliptic_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_special_elliptic_node_add(a : MathspecialellipticNode, b : MathspecialellipticNode) -> MathspecialellipticNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_special_elliptic_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_special_elliptic_node_copy(s : MathspecialellipticNode) -> MathspecialellipticNode {
  let result = math_special_elliptic_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_special_elliptic_node_fill(s : MathspecialellipticNode, v : Double) -> MathspecialellipticNode {
  let result = math_special_elliptic_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_special_elliptic_node_min(s : MathspecialellipticNode) -> Double { @_common.min(s.data) }

pub fn math_special_elliptic_node_max(s : MathspecialellipticNode) -> Double { @_common.max(s.data) }

pub fn math_special_elliptic_node_to_string(s : MathspecialellipticNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialellipticEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_elliptic_edge_make(size : Int) -> MathspecialellipticEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_elliptic_edge_len(s : MathspecialellipticEdge) -> Int { s.size }

pub fn math_special_elliptic_edge_get(s : MathspecialellipticEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_elliptic_edge_set(s : MathspecialellipticEdge, i : Int, v : Double) -> MathspecialellipticEdge {
  let result = math_special_elliptic_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_special_elliptic_edge_sum(s : MathspecialellipticEdge) -> Double { @_common.sum(s.data) }

pub fn math_special_elliptic_edge_mean(s : MathspecialellipticEdge) -> Double { @_common.mean(s.data) }

pub fn math_special_elliptic_edge_scale(s : MathspecialellipticEdge, f : Double) -> MathspecialellipticEdge {
  let result = math_special_elliptic_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_special_elliptic_edge_add(a : MathspecialellipticEdge, b : MathspecialellipticEdge) -> MathspecialellipticEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_special_elliptic_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_special_elliptic_edge_copy(s : MathspecialellipticEdge) -> MathspecialellipticEdge {
  let result = math_special_elliptic_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_special_elliptic_edge_fill(s : MathspecialellipticEdge, v : Double) -> MathspecialellipticEdge {
  let result = math_special_elliptic_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_special_elliptic_edge_min(s : MathspecialellipticEdge) -> Double { @_common.min(s.data) }

pub fn math_special_elliptic_edge_max(s : MathspecialellipticEdge) -> Double { @_common.max(s.data) }

pub fn math_special_elliptic_edge_to_string(s : MathspecialellipticEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialellipticPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_elliptic_path_make(size : Int) -> MathspecialellipticPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_elliptic_path_len(s : MathspecialellipticPath) -> Int { s.size }

pub fn math_special_elliptic_path_get(s : MathspecialellipticPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_elliptic_path_set(s : MathspecialellipticPath, i : Int, v : Double) -> MathspecialellipticPath {
  let result = math_special_elliptic_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_special_elliptic_path_sum(s : MathspecialellipticPath) -> Double { @_common.sum(s.data) }

pub fn math_special_elliptic_path_mean(s : MathspecialellipticPath) -> Double { @_common.mean(s.data) }

pub fn math_special_elliptic_path_scale(s : MathspecialellipticPath, f : Double) -> MathspecialellipticPath {
  let result = math_special_elliptic_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_special_elliptic_path_add(a : MathspecialellipticPath, b : MathspecialellipticPath) -> MathspecialellipticPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_special_elliptic_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_special_elliptic_path_copy(s : MathspecialellipticPath) -> MathspecialellipticPath {
  let result = math_special_elliptic_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_special_elliptic_path_fill(s : MathspecialellipticPath, v : Double) -> MathspecialellipticPath {
  let result = math_special_elliptic_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_special_elliptic_path_min(s : MathspecialellipticPath) -> Double { @_common.min(s.data) }

pub fn math_special_elliptic_path_max(s : MathspecialellipticPath) -> Double { @_common.max(s.data) }

pub fn math_special_elliptic_path_to_string(s : MathspecialellipticPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialellipticCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_elliptic_cluster_make(size : Int) -> MathspecialellipticCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_elliptic_cluster_len(s : MathspecialellipticCluster) -> Int { s.size }

pub fn math_special_elliptic_cluster_get(s : MathspecialellipticCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_elliptic_cluster_set(s : MathspecialellipticCluster, i : Int, v : Double) -> MathspecialellipticCluster {
  let result = math_special_elliptic_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_special_elliptic_cluster_sum(s : MathspecialellipticCluster) -> Double { @_common.sum(s.data) }

pub fn math_special_elliptic_cluster_mean(s : MathspecialellipticCluster) -> Double { @_common.mean(s.data) }

pub fn math_special_elliptic_cluster_scale(s : MathspecialellipticCluster, f : Double) -> MathspecialellipticCluster {
  let result = math_special_elliptic_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_special_elliptic_cluster_add(a : MathspecialellipticCluster, b : MathspecialellipticCluster) -> MathspecialellipticCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_special_elliptic_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_special_elliptic_cluster_copy(s : MathspecialellipticCluster) -> MathspecialellipticCluster {
  let result = math_special_elliptic_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_special_elliptic_cluster_fill(s : MathspecialellipticCluster, v : Double) -> MathspecialellipticCluster {
  let result = math_special_elliptic_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_special_elliptic_cluster_min(s : MathspecialellipticCluster) -> Double { @_common.min(s.data) }

pub fn math_special_elliptic_cluster_max(s : MathspecialellipticCluster) -> Double { @_common.max(s.data) }

pub fn math_special_elliptic_cluster_to_string(s : MathspecialellipticCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialellipticModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_elliptic_model_make(size : Int) -> MathspecialellipticModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_elliptic_model_len(s : MathspecialellipticModel) -> Int { s.size }

pub fn math_special_elliptic_model_get(s : MathspecialellipticModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_elliptic_model_set(s : MathspecialellipticModel, i : Int, v : Double) -> MathspecialellipticModel {
  let result = math_special_elliptic_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_special_elliptic_model_sum(s : MathspecialellipticModel) -> Double { @_common.sum(s.data) }

pub fn math_special_elliptic_model_mean(s : MathspecialellipticModel) -> Double { @_common.mean(s.data) }

pub fn math_special_elliptic_model_scale(s : MathspecialellipticModel, f : Double) -> MathspecialellipticModel {
  let result = math_special_elliptic_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_special_elliptic_model_add(a : MathspecialellipticModel, b : MathspecialellipticModel) -> MathspecialellipticModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_special_elliptic_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_special_elliptic_model_copy(s : MathspecialellipticModel) -> MathspecialellipticModel {
  let result = math_special_elliptic_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_special_elliptic_model_fill(s : MathspecialellipticModel, v : Double) -> MathspecialellipticModel {
  let result = math_special_elliptic_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_special_elliptic_model_min(s : MathspecialellipticModel) -> Double { @_common.min(s.data) }

pub fn math_special_elliptic_model_max(s : MathspecialellipticModel) -> Double { @_common.max(s.data) }

pub fn math_special_elliptic_model_to_string(s : MathspecialellipticModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialellipticLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_elliptic_layer_make(size : Int) -> MathspecialellipticLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_elliptic_layer_len(s : MathspecialellipticLayer) -> Int { s.size }

pub fn math_special_elliptic_layer_get(s : MathspecialellipticLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_elliptic_layer_set(s : MathspecialellipticLayer, i : Int, v : Double) -> MathspecialellipticLayer {
  let result = math_special_elliptic_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_special_elliptic_layer_sum(s : MathspecialellipticLayer) -> Double { @_common.sum(s.data) }

pub fn math_special_elliptic_layer_mean(s : MathspecialellipticLayer) -> Double { @_common.mean(s.data) }

pub fn math_special_elliptic_layer_scale(s : MathspecialellipticLayer, f : Double) -> MathspecialellipticLayer {
  let result = math_special_elliptic_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_special_elliptic_layer_add(a : MathspecialellipticLayer, b : MathspecialellipticLayer) -> MathspecialellipticLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_special_elliptic_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_special_elliptic_layer_copy(s : MathspecialellipticLayer) -> MathspecialellipticLayer {
  let result = math_special_elliptic_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_special_elliptic_layer_fill(s : MathspecialellipticLayer, v : Double) -> MathspecialellipticLayer {
  let result = math_special_elliptic_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_special_elliptic_layer_min(s : MathspecialellipticLayer) -> Double { @_common.min(s.data) }

pub fn math_special_elliptic_layer_max(s : MathspecialellipticLayer) -> Double { @_common.max(s.data) }

pub fn math_special_elliptic_layer_to_string(s : MathspecialellipticLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialellipticBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_elliptic_buffer_make(size : Int) -> MathspecialellipticBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_elliptic_buffer_len(s : MathspecialellipticBuffer) -> Int { s.size }

pub fn math_special_elliptic_buffer_get(s : MathspecialellipticBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_elliptic_buffer_set(s : MathspecialellipticBuffer, i : Int, v : Double) -> MathspecialellipticBuffer {
  let result = math_special_elliptic_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_special_elliptic_buffer_sum(s : MathspecialellipticBuffer) -> Double { @_common.sum(s.data) }

pub fn math_special_elliptic_buffer_mean(s : MathspecialellipticBuffer) -> Double { @_common.mean(s.data) }

pub fn math_special_elliptic_buffer_scale(s : MathspecialellipticBuffer, f : Double) -> MathspecialellipticBuffer {
  let result = math_special_elliptic_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_special_elliptic_buffer_add(a : MathspecialellipticBuffer, b : MathspecialellipticBuffer) -> MathspecialellipticBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_special_elliptic_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_special_elliptic_buffer_copy(s : MathspecialellipticBuffer) -> MathspecialellipticBuffer {
  let result = math_special_elliptic_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_special_elliptic_buffer_fill(s : MathspecialellipticBuffer, v : Double) -> MathspecialellipticBuffer {
  let result = math_special_elliptic_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_special_elliptic_buffer_min(s : MathspecialellipticBuffer) -> Double { @_common.min(s.data) }

pub fn math_special_elliptic_buffer_max(s : MathspecialellipticBuffer) -> Double { @_common.max(s.data) }

pub fn math_special_elliptic_buffer_to_string(s : MathspecialellipticBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialellipticCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_elliptic_cursor_make(size : Int) -> MathspecialellipticCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_elliptic_cursor_len(s : MathspecialellipticCursor) -> Int { s.size }

pub fn math_special_elliptic_cursor_get(s : MathspecialellipticCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_elliptic_cursor_set(s : MathspecialellipticCursor, i : Int, v : Double) -> MathspecialellipticCursor {
  let result = math_special_elliptic_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_special_elliptic_cursor_sum(s : MathspecialellipticCursor) -> Double { @_common.sum(s.data) }

pub fn math_special_elliptic_cursor_mean(s : MathspecialellipticCursor) -> Double { @_common.mean(s.data) }

pub fn math_special_elliptic_cursor_scale(s : MathspecialellipticCursor, f : Double) -> MathspecialellipticCursor {
  let result = math_special_elliptic_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_special_elliptic_cursor_add(a : MathspecialellipticCursor, b : MathspecialellipticCursor) -> MathspecialellipticCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_special_elliptic_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_special_elliptic_cursor_copy(s : MathspecialellipticCursor) -> MathspecialellipticCursor {
  let result = math_special_elliptic_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_special_elliptic_cursor_fill(s : MathspecialellipticCursor, v : Double) -> MathspecialellipticCursor {
  let result = math_special_elliptic_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_special_elliptic_cursor_min(s : MathspecialellipticCursor) -> Double { @_common.min(s.data) }

pub fn math_special_elliptic_cursor_max(s : MathspecialellipticCursor) -> Double { @_common.max(s.data) }

pub fn math_special_elliptic_cursor_to_string(s : MathspecialellipticCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialellipticView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_elliptic_view_make(size : Int) -> MathspecialellipticView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_elliptic_view_len(s : MathspecialellipticView) -> Int { s.size }

pub fn math_special_elliptic_view_get(s : MathspecialellipticView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_elliptic_view_set(s : MathspecialellipticView, i : Int, v : Double) -> MathspecialellipticView {
  let result = math_special_elliptic_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_special_elliptic_view_sum(s : MathspecialellipticView) -> Double { @_common.sum(s.data) }

pub fn math_special_elliptic_view_mean(s : MathspecialellipticView) -> Double { @_common.mean(s.data) }

pub fn math_special_elliptic_view_scale(s : MathspecialellipticView, f : Double) -> MathspecialellipticView {
  let result = math_special_elliptic_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_special_elliptic_view_add(a : MathspecialellipticView, b : MathspecialellipticView) -> MathspecialellipticView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_special_elliptic_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_special_elliptic_view_copy(s : MathspecialellipticView) -> MathspecialellipticView {
  let result = math_special_elliptic_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_special_elliptic_view_fill(s : MathspecialellipticView, v : Double) -> MathspecialellipticView {
  let result = math_special_elliptic_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_special_elliptic_view_min(s : MathspecialellipticView) -> Double { @_common.min(s.data) }

pub fn math_special_elliptic_view_max(s : MathspecialellipticView) -> Double { @_common.max(s.data) }

pub fn math_special_elliptic_view_to_string(s : MathspecialellipticView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialellipticRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_elliptic_range_make(size : Int) -> MathspecialellipticRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_elliptic_range_len(s : MathspecialellipticRange) -> Int { s.size }

pub fn math_special_elliptic_range_get(s : MathspecialellipticRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_elliptic_range_set(s : MathspecialellipticRange, i : Int, v : Double) -> MathspecialellipticRange {
  let result = math_special_elliptic_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_special_elliptic_range_sum(s : MathspecialellipticRange) -> Double { @_common.sum(s.data) }

pub fn math_special_elliptic_range_mean(s : MathspecialellipticRange) -> Double { @_common.mean(s.data) }

pub fn math_special_elliptic_range_scale(s : MathspecialellipticRange, f : Double) -> MathspecialellipticRange {
  let result = math_special_elliptic_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_special_elliptic_range_add(a : MathspecialellipticRange, b : MathspecialellipticRange) -> MathspecialellipticRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_special_elliptic_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_special_elliptic_range_copy(s : MathspecialellipticRange) -> MathspecialellipticRange {
  let result = math_special_elliptic_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_special_elliptic_range_fill(s : MathspecialellipticRange, v : Double) -> MathspecialellipticRange {
  let result = math_special_elliptic_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_special_elliptic_range_min(s : MathspecialellipticRange) -> Double { @_common.min(s.data) }

pub fn math_special_elliptic_range_max(s : MathspecialellipticRange) -> Double { @_common.max(s.data) }

pub fn math_special_elliptic_range_to_string(s : MathspecialellipticRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialellipticSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_elliptic_slice_make(size : Int) -> MathspecialellipticSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_elliptic_slice_len(s : MathspecialellipticSlice) -> Int { s.size }

pub fn math_special_elliptic_slice_get(s : MathspecialellipticSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_elliptic_slice_set(s : MathspecialellipticSlice, i : Int, v : Double) -> MathspecialellipticSlice {
  let result = math_special_elliptic_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_special_elliptic_slice_sum(s : MathspecialellipticSlice) -> Double { @_common.sum(s.data) }

pub fn math_special_elliptic_slice_mean(s : MathspecialellipticSlice) -> Double { @_common.mean(s.data) }

pub fn math_special_elliptic_slice_scale(s : MathspecialellipticSlice, f : Double) -> MathspecialellipticSlice {
  let result = math_special_elliptic_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_special_elliptic_slice_add(a : MathspecialellipticSlice, b : MathspecialellipticSlice) -> MathspecialellipticSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_special_elliptic_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_special_elliptic_slice_copy(s : MathspecialellipticSlice) -> MathspecialellipticSlice {
  let result = math_special_elliptic_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_special_elliptic_slice_fill(s : MathspecialellipticSlice, v : Double) -> MathspecialellipticSlice {
  let result = math_special_elliptic_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_special_elliptic_slice_min(s : MathspecialellipticSlice) -> Double { @_common.min(s.data) }

pub fn math_special_elliptic_slice_max(s : MathspecialellipticSlice) -> Double { @_common.max(s.data) }

pub fn math_special_elliptic_slice_to_string(s : MathspecialellipticSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

