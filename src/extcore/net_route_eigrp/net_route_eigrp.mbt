///===
/// extcore/net_route_eigrp

pub(all) struct NetrouteeigrpPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn net_route_eigrp_make_point(x : Double, y : Double) -> NetrouteeigrpPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn net_route_eigrp_make_point3(x : Double, y : Double, z : Double) -> NetrouteeigrpPoint {
  { x, y, z, label: 0 }
}

pub fn net_route_eigrp_point_x(pt : NetrouteeigrpPoint) -> Double { pt.x }

pub fn net_route_eigrp_point_y(pt : NetrouteeigrpPoint) -> Double { pt.y }

pub fn net_route_eigrp_point_z(pt : NetrouteeigrpPoint) -> Double { pt.z }

pub fn net_route_eigrp_point_label(pt : NetrouteeigrpPoint) -> Int { pt.label }

pub fn net_route_eigrp_point_dist(a : NetrouteeigrpPoint, b : NetrouteeigrpPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn net_route_eigrp_point_add(a : NetrouteeigrpPoint, b : NetrouteeigrpPoint) -> NetrouteeigrpPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn net_route_eigrp_point_sub(a : NetrouteeigrpPoint, b : NetrouteeigrpPoint) -> NetrouteeigrpPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn net_route_eigrp_point_scale(pt : NetrouteeigrpPoint, s : Double) -> NetrouteeigrpPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn net_route_eigrp_point_dot(a : NetrouteeigrpPoint, b : NetrouteeigrpPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn net_route_eigrp_point_cross(a : NetrouteeigrpPoint, b : NetrouteeigrpPoint) -> NetrouteeigrpPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn net_route_eigrp_point_norm(pt : NetrouteeigrpPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn net_route_eigrp_point_normalize(pt : NetrouteeigrpPoint) -> NetrouteeigrpPoint {
  let n = net_route_eigrp_point_norm(pt)
  if n < 0.0000001 { pt } else { net_route_eigrp_point_scale(pt, 1.0 / n) }
}

pub fn net_route_eigrp_point_negate(pt : NetrouteeigrpPoint) -> NetrouteeigrpPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn net_route_eigrp_point_mid(a : NetrouteeigrpPoint, b : NetrouteeigrpPoint) -> NetrouteeigrpPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn net_route_eigrp_point_lerp(a : NetrouteeigrpPoint, b : NetrouteeigrpPoint, t : Double) -> NetrouteeigrpPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn net_route_eigrp_point_to_string(pt : NetrouteeigrpPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct NetrouteeigrpSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn net_route_eigrp_make_series(vals : Array[Double], name : String) -> NetrouteeigrpSeries {
  { vals, name, meta: 0 }
}

pub fn net_route_eigrp_series_len(s : NetrouteeigrpSeries) -> Int { s.vals.length() }

pub fn net_route_eigrp_series_sum(s : NetrouteeigrpSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn net_route_eigrp_series_mean(s : NetrouteeigrpSeries) -> Double {
  let n = net_route_eigrp_series_len(s)
  if n == 0 { 0.0 } else { net_route_eigrp_series_sum(s) / n.to_double() }
}

pub fn net_route_eigrp_series_min(s : NetrouteeigrpSeries) -> Double {
  let n = net_route_eigrp_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn net_route_eigrp_series_max(s : NetrouteeigrpSeries) -> Double {
  let n = net_route_eigrp_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn net_route_eigrp_series_range(s : NetrouteeigrpSeries) -> Double {
  net_route_eigrp_series_max(s) - net_route_eigrp_series_min(s)
}

pub fn net_route_eigrp_series_var(s : NetrouteeigrpSeries) -> Double {
  let n = net_route_eigrp_series_len(s)
  if n == 0 { 0.0 } else {
    let m = net_route_eigrp_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn net_route_eigrp_series_std(s : NetrouteeigrpSeries) -> Double { @_common.sqrt(net_route_eigrp_series_var(s)) }

pub fn net_route_eigrp_series_median(s : NetrouteeigrpSeries) -> Double {
  let n = net_route_eigrp_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = net_route_eigrp_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn net_route_eigrp_series_scale(s : NetrouteeigrpSeries, f : Double) -> NetrouteeigrpSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn net_route_eigrp_series_add(a : NetrouteeigrpSeries, b : NetrouteeigrpSeries) -> NetrouteeigrpSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn net_route_eigrp_series_sub(a : NetrouteeigrpSeries, b : NetrouteeigrpSeries) -> NetrouteeigrpSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn net_route_eigrp_series_normalize(s : NetrouteeigrpSeries) -> NetrouteeigrpSeries {
  let mn = net_route_eigrp_series_min(s)
  let mx = net_route_eigrp_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn net_route_eigrp_series_cumsum(s : NetrouteeigrpSeries) -> NetrouteeigrpSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn net_route_eigrp_series_to_string(s : NetrouteeigrpSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NetrouteeigrpMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn net_route_eigrp_make_matrix(rows : Int, cols : Int, val : Double) -> NetrouteeigrpMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn net_route_eigrp_matrix_identity(n : Int) -> NetrouteeigrpMatrix {
  let m = net_route_eigrp_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn net_route_eigrp_matrix_get(m : NetrouteeigrpMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn net_route_eigrp_matrix_transpose(m : NetrouteeigrpMatrix) -> NetrouteeigrpMatrix {
  let result = net_route_eigrp_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn net_route_eigrp_matrix_add(a : NetrouteeigrpMatrix, b : NetrouteeigrpMatrix) -> NetrouteeigrpMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = net_route_eigrp_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn net_route_eigrp_matrix_scale(m : NetrouteeigrpMatrix, s : Double) -> NetrouteeigrpMatrix {
  let result = net_route_eigrp_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn net_route_eigrp_matrix_multiply(a : NetrouteeigrpMatrix, b : NetrouteeigrpMatrix) -> NetrouteeigrpMatrix {
  if a.cols != b.rows { return net_route_eigrp_make_matrix(a.rows, b.cols, 0.0) }
  let result = net_route_eigrp_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn net_route_eigrp_matrix_trace(m : NetrouteeigrpMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn net_route_eigrp_matrix_det(m : NetrouteeigrpMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn net_route_eigrp_matrix_norm(m : NetrouteeigrpMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn net_route_eigrp_matrix_to_string(m : NetrouteeigrpMatrix) -> String {
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

pub(all) struct NetrouteeigrpVector {
  comps : Array[Double]
  dim : Int
}

pub fn net_route_eigrp_make_vector(comps : Array[Double]) -> NetrouteeigrpVector {
  { comps, dim: comps.length() }
}

pub fn net_route_eigrp_vector_zero(dim : Int) -> NetrouteeigrpVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn net_route_eigrp_vector_add(a : NetrouteeigrpVector, b : NetrouteeigrpVector) -> NetrouteeigrpVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn net_route_eigrp_vector_sub(a : NetrouteeigrpVector, b : NetrouteeigrpVector) -> NetrouteeigrpVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn net_route_eigrp_vector_scale(v : NetrouteeigrpVector, s : Double) -> NetrouteeigrpVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn net_route_eigrp_vector_dot(a : NetrouteeigrpVector, b : NetrouteeigrpVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn net_route_eigrp_vector_norm(v : NetrouteeigrpVector) -> Double { @_common.sqrt(net_route_eigrp_vector_dot(v, v)) }

pub fn net_route_eigrp_vector_normalize(v : NetrouteeigrpVector) -> NetrouteeigrpVector {
  let n = net_route_eigrp_vector_norm(v)
  if n < 0.0000001 { v } else { net_route_eigrp_vector_scale(v, 1.0 / n) }
}

pub fn net_route_eigrp_vector_dist(a : NetrouteeigrpVector, b : NetrouteeigrpVector) -> Double {
  net_route_eigrp_vector_norm(net_route_eigrp_vector_sub(a, b))
}

pub fn net_route_eigrp_vector_to_string(v : NetrouteeigrpVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn net_route_eigrp_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn net_route_eigrp_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = net_route_eigrp_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn net_route_eigrp_std(data : Array[Double]) -> Double { @_common.sqrt(net_route_eigrp_var(data)) }

pub fn net_route_eigrp_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = net_route_eigrp_mean(a); let mb = net_route_eigrp_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn net_route_eigrp_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = net_route_eigrp_std(a); let sb = net_route_eigrp_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { net_route_eigrp_cov(a, b) / (sa * sb) }
}

pub fn net_route_eigrp_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = net_route_eigrp_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn net_route_eigrp_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn net_route_eigrp_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn net_route_eigrp_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  @_common.sqrt(net_route_eigrp_mse(pred, labels))
}

pub fn net_route_eigrp_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn net_route_eigrp_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = net_route_eigrp_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn net_route_eigrp_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn net_route_eigrp_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn net_route_eigrp_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = net_route_eigrp_precision(pred, labels, pos); let r = net_route_eigrp_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn net_route_eigrp_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn net_route_eigrp_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = net_route_eigrp_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn net_route_eigrp_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn net_route_eigrp_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn net_route_eigrp_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = net_route_eigrp_gcd(a, b)
    (a / g) * b
  }
}

pub fn net_route_eigrp_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn net_route_eigrp_fibonacci(n : Int) -> Int {
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

pub fn net_route_eigrp_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = net_route_eigrp_min(data); let mx = net_route_eigrp_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn net_route_eigrp_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = net_route_eigrp_mean(data); let sd = net_route_eigrp_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn net_route_eigrp_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn net_route_eigrp_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn net_route_eigrp_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn net_route_eigrp_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn net_route_eigrp_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn net_route_eigrp_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

pub(all) struct NetrouteeigrpFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_eigrp_frame_make(size : Int) -> NetrouteeigrpFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_eigrp_frame_len(s : NetrouteeigrpFrame) -> Int { s.size }

pub fn net_route_eigrp_frame_get(s : NetrouteeigrpFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_eigrp_frame_set(s : NetrouteeigrpFrame, i : Int, v : Double) -> NetrouteeigrpFrame {
  let result = net_route_eigrp_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_route_eigrp_frame_sum(s : NetrouteeigrpFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_route_eigrp_frame_mean(s : NetrouteeigrpFrame) -> Double {
  if s.size == 0 { 0.0 } else { net_route_eigrp_frame_sum(s) / s.size.to_double() }
}

pub fn net_route_eigrp_frame_scale(s : NetrouteeigrpFrame, f : Double) -> NetrouteeigrpFrame {
  let result = net_route_eigrp_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_route_eigrp_frame_add(a : NetrouteeigrpFrame, b : NetrouteeigrpFrame) -> NetrouteeigrpFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_route_eigrp_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_route_eigrp_frame_copy(s : NetrouteeigrpFrame) -> NetrouteeigrpFrame {
  let result = net_route_eigrp_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_route_eigrp_frame_fill(s : NetrouteeigrpFrame, v : Double) -> NetrouteeigrpFrame {
  let result = net_route_eigrp_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_route_eigrp_frame_min(s : NetrouteeigrpFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_route_eigrp_frame_max(s : NetrouteeigrpFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_route_eigrp_frame_to_string(s : NetrouteeigrpFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetrouteeigrpTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_eigrp_table_make(size : Int) -> NetrouteeigrpTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_eigrp_table_len(s : NetrouteeigrpTable) -> Int { s.size }

pub fn net_route_eigrp_table_get(s : NetrouteeigrpTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_eigrp_table_set(s : NetrouteeigrpTable, i : Int, v : Double) -> NetrouteeigrpTable {
  let result = net_route_eigrp_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_route_eigrp_table_sum(s : NetrouteeigrpTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_route_eigrp_table_mean(s : NetrouteeigrpTable) -> Double {
  if s.size == 0 { 0.0 } else { net_route_eigrp_table_sum(s) / s.size.to_double() }
}

pub fn net_route_eigrp_table_scale(s : NetrouteeigrpTable, f : Double) -> NetrouteeigrpTable {
  let result = net_route_eigrp_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_route_eigrp_table_add(a : NetrouteeigrpTable, b : NetrouteeigrpTable) -> NetrouteeigrpTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_route_eigrp_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_route_eigrp_table_copy(s : NetrouteeigrpTable) -> NetrouteeigrpTable {
  let result = net_route_eigrp_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_route_eigrp_table_fill(s : NetrouteeigrpTable, v : Double) -> NetrouteeigrpTable {
  let result = net_route_eigrp_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_route_eigrp_table_min(s : NetrouteeigrpTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_route_eigrp_table_max(s : NetrouteeigrpTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_route_eigrp_table_to_string(s : NetrouteeigrpTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetrouteeigrpGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_eigrp_graphn_make(size : Int) -> NetrouteeigrpGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_eigrp_graphn_len(s : NetrouteeigrpGraphN) -> Int { s.size }

pub fn net_route_eigrp_graphn_get(s : NetrouteeigrpGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_eigrp_graphn_set(s : NetrouteeigrpGraphN, i : Int, v : Double) -> NetrouteeigrpGraphN {
  let result = net_route_eigrp_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_route_eigrp_graphn_sum(s : NetrouteeigrpGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_route_eigrp_graphn_mean(s : NetrouteeigrpGraphN) -> Double {
  if s.size == 0 { 0.0 } else { net_route_eigrp_graphn_sum(s) / s.size.to_double() }
}

pub fn net_route_eigrp_graphn_scale(s : NetrouteeigrpGraphN, f : Double) -> NetrouteeigrpGraphN {
  let result = net_route_eigrp_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_route_eigrp_graphn_add(a : NetrouteeigrpGraphN, b : NetrouteeigrpGraphN) -> NetrouteeigrpGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_route_eigrp_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_route_eigrp_graphn_copy(s : NetrouteeigrpGraphN) -> NetrouteeigrpGraphN {
  let result = net_route_eigrp_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_route_eigrp_graphn_fill(s : NetrouteeigrpGraphN, v : Double) -> NetrouteeigrpGraphN {
  let result = net_route_eigrp_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_route_eigrp_graphn_min(s : NetrouteeigrpGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_route_eigrp_graphn_max(s : NetrouteeigrpGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_route_eigrp_graphn_to_string(s : NetrouteeigrpGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetrouteeigrpNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_eigrp_node_make(size : Int) -> NetrouteeigrpNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_eigrp_node_len(s : NetrouteeigrpNode) -> Int { s.size }

pub fn net_route_eigrp_node_get(s : NetrouteeigrpNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_eigrp_node_set(s : NetrouteeigrpNode, i : Int, v : Double) -> NetrouteeigrpNode {
  let result = net_route_eigrp_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_route_eigrp_node_sum(s : NetrouteeigrpNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_route_eigrp_node_mean(s : NetrouteeigrpNode) -> Double {
  if s.size == 0 { 0.0 } else { net_route_eigrp_node_sum(s) / s.size.to_double() }
}

pub fn net_route_eigrp_node_scale(s : NetrouteeigrpNode, f : Double) -> NetrouteeigrpNode {
  let result = net_route_eigrp_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_route_eigrp_node_add(a : NetrouteeigrpNode, b : NetrouteeigrpNode) -> NetrouteeigrpNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_route_eigrp_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_route_eigrp_node_copy(s : NetrouteeigrpNode) -> NetrouteeigrpNode {
  let result = net_route_eigrp_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_route_eigrp_node_fill(s : NetrouteeigrpNode, v : Double) -> NetrouteeigrpNode {
  let result = net_route_eigrp_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_route_eigrp_node_min(s : NetrouteeigrpNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_route_eigrp_node_max(s : NetrouteeigrpNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_route_eigrp_node_to_string(s : NetrouteeigrpNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetrouteeigrpEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_eigrp_edge_make(size : Int) -> NetrouteeigrpEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_eigrp_edge_len(s : NetrouteeigrpEdge) -> Int { s.size }

pub fn net_route_eigrp_edge_get(s : NetrouteeigrpEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_eigrp_edge_set(s : NetrouteeigrpEdge, i : Int, v : Double) -> NetrouteeigrpEdge {
  let result = net_route_eigrp_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_route_eigrp_edge_sum(s : NetrouteeigrpEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_route_eigrp_edge_mean(s : NetrouteeigrpEdge) -> Double {
  if s.size == 0 { 0.0 } else { net_route_eigrp_edge_sum(s) / s.size.to_double() }
}

pub fn net_route_eigrp_edge_scale(s : NetrouteeigrpEdge, f : Double) -> NetrouteeigrpEdge {
  let result = net_route_eigrp_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_route_eigrp_edge_add(a : NetrouteeigrpEdge, b : NetrouteeigrpEdge) -> NetrouteeigrpEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_route_eigrp_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_route_eigrp_edge_copy(s : NetrouteeigrpEdge) -> NetrouteeigrpEdge {
  let result = net_route_eigrp_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_route_eigrp_edge_fill(s : NetrouteeigrpEdge, v : Double) -> NetrouteeigrpEdge {
  let result = net_route_eigrp_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_route_eigrp_edge_min(s : NetrouteeigrpEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_route_eigrp_edge_max(s : NetrouteeigrpEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_route_eigrp_edge_to_string(s : NetrouteeigrpEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetrouteeigrpPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_eigrp_path_make(size : Int) -> NetrouteeigrpPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_eigrp_path_len(s : NetrouteeigrpPath) -> Int { s.size }

pub fn net_route_eigrp_path_get(s : NetrouteeigrpPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_eigrp_path_set(s : NetrouteeigrpPath, i : Int, v : Double) -> NetrouteeigrpPath {
  let result = net_route_eigrp_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_route_eigrp_path_sum(s : NetrouteeigrpPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_route_eigrp_path_mean(s : NetrouteeigrpPath) -> Double {
  if s.size == 0 { 0.0 } else { net_route_eigrp_path_sum(s) / s.size.to_double() }
}

pub fn net_route_eigrp_path_scale(s : NetrouteeigrpPath, f : Double) -> NetrouteeigrpPath {
  let result = net_route_eigrp_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_route_eigrp_path_add(a : NetrouteeigrpPath, b : NetrouteeigrpPath) -> NetrouteeigrpPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_route_eigrp_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_route_eigrp_path_copy(s : NetrouteeigrpPath) -> NetrouteeigrpPath {
  let result = net_route_eigrp_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_route_eigrp_path_fill(s : NetrouteeigrpPath, v : Double) -> NetrouteeigrpPath {
  let result = net_route_eigrp_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_route_eigrp_path_min(s : NetrouteeigrpPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_route_eigrp_path_max(s : NetrouteeigrpPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_route_eigrp_path_to_string(s : NetrouteeigrpPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetrouteeigrpCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_eigrp_cluster_make(size : Int) -> NetrouteeigrpCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_eigrp_cluster_len(s : NetrouteeigrpCluster) -> Int { s.size }

pub fn net_route_eigrp_cluster_get(s : NetrouteeigrpCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_eigrp_cluster_set(s : NetrouteeigrpCluster, i : Int, v : Double) -> NetrouteeigrpCluster {
  let result = net_route_eigrp_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_route_eigrp_cluster_sum(s : NetrouteeigrpCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_route_eigrp_cluster_mean(s : NetrouteeigrpCluster) -> Double {
  if s.size == 0 { 0.0 } else { net_route_eigrp_cluster_sum(s) / s.size.to_double() }
}

pub fn net_route_eigrp_cluster_scale(s : NetrouteeigrpCluster, f : Double) -> NetrouteeigrpCluster {
  let result = net_route_eigrp_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_route_eigrp_cluster_add(a : NetrouteeigrpCluster, b : NetrouteeigrpCluster) -> NetrouteeigrpCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_route_eigrp_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_route_eigrp_cluster_copy(s : NetrouteeigrpCluster) -> NetrouteeigrpCluster {
  let result = net_route_eigrp_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_route_eigrp_cluster_fill(s : NetrouteeigrpCluster, v : Double) -> NetrouteeigrpCluster {
  let result = net_route_eigrp_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_route_eigrp_cluster_min(s : NetrouteeigrpCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_route_eigrp_cluster_max(s : NetrouteeigrpCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_route_eigrp_cluster_to_string(s : NetrouteeigrpCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetrouteeigrpModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_eigrp_model_make(size : Int) -> NetrouteeigrpModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_eigrp_model_len(s : NetrouteeigrpModel) -> Int { s.size }

pub fn net_route_eigrp_model_get(s : NetrouteeigrpModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_eigrp_model_set(s : NetrouteeigrpModel, i : Int, v : Double) -> NetrouteeigrpModel {
  let result = net_route_eigrp_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_route_eigrp_model_sum(s : NetrouteeigrpModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_route_eigrp_model_mean(s : NetrouteeigrpModel) -> Double {
  if s.size == 0 { 0.0 } else { net_route_eigrp_model_sum(s) / s.size.to_double() }
}

pub fn net_route_eigrp_model_scale(s : NetrouteeigrpModel, f : Double) -> NetrouteeigrpModel {
  let result = net_route_eigrp_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_route_eigrp_model_add(a : NetrouteeigrpModel, b : NetrouteeigrpModel) -> NetrouteeigrpModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_route_eigrp_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_route_eigrp_model_copy(s : NetrouteeigrpModel) -> NetrouteeigrpModel {
  let result = net_route_eigrp_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_route_eigrp_model_fill(s : NetrouteeigrpModel, v : Double) -> NetrouteeigrpModel {
  let result = net_route_eigrp_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_route_eigrp_model_min(s : NetrouteeigrpModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_route_eigrp_model_max(s : NetrouteeigrpModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_route_eigrp_model_to_string(s : NetrouteeigrpModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetrouteeigrpLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_eigrp_layer_make(size : Int) -> NetrouteeigrpLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_eigrp_layer_len(s : NetrouteeigrpLayer) -> Int { s.size }

pub fn net_route_eigrp_layer_get(s : NetrouteeigrpLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_eigrp_layer_set(s : NetrouteeigrpLayer, i : Int, v : Double) -> NetrouteeigrpLayer {
  let result = net_route_eigrp_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_route_eigrp_layer_sum(s : NetrouteeigrpLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_route_eigrp_layer_mean(s : NetrouteeigrpLayer) -> Double {
  if s.size == 0 { 0.0 } else { net_route_eigrp_layer_sum(s) / s.size.to_double() }
}

pub fn net_route_eigrp_layer_scale(s : NetrouteeigrpLayer, f : Double) -> NetrouteeigrpLayer {
  let result = net_route_eigrp_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_route_eigrp_layer_add(a : NetrouteeigrpLayer, b : NetrouteeigrpLayer) -> NetrouteeigrpLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_route_eigrp_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_route_eigrp_layer_copy(s : NetrouteeigrpLayer) -> NetrouteeigrpLayer {
  let result = net_route_eigrp_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_route_eigrp_layer_fill(s : NetrouteeigrpLayer, v : Double) -> NetrouteeigrpLayer {
  let result = net_route_eigrp_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_route_eigrp_layer_min(s : NetrouteeigrpLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_route_eigrp_layer_max(s : NetrouteeigrpLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_route_eigrp_layer_to_string(s : NetrouteeigrpLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetrouteeigrpBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_eigrp_buffer_make(size : Int) -> NetrouteeigrpBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_eigrp_buffer_len(s : NetrouteeigrpBuffer) -> Int { s.size }

pub fn net_route_eigrp_buffer_get(s : NetrouteeigrpBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_eigrp_buffer_set(s : NetrouteeigrpBuffer, i : Int, v : Double) -> NetrouteeigrpBuffer {
  let result = net_route_eigrp_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_route_eigrp_buffer_sum(s : NetrouteeigrpBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_route_eigrp_buffer_mean(s : NetrouteeigrpBuffer) -> Double {
  if s.size == 0 { 0.0 } else { net_route_eigrp_buffer_sum(s) / s.size.to_double() }
}

pub fn net_route_eigrp_buffer_scale(s : NetrouteeigrpBuffer, f : Double) -> NetrouteeigrpBuffer {
  let result = net_route_eigrp_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_route_eigrp_buffer_add(a : NetrouteeigrpBuffer, b : NetrouteeigrpBuffer) -> NetrouteeigrpBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_route_eigrp_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_route_eigrp_buffer_copy(s : NetrouteeigrpBuffer) -> NetrouteeigrpBuffer {
  let result = net_route_eigrp_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_route_eigrp_buffer_fill(s : NetrouteeigrpBuffer, v : Double) -> NetrouteeigrpBuffer {
  let result = net_route_eigrp_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_route_eigrp_buffer_min(s : NetrouteeigrpBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_route_eigrp_buffer_max(s : NetrouteeigrpBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_route_eigrp_buffer_to_string(s : NetrouteeigrpBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetrouteeigrpCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_eigrp_cursor_make(size : Int) -> NetrouteeigrpCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_eigrp_cursor_len(s : NetrouteeigrpCursor) -> Int { s.size }

pub fn net_route_eigrp_cursor_get(s : NetrouteeigrpCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_eigrp_cursor_set(s : NetrouteeigrpCursor, i : Int, v : Double) -> NetrouteeigrpCursor {
  let result = net_route_eigrp_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_route_eigrp_cursor_sum(s : NetrouteeigrpCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_route_eigrp_cursor_mean(s : NetrouteeigrpCursor) -> Double {
  if s.size == 0 { 0.0 } else { net_route_eigrp_cursor_sum(s) / s.size.to_double() }
}

pub fn net_route_eigrp_cursor_scale(s : NetrouteeigrpCursor, f : Double) -> NetrouteeigrpCursor {
  let result = net_route_eigrp_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_route_eigrp_cursor_add(a : NetrouteeigrpCursor, b : NetrouteeigrpCursor) -> NetrouteeigrpCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_route_eigrp_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_route_eigrp_cursor_copy(s : NetrouteeigrpCursor) -> NetrouteeigrpCursor {
  let result = net_route_eigrp_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_route_eigrp_cursor_fill(s : NetrouteeigrpCursor, v : Double) -> NetrouteeigrpCursor {
  let result = net_route_eigrp_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_route_eigrp_cursor_min(s : NetrouteeigrpCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_route_eigrp_cursor_max(s : NetrouteeigrpCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_route_eigrp_cursor_to_string(s : NetrouteeigrpCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetrouteeigrpView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_eigrp_view_make(size : Int) -> NetrouteeigrpView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_eigrp_view_len(s : NetrouteeigrpView) -> Int { s.size }

pub fn net_route_eigrp_view_get(s : NetrouteeigrpView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_eigrp_view_set(s : NetrouteeigrpView, i : Int, v : Double) -> NetrouteeigrpView {
  let result = net_route_eigrp_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_route_eigrp_view_sum(s : NetrouteeigrpView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_route_eigrp_view_mean(s : NetrouteeigrpView) -> Double {
  if s.size == 0 { 0.0 } else { net_route_eigrp_view_sum(s) / s.size.to_double() }
}

pub fn net_route_eigrp_view_scale(s : NetrouteeigrpView, f : Double) -> NetrouteeigrpView {
  let result = net_route_eigrp_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_route_eigrp_view_add(a : NetrouteeigrpView, b : NetrouteeigrpView) -> NetrouteeigrpView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_route_eigrp_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_route_eigrp_view_copy(s : NetrouteeigrpView) -> NetrouteeigrpView {
  let result = net_route_eigrp_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_route_eigrp_view_fill(s : NetrouteeigrpView, v : Double) -> NetrouteeigrpView {
  let result = net_route_eigrp_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_route_eigrp_view_min(s : NetrouteeigrpView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_route_eigrp_view_max(s : NetrouteeigrpView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_route_eigrp_view_to_string(s : NetrouteeigrpView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetrouteeigrpRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_eigrp_range_make(size : Int) -> NetrouteeigrpRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_eigrp_range_len(s : NetrouteeigrpRange) -> Int { s.size }

pub fn net_route_eigrp_range_get(s : NetrouteeigrpRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_eigrp_range_set(s : NetrouteeigrpRange, i : Int, v : Double) -> NetrouteeigrpRange {
  let result = net_route_eigrp_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_route_eigrp_range_sum(s : NetrouteeigrpRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_route_eigrp_range_mean(s : NetrouteeigrpRange) -> Double {
  if s.size == 0 { 0.0 } else { net_route_eigrp_range_sum(s) / s.size.to_double() }
}

pub fn net_route_eigrp_range_scale(s : NetrouteeigrpRange, f : Double) -> NetrouteeigrpRange {
  let result = net_route_eigrp_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_route_eigrp_range_add(a : NetrouteeigrpRange, b : NetrouteeigrpRange) -> NetrouteeigrpRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_route_eigrp_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_route_eigrp_range_copy(s : NetrouteeigrpRange) -> NetrouteeigrpRange {
  let result = net_route_eigrp_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_route_eigrp_range_fill(s : NetrouteeigrpRange, v : Double) -> NetrouteeigrpRange {
  let result = net_route_eigrp_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_route_eigrp_range_min(s : NetrouteeigrpRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_route_eigrp_range_max(s : NetrouteeigrpRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_route_eigrp_range_to_string(s : NetrouteeigrpRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetrouteeigrpSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_eigrp_slice_make(size : Int) -> NetrouteeigrpSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_eigrp_slice_len(s : NetrouteeigrpSlice) -> Int { s.size }

pub fn net_route_eigrp_slice_get(s : NetrouteeigrpSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_eigrp_slice_set(s : NetrouteeigrpSlice, i : Int, v : Double) -> NetrouteeigrpSlice {
  let result = net_route_eigrp_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_route_eigrp_slice_sum(s : NetrouteeigrpSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_route_eigrp_slice_mean(s : NetrouteeigrpSlice) -> Double {
  if s.size == 0 { 0.0 } else { net_route_eigrp_slice_sum(s) / s.size.to_double() }
}

pub fn net_route_eigrp_slice_scale(s : NetrouteeigrpSlice, f : Double) -> NetrouteeigrpSlice {
  let result = net_route_eigrp_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_route_eigrp_slice_add(a : NetrouteeigrpSlice, b : NetrouteeigrpSlice) -> NetrouteeigrpSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_route_eigrp_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_route_eigrp_slice_copy(s : NetrouteeigrpSlice) -> NetrouteeigrpSlice {
  let result = net_route_eigrp_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_route_eigrp_slice_fill(s : NetrouteeigrpSlice, v : Double) -> NetrouteeigrpSlice {
  let result = net_route_eigrp_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_route_eigrp_slice_min(s : NetrouteeigrpSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_route_eigrp_slice_max(s : NetrouteeigrpSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_route_eigrp_slice_to_string(s : NetrouteeigrpSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

