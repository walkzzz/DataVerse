///===
/// extcore/finance_risk_spectral

pub(all) struct FinanceriskspectralPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn finance_risk_spectral_make_point(x : Double, y : Double) -> FinanceriskspectralPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn finance_risk_spectral_make_point3(x : Double, y : Double, z : Double) -> FinanceriskspectralPoint {
  { x, y, z, label: 0 }
}

pub fn finance_risk_spectral_point_x(pt : FinanceriskspectralPoint) -> Double { pt.x }

pub fn finance_risk_spectral_point_y(pt : FinanceriskspectralPoint) -> Double { pt.y }

pub fn finance_risk_spectral_point_z(pt : FinanceriskspectralPoint) -> Double { pt.z }

pub fn finance_risk_spectral_point_label(pt : FinanceriskspectralPoint) -> Int { pt.label }

pub fn finance_risk_spectral_point_dist(a : FinanceriskspectralPoint, b : FinanceriskspectralPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  finance_risk_spectral_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn finance_risk_spectral_point_add(a : FinanceriskspectralPoint, b : FinanceriskspectralPoint) -> FinanceriskspectralPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn finance_risk_spectral_point_sub(a : FinanceriskspectralPoint, b : FinanceriskspectralPoint) -> FinanceriskspectralPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn finance_risk_spectral_point_scale(pt : FinanceriskspectralPoint, s : Double) -> FinanceriskspectralPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn finance_risk_spectral_point_dot(a : FinanceriskspectralPoint, b : FinanceriskspectralPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn finance_risk_spectral_point_cross(a : FinanceriskspectralPoint, b : FinanceriskspectralPoint) -> FinanceriskspectralPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn finance_risk_spectral_point_norm(pt : FinanceriskspectralPoint) -> Double {
  finance_risk_spectral_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn finance_risk_spectral_point_normalize(pt : FinanceriskspectralPoint) -> FinanceriskspectralPoint {
  let n = finance_risk_spectral_point_norm(pt)
  if n < 0.0000001 { pt } else { finance_risk_spectral_point_scale(pt, 1.0 / n) }
}

pub fn finance_risk_spectral_point_negate(pt : FinanceriskspectralPoint) -> FinanceriskspectralPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn finance_risk_spectral_point_mid(a : FinanceriskspectralPoint, b : FinanceriskspectralPoint) -> FinanceriskspectralPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn finance_risk_spectral_point_lerp(a : FinanceriskspectralPoint, b : FinanceriskspectralPoint, t : Double) -> FinanceriskspectralPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn finance_risk_spectral_point_to_string(pt : FinanceriskspectralPoint) -> String {
  "(" + finance_risk_spectral_dbl(pt.x) + ", " + finance_risk_spectral_dbl(pt.y) + ", " + finance_risk_spectral_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct FinanceriskspectralSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn finance_risk_spectral_make_series(vals : Array[Double], name : String) -> FinanceriskspectralSeries {
  { vals, name, meta: 0 }
}

pub fn finance_risk_spectral_series_len(s : FinanceriskspectralSeries) -> Int { s.vals.length() }

pub fn finance_risk_spectral_series_sum(s : FinanceriskspectralSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn finance_risk_spectral_series_mean(s : FinanceriskspectralSeries) -> Double {
  let n = finance_risk_spectral_series_len(s)
  if n == 0 { 0.0 } else { finance_risk_spectral_series_sum(s) / n.to_double() }
}

pub fn finance_risk_spectral_series_min(s : FinanceriskspectralSeries) -> Double {
  let n = finance_risk_spectral_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn finance_risk_spectral_series_max(s : FinanceriskspectralSeries) -> Double {
  let n = finance_risk_spectral_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn finance_risk_spectral_series_range(s : FinanceriskspectralSeries) -> Double {
  finance_risk_spectral_series_max(s) - finance_risk_spectral_series_min(s)
}

pub fn finance_risk_spectral_series_var(s : FinanceriskspectralSeries) -> Double {
  let n = finance_risk_spectral_series_len(s)
  if n == 0 { 0.0 } else {
    let m = finance_risk_spectral_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn finance_risk_spectral_series_std(s : FinanceriskspectralSeries) -> Double { finance_risk_spectral_sqrt(finance_risk_spectral_series_var(s)) }

pub fn finance_risk_spectral_series_median(s : FinanceriskspectralSeries) -> Double {
  let n = finance_risk_spectral_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = finance_risk_spectral_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn finance_risk_spectral_series_scale(s : FinanceriskspectralSeries, f : Double) -> FinanceriskspectralSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = finance_risk_spectral_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn finance_risk_spectral_series_add(a : FinanceriskspectralSeries, b : FinanceriskspectralSeries) -> FinanceriskspectralSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = finance_risk_spectral_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn finance_risk_spectral_series_sub(a : FinanceriskspectralSeries, b : FinanceriskspectralSeries) -> FinanceriskspectralSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = finance_risk_spectral_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn finance_risk_spectral_series_normalize(s : FinanceriskspectralSeries) -> FinanceriskspectralSeries {
  let mn = finance_risk_spectral_series_min(s)
  let mx = finance_risk_spectral_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = finance_risk_spectral_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn finance_risk_spectral_series_cumsum(s : FinanceriskspectralSeries) -> FinanceriskspectralSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = finance_risk_spectral_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn finance_risk_spectral_series_to_string(s : FinanceriskspectralSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + finance_risk_spectral_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct FinanceriskspectralMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn finance_risk_spectral_make_matrix(rows : Int, cols : Int, val : Double) -> FinanceriskspectralMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn finance_risk_spectral_matrix_identity(n : Int) -> FinanceriskspectralMatrix {
  let m = finance_risk_spectral_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn finance_risk_spectral_matrix_get(m : FinanceriskspectralMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn finance_risk_spectral_matrix_transpose(m : FinanceriskspectralMatrix) -> FinanceriskspectralMatrix {
  let result = finance_risk_spectral_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn finance_risk_spectral_matrix_add(a : FinanceriskspectralMatrix, b : FinanceriskspectralMatrix) -> FinanceriskspectralMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = finance_risk_spectral_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn finance_risk_spectral_matrix_scale(m : FinanceriskspectralMatrix, s : Double) -> FinanceriskspectralMatrix {
  let result = finance_risk_spectral_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn finance_risk_spectral_matrix_multiply(a : FinanceriskspectralMatrix, b : FinanceriskspectralMatrix) -> FinanceriskspectralMatrix {
  if a.cols != b.rows { return finance_risk_spectral_make_matrix(a.rows, b.cols, 0.0) }
  let result = finance_risk_spectral_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn finance_risk_spectral_matrix_trace(m : FinanceriskspectralMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn finance_risk_spectral_matrix_det(m : FinanceriskspectralMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn finance_risk_spectral_matrix_norm(m : FinanceriskspectralMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  finance_risk_spectral_sqrt(sum)
}

pub fn finance_risk_spectral_matrix_to_string(m : FinanceriskspectralMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + finance_risk_spectral_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct FinanceriskspectralVector {
  comps : Array[Double]
  dim : Int
}

pub fn finance_risk_spectral_make_vector(comps : Array[Double]) -> FinanceriskspectralVector {
  { comps, dim: comps.length() }
}

pub fn finance_risk_spectral_vector_zero(dim : Int) -> FinanceriskspectralVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn finance_risk_spectral_vector_add(a : FinanceriskspectralVector, b : FinanceriskspectralVector) -> FinanceriskspectralVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = finance_risk_spectral_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn finance_risk_spectral_vector_sub(a : FinanceriskspectralVector, b : FinanceriskspectralVector) -> FinanceriskspectralVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = finance_risk_spectral_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn finance_risk_spectral_vector_scale(v : FinanceriskspectralVector, s : Double) -> FinanceriskspectralVector {
  let mut result = []
  for i in 0..<v.dim { result = finance_risk_spectral_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn finance_risk_spectral_vector_dot(a : FinanceriskspectralVector, b : FinanceriskspectralVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn finance_risk_spectral_vector_norm(v : FinanceriskspectralVector) -> Double { finance_risk_spectral_sqrt(finance_risk_spectral_vector_dot(v, v)) }

pub fn finance_risk_spectral_vector_normalize(v : FinanceriskspectralVector) -> FinanceriskspectralVector {
  let n = finance_risk_spectral_vector_norm(v)
  if n < 0.0000001 { v } else { finance_risk_spectral_vector_scale(v, 1.0 / n) }
}

pub fn finance_risk_spectral_vector_dist(a : FinanceriskspectralVector, b : FinanceriskspectralVector) -> Double {
  finance_risk_spectral_vector_norm(finance_risk_spectral_vector_sub(a, b))
}

pub fn finance_risk_spectral_vector_to_string(v : FinanceriskspectralVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + finance_risk_spectral_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn finance_risk_spectral_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn finance_risk_spectral_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = finance_risk_spectral_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn finance_risk_spectral_std(data : Array[Double]) -> Double { finance_risk_spectral_sqrt(finance_risk_spectral_var(data)) }

pub fn finance_risk_spectral_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = finance_risk_spectral_mean(a); let mb = finance_risk_spectral_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn finance_risk_spectral_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = finance_risk_spectral_std(a); let sb = finance_risk_spectral_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { finance_risk_spectral_cov(a, b) / (sa * sb) }
}

pub fn finance_risk_spectral_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = finance_risk_spectral_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn finance_risk_spectral_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn finance_risk_spectral_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn finance_risk_spectral_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  finance_risk_spectral_sqrt(finance_risk_spectral_mse(pred, labels))
}

pub fn finance_risk_spectral_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + finance_risk_spectral_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn finance_risk_spectral_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = finance_risk_spectral_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn finance_risk_spectral_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn finance_risk_spectral_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn finance_risk_spectral_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = finance_risk_spectral_precision(pred, labels, pos); let r = finance_risk_spectral_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn finance_risk_spectral_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn finance_risk_spectral_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = finance_risk_spectral_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn finance_risk_spectral_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn finance_risk_spectral_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn finance_risk_spectral_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = finance_risk_spectral_gcd(a, b)
    (a / g) * b
  }
}

pub fn finance_risk_spectral_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn finance_risk_spectral_fibonacci(n : Int) -> Int {
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

pub fn finance_risk_spectral_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = finance_risk_spectral_min(data); let mx = finance_risk_spectral_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn finance_risk_spectral_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = finance_risk_spectral_mean(data); let sd = finance_risk_spectral_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn finance_risk_spectral_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn finance_risk_spectral_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn finance_risk_spectral_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn finance_risk_spectral_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn finance_risk_spectral_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn finance_risk_spectral_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn finance_risk_spectral_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn finance_risk_spectral_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn finance_risk_spectral_dbl(x : Double) -> String {
  let i = if x >= 0.0 { finance_risk_spectral_int(x) } else { -finance_risk_spectral_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { finance_risk_spectral_int(f * 1000000.0) } else { finance_risk_spectral_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn finance_risk_spectral_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn finance_risk_spectral_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct FinanceriskspectralFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_spectral_frame_make(size : Int) -> FinanceriskspectralFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_spectral_frame_len(s : FinanceriskspectralFrame) -> Int { s.size }

pub fn finance_risk_spectral_frame_get(s : FinanceriskspectralFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_spectral_frame_set(s : FinanceriskspectralFrame, i : Int, v : Double) -> FinanceriskspectralFrame {
  let result = finance_risk_spectral_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_risk_spectral_frame_sum(s : FinanceriskspectralFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_risk_spectral_frame_mean(s : FinanceriskspectralFrame) -> Double {
  if s.size == 0 { 0.0 } else { finance_risk_spectral_frame_sum(s) / s.size.to_double() }
}

pub fn finance_risk_spectral_frame_scale(s : FinanceriskspectralFrame, f : Double) -> FinanceriskspectralFrame {
  let result = finance_risk_spectral_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_risk_spectral_frame_add(a : FinanceriskspectralFrame, b : FinanceriskspectralFrame) -> FinanceriskspectralFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_risk_spectral_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_risk_spectral_frame_copy(s : FinanceriskspectralFrame) -> FinanceriskspectralFrame {
  let result = finance_risk_spectral_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_risk_spectral_frame_fill(s : FinanceriskspectralFrame, v : Double) -> FinanceriskspectralFrame {
  let result = finance_risk_spectral_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_risk_spectral_frame_min(s : FinanceriskspectralFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_spectral_frame_max(s : FinanceriskspectralFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_spectral_frame_to_string(s : FinanceriskspectralFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskspectralTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_spectral_table_make(size : Int) -> FinanceriskspectralTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_spectral_table_len(s : FinanceriskspectralTable) -> Int { s.size }

pub fn finance_risk_spectral_table_get(s : FinanceriskspectralTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_spectral_table_set(s : FinanceriskspectralTable, i : Int, v : Double) -> FinanceriskspectralTable {
  let result = finance_risk_spectral_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_risk_spectral_table_sum(s : FinanceriskspectralTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_risk_spectral_table_mean(s : FinanceriskspectralTable) -> Double {
  if s.size == 0 { 0.0 } else { finance_risk_spectral_table_sum(s) / s.size.to_double() }
}

pub fn finance_risk_spectral_table_scale(s : FinanceriskspectralTable, f : Double) -> FinanceriskspectralTable {
  let result = finance_risk_spectral_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_risk_spectral_table_add(a : FinanceriskspectralTable, b : FinanceriskspectralTable) -> FinanceriskspectralTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_risk_spectral_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_risk_spectral_table_copy(s : FinanceriskspectralTable) -> FinanceriskspectralTable {
  let result = finance_risk_spectral_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_risk_spectral_table_fill(s : FinanceriskspectralTable, v : Double) -> FinanceriskspectralTable {
  let result = finance_risk_spectral_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_risk_spectral_table_min(s : FinanceriskspectralTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_spectral_table_max(s : FinanceriskspectralTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_spectral_table_to_string(s : FinanceriskspectralTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskspectralGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_spectral_graphn_make(size : Int) -> FinanceriskspectralGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_spectral_graphn_len(s : FinanceriskspectralGraphN) -> Int { s.size }

pub fn finance_risk_spectral_graphn_get(s : FinanceriskspectralGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_spectral_graphn_set(s : FinanceriskspectralGraphN, i : Int, v : Double) -> FinanceriskspectralGraphN {
  let result = finance_risk_spectral_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_risk_spectral_graphn_sum(s : FinanceriskspectralGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_risk_spectral_graphn_mean(s : FinanceriskspectralGraphN) -> Double {
  if s.size == 0 { 0.0 } else { finance_risk_spectral_graphn_sum(s) / s.size.to_double() }
}

pub fn finance_risk_spectral_graphn_scale(s : FinanceriskspectralGraphN, f : Double) -> FinanceriskspectralGraphN {
  let result = finance_risk_spectral_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_risk_spectral_graphn_add(a : FinanceriskspectralGraphN, b : FinanceriskspectralGraphN) -> FinanceriskspectralGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_risk_spectral_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_risk_spectral_graphn_copy(s : FinanceriskspectralGraphN) -> FinanceriskspectralGraphN {
  let result = finance_risk_spectral_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_risk_spectral_graphn_fill(s : FinanceriskspectralGraphN, v : Double) -> FinanceriskspectralGraphN {
  let result = finance_risk_spectral_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_risk_spectral_graphn_min(s : FinanceriskspectralGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_spectral_graphn_max(s : FinanceriskspectralGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_spectral_graphn_to_string(s : FinanceriskspectralGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskspectralNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_spectral_node_make(size : Int) -> FinanceriskspectralNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_spectral_node_len(s : FinanceriskspectralNode) -> Int { s.size }

pub fn finance_risk_spectral_node_get(s : FinanceriskspectralNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_spectral_node_set(s : FinanceriskspectralNode, i : Int, v : Double) -> FinanceriskspectralNode {
  let result = finance_risk_spectral_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_risk_spectral_node_sum(s : FinanceriskspectralNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_risk_spectral_node_mean(s : FinanceriskspectralNode) -> Double {
  if s.size == 0 { 0.0 } else { finance_risk_spectral_node_sum(s) / s.size.to_double() }
}

pub fn finance_risk_spectral_node_scale(s : FinanceriskspectralNode, f : Double) -> FinanceriskspectralNode {
  let result = finance_risk_spectral_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_risk_spectral_node_add(a : FinanceriskspectralNode, b : FinanceriskspectralNode) -> FinanceriskspectralNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_risk_spectral_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_risk_spectral_node_copy(s : FinanceriskspectralNode) -> FinanceriskspectralNode {
  let result = finance_risk_spectral_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_risk_spectral_node_fill(s : FinanceriskspectralNode, v : Double) -> FinanceriskspectralNode {
  let result = finance_risk_spectral_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_risk_spectral_node_min(s : FinanceriskspectralNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_spectral_node_max(s : FinanceriskspectralNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_spectral_node_to_string(s : FinanceriskspectralNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskspectralEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_spectral_edge_make(size : Int) -> FinanceriskspectralEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_spectral_edge_len(s : FinanceriskspectralEdge) -> Int { s.size }

pub fn finance_risk_spectral_edge_get(s : FinanceriskspectralEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_spectral_edge_set(s : FinanceriskspectralEdge, i : Int, v : Double) -> FinanceriskspectralEdge {
  let result = finance_risk_spectral_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_risk_spectral_edge_sum(s : FinanceriskspectralEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_risk_spectral_edge_mean(s : FinanceriskspectralEdge) -> Double {
  if s.size == 0 { 0.0 } else { finance_risk_spectral_edge_sum(s) / s.size.to_double() }
}

pub fn finance_risk_spectral_edge_scale(s : FinanceriskspectralEdge, f : Double) -> FinanceriskspectralEdge {
  let result = finance_risk_spectral_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_risk_spectral_edge_add(a : FinanceriskspectralEdge, b : FinanceriskspectralEdge) -> FinanceriskspectralEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_risk_spectral_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_risk_spectral_edge_copy(s : FinanceriskspectralEdge) -> FinanceriskspectralEdge {
  let result = finance_risk_spectral_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_risk_spectral_edge_fill(s : FinanceriskspectralEdge, v : Double) -> FinanceriskspectralEdge {
  let result = finance_risk_spectral_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_risk_spectral_edge_min(s : FinanceriskspectralEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_spectral_edge_max(s : FinanceriskspectralEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_spectral_edge_to_string(s : FinanceriskspectralEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskspectralPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_spectral_path_make(size : Int) -> FinanceriskspectralPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_spectral_path_len(s : FinanceriskspectralPath) -> Int { s.size }

pub fn finance_risk_spectral_path_get(s : FinanceriskspectralPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_spectral_path_set(s : FinanceriskspectralPath, i : Int, v : Double) -> FinanceriskspectralPath {
  let result = finance_risk_spectral_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_risk_spectral_path_sum(s : FinanceriskspectralPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_risk_spectral_path_mean(s : FinanceriskspectralPath) -> Double {
  if s.size == 0 { 0.0 } else { finance_risk_spectral_path_sum(s) / s.size.to_double() }
}

pub fn finance_risk_spectral_path_scale(s : FinanceriskspectralPath, f : Double) -> FinanceriskspectralPath {
  let result = finance_risk_spectral_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_risk_spectral_path_add(a : FinanceriskspectralPath, b : FinanceriskspectralPath) -> FinanceriskspectralPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_risk_spectral_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_risk_spectral_path_copy(s : FinanceriskspectralPath) -> FinanceriskspectralPath {
  let result = finance_risk_spectral_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_risk_spectral_path_fill(s : FinanceriskspectralPath, v : Double) -> FinanceriskspectralPath {
  let result = finance_risk_spectral_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_risk_spectral_path_min(s : FinanceriskspectralPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_spectral_path_max(s : FinanceriskspectralPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_spectral_path_to_string(s : FinanceriskspectralPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskspectralCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_spectral_cluster_make(size : Int) -> FinanceriskspectralCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_spectral_cluster_len(s : FinanceriskspectralCluster) -> Int { s.size }

pub fn finance_risk_spectral_cluster_get(s : FinanceriskspectralCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_spectral_cluster_set(s : FinanceriskspectralCluster, i : Int, v : Double) -> FinanceriskspectralCluster {
  let result = finance_risk_spectral_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_risk_spectral_cluster_sum(s : FinanceriskspectralCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_risk_spectral_cluster_mean(s : FinanceriskspectralCluster) -> Double {
  if s.size == 0 { 0.0 } else { finance_risk_spectral_cluster_sum(s) / s.size.to_double() }
}

pub fn finance_risk_spectral_cluster_scale(s : FinanceriskspectralCluster, f : Double) -> FinanceriskspectralCluster {
  let result = finance_risk_spectral_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_risk_spectral_cluster_add(a : FinanceriskspectralCluster, b : FinanceriskspectralCluster) -> FinanceriskspectralCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_risk_spectral_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_risk_spectral_cluster_copy(s : FinanceriskspectralCluster) -> FinanceriskspectralCluster {
  let result = finance_risk_spectral_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_risk_spectral_cluster_fill(s : FinanceriskspectralCluster, v : Double) -> FinanceriskspectralCluster {
  let result = finance_risk_spectral_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_risk_spectral_cluster_min(s : FinanceriskspectralCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_spectral_cluster_max(s : FinanceriskspectralCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_spectral_cluster_to_string(s : FinanceriskspectralCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskspectralModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_spectral_model_make(size : Int) -> FinanceriskspectralModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_spectral_model_len(s : FinanceriskspectralModel) -> Int { s.size }

pub fn finance_risk_spectral_model_get(s : FinanceriskspectralModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_spectral_model_set(s : FinanceriskspectralModel, i : Int, v : Double) -> FinanceriskspectralModel {
  let result = finance_risk_spectral_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_risk_spectral_model_sum(s : FinanceriskspectralModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_risk_spectral_model_mean(s : FinanceriskspectralModel) -> Double {
  if s.size == 0 { 0.0 } else { finance_risk_spectral_model_sum(s) / s.size.to_double() }
}

pub fn finance_risk_spectral_model_scale(s : FinanceriskspectralModel, f : Double) -> FinanceriskspectralModel {
  let result = finance_risk_spectral_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_risk_spectral_model_add(a : FinanceriskspectralModel, b : FinanceriskspectralModel) -> FinanceriskspectralModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_risk_spectral_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_risk_spectral_model_copy(s : FinanceriskspectralModel) -> FinanceriskspectralModel {
  let result = finance_risk_spectral_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_risk_spectral_model_fill(s : FinanceriskspectralModel, v : Double) -> FinanceriskspectralModel {
  let result = finance_risk_spectral_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_risk_spectral_model_min(s : FinanceriskspectralModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_spectral_model_max(s : FinanceriskspectralModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_spectral_model_to_string(s : FinanceriskspectralModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskspectralLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_spectral_layer_make(size : Int) -> FinanceriskspectralLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_spectral_layer_len(s : FinanceriskspectralLayer) -> Int { s.size }

pub fn finance_risk_spectral_layer_get(s : FinanceriskspectralLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_spectral_layer_set(s : FinanceriskspectralLayer, i : Int, v : Double) -> FinanceriskspectralLayer {
  let result = finance_risk_spectral_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_risk_spectral_layer_sum(s : FinanceriskspectralLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_risk_spectral_layer_mean(s : FinanceriskspectralLayer) -> Double {
  if s.size == 0 { 0.0 } else { finance_risk_spectral_layer_sum(s) / s.size.to_double() }
}

pub fn finance_risk_spectral_layer_scale(s : FinanceriskspectralLayer, f : Double) -> FinanceriskspectralLayer {
  let result = finance_risk_spectral_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_risk_spectral_layer_add(a : FinanceriskspectralLayer, b : FinanceriskspectralLayer) -> FinanceriskspectralLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_risk_spectral_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_risk_spectral_layer_copy(s : FinanceriskspectralLayer) -> FinanceriskspectralLayer {
  let result = finance_risk_spectral_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_risk_spectral_layer_fill(s : FinanceriskspectralLayer, v : Double) -> FinanceriskspectralLayer {
  let result = finance_risk_spectral_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_risk_spectral_layer_min(s : FinanceriskspectralLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_spectral_layer_max(s : FinanceriskspectralLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_spectral_layer_to_string(s : FinanceriskspectralLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskspectralBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_spectral_buffer_make(size : Int) -> FinanceriskspectralBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_spectral_buffer_len(s : FinanceriskspectralBuffer) -> Int { s.size }

pub fn finance_risk_spectral_buffer_get(s : FinanceriskspectralBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_spectral_buffer_set(s : FinanceriskspectralBuffer, i : Int, v : Double) -> FinanceriskspectralBuffer {
  let result = finance_risk_spectral_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_risk_spectral_buffer_sum(s : FinanceriskspectralBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_risk_spectral_buffer_mean(s : FinanceriskspectralBuffer) -> Double {
  if s.size == 0 { 0.0 } else { finance_risk_spectral_buffer_sum(s) / s.size.to_double() }
}

pub fn finance_risk_spectral_buffer_scale(s : FinanceriskspectralBuffer, f : Double) -> FinanceriskspectralBuffer {
  let result = finance_risk_spectral_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_risk_spectral_buffer_add(a : FinanceriskspectralBuffer, b : FinanceriskspectralBuffer) -> FinanceriskspectralBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_risk_spectral_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_risk_spectral_buffer_copy(s : FinanceriskspectralBuffer) -> FinanceriskspectralBuffer {
  let result = finance_risk_spectral_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_risk_spectral_buffer_fill(s : FinanceriskspectralBuffer, v : Double) -> FinanceriskspectralBuffer {
  let result = finance_risk_spectral_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_risk_spectral_buffer_min(s : FinanceriskspectralBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_spectral_buffer_max(s : FinanceriskspectralBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_spectral_buffer_to_string(s : FinanceriskspectralBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskspectralCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_spectral_cursor_make(size : Int) -> FinanceriskspectralCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_spectral_cursor_len(s : FinanceriskspectralCursor) -> Int { s.size }

pub fn finance_risk_spectral_cursor_get(s : FinanceriskspectralCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_spectral_cursor_set(s : FinanceriskspectralCursor, i : Int, v : Double) -> FinanceriskspectralCursor {
  let result = finance_risk_spectral_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_risk_spectral_cursor_sum(s : FinanceriskspectralCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_risk_spectral_cursor_mean(s : FinanceriskspectralCursor) -> Double {
  if s.size == 0 { 0.0 } else { finance_risk_spectral_cursor_sum(s) / s.size.to_double() }
}

pub fn finance_risk_spectral_cursor_scale(s : FinanceriskspectralCursor, f : Double) -> FinanceriskspectralCursor {
  let result = finance_risk_spectral_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_risk_spectral_cursor_add(a : FinanceriskspectralCursor, b : FinanceriskspectralCursor) -> FinanceriskspectralCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_risk_spectral_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_risk_spectral_cursor_copy(s : FinanceriskspectralCursor) -> FinanceriskspectralCursor {
  let result = finance_risk_spectral_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_risk_spectral_cursor_fill(s : FinanceriskspectralCursor, v : Double) -> FinanceriskspectralCursor {
  let result = finance_risk_spectral_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_risk_spectral_cursor_min(s : FinanceriskspectralCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_spectral_cursor_max(s : FinanceriskspectralCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_spectral_cursor_to_string(s : FinanceriskspectralCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskspectralView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_spectral_view_make(size : Int) -> FinanceriskspectralView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_spectral_view_len(s : FinanceriskspectralView) -> Int { s.size }

pub fn finance_risk_spectral_view_get(s : FinanceriskspectralView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_spectral_view_set(s : FinanceriskspectralView, i : Int, v : Double) -> FinanceriskspectralView {
  let result = finance_risk_spectral_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_risk_spectral_view_sum(s : FinanceriskspectralView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_risk_spectral_view_mean(s : FinanceriskspectralView) -> Double {
  if s.size == 0 { 0.0 } else { finance_risk_spectral_view_sum(s) / s.size.to_double() }
}

pub fn finance_risk_spectral_view_scale(s : FinanceriskspectralView, f : Double) -> FinanceriskspectralView {
  let result = finance_risk_spectral_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_risk_spectral_view_add(a : FinanceriskspectralView, b : FinanceriskspectralView) -> FinanceriskspectralView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_risk_spectral_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_risk_spectral_view_copy(s : FinanceriskspectralView) -> FinanceriskspectralView {
  let result = finance_risk_spectral_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_risk_spectral_view_fill(s : FinanceriskspectralView, v : Double) -> FinanceriskspectralView {
  let result = finance_risk_spectral_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_risk_spectral_view_min(s : FinanceriskspectralView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_spectral_view_max(s : FinanceriskspectralView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_spectral_view_to_string(s : FinanceriskspectralView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskspectralRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_spectral_range_make(size : Int) -> FinanceriskspectralRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_spectral_range_len(s : FinanceriskspectralRange) -> Int { s.size }

pub fn finance_risk_spectral_range_get(s : FinanceriskspectralRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_spectral_range_set(s : FinanceriskspectralRange, i : Int, v : Double) -> FinanceriskspectralRange {
  let result = finance_risk_spectral_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_risk_spectral_range_sum(s : FinanceriskspectralRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_risk_spectral_range_mean(s : FinanceriskspectralRange) -> Double {
  if s.size == 0 { 0.0 } else { finance_risk_spectral_range_sum(s) / s.size.to_double() }
}

pub fn finance_risk_spectral_range_scale(s : FinanceriskspectralRange, f : Double) -> FinanceriskspectralRange {
  let result = finance_risk_spectral_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_risk_spectral_range_add(a : FinanceriskspectralRange, b : FinanceriskspectralRange) -> FinanceriskspectralRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_risk_spectral_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_risk_spectral_range_copy(s : FinanceriskspectralRange) -> FinanceriskspectralRange {
  let result = finance_risk_spectral_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_risk_spectral_range_fill(s : FinanceriskspectralRange, v : Double) -> FinanceriskspectralRange {
  let result = finance_risk_spectral_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_risk_spectral_range_min(s : FinanceriskspectralRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_spectral_range_max(s : FinanceriskspectralRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_spectral_range_to_string(s : FinanceriskspectralRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskspectralSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_spectral_slice_make(size : Int) -> FinanceriskspectralSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_spectral_slice_len(s : FinanceriskspectralSlice) -> Int { s.size }

pub fn finance_risk_spectral_slice_get(s : FinanceriskspectralSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_spectral_slice_set(s : FinanceriskspectralSlice, i : Int, v : Double) -> FinanceriskspectralSlice {
  let result = finance_risk_spectral_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_risk_spectral_slice_sum(s : FinanceriskspectralSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_risk_spectral_slice_mean(s : FinanceriskspectralSlice) -> Double {
  if s.size == 0 { 0.0 } else { finance_risk_spectral_slice_sum(s) / s.size.to_double() }
}

pub fn finance_risk_spectral_slice_scale(s : FinanceriskspectralSlice, f : Double) -> FinanceriskspectralSlice {
  let result = finance_risk_spectral_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_risk_spectral_slice_add(a : FinanceriskspectralSlice, b : FinanceriskspectralSlice) -> FinanceriskspectralSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_risk_spectral_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_risk_spectral_slice_copy(s : FinanceriskspectralSlice) -> FinanceriskspectralSlice {
  let result = finance_risk_spectral_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_risk_spectral_slice_fill(s : FinanceriskspectralSlice, v : Double) -> FinanceriskspectralSlice {
  let result = finance_risk_spectral_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_risk_spectral_slice_min(s : FinanceriskspectralSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_spectral_slice_max(s : FinanceriskspectralSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_spectral_slice_to_string(s : FinanceriskspectralSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn finance_risk_spectral_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_risk_spectral_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_risk_spectral_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_risk_spectral_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_risk_spectral_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_risk_spectral_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_risk_spectral_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_risk_spectral_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_risk_spectral_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_risk_spectral_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_risk_spectral_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_risk_spectral_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_risk_spectral_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_risk_spectral_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_risk_spectral_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_risk_spectral_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_risk_spectral_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_risk_spectral_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_risk_spectral_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_risk_spectral_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_risk_spectral_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_risk_spectral_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_risk_spectral_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_risk_spectral_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn finance_risk_spectral_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

