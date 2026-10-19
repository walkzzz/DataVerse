///===
/// extcore/opt_grad_nesterov

pub(all) struct OptgradnesterovPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn opt_grad_nesterov_make_point(x : Double, y : Double) -> OptgradnesterovPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn opt_grad_nesterov_make_point3(x : Double, y : Double, z : Double) -> OptgradnesterovPoint {
  { x, y, z, label: 0 }
}

pub fn opt_grad_nesterov_point_x(pt : OptgradnesterovPoint) -> Double { pt.x }

pub fn opt_grad_nesterov_point_y(pt : OptgradnesterovPoint) -> Double { pt.y }

pub fn opt_grad_nesterov_point_z(pt : OptgradnesterovPoint) -> Double { pt.z }

pub fn opt_grad_nesterov_point_label(pt : OptgradnesterovPoint) -> Int { pt.label }

pub fn opt_grad_nesterov_point_dist(a : OptgradnesterovPoint, b : OptgradnesterovPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  opt_grad_nesterov_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn opt_grad_nesterov_point_add(a : OptgradnesterovPoint, b : OptgradnesterovPoint) -> OptgradnesterovPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn opt_grad_nesterov_point_sub(a : OptgradnesterovPoint, b : OptgradnesterovPoint) -> OptgradnesterovPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn opt_grad_nesterov_point_scale(pt : OptgradnesterovPoint, s : Double) -> OptgradnesterovPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn opt_grad_nesterov_point_dot(a : OptgradnesterovPoint, b : OptgradnesterovPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn opt_grad_nesterov_point_cross(a : OptgradnesterovPoint, b : OptgradnesterovPoint) -> OptgradnesterovPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn opt_grad_nesterov_point_norm(pt : OptgradnesterovPoint) -> Double {
  opt_grad_nesterov_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn opt_grad_nesterov_point_normalize(pt : OptgradnesterovPoint) -> OptgradnesterovPoint {
  let n = opt_grad_nesterov_point_norm(pt)
  if n < 0.0000001 { pt } else { opt_grad_nesterov_point_scale(pt, 1.0 / n) }
}

pub fn opt_grad_nesterov_point_negate(pt : OptgradnesterovPoint) -> OptgradnesterovPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn opt_grad_nesterov_point_mid(a : OptgradnesterovPoint, b : OptgradnesterovPoint) -> OptgradnesterovPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn opt_grad_nesterov_point_lerp(a : OptgradnesterovPoint, b : OptgradnesterovPoint, t : Double) -> OptgradnesterovPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn opt_grad_nesterov_point_to_string(pt : OptgradnesterovPoint) -> String {
  "(" + opt_grad_nesterov_dbl(pt.x) + ", " + opt_grad_nesterov_dbl(pt.y) + ", " + opt_grad_nesterov_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct OptgradnesterovSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn opt_grad_nesterov_make_series(vals : Array[Double], name : String) -> OptgradnesterovSeries {
  { vals, name, meta: 0 }
}

pub fn opt_grad_nesterov_series_len(s : OptgradnesterovSeries) -> Int { s.vals.length() }

pub fn opt_grad_nesterov_series_sum(s : OptgradnesterovSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn opt_grad_nesterov_series_mean(s : OptgradnesterovSeries) -> Double {
  let n = opt_grad_nesterov_series_len(s)
  if n == 0 { 0.0 } else { opt_grad_nesterov_series_sum(s) / n.to_double() }
}

pub fn opt_grad_nesterov_series_min(s : OptgradnesterovSeries) -> Double {
  let n = opt_grad_nesterov_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn opt_grad_nesterov_series_max(s : OptgradnesterovSeries) -> Double {
  let n = opt_grad_nesterov_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn opt_grad_nesterov_series_range(s : OptgradnesterovSeries) -> Double {
  opt_grad_nesterov_series_max(s) - opt_grad_nesterov_series_min(s)
}

pub fn opt_grad_nesterov_series_var(s : OptgradnesterovSeries) -> Double {
  let n = opt_grad_nesterov_series_len(s)
  if n == 0 { 0.0 } else {
    let m = opt_grad_nesterov_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn opt_grad_nesterov_series_std(s : OptgradnesterovSeries) -> Double { opt_grad_nesterov_sqrt(opt_grad_nesterov_series_var(s)) }

pub fn opt_grad_nesterov_series_median(s : OptgradnesterovSeries) -> Double {
  let n = opt_grad_nesterov_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = opt_grad_nesterov_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn opt_grad_nesterov_series_scale(s : OptgradnesterovSeries, f : Double) -> OptgradnesterovSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = opt_grad_nesterov_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn opt_grad_nesterov_series_add(a : OptgradnesterovSeries, b : OptgradnesterovSeries) -> OptgradnesterovSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = opt_grad_nesterov_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn opt_grad_nesterov_series_sub(a : OptgradnesterovSeries, b : OptgradnesterovSeries) -> OptgradnesterovSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = opt_grad_nesterov_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn opt_grad_nesterov_series_normalize(s : OptgradnesterovSeries) -> OptgradnesterovSeries {
  let mn = opt_grad_nesterov_series_min(s)
  let mx = opt_grad_nesterov_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = opt_grad_nesterov_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn opt_grad_nesterov_series_cumsum(s : OptgradnesterovSeries) -> OptgradnesterovSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = opt_grad_nesterov_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn opt_grad_nesterov_series_to_string(s : OptgradnesterovSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + opt_grad_nesterov_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct OptgradnesterovMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn opt_grad_nesterov_make_matrix(rows : Int, cols : Int, val : Double) -> OptgradnesterovMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn opt_grad_nesterov_matrix_identity(n : Int) -> OptgradnesterovMatrix {
  let m = opt_grad_nesterov_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn opt_grad_nesterov_matrix_get(m : OptgradnesterovMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn opt_grad_nesterov_matrix_transpose(m : OptgradnesterovMatrix) -> OptgradnesterovMatrix {
  let result = opt_grad_nesterov_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn opt_grad_nesterov_matrix_add(a : OptgradnesterovMatrix, b : OptgradnesterovMatrix) -> OptgradnesterovMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = opt_grad_nesterov_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn opt_grad_nesterov_matrix_scale(m : OptgradnesterovMatrix, s : Double) -> OptgradnesterovMatrix {
  let result = opt_grad_nesterov_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn opt_grad_nesterov_matrix_multiply(a : OptgradnesterovMatrix, b : OptgradnesterovMatrix) -> OptgradnesterovMatrix {
  if a.cols != b.rows { return opt_grad_nesterov_make_matrix(a.rows, b.cols, 0.0) }
  let result = opt_grad_nesterov_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn opt_grad_nesterov_matrix_trace(m : OptgradnesterovMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn opt_grad_nesterov_matrix_det(m : OptgradnesterovMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn opt_grad_nesterov_matrix_norm(m : OptgradnesterovMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  opt_grad_nesterov_sqrt(sum)
}

pub fn opt_grad_nesterov_matrix_to_string(m : OptgradnesterovMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + opt_grad_nesterov_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct OptgradnesterovVector {
  comps : Array[Double]
  dim : Int
}

pub fn opt_grad_nesterov_make_vector(comps : Array[Double]) -> OptgradnesterovVector {
  { comps, dim: comps.length() }
}

pub fn opt_grad_nesterov_vector_zero(dim : Int) -> OptgradnesterovVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn opt_grad_nesterov_vector_add(a : OptgradnesterovVector, b : OptgradnesterovVector) -> OptgradnesterovVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = opt_grad_nesterov_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn opt_grad_nesterov_vector_sub(a : OptgradnesterovVector, b : OptgradnesterovVector) -> OptgradnesterovVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = opt_grad_nesterov_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn opt_grad_nesterov_vector_scale(v : OptgradnesterovVector, s : Double) -> OptgradnesterovVector {
  let mut result = []
  for i in 0..<v.dim { result = opt_grad_nesterov_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn opt_grad_nesterov_vector_dot(a : OptgradnesterovVector, b : OptgradnesterovVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn opt_grad_nesterov_vector_norm(v : OptgradnesterovVector) -> Double { opt_grad_nesterov_sqrt(opt_grad_nesterov_vector_dot(v, v)) }

pub fn opt_grad_nesterov_vector_normalize(v : OptgradnesterovVector) -> OptgradnesterovVector {
  let n = opt_grad_nesterov_vector_norm(v)
  if n < 0.0000001 { v } else { opt_grad_nesterov_vector_scale(v, 1.0 / n) }
}

pub fn opt_grad_nesterov_vector_dist(a : OptgradnesterovVector, b : OptgradnesterovVector) -> Double {
  opt_grad_nesterov_vector_norm(opt_grad_nesterov_vector_sub(a, b))
}

pub fn opt_grad_nesterov_vector_to_string(v : OptgradnesterovVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + opt_grad_nesterov_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn opt_grad_nesterov_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn opt_grad_nesterov_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = opt_grad_nesterov_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn opt_grad_nesterov_std(data : Array[Double]) -> Double { opt_grad_nesterov_sqrt(opt_grad_nesterov_var(data)) }

pub fn opt_grad_nesterov_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = opt_grad_nesterov_mean(a); let mb = opt_grad_nesterov_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn opt_grad_nesterov_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = opt_grad_nesterov_std(a); let sb = opt_grad_nesterov_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { opt_grad_nesterov_cov(a, b) / (sa * sb) }
}

pub fn opt_grad_nesterov_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = opt_grad_nesterov_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn opt_grad_nesterov_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn opt_grad_nesterov_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn opt_grad_nesterov_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  opt_grad_nesterov_sqrt(opt_grad_nesterov_mse(pred, labels))
}

pub fn opt_grad_nesterov_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + opt_grad_nesterov_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn opt_grad_nesterov_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = opt_grad_nesterov_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn opt_grad_nesterov_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn opt_grad_nesterov_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn opt_grad_nesterov_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = opt_grad_nesterov_precision(pred, labels, pos); let r = opt_grad_nesterov_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn opt_grad_nesterov_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn opt_grad_nesterov_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = opt_grad_nesterov_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn opt_grad_nesterov_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn opt_grad_nesterov_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn opt_grad_nesterov_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = opt_grad_nesterov_gcd(a, b)
    (a / g) * b
  }
}

pub fn opt_grad_nesterov_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn opt_grad_nesterov_fibonacci(n : Int) -> Int {
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

pub fn opt_grad_nesterov_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = opt_grad_nesterov_min(data); let mx = opt_grad_nesterov_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn opt_grad_nesterov_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = opt_grad_nesterov_mean(data); let sd = opt_grad_nesterov_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn opt_grad_nesterov_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn opt_grad_nesterov_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn opt_grad_nesterov_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn opt_grad_nesterov_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn opt_grad_nesterov_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn opt_grad_nesterov_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn opt_grad_nesterov_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn opt_grad_nesterov_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn opt_grad_nesterov_dbl(x : Double) -> String {
  let i = if x >= 0.0 { opt_grad_nesterov_int(x) } else { -opt_grad_nesterov_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { opt_grad_nesterov_int(f * 1000000.0) } else { opt_grad_nesterov_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn opt_grad_nesterov_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn opt_grad_nesterov_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct OptgradnesterovFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_nesterov_frame_make(size : Int) -> OptgradnesterovFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_nesterov_frame_len(s : OptgradnesterovFrame) -> Int { s.size }

pub fn opt_grad_nesterov_frame_get(s : OptgradnesterovFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_nesterov_frame_set(s : OptgradnesterovFrame, i : Int, v : Double) -> OptgradnesterovFrame {
  let result = opt_grad_nesterov_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_grad_nesterov_frame_sum(s : OptgradnesterovFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_grad_nesterov_frame_mean(s : OptgradnesterovFrame) -> Double {
  if s.size == 0 { 0.0 } else { opt_grad_nesterov_frame_sum(s) / s.size.to_double() }
}

pub fn opt_grad_nesterov_frame_scale(s : OptgradnesterovFrame, f : Double) -> OptgradnesterovFrame {
  let result = opt_grad_nesterov_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_grad_nesterov_frame_add(a : OptgradnesterovFrame, b : OptgradnesterovFrame) -> OptgradnesterovFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_grad_nesterov_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_grad_nesterov_frame_copy(s : OptgradnesterovFrame) -> OptgradnesterovFrame {
  let result = opt_grad_nesterov_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_grad_nesterov_frame_fill(s : OptgradnesterovFrame, v : Double) -> OptgradnesterovFrame {
  let result = opt_grad_nesterov_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_grad_nesterov_frame_min(s : OptgradnesterovFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_nesterov_frame_max(s : OptgradnesterovFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_nesterov_frame_to_string(s : OptgradnesterovFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradnesterovTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_nesterov_table_make(size : Int) -> OptgradnesterovTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_nesterov_table_len(s : OptgradnesterovTable) -> Int { s.size }

pub fn opt_grad_nesterov_table_get(s : OptgradnesterovTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_nesterov_table_set(s : OptgradnesterovTable, i : Int, v : Double) -> OptgradnesterovTable {
  let result = opt_grad_nesterov_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_grad_nesterov_table_sum(s : OptgradnesterovTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_grad_nesterov_table_mean(s : OptgradnesterovTable) -> Double {
  if s.size == 0 { 0.0 } else { opt_grad_nesterov_table_sum(s) / s.size.to_double() }
}

pub fn opt_grad_nesterov_table_scale(s : OptgradnesterovTable, f : Double) -> OptgradnesterovTable {
  let result = opt_grad_nesterov_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_grad_nesterov_table_add(a : OptgradnesterovTable, b : OptgradnesterovTable) -> OptgradnesterovTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_grad_nesterov_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_grad_nesterov_table_copy(s : OptgradnesterovTable) -> OptgradnesterovTable {
  let result = opt_grad_nesterov_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_grad_nesterov_table_fill(s : OptgradnesterovTable, v : Double) -> OptgradnesterovTable {
  let result = opt_grad_nesterov_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_grad_nesterov_table_min(s : OptgradnesterovTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_nesterov_table_max(s : OptgradnesterovTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_nesterov_table_to_string(s : OptgradnesterovTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradnesterovGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_nesterov_graphn_make(size : Int) -> OptgradnesterovGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_nesterov_graphn_len(s : OptgradnesterovGraphN) -> Int { s.size }

pub fn opt_grad_nesterov_graphn_get(s : OptgradnesterovGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_nesterov_graphn_set(s : OptgradnesterovGraphN, i : Int, v : Double) -> OptgradnesterovGraphN {
  let result = opt_grad_nesterov_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_grad_nesterov_graphn_sum(s : OptgradnesterovGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_grad_nesterov_graphn_mean(s : OptgradnesterovGraphN) -> Double {
  if s.size == 0 { 0.0 } else { opt_grad_nesterov_graphn_sum(s) / s.size.to_double() }
}

pub fn opt_grad_nesterov_graphn_scale(s : OptgradnesterovGraphN, f : Double) -> OptgradnesterovGraphN {
  let result = opt_grad_nesterov_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_grad_nesterov_graphn_add(a : OptgradnesterovGraphN, b : OptgradnesterovGraphN) -> OptgradnesterovGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_grad_nesterov_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_grad_nesterov_graphn_copy(s : OptgradnesterovGraphN) -> OptgradnesterovGraphN {
  let result = opt_grad_nesterov_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_grad_nesterov_graphn_fill(s : OptgradnesterovGraphN, v : Double) -> OptgradnesterovGraphN {
  let result = opt_grad_nesterov_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_grad_nesterov_graphn_min(s : OptgradnesterovGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_nesterov_graphn_max(s : OptgradnesterovGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_nesterov_graphn_to_string(s : OptgradnesterovGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradnesterovNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_nesterov_node_make(size : Int) -> OptgradnesterovNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_nesterov_node_len(s : OptgradnesterovNode) -> Int { s.size }

pub fn opt_grad_nesterov_node_get(s : OptgradnesterovNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_nesterov_node_set(s : OptgradnesterovNode, i : Int, v : Double) -> OptgradnesterovNode {
  let result = opt_grad_nesterov_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_grad_nesterov_node_sum(s : OptgradnesterovNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_grad_nesterov_node_mean(s : OptgradnesterovNode) -> Double {
  if s.size == 0 { 0.0 } else { opt_grad_nesterov_node_sum(s) / s.size.to_double() }
}

pub fn opt_grad_nesterov_node_scale(s : OptgradnesterovNode, f : Double) -> OptgradnesterovNode {
  let result = opt_grad_nesterov_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_grad_nesterov_node_add(a : OptgradnesterovNode, b : OptgradnesterovNode) -> OptgradnesterovNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_grad_nesterov_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_grad_nesterov_node_copy(s : OptgradnesterovNode) -> OptgradnesterovNode {
  let result = opt_grad_nesterov_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_grad_nesterov_node_fill(s : OptgradnesterovNode, v : Double) -> OptgradnesterovNode {
  let result = opt_grad_nesterov_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_grad_nesterov_node_min(s : OptgradnesterovNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_nesterov_node_max(s : OptgradnesterovNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_nesterov_node_to_string(s : OptgradnesterovNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradnesterovEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_nesterov_edge_make(size : Int) -> OptgradnesterovEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_nesterov_edge_len(s : OptgradnesterovEdge) -> Int { s.size }

pub fn opt_grad_nesterov_edge_get(s : OptgradnesterovEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_nesterov_edge_set(s : OptgradnesterovEdge, i : Int, v : Double) -> OptgradnesterovEdge {
  let result = opt_grad_nesterov_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_grad_nesterov_edge_sum(s : OptgradnesterovEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_grad_nesterov_edge_mean(s : OptgradnesterovEdge) -> Double {
  if s.size == 0 { 0.0 } else { opt_grad_nesterov_edge_sum(s) / s.size.to_double() }
}

pub fn opt_grad_nesterov_edge_scale(s : OptgradnesterovEdge, f : Double) -> OptgradnesterovEdge {
  let result = opt_grad_nesterov_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_grad_nesterov_edge_add(a : OptgradnesterovEdge, b : OptgradnesterovEdge) -> OptgradnesterovEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_grad_nesterov_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_grad_nesterov_edge_copy(s : OptgradnesterovEdge) -> OptgradnesterovEdge {
  let result = opt_grad_nesterov_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_grad_nesterov_edge_fill(s : OptgradnesterovEdge, v : Double) -> OptgradnesterovEdge {
  let result = opt_grad_nesterov_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_grad_nesterov_edge_min(s : OptgradnesterovEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_nesterov_edge_max(s : OptgradnesterovEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_nesterov_edge_to_string(s : OptgradnesterovEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradnesterovPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_nesterov_path_make(size : Int) -> OptgradnesterovPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_nesterov_path_len(s : OptgradnesterovPath) -> Int { s.size }

pub fn opt_grad_nesterov_path_get(s : OptgradnesterovPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_nesterov_path_set(s : OptgradnesterovPath, i : Int, v : Double) -> OptgradnesterovPath {
  let result = opt_grad_nesterov_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_grad_nesterov_path_sum(s : OptgradnesterovPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_grad_nesterov_path_mean(s : OptgradnesterovPath) -> Double {
  if s.size == 0 { 0.0 } else { opt_grad_nesterov_path_sum(s) / s.size.to_double() }
}

pub fn opt_grad_nesterov_path_scale(s : OptgradnesterovPath, f : Double) -> OptgradnesterovPath {
  let result = opt_grad_nesterov_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_grad_nesterov_path_add(a : OptgradnesterovPath, b : OptgradnesterovPath) -> OptgradnesterovPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_grad_nesterov_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_grad_nesterov_path_copy(s : OptgradnesterovPath) -> OptgradnesterovPath {
  let result = opt_grad_nesterov_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_grad_nesterov_path_fill(s : OptgradnesterovPath, v : Double) -> OptgradnesterovPath {
  let result = opt_grad_nesterov_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_grad_nesterov_path_min(s : OptgradnesterovPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_nesterov_path_max(s : OptgradnesterovPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_nesterov_path_to_string(s : OptgradnesterovPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradnesterovCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_nesterov_cluster_make(size : Int) -> OptgradnesterovCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_nesterov_cluster_len(s : OptgradnesterovCluster) -> Int { s.size }

pub fn opt_grad_nesterov_cluster_get(s : OptgradnesterovCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_nesterov_cluster_set(s : OptgradnesterovCluster, i : Int, v : Double) -> OptgradnesterovCluster {
  let result = opt_grad_nesterov_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_grad_nesterov_cluster_sum(s : OptgradnesterovCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_grad_nesterov_cluster_mean(s : OptgradnesterovCluster) -> Double {
  if s.size == 0 { 0.0 } else { opt_grad_nesterov_cluster_sum(s) / s.size.to_double() }
}

pub fn opt_grad_nesterov_cluster_scale(s : OptgradnesterovCluster, f : Double) -> OptgradnesterovCluster {
  let result = opt_grad_nesterov_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_grad_nesterov_cluster_add(a : OptgradnesterovCluster, b : OptgradnesterovCluster) -> OptgradnesterovCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_grad_nesterov_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_grad_nesterov_cluster_copy(s : OptgradnesterovCluster) -> OptgradnesterovCluster {
  let result = opt_grad_nesterov_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_grad_nesterov_cluster_fill(s : OptgradnesterovCluster, v : Double) -> OptgradnesterovCluster {
  let result = opt_grad_nesterov_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_grad_nesterov_cluster_min(s : OptgradnesterovCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_nesterov_cluster_max(s : OptgradnesterovCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_nesterov_cluster_to_string(s : OptgradnesterovCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradnesterovModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_nesterov_model_make(size : Int) -> OptgradnesterovModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_nesterov_model_len(s : OptgradnesterovModel) -> Int { s.size }

pub fn opt_grad_nesterov_model_get(s : OptgradnesterovModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_nesterov_model_set(s : OptgradnesterovModel, i : Int, v : Double) -> OptgradnesterovModel {
  let result = opt_grad_nesterov_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_grad_nesterov_model_sum(s : OptgradnesterovModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_grad_nesterov_model_mean(s : OptgradnesterovModel) -> Double {
  if s.size == 0 { 0.0 } else { opt_grad_nesterov_model_sum(s) / s.size.to_double() }
}

pub fn opt_grad_nesterov_model_scale(s : OptgradnesterovModel, f : Double) -> OptgradnesterovModel {
  let result = opt_grad_nesterov_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_grad_nesterov_model_add(a : OptgradnesterovModel, b : OptgradnesterovModel) -> OptgradnesterovModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_grad_nesterov_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_grad_nesterov_model_copy(s : OptgradnesterovModel) -> OptgradnesterovModel {
  let result = opt_grad_nesterov_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_grad_nesterov_model_fill(s : OptgradnesterovModel, v : Double) -> OptgradnesterovModel {
  let result = opt_grad_nesterov_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_grad_nesterov_model_min(s : OptgradnesterovModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_nesterov_model_max(s : OptgradnesterovModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_nesterov_model_to_string(s : OptgradnesterovModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradnesterovLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_nesterov_layer_make(size : Int) -> OptgradnesterovLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_nesterov_layer_len(s : OptgradnesterovLayer) -> Int { s.size }

pub fn opt_grad_nesterov_layer_get(s : OptgradnesterovLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_nesterov_layer_set(s : OptgradnesterovLayer, i : Int, v : Double) -> OptgradnesterovLayer {
  let result = opt_grad_nesterov_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_grad_nesterov_layer_sum(s : OptgradnesterovLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_grad_nesterov_layer_mean(s : OptgradnesterovLayer) -> Double {
  if s.size == 0 { 0.0 } else { opt_grad_nesterov_layer_sum(s) / s.size.to_double() }
}

pub fn opt_grad_nesterov_layer_scale(s : OptgradnesterovLayer, f : Double) -> OptgradnesterovLayer {
  let result = opt_grad_nesterov_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_grad_nesterov_layer_add(a : OptgradnesterovLayer, b : OptgradnesterovLayer) -> OptgradnesterovLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_grad_nesterov_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_grad_nesterov_layer_copy(s : OptgradnesterovLayer) -> OptgradnesterovLayer {
  let result = opt_grad_nesterov_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_grad_nesterov_layer_fill(s : OptgradnesterovLayer, v : Double) -> OptgradnesterovLayer {
  let result = opt_grad_nesterov_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_grad_nesterov_layer_min(s : OptgradnesterovLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_nesterov_layer_max(s : OptgradnesterovLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_nesterov_layer_to_string(s : OptgradnesterovLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradnesterovBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_nesterov_buffer_make(size : Int) -> OptgradnesterovBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_nesterov_buffer_len(s : OptgradnesterovBuffer) -> Int { s.size }

pub fn opt_grad_nesterov_buffer_get(s : OptgradnesterovBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_nesterov_buffer_set(s : OptgradnesterovBuffer, i : Int, v : Double) -> OptgradnesterovBuffer {
  let result = opt_grad_nesterov_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_grad_nesterov_buffer_sum(s : OptgradnesterovBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_grad_nesterov_buffer_mean(s : OptgradnesterovBuffer) -> Double {
  if s.size == 0 { 0.0 } else { opt_grad_nesterov_buffer_sum(s) / s.size.to_double() }
}

pub fn opt_grad_nesterov_buffer_scale(s : OptgradnesterovBuffer, f : Double) -> OptgradnesterovBuffer {
  let result = opt_grad_nesterov_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_grad_nesterov_buffer_add(a : OptgradnesterovBuffer, b : OptgradnesterovBuffer) -> OptgradnesterovBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_grad_nesterov_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_grad_nesterov_buffer_copy(s : OptgradnesterovBuffer) -> OptgradnesterovBuffer {
  let result = opt_grad_nesterov_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_grad_nesterov_buffer_fill(s : OptgradnesterovBuffer, v : Double) -> OptgradnesterovBuffer {
  let result = opt_grad_nesterov_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_grad_nesterov_buffer_min(s : OptgradnesterovBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_nesterov_buffer_max(s : OptgradnesterovBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_nesterov_buffer_to_string(s : OptgradnesterovBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradnesterovCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_nesterov_cursor_make(size : Int) -> OptgradnesterovCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_nesterov_cursor_len(s : OptgradnesterovCursor) -> Int { s.size }

pub fn opt_grad_nesterov_cursor_get(s : OptgradnesterovCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_nesterov_cursor_set(s : OptgradnesterovCursor, i : Int, v : Double) -> OptgradnesterovCursor {
  let result = opt_grad_nesterov_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_grad_nesterov_cursor_sum(s : OptgradnesterovCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_grad_nesterov_cursor_mean(s : OptgradnesterovCursor) -> Double {
  if s.size == 0 { 0.0 } else { opt_grad_nesterov_cursor_sum(s) / s.size.to_double() }
}

pub fn opt_grad_nesterov_cursor_scale(s : OptgradnesterovCursor, f : Double) -> OptgradnesterovCursor {
  let result = opt_grad_nesterov_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_grad_nesterov_cursor_add(a : OptgradnesterovCursor, b : OptgradnesterovCursor) -> OptgradnesterovCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_grad_nesterov_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_grad_nesterov_cursor_copy(s : OptgradnesterovCursor) -> OptgradnesterovCursor {
  let result = opt_grad_nesterov_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_grad_nesterov_cursor_fill(s : OptgradnesterovCursor, v : Double) -> OptgradnesterovCursor {
  let result = opt_grad_nesterov_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_grad_nesterov_cursor_min(s : OptgradnesterovCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_nesterov_cursor_max(s : OptgradnesterovCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_nesterov_cursor_to_string(s : OptgradnesterovCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradnesterovView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_nesterov_view_make(size : Int) -> OptgradnesterovView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_nesterov_view_len(s : OptgradnesterovView) -> Int { s.size }

pub fn opt_grad_nesterov_view_get(s : OptgradnesterovView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_nesterov_view_set(s : OptgradnesterovView, i : Int, v : Double) -> OptgradnesterovView {
  let result = opt_grad_nesterov_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_grad_nesterov_view_sum(s : OptgradnesterovView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_grad_nesterov_view_mean(s : OptgradnesterovView) -> Double {
  if s.size == 0 { 0.0 } else { opt_grad_nesterov_view_sum(s) / s.size.to_double() }
}

pub fn opt_grad_nesterov_view_scale(s : OptgradnesterovView, f : Double) -> OptgradnesterovView {
  let result = opt_grad_nesterov_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_grad_nesterov_view_add(a : OptgradnesterovView, b : OptgradnesterovView) -> OptgradnesterovView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_grad_nesterov_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_grad_nesterov_view_copy(s : OptgradnesterovView) -> OptgradnesterovView {
  let result = opt_grad_nesterov_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_grad_nesterov_view_fill(s : OptgradnesterovView, v : Double) -> OptgradnesterovView {
  let result = opt_grad_nesterov_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_grad_nesterov_view_min(s : OptgradnesterovView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_nesterov_view_max(s : OptgradnesterovView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_nesterov_view_to_string(s : OptgradnesterovView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradnesterovRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_nesterov_range_make(size : Int) -> OptgradnesterovRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_nesterov_range_len(s : OptgradnesterovRange) -> Int { s.size }

pub fn opt_grad_nesterov_range_get(s : OptgradnesterovRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_nesterov_range_set(s : OptgradnesterovRange, i : Int, v : Double) -> OptgradnesterovRange {
  let result = opt_grad_nesterov_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_grad_nesterov_range_sum(s : OptgradnesterovRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_grad_nesterov_range_mean(s : OptgradnesterovRange) -> Double {
  if s.size == 0 { 0.0 } else { opt_grad_nesterov_range_sum(s) / s.size.to_double() }
}

pub fn opt_grad_nesterov_range_scale(s : OptgradnesterovRange, f : Double) -> OptgradnesterovRange {
  let result = opt_grad_nesterov_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_grad_nesterov_range_add(a : OptgradnesterovRange, b : OptgradnesterovRange) -> OptgradnesterovRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_grad_nesterov_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_grad_nesterov_range_copy(s : OptgradnesterovRange) -> OptgradnesterovRange {
  let result = opt_grad_nesterov_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_grad_nesterov_range_fill(s : OptgradnesterovRange, v : Double) -> OptgradnesterovRange {
  let result = opt_grad_nesterov_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_grad_nesterov_range_min(s : OptgradnesterovRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_nesterov_range_max(s : OptgradnesterovRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_nesterov_range_to_string(s : OptgradnesterovRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradnesterovSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_nesterov_slice_make(size : Int) -> OptgradnesterovSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_nesterov_slice_len(s : OptgradnesterovSlice) -> Int { s.size }

pub fn opt_grad_nesterov_slice_get(s : OptgradnesterovSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_nesterov_slice_set(s : OptgradnesterovSlice, i : Int, v : Double) -> OptgradnesterovSlice {
  let result = opt_grad_nesterov_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_grad_nesterov_slice_sum(s : OptgradnesterovSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_grad_nesterov_slice_mean(s : OptgradnesterovSlice) -> Double {
  if s.size == 0 { 0.0 } else { opt_grad_nesterov_slice_sum(s) / s.size.to_double() }
}

pub fn opt_grad_nesterov_slice_scale(s : OptgradnesterovSlice, f : Double) -> OptgradnesterovSlice {
  let result = opt_grad_nesterov_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_grad_nesterov_slice_add(a : OptgradnesterovSlice, b : OptgradnesterovSlice) -> OptgradnesterovSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_grad_nesterov_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_grad_nesterov_slice_copy(s : OptgradnesterovSlice) -> OptgradnesterovSlice {
  let result = opt_grad_nesterov_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_grad_nesterov_slice_fill(s : OptgradnesterovSlice, v : Double) -> OptgradnesterovSlice {
  let result = opt_grad_nesterov_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_grad_nesterov_slice_min(s : OptgradnesterovSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_nesterov_slice_max(s : OptgradnesterovSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_nesterov_slice_to_string(s : OptgradnesterovSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn opt_grad_nesterov_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_grad_nesterov_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_grad_nesterov_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_grad_nesterov_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_grad_nesterov_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_grad_nesterov_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_grad_nesterov_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_grad_nesterov_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_grad_nesterov_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_grad_nesterov_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_grad_nesterov_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_grad_nesterov_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_grad_nesterov_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_grad_nesterov_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_grad_nesterov_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_grad_nesterov_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_grad_nesterov_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_grad_nesterov_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_grad_nesterov_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_grad_nesterov_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_grad_nesterov_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_grad_nesterov_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_grad_nesterov_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_grad_nesterov_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_grad_nesterov_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

