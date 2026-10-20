///===
/// extcore/net_route_multipath

pub(all) struct NetroutemultipathPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn net_route_multipath_make_point(x : Double, y : Double) -> NetroutemultipathPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn net_route_multipath_make_point3(x : Double, y : Double, z : Double) -> NetroutemultipathPoint {
  { x, y, z, label: 0 }
}

pub fn net_route_multipath_point_x(pt : NetroutemultipathPoint) -> Double { pt.x }

pub fn net_route_multipath_point_y(pt : NetroutemultipathPoint) -> Double { pt.y }

pub fn net_route_multipath_point_z(pt : NetroutemultipathPoint) -> Double { pt.z }

pub fn net_route_multipath_point_label(pt : NetroutemultipathPoint) -> Int { pt.label }

pub fn net_route_multipath_point_dist(a : NetroutemultipathPoint, b : NetroutemultipathPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn net_route_multipath_point_add(a : NetroutemultipathPoint, b : NetroutemultipathPoint) -> NetroutemultipathPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn net_route_multipath_point_sub(a : NetroutemultipathPoint, b : NetroutemultipathPoint) -> NetroutemultipathPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn net_route_multipath_point_scale(pt : NetroutemultipathPoint, s : Double) -> NetroutemultipathPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn net_route_multipath_point_dot(a : NetroutemultipathPoint, b : NetroutemultipathPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn net_route_multipath_point_cross(a : NetroutemultipathPoint, b : NetroutemultipathPoint) -> NetroutemultipathPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn net_route_multipath_point_norm(pt : NetroutemultipathPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn net_route_multipath_point_normalize(pt : NetroutemultipathPoint) -> NetroutemultipathPoint {
  let n = net_route_multipath_point_norm(pt)
  if n < 0.0000001 { pt } else { net_route_multipath_point_scale(pt, 1.0 / n) }
}

pub fn net_route_multipath_point_negate(pt : NetroutemultipathPoint) -> NetroutemultipathPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn net_route_multipath_point_mid(a : NetroutemultipathPoint, b : NetroutemultipathPoint) -> NetroutemultipathPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn net_route_multipath_point_lerp(a : NetroutemultipathPoint, b : NetroutemultipathPoint, t : Double) -> NetroutemultipathPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn net_route_multipath_point_to_string(pt : NetroutemultipathPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct NetroutemultipathSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn net_route_multipath_make_series(vals : Array[Double], name : String) -> NetroutemultipathSeries {
  { vals, name, meta: 0 }
}

pub fn net_route_multipath_series_len(s : NetroutemultipathSeries) -> Int { s.vals.length() }

pub fn net_route_multipath_series_sum(s : NetroutemultipathSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn net_route_multipath_series_mean(s : NetroutemultipathSeries) -> Double { @_common.mean(s.vals) }

pub fn net_route_multipath_series_min(s : NetroutemultipathSeries) -> Double { @_common.min(s.vals) }

pub fn net_route_multipath_series_max(s : NetroutemultipathSeries) -> Double { @_common.max(s.vals) }

pub fn net_route_multipath_series_range(s : NetroutemultipathSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn net_route_multipath_series_var(s : NetroutemultipathSeries) -> Double { @_common.variance(s.vals) }

pub fn net_route_multipath_series_std(s : NetroutemultipathSeries) -> Double { @_common.std(s.vals) }

pub fn net_route_multipath_series_median(s : NetroutemultipathSeries) -> Double { @_common.median(s.vals) }

pub fn net_route_multipath_series_scale(s : NetroutemultipathSeries, f : Double) -> NetroutemultipathSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn net_route_multipath_series_add(a : NetroutemultipathSeries, b : NetroutemultipathSeries) -> NetroutemultipathSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn net_route_multipath_series_sub(a : NetroutemultipathSeries, b : NetroutemultipathSeries) -> NetroutemultipathSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn net_route_multipath_series_normalize(s : NetroutemultipathSeries) -> NetroutemultipathSeries {
  let mn = net_route_multipath_series_min(s)
  let mx = net_route_multipath_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn net_route_multipath_series_cumsum(s : NetroutemultipathSeries) -> NetroutemultipathSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn net_route_multipath_series_to_string(s : NetroutemultipathSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NetroutemultipathMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn net_route_multipath_make_matrix(rows : Int, cols : Int, val : Double) -> NetroutemultipathMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn net_route_multipath_matrix_identity(n : Int) -> NetroutemultipathMatrix {
  let m = net_route_multipath_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn net_route_multipath_matrix_get(m : NetroutemultipathMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn net_route_multipath_matrix_transpose(m : NetroutemultipathMatrix) -> NetroutemultipathMatrix {
  let result = net_route_multipath_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn net_route_multipath_matrix_add(a : NetroutemultipathMatrix, b : NetroutemultipathMatrix) -> NetroutemultipathMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = net_route_multipath_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn net_route_multipath_matrix_scale(m : NetroutemultipathMatrix, s : Double) -> NetroutemultipathMatrix {
  let result = net_route_multipath_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn net_route_multipath_matrix_multiply(a : NetroutemultipathMatrix, b : NetroutemultipathMatrix) -> NetroutemultipathMatrix {
  if a.cols != b.rows { return net_route_multipath_make_matrix(a.rows, b.cols, 0.0) }
  let result = net_route_multipath_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn net_route_multipath_matrix_trace(m : NetroutemultipathMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn net_route_multipath_matrix_det(m : NetroutemultipathMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn net_route_multipath_matrix_norm(m : NetroutemultipathMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn net_route_multipath_matrix_to_string(m : NetroutemultipathMatrix) -> String {
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

pub(all) struct NetroutemultipathVector {
  comps : Array[Double]
  dim : Int
}

pub fn net_route_multipath_make_vector(comps : Array[Double]) -> NetroutemultipathVector {
  { comps, dim: comps.length() }
}

pub fn net_route_multipath_vector_zero(dim : Int) -> NetroutemultipathVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn net_route_multipath_vector_add(a : NetroutemultipathVector, b : NetroutemultipathVector) -> NetroutemultipathVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn net_route_multipath_vector_sub(a : NetroutemultipathVector, b : NetroutemultipathVector) -> NetroutemultipathVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn net_route_multipath_vector_scale(v : NetroutemultipathVector, s : Double) -> NetroutemultipathVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn net_route_multipath_vector_dot(a : NetroutemultipathVector, b : NetroutemultipathVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn net_route_multipath_vector_norm(v : NetroutemultipathVector) -> Double { @_common.sqrt(net_route_multipath_vector_dot(v, v)) }

pub fn net_route_multipath_vector_normalize(v : NetroutemultipathVector) -> NetroutemultipathVector {
  let n = net_route_multipath_vector_norm(v)
  if n < 0.0000001 { v } else { net_route_multipath_vector_scale(v, 1.0 / n) }
}

pub fn net_route_multipath_vector_dist(a : NetroutemultipathVector, b : NetroutemultipathVector) -> Double {
  net_route_multipath_vector_norm(net_route_multipath_vector_sub(a, b))
}

pub fn net_route_multipath_vector_to_string(v : NetroutemultipathVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn net_route_multipath_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn net_route_multipath_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn net_route_multipath_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn net_route_multipath_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn net_route_multipath_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn net_route_multipath_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn net_route_multipath_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn net_route_multipath_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn net_route_multipath_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn net_route_multipath_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn net_route_multipath_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn net_route_multipath_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn net_route_multipath_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn net_route_multipath_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn net_route_multipath_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn net_route_multipath_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn net_route_multipath_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn net_route_multipath_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn net_route_multipath_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn net_route_multipath_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn net_route_multipath_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn net_route_multipath_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn net_route_multipath_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn net_route_multipath_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn net_route_multipath_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn net_route_multipath_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn net_route_multipath_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn net_route_multipath_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn net_route_multipath_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct NetroutemultipathFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_multipath_frame_make(size : Int) -> NetroutemultipathFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_multipath_frame_len(s : NetroutemultipathFrame) -> Int { s.size }

pub fn net_route_multipath_frame_get(s : NetroutemultipathFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_multipath_frame_set(s : NetroutemultipathFrame, i : Int, v : Double) -> NetroutemultipathFrame {
  let result = net_route_multipath_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_route_multipath_frame_sum(s : NetroutemultipathFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_route_multipath_frame_mean(s : NetroutemultipathFrame) -> Double {
  if s.size == 0 { 0.0 } else { net_route_multipath_frame_sum(s) / s.size.to_double() }
}

pub fn net_route_multipath_frame_scale(s : NetroutemultipathFrame, f : Double) -> NetroutemultipathFrame {
  let result = net_route_multipath_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_route_multipath_frame_add(a : NetroutemultipathFrame, b : NetroutemultipathFrame) -> NetroutemultipathFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_route_multipath_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_route_multipath_frame_copy(s : NetroutemultipathFrame) -> NetroutemultipathFrame {
  let result = net_route_multipath_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_route_multipath_frame_fill(s : NetroutemultipathFrame, v : Double) -> NetroutemultipathFrame {
  let result = net_route_multipath_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_route_multipath_frame_min(s : NetroutemultipathFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_route_multipath_frame_max(s : NetroutemultipathFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_route_multipath_frame_to_string(s : NetroutemultipathFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetroutemultipathTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_multipath_table_make(size : Int) -> NetroutemultipathTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_multipath_table_len(s : NetroutemultipathTable) -> Int { s.size }

pub fn net_route_multipath_table_get(s : NetroutemultipathTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_multipath_table_set(s : NetroutemultipathTable, i : Int, v : Double) -> NetroutemultipathTable {
  let result = net_route_multipath_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_route_multipath_table_sum(s : NetroutemultipathTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_route_multipath_table_mean(s : NetroutemultipathTable) -> Double {
  if s.size == 0 { 0.0 } else { net_route_multipath_table_sum(s) / s.size.to_double() }
}

pub fn net_route_multipath_table_scale(s : NetroutemultipathTable, f : Double) -> NetroutemultipathTable {
  let result = net_route_multipath_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_route_multipath_table_add(a : NetroutemultipathTable, b : NetroutemultipathTable) -> NetroutemultipathTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_route_multipath_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_route_multipath_table_copy(s : NetroutemultipathTable) -> NetroutemultipathTable {
  let result = net_route_multipath_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_route_multipath_table_fill(s : NetroutemultipathTable, v : Double) -> NetroutemultipathTable {
  let result = net_route_multipath_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_route_multipath_table_min(s : NetroutemultipathTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_route_multipath_table_max(s : NetroutemultipathTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_route_multipath_table_to_string(s : NetroutemultipathTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetroutemultipathGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_multipath_graphn_make(size : Int) -> NetroutemultipathGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_multipath_graphn_len(s : NetroutemultipathGraphN) -> Int { s.size }

pub fn net_route_multipath_graphn_get(s : NetroutemultipathGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_multipath_graphn_set(s : NetroutemultipathGraphN, i : Int, v : Double) -> NetroutemultipathGraphN {
  let result = net_route_multipath_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_route_multipath_graphn_sum(s : NetroutemultipathGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_route_multipath_graphn_mean(s : NetroutemultipathGraphN) -> Double {
  if s.size == 0 { 0.0 } else { net_route_multipath_graphn_sum(s) / s.size.to_double() }
}

pub fn net_route_multipath_graphn_scale(s : NetroutemultipathGraphN, f : Double) -> NetroutemultipathGraphN {
  let result = net_route_multipath_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_route_multipath_graphn_add(a : NetroutemultipathGraphN, b : NetroutemultipathGraphN) -> NetroutemultipathGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_route_multipath_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_route_multipath_graphn_copy(s : NetroutemultipathGraphN) -> NetroutemultipathGraphN {
  let result = net_route_multipath_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_route_multipath_graphn_fill(s : NetroutemultipathGraphN, v : Double) -> NetroutemultipathGraphN {
  let result = net_route_multipath_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_route_multipath_graphn_min(s : NetroutemultipathGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_route_multipath_graphn_max(s : NetroutemultipathGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_route_multipath_graphn_to_string(s : NetroutemultipathGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetroutemultipathNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_multipath_node_make(size : Int) -> NetroutemultipathNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_multipath_node_len(s : NetroutemultipathNode) -> Int { s.size }

pub fn net_route_multipath_node_get(s : NetroutemultipathNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_multipath_node_set(s : NetroutemultipathNode, i : Int, v : Double) -> NetroutemultipathNode {
  let result = net_route_multipath_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_route_multipath_node_sum(s : NetroutemultipathNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_route_multipath_node_mean(s : NetroutemultipathNode) -> Double {
  if s.size == 0 { 0.0 } else { net_route_multipath_node_sum(s) / s.size.to_double() }
}

pub fn net_route_multipath_node_scale(s : NetroutemultipathNode, f : Double) -> NetroutemultipathNode {
  let result = net_route_multipath_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_route_multipath_node_add(a : NetroutemultipathNode, b : NetroutemultipathNode) -> NetroutemultipathNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_route_multipath_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_route_multipath_node_copy(s : NetroutemultipathNode) -> NetroutemultipathNode {
  let result = net_route_multipath_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_route_multipath_node_fill(s : NetroutemultipathNode, v : Double) -> NetroutemultipathNode {
  let result = net_route_multipath_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_route_multipath_node_min(s : NetroutemultipathNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_route_multipath_node_max(s : NetroutemultipathNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_route_multipath_node_to_string(s : NetroutemultipathNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetroutemultipathEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_multipath_edge_make(size : Int) -> NetroutemultipathEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_multipath_edge_len(s : NetroutemultipathEdge) -> Int { s.size }

pub fn net_route_multipath_edge_get(s : NetroutemultipathEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_multipath_edge_set(s : NetroutemultipathEdge, i : Int, v : Double) -> NetroutemultipathEdge {
  let result = net_route_multipath_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_route_multipath_edge_sum(s : NetroutemultipathEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_route_multipath_edge_mean(s : NetroutemultipathEdge) -> Double {
  if s.size == 0 { 0.0 } else { net_route_multipath_edge_sum(s) / s.size.to_double() }
}

pub fn net_route_multipath_edge_scale(s : NetroutemultipathEdge, f : Double) -> NetroutemultipathEdge {
  let result = net_route_multipath_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_route_multipath_edge_add(a : NetroutemultipathEdge, b : NetroutemultipathEdge) -> NetroutemultipathEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_route_multipath_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_route_multipath_edge_copy(s : NetroutemultipathEdge) -> NetroutemultipathEdge {
  let result = net_route_multipath_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_route_multipath_edge_fill(s : NetroutemultipathEdge, v : Double) -> NetroutemultipathEdge {
  let result = net_route_multipath_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_route_multipath_edge_min(s : NetroutemultipathEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_route_multipath_edge_max(s : NetroutemultipathEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_route_multipath_edge_to_string(s : NetroutemultipathEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetroutemultipathPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_multipath_path_make(size : Int) -> NetroutemultipathPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_multipath_path_len(s : NetroutemultipathPath) -> Int { s.size }

pub fn net_route_multipath_path_get(s : NetroutemultipathPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_multipath_path_set(s : NetroutemultipathPath, i : Int, v : Double) -> NetroutemultipathPath {
  let result = net_route_multipath_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_route_multipath_path_sum(s : NetroutemultipathPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_route_multipath_path_mean(s : NetroutemultipathPath) -> Double {
  if s.size == 0 { 0.0 } else { net_route_multipath_path_sum(s) / s.size.to_double() }
}

pub fn net_route_multipath_path_scale(s : NetroutemultipathPath, f : Double) -> NetroutemultipathPath {
  let result = net_route_multipath_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_route_multipath_path_add(a : NetroutemultipathPath, b : NetroutemultipathPath) -> NetroutemultipathPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_route_multipath_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_route_multipath_path_copy(s : NetroutemultipathPath) -> NetroutemultipathPath {
  let result = net_route_multipath_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_route_multipath_path_fill(s : NetroutemultipathPath, v : Double) -> NetroutemultipathPath {
  let result = net_route_multipath_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_route_multipath_path_min(s : NetroutemultipathPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_route_multipath_path_max(s : NetroutemultipathPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_route_multipath_path_to_string(s : NetroutemultipathPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetroutemultipathCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_multipath_cluster_make(size : Int) -> NetroutemultipathCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_multipath_cluster_len(s : NetroutemultipathCluster) -> Int { s.size }

pub fn net_route_multipath_cluster_get(s : NetroutemultipathCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_multipath_cluster_set(s : NetroutemultipathCluster, i : Int, v : Double) -> NetroutemultipathCluster {
  let result = net_route_multipath_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_route_multipath_cluster_sum(s : NetroutemultipathCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_route_multipath_cluster_mean(s : NetroutemultipathCluster) -> Double {
  if s.size == 0 { 0.0 } else { net_route_multipath_cluster_sum(s) / s.size.to_double() }
}

pub fn net_route_multipath_cluster_scale(s : NetroutemultipathCluster, f : Double) -> NetroutemultipathCluster {
  let result = net_route_multipath_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_route_multipath_cluster_add(a : NetroutemultipathCluster, b : NetroutemultipathCluster) -> NetroutemultipathCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_route_multipath_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_route_multipath_cluster_copy(s : NetroutemultipathCluster) -> NetroutemultipathCluster {
  let result = net_route_multipath_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_route_multipath_cluster_fill(s : NetroutemultipathCluster, v : Double) -> NetroutemultipathCluster {
  let result = net_route_multipath_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_route_multipath_cluster_min(s : NetroutemultipathCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_route_multipath_cluster_max(s : NetroutemultipathCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_route_multipath_cluster_to_string(s : NetroutemultipathCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetroutemultipathModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_multipath_model_make(size : Int) -> NetroutemultipathModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_multipath_model_len(s : NetroutemultipathModel) -> Int { s.size }

pub fn net_route_multipath_model_get(s : NetroutemultipathModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_multipath_model_set(s : NetroutemultipathModel, i : Int, v : Double) -> NetroutemultipathModel {
  let result = net_route_multipath_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_route_multipath_model_sum(s : NetroutemultipathModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_route_multipath_model_mean(s : NetroutemultipathModel) -> Double {
  if s.size == 0 { 0.0 } else { net_route_multipath_model_sum(s) / s.size.to_double() }
}

pub fn net_route_multipath_model_scale(s : NetroutemultipathModel, f : Double) -> NetroutemultipathModel {
  let result = net_route_multipath_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_route_multipath_model_add(a : NetroutemultipathModel, b : NetroutemultipathModel) -> NetroutemultipathModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_route_multipath_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_route_multipath_model_copy(s : NetroutemultipathModel) -> NetroutemultipathModel {
  let result = net_route_multipath_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_route_multipath_model_fill(s : NetroutemultipathModel, v : Double) -> NetroutemultipathModel {
  let result = net_route_multipath_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_route_multipath_model_min(s : NetroutemultipathModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_route_multipath_model_max(s : NetroutemultipathModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_route_multipath_model_to_string(s : NetroutemultipathModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetroutemultipathLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_multipath_layer_make(size : Int) -> NetroutemultipathLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_multipath_layer_len(s : NetroutemultipathLayer) -> Int { s.size }

pub fn net_route_multipath_layer_get(s : NetroutemultipathLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_multipath_layer_set(s : NetroutemultipathLayer, i : Int, v : Double) -> NetroutemultipathLayer {
  let result = net_route_multipath_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_route_multipath_layer_sum(s : NetroutemultipathLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_route_multipath_layer_mean(s : NetroutemultipathLayer) -> Double {
  if s.size == 0 { 0.0 } else { net_route_multipath_layer_sum(s) / s.size.to_double() }
}

pub fn net_route_multipath_layer_scale(s : NetroutemultipathLayer, f : Double) -> NetroutemultipathLayer {
  let result = net_route_multipath_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_route_multipath_layer_add(a : NetroutemultipathLayer, b : NetroutemultipathLayer) -> NetroutemultipathLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_route_multipath_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_route_multipath_layer_copy(s : NetroutemultipathLayer) -> NetroutemultipathLayer {
  let result = net_route_multipath_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_route_multipath_layer_fill(s : NetroutemultipathLayer, v : Double) -> NetroutemultipathLayer {
  let result = net_route_multipath_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_route_multipath_layer_min(s : NetroutemultipathLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_route_multipath_layer_max(s : NetroutemultipathLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_route_multipath_layer_to_string(s : NetroutemultipathLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetroutemultipathBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_multipath_buffer_make(size : Int) -> NetroutemultipathBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_multipath_buffer_len(s : NetroutemultipathBuffer) -> Int { s.size }

pub fn net_route_multipath_buffer_get(s : NetroutemultipathBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_multipath_buffer_set(s : NetroutemultipathBuffer, i : Int, v : Double) -> NetroutemultipathBuffer {
  let result = net_route_multipath_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_route_multipath_buffer_sum(s : NetroutemultipathBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_route_multipath_buffer_mean(s : NetroutemultipathBuffer) -> Double {
  if s.size == 0 { 0.0 } else { net_route_multipath_buffer_sum(s) / s.size.to_double() }
}

pub fn net_route_multipath_buffer_scale(s : NetroutemultipathBuffer, f : Double) -> NetroutemultipathBuffer {
  let result = net_route_multipath_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_route_multipath_buffer_add(a : NetroutemultipathBuffer, b : NetroutemultipathBuffer) -> NetroutemultipathBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_route_multipath_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_route_multipath_buffer_copy(s : NetroutemultipathBuffer) -> NetroutemultipathBuffer {
  let result = net_route_multipath_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_route_multipath_buffer_fill(s : NetroutemultipathBuffer, v : Double) -> NetroutemultipathBuffer {
  let result = net_route_multipath_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_route_multipath_buffer_min(s : NetroutemultipathBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_route_multipath_buffer_max(s : NetroutemultipathBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_route_multipath_buffer_to_string(s : NetroutemultipathBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetroutemultipathCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_multipath_cursor_make(size : Int) -> NetroutemultipathCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_multipath_cursor_len(s : NetroutemultipathCursor) -> Int { s.size }

pub fn net_route_multipath_cursor_get(s : NetroutemultipathCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_multipath_cursor_set(s : NetroutemultipathCursor, i : Int, v : Double) -> NetroutemultipathCursor {
  let result = net_route_multipath_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_route_multipath_cursor_sum(s : NetroutemultipathCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_route_multipath_cursor_mean(s : NetroutemultipathCursor) -> Double {
  if s.size == 0 { 0.0 } else { net_route_multipath_cursor_sum(s) / s.size.to_double() }
}

pub fn net_route_multipath_cursor_scale(s : NetroutemultipathCursor, f : Double) -> NetroutemultipathCursor {
  let result = net_route_multipath_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_route_multipath_cursor_add(a : NetroutemultipathCursor, b : NetroutemultipathCursor) -> NetroutemultipathCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_route_multipath_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_route_multipath_cursor_copy(s : NetroutemultipathCursor) -> NetroutemultipathCursor {
  let result = net_route_multipath_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_route_multipath_cursor_fill(s : NetroutemultipathCursor, v : Double) -> NetroutemultipathCursor {
  let result = net_route_multipath_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_route_multipath_cursor_min(s : NetroutemultipathCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_route_multipath_cursor_max(s : NetroutemultipathCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_route_multipath_cursor_to_string(s : NetroutemultipathCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetroutemultipathView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_multipath_view_make(size : Int) -> NetroutemultipathView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_multipath_view_len(s : NetroutemultipathView) -> Int { s.size }

pub fn net_route_multipath_view_get(s : NetroutemultipathView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_multipath_view_set(s : NetroutemultipathView, i : Int, v : Double) -> NetroutemultipathView {
  let result = net_route_multipath_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_route_multipath_view_sum(s : NetroutemultipathView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_route_multipath_view_mean(s : NetroutemultipathView) -> Double {
  if s.size == 0 { 0.0 } else { net_route_multipath_view_sum(s) / s.size.to_double() }
}

pub fn net_route_multipath_view_scale(s : NetroutemultipathView, f : Double) -> NetroutemultipathView {
  let result = net_route_multipath_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_route_multipath_view_add(a : NetroutemultipathView, b : NetroutemultipathView) -> NetroutemultipathView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_route_multipath_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_route_multipath_view_copy(s : NetroutemultipathView) -> NetroutemultipathView {
  let result = net_route_multipath_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_route_multipath_view_fill(s : NetroutemultipathView, v : Double) -> NetroutemultipathView {
  let result = net_route_multipath_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_route_multipath_view_min(s : NetroutemultipathView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_route_multipath_view_max(s : NetroutemultipathView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_route_multipath_view_to_string(s : NetroutemultipathView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetroutemultipathRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_multipath_range_make(size : Int) -> NetroutemultipathRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_multipath_range_len(s : NetroutemultipathRange) -> Int { s.size }

pub fn net_route_multipath_range_get(s : NetroutemultipathRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_multipath_range_set(s : NetroutemultipathRange, i : Int, v : Double) -> NetroutemultipathRange {
  let result = net_route_multipath_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_route_multipath_range_sum(s : NetroutemultipathRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_route_multipath_range_mean(s : NetroutemultipathRange) -> Double {
  if s.size == 0 { 0.0 } else { net_route_multipath_range_sum(s) / s.size.to_double() }
}

pub fn net_route_multipath_range_scale(s : NetroutemultipathRange, f : Double) -> NetroutemultipathRange {
  let result = net_route_multipath_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_route_multipath_range_add(a : NetroutemultipathRange, b : NetroutemultipathRange) -> NetroutemultipathRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_route_multipath_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_route_multipath_range_copy(s : NetroutemultipathRange) -> NetroutemultipathRange {
  let result = net_route_multipath_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_route_multipath_range_fill(s : NetroutemultipathRange, v : Double) -> NetroutemultipathRange {
  let result = net_route_multipath_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_route_multipath_range_min(s : NetroutemultipathRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_route_multipath_range_max(s : NetroutemultipathRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_route_multipath_range_to_string(s : NetroutemultipathRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetroutemultipathSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_multipath_slice_make(size : Int) -> NetroutemultipathSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_multipath_slice_len(s : NetroutemultipathSlice) -> Int { s.size }

pub fn net_route_multipath_slice_get(s : NetroutemultipathSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_multipath_slice_set(s : NetroutemultipathSlice, i : Int, v : Double) -> NetroutemultipathSlice {
  let result = net_route_multipath_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_route_multipath_slice_sum(s : NetroutemultipathSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_route_multipath_slice_mean(s : NetroutemultipathSlice) -> Double {
  if s.size == 0 { 0.0 } else { net_route_multipath_slice_sum(s) / s.size.to_double() }
}

pub fn net_route_multipath_slice_scale(s : NetroutemultipathSlice, f : Double) -> NetroutemultipathSlice {
  let result = net_route_multipath_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_route_multipath_slice_add(a : NetroutemultipathSlice, b : NetroutemultipathSlice) -> NetroutemultipathSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_route_multipath_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_route_multipath_slice_copy(s : NetroutemultipathSlice) -> NetroutemultipathSlice {
  let result = net_route_multipath_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_route_multipath_slice_fill(s : NetroutemultipathSlice, v : Double) -> NetroutemultipathSlice {
  let result = net_route_multipath_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_route_multipath_slice_min(s : NetroutemultipathSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_route_multipath_slice_max(s : NetroutemultipathSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_route_multipath_slice_to_string(s : NetroutemultipathSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

