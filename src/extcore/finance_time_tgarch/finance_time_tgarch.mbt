///===
/// extcore/finance_time_tgarch

pub(all) struct FinancetimetgarchPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn finance_time_tgarch_make_point(x : Double, y : Double) -> FinancetimetgarchPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn finance_time_tgarch_make_point3(x : Double, y : Double, z : Double) -> FinancetimetgarchPoint {
  { x, y, z, label: 0 }
}

pub fn finance_time_tgarch_point_x(pt : FinancetimetgarchPoint) -> Double { pt.x }

pub fn finance_time_tgarch_point_y(pt : FinancetimetgarchPoint) -> Double { pt.y }

pub fn finance_time_tgarch_point_z(pt : FinancetimetgarchPoint) -> Double { pt.z }

pub fn finance_time_tgarch_point_label(pt : FinancetimetgarchPoint) -> Int { pt.label }

pub fn finance_time_tgarch_point_dist(a : FinancetimetgarchPoint, b : FinancetimetgarchPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn finance_time_tgarch_point_add(a : FinancetimetgarchPoint, b : FinancetimetgarchPoint) -> FinancetimetgarchPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn finance_time_tgarch_point_sub(a : FinancetimetgarchPoint, b : FinancetimetgarchPoint) -> FinancetimetgarchPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn finance_time_tgarch_point_scale(pt : FinancetimetgarchPoint, s : Double) -> FinancetimetgarchPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn finance_time_tgarch_point_dot(a : FinancetimetgarchPoint, b : FinancetimetgarchPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn finance_time_tgarch_point_cross(a : FinancetimetgarchPoint, b : FinancetimetgarchPoint) -> FinancetimetgarchPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn finance_time_tgarch_point_norm(pt : FinancetimetgarchPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn finance_time_tgarch_point_normalize(pt : FinancetimetgarchPoint) -> FinancetimetgarchPoint {
  let n = finance_time_tgarch_point_norm(pt)
  if n < 0.0000001 { pt } else { finance_time_tgarch_point_scale(pt, 1.0 / n) }
}

pub fn finance_time_tgarch_point_negate(pt : FinancetimetgarchPoint) -> FinancetimetgarchPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn finance_time_tgarch_point_mid(a : FinancetimetgarchPoint, b : FinancetimetgarchPoint) -> FinancetimetgarchPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn finance_time_tgarch_point_lerp(a : FinancetimetgarchPoint, b : FinancetimetgarchPoint, t : Double) -> FinancetimetgarchPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn finance_time_tgarch_point_to_string(pt : FinancetimetgarchPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct FinancetimetgarchSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn finance_time_tgarch_make_series(vals : Array[Double], name : String) -> FinancetimetgarchSeries {
  { vals, name, meta: 0 }
}

pub fn finance_time_tgarch_series_len(s : FinancetimetgarchSeries) -> Int { s.vals.length() }

pub fn finance_time_tgarch_series_sum(s : FinancetimetgarchSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn finance_time_tgarch_series_mean(s : FinancetimetgarchSeries) -> Double { @_common.mean(s.vals) }

pub fn finance_time_tgarch_series_min(s : FinancetimetgarchSeries) -> Double { @_common.min(s.vals) }

pub fn finance_time_tgarch_series_max(s : FinancetimetgarchSeries) -> Double { @_common.max(s.vals) }

pub fn finance_time_tgarch_series_range(s : FinancetimetgarchSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn finance_time_tgarch_series_var(s : FinancetimetgarchSeries) -> Double { @_common.variance(s.vals) }

pub fn finance_time_tgarch_series_std(s : FinancetimetgarchSeries) -> Double { @_common.std(s.vals) }

pub fn finance_time_tgarch_series_median(s : FinancetimetgarchSeries) -> Double { @_common.median(s.vals) }

pub fn finance_time_tgarch_series_scale(s : FinancetimetgarchSeries, f : Double) -> FinancetimetgarchSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn finance_time_tgarch_series_add(a : FinancetimetgarchSeries, b : FinancetimetgarchSeries) -> FinancetimetgarchSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn finance_time_tgarch_series_sub(a : FinancetimetgarchSeries, b : FinancetimetgarchSeries) -> FinancetimetgarchSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn finance_time_tgarch_series_normalize(s : FinancetimetgarchSeries) -> FinancetimetgarchSeries {
  let mn = finance_time_tgarch_series_min(s)
  let mx = finance_time_tgarch_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn finance_time_tgarch_series_cumsum(s : FinancetimetgarchSeries) -> FinancetimetgarchSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn finance_time_tgarch_series_to_string(s : FinancetimetgarchSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct FinancetimetgarchMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn finance_time_tgarch_make_matrix(rows : Int, cols : Int, val : Double) -> FinancetimetgarchMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn finance_time_tgarch_matrix_identity(n : Int) -> FinancetimetgarchMatrix {
  let m = finance_time_tgarch_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn finance_time_tgarch_matrix_get(m : FinancetimetgarchMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn finance_time_tgarch_matrix_transpose(m : FinancetimetgarchMatrix) -> FinancetimetgarchMatrix {
  let result = finance_time_tgarch_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn finance_time_tgarch_matrix_add(a : FinancetimetgarchMatrix, b : FinancetimetgarchMatrix) -> FinancetimetgarchMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = finance_time_tgarch_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn finance_time_tgarch_matrix_scale(m : FinancetimetgarchMatrix, s : Double) -> FinancetimetgarchMatrix {
  let result = finance_time_tgarch_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn finance_time_tgarch_matrix_multiply(a : FinancetimetgarchMatrix, b : FinancetimetgarchMatrix) -> FinancetimetgarchMatrix {
  if a.cols != b.rows { return finance_time_tgarch_make_matrix(a.rows, b.cols, 0.0) }
  let result = finance_time_tgarch_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn finance_time_tgarch_matrix_trace(m : FinancetimetgarchMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn finance_time_tgarch_matrix_det(m : FinancetimetgarchMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn finance_time_tgarch_matrix_norm(m : FinancetimetgarchMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn finance_time_tgarch_matrix_to_string(m : FinancetimetgarchMatrix) -> String {
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

pub(all) struct FinancetimetgarchVector {
  comps : Array[Double]
  dim : Int
}

pub fn finance_time_tgarch_make_vector(comps : Array[Double]) -> FinancetimetgarchVector {
  { comps, dim: comps.length() }
}

pub fn finance_time_tgarch_vector_zero(dim : Int) -> FinancetimetgarchVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn finance_time_tgarch_vector_add(a : FinancetimetgarchVector, b : FinancetimetgarchVector) -> FinancetimetgarchVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn finance_time_tgarch_vector_sub(a : FinancetimetgarchVector, b : FinancetimetgarchVector) -> FinancetimetgarchVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn finance_time_tgarch_vector_scale(v : FinancetimetgarchVector, s : Double) -> FinancetimetgarchVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn finance_time_tgarch_vector_dot(a : FinancetimetgarchVector, b : FinancetimetgarchVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn finance_time_tgarch_vector_norm(v : FinancetimetgarchVector) -> Double { @_common.sqrt(finance_time_tgarch_vector_dot(v, v)) }

pub fn finance_time_tgarch_vector_normalize(v : FinancetimetgarchVector) -> FinancetimetgarchVector {
  let n = finance_time_tgarch_vector_norm(v)
  if n < 0.0000001 { v } else { finance_time_tgarch_vector_scale(v, 1.0 / n) }
}

pub fn finance_time_tgarch_vector_dist(a : FinancetimetgarchVector, b : FinancetimetgarchVector) -> Double {
  finance_time_tgarch_vector_norm(finance_time_tgarch_vector_sub(a, b))
}

pub fn finance_time_tgarch_vector_to_string(v : FinancetimetgarchVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn finance_time_tgarch_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn finance_time_tgarch_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn finance_time_tgarch_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn finance_time_tgarch_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn finance_time_tgarch_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn finance_time_tgarch_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn finance_time_tgarch_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn finance_time_tgarch_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn finance_time_tgarch_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn finance_time_tgarch_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn finance_time_tgarch_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn finance_time_tgarch_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn finance_time_tgarch_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn finance_time_tgarch_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn finance_time_tgarch_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn finance_time_tgarch_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn finance_time_tgarch_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn finance_time_tgarch_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn finance_time_tgarch_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn finance_time_tgarch_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn finance_time_tgarch_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn finance_time_tgarch_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn finance_time_tgarch_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn finance_time_tgarch_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn finance_time_tgarch_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn finance_time_tgarch_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn finance_time_tgarch_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn finance_time_tgarch_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn finance_time_tgarch_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct FinancetimetgarchFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_tgarch_frame_make(size : Int) -> FinancetimetgarchFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_tgarch_frame_len(s : FinancetimetgarchFrame) -> Int { s.size }

pub fn finance_time_tgarch_frame_get(s : FinancetimetgarchFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_tgarch_frame_set(s : FinancetimetgarchFrame, i : Int, v : Double) -> FinancetimetgarchFrame {
  let result = finance_time_tgarch_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_time_tgarch_frame_sum(s : FinancetimetgarchFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_time_tgarch_frame_mean(s : FinancetimetgarchFrame) -> Double {
  if s.size == 0 { 0.0 } else { finance_time_tgarch_frame_sum(s) / s.size.to_double() }
}

pub fn finance_time_tgarch_frame_scale(s : FinancetimetgarchFrame, f : Double) -> FinancetimetgarchFrame {
  let result = finance_time_tgarch_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_time_tgarch_frame_add(a : FinancetimetgarchFrame, b : FinancetimetgarchFrame) -> FinancetimetgarchFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_time_tgarch_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_time_tgarch_frame_copy(s : FinancetimetgarchFrame) -> FinancetimetgarchFrame {
  let result = finance_time_tgarch_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_time_tgarch_frame_fill(s : FinancetimetgarchFrame, v : Double) -> FinancetimetgarchFrame {
  let result = finance_time_tgarch_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_time_tgarch_frame_min(s : FinancetimetgarchFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_tgarch_frame_max(s : FinancetimetgarchFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_tgarch_frame_to_string(s : FinancetimetgarchFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimetgarchTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_tgarch_table_make(size : Int) -> FinancetimetgarchTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_tgarch_table_len(s : FinancetimetgarchTable) -> Int { s.size }

pub fn finance_time_tgarch_table_get(s : FinancetimetgarchTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_tgarch_table_set(s : FinancetimetgarchTable, i : Int, v : Double) -> FinancetimetgarchTable {
  let result = finance_time_tgarch_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_time_tgarch_table_sum(s : FinancetimetgarchTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_time_tgarch_table_mean(s : FinancetimetgarchTable) -> Double {
  if s.size == 0 { 0.0 } else { finance_time_tgarch_table_sum(s) / s.size.to_double() }
}

pub fn finance_time_tgarch_table_scale(s : FinancetimetgarchTable, f : Double) -> FinancetimetgarchTable {
  let result = finance_time_tgarch_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_time_tgarch_table_add(a : FinancetimetgarchTable, b : FinancetimetgarchTable) -> FinancetimetgarchTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_time_tgarch_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_time_tgarch_table_copy(s : FinancetimetgarchTable) -> FinancetimetgarchTable {
  let result = finance_time_tgarch_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_time_tgarch_table_fill(s : FinancetimetgarchTable, v : Double) -> FinancetimetgarchTable {
  let result = finance_time_tgarch_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_time_tgarch_table_min(s : FinancetimetgarchTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_tgarch_table_max(s : FinancetimetgarchTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_tgarch_table_to_string(s : FinancetimetgarchTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimetgarchGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_tgarch_graphn_make(size : Int) -> FinancetimetgarchGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_tgarch_graphn_len(s : FinancetimetgarchGraphN) -> Int { s.size }

pub fn finance_time_tgarch_graphn_get(s : FinancetimetgarchGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_tgarch_graphn_set(s : FinancetimetgarchGraphN, i : Int, v : Double) -> FinancetimetgarchGraphN {
  let result = finance_time_tgarch_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_time_tgarch_graphn_sum(s : FinancetimetgarchGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_time_tgarch_graphn_mean(s : FinancetimetgarchGraphN) -> Double {
  if s.size == 0 { 0.0 } else { finance_time_tgarch_graphn_sum(s) / s.size.to_double() }
}

pub fn finance_time_tgarch_graphn_scale(s : FinancetimetgarchGraphN, f : Double) -> FinancetimetgarchGraphN {
  let result = finance_time_tgarch_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_time_tgarch_graphn_add(a : FinancetimetgarchGraphN, b : FinancetimetgarchGraphN) -> FinancetimetgarchGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_time_tgarch_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_time_tgarch_graphn_copy(s : FinancetimetgarchGraphN) -> FinancetimetgarchGraphN {
  let result = finance_time_tgarch_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_time_tgarch_graphn_fill(s : FinancetimetgarchGraphN, v : Double) -> FinancetimetgarchGraphN {
  let result = finance_time_tgarch_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_time_tgarch_graphn_min(s : FinancetimetgarchGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_tgarch_graphn_max(s : FinancetimetgarchGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_tgarch_graphn_to_string(s : FinancetimetgarchGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimetgarchNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_tgarch_node_make(size : Int) -> FinancetimetgarchNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_tgarch_node_len(s : FinancetimetgarchNode) -> Int { s.size }

pub fn finance_time_tgarch_node_get(s : FinancetimetgarchNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_tgarch_node_set(s : FinancetimetgarchNode, i : Int, v : Double) -> FinancetimetgarchNode {
  let result = finance_time_tgarch_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_time_tgarch_node_sum(s : FinancetimetgarchNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_time_tgarch_node_mean(s : FinancetimetgarchNode) -> Double {
  if s.size == 0 { 0.0 } else { finance_time_tgarch_node_sum(s) / s.size.to_double() }
}

pub fn finance_time_tgarch_node_scale(s : FinancetimetgarchNode, f : Double) -> FinancetimetgarchNode {
  let result = finance_time_tgarch_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_time_tgarch_node_add(a : FinancetimetgarchNode, b : FinancetimetgarchNode) -> FinancetimetgarchNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_time_tgarch_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_time_tgarch_node_copy(s : FinancetimetgarchNode) -> FinancetimetgarchNode {
  let result = finance_time_tgarch_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_time_tgarch_node_fill(s : FinancetimetgarchNode, v : Double) -> FinancetimetgarchNode {
  let result = finance_time_tgarch_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_time_tgarch_node_min(s : FinancetimetgarchNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_tgarch_node_max(s : FinancetimetgarchNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_tgarch_node_to_string(s : FinancetimetgarchNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimetgarchEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_tgarch_edge_make(size : Int) -> FinancetimetgarchEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_tgarch_edge_len(s : FinancetimetgarchEdge) -> Int { s.size }

pub fn finance_time_tgarch_edge_get(s : FinancetimetgarchEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_tgarch_edge_set(s : FinancetimetgarchEdge, i : Int, v : Double) -> FinancetimetgarchEdge {
  let result = finance_time_tgarch_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_time_tgarch_edge_sum(s : FinancetimetgarchEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_time_tgarch_edge_mean(s : FinancetimetgarchEdge) -> Double {
  if s.size == 0 { 0.0 } else { finance_time_tgarch_edge_sum(s) / s.size.to_double() }
}

pub fn finance_time_tgarch_edge_scale(s : FinancetimetgarchEdge, f : Double) -> FinancetimetgarchEdge {
  let result = finance_time_tgarch_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_time_tgarch_edge_add(a : FinancetimetgarchEdge, b : FinancetimetgarchEdge) -> FinancetimetgarchEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_time_tgarch_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_time_tgarch_edge_copy(s : FinancetimetgarchEdge) -> FinancetimetgarchEdge {
  let result = finance_time_tgarch_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_time_tgarch_edge_fill(s : FinancetimetgarchEdge, v : Double) -> FinancetimetgarchEdge {
  let result = finance_time_tgarch_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_time_tgarch_edge_min(s : FinancetimetgarchEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_tgarch_edge_max(s : FinancetimetgarchEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_tgarch_edge_to_string(s : FinancetimetgarchEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimetgarchPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_tgarch_path_make(size : Int) -> FinancetimetgarchPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_tgarch_path_len(s : FinancetimetgarchPath) -> Int { s.size }

pub fn finance_time_tgarch_path_get(s : FinancetimetgarchPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_tgarch_path_set(s : FinancetimetgarchPath, i : Int, v : Double) -> FinancetimetgarchPath {
  let result = finance_time_tgarch_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_time_tgarch_path_sum(s : FinancetimetgarchPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_time_tgarch_path_mean(s : FinancetimetgarchPath) -> Double {
  if s.size == 0 { 0.0 } else { finance_time_tgarch_path_sum(s) / s.size.to_double() }
}

pub fn finance_time_tgarch_path_scale(s : FinancetimetgarchPath, f : Double) -> FinancetimetgarchPath {
  let result = finance_time_tgarch_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_time_tgarch_path_add(a : FinancetimetgarchPath, b : FinancetimetgarchPath) -> FinancetimetgarchPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_time_tgarch_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_time_tgarch_path_copy(s : FinancetimetgarchPath) -> FinancetimetgarchPath {
  let result = finance_time_tgarch_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_time_tgarch_path_fill(s : FinancetimetgarchPath, v : Double) -> FinancetimetgarchPath {
  let result = finance_time_tgarch_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_time_tgarch_path_min(s : FinancetimetgarchPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_tgarch_path_max(s : FinancetimetgarchPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_tgarch_path_to_string(s : FinancetimetgarchPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimetgarchCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_tgarch_cluster_make(size : Int) -> FinancetimetgarchCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_tgarch_cluster_len(s : FinancetimetgarchCluster) -> Int { s.size }

pub fn finance_time_tgarch_cluster_get(s : FinancetimetgarchCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_tgarch_cluster_set(s : FinancetimetgarchCluster, i : Int, v : Double) -> FinancetimetgarchCluster {
  let result = finance_time_tgarch_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_time_tgarch_cluster_sum(s : FinancetimetgarchCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_time_tgarch_cluster_mean(s : FinancetimetgarchCluster) -> Double {
  if s.size == 0 { 0.0 } else { finance_time_tgarch_cluster_sum(s) / s.size.to_double() }
}

pub fn finance_time_tgarch_cluster_scale(s : FinancetimetgarchCluster, f : Double) -> FinancetimetgarchCluster {
  let result = finance_time_tgarch_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_time_tgarch_cluster_add(a : FinancetimetgarchCluster, b : FinancetimetgarchCluster) -> FinancetimetgarchCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_time_tgarch_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_time_tgarch_cluster_copy(s : FinancetimetgarchCluster) -> FinancetimetgarchCluster {
  let result = finance_time_tgarch_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_time_tgarch_cluster_fill(s : FinancetimetgarchCluster, v : Double) -> FinancetimetgarchCluster {
  let result = finance_time_tgarch_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_time_tgarch_cluster_min(s : FinancetimetgarchCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_tgarch_cluster_max(s : FinancetimetgarchCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_tgarch_cluster_to_string(s : FinancetimetgarchCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimetgarchModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_tgarch_model_make(size : Int) -> FinancetimetgarchModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_tgarch_model_len(s : FinancetimetgarchModel) -> Int { s.size }

pub fn finance_time_tgarch_model_get(s : FinancetimetgarchModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_tgarch_model_set(s : FinancetimetgarchModel, i : Int, v : Double) -> FinancetimetgarchModel {
  let result = finance_time_tgarch_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_time_tgarch_model_sum(s : FinancetimetgarchModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_time_tgarch_model_mean(s : FinancetimetgarchModel) -> Double {
  if s.size == 0 { 0.0 } else { finance_time_tgarch_model_sum(s) / s.size.to_double() }
}

pub fn finance_time_tgarch_model_scale(s : FinancetimetgarchModel, f : Double) -> FinancetimetgarchModel {
  let result = finance_time_tgarch_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_time_tgarch_model_add(a : FinancetimetgarchModel, b : FinancetimetgarchModel) -> FinancetimetgarchModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_time_tgarch_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_time_tgarch_model_copy(s : FinancetimetgarchModel) -> FinancetimetgarchModel {
  let result = finance_time_tgarch_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_time_tgarch_model_fill(s : FinancetimetgarchModel, v : Double) -> FinancetimetgarchModel {
  let result = finance_time_tgarch_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_time_tgarch_model_min(s : FinancetimetgarchModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_tgarch_model_max(s : FinancetimetgarchModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_tgarch_model_to_string(s : FinancetimetgarchModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimetgarchLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_tgarch_layer_make(size : Int) -> FinancetimetgarchLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_tgarch_layer_len(s : FinancetimetgarchLayer) -> Int { s.size }

pub fn finance_time_tgarch_layer_get(s : FinancetimetgarchLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_tgarch_layer_set(s : FinancetimetgarchLayer, i : Int, v : Double) -> FinancetimetgarchLayer {
  let result = finance_time_tgarch_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_time_tgarch_layer_sum(s : FinancetimetgarchLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_time_tgarch_layer_mean(s : FinancetimetgarchLayer) -> Double {
  if s.size == 0 { 0.0 } else { finance_time_tgarch_layer_sum(s) / s.size.to_double() }
}

pub fn finance_time_tgarch_layer_scale(s : FinancetimetgarchLayer, f : Double) -> FinancetimetgarchLayer {
  let result = finance_time_tgarch_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_time_tgarch_layer_add(a : FinancetimetgarchLayer, b : FinancetimetgarchLayer) -> FinancetimetgarchLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_time_tgarch_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_time_tgarch_layer_copy(s : FinancetimetgarchLayer) -> FinancetimetgarchLayer {
  let result = finance_time_tgarch_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_time_tgarch_layer_fill(s : FinancetimetgarchLayer, v : Double) -> FinancetimetgarchLayer {
  let result = finance_time_tgarch_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_time_tgarch_layer_min(s : FinancetimetgarchLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_tgarch_layer_max(s : FinancetimetgarchLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_tgarch_layer_to_string(s : FinancetimetgarchLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimetgarchBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_tgarch_buffer_make(size : Int) -> FinancetimetgarchBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_tgarch_buffer_len(s : FinancetimetgarchBuffer) -> Int { s.size }

pub fn finance_time_tgarch_buffer_get(s : FinancetimetgarchBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_tgarch_buffer_set(s : FinancetimetgarchBuffer, i : Int, v : Double) -> FinancetimetgarchBuffer {
  let result = finance_time_tgarch_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_time_tgarch_buffer_sum(s : FinancetimetgarchBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_time_tgarch_buffer_mean(s : FinancetimetgarchBuffer) -> Double {
  if s.size == 0 { 0.0 } else { finance_time_tgarch_buffer_sum(s) / s.size.to_double() }
}

pub fn finance_time_tgarch_buffer_scale(s : FinancetimetgarchBuffer, f : Double) -> FinancetimetgarchBuffer {
  let result = finance_time_tgarch_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_time_tgarch_buffer_add(a : FinancetimetgarchBuffer, b : FinancetimetgarchBuffer) -> FinancetimetgarchBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_time_tgarch_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_time_tgarch_buffer_copy(s : FinancetimetgarchBuffer) -> FinancetimetgarchBuffer {
  let result = finance_time_tgarch_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_time_tgarch_buffer_fill(s : FinancetimetgarchBuffer, v : Double) -> FinancetimetgarchBuffer {
  let result = finance_time_tgarch_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_time_tgarch_buffer_min(s : FinancetimetgarchBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_tgarch_buffer_max(s : FinancetimetgarchBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_tgarch_buffer_to_string(s : FinancetimetgarchBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimetgarchCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_tgarch_cursor_make(size : Int) -> FinancetimetgarchCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_tgarch_cursor_len(s : FinancetimetgarchCursor) -> Int { s.size }

pub fn finance_time_tgarch_cursor_get(s : FinancetimetgarchCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_tgarch_cursor_set(s : FinancetimetgarchCursor, i : Int, v : Double) -> FinancetimetgarchCursor {
  let result = finance_time_tgarch_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_time_tgarch_cursor_sum(s : FinancetimetgarchCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_time_tgarch_cursor_mean(s : FinancetimetgarchCursor) -> Double {
  if s.size == 0 { 0.0 } else { finance_time_tgarch_cursor_sum(s) / s.size.to_double() }
}

pub fn finance_time_tgarch_cursor_scale(s : FinancetimetgarchCursor, f : Double) -> FinancetimetgarchCursor {
  let result = finance_time_tgarch_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_time_tgarch_cursor_add(a : FinancetimetgarchCursor, b : FinancetimetgarchCursor) -> FinancetimetgarchCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_time_tgarch_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_time_tgarch_cursor_copy(s : FinancetimetgarchCursor) -> FinancetimetgarchCursor {
  let result = finance_time_tgarch_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_time_tgarch_cursor_fill(s : FinancetimetgarchCursor, v : Double) -> FinancetimetgarchCursor {
  let result = finance_time_tgarch_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_time_tgarch_cursor_min(s : FinancetimetgarchCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_tgarch_cursor_max(s : FinancetimetgarchCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_tgarch_cursor_to_string(s : FinancetimetgarchCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimetgarchView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_tgarch_view_make(size : Int) -> FinancetimetgarchView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_tgarch_view_len(s : FinancetimetgarchView) -> Int { s.size }

pub fn finance_time_tgarch_view_get(s : FinancetimetgarchView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_tgarch_view_set(s : FinancetimetgarchView, i : Int, v : Double) -> FinancetimetgarchView {
  let result = finance_time_tgarch_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_time_tgarch_view_sum(s : FinancetimetgarchView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_time_tgarch_view_mean(s : FinancetimetgarchView) -> Double {
  if s.size == 0 { 0.0 } else { finance_time_tgarch_view_sum(s) / s.size.to_double() }
}

pub fn finance_time_tgarch_view_scale(s : FinancetimetgarchView, f : Double) -> FinancetimetgarchView {
  let result = finance_time_tgarch_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_time_tgarch_view_add(a : FinancetimetgarchView, b : FinancetimetgarchView) -> FinancetimetgarchView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_time_tgarch_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_time_tgarch_view_copy(s : FinancetimetgarchView) -> FinancetimetgarchView {
  let result = finance_time_tgarch_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_time_tgarch_view_fill(s : FinancetimetgarchView, v : Double) -> FinancetimetgarchView {
  let result = finance_time_tgarch_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_time_tgarch_view_min(s : FinancetimetgarchView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_tgarch_view_max(s : FinancetimetgarchView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_tgarch_view_to_string(s : FinancetimetgarchView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimetgarchRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_tgarch_range_make(size : Int) -> FinancetimetgarchRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_tgarch_range_len(s : FinancetimetgarchRange) -> Int { s.size }

pub fn finance_time_tgarch_range_get(s : FinancetimetgarchRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_tgarch_range_set(s : FinancetimetgarchRange, i : Int, v : Double) -> FinancetimetgarchRange {
  let result = finance_time_tgarch_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_time_tgarch_range_sum(s : FinancetimetgarchRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_time_tgarch_range_mean(s : FinancetimetgarchRange) -> Double {
  if s.size == 0 { 0.0 } else { finance_time_tgarch_range_sum(s) / s.size.to_double() }
}

pub fn finance_time_tgarch_range_scale(s : FinancetimetgarchRange, f : Double) -> FinancetimetgarchRange {
  let result = finance_time_tgarch_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_time_tgarch_range_add(a : FinancetimetgarchRange, b : FinancetimetgarchRange) -> FinancetimetgarchRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_time_tgarch_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_time_tgarch_range_copy(s : FinancetimetgarchRange) -> FinancetimetgarchRange {
  let result = finance_time_tgarch_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_time_tgarch_range_fill(s : FinancetimetgarchRange, v : Double) -> FinancetimetgarchRange {
  let result = finance_time_tgarch_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_time_tgarch_range_min(s : FinancetimetgarchRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_tgarch_range_max(s : FinancetimetgarchRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_tgarch_range_to_string(s : FinancetimetgarchRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimetgarchSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_tgarch_slice_make(size : Int) -> FinancetimetgarchSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_tgarch_slice_len(s : FinancetimetgarchSlice) -> Int { s.size }

pub fn finance_time_tgarch_slice_get(s : FinancetimetgarchSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_tgarch_slice_set(s : FinancetimetgarchSlice, i : Int, v : Double) -> FinancetimetgarchSlice {
  let result = finance_time_tgarch_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_time_tgarch_slice_sum(s : FinancetimetgarchSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_time_tgarch_slice_mean(s : FinancetimetgarchSlice) -> Double {
  if s.size == 0 { 0.0 } else { finance_time_tgarch_slice_sum(s) / s.size.to_double() }
}

pub fn finance_time_tgarch_slice_scale(s : FinancetimetgarchSlice, f : Double) -> FinancetimetgarchSlice {
  let result = finance_time_tgarch_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_time_tgarch_slice_add(a : FinancetimetgarchSlice, b : FinancetimetgarchSlice) -> FinancetimetgarchSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_time_tgarch_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_time_tgarch_slice_copy(s : FinancetimetgarchSlice) -> FinancetimetgarchSlice {
  let result = finance_time_tgarch_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_time_tgarch_slice_fill(s : FinancetimetgarchSlice, v : Double) -> FinancetimetgarchSlice {
  let result = finance_time_tgarch_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_time_tgarch_slice_min(s : FinancetimetgarchSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_tgarch_slice_max(s : FinancetimetgarchSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_tgarch_slice_to_string(s : FinancetimetgarchSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

