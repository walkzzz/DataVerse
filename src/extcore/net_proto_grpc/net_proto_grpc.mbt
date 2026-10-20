///===
/// extcore/net_proto_grpc

pub(all) struct NetprotogrpcPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn net_proto_grpc_make_point(x : Double, y : Double) -> NetprotogrpcPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn net_proto_grpc_make_point3(x : Double, y : Double, z : Double) -> NetprotogrpcPoint {
  { x, y, z, label: 0 }
}

pub fn net_proto_grpc_point_x(pt : NetprotogrpcPoint) -> Double { pt.x }

pub fn net_proto_grpc_point_y(pt : NetprotogrpcPoint) -> Double { pt.y }

pub fn net_proto_grpc_point_z(pt : NetprotogrpcPoint) -> Double { pt.z }

pub fn net_proto_grpc_point_label(pt : NetprotogrpcPoint) -> Int { pt.label }

pub fn net_proto_grpc_point_dist(a : NetprotogrpcPoint, b : NetprotogrpcPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn net_proto_grpc_point_add(a : NetprotogrpcPoint, b : NetprotogrpcPoint) -> NetprotogrpcPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn net_proto_grpc_point_sub(a : NetprotogrpcPoint, b : NetprotogrpcPoint) -> NetprotogrpcPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn net_proto_grpc_point_scale(pt : NetprotogrpcPoint, s : Double) -> NetprotogrpcPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn net_proto_grpc_point_dot(a : NetprotogrpcPoint, b : NetprotogrpcPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn net_proto_grpc_point_cross(a : NetprotogrpcPoint, b : NetprotogrpcPoint) -> NetprotogrpcPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn net_proto_grpc_point_norm(pt : NetprotogrpcPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn net_proto_grpc_point_normalize(pt : NetprotogrpcPoint) -> NetprotogrpcPoint {
  let n = net_proto_grpc_point_norm(pt)
  if n < 0.0000001 { pt } else { net_proto_grpc_point_scale(pt, 1.0 / n) }
}

pub fn net_proto_grpc_point_negate(pt : NetprotogrpcPoint) -> NetprotogrpcPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn net_proto_grpc_point_mid(a : NetprotogrpcPoint, b : NetprotogrpcPoint) -> NetprotogrpcPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn net_proto_grpc_point_lerp(a : NetprotogrpcPoint, b : NetprotogrpcPoint, t : Double) -> NetprotogrpcPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn net_proto_grpc_point_to_string(pt : NetprotogrpcPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct NetprotogrpcSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn net_proto_grpc_make_series(vals : Array[Double], name : String) -> NetprotogrpcSeries {
  { vals, name, meta: 0 }
}

pub fn net_proto_grpc_series_len(s : NetprotogrpcSeries) -> Int { s.vals.length() }

pub fn net_proto_grpc_series_sum(s : NetprotogrpcSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn net_proto_grpc_series_mean(s : NetprotogrpcSeries) -> Double { @_common.mean(s.vals) }

pub fn net_proto_grpc_series_min(s : NetprotogrpcSeries) -> Double { @_common.min(s.vals) }

pub fn net_proto_grpc_series_max(s : NetprotogrpcSeries) -> Double { @_common.max(s.vals) }

pub fn net_proto_grpc_series_range(s : NetprotogrpcSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn net_proto_grpc_series_var(s : NetprotogrpcSeries) -> Double { @_common.variance(s.vals) }

pub fn net_proto_grpc_series_std(s : NetprotogrpcSeries) -> Double { @_common.std(s.vals) }

pub fn net_proto_grpc_series_median(s : NetprotogrpcSeries) -> Double { @_common.median(s.vals) }

pub fn net_proto_grpc_series_scale(s : NetprotogrpcSeries, f : Double) -> NetprotogrpcSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn net_proto_grpc_series_add(a : NetprotogrpcSeries, b : NetprotogrpcSeries) -> NetprotogrpcSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn net_proto_grpc_series_sub(a : NetprotogrpcSeries, b : NetprotogrpcSeries) -> NetprotogrpcSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn net_proto_grpc_series_normalize(s : NetprotogrpcSeries) -> NetprotogrpcSeries {
  let mn = net_proto_grpc_series_min(s)
  let mx = net_proto_grpc_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn net_proto_grpc_series_cumsum(s : NetprotogrpcSeries) -> NetprotogrpcSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn net_proto_grpc_series_to_string(s : NetprotogrpcSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NetprotogrpcMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn net_proto_grpc_make_matrix(rows : Int, cols : Int, val : Double) -> NetprotogrpcMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn net_proto_grpc_matrix_identity(n : Int) -> NetprotogrpcMatrix {
  let m = net_proto_grpc_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn net_proto_grpc_matrix_get(m : NetprotogrpcMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn net_proto_grpc_matrix_transpose(m : NetprotogrpcMatrix) -> NetprotogrpcMatrix {
  let result = net_proto_grpc_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn net_proto_grpc_matrix_add(a : NetprotogrpcMatrix, b : NetprotogrpcMatrix) -> NetprotogrpcMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = net_proto_grpc_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn net_proto_grpc_matrix_scale(m : NetprotogrpcMatrix, s : Double) -> NetprotogrpcMatrix {
  let result = net_proto_grpc_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn net_proto_grpc_matrix_multiply(a : NetprotogrpcMatrix, b : NetprotogrpcMatrix) -> NetprotogrpcMatrix {
  if a.cols != b.rows { return net_proto_grpc_make_matrix(a.rows, b.cols, 0.0) }
  let result = net_proto_grpc_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn net_proto_grpc_matrix_trace(m : NetprotogrpcMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn net_proto_grpc_matrix_det(m : NetprotogrpcMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn net_proto_grpc_matrix_norm(m : NetprotogrpcMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn net_proto_grpc_matrix_to_string(m : NetprotogrpcMatrix) -> String {
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

pub(all) struct NetprotogrpcVector {
  comps : Array[Double]
  dim : Int
}

pub fn net_proto_grpc_make_vector(comps : Array[Double]) -> NetprotogrpcVector {
  { comps, dim: comps.length() }
}

pub fn net_proto_grpc_vector_zero(dim : Int) -> NetprotogrpcVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn net_proto_grpc_vector_add(a : NetprotogrpcVector, b : NetprotogrpcVector) -> NetprotogrpcVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn net_proto_grpc_vector_sub(a : NetprotogrpcVector, b : NetprotogrpcVector) -> NetprotogrpcVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn net_proto_grpc_vector_scale(v : NetprotogrpcVector, s : Double) -> NetprotogrpcVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn net_proto_grpc_vector_dot(a : NetprotogrpcVector, b : NetprotogrpcVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn net_proto_grpc_vector_norm(v : NetprotogrpcVector) -> Double { @_common.sqrt(net_proto_grpc_vector_dot(v, v)) }

pub fn net_proto_grpc_vector_normalize(v : NetprotogrpcVector) -> NetprotogrpcVector {
  let n = net_proto_grpc_vector_norm(v)
  if n < 0.0000001 { v } else { net_proto_grpc_vector_scale(v, 1.0 / n) }
}

pub fn net_proto_grpc_vector_dist(a : NetprotogrpcVector, b : NetprotogrpcVector) -> Double {
  net_proto_grpc_vector_norm(net_proto_grpc_vector_sub(a, b))
}

pub fn net_proto_grpc_vector_to_string(v : NetprotogrpcVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn net_proto_grpc_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn net_proto_grpc_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn net_proto_grpc_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn net_proto_grpc_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn net_proto_grpc_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn net_proto_grpc_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn net_proto_grpc_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn net_proto_grpc_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn net_proto_grpc_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn net_proto_grpc_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn net_proto_grpc_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn net_proto_grpc_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn net_proto_grpc_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn net_proto_grpc_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn net_proto_grpc_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn net_proto_grpc_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn net_proto_grpc_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn net_proto_grpc_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn net_proto_grpc_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn net_proto_grpc_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn net_proto_grpc_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn net_proto_grpc_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn net_proto_grpc_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn net_proto_grpc_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn net_proto_grpc_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn net_proto_grpc_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn net_proto_grpc_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn net_proto_grpc_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn net_proto_grpc_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct NetprotogrpcFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_grpc_frame_make(size : Int) -> NetprotogrpcFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_grpc_frame_len(s : NetprotogrpcFrame) -> Int { s.size }

pub fn net_proto_grpc_frame_get(s : NetprotogrpcFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_grpc_frame_set(s : NetprotogrpcFrame, i : Int, v : Double) -> NetprotogrpcFrame {
  let result = net_proto_grpc_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_proto_grpc_frame_sum(s : NetprotogrpcFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_proto_grpc_frame_mean(s : NetprotogrpcFrame) -> Double {
  if s.size == 0 { 0.0 } else { net_proto_grpc_frame_sum(s) / s.size.to_double() }
}

pub fn net_proto_grpc_frame_scale(s : NetprotogrpcFrame, f : Double) -> NetprotogrpcFrame {
  let result = net_proto_grpc_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_proto_grpc_frame_add(a : NetprotogrpcFrame, b : NetprotogrpcFrame) -> NetprotogrpcFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_proto_grpc_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_proto_grpc_frame_copy(s : NetprotogrpcFrame) -> NetprotogrpcFrame {
  let result = net_proto_grpc_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_proto_grpc_frame_fill(s : NetprotogrpcFrame, v : Double) -> NetprotogrpcFrame {
  let result = net_proto_grpc_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_proto_grpc_frame_min(s : NetprotogrpcFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_grpc_frame_max(s : NetprotogrpcFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_grpc_frame_to_string(s : NetprotogrpcFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotogrpcTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_grpc_table_make(size : Int) -> NetprotogrpcTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_grpc_table_len(s : NetprotogrpcTable) -> Int { s.size }

pub fn net_proto_grpc_table_get(s : NetprotogrpcTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_grpc_table_set(s : NetprotogrpcTable, i : Int, v : Double) -> NetprotogrpcTable {
  let result = net_proto_grpc_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_proto_grpc_table_sum(s : NetprotogrpcTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_proto_grpc_table_mean(s : NetprotogrpcTable) -> Double {
  if s.size == 0 { 0.0 } else { net_proto_grpc_table_sum(s) / s.size.to_double() }
}

pub fn net_proto_grpc_table_scale(s : NetprotogrpcTable, f : Double) -> NetprotogrpcTable {
  let result = net_proto_grpc_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_proto_grpc_table_add(a : NetprotogrpcTable, b : NetprotogrpcTable) -> NetprotogrpcTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_proto_grpc_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_proto_grpc_table_copy(s : NetprotogrpcTable) -> NetprotogrpcTable {
  let result = net_proto_grpc_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_proto_grpc_table_fill(s : NetprotogrpcTable, v : Double) -> NetprotogrpcTable {
  let result = net_proto_grpc_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_proto_grpc_table_min(s : NetprotogrpcTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_grpc_table_max(s : NetprotogrpcTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_grpc_table_to_string(s : NetprotogrpcTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotogrpcGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_grpc_graphn_make(size : Int) -> NetprotogrpcGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_grpc_graphn_len(s : NetprotogrpcGraphN) -> Int { s.size }

pub fn net_proto_grpc_graphn_get(s : NetprotogrpcGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_grpc_graphn_set(s : NetprotogrpcGraphN, i : Int, v : Double) -> NetprotogrpcGraphN {
  let result = net_proto_grpc_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_proto_grpc_graphn_sum(s : NetprotogrpcGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_proto_grpc_graphn_mean(s : NetprotogrpcGraphN) -> Double {
  if s.size == 0 { 0.0 } else { net_proto_grpc_graphn_sum(s) / s.size.to_double() }
}

pub fn net_proto_grpc_graphn_scale(s : NetprotogrpcGraphN, f : Double) -> NetprotogrpcGraphN {
  let result = net_proto_grpc_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_proto_grpc_graphn_add(a : NetprotogrpcGraphN, b : NetprotogrpcGraphN) -> NetprotogrpcGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_proto_grpc_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_proto_grpc_graphn_copy(s : NetprotogrpcGraphN) -> NetprotogrpcGraphN {
  let result = net_proto_grpc_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_proto_grpc_graphn_fill(s : NetprotogrpcGraphN, v : Double) -> NetprotogrpcGraphN {
  let result = net_proto_grpc_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_proto_grpc_graphn_min(s : NetprotogrpcGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_grpc_graphn_max(s : NetprotogrpcGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_grpc_graphn_to_string(s : NetprotogrpcGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotogrpcNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_grpc_node_make(size : Int) -> NetprotogrpcNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_grpc_node_len(s : NetprotogrpcNode) -> Int { s.size }

pub fn net_proto_grpc_node_get(s : NetprotogrpcNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_grpc_node_set(s : NetprotogrpcNode, i : Int, v : Double) -> NetprotogrpcNode {
  let result = net_proto_grpc_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_proto_grpc_node_sum(s : NetprotogrpcNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_proto_grpc_node_mean(s : NetprotogrpcNode) -> Double {
  if s.size == 0 { 0.0 } else { net_proto_grpc_node_sum(s) / s.size.to_double() }
}

pub fn net_proto_grpc_node_scale(s : NetprotogrpcNode, f : Double) -> NetprotogrpcNode {
  let result = net_proto_grpc_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_proto_grpc_node_add(a : NetprotogrpcNode, b : NetprotogrpcNode) -> NetprotogrpcNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_proto_grpc_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_proto_grpc_node_copy(s : NetprotogrpcNode) -> NetprotogrpcNode {
  let result = net_proto_grpc_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_proto_grpc_node_fill(s : NetprotogrpcNode, v : Double) -> NetprotogrpcNode {
  let result = net_proto_grpc_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_proto_grpc_node_min(s : NetprotogrpcNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_grpc_node_max(s : NetprotogrpcNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_grpc_node_to_string(s : NetprotogrpcNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotogrpcEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_grpc_edge_make(size : Int) -> NetprotogrpcEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_grpc_edge_len(s : NetprotogrpcEdge) -> Int { s.size }

pub fn net_proto_grpc_edge_get(s : NetprotogrpcEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_grpc_edge_set(s : NetprotogrpcEdge, i : Int, v : Double) -> NetprotogrpcEdge {
  let result = net_proto_grpc_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_proto_grpc_edge_sum(s : NetprotogrpcEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_proto_grpc_edge_mean(s : NetprotogrpcEdge) -> Double {
  if s.size == 0 { 0.0 } else { net_proto_grpc_edge_sum(s) / s.size.to_double() }
}

pub fn net_proto_grpc_edge_scale(s : NetprotogrpcEdge, f : Double) -> NetprotogrpcEdge {
  let result = net_proto_grpc_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_proto_grpc_edge_add(a : NetprotogrpcEdge, b : NetprotogrpcEdge) -> NetprotogrpcEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_proto_grpc_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_proto_grpc_edge_copy(s : NetprotogrpcEdge) -> NetprotogrpcEdge {
  let result = net_proto_grpc_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_proto_grpc_edge_fill(s : NetprotogrpcEdge, v : Double) -> NetprotogrpcEdge {
  let result = net_proto_grpc_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_proto_grpc_edge_min(s : NetprotogrpcEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_grpc_edge_max(s : NetprotogrpcEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_grpc_edge_to_string(s : NetprotogrpcEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotogrpcPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_grpc_path_make(size : Int) -> NetprotogrpcPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_grpc_path_len(s : NetprotogrpcPath) -> Int { s.size }

pub fn net_proto_grpc_path_get(s : NetprotogrpcPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_grpc_path_set(s : NetprotogrpcPath, i : Int, v : Double) -> NetprotogrpcPath {
  let result = net_proto_grpc_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_proto_grpc_path_sum(s : NetprotogrpcPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_proto_grpc_path_mean(s : NetprotogrpcPath) -> Double {
  if s.size == 0 { 0.0 } else { net_proto_grpc_path_sum(s) / s.size.to_double() }
}

pub fn net_proto_grpc_path_scale(s : NetprotogrpcPath, f : Double) -> NetprotogrpcPath {
  let result = net_proto_grpc_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_proto_grpc_path_add(a : NetprotogrpcPath, b : NetprotogrpcPath) -> NetprotogrpcPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_proto_grpc_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_proto_grpc_path_copy(s : NetprotogrpcPath) -> NetprotogrpcPath {
  let result = net_proto_grpc_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_proto_grpc_path_fill(s : NetprotogrpcPath, v : Double) -> NetprotogrpcPath {
  let result = net_proto_grpc_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_proto_grpc_path_min(s : NetprotogrpcPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_grpc_path_max(s : NetprotogrpcPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_grpc_path_to_string(s : NetprotogrpcPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotogrpcCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_grpc_cluster_make(size : Int) -> NetprotogrpcCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_grpc_cluster_len(s : NetprotogrpcCluster) -> Int { s.size }

pub fn net_proto_grpc_cluster_get(s : NetprotogrpcCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_grpc_cluster_set(s : NetprotogrpcCluster, i : Int, v : Double) -> NetprotogrpcCluster {
  let result = net_proto_grpc_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_proto_grpc_cluster_sum(s : NetprotogrpcCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_proto_grpc_cluster_mean(s : NetprotogrpcCluster) -> Double {
  if s.size == 0 { 0.0 } else { net_proto_grpc_cluster_sum(s) / s.size.to_double() }
}

pub fn net_proto_grpc_cluster_scale(s : NetprotogrpcCluster, f : Double) -> NetprotogrpcCluster {
  let result = net_proto_grpc_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_proto_grpc_cluster_add(a : NetprotogrpcCluster, b : NetprotogrpcCluster) -> NetprotogrpcCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_proto_grpc_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_proto_grpc_cluster_copy(s : NetprotogrpcCluster) -> NetprotogrpcCluster {
  let result = net_proto_grpc_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_proto_grpc_cluster_fill(s : NetprotogrpcCluster, v : Double) -> NetprotogrpcCluster {
  let result = net_proto_grpc_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_proto_grpc_cluster_min(s : NetprotogrpcCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_grpc_cluster_max(s : NetprotogrpcCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_grpc_cluster_to_string(s : NetprotogrpcCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotogrpcModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_grpc_model_make(size : Int) -> NetprotogrpcModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_grpc_model_len(s : NetprotogrpcModel) -> Int { s.size }

pub fn net_proto_grpc_model_get(s : NetprotogrpcModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_grpc_model_set(s : NetprotogrpcModel, i : Int, v : Double) -> NetprotogrpcModel {
  let result = net_proto_grpc_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_proto_grpc_model_sum(s : NetprotogrpcModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_proto_grpc_model_mean(s : NetprotogrpcModel) -> Double {
  if s.size == 0 { 0.0 } else { net_proto_grpc_model_sum(s) / s.size.to_double() }
}

pub fn net_proto_grpc_model_scale(s : NetprotogrpcModel, f : Double) -> NetprotogrpcModel {
  let result = net_proto_grpc_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_proto_grpc_model_add(a : NetprotogrpcModel, b : NetprotogrpcModel) -> NetprotogrpcModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_proto_grpc_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_proto_grpc_model_copy(s : NetprotogrpcModel) -> NetprotogrpcModel {
  let result = net_proto_grpc_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_proto_grpc_model_fill(s : NetprotogrpcModel, v : Double) -> NetprotogrpcModel {
  let result = net_proto_grpc_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_proto_grpc_model_min(s : NetprotogrpcModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_grpc_model_max(s : NetprotogrpcModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_grpc_model_to_string(s : NetprotogrpcModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotogrpcLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_grpc_layer_make(size : Int) -> NetprotogrpcLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_grpc_layer_len(s : NetprotogrpcLayer) -> Int { s.size }

pub fn net_proto_grpc_layer_get(s : NetprotogrpcLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_grpc_layer_set(s : NetprotogrpcLayer, i : Int, v : Double) -> NetprotogrpcLayer {
  let result = net_proto_grpc_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_proto_grpc_layer_sum(s : NetprotogrpcLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_proto_grpc_layer_mean(s : NetprotogrpcLayer) -> Double {
  if s.size == 0 { 0.0 } else { net_proto_grpc_layer_sum(s) / s.size.to_double() }
}

pub fn net_proto_grpc_layer_scale(s : NetprotogrpcLayer, f : Double) -> NetprotogrpcLayer {
  let result = net_proto_grpc_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_proto_grpc_layer_add(a : NetprotogrpcLayer, b : NetprotogrpcLayer) -> NetprotogrpcLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_proto_grpc_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_proto_grpc_layer_copy(s : NetprotogrpcLayer) -> NetprotogrpcLayer {
  let result = net_proto_grpc_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_proto_grpc_layer_fill(s : NetprotogrpcLayer, v : Double) -> NetprotogrpcLayer {
  let result = net_proto_grpc_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_proto_grpc_layer_min(s : NetprotogrpcLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_grpc_layer_max(s : NetprotogrpcLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_grpc_layer_to_string(s : NetprotogrpcLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotogrpcBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_grpc_buffer_make(size : Int) -> NetprotogrpcBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_grpc_buffer_len(s : NetprotogrpcBuffer) -> Int { s.size }

pub fn net_proto_grpc_buffer_get(s : NetprotogrpcBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_grpc_buffer_set(s : NetprotogrpcBuffer, i : Int, v : Double) -> NetprotogrpcBuffer {
  let result = net_proto_grpc_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_proto_grpc_buffer_sum(s : NetprotogrpcBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_proto_grpc_buffer_mean(s : NetprotogrpcBuffer) -> Double {
  if s.size == 0 { 0.0 } else { net_proto_grpc_buffer_sum(s) / s.size.to_double() }
}

pub fn net_proto_grpc_buffer_scale(s : NetprotogrpcBuffer, f : Double) -> NetprotogrpcBuffer {
  let result = net_proto_grpc_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_proto_grpc_buffer_add(a : NetprotogrpcBuffer, b : NetprotogrpcBuffer) -> NetprotogrpcBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_proto_grpc_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_proto_grpc_buffer_copy(s : NetprotogrpcBuffer) -> NetprotogrpcBuffer {
  let result = net_proto_grpc_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_proto_grpc_buffer_fill(s : NetprotogrpcBuffer, v : Double) -> NetprotogrpcBuffer {
  let result = net_proto_grpc_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_proto_grpc_buffer_min(s : NetprotogrpcBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_grpc_buffer_max(s : NetprotogrpcBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_grpc_buffer_to_string(s : NetprotogrpcBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotogrpcCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_grpc_cursor_make(size : Int) -> NetprotogrpcCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_grpc_cursor_len(s : NetprotogrpcCursor) -> Int { s.size }

pub fn net_proto_grpc_cursor_get(s : NetprotogrpcCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_grpc_cursor_set(s : NetprotogrpcCursor, i : Int, v : Double) -> NetprotogrpcCursor {
  let result = net_proto_grpc_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_proto_grpc_cursor_sum(s : NetprotogrpcCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_proto_grpc_cursor_mean(s : NetprotogrpcCursor) -> Double {
  if s.size == 0 { 0.0 } else { net_proto_grpc_cursor_sum(s) / s.size.to_double() }
}

pub fn net_proto_grpc_cursor_scale(s : NetprotogrpcCursor, f : Double) -> NetprotogrpcCursor {
  let result = net_proto_grpc_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_proto_grpc_cursor_add(a : NetprotogrpcCursor, b : NetprotogrpcCursor) -> NetprotogrpcCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_proto_grpc_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_proto_grpc_cursor_copy(s : NetprotogrpcCursor) -> NetprotogrpcCursor {
  let result = net_proto_grpc_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_proto_grpc_cursor_fill(s : NetprotogrpcCursor, v : Double) -> NetprotogrpcCursor {
  let result = net_proto_grpc_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_proto_grpc_cursor_min(s : NetprotogrpcCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_grpc_cursor_max(s : NetprotogrpcCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_grpc_cursor_to_string(s : NetprotogrpcCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotogrpcView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_grpc_view_make(size : Int) -> NetprotogrpcView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_grpc_view_len(s : NetprotogrpcView) -> Int { s.size }

pub fn net_proto_grpc_view_get(s : NetprotogrpcView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_grpc_view_set(s : NetprotogrpcView, i : Int, v : Double) -> NetprotogrpcView {
  let result = net_proto_grpc_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_proto_grpc_view_sum(s : NetprotogrpcView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_proto_grpc_view_mean(s : NetprotogrpcView) -> Double {
  if s.size == 0 { 0.0 } else { net_proto_grpc_view_sum(s) / s.size.to_double() }
}

pub fn net_proto_grpc_view_scale(s : NetprotogrpcView, f : Double) -> NetprotogrpcView {
  let result = net_proto_grpc_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_proto_grpc_view_add(a : NetprotogrpcView, b : NetprotogrpcView) -> NetprotogrpcView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_proto_grpc_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_proto_grpc_view_copy(s : NetprotogrpcView) -> NetprotogrpcView {
  let result = net_proto_grpc_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_proto_grpc_view_fill(s : NetprotogrpcView, v : Double) -> NetprotogrpcView {
  let result = net_proto_grpc_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_proto_grpc_view_min(s : NetprotogrpcView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_grpc_view_max(s : NetprotogrpcView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_grpc_view_to_string(s : NetprotogrpcView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotogrpcRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_grpc_range_make(size : Int) -> NetprotogrpcRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_grpc_range_len(s : NetprotogrpcRange) -> Int { s.size }

pub fn net_proto_grpc_range_get(s : NetprotogrpcRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_grpc_range_set(s : NetprotogrpcRange, i : Int, v : Double) -> NetprotogrpcRange {
  let result = net_proto_grpc_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_proto_grpc_range_sum(s : NetprotogrpcRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_proto_grpc_range_mean(s : NetprotogrpcRange) -> Double {
  if s.size == 0 { 0.0 } else { net_proto_grpc_range_sum(s) / s.size.to_double() }
}

pub fn net_proto_grpc_range_scale(s : NetprotogrpcRange, f : Double) -> NetprotogrpcRange {
  let result = net_proto_grpc_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_proto_grpc_range_add(a : NetprotogrpcRange, b : NetprotogrpcRange) -> NetprotogrpcRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_proto_grpc_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_proto_grpc_range_copy(s : NetprotogrpcRange) -> NetprotogrpcRange {
  let result = net_proto_grpc_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_proto_grpc_range_fill(s : NetprotogrpcRange, v : Double) -> NetprotogrpcRange {
  let result = net_proto_grpc_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_proto_grpc_range_min(s : NetprotogrpcRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_grpc_range_max(s : NetprotogrpcRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_grpc_range_to_string(s : NetprotogrpcRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotogrpcSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_grpc_slice_make(size : Int) -> NetprotogrpcSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_grpc_slice_len(s : NetprotogrpcSlice) -> Int { s.size }

pub fn net_proto_grpc_slice_get(s : NetprotogrpcSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_grpc_slice_set(s : NetprotogrpcSlice, i : Int, v : Double) -> NetprotogrpcSlice {
  let result = net_proto_grpc_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_proto_grpc_slice_sum(s : NetprotogrpcSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_proto_grpc_slice_mean(s : NetprotogrpcSlice) -> Double {
  if s.size == 0 { 0.0 } else { net_proto_grpc_slice_sum(s) / s.size.to_double() }
}

pub fn net_proto_grpc_slice_scale(s : NetprotogrpcSlice, f : Double) -> NetprotogrpcSlice {
  let result = net_proto_grpc_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_proto_grpc_slice_add(a : NetprotogrpcSlice, b : NetprotogrpcSlice) -> NetprotogrpcSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_proto_grpc_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_proto_grpc_slice_copy(s : NetprotogrpcSlice) -> NetprotogrpcSlice {
  let result = net_proto_grpc_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_proto_grpc_slice_fill(s : NetprotogrpcSlice, v : Double) -> NetprotogrpcSlice {
  let result = net_proto_grpc_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_proto_grpc_slice_min(s : NetprotogrpcSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_grpc_slice_max(s : NetprotogrpcSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_grpc_slice_to_string(s : NetprotogrpcSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

