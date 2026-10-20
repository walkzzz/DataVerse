///===
/// extcore/nlp_pos_bilstm

pub(all) struct NlpposbilstmPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn nlp_pos_bilstm_make_point(x : Double, y : Double) -> NlpposbilstmPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn nlp_pos_bilstm_make_point3(x : Double, y : Double, z : Double) -> NlpposbilstmPoint {
  { x, y, z, label: 0 }
}

pub fn nlp_pos_bilstm_point_x(pt : NlpposbilstmPoint) -> Double { pt.x }

pub fn nlp_pos_bilstm_point_y(pt : NlpposbilstmPoint) -> Double { pt.y }

pub fn nlp_pos_bilstm_point_z(pt : NlpposbilstmPoint) -> Double { pt.z }

pub fn nlp_pos_bilstm_point_label(pt : NlpposbilstmPoint) -> Int { pt.label }

pub fn nlp_pos_bilstm_point_dist(a : NlpposbilstmPoint, b : NlpposbilstmPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn nlp_pos_bilstm_point_add(a : NlpposbilstmPoint, b : NlpposbilstmPoint) -> NlpposbilstmPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn nlp_pos_bilstm_point_sub(a : NlpposbilstmPoint, b : NlpposbilstmPoint) -> NlpposbilstmPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn nlp_pos_bilstm_point_scale(pt : NlpposbilstmPoint, s : Double) -> NlpposbilstmPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn nlp_pos_bilstm_point_dot(a : NlpposbilstmPoint, b : NlpposbilstmPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn nlp_pos_bilstm_point_cross(a : NlpposbilstmPoint, b : NlpposbilstmPoint) -> NlpposbilstmPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn nlp_pos_bilstm_point_norm(pt : NlpposbilstmPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn nlp_pos_bilstm_point_normalize(pt : NlpposbilstmPoint) -> NlpposbilstmPoint {
  let n = nlp_pos_bilstm_point_norm(pt)
  if n < 0.0000001 { pt } else { nlp_pos_bilstm_point_scale(pt, 1.0 / n) }
}

pub fn nlp_pos_bilstm_point_negate(pt : NlpposbilstmPoint) -> NlpposbilstmPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn nlp_pos_bilstm_point_mid(a : NlpposbilstmPoint, b : NlpposbilstmPoint) -> NlpposbilstmPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn nlp_pos_bilstm_point_lerp(a : NlpposbilstmPoint, b : NlpposbilstmPoint, t : Double) -> NlpposbilstmPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn nlp_pos_bilstm_point_to_string(pt : NlpposbilstmPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct NlpposbilstmSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn nlp_pos_bilstm_make_series(vals : Array[Double], name : String) -> NlpposbilstmSeries {
  { vals, name, meta: 0 }
}

pub fn nlp_pos_bilstm_series_len(s : NlpposbilstmSeries) -> Int { s.vals.length() }

pub fn nlp_pos_bilstm_series_sum(s : NlpposbilstmSeries) -> Double { @_common.sum(s.vals) }

pub fn nlp_pos_bilstm_series_mean(s : NlpposbilstmSeries) -> Double { @_common.mean(s.vals) }

pub fn nlp_pos_bilstm_series_min(s : NlpposbilstmSeries) -> Double { @_common.min(s.vals) }

pub fn nlp_pos_bilstm_series_max(s : NlpposbilstmSeries) -> Double { @_common.max(s.vals) }

pub fn nlp_pos_bilstm_series_range(s : NlpposbilstmSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn nlp_pos_bilstm_series_var(s : NlpposbilstmSeries) -> Double { @_common.variance(s.vals) }

pub fn nlp_pos_bilstm_series_std(s : NlpposbilstmSeries) -> Double { @_common.std(s.vals) }

pub fn nlp_pos_bilstm_series_median(s : NlpposbilstmSeries) -> Double { @_common.median(s.vals) }

pub fn nlp_pos_bilstm_series_scale(s : NlpposbilstmSeries, f : Double) -> NlpposbilstmSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn nlp_pos_bilstm_series_add(a : NlpposbilstmSeries, b : NlpposbilstmSeries) -> NlpposbilstmSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn nlp_pos_bilstm_series_sub(a : NlpposbilstmSeries, b : NlpposbilstmSeries) -> NlpposbilstmSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn nlp_pos_bilstm_series_normalize(s : NlpposbilstmSeries) -> NlpposbilstmSeries {
  let mn = nlp_pos_bilstm_series_min(s)
  let mx = nlp_pos_bilstm_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn nlp_pos_bilstm_series_cumsum(s : NlpposbilstmSeries) -> NlpposbilstmSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn nlp_pos_bilstm_series_to_string(s : NlpposbilstmSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NlpposbilstmMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn nlp_pos_bilstm_make_matrix(rows : Int, cols : Int, val : Double) -> NlpposbilstmMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn nlp_pos_bilstm_matrix_identity(n : Int) -> NlpposbilstmMatrix {
  let m = nlp_pos_bilstm_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn nlp_pos_bilstm_matrix_get(m : NlpposbilstmMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn nlp_pos_bilstm_matrix_transpose(m : NlpposbilstmMatrix) -> NlpposbilstmMatrix {
  let result = nlp_pos_bilstm_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn nlp_pos_bilstm_matrix_add(a : NlpposbilstmMatrix, b : NlpposbilstmMatrix) -> NlpposbilstmMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = nlp_pos_bilstm_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn nlp_pos_bilstm_matrix_scale(m : NlpposbilstmMatrix, s : Double) -> NlpposbilstmMatrix {
  let result = nlp_pos_bilstm_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn nlp_pos_bilstm_matrix_multiply(a : NlpposbilstmMatrix, b : NlpposbilstmMatrix) -> NlpposbilstmMatrix {
  if a.cols != b.rows { return nlp_pos_bilstm_make_matrix(a.rows, b.cols, 0.0) }
  let result = nlp_pos_bilstm_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn nlp_pos_bilstm_matrix_trace(m : NlpposbilstmMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn nlp_pos_bilstm_matrix_det(m : NlpposbilstmMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn nlp_pos_bilstm_matrix_norm(m : NlpposbilstmMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn nlp_pos_bilstm_matrix_to_string(m : NlpposbilstmMatrix) -> String {
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

pub(all) struct NlpposbilstmVector {
  comps : Array[Double]
  dim : Int
}

pub fn nlp_pos_bilstm_make_vector(comps : Array[Double]) -> NlpposbilstmVector {
  { comps, dim: comps.length() }
}

pub fn nlp_pos_bilstm_vector_zero(dim : Int) -> NlpposbilstmVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn nlp_pos_bilstm_vector_add(a : NlpposbilstmVector, b : NlpposbilstmVector) -> NlpposbilstmVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn nlp_pos_bilstm_vector_sub(a : NlpposbilstmVector, b : NlpposbilstmVector) -> NlpposbilstmVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn nlp_pos_bilstm_vector_scale(v : NlpposbilstmVector, s : Double) -> NlpposbilstmVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn nlp_pos_bilstm_vector_dot(a : NlpposbilstmVector, b : NlpposbilstmVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn nlp_pos_bilstm_vector_norm(v : NlpposbilstmVector) -> Double { @_common.sqrt(nlp_pos_bilstm_vector_dot(v, v)) }

pub fn nlp_pos_bilstm_vector_normalize(v : NlpposbilstmVector) -> NlpposbilstmVector {
  let n = nlp_pos_bilstm_vector_norm(v)
  if n < 0.0000001 { v } else { nlp_pos_bilstm_vector_scale(v, 1.0 / n) }
}

pub fn nlp_pos_bilstm_vector_dist(a : NlpposbilstmVector, b : NlpposbilstmVector) -> Double {
  nlp_pos_bilstm_vector_norm(nlp_pos_bilstm_vector_sub(a, b))
}

pub fn nlp_pos_bilstm_vector_to_string(v : NlpposbilstmVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn nlp_pos_bilstm_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn nlp_pos_bilstm_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn nlp_pos_bilstm_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn nlp_pos_bilstm_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn nlp_pos_bilstm_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn nlp_pos_bilstm_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn nlp_pos_bilstm_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn nlp_pos_bilstm_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn nlp_pos_bilstm_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn nlp_pos_bilstm_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn nlp_pos_bilstm_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn nlp_pos_bilstm_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn nlp_pos_bilstm_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn nlp_pos_bilstm_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn nlp_pos_bilstm_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn nlp_pos_bilstm_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn nlp_pos_bilstm_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn nlp_pos_bilstm_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn nlp_pos_bilstm_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn nlp_pos_bilstm_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn nlp_pos_bilstm_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn nlp_pos_bilstm_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn nlp_pos_bilstm_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn nlp_pos_bilstm_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn nlp_pos_bilstm_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn nlp_pos_bilstm_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn nlp_pos_bilstm_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn nlp_pos_bilstm_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn nlp_pos_bilstm_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct NlpposbilstmFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_bilstm_frame_make(size : Int) -> NlpposbilstmFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_bilstm_frame_len(s : NlpposbilstmFrame) -> Int { s.size }

pub fn nlp_pos_bilstm_frame_get(s : NlpposbilstmFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_bilstm_frame_set(s : NlpposbilstmFrame, i : Int, v : Double) -> NlpposbilstmFrame {
  let result = nlp_pos_bilstm_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_bilstm_frame_sum(s : NlpposbilstmFrame) -> Double { @_common.sum(s.data) }

pub fn nlp_pos_bilstm_frame_mean(s : NlpposbilstmFrame) -> Double { @_common.mean(s.data) }

pub fn nlp_pos_bilstm_frame_scale(s : NlpposbilstmFrame, f : Double) -> NlpposbilstmFrame {
  let result = nlp_pos_bilstm_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_pos_bilstm_frame_add(a : NlpposbilstmFrame, b : NlpposbilstmFrame) -> NlpposbilstmFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_pos_bilstm_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_pos_bilstm_frame_copy(s : NlpposbilstmFrame) -> NlpposbilstmFrame {
  let result = nlp_pos_bilstm_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_pos_bilstm_frame_fill(s : NlpposbilstmFrame, v : Double) -> NlpposbilstmFrame {
  let result = nlp_pos_bilstm_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_bilstm_frame_min(s : NlpposbilstmFrame) -> Double { @_common.min(s.data) }

pub fn nlp_pos_bilstm_frame_max(s : NlpposbilstmFrame) -> Double { @_common.max(s.data) }

pub fn nlp_pos_bilstm_frame_to_string(s : NlpposbilstmFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpposbilstmTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_bilstm_table_make(size : Int) -> NlpposbilstmTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_bilstm_table_len(s : NlpposbilstmTable) -> Int { s.size }

pub fn nlp_pos_bilstm_table_get(s : NlpposbilstmTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_bilstm_table_set(s : NlpposbilstmTable, i : Int, v : Double) -> NlpposbilstmTable {
  let result = nlp_pos_bilstm_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_bilstm_table_sum(s : NlpposbilstmTable) -> Double { @_common.sum(s.data) }

pub fn nlp_pos_bilstm_table_mean(s : NlpposbilstmTable) -> Double { @_common.mean(s.data) }

pub fn nlp_pos_bilstm_table_scale(s : NlpposbilstmTable, f : Double) -> NlpposbilstmTable {
  let result = nlp_pos_bilstm_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_pos_bilstm_table_add(a : NlpposbilstmTable, b : NlpposbilstmTable) -> NlpposbilstmTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_pos_bilstm_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_pos_bilstm_table_copy(s : NlpposbilstmTable) -> NlpposbilstmTable {
  let result = nlp_pos_bilstm_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_pos_bilstm_table_fill(s : NlpposbilstmTable, v : Double) -> NlpposbilstmTable {
  let result = nlp_pos_bilstm_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_bilstm_table_min(s : NlpposbilstmTable) -> Double { @_common.min(s.data) }

pub fn nlp_pos_bilstm_table_max(s : NlpposbilstmTable) -> Double { @_common.max(s.data) }

pub fn nlp_pos_bilstm_table_to_string(s : NlpposbilstmTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpposbilstmGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_bilstm_graphn_make(size : Int) -> NlpposbilstmGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_bilstm_graphn_len(s : NlpposbilstmGraphN) -> Int { s.size }

pub fn nlp_pos_bilstm_graphn_get(s : NlpposbilstmGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_bilstm_graphn_set(s : NlpposbilstmGraphN, i : Int, v : Double) -> NlpposbilstmGraphN {
  let result = nlp_pos_bilstm_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_bilstm_graphn_sum(s : NlpposbilstmGraphN) -> Double { @_common.sum(s.data) }

pub fn nlp_pos_bilstm_graphn_mean(s : NlpposbilstmGraphN) -> Double { @_common.mean(s.data) }

pub fn nlp_pos_bilstm_graphn_scale(s : NlpposbilstmGraphN, f : Double) -> NlpposbilstmGraphN {
  let result = nlp_pos_bilstm_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_pos_bilstm_graphn_add(a : NlpposbilstmGraphN, b : NlpposbilstmGraphN) -> NlpposbilstmGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_pos_bilstm_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_pos_bilstm_graphn_copy(s : NlpposbilstmGraphN) -> NlpposbilstmGraphN {
  let result = nlp_pos_bilstm_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_pos_bilstm_graphn_fill(s : NlpposbilstmGraphN, v : Double) -> NlpposbilstmGraphN {
  let result = nlp_pos_bilstm_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_bilstm_graphn_min(s : NlpposbilstmGraphN) -> Double { @_common.min(s.data) }

pub fn nlp_pos_bilstm_graphn_max(s : NlpposbilstmGraphN) -> Double { @_common.max(s.data) }

pub fn nlp_pos_bilstm_graphn_to_string(s : NlpposbilstmGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpposbilstmNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_bilstm_node_make(size : Int) -> NlpposbilstmNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_bilstm_node_len(s : NlpposbilstmNode) -> Int { s.size }

pub fn nlp_pos_bilstm_node_get(s : NlpposbilstmNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_bilstm_node_set(s : NlpposbilstmNode, i : Int, v : Double) -> NlpposbilstmNode {
  let result = nlp_pos_bilstm_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_bilstm_node_sum(s : NlpposbilstmNode) -> Double { @_common.sum(s.data) }

pub fn nlp_pos_bilstm_node_mean(s : NlpposbilstmNode) -> Double { @_common.mean(s.data) }

pub fn nlp_pos_bilstm_node_scale(s : NlpposbilstmNode, f : Double) -> NlpposbilstmNode {
  let result = nlp_pos_bilstm_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_pos_bilstm_node_add(a : NlpposbilstmNode, b : NlpposbilstmNode) -> NlpposbilstmNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_pos_bilstm_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_pos_bilstm_node_copy(s : NlpposbilstmNode) -> NlpposbilstmNode {
  let result = nlp_pos_bilstm_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_pos_bilstm_node_fill(s : NlpposbilstmNode, v : Double) -> NlpposbilstmNode {
  let result = nlp_pos_bilstm_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_bilstm_node_min(s : NlpposbilstmNode) -> Double { @_common.min(s.data) }

pub fn nlp_pos_bilstm_node_max(s : NlpposbilstmNode) -> Double { @_common.max(s.data) }

pub fn nlp_pos_bilstm_node_to_string(s : NlpposbilstmNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpposbilstmEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_bilstm_edge_make(size : Int) -> NlpposbilstmEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_bilstm_edge_len(s : NlpposbilstmEdge) -> Int { s.size }

pub fn nlp_pos_bilstm_edge_get(s : NlpposbilstmEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_bilstm_edge_set(s : NlpposbilstmEdge, i : Int, v : Double) -> NlpposbilstmEdge {
  let result = nlp_pos_bilstm_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_bilstm_edge_sum(s : NlpposbilstmEdge) -> Double { @_common.sum(s.data) }

pub fn nlp_pos_bilstm_edge_mean(s : NlpposbilstmEdge) -> Double { @_common.mean(s.data) }

pub fn nlp_pos_bilstm_edge_scale(s : NlpposbilstmEdge, f : Double) -> NlpposbilstmEdge {
  let result = nlp_pos_bilstm_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_pos_bilstm_edge_add(a : NlpposbilstmEdge, b : NlpposbilstmEdge) -> NlpposbilstmEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_pos_bilstm_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_pos_bilstm_edge_copy(s : NlpposbilstmEdge) -> NlpposbilstmEdge {
  let result = nlp_pos_bilstm_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_pos_bilstm_edge_fill(s : NlpposbilstmEdge, v : Double) -> NlpposbilstmEdge {
  let result = nlp_pos_bilstm_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_bilstm_edge_min(s : NlpposbilstmEdge) -> Double { @_common.min(s.data) }

pub fn nlp_pos_bilstm_edge_max(s : NlpposbilstmEdge) -> Double { @_common.max(s.data) }

pub fn nlp_pos_bilstm_edge_to_string(s : NlpposbilstmEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpposbilstmPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_bilstm_path_make(size : Int) -> NlpposbilstmPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_bilstm_path_len(s : NlpposbilstmPath) -> Int { s.size }

pub fn nlp_pos_bilstm_path_get(s : NlpposbilstmPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_bilstm_path_set(s : NlpposbilstmPath, i : Int, v : Double) -> NlpposbilstmPath {
  let result = nlp_pos_bilstm_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_bilstm_path_sum(s : NlpposbilstmPath) -> Double { @_common.sum(s.data) }

pub fn nlp_pos_bilstm_path_mean(s : NlpposbilstmPath) -> Double { @_common.mean(s.data) }

pub fn nlp_pos_bilstm_path_scale(s : NlpposbilstmPath, f : Double) -> NlpposbilstmPath {
  let result = nlp_pos_bilstm_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_pos_bilstm_path_add(a : NlpposbilstmPath, b : NlpposbilstmPath) -> NlpposbilstmPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_pos_bilstm_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_pos_bilstm_path_copy(s : NlpposbilstmPath) -> NlpposbilstmPath {
  let result = nlp_pos_bilstm_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_pos_bilstm_path_fill(s : NlpposbilstmPath, v : Double) -> NlpposbilstmPath {
  let result = nlp_pos_bilstm_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_bilstm_path_min(s : NlpposbilstmPath) -> Double { @_common.min(s.data) }

pub fn nlp_pos_bilstm_path_max(s : NlpposbilstmPath) -> Double { @_common.max(s.data) }

pub fn nlp_pos_bilstm_path_to_string(s : NlpposbilstmPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpposbilstmCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_bilstm_cluster_make(size : Int) -> NlpposbilstmCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_bilstm_cluster_len(s : NlpposbilstmCluster) -> Int { s.size }

pub fn nlp_pos_bilstm_cluster_get(s : NlpposbilstmCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_bilstm_cluster_set(s : NlpposbilstmCluster, i : Int, v : Double) -> NlpposbilstmCluster {
  let result = nlp_pos_bilstm_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_bilstm_cluster_sum(s : NlpposbilstmCluster) -> Double { @_common.sum(s.data) }

pub fn nlp_pos_bilstm_cluster_mean(s : NlpposbilstmCluster) -> Double { @_common.mean(s.data) }

pub fn nlp_pos_bilstm_cluster_scale(s : NlpposbilstmCluster, f : Double) -> NlpposbilstmCluster {
  let result = nlp_pos_bilstm_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_pos_bilstm_cluster_add(a : NlpposbilstmCluster, b : NlpposbilstmCluster) -> NlpposbilstmCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_pos_bilstm_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_pos_bilstm_cluster_copy(s : NlpposbilstmCluster) -> NlpposbilstmCluster {
  let result = nlp_pos_bilstm_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_pos_bilstm_cluster_fill(s : NlpposbilstmCluster, v : Double) -> NlpposbilstmCluster {
  let result = nlp_pos_bilstm_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_bilstm_cluster_min(s : NlpposbilstmCluster) -> Double { @_common.min(s.data) }

pub fn nlp_pos_bilstm_cluster_max(s : NlpposbilstmCluster) -> Double { @_common.max(s.data) }

pub fn nlp_pos_bilstm_cluster_to_string(s : NlpposbilstmCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpposbilstmModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_bilstm_model_make(size : Int) -> NlpposbilstmModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_bilstm_model_len(s : NlpposbilstmModel) -> Int { s.size }

pub fn nlp_pos_bilstm_model_get(s : NlpposbilstmModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_bilstm_model_set(s : NlpposbilstmModel, i : Int, v : Double) -> NlpposbilstmModel {
  let result = nlp_pos_bilstm_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_bilstm_model_sum(s : NlpposbilstmModel) -> Double { @_common.sum(s.data) }

pub fn nlp_pos_bilstm_model_mean(s : NlpposbilstmModel) -> Double { @_common.mean(s.data) }

pub fn nlp_pos_bilstm_model_scale(s : NlpposbilstmModel, f : Double) -> NlpposbilstmModel {
  let result = nlp_pos_bilstm_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_pos_bilstm_model_add(a : NlpposbilstmModel, b : NlpposbilstmModel) -> NlpposbilstmModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_pos_bilstm_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_pos_bilstm_model_copy(s : NlpposbilstmModel) -> NlpposbilstmModel {
  let result = nlp_pos_bilstm_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_pos_bilstm_model_fill(s : NlpposbilstmModel, v : Double) -> NlpposbilstmModel {
  let result = nlp_pos_bilstm_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_bilstm_model_min(s : NlpposbilstmModel) -> Double { @_common.min(s.data) }

pub fn nlp_pos_bilstm_model_max(s : NlpposbilstmModel) -> Double { @_common.max(s.data) }

pub fn nlp_pos_bilstm_model_to_string(s : NlpposbilstmModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpposbilstmLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_bilstm_layer_make(size : Int) -> NlpposbilstmLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_bilstm_layer_len(s : NlpposbilstmLayer) -> Int { s.size }

pub fn nlp_pos_bilstm_layer_get(s : NlpposbilstmLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_bilstm_layer_set(s : NlpposbilstmLayer, i : Int, v : Double) -> NlpposbilstmLayer {
  let result = nlp_pos_bilstm_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_bilstm_layer_sum(s : NlpposbilstmLayer) -> Double { @_common.sum(s.data) }

pub fn nlp_pos_bilstm_layer_mean(s : NlpposbilstmLayer) -> Double { @_common.mean(s.data) }

pub fn nlp_pos_bilstm_layer_scale(s : NlpposbilstmLayer, f : Double) -> NlpposbilstmLayer {
  let result = nlp_pos_bilstm_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_pos_bilstm_layer_add(a : NlpposbilstmLayer, b : NlpposbilstmLayer) -> NlpposbilstmLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_pos_bilstm_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_pos_bilstm_layer_copy(s : NlpposbilstmLayer) -> NlpposbilstmLayer {
  let result = nlp_pos_bilstm_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_pos_bilstm_layer_fill(s : NlpposbilstmLayer, v : Double) -> NlpposbilstmLayer {
  let result = nlp_pos_bilstm_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_bilstm_layer_min(s : NlpposbilstmLayer) -> Double { @_common.min(s.data) }

pub fn nlp_pos_bilstm_layer_max(s : NlpposbilstmLayer) -> Double { @_common.max(s.data) }

pub fn nlp_pos_bilstm_layer_to_string(s : NlpposbilstmLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpposbilstmBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_bilstm_buffer_make(size : Int) -> NlpposbilstmBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_bilstm_buffer_len(s : NlpposbilstmBuffer) -> Int { s.size }

pub fn nlp_pos_bilstm_buffer_get(s : NlpposbilstmBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_bilstm_buffer_set(s : NlpposbilstmBuffer, i : Int, v : Double) -> NlpposbilstmBuffer {
  let result = nlp_pos_bilstm_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_bilstm_buffer_sum(s : NlpposbilstmBuffer) -> Double { @_common.sum(s.data) }

pub fn nlp_pos_bilstm_buffer_mean(s : NlpposbilstmBuffer) -> Double { @_common.mean(s.data) }

pub fn nlp_pos_bilstm_buffer_scale(s : NlpposbilstmBuffer, f : Double) -> NlpposbilstmBuffer {
  let result = nlp_pos_bilstm_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_pos_bilstm_buffer_add(a : NlpposbilstmBuffer, b : NlpposbilstmBuffer) -> NlpposbilstmBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_pos_bilstm_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_pos_bilstm_buffer_copy(s : NlpposbilstmBuffer) -> NlpposbilstmBuffer {
  let result = nlp_pos_bilstm_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_pos_bilstm_buffer_fill(s : NlpposbilstmBuffer, v : Double) -> NlpposbilstmBuffer {
  let result = nlp_pos_bilstm_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_bilstm_buffer_min(s : NlpposbilstmBuffer) -> Double { @_common.min(s.data) }

pub fn nlp_pos_bilstm_buffer_max(s : NlpposbilstmBuffer) -> Double { @_common.max(s.data) }

pub fn nlp_pos_bilstm_buffer_to_string(s : NlpposbilstmBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpposbilstmCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_bilstm_cursor_make(size : Int) -> NlpposbilstmCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_bilstm_cursor_len(s : NlpposbilstmCursor) -> Int { s.size }

pub fn nlp_pos_bilstm_cursor_get(s : NlpposbilstmCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_bilstm_cursor_set(s : NlpposbilstmCursor, i : Int, v : Double) -> NlpposbilstmCursor {
  let result = nlp_pos_bilstm_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_bilstm_cursor_sum(s : NlpposbilstmCursor) -> Double { @_common.sum(s.data) }

pub fn nlp_pos_bilstm_cursor_mean(s : NlpposbilstmCursor) -> Double { @_common.mean(s.data) }

pub fn nlp_pos_bilstm_cursor_scale(s : NlpposbilstmCursor, f : Double) -> NlpposbilstmCursor {
  let result = nlp_pos_bilstm_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_pos_bilstm_cursor_add(a : NlpposbilstmCursor, b : NlpposbilstmCursor) -> NlpposbilstmCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_pos_bilstm_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_pos_bilstm_cursor_copy(s : NlpposbilstmCursor) -> NlpposbilstmCursor {
  let result = nlp_pos_bilstm_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_pos_bilstm_cursor_fill(s : NlpposbilstmCursor, v : Double) -> NlpposbilstmCursor {
  let result = nlp_pos_bilstm_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_bilstm_cursor_min(s : NlpposbilstmCursor) -> Double { @_common.min(s.data) }

pub fn nlp_pos_bilstm_cursor_max(s : NlpposbilstmCursor) -> Double { @_common.max(s.data) }

pub fn nlp_pos_bilstm_cursor_to_string(s : NlpposbilstmCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpposbilstmView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_bilstm_view_make(size : Int) -> NlpposbilstmView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_bilstm_view_len(s : NlpposbilstmView) -> Int { s.size }

pub fn nlp_pos_bilstm_view_get(s : NlpposbilstmView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_bilstm_view_set(s : NlpposbilstmView, i : Int, v : Double) -> NlpposbilstmView {
  let result = nlp_pos_bilstm_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_bilstm_view_sum(s : NlpposbilstmView) -> Double { @_common.sum(s.data) }

pub fn nlp_pos_bilstm_view_mean(s : NlpposbilstmView) -> Double { @_common.mean(s.data) }

pub fn nlp_pos_bilstm_view_scale(s : NlpposbilstmView, f : Double) -> NlpposbilstmView {
  let result = nlp_pos_bilstm_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_pos_bilstm_view_add(a : NlpposbilstmView, b : NlpposbilstmView) -> NlpposbilstmView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_pos_bilstm_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_pos_bilstm_view_copy(s : NlpposbilstmView) -> NlpposbilstmView {
  let result = nlp_pos_bilstm_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_pos_bilstm_view_fill(s : NlpposbilstmView, v : Double) -> NlpposbilstmView {
  let result = nlp_pos_bilstm_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_bilstm_view_min(s : NlpposbilstmView) -> Double { @_common.min(s.data) }

pub fn nlp_pos_bilstm_view_max(s : NlpposbilstmView) -> Double { @_common.max(s.data) }

pub fn nlp_pos_bilstm_view_to_string(s : NlpposbilstmView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpposbilstmRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_bilstm_range_make(size : Int) -> NlpposbilstmRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_bilstm_range_len(s : NlpposbilstmRange) -> Int { s.size }

pub fn nlp_pos_bilstm_range_get(s : NlpposbilstmRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_bilstm_range_set(s : NlpposbilstmRange, i : Int, v : Double) -> NlpposbilstmRange {
  let result = nlp_pos_bilstm_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_bilstm_range_sum(s : NlpposbilstmRange) -> Double { @_common.sum(s.data) }

pub fn nlp_pos_bilstm_range_mean(s : NlpposbilstmRange) -> Double { @_common.mean(s.data) }

pub fn nlp_pos_bilstm_range_scale(s : NlpposbilstmRange, f : Double) -> NlpposbilstmRange {
  let result = nlp_pos_bilstm_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_pos_bilstm_range_add(a : NlpposbilstmRange, b : NlpposbilstmRange) -> NlpposbilstmRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_pos_bilstm_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_pos_bilstm_range_copy(s : NlpposbilstmRange) -> NlpposbilstmRange {
  let result = nlp_pos_bilstm_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_pos_bilstm_range_fill(s : NlpposbilstmRange, v : Double) -> NlpposbilstmRange {
  let result = nlp_pos_bilstm_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_bilstm_range_min(s : NlpposbilstmRange) -> Double { @_common.min(s.data) }

pub fn nlp_pos_bilstm_range_max(s : NlpposbilstmRange) -> Double { @_common.max(s.data) }

pub fn nlp_pos_bilstm_range_to_string(s : NlpposbilstmRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpposbilstmSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_bilstm_slice_make(size : Int) -> NlpposbilstmSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_bilstm_slice_len(s : NlpposbilstmSlice) -> Int { s.size }

pub fn nlp_pos_bilstm_slice_get(s : NlpposbilstmSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_bilstm_slice_set(s : NlpposbilstmSlice, i : Int, v : Double) -> NlpposbilstmSlice {
  let result = nlp_pos_bilstm_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_bilstm_slice_sum(s : NlpposbilstmSlice) -> Double { @_common.sum(s.data) }

pub fn nlp_pos_bilstm_slice_mean(s : NlpposbilstmSlice) -> Double { @_common.mean(s.data) }

pub fn nlp_pos_bilstm_slice_scale(s : NlpposbilstmSlice, f : Double) -> NlpposbilstmSlice {
  let result = nlp_pos_bilstm_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_pos_bilstm_slice_add(a : NlpposbilstmSlice, b : NlpposbilstmSlice) -> NlpposbilstmSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_pos_bilstm_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_pos_bilstm_slice_copy(s : NlpposbilstmSlice) -> NlpposbilstmSlice {
  let result = nlp_pos_bilstm_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_pos_bilstm_slice_fill(s : NlpposbilstmSlice, v : Double) -> NlpposbilstmSlice {
  let result = nlp_pos_bilstm_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_bilstm_slice_min(s : NlpposbilstmSlice) -> Double { @_common.min(s.data) }

pub fn nlp_pos_bilstm_slice_max(s : NlpposbilstmSlice) -> Double { @_common.max(s.data) }

pub fn nlp_pos_bilstm_slice_to_string(s : NlpposbilstmSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

