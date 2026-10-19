///===
/// extcore/signal_spec_daniell

pub(all) struct SignalspecdaniellPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn signal_spec_daniell_make_point(x : Double, y : Double) -> SignalspecdaniellPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn signal_spec_daniell_make_point3(x : Double, y : Double, z : Double) -> SignalspecdaniellPoint {
  { x, y, z, label: 0 }
}

pub fn signal_spec_daniell_point_x(pt : SignalspecdaniellPoint) -> Double { pt.x }

pub fn signal_spec_daniell_point_y(pt : SignalspecdaniellPoint) -> Double { pt.y }

pub fn signal_spec_daniell_point_z(pt : SignalspecdaniellPoint) -> Double { pt.z }

pub fn signal_spec_daniell_point_label(pt : SignalspecdaniellPoint) -> Int { pt.label }

pub fn signal_spec_daniell_point_dist(a : SignalspecdaniellPoint, b : SignalspecdaniellPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  signal_spec_daniell_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn signal_spec_daniell_point_add(a : SignalspecdaniellPoint, b : SignalspecdaniellPoint) -> SignalspecdaniellPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn signal_spec_daniell_point_sub(a : SignalspecdaniellPoint, b : SignalspecdaniellPoint) -> SignalspecdaniellPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn signal_spec_daniell_point_scale(pt : SignalspecdaniellPoint, s : Double) -> SignalspecdaniellPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn signal_spec_daniell_point_dot(a : SignalspecdaniellPoint, b : SignalspecdaniellPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn signal_spec_daniell_point_cross(a : SignalspecdaniellPoint, b : SignalspecdaniellPoint) -> SignalspecdaniellPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn signal_spec_daniell_point_norm(pt : SignalspecdaniellPoint) -> Double {
  signal_spec_daniell_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn signal_spec_daniell_point_normalize(pt : SignalspecdaniellPoint) -> SignalspecdaniellPoint {
  let n = signal_spec_daniell_point_norm(pt)
  if n < 0.0000001 { pt } else { signal_spec_daniell_point_scale(pt, 1.0 / n) }
}

pub fn signal_spec_daniell_point_negate(pt : SignalspecdaniellPoint) -> SignalspecdaniellPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn signal_spec_daniell_point_mid(a : SignalspecdaniellPoint, b : SignalspecdaniellPoint) -> SignalspecdaniellPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn signal_spec_daniell_point_lerp(a : SignalspecdaniellPoint, b : SignalspecdaniellPoint, t : Double) -> SignalspecdaniellPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn signal_spec_daniell_point_to_string(pt : SignalspecdaniellPoint) -> String {
  "(" + signal_spec_daniell_dbl(pt.x) + ", " + signal_spec_daniell_dbl(pt.y) + ", " + signal_spec_daniell_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct SignalspecdaniellSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn signal_spec_daniell_make_series(vals : Array[Double], name : String) -> SignalspecdaniellSeries {
  { vals, name, meta: 0 }
}

pub fn signal_spec_daniell_series_len(s : SignalspecdaniellSeries) -> Int { s.vals.length() }

pub fn signal_spec_daniell_series_sum(s : SignalspecdaniellSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn signal_spec_daniell_series_mean(s : SignalspecdaniellSeries) -> Double {
  let n = signal_spec_daniell_series_len(s)
  if n == 0 { 0.0 } else { signal_spec_daniell_series_sum(s) / n.to_double() }
}

pub fn signal_spec_daniell_series_min(s : SignalspecdaniellSeries) -> Double {
  let n = signal_spec_daniell_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn signal_spec_daniell_series_max(s : SignalspecdaniellSeries) -> Double {
  let n = signal_spec_daniell_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn signal_spec_daniell_series_range(s : SignalspecdaniellSeries) -> Double {
  signal_spec_daniell_series_max(s) - signal_spec_daniell_series_min(s)
}

pub fn signal_spec_daniell_series_var(s : SignalspecdaniellSeries) -> Double {
  let n = signal_spec_daniell_series_len(s)
  if n == 0 { 0.0 } else {
    let m = signal_spec_daniell_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn signal_spec_daniell_series_std(s : SignalspecdaniellSeries) -> Double { signal_spec_daniell_sqrt(signal_spec_daniell_series_var(s)) }

pub fn signal_spec_daniell_series_median(s : SignalspecdaniellSeries) -> Double {
  let n = signal_spec_daniell_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = signal_spec_daniell_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn signal_spec_daniell_series_scale(s : SignalspecdaniellSeries, f : Double) -> SignalspecdaniellSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = signal_spec_daniell_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn signal_spec_daniell_series_add(a : SignalspecdaniellSeries, b : SignalspecdaniellSeries) -> SignalspecdaniellSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = signal_spec_daniell_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn signal_spec_daniell_series_sub(a : SignalspecdaniellSeries, b : SignalspecdaniellSeries) -> SignalspecdaniellSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = signal_spec_daniell_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn signal_spec_daniell_series_normalize(s : SignalspecdaniellSeries) -> SignalspecdaniellSeries {
  let mn = signal_spec_daniell_series_min(s)
  let mx = signal_spec_daniell_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = signal_spec_daniell_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn signal_spec_daniell_series_cumsum(s : SignalspecdaniellSeries) -> SignalspecdaniellSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = signal_spec_daniell_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn signal_spec_daniell_series_to_string(s : SignalspecdaniellSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + signal_spec_daniell_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SignalspecdaniellMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn signal_spec_daniell_make_matrix(rows : Int, cols : Int, val : Double) -> SignalspecdaniellMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn signal_spec_daniell_matrix_identity(n : Int) -> SignalspecdaniellMatrix {
  let m = signal_spec_daniell_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn signal_spec_daniell_matrix_get(m : SignalspecdaniellMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn signal_spec_daniell_matrix_transpose(m : SignalspecdaniellMatrix) -> SignalspecdaniellMatrix {
  let result = signal_spec_daniell_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn signal_spec_daniell_matrix_add(a : SignalspecdaniellMatrix, b : SignalspecdaniellMatrix) -> SignalspecdaniellMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = signal_spec_daniell_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn signal_spec_daniell_matrix_scale(m : SignalspecdaniellMatrix, s : Double) -> SignalspecdaniellMatrix {
  let result = signal_spec_daniell_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn signal_spec_daniell_matrix_multiply(a : SignalspecdaniellMatrix, b : SignalspecdaniellMatrix) -> SignalspecdaniellMatrix {
  if a.cols != b.rows { return signal_spec_daniell_make_matrix(a.rows, b.cols, 0.0) }
  let result = signal_spec_daniell_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn signal_spec_daniell_matrix_trace(m : SignalspecdaniellMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn signal_spec_daniell_matrix_det(m : SignalspecdaniellMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn signal_spec_daniell_matrix_norm(m : SignalspecdaniellMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  signal_spec_daniell_sqrt(sum)
}

pub fn signal_spec_daniell_matrix_to_string(m : SignalspecdaniellMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + signal_spec_daniell_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct SignalspecdaniellVector {
  comps : Array[Double]
  dim : Int
}

pub fn signal_spec_daniell_make_vector(comps : Array[Double]) -> SignalspecdaniellVector {
  { comps, dim: comps.length() }
}

pub fn signal_spec_daniell_vector_zero(dim : Int) -> SignalspecdaniellVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn signal_spec_daniell_vector_add(a : SignalspecdaniellVector, b : SignalspecdaniellVector) -> SignalspecdaniellVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = signal_spec_daniell_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn signal_spec_daniell_vector_sub(a : SignalspecdaniellVector, b : SignalspecdaniellVector) -> SignalspecdaniellVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = signal_spec_daniell_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn signal_spec_daniell_vector_scale(v : SignalspecdaniellVector, s : Double) -> SignalspecdaniellVector {
  let mut result = []
  for i in 0..<v.dim { result = signal_spec_daniell_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn signal_spec_daniell_vector_dot(a : SignalspecdaniellVector, b : SignalspecdaniellVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn signal_spec_daniell_vector_norm(v : SignalspecdaniellVector) -> Double { signal_spec_daniell_sqrt(signal_spec_daniell_vector_dot(v, v)) }

pub fn signal_spec_daniell_vector_normalize(v : SignalspecdaniellVector) -> SignalspecdaniellVector {
  let n = signal_spec_daniell_vector_norm(v)
  if n < 0.0000001 { v } else { signal_spec_daniell_vector_scale(v, 1.0 / n) }
}

pub fn signal_spec_daniell_vector_dist(a : SignalspecdaniellVector, b : SignalspecdaniellVector) -> Double {
  signal_spec_daniell_vector_norm(signal_spec_daniell_vector_sub(a, b))
}

pub fn signal_spec_daniell_vector_to_string(v : SignalspecdaniellVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + signal_spec_daniell_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn signal_spec_daniell_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn signal_spec_daniell_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = signal_spec_daniell_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn signal_spec_daniell_std(data : Array[Double]) -> Double { signal_spec_daniell_sqrt(signal_spec_daniell_var(data)) }

pub fn signal_spec_daniell_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = signal_spec_daniell_mean(a); let mb = signal_spec_daniell_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn signal_spec_daniell_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = signal_spec_daniell_std(a); let sb = signal_spec_daniell_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { signal_spec_daniell_cov(a, b) / (sa * sb) }
}

pub fn signal_spec_daniell_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = signal_spec_daniell_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn signal_spec_daniell_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn signal_spec_daniell_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn signal_spec_daniell_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  signal_spec_daniell_sqrt(signal_spec_daniell_mse(pred, labels))
}

pub fn signal_spec_daniell_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + signal_spec_daniell_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn signal_spec_daniell_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = signal_spec_daniell_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn signal_spec_daniell_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn signal_spec_daniell_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn signal_spec_daniell_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = signal_spec_daniell_precision(pred, labels, pos); let r = signal_spec_daniell_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn signal_spec_daniell_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn signal_spec_daniell_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = signal_spec_daniell_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn signal_spec_daniell_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn signal_spec_daniell_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn signal_spec_daniell_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = signal_spec_daniell_gcd(a, b)
    (a / g) * b
  }
}

pub fn signal_spec_daniell_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn signal_spec_daniell_fibonacci(n : Int) -> Int {
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

pub fn signal_spec_daniell_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = signal_spec_daniell_min(data); let mx = signal_spec_daniell_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn signal_spec_daniell_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = signal_spec_daniell_mean(data); let sd = signal_spec_daniell_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn signal_spec_daniell_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn signal_spec_daniell_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn signal_spec_daniell_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn signal_spec_daniell_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn signal_spec_daniell_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn signal_spec_daniell_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn signal_spec_daniell_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn signal_spec_daniell_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn signal_spec_daniell_dbl(x : Double) -> String {
  let i = if x >= 0.0 { signal_spec_daniell_int(x) } else { -signal_spec_daniell_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { signal_spec_daniell_int(f * 1000000.0) } else { signal_spec_daniell_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn signal_spec_daniell_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn signal_spec_daniell_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct SignalspecdaniellFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_daniell_frame_make(size : Int) -> SignalspecdaniellFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_daniell_frame_len(s : SignalspecdaniellFrame) -> Int { s.size }

pub fn signal_spec_daniell_frame_get(s : SignalspecdaniellFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_daniell_frame_set(s : SignalspecdaniellFrame, i : Int, v : Double) -> SignalspecdaniellFrame {
  let result = signal_spec_daniell_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_spec_daniell_frame_sum(s : SignalspecdaniellFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_spec_daniell_frame_mean(s : SignalspecdaniellFrame) -> Double {
  if s.size == 0 { 0.0 } else { signal_spec_daniell_frame_sum(s) / s.size.to_double() }
}

pub fn signal_spec_daniell_frame_scale(s : SignalspecdaniellFrame, f : Double) -> SignalspecdaniellFrame {
  let result = signal_spec_daniell_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_spec_daniell_frame_add(a : SignalspecdaniellFrame, b : SignalspecdaniellFrame) -> SignalspecdaniellFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_spec_daniell_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_spec_daniell_frame_copy(s : SignalspecdaniellFrame) -> SignalspecdaniellFrame {
  let result = signal_spec_daniell_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_spec_daniell_frame_fill(s : SignalspecdaniellFrame, v : Double) -> SignalspecdaniellFrame {
  let result = signal_spec_daniell_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_spec_daniell_frame_min(s : SignalspecdaniellFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_spec_daniell_frame_max(s : SignalspecdaniellFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_spec_daniell_frame_to_string(s : SignalspecdaniellFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecdaniellTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_daniell_table_make(size : Int) -> SignalspecdaniellTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_daniell_table_len(s : SignalspecdaniellTable) -> Int { s.size }

pub fn signal_spec_daniell_table_get(s : SignalspecdaniellTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_daniell_table_set(s : SignalspecdaniellTable, i : Int, v : Double) -> SignalspecdaniellTable {
  let result = signal_spec_daniell_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_spec_daniell_table_sum(s : SignalspecdaniellTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_spec_daniell_table_mean(s : SignalspecdaniellTable) -> Double {
  if s.size == 0 { 0.0 } else { signal_spec_daniell_table_sum(s) / s.size.to_double() }
}

pub fn signal_spec_daniell_table_scale(s : SignalspecdaniellTable, f : Double) -> SignalspecdaniellTable {
  let result = signal_spec_daniell_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_spec_daniell_table_add(a : SignalspecdaniellTable, b : SignalspecdaniellTable) -> SignalspecdaniellTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_spec_daniell_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_spec_daniell_table_copy(s : SignalspecdaniellTable) -> SignalspecdaniellTable {
  let result = signal_spec_daniell_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_spec_daniell_table_fill(s : SignalspecdaniellTable, v : Double) -> SignalspecdaniellTable {
  let result = signal_spec_daniell_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_spec_daniell_table_min(s : SignalspecdaniellTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_spec_daniell_table_max(s : SignalspecdaniellTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_spec_daniell_table_to_string(s : SignalspecdaniellTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecdaniellGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_daniell_graphn_make(size : Int) -> SignalspecdaniellGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_daniell_graphn_len(s : SignalspecdaniellGraphN) -> Int { s.size }

pub fn signal_spec_daniell_graphn_get(s : SignalspecdaniellGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_daniell_graphn_set(s : SignalspecdaniellGraphN, i : Int, v : Double) -> SignalspecdaniellGraphN {
  let result = signal_spec_daniell_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_spec_daniell_graphn_sum(s : SignalspecdaniellGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_spec_daniell_graphn_mean(s : SignalspecdaniellGraphN) -> Double {
  if s.size == 0 { 0.0 } else { signal_spec_daniell_graphn_sum(s) / s.size.to_double() }
}

pub fn signal_spec_daniell_graphn_scale(s : SignalspecdaniellGraphN, f : Double) -> SignalspecdaniellGraphN {
  let result = signal_spec_daniell_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_spec_daniell_graphn_add(a : SignalspecdaniellGraphN, b : SignalspecdaniellGraphN) -> SignalspecdaniellGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_spec_daniell_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_spec_daniell_graphn_copy(s : SignalspecdaniellGraphN) -> SignalspecdaniellGraphN {
  let result = signal_spec_daniell_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_spec_daniell_graphn_fill(s : SignalspecdaniellGraphN, v : Double) -> SignalspecdaniellGraphN {
  let result = signal_spec_daniell_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_spec_daniell_graphn_min(s : SignalspecdaniellGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_spec_daniell_graphn_max(s : SignalspecdaniellGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_spec_daniell_graphn_to_string(s : SignalspecdaniellGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecdaniellNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_daniell_node_make(size : Int) -> SignalspecdaniellNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_daniell_node_len(s : SignalspecdaniellNode) -> Int { s.size }

pub fn signal_spec_daniell_node_get(s : SignalspecdaniellNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_daniell_node_set(s : SignalspecdaniellNode, i : Int, v : Double) -> SignalspecdaniellNode {
  let result = signal_spec_daniell_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_spec_daniell_node_sum(s : SignalspecdaniellNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_spec_daniell_node_mean(s : SignalspecdaniellNode) -> Double {
  if s.size == 0 { 0.0 } else { signal_spec_daniell_node_sum(s) / s.size.to_double() }
}

pub fn signal_spec_daniell_node_scale(s : SignalspecdaniellNode, f : Double) -> SignalspecdaniellNode {
  let result = signal_spec_daniell_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_spec_daniell_node_add(a : SignalspecdaniellNode, b : SignalspecdaniellNode) -> SignalspecdaniellNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_spec_daniell_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_spec_daniell_node_copy(s : SignalspecdaniellNode) -> SignalspecdaniellNode {
  let result = signal_spec_daniell_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_spec_daniell_node_fill(s : SignalspecdaniellNode, v : Double) -> SignalspecdaniellNode {
  let result = signal_spec_daniell_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_spec_daniell_node_min(s : SignalspecdaniellNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_spec_daniell_node_max(s : SignalspecdaniellNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_spec_daniell_node_to_string(s : SignalspecdaniellNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecdaniellEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_daniell_edge_make(size : Int) -> SignalspecdaniellEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_daniell_edge_len(s : SignalspecdaniellEdge) -> Int { s.size }

pub fn signal_spec_daniell_edge_get(s : SignalspecdaniellEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_daniell_edge_set(s : SignalspecdaniellEdge, i : Int, v : Double) -> SignalspecdaniellEdge {
  let result = signal_spec_daniell_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_spec_daniell_edge_sum(s : SignalspecdaniellEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_spec_daniell_edge_mean(s : SignalspecdaniellEdge) -> Double {
  if s.size == 0 { 0.0 } else { signal_spec_daniell_edge_sum(s) / s.size.to_double() }
}

pub fn signal_spec_daniell_edge_scale(s : SignalspecdaniellEdge, f : Double) -> SignalspecdaniellEdge {
  let result = signal_spec_daniell_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_spec_daniell_edge_add(a : SignalspecdaniellEdge, b : SignalspecdaniellEdge) -> SignalspecdaniellEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_spec_daniell_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_spec_daniell_edge_copy(s : SignalspecdaniellEdge) -> SignalspecdaniellEdge {
  let result = signal_spec_daniell_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_spec_daniell_edge_fill(s : SignalspecdaniellEdge, v : Double) -> SignalspecdaniellEdge {
  let result = signal_spec_daniell_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_spec_daniell_edge_min(s : SignalspecdaniellEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_spec_daniell_edge_max(s : SignalspecdaniellEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_spec_daniell_edge_to_string(s : SignalspecdaniellEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecdaniellPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_daniell_path_make(size : Int) -> SignalspecdaniellPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_daniell_path_len(s : SignalspecdaniellPath) -> Int { s.size }

pub fn signal_spec_daniell_path_get(s : SignalspecdaniellPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_daniell_path_set(s : SignalspecdaniellPath, i : Int, v : Double) -> SignalspecdaniellPath {
  let result = signal_spec_daniell_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_spec_daniell_path_sum(s : SignalspecdaniellPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_spec_daniell_path_mean(s : SignalspecdaniellPath) -> Double {
  if s.size == 0 { 0.0 } else { signal_spec_daniell_path_sum(s) / s.size.to_double() }
}

pub fn signal_spec_daniell_path_scale(s : SignalspecdaniellPath, f : Double) -> SignalspecdaniellPath {
  let result = signal_spec_daniell_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_spec_daniell_path_add(a : SignalspecdaniellPath, b : SignalspecdaniellPath) -> SignalspecdaniellPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_spec_daniell_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_spec_daniell_path_copy(s : SignalspecdaniellPath) -> SignalspecdaniellPath {
  let result = signal_spec_daniell_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_spec_daniell_path_fill(s : SignalspecdaniellPath, v : Double) -> SignalspecdaniellPath {
  let result = signal_spec_daniell_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_spec_daniell_path_min(s : SignalspecdaniellPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_spec_daniell_path_max(s : SignalspecdaniellPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_spec_daniell_path_to_string(s : SignalspecdaniellPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecdaniellCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_daniell_cluster_make(size : Int) -> SignalspecdaniellCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_daniell_cluster_len(s : SignalspecdaniellCluster) -> Int { s.size }

pub fn signal_spec_daniell_cluster_get(s : SignalspecdaniellCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_daniell_cluster_set(s : SignalspecdaniellCluster, i : Int, v : Double) -> SignalspecdaniellCluster {
  let result = signal_spec_daniell_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_spec_daniell_cluster_sum(s : SignalspecdaniellCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_spec_daniell_cluster_mean(s : SignalspecdaniellCluster) -> Double {
  if s.size == 0 { 0.0 } else { signal_spec_daniell_cluster_sum(s) / s.size.to_double() }
}

pub fn signal_spec_daniell_cluster_scale(s : SignalspecdaniellCluster, f : Double) -> SignalspecdaniellCluster {
  let result = signal_spec_daniell_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_spec_daniell_cluster_add(a : SignalspecdaniellCluster, b : SignalspecdaniellCluster) -> SignalspecdaniellCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_spec_daniell_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_spec_daniell_cluster_copy(s : SignalspecdaniellCluster) -> SignalspecdaniellCluster {
  let result = signal_spec_daniell_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_spec_daniell_cluster_fill(s : SignalspecdaniellCluster, v : Double) -> SignalspecdaniellCluster {
  let result = signal_spec_daniell_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_spec_daniell_cluster_min(s : SignalspecdaniellCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_spec_daniell_cluster_max(s : SignalspecdaniellCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_spec_daniell_cluster_to_string(s : SignalspecdaniellCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecdaniellModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_daniell_model_make(size : Int) -> SignalspecdaniellModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_daniell_model_len(s : SignalspecdaniellModel) -> Int { s.size }

pub fn signal_spec_daniell_model_get(s : SignalspecdaniellModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_daniell_model_set(s : SignalspecdaniellModel, i : Int, v : Double) -> SignalspecdaniellModel {
  let result = signal_spec_daniell_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_spec_daniell_model_sum(s : SignalspecdaniellModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_spec_daniell_model_mean(s : SignalspecdaniellModel) -> Double {
  if s.size == 0 { 0.0 } else { signal_spec_daniell_model_sum(s) / s.size.to_double() }
}

pub fn signal_spec_daniell_model_scale(s : SignalspecdaniellModel, f : Double) -> SignalspecdaniellModel {
  let result = signal_spec_daniell_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_spec_daniell_model_add(a : SignalspecdaniellModel, b : SignalspecdaniellModel) -> SignalspecdaniellModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_spec_daniell_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_spec_daniell_model_copy(s : SignalspecdaniellModel) -> SignalspecdaniellModel {
  let result = signal_spec_daniell_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_spec_daniell_model_fill(s : SignalspecdaniellModel, v : Double) -> SignalspecdaniellModel {
  let result = signal_spec_daniell_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_spec_daniell_model_min(s : SignalspecdaniellModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_spec_daniell_model_max(s : SignalspecdaniellModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_spec_daniell_model_to_string(s : SignalspecdaniellModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecdaniellLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_daniell_layer_make(size : Int) -> SignalspecdaniellLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_daniell_layer_len(s : SignalspecdaniellLayer) -> Int { s.size }

pub fn signal_spec_daniell_layer_get(s : SignalspecdaniellLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_daniell_layer_set(s : SignalspecdaniellLayer, i : Int, v : Double) -> SignalspecdaniellLayer {
  let result = signal_spec_daniell_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_spec_daniell_layer_sum(s : SignalspecdaniellLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_spec_daniell_layer_mean(s : SignalspecdaniellLayer) -> Double {
  if s.size == 0 { 0.0 } else { signal_spec_daniell_layer_sum(s) / s.size.to_double() }
}

pub fn signal_spec_daniell_layer_scale(s : SignalspecdaniellLayer, f : Double) -> SignalspecdaniellLayer {
  let result = signal_spec_daniell_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_spec_daniell_layer_add(a : SignalspecdaniellLayer, b : SignalspecdaniellLayer) -> SignalspecdaniellLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_spec_daniell_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_spec_daniell_layer_copy(s : SignalspecdaniellLayer) -> SignalspecdaniellLayer {
  let result = signal_spec_daniell_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_spec_daniell_layer_fill(s : SignalspecdaniellLayer, v : Double) -> SignalspecdaniellLayer {
  let result = signal_spec_daniell_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_spec_daniell_layer_min(s : SignalspecdaniellLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_spec_daniell_layer_max(s : SignalspecdaniellLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_spec_daniell_layer_to_string(s : SignalspecdaniellLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecdaniellBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_daniell_buffer_make(size : Int) -> SignalspecdaniellBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_daniell_buffer_len(s : SignalspecdaniellBuffer) -> Int { s.size }

pub fn signal_spec_daniell_buffer_get(s : SignalspecdaniellBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_daniell_buffer_set(s : SignalspecdaniellBuffer, i : Int, v : Double) -> SignalspecdaniellBuffer {
  let result = signal_spec_daniell_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_spec_daniell_buffer_sum(s : SignalspecdaniellBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_spec_daniell_buffer_mean(s : SignalspecdaniellBuffer) -> Double {
  if s.size == 0 { 0.0 } else { signal_spec_daniell_buffer_sum(s) / s.size.to_double() }
}

pub fn signal_spec_daniell_buffer_scale(s : SignalspecdaniellBuffer, f : Double) -> SignalspecdaniellBuffer {
  let result = signal_spec_daniell_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_spec_daniell_buffer_add(a : SignalspecdaniellBuffer, b : SignalspecdaniellBuffer) -> SignalspecdaniellBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_spec_daniell_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_spec_daniell_buffer_copy(s : SignalspecdaniellBuffer) -> SignalspecdaniellBuffer {
  let result = signal_spec_daniell_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_spec_daniell_buffer_fill(s : SignalspecdaniellBuffer, v : Double) -> SignalspecdaniellBuffer {
  let result = signal_spec_daniell_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_spec_daniell_buffer_min(s : SignalspecdaniellBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_spec_daniell_buffer_max(s : SignalspecdaniellBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_spec_daniell_buffer_to_string(s : SignalspecdaniellBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecdaniellCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_daniell_cursor_make(size : Int) -> SignalspecdaniellCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_daniell_cursor_len(s : SignalspecdaniellCursor) -> Int { s.size }

pub fn signal_spec_daniell_cursor_get(s : SignalspecdaniellCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_daniell_cursor_set(s : SignalspecdaniellCursor, i : Int, v : Double) -> SignalspecdaniellCursor {
  let result = signal_spec_daniell_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_spec_daniell_cursor_sum(s : SignalspecdaniellCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_spec_daniell_cursor_mean(s : SignalspecdaniellCursor) -> Double {
  if s.size == 0 { 0.0 } else { signal_spec_daniell_cursor_sum(s) / s.size.to_double() }
}

pub fn signal_spec_daniell_cursor_scale(s : SignalspecdaniellCursor, f : Double) -> SignalspecdaniellCursor {
  let result = signal_spec_daniell_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_spec_daniell_cursor_add(a : SignalspecdaniellCursor, b : SignalspecdaniellCursor) -> SignalspecdaniellCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_spec_daniell_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_spec_daniell_cursor_copy(s : SignalspecdaniellCursor) -> SignalspecdaniellCursor {
  let result = signal_spec_daniell_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_spec_daniell_cursor_fill(s : SignalspecdaniellCursor, v : Double) -> SignalspecdaniellCursor {
  let result = signal_spec_daniell_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_spec_daniell_cursor_min(s : SignalspecdaniellCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_spec_daniell_cursor_max(s : SignalspecdaniellCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_spec_daniell_cursor_to_string(s : SignalspecdaniellCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecdaniellView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_daniell_view_make(size : Int) -> SignalspecdaniellView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_daniell_view_len(s : SignalspecdaniellView) -> Int { s.size }

pub fn signal_spec_daniell_view_get(s : SignalspecdaniellView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_daniell_view_set(s : SignalspecdaniellView, i : Int, v : Double) -> SignalspecdaniellView {
  let result = signal_spec_daniell_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_spec_daniell_view_sum(s : SignalspecdaniellView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_spec_daniell_view_mean(s : SignalspecdaniellView) -> Double {
  if s.size == 0 { 0.0 } else { signal_spec_daniell_view_sum(s) / s.size.to_double() }
}

pub fn signal_spec_daniell_view_scale(s : SignalspecdaniellView, f : Double) -> SignalspecdaniellView {
  let result = signal_spec_daniell_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_spec_daniell_view_add(a : SignalspecdaniellView, b : SignalspecdaniellView) -> SignalspecdaniellView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_spec_daniell_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_spec_daniell_view_copy(s : SignalspecdaniellView) -> SignalspecdaniellView {
  let result = signal_spec_daniell_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_spec_daniell_view_fill(s : SignalspecdaniellView, v : Double) -> SignalspecdaniellView {
  let result = signal_spec_daniell_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_spec_daniell_view_min(s : SignalspecdaniellView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_spec_daniell_view_max(s : SignalspecdaniellView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_spec_daniell_view_to_string(s : SignalspecdaniellView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecdaniellRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_daniell_range_make(size : Int) -> SignalspecdaniellRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_daniell_range_len(s : SignalspecdaniellRange) -> Int { s.size }

pub fn signal_spec_daniell_range_get(s : SignalspecdaniellRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_daniell_range_set(s : SignalspecdaniellRange, i : Int, v : Double) -> SignalspecdaniellRange {
  let result = signal_spec_daniell_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_spec_daniell_range_sum(s : SignalspecdaniellRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_spec_daniell_range_mean(s : SignalspecdaniellRange) -> Double {
  if s.size == 0 { 0.0 } else { signal_spec_daniell_range_sum(s) / s.size.to_double() }
}

pub fn signal_spec_daniell_range_scale(s : SignalspecdaniellRange, f : Double) -> SignalspecdaniellRange {
  let result = signal_spec_daniell_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_spec_daniell_range_add(a : SignalspecdaniellRange, b : SignalspecdaniellRange) -> SignalspecdaniellRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_spec_daniell_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_spec_daniell_range_copy(s : SignalspecdaniellRange) -> SignalspecdaniellRange {
  let result = signal_spec_daniell_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_spec_daniell_range_fill(s : SignalspecdaniellRange, v : Double) -> SignalspecdaniellRange {
  let result = signal_spec_daniell_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_spec_daniell_range_min(s : SignalspecdaniellRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_spec_daniell_range_max(s : SignalspecdaniellRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_spec_daniell_range_to_string(s : SignalspecdaniellRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecdaniellSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_daniell_slice_make(size : Int) -> SignalspecdaniellSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_daniell_slice_len(s : SignalspecdaniellSlice) -> Int { s.size }

pub fn signal_spec_daniell_slice_get(s : SignalspecdaniellSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_daniell_slice_set(s : SignalspecdaniellSlice, i : Int, v : Double) -> SignalspecdaniellSlice {
  let result = signal_spec_daniell_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_spec_daniell_slice_sum(s : SignalspecdaniellSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_spec_daniell_slice_mean(s : SignalspecdaniellSlice) -> Double {
  if s.size == 0 { 0.0 } else { signal_spec_daniell_slice_sum(s) / s.size.to_double() }
}

pub fn signal_spec_daniell_slice_scale(s : SignalspecdaniellSlice, f : Double) -> SignalspecdaniellSlice {
  let result = signal_spec_daniell_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_spec_daniell_slice_add(a : SignalspecdaniellSlice, b : SignalspecdaniellSlice) -> SignalspecdaniellSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_spec_daniell_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_spec_daniell_slice_copy(s : SignalspecdaniellSlice) -> SignalspecdaniellSlice {
  let result = signal_spec_daniell_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_spec_daniell_slice_fill(s : SignalspecdaniellSlice, v : Double) -> SignalspecdaniellSlice {
  let result = signal_spec_daniell_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_spec_daniell_slice_min(s : SignalspecdaniellSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_spec_daniell_slice_max(s : SignalspecdaniellSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_spec_daniell_slice_to_string(s : SignalspecdaniellSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn signal_spec_daniell_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_spec_daniell_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_spec_daniell_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_spec_daniell_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_spec_daniell_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_spec_daniell_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_spec_daniell_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_spec_daniell_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_spec_daniell_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_spec_daniell_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_spec_daniell_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_spec_daniell_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_spec_daniell_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_spec_daniell_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_spec_daniell_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_spec_daniell_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_spec_daniell_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_spec_daniell_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_spec_daniell_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_spec_daniell_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_spec_daniell_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_spec_daniell_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_spec_daniell_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_spec_daniell_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_spec_daniell_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

