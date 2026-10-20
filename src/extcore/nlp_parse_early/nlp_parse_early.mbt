///===
/// extcore/nlp_parse_early

pub(all) struct NlpparseearlyPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn nlp_parse_early_make_point(x : Double, y : Double) -> NlpparseearlyPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn nlp_parse_early_make_point3(x : Double, y : Double, z : Double) -> NlpparseearlyPoint {
  { x, y, z, label: 0 }
}

pub fn nlp_parse_early_point_x(pt : NlpparseearlyPoint) -> Double { pt.x }

pub fn nlp_parse_early_point_y(pt : NlpparseearlyPoint) -> Double { pt.y }

pub fn nlp_parse_early_point_z(pt : NlpparseearlyPoint) -> Double { pt.z }

pub fn nlp_parse_early_point_label(pt : NlpparseearlyPoint) -> Int { pt.label }

pub fn nlp_parse_early_point_dist(a : NlpparseearlyPoint, b : NlpparseearlyPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn nlp_parse_early_point_add(a : NlpparseearlyPoint, b : NlpparseearlyPoint) -> NlpparseearlyPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn nlp_parse_early_point_sub(a : NlpparseearlyPoint, b : NlpparseearlyPoint) -> NlpparseearlyPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn nlp_parse_early_point_scale(pt : NlpparseearlyPoint, s : Double) -> NlpparseearlyPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn nlp_parse_early_point_dot(a : NlpparseearlyPoint, b : NlpparseearlyPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn nlp_parse_early_point_cross(a : NlpparseearlyPoint, b : NlpparseearlyPoint) -> NlpparseearlyPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn nlp_parse_early_point_norm(pt : NlpparseearlyPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn nlp_parse_early_point_normalize(pt : NlpparseearlyPoint) -> NlpparseearlyPoint {
  let n = nlp_parse_early_point_norm(pt)
  if n < 0.0000001 { pt } else { nlp_parse_early_point_scale(pt, 1.0 / n) }
}

pub fn nlp_parse_early_point_negate(pt : NlpparseearlyPoint) -> NlpparseearlyPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn nlp_parse_early_point_mid(a : NlpparseearlyPoint, b : NlpparseearlyPoint) -> NlpparseearlyPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn nlp_parse_early_point_lerp(a : NlpparseearlyPoint, b : NlpparseearlyPoint, t : Double) -> NlpparseearlyPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn nlp_parse_early_point_to_string(pt : NlpparseearlyPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct NlpparseearlySeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn nlp_parse_early_make_series(vals : Array[Double], name : String) -> NlpparseearlySeries {
  { vals, name, meta: 0 }
}

pub fn nlp_parse_early_series_len(s : NlpparseearlySeries) -> Int { s.vals.length() }

pub fn nlp_parse_early_series_sum(s : NlpparseearlySeries) -> Double { @_common.sum(s.vals) }

pub fn nlp_parse_early_series_mean(s : NlpparseearlySeries) -> Double { @_common.mean(s.vals) }

pub fn nlp_parse_early_series_min(s : NlpparseearlySeries) -> Double { @_common.min(s.vals) }

pub fn nlp_parse_early_series_max(s : NlpparseearlySeries) -> Double { @_common.max(s.vals) }

pub fn nlp_parse_early_series_range(s : NlpparseearlySeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn nlp_parse_early_series_var(s : NlpparseearlySeries) -> Double { @_common.variance(s.vals) }

pub fn nlp_parse_early_series_std(s : NlpparseearlySeries) -> Double { @_common.std(s.vals) }

pub fn nlp_parse_early_series_median(s : NlpparseearlySeries) -> Double { @_common.median(s.vals) }

pub fn nlp_parse_early_series_scale(s : NlpparseearlySeries, f : Double) -> NlpparseearlySeries {
  { vals: @_common.scale_arr(s.vals, f), name: s.name, meta: s.meta }
}

pub fn nlp_parse_early_series_add(a : NlpparseearlySeries, b : NlpparseearlySeries) -> NlpparseearlySeries {
  { vals: @_common.add_arr(a.vals, b.vals), name: a.name + "+" + b.name, meta: a.meta }
}

pub fn nlp_parse_early_series_sub(a : NlpparseearlySeries, b : NlpparseearlySeries) -> NlpparseearlySeries {
  { vals: @_common.sub_arr(a.vals, b.vals), name: a.name + "-" + b.name, meta: a.meta }
}

pub fn nlp_parse_early_series_normalize(s : NlpparseearlySeries) -> NlpparseearlySeries {
  let mn = nlp_parse_early_series_min(s)
  let mx = nlp_parse_early_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn nlp_parse_early_series_cumsum(s : NlpparseearlySeries) -> NlpparseearlySeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn nlp_parse_early_series_to_string(s : NlpparseearlySeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NlpparseearlyMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn nlp_parse_early_make_matrix(rows : Int, cols : Int, val : Double) -> NlpparseearlyMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn nlp_parse_early_matrix_identity(n : Int) -> NlpparseearlyMatrix {
  let m = nlp_parse_early_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn nlp_parse_early_matrix_get(m : NlpparseearlyMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn nlp_parse_early_matrix_transpose(m : NlpparseearlyMatrix) -> NlpparseearlyMatrix {
  let result = nlp_parse_early_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn nlp_parse_early_matrix_add(a : NlpparseearlyMatrix, b : NlpparseearlyMatrix) -> NlpparseearlyMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = nlp_parse_early_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn nlp_parse_early_matrix_scale(m : NlpparseearlyMatrix, s : Double) -> NlpparseearlyMatrix {
  let result = nlp_parse_early_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn nlp_parse_early_matrix_multiply(a : NlpparseearlyMatrix, b : NlpparseearlyMatrix) -> NlpparseearlyMatrix {
  if a.cols != b.rows { return nlp_parse_early_make_matrix(a.rows, b.cols, 0.0) }
  let result = nlp_parse_early_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn nlp_parse_early_matrix_trace(m : NlpparseearlyMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn nlp_parse_early_matrix_det(m : NlpparseearlyMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn nlp_parse_early_matrix_norm(m : NlpparseearlyMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn nlp_parse_early_matrix_to_string(m : NlpparseearlyMatrix) -> String {
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

pub(all) struct NlpparseearlyVector {
  comps : Array[Double]
  dim : Int
}

pub fn nlp_parse_early_make_vector(comps : Array[Double]) -> NlpparseearlyVector {
  { comps, dim: comps.length() }
}

pub fn nlp_parse_early_vector_zero(dim : Int) -> NlpparseearlyVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn nlp_parse_early_vector_add(a : NlpparseearlyVector, b : NlpparseearlyVector) -> NlpparseearlyVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.add_arr(a.comps, b.comps), dim: n }
}

pub fn nlp_parse_early_vector_sub(a : NlpparseearlyVector, b : NlpparseearlyVector) -> NlpparseearlyVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.sub_arr(a.comps, b.comps), dim: n }
}

pub fn nlp_parse_early_vector_scale(v : NlpparseearlyVector, s : Double) -> NlpparseearlyVector {
  { comps: @_common.scale_arr(v.comps, s), dim: v.dim }
}

pub fn nlp_parse_early_vector_dot(a : NlpparseearlyVector, b : NlpparseearlyVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn nlp_parse_early_vector_norm(v : NlpparseearlyVector) -> Double { @_common.sqrt(nlp_parse_early_vector_dot(v, v)) }

pub fn nlp_parse_early_vector_normalize(v : NlpparseearlyVector) -> NlpparseearlyVector {
  let n = nlp_parse_early_vector_norm(v)
  if n < 0.0000001 { v } else { nlp_parse_early_vector_scale(v, 1.0 / n) }
}

pub fn nlp_parse_early_vector_dist(a : NlpparseearlyVector, b : NlpparseearlyVector) -> Double {
  nlp_parse_early_vector_norm(nlp_parse_early_vector_sub(a, b))
}

pub fn nlp_parse_early_vector_to_string(v : NlpparseearlyVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn nlp_parse_early_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn nlp_parse_early_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn nlp_parse_early_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn nlp_parse_early_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn nlp_parse_early_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn nlp_parse_early_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn nlp_parse_early_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn nlp_parse_early_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn nlp_parse_early_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn nlp_parse_early_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn nlp_parse_early_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn nlp_parse_early_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn nlp_parse_early_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn nlp_parse_early_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn nlp_parse_early_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn nlp_parse_early_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn nlp_parse_early_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn nlp_parse_early_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn nlp_parse_early_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn nlp_parse_early_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn nlp_parse_early_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn nlp_parse_early_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn nlp_parse_early_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn nlp_parse_early_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn nlp_parse_early_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn nlp_parse_early_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn nlp_parse_early_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn nlp_parse_early_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn nlp_parse_early_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct NlpparseearlyFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_early_frame_make(size : Int) -> NlpparseearlyFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_early_frame_len(s : NlpparseearlyFrame) -> Int { s.size }

pub fn nlp_parse_early_frame_get(s : NlpparseearlyFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_early_frame_set(s : NlpparseearlyFrame, i : Int, v : Double) -> NlpparseearlyFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_parse_early_frame_sum(s : NlpparseearlyFrame) -> Double { @_common.sum(s.data) }

pub fn nlp_parse_early_frame_mean(s : NlpparseearlyFrame) -> Double { @_common.mean(s.data) }

pub fn nlp_parse_early_frame_scale(s : NlpparseearlyFrame, f : Double) -> NlpparseearlyFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_parse_early_frame_add(a : NlpparseearlyFrame, b : NlpparseearlyFrame) -> NlpparseearlyFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_parse_early_frame_copy(s : NlpparseearlyFrame) -> NlpparseearlyFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_parse_early_frame_fill(s : NlpparseearlyFrame, v : Double) -> NlpparseearlyFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_parse_early_frame_min(s : NlpparseearlyFrame) -> Double { @_common.min(s.data) }

pub fn nlp_parse_early_frame_max(s : NlpparseearlyFrame) -> Double { @_common.max(s.data) }

pub fn nlp_parse_early_frame_to_string(s : NlpparseearlyFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparseearlyTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_early_table_make(size : Int) -> NlpparseearlyTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_early_table_len(s : NlpparseearlyTable) -> Int { s.size }

pub fn nlp_parse_early_table_get(s : NlpparseearlyTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_early_table_set(s : NlpparseearlyTable, i : Int, v : Double) -> NlpparseearlyTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_parse_early_table_sum(s : NlpparseearlyTable) -> Double { @_common.sum(s.data) }

pub fn nlp_parse_early_table_mean(s : NlpparseearlyTable) -> Double { @_common.mean(s.data) }

pub fn nlp_parse_early_table_scale(s : NlpparseearlyTable, f : Double) -> NlpparseearlyTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_parse_early_table_add(a : NlpparseearlyTable, b : NlpparseearlyTable) -> NlpparseearlyTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_parse_early_table_copy(s : NlpparseearlyTable) -> NlpparseearlyTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_parse_early_table_fill(s : NlpparseearlyTable, v : Double) -> NlpparseearlyTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_parse_early_table_min(s : NlpparseearlyTable) -> Double { @_common.min(s.data) }

pub fn nlp_parse_early_table_max(s : NlpparseearlyTable) -> Double { @_common.max(s.data) }

pub fn nlp_parse_early_table_to_string(s : NlpparseearlyTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparseearlyGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_early_graphn_make(size : Int) -> NlpparseearlyGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_early_graphn_len(s : NlpparseearlyGraphN) -> Int { s.size }

pub fn nlp_parse_early_graphn_get(s : NlpparseearlyGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_early_graphn_set(s : NlpparseearlyGraphN, i : Int, v : Double) -> NlpparseearlyGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_parse_early_graphn_sum(s : NlpparseearlyGraphN) -> Double { @_common.sum(s.data) }

pub fn nlp_parse_early_graphn_mean(s : NlpparseearlyGraphN) -> Double { @_common.mean(s.data) }

pub fn nlp_parse_early_graphn_scale(s : NlpparseearlyGraphN, f : Double) -> NlpparseearlyGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_parse_early_graphn_add(a : NlpparseearlyGraphN, b : NlpparseearlyGraphN) -> NlpparseearlyGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_parse_early_graphn_copy(s : NlpparseearlyGraphN) -> NlpparseearlyGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_parse_early_graphn_fill(s : NlpparseearlyGraphN, v : Double) -> NlpparseearlyGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_parse_early_graphn_min(s : NlpparseearlyGraphN) -> Double { @_common.min(s.data) }

pub fn nlp_parse_early_graphn_max(s : NlpparseearlyGraphN) -> Double { @_common.max(s.data) }

pub fn nlp_parse_early_graphn_to_string(s : NlpparseearlyGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparseearlyNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_early_node_make(size : Int) -> NlpparseearlyNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_early_node_len(s : NlpparseearlyNode) -> Int { s.size }

pub fn nlp_parse_early_node_get(s : NlpparseearlyNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_early_node_set(s : NlpparseearlyNode, i : Int, v : Double) -> NlpparseearlyNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_parse_early_node_sum(s : NlpparseearlyNode) -> Double { @_common.sum(s.data) }

pub fn nlp_parse_early_node_mean(s : NlpparseearlyNode) -> Double { @_common.mean(s.data) }

pub fn nlp_parse_early_node_scale(s : NlpparseearlyNode, f : Double) -> NlpparseearlyNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_parse_early_node_add(a : NlpparseearlyNode, b : NlpparseearlyNode) -> NlpparseearlyNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_parse_early_node_copy(s : NlpparseearlyNode) -> NlpparseearlyNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_parse_early_node_fill(s : NlpparseearlyNode, v : Double) -> NlpparseearlyNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_parse_early_node_min(s : NlpparseearlyNode) -> Double { @_common.min(s.data) }

pub fn nlp_parse_early_node_max(s : NlpparseearlyNode) -> Double { @_common.max(s.data) }

pub fn nlp_parse_early_node_to_string(s : NlpparseearlyNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparseearlyEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_early_edge_make(size : Int) -> NlpparseearlyEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_early_edge_len(s : NlpparseearlyEdge) -> Int { s.size }

pub fn nlp_parse_early_edge_get(s : NlpparseearlyEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_early_edge_set(s : NlpparseearlyEdge, i : Int, v : Double) -> NlpparseearlyEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_parse_early_edge_sum(s : NlpparseearlyEdge) -> Double { @_common.sum(s.data) }

pub fn nlp_parse_early_edge_mean(s : NlpparseearlyEdge) -> Double { @_common.mean(s.data) }

pub fn nlp_parse_early_edge_scale(s : NlpparseearlyEdge, f : Double) -> NlpparseearlyEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_parse_early_edge_add(a : NlpparseearlyEdge, b : NlpparseearlyEdge) -> NlpparseearlyEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_parse_early_edge_copy(s : NlpparseearlyEdge) -> NlpparseearlyEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_parse_early_edge_fill(s : NlpparseearlyEdge, v : Double) -> NlpparseearlyEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_parse_early_edge_min(s : NlpparseearlyEdge) -> Double { @_common.min(s.data) }

pub fn nlp_parse_early_edge_max(s : NlpparseearlyEdge) -> Double { @_common.max(s.data) }

pub fn nlp_parse_early_edge_to_string(s : NlpparseearlyEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparseearlyPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_early_path_make(size : Int) -> NlpparseearlyPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_early_path_len(s : NlpparseearlyPath) -> Int { s.size }

pub fn nlp_parse_early_path_get(s : NlpparseearlyPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_early_path_set(s : NlpparseearlyPath, i : Int, v : Double) -> NlpparseearlyPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_parse_early_path_sum(s : NlpparseearlyPath) -> Double { @_common.sum(s.data) }

pub fn nlp_parse_early_path_mean(s : NlpparseearlyPath) -> Double { @_common.mean(s.data) }

pub fn nlp_parse_early_path_scale(s : NlpparseearlyPath, f : Double) -> NlpparseearlyPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_parse_early_path_add(a : NlpparseearlyPath, b : NlpparseearlyPath) -> NlpparseearlyPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_parse_early_path_copy(s : NlpparseearlyPath) -> NlpparseearlyPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_parse_early_path_fill(s : NlpparseearlyPath, v : Double) -> NlpparseearlyPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_parse_early_path_min(s : NlpparseearlyPath) -> Double { @_common.min(s.data) }

pub fn nlp_parse_early_path_max(s : NlpparseearlyPath) -> Double { @_common.max(s.data) }

pub fn nlp_parse_early_path_to_string(s : NlpparseearlyPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparseearlyCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_early_cluster_make(size : Int) -> NlpparseearlyCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_early_cluster_len(s : NlpparseearlyCluster) -> Int { s.size }

pub fn nlp_parse_early_cluster_get(s : NlpparseearlyCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_early_cluster_set(s : NlpparseearlyCluster, i : Int, v : Double) -> NlpparseearlyCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_parse_early_cluster_sum(s : NlpparseearlyCluster) -> Double { @_common.sum(s.data) }

pub fn nlp_parse_early_cluster_mean(s : NlpparseearlyCluster) -> Double { @_common.mean(s.data) }

pub fn nlp_parse_early_cluster_scale(s : NlpparseearlyCluster, f : Double) -> NlpparseearlyCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_parse_early_cluster_add(a : NlpparseearlyCluster, b : NlpparseearlyCluster) -> NlpparseearlyCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_parse_early_cluster_copy(s : NlpparseearlyCluster) -> NlpparseearlyCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_parse_early_cluster_fill(s : NlpparseearlyCluster, v : Double) -> NlpparseearlyCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_parse_early_cluster_min(s : NlpparseearlyCluster) -> Double { @_common.min(s.data) }

pub fn nlp_parse_early_cluster_max(s : NlpparseearlyCluster) -> Double { @_common.max(s.data) }

pub fn nlp_parse_early_cluster_to_string(s : NlpparseearlyCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparseearlyModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_early_model_make(size : Int) -> NlpparseearlyModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_early_model_len(s : NlpparseearlyModel) -> Int { s.size }

pub fn nlp_parse_early_model_get(s : NlpparseearlyModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_early_model_set(s : NlpparseearlyModel, i : Int, v : Double) -> NlpparseearlyModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_parse_early_model_sum(s : NlpparseearlyModel) -> Double { @_common.sum(s.data) }

pub fn nlp_parse_early_model_mean(s : NlpparseearlyModel) -> Double { @_common.mean(s.data) }

pub fn nlp_parse_early_model_scale(s : NlpparseearlyModel, f : Double) -> NlpparseearlyModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_parse_early_model_add(a : NlpparseearlyModel, b : NlpparseearlyModel) -> NlpparseearlyModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_parse_early_model_copy(s : NlpparseearlyModel) -> NlpparseearlyModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_parse_early_model_fill(s : NlpparseearlyModel, v : Double) -> NlpparseearlyModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_parse_early_model_min(s : NlpparseearlyModel) -> Double { @_common.min(s.data) }

pub fn nlp_parse_early_model_max(s : NlpparseearlyModel) -> Double { @_common.max(s.data) }

pub fn nlp_parse_early_model_to_string(s : NlpparseearlyModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparseearlyLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_early_layer_make(size : Int) -> NlpparseearlyLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_early_layer_len(s : NlpparseearlyLayer) -> Int { s.size }

pub fn nlp_parse_early_layer_get(s : NlpparseearlyLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_early_layer_set(s : NlpparseearlyLayer, i : Int, v : Double) -> NlpparseearlyLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_parse_early_layer_sum(s : NlpparseearlyLayer) -> Double { @_common.sum(s.data) }

pub fn nlp_parse_early_layer_mean(s : NlpparseearlyLayer) -> Double { @_common.mean(s.data) }

pub fn nlp_parse_early_layer_scale(s : NlpparseearlyLayer, f : Double) -> NlpparseearlyLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_parse_early_layer_add(a : NlpparseearlyLayer, b : NlpparseearlyLayer) -> NlpparseearlyLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_parse_early_layer_copy(s : NlpparseearlyLayer) -> NlpparseearlyLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_parse_early_layer_fill(s : NlpparseearlyLayer, v : Double) -> NlpparseearlyLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_parse_early_layer_min(s : NlpparseearlyLayer) -> Double { @_common.min(s.data) }

pub fn nlp_parse_early_layer_max(s : NlpparseearlyLayer) -> Double { @_common.max(s.data) }

pub fn nlp_parse_early_layer_to_string(s : NlpparseearlyLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparseearlyBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_early_buffer_make(size : Int) -> NlpparseearlyBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_early_buffer_len(s : NlpparseearlyBuffer) -> Int { s.size }

pub fn nlp_parse_early_buffer_get(s : NlpparseearlyBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_early_buffer_set(s : NlpparseearlyBuffer, i : Int, v : Double) -> NlpparseearlyBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_parse_early_buffer_sum(s : NlpparseearlyBuffer) -> Double { @_common.sum(s.data) }

pub fn nlp_parse_early_buffer_mean(s : NlpparseearlyBuffer) -> Double { @_common.mean(s.data) }

pub fn nlp_parse_early_buffer_scale(s : NlpparseearlyBuffer, f : Double) -> NlpparseearlyBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_parse_early_buffer_add(a : NlpparseearlyBuffer, b : NlpparseearlyBuffer) -> NlpparseearlyBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_parse_early_buffer_copy(s : NlpparseearlyBuffer) -> NlpparseearlyBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_parse_early_buffer_fill(s : NlpparseearlyBuffer, v : Double) -> NlpparseearlyBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_parse_early_buffer_min(s : NlpparseearlyBuffer) -> Double { @_common.min(s.data) }

pub fn nlp_parse_early_buffer_max(s : NlpparseearlyBuffer) -> Double { @_common.max(s.data) }

pub fn nlp_parse_early_buffer_to_string(s : NlpparseearlyBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparseearlyCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_early_cursor_make(size : Int) -> NlpparseearlyCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_early_cursor_len(s : NlpparseearlyCursor) -> Int { s.size }

pub fn nlp_parse_early_cursor_get(s : NlpparseearlyCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_early_cursor_set(s : NlpparseearlyCursor, i : Int, v : Double) -> NlpparseearlyCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_parse_early_cursor_sum(s : NlpparseearlyCursor) -> Double { @_common.sum(s.data) }

pub fn nlp_parse_early_cursor_mean(s : NlpparseearlyCursor) -> Double { @_common.mean(s.data) }

pub fn nlp_parse_early_cursor_scale(s : NlpparseearlyCursor, f : Double) -> NlpparseearlyCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_parse_early_cursor_add(a : NlpparseearlyCursor, b : NlpparseearlyCursor) -> NlpparseearlyCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_parse_early_cursor_copy(s : NlpparseearlyCursor) -> NlpparseearlyCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_parse_early_cursor_fill(s : NlpparseearlyCursor, v : Double) -> NlpparseearlyCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_parse_early_cursor_min(s : NlpparseearlyCursor) -> Double { @_common.min(s.data) }

pub fn nlp_parse_early_cursor_max(s : NlpparseearlyCursor) -> Double { @_common.max(s.data) }

pub fn nlp_parse_early_cursor_to_string(s : NlpparseearlyCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparseearlyView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_early_view_make(size : Int) -> NlpparseearlyView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_early_view_len(s : NlpparseearlyView) -> Int { s.size }

pub fn nlp_parse_early_view_get(s : NlpparseearlyView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_early_view_set(s : NlpparseearlyView, i : Int, v : Double) -> NlpparseearlyView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_parse_early_view_sum(s : NlpparseearlyView) -> Double { @_common.sum(s.data) }

pub fn nlp_parse_early_view_mean(s : NlpparseearlyView) -> Double { @_common.mean(s.data) }

pub fn nlp_parse_early_view_scale(s : NlpparseearlyView, f : Double) -> NlpparseearlyView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_parse_early_view_add(a : NlpparseearlyView, b : NlpparseearlyView) -> NlpparseearlyView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_parse_early_view_copy(s : NlpparseearlyView) -> NlpparseearlyView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_parse_early_view_fill(s : NlpparseearlyView, v : Double) -> NlpparseearlyView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_parse_early_view_min(s : NlpparseearlyView) -> Double { @_common.min(s.data) }

pub fn nlp_parse_early_view_max(s : NlpparseearlyView) -> Double { @_common.max(s.data) }

pub fn nlp_parse_early_view_to_string(s : NlpparseearlyView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparseearlyRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_early_range_make(size : Int) -> NlpparseearlyRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_early_range_len(s : NlpparseearlyRange) -> Int { s.size }

pub fn nlp_parse_early_range_get(s : NlpparseearlyRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_early_range_set(s : NlpparseearlyRange, i : Int, v : Double) -> NlpparseearlyRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_parse_early_range_sum(s : NlpparseearlyRange) -> Double { @_common.sum(s.data) }

pub fn nlp_parse_early_range_mean(s : NlpparseearlyRange) -> Double { @_common.mean(s.data) }

pub fn nlp_parse_early_range_scale(s : NlpparseearlyRange, f : Double) -> NlpparseearlyRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_parse_early_range_add(a : NlpparseearlyRange, b : NlpparseearlyRange) -> NlpparseearlyRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_parse_early_range_copy(s : NlpparseearlyRange) -> NlpparseearlyRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_parse_early_range_fill(s : NlpparseearlyRange, v : Double) -> NlpparseearlyRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_parse_early_range_min(s : NlpparseearlyRange) -> Double { @_common.min(s.data) }

pub fn nlp_parse_early_range_max(s : NlpparseearlyRange) -> Double { @_common.max(s.data) }

pub fn nlp_parse_early_range_to_string(s : NlpparseearlyRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparseearlySlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_early_slice_make(size : Int) -> NlpparseearlySlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_early_slice_len(s : NlpparseearlySlice) -> Int { s.size }

pub fn nlp_parse_early_slice_get(s : NlpparseearlySlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_early_slice_set(s : NlpparseearlySlice, i : Int, v : Double) -> NlpparseearlySlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_parse_early_slice_sum(s : NlpparseearlySlice) -> Double { @_common.sum(s.data) }

pub fn nlp_parse_early_slice_mean(s : NlpparseearlySlice) -> Double { @_common.mean(s.data) }

pub fn nlp_parse_early_slice_scale(s : NlpparseearlySlice, f : Double) -> NlpparseearlySlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_parse_early_slice_add(a : NlpparseearlySlice, b : NlpparseearlySlice) -> NlpparseearlySlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_parse_early_slice_copy(s : NlpparseearlySlice) -> NlpparseearlySlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_parse_early_slice_fill(s : NlpparseearlySlice, v : Double) -> NlpparseearlySlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_parse_early_slice_min(s : NlpparseearlySlice) -> Double { @_common.min(s.data) }

pub fn nlp_parse_early_slice_max(s : NlpparseearlySlice) -> Double { @_common.max(s.data) }

pub fn nlp_parse_early_slice_to_string(s : NlpparseearlySlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

