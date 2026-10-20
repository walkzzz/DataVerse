///===
/// extcore/nlp_embed_bert

pub(all) struct NlpembedbertPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn nlp_embed_bert_make_point(x : Double, y : Double) -> NlpembedbertPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn nlp_embed_bert_make_point3(x : Double, y : Double, z : Double) -> NlpembedbertPoint {
  { x, y, z, label: 0 }
}

pub fn nlp_embed_bert_point_x(pt : NlpembedbertPoint) -> Double { pt.x }

pub fn nlp_embed_bert_point_y(pt : NlpembedbertPoint) -> Double { pt.y }

pub fn nlp_embed_bert_point_z(pt : NlpembedbertPoint) -> Double { pt.z }

pub fn nlp_embed_bert_point_label(pt : NlpembedbertPoint) -> Int { pt.label }

pub fn nlp_embed_bert_point_dist(a : NlpembedbertPoint, b : NlpembedbertPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn nlp_embed_bert_point_add(a : NlpembedbertPoint, b : NlpembedbertPoint) -> NlpembedbertPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn nlp_embed_bert_point_sub(a : NlpembedbertPoint, b : NlpembedbertPoint) -> NlpembedbertPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn nlp_embed_bert_point_scale(pt : NlpembedbertPoint, s : Double) -> NlpembedbertPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn nlp_embed_bert_point_dot(a : NlpembedbertPoint, b : NlpembedbertPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn nlp_embed_bert_point_cross(a : NlpembedbertPoint, b : NlpembedbertPoint) -> NlpembedbertPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn nlp_embed_bert_point_norm(pt : NlpembedbertPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn nlp_embed_bert_point_normalize(pt : NlpembedbertPoint) -> NlpembedbertPoint {
  let n = nlp_embed_bert_point_norm(pt)
  if n < 0.0000001 { pt } else { nlp_embed_bert_point_scale(pt, 1.0 / n) }
}

pub fn nlp_embed_bert_point_negate(pt : NlpembedbertPoint) -> NlpembedbertPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn nlp_embed_bert_point_mid(a : NlpembedbertPoint, b : NlpembedbertPoint) -> NlpembedbertPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn nlp_embed_bert_point_lerp(a : NlpembedbertPoint, b : NlpembedbertPoint, t : Double) -> NlpembedbertPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn nlp_embed_bert_point_to_string(pt : NlpembedbertPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct NlpembedbertSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn nlp_embed_bert_make_series(vals : Array[Double], name : String) -> NlpembedbertSeries {
  { vals, name, meta: 0 }
}

pub fn nlp_embed_bert_series_len(s : NlpembedbertSeries) -> Int { s.vals.length() }

pub fn nlp_embed_bert_series_sum(s : NlpembedbertSeries) -> Double { @_common.sum(s.vals) }

pub fn nlp_embed_bert_series_mean(s : NlpembedbertSeries) -> Double { @_common.mean(s.vals) }

pub fn nlp_embed_bert_series_min(s : NlpembedbertSeries) -> Double { @_common.min(s.vals) }

pub fn nlp_embed_bert_series_max(s : NlpembedbertSeries) -> Double { @_common.max(s.vals) }

pub fn nlp_embed_bert_series_range(s : NlpembedbertSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn nlp_embed_bert_series_var(s : NlpembedbertSeries) -> Double { @_common.variance(s.vals) }

pub fn nlp_embed_bert_series_std(s : NlpembedbertSeries) -> Double { @_common.std(s.vals) }

pub fn nlp_embed_bert_series_median(s : NlpembedbertSeries) -> Double { @_common.median(s.vals) }

pub fn nlp_embed_bert_series_scale(s : NlpembedbertSeries, f : Double) -> NlpembedbertSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn nlp_embed_bert_series_add(a : NlpembedbertSeries, b : NlpembedbertSeries) -> NlpembedbertSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn nlp_embed_bert_series_sub(a : NlpembedbertSeries, b : NlpembedbertSeries) -> NlpembedbertSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn nlp_embed_bert_series_normalize(s : NlpembedbertSeries) -> NlpembedbertSeries {
  let mn = nlp_embed_bert_series_min(s)
  let mx = nlp_embed_bert_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn nlp_embed_bert_series_cumsum(s : NlpembedbertSeries) -> NlpembedbertSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn nlp_embed_bert_series_to_string(s : NlpembedbertSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NlpembedbertMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn nlp_embed_bert_make_matrix(rows : Int, cols : Int, val : Double) -> NlpembedbertMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn nlp_embed_bert_matrix_identity(n : Int) -> NlpembedbertMatrix {
  let m = nlp_embed_bert_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn nlp_embed_bert_matrix_get(m : NlpembedbertMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn nlp_embed_bert_matrix_transpose(m : NlpembedbertMatrix) -> NlpembedbertMatrix {
  let result = nlp_embed_bert_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn nlp_embed_bert_matrix_add(a : NlpembedbertMatrix, b : NlpembedbertMatrix) -> NlpembedbertMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = nlp_embed_bert_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn nlp_embed_bert_matrix_scale(m : NlpembedbertMatrix, s : Double) -> NlpembedbertMatrix {
  let result = nlp_embed_bert_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn nlp_embed_bert_matrix_multiply(a : NlpembedbertMatrix, b : NlpembedbertMatrix) -> NlpembedbertMatrix {
  if a.cols != b.rows { return nlp_embed_bert_make_matrix(a.rows, b.cols, 0.0) }
  let result = nlp_embed_bert_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn nlp_embed_bert_matrix_trace(m : NlpembedbertMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn nlp_embed_bert_matrix_det(m : NlpembedbertMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn nlp_embed_bert_matrix_norm(m : NlpembedbertMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn nlp_embed_bert_matrix_to_string(m : NlpembedbertMatrix) -> String {
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

pub(all) struct NlpembedbertVector {
  comps : Array[Double]
  dim : Int
}

pub fn nlp_embed_bert_make_vector(comps : Array[Double]) -> NlpembedbertVector {
  { comps, dim: comps.length() }
}

pub fn nlp_embed_bert_vector_zero(dim : Int) -> NlpembedbertVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn nlp_embed_bert_vector_add(a : NlpembedbertVector, b : NlpembedbertVector) -> NlpembedbertVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn nlp_embed_bert_vector_sub(a : NlpembedbertVector, b : NlpembedbertVector) -> NlpembedbertVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn nlp_embed_bert_vector_scale(v : NlpembedbertVector, s : Double) -> NlpembedbertVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn nlp_embed_bert_vector_dot(a : NlpembedbertVector, b : NlpembedbertVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn nlp_embed_bert_vector_norm(v : NlpembedbertVector) -> Double { @_common.sqrt(nlp_embed_bert_vector_dot(v, v)) }

pub fn nlp_embed_bert_vector_normalize(v : NlpembedbertVector) -> NlpembedbertVector {
  let n = nlp_embed_bert_vector_norm(v)
  if n < 0.0000001 { v } else { nlp_embed_bert_vector_scale(v, 1.0 / n) }
}

pub fn nlp_embed_bert_vector_dist(a : NlpembedbertVector, b : NlpembedbertVector) -> Double {
  nlp_embed_bert_vector_norm(nlp_embed_bert_vector_sub(a, b))
}

pub fn nlp_embed_bert_vector_to_string(v : NlpembedbertVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn nlp_embed_bert_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn nlp_embed_bert_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn nlp_embed_bert_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn nlp_embed_bert_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn nlp_embed_bert_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn nlp_embed_bert_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn nlp_embed_bert_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn nlp_embed_bert_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn nlp_embed_bert_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn nlp_embed_bert_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn nlp_embed_bert_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn nlp_embed_bert_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn nlp_embed_bert_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn nlp_embed_bert_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn nlp_embed_bert_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn nlp_embed_bert_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn nlp_embed_bert_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn nlp_embed_bert_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn nlp_embed_bert_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn nlp_embed_bert_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn nlp_embed_bert_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn nlp_embed_bert_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn nlp_embed_bert_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn nlp_embed_bert_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn nlp_embed_bert_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn nlp_embed_bert_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn nlp_embed_bert_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn nlp_embed_bert_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn nlp_embed_bert_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct NlpembedbertFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_bert_frame_make(size : Int) -> NlpembedbertFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_bert_frame_len(s : NlpembedbertFrame) -> Int { s.size }

pub fn nlp_embed_bert_frame_get(s : NlpembedbertFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_bert_frame_set(s : NlpembedbertFrame, i : Int, v : Double) -> NlpembedbertFrame {
  let result = nlp_embed_bert_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_embed_bert_frame_sum(s : NlpembedbertFrame) -> Double { @_common.sum(s.data) }

pub fn nlp_embed_bert_frame_mean(s : NlpembedbertFrame) -> Double { @_common.mean(s.data) }

pub fn nlp_embed_bert_frame_scale(s : NlpembedbertFrame, f : Double) -> NlpembedbertFrame {
  let result = nlp_embed_bert_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_embed_bert_frame_add(a : NlpembedbertFrame, b : NlpembedbertFrame) -> NlpembedbertFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_embed_bert_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_embed_bert_frame_copy(s : NlpembedbertFrame) -> NlpembedbertFrame {
  let result = nlp_embed_bert_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_embed_bert_frame_fill(s : NlpembedbertFrame, v : Double) -> NlpembedbertFrame {
  let result = nlp_embed_bert_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_embed_bert_frame_min(s : NlpembedbertFrame) -> Double { @_common.min(s.data) }

pub fn nlp_embed_bert_frame_max(s : NlpembedbertFrame) -> Double { @_common.max(s.data) }

pub fn nlp_embed_bert_frame_to_string(s : NlpembedbertFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpembedbertTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_bert_table_make(size : Int) -> NlpembedbertTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_bert_table_len(s : NlpembedbertTable) -> Int { s.size }

pub fn nlp_embed_bert_table_get(s : NlpembedbertTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_bert_table_set(s : NlpembedbertTable, i : Int, v : Double) -> NlpembedbertTable {
  let result = nlp_embed_bert_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_embed_bert_table_sum(s : NlpembedbertTable) -> Double { @_common.sum(s.data) }

pub fn nlp_embed_bert_table_mean(s : NlpembedbertTable) -> Double { @_common.mean(s.data) }

pub fn nlp_embed_bert_table_scale(s : NlpembedbertTable, f : Double) -> NlpembedbertTable {
  let result = nlp_embed_bert_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_embed_bert_table_add(a : NlpembedbertTable, b : NlpembedbertTable) -> NlpembedbertTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_embed_bert_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_embed_bert_table_copy(s : NlpembedbertTable) -> NlpembedbertTable {
  let result = nlp_embed_bert_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_embed_bert_table_fill(s : NlpembedbertTable, v : Double) -> NlpembedbertTable {
  let result = nlp_embed_bert_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_embed_bert_table_min(s : NlpembedbertTable) -> Double { @_common.min(s.data) }

pub fn nlp_embed_bert_table_max(s : NlpembedbertTable) -> Double { @_common.max(s.data) }

pub fn nlp_embed_bert_table_to_string(s : NlpembedbertTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpembedbertGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_bert_graphn_make(size : Int) -> NlpembedbertGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_bert_graphn_len(s : NlpembedbertGraphN) -> Int { s.size }

pub fn nlp_embed_bert_graphn_get(s : NlpembedbertGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_bert_graphn_set(s : NlpembedbertGraphN, i : Int, v : Double) -> NlpembedbertGraphN {
  let result = nlp_embed_bert_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_embed_bert_graphn_sum(s : NlpembedbertGraphN) -> Double { @_common.sum(s.data) }

pub fn nlp_embed_bert_graphn_mean(s : NlpembedbertGraphN) -> Double { @_common.mean(s.data) }

pub fn nlp_embed_bert_graphn_scale(s : NlpembedbertGraphN, f : Double) -> NlpembedbertGraphN {
  let result = nlp_embed_bert_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_embed_bert_graphn_add(a : NlpembedbertGraphN, b : NlpembedbertGraphN) -> NlpembedbertGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_embed_bert_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_embed_bert_graphn_copy(s : NlpembedbertGraphN) -> NlpembedbertGraphN {
  let result = nlp_embed_bert_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_embed_bert_graphn_fill(s : NlpembedbertGraphN, v : Double) -> NlpembedbertGraphN {
  let result = nlp_embed_bert_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_embed_bert_graphn_min(s : NlpembedbertGraphN) -> Double { @_common.min(s.data) }

pub fn nlp_embed_bert_graphn_max(s : NlpembedbertGraphN) -> Double { @_common.max(s.data) }

pub fn nlp_embed_bert_graphn_to_string(s : NlpembedbertGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpembedbertNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_bert_node_make(size : Int) -> NlpembedbertNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_bert_node_len(s : NlpembedbertNode) -> Int { s.size }

pub fn nlp_embed_bert_node_get(s : NlpembedbertNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_bert_node_set(s : NlpembedbertNode, i : Int, v : Double) -> NlpembedbertNode {
  let result = nlp_embed_bert_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_embed_bert_node_sum(s : NlpembedbertNode) -> Double { @_common.sum(s.data) }

pub fn nlp_embed_bert_node_mean(s : NlpembedbertNode) -> Double { @_common.mean(s.data) }

pub fn nlp_embed_bert_node_scale(s : NlpembedbertNode, f : Double) -> NlpembedbertNode {
  let result = nlp_embed_bert_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_embed_bert_node_add(a : NlpembedbertNode, b : NlpembedbertNode) -> NlpembedbertNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_embed_bert_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_embed_bert_node_copy(s : NlpembedbertNode) -> NlpembedbertNode {
  let result = nlp_embed_bert_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_embed_bert_node_fill(s : NlpembedbertNode, v : Double) -> NlpembedbertNode {
  let result = nlp_embed_bert_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_embed_bert_node_min(s : NlpembedbertNode) -> Double { @_common.min(s.data) }

pub fn nlp_embed_bert_node_max(s : NlpembedbertNode) -> Double { @_common.max(s.data) }

pub fn nlp_embed_bert_node_to_string(s : NlpembedbertNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpembedbertEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_bert_edge_make(size : Int) -> NlpembedbertEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_bert_edge_len(s : NlpembedbertEdge) -> Int { s.size }

pub fn nlp_embed_bert_edge_get(s : NlpembedbertEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_bert_edge_set(s : NlpembedbertEdge, i : Int, v : Double) -> NlpembedbertEdge {
  let result = nlp_embed_bert_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_embed_bert_edge_sum(s : NlpembedbertEdge) -> Double { @_common.sum(s.data) }

pub fn nlp_embed_bert_edge_mean(s : NlpembedbertEdge) -> Double { @_common.mean(s.data) }

pub fn nlp_embed_bert_edge_scale(s : NlpembedbertEdge, f : Double) -> NlpembedbertEdge {
  let result = nlp_embed_bert_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_embed_bert_edge_add(a : NlpembedbertEdge, b : NlpembedbertEdge) -> NlpembedbertEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_embed_bert_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_embed_bert_edge_copy(s : NlpembedbertEdge) -> NlpembedbertEdge {
  let result = nlp_embed_bert_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_embed_bert_edge_fill(s : NlpembedbertEdge, v : Double) -> NlpembedbertEdge {
  let result = nlp_embed_bert_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_embed_bert_edge_min(s : NlpembedbertEdge) -> Double { @_common.min(s.data) }

pub fn nlp_embed_bert_edge_max(s : NlpembedbertEdge) -> Double { @_common.max(s.data) }

pub fn nlp_embed_bert_edge_to_string(s : NlpembedbertEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpembedbertPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_bert_path_make(size : Int) -> NlpembedbertPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_bert_path_len(s : NlpembedbertPath) -> Int { s.size }

pub fn nlp_embed_bert_path_get(s : NlpembedbertPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_bert_path_set(s : NlpembedbertPath, i : Int, v : Double) -> NlpembedbertPath {
  let result = nlp_embed_bert_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_embed_bert_path_sum(s : NlpembedbertPath) -> Double { @_common.sum(s.data) }

pub fn nlp_embed_bert_path_mean(s : NlpembedbertPath) -> Double { @_common.mean(s.data) }

pub fn nlp_embed_bert_path_scale(s : NlpembedbertPath, f : Double) -> NlpembedbertPath {
  let result = nlp_embed_bert_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_embed_bert_path_add(a : NlpembedbertPath, b : NlpembedbertPath) -> NlpembedbertPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_embed_bert_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_embed_bert_path_copy(s : NlpembedbertPath) -> NlpembedbertPath {
  let result = nlp_embed_bert_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_embed_bert_path_fill(s : NlpembedbertPath, v : Double) -> NlpembedbertPath {
  let result = nlp_embed_bert_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_embed_bert_path_min(s : NlpembedbertPath) -> Double { @_common.min(s.data) }

pub fn nlp_embed_bert_path_max(s : NlpembedbertPath) -> Double { @_common.max(s.data) }

pub fn nlp_embed_bert_path_to_string(s : NlpembedbertPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpembedbertCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_bert_cluster_make(size : Int) -> NlpembedbertCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_bert_cluster_len(s : NlpembedbertCluster) -> Int { s.size }

pub fn nlp_embed_bert_cluster_get(s : NlpembedbertCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_bert_cluster_set(s : NlpembedbertCluster, i : Int, v : Double) -> NlpembedbertCluster {
  let result = nlp_embed_bert_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_embed_bert_cluster_sum(s : NlpembedbertCluster) -> Double { @_common.sum(s.data) }

pub fn nlp_embed_bert_cluster_mean(s : NlpembedbertCluster) -> Double { @_common.mean(s.data) }

pub fn nlp_embed_bert_cluster_scale(s : NlpembedbertCluster, f : Double) -> NlpembedbertCluster {
  let result = nlp_embed_bert_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_embed_bert_cluster_add(a : NlpembedbertCluster, b : NlpembedbertCluster) -> NlpembedbertCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_embed_bert_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_embed_bert_cluster_copy(s : NlpembedbertCluster) -> NlpembedbertCluster {
  let result = nlp_embed_bert_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_embed_bert_cluster_fill(s : NlpembedbertCluster, v : Double) -> NlpembedbertCluster {
  let result = nlp_embed_bert_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_embed_bert_cluster_min(s : NlpembedbertCluster) -> Double { @_common.min(s.data) }

pub fn nlp_embed_bert_cluster_max(s : NlpembedbertCluster) -> Double { @_common.max(s.data) }

pub fn nlp_embed_bert_cluster_to_string(s : NlpembedbertCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpembedbertModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_bert_model_make(size : Int) -> NlpembedbertModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_bert_model_len(s : NlpembedbertModel) -> Int { s.size }

pub fn nlp_embed_bert_model_get(s : NlpembedbertModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_bert_model_set(s : NlpembedbertModel, i : Int, v : Double) -> NlpembedbertModel {
  let result = nlp_embed_bert_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_embed_bert_model_sum(s : NlpembedbertModel) -> Double { @_common.sum(s.data) }

pub fn nlp_embed_bert_model_mean(s : NlpembedbertModel) -> Double { @_common.mean(s.data) }

pub fn nlp_embed_bert_model_scale(s : NlpembedbertModel, f : Double) -> NlpembedbertModel {
  let result = nlp_embed_bert_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_embed_bert_model_add(a : NlpembedbertModel, b : NlpembedbertModel) -> NlpembedbertModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_embed_bert_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_embed_bert_model_copy(s : NlpembedbertModel) -> NlpembedbertModel {
  let result = nlp_embed_bert_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_embed_bert_model_fill(s : NlpembedbertModel, v : Double) -> NlpembedbertModel {
  let result = nlp_embed_bert_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_embed_bert_model_min(s : NlpembedbertModel) -> Double { @_common.min(s.data) }

pub fn nlp_embed_bert_model_max(s : NlpembedbertModel) -> Double { @_common.max(s.data) }

pub fn nlp_embed_bert_model_to_string(s : NlpembedbertModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpembedbertLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_bert_layer_make(size : Int) -> NlpembedbertLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_bert_layer_len(s : NlpembedbertLayer) -> Int { s.size }

pub fn nlp_embed_bert_layer_get(s : NlpembedbertLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_bert_layer_set(s : NlpembedbertLayer, i : Int, v : Double) -> NlpembedbertLayer {
  let result = nlp_embed_bert_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_embed_bert_layer_sum(s : NlpembedbertLayer) -> Double { @_common.sum(s.data) }

pub fn nlp_embed_bert_layer_mean(s : NlpembedbertLayer) -> Double { @_common.mean(s.data) }

pub fn nlp_embed_bert_layer_scale(s : NlpembedbertLayer, f : Double) -> NlpembedbertLayer {
  let result = nlp_embed_bert_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_embed_bert_layer_add(a : NlpembedbertLayer, b : NlpembedbertLayer) -> NlpembedbertLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_embed_bert_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_embed_bert_layer_copy(s : NlpembedbertLayer) -> NlpembedbertLayer {
  let result = nlp_embed_bert_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_embed_bert_layer_fill(s : NlpembedbertLayer, v : Double) -> NlpembedbertLayer {
  let result = nlp_embed_bert_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_embed_bert_layer_min(s : NlpembedbertLayer) -> Double { @_common.min(s.data) }

pub fn nlp_embed_bert_layer_max(s : NlpembedbertLayer) -> Double { @_common.max(s.data) }

pub fn nlp_embed_bert_layer_to_string(s : NlpembedbertLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpembedbertBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_bert_buffer_make(size : Int) -> NlpembedbertBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_bert_buffer_len(s : NlpembedbertBuffer) -> Int { s.size }

pub fn nlp_embed_bert_buffer_get(s : NlpembedbertBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_bert_buffer_set(s : NlpembedbertBuffer, i : Int, v : Double) -> NlpembedbertBuffer {
  let result = nlp_embed_bert_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_embed_bert_buffer_sum(s : NlpembedbertBuffer) -> Double { @_common.sum(s.data) }

pub fn nlp_embed_bert_buffer_mean(s : NlpembedbertBuffer) -> Double { @_common.mean(s.data) }

pub fn nlp_embed_bert_buffer_scale(s : NlpembedbertBuffer, f : Double) -> NlpembedbertBuffer {
  let result = nlp_embed_bert_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_embed_bert_buffer_add(a : NlpembedbertBuffer, b : NlpembedbertBuffer) -> NlpembedbertBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_embed_bert_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_embed_bert_buffer_copy(s : NlpembedbertBuffer) -> NlpembedbertBuffer {
  let result = nlp_embed_bert_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_embed_bert_buffer_fill(s : NlpembedbertBuffer, v : Double) -> NlpembedbertBuffer {
  let result = nlp_embed_bert_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_embed_bert_buffer_min(s : NlpembedbertBuffer) -> Double { @_common.min(s.data) }

pub fn nlp_embed_bert_buffer_max(s : NlpembedbertBuffer) -> Double { @_common.max(s.data) }

pub fn nlp_embed_bert_buffer_to_string(s : NlpembedbertBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpembedbertCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_bert_cursor_make(size : Int) -> NlpembedbertCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_bert_cursor_len(s : NlpembedbertCursor) -> Int { s.size }

pub fn nlp_embed_bert_cursor_get(s : NlpembedbertCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_bert_cursor_set(s : NlpembedbertCursor, i : Int, v : Double) -> NlpembedbertCursor {
  let result = nlp_embed_bert_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_embed_bert_cursor_sum(s : NlpembedbertCursor) -> Double { @_common.sum(s.data) }

pub fn nlp_embed_bert_cursor_mean(s : NlpembedbertCursor) -> Double { @_common.mean(s.data) }

pub fn nlp_embed_bert_cursor_scale(s : NlpembedbertCursor, f : Double) -> NlpembedbertCursor {
  let result = nlp_embed_bert_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_embed_bert_cursor_add(a : NlpembedbertCursor, b : NlpembedbertCursor) -> NlpembedbertCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_embed_bert_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_embed_bert_cursor_copy(s : NlpembedbertCursor) -> NlpembedbertCursor {
  let result = nlp_embed_bert_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_embed_bert_cursor_fill(s : NlpembedbertCursor, v : Double) -> NlpembedbertCursor {
  let result = nlp_embed_bert_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_embed_bert_cursor_min(s : NlpembedbertCursor) -> Double { @_common.min(s.data) }

pub fn nlp_embed_bert_cursor_max(s : NlpembedbertCursor) -> Double { @_common.max(s.data) }

pub fn nlp_embed_bert_cursor_to_string(s : NlpembedbertCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpembedbertView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_bert_view_make(size : Int) -> NlpembedbertView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_bert_view_len(s : NlpembedbertView) -> Int { s.size }

pub fn nlp_embed_bert_view_get(s : NlpembedbertView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_bert_view_set(s : NlpembedbertView, i : Int, v : Double) -> NlpembedbertView {
  let result = nlp_embed_bert_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_embed_bert_view_sum(s : NlpembedbertView) -> Double { @_common.sum(s.data) }

pub fn nlp_embed_bert_view_mean(s : NlpembedbertView) -> Double { @_common.mean(s.data) }

pub fn nlp_embed_bert_view_scale(s : NlpembedbertView, f : Double) -> NlpembedbertView {
  let result = nlp_embed_bert_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_embed_bert_view_add(a : NlpembedbertView, b : NlpembedbertView) -> NlpembedbertView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_embed_bert_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_embed_bert_view_copy(s : NlpembedbertView) -> NlpembedbertView {
  let result = nlp_embed_bert_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_embed_bert_view_fill(s : NlpembedbertView, v : Double) -> NlpembedbertView {
  let result = nlp_embed_bert_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_embed_bert_view_min(s : NlpembedbertView) -> Double { @_common.min(s.data) }

pub fn nlp_embed_bert_view_max(s : NlpembedbertView) -> Double { @_common.max(s.data) }

pub fn nlp_embed_bert_view_to_string(s : NlpembedbertView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpembedbertRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_bert_range_make(size : Int) -> NlpembedbertRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_bert_range_len(s : NlpembedbertRange) -> Int { s.size }

pub fn nlp_embed_bert_range_get(s : NlpembedbertRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_bert_range_set(s : NlpembedbertRange, i : Int, v : Double) -> NlpembedbertRange {
  let result = nlp_embed_bert_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_embed_bert_range_sum(s : NlpembedbertRange) -> Double { @_common.sum(s.data) }

pub fn nlp_embed_bert_range_mean(s : NlpembedbertRange) -> Double { @_common.mean(s.data) }

pub fn nlp_embed_bert_range_scale(s : NlpembedbertRange, f : Double) -> NlpembedbertRange {
  let result = nlp_embed_bert_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_embed_bert_range_add(a : NlpembedbertRange, b : NlpembedbertRange) -> NlpembedbertRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_embed_bert_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_embed_bert_range_copy(s : NlpembedbertRange) -> NlpembedbertRange {
  let result = nlp_embed_bert_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_embed_bert_range_fill(s : NlpembedbertRange, v : Double) -> NlpembedbertRange {
  let result = nlp_embed_bert_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_embed_bert_range_min(s : NlpembedbertRange) -> Double { @_common.min(s.data) }

pub fn nlp_embed_bert_range_max(s : NlpembedbertRange) -> Double { @_common.max(s.data) }

pub fn nlp_embed_bert_range_to_string(s : NlpembedbertRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpembedbertSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_bert_slice_make(size : Int) -> NlpembedbertSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_bert_slice_len(s : NlpembedbertSlice) -> Int { s.size }

pub fn nlp_embed_bert_slice_get(s : NlpembedbertSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_bert_slice_set(s : NlpembedbertSlice, i : Int, v : Double) -> NlpembedbertSlice {
  let result = nlp_embed_bert_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_embed_bert_slice_sum(s : NlpembedbertSlice) -> Double { @_common.sum(s.data) }

pub fn nlp_embed_bert_slice_mean(s : NlpembedbertSlice) -> Double { @_common.mean(s.data) }

pub fn nlp_embed_bert_slice_scale(s : NlpembedbertSlice, f : Double) -> NlpembedbertSlice {
  let result = nlp_embed_bert_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_embed_bert_slice_add(a : NlpembedbertSlice, b : NlpembedbertSlice) -> NlpembedbertSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_embed_bert_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_embed_bert_slice_copy(s : NlpembedbertSlice) -> NlpembedbertSlice {
  let result = nlp_embed_bert_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_embed_bert_slice_fill(s : NlpembedbertSlice, v : Double) -> NlpembedbertSlice {
  let result = nlp_embed_bert_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_embed_bert_slice_min(s : NlpembedbertSlice) -> Double { @_common.min(s.data) }

pub fn nlp_embed_bert_slice_max(s : NlpembedbertSlice) -> Double { @_common.max(s.data) }

pub fn nlp_embed_bert_slice_to_string(s : NlpembedbertSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

