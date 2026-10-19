///===
/// extcore/signal_window_rect

pub(all) struct SignalwindowrectPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn signal_window_rect_make_point(x : Double, y : Double) -> SignalwindowrectPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn signal_window_rect_make_point3(x : Double, y : Double, z : Double) -> SignalwindowrectPoint {
  { x, y, z, label: 0 }
}

pub fn signal_window_rect_point_x(pt : SignalwindowrectPoint) -> Double { pt.x }

pub fn signal_window_rect_point_y(pt : SignalwindowrectPoint) -> Double { pt.y }

pub fn signal_window_rect_point_z(pt : SignalwindowrectPoint) -> Double { pt.z }

pub fn signal_window_rect_point_label(pt : SignalwindowrectPoint) -> Int { pt.label }

pub fn signal_window_rect_point_dist(a : SignalwindowrectPoint, b : SignalwindowrectPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  signal_window_rect_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn signal_window_rect_point_add(a : SignalwindowrectPoint, b : SignalwindowrectPoint) -> SignalwindowrectPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn signal_window_rect_point_sub(a : SignalwindowrectPoint, b : SignalwindowrectPoint) -> SignalwindowrectPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn signal_window_rect_point_scale(pt : SignalwindowrectPoint, s : Double) -> SignalwindowrectPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn signal_window_rect_point_dot(a : SignalwindowrectPoint, b : SignalwindowrectPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn signal_window_rect_point_cross(a : SignalwindowrectPoint, b : SignalwindowrectPoint) -> SignalwindowrectPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn signal_window_rect_point_norm(pt : SignalwindowrectPoint) -> Double {
  signal_window_rect_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn signal_window_rect_point_normalize(pt : SignalwindowrectPoint) -> SignalwindowrectPoint {
  let n = signal_window_rect_point_norm(pt)
  if n < 0.0000001 { pt } else { signal_window_rect_point_scale(pt, 1.0 / n) }
}

pub fn signal_window_rect_point_negate(pt : SignalwindowrectPoint) -> SignalwindowrectPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn signal_window_rect_point_mid(a : SignalwindowrectPoint, b : SignalwindowrectPoint) -> SignalwindowrectPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn signal_window_rect_point_lerp(a : SignalwindowrectPoint, b : SignalwindowrectPoint, t : Double) -> SignalwindowrectPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn signal_window_rect_point_to_string(pt : SignalwindowrectPoint) -> String {
  "(" + signal_window_rect_dbl(pt.x) + ", " + signal_window_rect_dbl(pt.y) + ", " + signal_window_rect_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct SignalwindowrectSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn signal_window_rect_make_series(vals : Array[Double], name : String) -> SignalwindowrectSeries {
  { vals, name, meta: 0 }
}

pub fn signal_window_rect_series_len(s : SignalwindowrectSeries) -> Int { s.vals.length() }

pub fn signal_window_rect_series_sum(s : SignalwindowrectSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn signal_window_rect_series_mean(s : SignalwindowrectSeries) -> Double {
  let n = signal_window_rect_series_len(s)
  if n == 0 { 0.0 } else { signal_window_rect_series_sum(s) / n.to_double() }
}

pub fn signal_window_rect_series_min(s : SignalwindowrectSeries) -> Double {
  let n = signal_window_rect_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn signal_window_rect_series_max(s : SignalwindowrectSeries) -> Double {
  let n = signal_window_rect_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn signal_window_rect_series_range(s : SignalwindowrectSeries) -> Double {
  signal_window_rect_series_max(s) - signal_window_rect_series_min(s)
}

pub fn signal_window_rect_series_var(s : SignalwindowrectSeries) -> Double {
  let n = signal_window_rect_series_len(s)
  if n == 0 { 0.0 } else {
    let m = signal_window_rect_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn signal_window_rect_series_std(s : SignalwindowrectSeries) -> Double { signal_window_rect_sqrt(signal_window_rect_series_var(s)) }

pub fn signal_window_rect_series_median(s : SignalwindowrectSeries) -> Double {
  let n = signal_window_rect_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = signal_window_rect_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn signal_window_rect_series_scale(s : SignalwindowrectSeries, f : Double) -> SignalwindowrectSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = signal_window_rect_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn signal_window_rect_series_add(a : SignalwindowrectSeries, b : SignalwindowrectSeries) -> SignalwindowrectSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = signal_window_rect_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn signal_window_rect_series_sub(a : SignalwindowrectSeries, b : SignalwindowrectSeries) -> SignalwindowrectSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = signal_window_rect_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn signal_window_rect_series_normalize(s : SignalwindowrectSeries) -> SignalwindowrectSeries {
  let mn = signal_window_rect_series_min(s)
  let mx = signal_window_rect_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = signal_window_rect_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn signal_window_rect_series_cumsum(s : SignalwindowrectSeries) -> SignalwindowrectSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = signal_window_rect_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn signal_window_rect_series_to_string(s : SignalwindowrectSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + signal_window_rect_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SignalwindowrectMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn signal_window_rect_make_matrix(rows : Int, cols : Int, val : Double) -> SignalwindowrectMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn signal_window_rect_matrix_identity(n : Int) -> SignalwindowrectMatrix {
  let m = signal_window_rect_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn signal_window_rect_matrix_get(m : SignalwindowrectMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn signal_window_rect_matrix_transpose(m : SignalwindowrectMatrix) -> SignalwindowrectMatrix {
  let result = signal_window_rect_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn signal_window_rect_matrix_add(a : SignalwindowrectMatrix, b : SignalwindowrectMatrix) -> SignalwindowrectMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = signal_window_rect_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn signal_window_rect_matrix_scale(m : SignalwindowrectMatrix, s : Double) -> SignalwindowrectMatrix {
  let result = signal_window_rect_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn signal_window_rect_matrix_multiply(a : SignalwindowrectMatrix, b : SignalwindowrectMatrix) -> SignalwindowrectMatrix {
  if a.cols != b.rows { return signal_window_rect_make_matrix(a.rows, b.cols, 0.0) }
  let result = signal_window_rect_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn signal_window_rect_matrix_trace(m : SignalwindowrectMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn signal_window_rect_matrix_det(m : SignalwindowrectMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn signal_window_rect_matrix_norm(m : SignalwindowrectMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  signal_window_rect_sqrt(sum)
}

pub fn signal_window_rect_matrix_to_string(m : SignalwindowrectMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + signal_window_rect_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct SignalwindowrectVector {
  comps : Array[Double]
  dim : Int
}

pub fn signal_window_rect_make_vector(comps : Array[Double]) -> SignalwindowrectVector {
  { comps, dim: comps.length() }
}

pub fn signal_window_rect_vector_zero(dim : Int) -> SignalwindowrectVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn signal_window_rect_vector_add(a : SignalwindowrectVector, b : SignalwindowrectVector) -> SignalwindowrectVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = signal_window_rect_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn signal_window_rect_vector_sub(a : SignalwindowrectVector, b : SignalwindowrectVector) -> SignalwindowrectVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = signal_window_rect_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn signal_window_rect_vector_scale(v : SignalwindowrectVector, s : Double) -> SignalwindowrectVector {
  let mut result = []
  for i in 0..<v.dim { result = signal_window_rect_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn signal_window_rect_vector_dot(a : SignalwindowrectVector, b : SignalwindowrectVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn signal_window_rect_vector_norm(v : SignalwindowrectVector) -> Double { signal_window_rect_sqrt(signal_window_rect_vector_dot(v, v)) }

pub fn signal_window_rect_vector_normalize(v : SignalwindowrectVector) -> SignalwindowrectVector {
  let n = signal_window_rect_vector_norm(v)
  if n < 0.0000001 { v } else { signal_window_rect_vector_scale(v, 1.0 / n) }
}

pub fn signal_window_rect_vector_dist(a : SignalwindowrectVector, b : SignalwindowrectVector) -> Double {
  signal_window_rect_vector_norm(signal_window_rect_vector_sub(a, b))
}

pub fn signal_window_rect_vector_to_string(v : SignalwindowrectVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + signal_window_rect_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn signal_window_rect_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn signal_window_rect_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = signal_window_rect_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn signal_window_rect_std(data : Array[Double]) -> Double { signal_window_rect_sqrt(signal_window_rect_var(data)) }

pub fn signal_window_rect_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = signal_window_rect_mean(a); let mb = signal_window_rect_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn signal_window_rect_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = signal_window_rect_std(a); let sb = signal_window_rect_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { signal_window_rect_cov(a, b) / (sa * sb) }
}

pub fn signal_window_rect_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = signal_window_rect_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn signal_window_rect_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn signal_window_rect_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn signal_window_rect_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  signal_window_rect_sqrt(signal_window_rect_mse(pred, labels))
}

pub fn signal_window_rect_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + signal_window_rect_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn signal_window_rect_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = signal_window_rect_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn signal_window_rect_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn signal_window_rect_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn signal_window_rect_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = signal_window_rect_precision(pred, labels, pos); let r = signal_window_rect_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn signal_window_rect_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn signal_window_rect_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = signal_window_rect_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn signal_window_rect_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn signal_window_rect_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn signal_window_rect_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = signal_window_rect_gcd(a, b)
    (a / g) * b
  }
}

pub fn signal_window_rect_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn signal_window_rect_fibonacci(n : Int) -> Int {
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

pub fn signal_window_rect_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = signal_window_rect_min(data); let mx = signal_window_rect_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn signal_window_rect_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = signal_window_rect_mean(data); let sd = signal_window_rect_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn signal_window_rect_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn signal_window_rect_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn signal_window_rect_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn signal_window_rect_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn signal_window_rect_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn signal_window_rect_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn signal_window_rect_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn signal_window_rect_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn signal_window_rect_dbl(x : Double) -> String {
  let i = if x >= 0.0 { signal_window_rect_int(x) } else { -signal_window_rect_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { signal_window_rect_int(f * 1000000.0) } else { signal_window_rect_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn signal_window_rect_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn signal_window_rect_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct SignalwindowrectFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_rect_frame_make(size : Int) -> SignalwindowrectFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_rect_frame_len(s : SignalwindowrectFrame) -> Int { s.size }

pub fn signal_window_rect_frame_get(s : SignalwindowrectFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_rect_frame_set(s : SignalwindowrectFrame, i : Int, v : Double) -> SignalwindowrectFrame {
  let result = signal_window_rect_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_window_rect_frame_sum(s : SignalwindowrectFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_window_rect_frame_mean(s : SignalwindowrectFrame) -> Double {
  if s.size == 0 { 0.0 } else { signal_window_rect_frame_sum(s) / s.size.to_double() }
}

pub fn signal_window_rect_frame_scale(s : SignalwindowrectFrame, f : Double) -> SignalwindowrectFrame {
  let result = signal_window_rect_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_window_rect_frame_add(a : SignalwindowrectFrame, b : SignalwindowrectFrame) -> SignalwindowrectFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_window_rect_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_window_rect_frame_copy(s : SignalwindowrectFrame) -> SignalwindowrectFrame {
  let result = signal_window_rect_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_window_rect_frame_fill(s : SignalwindowrectFrame, v : Double) -> SignalwindowrectFrame {
  let result = signal_window_rect_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_window_rect_frame_min(s : SignalwindowrectFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_window_rect_frame_max(s : SignalwindowrectFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_window_rect_frame_to_string(s : SignalwindowrectFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowrectTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_rect_table_make(size : Int) -> SignalwindowrectTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_rect_table_len(s : SignalwindowrectTable) -> Int { s.size }

pub fn signal_window_rect_table_get(s : SignalwindowrectTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_rect_table_set(s : SignalwindowrectTable, i : Int, v : Double) -> SignalwindowrectTable {
  let result = signal_window_rect_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_window_rect_table_sum(s : SignalwindowrectTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_window_rect_table_mean(s : SignalwindowrectTable) -> Double {
  if s.size == 0 { 0.0 } else { signal_window_rect_table_sum(s) / s.size.to_double() }
}

pub fn signal_window_rect_table_scale(s : SignalwindowrectTable, f : Double) -> SignalwindowrectTable {
  let result = signal_window_rect_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_window_rect_table_add(a : SignalwindowrectTable, b : SignalwindowrectTable) -> SignalwindowrectTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_window_rect_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_window_rect_table_copy(s : SignalwindowrectTable) -> SignalwindowrectTable {
  let result = signal_window_rect_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_window_rect_table_fill(s : SignalwindowrectTable, v : Double) -> SignalwindowrectTable {
  let result = signal_window_rect_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_window_rect_table_min(s : SignalwindowrectTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_window_rect_table_max(s : SignalwindowrectTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_window_rect_table_to_string(s : SignalwindowrectTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowrectGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_rect_graphn_make(size : Int) -> SignalwindowrectGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_rect_graphn_len(s : SignalwindowrectGraphN) -> Int { s.size }

pub fn signal_window_rect_graphn_get(s : SignalwindowrectGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_rect_graphn_set(s : SignalwindowrectGraphN, i : Int, v : Double) -> SignalwindowrectGraphN {
  let result = signal_window_rect_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_window_rect_graphn_sum(s : SignalwindowrectGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_window_rect_graphn_mean(s : SignalwindowrectGraphN) -> Double {
  if s.size == 0 { 0.0 } else { signal_window_rect_graphn_sum(s) / s.size.to_double() }
}

pub fn signal_window_rect_graphn_scale(s : SignalwindowrectGraphN, f : Double) -> SignalwindowrectGraphN {
  let result = signal_window_rect_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_window_rect_graphn_add(a : SignalwindowrectGraphN, b : SignalwindowrectGraphN) -> SignalwindowrectGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_window_rect_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_window_rect_graphn_copy(s : SignalwindowrectGraphN) -> SignalwindowrectGraphN {
  let result = signal_window_rect_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_window_rect_graphn_fill(s : SignalwindowrectGraphN, v : Double) -> SignalwindowrectGraphN {
  let result = signal_window_rect_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_window_rect_graphn_min(s : SignalwindowrectGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_window_rect_graphn_max(s : SignalwindowrectGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_window_rect_graphn_to_string(s : SignalwindowrectGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowrectNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_rect_node_make(size : Int) -> SignalwindowrectNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_rect_node_len(s : SignalwindowrectNode) -> Int { s.size }

pub fn signal_window_rect_node_get(s : SignalwindowrectNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_rect_node_set(s : SignalwindowrectNode, i : Int, v : Double) -> SignalwindowrectNode {
  let result = signal_window_rect_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_window_rect_node_sum(s : SignalwindowrectNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_window_rect_node_mean(s : SignalwindowrectNode) -> Double {
  if s.size == 0 { 0.0 } else { signal_window_rect_node_sum(s) / s.size.to_double() }
}

pub fn signal_window_rect_node_scale(s : SignalwindowrectNode, f : Double) -> SignalwindowrectNode {
  let result = signal_window_rect_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_window_rect_node_add(a : SignalwindowrectNode, b : SignalwindowrectNode) -> SignalwindowrectNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_window_rect_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_window_rect_node_copy(s : SignalwindowrectNode) -> SignalwindowrectNode {
  let result = signal_window_rect_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_window_rect_node_fill(s : SignalwindowrectNode, v : Double) -> SignalwindowrectNode {
  let result = signal_window_rect_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_window_rect_node_min(s : SignalwindowrectNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_window_rect_node_max(s : SignalwindowrectNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_window_rect_node_to_string(s : SignalwindowrectNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowrectEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_rect_edge_make(size : Int) -> SignalwindowrectEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_rect_edge_len(s : SignalwindowrectEdge) -> Int { s.size }

pub fn signal_window_rect_edge_get(s : SignalwindowrectEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_rect_edge_set(s : SignalwindowrectEdge, i : Int, v : Double) -> SignalwindowrectEdge {
  let result = signal_window_rect_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_window_rect_edge_sum(s : SignalwindowrectEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_window_rect_edge_mean(s : SignalwindowrectEdge) -> Double {
  if s.size == 0 { 0.0 } else { signal_window_rect_edge_sum(s) / s.size.to_double() }
}

pub fn signal_window_rect_edge_scale(s : SignalwindowrectEdge, f : Double) -> SignalwindowrectEdge {
  let result = signal_window_rect_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_window_rect_edge_add(a : SignalwindowrectEdge, b : SignalwindowrectEdge) -> SignalwindowrectEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_window_rect_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_window_rect_edge_copy(s : SignalwindowrectEdge) -> SignalwindowrectEdge {
  let result = signal_window_rect_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_window_rect_edge_fill(s : SignalwindowrectEdge, v : Double) -> SignalwindowrectEdge {
  let result = signal_window_rect_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_window_rect_edge_min(s : SignalwindowrectEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_window_rect_edge_max(s : SignalwindowrectEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_window_rect_edge_to_string(s : SignalwindowrectEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowrectPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_rect_path_make(size : Int) -> SignalwindowrectPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_rect_path_len(s : SignalwindowrectPath) -> Int { s.size }

pub fn signal_window_rect_path_get(s : SignalwindowrectPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_rect_path_set(s : SignalwindowrectPath, i : Int, v : Double) -> SignalwindowrectPath {
  let result = signal_window_rect_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_window_rect_path_sum(s : SignalwindowrectPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_window_rect_path_mean(s : SignalwindowrectPath) -> Double {
  if s.size == 0 { 0.0 } else { signal_window_rect_path_sum(s) / s.size.to_double() }
}

pub fn signal_window_rect_path_scale(s : SignalwindowrectPath, f : Double) -> SignalwindowrectPath {
  let result = signal_window_rect_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_window_rect_path_add(a : SignalwindowrectPath, b : SignalwindowrectPath) -> SignalwindowrectPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_window_rect_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_window_rect_path_copy(s : SignalwindowrectPath) -> SignalwindowrectPath {
  let result = signal_window_rect_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_window_rect_path_fill(s : SignalwindowrectPath, v : Double) -> SignalwindowrectPath {
  let result = signal_window_rect_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_window_rect_path_min(s : SignalwindowrectPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_window_rect_path_max(s : SignalwindowrectPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_window_rect_path_to_string(s : SignalwindowrectPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowrectCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_rect_cluster_make(size : Int) -> SignalwindowrectCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_rect_cluster_len(s : SignalwindowrectCluster) -> Int { s.size }

pub fn signal_window_rect_cluster_get(s : SignalwindowrectCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_rect_cluster_set(s : SignalwindowrectCluster, i : Int, v : Double) -> SignalwindowrectCluster {
  let result = signal_window_rect_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_window_rect_cluster_sum(s : SignalwindowrectCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_window_rect_cluster_mean(s : SignalwindowrectCluster) -> Double {
  if s.size == 0 { 0.0 } else { signal_window_rect_cluster_sum(s) / s.size.to_double() }
}

pub fn signal_window_rect_cluster_scale(s : SignalwindowrectCluster, f : Double) -> SignalwindowrectCluster {
  let result = signal_window_rect_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_window_rect_cluster_add(a : SignalwindowrectCluster, b : SignalwindowrectCluster) -> SignalwindowrectCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_window_rect_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_window_rect_cluster_copy(s : SignalwindowrectCluster) -> SignalwindowrectCluster {
  let result = signal_window_rect_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_window_rect_cluster_fill(s : SignalwindowrectCluster, v : Double) -> SignalwindowrectCluster {
  let result = signal_window_rect_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_window_rect_cluster_min(s : SignalwindowrectCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_window_rect_cluster_max(s : SignalwindowrectCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_window_rect_cluster_to_string(s : SignalwindowrectCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowrectModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_rect_model_make(size : Int) -> SignalwindowrectModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_rect_model_len(s : SignalwindowrectModel) -> Int { s.size }

pub fn signal_window_rect_model_get(s : SignalwindowrectModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_rect_model_set(s : SignalwindowrectModel, i : Int, v : Double) -> SignalwindowrectModel {
  let result = signal_window_rect_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_window_rect_model_sum(s : SignalwindowrectModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_window_rect_model_mean(s : SignalwindowrectModel) -> Double {
  if s.size == 0 { 0.0 } else { signal_window_rect_model_sum(s) / s.size.to_double() }
}

pub fn signal_window_rect_model_scale(s : SignalwindowrectModel, f : Double) -> SignalwindowrectModel {
  let result = signal_window_rect_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_window_rect_model_add(a : SignalwindowrectModel, b : SignalwindowrectModel) -> SignalwindowrectModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_window_rect_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_window_rect_model_copy(s : SignalwindowrectModel) -> SignalwindowrectModel {
  let result = signal_window_rect_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_window_rect_model_fill(s : SignalwindowrectModel, v : Double) -> SignalwindowrectModel {
  let result = signal_window_rect_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_window_rect_model_min(s : SignalwindowrectModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_window_rect_model_max(s : SignalwindowrectModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_window_rect_model_to_string(s : SignalwindowrectModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowrectLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_rect_layer_make(size : Int) -> SignalwindowrectLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_rect_layer_len(s : SignalwindowrectLayer) -> Int { s.size }

pub fn signal_window_rect_layer_get(s : SignalwindowrectLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_rect_layer_set(s : SignalwindowrectLayer, i : Int, v : Double) -> SignalwindowrectLayer {
  let result = signal_window_rect_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_window_rect_layer_sum(s : SignalwindowrectLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_window_rect_layer_mean(s : SignalwindowrectLayer) -> Double {
  if s.size == 0 { 0.0 } else { signal_window_rect_layer_sum(s) / s.size.to_double() }
}

pub fn signal_window_rect_layer_scale(s : SignalwindowrectLayer, f : Double) -> SignalwindowrectLayer {
  let result = signal_window_rect_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_window_rect_layer_add(a : SignalwindowrectLayer, b : SignalwindowrectLayer) -> SignalwindowrectLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_window_rect_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_window_rect_layer_copy(s : SignalwindowrectLayer) -> SignalwindowrectLayer {
  let result = signal_window_rect_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_window_rect_layer_fill(s : SignalwindowrectLayer, v : Double) -> SignalwindowrectLayer {
  let result = signal_window_rect_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_window_rect_layer_min(s : SignalwindowrectLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_window_rect_layer_max(s : SignalwindowrectLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_window_rect_layer_to_string(s : SignalwindowrectLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowrectBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_rect_buffer_make(size : Int) -> SignalwindowrectBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_rect_buffer_len(s : SignalwindowrectBuffer) -> Int { s.size }

pub fn signal_window_rect_buffer_get(s : SignalwindowrectBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_rect_buffer_set(s : SignalwindowrectBuffer, i : Int, v : Double) -> SignalwindowrectBuffer {
  let result = signal_window_rect_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_window_rect_buffer_sum(s : SignalwindowrectBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_window_rect_buffer_mean(s : SignalwindowrectBuffer) -> Double {
  if s.size == 0 { 0.0 } else { signal_window_rect_buffer_sum(s) / s.size.to_double() }
}

pub fn signal_window_rect_buffer_scale(s : SignalwindowrectBuffer, f : Double) -> SignalwindowrectBuffer {
  let result = signal_window_rect_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_window_rect_buffer_add(a : SignalwindowrectBuffer, b : SignalwindowrectBuffer) -> SignalwindowrectBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_window_rect_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_window_rect_buffer_copy(s : SignalwindowrectBuffer) -> SignalwindowrectBuffer {
  let result = signal_window_rect_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_window_rect_buffer_fill(s : SignalwindowrectBuffer, v : Double) -> SignalwindowrectBuffer {
  let result = signal_window_rect_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_window_rect_buffer_min(s : SignalwindowrectBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_window_rect_buffer_max(s : SignalwindowrectBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_window_rect_buffer_to_string(s : SignalwindowrectBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowrectCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_rect_cursor_make(size : Int) -> SignalwindowrectCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_rect_cursor_len(s : SignalwindowrectCursor) -> Int { s.size }

pub fn signal_window_rect_cursor_get(s : SignalwindowrectCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_rect_cursor_set(s : SignalwindowrectCursor, i : Int, v : Double) -> SignalwindowrectCursor {
  let result = signal_window_rect_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_window_rect_cursor_sum(s : SignalwindowrectCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_window_rect_cursor_mean(s : SignalwindowrectCursor) -> Double {
  if s.size == 0 { 0.0 } else { signal_window_rect_cursor_sum(s) / s.size.to_double() }
}

pub fn signal_window_rect_cursor_scale(s : SignalwindowrectCursor, f : Double) -> SignalwindowrectCursor {
  let result = signal_window_rect_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_window_rect_cursor_add(a : SignalwindowrectCursor, b : SignalwindowrectCursor) -> SignalwindowrectCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_window_rect_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_window_rect_cursor_copy(s : SignalwindowrectCursor) -> SignalwindowrectCursor {
  let result = signal_window_rect_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_window_rect_cursor_fill(s : SignalwindowrectCursor, v : Double) -> SignalwindowrectCursor {
  let result = signal_window_rect_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_window_rect_cursor_min(s : SignalwindowrectCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_window_rect_cursor_max(s : SignalwindowrectCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_window_rect_cursor_to_string(s : SignalwindowrectCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowrectView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_rect_view_make(size : Int) -> SignalwindowrectView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_rect_view_len(s : SignalwindowrectView) -> Int { s.size }

pub fn signal_window_rect_view_get(s : SignalwindowrectView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_rect_view_set(s : SignalwindowrectView, i : Int, v : Double) -> SignalwindowrectView {
  let result = signal_window_rect_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_window_rect_view_sum(s : SignalwindowrectView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_window_rect_view_mean(s : SignalwindowrectView) -> Double {
  if s.size == 0 { 0.0 } else { signal_window_rect_view_sum(s) / s.size.to_double() }
}

pub fn signal_window_rect_view_scale(s : SignalwindowrectView, f : Double) -> SignalwindowrectView {
  let result = signal_window_rect_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_window_rect_view_add(a : SignalwindowrectView, b : SignalwindowrectView) -> SignalwindowrectView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_window_rect_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_window_rect_view_copy(s : SignalwindowrectView) -> SignalwindowrectView {
  let result = signal_window_rect_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_window_rect_view_fill(s : SignalwindowrectView, v : Double) -> SignalwindowrectView {
  let result = signal_window_rect_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_window_rect_view_min(s : SignalwindowrectView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_window_rect_view_max(s : SignalwindowrectView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_window_rect_view_to_string(s : SignalwindowrectView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowrectRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_rect_range_make(size : Int) -> SignalwindowrectRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_rect_range_len(s : SignalwindowrectRange) -> Int { s.size }

pub fn signal_window_rect_range_get(s : SignalwindowrectRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_rect_range_set(s : SignalwindowrectRange, i : Int, v : Double) -> SignalwindowrectRange {
  let result = signal_window_rect_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_window_rect_range_sum(s : SignalwindowrectRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_window_rect_range_mean(s : SignalwindowrectRange) -> Double {
  if s.size == 0 { 0.0 } else { signal_window_rect_range_sum(s) / s.size.to_double() }
}

pub fn signal_window_rect_range_scale(s : SignalwindowrectRange, f : Double) -> SignalwindowrectRange {
  let result = signal_window_rect_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_window_rect_range_add(a : SignalwindowrectRange, b : SignalwindowrectRange) -> SignalwindowrectRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_window_rect_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_window_rect_range_copy(s : SignalwindowrectRange) -> SignalwindowrectRange {
  let result = signal_window_rect_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_window_rect_range_fill(s : SignalwindowrectRange, v : Double) -> SignalwindowrectRange {
  let result = signal_window_rect_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_window_rect_range_min(s : SignalwindowrectRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_window_rect_range_max(s : SignalwindowrectRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_window_rect_range_to_string(s : SignalwindowrectRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowrectSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_rect_slice_make(size : Int) -> SignalwindowrectSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_rect_slice_len(s : SignalwindowrectSlice) -> Int { s.size }

pub fn signal_window_rect_slice_get(s : SignalwindowrectSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_rect_slice_set(s : SignalwindowrectSlice, i : Int, v : Double) -> SignalwindowrectSlice {
  let result = signal_window_rect_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_window_rect_slice_sum(s : SignalwindowrectSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_window_rect_slice_mean(s : SignalwindowrectSlice) -> Double {
  if s.size == 0 { 0.0 } else { signal_window_rect_slice_sum(s) / s.size.to_double() }
}

pub fn signal_window_rect_slice_scale(s : SignalwindowrectSlice, f : Double) -> SignalwindowrectSlice {
  let result = signal_window_rect_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_window_rect_slice_add(a : SignalwindowrectSlice, b : SignalwindowrectSlice) -> SignalwindowrectSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_window_rect_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_window_rect_slice_copy(s : SignalwindowrectSlice) -> SignalwindowrectSlice {
  let result = signal_window_rect_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_window_rect_slice_fill(s : SignalwindowrectSlice, v : Double) -> SignalwindowrectSlice {
  let result = signal_window_rect_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_window_rect_slice_min(s : SignalwindowrectSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_window_rect_slice_max(s : SignalwindowrectSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_window_rect_slice_to_string(s : SignalwindowrectSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn signal_window_rect_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_window_rect_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_window_rect_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_window_rect_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_window_rect_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_window_rect_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_window_rect_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_window_rect_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_window_rect_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_window_rect_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_window_rect_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_window_rect_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_window_rect_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_window_rect_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_window_rect_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_window_rect_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_window_rect_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_window_rect_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_window_rect_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_window_rect_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_window_rect_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_window_rect_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_window_rect_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_window_rect_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_window_rect_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

