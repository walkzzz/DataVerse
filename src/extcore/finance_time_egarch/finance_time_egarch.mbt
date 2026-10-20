///===
/// extcore/finance_time_egarch

pub(all) struct FinancetimeegarchPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn finance_time_egarch_make_point(x : Double, y : Double) -> FinancetimeegarchPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn finance_time_egarch_make_point3(x : Double, y : Double, z : Double) -> FinancetimeegarchPoint {
  { x, y, z, label: 0 }
}

pub fn finance_time_egarch_point_x(pt : FinancetimeegarchPoint) -> Double { pt.x }

pub fn finance_time_egarch_point_y(pt : FinancetimeegarchPoint) -> Double { pt.y }

pub fn finance_time_egarch_point_z(pt : FinancetimeegarchPoint) -> Double { pt.z }

pub fn finance_time_egarch_point_label(pt : FinancetimeegarchPoint) -> Int { pt.label }

pub fn finance_time_egarch_point_dist(a : FinancetimeegarchPoint, b : FinancetimeegarchPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn finance_time_egarch_point_add(a : FinancetimeegarchPoint, b : FinancetimeegarchPoint) -> FinancetimeegarchPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn finance_time_egarch_point_sub(a : FinancetimeegarchPoint, b : FinancetimeegarchPoint) -> FinancetimeegarchPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn finance_time_egarch_point_scale(pt : FinancetimeegarchPoint, s : Double) -> FinancetimeegarchPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn finance_time_egarch_point_dot(a : FinancetimeegarchPoint, b : FinancetimeegarchPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn finance_time_egarch_point_cross(a : FinancetimeegarchPoint, b : FinancetimeegarchPoint) -> FinancetimeegarchPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn finance_time_egarch_point_norm(pt : FinancetimeegarchPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn finance_time_egarch_point_normalize(pt : FinancetimeegarchPoint) -> FinancetimeegarchPoint {
  let n = finance_time_egarch_point_norm(pt)
  if n < 0.0000001 { pt } else { finance_time_egarch_point_scale(pt, 1.0 / n) }
}

pub fn finance_time_egarch_point_negate(pt : FinancetimeegarchPoint) -> FinancetimeegarchPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn finance_time_egarch_point_mid(a : FinancetimeegarchPoint, b : FinancetimeegarchPoint) -> FinancetimeegarchPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn finance_time_egarch_point_lerp(a : FinancetimeegarchPoint, b : FinancetimeegarchPoint, t : Double) -> FinancetimeegarchPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn finance_time_egarch_point_to_string(pt : FinancetimeegarchPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct FinancetimeegarchSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn finance_time_egarch_make_series(vals : Array[Double], name : String) -> FinancetimeegarchSeries {
  { vals, name, meta: 0 }
}

pub fn finance_time_egarch_series_len(s : FinancetimeegarchSeries) -> Int { s.vals.length() }

pub fn finance_time_egarch_series_sum(s : FinancetimeegarchSeries) -> Double { @_common.sum(s.vals) }

pub fn finance_time_egarch_series_mean(s : FinancetimeegarchSeries) -> Double { @_common.mean(s.vals) }

pub fn finance_time_egarch_series_min(s : FinancetimeegarchSeries) -> Double { @_common.min(s.vals) }

pub fn finance_time_egarch_series_max(s : FinancetimeegarchSeries) -> Double { @_common.max(s.vals) }

pub fn finance_time_egarch_series_range(s : FinancetimeegarchSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn finance_time_egarch_series_var(s : FinancetimeegarchSeries) -> Double { @_common.variance(s.vals) }

pub fn finance_time_egarch_series_std(s : FinancetimeegarchSeries) -> Double { @_common.std(s.vals) }

pub fn finance_time_egarch_series_median(s : FinancetimeegarchSeries) -> Double { @_common.median(s.vals) }

pub fn finance_time_egarch_series_scale(s : FinancetimeegarchSeries, f : Double) -> FinancetimeegarchSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn finance_time_egarch_series_add(a : FinancetimeegarchSeries, b : FinancetimeegarchSeries) -> FinancetimeegarchSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn finance_time_egarch_series_sub(a : FinancetimeegarchSeries, b : FinancetimeegarchSeries) -> FinancetimeegarchSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn finance_time_egarch_series_normalize(s : FinancetimeegarchSeries) -> FinancetimeegarchSeries {
  let mn = finance_time_egarch_series_min(s)
  let mx = finance_time_egarch_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn finance_time_egarch_series_cumsum(s : FinancetimeegarchSeries) -> FinancetimeegarchSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn finance_time_egarch_series_to_string(s : FinancetimeegarchSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct FinancetimeegarchMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn finance_time_egarch_make_matrix(rows : Int, cols : Int, val : Double) -> FinancetimeegarchMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn finance_time_egarch_matrix_identity(n : Int) -> FinancetimeegarchMatrix {
  let m = finance_time_egarch_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn finance_time_egarch_matrix_get(m : FinancetimeegarchMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn finance_time_egarch_matrix_transpose(m : FinancetimeegarchMatrix) -> FinancetimeegarchMatrix {
  let result = finance_time_egarch_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn finance_time_egarch_matrix_add(a : FinancetimeegarchMatrix, b : FinancetimeegarchMatrix) -> FinancetimeegarchMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = finance_time_egarch_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn finance_time_egarch_matrix_scale(m : FinancetimeegarchMatrix, s : Double) -> FinancetimeegarchMatrix {
  let result = finance_time_egarch_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn finance_time_egarch_matrix_multiply(a : FinancetimeegarchMatrix, b : FinancetimeegarchMatrix) -> FinancetimeegarchMatrix {
  if a.cols != b.rows { return finance_time_egarch_make_matrix(a.rows, b.cols, 0.0) }
  let result = finance_time_egarch_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn finance_time_egarch_matrix_trace(m : FinancetimeegarchMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn finance_time_egarch_matrix_det(m : FinancetimeegarchMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn finance_time_egarch_matrix_norm(m : FinancetimeegarchMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn finance_time_egarch_matrix_to_string(m : FinancetimeegarchMatrix) -> String {
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

pub(all) struct FinancetimeegarchVector {
  comps : Array[Double]
  dim : Int
}

pub fn finance_time_egarch_make_vector(comps : Array[Double]) -> FinancetimeegarchVector {
  { comps, dim: comps.length() }
}

pub fn finance_time_egarch_vector_zero(dim : Int) -> FinancetimeegarchVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn finance_time_egarch_vector_add(a : FinancetimeegarchVector, b : FinancetimeegarchVector) -> FinancetimeegarchVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn finance_time_egarch_vector_sub(a : FinancetimeegarchVector, b : FinancetimeegarchVector) -> FinancetimeegarchVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn finance_time_egarch_vector_scale(v : FinancetimeegarchVector, s : Double) -> FinancetimeegarchVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn finance_time_egarch_vector_dot(a : FinancetimeegarchVector, b : FinancetimeegarchVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn finance_time_egarch_vector_norm(v : FinancetimeegarchVector) -> Double { @_common.sqrt(finance_time_egarch_vector_dot(v, v)) }

pub fn finance_time_egarch_vector_normalize(v : FinancetimeegarchVector) -> FinancetimeegarchVector {
  let n = finance_time_egarch_vector_norm(v)
  if n < 0.0000001 { v } else { finance_time_egarch_vector_scale(v, 1.0 / n) }
}

pub fn finance_time_egarch_vector_dist(a : FinancetimeegarchVector, b : FinancetimeegarchVector) -> Double {
  finance_time_egarch_vector_norm(finance_time_egarch_vector_sub(a, b))
}

pub fn finance_time_egarch_vector_to_string(v : FinancetimeegarchVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn finance_time_egarch_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn finance_time_egarch_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn finance_time_egarch_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn finance_time_egarch_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn finance_time_egarch_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn finance_time_egarch_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn finance_time_egarch_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn finance_time_egarch_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn finance_time_egarch_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn finance_time_egarch_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn finance_time_egarch_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn finance_time_egarch_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn finance_time_egarch_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn finance_time_egarch_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn finance_time_egarch_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn finance_time_egarch_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn finance_time_egarch_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn finance_time_egarch_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn finance_time_egarch_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn finance_time_egarch_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn finance_time_egarch_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn finance_time_egarch_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn finance_time_egarch_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn finance_time_egarch_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn finance_time_egarch_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn finance_time_egarch_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn finance_time_egarch_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn finance_time_egarch_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn finance_time_egarch_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct FinancetimeegarchFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_egarch_frame_make(size : Int) -> FinancetimeegarchFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_egarch_frame_len(s : FinancetimeegarchFrame) -> Int { s.size }

pub fn finance_time_egarch_frame_get(s : FinancetimeegarchFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_egarch_frame_set(s : FinancetimeegarchFrame, i : Int, v : Double) -> FinancetimeegarchFrame {
  let result = finance_time_egarch_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_time_egarch_frame_sum(s : FinancetimeegarchFrame) -> Double { @_common.sum(s.data) }

pub fn finance_time_egarch_frame_mean(s : FinancetimeegarchFrame) -> Double { @_common.mean(s.data) }

pub fn finance_time_egarch_frame_scale(s : FinancetimeegarchFrame, f : Double) -> FinancetimeegarchFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_time_egarch_frame_add(a : FinancetimeegarchFrame, b : FinancetimeegarchFrame) -> FinancetimeegarchFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_time_egarch_frame_copy(s : FinancetimeegarchFrame) -> FinancetimeegarchFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_time_egarch_frame_fill(s : FinancetimeegarchFrame, v : Double) -> FinancetimeegarchFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_time_egarch_frame_min(s : FinancetimeegarchFrame) -> Double { @_common.min(s.data) }

pub fn finance_time_egarch_frame_max(s : FinancetimeegarchFrame) -> Double { @_common.max(s.data) }

pub fn finance_time_egarch_frame_to_string(s : FinancetimeegarchFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimeegarchTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_egarch_table_make(size : Int) -> FinancetimeegarchTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_egarch_table_len(s : FinancetimeegarchTable) -> Int { s.size }

pub fn finance_time_egarch_table_get(s : FinancetimeegarchTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_egarch_table_set(s : FinancetimeegarchTable, i : Int, v : Double) -> FinancetimeegarchTable {
  let result = finance_time_egarch_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_time_egarch_table_sum(s : FinancetimeegarchTable) -> Double { @_common.sum(s.data) }

pub fn finance_time_egarch_table_mean(s : FinancetimeegarchTable) -> Double { @_common.mean(s.data) }

pub fn finance_time_egarch_table_scale(s : FinancetimeegarchTable, f : Double) -> FinancetimeegarchTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_time_egarch_table_add(a : FinancetimeegarchTable, b : FinancetimeegarchTable) -> FinancetimeegarchTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_time_egarch_table_copy(s : FinancetimeegarchTable) -> FinancetimeegarchTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_time_egarch_table_fill(s : FinancetimeegarchTable, v : Double) -> FinancetimeegarchTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_time_egarch_table_min(s : FinancetimeegarchTable) -> Double { @_common.min(s.data) }

pub fn finance_time_egarch_table_max(s : FinancetimeegarchTable) -> Double { @_common.max(s.data) }

pub fn finance_time_egarch_table_to_string(s : FinancetimeegarchTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimeegarchGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_egarch_graphn_make(size : Int) -> FinancetimeegarchGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_egarch_graphn_len(s : FinancetimeegarchGraphN) -> Int { s.size }

pub fn finance_time_egarch_graphn_get(s : FinancetimeegarchGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_egarch_graphn_set(s : FinancetimeegarchGraphN, i : Int, v : Double) -> FinancetimeegarchGraphN {
  let result = finance_time_egarch_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_time_egarch_graphn_sum(s : FinancetimeegarchGraphN) -> Double { @_common.sum(s.data) }

pub fn finance_time_egarch_graphn_mean(s : FinancetimeegarchGraphN) -> Double { @_common.mean(s.data) }

pub fn finance_time_egarch_graphn_scale(s : FinancetimeegarchGraphN, f : Double) -> FinancetimeegarchGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_time_egarch_graphn_add(a : FinancetimeegarchGraphN, b : FinancetimeegarchGraphN) -> FinancetimeegarchGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_time_egarch_graphn_copy(s : FinancetimeegarchGraphN) -> FinancetimeegarchGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_time_egarch_graphn_fill(s : FinancetimeegarchGraphN, v : Double) -> FinancetimeegarchGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_time_egarch_graphn_min(s : FinancetimeegarchGraphN) -> Double { @_common.min(s.data) }

pub fn finance_time_egarch_graphn_max(s : FinancetimeegarchGraphN) -> Double { @_common.max(s.data) }

pub fn finance_time_egarch_graphn_to_string(s : FinancetimeegarchGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimeegarchNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_egarch_node_make(size : Int) -> FinancetimeegarchNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_egarch_node_len(s : FinancetimeegarchNode) -> Int { s.size }

pub fn finance_time_egarch_node_get(s : FinancetimeegarchNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_egarch_node_set(s : FinancetimeegarchNode, i : Int, v : Double) -> FinancetimeegarchNode {
  let result = finance_time_egarch_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_time_egarch_node_sum(s : FinancetimeegarchNode) -> Double { @_common.sum(s.data) }

pub fn finance_time_egarch_node_mean(s : FinancetimeegarchNode) -> Double { @_common.mean(s.data) }

pub fn finance_time_egarch_node_scale(s : FinancetimeegarchNode, f : Double) -> FinancetimeegarchNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_time_egarch_node_add(a : FinancetimeegarchNode, b : FinancetimeegarchNode) -> FinancetimeegarchNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_time_egarch_node_copy(s : FinancetimeegarchNode) -> FinancetimeegarchNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_time_egarch_node_fill(s : FinancetimeegarchNode, v : Double) -> FinancetimeegarchNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_time_egarch_node_min(s : FinancetimeegarchNode) -> Double { @_common.min(s.data) }

pub fn finance_time_egarch_node_max(s : FinancetimeegarchNode) -> Double { @_common.max(s.data) }

pub fn finance_time_egarch_node_to_string(s : FinancetimeegarchNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimeegarchEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_egarch_edge_make(size : Int) -> FinancetimeegarchEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_egarch_edge_len(s : FinancetimeegarchEdge) -> Int { s.size }

pub fn finance_time_egarch_edge_get(s : FinancetimeegarchEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_egarch_edge_set(s : FinancetimeegarchEdge, i : Int, v : Double) -> FinancetimeegarchEdge {
  let result = finance_time_egarch_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_time_egarch_edge_sum(s : FinancetimeegarchEdge) -> Double { @_common.sum(s.data) }

pub fn finance_time_egarch_edge_mean(s : FinancetimeegarchEdge) -> Double { @_common.mean(s.data) }

pub fn finance_time_egarch_edge_scale(s : FinancetimeegarchEdge, f : Double) -> FinancetimeegarchEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_time_egarch_edge_add(a : FinancetimeegarchEdge, b : FinancetimeegarchEdge) -> FinancetimeegarchEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_time_egarch_edge_copy(s : FinancetimeegarchEdge) -> FinancetimeegarchEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_time_egarch_edge_fill(s : FinancetimeegarchEdge, v : Double) -> FinancetimeegarchEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_time_egarch_edge_min(s : FinancetimeegarchEdge) -> Double { @_common.min(s.data) }

pub fn finance_time_egarch_edge_max(s : FinancetimeegarchEdge) -> Double { @_common.max(s.data) }

pub fn finance_time_egarch_edge_to_string(s : FinancetimeegarchEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimeegarchPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_egarch_path_make(size : Int) -> FinancetimeegarchPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_egarch_path_len(s : FinancetimeegarchPath) -> Int { s.size }

pub fn finance_time_egarch_path_get(s : FinancetimeegarchPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_egarch_path_set(s : FinancetimeegarchPath, i : Int, v : Double) -> FinancetimeegarchPath {
  let result = finance_time_egarch_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_time_egarch_path_sum(s : FinancetimeegarchPath) -> Double { @_common.sum(s.data) }

pub fn finance_time_egarch_path_mean(s : FinancetimeegarchPath) -> Double { @_common.mean(s.data) }

pub fn finance_time_egarch_path_scale(s : FinancetimeegarchPath, f : Double) -> FinancetimeegarchPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_time_egarch_path_add(a : FinancetimeegarchPath, b : FinancetimeegarchPath) -> FinancetimeegarchPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_time_egarch_path_copy(s : FinancetimeegarchPath) -> FinancetimeegarchPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_time_egarch_path_fill(s : FinancetimeegarchPath, v : Double) -> FinancetimeegarchPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_time_egarch_path_min(s : FinancetimeegarchPath) -> Double { @_common.min(s.data) }

pub fn finance_time_egarch_path_max(s : FinancetimeegarchPath) -> Double { @_common.max(s.data) }

pub fn finance_time_egarch_path_to_string(s : FinancetimeegarchPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimeegarchCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_egarch_cluster_make(size : Int) -> FinancetimeegarchCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_egarch_cluster_len(s : FinancetimeegarchCluster) -> Int { s.size }

pub fn finance_time_egarch_cluster_get(s : FinancetimeegarchCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_egarch_cluster_set(s : FinancetimeegarchCluster, i : Int, v : Double) -> FinancetimeegarchCluster {
  let result = finance_time_egarch_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_time_egarch_cluster_sum(s : FinancetimeegarchCluster) -> Double { @_common.sum(s.data) }

pub fn finance_time_egarch_cluster_mean(s : FinancetimeegarchCluster) -> Double { @_common.mean(s.data) }

pub fn finance_time_egarch_cluster_scale(s : FinancetimeegarchCluster, f : Double) -> FinancetimeegarchCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_time_egarch_cluster_add(a : FinancetimeegarchCluster, b : FinancetimeegarchCluster) -> FinancetimeegarchCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_time_egarch_cluster_copy(s : FinancetimeegarchCluster) -> FinancetimeegarchCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_time_egarch_cluster_fill(s : FinancetimeegarchCluster, v : Double) -> FinancetimeegarchCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_time_egarch_cluster_min(s : FinancetimeegarchCluster) -> Double { @_common.min(s.data) }

pub fn finance_time_egarch_cluster_max(s : FinancetimeegarchCluster) -> Double { @_common.max(s.data) }

pub fn finance_time_egarch_cluster_to_string(s : FinancetimeegarchCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimeegarchModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_egarch_model_make(size : Int) -> FinancetimeegarchModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_egarch_model_len(s : FinancetimeegarchModel) -> Int { s.size }

pub fn finance_time_egarch_model_get(s : FinancetimeegarchModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_egarch_model_set(s : FinancetimeegarchModel, i : Int, v : Double) -> FinancetimeegarchModel {
  let result = finance_time_egarch_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_time_egarch_model_sum(s : FinancetimeegarchModel) -> Double { @_common.sum(s.data) }

pub fn finance_time_egarch_model_mean(s : FinancetimeegarchModel) -> Double { @_common.mean(s.data) }

pub fn finance_time_egarch_model_scale(s : FinancetimeegarchModel, f : Double) -> FinancetimeegarchModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_time_egarch_model_add(a : FinancetimeegarchModel, b : FinancetimeegarchModel) -> FinancetimeegarchModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_time_egarch_model_copy(s : FinancetimeegarchModel) -> FinancetimeegarchModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_time_egarch_model_fill(s : FinancetimeegarchModel, v : Double) -> FinancetimeegarchModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_time_egarch_model_min(s : FinancetimeegarchModel) -> Double { @_common.min(s.data) }

pub fn finance_time_egarch_model_max(s : FinancetimeegarchModel) -> Double { @_common.max(s.data) }

pub fn finance_time_egarch_model_to_string(s : FinancetimeegarchModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimeegarchLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_egarch_layer_make(size : Int) -> FinancetimeegarchLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_egarch_layer_len(s : FinancetimeegarchLayer) -> Int { s.size }

pub fn finance_time_egarch_layer_get(s : FinancetimeegarchLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_egarch_layer_set(s : FinancetimeegarchLayer, i : Int, v : Double) -> FinancetimeegarchLayer {
  let result = finance_time_egarch_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_time_egarch_layer_sum(s : FinancetimeegarchLayer) -> Double { @_common.sum(s.data) }

pub fn finance_time_egarch_layer_mean(s : FinancetimeegarchLayer) -> Double { @_common.mean(s.data) }

pub fn finance_time_egarch_layer_scale(s : FinancetimeegarchLayer, f : Double) -> FinancetimeegarchLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_time_egarch_layer_add(a : FinancetimeegarchLayer, b : FinancetimeegarchLayer) -> FinancetimeegarchLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_time_egarch_layer_copy(s : FinancetimeegarchLayer) -> FinancetimeegarchLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_time_egarch_layer_fill(s : FinancetimeegarchLayer, v : Double) -> FinancetimeegarchLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_time_egarch_layer_min(s : FinancetimeegarchLayer) -> Double { @_common.min(s.data) }

pub fn finance_time_egarch_layer_max(s : FinancetimeegarchLayer) -> Double { @_common.max(s.data) }

pub fn finance_time_egarch_layer_to_string(s : FinancetimeegarchLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimeegarchBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_egarch_buffer_make(size : Int) -> FinancetimeegarchBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_egarch_buffer_len(s : FinancetimeegarchBuffer) -> Int { s.size }

pub fn finance_time_egarch_buffer_get(s : FinancetimeegarchBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_egarch_buffer_set(s : FinancetimeegarchBuffer, i : Int, v : Double) -> FinancetimeegarchBuffer {
  let result = finance_time_egarch_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_time_egarch_buffer_sum(s : FinancetimeegarchBuffer) -> Double { @_common.sum(s.data) }

pub fn finance_time_egarch_buffer_mean(s : FinancetimeegarchBuffer) -> Double { @_common.mean(s.data) }

pub fn finance_time_egarch_buffer_scale(s : FinancetimeegarchBuffer, f : Double) -> FinancetimeegarchBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_time_egarch_buffer_add(a : FinancetimeegarchBuffer, b : FinancetimeegarchBuffer) -> FinancetimeegarchBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_time_egarch_buffer_copy(s : FinancetimeegarchBuffer) -> FinancetimeegarchBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_time_egarch_buffer_fill(s : FinancetimeegarchBuffer, v : Double) -> FinancetimeegarchBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_time_egarch_buffer_min(s : FinancetimeegarchBuffer) -> Double { @_common.min(s.data) }

pub fn finance_time_egarch_buffer_max(s : FinancetimeegarchBuffer) -> Double { @_common.max(s.data) }

pub fn finance_time_egarch_buffer_to_string(s : FinancetimeegarchBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimeegarchCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_egarch_cursor_make(size : Int) -> FinancetimeegarchCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_egarch_cursor_len(s : FinancetimeegarchCursor) -> Int { s.size }

pub fn finance_time_egarch_cursor_get(s : FinancetimeegarchCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_egarch_cursor_set(s : FinancetimeegarchCursor, i : Int, v : Double) -> FinancetimeegarchCursor {
  let result = finance_time_egarch_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_time_egarch_cursor_sum(s : FinancetimeegarchCursor) -> Double { @_common.sum(s.data) }

pub fn finance_time_egarch_cursor_mean(s : FinancetimeegarchCursor) -> Double { @_common.mean(s.data) }

pub fn finance_time_egarch_cursor_scale(s : FinancetimeegarchCursor, f : Double) -> FinancetimeegarchCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_time_egarch_cursor_add(a : FinancetimeegarchCursor, b : FinancetimeegarchCursor) -> FinancetimeegarchCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_time_egarch_cursor_copy(s : FinancetimeegarchCursor) -> FinancetimeegarchCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_time_egarch_cursor_fill(s : FinancetimeegarchCursor, v : Double) -> FinancetimeegarchCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_time_egarch_cursor_min(s : FinancetimeegarchCursor) -> Double { @_common.min(s.data) }

pub fn finance_time_egarch_cursor_max(s : FinancetimeegarchCursor) -> Double { @_common.max(s.data) }

pub fn finance_time_egarch_cursor_to_string(s : FinancetimeegarchCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimeegarchView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_egarch_view_make(size : Int) -> FinancetimeegarchView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_egarch_view_len(s : FinancetimeegarchView) -> Int { s.size }

pub fn finance_time_egarch_view_get(s : FinancetimeegarchView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_egarch_view_set(s : FinancetimeegarchView, i : Int, v : Double) -> FinancetimeegarchView {
  let result = finance_time_egarch_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_time_egarch_view_sum(s : FinancetimeegarchView) -> Double { @_common.sum(s.data) }

pub fn finance_time_egarch_view_mean(s : FinancetimeegarchView) -> Double { @_common.mean(s.data) }

pub fn finance_time_egarch_view_scale(s : FinancetimeegarchView, f : Double) -> FinancetimeegarchView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_time_egarch_view_add(a : FinancetimeegarchView, b : FinancetimeegarchView) -> FinancetimeegarchView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_time_egarch_view_copy(s : FinancetimeegarchView) -> FinancetimeegarchView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_time_egarch_view_fill(s : FinancetimeegarchView, v : Double) -> FinancetimeegarchView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_time_egarch_view_min(s : FinancetimeegarchView) -> Double { @_common.min(s.data) }

pub fn finance_time_egarch_view_max(s : FinancetimeegarchView) -> Double { @_common.max(s.data) }

pub fn finance_time_egarch_view_to_string(s : FinancetimeegarchView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimeegarchRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_egarch_range_make(size : Int) -> FinancetimeegarchRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_egarch_range_len(s : FinancetimeegarchRange) -> Int { s.size }

pub fn finance_time_egarch_range_get(s : FinancetimeegarchRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_egarch_range_set(s : FinancetimeegarchRange, i : Int, v : Double) -> FinancetimeegarchRange {
  let result = finance_time_egarch_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_time_egarch_range_sum(s : FinancetimeegarchRange) -> Double { @_common.sum(s.data) }

pub fn finance_time_egarch_range_mean(s : FinancetimeegarchRange) -> Double { @_common.mean(s.data) }

pub fn finance_time_egarch_range_scale(s : FinancetimeegarchRange, f : Double) -> FinancetimeegarchRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_time_egarch_range_add(a : FinancetimeegarchRange, b : FinancetimeegarchRange) -> FinancetimeegarchRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_time_egarch_range_copy(s : FinancetimeegarchRange) -> FinancetimeegarchRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_time_egarch_range_fill(s : FinancetimeegarchRange, v : Double) -> FinancetimeegarchRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_time_egarch_range_min(s : FinancetimeegarchRange) -> Double { @_common.min(s.data) }

pub fn finance_time_egarch_range_max(s : FinancetimeegarchRange) -> Double { @_common.max(s.data) }

pub fn finance_time_egarch_range_to_string(s : FinancetimeegarchRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimeegarchSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_egarch_slice_make(size : Int) -> FinancetimeegarchSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_egarch_slice_len(s : FinancetimeegarchSlice) -> Int { s.size }

pub fn finance_time_egarch_slice_get(s : FinancetimeegarchSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_egarch_slice_set(s : FinancetimeegarchSlice, i : Int, v : Double) -> FinancetimeegarchSlice {
  let result = finance_time_egarch_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_time_egarch_slice_sum(s : FinancetimeegarchSlice) -> Double { @_common.sum(s.data) }

pub fn finance_time_egarch_slice_mean(s : FinancetimeegarchSlice) -> Double { @_common.mean(s.data) }

pub fn finance_time_egarch_slice_scale(s : FinancetimeegarchSlice, f : Double) -> FinancetimeegarchSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_time_egarch_slice_add(a : FinancetimeegarchSlice, b : FinancetimeegarchSlice) -> FinancetimeegarchSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_time_egarch_slice_copy(s : FinancetimeegarchSlice) -> FinancetimeegarchSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_time_egarch_slice_fill(s : FinancetimeegarchSlice, v : Double) -> FinancetimeegarchSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_time_egarch_slice_min(s : FinancetimeegarchSlice) -> Double { @_common.min(s.data) }

pub fn finance_time_egarch_slice_max(s : FinancetimeegarchSlice) -> Double { @_common.max(s.data) }

pub fn finance_time_egarch_slice_to_string(s : FinancetimeegarchSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

