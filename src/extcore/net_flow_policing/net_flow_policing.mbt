///===
/// extcore/net_flow_policing

pub(all) struct NetflowpolicingPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn net_flow_policing_make_point(x : Double, y : Double) -> NetflowpolicingPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn net_flow_policing_make_point3(x : Double, y : Double, z : Double) -> NetflowpolicingPoint {
  { x, y, z, label: 0 }
}

pub fn net_flow_policing_point_x(pt : NetflowpolicingPoint) -> Double { pt.x }

pub fn net_flow_policing_point_y(pt : NetflowpolicingPoint) -> Double { pt.y }

pub fn net_flow_policing_point_z(pt : NetflowpolicingPoint) -> Double { pt.z }

pub fn net_flow_policing_point_label(pt : NetflowpolicingPoint) -> Int { pt.label }

pub fn net_flow_policing_point_dist(a : NetflowpolicingPoint, b : NetflowpolicingPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn net_flow_policing_point_add(a : NetflowpolicingPoint, b : NetflowpolicingPoint) -> NetflowpolicingPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn net_flow_policing_point_sub(a : NetflowpolicingPoint, b : NetflowpolicingPoint) -> NetflowpolicingPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn net_flow_policing_point_scale(pt : NetflowpolicingPoint, s : Double) -> NetflowpolicingPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn net_flow_policing_point_dot(a : NetflowpolicingPoint, b : NetflowpolicingPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn net_flow_policing_point_cross(a : NetflowpolicingPoint, b : NetflowpolicingPoint) -> NetflowpolicingPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn net_flow_policing_point_norm(pt : NetflowpolicingPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn net_flow_policing_point_normalize(pt : NetflowpolicingPoint) -> NetflowpolicingPoint {
  let n = net_flow_policing_point_norm(pt)
  if n < 0.0000001 { pt } else { net_flow_policing_point_scale(pt, 1.0 / n) }
}

pub fn net_flow_policing_point_negate(pt : NetflowpolicingPoint) -> NetflowpolicingPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn net_flow_policing_point_mid(a : NetflowpolicingPoint, b : NetflowpolicingPoint) -> NetflowpolicingPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn net_flow_policing_point_lerp(a : NetflowpolicingPoint, b : NetflowpolicingPoint, t : Double) -> NetflowpolicingPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn net_flow_policing_point_to_string(pt : NetflowpolicingPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct NetflowpolicingSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn net_flow_policing_make_series(vals : Array[Double], name : String) -> NetflowpolicingSeries {
  { vals, name, meta: 0 }
}

pub fn net_flow_policing_series_len(s : NetflowpolicingSeries) -> Int { s.vals.length() }

pub fn net_flow_policing_series_sum(s : NetflowpolicingSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn net_flow_policing_series_mean(s : NetflowpolicingSeries) -> Double { @_common.mean(s.vals) }

pub fn net_flow_policing_series_min(s : NetflowpolicingSeries) -> Double { @_common.min(s.vals) }

pub fn net_flow_policing_series_max(s : NetflowpolicingSeries) -> Double { @_common.max(s.vals) }

pub fn net_flow_policing_series_range(s : NetflowpolicingSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn net_flow_policing_series_var(s : NetflowpolicingSeries) -> Double { @_common.variance(s.vals) }

pub fn net_flow_policing_series_std(s : NetflowpolicingSeries) -> Double { @_common.std(s.vals) }

pub fn net_flow_policing_series_median(s : NetflowpolicingSeries) -> Double { @_common.median(s.vals) }

pub fn net_flow_policing_series_scale(s : NetflowpolicingSeries, f : Double) -> NetflowpolicingSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn net_flow_policing_series_add(a : NetflowpolicingSeries, b : NetflowpolicingSeries) -> NetflowpolicingSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn net_flow_policing_series_sub(a : NetflowpolicingSeries, b : NetflowpolicingSeries) -> NetflowpolicingSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn net_flow_policing_series_normalize(s : NetflowpolicingSeries) -> NetflowpolicingSeries {
  let mn = net_flow_policing_series_min(s)
  let mx = net_flow_policing_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn net_flow_policing_series_cumsum(s : NetflowpolicingSeries) -> NetflowpolicingSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn net_flow_policing_series_to_string(s : NetflowpolicingSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NetflowpolicingMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn net_flow_policing_make_matrix(rows : Int, cols : Int, val : Double) -> NetflowpolicingMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn net_flow_policing_matrix_identity(n : Int) -> NetflowpolicingMatrix {
  let m = net_flow_policing_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn net_flow_policing_matrix_get(m : NetflowpolicingMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn net_flow_policing_matrix_transpose(m : NetflowpolicingMatrix) -> NetflowpolicingMatrix {
  let result = net_flow_policing_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn net_flow_policing_matrix_add(a : NetflowpolicingMatrix, b : NetflowpolicingMatrix) -> NetflowpolicingMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = net_flow_policing_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn net_flow_policing_matrix_scale(m : NetflowpolicingMatrix, s : Double) -> NetflowpolicingMatrix {
  let result = net_flow_policing_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn net_flow_policing_matrix_multiply(a : NetflowpolicingMatrix, b : NetflowpolicingMatrix) -> NetflowpolicingMatrix {
  if a.cols != b.rows { return net_flow_policing_make_matrix(a.rows, b.cols, 0.0) }
  let result = net_flow_policing_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn net_flow_policing_matrix_trace(m : NetflowpolicingMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn net_flow_policing_matrix_det(m : NetflowpolicingMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn net_flow_policing_matrix_norm(m : NetflowpolicingMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn net_flow_policing_matrix_to_string(m : NetflowpolicingMatrix) -> String {
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

pub(all) struct NetflowpolicingVector {
  comps : Array[Double]
  dim : Int
}

pub fn net_flow_policing_make_vector(comps : Array[Double]) -> NetflowpolicingVector {
  { comps, dim: comps.length() }
}

pub fn net_flow_policing_vector_zero(dim : Int) -> NetflowpolicingVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn net_flow_policing_vector_add(a : NetflowpolicingVector, b : NetflowpolicingVector) -> NetflowpolicingVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn net_flow_policing_vector_sub(a : NetflowpolicingVector, b : NetflowpolicingVector) -> NetflowpolicingVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn net_flow_policing_vector_scale(v : NetflowpolicingVector, s : Double) -> NetflowpolicingVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn net_flow_policing_vector_dot(a : NetflowpolicingVector, b : NetflowpolicingVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn net_flow_policing_vector_norm(v : NetflowpolicingVector) -> Double { @_common.sqrt(net_flow_policing_vector_dot(v, v)) }

pub fn net_flow_policing_vector_normalize(v : NetflowpolicingVector) -> NetflowpolicingVector {
  let n = net_flow_policing_vector_norm(v)
  if n < 0.0000001 { v } else { net_flow_policing_vector_scale(v, 1.0 / n) }
}

pub fn net_flow_policing_vector_dist(a : NetflowpolicingVector, b : NetflowpolicingVector) -> Double {
  net_flow_policing_vector_norm(net_flow_policing_vector_sub(a, b))
}

pub fn net_flow_policing_vector_to_string(v : NetflowpolicingVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn net_flow_policing_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn net_flow_policing_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn net_flow_policing_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn net_flow_policing_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn net_flow_policing_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn net_flow_policing_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn net_flow_policing_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn net_flow_policing_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn net_flow_policing_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn net_flow_policing_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn net_flow_policing_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn net_flow_policing_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn net_flow_policing_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn net_flow_policing_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn net_flow_policing_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn net_flow_policing_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn net_flow_policing_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn net_flow_policing_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn net_flow_policing_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn net_flow_policing_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn net_flow_policing_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn net_flow_policing_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn net_flow_policing_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn net_flow_policing_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn net_flow_policing_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn net_flow_policing_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn net_flow_policing_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn net_flow_policing_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn net_flow_policing_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct NetflowpolicingFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_policing_frame_make(size : Int) -> NetflowpolicingFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_policing_frame_len(s : NetflowpolicingFrame) -> Int { s.size }

pub fn net_flow_policing_frame_get(s : NetflowpolicingFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_policing_frame_set(s : NetflowpolicingFrame, i : Int, v : Double) -> NetflowpolicingFrame {
  let result = net_flow_policing_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_flow_policing_frame_sum(s : NetflowpolicingFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_flow_policing_frame_mean(s : NetflowpolicingFrame) -> Double {
  if s.size == 0 { 0.0 } else { net_flow_policing_frame_sum(s) / s.size.to_double() }
}

pub fn net_flow_policing_frame_scale(s : NetflowpolicingFrame, f : Double) -> NetflowpolicingFrame {
  let result = net_flow_policing_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_flow_policing_frame_add(a : NetflowpolicingFrame, b : NetflowpolicingFrame) -> NetflowpolicingFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_flow_policing_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_flow_policing_frame_copy(s : NetflowpolicingFrame) -> NetflowpolicingFrame {
  let result = net_flow_policing_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_flow_policing_frame_fill(s : NetflowpolicingFrame, v : Double) -> NetflowpolicingFrame {
  let result = net_flow_policing_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_flow_policing_frame_min(s : NetflowpolicingFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_policing_frame_max(s : NetflowpolicingFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_policing_frame_to_string(s : NetflowpolicingFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowpolicingTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_policing_table_make(size : Int) -> NetflowpolicingTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_policing_table_len(s : NetflowpolicingTable) -> Int { s.size }

pub fn net_flow_policing_table_get(s : NetflowpolicingTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_policing_table_set(s : NetflowpolicingTable, i : Int, v : Double) -> NetflowpolicingTable {
  let result = net_flow_policing_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_flow_policing_table_sum(s : NetflowpolicingTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_flow_policing_table_mean(s : NetflowpolicingTable) -> Double {
  if s.size == 0 { 0.0 } else { net_flow_policing_table_sum(s) / s.size.to_double() }
}

pub fn net_flow_policing_table_scale(s : NetflowpolicingTable, f : Double) -> NetflowpolicingTable {
  let result = net_flow_policing_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_flow_policing_table_add(a : NetflowpolicingTable, b : NetflowpolicingTable) -> NetflowpolicingTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_flow_policing_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_flow_policing_table_copy(s : NetflowpolicingTable) -> NetflowpolicingTable {
  let result = net_flow_policing_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_flow_policing_table_fill(s : NetflowpolicingTable, v : Double) -> NetflowpolicingTable {
  let result = net_flow_policing_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_flow_policing_table_min(s : NetflowpolicingTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_policing_table_max(s : NetflowpolicingTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_policing_table_to_string(s : NetflowpolicingTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowpolicingGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_policing_graphn_make(size : Int) -> NetflowpolicingGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_policing_graphn_len(s : NetflowpolicingGraphN) -> Int { s.size }

pub fn net_flow_policing_graphn_get(s : NetflowpolicingGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_policing_graphn_set(s : NetflowpolicingGraphN, i : Int, v : Double) -> NetflowpolicingGraphN {
  let result = net_flow_policing_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_flow_policing_graphn_sum(s : NetflowpolicingGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_flow_policing_graphn_mean(s : NetflowpolicingGraphN) -> Double {
  if s.size == 0 { 0.0 } else { net_flow_policing_graphn_sum(s) / s.size.to_double() }
}

pub fn net_flow_policing_graphn_scale(s : NetflowpolicingGraphN, f : Double) -> NetflowpolicingGraphN {
  let result = net_flow_policing_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_flow_policing_graphn_add(a : NetflowpolicingGraphN, b : NetflowpolicingGraphN) -> NetflowpolicingGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_flow_policing_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_flow_policing_graphn_copy(s : NetflowpolicingGraphN) -> NetflowpolicingGraphN {
  let result = net_flow_policing_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_flow_policing_graphn_fill(s : NetflowpolicingGraphN, v : Double) -> NetflowpolicingGraphN {
  let result = net_flow_policing_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_flow_policing_graphn_min(s : NetflowpolicingGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_policing_graphn_max(s : NetflowpolicingGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_policing_graphn_to_string(s : NetflowpolicingGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowpolicingNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_policing_node_make(size : Int) -> NetflowpolicingNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_policing_node_len(s : NetflowpolicingNode) -> Int { s.size }

pub fn net_flow_policing_node_get(s : NetflowpolicingNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_policing_node_set(s : NetflowpolicingNode, i : Int, v : Double) -> NetflowpolicingNode {
  let result = net_flow_policing_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_flow_policing_node_sum(s : NetflowpolicingNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_flow_policing_node_mean(s : NetflowpolicingNode) -> Double {
  if s.size == 0 { 0.0 } else { net_flow_policing_node_sum(s) / s.size.to_double() }
}

pub fn net_flow_policing_node_scale(s : NetflowpolicingNode, f : Double) -> NetflowpolicingNode {
  let result = net_flow_policing_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_flow_policing_node_add(a : NetflowpolicingNode, b : NetflowpolicingNode) -> NetflowpolicingNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_flow_policing_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_flow_policing_node_copy(s : NetflowpolicingNode) -> NetflowpolicingNode {
  let result = net_flow_policing_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_flow_policing_node_fill(s : NetflowpolicingNode, v : Double) -> NetflowpolicingNode {
  let result = net_flow_policing_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_flow_policing_node_min(s : NetflowpolicingNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_policing_node_max(s : NetflowpolicingNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_policing_node_to_string(s : NetflowpolicingNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowpolicingEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_policing_edge_make(size : Int) -> NetflowpolicingEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_policing_edge_len(s : NetflowpolicingEdge) -> Int { s.size }

pub fn net_flow_policing_edge_get(s : NetflowpolicingEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_policing_edge_set(s : NetflowpolicingEdge, i : Int, v : Double) -> NetflowpolicingEdge {
  let result = net_flow_policing_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_flow_policing_edge_sum(s : NetflowpolicingEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_flow_policing_edge_mean(s : NetflowpolicingEdge) -> Double {
  if s.size == 0 { 0.0 } else { net_flow_policing_edge_sum(s) / s.size.to_double() }
}

pub fn net_flow_policing_edge_scale(s : NetflowpolicingEdge, f : Double) -> NetflowpolicingEdge {
  let result = net_flow_policing_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_flow_policing_edge_add(a : NetflowpolicingEdge, b : NetflowpolicingEdge) -> NetflowpolicingEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_flow_policing_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_flow_policing_edge_copy(s : NetflowpolicingEdge) -> NetflowpolicingEdge {
  let result = net_flow_policing_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_flow_policing_edge_fill(s : NetflowpolicingEdge, v : Double) -> NetflowpolicingEdge {
  let result = net_flow_policing_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_flow_policing_edge_min(s : NetflowpolicingEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_policing_edge_max(s : NetflowpolicingEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_policing_edge_to_string(s : NetflowpolicingEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowpolicingPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_policing_path_make(size : Int) -> NetflowpolicingPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_policing_path_len(s : NetflowpolicingPath) -> Int { s.size }

pub fn net_flow_policing_path_get(s : NetflowpolicingPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_policing_path_set(s : NetflowpolicingPath, i : Int, v : Double) -> NetflowpolicingPath {
  let result = net_flow_policing_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_flow_policing_path_sum(s : NetflowpolicingPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_flow_policing_path_mean(s : NetflowpolicingPath) -> Double {
  if s.size == 0 { 0.0 } else { net_flow_policing_path_sum(s) / s.size.to_double() }
}

pub fn net_flow_policing_path_scale(s : NetflowpolicingPath, f : Double) -> NetflowpolicingPath {
  let result = net_flow_policing_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_flow_policing_path_add(a : NetflowpolicingPath, b : NetflowpolicingPath) -> NetflowpolicingPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_flow_policing_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_flow_policing_path_copy(s : NetflowpolicingPath) -> NetflowpolicingPath {
  let result = net_flow_policing_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_flow_policing_path_fill(s : NetflowpolicingPath, v : Double) -> NetflowpolicingPath {
  let result = net_flow_policing_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_flow_policing_path_min(s : NetflowpolicingPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_policing_path_max(s : NetflowpolicingPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_policing_path_to_string(s : NetflowpolicingPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowpolicingCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_policing_cluster_make(size : Int) -> NetflowpolicingCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_policing_cluster_len(s : NetflowpolicingCluster) -> Int { s.size }

pub fn net_flow_policing_cluster_get(s : NetflowpolicingCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_policing_cluster_set(s : NetflowpolicingCluster, i : Int, v : Double) -> NetflowpolicingCluster {
  let result = net_flow_policing_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_flow_policing_cluster_sum(s : NetflowpolicingCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_flow_policing_cluster_mean(s : NetflowpolicingCluster) -> Double {
  if s.size == 0 { 0.0 } else { net_flow_policing_cluster_sum(s) / s.size.to_double() }
}

pub fn net_flow_policing_cluster_scale(s : NetflowpolicingCluster, f : Double) -> NetflowpolicingCluster {
  let result = net_flow_policing_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_flow_policing_cluster_add(a : NetflowpolicingCluster, b : NetflowpolicingCluster) -> NetflowpolicingCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_flow_policing_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_flow_policing_cluster_copy(s : NetflowpolicingCluster) -> NetflowpolicingCluster {
  let result = net_flow_policing_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_flow_policing_cluster_fill(s : NetflowpolicingCluster, v : Double) -> NetflowpolicingCluster {
  let result = net_flow_policing_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_flow_policing_cluster_min(s : NetflowpolicingCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_policing_cluster_max(s : NetflowpolicingCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_policing_cluster_to_string(s : NetflowpolicingCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowpolicingModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_policing_model_make(size : Int) -> NetflowpolicingModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_policing_model_len(s : NetflowpolicingModel) -> Int { s.size }

pub fn net_flow_policing_model_get(s : NetflowpolicingModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_policing_model_set(s : NetflowpolicingModel, i : Int, v : Double) -> NetflowpolicingModel {
  let result = net_flow_policing_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_flow_policing_model_sum(s : NetflowpolicingModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_flow_policing_model_mean(s : NetflowpolicingModel) -> Double {
  if s.size == 0 { 0.0 } else { net_flow_policing_model_sum(s) / s.size.to_double() }
}

pub fn net_flow_policing_model_scale(s : NetflowpolicingModel, f : Double) -> NetflowpolicingModel {
  let result = net_flow_policing_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_flow_policing_model_add(a : NetflowpolicingModel, b : NetflowpolicingModel) -> NetflowpolicingModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_flow_policing_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_flow_policing_model_copy(s : NetflowpolicingModel) -> NetflowpolicingModel {
  let result = net_flow_policing_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_flow_policing_model_fill(s : NetflowpolicingModel, v : Double) -> NetflowpolicingModel {
  let result = net_flow_policing_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_flow_policing_model_min(s : NetflowpolicingModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_policing_model_max(s : NetflowpolicingModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_policing_model_to_string(s : NetflowpolicingModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowpolicingLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_policing_layer_make(size : Int) -> NetflowpolicingLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_policing_layer_len(s : NetflowpolicingLayer) -> Int { s.size }

pub fn net_flow_policing_layer_get(s : NetflowpolicingLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_policing_layer_set(s : NetflowpolicingLayer, i : Int, v : Double) -> NetflowpolicingLayer {
  let result = net_flow_policing_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_flow_policing_layer_sum(s : NetflowpolicingLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_flow_policing_layer_mean(s : NetflowpolicingLayer) -> Double {
  if s.size == 0 { 0.0 } else { net_flow_policing_layer_sum(s) / s.size.to_double() }
}

pub fn net_flow_policing_layer_scale(s : NetflowpolicingLayer, f : Double) -> NetflowpolicingLayer {
  let result = net_flow_policing_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_flow_policing_layer_add(a : NetflowpolicingLayer, b : NetflowpolicingLayer) -> NetflowpolicingLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_flow_policing_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_flow_policing_layer_copy(s : NetflowpolicingLayer) -> NetflowpolicingLayer {
  let result = net_flow_policing_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_flow_policing_layer_fill(s : NetflowpolicingLayer, v : Double) -> NetflowpolicingLayer {
  let result = net_flow_policing_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_flow_policing_layer_min(s : NetflowpolicingLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_policing_layer_max(s : NetflowpolicingLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_policing_layer_to_string(s : NetflowpolicingLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowpolicingBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_policing_buffer_make(size : Int) -> NetflowpolicingBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_policing_buffer_len(s : NetflowpolicingBuffer) -> Int { s.size }

pub fn net_flow_policing_buffer_get(s : NetflowpolicingBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_policing_buffer_set(s : NetflowpolicingBuffer, i : Int, v : Double) -> NetflowpolicingBuffer {
  let result = net_flow_policing_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_flow_policing_buffer_sum(s : NetflowpolicingBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_flow_policing_buffer_mean(s : NetflowpolicingBuffer) -> Double {
  if s.size == 0 { 0.0 } else { net_flow_policing_buffer_sum(s) / s.size.to_double() }
}

pub fn net_flow_policing_buffer_scale(s : NetflowpolicingBuffer, f : Double) -> NetflowpolicingBuffer {
  let result = net_flow_policing_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_flow_policing_buffer_add(a : NetflowpolicingBuffer, b : NetflowpolicingBuffer) -> NetflowpolicingBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_flow_policing_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_flow_policing_buffer_copy(s : NetflowpolicingBuffer) -> NetflowpolicingBuffer {
  let result = net_flow_policing_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_flow_policing_buffer_fill(s : NetflowpolicingBuffer, v : Double) -> NetflowpolicingBuffer {
  let result = net_flow_policing_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_flow_policing_buffer_min(s : NetflowpolicingBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_policing_buffer_max(s : NetflowpolicingBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_policing_buffer_to_string(s : NetflowpolicingBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowpolicingCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_policing_cursor_make(size : Int) -> NetflowpolicingCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_policing_cursor_len(s : NetflowpolicingCursor) -> Int { s.size }

pub fn net_flow_policing_cursor_get(s : NetflowpolicingCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_policing_cursor_set(s : NetflowpolicingCursor, i : Int, v : Double) -> NetflowpolicingCursor {
  let result = net_flow_policing_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_flow_policing_cursor_sum(s : NetflowpolicingCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_flow_policing_cursor_mean(s : NetflowpolicingCursor) -> Double {
  if s.size == 0 { 0.0 } else { net_flow_policing_cursor_sum(s) / s.size.to_double() }
}

pub fn net_flow_policing_cursor_scale(s : NetflowpolicingCursor, f : Double) -> NetflowpolicingCursor {
  let result = net_flow_policing_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_flow_policing_cursor_add(a : NetflowpolicingCursor, b : NetflowpolicingCursor) -> NetflowpolicingCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_flow_policing_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_flow_policing_cursor_copy(s : NetflowpolicingCursor) -> NetflowpolicingCursor {
  let result = net_flow_policing_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_flow_policing_cursor_fill(s : NetflowpolicingCursor, v : Double) -> NetflowpolicingCursor {
  let result = net_flow_policing_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_flow_policing_cursor_min(s : NetflowpolicingCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_policing_cursor_max(s : NetflowpolicingCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_policing_cursor_to_string(s : NetflowpolicingCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowpolicingView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_policing_view_make(size : Int) -> NetflowpolicingView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_policing_view_len(s : NetflowpolicingView) -> Int { s.size }

pub fn net_flow_policing_view_get(s : NetflowpolicingView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_policing_view_set(s : NetflowpolicingView, i : Int, v : Double) -> NetflowpolicingView {
  let result = net_flow_policing_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_flow_policing_view_sum(s : NetflowpolicingView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_flow_policing_view_mean(s : NetflowpolicingView) -> Double {
  if s.size == 0 { 0.0 } else { net_flow_policing_view_sum(s) / s.size.to_double() }
}

pub fn net_flow_policing_view_scale(s : NetflowpolicingView, f : Double) -> NetflowpolicingView {
  let result = net_flow_policing_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_flow_policing_view_add(a : NetflowpolicingView, b : NetflowpolicingView) -> NetflowpolicingView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_flow_policing_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_flow_policing_view_copy(s : NetflowpolicingView) -> NetflowpolicingView {
  let result = net_flow_policing_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_flow_policing_view_fill(s : NetflowpolicingView, v : Double) -> NetflowpolicingView {
  let result = net_flow_policing_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_flow_policing_view_min(s : NetflowpolicingView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_policing_view_max(s : NetflowpolicingView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_policing_view_to_string(s : NetflowpolicingView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowpolicingRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_policing_range_make(size : Int) -> NetflowpolicingRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_policing_range_len(s : NetflowpolicingRange) -> Int { s.size }

pub fn net_flow_policing_range_get(s : NetflowpolicingRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_policing_range_set(s : NetflowpolicingRange, i : Int, v : Double) -> NetflowpolicingRange {
  let result = net_flow_policing_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_flow_policing_range_sum(s : NetflowpolicingRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_flow_policing_range_mean(s : NetflowpolicingRange) -> Double {
  if s.size == 0 { 0.0 } else { net_flow_policing_range_sum(s) / s.size.to_double() }
}

pub fn net_flow_policing_range_scale(s : NetflowpolicingRange, f : Double) -> NetflowpolicingRange {
  let result = net_flow_policing_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_flow_policing_range_add(a : NetflowpolicingRange, b : NetflowpolicingRange) -> NetflowpolicingRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_flow_policing_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_flow_policing_range_copy(s : NetflowpolicingRange) -> NetflowpolicingRange {
  let result = net_flow_policing_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_flow_policing_range_fill(s : NetflowpolicingRange, v : Double) -> NetflowpolicingRange {
  let result = net_flow_policing_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_flow_policing_range_min(s : NetflowpolicingRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_policing_range_max(s : NetflowpolicingRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_policing_range_to_string(s : NetflowpolicingRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowpolicingSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_policing_slice_make(size : Int) -> NetflowpolicingSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_policing_slice_len(s : NetflowpolicingSlice) -> Int { s.size }

pub fn net_flow_policing_slice_get(s : NetflowpolicingSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_policing_slice_set(s : NetflowpolicingSlice, i : Int, v : Double) -> NetflowpolicingSlice {
  let result = net_flow_policing_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_flow_policing_slice_sum(s : NetflowpolicingSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_flow_policing_slice_mean(s : NetflowpolicingSlice) -> Double {
  if s.size == 0 { 0.0 } else { net_flow_policing_slice_sum(s) / s.size.to_double() }
}

pub fn net_flow_policing_slice_scale(s : NetflowpolicingSlice, f : Double) -> NetflowpolicingSlice {
  let result = net_flow_policing_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_flow_policing_slice_add(a : NetflowpolicingSlice, b : NetflowpolicingSlice) -> NetflowpolicingSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_flow_policing_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_flow_policing_slice_copy(s : NetflowpolicingSlice) -> NetflowpolicingSlice {
  let result = net_flow_policing_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_flow_policing_slice_fill(s : NetflowpolicingSlice, v : Double) -> NetflowpolicingSlice {
  let result = net_flow_policing_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_flow_policing_slice_min(s : NetflowpolicingSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_policing_slice_max(s : NetflowpolicingSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_policing_slice_to_string(s : NetflowpolicingSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

