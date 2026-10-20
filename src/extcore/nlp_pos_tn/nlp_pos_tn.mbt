///===
/// extcore/nlp_pos_tn

pub(all) struct NlppostnPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn nlp_pos_tn_make_point(x : Double, y : Double) -> NlppostnPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn nlp_pos_tn_make_point3(x : Double, y : Double, z : Double) -> NlppostnPoint {
  { x, y, z, label: 0 }
}

pub fn nlp_pos_tn_point_x(pt : NlppostnPoint) -> Double { pt.x }

pub fn nlp_pos_tn_point_y(pt : NlppostnPoint) -> Double { pt.y }

pub fn nlp_pos_tn_point_z(pt : NlppostnPoint) -> Double { pt.z }

pub fn nlp_pos_tn_point_label(pt : NlppostnPoint) -> Int { pt.label }

pub fn nlp_pos_tn_point_dist(a : NlppostnPoint, b : NlppostnPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn nlp_pos_tn_point_add(a : NlppostnPoint, b : NlppostnPoint) -> NlppostnPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn nlp_pos_tn_point_sub(a : NlppostnPoint, b : NlppostnPoint) -> NlppostnPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn nlp_pos_tn_point_scale(pt : NlppostnPoint, s : Double) -> NlppostnPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn nlp_pos_tn_point_dot(a : NlppostnPoint, b : NlppostnPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn nlp_pos_tn_point_cross(a : NlppostnPoint, b : NlppostnPoint) -> NlppostnPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn nlp_pos_tn_point_norm(pt : NlppostnPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn nlp_pos_tn_point_normalize(pt : NlppostnPoint) -> NlppostnPoint {
  let n = nlp_pos_tn_point_norm(pt)
  if n < 0.0000001 { pt } else { nlp_pos_tn_point_scale(pt, 1.0 / n) }
}

pub fn nlp_pos_tn_point_negate(pt : NlppostnPoint) -> NlppostnPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn nlp_pos_tn_point_mid(a : NlppostnPoint, b : NlppostnPoint) -> NlppostnPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn nlp_pos_tn_point_lerp(a : NlppostnPoint, b : NlppostnPoint, t : Double) -> NlppostnPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn nlp_pos_tn_point_to_string(pt : NlppostnPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct NlppostnSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn nlp_pos_tn_make_series(vals : Array[Double], name : String) -> NlppostnSeries {
  { vals, name, meta: 0 }
}

pub fn nlp_pos_tn_series_len(s : NlppostnSeries) -> Int { s.vals.length() }

pub fn nlp_pos_tn_series_sum(s : NlppostnSeries) -> Double { @_common.sum(s.vals) }

pub fn nlp_pos_tn_series_mean(s : NlppostnSeries) -> Double { @_common.mean(s.vals) }

pub fn nlp_pos_tn_series_min(s : NlppostnSeries) -> Double { @_common.min(s.vals) }

pub fn nlp_pos_tn_series_max(s : NlppostnSeries) -> Double { @_common.max(s.vals) }

pub fn nlp_pos_tn_series_range(s : NlppostnSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn nlp_pos_tn_series_var(s : NlppostnSeries) -> Double { @_common.variance(s.vals) }

pub fn nlp_pos_tn_series_std(s : NlppostnSeries) -> Double { @_common.std(s.vals) }

pub fn nlp_pos_tn_series_median(s : NlppostnSeries) -> Double { @_common.median(s.vals) }

pub fn nlp_pos_tn_series_scale(s : NlppostnSeries, f : Double) -> NlppostnSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn nlp_pos_tn_series_add(a : NlppostnSeries, b : NlppostnSeries) -> NlppostnSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn nlp_pos_tn_series_sub(a : NlppostnSeries, b : NlppostnSeries) -> NlppostnSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn nlp_pos_tn_series_normalize(s : NlppostnSeries) -> NlppostnSeries {
  let mn = nlp_pos_tn_series_min(s)
  let mx = nlp_pos_tn_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn nlp_pos_tn_series_cumsum(s : NlppostnSeries) -> NlppostnSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn nlp_pos_tn_series_to_string(s : NlppostnSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NlppostnMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn nlp_pos_tn_make_matrix(rows : Int, cols : Int, val : Double) -> NlppostnMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn nlp_pos_tn_matrix_identity(n : Int) -> NlppostnMatrix {
  let m = nlp_pos_tn_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn nlp_pos_tn_matrix_get(m : NlppostnMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn nlp_pos_tn_matrix_transpose(m : NlppostnMatrix) -> NlppostnMatrix {
  let result = nlp_pos_tn_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn nlp_pos_tn_matrix_add(a : NlppostnMatrix, b : NlppostnMatrix) -> NlppostnMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = nlp_pos_tn_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn nlp_pos_tn_matrix_scale(m : NlppostnMatrix, s : Double) -> NlppostnMatrix {
  let result = nlp_pos_tn_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn nlp_pos_tn_matrix_multiply(a : NlppostnMatrix, b : NlppostnMatrix) -> NlppostnMatrix {
  if a.cols != b.rows { return nlp_pos_tn_make_matrix(a.rows, b.cols, 0.0) }
  let result = nlp_pos_tn_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn nlp_pos_tn_matrix_trace(m : NlppostnMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn nlp_pos_tn_matrix_det(m : NlppostnMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn nlp_pos_tn_matrix_norm(m : NlppostnMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn nlp_pos_tn_matrix_to_string(m : NlppostnMatrix) -> String {
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

pub(all) struct NlppostnVector {
  comps : Array[Double]
  dim : Int
}

pub fn nlp_pos_tn_make_vector(comps : Array[Double]) -> NlppostnVector {
  { comps, dim: comps.length() }
}

pub fn nlp_pos_tn_vector_zero(dim : Int) -> NlppostnVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn nlp_pos_tn_vector_add(a : NlppostnVector, b : NlppostnVector) -> NlppostnVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn nlp_pos_tn_vector_sub(a : NlppostnVector, b : NlppostnVector) -> NlppostnVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn nlp_pos_tn_vector_scale(v : NlppostnVector, s : Double) -> NlppostnVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn nlp_pos_tn_vector_dot(a : NlppostnVector, b : NlppostnVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn nlp_pos_tn_vector_norm(v : NlppostnVector) -> Double { @_common.sqrt(nlp_pos_tn_vector_dot(v, v)) }

pub fn nlp_pos_tn_vector_normalize(v : NlppostnVector) -> NlppostnVector {
  let n = nlp_pos_tn_vector_norm(v)
  if n < 0.0000001 { v } else { nlp_pos_tn_vector_scale(v, 1.0 / n) }
}

pub fn nlp_pos_tn_vector_dist(a : NlppostnVector, b : NlppostnVector) -> Double {
  nlp_pos_tn_vector_norm(nlp_pos_tn_vector_sub(a, b))
}

pub fn nlp_pos_tn_vector_to_string(v : NlppostnVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn nlp_pos_tn_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn nlp_pos_tn_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn nlp_pos_tn_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn nlp_pos_tn_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn nlp_pos_tn_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn nlp_pos_tn_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn nlp_pos_tn_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn nlp_pos_tn_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn nlp_pos_tn_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn nlp_pos_tn_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn nlp_pos_tn_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn nlp_pos_tn_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn nlp_pos_tn_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn nlp_pos_tn_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn nlp_pos_tn_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn nlp_pos_tn_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn nlp_pos_tn_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn nlp_pos_tn_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn nlp_pos_tn_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn nlp_pos_tn_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn nlp_pos_tn_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn nlp_pos_tn_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn nlp_pos_tn_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn nlp_pos_tn_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn nlp_pos_tn_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn nlp_pos_tn_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn nlp_pos_tn_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn nlp_pos_tn_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn nlp_pos_tn_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct NlppostnFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_tn_frame_make(size : Int) -> NlppostnFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_tn_frame_len(s : NlppostnFrame) -> Int { s.size }

pub fn nlp_pos_tn_frame_get(s : NlppostnFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_tn_frame_set(s : NlppostnFrame, i : Int, v : Double) -> NlppostnFrame {
  let result = nlp_pos_tn_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_tn_frame_sum(s : NlppostnFrame) -> Double { @_common.sum(s.data) }

pub fn nlp_pos_tn_frame_mean(s : NlppostnFrame) -> Double { @_common.mean(s.data) }

pub fn nlp_pos_tn_frame_scale(s : NlppostnFrame, f : Double) -> NlppostnFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_pos_tn_frame_add(a : NlppostnFrame, b : NlppostnFrame) -> NlppostnFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_pos_tn_frame_copy(s : NlppostnFrame) -> NlppostnFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_pos_tn_frame_fill(s : NlppostnFrame, v : Double) -> NlppostnFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_pos_tn_frame_min(s : NlppostnFrame) -> Double { @_common.min(s.data) }

pub fn nlp_pos_tn_frame_max(s : NlppostnFrame) -> Double { @_common.max(s.data) }

pub fn nlp_pos_tn_frame_to_string(s : NlppostnFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlppostnTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_tn_table_make(size : Int) -> NlppostnTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_tn_table_len(s : NlppostnTable) -> Int { s.size }

pub fn nlp_pos_tn_table_get(s : NlppostnTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_tn_table_set(s : NlppostnTable, i : Int, v : Double) -> NlppostnTable {
  let result = nlp_pos_tn_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_tn_table_sum(s : NlppostnTable) -> Double { @_common.sum(s.data) }

pub fn nlp_pos_tn_table_mean(s : NlppostnTable) -> Double { @_common.mean(s.data) }

pub fn nlp_pos_tn_table_scale(s : NlppostnTable, f : Double) -> NlppostnTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_pos_tn_table_add(a : NlppostnTable, b : NlppostnTable) -> NlppostnTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_pos_tn_table_copy(s : NlppostnTable) -> NlppostnTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_pos_tn_table_fill(s : NlppostnTable, v : Double) -> NlppostnTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_pos_tn_table_min(s : NlppostnTable) -> Double { @_common.min(s.data) }

pub fn nlp_pos_tn_table_max(s : NlppostnTable) -> Double { @_common.max(s.data) }

pub fn nlp_pos_tn_table_to_string(s : NlppostnTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlppostnGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_tn_graphn_make(size : Int) -> NlppostnGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_tn_graphn_len(s : NlppostnGraphN) -> Int { s.size }

pub fn nlp_pos_tn_graphn_get(s : NlppostnGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_tn_graphn_set(s : NlppostnGraphN, i : Int, v : Double) -> NlppostnGraphN {
  let result = nlp_pos_tn_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_tn_graphn_sum(s : NlppostnGraphN) -> Double { @_common.sum(s.data) }

pub fn nlp_pos_tn_graphn_mean(s : NlppostnGraphN) -> Double { @_common.mean(s.data) }

pub fn nlp_pos_tn_graphn_scale(s : NlppostnGraphN, f : Double) -> NlppostnGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_pos_tn_graphn_add(a : NlppostnGraphN, b : NlppostnGraphN) -> NlppostnGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_pos_tn_graphn_copy(s : NlppostnGraphN) -> NlppostnGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_pos_tn_graphn_fill(s : NlppostnGraphN, v : Double) -> NlppostnGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_pos_tn_graphn_min(s : NlppostnGraphN) -> Double { @_common.min(s.data) }

pub fn nlp_pos_tn_graphn_max(s : NlppostnGraphN) -> Double { @_common.max(s.data) }

pub fn nlp_pos_tn_graphn_to_string(s : NlppostnGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlppostnNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_tn_node_make(size : Int) -> NlppostnNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_tn_node_len(s : NlppostnNode) -> Int { s.size }

pub fn nlp_pos_tn_node_get(s : NlppostnNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_tn_node_set(s : NlppostnNode, i : Int, v : Double) -> NlppostnNode {
  let result = nlp_pos_tn_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_tn_node_sum(s : NlppostnNode) -> Double { @_common.sum(s.data) }

pub fn nlp_pos_tn_node_mean(s : NlppostnNode) -> Double { @_common.mean(s.data) }

pub fn nlp_pos_tn_node_scale(s : NlppostnNode, f : Double) -> NlppostnNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_pos_tn_node_add(a : NlppostnNode, b : NlppostnNode) -> NlppostnNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_pos_tn_node_copy(s : NlppostnNode) -> NlppostnNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_pos_tn_node_fill(s : NlppostnNode, v : Double) -> NlppostnNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_pos_tn_node_min(s : NlppostnNode) -> Double { @_common.min(s.data) }

pub fn nlp_pos_tn_node_max(s : NlppostnNode) -> Double { @_common.max(s.data) }

pub fn nlp_pos_tn_node_to_string(s : NlppostnNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlppostnEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_tn_edge_make(size : Int) -> NlppostnEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_tn_edge_len(s : NlppostnEdge) -> Int { s.size }

pub fn nlp_pos_tn_edge_get(s : NlppostnEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_tn_edge_set(s : NlppostnEdge, i : Int, v : Double) -> NlppostnEdge {
  let result = nlp_pos_tn_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_tn_edge_sum(s : NlppostnEdge) -> Double { @_common.sum(s.data) }

pub fn nlp_pos_tn_edge_mean(s : NlppostnEdge) -> Double { @_common.mean(s.data) }

pub fn nlp_pos_tn_edge_scale(s : NlppostnEdge, f : Double) -> NlppostnEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_pos_tn_edge_add(a : NlppostnEdge, b : NlppostnEdge) -> NlppostnEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_pos_tn_edge_copy(s : NlppostnEdge) -> NlppostnEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_pos_tn_edge_fill(s : NlppostnEdge, v : Double) -> NlppostnEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_pos_tn_edge_min(s : NlppostnEdge) -> Double { @_common.min(s.data) }

pub fn nlp_pos_tn_edge_max(s : NlppostnEdge) -> Double { @_common.max(s.data) }

pub fn nlp_pos_tn_edge_to_string(s : NlppostnEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlppostnPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_tn_path_make(size : Int) -> NlppostnPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_tn_path_len(s : NlppostnPath) -> Int { s.size }

pub fn nlp_pos_tn_path_get(s : NlppostnPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_tn_path_set(s : NlppostnPath, i : Int, v : Double) -> NlppostnPath {
  let result = nlp_pos_tn_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_tn_path_sum(s : NlppostnPath) -> Double { @_common.sum(s.data) }

pub fn nlp_pos_tn_path_mean(s : NlppostnPath) -> Double { @_common.mean(s.data) }

pub fn nlp_pos_tn_path_scale(s : NlppostnPath, f : Double) -> NlppostnPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_pos_tn_path_add(a : NlppostnPath, b : NlppostnPath) -> NlppostnPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_pos_tn_path_copy(s : NlppostnPath) -> NlppostnPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_pos_tn_path_fill(s : NlppostnPath, v : Double) -> NlppostnPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_pos_tn_path_min(s : NlppostnPath) -> Double { @_common.min(s.data) }

pub fn nlp_pos_tn_path_max(s : NlppostnPath) -> Double { @_common.max(s.data) }

pub fn nlp_pos_tn_path_to_string(s : NlppostnPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlppostnCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_tn_cluster_make(size : Int) -> NlppostnCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_tn_cluster_len(s : NlppostnCluster) -> Int { s.size }

pub fn nlp_pos_tn_cluster_get(s : NlppostnCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_tn_cluster_set(s : NlppostnCluster, i : Int, v : Double) -> NlppostnCluster {
  let result = nlp_pos_tn_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_tn_cluster_sum(s : NlppostnCluster) -> Double { @_common.sum(s.data) }

pub fn nlp_pos_tn_cluster_mean(s : NlppostnCluster) -> Double { @_common.mean(s.data) }

pub fn nlp_pos_tn_cluster_scale(s : NlppostnCluster, f : Double) -> NlppostnCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_pos_tn_cluster_add(a : NlppostnCluster, b : NlppostnCluster) -> NlppostnCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_pos_tn_cluster_copy(s : NlppostnCluster) -> NlppostnCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_pos_tn_cluster_fill(s : NlppostnCluster, v : Double) -> NlppostnCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_pos_tn_cluster_min(s : NlppostnCluster) -> Double { @_common.min(s.data) }

pub fn nlp_pos_tn_cluster_max(s : NlppostnCluster) -> Double { @_common.max(s.data) }

pub fn nlp_pos_tn_cluster_to_string(s : NlppostnCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlppostnModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_tn_model_make(size : Int) -> NlppostnModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_tn_model_len(s : NlppostnModel) -> Int { s.size }

pub fn nlp_pos_tn_model_get(s : NlppostnModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_tn_model_set(s : NlppostnModel, i : Int, v : Double) -> NlppostnModel {
  let result = nlp_pos_tn_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_tn_model_sum(s : NlppostnModel) -> Double { @_common.sum(s.data) }

pub fn nlp_pos_tn_model_mean(s : NlppostnModel) -> Double { @_common.mean(s.data) }

pub fn nlp_pos_tn_model_scale(s : NlppostnModel, f : Double) -> NlppostnModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_pos_tn_model_add(a : NlppostnModel, b : NlppostnModel) -> NlppostnModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_pos_tn_model_copy(s : NlppostnModel) -> NlppostnModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_pos_tn_model_fill(s : NlppostnModel, v : Double) -> NlppostnModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_pos_tn_model_min(s : NlppostnModel) -> Double { @_common.min(s.data) }

pub fn nlp_pos_tn_model_max(s : NlppostnModel) -> Double { @_common.max(s.data) }

pub fn nlp_pos_tn_model_to_string(s : NlppostnModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlppostnLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_tn_layer_make(size : Int) -> NlppostnLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_tn_layer_len(s : NlppostnLayer) -> Int { s.size }

pub fn nlp_pos_tn_layer_get(s : NlppostnLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_tn_layer_set(s : NlppostnLayer, i : Int, v : Double) -> NlppostnLayer {
  let result = nlp_pos_tn_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_tn_layer_sum(s : NlppostnLayer) -> Double { @_common.sum(s.data) }

pub fn nlp_pos_tn_layer_mean(s : NlppostnLayer) -> Double { @_common.mean(s.data) }

pub fn nlp_pos_tn_layer_scale(s : NlppostnLayer, f : Double) -> NlppostnLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_pos_tn_layer_add(a : NlppostnLayer, b : NlppostnLayer) -> NlppostnLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_pos_tn_layer_copy(s : NlppostnLayer) -> NlppostnLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_pos_tn_layer_fill(s : NlppostnLayer, v : Double) -> NlppostnLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_pos_tn_layer_min(s : NlppostnLayer) -> Double { @_common.min(s.data) }

pub fn nlp_pos_tn_layer_max(s : NlppostnLayer) -> Double { @_common.max(s.data) }

pub fn nlp_pos_tn_layer_to_string(s : NlppostnLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlppostnBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_tn_buffer_make(size : Int) -> NlppostnBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_tn_buffer_len(s : NlppostnBuffer) -> Int { s.size }

pub fn nlp_pos_tn_buffer_get(s : NlppostnBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_tn_buffer_set(s : NlppostnBuffer, i : Int, v : Double) -> NlppostnBuffer {
  let result = nlp_pos_tn_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_tn_buffer_sum(s : NlppostnBuffer) -> Double { @_common.sum(s.data) }

pub fn nlp_pos_tn_buffer_mean(s : NlppostnBuffer) -> Double { @_common.mean(s.data) }

pub fn nlp_pos_tn_buffer_scale(s : NlppostnBuffer, f : Double) -> NlppostnBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_pos_tn_buffer_add(a : NlppostnBuffer, b : NlppostnBuffer) -> NlppostnBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_pos_tn_buffer_copy(s : NlppostnBuffer) -> NlppostnBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_pos_tn_buffer_fill(s : NlppostnBuffer, v : Double) -> NlppostnBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_pos_tn_buffer_min(s : NlppostnBuffer) -> Double { @_common.min(s.data) }

pub fn nlp_pos_tn_buffer_max(s : NlppostnBuffer) -> Double { @_common.max(s.data) }

pub fn nlp_pos_tn_buffer_to_string(s : NlppostnBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlppostnCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_tn_cursor_make(size : Int) -> NlppostnCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_tn_cursor_len(s : NlppostnCursor) -> Int { s.size }

pub fn nlp_pos_tn_cursor_get(s : NlppostnCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_tn_cursor_set(s : NlppostnCursor, i : Int, v : Double) -> NlppostnCursor {
  let result = nlp_pos_tn_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_tn_cursor_sum(s : NlppostnCursor) -> Double { @_common.sum(s.data) }

pub fn nlp_pos_tn_cursor_mean(s : NlppostnCursor) -> Double { @_common.mean(s.data) }

pub fn nlp_pos_tn_cursor_scale(s : NlppostnCursor, f : Double) -> NlppostnCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_pos_tn_cursor_add(a : NlppostnCursor, b : NlppostnCursor) -> NlppostnCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_pos_tn_cursor_copy(s : NlppostnCursor) -> NlppostnCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_pos_tn_cursor_fill(s : NlppostnCursor, v : Double) -> NlppostnCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_pos_tn_cursor_min(s : NlppostnCursor) -> Double { @_common.min(s.data) }

pub fn nlp_pos_tn_cursor_max(s : NlppostnCursor) -> Double { @_common.max(s.data) }

pub fn nlp_pos_tn_cursor_to_string(s : NlppostnCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlppostnView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_tn_view_make(size : Int) -> NlppostnView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_tn_view_len(s : NlppostnView) -> Int { s.size }

pub fn nlp_pos_tn_view_get(s : NlppostnView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_tn_view_set(s : NlppostnView, i : Int, v : Double) -> NlppostnView {
  let result = nlp_pos_tn_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_tn_view_sum(s : NlppostnView) -> Double { @_common.sum(s.data) }

pub fn nlp_pos_tn_view_mean(s : NlppostnView) -> Double { @_common.mean(s.data) }

pub fn nlp_pos_tn_view_scale(s : NlppostnView, f : Double) -> NlppostnView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_pos_tn_view_add(a : NlppostnView, b : NlppostnView) -> NlppostnView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_pos_tn_view_copy(s : NlppostnView) -> NlppostnView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_pos_tn_view_fill(s : NlppostnView, v : Double) -> NlppostnView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_pos_tn_view_min(s : NlppostnView) -> Double { @_common.min(s.data) }

pub fn nlp_pos_tn_view_max(s : NlppostnView) -> Double { @_common.max(s.data) }

pub fn nlp_pos_tn_view_to_string(s : NlppostnView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlppostnRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_tn_range_make(size : Int) -> NlppostnRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_tn_range_len(s : NlppostnRange) -> Int { s.size }

pub fn nlp_pos_tn_range_get(s : NlppostnRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_tn_range_set(s : NlppostnRange, i : Int, v : Double) -> NlppostnRange {
  let result = nlp_pos_tn_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_tn_range_sum(s : NlppostnRange) -> Double { @_common.sum(s.data) }

pub fn nlp_pos_tn_range_mean(s : NlppostnRange) -> Double { @_common.mean(s.data) }

pub fn nlp_pos_tn_range_scale(s : NlppostnRange, f : Double) -> NlppostnRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_pos_tn_range_add(a : NlppostnRange, b : NlppostnRange) -> NlppostnRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_pos_tn_range_copy(s : NlppostnRange) -> NlppostnRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_pos_tn_range_fill(s : NlppostnRange, v : Double) -> NlppostnRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_pos_tn_range_min(s : NlppostnRange) -> Double { @_common.min(s.data) }

pub fn nlp_pos_tn_range_max(s : NlppostnRange) -> Double { @_common.max(s.data) }

pub fn nlp_pos_tn_range_to_string(s : NlppostnRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlppostnSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_tn_slice_make(size : Int) -> NlppostnSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_tn_slice_len(s : NlppostnSlice) -> Int { s.size }

pub fn nlp_pos_tn_slice_get(s : NlppostnSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_tn_slice_set(s : NlppostnSlice, i : Int, v : Double) -> NlppostnSlice {
  let result = nlp_pos_tn_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_tn_slice_sum(s : NlppostnSlice) -> Double { @_common.sum(s.data) }

pub fn nlp_pos_tn_slice_mean(s : NlppostnSlice) -> Double { @_common.mean(s.data) }

pub fn nlp_pos_tn_slice_scale(s : NlppostnSlice, f : Double) -> NlppostnSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_pos_tn_slice_add(a : NlppostnSlice, b : NlppostnSlice) -> NlppostnSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_pos_tn_slice_copy(s : NlppostnSlice) -> NlppostnSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_pos_tn_slice_fill(s : NlppostnSlice, v : Double) -> NlppostnSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_pos_tn_slice_min(s : NlppostnSlice) -> Double { @_common.min(s.data) }

pub fn nlp_pos_tn_slice_max(s : NlppostnSlice) -> Double { @_common.max(s.data) }

pub fn nlp_pos_tn_slice_to_string(s : NlppostnSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

