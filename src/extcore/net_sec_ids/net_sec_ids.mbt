///===
/// extcore/net_sec_ids

pub(all) struct NetsecidsPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn net_sec_ids_make_point(x : Double, y : Double) -> NetsecidsPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn net_sec_ids_make_point3(x : Double, y : Double, z : Double) -> NetsecidsPoint {
  { x, y, z, label: 0 }
}

pub fn net_sec_ids_point_x(pt : NetsecidsPoint) -> Double { pt.x }

pub fn net_sec_ids_point_y(pt : NetsecidsPoint) -> Double { pt.y }

pub fn net_sec_ids_point_z(pt : NetsecidsPoint) -> Double { pt.z }

pub fn net_sec_ids_point_label(pt : NetsecidsPoint) -> Int { pt.label }

pub fn net_sec_ids_point_dist(a : NetsecidsPoint, b : NetsecidsPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn net_sec_ids_point_add(a : NetsecidsPoint, b : NetsecidsPoint) -> NetsecidsPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn net_sec_ids_point_sub(a : NetsecidsPoint, b : NetsecidsPoint) -> NetsecidsPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn net_sec_ids_point_scale(pt : NetsecidsPoint, s : Double) -> NetsecidsPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn net_sec_ids_point_dot(a : NetsecidsPoint, b : NetsecidsPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn net_sec_ids_point_cross(a : NetsecidsPoint, b : NetsecidsPoint) -> NetsecidsPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn net_sec_ids_point_norm(pt : NetsecidsPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn net_sec_ids_point_normalize(pt : NetsecidsPoint) -> NetsecidsPoint {
  let n = net_sec_ids_point_norm(pt)
  if n < 0.0000001 { pt } else { net_sec_ids_point_scale(pt, 1.0 / n) }
}

pub fn net_sec_ids_point_negate(pt : NetsecidsPoint) -> NetsecidsPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn net_sec_ids_point_mid(a : NetsecidsPoint, b : NetsecidsPoint) -> NetsecidsPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn net_sec_ids_point_lerp(a : NetsecidsPoint, b : NetsecidsPoint, t : Double) -> NetsecidsPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn net_sec_ids_point_to_string(pt : NetsecidsPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct NetsecidsSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn net_sec_ids_make_series(vals : Array[Double], name : String) -> NetsecidsSeries {
  { vals, name, meta: 0 }
}

pub fn net_sec_ids_series_len(s : NetsecidsSeries) -> Int { s.vals.length() }

pub fn net_sec_ids_series_sum(s : NetsecidsSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn net_sec_ids_series_mean(s : NetsecidsSeries) -> Double { @_common.mean(s.vals) }

pub fn net_sec_ids_series_min(s : NetsecidsSeries) -> Double { @_common.min(s.vals) }

pub fn net_sec_ids_series_max(s : NetsecidsSeries) -> Double { @_common.max(s.vals) }

pub fn net_sec_ids_series_range(s : NetsecidsSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn net_sec_ids_series_var(s : NetsecidsSeries) -> Double { @_common.variance(s.vals) }

pub fn net_sec_ids_series_std(s : NetsecidsSeries) -> Double { @_common.std(s.vals) }

pub fn net_sec_ids_series_median(s : NetsecidsSeries) -> Double { @_common.median(s.vals) }

pub fn net_sec_ids_series_scale(s : NetsecidsSeries, f : Double) -> NetsecidsSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn net_sec_ids_series_add(a : NetsecidsSeries, b : NetsecidsSeries) -> NetsecidsSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn net_sec_ids_series_sub(a : NetsecidsSeries, b : NetsecidsSeries) -> NetsecidsSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn net_sec_ids_series_normalize(s : NetsecidsSeries) -> NetsecidsSeries {
  let mn = net_sec_ids_series_min(s)
  let mx = net_sec_ids_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn net_sec_ids_series_cumsum(s : NetsecidsSeries) -> NetsecidsSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn net_sec_ids_series_to_string(s : NetsecidsSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NetsecidsMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn net_sec_ids_make_matrix(rows : Int, cols : Int, val : Double) -> NetsecidsMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn net_sec_ids_matrix_identity(n : Int) -> NetsecidsMatrix {
  let m = net_sec_ids_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn net_sec_ids_matrix_get(m : NetsecidsMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn net_sec_ids_matrix_transpose(m : NetsecidsMatrix) -> NetsecidsMatrix {
  let result = net_sec_ids_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn net_sec_ids_matrix_add(a : NetsecidsMatrix, b : NetsecidsMatrix) -> NetsecidsMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = net_sec_ids_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn net_sec_ids_matrix_scale(m : NetsecidsMatrix, s : Double) -> NetsecidsMatrix {
  let result = net_sec_ids_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn net_sec_ids_matrix_multiply(a : NetsecidsMatrix, b : NetsecidsMatrix) -> NetsecidsMatrix {
  if a.cols != b.rows { return net_sec_ids_make_matrix(a.rows, b.cols, 0.0) }
  let result = net_sec_ids_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn net_sec_ids_matrix_trace(m : NetsecidsMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn net_sec_ids_matrix_det(m : NetsecidsMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn net_sec_ids_matrix_norm(m : NetsecidsMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn net_sec_ids_matrix_to_string(m : NetsecidsMatrix) -> String {
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

pub(all) struct NetsecidsVector {
  comps : Array[Double]
  dim : Int
}

pub fn net_sec_ids_make_vector(comps : Array[Double]) -> NetsecidsVector {
  { comps, dim: comps.length() }
}

pub fn net_sec_ids_vector_zero(dim : Int) -> NetsecidsVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn net_sec_ids_vector_add(a : NetsecidsVector, b : NetsecidsVector) -> NetsecidsVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn net_sec_ids_vector_sub(a : NetsecidsVector, b : NetsecidsVector) -> NetsecidsVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn net_sec_ids_vector_scale(v : NetsecidsVector, s : Double) -> NetsecidsVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn net_sec_ids_vector_dot(a : NetsecidsVector, b : NetsecidsVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn net_sec_ids_vector_norm(v : NetsecidsVector) -> Double { @_common.sqrt(net_sec_ids_vector_dot(v, v)) }

pub fn net_sec_ids_vector_normalize(v : NetsecidsVector) -> NetsecidsVector {
  let n = net_sec_ids_vector_norm(v)
  if n < 0.0000001 { v } else { net_sec_ids_vector_scale(v, 1.0 / n) }
}

pub fn net_sec_ids_vector_dist(a : NetsecidsVector, b : NetsecidsVector) -> Double {
  net_sec_ids_vector_norm(net_sec_ids_vector_sub(a, b))
}

pub fn net_sec_ids_vector_to_string(v : NetsecidsVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn net_sec_ids_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn net_sec_ids_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn net_sec_ids_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn net_sec_ids_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn net_sec_ids_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn net_sec_ids_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn net_sec_ids_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn net_sec_ids_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn net_sec_ids_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn net_sec_ids_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn net_sec_ids_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn net_sec_ids_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn net_sec_ids_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn net_sec_ids_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn net_sec_ids_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn net_sec_ids_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn net_sec_ids_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn net_sec_ids_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn net_sec_ids_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn net_sec_ids_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn net_sec_ids_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn net_sec_ids_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn net_sec_ids_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn net_sec_ids_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn net_sec_ids_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn net_sec_ids_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn net_sec_ids_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn net_sec_ids_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn net_sec_ids_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct NetsecidsFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_ids_frame_make(size : Int) -> NetsecidsFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_ids_frame_len(s : NetsecidsFrame) -> Int { s.size }

pub fn net_sec_ids_frame_get(s : NetsecidsFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_ids_frame_set(s : NetsecidsFrame, i : Int, v : Double) -> NetsecidsFrame {
  let result = net_sec_ids_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_sec_ids_frame_sum(s : NetsecidsFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_sec_ids_frame_mean(s : NetsecidsFrame) -> Double {
  if s.size == 0 { 0.0 } else { net_sec_ids_frame_sum(s) / s.size.to_double() }
}

pub fn net_sec_ids_frame_scale(s : NetsecidsFrame, f : Double) -> NetsecidsFrame {
  let result = net_sec_ids_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_sec_ids_frame_add(a : NetsecidsFrame, b : NetsecidsFrame) -> NetsecidsFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_sec_ids_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_sec_ids_frame_copy(s : NetsecidsFrame) -> NetsecidsFrame {
  let result = net_sec_ids_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_sec_ids_frame_fill(s : NetsecidsFrame, v : Double) -> NetsecidsFrame {
  let result = net_sec_ids_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_sec_ids_frame_min(s : NetsecidsFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_sec_ids_frame_max(s : NetsecidsFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_sec_ids_frame_to_string(s : NetsecidsFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecidsTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_ids_table_make(size : Int) -> NetsecidsTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_ids_table_len(s : NetsecidsTable) -> Int { s.size }

pub fn net_sec_ids_table_get(s : NetsecidsTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_ids_table_set(s : NetsecidsTable, i : Int, v : Double) -> NetsecidsTable {
  let result = net_sec_ids_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_sec_ids_table_sum(s : NetsecidsTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_sec_ids_table_mean(s : NetsecidsTable) -> Double {
  if s.size == 0 { 0.0 } else { net_sec_ids_table_sum(s) / s.size.to_double() }
}

pub fn net_sec_ids_table_scale(s : NetsecidsTable, f : Double) -> NetsecidsTable {
  let result = net_sec_ids_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_sec_ids_table_add(a : NetsecidsTable, b : NetsecidsTable) -> NetsecidsTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_sec_ids_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_sec_ids_table_copy(s : NetsecidsTable) -> NetsecidsTable {
  let result = net_sec_ids_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_sec_ids_table_fill(s : NetsecidsTable, v : Double) -> NetsecidsTable {
  let result = net_sec_ids_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_sec_ids_table_min(s : NetsecidsTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_sec_ids_table_max(s : NetsecidsTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_sec_ids_table_to_string(s : NetsecidsTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecidsGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_ids_graphn_make(size : Int) -> NetsecidsGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_ids_graphn_len(s : NetsecidsGraphN) -> Int { s.size }

pub fn net_sec_ids_graphn_get(s : NetsecidsGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_ids_graphn_set(s : NetsecidsGraphN, i : Int, v : Double) -> NetsecidsGraphN {
  let result = net_sec_ids_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_sec_ids_graphn_sum(s : NetsecidsGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_sec_ids_graphn_mean(s : NetsecidsGraphN) -> Double {
  if s.size == 0 { 0.0 } else { net_sec_ids_graphn_sum(s) / s.size.to_double() }
}

pub fn net_sec_ids_graphn_scale(s : NetsecidsGraphN, f : Double) -> NetsecidsGraphN {
  let result = net_sec_ids_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_sec_ids_graphn_add(a : NetsecidsGraphN, b : NetsecidsGraphN) -> NetsecidsGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_sec_ids_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_sec_ids_graphn_copy(s : NetsecidsGraphN) -> NetsecidsGraphN {
  let result = net_sec_ids_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_sec_ids_graphn_fill(s : NetsecidsGraphN, v : Double) -> NetsecidsGraphN {
  let result = net_sec_ids_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_sec_ids_graphn_min(s : NetsecidsGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_sec_ids_graphn_max(s : NetsecidsGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_sec_ids_graphn_to_string(s : NetsecidsGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecidsNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_ids_node_make(size : Int) -> NetsecidsNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_ids_node_len(s : NetsecidsNode) -> Int { s.size }

pub fn net_sec_ids_node_get(s : NetsecidsNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_ids_node_set(s : NetsecidsNode, i : Int, v : Double) -> NetsecidsNode {
  let result = net_sec_ids_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_sec_ids_node_sum(s : NetsecidsNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_sec_ids_node_mean(s : NetsecidsNode) -> Double {
  if s.size == 0 { 0.0 } else { net_sec_ids_node_sum(s) / s.size.to_double() }
}

pub fn net_sec_ids_node_scale(s : NetsecidsNode, f : Double) -> NetsecidsNode {
  let result = net_sec_ids_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_sec_ids_node_add(a : NetsecidsNode, b : NetsecidsNode) -> NetsecidsNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_sec_ids_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_sec_ids_node_copy(s : NetsecidsNode) -> NetsecidsNode {
  let result = net_sec_ids_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_sec_ids_node_fill(s : NetsecidsNode, v : Double) -> NetsecidsNode {
  let result = net_sec_ids_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_sec_ids_node_min(s : NetsecidsNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_sec_ids_node_max(s : NetsecidsNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_sec_ids_node_to_string(s : NetsecidsNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecidsEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_ids_edge_make(size : Int) -> NetsecidsEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_ids_edge_len(s : NetsecidsEdge) -> Int { s.size }

pub fn net_sec_ids_edge_get(s : NetsecidsEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_ids_edge_set(s : NetsecidsEdge, i : Int, v : Double) -> NetsecidsEdge {
  let result = net_sec_ids_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_sec_ids_edge_sum(s : NetsecidsEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_sec_ids_edge_mean(s : NetsecidsEdge) -> Double {
  if s.size == 0 { 0.0 } else { net_sec_ids_edge_sum(s) / s.size.to_double() }
}

pub fn net_sec_ids_edge_scale(s : NetsecidsEdge, f : Double) -> NetsecidsEdge {
  let result = net_sec_ids_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_sec_ids_edge_add(a : NetsecidsEdge, b : NetsecidsEdge) -> NetsecidsEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_sec_ids_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_sec_ids_edge_copy(s : NetsecidsEdge) -> NetsecidsEdge {
  let result = net_sec_ids_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_sec_ids_edge_fill(s : NetsecidsEdge, v : Double) -> NetsecidsEdge {
  let result = net_sec_ids_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_sec_ids_edge_min(s : NetsecidsEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_sec_ids_edge_max(s : NetsecidsEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_sec_ids_edge_to_string(s : NetsecidsEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecidsPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_ids_path_make(size : Int) -> NetsecidsPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_ids_path_len(s : NetsecidsPath) -> Int { s.size }

pub fn net_sec_ids_path_get(s : NetsecidsPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_ids_path_set(s : NetsecidsPath, i : Int, v : Double) -> NetsecidsPath {
  let result = net_sec_ids_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_sec_ids_path_sum(s : NetsecidsPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_sec_ids_path_mean(s : NetsecidsPath) -> Double {
  if s.size == 0 { 0.0 } else { net_sec_ids_path_sum(s) / s.size.to_double() }
}

pub fn net_sec_ids_path_scale(s : NetsecidsPath, f : Double) -> NetsecidsPath {
  let result = net_sec_ids_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_sec_ids_path_add(a : NetsecidsPath, b : NetsecidsPath) -> NetsecidsPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_sec_ids_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_sec_ids_path_copy(s : NetsecidsPath) -> NetsecidsPath {
  let result = net_sec_ids_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_sec_ids_path_fill(s : NetsecidsPath, v : Double) -> NetsecidsPath {
  let result = net_sec_ids_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_sec_ids_path_min(s : NetsecidsPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_sec_ids_path_max(s : NetsecidsPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_sec_ids_path_to_string(s : NetsecidsPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecidsCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_ids_cluster_make(size : Int) -> NetsecidsCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_ids_cluster_len(s : NetsecidsCluster) -> Int { s.size }

pub fn net_sec_ids_cluster_get(s : NetsecidsCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_ids_cluster_set(s : NetsecidsCluster, i : Int, v : Double) -> NetsecidsCluster {
  let result = net_sec_ids_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_sec_ids_cluster_sum(s : NetsecidsCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_sec_ids_cluster_mean(s : NetsecidsCluster) -> Double {
  if s.size == 0 { 0.0 } else { net_sec_ids_cluster_sum(s) / s.size.to_double() }
}

pub fn net_sec_ids_cluster_scale(s : NetsecidsCluster, f : Double) -> NetsecidsCluster {
  let result = net_sec_ids_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_sec_ids_cluster_add(a : NetsecidsCluster, b : NetsecidsCluster) -> NetsecidsCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_sec_ids_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_sec_ids_cluster_copy(s : NetsecidsCluster) -> NetsecidsCluster {
  let result = net_sec_ids_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_sec_ids_cluster_fill(s : NetsecidsCluster, v : Double) -> NetsecidsCluster {
  let result = net_sec_ids_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_sec_ids_cluster_min(s : NetsecidsCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_sec_ids_cluster_max(s : NetsecidsCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_sec_ids_cluster_to_string(s : NetsecidsCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecidsModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_ids_model_make(size : Int) -> NetsecidsModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_ids_model_len(s : NetsecidsModel) -> Int { s.size }

pub fn net_sec_ids_model_get(s : NetsecidsModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_ids_model_set(s : NetsecidsModel, i : Int, v : Double) -> NetsecidsModel {
  let result = net_sec_ids_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_sec_ids_model_sum(s : NetsecidsModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_sec_ids_model_mean(s : NetsecidsModel) -> Double {
  if s.size == 0 { 0.0 } else { net_sec_ids_model_sum(s) / s.size.to_double() }
}

pub fn net_sec_ids_model_scale(s : NetsecidsModel, f : Double) -> NetsecidsModel {
  let result = net_sec_ids_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_sec_ids_model_add(a : NetsecidsModel, b : NetsecidsModel) -> NetsecidsModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_sec_ids_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_sec_ids_model_copy(s : NetsecidsModel) -> NetsecidsModel {
  let result = net_sec_ids_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_sec_ids_model_fill(s : NetsecidsModel, v : Double) -> NetsecidsModel {
  let result = net_sec_ids_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_sec_ids_model_min(s : NetsecidsModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_sec_ids_model_max(s : NetsecidsModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_sec_ids_model_to_string(s : NetsecidsModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecidsLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_ids_layer_make(size : Int) -> NetsecidsLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_ids_layer_len(s : NetsecidsLayer) -> Int { s.size }

pub fn net_sec_ids_layer_get(s : NetsecidsLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_ids_layer_set(s : NetsecidsLayer, i : Int, v : Double) -> NetsecidsLayer {
  let result = net_sec_ids_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_sec_ids_layer_sum(s : NetsecidsLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_sec_ids_layer_mean(s : NetsecidsLayer) -> Double {
  if s.size == 0 { 0.0 } else { net_sec_ids_layer_sum(s) / s.size.to_double() }
}

pub fn net_sec_ids_layer_scale(s : NetsecidsLayer, f : Double) -> NetsecidsLayer {
  let result = net_sec_ids_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_sec_ids_layer_add(a : NetsecidsLayer, b : NetsecidsLayer) -> NetsecidsLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_sec_ids_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_sec_ids_layer_copy(s : NetsecidsLayer) -> NetsecidsLayer {
  let result = net_sec_ids_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_sec_ids_layer_fill(s : NetsecidsLayer, v : Double) -> NetsecidsLayer {
  let result = net_sec_ids_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_sec_ids_layer_min(s : NetsecidsLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_sec_ids_layer_max(s : NetsecidsLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_sec_ids_layer_to_string(s : NetsecidsLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecidsBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_ids_buffer_make(size : Int) -> NetsecidsBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_ids_buffer_len(s : NetsecidsBuffer) -> Int { s.size }

pub fn net_sec_ids_buffer_get(s : NetsecidsBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_ids_buffer_set(s : NetsecidsBuffer, i : Int, v : Double) -> NetsecidsBuffer {
  let result = net_sec_ids_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_sec_ids_buffer_sum(s : NetsecidsBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_sec_ids_buffer_mean(s : NetsecidsBuffer) -> Double {
  if s.size == 0 { 0.0 } else { net_sec_ids_buffer_sum(s) / s.size.to_double() }
}

pub fn net_sec_ids_buffer_scale(s : NetsecidsBuffer, f : Double) -> NetsecidsBuffer {
  let result = net_sec_ids_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_sec_ids_buffer_add(a : NetsecidsBuffer, b : NetsecidsBuffer) -> NetsecidsBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_sec_ids_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_sec_ids_buffer_copy(s : NetsecidsBuffer) -> NetsecidsBuffer {
  let result = net_sec_ids_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_sec_ids_buffer_fill(s : NetsecidsBuffer, v : Double) -> NetsecidsBuffer {
  let result = net_sec_ids_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_sec_ids_buffer_min(s : NetsecidsBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_sec_ids_buffer_max(s : NetsecidsBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_sec_ids_buffer_to_string(s : NetsecidsBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecidsCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_ids_cursor_make(size : Int) -> NetsecidsCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_ids_cursor_len(s : NetsecidsCursor) -> Int { s.size }

pub fn net_sec_ids_cursor_get(s : NetsecidsCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_ids_cursor_set(s : NetsecidsCursor, i : Int, v : Double) -> NetsecidsCursor {
  let result = net_sec_ids_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_sec_ids_cursor_sum(s : NetsecidsCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_sec_ids_cursor_mean(s : NetsecidsCursor) -> Double {
  if s.size == 0 { 0.0 } else { net_sec_ids_cursor_sum(s) / s.size.to_double() }
}

pub fn net_sec_ids_cursor_scale(s : NetsecidsCursor, f : Double) -> NetsecidsCursor {
  let result = net_sec_ids_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_sec_ids_cursor_add(a : NetsecidsCursor, b : NetsecidsCursor) -> NetsecidsCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_sec_ids_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_sec_ids_cursor_copy(s : NetsecidsCursor) -> NetsecidsCursor {
  let result = net_sec_ids_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_sec_ids_cursor_fill(s : NetsecidsCursor, v : Double) -> NetsecidsCursor {
  let result = net_sec_ids_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_sec_ids_cursor_min(s : NetsecidsCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_sec_ids_cursor_max(s : NetsecidsCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_sec_ids_cursor_to_string(s : NetsecidsCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecidsView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_ids_view_make(size : Int) -> NetsecidsView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_ids_view_len(s : NetsecidsView) -> Int { s.size }

pub fn net_sec_ids_view_get(s : NetsecidsView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_ids_view_set(s : NetsecidsView, i : Int, v : Double) -> NetsecidsView {
  let result = net_sec_ids_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_sec_ids_view_sum(s : NetsecidsView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_sec_ids_view_mean(s : NetsecidsView) -> Double {
  if s.size == 0 { 0.0 } else { net_sec_ids_view_sum(s) / s.size.to_double() }
}

pub fn net_sec_ids_view_scale(s : NetsecidsView, f : Double) -> NetsecidsView {
  let result = net_sec_ids_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_sec_ids_view_add(a : NetsecidsView, b : NetsecidsView) -> NetsecidsView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_sec_ids_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_sec_ids_view_copy(s : NetsecidsView) -> NetsecidsView {
  let result = net_sec_ids_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_sec_ids_view_fill(s : NetsecidsView, v : Double) -> NetsecidsView {
  let result = net_sec_ids_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_sec_ids_view_min(s : NetsecidsView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_sec_ids_view_max(s : NetsecidsView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_sec_ids_view_to_string(s : NetsecidsView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecidsRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_ids_range_make(size : Int) -> NetsecidsRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_ids_range_len(s : NetsecidsRange) -> Int { s.size }

pub fn net_sec_ids_range_get(s : NetsecidsRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_ids_range_set(s : NetsecidsRange, i : Int, v : Double) -> NetsecidsRange {
  let result = net_sec_ids_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_sec_ids_range_sum(s : NetsecidsRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_sec_ids_range_mean(s : NetsecidsRange) -> Double {
  if s.size == 0 { 0.0 } else { net_sec_ids_range_sum(s) / s.size.to_double() }
}

pub fn net_sec_ids_range_scale(s : NetsecidsRange, f : Double) -> NetsecidsRange {
  let result = net_sec_ids_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_sec_ids_range_add(a : NetsecidsRange, b : NetsecidsRange) -> NetsecidsRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_sec_ids_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_sec_ids_range_copy(s : NetsecidsRange) -> NetsecidsRange {
  let result = net_sec_ids_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_sec_ids_range_fill(s : NetsecidsRange, v : Double) -> NetsecidsRange {
  let result = net_sec_ids_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_sec_ids_range_min(s : NetsecidsRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_sec_ids_range_max(s : NetsecidsRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_sec_ids_range_to_string(s : NetsecidsRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecidsSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_ids_slice_make(size : Int) -> NetsecidsSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_ids_slice_len(s : NetsecidsSlice) -> Int { s.size }

pub fn net_sec_ids_slice_get(s : NetsecidsSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_ids_slice_set(s : NetsecidsSlice, i : Int, v : Double) -> NetsecidsSlice {
  let result = net_sec_ids_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_sec_ids_slice_sum(s : NetsecidsSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_sec_ids_slice_mean(s : NetsecidsSlice) -> Double {
  if s.size == 0 { 0.0 } else { net_sec_ids_slice_sum(s) / s.size.to_double() }
}

pub fn net_sec_ids_slice_scale(s : NetsecidsSlice, f : Double) -> NetsecidsSlice {
  let result = net_sec_ids_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_sec_ids_slice_add(a : NetsecidsSlice, b : NetsecidsSlice) -> NetsecidsSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_sec_ids_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_sec_ids_slice_copy(s : NetsecidsSlice) -> NetsecidsSlice {
  let result = net_sec_ids_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_sec_ids_slice_fill(s : NetsecidsSlice, v : Double) -> NetsecidsSlice {
  let result = net_sec_ids_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_sec_ids_slice_min(s : NetsecidsSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_sec_ids_slice_max(s : NetsecidsSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_sec_ids_slice_to_string(s : NetsecidsSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

