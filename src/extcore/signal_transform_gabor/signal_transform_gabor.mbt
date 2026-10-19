///===
/// extcore/signal_transform_gabor

pub(all) struct SignaltransformgaborPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn signal_transform_gabor_make_point(x : Double, y : Double) -> SignaltransformgaborPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn signal_transform_gabor_make_point3(x : Double, y : Double, z : Double) -> SignaltransformgaborPoint {
  { x, y, z, label: 0 }
}

pub fn signal_transform_gabor_point_x(pt : SignaltransformgaborPoint) -> Double { pt.x }

pub fn signal_transform_gabor_point_y(pt : SignaltransformgaborPoint) -> Double { pt.y }

pub fn signal_transform_gabor_point_z(pt : SignaltransformgaborPoint) -> Double { pt.z }

pub fn signal_transform_gabor_point_label(pt : SignaltransformgaborPoint) -> Int { pt.label }

pub fn signal_transform_gabor_point_dist(a : SignaltransformgaborPoint, b : SignaltransformgaborPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn signal_transform_gabor_point_add(a : SignaltransformgaborPoint, b : SignaltransformgaborPoint) -> SignaltransformgaborPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn signal_transform_gabor_point_sub(a : SignaltransformgaborPoint, b : SignaltransformgaborPoint) -> SignaltransformgaborPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn signal_transform_gabor_point_scale(pt : SignaltransformgaborPoint, s : Double) -> SignaltransformgaborPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn signal_transform_gabor_point_dot(a : SignaltransformgaborPoint, b : SignaltransformgaborPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn signal_transform_gabor_point_cross(a : SignaltransformgaborPoint, b : SignaltransformgaborPoint) -> SignaltransformgaborPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn signal_transform_gabor_point_norm(pt : SignaltransformgaborPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn signal_transform_gabor_point_normalize(pt : SignaltransformgaborPoint) -> SignaltransformgaborPoint {
  let n = signal_transform_gabor_point_norm(pt)
  if n < 0.0000001 { pt } else { signal_transform_gabor_point_scale(pt, 1.0 / n) }
}

pub fn signal_transform_gabor_point_negate(pt : SignaltransformgaborPoint) -> SignaltransformgaborPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn signal_transform_gabor_point_mid(a : SignaltransformgaborPoint, b : SignaltransformgaborPoint) -> SignaltransformgaborPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn signal_transform_gabor_point_lerp(a : SignaltransformgaborPoint, b : SignaltransformgaborPoint, t : Double) -> SignaltransformgaborPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn signal_transform_gabor_point_to_string(pt : SignaltransformgaborPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct SignaltransformgaborSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn signal_transform_gabor_make_series(vals : Array[Double], name : String) -> SignaltransformgaborSeries {
  { vals, name, meta: 0 }
}

pub fn signal_transform_gabor_series_len(s : SignaltransformgaborSeries) -> Int { s.vals.length() }

pub fn signal_transform_gabor_series_sum(s : SignaltransformgaborSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn signal_transform_gabor_series_mean(s : SignaltransformgaborSeries) -> Double {
  let n = signal_transform_gabor_series_len(s)
  if n == 0 { 0.0 } else { signal_transform_gabor_series_sum(s) / n.to_double() }
}

pub fn signal_transform_gabor_series_min(s : SignaltransformgaborSeries) -> Double {
  let n = signal_transform_gabor_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn signal_transform_gabor_series_max(s : SignaltransformgaborSeries) -> Double {
  let n = signal_transform_gabor_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn signal_transform_gabor_series_range(s : SignaltransformgaborSeries) -> Double {
  signal_transform_gabor_series_max(s) - signal_transform_gabor_series_min(s)
}

pub fn signal_transform_gabor_series_var(s : SignaltransformgaborSeries) -> Double {
  let n = signal_transform_gabor_series_len(s)
  if n == 0 { 0.0 } else {
    let m = signal_transform_gabor_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn signal_transform_gabor_series_std(s : SignaltransformgaborSeries) -> Double { @_common.sqrt(signal_transform_gabor_series_var(s)) }

pub fn signal_transform_gabor_series_median(s : SignaltransformgaborSeries) -> Double {
  let n = signal_transform_gabor_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = signal_transform_gabor_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn signal_transform_gabor_series_scale(s : SignaltransformgaborSeries, f : Double) -> SignaltransformgaborSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn signal_transform_gabor_series_add(a : SignaltransformgaborSeries, b : SignaltransformgaborSeries) -> SignaltransformgaborSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn signal_transform_gabor_series_sub(a : SignaltransformgaborSeries, b : SignaltransformgaborSeries) -> SignaltransformgaborSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn signal_transform_gabor_series_normalize(s : SignaltransformgaborSeries) -> SignaltransformgaborSeries {
  let mn = signal_transform_gabor_series_min(s)
  let mx = signal_transform_gabor_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn signal_transform_gabor_series_cumsum(s : SignaltransformgaborSeries) -> SignaltransformgaborSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn signal_transform_gabor_series_to_string(s : SignaltransformgaborSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SignaltransformgaborMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn signal_transform_gabor_make_matrix(rows : Int, cols : Int, val : Double) -> SignaltransformgaborMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn signal_transform_gabor_matrix_identity(n : Int) -> SignaltransformgaborMatrix {
  let m = signal_transform_gabor_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn signal_transform_gabor_matrix_get(m : SignaltransformgaborMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn signal_transform_gabor_matrix_transpose(m : SignaltransformgaborMatrix) -> SignaltransformgaborMatrix {
  let result = signal_transform_gabor_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn signal_transform_gabor_matrix_add(a : SignaltransformgaborMatrix, b : SignaltransformgaborMatrix) -> SignaltransformgaborMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = signal_transform_gabor_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn signal_transform_gabor_matrix_scale(m : SignaltransformgaborMatrix, s : Double) -> SignaltransformgaborMatrix {
  let result = signal_transform_gabor_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn signal_transform_gabor_matrix_multiply(a : SignaltransformgaborMatrix, b : SignaltransformgaborMatrix) -> SignaltransformgaborMatrix {
  if a.cols != b.rows { return signal_transform_gabor_make_matrix(a.rows, b.cols, 0.0) }
  let result = signal_transform_gabor_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn signal_transform_gabor_matrix_trace(m : SignaltransformgaborMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn signal_transform_gabor_matrix_det(m : SignaltransformgaborMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn signal_transform_gabor_matrix_norm(m : SignaltransformgaborMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn signal_transform_gabor_matrix_to_string(m : SignaltransformgaborMatrix) -> String {
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

pub(all) struct SignaltransformgaborVector {
  comps : Array[Double]
  dim : Int
}

pub fn signal_transform_gabor_make_vector(comps : Array[Double]) -> SignaltransformgaborVector {
  { comps, dim: comps.length() }
}

pub fn signal_transform_gabor_vector_zero(dim : Int) -> SignaltransformgaborVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn signal_transform_gabor_vector_add(a : SignaltransformgaborVector, b : SignaltransformgaborVector) -> SignaltransformgaborVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn signal_transform_gabor_vector_sub(a : SignaltransformgaborVector, b : SignaltransformgaborVector) -> SignaltransformgaborVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn signal_transform_gabor_vector_scale(v : SignaltransformgaborVector, s : Double) -> SignaltransformgaborVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn signal_transform_gabor_vector_dot(a : SignaltransformgaborVector, b : SignaltransformgaborVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn signal_transform_gabor_vector_norm(v : SignaltransformgaborVector) -> Double { @_common.sqrt(signal_transform_gabor_vector_dot(v, v)) }

pub fn signal_transform_gabor_vector_normalize(v : SignaltransformgaborVector) -> SignaltransformgaborVector {
  let n = signal_transform_gabor_vector_norm(v)
  if n < 0.0000001 { v } else { signal_transform_gabor_vector_scale(v, 1.0 / n) }
}

pub fn signal_transform_gabor_vector_dist(a : SignaltransformgaborVector, b : SignaltransformgaborVector) -> Double {
  signal_transform_gabor_vector_norm(signal_transform_gabor_vector_sub(a, b))
}

pub fn signal_transform_gabor_vector_to_string(v : SignaltransformgaborVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn signal_transform_gabor_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn signal_transform_gabor_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = signal_transform_gabor_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn signal_transform_gabor_std(data : Array[Double]) -> Double { @_common.sqrt(signal_transform_gabor_var(data)) }

pub fn signal_transform_gabor_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = signal_transform_gabor_mean(a); let mb = signal_transform_gabor_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn signal_transform_gabor_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = signal_transform_gabor_std(a); let sb = signal_transform_gabor_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { signal_transform_gabor_cov(a, b) / (sa * sb) }
}

pub fn signal_transform_gabor_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = signal_transform_gabor_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn signal_transform_gabor_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn signal_transform_gabor_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn signal_transform_gabor_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  @_common.sqrt(signal_transform_gabor_mse(pred, labels))
}

pub fn signal_transform_gabor_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn signal_transform_gabor_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = signal_transform_gabor_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn signal_transform_gabor_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn signal_transform_gabor_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn signal_transform_gabor_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = signal_transform_gabor_precision(pred, labels, pos); let r = signal_transform_gabor_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn signal_transform_gabor_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn signal_transform_gabor_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = signal_transform_gabor_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn signal_transform_gabor_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn signal_transform_gabor_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn signal_transform_gabor_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = signal_transform_gabor_gcd(a, b)
    (a / g) * b
  }
}

pub fn signal_transform_gabor_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn signal_transform_gabor_fibonacci(n : Int) -> Int {
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

pub fn signal_transform_gabor_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = signal_transform_gabor_min(data); let mx = signal_transform_gabor_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn signal_transform_gabor_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = signal_transform_gabor_mean(data); let sd = signal_transform_gabor_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn signal_transform_gabor_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn signal_transform_gabor_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn signal_transform_gabor_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn signal_transform_gabor_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn signal_transform_gabor_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn signal_transform_gabor_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

pub(all) struct SignaltransformgaborFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_gabor_frame_make(size : Int) -> SignaltransformgaborFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_gabor_frame_len(s : SignaltransformgaborFrame) -> Int { s.size }

pub fn signal_transform_gabor_frame_get(s : SignaltransformgaborFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_gabor_frame_set(s : SignaltransformgaborFrame, i : Int, v : Double) -> SignaltransformgaborFrame {
  let result = signal_transform_gabor_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_transform_gabor_frame_sum(s : SignaltransformgaborFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_transform_gabor_frame_mean(s : SignaltransformgaborFrame) -> Double {
  if s.size == 0 { 0.0 } else { signal_transform_gabor_frame_sum(s) / s.size.to_double() }
}

pub fn signal_transform_gabor_frame_scale(s : SignaltransformgaborFrame, f : Double) -> SignaltransformgaborFrame {
  let result = signal_transform_gabor_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_transform_gabor_frame_add(a : SignaltransformgaborFrame, b : SignaltransformgaborFrame) -> SignaltransformgaborFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_transform_gabor_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_transform_gabor_frame_copy(s : SignaltransformgaborFrame) -> SignaltransformgaborFrame {
  let result = signal_transform_gabor_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_transform_gabor_frame_fill(s : SignaltransformgaborFrame, v : Double) -> SignaltransformgaborFrame {
  let result = signal_transform_gabor_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_transform_gabor_frame_min(s : SignaltransformgaborFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_gabor_frame_max(s : SignaltransformgaborFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_gabor_frame_to_string(s : SignaltransformgaborFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformgaborTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_gabor_table_make(size : Int) -> SignaltransformgaborTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_gabor_table_len(s : SignaltransformgaborTable) -> Int { s.size }

pub fn signal_transform_gabor_table_get(s : SignaltransformgaborTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_gabor_table_set(s : SignaltransformgaborTable, i : Int, v : Double) -> SignaltransformgaborTable {
  let result = signal_transform_gabor_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_transform_gabor_table_sum(s : SignaltransformgaborTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_transform_gabor_table_mean(s : SignaltransformgaborTable) -> Double {
  if s.size == 0 { 0.0 } else { signal_transform_gabor_table_sum(s) / s.size.to_double() }
}

pub fn signal_transform_gabor_table_scale(s : SignaltransformgaborTable, f : Double) -> SignaltransformgaborTable {
  let result = signal_transform_gabor_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_transform_gabor_table_add(a : SignaltransformgaborTable, b : SignaltransformgaborTable) -> SignaltransformgaborTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_transform_gabor_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_transform_gabor_table_copy(s : SignaltransformgaborTable) -> SignaltransformgaborTable {
  let result = signal_transform_gabor_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_transform_gabor_table_fill(s : SignaltransformgaborTable, v : Double) -> SignaltransformgaborTable {
  let result = signal_transform_gabor_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_transform_gabor_table_min(s : SignaltransformgaborTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_gabor_table_max(s : SignaltransformgaborTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_gabor_table_to_string(s : SignaltransformgaborTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformgaborGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_gabor_graphn_make(size : Int) -> SignaltransformgaborGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_gabor_graphn_len(s : SignaltransformgaborGraphN) -> Int { s.size }

pub fn signal_transform_gabor_graphn_get(s : SignaltransformgaborGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_gabor_graphn_set(s : SignaltransformgaborGraphN, i : Int, v : Double) -> SignaltransformgaborGraphN {
  let result = signal_transform_gabor_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_transform_gabor_graphn_sum(s : SignaltransformgaborGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_transform_gabor_graphn_mean(s : SignaltransformgaborGraphN) -> Double {
  if s.size == 0 { 0.0 } else { signal_transform_gabor_graphn_sum(s) / s.size.to_double() }
}

pub fn signal_transform_gabor_graphn_scale(s : SignaltransformgaborGraphN, f : Double) -> SignaltransformgaborGraphN {
  let result = signal_transform_gabor_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_transform_gabor_graphn_add(a : SignaltransformgaborGraphN, b : SignaltransformgaborGraphN) -> SignaltransformgaborGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_transform_gabor_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_transform_gabor_graphn_copy(s : SignaltransformgaborGraphN) -> SignaltransformgaborGraphN {
  let result = signal_transform_gabor_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_transform_gabor_graphn_fill(s : SignaltransformgaborGraphN, v : Double) -> SignaltransformgaborGraphN {
  let result = signal_transform_gabor_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_transform_gabor_graphn_min(s : SignaltransformgaborGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_gabor_graphn_max(s : SignaltransformgaborGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_gabor_graphn_to_string(s : SignaltransformgaborGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformgaborNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_gabor_node_make(size : Int) -> SignaltransformgaborNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_gabor_node_len(s : SignaltransformgaborNode) -> Int { s.size }

pub fn signal_transform_gabor_node_get(s : SignaltransformgaborNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_gabor_node_set(s : SignaltransformgaborNode, i : Int, v : Double) -> SignaltransformgaborNode {
  let result = signal_transform_gabor_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_transform_gabor_node_sum(s : SignaltransformgaborNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_transform_gabor_node_mean(s : SignaltransformgaborNode) -> Double {
  if s.size == 0 { 0.0 } else { signal_transform_gabor_node_sum(s) / s.size.to_double() }
}

pub fn signal_transform_gabor_node_scale(s : SignaltransformgaborNode, f : Double) -> SignaltransformgaborNode {
  let result = signal_transform_gabor_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_transform_gabor_node_add(a : SignaltransformgaborNode, b : SignaltransformgaborNode) -> SignaltransformgaborNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_transform_gabor_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_transform_gabor_node_copy(s : SignaltransformgaborNode) -> SignaltransformgaborNode {
  let result = signal_transform_gabor_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_transform_gabor_node_fill(s : SignaltransformgaborNode, v : Double) -> SignaltransformgaborNode {
  let result = signal_transform_gabor_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_transform_gabor_node_min(s : SignaltransformgaborNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_gabor_node_max(s : SignaltransformgaborNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_gabor_node_to_string(s : SignaltransformgaborNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformgaborEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_gabor_edge_make(size : Int) -> SignaltransformgaborEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_gabor_edge_len(s : SignaltransformgaborEdge) -> Int { s.size }

pub fn signal_transform_gabor_edge_get(s : SignaltransformgaborEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_gabor_edge_set(s : SignaltransformgaborEdge, i : Int, v : Double) -> SignaltransformgaborEdge {
  let result = signal_transform_gabor_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_transform_gabor_edge_sum(s : SignaltransformgaborEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_transform_gabor_edge_mean(s : SignaltransformgaborEdge) -> Double {
  if s.size == 0 { 0.0 } else { signal_transform_gabor_edge_sum(s) / s.size.to_double() }
}

pub fn signal_transform_gabor_edge_scale(s : SignaltransformgaborEdge, f : Double) -> SignaltransformgaborEdge {
  let result = signal_transform_gabor_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_transform_gabor_edge_add(a : SignaltransformgaborEdge, b : SignaltransformgaborEdge) -> SignaltransformgaborEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_transform_gabor_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_transform_gabor_edge_copy(s : SignaltransformgaborEdge) -> SignaltransformgaborEdge {
  let result = signal_transform_gabor_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_transform_gabor_edge_fill(s : SignaltransformgaborEdge, v : Double) -> SignaltransformgaborEdge {
  let result = signal_transform_gabor_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_transform_gabor_edge_min(s : SignaltransformgaborEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_gabor_edge_max(s : SignaltransformgaborEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_gabor_edge_to_string(s : SignaltransformgaborEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformgaborPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_gabor_path_make(size : Int) -> SignaltransformgaborPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_gabor_path_len(s : SignaltransformgaborPath) -> Int { s.size }

pub fn signal_transform_gabor_path_get(s : SignaltransformgaborPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_gabor_path_set(s : SignaltransformgaborPath, i : Int, v : Double) -> SignaltransformgaborPath {
  let result = signal_transform_gabor_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_transform_gabor_path_sum(s : SignaltransformgaborPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_transform_gabor_path_mean(s : SignaltransformgaborPath) -> Double {
  if s.size == 0 { 0.0 } else { signal_transform_gabor_path_sum(s) / s.size.to_double() }
}

pub fn signal_transform_gabor_path_scale(s : SignaltransformgaborPath, f : Double) -> SignaltransformgaborPath {
  let result = signal_transform_gabor_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_transform_gabor_path_add(a : SignaltransformgaborPath, b : SignaltransformgaborPath) -> SignaltransformgaborPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_transform_gabor_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_transform_gabor_path_copy(s : SignaltransformgaborPath) -> SignaltransformgaborPath {
  let result = signal_transform_gabor_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_transform_gabor_path_fill(s : SignaltransformgaborPath, v : Double) -> SignaltransformgaborPath {
  let result = signal_transform_gabor_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_transform_gabor_path_min(s : SignaltransformgaborPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_gabor_path_max(s : SignaltransformgaborPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_gabor_path_to_string(s : SignaltransformgaborPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformgaborCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_gabor_cluster_make(size : Int) -> SignaltransformgaborCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_gabor_cluster_len(s : SignaltransformgaborCluster) -> Int { s.size }

pub fn signal_transform_gabor_cluster_get(s : SignaltransformgaborCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_gabor_cluster_set(s : SignaltransformgaborCluster, i : Int, v : Double) -> SignaltransformgaborCluster {
  let result = signal_transform_gabor_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_transform_gabor_cluster_sum(s : SignaltransformgaborCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_transform_gabor_cluster_mean(s : SignaltransformgaborCluster) -> Double {
  if s.size == 0 { 0.0 } else { signal_transform_gabor_cluster_sum(s) / s.size.to_double() }
}

pub fn signal_transform_gabor_cluster_scale(s : SignaltransformgaborCluster, f : Double) -> SignaltransformgaborCluster {
  let result = signal_transform_gabor_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_transform_gabor_cluster_add(a : SignaltransformgaborCluster, b : SignaltransformgaborCluster) -> SignaltransformgaborCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_transform_gabor_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_transform_gabor_cluster_copy(s : SignaltransformgaborCluster) -> SignaltransformgaborCluster {
  let result = signal_transform_gabor_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_transform_gabor_cluster_fill(s : SignaltransformgaborCluster, v : Double) -> SignaltransformgaborCluster {
  let result = signal_transform_gabor_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_transform_gabor_cluster_min(s : SignaltransformgaborCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_gabor_cluster_max(s : SignaltransformgaborCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_gabor_cluster_to_string(s : SignaltransformgaborCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformgaborModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_gabor_model_make(size : Int) -> SignaltransformgaborModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_gabor_model_len(s : SignaltransformgaborModel) -> Int { s.size }

pub fn signal_transform_gabor_model_get(s : SignaltransformgaborModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_gabor_model_set(s : SignaltransformgaborModel, i : Int, v : Double) -> SignaltransformgaborModel {
  let result = signal_transform_gabor_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_transform_gabor_model_sum(s : SignaltransformgaborModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_transform_gabor_model_mean(s : SignaltransformgaborModel) -> Double {
  if s.size == 0 { 0.0 } else { signal_transform_gabor_model_sum(s) / s.size.to_double() }
}

pub fn signal_transform_gabor_model_scale(s : SignaltransformgaborModel, f : Double) -> SignaltransformgaborModel {
  let result = signal_transform_gabor_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_transform_gabor_model_add(a : SignaltransformgaborModel, b : SignaltransformgaborModel) -> SignaltransformgaborModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_transform_gabor_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_transform_gabor_model_copy(s : SignaltransformgaborModel) -> SignaltransformgaborModel {
  let result = signal_transform_gabor_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_transform_gabor_model_fill(s : SignaltransformgaborModel, v : Double) -> SignaltransformgaborModel {
  let result = signal_transform_gabor_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_transform_gabor_model_min(s : SignaltransformgaborModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_gabor_model_max(s : SignaltransformgaborModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_gabor_model_to_string(s : SignaltransformgaborModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformgaborLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_gabor_layer_make(size : Int) -> SignaltransformgaborLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_gabor_layer_len(s : SignaltransformgaborLayer) -> Int { s.size }

pub fn signal_transform_gabor_layer_get(s : SignaltransformgaborLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_gabor_layer_set(s : SignaltransformgaborLayer, i : Int, v : Double) -> SignaltransformgaborLayer {
  let result = signal_transform_gabor_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_transform_gabor_layer_sum(s : SignaltransformgaborLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_transform_gabor_layer_mean(s : SignaltransformgaborLayer) -> Double {
  if s.size == 0 { 0.0 } else { signal_transform_gabor_layer_sum(s) / s.size.to_double() }
}

pub fn signal_transform_gabor_layer_scale(s : SignaltransformgaborLayer, f : Double) -> SignaltransformgaborLayer {
  let result = signal_transform_gabor_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_transform_gabor_layer_add(a : SignaltransformgaborLayer, b : SignaltransformgaborLayer) -> SignaltransformgaborLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_transform_gabor_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_transform_gabor_layer_copy(s : SignaltransformgaborLayer) -> SignaltransformgaborLayer {
  let result = signal_transform_gabor_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_transform_gabor_layer_fill(s : SignaltransformgaborLayer, v : Double) -> SignaltransformgaborLayer {
  let result = signal_transform_gabor_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_transform_gabor_layer_min(s : SignaltransformgaborLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_gabor_layer_max(s : SignaltransformgaborLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_gabor_layer_to_string(s : SignaltransformgaborLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformgaborBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_gabor_buffer_make(size : Int) -> SignaltransformgaborBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_gabor_buffer_len(s : SignaltransformgaborBuffer) -> Int { s.size }

pub fn signal_transform_gabor_buffer_get(s : SignaltransformgaborBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_gabor_buffer_set(s : SignaltransformgaborBuffer, i : Int, v : Double) -> SignaltransformgaborBuffer {
  let result = signal_transform_gabor_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_transform_gabor_buffer_sum(s : SignaltransformgaborBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_transform_gabor_buffer_mean(s : SignaltransformgaborBuffer) -> Double {
  if s.size == 0 { 0.0 } else { signal_transform_gabor_buffer_sum(s) / s.size.to_double() }
}

pub fn signal_transform_gabor_buffer_scale(s : SignaltransformgaborBuffer, f : Double) -> SignaltransformgaborBuffer {
  let result = signal_transform_gabor_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_transform_gabor_buffer_add(a : SignaltransformgaborBuffer, b : SignaltransformgaborBuffer) -> SignaltransformgaborBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_transform_gabor_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_transform_gabor_buffer_copy(s : SignaltransformgaborBuffer) -> SignaltransformgaborBuffer {
  let result = signal_transform_gabor_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_transform_gabor_buffer_fill(s : SignaltransformgaborBuffer, v : Double) -> SignaltransformgaborBuffer {
  let result = signal_transform_gabor_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_transform_gabor_buffer_min(s : SignaltransformgaborBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_gabor_buffer_max(s : SignaltransformgaborBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_gabor_buffer_to_string(s : SignaltransformgaborBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformgaborCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_gabor_cursor_make(size : Int) -> SignaltransformgaborCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_gabor_cursor_len(s : SignaltransformgaborCursor) -> Int { s.size }

pub fn signal_transform_gabor_cursor_get(s : SignaltransformgaborCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_gabor_cursor_set(s : SignaltransformgaborCursor, i : Int, v : Double) -> SignaltransformgaborCursor {
  let result = signal_transform_gabor_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_transform_gabor_cursor_sum(s : SignaltransformgaborCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_transform_gabor_cursor_mean(s : SignaltransformgaborCursor) -> Double {
  if s.size == 0 { 0.0 } else { signal_transform_gabor_cursor_sum(s) / s.size.to_double() }
}

pub fn signal_transform_gabor_cursor_scale(s : SignaltransformgaborCursor, f : Double) -> SignaltransformgaborCursor {
  let result = signal_transform_gabor_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_transform_gabor_cursor_add(a : SignaltransformgaborCursor, b : SignaltransformgaborCursor) -> SignaltransformgaborCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_transform_gabor_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_transform_gabor_cursor_copy(s : SignaltransformgaborCursor) -> SignaltransformgaborCursor {
  let result = signal_transform_gabor_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_transform_gabor_cursor_fill(s : SignaltransformgaborCursor, v : Double) -> SignaltransformgaborCursor {
  let result = signal_transform_gabor_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_transform_gabor_cursor_min(s : SignaltransformgaborCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_gabor_cursor_max(s : SignaltransformgaborCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_gabor_cursor_to_string(s : SignaltransformgaborCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformgaborView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_gabor_view_make(size : Int) -> SignaltransformgaborView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_gabor_view_len(s : SignaltransformgaborView) -> Int { s.size }

pub fn signal_transform_gabor_view_get(s : SignaltransformgaborView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_gabor_view_set(s : SignaltransformgaborView, i : Int, v : Double) -> SignaltransformgaborView {
  let result = signal_transform_gabor_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_transform_gabor_view_sum(s : SignaltransformgaborView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_transform_gabor_view_mean(s : SignaltransformgaborView) -> Double {
  if s.size == 0 { 0.0 } else { signal_transform_gabor_view_sum(s) / s.size.to_double() }
}

pub fn signal_transform_gabor_view_scale(s : SignaltransformgaborView, f : Double) -> SignaltransformgaborView {
  let result = signal_transform_gabor_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_transform_gabor_view_add(a : SignaltransformgaborView, b : SignaltransformgaborView) -> SignaltransformgaborView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_transform_gabor_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_transform_gabor_view_copy(s : SignaltransformgaborView) -> SignaltransformgaborView {
  let result = signal_transform_gabor_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_transform_gabor_view_fill(s : SignaltransformgaborView, v : Double) -> SignaltransformgaborView {
  let result = signal_transform_gabor_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_transform_gabor_view_min(s : SignaltransformgaborView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_gabor_view_max(s : SignaltransformgaborView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_gabor_view_to_string(s : SignaltransformgaborView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformgaborRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_gabor_range_make(size : Int) -> SignaltransformgaborRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_gabor_range_len(s : SignaltransformgaborRange) -> Int { s.size }

pub fn signal_transform_gabor_range_get(s : SignaltransformgaborRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_gabor_range_set(s : SignaltransformgaborRange, i : Int, v : Double) -> SignaltransformgaborRange {
  let result = signal_transform_gabor_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_transform_gabor_range_sum(s : SignaltransformgaborRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_transform_gabor_range_mean(s : SignaltransformgaborRange) -> Double {
  if s.size == 0 { 0.0 } else { signal_transform_gabor_range_sum(s) / s.size.to_double() }
}

pub fn signal_transform_gabor_range_scale(s : SignaltransformgaborRange, f : Double) -> SignaltransformgaborRange {
  let result = signal_transform_gabor_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_transform_gabor_range_add(a : SignaltransformgaborRange, b : SignaltransformgaborRange) -> SignaltransformgaborRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_transform_gabor_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_transform_gabor_range_copy(s : SignaltransformgaborRange) -> SignaltransformgaborRange {
  let result = signal_transform_gabor_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_transform_gabor_range_fill(s : SignaltransformgaborRange, v : Double) -> SignaltransformgaborRange {
  let result = signal_transform_gabor_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_transform_gabor_range_min(s : SignaltransformgaborRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_gabor_range_max(s : SignaltransformgaborRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_gabor_range_to_string(s : SignaltransformgaborRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformgaborSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_gabor_slice_make(size : Int) -> SignaltransformgaborSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_gabor_slice_len(s : SignaltransformgaborSlice) -> Int { s.size }

pub fn signal_transform_gabor_slice_get(s : SignaltransformgaborSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_gabor_slice_set(s : SignaltransformgaborSlice, i : Int, v : Double) -> SignaltransformgaborSlice {
  let result = signal_transform_gabor_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_transform_gabor_slice_sum(s : SignaltransformgaborSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_transform_gabor_slice_mean(s : SignaltransformgaborSlice) -> Double {
  if s.size == 0 { 0.0 } else { signal_transform_gabor_slice_sum(s) / s.size.to_double() }
}

pub fn signal_transform_gabor_slice_scale(s : SignaltransformgaborSlice, f : Double) -> SignaltransformgaborSlice {
  let result = signal_transform_gabor_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_transform_gabor_slice_add(a : SignaltransformgaborSlice, b : SignaltransformgaborSlice) -> SignaltransformgaborSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_transform_gabor_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_transform_gabor_slice_copy(s : SignaltransformgaborSlice) -> SignaltransformgaborSlice {
  let result = signal_transform_gabor_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_transform_gabor_slice_fill(s : SignaltransformgaborSlice, v : Double) -> SignaltransformgaborSlice {
  let result = signal_transform_gabor_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_transform_gabor_slice_min(s : SignaltransformgaborSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_gabor_slice_max(s : SignaltransformgaborSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_gabor_slice_to_string(s : SignaltransformgaborSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

