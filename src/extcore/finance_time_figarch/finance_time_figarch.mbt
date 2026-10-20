///===
/// extcore/finance_time_figarch

pub(all) struct FinancetimefigarchPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn finance_time_figarch_make_point(x : Double, y : Double) -> FinancetimefigarchPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn finance_time_figarch_make_point3(x : Double, y : Double, z : Double) -> FinancetimefigarchPoint {
  { x, y, z, label: 0 }
}

pub fn finance_time_figarch_point_x(pt : FinancetimefigarchPoint) -> Double { pt.x }

pub fn finance_time_figarch_point_y(pt : FinancetimefigarchPoint) -> Double { pt.y }

pub fn finance_time_figarch_point_z(pt : FinancetimefigarchPoint) -> Double { pt.z }

pub fn finance_time_figarch_point_label(pt : FinancetimefigarchPoint) -> Int { pt.label }

pub fn finance_time_figarch_point_dist(a : FinancetimefigarchPoint, b : FinancetimefigarchPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn finance_time_figarch_point_add(a : FinancetimefigarchPoint, b : FinancetimefigarchPoint) -> FinancetimefigarchPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn finance_time_figarch_point_sub(a : FinancetimefigarchPoint, b : FinancetimefigarchPoint) -> FinancetimefigarchPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn finance_time_figarch_point_scale(pt : FinancetimefigarchPoint, s : Double) -> FinancetimefigarchPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn finance_time_figarch_point_dot(a : FinancetimefigarchPoint, b : FinancetimefigarchPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn finance_time_figarch_point_cross(a : FinancetimefigarchPoint, b : FinancetimefigarchPoint) -> FinancetimefigarchPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn finance_time_figarch_point_norm(pt : FinancetimefigarchPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn finance_time_figarch_point_normalize(pt : FinancetimefigarchPoint) -> FinancetimefigarchPoint {
  let n = finance_time_figarch_point_norm(pt)
  if n < 0.0000001 { pt } else { finance_time_figarch_point_scale(pt, 1.0 / n) }
}

pub fn finance_time_figarch_point_negate(pt : FinancetimefigarchPoint) -> FinancetimefigarchPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn finance_time_figarch_point_mid(a : FinancetimefigarchPoint, b : FinancetimefigarchPoint) -> FinancetimefigarchPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn finance_time_figarch_point_lerp(a : FinancetimefigarchPoint, b : FinancetimefigarchPoint, t : Double) -> FinancetimefigarchPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn finance_time_figarch_point_to_string(pt : FinancetimefigarchPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct FinancetimefigarchSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn finance_time_figarch_make_series(vals : Array[Double], name : String) -> FinancetimefigarchSeries {
  { vals, name, meta: 0 }
}

pub fn finance_time_figarch_series_len(s : FinancetimefigarchSeries) -> Int { s.vals.length() }

pub fn finance_time_figarch_series_sum(s : FinancetimefigarchSeries) -> Double { @_common.sum(s.vals) }

pub fn finance_time_figarch_series_mean(s : FinancetimefigarchSeries) -> Double { @_common.mean(s.vals) }

pub fn finance_time_figarch_series_min(s : FinancetimefigarchSeries) -> Double { @_common.min(s.vals) }

pub fn finance_time_figarch_series_max(s : FinancetimefigarchSeries) -> Double { @_common.max(s.vals) }

pub fn finance_time_figarch_series_range(s : FinancetimefigarchSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn finance_time_figarch_series_var(s : FinancetimefigarchSeries) -> Double { @_common.variance(s.vals) }

pub fn finance_time_figarch_series_std(s : FinancetimefigarchSeries) -> Double { @_common.std(s.vals) }

pub fn finance_time_figarch_series_median(s : FinancetimefigarchSeries) -> Double { @_common.median(s.vals) }

pub fn finance_time_figarch_series_scale(s : FinancetimefigarchSeries, f : Double) -> FinancetimefigarchSeries {
  { vals: @_common.scale_arr(s.vals, f), name: s.name, meta: s.meta }
}

pub fn finance_time_figarch_series_add(a : FinancetimefigarchSeries, b : FinancetimefigarchSeries) -> FinancetimefigarchSeries {
  { vals: @_common.add_arr(a.vals, b.vals), name: a.name + "+" + b.name, meta: a.meta }
}

pub fn finance_time_figarch_series_sub(a : FinancetimefigarchSeries, b : FinancetimefigarchSeries) -> FinancetimefigarchSeries {
  { vals: @_common.sub_arr(a.vals, b.vals), name: a.name + "-" + b.name, meta: a.meta }
}

pub fn finance_time_figarch_series_normalize(s : FinancetimefigarchSeries) -> FinancetimefigarchSeries {
  let mn = finance_time_figarch_series_min(s)
  let mx = finance_time_figarch_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn finance_time_figarch_series_cumsum(s : FinancetimefigarchSeries) -> FinancetimefigarchSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn finance_time_figarch_series_to_string(s : FinancetimefigarchSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct FinancetimefigarchMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn finance_time_figarch_make_matrix(rows : Int, cols : Int, val : Double) -> FinancetimefigarchMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn finance_time_figarch_matrix_identity(n : Int) -> FinancetimefigarchMatrix {
  let m = finance_time_figarch_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn finance_time_figarch_matrix_get(m : FinancetimefigarchMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn finance_time_figarch_matrix_transpose(m : FinancetimefigarchMatrix) -> FinancetimefigarchMatrix {
  let result = finance_time_figarch_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn finance_time_figarch_matrix_add(a : FinancetimefigarchMatrix, b : FinancetimefigarchMatrix) -> FinancetimefigarchMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = finance_time_figarch_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn finance_time_figarch_matrix_scale(m : FinancetimefigarchMatrix, s : Double) -> FinancetimefigarchMatrix {
  let result = finance_time_figarch_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn finance_time_figarch_matrix_multiply(a : FinancetimefigarchMatrix, b : FinancetimefigarchMatrix) -> FinancetimefigarchMatrix {
  if a.cols != b.rows { return finance_time_figarch_make_matrix(a.rows, b.cols, 0.0) }
  let result = finance_time_figarch_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn finance_time_figarch_matrix_trace(m : FinancetimefigarchMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn finance_time_figarch_matrix_det(m : FinancetimefigarchMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn finance_time_figarch_matrix_norm(m : FinancetimefigarchMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn finance_time_figarch_matrix_to_string(m : FinancetimefigarchMatrix) -> String {
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

pub(all) struct FinancetimefigarchVector {
  comps : Array[Double]
  dim : Int
}

pub fn finance_time_figarch_make_vector(comps : Array[Double]) -> FinancetimefigarchVector {
  { comps, dim: comps.length() }
}

pub fn finance_time_figarch_vector_zero(dim : Int) -> FinancetimefigarchVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn finance_time_figarch_vector_add(a : FinancetimefigarchVector, b : FinancetimefigarchVector) -> FinancetimefigarchVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.add_arr(a.comps, b.comps), dim: n }
}

pub fn finance_time_figarch_vector_sub(a : FinancetimefigarchVector, b : FinancetimefigarchVector) -> FinancetimefigarchVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.sub_arr(a.comps, b.comps), dim: n }
}

pub fn finance_time_figarch_vector_scale(v : FinancetimefigarchVector, s : Double) -> FinancetimefigarchVector {
  { comps: @_common.scale_arr(v.comps, s), dim: v.dim }
}

pub fn finance_time_figarch_vector_dot(a : FinancetimefigarchVector, b : FinancetimefigarchVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn finance_time_figarch_vector_norm(v : FinancetimefigarchVector) -> Double { @_common.sqrt(finance_time_figarch_vector_dot(v, v)) }

pub fn finance_time_figarch_vector_normalize(v : FinancetimefigarchVector) -> FinancetimefigarchVector {
  let n = finance_time_figarch_vector_norm(v)
  if n < 0.0000001 { v } else { finance_time_figarch_vector_scale(v, 1.0 / n) }
}

pub fn finance_time_figarch_vector_dist(a : FinancetimefigarchVector, b : FinancetimefigarchVector) -> Double {
  finance_time_figarch_vector_norm(finance_time_figarch_vector_sub(a, b))
}

pub fn finance_time_figarch_vector_to_string(v : FinancetimefigarchVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn finance_time_figarch_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn finance_time_figarch_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn finance_time_figarch_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn finance_time_figarch_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn finance_time_figarch_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn finance_time_figarch_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn finance_time_figarch_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn finance_time_figarch_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn finance_time_figarch_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn finance_time_figarch_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn finance_time_figarch_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn finance_time_figarch_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn finance_time_figarch_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn finance_time_figarch_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn finance_time_figarch_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn finance_time_figarch_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn finance_time_figarch_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn finance_time_figarch_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn finance_time_figarch_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn finance_time_figarch_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn finance_time_figarch_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn finance_time_figarch_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn finance_time_figarch_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn finance_time_figarch_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn finance_time_figarch_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn finance_time_figarch_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn finance_time_figarch_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn finance_time_figarch_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn finance_time_figarch_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct FinancetimefigarchFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_figarch_frame_make(size : Int) -> FinancetimefigarchFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_figarch_frame_len(s : FinancetimefigarchFrame) -> Int { s.size }

pub fn finance_time_figarch_frame_get(s : FinancetimefigarchFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_figarch_frame_set(s : FinancetimefigarchFrame, i : Int, v : Double) -> FinancetimefigarchFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_time_figarch_frame_sum(s : FinancetimefigarchFrame) -> Double { @_common.sum(s.data) }

pub fn finance_time_figarch_frame_mean(s : FinancetimefigarchFrame) -> Double { @_common.mean(s.data) }

pub fn finance_time_figarch_frame_scale(s : FinancetimefigarchFrame, f : Double) -> FinancetimefigarchFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_time_figarch_frame_add(a : FinancetimefigarchFrame, b : FinancetimefigarchFrame) -> FinancetimefigarchFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_time_figarch_frame_copy(s : FinancetimefigarchFrame) -> FinancetimefigarchFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_time_figarch_frame_fill(s : FinancetimefigarchFrame, v : Double) -> FinancetimefigarchFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_time_figarch_frame_min(s : FinancetimefigarchFrame) -> Double { @_common.min(s.data) }

pub fn finance_time_figarch_frame_max(s : FinancetimefigarchFrame) -> Double { @_common.max(s.data) }

pub fn finance_time_figarch_frame_to_string(s : FinancetimefigarchFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimefigarchTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_figarch_table_make(size : Int) -> FinancetimefigarchTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_figarch_table_len(s : FinancetimefigarchTable) -> Int { s.size }

pub fn finance_time_figarch_table_get(s : FinancetimefigarchTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_figarch_table_set(s : FinancetimefigarchTable, i : Int, v : Double) -> FinancetimefigarchTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_time_figarch_table_sum(s : FinancetimefigarchTable) -> Double { @_common.sum(s.data) }

pub fn finance_time_figarch_table_mean(s : FinancetimefigarchTable) -> Double { @_common.mean(s.data) }

pub fn finance_time_figarch_table_scale(s : FinancetimefigarchTable, f : Double) -> FinancetimefigarchTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_time_figarch_table_add(a : FinancetimefigarchTable, b : FinancetimefigarchTable) -> FinancetimefigarchTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_time_figarch_table_copy(s : FinancetimefigarchTable) -> FinancetimefigarchTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_time_figarch_table_fill(s : FinancetimefigarchTable, v : Double) -> FinancetimefigarchTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_time_figarch_table_min(s : FinancetimefigarchTable) -> Double { @_common.min(s.data) }

pub fn finance_time_figarch_table_max(s : FinancetimefigarchTable) -> Double { @_common.max(s.data) }

pub fn finance_time_figarch_table_to_string(s : FinancetimefigarchTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimefigarchGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_figarch_graphn_make(size : Int) -> FinancetimefigarchGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_figarch_graphn_len(s : FinancetimefigarchGraphN) -> Int { s.size }

pub fn finance_time_figarch_graphn_get(s : FinancetimefigarchGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_figarch_graphn_set(s : FinancetimefigarchGraphN, i : Int, v : Double) -> FinancetimefigarchGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_time_figarch_graphn_sum(s : FinancetimefigarchGraphN) -> Double { @_common.sum(s.data) }

pub fn finance_time_figarch_graphn_mean(s : FinancetimefigarchGraphN) -> Double { @_common.mean(s.data) }

pub fn finance_time_figarch_graphn_scale(s : FinancetimefigarchGraphN, f : Double) -> FinancetimefigarchGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_time_figarch_graphn_add(a : FinancetimefigarchGraphN, b : FinancetimefigarchGraphN) -> FinancetimefigarchGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_time_figarch_graphn_copy(s : FinancetimefigarchGraphN) -> FinancetimefigarchGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_time_figarch_graphn_fill(s : FinancetimefigarchGraphN, v : Double) -> FinancetimefigarchGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_time_figarch_graphn_min(s : FinancetimefigarchGraphN) -> Double { @_common.min(s.data) }

pub fn finance_time_figarch_graphn_max(s : FinancetimefigarchGraphN) -> Double { @_common.max(s.data) }

pub fn finance_time_figarch_graphn_to_string(s : FinancetimefigarchGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimefigarchNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_figarch_node_make(size : Int) -> FinancetimefigarchNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_figarch_node_len(s : FinancetimefigarchNode) -> Int { s.size }

pub fn finance_time_figarch_node_get(s : FinancetimefigarchNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_figarch_node_set(s : FinancetimefigarchNode, i : Int, v : Double) -> FinancetimefigarchNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_time_figarch_node_sum(s : FinancetimefigarchNode) -> Double { @_common.sum(s.data) }

pub fn finance_time_figarch_node_mean(s : FinancetimefigarchNode) -> Double { @_common.mean(s.data) }

pub fn finance_time_figarch_node_scale(s : FinancetimefigarchNode, f : Double) -> FinancetimefigarchNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_time_figarch_node_add(a : FinancetimefigarchNode, b : FinancetimefigarchNode) -> FinancetimefigarchNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_time_figarch_node_copy(s : FinancetimefigarchNode) -> FinancetimefigarchNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_time_figarch_node_fill(s : FinancetimefigarchNode, v : Double) -> FinancetimefigarchNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_time_figarch_node_min(s : FinancetimefigarchNode) -> Double { @_common.min(s.data) }

pub fn finance_time_figarch_node_max(s : FinancetimefigarchNode) -> Double { @_common.max(s.data) }

pub fn finance_time_figarch_node_to_string(s : FinancetimefigarchNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimefigarchEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_figarch_edge_make(size : Int) -> FinancetimefigarchEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_figarch_edge_len(s : FinancetimefigarchEdge) -> Int { s.size }

pub fn finance_time_figarch_edge_get(s : FinancetimefigarchEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_figarch_edge_set(s : FinancetimefigarchEdge, i : Int, v : Double) -> FinancetimefigarchEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_time_figarch_edge_sum(s : FinancetimefigarchEdge) -> Double { @_common.sum(s.data) }

pub fn finance_time_figarch_edge_mean(s : FinancetimefigarchEdge) -> Double { @_common.mean(s.data) }

pub fn finance_time_figarch_edge_scale(s : FinancetimefigarchEdge, f : Double) -> FinancetimefigarchEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_time_figarch_edge_add(a : FinancetimefigarchEdge, b : FinancetimefigarchEdge) -> FinancetimefigarchEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_time_figarch_edge_copy(s : FinancetimefigarchEdge) -> FinancetimefigarchEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_time_figarch_edge_fill(s : FinancetimefigarchEdge, v : Double) -> FinancetimefigarchEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_time_figarch_edge_min(s : FinancetimefigarchEdge) -> Double { @_common.min(s.data) }

pub fn finance_time_figarch_edge_max(s : FinancetimefigarchEdge) -> Double { @_common.max(s.data) }

pub fn finance_time_figarch_edge_to_string(s : FinancetimefigarchEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimefigarchPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_figarch_path_make(size : Int) -> FinancetimefigarchPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_figarch_path_len(s : FinancetimefigarchPath) -> Int { s.size }

pub fn finance_time_figarch_path_get(s : FinancetimefigarchPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_figarch_path_set(s : FinancetimefigarchPath, i : Int, v : Double) -> FinancetimefigarchPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_time_figarch_path_sum(s : FinancetimefigarchPath) -> Double { @_common.sum(s.data) }

pub fn finance_time_figarch_path_mean(s : FinancetimefigarchPath) -> Double { @_common.mean(s.data) }

pub fn finance_time_figarch_path_scale(s : FinancetimefigarchPath, f : Double) -> FinancetimefigarchPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_time_figarch_path_add(a : FinancetimefigarchPath, b : FinancetimefigarchPath) -> FinancetimefigarchPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_time_figarch_path_copy(s : FinancetimefigarchPath) -> FinancetimefigarchPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_time_figarch_path_fill(s : FinancetimefigarchPath, v : Double) -> FinancetimefigarchPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_time_figarch_path_min(s : FinancetimefigarchPath) -> Double { @_common.min(s.data) }

pub fn finance_time_figarch_path_max(s : FinancetimefigarchPath) -> Double { @_common.max(s.data) }

pub fn finance_time_figarch_path_to_string(s : FinancetimefigarchPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimefigarchCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_figarch_cluster_make(size : Int) -> FinancetimefigarchCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_figarch_cluster_len(s : FinancetimefigarchCluster) -> Int { s.size }

pub fn finance_time_figarch_cluster_get(s : FinancetimefigarchCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_figarch_cluster_set(s : FinancetimefigarchCluster, i : Int, v : Double) -> FinancetimefigarchCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_time_figarch_cluster_sum(s : FinancetimefigarchCluster) -> Double { @_common.sum(s.data) }

pub fn finance_time_figarch_cluster_mean(s : FinancetimefigarchCluster) -> Double { @_common.mean(s.data) }

pub fn finance_time_figarch_cluster_scale(s : FinancetimefigarchCluster, f : Double) -> FinancetimefigarchCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_time_figarch_cluster_add(a : FinancetimefigarchCluster, b : FinancetimefigarchCluster) -> FinancetimefigarchCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_time_figarch_cluster_copy(s : FinancetimefigarchCluster) -> FinancetimefigarchCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_time_figarch_cluster_fill(s : FinancetimefigarchCluster, v : Double) -> FinancetimefigarchCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_time_figarch_cluster_min(s : FinancetimefigarchCluster) -> Double { @_common.min(s.data) }

pub fn finance_time_figarch_cluster_max(s : FinancetimefigarchCluster) -> Double { @_common.max(s.data) }

pub fn finance_time_figarch_cluster_to_string(s : FinancetimefigarchCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimefigarchModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_figarch_model_make(size : Int) -> FinancetimefigarchModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_figarch_model_len(s : FinancetimefigarchModel) -> Int { s.size }

pub fn finance_time_figarch_model_get(s : FinancetimefigarchModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_figarch_model_set(s : FinancetimefigarchModel, i : Int, v : Double) -> FinancetimefigarchModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_time_figarch_model_sum(s : FinancetimefigarchModel) -> Double { @_common.sum(s.data) }

pub fn finance_time_figarch_model_mean(s : FinancetimefigarchModel) -> Double { @_common.mean(s.data) }

pub fn finance_time_figarch_model_scale(s : FinancetimefigarchModel, f : Double) -> FinancetimefigarchModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_time_figarch_model_add(a : FinancetimefigarchModel, b : FinancetimefigarchModel) -> FinancetimefigarchModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_time_figarch_model_copy(s : FinancetimefigarchModel) -> FinancetimefigarchModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_time_figarch_model_fill(s : FinancetimefigarchModel, v : Double) -> FinancetimefigarchModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_time_figarch_model_min(s : FinancetimefigarchModel) -> Double { @_common.min(s.data) }

pub fn finance_time_figarch_model_max(s : FinancetimefigarchModel) -> Double { @_common.max(s.data) }

pub fn finance_time_figarch_model_to_string(s : FinancetimefigarchModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimefigarchLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_figarch_layer_make(size : Int) -> FinancetimefigarchLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_figarch_layer_len(s : FinancetimefigarchLayer) -> Int { s.size }

pub fn finance_time_figarch_layer_get(s : FinancetimefigarchLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_figarch_layer_set(s : FinancetimefigarchLayer, i : Int, v : Double) -> FinancetimefigarchLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_time_figarch_layer_sum(s : FinancetimefigarchLayer) -> Double { @_common.sum(s.data) }

pub fn finance_time_figarch_layer_mean(s : FinancetimefigarchLayer) -> Double { @_common.mean(s.data) }

pub fn finance_time_figarch_layer_scale(s : FinancetimefigarchLayer, f : Double) -> FinancetimefigarchLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_time_figarch_layer_add(a : FinancetimefigarchLayer, b : FinancetimefigarchLayer) -> FinancetimefigarchLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_time_figarch_layer_copy(s : FinancetimefigarchLayer) -> FinancetimefigarchLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_time_figarch_layer_fill(s : FinancetimefigarchLayer, v : Double) -> FinancetimefigarchLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_time_figarch_layer_min(s : FinancetimefigarchLayer) -> Double { @_common.min(s.data) }

pub fn finance_time_figarch_layer_max(s : FinancetimefigarchLayer) -> Double { @_common.max(s.data) }

pub fn finance_time_figarch_layer_to_string(s : FinancetimefigarchLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimefigarchBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_figarch_buffer_make(size : Int) -> FinancetimefigarchBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_figarch_buffer_len(s : FinancetimefigarchBuffer) -> Int { s.size }

pub fn finance_time_figarch_buffer_get(s : FinancetimefigarchBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_figarch_buffer_set(s : FinancetimefigarchBuffer, i : Int, v : Double) -> FinancetimefigarchBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_time_figarch_buffer_sum(s : FinancetimefigarchBuffer) -> Double { @_common.sum(s.data) }

pub fn finance_time_figarch_buffer_mean(s : FinancetimefigarchBuffer) -> Double { @_common.mean(s.data) }

pub fn finance_time_figarch_buffer_scale(s : FinancetimefigarchBuffer, f : Double) -> FinancetimefigarchBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_time_figarch_buffer_add(a : FinancetimefigarchBuffer, b : FinancetimefigarchBuffer) -> FinancetimefigarchBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_time_figarch_buffer_copy(s : FinancetimefigarchBuffer) -> FinancetimefigarchBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_time_figarch_buffer_fill(s : FinancetimefigarchBuffer, v : Double) -> FinancetimefigarchBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_time_figarch_buffer_min(s : FinancetimefigarchBuffer) -> Double { @_common.min(s.data) }

pub fn finance_time_figarch_buffer_max(s : FinancetimefigarchBuffer) -> Double { @_common.max(s.data) }

pub fn finance_time_figarch_buffer_to_string(s : FinancetimefigarchBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimefigarchCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_figarch_cursor_make(size : Int) -> FinancetimefigarchCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_figarch_cursor_len(s : FinancetimefigarchCursor) -> Int { s.size }

pub fn finance_time_figarch_cursor_get(s : FinancetimefigarchCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_figarch_cursor_set(s : FinancetimefigarchCursor, i : Int, v : Double) -> FinancetimefigarchCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_time_figarch_cursor_sum(s : FinancetimefigarchCursor) -> Double { @_common.sum(s.data) }

pub fn finance_time_figarch_cursor_mean(s : FinancetimefigarchCursor) -> Double { @_common.mean(s.data) }

pub fn finance_time_figarch_cursor_scale(s : FinancetimefigarchCursor, f : Double) -> FinancetimefigarchCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_time_figarch_cursor_add(a : FinancetimefigarchCursor, b : FinancetimefigarchCursor) -> FinancetimefigarchCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_time_figarch_cursor_copy(s : FinancetimefigarchCursor) -> FinancetimefigarchCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_time_figarch_cursor_fill(s : FinancetimefigarchCursor, v : Double) -> FinancetimefigarchCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_time_figarch_cursor_min(s : FinancetimefigarchCursor) -> Double { @_common.min(s.data) }

pub fn finance_time_figarch_cursor_max(s : FinancetimefigarchCursor) -> Double { @_common.max(s.data) }

pub fn finance_time_figarch_cursor_to_string(s : FinancetimefigarchCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimefigarchView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_figarch_view_make(size : Int) -> FinancetimefigarchView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_figarch_view_len(s : FinancetimefigarchView) -> Int { s.size }

pub fn finance_time_figarch_view_get(s : FinancetimefigarchView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_figarch_view_set(s : FinancetimefigarchView, i : Int, v : Double) -> FinancetimefigarchView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_time_figarch_view_sum(s : FinancetimefigarchView) -> Double { @_common.sum(s.data) }

pub fn finance_time_figarch_view_mean(s : FinancetimefigarchView) -> Double { @_common.mean(s.data) }

pub fn finance_time_figarch_view_scale(s : FinancetimefigarchView, f : Double) -> FinancetimefigarchView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_time_figarch_view_add(a : FinancetimefigarchView, b : FinancetimefigarchView) -> FinancetimefigarchView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_time_figarch_view_copy(s : FinancetimefigarchView) -> FinancetimefigarchView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_time_figarch_view_fill(s : FinancetimefigarchView, v : Double) -> FinancetimefigarchView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_time_figarch_view_min(s : FinancetimefigarchView) -> Double { @_common.min(s.data) }

pub fn finance_time_figarch_view_max(s : FinancetimefigarchView) -> Double { @_common.max(s.data) }

pub fn finance_time_figarch_view_to_string(s : FinancetimefigarchView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimefigarchRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_figarch_range_make(size : Int) -> FinancetimefigarchRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_figarch_range_len(s : FinancetimefigarchRange) -> Int { s.size }

pub fn finance_time_figarch_range_get(s : FinancetimefigarchRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_figarch_range_set(s : FinancetimefigarchRange, i : Int, v : Double) -> FinancetimefigarchRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_time_figarch_range_sum(s : FinancetimefigarchRange) -> Double { @_common.sum(s.data) }

pub fn finance_time_figarch_range_mean(s : FinancetimefigarchRange) -> Double { @_common.mean(s.data) }

pub fn finance_time_figarch_range_scale(s : FinancetimefigarchRange, f : Double) -> FinancetimefigarchRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_time_figarch_range_add(a : FinancetimefigarchRange, b : FinancetimefigarchRange) -> FinancetimefigarchRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_time_figarch_range_copy(s : FinancetimefigarchRange) -> FinancetimefigarchRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_time_figarch_range_fill(s : FinancetimefigarchRange, v : Double) -> FinancetimefigarchRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_time_figarch_range_min(s : FinancetimefigarchRange) -> Double { @_common.min(s.data) }

pub fn finance_time_figarch_range_max(s : FinancetimefigarchRange) -> Double { @_common.max(s.data) }

pub fn finance_time_figarch_range_to_string(s : FinancetimefigarchRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimefigarchSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_figarch_slice_make(size : Int) -> FinancetimefigarchSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_figarch_slice_len(s : FinancetimefigarchSlice) -> Int { s.size }

pub fn finance_time_figarch_slice_get(s : FinancetimefigarchSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_figarch_slice_set(s : FinancetimefigarchSlice, i : Int, v : Double) -> FinancetimefigarchSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_time_figarch_slice_sum(s : FinancetimefigarchSlice) -> Double { @_common.sum(s.data) }

pub fn finance_time_figarch_slice_mean(s : FinancetimefigarchSlice) -> Double { @_common.mean(s.data) }

pub fn finance_time_figarch_slice_scale(s : FinancetimefigarchSlice, f : Double) -> FinancetimefigarchSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_time_figarch_slice_add(a : FinancetimefigarchSlice, b : FinancetimefigarchSlice) -> FinancetimefigarchSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_time_figarch_slice_copy(s : FinancetimefigarchSlice) -> FinancetimefigarchSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_time_figarch_slice_fill(s : FinancetimefigarchSlice, v : Double) -> FinancetimefigarchSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_time_figarch_slice_min(s : FinancetimefigarchSlice) -> Double { @_common.min(s.data) }

pub fn finance_time_figarch_slice_max(s : FinancetimefigarchSlice) -> Double { @_common.max(s.data) }

pub fn finance_time_figarch_slice_to_string(s : FinancetimefigarchSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

