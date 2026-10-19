///===
/// extcore/signal_spec_min_norm

pub(all) struct SignalspecminnormPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn signal_spec_min_norm_make_point(x : Double, y : Double) -> SignalspecminnormPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn signal_spec_min_norm_make_point3(x : Double, y : Double, z : Double) -> SignalspecminnormPoint {
  { x, y, z, label: 0 }
}

pub fn signal_spec_min_norm_point_x(pt : SignalspecminnormPoint) -> Double { pt.x }

pub fn signal_spec_min_norm_point_y(pt : SignalspecminnormPoint) -> Double { pt.y }

pub fn signal_spec_min_norm_point_z(pt : SignalspecminnormPoint) -> Double { pt.z }

pub fn signal_spec_min_norm_point_label(pt : SignalspecminnormPoint) -> Int { pt.label }

pub fn signal_spec_min_norm_point_dist(a : SignalspecminnormPoint, b : SignalspecminnormPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  signal_spec_min_norm_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn signal_spec_min_norm_point_add(a : SignalspecminnormPoint, b : SignalspecminnormPoint) -> SignalspecminnormPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn signal_spec_min_norm_point_sub(a : SignalspecminnormPoint, b : SignalspecminnormPoint) -> SignalspecminnormPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn signal_spec_min_norm_point_scale(pt : SignalspecminnormPoint, s : Double) -> SignalspecminnormPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn signal_spec_min_norm_point_dot(a : SignalspecminnormPoint, b : SignalspecminnormPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn signal_spec_min_norm_point_cross(a : SignalspecminnormPoint, b : SignalspecminnormPoint) -> SignalspecminnormPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn signal_spec_min_norm_point_norm(pt : SignalspecminnormPoint) -> Double {
  signal_spec_min_norm_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn signal_spec_min_norm_point_normalize(pt : SignalspecminnormPoint) -> SignalspecminnormPoint {
  let n = signal_spec_min_norm_point_norm(pt)
  if n < 0.0000001 { pt } else { signal_spec_min_norm_point_scale(pt, 1.0 / n) }
}

pub fn signal_spec_min_norm_point_negate(pt : SignalspecminnormPoint) -> SignalspecminnormPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn signal_spec_min_norm_point_mid(a : SignalspecminnormPoint, b : SignalspecminnormPoint) -> SignalspecminnormPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn signal_spec_min_norm_point_lerp(a : SignalspecminnormPoint, b : SignalspecminnormPoint, t : Double) -> SignalspecminnormPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn signal_spec_min_norm_point_to_string(pt : SignalspecminnormPoint) -> String {
  "(" + signal_spec_min_norm_dbl(pt.x) + ", " + signal_spec_min_norm_dbl(pt.y) + ", " + signal_spec_min_norm_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct SignalspecminnormSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn signal_spec_min_norm_make_series(vals : Array[Double], name : String) -> SignalspecminnormSeries {
  { vals, name, meta: 0 }
}

pub fn signal_spec_min_norm_series_len(s : SignalspecminnormSeries) -> Int { s.vals.length() }

pub fn signal_spec_min_norm_series_sum(s : SignalspecminnormSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn signal_spec_min_norm_series_mean(s : SignalspecminnormSeries) -> Double {
  let n = signal_spec_min_norm_series_len(s)
  if n == 0 { 0.0 } else { signal_spec_min_norm_series_sum(s) / n.to_double() }
}

pub fn signal_spec_min_norm_series_min(s : SignalspecminnormSeries) -> Double {
  let n = signal_spec_min_norm_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn signal_spec_min_norm_series_max(s : SignalspecminnormSeries) -> Double {
  let n = signal_spec_min_norm_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn signal_spec_min_norm_series_range(s : SignalspecminnormSeries) -> Double {
  signal_spec_min_norm_series_max(s) - signal_spec_min_norm_series_min(s)
}

pub fn signal_spec_min_norm_series_var(s : SignalspecminnormSeries) -> Double {
  let n = signal_spec_min_norm_series_len(s)
  if n == 0 { 0.0 } else {
    let m = signal_spec_min_norm_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn signal_spec_min_norm_series_std(s : SignalspecminnormSeries) -> Double { signal_spec_min_norm_sqrt(signal_spec_min_norm_series_var(s)) }

pub fn signal_spec_min_norm_series_median(s : SignalspecminnormSeries) -> Double {
  let n = signal_spec_min_norm_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = signal_spec_min_norm_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn signal_spec_min_norm_series_scale(s : SignalspecminnormSeries, f : Double) -> SignalspecminnormSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = signal_spec_min_norm_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn signal_spec_min_norm_series_add(a : SignalspecminnormSeries, b : SignalspecminnormSeries) -> SignalspecminnormSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = signal_spec_min_norm_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn signal_spec_min_norm_series_sub(a : SignalspecminnormSeries, b : SignalspecminnormSeries) -> SignalspecminnormSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = signal_spec_min_norm_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn signal_spec_min_norm_series_normalize(s : SignalspecminnormSeries) -> SignalspecminnormSeries {
  let mn = signal_spec_min_norm_series_min(s)
  let mx = signal_spec_min_norm_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = signal_spec_min_norm_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn signal_spec_min_norm_series_cumsum(s : SignalspecminnormSeries) -> SignalspecminnormSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = signal_spec_min_norm_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn signal_spec_min_norm_series_to_string(s : SignalspecminnormSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + signal_spec_min_norm_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SignalspecminnormMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn signal_spec_min_norm_make_matrix(rows : Int, cols : Int, val : Double) -> SignalspecminnormMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn signal_spec_min_norm_matrix_identity(n : Int) -> SignalspecminnormMatrix {
  let m = signal_spec_min_norm_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn signal_spec_min_norm_matrix_get(m : SignalspecminnormMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn signal_spec_min_norm_matrix_transpose(m : SignalspecminnormMatrix) -> SignalspecminnormMatrix {
  let result = signal_spec_min_norm_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn signal_spec_min_norm_matrix_add(a : SignalspecminnormMatrix, b : SignalspecminnormMatrix) -> SignalspecminnormMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = signal_spec_min_norm_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn signal_spec_min_norm_matrix_scale(m : SignalspecminnormMatrix, s : Double) -> SignalspecminnormMatrix {
  let result = signal_spec_min_norm_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn signal_spec_min_norm_matrix_multiply(a : SignalspecminnormMatrix, b : SignalspecminnormMatrix) -> SignalspecminnormMatrix {
  if a.cols != b.rows { return signal_spec_min_norm_make_matrix(a.rows, b.cols, 0.0) }
  let result = signal_spec_min_norm_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn signal_spec_min_norm_matrix_trace(m : SignalspecminnormMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn signal_spec_min_norm_matrix_det(m : SignalspecminnormMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn signal_spec_min_norm_matrix_norm(m : SignalspecminnormMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  signal_spec_min_norm_sqrt(sum)
}

pub fn signal_spec_min_norm_matrix_to_string(m : SignalspecminnormMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + signal_spec_min_norm_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct SignalspecminnormVector {
  comps : Array[Double]
  dim : Int
}

pub fn signal_spec_min_norm_make_vector(comps : Array[Double]) -> SignalspecminnormVector {
  { comps, dim: comps.length() }
}

pub fn signal_spec_min_norm_vector_zero(dim : Int) -> SignalspecminnormVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn signal_spec_min_norm_vector_add(a : SignalspecminnormVector, b : SignalspecminnormVector) -> SignalspecminnormVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = signal_spec_min_norm_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn signal_spec_min_norm_vector_sub(a : SignalspecminnormVector, b : SignalspecminnormVector) -> SignalspecminnormVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = signal_spec_min_norm_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn signal_spec_min_norm_vector_scale(v : SignalspecminnormVector, s : Double) -> SignalspecminnormVector {
  let mut result = []
  for i in 0..<v.dim { result = signal_spec_min_norm_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn signal_spec_min_norm_vector_dot(a : SignalspecminnormVector, b : SignalspecminnormVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn signal_spec_min_norm_vector_norm(v : SignalspecminnormVector) -> Double { signal_spec_min_norm_sqrt(signal_spec_min_norm_vector_dot(v, v)) }

pub fn signal_spec_min_norm_vector_normalize(v : SignalspecminnormVector) -> SignalspecminnormVector {
  let n = signal_spec_min_norm_vector_norm(v)
  if n < 0.0000001 { v } else { signal_spec_min_norm_vector_scale(v, 1.0 / n) }
}

pub fn signal_spec_min_norm_vector_dist(a : SignalspecminnormVector, b : SignalspecminnormVector) -> Double {
  signal_spec_min_norm_vector_norm(signal_spec_min_norm_vector_sub(a, b))
}

pub fn signal_spec_min_norm_vector_to_string(v : SignalspecminnormVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + signal_spec_min_norm_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn signal_spec_min_norm_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn signal_spec_min_norm_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = signal_spec_min_norm_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn signal_spec_min_norm_std(data : Array[Double]) -> Double { signal_spec_min_norm_sqrt(signal_spec_min_norm_var(data)) }

pub fn signal_spec_min_norm_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = signal_spec_min_norm_mean(a); let mb = signal_spec_min_norm_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn signal_spec_min_norm_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = signal_spec_min_norm_std(a); let sb = signal_spec_min_norm_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { signal_spec_min_norm_cov(a, b) / (sa * sb) }
}

pub fn signal_spec_min_norm_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = signal_spec_min_norm_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn signal_spec_min_norm_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn signal_spec_min_norm_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn signal_spec_min_norm_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  signal_spec_min_norm_sqrt(signal_spec_min_norm_mse(pred, labels))
}

pub fn signal_spec_min_norm_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + signal_spec_min_norm_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn signal_spec_min_norm_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = signal_spec_min_norm_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn signal_spec_min_norm_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn signal_spec_min_norm_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn signal_spec_min_norm_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = signal_spec_min_norm_precision(pred, labels, pos); let r = signal_spec_min_norm_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn signal_spec_min_norm_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn signal_spec_min_norm_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = signal_spec_min_norm_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn signal_spec_min_norm_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn signal_spec_min_norm_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn signal_spec_min_norm_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = signal_spec_min_norm_gcd(a, b)
    (a / g) * b
  }
}

pub fn signal_spec_min_norm_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn signal_spec_min_norm_fibonacci(n : Int) -> Int {
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

pub fn signal_spec_min_norm_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = signal_spec_min_norm_min(data); let mx = signal_spec_min_norm_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn signal_spec_min_norm_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = signal_spec_min_norm_mean(data); let sd = signal_spec_min_norm_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn signal_spec_min_norm_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn signal_spec_min_norm_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn signal_spec_min_norm_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn signal_spec_min_norm_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn signal_spec_min_norm_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn signal_spec_min_norm_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn signal_spec_min_norm_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn signal_spec_min_norm_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn signal_spec_min_norm_dbl(x : Double) -> String {
  let i = if x >= 0.0 { signal_spec_min_norm_int(x) } else { -signal_spec_min_norm_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { signal_spec_min_norm_int(f * 1000000.0) } else { signal_spec_min_norm_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn signal_spec_min_norm_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn signal_spec_min_norm_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct SignalspecminnormFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_min_norm_frame_make(size : Int) -> SignalspecminnormFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_min_norm_frame_len(s : SignalspecminnormFrame) -> Int { s.size }

pub fn signal_spec_min_norm_frame_get(s : SignalspecminnormFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_min_norm_frame_set(s : SignalspecminnormFrame, i : Int, v : Double) -> SignalspecminnormFrame {
  let result = signal_spec_min_norm_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_spec_min_norm_frame_sum(s : SignalspecminnormFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_spec_min_norm_frame_mean(s : SignalspecminnormFrame) -> Double {
  if s.size == 0 { 0.0 } else { signal_spec_min_norm_frame_sum(s) / s.size.to_double() }
}

pub fn signal_spec_min_norm_frame_scale(s : SignalspecminnormFrame, f : Double) -> SignalspecminnormFrame {
  let result = signal_spec_min_norm_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_spec_min_norm_frame_add(a : SignalspecminnormFrame, b : SignalspecminnormFrame) -> SignalspecminnormFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_spec_min_norm_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_spec_min_norm_frame_copy(s : SignalspecminnormFrame) -> SignalspecminnormFrame {
  let result = signal_spec_min_norm_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_spec_min_norm_frame_fill(s : SignalspecminnormFrame, v : Double) -> SignalspecminnormFrame {
  let result = signal_spec_min_norm_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_spec_min_norm_frame_min(s : SignalspecminnormFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_spec_min_norm_frame_max(s : SignalspecminnormFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_spec_min_norm_frame_to_string(s : SignalspecminnormFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecminnormTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_min_norm_table_make(size : Int) -> SignalspecminnormTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_min_norm_table_len(s : SignalspecminnormTable) -> Int { s.size }

pub fn signal_spec_min_norm_table_get(s : SignalspecminnormTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_min_norm_table_set(s : SignalspecminnormTable, i : Int, v : Double) -> SignalspecminnormTable {
  let result = signal_spec_min_norm_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_spec_min_norm_table_sum(s : SignalspecminnormTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_spec_min_norm_table_mean(s : SignalspecminnormTable) -> Double {
  if s.size == 0 { 0.0 } else { signal_spec_min_norm_table_sum(s) / s.size.to_double() }
}

pub fn signal_spec_min_norm_table_scale(s : SignalspecminnormTable, f : Double) -> SignalspecminnormTable {
  let result = signal_spec_min_norm_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_spec_min_norm_table_add(a : SignalspecminnormTable, b : SignalspecminnormTable) -> SignalspecminnormTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_spec_min_norm_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_spec_min_norm_table_copy(s : SignalspecminnormTable) -> SignalspecminnormTable {
  let result = signal_spec_min_norm_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_spec_min_norm_table_fill(s : SignalspecminnormTable, v : Double) -> SignalspecminnormTable {
  let result = signal_spec_min_norm_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_spec_min_norm_table_min(s : SignalspecminnormTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_spec_min_norm_table_max(s : SignalspecminnormTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_spec_min_norm_table_to_string(s : SignalspecminnormTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecminnormGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_min_norm_graphn_make(size : Int) -> SignalspecminnormGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_min_norm_graphn_len(s : SignalspecminnormGraphN) -> Int { s.size }

pub fn signal_spec_min_norm_graphn_get(s : SignalspecminnormGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_min_norm_graphn_set(s : SignalspecminnormGraphN, i : Int, v : Double) -> SignalspecminnormGraphN {
  let result = signal_spec_min_norm_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_spec_min_norm_graphn_sum(s : SignalspecminnormGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_spec_min_norm_graphn_mean(s : SignalspecminnormGraphN) -> Double {
  if s.size == 0 { 0.0 } else { signal_spec_min_norm_graphn_sum(s) / s.size.to_double() }
}

pub fn signal_spec_min_norm_graphn_scale(s : SignalspecminnormGraphN, f : Double) -> SignalspecminnormGraphN {
  let result = signal_spec_min_norm_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_spec_min_norm_graphn_add(a : SignalspecminnormGraphN, b : SignalspecminnormGraphN) -> SignalspecminnormGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_spec_min_norm_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_spec_min_norm_graphn_copy(s : SignalspecminnormGraphN) -> SignalspecminnormGraphN {
  let result = signal_spec_min_norm_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_spec_min_norm_graphn_fill(s : SignalspecminnormGraphN, v : Double) -> SignalspecminnormGraphN {
  let result = signal_spec_min_norm_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_spec_min_norm_graphn_min(s : SignalspecminnormGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_spec_min_norm_graphn_max(s : SignalspecminnormGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_spec_min_norm_graphn_to_string(s : SignalspecminnormGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecminnormNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_min_norm_node_make(size : Int) -> SignalspecminnormNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_min_norm_node_len(s : SignalspecminnormNode) -> Int { s.size }

pub fn signal_spec_min_norm_node_get(s : SignalspecminnormNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_min_norm_node_set(s : SignalspecminnormNode, i : Int, v : Double) -> SignalspecminnormNode {
  let result = signal_spec_min_norm_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_spec_min_norm_node_sum(s : SignalspecminnormNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_spec_min_norm_node_mean(s : SignalspecminnormNode) -> Double {
  if s.size == 0 { 0.0 } else { signal_spec_min_norm_node_sum(s) / s.size.to_double() }
}

pub fn signal_spec_min_norm_node_scale(s : SignalspecminnormNode, f : Double) -> SignalspecminnormNode {
  let result = signal_spec_min_norm_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_spec_min_norm_node_add(a : SignalspecminnormNode, b : SignalspecminnormNode) -> SignalspecminnormNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_spec_min_norm_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_spec_min_norm_node_copy(s : SignalspecminnormNode) -> SignalspecminnormNode {
  let result = signal_spec_min_norm_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_spec_min_norm_node_fill(s : SignalspecminnormNode, v : Double) -> SignalspecminnormNode {
  let result = signal_spec_min_norm_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_spec_min_norm_node_min(s : SignalspecminnormNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_spec_min_norm_node_max(s : SignalspecminnormNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_spec_min_norm_node_to_string(s : SignalspecminnormNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecminnormEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_min_norm_edge_make(size : Int) -> SignalspecminnormEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_min_norm_edge_len(s : SignalspecminnormEdge) -> Int { s.size }

pub fn signal_spec_min_norm_edge_get(s : SignalspecminnormEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_min_norm_edge_set(s : SignalspecminnormEdge, i : Int, v : Double) -> SignalspecminnormEdge {
  let result = signal_spec_min_norm_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_spec_min_norm_edge_sum(s : SignalspecminnormEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_spec_min_norm_edge_mean(s : SignalspecminnormEdge) -> Double {
  if s.size == 0 { 0.0 } else { signal_spec_min_norm_edge_sum(s) / s.size.to_double() }
}

pub fn signal_spec_min_norm_edge_scale(s : SignalspecminnormEdge, f : Double) -> SignalspecminnormEdge {
  let result = signal_spec_min_norm_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_spec_min_norm_edge_add(a : SignalspecminnormEdge, b : SignalspecminnormEdge) -> SignalspecminnormEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_spec_min_norm_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_spec_min_norm_edge_copy(s : SignalspecminnormEdge) -> SignalspecminnormEdge {
  let result = signal_spec_min_norm_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_spec_min_norm_edge_fill(s : SignalspecminnormEdge, v : Double) -> SignalspecminnormEdge {
  let result = signal_spec_min_norm_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_spec_min_norm_edge_min(s : SignalspecminnormEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_spec_min_norm_edge_max(s : SignalspecminnormEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_spec_min_norm_edge_to_string(s : SignalspecminnormEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecminnormPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_min_norm_path_make(size : Int) -> SignalspecminnormPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_min_norm_path_len(s : SignalspecminnormPath) -> Int { s.size }

pub fn signal_spec_min_norm_path_get(s : SignalspecminnormPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_min_norm_path_set(s : SignalspecminnormPath, i : Int, v : Double) -> SignalspecminnormPath {
  let result = signal_spec_min_norm_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_spec_min_norm_path_sum(s : SignalspecminnormPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_spec_min_norm_path_mean(s : SignalspecminnormPath) -> Double {
  if s.size == 0 { 0.0 } else { signal_spec_min_norm_path_sum(s) / s.size.to_double() }
}

pub fn signal_spec_min_norm_path_scale(s : SignalspecminnormPath, f : Double) -> SignalspecminnormPath {
  let result = signal_spec_min_norm_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_spec_min_norm_path_add(a : SignalspecminnormPath, b : SignalspecminnormPath) -> SignalspecminnormPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_spec_min_norm_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_spec_min_norm_path_copy(s : SignalspecminnormPath) -> SignalspecminnormPath {
  let result = signal_spec_min_norm_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_spec_min_norm_path_fill(s : SignalspecminnormPath, v : Double) -> SignalspecminnormPath {
  let result = signal_spec_min_norm_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_spec_min_norm_path_min(s : SignalspecminnormPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_spec_min_norm_path_max(s : SignalspecminnormPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_spec_min_norm_path_to_string(s : SignalspecminnormPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecminnormCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_min_norm_cluster_make(size : Int) -> SignalspecminnormCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_min_norm_cluster_len(s : SignalspecminnormCluster) -> Int { s.size }

pub fn signal_spec_min_norm_cluster_get(s : SignalspecminnormCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_min_norm_cluster_set(s : SignalspecminnormCluster, i : Int, v : Double) -> SignalspecminnormCluster {
  let result = signal_spec_min_norm_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_spec_min_norm_cluster_sum(s : SignalspecminnormCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_spec_min_norm_cluster_mean(s : SignalspecminnormCluster) -> Double {
  if s.size == 0 { 0.0 } else { signal_spec_min_norm_cluster_sum(s) / s.size.to_double() }
}

pub fn signal_spec_min_norm_cluster_scale(s : SignalspecminnormCluster, f : Double) -> SignalspecminnormCluster {
  let result = signal_spec_min_norm_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_spec_min_norm_cluster_add(a : SignalspecminnormCluster, b : SignalspecminnormCluster) -> SignalspecminnormCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_spec_min_norm_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_spec_min_norm_cluster_copy(s : SignalspecminnormCluster) -> SignalspecminnormCluster {
  let result = signal_spec_min_norm_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_spec_min_norm_cluster_fill(s : SignalspecminnormCluster, v : Double) -> SignalspecminnormCluster {
  let result = signal_spec_min_norm_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_spec_min_norm_cluster_min(s : SignalspecminnormCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_spec_min_norm_cluster_max(s : SignalspecminnormCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_spec_min_norm_cluster_to_string(s : SignalspecminnormCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecminnormModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_min_norm_model_make(size : Int) -> SignalspecminnormModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_min_norm_model_len(s : SignalspecminnormModel) -> Int { s.size }

pub fn signal_spec_min_norm_model_get(s : SignalspecminnormModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_min_norm_model_set(s : SignalspecminnormModel, i : Int, v : Double) -> SignalspecminnormModel {
  let result = signal_spec_min_norm_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_spec_min_norm_model_sum(s : SignalspecminnormModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_spec_min_norm_model_mean(s : SignalspecminnormModel) -> Double {
  if s.size == 0 { 0.0 } else { signal_spec_min_norm_model_sum(s) / s.size.to_double() }
}

pub fn signal_spec_min_norm_model_scale(s : SignalspecminnormModel, f : Double) -> SignalspecminnormModel {
  let result = signal_spec_min_norm_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_spec_min_norm_model_add(a : SignalspecminnormModel, b : SignalspecminnormModel) -> SignalspecminnormModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_spec_min_norm_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_spec_min_norm_model_copy(s : SignalspecminnormModel) -> SignalspecminnormModel {
  let result = signal_spec_min_norm_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_spec_min_norm_model_fill(s : SignalspecminnormModel, v : Double) -> SignalspecminnormModel {
  let result = signal_spec_min_norm_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_spec_min_norm_model_min(s : SignalspecminnormModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_spec_min_norm_model_max(s : SignalspecminnormModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_spec_min_norm_model_to_string(s : SignalspecminnormModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecminnormLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_min_norm_layer_make(size : Int) -> SignalspecminnormLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_min_norm_layer_len(s : SignalspecminnormLayer) -> Int { s.size }

pub fn signal_spec_min_norm_layer_get(s : SignalspecminnormLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_min_norm_layer_set(s : SignalspecminnormLayer, i : Int, v : Double) -> SignalspecminnormLayer {
  let result = signal_spec_min_norm_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_spec_min_norm_layer_sum(s : SignalspecminnormLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_spec_min_norm_layer_mean(s : SignalspecminnormLayer) -> Double {
  if s.size == 0 { 0.0 } else { signal_spec_min_norm_layer_sum(s) / s.size.to_double() }
}

pub fn signal_spec_min_norm_layer_scale(s : SignalspecminnormLayer, f : Double) -> SignalspecminnormLayer {
  let result = signal_spec_min_norm_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_spec_min_norm_layer_add(a : SignalspecminnormLayer, b : SignalspecminnormLayer) -> SignalspecminnormLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_spec_min_norm_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_spec_min_norm_layer_copy(s : SignalspecminnormLayer) -> SignalspecminnormLayer {
  let result = signal_spec_min_norm_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_spec_min_norm_layer_fill(s : SignalspecminnormLayer, v : Double) -> SignalspecminnormLayer {
  let result = signal_spec_min_norm_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_spec_min_norm_layer_min(s : SignalspecminnormLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_spec_min_norm_layer_max(s : SignalspecminnormLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_spec_min_norm_layer_to_string(s : SignalspecminnormLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecminnormBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_min_norm_buffer_make(size : Int) -> SignalspecminnormBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_min_norm_buffer_len(s : SignalspecminnormBuffer) -> Int { s.size }

pub fn signal_spec_min_norm_buffer_get(s : SignalspecminnormBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_min_norm_buffer_set(s : SignalspecminnormBuffer, i : Int, v : Double) -> SignalspecminnormBuffer {
  let result = signal_spec_min_norm_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_spec_min_norm_buffer_sum(s : SignalspecminnormBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_spec_min_norm_buffer_mean(s : SignalspecminnormBuffer) -> Double {
  if s.size == 0 { 0.0 } else { signal_spec_min_norm_buffer_sum(s) / s.size.to_double() }
}

pub fn signal_spec_min_norm_buffer_scale(s : SignalspecminnormBuffer, f : Double) -> SignalspecminnormBuffer {
  let result = signal_spec_min_norm_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_spec_min_norm_buffer_add(a : SignalspecminnormBuffer, b : SignalspecminnormBuffer) -> SignalspecminnormBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_spec_min_norm_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_spec_min_norm_buffer_copy(s : SignalspecminnormBuffer) -> SignalspecminnormBuffer {
  let result = signal_spec_min_norm_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_spec_min_norm_buffer_fill(s : SignalspecminnormBuffer, v : Double) -> SignalspecminnormBuffer {
  let result = signal_spec_min_norm_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_spec_min_norm_buffer_min(s : SignalspecminnormBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_spec_min_norm_buffer_max(s : SignalspecminnormBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_spec_min_norm_buffer_to_string(s : SignalspecminnormBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecminnormCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_min_norm_cursor_make(size : Int) -> SignalspecminnormCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_min_norm_cursor_len(s : SignalspecminnormCursor) -> Int { s.size }

pub fn signal_spec_min_norm_cursor_get(s : SignalspecminnormCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_min_norm_cursor_set(s : SignalspecminnormCursor, i : Int, v : Double) -> SignalspecminnormCursor {
  let result = signal_spec_min_norm_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_spec_min_norm_cursor_sum(s : SignalspecminnormCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_spec_min_norm_cursor_mean(s : SignalspecminnormCursor) -> Double {
  if s.size == 0 { 0.0 } else { signal_spec_min_norm_cursor_sum(s) / s.size.to_double() }
}

pub fn signal_spec_min_norm_cursor_scale(s : SignalspecminnormCursor, f : Double) -> SignalspecminnormCursor {
  let result = signal_spec_min_norm_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_spec_min_norm_cursor_add(a : SignalspecminnormCursor, b : SignalspecminnormCursor) -> SignalspecminnormCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_spec_min_norm_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_spec_min_norm_cursor_copy(s : SignalspecminnormCursor) -> SignalspecminnormCursor {
  let result = signal_spec_min_norm_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_spec_min_norm_cursor_fill(s : SignalspecminnormCursor, v : Double) -> SignalspecminnormCursor {
  let result = signal_spec_min_norm_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_spec_min_norm_cursor_min(s : SignalspecminnormCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_spec_min_norm_cursor_max(s : SignalspecminnormCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_spec_min_norm_cursor_to_string(s : SignalspecminnormCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecminnormView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_min_norm_view_make(size : Int) -> SignalspecminnormView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_min_norm_view_len(s : SignalspecminnormView) -> Int { s.size }

pub fn signal_spec_min_norm_view_get(s : SignalspecminnormView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_min_norm_view_set(s : SignalspecminnormView, i : Int, v : Double) -> SignalspecminnormView {
  let result = signal_spec_min_norm_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_spec_min_norm_view_sum(s : SignalspecminnormView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_spec_min_norm_view_mean(s : SignalspecminnormView) -> Double {
  if s.size == 0 { 0.0 } else { signal_spec_min_norm_view_sum(s) / s.size.to_double() }
}

pub fn signal_spec_min_norm_view_scale(s : SignalspecminnormView, f : Double) -> SignalspecminnormView {
  let result = signal_spec_min_norm_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_spec_min_norm_view_add(a : SignalspecminnormView, b : SignalspecminnormView) -> SignalspecminnormView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_spec_min_norm_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_spec_min_norm_view_copy(s : SignalspecminnormView) -> SignalspecminnormView {
  let result = signal_spec_min_norm_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_spec_min_norm_view_fill(s : SignalspecminnormView, v : Double) -> SignalspecminnormView {
  let result = signal_spec_min_norm_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_spec_min_norm_view_min(s : SignalspecminnormView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_spec_min_norm_view_max(s : SignalspecminnormView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_spec_min_norm_view_to_string(s : SignalspecminnormView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecminnormRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_min_norm_range_make(size : Int) -> SignalspecminnormRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_min_norm_range_len(s : SignalspecminnormRange) -> Int { s.size }

pub fn signal_spec_min_norm_range_get(s : SignalspecminnormRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_min_norm_range_set(s : SignalspecminnormRange, i : Int, v : Double) -> SignalspecminnormRange {
  let result = signal_spec_min_norm_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_spec_min_norm_range_sum(s : SignalspecminnormRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_spec_min_norm_range_mean(s : SignalspecminnormRange) -> Double {
  if s.size == 0 { 0.0 } else { signal_spec_min_norm_range_sum(s) / s.size.to_double() }
}

pub fn signal_spec_min_norm_range_scale(s : SignalspecminnormRange, f : Double) -> SignalspecminnormRange {
  let result = signal_spec_min_norm_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_spec_min_norm_range_add(a : SignalspecminnormRange, b : SignalspecminnormRange) -> SignalspecminnormRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_spec_min_norm_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_spec_min_norm_range_copy(s : SignalspecminnormRange) -> SignalspecminnormRange {
  let result = signal_spec_min_norm_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_spec_min_norm_range_fill(s : SignalspecminnormRange, v : Double) -> SignalspecminnormRange {
  let result = signal_spec_min_norm_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_spec_min_norm_range_min(s : SignalspecminnormRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_spec_min_norm_range_max(s : SignalspecminnormRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_spec_min_norm_range_to_string(s : SignalspecminnormRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecminnormSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_min_norm_slice_make(size : Int) -> SignalspecminnormSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_min_norm_slice_len(s : SignalspecminnormSlice) -> Int { s.size }

pub fn signal_spec_min_norm_slice_get(s : SignalspecminnormSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_min_norm_slice_set(s : SignalspecminnormSlice, i : Int, v : Double) -> SignalspecminnormSlice {
  let result = signal_spec_min_norm_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_spec_min_norm_slice_sum(s : SignalspecminnormSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_spec_min_norm_slice_mean(s : SignalspecminnormSlice) -> Double {
  if s.size == 0 { 0.0 } else { signal_spec_min_norm_slice_sum(s) / s.size.to_double() }
}

pub fn signal_spec_min_norm_slice_scale(s : SignalspecminnormSlice, f : Double) -> SignalspecminnormSlice {
  let result = signal_spec_min_norm_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_spec_min_norm_slice_add(a : SignalspecminnormSlice, b : SignalspecminnormSlice) -> SignalspecminnormSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_spec_min_norm_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_spec_min_norm_slice_copy(s : SignalspecminnormSlice) -> SignalspecminnormSlice {
  let result = signal_spec_min_norm_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_spec_min_norm_slice_fill(s : SignalspecminnormSlice, v : Double) -> SignalspecminnormSlice {
  let result = signal_spec_min_norm_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_spec_min_norm_slice_min(s : SignalspecminnormSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_spec_min_norm_slice_max(s : SignalspecminnormSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_spec_min_norm_slice_to_string(s : SignalspecminnormSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn signal_spec_min_norm_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_spec_min_norm_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_spec_min_norm_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_spec_min_norm_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_spec_min_norm_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_spec_min_norm_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_spec_min_norm_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_spec_min_norm_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_spec_min_norm_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_spec_min_norm_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_spec_min_norm_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_spec_min_norm_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_spec_min_norm_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_spec_min_norm_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_spec_min_norm_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_spec_min_norm_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_spec_min_norm_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_spec_min_norm_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_spec_min_norm_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_spec_min_norm_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_spec_min_norm_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_spec_min_norm_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_spec_min_norm_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_spec_min_norm_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_spec_min_norm_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

