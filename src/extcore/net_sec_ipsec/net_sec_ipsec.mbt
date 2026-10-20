///===
/// extcore/net_sec_ipsec

pub(all) struct NetsecipsecPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn net_sec_ipsec_make_point(x : Double, y : Double) -> NetsecipsecPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn net_sec_ipsec_make_point3(x : Double, y : Double, z : Double) -> NetsecipsecPoint {
  { x, y, z, label: 0 }
}

pub fn net_sec_ipsec_point_x(pt : NetsecipsecPoint) -> Double { pt.x }

pub fn net_sec_ipsec_point_y(pt : NetsecipsecPoint) -> Double { pt.y }

pub fn net_sec_ipsec_point_z(pt : NetsecipsecPoint) -> Double { pt.z }

pub fn net_sec_ipsec_point_label(pt : NetsecipsecPoint) -> Int { pt.label }

pub fn net_sec_ipsec_point_dist(a : NetsecipsecPoint, b : NetsecipsecPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn net_sec_ipsec_point_add(a : NetsecipsecPoint, b : NetsecipsecPoint) -> NetsecipsecPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn net_sec_ipsec_point_sub(a : NetsecipsecPoint, b : NetsecipsecPoint) -> NetsecipsecPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn net_sec_ipsec_point_scale(pt : NetsecipsecPoint, s : Double) -> NetsecipsecPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn net_sec_ipsec_point_dot(a : NetsecipsecPoint, b : NetsecipsecPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn net_sec_ipsec_point_cross(a : NetsecipsecPoint, b : NetsecipsecPoint) -> NetsecipsecPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn net_sec_ipsec_point_norm(pt : NetsecipsecPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn net_sec_ipsec_point_normalize(pt : NetsecipsecPoint) -> NetsecipsecPoint {
  let n = net_sec_ipsec_point_norm(pt)
  if n < 0.0000001 { pt } else { net_sec_ipsec_point_scale(pt, 1.0 / n) }
}

pub fn net_sec_ipsec_point_negate(pt : NetsecipsecPoint) -> NetsecipsecPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn net_sec_ipsec_point_mid(a : NetsecipsecPoint, b : NetsecipsecPoint) -> NetsecipsecPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn net_sec_ipsec_point_lerp(a : NetsecipsecPoint, b : NetsecipsecPoint, t : Double) -> NetsecipsecPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn net_sec_ipsec_point_to_string(pt : NetsecipsecPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct NetsecipsecSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn net_sec_ipsec_make_series(vals : Array[Double], name : String) -> NetsecipsecSeries {
  { vals, name, meta: 0 }
}

pub fn net_sec_ipsec_series_len(s : NetsecipsecSeries) -> Int { s.vals.length() }

pub fn net_sec_ipsec_series_sum(s : NetsecipsecSeries) -> Double { @_common.sum(s.vals) }

pub fn net_sec_ipsec_series_mean(s : NetsecipsecSeries) -> Double { @_common.mean(s.vals) }

pub fn net_sec_ipsec_series_min(s : NetsecipsecSeries) -> Double { @_common.min(s.vals) }

pub fn net_sec_ipsec_series_max(s : NetsecipsecSeries) -> Double { @_common.max(s.vals) }

pub fn net_sec_ipsec_series_range(s : NetsecipsecSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn net_sec_ipsec_series_var(s : NetsecipsecSeries) -> Double { @_common.variance(s.vals) }

pub fn net_sec_ipsec_series_std(s : NetsecipsecSeries) -> Double { @_common.std(s.vals) }

pub fn net_sec_ipsec_series_median(s : NetsecipsecSeries) -> Double { @_common.median(s.vals) }

pub fn net_sec_ipsec_series_scale(s : NetsecipsecSeries, f : Double) -> NetsecipsecSeries {
  { vals: @_common.scale_arr(s.vals, f), name: s.name, meta: s.meta }
}

pub fn net_sec_ipsec_series_add(a : NetsecipsecSeries, b : NetsecipsecSeries) -> NetsecipsecSeries {
  { vals: @_common.add_arr(a.vals, b.vals), name: a.name + "+" + b.name, meta: a.meta }
}

pub fn net_sec_ipsec_series_sub(a : NetsecipsecSeries, b : NetsecipsecSeries) -> NetsecipsecSeries {
  { vals: @_common.sub_arr(a.vals, b.vals), name: a.name + "-" + b.name, meta: a.meta }
}

pub fn net_sec_ipsec_series_normalize(s : NetsecipsecSeries) -> NetsecipsecSeries {
  let mn = net_sec_ipsec_series_min(s)
  let mx = net_sec_ipsec_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn net_sec_ipsec_series_cumsum(s : NetsecipsecSeries) -> NetsecipsecSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn net_sec_ipsec_series_to_string(s : NetsecipsecSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NetsecipsecMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn net_sec_ipsec_make_matrix(rows : Int, cols : Int, val : Double) -> NetsecipsecMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn net_sec_ipsec_matrix_identity(n : Int) -> NetsecipsecMatrix {
  let m = net_sec_ipsec_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn net_sec_ipsec_matrix_get(m : NetsecipsecMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn net_sec_ipsec_matrix_transpose(m : NetsecipsecMatrix) -> NetsecipsecMatrix {
  let result = net_sec_ipsec_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn net_sec_ipsec_matrix_add(a : NetsecipsecMatrix, b : NetsecipsecMatrix) -> NetsecipsecMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = net_sec_ipsec_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn net_sec_ipsec_matrix_scale(m : NetsecipsecMatrix, s : Double) -> NetsecipsecMatrix {
  let result = net_sec_ipsec_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn net_sec_ipsec_matrix_multiply(a : NetsecipsecMatrix, b : NetsecipsecMatrix) -> NetsecipsecMatrix {
  if a.cols != b.rows { return net_sec_ipsec_make_matrix(a.rows, b.cols, 0.0) }
  let result = net_sec_ipsec_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn net_sec_ipsec_matrix_trace(m : NetsecipsecMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn net_sec_ipsec_matrix_det(m : NetsecipsecMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn net_sec_ipsec_matrix_norm(m : NetsecipsecMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn net_sec_ipsec_matrix_to_string(m : NetsecipsecMatrix) -> String {
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

pub(all) struct NetsecipsecVector {
  comps : Array[Double]
  dim : Int
}

pub fn net_sec_ipsec_make_vector(comps : Array[Double]) -> NetsecipsecVector {
  { comps, dim: comps.length() }
}

pub fn net_sec_ipsec_vector_zero(dim : Int) -> NetsecipsecVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn net_sec_ipsec_vector_add(a : NetsecipsecVector, b : NetsecipsecVector) -> NetsecipsecVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.add_arr(a.comps, b.comps), dim: n }
}

pub fn net_sec_ipsec_vector_sub(a : NetsecipsecVector, b : NetsecipsecVector) -> NetsecipsecVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.sub_arr(a.comps, b.comps), dim: n }
}

pub fn net_sec_ipsec_vector_scale(v : NetsecipsecVector, s : Double) -> NetsecipsecVector {
  { comps: @_common.scale_arr(v.comps, s), dim: v.dim }
}

pub fn net_sec_ipsec_vector_dot(a : NetsecipsecVector, b : NetsecipsecVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn net_sec_ipsec_vector_norm(v : NetsecipsecVector) -> Double { @_common.sqrt(net_sec_ipsec_vector_dot(v, v)) }

pub fn net_sec_ipsec_vector_normalize(v : NetsecipsecVector) -> NetsecipsecVector {
  let n = net_sec_ipsec_vector_norm(v)
  if n < 0.0000001 { v } else { net_sec_ipsec_vector_scale(v, 1.0 / n) }
}

pub fn net_sec_ipsec_vector_dist(a : NetsecipsecVector, b : NetsecipsecVector) -> Double {
  net_sec_ipsec_vector_norm(net_sec_ipsec_vector_sub(a, b))
}

pub fn net_sec_ipsec_vector_to_string(v : NetsecipsecVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn net_sec_ipsec_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn net_sec_ipsec_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn net_sec_ipsec_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn net_sec_ipsec_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn net_sec_ipsec_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn net_sec_ipsec_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn net_sec_ipsec_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn net_sec_ipsec_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn net_sec_ipsec_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn net_sec_ipsec_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn net_sec_ipsec_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn net_sec_ipsec_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn net_sec_ipsec_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn net_sec_ipsec_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn net_sec_ipsec_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn net_sec_ipsec_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn net_sec_ipsec_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn net_sec_ipsec_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn net_sec_ipsec_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn net_sec_ipsec_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn net_sec_ipsec_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn net_sec_ipsec_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn net_sec_ipsec_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn net_sec_ipsec_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn net_sec_ipsec_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn net_sec_ipsec_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn net_sec_ipsec_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn net_sec_ipsec_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn net_sec_ipsec_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct NetsecipsecFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_ipsec_frame_make(size : Int) -> NetsecipsecFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_ipsec_frame_len(s : NetsecipsecFrame) -> Int { s.size }

pub fn net_sec_ipsec_frame_get(s : NetsecipsecFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_ipsec_frame_set(s : NetsecipsecFrame, i : Int, v : Double) -> NetsecipsecFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_sec_ipsec_frame_sum(s : NetsecipsecFrame) -> Double { @_common.sum(s.data) }

pub fn net_sec_ipsec_frame_mean(s : NetsecipsecFrame) -> Double { @_common.mean(s.data) }

pub fn net_sec_ipsec_frame_scale(s : NetsecipsecFrame, f : Double) -> NetsecipsecFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_sec_ipsec_frame_add(a : NetsecipsecFrame, b : NetsecipsecFrame) -> NetsecipsecFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_sec_ipsec_frame_copy(s : NetsecipsecFrame) -> NetsecipsecFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_sec_ipsec_frame_fill(s : NetsecipsecFrame, v : Double) -> NetsecipsecFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_sec_ipsec_frame_min(s : NetsecipsecFrame) -> Double { @_common.min(s.data) }

pub fn net_sec_ipsec_frame_max(s : NetsecipsecFrame) -> Double { @_common.max(s.data) }

pub fn net_sec_ipsec_frame_to_string(s : NetsecipsecFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecipsecTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_ipsec_table_make(size : Int) -> NetsecipsecTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_ipsec_table_len(s : NetsecipsecTable) -> Int { s.size }

pub fn net_sec_ipsec_table_get(s : NetsecipsecTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_ipsec_table_set(s : NetsecipsecTable, i : Int, v : Double) -> NetsecipsecTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_sec_ipsec_table_sum(s : NetsecipsecTable) -> Double { @_common.sum(s.data) }

pub fn net_sec_ipsec_table_mean(s : NetsecipsecTable) -> Double { @_common.mean(s.data) }

pub fn net_sec_ipsec_table_scale(s : NetsecipsecTable, f : Double) -> NetsecipsecTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_sec_ipsec_table_add(a : NetsecipsecTable, b : NetsecipsecTable) -> NetsecipsecTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_sec_ipsec_table_copy(s : NetsecipsecTable) -> NetsecipsecTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_sec_ipsec_table_fill(s : NetsecipsecTable, v : Double) -> NetsecipsecTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_sec_ipsec_table_min(s : NetsecipsecTable) -> Double { @_common.min(s.data) }

pub fn net_sec_ipsec_table_max(s : NetsecipsecTable) -> Double { @_common.max(s.data) }

pub fn net_sec_ipsec_table_to_string(s : NetsecipsecTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecipsecGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_ipsec_graphn_make(size : Int) -> NetsecipsecGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_ipsec_graphn_len(s : NetsecipsecGraphN) -> Int { s.size }

pub fn net_sec_ipsec_graphn_get(s : NetsecipsecGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_ipsec_graphn_set(s : NetsecipsecGraphN, i : Int, v : Double) -> NetsecipsecGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_sec_ipsec_graphn_sum(s : NetsecipsecGraphN) -> Double { @_common.sum(s.data) }

pub fn net_sec_ipsec_graphn_mean(s : NetsecipsecGraphN) -> Double { @_common.mean(s.data) }

pub fn net_sec_ipsec_graphn_scale(s : NetsecipsecGraphN, f : Double) -> NetsecipsecGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_sec_ipsec_graphn_add(a : NetsecipsecGraphN, b : NetsecipsecGraphN) -> NetsecipsecGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_sec_ipsec_graphn_copy(s : NetsecipsecGraphN) -> NetsecipsecGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_sec_ipsec_graphn_fill(s : NetsecipsecGraphN, v : Double) -> NetsecipsecGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_sec_ipsec_graphn_min(s : NetsecipsecGraphN) -> Double { @_common.min(s.data) }

pub fn net_sec_ipsec_graphn_max(s : NetsecipsecGraphN) -> Double { @_common.max(s.data) }

pub fn net_sec_ipsec_graphn_to_string(s : NetsecipsecGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecipsecNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_ipsec_node_make(size : Int) -> NetsecipsecNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_ipsec_node_len(s : NetsecipsecNode) -> Int { s.size }

pub fn net_sec_ipsec_node_get(s : NetsecipsecNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_ipsec_node_set(s : NetsecipsecNode, i : Int, v : Double) -> NetsecipsecNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_sec_ipsec_node_sum(s : NetsecipsecNode) -> Double { @_common.sum(s.data) }

pub fn net_sec_ipsec_node_mean(s : NetsecipsecNode) -> Double { @_common.mean(s.data) }

pub fn net_sec_ipsec_node_scale(s : NetsecipsecNode, f : Double) -> NetsecipsecNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_sec_ipsec_node_add(a : NetsecipsecNode, b : NetsecipsecNode) -> NetsecipsecNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_sec_ipsec_node_copy(s : NetsecipsecNode) -> NetsecipsecNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_sec_ipsec_node_fill(s : NetsecipsecNode, v : Double) -> NetsecipsecNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_sec_ipsec_node_min(s : NetsecipsecNode) -> Double { @_common.min(s.data) }

pub fn net_sec_ipsec_node_max(s : NetsecipsecNode) -> Double { @_common.max(s.data) }

pub fn net_sec_ipsec_node_to_string(s : NetsecipsecNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecipsecEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_ipsec_edge_make(size : Int) -> NetsecipsecEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_ipsec_edge_len(s : NetsecipsecEdge) -> Int { s.size }

pub fn net_sec_ipsec_edge_get(s : NetsecipsecEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_ipsec_edge_set(s : NetsecipsecEdge, i : Int, v : Double) -> NetsecipsecEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_sec_ipsec_edge_sum(s : NetsecipsecEdge) -> Double { @_common.sum(s.data) }

pub fn net_sec_ipsec_edge_mean(s : NetsecipsecEdge) -> Double { @_common.mean(s.data) }

pub fn net_sec_ipsec_edge_scale(s : NetsecipsecEdge, f : Double) -> NetsecipsecEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_sec_ipsec_edge_add(a : NetsecipsecEdge, b : NetsecipsecEdge) -> NetsecipsecEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_sec_ipsec_edge_copy(s : NetsecipsecEdge) -> NetsecipsecEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_sec_ipsec_edge_fill(s : NetsecipsecEdge, v : Double) -> NetsecipsecEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_sec_ipsec_edge_min(s : NetsecipsecEdge) -> Double { @_common.min(s.data) }

pub fn net_sec_ipsec_edge_max(s : NetsecipsecEdge) -> Double { @_common.max(s.data) }

pub fn net_sec_ipsec_edge_to_string(s : NetsecipsecEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecipsecPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_ipsec_path_make(size : Int) -> NetsecipsecPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_ipsec_path_len(s : NetsecipsecPath) -> Int { s.size }

pub fn net_sec_ipsec_path_get(s : NetsecipsecPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_ipsec_path_set(s : NetsecipsecPath, i : Int, v : Double) -> NetsecipsecPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_sec_ipsec_path_sum(s : NetsecipsecPath) -> Double { @_common.sum(s.data) }

pub fn net_sec_ipsec_path_mean(s : NetsecipsecPath) -> Double { @_common.mean(s.data) }

pub fn net_sec_ipsec_path_scale(s : NetsecipsecPath, f : Double) -> NetsecipsecPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_sec_ipsec_path_add(a : NetsecipsecPath, b : NetsecipsecPath) -> NetsecipsecPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_sec_ipsec_path_copy(s : NetsecipsecPath) -> NetsecipsecPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_sec_ipsec_path_fill(s : NetsecipsecPath, v : Double) -> NetsecipsecPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_sec_ipsec_path_min(s : NetsecipsecPath) -> Double { @_common.min(s.data) }

pub fn net_sec_ipsec_path_max(s : NetsecipsecPath) -> Double { @_common.max(s.data) }

pub fn net_sec_ipsec_path_to_string(s : NetsecipsecPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecipsecCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_ipsec_cluster_make(size : Int) -> NetsecipsecCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_ipsec_cluster_len(s : NetsecipsecCluster) -> Int { s.size }

pub fn net_sec_ipsec_cluster_get(s : NetsecipsecCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_ipsec_cluster_set(s : NetsecipsecCluster, i : Int, v : Double) -> NetsecipsecCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_sec_ipsec_cluster_sum(s : NetsecipsecCluster) -> Double { @_common.sum(s.data) }

pub fn net_sec_ipsec_cluster_mean(s : NetsecipsecCluster) -> Double { @_common.mean(s.data) }

pub fn net_sec_ipsec_cluster_scale(s : NetsecipsecCluster, f : Double) -> NetsecipsecCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_sec_ipsec_cluster_add(a : NetsecipsecCluster, b : NetsecipsecCluster) -> NetsecipsecCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_sec_ipsec_cluster_copy(s : NetsecipsecCluster) -> NetsecipsecCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_sec_ipsec_cluster_fill(s : NetsecipsecCluster, v : Double) -> NetsecipsecCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_sec_ipsec_cluster_min(s : NetsecipsecCluster) -> Double { @_common.min(s.data) }

pub fn net_sec_ipsec_cluster_max(s : NetsecipsecCluster) -> Double { @_common.max(s.data) }

pub fn net_sec_ipsec_cluster_to_string(s : NetsecipsecCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecipsecModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_ipsec_model_make(size : Int) -> NetsecipsecModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_ipsec_model_len(s : NetsecipsecModel) -> Int { s.size }

pub fn net_sec_ipsec_model_get(s : NetsecipsecModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_ipsec_model_set(s : NetsecipsecModel, i : Int, v : Double) -> NetsecipsecModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_sec_ipsec_model_sum(s : NetsecipsecModel) -> Double { @_common.sum(s.data) }

pub fn net_sec_ipsec_model_mean(s : NetsecipsecModel) -> Double { @_common.mean(s.data) }

pub fn net_sec_ipsec_model_scale(s : NetsecipsecModel, f : Double) -> NetsecipsecModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_sec_ipsec_model_add(a : NetsecipsecModel, b : NetsecipsecModel) -> NetsecipsecModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_sec_ipsec_model_copy(s : NetsecipsecModel) -> NetsecipsecModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_sec_ipsec_model_fill(s : NetsecipsecModel, v : Double) -> NetsecipsecModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_sec_ipsec_model_min(s : NetsecipsecModel) -> Double { @_common.min(s.data) }

pub fn net_sec_ipsec_model_max(s : NetsecipsecModel) -> Double { @_common.max(s.data) }

pub fn net_sec_ipsec_model_to_string(s : NetsecipsecModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecipsecLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_ipsec_layer_make(size : Int) -> NetsecipsecLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_ipsec_layer_len(s : NetsecipsecLayer) -> Int { s.size }

pub fn net_sec_ipsec_layer_get(s : NetsecipsecLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_ipsec_layer_set(s : NetsecipsecLayer, i : Int, v : Double) -> NetsecipsecLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_sec_ipsec_layer_sum(s : NetsecipsecLayer) -> Double { @_common.sum(s.data) }

pub fn net_sec_ipsec_layer_mean(s : NetsecipsecLayer) -> Double { @_common.mean(s.data) }

pub fn net_sec_ipsec_layer_scale(s : NetsecipsecLayer, f : Double) -> NetsecipsecLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_sec_ipsec_layer_add(a : NetsecipsecLayer, b : NetsecipsecLayer) -> NetsecipsecLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_sec_ipsec_layer_copy(s : NetsecipsecLayer) -> NetsecipsecLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_sec_ipsec_layer_fill(s : NetsecipsecLayer, v : Double) -> NetsecipsecLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_sec_ipsec_layer_min(s : NetsecipsecLayer) -> Double { @_common.min(s.data) }

pub fn net_sec_ipsec_layer_max(s : NetsecipsecLayer) -> Double { @_common.max(s.data) }

pub fn net_sec_ipsec_layer_to_string(s : NetsecipsecLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecipsecBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_ipsec_buffer_make(size : Int) -> NetsecipsecBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_ipsec_buffer_len(s : NetsecipsecBuffer) -> Int { s.size }

pub fn net_sec_ipsec_buffer_get(s : NetsecipsecBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_ipsec_buffer_set(s : NetsecipsecBuffer, i : Int, v : Double) -> NetsecipsecBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_sec_ipsec_buffer_sum(s : NetsecipsecBuffer) -> Double { @_common.sum(s.data) }

pub fn net_sec_ipsec_buffer_mean(s : NetsecipsecBuffer) -> Double { @_common.mean(s.data) }

pub fn net_sec_ipsec_buffer_scale(s : NetsecipsecBuffer, f : Double) -> NetsecipsecBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_sec_ipsec_buffer_add(a : NetsecipsecBuffer, b : NetsecipsecBuffer) -> NetsecipsecBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_sec_ipsec_buffer_copy(s : NetsecipsecBuffer) -> NetsecipsecBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_sec_ipsec_buffer_fill(s : NetsecipsecBuffer, v : Double) -> NetsecipsecBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_sec_ipsec_buffer_min(s : NetsecipsecBuffer) -> Double { @_common.min(s.data) }

pub fn net_sec_ipsec_buffer_max(s : NetsecipsecBuffer) -> Double { @_common.max(s.data) }

pub fn net_sec_ipsec_buffer_to_string(s : NetsecipsecBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecipsecCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_ipsec_cursor_make(size : Int) -> NetsecipsecCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_ipsec_cursor_len(s : NetsecipsecCursor) -> Int { s.size }

pub fn net_sec_ipsec_cursor_get(s : NetsecipsecCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_ipsec_cursor_set(s : NetsecipsecCursor, i : Int, v : Double) -> NetsecipsecCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_sec_ipsec_cursor_sum(s : NetsecipsecCursor) -> Double { @_common.sum(s.data) }

pub fn net_sec_ipsec_cursor_mean(s : NetsecipsecCursor) -> Double { @_common.mean(s.data) }

pub fn net_sec_ipsec_cursor_scale(s : NetsecipsecCursor, f : Double) -> NetsecipsecCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_sec_ipsec_cursor_add(a : NetsecipsecCursor, b : NetsecipsecCursor) -> NetsecipsecCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_sec_ipsec_cursor_copy(s : NetsecipsecCursor) -> NetsecipsecCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_sec_ipsec_cursor_fill(s : NetsecipsecCursor, v : Double) -> NetsecipsecCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_sec_ipsec_cursor_min(s : NetsecipsecCursor) -> Double { @_common.min(s.data) }

pub fn net_sec_ipsec_cursor_max(s : NetsecipsecCursor) -> Double { @_common.max(s.data) }

pub fn net_sec_ipsec_cursor_to_string(s : NetsecipsecCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecipsecView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_ipsec_view_make(size : Int) -> NetsecipsecView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_ipsec_view_len(s : NetsecipsecView) -> Int { s.size }

pub fn net_sec_ipsec_view_get(s : NetsecipsecView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_ipsec_view_set(s : NetsecipsecView, i : Int, v : Double) -> NetsecipsecView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_sec_ipsec_view_sum(s : NetsecipsecView) -> Double { @_common.sum(s.data) }

pub fn net_sec_ipsec_view_mean(s : NetsecipsecView) -> Double { @_common.mean(s.data) }

pub fn net_sec_ipsec_view_scale(s : NetsecipsecView, f : Double) -> NetsecipsecView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_sec_ipsec_view_add(a : NetsecipsecView, b : NetsecipsecView) -> NetsecipsecView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_sec_ipsec_view_copy(s : NetsecipsecView) -> NetsecipsecView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_sec_ipsec_view_fill(s : NetsecipsecView, v : Double) -> NetsecipsecView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_sec_ipsec_view_min(s : NetsecipsecView) -> Double { @_common.min(s.data) }

pub fn net_sec_ipsec_view_max(s : NetsecipsecView) -> Double { @_common.max(s.data) }

pub fn net_sec_ipsec_view_to_string(s : NetsecipsecView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecipsecRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_ipsec_range_make(size : Int) -> NetsecipsecRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_ipsec_range_len(s : NetsecipsecRange) -> Int { s.size }

pub fn net_sec_ipsec_range_get(s : NetsecipsecRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_ipsec_range_set(s : NetsecipsecRange, i : Int, v : Double) -> NetsecipsecRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_sec_ipsec_range_sum(s : NetsecipsecRange) -> Double { @_common.sum(s.data) }

pub fn net_sec_ipsec_range_mean(s : NetsecipsecRange) -> Double { @_common.mean(s.data) }

pub fn net_sec_ipsec_range_scale(s : NetsecipsecRange, f : Double) -> NetsecipsecRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_sec_ipsec_range_add(a : NetsecipsecRange, b : NetsecipsecRange) -> NetsecipsecRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_sec_ipsec_range_copy(s : NetsecipsecRange) -> NetsecipsecRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_sec_ipsec_range_fill(s : NetsecipsecRange, v : Double) -> NetsecipsecRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_sec_ipsec_range_min(s : NetsecipsecRange) -> Double { @_common.min(s.data) }

pub fn net_sec_ipsec_range_max(s : NetsecipsecRange) -> Double { @_common.max(s.data) }

pub fn net_sec_ipsec_range_to_string(s : NetsecipsecRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecipsecSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_ipsec_slice_make(size : Int) -> NetsecipsecSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_ipsec_slice_len(s : NetsecipsecSlice) -> Int { s.size }

pub fn net_sec_ipsec_slice_get(s : NetsecipsecSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_ipsec_slice_set(s : NetsecipsecSlice, i : Int, v : Double) -> NetsecipsecSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_sec_ipsec_slice_sum(s : NetsecipsecSlice) -> Double { @_common.sum(s.data) }

pub fn net_sec_ipsec_slice_mean(s : NetsecipsecSlice) -> Double { @_common.mean(s.data) }

pub fn net_sec_ipsec_slice_scale(s : NetsecipsecSlice, f : Double) -> NetsecipsecSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_sec_ipsec_slice_add(a : NetsecipsecSlice, b : NetsecipsecSlice) -> NetsecipsecSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_sec_ipsec_slice_copy(s : NetsecipsecSlice) -> NetsecipsecSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_sec_ipsec_slice_fill(s : NetsecipsecSlice, v : Double) -> NetsecipsecSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_sec_ipsec_slice_min(s : NetsecipsecSlice) -> Double { @_common.min(s.data) }

pub fn net_sec_ipsec_slice_max(s : NetsecipsecSlice) -> Double { @_common.max(s.data) }

pub fn net_sec_ipsec_slice_to_string(s : NetsecipsecSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

