///===
/// extcore/nlp_parse_arc_standard

pub(all) struct NlpparsearcstandardPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn nlp_parse_arc_standard_make_point(x : Double, y : Double) -> NlpparsearcstandardPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn nlp_parse_arc_standard_make_point3(x : Double, y : Double, z : Double) -> NlpparsearcstandardPoint {
  { x, y, z, label: 0 }
}

pub fn nlp_parse_arc_standard_point_x(pt : NlpparsearcstandardPoint) -> Double { pt.x }

pub fn nlp_parse_arc_standard_point_y(pt : NlpparsearcstandardPoint) -> Double { pt.y }

pub fn nlp_parse_arc_standard_point_z(pt : NlpparsearcstandardPoint) -> Double { pt.z }

pub fn nlp_parse_arc_standard_point_label(pt : NlpparsearcstandardPoint) -> Int { pt.label }

pub fn nlp_parse_arc_standard_point_dist(a : NlpparsearcstandardPoint, b : NlpparsearcstandardPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn nlp_parse_arc_standard_point_add(a : NlpparsearcstandardPoint, b : NlpparsearcstandardPoint) -> NlpparsearcstandardPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn nlp_parse_arc_standard_point_sub(a : NlpparsearcstandardPoint, b : NlpparsearcstandardPoint) -> NlpparsearcstandardPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn nlp_parse_arc_standard_point_scale(pt : NlpparsearcstandardPoint, s : Double) -> NlpparsearcstandardPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn nlp_parse_arc_standard_point_dot(a : NlpparsearcstandardPoint, b : NlpparsearcstandardPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn nlp_parse_arc_standard_point_cross(a : NlpparsearcstandardPoint, b : NlpparsearcstandardPoint) -> NlpparsearcstandardPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn nlp_parse_arc_standard_point_norm(pt : NlpparsearcstandardPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn nlp_parse_arc_standard_point_normalize(pt : NlpparsearcstandardPoint) -> NlpparsearcstandardPoint {
  let n = nlp_parse_arc_standard_point_norm(pt)
  if n < 0.0000001 { pt } else { nlp_parse_arc_standard_point_scale(pt, 1.0 / n) }
}

pub fn nlp_parse_arc_standard_point_negate(pt : NlpparsearcstandardPoint) -> NlpparsearcstandardPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn nlp_parse_arc_standard_point_mid(a : NlpparsearcstandardPoint, b : NlpparsearcstandardPoint) -> NlpparsearcstandardPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn nlp_parse_arc_standard_point_lerp(a : NlpparsearcstandardPoint, b : NlpparsearcstandardPoint, t : Double) -> NlpparsearcstandardPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn nlp_parse_arc_standard_point_to_string(pt : NlpparsearcstandardPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct NlpparsearcstandardSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn nlp_parse_arc_standard_make_series(vals : Array[Double], name : String) -> NlpparsearcstandardSeries {
  { vals, name, meta: 0 }
}

pub fn nlp_parse_arc_standard_series_len(s : NlpparsearcstandardSeries) -> Int { s.vals.length() }

pub fn nlp_parse_arc_standard_series_sum(s : NlpparsearcstandardSeries) -> Double { @_common.sum(s.vals) }

pub fn nlp_parse_arc_standard_series_mean(s : NlpparsearcstandardSeries) -> Double { @_common.mean(s.vals) }

pub fn nlp_parse_arc_standard_series_min(s : NlpparsearcstandardSeries) -> Double { @_common.min(s.vals) }

pub fn nlp_parse_arc_standard_series_max(s : NlpparsearcstandardSeries) -> Double { @_common.max(s.vals) }

pub fn nlp_parse_arc_standard_series_range(s : NlpparsearcstandardSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn nlp_parse_arc_standard_series_var(s : NlpparsearcstandardSeries) -> Double { @_common.variance(s.vals) }

pub fn nlp_parse_arc_standard_series_std(s : NlpparsearcstandardSeries) -> Double { @_common.std(s.vals) }

pub fn nlp_parse_arc_standard_series_median(s : NlpparsearcstandardSeries) -> Double { @_common.median(s.vals) }

pub fn nlp_parse_arc_standard_series_scale(s : NlpparsearcstandardSeries, f : Double) -> NlpparsearcstandardSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn nlp_parse_arc_standard_series_add(a : NlpparsearcstandardSeries, b : NlpparsearcstandardSeries) -> NlpparsearcstandardSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn nlp_parse_arc_standard_series_sub(a : NlpparsearcstandardSeries, b : NlpparsearcstandardSeries) -> NlpparsearcstandardSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn nlp_parse_arc_standard_series_normalize(s : NlpparsearcstandardSeries) -> NlpparsearcstandardSeries {
  let mn = nlp_parse_arc_standard_series_min(s)
  let mx = nlp_parse_arc_standard_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn nlp_parse_arc_standard_series_cumsum(s : NlpparsearcstandardSeries) -> NlpparsearcstandardSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn nlp_parse_arc_standard_series_to_string(s : NlpparsearcstandardSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NlpparsearcstandardMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn nlp_parse_arc_standard_make_matrix(rows : Int, cols : Int, val : Double) -> NlpparsearcstandardMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn nlp_parse_arc_standard_matrix_identity(n : Int) -> NlpparsearcstandardMatrix {
  let m = nlp_parse_arc_standard_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn nlp_parse_arc_standard_matrix_get(m : NlpparsearcstandardMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn nlp_parse_arc_standard_matrix_transpose(m : NlpparsearcstandardMatrix) -> NlpparsearcstandardMatrix {
  let result = nlp_parse_arc_standard_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn nlp_parse_arc_standard_matrix_add(a : NlpparsearcstandardMatrix, b : NlpparsearcstandardMatrix) -> NlpparsearcstandardMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = nlp_parse_arc_standard_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn nlp_parse_arc_standard_matrix_scale(m : NlpparsearcstandardMatrix, s : Double) -> NlpparsearcstandardMatrix {
  let result = nlp_parse_arc_standard_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn nlp_parse_arc_standard_matrix_multiply(a : NlpparsearcstandardMatrix, b : NlpparsearcstandardMatrix) -> NlpparsearcstandardMatrix {
  if a.cols != b.rows { return nlp_parse_arc_standard_make_matrix(a.rows, b.cols, 0.0) }
  let result = nlp_parse_arc_standard_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn nlp_parse_arc_standard_matrix_trace(m : NlpparsearcstandardMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn nlp_parse_arc_standard_matrix_det(m : NlpparsearcstandardMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn nlp_parse_arc_standard_matrix_norm(m : NlpparsearcstandardMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn nlp_parse_arc_standard_matrix_to_string(m : NlpparsearcstandardMatrix) -> String {
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

pub(all) struct NlpparsearcstandardVector {
  comps : Array[Double]
  dim : Int
}

pub fn nlp_parse_arc_standard_make_vector(comps : Array[Double]) -> NlpparsearcstandardVector {
  { comps, dim: comps.length() }
}

pub fn nlp_parse_arc_standard_vector_zero(dim : Int) -> NlpparsearcstandardVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn nlp_parse_arc_standard_vector_add(a : NlpparsearcstandardVector, b : NlpparsearcstandardVector) -> NlpparsearcstandardVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn nlp_parse_arc_standard_vector_sub(a : NlpparsearcstandardVector, b : NlpparsearcstandardVector) -> NlpparsearcstandardVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn nlp_parse_arc_standard_vector_scale(v : NlpparsearcstandardVector, s : Double) -> NlpparsearcstandardVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn nlp_parse_arc_standard_vector_dot(a : NlpparsearcstandardVector, b : NlpparsearcstandardVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn nlp_parse_arc_standard_vector_norm(v : NlpparsearcstandardVector) -> Double { @_common.sqrt(nlp_parse_arc_standard_vector_dot(v, v)) }

pub fn nlp_parse_arc_standard_vector_normalize(v : NlpparsearcstandardVector) -> NlpparsearcstandardVector {
  let n = nlp_parse_arc_standard_vector_norm(v)
  if n < 0.0000001 { v } else { nlp_parse_arc_standard_vector_scale(v, 1.0 / n) }
}

pub fn nlp_parse_arc_standard_vector_dist(a : NlpparsearcstandardVector, b : NlpparsearcstandardVector) -> Double {
  nlp_parse_arc_standard_vector_norm(nlp_parse_arc_standard_vector_sub(a, b))
}

pub fn nlp_parse_arc_standard_vector_to_string(v : NlpparsearcstandardVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn nlp_parse_arc_standard_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn nlp_parse_arc_standard_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn nlp_parse_arc_standard_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn nlp_parse_arc_standard_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn nlp_parse_arc_standard_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn nlp_parse_arc_standard_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn nlp_parse_arc_standard_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn nlp_parse_arc_standard_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn nlp_parse_arc_standard_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn nlp_parse_arc_standard_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn nlp_parse_arc_standard_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn nlp_parse_arc_standard_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn nlp_parse_arc_standard_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn nlp_parse_arc_standard_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn nlp_parse_arc_standard_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn nlp_parse_arc_standard_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn nlp_parse_arc_standard_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn nlp_parse_arc_standard_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn nlp_parse_arc_standard_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn nlp_parse_arc_standard_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn nlp_parse_arc_standard_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn nlp_parse_arc_standard_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn nlp_parse_arc_standard_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn nlp_parse_arc_standard_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn nlp_parse_arc_standard_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn nlp_parse_arc_standard_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn nlp_parse_arc_standard_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn nlp_parse_arc_standard_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn nlp_parse_arc_standard_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct NlpparsearcstandardFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_arc_standard_frame_make(size : Int) -> NlpparsearcstandardFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_arc_standard_frame_len(s : NlpparsearcstandardFrame) -> Int { s.size }

pub fn nlp_parse_arc_standard_frame_get(s : NlpparsearcstandardFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_arc_standard_frame_set(s : NlpparsearcstandardFrame, i : Int, v : Double) -> NlpparsearcstandardFrame {
  let result = nlp_parse_arc_standard_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_arc_standard_frame_sum(s : NlpparsearcstandardFrame) -> Double { @_common.sum(s.data) }

pub fn nlp_parse_arc_standard_frame_mean(s : NlpparsearcstandardFrame) -> Double { @_common.mean(s.data) }

pub fn nlp_parse_arc_standard_frame_scale(s : NlpparsearcstandardFrame, f : Double) -> NlpparsearcstandardFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_parse_arc_standard_frame_add(a : NlpparsearcstandardFrame, b : NlpparsearcstandardFrame) -> NlpparsearcstandardFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_parse_arc_standard_frame_copy(s : NlpparsearcstandardFrame) -> NlpparsearcstandardFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_parse_arc_standard_frame_fill(s : NlpparsearcstandardFrame, v : Double) -> NlpparsearcstandardFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_parse_arc_standard_frame_min(s : NlpparsearcstandardFrame) -> Double { @_common.min(s.data) }

pub fn nlp_parse_arc_standard_frame_max(s : NlpparsearcstandardFrame) -> Double { @_common.max(s.data) }

pub fn nlp_parse_arc_standard_frame_to_string(s : NlpparsearcstandardFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparsearcstandardTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_arc_standard_table_make(size : Int) -> NlpparsearcstandardTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_arc_standard_table_len(s : NlpparsearcstandardTable) -> Int { s.size }

pub fn nlp_parse_arc_standard_table_get(s : NlpparsearcstandardTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_arc_standard_table_set(s : NlpparsearcstandardTable, i : Int, v : Double) -> NlpparsearcstandardTable {
  let result = nlp_parse_arc_standard_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_arc_standard_table_sum(s : NlpparsearcstandardTable) -> Double { @_common.sum(s.data) }

pub fn nlp_parse_arc_standard_table_mean(s : NlpparsearcstandardTable) -> Double { @_common.mean(s.data) }

pub fn nlp_parse_arc_standard_table_scale(s : NlpparsearcstandardTable, f : Double) -> NlpparsearcstandardTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_parse_arc_standard_table_add(a : NlpparsearcstandardTable, b : NlpparsearcstandardTable) -> NlpparsearcstandardTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_parse_arc_standard_table_copy(s : NlpparsearcstandardTable) -> NlpparsearcstandardTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_parse_arc_standard_table_fill(s : NlpparsearcstandardTable, v : Double) -> NlpparsearcstandardTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_parse_arc_standard_table_min(s : NlpparsearcstandardTable) -> Double { @_common.min(s.data) }

pub fn nlp_parse_arc_standard_table_max(s : NlpparsearcstandardTable) -> Double { @_common.max(s.data) }

pub fn nlp_parse_arc_standard_table_to_string(s : NlpparsearcstandardTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparsearcstandardGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_arc_standard_graphn_make(size : Int) -> NlpparsearcstandardGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_arc_standard_graphn_len(s : NlpparsearcstandardGraphN) -> Int { s.size }

pub fn nlp_parse_arc_standard_graphn_get(s : NlpparsearcstandardGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_arc_standard_graphn_set(s : NlpparsearcstandardGraphN, i : Int, v : Double) -> NlpparsearcstandardGraphN {
  let result = nlp_parse_arc_standard_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_arc_standard_graphn_sum(s : NlpparsearcstandardGraphN) -> Double { @_common.sum(s.data) }

pub fn nlp_parse_arc_standard_graphn_mean(s : NlpparsearcstandardGraphN) -> Double { @_common.mean(s.data) }

pub fn nlp_parse_arc_standard_graphn_scale(s : NlpparsearcstandardGraphN, f : Double) -> NlpparsearcstandardGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_parse_arc_standard_graphn_add(a : NlpparsearcstandardGraphN, b : NlpparsearcstandardGraphN) -> NlpparsearcstandardGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_parse_arc_standard_graphn_copy(s : NlpparsearcstandardGraphN) -> NlpparsearcstandardGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_parse_arc_standard_graphn_fill(s : NlpparsearcstandardGraphN, v : Double) -> NlpparsearcstandardGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_parse_arc_standard_graphn_min(s : NlpparsearcstandardGraphN) -> Double { @_common.min(s.data) }

pub fn nlp_parse_arc_standard_graphn_max(s : NlpparsearcstandardGraphN) -> Double { @_common.max(s.data) }

pub fn nlp_parse_arc_standard_graphn_to_string(s : NlpparsearcstandardGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparsearcstandardNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_arc_standard_node_make(size : Int) -> NlpparsearcstandardNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_arc_standard_node_len(s : NlpparsearcstandardNode) -> Int { s.size }

pub fn nlp_parse_arc_standard_node_get(s : NlpparsearcstandardNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_arc_standard_node_set(s : NlpparsearcstandardNode, i : Int, v : Double) -> NlpparsearcstandardNode {
  let result = nlp_parse_arc_standard_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_arc_standard_node_sum(s : NlpparsearcstandardNode) -> Double { @_common.sum(s.data) }

pub fn nlp_parse_arc_standard_node_mean(s : NlpparsearcstandardNode) -> Double { @_common.mean(s.data) }

pub fn nlp_parse_arc_standard_node_scale(s : NlpparsearcstandardNode, f : Double) -> NlpparsearcstandardNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_parse_arc_standard_node_add(a : NlpparsearcstandardNode, b : NlpparsearcstandardNode) -> NlpparsearcstandardNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_parse_arc_standard_node_copy(s : NlpparsearcstandardNode) -> NlpparsearcstandardNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_parse_arc_standard_node_fill(s : NlpparsearcstandardNode, v : Double) -> NlpparsearcstandardNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_parse_arc_standard_node_min(s : NlpparsearcstandardNode) -> Double { @_common.min(s.data) }

pub fn nlp_parse_arc_standard_node_max(s : NlpparsearcstandardNode) -> Double { @_common.max(s.data) }

pub fn nlp_parse_arc_standard_node_to_string(s : NlpparsearcstandardNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparsearcstandardEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_arc_standard_edge_make(size : Int) -> NlpparsearcstandardEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_arc_standard_edge_len(s : NlpparsearcstandardEdge) -> Int { s.size }

pub fn nlp_parse_arc_standard_edge_get(s : NlpparsearcstandardEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_arc_standard_edge_set(s : NlpparsearcstandardEdge, i : Int, v : Double) -> NlpparsearcstandardEdge {
  let result = nlp_parse_arc_standard_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_arc_standard_edge_sum(s : NlpparsearcstandardEdge) -> Double { @_common.sum(s.data) }

pub fn nlp_parse_arc_standard_edge_mean(s : NlpparsearcstandardEdge) -> Double { @_common.mean(s.data) }

pub fn nlp_parse_arc_standard_edge_scale(s : NlpparsearcstandardEdge, f : Double) -> NlpparsearcstandardEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_parse_arc_standard_edge_add(a : NlpparsearcstandardEdge, b : NlpparsearcstandardEdge) -> NlpparsearcstandardEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_parse_arc_standard_edge_copy(s : NlpparsearcstandardEdge) -> NlpparsearcstandardEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_parse_arc_standard_edge_fill(s : NlpparsearcstandardEdge, v : Double) -> NlpparsearcstandardEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_parse_arc_standard_edge_min(s : NlpparsearcstandardEdge) -> Double { @_common.min(s.data) }

pub fn nlp_parse_arc_standard_edge_max(s : NlpparsearcstandardEdge) -> Double { @_common.max(s.data) }

pub fn nlp_parse_arc_standard_edge_to_string(s : NlpparsearcstandardEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparsearcstandardPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_arc_standard_path_make(size : Int) -> NlpparsearcstandardPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_arc_standard_path_len(s : NlpparsearcstandardPath) -> Int { s.size }

pub fn nlp_parse_arc_standard_path_get(s : NlpparsearcstandardPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_arc_standard_path_set(s : NlpparsearcstandardPath, i : Int, v : Double) -> NlpparsearcstandardPath {
  let result = nlp_parse_arc_standard_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_arc_standard_path_sum(s : NlpparsearcstandardPath) -> Double { @_common.sum(s.data) }

pub fn nlp_parse_arc_standard_path_mean(s : NlpparsearcstandardPath) -> Double { @_common.mean(s.data) }

pub fn nlp_parse_arc_standard_path_scale(s : NlpparsearcstandardPath, f : Double) -> NlpparsearcstandardPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_parse_arc_standard_path_add(a : NlpparsearcstandardPath, b : NlpparsearcstandardPath) -> NlpparsearcstandardPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_parse_arc_standard_path_copy(s : NlpparsearcstandardPath) -> NlpparsearcstandardPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_parse_arc_standard_path_fill(s : NlpparsearcstandardPath, v : Double) -> NlpparsearcstandardPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_parse_arc_standard_path_min(s : NlpparsearcstandardPath) -> Double { @_common.min(s.data) }

pub fn nlp_parse_arc_standard_path_max(s : NlpparsearcstandardPath) -> Double { @_common.max(s.data) }

pub fn nlp_parse_arc_standard_path_to_string(s : NlpparsearcstandardPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparsearcstandardCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_arc_standard_cluster_make(size : Int) -> NlpparsearcstandardCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_arc_standard_cluster_len(s : NlpparsearcstandardCluster) -> Int { s.size }

pub fn nlp_parse_arc_standard_cluster_get(s : NlpparsearcstandardCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_arc_standard_cluster_set(s : NlpparsearcstandardCluster, i : Int, v : Double) -> NlpparsearcstandardCluster {
  let result = nlp_parse_arc_standard_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_arc_standard_cluster_sum(s : NlpparsearcstandardCluster) -> Double { @_common.sum(s.data) }

pub fn nlp_parse_arc_standard_cluster_mean(s : NlpparsearcstandardCluster) -> Double { @_common.mean(s.data) }

pub fn nlp_parse_arc_standard_cluster_scale(s : NlpparsearcstandardCluster, f : Double) -> NlpparsearcstandardCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_parse_arc_standard_cluster_add(a : NlpparsearcstandardCluster, b : NlpparsearcstandardCluster) -> NlpparsearcstandardCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_parse_arc_standard_cluster_copy(s : NlpparsearcstandardCluster) -> NlpparsearcstandardCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_parse_arc_standard_cluster_fill(s : NlpparsearcstandardCluster, v : Double) -> NlpparsearcstandardCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_parse_arc_standard_cluster_min(s : NlpparsearcstandardCluster) -> Double { @_common.min(s.data) }

pub fn nlp_parse_arc_standard_cluster_max(s : NlpparsearcstandardCluster) -> Double { @_common.max(s.data) }

pub fn nlp_parse_arc_standard_cluster_to_string(s : NlpparsearcstandardCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparsearcstandardModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_arc_standard_model_make(size : Int) -> NlpparsearcstandardModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_arc_standard_model_len(s : NlpparsearcstandardModel) -> Int { s.size }

pub fn nlp_parse_arc_standard_model_get(s : NlpparsearcstandardModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_arc_standard_model_set(s : NlpparsearcstandardModel, i : Int, v : Double) -> NlpparsearcstandardModel {
  let result = nlp_parse_arc_standard_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_arc_standard_model_sum(s : NlpparsearcstandardModel) -> Double { @_common.sum(s.data) }

pub fn nlp_parse_arc_standard_model_mean(s : NlpparsearcstandardModel) -> Double { @_common.mean(s.data) }

pub fn nlp_parse_arc_standard_model_scale(s : NlpparsearcstandardModel, f : Double) -> NlpparsearcstandardModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_parse_arc_standard_model_add(a : NlpparsearcstandardModel, b : NlpparsearcstandardModel) -> NlpparsearcstandardModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_parse_arc_standard_model_copy(s : NlpparsearcstandardModel) -> NlpparsearcstandardModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_parse_arc_standard_model_fill(s : NlpparsearcstandardModel, v : Double) -> NlpparsearcstandardModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_parse_arc_standard_model_min(s : NlpparsearcstandardModel) -> Double { @_common.min(s.data) }

pub fn nlp_parse_arc_standard_model_max(s : NlpparsearcstandardModel) -> Double { @_common.max(s.data) }

pub fn nlp_parse_arc_standard_model_to_string(s : NlpparsearcstandardModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparsearcstandardLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_arc_standard_layer_make(size : Int) -> NlpparsearcstandardLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_arc_standard_layer_len(s : NlpparsearcstandardLayer) -> Int { s.size }

pub fn nlp_parse_arc_standard_layer_get(s : NlpparsearcstandardLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_arc_standard_layer_set(s : NlpparsearcstandardLayer, i : Int, v : Double) -> NlpparsearcstandardLayer {
  let result = nlp_parse_arc_standard_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_arc_standard_layer_sum(s : NlpparsearcstandardLayer) -> Double { @_common.sum(s.data) }

pub fn nlp_parse_arc_standard_layer_mean(s : NlpparsearcstandardLayer) -> Double { @_common.mean(s.data) }

pub fn nlp_parse_arc_standard_layer_scale(s : NlpparsearcstandardLayer, f : Double) -> NlpparsearcstandardLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_parse_arc_standard_layer_add(a : NlpparsearcstandardLayer, b : NlpparsearcstandardLayer) -> NlpparsearcstandardLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_parse_arc_standard_layer_copy(s : NlpparsearcstandardLayer) -> NlpparsearcstandardLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_parse_arc_standard_layer_fill(s : NlpparsearcstandardLayer, v : Double) -> NlpparsearcstandardLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_parse_arc_standard_layer_min(s : NlpparsearcstandardLayer) -> Double { @_common.min(s.data) }

pub fn nlp_parse_arc_standard_layer_max(s : NlpparsearcstandardLayer) -> Double { @_common.max(s.data) }

pub fn nlp_parse_arc_standard_layer_to_string(s : NlpparsearcstandardLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparsearcstandardBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_arc_standard_buffer_make(size : Int) -> NlpparsearcstandardBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_arc_standard_buffer_len(s : NlpparsearcstandardBuffer) -> Int { s.size }

pub fn nlp_parse_arc_standard_buffer_get(s : NlpparsearcstandardBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_arc_standard_buffer_set(s : NlpparsearcstandardBuffer, i : Int, v : Double) -> NlpparsearcstandardBuffer {
  let result = nlp_parse_arc_standard_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_arc_standard_buffer_sum(s : NlpparsearcstandardBuffer) -> Double { @_common.sum(s.data) }

pub fn nlp_parse_arc_standard_buffer_mean(s : NlpparsearcstandardBuffer) -> Double { @_common.mean(s.data) }

pub fn nlp_parse_arc_standard_buffer_scale(s : NlpparsearcstandardBuffer, f : Double) -> NlpparsearcstandardBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_parse_arc_standard_buffer_add(a : NlpparsearcstandardBuffer, b : NlpparsearcstandardBuffer) -> NlpparsearcstandardBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_parse_arc_standard_buffer_copy(s : NlpparsearcstandardBuffer) -> NlpparsearcstandardBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_parse_arc_standard_buffer_fill(s : NlpparsearcstandardBuffer, v : Double) -> NlpparsearcstandardBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_parse_arc_standard_buffer_min(s : NlpparsearcstandardBuffer) -> Double { @_common.min(s.data) }

pub fn nlp_parse_arc_standard_buffer_max(s : NlpparsearcstandardBuffer) -> Double { @_common.max(s.data) }

pub fn nlp_parse_arc_standard_buffer_to_string(s : NlpparsearcstandardBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparsearcstandardCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_arc_standard_cursor_make(size : Int) -> NlpparsearcstandardCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_arc_standard_cursor_len(s : NlpparsearcstandardCursor) -> Int { s.size }

pub fn nlp_parse_arc_standard_cursor_get(s : NlpparsearcstandardCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_arc_standard_cursor_set(s : NlpparsearcstandardCursor, i : Int, v : Double) -> NlpparsearcstandardCursor {
  let result = nlp_parse_arc_standard_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_arc_standard_cursor_sum(s : NlpparsearcstandardCursor) -> Double { @_common.sum(s.data) }

pub fn nlp_parse_arc_standard_cursor_mean(s : NlpparsearcstandardCursor) -> Double { @_common.mean(s.data) }

pub fn nlp_parse_arc_standard_cursor_scale(s : NlpparsearcstandardCursor, f : Double) -> NlpparsearcstandardCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_parse_arc_standard_cursor_add(a : NlpparsearcstandardCursor, b : NlpparsearcstandardCursor) -> NlpparsearcstandardCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_parse_arc_standard_cursor_copy(s : NlpparsearcstandardCursor) -> NlpparsearcstandardCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_parse_arc_standard_cursor_fill(s : NlpparsearcstandardCursor, v : Double) -> NlpparsearcstandardCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_parse_arc_standard_cursor_min(s : NlpparsearcstandardCursor) -> Double { @_common.min(s.data) }

pub fn nlp_parse_arc_standard_cursor_max(s : NlpparsearcstandardCursor) -> Double { @_common.max(s.data) }

pub fn nlp_parse_arc_standard_cursor_to_string(s : NlpparsearcstandardCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparsearcstandardView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_arc_standard_view_make(size : Int) -> NlpparsearcstandardView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_arc_standard_view_len(s : NlpparsearcstandardView) -> Int { s.size }

pub fn nlp_parse_arc_standard_view_get(s : NlpparsearcstandardView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_arc_standard_view_set(s : NlpparsearcstandardView, i : Int, v : Double) -> NlpparsearcstandardView {
  let result = nlp_parse_arc_standard_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_arc_standard_view_sum(s : NlpparsearcstandardView) -> Double { @_common.sum(s.data) }

pub fn nlp_parse_arc_standard_view_mean(s : NlpparsearcstandardView) -> Double { @_common.mean(s.data) }

pub fn nlp_parse_arc_standard_view_scale(s : NlpparsearcstandardView, f : Double) -> NlpparsearcstandardView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_parse_arc_standard_view_add(a : NlpparsearcstandardView, b : NlpparsearcstandardView) -> NlpparsearcstandardView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_parse_arc_standard_view_copy(s : NlpparsearcstandardView) -> NlpparsearcstandardView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_parse_arc_standard_view_fill(s : NlpparsearcstandardView, v : Double) -> NlpparsearcstandardView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_parse_arc_standard_view_min(s : NlpparsearcstandardView) -> Double { @_common.min(s.data) }

pub fn nlp_parse_arc_standard_view_max(s : NlpparsearcstandardView) -> Double { @_common.max(s.data) }

pub fn nlp_parse_arc_standard_view_to_string(s : NlpparsearcstandardView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparsearcstandardRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_arc_standard_range_make(size : Int) -> NlpparsearcstandardRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_arc_standard_range_len(s : NlpparsearcstandardRange) -> Int { s.size }

pub fn nlp_parse_arc_standard_range_get(s : NlpparsearcstandardRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_arc_standard_range_set(s : NlpparsearcstandardRange, i : Int, v : Double) -> NlpparsearcstandardRange {
  let result = nlp_parse_arc_standard_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_arc_standard_range_sum(s : NlpparsearcstandardRange) -> Double { @_common.sum(s.data) }

pub fn nlp_parse_arc_standard_range_mean(s : NlpparsearcstandardRange) -> Double { @_common.mean(s.data) }

pub fn nlp_parse_arc_standard_range_scale(s : NlpparsearcstandardRange, f : Double) -> NlpparsearcstandardRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_parse_arc_standard_range_add(a : NlpparsearcstandardRange, b : NlpparsearcstandardRange) -> NlpparsearcstandardRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_parse_arc_standard_range_copy(s : NlpparsearcstandardRange) -> NlpparsearcstandardRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_parse_arc_standard_range_fill(s : NlpparsearcstandardRange, v : Double) -> NlpparsearcstandardRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_parse_arc_standard_range_min(s : NlpparsearcstandardRange) -> Double { @_common.min(s.data) }

pub fn nlp_parse_arc_standard_range_max(s : NlpparsearcstandardRange) -> Double { @_common.max(s.data) }

pub fn nlp_parse_arc_standard_range_to_string(s : NlpparsearcstandardRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparsearcstandardSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_arc_standard_slice_make(size : Int) -> NlpparsearcstandardSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_arc_standard_slice_len(s : NlpparsearcstandardSlice) -> Int { s.size }

pub fn nlp_parse_arc_standard_slice_get(s : NlpparsearcstandardSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_arc_standard_slice_set(s : NlpparsearcstandardSlice, i : Int, v : Double) -> NlpparsearcstandardSlice {
  let result = nlp_parse_arc_standard_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_arc_standard_slice_sum(s : NlpparsearcstandardSlice) -> Double { @_common.sum(s.data) }

pub fn nlp_parse_arc_standard_slice_mean(s : NlpparsearcstandardSlice) -> Double { @_common.mean(s.data) }

pub fn nlp_parse_arc_standard_slice_scale(s : NlpparsearcstandardSlice, f : Double) -> NlpparsearcstandardSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_parse_arc_standard_slice_add(a : NlpparsearcstandardSlice, b : NlpparsearcstandardSlice) -> NlpparsearcstandardSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_parse_arc_standard_slice_copy(s : NlpparsearcstandardSlice) -> NlpparsearcstandardSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_parse_arc_standard_slice_fill(s : NlpparsearcstandardSlice, v : Double) -> NlpparsearcstandardSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_parse_arc_standard_slice_min(s : NlpparsearcstandardSlice) -> Double { @_common.min(s.data) }

pub fn nlp_parse_arc_standard_slice_max(s : NlpparsearcstandardSlice) -> Double { @_common.max(s.data) }

pub fn nlp_parse_arc_standard_slice_to_string(s : NlpparsearcstandardSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

