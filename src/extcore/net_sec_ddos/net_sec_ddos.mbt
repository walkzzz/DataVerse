///===
/// extcore/net_sec_ddos

pub(all) struct NetsecddosPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn net_sec_ddos_make_point(x : Double, y : Double) -> NetsecddosPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn net_sec_ddos_make_point3(x : Double, y : Double, z : Double) -> NetsecddosPoint {
  { x, y, z, label: 0 }
}

pub fn net_sec_ddos_point_x(pt : NetsecddosPoint) -> Double { pt.x }

pub fn net_sec_ddos_point_y(pt : NetsecddosPoint) -> Double { pt.y }

pub fn net_sec_ddos_point_z(pt : NetsecddosPoint) -> Double { pt.z }

pub fn net_sec_ddos_point_label(pt : NetsecddosPoint) -> Int { pt.label }

pub fn net_sec_ddos_point_dist(a : NetsecddosPoint, b : NetsecddosPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn net_sec_ddos_point_add(a : NetsecddosPoint, b : NetsecddosPoint) -> NetsecddosPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn net_sec_ddos_point_sub(a : NetsecddosPoint, b : NetsecddosPoint) -> NetsecddosPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn net_sec_ddos_point_scale(pt : NetsecddosPoint, s : Double) -> NetsecddosPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn net_sec_ddos_point_dot(a : NetsecddosPoint, b : NetsecddosPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn net_sec_ddos_point_cross(a : NetsecddosPoint, b : NetsecddosPoint) -> NetsecddosPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn net_sec_ddos_point_norm(pt : NetsecddosPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn net_sec_ddos_point_normalize(pt : NetsecddosPoint) -> NetsecddosPoint {
  let n = net_sec_ddos_point_norm(pt)
  if n < 0.0000001 { pt } else { net_sec_ddos_point_scale(pt, 1.0 / n) }
}

pub fn net_sec_ddos_point_negate(pt : NetsecddosPoint) -> NetsecddosPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn net_sec_ddos_point_mid(a : NetsecddosPoint, b : NetsecddosPoint) -> NetsecddosPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn net_sec_ddos_point_lerp(a : NetsecddosPoint, b : NetsecddosPoint, t : Double) -> NetsecddosPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn net_sec_ddos_point_to_string(pt : NetsecddosPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct NetsecddosSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn net_sec_ddos_make_series(vals : Array[Double], name : String) -> NetsecddosSeries {
  { vals, name, meta: 0 }
}

pub fn net_sec_ddos_series_len(s : NetsecddosSeries) -> Int { s.vals.length() }

pub fn net_sec_ddos_series_sum(s : NetsecddosSeries) -> Double { @_common.sum(s.vals) }

pub fn net_sec_ddos_series_mean(s : NetsecddosSeries) -> Double { @_common.mean(s.vals) }

pub fn net_sec_ddos_series_min(s : NetsecddosSeries) -> Double { @_common.min(s.vals) }

pub fn net_sec_ddos_series_max(s : NetsecddosSeries) -> Double { @_common.max(s.vals) }

pub fn net_sec_ddos_series_range(s : NetsecddosSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn net_sec_ddos_series_var(s : NetsecddosSeries) -> Double { @_common.variance(s.vals) }

pub fn net_sec_ddos_series_std(s : NetsecddosSeries) -> Double { @_common.std(s.vals) }

pub fn net_sec_ddos_series_median(s : NetsecddosSeries) -> Double { @_common.median(s.vals) }

pub fn net_sec_ddos_series_scale(s : NetsecddosSeries, f : Double) -> NetsecddosSeries {
  { vals: @_common.scale_arr(s.vals, f), name: s.name, meta: s.meta }
}

pub fn net_sec_ddos_series_add(a : NetsecddosSeries, b : NetsecddosSeries) -> NetsecddosSeries {
  { vals: @_common.add_arr(a.vals, b.vals), name: a.name + "+" + b.name, meta: a.meta }
}

pub fn net_sec_ddos_series_sub(a : NetsecddosSeries, b : NetsecddosSeries) -> NetsecddosSeries {
  { vals: @_common.sub_arr(a.vals, b.vals), name: a.name + "-" + b.name, meta: a.meta }
}

pub fn net_sec_ddos_series_normalize(s : NetsecddosSeries) -> NetsecddosSeries {
  let mn = net_sec_ddos_series_min(s)
  let mx = net_sec_ddos_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn net_sec_ddos_series_cumsum(s : NetsecddosSeries) -> NetsecddosSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn net_sec_ddos_series_to_string(s : NetsecddosSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NetsecddosMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn net_sec_ddos_make_matrix(rows : Int, cols : Int, val : Double) -> NetsecddosMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn net_sec_ddos_matrix_identity(n : Int) -> NetsecddosMatrix {
  let m = net_sec_ddos_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn net_sec_ddos_matrix_get(m : NetsecddosMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn net_sec_ddos_matrix_transpose(m : NetsecddosMatrix) -> NetsecddosMatrix {
  let result = net_sec_ddos_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn net_sec_ddos_matrix_add(a : NetsecddosMatrix, b : NetsecddosMatrix) -> NetsecddosMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = net_sec_ddos_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn net_sec_ddos_matrix_scale(m : NetsecddosMatrix, s : Double) -> NetsecddosMatrix {
  let result = net_sec_ddos_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn net_sec_ddos_matrix_multiply(a : NetsecddosMatrix, b : NetsecddosMatrix) -> NetsecddosMatrix {
  if a.cols != b.rows { return net_sec_ddos_make_matrix(a.rows, b.cols, 0.0) }
  let result = net_sec_ddos_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn net_sec_ddos_matrix_trace(m : NetsecddosMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn net_sec_ddos_matrix_det(m : NetsecddosMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn net_sec_ddos_matrix_norm(m : NetsecddosMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn net_sec_ddos_matrix_to_string(m : NetsecddosMatrix) -> String {
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

pub(all) struct NetsecddosVector {
  comps : Array[Double]
  dim : Int
}

pub fn net_sec_ddos_make_vector(comps : Array[Double]) -> NetsecddosVector {
  { comps, dim: comps.length() }
}

pub fn net_sec_ddos_vector_zero(dim : Int) -> NetsecddosVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn net_sec_ddos_vector_add(a : NetsecddosVector, b : NetsecddosVector) -> NetsecddosVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.add_arr(a.comps, b.comps), dim: n }
}

pub fn net_sec_ddos_vector_sub(a : NetsecddosVector, b : NetsecddosVector) -> NetsecddosVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.sub_arr(a.comps, b.comps), dim: n }
}

pub fn net_sec_ddos_vector_scale(v : NetsecddosVector, s : Double) -> NetsecddosVector {
  { comps: @_common.scale_arr(v.comps, s), dim: v.dim }
}

pub fn net_sec_ddos_vector_dot(a : NetsecddosVector, b : NetsecddosVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn net_sec_ddos_vector_norm(v : NetsecddosVector) -> Double { @_common.sqrt(net_sec_ddos_vector_dot(v, v)) }

pub fn net_sec_ddos_vector_normalize(v : NetsecddosVector) -> NetsecddosVector {
  let n = net_sec_ddos_vector_norm(v)
  if n < 0.0000001 { v } else { net_sec_ddos_vector_scale(v, 1.0 / n) }
}

pub fn net_sec_ddos_vector_dist(a : NetsecddosVector, b : NetsecddosVector) -> Double {
  net_sec_ddos_vector_norm(net_sec_ddos_vector_sub(a, b))
}

pub fn net_sec_ddos_vector_to_string(v : NetsecddosVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn net_sec_ddos_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn net_sec_ddos_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn net_sec_ddos_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn net_sec_ddos_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn net_sec_ddos_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn net_sec_ddos_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn net_sec_ddos_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn net_sec_ddos_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn net_sec_ddos_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn net_sec_ddos_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn net_sec_ddos_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn net_sec_ddos_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn net_sec_ddos_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn net_sec_ddos_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn net_sec_ddos_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn net_sec_ddos_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn net_sec_ddos_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn net_sec_ddos_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn net_sec_ddos_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn net_sec_ddos_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn net_sec_ddos_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn net_sec_ddos_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn net_sec_ddos_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn net_sec_ddos_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn net_sec_ddos_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn net_sec_ddos_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn net_sec_ddos_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn net_sec_ddos_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn net_sec_ddos_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct NetsecddosFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_ddos_frame_make(size : Int) -> NetsecddosFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_ddos_frame_len(s : NetsecddosFrame) -> Int { s.size }

pub fn net_sec_ddos_frame_get(s : NetsecddosFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_ddos_frame_set(s : NetsecddosFrame, i : Int, v : Double) -> NetsecddosFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_sec_ddos_frame_sum(s : NetsecddosFrame) -> Double { @_common.sum(s.data) }

pub fn net_sec_ddos_frame_mean(s : NetsecddosFrame) -> Double { @_common.mean(s.data) }

pub fn net_sec_ddos_frame_scale(s : NetsecddosFrame, f : Double) -> NetsecddosFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_sec_ddos_frame_add(a : NetsecddosFrame, b : NetsecddosFrame) -> NetsecddosFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_sec_ddos_frame_copy(s : NetsecddosFrame) -> NetsecddosFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_sec_ddos_frame_fill(s : NetsecddosFrame, v : Double) -> NetsecddosFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_sec_ddos_frame_min(s : NetsecddosFrame) -> Double { @_common.min(s.data) }

pub fn net_sec_ddos_frame_max(s : NetsecddosFrame) -> Double { @_common.max(s.data) }

pub fn net_sec_ddos_frame_to_string(s : NetsecddosFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecddosTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_ddos_table_make(size : Int) -> NetsecddosTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_ddos_table_len(s : NetsecddosTable) -> Int { s.size }

pub fn net_sec_ddos_table_get(s : NetsecddosTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_ddos_table_set(s : NetsecddosTable, i : Int, v : Double) -> NetsecddosTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_sec_ddos_table_sum(s : NetsecddosTable) -> Double { @_common.sum(s.data) }

pub fn net_sec_ddos_table_mean(s : NetsecddosTable) -> Double { @_common.mean(s.data) }

pub fn net_sec_ddos_table_scale(s : NetsecddosTable, f : Double) -> NetsecddosTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_sec_ddos_table_add(a : NetsecddosTable, b : NetsecddosTable) -> NetsecddosTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_sec_ddos_table_copy(s : NetsecddosTable) -> NetsecddosTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_sec_ddos_table_fill(s : NetsecddosTable, v : Double) -> NetsecddosTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_sec_ddos_table_min(s : NetsecddosTable) -> Double { @_common.min(s.data) }

pub fn net_sec_ddos_table_max(s : NetsecddosTable) -> Double { @_common.max(s.data) }

pub fn net_sec_ddos_table_to_string(s : NetsecddosTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecddosGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_ddos_graphn_make(size : Int) -> NetsecddosGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_ddos_graphn_len(s : NetsecddosGraphN) -> Int { s.size }

pub fn net_sec_ddos_graphn_get(s : NetsecddosGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_ddos_graphn_set(s : NetsecddosGraphN, i : Int, v : Double) -> NetsecddosGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_sec_ddos_graphn_sum(s : NetsecddosGraphN) -> Double { @_common.sum(s.data) }

pub fn net_sec_ddos_graphn_mean(s : NetsecddosGraphN) -> Double { @_common.mean(s.data) }

pub fn net_sec_ddos_graphn_scale(s : NetsecddosGraphN, f : Double) -> NetsecddosGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_sec_ddos_graphn_add(a : NetsecddosGraphN, b : NetsecddosGraphN) -> NetsecddosGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_sec_ddos_graphn_copy(s : NetsecddosGraphN) -> NetsecddosGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_sec_ddos_graphn_fill(s : NetsecddosGraphN, v : Double) -> NetsecddosGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_sec_ddos_graphn_min(s : NetsecddosGraphN) -> Double { @_common.min(s.data) }

pub fn net_sec_ddos_graphn_max(s : NetsecddosGraphN) -> Double { @_common.max(s.data) }

pub fn net_sec_ddos_graphn_to_string(s : NetsecddosGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecddosNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_ddos_node_make(size : Int) -> NetsecddosNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_ddos_node_len(s : NetsecddosNode) -> Int { s.size }

pub fn net_sec_ddos_node_get(s : NetsecddosNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_ddos_node_set(s : NetsecddosNode, i : Int, v : Double) -> NetsecddosNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_sec_ddos_node_sum(s : NetsecddosNode) -> Double { @_common.sum(s.data) }

pub fn net_sec_ddos_node_mean(s : NetsecddosNode) -> Double { @_common.mean(s.data) }

pub fn net_sec_ddos_node_scale(s : NetsecddosNode, f : Double) -> NetsecddosNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_sec_ddos_node_add(a : NetsecddosNode, b : NetsecddosNode) -> NetsecddosNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_sec_ddos_node_copy(s : NetsecddosNode) -> NetsecddosNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_sec_ddos_node_fill(s : NetsecddosNode, v : Double) -> NetsecddosNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_sec_ddos_node_min(s : NetsecddosNode) -> Double { @_common.min(s.data) }

pub fn net_sec_ddos_node_max(s : NetsecddosNode) -> Double { @_common.max(s.data) }

pub fn net_sec_ddos_node_to_string(s : NetsecddosNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecddosEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_ddos_edge_make(size : Int) -> NetsecddosEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_ddos_edge_len(s : NetsecddosEdge) -> Int { s.size }

pub fn net_sec_ddos_edge_get(s : NetsecddosEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_ddos_edge_set(s : NetsecddosEdge, i : Int, v : Double) -> NetsecddosEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_sec_ddos_edge_sum(s : NetsecddosEdge) -> Double { @_common.sum(s.data) }

pub fn net_sec_ddos_edge_mean(s : NetsecddosEdge) -> Double { @_common.mean(s.data) }

pub fn net_sec_ddos_edge_scale(s : NetsecddosEdge, f : Double) -> NetsecddosEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_sec_ddos_edge_add(a : NetsecddosEdge, b : NetsecddosEdge) -> NetsecddosEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_sec_ddos_edge_copy(s : NetsecddosEdge) -> NetsecddosEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_sec_ddos_edge_fill(s : NetsecddosEdge, v : Double) -> NetsecddosEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_sec_ddos_edge_min(s : NetsecddosEdge) -> Double { @_common.min(s.data) }

pub fn net_sec_ddos_edge_max(s : NetsecddosEdge) -> Double { @_common.max(s.data) }

pub fn net_sec_ddos_edge_to_string(s : NetsecddosEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecddosPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_ddos_path_make(size : Int) -> NetsecddosPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_ddos_path_len(s : NetsecddosPath) -> Int { s.size }

pub fn net_sec_ddos_path_get(s : NetsecddosPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_ddos_path_set(s : NetsecddosPath, i : Int, v : Double) -> NetsecddosPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_sec_ddos_path_sum(s : NetsecddosPath) -> Double { @_common.sum(s.data) }

pub fn net_sec_ddos_path_mean(s : NetsecddosPath) -> Double { @_common.mean(s.data) }

pub fn net_sec_ddos_path_scale(s : NetsecddosPath, f : Double) -> NetsecddosPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_sec_ddos_path_add(a : NetsecddosPath, b : NetsecddosPath) -> NetsecddosPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_sec_ddos_path_copy(s : NetsecddosPath) -> NetsecddosPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_sec_ddos_path_fill(s : NetsecddosPath, v : Double) -> NetsecddosPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_sec_ddos_path_min(s : NetsecddosPath) -> Double { @_common.min(s.data) }

pub fn net_sec_ddos_path_max(s : NetsecddosPath) -> Double { @_common.max(s.data) }

pub fn net_sec_ddos_path_to_string(s : NetsecddosPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecddosCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_ddos_cluster_make(size : Int) -> NetsecddosCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_ddos_cluster_len(s : NetsecddosCluster) -> Int { s.size }

pub fn net_sec_ddos_cluster_get(s : NetsecddosCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_ddos_cluster_set(s : NetsecddosCluster, i : Int, v : Double) -> NetsecddosCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_sec_ddos_cluster_sum(s : NetsecddosCluster) -> Double { @_common.sum(s.data) }

pub fn net_sec_ddos_cluster_mean(s : NetsecddosCluster) -> Double { @_common.mean(s.data) }

pub fn net_sec_ddos_cluster_scale(s : NetsecddosCluster, f : Double) -> NetsecddosCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_sec_ddos_cluster_add(a : NetsecddosCluster, b : NetsecddosCluster) -> NetsecddosCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_sec_ddos_cluster_copy(s : NetsecddosCluster) -> NetsecddosCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_sec_ddos_cluster_fill(s : NetsecddosCluster, v : Double) -> NetsecddosCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_sec_ddos_cluster_min(s : NetsecddosCluster) -> Double { @_common.min(s.data) }

pub fn net_sec_ddos_cluster_max(s : NetsecddosCluster) -> Double { @_common.max(s.data) }

pub fn net_sec_ddos_cluster_to_string(s : NetsecddosCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecddosModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_ddos_model_make(size : Int) -> NetsecddosModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_ddos_model_len(s : NetsecddosModel) -> Int { s.size }

pub fn net_sec_ddos_model_get(s : NetsecddosModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_ddos_model_set(s : NetsecddosModel, i : Int, v : Double) -> NetsecddosModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_sec_ddos_model_sum(s : NetsecddosModel) -> Double { @_common.sum(s.data) }

pub fn net_sec_ddos_model_mean(s : NetsecddosModel) -> Double { @_common.mean(s.data) }

pub fn net_sec_ddos_model_scale(s : NetsecddosModel, f : Double) -> NetsecddosModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_sec_ddos_model_add(a : NetsecddosModel, b : NetsecddosModel) -> NetsecddosModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_sec_ddos_model_copy(s : NetsecddosModel) -> NetsecddosModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_sec_ddos_model_fill(s : NetsecddosModel, v : Double) -> NetsecddosModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_sec_ddos_model_min(s : NetsecddosModel) -> Double { @_common.min(s.data) }

pub fn net_sec_ddos_model_max(s : NetsecddosModel) -> Double { @_common.max(s.data) }

pub fn net_sec_ddos_model_to_string(s : NetsecddosModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecddosLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_ddos_layer_make(size : Int) -> NetsecddosLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_ddos_layer_len(s : NetsecddosLayer) -> Int { s.size }

pub fn net_sec_ddos_layer_get(s : NetsecddosLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_ddos_layer_set(s : NetsecddosLayer, i : Int, v : Double) -> NetsecddosLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_sec_ddos_layer_sum(s : NetsecddosLayer) -> Double { @_common.sum(s.data) }

pub fn net_sec_ddos_layer_mean(s : NetsecddosLayer) -> Double { @_common.mean(s.data) }

pub fn net_sec_ddos_layer_scale(s : NetsecddosLayer, f : Double) -> NetsecddosLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_sec_ddos_layer_add(a : NetsecddosLayer, b : NetsecddosLayer) -> NetsecddosLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_sec_ddos_layer_copy(s : NetsecddosLayer) -> NetsecddosLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_sec_ddos_layer_fill(s : NetsecddosLayer, v : Double) -> NetsecddosLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_sec_ddos_layer_min(s : NetsecddosLayer) -> Double { @_common.min(s.data) }

pub fn net_sec_ddos_layer_max(s : NetsecddosLayer) -> Double { @_common.max(s.data) }

pub fn net_sec_ddos_layer_to_string(s : NetsecddosLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecddosBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_ddos_buffer_make(size : Int) -> NetsecddosBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_ddos_buffer_len(s : NetsecddosBuffer) -> Int { s.size }

pub fn net_sec_ddos_buffer_get(s : NetsecddosBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_ddos_buffer_set(s : NetsecddosBuffer, i : Int, v : Double) -> NetsecddosBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_sec_ddos_buffer_sum(s : NetsecddosBuffer) -> Double { @_common.sum(s.data) }

pub fn net_sec_ddos_buffer_mean(s : NetsecddosBuffer) -> Double { @_common.mean(s.data) }

pub fn net_sec_ddos_buffer_scale(s : NetsecddosBuffer, f : Double) -> NetsecddosBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_sec_ddos_buffer_add(a : NetsecddosBuffer, b : NetsecddosBuffer) -> NetsecddosBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_sec_ddos_buffer_copy(s : NetsecddosBuffer) -> NetsecddosBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_sec_ddos_buffer_fill(s : NetsecddosBuffer, v : Double) -> NetsecddosBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_sec_ddos_buffer_min(s : NetsecddosBuffer) -> Double { @_common.min(s.data) }

pub fn net_sec_ddos_buffer_max(s : NetsecddosBuffer) -> Double { @_common.max(s.data) }

pub fn net_sec_ddos_buffer_to_string(s : NetsecddosBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecddosCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_ddos_cursor_make(size : Int) -> NetsecddosCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_ddos_cursor_len(s : NetsecddosCursor) -> Int { s.size }

pub fn net_sec_ddos_cursor_get(s : NetsecddosCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_ddos_cursor_set(s : NetsecddosCursor, i : Int, v : Double) -> NetsecddosCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_sec_ddos_cursor_sum(s : NetsecddosCursor) -> Double { @_common.sum(s.data) }

pub fn net_sec_ddos_cursor_mean(s : NetsecddosCursor) -> Double { @_common.mean(s.data) }

pub fn net_sec_ddos_cursor_scale(s : NetsecddosCursor, f : Double) -> NetsecddosCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_sec_ddos_cursor_add(a : NetsecddosCursor, b : NetsecddosCursor) -> NetsecddosCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_sec_ddos_cursor_copy(s : NetsecddosCursor) -> NetsecddosCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_sec_ddos_cursor_fill(s : NetsecddosCursor, v : Double) -> NetsecddosCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_sec_ddos_cursor_min(s : NetsecddosCursor) -> Double { @_common.min(s.data) }

pub fn net_sec_ddos_cursor_max(s : NetsecddosCursor) -> Double { @_common.max(s.data) }

pub fn net_sec_ddos_cursor_to_string(s : NetsecddosCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecddosView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_ddos_view_make(size : Int) -> NetsecddosView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_ddos_view_len(s : NetsecddosView) -> Int { s.size }

pub fn net_sec_ddos_view_get(s : NetsecddosView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_ddos_view_set(s : NetsecddosView, i : Int, v : Double) -> NetsecddosView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_sec_ddos_view_sum(s : NetsecddosView) -> Double { @_common.sum(s.data) }

pub fn net_sec_ddos_view_mean(s : NetsecddosView) -> Double { @_common.mean(s.data) }

pub fn net_sec_ddos_view_scale(s : NetsecddosView, f : Double) -> NetsecddosView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_sec_ddos_view_add(a : NetsecddosView, b : NetsecddosView) -> NetsecddosView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_sec_ddos_view_copy(s : NetsecddosView) -> NetsecddosView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_sec_ddos_view_fill(s : NetsecddosView, v : Double) -> NetsecddosView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_sec_ddos_view_min(s : NetsecddosView) -> Double { @_common.min(s.data) }

pub fn net_sec_ddos_view_max(s : NetsecddosView) -> Double { @_common.max(s.data) }

pub fn net_sec_ddos_view_to_string(s : NetsecddosView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecddosRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_ddos_range_make(size : Int) -> NetsecddosRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_ddos_range_len(s : NetsecddosRange) -> Int { s.size }

pub fn net_sec_ddos_range_get(s : NetsecddosRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_ddos_range_set(s : NetsecddosRange, i : Int, v : Double) -> NetsecddosRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_sec_ddos_range_sum(s : NetsecddosRange) -> Double { @_common.sum(s.data) }

pub fn net_sec_ddos_range_mean(s : NetsecddosRange) -> Double { @_common.mean(s.data) }

pub fn net_sec_ddos_range_scale(s : NetsecddosRange, f : Double) -> NetsecddosRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_sec_ddos_range_add(a : NetsecddosRange, b : NetsecddosRange) -> NetsecddosRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_sec_ddos_range_copy(s : NetsecddosRange) -> NetsecddosRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_sec_ddos_range_fill(s : NetsecddosRange, v : Double) -> NetsecddosRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_sec_ddos_range_min(s : NetsecddosRange) -> Double { @_common.min(s.data) }

pub fn net_sec_ddos_range_max(s : NetsecddosRange) -> Double { @_common.max(s.data) }

pub fn net_sec_ddos_range_to_string(s : NetsecddosRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecddosSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_ddos_slice_make(size : Int) -> NetsecddosSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_ddos_slice_len(s : NetsecddosSlice) -> Int { s.size }

pub fn net_sec_ddos_slice_get(s : NetsecddosSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_ddos_slice_set(s : NetsecddosSlice, i : Int, v : Double) -> NetsecddosSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_sec_ddos_slice_sum(s : NetsecddosSlice) -> Double { @_common.sum(s.data) }

pub fn net_sec_ddos_slice_mean(s : NetsecddosSlice) -> Double { @_common.mean(s.data) }

pub fn net_sec_ddos_slice_scale(s : NetsecddosSlice, f : Double) -> NetsecddosSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_sec_ddos_slice_add(a : NetsecddosSlice, b : NetsecddosSlice) -> NetsecddosSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_sec_ddos_slice_copy(s : NetsecddosSlice) -> NetsecddosSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_sec_ddos_slice_fill(s : NetsecddosSlice, v : Double) -> NetsecddosSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_sec_ddos_slice_min(s : NetsecddosSlice) -> Double { @_common.min(s.data) }

pub fn net_sec_ddos_slice_max(s : NetsecddosSlice) -> Double { @_common.max(s.data) }

pub fn net_sec_ddos_slice_to_string(s : NetsecddosSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

