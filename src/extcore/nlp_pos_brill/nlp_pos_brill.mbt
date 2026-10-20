///===
/// extcore/nlp_pos_brill

pub(all) struct NlpposbrillPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn nlp_pos_brill_make_point(x : Double, y : Double) -> NlpposbrillPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn nlp_pos_brill_make_point3(x : Double, y : Double, z : Double) -> NlpposbrillPoint {
  { x, y, z, label: 0 }
}

pub fn nlp_pos_brill_point_x(pt : NlpposbrillPoint) -> Double { pt.x }

pub fn nlp_pos_brill_point_y(pt : NlpposbrillPoint) -> Double { pt.y }

pub fn nlp_pos_brill_point_z(pt : NlpposbrillPoint) -> Double { pt.z }

pub fn nlp_pos_brill_point_label(pt : NlpposbrillPoint) -> Int { pt.label }

pub fn nlp_pos_brill_point_dist(a : NlpposbrillPoint, b : NlpposbrillPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn nlp_pos_brill_point_add(a : NlpposbrillPoint, b : NlpposbrillPoint) -> NlpposbrillPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn nlp_pos_brill_point_sub(a : NlpposbrillPoint, b : NlpposbrillPoint) -> NlpposbrillPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn nlp_pos_brill_point_scale(pt : NlpposbrillPoint, s : Double) -> NlpposbrillPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn nlp_pos_brill_point_dot(a : NlpposbrillPoint, b : NlpposbrillPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn nlp_pos_brill_point_cross(a : NlpposbrillPoint, b : NlpposbrillPoint) -> NlpposbrillPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn nlp_pos_brill_point_norm(pt : NlpposbrillPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn nlp_pos_brill_point_normalize(pt : NlpposbrillPoint) -> NlpposbrillPoint {
  let n = nlp_pos_brill_point_norm(pt)
  if n < 0.0000001 { pt } else { nlp_pos_brill_point_scale(pt, 1.0 / n) }
}

pub fn nlp_pos_brill_point_negate(pt : NlpposbrillPoint) -> NlpposbrillPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn nlp_pos_brill_point_mid(a : NlpposbrillPoint, b : NlpposbrillPoint) -> NlpposbrillPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn nlp_pos_brill_point_lerp(a : NlpposbrillPoint, b : NlpposbrillPoint, t : Double) -> NlpposbrillPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn nlp_pos_brill_point_to_string(pt : NlpposbrillPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct NlpposbrillSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn nlp_pos_brill_make_series(vals : Array[Double], name : String) -> NlpposbrillSeries {
  { vals, name, meta: 0 }
}

pub fn nlp_pos_brill_series_len(s : NlpposbrillSeries) -> Int { s.vals.length() }

pub fn nlp_pos_brill_series_sum(s : NlpposbrillSeries) -> Double { @_common.sum(s.vals) }

pub fn nlp_pos_brill_series_mean(s : NlpposbrillSeries) -> Double { @_common.mean(s.vals) }

pub fn nlp_pos_brill_series_min(s : NlpposbrillSeries) -> Double { @_common.min(s.vals) }

pub fn nlp_pos_brill_series_max(s : NlpposbrillSeries) -> Double { @_common.max(s.vals) }

pub fn nlp_pos_brill_series_range(s : NlpposbrillSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn nlp_pos_brill_series_var(s : NlpposbrillSeries) -> Double { @_common.variance(s.vals) }

pub fn nlp_pos_brill_series_std(s : NlpposbrillSeries) -> Double { @_common.std(s.vals) }

pub fn nlp_pos_brill_series_median(s : NlpposbrillSeries) -> Double { @_common.median(s.vals) }

pub fn nlp_pos_brill_series_scale(s : NlpposbrillSeries, f : Double) -> NlpposbrillSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn nlp_pos_brill_series_add(a : NlpposbrillSeries, b : NlpposbrillSeries) -> NlpposbrillSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn nlp_pos_brill_series_sub(a : NlpposbrillSeries, b : NlpposbrillSeries) -> NlpposbrillSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn nlp_pos_brill_series_normalize(s : NlpposbrillSeries) -> NlpposbrillSeries {
  let mn = nlp_pos_brill_series_min(s)
  let mx = nlp_pos_brill_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn nlp_pos_brill_series_cumsum(s : NlpposbrillSeries) -> NlpposbrillSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn nlp_pos_brill_series_to_string(s : NlpposbrillSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NlpposbrillMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn nlp_pos_brill_make_matrix(rows : Int, cols : Int, val : Double) -> NlpposbrillMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn nlp_pos_brill_matrix_identity(n : Int) -> NlpposbrillMatrix {
  let m = nlp_pos_brill_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn nlp_pos_brill_matrix_get(m : NlpposbrillMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn nlp_pos_brill_matrix_transpose(m : NlpposbrillMatrix) -> NlpposbrillMatrix {
  let result = nlp_pos_brill_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn nlp_pos_brill_matrix_add(a : NlpposbrillMatrix, b : NlpposbrillMatrix) -> NlpposbrillMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = nlp_pos_brill_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn nlp_pos_brill_matrix_scale(m : NlpposbrillMatrix, s : Double) -> NlpposbrillMatrix {
  let result = nlp_pos_brill_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn nlp_pos_brill_matrix_multiply(a : NlpposbrillMatrix, b : NlpposbrillMatrix) -> NlpposbrillMatrix {
  if a.cols != b.rows { return nlp_pos_brill_make_matrix(a.rows, b.cols, 0.0) }
  let result = nlp_pos_brill_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn nlp_pos_brill_matrix_trace(m : NlpposbrillMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn nlp_pos_brill_matrix_det(m : NlpposbrillMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn nlp_pos_brill_matrix_norm(m : NlpposbrillMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn nlp_pos_brill_matrix_to_string(m : NlpposbrillMatrix) -> String {
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

pub(all) struct NlpposbrillVector {
  comps : Array[Double]
  dim : Int
}

pub fn nlp_pos_brill_make_vector(comps : Array[Double]) -> NlpposbrillVector {
  { comps, dim: comps.length() }
}

pub fn nlp_pos_brill_vector_zero(dim : Int) -> NlpposbrillVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn nlp_pos_brill_vector_add(a : NlpposbrillVector, b : NlpposbrillVector) -> NlpposbrillVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn nlp_pos_brill_vector_sub(a : NlpposbrillVector, b : NlpposbrillVector) -> NlpposbrillVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn nlp_pos_brill_vector_scale(v : NlpposbrillVector, s : Double) -> NlpposbrillVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn nlp_pos_brill_vector_dot(a : NlpposbrillVector, b : NlpposbrillVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn nlp_pos_brill_vector_norm(v : NlpposbrillVector) -> Double { @_common.sqrt(nlp_pos_brill_vector_dot(v, v)) }

pub fn nlp_pos_brill_vector_normalize(v : NlpposbrillVector) -> NlpposbrillVector {
  let n = nlp_pos_brill_vector_norm(v)
  if n < 0.0000001 { v } else { nlp_pos_brill_vector_scale(v, 1.0 / n) }
}

pub fn nlp_pos_brill_vector_dist(a : NlpposbrillVector, b : NlpposbrillVector) -> Double {
  nlp_pos_brill_vector_norm(nlp_pos_brill_vector_sub(a, b))
}

pub fn nlp_pos_brill_vector_to_string(v : NlpposbrillVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn nlp_pos_brill_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn nlp_pos_brill_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn nlp_pos_brill_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn nlp_pos_brill_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn nlp_pos_brill_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn nlp_pos_brill_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn nlp_pos_brill_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn nlp_pos_brill_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn nlp_pos_brill_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn nlp_pos_brill_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn nlp_pos_brill_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn nlp_pos_brill_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn nlp_pos_brill_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn nlp_pos_brill_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn nlp_pos_brill_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn nlp_pos_brill_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn nlp_pos_brill_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn nlp_pos_brill_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn nlp_pos_brill_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn nlp_pos_brill_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn nlp_pos_brill_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn nlp_pos_brill_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn nlp_pos_brill_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn nlp_pos_brill_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn nlp_pos_brill_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn nlp_pos_brill_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn nlp_pos_brill_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn nlp_pos_brill_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn nlp_pos_brill_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct NlpposbrillFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_brill_frame_make(size : Int) -> NlpposbrillFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_brill_frame_len(s : NlpposbrillFrame) -> Int { s.size }

pub fn nlp_pos_brill_frame_get(s : NlpposbrillFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_brill_frame_set(s : NlpposbrillFrame, i : Int, v : Double) -> NlpposbrillFrame {
  let result = nlp_pos_brill_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_brill_frame_sum(s : NlpposbrillFrame) -> Double { @_common.sum(s.data) }

pub fn nlp_pos_brill_frame_mean(s : NlpposbrillFrame) -> Double { @_common.mean(s.data) }

pub fn nlp_pos_brill_frame_scale(s : NlpposbrillFrame, f : Double) -> NlpposbrillFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_pos_brill_frame_add(a : NlpposbrillFrame, b : NlpposbrillFrame) -> NlpposbrillFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_pos_brill_frame_copy(s : NlpposbrillFrame) -> NlpposbrillFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_pos_brill_frame_fill(s : NlpposbrillFrame, v : Double) -> NlpposbrillFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_pos_brill_frame_min(s : NlpposbrillFrame) -> Double { @_common.min(s.data) }

pub fn nlp_pos_brill_frame_max(s : NlpposbrillFrame) -> Double { @_common.max(s.data) }

pub fn nlp_pos_brill_frame_to_string(s : NlpposbrillFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpposbrillTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_brill_table_make(size : Int) -> NlpposbrillTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_brill_table_len(s : NlpposbrillTable) -> Int { s.size }

pub fn nlp_pos_brill_table_get(s : NlpposbrillTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_brill_table_set(s : NlpposbrillTable, i : Int, v : Double) -> NlpposbrillTable {
  let result = nlp_pos_brill_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_brill_table_sum(s : NlpposbrillTable) -> Double { @_common.sum(s.data) }

pub fn nlp_pos_brill_table_mean(s : NlpposbrillTable) -> Double { @_common.mean(s.data) }

pub fn nlp_pos_brill_table_scale(s : NlpposbrillTable, f : Double) -> NlpposbrillTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_pos_brill_table_add(a : NlpposbrillTable, b : NlpposbrillTable) -> NlpposbrillTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_pos_brill_table_copy(s : NlpposbrillTable) -> NlpposbrillTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_pos_brill_table_fill(s : NlpposbrillTable, v : Double) -> NlpposbrillTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_pos_brill_table_min(s : NlpposbrillTable) -> Double { @_common.min(s.data) }

pub fn nlp_pos_brill_table_max(s : NlpposbrillTable) -> Double { @_common.max(s.data) }

pub fn nlp_pos_brill_table_to_string(s : NlpposbrillTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpposbrillGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_brill_graphn_make(size : Int) -> NlpposbrillGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_brill_graphn_len(s : NlpposbrillGraphN) -> Int { s.size }

pub fn nlp_pos_brill_graphn_get(s : NlpposbrillGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_brill_graphn_set(s : NlpposbrillGraphN, i : Int, v : Double) -> NlpposbrillGraphN {
  let result = nlp_pos_brill_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_brill_graphn_sum(s : NlpposbrillGraphN) -> Double { @_common.sum(s.data) }

pub fn nlp_pos_brill_graphn_mean(s : NlpposbrillGraphN) -> Double { @_common.mean(s.data) }

pub fn nlp_pos_brill_graphn_scale(s : NlpposbrillGraphN, f : Double) -> NlpposbrillGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_pos_brill_graphn_add(a : NlpposbrillGraphN, b : NlpposbrillGraphN) -> NlpposbrillGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_pos_brill_graphn_copy(s : NlpposbrillGraphN) -> NlpposbrillGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_pos_brill_graphn_fill(s : NlpposbrillGraphN, v : Double) -> NlpposbrillGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_pos_brill_graphn_min(s : NlpposbrillGraphN) -> Double { @_common.min(s.data) }

pub fn nlp_pos_brill_graphn_max(s : NlpposbrillGraphN) -> Double { @_common.max(s.data) }

pub fn nlp_pos_brill_graphn_to_string(s : NlpposbrillGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpposbrillNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_brill_node_make(size : Int) -> NlpposbrillNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_brill_node_len(s : NlpposbrillNode) -> Int { s.size }

pub fn nlp_pos_brill_node_get(s : NlpposbrillNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_brill_node_set(s : NlpposbrillNode, i : Int, v : Double) -> NlpposbrillNode {
  let result = nlp_pos_brill_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_brill_node_sum(s : NlpposbrillNode) -> Double { @_common.sum(s.data) }

pub fn nlp_pos_brill_node_mean(s : NlpposbrillNode) -> Double { @_common.mean(s.data) }

pub fn nlp_pos_brill_node_scale(s : NlpposbrillNode, f : Double) -> NlpposbrillNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_pos_brill_node_add(a : NlpposbrillNode, b : NlpposbrillNode) -> NlpposbrillNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_pos_brill_node_copy(s : NlpposbrillNode) -> NlpposbrillNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_pos_brill_node_fill(s : NlpposbrillNode, v : Double) -> NlpposbrillNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_pos_brill_node_min(s : NlpposbrillNode) -> Double { @_common.min(s.data) }

pub fn nlp_pos_brill_node_max(s : NlpposbrillNode) -> Double { @_common.max(s.data) }

pub fn nlp_pos_brill_node_to_string(s : NlpposbrillNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpposbrillEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_brill_edge_make(size : Int) -> NlpposbrillEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_brill_edge_len(s : NlpposbrillEdge) -> Int { s.size }

pub fn nlp_pos_brill_edge_get(s : NlpposbrillEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_brill_edge_set(s : NlpposbrillEdge, i : Int, v : Double) -> NlpposbrillEdge {
  let result = nlp_pos_brill_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_brill_edge_sum(s : NlpposbrillEdge) -> Double { @_common.sum(s.data) }

pub fn nlp_pos_brill_edge_mean(s : NlpposbrillEdge) -> Double { @_common.mean(s.data) }

pub fn nlp_pos_brill_edge_scale(s : NlpposbrillEdge, f : Double) -> NlpposbrillEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_pos_brill_edge_add(a : NlpposbrillEdge, b : NlpposbrillEdge) -> NlpposbrillEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_pos_brill_edge_copy(s : NlpposbrillEdge) -> NlpposbrillEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_pos_brill_edge_fill(s : NlpposbrillEdge, v : Double) -> NlpposbrillEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_pos_brill_edge_min(s : NlpposbrillEdge) -> Double { @_common.min(s.data) }

pub fn nlp_pos_brill_edge_max(s : NlpposbrillEdge) -> Double { @_common.max(s.data) }

pub fn nlp_pos_brill_edge_to_string(s : NlpposbrillEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpposbrillPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_brill_path_make(size : Int) -> NlpposbrillPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_brill_path_len(s : NlpposbrillPath) -> Int { s.size }

pub fn nlp_pos_brill_path_get(s : NlpposbrillPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_brill_path_set(s : NlpposbrillPath, i : Int, v : Double) -> NlpposbrillPath {
  let result = nlp_pos_brill_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_brill_path_sum(s : NlpposbrillPath) -> Double { @_common.sum(s.data) }

pub fn nlp_pos_brill_path_mean(s : NlpposbrillPath) -> Double { @_common.mean(s.data) }

pub fn nlp_pos_brill_path_scale(s : NlpposbrillPath, f : Double) -> NlpposbrillPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_pos_brill_path_add(a : NlpposbrillPath, b : NlpposbrillPath) -> NlpposbrillPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_pos_brill_path_copy(s : NlpposbrillPath) -> NlpposbrillPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_pos_brill_path_fill(s : NlpposbrillPath, v : Double) -> NlpposbrillPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_pos_brill_path_min(s : NlpposbrillPath) -> Double { @_common.min(s.data) }

pub fn nlp_pos_brill_path_max(s : NlpposbrillPath) -> Double { @_common.max(s.data) }

pub fn nlp_pos_brill_path_to_string(s : NlpposbrillPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpposbrillCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_brill_cluster_make(size : Int) -> NlpposbrillCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_brill_cluster_len(s : NlpposbrillCluster) -> Int { s.size }

pub fn nlp_pos_brill_cluster_get(s : NlpposbrillCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_brill_cluster_set(s : NlpposbrillCluster, i : Int, v : Double) -> NlpposbrillCluster {
  let result = nlp_pos_brill_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_brill_cluster_sum(s : NlpposbrillCluster) -> Double { @_common.sum(s.data) }

pub fn nlp_pos_brill_cluster_mean(s : NlpposbrillCluster) -> Double { @_common.mean(s.data) }

pub fn nlp_pos_brill_cluster_scale(s : NlpposbrillCluster, f : Double) -> NlpposbrillCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_pos_brill_cluster_add(a : NlpposbrillCluster, b : NlpposbrillCluster) -> NlpposbrillCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_pos_brill_cluster_copy(s : NlpposbrillCluster) -> NlpposbrillCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_pos_brill_cluster_fill(s : NlpposbrillCluster, v : Double) -> NlpposbrillCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_pos_brill_cluster_min(s : NlpposbrillCluster) -> Double { @_common.min(s.data) }

pub fn nlp_pos_brill_cluster_max(s : NlpposbrillCluster) -> Double { @_common.max(s.data) }

pub fn nlp_pos_brill_cluster_to_string(s : NlpposbrillCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpposbrillModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_brill_model_make(size : Int) -> NlpposbrillModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_brill_model_len(s : NlpposbrillModel) -> Int { s.size }

pub fn nlp_pos_brill_model_get(s : NlpposbrillModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_brill_model_set(s : NlpposbrillModel, i : Int, v : Double) -> NlpposbrillModel {
  let result = nlp_pos_brill_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_brill_model_sum(s : NlpposbrillModel) -> Double { @_common.sum(s.data) }

pub fn nlp_pos_brill_model_mean(s : NlpposbrillModel) -> Double { @_common.mean(s.data) }

pub fn nlp_pos_brill_model_scale(s : NlpposbrillModel, f : Double) -> NlpposbrillModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_pos_brill_model_add(a : NlpposbrillModel, b : NlpposbrillModel) -> NlpposbrillModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_pos_brill_model_copy(s : NlpposbrillModel) -> NlpposbrillModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_pos_brill_model_fill(s : NlpposbrillModel, v : Double) -> NlpposbrillModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_pos_brill_model_min(s : NlpposbrillModel) -> Double { @_common.min(s.data) }

pub fn nlp_pos_brill_model_max(s : NlpposbrillModel) -> Double { @_common.max(s.data) }

pub fn nlp_pos_brill_model_to_string(s : NlpposbrillModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpposbrillLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_brill_layer_make(size : Int) -> NlpposbrillLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_brill_layer_len(s : NlpposbrillLayer) -> Int { s.size }

pub fn nlp_pos_brill_layer_get(s : NlpposbrillLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_brill_layer_set(s : NlpposbrillLayer, i : Int, v : Double) -> NlpposbrillLayer {
  let result = nlp_pos_brill_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_brill_layer_sum(s : NlpposbrillLayer) -> Double { @_common.sum(s.data) }

pub fn nlp_pos_brill_layer_mean(s : NlpposbrillLayer) -> Double { @_common.mean(s.data) }

pub fn nlp_pos_brill_layer_scale(s : NlpposbrillLayer, f : Double) -> NlpposbrillLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_pos_brill_layer_add(a : NlpposbrillLayer, b : NlpposbrillLayer) -> NlpposbrillLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_pos_brill_layer_copy(s : NlpposbrillLayer) -> NlpposbrillLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_pos_brill_layer_fill(s : NlpposbrillLayer, v : Double) -> NlpposbrillLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_pos_brill_layer_min(s : NlpposbrillLayer) -> Double { @_common.min(s.data) }

pub fn nlp_pos_brill_layer_max(s : NlpposbrillLayer) -> Double { @_common.max(s.data) }

pub fn nlp_pos_brill_layer_to_string(s : NlpposbrillLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpposbrillBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_brill_buffer_make(size : Int) -> NlpposbrillBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_brill_buffer_len(s : NlpposbrillBuffer) -> Int { s.size }

pub fn nlp_pos_brill_buffer_get(s : NlpposbrillBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_brill_buffer_set(s : NlpposbrillBuffer, i : Int, v : Double) -> NlpposbrillBuffer {
  let result = nlp_pos_brill_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_brill_buffer_sum(s : NlpposbrillBuffer) -> Double { @_common.sum(s.data) }

pub fn nlp_pos_brill_buffer_mean(s : NlpposbrillBuffer) -> Double { @_common.mean(s.data) }

pub fn nlp_pos_brill_buffer_scale(s : NlpposbrillBuffer, f : Double) -> NlpposbrillBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_pos_brill_buffer_add(a : NlpposbrillBuffer, b : NlpposbrillBuffer) -> NlpposbrillBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_pos_brill_buffer_copy(s : NlpposbrillBuffer) -> NlpposbrillBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_pos_brill_buffer_fill(s : NlpposbrillBuffer, v : Double) -> NlpposbrillBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_pos_brill_buffer_min(s : NlpposbrillBuffer) -> Double { @_common.min(s.data) }

pub fn nlp_pos_brill_buffer_max(s : NlpposbrillBuffer) -> Double { @_common.max(s.data) }

pub fn nlp_pos_brill_buffer_to_string(s : NlpposbrillBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpposbrillCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_brill_cursor_make(size : Int) -> NlpposbrillCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_brill_cursor_len(s : NlpposbrillCursor) -> Int { s.size }

pub fn nlp_pos_brill_cursor_get(s : NlpposbrillCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_brill_cursor_set(s : NlpposbrillCursor, i : Int, v : Double) -> NlpposbrillCursor {
  let result = nlp_pos_brill_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_brill_cursor_sum(s : NlpposbrillCursor) -> Double { @_common.sum(s.data) }

pub fn nlp_pos_brill_cursor_mean(s : NlpposbrillCursor) -> Double { @_common.mean(s.data) }

pub fn nlp_pos_brill_cursor_scale(s : NlpposbrillCursor, f : Double) -> NlpposbrillCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_pos_brill_cursor_add(a : NlpposbrillCursor, b : NlpposbrillCursor) -> NlpposbrillCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_pos_brill_cursor_copy(s : NlpposbrillCursor) -> NlpposbrillCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_pos_brill_cursor_fill(s : NlpposbrillCursor, v : Double) -> NlpposbrillCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_pos_brill_cursor_min(s : NlpposbrillCursor) -> Double { @_common.min(s.data) }

pub fn nlp_pos_brill_cursor_max(s : NlpposbrillCursor) -> Double { @_common.max(s.data) }

pub fn nlp_pos_brill_cursor_to_string(s : NlpposbrillCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpposbrillView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_brill_view_make(size : Int) -> NlpposbrillView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_brill_view_len(s : NlpposbrillView) -> Int { s.size }

pub fn nlp_pos_brill_view_get(s : NlpposbrillView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_brill_view_set(s : NlpposbrillView, i : Int, v : Double) -> NlpposbrillView {
  let result = nlp_pos_brill_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_brill_view_sum(s : NlpposbrillView) -> Double { @_common.sum(s.data) }

pub fn nlp_pos_brill_view_mean(s : NlpposbrillView) -> Double { @_common.mean(s.data) }

pub fn nlp_pos_brill_view_scale(s : NlpposbrillView, f : Double) -> NlpposbrillView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_pos_brill_view_add(a : NlpposbrillView, b : NlpposbrillView) -> NlpposbrillView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_pos_brill_view_copy(s : NlpposbrillView) -> NlpposbrillView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_pos_brill_view_fill(s : NlpposbrillView, v : Double) -> NlpposbrillView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_pos_brill_view_min(s : NlpposbrillView) -> Double { @_common.min(s.data) }

pub fn nlp_pos_brill_view_max(s : NlpposbrillView) -> Double { @_common.max(s.data) }

pub fn nlp_pos_brill_view_to_string(s : NlpposbrillView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpposbrillRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_brill_range_make(size : Int) -> NlpposbrillRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_brill_range_len(s : NlpposbrillRange) -> Int { s.size }

pub fn nlp_pos_brill_range_get(s : NlpposbrillRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_brill_range_set(s : NlpposbrillRange, i : Int, v : Double) -> NlpposbrillRange {
  let result = nlp_pos_brill_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_brill_range_sum(s : NlpposbrillRange) -> Double { @_common.sum(s.data) }

pub fn nlp_pos_brill_range_mean(s : NlpposbrillRange) -> Double { @_common.mean(s.data) }

pub fn nlp_pos_brill_range_scale(s : NlpposbrillRange, f : Double) -> NlpposbrillRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_pos_brill_range_add(a : NlpposbrillRange, b : NlpposbrillRange) -> NlpposbrillRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_pos_brill_range_copy(s : NlpposbrillRange) -> NlpposbrillRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_pos_brill_range_fill(s : NlpposbrillRange, v : Double) -> NlpposbrillRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_pos_brill_range_min(s : NlpposbrillRange) -> Double { @_common.min(s.data) }

pub fn nlp_pos_brill_range_max(s : NlpposbrillRange) -> Double { @_common.max(s.data) }

pub fn nlp_pos_brill_range_to_string(s : NlpposbrillRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpposbrillSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_brill_slice_make(size : Int) -> NlpposbrillSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_brill_slice_len(s : NlpposbrillSlice) -> Int { s.size }

pub fn nlp_pos_brill_slice_get(s : NlpposbrillSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_brill_slice_set(s : NlpposbrillSlice, i : Int, v : Double) -> NlpposbrillSlice {
  let result = nlp_pos_brill_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_brill_slice_sum(s : NlpposbrillSlice) -> Double { @_common.sum(s.data) }

pub fn nlp_pos_brill_slice_mean(s : NlpposbrillSlice) -> Double { @_common.mean(s.data) }

pub fn nlp_pos_brill_slice_scale(s : NlpposbrillSlice, f : Double) -> NlpposbrillSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_pos_brill_slice_add(a : NlpposbrillSlice, b : NlpposbrillSlice) -> NlpposbrillSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_pos_brill_slice_copy(s : NlpposbrillSlice) -> NlpposbrillSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_pos_brill_slice_fill(s : NlpposbrillSlice, v : Double) -> NlpposbrillSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_pos_brill_slice_min(s : NlpposbrillSlice) -> Double { @_common.min(s.data) }

pub fn nlp_pos_brill_slice_max(s : NlpposbrillSlice) -> Double { @_common.max(s.data) }

pub fn nlp_pos_brill_slice_to_string(s : NlpposbrillSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

