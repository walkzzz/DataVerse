///===
/// extcore/net_proto_udp

pub(all) struct NetprotoudpPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn net_proto_udp_make_point(x : Double, y : Double) -> NetprotoudpPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn net_proto_udp_make_point3(x : Double, y : Double, z : Double) -> NetprotoudpPoint {
  { x, y, z, label: 0 }
}

pub fn net_proto_udp_point_x(pt : NetprotoudpPoint) -> Double { pt.x }

pub fn net_proto_udp_point_y(pt : NetprotoudpPoint) -> Double { pt.y }

pub fn net_proto_udp_point_z(pt : NetprotoudpPoint) -> Double { pt.z }

pub fn net_proto_udp_point_label(pt : NetprotoudpPoint) -> Int { pt.label }

pub fn net_proto_udp_point_dist(a : NetprotoudpPoint, b : NetprotoudpPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn net_proto_udp_point_add(a : NetprotoudpPoint, b : NetprotoudpPoint) -> NetprotoudpPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn net_proto_udp_point_sub(a : NetprotoudpPoint, b : NetprotoudpPoint) -> NetprotoudpPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn net_proto_udp_point_scale(pt : NetprotoudpPoint, s : Double) -> NetprotoudpPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn net_proto_udp_point_dot(a : NetprotoudpPoint, b : NetprotoudpPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn net_proto_udp_point_cross(a : NetprotoudpPoint, b : NetprotoudpPoint) -> NetprotoudpPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn net_proto_udp_point_norm(pt : NetprotoudpPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn net_proto_udp_point_normalize(pt : NetprotoudpPoint) -> NetprotoudpPoint {
  let n = net_proto_udp_point_norm(pt)
  if n < 0.0000001 { pt } else { net_proto_udp_point_scale(pt, 1.0 / n) }
}

pub fn net_proto_udp_point_negate(pt : NetprotoudpPoint) -> NetprotoudpPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn net_proto_udp_point_mid(a : NetprotoudpPoint, b : NetprotoudpPoint) -> NetprotoudpPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn net_proto_udp_point_lerp(a : NetprotoudpPoint, b : NetprotoudpPoint, t : Double) -> NetprotoudpPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn net_proto_udp_point_to_string(pt : NetprotoudpPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct NetprotoudpSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn net_proto_udp_make_series(vals : Array[Double], name : String) -> NetprotoudpSeries {
  { vals, name, meta: 0 }
}

pub fn net_proto_udp_series_len(s : NetprotoudpSeries) -> Int { s.vals.length() }

pub fn net_proto_udp_series_sum(s : NetprotoudpSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn net_proto_udp_series_mean(s : NetprotoudpSeries) -> Double { @_common.mean(s.vals) }

pub fn net_proto_udp_series_min(s : NetprotoudpSeries) -> Double { @_common.min(s.vals) }

pub fn net_proto_udp_series_max(s : NetprotoudpSeries) -> Double { @_common.max(s.vals) }

pub fn net_proto_udp_series_range(s : NetprotoudpSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn net_proto_udp_series_var(s : NetprotoudpSeries) -> Double { @_common.variance(s.vals) }

pub fn net_proto_udp_series_std(s : NetprotoudpSeries) -> Double { @_common.std(s.vals) }

pub fn net_proto_udp_series_median(s : NetprotoudpSeries) -> Double { @_common.median(s.vals) }

pub fn net_proto_udp_series_scale(s : NetprotoudpSeries, f : Double) -> NetprotoudpSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn net_proto_udp_series_add(a : NetprotoudpSeries, b : NetprotoudpSeries) -> NetprotoudpSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn net_proto_udp_series_sub(a : NetprotoudpSeries, b : NetprotoudpSeries) -> NetprotoudpSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn net_proto_udp_series_normalize(s : NetprotoudpSeries) -> NetprotoudpSeries {
  let mn = net_proto_udp_series_min(s)
  let mx = net_proto_udp_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn net_proto_udp_series_cumsum(s : NetprotoudpSeries) -> NetprotoudpSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn net_proto_udp_series_to_string(s : NetprotoudpSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NetprotoudpMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn net_proto_udp_make_matrix(rows : Int, cols : Int, val : Double) -> NetprotoudpMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn net_proto_udp_matrix_identity(n : Int) -> NetprotoudpMatrix {
  let m = net_proto_udp_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn net_proto_udp_matrix_get(m : NetprotoudpMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn net_proto_udp_matrix_transpose(m : NetprotoudpMatrix) -> NetprotoudpMatrix {
  let result = net_proto_udp_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn net_proto_udp_matrix_add(a : NetprotoudpMatrix, b : NetprotoudpMatrix) -> NetprotoudpMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = net_proto_udp_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn net_proto_udp_matrix_scale(m : NetprotoudpMatrix, s : Double) -> NetprotoudpMatrix {
  let result = net_proto_udp_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn net_proto_udp_matrix_multiply(a : NetprotoudpMatrix, b : NetprotoudpMatrix) -> NetprotoudpMatrix {
  if a.cols != b.rows { return net_proto_udp_make_matrix(a.rows, b.cols, 0.0) }
  let result = net_proto_udp_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn net_proto_udp_matrix_trace(m : NetprotoudpMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn net_proto_udp_matrix_det(m : NetprotoudpMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn net_proto_udp_matrix_norm(m : NetprotoudpMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn net_proto_udp_matrix_to_string(m : NetprotoudpMatrix) -> String {
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

pub(all) struct NetprotoudpVector {
  comps : Array[Double]
  dim : Int
}

pub fn net_proto_udp_make_vector(comps : Array[Double]) -> NetprotoudpVector {
  { comps, dim: comps.length() }
}

pub fn net_proto_udp_vector_zero(dim : Int) -> NetprotoudpVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn net_proto_udp_vector_add(a : NetprotoudpVector, b : NetprotoudpVector) -> NetprotoudpVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn net_proto_udp_vector_sub(a : NetprotoudpVector, b : NetprotoudpVector) -> NetprotoudpVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn net_proto_udp_vector_scale(v : NetprotoudpVector, s : Double) -> NetprotoudpVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn net_proto_udp_vector_dot(a : NetprotoudpVector, b : NetprotoudpVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn net_proto_udp_vector_norm(v : NetprotoudpVector) -> Double { @_common.sqrt(net_proto_udp_vector_dot(v, v)) }

pub fn net_proto_udp_vector_normalize(v : NetprotoudpVector) -> NetprotoudpVector {
  let n = net_proto_udp_vector_norm(v)
  if n < 0.0000001 { v } else { net_proto_udp_vector_scale(v, 1.0 / n) }
}

pub fn net_proto_udp_vector_dist(a : NetprotoudpVector, b : NetprotoudpVector) -> Double {
  net_proto_udp_vector_norm(net_proto_udp_vector_sub(a, b))
}

pub fn net_proto_udp_vector_to_string(v : NetprotoudpVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn net_proto_udp_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn net_proto_udp_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn net_proto_udp_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn net_proto_udp_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn net_proto_udp_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn net_proto_udp_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn net_proto_udp_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn net_proto_udp_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn net_proto_udp_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn net_proto_udp_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn net_proto_udp_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn net_proto_udp_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn net_proto_udp_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn net_proto_udp_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn net_proto_udp_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn net_proto_udp_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn net_proto_udp_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn net_proto_udp_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn net_proto_udp_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn net_proto_udp_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn net_proto_udp_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn net_proto_udp_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn net_proto_udp_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn net_proto_udp_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn net_proto_udp_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn net_proto_udp_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn net_proto_udp_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn net_proto_udp_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn net_proto_udp_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct NetprotoudpFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_udp_frame_make(size : Int) -> NetprotoudpFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_udp_frame_len(s : NetprotoudpFrame) -> Int { s.size }

pub fn net_proto_udp_frame_get(s : NetprotoudpFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_udp_frame_set(s : NetprotoudpFrame, i : Int, v : Double) -> NetprotoudpFrame {
  let result = net_proto_udp_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_proto_udp_frame_sum(s : NetprotoudpFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_proto_udp_frame_mean(s : NetprotoudpFrame) -> Double {
  if s.size == 0 { 0.0 } else { net_proto_udp_frame_sum(s) / s.size.to_double() }
}

pub fn net_proto_udp_frame_scale(s : NetprotoudpFrame, f : Double) -> NetprotoudpFrame {
  let result = net_proto_udp_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_proto_udp_frame_add(a : NetprotoudpFrame, b : NetprotoudpFrame) -> NetprotoudpFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_proto_udp_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_proto_udp_frame_copy(s : NetprotoudpFrame) -> NetprotoudpFrame {
  let result = net_proto_udp_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_proto_udp_frame_fill(s : NetprotoudpFrame, v : Double) -> NetprotoudpFrame {
  let result = net_proto_udp_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_proto_udp_frame_min(s : NetprotoudpFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_udp_frame_max(s : NetprotoudpFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_udp_frame_to_string(s : NetprotoudpFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotoudpTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_udp_table_make(size : Int) -> NetprotoudpTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_udp_table_len(s : NetprotoudpTable) -> Int { s.size }

pub fn net_proto_udp_table_get(s : NetprotoudpTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_udp_table_set(s : NetprotoudpTable, i : Int, v : Double) -> NetprotoudpTable {
  let result = net_proto_udp_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_proto_udp_table_sum(s : NetprotoudpTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_proto_udp_table_mean(s : NetprotoudpTable) -> Double {
  if s.size == 0 { 0.0 } else { net_proto_udp_table_sum(s) / s.size.to_double() }
}

pub fn net_proto_udp_table_scale(s : NetprotoudpTable, f : Double) -> NetprotoudpTable {
  let result = net_proto_udp_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_proto_udp_table_add(a : NetprotoudpTable, b : NetprotoudpTable) -> NetprotoudpTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_proto_udp_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_proto_udp_table_copy(s : NetprotoudpTable) -> NetprotoudpTable {
  let result = net_proto_udp_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_proto_udp_table_fill(s : NetprotoudpTable, v : Double) -> NetprotoudpTable {
  let result = net_proto_udp_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_proto_udp_table_min(s : NetprotoudpTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_udp_table_max(s : NetprotoudpTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_udp_table_to_string(s : NetprotoudpTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotoudpGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_udp_graphn_make(size : Int) -> NetprotoudpGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_udp_graphn_len(s : NetprotoudpGraphN) -> Int { s.size }

pub fn net_proto_udp_graphn_get(s : NetprotoudpGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_udp_graphn_set(s : NetprotoudpGraphN, i : Int, v : Double) -> NetprotoudpGraphN {
  let result = net_proto_udp_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_proto_udp_graphn_sum(s : NetprotoudpGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_proto_udp_graphn_mean(s : NetprotoudpGraphN) -> Double {
  if s.size == 0 { 0.0 } else { net_proto_udp_graphn_sum(s) / s.size.to_double() }
}

pub fn net_proto_udp_graphn_scale(s : NetprotoudpGraphN, f : Double) -> NetprotoudpGraphN {
  let result = net_proto_udp_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_proto_udp_graphn_add(a : NetprotoudpGraphN, b : NetprotoudpGraphN) -> NetprotoudpGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_proto_udp_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_proto_udp_graphn_copy(s : NetprotoudpGraphN) -> NetprotoudpGraphN {
  let result = net_proto_udp_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_proto_udp_graphn_fill(s : NetprotoudpGraphN, v : Double) -> NetprotoudpGraphN {
  let result = net_proto_udp_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_proto_udp_graphn_min(s : NetprotoudpGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_udp_graphn_max(s : NetprotoudpGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_udp_graphn_to_string(s : NetprotoudpGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotoudpNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_udp_node_make(size : Int) -> NetprotoudpNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_udp_node_len(s : NetprotoudpNode) -> Int { s.size }

pub fn net_proto_udp_node_get(s : NetprotoudpNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_udp_node_set(s : NetprotoudpNode, i : Int, v : Double) -> NetprotoudpNode {
  let result = net_proto_udp_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_proto_udp_node_sum(s : NetprotoudpNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_proto_udp_node_mean(s : NetprotoudpNode) -> Double {
  if s.size == 0 { 0.0 } else { net_proto_udp_node_sum(s) / s.size.to_double() }
}

pub fn net_proto_udp_node_scale(s : NetprotoudpNode, f : Double) -> NetprotoudpNode {
  let result = net_proto_udp_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_proto_udp_node_add(a : NetprotoudpNode, b : NetprotoudpNode) -> NetprotoudpNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_proto_udp_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_proto_udp_node_copy(s : NetprotoudpNode) -> NetprotoudpNode {
  let result = net_proto_udp_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_proto_udp_node_fill(s : NetprotoudpNode, v : Double) -> NetprotoudpNode {
  let result = net_proto_udp_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_proto_udp_node_min(s : NetprotoudpNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_udp_node_max(s : NetprotoudpNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_udp_node_to_string(s : NetprotoudpNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotoudpEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_udp_edge_make(size : Int) -> NetprotoudpEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_udp_edge_len(s : NetprotoudpEdge) -> Int { s.size }

pub fn net_proto_udp_edge_get(s : NetprotoudpEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_udp_edge_set(s : NetprotoudpEdge, i : Int, v : Double) -> NetprotoudpEdge {
  let result = net_proto_udp_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_proto_udp_edge_sum(s : NetprotoudpEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_proto_udp_edge_mean(s : NetprotoudpEdge) -> Double {
  if s.size == 0 { 0.0 } else { net_proto_udp_edge_sum(s) / s.size.to_double() }
}

pub fn net_proto_udp_edge_scale(s : NetprotoudpEdge, f : Double) -> NetprotoudpEdge {
  let result = net_proto_udp_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_proto_udp_edge_add(a : NetprotoudpEdge, b : NetprotoudpEdge) -> NetprotoudpEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_proto_udp_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_proto_udp_edge_copy(s : NetprotoudpEdge) -> NetprotoudpEdge {
  let result = net_proto_udp_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_proto_udp_edge_fill(s : NetprotoudpEdge, v : Double) -> NetprotoudpEdge {
  let result = net_proto_udp_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_proto_udp_edge_min(s : NetprotoudpEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_udp_edge_max(s : NetprotoudpEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_udp_edge_to_string(s : NetprotoudpEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotoudpPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_udp_path_make(size : Int) -> NetprotoudpPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_udp_path_len(s : NetprotoudpPath) -> Int { s.size }

pub fn net_proto_udp_path_get(s : NetprotoudpPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_udp_path_set(s : NetprotoudpPath, i : Int, v : Double) -> NetprotoudpPath {
  let result = net_proto_udp_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_proto_udp_path_sum(s : NetprotoudpPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_proto_udp_path_mean(s : NetprotoudpPath) -> Double {
  if s.size == 0 { 0.0 } else { net_proto_udp_path_sum(s) / s.size.to_double() }
}

pub fn net_proto_udp_path_scale(s : NetprotoudpPath, f : Double) -> NetprotoudpPath {
  let result = net_proto_udp_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_proto_udp_path_add(a : NetprotoudpPath, b : NetprotoudpPath) -> NetprotoudpPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_proto_udp_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_proto_udp_path_copy(s : NetprotoudpPath) -> NetprotoudpPath {
  let result = net_proto_udp_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_proto_udp_path_fill(s : NetprotoudpPath, v : Double) -> NetprotoudpPath {
  let result = net_proto_udp_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_proto_udp_path_min(s : NetprotoudpPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_udp_path_max(s : NetprotoudpPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_udp_path_to_string(s : NetprotoudpPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotoudpCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_udp_cluster_make(size : Int) -> NetprotoudpCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_udp_cluster_len(s : NetprotoudpCluster) -> Int { s.size }

pub fn net_proto_udp_cluster_get(s : NetprotoudpCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_udp_cluster_set(s : NetprotoudpCluster, i : Int, v : Double) -> NetprotoudpCluster {
  let result = net_proto_udp_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_proto_udp_cluster_sum(s : NetprotoudpCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_proto_udp_cluster_mean(s : NetprotoudpCluster) -> Double {
  if s.size == 0 { 0.0 } else { net_proto_udp_cluster_sum(s) / s.size.to_double() }
}

pub fn net_proto_udp_cluster_scale(s : NetprotoudpCluster, f : Double) -> NetprotoudpCluster {
  let result = net_proto_udp_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_proto_udp_cluster_add(a : NetprotoudpCluster, b : NetprotoudpCluster) -> NetprotoudpCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_proto_udp_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_proto_udp_cluster_copy(s : NetprotoudpCluster) -> NetprotoudpCluster {
  let result = net_proto_udp_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_proto_udp_cluster_fill(s : NetprotoudpCluster, v : Double) -> NetprotoudpCluster {
  let result = net_proto_udp_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_proto_udp_cluster_min(s : NetprotoudpCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_udp_cluster_max(s : NetprotoudpCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_udp_cluster_to_string(s : NetprotoudpCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotoudpModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_udp_model_make(size : Int) -> NetprotoudpModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_udp_model_len(s : NetprotoudpModel) -> Int { s.size }

pub fn net_proto_udp_model_get(s : NetprotoudpModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_udp_model_set(s : NetprotoudpModel, i : Int, v : Double) -> NetprotoudpModel {
  let result = net_proto_udp_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_proto_udp_model_sum(s : NetprotoudpModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_proto_udp_model_mean(s : NetprotoudpModel) -> Double {
  if s.size == 0 { 0.0 } else { net_proto_udp_model_sum(s) / s.size.to_double() }
}

pub fn net_proto_udp_model_scale(s : NetprotoudpModel, f : Double) -> NetprotoudpModel {
  let result = net_proto_udp_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_proto_udp_model_add(a : NetprotoudpModel, b : NetprotoudpModel) -> NetprotoudpModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_proto_udp_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_proto_udp_model_copy(s : NetprotoudpModel) -> NetprotoudpModel {
  let result = net_proto_udp_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_proto_udp_model_fill(s : NetprotoudpModel, v : Double) -> NetprotoudpModel {
  let result = net_proto_udp_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_proto_udp_model_min(s : NetprotoudpModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_udp_model_max(s : NetprotoudpModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_udp_model_to_string(s : NetprotoudpModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotoudpLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_udp_layer_make(size : Int) -> NetprotoudpLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_udp_layer_len(s : NetprotoudpLayer) -> Int { s.size }

pub fn net_proto_udp_layer_get(s : NetprotoudpLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_udp_layer_set(s : NetprotoudpLayer, i : Int, v : Double) -> NetprotoudpLayer {
  let result = net_proto_udp_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_proto_udp_layer_sum(s : NetprotoudpLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_proto_udp_layer_mean(s : NetprotoudpLayer) -> Double {
  if s.size == 0 { 0.0 } else { net_proto_udp_layer_sum(s) / s.size.to_double() }
}

pub fn net_proto_udp_layer_scale(s : NetprotoudpLayer, f : Double) -> NetprotoudpLayer {
  let result = net_proto_udp_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_proto_udp_layer_add(a : NetprotoudpLayer, b : NetprotoudpLayer) -> NetprotoudpLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_proto_udp_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_proto_udp_layer_copy(s : NetprotoudpLayer) -> NetprotoudpLayer {
  let result = net_proto_udp_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_proto_udp_layer_fill(s : NetprotoudpLayer, v : Double) -> NetprotoudpLayer {
  let result = net_proto_udp_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_proto_udp_layer_min(s : NetprotoudpLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_udp_layer_max(s : NetprotoudpLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_udp_layer_to_string(s : NetprotoudpLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotoudpBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_udp_buffer_make(size : Int) -> NetprotoudpBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_udp_buffer_len(s : NetprotoudpBuffer) -> Int { s.size }

pub fn net_proto_udp_buffer_get(s : NetprotoudpBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_udp_buffer_set(s : NetprotoudpBuffer, i : Int, v : Double) -> NetprotoudpBuffer {
  let result = net_proto_udp_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_proto_udp_buffer_sum(s : NetprotoudpBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_proto_udp_buffer_mean(s : NetprotoudpBuffer) -> Double {
  if s.size == 0 { 0.0 } else { net_proto_udp_buffer_sum(s) / s.size.to_double() }
}

pub fn net_proto_udp_buffer_scale(s : NetprotoudpBuffer, f : Double) -> NetprotoudpBuffer {
  let result = net_proto_udp_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_proto_udp_buffer_add(a : NetprotoudpBuffer, b : NetprotoudpBuffer) -> NetprotoudpBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_proto_udp_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_proto_udp_buffer_copy(s : NetprotoudpBuffer) -> NetprotoudpBuffer {
  let result = net_proto_udp_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_proto_udp_buffer_fill(s : NetprotoudpBuffer, v : Double) -> NetprotoudpBuffer {
  let result = net_proto_udp_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_proto_udp_buffer_min(s : NetprotoudpBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_udp_buffer_max(s : NetprotoudpBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_udp_buffer_to_string(s : NetprotoudpBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotoudpCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_udp_cursor_make(size : Int) -> NetprotoudpCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_udp_cursor_len(s : NetprotoudpCursor) -> Int { s.size }

pub fn net_proto_udp_cursor_get(s : NetprotoudpCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_udp_cursor_set(s : NetprotoudpCursor, i : Int, v : Double) -> NetprotoudpCursor {
  let result = net_proto_udp_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_proto_udp_cursor_sum(s : NetprotoudpCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_proto_udp_cursor_mean(s : NetprotoudpCursor) -> Double {
  if s.size == 0 { 0.0 } else { net_proto_udp_cursor_sum(s) / s.size.to_double() }
}

pub fn net_proto_udp_cursor_scale(s : NetprotoudpCursor, f : Double) -> NetprotoudpCursor {
  let result = net_proto_udp_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_proto_udp_cursor_add(a : NetprotoudpCursor, b : NetprotoudpCursor) -> NetprotoudpCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_proto_udp_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_proto_udp_cursor_copy(s : NetprotoudpCursor) -> NetprotoudpCursor {
  let result = net_proto_udp_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_proto_udp_cursor_fill(s : NetprotoudpCursor, v : Double) -> NetprotoudpCursor {
  let result = net_proto_udp_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_proto_udp_cursor_min(s : NetprotoudpCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_udp_cursor_max(s : NetprotoudpCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_udp_cursor_to_string(s : NetprotoudpCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotoudpView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_udp_view_make(size : Int) -> NetprotoudpView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_udp_view_len(s : NetprotoudpView) -> Int { s.size }

pub fn net_proto_udp_view_get(s : NetprotoudpView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_udp_view_set(s : NetprotoudpView, i : Int, v : Double) -> NetprotoudpView {
  let result = net_proto_udp_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_proto_udp_view_sum(s : NetprotoudpView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_proto_udp_view_mean(s : NetprotoudpView) -> Double {
  if s.size == 0 { 0.0 } else { net_proto_udp_view_sum(s) / s.size.to_double() }
}

pub fn net_proto_udp_view_scale(s : NetprotoudpView, f : Double) -> NetprotoudpView {
  let result = net_proto_udp_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_proto_udp_view_add(a : NetprotoudpView, b : NetprotoudpView) -> NetprotoudpView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_proto_udp_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_proto_udp_view_copy(s : NetprotoudpView) -> NetprotoudpView {
  let result = net_proto_udp_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_proto_udp_view_fill(s : NetprotoudpView, v : Double) -> NetprotoudpView {
  let result = net_proto_udp_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_proto_udp_view_min(s : NetprotoudpView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_udp_view_max(s : NetprotoudpView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_udp_view_to_string(s : NetprotoudpView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotoudpRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_udp_range_make(size : Int) -> NetprotoudpRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_udp_range_len(s : NetprotoudpRange) -> Int { s.size }

pub fn net_proto_udp_range_get(s : NetprotoudpRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_udp_range_set(s : NetprotoudpRange, i : Int, v : Double) -> NetprotoudpRange {
  let result = net_proto_udp_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_proto_udp_range_sum(s : NetprotoudpRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_proto_udp_range_mean(s : NetprotoudpRange) -> Double {
  if s.size == 0 { 0.0 } else { net_proto_udp_range_sum(s) / s.size.to_double() }
}

pub fn net_proto_udp_range_scale(s : NetprotoudpRange, f : Double) -> NetprotoudpRange {
  let result = net_proto_udp_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_proto_udp_range_add(a : NetprotoudpRange, b : NetprotoudpRange) -> NetprotoudpRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_proto_udp_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_proto_udp_range_copy(s : NetprotoudpRange) -> NetprotoudpRange {
  let result = net_proto_udp_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_proto_udp_range_fill(s : NetprotoudpRange, v : Double) -> NetprotoudpRange {
  let result = net_proto_udp_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_proto_udp_range_min(s : NetprotoudpRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_udp_range_max(s : NetprotoudpRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_udp_range_to_string(s : NetprotoudpRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotoudpSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_udp_slice_make(size : Int) -> NetprotoudpSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_udp_slice_len(s : NetprotoudpSlice) -> Int { s.size }

pub fn net_proto_udp_slice_get(s : NetprotoudpSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_udp_slice_set(s : NetprotoudpSlice, i : Int, v : Double) -> NetprotoudpSlice {
  let result = net_proto_udp_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_proto_udp_slice_sum(s : NetprotoudpSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_proto_udp_slice_mean(s : NetprotoudpSlice) -> Double {
  if s.size == 0 { 0.0 } else { net_proto_udp_slice_sum(s) / s.size.to_double() }
}

pub fn net_proto_udp_slice_scale(s : NetprotoudpSlice, f : Double) -> NetprotoudpSlice {
  let result = net_proto_udp_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_proto_udp_slice_add(a : NetprotoudpSlice, b : NetprotoudpSlice) -> NetprotoudpSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_proto_udp_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_proto_udp_slice_copy(s : NetprotoudpSlice) -> NetprotoudpSlice {
  let result = net_proto_udp_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_proto_udp_slice_fill(s : NetprotoudpSlice, v : Double) -> NetprotoudpSlice {
  let result = net_proto_udp_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_proto_udp_slice_min(s : NetprotoudpSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_udp_slice_max(s : NetprotoudpSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_udp_slice_to_string(s : NetprotoudpSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

