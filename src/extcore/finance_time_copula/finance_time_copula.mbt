///===
/// extcore/finance_time_copula

pub(all) struct FinancetimecopulaPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn finance_time_copula_make_point(x : Double, y : Double) -> FinancetimecopulaPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn finance_time_copula_make_point3(x : Double, y : Double, z : Double) -> FinancetimecopulaPoint {
  { x, y, z, label: 0 }
}

pub fn finance_time_copula_point_x(pt : FinancetimecopulaPoint) -> Double { pt.x }

pub fn finance_time_copula_point_y(pt : FinancetimecopulaPoint) -> Double { pt.y }

pub fn finance_time_copula_point_z(pt : FinancetimecopulaPoint) -> Double { pt.z }

pub fn finance_time_copula_point_label(pt : FinancetimecopulaPoint) -> Int { pt.label }

pub fn finance_time_copula_point_dist(a : FinancetimecopulaPoint, b : FinancetimecopulaPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  finance_time_copula_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn finance_time_copula_point_add(a : FinancetimecopulaPoint, b : FinancetimecopulaPoint) -> FinancetimecopulaPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn finance_time_copula_point_sub(a : FinancetimecopulaPoint, b : FinancetimecopulaPoint) -> FinancetimecopulaPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn finance_time_copula_point_scale(pt : FinancetimecopulaPoint, s : Double) -> FinancetimecopulaPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn finance_time_copula_point_dot(a : FinancetimecopulaPoint, b : FinancetimecopulaPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn finance_time_copula_point_cross(a : FinancetimecopulaPoint, b : FinancetimecopulaPoint) -> FinancetimecopulaPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn finance_time_copula_point_norm(pt : FinancetimecopulaPoint) -> Double {
  finance_time_copula_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn finance_time_copula_point_normalize(pt : FinancetimecopulaPoint) -> FinancetimecopulaPoint {
  let n = finance_time_copula_point_norm(pt)
  if n < 0.0000001 { pt } else { finance_time_copula_point_scale(pt, 1.0 / n) }
}

pub fn finance_time_copula_point_negate(pt : FinancetimecopulaPoint) -> FinancetimecopulaPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn finance_time_copula_point_mid(a : FinancetimecopulaPoint, b : FinancetimecopulaPoint) -> FinancetimecopulaPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn finance_time_copula_point_lerp(a : FinancetimecopulaPoint, b : FinancetimecopulaPoint, t : Double) -> FinancetimecopulaPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn finance_time_copula_point_to_string(pt : FinancetimecopulaPoint) -> String {
  "(" + finance_time_copula_dbl(pt.x) + ", " + finance_time_copula_dbl(pt.y) + ", " + finance_time_copula_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct FinancetimecopulaSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn finance_time_copula_make_series(vals : Array[Double], name : String) -> FinancetimecopulaSeries {
  { vals, name, meta: 0 }
}

pub fn finance_time_copula_series_len(s : FinancetimecopulaSeries) -> Int { s.vals.length() }

pub fn finance_time_copula_series_sum(s : FinancetimecopulaSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn finance_time_copula_series_mean(s : FinancetimecopulaSeries) -> Double {
  let n = finance_time_copula_series_len(s)
  if n == 0 { 0.0 } else { finance_time_copula_series_sum(s) / n.to_double() }
}

pub fn finance_time_copula_series_min(s : FinancetimecopulaSeries) -> Double {
  let n = finance_time_copula_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn finance_time_copula_series_max(s : FinancetimecopulaSeries) -> Double {
  let n = finance_time_copula_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn finance_time_copula_series_range(s : FinancetimecopulaSeries) -> Double {
  finance_time_copula_series_max(s) - finance_time_copula_series_min(s)
}

pub fn finance_time_copula_series_var(s : FinancetimecopulaSeries) -> Double {
  let n = finance_time_copula_series_len(s)
  if n == 0 { 0.0 } else {
    let m = finance_time_copula_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn finance_time_copula_series_std(s : FinancetimecopulaSeries) -> Double { finance_time_copula_sqrt(finance_time_copula_series_var(s)) }

pub fn finance_time_copula_series_median(s : FinancetimecopulaSeries) -> Double {
  let n = finance_time_copula_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = finance_time_copula_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn finance_time_copula_series_scale(s : FinancetimecopulaSeries, f : Double) -> FinancetimecopulaSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = finance_time_copula_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn finance_time_copula_series_add(a : FinancetimecopulaSeries, b : FinancetimecopulaSeries) -> FinancetimecopulaSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = finance_time_copula_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn finance_time_copula_series_sub(a : FinancetimecopulaSeries, b : FinancetimecopulaSeries) -> FinancetimecopulaSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = finance_time_copula_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn finance_time_copula_series_normalize(s : FinancetimecopulaSeries) -> FinancetimecopulaSeries {
  let mn = finance_time_copula_series_min(s)
  let mx = finance_time_copula_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = finance_time_copula_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn finance_time_copula_series_cumsum(s : FinancetimecopulaSeries) -> FinancetimecopulaSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = finance_time_copula_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn finance_time_copula_series_to_string(s : FinancetimecopulaSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + finance_time_copula_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct FinancetimecopulaMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn finance_time_copula_make_matrix(rows : Int, cols : Int, val : Double) -> FinancetimecopulaMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn finance_time_copula_matrix_identity(n : Int) -> FinancetimecopulaMatrix {
  let m = finance_time_copula_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn finance_time_copula_matrix_get(m : FinancetimecopulaMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn finance_time_copula_matrix_transpose(m : FinancetimecopulaMatrix) -> FinancetimecopulaMatrix {
  let result = finance_time_copula_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn finance_time_copula_matrix_add(a : FinancetimecopulaMatrix, b : FinancetimecopulaMatrix) -> FinancetimecopulaMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = finance_time_copula_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn finance_time_copula_matrix_scale(m : FinancetimecopulaMatrix, s : Double) -> FinancetimecopulaMatrix {
  let result = finance_time_copula_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn finance_time_copula_matrix_multiply(a : FinancetimecopulaMatrix, b : FinancetimecopulaMatrix) -> FinancetimecopulaMatrix {
  if a.cols != b.rows { return finance_time_copula_make_matrix(a.rows, b.cols, 0.0) }
  let result = finance_time_copula_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn finance_time_copula_matrix_trace(m : FinancetimecopulaMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn finance_time_copula_matrix_det(m : FinancetimecopulaMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn finance_time_copula_matrix_norm(m : FinancetimecopulaMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  finance_time_copula_sqrt(sum)
}

pub fn finance_time_copula_matrix_to_string(m : FinancetimecopulaMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + finance_time_copula_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct FinancetimecopulaVector {
  comps : Array[Double]
  dim : Int
}

pub fn finance_time_copula_make_vector(comps : Array[Double]) -> FinancetimecopulaVector {
  { comps, dim: comps.length() }
}

pub fn finance_time_copula_vector_zero(dim : Int) -> FinancetimecopulaVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn finance_time_copula_vector_add(a : FinancetimecopulaVector, b : FinancetimecopulaVector) -> FinancetimecopulaVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = finance_time_copula_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn finance_time_copula_vector_sub(a : FinancetimecopulaVector, b : FinancetimecopulaVector) -> FinancetimecopulaVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = finance_time_copula_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn finance_time_copula_vector_scale(v : FinancetimecopulaVector, s : Double) -> FinancetimecopulaVector {
  let mut result = []
  for i in 0..<v.dim { result = finance_time_copula_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn finance_time_copula_vector_dot(a : FinancetimecopulaVector, b : FinancetimecopulaVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn finance_time_copula_vector_norm(v : FinancetimecopulaVector) -> Double { finance_time_copula_sqrt(finance_time_copula_vector_dot(v, v)) }

pub fn finance_time_copula_vector_normalize(v : FinancetimecopulaVector) -> FinancetimecopulaVector {
  let n = finance_time_copula_vector_norm(v)
  if n < 0.0000001 { v } else { finance_time_copula_vector_scale(v, 1.0 / n) }
}

pub fn finance_time_copula_vector_dist(a : FinancetimecopulaVector, b : FinancetimecopulaVector) -> Double {
  finance_time_copula_vector_norm(finance_time_copula_vector_sub(a, b))
}

pub fn finance_time_copula_vector_to_string(v : FinancetimecopulaVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + finance_time_copula_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn finance_time_copula_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn finance_time_copula_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = finance_time_copula_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn finance_time_copula_std(data : Array[Double]) -> Double { finance_time_copula_sqrt(finance_time_copula_var(data)) }

pub fn finance_time_copula_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = finance_time_copula_mean(a); let mb = finance_time_copula_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn finance_time_copula_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = finance_time_copula_std(a); let sb = finance_time_copula_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { finance_time_copula_cov(a, b) / (sa * sb) }
}

pub fn finance_time_copula_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = finance_time_copula_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn finance_time_copula_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn finance_time_copula_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn finance_time_copula_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  finance_time_copula_sqrt(finance_time_copula_mse(pred, labels))
}

pub fn finance_time_copula_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + finance_time_copula_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn finance_time_copula_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = finance_time_copula_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn finance_time_copula_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn finance_time_copula_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn finance_time_copula_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = finance_time_copula_precision(pred, labels, pos); let r = finance_time_copula_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn finance_time_copula_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn finance_time_copula_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = finance_time_copula_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn finance_time_copula_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn finance_time_copula_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn finance_time_copula_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = finance_time_copula_gcd(a, b)
    (a / g) * b
  }
}

pub fn finance_time_copula_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn finance_time_copula_fibonacci(n : Int) -> Int {
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

pub fn finance_time_copula_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = finance_time_copula_min(data); let mx = finance_time_copula_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn finance_time_copula_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = finance_time_copula_mean(data); let sd = finance_time_copula_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn finance_time_copula_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn finance_time_copula_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn finance_time_copula_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn finance_time_copula_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn finance_time_copula_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn finance_time_copula_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn finance_time_copula_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn finance_time_copula_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn finance_time_copula_dbl(x : Double) -> String {
  let i = if x >= 0.0 { finance_time_copula_int(x) } else { -finance_time_copula_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { finance_time_copula_int(f * 1000000.0) } else { finance_time_copula_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn finance_time_copula_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn finance_time_copula_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct FinancetimecopulaFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_copula_frame_make(size : Int) -> FinancetimecopulaFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_copula_frame_len(s : FinancetimecopulaFrame) -> Int { s.size }

pub fn finance_time_copula_frame_get(s : FinancetimecopulaFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_copula_frame_set(s : FinancetimecopulaFrame, i : Int, v : Double) -> FinancetimecopulaFrame {
  let result = finance_time_copula_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_time_copula_frame_sum(s : FinancetimecopulaFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_time_copula_frame_mean(s : FinancetimecopulaFrame) -> Double {
  if s.size == 0 { 0.0 } else { finance_time_copula_frame_sum(s) / s.size.to_double() }
}

pub fn finance_time_copula_frame_scale(s : FinancetimecopulaFrame, f : Double) -> FinancetimecopulaFrame {
  let result = finance_time_copula_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_time_copula_frame_add(a : FinancetimecopulaFrame, b : FinancetimecopulaFrame) -> FinancetimecopulaFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_time_copula_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_time_copula_frame_copy(s : FinancetimecopulaFrame) -> FinancetimecopulaFrame {
  let result = finance_time_copula_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_time_copula_frame_fill(s : FinancetimecopulaFrame, v : Double) -> FinancetimecopulaFrame {
  let result = finance_time_copula_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_time_copula_frame_min(s : FinancetimecopulaFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_copula_frame_max(s : FinancetimecopulaFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_copula_frame_to_string(s : FinancetimecopulaFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimecopulaTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_copula_table_make(size : Int) -> FinancetimecopulaTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_copula_table_len(s : FinancetimecopulaTable) -> Int { s.size }

pub fn finance_time_copula_table_get(s : FinancetimecopulaTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_copula_table_set(s : FinancetimecopulaTable, i : Int, v : Double) -> FinancetimecopulaTable {
  let result = finance_time_copula_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_time_copula_table_sum(s : FinancetimecopulaTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_time_copula_table_mean(s : FinancetimecopulaTable) -> Double {
  if s.size == 0 { 0.0 } else { finance_time_copula_table_sum(s) / s.size.to_double() }
}

pub fn finance_time_copula_table_scale(s : FinancetimecopulaTable, f : Double) -> FinancetimecopulaTable {
  let result = finance_time_copula_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_time_copula_table_add(a : FinancetimecopulaTable, b : FinancetimecopulaTable) -> FinancetimecopulaTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_time_copula_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_time_copula_table_copy(s : FinancetimecopulaTable) -> FinancetimecopulaTable {
  let result = finance_time_copula_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_time_copula_table_fill(s : FinancetimecopulaTable, v : Double) -> FinancetimecopulaTable {
  let result = finance_time_copula_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_time_copula_table_min(s : FinancetimecopulaTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_copula_table_max(s : FinancetimecopulaTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_copula_table_to_string(s : FinancetimecopulaTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimecopulaGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_copula_graphn_make(size : Int) -> FinancetimecopulaGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_copula_graphn_len(s : FinancetimecopulaGraphN) -> Int { s.size }

pub fn finance_time_copula_graphn_get(s : FinancetimecopulaGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_copula_graphn_set(s : FinancetimecopulaGraphN, i : Int, v : Double) -> FinancetimecopulaGraphN {
  let result = finance_time_copula_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_time_copula_graphn_sum(s : FinancetimecopulaGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_time_copula_graphn_mean(s : FinancetimecopulaGraphN) -> Double {
  if s.size == 0 { 0.0 } else { finance_time_copula_graphn_sum(s) / s.size.to_double() }
}

pub fn finance_time_copula_graphn_scale(s : FinancetimecopulaGraphN, f : Double) -> FinancetimecopulaGraphN {
  let result = finance_time_copula_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_time_copula_graphn_add(a : FinancetimecopulaGraphN, b : FinancetimecopulaGraphN) -> FinancetimecopulaGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_time_copula_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_time_copula_graphn_copy(s : FinancetimecopulaGraphN) -> FinancetimecopulaGraphN {
  let result = finance_time_copula_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_time_copula_graphn_fill(s : FinancetimecopulaGraphN, v : Double) -> FinancetimecopulaGraphN {
  let result = finance_time_copula_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_time_copula_graphn_min(s : FinancetimecopulaGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_copula_graphn_max(s : FinancetimecopulaGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_copula_graphn_to_string(s : FinancetimecopulaGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimecopulaNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_copula_node_make(size : Int) -> FinancetimecopulaNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_copula_node_len(s : FinancetimecopulaNode) -> Int { s.size }

pub fn finance_time_copula_node_get(s : FinancetimecopulaNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_copula_node_set(s : FinancetimecopulaNode, i : Int, v : Double) -> FinancetimecopulaNode {
  let result = finance_time_copula_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_time_copula_node_sum(s : FinancetimecopulaNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_time_copula_node_mean(s : FinancetimecopulaNode) -> Double {
  if s.size == 0 { 0.0 } else { finance_time_copula_node_sum(s) / s.size.to_double() }
}

pub fn finance_time_copula_node_scale(s : FinancetimecopulaNode, f : Double) -> FinancetimecopulaNode {
  let result = finance_time_copula_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_time_copula_node_add(a : FinancetimecopulaNode, b : FinancetimecopulaNode) -> FinancetimecopulaNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_time_copula_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_time_copula_node_copy(s : FinancetimecopulaNode) -> FinancetimecopulaNode {
  let result = finance_time_copula_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_time_copula_node_fill(s : FinancetimecopulaNode, v : Double) -> FinancetimecopulaNode {
  let result = finance_time_copula_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_time_copula_node_min(s : FinancetimecopulaNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_copula_node_max(s : FinancetimecopulaNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_copula_node_to_string(s : FinancetimecopulaNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimecopulaEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_copula_edge_make(size : Int) -> FinancetimecopulaEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_copula_edge_len(s : FinancetimecopulaEdge) -> Int { s.size }

pub fn finance_time_copula_edge_get(s : FinancetimecopulaEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_copula_edge_set(s : FinancetimecopulaEdge, i : Int, v : Double) -> FinancetimecopulaEdge {
  let result = finance_time_copula_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_time_copula_edge_sum(s : FinancetimecopulaEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_time_copula_edge_mean(s : FinancetimecopulaEdge) -> Double {
  if s.size == 0 { 0.0 } else { finance_time_copula_edge_sum(s) / s.size.to_double() }
}

pub fn finance_time_copula_edge_scale(s : FinancetimecopulaEdge, f : Double) -> FinancetimecopulaEdge {
  let result = finance_time_copula_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_time_copula_edge_add(a : FinancetimecopulaEdge, b : FinancetimecopulaEdge) -> FinancetimecopulaEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_time_copula_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_time_copula_edge_copy(s : FinancetimecopulaEdge) -> FinancetimecopulaEdge {
  let result = finance_time_copula_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_time_copula_edge_fill(s : FinancetimecopulaEdge, v : Double) -> FinancetimecopulaEdge {
  let result = finance_time_copula_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_time_copula_edge_min(s : FinancetimecopulaEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_copula_edge_max(s : FinancetimecopulaEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_copula_edge_to_string(s : FinancetimecopulaEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimecopulaPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_copula_path_make(size : Int) -> FinancetimecopulaPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_copula_path_len(s : FinancetimecopulaPath) -> Int { s.size }

pub fn finance_time_copula_path_get(s : FinancetimecopulaPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_copula_path_set(s : FinancetimecopulaPath, i : Int, v : Double) -> FinancetimecopulaPath {
  let result = finance_time_copula_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_time_copula_path_sum(s : FinancetimecopulaPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_time_copula_path_mean(s : FinancetimecopulaPath) -> Double {
  if s.size == 0 { 0.0 } else { finance_time_copula_path_sum(s) / s.size.to_double() }
}

pub fn finance_time_copula_path_scale(s : FinancetimecopulaPath, f : Double) -> FinancetimecopulaPath {
  let result = finance_time_copula_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_time_copula_path_add(a : FinancetimecopulaPath, b : FinancetimecopulaPath) -> FinancetimecopulaPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_time_copula_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_time_copula_path_copy(s : FinancetimecopulaPath) -> FinancetimecopulaPath {
  let result = finance_time_copula_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_time_copula_path_fill(s : FinancetimecopulaPath, v : Double) -> FinancetimecopulaPath {
  let result = finance_time_copula_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_time_copula_path_min(s : FinancetimecopulaPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_copula_path_max(s : FinancetimecopulaPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_copula_path_to_string(s : FinancetimecopulaPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimecopulaCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_copula_cluster_make(size : Int) -> FinancetimecopulaCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_copula_cluster_len(s : FinancetimecopulaCluster) -> Int { s.size }

pub fn finance_time_copula_cluster_get(s : FinancetimecopulaCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_copula_cluster_set(s : FinancetimecopulaCluster, i : Int, v : Double) -> FinancetimecopulaCluster {
  let result = finance_time_copula_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_time_copula_cluster_sum(s : FinancetimecopulaCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_time_copula_cluster_mean(s : FinancetimecopulaCluster) -> Double {
  if s.size == 0 { 0.0 } else { finance_time_copula_cluster_sum(s) / s.size.to_double() }
}

pub fn finance_time_copula_cluster_scale(s : FinancetimecopulaCluster, f : Double) -> FinancetimecopulaCluster {
  let result = finance_time_copula_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_time_copula_cluster_add(a : FinancetimecopulaCluster, b : FinancetimecopulaCluster) -> FinancetimecopulaCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_time_copula_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_time_copula_cluster_copy(s : FinancetimecopulaCluster) -> FinancetimecopulaCluster {
  let result = finance_time_copula_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_time_copula_cluster_fill(s : FinancetimecopulaCluster, v : Double) -> FinancetimecopulaCluster {
  let result = finance_time_copula_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_time_copula_cluster_min(s : FinancetimecopulaCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_copula_cluster_max(s : FinancetimecopulaCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_copula_cluster_to_string(s : FinancetimecopulaCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimecopulaModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_copula_model_make(size : Int) -> FinancetimecopulaModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_copula_model_len(s : FinancetimecopulaModel) -> Int { s.size }

pub fn finance_time_copula_model_get(s : FinancetimecopulaModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_copula_model_set(s : FinancetimecopulaModel, i : Int, v : Double) -> FinancetimecopulaModel {
  let result = finance_time_copula_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_time_copula_model_sum(s : FinancetimecopulaModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_time_copula_model_mean(s : FinancetimecopulaModel) -> Double {
  if s.size == 0 { 0.0 } else { finance_time_copula_model_sum(s) / s.size.to_double() }
}

pub fn finance_time_copula_model_scale(s : FinancetimecopulaModel, f : Double) -> FinancetimecopulaModel {
  let result = finance_time_copula_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_time_copula_model_add(a : FinancetimecopulaModel, b : FinancetimecopulaModel) -> FinancetimecopulaModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_time_copula_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_time_copula_model_copy(s : FinancetimecopulaModel) -> FinancetimecopulaModel {
  let result = finance_time_copula_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_time_copula_model_fill(s : FinancetimecopulaModel, v : Double) -> FinancetimecopulaModel {
  let result = finance_time_copula_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_time_copula_model_min(s : FinancetimecopulaModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_copula_model_max(s : FinancetimecopulaModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_copula_model_to_string(s : FinancetimecopulaModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimecopulaLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_copula_layer_make(size : Int) -> FinancetimecopulaLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_copula_layer_len(s : FinancetimecopulaLayer) -> Int { s.size }

pub fn finance_time_copula_layer_get(s : FinancetimecopulaLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_copula_layer_set(s : FinancetimecopulaLayer, i : Int, v : Double) -> FinancetimecopulaLayer {
  let result = finance_time_copula_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_time_copula_layer_sum(s : FinancetimecopulaLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_time_copula_layer_mean(s : FinancetimecopulaLayer) -> Double {
  if s.size == 0 { 0.0 } else { finance_time_copula_layer_sum(s) / s.size.to_double() }
}

pub fn finance_time_copula_layer_scale(s : FinancetimecopulaLayer, f : Double) -> FinancetimecopulaLayer {
  let result = finance_time_copula_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_time_copula_layer_add(a : FinancetimecopulaLayer, b : FinancetimecopulaLayer) -> FinancetimecopulaLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_time_copula_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_time_copula_layer_copy(s : FinancetimecopulaLayer) -> FinancetimecopulaLayer {
  let result = finance_time_copula_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_time_copula_layer_fill(s : FinancetimecopulaLayer, v : Double) -> FinancetimecopulaLayer {
  let result = finance_time_copula_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_time_copula_layer_min(s : FinancetimecopulaLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_copula_layer_max(s : FinancetimecopulaLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_copula_layer_to_string(s : FinancetimecopulaLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimecopulaBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_copula_buffer_make(size : Int) -> FinancetimecopulaBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_copula_buffer_len(s : FinancetimecopulaBuffer) -> Int { s.size }

pub fn finance_time_copula_buffer_get(s : FinancetimecopulaBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_copula_buffer_set(s : FinancetimecopulaBuffer, i : Int, v : Double) -> FinancetimecopulaBuffer {
  let result = finance_time_copula_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_time_copula_buffer_sum(s : FinancetimecopulaBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_time_copula_buffer_mean(s : FinancetimecopulaBuffer) -> Double {
  if s.size == 0 { 0.0 } else { finance_time_copula_buffer_sum(s) / s.size.to_double() }
}

pub fn finance_time_copula_buffer_scale(s : FinancetimecopulaBuffer, f : Double) -> FinancetimecopulaBuffer {
  let result = finance_time_copula_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_time_copula_buffer_add(a : FinancetimecopulaBuffer, b : FinancetimecopulaBuffer) -> FinancetimecopulaBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_time_copula_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_time_copula_buffer_copy(s : FinancetimecopulaBuffer) -> FinancetimecopulaBuffer {
  let result = finance_time_copula_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_time_copula_buffer_fill(s : FinancetimecopulaBuffer, v : Double) -> FinancetimecopulaBuffer {
  let result = finance_time_copula_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_time_copula_buffer_min(s : FinancetimecopulaBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_copula_buffer_max(s : FinancetimecopulaBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_copula_buffer_to_string(s : FinancetimecopulaBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimecopulaCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_copula_cursor_make(size : Int) -> FinancetimecopulaCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_copula_cursor_len(s : FinancetimecopulaCursor) -> Int { s.size }

pub fn finance_time_copula_cursor_get(s : FinancetimecopulaCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_copula_cursor_set(s : FinancetimecopulaCursor, i : Int, v : Double) -> FinancetimecopulaCursor {
  let result = finance_time_copula_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_time_copula_cursor_sum(s : FinancetimecopulaCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_time_copula_cursor_mean(s : FinancetimecopulaCursor) -> Double {
  if s.size == 0 { 0.0 } else { finance_time_copula_cursor_sum(s) / s.size.to_double() }
}

pub fn finance_time_copula_cursor_scale(s : FinancetimecopulaCursor, f : Double) -> FinancetimecopulaCursor {
  let result = finance_time_copula_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_time_copula_cursor_add(a : FinancetimecopulaCursor, b : FinancetimecopulaCursor) -> FinancetimecopulaCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_time_copula_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_time_copula_cursor_copy(s : FinancetimecopulaCursor) -> FinancetimecopulaCursor {
  let result = finance_time_copula_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_time_copula_cursor_fill(s : FinancetimecopulaCursor, v : Double) -> FinancetimecopulaCursor {
  let result = finance_time_copula_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_time_copula_cursor_min(s : FinancetimecopulaCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_copula_cursor_max(s : FinancetimecopulaCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_copula_cursor_to_string(s : FinancetimecopulaCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimecopulaView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_copula_view_make(size : Int) -> FinancetimecopulaView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_copula_view_len(s : FinancetimecopulaView) -> Int { s.size }

pub fn finance_time_copula_view_get(s : FinancetimecopulaView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_copula_view_set(s : FinancetimecopulaView, i : Int, v : Double) -> FinancetimecopulaView {
  let result = finance_time_copula_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_time_copula_view_sum(s : FinancetimecopulaView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_time_copula_view_mean(s : FinancetimecopulaView) -> Double {
  if s.size == 0 { 0.0 } else { finance_time_copula_view_sum(s) / s.size.to_double() }
}

pub fn finance_time_copula_view_scale(s : FinancetimecopulaView, f : Double) -> FinancetimecopulaView {
  let result = finance_time_copula_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_time_copula_view_add(a : FinancetimecopulaView, b : FinancetimecopulaView) -> FinancetimecopulaView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_time_copula_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_time_copula_view_copy(s : FinancetimecopulaView) -> FinancetimecopulaView {
  let result = finance_time_copula_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_time_copula_view_fill(s : FinancetimecopulaView, v : Double) -> FinancetimecopulaView {
  let result = finance_time_copula_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_time_copula_view_min(s : FinancetimecopulaView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_copula_view_max(s : FinancetimecopulaView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_copula_view_to_string(s : FinancetimecopulaView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimecopulaRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_copula_range_make(size : Int) -> FinancetimecopulaRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_copula_range_len(s : FinancetimecopulaRange) -> Int { s.size }

pub fn finance_time_copula_range_get(s : FinancetimecopulaRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_copula_range_set(s : FinancetimecopulaRange, i : Int, v : Double) -> FinancetimecopulaRange {
  let result = finance_time_copula_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_time_copula_range_sum(s : FinancetimecopulaRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_time_copula_range_mean(s : FinancetimecopulaRange) -> Double {
  if s.size == 0 { 0.0 } else { finance_time_copula_range_sum(s) / s.size.to_double() }
}

pub fn finance_time_copula_range_scale(s : FinancetimecopulaRange, f : Double) -> FinancetimecopulaRange {
  let result = finance_time_copula_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_time_copula_range_add(a : FinancetimecopulaRange, b : FinancetimecopulaRange) -> FinancetimecopulaRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_time_copula_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_time_copula_range_copy(s : FinancetimecopulaRange) -> FinancetimecopulaRange {
  let result = finance_time_copula_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_time_copula_range_fill(s : FinancetimecopulaRange, v : Double) -> FinancetimecopulaRange {
  let result = finance_time_copula_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_time_copula_range_min(s : FinancetimecopulaRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_copula_range_max(s : FinancetimecopulaRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_copula_range_to_string(s : FinancetimecopulaRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimecopulaSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_copula_slice_make(size : Int) -> FinancetimecopulaSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_copula_slice_len(s : FinancetimecopulaSlice) -> Int { s.size }

pub fn finance_time_copula_slice_get(s : FinancetimecopulaSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_copula_slice_set(s : FinancetimecopulaSlice, i : Int, v : Double) -> FinancetimecopulaSlice {
  let result = finance_time_copula_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_time_copula_slice_sum(s : FinancetimecopulaSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_time_copula_slice_mean(s : FinancetimecopulaSlice) -> Double {
  if s.size == 0 { 0.0 } else { finance_time_copula_slice_sum(s) / s.size.to_double() }
}

pub fn finance_time_copula_slice_scale(s : FinancetimecopulaSlice, f : Double) -> FinancetimecopulaSlice {
  let result = finance_time_copula_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_time_copula_slice_add(a : FinancetimecopulaSlice, b : FinancetimecopulaSlice) -> FinancetimecopulaSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_time_copula_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_time_copula_slice_copy(s : FinancetimecopulaSlice) -> FinancetimecopulaSlice {
  let result = finance_time_copula_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_time_copula_slice_fill(s : FinancetimecopulaSlice, v : Double) -> FinancetimecopulaSlice {
  let result = finance_time_copula_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_time_copula_slice_min(s : FinancetimecopulaSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_copula_slice_max(s : FinancetimecopulaSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_copula_slice_to_string(s : FinancetimecopulaSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn finance_time_copula_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_time_copula_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_time_copula_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_time_copula_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_time_copula_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_time_copula_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_time_copula_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_time_copula_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_time_copula_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_time_copula_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_time_copula_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_time_copula_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_time_copula_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_time_copula_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_time_copula_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_time_copula_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_time_copula_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_time_copula_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_time_copula_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_time_copula_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_time_copula_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_time_copula_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_time_copula_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_time_copula_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_time_copula_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

