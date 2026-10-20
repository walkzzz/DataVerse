///===
/// extcore/stats_model_nonlinear

pub(all) struct StatsmodelnonlinearPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn stats_model_nonlinear_make_point(x : Double, y : Double) -> StatsmodelnonlinearPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn stats_model_nonlinear_make_point3(x : Double, y : Double, z : Double) -> StatsmodelnonlinearPoint {
  { x, y, z, label: 0 }
}

pub fn stats_model_nonlinear_point_x(pt : StatsmodelnonlinearPoint) -> Double { pt.x }

pub fn stats_model_nonlinear_point_y(pt : StatsmodelnonlinearPoint) -> Double { pt.y }

pub fn stats_model_nonlinear_point_z(pt : StatsmodelnonlinearPoint) -> Double { pt.z }

pub fn stats_model_nonlinear_point_label(pt : StatsmodelnonlinearPoint) -> Int { pt.label }

pub fn stats_model_nonlinear_point_dist(a : StatsmodelnonlinearPoint, b : StatsmodelnonlinearPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn stats_model_nonlinear_point_add(a : StatsmodelnonlinearPoint, b : StatsmodelnonlinearPoint) -> StatsmodelnonlinearPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn stats_model_nonlinear_point_sub(a : StatsmodelnonlinearPoint, b : StatsmodelnonlinearPoint) -> StatsmodelnonlinearPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn stats_model_nonlinear_point_scale(pt : StatsmodelnonlinearPoint, s : Double) -> StatsmodelnonlinearPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn stats_model_nonlinear_point_dot(a : StatsmodelnonlinearPoint, b : StatsmodelnonlinearPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn stats_model_nonlinear_point_cross(a : StatsmodelnonlinearPoint, b : StatsmodelnonlinearPoint) -> StatsmodelnonlinearPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn stats_model_nonlinear_point_norm(pt : StatsmodelnonlinearPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn stats_model_nonlinear_point_normalize(pt : StatsmodelnonlinearPoint) -> StatsmodelnonlinearPoint {
  let n = stats_model_nonlinear_point_norm(pt)
  if n < 0.0000001 { pt } else { stats_model_nonlinear_point_scale(pt, 1.0 / n) }
}

pub fn stats_model_nonlinear_point_negate(pt : StatsmodelnonlinearPoint) -> StatsmodelnonlinearPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn stats_model_nonlinear_point_mid(a : StatsmodelnonlinearPoint, b : StatsmodelnonlinearPoint) -> StatsmodelnonlinearPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn stats_model_nonlinear_point_lerp(a : StatsmodelnonlinearPoint, b : StatsmodelnonlinearPoint, t : Double) -> StatsmodelnonlinearPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn stats_model_nonlinear_point_to_string(pt : StatsmodelnonlinearPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct StatsmodelnonlinearSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn stats_model_nonlinear_make_series(vals : Array[Double], name : String) -> StatsmodelnonlinearSeries {
  { vals, name, meta: 0 }
}

pub fn stats_model_nonlinear_series_len(s : StatsmodelnonlinearSeries) -> Int { s.vals.length() }

pub fn stats_model_nonlinear_series_sum(s : StatsmodelnonlinearSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn stats_model_nonlinear_series_mean(s : StatsmodelnonlinearSeries) -> Double { @_common.mean(s.vals) }

pub fn stats_model_nonlinear_series_min(s : StatsmodelnonlinearSeries) -> Double { @_common.min(s.vals) }

pub fn stats_model_nonlinear_series_max(s : StatsmodelnonlinearSeries) -> Double { @_common.max(s.vals) }

pub fn stats_model_nonlinear_series_range(s : StatsmodelnonlinearSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn stats_model_nonlinear_series_var(s : StatsmodelnonlinearSeries) -> Double { @_common.variance(s.vals) }

pub fn stats_model_nonlinear_series_std(s : StatsmodelnonlinearSeries) -> Double { @_common.std(s.vals) }

pub fn stats_model_nonlinear_series_median(s : StatsmodelnonlinearSeries) -> Double { @_common.median(s.vals) }

pub fn stats_model_nonlinear_series_scale(s : StatsmodelnonlinearSeries, f : Double) -> StatsmodelnonlinearSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn stats_model_nonlinear_series_add(a : StatsmodelnonlinearSeries, b : StatsmodelnonlinearSeries) -> StatsmodelnonlinearSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn stats_model_nonlinear_series_sub(a : StatsmodelnonlinearSeries, b : StatsmodelnonlinearSeries) -> StatsmodelnonlinearSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn stats_model_nonlinear_series_normalize(s : StatsmodelnonlinearSeries) -> StatsmodelnonlinearSeries {
  let mn = stats_model_nonlinear_series_min(s)
  let mx = stats_model_nonlinear_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn stats_model_nonlinear_series_cumsum(s : StatsmodelnonlinearSeries) -> StatsmodelnonlinearSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn stats_model_nonlinear_series_to_string(s : StatsmodelnonlinearSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct StatsmodelnonlinearMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn stats_model_nonlinear_make_matrix(rows : Int, cols : Int, val : Double) -> StatsmodelnonlinearMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn stats_model_nonlinear_matrix_identity(n : Int) -> StatsmodelnonlinearMatrix {
  let m = stats_model_nonlinear_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn stats_model_nonlinear_matrix_get(m : StatsmodelnonlinearMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn stats_model_nonlinear_matrix_transpose(m : StatsmodelnonlinearMatrix) -> StatsmodelnonlinearMatrix {
  let result = stats_model_nonlinear_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn stats_model_nonlinear_matrix_add(a : StatsmodelnonlinearMatrix, b : StatsmodelnonlinearMatrix) -> StatsmodelnonlinearMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = stats_model_nonlinear_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn stats_model_nonlinear_matrix_scale(m : StatsmodelnonlinearMatrix, s : Double) -> StatsmodelnonlinearMatrix {
  let result = stats_model_nonlinear_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn stats_model_nonlinear_matrix_multiply(a : StatsmodelnonlinearMatrix, b : StatsmodelnonlinearMatrix) -> StatsmodelnonlinearMatrix {
  if a.cols != b.rows { return stats_model_nonlinear_make_matrix(a.rows, b.cols, 0.0) }
  let result = stats_model_nonlinear_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn stats_model_nonlinear_matrix_trace(m : StatsmodelnonlinearMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn stats_model_nonlinear_matrix_det(m : StatsmodelnonlinearMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn stats_model_nonlinear_matrix_norm(m : StatsmodelnonlinearMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn stats_model_nonlinear_matrix_to_string(m : StatsmodelnonlinearMatrix) -> String {
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

pub(all) struct StatsmodelnonlinearVector {
  comps : Array[Double]
  dim : Int
}

pub fn stats_model_nonlinear_make_vector(comps : Array[Double]) -> StatsmodelnonlinearVector {
  { comps, dim: comps.length() }
}

pub fn stats_model_nonlinear_vector_zero(dim : Int) -> StatsmodelnonlinearVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn stats_model_nonlinear_vector_add(a : StatsmodelnonlinearVector, b : StatsmodelnonlinearVector) -> StatsmodelnonlinearVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn stats_model_nonlinear_vector_sub(a : StatsmodelnonlinearVector, b : StatsmodelnonlinearVector) -> StatsmodelnonlinearVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn stats_model_nonlinear_vector_scale(v : StatsmodelnonlinearVector, s : Double) -> StatsmodelnonlinearVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn stats_model_nonlinear_vector_dot(a : StatsmodelnonlinearVector, b : StatsmodelnonlinearVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn stats_model_nonlinear_vector_norm(v : StatsmodelnonlinearVector) -> Double { @_common.sqrt(stats_model_nonlinear_vector_dot(v, v)) }

pub fn stats_model_nonlinear_vector_normalize(v : StatsmodelnonlinearVector) -> StatsmodelnonlinearVector {
  let n = stats_model_nonlinear_vector_norm(v)
  if n < 0.0000001 { v } else { stats_model_nonlinear_vector_scale(v, 1.0 / n) }
}

pub fn stats_model_nonlinear_vector_dist(a : StatsmodelnonlinearVector, b : StatsmodelnonlinearVector) -> Double {
  stats_model_nonlinear_vector_norm(stats_model_nonlinear_vector_sub(a, b))
}

pub fn stats_model_nonlinear_vector_to_string(v : StatsmodelnonlinearVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn stats_model_nonlinear_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn stats_model_nonlinear_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn stats_model_nonlinear_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn stats_model_nonlinear_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn stats_model_nonlinear_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn stats_model_nonlinear_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn stats_model_nonlinear_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn stats_model_nonlinear_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn stats_model_nonlinear_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn stats_model_nonlinear_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn stats_model_nonlinear_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn stats_model_nonlinear_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn stats_model_nonlinear_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn stats_model_nonlinear_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn stats_model_nonlinear_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn stats_model_nonlinear_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn stats_model_nonlinear_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn stats_model_nonlinear_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn stats_model_nonlinear_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn stats_model_nonlinear_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn stats_model_nonlinear_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn stats_model_nonlinear_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn stats_model_nonlinear_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn stats_model_nonlinear_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn stats_model_nonlinear_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn stats_model_nonlinear_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn stats_model_nonlinear_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn stats_model_nonlinear_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn stats_model_nonlinear_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct StatsmodelnonlinearFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_nonlinear_frame_make(size : Int) -> StatsmodelnonlinearFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_model_nonlinear_frame_len(s : StatsmodelnonlinearFrame) -> Int { s.size }

pub fn stats_model_nonlinear_frame_get(s : StatsmodelnonlinearFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_model_nonlinear_frame_set(s : StatsmodelnonlinearFrame, i : Int, v : Double) -> StatsmodelnonlinearFrame {
  let result = stats_model_nonlinear_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_model_nonlinear_frame_sum(s : StatsmodelnonlinearFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_model_nonlinear_frame_mean(s : StatsmodelnonlinearFrame) -> Double {
  if s.size == 0 { 0.0 } else { stats_model_nonlinear_frame_sum(s) / s.size.to_double() }
}

pub fn stats_model_nonlinear_frame_scale(s : StatsmodelnonlinearFrame, f : Double) -> StatsmodelnonlinearFrame {
  let result = stats_model_nonlinear_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_model_nonlinear_frame_add(a : StatsmodelnonlinearFrame, b : StatsmodelnonlinearFrame) -> StatsmodelnonlinearFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_model_nonlinear_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_model_nonlinear_frame_copy(s : StatsmodelnonlinearFrame) -> StatsmodelnonlinearFrame {
  let result = stats_model_nonlinear_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_model_nonlinear_frame_fill(s : StatsmodelnonlinearFrame, v : Double) -> StatsmodelnonlinearFrame {
  let result = stats_model_nonlinear_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_model_nonlinear_frame_min(s : StatsmodelnonlinearFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_model_nonlinear_frame_max(s : StatsmodelnonlinearFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_model_nonlinear_frame_to_string(s : StatsmodelnonlinearFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsmodelnonlinearTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_nonlinear_table_make(size : Int) -> StatsmodelnonlinearTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_model_nonlinear_table_len(s : StatsmodelnonlinearTable) -> Int { s.size }

pub fn stats_model_nonlinear_table_get(s : StatsmodelnonlinearTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_model_nonlinear_table_set(s : StatsmodelnonlinearTable, i : Int, v : Double) -> StatsmodelnonlinearTable {
  let result = stats_model_nonlinear_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_model_nonlinear_table_sum(s : StatsmodelnonlinearTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_model_nonlinear_table_mean(s : StatsmodelnonlinearTable) -> Double {
  if s.size == 0 { 0.0 } else { stats_model_nonlinear_table_sum(s) / s.size.to_double() }
}

pub fn stats_model_nonlinear_table_scale(s : StatsmodelnonlinearTable, f : Double) -> StatsmodelnonlinearTable {
  let result = stats_model_nonlinear_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_model_nonlinear_table_add(a : StatsmodelnonlinearTable, b : StatsmodelnonlinearTable) -> StatsmodelnonlinearTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_model_nonlinear_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_model_nonlinear_table_copy(s : StatsmodelnonlinearTable) -> StatsmodelnonlinearTable {
  let result = stats_model_nonlinear_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_model_nonlinear_table_fill(s : StatsmodelnonlinearTable, v : Double) -> StatsmodelnonlinearTable {
  let result = stats_model_nonlinear_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_model_nonlinear_table_min(s : StatsmodelnonlinearTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_model_nonlinear_table_max(s : StatsmodelnonlinearTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_model_nonlinear_table_to_string(s : StatsmodelnonlinearTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsmodelnonlinearGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_nonlinear_graphn_make(size : Int) -> StatsmodelnonlinearGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_model_nonlinear_graphn_len(s : StatsmodelnonlinearGraphN) -> Int { s.size }

pub fn stats_model_nonlinear_graphn_get(s : StatsmodelnonlinearGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_model_nonlinear_graphn_set(s : StatsmodelnonlinearGraphN, i : Int, v : Double) -> StatsmodelnonlinearGraphN {
  let result = stats_model_nonlinear_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_model_nonlinear_graphn_sum(s : StatsmodelnonlinearGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_model_nonlinear_graphn_mean(s : StatsmodelnonlinearGraphN) -> Double {
  if s.size == 0 { 0.0 } else { stats_model_nonlinear_graphn_sum(s) / s.size.to_double() }
}

pub fn stats_model_nonlinear_graphn_scale(s : StatsmodelnonlinearGraphN, f : Double) -> StatsmodelnonlinearGraphN {
  let result = stats_model_nonlinear_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_model_nonlinear_graphn_add(a : StatsmodelnonlinearGraphN, b : StatsmodelnonlinearGraphN) -> StatsmodelnonlinearGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_model_nonlinear_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_model_nonlinear_graphn_copy(s : StatsmodelnonlinearGraphN) -> StatsmodelnonlinearGraphN {
  let result = stats_model_nonlinear_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_model_nonlinear_graphn_fill(s : StatsmodelnonlinearGraphN, v : Double) -> StatsmodelnonlinearGraphN {
  let result = stats_model_nonlinear_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_model_nonlinear_graphn_min(s : StatsmodelnonlinearGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_model_nonlinear_graphn_max(s : StatsmodelnonlinearGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_model_nonlinear_graphn_to_string(s : StatsmodelnonlinearGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsmodelnonlinearNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_nonlinear_node_make(size : Int) -> StatsmodelnonlinearNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_model_nonlinear_node_len(s : StatsmodelnonlinearNode) -> Int { s.size }

pub fn stats_model_nonlinear_node_get(s : StatsmodelnonlinearNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_model_nonlinear_node_set(s : StatsmodelnonlinearNode, i : Int, v : Double) -> StatsmodelnonlinearNode {
  let result = stats_model_nonlinear_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_model_nonlinear_node_sum(s : StatsmodelnonlinearNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_model_nonlinear_node_mean(s : StatsmodelnonlinearNode) -> Double {
  if s.size == 0 { 0.0 } else { stats_model_nonlinear_node_sum(s) / s.size.to_double() }
}

pub fn stats_model_nonlinear_node_scale(s : StatsmodelnonlinearNode, f : Double) -> StatsmodelnonlinearNode {
  let result = stats_model_nonlinear_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_model_nonlinear_node_add(a : StatsmodelnonlinearNode, b : StatsmodelnonlinearNode) -> StatsmodelnonlinearNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_model_nonlinear_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_model_nonlinear_node_copy(s : StatsmodelnonlinearNode) -> StatsmodelnonlinearNode {
  let result = stats_model_nonlinear_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_model_nonlinear_node_fill(s : StatsmodelnonlinearNode, v : Double) -> StatsmodelnonlinearNode {
  let result = stats_model_nonlinear_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_model_nonlinear_node_min(s : StatsmodelnonlinearNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_model_nonlinear_node_max(s : StatsmodelnonlinearNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_model_nonlinear_node_to_string(s : StatsmodelnonlinearNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsmodelnonlinearEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_nonlinear_edge_make(size : Int) -> StatsmodelnonlinearEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_model_nonlinear_edge_len(s : StatsmodelnonlinearEdge) -> Int { s.size }

pub fn stats_model_nonlinear_edge_get(s : StatsmodelnonlinearEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_model_nonlinear_edge_set(s : StatsmodelnonlinearEdge, i : Int, v : Double) -> StatsmodelnonlinearEdge {
  let result = stats_model_nonlinear_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_model_nonlinear_edge_sum(s : StatsmodelnonlinearEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_model_nonlinear_edge_mean(s : StatsmodelnonlinearEdge) -> Double {
  if s.size == 0 { 0.0 } else { stats_model_nonlinear_edge_sum(s) / s.size.to_double() }
}

pub fn stats_model_nonlinear_edge_scale(s : StatsmodelnonlinearEdge, f : Double) -> StatsmodelnonlinearEdge {
  let result = stats_model_nonlinear_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_model_nonlinear_edge_add(a : StatsmodelnonlinearEdge, b : StatsmodelnonlinearEdge) -> StatsmodelnonlinearEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_model_nonlinear_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_model_nonlinear_edge_copy(s : StatsmodelnonlinearEdge) -> StatsmodelnonlinearEdge {
  let result = stats_model_nonlinear_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_model_nonlinear_edge_fill(s : StatsmodelnonlinearEdge, v : Double) -> StatsmodelnonlinearEdge {
  let result = stats_model_nonlinear_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_model_nonlinear_edge_min(s : StatsmodelnonlinearEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_model_nonlinear_edge_max(s : StatsmodelnonlinearEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_model_nonlinear_edge_to_string(s : StatsmodelnonlinearEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsmodelnonlinearPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_nonlinear_path_make(size : Int) -> StatsmodelnonlinearPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_model_nonlinear_path_len(s : StatsmodelnonlinearPath) -> Int { s.size }

pub fn stats_model_nonlinear_path_get(s : StatsmodelnonlinearPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_model_nonlinear_path_set(s : StatsmodelnonlinearPath, i : Int, v : Double) -> StatsmodelnonlinearPath {
  let result = stats_model_nonlinear_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_model_nonlinear_path_sum(s : StatsmodelnonlinearPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_model_nonlinear_path_mean(s : StatsmodelnonlinearPath) -> Double {
  if s.size == 0 { 0.0 } else { stats_model_nonlinear_path_sum(s) / s.size.to_double() }
}

pub fn stats_model_nonlinear_path_scale(s : StatsmodelnonlinearPath, f : Double) -> StatsmodelnonlinearPath {
  let result = stats_model_nonlinear_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_model_nonlinear_path_add(a : StatsmodelnonlinearPath, b : StatsmodelnonlinearPath) -> StatsmodelnonlinearPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_model_nonlinear_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_model_nonlinear_path_copy(s : StatsmodelnonlinearPath) -> StatsmodelnonlinearPath {
  let result = stats_model_nonlinear_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_model_nonlinear_path_fill(s : StatsmodelnonlinearPath, v : Double) -> StatsmodelnonlinearPath {
  let result = stats_model_nonlinear_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_model_nonlinear_path_min(s : StatsmodelnonlinearPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_model_nonlinear_path_max(s : StatsmodelnonlinearPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_model_nonlinear_path_to_string(s : StatsmodelnonlinearPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsmodelnonlinearCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_nonlinear_cluster_make(size : Int) -> StatsmodelnonlinearCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_model_nonlinear_cluster_len(s : StatsmodelnonlinearCluster) -> Int { s.size }

pub fn stats_model_nonlinear_cluster_get(s : StatsmodelnonlinearCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_model_nonlinear_cluster_set(s : StatsmodelnonlinearCluster, i : Int, v : Double) -> StatsmodelnonlinearCluster {
  let result = stats_model_nonlinear_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_model_nonlinear_cluster_sum(s : StatsmodelnonlinearCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_model_nonlinear_cluster_mean(s : StatsmodelnonlinearCluster) -> Double {
  if s.size == 0 { 0.0 } else { stats_model_nonlinear_cluster_sum(s) / s.size.to_double() }
}

pub fn stats_model_nonlinear_cluster_scale(s : StatsmodelnonlinearCluster, f : Double) -> StatsmodelnonlinearCluster {
  let result = stats_model_nonlinear_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_model_nonlinear_cluster_add(a : StatsmodelnonlinearCluster, b : StatsmodelnonlinearCluster) -> StatsmodelnonlinearCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_model_nonlinear_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_model_nonlinear_cluster_copy(s : StatsmodelnonlinearCluster) -> StatsmodelnonlinearCluster {
  let result = stats_model_nonlinear_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_model_nonlinear_cluster_fill(s : StatsmodelnonlinearCluster, v : Double) -> StatsmodelnonlinearCluster {
  let result = stats_model_nonlinear_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_model_nonlinear_cluster_min(s : StatsmodelnonlinearCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_model_nonlinear_cluster_max(s : StatsmodelnonlinearCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_model_nonlinear_cluster_to_string(s : StatsmodelnonlinearCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsmodelnonlinearModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_nonlinear_model_make(size : Int) -> StatsmodelnonlinearModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_model_nonlinear_model_len(s : StatsmodelnonlinearModel) -> Int { s.size }

pub fn stats_model_nonlinear_model_get(s : StatsmodelnonlinearModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_model_nonlinear_model_set(s : StatsmodelnonlinearModel, i : Int, v : Double) -> StatsmodelnonlinearModel {
  let result = stats_model_nonlinear_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_model_nonlinear_model_sum(s : StatsmodelnonlinearModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_model_nonlinear_model_mean(s : StatsmodelnonlinearModel) -> Double {
  if s.size == 0 { 0.0 } else { stats_model_nonlinear_model_sum(s) / s.size.to_double() }
}

pub fn stats_model_nonlinear_model_scale(s : StatsmodelnonlinearModel, f : Double) -> StatsmodelnonlinearModel {
  let result = stats_model_nonlinear_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_model_nonlinear_model_add(a : StatsmodelnonlinearModel, b : StatsmodelnonlinearModel) -> StatsmodelnonlinearModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_model_nonlinear_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_model_nonlinear_model_copy(s : StatsmodelnonlinearModel) -> StatsmodelnonlinearModel {
  let result = stats_model_nonlinear_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_model_nonlinear_model_fill(s : StatsmodelnonlinearModel, v : Double) -> StatsmodelnonlinearModel {
  let result = stats_model_nonlinear_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_model_nonlinear_model_min(s : StatsmodelnonlinearModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_model_nonlinear_model_max(s : StatsmodelnonlinearModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_model_nonlinear_model_to_string(s : StatsmodelnonlinearModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsmodelnonlinearLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_nonlinear_layer_make(size : Int) -> StatsmodelnonlinearLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_model_nonlinear_layer_len(s : StatsmodelnonlinearLayer) -> Int { s.size }

pub fn stats_model_nonlinear_layer_get(s : StatsmodelnonlinearLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_model_nonlinear_layer_set(s : StatsmodelnonlinearLayer, i : Int, v : Double) -> StatsmodelnonlinearLayer {
  let result = stats_model_nonlinear_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_model_nonlinear_layer_sum(s : StatsmodelnonlinearLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_model_nonlinear_layer_mean(s : StatsmodelnonlinearLayer) -> Double {
  if s.size == 0 { 0.0 } else { stats_model_nonlinear_layer_sum(s) / s.size.to_double() }
}

pub fn stats_model_nonlinear_layer_scale(s : StatsmodelnonlinearLayer, f : Double) -> StatsmodelnonlinearLayer {
  let result = stats_model_nonlinear_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_model_nonlinear_layer_add(a : StatsmodelnonlinearLayer, b : StatsmodelnonlinearLayer) -> StatsmodelnonlinearLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_model_nonlinear_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_model_nonlinear_layer_copy(s : StatsmodelnonlinearLayer) -> StatsmodelnonlinearLayer {
  let result = stats_model_nonlinear_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_model_nonlinear_layer_fill(s : StatsmodelnonlinearLayer, v : Double) -> StatsmodelnonlinearLayer {
  let result = stats_model_nonlinear_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_model_nonlinear_layer_min(s : StatsmodelnonlinearLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_model_nonlinear_layer_max(s : StatsmodelnonlinearLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_model_nonlinear_layer_to_string(s : StatsmodelnonlinearLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsmodelnonlinearBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_nonlinear_buffer_make(size : Int) -> StatsmodelnonlinearBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_model_nonlinear_buffer_len(s : StatsmodelnonlinearBuffer) -> Int { s.size }

pub fn stats_model_nonlinear_buffer_get(s : StatsmodelnonlinearBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_model_nonlinear_buffer_set(s : StatsmodelnonlinearBuffer, i : Int, v : Double) -> StatsmodelnonlinearBuffer {
  let result = stats_model_nonlinear_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_model_nonlinear_buffer_sum(s : StatsmodelnonlinearBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_model_nonlinear_buffer_mean(s : StatsmodelnonlinearBuffer) -> Double {
  if s.size == 0 { 0.0 } else { stats_model_nonlinear_buffer_sum(s) / s.size.to_double() }
}

pub fn stats_model_nonlinear_buffer_scale(s : StatsmodelnonlinearBuffer, f : Double) -> StatsmodelnonlinearBuffer {
  let result = stats_model_nonlinear_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_model_nonlinear_buffer_add(a : StatsmodelnonlinearBuffer, b : StatsmodelnonlinearBuffer) -> StatsmodelnonlinearBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_model_nonlinear_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_model_nonlinear_buffer_copy(s : StatsmodelnonlinearBuffer) -> StatsmodelnonlinearBuffer {
  let result = stats_model_nonlinear_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_model_nonlinear_buffer_fill(s : StatsmodelnonlinearBuffer, v : Double) -> StatsmodelnonlinearBuffer {
  let result = stats_model_nonlinear_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_model_nonlinear_buffer_min(s : StatsmodelnonlinearBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_model_nonlinear_buffer_max(s : StatsmodelnonlinearBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_model_nonlinear_buffer_to_string(s : StatsmodelnonlinearBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsmodelnonlinearCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_nonlinear_cursor_make(size : Int) -> StatsmodelnonlinearCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_model_nonlinear_cursor_len(s : StatsmodelnonlinearCursor) -> Int { s.size }

pub fn stats_model_nonlinear_cursor_get(s : StatsmodelnonlinearCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_model_nonlinear_cursor_set(s : StatsmodelnonlinearCursor, i : Int, v : Double) -> StatsmodelnonlinearCursor {
  let result = stats_model_nonlinear_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_model_nonlinear_cursor_sum(s : StatsmodelnonlinearCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_model_nonlinear_cursor_mean(s : StatsmodelnonlinearCursor) -> Double {
  if s.size == 0 { 0.0 } else { stats_model_nonlinear_cursor_sum(s) / s.size.to_double() }
}

pub fn stats_model_nonlinear_cursor_scale(s : StatsmodelnonlinearCursor, f : Double) -> StatsmodelnonlinearCursor {
  let result = stats_model_nonlinear_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_model_nonlinear_cursor_add(a : StatsmodelnonlinearCursor, b : StatsmodelnonlinearCursor) -> StatsmodelnonlinearCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_model_nonlinear_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_model_nonlinear_cursor_copy(s : StatsmodelnonlinearCursor) -> StatsmodelnonlinearCursor {
  let result = stats_model_nonlinear_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_model_nonlinear_cursor_fill(s : StatsmodelnonlinearCursor, v : Double) -> StatsmodelnonlinearCursor {
  let result = stats_model_nonlinear_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_model_nonlinear_cursor_min(s : StatsmodelnonlinearCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_model_nonlinear_cursor_max(s : StatsmodelnonlinearCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_model_nonlinear_cursor_to_string(s : StatsmodelnonlinearCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsmodelnonlinearView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_nonlinear_view_make(size : Int) -> StatsmodelnonlinearView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_model_nonlinear_view_len(s : StatsmodelnonlinearView) -> Int { s.size }

pub fn stats_model_nonlinear_view_get(s : StatsmodelnonlinearView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_model_nonlinear_view_set(s : StatsmodelnonlinearView, i : Int, v : Double) -> StatsmodelnonlinearView {
  let result = stats_model_nonlinear_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_model_nonlinear_view_sum(s : StatsmodelnonlinearView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_model_nonlinear_view_mean(s : StatsmodelnonlinearView) -> Double {
  if s.size == 0 { 0.0 } else { stats_model_nonlinear_view_sum(s) / s.size.to_double() }
}

pub fn stats_model_nonlinear_view_scale(s : StatsmodelnonlinearView, f : Double) -> StatsmodelnonlinearView {
  let result = stats_model_nonlinear_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_model_nonlinear_view_add(a : StatsmodelnonlinearView, b : StatsmodelnonlinearView) -> StatsmodelnonlinearView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_model_nonlinear_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_model_nonlinear_view_copy(s : StatsmodelnonlinearView) -> StatsmodelnonlinearView {
  let result = stats_model_nonlinear_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_model_nonlinear_view_fill(s : StatsmodelnonlinearView, v : Double) -> StatsmodelnonlinearView {
  let result = stats_model_nonlinear_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_model_nonlinear_view_min(s : StatsmodelnonlinearView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_model_nonlinear_view_max(s : StatsmodelnonlinearView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_model_nonlinear_view_to_string(s : StatsmodelnonlinearView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsmodelnonlinearRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_nonlinear_range_make(size : Int) -> StatsmodelnonlinearRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_model_nonlinear_range_len(s : StatsmodelnonlinearRange) -> Int { s.size }

pub fn stats_model_nonlinear_range_get(s : StatsmodelnonlinearRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_model_nonlinear_range_set(s : StatsmodelnonlinearRange, i : Int, v : Double) -> StatsmodelnonlinearRange {
  let result = stats_model_nonlinear_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_model_nonlinear_range_sum(s : StatsmodelnonlinearRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_model_nonlinear_range_mean(s : StatsmodelnonlinearRange) -> Double {
  if s.size == 0 { 0.0 } else { stats_model_nonlinear_range_sum(s) / s.size.to_double() }
}

pub fn stats_model_nonlinear_range_scale(s : StatsmodelnonlinearRange, f : Double) -> StatsmodelnonlinearRange {
  let result = stats_model_nonlinear_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_model_nonlinear_range_add(a : StatsmodelnonlinearRange, b : StatsmodelnonlinearRange) -> StatsmodelnonlinearRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_model_nonlinear_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_model_nonlinear_range_copy(s : StatsmodelnonlinearRange) -> StatsmodelnonlinearRange {
  let result = stats_model_nonlinear_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_model_nonlinear_range_fill(s : StatsmodelnonlinearRange, v : Double) -> StatsmodelnonlinearRange {
  let result = stats_model_nonlinear_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_model_nonlinear_range_min(s : StatsmodelnonlinearRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_model_nonlinear_range_max(s : StatsmodelnonlinearRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_model_nonlinear_range_to_string(s : StatsmodelnonlinearRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsmodelnonlinearSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_nonlinear_slice_make(size : Int) -> StatsmodelnonlinearSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_model_nonlinear_slice_len(s : StatsmodelnonlinearSlice) -> Int { s.size }

pub fn stats_model_nonlinear_slice_get(s : StatsmodelnonlinearSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_model_nonlinear_slice_set(s : StatsmodelnonlinearSlice, i : Int, v : Double) -> StatsmodelnonlinearSlice {
  let result = stats_model_nonlinear_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_model_nonlinear_slice_sum(s : StatsmodelnonlinearSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_model_nonlinear_slice_mean(s : StatsmodelnonlinearSlice) -> Double {
  if s.size == 0 { 0.0 } else { stats_model_nonlinear_slice_sum(s) / s.size.to_double() }
}

pub fn stats_model_nonlinear_slice_scale(s : StatsmodelnonlinearSlice, f : Double) -> StatsmodelnonlinearSlice {
  let result = stats_model_nonlinear_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_model_nonlinear_slice_add(a : StatsmodelnonlinearSlice, b : StatsmodelnonlinearSlice) -> StatsmodelnonlinearSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_model_nonlinear_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_model_nonlinear_slice_copy(s : StatsmodelnonlinearSlice) -> StatsmodelnonlinearSlice {
  let result = stats_model_nonlinear_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_model_nonlinear_slice_fill(s : StatsmodelnonlinearSlice, v : Double) -> StatsmodelnonlinearSlice {
  let result = stats_model_nonlinear_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_model_nonlinear_slice_min(s : StatsmodelnonlinearSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_model_nonlinear_slice_max(s : StatsmodelnonlinearSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_model_nonlinear_slice_to_string(s : StatsmodelnonlinearSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

