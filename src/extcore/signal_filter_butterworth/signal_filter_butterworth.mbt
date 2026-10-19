///===
/// extcore/signal_filter_butterworth

pub(all) struct SignalfilterbutterworthPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn signal_filter_butterworth_make_point(x : Double, y : Double) -> SignalfilterbutterworthPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn signal_filter_butterworth_make_point3(x : Double, y : Double, z : Double) -> SignalfilterbutterworthPoint {
  { x, y, z, label: 0 }
}

pub fn signal_filter_butterworth_point_x(pt : SignalfilterbutterworthPoint) -> Double { pt.x }

pub fn signal_filter_butterworth_point_y(pt : SignalfilterbutterworthPoint) -> Double { pt.y }

pub fn signal_filter_butterworth_point_z(pt : SignalfilterbutterworthPoint) -> Double { pt.z }

pub fn signal_filter_butterworth_point_label(pt : SignalfilterbutterworthPoint) -> Int { pt.label }

pub fn signal_filter_butterworth_point_dist(a : SignalfilterbutterworthPoint, b : SignalfilterbutterworthPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  signal_filter_butterworth_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn signal_filter_butterworth_point_add(a : SignalfilterbutterworthPoint, b : SignalfilterbutterworthPoint) -> SignalfilterbutterworthPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn signal_filter_butterworth_point_sub(a : SignalfilterbutterworthPoint, b : SignalfilterbutterworthPoint) -> SignalfilterbutterworthPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn signal_filter_butterworth_point_scale(pt : SignalfilterbutterworthPoint, s : Double) -> SignalfilterbutterworthPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn signal_filter_butterworth_point_dot(a : SignalfilterbutterworthPoint, b : SignalfilterbutterworthPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn signal_filter_butterworth_point_cross(a : SignalfilterbutterworthPoint, b : SignalfilterbutterworthPoint) -> SignalfilterbutterworthPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn signal_filter_butterworth_point_norm(pt : SignalfilterbutterworthPoint) -> Double {
  signal_filter_butterworth_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn signal_filter_butterworth_point_normalize(pt : SignalfilterbutterworthPoint) -> SignalfilterbutterworthPoint {
  let n = signal_filter_butterworth_point_norm(pt)
  if n < 0.0000001 { pt } else { signal_filter_butterworth_point_scale(pt, 1.0 / n) }
}

pub fn signal_filter_butterworth_point_negate(pt : SignalfilterbutterworthPoint) -> SignalfilterbutterworthPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn signal_filter_butterworth_point_mid(a : SignalfilterbutterworthPoint, b : SignalfilterbutterworthPoint) -> SignalfilterbutterworthPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn signal_filter_butterworth_point_lerp(a : SignalfilterbutterworthPoint, b : SignalfilterbutterworthPoint, t : Double) -> SignalfilterbutterworthPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn signal_filter_butterworth_point_to_string(pt : SignalfilterbutterworthPoint) -> String {
  "(" + signal_filter_butterworth_dbl(pt.x) + ", " + signal_filter_butterworth_dbl(pt.y) + ", " + signal_filter_butterworth_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct SignalfilterbutterworthSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn signal_filter_butterworth_make_series(vals : Array[Double], name : String) -> SignalfilterbutterworthSeries {
  { vals, name, meta: 0 }
}

pub fn signal_filter_butterworth_series_len(s : SignalfilterbutterworthSeries) -> Int { s.vals.length() }

pub fn signal_filter_butterworth_series_sum(s : SignalfilterbutterworthSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn signal_filter_butterworth_series_mean(s : SignalfilterbutterworthSeries) -> Double {
  let n = signal_filter_butterworth_series_len(s)
  if n == 0 { 0.0 } else { signal_filter_butterworth_series_sum(s) / n.to_double() }
}

pub fn signal_filter_butterworth_series_min(s : SignalfilterbutterworthSeries) -> Double {
  let n = signal_filter_butterworth_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn signal_filter_butterworth_series_max(s : SignalfilterbutterworthSeries) -> Double {
  let n = signal_filter_butterworth_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn signal_filter_butterworth_series_range(s : SignalfilterbutterworthSeries) -> Double {
  signal_filter_butterworth_series_max(s) - signal_filter_butterworth_series_min(s)
}

pub fn signal_filter_butterworth_series_var(s : SignalfilterbutterworthSeries) -> Double {
  let n = signal_filter_butterworth_series_len(s)
  if n == 0 { 0.0 } else {
    let m = signal_filter_butterworth_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn signal_filter_butterworth_series_std(s : SignalfilterbutterworthSeries) -> Double { signal_filter_butterworth_sqrt(signal_filter_butterworth_series_var(s)) }

pub fn signal_filter_butterworth_series_median(s : SignalfilterbutterworthSeries) -> Double {
  let n = signal_filter_butterworth_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = signal_filter_butterworth_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn signal_filter_butterworth_series_scale(s : SignalfilterbutterworthSeries, f : Double) -> SignalfilterbutterworthSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = signal_filter_butterworth_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn signal_filter_butterworth_series_add(a : SignalfilterbutterworthSeries, b : SignalfilterbutterworthSeries) -> SignalfilterbutterworthSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = signal_filter_butterworth_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn signal_filter_butterworth_series_sub(a : SignalfilterbutterworthSeries, b : SignalfilterbutterworthSeries) -> SignalfilterbutterworthSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = signal_filter_butterworth_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn signal_filter_butterworth_series_normalize(s : SignalfilterbutterworthSeries) -> SignalfilterbutterworthSeries {
  let mn = signal_filter_butterworth_series_min(s)
  let mx = signal_filter_butterworth_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = signal_filter_butterworth_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn signal_filter_butterworth_series_cumsum(s : SignalfilterbutterworthSeries) -> SignalfilterbutterworthSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = signal_filter_butterworth_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn signal_filter_butterworth_series_to_string(s : SignalfilterbutterworthSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + signal_filter_butterworth_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SignalfilterbutterworthMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn signal_filter_butterworth_make_matrix(rows : Int, cols : Int, val : Double) -> SignalfilterbutterworthMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn signal_filter_butterworth_matrix_identity(n : Int) -> SignalfilterbutterworthMatrix {
  let m = signal_filter_butterworth_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn signal_filter_butterworth_matrix_get(m : SignalfilterbutterworthMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn signal_filter_butterworth_matrix_transpose(m : SignalfilterbutterworthMatrix) -> SignalfilterbutterworthMatrix {
  let result = signal_filter_butterworth_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn signal_filter_butterworth_matrix_add(a : SignalfilterbutterworthMatrix, b : SignalfilterbutterworthMatrix) -> SignalfilterbutterworthMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = signal_filter_butterworth_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn signal_filter_butterworth_matrix_scale(m : SignalfilterbutterworthMatrix, s : Double) -> SignalfilterbutterworthMatrix {
  let result = signal_filter_butterworth_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn signal_filter_butterworth_matrix_multiply(a : SignalfilterbutterworthMatrix, b : SignalfilterbutterworthMatrix) -> SignalfilterbutterworthMatrix {
  if a.cols != b.rows { return signal_filter_butterworth_make_matrix(a.rows, b.cols, 0.0) }
  let result = signal_filter_butterworth_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn signal_filter_butterworth_matrix_trace(m : SignalfilterbutterworthMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn signal_filter_butterworth_matrix_det(m : SignalfilterbutterworthMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn signal_filter_butterworth_matrix_norm(m : SignalfilterbutterworthMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  signal_filter_butterworth_sqrt(sum)
}

pub fn signal_filter_butterworth_matrix_to_string(m : SignalfilterbutterworthMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + signal_filter_butterworth_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct SignalfilterbutterworthVector {
  comps : Array[Double]
  dim : Int
}

pub fn signal_filter_butterworth_make_vector(comps : Array[Double]) -> SignalfilterbutterworthVector {
  { comps, dim: comps.length() }
}

pub fn signal_filter_butterworth_vector_zero(dim : Int) -> SignalfilterbutterworthVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn signal_filter_butterworth_vector_add(a : SignalfilterbutterworthVector, b : SignalfilterbutterworthVector) -> SignalfilterbutterworthVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = signal_filter_butterworth_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn signal_filter_butterworth_vector_sub(a : SignalfilterbutterworthVector, b : SignalfilterbutterworthVector) -> SignalfilterbutterworthVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = signal_filter_butterworth_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn signal_filter_butterworth_vector_scale(v : SignalfilterbutterworthVector, s : Double) -> SignalfilterbutterworthVector {
  let mut result = []
  for i in 0..<v.dim { result = signal_filter_butterworth_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn signal_filter_butterworth_vector_dot(a : SignalfilterbutterworthVector, b : SignalfilterbutterworthVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn signal_filter_butterworth_vector_norm(v : SignalfilterbutterworthVector) -> Double { signal_filter_butterworth_sqrt(signal_filter_butterworth_vector_dot(v, v)) }

pub fn signal_filter_butterworth_vector_normalize(v : SignalfilterbutterworthVector) -> SignalfilterbutterworthVector {
  let n = signal_filter_butterworth_vector_norm(v)
  if n < 0.0000001 { v } else { signal_filter_butterworth_vector_scale(v, 1.0 / n) }
}

pub fn signal_filter_butterworth_vector_dist(a : SignalfilterbutterworthVector, b : SignalfilterbutterworthVector) -> Double {
  signal_filter_butterworth_vector_norm(signal_filter_butterworth_vector_sub(a, b))
}

pub fn signal_filter_butterworth_vector_to_string(v : SignalfilterbutterworthVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + signal_filter_butterworth_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn signal_filter_butterworth_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn signal_filter_butterworth_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = signal_filter_butterworth_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn signal_filter_butterworth_std(data : Array[Double]) -> Double { signal_filter_butterworth_sqrt(signal_filter_butterworth_var(data)) }

pub fn signal_filter_butterworth_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = signal_filter_butterworth_mean(a); let mb = signal_filter_butterworth_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn signal_filter_butterworth_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = signal_filter_butterworth_std(a); let sb = signal_filter_butterworth_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { signal_filter_butterworth_cov(a, b) / (sa * sb) }
}

pub fn signal_filter_butterworth_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = signal_filter_butterworth_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn signal_filter_butterworth_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn signal_filter_butterworth_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn signal_filter_butterworth_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  signal_filter_butterworth_sqrt(signal_filter_butterworth_mse(pred, labels))
}

pub fn signal_filter_butterworth_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + signal_filter_butterworth_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn signal_filter_butterworth_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = signal_filter_butterworth_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn signal_filter_butterworth_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn signal_filter_butterworth_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn signal_filter_butterworth_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = signal_filter_butterworth_precision(pred, labels, pos); let r = signal_filter_butterworth_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn signal_filter_butterworth_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn signal_filter_butterworth_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = signal_filter_butterworth_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn signal_filter_butterworth_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn signal_filter_butterworth_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn signal_filter_butterworth_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = signal_filter_butterworth_gcd(a, b)
    (a / g) * b
  }
}

pub fn signal_filter_butterworth_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn signal_filter_butterworth_fibonacci(n : Int) -> Int {
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

pub fn signal_filter_butterworth_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = signal_filter_butterworth_min(data); let mx = signal_filter_butterworth_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn signal_filter_butterworth_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = signal_filter_butterworth_mean(data); let sd = signal_filter_butterworth_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn signal_filter_butterworth_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn signal_filter_butterworth_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn signal_filter_butterworth_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn signal_filter_butterworth_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn signal_filter_butterworth_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn signal_filter_butterworth_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn signal_filter_butterworth_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn signal_filter_butterworth_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn signal_filter_butterworth_dbl(x : Double) -> String {
  let i = if x >= 0.0 { signal_filter_butterworth_int(x) } else { -signal_filter_butterworth_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { signal_filter_butterworth_int(f * 1000000.0) } else { signal_filter_butterworth_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn signal_filter_butterworth_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn signal_filter_butterworth_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct SignalfilterbutterworthFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_butterworth_frame_make(size : Int) -> SignalfilterbutterworthFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_butterworth_frame_len(s : SignalfilterbutterworthFrame) -> Int { s.size }

pub fn signal_filter_butterworth_frame_get(s : SignalfilterbutterworthFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_butterworth_frame_set(s : SignalfilterbutterworthFrame, i : Int, v : Double) -> SignalfilterbutterworthFrame {
  let result = signal_filter_butterworth_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_filter_butterworth_frame_sum(s : SignalfilterbutterworthFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_filter_butterworth_frame_mean(s : SignalfilterbutterworthFrame) -> Double {
  if s.size == 0 { 0.0 } else { signal_filter_butterworth_frame_sum(s) / s.size.to_double() }
}

pub fn signal_filter_butterworth_frame_scale(s : SignalfilterbutterworthFrame, f : Double) -> SignalfilterbutterworthFrame {
  let result = signal_filter_butterworth_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_filter_butterworth_frame_add(a : SignalfilterbutterworthFrame, b : SignalfilterbutterworthFrame) -> SignalfilterbutterworthFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_filter_butterworth_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_filter_butterworth_frame_copy(s : SignalfilterbutterworthFrame) -> SignalfilterbutterworthFrame {
  let result = signal_filter_butterworth_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_filter_butterworth_frame_fill(s : SignalfilterbutterworthFrame, v : Double) -> SignalfilterbutterworthFrame {
  let result = signal_filter_butterworth_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_filter_butterworth_frame_min(s : SignalfilterbutterworthFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_filter_butterworth_frame_max(s : SignalfilterbutterworthFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_filter_butterworth_frame_to_string(s : SignalfilterbutterworthFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilterbutterworthTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_butterworth_table_make(size : Int) -> SignalfilterbutterworthTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_butterworth_table_len(s : SignalfilterbutterworthTable) -> Int { s.size }

pub fn signal_filter_butterworth_table_get(s : SignalfilterbutterworthTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_butterworth_table_set(s : SignalfilterbutterworthTable, i : Int, v : Double) -> SignalfilterbutterworthTable {
  let result = signal_filter_butterworth_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_filter_butterworth_table_sum(s : SignalfilterbutterworthTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_filter_butterworth_table_mean(s : SignalfilterbutterworthTable) -> Double {
  if s.size == 0 { 0.0 } else { signal_filter_butterworth_table_sum(s) / s.size.to_double() }
}

pub fn signal_filter_butterworth_table_scale(s : SignalfilterbutterworthTable, f : Double) -> SignalfilterbutterworthTable {
  let result = signal_filter_butterworth_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_filter_butterworth_table_add(a : SignalfilterbutterworthTable, b : SignalfilterbutterworthTable) -> SignalfilterbutterworthTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_filter_butterworth_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_filter_butterworth_table_copy(s : SignalfilterbutterworthTable) -> SignalfilterbutterworthTable {
  let result = signal_filter_butterworth_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_filter_butterworth_table_fill(s : SignalfilterbutterworthTable, v : Double) -> SignalfilterbutterworthTable {
  let result = signal_filter_butterworth_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_filter_butterworth_table_min(s : SignalfilterbutterworthTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_filter_butterworth_table_max(s : SignalfilterbutterworthTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_filter_butterworth_table_to_string(s : SignalfilterbutterworthTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilterbutterworthGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_butterworth_graphn_make(size : Int) -> SignalfilterbutterworthGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_butterworth_graphn_len(s : SignalfilterbutterworthGraphN) -> Int { s.size }

pub fn signal_filter_butterworth_graphn_get(s : SignalfilterbutterworthGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_butterworth_graphn_set(s : SignalfilterbutterworthGraphN, i : Int, v : Double) -> SignalfilterbutterworthGraphN {
  let result = signal_filter_butterworth_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_filter_butterworth_graphn_sum(s : SignalfilterbutterworthGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_filter_butterworth_graphn_mean(s : SignalfilterbutterworthGraphN) -> Double {
  if s.size == 0 { 0.0 } else { signal_filter_butterworth_graphn_sum(s) / s.size.to_double() }
}

pub fn signal_filter_butterworth_graphn_scale(s : SignalfilterbutterworthGraphN, f : Double) -> SignalfilterbutterworthGraphN {
  let result = signal_filter_butterworth_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_filter_butterworth_graphn_add(a : SignalfilterbutterworthGraphN, b : SignalfilterbutterworthGraphN) -> SignalfilterbutterworthGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_filter_butterworth_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_filter_butterworth_graphn_copy(s : SignalfilterbutterworthGraphN) -> SignalfilterbutterworthGraphN {
  let result = signal_filter_butterworth_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_filter_butterworth_graphn_fill(s : SignalfilterbutterworthGraphN, v : Double) -> SignalfilterbutterworthGraphN {
  let result = signal_filter_butterworth_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_filter_butterworth_graphn_min(s : SignalfilterbutterworthGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_filter_butterworth_graphn_max(s : SignalfilterbutterworthGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_filter_butterworth_graphn_to_string(s : SignalfilterbutterworthGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilterbutterworthNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_butterworth_node_make(size : Int) -> SignalfilterbutterworthNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_butterworth_node_len(s : SignalfilterbutterworthNode) -> Int { s.size }

pub fn signal_filter_butterworth_node_get(s : SignalfilterbutterworthNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_butterworth_node_set(s : SignalfilterbutterworthNode, i : Int, v : Double) -> SignalfilterbutterworthNode {
  let result = signal_filter_butterworth_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_filter_butterworth_node_sum(s : SignalfilterbutterworthNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_filter_butterworth_node_mean(s : SignalfilterbutterworthNode) -> Double {
  if s.size == 0 { 0.0 } else { signal_filter_butterworth_node_sum(s) / s.size.to_double() }
}

pub fn signal_filter_butterworth_node_scale(s : SignalfilterbutterworthNode, f : Double) -> SignalfilterbutterworthNode {
  let result = signal_filter_butterworth_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_filter_butterworth_node_add(a : SignalfilterbutterworthNode, b : SignalfilterbutterworthNode) -> SignalfilterbutterworthNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_filter_butterworth_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_filter_butterworth_node_copy(s : SignalfilterbutterworthNode) -> SignalfilterbutterworthNode {
  let result = signal_filter_butterworth_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_filter_butterworth_node_fill(s : SignalfilterbutterworthNode, v : Double) -> SignalfilterbutterworthNode {
  let result = signal_filter_butterworth_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_filter_butterworth_node_min(s : SignalfilterbutterworthNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_filter_butterworth_node_max(s : SignalfilterbutterworthNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_filter_butterworth_node_to_string(s : SignalfilterbutterworthNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilterbutterworthEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_butterworth_edge_make(size : Int) -> SignalfilterbutterworthEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_butterworth_edge_len(s : SignalfilterbutterworthEdge) -> Int { s.size }

pub fn signal_filter_butterworth_edge_get(s : SignalfilterbutterworthEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_butterworth_edge_set(s : SignalfilterbutterworthEdge, i : Int, v : Double) -> SignalfilterbutterworthEdge {
  let result = signal_filter_butterworth_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_filter_butterworth_edge_sum(s : SignalfilterbutterworthEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_filter_butterworth_edge_mean(s : SignalfilterbutterworthEdge) -> Double {
  if s.size == 0 { 0.0 } else { signal_filter_butterworth_edge_sum(s) / s.size.to_double() }
}

pub fn signal_filter_butterworth_edge_scale(s : SignalfilterbutterworthEdge, f : Double) -> SignalfilterbutterworthEdge {
  let result = signal_filter_butterworth_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_filter_butterworth_edge_add(a : SignalfilterbutterworthEdge, b : SignalfilterbutterworthEdge) -> SignalfilterbutterworthEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_filter_butterworth_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_filter_butterworth_edge_copy(s : SignalfilterbutterworthEdge) -> SignalfilterbutterworthEdge {
  let result = signal_filter_butterworth_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_filter_butterworth_edge_fill(s : SignalfilterbutterworthEdge, v : Double) -> SignalfilterbutterworthEdge {
  let result = signal_filter_butterworth_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_filter_butterworth_edge_min(s : SignalfilterbutterworthEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_filter_butterworth_edge_max(s : SignalfilterbutterworthEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_filter_butterworth_edge_to_string(s : SignalfilterbutterworthEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilterbutterworthPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_butterworth_path_make(size : Int) -> SignalfilterbutterworthPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_butterworth_path_len(s : SignalfilterbutterworthPath) -> Int { s.size }

pub fn signal_filter_butterworth_path_get(s : SignalfilterbutterworthPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_butterworth_path_set(s : SignalfilterbutterworthPath, i : Int, v : Double) -> SignalfilterbutterworthPath {
  let result = signal_filter_butterworth_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_filter_butterworth_path_sum(s : SignalfilterbutterworthPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_filter_butterworth_path_mean(s : SignalfilterbutterworthPath) -> Double {
  if s.size == 0 { 0.0 } else { signal_filter_butterworth_path_sum(s) / s.size.to_double() }
}

pub fn signal_filter_butterworth_path_scale(s : SignalfilterbutterworthPath, f : Double) -> SignalfilterbutterworthPath {
  let result = signal_filter_butterworth_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_filter_butterworth_path_add(a : SignalfilterbutterworthPath, b : SignalfilterbutterworthPath) -> SignalfilterbutterworthPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_filter_butterworth_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_filter_butterworth_path_copy(s : SignalfilterbutterworthPath) -> SignalfilterbutterworthPath {
  let result = signal_filter_butterworth_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_filter_butterworth_path_fill(s : SignalfilterbutterworthPath, v : Double) -> SignalfilterbutterworthPath {
  let result = signal_filter_butterworth_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_filter_butterworth_path_min(s : SignalfilterbutterworthPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_filter_butterworth_path_max(s : SignalfilterbutterworthPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_filter_butterworth_path_to_string(s : SignalfilterbutterworthPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilterbutterworthCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_butterworth_cluster_make(size : Int) -> SignalfilterbutterworthCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_butterworth_cluster_len(s : SignalfilterbutterworthCluster) -> Int { s.size }

pub fn signal_filter_butterworth_cluster_get(s : SignalfilterbutterworthCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_butterworth_cluster_set(s : SignalfilterbutterworthCluster, i : Int, v : Double) -> SignalfilterbutterworthCluster {
  let result = signal_filter_butterworth_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_filter_butterworth_cluster_sum(s : SignalfilterbutterworthCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_filter_butterworth_cluster_mean(s : SignalfilterbutterworthCluster) -> Double {
  if s.size == 0 { 0.0 } else { signal_filter_butterworth_cluster_sum(s) / s.size.to_double() }
}

pub fn signal_filter_butterworth_cluster_scale(s : SignalfilterbutterworthCluster, f : Double) -> SignalfilterbutterworthCluster {
  let result = signal_filter_butterworth_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_filter_butterworth_cluster_add(a : SignalfilterbutterworthCluster, b : SignalfilterbutterworthCluster) -> SignalfilterbutterworthCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_filter_butterworth_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_filter_butterworth_cluster_copy(s : SignalfilterbutterworthCluster) -> SignalfilterbutterworthCluster {
  let result = signal_filter_butterworth_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_filter_butterworth_cluster_fill(s : SignalfilterbutterworthCluster, v : Double) -> SignalfilterbutterworthCluster {
  let result = signal_filter_butterworth_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_filter_butterworth_cluster_min(s : SignalfilterbutterworthCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_filter_butterworth_cluster_max(s : SignalfilterbutterworthCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_filter_butterworth_cluster_to_string(s : SignalfilterbutterworthCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilterbutterworthModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_butterworth_model_make(size : Int) -> SignalfilterbutterworthModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_butterworth_model_len(s : SignalfilterbutterworthModel) -> Int { s.size }

pub fn signal_filter_butterworth_model_get(s : SignalfilterbutterworthModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_butterworth_model_set(s : SignalfilterbutterworthModel, i : Int, v : Double) -> SignalfilterbutterworthModel {
  let result = signal_filter_butterworth_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_filter_butterworth_model_sum(s : SignalfilterbutterworthModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_filter_butterworth_model_mean(s : SignalfilterbutterworthModel) -> Double {
  if s.size == 0 { 0.0 } else { signal_filter_butterworth_model_sum(s) / s.size.to_double() }
}

pub fn signal_filter_butterworth_model_scale(s : SignalfilterbutterworthModel, f : Double) -> SignalfilterbutterworthModel {
  let result = signal_filter_butterworth_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_filter_butterworth_model_add(a : SignalfilterbutterworthModel, b : SignalfilterbutterworthModel) -> SignalfilterbutterworthModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_filter_butterworth_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_filter_butterworth_model_copy(s : SignalfilterbutterworthModel) -> SignalfilterbutterworthModel {
  let result = signal_filter_butterworth_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_filter_butterworth_model_fill(s : SignalfilterbutterworthModel, v : Double) -> SignalfilterbutterworthModel {
  let result = signal_filter_butterworth_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_filter_butterworth_model_min(s : SignalfilterbutterworthModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_filter_butterworth_model_max(s : SignalfilterbutterworthModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_filter_butterworth_model_to_string(s : SignalfilterbutterworthModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilterbutterworthLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_butterworth_layer_make(size : Int) -> SignalfilterbutterworthLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_butterworth_layer_len(s : SignalfilterbutterworthLayer) -> Int { s.size }

pub fn signal_filter_butterworth_layer_get(s : SignalfilterbutterworthLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_butterworth_layer_set(s : SignalfilterbutterworthLayer, i : Int, v : Double) -> SignalfilterbutterworthLayer {
  let result = signal_filter_butterworth_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_filter_butterworth_layer_sum(s : SignalfilterbutterworthLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_filter_butterworth_layer_mean(s : SignalfilterbutterworthLayer) -> Double {
  if s.size == 0 { 0.0 } else { signal_filter_butterworth_layer_sum(s) / s.size.to_double() }
}

pub fn signal_filter_butterworth_layer_scale(s : SignalfilterbutterworthLayer, f : Double) -> SignalfilterbutterworthLayer {
  let result = signal_filter_butterworth_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_filter_butterworth_layer_add(a : SignalfilterbutterworthLayer, b : SignalfilterbutterworthLayer) -> SignalfilterbutterworthLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_filter_butterworth_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_filter_butterworth_layer_copy(s : SignalfilterbutterworthLayer) -> SignalfilterbutterworthLayer {
  let result = signal_filter_butterworth_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_filter_butterworth_layer_fill(s : SignalfilterbutterworthLayer, v : Double) -> SignalfilterbutterworthLayer {
  let result = signal_filter_butterworth_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_filter_butterworth_layer_min(s : SignalfilterbutterworthLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_filter_butterworth_layer_max(s : SignalfilterbutterworthLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_filter_butterworth_layer_to_string(s : SignalfilterbutterworthLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilterbutterworthBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_butterworth_buffer_make(size : Int) -> SignalfilterbutterworthBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_butterworth_buffer_len(s : SignalfilterbutterworthBuffer) -> Int { s.size }

pub fn signal_filter_butterworth_buffer_get(s : SignalfilterbutterworthBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_butterworth_buffer_set(s : SignalfilterbutterworthBuffer, i : Int, v : Double) -> SignalfilterbutterworthBuffer {
  let result = signal_filter_butterworth_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_filter_butterworth_buffer_sum(s : SignalfilterbutterworthBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_filter_butterworth_buffer_mean(s : SignalfilterbutterworthBuffer) -> Double {
  if s.size == 0 { 0.0 } else { signal_filter_butterworth_buffer_sum(s) / s.size.to_double() }
}

pub fn signal_filter_butterworth_buffer_scale(s : SignalfilterbutterworthBuffer, f : Double) -> SignalfilterbutterworthBuffer {
  let result = signal_filter_butterworth_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_filter_butterworth_buffer_add(a : SignalfilterbutterworthBuffer, b : SignalfilterbutterworthBuffer) -> SignalfilterbutterworthBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_filter_butterworth_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_filter_butterworth_buffer_copy(s : SignalfilterbutterworthBuffer) -> SignalfilterbutterworthBuffer {
  let result = signal_filter_butterworth_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_filter_butterworth_buffer_fill(s : SignalfilterbutterworthBuffer, v : Double) -> SignalfilterbutterworthBuffer {
  let result = signal_filter_butterworth_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_filter_butterworth_buffer_min(s : SignalfilterbutterworthBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_filter_butterworth_buffer_max(s : SignalfilterbutterworthBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_filter_butterworth_buffer_to_string(s : SignalfilterbutterworthBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilterbutterworthCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_butterworth_cursor_make(size : Int) -> SignalfilterbutterworthCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_butterworth_cursor_len(s : SignalfilterbutterworthCursor) -> Int { s.size }

pub fn signal_filter_butterworth_cursor_get(s : SignalfilterbutterworthCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_butterworth_cursor_set(s : SignalfilterbutterworthCursor, i : Int, v : Double) -> SignalfilterbutterworthCursor {
  let result = signal_filter_butterworth_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_filter_butterworth_cursor_sum(s : SignalfilterbutterworthCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_filter_butterworth_cursor_mean(s : SignalfilterbutterworthCursor) -> Double {
  if s.size == 0 { 0.0 } else { signal_filter_butterworth_cursor_sum(s) / s.size.to_double() }
}

pub fn signal_filter_butterworth_cursor_scale(s : SignalfilterbutterworthCursor, f : Double) -> SignalfilterbutterworthCursor {
  let result = signal_filter_butterworth_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_filter_butterworth_cursor_add(a : SignalfilterbutterworthCursor, b : SignalfilterbutterworthCursor) -> SignalfilterbutterworthCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_filter_butterworth_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_filter_butterworth_cursor_copy(s : SignalfilterbutterworthCursor) -> SignalfilterbutterworthCursor {
  let result = signal_filter_butterworth_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_filter_butterworth_cursor_fill(s : SignalfilterbutterworthCursor, v : Double) -> SignalfilterbutterworthCursor {
  let result = signal_filter_butterworth_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_filter_butterworth_cursor_min(s : SignalfilterbutterworthCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_filter_butterworth_cursor_max(s : SignalfilterbutterworthCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_filter_butterworth_cursor_to_string(s : SignalfilterbutterworthCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilterbutterworthView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_butterworth_view_make(size : Int) -> SignalfilterbutterworthView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_butterworth_view_len(s : SignalfilterbutterworthView) -> Int { s.size }

pub fn signal_filter_butterworth_view_get(s : SignalfilterbutterworthView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_butterworth_view_set(s : SignalfilterbutterworthView, i : Int, v : Double) -> SignalfilterbutterworthView {
  let result = signal_filter_butterworth_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_filter_butterworth_view_sum(s : SignalfilterbutterworthView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_filter_butterworth_view_mean(s : SignalfilterbutterworthView) -> Double {
  if s.size == 0 { 0.0 } else { signal_filter_butterworth_view_sum(s) / s.size.to_double() }
}

pub fn signal_filter_butterworth_view_scale(s : SignalfilterbutterworthView, f : Double) -> SignalfilterbutterworthView {
  let result = signal_filter_butterworth_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_filter_butterworth_view_add(a : SignalfilterbutterworthView, b : SignalfilterbutterworthView) -> SignalfilterbutterworthView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_filter_butterworth_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_filter_butterworth_view_copy(s : SignalfilterbutterworthView) -> SignalfilterbutterworthView {
  let result = signal_filter_butterworth_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_filter_butterworth_view_fill(s : SignalfilterbutterworthView, v : Double) -> SignalfilterbutterworthView {
  let result = signal_filter_butterworth_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_filter_butterworth_view_min(s : SignalfilterbutterworthView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_filter_butterworth_view_max(s : SignalfilterbutterworthView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_filter_butterworth_view_to_string(s : SignalfilterbutterworthView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilterbutterworthRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_butterworth_range_make(size : Int) -> SignalfilterbutterworthRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_butterworth_range_len(s : SignalfilterbutterworthRange) -> Int { s.size }

pub fn signal_filter_butterworth_range_get(s : SignalfilterbutterworthRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_butterworth_range_set(s : SignalfilterbutterworthRange, i : Int, v : Double) -> SignalfilterbutterworthRange {
  let result = signal_filter_butterworth_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_filter_butterworth_range_sum(s : SignalfilterbutterworthRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_filter_butterworth_range_mean(s : SignalfilterbutterworthRange) -> Double {
  if s.size == 0 { 0.0 } else { signal_filter_butterworth_range_sum(s) / s.size.to_double() }
}

pub fn signal_filter_butterworth_range_scale(s : SignalfilterbutterworthRange, f : Double) -> SignalfilterbutterworthRange {
  let result = signal_filter_butterworth_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_filter_butterworth_range_add(a : SignalfilterbutterworthRange, b : SignalfilterbutterworthRange) -> SignalfilterbutterworthRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_filter_butterworth_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_filter_butterworth_range_copy(s : SignalfilterbutterworthRange) -> SignalfilterbutterworthRange {
  let result = signal_filter_butterworth_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_filter_butterworth_range_fill(s : SignalfilterbutterworthRange, v : Double) -> SignalfilterbutterworthRange {
  let result = signal_filter_butterworth_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_filter_butterworth_range_min(s : SignalfilterbutterworthRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_filter_butterworth_range_max(s : SignalfilterbutterworthRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_filter_butterworth_range_to_string(s : SignalfilterbutterworthRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilterbutterworthSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_butterworth_slice_make(size : Int) -> SignalfilterbutterworthSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_butterworth_slice_len(s : SignalfilterbutterworthSlice) -> Int { s.size }

pub fn signal_filter_butterworth_slice_get(s : SignalfilterbutterworthSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_butterworth_slice_set(s : SignalfilterbutterworthSlice, i : Int, v : Double) -> SignalfilterbutterworthSlice {
  let result = signal_filter_butterworth_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_filter_butterworth_slice_sum(s : SignalfilterbutterworthSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_filter_butterworth_slice_mean(s : SignalfilterbutterworthSlice) -> Double {
  if s.size == 0 { 0.0 } else { signal_filter_butterworth_slice_sum(s) / s.size.to_double() }
}

pub fn signal_filter_butterworth_slice_scale(s : SignalfilterbutterworthSlice, f : Double) -> SignalfilterbutterworthSlice {
  let result = signal_filter_butterworth_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_filter_butterworth_slice_add(a : SignalfilterbutterworthSlice, b : SignalfilterbutterworthSlice) -> SignalfilterbutterworthSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_filter_butterworth_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_filter_butterworth_slice_copy(s : SignalfilterbutterworthSlice) -> SignalfilterbutterworthSlice {
  let result = signal_filter_butterworth_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_filter_butterworth_slice_fill(s : SignalfilterbutterworthSlice, v : Double) -> SignalfilterbutterworthSlice {
  let result = signal_filter_butterworth_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_filter_butterworth_slice_min(s : SignalfilterbutterworthSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_filter_butterworth_slice_max(s : SignalfilterbutterworthSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_filter_butterworth_slice_to_string(s : SignalfilterbutterworthSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn signal_filter_butterworth_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_filter_butterworth_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_filter_butterworth_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_filter_butterworth_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_filter_butterworth_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_filter_butterworth_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_filter_butterworth_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_filter_butterworth_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_filter_butterworth_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_filter_butterworth_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_filter_butterworth_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_filter_butterworth_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_filter_butterworth_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_filter_butterworth_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_filter_butterworth_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_filter_butterworth_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_filter_butterworth_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_filter_butterworth_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_filter_butterworth_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_filter_butterworth_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_filter_butterworth_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_filter_butterworth_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_filter_butterworth_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_filter_butterworth_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_filter_butterworth_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

