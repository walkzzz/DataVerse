///===
/// extcore/stats_dist_binomial

pub(all) struct StatsdistbinomialPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn stats_dist_binomial_make_point(x : Double, y : Double) -> StatsdistbinomialPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn stats_dist_binomial_make_point3(x : Double, y : Double, z : Double) -> StatsdistbinomialPoint {
  { x, y, z, label: 0 }
}

pub fn stats_dist_binomial_point_x(pt : StatsdistbinomialPoint) -> Double { pt.x }

pub fn stats_dist_binomial_point_y(pt : StatsdistbinomialPoint) -> Double { pt.y }

pub fn stats_dist_binomial_point_z(pt : StatsdistbinomialPoint) -> Double { pt.z }

pub fn stats_dist_binomial_point_label(pt : StatsdistbinomialPoint) -> Int { pt.label }

pub fn stats_dist_binomial_point_dist(a : StatsdistbinomialPoint, b : StatsdistbinomialPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn stats_dist_binomial_point_add(a : StatsdistbinomialPoint, b : StatsdistbinomialPoint) -> StatsdistbinomialPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn stats_dist_binomial_point_sub(a : StatsdistbinomialPoint, b : StatsdistbinomialPoint) -> StatsdistbinomialPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn stats_dist_binomial_point_scale(pt : StatsdistbinomialPoint, s : Double) -> StatsdistbinomialPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn stats_dist_binomial_point_dot(a : StatsdistbinomialPoint, b : StatsdistbinomialPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn stats_dist_binomial_point_cross(a : StatsdistbinomialPoint, b : StatsdistbinomialPoint) -> StatsdistbinomialPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn stats_dist_binomial_point_norm(pt : StatsdistbinomialPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn stats_dist_binomial_point_normalize(pt : StatsdistbinomialPoint) -> StatsdistbinomialPoint {
  let n = stats_dist_binomial_point_norm(pt)
  if n < 0.0000001 { pt } else { stats_dist_binomial_point_scale(pt, 1.0 / n) }
}

pub fn stats_dist_binomial_point_negate(pt : StatsdistbinomialPoint) -> StatsdistbinomialPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn stats_dist_binomial_point_mid(a : StatsdistbinomialPoint, b : StatsdistbinomialPoint) -> StatsdistbinomialPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn stats_dist_binomial_point_lerp(a : StatsdistbinomialPoint, b : StatsdistbinomialPoint, t : Double) -> StatsdistbinomialPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn stats_dist_binomial_point_to_string(pt : StatsdistbinomialPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct StatsdistbinomialSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn stats_dist_binomial_make_series(vals : Array[Double], name : String) -> StatsdistbinomialSeries {
  { vals, name, meta: 0 }
}

pub fn stats_dist_binomial_series_len(s : StatsdistbinomialSeries) -> Int { s.vals.length() }

pub fn stats_dist_binomial_series_sum(s : StatsdistbinomialSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn stats_dist_binomial_series_mean(s : StatsdistbinomialSeries) -> Double {
  let n = stats_dist_binomial_series_len(s)
  if n == 0 { 0.0 } else { stats_dist_binomial_series_sum(s) / n.to_double() }
}

pub fn stats_dist_binomial_series_min(s : StatsdistbinomialSeries) -> Double {
  let n = stats_dist_binomial_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn stats_dist_binomial_series_max(s : StatsdistbinomialSeries) -> Double {
  let n = stats_dist_binomial_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn stats_dist_binomial_series_range(s : StatsdistbinomialSeries) -> Double {
  stats_dist_binomial_series_max(s) - stats_dist_binomial_series_min(s)
}

pub fn stats_dist_binomial_series_var(s : StatsdistbinomialSeries) -> Double {
  let n = stats_dist_binomial_series_len(s)
  if n == 0 { 0.0 } else {
    let m = stats_dist_binomial_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn stats_dist_binomial_series_std(s : StatsdistbinomialSeries) -> Double { @_common.sqrt(stats_dist_binomial_series_var(s)) }

pub fn stats_dist_binomial_series_median(s : StatsdistbinomialSeries) -> Double {
  let n = stats_dist_binomial_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = stats_dist_binomial_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn stats_dist_binomial_series_scale(s : StatsdistbinomialSeries, f : Double) -> StatsdistbinomialSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn stats_dist_binomial_series_add(a : StatsdistbinomialSeries, b : StatsdistbinomialSeries) -> StatsdistbinomialSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn stats_dist_binomial_series_sub(a : StatsdistbinomialSeries, b : StatsdistbinomialSeries) -> StatsdistbinomialSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn stats_dist_binomial_series_normalize(s : StatsdistbinomialSeries) -> StatsdistbinomialSeries {
  let mn = stats_dist_binomial_series_min(s)
  let mx = stats_dist_binomial_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn stats_dist_binomial_series_cumsum(s : StatsdistbinomialSeries) -> StatsdistbinomialSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn stats_dist_binomial_series_to_string(s : StatsdistbinomialSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct StatsdistbinomialMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn stats_dist_binomial_make_matrix(rows : Int, cols : Int, val : Double) -> StatsdistbinomialMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn stats_dist_binomial_matrix_identity(n : Int) -> StatsdistbinomialMatrix {
  let m = stats_dist_binomial_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn stats_dist_binomial_matrix_get(m : StatsdistbinomialMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn stats_dist_binomial_matrix_transpose(m : StatsdistbinomialMatrix) -> StatsdistbinomialMatrix {
  let result = stats_dist_binomial_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn stats_dist_binomial_matrix_add(a : StatsdistbinomialMatrix, b : StatsdistbinomialMatrix) -> StatsdistbinomialMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = stats_dist_binomial_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn stats_dist_binomial_matrix_scale(m : StatsdistbinomialMatrix, s : Double) -> StatsdistbinomialMatrix {
  let result = stats_dist_binomial_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn stats_dist_binomial_matrix_multiply(a : StatsdistbinomialMatrix, b : StatsdistbinomialMatrix) -> StatsdistbinomialMatrix {
  if a.cols != b.rows { return stats_dist_binomial_make_matrix(a.rows, b.cols, 0.0) }
  let result = stats_dist_binomial_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn stats_dist_binomial_matrix_trace(m : StatsdistbinomialMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn stats_dist_binomial_matrix_det(m : StatsdistbinomialMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn stats_dist_binomial_matrix_norm(m : StatsdistbinomialMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn stats_dist_binomial_matrix_to_string(m : StatsdistbinomialMatrix) -> String {
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

pub(all) struct StatsdistbinomialVector {
  comps : Array[Double]
  dim : Int
}

pub fn stats_dist_binomial_make_vector(comps : Array[Double]) -> StatsdistbinomialVector {
  { comps, dim: comps.length() }
}

pub fn stats_dist_binomial_vector_zero(dim : Int) -> StatsdistbinomialVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn stats_dist_binomial_vector_add(a : StatsdistbinomialVector, b : StatsdistbinomialVector) -> StatsdistbinomialVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn stats_dist_binomial_vector_sub(a : StatsdistbinomialVector, b : StatsdistbinomialVector) -> StatsdistbinomialVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn stats_dist_binomial_vector_scale(v : StatsdistbinomialVector, s : Double) -> StatsdistbinomialVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn stats_dist_binomial_vector_dot(a : StatsdistbinomialVector, b : StatsdistbinomialVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn stats_dist_binomial_vector_norm(v : StatsdistbinomialVector) -> Double { @_common.sqrt(stats_dist_binomial_vector_dot(v, v)) }

pub fn stats_dist_binomial_vector_normalize(v : StatsdistbinomialVector) -> StatsdistbinomialVector {
  let n = stats_dist_binomial_vector_norm(v)
  if n < 0.0000001 { v } else { stats_dist_binomial_vector_scale(v, 1.0 / n) }
}

pub fn stats_dist_binomial_vector_dist(a : StatsdistbinomialVector, b : StatsdistbinomialVector) -> Double {
  stats_dist_binomial_vector_norm(stats_dist_binomial_vector_sub(a, b))
}

pub fn stats_dist_binomial_vector_to_string(v : StatsdistbinomialVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn stats_dist_binomial_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn stats_dist_binomial_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = stats_dist_binomial_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn stats_dist_binomial_std(data : Array[Double]) -> Double { @_common.sqrt(stats_dist_binomial_var(data)) }

pub fn stats_dist_binomial_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = stats_dist_binomial_mean(a); let mb = stats_dist_binomial_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn stats_dist_binomial_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = stats_dist_binomial_std(a); let sb = stats_dist_binomial_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { stats_dist_binomial_cov(a, b) / (sa * sb) }
}

pub fn stats_dist_binomial_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = stats_dist_binomial_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn stats_dist_binomial_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn stats_dist_binomial_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn stats_dist_binomial_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  @_common.sqrt(stats_dist_binomial_mse(pred, labels))
}

pub fn stats_dist_binomial_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn stats_dist_binomial_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = stats_dist_binomial_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn stats_dist_binomial_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn stats_dist_binomial_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn stats_dist_binomial_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = stats_dist_binomial_precision(pred, labels, pos); let r = stats_dist_binomial_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn stats_dist_binomial_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn stats_dist_binomial_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = stats_dist_binomial_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn stats_dist_binomial_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn stats_dist_binomial_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn stats_dist_binomial_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = stats_dist_binomial_gcd(a, b)
    (a / g) * b
  }
}

pub fn stats_dist_binomial_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn stats_dist_binomial_fibonacci(n : Int) -> Int {
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

pub fn stats_dist_binomial_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = stats_dist_binomial_min(data); let mx = stats_dist_binomial_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn stats_dist_binomial_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = stats_dist_binomial_mean(data); let sd = stats_dist_binomial_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn stats_dist_binomial_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn stats_dist_binomial_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn stats_dist_binomial_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn stats_dist_binomial_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn stats_dist_binomial_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn stats_dist_binomial_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

pub(all) struct StatsdistbinomialFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_binomial_frame_make(size : Int) -> StatsdistbinomialFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_binomial_frame_len(s : StatsdistbinomialFrame) -> Int { s.size }

pub fn stats_dist_binomial_frame_get(s : StatsdistbinomialFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_binomial_frame_set(s : StatsdistbinomialFrame, i : Int, v : Double) -> StatsdistbinomialFrame {
  let result = stats_dist_binomial_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_binomial_frame_sum(s : StatsdistbinomialFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_binomial_frame_mean(s : StatsdistbinomialFrame) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_binomial_frame_sum(s) / s.size.to_double() }
}

pub fn stats_dist_binomial_frame_scale(s : StatsdistbinomialFrame, f : Double) -> StatsdistbinomialFrame {
  let result = stats_dist_binomial_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_binomial_frame_add(a : StatsdistbinomialFrame, b : StatsdistbinomialFrame) -> StatsdistbinomialFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_binomial_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_binomial_frame_copy(s : StatsdistbinomialFrame) -> StatsdistbinomialFrame {
  let result = stats_dist_binomial_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_binomial_frame_fill(s : StatsdistbinomialFrame, v : Double) -> StatsdistbinomialFrame {
  let result = stats_dist_binomial_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_binomial_frame_min(s : StatsdistbinomialFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_binomial_frame_max(s : StatsdistbinomialFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_binomial_frame_to_string(s : StatsdistbinomialFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistbinomialTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_binomial_table_make(size : Int) -> StatsdistbinomialTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_binomial_table_len(s : StatsdistbinomialTable) -> Int { s.size }

pub fn stats_dist_binomial_table_get(s : StatsdistbinomialTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_binomial_table_set(s : StatsdistbinomialTable, i : Int, v : Double) -> StatsdistbinomialTable {
  let result = stats_dist_binomial_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_binomial_table_sum(s : StatsdistbinomialTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_binomial_table_mean(s : StatsdistbinomialTable) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_binomial_table_sum(s) / s.size.to_double() }
}

pub fn stats_dist_binomial_table_scale(s : StatsdistbinomialTable, f : Double) -> StatsdistbinomialTable {
  let result = stats_dist_binomial_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_binomial_table_add(a : StatsdistbinomialTable, b : StatsdistbinomialTable) -> StatsdistbinomialTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_binomial_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_binomial_table_copy(s : StatsdistbinomialTable) -> StatsdistbinomialTable {
  let result = stats_dist_binomial_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_binomial_table_fill(s : StatsdistbinomialTable, v : Double) -> StatsdistbinomialTable {
  let result = stats_dist_binomial_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_binomial_table_min(s : StatsdistbinomialTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_binomial_table_max(s : StatsdistbinomialTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_binomial_table_to_string(s : StatsdistbinomialTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistbinomialGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_binomial_graphn_make(size : Int) -> StatsdistbinomialGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_binomial_graphn_len(s : StatsdistbinomialGraphN) -> Int { s.size }

pub fn stats_dist_binomial_graphn_get(s : StatsdistbinomialGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_binomial_graphn_set(s : StatsdistbinomialGraphN, i : Int, v : Double) -> StatsdistbinomialGraphN {
  let result = stats_dist_binomial_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_binomial_graphn_sum(s : StatsdistbinomialGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_binomial_graphn_mean(s : StatsdistbinomialGraphN) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_binomial_graphn_sum(s) / s.size.to_double() }
}

pub fn stats_dist_binomial_graphn_scale(s : StatsdistbinomialGraphN, f : Double) -> StatsdistbinomialGraphN {
  let result = stats_dist_binomial_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_binomial_graphn_add(a : StatsdistbinomialGraphN, b : StatsdistbinomialGraphN) -> StatsdistbinomialGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_binomial_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_binomial_graphn_copy(s : StatsdistbinomialGraphN) -> StatsdistbinomialGraphN {
  let result = stats_dist_binomial_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_binomial_graphn_fill(s : StatsdistbinomialGraphN, v : Double) -> StatsdistbinomialGraphN {
  let result = stats_dist_binomial_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_binomial_graphn_min(s : StatsdistbinomialGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_binomial_graphn_max(s : StatsdistbinomialGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_binomial_graphn_to_string(s : StatsdistbinomialGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistbinomialNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_binomial_node_make(size : Int) -> StatsdistbinomialNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_binomial_node_len(s : StatsdistbinomialNode) -> Int { s.size }

pub fn stats_dist_binomial_node_get(s : StatsdistbinomialNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_binomial_node_set(s : StatsdistbinomialNode, i : Int, v : Double) -> StatsdistbinomialNode {
  let result = stats_dist_binomial_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_binomial_node_sum(s : StatsdistbinomialNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_binomial_node_mean(s : StatsdistbinomialNode) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_binomial_node_sum(s) / s.size.to_double() }
}

pub fn stats_dist_binomial_node_scale(s : StatsdistbinomialNode, f : Double) -> StatsdistbinomialNode {
  let result = stats_dist_binomial_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_binomial_node_add(a : StatsdistbinomialNode, b : StatsdistbinomialNode) -> StatsdistbinomialNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_binomial_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_binomial_node_copy(s : StatsdistbinomialNode) -> StatsdistbinomialNode {
  let result = stats_dist_binomial_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_binomial_node_fill(s : StatsdistbinomialNode, v : Double) -> StatsdistbinomialNode {
  let result = stats_dist_binomial_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_binomial_node_min(s : StatsdistbinomialNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_binomial_node_max(s : StatsdistbinomialNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_binomial_node_to_string(s : StatsdistbinomialNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistbinomialEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_binomial_edge_make(size : Int) -> StatsdistbinomialEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_binomial_edge_len(s : StatsdistbinomialEdge) -> Int { s.size }

pub fn stats_dist_binomial_edge_get(s : StatsdistbinomialEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_binomial_edge_set(s : StatsdistbinomialEdge, i : Int, v : Double) -> StatsdistbinomialEdge {
  let result = stats_dist_binomial_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_binomial_edge_sum(s : StatsdistbinomialEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_binomial_edge_mean(s : StatsdistbinomialEdge) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_binomial_edge_sum(s) / s.size.to_double() }
}

pub fn stats_dist_binomial_edge_scale(s : StatsdistbinomialEdge, f : Double) -> StatsdistbinomialEdge {
  let result = stats_dist_binomial_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_binomial_edge_add(a : StatsdistbinomialEdge, b : StatsdistbinomialEdge) -> StatsdistbinomialEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_binomial_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_binomial_edge_copy(s : StatsdistbinomialEdge) -> StatsdistbinomialEdge {
  let result = stats_dist_binomial_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_binomial_edge_fill(s : StatsdistbinomialEdge, v : Double) -> StatsdistbinomialEdge {
  let result = stats_dist_binomial_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_binomial_edge_min(s : StatsdistbinomialEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_binomial_edge_max(s : StatsdistbinomialEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_binomial_edge_to_string(s : StatsdistbinomialEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistbinomialPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_binomial_path_make(size : Int) -> StatsdistbinomialPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_binomial_path_len(s : StatsdistbinomialPath) -> Int { s.size }

pub fn stats_dist_binomial_path_get(s : StatsdistbinomialPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_binomial_path_set(s : StatsdistbinomialPath, i : Int, v : Double) -> StatsdistbinomialPath {
  let result = stats_dist_binomial_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_binomial_path_sum(s : StatsdistbinomialPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_binomial_path_mean(s : StatsdistbinomialPath) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_binomial_path_sum(s) / s.size.to_double() }
}

pub fn stats_dist_binomial_path_scale(s : StatsdistbinomialPath, f : Double) -> StatsdistbinomialPath {
  let result = stats_dist_binomial_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_binomial_path_add(a : StatsdistbinomialPath, b : StatsdistbinomialPath) -> StatsdistbinomialPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_binomial_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_binomial_path_copy(s : StatsdistbinomialPath) -> StatsdistbinomialPath {
  let result = stats_dist_binomial_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_binomial_path_fill(s : StatsdistbinomialPath, v : Double) -> StatsdistbinomialPath {
  let result = stats_dist_binomial_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_binomial_path_min(s : StatsdistbinomialPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_binomial_path_max(s : StatsdistbinomialPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_binomial_path_to_string(s : StatsdistbinomialPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistbinomialCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_binomial_cluster_make(size : Int) -> StatsdistbinomialCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_binomial_cluster_len(s : StatsdistbinomialCluster) -> Int { s.size }

pub fn stats_dist_binomial_cluster_get(s : StatsdistbinomialCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_binomial_cluster_set(s : StatsdistbinomialCluster, i : Int, v : Double) -> StatsdistbinomialCluster {
  let result = stats_dist_binomial_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_binomial_cluster_sum(s : StatsdistbinomialCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_binomial_cluster_mean(s : StatsdistbinomialCluster) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_binomial_cluster_sum(s) / s.size.to_double() }
}

pub fn stats_dist_binomial_cluster_scale(s : StatsdistbinomialCluster, f : Double) -> StatsdistbinomialCluster {
  let result = stats_dist_binomial_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_binomial_cluster_add(a : StatsdistbinomialCluster, b : StatsdistbinomialCluster) -> StatsdistbinomialCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_binomial_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_binomial_cluster_copy(s : StatsdistbinomialCluster) -> StatsdistbinomialCluster {
  let result = stats_dist_binomial_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_binomial_cluster_fill(s : StatsdistbinomialCluster, v : Double) -> StatsdistbinomialCluster {
  let result = stats_dist_binomial_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_binomial_cluster_min(s : StatsdistbinomialCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_binomial_cluster_max(s : StatsdistbinomialCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_binomial_cluster_to_string(s : StatsdistbinomialCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistbinomialModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_binomial_model_make(size : Int) -> StatsdistbinomialModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_binomial_model_len(s : StatsdistbinomialModel) -> Int { s.size }

pub fn stats_dist_binomial_model_get(s : StatsdistbinomialModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_binomial_model_set(s : StatsdistbinomialModel, i : Int, v : Double) -> StatsdistbinomialModel {
  let result = stats_dist_binomial_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_binomial_model_sum(s : StatsdistbinomialModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_binomial_model_mean(s : StatsdistbinomialModel) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_binomial_model_sum(s) / s.size.to_double() }
}

pub fn stats_dist_binomial_model_scale(s : StatsdistbinomialModel, f : Double) -> StatsdistbinomialModel {
  let result = stats_dist_binomial_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_binomial_model_add(a : StatsdistbinomialModel, b : StatsdistbinomialModel) -> StatsdistbinomialModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_binomial_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_binomial_model_copy(s : StatsdistbinomialModel) -> StatsdistbinomialModel {
  let result = stats_dist_binomial_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_binomial_model_fill(s : StatsdistbinomialModel, v : Double) -> StatsdistbinomialModel {
  let result = stats_dist_binomial_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_binomial_model_min(s : StatsdistbinomialModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_binomial_model_max(s : StatsdistbinomialModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_binomial_model_to_string(s : StatsdistbinomialModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistbinomialLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_binomial_layer_make(size : Int) -> StatsdistbinomialLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_binomial_layer_len(s : StatsdistbinomialLayer) -> Int { s.size }

pub fn stats_dist_binomial_layer_get(s : StatsdistbinomialLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_binomial_layer_set(s : StatsdistbinomialLayer, i : Int, v : Double) -> StatsdistbinomialLayer {
  let result = stats_dist_binomial_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_binomial_layer_sum(s : StatsdistbinomialLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_binomial_layer_mean(s : StatsdistbinomialLayer) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_binomial_layer_sum(s) / s.size.to_double() }
}

pub fn stats_dist_binomial_layer_scale(s : StatsdistbinomialLayer, f : Double) -> StatsdistbinomialLayer {
  let result = stats_dist_binomial_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_binomial_layer_add(a : StatsdistbinomialLayer, b : StatsdistbinomialLayer) -> StatsdistbinomialLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_binomial_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_binomial_layer_copy(s : StatsdistbinomialLayer) -> StatsdistbinomialLayer {
  let result = stats_dist_binomial_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_binomial_layer_fill(s : StatsdistbinomialLayer, v : Double) -> StatsdistbinomialLayer {
  let result = stats_dist_binomial_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_binomial_layer_min(s : StatsdistbinomialLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_binomial_layer_max(s : StatsdistbinomialLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_binomial_layer_to_string(s : StatsdistbinomialLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistbinomialBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_binomial_buffer_make(size : Int) -> StatsdistbinomialBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_binomial_buffer_len(s : StatsdistbinomialBuffer) -> Int { s.size }

pub fn stats_dist_binomial_buffer_get(s : StatsdistbinomialBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_binomial_buffer_set(s : StatsdistbinomialBuffer, i : Int, v : Double) -> StatsdistbinomialBuffer {
  let result = stats_dist_binomial_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_binomial_buffer_sum(s : StatsdistbinomialBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_binomial_buffer_mean(s : StatsdistbinomialBuffer) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_binomial_buffer_sum(s) / s.size.to_double() }
}

pub fn stats_dist_binomial_buffer_scale(s : StatsdistbinomialBuffer, f : Double) -> StatsdistbinomialBuffer {
  let result = stats_dist_binomial_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_binomial_buffer_add(a : StatsdistbinomialBuffer, b : StatsdistbinomialBuffer) -> StatsdistbinomialBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_binomial_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_binomial_buffer_copy(s : StatsdistbinomialBuffer) -> StatsdistbinomialBuffer {
  let result = stats_dist_binomial_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_binomial_buffer_fill(s : StatsdistbinomialBuffer, v : Double) -> StatsdistbinomialBuffer {
  let result = stats_dist_binomial_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_binomial_buffer_min(s : StatsdistbinomialBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_binomial_buffer_max(s : StatsdistbinomialBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_binomial_buffer_to_string(s : StatsdistbinomialBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistbinomialCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_binomial_cursor_make(size : Int) -> StatsdistbinomialCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_binomial_cursor_len(s : StatsdistbinomialCursor) -> Int { s.size }

pub fn stats_dist_binomial_cursor_get(s : StatsdistbinomialCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_binomial_cursor_set(s : StatsdistbinomialCursor, i : Int, v : Double) -> StatsdistbinomialCursor {
  let result = stats_dist_binomial_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_binomial_cursor_sum(s : StatsdistbinomialCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_binomial_cursor_mean(s : StatsdistbinomialCursor) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_binomial_cursor_sum(s) / s.size.to_double() }
}

pub fn stats_dist_binomial_cursor_scale(s : StatsdistbinomialCursor, f : Double) -> StatsdistbinomialCursor {
  let result = stats_dist_binomial_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_binomial_cursor_add(a : StatsdistbinomialCursor, b : StatsdistbinomialCursor) -> StatsdistbinomialCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_binomial_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_binomial_cursor_copy(s : StatsdistbinomialCursor) -> StatsdistbinomialCursor {
  let result = stats_dist_binomial_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_binomial_cursor_fill(s : StatsdistbinomialCursor, v : Double) -> StatsdistbinomialCursor {
  let result = stats_dist_binomial_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_binomial_cursor_min(s : StatsdistbinomialCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_binomial_cursor_max(s : StatsdistbinomialCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_binomial_cursor_to_string(s : StatsdistbinomialCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistbinomialView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_binomial_view_make(size : Int) -> StatsdistbinomialView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_binomial_view_len(s : StatsdistbinomialView) -> Int { s.size }

pub fn stats_dist_binomial_view_get(s : StatsdistbinomialView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_binomial_view_set(s : StatsdistbinomialView, i : Int, v : Double) -> StatsdistbinomialView {
  let result = stats_dist_binomial_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_binomial_view_sum(s : StatsdistbinomialView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_binomial_view_mean(s : StatsdistbinomialView) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_binomial_view_sum(s) / s.size.to_double() }
}

pub fn stats_dist_binomial_view_scale(s : StatsdistbinomialView, f : Double) -> StatsdistbinomialView {
  let result = stats_dist_binomial_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_binomial_view_add(a : StatsdistbinomialView, b : StatsdistbinomialView) -> StatsdistbinomialView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_binomial_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_binomial_view_copy(s : StatsdistbinomialView) -> StatsdistbinomialView {
  let result = stats_dist_binomial_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_binomial_view_fill(s : StatsdistbinomialView, v : Double) -> StatsdistbinomialView {
  let result = stats_dist_binomial_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_binomial_view_min(s : StatsdistbinomialView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_binomial_view_max(s : StatsdistbinomialView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_binomial_view_to_string(s : StatsdistbinomialView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistbinomialRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_binomial_range_make(size : Int) -> StatsdistbinomialRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_binomial_range_len(s : StatsdistbinomialRange) -> Int { s.size }

pub fn stats_dist_binomial_range_get(s : StatsdistbinomialRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_binomial_range_set(s : StatsdistbinomialRange, i : Int, v : Double) -> StatsdistbinomialRange {
  let result = stats_dist_binomial_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_binomial_range_sum(s : StatsdistbinomialRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_binomial_range_mean(s : StatsdistbinomialRange) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_binomial_range_sum(s) / s.size.to_double() }
}

pub fn stats_dist_binomial_range_scale(s : StatsdistbinomialRange, f : Double) -> StatsdistbinomialRange {
  let result = stats_dist_binomial_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_binomial_range_add(a : StatsdistbinomialRange, b : StatsdistbinomialRange) -> StatsdistbinomialRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_binomial_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_binomial_range_copy(s : StatsdistbinomialRange) -> StatsdistbinomialRange {
  let result = stats_dist_binomial_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_binomial_range_fill(s : StatsdistbinomialRange, v : Double) -> StatsdistbinomialRange {
  let result = stats_dist_binomial_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_binomial_range_min(s : StatsdistbinomialRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_binomial_range_max(s : StatsdistbinomialRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_binomial_range_to_string(s : StatsdistbinomialRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistbinomialSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_binomial_slice_make(size : Int) -> StatsdistbinomialSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_binomial_slice_len(s : StatsdistbinomialSlice) -> Int { s.size }

pub fn stats_dist_binomial_slice_get(s : StatsdistbinomialSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_binomial_slice_set(s : StatsdistbinomialSlice, i : Int, v : Double) -> StatsdistbinomialSlice {
  let result = stats_dist_binomial_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_binomial_slice_sum(s : StatsdistbinomialSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_binomial_slice_mean(s : StatsdistbinomialSlice) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_binomial_slice_sum(s) / s.size.to_double() }
}

pub fn stats_dist_binomial_slice_scale(s : StatsdistbinomialSlice, f : Double) -> StatsdistbinomialSlice {
  let result = stats_dist_binomial_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_binomial_slice_add(a : StatsdistbinomialSlice, b : StatsdistbinomialSlice) -> StatsdistbinomialSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_binomial_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_binomial_slice_copy(s : StatsdistbinomialSlice) -> StatsdistbinomialSlice {
  let result = stats_dist_binomial_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_binomial_slice_fill(s : StatsdistbinomialSlice, v : Double) -> StatsdistbinomialSlice {
  let result = stats_dist_binomial_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_binomial_slice_min(s : StatsdistbinomialSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_binomial_slice_max(s : StatsdistbinomialSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_binomial_slice_to_string(s : StatsdistbinomialSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

