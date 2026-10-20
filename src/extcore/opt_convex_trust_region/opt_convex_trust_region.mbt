///===
/// extcore/opt_convex_trust_region

pub(all) struct OptconvextrustregionPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn opt_convex_trust_region_make_point(x : Double, y : Double) -> OptconvextrustregionPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn opt_convex_trust_region_make_point3(x : Double, y : Double, z : Double) -> OptconvextrustregionPoint {
  { x, y, z, label: 0 }
}

pub fn opt_convex_trust_region_point_x(pt : OptconvextrustregionPoint) -> Double { pt.x }

pub fn opt_convex_trust_region_point_y(pt : OptconvextrustregionPoint) -> Double { pt.y }

pub fn opt_convex_trust_region_point_z(pt : OptconvextrustregionPoint) -> Double { pt.z }

pub fn opt_convex_trust_region_point_label(pt : OptconvextrustregionPoint) -> Int { pt.label }

pub fn opt_convex_trust_region_point_dist(a : OptconvextrustregionPoint, b : OptconvextrustregionPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn opt_convex_trust_region_point_add(a : OptconvextrustregionPoint, b : OptconvextrustregionPoint) -> OptconvextrustregionPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn opt_convex_trust_region_point_sub(a : OptconvextrustregionPoint, b : OptconvextrustregionPoint) -> OptconvextrustregionPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn opt_convex_trust_region_point_scale(pt : OptconvextrustregionPoint, s : Double) -> OptconvextrustregionPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn opt_convex_trust_region_point_dot(a : OptconvextrustregionPoint, b : OptconvextrustregionPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn opt_convex_trust_region_point_cross(a : OptconvextrustregionPoint, b : OptconvextrustregionPoint) -> OptconvextrustregionPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn opt_convex_trust_region_point_norm(pt : OptconvextrustregionPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn opt_convex_trust_region_point_normalize(pt : OptconvextrustregionPoint) -> OptconvextrustregionPoint {
  let n = opt_convex_trust_region_point_norm(pt)
  if n < 0.0000001 { pt } else { opt_convex_trust_region_point_scale(pt, 1.0 / n) }
}

pub fn opt_convex_trust_region_point_negate(pt : OptconvextrustregionPoint) -> OptconvextrustregionPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn opt_convex_trust_region_point_mid(a : OptconvextrustregionPoint, b : OptconvextrustregionPoint) -> OptconvextrustregionPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn opt_convex_trust_region_point_lerp(a : OptconvextrustregionPoint, b : OptconvextrustregionPoint, t : Double) -> OptconvextrustregionPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn opt_convex_trust_region_point_to_string(pt : OptconvextrustregionPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct OptconvextrustregionSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn opt_convex_trust_region_make_series(vals : Array[Double], name : String) -> OptconvextrustregionSeries {
  { vals, name, meta: 0 }
}

pub fn opt_convex_trust_region_series_len(s : OptconvextrustregionSeries) -> Int { s.vals.length() }

pub fn opt_convex_trust_region_series_sum(s : OptconvextrustregionSeries) -> Double { @_common.sum(s.vals) }

pub fn opt_convex_trust_region_series_mean(s : OptconvextrustregionSeries) -> Double { @_common.mean(s.vals) }

pub fn opt_convex_trust_region_series_min(s : OptconvextrustregionSeries) -> Double { @_common.min(s.vals) }

pub fn opt_convex_trust_region_series_max(s : OptconvextrustregionSeries) -> Double { @_common.max(s.vals) }

pub fn opt_convex_trust_region_series_range(s : OptconvextrustregionSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn opt_convex_trust_region_series_var(s : OptconvextrustregionSeries) -> Double { @_common.variance(s.vals) }

pub fn opt_convex_trust_region_series_std(s : OptconvextrustregionSeries) -> Double { @_common.std(s.vals) }

pub fn opt_convex_trust_region_series_median(s : OptconvextrustregionSeries) -> Double { @_common.median(s.vals) }

pub fn opt_convex_trust_region_series_scale(s : OptconvextrustregionSeries, f : Double) -> OptconvextrustregionSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn opt_convex_trust_region_series_add(a : OptconvextrustregionSeries, b : OptconvextrustregionSeries) -> OptconvextrustregionSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn opt_convex_trust_region_series_sub(a : OptconvextrustregionSeries, b : OptconvextrustregionSeries) -> OptconvextrustregionSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn opt_convex_trust_region_series_normalize(s : OptconvextrustregionSeries) -> OptconvextrustregionSeries {
  let mn = opt_convex_trust_region_series_min(s)
  let mx = opt_convex_trust_region_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn opt_convex_trust_region_series_cumsum(s : OptconvextrustregionSeries) -> OptconvextrustregionSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn opt_convex_trust_region_series_to_string(s : OptconvextrustregionSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct OptconvextrustregionMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn opt_convex_trust_region_make_matrix(rows : Int, cols : Int, val : Double) -> OptconvextrustregionMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn opt_convex_trust_region_matrix_identity(n : Int) -> OptconvextrustregionMatrix {
  let m = opt_convex_trust_region_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn opt_convex_trust_region_matrix_get(m : OptconvextrustregionMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn opt_convex_trust_region_matrix_transpose(m : OptconvextrustregionMatrix) -> OptconvextrustregionMatrix {
  let result = opt_convex_trust_region_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn opt_convex_trust_region_matrix_add(a : OptconvextrustregionMatrix, b : OptconvextrustregionMatrix) -> OptconvextrustregionMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = opt_convex_trust_region_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn opt_convex_trust_region_matrix_scale(m : OptconvextrustregionMatrix, s : Double) -> OptconvextrustregionMatrix {
  let result = opt_convex_trust_region_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn opt_convex_trust_region_matrix_multiply(a : OptconvextrustregionMatrix, b : OptconvextrustregionMatrix) -> OptconvextrustregionMatrix {
  if a.cols != b.rows { return opt_convex_trust_region_make_matrix(a.rows, b.cols, 0.0) }
  let result = opt_convex_trust_region_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn opt_convex_trust_region_matrix_trace(m : OptconvextrustregionMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn opt_convex_trust_region_matrix_det(m : OptconvextrustregionMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn opt_convex_trust_region_matrix_norm(m : OptconvextrustregionMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn opt_convex_trust_region_matrix_to_string(m : OptconvextrustregionMatrix) -> String {
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

pub(all) struct OptconvextrustregionVector {
  comps : Array[Double]
  dim : Int
}

pub fn opt_convex_trust_region_make_vector(comps : Array[Double]) -> OptconvextrustregionVector {
  { comps, dim: comps.length() }
}

pub fn opt_convex_trust_region_vector_zero(dim : Int) -> OptconvextrustregionVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn opt_convex_trust_region_vector_add(a : OptconvextrustregionVector, b : OptconvextrustregionVector) -> OptconvextrustregionVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn opt_convex_trust_region_vector_sub(a : OptconvextrustregionVector, b : OptconvextrustregionVector) -> OptconvextrustregionVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn opt_convex_trust_region_vector_scale(v : OptconvextrustregionVector, s : Double) -> OptconvextrustregionVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn opt_convex_trust_region_vector_dot(a : OptconvextrustregionVector, b : OptconvextrustregionVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn opt_convex_trust_region_vector_norm(v : OptconvextrustregionVector) -> Double { @_common.sqrt(opt_convex_trust_region_vector_dot(v, v)) }

pub fn opt_convex_trust_region_vector_normalize(v : OptconvextrustregionVector) -> OptconvextrustregionVector {
  let n = opt_convex_trust_region_vector_norm(v)
  if n < 0.0000001 { v } else { opt_convex_trust_region_vector_scale(v, 1.0 / n) }
}

pub fn opt_convex_trust_region_vector_dist(a : OptconvextrustregionVector, b : OptconvextrustregionVector) -> Double {
  opt_convex_trust_region_vector_norm(opt_convex_trust_region_vector_sub(a, b))
}

pub fn opt_convex_trust_region_vector_to_string(v : OptconvextrustregionVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn opt_convex_trust_region_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn opt_convex_trust_region_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn opt_convex_trust_region_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn opt_convex_trust_region_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn opt_convex_trust_region_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn opt_convex_trust_region_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn opt_convex_trust_region_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn opt_convex_trust_region_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn opt_convex_trust_region_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn opt_convex_trust_region_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn opt_convex_trust_region_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn opt_convex_trust_region_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn opt_convex_trust_region_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn opt_convex_trust_region_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn opt_convex_trust_region_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn opt_convex_trust_region_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn opt_convex_trust_region_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn opt_convex_trust_region_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn opt_convex_trust_region_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn opt_convex_trust_region_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn opt_convex_trust_region_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn opt_convex_trust_region_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn opt_convex_trust_region_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn opt_convex_trust_region_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn opt_convex_trust_region_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn opt_convex_trust_region_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn opt_convex_trust_region_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn opt_convex_trust_region_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn opt_convex_trust_region_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct OptconvextrustregionFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_trust_region_frame_make(size : Int) -> OptconvextrustregionFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_trust_region_frame_len(s : OptconvextrustregionFrame) -> Int { s.size }

pub fn opt_convex_trust_region_frame_get(s : OptconvextrustregionFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_trust_region_frame_set(s : OptconvextrustregionFrame, i : Int, v : Double) -> OptconvextrustregionFrame {
  let result = opt_convex_trust_region_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_convex_trust_region_frame_sum(s : OptconvextrustregionFrame) -> Double { @_common.sum(s.data) }

pub fn opt_convex_trust_region_frame_mean(s : OptconvextrustregionFrame) -> Double { @_common.mean(s.data) }

pub fn opt_convex_trust_region_frame_scale(s : OptconvextrustregionFrame, f : Double) -> OptconvextrustregionFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_convex_trust_region_frame_add(a : OptconvextrustregionFrame, b : OptconvextrustregionFrame) -> OptconvextrustregionFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_convex_trust_region_frame_copy(s : OptconvextrustregionFrame) -> OptconvextrustregionFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_convex_trust_region_frame_fill(s : OptconvextrustregionFrame, v : Double) -> OptconvextrustregionFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_convex_trust_region_frame_min(s : OptconvextrustregionFrame) -> Double { @_common.min(s.data) }

pub fn opt_convex_trust_region_frame_max(s : OptconvextrustregionFrame) -> Double { @_common.max(s.data) }

pub fn opt_convex_trust_region_frame_to_string(s : OptconvextrustregionFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvextrustregionTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_trust_region_table_make(size : Int) -> OptconvextrustregionTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_trust_region_table_len(s : OptconvextrustregionTable) -> Int { s.size }

pub fn opt_convex_trust_region_table_get(s : OptconvextrustregionTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_trust_region_table_set(s : OptconvextrustregionTable, i : Int, v : Double) -> OptconvextrustregionTable {
  let result = opt_convex_trust_region_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_convex_trust_region_table_sum(s : OptconvextrustregionTable) -> Double { @_common.sum(s.data) }

pub fn opt_convex_trust_region_table_mean(s : OptconvextrustregionTable) -> Double { @_common.mean(s.data) }

pub fn opt_convex_trust_region_table_scale(s : OptconvextrustregionTable, f : Double) -> OptconvextrustregionTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_convex_trust_region_table_add(a : OptconvextrustregionTable, b : OptconvextrustregionTable) -> OptconvextrustregionTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_convex_trust_region_table_copy(s : OptconvextrustregionTable) -> OptconvextrustregionTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_convex_trust_region_table_fill(s : OptconvextrustregionTable, v : Double) -> OptconvextrustregionTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_convex_trust_region_table_min(s : OptconvextrustregionTable) -> Double { @_common.min(s.data) }

pub fn opt_convex_trust_region_table_max(s : OptconvextrustregionTable) -> Double { @_common.max(s.data) }

pub fn opt_convex_trust_region_table_to_string(s : OptconvextrustregionTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvextrustregionGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_trust_region_graphn_make(size : Int) -> OptconvextrustregionGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_trust_region_graphn_len(s : OptconvextrustregionGraphN) -> Int { s.size }

pub fn opt_convex_trust_region_graphn_get(s : OptconvextrustregionGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_trust_region_graphn_set(s : OptconvextrustregionGraphN, i : Int, v : Double) -> OptconvextrustregionGraphN {
  let result = opt_convex_trust_region_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_convex_trust_region_graphn_sum(s : OptconvextrustregionGraphN) -> Double { @_common.sum(s.data) }

pub fn opt_convex_trust_region_graphn_mean(s : OptconvextrustregionGraphN) -> Double { @_common.mean(s.data) }

pub fn opt_convex_trust_region_graphn_scale(s : OptconvextrustregionGraphN, f : Double) -> OptconvextrustregionGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_convex_trust_region_graphn_add(a : OptconvextrustregionGraphN, b : OptconvextrustregionGraphN) -> OptconvextrustregionGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_convex_trust_region_graphn_copy(s : OptconvextrustregionGraphN) -> OptconvextrustregionGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_convex_trust_region_graphn_fill(s : OptconvextrustregionGraphN, v : Double) -> OptconvextrustregionGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_convex_trust_region_graphn_min(s : OptconvextrustregionGraphN) -> Double { @_common.min(s.data) }

pub fn opt_convex_trust_region_graphn_max(s : OptconvextrustregionGraphN) -> Double { @_common.max(s.data) }

pub fn opt_convex_trust_region_graphn_to_string(s : OptconvextrustregionGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvextrustregionNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_trust_region_node_make(size : Int) -> OptconvextrustregionNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_trust_region_node_len(s : OptconvextrustregionNode) -> Int { s.size }

pub fn opt_convex_trust_region_node_get(s : OptconvextrustregionNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_trust_region_node_set(s : OptconvextrustregionNode, i : Int, v : Double) -> OptconvextrustregionNode {
  let result = opt_convex_trust_region_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_convex_trust_region_node_sum(s : OptconvextrustregionNode) -> Double { @_common.sum(s.data) }

pub fn opt_convex_trust_region_node_mean(s : OptconvextrustregionNode) -> Double { @_common.mean(s.data) }

pub fn opt_convex_trust_region_node_scale(s : OptconvextrustregionNode, f : Double) -> OptconvextrustregionNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_convex_trust_region_node_add(a : OptconvextrustregionNode, b : OptconvextrustregionNode) -> OptconvextrustregionNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_convex_trust_region_node_copy(s : OptconvextrustregionNode) -> OptconvextrustregionNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_convex_trust_region_node_fill(s : OptconvextrustregionNode, v : Double) -> OptconvextrustregionNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_convex_trust_region_node_min(s : OptconvextrustregionNode) -> Double { @_common.min(s.data) }

pub fn opt_convex_trust_region_node_max(s : OptconvextrustregionNode) -> Double { @_common.max(s.data) }

pub fn opt_convex_trust_region_node_to_string(s : OptconvextrustregionNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvextrustregionEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_trust_region_edge_make(size : Int) -> OptconvextrustregionEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_trust_region_edge_len(s : OptconvextrustregionEdge) -> Int { s.size }

pub fn opt_convex_trust_region_edge_get(s : OptconvextrustregionEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_trust_region_edge_set(s : OptconvextrustregionEdge, i : Int, v : Double) -> OptconvextrustregionEdge {
  let result = opt_convex_trust_region_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_convex_trust_region_edge_sum(s : OptconvextrustregionEdge) -> Double { @_common.sum(s.data) }

pub fn opt_convex_trust_region_edge_mean(s : OptconvextrustregionEdge) -> Double { @_common.mean(s.data) }

pub fn opt_convex_trust_region_edge_scale(s : OptconvextrustregionEdge, f : Double) -> OptconvextrustregionEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_convex_trust_region_edge_add(a : OptconvextrustregionEdge, b : OptconvextrustregionEdge) -> OptconvextrustregionEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_convex_trust_region_edge_copy(s : OptconvextrustregionEdge) -> OptconvextrustregionEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_convex_trust_region_edge_fill(s : OptconvextrustregionEdge, v : Double) -> OptconvextrustregionEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_convex_trust_region_edge_min(s : OptconvextrustregionEdge) -> Double { @_common.min(s.data) }

pub fn opt_convex_trust_region_edge_max(s : OptconvextrustregionEdge) -> Double { @_common.max(s.data) }

pub fn opt_convex_trust_region_edge_to_string(s : OptconvextrustregionEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvextrustregionPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_trust_region_path_make(size : Int) -> OptconvextrustregionPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_trust_region_path_len(s : OptconvextrustregionPath) -> Int { s.size }

pub fn opt_convex_trust_region_path_get(s : OptconvextrustregionPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_trust_region_path_set(s : OptconvextrustregionPath, i : Int, v : Double) -> OptconvextrustregionPath {
  let result = opt_convex_trust_region_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_convex_trust_region_path_sum(s : OptconvextrustregionPath) -> Double { @_common.sum(s.data) }

pub fn opt_convex_trust_region_path_mean(s : OptconvextrustregionPath) -> Double { @_common.mean(s.data) }

pub fn opt_convex_trust_region_path_scale(s : OptconvextrustregionPath, f : Double) -> OptconvextrustregionPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_convex_trust_region_path_add(a : OptconvextrustregionPath, b : OptconvextrustregionPath) -> OptconvextrustregionPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_convex_trust_region_path_copy(s : OptconvextrustregionPath) -> OptconvextrustregionPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_convex_trust_region_path_fill(s : OptconvextrustregionPath, v : Double) -> OptconvextrustregionPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_convex_trust_region_path_min(s : OptconvextrustregionPath) -> Double { @_common.min(s.data) }

pub fn opt_convex_trust_region_path_max(s : OptconvextrustregionPath) -> Double { @_common.max(s.data) }

pub fn opt_convex_trust_region_path_to_string(s : OptconvextrustregionPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvextrustregionCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_trust_region_cluster_make(size : Int) -> OptconvextrustregionCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_trust_region_cluster_len(s : OptconvextrustregionCluster) -> Int { s.size }

pub fn opt_convex_trust_region_cluster_get(s : OptconvextrustregionCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_trust_region_cluster_set(s : OptconvextrustregionCluster, i : Int, v : Double) -> OptconvextrustregionCluster {
  let result = opt_convex_trust_region_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_convex_trust_region_cluster_sum(s : OptconvextrustregionCluster) -> Double { @_common.sum(s.data) }

pub fn opt_convex_trust_region_cluster_mean(s : OptconvextrustregionCluster) -> Double { @_common.mean(s.data) }

pub fn opt_convex_trust_region_cluster_scale(s : OptconvextrustregionCluster, f : Double) -> OptconvextrustregionCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_convex_trust_region_cluster_add(a : OptconvextrustregionCluster, b : OptconvextrustregionCluster) -> OptconvextrustregionCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_convex_trust_region_cluster_copy(s : OptconvextrustregionCluster) -> OptconvextrustregionCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_convex_trust_region_cluster_fill(s : OptconvextrustregionCluster, v : Double) -> OptconvextrustregionCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_convex_trust_region_cluster_min(s : OptconvextrustregionCluster) -> Double { @_common.min(s.data) }

pub fn opt_convex_trust_region_cluster_max(s : OptconvextrustregionCluster) -> Double { @_common.max(s.data) }

pub fn opt_convex_trust_region_cluster_to_string(s : OptconvextrustregionCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvextrustregionModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_trust_region_model_make(size : Int) -> OptconvextrustregionModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_trust_region_model_len(s : OptconvextrustregionModel) -> Int { s.size }

pub fn opt_convex_trust_region_model_get(s : OptconvextrustregionModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_trust_region_model_set(s : OptconvextrustregionModel, i : Int, v : Double) -> OptconvextrustregionModel {
  let result = opt_convex_trust_region_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_convex_trust_region_model_sum(s : OptconvextrustregionModel) -> Double { @_common.sum(s.data) }

pub fn opt_convex_trust_region_model_mean(s : OptconvextrustregionModel) -> Double { @_common.mean(s.data) }

pub fn opt_convex_trust_region_model_scale(s : OptconvextrustregionModel, f : Double) -> OptconvextrustregionModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_convex_trust_region_model_add(a : OptconvextrustregionModel, b : OptconvextrustregionModel) -> OptconvextrustregionModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_convex_trust_region_model_copy(s : OptconvextrustregionModel) -> OptconvextrustregionModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_convex_trust_region_model_fill(s : OptconvextrustregionModel, v : Double) -> OptconvextrustregionModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_convex_trust_region_model_min(s : OptconvextrustregionModel) -> Double { @_common.min(s.data) }

pub fn opt_convex_trust_region_model_max(s : OptconvextrustregionModel) -> Double { @_common.max(s.data) }

pub fn opt_convex_trust_region_model_to_string(s : OptconvextrustregionModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvextrustregionLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_trust_region_layer_make(size : Int) -> OptconvextrustregionLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_trust_region_layer_len(s : OptconvextrustregionLayer) -> Int { s.size }

pub fn opt_convex_trust_region_layer_get(s : OptconvextrustregionLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_trust_region_layer_set(s : OptconvextrustregionLayer, i : Int, v : Double) -> OptconvextrustregionLayer {
  let result = opt_convex_trust_region_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_convex_trust_region_layer_sum(s : OptconvextrustregionLayer) -> Double { @_common.sum(s.data) }

pub fn opt_convex_trust_region_layer_mean(s : OptconvextrustregionLayer) -> Double { @_common.mean(s.data) }

pub fn opt_convex_trust_region_layer_scale(s : OptconvextrustregionLayer, f : Double) -> OptconvextrustregionLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_convex_trust_region_layer_add(a : OptconvextrustregionLayer, b : OptconvextrustregionLayer) -> OptconvextrustregionLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_convex_trust_region_layer_copy(s : OptconvextrustregionLayer) -> OptconvextrustregionLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_convex_trust_region_layer_fill(s : OptconvextrustregionLayer, v : Double) -> OptconvextrustregionLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_convex_trust_region_layer_min(s : OptconvextrustregionLayer) -> Double { @_common.min(s.data) }

pub fn opt_convex_trust_region_layer_max(s : OptconvextrustregionLayer) -> Double { @_common.max(s.data) }

pub fn opt_convex_trust_region_layer_to_string(s : OptconvextrustregionLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvextrustregionBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_trust_region_buffer_make(size : Int) -> OptconvextrustregionBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_trust_region_buffer_len(s : OptconvextrustregionBuffer) -> Int { s.size }

pub fn opt_convex_trust_region_buffer_get(s : OptconvextrustregionBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_trust_region_buffer_set(s : OptconvextrustregionBuffer, i : Int, v : Double) -> OptconvextrustregionBuffer {
  let result = opt_convex_trust_region_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_convex_trust_region_buffer_sum(s : OptconvextrustregionBuffer) -> Double { @_common.sum(s.data) }

pub fn opt_convex_trust_region_buffer_mean(s : OptconvextrustregionBuffer) -> Double { @_common.mean(s.data) }

pub fn opt_convex_trust_region_buffer_scale(s : OptconvextrustregionBuffer, f : Double) -> OptconvextrustregionBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_convex_trust_region_buffer_add(a : OptconvextrustregionBuffer, b : OptconvextrustregionBuffer) -> OptconvextrustregionBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_convex_trust_region_buffer_copy(s : OptconvextrustregionBuffer) -> OptconvextrustregionBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_convex_trust_region_buffer_fill(s : OptconvextrustregionBuffer, v : Double) -> OptconvextrustregionBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_convex_trust_region_buffer_min(s : OptconvextrustregionBuffer) -> Double { @_common.min(s.data) }

pub fn opt_convex_trust_region_buffer_max(s : OptconvextrustregionBuffer) -> Double { @_common.max(s.data) }

pub fn opt_convex_trust_region_buffer_to_string(s : OptconvextrustregionBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvextrustregionCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_trust_region_cursor_make(size : Int) -> OptconvextrustregionCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_trust_region_cursor_len(s : OptconvextrustregionCursor) -> Int { s.size }

pub fn opt_convex_trust_region_cursor_get(s : OptconvextrustregionCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_trust_region_cursor_set(s : OptconvextrustregionCursor, i : Int, v : Double) -> OptconvextrustregionCursor {
  let result = opt_convex_trust_region_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_convex_trust_region_cursor_sum(s : OptconvextrustregionCursor) -> Double { @_common.sum(s.data) }

pub fn opt_convex_trust_region_cursor_mean(s : OptconvextrustregionCursor) -> Double { @_common.mean(s.data) }

pub fn opt_convex_trust_region_cursor_scale(s : OptconvextrustregionCursor, f : Double) -> OptconvextrustregionCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_convex_trust_region_cursor_add(a : OptconvextrustregionCursor, b : OptconvextrustregionCursor) -> OptconvextrustregionCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_convex_trust_region_cursor_copy(s : OptconvextrustregionCursor) -> OptconvextrustregionCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_convex_trust_region_cursor_fill(s : OptconvextrustregionCursor, v : Double) -> OptconvextrustregionCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_convex_trust_region_cursor_min(s : OptconvextrustregionCursor) -> Double { @_common.min(s.data) }

pub fn opt_convex_trust_region_cursor_max(s : OptconvextrustregionCursor) -> Double { @_common.max(s.data) }

pub fn opt_convex_trust_region_cursor_to_string(s : OptconvextrustregionCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvextrustregionView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_trust_region_view_make(size : Int) -> OptconvextrustregionView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_trust_region_view_len(s : OptconvextrustregionView) -> Int { s.size }

pub fn opt_convex_trust_region_view_get(s : OptconvextrustregionView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_trust_region_view_set(s : OptconvextrustregionView, i : Int, v : Double) -> OptconvextrustregionView {
  let result = opt_convex_trust_region_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_convex_trust_region_view_sum(s : OptconvextrustregionView) -> Double { @_common.sum(s.data) }

pub fn opt_convex_trust_region_view_mean(s : OptconvextrustregionView) -> Double { @_common.mean(s.data) }

pub fn opt_convex_trust_region_view_scale(s : OptconvextrustregionView, f : Double) -> OptconvextrustregionView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_convex_trust_region_view_add(a : OptconvextrustregionView, b : OptconvextrustregionView) -> OptconvextrustregionView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_convex_trust_region_view_copy(s : OptconvextrustregionView) -> OptconvextrustregionView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_convex_trust_region_view_fill(s : OptconvextrustregionView, v : Double) -> OptconvextrustregionView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_convex_trust_region_view_min(s : OptconvextrustregionView) -> Double { @_common.min(s.data) }

pub fn opt_convex_trust_region_view_max(s : OptconvextrustregionView) -> Double { @_common.max(s.data) }

pub fn opt_convex_trust_region_view_to_string(s : OptconvextrustregionView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvextrustregionRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_trust_region_range_make(size : Int) -> OptconvextrustregionRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_trust_region_range_len(s : OptconvextrustregionRange) -> Int { s.size }

pub fn opt_convex_trust_region_range_get(s : OptconvextrustregionRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_trust_region_range_set(s : OptconvextrustregionRange, i : Int, v : Double) -> OptconvextrustregionRange {
  let result = opt_convex_trust_region_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_convex_trust_region_range_sum(s : OptconvextrustregionRange) -> Double { @_common.sum(s.data) }

pub fn opt_convex_trust_region_range_mean(s : OptconvextrustregionRange) -> Double { @_common.mean(s.data) }

pub fn opt_convex_trust_region_range_scale(s : OptconvextrustregionRange, f : Double) -> OptconvextrustregionRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_convex_trust_region_range_add(a : OptconvextrustregionRange, b : OptconvextrustregionRange) -> OptconvextrustregionRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_convex_trust_region_range_copy(s : OptconvextrustregionRange) -> OptconvextrustregionRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_convex_trust_region_range_fill(s : OptconvextrustregionRange, v : Double) -> OptconvextrustregionRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_convex_trust_region_range_min(s : OptconvextrustregionRange) -> Double { @_common.min(s.data) }

pub fn opt_convex_trust_region_range_max(s : OptconvextrustregionRange) -> Double { @_common.max(s.data) }

pub fn opt_convex_trust_region_range_to_string(s : OptconvextrustregionRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvextrustregionSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_trust_region_slice_make(size : Int) -> OptconvextrustregionSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_trust_region_slice_len(s : OptconvextrustregionSlice) -> Int { s.size }

pub fn opt_convex_trust_region_slice_get(s : OptconvextrustregionSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_trust_region_slice_set(s : OptconvextrustregionSlice, i : Int, v : Double) -> OptconvextrustregionSlice {
  let result = opt_convex_trust_region_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_convex_trust_region_slice_sum(s : OptconvextrustregionSlice) -> Double { @_common.sum(s.data) }

pub fn opt_convex_trust_region_slice_mean(s : OptconvextrustregionSlice) -> Double { @_common.mean(s.data) }

pub fn opt_convex_trust_region_slice_scale(s : OptconvextrustregionSlice, f : Double) -> OptconvextrustregionSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_convex_trust_region_slice_add(a : OptconvextrustregionSlice, b : OptconvextrustregionSlice) -> OptconvextrustregionSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_convex_trust_region_slice_copy(s : OptconvextrustregionSlice) -> OptconvextrustregionSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_convex_trust_region_slice_fill(s : OptconvextrustregionSlice, v : Double) -> OptconvextrustregionSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_convex_trust_region_slice_min(s : OptconvextrustregionSlice) -> Double { @_common.min(s.data) }

pub fn opt_convex_trust_region_slice_max(s : OptconvextrustregionSlice) -> Double { @_common.max(s.data) }

pub fn opt_convex_trust_region_slice_to_string(s : OptconvextrustregionSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

