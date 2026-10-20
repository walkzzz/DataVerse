///===
/// extcore/ml_cluster_spectral

pub(all) struct MlclusterspectralPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_cluster_spectral_make_point(x : Double, y : Double) -> MlclusterspectralPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_cluster_spectral_make_point3(x : Double, y : Double, z : Double) -> MlclusterspectralPoint {
  { x, y, z, label: 0 }
}

pub fn ml_cluster_spectral_point_x(pt : MlclusterspectralPoint) -> Double { pt.x }

pub fn ml_cluster_spectral_point_y(pt : MlclusterspectralPoint) -> Double { pt.y }

pub fn ml_cluster_spectral_point_z(pt : MlclusterspectralPoint) -> Double { pt.z }

pub fn ml_cluster_spectral_point_label(pt : MlclusterspectralPoint) -> Int { pt.label }

pub fn ml_cluster_spectral_point_dist(a : MlclusterspectralPoint, b : MlclusterspectralPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ml_cluster_spectral_point_add(a : MlclusterspectralPoint, b : MlclusterspectralPoint) -> MlclusterspectralPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn ml_cluster_spectral_point_sub(a : MlclusterspectralPoint, b : MlclusterspectralPoint) -> MlclusterspectralPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn ml_cluster_spectral_point_scale(pt : MlclusterspectralPoint, s : Double) -> MlclusterspectralPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn ml_cluster_spectral_point_dot(a : MlclusterspectralPoint, b : MlclusterspectralPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn ml_cluster_spectral_point_cross(a : MlclusterspectralPoint, b : MlclusterspectralPoint) -> MlclusterspectralPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn ml_cluster_spectral_point_norm(pt : MlclusterspectralPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn ml_cluster_spectral_point_normalize(pt : MlclusterspectralPoint) -> MlclusterspectralPoint {
  let n = ml_cluster_spectral_point_norm(pt)
  if n < 0.0000001 { pt } else { ml_cluster_spectral_point_scale(pt, 1.0 / n) }
}

pub fn ml_cluster_spectral_point_negate(pt : MlclusterspectralPoint) -> MlclusterspectralPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn ml_cluster_spectral_point_mid(a : MlclusterspectralPoint, b : MlclusterspectralPoint) -> MlclusterspectralPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn ml_cluster_spectral_point_lerp(a : MlclusterspectralPoint, b : MlclusterspectralPoint, t : Double) -> MlclusterspectralPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn ml_cluster_spectral_point_to_string(pt : MlclusterspectralPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct MlclusterspectralSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_cluster_spectral_make_series(vals : Array[Double], name : String) -> MlclusterspectralSeries {
  { vals, name, meta: 0 }
}

pub fn ml_cluster_spectral_series_len(s : MlclusterspectralSeries) -> Int { s.vals.length() }

pub fn ml_cluster_spectral_series_sum(s : MlclusterspectralSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn ml_cluster_spectral_series_mean(s : MlclusterspectralSeries) -> Double { @_common.mean(s.vals) }

pub fn ml_cluster_spectral_series_min(s : MlclusterspectralSeries) -> Double { @_common.min(s.vals) }

pub fn ml_cluster_spectral_series_max(s : MlclusterspectralSeries) -> Double { @_common.max(s.vals) }

pub fn ml_cluster_spectral_series_range(s : MlclusterspectralSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn ml_cluster_spectral_series_var(s : MlclusterspectralSeries) -> Double { @_common.variance(s.vals) }

pub fn ml_cluster_spectral_series_std(s : MlclusterspectralSeries) -> Double { @_common.std(s.vals) }

pub fn ml_cluster_spectral_series_median(s : MlclusterspectralSeries) -> Double { @_common.median(s.vals) }

pub fn ml_cluster_spectral_series_scale(s : MlclusterspectralSeries, f : Double) -> MlclusterspectralSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn ml_cluster_spectral_series_add(a : MlclusterspectralSeries, b : MlclusterspectralSeries) -> MlclusterspectralSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn ml_cluster_spectral_series_sub(a : MlclusterspectralSeries, b : MlclusterspectralSeries) -> MlclusterspectralSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn ml_cluster_spectral_series_normalize(s : MlclusterspectralSeries) -> MlclusterspectralSeries {
  let mn = ml_cluster_spectral_series_min(s)
  let mx = ml_cluster_spectral_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn ml_cluster_spectral_series_cumsum(s : MlclusterspectralSeries) -> MlclusterspectralSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn ml_cluster_spectral_series_to_string(s : MlclusterspectralSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlclusterspectralMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_cluster_spectral_make_matrix(rows : Int, cols : Int, val : Double) -> MlclusterspectralMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_cluster_spectral_matrix_identity(n : Int) -> MlclusterspectralMatrix {
  let m = ml_cluster_spectral_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ml_cluster_spectral_matrix_get(m : MlclusterspectralMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn ml_cluster_spectral_matrix_transpose(m : MlclusterspectralMatrix) -> MlclusterspectralMatrix {
  let result = ml_cluster_spectral_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn ml_cluster_spectral_matrix_add(a : MlclusterspectralMatrix, b : MlclusterspectralMatrix) -> MlclusterspectralMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = ml_cluster_spectral_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn ml_cluster_spectral_matrix_scale(m : MlclusterspectralMatrix, s : Double) -> MlclusterspectralMatrix {
  let result = ml_cluster_spectral_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn ml_cluster_spectral_matrix_multiply(a : MlclusterspectralMatrix, b : MlclusterspectralMatrix) -> MlclusterspectralMatrix {
  if a.cols != b.rows { return ml_cluster_spectral_make_matrix(a.rows, b.cols, 0.0) }
  let result = ml_cluster_spectral_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ml_cluster_spectral_matrix_trace(m : MlclusterspectralMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn ml_cluster_spectral_matrix_det(m : MlclusterspectralMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ml_cluster_spectral_matrix_norm(m : MlclusterspectralMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ml_cluster_spectral_matrix_to_string(m : MlclusterspectralMatrix) -> String {
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

pub(all) struct MlclusterspectralVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_cluster_spectral_make_vector(comps : Array[Double]) -> MlclusterspectralVector {
  { comps, dim: comps.length() }
}

pub fn ml_cluster_spectral_vector_zero(dim : Int) -> MlclusterspectralVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ml_cluster_spectral_vector_add(a : MlclusterspectralVector, b : MlclusterspectralVector) -> MlclusterspectralVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ml_cluster_spectral_vector_sub(a : MlclusterspectralVector, b : MlclusterspectralVector) -> MlclusterspectralVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ml_cluster_spectral_vector_scale(v : MlclusterspectralVector, s : Double) -> MlclusterspectralVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn ml_cluster_spectral_vector_dot(a : MlclusterspectralVector, b : MlclusterspectralVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn ml_cluster_spectral_vector_norm(v : MlclusterspectralVector) -> Double { @_common.sqrt(ml_cluster_spectral_vector_dot(v, v)) }

pub fn ml_cluster_spectral_vector_normalize(v : MlclusterspectralVector) -> MlclusterspectralVector {
  let n = ml_cluster_spectral_vector_norm(v)
  if n < 0.0000001 { v } else { ml_cluster_spectral_vector_scale(v, 1.0 / n) }
}

pub fn ml_cluster_spectral_vector_dist(a : MlclusterspectralVector, b : MlclusterspectralVector) -> Double {
  ml_cluster_spectral_vector_norm(ml_cluster_spectral_vector_sub(a, b))
}

pub fn ml_cluster_spectral_vector_to_string(v : MlclusterspectralVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ml_cluster_spectral_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ml_cluster_spectral_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ml_cluster_spectral_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ml_cluster_spectral_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ml_cluster_spectral_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ml_cluster_spectral_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ml_cluster_spectral_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ml_cluster_spectral_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ml_cluster_spectral_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ml_cluster_spectral_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ml_cluster_spectral_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ml_cluster_spectral_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ml_cluster_spectral_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ml_cluster_spectral_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ml_cluster_spectral_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ml_cluster_spectral_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ml_cluster_spectral_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ml_cluster_spectral_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ml_cluster_spectral_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ml_cluster_spectral_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ml_cluster_spectral_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ml_cluster_spectral_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ml_cluster_spectral_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ml_cluster_spectral_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ml_cluster_spectral_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ml_cluster_spectral_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ml_cluster_spectral_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ml_cluster_spectral_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ml_cluster_spectral_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MlclusterspectralFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_spectral_frame_make(size : Int) -> MlclusterspectralFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_spectral_frame_len(s : MlclusterspectralFrame) -> Int { s.size }

pub fn ml_cluster_spectral_frame_get(s : MlclusterspectralFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_spectral_frame_set(s : MlclusterspectralFrame, i : Int, v : Double) -> MlclusterspectralFrame {
  let result = ml_cluster_spectral_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_spectral_frame_sum(s : MlclusterspectralFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_cluster_spectral_frame_mean(s : MlclusterspectralFrame) -> Double {
  if s.size == 0 { 0.0 } else { ml_cluster_spectral_frame_sum(s) / s.size.to_double() }
}

pub fn ml_cluster_spectral_frame_scale(s : MlclusterspectralFrame, f : Double) -> MlclusterspectralFrame {
  let result = ml_cluster_spectral_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_cluster_spectral_frame_add(a : MlclusterspectralFrame, b : MlclusterspectralFrame) -> MlclusterspectralFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_cluster_spectral_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_cluster_spectral_frame_copy(s : MlclusterspectralFrame) -> MlclusterspectralFrame {
  let result = ml_cluster_spectral_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_cluster_spectral_frame_fill(s : MlclusterspectralFrame, v : Double) -> MlclusterspectralFrame {
  let result = ml_cluster_spectral_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_spectral_frame_min(s : MlclusterspectralFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_spectral_frame_max(s : MlclusterspectralFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_spectral_frame_to_string(s : MlclusterspectralFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusterspectralTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_spectral_table_make(size : Int) -> MlclusterspectralTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_spectral_table_len(s : MlclusterspectralTable) -> Int { s.size }

pub fn ml_cluster_spectral_table_get(s : MlclusterspectralTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_spectral_table_set(s : MlclusterspectralTable, i : Int, v : Double) -> MlclusterspectralTable {
  let result = ml_cluster_spectral_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_spectral_table_sum(s : MlclusterspectralTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_cluster_spectral_table_mean(s : MlclusterspectralTable) -> Double {
  if s.size == 0 { 0.0 } else { ml_cluster_spectral_table_sum(s) / s.size.to_double() }
}

pub fn ml_cluster_spectral_table_scale(s : MlclusterspectralTable, f : Double) -> MlclusterspectralTable {
  let result = ml_cluster_spectral_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_cluster_spectral_table_add(a : MlclusterspectralTable, b : MlclusterspectralTable) -> MlclusterspectralTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_cluster_spectral_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_cluster_spectral_table_copy(s : MlclusterspectralTable) -> MlclusterspectralTable {
  let result = ml_cluster_spectral_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_cluster_spectral_table_fill(s : MlclusterspectralTable, v : Double) -> MlclusterspectralTable {
  let result = ml_cluster_spectral_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_spectral_table_min(s : MlclusterspectralTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_spectral_table_max(s : MlclusterspectralTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_spectral_table_to_string(s : MlclusterspectralTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusterspectralGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_spectral_graphn_make(size : Int) -> MlclusterspectralGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_spectral_graphn_len(s : MlclusterspectralGraphN) -> Int { s.size }

pub fn ml_cluster_spectral_graphn_get(s : MlclusterspectralGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_spectral_graphn_set(s : MlclusterspectralGraphN, i : Int, v : Double) -> MlclusterspectralGraphN {
  let result = ml_cluster_spectral_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_spectral_graphn_sum(s : MlclusterspectralGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_cluster_spectral_graphn_mean(s : MlclusterspectralGraphN) -> Double {
  if s.size == 0 { 0.0 } else { ml_cluster_spectral_graphn_sum(s) / s.size.to_double() }
}

pub fn ml_cluster_spectral_graphn_scale(s : MlclusterspectralGraphN, f : Double) -> MlclusterspectralGraphN {
  let result = ml_cluster_spectral_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_cluster_spectral_graphn_add(a : MlclusterspectralGraphN, b : MlclusterspectralGraphN) -> MlclusterspectralGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_cluster_spectral_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_cluster_spectral_graphn_copy(s : MlclusterspectralGraphN) -> MlclusterspectralGraphN {
  let result = ml_cluster_spectral_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_cluster_spectral_graphn_fill(s : MlclusterspectralGraphN, v : Double) -> MlclusterspectralGraphN {
  let result = ml_cluster_spectral_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_spectral_graphn_min(s : MlclusterspectralGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_spectral_graphn_max(s : MlclusterspectralGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_spectral_graphn_to_string(s : MlclusterspectralGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusterspectralNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_spectral_node_make(size : Int) -> MlclusterspectralNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_spectral_node_len(s : MlclusterspectralNode) -> Int { s.size }

pub fn ml_cluster_spectral_node_get(s : MlclusterspectralNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_spectral_node_set(s : MlclusterspectralNode, i : Int, v : Double) -> MlclusterspectralNode {
  let result = ml_cluster_spectral_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_spectral_node_sum(s : MlclusterspectralNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_cluster_spectral_node_mean(s : MlclusterspectralNode) -> Double {
  if s.size == 0 { 0.0 } else { ml_cluster_spectral_node_sum(s) / s.size.to_double() }
}

pub fn ml_cluster_spectral_node_scale(s : MlclusterspectralNode, f : Double) -> MlclusterspectralNode {
  let result = ml_cluster_spectral_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_cluster_spectral_node_add(a : MlclusterspectralNode, b : MlclusterspectralNode) -> MlclusterspectralNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_cluster_spectral_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_cluster_spectral_node_copy(s : MlclusterspectralNode) -> MlclusterspectralNode {
  let result = ml_cluster_spectral_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_cluster_spectral_node_fill(s : MlclusterspectralNode, v : Double) -> MlclusterspectralNode {
  let result = ml_cluster_spectral_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_spectral_node_min(s : MlclusterspectralNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_spectral_node_max(s : MlclusterspectralNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_spectral_node_to_string(s : MlclusterspectralNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusterspectralEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_spectral_edge_make(size : Int) -> MlclusterspectralEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_spectral_edge_len(s : MlclusterspectralEdge) -> Int { s.size }

pub fn ml_cluster_spectral_edge_get(s : MlclusterspectralEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_spectral_edge_set(s : MlclusterspectralEdge, i : Int, v : Double) -> MlclusterspectralEdge {
  let result = ml_cluster_spectral_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_spectral_edge_sum(s : MlclusterspectralEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_cluster_spectral_edge_mean(s : MlclusterspectralEdge) -> Double {
  if s.size == 0 { 0.0 } else { ml_cluster_spectral_edge_sum(s) / s.size.to_double() }
}

pub fn ml_cluster_spectral_edge_scale(s : MlclusterspectralEdge, f : Double) -> MlclusterspectralEdge {
  let result = ml_cluster_spectral_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_cluster_spectral_edge_add(a : MlclusterspectralEdge, b : MlclusterspectralEdge) -> MlclusterspectralEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_cluster_spectral_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_cluster_spectral_edge_copy(s : MlclusterspectralEdge) -> MlclusterspectralEdge {
  let result = ml_cluster_spectral_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_cluster_spectral_edge_fill(s : MlclusterspectralEdge, v : Double) -> MlclusterspectralEdge {
  let result = ml_cluster_spectral_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_spectral_edge_min(s : MlclusterspectralEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_spectral_edge_max(s : MlclusterspectralEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_spectral_edge_to_string(s : MlclusterspectralEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusterspectralPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_spectral_path_make(size : Int) -> MlclusterspectralPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_spectral_path_len(s : MlclusterspectralPath) -> Int { s.size }

pub fn ml_cluster_spectral_path_get(s : MlclusterspectralPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_spectral_path_set(s : MlclusterspectralPath, i : Int, v : Double) -> MlclusterspectralPath {
  let result = ml_cluster_spectral_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_spectral_path_sum(s : MlclusterspectralPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_cluster_spectral_path_mean(s : MlclusterspectralPath) -> Double {
  if s.size == 0 { 0.0 } else { ml_cluster_spectral_path_sum(s) / s.size.to_double() }
}

pub fn ml_cluster_spectral_path_scale(s : MlclusterspectralPath, f : Double) -> MlclusterspectralPath {
  let result = ml_cluster_spectral_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_cluster_spectral_path_add(a : MlclusterspectralPath, b : MlclusterspectralPath) -> MlclusterspectralPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_cluster_spectral_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_cluster_spectral_path_copy(s : MlclusterspectralPath) -> MlclusterspectralPath {
  let result = ml_cluster_spectral_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_cluster_spectral_path_fill(s : MlclusterspectralPath, v : Double) -> MlclusterspectralPath {
  let result = ml_cluster_spectral_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_spectral_path_min(s : MlclusterspectralPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_spectral_path_max(s : MlclusterspectralPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_spectral_path_to_string(s : MlclusterspectralPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusterspectralCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_spectral_cluster_make(size : Int) -> MlclusterspectralCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_spectral_cluster_len(s : MlclusterspectralCluster) -> Int { s.size }

pub fn ml_cluster_spectral_cluster_get(s : MlclusterspectralCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_spectral_cluster_set(s : MlclusterspectralCluster, i : Int, v : Double) -> MlclusterspectralCluster {
  let result = ml_cluster_spectral_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_spectral_cluster_sum(s : MlclusterspectralCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_cluster_spectral_cluster_mean(s : MlclusterspectralCluster) -> Double {
  if s.size == 0 { 0.0 } else { ml_cluster_spectral_cluster_sum(s) / s.size.to_double() }
}

pub fn ml_cluster_spectral_cluster_scale(s : MlclusterspectralCluster, f : Double) -> MlclusterspectralCluster {
  let result = ml_cluster_spectral_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_cluster_spectral_cluster_add(a : MlclusterspectralCluster, b : MlclusterspectralCluster) -> MlclusterspectralCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_cluster_spectral_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_cluster_spectral_cluster_copy(s : MlclusterspectralCluster) -> MlclusterspectralCluster {
  let result = ml_cluster_spectral_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_cluster_spectral_cluster_fill(s : MlclusterspectralCluster, v : Double) -> MlclusterspectralCluster {
  let result = ml_cluster_spectral_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_spectral_cluster_min(s : MlclusterspectralCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_spectral_cluster_max(s : MlclusterspectralCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_spectral_cluster_to_string(s : MlclusterspectralCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusterspectralModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_spectral_model_make(size : Int) -> MlclusterspectralModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_spectral_model_len(s : MlclusterspectralModel) -> Int { s.size }

pub fn ml_cluster_spectral_model_get(s : MlclusterspectralModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_spectral_model_set(s : MlclusterspectralModel, i : Int, v : Double) -> MlclusterspectralModel {
  let result = ml_cluster_spectral_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_spectral_model_sum(s : MlclusterspectralModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_cluster_spectral_model_mean(s : MlclusterspectralModel) -> Double {
  if s.size == 0 { 0.0 } else { ml_cluster_spectral_model_sum(s) / s.size.to_double() }
}

pub fn ml_cluster_spectral_model_scale(s : MlclusterspectralModel, f : Double) -> MlclusterspectralModel {
  let result = ml_cluster_spectral_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_cluster_spectral_model_add(a : MlclusterspectralModel, b : MlclusterspectralModel) -> MlclusterspectralModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_cluster_spectral_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_cluster_spectral_model_copy(s : MlclusterspectralModel) -> MlclusterspectralModel {
  let result = ml_cluster_spectral_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_cluster_spectral_model_fill(s : MlclusterspectralModel, v : Double) -> MlclusterspectralModel {
  let result = ml_cluster_spectral_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_spectral_model_min(s : MlclusterspectralModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_spectral_model_max(s : MlclusterspectralModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_spectral_model_to_string(s : MlclusterspectralModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusterspectralLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_spectral_layer_make(size : Int) -> MlclusterspectralLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_spectral_layer_len(s : MlclusterspectralLayer) -> Int { s.size }

pub fn ml_cluster_spectral_layer_get(s : MlclusterspectralLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_spectral_layer_set(s : MlclusterspectralLayer, i : Int, v : Double) -> MlclusterspectralLayer {
  let result = ml_cluster_spectral_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_spectral_layer_sum(s : MlclusterspectralLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_cluster_spectral_layer_mean(s : MlclusterspectralLayer) -> Double {
  if s.size == 0 { 0.0 } else { ml_cluster_spectral_layer_sum(s) / s.size.to_double() }
}

pub fn ml_cluster_spectral_layer_scale(s : MlclusterspectralLayer, f : Double) -> MlclusterspectralLayer {
  let result = ml_cluster_spectral_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_cluster_spectral_layer_add(a : MlclusterspectralLayer, b : MlclusterspectralLayer) -> MlclusterspectralLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_cluster_spectral_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_cluster_spectral_layer_copy(s : MlclusterspectralLayer) -> MlclusterspectralLayer {
  let result = ml_cluster_spectral_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_cluster_spectral_layer_fill(s : MlclusterspectralLayer, v : Double) -> MlclusterspectralLayer {
  let result = ml_cluster_spectral_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_spectral_layer_min(s : MlclusterspectralLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_spectral_layer_max(s : MlclusterspectralLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_spectral_layer_to_string(s : MlclusterspectralLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusterspectralBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_spectral_buffer_make(size : Int) -> MlclusterspectralBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_spectral_buffer_len(s : MlclusterspectralBuffer) -> Int { s.size }

pub fn ml_cluster_spectral_buffer_get(s : MlclusterspectralBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_spectral_buffer_set(s : MlclusterspectralBuffer, i : Int, v : Double) -> MlclusterspectralBuffer {
  let result = ml_cluster_spectral_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_spectral_buffer_sum(s : MlclusterspectralBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_cluster_spectral_buffer_mean(s : MlclusterspectralBuffer) -> Double {
  if s.size == 0 { 0.0 } else { ml_cluster_spectral_buffer_sum(s) / s.size.to_double() }
}

pub fn ml_cluster_spectral_buffer_scale(s : MlclusterspectralBuffer, f : Double) -> MlclusterspectralBuffer {
  let result = ml_cluster_spectral_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_cluster_spectral_buffer_add(a : MlclusterspectralBuffer, b : MlclusterspectralBuffer) -> MlclusterspectralBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_cluster_spectral_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_cluster_spectral_buffer_copy(s : MlclusterspectralBuffer) -> MlclusterspectralBuffer {
  let result = ml_cluster_spectral_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_cluster_spectral_buffer_fill(s : MlclusterspectralBuffer, v : Double) -> MlclusterspectralBuffer {
  let result = ml_cluster_spectral_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_spectral_buffer_min(s : MlclusterspectralBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_spectral_buffer_max(s : MlclusterspectralBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_spectral_buffer_to_string(s : MlclusterspectralBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusterspectralCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_spectral_cursor_make(size : Int) -> MlclusterspectralCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_spectral_cursor_len(s : MlclusterspectralCursor) -> Int { s.size }

pub fn ml_cluster_spectral_cursor_get(s : MlclusterspectralCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_spectral_cursor_set(s : MlclusterspectralCursor, i : Int, v : Double) -> MlclusterspectralCursor {
  let result = ml_cluster_spectral_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_spectral_cursor_sum(s : MlclusterspectralCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_cluster_spectral_cursor_mean(s : MlclusterspectralCursor) -> Double {
  if s.size == 0 { 0.0 } else { ml_cluster_spectral_cursor_sum(s) / s.size.to_double() }
}

pub fn ml_cluster_spectral_cursor_scale(s : MlclusterspectralCursor, f : Double) -> MlclusterspectralCursor {
  let result = ml_cluster_spectral_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_cluster_spectral_cursor_add(a : MlclusterspectralCursor, b : MlclusterspectralCursor) -> MlclusterspectralCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_cluster_spectral_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_cluster_spectral_cursor_copy(s : MlclusterspectralCursor) -> MlclusterspectralCursor {
  let result = ml_cluster_spectral_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_cluster_spectral_cursor_fill(s : MlclusterspectralCursor, v : Double) -> MlclusterspectralCursor {
  let result = ml_cluster_spectral_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_spectral_cursor_min(s : MlclusterspectralCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_spectral_cursor_max(s : MlclusterspectralCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_spectral_cursor_to_string(s : MlclusterspectralCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusterspectralView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_spectral_view_make(size : Int) -> MlclusterspectralView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_spectral_view_len(s : MlclusterspectralView) -> Int { s.size }

pub fn ml_cluster_spectral_view_get(s : MlclusterspectralView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_spectral_view_set(s : MlclusterspectralView, i : Int, v : Double) -> MlclusterspectralView {
  let result = ml_cluster_spectral_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_spectral_view_sum(s : MlclusterspectralView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_cluster_spectral_view_mean(s : MlclusterspectralView) -> Double {
  if s.size == 0 { 0.0 } else { ml_cluster_spectral_view_sum(s) / s.size.to_double() }
}

pub fn ml_cluster_spectral_view_scale(s : MlclusterspectralView, f : Double) -> MlclusterspectralView {
  let result = ml_cluster_spectral_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_cluster_spectral_view_add(a : MlclusterspectralView, b : MlclusterspectralView) -> MlclusterspectralView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_cluster_spectral_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_cluster_spectral_view_copy(s : MlclusterspectralView) -> MlclusterspectralView {
  let result = ml_cluster_spectral_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_cluster_spectral_view_fill(s : MlclusterspectralView, v : Double) -> MlclusterspectralView {
  let result = ml_cluster_spectral_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_spectral_view_min(s : MlclusterspectralView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_spectral_view_max(s : MlclusterspectralView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_spectral_view_to_string(s : MlclusterspectralView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusterspectralRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_spectral_range_make(size : Int) -> MlclusterspectralRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_spectral_range_len(s : MlclusterspectralRange) -> Int { s.size }

pub fn ml_cluster_spectral_range_get(s : MlclusterspectralRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_spectral_range_set(s : MlclusterspectralRange, i : Int, v : Double) -> MlclusterspectralRange {
  let result = ml_cluster_spectral_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_spectral_range_sum(s : MlclusterspectralRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_cluster_spectral_range_mean(s : MlclusterspectralRange) -> Double {
  if s.size == 0 { 0.0 } else { ml_cluster_spectral_range_sum(s) / s.size.to_double() }
}

pub fn ml_cluster_spectral_range_scale(s : MlclusterspectralRange, f : Double) -> MlclusterspectralRange {
  let result = ml_cluster_spectral_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_cluster_spectral_range_add(a : MlclusterspectralRange, b : MlclusterspectralRange) -> MlclusterspectralRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_cluster_spectral_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_cluster_spectral_range_copy(s : MlclusterspectralRange) -> MlclusterspectralRange {
  let result = ml_cluster_spectral_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_cluster_spectral_range_fill(s : MlclusterspectralRange, v : Double) -> MlclusterspectralRange {
  let result = ml_cluster_spectral_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_spectral_range_min(s : MlclusterspectralRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_spectral_range_max(s : MlclusterspectralRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_spectral_range_to_string(s : MlclusterspectralRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusterspectralSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_spectral_slice_make(size : Int) -> MlclusterspectralSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_spectral_slice_len(s : MlclusterspectralSlice) -> Int { s.size }

pub fn ml_cluster_spectral_slice_get(s : MlclusterspectralSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_spectral_slice_set(s : MlclusterspectralSlice, i : Int, v : Double) -> MlclusterspectralSlice {
  let result = ml_cluster_spectral_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_spectral_slice_sum(s : MlclusterspectralSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_cluster_spectral_slice_mean(s : MlclusterspectralSlice) -> Double {
  if s.size == 0 { 0.0 } else { ml_cluster_spectral_slice_sum(s) / s.size.to_double() }
}

pub fn ml_cluster_spectral_slice_scale(s : MlclusterspectralSlice, f : Double) -> MlclusterspectralSlice {
  let result = ml_cluster_spectral_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_cluster_spectral_slice_add(a : MlclusterspectralSlice, b : MlclusterspectralSlice) -> MlclusterspectralSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_cluster_spectral_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_cluster_spectral_slice_copy(s : MlclusterspectralSlice) -> MlclusterspectralSlice {
  let result = ml_cluster_spectral_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_cluster_spectral_slice_fill(s : MlclusterspectralSlice, v : Double) -> MlclusterspectralSlice {
  let result = ml_cluster_spectral_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_spectral_slice_min(s : MlclusterspectralSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_spectral_slice_max(s : MlclusterspectralSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_spectral_slice_to_string(s : MlclusterspectralSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

