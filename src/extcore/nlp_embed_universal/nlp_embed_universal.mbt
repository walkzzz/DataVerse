///===
/// extcore/nlp_embed_universal

pub(all) struct NlpembeduniversalPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn nlp_embed_universal_make_point(x : Double, y : Double) -> NlpembeduniversalPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn nlp_embed_universal_make_point3(x : Double, y : Double, z : Double) -> NlpembeduniversalPoint {
  { x, y, z, label: 0 }
}

pub fn nlp_embed_universal_point_x(pt : NlpembeduniversalPoint) -> Double { pt.x }

pub fn nlp_embed_universal_point_y(pt : NlpembeduniversalPoint) -> Double { pt.y }

pub fn nlp_embed_universal_point_z(pt : NlpembeduniversalPoint) -> Double { pt.z }

pub fn nlp_embed_universal_point_label(pt : NlpembeduniversalPoint) -> Int { pt.label }

pub fn nlp_embed_universal_point_dist(a : NlpembeduniversalPoint, b : NlpembeduniversalPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn nlp_embed_universal_point_add(a : NlpembeduniversalPoint, b : NlpembeduniversalPoint) -> NlpembeduniversalPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn nlp_embed_universal_point_sub(a : NlpembeduniversalPoint, b : NlpembeduniversalPoint) -> NlpembeduniversalPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn nlp_embed_universal_point_scale(pt : NlpembeduniversalPoint, s : Double) -> NlpembeduniversalPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn nlp_embed_universal_point_dot(a : NlpembeduniversalPoint, b : NlpembeduniversalPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn nlp_embed_universal_point_cross(a : NlpembeduniversalPoint, b : NlpembeduniversalPoint) -> NlpembeduniversalPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn nlp_embed_universal_point_norm(pt : NlpembeduniversalPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn nlp_embed_universal_point_normalize(pt : NlpembeduniversalPoint) -> NlpembeduniversalPoint {
  let n = nlp_embed_universal_point_norm(pt)
  if n < 0.0000001 { pt } else { nlp_embed_universal_point_scale(pt, 1.0 / n) }
}

pub fn nlp_embed_universal_point_negate(pt : NlpembeduniversalPoint) -> NlpembeduniversalPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn nlp_embed_universal_point_mid(a : NlpembeduniversalPoint, b : NlpembeduniversalPoint) -> NlpembeduniversalPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn nlp_embed_universal_point_lerp(a : NlpembeduniversalPoint, b : NlpembeduniversalPoint, t : Double) -> NlpembeduniversalPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn nlp_embed_universal_point_to_string(pt : NlpembeduniversalPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct NlpembeduniversalSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn nlp_embed_universal_make_series(vals : Array[Double], name : String) -> NlpembeduniversalSeries {
  { vals, name, meta: 0 }
}

pub fn nlp_embed_universal_series_len(s : NlpembeduniversalSeries) -> Int { s.vals.length() }

pub fn nlp_embed_universal_series_sum(s : NlpembeduniversalSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn nlp_embed_universal_series_mean(s : NlpembeduniversalSeries) -> Double { @_common.mean(s.vals) }

pub fn nlp_embed_universal_series_min(s : NlpembeduniversalSeries) -> Double { @_common.min(s.vals) }

pub fn nlp_embed_universal_series_max(s : NlpembeduniversalSeries) -> Double { @_common.max(s.vals) }

pub fn nlp_embed_universal_series_range(s : NlpembeduniversalSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn nlp_embed_universal_series_var(s : NlpembeduniversalSeries) -> Double { @_common.variance(s.vals) }

pub fn nlp_embed_universal_series_std(s : NlpembeduniversalSeries) -> Double { @_common.std(s.vals) }

pub fn nlp_embed_universal_series_median(s : NlpembeduniversalSeries) -> Double { @_common.median(s.vals) }

pub fn nlp_embed_universal_series_scale(s : NlpembeduniversalSeries, f : Double) -> NlpembeduniversalSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn nlp_embed_universal_series_add(a : NlpembeduniversalSeries, b : NlpembeduniversalSeries) -> NlpembeduniversalSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn nlp_embed_universal_series_sub(a : NlpembeduniversalSeries, b : NlpembeduniversalSeries) -> NlpembeduniversalSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn nlp_embed_universal_series_normalize(s : NlpembeduniversalSeries) -> NlpembeduniversalSeries {
  let mn = nlp_embed_universal_series_min(s)
  let mx = nlp_embed_universal_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn nlp_embed_universal_series_cumsum(s : NlpembeduniversalSeries) -> NlpembeduniversalSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn nlp_embed_universal_series_to_string(s : NlpembeduniversalSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NlpembeduniversalMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn nlp_embed_universal_make_matrix(rows : Int, cols : Int, val : Double) -> NlpembeduniversalMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn nlp_embed_universal_matrix_identity(n : Int) -> NlpembeduniversalMatrix {
  let m = nlp_embed_universal_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn nlp_embed_universal_matrix_get(m : NlpembeduniversalMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn nlp_embed_universal_matrix_transpose(m : NlpembeduniversalMatrix) -> NlpembeduniversalMatrix {
  let result = nlp_embed_universal_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn nlp_embed_universal_matrix_add(a : NlpembeduniversalMatrix, b : NlpembeduniversalMatrix) -> NlpembeduniversalMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = nlp_embed_universal_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn nlp_embed_universal_matrix_scale(m : NlpembeduniversalMatrix, s : Double) -> NlpembeduniversalMatrix {
  let result = nlp_embed_universal_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn nlp_embed_universal_matrix_multiply(a : NlpembeduniversalMatrix, b : NlpembeduniversalMatrix) -> NlpembeduniversalMatrix {
  if a.cols != b.rows { return nlp_embed_universal_make_matrix(a.rows, b.cols, 0.0) }
  let result = nlp_embed_universal_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn nlp_embed_universal_matrix_trace(m : NlpembeduniversalMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn nlp_embed_universal_matrix_det(m : NlpembeduniversalMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn nlp_embed_universal_matrix_norm(m : NlpembeduniversalMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn nlp_embed_universal_matrix_to_string(m : NlpembeduniversalMatrix) -> String {
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

pub(all) struct NlpembeduniversalVector {
  comps : Array[Double]
  dim : Int
}

pub fn nlp_embed_universal_make_vector(comps : Array[Double]) -> NlpembeduniversalVector {
  { comps, dim: comps.length() }
}

pub fn nlp_embed_universal_vector_zero(dim : Int) -> NlpembeduniversalVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn nlp_embed_universal_vector_add(a : NlpembeduniversalVector, b : NlpembeduniversalVector) -> NlpembeduniversalVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn nlp_embed_universal_vector_sub(a : NlpembeduniversalVector, b : NlpembeduniversalVector) -> NlpembeduniversalVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn nlp_embed_universal_vector_scale(v : NlpembeduniversalVector, s : Double) -> NlpembeduniversalVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn nlp_embed_universal_vector_dot(a : NlpembeduniversalVector, b : NlpembeduniversalVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn nlp_embed_universal_vector_norm(v : NlpembeduniversalVector) -> Double { @_common.sqrt(nlp_embed_universal_vector_dot(v, v)) }

pub fn nlp_embed_universal_vector_normalize(v : NlpembeduniversalVector) -> NlpembeduniversalVector {
  let n = nlp_embed_universal_vector_norm(v)
  if n < 0.0000001 { v } else { nlp_embed_universal_vector_scale(v, 1.0 / n) }
}

pub fn nlp_embed_universal_vector_dist(a : NlpembeduniversalVector, b : NlpembeduniversalVector) -> Double {
  nlp_embed_universal_vector_norm(nlp_embed_universal_vector_sub(a, b))
}

pub fn nlp_embed_universal_vector_to_string(v : NlpembeduniversalVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn nlp_embed_universal_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn nlp_embed_universal_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn nlp_embed_universal_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn nlp_embed_universal_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn nlp_embed_universal_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn nlp_embed_universal_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn nlp_embed_universal_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn nlp_embed_universal_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn nlp_embed_universal_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn nlp_embed_universal_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn nlp_embed_universal_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn nlp_embed_universal_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn nlp_embed_universal_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn nlp_embed_universal_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn nlp_embed_universal_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn nlp_embed_universal_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn nlp_embed_universal_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn nlp_embed_universal_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn nlp_embed_universal_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn nlp_embed_universal_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn nlp_embed_universal_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn nlp_embed_universal_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn nlp_embed_universal_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn nlp_embed_universal_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn nlp_embed_universal_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn nlp_embed_universal_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn nlp_embed_universal_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn nlp_embed_universal_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn nlp_embed_universal_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct NlpembeduniversalFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_universal_frame_make(size : Int) -> NlpembeduniversalFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_universal_frame_len(s : NlpembeduniversalFrame) -> Int { s.size }

pub fn nlp_embed_universal_frame_get(s : NlpembeduniversalFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_universal_frame_set(s : NlpembeduniversalFrame, i : Int, v : Double) -> NlpembeduniversalFrame {
  let result = nlp_embed_universal_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_embed_universal_frame_sum(s : NlpembeduniversalFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_embed_universal_frame_mean(s : NlpembeduniversalFrame) -> Double {
  if s.size == 0 { 0.0 } else { nlp_embed_universal_frame_sum(s) / s.size.to_double() }
}

pub fn nlp_embed_universal_frame_scale(s : NlpembeduniversalFrame, f : Double) -> NlpembeduniversalFrame {
  let result = nlp_embed_universal_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_embed_universal_frame_add(a : NlpembeduniversalFrame, b : NlpembeduniversalFrame) -> NlpembeduniversalFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_embed_universal_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_embed_universal_frame_copy(s : NlpembeduniversalFrame) -> NlpembeduniversalFrame {
  let result = nlp_embed_universal_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_embed_universal_frame_fill(s : NlpembeduniversalFrame, v : Double) -> NlpembeduniversalFrame {
  let result = nlp_embed_universal_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_embed_universal_frame_min(s : NlpembeduniversalFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_embed_universal_frame_max(s : NlpembeduniversalFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_embed_universal_frame_to_string(s : NlpembeduniversalFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpembeduniversalTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_universal_table_make(size : Int) -> NlpembeduniversalTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_universal_table_len(s : NlpembeduniversalTable) -> Int { s.size }

pub fn nlp_embed_universal_table_get(s : NlpembeduniversalTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_universal_table_set(s : NlpembeduniversalTable, i : Int, v : Double) -> NlpembeduniversalTable {
  let result = nlp_embed_universal_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_embed_universal_table_sum(s : NlpembeduniversalTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_embed_universal_table_mean(s : NlpembeduniversalTable) -> Double {
  if s.size == 0 { 0.0 } else { nlp_embed_universal_table_sum(s) / s.size.to_double() }
}

pub fn nlp_embed_universal_table_scale(s : NlpembeduniversalTable, f : Double) -> NlpembeduniversalTable {
  let result = nlp_embed_universal_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_embed_universal_table_add(a : NlpembeduniversalTable, b : NlpembeduniversalTable) -> NlpembeduniversalTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_embed_universal_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_embed_universal_table_copy(s : NlpembeduniversalTable) -> NlpembeduniversalTable {
  let result = nlp_embed_universal_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_embed_universal_table_fill(s : NlpembeduniversalTable, v : Double) -> NlpembeduniversalTable {
  let result = nlp_embed_universal_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_embed_universal_table_min(s : NlpembeduniversalTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_embed_universal_table_max(s : NlpembeduniversalTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_embed_universal_table_to_string(s : NlpembeduniversalTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpembeduniversalGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_universal_graphn_make(size : Int) -> NlpembeduniversalGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_universal_graphn_len(s : NlpembeduniversalGraphN) -> Int { s.size }

pub fn nlp_embed_universal_graphn_get(s : NlpembeduniversalGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_universal_graphn_set(s : NlpembeduniversalGraphN, i : Int, v : Double) -> NlpembeduniversalGraphN {
  let result = nlp_embed_universal_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_embed_universal_graphn_sum(s : NlpembeduniversalGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_embed_universal_graphn_mean(s : NlpembeduniversalGraphN) -> Double {
  if s.size == 0 { 0.0 } else { nlp_embed_universal_graphn_sum(s) / s.size.to_double() }
}

pub fn nlp_embed_universal_graphn_scale(s : NlpembeduniversalGraphN, f : Double) -> NlpembeduniversalGraphN {
  let result = nlp_embed_universal_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_embed_universal_graphn_add(a : NlpembeduniversalGraphN, b : NlpembeduniversalGraphN) -> NlpembeduniversalGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_embed_universal_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_embed_universal_graphn_copy(s : NlpembeduniversalGraphN) -> NlpembeduniversalGraphN {
  let result = nlp_embed_universal_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_embed_universal_graphn_fill(s : NlpembeduniversalGraphN, v : Double) -> NlpembeduniversalGraphN {
  let result = nlp_embed_universal_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_embed_universal_graphn_min(s : NlpembeduniversalGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_embed_universal_graphn_max(s : NlpembeduniversalGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_embed_universal_graphn_to_string(s : NlpembeduniversalGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpembeduniversalNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_universal_node_make(size : Int) -> NlpembeduniversalNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_universal_node_len(s : NlpembeduniversalNode) -> Int { s.size }

pub fn nlp_embed_universal_node_get(s : NlpembeduniversalNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_universal_node_set(s : NlpembeduniversalNode, i : Int, v : Double) -> NlpembeduniversalNode {
  let result = nlp_embed_universal_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_embed_universal_node_sum(s : NlpembeduniversalNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_embed_universal_node_mean(s : NlpembeduniversalNode) -> Double {
  if s.size == 0 { 0.0 } else { nlp_embed_universal_node_sum(s) / s.size.to_double() }
}

pub fn nlp_embed_universal_node_scale(s : NlpembeduniversalNode, f : Double) -> NlpembeduniversalNode {
  let result = nlp_embed_universal_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_embed_universal_node_add(a : NlpembeduniversalNode, b : NlpembeduniversalNode) -> NlpembeduniversalNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_embed_universal_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_embed_universal_node_copy(s : NlpembeduniversalNode) -> NlpembeduniversalNode {
  let result = nlp_embed_universal_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_embed_universal_node_fill(s : NlpembeduniversalNode, v : Double) -> NlpembeduniversalNode {
  let result = nlp_embed_universal_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_embed_universal_node_min(s : NlpembeduniversalNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_embed_universal_node_max(s : NlpembeduniversalNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_embed_universal_node_to_string(s : NlpembeduniversalNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpembeduniversalEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_universal_edge_make(size : Int) -> NlpembeduniversalEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_universal_edge_len(s : NlpembeduniversalEdge) -> Int { s.size }

pub fn nlp_embed_universal_edge_get(s : NlpembeduniversalEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_universal_edge_set(s : NlpembeduniversalEdge, i : Int, v : Double) -> NlpembeduniversalEdge {
  let result = nlp_embed_universal_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_embed_universal_edge_sum(s : NlpembeduniversalEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_embed_universal_edge_mean(s : NlpembeduniversalEdge) -> Double {
  if s.size == 0 { 0.0 } else { nlp_embed_universal_edge_sum(s) / s.size.to_double() }
}

pub fn nlp_embed_universal_edge_scale(s : NlpembeduniversalEdge, f : Double) -> NlpembeduniversalEdge {
  let result = nlp_embed_universal_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_embed_universal_edge_add(a : NlpembeduniversalEdge, b : NlpembeduniversalEdge) -> NlpembeduniversalEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_embed_universal_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_embed_universal_edge_copy(s : NlpembeduniversalEdge) -> NlpembeduniversalEdge {
  let result = nlp_embed_universal_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_embed_universal_edge_fill(s : NlpembeduniversalEdge, v : Double) -> NlpembeduniversalEdge {
  let result = nlp_embed_universal_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_embed_universal_edge_min(s : NlpembeduniversalEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_embed_universal_edge_max(s : NlpembeduniversalEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_embed_universal_edge_to_string(s : NlpembeduniversalEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpembeduniversalPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_universal_path_make(size : Int) -> NlpembeduniversalPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_universal_path_len(s : NlpembeduniversalPath) -> Int { s.size }

pub fn nlp_embed_universal_path_get(s : NlpembeduniversalPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_universal_path_set(s : NlpembeduniversalPath, i : Int, v : Double) -> NlpembeduniversalPath {
  let result = nlp_embed_universal_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_embed_universal_path_sum(s : NlpembeduniversalPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_embed_universal_path_mean(s : NlpembeduniversalPath) -> Double {
  if s.size == 0 { 0.0 } else { nlp_embed_universal_path_sum(s) / s.size.to_double() }
}

pub fn nlp_embed_universal_path_scale(s : NlpembeduniversalPath, f : Double) -> NlpembeduniversalPath {
  let result = nlp_embed_universal_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_embed_universal_path_add(a : NlpembeduniversalPath, b : NlpembeduniversalPath) -> NlpembeduniversalPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_embed_universal_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_embed_universal_path_copy(s : NlpembeduniversalPath) -> NlpembeduniversalPath {
  let result = nlp_embed_universal_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_embed_universal_path_fill(s : NlpembeduniversalPath, v : Double) -> NlpembeduniversalPath {
  let result = nlp_embed_universal_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_embed_universal_path_min(s : NlpembeduniversalPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_embed_universal_path_max(s : NlpembeduniversalPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_embed_universal_path_to_string(s : NlpembeduniversalPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpembeduniversalCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_universal_cluster_make(size : Int) -> NlpembeduniversalCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_universal_cluster_len(s : NlpembeduniversalCluster) -> Int { s.size }

pub fn nlp_embed_universal_cluster_get(s : NlpembeduniversalCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_universal_cluster_set(s : NlpembeduniversalCluster, i : Int, v : Double) -> NlpembeduniversalCluster {
  let result = nlp_embed_universal_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_embed_universal_cluster_sum(s : NlpembeduniversalCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_embed_universal_cluster_mean(s : NlpembeduniversalCluster) -> Double {
  if s.size == 0 { 0.0 } else { nlp_embed_universal_cluster_sum(s) / s.size.to_double() }
}

pub fn nlp_embed_universal_cluster_scale(s : NlpembeduniversalCluster, f : Double) -> NlpembeduniversalCluster {
  let result = nlp_embed_universal_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_embed_universal_cluster_add(a : NlpembeduniversalCluster, b : NlpembeduniversalCluster) -> NlpembeduniversalCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_embed_universal_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_embed_universal_cluster_copy(s : NlpembeduniversalCluster) -> NlpembeduniversalCluster {
  let result = nlp_embed_universal_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_embed_universal_cluster_fill(s : NlpembeduniversalCluster, v : Double) -> NlpembeduniversalCluster {
  let result = nlp_embed_universal_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_embed_universal_cluster_min(s : NlpembeduniversalCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_embed_universal_cluster_max(s : NlpembeduniversalCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_embed_universal_cluster_to_string(s : NlpembeduniversalCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpembeduniversalModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_universal_model_make(size : Int) -> NlpembeduniversalModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_universal_model_len(s : NlpembeduniversalModel) -> Int { s.size }

pub fn nlp_embed_universal_model_get(s : NlpembeduniversalModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_universal_model_set(s : NlpembeduniversalModel, i : Int, v : Double) -> NlpembeduniversalModel {
  let result = nlp_embed_universal_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_embed_universal_model_sum(s : NlpembeduniversalModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_embed_universal_model_mean(s : NlpembeduniversalModel) -> Double {
  if s.size == 0 { 0.0 } else { nlp_embed_universal_model_sum(s) / s.size.to_double() }
}

pub fn nlp_embed_universal_model_scale(s : NlpembeduniversalModel, f : Double) -> NlpembeduniversalModel {
  let result = nlp_embed_universal_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_embed_universal_model_add(a : NlpembeduniversalModel, b : NlpembeduniversalModel) -> NlpembeduniversalModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_embed_universal_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_embed_universal_model_copy(s : NlpembeduniversalModel) -> NlpembeduniversalModel {
  let result = nlp_embed_universal_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_embed_universal_model_fill(s : NlpembeduniversalModel, v : Double) -> NlpembeduniversalModel {
  let result = nlp_embed_universal_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_embed_universal_model_min(s : NlpembeduniversalModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_embed_universal_model_max(s : NlpembeduniversalModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_embed_universal_model_to_string(s : NlpembeduniversalModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpembeduniversalLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_universal_layer_make(size : Int) -> NlpembeduniversalLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_universal_layer_len(s : NlpembeduniversalLayer) -> Int { s.size }

pub fn nlp_embed_universal_layer_get(s : NlpembeduniversalLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_universal_layer_set(s : NlpembeduniversalLayer, i : Int, v : Double) -> NlpembeduniversalLayer {
  let result = nlp_embed_universal_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_embed_universal_layer_sum(s : NlpembeduniversalLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_embed_universal_layer_mean(s : NlpembeduniversalLayer) -> Double {
  if s.size == 0 { 0.0 } else { nlp_embed_universal_layer_sum(s) / s.size.to_double() }
}

pub fn nlp_embed_universal_layer_scale(s : NlpembeduniversalLayer, f : Double) -> NlpembeduniversalLayer {
  let result = nlp_embed_universal_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_embed_universal_layer_add(a : NlpembeduniversalLayer, b : NlpembeduniversalLayer) -> NlpembeduniversalLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_embed_universal_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_embed_universal_layer_copy(s : NlpembeduniversalLayer) -> NlpembeduniversalLayer {
  let result = nlp_embed_universal_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_embed_universal_layer_fill(s : NlpembeduniversalLayer, v : Double) -> NlpembeduniversalLayer {
  let result = nlp_embed_universal_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_embed_universal_layer_min(s : NlpembeduniversalLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_embed_universal_layer_max(s : NlpembeduniversalLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_embed_universal_layer_to_string(s : NlpembeduniversalLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpembeduniversalBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_universal_buffer_make(size : Int) -> NlpembeduniversalBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_universal_buffer_len(s : NlpembeduniversalBuffer) -> Int { s.size }

pub fn nlp_embed_universal_buffer_get(s : NlpembeduniversalBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_universal_buffer_set(s : NlpembeduniversalBuffer, i : Int, v : Double) -> NlpembeduniversalBuffer {
  let result = nlp_embed_universal_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_embed_universal_buffer_sum(s : NlpembeduniversalBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_embed_universal_buffer_mean(s : NlpembeduniversalBuffer) -> Double {
  if s.size == 0 { 0.0 } else { nlp_embed_universal_buffer_sum(s) / s.size.to_double() }
}

pub fn nlp_embed_universal_buffer_scale(s : NlpembeduniversalBuffer, f : Double) -> NlpembeduniversalBuffer {
  let result = nlp_embed_universal_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_embed_universal_buffer_add(a : NlpembeduniversalBuffer, b : NlpembeduniversalBuffer) -> NlpembeduniversalBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_embed_universal_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_embed_universal_buffer_copy(s : NlpembeduniversalBuffer) -> NlpembeduniversalBuffer {
  let result = nlp_embed_universal_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_embed_universal_buffer_fill(s : NlpembeduniversalBuffer, v : Double) -> NlpembeduniversalBuffer {
  let result = nlp_embed_universal_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_embed_universal_buffer_min(s : NlpembeduniversalBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_embed_universal_buffer_max(s : NlpembeduniversalBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_embed_universal_buffer_to_string(s : NlpembeduniversalBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpembeduniversalCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_universal_cursor_make(size : Int) -> NlpembeduniversalCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_universal_cursor_len(s : NlpembeduniversalCursor) -> Int { s.size }

pub fn nlp_embed_universal_cursor_get(s : NlpembeduniversalCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_universal_cursor_set(s : NlpembeduniversalCursor, i : Int, v : Double) -> NlpembeduniversalCursor {
  let result = nlp_embed_universal_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_embed_universal_cursor_sum(s : NlpembeduniversalCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_embed_universal_cursor_mean(s : NlpembeduniversalCursor) -> Double {
  if s.size == 0 { 0.0 } else { nlp_embed_universal_cursor_sum(s) / s.size.to_double() }
}

pub fn nlp_embed_universal_cursor_scale(s : NlpembeduniversalCursor, f : Double) -> NlpembeduniversalCursor {
  let result = nlp_embed_universal_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_embed_universal_cursor_add(a : NlpembeduniversalCursor, b : NlpembeduniversalCursor) -> NlpembeduniversalCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_embed_universal_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_embed_universal_cursor_copy(s : NlpembeduniversalCursor) -> NlpembeduniversalCursor {
  let result = nlp_embed_universal_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_embed_universal_cursor_fill(s : NlpembeduniversalCursor, v : Double) -> NlpembeduniversalCursor {
  let result = nlp_embed_universal_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_embed_universal_cursor_min(s : NlpembeduniversalCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_embed_universal_cursor_max(s : NlpembeduniversalCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_embed_universal_cursor_to_string(s : NlpembeduniversalCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpembeduniversalView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_universal_view_make(size : Int) -> NlpembeduniversalView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_universal_view_len(s : NlpembeduniversalView) -> Int { s.size }

pub fn nlp_embed_universal_view_get(s : NlpembeduniversalView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_universal_view_set(s : NlpembeduniversalView, i : Int, v : Double) -> NlpembeduniversalView {
  let result = nlp_embed_universal_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_embed_universal_view_sum(s : NlpembeduniversalView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_embed_universal_view_mean(s : NlpembeduniversalView) -> Double {
  if s.size == 0 { 0.0 } else { nlp_embed_universal_view_sum(s) / s.size.to_double() }
}

pub fn nlp_embed_universal_view_scale(s : NlpembeduniversalView, f : Double) -> NlpembeduniversalView {
  let result = nlp_embed_universal_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_embed_universal_view_add(a : NlpembeduniversalView, b : NlpembeduniversalView) -> NlpembeduniversalView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_embed_universal_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_embed_universal_view_copy(s : NlpembeduniversalView) -> NlpembeduniversalView {
  let result = nlp_embed_universal_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_embed_universal_view_fill(s : NlpembeduniversalView, v : Double) -> NlpembeduniversalView {
  let result = nlp_embed_universal_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_embed_universal_view_min(s : NlpembeduniversalView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_embed_universal_view_max(s : NlpembeduniversalView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_embed_universal_view_to_string(s : NlpembeduniversalView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpembeduniversalRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_universal_range_make(size : Int) -> NlpembeduniversalRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_universal_range_len(s : NlpembeduniversalRange) -> Int { s.size }

pub fn nlp_embed_universal_range_get(s : NlpembeduniversalRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_universal_range_set(s : NlpembeduniversalRange, i : Int, v : Double) -> NlpembeduniversalRange {
  let result = nlp_embed_universal_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_embed_universal_range_sum(s : NlpembeduniversalRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_embed_universal_range_mean(s : NlpembeduniversalRange) -> Double {
  if s.size == 0 { 0.0 } else { nlp_embed_universal_range_sum(s) / s.size.to_double() }
}

pub fn nlp_embed_universal_range_scale(s : NlpembeduniversalRange, f : Double) -> NlpembeduniversalRange {
  let result = nlp_embed_universal_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_embed_universal_range_add(a : NlpembeduniversalRange, b : NlpembeduniversalRange) -> NlpembeduniversalRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_embed_universal_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_embed_universal_range_copy(s : NlpembeduniversalRange) -> NlpembeduniversalRange {
  let result = nlp_embed_universal_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_embed_universal_range_fill(s : NlpembeduniversalRange, v : Double) -> NlpembeduniversalRange {
  let result = nlp_embed_universal_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_embed_universal_range_min(s : NlpembeduniversalRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_embed_universal_range_max(s : NlpembeduniversalRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_embed_universal_range_to_string(s : NlpembeduniversalRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpembeduniversalSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_universal_slice_make(size : Int) -> NlpembeduniversalSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_universal_slice_len(s : NlpembeduniversalSlice) -> Int { s.size }

pub fn nlp_embed_universal_slice_get(s : NlpembeduniversalSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_universal_slice_set(s : NlpembeduniversalSlice, i : Int, v : Double) -> NlpembeduniversalSlice {
  let result = nlp_embed_universal_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_embed_universal_slice_sum(s : NlpembeduniversalSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_embed_universal_slice_mean(s : NlpembeduniversalSlice) -> Double {
  if s.size == 0 { 0.0 } else { nlp_embed_universal_slice_sum(s) / s.size.to_double() }
}

pub fn nlp_embed_universal_slice_scale(s : NlpembeduniversalSlice, f : Double) -> NlpembeduniversalSlice {
  let result = nlp_embed_universal_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_embed_universal_slice_add(a : NlpembeduniversalSlice, b : NlpembeduniversalSlice) -> NlpembeduniversalSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_embed_universal_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_embed_universal_slice_copy(s : NlpembeduniversalSlice) -> NlpembeduniversalSlice {
  let result = nlp_embed_universal_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_embed_universal_slice_fill(s : NlpembeduniversalSlice, v : Double) -> NlpembeduniversalSlice {
  let result = nlp_embed_universal_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_embed_universal_slice_min(s : NlpembeduniversalSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_embed_universal_slice_max(s : NlpembeduniversalSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_embed_universal_slice_to_string(s : NlpembeduniversalSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

