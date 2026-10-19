///===
/// extcore/net_flow_backpressure

pub(all) struct NetflowbackpressurePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn net_flow_backpressure_make_point(x : Double, y : Double) -> NetflowbackpressurePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn net_flow_backpressure_make_point3(x : Double, y : Double, z : Double) -> NetflowbackpressurePoint {
  { x, y, z, label: 0 }
}

pub fn net_flow_backpressure_point_x(pt : NetflowbackpressurePoint) -> Double { pt.x }

pub fn net_flow_backpressure_point_y(pt : NetflowbackpressurePoint) -> Double { pt.y }

pub fn net_flow_backpressure_point_z(pt : NetflowbackpressurePoint) -> Double { pt.z }

pub fn net_flow_backpressure_point_label(pt : NetflowbackpressurePoint) -> Int { pt.label }

pub fn net_flow_backpressure_point_dist(a : NetflowbackpressurePoint, b : NetflowbackpressurePoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn net_flow_backpressure_point_add(a : NetflowbackpressurePoint, b : NetflowbackpressurePoint) -> NetflowbackpressurePoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn net_flow_backpressure_point_sub(a : NetflowbackpressurePoint, b : NetflowbackpressurePoint) -> NetflowbackpressurePoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn net_flow_backpressure_point_scale(pt : NetflowbackpressurePoint, s : Double) -> NetflowbackpressurePoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn net_flow_backpressure_point_dot(a : NetflowbackpressurePoint, b : NetflowbackpressurePoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn net_flow_backpressure_point_cross(a : NetflowbackpressurePoint, b : NetflowbackpressurePoint) -> NetflowbackpressurePoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn net_flow_backpressure_point_norm(pt : NetflowbackpressurePoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn net_flow_backpressure_point_normalize(pt : NetflowbackpressurePoint) -> NetflowbackpressurePoint {
  let n = net_flow_backpressure_point_norm(pt)
  if n < 0.0000001 { pt } else { net_flow_backpressure_point_scale(pt, 1.0 / n) }
}

pub fn net_flow_backpressure_point_negate(pt : NetflowbackpressurePoint) -> NetflowbackpressurePoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn net_flow_backpressure_point_mid(a : NetflowbackpressurePoint, b : NetflowbackpressurePoint) -> NetflowbackpressurePoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn net_flow_backpressure_point_lerp(a : NetflowbackpressurePoint, b : NetflowbackpressurePoint, t : Double) -> NetflowbackpressurePoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn net_flow_backpressure_point_to_string(pt : NetflowbackpressurePoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct NetflowbackpressureSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn net_flow_backpressure_make_series(vals : Array[Double], name : String) -> NetflowbackpressureSeries {
  { vals, name, meta: 0 }
}

pub fn net_flow_backpressure_series_len(s : NetflowbackpressureSeries) -> Int { s.vals.length() }

pub fn net_flow_backpressure_series_sum(s : NetflowbackpressureSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn net_flow_backpressure_series_mean(s : NetflowbackpressureSeries) -> Double {
  let n = net_flow_backpressure_series_len(s)
  if n == 0 { 0.0 } else { net_flow_backpressure_series_sum(s) / n.to_double() }
}

pub fn net_flow_backpressure_series_min(s : NetflowbackpressureSeries) -> Double {
  let n = net_flow_backpressure_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn net_flow_backpressure_series_max(s : NetflowbackpressureSeries) -> Double {
  let n = net_flow_backpressure_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn net_flow_backpressure_series_range(s : NetflowbackpressureSeries) -> Double {
  net_flow_backpressure_series_max(s) - net_flow_backpressure_series_min(s)
}

pub fn net_flow_backpressure_series_var(s : NetflowbackpressureSeries) -> Double {
  let n = net_flow_backpressure_series_len(s)
  if n == 0 { 0.0 } else {
    let m = net_flow_backpressure_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn net_flow_backpressure_series_std(s : NetflowbackpressureSeries) -> Double { @_common.sqrt(net_flow_backpressure_series_var(s)) }

pub fn net_flow_backpressure_series_median(s : NetflowbackpressureSeries) -> Double {
  let n = net_flow_backpressure_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = net_flow_backpressure_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn net_flow_backpressure_series_scale(s : NetflowbackpressureSeries, f : Double) -> NetflowbackpressureSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn net_flow_backpressure_series_add(a : NetflowbackpressureSeries, b : NetflowbackpressureSeries) -> NetflowbackpressureSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn net_flow_backpressure_series_sub(a : NetflowbackpressureSeries, b : NetflowbackpressureSeries) -> NetflowbackpressureSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn net_flow_backpressure_series_normalize(s : NetflowbackpressureSeries) -> NetflowbackpressureSeries {
  let mn = net_flow_backpressure_series_min(s)
  let mx = net_flow_backpressure_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn net_flow_backpressure_series_cumsum(s : NetflowbackpressureSeries) -> NetflowbackpressureSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn net_flow_backpressure_series_to_string(s : NetflowbackpressureSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NetflowbackpressureMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn net_flow_backpressure_make_matrix(rows : Int, cols : Int, val : Double) -> NetflowbackpressureMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn net_flow_backpressure_matrix_identity(n : Int) -> NetflowbackpressureMatrix {
  let m = net_flow_backpressure_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn net_flow_backpressure_matrix_get(m : NetflowbackpressureMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn net_flow_backpressure_matrix_transpose(m : NetflowbackpressureMatrix) -> NetflowbackpressureMatrix {
  let result = net_flow_backpressure_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn net_flow_backpressure_matrix_add(a : NetflowbackpressureMatrix, b : NetflowbackpressureMatrix) -> NetflowbackpressureMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = net_flow_backpressure_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn net_flow_backpressure_matrix_scale(m : NetflowbackpressureMatrix, s : Double) -> NetflowbackpressureMatrix {
  let result = net_flow_backpressure_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn net_flow_backpressure_matrix_multiply(a : NetflowbackpressureMatrix, b : NetflowbackpressureMatrix) -> NetflowbackpressureMatrix {
  if a.cols != b.rows { return net_flow_backpressure_make_matrix(a.rows, b.cols, 0.0) }
  let result = net_flow_backpressure_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn net_flow_backpressure_matrix_trace(m : NetflowbackpressureMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn net_flow_backpressure_matrix_det(m : NetflowbackpressureMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn net_flow_backpressure_matrix_norm(m : NetflowbackpressureMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn net_flow_backpressure_matrix_to_string(m : NetflowbackpressureMatrix) -> String {
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

pub(all) struct NetflowbackpressureVector {
  comps : Array[Double]
  dim : Int
}

pub fn net_flow_backpressure_make_vector(comps : Array[Double]) -> NetflowbackpressureVector {
  { comps, dim: comps.length() }
}

pub fn net_flow_backpressure_vector_zero(dim : Int) -> NetflowbackpressureVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn net_flow_backpressure_vector_add(a : NetflowbackpressureVector, b : NetflowbackpressureVector) -> NetflowbackpressureVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn net_flow_backpressure_vector_sub(a : NetflowbackpressureVector, b : NetflowbackpressureVector) -> NetflowbackpressureVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn net_flow_backpressure_vector_scale(v : NetflowbackpressureVector, s : Double) -> NetflowbackpressureVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn net_flow_backpressure_vector_dot(a : NetflowbackpressureVector, b : NetflowbackpressureVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn net_flow_backpressure_vector_norm(v : NetflowbackpressureVector) -> Double { @_common.sqrt(net_flow_backpressure_vector_dot(v, v)) }

pub fn net_flow_backpressure_vector_normalize(v : NetflowbackpressureVector) -> NetflowbackpressureVector {
  let n = net_flow_backpressure_vector_norm(v)
  if n < 0.0000001 { v } else { net_flow_backpressure_vector_scale(v, 1.0 / n) }
}

pub fn net_flow_backpressure_vector_dist(a : NetflowbackpressureVector, b : NetflowbackpressureVector) -> Double {
  net_flow_backpressure_vector_norm(net_flow_backpressure_vector_sub(a, b))
}

pub fn net_flow_backpressure_vector_to_string(v : NetflowbackpressureVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn net_flow_backpressure_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn net_flow_backpressure_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = net_flow_backpressure_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn net_flow_backpressure_std(data : Array[Double]) -> Double { @_common.sqrt(net_flow_backpressure_var(data)) }

pub fn net_flow_backpressure_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = net_flow_backpressure_mean(a); let mb = net_flow_backpressure_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn net_flow_backpressure_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = net_flow_backpressure_std(a); let sb = net_flow_backpressure_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { net_flow_backpressure_cov(a, b) / (sa * sb) }
}

pub fn net_flow_backpressure_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = net_flow_backpressure_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn net_flow_backpressure_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn net_flow_backpressure_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn net_flow_backpressure_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  @_common.sqrt(net_flow_backpressure_mse(pred, labels))
}

pub fn net_flow_backpressure_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn net_flow_backpressure_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = net_flow_backpressure_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn net_flow_backpressure_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn net_flow_backpressure_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn net_flow_backpressure_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = net_flow_backpressure_precision(pred, labels, pos); let r = net_flow_backpressure_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn net_flow_backpressure_sort(arr : Array[Double]) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  for i in 0..<n {
    let mut min_idx = i
    let start = i + 1
    for j in start..<n { if result[j] < result[min_idx] { min_idx = j } }
    let tmp = result[i]; result[i] = result[min_idx]; result[min_idx] = tmp
  }
  result
}

pub fn net_flow_backpressure_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = net_flow_backpressure_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn net_flow_backpressure_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn net_flow_backpressure_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn net_flow_backpressure_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = net_flow_backpressure_gcd(a, b)
    (a / g) * b
  }
}

pub fn net_flow_backpressure_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn net_flow_backpressure_fibonacci(n : Int) -> Int {
  if n < 2 {
    n
  } else {
    let mut a = 0
    let mut b = 1
    let end = n + 1
    for _ in 2..<end {
      let c = a + b
      a = b
      b = c
    }
    b
  }
}

pub fn net_flow_backpressure_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = net_flow_backpressure_min(data); let mx = net_flow_backpressure_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn net_flow_backpressure_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = net_flow_backpressure_mean(data); let sd = net_flow_backpressure_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn net_flow_backpressure_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn net_flow_backpressure_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn net_flow_backpressure_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn net_flow_backpressure_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn net_flow_backpressure_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn net_flow_backpressure_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

pub(all) struct NetflowbackpressureFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_backpressure_frame_make(size : Int) -> NetflowbackpressureFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_backpressure_frame_len(s : NetflowbackpressureFrame) -> Int { s.size }

pub fn net_flow_backpressure_frame_get(s : NetflowbackpressureFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_backpressure_frame_set(s : NetflowbackpressureFrame, i : Int, v : Double) -> NetflowbackpressureFrame {
  let result = net_flow_backpressure_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_flow_backpressure_frame_sum(s : NetflowbackpressureFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_flow_backpressure_frame_mean(s : NetflowbackpressureFrame) -> Double {
  if s.size == 0 { 0.0 } else { net_flow_backpressure_frame_sum(s) / s.size.to_double() }
}

pub fn net_flow_backpressure_frame_scale(s : NetflowbackpressureFrame, f : Double) -> NetflowbackpressureFrame {
  let result = net_flow_backpressure_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_flow_backpressure_frame_add(a : NetflowbackpressureFrame, b : NetflowbackpressureFrame) -> NetflowbackpressureFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_flow_backpressure_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_flow_backpressure_frame_copy(s : NetflowbackpressureFrame) -> NetflowbackpressureFrame {
  let result = net_flow_backpressure_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_flow_backpressure_frame_fill(s : NetflowbackpressureFrame, v : Double) -> NetflowbackpressureFrame {
  let result = net_flow_backpressure_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_flow_backpressure_frame_min(s : NetflowbackpressureFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_backpressure_frame_max(s : NetflowbackpressureFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_backpressure_frame_to_string(s : NetflowbackpressureFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowbackpressureTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_backpressure_table_make(size : Int) -> NetflowbackpressureTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_backpressure_table_len(s : NetflowbackpressureTable) -> Int { s.size }

pub fn net_flow_backpressure_table_get(s : NetflowbackpressureTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_backpressure_table_set(s : NetflowbackpressureTable, i : Int, v : Double) -> NetflowbackpressureTable {
  let result = net_flow_backpressure_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_flow_backpressure_table_sum(s : NetflowbackpressureTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_flow_backpressure_table_mean(s : NetflowbackpressureTable) -> Double {
  if s.size == 0 { 0.0 } else { net_flow_backpressure_table_sum(s) / s.size.to_double() }
}

pub fn net_flow_backpressure_table_scale(s : NetflowbackpressureTable, f : Double) -> NetflowbackpressureTable {
  let result = net_flow_backpressure_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_flow_backpressure_table_add(a : NetflowbackpressureTable, b : NetflowbackpressureTable) -> NetflowbackpressureTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_flow_backpressure_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_flow_backpressure_table_copy(s : NetflowbackpressureTable) -> NetflowbackpressureTable {
  let result = net_flow_backpressure_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_flow_backpressure_table_fill(s : NetflowbackpressureTable, v : Double) -> NetflowbackpressureTable {
  let result = net_flow_backpressure_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_flow_backpressure_table_min(s : NetflowbackpressureTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_backpressure_table_max(s : NetflowbackpressureTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_backpressure_table_to_string(s : NetflowbackpressureTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowbackpressureGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_backpressure_graphn_make(size : Int) -> NetflowbackpressureGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_backpressure_graphn_len(s : NetflowbackpressureGraphN) -> Int { s.size }

pub fn net_flow_backpressure_graphn_get(s : NetflowbackpressureGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_backpressure_graphn_set(s : NetflowbackpressureGraphN, i : Int, v : Double) -> NetflowbackpressureGraphN {
  let result = net_flow_backpressure_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_flow_backpressure_graphn_sum(s : NetflowbackpressureGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_flow_backpressure_graphn_mean(s : NetflowbackpressureGraphN) -> Double {
  if s.size == 0 { 0.0 } else { net_flow_backpressure_graphn_sum(s) / s.size.to_double() }
}

pub fn net_flow_backpressure_graphn_scale(s : NetflowbackpressureGraphN, f : Double) -> NetflowbackpressureGraphN {
  let result = net_flow_backpressure_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_flow_backpressure_graphn_add(a : NetflowbackpressureGraphN, b : NetflowbackpressureGraphN) -> NetflowbackpressureGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_flow_backpressure_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_flow_backpressure_graphn_copy(s : NetflowbackpressureGraphN) -> NetflowbackpressureGraphN {
  let result = net_flow_backpressure_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_flow_backpressure_graphn_fill(s : NetflowbackpressureGraphN, v : Double) -> NetflowbackpressureGraphN {
  let result = net_flow_backpressure_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_flow_backpressure_graphn_min(s : NetflowbackpressureGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_backpressure_graphn_max(s : NetflowbackpressureGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_backpressure_graphn_to_string(s : NetflowbackpressureGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowbackpressureNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_backpressure_node_make(size : Int) -> NetflowbackpressureNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_backpressure_node_len(s : NetflowbackpressureNode) -> Int { s.size }

pub fn net_flow_backpressure_node_get(s : NetflowbackpressureNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_backpressure_node_set(s : NetflowbackpressureNode, i : Int, v : Double) -> NetflowbackpressureNode {
  let result = net_flow_backpressure_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_flow_backpressure_node_sum(s : NetflowbackpressureNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_flow_backpressure_node_mean(s : NetflowbackpressureNode) -> Double {
  if s.size == 0 { 0.0 } else { net_flow_backpressure_node_sum(s) / s.size.to_double() }
}

pub fn net_flow_backpressure_node_scale(s : NetflowbackpressureNode, f : Double) -> NetflowbackpressureNode {
  let result = net_flow_backpressure_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_flow_backpressure_node_add(a : NetflowbackpressureNode, b : NetflowbackpressureNode) -> NetflowbackpressureNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_flow_backpressure_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_flow_backpressure_node_copy(s : NetflowbackpressureNode) -> NetflowbackpressureNode {
  let result = net_flow_backpressure_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_flow_backpressure_node_fill(s : NetflowbackpressureNode, v : Double) -> NetflowbackpressureNode {
  let result = net_flow_backpressure_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_flow_backpressure_node_min(s : NetflowbackpressureNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_backpressure_node_max(s : NetflowbackpressureNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_backpressure_node_to_string(s : NetflowbackpressureNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowbackpressureEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_backpressure_edge_make(size : Int) -> NetflowbackpressureEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_backpressure_edge_len(s : NetflowbackpressureEdge) -> Int { s.size }

pub fn net_flow_backpressure_edge_get(s : NetflowbackpressureEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_backpressure_edge_set(s : NetflowbackpressureEdge, i : Int, v : Double) -> NetflowbackpressureEdge {
  let result = net_flow_backpressure_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_flow_backpressure_edge_sum(s : NetflowbackpressureEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_flow_backpressure_edge_mean(s : NetflowbackpressureEdge) -> Double {
  if s.size == 0 { 0.0 } else { net_flow_backpressure_edge_sum(s) / s.size.to_double() }
}

pub fn net_flow_backpressure_edge_scale(s : NetflowbackpressureEdge, f : Double) -> NetflowbackpressureEdge {
  let result = net_flow_backpressure_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_flow_backpressure_edge_add(a : NetflowbackpressureEdge, b : NetflowbackpressureEdge) -> NetflowbackpressureEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_flow_backpressure_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_flow_backpressure_edge_copy(s : NetflowbackpressureEdge) -> NetflowbackpressureEdge {
  let result = net_flow_backpressure_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_flow_backpressure_edge_fill(s : NetflowbackpressureEdge, v : Double) -> NetflowbackpressureEdge {
  let result = net_flow_backpressure_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_flow_backpressure_edge_min(s : NetflowbackpressureEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_backpressure_edge_max(s : NetflowbackpressureEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_backpressure_edge_to_string(s : NetflowbackpressureEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowbackpressurePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_backpressure_path_make(size : Int) -> NetflowbackpressurePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_backpressure_path_len(s : NetflowbackpressurePath) -> Int { s.size }

pub fn net_flow_backpressure_path_get(s : NetflowbackpressurePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_backpressure_path_set(s : NetflowbackpressurePath, i : Int, v : Double) -> NetflowbackpressurePath {
  let result = net_flow_backpressure_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_flow_backpressure_path_sum(s : NetflowbackpressurePath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_flow_backpressure_path_mean(s : NetflowbackpressurePath) -> Double {
  if s.size == 0 { 0.0 } else { net_flow_backpressure_path_sum(s) / s.size.to_double() }
}

pub fn net_flow_backpressure_path_scale(s : NetflowbackpressurePath, f : Double) -> NetflowbackpressurePath {
  let result = net_flow_backpressure_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_flow_backpressure_path_add(a : NetflowbackpressurePath, b : NetflowbackpressurePath) -> NetflowbackpressurePath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_flow_backpressure_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_flow_backpressure_path_copy(s : NetflowbackpressurePath) -> NetflowbackpressurePath {
  let result = net_flow_backpressure_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_flow_backpressure_path_fill(s : NetflowbackpressurePath, v : Double) -> NetflowbackpressurePath {
  let result = net_flow_backpressure_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_flow_backpressure_path_min(s : NetflowbackpressurePath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_backpressure_path_max(s : NetflowbackpressurePath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_backpressure_path_to_string(s : NetflowbackpressurePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowbackpressureCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_backpressure_cluster_make(size : Int) -> NetflowbackpressureCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_backpressure_cluster_len(s : NetflowbackpressureCluster) -> Int { s.size }

pub fn net_flow_backpressure_cluster_get(s : NetflowbackpressureCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_backpressure_cluster_set(s : NetflowbackpressureCluster, i : Int, v : Double) -> NetflowbackpressureCluster {
  let result = net_flow_backpressure_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_flow_backpressure_cluster_sum(s : NetflowbackpressureCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_flow_backpressure_cluster_mean(s : NetflowbackpressureCluster) -> Double {
  if s.size == 0 { 0.0 } else { net_flow_backpressure_cluster_sum(s) / s.size.to_double() }
}

pub fn net_flow_backpressure_cluster_scale(s : NetflowbackpressureCluster, f : Double) -> NetflowbackpressureCluster {
  let result = net_flow_backpressure_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_flow_backpressure_cluster_add(a : NetflowbackpressureCluster, b : NetflowbackpressureCluster) -> NetflowbackpressureCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_flow_backpressure_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_flow_backpressure_cluster_copy(s : NetflowbackpressureCluster) -> NetflowbackpressureCluster {
  let result = net_flow_backpressure_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_flow_backpressure_cluster_fill(s : NetflowbackpressureCluster, v : Double) -> NetflowbackpressureCluster {
  let result = net_flow_backpressure_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_flow_backpressure_cluster_min(s : NetflowbackpressureCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_backpressure_cluster_max(s : NetflowbackpressureCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_backpressure_cluster_to_string(s : NetflowbackpressureCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowbackpressureModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_backpressure_model_make(size : Int) -> NetflowbackpressureModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_backpressure_model_len(s : NetflowbackpressureModel) -> Int { s.size }

pub fn net_flow_backpressure_model_get(s : NetflowbackpressureModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_backpressure_model_set(s : NetflowbackpressureModel, i : Int, v : Double) -> NetflowbackpressureModel {
  let result = net_flow_backpressure_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_flow_backpressure_model_sum(s : NetflowbackpressureModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_flow_backpressure_model_mean(s : NetflowbackpressureModel) -> Double {
  if s.size == 0 { 0.0 } else { net_flow_backpressure_model_sum(s) / s.size.to_double() }
}

pub fn net_flow_backpressure_model_scale(s : NetflowbackpressureModel, f : Double) -> NetflowbackpressureModel {
  let result = net_flow_backpressure_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_flow_backpressure_model_add(a : NetflowbackpressureModel, b : NetflowbackpressureModel) -> NetflowbackpressureModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_flow_backpressure_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_flow_backpressure_model_copy(s : NetflowbackpressureModel) -> NetflowbackpressureModel {
  let result = net_flow_backpressure_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_flow_backpressure_model_fill(s : NetflowbackpressureModel, v : Double) -> NetflowbackpressureModel {
  let result = net_flow_backpressure_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_flow_backpressure_model_min(s : NetflowbackpressureModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_backpressure_model_max(s : NetflowbackpressureModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_backpressure_model_to_string(s : NetflowbackpressureModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowbackpressureLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_backpressure_layer_make(size : Int) -> NetflowbackpressureLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_backpressure_layer_len(s : NetflowbackpressureLayer) -> Int { s.size }

pub fn net_flow_backpressure_layer_get(s : NetflowbackpressureLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_backpressure_layer_set(s : NetflowbackpressureLayer, i : Int, v : Double) -> NetflowbackpressureLayer {
  let result = net_flow_backpressure_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_flow_backpressure_layer_sum(s : NetflowbackpressureLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_flow_backpressure_layer_mean(s : NetflowbackpressureLayer) -> Double {
  if s.size == 0 { 0.0 } else { net_flow_backpressure_layer_sum(s) / s.size.to_double() }
}

pub fn net_flow_backpressure_layer_scale(s : NetflowbackpressureLayer, f : Double) -> NetflowbackpressureLayer {
  let result = net_flow_backpressure_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_flow_backpressure_layer_add(a : NetflowbackpressureLayer, b : NetflowbackpressureLayer) -> NetflowbackpressureLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_flow_backpressure_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_flow_backpressure_layer_copy(s : NetflowbackpressureLayer) -> NetflowbackpressureLayer {
  let result = net_flow_backpressure_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_flow_backpressure_layer_fill(s : NetflowbackpressureLayer, v : Double) -> NetflowbackpressureLayer {
  let result = net_flow_backpressure_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_flow_backpressure_layer_min(s : NetflowbackpressureLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_backpressure_layer_max(s : NetflowbackpressureLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_backpressure_layer_to_string(s : NetflowbackpressureLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowbackpressureBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_backpressure_buffer_make(size : Int) -> NetflowbackpressureBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_backpressure_buffer_len(s : NetflowbackpressureBuffer) -> Int { s.size }

pub fn net_flow_backpressure_buffer_get(s : NetflowbackpressureBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_backpressure_buffer_set(s : NetflowbackpressureBuffer, i : Int, v : Double) -> NetflowbackpressureBuffer {
  let result = net_flow_backpressure_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_flow_backpressure_buffer_sum(s : NetflowbackpressureBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_flow_backpressure_buffer_mean(s : NetflowbackpressureBuffer) -> Double {
  if s.size == 0 { 0.0 } else { net_flow_backpressure_buffer_sum(s) / s.size.to_double() }
}

pub fn net_flow_backpressure_buffer_scale(s : NetflowbackpressureBuffer, f : Double) -> NetflowbackpressureBuffer {
  let result = net_flow_backpressure_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_flow_backpressure_buffer_add(a : NetflowbackpressureBuffer, b : NetflowbackpressureBuffer) -> NetflowbackpressureBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_flow_backpressure_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_flow_backpressure_buffer_copy(s : NetflowbackpressureBuffer) -> NetflowbackpressureBuffer {
  let result = net_flow_backpressure_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_flow_backpressure_buffer_fill(s : NetflowbackpressureBuffer, v : Double) -> NetflowbackpressureBuffer {
  let result = net_flow_backpressure_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_flow_backpressure_buffer_min(s : NetflowbackpressureBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_backpressure_buffer_max(s : NetflowbackpressureBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_backpressure_buffer_to_string(s : NetflowbackpressureBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowbackpressureCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_backpressure_cursor_make(size : Int) -> NetflowbackpressureCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_backpressure_cursor_len(s : NetflowbackpressureCursor) -> Int { s.size }

pub fn net_flow_backpressure_cursor_get(s : NetflowbackpressureCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_backpressure_cursor_set(s : NetflowbackpressureCursor, i : Int, v : Double) -> NetflowbackpressureCursor {
  let result = net_flow_backpressure_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_flow_backpressure_cursor_sum(s : NetflowbackpressureCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_flow_backpressure_cursor_mean(s : NetflowbackpressureCursor) -> Double {
  if s.size == 0 { 0.0 } else { net_flow_backpressure_cursor_sum(s) / s.size.to_double() }
}

pub fn net_flow_backpressure_cursor_scale(s : NetflowbackpressureCursor, f : Double) -> NetflowbackpressureCursor {
  let result = net_flow_backpressure_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_flow_backpressure_cursor_add(a : NetflowbackpressureCursor, b : NetflowbackpressureCursor) -> NetflowbackpressureCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_flow_backpressure_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_flow_backpressure_cursor_copy(s : NetflowbackpressureCursor) -> NetflowbackpressureCursor {
  let result = net_flow_backpressure_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_flow_backpressure_cursor_fill(s : NetflowbackpressureCursor, v : Double) -> NetflowbackpressureCursor {
  let result = net_flow_backpressure_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_flow_backpressure_cursor_min(s : NetflowbackpressureCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_backpressure_cursor_max(s : NetflowbackpressureCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_backpressure_cursor_to_string(s : NetflowbackpressureCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowbackpressureView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_backpressure_view_make(size : Int) -> NetflowbackpressureView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_backpressure_view_len(s : NetflowbackpressureView) -> Int { s.size }

pub fn net_flow_backpressure_view_get(s : NetflowbackpressureView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_backpressure_view_set(s : NetflowbackpressureView, i : Int, v : Double) -> NetflowbackpressureView {
  let result = net_flow_backpressure_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_flow_backpressure_view_sum(s : NetflowbackpressureView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_flow_backpressure_view_mean(s : NetflowbackpressureView) -> Double {
  if s.size == 0 { 0.0 } else { net_flow_backpressure_view_sum(s) / s.size.to_double() }
}

pub fn net_flow_backpressure_view_scale(s : NetflowbackpressureView, f : Double) -> NetflowbackpressureView {
  let result = net_flow_backpressure_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_flow_backpressure_view_add(a : NetflowbackpressureView, b : NetflowbackpressureView) -> NetflowbackpressureView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_flow_backpressure_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_flow_backpressure_view_copy(s : NetflowbackpressureView) -> NetflowbackpressureView {
  let result = net_flow_backpressure_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_flow_backpressure_view_fill(s : NetflowbackpressureView, v : Double) -> NetflowbackpressureView {
  let result = net_flow_backpressure_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_flow_backpressure_view_min(s : NetflowbackpressureView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_backpressure_view_max(s : NetflowbackpressureView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_backpressure_view_to_string(s : NetflowbackpressureView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowbackpressureRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_backpressure_range_make(size : Int) -> NetflowbackpressureRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_backpressure_range_len(s : NetflowbackpressureRange) -> Int { s.size }

pub fn net_flow_backpressure_range_get(s : NetflowbackpressureRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_backpressure_range_set(s : NetflowbackpressureRange, i : Int, v : Double) -> NetflowbackpressureRange {
  let result = net_flow_backpressure_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_flow_backpressure_range_sum(s : NetflowbackpressureRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_flow_backpressure_range_mean(s : NetflowbackpressureRange) -> Double {
  if s.size == 0 { 0.0 } else { net_flow_backpressure_range_sum(s) / s.size.to_double() }
}

pub fn net_flow_backpressure_range_scale(s : NetflowbackpressureRange, f : Double) -> NetflowbackpressureRange {
  let result = net_flow_backpressure_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_flow_backpressure_range_add(a : NetflowbackpressureRange, b : NetflowbackpressureRange) -> NetflowbackpressureRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_flow_backpressure_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_flow_backpressure_range_copy(s : NetflowbackpressureRange) -> NetflowbackpressureRange {
  let result = net_flow_backpressure_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_flow_backpressure_range_fill(s : NetflowbackpressureRange, v : Double) -> NetflowbackpressureRange {
  let result = net_flow_backpressure_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_flow_backpressure_range_min(s : NetflowbackpressureRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_backpressure_range_max(s : NetflowbackpressureRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_backpressure_range_to_string(s : NetflowbackpressureRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowbackpressureSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_backpressure_slice_make(size : Int) -> NetflowbackpressureSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_backpressure_slice_len(s : NetflowbackpressureSlice) -> Int { s.size }

pub fn net_flow_backpressure_slice_get(s : NetflowbackpressureSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_backpressure_slice_set(s : NetflowbackpressureSlice, i : Int, v : Double) -> NetflowbackpressureSlice {
  let result = net_flow_backpressure_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_flow_backpressure_slice_sum(s : NetflowbackpressureSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_flow_backpressure_slice_mean(s : NetflowbackpressureSlice) -> Double {
  if s.size == 0 { 0.0 } else { net_flow_backpressure_slice_sum(s) / s.size.to_double() }
}

pub fn net_flow_backpressure_slice_scale(s : NetflowbackpressureSlice, f : Double) -> NetflowbackpressureSlice {
  let result = net_flow_backpressure_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_flow_backpressure_slice_add(a : NetflowbackpressureSlice, b : NetflowbackpressureSlice) -> NetflowbackpressureSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_flow_backpressure_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_flow_backpressure_slice_copy(s : NetflowbackpressureSlice) -> NetflowbackpressureSlice {
  let result = net_flow_backpressure_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_flow_backpressure_slice_fill(s : NetflowbackpressureSlice, v : Double) -> NetflowbackpressureSlice {
  let result = net_flow_backpressure_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_flow_backpressure_slice_min(s : NetflowbackpressureSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_backpressure_slice_max(s : NetflowbackpressureSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_backpressure_slice_to_string(s : NetflowbackpressureSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

