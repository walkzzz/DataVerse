///===
/// extcore/stats_dist_wishart

pub(all) struct StatsdistwishartPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn stats_dist_wishart_make_point(x : Double, y : Double) -> StatsdistwishartPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn stats_dist_wishart_make_point3(x : Double, y : Double, z : Double) -> StatsdistwishartPoint {
  { x, y, z, label: 0 }
}

pub fn stats_dist_wishart_point_x(pt : StatsdistwishartPoint) -> Double { pt.x }

pub fn stats_dist_wishart_point_y(pt : StatsdistwishartPoint) -> Double { pt.y }

pub fn stats_dist_wishart_point_z(pt : StatsdistwishartPoint) -> Double { pt.z }

pub fn stats_dist_wishart_point_label(pt : StatsdistwishartPoint) -> Int { pt.label }

pub fn stats_dist_wishart_point_dist(a : StatsdistwishartPoint, b : StatsdistwishartPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn stats_dist_wishart_point_add(a : StatsdistwishartPoint, b : StatsdistwishartPoint) -> StatsdistwishartPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn stats_dist_wishart_point_sub(a : StatsdistwishartPoint, b : StatsdistwishartPoint) -> StatsdistwishartPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn stats_dist_wishart_point_scale(pt : StatsdistwishartPoint, s : Double) -> StatsdistwishartPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn stats_dist_wishart_point_dot(a : StatsdistwishartPoint, b : StatsdistwishartPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn stats_dist_wishart_point_cross(a : StatsdistwishartPoint, b : StatsdistwishartPoint) -> StatsdistwishartPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn stats_dist_wishart_point_norm(pt : StatsdistwishartPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn stats_dist_wishart_point_normalize(pt : StatsdistwishartPoint) -> StatsdistwishartPoint {
  let n = stats_dist_wishart_point_norm(pt)
  if n < 0.0000001 { pt } else { stats_dist_wishart_point_scale(pt, 1.0 / n) }
}

pub fn stats_dist_wishart_point_negate(pt : StatsdistwishartPoint) -> StatsdistwishartPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn stats_dist_wishart_point_mid(a : StatsdistwishartPoint, b : StatsdistwishartPoint) -> StatsdistwishartPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn stats_dist_wishart_point_lerp(a : StatsdistwishartPoint, b : StatsdistwishartPoint, t : Double) -> StatsdistwishartPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn stats_dist_wishart_point_to_string(pt : StatsdistwishartPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct StatsdistwishartSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn stats_dist_wishart_make_series(vals : Array[Double], name : String) -> StatsdistwishartSeries {
  { vals, name, meta: 0 }
}

pub fn stats_dist_wishart_series_len(s : StatsdistwishartSeries) -> Int { s.vals.length() }

pub fn stats_dist_wishart_series_sum(s : StatsdistwishartSeries) -> Double { @_common.sum(s.vals) }

pub fn stats_dist_wishart_series_mean(s : StatsdistwishartSeries) -> Double { @_common.mean(s.vals) }

pub fn stats_dist_wishart_series_min(s : StatsdistwishartSeries) -> Double { @_common.min(s.vals) }

pub fn stats_dist_wishart_series_max(s : StatsdistwishartSeries) -> Double { @_common.max(s.vals) }

pub fn stats_dist_wishart_series_range(s : StatsdistwishartSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn stats_dist_wishart_series_var(s : StatsdistwishartSeries) -> Double { @_common.variance(s.vals) }

pub fn stats_dist_wishart_series_std(s : StatsdistwishartSeries) -> Double { @_common.std(s.vals) }

pub fn stats_dist_wishart_series_median(s : StatsdistwishartSeries) -> Double { @_common.median(s.vals) }

pub fn stats_dist_wishart_series_scale(s : StatsdistwishartSeries, f : Double) -> StatsdistwishartSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn stats_dist_wishart_series_add(a : StatsdistwishartSeries, b : StatsdistwishartSeries) -> StatsdistwishartSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn stats_dist_wishart_series_sub(a : StatsdistwishartSeries, b : StatsdistwishartSeries) -> StatsdistwishartSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn stats_dist_wishart_series_normalize(s : StatsdistwishartSeries) -> StatsdistwishartSeries {
  let mn = stats_dist_wishart_series_min(s)
  let mx = stats_dist_wishart_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn stats_dist_wishart_series_cumsum(s : StatsdistwishartSeries) -> StatsdistwishartSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn stats_dist_wishart_series_to_string(s : StatsdistwishartSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct StatsdistwishartMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn stats_dist_wishart_make_matrix(rows : Int, cols : Int, val : Double) -> StatsdistwishartMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn stats_dist_wishart_matrix_identity(n : Int) -> StatsdistwishartMatrix {
  let m = stats_dist_wishart_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn stats_dist_wishart_matrix_get(m : StatsdistwishartMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn stats_dist_wishart_matrix_transpose(m : StatsdistwishartMatrix) -> StatsdistwishartMatrix {
  let result = stats_dist_wishart_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn stats_dist_wishart_matrix_add(a : StatsdistwishartMatrix, b : StatsdistwishartMatrix) -> StatsdistwishartMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = stats_dist_wishart_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn stats_dist_wishart_matrix_scale(m : StatsdistwishartMatrix, s : Double) -> StatsdistwishartMatrix {
  let result = stats_dist_wishart_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn stats_dist_wishart_matrix_multiply(a : StatsdistwishartMatrix, b : StatsdistwishartMatrix) -> StatsdistwishartMatrix {
  if a.cols != b.rows { return stats_dist_wishart_make_matrix(a.rows, b.cols, 0.0) }
  let result = stats_dist_wishart_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn stats_dist_wishart_matrix_trace(m : StatsdistwishartMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn stats_dist_wishart_matrix_det(m : StatsdistwishartMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn stats_dist_wishart_matrix_norm(m : StatsdistwishartMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn stats_dist_wishart_matrix_to_string(m : StatsdistwishartMatrix) -> String {
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

pub(all) struct StatsdistwishartVector {
  comps : Array[Double]
  dim : Int
}

pub fn stats_dist_wishart_make_vector(comps : Array[Double]) -> StatsdistwishartVector {
  { comps, dim: comps.length() }
}

pub fn stats_dist_wishart_vector_zero(dim : Int) -> StatsdistwishartVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn stats_dist_wishart_vector_add(a : StatsdistwishartVector, b : StatsdistwishartVector) -> StatsdistwishartVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn stats_dist_wishart_vector_sub(a : StatsdistwishartVector, b : StatsdistwishartVector) -> StatsdistwishartVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn stats_dist_wishart_vector_scale(v : StatsdistwishartVector, s : Double) -> StatsdistwishartVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn stats_dist_wishart_vector_dot(a : StatsdistwishartVector, b : StatsdistwishartVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn stats_dist_wishart_vector_norm(v : StatsdistwishartVector) -> Double { @_common.sqrt(stats_dist_wishart_vector_dot(v, v)) }

pub fn stats_dist_wishart_vector_normalize(v : StatsdistwishartVector) -> StatsdistwishartVector {
  let n = stats_dist_wishart_vector_norm(v)
  if n < 0.0000001 { v } else { stats_dist_wishart_vector_scale(v, 1.0 / n) }
}

pub fn stats_dist_wishart_vector_dist(a : StatsdistwishartVector, b : StatsdistwishartVector) -> Double {
  stats_dist_wishart_vector_norm(stats_dist_wishart_vector_sub(a, b))
}

pub fn stats_dist_wishart_vector_to_string(v : StatsdistwishartVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn stats_dist_wishart_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn stats_dist_wishart_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn stats_dist_wishart_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn stats_dist_wishart_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn stats_dist_wishart_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn stats_dist_wishart_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn stats_dist_wishart_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn stats_dist_wishart_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn stats_dist_wishart_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn stats_dist_wishart_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn stats_dist_wishart_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn stats_dist_wishart_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn stats_dist_wishart_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn stats_dist_wishart_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn stats_dist_wishart_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn stats_dist_wishart_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn stats_dist_wishart_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn stats_dist_wishart_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn stats_dist_wishart_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn stats_dist_wishart_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn stats_dist_wishart_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn stats_dist_wishart_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn stats_dist_wishart_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn stats_dist_wishart_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn stats_dist_wishart_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn stats_dist_wishart_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn stats_dist_wishart_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn stats_dist_wishart_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn stats_dist_wishart_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct StatsdistwishartFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_wishart_frame_make(size : Int) -> StatsdistwishartFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_wishart_frame_len(s : StatsdistwishartFrame) -> Int { s.size }

pub fn stats_dist_wishart_frame_get(s : StatsdistwishartFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_wishart_frame_set(s : StatsdistwishartFrame, i : Int, v : Double) -> StatsdistwishartFrame {
  let result = stats_dist_wishart_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_wishart_frame_sum(s : StatsdistwishartFrame) -> Double { @_common.sum(s.data) }

pub fn stats_dist_wishart_frame_mean(s : StatsdistwishartFrame) -> Double { @_common.mean(s.data) }

pub fn stats_dist_wishart_frame_scale(s : StatsdistwishartFrame, f : Double) -> StatsdistwishartFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_wishart_frame_add(a : StatsdistwishartFrame, b : StatsdistwishartFrame) -> StatsdistwishartFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_wishart_frame_copy(s : StatsdistwishartFrame) -> StatsdistwishartFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_wishart_frame_fill(s : StatsdistwishartFrame, v : Double) -> StatsdistwishartFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_wishart_frame_min(s : StatsdistwishartFrame) -> Double { @_common.min(s.data) }

pub fn stats_dist_wishart_frame_max(s : StatsdistwishartFrame) -> Double { @_common.max(s.data) }

pub fn stats_dist_wishart_frame_to_string(s : StatsdistwishartFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistwishartTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_wishart_table_make(size : Int) -> StatsdistwishartTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_wishart_table_len(s : StatsdistwishartTable) -> Int { s.size }

pub fn stats_dist_wishart_table_get(s : StatsdistwishartTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_wishart_table_set(s : StatsdistwishartTable, i : Int, v : Double) -> StatsdistwishartTable {
  let result = stats_dist_wishart_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_wishart_table_sum(s : StatsdistwishartTable) -> Double { @_common.sum(s.data) }

pub fn stats_dist_wishart_table_mean(s : StatsdistwishartTable) -> Double { @_common.mean(s.data) }

pub fn stats_dist_wishart_table_scale(s : StatsdistwishartTable, f : Double) -> StatsdistwishartTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_wishart_table_add(a : StatsdistwishartTable, b : StatsdistwishartTable) -> StatsdistwishartTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_wishart_table_copy(s : StatsdistwishartTable) -> StatsdistwishartTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_wishart_table_fill(s : StatsdistwishartTable, v : Double) -> StatsdistwishartTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_wishart_table_min(s : StatsdistwishartTable) -> Double { @_common.min(s.data) }

pub fn stats_dist_wishart_table_max(s : StatsdistwishartTable) -> Double { @_common.max(s.data) }

pub fn stats_dist_wishart_table_to_string(s : StatsdistwishartTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistwishartGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_wishart_graphn_make(size : Int) -> StatsdistwishartGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_wishart_graphn_len(s : StatsdistwishartGraphN) -> Int { s.size }

pub fn stats_dist_wishart_graphn_get(s : StatsdistwishartGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_wishart_graphn_set(s : StatsdistwishartGraphN, i : Int, v : Double) -> StatsdistwishartGraphN {
  let result = stats_dist_wishart_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_wishart_graphn_sum(s : StatsdistwishartGraphN) -> Double { @_common.sum(s.data) }

pub fn stats_dist_wishart_graphn_mean(s : StatsdistwishartGraphN) -> Double { @_common.mean(s.data) }

pub fn stats_dist_wishart_graphn_scale(s : StatsdistwishartGraphN, f : Double) -> StatsdistwishartGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_wishart_graphn_add(a : StatsdistwishartGraphN, b : StatsdistwishartGraphN) -> StatsdistwishartGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_wishart_graphn_copy(s : StatsdistwishartGraphN) -> StatsdistwishartGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_wishart_graphn_fill(s : StatsdistwishartGraphN, v : Double) -> StatsdistwishartGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_wishart_graphn_min(s : StatsdistwishartGraphN) -> Double { @_common.min(s.data) }

pub fn stats_dist_wishart_graphn_max(s : StatsdistwishartGraphN) -> Double { @_common.max(s.data) }

pub fn stats_dist_wishart_graphn_to_string(s : StatsdistwishartGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistwishartNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_wishart_node_make(size : Int) -> StatsdistwishartNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_wishart_node_len(s : StatsdistwishartNode) -> Int { s.size }

pub fn stats_dist_wishart_node_get(s : StatsdistwishartNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_wishart_node_set(s : StatsdistwishartNode, i : Int, v : Double) -> StatsdistwishartNode {
  let result = stats_dist_wishart_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_wishart_node_sum(s : StatsdistwishartNode) -> Double { @_common.sum(s.data) }

pub fn stats_dist_wishart_node_mean(s : StatsdistwishartNode) -> Double { @_common.mean(s.data) }

pub fn stats_dist_wishart_node_scale(s : StatsdistwishartNode, f : Double) -> StatsdistwishartNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_wishart_node_add(a : StatsdistwishartNode, b : StatsdistwishartNode) -> StatsdistwishartNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_wishart_node_copy(s : StatsdistwishartNode) -> StatsdistwishartNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_wishart_node_fill(s : StatsdistwishartNode, v : Double) -> StatsdistwishartNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_wishart_node_min(s : StatsdistwishartNode) -> Double { @_common.min(s.data) }

pub fn stats_dist_wishart_node_max(s : StatsdistwishartNode) -> Double { @_common.max(s.data) }

pub fn stats_dist_wishart_node_to_string(s : StatsdistwishartNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistwishartEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_wishart_edge_make(size : Int) -> StatsdistwishartEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_wishart_edge_len(s : StatsdistwishartEdge) -> Int { s.size }

pub fn stats_dist_wishart_edge_get(s : StatsdistwishartEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_wishart_edge_set(s : StatsdistwishartEdge, i : Int, v : Double) -> StatsdistwishartEdge {
  let result = stats_dist_wishart_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_wishart_edge_sum(s : StatsdistwishartEdge) -> Double { @_common.sum(s.data) }

pub fn stats_dist_wishart_edge_mean(s : StatsdistwishartEdge) -> Double { @_common.mean(s.data) }

pub fn stats_dist_wishart_edge_scale(s : StatsdistwishartEdge, f : Double) -> StatsdistwishartEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_wishart_edge_add(a : StatsdistwishartEdge, b : StatsdistwishartEdge) -> StatsdistwishartEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_wishart_edge_copy(s : StatsdistwishartEdge) -> StatsdistwishartEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_wishart_edge_fill(s : StatsdistwishartEdge, v : Double) -> StatsdistwishartEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_wishart_edge_min(s : StatsdistwishartEdge) -> Double { @_common.min(s.data) }

pub fn stats_dist_wishart_edge_max(s : StatsdistwishartEdge) -> Double { @_common.max(s.data) }

pub fn stats_dist_wishart_edge_to_string(s : StatsdistwishartEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistwishartPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_wishart_path_make(size : Int) -> StatsdistwishartPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_wishart_path_len(s : StatsdistwishartPath) -> Int { s.size }

pub fn stats_dist_wishart_path_get(s : StatsdistwishartPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_wishart_path_set(s : StatsdistwishartPath, i : Int, v : Double) -> StatsdistwishartPath {
  let result = stats_dist_wishart_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_wishart_path_sum(s : StatsdistwishartPath) -> Double { @_common.sum(s.data) }

pub fn stats_dist_wishart_path_mean(s : StatsdistwishartPath) -> Double { @_common.mean(s.data) }

pub fn stats_dist_wishart_path_scale(s : StatsdistwishartPath, f : Double) -> StatsdistwishartPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_wishart_path_add(a : StatsdistwishartPath, b : StatsdistwishartPath) -> StatsdistwishartPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_wishart_path_copy(s : StatsdistwishartPath) -> StatsdistwishartPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_wishart_path_fill(s : StatsdistwishartPath, v : Double) -> StatsdistwishartPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_wishart_path_min(s : StatsdistwishartPath) -> Double { @_common.min(s.data) }

pub fn stats_dist_wishart_path_max(s : StatsdistwishartPath) -> Double { @_common.max(s.data) }

pub fn stats_dist_wishart_path_to_string(s : StatsdistwishartPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistwishartCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_wishart_cluster_make(size : Int) -> StatsdistwishartCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_wishart_cluster_len(s : StatsdistwishartCluster) -> Int { s.size }

pub fn stats_dist_wishart_cluster_get(s : StatsdistwishartCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_wishart_cluster_set(s : StatsdistwishartCluster, i : Int, v : Double) -> StatsdistwishartCluster {
  let result = stats_dist_wishart_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_wishart_cluster_sum(s : StatsdistwishartCluster) -> Double { @_common.sum(s.data) }

pub fn stats_dist_wishart_cluster_mean(s : StatsdistwishartCluster) -> Double { @_common.mean(s.data) }

pub fn stats_dist_wishart_cluster_scale(s : StatsdistwishartCluster, f : Double) -> StatsdistwishartCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_wishart_cluster_add(a : StatsdistwishartCluster, b : StatsdistwishartCluster) -> StatsdistwishartCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_wishart_cluster_copy(s : StatsdistwishartCluster) -> StatsdistwishartCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_wishart_cluster_fill(s : StatsdistwishartCluster, v : Double) -> StatsdistwishartCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_wishart_cluster_min(s : StatsdistwishartCluster) -> Double { @_common.min(s.data) }

pub fn stats_dist_wishart_cluster_max(s : StatsdistwishartCluster) -> Double { @_common.max(s.data) }

pub fn stats_dist_wishart_cluster_to_string(s : StatsdistwishartCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistwishartModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_wishart_model_make(size : Int) -> StatsdistwishartModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_wishart_model_len(s : StatsdistwishartModel) -> Int { s.size }

pub fn stats_dist_wishart_model_get(s : StatsdistwishartModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_wishart_model_set(s : StatsdistwishartModel, i : Int, v : Double) -> StatsdistwishartModel {
  let result = stats_dist_wishart_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_wishart_model_sum(s : StatsdistwishartModel) -> Double { @_common.sum(s.data) }

pub fn stats_dist_wishart_model_mean(s : StatsdistwishartModel) -> Double { @_common.mean(s.data) }

pub fn stats_dist_wishart_model_scale(s : StatsdistwishartModel, f : Double) -> StatsdistwishartModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_wishart_model_add(a : StatsdistwishartModel, b : StatsdistwishartModel) -> StatsdistwishartModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_wishart_model_copy(s : StatsdistwishartModel) -> StatsdistwishartModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_wishart_model_fill(s : StatsdistwishartModel, v : Double) -> StatsdistwishartModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_wishart_model_min(s : StatsdistwishartModel) -> Double { @_common.min(s.data) }

pub fn stats_dist_wishart_model_max(s : StatsdistwishartModel) -> Double { @_common.max(s.data) }

pub fn stats_dist_wishart_model_to_string(s : StatsdistwishartModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistwishartLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_wishart_layer_make(size : Int) -> StatsdistwishartLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_wishart_layer_len(s : StatsdistwishartLayer) -> Int { s.size }

pub fn stats_dist_wishart_layer_get(s : StatsdistwishartLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_wishart_layer_set(s : StatsdistwishartLayer, i : Int, v : Double) -> StatsdistwishartLayer {
  let result = stats_dist_wishart_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_wishart_layer_sum(s : StatsdistwishartLayer) -> Double { @_common.sum(s.data) }

pub fn stats_dist_wishart_layer_mean(s : StatsdistwishartLayer) -> Double { @_common.mean(s.data) }

pub fn stats_dist_wishart_layer_scale(s : StatsdistwishartLayer, f : Double) -> StatsdistwishartLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_wishart_layer_add(a : StatsdistwishartLayer, b : StatsdistwishartLayer) -> StatsdistwishartLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_wishart_layer_copy(s : StatsdistwishartLayer) -> StatsdistwishartLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_wishart_layer_fill(s : StatsdistwishartLayer, v : Double) -> StatsdistwishartLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_wishart_layer_min(s : StatsdistwishartLayer) -> Double { @_common.min(s.data) }

pub fn stats_dist_wishart_layer_max(s : StatsdistwishartLayer) -> Double { @_common.max(s.data) }

pub fn stats_dist_wishart_layer_to_string(s : StatsdistwishartLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistwishartBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_wishart_buffer_make(size : Int) -> StatsdistwishartBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_wishart_buffer_len(s : StatsdistwishartBuffer) -> Int { s.size }

pub fn stats_dist_wishart_buffer_get(s : StatsdistwishartBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_wishart_buffer_set(s : StatsdistwishartBuffer, i : Int, v : Double) -> StatsdistwishartBuffer {
  let result = stats_dist_wishart_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_wishart_buffer_sum(s : StatsdistwishartBuffer) -> Double { @_common.sum(s.data) }

pub fn stats_dist_wishart_buffer_mean(s : StatsdistwishartBuffer) -> Double { @_common.mean(s.data) }

pub fn stats_dist_wishart_buffer_scale(s : StatsdistwishartBuffer, f : Double) -> StatsdistwishartBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_wishart_buffer_add(a : StatsdistwishartBuffer, b : StatsdistwishartBuffer) -> StatsdistwishartBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_wishart_buffer_copy(s : StatsdistwishartBuffer) -> StatsdistwishartBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_wishart_buffer_fill(s : StatsdistwishartBuffer, v : Double) -> StatsdistwishartBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_wishart_buffer_min(s : StatsdistwishartBuffer) -> Double { @_common.min(s.data) }

pub fn stats_dist_wishart_buffer_max(s : StatsdistwishartBuffer) -> Double { @_common.max(s.data) }

pub fn stats_dist_wishart_buffer_to_string(s : StatsdistwishartBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistwishartCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_wishart_cursor_make(size : Int) -> StatsdistwishartCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_wishart_cursor_len(s : StatsdistwishartCursor) -> Int { s.size }

pub fn stats_dist_wishart_cursor_get(s : StatsdistwishartCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_wishart_cursor_set(s : StatsdistwishartCursor, i : Int, v : Double) -> StatsdistwishartCursor {
  let result = stats_dist_wishart_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_wishart_cursor_sum(s : StatsdistwishartCursor) -> Double { @_common.sum(s.data) }

pub fn stats_dist_wishart_cursor_mean(s : StatsdistwishartCursor) -> Double { @_common.mean(s.data) }

pub fn stats_dist_wishart_cursor_scale(s : StatsdistwishartCursor, f : Double) -> StatsdistwishartCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_wishart_cursor_add(a : StatsdistwishartCursor, b : StatsdistwishartCursor) -> StatsdistwishartCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_wishart_cursor_copy(s : StatsdistwishartCursor) -> StatsdistwishartCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_wishart_cursor_fill(s : StatsdistwishartCursor, v : Double) -> StatsdistwishartCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_wishart_cursor_min(s : StatsdistwishartCursor) -> Double { @_common.min(s.data) }

pub fn stats_dist_wishart_cursor_max(s : StatsdistwishartCursor) -> Double { @_common.max(s.data) }

pub fn stats_dist_wishart_cursor_to_string(s : StatsdistwishartCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistwishartView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_wishart_view_make(size : Int) -> StatsdistwishartView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_wishart_view_len(s : StatsdistwishartView) -> Int { s.size }

pub fn stats_dist_wishart_view_get(s : StatsdistwishartView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_wishart_view_set(s : StatsdistwishartView, i : Int, v : Double) -> StatsdistwishartView {
  let result = stats_dist_wishart_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_wishart_view_sum(s : StatsdistwishartView) -> Double { @_common.sum(s.data) }

pub fn stats_dist_wishart_view_mean(s : StatsdistwishartView) -> Double { @_common.mean(s.data) }

pub fn stats_dist_wishart_view_scale(s : StatsdistwishartView, f : Double) -> StatsdistwishartView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_wishart_view_add(a : StatsdistwishartView, b : StatsdistwishartView) -> StatsdistwishartView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_wishart_view_copy(s : StatsdistwishartView) -> StatsdistwishartView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_wishart_view_fill(s : StatsdistwishartView, v : Double) -> StatsdistwishartView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_wishart_view_min(s : StatsdistwishartView) -> Double { @_common.min(s.data) }

pub fn stats_dist_wishart_view_max(s : StatsdistwishartView) -> Double { @_common.max(s.data) }

pub fn stats_dist_wishart_view_to_string(s : StatsdistwishartView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistwishartRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_wishart_range_make(size : Int) -> StatsdistwishartRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_wishart_range_len(s : StatsdistwishartRange) -> Int { s.size }

pub fn stats_dist_wishart_range_get(s : StatsdistwishartRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_wishart_range_set(s : StatsdistwishartRange, i : Int, v : Double) -> StatsdistwishartRange {
  let result = stats_dist_wishart_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_wishart_range_sum(s : StatsdistwishartRange) -> Double { @_common.sum(s.data) }

pub fn stats_dist_wishart_range_mean(s : StatsdistwishartRange) -> Double { @_common.mean(s.data) }

pub fn stats_dist_wishart_range_scale(s : StatsdistwishartRange, f : Double) -> StatsdistwishartRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_wishart_range_add(a : StatsdistwishartRange, b : StatsdistwishartRange) -> StatsdistwishartRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_wishart_range_copy(s : StatsdistwishartRange) -> StatsdistwishartRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_wishart_range_fill(s : StatsdistwishartRange, v : Double) -> StatsdistwishartRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_wishart_range_min(s : StatsdistwishartRange) -> Double { @_common.min(s.data) }

pub fn stats_dist_wishart_range_max(s : StatsdistwishartRange) -> Double { @_common.max(s.data) }

pub fn stats_dist_wishart_range_to_string(s : StatsdistwishartRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistwishartSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_wishart_slice_make(size : Int) -> StatsdistwishartSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_wishart_slice_len(s : StatsdistwishartSlice) -> Int { s.size }

pub fn stats_dist_wishart_slice_get(s : StatsdistwishartSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_wishart_slice_set(s : StatsdistwishartSlice, i : Int, v : Double) -> StatsdistwishartSlice {
  let result = stats_dist_wishart_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_wishart_slice_sum(s : StatsdistwishartSlice) -> Double { @_common.sum(s.data) }

pub fn stats_dist_wishart_slice_mean(s : StatsdistwishartSlice) -> Double { @_common.mean(s.data) }

pub fn stats_dist_wishart_slice_scale(s : StatsdistwishartSlice, f : Double) -> StatsdistwishartSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_wishart_slice_add(a : StatsdistwishartSlice, b : StatsdistwishartSlice) -> StatsdistwishartSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_wishart_slice_copy(s : StatsdistwishartSlice) -> StatsdistwishartSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_wishart_slice_fill(s : StatsdistwishartSlice, v : Double) -> StatsdistwishartSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_wishart_slice_min(s : StatsdistwishartSlice) -> Double { @_common.min(s.data) }

pub fn stats_dist_wishart_slice_max(s : StatsdistwishartSlice) -> Double { @_common.max(s.data) }

pub fn stats_dist_wishart_slice_to_string(s : StatsdistwishartSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

