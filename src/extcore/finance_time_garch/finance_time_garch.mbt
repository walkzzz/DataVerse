///===
/// extcore/finance_time_garch

pub(all) struct FinancetimegarchPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn finance_time_garch_make_point(x : Double, y : Double) -> FinancetimegarchPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn finance_time_garch_make_point3(x : Double, y : Double, z : Double) -> FinancetimegarchPoint {
  { x, y, z, label: 0 }
}

pub fn finance_time_garch_point_x(pt : FinancetimegarchPoint) -> Double { pt.x }

pub fn finance_time_garch_point_y(pt : FinancetimegarchPoint) -> Double { pt.y }

pub fn finance_time_garch_point_z(pt : FinancetimegarchPoint) -> Double { pt.z }

pub fn finance_time_garch_point_label(pt : FinancetimegarchPoint) -> Int { pt.label }

pub fn finance_time_garch_point_dist(a : FinancetimegarchPoint, b : FinancetimegarchPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn finance_time_garch_point_add(a : FinancetimegarchPoint, b : FinancetimegarchPoint) -> FinancetimegarchPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn finance_time_garch_point_sub(a : FinancetimegarchPoint, b : FinancetimegarchPoint) -> FinancetimegarchPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn finance_time_garch_point_scale(pt : FinancetimegarchPoint, s : Double) -> FinancetimegarchPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn finance_time_garch_point_dot(a : FinancetimegarchPoint, b : FinancetimegarchPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn finance_time_garch_point_cross(a : FinancetimegarchPoint, b : FinancetimegarchPoint) -> FinancetimegarchPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn finance_time_garch_point_norm(pt : FinancetimegarchPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn finance_time_garch_point_normalize(pt : FinancetimegarchPoint) -> FinancetimegarchPoint {
  let n = finance_time_garch_point_norm(pt)
  if n < 0.0000001 { pt } else { finance_time_garch_point_scale(pt, 1.0 / n) }
}

pub fn finance_time_garch_point_negate(pt : FinancetimegarchPoint) -> FinancetimegarchPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn finance_time_garch_point_mid(a : FinancetimegarchPoint, b : FinancetimegarchPoint) -> FinancetimegarchPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn finance_time_garch_point_lerp(a : FinancetimegarchPoint, b : FinancetimegarchPoint, t : Double) -> FinancetimegarchPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn finance_time_garch_point_to_string(pt : FinancetimegarchPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct FinancetimegarchSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn finance_time_garch_make_series(vals : Array[Double], name : String) -> FinancetimegarchSeries {
  { vals, name, meta: 0 }
}

pub fn finance_time_garch_series_len(s : FinancetimegarchSeries) -> Int { s.vals.length() }

pub fn finance_time_garch_series_sum(s : FinancetimegarchSeries) -> Double { @_common.sum(s.vals) }

pub fn finance_time_garch_series_mean(s : FinancetimegarchSeries) -> Double { @_common.mean(s.vals) }

pub fn finance_time_garch_series_min(s : FinancetimegarchSeries) -> Double { @_common.min(s.vals) }

pub fn finance_time_garch_series_max(s : FinancetimegarchSeries) -> Double { @_common.max(s.vals) }

pub fn finance_time_garch_series_range(s : FinancetimegarchSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn finance_time_garch_series_var(s : FinancetimegarchSeries) -> Double { @_common.variance(s.vals) }

pub fn finance_time_garch_series_std(s : FinancetimegarchSeries) -> Double { @_common.std(s.vals) }

pub fn finance_time_garch_series_median(s : FinancetimegarchSeries) -> Double { @_common.median(s.vals) }

pub fn finance_time_garch_series_scale(s : FinancetimegarchSeries, f : Double) -> FinancetimegarchSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn finance_time_garch_series_add(a : FinancetimegarchSeries, b : FinancetimegarchSeries) -> FinancetimegarchSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn finance_time_garch_series_sub(a : FinancetimegarchSeries, b : FinancetimegarchSeries) -> FinancetimegarchSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn finance_time_garch_series_normalize(s : FinancetimegarchSeries) -> FinancetimegarchSeries {
  let mn = finance_time_garch_series_min(s)
  let mx = finance_time_garch_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn finance_time_garch_series_cumsum(s : FinancetimegarchSeries) -> FinancetimegarchSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn finance_time_garch_series_to_string(s : FinancetimegarchSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct FinancetimegarchMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn finance_time_garch_make_matrix(rows : Int, cols : Int, val : Double) -> FinancetimegarchMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn finance_time_garch_matrix_identity(n : Int) -> FinancetimegarchMatrix {
  let m = finance_time_garch_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn finance_time_garch_matrix_get(m : FinancetimegarchMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn finance_time_garch_matrix_transpose(m : FinancetimegarchMatrix) -> FinancetimegarchMatrix {
  let result = finance_time_garch_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn finance_time_garch_matrix_add(a : FinancetimegarchMatrix, b : FinancetimegarchMatrix) -> FinancetimegarchMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = finance_time_garch_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn finance_time_garch_matrix_scale(m : FinancetimegarchMatrix, s : Double) -> FinancetimegarchMatrix {
  let result = finance_time_garch_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn finance_time_garch_matrix_multiply(a : FinancetimegarchMatrix, b : FinancetimegarchMatrix) -> FinancetimegarchMatrix {
  if a.cols != b.rows { return finance_time_garch_make_matrix(a.rows, b.cols, 0.0) }
  let result = finance_time_garch_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn finance_time_garch_matrix_trace(m : FinancetimegarchMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn finance_time_garch_matrix_det(m : FinancetimegarchMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn finance_time_garch_matrix_norm(m : FinancetimegarchMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn finance_time_garch_matrix_to_string(m : FinancetimegarchMatrix) -> String {
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

pub(all) struct FinancetimegarchVector {
  comps : Array[Double]
  dim : Int
}

pub fn finance_time_garch_make_vector(comps : Array[Double]) -> FinancetimegarchVector {
  { comps, dim: comps.length() }
}

pub fn finance_time_garch_vector_zero(dim : Int) -> FinancetimegarchVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn finance_time_garch_vector_add(a : FinancetimegarchVector, b : FinancetimegarchVector) -> FinancetimegarchVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn finance_time_garch_vector_sub(a : FinancetimegarchVector, b : FinancetimegarchVector) -> FinancetimegarchVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn finance_time_garch_vector_scale(v : FinancetimegarchVector, s : Double) -> FinancetimegarchVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn finance_time_garch_vector_dot(a : FinancetimegarchVector, b : FinancetimegarchVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn finance_time_garch_vector_norm(v : FinancetimegarchVector) -> Double { @_common.sqrt(finance_time_garch_vector_dot(v, v)) }

pub fn finance_time_garch_vector_normalize(v : FinancetimegarchVector) -> FinancetimegarchVector {
  let n = finance_time_garch_vector_norm(v)
  if n < 0.0000001 { v } else { finance_time_garch_vector_scale(v, 1.0 / n) }
}

pub fn finance_time_garch_vector_dist(a : FinancetimegarchVector, b : FinancetimegarchVector) -> Double {
  finance_time_garch_vector_norm(finance_time_garch_vector_sub(a, b))
}

pub fn finance_time_garch_vector_to_string(v : FinancetimegarchVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn finance_time_garch_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn finance_time_garch_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn finance_time_garch_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn finance_time_garch_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn finance_time_garch_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn finance_time_garch_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn finance_time_garch_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn finance_time_garch_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn finance_time_garch_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn finance_time_garch_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn finance_time_garch_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn finance_time_garch_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn finance_time_garch_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn finance_time_garch_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn finance_time_garch_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn finance_time_garch_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn finance_time_garch_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn finance_time_garch_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn finance_time_garch_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn finance_time_garch_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn finance_time_garch_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn finance_time_garch_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn finance_time_garch_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn finance_time_garch_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn finance_time_garch_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn finance_time_garch_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn finance_time_garch_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn finance_time_garch_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn finance_time_garch_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct FinancetimegarchFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_garch_frame_make(size : Int) -> FinancetimegarchFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_garch_frame_len(s : FinancetimegarchFrame) -> Int { s.size }

pub fn finance_time_garch_frame_get(s : FinancetimegarchFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_garch_frame_set(s : FinancetimegarchFrame, i : Int, v : Double) -> FinancetimegarchFrame {
  let result = finance_time_garch_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_time_garch_frame_sum(s : FinancetimegarchFrame) -> Double { @_common.sum(s.data) }

pub fn finance_time_garch_frame_mean(s : FinancetimegarchFrame) -> Double { @_common.mean(s.data) }

pub fn finance_time_garch_frame_scale(s : FinancetimegarchFrame, f : Double) -> FinancetimegarchFrame {
  let result = finance_time_garch_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_time_garch_frame_add(a : FinancetimegarchFrame, b : FinancetimegarchFrame) -> FinancetimegarchFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_time_garch_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_time_garch_frame_copy(s : FinancetimegarchFrame) -> FinancetimegarchFrame {
  let result = finance_time_garch_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_time_garch_frame_fill(s : FinancetimegarchFrame, v : Double) -> FinancetimegarchFrame {
  let result = finance_time_garch_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_time_garch_frame_min(s : FinancetimegarchFrame) -> Double { @_common.min(s.data) }

pub fn finance_time_garch_frame_max(s : FinancetimegarchFrame) -> Double { @_common.max(s.data) }

pub fn finance_time_garch_frame_to_string(s : FinancetimegarchFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimegarchTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_garch_table_make(size : Int) -> FinancetimegarchTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_garch_table_len(s : FinancetimegarchTable) -> Int { s.size }

pub fn finance_time_garch_table_get(s : FinancetimegarchTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_garch_table_set(s : FinancetimegarchTable, i : Int, v : Double) -> FinancetimegarchTable {
  let result = finance_time_garch_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_time_garch_table_sum(s : FinancetimegarchTable) -> Double { @_common.sum(s.data) }

pub fn finance_time_garch_table_mean(s : FinancetimegarchTable) -> Double { @_common.mean(s.data) }

pub fn finance_time_garch_table_scale(s : FinancetimegarchTable, f : Double) -> FinancetimegarchTable {
  let result = finance_time_garch_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_time_garch_table_add(a : FinancetimegarchTable, b : FinancetimegarchTable) -> FinancetimegarchTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_time_garch_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_time_garch_table_copy(s : FinancetimegarchTable) -> FinancetimegarchTable {
  let result = finance_time_garch_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_time_garch_table_fill(s : FinancetimegarchTable, v : Double) -> FinancetimegarchTable {
  let result = finance_time_garch_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_time_garch_table_min(s : FinancetimegarchTable) -> Double { @_common.min(s.data) }

pub fn finance_time_garch_table_max(s : FinancetimegarchTable) -> Double { @_common.max(s.data) }

pub fn finance_time_garch_table_to_string(s : FinancetimegarchTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimegarchGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_garch_graphn_make(size : Int) -> FinancetimegarchGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_garch_graphn_len(s : FinancetimegarchGraphN) -> Int { s.size }

pub fn finance_time_garch_graphn_get(s : FinancetimegarchGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_garch_graphn_set(s : FinancetimegarchGraphN, i : Int, v : Double) -> FinancetimegarchGraphN {
  let result = finance_time_garch_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_time_garch_graphn_sum(s : FinancetimegarchGraphN) -> Double { @_common.sum(s.data) }

pub fn finance_time_garch_graphn_mean(s : FinancetimegarchGraphN) -> Double { @_common.mean(s.data) }

pub fn finance_time_garch_graphn_scale(s : FinancetimegarchGraphN, f : Double) -> FinancetimegarchGraphN {
  let result = finance_time_garch_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_time_garch_graphn_add(a : FinancetimegarchGraphN, b : FinancetimegarchGraphN) -> FinancetimegarchGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_time_garch_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_time_garch_graphn_copy(s : FinancetimegarchGraphN) -> FinancetimegarchGraphN {
  let result = finance_time_garch_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_time_garch_graphn_fill(s : FinancetimegarchGraphN, v : Double) -> FinancetimegarchGraphN {
  let result = finance_time_garch_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_time_garch_graphn_min(s : FinancetimegarchGraphN) -> Double { @_common.min(s.data) }

pub fn finance_time_garch_graphn_max(s : FinancetimegarchGraphN) -> Double { @_common.max(s.data) }

pub fn finance_time_garch_graphn_to_string(s : FinancetimegarchGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimegarchNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_garch_node_make(size : Int) -> FinancetimegarchNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_garch_node_len(s : FinancetimegarchNode) -> Int { s.size }

pub fn finance_time_garch_node_get(s : FinancetimegarchNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_garch_node_set(s : FinancetimegarchNode, i : Int, v : Double) -> FinancetimegarchNode {
  let result = finance_time_garch_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_time_garch_node_sum(s : FinancetimegarchNode) -> Double { @_common.sum(s.data) }

pub fn finance_time_garch_node_mean(s : FinancetimegarchNode) -> Double { @_common.mean(s.data) }

pub fn finance_time_garch_node_scale(s : FinancetimegarchNode, f : Double) -> FinancetimegarchNode {
  let result = finance_time_garch_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_time_garch_node_add(a : FinancetimegarchNode, b : FinancetimegarchNode) -> FinancetimegarchNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_time_garch_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_time_garch_node_copy(s : FinancetimegarchNode) -> FinancetimegarchNode {
  let result = finance_time_garch_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_time_garch_node_fill(s : FinancetimegarchNode, v : Double) -> FinancetimegarchNode {
  let result = finance_time_garch_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_time_garch_node_min(s : FinancetimegarchNode) -> Double { @_common.min(s.data) }

pub fn finance_time_garch_node_max(s : FinancetimegarchNode) -> Double { @_common.max(s.data) }

pub fn finance_time_garch_node_to_string(s : FinancetimegarchNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimegarchEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_garch_edge_make(size : Int) -> FinancetimegarchEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_garch_edge_len(s : FinancetimegarchEdge) -> Int { s.size }

pub fn finance_time_garch_edge_get(s : FinancetimegarchEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_garch_edge_set(s : FinancetimegarchEdge, i : Int, v : Double) -> FinancetimegarchEdge {
  let result = finance_time_garch_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_time_garch_edge_sum(s : FinancetimegarchEdge) -> Double { @_common.sum(s.data) }

pub fn finance_time_garch_edge_mean(s : FinancetimegarchEdge) -> Double { @_common.mean(s.data) }

pub fn finance_time_garch_edge_scale(s : FinancetimegarchEdge, f : Double) -> FinancetimegarchEdge {
  let result = finance_time_garch_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_time_garch_edge_add(a : FinancetimegarchEdge, b : FinancetimegarchEdge) -> FinancetimegarchEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_time_garch_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_time_garch_edge_copy(s : FinancetimegarchEdge) -> FinancetimegarchEdge {
  let result = finance_time_garch_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_time_garch_edge_fill(s : FinancetimegarchEdge, v : Double) -> FinancetimegarchEdge {
  let result = finance_time_garch_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_time_garch_edge_min(s : FinancetimegarchEdge) -> Double { @_common.min(s.data) }

pub fn finance_time_garch_edge_max(s : FinancetimegarchEdge) -> Double { @_common.max(s.data) }

pub fn finance_time_garch_edge_to_string(s : FinancetimegarchEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimegarchPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_garch_path_make(size : Int) -> FinancetimegarchPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_garch_path_len(s : FinancetimegarchPath) -> Int { s.size }

pub fn finance_time_garch_path_get(s : FinancetimegarchPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_garch_path_set(s : FinancetimegarchPath, i : Int, v : Double) -> FinancetimegarchPath {
  let result = finance_time_garch_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_time_garch_path_sum(s : FinancetimegarchPath) -> Double { @_common.sum(s.data) }

pub fn finance_time_garch_path_mean(s : FinancetimegarchPath) -> Double { @_common.mean(s.data) }

pub fn finance_time_garch_path_scale(s : FinancetimegarchPath, f : Double) -> FinancetimegarchPath {
  let result = finance_time_garch_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_time_garch_path_add(a : FinancetimegarchPath, b : FinancetimegarchPath) -> FinancetimegarchPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_time_garch_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_time_garch_path_copy(s : FinancetimegarchPath) -> FinancetimegarchPath {
  let result = finance_time_garch_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_time_garch_path_fill(s : FinancetimegarchPath, v : Double) -> FinancetimegarchPath {
  let result = finance_time_garch_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_time_garch_path_min(s : FinancetimegarchPath) -> Double { @_common.min(s.data) }

pub fn finance_time_garch_path_max(s : FinancetimegarchPath) -> Double { @_common.max(s.data) }

pub fn finance_time_garch_path_to_string(s : FinancetimegarchPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimegarchCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_garch_cluster_make(size : Int) -> FinancetimegarchCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_garch_cluster_len(s : FinancetimegarchCluster) -> Int { s.size }

pub fn finance_time_garch_cluster_get(s : FinancetimegarchCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_garch_cluster_set(s : FinancetimegarchCluster, i : Int, v : Double) -> FinancetimegarchCluster {
  let result = finance_time_garch_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_time_garch_cluster_sum(s : FinancetimegarchCluster) -> Double { @_common.sum(s.data) }

pub fn finance_time_garch_cluster_mean(s : FinancetimegarchCluster) -> Double { @_common.mean(s.data) }

pub fn finance_time_garch_cluster_scale(s : FinancetimegarchCluster, f : Double) -> FinancetimegarchCluster {
  let result = finance_time_garch_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_time_garch_cluster_add(a : FinancetimegarchCluster, b : FinancetimegarchCluster) -> FinancetimegarchCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_time_garch_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_time_garch_cluster_copy(s : FinancetimegarchCluster) -> FinancetimegarchCluster {
  let result = finance_time_garch_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_time_garch_cluster_fill(s : FinancetimegarchCluster, v : Double) -> FinancetimegarchCluster {
  let result = finance_time_garch_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_time_garch_cluster_min(s : FinancetimegarchCluster) -> Double { @_common.min(s.data) }

pub fn finance_time_garch_cluster_max(s : FinancetimegarchCluster) -> Double { @_common.max(s.data) }

pub fn finance_time_garch_cluster_to_string(s : FinancetimegarchCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimegarchModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_garch_model_make(size : Int) -> FinancetimegarchModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_garch_model_len(s : FinancetimegarchModel) -> Int { s.size }

pub fn finance_time_garch_model_get(s : FinancetimegarchModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_garch_model_set(s : FinancetimegarchModel, i : Int, v : Double) -> FinancetimegarchModel {
  let result = finance_time_garch_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_time_garch_model_sum(s : FinancetimegarchModel) -> Double { @_common.sum(s.data) }

pub fn finance_time_garch_model_mean(s : FinancetimegarchModel) -> Double { @_common.mean(s.data) }

pub fn finance_time_garch_model_scale(s : FinancetimegarchModel, f : Double) -> FinancetimegarchModel {
  let result = finance_time_garch_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_time_garch_model_add(a : FinancetimegarchModel, b : FinancetimegarchModel) -> FinancetimegarchModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_time_garch_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_time_garch_model_copy(s : FinancetimegarchModel) -> FinancetimegarchModel {
  let result = finance_time_garch_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_time_garch_model_fill(s : FinancetimegarchModel, v : Double) -> FinancetimegarchModel {
  let result = finance_time_garch_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_time_garch_model_min(s : FinancetimegarchModel) -> Double { @_common.min(s.data) }

pub fn finance_time_garch_model_max(s : FinancetimegarchModel) -> Double { @_common.max(s.data) }

pub fn finance_time_garch_model_to_string(s : FinancetimegarchModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimegarchLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_garch_layer_make(size : Int) -> FinancetimegarchLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_garch_layer_len(s : FinancetimegarchLayer) -> Int { s.size }

pub fn finance_time_garch_layer_get(s : FinancetimegarchLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_garch_layer_set(s : FinancetimegarchLayer, i : Int, v : Double) -> FinancetimegarchLayer {
  let result = finance_time_garch_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_time_garch_layer_sum(s : FinancetimegarchLayer) -> Double { @_common.sum(s.data) }

pub fn finance_time_garch_layer_mean(s : FinancetimegarchLayer) -> Double { @_common.mean(s.data) }

pub fn finance_time_garch_layer_scale(s : FinancetimegarchLayer, f : Double) -> FinancetimegarchLayer {
  let result = finance_time_garch_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_time_garch_layer_add(a : FinancetimegarchLayer, b : FinancetimegarchLayer) -> FinancetimegarchLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_time_garch_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_time_garch_layer_copy(s : FinancetimegarchLayer) -> FinancetimegarchLayer {
  let result = finance_time_garch_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_time_garch_layer_fill(s : FinancetimegarchLayer, v : Double) -> FinancetimegarchLayer {
  let result = finance_time_garch_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_time_garch_layer_min(s : FinancetimegarchLayer) -> Double { @_common.min(s.data) }

pub fn finance_time_garch_layer_max(s : FinancetimegarchLayer) -> Double { @_common.max(s.data) }

pub fn finance_time_garch_layer_to_string(s : FinancetimegarchLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimegarchBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_garch_buffer_make(size : Int) -> FinancetimegarchBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_garch_buffer_len(s : FinancetimegarchBuffer) -> Int { s.size }

pub fn finance_time_garch_buffer_get(s : FinancetimegarchBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_garch_buffer_set(s : FinancetimegarchBuffer, i : Int, v : Double) -> FinancetimegarchBuffer {
  let result = finance_time_garch_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_time_garch_buffer_sum(s : FinancetimegarchBuffer) -> Double { @_common.sum(s.data) }

pub fn finance_time_garch_buffer_mean(s : FinancetimegarchBuffer) -> Double { @_common.mean(s.data) }

pub fn finance_time_garch_buffer_scale(s : FinancetimegarchBuffer, f : Double) -> FinancetimegarchBuffer {
  let result = finance_time_garch_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_time_garch_buffer_add(a : FinancetimegarchBuffer, b : FinancetimegarchBuffer) -> FinancetimegarchBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_time_garch_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_time_garch_buffer_copy(s : FinancetimegarchBuffer) -> FinancetimegarchBuffer {
  let result = finance_time_garch_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_time_garch_buffer_fill(s : FinancetimegarchBuffer, v : Double) -> FinancetimegarchBuffer {
  let result = finance_time_garch_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_time_garch_buffer_min(s : FinancetimegarchBuffer) -> Double { @_common.min(s.data) }

pub fn finance_time_garch_buffer_max(s : FinancetimegarchBuffer) -> Double { @_common.max(s.data) }

pub fn finance_time_garch_buffer_to_string(s : FinancetimegarchBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimegarchCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_garch_cursor_make(size : Int) -> FinancetimegarchCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_garch_cursor_len(s : FinancetimegarchCursor) -> Int { s.size }

pub fn finance_time_garch_cursor_get(s : FinancetimegarchCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_garch_cursor_set(s : FinancetimegarchCursor, i : Int, v : Double) -> FinancetimegarchCursor {
  let result = finance_time_garch_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_time_garch_cursor_sum(s : FinancetimegarchCursor) -> Double { @_common.sum(s.data) }

pub fn finance_time_garch_cursor_mean(s : FinancetimegarchCursor) -> Double { @_common.mean(s.data) }

pub fn finance_time_garch_cursor_scale(s : FinancetimegarchCursor, f : Double) -> FinancetimegarchCursor {
  let result = finance_time_garch_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_time_garch_cursor_add(a : FinancetimegarchCursor, b : FinancetimegarchCursor) -> FinancetimegarchCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_time_garch_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_time_garch_cursor_copy(s : FinancetimegarchCursor) -> FinancetimegarchCursor {
  let result = finance_time_garch_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_time_garch_cursor_fill(s : FinancetimegarchCursor, v : Double) -> FinancetimegarchCursor {
  let result = finance_time_garch_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_time_garch_cursor_min(s : FinancetimegarchCursor) -> Double { @_common.min(s.data) }

pub fn finance_time_garch_cursor_max(s : FinancetimegarchCursor) -> Double { @_common.max(s.data) }

pub fn finance_time_garch_cursor_to_string(s : FinancetimegarchCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimegarchView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_garch_view_make(size : Int) -> FinancetimegarchView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_garch_view_len(s : FinancetimegarchView) -> Int { s.size }

pub fn finance_time_garch_view_get(s : FinancetimegarchView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_garch_view_set(s : FinancetimegarchView, i : Int, v : Double) -> FinancetimegarchView {
  let result = finance_time_garch_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_time_garch_view_sum(s : FinancetimegarchView) -> Double { @_common.sum(s.data) }

pub fn finance_time_garch_view_mean(s : FinancetimegarchView) -> Double { @_common.mean(s.data) }

pub fn finance_time_garch_view_scale(s : FinancetimegarchView, f : Double) -> FinancetimegarchView {
  let result = finance_time_garch_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_time_garch_view_add(a : FinancetimegarchView, b : FinancetimegarchView) -> FinancetimegarchView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_time_garch_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_time_garch_view_copy(s : FinancetimegarchView) -> FinancetimegarchView {
  let result = finance_time_garch_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_time_garch_view_fill(s : FinancetimegarchView, v : Double) -> FinancetimegarchView {
  let result = finance_time_garch_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_time_garch_view_min(s : FinancetimegarchView) -> Double { @_common.min(s.data) }

pub fn finance_time_garch_view_max(s : FinancetimegarchView) -> Double { @_common.max(s.data) }

pub fn finance_time_garch_view_to_string(s : FinancetimegarchView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimegarchRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_garch_range_make(size : Int) -> FinancetimegarchRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_garch_range_len(s : FinancetimegarchRange) -> Int { s.size }

pub fn finance_time_garch_range_get(s : FinancetimegarchRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_garch_range_set(s : FinancetimegarchRange, i : Int, v : Double) -> FinancetimegarchRange {
  let result = finance_time_garch_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_time_garch_range_sum(s : FinancetimegarchRange) -> Double { @_common.sum(s.data) }

pub fn finance_time_garch_range_mean(s : FinancetimegarchRange) -> Double { @_common.mean(s.data) }

pub fn finance_time_garch_range_scale(s : FinancetimegarchRange, f : Double) -> FinancetimegarchRange {
  let result = finance_time_garch_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_time_garch_range_add(a : FinancetimegarchRange, b : FinancetimegarchRange) -> FinancetimegarchRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_time_garch_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_time_garch_range_copy(s : FinancetimegarchRange) -> FinancetimegarchRange {
  let result = finance_time_garch_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_time_garch_range_fill(s : FinancetimegarchRange, v : Double) -> FinancetimegarchRange {
  let result = finance_time_garch_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_time_garch_range_min(s : FinancetimegarchRange) -> Double { @_common.min(s.data) }

pub fn finance_time_garch_range_max(s : FinancetimegarchRange) -> Double { @_common.max(s.data) }

pub fn finance_time_garch_range_to_string(s : FinancetimegarchRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimegarchSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_garch_slice_make(size : Int) -> FinancetimegarchSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_garch_slice_len(s : FinancetimegarchSlice) -> Int { s.size }

pub fn finance_time_garch_slice_get(s : FinancetimegarchSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_garch_slice_set(s : FinancetimegarchSlice, i : Int, v : Double) -> FinancetimegarchSlice {
  let result = finance_time_garch_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_time_garch_slice_sum(s : FinancetimegarchSlice) -> Double { @_common.sum(s.data) }

pub fn finance_time_garch_slice_mean(s : FinancetimegarchSlice) -> Double { @_common.mean(s.data) }

pub fn finance_time_garch_slice_scale(s : FinancetimegarchSlice, f : Double) -> FinancetimegarchSlice {
  let result = finance_time_garch_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_time_garch_slice_add(a : FinancetimegarchSlice, b : FinancetimegarchSlice) -> FinancetimegarchSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_time_garch_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_time_garch_slice_copy(s : FinancetimegarchSlice) -> FinancetimegarchSlice {
  let result = finance_time_garch_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_time_garch_slice_fill(s : FinancetimegarchSlice, v : Double) -> FinancetimegarchSlice {
  let result = finance_time_garch_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_time_garch_slice_min(s : FinancetimegarchSlice) -> Double { @_common.min(s.data) }

pub fn finance_time_garch_slice_max(s : FinancetimegarchSlice) -> Double { @_common.max(s.data) }

pub fn finance_time_garch_slice_to_string(s : FinancetimegarchSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

