///===
/// extcore/nlp_tokenize_subword

pub(all) struct NlptokenizesubwordPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn nlp_tokenize_subword_make_point(x : Double, y : Double) -> NlptokenizesubwordPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn nlp_tokenize_subword_make_point3(x : Double, y : Double, z : Double) -> NlptokenizesubwordPoint {
  { x, y, z, label: 0 }
}

pub fn nlp_tokenize_subword_point_x(pt : NlptokenizesubwordPoint) -> Double { pt.x }

pub fn nlp_tokenize_subword_point_y(pt : NlptokenizesubwordPoint) -> Double { pt.y }

pub fn nlp_tokenize_subword_point_z(pt : NlptokenizesubwordPoint) -> Double { pt.z }

pub fn nlp_tokenize_subword_point_label(pt : NlptokenizesubwordPoint) -> Int { pt.label }

pub fn nlp_tokenize_subword_point_dist(a : NlptokenizesubwordPoint, b : NlptokenizesubwordPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn nlp_tokenize_subword_point_add(a : NlptokenizesubwordPoint, b : NlptokenizesubwordPoint) -> NlptokenizesubwordPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn nlp_tokenize_subword_point_sub(a : NlptokenizesubwordPoint, b : NlptokenizesubwordPoint) -> NlptokenizesubwordPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn nlp_tokenize_subword_point_scale(pt : NlptokenizesubwordPoint, s : Double) -> NlptokenizesubwordPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn nlp_tokenize_subword_point_dot(a : NlptokenizesubwordPoint, b : NlptokenizesubwordPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn nlp_tokenize_subword_point_cross(a : NlptokenizesubwordPoint, b : NlptokenizesubwordPoint) -> NlptokenizesubwordPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn nlp_tokenize_subword_point_norm(pt : NlptokenizesubwordPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn nlp_tokenize_subword_point_normalize(pt : NlptokenizesubwordPoint) -> NlptokenizesubwordPoint {
  let n = nlp_tokenize_subword_point_norm(pt)
  if n < 0.0000001 { pt } else { nlp_tokenize_subword_point_scale(pt, 1.0 / n) }
}

pub fn nlp_tokenize_subword_point_negate(pt : NlptokenizesubwordPoint) -> NlptokenizesubwordPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn nlp_tokenize_subword_point_mid(a : NlptokenizesubwordPoint, b : NlptokenizesubwordPoint) -> NlptokenizesubwordPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn nlp_tokenize_subword_point_lerp(a : NlptokenizesubwordPoint, b : NlptokenizesubwordPoint, t : Double) -> NlptokenizesubwordPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn nlp_tokenize_subword_point_to_string(pt : NlptokenizesubwordPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct NlptokenizesubwordSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn nlp_tokenize_subword_make_series(vals : Array[Double], name : String) -> NlptokenizesubwordSeries {
  { vals, name, meta: 0 }
}

pub fn nlp_tokenize_subword_series_len(s : NlptokenizesubwordSeries) -> Int { s.vals.length() }

pub fn nlp_tokenize_subword_series_sum(s : NlptokenizesubwordSeries) -> Double { @_common.sum(s.vals) }

pub fn nlp_tokenize_subword_series_mean(s : NlptokenizesubwordSeries) -> Double { @_common.mean(s.vals) }

pub fn nlp_tokenize_subword_series_min(s : NlptokenizesubwordSeries) -> Double { @_common.min(s.vals) }

pub fn nlp_tokenize_subword_series_max(s : NlptokenizesubwordSeries) -> Double { @_common.max(s.vals) }

pub fn nlp_tokenize_subword_series_range(s : NlptokenizesubwordSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn nlp_tokenize_subword_series_var(s : NlptokenizesubwordSeries) -> Double { @_common.variance(s.vals) }

pub fn nlp_tokenize_subword_series_std(s : NlptokenizesubwordSeries) -> Double { @_common.std(s.vals) }

pub fn nlp_tokenize_subword_series_median(s : NlptokenizesubwordSeries) -> Double { @_common.median(s.vals) }

pub fn nlp_tokenize_subword_series_scale(s : NlptokenizesubwordSeries, f : Double) -> NlptokenizesubwordSeries {
  { vals: @_common.scale_arr(s.vals, f), name: s.name, meta: s.meta }
}

pub fn nlp_tokenize_subword_series_add(a : NlptokenizesubwordSeries, b : NlptokenizesubwordSeries) -> NlptokenizesubwordSeries {
  { vals: @_common.add_arr(a.vals, b.vals), name: a.name + "+" + b.name, meta: a.meta }
}

pub fn nlp_tokenize_subword_series_sub(a : NlptokenizesubwordSeries, b : NlptokenizesubwordSeries) -> NlptokenizesubwordSeries {
  { vals: @_common.sub_arr(a.vals, b.vals), name: a.name + "-" + b.name, meta: a.meta }
}

pub fn nlp_tokenize_subword_series_normalize(s : NlptokenizesubwordSeries) -> NlptokenizesubwordSeries {
  let mn = nlp_tokenize_subword_series_min(s)
  let mx = nlp_tokenize_subword_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn nlp_tokenize_subword_series_cumsum(s : NlptokenizesubwordSeries) -> NlptokenizesubwordSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn nlp_tokenize_subword_series_to_string(s : NlptokenizesubwordSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NlptokenizesubwordMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn nlp_tokenize_subword_make_matrix(rows : Int, cols : Int, val : Double) -> NlptokenizesubwordMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn nlp_tokenize_subword_matrix_identity(n : Int) -> NlptokenizesubwordMatrix {
  let m = nlp_tokenize_subword_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn nlp_tokenize_subword_matrix_get(m : NlptokenizesubwordMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn nlp_tokenize_subword_matrix_transpose(m : NlptokenizesubwordMatrix) -> NlptokenizesubwordMatrix {
  let result = nlp_tokenize_subword_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn nlp_tokenize_subword_matrix_add(a : NlptokenizesubwordMatrix, b : NlptokenizesubwordMatrix) -> NlptokenizesubwordMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = nlp_tokenize_subword_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn nlp_tokenize_subword_matrix_scale(m : NlptokenizesubwordMatrix, s : Double) -> NlptokenizesubwordMatrix {
  let result = nlp_tokenize_subword_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn nlp_tokenize_subword_matrix_multiply(a : NlptokenizesubwordMatrix, b : NlptokenizesubwordMatrix) -> NlptokenizesubwordMatrix {
  if a.cols != b.rows { return nlp_tokenize_subword_make_matrix(a.rows, b.cols, 0.0) }
  let result = nlp_tokenize_subword_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn nlp_tokenize_subword_matrix_trace(m : NlptokenizesubwordMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn nlp_tokenize_subword_matrix_det(m : NlptokenizesubwordMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn nlp_tokenize_subword_matrix_norm(m : NlptokenizesubwordMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn nlp_tokenize_subword_matrix_to_string(m : NlptokenizesubwordMatrix) -> String {
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

pub(all) struct NlptokenizesubwordVector {
  comps : Array[Double]
  dim : Int
}

pub fn nlp_tokenize_subword_make_vector(comps : Array[Double]) -> NlptokenizesubwordVector {
  { comps, dim: comps.length() }
}

pub fn nlp_tokenize_subword_vector_zero(dim : Int) -> NlptokenizesubwordVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn nlp_tokenize_subword_vector_add(a : NlptokenizesubwordVector, b : NlptokenizesubwordVector) -> NlptokenizesubwordVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.add_arr(a.comps, b.comps), dim: n }
}

pub fn nlp_tokenize_subword_vector_sub(a : NlptokenizesubwordVector, b : NlptokenizesubwordVector) -> NlptokenizesubwordVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.sub_arr(a.comps, b.comps), dim: n }
}

pub fn nlp_tokenize_subword_vector_scale(v : NlptokenizesubwordVector, s : Double) -> NlptokenizesubwordVector {
  { comps: @_common.scale_arr(v.comps, s), dim: v.dim }
}

pub fn nlp_tokenize_subword_vector_dot(a : NlptokenizesubwordVector, b : NlptokenizesubwordVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn nlp_tokenize_subword_vector_norm(v : NlptokenizesubwordVector) -> Double { @_common.sqrt(nlp_tokenize_subword_vector_dot(v, v)) }

pub fn nlp_tokenize_subword_vector_normalize(v : NlptokenizesubwordVector) -> NlptokenizesubwordVector {
  let n = nlp_tokenize_subword_vector_norm(v)
  if n < 0.0000001 { v } else { nlp_tokenize_subword_vector_scale(v, 1.0 / n) }
}

pub fn nlp_tokenize_subword_vector_dist(a : NlptokenizesubwordVector, b : NlptokenizesubwordVector) -> Double {
  nlp_tokenize_subword_vector_norm(nlp_tokenize_subword_vector_sub(a, b))
}

pub fn nlp_tokenize_subword_vector_to_string(v : NlptokenizesubwordVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn nlp_tokenize_subword_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn nlp_tokenize_subword_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn nlp_tokenize_subword_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn nlp_tokenize_subword_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn nlp_tokenize_subword_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn nlp_tokenize_subword_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn nlp_tokenize_subword_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn nlp_tokenize_subword_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn nlp_tokenize_subword_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn nlp_tokenize_subword_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn nlp_tokenize_subword_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn nlp_tokenize_subword_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn nlp_tokenize_subword_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn nlp_tokenize_subword_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn nlp_tokenize_subword_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn nlp_tokenize_subword_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn nlp_tokenize_subword_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn nlp_tokenize_subword_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn nlp_tokenize_subword_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn nlp_tokenize_subword_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn nlp_tokenize_subword_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn nlp_tokenize_subword_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn nlp_tokenize_subword_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn nlp_tokenize_subword_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn nlp_tokenize_subword_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn nlp_tokenize_subword_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn nlp_tokenize_subword_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn nlp_tokenize_subword_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn nlp_tokenize_subword_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct NlptokenizesubwordFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_subword_frame_make(size : Int) -> NlptokenizesubwordFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_subword_frame_len(s : NlptokenizesubwordFrame) -> Int { s.size }

pub fn nlp_tokenize_subword_frame_get(s : NlptokenizesubwordFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_subword_frame_set(s : NlptokenizesubwordFrame, i : Int, v : Double) -> NlptokenizesubwordFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_subword_frame_sum(s : NlptokenizesubwordFrame) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_subword_frame_mean(s : NlptokenizesubwordFrame) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_subword_frame_scale(s : NlptokenizesubwordFrame, f : Double) -> NlptokenizesubwordFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_subword_frame_add(a : NlptokenizesubwordFrame, b : NlptokenizesubwordFrame) -> NlptokenizesubwordFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_tokenize_subword_frame_copy(s : NlptokenizesubwordFrame) -> NlptokenizesubwordFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_subword_frame_fill(s : NlptokenizesubwordFrame, v : Double) -> NlptokenizesubwordFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_subword_frame_min(s : NlptokenizesubwordFrame) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_subword_frame_max(s : NlptokenizesubwordFrame) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_subword_frame_to_string(s : NlptokenizesubwordFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizesubwordTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_subword_table_make(size : Int) -> NlptokenizesubwordTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_subword_table_len(s : NlptokenizesubwordTable) -> Int { s.size }

pub fn nlp_tokenize_subword_table_get(s : NlptokenizesubwordTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_subword_table_set(s : NlptokenizesubwordTable, i : Int, v : Double) -> NlptokenizesubwordTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_subword_table_sum(s : NlptokenizesubwordTable) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_subword_table_mean(s : NlptokenizesubwordTable) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_subword_table_scale(s : NlptokenizesubwordTable, f : Double) -> NlptokenizesubwordTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_subword_table_add(a : NlptokenizesubwordTable, b : NlptokenizesubwordTable) -> NlptokenizesubwordTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_tokenize_subword_table_copy(s : NlptokenizesubwordTable) -> NlptokenizesubwordTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_subword_table_fill(s : NlptokenizesubwordTable, v : Double) -> NlptokenizesubwordTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_subword_table_min(s : NlptokenizesubwordTable) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_subword_table_max(s : NlptokenizesubwordTable) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_subword_table_to_string(s : NlptokenizesubwordTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizesubwordGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_subword_graphn_make(size : Int) -> NlptokenizesubwordGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_subword_graphn_len(s : NlptokenizesubwordGraphN) -> Int { s.size }

pub fn nlp_tokenize_subword_graphn_get(s : NlptokenizesubwordGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_subword_graphn_set(s : NlptokenizesubwordGraphN, i : Int, v : Double) -> NlptokenizesubwordGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_subword_graphn_sum(s : NlptokenizesubwordGraphN) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_subword_graphn_mean(s : NlptokenizesubwordGraphN) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_subword_graphn_scale(s : NlptokenizesubwordGraphN, f : Double) -> NlptokenizesubwordGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_subword_graphn_add(a : NlptokenizesubwordGraphN, b : NlptokenizesubwordGraphN) -> NlptokenizesubwordGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_tokenize_subword_graphn_copy(s : NlptokenizesubwordGraphN) -> NlptokenizesubwordGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_subword_graphn_fill(s : NlptokenizesubwordGraphN, v : Double) -> NlptokenizesubwordGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_subword_graphn_min(s : NlptokenizesubwordGraphN) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_subword_graphn_max(s : NlptokenizesubwordGraphN) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_subword_graphn_to_string(s : NlptokenizesubwordGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizesubwordNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_subword_node_make(size : Int) -> NlptokenizesubwordNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_subword_node_len(s : NlptokenizesubwordNode) -> Int { s.size }

pub fn nlp_tokenize_subword_node_get(s : NlptokenizesubwordNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_subword_node_set(s : NlptokenizesubwordNode, i : Int, v : Double) -> NlptokenizesubwordNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_subword_node_sum(s : NlptokenizesubwordNode) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_subword_node_mean(s : NlptokenizesubwordNode) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_subword_node_scale(s : NlptokenizesubwordNode, f : Double) -> NlptokenizesubwordNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_subword_node_add(a : NlptokenizesubwordNode, b : NlptokenizesubwordNode) -> NlptokenizesubwordNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_tokenize_subword_node_copy(s : NlptokenizesubwordNode) -> NlptokenizesubwordNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_subword_node_fill(s : NlptokenizesubwordNode, v : Double) -> NlptokenizesubwordNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_subword_node_min(s : NlptokenizesubwordNode) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_subword_node_max(s : NlptokenizesubwordNode) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_subword_node_to_string(s : NlptokenizesubwordNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizesubwordEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_subword_edge_make(size : Int) -> NlptokenizesubwordEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_subword_edge_len(s : NlptokenizesubwordEdge) -> Int { s.size }

pub fn nlp_tokenize_subword_edge_get(s : NlptokenizesubwordEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_subword_edge_set(s : NlptokenizesubwordEdge, i : Int, v : Double) -> NlptokenizesubwordEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_subword_edge_sum(s : NlptokenizesubwordEdge) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_subword_edge_mean(s : NlptokenizesubwordEdge) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_subword_edge_scale(s : NlptokenizesubwordEdge, f : Double) -> NlptokenizesubwordEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_subword_edge_add(a : NlptokenizesubwordEdge, b : NlptokenizesubwordEdge) -> NlptokenizesubwordEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_tokenize_subword_edge_copy(s : NlptokenizesubwordEdge) -> NlptokenizesubwordEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_subword_edge_fill(s : NlptokenizesubwordEdge, v : Double) -> NlptokenizesubwordEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_subword_edge_min(s : NlptokenizesubwordEdge) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_subword_edge_max(s : NlptokenizesubwordEdge) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_subword_edge_to_string(s : NlptokenizesubwordEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizesubwordPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_subword_path_make(size : Int) -> NlptokenizesubwordPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_subword_path_len(s : NlptokenizesubwordPath) -> Int { s.size }

pub fn nlp_tokenize_subword_path_get(s : NlptokenizesubwordPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_subword_path_set(s : NlptokenizesubwordPath, i : Int, v : Double) -> NlptokenizesubwordPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_subword_path_sum(s : NlptokenizesubwordPath) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_subword_path_mean(s : NlptokenizesubwordPath) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_subword_path_scale(s : NlptokenizesubwordPath, f : Double) -> NlptokenizesubwordPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_subword_path_add(a : NlptokenizesubwordPath, b : NlptokenizesubwordPath) -> NlptokenizesubwordPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_tokenize_subword_path_copy(s : NlptokenizesubwordPath) -> NlptokenizesubwordPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_subword_path_fill(s : NlptokenizesubwordPath, v : Double) -> NlptokenizesubwordPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_subword_path_min(s : NlptokenizesubwordPath) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_subword_path_max(s : NlptokenizesubwordPath) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_subword_path_to_string(s : NlptokenizesubwordPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizesubwordCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_subword_cluster_make(size : Int) -> NlptokenizesubwordCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_subword_cluster_len(s : NlptokenizesubwordCluster) -> Int { s.size }

pub fn nlp_tokenize_subword_cluster_get(s : NlptokenizesubwordCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_subword_cluster_set(s : NlptokenizesubwordCluster, i : Int, v : Double) -> NlptokenizesubwordCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_subword_cluster_sum(s : NlptokenizesubwordCluster) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_subword_cluster_mean(s : NlptokenizesubwordCluster) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_subword_cluster_scale(s : NlptokenizesubwordCluster, f : Double) -> NlptokenizesubwordCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_subword_cluster_add(a : NlptokenizesubwordCluster, b : NlptokenizesubwordCluster) -> NlptokenizesubwordCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_tokenize_subword_cluster_copy(s : NlptokenizesubwordCluster) -> NlptokenizesubwordCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_subword_cluster_fill(s : NlptokenizesubwordCluster, v : Double) -> NlptokenizesubwordCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_subword_cluster_min(s : NlptokenizesubwordCluster) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_subword_cluster_max(s : NlptokenizesubwordCluster) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_subword_cluster_to_string(s : NlptokenizesubwordCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizesubwordModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_subword_model_make(size : Int) -> NlptokenizesubwordModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_subword_model_len(s : NlptokenizesubwordModel) -> Int { s.size }

pub fn nlp_tokenize_subword_model_get(s : NlptokenizesubwordModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_subword_model_set(s : NlptokenizesubwordModel, i : Int, v : Double) -> NlptokenizesubwordModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_subword_model_sum(s : NlptokenizesubwordModel) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_subword_model_mean(s : NlptokenizesubwordModel) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_subword_model_scale(s : NlptokenizesubwordModel, f : Double) -> NlptokenizesubwordModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_subword_model_add(a : NlptokenizesubwordModel, b : NlptokenizesubwordModel) -> NlptokenizesubwordModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_tokenize_subword_model_copy(s : NlptokenizesubwordModel) -> NlptokenizesubwordModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_subword_model_fill(s : NlptokenizesubwordModel, v : Double) -> NlptokenizesubwordModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_subword_model_min(s : NlptokenizesubwordModel) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_subword_model_max(s : NlptokenizesubwordModel) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_subword_model_to_string(s : NlptokenizesubwordModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizesubwordLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_subword_layer_make(size : Int) -> NlptokenizesubwordLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_subword_layer_len(s : NlptokenizesubwordLayer) -> Int { s.size }

pub fn nlp_tokenize_subword_layer_get(s : NlptokenizesubwordLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_subword_layer_set(s : NlptokenizesubwordLayer, i : Int, v : Double) -> NlptokenizesubwordLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_subword_layer_sum(s : NlptokenizesubwordLayer) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_subword_layer_mean(s : NlptokenizesubwordLayer) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_subword_layer_scale(s : NlptokenizesubwordLayer, f : Double) -> NlptokenizesubwordLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_subword_layer_add(a : NlptokenizesubwordLayer, b : NlptokenizesubwordLayer) -> NlptokenizesubwordLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_tokenize_subword_layer_copy(s : NlptokenizesubwordLayer) -> NlptokenizesubwordLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_subword_layer_fill(s : NlptokenizesubwordLayer, v : Double) -> NlptokenizesubwordLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_subword_layer_min(s : NlptokenizesubwordLayer) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_subword_layer_max(s : NlptokenizesubwordLayer) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_subword_layer_to_string(s : NlptokenizesubwordLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizesubwordBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_subword_buffer_make(size : Int) -> NlptokenizesubwordBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_subword_buffer_len(s : NlptokenizesubwordBuffer) -> Int { s.size }

pub fn nlp_tokenize_subword_buffer_get(s : NlptokenizesubwordBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_subword_buffer_set(s : NlptokenizesubwordBuffer, i : Int, v : Double) -> NlptokenizesubwordBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_subword_buffer_sum(s : NlptokenizesubwordBuffer) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_subword_buffer_mean(s : NlptokenizesubwordBuffer) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_subword_buffer_scale(s : NlptokenizesubwordBuffer, f : Double) -> NlptokenizesubwordBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_subword_buffer_add(a : NlptokenizesubwordBuffer, b : NlptokenizesubwordBuffer) -> NlptokenizesubwordBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_tokenize_subword_buffer_copy(s : NlptokenizesubwordBuffer) -> NlptokenizesubwordBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_subword_buffer_fill(s : NlptokenizesubwordBuffer, v : Double) -> NlptokenizesubwordBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_subword_buffer_min(s : NlptokenizesubwordBuffer) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_subword_buffer_max(s : NlptokenizesubwordBuffer) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_subword_buffer_to_string(s : NlptokenizesubwordBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizesubwordCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_subword_cursor_make(size : Int) -> NlptokenizesubwordCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_subword_cursor_len(s : NlptokenizesubwordCursor) -> Int { s.size }

pub fn nlp_tokenize_subword_cursor_get(s : NlptokenizesubwordCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_subword_cursor_set(s : NlptokenizesubwordCursor, i : Int, v : Double) -> NlptokenizesubwordCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_subword_cursor_sum(s : NlptokenizesubwordCursor) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_subword_cursor_mean(s : NlptokenizesubwordCursor) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_subword_cursor_scale(s : NlptokenizesubwordCursor, f : Double) -> NlptokenizesubwordCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_subword_cursor_add(a : NlptokenizesubwordCursor, b : NlptokenizesubwordCursor) -> NlptokenizesubwordCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_tokenize_subword_cursor_copy(s : NlptokenizesubwordCursor) -> NlptokenizesubwordCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_subword_cursor_fill(s : NlptokenizesubwordCursor, v : Double) -> NlptokenizesubwordCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_subword_cursor_min(s : NlptokenizesubwordCursor) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_subword_cursor_max(s : NlptokenizesubwordCursor) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_subword_cursor_to_string(s : NlptokenizesubwordCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizesubwordView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_subword_view_make(size : Int) -> NlptokenizesubwordView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_subword_view_len(s : NlptokenizesubwordView) -> Int { s.size }

pub fn nlp_tokenize_subword_view_get(s : NlptokenizesubwordView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_subword_view_set(s : NlptokenizesubwordView, i : Int, v : Double) -> NlptokenizesubwordView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_subword_view_sum(s : NlptokenizesubwordView) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_subword_view_mean(s : NlptokenizesubwordView) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_subword_view_scale(s : NlptokenizesubwordView, f : Double) -> NlptokenizesubwordView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_subword_view_add(a : NlptokenizesubwordView, b : NlptokenizesubwordView) -> NlptokenizesubwordView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_tokenize_subword_view_copy(s : NlptokenizesubwordView) -> NlptokenizesubwordView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_subword_view_fill(s : NlptokenizesubwordView, v : Double) -> NlptokenizesubwordView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_subword_view_min(s : NlptokenizesubwordView) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_subword_view_max(s : NlptokenizesubwordView) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_subword_view_to_string(s : NlptokenizesubwordView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizesubwordRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_subword_range_make(size : Int) -> NlptokenizesubwordRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_subword_range_len(s : NlptokenizesubwordRange) -> Int { s.size }

pub fn nlp_tokenize_subword_range_get(s : NlptokenizesubwordRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_subword_range_set(s : NlptokenizesubwordRange, i : Int, v : Double) -> NlptokenizesubwordRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_subword_range_sum(s : NlptokenizesubwordRange) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_subword_range_mean(s : NlptokenizesubwordRange) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_subword_range_scale(s : NlptokenizesubwordRange, f : Double) -> NlptokenizesubwordRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_subword_range_add(a : NlptokenizesubwordRange, b : NlptokenizesubwordRange) -> NlptokenizesubwordRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_tokenize_subword_range_copy(s : NlptokenizesubwordRange) -> NlptokenizesubwordRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_subword_range_fill(s : NlptokenizesubwordRange, v : Double) -> NlptokenizesubwordRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_subword_range_min(s : NlptokenizesubwordRange) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_subword_range_max(s : NlptokenizesubwordRange) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_subword_range_to_string(s : NlptokenizesubwordRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizesubwordSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_subword_slice_make(size : Int) -> NlptokenizesubwordSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_subword_slice_len(s : NlptokenizesubwordSlice) -> Int { s.size }

pub fn nlp_tokenize_subword_slice_get(s : NlptokenizesubwordSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_subword_slice_set(s : NlptokenizesubwordSlice, i : Int, v : Double) -> NlptokenizesubwordSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_subword_slice_sum(s : NlptokenizesubwordSlice) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_subword_slice_mean(s : NlptokenizesubwordSlice) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_subword_slice_scale(s : NlptokenizesubwordSlice, f : Double) -> NlptokenizesubwordSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_subword_slice_add(a : NlptokenizesubwordSlice, b : NlptokenizesubwordSlice) -> NlptokenizesubwordSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_tokenize_subword_slice_copy(s : NlptokenizesubwordSlice) -> NlptokenizesubwordSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_subword_slice_fill(s : NlptokenizesubwordSlice, v : Double) -> NlptokenizesubwordSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_subword_slice_min(s : NlptokenizesubwordSlice) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_subword_slice_max(s : NlptokenizesubwordSlice) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_subword_slice_to_string(s : NlptokenizesubwordSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

