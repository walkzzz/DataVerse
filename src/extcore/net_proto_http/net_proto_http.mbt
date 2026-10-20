///===
/// extcore/net_proto_http

pub(all) struct NetprotohttpPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn net_proto_http_make_point(x : Double, y : Double) -> NetprotohttpPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn net_proto_http_make_point3(x : Double, y : Double, z : Double) -> NetprotohttpPoint {
  { x, y, z, label: 0 }
}

pub fn net_proto_http_point_x(pt : NetprotohttpPoint) -> Double { pt.x }

pub fn net_proto_http_point_y(pt : NetprotohttpPoint) -> Double { pt.y }

pub fn net_proto_http_point_z(pt : NetprotohttpPoint) -> Double { pt.z }

pub fn net_proto_http_point_label(pt : NetprotohttpPoint) -> Int { pt.label }

pub fn net_proto_http_point_dist(a : NetprotohttpPoint, b : NetprotohttpPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn net_proto_http_point_add(a : NetprotohttpPoint, b : NetprotohttpPoint) -> NetprotohttpPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn net_proto_http_point_sub(a : NetprotohttpPoint, b : NetprotohttpPoint) -> NetprotohttpPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn net_proto_http_point_scale(pt : NetprotohttpPoint, s : Double) -> NetprotohttpPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn net_proto_http_point_dot(a : NetprotohttpPoint, b : NetprotohttpPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn net_proto_http_point_cross(a : NetprotohttpPoint, b : NetprotohttpPoint) -> NetprotohttpPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn net_proto_http_point_norm(pt : NetprotohttpPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn net_proto_http_point_normalize(pt : NetprotohttpPoint) -> NetprotohttpPoint {
  let n = net_proto_http_point_norm(pt)
  if n < 0.0000001 { pt } else { net_proto_http_point_scale(pt, 1.0 / n) }
}

pub fn net_proto_http_point_negate(pt : NetprotohttpPoint) -> NetprotohttpPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn net_proto_http_point_mid(a : NetprotohttpPoint, b : NetprotohttpPoint) -> NetprotohttpPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn net_proto_http_point_lerp(a : NetprotohttpPoint, b : NetprotohttpPoint, t : Double) -> NetprotohttpPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn net_proto_http_point_to_string(pt : NetprotohttpPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct NetprotohttpSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn net_proto_http_make_series(vals : Array[Double], name : String) -> NetprotohttpSeries {
  { vals, name, meta: 0 }
}

pub fn net_proto_http_series_len(s : NetprotohttpSeries) -> Int { s.vals.length() }

pub fn net_proto_http_series_sum(s : NetprotohttpSeries) -> Double { @_common.sum(s.vals) }

pub fn net_proto_http_series_mean(s : NetprotohttpSeries) -> Double { @_common.mean(s.vals) }

pub fn net_proto_http_series_min(s : NetprotohttpSeries) -> Double { @_common.min(s.vals) }

pub fn net_proto_http_series_max(s : NetprotohttpSeries) -> Double { @_common.max(s.vals) }

pub fn net_proto_http_series_range(s : NetprotohttpSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn net_proto_http_series_var(s : NetprotohttpSeries) -> Double { @_common.variance(s.vals) }

pub fn net_proto_http_series_std(s : NetprotohttpSeries) -> Double { @_common.std(s.vals) }

pub fn net_proto_http_series_median(s : NetprotohttpSeries) -> Double { @_common.median(s.vals) }

pub fn net_proto_http_series_scale(s : NetprotohttpSeries, f : Double) -> NetprotohttpSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn net_proto_http_series_add(a : NetprotohttpSeries, b : NetprotohttpSeries) -> NetprotohttpSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn net_proto_http_series_sub(a : NetprotohttpSeries, b : NetprotohttpSeries) -> NetprotohttpSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn net_proto_http_series_normalize(s : NetprotohttpSeries) -> NetprotohttpSeries {
  let mn = net_proto_http_series_min(s)
  let mx = net_proto_http_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn net_proto_http_series_cumsum(s : NetprotohttpSeries) -> NetprotohttpSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn net_proto_http_series_to_string(s : NetprotohttpSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NetprotohttpMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn net_proto_http_make_matrix(rows : Int, cols : Int, val : Double) -> NetprotohttpMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn net_proto_http_matrix_identity(n : Int) -> NetprotohttpMatrix {
  let m = net_proto_http_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn net_proto_http_matrix_get(m : NetprotohttpMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn net_proto_http_matrix_transpose(m : NetprotohttpMatrix) -> NetprotohttpMatrix {
  let result = net_proto_http_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn net_proto_http_matrix_add(a : NetprotohttpMatrix, b : NetprotohttpMatrix) -> NetprotohttpMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = net_proto_http_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn net_proto_http_matrix_scale(m : NetprotohttpMatrix, s : Double) -> NetprotohttpMatrix {
  let result = net_proto_http_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn net_proto_http_matrix_multiply(a : NetprotohttpMatrix, b : NetprotohttpMatrix) -> NetprotohttpMatrix {
  if a.cols != b.rows { return net_proto_http_make_matrix(a.rows, b.cols, 0.0) }
  let result = net_proto_http_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn net_proto_http_matrix_trace(m : NetprotohttpMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn net_proto_http_matrix_det(m : NetprotohttpMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn net_proto_http_matrix_norm(m : NetprotohttpMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn net_proto_http_matrix_to_string(m : NetprotohttpMatrix) -> String {
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

pub(all) struct NetprotohttpVector {
  comps : Array[Double]
  dim : Int
}

pub fn net_proto_http_make_vector(comps : Array[Double]) -> NetprotohttpVector {
  { comps, dim: comps.length() }
}

pub fn net_proto_http_vector_zero(dim : Int) -> NetprotohttpVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn net_proto_http_vector_add(a : NetprotohttpVector, b : NetprotohttpVector) -> NetprotohttpVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn net_proto_http_vector_sub(a : NetprotohttpVector, b : NetprotohttpVector) -> NetprotohttpVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn net_proto_http_vector_scale(v : NetprotohttpVector, s : Double) -> NetprotohttpVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn net_proto_http_vector_dot(a : NetprotohttpVector, b : NetprotohttpVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn net_proto_http_vector_norm(v : NetprotohttpVector) -> Double { @_common.sqrt(net_proto_http_vector_dot(v, v)) }

pub fn net_proto_http_vector_normalize(v : NetprotohttpVector) -> NetprotohttpVector {
  let n = net_proto_http_vector_norm(v)
  if n < 0.0000001 { v } else { net_proto_http_vector_scale(v, 1.0 / n) }
}

pub fn net_proto_http_vector_dist(a : NetprotohttpVector, b : NetprotohttpVector) -> Double {
  net_proto_http_vector_norm(net_proto_http_vector_sub(a, b))
}

pub fn net_proto_http_vector_to_string(v : NetprotohttpVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn net_proto_http_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn net_proto_http_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn net_proto_http_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn net_proto_http_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn net_proto_http_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn net_proto_http_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn net_proto_http_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn net_proto_http_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn net_proto_http_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn net_proto_http_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn net_proto_http_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn net_proto_http_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn net_proto_http_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn net_proto_http_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn net_proto_http_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn net_proto_http_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn net_proto_http_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn net_proto_http_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn net_proto_http_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn net_proto_http_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn net_proto_http_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn net_proto_http_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn net_proto_http_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn net_proto_http_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn net_proto_http_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn net_proto_http_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn net_proto_http_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn net_proto_http_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn net_proto_http_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct NetprotohttpFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_http_frame_make(size : Int) -> NetprotohttpFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_http_frame_len(s : NetprotohttpFrame) -> Int { s.size }

pub fn net_proto_http_frame_get(s : NetprotohttpFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_http_frame_set(s : NetprotohttpFrame, i : Int, v : Double) -> NetprotohttpFrame {
  let result = net_proto_http_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_proto_http_frame_sum(s : NetprotohttpFrame) -> Double { @_common.sum(s.data) }

pub fn net_proto_http_frame_mean(s : NetprotohttpFrame) -> Double { @_common.mean(s.data) }

pub fn net_proto_http_frame_scale(s : NetprotohttpFrame, f : Double) -> NetprotohttpFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_proto_http_frame_add(a : NetprotohttpFrame, b : NetprotohttpFrame) -> NetprotohttpFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_proto_http_frame_copy(s : NetprotohttpFrame) -> NetprotohttpFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_proto_http_frame_fill(s : NetprotohttpFrame, v : Double) -> NetprotohttpFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_proto_http_frame_min(s : NetprotohttpFrame) -> Double { @_common.min(s.data) }

pub fn net_proto_http_frame_max(s : NetprotohttpFrame) -> Double { @_common.max(s.data) }

pub fn net_proto_http_frame_to_string(s : NetprotohttpFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotohttpTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_http_table_make(size : Int) -> NetprotohttpTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_http_table_len(s : NetprotohttpTable) -> Int { s.size }

pub fn net_proto_http_table_get(s : NetprotohttpTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_http_table_set(s : NetprotohttpTable, i : Int, v : Double) -> NetprotohttpTable {
  let result = net_proto_http_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_proto_http_table_sum(s : NetprotohttpTable) -> Double { @_common.sum(s.data) }

pub fn net_proto_http_table_mean(s : NetprotohttpTable) -> Double { @_common.mean(s.data) }

pub fn net_proto_http_table_scale(s : NetprotohttpTable, f : Double) -> NetprotohttpTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_proto_http_table_add(a : NetprotohttpTable, b : NetprotohttpTable) -> NetprotohttpTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_proto_http_table_copy(s : NetprotohttpTable) -> NetprotohttpTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_proto_http_table_fill(s : NetprotohttpTable, v : Double) -> NetprotohttpTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_proto_http_table_min(s : NetprotohttpTable) -> Double { @_common.min(s.data) }

pub fn net_proto_http_table_max(s : NetprotohttpTable) -> Double { @_common.max(s.data) }

pub fn net_proto_http_table_to_string(s : NetprotohttpTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotohttpGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_http_graphn_make(size : Int) -> NetprotohttpGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_http_graphn_len(s : NetprotohttpGraphN) -> Int { s.size }

pub fn net_proto_http_graphn_get(s : NetprotohttpGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_http_graphn_set(s : NetprotohttpGraphN, i : Int, v : Double) -> NetprotohttpGraphN {
  let result = net_proto_http_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_proto_http_graphn_sum(s : NetprotohttpGraphN) -> Double { @_common.sum(s.data) }

pub fn net_proto_http_graphn_mean(s : NetprotohttpGraphN) -> Double { @_common.mean(s.data) }

pub fn net_proto_http_graphn_scale(s : NetprotohttpGraphN, f : Double) -> NetprotohttpGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_proto_http_graphn_add(a : NetprotohttpGraphN, b : NetprotohttpGraphN) -> NetprotohttpGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_proto_http_graphn_copy(s : NetprotohttpGraphN) -> NetprotohttpGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_proto_http_graphn_fill(s : NetprotohttpGraphN, v : Double) -> NetprotohttpGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_proto_http_graphn_min(s : NetprotohttpGraphN) -> Double { @_common.min(s.data) }

pub fn net_proto_http_graphn_max(s : NetprotohttpGraphN) -> Double { @_common.max(s.data) }

pub fn net_proto_http_graphn_to_string(s : NetprotohttpGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotohttpNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_http_node_make(size : Int) -> NetprotohttpNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_http_node_len(s : NetprotohttpNode) -> Int { s.size }

pub fn net_proto_http_node_get(s : NetprotohttpNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_http_node_set(s : NetprotohttpNode, i : Int, v : Double) -> NetprotohttpNode {
  let result = net_proto_http_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_proto_http_node_sum(s : NetprotohttpNode) -> Double { @_common.sum(s.data) }

pub fn net_proto_http_node_mean(s : NetprotohttpNode) -> Double { @_common.mean(s.data) }

pub fn net_proto_http_node_scale(s : NetprotohttpNode, f : Double) -> NetprotohttpNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_proto_http_node_add(a : NetprotohttpNode, b : NetprotohttpNode) -> NetprotohttpNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_proto_http_node_copy(s : NetprotohttpNode) -> NetprotohttpNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_proto_http_node_fill(s : NetprotohttpNode, v : Double) -> NetprotohttpNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_proto_http_node_min(s : NetprotohttpNode) -> Double { @_common.min(s.data) }

pub fn net_proto_http_node_max(s : NetprotohttpNode) -> Double { @_common.max(s.data) }

pub fn net_proto_http_node_to_string(s : NetprotohttpNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotohttpEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_http_edge_make(size : Int) -> NetprotohttpEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_http_edge_len(s : NetprotohttpEdge) -> Int { s.size }

pub fn net_proto_http_edge_get(s : NetprotohttpEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_http_edge_set(s : NetprotohttpEdge, i : Int, v : Double) -> NetprotohttpEdge {
  let result = net_proto_http_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_proto_http_edge_sum(s : NetprotohttpEdge) -> Double { @_common.sum(s.data) }

pub fn net_proto_http_edge_mean(s : NetprotohttpEdge) -> Double { @_common.mean(s.data) }

pub fn net_proto_http_edge_scale(s : NetprotohttpEdge, f : Double) -> NetprotohttpEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_proto_http_edge_add(a : NetprotohttpEdge, b : NetprotohttpEdge) -> NetprotohttpEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_proto_http_edge_copy(s : NetprotohttpEdge) -> NetprotohttpEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_proto_http_edge_fill(s : NetprotohttpEdge, v : Double) -> NetprotohttpEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_proto_http_edge_min(s : NetprotohttpEdge) -> Double { @_common.min(s.data) }

pub fn net_proto_http_edge_max(s : NetprotohttpEdge) -> Double { @_common.max(s.data) }

pub fn net_proto_http_edge_to_string(s : NetprotohttpEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotohttpPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_http_path_make(size : Int) -> NetprotohttpPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_http_path_len(s : NetprotohttpPath) -> Int { s.size }

pub fn net_proto_http_path_get(s : NetprotohttpPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_http_path_set(s : NetprotohttpPath, i : Int, v : Double) -> NetprotohttpPath {
  let result = net_proto_http_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_proto_http_path_sum(s : NetprotohttpPath) -> Double { @_common.sum(s.data) }

pub fn net_proto_http_path_mean(s : NetprotohttpPath) -> Double { @_common.mean(s.data) }

pub fn net_proto_http_path_scale(s : NetprotohttpPath, f : Double) -> NetprotohttpPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_proto_http_path_add(a : NetprotohttpPath, b : NetprotohttpPath) -> NetprotohttpPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_proto_http_path_copy(s : NetprotohttpPath) -> NetprotohttpPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_proto_http_path_fill(s : NetprotohttpPath, v : Double) -> NetprotohttpPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_proto_http_path_min(s : NetprotohttpPath) -> Double { @_common.min(s.data) }

pub fn net_proto_http_path_max(s : NetprotohttpPath) -> Double { @_common.max(s.data) }

pub fn net_proto_http_path_to_string(s : NetprotohttpPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotohttpCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_http_cluster_make(size : Int) -> NetprotohttpCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_http_cluster_len(s : NetprotohttpCluster) -> Int { s.size }

pub fn net_proto_http_cluster_get(s : NetprotohttpCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_http_cluster_set(s : NetprotohttpCluster, i : Int, v : Double) -> NetprotohttpCluster {
  let result = net_proto_http_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_proto_http_cluster_sum(s : NetprotohttpCluster) -> Double { @_common.sum(s.data) }

pub fn net_proto_http_cluster_mean(s : NetprotohttpCluster) -> Double { @_common.mean(s.data) }

pub fn net_proto_http_cluster_scale(s : NetprotohttpCluster, f : Double) -> NetprotohttpCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_proto_http_cluster_add(a : NetprotohttpCluster, b : NetprotohttpCluster) -> NetprotohttpCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_proto_http_cluster_copy(s : NetprotohttpCluster) -> NetprotohttpCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_proto_http_cluster_fill(s : NetprotohttpCluster, v : Double) -> NetprotohttpCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_proto_http_cluster_min(s : NetprotohttpCluster) -> Double { @_common.min(s.data) }

pub fn net_proto_http_cluster_max(s : NetprotohttpCluster) -> Double { @_common.max(s.data) }

pub fn net_proto_http_cluster_to_string(s : NetprotohttpCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotohttpModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_http_model_make(size : Int) -> NetprotohttpModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_http_model_len(s : NetprotohttpModel) -> Int { s.size }

pub fn net_proto_http_model_get(s : NetprotohttpModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_http_model_set(s : NetprotohttpModel, i : Int, v : Double) -> NetprotohttpModel {
  let result = net_proto_http_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_proto_http_model_sum(s : NetprotohttpModel) -> Double { @_common.sum(s.data) }

pub fn net_proto_http_model_mean(s : NetprotohttpModel) -> Double { @_common.mean(s.data) }

pub fn net_proto_http_model_scale(s : NetprotohttpModel, f : Double) -> NetprotohttpModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_proto_http_model_add(a : NetprotohttpModel, b : NetprotohttpModel) -> NetprotohttpModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_proto_http_model_copy(s : NetprotohttpModel) -> NetprotohttpModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_proto_http_model_fill(s : NetprotohttpModel, v : Double) -> NetprotohttpModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_proto_http_model_min(s : NetprotohttpModel) -> Double { @_common.min(s.data) }

pub fn net_proto_http_model_max(s : NetprotohttpModel) -> Double { @_common.max(s.data) }

pub fn net_proto_http_model_to_string(s : NetprotohttpModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotohttpLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_http_layer_make(size : Int) -> NetprotohttpLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_http_layer_len(s : NetprotohttpLayer) -> Int { s.size }

pub fn net_proto_http_layer_get(s : NetprotohttpLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_http_layer_set(s : NetprotohttpLayer, i : Int, v : Double) -> NetprotohttpLayer {
  let result = net_proto_http_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_proto_http_layer_sum(s : NetprotohttpLayer) -> Double { @_common.sum(s.data) }

pub fn net_proto_http_layer_mean(s : NetprotohttpLayer) -> Double { @_common.mean(s.data) }

pub fn net_proto_http_layer_scale(s : NetprotohttpLayer, f : Double) -> NetprotohttpLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_proto_http_layer_add(a : NetprotohttpLayer, b : NetprotohttpLayer) -> NetprotohttpLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_proto_http_layer_copy(s : NetprotohttpLayer) -> NetprotohttpLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_proto_http_layer_fill(s : NetprotohttpLayer, v : Double) -> NetprotohttpLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_proto_http_layer_min(s : NetprotohttpLayer) -> Double { @_common.min(s.data) }

pub fn net_proto_http_layer_max(s : NetprotohttpLayer) -> Double { @_common.max(s.data) }

pub fn net_proto_http_layer_to_string(s : NetprotohttpLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotohttpBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_http_buffer_make(size : Int) -> NetprotohttpBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_http_buffer_len(s : NetprotohttpBuffer) -> Int { s.size }

pub fn net_proto_http_buffer_get(s : NetprotohttpBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_http_buffer_set(s : NetprotohttpBuffer, i : Int, v : Double) -> NetprotohttpBuffer {
  let result = net_proto_http_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_proto_http_buffer_sum(s : NetprotohttpBuffer) -> Double { @_common.sum(s.data) }

pub fn net_proto_http_buffer_mean(s : NetprotohttpBuffer) -> Double { @_common.mean(s.data) }

pub fn net_proto_http_buffer_scale(s : NetprotohttpBuffer, f : Double) -> NetprotohttpBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_proto_http_buffer_add(a : NetprotohttpBuffer, b : NetprotohttpBuffer) -> NetprotohttpBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_proto_http_buffer_copy(s : NetprotohttpBuffer) -> NetprotohttpBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_proto_http_buffer_fill(s : NetprotohttpBuffer, v : Double) -> NetprotohttpBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_proto_http_buffer_min(s : NetprotohttpBuffer) -> Double { @_common.min(s.data) }

pub fn net_proto_http_buffer_max(s : NetprotohttpBuffer) -> Double { @_common.max(s.data) }

pub fn net_proto_http_buffer_to_string(s : NetprotohttpBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotohttpCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_http_cursor_make(size : Int) -> NetprotohttpCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_http_cursor_len(s : NetprotohttpCursor) -> Int { s.size }

pub fn net_proto_http_cursor_get(s : NetprotohttpCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_http_cursor_set(s : NetprotohttpCursor, i : Int, v : Double) -> NetprotohttpCursor {
  let result = net_proto_http_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_proto_http_cursor_sum(s : NetprotohttpCursor) -> Double { @_common.sum(s.data) }

pub fn net_proto_http_cursor_mean(s : NetprotohttpCursor) -> Double { @_common.mean(s.data) }

pub fn net_proto_http_cursor_scale(s : NetprotohttpCursor, f : Double) -> NetprotohttpCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_proto_http_cursor_add(a : NetprotohttpCursor, b : NetprotohttpCursor) -> NetprotohttpCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_proto_http_cursor_copy(s : NetprotohttpCursor) -> NetprotohttpCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_proto_http_cursor_fill(s : NetprotohttpCursor, v : Double) -> NetprotohttpCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_proto_http_cursor_min(s : NetprotohttpCursor) -> Double { @_common.min(s.data) }

pub fn net_proto_http_cursor_max(s : NetprotohttpCursor) -> Double { @_common.max(s.data) }

pub fn net_proto_http_cursor_to_string(s : NetprotohttpCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotohttpView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_http_view_make(size : Int) -> NetprotohttpView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_http_view_len(s : NetprotohttpView) -> Int { s.size }

pub fn net_proto_http_view_get(s : NetprotohttpView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_http_view_set(s : NetprotohttpView, i : Int, v : Double) -> NetprotohttpView {
  let result = net_proto_http_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_proto_http_view_sum(s : NetprotohttpView) -> Double { @_common.sum(s.data) }

pub fn net_proto_http_view_mean(s : NetprotohttpView) -> Double { @_common.mean(s.data) }

pub fn net_proto_http_view_scale(s : NetprotohttpView, f : Double) -> NetprotohttpView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_proto_http_view_add(a : NetprotohttpView, b : NetprotohttpView) -> NetprotohttpView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_proto_http_view_copy(s : NetprotohttpView) -> NetprotohttpView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_proto_http_view_fill(s : NetprotohttpView, v : Double) -> NetprotohttpView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_proto_http_view_min(s : NetprotohttpView) -> Double { @_common.min(s.data) }

pub fn net_proto_http_view_max(s : NetprotohttpView) -> Double { @_common.max(s.data) }

pub fn net_proto_http_view_to_string(s : NetprotohttpView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotohttpRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_http_range_make(size : Int) -> NetprotohttpRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_http_range_len(s : NetprotohttpRange) -> Int { s.size }

pub fn net_proto_http_range_get(s : NetprotohttpRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_http_range_set(s : NetprotohttpRange, i : Int, v : Double) -> NetprotohttpRange {
  let result = net_proto_http_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_proto_http_range_sum(s : NetprotohttpRange) -> Double { @_common.sum(s.data) }

pub fn net_proto_http_range_mean(s : NetprotohttpRange) -> Double { @_common.mean(s.data) }

pub fn net_proto_http_range_scale(s : NetprotohttpRange, f : Double) -> NetprotohttpRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_proto_http_range_add(a : NetprotohttpRange, b : NetprotohttpRange) -> NetprotohttpRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_proto_http_range_copy(s : NetprotohttpRange) -> NetprotohttpRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_proto_http_range_fill(s : NetprotohttpRange, v : Double) -> NetprotohttpRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_proto_http_range_min(s : NetprotohttpRange) -> Double { @_common.min(s.data) }

pub fn net_proto_http_range_max(s : NetprotohttpRange) -> Double { @_common.max(s.data) }

pub fn net_proto_http_range_to_string(s : NetprotohttpRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotohttpSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_http_slice_make(size : Int) -> NetprotohttpSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_http_slice_len(s : NetprotohttpSlice) -> Int { s.size }

pub fn net_proto_http_slice_get(s : NetprotohttpSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_http_slice_set(s : NetprotohttpSlice, i : Int, v : Double) -> NetprotohttpSlice {
  let result = net_proto_http_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_proto_http_slice_sum(s : NetprotohttpSlice) -> Double { @_common.sum(s.data) }

pub fn net_proto_http_slice_mean(s : NetprotohttpSlice) -> Double { @_common.mean(s.data) }

pub fn net_proto_http_slice_scale(s : NetprotohttpSlice, f : Double) -> NetprotohttpSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_proto_http_slice_add(a : NetprotohttpSlice, b : NetprotohttpSlice) -> NetprotohttpSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_proto_http_slice_copy(s : NetprotohttpSlice) -> NetprotohttpSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_proto_http_slice_fill(s : NetprotohttpSlice, v : Double) -> NetprotohttpSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_proto_http_slice_min(s : NetprotohttpSlice) -> Double { @_common.min(s.data) }

pub fn net_proto_http_slice_max(s : NetprotohttpSlice) -> Double { @_common.max(s.data) }

pub fn net_proto_http_slice_to_string(s : NetprotohttpSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

