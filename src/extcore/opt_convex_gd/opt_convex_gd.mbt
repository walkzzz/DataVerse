///===
/// extcore/opt_convex_gd

pub(all) struct OptconvexgdPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn opt_convex_gd_make_point(x : Double, y : Double) -> OptconvexgdPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn opt_convex_gd_make_point3(x : Double, y : Double, z : Double) -> OptconvexgdPoint {
  { x, y, z, label: 0 }
}

pub fn opt_convex_gd_point_x(pt : OptconvexgdPoint) -> Double { pt.x }

pub fn opt_convex_gd_point_y(pt : OptconvexgdPoint) -> Double { pt.y }

pub fn opt_convex_gd_point_z(pt : OptconvexgdPoint) -> Double { pt.z }

pub fn opt_convex_gd_point_label(pt : OptconvexgdPoint) -> Int { pt.label }

pub fn opt_convex_gd_point_dist(a : OptconvexgdPoint, b : OptconvexgdPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn opt_convex_gd_point_add(a : OptconvexgdPoint, b : OptconvexgdPoint) -> OptconvexgdPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn opt_convex_gd_point_sub(a : OptconvexgdPoint, b : OptconvexgdPoint) -> OptconvexgdPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn opt_convex_gd_point_scale(pt : OptconvexgdPoint, s : Double) -> OptconvexgdPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn opt_convex_gd_point_dot(a : OptconvexgdPoint, b : OptconvexgdPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn opt_convex_gd_point_cross(a : OptconvexgdPoint, b : OptconvexgdPoint) -> OptconvexgdPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn opt_convex_gd_point_norm(pt : OptconvexgdPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn opt_convex_gd_point_normalize(pt : OptconvexgdPoint) -> OptconvexgdPoint {
  let n = opt_convex_gd_point_norm(pt)
  if n < 0.0000001 { pt } else { opt_convex_gd_point_scale(pt, 1.0 / n) }
}

pub fn opt_convex_gd_point_negate(pt : OptconvexgdPoint) -> OptconvexgdPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn opt_convex_gd_point_mid(a : OptconvexgdPoint, b : OptconvexgdPoint) -> OptconvexgdPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn opt_convex_gd_point_lerp(a : OptconvexgdPoint, b : OptconvexgdPoint, t : Double) -> OptconvexgdPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn opt_convex_gd_point_to_string(pt : OptconvexgdPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct OptconvexgdSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn opt_convex_gd_make_series(vals : Array[Double], name : String) -> OptconvexgdSeries {
  { vals, name, meta: 0 }
}

pub fn opt_convex_gd_series_len(s : OptconvexgdSeries) -> Int { s.vals.length() }

pub fn opt_convex_gd_series_sum(s : OptconvexgdSeries) -> Double { @_common.sum(s.vals) }

pub fn opt_convex_gd_series_mean(s : OptconvexgdSeries) -> Double { @_common.mean(s.vals) }

pub fn opt_convex_gd_series_min(s : OptconvexgdSeries) -> Double { @_common.min(s.vals) }

pub fn opt_convex_gd_series_max(s : OptconvexgdSeries) -> Double { @_common.max(s.vals) }

pub fn opt_convex_gd_series_range(s : OptconvexgdSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn opt_convex_gd_series_var(s : OptconvexgdSeries) -> Double { @_common.variance(s.vals) }

pub fn opt_convex_gd_series_std(s : OptconvexgdSeries) -> Double { @_common.std(s.vals) }

pub fn opt_convex_gd_series_median(s : OptconvexgdSeries) -> Double { @_common.median(s.vals) }

pub fn opt_convex_gd_series_scale(s : OptconvexgdSeries, f : Double) -> OptconvexgdSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn opt_convex_gd_series_add(a : OptconvexgdSeries, b : OptconvexgdSeries) -> OptconvexgdSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn opt_convex_gd_series_sub(a : OptconvexgdSeries, b : OptconvexgdSeries) -> OptconvexgdSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn opt_convex_gd_series_normalize(s : OptconvexgdSeries) -> OptconvexgdSeries {
  let mn = opt_convex_gd_series_min(s)
  let mx = opt_convex_gd_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn opt_convex_gd_series_cumsum(s : OptconvexgdSeries) -> OptconvexgdSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn opt_convex_gd_series_to_string(s : OptconvexgdSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct OptconvexgdMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn opt_convex_gd_make_matrix(rows : Int, cols : Int, val : Double) -> OptconvexgdMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn opt_convex_gd_matrix_identity(n : Int) -> OptconvexgdMatrix {
  let m = opt_convex_gd_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn opt_convex_gd_matrix_get(m : OptconvexgdMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn opt_convex_gd_matrix_transpose(m : OptconvexgdMatrix) -> OptconvexgdMatrix {
  let result = opt_convex_gd_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn opt_convex_gd_matrix_add(a : OptconvexgdMatrix, b : OptconvexgdMatrix) -> OptconvexgdMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = opt_convex_gd_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn opt_convex_gd_matrix_scale(m : OptconvexgdMatrix, s : Double) -> OptconvexgdMatrix {
  let result = opt_convex_gd_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn opt_convex_gd_matrix_multiply(a : OptconvexgdMatrix, b : OptconvexgdMatrix) -> OptconvexgdMatrix {
  if a.cols != b.rows { return opt_convex_gd_make_matrix(a.rows, b.cols, 0.0) }
  let result = opt_convex_gd_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn opt_convex_gd_matrix_trace(m : OptconvexgdMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn opt_convex_gd_matrix_det(m : OptconvexgdMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn opt_convex_gd_matrix_norm(m : OptconvexgdMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn opt_convex_gd_matrix_to_string(m : OptconvexgdMatrix) -> String {
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

pub(all) struct OptconvexgdVector {
  comps : Array[Double]
  dim : Int
}

pub fn opt_convex_gd_make_vector(comps : Array[Double]) -> OptconvexgdVector {
  { comps, dim: comps.length() }
}

pub fn opt_convex_gd_vector_zero(dim : Int) -> OptconvexgdVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn opt_convex_gd_vector_add(a : OptconvexgdVector, b : OptconvexgdVector) -> OptconvexgdVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn opt_convex_gd_vector_sub(a : OptconvexgdVector, b : OptconvexgdVector) -> OptconvexgdVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn opt_convex_gd_vector_scale(v : OptconvexgdVector, s : Double) -> OptconvexgdVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn opt_convex_gd_vector_dot(a : OptconvexgdVector, b : OptconvexgdVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn opt_convex_gd_vector_norm(v : OptconvexgdVector) -> Double { @_common.sqrt(opt_convex_gd_vector_dot(v, v)) }

pub fn opt_convex_gd_vector_normalize(v : OptconvexgdVector) -> OptconvexgdVector {
  let n = opt_convex_gd_vector_norm(v)
  if n < 0.0000001 { v } else { opt_convex_gd_vector_scale(v, 1.0 / n) }
}

pub fn opt_convex_gd_vector_dist(a : OptconvexgdVector, b : OptconvexgdVector) -> Double {
  opt_convex_gd_vector_norm(opt_convex_gd_vector_sub(a, b))
}

pub fn opt_convex_gd_vector_to_string(v : OptconvexgdVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn opt_convex_gd_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn opt_convex_gd_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn opt_convex_gd_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn opt_convex_gd_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn opt_convex_gd_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn opt_convex_gd_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn opt_convex_gd_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn opt_convex_gd_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn opt_convex_gd_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn opt_convex_gd_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn opt_convex_gd_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn opt_convex_gd_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn opt_convex_gd_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn opt_convex_gd_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn opt_convex_gd_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn opt_convex_gd_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn opt_convex_gd_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn opt_convex_gd_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn opt_convex_gd_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn opt_convex_gd_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn opt_convex_gd_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn opt_convex_gd_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn opt_convex_gd_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn opt_convex_gd_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn opt_convex_gd_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn opt_convex_gd_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn opt_convex_gd_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn opt_convex_gd_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn opt_convex_gd_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct OptconvexgdFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_gd_frame_make(size : Int) -> OptconvexgdFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_gd_frame_len(s : OptconvexgdFrame) -> Int { s.size }

pub fn opt_convex_gd_frame_get(s : OptconvexgdFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_gd_frame_set(s : OptconvexgdFrame, i : Int, v : Double) -> OptconvexgdFrame {
  let result = opt_convex_gd_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_convex_gd_frame_sum(s : OptconvexgdFrame) -> Double { @_common.sum(s.data) }

pub fn opt_convex_gd_frame_mean(s : OptconvexgdFrame) -> Double { @_common.mean(s.data) }

pub fn opt_convex_gd_frame_scale(s : OptconvexgdFrame, f : Double) -> OptconvexgdFrame {
  let result = opt_convex_gd_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_convex_gd_frame_add(a : OptconvexgdFrame, b : OptconvexgdFrame) -> OptconvexgdFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_convex_gd_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_convex_gd_frame_copy(s : OptconvexgdFrame) -> OptconvexgdFrame {
  let result = opt_convex_gd_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_convex_gd_frame_fill(s : OptconvexgdFrame, v : Double) -> OptconvexgdFrame {
  let result = opt_convex_gd_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_convex_gd_frame_min(s : OptconvexgdFrame) -> Double { @_common.min(s.data) }

pub fn opt_convex_gd_frame_max(s : OptconvexgdFrame) -> Double { @_common.max(s.data) }

pub fn opt_convex_gd_frame_to_string(s : OptconvexgdFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexgdTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_gd_table_make(size : Int) -> OptconvexgdTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_gd_table_len(s : OptconvexgdTable) -> Int { s.size }

pub fn opt_convex_gd_table_get(s : OptconvexgdTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_gd_table_set(s : OptconvexgdTable, i : Int, v : Double) -> OptconvexgdTable {
  let result = opt_convex_gd_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_convex_gd_table_sum(s : OptconvexgdTable) -> Double { @_common.sum(s.data) }

pub fn opt_convex_gd_table_mean(s : OptconvexgdTable) -> Double { @_common.mean(s.data) }

pub fn opt_convex_gd_table_scale(s : OptconvexgdTable, f : Double) -> OptconvexgdTable {
  let result = opt_convex_gd_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_convex_gd_table_add(a : OptconvexgdTable, b : OptconvexgdTable) -> OptconvexgdTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_convex_gd_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_convex_gd_table_copy(s : OptconvexgdTable) -> OptconvexgdTable {
  let result = opt_convex_gd_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_convex_gd_table_fill(s : OptconvexgdTable, v : Double) -> OptconvexgdTable {
  let result = opt_convex_gd_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_convex_gd_table_min(s : OptconvexgdTable) -> Double { @_common.min(s.data) }

pub fn opt_convex_gd_table_max(s : OptconvexgdTable) -> Double { @_common.max(s.data) }

pub fn opt_convex_gd_table_to_string(s : OptconvexgdTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexgdGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_gd_graphn_make(size : Int) -> OptconvexgdGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_gd_graphn_len(s : OptconvexgdGraphN) -> Int { s.size }

pub fn opt_convex_gd_graphn_get(s : OptconvexgdGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_gd_graphn_set(s : OptconvexgdGraphN, i : Int, v : Double) -> OptconvexgdGraphN {
  let result = opt_convex_gd_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_convex_gd_graphn_sum(s : OptconvexgdGraphN) -> Double { @_common.sum(s.data) }

pub fn opt_convex_gd_graphn_mean(s : OptconvexgdGraphN) -> Double { @_common.mean(s.data) }

pub fn opt_convex_gd_graphn_scale(s : OptconvexgdGraphN, f : Double) -> OptconvexgdGraphN {
  let result = opt_convex_gd_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_convex_gd_graphn_add(a : OptconvexgdGraphN, b : OptconvexgdGraphN) -> OptconvexgdGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_convex_gd_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_convex_gd_graphn_copy(s : OptconvexgdGraphN) -> OptconvexgdGraphN {
  let result = opt_convex_gd_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_convex_gd_graphn_fill(s : OptconvexgdGraphN, v : Double) -> OptconvexgdGraphN {
  let result = opt_convex_gd_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_convex_gd_graphn_min(s : OptconvexgdGraphN) -> Double { @_common.min(s.data) }

pub fn opt_convex_gd_graphn_max(s : OptconvexgdGraphN) -> Double { @_common.max(s.data) }

pub fn opt_convex_gd_graphn_to_string(s : OptconvexgdGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexgdNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_gd_node_make(size : Int) -> OptconvexgdNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_gd_node_len(s : OptconvexgdNode) -> Int { s.size }

pub fn opt_convex_gd_node_get(s : OptconvexgdNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_gd_node_set(s : OptconvexgdNode, i : Int, v : Double) -> OptconvexgdNode {
  let result = opt_convex_gd_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_convex_gd_node_sum(s : OptconvexgdNode) -> Double { @_common.sum(s.data) }

pub fn opt_convex_gd_node_mean(s : OptconvexgdNode) -> Double { @_common.mean(s.data) }

pub fn opt_convex_gd_node_scale(s : OptconvexgdNode, f : Double) -> OptconvexgdNode {
  let result = opt_convex_gd_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_convex_gd_node_add(a : OptconvexgdNode, b : OptconvexgdNode) -> OptconvexgdNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_convex_gd_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_convex_gd_node_copy(s : OptconvexgdNode) -> OptconvexgdNode {
  let result = opt_convex_gd_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_convex_gd_node_fill(s : OptconvexgdNode, v : Double) -> OptconvexgdNode {
  let result = opt_convex_gd_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_convex_gd_node_min(s : OptconvexgdNode) -> Double { @_common.min(s.data) }

pub fn opt_convex_gd_node_max(s : OptconvexgdNode) -> Double { @_common.max(s.data) }

pub fn opt_convex_gd_node_to_string(s : OptconvexgdNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexgdEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_gd_edge_make(size : Int) -> OptconvexgdEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_gd_edge_len(s : OptconvexgdEdge) -> Int { s.size }

pub fn opt_convex_gd_edge_get(s : OptconvexgdEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_gd_edge_set(s : OptconvexgdEdge, i : Int, v : Double) -> OptconvexgdEdge {
  let result = opt_convex_gd_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_convex_gd_edge_sum(s : OptconvexgdEdge) -> Double { @_common.sum(s.data) }

pub fn opt_convex_gd_edge_mean(s : OptconvexgdEdge) -> Double { @_common.mean(s.data) }

pub fn opt_convex_gd_edge_scale(s : OptconvexgdEdge, f : Double) -> OptconvexgdEdge {
  let result = opt_convex_gd_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_convex_gd_edge_add(a : OptconvexgdEdge, b : OptconvexgdEdge) -> OptconvexgdEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_convex_gd_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_convex_gd_edge_copy(s : OptconvexgdEdge) -> OptconvexgdEdge {
  let result = opt_convex_gd_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_convex_gd_edge_fill(s : OptconvexgdEdge, v : Double) -> OptconvexgdEdge {
  let result = opt_convex_gd_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_convex_gd_edge_min(s : OptconvexgdEdge) -> Double { @_common.min(s.data) }

pub fn opt_convex_gd_edge_max(s : OptconvexgdEdge) -> Double { @_common.max(s.data) }

pub fn opt_convex_gd_edge_to_string(s : OptconvexgdEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexgdPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_gd_path_make(size : Int) -> OptconvexgdPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_gd_path_len(s : OptconvexgdPath) -> Int { s.size }

pub fn opt_convex_gd_path_get(s : OptconvexgdPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_gd_path_set(s : OptconvexgdPath, i : Int, v : Double) -> OptconvexgdPath {
  let result = opt_convex_gd_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_convex_gd_path_sum(s : OptconvexgdPath) -> Double { @_common.sum(s.data) }

pub fn opt_convex_gd_path_mean(s : OptconvexgdPath) -> Double { @_common.mean(s.data) }

pub fn opt_convex_gd_path_scale(s : OptconvexgdPath, f : Double) -> OptconvexgdPath {
  let result = opt_convex_gd_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_convex_gd_path_add(a : OptconvexgdPath, b : OptconvexgdPath) -> OptconvexgdPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_convex_gd_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_convex_gd_path_copy(s : OptconvexgdPath) -> OptconvexgdPath {
  let result = opt_convex_gd_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_convex_gd_path_fill(s : OptconvexgdPath, v : Double) -> OptconvexgdPath {
  let result = opt_convex_gd_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_convex_gd_path_min(s : OptconvexgdPath) -> Double { @_common.min(s.data) }

pub fn opt_convex_gd_path_max(s : OptconvexgdPath) -> Double { @_common.max(s.data) }

pub fn opt_convex_gd_path_to_string(s : OptconvexgdPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexgdCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_gd_cluster_make(size : Int) -> OptconvexgdCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_gd_cluster_len(s : OptconvexgdCluster) -> Int { s.size }

pub fn opt_convex_gd_cluster_get(s : OptconvexgdCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_gd_cluster_set(s : OptconvexgdCluster, i : Int, v : Double) -> OptconvexgdCluster {
  let result = opt_convex_gd_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_convex_gd_cluster_sum(s : OptconvexgdCluster) -> Double { @_common.sum(s.data) }

pub fn opt_convex_gd_cluster_mean(s : OptconvexgdCluster) -> Double { @_common.mean(s.data) }

pub fn opt_convex_gd_cluster_scale(s : OptconvexgdCluster, f : Double) -> OptconvexgdCluster {
  let result = opt_convex_gd_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_convex_gd_cluster_add(a : OptconvexgdCluster, b : OptconvexgdCluster) -> OptconvexgdCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_convex_gd_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_convex_gd_cluster_copy(s : OptconvexgdCluster) -> OptconvexgdCluster {
  let result = opt_convex_gd_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_convex_gd_cluster_fill(s : OptconvexgdCluster, v : Double) -> OptconvexgdCluster {
  let result = opt_convex_gd_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_convex_gd_cluster_min(s : OptconvexgdCluster) -> Double { @_common.min(s.data) }

pub fn opt_convex_gd_cluster_max(s : OptconvexgdCluster) -> Double { @_common.max(s.data) }

pub fn opt_convex_gd_cluster_to_string(s : OptconvexgdCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexgdModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_gd_model_make(size : Int) -> OptconvexgdModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_gd_model_len(s : OptconvexgdModel) -> Int { s.size }

pub fn opt_convex_gd_model_get(s : OptconvexgdModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_gd_model_set(s : OptconvexgdModel, i : Int, v : Double) -> OptconvexgdModel {
  let result = opt_convex_gd_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_convex_gd_model_sum(s : OptconvexgdModel) -> Double { @_common.sum(s.data) }

pub fn opt_convex_gd_model_mean(s : OptconvexgdModel) -> Double { @_common.mean(s.data) }

pub fn opt_convex_gd_model_scale(s : OptconvexgdModel, f : Double) -> OptconvexgdModel {
  let result = opt_convex_gd_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_convex_gd_model_add(a : OptconvexgdModel, b : OptconvexgdModel) -> OptconvexgdModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_convex_gd_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_convex_gd_model_copy(s : OptconvexgdModel) -> OptconvexgdModel {
  let result = opt_convex_gd_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_convex_gd_model_fill(s : OptconvexgdModel, v : Double) -> OptconvexgdModel {
  let result = opt_convex_gd_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_convex_gd_model_min(s : OptconvexgdModel) -> Double { @_common.min(s.data) }

pub fn opt_convex_gd_model_max(s : OptconvexgdModel) -> Double { @_common.max(s.data) }

pub fn opt_convex_gd_model_to_string(s : OptconvexgdModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexgdLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_gd_layer_make(size : Int) -> OptconvexgdLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_gd_layer_len(s : OptconvexgdLayer) -> Int { s.size }

pub fn opt_convex_gd_layer_get(s : OptconvexgdLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_gd_layer_set(s : OptconvexgdLayer, i : Int, v : Double) -> OptconvexgdLayer {
  let result = opt_convex_gd_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_convex_gd_layer_sum(s : OptconvexgdLayer) -> Double { @_common.sum(s.data) }

pub fn opt_convex_gd_layer_mean(s : OptconvexgdLayer) -> Double { @_common.mean(s.data) }

pub fn opt_convex_gd_layer_scale(s : OptconvexgdLayer, f : Double) -> OptconvexgdLayer {
  let result = opt_convex_gd_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_convex_gd_layer_add(a : OptconvexgdLayer, b : OptconvexgdLayer) -> OptconvexgdLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_convex_gd_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_convex_gd_layer_copy(s : OptconvexgdLayer) -> OptconvexgdLayer {
  let result = opt_convex_gd_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_convex_gd_layer_fill(s : OptconvexgdLayer, v : Double) -> OptconvexgdLayer {
  let result = opt_convex_gd_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_convex_gd_layer_min(s : OptconvexgdLayer) -> Double { @_common.min(s.data) }

pub fn opt_convex_gd_layer_max(s : OptconvexgdLayer) -> Double { @_common.max(s.data) }

pub fn opt_convex_gd_layer_to_string(s : OptconvexgdLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexgdBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_gd_buffer_make(size : Int) -> OptconvexgdBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_gd_buffer_len(s : OptconvexgdBuffer) -> Int { s.size }

pub fn opt_convex_gd_buffer_get(s : OptconvexgdBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_gd_buffer_set(s : OptconvexgdBuffer, i : Int, v : Double) -> OptconvexgdBuffer {
  let result = opt_convex_gd_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_convex_gd_buffer_sum(s : OptconvexgdBuffer) -> Double { @_common.sum(s.data) }

pub fn opt_convex_gd_buffer_mean(s : OptconvexgdBuffer) -> Double { @_common.mean(s.data) }

pub fn opt_convex_gd_buffer_scale(s : OptconvexgdBuffer, f : Double) -> OptconvexgdBuffer {
  let result = opt_convex_gd_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_convex_gd_buffer_add(a : OptconvexgdBuffer, b : OptconvexgdBuffer) -> OptconvexgdBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_convex_gd_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_convex_gd_buffer_copy(s : OptconvexgdBuffer) -> OptconvexgdBuffer {
  let result = opt_convex_gd_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_convex_gd_buffer_fill(s : OptconvexgdBuffer, v : Double) -> OptconvexgdBuffer {
  let result = opt_convex_gd_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_convex_gd_buffer_min(s : OptconvexgdBuffer) -> Double { @_common.min(s.data) }

pub fn opt_convex_gd_buffer_max(s : OptconvexgdBuffer) -> Double { @_common.max(s.data) }

pub fn opt_convex_gd_buffer_to_string(s : OptconvexgdBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexgdCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_gd_cursor_make(size : Int) -> OptconvexgdCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_gd_cursor_len(s : OptconvexgdCursor) -> Int { s.size }

pub fn opt_convex_gd_cursor_get(s : OptconvexgdCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_gd_cursor_set(s : OptconvexgdCursor, i : Int, v : Double) -> OptconvexgdCursor {
  let result = opt_convex_gd_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_convex_gd_cursor_sum(s : OptconvexgdCursor) -> Double { @_common.sum(s.data) }

pub fn opt_convex_gd_cursor_mean(s : OptconvexgdCursor) -> Double { @_common.mean(s.data) }

pub fn opt_convex_gd_cursor_scale(s : OptconvexgdCursor, f : Double) -> OptconvexgdCursor {
  let result = opt_convex_gd_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_convex_gd_cursor_add(a : OptconvexgdCursor, b : OptconvexgdCursor) -> OptconvexgdCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_convex_gd_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_convex_gd_cursor_copy(s : OptconvexgdCursor) -> OptconvexgdCursor {
  let result = opt_convex_gd_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_convex_gd_cursor_fill(s : OptconvexgdCursor, v : Double) -> OptconvexgdCursor {
  let result = opt_convex_gd_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_convex_gd_cursor_min(s : OptconvexgdCursor) -> Double { @_common.min(s.data) }

pub fn opt_convex_gd_cursor_max(s : OptconvexgdCursor) -> Double { @_common.max(s.data) }

pub fn opt_convex_gd_cursor_to_string(s : OptconvexgdCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexgdView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_gd_view_make(size : Int) -> OptconvexgdView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_gd_view_len(s : OptconvexgdView) -> Int { s.size }

pub fn opt_convex_gd_view_get(s : OptconvexgdView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_gd_view_set(s : OptconvexgdView, i : Int, v : Double) -> OptconvexgdView {
  let result = opt_convex_gd_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_convex_gd_view_sum(s : OptconvexgdView) -> Double { @_common.sum(s.data) }

pub fn opt_convex_gd_view_mean(s : OptconvexgdView) -> Double { @_common.mean(s.data) }

pub fn opt_convex_gd_view_scale(s : OptconvexgdView, f : Double) -> OptconvexgdView {
  let result = opt_convex_gd_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_convex_gd_view_add(a : OptconvexgdView, b : OptconvexgdView) -> OptconvexgdView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_convex_gd_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_convex_gd_view_copy(s : OptconvexgdView) -> OptconvexgdView {
  let result = opt_convex_gd_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_convex_gd_view_fill(s : OptconvexgdView, v : Double) -> OptconvexgdView {
  let result = opt_convex_gd_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_convex_gd_view_min(s : OptconvexgdView) -> Double { @_common.min(s.data) }

pub fn opt_convex_gd_view_max(s : OptconvexgdView) -> Double { @_common.max(s.data) }

pub fn opt_convex_gd_view_to_string(s : OptconvexgdView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexgdRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_gd_range_make(size : Int) -> OptconvexgdRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_gd_range_len(s : OptconvexgdRange) -> Int { s.size }

pub fn opt_convex_gd_range_get(s : OptconvexgdRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_gd_range_set(s : OptconvexgdRange, i : Int, v : Double) -> OptconvexgdRange {
  let result = opt_convex_gd_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_convex_gd_range_sum(s : OptconvexgdRange) -> Double { @_common.sum(s.data) }

pub fn opt_convex_gd_range_mean(s : OptconvexgdRange) -> Double { @_common.mean(s.data) }

pub fn opt_convex_gd_range_scale(s : OptconvexgdRange, f : Double) -> OptconvexgdRange {
  let result = opt_convex_gd_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_convex_gd_range_add(a : OptconvexgdRange, b : OptconvexgdRange) -> OptconvexgdRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_convex_gd_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_convex_gd_range_copy(s : OptconvexgdRange) -> OptconvexgdRange {
  let result = opt_convex_gd_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_convex_gd_range_fill(s : OptconvexgdRange, v : Double) -> OptconvexgdRange {
  let result = opt_convex_gd_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_convex_gd_range_min(s : OptconvexgdRange) -> Double { @_common.min(s.data) }

pub fn opt_convex_gd_range_max(s : OptconvexgdRange) -> Double { @_common.max(s.data) }

pub fn opt_convex_gd_range_to_string(s : OptconvexgdRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexgdSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_gd_slice_make(size : Int) -> OptconvexgdSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_gd_slice_len(s : OptconvexgdSlice) -> Int { s.size }

pub fn opt_convex_gd_slice_get(s : OptconvexgdSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_gd_slice_set(s : OptconvexgdSlice, i : Int, v : Double) -> OptconvexgdSlice {
  let result = opt_convex_gd_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_convex_gd_slice_sum(s : OptconvexgdSlice) -> Double { @_common.sum(s.data) }

pub fn opt_convex_gd_slice_mean(s : OptconvexgdSlice) -> Double { @_common.mean(s.data) }

pub fn opt_convex_gd_slice_scale(s : OptconvexgdSlice, f : Double) -> OptconvexgdSlice {
  let result = opt_convex_gd_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_convex_gd_slice_add(a : OptconvexgdSlice, b : OptconvexgdSlice) -> OptconvexgdSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_convex_gd_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_convex_gd_slice_copy(s : OptconvexgdSlice) -> OptconvexgdSlice {
  let result = opt_convex_gd_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_convex_gd_slice_fill(s : OptconvexgdSlice, v : Double) -> OptconvexgdSlice {
  let result = opt_convex_gd_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_convex_gd_slice_min(s : OptconvexgdSlice) -> Double { @_common.min(s.data) }

pub fn opt_convex_gd_slice_max(s : OptconvexgdSlice) -> Double { @_common.max(s.data) }

pub fn opt_convex_gd_slice_to_string(s : OptconvexgdSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

