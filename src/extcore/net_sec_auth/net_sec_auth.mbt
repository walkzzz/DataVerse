///===
/// extcore/net_sec_auth

pub(all) struct NetsecauthPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn net_sec_auth_make_point(x : Double, y : Double) -> NetsecauthPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn net_sec_auth_make_point3(x : Double, y : Double, z : Double) -> NetsecauthPoint {
  { x, y, z, label: 0 }
}

pub fn net_sec_auth_point_x(pt : NetsecauthPoint) -> Double { pt.x }

pub fn net_sec_auth_point_y(pt : NetsecauthPoint) -> Double { pt.y }

pub fn net_sec_auth_point_z(pt : NetsecauthPoint) -> Double { pt.z }

pub fn net_sec_auth_point_label(pt : NetsecauthPoint) -> Int { pt.label }

pub fn net_sec_auth_point_dist(a : NetsecauthPoint, b : NetsecauthPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn net_sec_auth_point_add(a : NetsecauthPoint, b : NetsecauthPoint) -> NetsecauthPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn net_sec_auth_point_sub(a : NetsecauthPoint, b : NetsecauthPoint) -> NetsecauthPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn net_sec_auth_point_scale(pt : NetsecauthPoint, s : Double) -> NetsecauthPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn net_sec_auth_point_dot(a : NetsecauthPoint, b : NetsecauthPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn net_sec_auth_point_cross(a : NetsecauthPoint, b : NetsecauthPoint) -> NetsecauthPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn net_sec_auth_point_norm(pt : NetsecauthPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn net_sec_auth_point_normalize(pt : NetsecauthPoint) -> NetsecauthPoint {
  let n = net_sec_auth_point_norm(pt)
  if n < 0.0000001 { pt } else { net_sec_auth_point_scale(pt, 1.0 / n) }
}

pub fn net_sec_auth_point_negate(pt : NetsecauthPoint) -> NetsecauthPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn net_sec_auth_point_mid(a : NetsecauthPoint, b : NetsecauthPoint) -> NetsecauthPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn net_sec_auth_point_lerp(a : NetsecauthPoint, b : NetsecauthPoint, t : Double) -> NetsecauthPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn net_sec_auth_point_to_string(pt : NetsecauthPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct NetsecauthSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn net_sec_auth_make_series(vals : Array[Double], name : String) -> NetsecauthSeries {
  { vals, name, meta: 0 }
}

pub fn net_sec_auth_series_len(s : NetsecauthSeries) -> Int { s.vals.length() }

pub fn net_sec_auth_series_sum(s : NetsecauthSeries) -> Double { @_common.sum(s.vals) }

pub fn net_sec_auth_series_mean(s : NetsecauthSeries) -> Double { @_common.mean(s.vals) }

pub fn net_sec_auth_series_min(s : NetsecauthSeries) -> Double { @_common.min(s.vals) }

pub fn net_sec_auth_series_max(s : NetsecauthSeries) -> Double { @_common.max(s.vals) }

pub fn net_sec_auth_series_range(s : NetsecauthSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn net_sec_auth_series_var(s : NetsecauthSeries) -> Double { @_common.variance(s.vals) }

pub fn net_sec_auth_series_std(s : NetsecauthSeries) -> Double { @_common.std(s.vals) }

pub fn net_sec_auth_series_median(s : NetsecauthSeries) -> Double { @_common.median(s.vals) }

pub fn net_sec_auth_series_scale(s : NetsecauthSeries, f : Double) -> NetsecauthSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn net_sec_auth_series_add(a : NetsecauthSeries, b : NetsecauthSeries) -> NetsecauthSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn net_sec_auth_series_sub(a : NetsecauthSeries, b : NetsecauthSeries) -> NetsecauthSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn net_sec_auth_series_normalize(s : NetsecauthSeries) -> NetsecauthSeries {
  let mn = net_sec_auth_series_min(s)
  let mx = net_sec_auth_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn net_sec_auth_series_cumsum(s : NetsecauthSeries) -> NetsecauthSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn net_sec_auth_series_to_string(s : NetsecauthSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NetsecauthMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn net_sec_auth_make_matrix(rows : Int, cols : Int, val : Double) -> NetsecauthMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn net_sec_auth_matrix_identity(n : Int) -> NetsecauthMatrix {
  let m = net_sec_auth_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn net_sec_auth_matrix_get(m : NetsecauthMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn net_sec_auth_matrix_transpose(m : NetsecauthMatrix) -> NetsecauthMatrix {
  let result = net_sec_auth_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn net_sec_auth_matrix_add(a : NetsecauthMatrix, b : NetsecauthMatrix) -> NetsecauthMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = net_sec_auth_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn net_sec_auth_matrix_scale(m : NetsecauthMatrix, s : Double) -> NetsecauthMatrix {
  let result = net_sec_auth_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn net_sec_auth_matrix_multiply(a : NetsecauthMatrix, b : NetsecauthMatrix) -> NetsecauthMatrix {
  if a.cols != b.rows { return net_sec_auth_make_matrix(a.rows, b.cols, 0.0) }
  let result = net_sec_auth_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn net_sec_auth_matrix_trace(m : NetsecauthMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn net_sec_auth_matrix_det(m : NetsecauthMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn net_sec_auth_matrix_norm(m : NetsecauthMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn net_sec_auth_matrix_to_string(m : NetsecauthMatrix) -> String {
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

pub(all) struct NetsecauthVector {
  comps : Array[Double]
  dim : Int
}

pub fn net_sec_auth_make_vector(comps : Array[Double]) -> NetsecauthVector {
  { comps, dim: comps.length() }
}

pub fn net_sec_auth_vector_zero(dim : Int) -> NetsecauthVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn net_sec_auth_vector_add(a : NetsecauthVector, b : NetsecauthVector) -> NetsecauthVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn net_sec_auth_vector_sub(a : NetsecauthVector, b : NetsecauthVector) -> NetsecauthVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn net_sec_auth_vector_scale(v : NetsecauthVector, s : Double) -> NetsecauthVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn net_sec_auth_vector_dot(a : NetsecauthVector, b : NetsecauthVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn net_sec_auth_vector_norm(v : NetsecauthVector) -> Double { @_common.sqrt(net_sec_auth_vector_dot(v, v)) }

pub fn net_sec_auth_vector_normalize(v : NetsecauthVector) -> NetsecauthVector {
  let n = net_sec_auth_vector_norm(v)
  if n < 0.0000001 { v } else { net_sec_auth_vector_scale(v, 1.0 / n) }
}

pub fn net_sec_auth_vector_dist(a : NetsecauthVector, b : NetsecauthVector) -> Double {
  net_sec_auth_vector_norm(net_sec_auth_vector_sub(a, b))
}

pub fn net_sec_auth_vector_to_string(v : NetsecauthVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn net_sec_auth_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn net_sec_auth_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn net_sec_auth_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn net_sec_auth_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn net_sec_auth_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn net_sec_auth_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn net_sec_auth_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn net_sec_auth_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn net_sec_auth_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn net_sec_auth_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn net_sec_auth_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn net_sec_auth_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn net_sec_auth_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn net_sec_auth_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn net_sec_auth_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn net_sec_auth_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn net_sec_auth_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn net_sec_auth_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn net_sec_auth_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn net_sec_auth_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn net_sec_auth_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn net_sec_auth_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn net_sec_auth_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn net_sec_auth_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn net_sec_auth_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn net_sec_auth_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn net_sec_auth_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn net_sec_auth_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn net_sec_auth_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct NetsecauthFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_auth_frame_make(size : Int) -> NetsecauthFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_auth_frame_len(s : NetsecauthFrame) -> Int { s.size }

pub fn net_sec_auth_frame_get(s : NetsecauthFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_auth_frame_set(s : NetsecauthFrame, i : Int, v : Double) -> NetsecauthFrame {
  let result = net_sec_auth_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_sec_auth_frame_sum(s : NetsecauthFrame) -> Double { @_common.sum(s.data) }

pub fn net_sec_auth_frame_mean(s : NetsecauthFrame) -> Double { @_common.mean(s.data) }

pub fn net_sec_auth_frame_scale(s : NetsecauthFrame, f : Double) -> NetsecauthFrame {
  let result = net_sec_auth_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_sec_auth_frame_add(a : NetsecauthFrame, b : NetsecauthFrame) -> NetsecauthFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_sec_auth_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_sec_auth_frame_copy(s : NetsecauthFrame) -> NetsecauthFrame {
  let result = net_sec_auth_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_sec_auth_frame_fill(s : NetsecauthFrame, v : Double) -> NetsecauthFrame {
  let result = net_sec_auth_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_sec_auth_frame_min(s : NetsecauthFrame) -> Double { @_common.min(s.data) }

pub fn net_sec_auth_frame_max(s : NetsecauthFrame) -> Double { @_common.max(s.data) }

pub fn net_sec_auth_frame_to_string(s : NetsecauthFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecauthTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_auth_table_make(size : Int) -> NetsecauthTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_auth_table_len(s : NetsecauthTable) -> Int { s.size }

pub fn net_sec_auth_table_get(s : NetsecauthTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_auth_table_set(s : NetsecauthTable, i : Int, v : Double) -> NetsecauthTable {
  let result = net_sec_auth_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_sec_auth_table_sum(s : NetsecauthTable) -> Double { @_common.sum(s.data) }

pub fn net_sec_auth_table_mean(s : NetsecauthTable) -> Double { @_common.mean(s.data) }

pub fn net_sec_auth_table_scale(s : NetsecauthTable, f : Double) -> NetsecauthTable {
  let result = net_sec_auth_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_sec_auth_table_add(a : NetsecauthTable, b : NetsecauthTable) -> NetsecauthTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_sec_auth_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_sec_auth_table_copy(s : NetsecauthTable) -> NetsecauthTable {
  let result = net_sec_auth_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_sec_auth_table_fill(s : NetsecauthTable, v : Double) -> NetsecauthTable {
  let result = net_sec_auth_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_sec_auth_table_min(s : NetsecauthTable) -> Double { @_common.min(s.data) }

pub fn net_sec_auth_table_max(s : NetsecauthTable) -> Double { @_common.max(s.data) }

pub fn net_sec_auth_table_to_string(s : NetsecauthTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecauthGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_auth_graphn_make(size : Int) -> NetsecauthGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_auth_graphn_len(s : NetsecauthGraphN) -> Int { s.size }

pub fn net_sec_auth_graphn_get(s : NetsecauthGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_auth_graphn_set(s : NetsecauthGraphN, i : Int, v : Double) -> NetsecauthGraphN {
  let result = net_sec_auth_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_sec_auth_graphn_sum(s : NetsecauthGraphN) -> Double { @_common.sum(s.data) }

pub fn net_sec_auth_graphn_mean(s : NetsecauthGraphN) -> Double { @_common.mean(s.data) }

pub fn net_sec_auth_graphn_scale(s : NetsecauthGraphN, f : Double) -> NetsecauthGraphN {
  let result = net_sec_auth_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_sec_auth_graphn_add(a : NetsecauthGraphN, b : NetsecauthGraphN) -> NetsecauthGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_sec_auth_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_sec_auth_graphn_copy(s : NetsecauthGraphN) -> NetsecauthGraphN {
  let result = net_sec_auth_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_sec_auth_graphn_fill(s : NetsecauthGraphN, v : Double) -> NetsecauthGraphN {
  let result = net_sec_auth_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_sec_auth_graphn_min(s : NetsecauthGraphN) -> Double { @_common.min(s.data) }

pub fn net_sec_auth_graphn_max(s : NetsecauthGraphN) -> Double { @_common.max(s.data) }

pub fn net_sec_auth_graphn_to_string(s : NetsecauthGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecauthNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_auth_node_make(size : Int) -> NetsecauthNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_auth_node_len(s : NetsecauthNode) -> Int { s.size }

pub fn net_sec_auth_node_get(s : NetsecauthNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_auth_node_set(s : NetsecauthNode, i : Int, v : Double) -> NetsecauthNode {
  let result = net_sec_auth_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_sec_auth_node_sum(s : NetsecauthNode) -> Double { @_common.sum(s.data) }

pub fn net_sec_auth_node_mean(s : NetsecauthNode) -> Double { @_common.mean(s.data) }

pub fn net_sec_auth_node_scale(s : NetsecauthNode, f : Double) -> NetsecauthNode {
  let result = net_sec_auth_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_sec_auth_node_add(a : NetsecauthNode, b : NetsecauthNode) -> NetsecauthNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_sec_auth_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_sec_auth_node_copy(s : NetsecauthNode) -> NetsecauthNode {
  let result = net_sec_auth_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_sec_auth_node_fill(s : NetsecauthNode, v : Double) -> NetsecauthNode {
  let result = net_sec_auth_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_sec_auth_node_min(s : NetsecauthNode) -> Double { @_common.min(s.data) }

pub fn net_sec_auth_node_max(s : NetsecauthNode) -> Double { @_common.max(s.data) }

pub fn net_sec_auth_node_to_string(s : NetsecauthNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecauthEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_auth_edge_make(size : Int) -> NetsecauthEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_auth_edge_len(s : NetsecauthEdge) -> Int { s.size }

pub fn net_sec_auth_edge_get(s : NetsecauthEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_auth_edge_set(s : NetsecauthEdge, i : Int, v : Double) -> NetsecauthEdge {
  let result = net_sec_auth_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_sec_auth_edge_sum(s : NetsecauthEdge) -> Double { @_common.sum(s.data) }

pub fn net_sec_auth_edge_mean(s : NetsecauthEdge) -> Double { @_common.mean(s.data) }

pub fn net_sec_auth_edge_scale(s : NetsecauthEdge, f : Double) -> NetsecauthEdge {
  let result = net_sec_auth_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_sec_auth_edge_add(a : NetsecauthEdge, b : NetsecauthEdge) -> NetsecauthEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_sec_auth_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_sec_auth_edge_copy(s : NetsecauthEdge) -> NetsecauthEdge {
  let result = net_sec_auth_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_sec_auth_edge_fill(s : NetsecauthEdge, v : Double) -> NetsecauthEdge {
  let result = net_sec_auth_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_sec_auth_edge_min(s : NetsecauthEdge) -> Double { @_common.min(s.data) }

pub fn net_sec_auth_edge_max(s : NetsecauthEdge) -> Double { @_common.max(s.data) }

pub fn net_sec_auth_edge_to_string(s : NetsecauthEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecauthPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_auth_path_make(size : Int) -> NetsecauthPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_auth_path_len(s : NetsecauthPath) -> Int { s.size }

pub fn net_sec_auth_path_get(s : NetsecauthPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_auth_path_set(s : NetsecauthPath, i : Int, v : Double) -> NetsecauthPath {
  let result = net_sec_auth_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_sec_auth_path_sum(s : NetsecauthPath) -> Double { @_common.sum(s.data) }

pub fn net_sec_auth_path_mean(s : NetsecauthPath) -> Double { @_common.mean(s.data) }

pub fn net_sec_auth_path_scale(s : NetsecauthPath, f : Double) -> NetsecauthPath {
  let result = net_sec_auth_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_sec_auth_path_add(a : NetsecauthPath, b : NetsecauthPath) -> NetsecauthPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_sec_auth_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_sec_auth_path_copy(s : NetsecauthPath) -> NetsecauthPath {
  let result = net_sec_auth_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_sec_auth_path_fill(s : NetsecauthPath, v : Double) -> NetsecauthPath {
  let result = net_sec_auth_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_sec_auth_path_min(s : NetsecauthPath) -> Double { @_common.min(s.data) }

pub fn net_sec_auth_path_max(s : NetsecauthPath) -> Double { @_common.max(s.data) }

pub fn net_sec_auth_path_to_string(s : NetsecauthPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecauthCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_auth_cluster_make(size : Int) -> NetsecauthCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_auth_cluster_len(s : NetsecauthCluster) -> Int { s.size }

pub fn net_sec_auth_cluster_get(s : NetsecauthCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_auth_cluster_set(s : NetsecauthCluster, i : Int, v : Double) -> NetsecauthCluster {
  let result = net_sec_auth_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_sec_auth_cluster_sum(s : NetsecauthCluster) -> Double { @_common.sum(s.data) }

pub fn net_sec_auth_cluster_mean(s : NetsecauthCluster) -> Double { @_common.mean(s.data) }

pub fn net_sec_auth_cluster_scale(s : NetsecauthCluster, f : Double) -> NetsecauthCluster {
  let result = net_sec_auth_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_sec_auth_cluster_add(a : NetsecauthCluster, b : NetsecauthCluster) -> NetsecauthCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_sec_auth_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_sec_auth_cluster_copy(s : NetsecauthCluster) -> NetsecauthCluster {
  let result = net_sec_auth_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_sec_auth_cluster_fill(s : NetsecauthCluster, v : Double) -> NetsecauthCluster {
  let result = net_sec_auth_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_sec_auth_cluster_min(s : NetsecauthCluster) -> Double { @_common.min(s.data) }

pub fn net_sec_auth_cluster_max(s : NetsecauthCluster) -> Double { @_common.max(s.data) }

pub fn net_sec_auth_cluster_to_string(s : NetsecauthCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecauthModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_auth_model_make(size : Int) -> NetsecauthModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_auth_model_len(s : NetsecauthModel) -> Int { s.size }

pub fn net_sec_auth_model_get(s : NetsecauthModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_auth_model_set(s : NetsecauthModel, i : Int, v : Double) -> NetsecauthModel {
  let result = net_sec_auth_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_sec_auth_model_sum(s : NetsecauthModel) -> Double { @_common.sum(s.data) }

pub fn net_sec_auth_model_mean(s : NetsecauthModel) -> Double { @_common.mean(s.data) }

pub fn net_sec_auth_model_scale(s : NetsecauthModel, f : Double) -> NetsecauthModel {
  let result = net_sec_auth_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_sec_auth_model_add(a : NetsecauthModel, b : NetsecauthModel) -> NetsecauthModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_sec_auth_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_sec_auth_model_copy(s : NetsecauthModel) -> NetsecauthModel {
  let result = net_sec_auth_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_sec_auth_model_fill(s : NetsecauthModel, v : Double) -> NetsecauthModel {
  let result = net_sec_auth_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_sec_auth_model_min(s : NetsecauthModel) -> Double { @_common.min(s.data) }

pub fn net_sec_auth_model_max(s : NetsecauthModel) -> Double { @_common.max(s.data) }

pub fn net_sec_auth_model_to_string(s : NetsecauthModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecauthLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_auth_layer_make(size : Int) -> NetsecauthLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_auth_layer_len(s : NetsecauthLayer) -> Int { s.size }

pub fn net_sec_auth_layer_get(s : NetsecauthLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_auth_layer_set(s : NetsecauthLayer, i : Int, v : Double) -> NetsecauthLayer {
  let result = net_sec_auth_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_sec_auth_layer_sum(s : NetsecauthLayer) -> Double { @_common.sum(s.data) }

pub fn net_sec_auth_layer_mean(s : NetsecauthLayer) -> Double { @_common.mean(s.data) }

pub fn net_sec_auth_layer_scale(s : NetsecauthLayer, f : Double) -> NetsecauthLayer {
  let result = net_sec_auth_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_sec_auth_layer_add(a : NetsecauthLayer, b : NetsecauthLayer) -> NetsecauthLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_sec_auth_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_sec_auth_layer_copy(s : NetsecauthLayer) -> NetsecauthLayer {
  let result = net_sec_auth_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_sec_auth_layer_fill(s : NetsecauthLayer, v : Double) -> NetsecauthLayer {
  let result = net_sec_auth_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_sec_auth_layer_min(s : NetsecauthLayer) -> Double { @_common.min(s.data) }

pub fn net_sec_auth_layer_max(s : NetsecauthLayer) -> Double { @_common.max(s.data) }

pub fn net_sec_auth_layer_to_string(s : NetsecauthLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecauthBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_auth_buffer_make(size : Int) -> NetsecauthBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_auth_buffer_len(s : NetsecauthBuffer) -> Int { s.size }

pub fn net_sec_auth_buffer_get(s : NetsecauthBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_auth_buffer_set(s : NetsecauthBuffer, i : Int, v : Double) -> NetsecauthBuffer {
  let result = net_sec_auth_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_sec_auth_buffer_sum(s : NetsecauthBuffer) -> Double { @_common.sum(s.data) }

pub fn net_sec_auth_buffer_mean(s : NetsecauthBuffer) -> Double { @_common.mean(s.data) }

pub fn net_sec_auth_buffer_scale(s : NetsecauthBuffer, f : Double) -> NetsecauthBuffer {
  let result = net_sec_auth_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_sec_auth_buffer_add(a : NetsecauthBuffer, b : NetsecauthBuffer) -> NetsecauthBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_sec_auth_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_sec_auth_buffer_copy(s : NetsecauthBuffer) -> NetsecauthBuffer {
  let result = net_sec_auth_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_sec_auth_buffer_fill(s : NetsecauthBuffer, v : Double) -> NetsecauthBuffer {
  let result = net_sec_auth_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_sec_auth_buffer_min(s : NetsecauthBuffer) -> Double { @_common.min(s.data) }

pub fn net_sec_auth_buffer_max(s : NetsecauthBuffer) -> Double { @_common.max(s.data) }

pub fn net_sec_auth_buffer_to_string(s : NetsecauthBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecauthCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_auth_cursor_make(size : Int) -> NetsecauthCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_auth_cursor_len(s : NetsecauthCursor) -> Int { s.size }

pub fn net_sec_auth_cursor_get(s : NetsecauthCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_auth_cursor_set(s : NetsecauthCursor, i : Int, v : Double) -> NetsecauthCursor {
  let result = net_sec_auth_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_sec_auth_cursor_sum(s : NetsecauthCursor) -> Double { @_common.sum(s.data) }

pub fn net_sec_auth_cursor_mean(s : NetsecauthCursor) -> Double { @_common.mean(s.data) }

pub fn net_sec_auth_cursor_scale(s : NetsecauthCursor, f : Double) -> NetsecauthCursor {
  let result = net_sec_auth_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_sec_auth_cursor_add(a : NetsecauthCursor, b : NetsecauthCursor) -> NetsecauthCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_sec_auth_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_sec_auth_cursor_copy(s : NetsecauthCursor) -> NetsecauthCursor {
  let result = net_sec_auth_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_sec_auth_cursor_fill(s : NetsecauthCursor, v : Double) -> NetsecauthCursor {
  let result = net_sec_auth_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_sec_auth_cursor_min(s : NetsecauthCursor) -> Double { @_common.min(s.data) }

pub fn net_sec_auth_cursor_max(s : NetsecauthCursor) -> Double { @_common.max(s.data) }

pub fn net_sec_auth_cursor_to_string(s : NetsecauthCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecauthView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_auth_view_make(size : Int) -> NetsecauthView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_auth_view_len(s : NetsecauthView) -> Int { s.size }

pub fn net_sec_auth_view_get(s : NetsecauthView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_auth_view_set(s : NetsecauthView, i : Int, v : Double) -> NetsecauthView {
  let result = net_sec_auth_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_sec_auth_view_sum(s : NetsecauthView) -> Double { @_common.sum(s.data) }

pub fn net_sec_auth_view_mean(s : NetsecauthView) -> Double { @_common.mean(s.data) }

pub fn net_sec_auth_view_scale(s : NetsecauthView, f : Double) -> NetsecauthView {
  let result = net_sec_auth_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_sec_auth_view_add(a : NetsecauthView, b : NetsecauthView) -> NetsecauthView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_sec_auth_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_sec_auth_view_copy(s : NetsecauthView) -> NetsecauthView {
  let result = net_sec_auth_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_sec_auth_view_fill(s : NetsecauthView, v : Double) -> NetsecauthView {
  let result = net_sec_auth_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_sec_auth_view_min(s : NetsecauthView) -> Double { @_common.min(s.data) }

pub fn net_sec_auth_view_max(s : NetsecauthView) -> Double { @_common.max(s.data) }

pub fn net_sec_auth_view_to_string(s : NetsecauthView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecauthRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_auth_range_make(size : Int) -> NetsecauthRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_auth_range_len(s : NetsecauthRange) -> Int { s.size }

pub fn net_sec_auth_range_get(s : NetsecauthRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_auth_range_set(s : NetsecauthRange, i : Int, v : Double) -> NetsecauthRange {
  let result = net_sec_auth_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_sec_auth_range_sum(s : NetsecauthRange) -> Double { @_common.sum(s.data) }

pub fn net_sec_auth_range_mean(s : NetsecauthRange) -> Double { @_common.mean(s.data) }

pub fn net_sec_auth_range_scale(s : NetsecauthRange, f : Double) -> NetsecauthRange {
  let result = net_sec_auth_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_sec_auth_range_add(a : NetsecauthRange, b : NetsecauthRange) -> NetsecauthRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_sec_auth_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_sec_auth_range_copy(s : NetsecauthRange) -> NetsecauthRange {
  let result = net_sec_auth_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_sec_auth_range_fill(s : NetsecauthRange, v : Double) -> NetsecauthRange {
  let result = net_sec_auth_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_sec_auth_range_min(s : NetsecauthRange) -> Double { @_common.min(s.data) }

pub fn net_sec_auth_range_max(s : NetsecauthRange) -> Double { @_common.max(s.data) }

pub fn net_sec_auth_range_to_string(s : NetsecauthRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecauthSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_auth_slice_make(size : Int) -> NetsecauthSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_auth_slice_len(s : NetsecauthSlice) -> Int { s.size }

pub fn net_sec_auth_slice_get(s : NetsecauthSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_auth_slice_set(s : NetsecauthSlice, i : Int, v : Double) -> NetsecauthSlice {
  let result = net_sec_auth_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_sec_auth_slice_sum(s : NetsecauthSlice) -> Double { @_common.sum(s.data) }

pub fn net_sec_auth_slice_mean(s : NetsecauthSlice) -> Double { @_common.mean(s.data) }

pub fn net_sec_auth_slice_scale(s : NetsecauthSlice, f : Double) -> NetsecauthSlice {
  let result = net_sec_auth_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_sec_auth_slice_add(a : NetsecauthSlice, b : NetsecauthSlice) -> NetsecauthSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_sec_auth_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_sec_auth_slice_copy(s : NetsecauthSlice) -> NetsecauthSlice {
  let result = net_sec_auth_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_sec_auth_slice_fill(s : NetsecauthSlice, v : Double) -> NetsecauthSlice {
  let result = net_sec_auth_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_sec_auth_slice_min(s : NetsecauthSlice) -> Double { @_common.min(s.data) }

pub fn net_sec_auth_slice_max(s : NetsecauthSlice) -> Double { @_common.max(s.data) }

pub fn net_sec_auth_slice_to_string(s : NetsecauthSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

