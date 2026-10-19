///===
/// extcore/signal_filter_elliptic

pub(all) struct SignalfilterellipticPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn signal_filter_elliptic_make_point(x : Double, y : Double) -> SignalfilterellipticPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn signal_filter_elliptic_make_point3(x : Double, y : Double, z : Double) -> SignalfilterellipticPoint {
  { x, y, z, label: 0 }
}

pub fn signal_filter_elliptic_point_x(pt : SignalfilterellipticPoint) -> Double { pt.x }

pub fn signal_filter_elliptic_point_y(pt : SignalfilterellipticPoint) -> Double { pt.y }

pub fn signal_filter_elliptic_point_z(pt : SignalfilterellipticPoint) -> Double { pt.z }

pub fn signal_filter_elliptic_point_label(pt : SignalfilterellipticPoint) -> Int { pt.label }

pub fn signal_filter_elliptic_point_dist(a : SignalfilterellipticPoint, b : SignalfilterellipticPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn signal_filter_elliptic_point_add(a : SignalfilterellipticPoint, b : SignalfilterellipticPoint) -> SignalfilterellipticPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn signal_filter_elliptic_point_sub(a : SignalfilterellipticPoint, b : SignalfilterellipticPoint) -> SignalfilterellipticPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn signal_filter_elliptic_point_scale(pt : SignalfilterellipticPoint, s : Double) -> SignalfilterellipticPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn signal_filter_elliptic_point_dot(a : SignalfilterellipticPoint, b : SignalfilterellipticPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn signal_filter_elliptic_point_cross(a : SignalfilterellipticPoint, b : SignalfilterellipticPoint) -> SignalfilterellipticPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn signal_filter_elliptic_point_norm(pt : SignalfilterellipticPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn signal_filter_elliptic_point_normalize(pt : SignalfilterellipticPoint) -> SignalfilterellipticPoint {
  let n = signal_filter_elliptic_point_norm(pt)
  if n < 0.0000001 { pt } else { signal_filter_elliptic_point_scale(pt, 1.0 / n) }
}

pub fn signal_filter_elliptic_point_negate(pt : SignalfilterellipticPoint) -> SignalfilterellipticPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn signal_filter_elliptic_point_mid(a : SignalfilterellipticPoint, b : SignalfilterellipticPoint) -> SignalfilterellipticPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn signal_filter_elliptic_point_lerp(a : SignalfilterellipticPoint, b : SignalfilterellipticPoint, t : Double) -> SignalfilterellipticPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn signal_filter_elliptic_point_to_string(pt : SignalfilterellipticPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct SignalfilterellipticSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn signal_filter_elliptic_make_series(vals : Array[Double], name : String) -> SignalfilterellipticSeries {
  { vals, name, meta: 0 }
}

pub fn signal_filter_elliptic_series_len(s : SignalfilterellipticSeries) -> Int { s.vals.length() }

pub fn signal_filter_elliptic_series_sum(s : SignalfilterellipticSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn signal_filter_elliptic_series_mean(s : SignalfilterellipticSeries) -> Double {
  let n = signal_filter_elliptic_series_len(s)
  if n == 0 { 0.0 } else { signal_filter_elliptic_series_sum(s) / n.to_double() }
}

pub fn signal_filter_elliptic_series_min(s : SignalfilterellipticSeries) -> Double {
  let n = signal_filter_elliptic_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn signal_filter_elliptic_series_max(s : SignalfilterellipticSeries) -> Double {
  let n = signal_filter_elliptic_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn signal_filter_elliptic_series_range(s : SignalfilterellipticSeries) -> Double {
  signal_filter_elliptic_series_max(s) - signal_filter_elliptic_series_min(s)
}

pub fn signal_filter_elliptic_series_var(s : SignalfilterellipticSeries) -> Double {
  let n = signal_filter_elliptic_series_len(s)
  if n == 0 { 0.0 } else {
    let m = signal_filter_elliptic_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn signal_filter_elliptic_series_std(s : SignalfilterellipticSeries) -> Double { @_common.sqrt(signal_filter_elliptic_series_var(s)) }

pub fn signal_filter_elliptic_series_median(s : SignalfilterellipticSeries) -> Double {
  let n = signal_filter_elliptic_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = signal_filter_elliptic_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn signal_filter_elliptic_series_scale(s : SignalfilterellipticSeries, f : Double) -> SignalfilterellipticSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn signal_filter_elliptic_series_add(a : SignalfilterellipticSeries, b : SignalfilterellipticSeries) -> SignalfilterellipticSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn signal_filter_elliptic_series_sub(a : SignalfilterellipticSeries, b : SignalfilterellipticSeries) -> SignalfilterellipticSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn signal_filter_elliptic_series_normalize(s : SignalfilterellipticSeries) -> SignalfilterellipticSeries {
  let mn = signal_filter_elliptic_series_min(s)
  let mx = signal_filter_elliptic_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn signal_filter_elliptic_series_cumsum(s : SignalfilterellipticSeries) -> SignalfilterellipticSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn signal_filter_elliptic_series_to_string(s : SignalfilterellipticSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SignalfilterellipticMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn signal_filter_elliptic_make_matrix(rows : Int, cols : Int, val : Double) -> SignalfilterellipticMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn signal_filter_elliptic_matrix_identity(n : Int) -> SignalfilterellipticMatrix {
  let m = signal_filter_elliptic_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn signal_filter_elliptic_matrix_get(m : SignalfilterellipticMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn signal_filter_elliptic_matrix_transpose(m : SignalfilterellipticMatrix) -> SignalfilterellipticMatrix {
  let result = signal_filter_elliptic_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn signal_filter_elliptic_matrix_add(a : SignalfilterellipticMatrix, b : SignalfilterellipticMatrix) -> SignalfilterellipticMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = signal_filter_elliptic_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn signal_filter_elliptic_matrix_scale(m : SignalfilterellipticMatrix, s : Double) -> SignalfilterellipticMatrix {
  let result = signal_filter_elliptic_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn signal_filter_elliptic_matrix_multiply(a : SignalfilterellipticMatrix, b : SignalfilterellipticMatrix) -> SignalfilterellipticMatrix {
  if a.cols != b.rows { return signal_filter_elliptic_make_matrix(a.rows, b.cols, 0.0) }
  let result = signal_filter_elliptic_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn signal_filter_elliptic_matrix_trace(m : SignalfilterellipticMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn signal_filter_elliptic_matrix_det(m : SignalfilterellipticMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn signal_filter_elliptic_matrix_norm(m : SignalfilterellipticMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn signal_filter_elliptic_matrix_to_string(m : SignalfilterellipticMatrix) -> String {
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

pub(all) struct SignalfilterellipticVector {
  comps : Array[Double]
  dim : Int
}

pub fn signal_filter_elliptic_make_vector(comps : Array[Double]) -> SignalfilterellipticVector {
  { comps, dim: comps.length() }
}

pub fn signal_filter_elliptic_vector_zero(dim : Int) -> SignalfilterellipticVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn signal_filter_elliptic_vector_add(a : SignalfilterellipticVector, b : SignalfilterellipticVector) -> SignalfilterellipticVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn signal_filter_elliptic_vector_sub(a : SignalfilterellipticVector, b : SignalfilterellipticVector) -> SignalfilterellipticVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn signal_filter_elliptic_vector_scale(v : SignalfilterellipticVector, s : Double) -> SignalfilterellipticVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn signal_filter_elliptic_vector_dot(a : SignalfilterellipticVector, b : SignalfilterellipticVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn signal_filter_elliptic_vector_norm(v : SignalfilterellipticVector) -> Double { @_common.sqrt(signal_filter_elliptic_vector_dot(v, v)) }

pub fn signal_filter_elliptic_vector_normalize(v : SignalfilterellipticVector) -> SignalfilterellipticVector {
  let n = signal_filter_elliptic_vector_norm(v)
  if n < 0.0000001 { v } else { signal_filter_elliptic_vector_scale(v, 1.0 / n) }
}

pub fn signal_filter_elliptic_vector_dist(a : SignalfilterellipticVector, b : SignalfilterellipticVector) -> Double {
  signal_filter_elliptic_vector_norm(signal_filter_elliptic_vector_sub(a, b))
}

pub fn signal_filter_elliptic_vector_to_string(v : SignalfilterellipticVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn signal_filter_elliptic_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn signal_filter_elliptic_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = signal_filter_elliptic_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn signal_filter_elliptic_std(data : Array[Double]) -> Double { @_common.sqrt(signal_filter_elliptic_var(data)) }

pub fn signal_filter_elliptic_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = signal_filter_elliptic_mean(a); let mb = signal_filter_elliptic_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn signal_filter_elliptic_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = signal_filter_elliptic_std(a); let sb = signal_filter_elliptic_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { signal_filter_elliptic_cov(a, b) / (sa * sb) }
}

pub fn signal_filter_elliptic_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = signal_filter_elliptic_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn signal_filter_elliptic_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn signal_filter_elliptic_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn signal_filter_elliptic_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  @_common.sqrt(signal_filter_elliptic_mse(pred, labels))
}

pub fn signal_filter_elliptic_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn signal_filter_elliptic_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = signal_filter_elliptic_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn signal_filter_elliptic_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn signal_filter_elliptic_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn signal_filter_elliptic_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = signal_filter_elliptic_precision(pred, labels, pos); let r = signal_filter_elliptic_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn signal_filter_elliptic_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn signal_filter_elliptic_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = signal_filter_elliptic_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn signal_filter_elliptic_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn signal_filter_elliptic_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn signal_filter_elliptic_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = signal_filter_elliptic_gcd(a, b)
    (a / g) * b
  }
}

pub fn signal_filter_elliptic_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn signal_filter_elliptic_fibonacci(n : Int) -> Int {
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

pub fn signal_filter_elliptic_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = signal_filter_elliptic_min(data); let mx = signal_filter_elliptic_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn signal_filter_elliptic_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = signal_filter_elliptic_mean(data); let sd = signal_filter_elliptic_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn signal_filter_elliptic_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn signal_filter_elliptic_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn signal_filter_elliptic_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn signal_filter_elliptic_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn signal_filter_elliptic_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn signal_filter_elliptic_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

pub(all) struct SignalfilterellipticFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_elliptic_frame_make(size : Int) -> SignalfilterellipticFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_elliptic_frame_len(s : SignalfilterellipticFrame) -> Int { s.size }

pub fn signal_filter_elliptic_frame_get(s : SignalfilterellipticFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_elliptic_frame_set(s : SignalfilterellipticFrame, i : Int, v : Double) -> SignalfilterellipticFrame {
  let result = signal_filter_elliptic_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_filter_elliptic_frame_sum(s : SignalfilterellipticFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_filter_elliptic_frame_mean(s : SignalfilterellipticFrame) -> Double {
  if s.size == 0 { 0.0 } else { signal_filter_elliptic_frame_sum(s) / s.size.to_double() }
}

pub fn signal_filter_elliptic_frame_scale(s : SignalfilterellipticFrame, f : Double) -> SignalfilterellipticFrame {
  let result = signal_filter_elliptic_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_filter_elliptic_frame_add(a : SignalfilterellipticFrame, b : SignalfilterellipticFrame) -> SignalfilterellipticFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_filter_elliptic_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_filter_elliptic_frame_copy(s : SignalfilterellipticFrame) -> SignalfilterellipticFrame {
  let result = signal_filter_elliptic_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_filter_elliptic_frame_fill(s : SignalfilterellipticFrame, v : Double) -> SignalfilterellipticFrame {
  let result = signal_filter_elliptic_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_filter_elliptic_frame_min(s : SignalfilterellipticFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_filter_elliptic_frame_max(s : SignalfilterellipticFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_filter_elliptic_frame_to_string(s : SignalfilterellipticFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilterellipticTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_elliptic_table_make(size : Int) -> SignalfilterellipticTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_elliptic_table_len(s : SignalfilterellipticTable) -> Int { s.size }

pub fn signal_filter_elliptic_table_get(s : SignalfilterellipticTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_elliptic_table_set(s : SignalfilterellipticTable, i : Int, v : Double) -> SignalfilterellipticTable {
  let result = signal_filter_elliptic_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_filter_elliptic_table_sum(s : SignalfilterellipticTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_filter_elliptic_table_mean(s : SignalfilterellipticTable) -> Double {
  if s.size == 0 { 0.0 } else { signal_filter_elliptic_table_sum(s) / s.size.to_double() }
}

pub fn signal_filter_elliptic_table_scale(s : SignalfilterellipticTable, f : Double) -> SignalfilterellipticTable {
  let result = signal_filter_elliptic_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_filter_elliptic_table_add(a : SignalfilterellipticTable, b : SignalfilterellipticTable) -> SignalfilterellipticTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_filter_elliptic_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_filter_elliptic_table_copy(s : SignalfilterellipticTable) -> SignalfilterellipticTable {
  let result = signal_filter_elliptic_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_filter_elliptic_table_fill(s : SignalfilterellipticTable, v : Double) -> SignalfilterellipticTable {
  let result = signal_filter_elliptic_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_filter_elliptic_table_min(s : SignalfilterellipticTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_filter_elliptic_table_max(s : SignalfilterellipticTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_filter_elliptic_table_to_string(s : SignalfilterellipticTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilterellipticGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_elliptic_graphn_make(size : Int) -> SignalfilterellipticGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_elliptic_graphn_len(s : SignalfilterellipticGraphN) -> Int { s.size }

pub fn signal_filter_elliptic_graphn_get(s : SignalfilterellipticGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_elliptic_graphn_set(s : SignalfilterellipticGraphN, i : Int, v : Double) -> SignalfilterellipticGraphN {
  let result = signal_filter_elliptic_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_filter_elliptic_graphn_sum(s : SignalfilterellipticGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_filter_elliptic_graphn_mean(s : SignalfilterellipticGraphN) -> Double {
  if s.size == 0 { 0.0 } else { signal_filter_elliptic_graphn_sum(s) / s.size.to_double() }
}

pub fn signal_filter_elliptic_graphn_scale(s : SignalfilterellipticGraphN, f : Double) -> SignalfilterellipticGraphN {
  let result = signal_filter_elliptic_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_filter_elliptic_graphn_add(a : SignalfilterellipticGraphN, b : SignalfilterellipticGraphN) -> SignalfilterellipticGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_filter_elliptic_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_filter_elliptic_graphn_copy(s : SignalfilterellipticGraphN) -> SignalfilterellipticGraphN {
  let result = signal_filter_elliptic_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_filter_elliptic_graphn_fill(s : SignalfilterellipticGraphN, v : Double) -> SignalfilterellipticGraphN {
  let result = signal_filter_elliptic_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_filter_elliptic_graphn_min(s : SignalfilterellipticGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_filter_elliptic_graphn_max(s : SignalfilterellipticGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_filter_elliptic_graphn_to_string(s : SignalfilterellipticGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilterellipticNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_elliptic_node_make(size : Int) -> SignalfilterellipticNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_elliptic_node_len(s : SignalfilterellipticNode) -> Int { s.size }

pub fn signal_filter_elliptic_node_get(s : SignalfilterellipticNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_elliptic_node_set(s : SignalfilterellipticNode, i : Int, v : Double) -> SignalfilterellipticNode {
  let result = signal_filter_elliptic_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_filter_elliptic_node_sum(s : SignalfilterellipticNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_filter_elliptic_node_mean(s : SignalfilterellipticNode) -> Double {
  if s.size == 0 { 0.0 } else { signal_filter_elliptic_node_sum(s) / s.size.to_double() }
}

pub fn signal_filter_elliptic_node_scale(s : SignalfilterellipticNode, f : Double) -> SignalfilterellipticNode {
  let result = signal_filter_elliptic_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_filter_elliptic_node_add(a : SignalfilterellipticNode, b : SignalfilterellipticNode) -> SignalfilterellipticNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_filter_elliptic_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_filter_elliptic_node_copy(s : SignalfilterellipticNode) -> SignalfilterellipticNode {
  let result = signal_filter_elliptic_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_filter_elliptic_node_fill(s : SignalfilterellipticNode, v : Double) -> SignalfilterellipticNode {
  let result = signal_filter_elliptic_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_filter_elliptic_node_min(s : SignalfilterellipticNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_filter_elliptic_node_max(s : SignalfilterellipticNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_filter_elliptic_node_to_string(s : SignalfilterellipticNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilterellipticEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_elliptic_edge_make(size : Int) -> SignalfilterellipticEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_elliptic_edge_len(s : SignalfilterellipticEdge) -> Int { s.size }

pub fn signal_filter_elliptic_edge_get(s : SignalfilterellipticEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_elliptic_edge_set(s : SignalfilterellipticEdge, i : Int, v : Double) -> SignalfilterellipticEdge {
  let result = signal_filter_elliptic_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_filter_elliptic_edge_sum(s : SignalfilterellipticEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_filter_elliptic_edge_mean(s : SignalfilterellipticEdge) -> Double {
  if s.size == 0 { 0.0 } else { signal_filter_elliptic_edge_sum(s) / s.size.to_double() }
}

pub fn signal_filter_elliptic_edge_scale(s : SignalfilterellipticEdge, f : Double) -> SignalfilterellipticEdge {
  let result = signal_filter_elliptic_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_filter_elliptic_edge_add(a : SignalfilterellipticEdge, b : SignalfilterellipticEdge) -> SignalfilterellipticEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_filter_elliptic_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_filter_elliptic_edge_copy(s : SignalfilterellipticEdge) -> SignalfilterellipticEdge {
  let result = signal_filter_elliptic_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_filter_elliptic_edge_fill(s : SignalfilterellipticEdge, v : Double) -> SignalfilterellipticEdge {
  let result = signal_filter_elliptic_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_filter_elliptic_edge_min(s : SignalfilterellipticEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_filter_elliptic_edge_max(s : SignalfilterellipticEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_filter_elliptic_edge_to_string(s : SignalfilterellipticEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilterellipticPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_elliptic_path_make(size : Int) -> SignalfilterellipticPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_elliptic_path_len(s : SignalfilterellipticPath) -> Int { s.size }

pub fn signal_filter_elliptic_path_get(s : SignalfilterellipticPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_elliptic_path_set(s : SignalfilterellipticPath, i : Int, v : Double) -> SignalfilterellipticPath {
  let result = signal_filter_elliptic_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_filter_elliptic_path_sum(s : SignalfilterellipticPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_filter_elliptic_path_mean(s : SignalfilterellipticPath) -> Double {
  if s.size == 0 { 0.0 } else { signal_filter_elliptic_path_sum(s) / s.size.to_double() }
}

pub fn signal_filter_elliptic_path_scale(s : SignalfilterellipticPath, f : Double) -> SignalfilterellipticPath {
  let result = signal_filter_elliptic_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_filter_elliptic_path_add(a : SignalfilterellipticPath, b : SignalfilterellipticPath) -> SignalfilterellipticPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_filter_elliptic_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_filter_elliptic_path_copy(s : SignalfilterellipticPath) -> SignalfilterellipticPath {
  let result = signal_filter_elliptic_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_filter_elliptic_path_fill(s : SignalfilterellipticPath, v : Double) -> SignalfilterellipticPath {
  let result = signal_filter_elliptic_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_filter_elliptic_path_min(s : SignalfilterellipticPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_filter_elliptic_path_max(s : SignalfilterellipticPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_filter_elliptic_path_to_string(s : SignalfilterellipticPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilterellipticCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_elliptic_cluster_make(size : Int) -> SignalfilterellipticCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_elliptic_cluster_len(s : SignalfilterellipticCluster) -> Int { s.size }

pub fn signal_filter_elliptic_cluster_get(s : SignalfilterellipticCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_elliptic_cluster_set(s : SignalfilterellipticCluster, i : Int, v : Double) -> SignalfilterellipticCluster {
  let result = signal_filter_elliptic_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_filter_elliptic_cluster_sum(s : SignalfilterellipticCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_filter_elliptic_cluster_mean(s : SignalfilterellipticCluster) -> Double {
  if s.size == 0 { 0.0 } else { signal_filter_elliptic_cluster_sum(s) / s.size.to_double() }
}

pub fn signal_filter_elliptic_cluster_scale(s : SignalfilterellipticCluster, f : Double) -> SignalfilterellipticCluster {
  let result = signal_filter_elliptic_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_filter_elliptic_cluster_add(a : SignalfilterellipticCluster, b : SignalfilterellipticCluster) -> SignalfilterellipticCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_filter_elliptic_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_filter_elliptic_cluster_copy(s : SignalfilterellipticCluster) -> SignalfilterellipticCluster {
  let result = signal_filter_elliptic_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_filter_elliptic_cluster_fill(s : SignalfilterellipticCluster, v : Double) -> SignalfilterellipticCluster {
  let result = signal_filter_elliptic_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_filter_elliptic_cluster_min(s : SignalfilterellipticCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_filter_elliptic_cluster_max(s : SignalfilterellipticCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_filter_elliptic_cluster_to_string(s : SignalfilterellipticCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilterellipticModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_elliptic_model_make(size : Int) -> SignalfilterellipticModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_elliptic_model_len(s : SignalfilterellipticModel) -> Int { s.size }

pub fn signal_filter_elliptic_model_get(s : SignalfilterellipticModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_elliptic_model_set(s : SignalfilterellipticModel, i : Int, v : Double) -> SignalfilterellipticModel {
  let result = signal_filter_elliptic_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_filter_elliptic_model_sum(s : SignalfilterellipticModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_filter_elliptic_model_mean(s : SignalfilterellipticModel) -> Double {
  if s.size == 0 { 0.0 } else { signal_filter_elliptic_model_sum(s) / s.size.to_double() }
}

pub fn signal_filter_elliptic_model_scale(s : SignalfilterellipticModel, f : Double) -> SignalfilterellipticModel {
  let result = signal_filter_elliptic_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_filter_elliptic_model_add(a : SignalfilterellipticModel, b : SignalfilterellipticModel) -> SignalfilterellipticModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_filter_elliptic_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_filter_elliptic_model_copy(s : SignalfilterellipticModel) -> SignalfilterellipticModel {
  let result = signal_filter_elliptic_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_filter_elliptic_model_fill(s : SignalfilterellipticModel, v : Double) -> SignalfilterellipticModel {
  let result = signal_filter_elliptic_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_filter_elliptic_model_min(s : SignalfilterellipticModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_filter_elliptic_model_max(s : SignalfilterellipticModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_filter_elliptic_model_to_string(s : SignalfilterellipticModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilterellipticLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_elliptic_layer_make(size : Int) -> SignalfilterellipticLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_elliptic_layer_len(s : SignalfilterellipticLayer) -> Int { s.size }

pub fn signal_filter_elliptic_layer_get(s : SignalfilterellipticLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_elliptic_layer_set(s : SignalfilterellipticLayer, i : Int, v : Double) -> SignalfilterellipticLayer {
  let result = signal_filter_elliptic_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_filter_elliptic_layer_sum(s : SignalfilterellipticLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_filter_elliptic_layer_mean(s : SignalfilterellipticLayer) -> Double {
  if s.size == 0 { 0.0 } else { signal_filter_elliptic_layer_sum(s) / s.size.to_double() }
}

pub fn signal_filter_elliptic_layer_scale(s : SignalfilterellipticLayer, f : Double) -> SignalfilterellipticLayer {
  let result = signal_filter_elliptic_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_filter_elliptic_layer_add(a : SignalfilterellipticLayer, b : SignalfilterellipticLayer) -> SignalfilterellipticLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_filter_elliptic_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_filter_elliptic_layer_copy(s : SignalfilterellipticLayer) -> SignalfilterellipticLayer {
  let result = signal_filter_elliptic_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_filter_elliptic_layer_fill(s : SignalfilterellipticLayer, v : Double) -> SignalfilterellipticLayer {
  let result = signal_filter_elliptic_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_filter_elliptic_layer_min(s : SignalfilterellipticLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_filter_elliptic_layer_max(s : SignalfilterellipticLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_filter_elliptic_layer_to_string(s : SignalfilterellipticLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilterellipticBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_elliptic_buffer_make(size : Int) -> SignalfilterellipticBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_elliptic_buffer_len(s : SignalfilterellipticBuffer) -> Int { s.size }

pub fn signal_filter_elliptic_buffer_get(s : SignalfilterellipticBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_elliptic_buffer_set(s : SignalfilterellipticBuffer, i : Int, v : Double) -> SignalfilterellipticBuffer {
  let result = signal_filter_elliptic_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_filter_elliptic_buffer_sum(s : SignalfilterellipticBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_filter_elliptic_buffer_mean(s : SignalfilterellipticBuffer) -> Double {
  if s.size == 0 { 0.0 } else { signal_filter_elliptic_buffer_sum(s) / s.size.to_double() }
}

pub fn signal_filter_elliptic_buffer_scale(s : SignalfilterellipticBuffer, f : Double) -> SignalfilterellipticBuffer {
  let result = signal_filter_elliptic_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_filter_elliptic_buffer_add(a : SignalfilterellipticBuffer, b : SignalfilterellipticBuffer) -> SignalfilterellipticBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_filter_elliptic_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_filter_elliptic_buffer_copy(s : SignalfilterellipticBuffer) -> SignalfilterellipticBuffer {
  let result = signal_filter_elliptic_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_filter_elliptic_buffer_fill(s : SignalfilterellipticBuffer, v : Double) -> SignalfilterellipticBuffer {
  let result = signal_filter_elliptic_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_filter_elliptic_buffer_min(s : SignalfilterellipticBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_filter_elliptic_buffer_max(s : SignalfilterellipticBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_filter_elliptic_buffer_to_string(s : SignalfilterellipticBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilterellipticCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_elliptic_cursor_make(size : Int) -> SignalfilterellipticCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_elliptic_cursor_len(s : SignalfilterellipticCursor) -> Int { s.size }

pub fn signal_filter_elliptic_cursor_get(s : SignalfilterellipticCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_elliptic_cursor_set(s : SignalfilterellipticCursor, i : Int, v : Double) -> SignalfilterellipticCursor {
  let result = signal_filter_elliptic_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_filter_elliptic_cursor_sum(s : SignalfilterellipticCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_filter_elliptic_cursor_mean(s : SignalfilterellipticCursor) -> Double {
  if s.size == 0 { 0.0 } else { signal_filter_elliptic_cursor_sum(s) / s.size.to_double() }
}

pub fn signal_filter_elliptic_cursor_scale(s : SignalfilterellipticCursor, f : Double) -> SignalfilterellipticCursor {
  let result = signal_filter_elliptic_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_filter_elliptic_cursor_add(a : SignalfilterellipticCursor, b : SignalfilterellipticCursor) -> SignalfilterellipticCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_filter_elliptic_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_filter_elliptic_cursor_copy(s : SignalfilterellipticCursor) -> SignalfilterellipticCursor {
  let result = signal_filter_elliptic_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_filter_elliptic_cursor_fill(s : SignalfilterellipticCursor, v : Double) -> SignalfilterellipticCursor {
  let result = signal_filter_elliptic_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_filter_elliptic_cursor_min(s : SignalfilterellipticCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_filter_elliptic_cursor_max(s : SignalfilterellipticCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_filter_elliptic_cursor_to_string(s : SignalfilterellipticCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilterellipticView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_elliptic_view_make(size : Int) -> SignalfilterellipticView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_elliptic_view_len(s : SignalfilterellipticView) -> Int { s.size }

pub fn signal_filter_elliptic_view_get(s : SignalfilterellipticView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_elliptic_view_set(s : SignalfilterellipticView, i : Int, v : Double) -> SignalfilterellipticView {
  let result = signal_filter_elliptic_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_filter_elliptic_view_sum(s : SignalfilterellipticView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_filter_elliptic_view_mean(s : SignalfilterellipticView) -> Double {
  if s.size == 0 { 0.0 } else { signal_filter_elliptic_view_sum(s) / s.size.to_double() }
}

pub fn signal_filter_elliptic_view_scale(s : SignalfilterellipticView, f : Double) -> SignalfilterellipticView {
  let result = signal_filter_elliptic_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_filter_elliptic_view_add(a : SignalfilterellipticView, b : SignalfilterellipticView) -> SignalfilterellipticView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_filter_elliptic_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_filter_elliptic_view_copy(s : SignalfilterellipticView) -> SignalfilterellipticView {
  let result = signal_filter_elliptic_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_filter_elliptic_view_fill(s : SignalfilterellipticView, v : Double) -> SignalfilterellipticView {
  let result = signal_filter_elliptic_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_filter_elliptic_view_min(s : SignalfilterellipticView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_filter_elliptic_view_max(s : SignalfilterellipticView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_filter_elliptic_view_to_string(s : SignalfilterellipticView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilterellipticRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_elliptic_range_make(size : Int) -> SignalfilterellipticRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_elliptic_range_len(s : SignalfilterellipticRange) -> Int { s.size }

pub fn signal_filter_elliptic_range_get(s : SignalfilterellipticRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_elliptic_range_set(s : SignalfilterellipticRange, i : Int, v : Double) -> SignalfilterellipticRange {
  let result = signal_filter_elliptic_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_filter_elliptic_range_sum(s : SignalfilterellipticRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_filter_elliptic_range_mean(s : SignalfilterellipticRange) -> Double {
  if s.size == 0 { 0.0 } else { signal_filter_elliptic_range_sum(s) / s.size.to_double() }
}

pub fn signal_filter_elliptic_range_scale(s : SignalfilterellipticRange, f : Double) -> SignalfilterellipticRange {
  let result = signal_filter_elliptic_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_filter_elliptic_range_add(a : SignalfilterellipticRange, b : SignalfilterellipticRange) -> SignalfilterellipticRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_filter_elliptic_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_filter_elliptic_range_copy(s : SignalfilterellipticRange) -> SignalfilterellipticRange {
  let result = signal_filter_elliptic_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_filter_elliptic_range_fill(s : SignalfilterellipticRange, v : Double) -> SignalfilterellipticRange {
  let result = signal_filter_elliptic_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_filter_elliptic_range_min(s : SignalfilterellipticRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_filter_elliptic_range_max(s : SignalfilterellipticRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_filter_elliptic_range_to_string(s : SignalfilterellipticRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilterellipticSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_elliptic_slice_make(size : Int) -> SignalfilterellipticSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_elliptic_slice_len(s : SignalfilterellipticSlice) -> Int { s.size }

pub fn signal_filter_elliptic_slice_get(s : SignalfilterellipticSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_elliptic_slice_set(s : SignalfilterellipticSlice, i : Int, v : Double) -> SignalfilterellipticSlice {
  let result = signal_filter_elliptic_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_filter_elliptic_slice_sum(s : SignalfilterellipticSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_filter_elliptic_slice_mean(s : SignalfilterellipticSlice) -> Double {
  if s.size == 0 { 0.0 } else { signal_filter_elliptic_slice_sum(s) / s.size.to_double() }
}

pub fn signal_filter_elliptic_slice_scale(s : SignalfilterellipticSlice, f : Double) -> SignalfilterellipticSlice {
  let result = signal_filter_elliptic_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_filter_elliptic_slice_add(a : SignalfilterellipticSlice, b : SignalfilterellipticSlice) -> SignalfilterellipticSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_filter_elliptic_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_filter_elliptic_slice_copy(s : SignalfilterellipticSlice) -> SignalfilterellipticSlice {
  let result = signal_filter_elliptic_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_filter_elliptic_slice_fill(s : SignalfilterellipticSlice, v : Double) -> SignalfilterellipticSlice {
  let result = signal_filter_elliptic_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_filter_elliptic_slice_min(s : SignalfilterellipticSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_filter_elliptic_slice_max(s : SignalfilterellipticSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_filter_elliptic_slice_to_string(s : SignalfilterellipticSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

