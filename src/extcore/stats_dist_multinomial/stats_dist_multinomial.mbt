///===
/// extcore/stats_dist_multinomial

pub(all) struct StatsdistmultinomialPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn stats_dist_multinomial_make_point(x : Double, y : Double) -> StatsdistmultinomialPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn stats_dist_multinomial_make_point3(x : Double, y : Double, z : Double) -> StatsdistmultinomialPoint {
  { x, y, z, label: 0 }
}

pub fn stats_dist_multinomial_point_x(pt : StatsdistmultinomialPoint) -> Double { pt.x }

pub fn stats_dist_multinomial_point_y(pt : StatsdistmultinomialPoint) -> Double { pt.y }

pub fn stats_dist_multinomial_point_z(pt : StatsdistmultinomialPoint) -> Double { pt.z }

pub fn stats_dist_multinomial_point_label(pt : StatsdistmultinomialPoint) -> Int { pt.label }

pub fn stats_dist_multinomial_point_dist(a : StatsdistmultinomialPoint, b : StatsdistmultinomialPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  stats_dist_multinomial_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn stats_dist_multinomial_point_add(a : StatsdistmultinomialPoint, b : StatsdistmultinomialPoint) -> StatsdistmultinomialPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn stats_dist_multinomial_point_sub(a : StatsdistmultinomialPoint, b : StatsdistmultinomialPoint) -> StatsdistmultinomialPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn stats_dist_multinomial_point_scale(pt : StatsdistmultinomialPoint, s : Double) -> StatsdistmultinomialPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn stats_dist_multinomial_point_dot(a : StatsdistmultinomialPoint, b : StatsdistmultinomialPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn stats_dist_multinomial_point_cross(a : StatsdistmultinomialPoint, b : StatsdistmultinomialPoint) -> StatsdistmultinomialPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn stats_dist_multinomial_point_norm(pt : StatsdistmultinomialPoint) -> Double {
  stats_dist_multinomial_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn stats_dist_multinomial_point_normalize(pt : StatsdistmultinomialPoint) -> StatsdistmultinomialPoint {
  let n = stats_dist_multinomial_point_norm(pt)
  if n < 0.0000001 { pt } else { stats_dist_multinomial_point_scale(pt, 1.0 / n) }
}

pub fn stats_dist_multinomial_point_negate(pt : StatsdistmultinomialPoint) -> StatsdistmultinomialPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn stats_dist_multinomial_point_mid(a : StatsdistmultinomialPoint, b : StatsdistmultinomialPoint) -> StatsdistmultinomialPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn stats_dist_multinomial_point_lerp(a : StatsdistmultinomialPoint, b : StatsdistmultinomialPoint, t : Double) -> StatsdistmultinomialPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn stats_dist_multinomial_point_to_string(pt : StatsdistmultinomialPoint) -> String {
  "(" + stats_dist_multinomial_dbl(pt.x) + ", " + stats_dist_multinomial_dbl(pt.y) + ", " + stats_dist_multinomial_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct StatsdistmultinomialSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn stats_dist_multinomial_make_series(vals : Array[Double], name : String) -> StatsdistmultinomialSeries {
  { vals, name, meta: 0 }
}

pub fn stats_dist_multinomial_series_len(s : StatsdistmultinomialSeries) -> Int { s.vals.length() }

pub fn stats_dist_multinomial_series_sum(s : StatsdistmultinomialSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn stats_dist_multinomial_series_mean(s : StatsdistmultinomialSeries) -> Double {
  let n = stats_dist_multinomial_series_len(s)
  if n == 0 { 0.0 } else { stats_dist_multinomial_series_sum(s) / n.to_double() }
}

pub fn stats_dist_multinomial_series_min(s : StatsdistmultinomialSeries) -> Double {
  let n = stats_dist_multinomial_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn stats_dist_multinomial_series_max(s : StatsdistmultinomialSeries) -> Double {
  let n = stats_dist_multinomial_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn stats_dist_multinomial_series_range(s : StatsdistmultinomialSeries) -> Double {
  stats_dist_multinomial_series_max(s) - stats_dist_multinomial_series_min(s)
}

pub fn stats_dist_multinomial_series_var(s : StatsdistmultinomialSeries) -> Double {
  let n = stats_dist_multinomial_series_len(s)
  if n == 0 { 0.0 } else {
    let m = stats_dist_multinomial_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn stats_dist_multinomial_series_std(s : StatsdistmultinomialSeries) -> Double { stats_dist_multinomial_sqrt(stats_dist_multinomial_series_var(s)) }

pub fn stats_dist_multinomial_series_median(s : StatsdistmultinomialSeries) -> Double {
  let n = stats_dist_multinomial_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = stats_dist_multinomial_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn stats_dist_multinomial_series_scale(s : StatsdistmultinomialSeries, f : Double) -> StatsdistmultinomialSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = stats_dist_multinomial_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn stats_dist_multinomial_series_add(a : StatsdistmultinomialSeries, b : StatsdistmultinomialSeries) -> StatsdistmultinomialSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = stats_dist_multinomial_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn stats_dist_multinomial_series_sub(a : StatsdistmultinomialSeries, b : StatsdistmultinomialSeries) -> StatsdistmultinomialSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = stats_dist_multinomial_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn stats_dist_multinomial_series_normalize(s : StatsdistmultinomialSeries) -> StatsdistmultinomialSeries {
  let mn = stats_dist_multinomial_series_min(s)
  let mx = stats_dist_multinomial_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = stats_dist_multinomial_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn stats_dist_multinomial_series_cumsum(s : StatsdistmultinomialSeries) -> StatsdistmultinomialSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = stats_dist_multinomial_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn stats_dist_multinomial_series_to_string(s : StatsdistmultinomialSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + stats_dist_multinomial_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct StatsdistmultinomialMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn stats_dist_multinomial_make_matrix(rows : Int, cols : Int, val : Double) -> StatsdistmultinomialMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn stats_dist_multinomial_matrix_identity(n : Int) -> StatsdistmultinomialMatrix {
  let m = stats_dist_multinomial_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn stats_dist_multinomial_matrix_get(m : StatsdistmultinomialMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn stats_dist_multinomial_matrix_transpose(m : StatsdistmultinomialMatrix) -> StatsdistmultinomialMatrix {
  let result = stats_dist_multinomial_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn stats_dist_multinomial_matrix_add(a : StatsdistmultinomialMatrix, b : StatsdistmultinomialMatrix) -> StatsdistmultinomialMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = stats_dist_multinomial_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn stats_dist_multinomial_matrix_scale(m : StatsdistmultinomialMatrix, s : Double) -> StatsdistmultinomialMatrix {
  let result = stats_dist_multinomial_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn stats_dist_multinomial_matrix_multiply(a : StatsdistmultinomialMatrix, b : StatsdistmultinomialMatrix) -> StatsdistmultinomialMatrix {
  if a.cols != b.rows { return stats_dist_multinomial_make_matrix(a.rows, b.cols, 0.0) }
  let result = stats_dist_multinomial_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn stats_dist_multinomial_matrix_trace(m : StatsdistmultinomialMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn stats_dist_multinomial_matrix_det(m : StatsdistmultinomialMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn stats_dist_multinomial_matrix_norm(m : StatsdistmultinomialMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  stats_dist_multinomial_sqrt(sum)
}

pub fn stats_dist_multinomial_matrix_to_string(m : StatsdistmultinomialMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + stats_dist_multinomial_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct StatsdistmultinomialVector {
  comps : Array[Double]
  dim : Int
}

pub fn stats_dist_multinomial_make_vector(comps : Array[Double]) -> StatsdistmultinomialVector {
  { comps, dim: comps.length() }
}

pub fn stats_dist_multinomial_vector_zero(dim : Int) -> StatsdistmultinomialVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn stats_dist_multinomial_vector_add(a : StatsdistmultinomialVector, b : StatsdistmultinomialVector) -> StatsdistmultinomialVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = stats_dist_multinomial_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn stats_dist_multinomial_vector_sub(a : StatsdistmultinomialVector, b : StatsdistmultinomialVector) -> StatsdistmultinomialVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = stats_dist_multinomial_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn stats_dist_multinomial_vector_scale(v : StatsdistmultinomialVector, s : Double) -> StatsdistmultinomialVector {
  let mut result = []
  for i in 0..<v.dim { result = stats_dist_multinomial_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn stats_dist_multinomial_vector_dot(a : StatsdistmultinomialVector, b : StatsdistmultinomialVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn stats_dist_multinomial_vector_norm(v : StatsdistmultinomialVector) -> Double { stats_dist_multinomial_sqrt(stats_dist_multinomial_vector_dot(v, v)) }

pub fn stats_dist_multinomial_vector_normalize(v : StatsdistmultinomialVector) -> StatsdistmultinomialVector {
  let n = stats_dist_multinomial_vector_norm(v)
  if n < 0.0000001 { v } else { stats_dist_multinomial_vector_scale(v, 1.0 / n) }
}

pub fn stats_dist_multinomial_vector_dist(a : StatsdistmultinomialVector, b : StatsdistmultinomialVector) -> Double {
  stats_dist_multinomial_vector_norm(stats_dist_multinomial_vector_sub(a, b))
}

pub fn stats_dist_multinomial_vector_to_string(v : StatsdistmultinomialVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + stats_dist_multinomial_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn stats_dist_multinomial_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn stats_dist_multinomial_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = stats_dist_multinomial_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn stats_dist_multinomial_std(data : Array[Double]) -> Double { stats_dist_multinomial_sqrt(stats_dist_multinomial_var(data)) }

pub fn stats_dist_multinomial_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = stats_dist_multinomial_mean(a); let mb = stats_dist_multinomial_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn stats_dist_multinomial_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = stats_dist_multinomial_std(a); let sb = stats_dist_multinomial_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { stats_dist_multinomial_cov(a, b) / (sa * sb) }
}

pub fn stats_dist_multinomial_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = stats_dist_multinomial_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn stats_dist_multinomial_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn stats_dist_multinomial_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn stats_dist_multinomial_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  stats_dist_multinomial_sqrt(stats_dist_multinomial_mse(pred, labels))
}

pub fn stats_dist_multinomial_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + stats_dist_multinomial_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn stats_dist_multinomial_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = stats_dist_multinomial_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn stats_dist_multinomial_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn stats_dist_multinomial_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn stats_dist_multinomial_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = stats_dist_multinomial_precision(pred, labels, pos); let r = stats_dist_multinomial_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn stats_dist_multinomial_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn stats_dist_multinomial_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = stats_dist_multinomial_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn stats_dist_multinomial_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn stats_dist_multinomial_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn stats_dist_multinomial_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = stats_dist_multinomial_gcd(a, b)
    (a / g) * b
  }
}

pub fn stats_dist_multinomial_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn stats_dist_multinomial_fibonacci(n : Int) -> Int {
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

pub fn stats_dist_multinomial_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = stats_dist_multinomial_min(data); let mx = stats_dist_multinomial_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn stats_dist_multinomial_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = stats_dist_multinomial_mean(data); let sd = stats_dist_multinomial_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn stats_dist_multinomial_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn stats_dist_multinomial_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn stats_dist_multinomial_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn stats_dist_multinomial_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn stats_dist_multinomial_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn stats_dist_multinomial_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn stats_dist_multinomial_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn stats_dist_multinomial_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn stats_dist_multinomial_dbl(x : Double) -> String {
  let i = if x >= 0.0 { stats_dist_multinomial_int(x) } else { -stats_dist_multinomial_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { stats_dist_multinomial_int(f * 1000000.0) } else { stats_dist_multinomial_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn stats_dist_multinomial_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn stats_dist_multinomial_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct StatsdistmultinomialFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_multinomial_frame_make(size : Int) -> StatsdistmultinomialFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_multinomial_frame_len(s : StatsdistmultinomialFrame) -> Int { s.size }

pub fn stats_dist_multinomial_frame_get(s : StatsdistmultinomialFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_multinomial_frame_set(s : StatsdistmultinomialFrame, i : Int, v : Double) -> StatsdistmultinomialFrame {
  let result = stats_dist_multinomial_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_multinomial_frame_sum(s : StatsdistmultinomialFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_multinomial_frame_mean(s : StatsdistmultinomialFrame) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_multinomial_frame_sum(s) / s.size.to_double() }
}

pub fn stats_dist_multinomial_frame_scale(s : StatsdistmultinomialFrame, f : Double) -> StatsdistmultinomialFrame {
  let result = stats_dist_multinomial_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_multinomial_frame_add(a : StatsdistmultinomialFrame, b : StatsdistmultinomialFrame) -> StatsdistmultinomialFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_multinomial_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_multinomial_frame_copy(s : StatsdistmultinomialFrame) -> StatsdistmultinomialFrame {
  let result = stats_dist_multinomial_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_multinomial_frame_fill(s : StatsdistmultinomialFrame, v : Double) -> StatsdistmultinomialFrame {
  let result = stats_dist_multinomial_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_multinomial_frame_min(s : StatsdistmultinomialFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_multinomial_frame_max(s : StatsdistmultinomialFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_multinomial_frame_to_string(s : StatsdistmultinomialFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistmultinomialTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_multinomial_table_make(size : Int) -> StatsdistmultinomialTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_multinomial_table_len(s : StatsdistmultinomialTable) -> Int { s.size }

pub fn stats_dist_multinomial_table_get(s : StatsdistmultinomialTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_multinomial_table_set(s : StatsdistmultinomialTable, i : Int, v : Double) -> StatsdistmultinomialTable {
  let result = stats_dist_multinomial_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_multinomial_table_sum(s : StatsdistmultinomialTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_multinomial_table_mean(s : StatsdistmultinomialTable) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_multinomial_table_sum(s) / s.size.to_double() }
}

pub fn stats_dist_multinomial_table_scale(s : StatsdistmultinomialTable, f : Double) -> StatsdistmultinomialTable {
  let result = stats_dist_multinomial_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_multinomial_table_add(a : StatsdistmultinomialTable, b : StatsdistmultinomialTable) -> StatsdistmultinomialTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_multinomial_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_multinomial_table_copy(s : StatsdistmultinomialTable) -> StatsdistmultinomialTable {
  let result = stats_dist_multinomial_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_multinomial_table_fill(s : StatsdistmultinomialTable, v : Double) -> StatsdistmultinomialTable {
  let result = stats_dist_multinomial_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_multinomial_table_min(s : StatsdistmultinomialTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_multinomial_table_max(s : StatsdistmultinomialTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_multinomial_table_to_string(s : StatsdistmultinomialTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistmultinomialGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_multinomial_graphn_make(size : Int) -> StatsdistmultinomialGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_multinomial_graphn_len(s : StatsdistmultinomialGraphN) -> Int { s.size }

pub fn stats_dist_multinomial_graphn_get(s : StatsdistmultinomialGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_multinomial_graphn_set(s : StatsdistmultinomialGraphN, i : Int, v : Double) -> StatsdistmultinomialGraphN {
  let result = stats_dist_multinomial_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_multinomial_graphn_sum(s : StatsdistmultinomialGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_multinomial_graphn_mean(s : StatsdistmultinomialGraphN) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_multinomial_graphn_sum(s) / s.size.to_double() }
}

pub fn stats_dist_multinomial_graphn_scale(s : StatsdistmultinomialGraphN, f : Double) -> StatsdistmultinomialGraphN {
  let result = stats_dist_multinomial_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_multinomial_graphn_add(a : StatsdistmultinomialGraphN, b : StatsdistmultinomialGraphN) -> StatsdistmultinomialGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_multinomial_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_multinomial_graphn_copy(s : StatsdistmultinomialGraphN) -> StatsdistmultinomialGraphN {
  let result = stats_dist_multinomial_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_multinomial_graphn_fill(s : StatsdistmultinomialGraphN, v : Double) -> StatsdistmultinomialGraphN {
  let result = stats_dist_multinomial_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_multinomial_graphn_min(s : StatsdistmultinomialGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_multinomial_graphn_max(s : StatsdistmultinomialGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_multinomial_graphn_to_string(s : StatsdistmultinomialGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistmultinomialNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_multinomial_node_make(size : Int) -> StatsdistmultinomialNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_multinomial_node_len(s : StatsdistmultinomialNode) -> Int { s.size }

pub fn stats_dist_multinomial_node_get(s : StatsdistmultinomialNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_multinomial_node_set(s : StatsdistmultinomialNode, i : Int, v : Double) -> StatsdistmultinomialNode {
  let result = stats_dist_multinomial_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_multinomial_node_sum(s : StatsdistmultinomialNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_multinomial_node_mean(s : StatsdistmultinomialNode) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_multinomial_node_sum(s) / s.size.to_double() }
}

pub fn stats_dist_multinomial_node_scale(s : StatsdistmultinomialNode, f : Double) -> StatsdistmultinomialNode {
  let result = stats_dist_multinomial_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_multinomial_node_add(a : StatsdistmultinomialNode, b : StatsdistmultinomialNode) -> StatsdistmultinomialNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_multinomial_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_multinomial_node_copy(s : StatsdistmultinomialNode) -> StatsdistmultinomialNode {
  let result = stats_dist_multinomial_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_multinomial_node_fill(s : StatsdistmultinomialNode, v : Double) -> StatsdistmultinomialNode {
  let result = stats_dist_multinomial_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_multinomial_node_min(s : StatsdistmultinomialNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_multinomial_node_max(s : StatsdistmultinomialNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_multinomial_node_to_string(s : StatsdistmultinomialNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistmultinomialEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_multinomial_edge_make(size : Int) -> StatsdistmultinomialEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_multinomial_edge_len(s : StatsdistmultinomialEdge) -> Int { s.size }

pub fn stats_dist_multinomial_edge_get(s : StatsdistmultinomialEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_multinomial_edge_set(s : StatsdistmultinomialEdge, i : Int, v : Double) -> StatsdistmultinomialEdge {
  let result = stats_dist_multinomial_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_multinomial_edge_sum(s : StatsdistmultinomialEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_multinomial_edge_mean(s : StatsdistmultinomialEdge) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_multinomial_edge_sum(s) / s.size.to_double() }
}

pub fn stats_dist_multinomial_edge_scale(s : StatsdistmultinomialEdge, f : Double) -> StatsdistmultinomialEdge {
  let result = stats_dist_multinomial_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_multinomial_edge_add(a : StatsdistmultinomialEdge, b : StatsdistmultinomialEdge) -> StatsdistmultinomialEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_multinomial_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_multinomial_edge_copy(s : StatsdistmultinomialEdge) -> StatsdistmultinomialEdge {
  let result = stats_dist_multinomial_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_multinomial_edge_fill(s : StatsdistmultinomialEdge, v : Double) -> StatsdistmultinomialEdge {
  let result = stats_dist_multinomial_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_multinomial_edge_min(s : StatsdistmultinomialEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_multinomial_edge_max(s : StatsdistmultinomialEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_multinomial_edge_to_string(s : StatsdistmultinomialEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistmultinomialPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_multinomial_path_make(size : Int) -> StatsdistmultinomialPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_multinomial_path_len(s : StatsdistmultinomialPath) -> Int { s.size }

pub fn stats_dist_multinomial_path_get(s : StatsdistmultinomialPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_multinomial_path_set(s : StatsdistmultinomialPath, i : Int, v : Double) -> StatsdistmultinomialPath {
  let result = stats_dist_multinomial_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_multinomial_path_sum(s : StatsdistmultinomialPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_multinomial_path_mean(s : StatsdistmultinomialPath) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_multinomial_path_sum(s) / s.size.to_double() }
}

pub fn stats_dist_multinomial_path_scale(s : StatsdistmultinomialPath, f : Double) -> StatsdistmultinomialPath {
  let result = stats_dist_multinomial_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_multinomial_path_add(a : StatsdistmultinomialPath, b : StatsdistmultinomialPath) -> StatsdistmultinomialPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_multinomial_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_multinomial_path_copy(s : StatsdistmultinomialPath) -> StatsdistmultinomialPath {
  let result = stats_dist_multinomial_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_multinomial_path_fill(s : StatsdistmultinomialPath, v : Double) -> StatsdistmultinomialPath {
  let result = stats_dist_multinomial_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_multinomial_path_min(s : StatsdistmultinomialPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_multinomial_path_max(s : StatsdistmultinomialPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_multinomial_path_to_string(s : StatsdistmultinomialPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistmultinomialCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_multinomial_cluster_make(size : Int) -> StatsdistmultinomialCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_multinomial_cluster_len(s : StatsdistmultinomialCluster) -> Int { s.size }

pub fn stats_dist_multinomial_cluster_get(s : StatsdistmultinomialCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_multinomial_cluster_set(s : StatsdistmultinomialCluster, i : Int, v : Double) -> StatsdistmultinomialCluster {
  let result = stats_dist_multinomial_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_multinomial_cluster_sum(s : StatsdistmultinomialCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_multinomial_cluster_mean(s : StatsdistmultinomialCluster) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_multinomial_cluster_sum(s) / s.size.to_double() }
}

pub fn stats_dist_multinomial_cluster_scale(s : StatsdistmultinomialCluster, f : Double) -> StatsdistmultinomialCluster {
  let result = stats_dist_multinomial_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_multinomial_cluster_add(a : StatsdistmultinomialCluster, b : StatsdistmultinomialCluster) -> StatsdistmultinomialCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_multinomial_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_multinomial_cluster_copy(s : StatsdistmultinomialCluster) -> StatsdistmultinomialCluster {
  let result = stats_dist_multinomial_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_multinomial_cluster_fill(s : StatsdistmultinomialCluster, v : Double) -> StatsdistmultinomialCluster {
  let result = stats_dist_multinomial_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_multinomial_cluster_min(s : StatsdistmultinomialCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_multinomial_cluster_max(s : StatsdistmultinomialCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_multinomial_cluster_to_string(s : StatsdistmultinomialCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistmultinomialModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_multinomial_model_make(size : Int) -> StatsdistmultinomialModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_multinomial_model_len(s : StatsdistmultinomialModel) -> Int { s.size }

pub fn stats_dist_multinomial_model_get(s : StatsdistmultinomialModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_multinomial_model_set(s : StatsdistmultinomialModel, i : Int, v : Double) -> StatsdistmultinomialModel {
  let result = stats_dist_multinomial_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_multinomial_model_sum(s : StatsdistmultinomialModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_multinomial_model_mean(s : StatsdistmultinomialModel) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_multinomial_model_sum(s) / s.size.to_double() }
}

pub fn stats_dist_multinomial_model_scale(s : StatsdistmultinomialModel, f : Double) -> StatsdistmultinomialModel {
  let result = stats_dist_multinomial_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_multinomial_model_add(a : StatsdistmultinomialModel, b : StatsdistmultinomialModel) -> StatsdistmultinomialModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_multinomial_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_multinomial_model_copy(s : StatsdistmultinomialModel) -> StatsdistmultinomialModel {
  let result = stats_dist_multinomial_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_multinomial_model_fill(s : StatsdistmultinomialModel, v : Double) -> StatsdistmultinomialModel {
  let result = stats_dist_multinomial_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_multinomial_model_min(s : StatsdistmultinomialModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_multinomial_model_max(s : StatsdistmultinomialModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_multinomial_model_to_string(s : StatsdistmultinomialModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistmultinomialLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_multinomial_layer_make(size : Int) -> StatsdistmultinomialLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_multinomial_layer_len(s : StatsdistmultinomialLayer) -> Int { s.size }

pub fn stats_dist_multinomial_layer_get(s : StatsdistmultinomialLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_multinomial_layer_set(s : StatsdistmultinomialLayer, i : Int, v : Double) -> StatsdistmultinomialLayer {
  let result = stats_dist_multinomial_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_multinomial_layer_sum(s : StatsdistmultinomialLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_multinomial_layer_mean(s : StatsdistmultinomialLayer) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_multinomial_layer_sum(s) / s.size.to_double() }
}

pub fn stats_dist_multinomial_layer_scale(s : StatsdistmultinomialLayer, f : Double) -> StatsdistmultinomialLayer {
  let result = stats_dist_multinomial_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_multinomial_layer_add(a : StatsdistmultinomialLayer, b : StatsdistmultinomialLayer) -> StatsdistmultinomialLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_multinomial_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_multinomial_layer_copy(s : StatsdistmultinomialLayer) -> StatsdistmultinomialLayer {
  let result = stats_dist_multinomial_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_multinomial_layer_fill(s : StatsdistmultinomialLayer, v : Double) -> StatsdistmultinomialLayer {
  let result = stats_dist_multinomial_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_multinomial_layer_min(s : StatsdistmultinomialLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_multinomial_layer_max(s : StatsdistmultinomialLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_multinomial_layer_to_string(s : StatsdistmultinomialLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistmultinomialBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_multinomial_buffer_make(size : Int) -> StatsdistmultinomialBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_multinomial_buffer_len(s : StatsdistmultinomialBuffer) -> Int { s.size }

pub fn stats_dist_multinomial_buffer_get(s : StatsdistmultinomialBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_multinomial_buffer_set(s : StatsdistmultinomialBuffer, i : Int, v : Double) -> StatsdistmultinomialBuffer {
  let result = stats_dist_multinomial_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_multinomial_buffer_sum(s : StatsdistmultinomialBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_multinomial_buffer_mean(s : StatsdistmultinomialBuffer) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_multinomial_buffer_sum(s) / s.size.to_double() }
}

pub fn stats_dist_multinomial_buffer_scale(s : StatsdistmultinomialBuffer, f : Double) -> StatsdistmultinomialBuffer {
  let result = stats_dist_multinomial_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_multinomial_buffer_add(a : StatsdistmultinomialBuffer, b : StatsdistmultinomialBuffer) -> StatsdistmultinomialBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_multinomial_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_multinomial_buffer_copy(s : StatsdistmultinomialBuffer) -> StatsdistmultinomialBuffer {
  let result = stats_dist_multinomial_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_multinomial_buffer_fill(s : StatsdistmultinomialBuffer, v : Double) -> StatsdistmultinomialBuffer {
  let result = stats_dist_multinomial_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_multinomial_buffer_min(s : StatsdistmultinomialBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_multinomial_buffer_max(s : StatsdistmultinomialBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_multinomial_buffer_to_string(s : StatsdistmultinomialBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistmultinomialCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_multinomial_cursor_make(size : Int) -> StatsdistmultinomialCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_multinomial_cursor_len(s : StatsdistmultinomialCursor) -> Int { s.size }

pub fn stats_dist_multinomial_cursor_get(s : StatsdistmultinomialCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_multinomial_cursor_set(s : StatsdistmultinomialCursor, i : Int, v : Double) -> StatsdistmultinomialCursor {
  let result = stats_dist_multinomial_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_multinomial_cursor_sum(s : StatsdistmultinomialCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_multinomial_cursor_mean(s : StatsdistmultinomialCursor) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_multinomial_cursor_sum(s) / s.size.to_double() }
}

pub fn stats_dist_multinomial_cursor_scale(s : StatsdistmultinomialCursor, f : Double) -> StatsdistmultinomialCursor {
  let result = stats_dist_multinomial_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_multinomial_cursor_add(a : StatsdistmultinomialCursor, b : StatsdistmultinomialCursor) -> StatsdistmultinomialCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_multinomial_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_multinomial_cursor_copy(s : StatsdistmultinomialCursor) -> StatsdistmultinomialCursor {
  let result = stats_dist_multinomial_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_multinomial_cursor_fill(s : StatsdistmultinomialCursor, v : Double) -> StatsdistmultinomialCursor {
  let result = stats_dist_multinomial_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_multinomial_cursor_min(s : StatsdistmultinomialCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_multinomial_cursor_max(s : StatsdistmultinomialCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_multinomial_cursor_to_string(s : StatsdistmultinomialCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistmultinomialView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_multinomial_view_make(size : Int) -> StatsdistmultinomialView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_multinomial_view_len(s : StatsdistmultinomialView) -> Int { s.size }

pub fn stats_dist_multinomial_view_get(s : StatsdistmultinomialView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_multinomial_view_set(s : StatsdistmultinomialView, i : Int, v : Double) -> StatsdistmultinomialView {
  let result = stats_dist_multinomial_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_multinomial_view_sum(s : StatsdistmultinomialView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_multinomial_view_mean(s : StatsdistmultinomialView) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_multinomial_view_sum(s) / s.size.to_double() }
}

pub fn stats_dist_multinomial_view_scale(s : StatsdistmultinomialView, f : Double) -> StatsdistmultinomialView {
  let result = stats_dist_multinomial_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_multinomial_view_add(a : StatsdistmultinomialView, b : StatsdistmultinomialView) -> StatsdistmultinomialView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_multinomial_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_multinomial_view_copy(s : StatsdistmultinomialView) -> StatsdistmultinomialView {
  let result = stats_dist_multinomial_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_multinomial_view_fill(s : StatsdistmultinomialView, v : Double) -> StatsdistmultinomialView {
  let result = stats_dist_multinomial_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_multinomial_view_min(s : StatsdistmultinomialView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_multinomial_view_max(s : StatsdistmultinomialView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_multinomial_view_to_string(s : StatsdistmultinomialView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistmultinomialRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_multinomial_range_make(size : Int) -> StatsdistmultinomialRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_multinomial_range_len(s : StatsdistmultinomialRange) -> Int { s.size }

pub fn stats_dist_multinomial_range_get(s : StatsdistmultinomialRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_multinomial_range_set(s : StatsdistmultinomialRange, i : Int, v : Double) -> StatsdistmultinomialRange {
  let result = stats_dist_multinomial_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_multinomial_range_sum(s : StatsdistmultinomialRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_multinomial_range_mean(s : StatsdistmultinomialRange) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_multinomial_range_sum(s) / s.size.to_double() }
}

pub fn stats_dist_multinomial_range_scale(s : StatsdistmultinomialRange, f : Double) -> StatsdistmultinomialRange {
  let result = stats_dist_multinomial_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_multinomial_range_add(a : StatsdistmultinomialRange, b : StatsdistmultinomialRange) -> StatsdistmultinomialRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_multinomial_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_multinomial_range_copy(s : StatsdistmultinomialRange) -> StatsdistmultinomialRange {
  let result = stats_dist_multinomial_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_multinomial_range_fill(s : StatsdistmultinomialRange, v : Double) -> StatsdistmultinomialRange {
  let result = stats_dist_multinomial_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_multinomial_range_min(s : StatsdistmultinomialRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_multinomial_range_max(s : StatsdistmultinomialRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_multinomial_range_to_string(s : StatsdistmultinomialRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistmultinomialSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_multinomial_slice_make(size : Int) -> StatsdistmultinomialSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_multinomial_slice_len(s : StatsdistmultinomialSlice) -> Int { s.size }

pub fn stats_dist_multinomial_slice_get(s : StatsdistmultinomialSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_multinomial_slice_set(s : StatsdistmultinomialSlice, i : Int, v : Double) -> StatsdistmultinomialSlice {
  let result = stats_dist_multinomial_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_multinomial_slice_sum(s : StatsdistmultinomialSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_multinomial_slice_mean(s : StatsdistmultinomialSlice) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_multinomial_slice_sum(s) / s.size.to_double() }
}

pub fn stats_dist_multinomial_slice_scale(s : StatsdistmultinomialSlice, f : Double) -> StatsdistmultinomialSlice {
  let result = stats_dist_multinomial_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_multinomial_slice_add(a : StatsdistmultinomialSlice, b : StatsdistmultinomialSlice) -> StatsdistmultinomialSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_multinomial_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_multinomial_slice_copy(s : StatsdistmultinomialSlice) -> StatsdistmultinomialSlice {
  let result = stats_dist_multinomial_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_multinomial_slice_fill(s : StatsdistmultinomialSlice, v : Double) -> StatsdistmultinomialSlice {
  let result = stats_dist_multinomial_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_multinomial_slice_min(s : StatsdistmultinomialSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_multinomial_slice_max(s : StatsdistmultinomialSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_multinomial_slice_to_string(s : StatsdistmultinomialSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn stats_dist_multinomial_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_dist_multinomial_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_dist_multinomial_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_dist_multinomial_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_dist_multinomial_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_dist_multinomial_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_dist_multinomial_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_dist_multinomial_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_dist_multinomial_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_dist_multinomial_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_dist_multinomial_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_dist_multinomial_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_dist_multinomial_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_dist_multinomial_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_dist_multinomial_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_dist_multinomial_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_dist_multinomial_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_dist_multinomial_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_dist_multinomial_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_dist_multinomial_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_dist_multinomial_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_dist_multinomial_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_dist_multinomial_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_dist_multinomial_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_dist_multinomial_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

