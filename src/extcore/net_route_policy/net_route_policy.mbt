///===
/// extcore/net_route_policy

pub(all) struct NetroutepolicyPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn net_route_policy_make_point(x : Double, y : Double) -> NetroutepolicyPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn net_route_policy_make_point3(x : Double, y : Double, z : Double) -> NetroutepolicyPoint {
  { x, y, z, label: 0 }
}

pub fn net_route_policy_point_x(pt : NetroutepolicyPoint) -> Double { pt.x }

pub fn net_route_policy_point_y(pt : NetroutepolicyPoint) -> Double { pt.y }

pub fn net_route_policy_point_z(pt : NetroutepolicyPoint) -> Double { pt.z }

pub fn net_route_policy_point_label(pt : NetroutepolicyPoint) -> Int { pt.label }

pub fn net_route_policy_point_dist(a : NetroutepolicyPoint, b : NetroutepolicyPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn net_route_policy_point_add(a : NetroutepolicyPoint, b : NetroutepolicyPoint) -> NetroutepolicyPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn net_route_policy_point_sub(a : NetroutepolicyPoint, b : NetroutepolicyPoint) -> NetroutepolicyPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn net_route_policy_point_scale(pt : NetroutepolicyPoint, s : Double) -> NetroutepolicyPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn net_route_policy_point_dot(a : NetroutepolicyPoint, b : NetroutepolicyPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn net_route_policy_point_cross(a : NetroutepolicyPoint, b : NetroutepolicyPoint) -> NetroutepolicyPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn net_route_policy_point_norm(pt : NetroutepolicyPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn net_route_policy_point_normalize(pt : NetroutepolicyPoint) -> NetroutepolicyPoint {
  let n = net_route_policy_point_norm(pt)
  if n < 0.0000001 { pt } else { net_route_policy_point_scale(pt, 1.0 / n) }
}

pub fn net_route_policy_point_negate(pt : NetroutepolicyPoint) -> NetroutepolicyPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn net_route_policy_point_mid(a : NetroutepolicyPoint, b : NetroutepolicyPoint) -> NetroutepolicyPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn net_route_policy_point_lerp(a : NetroutepolicyPoint, b : NetroutepolicyPoint, t : Double) -> NetroutepolicyPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn net_route_policy_point_to_string(pt : NetroutepolicyPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct NetroutepolicySeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn net_route_policy_make_series(vals : Array[Double], name : String) -> NetroutepolicySeries {
  { vals, name, meta: 0 }
}

pub fn net_route_policy_series_len(s : NetroutepolicySeries) -> Int { s.vals.length() }

pub fn net_route_policy_series_sum(s : NetroutepolicySeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn net_route_policy_series_mean(s : NetroutepolicySeries) -> Double { @_common.mean(s.vals) }

pub fn net_route_policy_series_min(s : NetroutepolicySeries) -> Double { @_common.min(s.vals) }

pub fn net_route_policy_series_max(s : NetroutepolicySeries) -> Double { @_common.max(s.vals) }

pub fn net_route_policy_series_range(s : NetroutepolicySeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn net_route_policy_series_var(s : NetroutepolicySeries) -> Double { @_common.variance(s.vals) }

pub fn net_route_policy_series_std(s : NetroutepolicySeries) -> Double { @_common.std(s.vals) }

pub fn net_route_policy_series_median(s : NetroutepolicySeries) -> Double { @_common.median(s.vals) }

pub fn net_route_policy_series_scale(s : NetroutepolicySeries, f : Double) -> NetroutepolicySeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn net_route_policy_series_add(a : NetroutepolicySeries, b : NetroutepolicySeries) -> NetroutepolicySeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn net_route_policy_series_sub(a : NetroutepolicySeries, b : NetroutepolicySeries) -> NetroutepolicySeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn net_route_policy_series_normalize(s : NetroutepolicySeries) -> NetroutepolicySeries {
  let mn = net_route_policy_series_min(s)
  let mx = net_route_policy_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn net_route_policy_series_cumsum(s : NetroutepolicySeries) -> NetroutepolicySeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn net_route_policy_series_to_string(s : NetroutepolicySeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NetroutepolicyMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn net_route_policy_make_matrix(rows : Int, cols : Int, val : Double) -> NetroutepolicyMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn net_route_policy_matrix_identity(n : Int) -> NetroutepolicyMatrix {
  let m = net_route_policy_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn net_route_policy_matrix_get(m : NetroutepolicyMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn net_route_policy_matrix_transpose(m : NetroutepolicyMatrix) -> NetroutepolicyMatrix {
  let result = net_route_policy_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn net_route_policy_matrix_add(a : NetroutepolicyMatrix, b : NetroutepolicyMatrix) -> NetroutepolicyMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = net_route_policy_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn net_route_policy_matrix_scale(m : NetroutepolicyMatrix, s : Double) -> NetroutepolicyMatrix {
  let result = net_route_policy_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn net_route_policy_matrix_multiply(a : NetroutepolicyMatrix, b : NetroutepolicyMatrix) -> NetroutepolicyMatrix {
  if a.cols != b.rows { return net_route_policy_make_matrix(a.rows, b.cols, 0.0) }
  let result = net_route_policy_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn net_route_policy_matrix_trace(m : NetroutepolicyMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn net_route_policy_matrix_det(m : NetroutepolicyMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn net_route_policy_matrix_norm(m : NetroutepolicyMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn net_route_policy_matrix_to_string(m : NetroutepolicyMatrix) -> String {
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

pub(all) struct NetroutepolicyVector {
  comps : Array[Double]
  dim : Int
}

pub fn net_route_policy_make_vector(comps : Array[Double]) -> NetroutepolicyVector {
  { comps, dim: comps.length() }
}

pub fn net_route_policy_vector_zero(dim : Int) -> NetroutepolicyVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn net_route_policy_vector_add(a : NetroutepolicyVector, b : NetroutepolicyVector) -> NetroutepolicyVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn net_route_policy_vector_sub(a : NetroutepolicyVector, b : NetroutepolicyVector) -> NetroutepolicyVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn net_route_policy_vector_scale(v : NetroutepolicyVector, s : Double) -> NetroutepolicyVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn net_route_policy_vector_dot(a : NetroutepolicyVector, b : NetroutepolicyVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn net_route_policy_vector_norm(v : NetroutepolicyVector) -> Double { @_common.sqrt(net_route_policy_vector_dot(v, v)) }

pub fn net_route_policy_vector_normalize(v : NetroutepolicyVector) -> NetroutepolicyVector {
  let n = net_route_policy_vector_norm(v)
  if n < 0.0000001 { v } else { net_route_policy_vector_scale(v, 1.0 / n) }
}

pub fn net_route_policy_vector_dist(a : NetroutepolicyVector, b : NetroutepolicyVector) -> Double {
  net_route_policy_vector_norm(net_route_policy_vector_sub(a, b))
}

pub fn net_route_policy_vector_to_string(v : NetroutepolicyVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn net_route_policy_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn net_route_policy_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn net_route_policy_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn net_route_policy_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn net_route_policy_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn net_route_policy_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn net_route_policy_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn net_route_policy_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn net_route_policy_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn net_route_policy_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn net_route_policy_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn net_route_policy_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn net_route_policy_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn net_route_policy_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn net_route_policy_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn net_route_policy_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn net_route_policy_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn net_route_policy_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn net_route_policy_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn net_route_policy_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn net_route_policy_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn net_route_policy_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn net_route_policy_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn net_route_policy_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn net_route_policy_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn net_route_policy_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn net_route_policy_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn net_route_policy_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn net_route_policy_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct NetroutepolicyFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_policy_frame_make(size : Int) -> NetroutepolicyFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_policy_frame_len(s : NetroutepolicyFrame) -> Int { s.size }

pub fn net_route_policy_frame_get(s : NetroutepolicyFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_policy_frame_set(s : NetroutepolicyFrame, i : Int, v : Double) -> NetroutepolicyFrame {
  let result = net_route_policy_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_route_policy_frame_sum(s : NetroutepolicyFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_route_policy_frame_mean(s : NetroutepolicyFrame) -> Double {
  if s.size == 0 { 0.0 } else { net_route_policy_frame_sum(s) / s.size.to_double() }
}

pub fn net_route_policy_frame_scale(s : NetroutepolicyFrame, f : Double) -> NetroutepolicyFrame {
  let result = net_route_policy_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_route_policy_frame_add(a : NetroutepolicyFrame, b : NetroutepolicyFrame) -> NetroutepolicyFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_route_policy_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_route_policy_frame_copy(s : NetroutepolicyFrame) -> NetroutepolicyFrame {
  let result = net_route_policy_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_route_policy_frame_fill(s : NetroutepolicyFrame, v : Double) -> NetroutepolicyFrame {
  let result = net_route_policy_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_route_policy_frame_min(s : NetroutepolicyFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_route_policy_frame_max(s : NetroutepolicyFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_route_policy_frame_to_string(s : NetroutepolicyFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetroutepolicyTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_policy_table_make(size : Int) -> NetroutepolicyTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_policy_table_len(s : NetroutepolicyTable) -> Int { s.size }

pub fn net_route_policy_table_get(s : NetroutepolicyTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_policy_table_set(s : NetroutepolicyTable, i : Int, v : Double) -> NetroutepolicyTable {
  let result = net_route_policy_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_route_policy_table_sum(s : NetroutepolicyTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_route_policy_table_mean(s : NetroutepolicyTable) -> Double {
  if s.size == 0 { 0.0 } else { net_route_policy_table_sum(s) / s.size.to_double() }
}

pub fn net_route_policy_table_scale(s : NetroutepolicyTable, f : Double) -> NetroutepolicyTable {
  let result = net_route_policy_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_route_policy_table_add(a : NetroutepolicyTable, b : NetroutepolicyTable) -> NetroutepolicyTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_route_policy_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_route_policy_table_copy(s : NetroutepolicyTable) -> NetroutepolicyTable {
  let result = net_route_policy_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_route_policy_table_fill(s : NetroutepolicyTable, v : Double) -> NetroutepolicyTable {
  let result = net_route_policy_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_route_policy_table_min(s : NetroutepolicyTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_route_policy_table_max(s : NetroutepolicyTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_route_policy_table_to_string(s : NetroutepolicyTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetroutepolicyGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_policy_graphn_make(size : Int) -> NetroutepolicyGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_policy_graphn_len(s : NetroutepolicyGraphN) -> Int { s.size }

pub fn net_route_policy_graphn_get(s : NetroutepolicyGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_policy_graphn_set(s : NetroutepolicyGraphN, i : Int, v : Double) -> NetroutepolicyGraphN {
  let result = net_route_policy_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_route_policy_graphn_sum(s : NetroutepolicyGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_route_policy_graphn_mean(s : NetroutepolicyGraphN) -> Double {
  if s.size == 0 { 0.0 } else { net_route_policy_graphn_sum(s) / s.size.to_double() }
}

pub fn net_route_policy_graphn_scale(s : NetroutepolicyGraphN, f : Double) -> NetroutepolicyGraphN {
  let result = net_route_policy_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_route_policy_graphn_add(a : NetroutepolicyGraphN, b : NetroutepolicyGraphN) -> NetroutepolicyGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_route_policy_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_route_policy_graphn_copy(s : NetroutepolicyGraphN) -> NetroutepolicyGraphN {
  let result = net_route_policy_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_route_policy_graphn_fill(s : NetroutepolicyGraphN, v : Double) -> NetroutepolicyGraphN {
  let result = net_route_policy_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_route_policy_graphn_min(s : NetroutepolicyGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_route_policy_graphn_max(s : NetroutepolicyGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_route_policy_graphn_to_string(s : NetroutepolicyGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetroutepolicyNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_policy_node_make(size : Int) -> NetroutepolicyNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_policy_node_len(s : NetroutepolicyNode) -> Int { s.size }

pub fn net_route_policy_node_get(s : NetroutepolicyNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_policy_node_set(s : NetroutepolicyNode, i : Int, v : Double) -> NetroutepolicyNode {
  let result = net_route_policy_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_route_policy_node_sum(s : NetroutepolicyNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_route_policy_node_mean(s : NetroutepolicyNode) -> Double {
  if s.size == 0 { 0.0 } else { net_route_policy_node_sum(s) / s.size.to_double() }
}

pub fn net_route_policy_node_scale(s : NetroutepolicyNode, f : Double) -> NetroutepolicyNode {
  let result = net_route_policy_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_route_policy_node_add(a : NetroutepolicyNode, b : NetroutepolicyNode) -> NetroutepolicyNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_route_policy_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_route_policy_node_copy(s : NetroutepolicyNode) -> NetroutepolicyNode {
  let result = net_route_policy_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_route_policy_node_fill(s : NetroutepolicyNode, v : Double) -> NetroutepolicyNode {
  let result = net_route_policy_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_route_policy_node_min(s : NetroutepolicyNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_route_policy_node_max(s : NetroutepolicyNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_route_policy_node_to_string(s : NetroutepolicyNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetroutepolicyEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_policy_edge_make(size : Int) -> NetroutepolicyEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_policy_edge_len(s : NetroutepolicyEdge) -> Int { s.size }

pub fn net_route_policy_edge_get(s : NetroutepolicyEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_policy_edge_set(s : NetroutepolicyEdge, i : Int, v : Double) -> NetroutepolicyEdge {
  let result = net_route_policy_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_route_policy_edge_sum(s : NetroutepolicyEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_route_policy_edge_mean(s : NetroutepolicyEdge) -> Double {
  if s.size == 0 { 0.0 } else { net_route_policy_edge_sum(s) / s.size.to_double() }
}

pub fn net_route_policy_edge_scale(s : NetroutepolicyEdge, f : Double) -> NetroutepolicyEdge {
  let result = net_route_policy_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_route_policy_edge_add(a : NetroutepolicyEdge, b : NetroutepolicyEdge) -> NetroutepolicyEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_route_policy_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_route_policy_edge_copy(s : NetroutepolicyEdge) -> NetroutepolicyEdge {
  let result = net_route_policy_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_route_policy_edge_fill(s : NetroutepolicyEdge, v : Double) -> NetroutepolicyEdge {
  let result = net_route_policy_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_route_policy_edge_min(s : NetroutepolicyEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_route_policy_edge_max(s : NetroutepolicyEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_route_policy_edge_to_string(s : NetroutepolicyEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetroutepolicyPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_policy_path_make(size : Int) -> NetroutepolicyPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_policy_path_len(s : NetroutepolicyPath) -> Int { s.size }

pub fn net_route_policy_path_get(s : NetroutepolicyPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_policy_path_set(s : NetroutepolicyPath, i : Int, v : Double) -> NetroutepolicyPath {
  let result = net_route_policy_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_route_policy_path_sum(s : NetroutepolicyPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_route_policy_path_mean(s : NetroutepolicyPath) -> Double {
  if s.size == 0 { 0.0 } else { net_route_policy_path_sum(s) / s.size.to_double() }
}

pub fn net_route_policy_path_scale(s : NetroutepolicyPath, f : Double) -> NetroutepolicyPath {
  let result = net_route_policy_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_route_policy_path_add(a : NetroutepolicyPath, b : NetroutepolicyPath) -> NetroutepolicyPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_route_policy_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_route_policy_path_copy(s : NetroutepolicyPath) -> NetroutepolicyPath {
  let result = net_route_policy_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_route_policy_path_fill(s : NetroutepolicyPath, v : Double) -> NetroutepolicyPath {
  let result = net_route_policy_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_route_policy_path_min(s : NetroutepolicyPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_route_policy_path_max(s : NetroutepolicyPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_route_policy_path_to_string(s : NetroutepolicyPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetroutepolicyCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_policy_cluster_make(size : Int) -> NetroutepolicyCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_policy_cluster_len(s : NetroutepolicyCluster) -> Int { s.size }

pub fn net_route_policy_cluster_get(s : NetroutepolicyCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_policy_cluster_set(s : NetroutepolicyCluster, i : Int, v : Double) -> NetroutepolicyCluster {
  let result = net_route_policy_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_route_policy_cluster_sum(s : NetroutepolicyCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_route_policy_cluster_mean(s : NetroutepolicyCluster) -> Double {
  if s.size == 0 { 0.0 } else { net_route_policy_cluster_sum(s) / s.size.to_double() }
}

pub fn net_route_policy_cluster_scale(s : NetroutepolicyCluster, f : Double) -> NetroutepolicyCluster {
  let result = net_route_policy_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_route_policy_cluster_add(a : NetroutepolicyCluster, b : NetroutepolicyCluster) -> NetroutepolicyCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_route_policy_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_route_policy_cluster_copy(s : NetroutepolicyCluster) -> NetroutepolicyCluster {
  let result = net_route_policy_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_route_policy_cluster_fill(s : NetroutepolicyCluster, v : Double) -> NetroutepolicyCluster {
  let result = net_route_policy_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_route_policy_cluster_min(s : NetroutepolicyCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_route_policy_cluster_max(s : NetroutepolicyCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_route_policy_cluster_to_string(s : NetroutepolicyCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetroutepolicyModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_policy_model_make(size : Int) -> NetroutepolicyModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_policy_model_len(s : NetroutepolicyModel) -> Int { s.size }

pub fn net_route_policy_model_get(s : NetroutepolicyModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_policy_model_set(s : NetroutepolicyModel, i : Int, v : Double) -> NetroutepolicyModel {
  let result = net_route_policy_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_route_policy_model_sum(s : NetroutepolicyModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_route_policy_model_mean(s : NetroutepolicyModel) -> Double {
  if s.size == 0 { 0.0 } else { net_route_policy_model_sum(s) / s.size.to_double() }
}

pub fn net_route_policy_model_scale(s : NetroutepolicyModel, f : Double) -> NetroutepolicyModel {
  let result = net_route_policy_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_route_policy_model_add(a : NetroutepolicyModel, b : NetroutepolicyModel) -> NetroutepolicyModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_route_policy_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_route_policy_model_copy(s : NetroutepolicyModel) -> NetroutepolicyModel {
  let result = net_route_policy_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_route_policy_model_fill(s : NetroutepolicyModel, v : Double) -> NetroutepolicyModel {
  let result = net_route_policy_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_route_policy_model_min(s : NetroutepolicyModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_route_policy_model_max(s : NetroutepolicyModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_route_policy_model_to_string(s : NetroutepolicyModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetroutepolicyLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_policy_layer_make(size : Int) -> NetroutepolicyLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_policy_layer_len(s : NetroutepolicyLayer) -> Int { s.size }

pub fn net_route_policy_layer_get(s : NetroutepolicyLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_policy_layer_set(s : NetroutepolicyLayer, i : Int, v : Double) -> NetroutepolicyLayer {
  let result = net_route_policy_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_route_policy_layer_sum(s : NetroutepolicyLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_route_policy_layer_mean(s : NetroutepolicyLayer) -> Double {
  if s.size == 0 { 0.0 } else { net_route_policy_layer_sum(s) / s.size.to_double() }
}

pub fn net_route_policy_layer_scale(s : NetroutepolicyLayer, f : Double) -> NetroutepolicyLayer {
  let result = net_route_policy_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_route_policy_layer_add(a : NetroutepolicyLayer, b : NetroutepolicyLayer) -> NetroutepolicyLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_route_policy_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_route_policy_layer_copy(s : NetroutepolicyLayer) -> NetroutepolicyLayer {
  let result = net_route_policy_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_route_policy_layer_fill(s : NetroutepolicyLayer, v : Double) -> NetroutepolicyLayer {
  let result = net_route_policy_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_route_policy_layer_min(s : NetroutepolicyLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_route_policy_layer_max(s : NetroutepolicyLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_route_policy_layer_to_string(s : NetroutepolicyLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetroutepolicyBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_policy_buffer_make(size : Int) -> NetroutepolicyBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_policy_buffer_len(s : NetroutepolicyBuffer) -> Int { s.size }

pub fn net_route_policy_buffer_get(s : NetroutepolicyBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_policy_buffer_set(s : NetroutepolicyBuffer, i : Int, v : Double) -> NetroutepolicyBuffer {
  let result = net_route_policy_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_route_policy_buffer_sum(s : NetroutepolicyBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_route_policy_buffer_mean(s : NetroutepolicyBuffer) -> Double {
  if s.size == 0 { 0.0 } else { net_route_policy_buffer_sum(s) / s.size.to_double() }
}

pub fn net_route_policy_buffer_scale(s : NetroutepolicyBuffer, f : Double) -> NetroutepolicyBuffer {
  let result = net_route_policy_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_route_policy_buffer_add(a : NetroutepolicyBuffer, b : NetroutepolicyBuffer) -> NetroutepolicyBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_route_policy_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_route_policy_buffer_copy(s : NetroutepolicyBuffer) -> NetroutepolicyBuffer {
  let result = net_route_policy_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_route_policy_buffer_fill(s : NetroutepolicyBuffer, v : Double) -> NetroutepolicyBuffer {
  let result = net_route_policy_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_route_policy_buffer_min(s : NetroutepolicyBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_route_policy_buffer_max(s : NetroutepolicyBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_route_policy_buffer_to_string(s : NetroutepolicyBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetroutepolicyCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_policy_cursor_make(size : Int) -> NetroutepolicyCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_policy_cursor_len(s : NetroutepolicyCursor) -> Int { s.size }

pub fn net_route_policy_cursor_get(s : NetroutepolicyCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_policy_cursor_set(s : NetroutepolicyCursor, i : Int, v : Double) -> NetroutepolicyCursor {
  let result = net_route_policy_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_route_policy_cursor_sum(s : NetroutepolicyCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_route_policy_cursor_mean(s : NetroutepolicyCursor) -> Double {
  if s.size == 0 { 0.0 } else { net_route_policy_cursor_sum(s) / s.size.to_double() }
}

pub fn net_route_policy_cursor_scale(s : NetroutepolicyCursor, f : Double) -> NetroutepolicyCursor {
  let result = net_route_policy_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_route_policy_cursor_add(a : NetroutepolicyCursor, b : NetroutepolicyCursor) -> NetroutepolicyCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_route_policy_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_route_policy_cursor_copy(s : NetroutepolicyCursor) -> NetroutepolicyCursor {
  let result = net_route_policy_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_route_policy_cursor_fill(s : NetroutepolicyCursor, v : Double) -> NetroutepolicyCursor {
  let result = net_route_policy_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_route_policy_cursor_min(s : NetroutepolicyCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_route_policy_cursor_max(s : NetroutepolicyCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_route_policy_cursor_to_string(s : NetroutepolicyCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetroutepolicyView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_policy_view_make(size : Int) -> NetroutepolicyView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_policy_view_len(s : NetroutepolicyView) -> Int { s.size }

pub fn net_route_policy_view_get(s : NetroutepolicyView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_policy_view_set(s : NetroutepolicyView, i : Int, v : Double) -> NetroutepolicyView {
  let result = net_route_policy_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_route_policy_view_sum(s : NetroutepolicyView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_route_policy_view_mean(s : NetroutepolicyView) -> Double {
  if s.size == 0 { 0.0 } else { net_route_policy_view_sum(s) / s.size.to_double() }
}

pub fn net_route_policy_view_scale(s : NetroutepolicyView, f : Double) -> NetroutepolicyView {
  let result = net_route_policy_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_route_policy_view_add(a : NetroutepolicyView, b : NetroutepolicyView) -> NetroutepolicyView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_route_policy_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_route_policy_view_copy(s : NetroutepolicyView) -> NetroutepolicyView {
  let result = net_route_policy_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_route_policy_view_fill(s : NetroutepolicyView, v : Double) -> NetroutepolicyView {
  let result = net_route_policy_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_route_policy_view_min(s : NetroutepolicyView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_route_policy_view_max(s : NetroutepolicyView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_route_policy_view_to_string(s : NetroutepolicyView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetroutepolicyRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_policy_range_make(size : Int) -> NetroutepolicyRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_policy_range_len(s : NetroutepolicyRange) -> Int { s.size }

pub fn net_route_policy_range_get(s : NetroutepolicyRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_policy_range_set(s : NetroutepolicyRange, i : Int, v : Double) -> NetroutepolicyRange {
  let result = net_route_policy_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_route_policy_range_sum(s : NetroutepolicyRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_route_policy_range_mean(s : NetroutepolicyRange) -> Double {
  if s.size == 0 { 0.0 } else { net_route_policy_range_sum(s) / s.size.to_double() }
}

pub fn net_route_policy_range_scale(s : NetroutepolicyRange, f : Double) -> NetroutepolicyRange {
  let result = net_route_policy_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_route_policy_range_add(a : NetroutepolicyRange, b : NetroutepolicyRange) -> NetroutepolicyRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_route_policy_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_route_policy_range_copy(s : NetroutepolicyRange) -> NetroutepolicyRange {
  let result = net_route_policy_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_route_policy_range_fill(s : NetroutepolicyRange, v : Double) -> NetroutepolicyRange {
  let result = net_route_policy_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_route_policy_range_min(s : NetroutepolicyRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_route_policy_range_max(s : NetroutepolicyRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_route_policy_range_to_string(s : NetroutepolicyRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetroutepolicySlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_policy_slice_make(size : Int) -> NetroutepolicySlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_policy_slice_len(s : NetroutepolicySlice) -> Int { s.size }

pub fn net_route_policy_slice_get(s : NetroutepolicySlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_policy_slice_set(s : NetroutepolicySlice, i : Int, v : Double) -> NetroutepolicySlice {
  let result = net_route_policy_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_route_policy_slice_sum(s : NetroutepolicySlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_route_policy_slice_mean(s : NetroutepolicySlice) -> Double {
  if s.size == 0 { 0.0 } else { net_route_policy_slice_sum(s) / s.size.to_double() }
}

pub fn net_route_policy_slice_scale(s : NetroutepolicySlice, f : Double) -> NetroutepolicySlice {
  let result = net_route_policy_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_route_policy_slice_add(a : NetroutepolicySlice, b : NetroutepolicySlice) -> NetroutepolicySlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_route_policy_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_route_policy_slice_copy(s : NetroutepolicySlice) -> NetroutepolicySlice {
  let result = net_route_policy_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_route_policy_slice_fill(s : NetroutepolicySlice, v : Double) -> NetroutepolicySlice {
  let result = net_route_policy_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_route_policy_slice_min(s : NetroutepolicySlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_route_policy_slice_max(s : NetroutepolicySlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_route_policy_slice_to_string(s : NetroutepolicySlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

