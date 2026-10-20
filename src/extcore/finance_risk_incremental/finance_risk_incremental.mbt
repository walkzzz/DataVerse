///===
/// extcore/finance_risk_incremental

pub(all) struct FinanceriskincrementalPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn finance_risk_incremental_make_point(x : Double, y : Double) -> FinanceriskincrementalPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn finance_risk_incremental_make_point3(x : Double, y : Double, z : Double) -> FinanceriskincrementalPoint {
  { x, y, z, label: 0 }
}

pub fn finance_risk_incremental_point_x(pt : FinanceriskincrementalPoint) -> Double { pt.x }

pub fn finance_risk_incremental_point_y(pt : FinanceriskincrementalPoint) -> Double { pt.y }

pub fn finance_risk_incremental_point_z(pt : FinanceriskincrementalPoint) -> Double { pt.z }

pub fn finance_risk_incremental_point_label(pt : FinanceriskincrementalPoint) -> Int { pt.label }

pub fn finance_risk_incremental_point_dist(a : FinanceriskincrementalPoint, b : FinanceriskincrementalPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn finance_risk_incremental_point_add(a : FinanceriskincrementalPoint, b : FinanceriskincrementalPoint) -> FinanceriskincrementalPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn finance_risk_incremental_point_sub(a : FinanceriskincrementalPoint, b : FinanceriskincrementalPoint) -> FinanceriskincrementalPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn finance_risk_incremental_point_scale(pt : FinanceriskincrementalPoint, s : Double) -> FinanceriskincrementalPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn finance_risk_incremental_point_dot(a : FinanceriskincrementalPoint, b : FinanceriskincrementalPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn finance_risk_incremental_point_cross(a : FinanceriskincrementalPoint, b : FinanceriskincrementalPoint) -> FinanceriskincrementalPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn finance_risk_incremental_point_norm(pt : FinanceriskincrementalPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn finance_risk_incremental_point_normalize(pt : FinanceriskincrementalPoint) -> FinanceriskincrementalPoint {
  let n = finance_risk_incremental_point_norm(pt)
  if n < 0.0000001 { pt } else { finance_risk_incremental_point_scale(pt, 1.0 / n) }
}

pub fn finance_risk_incremental_point_negate(pt : FinanceriskincrementalPoint) -> FinanceriskincrementalPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn finance_risk_incremental_point_mid(a : FinanceriskincrementalPoint, b : FinanceriskincrementalPoint) -> FinanceriskincrementalPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn finance_risk_incremental_point_lerp(a : FinanceriskincrementalPoint, b : FinanceriskincrementalPoint, t : Double) -> FinanceriskincrementalPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn finance_risk_incremental_point_to_string(pt : FinanceriskincrementalPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct FinanceriskincrementalSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn finance_risk_incremental_make_series(vals : Array[Double], name : String) -> FinanceriskincrementalSeries {
  { vals, name, meta: 0 }
}

pub fn finance_risk_incremental_series_len(s : FinanceriskincrementalSeries) -> Int { s.vals.length() }

pub fn finance_risk_incremental_series_sum(s : FinanceriskincrementalSeries) -> Double { @_common.sum(s.vals) }

pub fn finance_risk_incremental_series_mean(s : FinanceriskincrementalSeries) -> Double { @_common.mean(s.vals) }

pub fn finance_risk_incremental_series_min(s : FinanceriskincrementalSeries) -> Double { @_common.min(s.vals) }

pub fn finance_risk_incremental_series_max(s : FinanceriskincrementalSeries) -> Double { @_common.max(s.vals) }

pub fn finance_risk_incremental_series_range(s : FinanceriskincrementalSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn finance_risk_incremental_series_var(s : FinanceriskincrementalSeries) -> Double { @_common.variance(s.vals) }

pub fn finance_risk_incremental_series_std(s : FinanceriskincrementalSeries) -> Double { @_common.std(s.vals) }

pub fn finance_risk_incremental_series_median(s : FinanceriskincrementalSeries) -> Double { @_common.median(s.vals) }

pub fn finance_risk_incremental_series_scale(s : FinanceriskincrementalSeries, f : Double) -> FinanceriskincrementalSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn finance_risk_incremental_series_add(a : FinanceriskincrementalSeries, b : FinanceriskincrementalSeries) -> FinanceriskincrementalSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn finance_risk_incremental_series_sub(a : FinanceriskincrementalSeries, b : FinanceriskincrementalSeries) -> FinanceriskincrementalSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn finance_risk_incremental_series_normalize(s : FinanceriskincrementalSeries) -> FinanceriskincrementalSeries {
  let mn = finance_risk_incremental_series_min(s)
  let mx = finance_risk_incremental_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn finance_risk_incremental_series_cumsum(s : FinanceriskincrementalSeries) -> FinanceriskincrementalSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn finance_risk_incremental_series_to_string(s : FinanceriskincrementalSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct FinanceriskincrementalMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn finance_risk_incremental_make_matrix(rows : Int, cols : Int, val : Double) -> FinanceriskincrementalMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn finance_risk_incremental_matrix_identity(n : Int) -> FinanceriskincrementalMatrix {
  let m = finance_risk_incremental_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn finance_risk_incremental_matrix_get(m : FinanceriskincrementalMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn finance_risk_incremental_matrix_transpose(m : FinanceriskincrementalMatrix) -> FinanceriskincrementalMatrix {
  let result = finance_risk_incremental_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn finance_risk_incremental_matrix_add(a : FinanceriskincrementalMatrix, b : FinanceriskincrementalMatrix) -> FinanceriskincrementalMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = finance_risk_incremental_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn finance_risk_incremental_matrix_scale(m : FinanceriskincrementalMatrix, s : Double) -> FinanceriskincrementalMatrix {
  let result = finance_risk_incremental_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn finance_risk_incremental_matrix_multiply(a : FinanceriskincrementalMatrix, b : FinanceriskincrementalMatrix) -> FinanceriskincrementalMatrix {
  if a.cols != b.rows { return finance_risk_incremental_make_matrix(a.rows, b.cols, 0.0) }
  let result = finance_risk_incremental_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn finance_risk_incremental_matrix_trace(m : FinanceriskincrementalMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn finance_risk_incremental_matrix_det(m : FinanceriskincrementalMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn finance_risk_incremental_matrix_norm(m : FinanceriskincrementalMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn finance_risk_incremental_matrix_to_string(m : FinanceriskincrementalMatrix) -> String {
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

pub(all) struct FinanceriskincrementalVector {
  comps : Array[Double]
  dim : Int
}

pub fn finance_risk_incremental_make_vector(comps : Array[Double]) -> FinanceriskincrementalVector {
  { comps, dim: comps.length() }
}

pub fn finance_risk_incremental_vector_zero(dim : Int) -> FinanceriskincrementalVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn finance_risk_incremental_vector_add(a : FinanceriskincrementalVector, b : FinanceriskincrementalVector) -> FinanceriskincrementalVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn finance_risk_incremental_vector_sub(a : FinanceriskincrementalVector, b : FinanceriskincrementalVector) -> FinanceriskincrementalVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn finance_risk_incremental_vector_scale(v : FinanceriskincrementalVector, s : Double) -> FinanceriskincrementalVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn finance_risk_incremental_vector_dot(a : FinanceriskincrementalVector, b : FinanceriskincrementalVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn finance_risk_incremental_vector_norm(v : FinanceriskincrementalVector) -> Double { @_common.sqrt(finance_risk_incremental_vector_dot(v, v)) }

pub fn finance_risk_incremental_vector_normalize(v : FinanceriskincrementalVector) -> FinanceriskincrementalVector {
  let n = finance_risk_incremental_vector_norm(v)
  if n < 0.0000001 { v } else { finance_risk_incremental_vector_scale(v, 1.0 / n) }
}

pub fn finance_risk_incremental_vector_dist(a : FinanceriskincrementalVector, b : FinanceriskincrementalVector) -> Double {
  finance_risk_incremental_vector_norm(finance_risk_incremental_vector_sub(a, b))
}

pub fn finance_risk_incremental_vector_to_string(v : FinanceriskincrementalVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn finance_risk_incremental_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn finance_risk_incremental_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn finance_risk_incremental_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn finance_risk_incremental_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn finance_risk_incremental_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn finance_risk_incremental_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn finance_risk_incremental_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn finance_risk_incremental_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn finance_risk_incremental_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn finance_risk_incremental_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn finance_risk_incremental_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn finance_risk_incremental_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn finance_risk_incremental_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn finance_risk_incremental_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn finance_risk_incremental_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn finance_risk_incremental_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn finance_risk_incremental_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn finance_risk_incremental_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn finance_risk_incremental_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn finance_risk_incremental_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn finance_risk_incremental_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn finance_risk_incremental_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn finance_risk_incremental_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn finance_risk_incremental_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn finance_risk_incremental_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn finance_risk_incremental_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn finance_risk_incremental_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn finance_risk_incremental_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn finance_risk_incremental_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct FinanceriskincrementalFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_incremental_frame_make(size : Int) -> FinanceriskincrementalFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_incremental_frame_len(s : FinanceriskincrementalFrame) -> Int { s.size }

pub fn finance_risk_incremental_frame_get(s : FinanceriskincrementalFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_incremental_frame_set(s : FinanceriskincrementalFrame, i : Int, v : Double) -> FinanceriskincrementalFrame {
  let result = finance_risk_incremental_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_risk_incremental_frame_sum(s : FinanceriskincrementalFrame) -> Double { @_common.sum(s.data) }

pub fn finance_risk_incremental_frame_mean(s : FinanceriskincrementalFrame) -> Double { @_common.mean(s.data) }

pub fn finance_risk_incremental_frame_scale(s : FinanceriskincrementalFrame, f : Double) -> FinanceriskincrementalFrame {
  let result = finance_risk_incremental_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_risk_incremental_frame_add(a : FinanceriskincrementalFrame, b : FinanceriskincrementalFrame) -> FinanceriskincrementalFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_risk_incremental_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_risk_incremental_frame_copy(s : FinanceriskincrementalFrame) -> FinanceriskincrementalFrame {
  let result = finance_risk_incremental_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_risk_incremental_frame_fill(s : FinanceriskincrementalFrame, v : Double) -> FinanceriskincrementalFrame {
  let result = finance_risk_incremental_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_risk_incremental_frame_min(s : FinanceriskincrementalFrame) -> Double { @_common.min(s.data) }

pub fn finance_risk_incremental_frame_max(s : FinanceriskincrementalFrame) -> Double { @_common.max(s.data) }

pub fn finance_risk_incremental_frame_to_string(s : FinanceriskincrementalFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskincrementalTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_incremental_table_make(size : Int) -> FinanceriskincrementalTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_incremental_table_len(s : FinanceriskincrementalTable) -> Int { s.size }

pub fn finance_risk_incremental_table_get(s : FinanceriskincrementalTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_incremental_table_set(s : FinanceriskincrementalTable, i : Int, v : Double) -> FinanceriskincrementalTable {
  let result = finance_risk_incremental_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_risk_incremental_table_sum(s : FinanceriskincrementalTable) -> Double { @_common.sum(s.data) }

pub fn finance_risk_incremental_table_mean(s : FinanceriskincrementalTable) -> Double { @_common.mean(s.data) }

pub fn finance_risk_incremental_table_scale(s : FinanceriskincrementalTable, f : Double) -> FinanceriskincrementalTable {
  let result = finance_risk_incremental_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_risk_incremental_table_add(a : FinanceriskincrementalTable, b : FinanceriskincrementalTable) -> FinanceriskincrementalTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_risk_incremental_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_risk_incremental_table_copy(s : FinanceriskincrementalTable) -> FinanceriskincrementalTable {
  let result = finance_risk_incremental_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_risk_incremental_table_fill(s : FinanceriskincrementalTable, v : Double) -> FinanceriskincrementalTable {
  let result = finance_risk_incremental_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_risk_incremental_table_min(s : FinanceriskincrementalTable) -> Double { @_common.min(s.data) }

pub fn finance_risk_incremental_table_max(s : FinanceriskincrementalTable) -> Double { @_common.max(s.data) }

pub fn finance_risk_incremental_table_to_string(s : FinanceriskincrementalTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskincrementalGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_incremental_graphn_make(size : Int) -> FinanceriskincrementalGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_incremental_graphn_len(s : FinanceriskincrementalGraphN) -> Int { s.size }

pub fn finance_risk_incremental_graphn_get(s : FinanceriskincrementalGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_incremental_graphn_set(s : FinanceriskincrementalGraphN, i : Int, v : Double) -> FinanceriskincrementalGraphN {
  let result = finance_risk_incremental_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_risk_incremental_graphn_sum(s : FinanceriskincrementalGraphN) -> Double { @_common.sum(s.data) }

pub fn finance_risk_incremental_graphn_mean(s : FinanceriskincrementalGraphN) -> Double { @_common.mean(s.data) }

pub fn finance_risk_incremental_graphn_scale(s : FinanceriskincrementalGraphN, f : Double) -> FinanceriskincrementalGraphN {
  let result = finance_risk_incremental_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_risk_incremental_graphn_add(a : FinanceriskincrementalGraphN, b : FinanceriskincrementalGraphN) -> FinanceriskincrementalGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_risk_incremental_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_risk_incremental_graphn_copy(s : FinanceriskincrementalGraphN) -> FinanceriskincrementalGraphN {
  let result = finance_risk_incremental_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_risk_incremental_graphn_fill(s : FinanceriskincrementalGraphN, v : Double) -> FinanceriskincrementalGraphN {
  let result = finance_risk_incremental_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_risk_incremental_graphn_min(s : FinanceriskincrementalGraphN) -> Double { @_common.min(s.data) }

pub fn finance_risk_incremental_graphn_max(s : FinanceriskincrementalGraphN) -> Double { @_common.max(s.data) }

pub fn finance_risk_incremental_graphn_to_string(s : FinanceriskincrementalGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskincrementalNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_incremental_node_make(size : Int) -> FinanceriskincrementalNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_incremental_node_len(s : FinanceriskincrementalNode) -> Int { s.size }

pub fn finance_risk_incremental_node_get(s : FinanceriskincrementalNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_incremental_node_set(s : FinanceriskincrementalNode, i : Int, v : Double) -> FinanceriskincrementalNode {
  let result = finance_risk_incremental_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_risk_incremental_node_sum(s : FinanceriskincrementalNode) -> Double { @_common.sum(s.data) }

pub fn finance_risk_incremental_node_mean(s : FinanceriskincrementalNode) -> Double { @_common.mean(s.data) }

pub fn finance_risk_incremental_node_scale(s : FinanceriskincrementalNode, f : Double) -> FinanceriskincrementalNode {
  let result = finance_risk_incremental_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_risk_incremental_node_add(a : FinanceriskincrementalNode, b : FinanceriskincrementalNode) -> FinanceriskincrementalNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_risk_incremental_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_risk_incremental_node_copy(s : FinanceriskincrementalNode) -> FinanceriskincrementalNode {
  let result = finance_risk_incremental_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_risk_incremental_node_fill(s : FinanceriskincrementalNode, v : Double) -> FinanceriskincrementalNode {
  let result = finance_risk_incremental_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_risk_incremental_node_min(s : FinanceriskincrementalNode) -> Double { @_common.min(s.data) }

pub fn finance_risk_incremental_node_max(s : FinanceriskincrementalNode) -> Double { @_common.max(s.data) }

pub fn finance_risk_incremental_node_to_string(s : FinanceriskincrementalNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskincrementalEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_incremental_edge_make(size : Int) -> FinanceriskincrementalEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_incremental_edge_len(s : FinanceriskincrementalEdge) -> Int { s.size }

pub fn finance_risk_incremental_edge_get(s : FinanceriskincrementalEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_incremental_edge_set(s : FinanceriskincrementalEdge, i : Int, v : Double) -> FinanceriskincrementalEdge {
  let result = finance_risk_incremental_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_risk_incremental_edge_sum(s : FinanceriskincrementalEdge) -> Double { @_common.sum(s.data) }

pub fn finance_risk_incremental_edge_mean(s : FinanceriskincrementalEdge) -> Double { @_common.mean(s.data) }

pub fn finance_risk_incremental_edge_scale(s : FinanceriskincrementalEdge, f : Double) -> FinanceriskincrementalEdge {
  let result = finance_risk_incremental_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_risk_incremental_edge_add(a : FinanceriskincrementalEdge, b : FinanceriskincrementalEdge) -> FinanceriskincrementalEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_risk_incremental_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_risk_incremental_edge_copy(s : FinanceriskincrementalEdge) -> FinanceriskincrementalEdge {
  let result = finance_risk_incremental_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_risk_incremental_edge_fill(s : FinanceriskincrementalEdge, v : Double) -> FinanceriskincrementalEdge {
  let result = finance_risk_incremental_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_risk_incremental_edge_min(s : FinanceriskincrementalEdge) -> Double { @_common.min(s.data) }

pub fn finance_risk_incremental_edge_max(s : FinanceriskincrementalEdge) -> Double { @_common.max(s.data) }

pub fn finance_risk_incremental_edge_to_string(s : FinanceriskincrementalEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskincrementalPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_incremental_path_make(size : Int) -> FinanceriskincrementalPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_incremental_path_len(s : FinanceriskincrementalPath) -> Int { s.size }

pub fn finance_risk_incremental_path_get(s : FinanceriskincrementalPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_incremental_path_set(s : FinanceriskincrementalPath, i : Int, v : Double) -> FinanceriskincrementalPath {
  let result = finance_risk_incremental_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_risk_incremental_path_sum(s : FinanceriskincrementalPath) -> Double { @_common.sum(s.data) }

pub fn finance_risk_incremental_path_mean(s : FinanceriskincrementalPath) -> Double { @_common.mean(s.data) }

pub fn finance_risk_incremental_path_scale(s : FinanceriskincrementalPath, f : Double) -> FinanceriskincrementalPath {
  let result = finance_risk_incremental_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_risk_incremental_path_add(a : FinanceriskincrementalPath, b : FinanceriskincrementalPath) -> FinanceriskincrementalPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_risk_incremental_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_risk_incremental_path_copy(s : FinanceriskincrementalPath) -> FinanceriskincrementalPath {
  let result = finance_risk_incremental_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_risk_incremental_path_fill(s : FinanceriskincrementalPath, v : Double) -> FinanceriskincrementalPath {
  let result = finance_risk_incremental_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_risk_incremental_path_min(s : FinanceriskincrementalPath) -> Double { @_common.min(s.data) }

pub fn finance_risk_incremental_path_max(s : FinanceriskincrementalPath) -> Double { @_common.max(s.data) }

pub fn finance_risk_incremental_path_to_string(s : FinanceriskincrementalPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskincrementalCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_incremental_cluster_make(size : Int) -> FinanceriskincrementalCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_incremental_cluster_len(s : FinanceriskincrementalCluster) -> Int { s.size }

pub fn finance_risk_incremental_cluster_get(s : FinanceriskincrementalCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_incremental_cluster_set(s : FinanceriskincrementalCluster, i : Int, v : Double) -> FinanceriskincrementalCluster {
  let result = finance_risk_incremental_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_risk_incremental_cluster_sum(s : FinanceriskincrementalCluster) -> Double { @_common.sum(s.data) }

pub fn finance_risk_incremental_cluster_mean(s : FinanceriskincrementalCluster) -> Double { @_common.mean(s.data) }

pub fn finance_risk_incremental_cluster_scale(s : FinanceriskincrementalCluster, f : Double) -> FinanceriskincrementalCluster {
  let result = finance_risk_incremental_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_risk_incremental_cluster_add(a : FinanceriskincrementalCluster, b : FinanceriskincrementalCluster) -> FinanceriskincrementalCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_risk_incremental_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_risk_incremental_cluster_copy(s : FinanceriskincrementalCluster) -> FinanceriskincrementalCluster {
  let result = finance_risk_incremental_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_risk_incremental_cluster_fill(s : FinanceriskincrementalCluster, v : Double) -> FinanceriskincrementalCluster {
  let result = finance_risk_incremental_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_risk_incremental_cluster_min(s : FinanceriskincrementalCluster) -> Double { @_common.min(s.data) }

pub fn finance_risk_incremental_cluster_max(s : FinanceriskincrementalCluster) -> Double { @_common.max(s.data) }

pub fn finance_risk_incremental_cluster_to_string(s : FinanceriskincrementalCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskincrementalModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_incremental_model_make(size : Int) -> FinanceriskincrementalModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_incremental_model_len(s : FinanceriskincrementalModel) -> Int { s.size }

pub fn finance_risk_incremental_model_get(s : FinanceriskincrementalModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_incremental_model_set(s : FinanceriskincrementalModel, i : Int, v : Double) -> FinanceriskincrementalModel {
  let result = finance_risk_incremental_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_risk_incremental_model_sum(s : FinanceriskincrementalModel) -> Double { @_common.sum(s.data) }

pub fn finance_risk_incremental_model_mean(s : FinanceriskincrementalModel) -> Double { @_common.mean(s.data) }

pub fn finance_risk_incremental_model_scale(s : FinanceriskincrementalModel, f : Double) -> FinanceriskincrementalModel {
  let result = finance_risk_incremental_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_risk_incremental_model_add(a : FinanceriskincrementalModel, b : FinanceriskincrementalModel) -> FinanceriskincrementalModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_risk_incremental_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_risk_incremental_model_copy(s : FinanceriskincrementalModel) -> FinanceriskincrementalModel {
  let result = finance_risk_incremental_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_risk_incremental_model_fill(s : FinanceriskincrementalModel, v : Double) -> FinanceriskincrementalModel {
  let result = finance_risk_incremental_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_risk_incremental_model_min(s : FinanceriskincrementalModel) -> Double { @_common.min(s.data) }

pub fn finance_risk_incremental_model_max(s : FinanceriskincrementalModel) -> Double { @_common.max(s.data) }

pub fn finance_risk_incremental_model_to_string(s : FinanceriskincrementalModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskincrementalLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_incremental_layer_make(size : Int) -> FinanceriskincrementalLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_incremental_layer_len(s : FinanceriskincrementalLayer) -> Int { s.size }

pub fn finance_risk_incremental_layer_get(s : FinanceriskincrementalLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_incremental_layer_set(s : FinanceriskincrementalLayer, i : Int, v : Double) -> FinanceriskincrementalLayer {
  let result = finance_risk_incremental_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_risk_incremental_layer_sum(s : FinanceriskincrementalLayer) -> Double { @_common.sum(s.data) }

pub fn finance_risk_incremental_layer_mean(s : FinanceriskincrementalLayer) -> Double { @_common.mean(s.data) }

pub fn finance_risk_incremental_layer_scale(s : FinanceriskincrementalLayer, f : Double) -> FinanceriskincrementalLayer {
  let result = finance_risk_incremental_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_risk_incremental_layer_add(a : FinanceriskincrementalLayer, b : FinanceriskincrementalLayer) -> FinanceriskincrementalLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_risk_incremental_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_risk_incremental_layer_copy(s : FinanceriskincrementalLayer) -> FinanceriskincrementalLayer {
  let result = finance_risk_incremental_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_risk_incremental_layer_fill(s : FinanceriskincrementalLayer, v : Double) -> FinanceriskincrementalLayer {
  let result = finance_risk_incremental_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_risk_incremental_layer_min(s : FinanceriskincrementalLayer) -> Double { @_common.min(s.data) }

pub fn finance_risk_incremental_layer_max(s : FinanceriskincrementalLayer) -> Double { @_common.max(s.data) }

pub fn finance_risk_incremental_layer_to_string(s : FinanceriskincrementalLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskincrementalBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_incremental_buffer_make(size : Int) -> FinanceriskincrementalBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_incremental_buffer_len(s : FinanceriskincrementalBuffer) -> Int { s.size }

pub fn finance_risk_incremental_buffer_get(s : FinanceriskincrementalBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_incremental_buffer_set(s : FinanceriskincrementalBuffer, i : Int, v : Double) -> FinanceriskincrementalBuffer {
  let result = finance_risk_incremental_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_risk_incremental_buffer_sum(s : FinanceriskincrementalBuffer) -> Double { @_common.sum(s.data) }

pub fn finance_risk_incremental_buffer_mean(s : FinanceriskincrementalBuffer) -> Double { @_common.mean(s.data) }

pub fn finance_risk_incremental_buffer_scale(s : FinanceriskincrementalBuffer, f : Double) -> FinanceriskincrementalBuffer {
  let result = finance_risk_incremental_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_risk_incremental_buffer_add(a : FinanceriskincrementalBuffer, b : FinanceriskincrementalBuffer) -> FinanceriskincrementalBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_risk_incremental_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_risk_incremental_buffer_copy(s : FinanceriskincrementalBuffer) -> FinanceriskincrementalBuffer {
  let result = finance_risk_incremental_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_risk_incremental_buffer_fill(s : FinanceriskincrementalBuffer, v : Double) -> FinanceriskincrementalBuffer {
  let result = finance_risk_incremental_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_risk_incremental_buffer_min(s : FinanceriskincrementalBuffer) -> Double { @_common.min(s.data) }

pub fn finance_risk_incremental_buffer_max(s : FinanceriskincrementalBuffer) -> Double { @_common.max(s.data) }

pub fn finance_risk_incremental_buffer_to_string(s : FinanceriskincrementalBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskincrementalCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_incremental_cursor_make(size : Int) -> FinanceriskincrementalCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_incremental_cursor_len(s : FinanceriskincrementalCursor) -> Int { s.size }

pub fn finance_risk_incremental_cursor_get(s : FinanceriskincrementalCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_incremental_cursor_set(s : FinanceriskincrementalCursor, i : Int, v : Double) -> FinanceriskincrementalCursor {
  let result = finance_risk_incremental_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_risk_incremental_cursor_sum(s : FinanceriskincrementalCursor) -> Double { @_common.sum(s.data) }

pub fn finance_risk_incremental_cursor_mean(s : FinanceriskincrementalCursor) -> Double { @_common.mean(s.data) }

pub fn finance_risk_incremental_cursor_scale(s : FinanceriskincrementalCursor, f : Double) -> FinanceriskincrementalCursor {
  let result = finance_risk_incremental_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_risk_incremental_cursor_add(a : FinanceriskincrementalCursor, b : FinanceriskincrementalCursor) -> FinanceriskincrementalCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_risk_incremental_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_risk_incremental_cursor_copy(s : FinanceriskincrementalCursor) -> FinanceriskincrementalCursor {
  let result = finance_risk_incremental_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_risk_incremental_cursor_fill(s : FinanceriskincrementalCursor, v : Double) -> FinanceriskincrementalCursor {
  let result = finance_risk_incremental_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_risk_incremental_cursor_min(s : FinanceriskincrementalCursor) -> Double { @_common.min(s.data) }

pub fn finance_risk_incremental_cursor_max(s : FinanceriskincrementalCursor) -> Double { @_common.max(s.data) }

pub fn finance_risk_incremental_cursor_to_string(s : FinanceriskincrementalCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskincrementalView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_incremental_view_make(size : Int) -> FinanceriskincrementalView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_incremental_view_len(s : FinanceriskincrementalView) -> Int { s.size }

pub fn finance_risk_incremental_view_get(s : FinanceriskincrementalView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_incremental_view_set(s : FinanceriskincrementalView, i : Int, v : Double) -> FinanceriskincrementalView {
  let result = finance_risk_incremental_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_risk_incremental_view_sum(s : FinanceriskincrementalView) -> Double { @_common.sum(s.data) }

pub fn finance_risk_incremental_view_mean(s : FinanceriskincrementalView) -> Double { @_common.mean(s.data) }

pub fn finance_risk_incremental_view_scale(s : FinanceriskincrementalView, f : Double) -> FinanceriskincrementalView {
  let result = finance_risk_incremental_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_risk_incremental_view_add(a : FinanceriskincrementalView, b : FinanceriskincrementalView) -> FinanceriskincrementalView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_risk_incremental_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_risk_incremental_view_copy(s : FinanceriskincrementalView) -> FinanceriskincrementalView {
  let result = finance_risk_incremental_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_risk_incremental_view_fill(s : FinanceriskincrementalView, v : Double) -> FinanceriskincrementalView {
  let result = finance_risk_incremental_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_risk_incremental_view_min(s : FinanceriskincrementalView) -> Double { @_common.min(s.data) }

pub fn finance_risk_incremental_view_max(s : FinanceriskincrementalView) -> Double { @_common.max(s.data) }

pub fn finance_risk_incremental_view_to_string(s : FinanceriskincrementalView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskincrementalRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_incremental_range_make(size : Int) -> FinanceriskincrementalRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_incremental_range_len(s : FinanceriskincrementalRange) -> Int { s.size }

pub fn finance_risk_incremental_range_get(s : FinanceriskincrementalRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_incremental_range_set(s : FinanceriskincrementalRange, i : Int, v : Double) -> FinanceriskincrementalRange {
  let result = finance_risk_incremental_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_risk_incremental_range_sum(s : FinanceriskincrementalRange) -> Double { @_common.sum(s.data) }

pub fn finance_risk_incremental_range_mean(s : FinanceriskincrementalRange) -> Double { @_common.mean(s.data) }

pub fn finance_risk_incremental_range_scale(s : FinanceriskincrementalRange, f : Double) -> FinanceriskincrementalRange {
  let result = finance_risk_incremental_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_risk_incremental_range_add(a : FinanceriskincrementalRange, b : FinanceriskincrementalRange) -> FinanceriskincrementalRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_risk_incremental_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_risk_incremental_range_copy(s : FinanceriskincrementalRange) -> FinanceriskincrementalRange {
  let result = finance_risk_incremental_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_risk_incremental_range_fill(s : FinanceriskincrementalRange, v : Double) -> FinanceriskincrementalRange {
  let result = finance_risk_incremental_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_risk_incremental_range_min(s : FinanceriskincrementalRange) -> Double { @_common.min(s.data) }

pub fn finance_risk_incremental_range_max(s : FinanceriskincrementalRange) -> Double { @_common.max(s.data) }

pub fn finance_risk_incremental_range_to_string(s : FinanceriskincrementalRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskincrementalSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_incremental_slice_make(size : Int) -> FinanceriskincrementalSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_incremental_slice_len(s : FinanceriskincrementalSlice) -> Int { s.size }

pub fn finance_risk_incremental_slice_get(s : FinanceriskincrementalSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_incremental_slice_set(s : FinanceriskincrementalSlice, i : Int, v : Double) -> FinanceriskincrementalSlice {
  let result = finance_risk_incremental_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_risk_incremental_slice_sum(s : FinanceriskincrementalSlice) -> Double { @_common.sum(s.data) }

pub fn finance_risk_incremental_slice_mean(s : FinanceriskincrementalSlice) -> Double { @_common.mean(s.data) }

pub fn finance_risk_incremental_slice_scale(s : FinanceriskincrementalSlice, f : Double) -> FinanceriskincrementalSlice {
  let result = finance_risk_incremental_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_risk_incremental_slice_add(a : FinanceriskincrementalSlice, b : FinanceriskincrementalSlice) -> FinanceriskincrementalSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_risk_incremental_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_risk_incremental_slice_copy(s : FinanceriskincrementalSlice) -> FinanceriskincrementalSlice {
  let result = finance_risk_incremental_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_risk_incremental_slice_fill(s : FinanceriskincrementalSlice, v : Double) -> FinanceriskincrementalSlice {
  let result = finance_risk_incremental_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_risk_incremental_slice_min(s : FinanceriskincrementalSlice) -> Double { @_common.min(s.data) }

pub fn finance_risk_incremental_slice_max(s : FinanceriskincrementalSlice) -> Double { @_common.max(s.data) }

pub fn finance_risk_incremental_slice_to_string(s : FinanceriskincrementalSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

