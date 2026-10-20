///===
/// extcore/net_flow_congestion

pub(all) struct NetflowcongestionPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn net_flow_congestion_make_point(x : Double, y : Double) -> NetflowcongestionPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn net_flow_congestion_make_point3(x : Double, y : Double, z : Double) -> NetflowcongestionPoint {
  { x, y, z, label: 0 }
}

pub fn net_flow_congestion_point_x(pt : NetflowcongestionPoint) -> Double { pt.x }

pub fn net_flow_congestion_point_y(pt : NetflowcongestionPoint) -> Double { pt.y }

pub fn net_flow_congestion_point_z(pt : NetflowcongestionPoint) -> Double { pt.z }

pub fn net_flow_congestion_point_label(pt : NetflowcongestionPoint) -> Int { pt.label }

pub fn net_flow_congestion_point_dist(a : NetflowcongestionPoint, b : NetflowcongestionPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn net_flow_congestion_point_add(a : NetflowcongestionPoint, b : NetflowcongestionPoint) -> NetflowcongestionPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn net_flow_congestion_point_sub(a : NetflowcongestionPoint, b : NetflowcongestionPoint) -> NetflowcongestionPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn net_flow_congestion_point_scale(pt : NetflowcongestionPoint, s : Double) -> NetflowcongestionPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn net_flow_congestion_point_dot(a : NetflowcongestionPoint, b : NetflowcongestionPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn net_flow_congestion_point_cross(a : NetflowcongestionPoint, b : NetflowcongestionPoint) -> NetflowcongestionPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn net_flow_congestion_point_norm(pt : NetflowcongestionPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn net_flow_congestion_point_normalize(pt : NetflowcongestionPoint) -> NetflowcongestionPoint {
  let n = net_flow_congestion_point_norm(pt)
  if n < 0.0000001 { pt } else { net_flow_congestion_point_scale(pt, 1.0 / n) }
}

pub fn net_flow_congestion_point_negate(pt : NetflowcongestionPoint) -> NetflowcongestionPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn net_flow_congestion_point_mid(a : NetflowcongestionPoint, b : NetflowcongestionPoint) -> NetflowcongestionPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn net_flow_congestion_point_lerp(a : NetflowcongestionPoint, b : NetflowcongestionPoint, t : Double) -> NetflowcongestionPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn net_flow_congestion_point_to_string(pt : NetflowcongestionPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct NetflowcongestionSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn net_flow_congestion_make_series(vals : Array[Double], name : String) -> NetflowcongestionSeries {
  { vals, name, meta: 0 }
}

pub fn net_flow_congestion_series_len(s : NetflowcongestionSeries) -> Int { s.vals.length() }

pub fn net_flow_congestion_series_sum(s : NetflowcongestionSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn net_flow_congestion_series_mean(s : NetflowcongestionSeries) -> Double { @_common.mean(s.vals) }

pub fn net_flow_congestion_series_min(s : NetflowcongestionSeries) -> Double { @_common.min(s.vals) }

pub fn net_flow_congestion_series_max(s : NetflowcongestionSeries) -> Double { @_common.max(s.vals) }

pub fn net_flow_congestion_series_range(s : NetflowcongestionSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn net_flow_congestion_series_var(s : NetflowcongestionSeries) -> Double { @_common.variance(s.vals) }

pub fn net_flow_congestion_series_std(s : NetflowcongestionSeries) -> Double { @_common.std(s.vals) }

pub fn net_flow_congestion_series_median(s : NetflowcongestionSeries) -> Double { @_common.median(s.vals) }

pub fn net_flow_congestion_series_scale(s : NetflowcongestionSeries, f : Double) -> NetflowcongestionSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn net_flow_congestion_series_add(a : NetflowcongestionSeries, b : NetflowcongestionSeries) -> NetflowcongestionSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn net_flow_congestion_series_sub(a : NetflowcongestionSeries, b : NetflowcongestionSeries) -> NetflowcongestionSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn net_flow_congestion_series_normalize(s : NetflowcongestionSeries) -> NetflowcongestionSeries {
  let mn = net_flow_congestion_series_min(s)
  let mx = net_flow_congestion_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn net_flow_congestion_series_cumsum(s : NetflowcongestionSeries) -> NetflowcongestionSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn net_flow_congestion_series_to_string(s : NetflowcongestionSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NetflowcongestionMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn net_flow_congestion_make_matrix(rows : Int, cols : Int, val : Double) -> NetflowcongestionMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn net_flow_congestion_matrix_identity(n : Int) -> NetflowcongestionMatrix {
  let m = net_flow_congestion_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn net_flow_congestion_matrix_get(m : NetflowcongestionMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn net_flow_congestion_matrix_transpose(m : NetflowcongestionMatrix) -> NetflowcongestionMatrix {
  let result = net_flow_congestion_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn net_flow_congestion_matrix_add(a : NetflowcongestionMatrix, b : NetflowcongestionMatrix) -> NetflowcongestionMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = net_flow_congestion_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn net_flow_congestion_matrix_scale(m : NetflowcongestionMatrix, s : Double) -> NetflowcongestionMatrix {
  let result = net_flow_congestion_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn net_flow_congestion_matrix_multiply(a : NetflowcongestionMatrix, b : NetflowcongestionMatrix) -> NetflowcongestionMatrix {
  if a.cols != b.rows { return net_flow_congestion_make_matrix(a.rows, b.cols, 0.0) }
  let result = net_flow_congestion_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn net_flow_congestion_matrix_trace(m : NetflowcongestionMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn net_flow_congestion_matrix_det(m : NetflowcongestionMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn net_flow_congestion_matrix_norm(m : NetflowcongestionMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn net_flow_congestion_matrix_to_string(m : NetflowcongestionMatrix) -> String {
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

pub(all) struct NetflowcongestionVector {
  comps : Array[Double]
  dim : Int
}

pub fn net_flow_congestion_make_vector(comps : Array[Double]) -> NetflowcongestionVector {
  { comps, dim: comps.length() }
}

pub fn net_flow_congestion_vector_zero(dim : Int) -> NetflowcongestionVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn net_flow_congestion_vector_add(a : NetflowcongestionVector, b : NetflowcongestionVector) -> NetflowcongestionVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn net_flow_congestion_vector_sub(a : NetflowcongestionVector, b : NetflowcongestionVector) -> NetflowcongestionVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn net_flow_congestion_vector_scale(v : NetflowcongestionVector, s : Double) -> NetflowcongestionVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn net_flow_congestion_vector_dot(a : NetflowcongestionVector, b : NetflowcongestionVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn net_flow_congestion_vector_norm(v : NetflowcongestionVector) -> Double { @_common.sqrt(net_flow_congestion_vector_dot(v, v)) }

pub fn net_flow_congestion_vector_normalize(v : NetflowcongestionVector) -> NetflowcongestionVector {
  let n = net_flow_congestion_vector_norm(v)
  if n < 0.0000001 { v } else { net_flow_congestion_vector_scale(v, 1.0 / n) }
}

pub fn net_flow_congestion_vector_dist(a : NetflowcongestionVector, b : NetflowcongestionVector) -> Double {
  net_flow_congestion_vector_norm(net_flow_congestion_vector_sub(a, b))
}

pub fn net_flow_congestion_vector_to_string(v : NetflowcongestionVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn net_flow_congestion_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn net_flow_congestion_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn net_flow_congestion_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn net_flow_congestion_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn net_flow_congestion_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn net_flow_congestion_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn net_flow_congestion_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn net_flow_congestion_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn net_flow_congestion_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn net_flow_congestion_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn net_flow_congestion_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn net_flow_congestion_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn net_flow_congestion_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn net_flow_congestion_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn net_flow_congestion_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn net_flow_congestion_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn net_flow_congestion_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn net_flow_congestion_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn net_flow_congestion_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn net_flow_congestion_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn net_flow_congestion_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn net_flow_congestion_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn net_flow_congestion_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn net_flow_congestion_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn net_flow_congestion_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn net_flow_congestion_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn net_flow_congestion_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn net_flow_congestion_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn net_flow_congestion_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct NetflowcongestionFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_congestion_frame_make(size : Int) -> NetflowcongestionFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_congestion_frame_len(s : NetflowcongestionFrame) -> Int { s.size }

pub fn net_flow_congestion_frame_get(s : NetflowcongestionFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_congestion_frame_set(s : NetflowcongestionFrame, i : Int, v : Double) -> NetflowcongestionFrame {
  let result = net_flow_congestion_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_flow_congestion_frame_sum(s : NetflowcongestionFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_flow_congestion_frame_mean(s : NetflowcongestionFrame) -> Double {
  if s.size == 0 { 0.0 } else { net_flow_congestion_frame_sum(s) / s.size.to_double() }
}

pub fn net_flow_congestion_frame_scale(s : NetflowcongestionFrame, f : Double) -> NetflowcongestionFrame {
  let result = net_flow_congestion_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_flow_congestion_frame_add(a : NetflowcongestionFrame, b : NetflowcongestionFrame) -> NetflowcongestionFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_flow_congestion_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_flow_congestion_frame_copy(s : NetflowcongestionFrame) -> NetflowcongestionFrame {
  let result = net_flow_congestion_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_flow_congestion_frame_fill(s : NetflowcongestionFrame, v : Double) -> NetflowcongestionFrame {
  let result = net_flow_congestion_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_flow_congestion_frame_min(s : NetflowcongestionFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_congestion_frame_max(s : NetflowcongestionFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_congestion_frame_to_string(s : NetflowcongestionFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowcongestionTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_congestion_table_make(size : Int) -> NetflowcongestionTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_congestion_table_len(s : NetflowcongestionTable) -> Int { s.size }

pub fn net_flow_congestion_table_get(s : NetflowcongestionTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_congestion_table_set(s : NetflowcongestionTable, i : Int, v : Double) -> NetflowcongestionTable {
  let result = net_flow_congestion_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_flow_congestion_table_sum(s : NetflowcongestionTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_flow_congestion_table_mean(s : NetflowcongestionTable) -> Double {
  if s.size == 0 { 0.0 } else { net_flow_congestion_table_sum(s) / s.size.to_double() }
}

pub fn net_flow_congestion_table_scale(s : NetflowcongestionTable, f : Double) -> NetflowcongestionTable {
  let result = net_flow_congestion_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_flow_congestion_table_add(a : NetflowcongestionTable, b : NetflowcongestionTable) -> NetflowcongestionTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_flow_congestion_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_flow_congestion_table_copy(s : NetflowcongestionTable) -> NetflowcongestionTable {
  let result = net_flow_congestion_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_flow_congestion_table_fill(s : NetflowcongestionTable, v : Double) -> NetflowcongestionTable {
  let result = net_flow_congestion_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_flow_congestion_table_min(s : NetflowcongestionTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_congestion_table_max(s : NetflowcongestionTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_congestion_table_to_string(s : NetflowcongestionTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowcongestionGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_congestion_graphn_make(size : Int) -> NetflowcongestionGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_congestion_graphn_len(s : NetflowcongestionGraphN) -> Int { s.size }

pub fn net_flow_congestion_graphn_get(s : NetflowcongestionGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_congestion_graphn_set(s : NetflowcongestionGraphN, i : Int, v : Double) -> NetflowcongestionGraphN {
  let result = net_flow_congestion_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_flow_congestion_graphn_sum(s : NetflowcongestionGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_flow_congestion_graphn_mean(s : NetflowcongestionGraphN) -> Double {
  if s.size == 0 { 0.0 } else { net_flow_congestion_graphn_sum(s) / s.size.to_double() }
}

pub fn net_flow_congestion_graphn_scale(s : NetflowcongestionGraphN, f : Double) -> NetflowcongestionGraphN {
  let result = net_flow_congestion_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_flow_congestion_graphn_add(a : NetflowcongestionGraphN, b : NetflowcongestionGraphN) -> NetflowcongestionGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_flow_congestion_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_flow_congestion_graphn_copy(s : NetflowcongestionGraphN) -> NetflowcongestionGraphN {
  let result = net_flow_congestion_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_flow_congestion_graphn_fill(s : NetflowcongestionGraphN, v : Double) -> NetflowcongestionGraphN {
  let result = net_flow_congestion_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_flow_congestion_graphn_min(s : NetflowcongestionGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_congestion_graphn_max(s : NetflowcongestionGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_congestion_graphn_to_string(s : NetflowcongestionGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowcongestionNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_congestion_node_make(size : Int) -> NetflowcongestionNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_congestion_node_len(s : NetflowcongestionNode) -> Int { s.size }

pub fn net_flow_congestion_node_get(s : NetflowcongestionNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_congestion_node_set(s : NetflowcongestionNode, i : Int, v : Double) -> NetflowcongestionNode {
  let result = net_flow_congestion_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_flow_congestion_node_sum(s : NetflowcongestionNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_flow_congestion_node_mean(s : NetflowcongestionNode) -> Double {
  if s.size == 0 { 0.0 } else { net_flow_congestion_node_sum(s) / s.size.to_double() }
}

pub fn net_flow_congestion_node_scale(s : NetflowcongestionNode, f : Double) -> NetflowcongestionNode {
  let result = net_flow_congestion_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_flow_congestion_node_add(a : NetflowcongestionNode, b : NetflowcongestionNode) -> NetflowcongestionNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_flow_congestion_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_flow_congestion_node_copy(s : NetflowcongestionNode) -> NetflowcongestionNode {
  let result = net_flow_congestion_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_flow_congestion_node_fill(s : NetflowcongestionNode, v : Double) -> NetflowcongestionNode {
  let result = net_flow_congestion_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_flow_congestion_node_min(s : NetflowcongestionNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_congestion_node_max(s : NetflowcongestionNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_congestion_node_to_string(s : NetflowcongestionNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowcongestionEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_congestion_edge_make(size : Int) -> NetflowcongestionEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_congestion_edge_len(s : NetflowcongestionEdge) -> Int { s.size }

pub fn net_flow_congestion_edge_get(s : NetflowcongestionEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_congestion_edge_set(s : NetflowcongestionEdge, i : Int, v : Double) -> NetflowcongestionEdge {
  let result = net_flow_congestion_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_flow_congestion_edge_sum(s : NetflowcongestionEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_flow_congestion_edge_mean(s : NetflowcongestionEdge) -> Double {
  if s.size == 0 { 0.0 } else { net_flow_congestion_edge_sum(s) / s.size.to_double() }
}

pub fn net_flow_congestion_edge_scale(s : NetflowcongestionEdge, f : Double) -> NetflowcongestionEdge {
  let result = net_flow_congestion_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_flow_congestion_edge_add(a : NetflowcongestionEdge, b : NetflowcongestionEdge) -> NetflowcongestionEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_flow_congestion_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_flow_congestion_edge_copy(s : NetflowcongestionEdge) -> NetflowcongestionEdge {
  let result = net_flow_congestion_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_flow_congestion_edge_fill(s : NetflowcongestionEdge, v : Double) -> NetflowcongestionEdge {
  let result = net_flow_congestion_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_flow_congestion_edge_min(s : NetflowcongestionEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_congestion_edge_max(s : NetflowcongestionEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_congestion_edge_to_string(s : NetflowcongestionEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowcongestionPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_congestion_path_make(size : Int) -> NetflowcongestionPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_congestion_path_len(s : NetflowcongestionPath) -> Int { s.size }

pub fn net_flow_congestion_path_get(s : NetflowcongestionPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_congestion_path_set(s : NetflowcongestionPath, i : Int, v : Double) -> NetflowcongestionPath {
  let result = net_flow_congestion_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_flow_congestion_path_sum(s : NetflowcongestionPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_flow_congestion_path_mean(s : NetflowcongestionPath) -> Double {
  if s.size == 0 { 0.0 } else { net_flow_congestion_path_sum(s) / s.size.to_double() }
}

pub fn net_flow_congestion_path_scale(s : NetflowcongestionPath, f : Double) -> NetflowcongestionPath {
  let result = net_flow_congestion_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_flow_congestion_path_add(a : NetflowcongestionPath, b : NetflowcongestionPath) -> NetflowcongestionPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_flow_congestion_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_flow_congestion_path_copy(s : NetflowcongestionPath) -> NetflowcongestionPath {
  let result = net_flow_congestion_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_flow_congestion_path_fill(s : NetflowcongestionPath, v : Double) -> NetflowcongestionPath {
  let result = net_flow_congestion_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_flow_congestion_path_min(s : NetflowcongestionPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_congestion_path_max(s : NetflowcongestionPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_congestion_path_to_string(s : NetflowcongestionPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowcongestionCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_congestion_cluster_make(size : Int) -> NetflowcongestionCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_congestion_cluster_len(s : NetflowcongestionCluster) -> Int { s.size }

pub fn net_flow_congestion_cluster_get(s : NetflowcongestionCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_congestion_cluster_set(s : NetflowcongestionCluster, i : Int, v : Double) -> NetflowcongestionCluster {
  let result = net_flow_congestion_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_flow_congestion_cluster_sum(s : NetflowcongestionCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_flow_congestion_cluster_mean(s : NetflowcongestionCluster) -> Double {
  if s.size == 0 { 0.0 } else { net_flow_congestion_cluster_sum(s) / s.size.to_double() }
}

pub fn net_flow_congestion_cluster_scale(s : NetflowcongestionCluster, f : Double) -> NetflowcongestionCluster {
  let result = net_flow_congestion_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_flow_congestion_cluster_add(a : NetflowcongestionCluster, b : NetflowcongestionCluster) -> NetflowcongestionCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_flow_congestion_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_flow_congestion_cluster_copy(s : NetflowcongestionCluster) -> NetflowcongestionCluster {
  let result = net_flow_congestion_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_flow_congestion_cluster_fill(s : NetflowcongestionCluster, v : Double) -> NetflowcongestionCluster {
  let result = net_flow_congestion_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_flow_congestion_cluster_min(s : NetflowcongestionCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_congestion_cluster_max(s : NetflowcongestionCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_congestion_cluster_to_string(s : NetflowcongestionCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowcongestionModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_congestion_model_make(size : Int) -> NetflowcongestionModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_congestion_model_len(s : NetflowcongestionModel) -> Int { s.size }

pub fn net_flow_congestion_model_get(s : NetflowcongestionModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_congestion_model_set(s : NetflowcongestionModel, i : Int, v : Double) -> NetflowcongestionModel {
  let result = net_flow_congestion_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_flow_congestion_model_sum(s : NetflowcongestionModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_flow_congestion_model_mean(s : NetflowcongestionModel) -> Double {
  if s.size == 0 { 0.0 } else { net_flow_congestion_model_sum(s) / s.size.to_double() }
}

pub fn net_flow_congestion_model_scale(s : NetflowcongestionModel, f : Double) -> NetflowcongestionModel {
  let result = net_flow_congestion_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_flow_congestion_model_add(a : NetflowcongestionModel, b : NetflowcongestionModel) -> NetflowcongestionModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_flow_congestion_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_flow_congestion_model_copy(s : NetflowcongestionModel) -> NetflowcongestionModel {
  let result = net_flow_congestion_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_flow_congestion_model_fill(s : NetflowcongestionModel, v : Double) -> NetflowcongestionModel {
  let result = net_flow_congestion_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_flow_congestion_model_min(s : NetflowcongestionModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_congestion_model_max(s : NetflowcongestionModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_congestion_model_to_string(s : NetflowcongestionModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowcongestionLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_congestion_layer_make(size : Int) -> NetflowcongestionLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_congestion_layer_len(s : NetflowcongestionLayer) -> Int { s.size }

pub fn net_flow_congestion_layer_get(s : NetflowcongestionLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_congestion_layer_set(s : NetflowcongestionLayer, i : Int, v : Double) -> NetflowcongestionLayer {
  let result = net_flow_congestion_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_flow_congestion_layer_sum(s : NetflowcongestionLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_flow_congestion_layer_mean(s : NetflowcongestionLayer) -> Double {
  if s.size == 0 { 0.0 } else { net_flow_congestion_layer_sum(s) / s.size.to_double() }
}

pub fn net_flow_congestion_layer_scale(s : NetflowcongestionLayer, f : Double) -> NetflowcongestionLayer {
  let result = net_flow_congestion_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_flow_congestion_layer_add(a : NetflowcongestionLayer, b : NetflowcongestionLayer) -> NetflowcongestionLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_flow_congestion_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_flow_congestion_layer_copy(s : NetflowcongestionLayer) -> NetflowcongestionLayer {
  let result = net_flow_congestion_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_flow_congestion_layer_fill(s : NetflowcongestionLayer, v : Double) -> NetflowcongestionLayer {
  let result = net_flow_congestion_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_flow_congestion_layer_min(s : NetflowcongestionLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_congestion_layer_max(s : NetflowcongestionLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_congestion_layer_to_string(s : NetflowcongestionLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowcongestionBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_congestion_buffer_make(size : Int) -> NetflowcongestionBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_congestion_buffer_len(s : NetflowcongestionBuffer) -> Int { s.size }

pub fn net_flow_congestion_buffer_get(s : NetflowcongestionBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_congestion_buffer_set(s : NetflowcongestionBuffer, i : Int, v : Double) -> NetflowcongestionBuffer {
  let result = net_flow_congestion_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_flow_congestion_buffer_sum(s : NetflowcongestionBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_flow_congestion_buffer_mean(s : NetflowcongestionBuffer) -> Double {
  if s.size == 0 { 0.0 } else { net_flow_congestion_buffer_sum(s) / s.size.to_double() }
}

pub fn net_flow_congestion_buffer_scale(s : NetflowcongestionBuffer, f : Double) -> NetflowcongestionBuffer {
  let result = net_flow_congestion_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_flow_congestion_buffer_add(a : NetflowcongestionBuffer, b : NetflowcongestionBuffer) -> NetflowcongestionBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_flow_congestion_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_flow_congestion_buffer_copy(s : NetflowcongestionBuffer) -> NetflowcongestionBuffer {
  let result = net_flow_congestion_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_flow_congestion_buffer_fill(s : NetflowcongestionBuffer, v : Double) -> NetflowcongestionBuffer {
  let result = net_flow_congestion_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_flow_congestion_buffer_min(s : NetflowcongestionBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_congestion_buffer_max(s : NetflowcongestionBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_congestion_buffer_to_string(s : NetflowcongestionBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowcongestionCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_congestion_cursor_make(size : Int) -> NetflowcongestionCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_congestion_cursor_len(s : NetflowcongestionCursor) -> Int { s.size }

pub fn net_flow_congestion_cursor_get(s : NetflowcongestionCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_congestion_cursor_set(s : NetflowcongestionCursor, i : Int, v : Double) -> NetflowcongestionCursor {
  let result = net_flow_congestion_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_flow_congestion_cursor_sum(s : NetflowcongestionCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_flow_congestion_cursor_mean(s : NetflowcongestionCursor) -> Double {
  if s.size == 0 { 0.0 } else { net_flow_congestion_cursor_sum(s) / s.size.to_double() }
}

pub fn net_flow_congestion_cursor_scale(s : NetflowcongestionCursor, f : Double) -> NetflowcongestionCursor {
  let result = net_flow_congestion_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_flow_congestion_cursor_add(a : NetflowcongestionCursor, b : NetflowcongestionCursor) -> NetflowcongestionCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_flow_congestion_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_flow_congestion_cursor_copy(s : NetflowcongestionCursor) -> NetflowcongestionCursor {
  let result = net_flow_congestion_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_flow_congestion_cursor_fill(s : NetflowcongestionCursor, v : Double) -> NetflowcongestionCursor {
  let result = net_flow_congestion_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_flow_congestion_cursor_min(s : NetflowcongestionCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_congestion_cursor_max(s : NetflowcongestionCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_congestion_cursor_to_string(s : NetflowcongestionCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowcongestionView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_congestion_view_make(size : Int) -> NetflowcongestionView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_congestion_view_len(s : NetflowcongestionView) -> Int { s.size }

pub fn net_flow_congestion_view_get(s : NetflowcongestionView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_congestion_view_set(s : NetflowcongestionView, i : Int, v : Double) -> NetflowcongestionView {
  let result = net_flow_congestion_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_flow_congestion_view_sum(s : NetflowcongestionView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_flow_congestion_view_mean(s : NetflowcongestionView) -> Double {
  if s.size == 0 { 0.0 } else { net_flow_congestion_view_sum(s) / s.size.to_double() }
}

pub fn net_flow_congestion_view_scale(s : NetflowcongestionView, f : Double) -> NetflowcongestionView {
  let result = net_flow_congestion_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_flow_congestion_view_add(a : NetflowcongestionView, b : NetflowcongestionView) -> NetflowcongestionView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_flow_congestion_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_flow_congestion_view_copy(s : NetflowcongestionView) -> NetflowcongestionView {
  let result = net_flow_congestion_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_flow_congestion_view_fill(s : NetflowcongestionView, v : Double) -> NetflowcongestionView {
  let result = net_flow_congestion_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_flow_congestion_view_min(s : NetflowcongestionView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_congestion_view_max(s : NetflowcongestionView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_congestion_view_to_string(s : NetflowcongestionView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowcongestionRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_congestion_range_make(size : Int) -> NetflowcongestionRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_congestion_range_len(s : NetflowcongestionRange) -> Int { s.size }

pub fn net_flow_congestion_range_get(s : NetflowcongestionRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_congestion_range_set(s : NetflowcongestionRange, i : Int, v : Double) -> NetflowcongestionRange {
  let result = net_flow_congestion_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_flow_congestion_range_sum(s : NetflowcongestionRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_flow_congestion_range_mean(s : NetflowcongestionRange) -> Double {
  if s.size == 0 { 0.0 } else { net_flow_congestion_range_sum(s) / s.size.to_double() }
}

pub fn net_flow_congestion_range_scale(s : NetflowcongestionRange, f : Double) -> NetflowcongestionRange {
  let result = net_flow_congestion_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_flow_congestion_range_add(a : NetflowcongestionRange, b : NetflowcongestionRange) -> NetflowcongestionRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_flow_congestion_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_flow_congestion_range_copy(s : NetflowcongestionRange) -> NetflowcongestionRange {
  let result = net_flow_congestion_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_flow_congestion_range_fill(s : NetflowcongestionRange, v : Double) -> NetflowcongestionRange {
  let result = net_flow_congestion_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_flow_congestion_range_min(s : NetflowcongestionRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_congestion_range_max(s : NetflowcongestionRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_congestion_range_to_string(s : NetflowcongestionRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowcongestionSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_congestion_slice_make(size : Int) -> NetflowcongestionSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_congestion_slice_len(s : NetflowcongestionSlice) -> Int { s.size }

pub fn net_flow_congestion_slice_get(s : NetflowcongestionSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_congestion_slice_set(s : NetflowcongestionSlice, i : Int, v : Double) -> NetflowcongestionSlice {
  let result = net_flow_congestion_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_flow_congestion_slice_sum(s : NetflowcongestionSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_flow_congestion_slice_mean(s : NetflowcongestionSlice) -> Double {
  if s.size == 0 { 0.0 } else { net_flow_congestion_slice_sum(s) / s.size.to_double() }
}

pub fn net_flow_congestion_slice_scale(s : NetflowcongestionSlice, f : Double) -> NetflowcongestionSlice {
  let result = net_flow_congestion_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_flow_congestion_slice_add(a : NetflowcongestionSlice, b : NetflowcongestionSlice) -> NetflowcongestionSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_flow_congestion_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_flow_congestion_slice_copy(s : NetflowcongestionSlice) -> NetflowcongestionSlice {
  let result = net_flow_congestion_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_flow_congestion_slice_fill(s : NetflowcongestionSlice, v : Double) -> NetflowcongestionSlice {
  let result = net_flow_congestion_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_flow_congestion_slice_min(s : NetflowcongestionSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_congestion_slice_max(s : NetflowcongestionSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_congestion_slice_to_string(s : NetflowcongestionSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

