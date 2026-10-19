///===
/// extcore/net_route_ospf

pub(all) struct NetrouteospfPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn net_route_ospf_make_point(x : Double, y : Double) -> NetrouteospfPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn net_route_ospf_make_point3(x : Double, y : Double, z : Double) -> NetrouteospfPoint {
  { x, y, z, label: 0 }
}

pub fn net_route_ospf_point_x(pt : NetrouteospfPoint) -> Double { pt.x }

pub fn net_route_ospf_point_y(pt : NetrouteospfPoint) -> Double { pt.y }

pub fn net_route_ospf_point_z(pt : NetrouteospfPoint) -> Double { pt.z }

pub fn net_route_ospf_point_label(pt : NetrouteospfPoint) -> Int { pt.label }

pub fn net_route_ospf_point_dist(a : NetrouteospfPoint, b : NetrouteospfPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  net_route_ospf_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn net_route_ospf_point_add(a : NetrouteospfPoint, b : NetrouteospfPoint) -> NetrouteospfPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn net_route_ospf_point_sub(a : NetrouteospfPoint, b : NetrouteospfPoint) -> NetrouteospfPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn net_route_ospf_point_scale(pt : NetrouteospfPoint, s : Double) -> NetrouteospfPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn net_route_ospf_point_dot(a : NetrouteospfPoint, b : NetrouteospfPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn net_route_ospf_point_cross(a : NetrouteospfPoint, b : NetrouteospfPoint) -> NetrouteospfPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn net_route_ospf_point_norm(pt : NetrouteospfPoint) -> Double {
  net_route_ospf_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn net_route_ospf_point_normalize(pt : NetrouteospfPoint) -> NetrouteospfPoint {
  let n = net_route_ospf_point_norm(pt)
  if n < 0.0000001 { pt } else { net_route_ospf_point_scale(pt, 1.0 / n) }
}

pub fn net_route_ospf_point_negate(pt : NetrouteospfPoint) -> NetrouteospfPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn net_route_ospf_point_mid(a : NetrouteospfPoint, b : NetrouteospfPoint) -> NetrouteospfPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn net_route_ospf_point_lerp(a : NetrouteospfPoint, b : NetrouteospfPoint, t : Double) -> NetrouteospfPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn net_route_ospf_point_to_string(pt : NetrouteospfPoint) -> String {
  "(" + net_route_ospf_dbl(pt.x) + ", " + net_route_ospf_dbl(pt.y) + ", " + net_route_ospf_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct NetrouteospfSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn net_route_ospf_make_series(vals : Array[Double], name : String) -> NetrouteospfSeries {
  { vals, name, meta: 0 }
}

pub fn net_route_ospf_series_len(s : NetrouteospfSeries) -> Int { s.vals.length() }

pub fn net_route_ospf_series_sum(s : NetrouteospfSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn net_route_ospf_series_mean(s : NetrouteospfSeries) -> Double {
  let n = net_route_ospf_series_len(s)
  if n == 0 { 0.0 } else { net_route_ospf_series_sum(s) / n.to_double() }
}

pub fn net_route_ospf_series_min(s : NetrouteospfSeries) -> Double {
  let n = net_route_ospf_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn net_route_ospf_series_max(s : NetrouteospfSeries) -> Double {
  let n = net_route_ospf_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn net_route_ospf_series_range(s : NetrouteospfSeries) -> Double {
  net_route_ospf_series_max(s) - net_route_ospf_series_min(s)
}

pub fn net_route_ospf_series_var(s : NetrouteospfSeries) -> Double {
  let n = net_route_ospf_series_len(s)
  if n == 0 { 0.0 } else {
    let m = net_route_ospf_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn net_route_ospf_series_std(s : NetrouteospfSeries) -> Double { net_route_ospf_sqrt(net_route_ospf_series_var(s)) }

pub fn net_route_ospf_series_median(s : NetrouteospfSeries) -> Double {
  let n = net_route_ospf_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = net_route_ospf_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn net_route_ospf_series_scale(s : NetrouteospfSeries, f : Double) -> NetrouteospfSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = net_route_ospf_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn net_route_ospf_series_add(a : NetrouteospfSeries, b : NetrouteospfSeries) -> NetrouteospfSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = net_route_ospf_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn net_route_ospf_series_sub(a : NetrouteospfSeries, b : NetrouteospfSeries) -> NetrouteospfSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = net_route_ospf_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn net_route_ospf_series_normalize(s : NetrouteospfSeries) -> NetrouteospfSeries {
  let mn = net_route_ospf_series_min(s)
  let mx = net_route_ospf_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = net_route_ospf_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn net_route_ospf_series_cumsum(s : NetrouteospfSeries) -> NetrouteospfSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = net_route_ospf_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn net_route_ospf_series_to_string(s : NetrouteospfSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + net_route_ospf_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NetrouteospfMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn net_route_ospf_make_matrix(rows : Int, cols : Int, val : Double) -> NetrouteospfMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn net_route_ospf_matrix_identity(n : Int) -> NetrouteospfMatrix {
  let m = net_route_ospf_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn net_route_ospf_matrix_get(m : NetrouteospfMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn net_route_ospf_matrix_transpose(m : NetrouteospfMatrix) -> NetrouteospfMatrix {
  let result = net_route_ospf_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn net_route_ospf_matrix_add(a : NetrouteospfMatrix, b : NetrouteospfMatrix) -> NetrouteospfMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = net_route_ospf_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn net_route_ospf_matrix_scale(m : NetrouteospfMatrix, s : Double) -> NetrouteospfMatrix {
  let result = net_route_ospf_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn net_route_ospf_matrix_multiply(a : NetrouteospfMatrix, b : NetrouteospfMatrix) -> NetrouteospfMatrix {
  if a.cols != b.rows { return net_route_ospf_make_matrix(a.rows, b.cols, 0.0) }
  let result = net_route_ospf_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn net_route_ospf_matrix_trace(m : NetrouteospfMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn net_route_ospf_matrix_det(m : NetrouteospfMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn net_route_ospf_matrix_norm(m : NetrouteospfMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  net_route_ospf_sqrt(sum)
}

pub fn net_route_ospf_matrix_to_string(m : NetrouteospfMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + net_route_ospf_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct NetrouteospfVector {
  comps : Array[Double]
  dim : Int
}

pub fn net_route_ospf_make_vector(comps : Array[Double]) -> NetrouteospfVector {
  { comps, dim: comps.length() }
}

pub fn net_route_ospf_vector_zero(dim : Int) -> NetrouteospfVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn net_route_ospf_vector_add(a : NetrouteospfVector, b : NetrouteospfVector) -> NetrouteospfVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = net_route_ospf_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn net_route_ospf_vector_sub(a : NetrouteospfVector, b : NetrouteospfVector) -> NetrouteospfVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = net_route_ospf_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn net_route_ospf_vector_scale(v : NetrouteospfVector, s : Double) -> NetrouteospfVector {
  let mut result = []
  for i in 0..<v.dim { result = net_route_ospf_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn net_route_ospf_vector_dot(a : NetrouteospfVector, b : NetrouteospfVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn net_route_ospf_vector_norm(v : NetrouteospfVector) -> Double { net_route_ospf_sqrt(net_route_ospf_vector_dot(v, v)) }

pub fn net_route_ospf_vector_normalize(v : NetrouteospfVector) -> NetrouteospfVector {
  let n = net_route_ospf_vector_norm(v)
  if n < 0.0000001 { v } else { net_route_ospf_vector_scale(v, 1.0 / n) }
}

pub fn net_route_ospf_vector_dist(a : NetrouteospfVector, b : NetrouteospfVector) -> Double {
  net_route_ospf_vector_norm(net_route_ospf_vector_sub(a, b))
}

pub fn net_route_ospf_vector_to_string(v : NetrouteospfVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + net_route_ospf_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn net_route_ospf_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn net_route_ospf_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = net_route_ospf_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn net_route_ospf_std(data : Array[Double]) -> Double { net_route_ospf_sqrt(net_route_ospf_var(data)) }

pub fn net_route_ospf_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = net_route_ospf_mean(a); let mb = net_route_ospf_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn net_route_ospf_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = net_route_ospf_std(a); let sb = net_route_ospf_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { net_route_ospf_cov(a, b) / (sa * sb) }
}

pub fn net_route_ospf_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = net_route_ospf_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn net_route_ospf_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn net_route_ospf_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn net_route_ospf_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  net_route_ospf_sqrt(net_route_ospf_mse(pred, labels))
}

pub fn net_route_ospf_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + net_route_ospf_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn net_route_ospf_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = net_route_ospf_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn net_route_ospf_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn net_route_ospf_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn net_route_ospf_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = net_route_ospf_precision(pred, labels, pos); let r = net_route_ospf_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn net_route_ospf_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn net_route_ospf_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = net_route_ospf_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn net_route_ospf_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn net_route_ospf_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn net_route_ospf_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = net_route_ospf_gcd(a, b)
    (a / g) * b
  }
}

pub fn net_route_ospf_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn net_route_ospf_fibonacci(n : Int) -> Int {
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

pub fn net_route_ospf_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = net_route_ospf_min(data); let mx = net_route_ospf_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn net_route_ospf_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = net_route_ospf_mean(data); let sd = net_route_ospf_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn net_route_ospf_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn net_route_ospf_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn net_route_ospf_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn net_route_ospf_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn net_route_ospf_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn net_route_ospf_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn net_route_ospf_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn net_route_ospf_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn net_route_ospf_dbl(x : Double) -> String {
  let i = if x >= 0.0 { net_route_ospf_int(x) } else { -net_route_ospf_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { net_route_ospf_int(f * 1000000.0) } else { net_route_ospf_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn net_route_ospf_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn net_route_ospf_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct NetrouteospfFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_ospf_frame_make(size : Int) -> NetrouteospfFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_ospf_frame_len(s : NetrouteospfFrame) -> Int { s.size }

pub fn net_route_ospf_frame_get(s : NetrouteospfFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_ospf_frame_set(s : NetrouteospfFrame, i : Int, v : Double) -> NetrouteospfFrame {
  let result = net_route_ospf_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_route_ospf_frame_sum(s : NetrouteospfFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_route_ospf_frame_mean(s : NetrouteospfFrame) -> Double {
  if s.size == 0 { 0.0 } else { net_route_ospf_frame_sum(s) / s.size.to_double() }
}

pub fn net_route_ospf_frame_scale(s : NetrouteospfFrame, f : Double) -> NetrouteospfFrame {
  let result = net_route_ospf_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_route_ospf_frame_add(a : NetrouteospfFrame, b : NetrouteospfFrame) -> NetrouteospfFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_route_ospf_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_route_ospf_frame_copy(s : NetrouteospfFrame) -> NetrouteospfFrame {
  let result = net_route_ospf_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_route_ospf_frame_fill(s : NetrouteospfFrame, v : Double) -> NetrouteospfFrame {
  let result = net_route_ospf_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_route_ospf_frame_min(s : NetrouteospfFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_route_ospf_frame_max(s : NetrouteospfFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_route_ospf_frame_to_string(s : NetrouteospfFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetrouteospfTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_ospf_table_make(size : Int) -> NetrouteospfTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_ospf_table_len(s : NetrouteospfTable) -> Int { s.size }

pub fn net_route_ospf_table_get(s : NetrouteospfTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_ospf_table_set(s : NetrouteospfTable, i : Int, v : Double) -> NetrouteospfTable {
  let result = net_route_ospf_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_route_ospf_table_sum(s : NetrouteospfTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_route_ospf_table_mean(s : NetrouteospfTable) -> Double {
  if s.size == 0 { 0.0 } else { net_route_ospf_table_sum(s) / s.size.to_double() }
}

pub fn net_route_ospf_table_scale(s : NetrouteospfTable, f : Double) -> NetrouteospfTable {
  let result = net_route_ospf_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_route_ospf_table_add(a : NetrouteospfTable, b : NetrouteospfTable) -> NetrouteospfTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_route_ospf_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_route_ospf_table_copy(s : NetrouteospfTable) -> NetrouteospfTable {
  let result = net_route_ospf_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_route_ospf_table_fill(s : NetrouteospfTable, v : Double) -> NetrouteospfTable {
  let result = net_route_ospf_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_route_ospf_table_min(s : NetrouteospfTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_route_ospf_table_max(s : NetrouteospfTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_route_ospf_table_to_string(s : NetrouteospfTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetrouteospfGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_ospf_graphn_make(size : Int) -> NetrouteospfGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_ospf_graphn_len(s : NetrouteospfGraphN) -> Int { s.size }

pub fn net_route_ospf_graphn_get(s : NetrouteospfGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_ospf_graphn_set(s : NetrouteospfGraphN, i : Int, v : Double) -> NetrouteospfGraphN {
  let result = net_route_ospf_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_route_ospf_graphn_sum(s : NetrouteospfGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_route_ospf_graphn_mean(s : NetrouteospfGraphN) -> Double {
  if s.size == 0 { 0.0 } else { net_route_ospf_graphn_sum(s) / s.size.to_double() }
}

pub fn net_route_ospf_graphn_scale(s : NetrouteospfGraphN, f : Double) -> NetrouteospfGraphN {
  let result = net_route_ospf_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_route_ospf_graphn_add(a : NetrouteospfGraphN, b : NetrouteospfGraphN) -> NetrouteospfGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_route_ospf_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_route_ospf_graphn_copy(s : NetrouteospfGraphN) -> NetrouteospfGraphN {
  let result = net_route_ospf_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_route_ospf_graphn_fill(s : NetrouteospfGraphN, v : Double) -> NetrouteospfGraphN {
  let result = net_route_ospf_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_route_ospf_graphn_min(s : NetrouteospfGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_route_ospf_graphn_max(s : NetrouteospfGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_route_ospf_graphn_to_string(s : NetrouteospfGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetrouteospfNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_ospf_node_make(size : Int) -> NetrouteospfNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_ospf_node_len(s : NetrouteospfNode) -> Int { s.size }

pub fn net_route_ospf_node_get(s : NetrouteospfNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_ospf_node_set(s : NetrouteospfNode, i : Int, v : Double) -> NetrouteospfNode {
  let result = net_route_ospf_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_route_ospf_node_sum(s : NetrouteospfNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_route_ospf_node_mean(s : NetrouteospfNode) -> Double {
  if s.size == 0 { 0.0 } else { net_route_ospf_node_sum(s) / s.size.to_double() }
}

pub fn net_route_ospf_node_scale(s : NetrouteospfNode, f : Double) -> NetrouteospfNode {
  let result = net_route_ospf_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_route_ospf_node_add(a : NetrouteospfNode, b : NetrouteospfNode) -> NetrouteospfNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_route_ospf_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_route_ospf_node_copy(s : NetrouteospfNode) -> NetrouteospfNode {
  let result = net_route_ospf_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_route_ospf_node_fill(s : NetrouteospfNode, v : Double) -> NetrouteospfNode {
  let result = net_route_ospf_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_route_ospf_node_min(s : NetrouteospfNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_route_ospf_node_max(s : NetrouteospfNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_route_ospf_node_to_string(s : NetrouteospfNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetrouteospfEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_ospf_edge_make(size : Int) -> NetrouteospfEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_ospf_edge_len(s : NetrouteospfEdge) -> Int { s.size }

pub fn net_route_ospf_edge_get(s : NetrouteospfEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_ospf_edge_set(s : NetrouteospfEdge, i : Int, v : Double) -> NetrouteospfEdge {
  let result = net_route_ospf_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_route_ospf_edge_sum(s : NetrouteospfEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_route_ospf_edge_mean(s : NetrouteospfEdge) -> Double {
  if s.size == 0 { 0.0 } else { net_route_ospf_edge_sum(s) / s.size.to_double() }
}

pub fn net_route_ospf_edge_scale(s : NetrouteospfEdge, f : Double) -> NetrouteospfEdge {
  let result = net_route_ospf_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_route_ospf_edge_add(a : NetrouteospfEdge, b : NetrouteospfEdge) -> NetrouteospfEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_route_ospf_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_route_ospf_edge_copy(s : NetrouteospfEdge) -> NetrouteospfEdge {
  let result = net_route_ospf_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_route_ospf_edge_fill(s : NetrouteospfEdge, v : Double) -> NetrouteospfEdge {
  let result = net_route_ospf_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_route_ospf_edge_min(s : NetrouteospfEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_route_ospf_edge_max(s : NetrouteospfEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_route_ospf_edge_to_string(s : NetrouteospfEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetrouteospfPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_ospf_path_make(size : Int) -> NetrouteospfPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_ospf_path_len(s : NetrouteospfPath) -> Int { s.size }

pub fn net_route_ospf_path_get(s : NetrouteospfPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_ospf_path_set(s : NetrouteospfPath, i : Int, v : Double) -> NetrouteospfPath {
  let result = net_route_ospf_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_route_ospf_path_sum(s : NetrouteospfPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_route_ospf_path_mean(s : NetrouteospfPath) -> Double {
  if s.size == 0 { 0.0 } else { net_route_ospf_path_sum(s) / s.size.to_double() }
}

pub fn net_route_ospf_path_scale(s : NetrouteospfPath, f : Double) -> NetrouteospfPath {
  let result = net_route_ospf_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_route_ospf_path_add(a : NetrouteospfPath, b : NetrouteospfPath) -> NetrouteospfPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_route_ospf_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_route_ospf_path_copy(s : NetrouteospfPath) -> NetrouteospfPath {
  let result = net_route_ospf_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_route_ospf_path_fill(s : NetrouteospfPath, v : Double) -> NetrouteospfPath {
  let result = net_route_ospf_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_route_ospf_path_min(s : NetrouteospfPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_route_ospf_path_max(s : NetrouteospfPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_route_ospf_path_to_string(s : NetrouteospfPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetrouteospfCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_ospf_cluster_make(size : Int) -> NetrouteospfCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_ospf_cluster_len(s : NetrouteospfCluster) -> Int { s.size }

pub fn net_route_ospf_cluster_get(s : NetrouteospfCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_ospf_cluster_set(s : NetrouteospfCluster, i : Int, v : Double) -> NetrouteospfCluster {
  let result = net_route_ospf_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_route_ospf_cluster_sum(s : NetrouteospfCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_route_ospf_cluster_mean(s : NetrouteospfCluster) -> Double {
  if s.size == 0 { 0.0 } else { net_route_ospf_cluster_sum(s) / s.size.to_double() }
}

pub fn net_route_ospf_cluster_scale(s : NetrouteospfCluster, f : Double) -> NetrouteospfCluster {
  let result = net_route_ospf_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_route_ospf_cluster_add(a : NetrouteospfCluster, b : NetrouteospfCluster) -> NetrouteospfCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_route_ospf_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_route_ospf_cluster_copy(s : NetrouteospfCluster) -> NetrouteospfCluster {
  let result = net_route_ospf_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_route_ospf_cluster_fill(s : NetrouteospfCluster, v : Double) -> NetrouteospfCluster {
  let result = net_route_ospf_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_route_ospf_cluster_min(s : NetrouteospfCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_route_ospf_cluster_max(s : NetrouteospfCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_route_ospf_cluster_to_string(s : NetrouteospfCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetrouteospfModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_ospf_model_make(size : Int) -> NetrouteospfModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_ospf_model_len(s : NetrouteospfModel) -> Int { s.size }

pub fn net_route_ospf_model_get(s : NetrouteospfModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_ospf_model_set(s : NetrouteospfModel, i : Int, v : Double) -> NetrouteospfModel {
  let result = net_route_ospf_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_route_ospf_model_sum(s : NetrouteospfModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_route_ospf_model_mean(s : NetrouteospfModel) -> Double {
  if s.size == 0 { 0.0 } else { net_route_ospf_model_sum(s) / s.size.to_double() }
}

pub fn net_route_ospf_model_scale(s : NetrouteospfModel, f : Double) -> NetrouteospfModel {
  let result = net_route_ospf_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_route_ospf_model_add(a : NetrouteospfModel, b : NetrouteospfModel) -> NetrouteospfModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_route_ospf_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_route_ospf_model_copy(s : NetrouteospfModel) -> NetrouteospfModel {
  let result = net_route_ospf_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_route_ospf_model_fill(s : NetrouteospfModel, v : Double) -> NetrouteospfModel {
  let result = net_route_ospf_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_route_ospf_model_min(s : NetrouteospfModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_route_ospf_model_max(s : NetrouteospfModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_route_ospf_model_to_string(s : NetrouteospfModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetrouteospfLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_ospf_layer_make(size : Int) -> NetrouteospfLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_ospf_layer_len(s : NetrouteospfLayer) -> Int { s.size }

pub fn net_route_ospf_layer_get(s : NetrouteospfLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_ospf_layer_set(s : NetrouteospfLayer, i : Int, v : Double) -> NetrouteospfLayer {
  let result = net_route_ospf_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_route_ospf_layer_sum(s : NetrouteospfLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_route_ospf_layer_mean(s : NetrouteospfLayer) -> Double {
  if s.size == 0 { 0.0 } else { net_route_ospf_layer_sum(s) / s.size.to_double() }
}

pub fn net_route_ospf_layer_scale(s : NetrouteospfLayer, f : Double) -> NetrouteospfLayer {
  let result = net_route_ospf_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_route_ospf_layer_add(a : NetrouteospfLayer, b : NetrouteospfLayer) -> NetrouteospfLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_route_ospf_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_route_ospf_layer_copy(s : NetrouteospfLayer) -> NetrouteospfLayer {
  let result = net_route_ospf_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_route_ospf_layer_fill(s : NetrouteospfLayer, v : Double) -> NetrouteospfLayer {
  let result = net_route_ospf_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_route_ospf_layer_min(s : NetrouteospfLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_route_ospf_layer_max(s : NetrouteospfLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_route_ospf_layer_to_string(s : NetrouteospfLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetrouteospfBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_ospf_buffer_make(size : Int) -> NetrouteospfBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_ospf_buffer_len(s : NetrouteospfBuffer) -> Int { s.size }

pub fn net_route_ospf_buffer_get(s : NetrouteospfBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_ospf_buffer_set(s : NetrouteospfBuffer, i : Int, v : Double) -> NetrouteospfBuffer {
  let result = net_route_ospf_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_route_ospf_buffer_sum(s : NetrouteospfBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_route_ospf_buffer_mean(s : NetrouteospfBuffer) -> Double {
  if s.size == 0 { 0.0 } else { net_route_ospf_buffer_sum(s) / s.size.to_double() }
}

pub fn net_route_ospf_buffer_scale(s : NetrouteospfBuffer, f : Double) -> NetrouteospfBuffer {
  let result = net_route_ospf_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_route_ospf_buffer_add(a : NetrouteospfBuffer, b : NetrouteospfBuffer) -> NetrouteospfBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_route_ospf_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_route_ospf_buffer_copy(s : NetrouteospfBuffer) -> NetrouteospfBuffer {
  let result = net_route_ospf_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_route_ospf_buffer_fill(s : NetrouteospfBuffer, v : Double) -> NetrouteospfBuffer {
  let result = net_route_ospf_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_route_ospf_buffer_min(s : NetrouteospfBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_route_ospf_buffer_max(s : NetrouteospfBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_route_ospf_buffer_to_string(s : NetrouteospfBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetrouteospfCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_ospf_cursor_make(size : Int) -> NetrouteospfCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_ospf_cursor_len(s : NetrouteospfCursor) -> Int { s.size }

pub fn net_route_ospf_cursor_get(s : NetrouteospfCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_ospf_cursor_set(s : NetrouteospfCursor, i : Int, v : Double) -> NetrouteospfCursor {
  let result = net_route_ospf_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_route_ospf_cursor_sum(s : NetrouteospfCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_route_ospf_cursor_mean(s : NetrouteospfCursor) -> Double {
  if s.size == 0 { 0.0 } else { net_route_ospf_cursor_sum(s) / s.size.to_double() }
}

pub fn net_route_ospf_cursor_scale(s : NetrouteospfCursor, f : Double) -> NetrouteospfCursor {
  let result = net_route_ospf_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_route_ospf_cursor_add(a : NetrouteospfCursor, b : NetrouteospfCursor) -> NetrouteospfCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_route_ospf_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_route_ospf_cursor_copy(s : NetrouteospfCursor) -> NetrouteospfCursor {
  let result = net_route_ospf_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_route_ospf_cursor_fill(s : NetrouteospfCursor, v : Double) -> NetrouteospfCursor {
  let result = net_route_ospf_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_route_ospf_cursor_min(s : NetrouteospfCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_route_ospf_cursor_max(s : NetrouteospfCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_route_ospf_cursor_to_string(s : NetrouteospfCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetrouteospfView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_ospf_view_make(size : Int) -> NetrouteospfView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_ospf_view_len(s : NetrouteospfView) -> Int { s.size }

pub fn net_route_ospf_view_get(s : NetrouteospfView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_ospf_view_set(s : NetrouteospfView, i : Int, v : Double) -> NetrouteospfView {
  let result = net_route_ospf_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_route_ospf_view_sum(s : NetrouteospfView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_route_ospf_view_mean(s : NetrouteospfView) -> Double {
  if s.size == 0 { 0.0 } else { net_route_ospf_view_sum(s) / s.size.to_double() }
}

pub fn net_route_ospf_view_scale(s : NetrouteospfView, f : Double) -> NetrouteospfView {
  let result = net_route_ospf_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_route_ospf_view_add(a : NetrouteospfView, b : NetrouteospfView) -> NetrouteospfView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_route_ospf_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_route_ospf_view_copy(s : NetrouteospfView) -> NetrouteospfView {
  let result = net_route_ospf_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_route_ospf_view_fill(s : NetrouteospfView, v : Double) -> NetrouteospfView {
  let result = net_route_ospf_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_route_ospf_view_min(s : NetrouteospfView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_route_ospf_view_max(s : NetrouteospfView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_route_ospf_view_to_string(s : NetrouteospfView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetrouteospfRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_ospf_range_make(size : Int) -> NetrouteospfRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_ospf_range_len(s : NetrouteospfRange) -> Int { s.size }

pub fn net_route_ospf_range_get(s : NetrouteospfRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_ospf_range_set(s : NetrouteospfRange, i : Int, v : Double) -> NetrouteospfRange {
  let result = net_route_ospf_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_route_ospf_range_sum(s : NetrouteospfRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_route_ospf_range_mean(s : NetrouteospfRange) -> Double {
  if s.size == 0 { 0.0 } else { net_route_ospf_range_sum(s) / s.size.to_double() }
}

pub fn net_route_ospf_range_scale(s : NetrouteospfRange, f : Double) -> NetrouteospfRange {
  let result = net_route_ospf_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_route_ospf_range_add(a : NetrouteospfRange, b : NetrouteospfRange) -> NetrouteospfRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_route_ospf_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_route_ospf_range_copy(s : NetrouteospfRange) -> NetrouteospfRange {
  let result = net_route_ospf_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_route_ospf_range_fill(s : NetrouteospfRange, v : Double) -> NetrouteospfRange {
  let result = net_route_ospf_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_route_ospf_range_min(s : NetrouteospfRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_route_ospf_range_max(s : NetrouteospfRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_route_ospf_range_to_string(s : NetrouteospfRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetrouteospfSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_ospf_slice_make(size : Int) -> NetrouteospfSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_ospf_slice_len(s : NetrouteospfSlice) -> Int { s.size }

pub fn net_route_ospf_slice_get(s : NetrouteospfSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_ospf_slice_set(s : NetrouteospfSlice, i : Int, v : Double) -> NetrouteospfSlice {
  let result = net_route_ospf_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_route_ospf_slice_sum(s : NetrouteospfSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_route_ospf_slice_mean(s : NetrouteospfSlice) -> Double {
  if s.size == 0 { 0.0 } else { net_route_ospf_slice_sum(s) / s.size.to_double() }
}

pub fn net_route_ospf_slice_scale(s : NetrouteospfSlice, f : Double) -> NetrouteospfSlice {
  let result = net_route_ospf_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_route_ospf_slice_add(a : NetrouteospfSlice, b : NetrouteospfSlice) -> NetrouteospfSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_route_ospf_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_route_ospf_slice_copy(s : NetrouteospfSlice) -> NetrouteospfSlice {
  let result = net_route_ospf_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_route_ospf_slice_fill(s : NetrouteospfSlice, v : Double) -> NetrouteospfSlice {
  let result = net_route_ospf_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_route_ospf_slice_min(s : NetrouteospfSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_route_ospf_slice_max(s : NetrouteospfSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_route_ospf_slice_to_string(s : NetrouteospfSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn net_route_ospf_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_route_ospf_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_route_ospf_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_route_ospf_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_route_ospf_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_route_ospf_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_route_ospf_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_route_ospf_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_route_ospf_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_route_ospf_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_route_ospf_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_route_ospf_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_route_ospf_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_route_ospf_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_route_ospf_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_route_ospf_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_route_ospf_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_route_ospf_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_route_ospf_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_route_ospf_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_route_ospf_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_route_ospf_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_route_ospf_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_route_ospf_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_route_ospf_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

