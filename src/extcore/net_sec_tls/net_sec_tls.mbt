///===
/// extcore/net_sec_tls

pub(all) struct NetsectlsPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn net_sec_tls_make_point(x : Double, y : Double) -> NetsectlsPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn net_sec_tls_make_point3(x : Double, y : Double, z : Double) -> NetsectlsPoint {
  { x, y, z, label: 0 }
}

pub fn net_sec_tls_point_x(pt : NetsectlsPoint) -> Double { pt.x }

pub fn net_sec_tls_point_y(pt : NetsectlsPoint) -> Double { pt.y }

pub fn net_sec_tls_point_z(pt : NetsectlsPoint) -> Double { pt.z }

pub fn net_sec_tls_point_label(pt : NetsectlsPoint) -> Int { pt.label }

pub fn net_sec_tls_point_dist(a : NetsectlsPoint, b : NetsectlsPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn net_sec_tls_point_add(a : NetsectlsPoint, b : NetsectlsPoint) -> NetsectlsPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn net_sec_tls_point_sub(a : NetsectlsPoint, b : NetsectlsPoint) -> NetsectlsPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn net_sec_tls_point_scale(pt : NetsectlsPoint, s : Double) -> NetsectlsPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn net_sec_tls_point_dot(a : NetsectlsPoint, b : NetsectlsPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn net_sec_tls_point_cross(a : NetsectlsPoint, b : NetsectlsPoint) -> NetsectlsPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn net_sec_tls_point_norm(pt : NetsectlsPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn net_sec_tls_point_normalize(pt : NetsectlsPoint) -> NetsectlsPoint {
  let n = net_sec_tls_point_norm(pt)
  if n < 0.0000001 { pt } else { net_sec_tls_point_scale(pt, 1.0 / n) }
}

pub fn net_sec_tls_point_negate(pt : NetsectlsPoint) -> NetsectlsPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn net_sec_tls_point_mid(a : NetsectlsPoint, b : NetsectlsPoint) -> NetsectlsPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn net_sec_tls_point_lerp(a : NetsectlsPoint, b : NetsectlsPoint, t : Double) -> NetsectlsPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn net_sec_tls_point_to_string(pt : NetsectlsPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct NetsectlsSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn net_sec_tls_make_series(vals : Array[Double], name : String) -> NetsectlsSeries {
  { vals, name, meta: 0 }
}

pub fn net_sec_tls_series_len(s : NetsectlsSeries) -> Int { s.vals.length() }

pub fn net_sec_tls_series_sum(s : NetsectlsSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn net_sec_tls_series_mean(s : NetsectlsSeries) -> Double {
  let n = net_sec_tls_series_len(s)
  if n == 0 { 0.0 } else { net_sec_tls_series_sum(s) / n.to_double() }
}

pub fn net_sec_tls_series_min(s : NetsectlsSeries) -> Double {
  let n = net_sec_tls_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn net_sec_tls_series_max(s : NetsectlsSeries) -> Double {
  let n = net_sec_tls_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn net_sec_tls_series_range(s : NetsectlsSeries) -> Double {
  net_sec_tls_series_max(s) - net_sec_tls_series_min(s)
}

pub fn net_sec_tls_series_var(s : NetsectlsSeries) -> Double {
  let n = net_sec_tls_series_len(s)
  if n == 0 { 0.0 } else {
    let m = net_sec_tls_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn net_sec_tls_series_std(s : NetsectlsSeries) -> Double { @_common.sqrt(net_sec_tls_series_var(s)) }

pub fn net_sec_tls_series_median(s : NetsectlsSeries) -> Double {
  let n = net_sec_tls_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = net_sec_tls_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn net_sec_tls_series_scale(s : NetsectlsSeries, f : Double) -> NetsectlsSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn net_sec_tls_series_add(a : NetsectlsSeries, b : NetsectlsSeries) -> NetsectlsSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn net_sec_tls_series_sub(a : NetsectlsSeries, b : NetsectlsSeries) -> NetsectlsSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn net_sec_tls_series_normalize(s : NetsectlsSeries) -> NetsectlsSeries {
  let mn = net_sec_tls_series_min(s)
  let mx = net_sec_tls_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn net_sec_tls_series_cumsum(s : NetsectlsSeries) -> NetsectlsSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn net_sec_tls_series_to_string(s : NetsectlsSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NetsectlsMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn net_sec_tls_make_matrix(rows : Int, cols : Int, val : Double) -> NetsectlsMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn net_sec_tls_matrix_identity(n : Int) -> NetsectlsMatrix {
  let m = net_sec_tls_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn net_sec_tls_matrix_get(m : NetsectlsMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn net_sec_tls_matrix_transpose(m : NetsectlsMatrix) -> NetsectlsMatrix {
  let result = net_sec_tls_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn net_sec_tls_matrix_add(a : NetsectlsMatrix, b : NetsectlsMatrix) -> NetsectlsMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = net_sec_tls_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn net_sec_tls_matrix_scale(m : NetsectlsMatrix, s : Double) -> NetsectlsMatrix {
  let result = net_sec_tls_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn net_sec_tls_matrix_multiply(a : NetsectlsMatrix, b : NetsectlsMatrix) -> NetsectlsMatrix {
  if a.cols != b.rows { return net_sec_tls_make_matrix(a.rows, b.cols, 0.0) }
  let result = net_sec_tls_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn net_sec_tls_matrix_trace(m : NetsectlsMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn net_sec_tls_matrix_det(m : NetsectlsMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn net_sec_tls_matrix_norm(m : NetsectlsMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn net_sec_tls_matrix_to_string(m : NetsectlsMatrix) -> String {
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

pub(all) struct NetsectlsVector {
  comps : Array[Double]
  dim : Int
}

pub fn net_sec_tls_make_vector(comps : Array[Double]) -> NetsectlsVector {
  { comps, dim: comps.length() }
}

pub fn net_sec_tls_vector_zero(dim : Int) -> NetsectlsVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn net_sec_tls_vector_add(a : NetsectlsVector, b : NetsectlsVector) -> NetsectlsVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn net_sec_tls_vector_sub(a : NetsectlsVector, b : NetsectlsVector) -> NetsectlsVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn net_sec_tls_vector_scale(v : NetsectlsVector, s : Double) -> NetsectlsVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn net_sec_tls_vector_dot(a : NetsectlsVector, b : NetsectlsVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn net_sec_tls_vector_norm(v : NetsectlsVector) -> Double { @_common.sqrt(net_sec_tls_vector_dot(v, v)) }

pub fn net_sec_tls_vector_normalize(v : NetsectlsVector) -> NetsectlsVector {
  let n = net_sec_tls_vector_norm(v)
  if n < 0.0000001 { v } else { net_sec_tls_vector_scale(v, 1.0 / n) }
}

pub fn net_sec_tls_vector_dist(a : NetsectlsVector, b : NetsectlsVector) -> Double {
  net_sec_tls_vector_norm(net_sec_tls_vector_sub(a, b))
}

pub fn net_sec_tls_vector_to_string(v : NetsectlsVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn net_sec_tls_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn net_sec_tls_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn net_sec_tls_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn net_sec_tls_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn net_sec_tls_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn net_sec_tls_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn net_sec_tls_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn net_sec_tls_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn net_sec_tls_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn net_sec_tls_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn net_sec_tls_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn net_sec_tls_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn net_sec_tls_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn net_sec_tls_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn net_sec_tls_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn net_sec_tls_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn net_sec_tls_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn net_sec_tls_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn net_sec_tls_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn net_sec_tls_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn net_sec_tls_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn net_sec_tls_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn net_sec_tls_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn net_sec_tls_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn net_sec_tls_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn net_sec_tls_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn net_sec_tls_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn net_sec_tls_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn net_sec_tls_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct NetsectlsFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_tls_frame_make(size : Int) -> NetsectlsFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_tls_frame_len(s : NetsectlsFrame) -> Int { s.size }

pub fn net_sec_tls_frame_get(s : NetsectlsFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_tls_frame_set(s : NetsectlsFrame, i : Int, v : Double) -> NetsectlsFrame {
  let result = net_sec_tls_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_sec_tls_frame_sum(s : NetsectlsFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_sec_tls_frame_mean(s : NetsectlsFrame) -> Double {
  if s.size == 0 { 0.0 } else { net_sec_tls_frame_sum(s) / s.size.to_double() }
}

pub fn net_sec_tls_frame_scale(s : NetsectlsFrame, f : Double) -> NetsectlsFrame {
  let result = net_sec_tls_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_sec_tls_frame_add(a : NetsectlsFrame, b : NetsectlsFrame) -> NetsectlsFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_sec_tls_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_sec_tls_frame_copy(s : NetsectlsFrame) -> NetsectlsFrame {
  let result = net_sec_tls_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_sec_tls_frame_fill(s : NetsectlsFrame, v : Double) -> NetsectlsFrame {
  let result = net_sec_tls_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_sec_tls_frame_min(s : NetsectlsFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_sec_tls_frame_max(s : NetsectlsFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_sec_tls_frame_to_string(s : NetsectlsFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsectlsTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_tls_table_make(size : Int) -> NetsectlsTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_tls_table_len(s : NetsectlsTable) -> Int { s.size }

pub fn net_sec_tls_table_get(s : NetsectlsTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_tls_table_set(s : NetsectlsTable, i : Int, v : Double) -> NetsectlsTable {
  let result = net_sec_tls_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_sec_tls_table_sum(s : NetsectlsTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_sec_tls_table_mean(s : NetsectlsTable) -> Double {
  if s.size == 0 { 0.0 } else { net_sec_tls_table_sum(s) / s.size.to_double() }
}

pub fn net_sec_tls_table_scale(s : NetsectlsTable, f : Double) -> NetsectlsTable {
  let result = net_sec_tls_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_sec_tls_table_add(a : NetsectlsTable, b : NetsectlsTable) -> NetsectlsTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_sec_tls_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_sec_tls_table_copy(s : NetsectlsTable) -> NetsectlsTable {
  let result = net_sec_tls_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_sec_tls_table_fill(s : NetsectlsTable, v : Double) -> NetsectlsTable {
  let result = net_sec_tls_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_sec_tls_table_min(s : NetsectlsTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_sec_tls_table_max(s : NetsectlsTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_sec_tls_table_to_string(s : NetsectlsTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsectlsGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_tls_graphn_make(size : Int) -> NetsectlsGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_tls_graphn_len(s : NetsectlsGraphN) -> Int { s.size }

pub fn net_sec_tls_graphn_get(s : NetsectlsGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_tls_graphn_set(s : NetsectlsGraphN, i : Int, v : Double) -> NetsectlsGraphN {
  let result = net_sec_tls_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_sec_tls_graphn_sum(s : NetsectlsGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_sec_tls_graphn_mean(s : NetsectlsGraphN) -> Double {
  if s.size == 0 { 0.0 } else { net_sec_tls_graphn_sum(s) / s.size.to_double() }
}

pub fn net_sec_tls_graphn_scale(s : NetsectlsGraphN, f : Double) -> NetsectlsGraphN {
  let result = net_sec_tls_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_sec_tls_graphn_add(a : NetsectlsGraphN, b : NetsectlsGraphN) -> NetsectlsGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_sec_tls_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_sec_tls_graphn_copy(s : NetsectlsGraphN) -> NetsectlsGraphN {
  let result = net_sec_tls_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_sec_tls_graphn_fill(s : NetsectlsGraphN, v : Double) -> NetsectlsGraphN {
  let result = net_sec_tls_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_sec_tls_graphn_min(s : NetsectlsGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_sec_tls_graphn_max(s : NetsectlsGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_sec_tls_graphn_to_string(s : NetsectlsGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsectlsNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_tls_node_make(size : Int) -> NetsectlsNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_tls_node_len(s : NetsectlsNode) -> Int { s.size }

pub fn net_sec_tls_node_get(s : NetsectlsNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_tls_node_set(s : NetsectlsNode, i : Int, v : Double) -> NetsectlsNode {
  let result = net_sec_tls_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_sec_tls_node_sum(s : NetsectlsNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_sec_tls_node_mean(s : NetsectlsNode) -> Double {
  if s.size == 0 { 0.0 } else { net_sec_tls_node_sum(s) / s.size.to_double() }
}

pub fn net_sec_tls_node_scale(s : NetsectlsNode, f : Double) -> NetsectlsNode {
  let result = net_sec_tls_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_sec_tls_node_add(a : NetsectlsNode, b : NetsectlsNode) -> NetsectlsNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_sec_tls_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_sec_tls_node_copy(s : NetsectlsNode) -> NetsectlsNode {
  let result = net_sec_tls_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_sec_tls_node_fill(s : NetsectlsNode, v : Double) -> NetsectlsNode {
  let result = net_sec_tls_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_sec_tls_node_min(s : NetsectlsNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_sec_tls_node_max(s : NetsectlsNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_sec_tls_node_to_string(s : NetsectlsNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsectlsEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_tls_edge_make(size : Int) -> NetsectlsEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_tls_edge_len(s : NetsectlsEdge) -> Int { s.size }

pub fn net_sec_tls_edge_get(s : NetsectlsEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_tls_edge_set(s : NetsectlsEdge, i : Int, v : Double) -> NetsectlsEdge {
  let result = net_sec_tls_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_sec_tls_edge_sum(s : NetsectlsEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_sec_tls_edge_mean(s : NetsectlsEdge) -> Double {
  if s.size == 0 { 0.0 } else { net_sec_tls_edge_sum(s) / s.size.to_double() }
}

pub fn net_sec_tls_edge_scale(s : NetsectlsEdge, f : Double) -> NetsectlsEdge {
  let result = net_sec_tls_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_sec_tls_edge_add(a : NetsectlsEdge, b : NetsectlsEdge) -> NetsectlsEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_sec_tls_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_sec_tls_edge_copy(s : NetsectlsEdge) -> NetsectlsEdge {
  let result = net_sec_tls_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_sec_tls_edge_fill(s : NetsectlsEdge, v : Double) -> NetsectlsEdge {
  let result = net_sec_tls_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_sec_tls_edge_min(s : NetsectlsEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_sec_tls_edge_max(s : NetsectlsEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_sec_tls_edge_to_string(s : NetsectlsEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsectlsPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_tls_path_make(size : Int) -> NetsectlsPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_tls_path_len(s : NetsectlsPath) -> Int { s.size }

pub fn net_sec_tls_path_get(s : NetsectlsPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_tls_path_set(s : NetsectlsPath, i : Int, v : Double) -> NetsectlsPath {
  let result = net_sec_tls_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_sec_tls_path_sum(s : NetsectlsPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_sec_tls_path_mean(s : NetsectlsPath) -> Double {
  if s.size == 0 { 0.0 } else { net_sec_tls_path_sum(s) / s.size.to_double() }
}

pub fn net_sec_tls_path_scale(s : NetsectlsPath, f : Double) -> NetsectlsPath {
  let result = net_sec_tls_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_sec_tls_path_add(a : NetsectlsPath, b : NetsectlsPath) -> NetsectlsPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_sec_tls_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_sec_tls_path_copy(s : NetsectlsPath) -> NetsectlsPath {
  let result = net_sec_tls_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_sec_tls_path_fill(s : NetsectlsPath, v : Double) -> NetsectlsPath {
  let result = net_sec_tls_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_sec_tls_path_min(s : NetsectlsPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_sec_tls_path_max(s : NetsectlsPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_sec_tls_path_to_string(s : NetsectlsPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsectlsCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_tls_cluster_make(size : Int) -> NetsectlsCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_tls_cluster_len(s : NetsectlsCluster) -> Int { s.size }

pub fn net_sec_tls_cluster_get(s : NetsectlsCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_tls_cluster_set(s : NetsectlsCluster, i : Int, v : Double) -> NetsectlsCluster {
  let result = net_sec_tls_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_sec_tls_cluster_sum(s : NetsectlsCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_sec_tls_cluster_mean(s : NetsectlsCluster) -> Double {
  if s.size == 0 { 0.0 } else { net_sec_tls_cluster_sum(s) / s.size.to_double() }
}

pub fn net_sec_tls_cluster_scale(s : NetsectlsCluster, f : Double) -> NetsectlsCluster {
  let result = net_sec_tls_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_sec_tls_cluster_add(a : NetsectlsCluster, b : NetsectlsCluster) -> NetsectlsCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_sec_tls_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_sec_tls_cluster_copy(s : NetsectlsCluster) -> NetsectlsCluster {
  let result = net_sec_tls_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_sec_tls_cluster_fill(s : NetsectlsCluster, v : Double) -> NetsectlsCluster {
  let result = net_sec_tls_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_sec_tls_cluster_min(s : NetsectlsCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_sec_tls_cluster_max(s : NetsectlsCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_sec_tls_cluster_to_string(s : NetsectlsCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsectlsModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_tls_model_make(size : Int) -> NetsectlsModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_tls_model_len(s : NetsectlsModel) -> Int { s.size }

pub fn net_sec_tls_model_get(s : NetsectlsModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_tls_model_set(s : NetsectlsModel, i : Int, v : Double) -> NetsectlsModel {
  let result = net_sec_tls_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_sec_tls_model_sum(s : NetsectlsModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_sec_tls_model_mean(s : NetsectlsModel) -> Double {
  if s.size == 0 { 0.0 } else { net_sec_tls_model_sum(s) / s.size.to_double() }
}

pub fn net_sec_tls_model_scale(s : NetsectlsModel, f : Double) -> NetsectlsModel {
  let result = net_sec_tls_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_sec_tls_model_add(a : NetsectlsModel, b : NetsectlsModel) -> NetsectlsModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_sec_tls_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_sec_tls_model_copy(s : NetsectlsModel) -> NetsectlsModel {
  let result = net_sec_tls_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_sec_tls_model_fill(s : NetsectlsModel, v : Double) -> NetsectlsModel {
  let result = net_sec_tls_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_sec_tls_model_min(s : NetsectlsModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_sec_tls_model_max(s : NetsectlsModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_sec_tls_model_to_string(s : NetsectlsModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsectlsLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_tls_layer_make(size : Int) -> NetsectlsLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_tls_layer_len(s : NetsectlsLayer) -> Int { s.size }

pub fn net_sec_tls_layer_get(s : NetsectlsLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_tls_layer_set(s : NetsectlsLayer, i : Int, v : Double) -> NetsectlsLayer {
  let result = net_sec_tls_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_sec_tls_layer_sum(s : NetsectlsLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_sec_tls_layer_mean(s : NetsectlsLayer) -> Double {
  if s.size == 0 { 0.0 } else { net_sec_tls_layer_sum(s) / s.size.to_double() }
}

pub fn net_sec_tls_layer_scale(s : NetsectlsLayer, f : Double) -> NetsectlsLayer {
  let result = net_sec_tls_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_sec_tls_layer_add(a : NetsectlsLayer, b : NetsectlsLayer) -> NetsectlsLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_sec_tls_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_sec_tls_layer_copy(s : NetsectlsLayer) -> NetsectlsLayer {
  let result = net_sec_tls_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_sec_tls_layer_fill(s : NetsectlsLayer, v : Double) -> NetsectlsLayer {
  let result = net_sec_tls_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_sec_tls_layer_min(s : NetsectlsLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_sec_tls_layer_max(s : NetsectlsLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_sec_tls_layer_to_string(s : NetsectlsLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsectlsBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_tls_buffer_make(size : Int) -> NetsectlsBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_tls_buffer_len(s : NetsectlsBuffer) -> Int { s.size }

pub fn net_sec_tls_buffer_get(s : NetsectlsBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_tls_buffer_set(s : NetsectlsBuffer, i : Int, v : Double) -> NetsectlsBuffer {
  let result = net_sec_tls_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_sec_tls_buffer_sum(s : NetsectlsBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_sec_tls_buffer_mean(s : NetsectlsBuffer) -> Double {
  if s.size == 0 { 0.0 } else { net_sec_tls_buffer_sum(s) / s.size.to_double() }
}

pub fn net_sec_tls_buffer_scale(s : NetsectlsBuffer, f : Double) -> NetsectlsBuffer {
  let result = net_sec_tls_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_sec_tls_buffer_add(a : NetsectlsBuffer, b : NetsectlsBuffer) -> NetsectlsBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_sec_tls_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_sec_tls_buffer_copy(s : NetsectlsBuffer) -> NetsectlsBuffer {
  let result = net_sec_tls_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_sec_tls_buffer_fill(s : NetsectlsBuffer, v : Double) -> NetsectlsBuffer {
  let result = net_sec_tls_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_sec_tls_buffer_min(s : NetsectlsBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_sec_tls_buffer_max(s : NetsectlsBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_sec_tls_buffer_to_string(s : NetsectlsBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsectlsCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_tls_cursor_make(size : Int) -> NetsectlsCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_tls_cursor_len(s : NetsectlsCursor) -> Int { s.size }

pub fn net_sec_tls_cursor_get(s : NetsectlsCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_tls_cursor_set(s : NetsectlsCursor, i : Int, v : Double) -> NetsectlsCursor {
  let result = net_sec_tls_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_sec_tls_cursor_sum(s : NetsectlsCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_sec_tls_cursor_mean(s : NetsectlsCursor) -> Double {
  if s.size == 0 { 0.0 } else { net_sec_tls_cursor_sum(s) / s.size.to_double() }
}

pub fn net_sec_tls_cursor_scale(s : NetsectlsCursor, f : Double) -> NetsectlsCursor {
  let result = net_sec_tls_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_sec_tls_cursor_add(a : NetsectlsCursor, b : NetsectlsCursor) -> NetsectlsCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_sec_tls_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_sec_tls_cursor_copy(s : NetsectlsCursor) -> NetsectlsCursor {
  let result = net_sec_tls_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_sec_tls_cursor_fill(s : NetsectlsCursor, v : Double) -> NetsectlsCursor {
  let result = net_sec_tls_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_sec_tls_cursor_min(s : NetsectlsCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_sec_tls_cursor_max(s : NetsectlsCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_sec_tls_cursor_to_string(s : NetsectlsCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsectlsView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_tls_view_make(size : Int) -> NetsectlsView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_tls_view_len(s : NetsectlsView) -> Int { s.size }

pub fn net_sec_tls_view_get(s : NetsectlsView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_tls_view_set(s : NetsectlsView, i : Int, v : Double) -> NetsectlsView {
  let result = net_sec_tls_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_sec_tls_view_sum(s : NetsectlsView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_sec_tls_view_mean(s : NetsectlsView) -> Double {
  if s.size == 0 { 0.0 } else { net_sec_tls_view_sum(s) / s.size.to_double() }
}

pub fn net_sec_tls_view_scale(s : NetsectlsView, f : Double) -> NetsectlsView {
  let result = net_sec_tls_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_sec_tls_view_add(a : NetsectlsView, b : NetsectlsView) -> NetsectlsView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_sec_tls_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_sec_tls_view_copy(s : NetsectlsView) -> NetsectlsView {
  let result = net_sec_tls_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_sec_tls_view_fill(s : NetsectlsView, v : Double) -> NetsectlsView {
  let result = net_sec_tls_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_sec_tls_view_min(s : NetsectlsView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_sec_tls_view_max(s : NetsectlsView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_sec_tls_view_to_string(s : NetsectlsView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsectlsRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_tls_range_make(size : Int) -> NetsectlsRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_tls_range_len(s : NetsectlsRange) -> Int { s.size }

pub fn net_sec_tls_range_get(s : NetsectlsRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_tls_range_set(s : NetsectlsRange, i : Int, v : Double) -> NetsectlsRange {
  let result = net_sec_tls_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_sec_tls_range_sum(s : NetsectlsRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_sec_tls_range_mean(s : NetsectlsRange) -> Double {
  if s.size == 0 { 0.0 } else { net_sec_tls_range_sum(s) / s.size.to_double() }
}

pub fn net_sec_tls_range_scale(s : NetsectlsRange, f : Double) -> NetsectlsRange {
  let result = net_sec_tls_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_sec_tls_range_add(a : NetsectlsRange, b : NetsectlsRange) -> NetsectlsRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_sec_tls_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_sec_tls_range_copy(s : NetsectlsRange) -> NetsectlsRange {
  let result = net_sec_tls_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_sec_tls_range_fill(s : NetsectlsRange, v : Double) -> NetsectlsRange {
  let result = net_sec_tls_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_sec_tls_range_min(s : NetsectlsRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_sec_tls_range_max(s : NetsectlsRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_sec_tls_range_to_string(s : NetsectlsRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsectlsSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_tls_slice_make(size : Int) -> NetsectlsSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_tls_slice_len(s : NetsectlsSlice) -> Int { s.size }

pub fn net_sec_tls_slice_get(s : NetsectlsSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_tls_slice_set(s : NetsectlsSlice, i : Int, v : Double) -> NetsectlsSlice {
  let result = net_sec_tls_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_sec_tls_slice_sum(s : NetsectlsSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_sec_tls_slice_mean(s : NetsectlsSlice) -> Double {
  if s.size == 0 { 0.0 } else { net_sec_tls_slice_sum(s) / s.size.to_double() }
}

pub fn net_sec_tls_slice_scale(s : NetsectlsSlice, f : Double) -> NetsectlsSlice {
  let result = net_sec_tls_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_sec_tls_slice_add(a : NetsectlsSlice, b : NetsectlsSlice) -> NetsectlsSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_sec_tls_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_sec_tls_slice_copy(s : NetsectlsSlice) -> NetsectlsSlice {
  let result = net_sec_tls_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_sec_tls_slice_fill(s : NetsectlsSlice, v : Double) -> NetsectlsSlice {
  let result = net_sec_tls_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_sec_tls_slice_min(s : NetsectlsSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_sec_tls_slice_max(s : NetsectlsSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_sec_tls_slice_to_string(s : NetsectlsSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

