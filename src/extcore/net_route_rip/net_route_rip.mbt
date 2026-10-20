///===
/// extcore/net_route_rip

pub(all) struct NetrouteripPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn net_route_rip_make_point(x : Double, y : Double) -> NetrouteripPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn net_route_rip_make_point3(x : Double, y : Double, z : Double) -> NetrouteripPoint {
  { x, y, z, label: 0 }
}

pub fn net_route_rip_point_x(pt : NetrouteripPoint) -> Double { pt.x }

pub fn net_route_rip_point_y(pt : NetrouteripPoint) -> Double { pt.y }

pub fn net_route_rip_point_z(pt : NetrouteripPoint) -> Double { pt.z }

pub fn net_route_rip_point_label(pt : NetrouteripPoint) -> Int { pt.label }

pub fn net_route_rip_point_dist(a : NetrouteripPoint, b : NetrouteripPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn net_route_rip_point_add(a : NetrouteripPoint, b : NetrouteripPoint) -> NetrouteripPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn net_route_rip_point_sub(a : NetrouteripPoint, b : NetrouteripPoint) -> NetrouteripPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn net_route_rip_point_scale(pt : NetrouteripPoint, s : Double) -> NetrouteripPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn net_route_rip_point_dot(a : NetrouteripPoint, b : NetrouteripPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn net_route_rip_point_cross(a : NetrouteripPoint, b : NetrouteripPoint) -> NetrouteripPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn net_route_rip_point_norm(pt : NetrouteripPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn net_route_rip_point_normalize(pt : NetrouteripPoint) -> NetrouteripPoint {
  let n = net_route_rip_point_norm(pt)
  if n < 0.0000001 { pt } else { net_route_rip_point_scale(pt, 1.0 / n) }
}

pub fn net_route_rip_point_negate(pt : NetrouteripPoint) -> NetrouteripPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn net_route_rip_point_mid(a : NetrouteripPoint, b : NetrouteripPoint) -> NetrouteripPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn net_route_rip_point_lerp(a : NetrouteripPoint, b : NetrouteripPoint, t : Double) -> NetrouteripPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn net_route_rip_point_to_string(pt : NetrouteripPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct NetrouteripSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn net_route_rip_make_series(vals : Array[Double], name : String) -> NetrouteripSeries {
  { vals, name, meta: 0 }
}

pub fn net_route_rip_series_len(s : NetrouteripSeries) -> Int { s.vals.length() }

pub fn net_route_rip_series_sum(s : NetrouteripSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn net_route_rip_series_mean(s : NetrouteripSeries) -> Double { @_common.mean(s.vals) }

pub fn net_route_rip_series_min(s : NetrouteripSeries) -> Double { @_common.min(s.vals) }

pub fn net_route_rip_series_max(s : NetrouteripSeries) -> Double { @_common.max(s.vals) }

pub fn net_route_rip_series_range(s : NetrouteripSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn net_route_rip_series_var(s : NetrouteripSeries) -> Double { @_common.variance(s.vals) }

pub fn net_route_rip_series_std(s : NetrouteripSeries) -> Double { @_common.std(s.vals) }

pub fn net_route_rip_series_median(s : NetrouteripSeries) -> Double { @_common.median(s.vals) }

pub fn net_route_rip_series_scale(s : NetrouteripSeries, f : Double) -> NetrouteripSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn net_route_rip_series_add(a : NetrouteripSeries, b : NetrouteripSeries) -> NetrouteripSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn net_route_rip_series_sub(a : NetrouteripSeries, b : NetrouteripSeries) -> NetrouteripSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn net_route_rip_series_normalize(s : NetrouteripSeries) -> NetrouteripSeries {
  let mn = net_route_rip_series_min(s)
  let mx = net_route_rip_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn net_route_rip_series_cumsum(s : NetrouteripSeries) -> NetrouteripSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn net_route_rip_series_to_string(s : NetrouteripSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NetrouteripMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn net_route_rip_make_matrix(rows : Int, cols : Int, val : Double) -> NetrouteripMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn net_route_rip_matrix_identity(n : Int) -> NetrouteripMatrix {
  let m = net_route_rip_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn net_route_rip_matrix_get(m : NetrouteripMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn net_route_rip_matrix_transpose(m : NetrouteripMatrix) -> NetrouteripMatrix {
  let result = net_route_rip_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn net_route_rip_matrix_add(a : NetrouteripMatrix, b : NetrouteripMatrix) -> NetrouteripMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = net_route_rip_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn net_route_rip_matrix_scale(m : NetrouteripMatrix, s : Double) -> NetrouteripMatrix {
  let result = net_route_rip_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn net_route_rip_matrix_multiply(a : NetrouteripMatrix, b : NetrouteripMatrix) -> NetrouteripMatrix {
  if a.cols != b.rows { return net_route_rip_make_matrix(a.rows, b.cols, 0.0) }
  let result = net_route_rip_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn net_route_rip_matrix_trace(m : NetrouteripMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn net_route_rip_matrix_det(m : NetrouteripMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn net_route_rip_matrix_norm(m : NetrouteripMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn net_route_rip_matrix_to_string(m : NetrouteripMatrix) -> String {
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

pub(all) struct NetrouteripVector {
  comps : Array[Double]
  dim : Int
}

pub fn net_route_rip_make_vector(comps : Array[Double]) -> NetrouteripVector {
  { comps, dim: comps.length() }
}

pub fn net_route_rip_vector_zero(dim : Int) -> NetrouteripVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn net_route_rip_vector_add(a : NetrouteripVector, b : NetrouteripVector) -> NetrouteripVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn net_route_rip_vector_sub(a : NetrouteripVector, b : NetrouteripVector) -> NetrouteripVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn net_route_rip_vector_scale(v : NetrouteripVector, s : Double) -> NetrouteripVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn net_route_rip_vector_dot(a : NetrouteripVector, b : NetrouteripVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn net_route_rip_vector_norm(v : NetrouteripVector) -> Double { @_common.sqrt(net_route_rip_vector_dot(v, v)) }

pub fn net_route_rip_vector_normalize(v : NetrouteripVector) -> NetrouteripVector {
  let n = net_route_rip_vector_norm(v)
  if n < 0.0000001 { v } else { net_route_rip_vector_scale(v, 1.0 / n) }
}

pub fn net_route_rip_vector_dist(a : NetrouteripVector, b : NetrouteripVector) -> Double {
  net_route_rip_vector_norm(net_route_rip_vector_sub(a, b))
}

pub fn net_route_rip_vector_to_string(v : NetrouteripVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn net_route_rip_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn net_route_rip_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn net_route_rip_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn net_route_rip_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn net_route_rip_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn net_route_rip_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn net_route_rip_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn net_route_rip_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn net_route_rip_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn net_route_rip_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn net_route_rip_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn net_route_rip_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn net_route_rip_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn net_route_rip_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn net_route_rip_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn net_route_rip_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn net_route_rip_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn net_route_rip_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn net_route_rip_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn net_route_rip_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn net_route_rip_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn net_route_rip_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn net_route_rip_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn net_route_rip_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn net_route_rip_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn net_route_rip_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn net_route_rip_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn net_route_rip_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn net_route_rip_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct NetrouteripFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_rip_frame_make(size : Int) -> NetrouteripFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_rip_frame_len(s : NetrouteripFrame) -> Int { s.size }

pub fn net_route_rip_frame_get(s : NetrouteripFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_rip_frame_set(s : NetrouteripFrame, i : Int, v : Double) -> NetrouteripFrame {
  let result = net_route_rip_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_route_rip_frame_sum(s : NetrouteripFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_route_rip_frame_mean(s : NetrouteripFrame) -> Double {
  if s.size == 0 { 0.0 } else { net_route_rip_frame_sum(s) / s.size.to_double() }
}

pub fn net_route_rip_frame_scale(s : NetrouteripFrame, f : Double) -> NetrouteripFrame {
  let result = net_route_rip_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_route_rip_frame_add(a : NetrouteripFrame, b : NetrouteripFrame) -> NetrouteripFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_route_rip_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_route_rip_frame_copy(s : NetrouteripFrame) -> NetrouteripFrame {
  let result = net_route_rip_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_route_rip_frame_fill(s : NetrouteripFrame, v : Double) -> NetrouteripFrame {
  let result = net_route_rip_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_route_rip_frame_min(s : NetrouteripFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_route_rip_frame_max(s : NetrouteripFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_route_rip_frame_to_string(s : NetrouteripFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetrouteripTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_rip_table_make(size : Int) -> NetrouteripTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_rip_table_len(s : NetrouteripTable) -> Int { s.size }

pub fn net_route_rip_table_get(s : NetrouteripTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_rip_table_set(s : NetrouteripTable, i : Int, v : Double) -> NetrouteripTable {
  let result = net_route_rip_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_route_rip_table_sum(s : NetrouteripTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_route_rip_table_mean(s : NetrouteripTable) -> Double {
  if s.size == 0 { 0.0 } else { net_route_rip_table_sum(s) / s.size.to_double() }
}

pub fn net_route_rip_table_scale(s : NetrouteripTable, f : Double) -> NetrouteripTable {
  let result = net_route_rip_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_route_rip_table_add(a : NetrouteripTable, b : NetrouteripTable) -> NetrouteripTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_route_rip_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_route_rip_table_copy(s : NetrouteripTable) -> NetrouteripTable {
  let result = net_route_rip_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_route_rip_table_fill(s : NetrouteripTable, v : Double) -> NetrouteripTable {
  let result = net_route_rip_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_route_rip_table_min(s : NetrouteripTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_route_rip_table_max(s : NetrouteripTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_route_rip_table_to_string(s : NetrouteripTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetrouteripGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_rip_graphn_make(size : Int) -> NetrouteripGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_rip_graphn_len(s : NetrouteripGraphN) -> Int { s.size }

pub fn net_route_rip_graphn_get(s : NetrouteripGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_rip_graphn_set(s : NetrouteripGraphN, i : Int, v : Double) -> NetrouteripGraphN {
  let result = net_route_rip_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_route_rip_graphn_sum(s : NetrouteripGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_route_rip_graphn_mean(s : NetrouteripGraphN) -> Double {
  if s.size == 0 { 0.0 } else { net_route_rip_graphn_sum(s) / s.size.to_double() }
}

pub fn net_route_rip_graphn_scale(s : NetrouteripGraphN, f : Double) -> NetrouteripGraphN {
  let result = net_route_rip_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_route_rip_graphn_add(a : NetrouteripGraphN, b : NetrouteripGraphN) -> NetrouteripGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_route_rip_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_route_rip_graphn_copy(s : NetrouteripGraphN) -> NetrouteripGraphN {
  let result = net_route_rip_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_route_rip_graphn_fill(s : NetrouteripGraphN, v : Double) -> NetrouteripGraphN {
  let result = net_route_rip_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_route_rip_graphn_min(s : NetrouteripGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_route_rip_graphn_max(s : NetrouteripGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_route_rip_graphn_to_string(s : NetrouteripGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetrouteripNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_rip_node_make(size : Int) -> NetrouteripNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_rip_node_len(s : NetrouteripNode) -> Int { s.size }

pub fn net_route_rip_node_get(s : NetrouteripNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_rip_node_set(s : NetrouteripNode, i : Int, v : Double) -> NetrouteripNode {
  let result = net_route_rip_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_route_rip_node_sum(s : NetrouteripNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_route_rip_node_mean(s : NetrouteripNode) -> Double {
  if s.size == 0 { 0.0 } else { net_route_rip_node_sum(s) / s.size.to_double() }
}

pub fn net_route_rip_node_scale(s : NetrouteripNode, f : Double) -> NetrouteripNode {
  let result = net_route_rip_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_route_rip_node_add(a : NetrouteripNode, b : NetrouteripNode) -> NetrouteripNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_route_rip_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_route_rip_node_copy(s : NetrouteripNode) -> NetrouteripNode {
  let result = net_route_rip_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_route_rip_node_fill(s : NetrouteripNode, v : Double) -> NetrouteripNode {
  let result = net_route_rip_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_route_rip_node_min(s : NetrouteripNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_route_rip_node_max(s : NetrouteripNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_route_rip_node_to_string(s : NetrouteripNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetrouteripEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_rip_edge_make(size : Int) -> NetrouteripEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_rip_edge_len(s : NetrouteripEdge) -> Int { s.size }

pub fn net_route_rip_edge_get(s : NetrouteripEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_rip_edge_set(s : NetrouteripEdge, i : Int, v : Double) -> NetrouteripEdge {
  let result = net_route_rip_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_route_rip_edge_sum(s : NetrouteripEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_route_rip_edge_mean(s : NetrouteripEdge) -> Double {
  if s.size == 0 { 0.0 } else { net_route_rip_edge_sum(s) / s.size.to_double() }
}

pub fn net_route_rip_edge_scale(s : NetrouteripEdge, f : Double) -> NetrouteripEdge {
  let result = net_route_rip_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_route_rip_edge_add(a : NetrouteripEdge, b : NetrouteripEdge) -> NetrouteripEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_route_rip_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_route_rip_edge_copy(s : NetrouteripEdge) -> NetrouteripEdge {
  let result = net_route_rip_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_route_rip_edge_fill(s : NetrouteripEdge, v : Double) -> NetrouteripEdge {
  let result = net_route_rip_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_route_rip_edge_min(s : NetrouteripEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_route_rip_edge_max(s : NetrouteripEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_route_rip_edge_to_string(s : NetrouteripEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetrouteripPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_rip_path_make(size : Int) -> NetrouteripPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_rip_path_len(s : NetrouteripPath) -> Int { s.size }

pub fn net_route_rip_path_get(s : NetrouteripPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_rip_path_set(s : NetrouteripPath, i : Int, v : Double) -> NetrouteripPath {
  let result = net_route_rip_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_route_rip_path_sum(s : NetrouteripPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_route_rip_path_mean(s : NetrouteripPath) -> Double {
  if s.size == 0 { 0.0 } else { net_route_rip_path_sum(s) / s.size.to_double() }
}

pub fn net_route_rip_path_scale(s : NetrouteripPath, f : Double) -> NetrouteripPath {
  let result = net_route_rip_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_route_rip_path_add(a : NetrouteripPath, b : NetrouteripPath) -> NetrouteripPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_route_rip_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_route_rip_path_copy(s : NetrouteripPath) -> NetrouteripPath {
  let result = net_route_rip_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_route_rip_path_fill(s : NetrouteripPath, v : Double) -> NetrouteripPath {
  let result = net_route_rip_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_route_rip_path_min(s : NetrouteripPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_route_rip_path_max(s : NetrouteripPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_route_rip_path_to_string(s : NetrouteripPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetrouteripCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_rip_cluster_make(size : Int) -> NetrouteripCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_rip_cluster_len(s : NetrouteripCluster) -> Int { s.size }

pub fn net_route_rip_cluster_get(s : NetrouteripCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_rip_cluster_set(s : NetrouteripCluster, i : Int, v : Double) -> NetrouteripCluster {
  let result = net_route_rip_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_route_rip_cluster_sum(s : NetrouteripCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_route_rip_cluster_mean(s : NetrouteripCluster) -> Double {
  if s.size == 0 { 0.0 } else { net_route_rip_cluster_sum(s) / s.size.to_double() }
}

pub fn net_route_rip_cluster_scale(s : NetrouteripCluster, f : Double) -> NetrouteripCluster {
  let result = net_route_rip_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_route_rip_cluster_add(a : NetrouteripCluster, b : NetrouteripCluster) -> NetrouteripCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_route_rip_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_route_rip_cluster_copy(s : NetrouteripCluster) -> NetrouteripCluster {
  let result = net_route_rip_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_route_rip_cluster_fill(s : NetrouteripCluster, v : Double) -> NetrouteripCluster {
  let result = net_route_rip_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_route_rip_cluster_min(s : NetrouteripCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_route_rip_cluster_max(s : NetrouteripCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_route_rip_cluster_to_string(s : NetrouteripCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetrouteripModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_rip_model_make(size : Int) -> NetrouteripModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_rip_model_len(s : NetrouteripModel) -> Int { s.size }

pub fn net_route_rip_model_get(s : NetrouteripModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_rip_model_set(s : NetrouteripModel, i : Int, v : Double) -> NetrouteripModel {
  let result = net_route_rip_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_route_rip_model_sum(s : NetrouteripModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_route_rip_model_mean(s : NetrouteripModel) -> Double {
  if s.size == 0 { 0.0 } else { net_route_rip_model_sum(s) / s.size.to_double() }
}

pub fn net_route_rip_model_scale(s : NetrouteripModel, f : Double) -> NetrouteripModel {
  let result = net_route_rip_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_route_rip_model_add(a : NetrouteripModel, b : NetrouteripModel) -> NetrouteripModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_route_rip_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_route_rip_model_copy(s : NetrouteripModel) -> NetrouteripModel {
  let result = net_route_rip_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_route_rip_model_fill(s : NetrouteripModel, v : Double) -> NetrouteripModel {
  let result = net_route_rip_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_route_rip_model_min(s : NetrouteripModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_route_rip_model_max(s : NetrouteripModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_route_rip_model_to_string(s : NetrouteripModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetrouteripLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_rip_layer_make(size : Int) -> NetrouteripLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_rip_layer_len(s : NetrouteripLayer) -> Int { s.size }

pub fn net_route_rip_layer_get(s : NetrouteripLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_rip_layer_set(s : NetrouteripLayer, i : Int, v : Double) -> NetrouteripLayer {
  let result = net_route_rip_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_route_rip_layer_sum(s : NetrouteripLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_route_rip_layer_mean(s : NetrouteripLayer) -> Double {
  if s.size == 0 { 0.0 } else { net_route_rip_layer_sum(s) / s.size.to_double() }
}

pub fn net_route_rip_layer_scale(s : NetrouteripLayer, f : Double) -> NetrouteripLayer {
  let result = net_route_rip_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_route_rip_layer_add(a : NetrouteripLayer, b : NetrouteripLayer) -> NetrouteripLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_route_rip_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_route_rip_layer_copy(s : NetrouteripLayer) -> NetrouteripLayer {
  let result = net_route_rip_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_route_rip_layer_fill(s : NetrouteripLayer, v : Double) -> NetrouteripLayer {
  let result = net_route_rip_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_route_rip_layer_min(s : NetrouteripLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_route_rip_layer_max(s : NetrouteripLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_route_rip_layer_to_string(s : NetrouteripLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetrouteripBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_rip_buffer_make(size : Int) -> NetrouteripBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_rip_buffer_len(s : NetrouteripBuffer) -> Int { s.size }

pub fn net_route_rip_buffer_get(s : NetrouteripBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_rip_buffer_set(s : NetrouteripBuffer, i : Int, v : Double) -> NetrouteripBuffer {
  let result = net_route_rip_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_route_rip_buffer_sum(s : NetrouteripBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_route_rip_buffer_mean(s : NetrouteripBuffer) -> Double {
  if s.size == 0 { 0.0 } else { net_route_rip_buffer_sum(s) / s.size.to_double() }
}

pub fn net_route_rip_buffer_scale(s : NetrouteripBuffer, f : Double) -> NetrouteripBuffer {
  let result = net_route_rip_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_route_rip_buffer_add(a : NetrouteripBuffer, b : NetrouteripBuffer) -> NetrouteripBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_route_rip_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_route_rip_buffer_copy(s : NetrouteripBuffer) -> NetrouteripBuffer {
  let result = net_route_rip_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_route_rip_buffer_fill(s : NetrouteripBuffer, v : Double) -> NetrouteripBuffer {
  let result = net_route_rip_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_route_rip_buffer_min(s : NetrouteripBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_route_rip_buffer_max(s : NetrouteripBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_route_rip_buffer_to_string(s : NetrouteripBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetrouteripCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_rip_cursor_make(size : Int) -> NetrouteripCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_rip_cursor_len(s : NetrouteripCursor) -> Int { s.size }

pub fn net_route_rip_cursor_get(s : NetrouteripCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_rip_cursor_set(s : NetrouteripCursor, i : Int, v : Double) -> NetrouteripCursor {
  let result = net_route_rip_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_route_rip_cursor_sum(s : NetrouteripCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_route_rip_cursor_mean(s : NetrouteripCursor) -> Double {
  if s.size == 0 { 0.0 } else { net_route_rip_cursor_sum(s) / s.size.to_double() }
}

pub fn net_route_rip_cursor_scale(s : NetrouteripCursor, f : Double) -> NetrouteripCursor {
  let result = net_route_rip_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_route_rip_cursor_add(a : NetrouteripCursor, b : NetrouteripCursor) -> NetrouteripCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_route_rip_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_route_rip_cursor_copy(s : NetrouteripCursor) -> NetrouteripCursor {
  let result = net_route_rip_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_route_rip_cursor_fill(s : NetrouteripCursor, v : Double) -> NetrouteripCursor {
  let result = net_route_rip_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_route_rip_cursor_min(s : NetrouteripCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_route_rip_cursor_max(s : NetrouteripCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_route_rip_cursor_to_string(s : NetrouteripCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetrouteripView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_rip_view_make(size : Int) -> NetrouteripView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_rip_view_len(s : NetrouteripView) -> Int { s.size }

pub fn net_route_rip_view_get(s : NetrouteripView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_rip_view_set(s : NetrouteripView, i : Int, v : Double) -> NetrouteripView {
  let result = net_route_rip_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_route_rip_view_sum(s : NetrouteripView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_route_rip_view_mean(s : NetrouteripView) -> Double {
  if s.size == 0 { 0.0 } else { net_route_rip_view_sum(s) / s.size.to_double() }
}

pub fn net_route_rip_view_scale(s : NetrouteripView, f : Double) -> NetrouteripView {
  let result = net_route_rip_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_route_rip_view_add(a : NetrouteripView, b : NetrouteripView) -> NetrouteripView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_route_rip_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_route_rip_view_copy(s : NetrouteripView) -> NetrouteripView {
  let result = net_route_rip_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_route_rip_view_fill(s : NetrouteripView, v : Double) -> NetrouteripView {
  let result = net_route_rip_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_route_rip_view_min(s : NetrouteripView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_route_rip_view_max(s : NetrouteripView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_route_rip_view_to_string(s : NetrouteripView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetrouteripRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_rip_range_make(size : Int) -> NetrouteripRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_rip_range_len(s : NetrouteripRange) -> Int { s.size }

pub fn net_route_rip_range_get(s : NetrouteripRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_rip_range_set(s : NetrouteripRange, i : Int, v : Double) -> NetrouteripRange {
  let result = net_route_rip_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_route_rip_range_sum(s : NetrouteripRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_route_rip_range_mean(s : NetrouteripRange) -> Double {
  if s.size == 0 { 0.0 } else { net_route_rip_range_sum(s) / s.size.to_double() }
}

pub fn net_route_rip_range_scale(s : NetrouteripRange, f : Double) -> NetrouteripRange {
  let result = net_route_rip_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_route_rip_range_add(a : NetrouteripRange, b : NetrouteripRange) -> NetrouteripRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_route_rip_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_route_rip_range_copy(s : NetrouteripRange) -> NetrouteripRange {
  let result = net_route_rip_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_route_rip_range_fill(s : NetrouteripRange, v : Double) -> NetrouteripRange {
  let result = net_route_rip_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_route_rip_range_min(s : NetrouteripRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_route_rip_range_max(s : NetrouteripRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_route_rip_range_to_string(s : NetrouteripRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetrouteripSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_rip_slice_make(size : Int) -> NetrouteripSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_rip_slice_len(s : NetrouteripSlice) -> Int { s.size }

pub fn net_route_rip_slice_get(s : NetrouteripSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_rip_slice_set(s : NetrouteripSlice, i : Int, v : Double) -> NetrouteripSlice {
  let result = net_route_rip_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_route_rip_slice_sum(s : NetrouteripSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_route_rip_slice_mean(s : NetrouteripSlice) -> Double {
  if s.size == 0 { 0.0 } else { net_route_rip_slice_sum(s) / s.size.to_double() }
}

pub fn net_route_rip_slice_scale(s : NetrouteripSlice, f : Double) -> NetrouteripSlice {
  let result = net_route_rip_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_route_rip_slice_add(a : NetrouteripSlice, b : NetrouteripSlice) -> NetrouteripSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_route_rip_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_route_rip_slice_copy(s : NetrouteripSlice) -> NetrouteripSlice {
  let result = net_route_rip_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_route_rip_slice_fill(s : NetrouteripSlice, v : Double) -> NetrouteripSlice {
  let result = net_route_rip_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_route_rip_slice_min(s : NetrouteripSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_route_rip_slice_max(s : NetrouteripSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_route_rip_slice_to_string(s : NetrouteripSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

