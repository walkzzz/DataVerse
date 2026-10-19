///===
/// extcore/net_flow_window

pub(all) struct NetflowwindowPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn net_flow_window_make_point(x : Double, y : Double) -> NetflowwindowPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn net_flow_window_make_point3(x : Double, y : Double, z : Double) -> NetflowwindowPoint {
  { x, y, z, label: 0 }
}

pub fn net_flow_window_point_x(pt : NetflowwindowPoint) -> Double { pt.x }

pub fn net_flow_window_point_y(pt : NetflowwindowPoint) -> Double { pt.y }

pub fn net_flow_window_point_z(pt : NetflowwindowPoint) -> Double { pt.z }

pub fn net_flow_window_point_label(pt : NetflowwindowPoint) -> Int { pt.label }

pub fn net_flow_window_point_dist(a : NetflowwindowPoint, b : NetflowwindowPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  net_flow_window_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn net_flow_window_point_add(a : NetflowwindowPoint, b : NetflowwindowPoint) -> NetflowwindowPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn net_flow_window_point_sub(a : NetflowwindowPoint, b : NetflowwindowPoint) -> NetflowwindowPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn net_flow_window_point_scale(pt : NetflowwindowPoint, s : Double) -> NetflowwindowPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn net_flow_window_point_dot(a : NetflowwindowPoint, b : NetflowwindowPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn net_flow_window_point_cross(a : NetflowwindowPoint, b : NetflowwindowPoint) -> NetflowwindowPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn net_flow_window_point_norm(pt : NetflowwindowPoint) -> Double {
  net_flow_window_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn net_flow_window_point_normalize(pt : NetflowwindowPoint) -> NetflowwindowPoint {
  let n = net_flow_window_point_norm(pt)
  if n < 0.0000001 { pt } else { net_flow_window_point_scale(pt, 1.0 / n) }
}

pub fn net_flow_window_point_negate(pt : NetflowwindowPoint) -> NetflowwindowPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn net_flow_window_point_mid(a : NetflowwindowPoint, b : NetflowwindowPoint) -> NetflowwindowPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn net_flow_window_point_lerp(a : NetflowwindowPoint, b : NetflowwindowPoint, t : Double) -> NetflowwindowPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn net_flow_window_point_to_string(pt : NetflowwindowPoint) -> String {
  "(" + net_flow_window_dbl(pt.x) + ", " + net_flow_window_dbl(pt.y) + ", " + net_flow_window_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct NetflowwindowSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn net_flow_window_make_series(vals : Array[Double], name : String) -> NetflowwindowSeries {
  { vals, name, meta: 0 }
}

pub fn net_flow_window_series_len(s : NetflowwindowSeries) -> Int { s.vals.length() }

pub fn net_flow_window_series_sum(s : NetflowwindowSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn net_flow_window_series_mean(s : NetflowwindowSeries) -> Double {
  let n = net_flow_window_series_len(s)
  if n == 0 { 0.0 } else { net_flow_window_series_sum(s) / n.to_double() }
}

pub fn net_flow_window_series_min(s : NetflowwindowSeries) -> Double {
  let n = net_flow_window_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn net_flow_window_series_max(s : NetflowwindowSeries) -> Double {
  let n = net_flow_window_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn net_flow_window_series_range(s : NetflowwindowSeries) -> Double {
  net_flow_window_series_max(s) - net_flow_window_series_min(s)
}

pub fn net_flow_window_series_var(s : NetflowwindowSeries) -> Double {
  let n = net_flow_window_series_len(s)
  if n == 0 { 0.0 } else {
    let m = net_flow_window_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn net_flow_window_series_std(s : NetflowwindowSeries) -> Double { net_flow_window_sqrt(net_flow_window_series_var(s)) }

pub fn net_flow_window_series_median(s : NetflowwindowSeries) -> Double {
  let n = net_flow_window_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = net_flow_window_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn net_flow_window_series_scale(s : NetflowwindowSeries, f : Double) -> NetflowwindowSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = net_flow_window_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn net_flow_window_series_add(a : NetflowwindowSeries, b : NetflowwindowSeries) -> NetflowwindowSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = net_flow_window_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn net_flow_window_series_sub(a : NetflowwindowSeries, b : NetflowwindowSeries) -> NetflowwindowSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = net_flow_window_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn net_flow_window_series_normalize(s : NetflowwindowSeries) -> NetflowwindowSeries {
  let mn = net_flow_window_series_min(s)
  let mx = net_flow_window_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = net_flow_window_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn net_flow_window_series_cumsum(s : NetflowwindowSeries) -> NetflowwindowSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = net_flow_window_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn net_flow_window_series_to_string(s : NetflowwindowSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + net_flow_window_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NetflowwindowMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn net_flow_window_make_matrix(rows : Int, cols : Int, val : Double) -> NetflowwindowMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn net_flow_window_matrix_identity(n : Int) -> NetflowwindowMatrix {
  let m = net_flow_window_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn net_flow_window_matrix_get(m : NetflowwindowMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn net_flow_window_matrix_transpose(m : NetflowwindowMatrix) -> NetflowwindowMatrix {
  let result = net_flow_window_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn net_flow_window_matrix_add(a : NetflowwindowMatrix, b : NetflowwindowMatrix) -> NetflowwindowMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = net_flow_window_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn net_flow_window_matrix_scale(m : NetflowwindowMatrix, s : Double) -> NetflowwindowMatrix {
  let result = net_flow_window_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn net_flow_window_matrix_multiply(a : NetflowwindowMatrix, b : NetflowwindowMatrix) -> NetflowwindowMatrix {
  if a.cols != b.rows { return net_flow_window_make_matrix(a.rows, b.cols, 0.0) }
  let result = net_flow_window_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn net_flow_window_matrix_trace(m : NetflowwindowMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn net_flow_window_matrix_det(m : NetflowwindowMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn net_flow_window_matrix_norm(m : NetflowwindowMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  net_flow_window_sqrt(sum)
}

pub fn net_flow_window_matrix_to_string(m : NetflowwindowMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + net_flow_window_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct NetflowwindowVector {
  comps : Array[Double]
  dim : Int
}

pub fn net_flow_window_make_vector(comps : Array[Double]) -> NetflowwindowVector {
  { comps, dim: comps.length() }
}

pub fn net_flow_window_vector_zero(dim : Int) -> NetflowwindowVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn net_flow_window_vector_add(a : NetflowwindowVector, b : NetflowwindowVector) -> NetflowwindowVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = net_flow_window_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn net_flow_window_vector_sub(a : NetflowwindowVector, b : NetflowwindowVector) -> NetflowwindowVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = net_flow_window_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn net_flow_window_vector_scale(v : NetflowwindowVector, s : Double) -> NetflowwindowVector {
  let mut result = []
  for i in 0..<v.dim { result = net_flow_window_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn net_flow_window_vector_dot(a : NetflowwindowVector, b : NetflowwindowVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn net_flow_window_vector_norm(v : NetflowwindowVector) -> Double { net_flow_window_sqrt(net_flow_window_vector_dot(v, v)) }

pub fn net_flow_window_vector_normalize(v : NetflowwindowVector) -> NetflowwindowVector {
  let n = net_flow_window_vector_norm(v)
  if n < 0.0000001 { v } else { net_flow_window_vector_scale(v, 1.0 / n) }
}

pub fn net_flow_window_vector_dist(a : NetflowwindowVector, b : NetflowwindowVector) -> Double {
  net_flow_window_vector_norm(net_flow_window_vector_sub(a, b))
}

pub fn net_flow_window_vector_to_string(v : NetflowwindowVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + net_flow_window_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn net_flow_window_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn net_flow_window_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = net_flow_window_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn net_flow_window_std(data : Array[Double]) -> Double { net_flow_window_sqrt(net_flow_window_var(data)) }

pub fn net_flow_window_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = net_flow_window_mean(a); let mb = net_flow_window_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn net_flow_window_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = net_flow_window_std(a); let sb = net_flow_window_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { net_flow_window_cov(a, b) / (sa * sb) }
}

pub fn net_flow_window_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = net_flow_window_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn net_flow_window_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn net_flow_window_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn net_flow_window_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  net_flow_window_sqrt(net_flow_window_mse(pred, labels))
}

pub fn net_flow_window_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + net_flow_window_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn net_flow_window_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = net_flow_window_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn net_flow_window_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn net_flow_window_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn net_flow_window_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = net_flow_window_precision(pred, labels, pos); let r = net_flow_window_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn net_flow_window_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn net_flow_window_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = net_flow_window_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn net_flow_window_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn net_flow_window_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn net_flow_window_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = net_flow_window_gcd(a, b)
    (a / g) * b
  }
}

pub fn net_flow_window_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn net_flow_window_fibonacci(n : Int) -> Int {
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

pub fn net_flow_window_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = net_flow_window_min(data); let mx = net_flow_window_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn net_flow_window_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = net_flow_window_mean(data); let sd = net_flow_window_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn net_flow_window_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn net_flow_window_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn net_flow_window_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn net_flow_window_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn net_flow_window_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn net_flow_window_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn net_flow_window_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn net_flow_window_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn net_flow_window_dbl(x : Double) -> String {
  let i = if x >= 0.0 { net_flow_window_int(x) } else { -net_flow_window_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { net_flow_window_int(f * 1000000.0) } else { net_flow_window_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn net_flow_window_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn net_flow_window_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct NetflowwindowFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_window_frame_make(size : Int) -> NetflowwindowFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_window_frame_len(s : NetflowwindowFrame) -> Int { s.size }

pub fn net_flow_window_frame_get(s : NetflowwindowFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_window_frame_set(s : NetflowwindowFrame, i : Int, v : Double) -> NetflowwindowFrame {
  let result = net_flow_window_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_flow_window_frame_sum(s : NetflowwindowFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_flow_window_frame_mean(s : NetflowwindowFrame) -> Double {
  if s.size == 0 { 0.0 } else { net_flow_window_frame_sum(s) / s.size.to_double() }
}

pub fn net_flow_window_frame_scale(s : NetflowwindowFrame, f : Double) -> NetflowwindowFrame {
  let result = net_flow_window_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_flow_window_frame_add(a : NetflowwindowFrame, b : NetflowwindowFrame) -> NetflowwindowFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_flow_window_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_flow_window_frame_copy(s : NetflowwindowFrame) -> NetflowwindowFrame {
  let result = net_flow_window_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_flow_window_frame_fill(s : NetflowwindowFrame, v : Double) -> NetflowwindowFrame {
  let result = net_flow_window_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_flow_window_frame_min(s : NetflowwindowFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_window_frame_max(s : NetflowwindowFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_window_frame_to_string(s : NetflowwindowFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowwindowTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_window_table_make(size : Int) -> NetflowwindowTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_window_table_len(s : NetflowwindowTable) -> Int { s.size }

pub fn net_flow_window_table_get(s : NetflowwindowTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_window_table_set(s : NetflowwindowTable, i : Int, v : Double) -> NetflowwindowTable {
  let result = net_flow_window_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_flow_window_table_sum(s : NetflowwindowTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_flow_window_table_mean(s : NetflowwindowTable) -> Double {
  if s.size == 0 { 0.0 } else { net_flow_window_table_sum(s) / s.size.to_double() }
}

pub fn net_flow_window_table_scale(s : NetflowwindowTable, f : Double) -> NetflowwindowTable {
  let result = net_flow_window_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_flow_window_table_add(a : NetflowwindowTable, b : NetflowwindowTable) -> NetflowwindowTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_flow_window_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_flow_window_table_copy(s : NetflowwindowTable) -> NetflowwindowTable {
  let result = net_flow_window_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_flow_window_table_fill(s : NetflowwindowTable, v : Double) -> NetflowwindowTable {
  let result = net_flow_window_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_flow_window_table_min(s : NetflowwindowTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_window_table_max(s : NetflowwindowTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_window_table_to_string(s : NetflowwindowTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowwindowGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_window_graphn_make(size : Int) -> NetflowwindowGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_window_graphn_len(s : NetflowwindowGraphN) -> Int { s.size }

pub fn net_flow_window_graphn_get(s : NetflowwindowGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_window_graphn_set(s : NetflowwindowGraphN, i : Int, v : Double) -> NetflowwindowGraphN {
  let result = net_flow_window_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_flow_window_graphn_sum(s : NetflowwindowGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_flow_window_graphn_mean(s : NetflowwindowGraphN) -> Double {
  if s.size == 0 { 0.0 } else { net_flow_window_graphn_sum(s) / s.size.to_double() }
}

pub fn net_flow_window_graphn_scale(s : NetflowwindowGraphN, f : Double) -> NetflowwindowGraphN {
  let result = net_flow_window_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_flow_window_graphn_add(a : NetflowwindowGraphN, b : NetflowwindowGraphN) -> NetflowwindowGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_flow_window_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_flow_window_graphn_copy(s : NetflowwindowGraphN) -> NetflowwindowGraphN {
  let result = net_flow_window_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_flow_window_graphn_fill(s : NetflowwindowGraphN, v : Double) -> NetflowwindowGraphN {
  let result = net_flow_window_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_flow_window_graphn_min(s : NetflowwindowGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_window_graphn_max(s : NetflowwindowGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_window_graphn_to_string(s : NetflowwindowGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowwindowNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_window_node_make(size : Int) -> NetflowwindowNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_window_node_len(s : NetflowwindowNode) -> Int { s.size }

pub fn net_flow_window_node_get(s : NetflowwindowNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_window_node_set(s : NetflowwindowNode, i : Int, v : Double) -> NetflowwindowNode {
  let result = net_flow_window_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_flow_window_node_sum(s : NetflowwindowNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_flow_window_node_mean(s : NetflowwindowNode) -> Double {
  if s.size == 0 { 0.0 } else { net_flow_window_node_sum(s) / s.size.to_double() }
}

pub fn net_flow_window_node_scale(s : NetflowwindowNode, f : Double) -> NetflowwindowNode {
  let result = net_flow_window_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_flow_window_node_add(a : NetflowwindowNode, b : NetflowwindowNode) -> NetflowwindowNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_flow_window_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_flow_window_node_copy(s : NetflowwindowNode) -> NetflowwindowNode {
  let result = net_flow_window_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_flow_window_node_fill(s : NetflowwindowNode, v : Double) -> NetflowwindowNode {
  let result = net_flow_window_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_flow_window_node_min(s : NetflowwindowNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_window_node_max(s : NetflowwindowNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_window_node_to_string(s : NetflowwindowNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowwindowEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_window_edge_make(size : Int) -> NetflowwindowEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_window_edge_len(s : NetflowwindowEdge) -> Int { s.size }

pub fn net_flow_window_edge_get(s : NetflowwindowEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_window_edge_set(s : NetflowwindowEdge, i : Int, v : Double) -> NetflowwindowEdge {
  let result = net_flow_window_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_flow_window_edge_sum(s : NetflowwindowEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_flow_window_edge_mean(s : NetflowwindowEdge) -> Double {
  if s.size == 0 { 0.0 } else { net_flow_window_edge_sum(s) / s.size.to_double() }
}

pub fn net_flow_window_edge_scale(s : NetflowwindowEdge, f : Double) -> NetflowwindowEdge {
  let result = net_flow_window_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_flow_window_edge_add(a : NetflowwindowEdge, b : NetflowwindowEdge) -> NetflowwindowEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_flow_window_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_flow_window_edge_copy(s : NetflowwindowEdge) -> NetflowwindowEdge {
  let result = net_flow_window_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_flow_window_edge_fill(s : NetflowwindowEdge, v : Double) -> NetflowwindowEdge {
  let result = net_flow_window_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_flow_window_edge_min(s : NetflowwindowEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_window_edge_max(s : NetflowwindowEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_window_edge_to_string(s : NetflowwindowEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowwindowPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_window_path_make(size : Int) -> NetflowwindowPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_window_path_len(s : NetflowwindowPath) -> Int { s.size }

pub fn net_flow_window_path_get(s : NetflowwindowPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_window_path_set(s : NetflowwindowPath, i : Int, v : Double) -> NetflowwindowPath {
  let result = net_flow_window_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_flow_window_path_sum(s : NetflowwindowPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_flow_window_path_mean(s : NetflowwindowPath) -> Double {
  if s.size == 0 { 0.0 } else { net_flow_window_path_sum(s) / s.size.to_double() }
}

pub fn net_flow_window_path_scale(s : NetflowwindowPath, f : Double) -> NetflowwindowPath {
  let result = net_flow_window_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_flow_window_path_add(a : NetflowwindowPath, b : NetflowwindowPath) -> NetflowwindowPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_flow_window_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_flow_window_path_copy(s : NetflowwindowPath) -> NetflowwindowPath {
  let result = net_flow_window_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_flow_window_path_fill(s : NetflowwindowPath, v : Double) -> NetflowwindowPath {
  let result = net_flow_window_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_flow_window_path_min(s : NetflowwindowPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_window_path_max(s : NetflowwindowPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_window_path_to_string(s : NetflowwindowPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowwindowCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_window_cluster_make(size : Int) -> NetflowwindowCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_window_cluster_len(s : NetflowwindowCluster) -> Int { s.size }

pub fn net_flow_window_cluster_get(s : NetflowwindowCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_window_cluster_set(s : NetflowwindowCluster, i : Int, v : Double) -> NetflowwindowCluster {
  let result = net_flow_window_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_flow_window_cluster_sum(s : NetflowwindowCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_flow_window_cluster_mean(s : NetflowwindowCluster) -> Double {
  if s.size == 0 { 0.0 } else { net_flow_window_cluster_sum(s) / s.size.to_double() }
}

pub fn net_flow_window_cluster_scale(s : NetflowwindowCluster, f : Double) -> NetflowwindowCluster {
  let result = net_flow_window_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_flow_window_cluster_add(a : NetflowwindowCluster, b : NetflowwindowCluster) -> NetflowwindowCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_flow_window_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_flow_window_cluster_copy(s : NetflowwindowCluster) -> NetflowwindowCluster {
  let result = net_flow_window_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_flow_window_cluster_fill(s : NetflowwindowCluster, v : Double) -> NetflowwindowCluster {
  let result = net_flow_window_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_flow_window_cluster_min(s : NetflowwindowCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_window_cluster_max(s : NetflowwindowCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_window_cluster_to_string(s : NetflowwindowCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowwindowModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_window_model_make(size : Int) -> NetflowwindowModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_window_model_len(s : NetflowwindowModel) -> Int { s.size }

pub fn net_flow_window_model_get(s : NetflowwindowModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_window_model_set(s : NetflowwindowModel, i : Int, v : Double) -> NetflowwindowModel {
  let result = net_flow_window_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_flow_window_model_sum(s : NetflowwindowModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_flow_window_model_mean(s : NetflowwindowModel) -> Double {
  if s.size == 0 { 0.0 } else { net_flow_window_model_sum(s) / s.size.to_double() }
}

pub fn net_flow_window_model_scale(s : NetflowwindowModel, f : Double) -> NetflowwindowModel {
  let result = net_flow_window_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_flow_window_model_add(a : NetflowwindowModel, b : NetflowwindowModel) -> NetflowwindowModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_flow_window_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_flow_window_model_copy(s : NetflowwindowModel) -> NetflowwindowModel {
  let result = net_flow_window_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_flow_window_model_fill(s : NetflowwindowModel, v : Double) -> NetflowwindowModel {
  let result = net_flow_window_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_flow_window_model_min(s : NetflowwindowModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_window_model_max(s : NetflowwindowModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_window_model_to_string(s : NetflowwindowModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowwindowLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_window_layer_make(size : Int) -> NetflowwindowLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_window_layer_len(s : NetflowwindowLayer) -> Int { s.size }

pub fn net_flow_window_layer_get(s : NetflowwindowLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_window_layer_set(s : NetflowwindowLayer, i : Int, v : Double) -> NetflowwindowLayer {
  let result = net_flow_window_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_flow_window_layer_sum(s : NetflowwindowLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_flow_window_layer_mean(s : NetflowwindowLayer) -> Double {
  if s.size == 0 { 0.0 } else { net_flow_window_layer_sum(s) / s.size.to_double() }
}

pub fn net_flow_window_layer_scale(s : NetflowwindowLayer, f : Double) -> NetflowwindowLayer {
  let result = net_flow_window_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_flow_window_layer_add(a : NetflowwindowLayer, b : NetflowwindowLayer) -> NetflowwindowLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_flow_window_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_flow_window_layer_copy(s : NetflowwindowLayer) -> NetflowwindowLayer {
  let result = net_flow_window_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_flow_window_layer_fill(s : NetflowwindowLayer, v : Double) -> NetflowwindowLayer {
  let result = net_flow_window_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_flow_window_layer_min(s : NetflowwindowLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_window_layer_max(s : NetflowwindowLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_window_layer_to_string(s : NetflowwindowLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowwindowBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_window_buffer_make(size : Int) -> NetflowwindowBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_window_buffer_len(s : NetflowwindowBuffer) -> Int { s.size }

pub fn net_flow_window_buffer_get(s : NetflowwindowBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_window_buffer_set(s : NetflowwindowBuffer, i : Int, v : Double) -> NetflowwindowBuffer {
  let result = net_flow_window_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_flow_window_buffer_sum(s : NetflowwindowBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_flow_window_buffer_mean(s : NetflowwindowBuffer) -> Double {
  if s.size == 0 { 0.0 } else { net_flow_window_buffer_sum(s) / s.size.to_double() }
}

pub fn net_flow_window_buffer_scale(s : NetflowwindowBuffer, f : Double) -> NetflowwindowBuffer {
  let result = net_flow_window_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_flow_window_buffer_add(a : NetflowwindowBuffer, b : NetflowwindowBuffer) -> NetflowwindowBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_flow_window_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_flow_window_buffer_copy(s : NetflowwindowBuffer) -> NetflowwindowBuffer {
  let result = net_flow_window_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_flow_window_buffer_fill(s : NetflowwindowBuffer, v : Double) -> NetflowwindowBuffer {
  let result = net_flow_window_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_flow_window_buffer_min(s : NetflowwindowBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_window_buffer_max(s : NetflowwindowBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_window_buffer_to_string(s : NetflowwindowBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowwindowCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_window_cursor_make(size : Int) -> NetflowwindowCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_window_cursor_len(s : NetflowwindowCursor) -> Int { s.size }

pub fn net_flow_window_cursor_get(s : NetflowwindowCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_window_cursor_set(s : NetflowwindowCursor, i : Int, v : Double) -> NetflowwindowCursor {
  let result = net_flow_window_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_flow_window_cursor_sum(s : NetflowwindowCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_flow_window_cursor_mean(s : NetflowwindowCursor) -> Double {
  if s.size == 0 { 0.0 } else { net_flow_window_cursor_sum(s) / s.size.to_double() }
}

pub fn net_flow_window_cursor_scale(s : NetflowwindowCursor, f : Double) -> NetflowwindowCursor {
  let result = net_flow_window_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_flow_window_cursor_add(a : NetflowwindowCursor, b : NetflowwindowCursor) -> NetflowwindowCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_flow_window_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_flow_window_cursor_copy(s : NetflowwindowCursor) -> NetflowwindowCursor {
  let result = net_flow_window_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_flow_window_cursor_fill(s : NetflowwindowCursor, v : Double) -> NetflowwindowCursor {
  let result = net_flow_window_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_flow_window_cursor_min(s : NetflowwindowCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_window_cursor_max(s : NetflowwindowCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_window_cursor_to_string(s : NetflowwindowCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowwindowView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_window_view_make(size : Int) -> NetflowwindowView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_window_view_len(s : NetflowwindowView) -> Int { s.size }

pub fn net_flow_window_view_get(s : NetflowwindowView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_window_view_set(s : NetflowwindowView, i : Int, v : Double) -> NetflowwindowView {
  let result = net_flow_window_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_flow_window_view_sum(s : NetflowwindowView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_flow_window_view_mean(s : NetflowwindowView) -> Double {
  if s.size == 0 { 0.0 } else { net_flow_window_view_sum(s) / s.size.to_double() }
}

pub fn net_flow_window_view_scale(s : NetflowwindowView, f : Double) -> NetflowwindowView {
  let result = net_flow_window_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_flow_window_view_add(a : NetflowwindowView, b : NetflowwindowView) -> NetflowwindowView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_flow_window_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_flow_window_view_copy(s : NetflowwindowView) -> NetflowwindowView {
  let result = net_flow_window_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_flow_window_view_fill(s : NetflowwindowView, v : Double) -> NetflowwindowView {
  let result = net_flow_window_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_flow_window_view_min(s : NetflowwindowView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_window_view_max(s : NetflowwindowView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_window_view_to_string(s : NetflowwindowView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowwindowRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_window_range_make(size : Int) -> NetflowwindowRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_window_range_len(s : NetflowwindowRange) -> Int { s.size }

pub fn net_flow_window_range_get(s : NetflowwindowRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_window_range_set(s : NetflowwindowRange, i : Int, v : Double) -> NetflowwindowRange {
  let result = net_flow_window_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_flow_window_range_sum(s : NetflowwindowRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_flow_window_range_mean(s : NetflowwindowRange) -> Double {
  if s.size == 0 { 0.0 } else { net_flow_window_range_sum(s) / s.size.to_double() }
}

pub fn net_flow_window_range_scale(s : NetflowwindowRange, f : Double) -> NetflowwindowRange {
  let result = net_flow_window_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_flow_window_range_add(a : NetflowwindowRange, b : NetflowwindowRange) -> NetflowwindowRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_flow_window_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_flow_window_range_copy(s : NetflowwindowRange) -> NetflowwindowRange {
  let result = net_flow_window_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_flow_window_range_fill(s : NetflowwindowRange, v : Double) -> NetflowwindowRange {
  let result = net_flow_window_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_flow_window_range_min(s : NetflowwindowRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_window_range_max(s : NetflowwindowRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_window_range_to_string(s : NetflowwindowRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowwindowSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_window_slice_make(size : Int) -> NetflowwindowSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_window_slice_len(s : NetflowwindowSlice) -> Int { s.size }

pub fn net_flow_window_slice_get(s : NetflowwindowSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_window_slice_set(s : NetflowwindowSlice, i : Int, v : Double) -> NetflowwindowSlice {
  let result = net_flow_window_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_flow_window_slice_sum(s : NetflowwindowSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_flow_window_slice_mean(s : NetflowwindowSlice) -> Double {
  if s.size == 0 { 0.0 } else { net_flow_window_slice_sum(s) / s.size.to_double() }
}

pub fn net_flow_window_slice_scale(s : NetflowwindowSlice, f : Double) -> NetflowwindowSlice {
  let result = net_flow_window_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_flow_window_slice_add(a : NetflowwindowSlice, b : NetflowwindowSlice) -> NetflowwindowSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_flow_window_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_flow_window_slice_copy(s : NetflowwindowSlice) -> NetflowwindowSlice {
  let result = net_flow_window_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_flow_window_slice_fill(s : NetflowwindowSlice, v : Double) -> NetflowwindowSlice {
  let result = net_flow_window_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_flow_window_slice_min(s : NetflowwindowSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_window_slice_max(s : NetflowwindowSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_window_slice_to_string(s : NetflowwindowSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn net_flow_window_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_flow_window_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_flow_window_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_flow_window_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_flow_window_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_flow_window_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_flow_window_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_flow_window_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_flow_window_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_flow_window_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_flow_window_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_flow_window_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_flow_window_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_flow_window_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_flow_window_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_flow_window_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_flow_window_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_flow_window_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_flow_window_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_flow_window_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_flow_window_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_flow_window_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_flow_window_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_flow_window_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_flow_window_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

