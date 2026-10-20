///===
/// extcore/net_proto_quic

pub(all) struct NetprotoquicPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn net_proto_quic_make_point(x : Double, y : Double) -> NetprotoquicPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn net_proto_quic_make_point3(x : Double, y : Double, z : Double) -> NetprotoquicPoint {
  { x, y, z, label: 0 }
}

pub fn net_proto_quic_point_x(pt : NetprotoquicPoint) -> Double { pt.x }

pub fn net_proto_quic_point_y(pt : NetprotoquicPoint) -> Double { pt.y }

pub fn net_proto_quic_point_z(pt : NetprotoquicPoint) -> Double { pt.z }

pub fn net_proto_quic_point_label(pt : NetprotoquicPoint) -> Int { pt.label }

pub fn net_proto_quic_point_dist(a : NetprotoquicPoint, b : NetprotoquicPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn net_proto_quic_point_add(a : NetprotoquicPoint, b : NetprotoquicPoint) -> NetprotoquicPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn net_proto_quic_point_sub(a : NetprotoquicPoint, b : NetprotoquicPoint) -> NetprotoquicPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn net_proto_quic_point_scale(pt : NetprotoquicPoint, s : Double) -> NetprotoquicPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn net_proto_quic_point_dot(a : NetprotoquicPoint, b : NetprotoquicPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn net_proto_quic_point_cross(a : NetprotoquicPoint, b : NetprotoquicPoint) -> NetprotoquicPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn net_proto_quic_point_norm(pt : NetprotoquicPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn net_proto_quic_point_normalize(pt : NetprotoquicPoint) -> NetprotoquicPoint {
  let n = net_proto_quic_point_norm(pt)
  if n < 0.0000001 { pt } else { net_proto_quic_point_scale(pt, 1.0 / n) }
}

pub fn net_proto_quic_point_negate(pt : NetprotoquicPoint) -> NetprotoquicPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn net_proto_quic_point_mid(a : NetprotoquicPoint, b : NetprotoquicPoint) -> NetprotoquicPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn net_proto_quic_point_lerp(a : NetprotoquicPoint, b : NetprotoquicPoint, t : Double) -> NetprotoquicPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn net_proto_quic_point_to_string(pt : NetprotoquicPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct NetprotoquicSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn net_proto_quic_make_series(vals : Array[Double], name : String) -> NetprotoquicSeries {
  { vals, name, meta: 0 }
}

pub fn net_proto_quic_series_len(s : NetprotoquicSeries) -> Int { s.vals.length() }

pub fn net_proto_quic_series_sum(s : NetprotoquicSeries) -> Double { @_common.sum(s.vals) }

pub fn net_proto_quic_series_mean(s : NetprotoquicSeries) -> Double { @_common.mean(s.vals) }

pub fn net_proto_quic_series_min(s : NetprotoquicSeries) -> Double { @_common.min(s.vals) }

pub fn net_proto_quic_series_max(s : NetprotoquicSeries) -> Double { @_common.max(s.vals) }

pub fn net_proto_quic_series_range(s : NetprotoquicSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn net_proto_quic_series_var(s : NetprotoquicSeries) -> Double { @_common.variance(s.vals) }

pub fn net_proto_quic_series_std(s : NetprotoquicSeries) -> Double { @_common.std(s.vals) }

pub fn net_proto_quic_series_median(s : NetprotoquicSeries) -> Double { @_common.median(s.vals) }

pub fn net_proto_quic_series_scale(s : NetprotoquicSeries, f : Double) -> NetprotoquicSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn net_proto_quic_series_add(a : NetprotoquicSeries, b : NetprotoquicSeries) -> NetprotoquicSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn net_proto_quic_series_sub(a : NetprotoquicSeries, b : NetprotoquicSeries) -> NetprotoquicSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn net_proto_quic_series_normalize(s : NetprotoquicSeries) -> NetprotoquicSeries {
  let mn = net_proto_quic_series_min(s)
  let mx = net_proto_quic_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn net_proto_quic_series_cumsum(s : NetprotoquicSeries) -> NetprotoquicSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn net_proto_quic_series_to_string(s : NetprotoquicSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NetprotoquicMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn net_proto_quic_make_matrix(rows : Int, cols : Int, val : Double) -> NetprotoquicMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn net_proto_quic_matrix_identity(n : Int) -> NetprotoquicMatrix {
  let m = net_proto_quic_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn net_proto_quic_matrix_get(m : NetprotoquicMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn net_proto_quic_matrix_transpose(m : NetprotoquicMatrix) -> NetprotoquicMatrix {
  let result = net_proto_quic_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn net_proto_quic_matrix_add(a : NetprotoquicMatrix, b : NetprotoquicMatrix) -> NetprotoquicMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = net_proto_quic_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn net_proto_quic_matrix_scale(m : NetprotoquicMatrix, s : Double) -> NetprotoquicMatrix {
  let result = net_proto_quic_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn net_proto_quic_matrix_multiply(a : NetprotoquicMatrix, b : NetprotoquicMatrix) -> NetprotoquicMatrix {
  if a.cols != b.rows { return net_proto_quic_make_matrix(a.rows, b.cols, 0.0) }
  let result = net_proto_quic_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn net_proto_quic_matrix_trace(m : NetprotoquicMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn net_proto_quic_matrix_det(m : NetprotoquicMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn net_proto_quic_matrix_norm(m : NetprotoquicMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn net_proto_quic_matrix_to_string(m : NetprotoquicMatrix) -> String {
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

pub(all) struct NetprotoquicVector {
  comps : Array[Double]
  dim : Int
}

pub fn net_proto_quic_make_vector(comps : Array[Double]) -> NetprotoquicVector {
  { comps, dim: comps.length() }
}

pub fn net_proto_quic_vector_zero(dim : Int) -> NetprotoquicVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn net_proto_quic_vector_add(a : NetprotoquicVector, b : NetprotoquicVector) -> NetprotoquicVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn net_proto_quic_vector_sub(a : NetprotoquicVector, b : NetprotoquicVector) -> NetprotoquicVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn net_proto_quic_vector_scale(v : NetprotoquicVector, s : Double) -> NetprotoquicVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn net_proto_quic_vector_dot(a : NetprotoquicVector, b : NetprotoquicVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn net_proto_quic_vector_norm(v : NetprotoquicVector) -> Double { @_common.sqrt(net_proto_quic_vector_dot(v, v)) }

pub fn net_proto_quic_vector_normalize(v : NetprotoquicVector) -> NetprotoquicVector {
  let n = net_proto_quic_vector_norm(v)
  if n < 0.0000001 { v } else { net_proto_quic_vector_scale(v, 1.0 / n) }
}

pub fn net_proto_quic_vector_dist(a : NetprotoquicVector, b : NetprotoquicVector) -> Double {
  net_proto_quic_vector_norm(net_proto_quic_vector_sub(a, b))
}

pub fn net_proto_quic_vector_to_string(v : NetprotoquicVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn net_proto_quic_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn net_proto_quic_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn net_proto_quic_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn net_proto_quic_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn net_proto_quic_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn net_proto_quic_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn net_proto_quic_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn net_proto_quic_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn net_proto_quic_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn net_proto_quic_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn net_proto_quic_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn net_proto_quic_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn net_proto_quic_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn net_proto_quic_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn net_proto_quic_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn net_proto_quic_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn net_proto_quic_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn net_proto_quic_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn net_proto_quic_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn net_proto_quic_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn net_proto_quic_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn net_proto_quic_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn net_proto_quic_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn net_proto_quic_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn net_proto_quic_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn net_proto_quic_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn net_proto_quic_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn net_proto_quic_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn net_proto_quic_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct NetprotoquicFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_quic_frame_make(size : Int) -> NetprotoquicFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_quic_frame_len(s : NetprotoquicFrame) -> Int { s.size }

pub fn net_proto_quic_frame_get(s : NetprotoquicFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_quic_frame_set(s : NetprotoquicFrame, i : Int, v : Double) -> NetprotoquicFrame {
  let result = net_proto_quic_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_proto_quic_frame_sum(s : NetprotoquicFrame) -> Double { @_common.sum(s.data) }

pub fn net_proto_quic_frame_mean(s : NetprotoquicFrame) -> Double { @_common.mean(s.data) }

pub fn net_proto_quic_frame_scale(s : NetprotoquicFrame, f : Double) -> NetprotoquicFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_proto_quic_frame_add(a : NetprotoquicFrame, b : NetprotoquicFrame) -> NetprotoquicFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_proto_quic_frame_copy(s : NetprotoquicFrame) -> NetprotoquicFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_proto_quic_frame_fill(s : NetprotoquicFrame, v : Double) -> NetprotoquicFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_proto_quic_frame_min(s : NetprotoquicFrame) -> Double { @_common.min(s.data) }

pub fn net_proto_quic_frame_max(s : NetprotoquicFrame) -> Double { @_common.max(s.data) }

pub fn net_proto_quic_frame_to_string(s : NetprotoquicFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotoquicTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_quic_table_make(size : Int) -> NetprotoquicTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_quic_table_len(s : NetprotoquicTable) -> Int { s.size }

pub fn net_proto_quic_table_get(s : NetprotoquicTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_quic_table_set(s : NetprotoquicTable, i : Int, v : Double) -> NetprotoquicTable {
  let result = net_proto_quic_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_proto_quic_table_sum(s : NetprotoquicTable) -> Double { @_common.sum(s.data) }

pub fn net_proto_quic_table_mean(s : NetprotoquicTable) -> Double { @_common.mean(s.data) }

pub fn net_proto_quic_table_scale(s : NetprotoquicTable, f : Double) -> NetprotoquicTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_proto_quic_table_add(a : NetprotoquicTable, b : NetprotoquicTable) -> NetprotoquicTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_proto_quic_table_copy(s : NetprotoquicTable) -> NetprotoquicTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_proto_quic_table_fill(s : NetprotoquicTable, v : Double) -> NetprotoquicTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_proto_quic_table_min(s : NetprotoquicTable) -> Double { @_common.min(s.data) }

pub fn net_proto_quic_table_max(s : NetprotoquicTable) -> Double { @_common.max(s.data) }

pub fn net_proto_quic_table_to_string(s : NetprotoquicTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotoquicGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_quic_graphn_make(size : Int) -> NetprotoquicGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_quic_graphn_len(s : NetprotoquicGraphN) -> Int { s.size }

pub fn net_proto_quic_graphn_get(s : NetprotoquicGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_quic_graphn_set(s : NetprotoquicGraphN, i : Int, v : Double) -> NetprotoquicGraphN {
  let result = net_proto_quic_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_proto_quic_graphn_sum(s : NetprotoquicGraphN) -> Double { @_common.sum(s.data) }

pub fn net_proto_quic_graphn_mean(s : NetprotoquicGraphN) -> Double { @_common.mean(s.data) }

pub fn net_proto_quic_graphn_scale(s : NetprotoquicGraphN, f : Double) -> NetprotoquicGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_proto_quic_graphn_add(a : NetprotoquicGraphN, b : NetprotoquicGraphN) -> NetprotoquicGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_proto_quic_graphn_copy(s : NetprotoquicGraphN) -> NetprotoquicGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_proto_quic_graphn_fill(s : NetprotoquicGraphN, v : Double) -> NetprotoquicGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_proto_quic_graphn_min(s : NetprotoquicGraphN) -> Double { @_common.min(s.data) }

pub fn net_proto_quic_graphn_max(s : NetprotoquicGraphN) -> Double { @_common.max(s.data) }

pub fn net_proto_quic_graphn_to_string(s : NetprotoquicGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotoquicNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_quic_node_make(size : Int) -> NetprotoquicNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_quic_node_len(s : NetprotoquicNode) -> Int { s.size }

pub fn net_proto_quic_node_get(s : NetprotoquicNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_quic_node_set(s : NetprotoquicNode, i : Int, v : Double) -> NetprotoquicNode {
  let result = net_proto_quic_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_proto_quic_node_sum(s : NetprotoquicNode) -> Double { @_common.sum(s.data) }

pub fn net_proto_quic_node_mean(s : NetprotoquicNode) -> Double { @_common.mean(s.data) }

pub fn net_proto_quic_node_scale(s : NetprotoquicNode, f : Double) -> NetprotoquicNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_proto_quic_node_add(a : NetprotoquicNode, b : NetprotoquicNode) -> NetprotoquicNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_proto_quic_node_copy(s : NetprotoquicNode) -> NetprotoquicNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_proto_quic_node_fill(s : NetprotoquicNode, v : Double) -> NetprotoquicNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_proto_quic_node_min(s : NetprotoquicNode) -> Double { @_common.min(s.data) }

pub fn net_proto_quic_node_max(s : NetprotoquicNode) -> Double { @_common.max(s.data) }

pub fn net_proto_quic_node_to_string(s : NetprotoquicNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotoquicEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_quic_edge_make(size : Int) -> NetprotoquicEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_quic_edge_len(s : NetprotoquicEdge) -> Int { s.size }

pub fn net_proto_quic_edge_get(s : NetprotoquicEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_quic_edge_set(s : NetprotoquicEdge, i : Int, v : Double) -> NetprotoquicEdge {
  let result = net_proto_quic_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_proto_quic_edge_sum(s : NetprotoquicEdge) -> Double { @_common.sum(s.data) }

pub fn net_proto_quic_edge_mean(s : NetprotoquicEdge) -> Double { @_common.mean(s.data) }

pub fn net_proto_quic_edge_scale(s : NetprotoquicEdge, f : Double) -> NetprotoquicEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_proto_quic_edge_add(a : NetprotoquicEdge, b : NetprotoquicEdge) -> NetprotoquicEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_proto_quic_edge_copy(s : NetprotoquicEdge) -> NetprotoquicEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_proto_quic_edge_fill(s : NetprotoquicEdge, v : Double) -> NetprotoquicEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_proto_quic_edge_min(s : NetprotoquicEdge) -> Double { @_common.min(s.data) }

pub fn net_proto_quic_edge_max(s : NetprotoquicEdge) -> Double { @_common.max(s.data) }

pub fn net_proto_quic_edge_to_string(s : NetprotoquicEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotoquicPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_quic_path_make(size : Int) -> NetprotoquicPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_quic_path_len(s : NetprotoquicPath) -> Int { s.size }

pub fn net_proto_quic_path_get(s : NetprotoquicPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_quic_path_set(s : NetprotoquicPath, i : Int, v : Double) -> NetprotoquicPath {
  let result = net_proto_quic_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_proto_quic_path_sum(s : NetprotoquicPath) -> Double { @_common.sum(s.data) }

pub fn net_proto_quic_path_mean(s : NetprotoquicPath) -> Double { @_common.mean(s.data) }

pub fn net_proto_quic_path_scale(s : NetprotoquicPath, f : Double) -> NetprotoquicPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_proto_quic_path_add(a : NetprotoquicPath, b : NetprotoquicPath) -> NetprotoquicPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_proto_quic_path_copy(s : NetprotoquicPath) -> NetprotoquicPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_proto_quic_path_fill(s : NetprotoquicPath, v : Double) -> NetprotoquicPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_proto_quic_path_min(s : NetprotoquicPath) -> Double { @_common.min(s.data) }

pub fn net_proto_quic_path_max(s : NetprotoquicPath) -> Double { @_common.max(s.data) }

pub fn net_proto_quic_path_to_string(s : NetprotoquicPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotoquicCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_quic_cluster_make(size : Int) -> NetprotoquicCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_quic_cluster_len(s : NetprotoquicCluster) -> Int { s.size }

pub fn net_proto_quic_cluster_get(s : NetprotoquicCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_quic_cluster_set(s : NetprotoquicCluster, i : Int, v : Double) -> NetprotoquicCluster {
  let result = net_proto_quic_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_proto_quic_cluster_sum(s : NetprotoquicCluster) -> Double { @_common.sum(s.data) }

pub fn net_proto_quic_cluster_mean(s : NetprotoquicCluster) -> Double { @_common.mean(s.data) }

pub fn net_proto_quic_cluster_scale(s : NetprotoquicCluster, f : Double) -> NetprotoquicCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_proto_quic_cluster_add(a : NetprotoquicCluster, b : NetprotoquicCluster) -> NetprotoquicCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_proto_quic_cluster_copy(s : NetprotoquicCluster) -> NetprotoquicCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_proto_quic_cluster_fill(s : NetprotoquicCluster, v : Double) -> NetprotoquicCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_proto_quic_cluster_min(s : NetprotoquicCluster) -> Double { @_common.min(s.data) }

pub fn net_proto_quic_cluster_max(s : NetprotoquicCluster) -> Double { @_common.max(s.data) }

pub fn net_proto_quic_cluster_to_string(s : NetprotoquicCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotoquicModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_quic_model_make(size : Int) -> NetprotoquicModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_quic_model_len(s : NetprotoquicModel) -> Int { s.size }

pub fn net_proto_quic_model_get(s : NetprotoquicModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_quic_model_set(s : NetprotoquicModel, i : Int, v : Double) -> NetprotoquicModel {
  let result = net_proto_quic_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_proto_quic_model_sum(s : NetprotoquicModel) -> Double { @_common.sum(s.data) }

pub fn net_proto_quic_model_mean(s : NetprotoquicModel) -> Double { @_common.mean(s.data) }

pub fn net_proto_quic_model_scale(s : NetprotoquicModel, f : Double) -> NetprotoquicModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_proto_quic_model_add(a : NetprotoquicModel, b : NetprotoquicModel) -> NetprotoquicModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_proto_quic_model_copy(s : NetprotoquicModel) -> NetprotoquicModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_proto_quic_model_fill(s : NetprotoquicModel, v : Double) -> NetprotoquicModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_proto_quic_model_min(s : NetprotoquicModel) -> Double { @_common.min(s.data) }

pub fn net_proto_quic_model_max(s : NetprotoquicModel) -> Double { @_common.max(s.data) }

pub fn net_proto_quic_model_to_string(s : NetprotoquicModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotoquicLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_quic_layer_make(size : Int) -> NetprotoquicLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_quic_layer_len(s : NetprotoquicLayer) -> Int { s.size }

pub fn net_proto_quic_layer_get(s : NetprotoquicLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_quic_layer_set(s : NetprotoquicLayer, i : Int, v : Double) -> NetprotoquicLayer {
  let result = net_proto_quic_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_proto_quic_layer_sum(s : NetprotoquicLayer) -> Double { @_common.sum(s.data) }

pub fn net_proto_quic_layer_mean(s : NetprotoquicLayer) -> Double { @_common.mean(s.data) }

pub fn net_proto_quic_layer_scale(s : NetprotoquicLayer, f : Double) -> NetprotoquicLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_proto_quic_layer_add(a : NetprotoquicLayer, b : NetprotoquicLayer) -> NetprotoquicLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_proto_quic_layer_copy(s : NetprotoquicLayer) -> NetprotoquicLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_proto_quic_layer_fill(s : NetprotoquicLayer, v : Double) -> NetprotoquicLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_proto_quic_layer_min(s : NetprotoquicLayer) -> Double { @_common.min(s.data) }

pub fn net_proto_quic_layer_max(s : NetprotoquicLayer) -> Double { @_common.max(s.data) }

pub fn net_proto_quic_layer_to_string(s : NetprotoquicLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotoquicBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_quic_buffer_make(size : Int) -> NetprotoquicBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_quic_buffer_len(s : NetprotoquicBuffer) -> Int { s.size }

pub fn net_proto_quic_buffer_get(s : NetprotoquicBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_quic_buffer_set(s : NetprotoquicBuffer, i : Int, v : Double) -> NetprotoquicBuffer {
  let result = net_proto_quic_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_proto_quic_buffer_sum(s : NetprotoquicBuffer) -> Double { @_common.sum(s.data) }

pub fn net_proto_quic_buffer_mean(s : NetprotoquicBuffer) -> Double { @_common.mean(s.data) }

pub fn net_proto_quic_buffer_scale(s : NetprotoquicBuffer, f : Double) -> NetprotoquicBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_proto_quic_buffer_add(a : NetprotoquicBuffer, b : NetprotoquicBuffer) -> NetprotoquicBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_proto_quic_buffer_copy(s : NetprotoquicBuffer) -> NetprotoquicBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_proto_quic_buffer_fill(s : NetprotoquicBuffer, v : Double) -> NetprotoquicBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_proto_quic_buffer_min(s : NetprotoquicBuffer) -> Double { @_common.min(s.data) }

pub fn net_proto_quic_buffer_max(s : NetprotoquicBuffer) -> Double { @_common.max(s.data) }

pub fn net_proto_quic_buffer_to_string(s : NetprotoquicBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotoquicCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_quic_cursor_make(size : Int) -> NetprotoquicCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_quic_cursor_len(s : NetprotoquicCursor) -> Int { s.size }

pub fn net_proto_quic_cursor_get(s : NetprotoquicCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_quic_cursor_set(s : NetprotoquicCursor, i : Int, v : Double) -> NetprotoquicCursor {
  let result = net_proto_quic_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_proto_quic_cursor_sum(s : NetprotoquicCursor) -> Double { @_common.sum(s.data) }

pub fn net_proto_quic_cursor_mean(s : NetprotoquicCursor) -> Double { @_common.mean(s.data) }

pub fn net_proto_quic_cursor_scale(s : NetprotoquicCursor, f : Double) -> NetprotoquicCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_proto_quic_cursor_add(a : NetprotoquicCursor, b : NetprotoquicCursor) -> NetprotoquicCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_proto_quic_cursor_copy(s : NetprotoquicCursor) -> NetprotoquicCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_proto_quic_cursor_fill(s : NetprotoquicCursor, v : Double) -> NetprotoquicCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_proto_quic_cursor_min(s : NetprotoquicCursor) -> Double { @_common.min(s.data) }

pub fn net_proto_quic_cursor_max(s : NetprotoquicCursor) -> Double { @_common.max(s.data) }

pub fn net_proto_quic_cursor_to_string(s : NetprotoquicCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotoquicView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_quic_view_make(size : Int) -> NetprotoquicView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_quic_view_len(s : NetprotoquicView) -> Int { s.size }

pub fn net_proto_quic_view_get(s : NetprotoquicView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_quic_view_set(s : NetprotoquicView, i : Int, v : Double) -> NetprotoquicView {
  let result = net_proto_quic_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_proto_quic_view_sum(s : NetprotoquicView) -> Double { @_common.sum(s.data) }

pub fn net_proto_quic_view_mean(s : NetprotoquicView) -> Double { @_common.mean(s.data) }

pub fn net_proto_quic_view_scale(s : NetprotoquicView, f : Double) -> NetprotoquicView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_proto_quic_view_add(a : NetprotoquicView, b : NetprotoquicView) -> NetprotoquicView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_proto_quic_view_copy(s : NetprotoquicView) -> NetprotoquicView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_proto_quic_view_fill(s : NetprotoquicView, v : Double) -> NetprotoquicView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_proto_quic_view_min(s : NetprotoquicView) -> Double { @_common.min(s.data) }

pub fn net_proto_quic_view_max(s : NetprotoquicView) -> Double { @_common.max(s.data) }

pub fn net_proto_quic_view_to_string(s : NetprotoquicView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotoquicRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_quic_range_make(size : Int) -> NetprotoquicRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_quic_range_len(s : NetprotoquicRange) -> Int { s.size }

pub fn net_proto_quic_range_get(s : NetprotoquicRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_quic_range_set(s : NetprotoquicRange, i : Int, v : Double) -> NetprotoquicRange {
  let result = net_proto_quic_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_proto_quic_range_sum(s : NetprotoquicRange) -> Double { @_common.sum(s.data) }

pub fn net_proto_quic_range_mean(s : NetprotoquicRange) -> Double { @_common.mean(s.data) }

pub fn net_proto_quic_range_scale(s : NetprotoquicRange, f : Double) -> NetprotoquicRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_proto_quic_range_add(a : NetprotoquicRange, b : NetprotoquicRange) -> NetprotoquicRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_proto_quic_range_copy(s : NetprotoquicRange) -> NetprotoquicRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_proto_quic_range_fill(s : NetprotoquicRange, v : Double) -> NetprotoquicRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_proto_quic_range_min(s : NetprotoquicRange) -> Double { @_common.min(s.data) }

pub fn net_proto_quic_range_max(s : NetprotoquicRange) -> Double { @_common.max(s.data) }

pub fn net_proto_quic_range_to_string(s : NetprotoquicRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotoquicSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_quic_slice_make(size : Int) -> NetprotoquicSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_quic_slice_len(s : NetprotoquicSlice) -> Int { s.size }

pub fn net_proto_quic_slice_get(s : NetprotoquicSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_quic_slice_set(s : NetprotoquicSlice, i : Int, v : Double) -> NetprotoquicSlice {
  let result = net_proto_quic_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_proto_quic_slice_sum(s : NetprotoquicSlice) -> Double { @_common.sum(s.data) }

pub fn net_proto_quic_slice_mean(s : NetprotoquicSlice) -> Double { @_common.mean(s.data) }

pub fn net_proto_quic_slice_scale(s : NetprotoquicSlice, f : Double) -> NetprotoquicSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_proto_quic_slice_add(a : NetprotoquicSlice, b : NetprotoquicSlice) -> NetprotoquicSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_proto_quic_slice_copy(s : NetprotoquicSlice) -> NetprotoquicSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_proto_quic_slice_fill(s : NetprotoquicSlice, v : Double) -> NetprotoquicSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_proto_quic_slice_min(s : NetprotoquicSlice) -> Double { @_common.min(s.data) }

pub fn net_proto_quic_slice_max(s : NetprotoquicSlice) -> Double { @_common.max(s.data) }

pub fn net_proto_quic_slice_to_string(s : NetprotoquicSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

