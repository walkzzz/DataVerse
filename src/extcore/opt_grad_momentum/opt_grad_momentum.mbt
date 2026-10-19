///===
/// extcore/opt_grad_momentum

pub(all) struct OptgradmomentumPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn opt_grad_momentum_make_point(x : Double, y : Double) -> OptgradmomentumPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn opt_grad_momentum_make_point3(x : Double, y : Double, z : Double) -> OptgradmomentumPoint {
  { x, y, z, label: 0 }
}

pub fn opt_grad_momentum_point_x(pt : OptgradmomentumPoint) -> Double { pt.x }

pub fn opt_grad_momentum_point_y(pt : OptgradmomentumPoint) -> Double { pt.y }

pub fn opt_grad_momentum_point_z(pt : OptgradmomentumPoint) -> Double { pt.z }

pub fn opt_grad_momentum_point_label(pt : OptgradmomentumPoint) -> Int { pt.label }

pub fn opt_grad_momentum_point_dist(a : OptgradmomentumPoint, b : OptgradmomentumPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  opt_grad_momentum_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn opt_grad_momentum_point_add(a : OptgradmomentumPoint, b : OptgradmomentumPoint) -> OptgradmomentumPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn opt_grad_momentum_point_sub(a : OptgradmomentumPoint, b : OptgradmomentumPoint) -> OptgradmomentumPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn opt_grad_momentum_point_scale(pt : OptgradmomentumPoint, s : Double) -> OptgradmomentumPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn opt_grad_momentum_point_dot(a : OptgradmomentumPoint, b : OptgradmomentumPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn opt_grad_momentum_point_cross(a : OptgradmomentumPoint, b : OptgradmomentumPoint) -> OptgradmomentumPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn opt_grad_momentum_point_norm(pt : OptgradmomentumPoint) -> Double {
  opt_grad_momentum_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn opt_grad_momentum_point_normalize(pt : OptgradmomentumPoint) -> OptgradmomentumPoint {
  let n = opt_grad_momentum_point_norm(pt)
  if n < 0.0000001 { pt } else { opt_grad_momentum_point_scale(pt, 1.0 / n) }
}

pub fn opt_grad_momentum_point_negate(pt : OptgradmomentumPoint) -> OptgradmomentumPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn opt_grad_momentum_point_mid(a : OptgradmomentumPoint, b : OptgradmomentumPoint) -> OptgradmomentumPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn opt_grad_momentum_point_lerp(a : OptgradmomentumPoint, b : OptgradmomentumPoint, t : Double) -> OptgradmomentumPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn opt_grad_momentum_point_to_string(pt : OptgradmomentumPoint) -> String {
  "(" + opt_grad_momentum_dbl(pt.x) + ", " + opt_grad_momentum_dbl(pt.y) + ", " + opt_grad_momentum_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct OptgradmomentumSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn opt_grad_momentum_make_series(vals : Array[Double], name : String) -> OptgradmomentumSeries {
  { vals, name, meta: 0 }
}

pub fn opt_grad_momentum_series_len(s : OptgradmomentumSeries) -> Int { s.vals.length() }

pub fn opt_grad_momentum_series_sum(s : OptgradmomentumSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn opt_grad_momentum_series_mean(s : OptgradmomentumSeries) -> Double {
  let n = opt_grad_momentum_series_len(s)
  if n == 0 { 0.0 } else { opt_grad_momentum_series_sum(s) / n.to_double() }
}

pub fn opt_grad_momentum_series_min(s : OptgradmomentumSeries) -> Double {
  let n = opt_grad_momentum_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn opt_grad_momentum_series_max(s : OptgradmomentumSeries) -> Double {
  let n = opt_grad_momentum_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn opt_grad_momentum_series_range(s : OptgradmomentumSeries) -> Double {
  opt_grad_momentum_series_max(s) - opt_grad_momentum_series_min(s)
}

pub fn opt_grad_momentum_series_var(s : OptgradmomentumSeries) -> Double {
  let n = opt_grad_momentum_series_len(s)
  if n == 0 { 0.0 } else {
    let m = opt_grad_momentum_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn opt_grad_momentum_series_std(s : OptgradmomentumSeries) -> Double { opt_grad_momentum_sqrt(opt_grad_momentum_series_var(s)) }

pub fn opt_grad_momentum_series_median(s : OptgradmomentumSeries) -> Double {
  let n = opt_grad_momentum_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = opt_grad_momentum_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn opt_grad_momentum_series_scale(s : OptgradmomentumSeries, f : Double) -> OptgradmomentumSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = opt_grad_momentum_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn opt_grad_momentum_series_add(a : OptgradmomentumSeries, b : OptgradmomentumSeries) -> OptgradmomentumSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = opt_grad_momentum_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn opt_grad_momentum_series_sub(a : OptgradmomentumSeries, b : OptgradmomentumSeries) -> OptgradmomentumSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = opt_grad_momentum_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn opt_grad_momentum_series_normalize(s : OptgradmomentumSeries) -> OptgradmomentumSeries {
  let mn = opt_grad_momentum_series_min(s)
  let mx = opt_grad_momentum_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = opt_grad_momentum_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn opt_grad_momentum_series_cumsum(s : OptgradmomentumSeries) -> OptgradmomentumSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = opt_grad_momentum_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn opt_grad_momentum_series_to_string(s : OptgradmomentumSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + opt_grad_momentum_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct OptgradmomentumMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn opt_grad_momentum_make_matrix(rows : Int, cols : Int, val : Double) -> OptgradmomentumMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn opt_grad_momentum_matrix_identity(n : Int) -> OptgradmomentumMatrix {
  let m = opt_grad_momentum_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn opt_grad_momentum_matrix_get(m : OptgradmomentumMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn opt_grad_momentum_matrix_transpose(m : OptgradmomentumMatrix) -> OptgradmomentumMatrix {
  let result = opt_grad_momentum_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn opt_grad_momentum_matrix_add(a : OptgradmomentumMatrix, b : OptgradmomentumMatrix) -> OptgradmomentumMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = opt_grad_momentum_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn opt_grad_momentum_matrix_scale(m : OptgradmomentumMatrix, s : Double) -> OptgradmomentumMatrix {
  let result = opt_grad_momentum_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn opt_grad_momentum_matrix_multiply(a : OptgradmomentumMatrix, b : OptgradmomentumMatrix) -> OptgradmomentumMatrix {
  if a.cols != b.rows { return opt_grad_momentum_make_matrix(a.rows, b.cols, 0.0) }
  let result = opt_grad_momentum_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn opt_grad_momentum_matrix_trace(m : OptgradmomentumMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn opt_grad_momentum_matrix_det(m : OptgradmomentumMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn opt_grad_momentum_matrix_norm(m : OptgradmomentumMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  opt_grad_momentum_sqrt(sum)
}

pub fn opt_grad_momentum_matrix_to_string(m : OptgradmomentumMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + opt_grad_momentum_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct OptgradmomentumVector {
  comps : Array[Double]
  dim : Int
}

pub fn opt_grad_momentum_make_vector(comps : Array[Double]) -> OptgradmomentumVector {
  { comps, dim: comps.length() }
}

pub fn opt_grad_momentum_vector_zero(dim : Int) -> OptgradmomentumVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn opt_grad_momentum_vector_add(a : OptgradmomentumVector, b : OptgradmomentumVector) -> OptgradmomentumVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = opt_grad_momentum_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn opt_grad_momentum_vector_sub(a : OptgradmomentumVector, b : OptgradmomentumVector) -> OptgradmomentumVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = opt_grad_momentum_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn opt_grad_momentum_vector_scale(v : OptgradmomentumVector, s : Double) -> OptgradmomentumVector {
  let mut result = []
  for i in 0..<v.dim { result = opt_grad_momentum_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn opt_grad_momentum_vector_dot(a : OptgradmomentumVector, b : OptgradmomentumVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn opt_grad_momentum_vector_norm(v : OptgradmomentumVector) -> Double { opt_grad_momentum_sqrt(opt_grad_momentum_vector_dot(v, v)) }

pub fn opt_grad_momentum_vector_normalize(v : OptgradmomentumVector) -> OptgradmomentumVector {
  let n = opt_grad_momentum_vector_norm(v)
  if n < 0.0000001 { v } else { opt_grad_momentum_vector_scale(v, 1.0 / n) }
}

pub fn opt_grad_momentum_vector_dist(a : OptgradmomentumVector, b : OptgradmomentumVector) -> Double {
  opt_grad_momentum_vector_norm(opt_grad_momentum_vector_sub(a, b))
}

pub fn opt_grad_momentum_vector_to_string(v : OptgradmomentumVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + opt_grad_momentum_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn opt_grad_momentum_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn opt_grad_momentum_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = opt_grad_momentum_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn opt_grad_momentum_std(data : Array[Double]) -> Double { opt_grad_momentum_sqrt(opt_grad_momentum_var(data)) }

pub fn opt_grad_momentum_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = opt_grad_momentum_mean(a); let mb = opt_grad_momentum_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn opt_grad_momentum_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = opt_grad_momentum_std(a); let sb = opt_grad_momentum_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { opt_grad_momentum_cov(a, b) / (sa * sb) }
}

pub fn opt_grad_momentum_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = opt_grad_momentum_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn opt_grad_momentum_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn opt_grad_momentum_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn opt_grad_momentum_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  opt_grad_momentum_sqrt(opt_grad_momentum_mse(pred, labels))
}

pub fn opt_grad_momentum_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + opt_grad_momentum_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn opt_grad_momentum_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = opt_grad_momentum_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn opt_grad_momentum_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn opt_grad_momentum_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn opt_grad_momentum_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = opt_grad_momentum_precision(pred, labels, pos); let r = opt_grad_momentum_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn opt_grad_momentum_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn opt_grad_momentum_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = opt_grad_momentum_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn opt_grad_momentum_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn opt_grad_momentum_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn opt_grad_momentum_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = opt_grad_momentum_gcd(a, b)
    (a / g) * b
  }
}

pub fn opt_grad_momentum_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn opt_grad_momentum_fibonacci(n : Int) -> Int {
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

pub fn opt_grad_momentum_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = opt_grad_momentum_min(data); let mx = opt_grad_momentum_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn opt_grad_momentum_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = opt_grad_momentum_mean(data); let sd = opt_grad_momentum_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn opt_grad_momentum_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn opt_grad_momentum_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn opt_grad_momentum_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn opt_grad_momentum_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn opt_grad_momentum_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn opt_grad_momentum_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn opt_grad_momentum_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn opt_grad_momentum_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn opt_grad_momentum_dbl(x : Double) -> String {
  let i = if x >= 0.0 { opt_grad_momentum_int(x) } else { -opt_grad_momentum_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { opt_grad_momentum_int(f * 1000000.0) } else { opt_grad_momentum_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn opt_grad_momentum_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn opt_grad_momentum_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct OptgradmomentumFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_momentum_frame_make(size : Int) -> OptgradmomentumFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_momentum_frame_len(s : OptgradmomentumFrame) -> Int { s.size }

pub fn opt_grad_momentum_frame_get(s : OptgradmomentumFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_momentum_frame_set(s : OptgradmomentumFrame, i : Int, v : Double) -> OptgradmomentumFrame {
  let result = opt_grad_momentum_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_grad_momentum_frame_sum(s : OptgradmomentumFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_grad_momentum_frame_mean(s : OptgradmomentumFrame) -> Double {
  if s.size == 0 { 0.0 } else { opt_grad_momentum_frame_sum(s) / s.size.to_double() }
}

pub fn opt_grad_momentum_frame_scale(s : OptgradmomentumFrame, f : Double) -> OptgradmomentumFrame {
  let result = opt_grad_momentum_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_grad_momentum_frame_add(a : OptgradmomentumFrame, b : OptgradmomentumFrame) -> OptgradmomentumFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_grad_momentum_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_grad_momentum_frame_copy(s : OptgradmomentumFrame) -> OptgradmomentumFrame {
  let result = opt_grad_momentum_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_grad_momentum_frame_fill(s : OptgradmomentumFrame, v : Double) -> OptgradmomentumFrame {
  let result = opt_grad_momentum_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_grad_momentum_frame_min(s : OptgradmomentumFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_momentum_frame_max(s : OptgradmomentumFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_momentum_frame_to_string(s : OptgradmomentumFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradmomentumTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_momentum_table_make(size : Int) -> OptgradmomentumTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_momentum_table_len(s : OptgradmomentumTable) -> Int { s.size }

pub fn opt_grad_momentum_table_get(s : OptgradmomentumTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_momentum_table_set(s : OptgradmomentumTable, i : Int, v : Double) -> OptgradmomentumTable {
  let result = opt_grad_momentum_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_grad_momentum_table_sum(s : OptgradmomentumTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_grad_momentum_table_mean(s : OptgradmomentumTable) -> Double {
  if s.size == 0 { 0.0 } else { opt_grad_momentum_table_sum(s) / s.size.to_double() }
}

pub fn opt_grad_momentum_table_scale(s : OptgradmomentumTable, f : Double) -> OptgradmomentumTable {
  let result = opt_grad_momentum_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_grad_momentum_table_add(a : OptgradmomentumTable, b : OptgradmomentumTable) -> OptgradmomentumTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_grad_momentum_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_grad_momentum_table_copy(s : OptgradmomentumTable) -> OptgradmomentumTable {
  let result = opt_grad_momentum_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_grad_momentum_table_fill(s : OptgradmomentumTable, v : Double) -> OptgradmomentumTable {
  let result = opt_grad_momentum_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_grad_momentum_table_min(s : OptgradmomentumTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_momentum_table_max(s : OptgradmomentumTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_momentum_table_to_string(s : OptgradmomentumTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradmomentumGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_momentum_graphn_make(size : Int) -> OptgradmomentumGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_momentum_graphn_len(s : OptgradmomentumGraphN) -> Int { s.size }

pub fn opt_grad_momentum_graphn_get(s : OptgradmomentumGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_momentum_graphn_set(s : OptgradmomentumGraphN, i : Int, v : Double) -> OptgradmomentumGraphN {
  let result = opt_grad_momentum_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_grad_momentum_graphn_sum(s : OptgradmomentumGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_grad_momentum_graphn_mean(s : OptgradmomentumGraphN) -> Double {
  if s.size == 0 { 0.0 } else { opt_grad_momentum_graphn_sum(s) / s.size.to_double() }
}

pub fn opt_grad_momentum_graphn_scale(s : OptgradmomentumGraphN, f : Double) -> OptgradmomentumGraphN {
  let result = opt_grad_momentum_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_grad_momentum_graphn_add(a : OptgradmomentumGraphN, b : OptgradmomentumGraphN) -> OptgradmomentumGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_grad_momentum_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_grad_momentum_graphn_copy(s : OptgradmomentumGraphN) -> OptgradmomentumGraphN {
  let result = opt_grad_momentum_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_grad_momentum_graphn_fill(s : OptgradmomentumGraphN, v : Double) -> OptgradmomentumGraphN {
  let result = opt_grad_momentum_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_grad_momentum_graphn_min(s : OptgradmomentumGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_momentum_graphn_max(s : OptgradmomentumGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_momentum_graphn_to_string(s : OptgradmomentumGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradmomentumNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_momentum_node_make(size : Int) -> OptgradmomentumNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_momentum_node_len(s : OptgradmomentumNode) -> Int { s.size }

pub fn opt_grad_momentum_node_get(s : OptgradmomentumNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_momentum_node_set(s : OptgradmomentumNode, i : Int, v : Double) -> OptgradmomentumNode {
  let result = opt_grad_momentum_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_grad_momentum_node_sum(s : OptgradmomentumNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_grad_momentum_node_mean(s : OptgradmomentumNode) -> Double {
  if s.size == 0 { 0.0 } else { opt_grad_momentum_node_sum(s) / s.size.to_double() }
}

pub fn opt_grad_momentum_node_scale(s : OptgradmomentumNode, f : Double) -> OptgradmomentumNode {
  let result = opt_grad_momentum_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_grad_momentum_node_add(a : OptgradmomentumNode, b : OptgradmomentumNode) -> OptgradmomentumNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_grad_momentum_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_grad_momentum_node_copy(s : OptgradmomentumNode) -> OptgradmomentumNode {
  let result = opt_grad_momentum_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_grad_momentum_node_fill(s : OptgradmomentumNode, v : Double) -> OptgradmomentumNode {
  let result = opt_grad_momentum_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_grad_momentum_node_min(s : OptgradmomentumNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_momentum_node_max(s : OptgradmomentumNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_momentum_node_to_string(s : OptgradmomentumNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradmomentumEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_momentum_edge_make(size : Int) -> OptgradmomentumEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_momentum_edge_len(s : OptgradmomentumEdge) -> Int { s.size }

pub fn opt_grad_momentum_edge_get(s : OptgradmomentumEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_momentum_edge_set(s : OptgradmomentumEdge, i : Int, v : Double) -> OptgradmomentumEdge {
  let result = opt_grad_momentum_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_grad_momentum_edge_sum(s : OptgradmomentumEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_grad_momentum_edge_mean(s : OptgradmomentumEdge) -> Double {
  if s.size == 0 { 0.0 } else { opt_grad_momentum_edge_sum(s) / s.size.to_double() }
}

pub fn opt_grad_momentum_edge_scale(s : OptgradmomentumEdge, f : Double) -> OptgradmomentumEdge {
  let result = opt_grad_momentum_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_grad_momentum_edge_add(a : OptgradmomentumEdge, b : OptgradmomentumEdge) -> OptgradmomentumEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_grad_momentum_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_grad_momentum_edge_copy(s : OptgradmomentumEdge) -> OptgradmomentumEdge {
  let result = opt_grad_momentum_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_grad_momentum_edge_fill(s : OptgradmomentumEdge, v : Double) -> OptgradmomentumEdge {
  let result = opt_grad_momentum_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_grad_momentum_edge_min(s : OptgradmomentumEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_momentum_edge_max(s : OptgradmomentumEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_momentum_edge_to_string(s : OptgradmomentumEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradmomentumPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_momentum_path_make(size : Int) -> OptgradmomentumPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_momentum_path_len(s : OptgradmomentumPath) -> Int { s.size }

pub fn opt_grad_momentum_path_get(s : OptgradmomentumPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_momentum_path_set(s : OptgradmomentumPath, i : Int, v : Double) -> OptgradmomentumPath {
  let result = opt_grad_momentum_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_grad_momentum_path_sum(s : OptgradmomentumPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_grad_momentum_path_mean(s : OptgradmomentumPath) -> Double {
  if s.size == 0 { 0.0 } else { opt_grad_momentum_path_sum(s) / s.size.to_double() }
}

pub fn opt_grad_momentum_path_scale(s : OptgradmomentumPath, f : Double) -> OptgradmomentumPath {
  let result = opt_grad_momentum_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_grad_momentum_path_add(a : OptgradmomentumPath, b : OptgradmomentumPath) -> OptgradmomentumPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_grad_momentum_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_grad_momentum_path_copy(s : OptgradmomentumPath) -> OptgradmomentumPath {
  let result = opt_grad_momentum_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_grad_momentum_path_fill(s : OptgradmomentumPath, v : Double) -> OptgradmomentumPath {
  let result = opt_grad_momentum_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_grad_momentum_path_min(s : OptgradmomentumPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_momentum_path_max(s : OptgradmomentumPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_momentum_path_to_string(s : OptgradmomentumPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradmomentumCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_momentum_cluster_make(size : Int) -> OptgradmomentumCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_momentum_cluster_len(s : OptgradmomentumCluster) -> Int { s.size }

pub fn opt_grad_momentum_cluster_get(s : OptgradmomentumCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_momentum_cluster_set(s : OptgradmomentumCluster, i : Int, v : Double) -> OptgradmomentumCluster {
  let result = opt_grad_momentum_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_grad_momentum_cluster_sum(s : OptgradmomentumCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_grad_momentum_cluster_mean(s : OptgradmomentumCluster) -> Double {
  if s.size == 0 { 0.0 } else { opt_grad_momentum_cluster_sum(s) / s.size.to_double() }
}

pub fn opt_grad_momentum_cluster_scale(s : OptgradmomentumCluster, f : Double) -> OptgradmomentumCluster {
  let result = opt_grad_momentum_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_grad_momentum_cluster_add(a : OptgradmomentumCluster, b : OptgradmomentumCluster) -> OptgradmomentumCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_grad_momentum_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_grad_momentum_cluster_copy(s : OptgradmomentumCluster) -> OptgradmomentumCluster {
  let result = opt_grad_momentum_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_grad_momentum_cluster_fill(s : OptgradmomentumCluster, v : Double) -> OptgradmomentumCluster {
  let result = opt_grad_momentum_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_grad_momentum_cluster_min(s : OptgradmomentumCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_momentum_cluster_max(s : OptgradmomentumCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_momentum_cluster_to_string(s : OptgradmomentumCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradmomentumModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_momentum_model_make(size : Int) -> OptgradmomentumModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_momentum_model_len(s : OptgradmomentumModel) -> Int { s.size }

pub fn opt_grad_momentum_model_get(s : OptgradmomentumModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_momentum_model_set(s : OptgradmomentumModel, i : Int, v : Double) -> OptgradmomentumModel {
  let result = opt_grad_momentum_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_grad_momentum_model_sum(s : OptgradmomentumModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_grad_momentum_model_mean(s : OptgradmomentumModel) -> Double {
  if s.size == 0 { 0.0 } else { opt_grad_momentum_model_sum(s) / s.size.to_double() }
}

pub fn opt_grad_momentum_model_scale(s : OptgradmomentumModel, f : Double) -> OptgradmomentumModel {
  let result = opt_grad_momentum_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_grad_momentum_model_add(a : OptgradmomentumModel, b : OptgradmomentumModel) -> OptgradmomentumModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_grad_momentum_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_grad_momentum_model_copy(s : OptgradmomentumModel) -> OptgradmomentumModel {
  let result = opt_grad_momentum_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_grad_momentum_model_fill(s : OptgradmomentumModel, v : Double) -> OptgradmomentumModel {
  let result = opt_grad_momentum_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_grad_momentum_model_min(s : OptgradmomentumModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_momentum_model_max(s : OptgradmomentumModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_momentum_model_to_string(s : OptgradmomentumModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradmomentumLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_momentum_layer_make(size : Int) -> OptgradmomentumLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_momentum_layer_len(s : OptgradmomentumLayer) -> Int { s.size }

pub fn opt_grad_momentum_layer_get(s : OptgradmomentumLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_momentum_layer_set(s : OptgradmomentumLayer, i : Int, v : Double) -> OptgradmomentumLayer {
  let result = opt_grad_momentum_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_grad_momentum_layer_sum(s : OptgradmomentumLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_grad_momentum_layer_mean(s : OptgradmomentumLayer) -> Double {
  if s.size == 0 { 0.0 } else { opt_grad_momentum_layer_sum(s) / s.size.to_double() }
}

pub fn opt_grad_momentum_layer_scale(s : OptgradmomentumLayer, f : Double) -> OptgradmomentumLayer {
  let result = opt_grad_momentum_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_grad_momentum_layer_add(a : OptgradmomentumLayer, b : OptgradmomentumLayer) -> OptgradmomentumLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_grad_momentum_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_grad_momentum_layer_copy(s : OptgradmomentumLayer) -> OptgradmomentumLayer {
  let result = opt_grad_momentum_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_grad_momentum_layer_fill(s : OptgradmomentumLayer, v : Double) -> OptgradmomentumLayer {
  let result = opt_grad_momentum_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_grad_momentum_layer_min(s : OptgradmomentumLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_momentum_layer_max(s : OptgradmomentumLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_momentum_layer_to_string(s : OptgradmomentumLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradmomentumBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_momentum_buffer_make(size : Int) -> OptgradmomentumBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_momentum_buffer_len(s : OptgradmomentumBuffer) -> Int { s.size }

pub fn opt_grad_momentum_buffer_get(s : OptgradmomentumBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_momentum_buffer_set(s : OptgradmomentumBuffer, i : Int, v : Double) -> OptgradmomentumBuffer {
  let result = opt_grad_momentum_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_grad_momentum_buffer_sum(s : OptgradmomentumBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_grad_momentum_buffer_mean(s : OptgradmomentumBuffer) -> Double {
  if s.size == 0 { 0.0 } else { opt_grad_momentum_buffer_sum(s) / s.size.to_double() }
}

pub fn opt_grad_momentum_buffer_scale(s : OptgradmomentumBuffer, f : Double) -> OptgradmomentumBuffer {
  let result = opt_grad_momentum_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_grad_momentum_buffer_add(a : OptgradmomentumBuffer, b : OptgradmomentumBuffer) -> OptgradmomentumBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_grad_momentum_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_grad_momentum_buffer_copy(s : OptgradmomentumBuffer) -> OptgradmomentumBuffer {
  let result = opt_grad_momentum_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_grad_momentum_buffer_fill(s : OptgradmomentumBuffer, v : Double) -> OptgradmomentumBuffer {
  let result = opt_grad_momentum_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_grad_momentum_buffer_min(s : OptgradmomentumBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_momentum_buffer_max(s : OptgradmomentumBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_momentum_buffer_to_string(s : OptgradmomentumBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradmomentumCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_momentum_cursor_make(size : Int) -> OptgradmomentumCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_momentum_cursor_len(s : OptgradmomentumCursor) -> Int { s.size }

pub fn opt_grad_momentum_cursor_get(s : OptgradmomentumCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_momentum_cursor_set(s : OptgradmomentumCursor, i : Int, v : Double) -> OptgradmomentumCursor {
  let result = opt_grad_momentum_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_grad_momentum_cursor_sum(s : OptgradmomentumCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_grad_momentum_cursor_mean(s : OptgradmomentumCursor) -> Double {
  if s.size == 0 { 0.0 } else { opt_grad_momentum_cursor_sum(s) / s.size.to_double() }
}

pub fn opt_grad_momentum_cursor_scale(s : OptgradmomentumCursor, f : Double) -> OptgradmomentumCursor {
  let result = opt_grad_momentum_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_grad_momentum_cursor_add(a : OptgradmomentumCursor, b : OptgradmomentumCursor) -> OptgradmomentumCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_grad_momentum_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_grad_momentum_cursor_copy(s : OptgradmomentumCursor) -> OptgradmomentumCursor {
  let result = opt_grad_momentum_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_grad_momentum_cursor_fill(s : OptgradmomentumCursor, v : Double) -> OptgradmomentumCursor {
  let result = opt_grad_momentum_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_grad_momentum_cursor_min(s : OptgradmomentumCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_momentum_cursor_max(s : OptgradmomentumCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_momentum_cursor_to_string(s : OptgradmomentumCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradmomentumView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_momentum_view_make(size : Int) -> OptgradmomentumView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_momentum_view_len(s : OptgradmomentumView) -> Int { s.size }

pub fn opt_grad_momentum_view_get(s : OptgradmomentumView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_momentum_view_set(s : OptgradmomentumView, i : Int, v : Double) -> OptgradmomentumView {
  let result = opt_grad_momentum_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_grad_momentum_view_sum(s : OptgradmomentumView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_grad_momentum_view_mean(s : OptgradmomentumView) -> Double {
  if s.size == 0 { 0.0 } else { opt_grad_momentum_view_sum(s) / s.size.to_double() }
}

pub fn opt_grad_momentum_view_scale(s : OptgradmomentumView, f : Double) -> OptgradmomentumView {
  let result = opt_grad_momentum_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_grad_momentum_view_add(a : OptgradmomentumView, b : OptgradmomentumView) -> OptgradmomentumView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_grad_momentum_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_grad_momentum_view_copy(s : OptgradmomentumView) -> OptgradmomentumView {
  let result = opt_grad_momentum_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_grad_momentum_view_fill(s : OptgradmomentumView, v : Double) -> OptgradmomentumView {
  let result = opt_grad_momentum_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_grad_momentum_view_min(s : OptgradmomentumView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_momentum_view_max(s : OptgradmomentumView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_momentum_view_to_string(s : OptgradmomentumView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradmomentumRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_momentum_range_make(size : Int) -> OptgradmomentumRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_momentum_range_len(s : OptgradmomentumRange) -> Int { s.size }

pub fn opt_grad_momentum_range_get(s : OptgradmomentumRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_momentum_range_set(s : OptgradmomentumRange, i : Int, v : Double) -> OptgradmomentumRange {
  let result = opt_grad_momentum_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_grad_momentum_range_sum(s : OptgradmomentumRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_grad_momentum_range_mean(s : OptgradmomentumRange) -> Double {
  if s.size == 0 { 0.0 } else { opt_grad_momentum_range_sum(s) / s.size.to_double() }
}

pub fn opt_grad_momentum_range_scale(s : OptgradmomentumRange, f : Double) -> OptgradmomentumRange {
  let result = opt_grad_momentum_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_grad_momentum_range_add(a : OptgradmomentumRange, b : OptgradmomentumRange) -> OptgradmomentumRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_grad_momentum_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_grad_momentum_range_copy(s : OptgradmomentumRange) -> OptgradmomentumRange {
  let result = opt_grad_momentum_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_grad_momentum_range_fill(s : OptgradmomentumRange, v : Double) -> OptgradmomentumRange {
  let result = opt_grad_momentum_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_grad_momentum_range_min(s : OptgradmomentumRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_momentum_range_max(s : OptgradmomentumRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_momentum_range_to_string(s : OptgradmomentumRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradmomentumSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_momentum_slice_make(size : Int) -> OptgradmomentumSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_momentum_slice_len(s : OptgradmomentumSlice) -> Int { s.size }

pub fn opt_grad_momentum_slice_get(s : OptgradmomentumSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_momentum_slice_set(s : OptgradmomentumSlice, i : Int, v : Double) -> OptgradmomentumSlice {
  let result = opt_grad_momentum_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_grad_momentum_slice_sum(s : OptgradmomentumSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_grad_momentum_slice_mean(s : OptgradmomentumSlice) -> Double {
  if s.size == 0 { 0.0 } else { opt_grad_momentum_slice_sum(s) / s.size.to_double() }
}

pub fn opt_grad_momentum_slice_scale(s : OptgradmomentumSlice, f : Double) -> OptgradmomentumSlice {
  let result = opt_grad_momentum_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_grad_momentum_slice_add(a : OptgradmomentumSlice, b : OptgradmomentumSlice) -> OptgradmomentumSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_grad_momentum_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_grad_momentum_slice_copy(s : OptgradmomentumSlice) -> OptgradmomentumSlice {
  let result = opt_grad_momentum_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_grad_momentum_slice_fill(s : OptgradmomentumSlice, v : Double) -> OptgradmomentumSlice {
  let result = opt_grad_momentum_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_grad_momentum_slice_min(s : OptgradmomentumSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_momentum_slice_max(s : OptgradmomentumSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_momentum_slice_to_string(s : OptgradmomentumSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn opt_grad_momentum_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_grad_momentum_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_grad_momentum_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_grad_momentum_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_grad_momentum_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_grad_momentum_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_grad_momentum_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_grad_momentum_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_grad_momentum_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_grad_momentum_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_grad_momentum_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_grad_momentum_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_grad_momentum_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_grad_momentum_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_grad_momentum_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_grad_momentum_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_grad_momentum_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_grad_momentum_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_grad_momentum_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_grad_momentum_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_grad_momentum_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_grad_momentum_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_grad_momentum_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_grad_momentum_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_grad_momentum_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

