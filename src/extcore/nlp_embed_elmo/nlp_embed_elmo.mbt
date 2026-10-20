///===
/// extcore/nlp_embed_elmo

pub(all) struct NlpembedelmoPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn nlp_embed_elmo_make_point(x : Double, y : Double) -> NlpembedelmoPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn nlp_embed_elmo_make_point3(x : Double, y : Double, z : Double) -> NlpembedelmoPoint {
  { x, y, z, label: 0 }
}

pub fn nlp_embed_elmo_point_x(pt : NlpembedelmoPoint) -> Double { pt.x }

pub fn nlp_embed_elmo_point_y(pt : NlpembedelmoPoint) -> Double { pt.y }

pub fn nlp_embed_elmo_point_z(pt : NlpembedelmoPoint) -> Double { pt.z }

pub fn nlp_embed_elmo_point_label(pt : NlpembedelmoPoint) -> Int { pt.label }

pub fn nlp_embed_elmo_point_dist(a : NlpembedelmoPoint, b : NlpembedelmoPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn nlp_embed_elmo_point_add(a : NlpembedelmoPoint, b : NlpembedelmoPoint) -> NlpembedelmoPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn nlp_embed_elmo_point_sub(a : NlpembedelmoPoint, b : NlpembedelmoPoint) -> NlpembedelmoPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn nlp_embed_elmo_point_scale(pt : NlpembedelmoPoint, s : Double) -> NlpembedelmoPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn nlp_embed_elmo_point_dot(a : NlpembedelmoPoint, b : NlpembedelmoPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn nlp_embed_elmo_point_cross(a : NlpembedelmoPoint, b : NlpembedelmoPoint) -> NlpembedelmoPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn nlp_embed_elmo_point_norm(pt : NlpembedelmoPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn nlp_embed_elmo_point_normalize(pt : NlpembedelmoPoint) -> NlpembedelmoPoint {
  let n = nlp_embed_elmo_point_norm(pt)
  if n < 0.0000001 { pt } else { nlp_embed_elmo_point_scale(pt, 1.0 / n) }
}

pub fn nlp_embed_elmo_point_negate(pt : NlpembedelmoPoint) -> NlpembedelmoPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn nlp_embed_elmo_point_mid(a : NlpembedelmoPoint, b : NlpembedelmoPoint) -> NlpembedelmoPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn nlp_embed_elmo_point_lerp(a : NlpembedelmoPoint, b : NlpembedelmoPoint, t : Double) -> NlpembedelmoPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn nlp_embed_elmo_point_to_string(pt : NlpembedelmoPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct NlpembedelmoSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn nlp_embed_elmo_make_series(vals : Array[Double], name : String) -> NlpembedelmoSeries {
  { vals, name, meta: 0 }
}

pub fn nlp_embed_elmo_series_len(s : NlpembedelmoSeries) -> Int { s.vals.length() }

pub fn nlp_embed_elmo_series_sum(s : NlpembedelmoSeries) -> Double { @_common.sum(s.vals) }

pub fn nlp_embed_elmo_series_mean(s : NlpembedelmoSeries) -> Double { @_common.mean(s.vals) }

pub fn nlp_embed_elmo_series_min(s : NlpembedelmoSeries) -> Double { @_common.min(s.vals) }

pub fn nlp_embed_elmo_series_max(s : NlpembedelmoSeries) -> Double { @_common.max(s.vals) }

pub fn nlp_embed_elmo_series_range(s : NlpembedelmoSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn nlp_embed_elmo_series_var(s : NlpembedelmoSeries) -> Double { @_common.variance(s.vals) }

pub fn nlp_embed_elmo_series_std(s : NlpembedelmoSeries) -> Double { @_common.std(s.vals) }

pub fn nlp_embed_elmo_series_median(s : NlpembedelmoSeries) -> Double { @_common.median(s.vals) }

pub fn nlp_embed_elmo_series_scale(s : NlpembedelmoSeries, f : Double) -> NlpembedelmoSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn nlp_embed_elmo_series_add(a : NlpembedelmoSeries, b : NlpembedelmoSeries) -> NlpembedelmoSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn nlp_embed_elmo_series_sub(a : NlpembedelmoSeries, b : NlpembedelmoSeries) -> NlpembedelmoSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn nlp_embed_elmo_series_normalize(s : NlpembedelmoSeries) -> NlpembedelmoSeries {
  let mn = nlp_embed_elmo_series_min(s)
  let mx = nlp_embed_elmo_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn nlp_embed_elmo_series_cumsum(s : NlpembedelmoSeries) -> NlpembedelmoSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn nlp_embed_elmo_series_to_string(s : NlpembedelmoSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NlpembedelmoMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn nlp_embed_elmo_make_matrix(rows : Int, cols : Int, val : Double) -> NlpembedelmoMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn nlp_embed_elmo_matrix_identity(n : Int) -> NlpembedelmoMatrix {
  let m = nlp_embed_elmo_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn nlp_embed_elmo_matrix_get(m : NlpembedelmoMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn nlp_embed_elmo_matrix_transpose(m : NlpembedelmoMatrix) -> NlpembedelmoMatrix {
  let result = nlp_embed_elmo_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn nlp_embed_elmo_matrix_add(a : NlpembedelmoMatrix, b : NlpembedelmoMatrix) -> NlpembedelmoMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = nlp_embed_elmo_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn nlp_embed_elmo_matrix_scale(m : NlpembedelmoMatrix, s : Double) -> NlpembedelmoMatrix {
  let result = nlp_embed_elmo_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn nlp_embed_elmo_matrix_multiply(a : NlpembedelmoMatrix, b : NlpembedelmoMatrix) -> NlpembedelmoMatrix {
  if a.cols != b.rows { return nlp_embed_elmo_make_matrix(a.rows, b.cols, 0.0) }
  let result = nlp_embed_elmo_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn nlp_embed_elmo_matrix_trace(m : NlpembedelmoMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn nlp_embed_elmo_matrix_det(m : NlpembedelmoMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn nlp_embed_elmo_matrix_norm(m : NlpembedelmoMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn nlp_embed_elmo_matrix_to_string(m : NlpembedelmoMatrix) -> String {
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

pub(all) struct NlpembedelmoVector {
  comps : Array[Double]
  dim : Int
}

pub fn nlp_embed_elmo_make_vector(comps : Array[Double]) -> NlpembedelmoVector {
  { comps, dim: comps.length() }
}

pub fn nlp_embed_elmo_vector_zero(dim : Int) -> NlpembedelmoVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn nlp_embed_elmo_vector_add(a : NlpembedelmoVector, b : NlpembedelmoVector) -> NlpembedelmoVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn nlp_embed_elmo_vector_sub(a : NlpembedelmoVector, b : NlpembedelmoVector) -> NlpembedelmoVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn nlp_embed_elmo_vector_scale(v : NlpembedelmoVector, s : Double) -> NlpembedelmoVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn nlp_embed_elmo_vector_dot(a : NlpembedelmoVector, b : NlpembedelmoVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn nlp_embed_elmo_vector_norm(v : NlpembedelmoVector) -> Double { @_common.sqrt(nlp_embed_elmo_vector_dot(v, v)) }

pub fn nlp_embed_elmo_vector_normalize(v : NlpembedelmoVector) -> NlpembedelmoVector {
  let n = nlp_embed_elmo_vector_norm(v)
  if n < 0.0000001 { v } else { nlp_embed_elmo_vector_scale(v, 1.0 / n) }
}

pub fn nlp_embed_elmo_vector_dist(a : NlpembedelmoVector, b : NlpembedelmoVector) -> Double {
  nlp_embed_elmo_vector_norm(nlp_embed_elmo_vector_sub(a, b))
}

pub fn nlp_embed_elmo_vector_to_string(v : NlpembedelmoVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn nlp_embed_elmo_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn nlp_embed_elmo_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn nlp_embed_elmo_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn nlp_embed_elmo_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn nlp_embed_elmo_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn nlp_embed_elmo_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn nlp_embed_elmo_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn nlp_embed_elmo_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn nlp_embed_elmo_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn nlp_embed_elmo_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn nlp_embed_elmo_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn nlp_embed_elmo_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn nlp_embed_elmo_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn nlp_embed_elmo_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn nlp_embed_elmo_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn nlp_embed_elmo_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn nlp_embed_elmo_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn nlp_embed_elmo_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn nlp_embed_elmo_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn nlp_embed_elmo_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn nlp_embed_elmo_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn nlp_embed_elmo_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn nlp_embed_elmo_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn nlp_embed_elmo_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn nlp_embed_elmo_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn nlp_embed_elmo_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn nlp_embed_elmo_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn nlp_embed_elmo_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn nlp_embed_elmo_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct NlpembedelmoFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_elmo_frame_make(size : Int) -> NlpembedelmoFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_elmo_frame_len(s : NlpembedelmoFrame) -> Int { s.size }

pub fn nlp_embed_elmo_frame_get(s : NlpembedelmoFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_elmo_frame_set(s : NlpembedelmoFrame, i : Int, v : Double) -> NlpembedelmoFrame {
  let result = nlp_embed_elmo_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_embed_elmo_frame_sum(s : NlpembedelmoFrame) -> Double { @_common.sum(s.data) }

pub fn nlp_embed_elmo_frame_mean(s : NlpembedelmoFrame) -> Double { @_common.mean(s.data) }

pub fn nlp_embed_elmo_frame_scale(s : NlpembedelmoFrame, f : Double) -> NlpembedelmoFrame {
  let result = nlp_embed_elmo_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_embed_elmo_frame_add(a : NlpembedelmoFrame, b : NlpembedelmoFrame) -> NlpembedelmoFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_embed_elmo_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_embed_elmo_frame_copy(s : NlpembedelmoFrame) -> NlpembedelmoFrame {
  let result = nlp_embed_elmo_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_embed_elmo_frame_fill(s : NlpembedelmoFrame, v : Double) -> NlpembedelmoFrame {
  let result = nlp_embed_elmo_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_embed_elmo_frame_min(s : NlpembedelmoFrame) -> Double { @_common.min(s.data) }

pub fn nlp_embed_elmo_frame_max(s : NlpembedelmoFrame) -> Double { @_common.max(s.data) }

pub fn nlp_embed_elmo_frame_to_string(s : NlpembedelmoFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpembedelmoTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_elmo_table_make(size : Int) -> NlpembedelmoTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_elmo_table_len(s : NlpembedelmoTable) -> Int { s.size }

pub fn nlp_embed_elmo_table_get(s : NlpembedelmoTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_elmo_table_set(s : NlpembedelmoTable, i : Int, v : Double) -> NlpembedelmoTable {
  let result = nlp_embed_elmo_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_embed_elmo_table_sum(s : NlpembedelmoTable) -> Double { @_common.sum(s.data) }

pub fn nlp_embed_elmo_table_mean(s : NlpembedelmoTable) -> Double { @_common.mean(s.data) }

pub fn nlp_embed_elmo_table_scale(s : NlpembedelmoTable, f : Double) -> NlpembedelmoTable {
  let result = nlp_embed_elmo_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_embed_elmo_table_add(a : NlpembedelmoTable, b : NlpembedelmoTable) -> NlpembedelmoTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_embed_elmo_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_embed_elmo_table_copy(s : NlpembedelmoTable) -> NlpembedelmoTable {
  let result = nlp_embed_elmo_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_embed_elmo_table_fill(s : NlpembedelmoTable, v : Double) -> NlpembedelmoTable {
  let result = nlp_embed_elmo_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_embed_elmo_table_min(s : NlpembedelmoTable) -> Double { @_common.min(s.data) }

pub fn nlp_embed_elmo_table_max(s : NlpembedelmoTable) -> Double { @_common.max(s.data) }

pub fn nlp_embed_elmo_table_to_string(s : NlpembedelmoTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpembedelmoGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_elmo_graphn_make(size : Int) -> NlpembedelmoGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_elmo_graphn_len(s : NlpembedelmoGraphN) -> Int { s.size }

pub fn nlp_embed_elmo_graphn_get(s : NlpembedelmoGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_elmo_graphn_set(s : NlpembedelmoGraphN, i : Int, v : Double) -> NlpembedelmoGraphN {
  let result = nlp_embed_elmo_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_embed_elmo_graphn_sum(s : NlpembedelmoGraphN) -> Double { @_common.sum(s.data) }

pub fn nlp_embed_elmo_graphn_mean(s : NlpembedelmoGraphN) -> Double { @_common.mean(s.data) }

pub fn nlp_embed_elmo_graphn_scale(s : NlpembedelmoGraphN, f : Double) -> NlpembedelmoGraphN {
  let result = nlp_embed_elmo_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_embed_elmo_graphn_add(a : NlpembedelmoGraphN, b : NlpembedelmoGraphN) -> NlpembedelmoGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_embed_elmo_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_embed_elmo_graphn_copy(s : NlpembedelmoGraphN) -> NlpembedelmoGraphN {
  let result = nlp_embed_elmo_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_embed_elmo_graphn_fill(s : NlpembedelmoGraphN, v : Double) -> NlpembedelmoGraphN {
  let result = nlp_embed_elmo_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_embed_elmo_graphn_min(s : NlpembedelmoGraphN) -> Double { @_common.min(s.data) }

pub fn nlp_embed_elmo_graphn_max(s : NlpembedelmoGraphN) -> Double { @_common.max(s.data) }

pub fn nlp_embed_elmo_graphn_to_string(s : NlpembedelmoGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpembedelmoNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_elmo_node_make(size : Int) -> NlpembedelmoNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_elmo_node_len(s : NlpembedelmoNode) -> Int { s.size }

pub fn nlp_embed_elmo_node_get(s : NlpembedelmoNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_elmo_node_set(s : NlpembedelmoNode, i : Int, v : Double) -> NlpembedelmoNode {
  let result = nlp_embed_elmo_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_embed_elmo_node_sum(s : NlpembedelmoNode) -> Double { @_common.sum(s.data) }

pub fn nlp_embed_elmo_node_mean(s : NlpembedelmoNode) -> Double { @_common.mean(s.data) }

pub fn nlp_embed_elmo_node_scale(s : NlpembedelmoNode, f : Double) -> NlpembedelmoNode {
  let result = nlp_embed_elmo_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_embed_elmo_node_add(a : NlpembedelmoNode, b : NlpembedelmoNode) -> NlpembedelmoNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_embed_elmo_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_embed_elmo_node_copy(s : NlpembedelmoNode) -> NlpembedelmoNode {
  let result = nlp_embed_elmo_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_embed_elmo_node_fill(s : NlpembedelmoNode, v : Double) -> NlpembedelmoNode {
  let result = nlp_embed_elmo_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_embed_elmo_node_min(s : NlpembedelmoNode) -> Double { @_common.min(s.data) }

pub fn nlp_embed_elmo_node_max(s : NlpembedelmoNode) -> Double { @_common.max(s.data) }

pub fn nlp_embed_elmo_node_to_string(s : NlpembedelmoNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpembedelmoEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_elmo_edge_make(size : Int) -> NlpembedelmoEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_elmo_edge_len(s : NlpembedelmoEdge) -> Int { s.size }

pub fn nlp_embed_elmo_edge_get(s : NlpembedelmoEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_elmo_edge_set(s : NlpembedelmoEdge, i : Int, v : Double) -> NlpembedelmoEdge {
  let result = nlp_embed_elmo_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_embed_elmo_edge_sum(s : NlpembedelmoEdge) -> Double { @_common.sum(s.data) }

pub fn nlp_embed_elmo_edge_mean(s : NlpembedelmoEdge) -> Double { @_common.mean(s.data) }

pub fn nlp_embed_elmo_edge_scale(s : NlpembedelmoEdge, f : Double) -> NlpembedelmoEdge {
  let result = nlp_embed_elmo_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_embed_elmo_edge_add(a : NlpembedelmoEdge, b : NlpembedelmoEdge) -> NlpembedelmoEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_embed_elmo_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_embed_elmo_edge_copy(s : NlpembedelmoEdge) -> NlpembedelmoEdge {
  let result = nlp_embed_elmo_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_embed_elmo_edge_fill(s : NlpembedelmoEdge, v : Double) -> NlpembedelmoEdge {
  let result = nlp_embed_elmo_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_embed_elmo_edge_min(s : NlpembedelmoEdge) -> Double { @_common.min(s.data) }

pub fn nlp_embed_elmo_edge_max(s : NlpembedelmoEdge) -> Double { @_common.max(s.data) }

pub fn nlp_embed_elmo_edge_to_string(s : NlpembedelmoEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpembedelmoPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_elmo_path_make(size : Int) -> NlpembedelmoPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_elmo_path_len(s : NlpembedelmoPath) -> Int { s.size }

pub fn nlp_embed_elmo_path_get(s : NlpembedelmoPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_elmo_path_set(s : NlpembedelmoPath, i : Int, v : Double) -> NlpembedelmoPath {
  let result = nlp_embed_elmo_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_embed_elmo_path_sum(s : NlpembedelmoPath) -> Double { @_common.sum(s.data) }

pub fn nlp_embed_elmo_path_mean(s : NlpembedelmoPath) -> Double { @_common.mean(s.data) }

pub fn nlp_embed_elmo_path_scale(s : NlpembedelmoPath, f : Double) -> NlpembedelmoPath {
  let result = nlp_embed_elmo_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_embed_elmo_path_add(a : NlpembedelmoPath, b : NlpembedelmoPath) -> NlpembedelmoPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_embed_elmo_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_embed_elmo_path_copy(s : NlpembedelmoPath) -> NlpembedelmoPath {
  let result = nlp_embed_elmo_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_embed_elmo_path_fill(s : NlpembedelmoPath, v : Double) -> NlpembedelmoPath {
  let result = nlp_embed_elmo_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_embed_elmo_path_min(s : NlpembedelmoPath) -> Double { @_common.min(s.data) }

pub fn nlp_embed_elmo_path_max(s : NlpembedelmoPath) -> Double { @_common.max(s.data) }

pub fn nlp_embed_elmo_path_to_string(s : NlpembedelmoPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpembedelmoCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_elmo_cluster_make(size : Int) -> NlpembedelmoCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_elmo_cluster_len(s : NlpembedelmoCluster) -> Int { s.size }

pub fn nlp_embed_elmo_cluster_get(s : NlpembedelmoCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_elmo_cluster_set(s : NlpembedelmoCluster, i : Int, v : Double) -> NlpembedelmoCluster {
  let result = nlp_embed_elmo_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_embed_elmo_cluster_sum(s : NlpembedelmoCluster) -> Double { @_common.sum(s.data) }

pub fn nlp_embed_elmo_cluster_mean(s : NlpembedelmoCluster) -> Double { @_common.mean(s.data) }

pub fn nlp_embed_elmo_cluster_scale(s : NlpembedelmoCluster, f : Double) -> NlpembedelmoCluster {
  let result = nlp_embed_elmo_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_embed_elmo_cluster_add(a : NlpembedelmoCluster, b : NlpembedelmoCluster) -> NlpembedelmoCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_embed_elmo_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_embed_elmo_cluster_copy(s : NlpembedelmoCluster) -> NlpembedelmoCluster {
  let result = nlp_embed_elmo_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_embed_elmo_cluster_fill(s : NlpembedelmoCluster, v : Double) -> NlpembedelmoCluster {
  let result = nlp_embed_elmo_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_embed_elmo_cluster_min(s : NlpembedelmoCluster) -> Double { @_common.min(s.data) }

pub fn nlp_embed_elmo_cluster_max(s : NlpembedelmoCluster) -> Double { @_common.max(s.data) }

pub fn nlp_embed_elmo_cluster_to_string(s : NlpembedelmoCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpembedelmoModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_elmo_model_make(size : Int) -> NlpembedelmoModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_elmo_model_len(s : NlpembedelmoModel) -> Int { s.size }

pub fn nlp_embed_elmo_model_get(s : NlpembedelmoModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_elmo_model_set(s : NlpembedelmoModel, i : Int, v : Double) -> NlpembedelmoModel {
  let result = nlp_embed_elmo_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_embed_elmo_model_sum(s : NlpembedelmoModel) -> Double { @_common.sum(s.data) }

pub fn nlp_embed_elmo_model_mean(s : NlpembedelmoModel) -> Double { @_common.mean(s.data) }

pub fn nlp_embed_elmo_model_scale(s : NlpembedelmoModel, f : Double) -> NlpembedelmoModel {
  let result = nlp_embed_elmo_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_embed_elmo_model_add(a : NlpembedelmoModel, b : NlpembedelmoModel) -> NlpembedelmoModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_embed_elmo_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_embed_elmo_model_copy(s : NlpembedelmoModel) -> NlpembedelmoModel {
  let result = nlp_embed_elmo_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_embed_elmo_model_fill(s : NlpembedelmoModel, v : Double) -> NlpembedelmoModel {
  let result = nlp_embed_elmo_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_embed_elmo_model_min(s : NlpembedelmoModel) -> Double { @_common.min(s.data) }

pub fn nlp_embed_elmo_model_max(s : NlpembedelmoModel) -> Double { @_common.max(s.data) }

pub fn nlp_embed_elmo_model_to_string(s : NlpembedelmoModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpembedelmoLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_elmo_layer_make(size : Int) -> NlpembedelmoLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_elmo_layer_len(s : NlpembedelmoLayer) -> Int { s.size }

pub fn nlp_embed_elmo_layer_get(s : NlpembedelmoLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_elmo_layer_set(s : NlpembedelmoLayer, i : Int, v : Double) -> NlpembedelmoLayer {
  let result = nlp_embed_elmo_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_embed_elmo_layer_sum(s : NlpembedelmoLayer) -> Double { @_common.sum(s.data) }

pub fn nlp_embed_elmo_layer_mean(s : NlpembedelmoLayer) -> Double { @_common.mean(s.data) }

pub fn nlp_embed_elmo_layer_scale(s : NlpembedelmoLayer, f : Double) -> NlpembedelmoLayer {
  let result = nlp_embed_elmo_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_embed_elmo_layer_add(a : NlpembedelmoLayer, b : NlpembedelmoLayer) -> NlpembedelmoLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_embed_elmo_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_embed_elmo_layer_copy(s : NlpembedelmoLayer) -> NlpembedelmoLayer {
  let result = nlp_embed_elmo_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_embed_elmo_layer_fill(s : NlpembedelmoLayer, v : Double) -> NlpembedelmoLayer {
  let result = nlp_embed_elmo_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_embed_elmo_layer_min(s : NlpembedelmoLayer) -> Double { @_common.min(s.data) }

pub fn nlp_embed_elmo_layer_max(s : NlpembedelmoLayer) -> Double { @_common.max(s.data) }

pub fn nlp_embed_elmo_layer_to_string(s : NlpembedelmoLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpembedelmoBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_elmo_buffer_make(size : Int) -> NlpembedelmoBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_elmo_buffer_len(s : NlpembedelmoBuffer) -> Int { s.size }

pub fn nlp_embed_elmo_buffer_get(s : NlpembedelmoBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_elmo_buffer_set(s : NlpembedelmoBuffer, i : Int, v : Double) -> NlpembedelmoBuffer {
  let result = nlp_embed_elmo_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_embed_elmo_buffer_sum(s : NlpembedelmoBuffer) -> Double { @_common.sum(s.data) }

pub fn nlp_embed_elmo_buffer_mean(s : NlpembedelmoBuffer) -> Double { @_common.mean(s.data) }

pub fn nlp_embed_elmo_buffer_scale(s : NlpembedelmoBuffer, f : Double) -> NlpembedelmoBuffer {
  let result = nlp_embed_elmo_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_embed_elmo_buffer_add(a : NlpembedelmoBuffer, b : NlpembedelmoBuffer) -> NlpembedelmoBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_embed_elmo_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_embed_elmo_buffer_copy(s : NlpembedelmoBuffer) -> NlpembedelmoBuffer {
  let result = nlp_embed_elmo_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_embed_elmo_buffer_fill(s : NlpembedelmoBuffer, v : Double) -> NlpembedelmoBuffer {
  let result = nlp_embed_elmo_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_embed_elmo_buffer_min(s : NlpembedelmoBuffer) -> Double { @_common.min(s.data) }

pub fn nlp_embed_elmo_buffer_max(s : NlpembedelmoBuffer) -> Double { @_common.max(s.data) }

pub fn nlp_embed_elmo_buffer_to_string(s : NlpembedelmoBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpembedelmoCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_elmo_cursor_make(size : Int) -> NlpembedelmoCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_elmo_cursor_len(s : NlpembedelmoCursor) -> Int { s.size }

pub fn nlp_embed_elmo_cursor_get(s : NlpembedelmoCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_elmo_cursor_set(s : NlpembedelmoCursor, i : Int, v : Double) -> NlpembedelmoCursor {
  let result = nlp_embed_elmo_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_embed_elmo_cursor_sum(s : NlpembedelmoCursor) -> Double { @_common.sum(s.data) }

pub fn nlp_embed_elmo_cursor_mean(s : NlpembedelmoCursor) -> Double { @_common.mean(s.data) }

pub fn nlp_embed_elmo_cursor_scale(s : NlpembedelmoCursor, f : Double) -> NlpembedelmoCursor {
  let result = nlp_embed_elmo_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_embed_elmo_cursor_add(a : NlpembedelmoCursor, b : NlpembedelmoCursor) -> NlpembedelmoCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_embed_elmo_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_embed_elmo_cursor_copy(s : NlpembedelmoCursor) -> NlpembedelmoCursor {
  let result = nlp_embed_elmo_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_embed_elmo_cursor_fill(s : NlpembedelmoCursor, v : Double) -> NlpembedelmoCursor {
  let result = nlp_embed_elmo_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_embed_elmo_cursor_min(s : NlpembedelmoCursor) -> Double { @_common.min(s.data) }

pub fn nlp_embed_elmo_cursor_max(s : NlpembedelmoCursor) -> Double { @_common.max(s.data) }

pub fn nlp_embed_elmo_cursor_to_string(s : NlpembedelmoCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpembedelmoView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_elmo_view_make(size : Int) -> NlpembedelmoView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_elmo_view_len(s : NlpembedelmoView) -> Int { s.size }

pub fn nlp_embed_elmo_view_get(s : NlpembedelmoView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_elmo_view_set(s : NlpembedelmoView, i : Int, v : Double) -> NlpembedelmoView {
  let result = nlp_embed_elmo_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_embed_elmo_view_sum(s : NlpembedelmoView) -> Double { @_common.sum(s.data) }

pub fn nlp_embed_elmo_view_mean(s : NlpembedelmoView) -> Double { @_common.mean(s.data) }

pub fn nlp_embed_elmo_view_scale(s : NlpembedelmoView, f : Double) -> NlpembedelmoView {
  let result = nlp_embed_elmo_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_embed_elmo_view_add(a : NlpembedelmoView, b : NlpembedelmoView) -> NlpembedelmoView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_embed_elmo_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_embed_elmo_view_copy(s : NlpembedelmoView) -> NlpembedelmoView {
  let result = nlp_embed_elmo_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_embed_elmo_view_fill(s : NlpembedelmoView, v : Double) -> NlpembedelmoView {
  let result = nlp_embed_elmo_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_embed_elmo_view_min(s : NlpembedelmoView) -> Double { @_common.min(s.data) }

pub fn nlp_embed_elmo_view_max(s : NlpembedelmoView) -> Double { @_common.max(s.data) }

pub fn nlp_embed_elmo_view_to_string(s : NlpembedelmoView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpembedelmoRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_elmo_range_make(size : Int) -> NlpembedelmoRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_elmo_range_len(s : NlpembedelmoRange) -> Int { s.size }

pub fn nlp_embed_elmo_range_get(s : NlpembedelmoRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_elmo_range_set(s : NlpembedelmoRange, i : Int, v : Double) -> NlpembedelmoRange {
  let result = nlp_embed_elmo_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_embed_elmo_range_sum(s : NlpembedelmoRange) -> Double { @_common.sum(s.data) }

pub fn nlp_embed_elmo_range_mean(s : NlpembedelmoRange) -> Double { @_common.mean(s.data) }

pub fn nlp_embed_elmo_range_scale(s : NlpembedelmoRange, f : Double) -> NlpembedelmoRange {
  let result = nlp_embed_elmo_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_embed_elmo_range_add(a : NlpembedelmoRange, b : NlpembedelmoRange) -> NlpembedelmoRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_embed_elmo_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_embed_elmo_range_copy(s : NlpembedelmoRange) -> NlpembedelmoRange {
  let result = nlp_embed_elmo_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_embed_elmo_range_fill(s : NlpembedelmoRange, v : Double) -> NlpembedelmoRange {
  let result = nlp_embed_elmo_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_embed_elmo_range_min(s : NlpembedelmoRange) -> Double { @_common.min(s.data) }

pub fn nlp_embed_elmo_range_max(s : NlpembedelmoRange) -> Double { @_common.max(s.data) }

pub fn nlp_embed_elmo_range_to_string(s : NlpembedelmoRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpembedelmoSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_elmo_slice_make(size : Int) -> NlpembedelmoSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_elmo_slice_len(s : NlpembedelmoSlice) -> Int { s.size }

pub fn nlp_embed_elmo_slice_get(s : NlpembedelmoSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_elmo_slice_set(s : NlpembedelmoSlice, i : Int, v : Double) -> NlpembedelmoSlice {
  let result = nlp_embed_elmo_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_embed_elmo_slice_sum(s : NlpembedelmoSlice) -> Double { @_common.sum(s.data) }

pub fn nlp_embed_elmo_slice_mean(s : NlpembedelmoSlice) -> Double { @_common.mean(s.data) }

pub fn nlp_embed_elmo_slice_scale(s : NlpembedelmoSlice, f : Double) -> NlpembedelmoSlice {
  let result = nlp_embed_elmo_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_embed_elmo_slice_add(a : NlpembedelmoSlice, b : NlpembedelmoSlice) -> NlpembedelmoSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_embed_elmo_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_embed_elmo_slice_copy(s : NlpembedelmoSlice) -> NlpembedelmoSlice {
  let result = nlp_embed_elmo_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_embed_elmo_slice_fill(s : NlpembedelmoSlice, v : Double) -> NlpembedelmoSlice {
  let result = nlp_embed_elmo_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_embed_elmo_slice_min(s : NlpembedelmoSlice) -> Double { @_common.min(s.data) }

pub fn nlp_embed_elmo_slice_max(s : NlpembedelmoSlice) -> Double { @_common.max(s.data) }

pub fn nlp_embed_elmo_slice_to_string(s : NlpembedelmoSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

