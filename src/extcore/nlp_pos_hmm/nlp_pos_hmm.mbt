///===
/// extcore/nlp_pos_hmm

pub(all) struct NlpposhmmPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn nlp_pos_hmm_make_point(x : Double, y : Double) -> NlpposhmmPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn nlp_pos_hmm_make_point3(x : Double, y : Double, z : Double) -> NlpposhmmPoint {
  { x, y, z, label: 0 }
}

pub fn nlp_pos_hmm_point_x(pt : NlpposhmmPoint) -> Double { pt.x }

pub fn nlp_pos_hmm_point_y(pt : NlpposhmmPoint) -> Double { pt.y }

pub fn nlp_pos_hmm_point_z(pt : NlpposhmmPoint) -> Double { pt.z }

pub fn nlp_pos_hmm_point_label(pt : NlpposhmmPoint) -> Int { pt.label }

pub fn nlp_pos_hmm_point_dist(a : NlpposhmmPoint, b : NlpposhmmPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn nlp_pos_hmm_point_add(a : NlpposhmmPoint, b : NlpposhmmPoint) -> NlpposhmmPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn nlp_pos_hmm_point_sub(a : NlpposhmmPoint, b : NlpposhmmPoint) -> NlpposhmmPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn nlp_pos_hmm_point_scale(pt : NlpposhmmPoint, s : Double) -> NlpposhmmPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn nlp_pos_hmm_point_dot(a : NlpposhmmPoint, b : NlpposhmmPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn nlp_pos_hmm_point_cross(a : NlpposhmmPoint, b : NlpposhmmPoint) -> NlpposhmmPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn nlp_pos_hmm_point_norm(pt : NlpposhmmPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn nlp_pos_hmm_point_normalize(pt : NlpposhmmPoint) -> NlpposhmmPoint {
  let n = nlp_pos_hmm_point_norm(pt)
  if n < 0.0000001 { pt } else { nlp_pos_hmm_point_scale(pt, 1.0 / n) }
}

pub fn nlp_pos_hmm_point_negate(pt : NlpposhmmPoint) -> NlpposhmmPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn nlp_pos_hmm_point_mid(a : NlpposhmmPoint, b : NlpposhmmPoint) -> NlpposhmmPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn nlp_pos_hmm_point_lerp(a : NlpposhmmPoint, b : NlpposhmmPoint, t : Double) -> NlpposhmmPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn nlp_pos_hmm_point_to_string(pt : NlpposhmmPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct NlpposhmmSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn nlp_pos_hmm_make_series(vals : Array[Double], name : String) -> NlpposhmmSeries {
  { vals, name, meta: 0 }
}

pub fn nlp_pos_hmm_series_len(s : NlpposhmmSeries) -> Int { s.vals.length() }

pub fn nlp_pos_hmm_series_sum(s : NlpposhmmSeries) -> Double { @_common.sum(s.vals) }

pub fn nlp_pos_hmm_series_mean(s : NlpposhmmSeries) -> Double { @_common.mean(s.vals) }

pub fn nlp_pos_hmm_series_min(s : NlpposhmmSeries) -> Double { @_common.min(s.vals) }

pub fn nlp_pos_hmm_series_max(s : NlpposhmmSeries) -> Double { @_common.max(s.vals) }

pub fn nlp_pos_hmm_series_range(s : NlpposhmmSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn nlp_pos_hmm_series_var(s : NlpposhmmSeries) -> Double { @_common.variance(s.vals) }

pub fn nlp_pos_hmm_series_std(s : NlpposhmmSeries) -> Double { @_common.std(s.vals) }

pub fn nlp_pos_hmm_series_median(s : NlpposhmmSeries) -> Double { @_common.median(s.vals) }

pub fn nlp_pos_hmm_series_scale(s : NlpposhmmSeries, f : Double) -> NlpposhmmSeries {
  { vals: @_common.scale_arr(s.vals, f), name: s.name, meta: s.meta }
}

pub fn nlp_pos_hmm_series_add(a : NlpposhmmSeries, b : NlpposhmmSeries) -> NlpposhmmSeries {
  { vals: @_common.add_arr(a.vals, b.vals), name: a.name + "+" + b.name, meta: a.meta }
}

pub fn nlp_pos_hmm_series_sub(a : NlpposhmmSeries, b : NlpposhmmSeries) -> NlpposhmmSeries {
  { vals: @_common.sub_arr(a.vals, b.vals), name: a.name + "-" + b.name, meta: a.meta }
}

pub fn nlp_pos_hmm_series_normalize(s : NlpposhmmSeries) -> NlpposhmmSeries {
  let mn = nlp_pos_hmm_series_min(s)
  let mx = nlp_pos_hmm_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn nlp_pos_hmm_series_cumsum(s : NlpposhmmSeries) -> NlpposhmmSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn nlp_pos_hmm_series_to_string(s : NlpposhmmSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NlpposhmmMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn nlp_pos_hmm_make_matrix(rows : Int, cols : Int, val : Double) -> NlpposhmmMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn nlp_pos_hmm_matrix_identity(n : Int) -> NlpposhmmMatrix {
  let m = nlp_pos_hmm_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn nlp_pos_hmm_matrix_get(m : NlpposhmmMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn nlp_pos_hmm_matrix_transpose(m : NlpposhmmMatrix) -> NlpposhmmMatrix {
  let result = nlp_pos_hmm_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn nlp_pos_hmm_matrix_add(a : NlpposhmmMatrix, b : NlpposhmmMatrix) -> NlpposhmmMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = nlp_pos_hmm_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn nlp_pos_hmm_matrix_scale(m : NlpposhmmMatrix, s : Double) -> NlpposhmmMatrix {
  let result = nlp_pos_hmm_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn nlp_pos_hmm_matrix_multiply(a : NlpposhmmMatrix, b : NlpposhmmMatrix) -> NlpposhmmMatrix {
  if a.cols != b.rows { return nlp_pos_hmm_make_matrix(a.rows, b.cols, 0.0) }
  let result = nlp_pos_hmm_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn nlp_pos_hmm_matrix_trace(m : NlpposhmmMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn nlp_pos_hmm_matrix_det(m : NlpposhmmMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn nlp_pos_hmm_matrix_norm(m : NlpposhmmMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn nlp_pos_hmm_matrix_to_string(m : NlpposhmmMatrix) -> String {
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

pub(all) struct NlpposhmmVector {
  comps : Array[Double]
  dim : Int
}

pub fn nlp_pos_hmm_make_vector(comps : Array[Double]) -> NlpposhmmVector {
  { comps, dim: comps.length() }
}

pub fn nlp_pos_hmm_vector_zero(dim : Int) -> NlpposhmmVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn nlp_pos_hmm_vector_add(a : NlpposhmmVector, b : NlpposhmmVector) -> NlpposhmmVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.add_arr(a.comps, b.comps), dim: n }
}

pub fn nlp_pos_hmm_vector_sub(a : NlpposhmmVector, b : NlpposhmmVector) -> NlpposhmmVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.sub_arr(a.comps, b.comps), dim: n }
}

pub fn nlp_pos_hmm_vector_scale(v : NlpposhmmVector, s : Double) -> NlpposhmmVector {
  { comps: @_common.scale_arr(v.comps, s), dim: v.dim }
}

pub fn nlp_pos_hmm_vector_dot(a : NlpposhmmVector, b : NlpposhmmVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn nlp_pos_hmm_vector_norm(v : NlpposhmmVector) -> Double { @_common.sqrt(nlp_pos_hmm_vector_dot(v, v)) }

pub fn nlp_pos_hmm_vector_normalize(v : NlpposhmmVector) -> NlpposhmmVector {
  let n = nlp_pos_hmm_vector_norm(v)
  if n < 0.0000001 { v } else { nlp_pos_hmm_vector_scale(v, 1.0 / n) }
}

pub fn nlp_pos_hmm_vector_dist(a : NlpposhmmVector, b : NlpposhmmVector) -> Double {
  nlp_pos_hmm_vector_norm(nlp_pos_hmm_vector_sub(a, b))
}

pub fn nlp_pos_hmm_vector_to_string(v : NlpposhmmVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn nlp_pos_hmm_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn nlp_pos_hmm_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn nlp_pos_hmm_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn nlp_pos_hmm_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn nlp_pos_hmm_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn nlp_pos_hmm_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn nlp_pos_hmm_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn nlp_pos_hmm_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn nlp_pos_hmm_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn nlp_pos_hmm_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn nlp_pos_hmm_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn nlp_pos_hmm_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn nlp_pos_hmm_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn nlp_pos_hmm_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn nlp_pos_hmm_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn nlp_pos_hmm_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn nlp_pos_hmm_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn nlp_pos_hmm_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn nlp_pos_hmm_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn nlp_pos_hmm_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn nlp_pos_hmm_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn nlp_pos_hmm_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn nlp_pos_hmm_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn nlp_pos_hmm_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn nlp_pos_hmm_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn nlp_pos_hmm_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn nlp_pos_hmm_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn nlp_pos_hmm_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn nlp_pos_hmm_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct NlpposhmmFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_hmm_frame_make(size : Int) -> NlpposhmmFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_hmm_frame_len(s : NlpposhmmFrame) -> Int { s.size }

pub fn nlp_pos_hmm_frame_get(s : NlpposhmmFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_hmm_frame_set(s : NlpposhmmFrame, i : Int, v : Double) -> NlpposhmmFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_pos_hmm_frame_sum(s : NlpposhmmFrame) -> Double { @_common.sum(s.data) }

pub fn nlp_pos_hmm_frame_mean(s : NlpposhmmFrame) -> Double { @_common.mean(s.data) }

pub fn nlp_pos_hmm_frame_scale(s : NlpposhmmFrame, f : Double) -> NlpposhmmFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_pos_hmm_frame_add(a : NlpposhmmFrame, b : NlpposhmmFrame) -> NlpposhmmFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_pos_hmm_frame_copy(s : NlpposhmmFrame) -> NlpposhmmFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_pos_hmm_frame_fill(s : NlpposhmmFrame, v : Double) -> NlpposhmmFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_pos_hmm_frame_min(s : NlpposhmmFrame) -> Double { @_common.min(s.data) }

pub fn nlp_pos_hmm_frame_max(s : NlpposhmmFrame) -> Double { @_common.max(s.data) }

pub fn nlp_pos_hmm_frame_to_string(s : NlpposhmmFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpposhmmTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_hmm_table_make(size : Int) -> NlpposhmmTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_hmm_table_len(s : NlpposhmmTable) -> Int { s.size }

pub fn nlp_pos_hmm_table_get(s : NlpposhmmTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_hmm_table_set(s : NlpposhmmTable, i : Int, v : Double) -> NlpposhmmTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_pos_hmm_table_sum(s : NlpposhmmTable) -> Double { @_common.sum(s.data) }

pub fn nlp_pos_hmm_table_mean(s : NlpposhmmTable) -> Double { @_common.mean(s.data) }

pub fn nlp_pos_hmm_table_scale(s : NlpposhmmTable, f : Double) -> NlpposhmmTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_pos_hmm_table_add(a : NlpposhmmTable, b : NlpposhmmTable) -> NlpposhmmTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_pos_hmm_table_copy(s : NlpposhmmTable) -> NlpposhmmTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_pos_hmm_table_fill(s : NlpposhmmTable, v : Double) -> NlpposhmmTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_pos_hmm_table_min(s : NlpposhmmTable) -> Double { @_common.min(s.data) }

pub fn nlp_pos_hmm_table_max(s : NlpposhmmTable) -> Double { @_common.max(s.data) }

pub fn nlp_pos_hmm_table_to_string(s : NlpposhmmTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpposhmmGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_hmm_graphn_make(size : Int) -> NlpposhmmGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_hmm_graphn_len(s : NlpposhmmGraphN) -> Int { s.size }

pub fn nlp_pos_hmm_graphn_get(s : NlpposhmmGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_hmm_graphn_set(s : NlpposhmmGraphN, i : Int, v : Double) -> NlpposhmmGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_pos_hmm_graphn_sum(s : NlpposhmmGraphN) -> Double { @_common.sum(s.data) }

pub fn nlp_pos_hmm_graphn_mean(s : NlpposhmmGraphN) -> Double { @_common.mean(s.data) }

pub fn nlp_pos_hmm_graphn_scale(s : NlpposhmmGraphN, f : Double) -> NlpposhmmGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_pos_hmm_graphn_add(a : NlpposhmmGraphN, b : NlpposhmmGraphN) -> NlpposhmmGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_pos_hmm_graphn_copy(s : NlpposhmmGraphN) -> NlpposhmmGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_pos_hmm_graphn_fill(s : NlpposhmmGraphN, v : Double) -> NlpposhmmGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_pos_hmm_graphn_min(s : NlpposhmmGraphN) -> Double { @_common.min(s.data) }

pub fn nlp_pos_hmm_graphn_max(s : NlpposhmmGraphN) -> Double { @_common.max(s.data) }

pub fn nlp_pos_hmm_graphn_to_string(s : NlpposhmmGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpposhmmNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_hmm_node_make(size : Int) -> NlpposhmmNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_hmm_node_len(s : NlpposhmmNode) -> Int { s.size }

pub fn nlp_pos_hmm_node_get(s : NlpposhmmNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_hmm_node_set(s : NlpposhmmNode, i : Int, v : Double) -> NlpposhmmNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_pos_hmm_node_sum(s : NlpposhmmNode) -> Double { @_common.sum(s.data) }

pub fn nlp_pos_hmm_node_mean(s : NlpposhmmNode) -> Double { @_common.mean(s.data) }

pub fn nlp_pos_hmm_node_scale(s : NlpposhmmNode, f : Double) -> NlpposhmmNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_pos_hmm_node_add(a : NlpposhmmNode, b : NlpposhmmNode) -> NlpposhmmNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_pos_hmm_node_copy(s : NlpposhmmNode) -> NlpposhmmNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_pos_hmm_node_fill(s : NlpposhmmNode, v : Double) -> NlpposhmmNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_pos_hmm_node_min(s : NlpposhmmNode) -> Double { @_common.min(s.data) }

pub fn nlp_pos_hmm_node_max(s : NlpposhmmNode) -> Double { @_common.max(s.data) }

pub fn nlp_pos_hmm_node_to_string(s : NlpposhmmNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpposhmmEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_hmm_edge_make(size : Int) -> NlpposhmmEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_hmm_edge_len(s : NlpposhmmEdge) -> Int { s.size }

pub fn nlp_pos_hmm_edge_get(s : NlpposhmmEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_hmm_edge_set(s : NlpposhmmEdge, i : Int, v : Double) -> NlpposhmmEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_pos_hmm_edge_sum(s : NlpposhmmEdge) -> Double { @_common.sum(s.data) }

pub fn nlp_pos_hmm_edge_mean(s : NlpposhmmEdge) -> Double { @_common.mean(s.data) }

pub fn nlp_pos_hmm_edge_scale(s : NlpposhmmEdge, f : Double) -> NlpposhmmEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_pos_hmm_edge_add(a : NlpposhmmEdge, b : NlpposhmmEdge) -> NlpposhmmEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_pos_hmm_edge_copy(s : NlpposhmmEdge) -> NlpposhmmEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_pos_hmm_edge_fill(s : NlpposhmmEdge, v : Double) -> NlpposhmmEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_pos_hmm_edge_min(s : NlpposhmmEdge) -> Double { @_common.min(s.data) }

pub fn nlp_pos_hmm_edge_max(s : NlpposhmmEdge) -> Double { @_common.max(s.data) }

pub fn nlp_pos_hmm_edge_to_string(s : NlpposhmmEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpposhmmPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_hmm_path_make(size : Int) -> NlpposhmmPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_hmm_path_len(s : NlpposhmmPath) -> Int { s.size }

pub fn nlp_pos_hmm_path_get(s : NlpposhmmPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_hmm_path_set(s : NlpposhmmPath, i : Int, v : Double) -> NlpposhmmPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_pos_hmm_path_sum(s : NlpposhmmPath) -> Double { @_common.sum(s.data) }

pub fn nlp_pos_hmm_path_mean(s : NlpposhmmPath) -> Double { @_common.mean(s.data) }

pub fn nlp_pos_hmm_path_scale(s : NlpposhmmPath, f : Double) -> NlpposhmmPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_pos_hmm_path_add(a : NlpposhmmPath, b : NlpposhmmPath) -> NlpposhmmPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_pos_hmm_path_copy(s : NlpposhmmPath) -> NlpposhmmPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_pos_hmm_path_fill(s : NlpposhmmPath, v : Double) -> NlpposhmmPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_pos_hmm_path_min(s : NlpposhmmPath) -> Double { @_common.min(s.data) }

pub fn nlp_pos_hmm_path_max(s : NlpposhmmPath) -> Double { @_common.max(s.data) }

pub fn nlp_pos_hmm_path_to_string(s : NlpposhmmPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpposhmmCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_hmm_cluster_make(size : Int) -> NlpposhmmCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_hmm_cluster_len(s : NlpposhmmCluster) -> Int { s.size }

pub fn nlp_pos_hmm_cluster_get(s : NlpposhmmCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_hmm_cluster_set(s : NlpposhmmCluster, i : Int, v : Double) -> NlpposhmmCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_pos_hmm_cluster_sum(s : NlpposhmmCluster) -> Double { @_common.sum(s.data) }

pub fn nlp_pos_hmm_cluster_mean(s : NlpposhmmCluster) -> Double { @_common.mean(s.data) }

pub fn nlp_pos_hmm_cluster_scale(s : NlpposhmmCluster, f : Double) -> NlpposhmmCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_pos_hmm_cluster_add(a : NlpposhmmCluster, b : NlpposhmmCluster) -> NlpposhmmCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_pos_hmm_cluster_copy(s : NlpposhmmCluster) -> NlpposhmmCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_pos_hmm_cluster_fill(s : NlpposhmmCluster, v : Double) -> NlpposhmmCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_pos_hmm_cluster_min(s : NlpposhmmCluster) -> Double { @_common.min(s.data) }

pub fn nlp_pos_hmm_cluster_max(s : NlpposhmmCluster) -> Double { @_common.max(s.data) }

pub fn nlp_pos_hmm_cluster_to_string(s : NlpposhmmCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpposhmmModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_hmm_model_make(size : Int) -> NlpposhmmModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_hmm_model_len(s : NlpposhmmModel) -> Int { s.size }

pub fn nlp_pos_hmm_model_get(s : NlpposhmmModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_hmm_model_set(s : NlpposhmmModel, i : Int, v : Double) -> NlpposhmmModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_pos_hmm_model_sum(s : NlpposhmmModel) -> Double { @_common.sum(s.data) }

pub fn nlp_pos_hmm_model_mean(s : NlpposhmmModel) -> Double { @_common.mean(s.data) }

pub fn nlp_pos_hmm_model_scale(s : NlpposhmmModel, f : Double) -> NlpposhmmModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_pos_hmm_model_add(a : NlpposhmmModel, b : NlpposhmmModel) -> NlpposhmmModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_pos_hmm_model_copy(s : NlpposhmmModel) -> NlpposhmmModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_pos_hmm_model_fill(s : NlpposhmmModel, v : Double) -> NlpposhmmModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_pos_hmm_model_min(s : NlpposhmmModel) -> Double { @_common.min(s.data) }

pub fn nlp_pos_hmm_model_max(s : NlpposhmmModel) -> Double { @_common.max(s.data) }

pub fn nlp_pos_hmm_model_to_string(s : NlpposhmmModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpposhmmLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_hmm_layer_make(size : Int) -> NlpposhmmLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_hmm_layer_len(s : NlpposhmmLayer) -> Int { s.size }

pub fn nlp_pos_hmm_layer_get(s : NlpposhmmLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_hmm_layer_set(s : NlpposhmmLayer, i : Int, v : Double) -> NlpposhmmLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_pos_hmm_layer_sum(s : NlpposhmmLayer) -> Double { @_common.sum(s.data) }

pub fn nlp_pos_hmm_layer_mean(s : NlpposhmmLayer) -> Double { @_common.mean(s.data) }

pub fn nlp_pos_hmm_layer_scale(s : NlpposhmmLayer, f : Double) -> NlpposhmmLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_pos_hmm_layer_add(a : NlpposhmmLayer, b : NlpposhmmLayer) -> NlpposhmmLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_pos_hmm_layer_copy(s : NlpposhmmLayer) -> NlpposhmmLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_pos_hmm_layer_fill(s : NlpposhmmLayer, v : Double) -> NlpposhmmLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_pos_hmm_layer_min(s : NlpposhmmLayer) -> Double { @_common.min(s.data) }

pub fn nlp_pos_hmm_layer_max(s : NlpposhmmLayer) -> Double { @_common.max(s.data) }

pub fn nlp_pos_hmm_layer_to_string(s : NlpposhmmLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpposhmmBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_hmm_buffer_make(size : Int) -> NlpposhmmBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_hmm_buffer_len(s : NlpposhmmBuffer) -> Int { s.size }

pub fn nlp_pos_hmm_buffer_get(s : NlpposhmmBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_hmm_buffer_set(s : NlpposhmmBuffer, i : Int, v : Double) -> NlpposhmmBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_pos_hmm_buffer_sum(s : NlpposhmmBuffer) -> Double { @_common.sum(s.data) }

pub fn nlp_pos_hmm_buffer_mean(s : NlpposhmmBuffer) -> Double { @_common.mean(s.data) }

pub fn nlp_pos_hmm_buffer_scale(s : NlpposhmmBuffer, f : Double) -> NlpposhmmBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_pos_hmm_buffer_add(a : NlpposhmmBuffer, b : NlpposhmmBuffer) -> NlpposhmmBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_pos_hmm_buffer_copy(s : NlpposhmmBuffer) -> NlpposhmmBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_pos_hmm_buffer_fill(s : NlpposhmmBuffer, v : Double) -> NlpposhmmBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_pos_hmm_buffer_min(s : NlpposhmmBuffer) -> Double { @_common.min(s.data) }

pub fn nlp_pos_hmm_buffer_max(s : NlpposhmmBuffer) -> Double { @_common.max(s.data) }

pub fn nlp_pos_hmm_buffer_to_string(s : NlpposhmmBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpposhmmCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_hmm_cursor_make(size : Int) -> NlpposhmmCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_hmm_cursor_len(s : NlpposhmmCursor) -> Int { s.size }

pub fn nlp_pos_hmm_cursor_get(s : NlpposhmmCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_hmm_cursor_set(s : NlpposhmmCursor, i : Int, v : Double) -> NlpposhmmCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_pos_hmm_cursor_sum(s : NlpposhmmCursor) -> Double { @_common.sum(s.data) }

pub fn nlp_pos_hmm_cursor_mean(s : NlpposhmmCursor) -> Double { @_common.mean(s.data) }

pub fn nlp_pos_hmm_cursor_scale(s : NlpposhmmCursor, f : Double) -> NlpposhmmCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_pos_hmm_cursor_add(a : NlpposhmmCursor, b : NlpposhmmCursor) -> NlpposhmmCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_pos_hmm_cursor_copy(s : NlpposhmmCursor) -> NlpposhmmCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_pos_hmm_cursor_fill(s : NlpposhmmCursor, v : Double) -> NlpposhmmCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_pos_hmm_cursor_min(s : NlpposhmmCursor) -> Double { @_common.min(s.data) }

pub fn nlp_pos_hmm_cursor_max(s : NlpposhmmCursor) -> Double { @_common.max(s.data) }

pub fn nlp_pos_hmm_cursor_to_string(s : NlpposhmmCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpposhmmView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_hmm_view_make(size : Int) -> NlpposhmmView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_hmm_view_len(s : NlpposhmmView) -> Int { s.size }

pub fn nlp_pos_hmm_view_get(s : NlpposhmmView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_hmm_view_set(s : NlpposhmmView, i : Int, v : Double) -> NlpposhmmView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_pos_hmm_view_sum(s : NlpposhmmView) -> Double { @_common.sum(s.data) }

pub fn nlp_pos_hmm_view_mean(s : NlpposhmmView) -> Double { @_common.mean(s.data) }

pub fn nlp_pos_hmm_view_scale(s : NlpposhmmView, f : Double) -> NlpposhmmView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_pos_hmm_view_add(a : NlpposhmmView, b : NlpposhmmView) -> NlpposhmmView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_pos_hmm_view_copy(s : NlpposhmmView) -> NlpposhmmView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_pos_hmm_view_fill(s : NlpposhmmView, v : Double) -> NlpposhmmView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_pos_hmm_view_min(s : NlpposhmmView) -> Double { @_common.min(s.data) }

pub fn nlp_pos_hmm_view_max(s : NlpposhmmView) -> Double { @_common.max(s.data) }

pub fn nlp_pos_hmm_view_to_string(s : NlpposhmmView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpposhmmRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_hmm_range_make(size : Int) -> NlpposhmmRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_hmm_range_len(s : NlpposhmmRange) -> Int { s.size }

pub fn nlp_pos_hmm_range_get(s : NlpposhmmRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_hmm_range_set(s : NlpposhmmRange, i : Int, v : Double) -> NlpposhmmRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_pos_hmm_range_sum(s : NlpposhmmRange) -> Double { @_common.sum(s.data) }

pub fn nlp_pos_hmm_range_mean(s : NlpposhmmRange) -> Double { @_common.mean(s.data) }

pub fn nlp_pos_hmm_range_scale(s : NlpposhmmRange, f : Double) -> NlpposhmmRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_pos_hmm_range_add(a : NlpposhmmRange, b : NlpposhmmRange) -> NlpposhmmRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_pos_hmm_range_copy(s : NlpposhmmRange) -> NlpposhmmRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_pos_hmm_range_fill(s : NlpposhmmRange, v : Double) -> NlpposhmmRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_pos_hmm_range_min(s : NlpposhmmRange) -> Double { @_common.min(s.data) }

pub fn nlp_pos_hmm_range_max(s : NlpposhmmRange) -> Double { @_common.max(s.data) }

pub fn nlp_pos_hmm_range_to_string(s : NlpposhmmRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpposhmmSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_hmm_slice_make(size : Int) -> NlpposhmmSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_hmm_slice_len(s : NlpposhmmSlice) -> Int { s.size }

pub fn nlp_pos_hmm_slice_get(s : NlpposhmmSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_hmm_slice_set(s : NlpposhmmSlice, i : Int, v : Double) -> NlpposhmmSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_pos_hmm_slice_sum(s : NlpposhmmSlice) -> Double { @_common.sum(s.data) }

pub fn nlp_pos_hmm_slice_mean(s : NlpposhmmSlice) -> Double { @_common.mean(s.data) }

pub fn nlp_pos_hmm_slice_scale(s : NlpposhmmSlice, f : Double) -> NlpposhmmSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_pos_hmm_slice_add(a : NlpposhmmSlice, b : NlpposhmmSlice) -> NlpposhmmSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_pos_hmm_slice_copy(s : NlpposhmmSlice) -> NlpposhmmSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_pos_hmm_slice_fill(s : NlpposhmmSlice, v : Double) -> NlpposhmmSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_pos_hmm_slice_min(s : NlpposhmmSlice) -> Double { @_common.min(s.data) }

pub fn nlp_pos_hmm_slice_max(s : NlpposhmmSlice) -> Double { @_common.max(s.data) }

pub fn nlp_pos_hmm_slice_to_string(s : NlpposhmmSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

