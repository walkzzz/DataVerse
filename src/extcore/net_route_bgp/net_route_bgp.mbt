///===
/// extcore/net_route_bgp

pub(all) struct NetroutebgpPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn net_route_bgp_make_point(x : Double, y : Double) -> NetroutebgpPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn net_route_bgp_make_point3(x : Double, y : Double, z : Double) -> NetroutebgpPoint {
  { x, y, z, label: 0 }
}

pub fn net_route_bgp_point_x(pt : NetroutebgpPoint) -> Double { pt.x }

pub fn net_route_bgp_point_y(pt : NetroutebgpPoint) -> Double { pt.y }

pub fn net_route_bgp_point_z(pt : NetroutebgpPoint) -> Double { pt.z }

pub fn net_route_bgp_point_label(pt : NetroutebgpPoint) -> Int { pt.label }

pub fn net_route_bgp_point_dist(a : NetroutebgpPoint, b : NetroutebgpPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  net_route_bgp_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn net_route_bgp_point_add(a : NetroutebgpPoint, b : NetroutebgpPoint) -> NetroutebgpPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn net_route_bgp_point_sub(a : NetroutebgpPoint, b : NetroutebgpPoint) -> NetroutebgpPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn net_route_bgp_point_scale(pt : NetroutebgpPoint, s : Double) -> NetroutebgpPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn net_route_bgp_point_dot(a : NetroutebgpPoint, b : NetroutebgpPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn net_route_bgp_point_cross(a : NetroutebgpPoint, b : NetroutebgpPoint) -> NetroutebgpPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn net_route_bgp_point_norm(pt : NetroutebgpPoint) -> Double {
  net_route_bgp_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn net_route_bgp_point_normalize(pt : NetroutebgpPoint) -> NetroutebgpPoint {
  let n = net_route_bgp_point_norm(pt)
  if n < 0.0000001 { pt } else { net_route_bgp_point_scale(pt, 1.0 / n) }
}

pub fn net_route_bgp_point_negate(pt : NetroutebgpPoint) -> NetroutebgpPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn net_route_bgp_point_mid(a : NetroutebgpPoint, b : NetroutebgpPoint) -> NetroutebgpPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn net_route_bgp_point_lerp(a : NetroutebgpPoint, b : NetroutebgpPoint, t : Double) -> NetroutebgpPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn net_route_bgp_point_to_string(pt : NetroutebgpPoint) -> String {
  "(" + net_route_bgp_dbl(pt.x) + ", " + net_route_bgp_dbl(pt.y) + ", " + net_route_bgp_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct NetroutebgpSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn net_route_bgp_make_series(vals : Array[Double], name : String) -> NetroutebgpSeries {
  { vals, name, meta: 0 }
}

pub fn net_route_bgp_series_len(s : NetroutebgpSeries) -> Int { s.vals.length() }

pub fn net_route_bgp_series_sum(s : NetroutebgpSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn net_route_bgp_series_mean(s : NetroutebgpSeries) -> Double {
  let n = net_route_bgp_series_len(s)
  if n == 0 { 0.0 } else { net_route_bgp_series_sum(s) / n.to_double() }
}

pub fn net_route_bgp_series_min(s : NetroutebgpSeries) -> Double {
  let n = net_route_bgp_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn net_route_bgp_series_max(s : NetroutebgpSeries) -> Double {
  let n = net_route_bgp_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn net_route_bgp_series_range(s : NetroutebgpSeries) -> Double {
  net_route_bgp_series_max(s) - net_route_bgp_series_min(s)
}

pub fn net_route_bgp_series_var(s : NetroutebgpSeries) -> Double {
  let n = net_route_bgp_series_len(s)
  if n == 0 { 0.0 } else {
    let m = net_route_bgp_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn net_route_bgp_series_std(s : NetroutebgpSeries) -> Double { net_route_bgp_sqrt(net_route_bgp_series_var(s)) }

pub fn net_route_bgp_series_median(s : NetroutebgpSeries) -> Double {
  let n = net_route_bgp_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = net_route_bgp_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn net_route_bgp_series_scale(s : NetroutebgpSeries, f : Double) -> NetroutebgpSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = net_route_bgp_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn net_route_bgp_series_add(a : NetroutebgpSeries, b : NetroutebgpSeries) -> NetroutebgpSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = net_route_bgp_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn net_route_bgp_series_sub(a : NetroutebgpSeries, b : NetroutebgpSeries) -> NetroutebgpSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = net_route_bgp_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn net_route_bgp_series_normalize(s : NetroutebgpSeries) -> NetroutebgpSeries {
  let mn = net_route_bgp_series_min(s)
  let mx = net_route_bgp_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = net_route_bgp_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn net_route_bgp_series_cumsum(s : NetroutebgpSeries) -> NetroutebgpSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = net_route_bgp_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn net_route_bgp_series_to_string(s : NetroutebgpSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + net_route_bgp_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NetroutebgpMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn net_route_bgp_make_matrix(rows : Int, cols : Int, val : Double) -> NetroutebgpMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn net_route_bgp_matrix_identity(n : Int) -> NetroutebgpMatrix {
  let m = net_route_bgp_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn net_route_bgp_matrix_get(m : NetroutebgpMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn net_route_bgp_matrix_transpose(m : NetroutebgpMatrix) -> NetroutebgpMatrix {
  let result = net_route_bgp_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn net_route_bgp_matrix_add(a : NetroutebgpMatrix, b : NetroutebgpMatrix) -> NetroutebgpMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = net_route_bgp_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn net_route_bgp_matrix_scale(m : NetroutebgpMatrix, s : Double) -> NetroutebgpMatrix {
  let result = net_route_bgp_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn net_route_bgp_matrix_multiply(a : NetroutebgpMatrix, b : NetroutebgpMatrix) -> NetroutebgpMatrix {
  if a.cols != b.rows { return net_route_bgp_make_matrix(a.rows, b.cols, 0.0) }
  let result = net_route_bgp_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn net_route_bgp_matrix_trace(m : NetroutebgpMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn net_route_bgp_matrix_det(m : NetroutebgpMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn net_route_bgp_matrix_norm(m : NetroutebgpMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  net_route_bgp_sqrt(sum)
}

pub fn net_route_bgp_matrix_to_string(m : NetroutebgpMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + net_route_bgp_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct NetroutebgpVector {
  comps : Array[Double]
  dim : Int
}

pub fn net_route_bgp_make_vector(comps : Array[Double]) -> NetroutebgpVector {
  { comps, dim: comps.length() }
}

pub fn net_route_bgp_vector_zero(dim : Int) -> NetroutebgpVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn net_route_bgp_vector_add(a : NetroutebgpVector, b : NetroutebgpVector) -> NetroutebgpVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = net_route_bgp_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn net_route_bgp_vector_sub(a : NetroutebgpVector, b : NetroutebgpVector) -> NetroutebgpVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = net_route_bgp_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn net_route_bgp_vector_scale(v : NetroutebgpVector, s : Double) -> NetroutebgpVector {
  let mut result = []
  for i in 0..<v.dim { result = net_route_bgp_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn net_route_bgp_vector_dot(a : NetroutebgpVector, b : NetroutebgpVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn net_route_bgp_vector_norm(v : NetroutebgpVector) -> Double { net_route_bgp_sqrt(net_route_bgp_vector_dot(v, v)) }

pub fn net_route_bgp_vector_normalize(v : NetroutebgpVector) -> NetroutebgpVector {
  let n = net_route_bgp_vector_norm(v)
  if n < 0.0000001 { v } else { net_route_bgp_vector_scale(v, 1.0 / n) }
}

pub fn net_route_bgp_vector_dist(a : NetroutebgpVector, b : NetroutebgpVector) -> Double {
  net_route_bgp_vector_norm(net_route_bgp_vector_sub(a, b))
}

pub fn net_route_bgp_vector_to_string(v : NetroutebgpVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + net_route_bgp_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn net_route_bgp_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn net_route_bgp_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = net_route_bgp_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn net_route_bgp_std(data : Array[Double]) -> Double { net_route_bgp_sqrt(net_route_bgp_var(data)) }

pub fn net_route_bgp_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = net_route_bgp_mean(a); let mb = net_route_bgp_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn net_route_bgp_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = net_route_bgp_std(a); let sb = net_route_bgp_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { net_route_bgp_cov(a, b) / (sa * sb) }
}

pub fn net_route_bgp_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = net_route_bgp_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn net_route_bgp_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn net_route_bgp_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn net_route_bgp_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  net_route_bgp_sqrt(net_route_bgp_mse(pred, labels))
}

pub fn net_route_bgp_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + net_route_bgp_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn net_route_bgp_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = net_route_bgp_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn net_route_bgp_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn net_route_bgp_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn net_route_bgp_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = net_route_bgp_precision(pred, labels, pos); let r = net_route_bgp_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn net_route_bgp_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn net_route_bgp_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = net_route_bgp_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn net_route_bgp_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn net_route_bgp_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn net_route_bgp_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = net_route_bgp_gcd(a, b)
    (a / g) * b
  }
}

pub fn net_route_bgp_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn net_route_bgp_fibonacci(n : Int) -> Int {
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

pub fn net_route_bgp_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = net_route_bgp_min(data); let mx = net_route_bgp_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn net_route_bgp_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = net_route_bgp_mean(data); let sd = net_route_bgp_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn net_route_bgp_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn net_route_bgp_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn net_route_bgp_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn net_route_bgp_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn net_route_bgp_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn net_route_bgp_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn net_route_bgp_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn net_route_bgp_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn net_route_bgp_dbl(x : Double) -> String {
  let i = if x >= 0.0 { net_route_bgp_int(x) } else { -net_route_bgp_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { net_route_bgp_int(f * 1000000.0) } else { net_route_bgp_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn net_route_bgp_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn net_route_bgp_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct NetroutebgpFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_bgp_frame_make(size : Int) -> NetroutebgpFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_bgp_frame_len(s : NetroutebgpFrame) -> Int { s.size }

pub fn net_route_bgp_frame_get(s : NetroutebgpFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_bgp_frame_set(s : NetroutebgpFrame, i : Int, v : Double) -> NetroutebgpFrame {
  let result = net_route_bgp_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_route_bgp_frame_sum(s : NetroutebgpFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_route_bgp_frame_mean(s : NetroutebgpFrame) -> Double {
  if s.size == 0 { 0.0 } else { net_route_bgp_frame_sum(s) / s.size.to_double() }
}

pub fn net_route_bgp_frame_scale(s : NetroutebgpFrame, f : Double) -> NetroutebgpFrame {
  let result = net_route_bgp_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_route_bgp_frame_add(a : NetroutebgpFrame, b : NetroutebgpFrame) -> NetroutebgpFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_route_bgp_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_route_bgp_frame_copy(s : NetroutebgpFrame) -> NetroutebgpFrame {
  let result = net_route_bgp_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_route_bgp_frame_fill(s : NetroutebgpFrame, v : Double) -> NetroutebgpFrame {
  let result = net_route_bgp_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_route_bgp_frame_min(s : NetroutebgpFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_route_bgp_frame_max(s : NetroutebgpFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_route_bgp_frame_to_string(s : NetroutebgpFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetroutebgpTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_bgp_table_make(size : Int) -> NetroutebgpTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_bgp_table_len(s : NetroutebgpTable) -> Int { s.size }

pub fn net_route_bgp_table_get(s : NetroutebgpTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_bgp_table_set(s : NetroutebgpTable, i : Int, v : Double) -> NetroutebgpTable {
  let result = net_route_bgp_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_route_bgp_table_sum(s : NetroutebgpTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_route_bgp_table_mean(s : NetroutebgpTable) -> Double {
  if s.size == 0 { 0.0 } else { net_route_bgp_table_sum(s) / s.size.to_double() }
}

pub fn net_route_bgp_table_scale(s : NetroutebgpTable, f : Double) -> NetroutebgpTable {
  let result = net_route_bgp_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_route_bgp_table_add(a : NetroutebgpTable, b : NetroutebgpTable) -> NetroutebgpTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_route_bgp_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_route_bgp_table_copy(s : NetroutebgpTable) -> NetroutebgpTable {
  let result = net_route_bgp_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_route_bgp_table_fill(s : NetroutebgpTable, v : Double) -> NetroutebgpTable {
  let result = net_route_bgp_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_route_bgp_table_min(s : NetroutebgpTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_route_bgp_table_max(s : NetroutebgpTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_route_bgp_table_to_string(s : NetroutebgpTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetroutebgpGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_bgp_graphn_make(size : Int) -> NetroutebgpGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_bgp_graphn_len(s : NetroutebgpGraphN) -> Int { s.size }

pub fn net_route_bgp_graphn_get(s : NetroutebgpGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_bgp_graphn_set(s : NetroutebgpGraphN, i : Int, v : Double) -> NetroutebgpGraphN {
  let result = net_route_bgp_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_route_bgp_graphn_sum(s : NetroutebgpGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_route_bgp_graphn_mean(s : NetroutebgpGraphN) -> Double {
  if s.size == 0 { 0.0 } else { net_route_bgp_graphn_sum(s) / s.size.to_double() }
}

pub fn net_route_bgp_graphn_scale(s : NetroutebgpGraphN, f : Double) -> NetroutebgpGraphN {
  let result = net_route_bgp_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_route_bgp_graphn_add(a : NetroutebgpGraphN, b : NetroutebgpGraphN) -> NetroutebgpGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_route_bgp_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_route_bgp_graphn_copy(s : NetroutebgpGraphN) -> NetroutebgpGraphN {
  let result = net_route_bgp_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_route_bgp_graphn_fill(s : NetroutebgpGraphN, v : Double) -> NetroutebgpGraphN {
  let result = net_route_bgp_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_route_bgp_graphn_min(s : NetroutebgpGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_route_bgp_graphn_max(s : NetroutebgpGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_route_bgp_graphn_to_string(s : NetroutebgpGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetroutebgpNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_bgp_node_make(size : Int) -> NetroutebgpNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_bgp_node_len(s : NetroutebgpNode) -> Int { s.size }

pub fn net_route_bgp_node_get(s : NetroutebgpNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_bgp_node_set(s : NetroutebgpNode, i : Int, v : Double) -> NetroutebgpNode {
  let result = net_route_bgp_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_route_bgp_node_sum(s : NetroutebgpNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_route_bgp_node_mean(s : NetroutebgpNode) -> Double {
  if s.size == 0 { 0.0 } else { net_route_bgp_node_sum(s) / s.size.to_double() }
}

pub fn net_route_bgp_node_scale(s : NetroutebgpNode, f : Double) -> NetroutebgpNode {
  let result = net_route_bgp_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_route_bgp_node_add(a : NetroutebgpNode, b : NetroutebgpNode) -> NetroutebgpNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_route_bgp_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_route_bgp_node_copy(s : NetroutebgpNode) -> NetroutebgpNode {
  let result = net_route_bgp_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_route_bgp_node_fill(s : NetroutebgpNode, v : Double) -> NetroutebgpNode {
  let result = net_route_bgp_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_route_bgp_node_min(s : NetroutebgpNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_route_bgp_node_max(s : NetroutebgpNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_route_bgp_node_to_string(s : NetroutebgpNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetroutebgpEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_bgp_edge_make(size : Int) -> NetroutebgpEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_bgp_edge_len(s : NetroutebgpEdge) -> Int { s.size }

pub fn net_route_bgp_edge_get(s : NetroutebgpEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_bgp_edge_set(s : NetroutebgpEdge, i : Int, v : Double) -> NetroutebgpEdge {
  let result = net_route_bgp_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_route_bgp_edge_sum(s : NetroutebgpEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_route_bgp_edge_mean(s : NetroutebgpEdge) -> Double {
  if s.size == 0 { 0.0 } else { net_route_bgp_edge_sum(s) / s.size.to_double() }
}

pub fn net_route_bgp_edge_scale(s : NetroutebgpEdge, f : Double) -> NetroutebgpEdge {
  let result = net_route_bgp_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_route_bgp_edge_add(a : NetroutebgpEdge, b : NetroutebgpEdge) -> NetroutebgpEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_route_bgp_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_route_bgp_edge_copy(s : NetroutebgpEdge) -> NetroutebgpEdge {
  let result = net_route_bgp_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_route_bgp_edge_fill(s : NetroutebgpEdge, v : Double) -> NetroutebgpEdge {
  let result = net_route_bgp_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_route_bgp_edge_min(s : NetroutebgpEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_route_bgp_edge_max(s : NetroutebgpEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_route_bgp_edge_to_string(s : NetroutebgpEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetroutebgpPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_bgp_path_make(size : Int) -> NetroutebgpPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_bgp_path_len(s : NetroutebgpPath) -> Int { s.size }

pub fn net_route_bgp_path_get(s : NetroutebgpPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_bgp_path_set(s : NetroutebgpPath, i : Int, v : Double) -> NetroutebgpPath {
  let result = net_route_bgp_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_route_bgp_path_sum(s : NetroutebgpPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_route_bgp_path_mean(s : NetroutebgpPath) -> Double {
  if s.size == 0 { 0.0 } else { net_route_bgp_path_sum(s) / s.size.to_double() }
}

pub fn net_route_bgp_path_scale(s : NetroutebgpPath, f : Double) -> NetroutebgpPath {
  let result = net_route_bgp_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_route_bgp_path_add(a : NetroutebgpPath, b : NetroutebgpPath) -> NetroutebgpPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_route_bgp_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_route_bgp_path_copy(s : NetroutebgpPath) -> NetroutebgpPath {
  let result = net_route_bgp_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_route_bgp_path_fill(s : NetroutebgpPath, v : Double) -> NetroutebgpPath {
  let result = net_route_bgp_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_route_bgp_path_min(s : NetroutebgpPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_route_bgp_path_max(s : NetroutebgpPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_route_bgp_path_to_string(s : NetroutebgpPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetroutebgpCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_bgp_cluster_make(size : Int) -> NetroutebgpCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_bgp_cluster_len(s : NetroutebgpCluster) -> Int { s.size }

pub fn net_route_bgp_cluster_get(s : NetroutebgpCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_bgp_cluster_set(s : NetroutebgpCluster, i : Int, v : Double) -> NetroutebgpCluster {
  let result = net_route_bgp_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_route_bgp_cluster_sum(s : NetroutebgpCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_route_bgp_cluster_mean(s : NetroutebgpCluster) -> Double {
  if s.size == 0 { 0.0 } else { net_route_bgp_cluster_sum(s) / s.size.to_double() }
}

pub fn net_route_bgp_cluster_scale(s : NetroutebgpCluster, f : Double) -> NetroutebgpCluster {
  let result = net_route_bgp_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_route_bgp_cluster_add(a : NetroutebgpCluster, b : NetroutebgpCluster) -> NetroutebgpCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_route_bgp_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_route_bgp_cluster_copy(s : NetroutebgpCluster) -> NetroutebgpCluster {
  let result = net_route_bgp_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_route_bgp_cluster_fill(s : NetroutebgpCluster, v : Double) -> NetroutebgpCluster {
  let result = net_route_bgp_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_route_bgp_cluster_min(s : NetroutebgpCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_route_bgp_cluster_max(s : NetroutebgpCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_route_bgp_cluster_to_string(s : NetroutebgpCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetroutebgpModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_bgp_model_make(size : Int) -> NetroutebgpModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_bgp_model_len(s : NetroutebgpModel) -> Int { s.size }

pub fn net_route_bgp_model_get(s : NetroutebgpModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_bgp_model_set(s : NetroutebgpModel, i : Int, v : Double) -> NetroutebgpModel {
  let result = net_route_bgp_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_route_bgp_model_sum(s : NetroutebgpModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_route_bgp_model_mean(s : NetroutebgpModel) -> Double {
  if s.size == 0 { 0.0 } else { net_route_bgp_model_sum(s) / s.size.to_double() }
}

pub fn net_route_bgp_model_scale(s : NetroutebgpModel, f : Double) -> NetroutebgpModel {
  let result = net_route_bgp_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_route_bgp_model_add(a : NetroutebgpModel, b : NetroutebgpModel) -> NetroutebgpModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_route_bgp_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_route_bgp_model_copy(s : NetroutebgpModel) -> NetroutebgpModel {
  let result = net_route_bgp_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_route_bgp_model_fill(s : NetroutebgpModel, v : Double) -> NetroutebgpModel {
  let result = net_route_bgp_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_route_bgp_model_min(s : NetroutebgpModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_route_bgp_model_max(s : NetroutebgpModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_route_bgp_model_to_string(s : NetroutebgpModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetroutebgpLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_bgp_layer_make(size : Int) -> NetroutebgpLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_bgp_layer_len(s : NetroutebgpLayer) -> Int { s.size }

pub fn net_route_bgp_layer_get(s : NetroutebgpLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_bgp_layer_set(s : NetroutebgpLayer, i : Int, v : Double) -> NetroutebgpLayer {
  let result = net_route_bgp_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_route_bgp_layer_sum(s : NetroutebgpLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_route_bgp_layer_mean(s : NetroutebgpLayer) -> Double {
  if s.size == 0 { 0.0 } else { net_route_bgp_layer_sum(s) / s.size.to_double() }
}

pub fn net_route_bgp_layer_scale(s : NetroutebgpLayer, f : Double) -> NetroutebgpLayer {
  let result = net_route_bgp_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_route_bgp_layer_add(a : NetroutebgpLayer, b : NetroutebgpLayer) -> NetroutebgpLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_route_bgp_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_route_bgp_layer_copy(s : NetroutebgpLayer) -> NetroutebgpLayer {
  let result = net_route_bgp_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_route_bgp_layer_fill(s : NetroutebgpLayer, v : Double) -> NetroutebgpLayer {
  let result = net_route_bgp_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_route_bgp_layer_min(s : NetroutebgpLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_route_bgp_layer_max(s : NetroutebgpLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_route_bgp_layer_to_string(s : NetroutebgpLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetroutebgpBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_bgp_buffer_make(size : Int) -> NetroutebgpBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_bgp_buffer_len(s : NetroutebgpBuffer) -> Int { s.size }

pub fn net_route_bgp_buffer_get(s : NetroutebgpBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_bgp_buffer_set(s : NetroutebgpBuffer, i : Int, v : Double) -> NetroutebgpBuffer {
  let result = net_route_bgp_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_route_bgp_buffer_sum(s : NetroutebgpBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_route_bgp_buffer_mean(s : NetroutebgpBuffer) -> Double {
  if s.size == 0 { 0.0 } else { net_route_bgp_buffer_sum(s) / s.size.to_double() }
}

pub fn net_route_bgp_buffer_scale(s : NetroutebgpBuffer, f : Double) -> NetroutebgpBuffer {
  let result = net_route_bgp_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_route_bgp_buffer_add(a : NetroutebgpBuffer, b : NetroutebgpBuffer) -> NetroutebgpBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_route_bgp_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_route_bgp_buffer_copy(s : NetroutebgpBuffer) -> NetroutebgpBuffer {
  let result = net_route_bgp_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_route_bgp_buffer_fill(s : NetroutebgpBuffer, v : Double) -> NetroutebgpBuffer {
  let result = net_route_bgp_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_route_bgp_buffer_min(s : NetroutebgpBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_route_bgp_buffer_max(s : NetroutebgpBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_route_bgp_buffer_to_string(s : NetroutebgpBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetroutebgpCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_bgp_cursor_make(size : Int) -> NetroutebgpCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_bgp_cursor_len(s : NetroutebgpCursor) -> Int { s.size }

pub fn net_route_bgp_cursor_get(s : NetroutebgpCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_bgp_cursor_set(s : NetroutebgpCursor, i : Int, v : Double) -> NetroutebgpCursor {
  let result = net_route_bgp_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_route_bgp_cursor_sum(s : NetroutebgpCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_route_bgp_cursor_mean(s : NetroutebgpCursor) -> Double {
  if s.size == 0 { 0.0 } else { net_route_bgp_cursor_sum(s) / s.size.to_double() }
}

pub fn net_route_bgp_cursor_scale(s : NetroutebgpCursor, f : Double) -> NetroutebgpCursor {
  let result = net_route_bgp_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_route_bgp_cursor_add(a : NetroutebgpCursor, b : NetroutebgpCursor) -> NetroutebgpCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_route_bgp_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_route_bgp_cursor_copy(s : NetroutebgpCursor) -> NetroutebgpCursor {
  let result = net_route_bgp_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_route_bgp_cursor_fill(s : NetroutebgpCursor, v : Double) -> NetroutebgpCursor {
  let result = net_route_bgp_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_route_bgp_cursor_min(s : NetroutebgpCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_route_bgp_cursor_max(s : NetroutebgpCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_route_bgp_cursor_to_string(s : NetroutebgpCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetroutebgpView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_bgp_view_make(size : Int) -> NetroutebgpView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_bgp_view_len(s : NetroutebgpView) -> Int { s.size }

pub fn net_route_bgp_view_get(s : NetroutebgpView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_bgp_view_set(s : NetroutebgpView, i : Int, v : Double) -> NetroutebgpView {
  let result = net_route_bgp_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_route_bgp_view_sum(s : NetroutebgpView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_route_bgp_view_mean(s : NetroutebgpView) -> Double {
  if s.size == 0 { 0.0 } else { net_route_bgp_view_sum(s) / s.size.to_double() }
}

pub fn net_route_bgp_view_scale(s : NetroutebgpView, f : Double) -> NetroutebgpView {
  let result = net_route_bgp_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_route_bgp_view_add(a : NetroutebgpView, b : NetroutebgpView) -> NetroutebgpView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_route_bgp_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_route_bgp_view_copy(s : NetroutebgpView) -> NetroutebgpView {
  let result = net_route_bgp_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_route_bgp_view_fill(s : NetroutebgpView, v : Double) -> NetroutebgpView {
  let result = net_route_bgp_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_route_bgp_view_min(s : NetroutebgpView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_route_bgp_view_max(s : NetroutebgpView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_route_bgp_view_to_string(s : NetroutebgpView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetroutebgpRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_bgp_range_make(size : Int) -> NetroutebgpRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_bgp_range_len(s : NetroutebgpRange) -> Int { s.size }

pub fn net_route_bgp_range_get(s : NetroutebgpRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_bgp_range_set(s : NetroutebgpRange, i : Int, v : Double) -> NetroutebgpRange {
  let result = net_route_bgp_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_route_bgp_range_sum(s : NetroutebgpRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_route_bgp_range_mean(s : NetroutebgpRange) -> Double {
  if s.size == 0 { 0.0 } else { net_route_bgp_range_sum(s) / s.size.to_double() }
}

pub fn net_route_bgp_range_scale(s : NetroutebgpRange, f : Double) -> NetroutebgpRange {
  let result = net_route_bgp_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_route_bgp_range_add(a : NetroutebgpRange, b : NetroutebgpRange) -> NetroutebgpRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_route_bgp_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_route_bgp_range_copy(s : NetroutebgpRange) -> NetroutebgpRange {
  let result = net_route_bgp_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_route_bgp_range_fill(s : NetroutebgpRange, v : Double) -> NetroutebgpRange {
  let result = net_route_bgp_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_route_bgp_range_min(s : NetroutebgpRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_route_bgp_range_max(s : NetroutebgpRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_route_bgp_range_to_string(s : NetroutebgpRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetroutebgpSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_bgp_slice_make(size : Int) -> NetroutebgpSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_bgp_slice_len(s : NetroutebgpSlice) -> Int { s.size }

pub fn net_route_bgp_slice_get(s : NetroutebgpSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_bgp_slice_set(s : NetroutebgpSlice, i : Int, v : Double) -> NetroutebgpSlice {
  let result = net_route_bgp_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_route_bgp_slice_sum(s : NetroutebgpSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_route_bgp_slice_mean(s : NetroutebgpSlice) -> Double {
  if s.size == 0 { 0.0 } else { net_route_bgp_slice_sum(s) / s.size.to_double() }
}

pub fn net_route_bgp_slice_scale(s : NetroutebgpSlice, f : Double) -> NetroutebgpSlice {
  let result = net_route_bgp_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_route_bgp_slice_add(a : NetroutebgpSlice, b : NetroutebgpSlice) -> NetroutebgpSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_route_bgp_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_route_bgp_slice_copy(s : NetroutebgpSlice) -> NetroutebgpSlice {
  let result = net_route_bgp_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_route_bgp_slice_fill(s : NetroutebgpSlice, v : Double) -> NetroutebgpSlice {
  let result = net_route_bgp_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_route_bgp_slice_min(s : NetroutebgpSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_route_bgp_slice_max(s : NetroutebgpSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_route_bgp_slice_to_string(s : NetroutebgpSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn net_route_bgp_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_route_bgp_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_route_bgp_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_route_bgp_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_route_bgp_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_route_bgp_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_route_bgp_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_route_bgp_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_route_bgp_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_route_bgp_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_route_bgp_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_route_bgp_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_route_bgp_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_route_bgp_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_route_bgp_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_route_bgp_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_route_bgp_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_route_bgp_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_route_bgp_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_route_bgp_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_route_bgp_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_route_bgp_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_route_bgp_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_route_bgp_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_route_bgp_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

