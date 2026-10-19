///===
/// extcore/signal_transform_hilbert

pub(all) struct SignaltransformhilbertPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn signal_transform_hilbert_make_point(x : Double, y : Double) -> SignaltransformhilbertPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn signal_transform_hilbert_make_point3(x : Double, y : Double, z : Double) -> SignaltransformhilbertPoint {
  { x, y, z, label: 0 }
}

pub fn signal_transform_hilbert_point_x(pt : SignaltransformhilbertPoint) -> Double { pt.x }

pub fn signal_transform_hilbert_point_y(pt : SignaltransformhilbertPoint) -> Double { pt.y }

pub fn signal_transform_hilbert_point_z(pt : SignaltransformhilbertPoint) -> Double { pt.z }

pub fn signal_transform_hilbert_point_label(pt : SignaltransformhilbertPoint) -> Int { pt.label }

pub fn signal_transform_hilbert_point_dist(a : SignaltransformhilbertPoint, b : SignaltransformhilbertPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  signal_transform_hilbert_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn signal_transform_hilbert_point_add(a : SignaltransformhilbertPoint, b : SignaltransformhilbertPoint) -> SignaltransformhilbertPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn signal_transform_hilbert_point_sub(a : SignaltransformhilbertPoint, b : SignaltransformhilbertPoint) -> SignaltransformhilbertPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn signal_transform_hilbert_point_scale(pt : SignaltransformhilbertPoint, s : Double) -> SignaltransformhilbertPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn signal_transform_hilbert_point_dot(a : SignaltransformhilbertPoint, b : SignaltransformhilbertPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn signal_transform_hilbert_point_cross(a : SignaltransformhilbertPoint, b : SignaltransformhilbertPoint) -> SignaltransformhilbertPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn signal_transform_hilbert_point_norm(pt : SignaltransformhilbertPoint) -> Double {
  signal_transform_hilbert_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn signal_transform_hilbert_point_normalize(pt : SignaltransformhilbertPoint) -> SignaltransformhilbertPoint {
  let n = signal_transform_hilbert_point_norm(pt)
  if n < 0.0000001 { pt } else { signal_transform_hilbert_point_scale(pt, 1.0 / n) }
}

pub fn signal_transform_hilbert_point_negate(pt : SignaltransformhilbertPoint) -> SignaltransformhilbertPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn signal_transform_hilbert_point_mid(a : SignaltransformhilbertPoint, b : SignaltransformhilbertPoint) -> SignaltransformhilbertPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn signal_transform_hilbert_point_lerp(a : SignaltransformhilbertPoint, b : SignaltransformhilbertPoint, t : Double) -> SignaltransformhilbertPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn signal_transform_hilbert_point_to_string(pt : SignaltransformhilbertPoint) -> String {
  "(" + signal_transform_hilbert_dbl(pt.x) + ", " + signal_transform_hilbert_dbl(pt.y) + ", " + signal_transform_hilbert_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct SignaltransformhilbertSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn signal_transform_hilbert_make_series(vals : Array[Double], name : String) -> SignaltransformhilbertSeries {
  { vals, name, meta: 0 }
}

pub fn signal_transform_hilbert_series_len(s : SignaltransformhilbertSeries) -> Int { s.vals.length() }

pub fn signal_transform_hilbert_series_sum(s : SignaltransformhilbertSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn signal_transform_hilbert_series_mean(s : SignaltransformhilbertSeries) -> Double {
  let n = signal_transform_hilbert_series_len(s)
  if n == 0 { 0.0 } else { signal_transform_hilbert_series_sum(s) / n.to_double() }
}

pub fn signal_transform_hilbert_series_min(s : SignaltransformhilbertSeries) -> Double {
  let n = signal_transform_hilbert_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn signal_transform_hilbert_series_max(s : SignaltransformhilbertSeries) -> Double {
  let n = signal_transform_hilbert_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn signal_transform_hilbert_series_range(s : SignaltransformhilbertSeries) -> Double {
  signal_transform_hilbert_series_max(s) - signal_transform_hilbert_series_min(s)
}

pub fn signal_transform_hilbert_series_var(s : SignaltransformhilbertSeries) -> Double {
  let n = signal_transform_hilbert_series_len(s)
  if n == 0 { 0.0 } else {
    let m = signal_transform_hilbert_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn signal_transform_hilbert_series_std(s : SignaltransformhilbertSeries) -> Double { signal_transform_hilbert_sqrt(signal_transform_hilbert_series_var(s)) }

pub fn signal_transform_hilbert_series_median(s : SignaltransformhilbertSeries) -> Double {
  let n = signal_transform_hilbert_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = signal_transform_hilbert_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn signal_transform_hilbert_series_scale(s : SignaltransformhilbertSeries, f : Double) -> SignaltransformhilbertSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = signal_transform_hilbert_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn signal_transform_hilbert_series_add(a : SignaltransformhilbertSeries, b : SignaltransformhilbertSeries) -> SignaltransformhilbertSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = signal_transform_hilbert_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn signal_transform_hilbert_series_sub(a : SignaltransformhilbertSeries, b : SignaltransformhilbertSeries) -> SignaltransformhilbertSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = signal_transform_hilbert_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn signal_transform_hilbert_series_normalize(s : SignaltransformhilbertSeries) -> SignaltransformhilbertSeries {
  let mn = signal_transform_hilbert_series_min(s)
  let mx = signal_transform_hilbert_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = signal_transform_hilbert_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn signal_transform_hilbert_series_cumsum(s : SignaltransformhilbertSeries) -> SignaltransformhilbertSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = signal_transform_hilbert_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn signal_transform_hilbert_series_to_string(s : SignaltransformhilbertSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + signal_transform_hilbert_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SignaltransformhilbertMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn signal_transform_hilbert_make_matrix(rows : Int, cols : Int, val : Double) -> SignaltransformhilbertMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn signal_transform_hilbert_matrix_identity(n : Int) -> SignaltransformhilbertMatrix {
  let m = signal_transform_hilbert_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn signal_transform_hilbert_matrix_get(m : SignaltransformhilbertMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn signal_transform_hilbert_matrix_transpose(m : SignaltransformhilbertMatrix) -> SignaltransformhilbertMatrix {
  let result = signal_transform_hilbert_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn signal_transform_hilbert_matrix_add(a : SignaltransformhilbertMatrix, b : SignaltransformhilbertMatrix) -> SignaltransformhilbertMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = signal_transform_hilbert_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn signal_transform_hilbert_matrix_scale(m : SignaltransformhilbertMatrix, s : Double) -> SignaltransformhilbertMatrix {
  let result = signal_transform_hilbert_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn signal_transform_hilbert_matrix_multiply(a : SignaltransformhilbertMatrix, b : SignaltransformhilbertMatrix) -> SignaltransformhilbertMatrix {
  if a.cols != b.rows { return signal_transform_hilbert_make_matrix(a.rows, b.cols, 0.0) }
  let result = signal_transform_hilbert_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn signal_transform_hilbert_matrix_trace(m : SignaltransformhilbertMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn signal_transform_hilbert_matrix_det(m : SignaltransformhilbertMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn signal_transform_hilbert_matrix_norm(m : SignaltransformhilbertMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  signal_transform_hilbert_sqrt(sum)
}

pub fn signal_transform_hilbert_matrix_to_string(m : SignaltransformhilbertMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + signal_transform_hilbert_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct SignaltransformhilbertVector {
  comps : Array[Double]
  dim : Int
}

pub fn signal_transform_hilbert_make_vector(comps : Array[Double]) -> SignaltransformhilbertVector {
  { comps, dim: comps.length() }
}

pub fn signal_transform_hilbert_vector_zero(dim : Int) -> SignaltransformhilbertVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn signal_transform_hilbert_vector_add(a : SignaltransformhilbertVector, b : SignaltransformhilbertVector) -> SignaltransformhilbertVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = signal_transform_hilbert_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn signal_transform_hilbert_vector_sub(a : SignaltransformhilbertVector, b : SignaltransformhilbertVector) -> SignaltransformhilbertVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = signal_transform_hilbert_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn signal_transform_hilbert_vector_scale(v : SignaltransformhilbertVector, s : Double) -> SignaltransformhilbertVector {
  let mut result = []
  for i in 0..<v.dim { result = signal_transform_hilbert_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn signal_transform_hilbert_vector_dot(a : SignaltransformhilbertVector, b : SignaltransformhilbertVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn signal_transform_hilbert_vector_norm(v : SignaltransformhilbertVector) -> Double { signal_transform_hilbert_sqrt(signal_transform_hilbert_vector_dot(v, v)) }

pub fn signal_transform_hilbert_vector_normalize(v : SignaltransformhilbertVector) -> SignaltransformhilbertVector {
  let n = signal_transform_hilbert_vector_norm(v)
  if n < 0.0000001 { v } else { signal_transform_hilbert_vector_scale(v, 1.0 / n) }
}

pub fn signal_transform_hilbert_vector_dist(a : SignaltransformhilbertVector, b : SignaltransformhilbertVector) -> Double {
  signal_transform_hilbert_vector_norm(signal_transform_hilbert_vector_sub(a, b))
}

pub fn signal_transform_hilbert_vector_to_string(v : SignaltransformhilbertVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + signal_transform_hilbert_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn signal_transform_hilbert_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn signal_transform_hilbert_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = signal_transform_hilbert_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn signal_transform_hilbert_std(data : Array[Double]) -> Double { signal_transform_hilbert_sqrt(signal_transform_hilbert_var(data)) }

pub fn signal_transform_hilbert_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = signal_transform_hilbert_mean(a); let mb = signal_transform_hilbert_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn signal_transform_hilbert_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = signal_transform_hilbert_std(a); let sb = signal_transform_hilbert_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { signal_transform_hilbert_cov(a, b) / (sa * sb) }
}

pub fn signal_transform_hilbert_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = signal_transform_hilbert_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn signal_transform_hilbert_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn signal_transform_hilbert_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn signal_transform_hilbert_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  signal_transform_hilbert_sqrt(signal_transform_hilbert_mse(pred, labels))
}

pub fn signal_transform_hilbert_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + signal_transform_hilbert_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn signal_transform_hilbert_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = signal_transform_hilbert_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn signal_transform_hilbert_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn signal_transform_hilbert_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn signal_transform_hilbert_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = signal_transform_hilbert_precision(pred, labels, pos); let r = signal_transform_hilbert_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn signal_transform_hilbert_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn signal_transform_hilbert_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = signal_transform_hilbert_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn signal_transform_hilbert_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn signal_transform_hilbert_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn signal_transform_hilbert_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = signal_transform_hilbert_gcd(a, b)
    (a / g) * b
  }
}

pub fn signal_transform_hilbert_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn signal_transform_hilbert_fibonacci(n : Int) -> Int {
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

pub fn signal_transform_hilbert_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = signal_transform_hilbert_min(data); let mx = signal_transform_hilbert_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn signal_transform_hilbert_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = signal_transform_hilbert_mean(data); let sd = signal_transform_hilbert_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn signal_transform_hilbert_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn signal_transform_hilbert_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn signal_transform_hilbert_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn signal_transform_hilbert_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn signal_transform_hilbert_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn signal_transform_hilbert_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn signal_transform_hilbert_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn signal_transform_hilbert_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn signal_transform_hilbert_dbl(x : Double) -> String {
  let i = if x >= 0.0 { signal_transform_hilbert_int(x) } else { -signal_transform_hilbert_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { signal_transform_hilbert_int(f * 1000000.0) } else { signal_transform_hilbert_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn signal_transform_hilbert_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn signal_transform_hilbert_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct SignaltransformhilbertFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_hilbert_frame_make(size : Int) -> SignaltransformhilbertFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_hilbert_frame_len(s : SignaltransformhilbertFrame) -> Int { s.size }

pub fn signal_transform_hilbert_frame_get(s : SignaltransformhilbertFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_hilbert_frame_set(s : SignaltransformhilbertFrame, i : Int, v : Double) -> SignaltransformhilbertFrame {
  let result = signal_transform_hilbert_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_transform_hilbert_frame_sum(s : SignaltransformhilbertFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_transform_hilbert_frame_mean(s : SignaltransformhilbertFrame) -> Double {
  if s.size == 0 { 0.0 } else { signal_transform_hilbert_frame_sum(s) / s.size.to_double() }
}

pub fn signal_transform_hilbert_frame_scale(s : SignaltransformhilbertFrame, f : Double) -> SignaltransformhilbertFrame {
  let result = signal_transform_hilbert_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_transform_hilbert_frame_add(a : SignaltransformhilbertFrame, b : SignaltransformhilbertFrame) -> SignaltransformhilbertFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_transform_hilbert_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_transform_hilbert_frame_copy(s : SignaltransformhilbertFrame) -> SignaltransformhilbertFrame {
  let result = signal_transform_hilbert_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_transform_hilbert_frame_fill(s : SignaltransformhilbertFrame, v : Double) -> SignaltransformhilbertFrame {
  let result = signal_transform_hilbert_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_transform_hilbert_frame_min(s : SignaltransformhilbertFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_hilbert_frame_max(s : SignaltransformhilbertFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_hilbert_frame_to_string(s : SignaltransformhilbertFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformhilbertTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_hilbert_table_make(size : Int) -> SignaltransformhilbertTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_hilbert_table_len(s : SignaltransformhilbertTable) -> Int { s.size }

pub fn signal_transform_hilbert_table_get(s : SignaltransformhilbertTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_hilbert_table_set(s : SignaltransformhilbertTable, i : Int, v : Double) -> SignaltransformhilbertTable {
  let result = signal_transform_hilbert_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_transform_hilbert_table_sum(s : SignaltransformhilbertTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_transform_hilbert_table_mean(s : SignaltransformhilbertTable) -> Double {
  if s.size == 0 { 0.0 } else { signal_transform_hilbert_table_sum(s) / s.size.to_double() }
}

pub fn signal_transform_hilbert_table_scale(s : SignaltransformhilbertTable, f : Double) -> SignaltransformhilbertTable {
  let result = signal_transform_hilbert_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_transform_hilbert_table_add(a : SignaltransformhilbertTable, b : SignaltransformhilbertTable) -> SignaltransformhilbertTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_transform_hilbert_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_transform_hilbert_table_copy(s : SignaltransformhilbertTable) -> SignaltransformhilbertTable {
  let result = signal_transform_hilbert_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_transform_hilbert_table_fill(s : SignaltransformhilbertTable, v : Double) -> SignaltransformhilbertTable {
  let result = signal_transform_hilbert_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_transform_hilbert_table_min(s : SignaltransformhilbertTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_hilbert_table_max(s : SignaltransformhilbertTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_hilbert_table_to_string(s : SignaltransformhilbertTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformhilbertGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_hilbert_graphn_make(size : Int) -> SignaltransformhilbertGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_hilbert_graphn_len(s : SignaltransformhilbertGraphN) -> Int { s.size }

pub fn signal_transform_hilbert_graphn_get(s : SignaltransformhilbertGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_hilbert_graphn_set(s : SignaltransformhilbertGraphN, i : Int, v : Double) -> SignaltransformhilbertGraphN {
  let result = signal_transform_hilbert_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_transform_hilbert_graphn_sum(s : SignaltransformhilbertGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_transform_hilbert_graphn_mean(s : SignaltransformhilbertGraphN) -> Double {
  if s.size == 0 { 0.0 } else { signal_transform_hilbert_graphn_sum(s) / s.size.to_double() }
}

pub fn signal_transform_hilbert_graphn_scale(s : SignaltransformhilbertGraphN, f : Double) -> SignaltransformhilbertGraphN {
  let result = signal_transform_hilbert_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_transform_hilbert_graphn_add(a : SignaltransformhilbertGraphN, b : SignaltransformhilbertGraphN) -> SignaltransformhilbertGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_transform_hilbert_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_transform_hilbert_graphn_copy(s : SignaltransformhilbertGraphN) -> SignaltransformhilbertGraphN {
  let result = signal_transform_hilbert_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_transform_hilbert_graphn_fill(s : SignaltransformhilbertGraphN, v : Double) -> SignaltransformhilbertGraphN {
  let result = signal_transform_hilbert_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_transform_hilbert_graphn_min(s : SignaltransformhilbertGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_hilbert_graphn_max(s : SignaltransformhilbertGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_hilbert_graphn_to_string(s : SignaltransformhilbertGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformhilbertNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_hilbert_node_make(size : Int) -> SignaltransformhilbertNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_hilbert_node_len(s : SignaltransformhilbertNode) -> Int { s.size }

pub fn signal_transform_hilbert_node_get(s : SignaltransformhilbertNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_hilbert_node_set(s : SignaltransformhilbertNode, i : Int, v : Double) -> SignaltransformhilbertNode {
  let result = signal_transform_hilbert_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_transform_hilbert_node_sum(s : SignaltransformhilbertNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_transform_hilbert_node_mean(s : SignaltransformhilbertNode) -> Double {
  if s.size == 0 { 0.0 } else { signal_transform_hilbert_node_sum(s) / s.size.to_double() }
}

pub fn signal_transform_hilbert_node_scale(s : SignaltransformhilbertNode, f : Double) -> SignaltransformhilbertNode {
  let result = signal_transform_hilbert_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_transform_hilbert_node_add(a : SignaltransformhilbertNode, b : SignaltransformhilbertNode) -> SignaltransformhilbertNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_transform_hilbert_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_transform_hilbert_node_copy(s : SignaltransformhilbertNode) -> SignaltransformhilbertNode {
  let result = signal_transform_hilbert_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_transform_hilbert_node_fill(s : SignaltransformhilbertNode, v : Double) -> SignaltransformhilbertNode {
  let result = signal_transform_hilbert_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_transform_hilbert_node_min(s : SignaltransformhilbertNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_hilbert_node_max(s : SignaltransformhilbertNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_hilbert_node_to_string(s : SignaltransformhilbertNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformhilbertEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_hilbert_edge_make(size : Int) -> SignaltransformhilbertEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_hilbert_edge_len(s : SignaltransformhilbertEdge) -> Int { s.size }

pub fn signal_transform_hilbert_edge_get(s : SignaltransformhilbertEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_hilbert_edge_set(s : SignaltransformhilbertEdge, i : Int, v : Double) -> SignaltransformhilbertEdge {
  let result = signal_transform_hilbert_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_transform_hilbert_edge_sum(s : SignaltransformhilbertEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_transform_hilbert_edge_mean(s : SignaltransformhilbertEdge) -> Double {
  if s.size == 0 { 0.0 } else { signal_transform_hilbert_edge_sum(s) / s.size.to_double() }
}

pub fn signal_transform_hilbert_edge_scale(s : SignaltransformhilbertEdge, f : Double) -> SignaltransformhilbertEdge {
  let result = signal_transform_hilbert_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_transform_hilbert_edge_add(a : SignaltransformhilbertEdge, b : SignaltransformhilbertEdge) -> SignaltransformhilbertEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_transform_hilbert_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_transform_hilbert_edge_copy(s : SignaltransformhilbertEdge) -> SignaltransformhilbertEdge {
  let result = signal_transform_hilbert_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_transform_hilbert_edge_fill(s : SignaltransformhilbertEdge, v : Double) -> SignaltransformhilbertEdge {
  let result = signal_transform_hilbert_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_transform_hilbert_edge_min(s : SignaltransformhilbertEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_hilbert_edge_max(s : SignaltransformhilbertEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_hilbert_edge_to_string(s : SignaltransformhilbertEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformhilbertPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_hilbert_path_make(size : Int) -> SignaltransformhilbertPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_hilbert_path_len(s : SignaltransformhilbertPath) -> Int { s.size }

pub fn signal_transform_hilbert_path_get(s : SignaltransformhilbertPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_hilbert_path_set(s : SignaltransformhilbertPath, i : Int, v : Double) -> SignaltransformhilbertPath {
  let result = signal_transform_hilbert_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_transform_hilbert_path_sum(s : SignaltransformhilbertPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_transform_hilbert_path_mean(s : SignaltransformhilbertPath) -> Double {
  if s.size == 0 { 0.0 } else { signal_transform_hilbert_path_sum(s) / s.size.to_double() }
}

pub fn signal_transform_hilbert_path_scale(s : SignaltransformhilbertPath, f : Double) -> SignaltransformhilbertPath {
  let result = signal_transform_hilbert_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_transform_hilbert_path_add(a : SignaltransformhilbertPath, b : SignaltransformhilbertPath) -> SignaltransformhilbertPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_transform_hilbert_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_transform_hilbert_path_copy(s : SignaltransformhilbertPath) -> SignaltransformhilbertPath {
  let result = signal_transform_hilbert_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_transform_hilbert_path_fill(s : SignaltransformhilbertPath, v : Double) -> SignaltransformhilbertPath {
  let result = signal_transform_hilbert_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_transform_hilbert_path_min(s : SignaltransformhilbertPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_hilbert_path_max(s : SignaltransformhilbertPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_hilbert_path_to_string(s : SignaltransformhilbertPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformhilbertCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_hilbert_cluster_make(size : Int) -> SignaltransformhilbertCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_hilbert_cluster_len(s : SignaltransformhilbertCluster) -> Int { s.size }

pub fn signal_transform_hilbert_cluster_get(s : SignaltransformhilbertCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_hilbert_cluster_set(s : SignaltransformhilbertCluster, i : Int, v : Double) -> SignaltransformhilbertCluster {
  let result = signal_transform_hilbert_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_transform_hilbert_cluster_sum(s : SignaltransformhilbertCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_transform_hilbert_cluster_mean(s : SignaltransformhilbertCluster) -> Double {
  if s.size == 0 { 0.0 } else { signal_transform_hilbert_cluster_sum(s) / s.size.to_double() }
}

pub fn signal_transform_hilbert_cluster_scale(s : SignaltransformhilbertCluster, f : Double) -> SignaltransformhilbertCluster {
  let result = signal_transform_hilbert_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_transform_hilbert_cluster_add(a : SignaltransformhilbertCluster, b : SignaltransformhilbertCluster) -> SignaltransformhilbertCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_transform_hilbert_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_transform_hilbert_cluster_copy(s : SignaltransformhilbertCluster) -> SignaltransformhilbertCluster {
  let result = signal_transform_hilbert_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_transform_hilbert_cluster_fill(s : SignaltransformhilbertCluster, v : Double) -> SignaltransformhilbertCluster {
  let result = signal_transform_hilbert_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_transform_hilbert_cluster_min(s : SignaltransformhilbertCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_hilbert_cluster_max(s : SignaltransformhilbertCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_hilbert_cluster_to_string(s : SignaltransformhilbertCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformhilbertModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_hilbert_model_make(size : Int) -> SignaltransformhilbertModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_hilbert_model_len(s : SignaltransformhilbertModel) -> Int { s.size }

pub fn signal_transform_hilbert_model_get(s : SignaltransformhilbertModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_hilbert_model_set(s : SignaltransformhilbertModel, i : Int, v : Double) -> SignaltransformhilbertModel {
  let result = signal_transform_hilbert_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_transform_hilbert_model_sum(s : SignaltransformhilbertModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_transform_hilbert_model_mean(s : SignaltransformhilbertModel) -> Double {
  if s.size == 0 { 0.0 } else { signal_transform_hilbert_model_sum(s) / s.size.to_double() }
}

pub fn signal_transform_hilbert_model_scale(s : SignaltransformhilbertModel, f : Double) -> SignaltransformhilbertModel {
  let result = signal_transform_hilbert_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_transform_hilbert_model_add(a : SignaltransformhilbertModel, b : SignaltransformhilbertModel) -> SignaltransformhilbertModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_transform_hilbert_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_transform_hilbert_model_copy(s : SignaltransformhilbertModel) -> SignaltransformhilbertModel {
  let result = signal_transform_hilbert_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_transform_hilbert_model_fill(s : SignaltransformhilbertModel, v : Double) -> SignaltransformhilbertModel {
  let result = signal_transform_hilbert_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_transform_hilbert_model_min(s : SignaltransformhilbertModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_hilbert_model_max(s : SignaltransformhilbertModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_hilbert_model_to_string(s : SignaltransformhilbertModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformhilbertLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_hilbert_layer_make(size : Int) -> SignaltransformhilbertLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_hilbert_layer_len(s : SignaltransformhilbertLayer) -> Int { s.size }

pub fn signal_transform_hilbert_layer_get(s : SignaltransformhilbertLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_hilbert_layer_set(s : SignaltransformhilbertLayer, i : Int, v : Double) -> SignaltransformhilbertLayer {
  let result = signal_transform_hilbert_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_transform_hilbert_layer_sum(s : SignaltransformhilbertLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_transform_hilbert_layer_mean(s : SignaltransformhilbertLayer) -> Double {
  if s.size == 0 { 0.0 } else { signal_transform_hilbert_layer_sum(s) / s.size.to_double() }
}

pub fn signal_transform_hilbert_layer_scale(s : SignaltransformhilbertLayer, f : Double) -> SignaltransformhilbertLayer {
  let result = signal_transform_hilbert_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_transform_hilbert_layer_add(a : SignaltransformhilbertLayer, b : SignaltransformhilbertLayer) -> SignaltransformhilbertLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_transform_hilbert_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_transform_hilbert_layer_copy(s : SignaltransformhilbertLayer) -> SignaltransformhilbertLayer {
  let result = signal_transform_hilbert_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_transform_hilbert_layer_fill(s : SignaltransformhilbertLayer, v : Double) -> SignaltransformhilbertLayer {
  let result = signal_transform_hilbert_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_transform_hilbert_layer_min(s : SignaltransformhilbertLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_hilbert_layer_max(s : SignaltransformhilbertLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_hilbert_layer_to_string(s : SignaltransformhilbertLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformhilbertBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_hilbert_buffer_make(size : Int) -> SignaltransformhilbertBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_hilbert_buffer_len(s : SignaltransformhilbertBuffer) -> Int { s.size }

pub fn signal_transform_hilbert_buffer_get(s : SignaltransformhilbertBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_hilbert_buffer_set(s : SignaltransformhilbertBuffer, i : Int, v : Double) -> SignaltransformhilbertBuffer {
  let result = signal_transform_hilbert_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_transform_hilbert_buffer_sum(s : SignaltransformhilbertBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_transform_hilbert_buffer_mean(s : SignaltransformhilbertBuffer) -> Double {
  if s.size == 0 { 0.0 } else { signal_transform_hilbert_buffer_sum(s) / s.size.to_double() }
}

pub fn signal_transform_hilbert_buffer_scale(s : SignaltransformhilbertBuffer, f : Double) -> SignaltransformhilbertBuffer {
  let result = signal_transform_hilbert_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_transform_hilbert_buffer_add(a : SignaltransformhilbertBuffer, b : SignaltransformhilbertBuffer) -> SignaltransformhilbertBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_transform_hilbert_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_transform_hilbert_buffer_copy(s : SignaltransformhilbertBuffer) -> SignaltransformhilbertBuffer {
  let result = signal_transform_hilbert_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_transform_hilbert_buffer_fill(s : SignaltransformhilbertBuffer, v : Double) -> SignaltransformhilbertBuffer {
  let result = signal_transform_hilbert_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_transform_hilbert_buffer_min(s : SignaltransformhilbertBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_hilbert_buffer_max(s : SignaltransformhilbertBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_hilbert_buffer_to_string(s : SignaltransformhilbertBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformhilbertCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_hilbert_cursor_make(size : Int) -> SignaltransformhilbertCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_hilbert_cursor_len(s : SignaltransformhilbertCursor) -> Int { s.size }

pub fn signal_transform_hilbert_cursor_get(s : SignaltransformhilbertCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_hilbert_cursor_set(s : SignaltransformhilbertCursor, i : Int, v : Double) -> SignaltransformhilbertCursor {
  let result = signal_transform_hilbert_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_transform_hilbert_cursor_sum(s : SignaltransformhilbertCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_transform_hilbert_cursor_mean(s : SignaltransformhilbertCursor) -> Double {
  if s.size == 0 { 0.0 } else { signal_transform_hilbert_cursor_sum(s) / s.size.to_double() }
}

pub fn signal_transform_hilbert_cursor_scale(s : SignaltransformhilbertCursor, f : Double) -> SignaltransformhilbertCursor {
  let result = signal_transform_hilbert_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_transform_hilbert_cursor_add(a : SignaltransformhilbertCursor, b : SignaltransformhilbertCursor) -> SignaltransformhilbertCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_transform_hilbert_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_transform_hilbert_cursor_copy(s : SignaltransformhilbertCursor) -> SignaltransformhilbertCursor {
  let result = signal_transform_hilbert_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_transform_hilbert_cursor_fill(s : SignaltransformhilbertCursor, v : Double) -> SignaltransformhilbertCursor {
  let result = signal_transform_hilbert_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_transform_hilbert_cursor_min(s : SignaltransformhilbertCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_hilbert_cursor_max(s : SignaltransformhilbertCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_hilbert_cursor_to_string(s : SignaltransformhilbertCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformhilbertView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_hilbert_view_make(size : Int) -> SignaltransformhilbertView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_hilbert_view_len(s : SignaltransformhilbertView) -> Int { s.size }

pub fn signal_transform_hilbert_view_get(s : SignaltransformhilbertView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_hilbert_view_set(s : SignaltransformhilbertView, i : Int, v : Double) -> SignaltransformhilbertView {
  let result = signal_transform_hilbert_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_transform_hilbert_view_sum(s : SignaltransformhilbertView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_transform_hilbert_view_mean(s : SignaltransformhilbertView) -> Double {
  if s.size == 0 { 0.0 } else { signal_transform_hilbert_view_sum(s) / s.size.to_double() }
}

pub fn signal_transform_hilbert_view_scale(s : SignaltransformhilbertView, f : Double) -> SignaltransformhilbertView {
  let result = signal_transform_hilbert_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_transform_hilbert_view_add(a : SignaltransformhilbertView, b : SignaltransformhilbertView) -> SignaltransformhilbertView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_transform_hilbert_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_transform_hilbert_view_copy(s : SignaltransformhilbertView) -> SignaltransformhilbertView {
  let result = signal_transform_hilbert_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_transform_hilbert_view_fill(s : SignaltransformhilbertView, v : Double) -> SignaltransformhilbertView {
  let result = signal_transform_hilbert_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_transform_hilbert_view_min(s : SignaltransformhilbertView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_hilbert_view_max(s : SignaltransformhilbertView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_hilbert_view_to_string(s : SignaltransformhilbertView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformhilbertRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_hilbert_range_make(size : Int) -> SignaltransformhilbertRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_hilbert_range_len(s : SignaltransformhilbertRange) -> Int { s.size }

pub fn signal_transform_hilbert_range_get(s : SignaltransformhilbertRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_hilbert_range_set(s : SignaltransformhilbertRange, i : Int, v : Double) -> SignaltransformhilbertRange {
  let result = signal_transform_hilbert_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_transform_hilbert_range_sum(s : SignaltransformhilbertRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_transform_hilbert_range_mean(s : SignaltransformhilbertRange) -> Double {
  if s.size == 0 { 0.0 } else { signal_transform_hilbert_range_sum(s) / s.size.to_double() }
}

pub fn signal_transform_hilbert_range_scale(s : SignaltransformhilbertRange, f : Double) -> SignaltransformhilbertRange {
  let result = signal_transform_hilbert_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_transform_hilbert_range_add(a : SignaltransformhilbertRange, b : SignaltransformhilbertRange) -> SignaltransformhilbertRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_transform_hilbert_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_transform_hilbert_range_copy(s : SignaltransformhilbertRange) -> SignaltransformhilbertRange {
  let result = signal_transform_hilbert_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_transform_hilbert_range_fill(s : SignaltransformhilbertRange, v : Double) -> SignaltransformhilbertRange {
  let result = signal_transform_hilbert_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_transform_hilbert_range_min(s : SignaltransformhilbertRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_hilbert_range_max(s : SignaltransformhilbertRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_hilbert_range_to_string(s : SignaltransformhilbertRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformhilbertSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_hilbert_slice_make(size : Int) -> SignaltransformhilbertSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_hilbert_slice_len(s : SignaltransformhilbertSlice) -> Int { s.size }

pub fn signal_transform_hilbert_slice_get(s : SignaltransformhilbertSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_hilbert_slice_set(s : SignaltransformhilbertSlice, i : Int, v : Double) -> SignaltransformhilbertSlice {
  let result = signal_transform_hilbert_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_transform_hilbert_slice_sum(s : SignaltransformhilbertSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_transform_hilbert_slice_mean(s : SignaltransformhilbertSlice) -> Double {
  if s.size == 0 { 0.0 } else { signal_transform_hilbert_slice_sum(s) / s.size.to_double() }
}

pub fn signal_transform_hilbert_slice_scale(s : SignaltransformhilbertSlice, f : Double) -> SignaltransformhilbertSlice {
  let result = signal_transform_hilbert_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_transform_hilbert_slice_add(a : SignaltransformhilbertSlice, b : SignaltransformhilbertSlice) -> SignaltransformhilbertSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_transform_hilbert_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_transform_hilbert_slice_copy(s : SignaltransformhilbertSlice) -> SignaltransformhilbertSlice {
  let result = signal_transform_hilbert_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_transform_hilbert_slice_fill(s : SignaltransformhilbertSlice, v : Double) -> SignaltransformhilbertSlice {
  let result = signal_transform_hilbert_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_transform_hilbert_slice_min(s : SignaltransformhilbertSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_hilbert_slice_max(s : SignaltransformhilbertSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_hilbert_slice_to_string(s : SignaltransformhilbertSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn signal_transform_hilbert_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_transform_hilbert_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_transform_hilbert_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_transform_hilbert_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_transform_hilbert_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_transform_hilbert_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_transform_hilbert_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_transform_hilbert_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_transform_hilbert_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_transform_hilbert_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_transform_hilbert_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_transform_hilbert_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_transform_hilbert_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_transform_hilbert_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_transform_hilbert_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_transform_hilbert_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_transform_hilbert_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_transform_hilbert_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_transform_hilbert_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_transform_hilbert_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_transform_hilbert_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_transform_hilbert_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_transform_hilbert_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_transform_hilbert_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_transform_hilbert_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

