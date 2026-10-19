///===
/// extcore/signal_window_hann

pub(all) struct SignalwindowhannPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn signal_window_hann_make_point(x : Double, y : Double) -> SignalwindowhannPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn signal_window_hann_make_point3(x : Double, y : Double, z : Double) -> SignalwindowhannPoint {
  { x, y, z, label: 0 }
}

pub fn signal_window_hann_point_x(pt : SignalwindowhannPoint) -> Double { pt.x }

pub fn signal_window_hann_point_y(pt : SignalwindowhannPoint) -> Double { pt.y }

pub fn signal_window_hann_point_z(pt : SignalwindowhannPoint) -> Double { pt.z }

pub fn signal_window_hann_point_label(pt : SignalwindowhannPoint) -> Int { pt.label }

pub fn signal_window_hann_point_dist(a : SignalwindowhannPoint, b : SignalwindowhannPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  signal_window_hann_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn signal_window_hann_point_add(a : SignalwindowhannPoint, b : SignalwindowhannPoint) -> SignalwindowhannPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn signal_window_hann_point_sub(a : SignalwindowhannPoint, b : SignalwindowhannPoint) -> SignalwindowhannPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn signal_window_hann_point_scale(pt : SignalwindowhannPoint, s : Double) -> SignalwindowhannPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn signal_window_hann_point_dot(a : SignalwindowhannPoint, b : SignalwindowhannPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn signal_window_hann_point_cross(a : SignalwindowhannPoint, b : SignalwindowhannPoint) -> SignalwindowhannPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn signal_window_hann_point_norm(pt : SignalwindowhannPoint) -> Double {
  signal_window_hann_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn signal_window_hann_point_normalize(pt : SignalwindowhannPoint) -> SignalwindowhannPoint {
  let n = signal_window_hann_point_norm(pt)
  if n < 0.0000001 { pt } else { signal_window_hann_point_scale(pt, 1.0 / n) }
}

pub fn signal_window_hann_point_negate(pt : SignalwindowhannPoint) -> SignalwindowhannPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn signal_window_hann_point_mid(a : SignalwindowhannPoint, b : SignalwindowhannPoint) -> SignalwindowhannPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn signal_window_hann_point_lerp(a : SignalwindowhannPoint, b : SignalwindowhannPoint, t : Double) -> SignalwindowhannPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn signal_window_hann_point_to_string(pt : SignalwindowhannPoint) -> String {
  "(" + signal_window_hann_dbl(pt.x) + ", " + signal_window_hann_dbl(pt.y) + ", " + signal_window_hann_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct SignalwindowhannSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn signal_window_hann_make_series(vals : Array[Double], name : String) -> SignalwindowhannSeries {
  { vals, name, meta: 0 }
}

pub fn signal_window_hann_series_len(s : SignalwindowhannSeries) -> Int { s.vals.length() }

pub fn signal_window_hann_series_sum(s : SignalwindowhannSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn signal_window_hann_series_mean(s : SignalwindowhannSeries) -> Double {
  let n = signal_window_hann_series_len(s)
  if n == 0 { 0.0 } else { signal_window_hann_series_sum(s) / n.to_double() }
}

pub fn signal_window_hann_series_min(s : SignalwindowhannSeries) -> Double {
  let n = signal_window_hann_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn signal_window_hann_series_max(s : SignalwindowhannSeries) -> Double {
  let n = signal_window_hann_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn signal_window_hann_series_range(s : SignalwindowhannSeries) -> Double {
  signal_window_hann_series_max(s) - signal_window_hann_series_min(s)
}

pub fn signal_window_hann_series_var(s : SignalwindowhannSeries) -> Double {
  let n = signal_window_hann_series_len(s)
  if n == 0 { 0.0 } else {
    let m = signal_window_hann_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn signal_window_hann_series_std(s : SignalwindowhannSeries) -> Double { signal_window_hann_sqrt(signal_window_hann_series_var(s)) }

pub fn signal_window_hann_series_median(s : SignalwindowhannSeries) -> Double {
  let n = signal_window_hann_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = signal_window_hann_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn signal_window_hann_series_scale(s : SignalwindowhannSeries, f : Double) -> SignalwindowhannSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = signal_window_hann_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn signal_window_hann_series_add(a : SignalwindowhannSeries, b : SignalwindowhannSeries) -> SignalwindowhannSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = signal_window_hann_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn signal_window_hann_series_sub(a : SignalwindowhannSeries, b : SignalwindowhannSeries) -> SignalwindowhannSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = signal_window_hann_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn signal_window_hann_series_normalize(s : SignalwindowhannSeries) -> SignalwindowhannSeries {
  let mn = signal_window_hann_series_min(s)
  let mx = signal_window_hann_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = signal_window_hann_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn signal_window_hann_series_cumsum(s : SignalwindowhannSeries) -> SignalwindowhannSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = signal_window_hann_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn signal_window_hann_series_to_string(s : SignalwindowhannSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + signal_window_hann_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SignalwindowhannMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn signal_window_hann_make_matrix(rows : Int, cols : Int, val : Double) -> SignalwindowhannMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn signal_window_hann_matrix_identity(n : Int) -> SignalwindowhannMatrix {
  let m = signal_window_hann_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn signal_window_hann_matrix_get(m : SignalwindowhannMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn signal_window_hann_matrix_transpose(m : SignalwindowhannMatrix) -> SignalwindowhannMatrix {
  let result = signal_window_hann_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn signal_window_hann_matrix_add(a : SignalwindowhannMatrix, b : SignalwindowhannMatrix) -> SignalwindowhannMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = signal_window_hann_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn signal_window_hann_matrix_scale(m : SignalwindowhannMatrix, s : Double) -> SignalwindowhannMatrix {
  let result = signal_window_hann_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn signal_window_hann_matrix_multiply(a : SignalwindowhannMatrix, b : SignalwindowhannMatrix) -> SignalwindowhannMatrix {
  if a.cols != b.rows { return signal_window_hann_make_matrix(a.rows, b.cols, 0.0) }
  let result = signal_window_hann_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn signal_window_hann_matrix_trace(m : SignalwindowhannMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn signal_window_hann_matrix_det(m : SignalwindowhannMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn signal_window_hann_matrix_norm(m : SignalwindowhannMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  signal_window_hann_sqrt(sum)
}

pub fn signal_window_hann_matrix_to_string(m : SignalwindowhannMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + signal_window_hann_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct SignalwindowhannVector {
  comps : Array[Double]
  dim : Int
}

pub fn signal_window_hann_make_vector(comps : Array[Double]) -> SignalwindowhannVector {
  { comps, dim: comps.length() }
}

pub fn signal_window_hann_vector_zero(dim : Int) -> SignalwindowhannVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn signal_window_hann_vector_add(a : SignalwindowhannVector, b : SignalwindowhannVector) -> SignalwindowhannVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = signal_window_hann_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn signal_window_hann_vector_sub(a : SignalwindowhannVector, b : SignalwindowhannVector) -> SignalwindowhannVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = signal_window_hann_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn signal_window_hann_vector_scale(v : SignalwindowhannVector, s : Double) -> SignalwindowhannVector {
  let mut result = []
  for i in 0..<v.dim { result = signal_window_hann_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn signal_window_hann_vector_dot(a : SignalwindowhannVector, b : SignalwindowhannVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn signal_window_hann_vector_norm(v : SignalwindowhannVector) -> Double { signal_window_hann_sqrt(signal_window_hann_vector_dot(v, v)) }

pub fn signal_window_hann_vector_normalize(v : SignalwindowhannVector) -> SignalwindowhannVector {
  let n = signal_window_hann_vector_norm(v)
  if n < 0.0000001 { v } else { signal_window_hann_vector_scale(v, 1.0 / n) }
}

pub fn signal_window_hann_vector_dist(a : SignalwindowhannVector, b : SignalwindowhannVector) -> Double {
  signal_window_hann_vector_norm(signal_window_hann_vector_sub(a, b))
}

pub fn signal_window_hann_vector_to_string(v : SignalwindowhannVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + signal_window_hann_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn signal_window_hann_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn signal_window_hann_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = signal_window_hann_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn signal_window_hann_std(data : Array[Double]) -> Double { signal_window_hann_sqrt(signal_window_hann_var(data)) }

pub fn signal_window_hann_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = signal_window_hann_mean(a); let mb = signal_window_hann_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn signal_window_hann_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = signal_window_hann_std(a); let sb = signal_window_hann_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { signal_window_hann_cov(a, b) / (sa * sb) }
}

pub fn signal_window_hann_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = signal_window_hann_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn signal_window_hann_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn signal_window_hann_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn signal_window_hann_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  signal_window_hann_sqrt(signal_window_hann_mse(pred, labels))
}

pub fn signal_window_hann_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + signal_window_hann_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn signal_window_hann_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = signal_window_hann_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn signal_window_hann_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn signal_window_hann_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn signal_window_hann_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = signal_window_hann_precision(pred, labels, pos); let r = signal_window_hann_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn signal_window_hann_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn signal_window_hann_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = signal_window_hann_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn signal_window_hann_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn signal_window_hann_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn signal_window_hann_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = signal_window_hann_gcd(a, b)
    (a / g) * b
  }
}

pub fn signal_window_hann_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn signal_window_hann_fibonacci(n : Int) -> Int {
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

pub fn signal_window_hann_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = signal_window_hann_min(data); let mx = signal_window_hann_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn signal_window_hann_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = signal_window_hann_mean(data); let sd = signal_window_hann_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn signal_window_hann_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn signal_window_hann_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn signal_window_hann_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn signal_window_hann_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn signal_window_hann_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn signal_window_hann_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn signal_window_hann_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn signal_window_hann_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn signal_window_hann_dbl(x : Double) -> String {
  let i = if x >= 0.0 { signal_window_hann_int(x) } else { -signal_window_hann_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { signal_window_hann_int(f * 1000000.0) } else { signal_window_hann_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn signal_window_hann_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn signal_window_hann_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct SignalwindowhannFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_hann_frame_make(size : Int) -> SignalwindowhannFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_hann_frame_len(s : SignalwindowhannFrame) -> Int { s.size }

pub fn signal_window_hann_frame_get(s : SignalwindowhannFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_hann_frame_set(s : SignalwindowhannFrame, i : Int, v : Double) -> SignalwindowhannFrame {
  let result = signal_window_hann_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_window_hann_frame_sum(s : SignalwindowhannFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_window_hann_frame_mean(s : SignalwindowhannFrame) -> Double {
  if s.size == 0 { 0.0 } else { signal_window_hann_frame_sum(s) / s.size.to_double() }
}

pub fn signal_window_hann_frame_scale(s : SignalwindowhannFrame, f : Double) -> SignalwindowhannFrame {
  let result = signal_window_hann_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_window_hann_frame_add(a : SignalwindowhannFrame, b : SignalwindowhannFrame) -> SignalwindowhannFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_window_hann_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_window_hann_frame_copy(s : SignalwindowhannFrame) -> SignalwindowhannFrame {
  let result = signal_window_hann_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_window_hann_frame_fill(s : SignalwindowhannFrame, v : Double) -> SignalwindowhannFrame {
  let result = signal_window_hann_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_window_hann_frame_min(s : SignalwindowhannFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_window_hann_frame_max(s : SignalwindowhannFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_window_hann_frame_to_string(s : SignalwindowhannFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowhannTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_hann_table_make(size : Int) -> SignalwindowhannTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_hann_table_len(s : SignalwindowhannTable) -> Int { s.size }

pub fn signal_window_hann_table_get(s : SignalwindowhannTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_hann_table_set(s : SignalwindowhannTable, i : Int, v : Double) -> SignalwindowhannTable {
  let result = signal_window_hann_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_window_hann_table_sum(s : SignalwindowhannTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_window_hann_table_mean(s : SignalwindowhannTable) -> Double {
  if s.size == 0 { 0.0 } else { signal_window_hann_table_sum(s) / s.size.to_double() }
}

pub fn signal_window_hann_table_scale(s : SignalwindowhannTable, f : Double) -> SignalwindowhannTable {
  let result = signal_window_hann_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_window_hann_table_add(a : SignalwindowhannTable, b : SignalwindowhannTable) -> SignalwindowhannTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_window_hann_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_window_hann_table_copy(s : SignalwindowhannTable) -> SignalwindowhannTable {
  let result = signal_window_hann_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_window_hann_table_fill(s : SignalwindowhannTable, v : Double) -> SignalwindowhannTable {
  let result = signal_window_hann_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_window_hann_table_min(s : SignalwindowhannTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_window_hann_table_max(s : SignalwindowhannTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_window_hann_table_to_string(s : SignalwindowhannTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowhannGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_hann_graphn_make(size : Int) -> SignalwindowhannGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_hann_graphn_len(s : SignalwindowhannGraphN) -> Int { s.size }

pub fn signal_window_hann_graphn_get(s : SignalwindowhannGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_hann_graphn_set(s : SignalwindowhannGraphN, i : Int, v : Double) -> SignalwindowhannGraphN {
  let result = signal_window_hann_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_window_hann_graphn_sum(s : SignalwindowhannGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_window_hann_graphn_mean(s : SignalwindowhannGraphN) -> Double {
  if s.size == 0 { 0.0 } else { signal_window_hann_graphn_sum(s) / s.size.to_double() }
}

pub fn signal_window_hann_graphn_scale(s : SignalwindowhannGraphN, f : Double) -> SignalwindowhannGraphN {
  let result = signal_window_hann_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_window_hann_graphn_add(a : SignalwindowhannGraphN, b : SignalwindowhannGraphN) -> SignalwindowhannGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_window_hann_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_window_hann_graphn_copy(s : SignalwindowhannGraphN) -> SignalwindowhannGraphN {
  let result = signal_window_hann_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_window_hann_graphn_fill(s : SignalwindowhannGraphN, v : Double) -> SignalwindowhannGraphN {
  let result = signal_window_hann_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_window_hann_graphn_min(s : SignalwindowhannGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_window_hann_graphn_max(s : SignalwindowhannGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_window_hann_graphn_to_string(s : SignalwindowhannGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowhannNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_hann_node_make(size : Int) -> SignalwindowhannNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_hann_node_len(s : SignalwindowhannNode) -> Int { s.size }

pub fn signal_window_hann_node_get(s : SignalwindowhannNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_hann_node_set(s : SignalwindowhannNode, i : Int, v : Double) -> SignalwindowhannNode {
  let result = signal_window_hann_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_window_hann_node_sum(s : SignalwindowhannNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_window_hann_node_mean(s : SignalwindowhannNode) -> Double {
  if s.size == 0 { 0.0 } else { signal_window_hann_node_sum(s) / s.size.to_double() }
}

pub fn signal_window_hann_node_scale(s : SignalwindowhannNode, f : Double) -> SignalwindowhannNode {
  let result = signal_window_hann_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_window_hann_node_add(a : SignalwindowhannNode, b : SignalwindowhannNode) -> SignalwindowhannNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_window_hann_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_window_hann_node_copy(s : SignalwindowhannNode) -> SignalwindowhannNode {
  let result = signal_window_hann_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_window_hann_node_fill(s : SignalwindowhannNode, v : Double) -> SignalwindowhannNode {
  let result = signal_window_hann_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_window_hann_node_min(s : SignalwindowhannNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_window_hann_node_max(s : SignalwindowhannNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_window_hann_node_to_string(s : SignalwindowhannNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowhannEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_hann_edge_make(size : Int) -> SignalwindowhannEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_hann_edge_len(s : SignalwindowhannEdge) -> Int { s.size }

pub fn signal_window_hann_edge_get(s : SignalwindowhannEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_hann_edge_set(s : SignalwindowhannEdge, i : Int, v : Double) -> SignalwindowhannEdge {
  let result = signal_window_hann_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_window_hann_edge_sum(s : SignalwindowhannEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_window_hann_edge_mean(s : SignalwindowhannEdge) -> Double {
  if s.size == 0 { 0.0 } else { signal_window_hann_edge_sum(s) / s.size.to_double() }
}

pub fn signal_window_hann_edge_scale(s : SignalwindowhannEdge, f : Double) -> SignalwindowhannEdge {
  let result = signal_window_hann_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_window_hann_edge_add(a : SignalwindowhannEdge, b : SignalwindowhannEdge) -> SignalwindowhannEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_window_hann_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_window_hann_edge_copy(s : SignalwindowhannEdge) -> SignalwindowhannEdge {
  let result = signal_window_hann_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_window_hann_edge_fill(s : SignalwindowhannEdge, v : Double) -> SignalwindowhannEdge {
  let result = signal_window_hann_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_window_hann_edge_min(s : SignalwindowhannEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_window_hann_edge_max(s : SignalwindowhannEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_window_hann_edge_to_string(s : SignalwindowhannEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowhannPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_hann_path_make(size : Int) -> SignalwindowhannPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_hann_path_len(s : SignalwindowhannPath) -> Int { s.size }

pub fn signal_window_hann_path_get(s : SignalwindowhannPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_hann_path_set(s : SignalwindowhannPath, i : Int, v : Double) -> SignalwindowhannPath {
  let result = signal_window_hann_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_window_hann_path_sum(s : SignalwindowhannPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_window_hann_path_mean(s : SignalwindowhannPath) -> Double {
  if s.size == 0 { 0.0 } else { signal_window_hann_path_sum(s) / s.size.to_double() }
}

pub fn signal_window_hann_path_scale(s : SignalwindowhannPath, f : Double) -> SignalwindowhannPath {
  let result = signal_window_hann_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_window_hann_path_add(a : SignalwindowhannPath, b : SignalwindowhannPath) -> SignalwindowhannPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_window_hann_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_window_hann_path_copy(s : SignalwindowhannPath) -> SignalwindowhannPath {
  let result = signal_window_hann_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_window_hann_path_fill(s : SignalwindowhannPath, v : Double) -> SignalwindowhannPath {
  let result = signal_window_hann_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_window_hann_path_min(s : SignalwindowhannPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_window_hann_path_max(s : SignalwindowhannPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_window_hann_path_to_string(s : SignalwindowhannPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowhannCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_hann_cluster_make(size : Int) -> SignalwindowhannCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_hann_cluster_len(s : SignalwindowhannCluster) -> Int { s.size }

pub fn signal_window_hann_cluster_get(s : SignalwindowhannCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_hann_cluster_set(s : SignalwindowhannCluster, i : Int, v : Double) -> SignalwindowhannCluster {
  let result = signal_window_hann_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_window_hann_cluster_sum(s : SignalwindowhannCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_window_hann_cluster_mean(s : SignalwindowhannCluster) -> Double {
  if s.size == 0 { 0.0 } else { signal_window_hann_cluster_sum(s) / s.size.to_double() }
}

pub fn signal_window_hann_cluster_scale(s : SignalwindowhannCluster, f : Double) -> SignalwindowhannCluster {
  let result = signal_window_hann_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_window_hann_cluster_add(a : SignalwindowhannCluster, b : SignalwindowhannCluster) -> SignalwindowhannCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_window_hann_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_window_hann_cluster_copy(s : SignalwindowhannCluster) -> SignalwindowhannCluster {
  let result = signal_window_hann_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_window_hann_cluster_fill(s : SignalwindowhannCluster, v : Double) -> SignalwindowhannCluster {
  let result = signal_window_hann_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_window_hann_cluster_min(s : SignalwindowhannCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_window_hann_cluster_max(s : SignalwindowhannCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_window_hann_cluster_to_string(s : SignalwindowhannCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowhannModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_hann_model_make(size : Int) -> SignalwindowhannModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_hann_model_len(s : SignalwindowhannModel) -> Int { s.size }

pub fn signal_window_hann_model_get(s : SignalwindowhannModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_hann_model_set(s : SignalwindowhannModel, i : Int, v : Double) -> SignalwindowhannModel {
  let result = signal_window_hann_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_window_hann_model_sum(s : SignalwindowhannModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_window_hann_model_mean(s : SignalwindowhannModel) -> Double {
  if s.size == 0 { 0.0 } else { signal_window_hann_model_sum(s) / s.size.to_double() }
}

pub fn signal_window_hann_model_scale(s : SignalwindowhannModel, f : Double) -> SignalwindowhannModel {
  let result = signal_window_hann_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_window_hann_model_add(a : SignalwindowhannModel, b : SignalwindowhannModel) -> SignalwindowhannModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_window_hann_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_window_hann_model_copy(s : SignalwindowhannModel) -> SignalwindowhannModel {
  let result = signal_window_hann_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_window_hann_model_fill(s : SignalwindowhannModel, v : Double) -> SignalwindowhannModel {
  let result = signal_window_hann_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_window_hann_model_min(s : SignalwindowhannModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_window_hann_model_max(s : SignalwindowhannModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_window_hann_model_to_string(s : SignalwindowhannModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowhannLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_hann_layer_make(size : Int) -> SignalwindowhannLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_hann_layer_len(s : SignalwindowhannLayer) -> Int { s.size }

pub fn signal_window_hann_layer_get(s : SignalwindowhannLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_hann_layer_set(s : SignalwindowhannLayer, i : Int, v : Double) -> SignalwindowhannLayer {
  let result = signal_window_hann_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_window_hann_layer_sum(s : SignalwindowhannLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_window_hann_layer_mean(s : SignalwindowhannLayer) -> Double {
  if s.size == 0 { 0.0 } else { signal_window_hann_layer_sum(s) / s.size.to_double() }
}

pub fn signal_window_hann_layer_scale(s : SignalwindowhannLayer, f : Double) -> SignalwindowhannLayer {
  let result = signal_window_hann_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_window_hann_layer_add(a : SignalwindowhannLayer, b : SignalwindowhannLayer) -> SignalwindowhannLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_window_hann_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_window_hann_layer_copy(s : SignalwindowhannLayer) -> SignalwindowhannLayer {
  let result = signal_window_hann_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_window_hann_layer_fill(s : SignalwindowhannLayer, v : Double) -> SignalwindowhannLayer {
  let result = signal_window_hann_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_window_hann_layer_min(s : SignalwindowhannLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_window_hann_layer_max(s : SignalwindowhannLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_window_hann_layer_to_string(s : SignalwindowhannLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowhannBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_hann_buffer_make(size : Int) -> SignalwindowhannBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_hann_buffer_len(s : SignalwindowhannBuffer) -> Int { s.size }

pub fn signal_window_hann_buffer_get(s : SignalwindowhannBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_hann_buffer_set(s : SignalwindowhannBuffer, i : Int, v : Double) -> SignalwindowhannBuffer {
  let result = signal_window_hann_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_window_hann_buffer_sum(s : SignalwindowhannBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_window_hann_buffer_mean(s : SignalwindowhannBuffer) -> Double {
  if s.size == 0 { 0.0 } else { signal_window_hann_buffer_sum(s) / s.size.to_double() }
}

pub fn signal_window_hann_buffer_scale(s : SignalwindowhannBuffer, f : Double) -> SignalwindowhannBuffer {
  let result = signal_window_hann_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_window_hann_buffer_add(a : SignalwindowhannBuffer, b : SignalwindowhannBuffer) -> SignalwindowhannBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_window_hann_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_window_hann_buffer_copy(s : SignalwindowhannBuffer) -> SignalwindowhannBuffer {
  let result = signal_window_hann_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_window_hann_buffer_fill(s : SignalwindowhannBuffer, v : Double) -> SignalwindowhannBuffer {
  let result = signal_window_hann_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_window_hann_buffer_min(s : SignalwindowhannBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_window_hann_buffer_max(s : SignalwindowhannBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_window_hann_buffer_to_string(s : SignalwindowhannBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowhannCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_hann_cursor_make(size : Int) -> SignalwindowhannCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_hann_cursor_len(s : SignalwindowhannCursor) -> Int { s.size }

pub fn signal_window_hann_cursor_get(s : SignalwindowhannCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_hann_cursor_set(s : SignalwindowhannCursor, i : Int, v : Double) -> SignalwindowhannCursor {
  let result = signal_window_hann_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_window_hann_cursor_sum(s : SignalwindowhannCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_window_hann_cursor_mean(s : SignalwindowhannCursor) -> Double {
  if s.size == 0 { 0.0 } else { signal_window_hann_cursor_sum(s) / s.size.to_double() }
}

pub fn signal_window_hann_cursor_scale(s : SignalwindowhannCursor, f : Double) -> SignalwindowhannCursor {
  let result = signal_window_hann_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_window_hann_cursor_add(a : SignalwindowhannCursor, b : SignalwindowhannCursor) -> SignalwindowhannCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_window_hann_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_window_hann_cursor_copy(s : SignalwindowhannCursor) -> SignalwindowhannCursor {
  let result = signal_window_hann_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_window_hann_cursor_fill(s : SignalwindowhannCursor, v : Double) -> SignalwindowhannCursor {
  let result = signal_window_hann_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_window_hann_cursor_min(s : SignalwindowhannCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_window_hann_cursor_max(s : SignalwindowhannCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_window_hann_cursor_to_string(s : SignalwindowhannCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowhannView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_hann_view_make(size : Int) -> SignalwindowhannView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_hann_view_len(s : SignalwindowhannView) -> Int { s.size }

pub fn signal_window_hann_view_get(s : SignalwindowhannView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_hann_view_set(s : SignalwindowhannView, i : Int, v : Double) -> SignalwindowhannView {
  let result = signal_window_hann_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_window_hann_view_sum(s : SignalwindowhannView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_window_hann_view_mean(s : SignalwindowhannView) -> Double {
  if s.size == 0 { 0.0 } else { signal_window_hann_view_sum(s) / s.size.to_double() }
}

pub fn signal_window_hann_view_scale(s : SignalwindowhannView, f : Double) -> SignalwindowhannView {
  let result = signal_window_hann_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_window_hann_view_add(a : SignalwindowhannView, b : SignalwindowhannView) -> SignalwindowhannView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_window_hann_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_window_hann_view_copy(s : SignalwindowhannView) -> SignalwindowhannView {
  let result = signal_window_hann_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_window_hann_view_fill(s : SignalwindowhannView, v : Double) -> SignalwindowhannView {
  let result = signal_window_hann_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_window_hann_view_min(s : SignalwindowhannView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_window_hann_view_max(s : SignalwindowhannView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_window_hann_view_to_string(s : SignalwindowhannView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowhannRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_hann_range_make(size : Int) -> SignalwindowhannRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_hann_range_len(s : SignalwindowhannRange) -> Int { s.size }

pub fn signal_window_hann_range_get(s : SignalwindowhannRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_hann_range_set(s : SignalwindowhannRange, i : Int, v : Double) -> SignalwindowhannRange {
  let result = signal_window_hann_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_window_hann_range_sum(s : SignalwindowhannRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_window_hann_range_mean(s : SignalwindowhannRange) -> Double {
  if s.size == 0 { 0.0 } else { signal_window_hann_range_sum(s) / s.size.to_double() }
}

pub fn signal_window_hann_range_scale(s : SignalwindowhannRange, f : Double) -> SignalwindowhannRange {
  let result = signal_window_hann_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_window_hann_range_add(a : SignalwindowhannRange, b : SignalwindowhannRange) -> SignalwindowhannRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_window_hann_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_window_hann_range_copy(s : SignalwindowhannRange) -> SignalwindowhannRange {
  let result = signal_window_hann_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_window_hann_range_fill(s : SignalwindowhannRange, v : Double) -> SignalwindowhannRange {
  let result = signal_window_hann_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_window_hann_range_min(s : SignalwindowhannRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_window_hann_range_max(s : SignalwindowhannRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_window_hann_range_to_string(s : SignalwindowhannRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowhannSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_hann_slice_make(size : Int) -> SignalwindowhannSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_hann_slice_len(s : SignalwindowhannSlice) -> Int { s.size }

pub fn signal_window_hann_slice_get(s : SignalwindowhannSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_hann_slice_set(s : SignalwindowhannSlice, i : Int, v : Double) -> SignalwindowhannSlice {
  let result = signal_window_hann_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_window_hann_slice_sum(s : SignalwindowhannSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_window_hann_slice_mean(s : SignalwindowhannSlice) -> Double {
  if s.size == 0 { 0.0 } else { signal_window_hann_slice_sum(s) / s.size.to_double() }
}

pub fn signal_window_hann_slice_scale(s : SignalwindowhannSlice, f : Double) -> SignalwindowhannSlice {
  let result = signal_window_hann_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_window_hann_slice_add(a : SignalwindowhannSlice, b : SignalwindowhannSlice) -> SignalwindowhannSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_window_hann_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_window_hann_slice_copy(s : SignalwindowhannSlice) -> SignalwindowhannSlice {
  let result = signal_window_hann_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_window_hann_slice_fill(s : SignalwindowhannSlice, v : Double) -> SignalwindowhannSlice {
  let result = signal_window_hann_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_window_hann_slice_min(s : SignalwindowhannSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_window_hann_slice_max(s : SignalwindowhannSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_window_hann_slice_to_string(s : SignalwindowhannSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn signal_window_hann_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_window_hann_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_window_hann_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_window_hann_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_window_hann_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_window_hann_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_window_hann_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_window_hann_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_window_hann_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_window_hann_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_window_hann_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_window_hann_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_window_hann_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_window_hann_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_window_hann_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_window_hann_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_window_hann_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_window_hann_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_window_hann_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_window_hann_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_window_hann_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_window_hann_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_window_hann_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_window_hann_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_window_hann_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

