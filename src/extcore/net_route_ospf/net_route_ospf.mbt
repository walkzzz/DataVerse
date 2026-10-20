///===
/// extcore/net_route_ospf

pub(all) struct NetrouteospfPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn net_route_ospf_make_point(x : Double, y : Double) -> NetrouteospfPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn net_route_ospf_make_point3(x : Double, y : Double, z : Double) -> NetrouteospfPoint {
  { x, y, z, label: 0 }
}

pub fn net_route_ospf_point_x(pt : NetrouteospfPoint) -> Double { pt.x }

pub fn net_route_ospf_point_y(pt : NetrouteospfPoint) -> Double { pt.y }

pub fn net_route_ospf_point_z(pt : NetrouteospfPoint) -> Double { pt.z }

pub fn net_route_ospf_point_label(pt : NetrouteospfPoint) -> Int { pt.label }

pub fn net_route_ospf_point_dist(a : NetrouteospfPoint, b : NetrouteospfPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn net_route_ospf_point_add(a : NetrouteospfPoint, b : NetrouteospfPoint) -> NetrouteospfPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn net_route_ospf_point_sub(a : NetrouteospfPoint, b : NetrouteospfPoint) -> NetrouteospfPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn net_route_ospf_point_scale(pt : NetrouteospfPoint, s : Double) -> NetrouteospfPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn net_route_ospf_point_dot(a : NetrouteospfPoint, b : NetrouteospfPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn net_route_ospf_point_cross(a : NetrouteospfPoint, b : NetrouteospfPoint) -> NetrouteospfPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn net_route_ospf_point_norm(pt : NetrouteospfPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn net_route_ospf_point_normalize(pt : NetrouteospfPoint) -> NetrouteospfPoint {
  let n = net_route_ospf_point_norm(pt)
  if n < 0.0000001 { pt } else { net_route_ospf_point_scale(pt, 1.0 / n) }
}

pub fn net_route_ospf_point_negate(pt : NetrouteospfPoint) -> NetrouteospfPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn net_route_ospf_point_mid(a : NetrouteospfPoint, b : NetrouteospfPoint) -> NetrouteospfPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn net_route_ospf_point_lerp(a : NetrouteospfPoint, b : NetrouteospfPoint, t : Double) -> NetrouteospfPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn net_route_ospf_point_to_string(pt : NetrouteospfPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct NetrouteospfSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn net_route_ospf_make_series(vals : Array[Double], name : String) -> NetrouteospfSeries {
  { vals, name, meta: 0 }
}

pub fn net_route_ospf_series_len(s : NetrouteospfSeries) -> Int { s.vals.length() }

pub fn net_route_ospf_series_sum(s : NetrouteospfSeries) -> Double { @_common.sum(s.vals) }

pub fn net_route_ospf_series_mean(s : NetrouteospfSeries) -> Double { @_common.mean(s.vals) }

pub fn net_route_ospf_series_min(s : NetrouteospfSeries) -> Double { @_common.min(s.vals) }

pub fn net_route_ospf_series_max(s : NetrouteospfSeries) -> Double { @_common.max(s.vals) }

pub fn net_route_ospf_series_range(s : NetrouteospfSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn net_route_ospf_series_var(s : NetrouteospfSeries) -> Double { @_common.variance(s.vals) }

pub fn net_route_ospf_series_std(s : NetrouteospfSeries) -> Double { @_common.std(s.vals) }

pub fn net_route_ospf_series_median(s : NetrouteospfSeries) -> Double { @_common.median(s.vals) }

pub fn net_route_ospf_series_scale(s : NetrouteospfSeries, f : Double) -> NetrouteospfSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn net_route_ospf_series_add(a : NetrouteospfSeries, b : NetrouteospfSeries) -> NetrouteospfSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn net_route_ospf_series_sub(a : NetrouteospfSeries, b : NetrouteospfSeries) -> NetrouteospfSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn net_route_ospf_series_normalize(s : NetrouteospfSeries) -> NetrouteospfSeries {
  let mn = net_route_ospf_series_min(s)
  let mx = net_route_ospf_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn net_route_ospf_series_cumsum(s : NetrouteospfSeries) -> NetrouteospfSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn net_route_ospf_series_to_string(s : NetrouteospfSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NetrouteospfMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn net_route_ospf_make_matrix(rows : Int, cols : Int, val : Double) -> NetrouteospfMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn net_route_ospf_matrix_identity(n : Int) -> NetrouteospfMatrix {
  let m = net_route_ospf_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn net_route_ospf_matrix_get(m : NetrouteospfMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn net_route_ospf_matrix_transpose(m : NetrouteospfMatrix) -> NetrouteospfMatrix {
  let result = net_route_ospf_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn net_route_ospf_matrix_add(a : NetrouteospfMatrix, b : NetrouteospfMatrix) -> NetrouteospfMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = net_route_ospf_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn net_route_ospf_matrix_scale(m : NetrouteospfMatrix, s : Double) -> NetrouteospfMatrix {
  let result = net_route_ospf_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn net_route_ospf_matrix_multiply(a : NetrouteospfMatrix, b : NetrouteospfMatrix) -> NetrouteospfMatrix {
  if a.cols != b.rows { return net_route_ospf_make_matrix(a.rows, b.cols, 0.0) }
  let result = net_route_ospf_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn net_route_ospf_matrix_trace(m : NetrouteospfMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn net_route_ospf_matrix_det(m : NetrouteospfMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn net_route_ospf_matrix_norm(m : NetrouteospfMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn net_route_ospf_matrix_to_string(m : NetrouteospfMatrix) -> String {
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

pub(all) struct NetrouteospfVector {
  comps : Array[Double]
  dim : Int
}

pub fn net_route_ospf_make_vector(comps : Array[Double]) -> NetrouteospfVector {
  { comps, dim: comps.length() }
}

pub fn net_route_ospf_vector_zero(dim : Int) -> NetrouteospfVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn net_route_ospf_vector_add(a : NetrouteospfVector, b : NetrouteospfVector) -> NetrouteospfVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn net_route_ospf_vector_sub(a : NetrouteospfVector, b : NetrouteospfVector) -> NetrouteospfVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn net_route_ospf_vector_scale(v : NetrouteospfVector, s : Double) -> NetrouteospfVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn net_route_ospf_vector_dot(a : NetrouteospfVector, b : NetrouteospfVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn net_route_ospf_vector_norm(v : NetrouteospfVector) -> Double { @_common.sqrt(net_route_ospf_vector_dot(v, v)) }

pub fn net_route_ospf_vector_normalize(v : NetrouteospfVector) -> NetrouteospfVector {
  let n = net_route_ospf_vector_norm(v)
  if n < 0.0000001 { v } else { net_route_ospf_vector_scale(v, 1.0 / n) }
}

pub fn net_route_ospf_vector_dist(a : NetrouteospfVector, b : NetrouteospfVector) -> Double {
  net_route_ospf_vector_norm(net_route_ospf_vector_sub(a, b))
}

pub fn net_route_ospf_vector_to_string(v : NetrouteospfVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn net_route_ospf_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn net_route_ospf_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn net_route_ospf_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn net_route_ospf_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn net_route_ospf_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn net_route_ospf_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn net_route_ospf_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn net_route_ospf_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn net_route_ospf_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn net_route_ospf_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn net_route_ospf_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn net_route_ospf_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn net_route_ospf_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn net_route_ospf_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn net_route_ospf_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn net_route_ospf_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn net_route_ospf_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn net_route_ospf_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn net_route_ospf_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn net_route_ospf_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn net_route_ospf_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn net_route_ospf_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn net_route_ospf_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn net_route_ospf_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn net_route_ospf_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn net_route_ospf_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn net_route_ospf_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn net_route_ospf_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn net_route_ospf_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct NetrouteospfFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_ospf_frame_make(size : Int) -> NetrouteospfFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_ospf_frame_len(s : NetrouteospfFrame) -> Int { s.size }

pub fn net_route_ospf_frame_get(s : NetrouteospfFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_ospf_frame_set(s : NetrouteospfFrame, i : Int, v : Double) -> NetrouteospfFrame {
  let result = net_route_ospf_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_route_ospf_frame_sum(s : NetrouteospfFrame) -> Double { @_common.sum(s.data) }

pub fn net_route_ospf_frame_mean(s : NetrouteospfFrame) -> Double { @_common.mean(s.data) }

pub fn net_route_ospf_frame_scale(s : NetrouteospfFrame, f : Double) -> NetrouteospfFrame {
  let result = net_route_ospf_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_route_ospf_frame_add(a : NetrouteospfFrame, b : NetrouteospfFrame) -> NetrouteospfFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_route_ospf_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_route_ospf_frame_copy(s : NetrouteospfFrame) -> NetrouteospfFrame {
  let result = net_route_ospf_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_route_ospf_frame_fill(s : NetrouteospfFrame, v : Double) -> NetrouteospfFrame {
  let result = net_route_ospf_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_route_ospf_frame_min(s : NetrouteospfFrame) -> Double { @_common.min(s.data) }

pub fn net_route_ospf_frame_max(s : NetrouteospfFrame) -> Double { @_common.max(s.data) }

pub fn net_route_ospf_frame_to_string(s : NetrouteospfFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetrouteospfTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_ospf_table_make(size : Int) -> NetrouteospfTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_ospf_table_len(s : NetrouteospfTable) -> Int { s.size }

pub fn net_route_ospf_table_get(s : NetrouteospfTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_ospf_table_set(s : NetrouteospfTable, i : Int, v : Double) -> NetrouteospfTable {
  let result = net_route_ospf_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_route_ospf_table_sum(s : NetrouteospfTable) -> Double { @_common.sum(s.data) }

pub fn net_route_ospf_table_mean(s : NetrouteospfTable) -> Double { @_common.mean(s.data) }

pub fn net_route_ospf_table_scale(s : NetrouteospfTable, f : Double) -> NetrouteospfTable {
  let result = net_route_ospf_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_route_ospf_table_add(a : NetrouteospfTable, b : NetrouteospfTable) -> NetrouteospfTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_route_ospf_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_route_ospf_table_copy(s : NetrouteospfTable) -> NetrouteospfTable {
  let result = net_route_ospf_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_route_ospf_table_fill(s : NetrouteospfTable, v : Double) -> NetrouteospfTable {
  let result = net_route_ospf_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_route_ospf_table_min(s : NetrouteospfTable) -> Double { @_common.min(s.data) }

pub fn net_route_ospf_table_max(s : NetrouteospfTable) -> Double { @_common.max(s.data) }

pub fn net_route_ospf_table_to_string(s : NetrouteospfTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetrouteospfGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_ospf_graphn_make(size : Int) -> NetrouteospfGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_ospf_graphn_len(s : NetrouteospfGraphN) -> Int { s.size }

pub fn net_route_ospf_graphn_get(s : NetrouteospfGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_ospf_graphn_set(s : NetrouteospfGraphN, i : Int, v : Double) -> NetrouteospfGraphN {
  let result = net_route_ospf_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_route_ospf_graphn_sum(s : NetrouteospfGraphN) -> Double { @_common.sum(s.data) }

pub fn net_route_ospf_graphn_mean(s : NetrouteospfGraphN) -> Double { @_common.mean(s.data) }

pub fn net_route_ospf_graphn_scale(s : NetrouteospfGraphN, f : Double) -> NetrouteospfGraphN {
  let result = net_route_ospf_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_route_ospf_graphn_add(a : NetrouteospfGraphN, b : NetrouteospfGraphN) -> NetrouteospfGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_route_ospf_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_route_ospf_graphn_copy(s : NetrouteospfGraphN) -> NetrouteospfGraphN {
  let result = net_route_ospf_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_route_ospf_graphn_fill(s : NetrouteospfGraphN, v : Double) -> NetrouteospfGraphN {
  let result = net_route_ospf_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_route_ospf_graphn_min(s : NetrouteospfGraphN) -> Double { @_common.min(s.data) }

pub fn net_route_ospf_graphn_max(s : NetrouteospfGraphN) -> Double { @_common.max(s.data) }

pub fn net_route_ospf_graphn_to_string(s : NetrouteospfGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetrouteospfNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_ospf_node_make(size : Int) -> NetrouteospfNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_ospf_node_len(s : NetrouteospfNode) -> Int { s.size }

pub fn net_route_ospf_node_get(s : NetrouteospfNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_ospf_node_set(s : NetrouteospfNode, i : Int, v : Double) -> NetrouteospfNode {
  let result = net_route_ospf_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_route_ospf_node_sum(s : NetrouteospfNode) -> Double { @_common.sum(s.data) }

pub fn net_route_ospf_node_mean(s : NetrouteospfNode) -> Double { @_common.mean(s.data) }

pub fn net_route_ospf_node_scale(s : NetrouteospfNode, f : Double) -> NetrouteospfNode {
  let result = net_route_ospf_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_route_ospf_node_add(a : NetrouteospfNode, b : NetrouteospfNode) -> NetrouteospfNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_route_ospf_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_route_ospf_node_copy(s : NetrouteospfNode) -> NetrouteospfNode {
  let result = net_route_ospf_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_route_ospf_node_fill(s : NetrouteospfNode, v : Double) -> NetrouteospfNode {
  let result = net_route_ospf_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_route_ospf_node_min(s : NetrouteospfNode) -> Double { @_common.min(s.data) }

pub fn net_route_ospf_node_max(s : NetrouteospfNode) -> Double { @_common.max(s.data) }

pub fn net_route_ospf_node_to_string(s : NetrouteospfNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetrouteospfEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_ospf_edge_make(size : Int) -> NetrouteospfEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_ospf_edge_len(s : NetrouteospfEdge) -> Int { s.size }

pub fn net_route_ospf_edge_get(s : NetrouteospfEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_ospf_edge_set(s : NetrouteospfEdge, i : Int, v : Double) -> NetrouteospfEdge {
  let result = net_route_ospf_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_route_ospf_edge_sum(s : NetrouteospfEdge) -> Double { @_common.sum(s.data) }

pub fn net_route_ospf_edge_mean(s : NetrouteospfEdge) -> Double { @_common.mean(s.data) }

pub fn net_route_ospf_edge_scale(s : NetrouteospfEdge, f : Double) -> NetrouteospfEdge {
  let result = net_route_ospf_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_route_ospf_edge_add(a : NetrouteospfEdge, b : NetrouteospfEdge) -> NetrouteospfEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_route_ospf_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_route_ospf_edge_copy(s : NetrouteospfEdge) -> NetrouteospfEdge {
  let result = net_route_ospf_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_route_ospf_edge_fill(s : NetrouteospfEdge, v : Double) -> NetrouteospfEdge {
  let result = net_route_ospf_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_route_ospf_edge_min(s : NetrouteospfEdge) -> Double { @_common.min(s.data) }

pub fn net_route_ospf_edge_max(s : NetrouteospfEdge) -> Double { @_common.max(s.data) }

pub fn net_route_ospf_edge_to_string(s : NetrouteospfEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetrouteospfPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_ospf_path_make(size : Int) -> NetrouteospfPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_ospf_path_len(s : NetrouteospfPath) -> Int { s.size }

pub fn net_route_ospf_path_get(s : NetrouteospfPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_ospf_path_set(s : NetrouteospfPath, i : Int, v : Double) -> NetrouteospfPath {
  let result = net_route_ospf_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_route_ospf_path_sum(s : NetrouteospfPath) -> Double { @_common.sum(s.data) }

pub fn net_route_ospf_path_mean(s : NetrouteospfPath) -> Double { @_common.mean(s.data) }

pub fn net_route_ospf_path_scale(s : NetrouteospfPath, f : Double) -> NetrouteospfPath {
  let result = net_route_ospf_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_route_ospf_path_add(a : NetrouteospfPath, b : NetrouteospfPath) -> NetrouteospfPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_route_ospf_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_route_ospf_path_copy(s : NetrouteospfPath) -> NetrouteospfPath {
  let result = net_route_ospf_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_route_ospf_path_fill(s : NetrouteospfPath, v : Double) -> NetrouteospfPath {
  let result = net_route_ospf_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_route_ospf_path_min(s : NetrouteospfPath) -> Double { @_common.min(s.data) }

pub fn net_route_ospf_path_max(s : NetrouteospfPath) -> Double { @_common.max(s.data) }

pub fn net_route_ospf_path_to_string(s : NetrouteospfPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetrouteospfCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_ospf_cluster_make(size : Int) -> NetrouteospfCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_ospf_cluster_len(s : NetrouteospfCluster) -> Int { s.size }

pub fn net_route_ospf_cluster_get(s : NetrouteospfCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_ospf_cluster_set(s : NetrouteospfCluster, i : Int, v : Double) -> NetrouteospfCluster {
  let result = net_route_ospf_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_route_ospf_cluster_sum(s : NetrouteospfCluster) -> Double { @_common.sum(s.data) }

pub fn net_route_ospf_cluster_mean(s : NetrouteospfCluster) -> Double { @_common.mean(s.data) }

pub fn net_route_ospf_cluster_scale(s : NetrouteospfCluster, f : Double) -> NetrouteospfCluster {
  let result = net_route_ospf_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_route_ospf_cluster_add(a : NetrouteospfCluster, b : NetrouteospfCluster) -> NetrouteospfCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_route_ospf_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_route_ospf_cluster_copy(s : NetrouteospfCluster) -> NetrouteospfCluster {
  let result = net_route_ospf_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_route_ospf_cluster_fill(s : NetrouteospfCluster, v : Double) -> NetrouteospfCluster {
  let result = net_route_ospf_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_route_ospf_cluster_min(s : NetrouteospfCluster) -> Double { @_common.min(s.data) }

pub fn net_route_ospf_cluster_max(s : NetrouteospfCluster) -> Double { @_common.max(s.data) }

pub fn net_route_ospf_cluster_to_string(s : NetrouteospfCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetrouteospfModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_ospf_model_make(size : Int) -> NetrouteospfModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_ospf_model_len(s : NetrouteospfModel) -> Int { s.size }

pub fn net_route_ospf_model_get(s : NetrouteospfModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_ospf_model_set(s : NetrouteospfModel, i : Int, v : Double) -> NetrouteospfModel {
  let result = net_route_ospf_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_route_ospf_model_sum(s : NetrouteospfModel) -> Double { @_common.sum(s.data) }

pub fn net_route_ospf_model_mean(s : NetrouteospfModel) -> Double { @_common.mean(s.data) }

pub fn net_route_ospf_model_scale(s : NetrouteospfModel, f : Double) -> NetrouteospfModel {
  let result = net_route_ospf_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_route_ospf_model_add(a : NetrouteospfModel, b : NetrouteospfModel) -> NetrouteospfModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_route_ospf_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_route_ospf_model_copy(s : NetrouteospfModel) -> NetrouteospfModel {
  let result = net_route_ospf_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_route_ospf_model_fill(s : NetrouteospfModel, v : Double) -> NetrouteospfModel {
  let result = net_route_ospf_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_route_ospf_model_min(s : NetrouteospfModel) -> Double { @_common.min(s.data) }

pub fn net_route_ospf_model_max(s : NetrouteospfModel) -> Double { @_common.max(s.data) }

pub fn net_route_ospf_model_to_string(s : NetrouteospfModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetrouteospfLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_ospf_layer_make(size : Int) -> NetrouteospfLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_ospf_layer_len(s : NetrouteospfLayer) -> Int { s.size }

pub fn net_route_ospf_layer_get(s : NetrouteospfLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_ospf_layer_set(s : NetrouteospfLayer, i : Int, v : Double) -> NetrouteospfLayer {
  let result = net_route_ospf_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_route_ospf_layer_sum(s : NetrouteospfLayer) -> Double { @_common.sum(s.data) }

pub fn net_route_ospf_layer_mean(s : NetrouteospfLayer) -> Double { @_common.mean(s.data) }

pub fn net_route_ospf_layer_scale(s : NetrouteospfLayer, f : Double) -> NetrouteospfLayer {
  let result = net_route_ospf_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_route_ospf_layer_add(a : NetrouteospfLayer, b : NetrouteospfLayer) -> NetrouteospfLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_route_ospf_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_route_ospf_layer_copy(s : NetrouteospfLayer) -> NetrouteospfLayer {
  let result = net_route_ospf_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_route_ospf_layer_fill(s : NetrouteospfLayer, v : Double) -> NetrouteospfLayer {
  let result = net_route_ospf_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_route_ospf_layer_min(s : NetrouteospfLayer) -> Double { @_common.min(s.data) }

pub fn net_route_ospf_layer_max(s : NetrouteospfLayer) -> Double { @_common.max(s.data) }

pub fn net_route_ospf_layer_to_string(s : NetrouteospfLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetrouteospfBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_ospf_buffer_make(size : Int) -> NetrouteospfBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_ospf_buffer_len(s : NetrouteospfBuffer) -> Int { s.size }

pub fn net_route_ospf_buffer_get(s : NetrouteospfBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_ospf_buffer_set(s : NetrouteospfBuffer, i : Int, v : Double) -> NetrouteospfBuffer {
  let result = net_route_ospf_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_route_ospf_buffer_sum(s : NetrouteospfBuffer) -> Double { @_common.sum(s.data) }

pub fn net_route_ospf_buffer_mean(s : NetrouteospfBuffer) -> Double { @_common.mean(s.data) }

pub fn net_route_ospf_buffer_scale(s : NetrouteospfBuffer, f : Double) -> NetrouteospfBuffer {
  let result = net_route_ospf_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_route_ospf_buffer_add(a : NetrouteospfBuffer, b : NetrouteospfBuffer) -> NetrouteospfBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_route_ospf_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_route_ospf_buffer_copy(s : NetrouteospfBuffer) -> NetrouteospfBuffer {
  let result = net_route_ospf_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_route_ospf_buffer_fill(s : NetrouteospfBuffer, v : Double) -> NetrouteospfBuffer {
  let result = net_route_ospf_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_route_ospf_buffer_min(s : NetrouteospfBuffer) -> Double { @_common.min(s.data) }

pub fn net_route_ospf_buffer_max(s : NetrouteospfBuffer) -> Double { @_common.max(s.data) }

pub fn net_route_ospf_buffer_to_string(s : NetrouteospfBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetrouteospfCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_ospf_cursor_make(size : Int) -> NetrouteospfCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_ospf_cursor_len(s : NetrouteospfCursor) -> Int { s.size }

pub fn net_route_ospf_cursor_get(s : NetrouteospfCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_ospf_cursor_set(s : NetrouteospfCursor, i : Int, v : Double) -> NetrouteospfCursor {
  let result = net_route_ospf_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_route_ospf_cursor_sum(s : NetrouteospfCursor) -> Double { @_common.sum(s.data) }

pub fn net_route_ospf_cursor_mean(s : NetrouteospfCursor) -> Double { @_common.mean(s.data) }

pub fn net_route_ospf_cursor_scale(s : NetrouteospfCursor, f : Double) -> NetrouteospfCursor {
  let result = net_route_ospf_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_route_ospf_cursor_add(a : NetrouteospfCursor, b : NetrouteospfCursor) -> NetrouteospfCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_route_ospf_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_route_ospf_cursor_copy(s : NetrouteospfCursor) -> NetrouteospfCursor {
  let result = net_route_ospf_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_route_ospf_cursor_fill(s : NetrouteospfCursor, v : Double) -> NetrouteospfCursor {
  let result = net_route_ospf_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_route_ospf_cursor_min(s : NetrouteospfCursor) -> Double { @_common.min(s.data) }

pub fn net_route_ospf_cursor_max(s : NetrouteospfCursor) -> Double { @_common.max(s.data) }

pub fn net_route_ospf_cursor_to_string(s : NetrouteospfCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetrouteospfView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_ospf_view_make(size : Int) -> NetrouteospfView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_ospf_view_len(s : NetrouteospfView) -> Int { s.size }

pub fn net_route_ospf_view_get(s : NetrouteospfView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_ospf_view_set(s : NetrouteospfView, i : Int, v : Double) -> NetrouteospfView {
  let result = net_route_ospf_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_route_ospf_view_sum(s : NetrouteospfView) -> Double { @_common.sum(s.data) }

pub fn net_route_ospf_view_mean(s : NetrouteospfView) -> Double { @_common.mean(s.data) }

pub fn net_route_ospf_view_scale(s : NetrouteospfView, f : Double) -> NetrouteospfView {
  let result = net_route_ospf_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_route_ospf_view_add(a : NetrouteospfView, b : NetrouteospfView) -> NetrouteospfView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_route_ospf_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_route_ospf_view_copy(s : NetrouteospfView) -> NetrouteospfView {
  let result = net_route_ospf_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_route_ospf_view_fill(s : NetrouteospfView, v : Double) -> NetrouteospfView {
  let result = net_route_ospf_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_route_ospf_view_min(s : NetrouteospfView) -> Double { @_common.min(s.data) }

pub fn net_route_ospf_view_max(s : NetrouteospfView) -> Double { @_common.max(s.data) }

pub fn net_route_ospf_view_to_string(s : NetrouteospfView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetrouteospfRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_ospf_range_make(size : Int) -> NetrouteospfRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_ospf_range_len(s : NetrouteospfRange) -> Int { s.size }

pub fn net_route_ospf_range_get(s : NetrouteospfRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_ospf_range_set(s : NetrouteospfRange, i : Int, v : Double) -> NetrouteospfRange {
  let result = net_route_ospf_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_route_ospf_range_sum(s : NetrouteospfRange) -> Double { @_common.sum(s.data) }

pub fn net_route_ospf_range_mean(s : NetrouteospfRange) -> Double { @_common.mean(s.data) }

pub fn net_route_ospf_range_scale(s : NetrouteospfRange, f : Double) -> NetrouteospfRange {
  let result = net_route_ospf_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_route_ospf_range_add(a : NetrouteospfRange, b : NetrouteospfRange) -> NetrouteospfRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_route_ospf_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_route_ospf_range_copy(s : NetrouteospfRange) -> NetrouteospfRange {
  let result = net_route_ospf_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_route_ospf_range_fill(s : NetrouteospfRange, v : Double) -> NetrouteospfRange {
  let result = net_route_ospf_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_route_ospf_range_min(s : NetrouteospfRange) -> Double { @_common.min(s.data) }

pub fn net_route_ospf_range_max(s : NetrouteospfRange) -> Double { @_common.max(s.data) }

pub fn net_route_ospf_range_to_string(s : NetrouteospfRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetrouteospfSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_ospf_slice_make(size : Int) -> NetrouteospfSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_ospf_slice_len(s : NetrouteospfSlice) -> Int { s.size }

pub fn net_route_ospf_slice_get(s : NetrouteospfSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_ospf_slice_set(s : NetrouteospfSlice, i : Int, v : Double) -> NetrouteospfSlice {
  let result = net_route_ospf_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_route_ospf_slice_sum(s : NetrouteospfSlice) -> Double { @_common.sum(s.data) }

pub fn net_route_ospf_slice_mean(s : NetrouteospfSlice) -> Double { @_common.mean(s.data) }

pub fn net_route_ospf_slice_scale(s : NetrouteospfSlice, f : Double) -> NetrouteospfSlice {
  let result = net_route_ospf_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_route_ospf_slice_add(a : NetrouteospfSlice, b : NetrouteospfSlice) -> NetrouteospfSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_route_ospf_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_route_ospf_slice_copy(s : NetrouteospfSlice) -> NetrouteospfSlice {
  let result = net_route_ospf_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_route_ospf_slice_fill(s : NetrouteospfSlice, v : Double) -> NetrouteospfSlice {
  let result = net_route_ospf_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_route_ospf_slice_min(s : NetrouteospfSlice) -> Double { @_common.min(s.data) }

pub fn net_route_ospf_slice_max(s : NetrouteospfSlice) -> Double { @_common.max(s.data) }

pub fn net_route_ospf_slice_to_string(s : NetrouteospfSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

