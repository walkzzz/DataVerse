///===
/// extcore/nlp_tokenize_wordpiece

pub(all) struct NlptokenizewordpiecePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn nlp_tokenize_wordpiece_make_point(x : Double, y : Double) -> NlptokenizewordpiecePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn nlp_tokenize_wordpiece_make_point3(x : Double, y : Double, z : Double) -> NlptokenizewordpiecePoint {
  { x, y, z, label: 0 }
}

pub fn nlp_tokenize_wordpiece_point_x(pt : NlptokenizewordpiecePoint) -> Double { pt.x }

pub fn nlp_tokenize_wordpiece_point_y(pt : NlptokenizewordpiecePoint) -> Double { pt.y }

pub fn nlp_tokenize_wordpiece_point_z(pt : NlptokenizewordpiecePoint) -> Double { pt.z }

pub fn nlp_tokenize_wordpiece_point_label(pt : NlptokenizewordpiecePoint) -> Int { pt.label }

pub fn nlp_tokenize_wordpiece_point_dist(a : NlptokenizewordpiecePoint, b : NlptokenizewordpiecePoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn nlp_tokenize_wordpiece_point_add(a : NlptokenizewordpiecePoint, b : NlptokenizewordpiecePoint) -> NlptokenizewordpiecePoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn nlp_tokenize_wordpiece_point_sub(a : NlptokenizewordpiecePoint, b : NlptokenizewordpiecePoint) -> NlptokenizewordpiecePoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn nlp_tokenize_wordpiece_point_scale(pt : NlptokenizewordpiecePoint, s : Double) -> NlptokenizewordpiecePoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn nlp_tokenize_wordpiece_point_dot(a : NlptokenizewordpiecePoint, b : NlptokenizewordpiecePoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn nlp_tokenize_wordpiece_point_cross(a : NlptokenizewordpiecePoint, b : NlptokenizewordpiecePoint) -> NlptokenizewordpiecePoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn nlp_tokenize_wordpiece_point_norm(pt : NlptokenizewordpiecePoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn nlp_tokenize_wordpiece_point_normalize(pt : NlptokenizewordpiecePoint) -> NlptokenizewordpiecePoint {
  let n = nlp_tokenize_wordpiece_point_norm(pt)
  if n < 0.0000001 { pt } else { nlp_tokenize_wordpiece_point_scale(pt, 1.0 / n) }
}

pub fn nlp_tokenize_wordpiece_point_negate(pt : NlptokenizewordpiecePoint) -> NlptokenizewordpiecePoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn nlp_tokenize_wordpiece_point_mid(a : NlptokenizewordpiecePoint, b : NlptokenizewordpiecePoint) -> NlptokenizewordpiecePoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn nlp_tokenize_wordpiece_point_lerp(a : NlptokenizewordpiecePoint, b : NlptokenizewordpiecePoint, t : Double) -> NlptokenizewordpiecePoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn nlp_tokenize_wordpiece_point_to_string(pt : NlptokenizewordpiecePoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct NlptokenizewordpieceSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn nlp_tokenize_wordpiece_make_series(vals : Array[Double], name : String) -> NlptokenizewordpieceSeries {
  { vals, name, meta: 0 }
}

pub fn nlp_tokenize_wordpiece_series_len(s : NlptokenizewordpieceSeries) -> Int { s.vals.length() }

pub fn nlp_tokenize_wordpiece_series_sum(s : NlptokenizewordpieceSeries) -> Double { @_common.sum(s.vals) }

pub fn nlp_tokenize_wordpiece_series_mean(s : NlptokenizewordpieceSeries) -> Double { @_common.mean(s.vals) }

pub fn nlp_tokenize_wordpiece_series_min(s : NlptokenizewordpieceSeries) -> Double { @_common.min(s.vals) }

pub fn nlp_tokenize_wordpiece_series_max(s : NlptokenizewordpieceSeries) -> Double { @_common.max(s.vals) }

pub fn nlp_tokenize_wordpiece_series_range(s : NlptokenizewordpieceSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn nlp_tokenize_wordpiece_series_var(s : NlptokenizewordpieceSeries) -> Double { @_common.variance(s.vals) }

pub fn nlp_tokenize_wordpiece_series_std(s : NlptokenizewordpieceSeries) -> Double { @_common.std(s.vals) }

pub fn nlp_tokenize_wordpiece_series_median(s : NlptokenizewordpieceSeries) -> Double { @_common.median(s.vals) }

pub fn nlp_tokenize_wordpiece_series_scale(s : NlptokenizewordpieceSeries, f : Double) -> NlptokenizewordpieceSeries {
  { vals: @_common.scale_arr(s.vals, f), name: s.name, meta: s.meta }
}

pub fn nlp_tokenize_wordpiece_series_add(a : NlptokenizewordpieceSeries, b : NlptokenizewordpieceSeries) -> NlptokenizewordpieceSeries {
  { vals: @_common.add_arr(a.vals, b.vals), name: a.name + "+" + b.name, meta: a.meta }
}

pub fn nlp_tokenize_wordpiece_series_sub(a : NlptokenizewordpieceSeries, b : NlptokenizewordpieceSeries) -> NlptokenizewordpieceSeries {
  { vals: @_common.sub_arr(a.vals, b.vals), name: a.name + "-" + b.name, meta: a.meta }
}

pub fn nlp_tokenize_wordpiece_series_normalize(s : NlptokenizewordpieceSeries) -> NlptokenizewordpieceSeries {
  let mn = nlp_tokenize_wordpiece_series_min(s)
  let mx = nlp_tokenize_wordpiece_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn nlp_tokenize_wordpiece_series_cumsum(s : NlptokenizewordpieceSeries) -> NlptokenizewordpieceSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn nlp_tokenize_wordpiece_series_to_string(s : NlptokenizewordpieceSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NlptokenizewordpieceMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn nlp_tokenize_wordpiece_make_matrix(rows : Int, cols : Int, val : Double) -> NlptokenizewordpieceMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn nlp_tokenize_wordpiece_matrix_identity(n : Int) -> NlptokenizewordpieceMatrix {
  let m = nlp_tokenize_wordpiece_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn nlp_tokenize_wordpiece_matrix_get(m : NlptokenizewordpieceMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn nlp_tokenize_wordpiece_matrix_transpose(m : NlptokenizewordpieceMatrix) -> NlptokenizewordpieceMatrix {
  let result = nlp_tokenize_wordpiece_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn nlp_tokenize_wordpiece_matrix_add(a : NlptokenizewordpieceMatrix, b : NlptokenizewordpieceMatrix) -> NlptokenizewordpieceMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = nlp_tokenize_wordpiece_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn nlp_tokenize_wordpiece_matrix_scale(m : NlptokenizewordpieceMatrix, s : Double) -> NlptokenizewordpieceMatrix {
  let result = nlp_tokenize_wordpiece_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn nlp_tokenize_wordpiece_matrix_multiply(a : NlptokenizewordpieceMatrix, b : NlptokenizewordpieceMatrix) -> NlptokenizewordpieceMatrix {
  if a.cols != b.rows { return nlp_tokenize_wordpiece_make_matrix(a.rows, b.cols, 0.0) }
  let result = nlp_tokenize_wordpiece_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn nlp_tokenize_wordpiece_matrix_trace(m : NlptokenizewordpieceMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn nlp_tokenize_wordpiece_matrix_det(m : NlptokenizewordpieceMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn nlp_tokenize_wordpiece_matrix_norm(m : NlptokenizewordpieceMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn nlp_tokenize_wordpiece_matrix_to_string(m : NlptokenizewordpieceMatrix) -> String {
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

pub(all) struct NlptokenizewordpieceVector {
  comps : Array[Double]
  dim : Int
}

pub fn nlp_tokenize_wordpiece_make_vector(comps : Array[Double]) -> NlptokenizewordpieceVector {
  { comps, dim: comps.length() }
}

pub fn nlp_tokenize_wordpiece_vector_zero(dim : Int) -> NlptokenizewordpieceVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn nlp_tokenize_wordpiece_vector_add(a : NlptokenizewordpieceVector, b : NlptokenizewordpieceVector) -> NlptokenizewordpieceVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.add_arr(a.comps, b.comps), dim: n }
}

pub fn nlp_tokenize_wordpiece_vector_sub(a : NlptokenizewordpieceVector, b : NlptokenizewordpieceVector) -> NlptokenizewordpieceVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.sub_arr(a.comps, b.comps), dim: n }
}

pub fn nlp_tokenize_wordpiece_vector_scale(v : NlptokenizewordpieceVector, s : Double) -> NlptokenizewordpieceVector {
  { comps: @_common.scale_arr(v.comps, s), dim: v.dim }
}

pub fn nlp_tokenize_wordpiece_vector_dot(a : NlptokenizewordpieceVector, b : NlptokenizewordpieceVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn nlp_tokenize_wordpiece_vector_norm(v : NlptokenizewordpieceVector) -> Double { @_common.sqrt(nlp_tokenize_wordpiece_vector_dot(v, v)) }

pub fn nlp_tokenize_wordpiece_vector_normalize(v : NlptokenizewordpieceVector) -> NlptokenizewordpieceVector {
  let n = nlp_tokenize_wordpiece_vector_norm(v)
  if n < 0.0000001 { v } else { nlp_tokenize_wordpiece_vector_scale(v, 1.0 / n) }
}

pub fn nlp_tokenize_wordpiece_vector_dist(a : NlptokenizewordpieceVector, b : NlptokenizewordpieceVector) -> Double {
  nlp_tokenize_wordpiece_vector_norm(nlp_tokenize_wordpiece_vector_sub(a, b))
}

pub fn nlp_tokenize_wordpiece_vector_to_string(v : NlptokenizewordpieceVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn nlp_tokenize_wordpiece_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn nlp_tokenize_wordpiece_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn nlp_tokenize_wordpiece_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn nlp_tokenize_wordpiece_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn nlp_tokenize_wordpiece_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn nlp_tokenize_wordpiece_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn nlp_tokenize_wordpiece_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn nlp_tokenize_wordpiece_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn nlp_tokenize_wordpiece_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn nlp_tokenize_wordpiece_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn nlp_tokenize_wordpiece_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn nlp_tokenize_wordpiece_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn nlp_tokenize_wordpiece_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn nlp_tokenize_wordpiece_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn nlp_tokenize_wordpiece_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn nlp_tokenize_wordpiece_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn nlp_tokenize_wordpiece_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn nlp_tokenize_wordpiece_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn nlp_tokenize_wordpiece_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn nlp_tokenize_wordpiece_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn nlp_tokenize_wordpiece_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn nlp_tokenize_wordpiece_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn nlp_tokenize_wordpiece_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn nlp_tokenize_wordpiece_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn nlp_tokenize_wordpiece_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn nlp_tokenize_wordpiece_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn nlp_tokenize_wordpiece_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn nlp_tokenize_wordpiece_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn nlp_tokenize_wordpiece_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct NlptokenizewordpieceFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_wordpiece_frame_make(size : Int) -> NlptokenizewordpieceFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_wordpiece_frame_len(s : NlptokenizewordpieceFrame) -> Int { s.size }

pub fn nlp_tokenize_wordpiece_frame_get(s : NlptokenizewordpieceFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_wordpiece_frame_set(s : NlptokenizewordpieceFrame, i : Int, v : Double) -> NlptokenizewordpieceFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_wordpiece_frame_sum(s : NlptokenizewordpieceFrame) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_wordpiece_frame_mean(s : NlptokenizewordpieceFrame) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_wordpiece_frame_scale(s : NlptokenizewordpieceFrame, f : Double) -> NlptokenizewordpieceFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_wordpiece_frame_add(a : NlptokenizewordpieceFrame, b : NlptokenizewordpieceFrame) -> NlptokenizewordpieceFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_tokenize_wordpiece_frame_copy(s : NlptokenizewordpieceFrame) -> NlptokenizewordpieceFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_wordpiece_frame_fill(s : NlptokenizewordpieceFrame, v : Double) -> NlptokenizewordpieceFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_wordpiece_frame_min(s : NlptokenizewordpieceFrame) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_wordpiece_frame_max(s : NlptokenizewordpieceFrame) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_wordpiece_frame_to_string(s : NlptokenizewordpieceFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizewordpieceTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_wordpiece_table_make(size : Int) -> NlptokenizewordpieceTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_wordpiece_table_len(s : NlptokenizewordpieceTable) -> Int { s.size }

pub fn nlp_tokenize_wordpiece_table_get(s : NlptokenizewordpieceTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_wordpiece_table_set(s : NlptokenizewordpieceTable, i : Int, v : Double) -> NlptokenizewordpieceTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_wordpiece_table_sum(s : NlptokenizewordpieceTable) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_wordpiece_table_mean(s : NlptokenizewordpieceTable) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_wordpiece_table_scale(s : NlptokenizewordpieceTable, f : Double) -> NlptokenizewordpieceTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_wordpiece_table_add(a : NlptokenizewordpieceTable, b : NlptokenizewordpieceTable) -> NlptokenizewordpieceTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_tokenize_wordpiece_table_copy(s : NlptokenizewordpieceTable) -> NlptokenizewordpieceTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_wordpiece_table_fill(s : NlptokenizewordpieceTable, v : Double) -> NlptokenizewordpieceTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_wordpiece_table_min(s : NlptokenizewordpieceTable) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_wordpiece_table_max(s : NlptokenizewordpieceTable) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_wordpiece_table_to_string(s : NlptokenizewordpieceTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizewordpieceGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_wordpiece_graphn_make(size : Int) -> NlptokenizewordpieceGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_wordpiece_graphn_len(s : NlptokenizewordpieceGraphN) -> Int { s.size }

pub fn nlp_tokenize_wordpiece_graphn_get(s : NlptokenizewordpieceGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_wordpiece_graphn_set(s : NlptokenizewordpieceGraphN, i : Int, v : Double) -> NlptokenizewordpieceGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_wordpiece_graphn_sum(s : NlptokenizewordpieceGraphN) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_wordpiece_graphn_mean(s : NlptokenizewordpieceGraphN) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_wordpiece_graphn_scale(s : NlptokenizewordpieceGraphN, f : Double) -> NlptokenizewordpieceGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_wordpiece_graphn_add(a : NlptokenizewordpieceGraphN, b : NlptokenizewordpieceGraphN) -> NlptokenizewordpieceGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_tokenize_wordpiece_graphn_copy(s : NlptokenizewordpieceGraphN) -> NlptokenizewordpieceGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_wordpiece_graphn_fill(s : NlptokenizewordpieceGraphN, v : Double) -> NlptokenizewordpieceGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_wordpiece_graphn_min(s : NlptokenizewordpieceGraphN) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_wordpiece_graphn_max(s : NlptokenizewordpieceGraphN) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_wordpiece_graphn_to_string(s : NlptokenizewordpieceGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizewordpieceNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_wordpiece_node_make(size : Int) -> NlptokenizewordpieceNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_wordpiece_node_len(s : NlptokenizewordpieceNode) -> Int { s.size }

pub fn nlp_tokenize_wordpiece_node_get(s : NlptokenizewordpieceNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_wordpiece_node_set(s : NlptokenizewordpieceNode, i : Int, v : Double) -> NlptokenizewordpieceNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_wordpiece_node_sum(s : NlptokenizewordpieceNode) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_wordpiece_node_mean(s : NlptokenizewordpieceNode) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_wordpiece_node_scale(s : NlptokenizewordpieceNode, f : Double) -> NlptokenizewordpieceNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_wordpiece_node_add(a : NlptokenizewordpieceNode, b : NlptokenizewordpieceNode) -> NlptokenizewordpieceNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_tokenize_wordpiece_node_copy(s : NlptokenizewordpieceNode) -> NlptokenizewordpieceNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_wordpiece_node_fill(s : NlptokenizewordpieceNode, v : Double) -> NlptokenizewordpieceNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_wordpiece_node_min(s : NlptokenizewordpieceNode) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_wordpiece_node_max(s : NlptokenizewordpieceNode) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_wordpiece_node_to_string(s : NlptokenizewordpieceNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizewordpieceEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_wordpiece_edge_make(size : Int) -> NlptokenizewordpieceEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_wordpiece_edge_len(s : NlptokenizewordpieceEdge) -> Int { s.size }

pub fn nlp_tokenize_wordpiece_edge_get(s : NlptokenizewordpieceEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_wordpiece_edge_set(s : NlptokenizewordpieceEdge, i : Int, v : Double) -> NlptokenizewordpieceEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_wordpiece_edge_sum(s : NlptokenizewordpieceEdge) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_wordpiece_edge_mean(s : NlptokenizewordpieceEdge) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_wordpiece_edge_scale(s : NlptokenizewordpieceEdge, f : Double) -> NlptokenizewordpieceEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_wordpiece_edge_add(a : NlptokenizewordpieceEdge, b : NlptokenizewordpieceEdge) -> NlptokenizewordpieceEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_tokenize_wordpiece_edge_copy(s : NlptokenizewordpieceEdge) -> NlptokenizewordpieceEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_wordpiece_edge_fill(s : NlptokenizewordpieceEdge, v : Double) -> NlptokenizewordpieceEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_wordpiece_edge_min(s : NlptokenizewordpieceEdge) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_wordpiece_edge_max(s : NlptokenizewordpieceEdge) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_wordpiece_edge_to_string(s : NlptokenizewordpieceEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizewordpiecePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_wordpiece_path_make(size : Int) -> NlptokenizewordpiecePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_wordpiece_path_len(s : NlptokenizewordpiecePath) -> Int { s.size }

pub fn nlp_tokenize_wordpiece_path_get(s : NlptokenizewordpiecePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_wordpiece_path_set(s : NlptokenizewordpiecePath, i : Int, v : Double) -> NlptokenizewordpiecePath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_wordpiece_path_sum(s : NlptokenizewordpiecePath) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_wordpiece_path_mean(s : NlptokenizewordpiecePath) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_wordpiece_path_scale(s : NlptokenizewordpiecePath, f : Double) -> NlptokenizewordpiecePath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_wordpiece_path_add(a : NlptokenizewordpiecePath, b : NlptokenizewordpiecePath) -> NlptokenizewordpiecePath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_tokenize_wordpiece_path_copy(s : NlptokenizewordpiecePath) -> NlptokenizewordpiecePath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_wordpiece_path_fill(s : NlptokenizewordpiecePath, v : Double) -> NlptokenizewordpiecePath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_wordpiece_path_min(s : NlptokenizewordpiecePath) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_wordpiece_path_max(s : NlptokenizewordpiecePath) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_wordpiece_path_to_string(s : NlptokenizewordpiecePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizewordpieceCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_wordpiece_cluster_make(size : Int) -> NlptokenizewordpieceCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_wordpiece_cluster_len(s : NlptokenizewordpieceCluster) -> Int { s.size }

pub fn nlp_tokenize_wordpiece_cluster_get(s : NlptokenizewordpieceCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_wordpiece_cluster_set(s : NlptokenizewordpieceCluster, i : Int, v : Double) -> NlptokenizewordpieceCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_wordpiece_cluster_sum(s : NlptokenizewordpieceCluster) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_wordpiece_cluster_mean(s : NlptokenizewordpieceCluster) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_wordpiece_cluster_scale(s : NlptokenizewordpieceCluster, f : Double) -> NlptokenizewordpieceCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_wordpiece_cluster_add(a : NlptokenizewordpieceCluster, b : NlptokenizewordpieceCluster) -> NlptokenizewordpieceCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_tokenize_wordpiece_cluster_copy(s : NlptokenizewordpieceCluster) -> NlptokenizewordpieceCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_wordpiece_cluster_fill(s : NlptokenizewordpieceCluster, v : Double) -> NlptokenizewordpieceCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_wordpiece_cluster_min(s : NlptokenizewordpieceCluster) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_wordpiece_cluster_max(s : NlptokenizewordpieceCluster) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_wordpiece_cluster_to_string(s : NlptokenizewordpieceCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizewordpieceModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_wordpiece_model_make(size : Int) -> NlptokenizewordpieceModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_wordpiece_model_len(s : NlptokenizewordpieceModel) -> Int { s.size }

pub fn nlp_tokenize_wordpiece_model_get(s : NlptokenizewordpieceModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_wordpiece_model_set(s : NlptokenizewordpieceModel, i : Int, v : Double) -> NlptokenizewordpieceModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_wordpiece_model_sum(s : NlptokenizewordpieceModel) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_wordpiece_model_mean(s : NlptokenizewordpieceModel) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_wordpiece_model_scale(s : NlptokenizewordpieceModel, f : Double) -> NlptokenizewordpieceModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_wordpiece_model_add(a : NlptokenizewordpieceModel, b : NlptokenizewordpieceModel) -> NlptokenizewordpieceModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_tokenize_wordpiece_model_copy(s : NlptokenizewordpieceModel) -> NlptokenizewordpieceModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_wordpiece_model_fill(s : NlptokenizewordpieceModel, v : Double) -> NlptokenizewordpieceModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_wordpiece_model_min(s : NlptokenizewordpieceModel) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_wordpiece_model_max(s : NlptokenizewordpieceModel) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_wordpiece_model_to_string(s : NlptokenizewordpieceModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizewordpieceLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_wordpiece_layer_make(size : Int) -> NlptokenizewordpieceLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_wordpiece_layer_len(s : NlptokenizewordpieceLayer) -> Int { s.size }

pub fn nlp_tokenize_wordpiece_layer_get(s : NlptokenizewordpieceLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_wordpiece_layer_set(s : NlptokenizewordpieceLayer, i : Int, v : Double) -> NlptokenizewordpieceLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_wordpiece_layer_sum(s : NlptokenizewordpieceLayer) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_wordpiece_layer_mean(s : NlptokenizewordpieceLayer) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_wordpiece_layer_scale(s : NlptokenizewordpieceLayer, f : Double) -> NlptokenizewordpieceLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_wordpiece_layer_add(a : NlptokenizewordpieceLayer, b : NlptokenizewordpieceLayer) -> NlptokenizewordpieceLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_tokenize_wordpiece_layer_copy(s : NlptokenizewordpieceLayer) -> NlptokenizewordpieceLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_wordpiece_layer_fill(s : NlptokenizewordpieceLayer, v : Double) -> NlptokenizewordpieceLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_wordpiece_layer_min(s : NlptokenizewordpieceLayer) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_wordpiece_layer_max(s : NlptokenizewordpieceLayer) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_wordpiece_layer_to_string(s : NlptokenizewordpieceLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizewordpieceBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_wordpiece_buffer_make(size : Int) -> NlptokenizewordpieceBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_wordpiece_buffer_len(s : NlptokenizewordpieceBuffer) -> Int { s.size }

pub fn nlp_tokenize_wordpiece_buffer_get(s : NlptokenizewordpieceBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_wordpiece_buffer_set(s : NlptokenizewordpieceBuffer, i : Int, v : Double) -> NlptokenizewordpieceBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_wordpiece_buffer_sum(s : NlptokenizewordpieceBuffer) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_wordpiece_buffer_mean(s : NlptokenizewordpieceBuffer) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_wordpiece_buffer_scale(s : NlptokenizewordpieceBuffer, f : Double) -> NlptokenizewordpieceBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_wordpiece_buffer_add(a : NlptokenizewordpieceBuffer, b : NlptokenizewordpieceBuffer) -> NlptokenizewordpieceBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_tokenize_wordpiece_buffer_copy(s : NlptokenizewordpieceBuffer) -> NlptokenizewordpieceBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_wordpiece_buffer_fill(s : NlptokenizewordpieceBuffer, v : Double) -> NlptokenizewordpieceBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_wordpiece_buffer_min(s : NlptokenizewordpieceBuffer) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_wordpiece_buffer_max(s : NlptokenizewordpieceBuffer) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_wordpiece_buffer_to_string(s : NlptokenizewordpieceBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizewordpieceCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_wordpiece_cursor_make(size : Int) -> NlptokenizewordpieceCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_wordpiece_cursor_len(s : NlptokenizewordpieceCursor) -> Int { s.size }

pub fn nlp_tokenize_wordpiece_cursor_get(s : NlptokenizewordpieceCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_wordpiece_cursor_set(s : NlptokenizewordpieceCursor, i : Int, v : Double) -> NlptokenizewordpieceCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_wordpiece_cursor_sum(s : NlptokenizewordpieceCursor) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_wordpiece_cursor_mean(s : NlptokenizewordpieceCursor) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_wordpiece_cursor_scale(s : NlptokenizewordpieceCursor, f : Double) -> NlptokenizewordpieceCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_wordpiece_cursor_add(a : NlptokenizewordpieceCursor, b : NlptokenizewordpieceCursor) -> NlptokenizewordpieceCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_tokenize_wordpiece_cursor_copy(s : NlptokenizewordpieceCursor) -> NlptokenizewordpieceCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_wordpiece_cursor_fill(s : NlptokenizewordpieceCursor, v : Double) -> NlptokenizewordpieceCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_wordpiece_cursor_min(s : NlptokenizewordpieceCursor) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_wordpiece_cursor_max(s : NlptokenizewordpieceCursor) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_wordpiece_cursor_to_string(s : NlptokenizewordpieceCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizewordpieceView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_wordpiece_view_make(size : Int) -> NlptokenizewordpieceView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_wordpiece_view_len(s : NlptokenizewordpieceView) -> Int { s.size }

pub fn nlp_tokenize_wordpiece_view_get(s : NlptokenizewordpieceView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_wordpiece_view_set(s : NlptokenizewordpieceView, i : Int, v : Double) -> NlptokenizewordpieceView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_wordpiece_view_sum(s : NlptokenizewordpieceView) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_wordpiece_view_mean(s : NlptokenizewordpieceView) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_wordpiece_view_scale(s : NlptokenizewordpieceView, f : Double) -> NlptokenizewordpieceView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_wordpiece_view_add(a : NlptokenizewordpieceView, b : NlptokenizewordpieceView) -> NlptokenizewordpieceView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_tokenize_wordpiece_view_copy(s : NlptokenizewordpieceView) -> NlptokenizewordpieceView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_wordpiece_view_fill(s : NlptokenizewordpieceView, v : Double) -> NlptokenizewordpieceView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_wordpiece_view_min(s : NlptokenizewordpieceView) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_wordpiece_view_max(s : NlptokenizewordpieceView) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_wordpiece_view_to_string(s : NlptokenizewordpieceView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizewordpieceRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_wordpiece_range_make(size : Int) -> NlptokenizewordpieceRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_wordpiece_range_len(s : NlptokenizewordpieceRange) -> Int { s.size }

pub fn nlp_tokenize_wordpiece_range_get(s : NlptokenizewordpieceRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_wordpiece_range_set(s : NlptokenizewordpieceRange, i : Int, v : Double) -> NlptokenizewordpieceRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_wordpiece_range_sum(s : NlptokenizewordpieceRange) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_wordpiece_range_mean(s : NlptokenizewordpieceRange) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_wordpiece_range_scale(s : NlptokenizewordpieceRange, f : Double) -> NlptokenizewordpieceRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_wordpiece_range_add(a : NlptokenizewordpieceRange, b : NlptokenizewordpieceRange) -> NlptokenizewordpieceRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_tokenize_wordpiece_range_copy(s : NlptokenizewordpieceRange) -> NlptokenizewordpieceRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_wordpiece_range_fill(s : NlptokenizewordpieceRange, v : Double) -> NlptokenizewordpieceRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_wordpiece_range_min(s : NlptokenizewordpieceRange) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_wordpiece_range_max(s : NlptokenizewordpieceRange) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_wordpiece_range_to_string(s : NlptokenizewordpieceRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizewordpieceSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_wordpiece_slice_make(size : Int) -> NlptokenizewordpieceSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_wordpiece_slice_len(s : NlptokenizewordpieceSlice) -> Int { s.size }

pub fn nlp_tokenize_wordpiece_slice_get(s : NlptokenizewordpieceSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_wordpiece_slice_set(s : NlptokenizewordpieceSlice, i : Int, v : Double) -> NlptokenizewordpieceSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_wordpiece_slice_sum(s : NlptokenizewordpieceSlice) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_wordpiece_slice_mean(s : NlptokenizewordpieceSlice) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_wordpiece_slice_scale(s : NlptokenizewordpieceSlice, f : Double) -> NlptokenizewordpieceSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_wordpiece_slice_add(a : NlptokenizewordpieceSlice, b : NlptokenizewordpieceSlice) -> NlptokenizewordpieceSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_tokenize_wordpiece_slice_copy(s : NlptokenizewordpieceSlice) -> NlptokenizewordpieceSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_wordpiece_slice_fill(s : NlptokenizewordpieceSlice, v : Double) -> NlptokenizewordpieceSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_wordpiece_slice_min(s : NlptokenizewordpieceSlice) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_wordpiece_slice_max(s : NlptokenizewordpieceSlice) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_wordpiece_slice_to_string(s : NlptokenizewordpieceSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

