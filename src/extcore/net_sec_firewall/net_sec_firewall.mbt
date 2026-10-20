///===
/// extcore/net_sec_firewall

pub(all) struct NetsecfirewallPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn net_sec_firewall_make_point(x : Double, y : Double) -> NetsecfirewallPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn net_sec_firewall_make_point3(x : Double, y : Double, z : Double) -> NetsecfirewallPoint {
  { x, y, z, label: 0 }
}

pub fn net_sec_firewall_point_x(pt : NetsecfirewallPoint) -> Double { pt.x }

pub fn net_sec_firewall_point_y(pt : NetsecfirewallPoint) -> Double { pt.y }

pub fn net_sec_firewall_point_z(pt : NetsecfirewallPoint) -> Double { pt.z }

pub fn net_sec_firewall_point_label(pt : NetsecfirewallPoint) -> Int { pt.label }

pub fn net_sec_firewall_point_dist(a : NetsecfirewallPoint, b : NetsecfirewallPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn net_sec_firewall_point_add(a : NetsecfirewallPoint, b : NetsecfirewallPoint) -> NetsecfirewallPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn net_sec_firewall_point_sub(a : NetsecfirewallPoint, b : NetsecfirewallPoint) -> NetsecfirewallPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn net_sec_firewall_point_scale(pt : NetsecfirewallPoint, s : Double) -> NetsecfirewallPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn net_sec_firewall_point_dot(a : NetsecfirewallPoint, b : NetsecfirewallPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn net_sec_firewall_point_cross(a : NetsecfirewallPoint, b : NetsecfirewallPoint) -> NetsecfirewallPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn net_sec_firewall_point_norm(pt : NetsecfirewallPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn net_sec_firewall_point_normalize(pt : NetsecfirewallPoint) -> NetsecfirewallPoint {
  let n = net_sec_firewall_point_norm(pt)
  if n < 0.0000001 { pt } else { net_sec_firewall_point_scale(pt, 1.0 / n) }
}

pub fn net_sec_firewall_point_negate(pt : NetsecfirewallPoint) -> NetsecfirewallPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn net_sec_firewall_point_mid(a : NetsecfirewallPoint, b : NetsecfirewallPoint) -> NetsecfirewallPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn net_sec_firewall_point_lerp(a : NetsecfirewallPoint, b : NetsecfirewallPoint, t : Double) -> NetsecfirewallPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn net_sec_firewall_point_to_string(pt : NetsecfirewallPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct NetsecfirewallSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn net_sec_firewall_make_series(vals : Array[Double], name : String) -> NetsecfirewallSeries {
  { vals, name, meta: 0 }
}

pub fn net_sec_firewall_series_len(s : NetsecfirewallSeries) -> Int { s.vals.length() }

pub fn net_sec_firewall_series_sum(s : NetsecfirewallSeries) -> Double { @_common.sum(s.vals) }

pub fn net_sec_firewall_series_mean(s : NetsecfirewallSeries) -> Double { @_common.mean(s.vals) }

pub fn net_sec_firewall_series_min(s : NetsecfirewallSeries) -> Double { @_common.min(s.vals) }

pub fn net_sec_firewall_series_max(s : NetsecfirewallSeries) -> Double { @_common.max(s.vals) }

pub fn net_sec_firewall_series_range(s : NetsecfirewallSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn net_sec_firewall_series_var(s : NetsecfirewallSeries) -> Double { @_common.variance(s.vals) }

pub fn net_sec_firewall_series_std(s : NetsecfirewallSeries) -> Double { @_common.std(s.vals) }

pub fn net_sec_firewall_series_median(s : NetsecfirewallSeries) -> Double { @_common.median(s.vals) }

pub fn net_sec_firewall_series_scale(s : NetsecfirewallSeries, f : Double) -> NetsecfirewallSeries {
  { vals: @_common.scale_arr(s.vals, f), name: s.name, meta: s.meta }
}

pub fn net_sec_firewall_series_add(a : NetsecfirewallSeries, b : NetsecfirewallSeries) -> NetsecfirewallSeries {
  { vals: @_common.add_arr(a.vals, b.vals), name: a.name + "+" + b.name, meta: a.meta }
}

pub fn net_sec_firewall_series_sub(a : NetsecfirewallSeries, b : NetsecfirewallSeries) -> NetsecfirewallSeries {
  { vals: @_common.sub_arr(a.vals, b.vals), name: a.name + "-" + b.name, meta: a.meta }
}

pub fn net_sec_firewall_series_normalize(s : NetsecfirewallSeries) -> NetsecfirewallSeries {
  let mn = net_sec_firewall_series_min(s)
  let mx = net_sec_firewall_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn net_sec_firewall_series_cumsum(s : NetsecfirewallSeries) -> NetsecfirewallSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn net_sec_firewall_series_to_string(s : NetsecfirewallSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NetsecfirewallMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn net_sec_firewall_make_matrix(rows : Int, cols : Int, val : Double) -> NetsecfirewallMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn net_sec_firewall_matrix_identity(n : Int) -> NetsecfirewallMatrix {
  let m = net_sec_firewall_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn net_sec_firewall_matrix_get(m : NetsecfirewallMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn net_sec_firewall_matrix_transpose(m : NetsecfirewallMatrix) -> NetsecfirewallMatrix {
  let result = net_sec_firewall_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn net_sec_firewall_matrix_add(a : NetsecfirewallMatrix, b : NetsecfirewallMatrix) -> NetsecfirewallMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = net_sec_firewall_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn net_sec_firewall_matrix_scale(m : NetsecfirewallMatrix, s : Double) -> NetsecfirewallMatrix {
  let result = net_sec_firewall_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn net_sec_firewall_matrix_multiply(a : NetsecfirewallMatrix, b : NetsecfirewallMatrix) -> NetsecfirewallMatrix {
  if a.cols != b.rows { return net_sec_firewall_make_matrix(a.rows, b.cols, 0.0) }
  let result = net_sec_firewall_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn net_sec_firewall_matrix_trace(m : NetsecfirewallMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn net_sec_firewall_matrix_det(m : NetsecfirewallMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn net_sec_firewall_matrix_norm(m : NetsecfirewallMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn net_sec_firewall_matrix_to_string(m : NetsecfirewallMatrix) -> String {
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

pub(all) struct NetsecfirewallVector {
  comps : Array[Double]
  dim : Int
}

pub fn net_sec_firewall_make_vector(comps : Array[Double]) -> NetsecfirewallVector {
  { comps, dim: comps.length() }
}

pub fn net_sec_firewall_vector_zero(dim : Int) -> NetsecfirewallVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn net_sec_firewall_vector_add(a : NetsecfirewallVector, b : NetsecfirewallVector) -> NetsecfirewallVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.add_arr(a.comps, b.comps), dim: n }
}

pub fn net_sec_firewall_vector_sub(a : NetsecfirewallVector, b : NetsecfirewallVector) -> NetsecfirewallVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.sub_arr(a.comps, b.comps), dim: n }
}

pub fn net_sec_firewall_vector_scale(v : NetsecfirewallVector, s : Double) -> NetsecfirewallVector {
  { comps: @_common.scale_arr(v.comps, s), dim: v.dim }
}

pub fn net_sec_firewall_vector_dot(a : NetsecfirewallVector, b : NetsecfirewallVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn net_sec_firewall_vector_norm(v : NetsecfirewallVector) -> Double { @_common.sqrt(net_sec_firewall_vector_dot(v, v)) }

pub fn net_sec_firewall_vector_normalize(v : NetsecfirewallVector) -> NetsecfirewallVector {
  let n = net_sec_firewall_vector_norm(v)
  if n < 0.0000001 { v } else { net_sec_firewall_vector_scale(v, 1.0 / n) }
}

pub fn net_sec_firewall_vector_dist(a : NetsecfirewallVector, b : NetsecfirewallVector) -> Double {
  net_sec_firewall_vector_norm(net_sec_firewall_vector_sub(a, b))
}

pub fn net_sec_firewall_vector_to_string(v : NetsecfirewallVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn net_sec_firewall_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn net_sec_firewall_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn net_sec_firewall_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn net_sec_firewall_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn net_sec_firewall_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn net_sec_firewall_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn net_sec_firewall_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn net_sec_firewall_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn net_sec_firewall_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn net_sec_firewall_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn net_sec_firewall_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn net_sec_firewall_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn net_sec_firewall_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn net_sec_firewall_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn net_sec_firewall_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn net_sec_firewall_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn net_sec_firewall_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn net_sec_firewall_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn net_sec_firewall_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn net_sec_firewall_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn net_sec_firewall_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn net_sec_firewall_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn net_sec_firewall_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn net_sec_firewall_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn net_sec_firewall_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn net_sec_firewall_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn net_sec_firewall_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn net_sec_firewall_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn net_sec_firewall_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct NetsecfirewallFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_firewall_frame_make(size : Int) -> NetsecfirewallFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_firewall_frame_len(s : NetsecfirewallFrame) -> Int { s.size }

pub fn net_sec_firewall_frame_get(s : NetsecfirewallFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_firewall_frame_set(s : NetsecfirewallFrame, i : Int, v : Double) -> NetsecfirewallFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_sec_firewall_frame_sum(s : NetsecfirewallFrame) -> Double { @_common.sum(s.data) }

pub fn net_sec_firewall_frame_mean(s : NetsecfirewallFrame) -> Double { @_common.mean(s.data) }

pub fn net_sec_firewall_frame_scale(s : NetsecfirewallFrame, f : Double) -> NetsecfirewallFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_sec_firewall_frame_add(a : NetsecfirewallFrame, b : NetsecfirewallFrame) -> NetsecfirewallFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_sec_firewall_frame_copy(s : NetsecfirewallFrame) -> NetsecfirewallFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_sec_firewall_frame_fill(s : NetsecfirewallFrame, v : Double) -> NetsecfirewallFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_sec_firewall_frame_min(s : NetsecfirewallFrame) -> Double { @_common.min(s.data) }

pub fn net_sec_firewall_frame_max(s : NetsecfirewallFrame) -> Double { @_common.max(s.data) }

pub fn net_sec_firewall_frame_to_string(s : NetsecfirewallFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecfirewallTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_firewall_table_make(size : Int) -> NetsecfirewallTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_firewall_table_len(s : NetsecfirewallTable) -> Int { s.size }

pub fn net_sec_firewall_table_get(s : NetsecfirewallTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_firewall_table_set(s : NetsecfirewallTable, i : Int, v : Double) -> NetsecfirewallTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_sec_firewall_table_sum(s : NetsecfirewallTable) -> Double { @_common.sum(s.data) }

pub fn net_sec_firewall_table_mean(s : NetsecfirewallTable) -> Double { @_common.mean(s.data) }

pub fn net_sec_firewall_table_scale(s : NetsecfirewallTable, f : Double) -> NetsecfirewallTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_sec_firewall_table_add(a : NetsecfirewallTable, b : NetsecfirewallTable) -> NetsecfirewallTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_sec_firewall_table_copy(s : NetsecfirewallTable) -> NetsecfirewallTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_sec_firewall_table_fill(s : NetsecfirewallTable, v : Double) -> NetsecfirewallTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_sec_firewall_table_min(s : NetsecfirewallTable) -> Double { @_common.min(s.data) }

pub fn net_sec_firewall_table_max(s : NetsecfirewallTable) -> Double { @_common.max(s.data) }

pub fn net_sec_firewall_table_to_string(s : NetsecfirewallTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecfirewallGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_firewall_graphn_make(size : Int) -> NetsecfirewallGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_firewall_graphn_len(s : NetsecfirewallGraphN) -> Int { s.size }

pub fn net_sec_firewall_graphn_get(s : NetsecfirewallGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_firewall_graphn_set(s : NetsecfirewallGraphN, i : Int, v : Double) -> NetsecfirewallGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_sec_firewall_graphn_sum(s : NetsecfirewallGraphN) -> Double { @_common.sum(s.data) }

pub fn net_sec_firewall_graphn_mean(s : NetsecfirewallGraphN) -> Double { @_common.mean(s.data) }

pub fn net_sec_firewall_graphn_scale(s : NetsecfirewallGraphN, f : Double) -> NetsecfirewallGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_sec_firewall_graphn_add(a : NetsecfirewallGraphN, b : NetsecfirewallGraphN) -> NetsecfirewallGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_sec_firewall_graphn_copy(s : NetsecfirewallGraphN) -> NetsecfirewallGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_sec_firewall_graphn_fill(s : NetsecfirewallGraphN, v : Double) -> NetsecfirewallGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_sec_firewall_graphn_min(s : NetsecfirewallGraphN) -> Double { @_common.min(s.data) }

pub fn net_sec_firewall_graphn_max(s : NetsecfirewallGraphN) -> Double { @_common.max(s.data) }

pub fn net_sec_firewall_graphn_to_string(s : NetsecfirewallGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecfirewallNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_firewall_node_make(size : Int) -> NetsecfirewallNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_firewall_node_len(s : NetsecfirewallNode) -> Int { s.size }

pub fn net_sec_firewall_node_get(s : NetsecfirewallNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_firewall_node_set(s : NetsecfirewallNode, i : Int, v : Double) -> NetsecfirewallNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_sec_firewall_node_sum(s : NetsecfirewallNode) -> Double { @_common.sum(s.data) }

pub fn net_sec_firewall_node_mean(s : NetsecfirewallNode) -> Double { @_common.mean(s.data) }

pub fn net_sec_firewall_node_scale(s : NetsecfirewallNode, f : Double) -> NetsecfirewallNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_sec_firewall_node_add(a : NetsecfirewallNode, b : NetsecfirewallNode) -> NetsecfirewallNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_sec_firewall_node_copy(s : NetsecfirewallNode) -> NetsecfirewallNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_sec_firewall_node_fill(s : NetsecfirewallNode, v : Double) -> NetsecfirewallNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_sec_firewall_node_min(s : NetsecfirewallNode) -> Double { @_common.min(s.data) }

pub fn net_sec_firewall_node_max(s : NetsecfirewallNode) -> Double { @_common.max(s.data) }

pub fn net_sec_firewall_node_to_string(s : NetsecfirewallNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecfirewallEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_firewall_edge_make(size : Int) -> NetsecfirewallEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_firewall_edge_len(s : NetsecfirewallEdge) -> Int { s.size }

pub fn net_sec_firewall_edge_get(s : NetsecfirewallEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_firewall_edge_set(s : NetsecfirewallEdge, i : Int, v : Double) -> NetsecfirewallEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_sec_firewall_edge_sum(s : NetsecfirewallEdge) -> Double { @_common.sum(s.data) }

pub fn net_sec_firewall_edge_mean(s : NetsecfirewallEdge) -> Double { @_common.mean(s.data) }

pub fn net_sec_firewall_edge_scale(s : NetsecfirewallEdge, f : Double) -> NetsecfirewallEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_sec_firewall_edge_add(a : NetsecfirewallEdge, b : NetsecfirewallEdge) -> NetsecfirewallEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_sec_firewall_edge_copy(s : NetsecfirewallEdge) -> NetsecfirewallEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_sec_firewall_edge_fill(s : NetsecfirewallEdge, v : Double) -> NetsecfirewallEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_sec_firewall_edge_min(s : NetsecfirewallEdge) -> Double { @_common.min(s.data) }

pub fn net_sec_firewall_edge_max(s : NetsecfirewallEdge) -> Double { @_common.max(s.data) }

pub fn net_sec_firewall_edge_to_string(s : NetsecfirewallEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecfirewallPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_firewall_path_make(size : Int) -> NetsecfirewallPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_firewall_path_len(s : NetsecfirewallPath) -> Int { s.size }

pub fn net_sec_firewall_path_get(s : NetsecfirewallPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_firewall_path_set(s : NetsecfirewallPath, i : Int, v : Double) -> NetsecfirewallPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_sec_firewall_path_sum(s : NetsecfirewallPath) -> Double { @_common.sum(s.data) }

pub fn net_sec_firewall_path_mean(s : NetsecfirewallPath) -> Double { @_common.mean(s.data) }

pub fn net_sec_firewall_path_scale(s : NetsecfirewallPath, f : Double) -> NetsecfirewallPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_sec_firewall_path_add(a : NetsecfirewallPath, b : NetsecfirewallPath) -> NetsecfirewallPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_sec_firewall_path_copy(s : NetsecfirewallPath) -> NetsecfirewallPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_sec_firewall_path_fill(s : NetsecfirewallPath, v : Double) -> NetsecfirewallPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_sec_firewall_path_min(s : NetsecfirewallPath) -> Double { @_common.min(s.data) }

pub fn net_sec_firewall_path_max(s : NetsecfirewallPath) -> Double { @_common.max(s.data) }

pub fn net_sec_firewall_path_to_string(s : NetsecfirewallPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecfirewallCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_firewall_cluster_make(size : Int) -> NetsecfirewallCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_firewall_cluster_len(s : NetsecfirewallCluster) -> Int { s.size }

pub fn net_sec_firewall_cluster_get(s : NetsecfirewallCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_firewall_cluster_set(s : NetsecfirewallCluster, i : Int, v : Double) -> NetsecfirewallCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_sec_firewall_cluster_sum(s : NetsecfirewallCluster) -> Double { @_common.sum(s.data) }

pub fn net_sec_firewall_cluster_mean(s : NetsecfirewallCluster) -> Double { @_common.mean(s.data) }

pub fn net_sec_firewall_cluster_scale(s : NetsecfirewallCluster, f : Double) -> NetsecfirewallCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_sec_firewall_cluster_add(a : NetsecfirewallCluster, b : NetsecfirewallCluster) -> NetsecfirewallCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_sec_firewall_cluster_copy(s : NetsecfirewallCluster) -> NetsecfirewallCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_sec_firewall_cluster_fill(s : NetsecfirewallCluster, v : Double) -> NetsecfirewallCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_sec_firewall_cluster_min(s : NetsecfirewallCluster) -> Double { @_common.min(s.data) }

pub fn net_sec_firewall_cluster_max(s : NetsecfirewallCluster) -> Double { @_common.max(s.data) }

pub fn net_sec_firewall_cluster_to_string(s : NetsecfirewallCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecfirewallModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_firewall_model_make(size : Int) -> NetsecfirewallModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_firewall_model_len(s : NetsecfirewallModel) -> Int { s.size }

pub fn net_sec_firewall_model_get(s : NetsecfirewallModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_firewall_model_set(s : NetsecfirewallModel, i : Int, v : Double) -> NetsecfirewallModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_sec_firewall_model_sum(s : NetsecfirewallModel) -> Double { @_common.sum(s.data) }

pub fn net_sec_firewall_model_mean(s : NetsecfirewallModel) -> Double { @_common.mean(s.data) }

pub fn net_sec_firewall_model_scale(s : NetsecfirewallModel, f : Double) -> NetsecfirewallModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_sec_firewall_model_add(a : NetsecfirewallModel, b : NetsecfirewallModel) -> NetsecfirewallModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_sec_firewall_model_copy(s : NetsecfirewallModel) -> NetsecfirewallModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_sec_firewall_model_fill(s : NetsecfirewallModel, v : Double) -> NetsecfirewallModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_sec_firewall_model_min(s : NetsecfirewallModel) -> Double { @_common.min(s.data) }

pub fn net_sec_firewall_model_max(s : NetsecfirewallModel) -> Double { @_common.max(s.data) }

pub fn net_sec_firewall_model_to_string(s : NetsecfirewallModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecfirewallLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_firewall_layer_make(size : Int) -> NetsecfirewallLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_firewall_layer_len(s : NetsecfirewallLayer) -> Int { s.size }

pub fn net_sec_firewall_layer_get(s : NetsecfirewallLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_firewall_layer_set(s : NetsecfirewallLayer, i : Int, v : Double) -> NetsecfirewallLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_sec_firewall_layer_sum(s : NetsecfirewallLayer) -> Double { @_common.sum(s.data) }

pub fn net_sec_firewall_layer_mean(s : NetsecfirewallLayer) -> Double { @_common.mean(s.data) }

pub fn net_sec_firewall_layer_scale(s : NetsecfirewallLayer, f : Double) -> NetsecfirewallLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_sec_firewall_layer_add(a : NetsecfirewallLayer, b : NetsecfirewallLayer) -> NetsecfirewallLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_sec_firewall_layer_copy(s : NetsecfirewallLayer) -> NetsecfirewallLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_sec_firewall_layer_fill(s : NetsecfirewallLayer, v : Double) -> NetsecfirewallLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_sec_firewall_layer_min(s : NetsecfirewallLayer) -> Double { @_common.min(s.data) }

pub fn net_sec_firewall_layer_max(s : NetsecfirewallLayer) -> Double { @_common.max(s.data) }

pub fn net_sec_firewall_layer_to_string(s : NetsecfirewallLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecfirewallBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_firewall_buffer_make(size : Int) -> NetsecfirewallBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_firewall_buffer_len(s : NetsecfirewallBuffer) -> Int { s.size }

pub fn net_sec_firewall_buffer_get(s : NetsecfirewallBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_firewall_buffer_set(s : NetsecfirewallBuffer, i : Int, v : Double) -> NetsecfirewallBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_sec_firewall_buffer_sum(s : NetsecfirewallBuffer) -> Double { @_common.sum(s.data) }

pub fn net_sec_firewall_buffer_mean(s : NetsecfirewallBuffer) -> Double { @_common.mean(s.data) }

pub fn net_sec_firewall_buffer_scale(s : NetsecfirewallBuffer, f : Double) -> NetsecfirewallBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_sec_firewall_buffer_add(a : NetsecfirewallBuffer, b : NetsecfirewallBuffer) -> NetsecfirewallBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_sec_firewall_buffer_copy(s : NetsecfirewallBuffer) -> NetsecfirewallBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_sec_firewall_buffer_fill(s : NetsecfirewallBuffer, v : Double) -> NetsecfirewallBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_sec_firewall_buffer_min(s : NetsecfirewallBuffer) -> Double { @_common.min(s.data) }

pub fn net_sec_firewall_buffer_max(s : NetsecfirewallBuffer) -> Double { @_common.max(s.data) }

pub fn net_sec_firewall_buffer_to_string(s : NetsecfirewallBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecfirewallCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_firewall_cursor_make(size : Int) -> NetsecfirewallCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_firewall_cursor_len(s : NetsecfirewallCursor) -> Int { s.size }

pub fn net_sec_firewall_cursor_get(s : NetsecfirewallCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_firewall_cursor_set(s : NetsecfirewallCursor, i : Int, v : Double) -> NetsecfirewallCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_sec_firewall_cursor_sum(s : NetsecfirewallCursor) -> Double { @_common.sum(s.data) }

pub fn net_sec_firewall_cursor_mean(s : NetsecfirewallCursor) -> Double { @_common.mean(s.data) }

pub fn net_sec_firewall_cursor_scale(s : NetsecfirewallCursor, f : Double) -> NetsecfirewallCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_sec_firewall_cursor_add(a : NetsecfirewallCursor, b : NetsecfirewallCursor) -> NetsecfirewallCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_sec_firewall_cursor_copy(s : NetsecfirewallCursor) -> NetsecfirewallCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_sec_firewall_cursor_fill(s : NetsecfirewallCursor, v : Double) -> NetsecfirewallCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_sec_firewall_cursor_min(s : NetsecfirewallCursor) -> Double { @_common.min(s.data) }

pub fn net_sec_firewall_cursor_max(s : NetsecfirewallCursor) -> Double { @_common.max(s.data) }

pub fn net_sec_firewall_cursor_to_string(s : NetsecfirewallCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecfirewallView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_firewall_view_make(size : Int) -> NetsecfirewallView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_firewall_view_len(s : NetsecfirewallView) -> Int { s.size }

pub fn net_sec_firewall_view_get(s : NetsecfirewallView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_firewall_view_set(s : NetsecfirewallView, i : Int, v : Double) -> NetsecfirewallView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_sec_firewall_view_sum(s : NetsecfirewallView) -> Double { @_common.sum(s.data) }

pub fn net_sec_firewall_view_mean(s : NetsecfirewallView) -> Double { @_common.mean(s.data) }

pub fn net_sec_firewall_view_scale(s : NetsecfirewallView, f : Double) -> NetsecfirewallView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_sec_firewall_view_add(a : NetsecfirewallView, b : NetsecfirewallView) -> NetsecfirewallView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_sec_firewall_view_copy(s : NetsecfirewallView) -> NetsecfirewallView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_sec_firewall_view_fill(s : NetsecfirewallView, v : Double) -> NetsecfirewallView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_sec_firewall_view_min(s : NetsecfirewallView) -> Double { @_common.min(s.data) }

pub fn net_sec_firewall_view_max(s : NetsecfirewallView) -> Double { @_common.max(s.data) }

pub fn net_sec_firewall_view_to_string(s : NetsecfirewallView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecfirewallRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_firewall_range_make(size : Int) -> NetsecfirewallRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_firewall_range_len(s : NetsecfirewallRange) -> Int { s.size }

pub fn net_sec_firewall_range_get(s : NetsecfirewallRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_firewall_range_set(s : NetsecfirewallRange, i : Int, v : Double) -> NetsecfirewallRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_sec_firewall_range_sum(s : NetsecfirewallRange) -> Double { @_common.sum(s.data) }

pub fn net_sec_firewall_range_mean(s : NetsecfirewallRange) -> Double { @_common.mean(s.data) }

pub fn net_sec_firewall_range_scale(s : NetsecfirewallRange, f : Double) -> NetsecfirewallRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_sec_firewall_range_add(a : NetsecfirewallRange, b : NetsecfirewallRange) -> NetsecfirewallRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_sec_firewall_range_copy(s : NetsecfirewallRange) -> NetsecfirewallRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_sec_firewall_range_fill(s : NetsecfirewallRange, v : Double) -> NetsecfirewallRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_sec_firewall_range_min(s : NetsecfirewallRange) -> Double { @_common.min(s.data) }

pub fn net_sec_firewall_range_max(s : NetsecfirewallRange) -> Double { @_common.max(s.data) }

pub fn net_sec_firewall_range_to_string(s : NetsecfirewallRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecfirewallSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_firewall_slice_make(size : Int) -> NetsecfirewallSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_firewall_slice_len(s : NetsecfirewallSlice) -> Int { s.size }

pub fn net_sec_firewall_slice_get(s : NetsecfirewallSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_firewall_slice_set(s : NetsecfirewallSlice, i : Int, v : Double) -> NetsecfirewallSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_sec_firewall_slice_sum(s : NetsecfirewallSlice) -> Double { @_common.sum(s.data) }

pub fn net_sec_firewall_slice_mean(s : NetsecfirewallSlice) -> Double { @_common.mean(s.data) }

pub fn net_sec_firewall_slice_scale(s : NetsecfirewallSlice, f : Double) -> NetsecfirewallSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_sec_firewall_slice_add(a : NetsecfirewallSlice, b : NetsecfirewallSlice) -> NetsecfirewallSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_sec_firewall_slice_copy(s : NetsecfirewallSlice) -> NetsecfirewallSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_sec_firewall_slice_fill(s : NetsecfirewallSlice, v : Double) -> NetsecfirewallSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_sec_firewall_slice_min(s : NetsecfirewallSlice) -> Double { @_common.min(s.data) }

pub fn net_sec_firewall_slice_max(s : NetsecfirewallSlice) -> Double { @_common.max(s.data) }

pub fn net_sec_firewall_slice_to_string(s : NetsecfirewallSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

