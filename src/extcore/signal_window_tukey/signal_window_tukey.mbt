///===
/// extcore/signal_window_tukey

pub(all) struct SignalwindowtukeyPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn signal_window_tukey_make_point(x : Double, y : Double) -> SignalwindowtukeyPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn signal_window_tukey_make_point3(x : Double, y : Double, z : Double) -> SignalwindowtukeyPoint {
  { x, y, z, label: 0 }
}

pub fn signal_window_tukey_point_x(pt : SignalwindowtukeyPoint) -> Double { pt.x }

pub fn signal_window_tukey_point_y(pt : SignalwindowtukeyPoint) -> Double { pt.y }

pub fn signal_window_tukey_point_z(pt : SignalwindowtukeyPoint) -> Double { pt.z }

pub fn signal_window_tukey_point_label(pt : SignalwindowtukeyPoint) -> Int { pt.label }

pub fn signal_window_tukey_point_dist(a : SignalwindowtukeyPoint, b : SignalwindowtukeyPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn signal_window_tukey_point_add(a : SignalwindowtukeyPoint, b : SignalwindowtukeyPoint) -> SignalwindowtukeyPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn signal_window_tukey_point_sub(a : SignalwindowtukeyPoint, b : SignalwindowtukeyPoint) -> SignalwindowtukeyPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn signal_window_tukey_point_scale(pt : SignalwindowtukeyPoint, s : Double) -> SignalwindowtukeyPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn signal_window_tukey_point_dot(a : SignalwindowtukeyPoint, b : SignalwindowtukeyPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn signal_window_tukey_point_cross(a : SignalwindowtukeyPoint, b : SignalwindowtukeyPoint) -> SignalwindowtukeyPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn signal_window_tukey_point_norm(pt : SignalwindowtukeyPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn signal_window_tukey_point_normalize(pt : SignalwindowtukeyPoint) -> SignalwindowtukeyPoint {
  let n = signal_window_tukey_point_norm(pt)
  if n < 0.0000001 { pt } else { signal_window_tukey_point_scale(pt, 1.0 / n) }
}

pub fn signal_window_tukey_point_negate(pt : SignalwindowtukeyPoint) -> SignalwindowtukeyPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn signal_window_tukey_point_mid(a : SignalwindowtukeyPoint, b : SignalwindowtukeyPoint) -> SignalwindowtukeyPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn signal_window_tukey_point_lerp(a : SignalwindowtukeyPoint, b : SignalwindowtukeyPoint, t : Double) -> SignalwindowtukeyPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn signal_window_tukey_point_to_string(pt : SignalwindowtukeyPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct SignalwindowtukeySeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn signal_window_tukey_make_series(vals : Array[Double], name : String) -> SignalwindowtukeySeries {
  { vals, name, meta: 0 }
}

pub fn signal_window_tukey_series_len(s : SignalwindowtukeySeries) -> Int { s.vals.length() }

pub fn signal_window_tukey_series_sum(s : SignalwindowtukeySeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn signal_window_tukey_series_mean(s : SignalwindowtukeySeries) -> Double {
  let n = signal_window_tukey_series_len(s)
  if n == 0 { 0.0 } else { signal_window_tukey_series_sum(s) / n.to_double() }
}

pub fn signal_window_tukey_series_min(s : SignalwindowtukeySeries) -> Double {
  let n = signal_window_tukey_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn signal_window_tukey_series_max(s : SignalwindowtukeySeries) -> Double {
  let n = signal_window_tukey_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn signal_window_tukey_series_range(s : SignalwindowtukeySeries) -> Double {
  signal_window_tukey_series_max(s) - signal_window_tukey_series_min(s)
}

pub fn signal_window_tukey_series_var(s : SignalwindowtukeySeries) -> Double {
  let n = signal_window_tukey_series_len(s)
  if n == 0 { 0.0 } else {
    let m = signal_window_tukey_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn signal_window_tukey_series_std(s : SignalwindowtukeySeries) -> Double { @_common.sqrt(signal_window_tukey_series_var(s)) }

pub fn signal_window_tukey_series_median(s : SignalwindowtukeySeries) -> Double {
  let n = signal_window_tukey_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = signal_window_tukey_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn signal_window_tukey_series_scale(s : SignalwindowtukeySeries, f : Double) -> SignalwindowtukeySeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn signal_window_tukey_series_add(a : SignalwindowtukeySeries, b : SignalwindowtukeySeries) -> SignalwindowtukeySeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn signal_window_tukey_series_sub(a : SignalwindowtukeySeries, b : SignalwindowtukeySeries) -> SignalwindowtukeySeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn signal_window_tukey_series_normalize(s : SignalwindowtukeySeries) -> SignalwindowtukeySeries {
  let mn = signal_window_tukey_series_min(s)
  let mx = signal_window_tukey_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn signal_window_tukey_series_cumsum(s : SignalwindowtukeySeries) -> SignalwindowtukeySeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn signal_window_tukey_series_to_string(s : SignalwindowtukeySeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SignalwindowtukeyMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn signal_window_tukey_make_matrix(rows : Int, cols : Int, val : Double) -> SignalwindowtukeyMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn signal_window_tukey_matrix_identity(n : Int) -> SignalwindowtukeyMatrix {
  let m = signal_window_tukey_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn signal_window_tukey_matrix_get(m : SignalwindowtukeyMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn signal_window_tukey_matrix_transpose(m : SignalwindowtukeyMatrix) -> SignalwindowtukeyMatrix {
  let result = signal_window_tukey_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn signal_window_tukey_matrix_add(a : SignalwindowtukeyMatrix, b : SignalwindowtukeyMatrix) -> SignalwindowtukeyMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = signal_window_tukey_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn signal_window_tukey_matrix_scale(m : SignalwindowtukeyMatrix, s : Double) -> SignalwindowtukeyMatrix {
  let result = signal_window_tukey_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn signal_window_tukey_matrix_multiply(a : SignalwindowtukeyMatrix, b : SignalwindowtukeyMatrix) -> SignalwindowtukeyMatrix {
  if a.cols != b.rows { return signal_window_tukey_make_matrix(a.rows, b.cols, 0.0) }
  let result = signal_window_tukey_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn signal_window_tukey_matrix_trace(m : SignalwindowtukeyMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn signal_window_tukey_matrix_det(m : SignalwindowtukeyMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn signal_window_tukey_matrix_norm(m : SignalwindowtukeyMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn signal_window_tukey_matrix_to_string(m : SignalwindowtukeyMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + @_common.dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct SignalwindowtukeyVector {
  comps : Array[Double]
  dim : Int
}

pub fn signal_window_tukey_make_vector(comps : Array[Double]) -> SignalwindowtukeyVector {
  { comps, dim: comps.length() }
}

pub fn signal_window_tukey_vector_zero(dim : Int) -> SignalwindowtukeyVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn signal_window_tukey_vector_add(a : SignalwindowtukeyVector, b : SignalwindowtukeyVector) -> SignalwindowtukeyVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn signal_window_tukey_vector_sub(a : SignalwindowtukeyVector, b : SignalwindowtukeyVector) -> SignalwindowtukeyVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn signal_window_tukey_vector_scale(v : SignalwindowtukeyVector, s : Double) -> SignalwindowtukeyVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn signal_window_tukey_vector_dot(a : SignalwindowtukeyVector, b : SignalwindowtukeyVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn signal_window_tukey_vector_norm(v : SignalwindowtukeyVector) -> Double { @_common.sqrt(signal_window_tukey_vector_dot(v, v)) }

pub fn signal_window_tukey_vector_normalize(v : SignalwindowtukeyVector) -> SignalwindowtukeyVector {
  let n = signal_window_tukey_vector_norm(v)
  if n < 0.0000001 { v } else { signal_window_tukey_vector_scale(v, 1.0 / n) }
}

pub fn signal_window_tukey_vector_dist(a : SignalwindowtukeyVector, b : SignalwindowtukeyVector) -> Double {
  signal_window_tukey_vector_norm(signal_window_tukey_vector_sub(a, b))
}

pub fn signal_window_tukey_vector_to_string(v : SignalwindowtukeyVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn signal_window_tukey_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn signal_window_tukey_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = signal_window_tukey_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn signal_window_tukey_std(data : Array[Double]) -> Double { @_common.sqrt(signal_window_tukey_var(data)) }

pub fn signal_window_tukey_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = signal_window_tukey_mean(a); let mb = signal_window_tukey_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn signal_window_tukey_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = signal_window_tukey_std(a); let sb = signal_window_tukey_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { signal_window_tukey_cov(a, b) / (sa * sb) }
}

pub fn signal_window_tukey_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = signal_window_tukey_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn signal_window_tukey_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn signal_window_tukey_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn signal_window_tukey_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  @_common.sqrt(signal_window_tukey_mse(pred, labels))
}

pub fn signal_window_tukey_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn signal_window_tukey_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = signal_window_tukey_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn signal_window_tukey_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn signal_window_tukey_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn signal_window_tukey_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = signal_window_tukey_precision(pred, labels, pos); let r = signal_window_tukey_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn signal_window_tukey_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn signal_window_tukey_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = signal_window_tukey_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn signal_window_tukey_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn signal_window_tukey_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn signal_window_tukey_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = signal_window_tukey_gcd(a, b)
    (a / g) * b
  }
}

pub fn signal_window_tukey_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn signal_window_tukey_fibonacci(n : Int) -> Int {
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

pub fn signal_window_tukey_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = signal_window_tukey_min(data); let mx = signal_window_tukey_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn signal_window_tukey_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = signal_window_tukey_mean(data); let sd = signal_window_tukey_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn signal_window_tukey_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn signal_window_tukey_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn signal_window_tukey_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn signal_window_tukey_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn signal_window_tukey_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn signal_window_tukey_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

pub(all) struct SignalwindowtukeyFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_tukey_frame_make(size : Int) -> SignalwindowtukeyFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_tukey_frame_len(s : SignalwindowtukeyFrame) -> Int { s.size }

pub fn signal_window_tukey_frame_get(s : SignalwindowtukeyFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_tukey_frame_set(s : SignalwindowtukeyFrame, i : Int, v : Double) -> SignalwindowtukeyFrame {
  let result = signal_window_tukey_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_window_tukey_frame_sum(s : SignalwindowtukeyFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_window_tukey_frame_mean(s : SignalwindowtukeyFrame) -> Double {
  if s.size == 0 { 0.0 } else { signal_window_tukey_frame_sum(s) / s.size.to_double() }
}

pub fn signal_window_tukey_frame_scale(s : SignalwindowtukeyFrame, f : Double) -> SignalwindowtukeyFrame {
  let result = signal_window_tukey_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_window_tukey_frame_add(a : SignalwindowtukeyFrame, b : SignalwindowtukeyFrame) -> SignalwindowtukeyFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_window_tukey_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_window_tukey_frame_copy(s : SignalwindowtukeyFrame) -> SignalwindowtukeyFrame {
  let result = signal_window_tukey_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_window_tukey_frame_fill(s : SignalwindowtukeyFrame, v : Double) -> SignalwindowtukeyFrame {
  let result = signal_window_tukey_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_window_tukey_frame_min(s : SignalwindowtukeyFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_window_tukey_frame_max(s : SignalwindowtukeyFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_window_tukey_frame_to_string(s : SignalwindowtukeyFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowtukeyTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_tukey_table_make(size : Int) -> SignalwindowtukeyTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_tukey_table_len(s : SignalwindowtukeyTable) -> Int { s.size }

pub fn signal_window_tukey_table_get(s : SignalwindowtukeyTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_tukey_table_set(s : SignalwindowtukeyTable, i : Int, v : Double) -> SignalwindowtukeyTable {
  let result = signal_window_tukey_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_window_tukey_table_sum(s : SignalwindowtukeyTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_window_tukey_table_mean(s : SignalwindowtukeyTable) -> Double {
  if s.size == 0 { 0.0 } else { signal_window_tukey_table_sum(s) / s.size.to_double() }
}

pub fn signal_window_tukey_table_scale(s : SignalwindowtukeyTable, f : Double) -> SignalwindowtukeyTable {
  let result = signal_window_tukey_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_window_tukey_table_add(a : SignalwindowtukeyTable, b : SignalwindowtukeyTable) -> SignalwindowtukeyTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_window_tukey_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_window_tukey_table_copy(s : SignalwindowtukeyTable) -> SignalwindowtukeyTable {
  let result = signal_window_tukey_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_window_tukey_table_fill(s : SignalwindowtukeyTable, v : Double) -> SignalwindowtukeyTable {
  let result = signal_window_tukey_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_window_tukey_table_min(s : SignalwindowtukeyTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_window_tukey_table_max(s : SignalwindowtukeyTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_window_tukey_table_to_string(s : SignalwindowtukeyTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowtukeyGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_tukey_graphn_make(size : Int) -> SignalwindowtukeyGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_tukey_graphn_len(s : SignalwindowtukeyGraphN) -> Int { s.size }

pub fn signal_window_tukey_graphn_get(s : SignalwindowtukeyGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_tukey_graphn_set(s : SignalwindowtukeyGraphN, i : Int, v : Double) -> SignalwindowtukeyGraphN {
  let result = signal_window_tukey_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_window_tukey_graphn_sum(s : SignalwindowtukeyGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_window_tukey_graphn_mean(s : SignalwindowtukeyGraphN) -> Double {
  if s.size == 0 { 0.0 } else { signal_window_tukey_graphn_sum(s) / s.size.to_double() }
}

pub fn signal_window_tukey_graphn_scale(s : SignalwindowtukeyGraphN, f : Double) -> SignalwindowtukeyGraphN {
  let result = signal_window_tukey_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_window_tukey_graphn_add(a : SignalwindowtukeyGraphN, b : SignalwindowtukeyGraphN) -> SignalwindowtukeyGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_window_tukey_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_window_tukey_graphn_copy(s : SignalwindowtukeyGraphN) -> SignalwindowtukeyGraphN {
  let result = signal_window_tukey_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_window_tukey_graphn_fill(s : SignalwindowtukeyGraphN, v : Double) -> SignalwindowtukeyGraphN {
  let result = signal_window_tukey_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_window_tukey_graphn_min(s : SignalwindowtukeyGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_window_tukey_graphn_max(s : SignalwindowtukeyGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_window_tukey_graphn_to_string(s : SignalwindowtukeyGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowtukeyNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_tukey_node_make(size : Int) -> SignalwindowtukeyNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_tukey_node_len(s : SignalwindowtukeyNode) -> Int { s.size }

pub fn signal_window_tukey_node_get(s : SignalwindowtukeyNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_tukey_node_set(s : SignalwindowtukeyNode, i : Int, v : Double) -> SignalwindowtukeyNode {
  let result = signal_window_tukey_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_window_tukey_node_sum(s : SignalwindowtukeyNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_window_tukey_node_mean(s : SignalwindowtukeyNode) -> Double {
  if s.size == 0 { 0.0 } else { signal_window_tukey_node_sum(s) / s.size.to_double() }
}

pub fn signal_window_tukey_node_scale(s : SignalwindowtukeyNode, f : Double) -> SignalwindowtukeyNode {
  let result = signal_window_tukey_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_window_tukey_node_add(a : SignalwindowtukeyNode, b : SignalwindowtukeyNode) -> SignalwindowtukeyNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_window_tukey_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_window_tukey_node_copy(s : SignalwindowtukeyNode) -> SignalwindowtukeyNode {
  let result = signal_window_tukey_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_window_tukey_node_fill(s : SignalwindowtukeyNode, v : Double) -> SignalwindowtukeyNode {
  let result = signal_window_tukey_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_window_tukey_node_min(s : SignalwindowtukeyNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_window_tukey_node_max(s : SignalwindowtukeyNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_window_tukey_node_to_string(s : SignalwindowtukeyNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowtukeyEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_tukey_edge_make(size : Int) -> SignalwindowtukeyEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_tukey_edge_len(s : SignalwindowtukeyEdge) -> Int { s.size }

pub fn signal_window_tukey_edge_get(s : SignalwindowtukeyEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_tukey_edge_set(s : SignalwindowtukeyEdge, i : Int, v : Double) -> SignalwindowtukeyEdge {
  let result = signal_window_tukey_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_window_tukey_edge_sum(s : SignalwindowtukeyEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_window_tukey_edge_mean(s : SignalwindowtukeyEdge) -> Double {
  if s.size == 0 { 0.0 } else { signal_window_tukey_edge_sum(s) / s.size.to_double() }
}

pub fn signal_window_tukey_edge_scale(s : SignalwindowtukeyEdge, f : Double) -> SignalwindowtukeyEdge {
  let result = signal_window_tukey_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_window_tukey_edge_add(a : SignalwindowtukeyEdge, b : SignalwindowtukeyEdge) -> SignalwindowtukeyEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_window_tukey_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_window_tukey_edge_copy(s : SignalwindowtukeyEdge) -> SignalwindowtukeyEdge {
  let result = signal_window_tukey_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_window_tukey_edge_fill(s : SignalwindowtukeyEdge, v : Double) -> SignalwindowtukeyEdge {
  let result = signal_window_tukey_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_window_tukey_edge_min(s : SignalwindowtukeyEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_window_tukey_edge_max(s : SignalwindowtukeyEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_window_tukey_edge_to_string(s : SignalwindowtukeyEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowtukeyPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_tukey_path_make(size : Int) -> SignalwindowtukeyPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_tukey_path_len(s : SignalwindowtukeyPath) -> Int { s.size }

pub fn signal_window_tukey_path_get(s : SignalwindowtukeyPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_tukey_path_set(s : SignalwindowtukeyPath, i : Int, v : Double) -> SignalwindowtukeyPath {
  let result = signal_window_tukey_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_window_tukey_path_sum(s : SignalwindowtukeyPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_window_tukey_path_mean(s : SignalwindowtukeyPath) -> Double {
  if s.size == 0 { 0.0 } else { signal_window_tukey_path_sum(s) / s.size.to_double() }
}

pub fn signal_window_tukey_path_scale(s : SignalwindowtukeyPath, f : Double) -> SignalwindowtukeyPath {
  let result = signal_window_tukey_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_window_tukey_path_add(a : SignalwindowtukeyPath, b : SignalwindowtukeyPath) -> SignalwindowtukeyPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_window_tukey_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_window_tukey_path_copy(s : SignalwindowtukeyPath) -> SignalwindowtukeyPath {
  let result = signal_window_tukey_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_window_tukey_path_fill(s : SignalwindowtukeyPath, v : Double) -> SignalwindowtukeyPath {
  let result = signal_window_tukey_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_window_tukey_path_min(s : SignalwindowtukeyPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_window_tukey_path_max(s : SignalwindowtukeyPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_window_tukey_path_to_string(s : SignalwindowtukeyPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowtukeyCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_tukey_cluster_make(size : Int) -> SignalwindowtukeyCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_tukey_cluster_len(s : SignalwindowtukeyCluster) -> Int { s.size }

pub fn signal_window_tukey_cluster_get(s : SignalwindowtukeyCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_tukey_cluster_set(s : SignalwindowtukeyCluster, i : Int, v : Double) -> SignalwindowtukeyCluster {
  let result = signal_window_tukey_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_window_tukey_cluster_sum(s : SignalwindowtukeyCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_window_tukey_cluster_mean(s : SignalwindowtukeyCluster) -> Double {
  if s.size == 0 { 0.0 } else { signal_window_tukey_cluster_sum(s) / s.size.to_double() }
}

pub fn signal_window_tukey_cluster_scale(s : SignalwindowtukeyCluster, f : Double) -> SignalwindowtukeyCluster {
  let result = signal_window_tukey_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_window_tukey_cluster_add(a : SignalwindowtukeyCluster, b : SignalwindowtukeyCluster) -> SignalwindowtukeyCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_window_tukey_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_window_tukey_cluster_copy(s : SignalwindowtukeyCluster) -> SignalwindowtukeyCluster {
  let result = signal_window_tukey_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_window_tukey_cluster_fill(s : SignalwindowtukeyCluster, v : Double) -> SignalwindowtukeyCluster {
  let result = signal_window_tukey_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_window_tukey_cluster_min(s : SignalwindowtukeyCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_window_tukey_cluster_max(s : SignalwindowtukeyCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_window_tukey_cluster_to_string(s : SignalwindowtukeyCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowtukeyModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_tukey_model_make(size : Int) -> SignalwindowtukeyModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_tukey_model_len(s : SignalwindowtukeyModel) -> Int { s.size }

pub fn signal_window_tukey_model_get(s : SignalwindowtukeyModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_tukey_model_set(s : SignalwindowtukeyModel, i : Int, v : Double) -> SignalwindowtukeyModel {
  let result = signal_window_tukey_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_window_tukey_model_sum(s : SignalwindowtukeyModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_window_tukey_model_mean(s : SignalwindowtukeyModel) -> Double {
  if s.size == 0 { 0.0 } else { signal_window_tukey_model_sum(s) / s.size.to_double() }
}

pub fn signal_window_tukey_model_scale(s : SignalwindowtukeyModel, f : Double) -> SignalwindowtukeyModel {
  let result = signal_window_tukey_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_window_tukey_model_add(a : SignalwindowtukeyModel, b : SignalwindowtukeyModel) -> SignalwindowtukeyModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_window_tukey_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_window_tukey_model_copy(s : SignalwindowtukeyModel) -> SignalwindowtukeyModel {
  let result = signal_window_tukey_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_window_tukey_model_fill(s : SignalwindowtukeyModel, v : Double) -> SignalwindowtukeyModel {
  let result = signal_window_tukey_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_window_tukey_model_min(s : SignalwindowtukeyModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_window_tukey_model_max(s : SignalwindowtukeyModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_window_tukey_model_to_string(s : SignalwindowtukeyModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowtukeyLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_tukey_layer_make(size : Int) -> SignalwindowtukeyLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_tukey_layer_len(s : SignalwindowtukeyLayer) -> Int { s.size }

pub fn signal_window_tukey_layer_get(s : SignalwindowtukeyLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_tukey_layer_set(s : SignalwindowtukeyLayer, i : Int, v : Double) -> SignalwindowtukeyLayer {
  let result = signal_window_tukey_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_window_tukey_layer_sum(s : SignalwindowtukeyLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_window_tukey_layer_mean(s : SignalwindowtukeyLayer) -> Double {
  if s.size == 0 { 0.0 } else { signal_window_tukey_layer_sum(s) / s.size.to_double() }
}

pub fn signal_window_tukey_layer_scale(s : SignalwindowtukeyLayer, f : Double) -> SignalwindowtukeyLayer {
  let result = signal_window_tukey_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_window_tukey_layer_add(a : SignalwindowtukeyLayer, b : SignalwindowtukeyLayer) -> SignalwindowtukeyLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_window_tukey_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_window_tukey_layer_copy(s : SignalwindowtukeyLayer) -> SignalwindowtukeyLayer {
  let result = signal_window_tukey_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_window_tukey_layer_fill(s : SignalwindowtukeyLayer, v : Double) -> SignalwindowtukeyLayer {
  let result = signal_window_tukey_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_window_tukey_layer_min(s : SignalwindowtukeyLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_window_tukey_layer_max(s : SignalwindowtukeyLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_window_tukey_layer_to_string(s : SignalwindowtukeyLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowtukeyBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_tukey_buffer_make(size : Int) -> SignalwindowtukeyBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_tukey_buffer_len(s : SignalwindowtukeyBuffer) -> Int { s.size }

pub fn signal_window_tukey_buffer_get(s : SignalwindowtukeyBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_tukey_buffer_set(s : SignalwindowtukeyBuffer, i : Int, v : Double) -> SignalwindowtukeyBuffer {
  let result = signal_window_tukey_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_window_tukey_buffer_sum(s : SignalwindowtukeyBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_window_tukey_buffer_mean(s : SignalwindowtukeyBuffer) -> Double {
  if s.size == 0 { 0.0 } else { signal_window_tukey_buffer_sum(s) / s.size.to_double() }
}

pub fn signal_window_tukey_buffer_scale(s : SignalwindowtukeyBuffer, f : Double) -> SignalwindowtukeyBuffer {
  let result = signal_window_tukey_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_window_tukey_buffer_add(a : SignalwindowtukeyBuffer, b : SignalwindowtukeyBuffer) -> SignalwindowtukeyBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_window_tukey_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_window_tukey_buffer_copy(s : SignalwindowtukeyBuffer) -> SignalwindowtukeyBuffer {
  let result = signal_window_tukey_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_window_tukey_buffer_fill(s : SignalwindowtukeyBuffer, v : Double) -> SignalwindowtukeyBuffer {
  let result = signal_window_tukey_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_window_tukey_buffer_min(s : SignalwindowtukeyBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_window_tukey_buffer_max(s : SignalwindowtukeyBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_window_tukey_buffer_to_string(s : SignalwindowtukeyBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowtukeyCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_tukey_cursor_make(size : Int) -> SignalwindowtukeyCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_tukey_cursor_len(s : SignalwindowtukeyCursor) -> Int { s.size }

pub fn signal_window_tukey_cursor_get(s : SignalwindowtukeyCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_tukey_cursor_set(s : SignalwindowtukeyCursor, i : Int, v : Double) -> SignalwindowtukeyCursor {
  let result = signal_window_tukey_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_window_tukey_cursor_sum(s : SignalwindowtukeyCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_window_tukey_cursor_mean(s : SignalwindowtukeyCursor) -> Double {
  if s.size == 0 { 0.0 } else { signal_window_tukey_cursor_sum(s) / s.size.to_double() }
}

pub fn signal_window_tukey_cursor_scale(s : SignalwindowtukeyCursor, f : Double) -> SignalwindowtukeyCursor {
  let result = signal_window_tukey_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_window_tukey_cursor_add(a : SignalwindowtukeyCursor, b : SignalwindowtukeyCursor) -> SignalwindowtukeyCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_window_tukey_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_window_tukey_cursor_copy(s : SignalwindowtukeyCursor) -> SignalwindowtukeyCursor {
  let result = signal_window_tukey_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_window_tukey_cursor_fill(s : SignalwindowtukeyCursor, v : Double) -> SignalwindowtukeyCursor {
  let result = signal_window_tukey_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_window_tukey_cursor_min(s : SignalwindowtukeyCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_window_tukey_cursor_max(s : SignalwindowtukeyCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_window_tukey_cursor_to_string(s : SignalwindowtukeyCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowtukeyView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_tukey_view_make(size : Int) -> SignalwindowtukeyView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_tukey_view_len(s : SignalwindowtukeyView) -> Int { s.size }

pub fn signal_window_tukey_view_get(s : SignalwindowtukeyView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_tukey_view_set(s : SignalwindowtukeyView, i : Int, v : Double) -> SignalwindowtukeyView {
  let result = signal_window_tukey_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_window_tukey_view_sum(s : SignalwindowtukeyView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_window_tukey_view_mean(s : SignalwindowtukeyView) -> Double {
  if s.size == 0 { 0.0 } else { signal_window_tukey_view_sum(s) / s.size.to_double() }
}

pub fn signal_window_tukey_view_scale(s : SignalwindowtukeyView, f : Double) -> SignalwindowtukeyView {
  let result = signal_window_tukey_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_window_tukey_view_add(a : SignalwindowtukeyView, b : SignalwindowtukeyView) -> SignalwindowtukeyView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_window_tukey_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_window_tukey_view_copy(s : SignalwindowtukeyView) -> SignalwindowtukeyView {
  let result = signal_window_tukey_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_window_tukey_view_fill(s : SignalwindowtukeyView, v : Double) -> SignalwindowtukeyView {
  let result = signal_window_tukey_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_window_tukey_view_min(s : SignalwindowtukeyView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_window_tukey_view_max(s : SignalwindowtukeyView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_window_tukey_view_to_string(s : SignalwindowtukeyView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowtukeyRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_tukey_range_make(size : Int) -> SignalwindowtukeyRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_tukey_range_len(s : SignalwindowtukeyRange) -> Int { s.size }

pub fn signal_window_tukey_range_get(s : SignalwindowtukeyRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_tukey_range_set(s : SignalwindowtukeyRange, i : Int, v : Double) -> SignalwindowtukeyRange {
  let result = signal_window_tukey_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_window_tukey_range_sum(s : SignalwindowtukeyRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_window_tukey_range_mean(s : SignalwindowtukeyRange) -> Double {
  if s.size == 0 { 0.0 } else { signal_window_tukey_range_sum(s) / s.size.to_double() }
}

pub fn signal_window_tukey_range_scale(s : SignalwindowtukeyRange, f : Double) -> SignalwindowtukeyRange {
  let result = signal_window_tukey_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_window_tukey_range_add(a : SignalwindowtukeyRange, b : SignalwindowtukeyRange) -> SignalwindowtukeyRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_window_tukey_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_window_tukey_range_copy(s : SignalwindowtukeyRange) -> SignalwindowtukeyRange {
  let result = signal_window_tukey_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_window_tukey_range_fill(s : SignalwindowtukeyRange, v : Double) -> SignalwindowtukeyRange {
  let result = signal_window_tukey_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_window_tukey_range_min(s : SignalwindowtukeyRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_window_tukey_range_max(s : SignalwindowtukeyRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_window_tukey_range_to_string(s : SignalwindowtukeyRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowtukeySlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_tukey_slice_make(size : Int) -> SignalwindowtukeySlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_tukey_slice_len(s : SignalwindowtukeySlice) -> Int { s.size }

pub fn signal_window_tukey_slice_get(s : SignalwindowtukeySlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_tukey_slice_set(s : SignalwindowtukeySlice, i : Int, v : Double) -> SignalwindowtukeySlice {
  let result = signal_window_tukey_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_window_tukey_slice_sum(s : SignalwindowtukeySlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_window_tukey_slice_mean(s : SignalwindowtukeySlice) -> Double {
  if s.size == 0 { 0.0 } else { signal_window_tukey_slice_sum(s) / s.size.to_double() }
}

pub fn signal_window_tukey_slice_scale(s : SignalwindowtukeySlice, f : Double) -> SignalwindowtukeySlice {
  let result = signal_window_tukey_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_window_tukey_slice_add(a : SignalwindowtukeySlice, b : SignalwindowtukeySlice) -> SignalwindowtukeySlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_window_tukey_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_window_tukey_slice_copy(s : SignalwindowtukeySlice) -> SignalwindowtukeySlice {
  let result = signal_window_tukey_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_window_tukey_slice_fill(s : SignalwindowtukeySlice, v : Double) -> SignalwindowtukeySlice {
  let result = signal_window_tukey_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_window_tukey_slice_min(s : SignalwindowtukeySlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_window_tukey_slice_max(s : SignalwindowtukeySlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_window_tukey_slice_to_string(s : SignalwindowtukeySlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

