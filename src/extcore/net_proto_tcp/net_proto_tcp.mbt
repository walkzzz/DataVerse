///===
/// extcore/net_proto_tcp

pub(all) struct NetprototcpPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn net_proto_tcp_make_point(x : Double, y : Double) -> NetprototcpPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn net_proto_tcp_make_point3(x : Double, y : Double, z : Double) -> NetprototcpPoint {
  { x, y, z, label: 0 }
}

pub fn net_proto_tcp_point_x(pt : NetprototcpPoint) -> Double { pt.x }

pub fn net_proto_tcp_point_y(pt : NetprototcpPoint) -> Double { pt.y }

pub fn net_proto_tcp_point_z(pt : NetprototcpPoint) -> Double { pt.z }

pub fn net_proto_tcp_point_label(pt : NetprototcpPoint) -> Int { pt.label }

pub fn net_proto_tcp_point_dist(a : NetprototcpPoint, b : NetprototcpPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn net_proto_tcp_point_add(a : NetprototcpPoint, b : NetprototcpPoint) -> NetprototcpPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn net_proto_tcp_point_sub(a : NetprototcpPoint, b : NetprototcpPoint) -> NetprototcpPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn net_proto_tcp_point_scale(pt : NetprototcpPoint, s : Double) -> NetprototcpPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn net_proto_tcp_point_dot(a : NetprototcpPoint, b : NetprototcpPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn net_proto_tcp_point_cross(a : NetprototcpPoint, b : NetprototcpPoint) -> NetprototcpPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn net_proto_tcp_point_norm(pt : NetprototcpPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn net_proto_tcp_point_normalize(pt : NetprototcpPoint) -> NetprototcpPoint {
  let n = net_proto_tcp_point_norm(pt)
  if n < 0.0000001 { pt } else { net_proto_tcp_point_scale(pt, 1.0 / n) }
}

pub fn net_proto_tcp_point_negate(pt : NetprototcpPoint) -> NetprototcpPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn net_proto_tcp_point_mid(a : NetprototcpPoint, b : NetprototcpPoint) -> NetprototcpPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn net_proto_tcp_point_lerp(a : NetprototcpPoint, b : NetprototcpPoint, t : Double) -> NetprototcpPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn net_proto_tcp_point_to_string(pt : NetprototcpPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct NetprototcpSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn net_proto_tcp_make_series(vals : Array[Double], name : String) -> NetprototcpSeries {
  { vals, name, meta: 0 }
}

pub fn net_proto_tcp_series_len(s : NetprototcpSeries) -> Int { s.vals.length() }

pub fn net_proto_tcp_series_sum(s : NetprototcpSeries) -> Double { @_common.sum(s.vals) }

pub fn net_proto_tcp_series_mean(s : NetprototcpSeries) -> Double { @_common.mean(s.vals) }

pub fn net_proto_tcp_series_min(s : NetprototcpSeries) -> Double { @_common.min(s.vals) }

pub fn net_proto_tcp_series_max(s : NetprototcpSeries) -> Double { @_common.max(s.vals) }

pub fn net_proto_tcp_series_range(s : NetprototcpSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn net_proto_tcp_series_var(s : NetprototcpSeries) -> Double { @_common.variance(s.vals) }

pub fn net_proto_tcp_series_std(s : NetprototcpSeries) -> Double { @_common.std(s.vals) }

pub fn net_proto_tcp_series_median(s : NetprototcpSeries) -> Double { @_common.median(s.vals) }

pub fn net_proto_tcp_series_scale(s : NetprototcpSeries, f : Double) -> NetprototcpSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn net_proto_tcp_series_add(a : NetprototcpSeries, b : NetprototcpSeries) -> NetprototcpSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn net_proto_tcp_series_sub(a : NetprototcpSeries, b : NetprototcpSeries) -> NetprototcpSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn net_proto_tcp_series_normalize(s : NetprototcpSeries) -> NetprototcpSeries {
  let mn = net_proto_tcp_series_min(s)
  let mx = net_proto_tcp_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn net_proto_tcp_series_cumsum(s : NetprototcpSeries) -> NetprototcpSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn net_proto_tcp_series_to_string(s : NetprototcpSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NetprototcpMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn net_proto_tcp_make_matrix(rows : Int, cols : Int, val : Double) -> NetprototcpMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn net_proto_tcp_matrix_identity(n : Int) -> NetprototcpMatrix {
  let m = net_proto_tcp_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn net_proto_tcp_matrix_get(m : NetprototcpMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn net_proto_tcp_matrix_transpose(m : NetprototcpMatrix) -> NetprototcpMatrix {
  let result = net_proto_tcp_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn net_proto_tcp_matrix_add(a : NetprototcpMatrix, b : NetprototcpMatrix) -> NetprototcpMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = net_proto_tcp_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn net_proto_tcp_matrix_scale(m : NetprototcpMatrix, s : Double) -> NetprototcpMatrix {
  let result = net_proto_tcp_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn net_proto_tcp_matrix_multiply(a : NetprototcpMatrix, b : NetprototcpMatrix) -> NetprototcpMatrix {
  if a.cols != b.rows { return net_proto_tcp_make_matrix(a.rows, b.cols, 0.0) }
  let result = net_proto_tcp_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn net_proto_tcp_matrix_trace(m : NetprototcpMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn net_proto_tcp_matrix_det(m : NetprototcpMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn net_proto_tcp_matrix_norm(m : NetprototcpMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn net_proto_tcp_matrix_to_string(m : NetprototcpMatrix) -> String {
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

pub(all) struct NetprototcpVector {
  comps : Array[Double]
  dim : Int
}

pub fn net_proto_tcp_make_vector(comps : Array[Double]) -> NetprototcpVector {
  { comps, dim: comps.length() }
}

pub fn net_proto_tcp_vector_zero(dim : Int) -> NetprototcpVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn net_proto_tcp_vector_add(a : NetprototcpVector, b : NetprototcpVector) -> NetprototcpVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn net_proto_tcp_vector_sub(a : NetprototcpVector, b : NetprototcpVector) -> NetprototcpVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn net_proto_tcp_vector_scale(v : NetprototcpVector, s : Double) -> NetprototcpVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn net_proto_tcp_vector_dot(a : NetprototcpVector, b : NetprototcpVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn net_proto_tcp_vector_norm(v : NetprototcpVector) -> Double { @_common.sqrt(net_proto_tcp_vector_dot(v, v)) }

pub fn net_proto_tcp_vector_normalize(v : NetprototcpVector) -> NetprototcpVector {
  let n = net_proto_tcp_vector_norm(v)
  if n < 0.0000001 { v } else { net_proto_tcp_vector_scale(v, 1.0 / n) }
}

pub fn net_proto_tcp_vector_dist(a : NetprototcpVector, b : NetprototcpVector) -> Double {
  net_proto_tcp_vector_norm(net_proto_tcp_vector_sub(a, b))
}

pub fn net_proto_tcp_vector_to_string(v : NetprototcpVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn net_proto_tcp_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn net_proto_tcp_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn net_proto_tcp_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn net_proto_tcp_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn net_proto_tcp_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn net_proto_tcp_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn net_proto_tcp_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn net_proto_tcp_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn net_proto_tcp_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn net_proto_tcp_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn net_proto_tcp_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn net_proto_tcp_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn net_proto_tcp_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn net_proto_tcp_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn net_proto_tcp_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn net_proto_tcp_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn net_proto_tcp_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn net_proto_tcp_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn net_proto_tcp_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn net_proto_tcp_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn net_proto_tcp_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn net_proto_tcp_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn net_proto_tcp_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn net_proto_tcp_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn net_proto_tcp_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn net_proto_tcp_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn net_proto_tcp_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn net_proto_tcp_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn net_proto_tcp_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct NetprototcpFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_tcp_frame_make(size : Int) -> NetprototcpFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_tcp_frame_len(s : NetprototcpFrame) -> Int { s.size }

pub fn net_proto_tcp_frame_get(s : NetprototcpFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_tcp_frame_set(s : NetprototcpFrame, i : Int, v : Double) -> NetprototcpFrame {
  let result = net_proto_tcp_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_proto_tcp_frame_sum(s : NetprototcpFrame) -> Double { @_common.sum(s.data) }

pub fn net_proto_tcp_frame_mean(s : NetprototcpFrame) -> Double { @_common.mean(s.data) }

pub fn net_proto_tcp_frame_scale(s : NetprototcpFrame, f : Double) -> NetprototcpFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_proto_tcp_frame_add(a : NetprototcpFrame, b : NetprototcpFrame) -> NetprototcpFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_proto_tcp_frame_copy(s : NetprototcpFrame) -> NetprototcpFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_proto_tcp_frame_fill(s : NetprototcpFrame, v : Double) -> NetprototcpFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_proto_tcp_frame_min(s : NetprototcpFrame) -> Double { @_common.min(s.data) }

pub fn net_proto_tcp_frame_max(s : NetprototcpFrame) -> Double { @_common.max(s.data) }

pub fn net_proto_tcp_frame_to_string(s : NetprototcpFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprototcpTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_tcp_table_make(size : Int) -> NetprototcpTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_tcp_table_len(s : NetprototcpTable) -> Int { s.size }

pub fn net_proto_tcp_table_get(s : NetprototcpTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_tcp_table_set(s : NetprototcpTable, i : Int, v : Double) -> NetprototcpTable {
  let result = net_proto_tcp_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_proto_tcp_table_sum(s : NetprototcpTable) -> Double { @_common.sum(s.data) }

pub fn net_proto_tcp_table_mean(s : NetprototcpTable) -> Double { @_common.mean(s.data) }

pub fn net_proto_tcp_table_scale(s : NetprototcpTable, f : Double) -> NetprototcpTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_proto_tcp_table_add(a : NetprototcpTable, b : NetprototcpTable) -> NetprototcpTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_proto_tcp_table_copy(s : NetprototcpTable) -> NetprototcpTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_proto_tcp_table_fill(s : NetprototcpTable, v : Double) -> NetprototcpTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_proto_tcp_table_min(s : NetprototcpTable) -> Double { @_common.min(s.data) }

pub fn net_proto_tcp_table_max(s : NetprototcpTable) -> Double { @_common.max(s.data) }

pub fn net_proto_tcp_table_to_string(s : NetprototcpTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprototcpGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_tcp_graphn_make(size : Int) -> NetprototcpGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_tcp_graphn_len(s : NetprototcpGraphN) -> Int { s.size }

pub fn net_proto_tcp_graphn_get(s : NetprototcpGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_tcp_graphn_set(s : NetprototcpGraphN, i : Int, v : Double) -> NetprototcpGraphN {
  let result = net_proto_tcp_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_proto_tcp_graphn_sum(s : NetprototcpGraphN) -> Double { @_common.sum(s.data) }

pub fn net_proto_tcp_graphn_mean(s : NetprototcpGraphN) -> Double { @_common.mean(s.data) }

pub fn net_proto_tcp_graphn_scale(s : NetprototcpGraphN, f : Double) -> NetprototcpGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_proto_tcp_graphn_add(a : NetprototcpGraphN, b : NetprototcpGraphN) -> NetprototcpGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_proto_tcp_graphn_copy(s : NetprototcpGraphN) -> NetprototcpGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_proto_tcp_graphn_fill(s : NetprototcpGraphN, v : Double) -> NetprototcpGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_proto_tcp_graphn_min(s : NetprototcpGraphN) -> Double { @_common.min(s.data) }

pub fn net_proto_tcp_graphn_max(s : NetprototcpGraphN) -> Double { @_common.max(s.data) }

pub fn net_proto_tcp_graphn_to_string(s : NetprototcpGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprototcpNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_tcp_node_make(size : Int) -> NetprototcpNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_tcp_node_len(s : NetprototcpNode) -> Int { s.size }

pub fn net_proto_tcp_node_get(s : NetprototcpNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_tcp_node_set(s : NetprototcpNode, i : Int, v : Double) -> NetprototcpNode {
  let result = net_proto_tcp_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_proto_tcp_node_sum(s : NetprototcpNode) -> Double { @_common.sum(s.data) }

pub fn net_proto_tcp_node_mean(s : NetprototcpNode) -> Double { @_common.mean(s.data) }

pub fn net_proto_tcp_node_scale(s : NetprototcpNode, f : Double) -> NetprototcpNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_proto_tcp_node_add(a : NetprototcpNode, b : NetprototcpNode) -> NetprototcpNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_proto_tcp_node_copy(s : NetprototcpNode) -> NetprototcpNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_proto_tcp_node_fill(s : NetprototcpNode, v : Double) -> NetprototcpNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_proto_tcp_node_min(s : NetprototcpNode) -> Double { @_common.min(s.data) }

pub fn net_proto_tcp_node_max(s : NetprototcpNode) -> Double { @_common.max(s.data) }

pub fn net_proto_tcp_node_to_string(s : NetprototcpNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprototcpEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_tcp_edge_make(size : Int) -> NetprototcpEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_tcp_edge_len(s : NetprototcpEdge) -> Int { s.size }

pub fn net_proto_tcp_edge_get(s : NetprototcpEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_tcp_edge_set(s : NetprototcpEdge, i : Int, v : Double) -> NetprototcpEdge {
  let result = net_proto_tcp_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_proto_tcp_edge_sum(s : NetprototcpEdge) -> Double { @_common.sum(s.data) }

pub fn net_proto_tcp_edge_mean(s : NetprototcpEdge) -> Double { @_common.mean(s.data) }

pub fn net_proto_tcp_edge_scale(s : NetprototcpEdge, f : Double) -> NetprototcpEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_proto_tcp_edge_add(a : NetprototcpEdge, b : NetprototcpEdge) -> NetprototcpEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_proto_tcp_edge_copy(s : NetprototcpEdge) -> NetprototcpEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_proto_tcp_edge_fill(s : NetprototcpEdge, v : Double) -> NetprototcpEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_proto_tcp_edge_min(s : NetprototcpEdge) -> Double { @_common.min(s.data) }

pub fn net_proto_tcp_edge_max(s : NetprototcpEdge) -> Double { @_common.max(s.data) }

pub fn net_proto_tcp_edge_to_string(s : NetprototcpEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprototcpPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_tcp_path_make(size : Int) -> NetprototcpPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_tcp_path_len(s : NetprototcpPath) -> Int { s.size }

pub fn net_proto_tcp_path_get(s : NetprototcpPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_tcp_path_set(s : NetprototcpPath, i : Int, v : Double) -> NetprototcpPath {
  let result = net_proto_tcp_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_proto_tcp_path_sum(s : NetprototcpPath) -> Double { @_common.sum(s.data) }

pub fn net_proto_tcp_path_mean(s : NetprototcpPath) -> Double { @_common.mean(s.data) }

pub fn net_proto_tcp_path_scale(s : NetprototcpPath, f : Double) -> NetprototcpPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_proto_tcp_path_add(a : NetprototcpPath, b : NetprototcpPath) -> NetprototcpPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_proto_tcp_path_copy(s : NetprototcpPath) -> NetprototcpPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_proto_tcp_path_fill(s : NetprototcpPath, v : Double) -> NetprototcpPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_proto_tcp_path_min(s : NetprototcpPath) -> Double { @_common.min(s.data) }

pub fn net_proto_tcp_path_max(s : NetprototcpPath) -> Double { @_common.max(s.data) }

pub fn net_proto_tcp_path_to_string(s : NetprototcpPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprototcpCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_tcp_cluster_make(size : Int) -> NetprototcpCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_tcp_cluster_len(s : NetprototcpCluster) -> Int { s.size }

pub fn net_proto_tcp_cluster_get(s : NetprototcpCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_tcp_cluster_set(s : NetprototcpCluster, i : Int, v : Double) -> NetprototcpCluster {
  let result = net_proto_tcp_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_proto_tcp_cluster_sum(s : NetprototcpCluster) -> Double { @_common.sum(s.data) }

pub fn net_proto_tcp_cluster_mean(s : NetprototcpCluster) -> Double { @_common.mean(s.data) }

pub fn net_proto_tcp_cluster_scale(s : NetprototcpCluster, f : Double) -> NetprototcpCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_proto_tcp_cluster_add(a : NetprototcpCluster, b : NetprototcpCluster) -> NetprototcpCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_proto_tcp_cluster_copy(s : NetprototcpCluster) -> NetprototcpCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_proto_tcp_cluster_fill(s : NetprototcpCluster, v : Double) -> NetprototcpCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_proto_tcp_cluster_min(s : NetprototcpCluster) -> Double { @_common.min(s.data) }

pub fn net_proto_tcp_cluster_max(s : NetprototcpCluster) -> Double { @_common.max(s.data) }

pub fn net_proto_tcp_cluster_to_string(s : NetprototcpCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprototcpModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_tcp_model_make(size : Int) -> NetprototcpModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_tcp_model_len(s : NetprototcpModel) -> Int { s.size }

pub fn net_proto_tcp_model_get(s : NetprototcpModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_tcp_model_set(s : NetprototcpModel, i : Int, v : Double) -> NetprototcpModel {
  let result = net_proto_tcp_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_proto_tcp_model_sum(s : NetprototcpModel) -> Double { @_common.sum(s.data) }

pub fn net_proto_tcp_model_mean(s : NetprototcpModel) -> Double { @_common.mean(s.data) }

pub fn net_proto_tcp_model_scale(s : NetprototcpModel, f : Double) -> NetprototcpModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_proto_tcp_model_add(a : NetprototcpModel, b : NetprototcpModel) -> NetprototcpModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_proto_tcp_model_copy(s : NetprototcpModel) -> NetprototcpModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_proto_tcp_model_fill(s : NetprototcpModel, v : Double) -> NetprototcpModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_proto_tcp_model_min(s : NetprototcpModel) -> Double { @_common.min(s.data) }

pub fn net_proto_tcp_model_max(s : NetprototcpModel) -> Double { @_common.max(s.data) }

pub fn net_proto_tcp_model_to_string(s : NetprototcpModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprototcpLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_tcp_layer_make(size : Int) -> NetprototcpLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_tcp_layer_len(s : NetprototcpLayer) -> Int { s.size }

pub fn net_proto_tcp_layer_get(s : NetprototcpLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_tcp_layer_set(s : NetprototcpLayer, i : Int, v : Double) -> NetprototcpLayer {
  let result = net_proto_tcp_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_proto_tcp_layer_sum(s : NetprototcpLayer) -> Double { @_common.sum(s.data) }

pub fn net_proto_tcp_layer_mean(s : NetprototcpLayer) -> Double { @_common.mean(s.data) }

pub fn net_proto_tcp_layer_scale(s : NetprototcpLayer, f : Double) -> NetprototcpLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_proto_tcp_layer_add(a : NetprototcpLayer, b : NetprototcpLayer) -> NetprototcpLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_proto_tcp_layer_copy(s : NetprototcpLayer) -> NetprototcpLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_proto_tcp_layer_fill(s : NetprototcpLayer, v : Double) -> NetprototcpLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_proto_tcp_layer_min(s : NetprototcpLayer) -> Double { @_common.min(s.data) }

pub fn net_proto_tcp_layer_max(s : NetprototcpLayer) -> Double { @_common.max(s.data) }

pub fn net_proto_tcp_layer_to_string(s : NetprototcpLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprototcpBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_tcp_buffer_make(size : Int) -> NetprototcpBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_tcp_buffer_len(s : NetprototcpBuffer) -> Int { s.size }

pub fn net_proto_tcp_buffer_get(s : NetprototcpBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_tcp_buffer_set(s : NetprototcpBuffer, i : Int, v : Double) -> NetprototcpBuffer {
  let result = net_proto_tcp_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_proto_tcp_buffer_sum(s : NetprototcpBuffer) -> Double { @_common.sum(s.data) }

pub fn net_proto_tcp_buffer_mean(s : NetprototcpBuffer) -> Double { @_common.mean(s.data) }

pub fn net_proto_tcp_buffer_scale(s : NetprototcpBuffer, f : Double) -> NetprototcpBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_proto_tcp_buffer_add(a : NetprototcpBuffer, b : NetprototcpBuffer) -> NetprototcpBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_proto_tcp_buffer_copy(s : NetprototcpBuffer) -> NetprototcpBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_proto_tcp_buffer_fill(s : NetprototcpBuffer, v : Double) -> NetprototcpBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_proto_tcp_buffer_min(s : NetprototcpBuffer) -> Double { @_common.min(s.data) }

pub fn net_proto_tcp_buffer_max(s : NetprototcpBuffer) -> Double { @_common.max(s.data) }

pub fn net_proto_tcp_buffer_to_string(s : NetprototcpBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprototcpCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_tcp_cursor_make(size : Int) -> NetprototcpCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_tcp_cursor_len(s : NetprototcpCursor) -> Int { s.size }

pub fn net_proto_tcp_cursor_get(s : NetprototcpCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_tcp_cursor_set(s : NetprototcpCursor, i : Int, v : Double) -> NetprototcpCursor {
  let result = net_proto_tcp_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_proto_tcp_cursor_sum(s : NetprototcpCursor) -> Double { @_common.sum(s.data) }

pub fn net_proto_tcp_cursor_mean(s : NetprototcpCursor) -> Double { @_common.mean(s.data) }

pub fn net_proto_tcp_cursor_scale(s : NetprototcpCursor, f : Double) -> NetprototcpCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_proto_tcp_cursor_add(a : NetprototcpCursor, b : NetprototcpCursor) -> NetprototcpCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_proto_tcp_cursor_copy(s : NetprototcpCursor) -> NetprototcpCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_proto_tcp_cursor_fill(s : NetprototcpCursor, v : Double) -> NetprototcpCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_proto_tcp_cursor_min(s : NetprototcpCursor) -> Double { @_common.min(s.data) }

pub fn net_proto_tcp_cursor_max(s : NetprototcpCursor) -> Double { @_common.max(s.data) }

pub fn net_proto_tcp_cursor_to_string(s : NetprototcpCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprototcpView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_tcp_view_make(size : Int) -> NetprototcpView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_tcp_view_len(s : NetprototcpView) -> Int { s.size }

pub fn net_proto_tcp_view_get(s : NetprototcpView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_tcp_view_set(s : NetprototcpView, i : Int, v : Double) -> NetprototcpView {
  let result = net_proto_tcp_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_proto_tcp_view_sum(s : NetprototcpView) -> Double { @_common.sum(s.data) }

pub fn net_proto_tcp_view_mean(s : NetprototcpView) -> Double { @_common.mean(s.data) }

pub fn net_proto_tcp_view_scale(s : NetprototcpView, f : Double) -> NetprototcpView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_proto_tcp_view_add(a : NetprototcpView, b : NetprototcpView) -> NetprototcpView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_proto_tcp_view_copy(s : NetprototcpView) -> NetprototcpView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_proto_tcp_view_fill(s : NetprototcpView, v : Double) -> NetprototcpView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_proto_tcp_view_min(s : NetprototcpView) -> Double { @_common.min(s.data) }

pub fn net_proto_tcp_view_max(s : NetprototcpView) -> Double { @_common.max(s.data) }

pub fn net_proto_tcp_view_to_string(s : NetprototcpView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprototcpRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_tcp_range_make(size : Int) -> NetprototcpRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_tcp_range_len(s : NetprototcpRange) -> Int { s.size }

pub fn net_proto_tcp_range_get(s : NetprototcpRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_tcp_range_set(s : NetprototcpRange, i : Int, v : Double) -> NetprototcpRange {
  let result = net_proto_tcp_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_proto_tcp_range_sum(s : NetprototcpRange) -> Double { @_common.sum(s.data) }

pub fn net_proto_tcp_range_mean(s : NetprototcpRange) -> Double { @_common.mean(s.data) }

pub fn net_proto_tcp_range_scale(s : NetprototcpRange, f : Double) -> NetprototcpRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_proto_tcp_range_add(a : NetprototcpRange, b : NetprototcpRange) -> NetprototcpRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_proto_tcp_range_copy(s : NetprototcpRange) -> NetprototcpRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_proto_tcp_range_fill(s : NetprototcpRange, v : Double) -> NetprototcpRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_proto_tcp_range_min(s : NetprototcpRange) -> Double { @_common.min(s.data) }

pub fn net_proto_tcp_range_max(s : NetprototcpRange) -> Double { @_common.max(s.data) }

pub fn net_proto_tcp_range_to_string(s : NetprototcpRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprototcpSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_tcp_slice_make(size : Int) -> NetprototcpSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_tcp_slice_len(s : NetprototcpSlice) -> Int { s.size }

pub fn net_proto_tcp_slice_get(s : NetprototcpSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_tcp_slice_set(s : NetprototcpSlice, i : Int, v : Double) -> NetprototcpSlice {
  let result = net_proto_tcp_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_proto_tcp_slice_sum(s : NetprototcpSlice) -> Double { @_common.sum(s.data) }

pub fn net_proto_tcp_slice_mean(s : NetprototcpSlice) -> Double { @_common.mean(s.data) }

pub fn net_proto_tcp_slice_scale(s : NetprototcpSlice, f : Double) -> NetprototcpSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_proto_tcp_slice_add(a : NetprototcpSlice, b : NetprototcpSlice) -> NetprototcpSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_proto_tcp_slice_copy(s : NetprototcpSlice) -> NetprototcpSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_proto_tcp_slice_fill(s : NetprototcpSlice, v : Double) -> NetprototcpSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_proto_tcp_slice_min(s : NetprototcpSlice) -> Double { @_common.min(s.data) }

pub fn net_proto_tcp_slice_max(s : NetprototcpSlice) -> Double { @_common.max(s.data) }

pub fn net_proto_tcp_slice_to_string(s : NetprototcpSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

