///===
/// extcore/net_proto_https

pub(all) struct NetprotohttpsPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn net_proto_https_make_point(x : Double, y : Double) -> NetprotohttpsPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn net_proto_https_make_point3(x : Double, y : Double, z : Double) -> NetprotohttpsPoint {
  { x, y, z, label: 0 }
}

pub fn net_proto_https_point_x(pt : NetprotohttpsPoint) -> Double { pt.x }

pub fn net_proto_https_point_y(pt : NetprotohttpsPoint) -> Double { pt.y }

pub fn net_proto_https_point_z(pt : NetprotohttpsPoint) -> Double { pt.z }

pub fn net_proto_https_point_label(pt : NetprotohttpsPoint) -> Int { pt.label }

pub fn net_proto_https_point_dist(a : NetprotohttpsPoint, b : NetprotohttpsPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn net_proto_https_point_add(a : NetprotohttpsPoint, b : NetprotohttpsPoint) -> NetprotohttpsPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn net_proto_https_point_sub(a : NetprotohttpsPoint, b : NetprotohttpsPoint) -> NetprotohttpsPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn net_proto_https_point_scale(pt : NetprotohttpsPoint, s : Double) -> NetprotohttpsPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn net_proto_https_point_dot(a : NetprotohttpsPoint, b : NetprotohttpsPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn net_proto_https_point_cross(a : NetprotohttpsPoint, b : NetprotohttpsPoint) -> NetprotohttpsPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn net_proto_https_point_norm(pt : NetprotohttpsPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn net_proto_https_point_normalize(pt : NetprotohttpsPoint) -> NetprotohttpsPoint {
  let n = net_proto_https_point_norm(pt)
  if n < 0.0000001 { pt } else { net_proto_https_point_scale(pt, 1.0 / n) }
}

pub fn net_proto_https_point_negate(pt : NetprotohttpsPoint) -> NetprotohttpsPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn net_proto_https_point_mid(a : NetprotohttpsPoint, b : NetprotohttpsPoint) -> NetprotohttpsPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn net_proto_https_point_lerp(a : NetprotohttpsPoint, b : NetprotohttpsPoint, t : Double) -> NetprotohttpsPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn net_proto_https_point_to_string(pt : NetprotohttpsPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct NetprotohttpsSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn net_proto_https_make_series(vals : Array[Double], name : String) -> NetprotohttpsSeries {
  { vals, name, meta: 0 }
}

pub fn net_proto_https_series_len(s : NetprotohttpsSeries) -> Int { s.vals.length() }

pub fn net_proto_https_series_sum(s : NetprotohttpsSeries) -> Double { @_common.sum(s.vals) }

pub fn net_proto_https_series_mean(s : NetprotohttpsSeries) -> Double { @_common.mean(s.vals) }

pub fn net_proto_https_series_min(s : NetprotohttpsSeries) -> Double { @_common.min(s.vals) }

pub fn net_proto_https_series_max(s : NetprotohttpsSeries) -> Double { @_common.max(s.vals) }

pub fn net_proto_https_series_range(s : NetprotohttpsSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn net_proto_https_series_var(s : NetprotohttpsSeries) -> Double { @_common.variance(s.vals) }

pub fn net_proto_https_series_std(s : NetprotohttpsSeries) -> Double { @_common.std(s.vals) }

pub fn net_proto_https_series_median(s : NetprotohttpsSeries) -> Double { @_common.median(s.vals) }

pub fn net_proto_https_series_scale(s : NetprotohttpsSeries, f : Double) -> NetprotohttpsSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn net_proto_https_series_add(a : NetprotohttpsSeries, b : NetprotohttpsSeries) -> NetprotohttpsSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn net_proto_https_series_sub(a : NetprotohttpsSeries, b : NetprotohttpsSeries) -> NetprotohttpsSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn net_proto_https_series_normalize(s : NetprotohttpsSeries) -> NetprotohttpsSeries {
  let mn = net_proto_https_series_min(s)
  let mx = net_proto_https_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn net_proto_https_series_cumsum(s : NetprotohttpsSeries) -> NetprotohttpsSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn net_proto_https_series_to_string(s : NetprotohttpsSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NetprotohttpsMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn net_proto_https_make_matrix(rows : Int, cols : Int, val : Double) -> NetprotohttpsMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn net_proto_https_matrix_identity(n : Int) -> NetprotohttpsMatrix {
  let m = net_proto_https_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn net_proto_https_matrix_get(m : NetprotohttpsMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn net_proto_https_matrix_transpose(m : NetprotohttpsMatrix) -> NetprotohttpsMatrix {
  let result = net_proto_https_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn net_proto_https_matrix_add(a : NetprotohttpsMatrix, b : NetprotohttpsMatrix) -> NetprotohttpsMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = net_proto_https_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn net_proto_https_matrix_scale(m : NetprotohttpsMatrix, s : Double) -> NetprotohttpsMatrix {
  let result = net_proto_https_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn net_proto_https_matrix_multiply(a : NetprotohttpsMatrix, b : NetprotohttpsMatrix) -> NetprotohttpsMatrix {
  if a.cols != b.rows { return net_proto_https_make_matrix(a.rows, b.cols, 0.0) }
  let result = net_proto_https_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn net_proto_https_matrix_trace(m : NetprotohttpsMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn net_proto_https_matrix_det(m : NetprotohttpsMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn net_proto_https_matrix_norm(m : NetprotohttpsMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn net_proto_https_matrix_to_string(m : NetprotohttpsMatrix) -> String {
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

pub(all) struct NetprotohttpsVector {
  comps : Array[Double]
  dim : Int
}

pub fn net_proto_https_make_vector(comps : Array[Double]) -> NetprotohttpsVector {
  { comps, dim: comps.length() }
}

pub fn net_proto_https_vector_zero(dim : Int) -> NetprotohttpsVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn net_proto_https_vector_add(a : NetprotohttpsVector, b : NetprotohttpsVector) -> NetprotohttpsVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn net_proto_https_vector_sub(a : NetprotohttpsVector, b : NetprotohttpsVector) -> NetprotohttpsVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn net_proto_https_vector_scale(v : NetprotohttpsVector, s : Double) -> NetprotohttpsVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn net_proto_https_vector_dot(a : NetprotohttpsVector, b : NetprotohttpsVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn net_proto_https_vector_norm(v : NetprotohttpsVector) -> Double { @_common.sqrt(net_proto_https_vector_dot(v, v)) }

pub fn net_proto_https_vector_normalize(v : NetprotohttpsVector) -> NetprotohttpsVector {
  let n = net_proto_https_vector_norm(v)
  if n < 0.0000001 { v } else { net_proto_https_vector_scale(v, 1.0 / n) }
}

pub fn net_proto_https_vector_dist(a : NetprotohttpsVector, b : NetprotohttpsVector) -> Double {
  net_proto_https_vector_norm(net_proto_https_vector_sub(a, b))
}

pub fn net_proto_https_vector_to_string(v : NetprotohttpsVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn net_proto_https_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn net_proto_https_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn net_proto_https_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn net_proto_https_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn net_proto_https_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn net_proto_https_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn net_proto_https_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn net_proto_https_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn net_proto_https_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn net_proto_https_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn net_proto_https_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn net_proto_https_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn net_proto_https_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn net_proto_https_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn net_proto_https_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn net_proto_https_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn net_proto_https_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn net_proto_https_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn net_proto_https_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn net_proto_https_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn net_proto_https_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn net_proto_https_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn net_proto_https_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn net_proto_https_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn net_proto_https_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn net_proto_https_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn net_proto_https_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn net_proto_https_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn net_proto_https_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct NetprotohttpsFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_https_frame_make(size : Int) -> NetprotohttpsFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_https_frame_len(s : NetprotohttpsFrame) -> Int { s.size }

pub fn net_proto_https_frame_get(s : NetprotohttpsFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_https_frame_set(s : NetprotohttpsFrame, i : Int, v : Double) -> NetprotohttpsFrame {
  let result = net_proto_https_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_proto_https_frame_sum(s : NetprotohttpsFrame) -> Double { @_common.sum(s.data) }

pub fn net_proto_https_frame_mean(s : NetprotohttpsFrame) -> Double { @_common.mean(s.data) }

pub fn net_proto_https_frame_scale(s : NetprotohttpsFrame, f : Double) -> NetprotohttpsFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_proto_https_frame_add(a : NetprotohttpsFrame, b : NetprotohttpsFrame) -> NetprotohttpsFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_proto_https_frame_copy(s : NetprotohttpsFrame) -> NetprotohttpsFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_proto_https_frame_fill(s : NetprotohttpsFrame, v : Double) -> NetprotohttpsFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_proto_https_frame_min(s : NetprotohttpsFrame) -> Double { @_common.min(s.data) }

pub fn net_proto_https_frame_max(s : NetprotohttpsFrame) -> Double { @_common.max(s.data) }

pub fn net_proto_https_frame_to_string(s : NetprotohttpsFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotohttpsTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_https_table_make(size : Int) -> NetprotohttpsTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_https_table_len(s : NetprotohttpsTable) -> Int { s.size }

pub fn net_proto_https_table_get(s : NetprotohttpsTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_https_table_set(s : NetprotohttpsTable, i : Int, v : Double) -> NetprotohttpsTable {
  let result = net_proto_https_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_proto_https_table_sum(s : NetprotohttpsTable) -> Double { @_common.sum(s.data) }

pub fn net_proto_https_table_mean(s : NetprotohttpsTable) -> Double { @_common.mean(s.data) }

pub fn net_proto_https_table_scale(s : NetprotohttpsTable, f : Double) -> NetprotohttpsTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_proto_https_table_add(a : NetprotohttpsTable, b : NetprotohttpsTable) -> NetprotohttpsTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_proto_https_table_copy(s : NetprotohttpsTable) -> NetprotohttpsTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_proto_https_table_fill(s : NetprotohttpsTable, v : Double) -> NetprotohttpsTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_proto_https_table_min(s : NetprotohttpsTable) -> Double { @_common.min(s.data) }

pub fn net_proto_https_table_max(s : NetprotohttpsTable) -> Double { @_common.max(s.data) }

pub fn net_proto_https_table_to_string(s : NetprotohttpsTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotohttpsGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_https_graphn_make(size : Int) -> NetprotohttpsGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_https_graphn_len(s : NetprotohttpsGraphN) -> Int { s.size }

pub fn net_proto_https_graphn_get(s : NetprotohttpsGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_https_graphn_set(s : NetprotohttpsGraphN, i : Int, v : Double) -> NetprotohttpsGraphN {
  let result = net_proto_https_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_proto_https_graphn_sum(s : NetprotohttpsGraphN) -> Double { @_common.sum(s.data) }

pub fn net_proto_https_graphn_mean(s : NetprotohttpsGraphN) -> Double { @_common.mean(s.data) }

pub fn net_proto_https_graphn_scale(s : NetprotohttpsGraphN, f : Double) -> NetprotohttpsGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_proto_https_graphn_add(a : NetprotohttpsGraphN, b : NetprotohttpsGraphN) -> NetprotohttpsGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_proto_https_graphn_copy(s : NetprotohttpsGraphN) -> NetprotohttpsGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_proto_https_graphn_fill(s : NetprotohttpsGraphN, v : Double) -> NetprotohttpsGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_proto_https_graphn_min(s : NetprotohttpsGraphN) -> Double { @_common.min(s.data) }

pub fn net_proto_https_graphn_max(s : NetprotohttpsGraphN) -> Double { @_common.max(s.data) }

pub fn net_proto_https_graphn_to_string(s : NetprotohttpsGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotohttpsNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_https_node_make(size : Int) -> NetprotohttpsNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_https_node_len(s : NetprotohttpsNode) -> Int { s.size }

pub fn net_proto_https_node_get(s : NetprotohttpsNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_https_node_set(s : NetprotohttpsNode, i : Int, v : Double) -> NetprotohttpsNode {
  let result = net_proto_https_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_proto_https_node_sum(s : NetprotohttpsNode) -> Double { @_common.sum(s.data) }

pub fn net_proto_https_node_mean(s : NetprotohttpsNode) -> Double { @_common.mean(s.data) }

pub fn net_proto_https_node_scale(s : NetprotohttpsNode, f : Double) -> NetprotohttpsNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_proto_https_node_add(a : NetprotohttpsNode, b : NetprotohttpsNode) -> NetprotohttpsNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_proto_https_node_copy(s : NetprotohttpsNode) -> NetprotohttpsNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_proto_https_node_fill(s : NetprotohttpsNode, v : Double) -> NetprotohttpsNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_proto_https_node_min(s : NetprotohttpsNode) -> Double { @_common.min(s.data) }

pub fn net_proto_https_node_max(s : NetprotohttpsNode) -> Double { @_common.max(s.data) }

pub fn net_proto_https_node_to_string(s : NetprotohttpsNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotohttpsEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_https_edge_make(size : Int) -> NetprotohttpsEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_https_edge_len(s : NetprotohttpsEdge) -> Int { s.size }

pub fn net_proto_https_edge_get(s : NetprotohttpsEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_https_edge_set(s : NetprotohttpsEdge, i : Int, v : Double) -> NetprotohttpsEdge {
  let result = net_proto_https_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_proto_https_edge_sum(s : NetprotohttpsEdge) -> Double { @_common.sum(s.data) }

pub fn net_proto_https_edge_mean(s : NetprotohttpsEdge) -> Double { @_common.mean(s.data) }

pub fn net_proto_https_edge_scale(s : NetprotohttpsEdge, f : Double) -> NetprotohttpsEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_proto_https_edge_add(a : NetprotohttpsEdge, b : NetprotohttpsEdge) -> NetprotohttpsEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_proto_https_edge_copy(s : NetprotohttpsEdge) -> NetprotohttpsEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_proto_https_edge_fill(s : NetprotohttpsEdge, v : Double) -> NetprotohttpsEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_proto_https_edge_min(s : NetprotohttpsEdge) -> Double { @_common.min(s.data) }

pub fn net_proto_https_edge_max(s : NetprotohttpsEdge) -> Double { @_common.max(s.data) }

pub fn net_proto_https_edge_to_string(s : NetprotohttpsEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotohttpsPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_https_path_make(size : Int) -> NetprotohttpsPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_https_path_len(s : NetprotohttpsPath) -> Int { s.size }

pub fn net_proto_https_path_get(s : NetprotohttpsPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_https_path_set(s : NetprotohttpsPath, i : Int, v : Double) -> NetprotohttpsPath {
  let result = net_proto_https_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_proto_https_path_sum(s : NetprotohttpsPath) -> Double { @_common.sum(s.data) }

pub fn net_proto_https_path_mean(s : NetprotohttpsPath) -> Double { @_common.mean(s.data) }

pub fn net_proto_https_path_scale(s : NetprotohttpsPath, f : Double) -> NetprotohttpsPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_proto_https_path_add(a : NetprotohttpsPath, b : NetprotohttpsPath) -> NetprotohttpsPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_proto_https_path_copy(s : NetprotohttpsPath) -> NetprotohttpsPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_proto_https_path_fill(s : NetprotohttpsPath, v : Double) -> NetprotohttpsPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_proto_https_path_min(s : NetprotohttpsPath) -> Double { @_common.min(s.data) }

pub fn net_proto_https_path_max(s : NetprotohttpsPath) -> Double { @_common.max(s.data) }

pub fn net_proto_https_path_to_string(s : NetprotohttpsPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotohttpsCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_https_cluster_make(size : Int) -> NetprotohttpsCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_https_cluster_len(s : NetprotohttpsCluster) -> Int { s.size }

pub fn net_proto_https_cluster_get(s : NetprotohttpsCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_https_cluster_set(s : NetprotohttpsCluster, i : Int, v : Double) -> NetprotohttpsCluster {
  let result = net_proto_https_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_proto_https_cluster_sum(s : NetprotohttpsCluster) -> Double { @_common.sum(s.data) }

pub fn net_proto_https_cluster_mean(s : NetprotohttpsCluster) -> Double { @_common.mean(s.data) }

pub fn net_proto_https_cluster_scale(s : NetprotohttpsCluster, f : Double) -> NetprotohttpsCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_proto_https_cluster_add(a : NetprotohttpsCluster, b : NetprotohttpsCluster) -> NetprotohttpsCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_proto_https_cluster_copy(s : NetprotohttpsCluster) -> NetprotohttpsCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_proto_https_cluster_fill(s : NetprotohttpsCluster, v : Double) -> NetprotohttpsCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_proto_https_cluster_min(s : NetprotohttpsCluster) -> Double { @_common.min(s.data) }

pub fn net_proto_https_cluster_max(s : NetprotohttpsCluster) -> Double { @_common.max(s.data) }

pub fn net_proto_https_cluster_to_string(s : NetprotohttpsCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotohttpsModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_https_model_make(size : Int) -> NetprotohttpsModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_https_model_len(s : NetprotohttpsModel) -> Int { s.size }

pub fn net_proto_https_model_get(s : NetprotohttpsModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_https_model_set(s : NetprotohttpsModel, i : Int, v : Double) -> NetprotohttpsModel {
  let result = net_proto_https_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_proto_https_model_sum(s : NetprotohttpsModel) -> Double { @_common.sum(s.data) }

pub fn net_proto_https_model_mean(s : NetprotohttpsModel) -> Double { @_common.mean(s.data) }

pub fn net_proto_https_model_scale(s : NetprotohttpsModel, f : Double) -> NetprotohttpsModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_proto_https_model_add(a : NetprotohttpsModel, b : NetprotohttpsModel) -> NetprotohttpsModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_proto_https_model_copy(s : NetprotohttpsModel) -> NetprotohttpsModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_proto_https_model_fill(s : NetprotohttpsModel, v : Double) -> NetprotohttpsModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_proto_https_model_min(s : NetprotohttpsModel) -> Double { @_common.min(s.data) }

pub fn net_proto_https_model_max(s : NetprotohttpsModel) -> Double { @_common.max(s.data) }

pub fn net_proto_https_model_to_string(s : NetprotohttpsModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotohttpsLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_https_layer_make(size : Int) -> NetprotohttpsLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_https_layer_len(s : NetprotohttpsLayer) -> Int { s.size }

pub fn net_proto_https_layer_get(s : NetprotohttpsLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_https_layer_set(s : NetprotohttpsLayer, i : Int, v : Double) -> NetprotohttpsLayer {
  let result = net_proto_https_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_proto_https_layer_sum(s : NetprotohttpsLayer) -> Double { @_common.sum(s.data) }

pub fn net_proto_https_layer_mean(s : NetprotohttpsLayer) -> Double { @_common.mean(s.data) }

pub fn net_proto_https_layer_scale(s : NetprotohttpsLayer, f : Double) -> NetprotohttpsLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_proto_https_layer_add(a : NetprotohttpsLayer, b : NetprotohttpsLayer) -> NetprotohttpsLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_proto_https_layer_copy(s : NetprotohttpsLayer) -> NetprotohttpsLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_proto_https_layer_fill(s : NetprotohttpsLayer, v : Double) -> NetprotohttpsLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_proto_https_layer_min(s : NetprotohttpsLayer) -> Double { @_common.min(s.data) }

pub fn net_proto_https_layer_max(s : NetprotohttpsLayer) -> Double { @_common.max(s.data) }

pub fn net_proto_https_layer_to_string(s : NetprotohttpsLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotohttpsBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_https_buffer_make(size : Int) -> NetprotohttpsBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_https_buffer_len(s : NetprotohttpsBuffer) -> Int { s.size }

pub fn net_proto_https_buffer_get(s : NetprotohttpsBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_https_buffer_set(s : NetprotohttpsBuffer, i : Int, v : Double) -> NetprotohttpsBuffer {
  let result = net_proto_https_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_proto_https_buffer_sum(s : NetprotohttpsBuffer) -> Double { @_common.sum(s.data) }

pub fn net_proto_https_buffer_mean(s : NetprotohttpsBuffer) -> Double { @_common.mean(s.data) }

pub fn net_proto_https_buffer_scale(s : NetprotohttpsBuffer, f : Double) -> NetprotohttpsBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_proto_https_buffer_add(a : NetprotohttpsBuffer, b : NetprotohttpsBuffer) -> NetprotohttpsBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_proto_https_buffer_copy(s : NetprotohttpsBuffer) -> NetprotohttpsBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_proto_https_buffer_fill(s : NetprotohttpsBuffer, v : Double) -> NetprotohttpsBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_proto_https_buffer_min(s : NetprotohttpsBuffer) -> Double { @_common.min(s.data) }

pub fn net_proto_https_buffer_max(s : NetprotohttpsBuffer) -> Double { @_common.max(s.data) }

pub fn net_proto_https_buffer_to_string(s : NetprotohttpsBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotohttpsCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_https_cursor_make(size : Int) -> NetprotohttpsCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_https_cursor_len(s : NetprotohttpsCursor) -> Int { s.size }

pub fn net_proto_https_cursor_get(s : NetprotohttpsCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_https_cursor_set(s : NetprotohttpsCursor, i : Int, v : Double) -> NetprotohttpsCursor {
  let result = net_proto_https_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_proto_https_cursor_sum(s : NetprotohttpsCursor) -> Double { @_common.sum(s.data) }

pub fn net_proto_https_cursor_mean(s : NetprotohttpsCursor) -> Double { @_common.mean(s.data) }

pub fn net_proto_https_cursor_scale(s : NetprotohttpsCursor, f : Double) -> NetprotohttpsCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_proto_https_cursor_add(a : NetprotohttpsCursor, b : NetprotohttpsCursor) -> NetprotohttpsCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_proto_https_cursor_copy(s : NetprotohttpsCursor) -> NetprotohttpsCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_proto_https_cursor_fill(s : NetprotohttpsCursor, v : Double) -> NetprotohttpsCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_proto_https_cursor_min(s : NetprotohttpsCursor) -> Double { @_common.min(s.data) }

pub fn net_proto_https_cursor_max(s : NetprotohttpsCursor) -> Double { @_common.max(s.data) }

pub fn net_proto_https_cursor_to_string(s : NetprotohttpsCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotohttpsView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_https_view_make(size : Int) -> NetprotohttpsView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_https_view_len(s : NetprotohttpsView) -> Int { s.size }

pub fn net_proto_https_view_get(s : NetprotohttpsView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_https_view_set(s : NetprotohttpsView, i : Int, v : Double) -> NetprotohttpsView {
  let result = net_proto_https_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_proto_https_view_sum(s : NetprotohttpsView) -> Double { @_common.sum(s.data) }

pub fn net_proto_https_view_mean(s : NetprotohttpsView) -> Double { @_common.mean(s.data) }

pub fn net_proto_https_view_scale(s : NetprotohttpsView, f : Double) -> NetprotohttpsView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_proto_https_view_add(a : NetprotohttpsView, b : NetprotohttpsView) -> NetprotohttpsView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_proto_https_view_copy(s : NetprotohttpsView) -> NetprotohttpsView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_proto_https_view_fill(s : NetprotohttpsView, v : Double) -> NetprotohttpsView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_proto_https_view_min(s : NetprotohttpsView) -> Double { @_common.min(s.data) }

pub fn net_proto_https_view_max(s : NetprotohttpsView) -> Double { @_common.max(s.data) }

pub fn net_proto_https_view_to_string(s : NetprotohttpsView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotohttpsRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_https_range_make(size : Int) -> NetprotohttpsRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_https_range_len(s : NetprotohttpsRange) -> Int { s.size }

pub fn net_proto_https_range_get(s : NetprotohttpsRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_https_range_set(s : NetprotohttpsRange, i : Int, v : Double) -> NetprotohttpsRange {
  let result = net_proto_https_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_proto_https_range_sum(s : NetprotohttpsRange) -> Double { @_common.sum(s.data) }

pub fn net_proto_https_range_mean(s : NetprotohttpsRange) -> Double { @_common.mean(s.data) }

pub fn net_proto_https_range_scale(s : NetprotohttpsRange, f : Double) -> NetprotohttpsRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_proto_https_range_add(a : NetprotohttpsRange, b : NetprotohttpsRange) -> NetprotohttpsRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_proto_https_range_copy(s : NetprotohttpsRange) -> NetprotohttpsRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_proto_https_range_fill(s : NetprotohttpsRange, v : Double) -> NetprotohttpsRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_proto_https_range_min(s : NetprotohttpsRange) -> Double { @_common.min(s.data) }

pub fn net_proto_https_range_max(s : NetprotohttpsRange) -> Double { @_common.max(s.data) }

pub fn net_proto_https_range_to_string(s : NetprotohttpsRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotohttpsSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_https_slice_make(size : Int) -> NetprotohttpsSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_https_slice_len(s : NetprotohttpsSlice) -> Int { s.size }

pub fn net_proto_https_slice_get(s : NetprotohttpsSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_https_slice_set(s : NetprotohttpsSlice, i : Int, v : Double) -> NetprotohttpsSlice {
  let result = net_proto_https_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_proto_https_slice_sum(s : NetprotohttpsSlice) -> Double { @_common.sum(s.data) }

pub fn net_proto_https_slice_mean(s : NetprotohttpsSlice) -> Double { @_common.mean(s.data) }

pub fn net_proto_https_slice_scale(s : NetprotohttpsSlice, f : Double) -> NetprotohttpsSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_proto_https_slice_add(a : NetprotohttpsSlice, b : NetprotohttpsSlice) -> NetprotohttpsSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_proto_https_slice_copy(s : NetprotohttpsSlice) -> NetprotohttpsSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_proto_https_slice_fill(s : NetprotohttpsSlice, v : Double) -> NetprotohttpsSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_proto_https_slice_min(s : NetprotohttpsSlice) -> Double { @_common.min(s.data) }

pub fn net_proto_https_slice_max(s : NetprotohttpsSlice) -> Double { @_common.max(s.data) }

pub fn net_proto_https_slice_to_string(s : NetprotohttpsSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

