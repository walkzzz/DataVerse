///===
/// extcore/nlp_pos_transformer

pub(all) struct NlppostransformerPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn nlp_pos_transformer_make_point(x : Double, y : Double) -> NlppostransformerPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn nlp_pos_transformer_make_point3(x : Double, y : Double, z : Double) -> NlppostransformerPoint {
  { x, y, z, label: 0 }
}

pub fn nlp_pos_transformer_point_x(pt : NlppostransformerPoint) -> Double { pt.x }

pub fn nlp_pos_transformer_point_y(pt : NlppostransformerPoint) -> Double { pt.y }

pub fn nlp_pos_transformer_point_z(pt : NlppostransformerPoint) -> Double { pt.z }

pub fn nlp_pos_transformer_point_label(pt : NlppostransformerPoint) -> Int { pt.label }

pub fn nlp_pos_transformer_point_dist(a : NlppostransformerPoint, b : NlppostransformerPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn nlp_pos_transformer_point_add(a : NlppostransformerPoint, b : NlppostransformerPoint) -> NlppostransformerPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn nlp_pos_transformer_point_sub(a : NlppostransformerPoint, b : NlppostransformerPoint) -> NlppostransformerPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn nlp_pos_transformer_point_scale(pt : NlppostransformerPoint, s : Double) -> NlppostransformerPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn nlp_pos_transformer_point_dot(a : NlppostransformerPoint, b : NlppostransformerPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn nlp_pos_transformer_point_cross(a : NlppostransformerPoint, b : NlppostransformerPoint) -> NlppostransformerPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn nlp_pos_transformer_point_norm(pt : NlppostransformerPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn nlp_pos_transformer_point_normalize(pt : NlppostransformerPoint) -> NlppostransformerPoint {
  let n = nlp_pos_transformer_point_norm(pt)
  if n < 0.0000001 { pt } else { nlp_pos_transformer_point_scale(pt, 1.0 / n) }
}

pub fn nlp_pos_transformer_point_negate(pt : NlppostransformerPoint) -> NlppostransformerPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn nlp_pos_transformer_point_mid(a : NlppostransformerPoint, b : NlppostransformerPoint) -> NlppostransformerPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn nlp_pos_transformer_point_lerp(a : NlppostransformerPoint, b : NlppostransformerPoint, t : Double) -> NlppostransformerPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn nlp_pos_transformer_point_to_string(pt : NlppostransformerPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct NlppostransformerSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn nlp_pos_transformer_make_series(vals : Array[Double], name : String) -> NlppostransformerSeries {
  { vals, name, meta: 0 }
}

pub fn nlp_pos_transformer_series_len(s : NlppostransformerSeries) -> Int { s.vals.length() }

pub fn nlp_pos_transformer_series_sum(s : NlppostransformerSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn nlp_pos_transformer_series_mean(s : NlppostransformerSeries) -> Double { @_common.mean(s.vals) }

pub fn nlp_pos_transformer_series_min(s : NlppostransformerSeries) -> Double { @_common.min(s.vals) }

pub fn nlp_pos_transformer_series_max(s : NlppostransformerSeries) -> Double { @_common.max(s.vals) }

pub fn nlp_pos_transformer_series_range(s : NlppostransformerSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn nlp_pos_transformer_series_var(s : NlppostransformerSeries) -> Double { @_common.variance(s.vals) }

pub fn nlp_pos_transformer_series_std(s : NlppostransformerSeries) -> Double { @_common.std(s.vals) }

pub fn nlp_pos_transformer_series_median(s : NlppostransformerSeries) -> Double { @_common.median(s.vals) }

pub fn nlp_pos_transformer_series_scale(s : NlppostransformerSeries, f : Double) -> NlppostransformerSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn nlp_pos_transformer_series_add(a : NlppostransformerSeries, b : NlppostransformerSeries) -> NlppostransformerSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn nlp_pos_transformer_series_sub(a : NlppostransformerSeries, b : NlppostransformerSeries) -> NlppostransformerSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn nlp_pos_transformer_series_normalize(s : NlppostransformerSeries) -> NlppostransformerSeries {
  let mn = nlp_pos_transformer_series_min(s)
  let mx = nlp_pos_transformer_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn nlp_pos_transformer_series_cumsum(s : NlppostransformerSeries) -> NlppostransformerSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn nlp_pos_transformer_series_to_string(s : NlppostransformerSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NlppostransformerMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn nlp_pos_transformer_make_matrix(rows : Int, cols : Int, val : Double) -> NlppostransformerMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn nlp_pos_transformer_matrix_identity(n : Int) -> NlppostransformerMatrix {
  let m = nlp_pos_transformer_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn nlp_pos_transformer_matrix_get(m : NlppostransformerMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn nlp_pos_transformer_matrix_transpose(m : NlppostransformerMatrix) -> NlppostransformerMatrix {
  let result = nlp_pos_transformer_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn nlp_pos_transformer_matrix_add(a : NlppostransformerMatrix, b : NlppostransformerMatrix) -> NlppostransformerMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = nlp_pos_transformer_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn nlp_pos_transformer_matrix_scale(m : NlppostransformerMatrix, s : Double) -> NlppostransformerMatrix {
  let result = nlp_pos_transformer_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn nlp_pos_transformer_matrix_multiply(a : NlppostransformerMatrix, b : NlppostransformerMatrix) -> NlppostransformerMatrix {
  if a.cols != b.rows { return nlp_pos_transformer_make_matrix(a.rows, b.cols, 0.0) }
  let result = nlp_pos_transformer_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn nlp_pos_transformer_matrix_trace(m : NlppostransformerMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn nlp_pos_transformer_matrix_det(m : NlppostransformerMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn nlp_pos_transformer_matrix_norm(m : NlppostransformerMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn nlp_pos_transformer_matrix_to_string(m : NlppostransformerMatrix) -> String {
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

pub(all) struct NlppostransformerVector {
  comps : Array[Double]
  dim : Int
}

pub fn nlp_pos_transformer_make_vector(comps : Array[Double]) -> NlppostransformerVector {
  { comps, dim: comps.length() }
}

pub fn nlp_pos_transformer_vector_zero(dim : Int) -> NlppostransformerVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn nlp_pos_transformer_vector_add(a : NlppostransformerVector, b : NlppostransformerVector) -> NlppostransformerVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn nlp_pos_transformer_vector_sub(a : NlppostransformerVector, b : NlppostransformerVector) -> NlppostransformerVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn nlp_pos_transformer_vector_scale(v : NlppostransformerVector, s : Double) -> NlppostransformerVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn nlp_pos_transformer_vector_dot(a : NlppostransformerVector, b : NlppostransformerVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn nlp_pos_transformer_vector_norm(v : NlppostransformerVector) -> Double { @_common.sqrt(nlp_pos_transformer_vector_dot(v, v)) }

pub fn nlp_pos_transformer_vector_normalize(v : NlppostransformerVector) -> NlppostransformerVector {
  let n = nlp_pos_transformer_vector_norm(v)
  if n < 0.0000001 { v } else { nlp_pos_transformer_vector_scale(v, 1.0 / n) }
}

pub fn nlp_pos_transformer_vector_dist(a : NlppostransformerVector, b : NlppostransformerVector) -> Double {
  nlp_pos_transformer_vector_norm(nlp_pos_transformer_vector_sub(a, b))
}

pub fn nlp_pos_transformer_vector_to_string(v : NlppostransformerVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn nlp_pos_transformer_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn nlp_pos_transformer_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn nlp_pos_transformer_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn nlp_pos_transformer_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn nlp_pos_transformer_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn nlp_pos_transformer_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn nlp_pos_transformer_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn nlp_pos_transformer_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn nlp_pos_transformer_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn nlp_pos_transformer_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn nlp_pos_transformer_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn nlp_pos_transformer_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn nlp_pos_transformer_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn nlp_pos_transformer_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn nlp_pos_transformer_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn nlp_pos_transformer_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn nlp_pos_transformer_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn nlp_pos_transformer_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn nlp_pos_transformer_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn nlp_pos_transformer_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn nlp_pos_transformer_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn nlp_pos_transformer_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn nlp_pos_transformer_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn nlp_pos_transformer_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn nlp_pos_transformer_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn nlp_pos_transformer_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn nlp_pos_transformer_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn nlp_pos_transformer_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn nlp_pos_transformer_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct NlppostransformerFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_transformer_frame_make(size : Int) -> NlppostransformerFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_transformer_frame_len(s : NlppostransformerFrame) -> Int { s.size }

pub fn nlp_pos_transformer_frame_get(s : NlppostransformerFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_transformer_frame_set(s : NlppostransformerFrame, i : Int, v : Double) -> NlppostransformerFrame {
  let result = nlp_pos_transformer_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_transformer_frame_sum(s : NlppostransformerFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_pos_transformer_frame_mean(s : NlppostransformerFrame) -> Double {
  if s.size == 0 { 0.0 } else { nlp_pos_transformer_frame_sum(s) / s.size.to_double() }
}

pub fn nlp_pos_transformer_frame_scale(s : NlppostransformerFrame, f : Double) -> NlppostransformerFrame {
  let result = nlp_pos_transformer_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_pos_transformer_frame_add(a : NlppostransformerFrame, b : NlppostransformerFrame) -> NlppostransformerFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_pos_transformer_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_pos_transformer_frame_copy(s : NlppostransformerFrame) -> NlppostransformerFrame {
  let result = nlp_pos_transformer_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_pos_transformer_frame_fill(s : NlppostransformerFrame, v : Double) -> NlppostransformerFrame {
  let result = nlp_pos_transformer_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_transformer_frame_min(s : NlppostransformerFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_transformer_frame_max(s : NlppostransformerFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_transformer_frame_to_string(s : NlppostransformerFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlppostransformerTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_transformer_table_make(size : Int) -> NlppostransformerTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_transformer_table_len(s : NlppostransformerTable) -> Int { s.size }

pub fn nlp_pos_transformer_table_get(s : NlppostransformerTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_transformer_table_set(s : NlppostransformerTable, i : Int, v : Double) -> NlppostransformerTable {
  let result = nlp_pos_transformer_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_transformer_table_sum(s : NlppostransformerTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_pos_transformer_table_mean(s : NlppostransformerTable) -> Double {
  if s.size == 0 { 0.0 } else { nlp_pos_transformer_table_sum(s) / s.size.to_double() }
}

pub fn nlp_pos_transformer_table_scale(s : NlppostransformerTable, f : Double) -> NlppostransformerTable {
  let result = nlp_pos_transformer_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_pos_transformer_table_add(a : NlppostransformerTable, b : NlppostransformerTable) -> NlppostransformerTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_pos_transformer_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_pos_transformer_table_copy(s : NlppostransformerTable) -> NlppostransformerTable {
  let result = nlp_pos_transformer_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_pos_transformer_table_fill(s : NlppostransformerTable, v : Double) -> NlppostransformerTable {
  let result = nlp_pos_transformer_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_transformer_table_min(s : NlppostransformerTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_transformer_table_max(s : NlppostransformerTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_transformer_table_to_string(s : NlppostransformerTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlppostransformerGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_transformer_graphn_make(size : Int) -> NlppostransformerGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_transformer_graphn_len(s : NlppostransformerGraphN) -> Int { s.size }

pub fn nlp_pos_transformer_graphn_get(s : NlppostransformerGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_transformer_graphn_set(s : NlppostransformerGraphN, i : Int, v : Double) -> NlppostransformerGraphN {
  let result = nlp_pos_transformer_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_transformer_graphn_sum(s : NlppostransformerGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_pos_transformer_graphn_mean(s : NlppostransformerGraphN) -> Double {
  if s.size == 0 { 0.0 } else { nlp_pos_transformer_graphn_sum(s) / s.size.to_double() }
}

pub fn nlp_pos_transformer_graphn_scale(s : NlppostransformerGraphN, f : Double) -> NlppostransformerGraphN {
  let result = nlp_pos_transformer_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_pos_transformer_graphn_add(a : NlppostransformerGraphN, b : NlppostransformerGraphN) -> NlppostransformerGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_pos_transformer_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_pos_transformer_graphn_copy(s : NlppostransformerGraphN) -> NlppostransformerGraphN {
  let result = nlp_pos_transformer_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_pos_transformer_graphn_fill(s : NlppostransformerGraphN, v : Double) -> NlppostransformerGraphN {
  let result = nlp_pos_transformer_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_transformer_graphn_min(s : NlppostransformerGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_transformer_graphn_max(s : NlppostransformerGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_transformer_graphn_to_string(s : NlppostransformerGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlppostransformerNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_transformer_node_make(size : Int) -> NlppostransformerNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_transformer_node_len(s : NlppostransformerNode) -> Int { s.size }

pub fn nlp_pos_transformer_node_get(s : NlppostransformerNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_transformer_node_set(s : NlppostransformerNode, i : Int, v : Double) -> NlppostransformerNode {
  let result = nlp_pos_transformer_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_transformer_node_sum(s : NlppostransformerNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_pos_transformer_node_mean(s : NlppostransformerNode) -> Double {
  if s.size == 0 { 0.0 } else { nlp_pos_transformer_node_sum(s) / s.size.to_double() }
}

pub fn nlp_pos_transformer_node_scale(s : NlppostransformerNode, f : Double) -> NlppostransformerNode {
  let result = nlp_pos_transformer_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_pos_transformer_node_add(a : NlppostransformerNode, b : NlppostransformerNode) -> NlppostransformerNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_pos_transformer_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_pos_transformer_node_copy(s : NlppostransformerNode) -> NlppostransformerNode {
  let result = nlp_pos_transformer_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_pos_transformer_node_fill(s : NlppostransformerNode, v : Double) -> NlppostransformerNode {
  let result = nlp_pos_transformer_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_transformer_node_min(s : NlppostransformerNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_transformer_node_max(s : NlppostransformerNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_transformer_node_to_string(s : NlppostransformerNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlppostransformerEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_transformer_edge_make(size : Int) -> NlppostransformerEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_transformer_edge_len(s : NlppostransformerEdge) -> Int { s.size }

pub fn nlp_pos_transformer_edge_get(s : NlppostransformerEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_transformer_edge_set(s : NlppostransformerEdge, i : Int, v : Double) -> NlppostransformerEdge {
  let result = nlp_pos_transformer_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_transformer_edge_sum(s : NlppostransformerEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_pos_transformer_edge_mean(s : NlppostransformerEdge) -> Double {
  if s.size == 0 { 0.0 } else { nlp_pos_transformer_edge_sum(s) / s.size.to_double() }
}

pub fn nlp_pos_transformer_edge_scale(s : NlppostransformerEdge, f : Double) -> NlppostransformerEdge {
  let result = nlp_pos_transformer_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_pos_transformer_edge_add(a : NlppostransformerEdge, b : NlppostransformerEdge) -> NlppostransformerEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_pos_transformer_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_pos_transformer_edge_copy(s : NlppostransformerEdge) -> NlppostransformerEdge {
  let result = nlp_pos_transformer_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_pos_transformer_edge_fill(s : NlppostransformerEdge, v : Double) -> NlppostransformerEdge {
  let result = nlp_pos_transformer_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_transformer_edge_min(s : NlppostransformerEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_transformer_edge_max(s : NlppostransformerEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_transformer_edge_to_string(s : NlppostransformerEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlppostransformerPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_transformer_path_make(size : Int) -> NlppostransformerPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_transformer_path_len(s : NlppostransformerPath) -> Int { s.size }

pub fn nlp_pos_transformer_path_get(s : NlppostransformerPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_transformer_path_set(s : NlppostransformerPath, i : Int, v : Double) -> NlppostransformerPath {
  let result = nlp_pos_transformer_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_transformer_path_sum(s : NlppostransformerPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_pos_transformer_path_mean(s : NlppostransformerPath) -> Double {
  if s.size == 0 { 0.0 } else { nlp_pos_transformer_path_sum(s) / s.size.to_double() }
}

pub fn nlp_pos_transformer_path_scale(s : NlppostransformerPath, f : Double) -> NlppostransformerPath {
  let result = nlp_pos_transformer_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_pos_transformer_path_add(a : NlppostransformerPath, b : NlppostransformerPath) -> NlppostransformerPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_pos_transformer_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_pos_transformer_path_copy(s : NlppostransformerPath) -> NlppostransformerPath {
  let result = nlp_pos_transformer_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_pos_transformer_path_fill(s : NlppostransformerPath, v : Double) -> NlppostransformerPath {
  let result = nlp_pos_transformer_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_transformer_path_min(s : NlppostransformerPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_transformer_path_max(s : NlppostransformerPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_transformer_path_to_string(s : NlppostransformerPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlppostransformerCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_transformer_cluster_make(size : Int) -> NlppostransformerCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_transformer_cluster_len(s : NlppostransformerCluster) -> Int { s.size }

pub fn nlp_pos_transformer_cluster_get(s : NlppostransformerCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_transformer_cluster_set(s : NlppostransformerCluster, i : Int, v : Double) -> NlppostransformerCluster {
  let result = nlp_pos_transformer_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_transformer_cluster_sum(s : NlppostransformerCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_pos_transformer_cluster_mean(s : NlppostransformerCluster) -> Double {
  if s.size == 0 { 0.0 } else { nlp_pos_transformer_cluster_sum(s) / s.size.to_double() }
}

pub fn nlp_pos_transformer_cluster_scale(s : NlppostransformerCluster, f : Double) -> NlppostransformerCluster {
  let result = nlp_pos_transformer_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_pos_transformer_cluster_add(a : NlppostransformerCluster, b : NlppostransformerCluster) -> NlppostransformerCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_pos_transformer_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_pos_transformer_cluster_copy(s : NlppostransformerCluster) -> NlppostransformerCluster {
  let result = nlp_pos_transformer_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_pos_transformer_cluster_fill(s : NlppostransformerCluster, v : Double) -> NlppostransformerCluster {
  let result = nlp_pos_transformer_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_transformer_cluster_min(s : NlppostransformerCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_transformer_cluster_max(s : NlppostransformerCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_transformer_cluster_to_string(s : NlppostransformerCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlppostransformerModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_transformer_model_make(size : Int) -> NlppostransformerModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_transformer_model_len(s : NlppostransformerModel) -> Int { s.size }

pub fn nlp_pos_transformer_model_get(s : NlppostransformerModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_transformer_model_set(s : NlppostransformerModel, i : Int, v : Double) -> NlppostransformerModel {
  let result = nlp_pos_transformer_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_transformer_model_sum(s : NlppostransformerModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_pos_transformer_model_mean(s : NlppostransformerModel) -> Double {
  if s.size == 0 { 0.0 } else { nlp_pos_transformer_model_sum(s) / s.size.to_double() }
}

pub fn nlp_pos_transformer_model_scale(s : NlppostransformerModel, f : Double) -> NlppostransformerModel {
  let result = nlp_pos_transformer_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_pos_transformer_model_add(a : NlppostransformerModel, b : NlppostransformerModel) -> NlppostransformerModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_pos_transformer_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_pos_transformer_model_copy(s : NlppostransformerModel) -> NlppostransformerModel {
  let result = nlp_pos_transformer_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_pos_transformer_model_fill(s : NlppostransformerModel, v : Double) -> NlppostransformerModel {
  let result = nlp_pos_transformer_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_transformer_model_min(s : NlppostransformerModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_transformer_model_max(s : NlppostransformerModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_transformer_model_to_string(s : NlppostransformerModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlppostransformerLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_transformer_layer_make(size : Int) -> NlppostransformerLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_transformer_layer_len(s : NlppostransformerLayer) -> Int { s.size }

pub fn nlp_pos_transformer_layer_get(s : NlppostransformerLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_transformer_layer_set(s : NlppostransformerLayer, i : Int, v : Double) -> NlppostransformerLayer {
  let result = nlp_pos_transformer_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_transformer_layer_sum(s : NlppostransformerLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_pos_transformer_layer_mean(s : NlppostransformerLayer) -> Double {
  if s.size == 0 { 0.0 } else { nlp_pos_transformer_layer_sum(s) / s.size.to_double() }
}

pub fn nlp_pos_transformer_layer_scale(s : NlppostransformerLayer, f : Double) -> NlppostransformerLayer {
  let result = nlp_pos_transformer_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_pos_transformer_layer_add(a : NlppostransformerLayer, b : NlppostransformerLayer) -> NlppostransformerLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_pos_transformer_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_pos_transformer_layer_copy(s : NlppostransformerLayer) -> NlppostransformerLayer {
  let result = nlp_pos_transformer_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_pos_transformer_layer_fill(s : NlppostransformerLayer, v : Double) -> NlppostransformerLayer {
  let result = nlp_pos_transformer_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_transformer_layer_min(s : NlppostransformerLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_transformer_layer_max(s : NlppostransformerLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_transformer_layer_to_string(s : NlppostransformerLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlppostransformerBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_transformer_buffer_make(size : Int) -> NlppostransformerBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_transformer_buffer_len(s : NlppostransformerBuffer) -> Int { s.size }

pub fn nlp_pos_transformer_buffer_get(s : NlppostransformerBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_transformer_buffer_set(s : NlppostransformerBuffer, i : Int, v : Double) -> NlppostransformerBuffer {
  let result = nlp_pos_transformer_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_transformer_buffer_sum(s : NlppostransformerBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_pos_transformer_buffer_mean(s : NlppostransformerBuffer) -> Double {
  if s.size == 0 { 0.0 } else { nlp_pos_transformer_buffer_sum(s) / s.size.to_double() }
}

pub fn nlp_pos_transformer_buffer_scale(s : NlppostransformerBuffer, f : Double) -> NlppostransformerBuffer {
  let result = nlp_pos_transformer_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_pos_transformer_buffer_add(a : NlppostransformerBuffer, b : NlppostransformerBuffer) -> NlppostransformerBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_pos_transformer_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_pos_transformer_buffer_copy(s : NlppostransformerBuffer) -> NlppostransformerBuffer {
  let result = nlp_pos_transformer_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_pos_transformer_buffer_fill(s : NlppostransformerBuffer, v : Double) -> NlppostransformerBuffer {
  let result = nlp_pos_transformer_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_transformer_buffer_min(s : NlppostransformerBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_transformer_buffer_max(s : NlppostransformerBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_transformer_buffer_to_string(s : NlppostransformerBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlppostransformerCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_transformer_cursor_make(size : Int) -> NlppostransformerCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_transformer_cursor_len(s : NlppostransformerCursor) -> Int { s.size }

pub fn nlp_pos_transformer_cursor_get(s : NlppostransformerCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_transformer_cursor_set(s : NlppostransformerCursor, i : Int, v : Double) -> NlppostransformerCursor {
  let result = nlp_pos_transformer_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_transformer_cursor_sum(s : NlppostransformerCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_pos_transformer_cursor_mean(s : NlppostransformerCursor) -> Double {
  if s.size == 0 { 0.0 } else { nlp_pos_transformer_cursor_sum(s) / s.size.to_double() }
}

pub fn nlp_pos_transformer_cursor_scale(s : NlppostransformerCursor, f : Double) -> NlppostransformerCursor {
  let result = nlp_pos_transformer_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_pos_transformer_cursor_add(a : NlppostransformerCursor, b : NlppostransformerCursor) -> NlppostransformerCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_pos_transformer_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_pos_transformer_cursor_copy(s : NlppostransformerCursor) -> NlppostransformerCursor {
  let result = nlp_pos_transformer_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_pos_transformer_cursor_fill(s : NlppostransformerCursor, v : Double) -> NlppostransformerCursor {
  let result = nlp_pos_transformer_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_transformer_cursor_min(s : NlppostransformerCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_transformer_cursor_max(s : NlppostransformerCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_transformer_cursor_to_string(s : NlppostransformerCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlppostransformerView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_transformer_view_make(size : Int) -> NlppostransformerView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_transformer_view_len(s : NlppostransformerView) -> Int { s.size }

pub fn nlp_pos_transformer_view_get(s : NlppostransformerView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_transformer_view_set(s : NlppostransformerView, i : Int, v : Double) -> NlppostransformerView {
  let result = nlp_pos_transformer_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_transformer_view_sum(s : NlppostransformerView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_pos_transformer_view_mean(s : NlppostransformerView) -> Double {
  if s.size == 0 { 0.0 } else { nlp_pos_transformer_view_sum(s) / s.size.to_double() }
}

pub fn nlp_pos_transformer_view_scale(s : NlppostransformerView, f : Double) -> NlppostransformerView {
  let result = nlp_pos_transformer_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_pos_transformer_view_add(a : NlppostransformerView, b : NlppostransformerView) -> NlppostransformerView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_pos_transformer_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_pos_transformer_view_copy(s : NlppostransformerView) -> NlppostransformerView {
  let result = nlp_pos_transformer_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_pos_transformer_view_fill(s : NlppostransformerView, v : Double) -> NlppostransformerView {
  let result = nlp_pos_transformer_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_transformer_view_min(s : NlppostransformerView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_transformer_view_max(s : NlppostransformerView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_transformer_view_to_string(s : NlppostransformerView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlppostransformerRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_transformer_range_make(size : Int) -> NlppostransformerRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_transformer_range_len(s : NlppostransformerRange) -> Int { s.size }

pub fn nlp_pos_transformer_range_get(s : NlppostransformerRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_transformer_range_set(s : NlppostransformerRange, i : Int, v : Double) -> NlppostransformerRange {
  let result = nlp_pos_transformer_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_transformer_range_sum(s : NlppostransformerRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_pos_transformer_range_mean(s : NlppostransformerRange) -> Double {
  if s.size == 0 { 0.0 } else { nlp_pos_transformer_range_sum(s) / s.size.to_double() }
}

pub fn nlp_pos_transformer_range_scale(s : NlppostransformerRange, f : Double) -> NlppostransformerRange {
  let result = nlp_pos_transformer_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_pos_transformer_range_add(a : NlppostransformerRange, b : NlppostransformerRange) -> NlppostransformerRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_pos_transformer_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_pos_transformer_range_copy(s : NlppostransformerRange) -> NlppostransformerRange {
  let result = nlp_pos_transformer_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_pos_transformer_range_fill(s : NlppostransformerRange, v : Double) -> NlppostransformerRange {
  let result = nlp_pos_transformer_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_transformer_range_min(s : NlppostransformerRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_transformer_range_max(s : NlppostransformerRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_transformer_range_to_string(s : NlppostransformerRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlppostransformerSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_transformer_slice_make(size : Int) -> NlppostransformerSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_transformer_slice_len(s : NlppostransformerSlice) -> Int { s.size }

pub fn nlp_pos_transformer_slice_get(s : NlppostransformerSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_transformer_slice_set(s : NlppostransformerSlice, i : Int, v : Double) -> NlppostransformerSlice {
  let result = nlp_pos_transformer_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_transformer_slice_sum(s : NlppostransformerSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_pos_transformer_slice_mean(s : NlppostransformerSlice) -> Double {
  if s.size == 0 { 0.0 } else { nlp_pos_transformer_slice_sum(s) / s.size.to_double() }
}

pub fn nlp_pos_transformer_slice_scale(s : NlppostransformerSlice, f : Double) -> NlppostransformerSlice {
  let result = nlp_pos_transformer_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_pos_transformer_slice_add(a : NlppostransformerSlice, b : NlppostransformerSlice) -> NlppostransformerSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_pos_transformer_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_pos_transformer_slice_copy(s : NlppostransformerSlice) -> NlppostransformerSlice {
  let result = nlp_pos_transformer_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_pos_transformer_slice_fill(s : NlppostransformerSlice, v : Double) -> NlppostransformerSlice {
  let result = nlp_pos_transformer_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_transformer_slice_min(s : NlppostransformerSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_transformer_slice_max(s : NlppostransformerSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_transformer_slice_to_string(s : NlppostransformerSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

