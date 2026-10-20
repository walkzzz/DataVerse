///===
/// extcore/opt_convex_dfp

pub(all) struct OptconvexdfpPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn opt_convex_dfp_make_point(x : Double, y : Double) -> OptconvexdfpPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn opt_convex_dfp_make_point3(x : Double, y : Double, z : Double) -> OptconvexdfpPoint {
  { x, y, z, label: 0 }
}

pub fn opt_convex_dfp_point_x(pt : OptconvexdfpPoint) -> Double { pt.x }

pub fn opt_convex_dfp_point_y(pt : OptconvexdfpPoint) -> Double { pt.y }

pub fn opt_convex_dfp_point_z(pt : OptconvexdfpPoint) -> Double { pt.z }

pub fn opt_convex_dfp_point_label(pt : OptconvexdfpPoint) -> Int { pt.label }

pub fn opt_convex_dfp_point_dist(a : OptconvexdfpPoint, b : OptconvexdfpPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn opt_convex_dfp_point_add(a : OptconvexdfpPoint, b : OptconvexdfpPoint) -> OptconvexdfpPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn opt_convex_dfp_point_sub(a : OptconvexdfpPoint, b : OptconvexdfpPoint) -> OptconvexdfpPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn opt_convex_dfp_point_scale(pt : OptconvexdfpPoint, s : Double) -> OptconvexdfpPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn opt_convex_dfp_point_dot(a : OptconvexdfpPoint, b : OptconvexdfpPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn opt_convex_dfp_point_cross(a : OptconvexdfpPoint, b : OptconvexdfpPoint) -> OptconvexdfpPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn opt_convex_dfp_point_norm(pt : OptconvexdfpPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn opt_convex_dfp_point_normalize(pt : OptconvexdfpPoint) -> OptconvexdfpPoint {
  let n = opt_convex_dfp_point_norm(pt)
  if n < 0.0000001 { pt } else { opt_convex_dfp_point_scale(pt, 1.0 / n) }
}

pub fn opt_convex_dfp_point_negate(pt : OptconvexdfpPoint) -> OptconvexdfpPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn opt_convex_dfp_point_mid(a : OptconvexdfpPoint, b : OptconvexdfpPoint) -> OptconvexdfpPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn opt_convex_dfp_point_lerp(a : OptconvexdfpPoint, b : OptconvexdfpPoint, t : Double) -> OptconvexdfpPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn opt_convex_dfp_point_to_string(pt : OptconvexdfpPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct OptconvexdfpSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn opt_convex_dfp_make_series(vals : Array[Double], name : String) -> OptconvexdfpSeries {
  { vals, name, meta: 0 }
}

pub fn opt_convex_dfp_series_len(s : OptconvexdfpSeries) -> Int { s.vals.length() }

pub fn opt_convex_dfp_series_sum(s : OptconvexdfpSeries) -> Double { @_common.sum(s.vals) }

pub fn opt_convex_dfp_series_mean(s : OptconvexdfpSeries) -> Double { @_common.mean(s.vals) }

pub fn opt_convex_dfp_series_min(s : OptconvexdfpSeries) -> Double { @_common.min(s.vals) }

pub fn opt_convex_dfp_series_max(s : OptconvexdfpSeries) -> Double { @_common.max(s.vals) }

pub fn opt_convex_dfp_series_range(s : OptconvexdfpSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn opt_convex_dfp_series_var(s : OptconvexdfpSeries) -> Double { @_common.variance(s.vals) }

pub fn opt_convex_dfp_series_std(s : OptconvexdfpSeries) -> Double { @_common.std(s.vals) }

pub fn opt_convex_dfp_series_median(s : OptconvexdfpSeries) -> Double { @_common.median(s.vals) }

pub fn opt_convex_dfp_series_scale(s : OptconvexdfpSeries, f : Double) -> OptconvexdfpSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn opt_convex_dfp_series_add(a : OptconvexdfpSeries, b : OptconvexdfpSeries) -> OptconvexdfpSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn opt_convex_dfp_series_sub(a : OptconvexdfpSeries, b : OptconvexdfpSeries) -> OptconvexdfpSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn opt_convex_dfp_series_normalize(s : OptconvexdfpSeries) -> OptconvexdfpSeries {
  let mn = opt_convex_dfp_series_min(s)
  let mx = opt_convex_dfp_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn opt_convex_dfp_series_cumsum(s : OptconvexdfpSeries) -> OptconvexdfpSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn opt_convex_dfp_series_to_string(s : OptconvexdfpSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct OptconvexdfpMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn opt_convex_dfp_make_matrix(rows : Int, cols : Int, val : Double) -> OptconvexdfpMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn opt_convex_dfp_matrix_identity(n : Int) -> OptconvexdfpMatrix {
  let m = opt_convex_dfp_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn opt_convex_dfp_matrix_get(m : OptconvexdfpMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn opt_convex_dfp_matrix_transpose(m : OptconvexdfpMatrix) -> OptconvexdfpMatrix {
  let result = opt_convex_dfp_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn opt_convex_dfp_matrix_add(a : OptconvexdfpMatrix, b : OptconvexdfpMatrix) -> OptconvexdfpMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = opt_convex_dfp_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn opt_convex_dfp_matrix_scale(m : OptconvexdfpMatrix, s : Double) -> OptconvexdfpMatrix {
  let result = opt_convex_dfp_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn opt_convex_dfp_matrix_multiply(a : OptconvexdfpMatrix, b : OptconvexdfpMatrix) -> OptconvexdfpMatrix {
  if a.cols != b.rows { return opt_convex_dfp_make_matrix(a.rows, b.cols, 0.0) }
  let result = opt_convex_dfp_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn opt_convex_dfp_matrix_trace(m : OptconvexdfpMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn opt_convex_dfp_matrix_det(m : OptconvexdfpMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn opt_convex_dfp_matrix_norm(m : OptconvexdfpMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn opt_convex_dfp_matrix_to_string(m : OptconvexdfpMatrix) -> String {
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

pub(all) struct OptconvexdfpVector {
  comps : Array[Double]
  dim : Int
}

pub fn opt_convex_dfp_make_vector(comps : Array[Double]) -> OptconvexdfpVector {
  { comps, dim: comps.length() }
}

pub fn opt_convex_dfp_vector_zero(dim : Int) -> OptconvexdfpVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn opt_convex_dfp_vector_add(a : OptconvexdfpVector, b : OptconvexdfpVector) -> OptconvexdfpVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn opt_convex_dfp_vector_sub(a : OptconvexdfpVector, b : OptconvexdfpVector) -> OptconvexdfpVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn opt_convex_dfp_vector_scale(v : OptconvexdfpVector, s : Double) -> OptconvexdfpVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn opt_convex_dfp_vector_dot(a : OptconvexdfpVector, b : OptconvexdfpVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn opt_convex_dfp_vector_norm(v : OptconvexdfpVector) -> Double { @_common.sqrt(opt_convex_dfp_vector_dot(v, v)) }

pub fn opt_convex_dfp_vector_normalize(v : OptconvexdfpVector) -> OptconvexdfpVector {
  let n = opt_convex_dfp_vector_norm(v)
  if n < 0.0000001 { v } else { opt_convex_dfp_vector_scale(v, 1.0 / n) }
}

pub fn opt_convex_dfp_vector_dist(a : OptconvexdfpVector, b : OptconvexdfpVector) -> Double {
  opt_convex_dfp_vector_norm(opt_convex_dfp_vector_sub(a, b))
}

pub fn opt_convex_dfp_vector_to_string(v : OptconvexdfpVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn opt_convex_dfp_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn opt_convex_dfp_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn opt_convex_dfp_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn opt_convex_dfp_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn opt_convex_dfp_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn opt_convex_dfp_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn opt_convex_dfp_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn opt_convex_dfp_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn opt_convex_dfp_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn opt_convex_dfp_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn opt_convex_dfp_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn opt_convex_dfp_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn opt_convex_dfp_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn opt_convex_dfp_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn opt_convex_dfp_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn opt_convex_dfp_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn opt_convex_dfp_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn opt_convex_dfp_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn opt_convex_dfp_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn opt_convex_dfp_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn opt_convex_dfp_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn opt_convex_dfp_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn opt_convex_dfp_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn opt_convex_dfp_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn opt_convex_dfp_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn opt_convex_dfp_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn opt_convex_dfp_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn opt_convex_dfp_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn opt_convex_dfp_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct OptconvexdfpFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_dfp_frame_make(size : Int) -> OptconvexdfpFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_dfp_frame_len(s : OptconvexdfpFrame) -> Int { s.size }

pub fn opt_convex_dfp_frame_get(s : OptconvexdfpFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_dfp_frame_set(s : OptconvexdfpFrame, i : Int, v : Double) -> OptconvexdfpFrame {
  let result = opt_convex_dfp_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_convex_dfp_frame_sum(s : OptconvexdfpFrame) -> Double { @_common.sum(s.data) }

pub fn opt_convex_dfp_frame_mean(s : OptconvexdfpFrame) -> Double { @_common.mean(s.data) }

pub fn opt_convex_dfp_frame_scale(s : OptconvexdfpFrame, f : Double) -> OptconvexdfpFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_convex_dfp_frame_add(a : OptconvexdfpFrame, b : OptconvexdfpFrame) -> OptconvexdfpFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_convex_dfp_frame_copy(s : OptconvexdfpFrame) -> OptconvexdfpFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_convex_dfp_frame_fill(s : OptconvexdfpFrame, v : Double) -> OptconvexdfpFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_convex_dfp_frame_min(s : OptconvexdfpFrame) -> Double { @_common.min(s.data) }

pub fn opt_convex_dfp_frame_max(s : OptconvexdfpFrame) -> Double { @_common.max(s.data) }

pub fn opt_convex_dfp_frame_to_string(s : OptconvexdfpFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexdfpTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_dfp_table_make(size : Int) -> OptconvexdfpTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_dfp_table_len(s : OptconvexdfpTable) -> Int { s.size }

pub fn opt_convex_dfp_table_get(s : OptconvexdfpTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_dfp_table_set(s : OptconvexdfpTable, i : Int, v : Double) -> OptconvexdfpTable {
  let result = opt_convex_dfp_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_convex_dfp_table_sum(s : OptconvexdfpTable) -> Double { @_common.sum(s.data) }

pub fn opt_convex_dfp_table_mean(s : OptconvexdfpTable) -> Double { @_common.mean(s.data) }

pub fn opt_convex_dfp_table_scale(s : OptconvexdfpTable, f : Double) -> OptconvexdfpTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_convex_dfp_table_add(a : OptconvexdfpTable, b : OptconvexdfpTable) -> OptconvexdfpTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_convex_dfp_table_copy(s : OptconvexdfpTable) -> OptconvexdfpTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_convex_dfp_table_fill(s : OptconvexdfpTable, v : Double) -> OptconvexdfpTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_convex_dfp_table_min(s : OptconvexdfpTable) -> Double { @_common.min(s.data) }

pub fn opt_convex_dfp_table_max(s : OptconvexdfpTable) -> Double { @_common.max(s.data) }

pub fn opt_convex_dfp_table_to_string(s : OptconvexdfpTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexdfpGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_dfp_graphn_make(size : Int) -> OptconvexdfpGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_dfp_graphn_len(s : OptconvexdfpGraphN) -> Int { s.size }

pub fn opt_convex_dfp_graphn_get(s : OptconvexdfpGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_dfp_graphn_set(s : OptconvexdfpGraphN, i : Int, v : Double) -> OptconvexdfpGraphN {
  let result = opt_convex_dfp_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_convex_dfp_graphn_sum(s : OptconvexdfpGraphN) -> Double { @_common.sum(s.data) }

pub fn opt_convex_dfp_graphn_mean(s : OptconvexdfpGraphN) -> Double { @_common.mean(s.data) }

pub fn opt_convex_dfp_graphn_scale(s : OptconvexdfpGraphN, f : Double) -> OptconvexdfpGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_convex_dfp_graphn_add(a : OptconvexdfpGraphN, b : OptconvexdfpGraphN) -> OptconvexdfpGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_convex_dfp_graphn_copy(s : OptconvexdfpGraphN) -> OptconvexdfpGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_convex_dfp_graphn_fill(s : OptconvexdfpGraphN, v : Double) -> OptconvexdfpGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_convex_dfp_graphn_min(s : OptconvexdfpGraphN) -> Double { @_common.min(s.data) }

pub fn opt_convex_dfp_graphn_max(s : OptconvexdfpGraphN) -> Double { @_common.max(s.data) }

pub fn opt_convex_dfp_graphn_to_string(s : OptconvexdfpGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexdfpNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_dfp_node_make(size : Int) -> OptconvexdfpNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_dfp_node_len(s : OptconvexdfpNode) -> Int { s.size }

pub fn opt_convex_dfp_node_get(s : OptconvexdfpNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_dfp_node_set(s : OptconvexdfpNode, i : Int, v : Double) -> OptconvexdfpNode {
  let result = opt_convex_dfp_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_convex_dfp_node_sum(s : OptconvexdfpNode) -> Double { @_common.sum(s.data) }

pub fn opt_convex_dfp_node_mean(s : OptconvexdfpNode) -> Double { @_common.mean(s.data) }

pub fn opt_convex_dfp_node_scale(s : OptconvexdfpNode, f : Double) -> OptconvexdfpNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_convex_dfp_node_add(a : OptconvexdfpNode, b : OptconvexdfpNode) -> OptconvexdfpNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_convex_dfp_node_copy(s : OptconvexdfpNode) -> OptconvexdfpNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_convex_dfp_node_fill(s : OptconvexdfpNode, v : Double) -> OptconvexdfpNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_convex_dfp_node_min(s : OptconvexdfpNode) -> Double { @_common.min(s.data) }

pub fn opt_convex_dfp_node_max(s : OptconvexdfpNode) -> Double { @_common.max(s.data) }

pub fn opt_convex_dfp_node_to_string(s : OptconvexdfpNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexdfpEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_dfp_edge_make(size : Int) -> OptconvexdfpEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_dfp_edge_len(s : OptconvexdfpEdge) -> Int { s.size }

pub fn opt_convex_dfp_edge_get(s : OptconvexdfpEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_dfp_edge_set(s : OptconvexdfpEdge, i : Int, v : Double) -> OptconvexdfpEdge {
  let result = opt_convex_dfp_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_convex_dfp_edge_sum(s : OptconvexdfpEdge) -> Double { @_common.sum(s.data) }

pub fn opt_convex_dfp_edge_mean(s : OptconvexdfpEdge) -> Double { @_common.mean(s.data) }

pub fn opt_convex_dfp_edge_scale(s : OptconvexdfpEdge, f : Double) -> OptconvexdfpEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_convex_dfp_edge_add(a : OptconvexdfpEdge, b : OptconvexdfpEdge) -> OptconvexdfpEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_convex_dfp_edge_copy(s : OptconvexdfpEdge) -> OptconvexdfpEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_convex_dfp_edge_fill(s : OptconvexdfpEdge, v : Double) -> OptconvexdfpEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_convex_dfp_edge_min(s : OptconvexdfpEdge) -> Double { @_common.min(s.data) }

pub fn opt_convex_dfp_edge_max(s : OptconvexdfpEdge) -> Double { @_common.max(s.data) }

pub fn opt_convex_dfp_edge_to_string(s : OptconvexdfpEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexdfpPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_dfp_path_make(size : Int) -> OptconvexdfpPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_dfp_path_len(s : OptconvexdfpPath) -> Int { s.size }

pub fn opt_convex_dfp_path_get(s : OptconvexdfpPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_dfp_path_set(s : OptconvexdfpPath, i : Int, v : Double) -> OptconvexdfpPath {
  let result = opt_convex_dfp_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_convex_dfp_path_sum(s : OptconvexdfpPath) -> Double { @_common.sum(s.data) }

pub fn opt_convex_dfp_path_mean(s : OptconvexdfpPath) -> Double { @_common.mean(s.data) }

pub fn opt_convex_dfp_path_scale(s : OptconvexdfpPath, f : Double) -> OptconvexdfpPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_convex_dfp_path_add(a : OptconvexdfpPath, b : OptconvexdfpPath) -> OptconvexdfpPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_convex_dfp_path_copy(s : OptconvexdfpPath) -> OptconvexdfpPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_convex_dfp_path_fill(s : OptconvexdfpPath, v : Double) -> OptconvexdfpPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_convex_dfp_path_min(s : OptconvexdfpPath) -> Double { @_common.min(s.data) }

pub fn opt_convex_dfp_path_max(s : OptconvexdfpPath) -> Double { @_common.max(s.data) }

pub fn opt_convex_dfp_path_to_string(s : OptconvexdfpPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexdfpCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_dfp_cluster_make(size : Int) -> OptconvexdfpCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_dfp_cluster_len(s : OptconvexdfpCluster) -> Int { s.size }

pub fn opt_convex_dfp_cluster_get(s : OptconvexdfpCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_dfp_cluster_set(s : OptconvexdfpCluster, i : Int, v : Double) -> OptconvexdfpCluster {
  let result = opt_convex_dfp_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_convex_dfp_cluster_sum(s : OptconvexdfpCluster) -> Double { @_common.sum(s.data) }

pub fn opt_convex_dfp_cluster_mean(s : OptconvexdfpCluster) -> Double { @_common.mean(s.data) }

pub fn opt_convex_dfp_cluster_scale(s : OptconvexdfpCluster, f : Double) -> OptconvexdfpCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_convex_dfp_cluster_add(a : OptconvexdfpCluster, b : OptconvexdfpCluster) -> OptconvexdfpCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_convex_dfp_cluster_copy(s : OptconvexdfpCluster) -> OptconvexdfpCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_convex_dfp_cluster_fill(s : OptconvexdfpCluster, v : Double) -> OptconvexdfpCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_convex_dfp_cluster_min(s : OptconvexdfpCluster) -> Double { @_common.min(s.data) }

pub fn opt_convex_dfp_cluster_max(s : OptconvexdfpCluster) -> Double { @_common.max(s.data) }

pub fn opt_convex_dfp_cluster_to_string(s : OptconvexdfpCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexdfpModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_dfp_model_make(size : Int) -> OptconvexdfpModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_dfp_model_len(s : OptconvexdfpModel) -> Int { s.size }

pub fn opt_convex_dfp_model_get(s : OptconvexdfpModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_dfp_model_set(s : OptconvexdfpModel, i : Int, v : Double) -> OptconvexdfpModel {
  let result = opt_convex_dfp_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_convex_dfp_model_sum(s : OptconvexdfpModel) -> Double { @_common.sum(s.data) }

pub fn opt_convex_dfp_model_mean(s : OptconvexdfpModel) -> Double { @_common.mean(s.data) }

pub fn opt_convex_dfp_model_scale(s : OptconvexdfpModel, f : Double) -> OptconvexdfpModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_convex_dfp_model_add(a : OptconvexdfpModel, b : OptconvexdfpModel) -> OptconvexdfpModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_convex_dfp_model_copy(s : OptconvexdfpModel) -> OptconvexdfpModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_convex_dfp_model_fill(s : OptconvexdfpModel, v : Double) -> OptconvexdfpModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_convex_dfp_model_min(s : OptconvexdfpModel) -> Double { @_common.min(s.data) }

pub fn opt_convex_dfp_model_max(s : OptconvexdfpModel) -> Double { @_common.max(s.data) }

pub fn opt_convex_dfp_model_to_string(s : OptconvexdfpModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexdfpLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_dfp_layer_make(size : Int) -> OptconvexdfpLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_dfp_layer_len(s : OptconvexdfpLayer) -> Int { s.size }

pub fn opt_convex_dfp_layer_get(s : OptconvexdfpLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_dfp_layer_set(s : OptconvexdfpLayer, i : Int, v : Double) -> OptconvexdfpLayer {
  let result = opt_convex_dfp_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_convex_dfp_layer_sum(s : OptconvexdfpLayer) -> Double { @_common.sum(s.data) }

pub fn opt_convex_dfp_layer_mean(s : OptconvexdfpLayer) -> Double { @_common.mean(s.data) }

pub fn opt_convex_dfp_layer_scale(s : OptconvexdfpLayer, f : Double) -> OptconvexdfpLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_convex_dfp_layer_add(a : OptconvexdfpLayer, b : OptconvexdfpLayer) -> OptconvexdfpLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_convex_dfp_layer_copy(s : OptconvexdfpLayer) -> OptconvexdfpLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_convex_dfp_layer_fill(s : OptconvexdfpLayer, v : Double) -> OptconvexdfpLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_convex_dfp_layer_min(s : OptconvexdfpLayer) -> Double { @_common.min(s.data) }

pub fn opt_convex_dfp_layer_max(s : OptconvexdfpLayer) -> Double { @_common.max(s.data) }

pub fn opt_convex_dfp_layer_to_string(s : OptconvexdfpLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexdfpBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_dfp_buffer_make(size : Int) -> OptconvexdfpBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_dfp_buffer_len(s : OptconvexdfpBuffer) -> Int { s.size }

pub fn opt_convex_dfp_buffer_get(s : OptconvexdfpBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_dfp_buffer_set(s : OptconvexdfpBuffer, i : Int, v : Double) -> OptconvexdfpBuffer {
  let result = opt_convex_dfp_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_convex_dfp_buffer_sum(s : OptconvexdfpBuffer) -> Double { @_common.sum(s.data) }

pub fn opt_convex_dfp_buffer_mean(s : OptconvexdfpBuffer) -> Double { @_common.mean(s.data) }

pub fn opt_convex_dfp_buffer_scale(s : OptconvexdfpBuffer, f : Double) -> OptconvexdfpBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_convex_dfp_buffer_add(a : OptconvexdfpBuffer, b : OptconvexdfpBuffer) -> OptconvexdfpBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_convex_dfp_buffer_copy(s : OptconvexdfpBuffer) -> OptconvexdfpBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_convex_dfp_buffer_fill(s : OptconvexdfpBuffer, v : Double) -> OptconvexdfpBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_convex_dfp_buffer_min(s : OptconvexdfpBuffer) -> Double { @_common.min(s.data) }

pub fn opt_convex_dfp_buffer_max(s : OptconvexdfpBuffer) -> Double { @_common.max(s.data) }

pub fn opt_convex_dfp_buffer_to_string(s : OptconvexdfpBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexdfpCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_dfp_cursor_make(size : Int) -> OptconvexdfpCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_dfp_cursor_len(s : OptconvexdfpCursor) -> Int { s.size }

pub fn opt_convex_dfp_cursor_get(s : OptconvexdfpCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_dfp_cursor_set(s : OptconvexdfpCursor, i : Int, v : Double) -> OptconvexdfpCursor {
  let result = opt_convex_dfp_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_convex_dfp_cursor_sum(s : OptconvexdfpCursor) -> Double { @_common.sum(s.data) }

pub fn opt_convex_dfp_cursor_mean(s : OptconvexdfpCursor) -> Double { @_common.mean(s.data) }

pub fn opt_convex_dfp_cursor_scale(s : OptconvexdfpCursor, f : Double) -> OptconvexdfpCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_convex_dfp_cursor_add(a : OptconvexdfpCursor, b : OptconvexdfpCursor) -> OptconvexdfpCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_convex_dfp_cursor_copy(s : OptconvexdfpCursor) -> OptconvexdfpCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_convex_dfp_cursor_fill(s : OptconvexdfpCursor, v : Double) -> OptconvexdfpCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_convex_dfp_cursor_min(s : OptconvexdfpCursor) -> Double { @_common.min(s.data) }

pub fn opt_convex_dfp_cursor_max(s : OptconvexdfpCursor) -> Double { @_common.max(s.data) }

pub fn opt_convex_dfp_cursor_to_string(s : OptconvexdfpCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexdfpView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_dfp_view_make(size : Int) -> OptconvexdfpView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_dfp_view_len(s : OptconvexdfpView) -> Int { s.size }

pub fn opt_convex_dfp_view_get(s : OptconvexdfpView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_dfp_view_set(s : OptconvexdfpView, i : Int, v : Double) -> OptconvexdfpView {
  let result = opt_convex_dfp_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_convex_dfp_view_sum(s : OptconvexdfpView) -> Double { @_common.sum(s.data) }

pub fn opt_convex_dfp_view_mean(s : OptconvexdfpView) -> Double { @_common.mean(s.data) }

pub fn opt_convex_dfp_view_scale(s : OptconvexdfpView, f : Double) -> OptconvexdfpView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_convex_dfp_view_add(a : OptconvexdfpView, b : OptconvexdfpView) -> OptconvexdfpView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_convex_dfp_view_copy(s : OptconvexdfpView) -> OptconvexdfpView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_convex_dfp_view_fill(s : OptconvexdfpView, v : Double) -> OptconvexdfpView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_convex_dfp_view_min(s : OptconvexdfpView) -> Double { @_common.min(s.data) }

pub fn opt_convex_dfp_view_max(s : OptconvexdfpView) -> Double { @_common.max(s.data) }

pub fn opt_convex_dfp_view_to_string(s : OptconvexdfpView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexdfpRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_dfp_range_make(size : Int) -> OptconvexdfpRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_dfp_range_len(s : OptconvexdfpRange) -> Int { s.size }

pub fn opt_convex_dfp_range_get(s : OptconvexdfpRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_dfp_range_set(s : OptconvexdfpRange, i : Int, v : Double) -> OptconvexdfpRange {
  let result = opt_convex_dfp_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_convex_dfp_range_sum(s : OptconvexdfpRange) -> Double { @_common.sum(s.data) }

pub fn opt_convex_dfp_range_mean(s : OptconvexdfpRange) -> Double { @_common.mean(s.data) }

pub fn opt_convex_dfp_range_scale(s : OptconvexdfpRange, f : Double) -> OptconvexdfpRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_convex_dfp_range_add(a : OptconvexdfpRange, b : OptconvexdfpRange) -> OptconvexdfpRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_convex_dfp_range_copy(s : OptconvexdfpRange) -> OptconvexdfpRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_convex_dfp_range_fill(s : OptconvexdfpRange, v : Double) -> OptconvexdfpRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_convex_dfp_range_min(s : OptconvexdfpRange) -> Double { @_common.min(s.data) }

pub fn opt_convex_dfp_range_max(s : OptconvexdfpRange) -> Double { @_common.max(s.data) }

pub fn opt_convex_dfp_range_to_string(s : OptconvexdfpRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexdfpSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_dfp_slice_make(size : Int) -> OptconvexdfpSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_dfp_slice_len(s : OptconvexdfpSlice) -> Int { s.size }

pub fn opt_convex_dfp_slice_get(s : OptconvexdfpSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_dfp_slice_set(s : OptconvexdfpSlice, i : Int, v : Double) -> OptconvexdfpSlice {
  let result = opt_convex_dfp_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_convex_dfp_slice_sum(s : OptconvexdfpSlice) -> Double { @_common.sum(s.data) }

pub fn opt_convex_dfp_slice_mean(s : OptconvexdfpSlice) -> Double { @_common.mean(s.data) }

pub fn opt_convex_dfp_slice_scale(s : OptconvexdfpSlice, f : Double) -> OptconvexdfpSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_convex_dfp_slice_add(a : OptconvexdfpSlice, b : OptconvexdfpSlice) -> OptconvexdfpSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_convex_dfp_slice_copy(s : OptconvexdfpSlice) -> OptconvexdfpSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_convex_dfp_slice_fill(s : OptconvexdfpSlice, v : Double) -> OptconvexdfpSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_convex_dfp_slice_min(s : OptconvexdfpSlice) -> Double { @_common.min(s.data) }

pub fn opt_convex_dfp_slice_max(s : OptconvexdfpSlice) -> Double { @_common.max(s.data) }

pub fn opt_convex_dfp_slice_to_string(s : OptconvexdfpSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

