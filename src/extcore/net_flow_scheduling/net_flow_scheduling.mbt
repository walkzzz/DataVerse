///===
/// extcore/net_flow_scheduling

pub(all) struct NetflowschedulingPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn net_flow_scheduling_make_point(x : Double, y : Double) -> NetflowschedulingPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn net_flow_scheduling_make_point3(x : Double, y : Double, z : Double) -> NetflowschedulingPoint {
  { x, y, z, label: 0 }
}

pub fn net_flow_scheduling_point_x(pt : NetflowschedulingPoint) -> Double { pt.x }

pub fn net_flow_scheduling_point_y(pt : NetflowschedulingPoint) -> Double { pt.y }

pub fn net_flow_scheduling_point_z(pt : NetflowschedulingPoint) -> Double { pt.z }

pub fn net_flow_scheduling_point_label(pt : NetflowschedulingPoint) -> Int { pt.label }

pub fn net_flow_scheduling_point_dist(a : NetflowschedulingPoint, b : NetflowschedulingPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn net_flow_scheduling_point_add(a : NetflowschedulingPoint, b : NetflowschedulingPoint) -> NetflowschedulingPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn net_flow_scheduling_point_sub(a : NetflowschedulingPoint, b : NetflowschedulingPoint) -> NetflowschedulingPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn net_flow_scheduling_point_scale(pt : NetflowschedulingPoint, s : Double) -> NetflowschedulingPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn net_flow_scheduling_point_dot(a : NetflowschedulingPoint, b : NetflowschedulingPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn net_flow_scheduling_point_cross(a : NetflowschedulingPoint, b : NetflowschedulingPoint) -> NetflowschedulingPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn net_flow_scheduling_point_norm(pt : NetflowschedulingPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn net_flow_scheduling_point_normalize(pt : NetflowschedulingPoint) -> NetflowschedulingPoint {
  let n = net_flow_scheduling_point_norm(pt)
  if n < 0.0000001 { pt } else { net_flow_scheduling_point_scale(pt, 1.0 / n) }
}

pub fn net_flow_scheduling_point_negate(pt : NetflowschedulingPoint) -> NetflowschedulingPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn net_flow_scheduling_point_mid(a : NetflowschedulingPoint, b : NetflowschedulingPoint) -> NetflowschedulingPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn net_flow_scheduling_point_lerp(a : NetflowschedulingPoint, b : NetflowschedulingPoint, t : Double) -> NetflowschedulingPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn net_flow_scheduling_point_to_string(pt : NetflowschedulingPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct NetflowschedulingSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn net_flow_scheduling_make_series(vals : Array[Double], name : String) -> NetflowschedulingSeries {
  { vals, name, meta: 0 }
}

pub fn net_flow_scheduling_series_len(s : NetflowschedulingSeries) -> Int { s.vals.length() }

pub fn net_flow_scheduling_series_sum(s : NetflowschedulingSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn net_flow_scheduling_series_mean(s : NetflowschedulingSeries) -> Double {
  let n = net_flow_scheduling_series_len(s)
  if n == 0 { 0.0 } else { net_flow_scheduling_series_sum(s) / n.to_double() }
}

pub fn net_flow_scheduling_series_min(s : NetflowschedulingSeries) -> Double {
  let n = net_flow_scheduling_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn net_flow_scheduling_series_max(s : NetflowschedulingSeries) -> Double {
  let n = net_flow_scheduling_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn net_flow_scheduling_series_range(s : NetflowschedulingSeries) -> Double {
  net_flow_scheduling_series_max(s) - net_flow_scheduling_series_min(s)
}

pub fn net_flow_scheduling_series_var(s : NetflowschedulingSeries) -> Double {
  let n = net_flow_scheduling_series_len(s)
  if n == 0 { 0.0 } else {
    let m = net_flow_scheduling_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn net_flow_scheduling_series_std(s : NetflowschedulingSeries) -> Double { @_common.sqrt(net_flow_scheduling_series_var(s)) }

pub fn net_flow_scheduling_series_median(s : NetflowschedulingSeries) -> Double {
  let n = net_flow_scheduling_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = net_flow_scheduling_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn net_flow_scheduling_series_scale(s : NetflowschedulingSeries, f : Double) -> NetflowschedulingSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn net_flow_scheduling_series_add(a : NetflowschedulingSeries, b : NetflowschedulingSeries) -> NetflowschedulingSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn net_flow_scheduling_series_sub(a : NetflowschedulingSeries, b : NetflowschedulingSeries) -> NetflowschedulingSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn net_flow_scheduling_series_normalize(s : NetflowschedulingSeries) -> NetflowschedulingSeries {
  let mn = net_flow_scheduling_series_min(s)
  let mx = net_flow_scheduling_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn net_flow_scheduling_series_cumsum(s : NetflowschedulingSeries) -> NetflowschedulingSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn net_flow_scheduling_series_to_string(s : NetflowschedulingSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NetflowschedulingMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn net_flow_scheduling_make_matrix(rows : Int, cols : Int, val : Double) -> NetflowschedulingMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn net_flow_scheduling_matrix_identity(n : Int) -> NetflowschedulingMatrix {
  let m = net_flow_scheduling_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn net_flow_scheduling_matrix_get(m : NetflowschedulingMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn net_flow_scheduling_matrix_transpose(m : NetflowschedulingMatrix) -> NetflowschedulingMatrix {
  let result = net_flow_scheduling_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn net_flow_scheduling_matrix_add(a : NetflowschedulingMatrix, b : NetflowschedulingMatrix) -> NetflowschedulingMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = net_flow_scheduling_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn net_flow_scheduling_matrix_scale(m : NetflowschedulingMatrix, s : Double) -> NetflowschedulingMatrix {
  let result = net_flow_scheduling_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn net_flow_scheduling_matrix_multiply(a : NetflowschedulingMatrix, b : NetflowschedulingMatrix) -> NetflowschedulingMatrix {
  if a.cols != b.rows { return net_flow_scheduling_make_matrix(a.rows, b.cols, 0.0) }
  let result = net_flow_scheduling_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn net_flow_scheduling_matrix_trace(m : NetflowschedulingMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn net_flow_scheduling_matrix_det(m : NetflowschedulingMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn net_flow_scheduling_matrix_norm(m : NetflowschedulingMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn net_flow_scheduling_matrix_to_string(m : NetflowschedulingMatrix) -> String {
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

pub(all) struct NetflowschedulingVector {
  comps : Array[Double]
  dim : Int
}

pub fn net_flow_scheduling_make_vector(comps : Array[Double]) -> NetflowschedulingVector {
  { comps, dim: comps.length() }
}

pub fn net_flow_scheduling_vector_zero(dim : Int) -> NetflowschedulingVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn net_flow_scheduling_vector_add(a : NetflowschedulingVector, b : NetflowschedulingVector) -> NetflowschedulingVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn net_flow_scheduling_vector_sub(a : NetflowschedulingVector, b : NetflowschedulingVector) -> NetflowschedulingVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn net_flow_scheduling_vector_scale(v : NetflowschedulingVector, s : Double) -> NetflowschedulingVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn net_flow_scheduling_vector_dot(a : NetflowschedulingVector, b : NetflowschedulingVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn net_flow_scheduling_vector_norm(v : NetflowschedulingVector) -> Double { @_common.sqrt(net_flow_scheduling_vector_dot(v, v)) }

pub fn net_flow_scheduling_vector_normalize(v : NetflowschedulingVector) -> NetflowschedulingVector {
  let n = net_flow_scheduling_vector_norm(v)
  if n < 0.0000001 { v } else { net_flow_scheduling_vector_scale(v, 1.0 / n) }
}

pub fn net_flow_scheduling_vector_dist(a : NetflowschedulingVector, b : NetflowschedulingVector) -> Double {
  net_flow_scheduling_vector_norm(net_flow_scheduling_vector_sub(a, b))
}

pub fn net_flow_scheduling_vector_to_string(v : NetflowschedulingVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn net_flow_scheduling_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn net_flow_scheduling_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn net_flow_scheduling_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn net_flow_scheduling_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn net_flow_scheduling_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn net_flow_scheduling_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn net_flow_scheduling_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn net_flow_scheduling_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn net_flow_scheduling_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn net_flow_scheduling_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn net_flow_scheduling_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn net_flow_scheduling_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn net_flow_scheduling_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn net_flow_scheduling_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn net_flow_scheduling_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn net_flow_scheduling_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn net_flow_scheduling_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn net_flow_scheduling_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn net_flow_scheduling_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn net_flow_scheduling_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn net_flow_scheduling_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn net_flow_scheduling_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn net_flow_scheduling_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn net_flow_scheduling_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn net_flow_scheduling_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn net_flow_scheduling_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn net_flow_scheduling_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn net_flow_scheduling_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn net_flow_scheduling_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct NetflowschedulingFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_scheduling_frame_make(size : Int) -> NetflowschedulingFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_scheduling_frame_len(s : NetflowschedulingFrame) -> Int { s.size }

pub fn net_flow_scheduling_frame_get(s : NetflowschedulingFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_scheduling_frame_set(s : NetflowschedulingFrame, i : Int, v : Double) -> NetflowschedulingFrame {
  let result = net_flow_scheduling_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_flow_scheduling_frame_sum(s : NetflowschedulingFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_flow_scheduling_frame_mean(s : NetflowschedulingFrame) -> Double {
  if s.size == 0 { 0.0 } else { net_flow_scheduling_frame_sum(s) / s.size.to_double() }
}

pub fn net_flow_scheduling_frame_scale(s : NetflowschedulingFrame, f : Double) -> NetflowschedulingFrame {
  let result = net_flow_scheduling_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_flow_scheduling_frame_add(a : NetflowschedulingFrame, b : NetflowschedulingFrame) -> NetflowschedulingFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_flow_scheduling_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_flow_scheduling_frame_copy(s : NetflowschedulingFrame) -> NetflowschedulingFrame {
  let result = net_flow_scheduling_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_flow_scheduling_frame_fill(s : NetflowschedulingFrame, v : Double) -> NetflowschedulingFrame {
  let result = net_flow_scheduling_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_flow_scheduling_frame_min(s : NetflowschedulingFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_scheduling_frame_max(s : NetflowschedulingFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_scheduling_frame_to_string(s : NetflowschedulingFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowschedulingTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_scheduling_table_make(size : Int) -> NetflowschedulingTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_scheduling_table_len(s : NetflowschedulingTable) -> Int { s.size }

pub fn net_flow_scheduling_table_get(s : NetflowschedulingTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_scheduling_table_set(s : NetflowschedulingTable, i : Int, v : Double) -> NetflowschedulingTable {
  let result = net_flow_scheduling_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_flow_scheduling_table_sum(s : NetflowschedulingTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_flow_scheduling_table_mean(s : NetflowschedulingTable) -> Double {
  if s.size == 0 { 0.0 } else { net_flow_scheduling_table_sum(s) / s.size.to_double() }
}

pub fn net_flow_scheduling_table_scale(s : NetflowschedulingTable, f : Double) -> NetflowschedulingTable {
  let result = net_flow_scheduling_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_flow_scheduling_table_add(a : NetflowschedulingTable, b : NetflowschedulingTable) -> NetflowschedulingTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_flow_scheduling_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_flow_scheduling_table_copy(s : NetflowschedulingTable) -> NetflowschedulingTable {
  let result = net_flow_scheduling_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_flow_scheduling_table_fill(s : NetflowschedulingTable, v : Double) -> NetflowschedulingTable {
  let result = net_flow_scheduling_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_flow_scheduling_table_min(s : NetflowschedulingTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_scheduling_table_max(s : NetflowschedulingTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_scheduling_table_to_string(s : NetflowschedulingTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowschedulingGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_scheduling_graphn_make(size : Int) -> NetflowschedulingGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_scheduling_graphn_len(s : NetflowschedulingGraphN) -> Int { s.size }

pub fn net_flow_scheduling_graphn_get(s : NetflowschedulingGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_scheduling_graphn_set(s : NetflowschedulingGraphN, i : Int, v : Double) -> NetflowschedulingGraphN {
  let result = net_flow_scheduling_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_flow_scheduling_graphn_sum(s : NetflowschedulingGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_flow_scheduling_graphn_mean(s : NetflowschedulingGraphN) -> Double {
  if s.size == 0 { 0.0 } else { net_flow_scheduling_graphn_sum(s) / s.size.to_double() }
}

pub fn net_flow_scheduling_graphn_scale(s : NetflowschedulingGraphN, f : Double) -> NetflowschedulingGraphN {
  let result = net_flow_scheduling_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_flow_scheduling_graphn_add(a : NetflowschedulingGraphN, b : NetflowschedulingGraphN) -> NetflowschedulingGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_flow_scheduling_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_flow_scheduling_graphn_copy(s : NetflowschedulingGraphN) -> NetflowschedulingGraphN {
  let result = net_flow_scheduling_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_flow_scheduling_graphn_fill(s : NetflowschedulingGraphN, v : Double) -> NetflowschedulingGraphN {
  let result = net_flow_scheduling_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_flow_scheduling_graphn_min(s : NetflowschedulingGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_scheduling_graphn_max(s : NetflowschedulingGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_scheduling_graphn_to_string(s : NetflowschedulingGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowschedulingNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_scheduling_node_make(size : Int) -> NetflowschedulingNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_scheduling_node_len(s : NetflowschedulingNode) -> Int { s.size }

pub fn net_flow_scheduling_node_get(s : NetflowschedulingNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_scheduling_node_set(s : NetflowschedulingNode, i : Int, v : Double) -> NetflowschedulingNode {
  let result = net_flow_scheduling_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_flow_scheduling_node_sum(s : NetflowschedulingNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_flow_scheduling_node_mean(s : NetflowschedulingNode) -> Double {
  if s.size == 0 { 0.0 } else { net_flow_scheduling_node_sum(s) / s.size.to_double() }
}

pub fn net_flow_scheduling_node_scale(s : NetflowschedulingNode, f : Double) -> NetflowschedulingNode {
  let result = net_flow_scheduling_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_flow_scheduling_node_add(a : NetflowschedulingNode, b : NetflowschedulingNode) -> NetflowschedulingNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_flow_scheduling_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_flow_scheduling_node_copy(s : NetflowschedulingNode) -> NetflowschedulingNode {
  let result = net_flow_scheduling_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_flow_scheduling_node_fill(s : NetflowschedulingNode, v : Double) -> NetflowschedulingNode {
  let result = net_flow_scheduling_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_flow_scheduling_node_min(s : NetflowschedulingNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_scheduling_node_max(s : NetflowschedulingNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_scheduling_node_to_string(s : NetflowschedulingNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowschedulingEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_scheduling_edge_make(size : Int) -> NetflowschedulingEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_scheduling_edge_len(s : NetflowschedulingEdge) -> Int { s.size }

pub fn net_flow_scheduling_edge_get(s : NetflowschedulingEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_scheduling_edge_set(s : NetflowschedulingEdge, i : Int, v : Double) -> NetflowschedulingEdge {
  let result = net_flow_scheduling_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_flow_scheduling_edge_sum(s : NetflowschedulingEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_flow_scheduling_edge_mean(s : NetflowschedulingEdge) -> Double {
  if s.size == 0 { 0.0 } else { net_flow_scheduling_edge_sum(s) / s.size.to_double() }
}

pub fn net_flow_scheduling_edge_scale(s : NetflowschedulingEdge, f : Double) -> NetflowschedulingEdge {
  let result = net_flow_scheduling_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_flow_scheduling_edge_add(a : NetflowschedulingEdge, b : NetflowschedulingEdge) -> NetflowschedulingEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_flow_scheduling_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_flow_scheduling_edge_copy(s : NetflowschedulingEdge) -> NetflowschedulingEdge {
  let result = net_flow_scheduling_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_flow_scheduling_edge_fill(s : NetflowschedulingEdge, v : Double) -> NetflowschedulingEdge {
  let result = net_flow_scheduling_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_flow_scheduling_edge_min(s : NetflowschedulingEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_scheduling_edge_max(s : NetflowschedulingEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_scheduling_edge_to_string(s : NetflowschedulingEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowschedulingPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_scheduling_path_make(size : Int) -> NetflowschedulingPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_scheduling_path_len(s : NetflowschedulingPath) -> Int { s.size }

pub fn net_flow_scheduling_path_get(s : NetflowschedulingPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_scheduling_path_set(s : NetflowschedulingPath, i : Int, v : Double) -> NetflowschedulingPath {
  let result = net_flow_scheduling_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_flow_scheduling_path_sum(s : NetflowschedulingPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_flow_scheduling_path_mean(s : NetflowschedulingPath) -> Double {
  if s.size == 0 { 0.0 } else { net_flow_scheduling_path_sum(s) / s.size.to_double() }
}

pub fn net_flow_scheduling_path_scale(s : NetflowschedulingPath, f : Double) -> NetflowschedulingPath {
  let result = net_flow_scheduling_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_flow_scheduling_path_add(a : NetflowschedulingPath, b : NetflowschedulingPath) -> NetflowschedulingPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_flow_scheduling_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_flow_scheduling_path_copy(s : NetflowschedulingPath) -> NetflowschedulingPath {
  let result = net_flow_scheduling_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_flow_scheduling_path_fill(s : NetflowschedulingPath, v : Double) -> NetflowschedulingPath {
  let result = net_flow_scheduling_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_flow_scheduling_path_min(s : NetflowschedulingPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_scheduling_path_max(s : NetflowschedulingPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_scheduling_path_to_string(s : NetflowschedulingPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowschedulingCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_scheduling_cluster_make(size : Int) -> NetflowschedulingCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_scheduling_cluster_len(s : NetflowschedulingCluster) -> Int { s.size }

pub fn net_flow_scheduling_cluster_get(s : NetflowschedulingCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_scheduling_cluster_set(s : NetflowschedulingCluster, i : Int, v : Double) -> NetflowschedulingCluster {
  let result = net_flow_scheduling_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_flow_scheduling_cluster_sum(s : NetflowschedulingCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_flow_scheduling_cluster_mean(s : NetflowschedulingCluster) -> Double {
  if s.size == 0 { 0.0 } else { net_flow_scheduling_cluster_sum(s) / s.size.to_double() }
}

pub fn net_flow_scheduling_cluster_scale(s : NetflowschedulingCluster, f : Double) -> NetflowschedulingCluster {
  let result = net_flow_scheduling_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_flow_scheduling_cluster_add(a : NetflowschedulingCluster, b : NetflowschedulingCluster) -> NetflowschedulingCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_flow_scheduling_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_flow_scheduling_cluster_copy(s : NetflowschedulingCluster) -> NetflowschedulingCluster {
  let result = net_flow_scheduling_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_flow_scheduling_cluster_fill(s : NetflowschedulingCluster, v : Double) -> NetflowschedulingCluster {
  let result = net_flow_scheduling_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_flow_scheduling_cluster_min(s : NetflowschedulingCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_scheduling_cluster_max(s : NetflowschedulingCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_scheduling_cluster_to_string(s : NetflowschedulingCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowschedulingModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_scheduling_model_make(size : Int) -> NetflowschedulingModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_scheduling_model_len(s : NetflowschedulingModel) -> Int { s.size }

pub fn net_flow_scheduling_model_get(s : NetflowschedulingModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_scheduling_model_set(s : NetflowschedulingModel, i : Int, v : Double) -> NetflowschedulingModel {
  let result = net_flow_scheduling_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_flow_scheduling_model_sum(s : NetflowschedulingModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_flow_scheduling_model_mean(s : NetflowschedulingModel) -> Double {
  if s.size == 0 { 0.0 } else { net_flow_scheduling_model_sum(s) / s.size.to_double() }
}

pub fn net_flow_scheduling_model_scale(s : NetflowschedulingModel, f : Double) -> NetflowschedulingModel {
  let result = net_flow_scheduling_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_flow_scheduling_model_add(a : NetflowschedulingModel, b : NetflowschedulingModel) -> NetflowschedulingModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_flow_scheduling_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_flow_scheduling_model_copy(s : NetflowschedulingModel) -> NetflowschedulingModel {
  let result = net_flow_scheduling_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_flow_scheduling_model_fill(s : NetflowschedulingModel, v : Double) -> NetflowschedulingModel {
  let result = net_flow_scheduling_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_flow_scheduling_model_min(s : NetflowschedulingModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_scheduling_model_max(s : NetflowschedulingModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_scheduling_model_to_string(s : NetflowschedulingModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowschedulingLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_scheduling_layer_make(size : Int) -> NetflowschedulingLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_scheduling_layer_len(s : NetflowschedulingLayer) -> Int { s.size }

pub fn net_flow_scheduling_layer_get(s : NetflowschedulingLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_scheduling_layer_set(s : NetflowschedulingLayer, i : Int, v : Double) -> NetflowschedulingLayer {
  let result = net_flow_scheduling_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_flow_scheduling_layer_sum(s : NetflowschedulingLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_flow_scheduling_layer_mean(s : NetflowschedulingLayer) -> Double {
  if s.size == 0 { 0.0 } else { net_flow_scheduling_layer_sum(s) / s.size.to_double() }
}

pub fn net_flow_scheduling_layer_scale(s : NetflowschedulingLayer, f : Double) -> NetflowschedulingLayer {
  let result = net_flow_scheduling_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_flow_scheduling_layer_add(a : NetflowschedulingLayer, b : NetflowschedulingLayer) -> NetflowschedulingLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_flow_scheduling_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_flow_scheduling_layer_copy(s : NetflowschedulingLayer) -> NetflowschedulingLayer {
  let result = net_flow_scheduling_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_flow_scheduling_layer_fill(s : NetflowschedulingLayer, v : Double) -> NetflowschedulingLayer {
  let result = net_flow_scheduling_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_flow_scheduling_layer_min(s : NetflowschedulingLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_scheduling_layer_max(s : NetflowschedulingLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_scheduling_layer_to_string(s : NetflowschedulingLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowschedulingBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_scheduling_buffer_make(size : Int) -> NetflowschedulingBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_scheduling_buffer_len(s : NetflowschedulingBuffer) -> Int { s.size }

pub fn net_flow_scheduling_buffer_get(s : NetflowschedulingBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_scheduling_buffer_set(s : NetflowschedulingBuffer, i : Int, v : Double) -> NetflowschedulingBuffer {
  let result = net_flow_scheduling_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_flow_scheduling_buffer_sum(s : NetflowschedulingBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_flow_scheduling_buffer_mean(s : NetflowschedulingBuffer) -> Double {
  if s.size == 0 { 0.0 } else { net_flow_scheduling_buffer_sum(s) / s.size.to_double() }
}

pub fn net_flow_scheduling_buffer_scale(s : NetflowschedulingBuffer, f : Double) -> NetflowschedulingBuffer {
  let result = net_flow_scheduling_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_flow_scheduling_buffer_add(a : NetflowschedulingBuffer, b : NetflowschedulingBuffer) -> NetflowschedulingBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_flow_scheduling_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_flow_scheduling_buffer_copy(s : NetflowschedulingBuffer) -> NetflowschedulingBuffer {
  let result = net_flow_scheduling_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_flow_scheduling_buffer_fill(s : NetflowschedulingBuffer, v : Double) -> NetflowschedulingBuffer {
  let result = net_flow_scheduling_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_flow_scheduling_buffer_min(s : NetflowschedulingBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_scheduling_buffer_max(s : NetflowschedulingBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_scheduling_buffer_to_string(s : NetflowschedulingBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowschedulingCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_scheduling_cursor_make(size : Int) -> NetflowschedulingCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_scheduling_cursor_len(s : NetflowschedulingCursor) -> Int { s.size }

pub fn net_flow_scheduling_cursor_get(s : NetflowschedulingCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_scheduling_cursor_set(s : NetflowschedulingCursor, i : Int, v : Double) -> NetflowschedulingCursor {
  let result = net_flow_scheduling_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_flow_scheduling_cursor_sum(s : NetflowschedulingCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_flow_scheduling_cursor_mean(s : NetflowschedulingCursor) -> Double {
  if s.size == 0 { 0.0 } else { net_flow_scheduling_cursor_sum(s) / s.size.to_double() }
}

pub fn net_flow_scheduling_cursor_scale(s : NetflowschedulingCursor, f : Double) -> NetflowschedulingCursor {
  let result = net_flow_scheduling_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_flow_scheduling_cursor_add(a : NetflowschedulingCursor, b : NetflowschedulingCursor) -> NetflowschedulingCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_flow_scheduling_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_flow_scheduling_cursor_copy(s : NetflowschedulingCursor) -> NetflowschedulingCursor {
  let result = net_flow_scheduling_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_flow_scheduling_cursor_fill(s : NetflowschedulingCursor, v : Double) -> NetflowschedulingCursor {
  let result = net_flow_scheduling_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_flow_scheduling_cursor_min(s : NetflowschedulingCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_scheduling_cursor_max(s : NetflowschedulingCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_scheduling_cursor_to_string(s : NetflowschedulingCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowschedulingView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_scheduling_view_make(size : Int) -> NetflowschedulingView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_scheduling_view_len(s : NetflowschedulingView) -> Int { s.size }

pub fn net_flow_scheduling_view_get(s : NetflowschedulingView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_scheduling_view_set(s : NetflowschedulingView, i : Int, v : Double) -> NetflowschedulingView {
  let result = net_flow_scheduling_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_flow_scheduling_view_sum(s : NetflowschedulingView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_flow_scheduling_view_mean(s : NetflowschedulingView) -> Double {
  if s.size == 0 { 0.0 } else { net_flow_scheduling_view_sum(s) / s.size.to_double() }
}

pub fn net_flow_scheduling_view_scale(s : NetflowschedulingView, f : Double) -> NetflowschedulingView {
  let result = net_flow_scheduling_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_flow_scheduling_view_add(a : NetflowschedulingView, b : NetflowschedulingView) -> NetflowschedulingView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_flow_scheduling_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_flow_scheduling_view_copy(s : NetflowschedulingView) -> NetflowschedulingView {
  let result = net_flow_scheduling_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_flow_scheduling_view_fill(s : NetflowschedulingView, v : Double) -> NetflowschedulingView {
  let result = net_flow_scheduling_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_flow_scheduling_view_min(s : NetflowschedulingView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_scheduling_view_max(s : NetflowschedulingView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_scheduling_view_to_string(s : NetflowschedulingView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowschedulingRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_scheduling_range_make(size : Int) -> NetflowschedulingRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_scheduling_range_len(s : NetflowschedulingRange) -> Int { s.size }

pub fn net_flow_scheduling_range_get(s : NetflowschedulingRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_scheduling_range_set(s : NetflowschedulingRange, i : Int, v : Double) -> NetflowschedulingRange {
  let result = net_flow_scheduling_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_flow_scheduling_range_sum(s : NetflowschedulingRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_flow_scheduling_range_mean(s : NetflowschedulingRange) -> Double {
  if s.size == 0 { 0.0 } else { net_flow_scheduling_range_sum(s) / s.size.to_double() }
}

pub fn net_flow_scheduling_range_scale(s : NetflowschedulingRange, f : Double) -> NetflowschedulingRange {
  let result = net_flow_scheduling_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_flow_scheduling_range_add(a : NetflowschedulingRange, b : NetflowschedulingRange) -> NetflowschedulingRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_flow_scheduling_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_flow_scheduling_range_copy(s : NetflowschedulingRange) -> NetflowschedulingRange {
  let result = net_flow_scheduling_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_flow_scheduling_range_fill(s : NetflowschedulingRange, v : Double) -> NetflowschedulingRange {
  let result = net_flow_scheduling_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_flow_scheduling_range_min(s : NetflowschedulingRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_scheduling_range_max(s : NetflowschedulingRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_scheduling_range_to_string(s : NetflowschedulingRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowschedulingSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_scheduling_slice_make(size : Int) -> NetflowschedulingSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_scheduling_slice_len(s : NetflowschedulingSlice) -> Int { s.size }

pub fn net_flow_scheduling_slice_get(s : NetflowschedulingSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_scheduling_slice_set(s : NetflowschedulingSlice, i : Int, v : Double) -> NetflowschedulingSlice {
  let result = net_flow_scheduling_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_flow_scheduling_slice_sum(s : NetflowschedulingSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_flow_scheduling_slice_mean(s : NetflowschedulingSlice) -> Double {
  if s.size == 0 { 0.0 } else { net_flow_scheduling_slice_sum(s) / s.size.to_double() }
}

pub fn net_flow_scheduling_slice_scale(s : NetflowschedulingSlice, f : Double) -> NetflowschedulingSlice {
  let result = net_flow_scheduling_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_flow_scheduling_slice_add(a : NetflowschedulingSlice, b : NetflowschedulingSlice) -> NetflowschedulingSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_flow_scheduling_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_flow_scheduling_slice_copy(s : NetflowschedulingSlice) -> NetflowschedulingSlice {
  let result = net_flow_scheduling_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_flow_scheduling_slice_fill(s : NetflowschedulingSlice, v : Double) -> NetflowschedulingSlice {
  let result = net_flow_scheduling_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_flow_scheduling_slice_min(s : NetflowschedulingSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_scheduling_slice_max(s : NetflowschedulingSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_scheduling_slice_to_string(s : NetflowschedulingSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

