///===
/// extcore/opt_grad_amsgrad

pub(all) struct OptgradamsgradPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn opt_grad_amsgrad_make_point(x : Double, y : Double) -> OptgradamsgradPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn opt_grad_amsgrad_make_point3(x : Double, y : Double, z : Double) -> OptgradamsgradPoint {
  { x, y, z, label: 0 }
}

pub fn opt_grad_amsgrad_point_x(pt : OptgradamsgradPoint) -> Double { pt.x }

pub fn opt_grad_amsgrad_point_y(pt : OptgradamsgradPoint) -> Double { pt.y }

pub fn opt_grad_amsgrad_point_z(pt : OptgradamsgradPoint) -> Double { pt.z }

pub fn opt_grad_amsgrad_point_label(pt : OptgradamsgradPoint) -> Int { pt.label }

pub fn opt_grad_amsgrad_point_dist(a : OptgradamsgradPoint, b : OptgradamsgradPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  opt_grad_amsgrad_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn opt_grad_amsgrad_point_add(a : OptgradamsgradPoint, b : OptgradamsgradPoint) -> OptgradamsgradPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn opt_grad_amsgrad_point_sub(a : OptgradamsgradPoint, b : OptgradamsgradPoint) -> OptgradamsgradPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn opt_grad_amsgrad_point_scale(pt : OptgradamsgradPoint, s : Double) -> OptgradamsgradPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn opt_grad_amsgrad_point_dot(a : OptgradamsgradPoint, b : OptgradamsgradPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn opt_grad_amsgrad_point_cross(a : OptgradamsgradPoint, b : OptgradamsgradPoint) -> OptgradamsgradPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn opt_grad_amsgrad_point_norm(pt : OptgradamsgradPoint) -> Double {
  opt_grad_amsgrad_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn opt_grad_amsgrad_point_normalize(pt : OptgradamsgradPoint) -> OptgradamsgradPoint {
  let n = opt_grad_amsgrad_point_norm(pt)
  if n < 0.0000001 { pt } else { opt_grad_amsgrad_point_scale(pt, 1.0 / n) }
}

pub fn opt_grad_amsgrad_point_negate(pt : OptgradamsgradPoint) -> OptgradamsgradPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn opt_grad_amsgrad_point_mid(a : OptgradamsgradPoint, b : OptgradamsgradPoint) -> OptgradamsgradPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn opt_grad_amsgrad_point_lerp(a : OptgradamsgradPoint, b : OptgradamsgradPoint, t : Double) -> OptgradamsgradPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn opt_grad_amsgrad_point_to_string(pt : OptgradamsgradPoint) -> String {
  "(" + opt_grad_amsgrad_dbl(pt.x) + ", " + opt_grad_amsgrad_dbl(pt.y) + ", " + opt_grad_amsgrad_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct OptgradamsgradSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn opt_grad_amsgrad_make_series(vals : Array[Double], name : String) -> OptgradamsgradSeries {
  { vals, name, meta: 0 }
}

pub fn opt_grad_amsgrad_series_len(s : OptgradamsgradSeries) -> Int { s.vals.length() }

pub fn opt_grad_amsgrad_series_sum(s : OptgradamsgradSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn opt_grad_amsgrad_series_mean(s : OptgradamsgradSeries) -> Double {
  let n = opt_grad_amsgrad_series_len(s)
  if n == 0 { 0.0 } else { opt_grad_amsgrad_series_sum(s) / n.to_double() }
}

pub fn opt_grad_amsgrad_series_min(s : OptgradamsgradSeries) -> Double {
  let n = opt_grad_amsgrad_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn opt_grad_amsgrad_series_max(s : OptgradamsgradSeries) -> Double {
  let n = opt_grad_amsgrad_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn opt_grad_amsgrad_series_range(s : OptgradamsgradSeries) -> Double {
  opt_grad_amsgrad_series_max(s) - opt_grad_amsgrad_series_min(s)
}

pub fn opt_grad_amsgrad_series_var(s : OptgradamsgradSeries) -> Double {
  let n = opt_grad_amsgrad_series_len(s)
  if n == 0 { 0.0 } else {
    let m = opt_grad_amsgrad_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn opt_grad_amsgrad_series_std(s : OptgradamsgradSeries) -> Double { opt_grad_amsgrad_sqrt(opt_grad_amsgrad_series_var(s)) }

pub fn opt_grad_amsgrad_series_median(s : OptgradamsgradSeries) -> Double {
  let n = opt_grad_amsgrad_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = opt_grad_amsgrad_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn opt_grad_amsgrad_series_scale(s : OptgradamsgradSeries, f : Double) -> OptgradamsgradSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = opt_grad_amsgrad_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn opt_grad_amsgrad_series_add(a : OptgradamsgradSeries, b : OptgradamsgradSeries) -> OptgradamsgradSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = opt_grad_amsgrad_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn opt_grad_amsgrad_series_sub(a : OptgradamsgradSeries, b : OptgradamsgradSeries) -> OptgradamsgradSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = opt_grad_amsgrad_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn opt_grad_amsgrad_series_normalize(s : OptgradamsgradSeries) -> OptgradamsgradSeries {
  let mn = opt_grad_amsgrad_series_min(s)
  let mx = opt_grad_amsgrad_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = opt_grad_amsgrad_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn opt_grad_amsgrad_series_cumsum(s : OptgradamsgradSeries) -> OptgradamsgradSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = opt_grad_amsgrad_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn opt_grad_amsgrad_series_to_string(s : OptgradamsgradSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + opt_grad_amsgrad_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct OptgradamsgradMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn opt_grad_amsgrad_make_matrix(rows : Int, cols : Int, val : Double) -> OptgradamsgradMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn opt_grad_amsgrad_matrix_identity(n : Int) -> OptgradamsgradMatrix {
  let m = opt_grad_amsgrad_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn opt_grad_amsgrad_matrix_get(m : OptgradamsgradMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn opt_grad_amsgrad_matrix_transpose(m : OptgradamsgradMatrix) -> OptgradamsgradMatrix {
  let result = opt_grad_amsgrad_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn opt_grad_amsgrad_matrix_add(a : OptgradamsgradMatrix, b : OptgradamsgradMatrix) -> OptgradamsgradMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = opt_grad_amsgrad_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn opt_grad_amsgrad_matrix_scale(m : OptgradamsgradMatrix, s : Double) -> OptgradamsgradMatrix {
  let result = opt_grad_amsgrad_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn opt_grad_amsgrad_matrix_multiply(a : OptgradamsgradMatrix, b : OptgradamsgradMatrix) -> OptgradamsgradMatrix {
  if a.cols != b.rows { return opt_grad_amsgrad_make_matrix(a.rows, b.cols, 0.0) }
  let result = opt_grad_amsgrad_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn opt_grad_amsgrad_matrix_trace(m : OptgradamsgradMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn opt_grad_amsgrad_matrix_det(m : OptgradamsgradMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn opt_grad_amsgrad_matrix_norm(m : OptgradamsgradMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  opt_grad_amsgrad_sqrt(sum)
}

pub fn opt_grad_amsgrad_matrix_to_string(m : OptgradamsgradMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + opt_grad_amsgrad_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct OptgradamsgradVector {
  comps : Array[Double]
  dim : Int
}

pub fn opt_grad_amsgrad_make_vector(comps : Array[Double]) -> OptgradamsgradVector {
  { comps, dim: comps.length() }
}

pub fn opt_grad_amsgrad_vector_zero(dim : Int) -> OptgradamsgradVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn opt_grad_amsgrad_vector_add(a : OptgradamsgradVector, b : OptgradamsgradVector) -> OptgradamsgradVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = opt_grad_amsgrad_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn opt_grad_amsgrad_vector_sub(a : OptgradamsgradVector, b : OptgradamsgradVector) -> OptgradamsgradVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = opt_grad_amsgrad_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn opt_grad_amsgrad_vector_scale(v : OptgradamsgradVector, s : Double) -> OptgradamsgradVector {
  let mut result = []
  for i in 0..<v.dim { result = opt_grad_amsgrad_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn opt_grad_amsgrad_vector_dot(a : OptgradamsgradVector, b : OptgradamsgradVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn opt_grad_amsgrad_vector_norm(v : OptgradamsgradVector) -> Double { opt_grad_amsgrad_sqrt(opt_grad_amsgrad_vector_dot(v, v)) }

pub fn opt_grad_amsgrad_vector_normalize(v : OptgradamsgradVector) -> OptgradamsgradVector {
  let n = opt_grad_amsgrad_vector_norm(v)
  if n < 0.0000001 { v } else { opt_grad_amsgrad_vector_scale(v, 1.0 / n) }
}

pub fn opt_grad_amsgrad_vector_dist(a : OptgradamsgradVector, b : OptgradamsgradVector) -> Double {
  opt_grad_amsgrad_vector_norm(opt_grad_amsgrad_vector_sub(a, b))
}

pub fn opt_grad_amsgrad_vector_to_string(v : OptgradamsgradVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + opt_grad_amsgrad_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn opt_grad_amsgrad_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn opt_grad_amsgrad_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = opt_grad_amsgrad_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn opt_grad_amsgrad_std(data : Array[Double]) -> Double { opt_grad_amsgrad_sqrt(opt_grad_amsgrad_var(data)) }

pub fn opt_grad_amsgrad_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = opt_grad_amsgrad_mean(a); let mb = opt_grad_amsgrad_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn opt_grad_amsgrad_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = opt_grad_amsgrad_std(a); let sb = opt_grad_amsgrad_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { opt_grad_amsgrad_cov(a, b) / (sa * sb) }
}

pub fn opt_grad_amsgrad_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = opt_grad_amsgrad_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn opt_grad_amsgrad_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn opt_grad_amsgrad_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn opt_grad_amsgrad_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  opt_grad_amsgrad_sqrt(opt_grad_amsgrad_mse(pred, labels))
}

pub fn opt_grad_amsgrad_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + opt_grad_amsgrad_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn opt_grad_amsgrad_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = opt_grad_amsgrad_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn opt_grad_amsgrad_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn opt_grad_amsgrad_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn opt_grad_amsgrad_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = opt_grad_amsgrad_precision(pred, labels, pos); let r = opt_grad_amsgrad_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn opt_grad_amsgrad_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn opt_grad_amsgrad_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = opt_grad_amsgrad_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn opt_grad_amsgrad_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn opt_grad_amsgrad_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn opt_grad_amsgrad_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = opt_grad_amsgrad_gcd(a, b)
    (a / g) * b
  }
}

pub fn opt_grad_amsgrad_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn opt_grad_amsgrad_fibonacci(n : Int) -> Int {
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

pub fn opt_grad_amsgrad_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = opt_grad_amsgrad_min(data); let mx = opt_grad_amsgrad_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn opt_grad_amsgrad_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = opt_grad_amsgrad_mean(data); let sd = opt_grad_amsgrad_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn opt_grad_amsgrad_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn opt_grad_amsgrad_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn opt_grad_amsgrad_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn opt_grad_amsgrad_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn opt_grad_amsgrad_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn opt_grad_amsgrad_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn opt_grad_amsgrad_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn opt_grad_amsgrad_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn opt_grad_amsgrad_dbl(x : Double) -> String {
  let i = if x >= 0.0 { opt_grad_amsgrad_int(x) } else { -opt_grad_amsgrad_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { opt_grad_amsgrad_int(f * 1000000.0) } else { opt_grad_amsgrad_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn opt_grad_amsgrad_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn opt_grad_amsgrad_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct OptgradamsgradFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_amsgrad_frame_make(size : Int) -> OptgradamsgradFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_amsgrad_frame_len(s : OptgradamsgradFrame) -> Int { s.size }

pub fn opt_grad_amsgrad_frame_get(s : OptgradamsgradFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_amsgrad_frame_set(s : OptgradamsgradFrame, i : Int, v : Double) -> OptgradamsgradFrame {
  let result = opt_grad_amsgrad_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_grad_amsgrad_frame_sum(s : OptgradamsgradFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_grad_amsgrad_frame_mean(s : OptgradamsgradFrame) -> Double {
  if s.size == 0 { 0.0 } else { opt_grad_amsgrad_frame_sum(s) / s.size.to_double() }
}

pub fn opt_grad_amsgrad_frame_scale(s : OptgradamsgradFrame, f : Double) -> OptgradamsgradFrame {
  let result = opt_grad_amsgrad_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_grad_amsgrad_frame_add(a : OptgradamsgradFrame, b : OptgradamsgradFrame) -> OptgradamsgradFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_grad_amsgrad_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_grad_amsgrad_frame_copy(s : OptgradamsgradFrame) -> OptgradamsgradFrame {
  let result = opt_grad_amsgrad_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_grad_amsgrad_frame_fill(s : OptgradamsgradFrame, v : Double) -> OptgradamsgradFrame {
  let result = opt_grad_amsgrad_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_grad_amsgrad_frame_min(s : OptgradamsgradFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_amsgrad_frame_max(s : OptgradamsgradFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_amsgrad_frame_to_string(s : OptgradamsgradFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradamsgradTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_amsgrad_table_make(size : Int) -> OptgradamsgradTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_amsgrad_table_len(s : OptgradamsgradTable) -> Int { s.size }

pub fn opt_grad_amsgrad_table_get(s : OptgradamsgradTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_amsgrad_table_set(s : OptgradamsgradTable, i : Int, v : Double) -> OptgradamsgradTable {
  let result = opt_grad_amsgrad_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_grad_amsgrad_table_sum(s : OptgradamsgradTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_grad_amsgrad_table_mean(s : OptgradamsgradTable) -> Double {
  if s.size == 0 { 0.0 } else { opt_grad_amsgrad_table_sum(s) / s.size.to_double() }
}

pub fn opt_grad_amsgrad_table_scale(s : OptgradamsgradTable, f : Double) -> OptgradamsgradTable {
  let result = opt_grad_amsgrad_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_grad_amsgrad_table_add(a : OptgradamsgradTable, b : OptgradamsgradTable) -> OptgradamsgradTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_grad_amsgrad_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_grad_amsgrad_table_copy(s : OptgradamsgradTable) -> OptgradamsgradTable {
  let result = opt_grad_amsgrad_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_grad_amsgrad_table_fill(s : OptgradamsgradTable, v : Double) -> OptgradamsgradTable {
  let result = opt_grad_amsgrad_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_grad_amsgrad_table_min(s : OptgradamsgradTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_amsgrad_table_max(s : OptgradamsgradTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_amsgrad_table_to_string(s : OptgradamsgradTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradamsgradGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_amsgrad_graphn_make(size : Int) -> OptgradamsgradGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_amsgrad_graphn_len(s : OptgradamsgradGraphN) -> Int { s.size }

pub fn opt_grad_amsgrad_graphn_get(s : OptgradamsgradGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_amsgrad_graphn_set(s : OptgradamsgradGraphN, i : Int, v : Double) -> OptgradamsgradGraphN {
  let result = opt_grad_amsgrad_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_grad_amsgrad_graphn_sum(s : OptgradamsgradGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_grad_amsgrad_graphn_mean(s : OptgradamsgradGraphN) -> Double {
  if s.size == 0 { 0.0 } else { opt_grad_amsgrad_graphn_sum(s) / s.size.to_double() }
}

pub fn opt_grad_amsgrad_graphn_scale(s : OptgradamsgradGraphN, f : Double) -> OptgradamsgradGraphN {
  let result = opt_grad_amsgrad_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_grad_amsgrad_graphn_add(a : OptgradamsgradGraphN, b : OptgradamsgradGraphN) -> OptgradamsgradGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_grad_amsgrad_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_grad_amsgrad_graphn_copy(s : OptgradamsgradGraphN) -> OptgradamsgradGraphN {
  let result = opt_grad_amsgrad_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_grad_amsgrad_graphn_fill(s : OptgradamsgradGraphN, v : Double) -> OptgradamsgradGraphN {
  let result = opt_grad_amsgrad_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_grad_amsgrad_graphn_min(s : OptgradamsgradGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_amsgrad_graphn_max(s : OptgradamsgradGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_amsgrad_graphn_to_string(s : OptgradamsgradGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradamsgradNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_amsgrad_node_make(size : Int) -> OptgradamsgradNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_amsgrad_node_len(s : OptgradamsgradNode) -> Int { s.size }

pub fn opt_grad_amsgrad_node_get(s : OptgradamsgradNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_amsgrad_node_set(s : OptgradamsgradNode, i : Int, v : Double) -> OptgradamsgradNode {
  let result = opt_grad_amsgrad_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_grad_amsgrad_node_sum(s : OptgradamsgradNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_grad_amsgrad_node_mean(s : OptgradamsgradNode) -> Double {
  if s.size == 0 { 0.0 } else { opt_grad_amsgrad_node_sum(s) / s.size.to_double() }
}

pub fn opt_grad_amsgrad_node_scale(s : OptgradamsgradNode, f : Double) -> OptgradamsgradNode {
  let result = opt_grad_amsgrad_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_grad_amsgrad_node_add(a : OptgradamsgradNode, b : OptgradamsgradNode) -> OptgradamsgradNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_grad_amsgrad_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_grad_amsgrad_node_copy(s : OptgradamsgradNode) -> OptgradamsgradNode {
  let result = opt_grad_amsgrad_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_grad_amsgrad_node_fill(s : OptgradamsgradNode, v : Double) -> OptgradamsgradNode {
  let result = opt_grad_amsgrad_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_grad_amsgrad_node_min(s : OptgradamsgradNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_amsgrad_node_max(s : OptgradamsgradNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_amsgrad_node_to_string(s : OptgradamsgradNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradamsgradEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_amsgrad_edge_make(size : Int) -> OptgradamsgradEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_amsgrad_edge_len(s : OptgradamsgradEdge) -> Int { s.size }

pub fn opt_grad_amsgrad_edge_get(s : OptgradamsgradEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_amsgrad_edge_set(s : OptgradamsgradEdge, i : Int, v : Double) -> OptgradamsgradEdge {
  let result = opt_grad_amsgrad_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_grad_amsgrad_edge_sum(s : OptgradamsgradEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_grad_amsgrad_edge_mean(s : OptgradamsgradEdge) -> Double {
  if s.size == 0 { 0.0 } else { opt_grad_amsgrad_edge_sum(s) / s.size.to_double() }
}

pub fn opt_grad_amsgrad_edge_scale(s : OptgradamsgradEdge, f : Double) -> OptgradamsgradEdge {
  let result = opt_grad_amsgrad_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_grad_amsgrad_edge_add(a : OptgradamsgradEdge, b : OptgradamsgradEdge) -> OptgradamsgradEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_grad_amsgrad_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_grad_amsgrad_edge_copy(s : OptgradamsgradEdge) -> OptgradamsgradEdge {
  let result = opt_grad_amsgrad_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_grad_amsgrad_edge_fill(s : OptgradamsgradEdge, v : Double) -> OptgradamsgradEdge {
  let result = opt_grad_amsgrad_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_grad_amsgrad_edge_min(s : OptgradamsgradEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_amsgrad_edge_max(s : OptgradamsgradEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_amsgrad_edge_to_string(s : OptgradamsgradEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradamsgradPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_amsgrad_path_make(size : Int) -> OptgradamsgradPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_amsgrad_path_len(s : OptgradamsgradPath) -> Int { s.size }

pub fn opt_grad_amsgrad_path_get(s : OptgradamsgradPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_amsgrad_path_set(s : OptgradamsgradPath, i : Int, v : Double) -> OptgradamsgradPath {
  let result = opt_grad_amsgrad_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_grad_amsgrad_path_sum(s : OptgradamsgradPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_grad_amsgrad_path_mean(s : OptgradamsgradPath) -> Double {
  if s.size == 0 { 0.0 } else { opt_grad_amsgrad_path_sum(s) / s.size.to_double() }
}

pub fn opt_grad_amsgrad_path_scale(s : OptgradamsgradPath, f : Double) -> OptgradamsgradPath {
  let result = opt_grad_amsgrad_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_grad_amsgrad_path_add(a : OptgradamsgradPath, b : OptgradamsgradPath) -> OptgradamsgradPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_grad_amsgrad_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_grad_amsgrad_path_copy(s : OptgradamsgradPath) -> OptgradamsgradPath {
  let result = opt_grad_amsgrad_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_grad_amsgrad_path_fill(s : OptgradamsgradPath, v : Double) -> OptgradamsgradPath {
  let result = opt_grad_amsgrad_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_grad_amsgrad_path_min(s : OptgradamsgradPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_amsgrad_path_max(s : OptgradamsgradPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_amsgrad_path_to_string(s : OptgradamsgradPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradamsgradCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_amsgrad_cluster_make(size : Int) -> OptgradamsgradCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_amsgrad_cluster_len(s : OptgradamsgradCluster) -> Int { s.size }

pub fn opt_grad_amsgrad_cluster_get(s : OptgradamsgradCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_amsgrad_cluster_set(s : OptgradamsgradCluster, i : Int, v : Double) -> OptgradamsgradCluster {
  let result = opt_grad_amsgrad_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_grad_amsgrad_cluster_sum(s : OptgradamsgradCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_grad_amsgrad_cluster_mean(s : OptgradamsgradCluster) -> Double {
  if s.size == 0 { 0.0 } else { opt_grad_amsgrad_cluster_sum(s) / s.size.to_double() }
}

pub fn opt_grad_amsgrad_cluster_scale(s : OptgradamsgradCluster, f : Double) -> OptgradamsgradCluster {
  let result = opt_grad_amsgrad_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_grad_amsgrad_cluster_add(a : OptgradamsgradCluster, b : OptgradamsgradCluster) -> OptgradamsgradCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_grad_amsgrad_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_grad_amsgrad_cluster_copy(s : OptgradamsgradCluster) -> OptgradamsgradCluster {
  let result = opt_grad_amsgrad_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_grad_amsgrad_cluster_fill(s : OptgradamsgradCluster, v : Double) -> OptgradamsgradCluster {
  let result = opt_grad_amsgrad_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_grad_amsgrad_cluster_min(s : OptgradamsgradCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_amsgrad_cluster_max(s : OptgradamsgradCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_amsgrad_cluster_to_string(s : OptgradamsgradCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradamsgradModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_amsgrad_model_make(size : Int) -> OptgradamsgradModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_amsgrad_model_len(s : OptgradamsgradModel) -> Int { s.size }

pub fn opt_grad_amsgrad_model_get(s : OptgradamsgradModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_amsgrad_model_set(s : OptgradamsgradModel, i : Int, v : Double) -> OptgradamsgradModel {
  let result = opt_grad_amsgrad_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_grad_amsgrad_model_sum(s : OptgradamsgradModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_grad_amsgrad_model_mean(s : OptgradamsgradModel) -> Double {
  if s.size == 0 { 0.0 } else { opt_grad_amsgrad_model_sum(s) / s.size.to_double() }
}

pub fn opt_grad_amsgrad_model_scale(s : OptgradamsgradModel, f : Double) -> OptgradamsgradModel {
  let result = opt_grad_amsgrad_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_grad_amsgrad_model_add(a : OptgradamsgradModel, b : OptgradamsgradModel) -> OptgradamsgradModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_grad_amsgrad_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_grad_amsgrad_model_copy(s : OptgradamsgradModel) -> OptgradamsgradModel {
  let result = opt_grad_amsgrad_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_grad_amsgrad_model_fill(s : OptgradamsgradModel, v : Double) -> OptgradamsgradModel {
  let result = opt_grad_amsgrad_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_grad_amsgrad_model_min(s : OptgradamsgradModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_amsgrad_model_max(s : OptgradamsgradModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_amsgrad_model_to_string(s : OptgradamsgradModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradamsgradLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_amsgrad_layer_make(size : Int) -> OptgradamsgradLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_amsgrad_layer_len(s : OptgradamsgradLayer) -> Int { s.size }

pub fn opt_grad_amsgrad_layer_get(s : OptgradamsgradLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_amsgrad_layer_set(s : OptgradamsgradLayer, i : Int, v : Double) -> OptgradamsgradLayer {
  let result = opt_grad_amsgrad_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_grad_amsgrad_layer_sum(s : OptgradamsgradLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_grad_amsgrad_layer_mean(s : OptgradamsgradLayer) -> Double {
  if s.size == 0 { 0.0 } else { opt_grad_amsgrad_layer_sum(s) / s.size.to_double() }
}

pub fn opt_grad_amsgrad_layer_scale(s : OptgradamsgradLayer, f : Double) -> OptgradamsgradLayer {
  let result = opt_grad_amsgrad_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_grad_amsgrad_layer_add(a : OptgradamsgradLayer, b : OptgradamsgradLayer) -> OptgradamsgradLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_grad_amsgrad_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_grad_amsgrad_layer_copy(s : OptgradamsgradLayer) -> OptgradamsgradLayer {
  let result = opt_grad_amsgrad_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_grad_amsgrad_layer_fill(s : OptgradamsgradLayer, v : Double) -> OptgradamsgradLayer {
  let result = opt_grad_amsgrad_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_grad_amsgrad_layer_min(s : OptgradamsgradLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_amsgrad_layer_max(s : OptgradamsgradLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_amsgrad_layer_to_string(s : OptgradamsgradLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradamsgradBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_amsgrad_buffer_make(size : Int) -> OptgradamsgradBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_amsgrad_buffer_len(s : OptgradamsgradBuffer) -> Int { s.size }

pub fn opt_grad_amsgrad_buffer_get(s : OptgradamsgradBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_amsgrad_buffer_set(s : OptgradamsgradBuffer, i : Int, v : Double) -> OptgradamsgradBuffer {
  let result = opt_grad_amsgrad_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_grad_amsgrad_buffer_sum(s : OptgradamsgradBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_grad_amsgrad_buffer_mean(s : OptgradamsgradBuffer) -> Double {
  if s.size == 0 { 0.0 } else { opt_grad_amsgrad_buffer_sum(s) / s.size.to_double() }
}

pub fn opt_grad_amsgrad_buffer_scale(s : OptgradamsgradBuffer, f : Double) -> OptgradamsgradBuffer {
  let result = opt_grad_amsgrad_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_grad_amsgrad_buffer_add(a : OptgradamsgradBuffer, b : OptgradamsgradBuffer) -> OptgradamsgradBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_grad_amsgrad_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_grad_amsgrad_buffer_copy(s : OptgradamsgradBuffer) -> OptgradamsgradBuffer {
  let result = opt_grad_amsgrad_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_grad_amsgrad_buffer_fill(s : OptgradamsgradBuffer, v : Double) -> OptgradamsgradBuffer {
  let result = opt_grad_amsgrad_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_grad_amsgrad_buffer_min(s : OptgradamsgradBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_amsgrad_buffer_max(s : OptgradamsgradBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_amsgrad_buffer_to_string(s : OptgradamsgradBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradamsgradCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_amsgrad_cursor_make(size : Int) -> OptgradamsgradCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_amsgrad_cursor_len(s : OptgradamsgradCursor) -> Int { s.size }

pub fn opt_grad_amsgrad_cursor_get(s : OptgradamsgradCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_amsgrad_cursor_set(s : OptgradamsgradCursor, i : Int, v : Double) -> OptgradamsgradCursor {
  let result = opt_grad_amsgrad_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_grad_amsgrad_cursor_sum(s : OptgradamsgradCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_grad_amsgrad_cursor_mean(s : OptgradamsgradCursor) -> Double {
  if s.size == 0 { 0.0 } else { opt_grad_amsgrad_cursor_sum(s) / s.size.to_double() }
}

pub fn opt_grad_amsgrad_cursor_scale(s : OptgradamsgradCursor, f : Double) -> OptgradamsgradCursor {
  let result = opt_grad_amsgrad_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_grad_amsgrad_cursor_add(a : OptgradamsgradCursor, b : OptgradamsgradCursor) -> OptgradamsgradCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_grad_amsgrad_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_grad_amsgrad_cursor_copy(s : OptgradamsgradCursor) -> OptgradamsgradCursor {
  let result = opt_grad_amsgrad_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_grad_amsgrad_cursor_fill(s : OptgradamsgradCursor, v : Double) -> OptgradamsgradCursor {
  let result = opt_grad_amsgrad_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_grad_amsgrad_cursor_min(s : OptgradamsgradCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_amsgrad_cursor_max(s : OptgradamsgradCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_amsgrad_cursor_to_string(s : OptgradamsgradCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradamsgradView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_amsgrad_view_make(size : Int) -> OptgradamsgradView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_amsgrad_view_len(s : OptgradamsgradView) -> Int { s.size }

pub fn opt_grad_amsgrad_view_get(s : OptgradamsgradView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_amsgrad_view_set(s : OptgradamsgradView, i : Int, v : Double) -> OptgradamsgradView {
  let result = opt_grad_amsgrad_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_grad_amsgrad_view_sum(s : OptgradamsgradView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_grad_amsgrad_view_mean(s : OptgradamsgradView) -> Double {
  if s.size == 0 { 0.0 } else { opt_grad_amsgrad_view_sum(s) / s.size.to_double() }
}

pub fn opt_grad_amsgrad_view_scale(s : OptgradamsgradView, f : Double) -> OptgradamsgradView {
  let result = opt_grad_amsgrad_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_grad_amsgrad_view_add(a : OptgradamsgradView, b : OptgradamsgradView) -> OptgradamsgradView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_grad_amsgrad_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_grad_amsgrad_view_copy(s : OptgradamsgradView) -> OptgradamsgradView {
  let result = opt_grad_amsgrad_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_grad_amsgrad_view_fill(s : OptgradamsgradView, v : Double) -> OptgradamsgradView {
  let result = opt_grad_amsgrad_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_grad_amsgrad_view_min(s : OptgradamsgradView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_amsgrad_view_max(s : OptgradamsgradView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_amsgrad_view_to_string(s : OptgradamsgradView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradamsgradRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_amsgrad_range_make(size : Int) -> OptgradamsgradRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_amsgrad_range_len(s : OptgradamsgradRange) -> Int { s.size }

pub fn opt_grad_amsgrad_range_get(s : OptgradamsgradRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_amsgrad_range_set(s : OptgradamsgradRange, i : Int, v : Double) -> OptgradamsgradRange {
  let result = opt_grad_amsgrad_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_grad_amsgrad_range_sum(s : OptgradamsgradRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_grad_amsgrad_range_mean(s : OptgradamsgradRange) -> Double {
  if s.size == 0 { 0.0 } else { opt_grad_amsgrad_range_sum(s) / s.size.to_double() }
}

pub fn opt_grad_amsgrad_range_scale(s : OptgradamsgradRange, f : Double) -> OptgradamsgradRange {
  let result = opt_grad_amsgrad_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_grad_amsgrad_range_add(a : OptgradamsgradRange, b : OptgradamsgradRange) -> OptgradamsgradRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_grad_amsgrad_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_grad_amsgrad_range_copy(s : OptgradamsgradRange) -> OptgradamsgradRange {
  let result = opt_grad_amsgrad_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_grad_amsgrad_range_fill(s : OptgradamsgradRange, v : Double) -> OptgradamsgradRange {
  let result = opt_grad_amsgrad_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_grad_amsgrad_range_min(s : OptgradamsgradRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_amsgrad_range_max(s : OptgradamsgradRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_amsgrad_range_to_string(s : OptgradamsgradRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradamsgradSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_amsgrad_slice_make(size : Int) -> OptgradamsgradSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_amsgrad_slice_len(s : OptgradamsgradSlice) -> Int { s.size }

pub fn opt_grad_amsgrad_slice_get(s : OptgradamsgradSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_amsgrad_slice_set(s : OptgradamsgradSlice, i : Int, v : Double) -> OptgradamsgradSlice {
  let result = opt_grad_amsgrad_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_grad_amsgrad_slice_sum(s : OptgradamsgradSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_grad_amsgrad_slice_mean(s : OptgradamsgradSlice) -> Double {
  if s.size == 0 { 0.0 } else { opt_grad_amsgrad_slice_sum(s) / s.size.to_double() }
}

pub fn opt_grad_amsgrad_slice_scale(s : OptgradamsgradSlice, f : Double) -> OptgradamsgradSlice {
  let result = opt_grad_amsgrad_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_grad_amsgrad_slice_add(a : OptgradamsgradSlice, b : OptgradamsgradSlice) -> OptgradamsgradSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_grad_amsgrad_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_grad_amsgrad_slice_copy(s : OptgradamsgradSlice) -> OptgradamsgradSlice {
  let result = opt_grad_amsgrad_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_grad_amsgrad_slice_fill(s : OptgradamsgradSlice, v : Double) -> OptgradamsgradSlice {
  let result = opt_grad_amsgrad_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_grad_amsgrad_slice_min(s : OptgradamsgradSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_amsgrad_slice_max(s : OptgradamsgradSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_amsgrad_slice_to_string(s : OptgradamsgradSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn opt_grad_amsgrad_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_grad_amsgrad_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_grad_amsgrad_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_grad_amsgrad_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_grad_amsgrad_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_grad_amsgrad_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_grad_amsgrad_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_grad_amsgrad_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_grad_amsgrad_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_grad_amsgrad_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_grad_amsgrad_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_grad_amsgrad_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_grad_amsgrad_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_grad_amsgrad_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_grad_amsgrad_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_grad_amsgrad_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_grad_amsgrad_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_grad_amsgrad_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_grad_amsgrad_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_grad_amsgrad_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_grad_amsgrad_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_grad_amsgrad_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_grad_amsgrad_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_grad_amsgrad_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_grad_amsgrad_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

