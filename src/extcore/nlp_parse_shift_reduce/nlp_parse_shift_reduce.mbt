///===
/// extcore/nlp_parse_shift_reduce

pub(all) struct NlpparseshiftreducePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn nlp_parse_shift_reduce_make_point(x : Double, y : Double) -> NlpparseshiftreducePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn nlp_parse_shift_reduce_make_point3(x : Double, y : Double, z : Double) -> NlpparseshiftreducePoint {
  { x, y, z, label: 0 }
}

pub fn nlp_parse_shift_reduce_point_x(pt : NlpparseshiftreducePoint) -> Double { pt.x }

pub fn nlp_parse_shift_reduce_point_y(pt : NlpparseshiftreducePoint) -> Double { pt.y }

pub fn nlp_parse_shift_reduce_point_z(pt : NlpparseshiftreducePoint) -> Double { pt.z }

pub fn nlp_parse_shift_reduce_point_label(pt : NlpparseshiftreducePoint) -> Int { pt.label }

pub fn nlp_parse_shift_reduce_point_dist(a : NlpparseshiftreducePoint, b : NlpparseshiftreducePoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn nlp_parse_shift_reduce_point_add(a : NlpparseshiftreducePoint, b : NlpparseshiftreducePoint) -> NlpparseshiftreducePoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn nlp_parse_shift_reduce_point_sub(a : NlpparseshiftreducePoint, b : NlpparseshiftreducePoint) -> NlpparseshiftreducePoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn nlp_parse_shift_reduce_point_scale(pt : NlpparseshiftreducePoint, s : Double) -> NlpparseshiftreducePoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn nlp_parse_shift_reduce_point_dot(a : NlpparseshiftreducePoint, b : NlpparseshiftreducePoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn nlp_parse_shift_reduce_point_cross(a : NlpparseshiftreducePoint, b : NlpparseshiftreducePoint) -> NlpparseshiftreducePoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn nlp_parse_shift_reduce_point_norm(pt : NlpparseshiftreducePoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn nlp_parse_shift_reduce_point_normalize(pt : NlpparseshiftreducePoint) -> NlpparseshiftreducePoint {
  let n = nlp_parse_shift_reduce_point_norm(pt)
  if n < 0.0000001 { pt } else { nlp_parse_shift_reduce_point_scale(pt, 1.0 / n) }
}

pub fn nlp_parse_shift_reduce_point_negate(pt : NlpparseshiftreducePoint) -> NlpparseshiftreducePoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn nlp_parse_shift_reduce_point_mid(a : NlpparseshiftreducePoint, b : NlpparseshiftreducePoint) -> NlpparseshiftreducePoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn nlp_parse_shift_reduce_point_lerp(a : NlpparseshiftreducePoint, b : NlpparseshiftreducePoint, t : Double) -> NlpparseshiftreducePoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn nlp_parse_shift_reduce_point_to_string(pt : NlpparseshiftreducePoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct NlpparseshiftreduceSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn nlp_parse_shift_reduce_make_series(vals : Array[Double], name : String) -> NlpparseshiftreduceSeries {
  { vals, name, meta: 0 }
}

pub fn nlp_parse_shift_reduce_series_len(s : NlpparseshiftreduceSeries) -> Int { s.vals.length() }

pub fn nlp_parse_shift_reduce_series_sum(s : NlpparseshiftreduceSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn nlp_parse_shift_reduce_series_mean(s : NlpparseshiftreduceSeries) -> Double { @_common.mean(s.vals) }

pub fn nlp_parse_shift_reduce_series_min(s : NlpparseshiftreduceSeries) -> Double { @_common.min(s.vals) }

pub fn nlp_parse_shift_reduce_series_max(s : NlpparseshiftreduceSeries) -> Double { @_common.max(s.vals) }

pub fn nlp_parse_shift_reduce_series_range(s : NlpparseshiftreduceSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn nlp_parse_shift_reduce_series_var(s : NlpparseshiftreduceSeries) -> Double { @_common.variance(s.vals) }

pub fn nlp_parse_shift_reduce_series_std(s : NlpparseshiftreduceSeries) -> Double { @_common.std(s.vals) }

pub fn nlp_parse_shift_reduce_series_median(s : NlpparseshiftreduceSeries) -> Double { @_common.median(s.vals) }

pub fn nlp_parse_shift_reduce_series_scale(s : NlpparseshiftreduceSeries, f : Double) -> NlpparseshiftreduceSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn nlp_parse_shift_reduce_series_add(a : NlpparseshiftreduceSeries, b : NlpparseshiftreduceSeries) -> NlpparseshiftreduceSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn nlp_parse_shift_reduce_series_sub(a : NlpparseshiftreduceSeries, b : NlpparseshiftreduceSeries) -> NlpparseshiftreduceSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn nlp_parse_shift_reduce_series_normalize(s : NlpparseshiftreduceSeries) -> NlpparseshiftreduceSeries {
  let mn = nlp_parse_shift_reduce_series_min(s)
  let mx = nlp_parse_shift_reduce_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn nlp_parse_shift_reduce_series_cumsum(s : NlpparseshiftreduceSeries) -> NlpparseshiftreduceSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn nlp_parse_shift_reduce_series_to_string(s : NlpparseshiftreduceSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NlpparseshiftreduceMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn nlp_parse_shift_reduce_make_matrix(rows : Int, cols : Int, val : Double) -> NlpparseshiftreduceMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn nlp_parse_shift_reduce_matrix_identity(n : Int) -> NlpparseshiftreduceMatrix {
  let m = nlp_parse_shift_reduce_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn nlp_parse_shift_reduce_matrix_get(m : NlpparseshiftreduceMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn nlp_parse_shift_reduce_matrix_transpose(m : NlpparseshiftreduceMatrix) -> NlpparseshiftreduceMatrix {
  let result = nlp_parse_shift_reduce_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn nlp_parse_shift_reduce_matrix_add(a : NlpparseshiftreduceMatrix, b : NlpparseshiftreduceMatrix) -> NlpparseshiftreduceMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = nlp_parse_shift_reduce_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn nlp_parse_shift_reduce_matrix_scale(m : NlpparseshiftreduceMatrix, s : Double) -> NlpparseshiftreduceMatrix {
  let result = nlp_parse_shift_reduce_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn nlp_parse_shift_reduce_matrix_multiply(a : NlpparseshiftreduceMatrix, b : NlpparseshiftreduceMatrix) -> NlpparseshiftreduceMatrix {
  if a.cols != b.rows { return nlp_parse_shift_reduce_make_matrix(a.rows, b.cols, 0.0) }
  let result = nlp_parse_shift_reduce_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn nlp_parse_shift_reduce_matrix_trace(m : NlpparseshiftreduceMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn nlp_parse_shift_reduce_matrix_det(m : NlpparseshiftreduceMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn nlp_parse_shift_reduce_matrix_norm(m : NlpparseshiftreduceMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn nlp_parse_shift_reduce_matrix_to_string(m : NlpparseshiftreduceMatrix) -> String {
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

pub(all) struct NlpparseshiftreduceVector {
  comps : Array[Double]
  dim : Int
}

pub fn nlp_parse_shift_reduce_make_vector(comps : Array[Double]) -> NlpparseshiftreduceVector {
  { comps, dim: comps.length() }
}

pub fn nlp_parse_shift_reduce_vector_zero(dim : Int) -> NlpparseshiftreduceVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn nlp_parse_shift_reduce_vector_add(a : NlpparseshiftreduceVector, b : NlpparseshiftreduceVector) -> NlpparseshiftreduceVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn nlp_parse_shift_reduce_vector_sub(a : NlpparseshiftreduceVector, b : NlpparseshiftreduceVector) -> NlpparseshiftreduceVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn nlp_parse_shift_reduce_vector_scale(v : NlpparseshiftreduceVector, s : Double) -> NlpparseshiftreduceVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn nlp_parse_shift_reduce_vector_dot(a : NlpparseshiftreduceVector, b : NlpparseshiftreduceVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn nlp_parse_shift_reduce_vector_norm(v : NlpparseshiftreduceVector) -> Double { @_common.sqrt(nlp_parse_shift_reduce_vector_dot(v, v)) }

pub fn nlp_parse_shift_reduce_vector_normalize(v : NlpparseshiftreduceVector) -> NlpparseshiftreduceVector {
  let n = nlp_parse_shift_reduce_vector_norm(v)
  if n < 0.0000001 { v } else { nlp_parse_shift_reduce_vector_scale(v, 1.0 / n) }
}

pub fn nlp_parse_shift_reduce_vector_dist(a : NlpparseshiftreduceVector, b : NlpparseshiftreduceVector) -> Double {
  nlp_parse_shift_reduce_vector_norm(nlp_parse_shift_reduce_vector_sub(a, b))
}

pub fn nlp_parse_shift_reduce_vector_to_string(v : NlpparseshiftreduceVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn nlp_parse_shift_reduce_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn nlp_parse_shift_reduce_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn nlp_parse_shift_reduce_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn nlp_parse_shift_reduce_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn nlp_parse_shift_reduce_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn nlp_parse_shift_reduce_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn nlp_parse_shift_reduce_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn nlp_parse_shift_reduce_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn nlp_parse_shift_reduce_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn nlp_parse_shift_reduce_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn nlp_parse_shift_reduce_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn nlp_parse_shift_reduce_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn nlp_parse_shift_reduce_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn nlp_parse_shift_reduce_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn nlp_parse_shift_reduce_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn nlp_parse_shift_reduce_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn nlp_parse_shift_reduce_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn nlp_parse_shift_reduce_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn nlp_parse_shift_reduce_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn nlp_parse_shift_reduce_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn nlp_parse_shift_reduce_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn nlp_parse_shift_reduce_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn nlp_parse_shift_reduce_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn nlp_parse_shift_reduce_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn nlp_parse_shift_reduce_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn nlp_parse_shift_reduce_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn nlp_parse_shift_reduce_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn nlp_parse_shift_reduce_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn nlp_parse_shift_reduce_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct NlpparseshiftreduceFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_shift_reduce_frame_make(size : Int) -> NlpparseshiftreduceFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_shift_reduce_frame_len(s : NlpparseshiftreduceFrame) -> Int { s.size }

pub fn nlp_parse_shift_reduce_frame_get(s : NlpparseshiftreduceFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_shift_reduce_frame_set(s : NlpparseshiftreduceFrame, i : Int, v : Double) -> NlpparseshiftreduceFrame {
  let result = nlp_parse_shift_reduce_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_shift_reduce_frame_sum(s : NlpparseshiftreduceFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_parse_shift_reduce_frame_mean(s : NlpparseshiftreduceFrame) -> Double {
  if s.size == 0 { 0.0 } else { nlp_parse_shift_reduce_frame_sum(s) / s.size.to_double() }
}

pub fn nlp_parse_shift_reduce_frame_scale(s : NlpparseshiftreduceFrame, f : Double) -> NlpparseshiftreduceFrame {
  let result = nlp_parse_shift_reduce_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_parse_shift_reduce_frame_add(a : NlpparseshiftreduceFrame, b : NlpparseshiftreduceFrame) -> NlpparseshiftreduceFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_parse_shift_reduce_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_parse_shift_reduce_frame_copy(s : NlpparseshiftreduceFrame) -> NlpparseshiftreduceFrame {
  let result = nlp_parse_shift_reduce_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_parse_shift_reduce_frame_fill(s : NlpparseshiftreduceFrame, v : Double) -> NlpparseshiftreduceFrame {
  let result = nlp_parse_shift_reduce_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_shift_reduce_frame_min(s : NlpparseshiftreduceFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_shift_reduce_frame_max(s : NlpparseshiftreduceFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_shift_reduce_frame_to_string(s : NlpparseshiftreduceFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparseshiftreduceTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_shift_reduce_table_make(size : Int) -> NlpparseshiftreduceTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_shift_reduce_table_len(s : NlpparseshiftreduceTable) -> Int { s.size }

pub fn nlp_parse_shift_reduce_table_get(s : NlpparseshiftreduceTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_shift_reduce_table_set(s : NlpparseshiftreduceTable, i : Int, v : Double) -> NlpparseshiftreduceTable {
  let result = nlp_parse_shift_reduce_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_shift_reduce_table_sum(s : NlpparseshiftreduceTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_parse_shift_reduce_table_mean(s : NlpparseshiftreduceTable) -> Double {
  if s.size == 0 { 0.0 } else { nlp_parse_shift_reduce_table_sum(s) / s.size.to_double() }
}

pub fn nlp_parse_shift_reduce_table_scale(s : NlpparseshiftreduceTable, f : Double) -> NlpparseshiftreduceTable {
  let result = nlp_parse_shift_reduce_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_parse_shift_reduce_table_add(a : NlpparseshiftreduceTable, b : NlpparseshiftreduceTable) -> NlpparseshiftreduceTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_parse_shift_reduce_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_parse_shift_reduce_table_copy(s : NlpparseshiftreduceTable) -> NlpparseshiftreduceTable {
  let result = nlp_parse_shift_reduce_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_parse_shift_reduce_table_fill(s : NlpparseshiftreduceTable, v : Double) -> NlpparseshiftreduceTable {
  let result = nlp_parse_shift_reduce_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_shift_reduce_table_min(s : NlpparseshiftreduceTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_shift_reduce_table_max(s : NlpparseshiftreduceTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_shift_reduce_table_to_string(s : NlpparseshiftreduceTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparseshiftreduceGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_shift_reduce_graphn_make(size : Int) -> NlpparseshiftreduceGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_shift_reduce_graphn_len(s : NlpparseshiftreduceGraphN) -> Int { s.size }

pub fn nlp_parse_shift_reduce_graphn_get(s : NlpparseshiftreduceGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_shift_reduce_graphn_set(s : NlpparseshiftreduceGraphN, i : Int, v : Double) -> NlpparseshiftreduceGraphN {
  let result = nlp_parse_shift_reduce_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_shift_reduce_graphn_sum(s : NlpparseshiftreduceGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_parse_shift_reduce_graphn_mean(s : NlpparseshiftreduceGraphN) -> Double {
  if s.size == 0 { 0.0 } else { nlp_parse_shift_reduce_graphn_sum(s) / s.size.to_double() }
}

pub fn nlp_parse_shift_reduce_graphn_scale(s : NlpparseshiftreduceGraphN, f : Double) -> NlpparseshiftreduceGraphN {
  let result = nlp_parse_shift_reduce_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_parse_shift_reduce_graphn_add(a : NlpparseshiftreduceGraphN, b : NlpparseshiftreduceGraphN) -> NlpparseshiftreduceGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_parse_shift_reduce_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_parse_shift_reduce_graphn_copy(s : NlpparseshiftreduceGraphN) -> NlpparseshiftreduceGraphN {
  let result = nlp_parse_shift_reduce_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_parse_shift_reduce_graphn_fill(s : NlpparseshiftreduceGraphN, v : Double) -> NlpparseshiftreduceGraphN {
  let result = nlp_parse_shift_reduce_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_shift_reduce_graphn_min(s : NlpparseshiftreduceGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_shift_reduce_graphn_max(s : NlpparseshiftreduceGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_shift_reduce_graphn_to_string(s : NlpparseshiftreduceGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparseshiftreduceNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_shift_reduce_node_make(size : Int) -> NlpparseshiftreduceNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_shift_reduce_node_len(s : NlpparseshiftreduceNode) -> Int { s.size }

pub fn nlp_parse_shift_reduce_node_get(s : NlpparseshiftreduceNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_shift_reduce_node_set(s : NlpparseshiftreduceNode, i : Int, v : Double) -> NlpparseshiftreduceNode {
  let result = nlp_parse_shift_reduce_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_shift_reduce_node_sum(s : NlpparseshiftreduceNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_parse_shift_reduce_node_mean(s : NlpparseshiftreduceNode) -> Double {
  if s.size == 0 { 0.0 } else { nlp_parse_shift_reduce_node_sum(s) / s.size.to_double() }
}

pub fn nlp_parse_shift_reduce_node_scale(s : NlpparseshiftreduceNode, f : Double) -> NlpparseshiftreduceNode {
  let result = nlp_parse_shift_reduce_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_parse_shift_reduce_node_add(a : NlpparseshiftreduceNode, b : NlpparseshiftreduceNode) -> NlpparseshiftreduceNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_parse_shift_reduce_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_parse_shift_reduce_node_copy(s : NlpparseshiftreduceNode) -> NlpparseshiftreduceNode {
  let result = nlp_parse_shift_reduce_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_parse_shift_reduce_node_fill(s : NlpparseshiftreduceNode, v : Double) -> NlpparseshiftreduceNode {
  let result = nlp_parse_shift_reduce_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_shift_reduce_node_min(s : NlpparseshiftreduceNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_shift_reduce_node_max(s : NlpparseshiftreduceNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_shift_reduce_node_to_string(s : NlpparseshiftreduceNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparseshiftreduceEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_shift_reduce_edge_make(size : Int) -> NlpparseshiftreduceEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_shift_reduce_edge_len(s : NlpparseshiftreduceEdge) -> Int { s.size }

pub fn nlp_parse_shift_reduce_edge_get(s : NlpparseshiftreduceEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_shift_reduce_edge_set(s : NlpparseshiftreduceEdge, i : Int, v : Double) -> NlpparseshiftreduceEdge {
  let result = nlp_parse_shift_reduce_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_shift_reduce_edge_sum(s : NlpparseshiftreduceEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_parse_shift_reduce_edge_mean(s : NlpparseshiftreduceEdge) -> Double {
  if s.size == 0 { 0.0 } else { nlp_parse_shift_reduce_edge_sum(s) / s.size.to_double() }
}

pub fn nlp_parse_shift_reduce_edge_scale(s : NlpparseshiftreduceEdge, f : Double) -> NlpparseshiftreduceEdge {
  let result = nlp_parse_shift_reduce_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_parse_shift_reduce_edge_add(a : NlpparseshiftreduceEdge, b : NlpparseshiftreduceEdge) -> NlpparseshiftreduceEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_parse_shift_reduce_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_parse_shift_reduce_edge_copy(s : NlpparseshiftreduceEdge) -> NlpparseshiftreduceEdge {
  let result = nlp_parse_shift_reduce_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_parse_shift_reduce_edge_fill(s : NlpparseshiftreduceEdge, v : Double) -> NlpparseshiftreduceEdge {
  let result = nlp_parse_shift_reduce_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_shift_reduce_edge_min(s : NlpparseshiftreduceEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_shift_reduce_edge_max(s : NlpparseshiftreduceEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_shift_reduce_edge_to_string(s : NlpparseshiftreduceEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparseshiftreducePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_shift_reduce_path_make(size : Int) -> NlpparseshiftreducePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_shift_reduce_path_len(s : NlpparseshiftreducePath) -> Int { s.size }

pub fn nlp_parse_shift_reduce_path_get(s : NlpparseshiftreducePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_shift_reduce_path_set(s : NlpparseshiftreducePath, i : Int, v : Double) -> NlpparseshiftreducePath {
  let result = nlp_parse_shift_reduce_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_shift_reduce_path_sum(s : NlpparseshiftreducePath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_parse_shift_reduce_path_mean(s : NlpparseshiftreducePath) -> Double {
  if s.size == 0 { 0.0 } else { nlp_parse_shift_reduce_path_sum(s) / s.size.to_double() }
}

pub fn nlp_parse_shift_reduce_path_scale(s : NlpparseshiftreducePath, f : Double) -> NlpparseshiftreducePath {
  let result = nlp_parse_shift_reduce_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_parse_shift_reduce_path_add(a : NlpparseshiftreducePath, b : NlpparseshiftreducePath) -> NlpparseshiftreducePath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_parse_shift_reduce_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_parse_shift_reduce_path_copy(s : NlpparseshiftreducePath) -> NlpparseshiftreducePath {
  let result = nlp_parse_shift_reduce_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_parse_shift_reduce_path_fill(s : NlpparseshiftreducePath, v : Double) -> NlpparseshiftreducePath {
  let result = nlp_parse_shift_reduce_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_shift_reduce_path_min(s : NlpparseshiftreducePath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_shift_reduce_path_max(s : NlpparseshiftreducePath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_shift_reduce_path_to_string(s : NlpparseshiftreducePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparseshiftreduceCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_shift_reduce_cluster_make(size : Int) -> NlpparseshiftreduceCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_shift_reduce_cluster_len(s : NlpparseshiftreduceCluster) -> Int { s.size }

pub fn nlp_parse_shift_reduce_cluster_get(s : NlpparseshiftreduceCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_shift_reduce_cluster_set(s : NlpparseshiftreduceCluster, i : Int, v : Double) -> NlpparseshiftreduceCluster {
  let result = nlp_parse_shift_reduce_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_shift_reduce_cluster_sum(s : NlpparseshiftreduceCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_parse_shift_reduce_cluster_mean(s : NlpparseshiftreduceCluster) -> Double {
  if s.size == 0 { 0.0 } else { nlp_parse_shift_reduce_cluster_sum(s) / s.size.to_double() }
}

pub fn nlp_parse_shift_reduce_cluster_scale(s : NlpparseshiftreduceCluster, f : Double) -> NlpparseshiftreduceCluster {
  let result = nlp_parse_shift_reduce_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_parse_shift_reduce_cluster_add(a : NlpparseshiftreduceCluster, b : NlpparseshiftreduceCluster) -> NlpparseshiftreduceCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_parse_shift_reduce_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_parse_shift_reduce_cluster_copy(s : NlpparseshiftreduceCluster) -> NlpparseshiftreduceCluster {
  let result = nlp_parse_shift_reduce_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_parse_shift_reduce_cluster_fill(s : NlpparseshiftreduceCluster, v : Double) -> NlpparseshiftreduceCluster {
  let result = nlp_parse_shift_reduce_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_shift_reduce_cluster_min(s : NlpparseshiftreduceCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_shift_reduce_cluster_max(s : NlpparseshiftreduceCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_shift_reduce_cluster_to_string(s : NlpparseshiftreduceCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparseshiftreduceModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_shift_reduce_model_make(size : Int) -> NlpparseshiftreduceModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_shift_reduce_model_len(s : NlpparseshiftreduceModel) -> Int { s.size }

pub fn nlp_parse_shift_reduce_model_get(s : NlpparseshiftreduceModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_shift_reduce_model_set(s : NlpparseshiftreduceModel, i : Int, v : Double) -> NlpparseshiftreduceModel {
  let result = nlp_parse_shift_reduce_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_shift_reduce_model_sum(s : NlpparseshiftreduceModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_parse_shift_reduce_model_mean(s : NlpparseshiftreduceModel) -> Double {
  if s.size == 0 { 0.0 } else { nlp_parse_shift_reduce_model_sum(s) / s.size.to_double() }
}

pub fn nlp_parse_shift_reduce_model_scale(s : NlpparseshiftreduceModel, f : Double) -> NlpparseshiftreduceModel {
  let result = nlp_parse_shift_reduce_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_parse_shift_reduce_model_add(a : NlpparseshiftreduceModel, b : NlpparseshiftreduceModel) -> NlpparseshiftreduceModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_parse_shift_reduce_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_parse_shift_reduce_model_copy(s : NlpparseshiftreduceModel) -> NlpparseshiftreduceModel {
  let result = nlp_parse_shift_reduce_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_parse_shift_reduce_model_fill(s : NlpparseshiftreduceModel, v : Double) -> NlpparseshiftreduceModel {
  let result = nlp_parse_shift_reduce_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_shift_reduce_model_min(s : NlpparseshiftreduceModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_shift_reduce_model_max(s : NlpparseshiftreduceModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_shift_reduce_model_to_string(s : NlpparseshiftreduceModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparseshiftreduceLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_shift_reduce_layer_make(size : Int) -> NlpparseshiftreduceLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_shift_reduce_layer_len(s : NlpparseshiftreduceLayer) -> Int { s.size }

pub fn nlp_parse_shift_reduce_layer_get(s : NlpparseshiftreduceLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_shift_reduce_layer_set(s : NlpparseshiftreduceLayer, i : Int, v : Double) -> NlpparseshiftreduceLayer {
  let result = nlp_parse_shift_reduce_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_shift_reduce_layer_sum(s : NlpparseshiftreduceLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_parse_shift_reduce_layer_mean(s : NlpparseshiftreduceLayer) -> Double {
  if s.size == 0 { 0.0 } else { nlp_parse_shift_reduce_layer_sum(s) / s.size.to_double() }
}

pub fn nlp_parse_shift_reduce_layer_scale(s : NlpparseshiftreduceLayer, f : Double) -> NlpparseshiftreduceLayer {
  let result = nlp_parse_shift_reduce_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_parse_shift_reduce_layer_add(a : NlpparseshiftreduceLayer, b : NlpparseshiftreduceLayer) -> NlpparseshiftreduceLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_parse_shift_reduce_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_parse_shift_reduce_layer_copy(s : NlpparseshiftreduceLayer) -> NlpparseshiftreduceLayer {
  let result = nlp_parse_shift_reduce_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_parse_shift_reduce_layer_fill(s : NlpparseshiftreduceLayer, v : Double) -> NlpparseshiftreduceLayer {
  let result = nlp_parse_shift_reduce_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_shift_reduce_layer_min(s : NlpparseshiftreduceLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_shift_reduce_layer_max(s : NlpparseshiftreduceLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_shift_reduce_layer_to_string(s : NlpparseshiftreduceLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparseshiftreduceBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_shift_reduce_buffer_make(size : Int) -> NlpparseshiftreduceBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_shift_reduce_buffer_len(s : NlpparseshiftreduceBuffer) -> Int { s.size }

pub fn nlp_parse_shift_reduce_buffer_get(s : NlpparseshiftreduceBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_shift_reduce_buffer_set(s : NlpparseshiftreduceBuffer, i : Int, v : Double) -> NlpparseshiftreduceBuffer {
  let result = nlp_parse_shift_reduce_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_shift_reduce_buffer_sum(s : NlpparseshiftreduceBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_parse_shift_reduce_buffer_mean(s : NlpparseshiftreduceBuffer) -> Double {
  if s.size == 0 { 0.0 } else { nlp_parse_shift_reduce_buffer_sum(s) / s.size.to_double() }
}

pub fn nlp_parse_shift_reduce_buffer_scale(s : NlpparseshiftreduceBuffer, f : Double) -> NlpparseshiftreduceBuffer {
  let result = nlp_parse_shift_reduce_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_parse_shift_reduce_buffer_add(a : NlpparseshiftreduceBuffer, b : NlpparseshiftreduceBuffer) -> NlpparseshiftreduceBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_parse_shift_reduce_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_parse_shift_reduce_buffer_copy(s : NlpparseshiftreduceBuffer) -> NlpparseshiftreduceBuffer {
  let result = nlp_parse_shift_reduce_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_parse_shift_reduce_buffer_fill(s : NlpparseshiftreduceBuffer, v : Double) -> NlpparseshiftreduceBuffer {
  let result = nlp_parse_shift_reduce_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_shift_reduce_buffer_min(s : NlpparseshiftreduceBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_shift_reduce_buffer_max(s : NlpparseshiftreduceBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_shift_reduce_buffer_to_string(s : NlpparseshiftreduceBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparseshiftreduceCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_shift_reduce_cursor_make(size : Int) -> NlpparseshiftreduceCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_shift_reduce_cursor_len(s : NlpparseshiftreduceCursor) -> Int { s.size }

pub fn nlp_parse_shift_reduce_cursor_get(s : NlpparseshiftreduceCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_shift_reduce_cursor_set(s : NlpparseshiftreduceCursor, i : Int, v : Double) -> NlpparseshiftreduceCursor {
  let result = nlp_parse_shift_reduce_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_shift_reduce_cursor_sum(s : NlpparseshiftreduceCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_parse_shift_reduce_cursor_mean(s : NlpparseshiftreduceCursor) -> Double {
  if s.size == 0 { 0.0 } else { nlp_parse_shift_reduce_cursor_sum(s) / s.size.to_double() }
}

pub fn nlp_parse_shift_reduce_cursor_scale(s : NlpparseshiftreduceCursor, f : Double) -> NlpparseshiftreduceCursor {
  let result = nlp_parse_shift_reduce_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_parse_shift_reduce_cursor_add(a : NlpparseshiftreduceCursor, b : NlpparseshiftreduceCursor) -> NlpparseshiftreduceCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_parse_shift_reduce_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_parse_shift_reduce_cursor_copy(s : NlpparseshiftreduceCursor) -> NlpparseshiftreduceCursor {
  let result = nlp_parse_shift_reduce_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_parse_shift_reduce_cursor_fill(s : NlpparseshiftreduceCursor, v : Double) -> NlpparseshiftreduceCursor {
  let result = nlp_parse_shift_reduce_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_shift_reduce_cursor_min(s : NlpparseshiftreduceCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_shift_reduce_cursor_max(s : NlpparseshiftreduceCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_shift_reduce_cursor_to_string(s : NlpparseshiftreduceCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparseshiftreduceView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_shift_reduce_view_make(size : Int) -> NlpparseshiftreduceView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_shift_reduce_view_len(s : NlpparseshiftreduceView) -> Int { s.size }

pub fn nlp_parse_shift_reduce_view_get(s : NlpparseshiftreduceView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_shift_reduce_view_set(s : NlpparseshiftreduceView, i : Int, v : Double) -> NlpparseshiftreduceView {
  let result = nlp_parse_shift_reduce_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_shift_reduce_view_sum(s : NlpparseshiftreduceView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_parse_shift_reduce_view_mean(s : NlpparseshiftreduceView) -> Double {
  if s.size == 0 { 0.0 } else { nlp_parse_shift_reduce_view_sum(s) / s.size.to_double() }
}

pub fn nlp_parse_shift_reduce_view_scale(s : NlpparseshiftreduceView, f : Double) -> NlpparseshiftreduceView {
  let result = nlp_parse_shift_reduce_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_parse_shift_reduce_view_add(a : NlpparseshiftreduceView, b : NlpparseshiftreduceView) -> NlpparseshiftreduceView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_parse_shift_reduce_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_parse_shift_reduce_view_copy(s : NlpparseshiftreduceView) -> NlpparseshiftreduceView {
  let result = nlp_parse_shift_reduce_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_parse_shift_reduce_view_fill(s : NlpparseshiftreduceView, v : Double) -> NlpparseshiftreduceView {
  let result = nlp_parse_shift_reduce_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_shift_reduce_view_min(s : NlpparseshiftreduceView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_shift_reduce_view_max(s : NlpparseshiftreduceView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_shift_reduce_view_to_string(s : NlpparseshiftreduceView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparseshiftreduceRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_shift_reduce_range_make(size : Int) -> NlpparseshiftreduceRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_shift_reduce_range_len(s : NlpparseshiftreduceRange) -> Int { s.size }

pub fn nlp_parse_shift_reduce_range_get(s : NlpparseshiftreduceRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_shift_reduce_range_set(s : NlpparseshiftreduceRange, i : Int, v : Double) -> NlpparseshiftreduceRange {
  let result = nlp_parse_shift_reduce_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_shift_reduce_range_sum(s : NlpparseshiftreduceRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_parse_shift_reduce_range_mean(s : NlpparseshiftreduceRange) -> Double {
  if s.size == 0 { 0.0 } else { nlp_parse_shift_reduce_range_sum(s) / s.size.to_double() }
}

pub fn nlp_parse_shift_reduce_range_scale(s : NlpparseshiftreduceRange, f : Double) -> NlpparseshiftreduceRange {
  let result = nlp_parse_shift_reduce_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_parse_shift_reduce_range_add(a : NlpparseshiftreduceRange, b : NlpparseshiftreduceRange) -> NlpparseshiftreduceRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_parse_shift_reduce_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_parse_shift_reduce_range_copy(s : NlpparseshiftreduceRange) -> NlpparseshiftreduceRange {
  let result = nlp_parse_shift_reduce_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_parse_shift_reduce_range_fill(s : NlpparseshiftreduceRange, v : Double) -> NlpparseshiftreduceRange {
  let result = nlp_parse_shift_reduce_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_shift_reduce_range_min(s : NlpparseshiftreduceRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_shift_reduce_range_max(s : NlpparseshiftreduceRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_shift_reduce_range_to_string(s : NlpparseshiftreduceRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparseshiftreduceSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_shift_reduce_slice_make(size : Int) -> NlpparseshiftreduceSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_shift_reduce_slice_len(s : NlpparseshiftreduceSlice) -> Int { s.size }

pub fn nlp_parse_shift_reduce_slice_get(s : NlpparseshiftreduceSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_shift_reduce_slice_set(s : NlpparseshiftreduceSlice, i : Int, v : Double) -> NlpparseshiftreduceSlice {
  let result = nlp_parse_shift_reduce_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_shift_reduce_slice_sum(s : NlpparseshiftreduceSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_parse_shift_reduce_slice_mean(s : NlpparseshiftreduceSlice) -> Double {
  if s.size == 0 { 0.0 } else { nlp_parse_shift_reduce_slice_sum(s) / s.size.to_double() }
}

pub fn nlp_parse_shift_reduce_slice_scale(s : NlpparseshiftreduceSlice, f : Double) -> NlpparseshiftreduceSlice {
  let result = nlp_parse_shift_reduce_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_parse_shift_reduce_slice_add(a : NlpparseshiftreduceSlice, b : NlpparseshiftreduceSlice) -> NlpparseshiftreduceSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_parse_shift_reduce_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_parse_shift_reduce_slice_copy(s : NlpparseshiftreduceSlice) -> NlpparseshiftreduceSlice {
  let result = nlp_parse_shift_reduce_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_parse_shift_reduce_slice_fill(s : NlpparseshiftreduceSlice, v : Double) -> NlpparseshiftreduceSlice {
  let result = nlp_parse_shift_reduce_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_shift_reduce_slice_min(s : NlpparseshiftreduceSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_shift_reduce_slice_max(s : NlpparseshiftreduceSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_shift_reduce_slice_to_string(s : NlpparseshiftreduceSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

