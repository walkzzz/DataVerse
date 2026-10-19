///===
/// extcore/signal_transform_stft

pub(all) struct SignaltransformstftPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn signal_transform_stft_make_point(x : Double, y : Double) -> SignaltransformstftPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn signal_transform_stft_make_point3(x : Double, y : Double, z : Double) -> SignaltransformstftPoint {
  { x, y, z, label: 0 }
}

pub fn signal_transform_stft_point_x(pt : SignaltransformstftPoint) -> Double { pt.x }

pub fn signal_transform_stft_point_y(pt : SignaltransformstftPoint) -> Double { pt.y }

pub fn signal_transform_stft_point_z(pt : SignaltransformstftPoint) -> Double { pt.z }

pub fn signal_transform_stft_point_label(pt : SignaltransformstftPoint) -> Int { pt.label }

pub fn signal_transform_stft_point_dist(a : SignaltransformstftPoint, b : SignaltransformstftPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  signal_transform_stft_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn signal_transform_stft_point_add(a : SignaltransformstftPoint, b : SignaltransformstftPoint) -> SignaltransformstftPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn signal_transform_stft_point_sub(a : SignaltransformstftPoint, b : SignaltransformstftPoint) -> SignaltransformstftPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn signal_transform_stft_point_scale(pt : SignaltransformstftPoint, s : Double) -> SignaltransformstftPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn signal_transform_stft_point_dot(a : SignaltransformstftPoint, b : SignaltransformstftPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn signal_transform_stft_point_cross(a : SignaltransformstftPoint, b : SignaltransformstftPoint) -> SignaltransformstftPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn signal_transform_stft_point_norm(pt : SignaltransformstftPoint) -> Double {
  signal_transform_stft_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn signal_transform_stft_point_normalize(pt : SignaltransformstftPoint) -> SignaltransformstftPoint {
  let n = signal_transform_stft_point_norm(pt)
  if n < 0.0000001 { pt } else { signal_transform_stft_point_scale(pt, 1.0 / n) }
}

pub fn signal_transform_stft_point_negate(pt : SignaltransformstftPoint) -> SignaltransformstftPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn signal_transform_stft_point_mid(a : SignaltransformstftPoint, b : SignaltransformstftPoint) -> SignaltransformstftPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn signal_transform_stft_point_lerp(a : SignaltransformstftPoint, b : SignaltransformstftPoint, t : Double) -> SignaltransformstftPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn signal_transform_stft_point_to_string(pt : SignaltransformstftPoint) -> String {
  "(" + signal_transform_stft_dbl(pt.x) + ", " + signal_transform_stft_dbl(pt.y) + ", " + signal_transform_stft_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct SignaltransformstftSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn signal_transform_stft_make_series(vals : Array[Double], name : String) -> SignaltransformstftSeries {
  { vals, name, meta: 0 }
}

pub fn signal_transform_stft_series_len(s : SignaltransformstftSeries) -> Int { s.vals.length() }

pub fn signal_transform_stft_series_sum(s : SignaltransformstftSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn signal_transform_stft_series_mean(s : SignaltransformstftSeries) -> Double {
  let n = signal_transform_stft_series_len(s)
  if n == 0 { 0.0 } else { signal_transform_stft_series_sum(s) / n.to_double() }
}

pub fn signal_transform_stft_series_min(s : SignaltransformstftSeries) -> Double {
  let n = signal_transform_stft_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn signal_transform_stft_series_max(s : SignaltransformstftSeries) -> Double {
  let n = signal_transform_stft_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn signal_transform_stft_series_range(s : SignaltransformstftSeries) -> Double {
  signal_transform_stft_series_max(s) - signal_transform_stft_series_min(s)
}

pub fn signal_transform_stft_series_var(s : SignaltransformstftSeries) -> Double {
  let n = signal_transform_stft_series_len(s)
  if n == 0 { 0.0 } else {
    let m = signal_transform_stft_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn signal_transform_stft_series_std(s : SignaltransformstftSeries) -> Double { signal_transform_stft_sqrt(signal_transform_stft_series_var(s)) }

pub fn signal_transform_stft_series_median(s : SignaltransformstftSeries) -> Double {
  let n = signal_transform_stft_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = signal_transform_stft_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn signal_transform_stft_series_scale(s : SignaltransformstftSeries, f : Double) -> SignaltransformstftSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = signal_transform_stft_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn signal_transform_stft_series_add(a : SignaltransformstftSeries, b : SignaltransformstftSeries) -> SignaltransformstftSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = signal_transform_stft_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn signal_transform_stft_series_sub(a : SignaltransformstftSeries, b : SignaltransformstftSeries) -> SignaltransformstftSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = signal_transform_stft_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn signal_transform_stft_series_normalize(s : SignaltransformstftSeries) -> SignaltransformstftSeries {
  let mn = signal_transform_stft_series_min(s)
  let mx = signal_transform_stft_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = signal_transform_stft_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn signal_transform_stft_series_cumsum(s : SignaltransformstftSeries) -> SignaltransformstftSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = signal_transform_stft_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn signal_transform_stft_series_to_string(s : SignaltransformstftSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + signal_transform_stft_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SignaltransformstftMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn signal_transform_stft_make_matrix(rows : Int, cols : Int, val : Double) -> SignaltransformstftMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn signal_transform_stft_matrix_identity(n : Int) -> SignaltransformstftMatrix {
  let m = signal_transform_stft_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn signal_transform_stft_matrix_get(m : SignaltransformstftMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn signal_transform_stft_matrix_transpose(m : SignaltransformstftMatrix) -> SignaltransformstftMatrix {
  let result = signal_transform_stft_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn signal_transform_stft_matrix_add(a : SignaltransformstftMatrix, b : SignaltransformstftMatrix) -> SignaltransformstftMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = signal_transform_stft_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn signal_transform_stft_matrix_scale(m : SignaltransformstftMatrix, s : Double) -> SignaltransformstftMatrix {
  let result = signal_transform_stft_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn signal_transform_stft_matrix_multiply(a : SignaltransformstftMatrix, b : SignaltransformstftMatrix) -> SignaltransformstftMatrix {
  if a.cols != b.rows { return signal_transform_stft_make_matrix(a.rows, b.cols, 0.0) }
  let result = signal_transform_stft_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn signal_transform_stft_matrix_trace(m : SignaltransformstftMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn signal_transform_stft_matrix_det(m : SignaltransformstftMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn signal_transform_stft_matrix_norm(m : SignaltransformstftMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  signal_transform_stft_sqrt(sum)
}

pub fn signal_transform_stft_matrix_to_string(m : SignaltransformstftMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + signal_transform_stft_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct SignaltransformstftVector {
  comps : Array[Double]
  dim : Int
}

pub fn signal_transform_stft_make_vector(comps : Array[Double]) -> SignaltransformstftVector {
  { comps, dim: comps.length() }
}

pub fn signal_transform_stft_vector_zero(dim : Int) -> SignaltransformstftVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn signal_transform_stft_vector_add(a : SignaltransformstftVector, b : SignaltransformstftVector) -> SignaltransformstftVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = signal_transform_stft_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn signal_transform_stft_vector_sub(a : SignaltransformstftVector, b : SignaltransformstftVector) -> SignaltransformstftVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = signal_transform_stft_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn signal_transform_stft_vector_scale(v : SignaltransformstftVector, s : Double) -> SignaltransformstftVector {
  let mut result = []
  for i in 0..<v.dim { result = signal_transform_stft_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn signal_transform_stft_vector_dot(a : SignaltransformstftVector, b : SignaltransformstftVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn signal_transform_stft_vector_norm(v : SignaltransformstftVector) -> Double { signal_transform_stft_sqrt(signal_transform_stft_vector_dot(v, v)) }

pub fn signal_transform_stft_vector_normalize(v : SignaltransformstftVector) -> SignaltransformstftVector {
  let n = signal_transform_stft_vector_norm(v)
  if n < 0.0000001 { v } else { signal_transform_stft_vector_scale(v, 1.0 / n) }
}

pub fn signal_transform_stft_vector_dist(a : SignaltransformstftVector, b : SignaltransformstftVector) -> Double {
  signal_transform_stft_vector_norm(signal_transform_stft_vector_sub(a, b))
}

pub fn signal_transform_stft_vector_to_string(v : SignaltransformstftVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + signal_transform_stft_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn signal_transform_stft_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn signal_transform_stft_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = signal_transform_stft_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn signal_transform_stft_std(data : Array[Double]) -> Double { signal_transform_stft_sqrt(signal_transform_stft_var(data)) }

pub fn signal_transform_stft_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = signal_transform_stft_mean(a); let mb = signal_transform_stft_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn signal_transform_stft_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = signal_transform_stft_std(a); let sb = signal_transform_stft_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { signal_transform_stft_cov(a, b) / (sa * sb) }
}

pub fn signal_transform_stft_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = signal_transform_stft_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn signal_transform_stft_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn signal_transform_stft_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn signal_transform_stft_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  signal_transform_stft_sqrt(signal_transform_stft_mse(pred, labels))
}

pub fn signal_transform_stft_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + signal_transform_stft_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn signal_transform_stft_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = signal_transform_stft_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn signal_transform_stft_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn signal_transform_stft_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn signal_transform_stft_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = signal_transform_stft_precision(pred, labels, pos); let r = signal_transform_stft_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn signal_transform_stft_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn signal_transform_stft_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = signal_transform_stft_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn signal_transform_stft_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn signal_transform_stft_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn signal_transform_stft_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = signal_transform_stft_gcd(a, b)
    (a / g) * b
  }
}

pub fn signal_transform_stft_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn signal_transform_stft_fibonacci(n : Int) -> Int {
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

pub fn signal_transform_stft_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = signal_transform_stft_min(data); let mx = signal_transform_stft_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn signal_transform_stft_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = signal_transform_stft_mean(data); let sd = signal_transform_stft_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn signal_transform_stft_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn signal_transform_stft_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn signal_transform_stft_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn signal_transform_stft_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn signal_transform_stft_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn signal_transform_stft_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn signal_transform_stft_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn signal_transform_stft_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn signal_transform_stft_dbl(x : Double) -> String {
  let i = if x >= 0.0 { signal_transform_stft_int(x) } else { -signal_transform_stft_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { signal_transform_stft_int(f * 1000000.0) } else { signal_transform_stft_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn signal_transform_stft_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn signal_transform_stft_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct SignaltransformstftFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_stft_frame_make(size : Int) -> SignaltransformstftFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_stft_frame_len(s : SignaltransformstftFrame) -> Int { s.size }

pub fn signal_transform_stft_frame_get(s : SignaltransformstftFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_stft_frame_set(s : SignaltransformstftFrame, i : Int, v : Double) -> SignaltransformstftFrame {
  let result = signal_transform_stft_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_transform_stft_frame_sum(s : SignaltransformstftFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_transform_stft_frame_mean(s : SignaltransformstftFrame) -> Double {
  if s.size == 0 { 0.0 } else { signal_transform_stft_frame_sum(s) / s.size.to_double() }
}

pub fn signal_transform_stft_frame_scale(s : SignaltransformstftFrame, f : Double) -> SignaltransformstftFrame {
  let result = signal_transform_stft_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_transform_stft_frame_add(a : SignaltransformstftFrame, b : SignaltransformstftFrame) -> SignaltransformstftFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_transform_stft_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_transform_stft_frame_copy(s : SignaltransformstftFrame) -> SignaltransformstftFrame {
  let result = signal_transform_stft_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_transform_stft_frame_fill(s : SignaltransformstftFrame, v : Double) -> SignaltransformstftFrame {
  let result = signal_transform_stft_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_transform_stft_frame_min(s : SignaltransformstftFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_stft_frame_max(s : SignaltransformstftFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_stft_frame_to_string(s : SignaltransformstftFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformstftTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_stft_table_make(size : Int) -> SignaltransformstftTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_stft_table_len(s : SignaltransformstftTable) -> Int { s.size }

pub fn signal_transform_stft_table_get(s : SignaltransformstftTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_stft_table_set(s : SignaltransformstftTable, i : Int, v : Double) -> SignaltransformstftTable {
  let result = signal_transform_stft_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_transform_stft_table_sum(s : SignaltransformstftTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_transform_stft_table_mean(s : SignaltransformstftTable) -> Double {
  if s.size == 0 { 0.0 } else { signal_transform_stft_table_sum(s) / s.size.to_double() }
}

pub fn signal_transform_stft_table_scale(s : SignaltransformstftTable, f : Double) -> SignaltransformstftTable {
  let result = signal_transform_stft_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_transform_stft_table_add(a : SignaltransformstftTable, b : SignaltransformstftTable) -> SignaltransformstftTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_transform_stft_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_transform_stft_table_copy(s : SignaltransformstftTable) -> SignaltransformstftTable {
  let result = signal_transform_stft_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_transform_stft_table_fill(s : SignaltransformstftTable, v : Double) -> SignaltransformstftTable {
  let result = signal_transform_stft_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_transform_stft_table_min(s : SignaltransformstftTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_stft_table_max(s : SignaltransformstftTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_stft_table_to_string(s : SignaltransformstftTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformstftGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_stft_graphn_make(size : Int) -> SignaltransformstftGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_stft_graphn_len(s : SignaltransformstftGraphN) -> Int { s.size }

pub fn signal_transform_stft_graphn_get(s : SignaltransformstftGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_stft_graphn_set(s : SignaltransformstftGraphN, i : Int, v : Double) -> SignaltransformstftGraphN {
  let result = signal_transform_stft_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_transform_stft_graphn_sum(s : SignaltransformstftGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_transform_stft_graphn_mean(s : SignaltransformstftGraphN) -> Double {
  if s.size == 0 { 0.0 } else { signal_transform_stft_graphn_sum(s) / s.size.to_double() }
}

pub fn signal_transform_stft_graphn_scale(s : SignaltransformstftGraphN, f : Double) -> SignaltransformstftGraphN {
  let result = signal_transform_stft_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_transform_stft_graphn_add(a : SignaltransformstftGraphN, b : SignaltransformstftGraphN) -> SignaltransformstftGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_transform_stft_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_transform_stft_graphn_copy(s : SignaltransformstftGraphN) -> SignaltransformstftGraphN {
  let result = signal_transform_stft_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_transform_stft_graphn_fill(s : SignaltransformstftGraphN, v : Double) -> SignaltransformstftGraphN {
  let result = signal_transform_stft_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_transform_stft_graphn_min(s : SignaltransformstftGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_stft_graphn_max(s : SignaltransformstftGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_stft_graphn_to_string(s : SignaltransformstftGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformstftNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_stft_node_make(size : Int) -> SignaltransformstftNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_stft_node_len(s : SignaltransformstftNode) -> Int { s.size }

pub fn signal_transform_stft_node_get(s : SignaltransformstftNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_stft_node_set(s : SignaltransformstftNode, i : Int, v : Double) -> SignaltransformstftNode {
  let result = signal_transform_stft_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_transform_stft_node_sum(s : SignaltransformstftNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_transform_stft_node_mean(s : SignaltransformstftNode) -> Double {
  if s.size == 0 { 0.0 } else { signal_transform_stft_node_sum(s) / s.size.to_double() }
}

pub fn signal_transform_stft_node_scale(s : SignaltransformstftNode, f : Double) -> SignaltransformstftNode {
  let result = signal_transform_stft_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_transform_stft_node_add(a : SignaltransformstftNode, b : SignaltransformstftNode) -> SignaltransformstftNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_transform_stft_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_transform_stft_node_copy(s : SignaltransformstftNode) -> SignaltransformstftNode {
  let result = signal_transform_stft_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_transform_stft_node_fill(s : SignaltransformstftNode, v : Double) -> SignaltransformstftNode {
  let result = signal_transform_stft_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_transform_stft_node_min(s : SignaltransformstftNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_stft_node_max(s : SignaltransformstftNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_stft_node_to_string(s : SignaltransformstftNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformstftEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_stft_edge_make(size : Int) -> SignaltransformstftEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_stft_edge_len(s : SignaltransformstftEdge) -> Int { s.size }

pub fn signal_transform_stft_edge_get(s : SignaltransformstftEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_stft_edge_set(s : SignaltransformstftEdge, i : Int, v : Double) -> SignaltransformstftEdge {
  let result = signal_transform_stft_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_transform_stft_edge_sum(s : SignaltransformstftEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_transform_stft_edge_mean(s : SignaltransformstftEdge) -> Double {
  if s.size == 0 { 0.0 } else { signal_transform_stft_edge_sum(s) / s.size.to_double() }
}

pub fn signal_transform_stft_edge_scale(s : SignaltransformstftEdge, f : Double) -> SignaltransformstftEdge {
  let result = signal_transform_stft_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_transform_stft_edge_add(a : SignaltransformstftEdge, b : SignaltransformstftEdge) -> SignaltransformstftEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_transform_stft_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_transform_stft_edge_copy(s : SignaltransformstftEdge) -> SignaltransformstftEdge {
  let result = signal_transform_stft_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_transform_stft_edge_fill(s : SignaltransformstftEdge, v : Double) -> SignaltransformstftEdge {
  let result = signal_transform_stft_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_transform_stft_edge_min(s : SignaltransformstftEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_stft_edge_max(s : SignaltransformstftEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_stft_edge_to_string(s : SignaltransformstftEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformstftPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_stft_path_make(size : Int) -> SignaltransformstftPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_stft_path_len(s : SignaltransformstftPath) -> Int { s.size }

pub fn signal_transform_stft_path_get(s : SignaltransformstftPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_stft_path_set(s : SignaltransformstftPath, i : Int, v : Double) -> SignaltransformstftPath {
  let result = signal_transform_stft_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_transform_stft_path_sum(s : SignaltransformstftPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_transform_stft_path_mean(s : SignaltransformstftPath) -> Double {
  if s.size == 0 { 0.0 } else { signal_transform_stft_path_sum(s) / s.size.to_double() }
}

pub fn signal_transform_stft_path_scale(s : SignaltransformstftPath, f : Double) -> SignaltransformstftPath {
  let result = signal_transform_stft_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_transform_stft_path_add(a : SignaltransformstftPath, b : SignaltransformstftPath) -> SignaltransformstftPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_transform_stft_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_transform_stft_path_copy(s : SignaltransformstftPath) -> SignaltransformstftPath {
  let result = signal_transform_stft_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_transform_stft_path_fill(s : SignaltransformstftPath, v : Double) -> SignaltransformstftPath {
  let result = signal_transform_stft_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_transform_stft_path_min(s : SignaltransformstftPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_stft_path_max(s : SignaltransformstftPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_stft_path_to_string(s : SignaltransformstftPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformstftCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_stft_cluster_make(size : Int) -> SignaltransformstftCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_stft_cluster_len(s : SignaltransformstftCluster) -> Int { s.size }

pub fn signal_transform_stft_cluster_get(s : SignaltransformstftCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_stft_cluster_set(s : SignaltransformstftCluster, i : Int, v : Double) -> SignaltransformstftCluster {
  let result = signal_transform_stft_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_transform_stft_cluster_sum(s : SignaltransformstftCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_transform_stft_cluster_mean(s : SignaltransformstftCluster) -> Double {
  if s.size == 0 { 0.0 } else { signal_transform_stft_cluster_sum(s) / s.size.to_double() }
}

pub fn signal_transform_stft_cluster_scale(s : SignaltransformstftCluster, f : Double) -> SignaltransformstftCluster {
  let result = signal_transform_stft_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_transform_stft_cluster_add(a : SignaltransformstftCluster, b : SignaltransformstftCluster) -> SignaltransformstftCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_transform_stft_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_transform_stft_cluster_copy(s : SignaltransformstftCluster) -> SignaltransformstftCluster {
  let result = signal_transform_stft_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_transform_stft_cluster_fill(s : SignaltransformstftCluster, v : Double) -> SignaltransformstftCluster {
  let result = signal_transform_stft_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_transform_stft_cluster_min(s : SignaltransformstftCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_stft_cluster_max(s : SignaltransformstftCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_stft_cluster_to_string(s : SignaltransformstftCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformstftModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_stft_model_make(size : Int) -> SignaltransformstftModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_stft_model_len(s : SignaltransformstftModel) -> Int { s.size }

pub fn signal_transform_stft_model_get(s : SignaltransformstftModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_stft_model_set(s : SignaltransformstftModel, i : Int, v : Double) -> SignaltransformstftModel {
  let result = signal_transform_stft_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_transform_stft_model_sum(s : SignaltransformstftModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_transform_stft_model_mean(s : SignaltransformstftModel) -> Double {
  if s.size == 0 { 0.0 } else { signal_transform_stft_model_sum(s) / s.size.to_double() }
}

pub fn signal_transform_stft_model_scale(s : SignaltransformstftModel, f : Double) -> SignaltransformstftModel {
  let result = signal_transform_stft_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_transform_stft_model_add(a : SignaltransformstftModel, b : SignaltransformstftModel) -> SignaltransformstftModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_transform_stft_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_transform_stft_model_copy(s : SignaltransformstftModel) -> SignaltransformstftModel {
  let result = signal_transform_stft_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_transform_stft_model_fill(s : SignaltransformstftModel, v : Double) -> SignaltransformstftModel {
  let result = signal_transform_stft_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_transform_stft_model_min(s : SignaltransformstftModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_stft_model_max(s : SignaltransformstftModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_stft_model_to_string(s : SignaltransformstftModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformstftLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_stft_layer_make(size : Int) -> SignaltransformstftLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_stft_layer_len(s : SignaltransformstftLayer) -> Int { s.size }

pub fn signal_transform_stft_layer_get(s : SignaltransformstftLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_stft_layer_set(s : SignaltransformstftLayer, i : Int, v : Double) -> SignaltransformstftLayer {
  let result = signal_transform_stft_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_transform_stft_layer_sum(s : SignaltransformstftLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_transform_stft_layer_mean(s : SignaltransformstftLayer) -> Double {
  if s.size == 0 { 0.0 } else { signal_transform_stft_layer_sum(s) / s.size.to_double() }
}

pub fn signal_transform_stft_layer_scale(s : SignaltransformstftLayer, f : Double) -> SignaltransformstftLayer {
  let result = signal_transform_stft_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_transform_stft_layer_add(a : SignaltransformstftLayer, b : SignaltransformstftLayer) -> SignaltransformstftLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_transform_stft_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_transform_stft_layer_copy(s : SignaltransformstftLayer) -> SignaltransformstftLayer {
  let result = signal_transform_stft_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_transform_stft_layer_fill(s : SignaltransformstftLayer, v : Double) -> SignaltransformstftLayer {
  let result = signal_transform_stft_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_transform_stft_layer_min(s : SignaltransformstftLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_stft_layer_max(s : SignaltransformstftLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_stft_layer_to_string(s : SignaltransformstftLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformstftBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_stft_buffer_make(size : Int) -> SignaltransformstftBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_stft_buffer_len(s : SignaltransformstftBuffer) -> Int { s.size }

pub fn signal_transform_stft_buffer_get(s : SignaltransformstftBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_stft_buffer_set(s : SignaltransformstftBuffer, i : Int, v : Double) -> SignaltransformstftBuffer {
  let result = signal_transform_stft_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_transform_stft_buffer_sum(s : SignaltransformstftBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_transform_stft_buffer_mean(s : SignaltransformstftBuffer) -> Double {
  if s.size == 0 { 0.0 } else { signal_transform_stft_buffer_sum(s) / s.size.to_double() }
}

pub fn signal_transform_stft_buffer_scale(s : SignaltransformstftBuffer, f : Double) -> SignaltransformstftBuffer {
  let result = signal_transform_stft_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_transform_stft_buffer_add(a : SignaltransformstftBuffer, b : SignaltransformstftBuffer) -> SignaltransformstftBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_transform_stft_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_transform_stft_buffer_copy(s : SignaltransformstftBuffer) -> SignaltransformstftBuffer {
  let result = signal_transform_stft_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_transform_stft_buffer_fill(s : SignaltransformstftBuffer, v : Double) -> SignaltransformstftBuffer {
  let result = signal_transform_stft_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_transform_stft_buffer_min(s : SignaltransformstftBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_stft_buffer_max(s : SignaltransformstftBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_stft_buffer_to_string(s : SignaltransformstftBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformstftCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_stft_cursor_make(size : Int) -> SignaltransformstftCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_stft_cursor_len(s : SignaltransformstftCursor) -> Int { s.size }

pub fn signal_transform_stft_cursor_get(s : SignaltransformstftCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_stft_cursor_set(s : SignaltransformstftCursor, i : Int, v : Double) -> SignaltransformstftCursor {
  let result = signal_transform_stft_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_transform_stft_cursor_sum(s : SignaltransformstftCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_transform_stft_cursor_mean(s : SignaltransformstftCursor) -> Double {
  if s.size == 0 { 0.0 } else { signal_transform_stft_cursor_sum(s) / s.size.to_double() }
}

pub fn signal_transform_stft_cursor_scale(s : SignaltransformstftCursor, f : Double) -> SignaltransformstftCursor {
  let result = signal_transform_stft_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_transform_stft_cursor_add(a : SignaltransformstftCursor, b : SignaltransformstftCursor) -> SignaltransformstftCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_transform_stft_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_transform_stft_cursor_copy(s : SignaltransformstftCursor) -> SignaltransformstftCursor {
  let result = signal_transform_stft_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_transform_stft_cursor_fill(s : SignaltransformstftCursor, v : Double) -> SignaltransformstftCursor {
  let result = signal_transform_stft_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_transform_stft_cursor_min(s : SignaltransformstftCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_stft_cursor_max(s : SignaltransformstftCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_stft_cursor_to_string(s : SignaltransformstftCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformstftView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_stft_view_make(size : Int) -> SignaltransformstftView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_stft_view_len(s : SignaltransformstftView) -> Int { s.size }

pub fn signal_transform_stft_view_get(s : SignaltransformstftView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_stft_view_set(s : SignaltransformstftView, i : Int, v : Double) -> SignaltransformstftView {
  let result = signal_transform_stft_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_transform_stft_view_sum(s : SignaltransformstftView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_transform_stft_view_mean(s : SignaltransformstftView) -> Double {
  if s.size == 0 { 0.0 } else { signal_transform_stft_view_sum(s) / s.size.to_double() }
}

pub fn signal_transform_stft_view_scale(s : SignaltransformstftView, f : Double) -> SignaltransformstftView {
  let result = signal_transform_stft_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_transform_stft_view_add(a : SignaltransformstftView, b : SignaltransformstftView) -> SignaltransformstftView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_transform_stft_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_transform_stft_view_copy(s : SignaltransformstftView) -> SignaltransformstftView {
  let result = signal_transform_stft_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_transform_stft_view_fill(s : SignaltransformstftView, v : Double) -> SignaltransformstftView {
  let result = signal_transform_stft_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_transform_stft_view_min(s : SignaltransformstftView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_stft_view_max(s : SignaltransformstftView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_stft_view_to_string(s : SignaltransformstftView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformstftRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_stft_range_make(size : Int) -> SignaltransformstftRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_stft_range_len(s : SignaltransformstftRange) -> Int { s.size }

pub fn signal_transform_stft_range_get(s : SignaltransformstftRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_stft_range_set(s : SignaltransformstftRange, i : Int, v : Double) -> SignaltransformstftRange {
  let result = signal_transform_stft_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_transform_stft_range_sum(s : SignaltransformstftRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_transform_stft_range_mean(s : SignaltransformstftRange) -> Double {
  if s.size == 0 { 0.0 } else { signal_transform_stft_range_sum(s) / s.size.to_double() }
}

pub fn signal_transform_stft_range_scale(s : SignaltransformstftRange, f : Double) -> SignaltransformstftRange {
  let result = signal_transform_stft_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_transform_stft_range_add(a : SignaltransformstftRange, b : SignaltransformstftRange) -> SignaltransformstftRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_transform_stft_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_transform_stft_range_copy(s : SignaltransformstftRange) -> SignaltransformstftRange {
  let result = signal_transform_stft_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_transform_stft_range_fill(s : SignaltransformstftRange, v : Double) -> SignaltransformstftRange {
  let result = signal_transform_stft_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_transform_stft_range_min(s : SignaltransformstftRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_stft_range_max(s : SignaltransformstftRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_stft_range_to_string(s : SignaltransformstftRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformstftSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_stft_slice_make(size : Int) -> SignaltransformstftSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_stft_slice_len(s : SignaltransformstftSlice) -> Int { s.size }

pub fn signal_transform_stft_slice_get(s : SignaltransformstftSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_stft_slice_set(s : SignaltransformstftSlice, i : Int, v : Double) -> SignaltransformstftSlice {
  let result = signal_transform_stft_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_transform_stft_slice_sum(s : SignaltransformstftSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_transform_stft_slice_mean(s : SignaltransformstftSlice) -> Double {
  if s.size == 0 { 0.0 } else { signal_transform_stft_slice_sum(s) / s.size.to_double() }
}

pub fn signal_transform_stft_slice_scale(s : SignaltransformstftSlice, f : Double) -> SignaltransformstftSlice {
  let result = signal_transform_stft_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_transform_stft_slice_add(a : SignaltransformstftSlice, b : SignaltransformstftSlice) -> SignaltransformstftSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_transform_stft_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_transform_stft_slice_copy(s : SignaltransformstftSlice) -> SignaltransformstftSlice {
  let result = signal_transform_stft_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_transform_stft_slice_fill(s : SignaltransformstftSlice, v : Double) -> SignaltransformstftSlice {
  let result = signal_transform_stft_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_transform_stft_slice_min(s : SignaltransformstftSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_stft_slice_max(s : SignaltransformstftSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_stft_slice_to_string(s : SignaltransformstftSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn signal_transform_stft_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_transform_stft_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_transform_stft_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_transform_stft_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_transform_stft_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_transform_stft_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_transform_stft_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_transform_stft_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_transform_stft_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_transform_stft_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_transform_stft_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_transform_stft_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_transform_stft_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_transform_stft_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_transform_stft_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_transform_stft_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_transform_stft_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_transform_stft_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_transform_stft_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_transform_stft_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_transform_stft_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_transform_stft_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_transform_stft_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_transform_stft_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_transform_stft_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

