///===
/// extcore/signal_transform_chirp

pub(all) struct SignaltransformchirpPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn signal_transform_chirp_make_point(x : Double, y : Double) -> SignaltransformchirpPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn signal_transform_chirp_make_point3(x : Double, y : Double, z : Double) -> SignaltransformchirpPoint {
  { x, y, z, label: 0 }
}

pub fn signal_transform_chirp_point_x(pt : SignaltransformchirpPoint) -> Double { pt.x }

pub fn signal_transform_chirp_point_y(pt : SignaltransformchirpPoint) -> Double { pt.y }

pub fn signal_transform_chirp_point_z(pt : SignaltransformchirpPoint) -> Double { pt.z }

pub fn signal_transform_chirp_point_label(pt : SignaltransformchirpPoint) -> Int { pt.label }

pub fn signal_transform_chirp_point_dist(a : SignaltransformchirpPoint, b : SignaltransformchirpPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  signal_transform_chirp_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn signal_transform_chirp_point_add(a : SignaltransformchirpPoint, b : SignaltransformchirpPoint) -> SignaltransformchirpPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn signal_transform_chirp_point_sub(a : SignaltransformchirpPoint, b : SignaltransformchirpPoint) -> SignaltransformchirpPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn signal_transform_chirp_point_scale(pt : SignaltransformchirpPoint, s : Double) -> SignaltransformchirpPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn signal_transform_chirp_point_dot(a : SignaltransformchirpPoint, b : SignaltransformchirpPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn signal_transform_chirp_point_cross(a : SignaltransformchirpPoint, b : SignaltransformchirpPoint) -> SignaltransformchirpPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn signal_transform_chirp_point_norm(pt : SignaltransformchirpPoint) -> Double {
  signal_transform_chirp_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn signal_transform_chirp_point_normalize(pt : SignaltransformchirpPoint) -> SignaltransformchirpPoint {
  let n = signal_transform_chirp_point_norm(pt)
  if n < 0.0000001 { pt } else { signal_transform_chirp_point_scale(pt, 1.0 / n) }
}

pub fn signal_transform_chirp_point_negate(pt : SignaltransformchirpPoint) -> SignaltransformchirpPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn signal_transform_chirp_point_mid(a : SignaltransformchirpPoint, b : SignaltransformchirpPoint) -> SignaltransformchirpPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn signal_transform_chirp_point_lerp(a : SignaltransformchirpPoint, b : SignaltransformchirpPoint, t : Double) -> SignaltransformchirpPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn signal_transform_chirp_point_to_string(pt : SignaltransformchirpPoint) -> String {
  "(" + signal_transform_chirp_dbl(pt.x) + ", " + signal_transform_chirp_dbl(pt.y) + ", " + signal_transform_chirp_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct SignaltransformchirpSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn signal_transform_chirp_make_series(vals : Array[Double], name : String) -> SignaltransformchirpSeries {
  { vals, name, meta: 0 }
}

pub fn signal_transform_chirp_series_len(s : SignaltransformchirpSeries) -> Int { s.vals.length() }

pub fn signal_transform_chirp_series_sum(s : SignaltransformchirpSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn signal_transform_chirp_series_mean(s : SignaltransformchirpSeries) -> Double {
  let n = signal_transform_chirp_series_len(s)
  if n == 0 { 0.0 } else { signal_transform_chirp_series_sum(s) / n.to_double() }
}

pub fn signal_transform_chirp_series_min(s : SignaltransformchirpSeries) -> Double {
  let n = signal_transform_chirp_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn signal_transform_chirp_series_max(s : SignaltransformchirpSeries) -> Double {
  let n = signal_transform_chirp_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn signal_transform_chirp_series_range(s : SignaltransformchirpSeries) -> Double {
  signal_transform_chirp_series_max(s) - signal_transform_chirp_series_min(s)
}

pub fn signal_transform_chirp_series_var(s : SignaltransformchirpSeries) -> Double {
  let n = signal_transform_chirp_series_len(s)
  if n == 0 { 0.0 } else {
    let m = signal_transform_chirp_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn signal_transform_chirp_series_std(s : SignaltransformchirpSeries) -> Double { signal_transform_chirp_sqrt(signal_transform_chirp_series_var(s)) }

pub fn signal_transform_chirp_series_median(s : SignaltransformchirpSeries) -> Double {
  let n = signal_transform_chirp_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = signal_transform_chirp_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn signal_transform_chirp_series_scale(s : SignaltransformchirpSeries, f : Double) -> SignaltransformchirpSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = signal_transform_chirp_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn signal_transform_chirp_series_add(a : SignaltransformchirpSeries, b : SignaltransformchirpSeries) -> SignaltransformchirpSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = signal_transform_chirp_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn signal_transform_chirp_series_sub(a : SignaltransformchirpSeries, b : SignaltransformchirpSeries) -> SignaltransformchirpSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = signal_transform_chirp_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn signal_transform_chirp_series_normalize(s : SignaltransformchirpSeries) -> SignaltransformchirpSeries {
  let mn = signal_transform_chirp_series_min(s)
  let mx = signal_transform_chirp_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = signal_transform_chirp_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn signal_transform_chirp_series_cumsum(s : SignaltransformchirpSeries) -> SignaltransformchirpSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = signal_transform_chirp_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn signal_transform_chirp_series_to_string(s : SignaltransformchirpSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + signal_transform_chirp_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SignaltransformchirpMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn signal_transform_chirp_make_matrix(rows : Int, cols : Int, val : Double) -> SignaltransformchirpMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn signal_transform_chirp_matrix_identity(n : Int) -> SignaltransformchirpMatrix {
  let m = signal_transform_chirp_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn signal_transform_chirp_matrix_get(m : SignaltransformchirpMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn signal_transform_chirp_matrix_transpose(m : SignaltransformchirpMatrix) -> SignaltransformchirpMatrix {
  let result = signal_transform_chirp_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn signal_transform_chirp_matrix_add(a : SignaltransformchirpMatrix, b : SignaltransformchirpMatrix) -> SignaltransformchirpMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = signal_transform_chirp_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn signal_transform_chirp_matrix_scale(m : SignaltransformchirpMatrix, s : Double) -> SignaltransformchirpMatrix {
  let result = signal_transform_chirp_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn signal_transform_chirp_matrix_multiply(a : SignaltransformchirpMatrix, b : SignaltransformchirpMatrix) -> SignaltransformchirpMatrix {
  if a.cols != b.rows { return signal_transform_chirp_make_matrix(a.rows, b.cols, 0.0) }
  let result = signal_transform_chirp_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn signal_transform_chirp_matrix_trace(m : SignaltransformchirpMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn signal_transform_chirp_matrix_det(m : SignaltransformchirpMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn signal_transform_chirp_matrix_norm(m : SignaltransformchirpMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  signal_transform_chirp_sqrt(sum)
}

pub fn signal_transform_chirp_matrix_to_string(m : SignaltransformchirpMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + signal_transform_chirp_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct SignaltransformchirpVector {
  comps : Array[Double]
  dim : Int
}

pub fn signal_transform_chirp_make_vector(comps : Array[Double]) -> SignaltransformchirpVector {
  { comps, dim: comps.length() }
}

pub fn signal_transform_chirp_vector_zero(dim : Int) -> SignaltransformchirpVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn signal_transform_chirp_vector_add(a : SignaltransformchirpVector, b : SignaltransformchirpVector) -> SignaltransformchirpVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = signal_transform_chirp_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn signal_transform_chirp_vector_sub(a : SignaltransformchirpVector, b : SignaltransformchirpVector) -> SignaltransformchirpVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = signal_transform_chirp_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn signal_transform_chirp_vector_scale(v : SignaltransformchirpVector, s : Double) -> SignaltransformchirpVector {
  let mut result = []
  for i in 0..<v.dim { result = signal_transform_chirp_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn signal_transform_chirp_vector_dot(a : SignaltransformchirpVector, b : SignaltransformchirpVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn signal_transform_chirp_vector_norm(v : SignaltransformchirpVector) -> Double { signal_transform_chirp_sqrt(signal_transform_chirp_vector_dot(v, v)) }

pub fn signal_transform_chirp_vector_normalize(v : SignaltransformchirpVector) -> SignaltransformchirpVector {
  let n = signal_transform_chirp_vector_norm(v)
  if n < 0.0000001 { v } else { signal_transform_chirp_vector_scale(v, 1.0 / n) }
}

pub fn signal_transform_chirp_vector_dist(a : SignaltransformchirpVector, b : SignaltransformchirpVector) -> Double {
  signal_transform_chirp_vector_norm(signal_transform_chirp_vector_sub(a, b))
}

pub fn signal_transform_chirp_vector_to_string(v : SignaltransformchirpVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + signal_transform_chirp_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn signal_transform_chirp_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn signal_transform_chirp_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = signal_transform_chirp_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn signal_transform_chirp_std(data : Array[Double]) -> Double { signal_transform_chirp_sqrt(signal_transform_chirp_var(data)) }

pub fn signal_transform_chirp_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = signal_transform_chirp_mean(a); let mb = signal_transform_chirp_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn signal_transform_chirp_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = signal_transform_chirp_std(a); let sb = signal_transform_chirp_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { signal_transform_chirp_cov(a, b) / (sa * sb) }
}

pub fn signal_transform_chirp_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = signal_transform_chirp_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn signal_transform_chirp_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn signal_transform_chirp_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn signal_transform_chirp_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  signal_transform_chirp_sqrt(signal_transform_chirp_mse(pred, labels))
}

pub fn signal_transform_chirp_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + signal_transform_chirp_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn signal_transform_chirp_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = signal_transform_chirp_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn signal_transform_chirp_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn signal_transform_chirp_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn signal_transform_chirp_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = signal_transform_chirp_precision(pred, labels, pos); let r = signal_transform_chirp_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn signal_transform_chirp_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn signal_transform_chirp_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = signal_transform_chirp_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn signal_transform_chirp_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn signal_transform_chirp_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn signal_transform_chirp_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = signal_transform_chirp_gcd(a, b)
    (a / g) * b
  }
}

pub fn signal_transform_chirp_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn signal_transform_chirp_fibonacci(n : Int) -> Int {
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

pub fn signal_transform_chirp_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = signal_transform_chirp_min(data); let mx = signal_transform_chirp_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn signal_transform_chirp_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = signal_transform_chirp_mean(data); let sd = signal_transform_chirp_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn signal_transform_chirp_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn signal_transform_chirp_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn signal_transform_chirp_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn signal_transform_chirp_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn signal_transform_chirp_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn signal_transform_chirp_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn signal_transform_chirp_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn signal_transform_chirp_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn signal_transform_chirp_dbl(x : Double) -> String {
  let i = if x >= 0.0 { signal_transform_chirp_int(x) } else { -signal_transform_chirp_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { signal_transform_chirp_int(f * 1000000.0) } else { signal_transform_chirp_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn signal_transform_chirp_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn signal_transform_chirp_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct SignaltransformchirpFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_chirp_frame_make(size : Int) -> SignaltransformchirpFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_chirp_frame_len(s : SignaltransformchirpFrame) -> Int { s.size }

pub fn signal_transform_chirp_frame_get(s : SignaltransformchirpFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_chirp_frame_set(s : SignaltransformchirpFrame, i : Int, v : Double) -> SignaltransformchirpFrame {
  let result = signal_transform_chirp_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_transform_chirp_frame_sum(s : SignaltransformchirpFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_transform_chirp_frame_mean(s : SignaltransformchirpFrame) -> Double {
  if s.size == 0 { 0.0 } else { signal_transform_chirp_frame_sum(s) / s.size.to_double() }
}

pub fn signal_transform_chirp_frame_scale(s : SignaltransformchirpFrame, f : Double) -> SignaltransformchirpFrame {
  let result = signal_transform_chirp_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_transform_chirp_frame_add(a : SignaltransformchirpFrame, b : SignaltransformchirpFrame) -> SignaltransformchirpFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_transform_chirp_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_transform_chirp_frame_copy(s : SignaltransformchirpFrame) -> SignaltransformchirpFrame {
  let result = signal_transform_chirp_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_transform_chirp_frame_fill(s : SignaltransformchirpFrame, v : Double) -> SignaltransformchirpFrame {
  let result = signal_transform_chirp_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_transform_chirp_frame_min(s : SignaltransformchirpFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_chirp_frame_max(s : SignaltransformchirpFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_chirp_frame_to_string(s : SignaltransformchirpFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformchirpTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_chirp_table_make(size : Int) -> SignaltransformchirpTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_chirp_table_len(s : SignaltransformchirpTable) -> Int { s.size }

pub fn signal_transform_chirp_table_get(s : SignaltransformchirpTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_chirp_table_set(s : SignaltransformchirpTable, i : Int, v : Double) -> SignaltransformchirpTable {
  let result = signal_transform_chirp_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_transform_chirp_table_sum(s : SignaltransformchirpTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_transform_chirp_table_mean(s : SignaltransformchirpTable) -> Double {
  if s.size == 0 { 0.0 } else { signal_transform_chirp_table_sum(s) / s.size.to_double() }
}

pub fn signal_transform_chirp_table_scale(s : SignaltransformchirpTable, f : Double) -> SignaltransformchirpTable {
  let result = signal_transform_chirp_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_transform_chirp_table_add(a : SignaltransformchirpTable, b : SignaltransformchirpTable) -> SignaltransformchirpTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_transform_chirp_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_transform_chirp_table_copy(s : SignaltransformchirpTable) -> SignaltransformchirpTable {
  let result = signal_transform_chirp_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_transform_chirp_table_fill(s : SignaltransformchirpTable, v : Double) -> SignaltransformchirpTable {
  let result = signal_transform_chirp_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_transform_chirp_table_min(s : SignaltransformchirpTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_chirp_table_max(s : SignaltransformchirpTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_chirp_table_to_string(s : SignaltransformchirpTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformchirpGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_chirp_graphn_make(size : Int) -> SignaltransformchirpGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_chirp_graphn_len(s : SignaltransformchirpGraphN) -> Int { s.size }

pub fn signal_transform_chirp_graphn_get(s : SignaltransformchirpGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_chirp_graphn_set(s : SignaltransformchirpGraphN, i : Int, v : Double) -> SignaltransformchirpGraphN {
  let result = signal_transform_chirp_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_transform_chirp_graphn_sum(s : SignaltransformchirpGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_transform_chirp_graphn_mean(s : SignaltransformchirpGraphN) -> Double {
  if s.size == 0 { 0.0 } else { signal_transform_chirp_graphn_sum(s) / s.size.to_double() }
}

pub fn signal_transform_chirp_graphn_scale(s : SignaltransformchirpGraphN, f : Double) -> SignaltransformchirpGraphN {
  let result = signal_transform_chirp_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_transform_chirp_graphn_add(a : SignaltransformchirpGraphN, b : SignaltransformchirpGraphN) -> SignaltransformchirpGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_transform_chirp_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_transform_chirp_graphn_copy(s : SignaltransformchirpGraphN) -> SignaltransformchirpGraphN {
  let result = signal_transform_chirp_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_transform_chirp_graphn_fill(s : SignaltransformchirpGraphN, v : Double) -> SignaltransformchirpGraphN {
  let result = signal_transform_chirp_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_transform_chirp_graphn_min(s : SignaltransformchirpGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_chirp_graphn_max(s : SignaltransformchirpGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_chirp_graphn_to_string(s : SignaltransformchirpGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformchirpNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_chirp_node_make(size : Int) -> SignaltransformchirpNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_chirp_node_len(s : SignaltransformchirpNode) -> Int { s.size }

pub fn signal_transform_chirp_node_get(s : SignaltransformchirpNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_chirp_node_set(s : SignaltransformchirpNode, i : Int, v : Double) -> SignaltransformchirpNode {
  let result = signal_transform_chirp_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_transform_chirp_node_sum(s : SignaltransformchirpNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_transform_chirp_node_mean(s : SignaltransformchirpNode) -> Double {
  if s.size == 0 { 0.0 } else { signal_transform_chirp_node_sum(s) / s.size.to_double() }
}

pub fn signal_transform_chirp_node_scale(s : SignaltransformchirpNode, f : Double) -> SignaltransformchirpNode {
  let result = signal_transform_chirp_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_transform_chirp_node_add(a : SignaltransformchirpNode, b : SignaltransformchirpNode) -> SignaltransformchirpNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_transform_chirp_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_transform_chirp_node_copy(s : SignaltransformchirpNode) -> SignaltransformchirpNode {
  let result = signal_transform_chirp_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_transform_chirp_node_fill(s : SignaltransformchirpNode, v : Double) -> SignaltransformchirpNode {
  let result = signal_transform_chirp_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_transform_chirp_node_min(s : SignaltransformchirpNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_chirp_node_max(s : SignaltransformchirpNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_chirp_node_to_string(s : SignaltransformchirpNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformchirpEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_chirp_edge_make(size : Int) -> SignaltransformchirpEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_chirp_edge_len(s : SignaltransformchirpEdge) -> Int { s.size }

pub fn signal_transform_chirp_edge_get(s : SignaltransformchirpEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_chirp_edge_set(s : SignaltransformchirpEdge, i : Int, v : Double) -> SignaltransformchirpEdge {
  let result = signal_transform_chirp_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_transform_chirp_edge_sum(s : SignaltransformchirpEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_transform_chirp_edge_mean(s : SignaltransformchirpEdge) -> Double {
  if s.size == 0 { 0.0 } else { signal_transform_chirp_edge_sum(s) / s.size.to_double() }
}

pub fn signal_transform_chirp_edge_scale(s : SignaltransformchirpEdge, f : Double) -> SignaltransformchirpEdge {
  let result = signal_transform_chirp_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_transform_chirp_edge_add(a : SignaltransformchirpEdge, b : SignaltransformchirpEdge) -> SignaltransformchirpEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_transform_chirp_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_transform_chirp_edge_copy(s : SignaltransformchirpEdge) -> SignaltransformchirpEdge {
  let result = signal_transform_chirp_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_transform_chirp_edge_fill(s : SignaltransformchirpEdge, v : Double) -> SignaltransformchirpEdge {
  let result = signal_transform_chirp_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_transform_chirp_edge_min(s : SignaltransformchirpEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_chirp_edge_max(s : SignaltransformchirpEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_chirp_edge_to_string(s : SignaltransformchirpEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformchirpPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_chirp_path_make(size : Int) -> SignaltransformchirpPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_chirp_path_len(s : SignaltransformchirpPath) -> Int { s.size }

pub fn signal_transform_chirp_path_get(s : SignaltransformchirpPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_chirp_path_set(s : SignaltransformchirpPath, i : Int, v : Double) -> SignaltransformchirpPath {
  let result = signal_transform_chirp_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_transform_chirp_path_sum(s : SignaltransformchirpPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_transform_chirp_path_mean(s : SignaltransformchirpPath) -> Double {
  if s.size == 0 { 0.0 } else { signal_transform_chirp_path_sum(s) / s.size.to_double() }
}

pub fn signal_transform_chirp_path_scale(s : SignaltransformchirpPath, f : Double) -> SignaltransformchirpPath {
  let result = signal_transform_chirp_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_transform_chirp_path_add(a : SignaltransformchirpPath, b : SignaltransformchirpPath) -> SignaltransformchirpPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_transform_chirp_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_transform_chirp_path_copy(s : SignaltransformchirpPath) -> SignaltransformchirpPath {
  let result = signal_transform_chirp_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_transform_chirp_path_fill(s : SignaltransformchirpPath, v : Double) -> SignaltransformchirpPath {
  let result = signal_transform_chirp_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_transform_chirp_path_min(s : SignaltransformchirpPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_chirp_path_max(s : SignaltransformchirpPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_chirp_path_to_string(s : SignaltransformchirpPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformchirpCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_chirp_cluster_make(size : Int) -> SignaltransformchirpCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_chirp_cluster_len(s : SignaltransformchirpCluster) -> Int { s.size }

pub fn signal_transform_chirp_cluster_get(s : SignaltransformchirpCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_chirp_cluster_set(s : SignaltransformchirpCluster, i : Int, v : Double) -> SignaltransformchirpCluster {
  let result = signal_transform_chirp_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_transform_chirp_cluster_sum(s : SignaltransformchirpCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_transform_chirp_cluster_mean(s : SignaltransformchirpCluster) -> Double {
  if s.size == 0 { 0.0 } else { signal_transform_chirp_cluster_sum(s) / s.size.to_double() }
}

pub fn signal_transform_chirp_cluster_scale(s : SignaltransformchirpCluster, f : Double) -> SignaltransformchirpCluster {
  let result = signal_transform_chirp_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_transform_chirp_cluster_add(a : SignaltransformchirpCluster, b : SignaltransformchirpCluster) -> SignaltransformchirpCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_transform_chirp_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_transform_chirp_cluster_copy(s : SignaltransformchirpCluster) -> SignaltransformchirpCluster {
  let result = signal_transform_chirp_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_transform_chirp_cluster_fill(s : SignaltransformchirpCluster, v : Double) -> SignaltransformchirpCluster {
  let result = signal_transform_chirp_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_transform_chirp_cluster_min(s : SignaltransformchirpCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_chirp_cluster_max(s : SignaltransformchirpCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_chirp_cluster_to_string(s : SignaltransformchirpCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformchirpModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_chirp_model_make(size : Int) -> SignaltransformchirpModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_chirp_model_len(s : SignaltransformchirpModel) -> Int { s.size }

pub fn signal_transform_chirp_model_get(s : SignaltransformchirpModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_chirp_model_set(s : SignaltransformchirpModel, i : Int, v : Double) -> SignaltransformchirpModel {
  let result = signal_transform_chirp_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_transform_chirp_model_sum(s : SignaltransformchirpModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_transform_chirp_model_mean(s : SignaltransformchirpModel) -> Double {
  if s.size == 0 { 0.0 } else { signal_transform_chirp_model_sum(s) / s.size.to_double() }
}

pub fn signal_transform_chirp_model_scale(s : SignaltransformchirpModel, f : Double) -> SignaltransformchirpModel {
  let result = signal_transform_chirp_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_transform_chirp_model_add(a : SignaltransformchirpModel, b : SignaltransformchirpModel) -> SignaltransformchirpModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_transform_chirp_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_transform_chirp_model_copy(s : SignaltransformchirpModel) -> SignaltransformchirpModel {
  let result = signal_transform_chirp_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_transform_chirp_model_fill(s : SignaltransformchirpModel, v : Double) -> SignaltransformchirpModel {
  let result = signal_transform_chirp_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_transform_chirp_model_min(s : SignaltransformchirpModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_chirp_model_max(s : SignaltransformchirpModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_chirp_model_to_string(s : SignaltransformchirpModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformchirpLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_chirp_layer_make(size : Int) -> SignaltransformchirpLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_chirp_layer_len(s : SignaltransformchirpLayer) -> Int { s.size }

pub fn signal_transform_chirp_layer_get(s : SignaltransformchirpLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_chirp_layer_set(s : SignaltransformchirpLayer, i : Int, v : Double) -> SignaltransformchirpLayer {
  let result = signal_transform_chirp_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_transform_chirp_layer_sum(s : SignaltransformchirpLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_transform_chirp_layer_mean(s : SignaltransformchirpLayer) -> Double {
  if s.size == 0 { 0.0 } else { signal_transform_chirp_layer_sum(s) / s.size.to_double() }
}

pub fn signal_transform_chirp_layer_scale(s : SignaltransformchirpLayer, f : Double) -> SignaltransformchirpLayer {
  let result = signal_transform_chirp_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_transform_chirp_layer_add(a : SignaltransformchirpLayer, b : SignaltransformchirpLayer) -> SignaltransformchirpLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_transform_chirp_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_transform_chirp_layer_copy(s : SignaltransformchirpLayer) -> SignaltransformchirpLayer {
  let result = signal_transform_chirp_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_transform_chirp_layer_fill(s : SignaltransformchirpLayer, v : Double) -> SignaltransformchirpLayer {
  let result = signal_transform_chirp_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_transform_chirp_layer_min(s : SignaltransformchirpLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_chirp_layer_max(s : SignaltransformchirpLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_chirp_layer_to_string(s : SignaltransformchirpLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformchirpBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_chirp_buffer_make(size : Int) -> SignaltransformchirpBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_chirp_buffer_len(s : SignaltransformchirpBuffer) -> Int { s.size }

pub fn signal_transform_chirp_buffer_get(s : SignaltransformchirpBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_chirp_buffer_set(s : SignaltransformchirpBuffer, i : Int, v : Double) -> SignaltransformchirpBuffer {
  let result = signal_transform_chirp_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_transform_chirp_buffer_sum(s : SignaltransformchirpBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_transform_chirp_buffer_mean(s : SignaltransformchirpBuffer) -> Double {
  if s.size == 0 { 0.0 } else { signal_transform_chirp_buffer_sum(s) / s.size.to_double() }
}

pub fn signal_transform_chirp_buffer_scale(s : SignaltransformchirpBuffer, f : Double) -> SignaltransformchirpBuffer {
  let result = signal_transform_chirp_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_transform_chirp_buffer_add(a : SignaltransformchirpBuffer, b : SignaltransformchirpBuffer) -> SignaltransformchirpBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_transform_chirp_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_transform_chirp_buffer_copy(s : SignaltransformchirpBuffer) -> SignaltransformchirpBuffer {
  let result = signal_transform_chirp_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_transform_chirp_buffer_fill(s : SignaltransformchirpBuffer, v : Double) -> SignaltransformchirpBuffer {
  let result = signal_transform_chirp_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_transform_chirp_buffer_min(s : SignaltransformchirpBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_chirp_buffer_max(s : SignaltransformchirpBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_chirp_buffer_to_string(s : SignaltransformchirpBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformchirpCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_chirp_cursor_make(size : Int) -> SignaltransformchirpCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_chirp_cursor_len(s : SignaltransformchirpCursor) -> Int { s.size }

pub fn signal_transform_chirp_cursor_get(s : SignaltransformchirpCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_chirp_cursor_set(s : SignaltransformchirpCursor, i : Int, v : Double) -> SignaltransformchirpCursor {
  let result = signal_transform_chirp_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_transform_chirp_cursor_sum(s : SignaltransformchirpCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_transform_chirp_cursor_mean(s : SignaltransformchirpCursor) -> Double {
  if s.size == 0 { 0.0 } else { signal_transform_chirp_cursor_sum(s) / s.size.to_double() }
}

pub fn signal_transform_chirp_cursor_scale(s : SignaltransformchirpCursor, f : Double) -> SignaltransformchirpCursor {
  let result = signal_transform_chirp_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_transform_chirp_cursor_add(a : SignaltransformchirpCursor, b : SignaltransformchirpCursor) -> SignaltransformchirpCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_transform_chirp_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_transform_chirp_cursor_copy(s : SignaltransformchirpCursor) -> SignaltransformchirpCursor {
  let result = signal_transform_chirp_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_transform_chirp_cursor_fill(s : SignaltransformchirpCursor, v : Double) -> SignaltransformchirpCursor {
  let result = signal_transform_chirp_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_transform_chirp_cursor_min(s : SignaltransformchirpCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_chirp_cursor_max(s : SignaltransformchirpCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_chirp_cursor_to_string(s : SignaltransformchirpCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformchirpView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_chirp_view_make(size : Int) -> SignaltransformchirpView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_chirp_view_len(s : SignaltransformchirpView) -> Int { s.size }

pub fn signal_transform_chirp_view_get(s : SignaltransformchirpView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_chirp_view_set(s : SignaltransformchirpView, i : Int, v : Double) -> SignaltransformchirpView {
  let result = signal_transform_chirp_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_transform_chirp_view_sum(s : SignaltransformchirpView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_transform_chirp_view_mean(s : SignaltransformchirpView) -> Double {
  if s.size == 0 { 0.0 } else { signal_transform_chirp_view_sum(s) / s.size.to_double() }
}

pub fn signal_transform_chirp_view_scale(s : SignaltransformchirpView, f : Double) -> SignaltransformchirpView {
  let result = signal_transform_chirp_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_transform_chirp_view_add(a : SignaltransformchirpView, b : SignaltransformchirpView) -> SignaltransformchirpView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_transform_chirp_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_transform_chirp_view_copy(s : SignaltransformchirpView) -> SignaltransformchirpView {
  let result = signal_transform_chirp_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_transform_chirp_view_fill(s : SignaltransformchirpView, v : Double) -> SignaltransformchirpView {
  let result = signal_transform_chirp_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_transform_chirp_view_min(s : SignaltransformchirpView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_chirp_view_max(s : SignaltransformchirpView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_chirp_view_to_string(s : SignaltransformchirpView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformchirpRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_chirp_range_make(size : Int) -> SignaltransformchirpRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_chirp_range_len(s : SignaltransformchirpRange) -> Int { s.size }

pub fn signal_transform_chirp_range_get(s : SignaltransformchirpRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_chirp_range_set(s : SignaltransformchirpRange, i : Int, v : Double) -> SignaltransformchirpRange {
  let result = signal_transform_chirp_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_transform_chirp_range_sum(s : SignaltransformchirpRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_transform_chirp_range_mean(s : SignaltransformchirpRange) -> Double {
  if s.size == 0 { 0.0 } else { signal_transform_chirp_range_sum(s) / s.size.to_double() }
}

pub fn signal_transform_chirp_range_scale(s : SignaltransformchirpRange, f : Double) -> SignaltransformchirpRange {
  let result = signal_transform_chirp_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_transform_chirp_range_add(a : SignaltransformchirpRange, b : SignaltransformchirpRange) -> SignaltransformchirpRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_transform_chirp_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_transform_chirp_range_copy(s : SignaltransformchirpRange) -> SignaltransformchirpRange {
  let result = signal_transform_chirp_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_transform_chirp_range_fill(s : SignaltransformchirpRange, v : Double) -> SignaltransformchirpRange {
  let result = signal_transform_chirp_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_transform_chirp_range_min(s : SignaltransformchirpRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_chirp_range_max(s : SignaltransformchirpRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_chirp_range_to_string(s : SignaltransformchirpRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformchirpSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_chirp_slice_make(size : Int) -> SignaltransformchirpSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_chirp_slice_len(s : SignaltransformchirpSlice) -> Int { s.size }

pub fn signal_transform_chirp_slice_get(s : SignaltransformchirpSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_chirp_slice_set(s : SignaltransformchirpSlice, i : Int, v : Double) -> SignaltransformchirpSlice {
  let result = signal_transform_chirp_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_transform_chirp_slice_sum(s : SignaltransformchirpSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_transform_chirp_slice_mean(s : SignaltransformchirpSlice) -> Double {
  if s.size == 0 { 0.0 } else { signal_transform_chirp_slice_sum(s) / s.size.to_double() }
}

pub fn signal_transform_chirp_slice_scale(s : SignaltransformchirpSlice, f : Double) -> SignaltransformchirpSlice {
  let result = signal_transform_chirp_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_transform_chirp_slice_add(a : SignaltransformchirpSlice, b : SignaltransformchirpSlice) -> SignaltransformchirpSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_transform_chirp_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_transform_chirp_slice_copy(s : SignaltransformchirpSlice) -> SignaltransformchirpSlice {
  let result = signal_transform_chirp_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_transform_chirp_slice_fill(s : SignaltransformchirpSlice, v : Double) -> SignaltransformchirpSlice {
  let result = signal_transform_chirp_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_transform_chirp_slice_min(s : SignaltransformchirpSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_chirp_slice_max(s : SignaltransformchirpSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_chirp_slice_to_string(s : SignaltransformchirpSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn signal_transform_chirp_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_transform_chirp_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_transform_chirp_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_transform_chirp_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_transform_chirp_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_transform_chirp_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_transform_chirp_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_transform_chirp_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_transform_chirp_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_transform_chirp_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_transform_chirp_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_transform_chirp_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_transform_chirp_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_transform_chirp_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_transform_chirp_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_transform_chirp_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_transform_chirp_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_transform_chirp_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_transform_chirp_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_transform_chirp_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_transform_chirp_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_transform_chirp_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_transform_chirp_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_transform_chirp_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_transform_chirp_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

