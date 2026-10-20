///===
/// extcore/nlp_tokenize_unigram

pub(all) struct NlptokenizeunigramPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn nlp_tokenize_unigram_make_point(x : Double, y : Double) -> NlptokenizeunigramPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn nlp_tokenize_unigram_make_point3(x : Double, y : Double, z : Double) -> NlptokenizeunigramPoint {
  { x, y, z, label: 0 }
}

pub fn nlp_tokenize_unigram_point_x(pt : NlptokenizeunigramPoint) -> Double { pt.x }

pub fn nlp_tokenize_unigram_point_y(pt : NlptokenizeunigramPoint) -> Double { pt.y }

pub fn nlp_tokenize_unigram_point_z(pt : NlptokenizeunigramPoint) -> Double { pt.z }

pub fn nlp_tokenize_unigram_point_label(pt : NlptokenizeunigramPoint) -> Int { pt.label }

pub fn nlp_tokenize_unigram_point_dist(a : NlptokenizeunigramPoint, b : NlptokenizeunigramPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn nlp_tokenize_unigram_point_add(a : NlptokenizeunigramPoint, b : NlptokenizeunigramPoint) -> NlptokenizeunigramPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn nlp_tokenize_unigram_point_sub(a : NlptokenizeunigramPoint, b : NlptokenizeunigramPoint) -> NlptokenizeunigramPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn nlp_tokenize_unigram_point_scale(pt : NlptokenizeunigramPoint, s : Double) -> NlptokenizeunigramPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn nlp_tokenize_unigram_point_dot(a : NlptokenizeunigramPoint, b : NlptokenizeunigramPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn nlp_tokenize_unigram_point_cross(a : NlptokenizeunigramPoint, b : NlptokenizeunigramPoint) -> NlptokenizeunigramPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn nlp_tokenize_unigram_point_norm(pt : NlptokenizeunigramPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn nlp_tokenize_unigram_point_normalize(pt : NlptokenizeunigramPoint) -> NlptokenizeunigramPoint {
  let n = nlp_tokenize_unigram_point_norm(pt)
  if n < 0.0000001 { pt } else { nlp_tokenize_unigram_point_scale(pt, 1.0 / n) }
}

pub fn nlp_tokenize_unigram_point_negate(pt : NlptokenizeunigramPoint) -> NlptokenizeunigramPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn nlp_tokenize_unigram_point_mid(a : NlptokenizeunigramPoint, b : NlptokenizeunigramPoint) -> NlptokenizeunigramPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn nlp_tokenize_unigram_point_lerp(a : NlptokenizeunigramPoint, b : NlptokenizeunigramPoint, t : Double) -> NlptokenizeunigramPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn nlp_tokenize_unigram_point_to_string(pt : NlptokenizeunigramPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct NlptokenizeunigramSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn nlp_tokenize_unigram_make_series(vals : Array[Double], name : String) -> NlptokenizeunigramSeries {
  { vals, name, meta: 0 }
}

pub fn nlp_tokenize_unigram_series_len(s : NlptokenizeunigramSeries) -> Int { s.vals.length() }

pub fn nlp_tokenize_unigram_series_sum(s : NlptokenizeunigramSeries) -> Double { @_common.sum(s.vals) }

pub fn nlp_tokenize_unigram_series_mean(s : NlptokenizeunigramSeries) -> Double { @_common.mean(s.vals) }

pub fn nlp_tokenize_unigram_series_min(s : NlptokenizeunigramSeries) -> Double { @_common.min(s.vals) }

pub fn nlp_tokenize_unigram_series_max(s : NlptokenizeunigramSeries) -> Double { @_common.max(s.vals) }

pub fn nlp_tokenize_unigram_series_range(s : NlptokenizeunigramSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn nlp_tokenize_unigram_series_var(s : NlptokenizeunigramSeries) -> Double { @_common.variance(s.vals) }

pub fn nlp_tokenize_unigram_series_std(s : NlptokenizeunigramSeries) -> Double { @_common.std(s.vals) }

pub fn nlp_tokenize_unigram_series_median(s : NlptokenizeunigramSeries) -> Double { @_common.median(s.vals) }

pub fn nlp_tokenize_unigram_series_scale(s : NlptokenizeunigramSeries, f : Double) -> NlptokenizeunigramSeries {
  { vals: @_common.scale_arr(s.vals, f), name: s.name, meta: s.meta }
}

pub fn nlp_tokenize_unigram_series_add(a : NlptokenizeunigramSeries, b : NlptokenizeunigramSeries) -> NlptokenizeunigramSeries {
  { vals: @_common.add_arr(a.vals, b.vals), name: a.name + "+" + b.name, meta: a.meta }
}

pub fn nlp_tokenize_unigram_series_sub(a : NlptokenizeunigramSeries, b : NlptokenizeunigramSeries) -> NlptokenizeunigramSeries {
  { vals: @_common.sub_arr(a.vals, b.vals), name: a.name + "-" + b.name, meta: a.meta }
}

pub fn nlp_tokenize_unigram_series_normalize(s : NlptokenizeunigramSeries) -> NlptokenizeunigramSeries {
  let mn = nlp_tokenize_unigram_series_min(s)
  let mx = nlp_tokenize_unigram_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn nlp_tokenize_unigram_series_cumsum(s : NlptokenizeunigramSeries) -> NlptokenizeunigramSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn nlp_tokenize_unigram_series_to_string(s : NlptokenizeunigramSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NlptokenizeunigramMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn nlp_tokenize_unigram_make_matrix(rows : Int, cols : Int, val : Double) -> NlptokenizeunigramMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn nlp_tokenize_unigram_matrix_identity(n : Int) -> NlptokenizeunigramMatrix {
  let m = nlp_tokenize_unigram_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn nlp_tokenize_unigram_matrix_get(m : NlptokenizeunigramMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn nlp_tokenize_unigram_matrix_transpose(m : NlptokenizeunigramMatrix) -> NlptokenizeunigramMatrix {
  let result = nlp_tokenize_unigram_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn nlp_tokenize_unigram_matrix_add(a : NlptokenizeunigramMatrix, b : NlptokenizeunigramMatrix) -> NlptokenizeunigramMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = nlp_tokenize_unigram_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn nlp_tokenize_unigram_matrix_scale(m : NlptokenizeunigramMatrix, s : Double) -> NlptokenizeunigramMatrix {
  let result = nlp_tokenize_unigram_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn nlp_tokenize_unigram_matrix_multiply(a : NlptokenizeunigramMatrix, b : NlptokenizeunigramMatrix) -> NlptokenizeunigramMatrix {
  if a.cols != b.rows { return nlp_tokenize_unigram_make_matrix(a.rows, b.cols, 0.0) }
  let result = nlp_tokenize_unigram_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn nlp_tokenize_unigram_matrix_trace(m : NlptokenizeunigramMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn nlp_tokenize_unigram_matrix_det(m : NlptokenizeunigramMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn nlp_tokenize_unigram_matrix_norm(m : NlptokenizeunigramMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn nlp_tokenize_unigram_matrix_to_string(m : NlptokenizeunigramMatrix) -> String {
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

pub(all) struct NlptokenizeunigramVector {
  comps : Array[Double]
  dim : Int
}

pub fn nlp_tokenize_unigram_make_vector(comps : Array[Double]) -> NlptokenizeunigramVector {
  { comps, dim: comps.length() }
}

pub fn nlp_tokenize_unigram_vector_zero(dim : Int) -> NlptokenizeunigramVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn nlp_tokenize_unigram_vector_add(a : NlptokenizeunigramVector, b : NlptokenizeunigramVector) -> NlptokenizeunigramVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.add_arr(a.comps, b.comps), dim: n }
}

pub fn nlp_tokenize_unigram_vector_sub(a : NlptokenizeunigramVector, b : NlptokenizeunigramVector) -> NlptokenizeunigramVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.sub_arr(a.comps, b.comps), dim: n }
}

pub fn nlp_tokenize_unigram_vector_scale(v : NlptokenizeunigramVector, s : Double) -> NlptokenizeunigramVector {
  { comps: @_common.scale_arr(v.comps, s), dim: v.dim }
}

pub fn nlp_tokenize_unigram_vector_dot(a : NlptokenizeunigramVector, b : NlptokenizeunigramVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn nlp_tokenize_unigram_vector_norm(v : NlptokenizeunigramVector) -> Double { @_common.sqrt(nlp_tokenize_unigram_vector_dot(v, v)) }

pub fn nlp_tokenize_unigram_vector_normalize(v : NlptokenizeunigramVector) -> NlptokenizeunigramVector {
  let n = nlp_tokenize_unigram_vector_norm(v)
  if n < 0.0000001 { v } else { nlp_tokenize_unigram_vector_scale(v, 1.0 / n) }
}

pub fn nlp_tokenize_unigram_vector_dist(a : NlptokenizeunigramVector, b : NlptokenizeunigramVector) -> Double {
  nlp_tokenize_unigram_vector_norm(nlp_tokenize_unigram_vector_sub(a, b))
}

pub fn nlp_tokenize_unigram_vector_to_string(v : NlptokenizeunigramVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn nlp_tokenize_unigram_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn nlp_tokenize_unigram_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn nlp_tokenize_unigram_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn nlp_tokenize_unigram_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn nlp_tokenize_unigram_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn nlp_tokenize_unigram_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn nlp_tokenize_unigram_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn nlp_tokenize_unigram_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn nlp_tokenize_unigram_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn nlp_tokenize_unigram_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn nlp_tokenize_unigram_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn nlp_tokenize_unigram_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn nlp_tokenize_unigram_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn nlp_tokenize_unigram_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn nlp_tokenize_unigram_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn nlp_tokenize_unigram_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn nlp_tokenize_unigram_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn nlp_tokenize_unigram_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn nlp_tokenize_unigram_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn nlp_tokenize_unigram_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn nlp_tokenize_unigram_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn nlp_tokenize_unigram_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn nlp_tokenize_unigram_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn nlp_tokenize_unigram_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn nlp_tokenize_unigram_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn nlp_tokenize_unigram_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn nlp_tokenize_unigram_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn nlp_tokenize_unigram_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn nlp_tokenize_unigram_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct NlptokenizeunigramFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_unigram_frame_make(size : Int) -> NlptokenizeunigramFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_unigram_frame_len(s : NlptokenizeunigramFrame) -> Int { s.size }

pub fn nlp_tokenize_unigram_frame_get(s : NlptokenizeunigramFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_unigram_frame_set(s : NlptokenizeunigramFrame, i : Int, v : Double) -> NlptokenizeunigramFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_unigram_frame_sum(s : NlptokenizeunigramFrame) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_unigram_frame_mean(s : NlptokenizeunigramFrame) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_unigram_frame_scale(s : NlptokenizeunigramFrame, f : Double) -> NlptokenizeunigramFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_unigram_frame_add(a : NlptokenizeunigramFrame, b : NlptokenizeunigramFrame) -> NlptokenizeunigramFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_tokenize_unigram_frame_copy(s : NlptokenizeunigramFrame) -> NlptokenizeunigramFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_unigram_frame_fill(s : NlptokenizeunigramFrame, v : Double) -> NlptokenizeunigramFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_unigram_frame_min(s : NlptokenizeunigramFrame) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_unigram_frame_max(s : NlptokenizeunigramFrame) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_unigram_frame_to_string(s : NlptokenizeunigramFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizeunigramTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_unigram_table_make(size : Int) -> NlptokenizeunigramTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_unigram_table_len(s : NlptokenizeunigramTable) -> Int { s.size }

pub fn nlp_tokenize_unigram_table_get(s : NlptokenizeunigramTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_unigram_table_set(s : NlptokenizeunigramTable, i : Int, v : Double) -> NlptokenizeunigramTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_unigram_table_sum(s : NlptokenizeunigramTable) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_unigram_table_mean(s : NlptokenizeunigramTable) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_unigram_table_scale(s : NlptokenizeunigramTable, f : Double) -> NlptokenizeunigramTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_unigram_table_add(a : NlptokenizeunigramTable, b : NlptokenizeunigramTable) -> NlptokenizeunigramTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_tokenize_unigram_table_copy(s : NlptokenizeunigramTable) -> NlptokenizeunigramTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_unigram_table_fill(s : NlptokenizeunigramTable, v : Double) -> NlptokenizeunigramTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_unigram_table_min(s : NlptokenizeunigramTable) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_unigram_table_max(s : NlptokenizeunigramTable) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_unigram_table_to_string(s : NlptokenizeunigramTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizeunigramGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_unigram_graphn_make(size : Int) -> NlptokenizeunigramGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_unigram_graphn_len(s : NlptokenizeunigramGraphN) -> Int { s.size }

pub fn nlp_tokenize_unigram_graphn_get(s : NlptokenizeunigramGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_unigram_graphn_set(s : NlptokenizeunigramGraphN, i : Int, v : Double) -> NlptokenizeunigramGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_unigram_graphn_sum(s : NlptokenizeunigramGraphN) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_unigram_graphn_mean(s : NlptokenizeunigramGraphN) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_unigram_graphn_scale(s : NlptokenizeunigramGraphN, f : Double) -> NlptokenizeunigramGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_unigram_graphn_add(a : NlptokenizeunigramGraphN, b : NlptokenizeunigramGraphN) -> NlptokenizeunigramGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_tokenize_unigram_graphn_copy(s : NlptokenizeunigramGraphN) -> NlptokenizeunigramGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_unigram_graphn_fill(s : NlptokenizeunigramGraphN, v : Double) -> NlptokenizeunigramGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_unigram_graphn_min(s : NlptokenizeunigramGraphN) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_unigram_graphn_max(s : NlptokenizeunigramGraphN) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_unigram_graphn_to_string(s : NlptokenizeunigramGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizeunigramNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_unigram_node_make(size : Int) -> NlptokenizeunigramNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_unigram_node_len(s : NlptokenizeunigramNode) -> Int { s.size }

pub fn nlp_tokenize_unigram_node_get(s : NlptokenizeunigramNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_unigram_node_set(s : NlptokenizeunigramNode, i : Int, v : Double) -> NlptokenizeunigramNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_unigram_node_sum(s : NlptokenizeunigramNode) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_unigram_node_mean(s : NlptokenizeunigramNode) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_unigram_node_scale(s : NlptokenizeunigramNode, f : Double) -> NlptokenizeunigramNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_unigram_node_add(a : NlptokenizeunigramNode, b : NlptokenizeunigramNode) -> NlptokenizeunigramNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_tokenize_unigram_node_copy(s : NlptokenizeunigramNode) -> NlptokenizeunigramNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_unigram_node_fill(s : NlptokenizeunigramNode, v : Double) -> NlptokenizeunigramNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_unigram_node_min(s : NlptokenizeunigramNode) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_unigram_node_max(s : NlptokenizeunigramNode) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_unigram_node_to_string(s : NlptokenizeunigramNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizeunigramEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_unigram_edge_make(size : Int) -> NlptokenizeunigramEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_unigram_edge_len(s : NlptokenizeunigramEdge) -> Int { s.size }

pub fn nlp_tokenize_unigram_edge_get(s : NlptokenizeunigramEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_unigram_edge_set(s : NlptokenizeunigramEdge, i : Int, v : Double) -> NlptokenizeunigramEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_unigram_edge_sum(s : NlptokenizeunigramEdge) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_unigram_edge_mean(s : NlptokenizeunigramEdge) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_unigram_edge_scale(s : NlptokenizeunigramEdge, f : Double) -> NlptokenizeunigramEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_unigram_edge_add(a : NlptokenizeunigramEdge, b : NlptokenizeunigramEdge) -> NlptokenizeunigramEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_tokenize_unigram_edge_copy(s : NlptokenizeunigramEdge) -> NlptokenizeunigramEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_unigram_edge_fill(s : NlptokenizeunigramEdge, v : Double) -> NlptokenizeunigramEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_unigram_edge_min(s : NlptokenizeunigramEdge) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_unigram_edge_max(s : NlptokenizeunigramEdge) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_unigram_edge_to_string(s : NlptokenizeunigramEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizeunigramPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_unigram_path_make(size : Int) -> NlptokenizeunigramPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_unigram_path_len(s : NlptokenizeunigramPath) -> Int { s.size }

pub fn nlp_tokenize_unigram_path_get(s : NlptokenizeunigramPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_unigram_path_set(s : NlptokenizeunigramPath, i : Int, v : Double) -> NlptokenizeunigramPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_unigram_path_sum(s : NlptokenizeunigramPath) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_unigram_path_mean(s : NlptokenizeunigramPath) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_unigram_path_scale(s : NlptokenizeunigramPath, f : Double) -> NlptokenizeunigramPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_unigram_path_add(a : NlptokenizeunigramPath, b : NlptokenizeunigramPath) -> NlptokenizeunigramPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_tokenize_unigram_path_copy(s : NlptokenizeunigramPath) -> NlptokenizeunigramPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_unigram_path_fill(s : NlptokenizeunigramPath, v : Double) -> NlptokenizeunigramPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_unigram_path_min(s : NlptokenizeunigramPath) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_unigram_path_max(s : NlptokenizeunigramPath) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_unigram_path_to_string(s : NlptokenizeunigramPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizeunigramCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_unigram_cluster_make(size : Int) -> NlptokenizeunigramCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_unigram_cluster_len(s : NlptokenizeunigramCluster) -> Int { s.size }

pub fn nlp_tokenize_unigram_cluster_get(s : NlptokenizeunigramCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_unigram_cluster_set(s : NlptokenizeunigramCluster, i : Int, v : Double) -> NlptokenizeunigramCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_unigram_cluster_sum(s : NlptokenizeunigramCluster) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_unigram_cluster_mean(s : NlptokenizeunigramCluster) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_unigram_cluster_scale(s : NlptokenizeunigramCluster, f : Double) -> NlptokenizeunigramCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_unigram_cluster_add(a : NlptokenizeunigramCluster, b : NlptokenizeunigramCluster) -> NlptokenizeunigramCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_tokenize_unigram_cluster_copy(s : NlptokenizeunigramCluster) -> NlptokenizeunigramCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_unigram_cluster_fill(s : NlptokenizeunigramCluster, v : Double) -> NlptokenizeunigramCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_unigram_cluster_min(s : NlptokenizeunigramCluster) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_unigram_cluster_max(s : NlptokenizeunigramCluster) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_unigram_cluster_to_string(s : NlptokenizeunigramCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizeunigramModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_unigram_model_make(size : Int) -> NlptokenizeunigramModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_unigram_model_len(s : NlptokenizeunigramModel) -> Int { s.size }

pub fn nlp_tokenize_unigram_model_get(s : NlptokenizeunigramModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_unigram_model_set(s : NlptokenizeunigramModel, i : Int, v : Double) -> NlptokenizeunigramModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_unigram_model_sum(s : NlptokenizeunigramModel) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_unigram_model_mean(s : NlptokenizeunigramModel) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_unigram_model_scale(s : NlptokenizeunigramModel, f : Double) -> NlptokenizeunigramModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_unigram_model_add(a : NlptokenizeunigramModel, b : NlptokenizeunigramModel) -> NlptokenizeunigramModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_tokenize_unigram_model_copy(s : NlptokenizeunigramModel) -> NlptokenizeunigramModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_unigram_model_fill(s : NlptokenizeunigramModel, v : Double) -> NlptokenizeunigramModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_unigram_model_min(s : NlptokenizeunigramModel) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_unigram_model_max(s : NlptokenizeunigramModel) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_unigram_model_to_string(s : NlptokenizeunigramModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizeunigramLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_unigram_layer_make(size : Int) -> NlptokenizeunigramLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_unigram_layer_len(s : NlptokenizeunigramLayer) -> Int { s.size }

pub fn nlp_tokenize_unigram_layer_get(s : NlptokenizeunigramLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_unigram_layer_set(s : NlptokenizeunigramLayer, i : Int, v : Double) -> NlptokenizeunigramLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_unigram_layer_sum(s : NlptokenizeunigramLayer) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_unigram_layer_mean(s : NlptokenizeunigramLayer) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_unigram_layer_scale(s : NlptokenizeunigramLayer, f : Double) -> NlptokenizeunigramLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_unigram_layer_add(a : NlptokenizeunigramLayer, b : NlptokenizeunigramLayer) -> NlptokenizeunigramLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_tokenize_unigram_layer_copy(s : NlptokenizeunigramLayer) -> NlptokenizeunigramLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_unigram_layer_fill(s : NlptokenizeunigramLayer, v : Double) -> NlptokenizeunigramLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_unigram_layer_min(s : NlptokenizeunigramLayer) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_unigram_layer_max(s : NlptokenizeunigramLayer) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_unigram_layer_to_string(s : NlptokenizeunigramLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizeunigramBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_unigram_buffer_make(size : Int) -> NlptokenizeunigramBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_unigram_buffer_len(s : NlptokenizeunigramBuffer) -> Int { s.size }

pub fn nlp_tokenize_unigram_buffer_get(s : NlptokenizeunigramBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_unigram_buffer_set(s : NlptokenizeunigramBuffer, i : Int, v : Double) -> NlptokenizeunigramBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_unigram_buffer_sum(s : NlptokenizeunigramBuffer) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_unigram_buffer_mean(s : NlptokenizeunigramBuffer) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_unigram_buffer_scale(s : NlptokenizeunigramBuffer, f : Double) -> NlptokenizeunigramBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_unigram_buffer_add(a : NlptokenizeunigramBuffer, b : NlptokenizeunigramBuffer) -> NlptokenizeunigramBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_tokenize_unigram_buffer_copy(s : NlptokenizeunigramBuffer) -> NlptokenizeunigramBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_unigram_buffer_fill(s : NlptokenizeunigramBuffer, v : Double) -> NlptokenizeunigramBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_unigram_buffer_min(s : NlptokenizeunigramBuffer) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_unigram_buffer_max(s : NlptokenizeunigramBuffer) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_unigram_buffer_to_string(s : NlptokenizeunigramBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizeunigramCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_unigram_cursor_make(size : Int) -> NlptokenizeunigramCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_unigram_cursor_len(s : NlptokenizeunigramCursor) -> Int { s.size }

pub fn nlp_tokenize_unigram_cursor_get(s : NlptokenizeunigramCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_unigram_cursor_set(s : NlptokenizeunigramCursor, i : Int, v : Double) -> NlptokenizeunigramCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_unigram_cursor_sum(s : NlptokenizeunigramCursor) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_unigram_cursor_mean(s : NlptokenizeunigramCursor) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_unigram_cursor_scale(s : NlptokenizeunigramCursor, f : Double) -> NlptokenizeunigramCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_unigram_cursor_add(a : NlptokenizeunigramCursor, b : NlptokenizeunigramCursor) -> NlptokenizeunigramCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_tokenize_unigram_cursor_copy(s : NlptokenizeunigramCursor) -> NlptokenizeunigramCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_unigram_cursor_fill(s : NlptokenizeunigramCursor, v : Double) -> NlptokenizeunigramCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_unigram_cursor_min(s : NlptokenizeunigramCursor) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_unigram_cursor_max(s : NlptokenizeunigramCursor) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_unigram_cursor_to_string(s : NlptokenizeunigramCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizeunigramView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_unigram_view_make(size : Int) -> NlptokenizeunigramView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_unigram_view_len(s : NlptokenizeunigramView) -> Int { s.size }

pub fn nlp_tokenize_unigram_view_get(s : NlptokenizeunigramView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_unigram_view_set(s : NlptokenizeunigramView, i : Int, v : Double) -> NlptokenizeunigramView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_unigram_view_sum(s : NlptokenizeunigramView) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_unigram_view_mean(s : NlptokenizeunigramView) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_unigram_view_scale(s : NlptokenizeunigramView, f : Double) -> NlptokenizeunigramView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_unigram_view_add(a : NlptokenizeunigramView, b : NlptokenizeunigramView) -> NlptokenizeunigramView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_tokenize_unigram_view_copy(s : NlptokenizeunigramView) -> NlptokenizeunigramView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_unigram_view_fill(s : NlptokenizeunigramView, v : Double) -> NlptokenizeunigramView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_unigram_view_min(s : NlptokenizeunigramView) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_unigram_view_max(s : NlptokenizeunigramView) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_unigram_view_to_string(s : NlptokenizeunigramView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizeunigramRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_unigram_range_make(size : Int) -> NlptokenizeunigramRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_unigram_range_len(s : NlptokenizeunigramRange) -> Int { s.size }

pub fn nlp_tokenize_unigram_range_get(s : NlptokenizeunigramRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_unigram_range_set(s : NlptokenizeunigramRange, i : Int, v : Double) -> NlptokenizeunigramRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_unigram_range_sum(s : NlptokenizeunigramRange) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_unigram_range_mean(s : NlptokenizeunigramRange) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_unigram_range_scale(s : NlptokenizeunigramRange, f : Double) -> NlptokenizeunigramRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_unigram_range_add(a : NlptokenizeunigramRange, b : NlptokenizeunigramRange) -> NlptokenizeunigramRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_tokenize_unigram_range_copy(s : NlptokenizeunigramRange) -> NlptokenizeunigramRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_unigram_range_fill(s : NlptokenizeunigramRange, v : Double) -> NlptokenizeunigramRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_unigram_range_min(s : NlptokenizeunigramRange) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_unigram_range_max(s : NlptokenizeunigramRange) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_unigram_range_to_string(s : NlptokenizeunigramRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizeunigramSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_unigram_slice_make(size : Int) -> NlptokenizeunigramSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_unigram_slice_len(s : NlptokenizeunigramSlice) -> Int { s.size }

pub fn nlp_tokenize_unigram_slice_get(s : NlptokenizeunigramSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_unigram_slice_set(s : NlptokenizeunigramSlice, i : Int, v : Double) -> NlptokenizeunigramSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_unigram_slice_sum(s : NlptokenizeunigramSlice) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_unigram_slice_mean(s : NlptokenizeunigramSlice) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_unigram_slice_scale(s : NlptokenizeunigramSlice, f : Double) -> NlptokenizeunigramSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_unigram_slice_add(a : NlptokenizeunigramSlice, b : NlptokenizeunigramSlice) -> NlptokenizeunigramSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_tokenize_unigram_slice_copy(s : NlptokenizeunigramSlice) -> NlptokenizeunigramSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_unigram_slice_fill(s : NlptokenizeunigramSlice, v : Double) -> NlptokenizeunigramSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_unigram_slice_min(s : NlptokenizeunigramSlice) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_unigram_slice_max(s : NlptokenizeunigramSlice) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_unigram_slice_to_string(s : NlptokenizeunigramSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

