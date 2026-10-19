///===
/// extcore/stats_test_chi_sq

pub(all) struct StatstestchisqPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn stats_test_chi_sq_make_point(x : Double, y : Double) -> StatstestchisqPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn stats_test_chi_sq_make_point3(x : Double, y : Double, z : Double) -> StatstestchisqPoint {
  { x, y, z, label: 0 }
}

pub fn stats_test_chi_sq_point_x(pt : StatstestchisqPoint) -> Double { pt.x }

pub fn stats_test_chi_sq_point_y(pt : StatstestchisqPoint) -> Double { pt.y }

pub fn stats_test_chi_sq_point_z(pt : StatstestchisqPoint) -> Double { pt.z }

pub fn stats_test_chi_sq_point_label(pt : StatstestchisqPoint) -> Int { pt.label }

pub fn stats_test_chi_sq_point_dist(a : StatstestchisqPoint, b : StatstestchisqPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn stats_test_chi_sq_point_add(a : StatstestchisqPoint, b : StatstestchisqPoint) -> StatstestchisqPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn stats_test_chi_sq_point_sub(a : StatstestchisqPoint, b : StatstestchisqPoint) -> StatstestchisqPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn stats_test_chi_sq_point_scale(pt : StatstestchisqPoint, s : Double) -> StatstestchisqPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn stats_test_chi_sq_point_dot(a : StatstestchisqPoint, b : StatstestchisqPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn stats_test_chi_sq_point_cross(a : StatstestchisqPoint, b : StatstestchisqPoint) -> StatstestchisqPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn stats_test_chi_sq_point_norm(pt : StatstestchisqPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn stats_test_chi_sq_point_normalize(pt : StatstestchisqPoint) -> StatstestchisqPoint {
  let n = stats_test_chi_sq_point_norm(pt)
  if n < 0.0000001 { pt } else { stats_test_chi_sq_point_scale(pt, 1.0 / n) }
}

pub fn stats_test_chi_sq_point_negate(pt : StatstestchisqPoint) -> StatstestchisqPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn stats_test_chi_sq_point_mid(a : StatstestchisqPoint, b : StatstestchisqPoint) -> StatstestchisqPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn stats_test_chi_sq_point_lerp(a : StatstestchisqPoint, b : StatstestchisqPoint, t : Double) -> StatstestchisqPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn stats_test_chi_sq_point_to_string(pt : StatstestchisqPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct StatstestchisqSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn stats_test_chi_sq_make_series(vals : Array[Double], name : String) -> StatstestchisqSeries {
  { vals, name, meta: 0 }
}

pub fn stats_test_chi_sq_series_len(s : StatstestchisqSeries) -> Int { s.vals.length() }

pub fn stats_test_chi_sq_series_sum(s : StatstestchisqSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn stats_test_chi_sq_series_mean(s : StatstestchisqSeries) -> Double {
  let n = stats_test_chi_sq_series_len(s)
  if n == 0 { 0.0 } else { stats_test_chi_sq_series_sum(s) / n.to_double() }
}

pub fn stats_test_chi_sq_series_min(s : StatstestchisqSeries) -> Double {
  let n = stats_test_chi_sq_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn stats_test_chi_sq_series_max(s : StatstestchisqSeries) -> Double {
  let n = stats_test_chi_sq_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn stats_test_chi_sq_series_range(s : StatstestchisqSeries) -> Double {
  stats_test_chi_sq_series_max(s) - stats_test_chi_sq_series_min(s)
}

pub fn stats_test_chi_sq_series_var(s : StatstestchisqSeries) -> Double {
  let n = stats_test_chi_sq_series_len(s)
  if n == 0 { 0.0 } else {
    let m = stats_test_chi_sq_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn stats_test_chi_sq_series_std(s : StatstestchisqSeries) -> Double { @_common.sqrt(stats_test_chi_sq_series_var(s)) }

pub fn stats_test_chi_sq_series_median(s : StatstestchisqSeries) -> Double {
  let n = stats_test_chi_sq_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = stats_test_chi_sq_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn stats_test_chi_sq_series_scale(s : StatstestchisqSeries, f : Double) -> StatstestchisqSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn stats_test_chi_sq_series_add(a : StatstestchisqSeries, b : StatstestchisqSeries) -> StatstestchisqSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn stats_test_chi_sq_series_sub(a : StatstestchisqSeries, b : StatstestchisqSeries) -> StatstestchisqSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn stats_test_chi_sq_series_normalize(s : StatstestchisqSeries) -> StatstestchisqSeries {
  let mn = stats_test_chi_sq_series_min(s)
  let mx = stats_test_chi_sq_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn stats_test_chi_sq_series_cumsum(s : StatstestchisqSeries) -> StatstestchisqSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn stats_test_chi_sq_series_to_string(s : StatstestchisqSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct StatstestchisqMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn stats_test_chi_sq_make_matrix(rows : Int, cols : Int, val : Double) -> StatstestchisqMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn stats_test_chi_sq_matrix_identity(n : Int) -> StatstestchisqMatrix {
  let m = stats_test_chi_sq_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn stats_test_chi_sq_matrix_get(m : StatstestchisqMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn stats_test_chi_sq_matrix_transpose(m : StatstestchisqMatrix) -> StatstestchisqMatrix {
  let result = stats_test_chi_sq_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn stats_test_chi_sq_matrix_add(a : StatstestchisqMatrix, b : StatstestchisqMatrix) -> StatstestchisqMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = stats_test_chi_sq_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn stats_test_chi_sq_matrix_scale(m : StatstestchisqMatrix, s : Double) -> StatstestchisqMatrix {
  let result = stats_test_chi_sq_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn stats_test_chi_sq_matrix_multiply(a : StatstestchisqMatrix, b : StatstestchisqMatrix) -> StatstestchisqMatrix {
  if a.cols != b.rows { return stats_test_chi_sq_make_matrix(a.rows, b.cols, 0.0) }
  let result = stats_test_chi_sq_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn stats_test_chi_sq_matrix_trace(m : StatstestchisqMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn stats_test_chi_sq_matrix_det(m : StatstestchisqMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn stats_test_chi_sq_matrix_norm(m : StatstestchisqMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn stats_test_chi_sq_matrix_to_string(m : StatstestchisqMatrix) -> String {
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

pub(all) struct StatstestchisqVector {
  comps : Array[Double]
  dim : Int
}

pub fn stats_test_chi_sq_make_vector(comps : Array[Double]) -> StatstestchisqVector {
  { comps, dim: comps.length() }
}

pub fn stats_test_chi_sq_vector_zero(dim : Int) -> StatstestchisqVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn stats_test_chi_sq_vector_add(a : StatstestchisqVector, b : StatstestchisqVector) -> StatstestchisqVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn stats_test_chi_sq_vector_sub(a : StatstestchisqVector, b : StatstestchisqVector) -> StatstestchisqVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn stats_test_chi_sq_vector_scale(v : StatstestchisqVector, s : Double) -> StatstestchisqVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn stats_test_chi_sq_vector_dot(a : StatstestchisqVector, b : StatstestchisqVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn stats_test_chi_sq_vector_norm(v : StatstestchisqVector) -> Double { @_common.sqrt(stats_test_chi_sq_vector_dot(v, v)) }

pub fn stats_test_chi_sq_vector_normalize(v : StatstestchisqVector) -> StatstestchisqVector {
  let n = stats_test_chi_sq_vector_norm(v)
  if n < 0.0000001 { v } else { stats_test_chi_sq_vector_scale(v, 1.0 / n) }
}

pub fn stats_test_chi_sq_vector_dist(a : StatstestchisqVector, b : StatstestchisqVector) -> Double {
  stats_test_chi_sq_vector_norm(stats_test_chi_sq_vector_sub(a, b))
}

pub fn stats_test_chi_sq_vector_to_string(v : StatstestchisqVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn stats_test_chi_sq_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn stats_test_chi_sq_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = stats_test_chi_sq_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn stats_test_chi_sq_std(data : Array[Double]) -> Double { @_common.sqrt(stats_test_chi_sq_var(data)) }

pub fn stats_test_chi_sq_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = stats_test_chi_sq_mean(a); let mb = stats_test_chi_sq_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn stats_test_chi_sq_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = stats_test_chi_sq_std(a); let sb = stats_test_chi_sq_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { stats_test_chi_sq_cov(a, b) / (sa * sb) }
}

pub fn stats_test_chi_sq_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = stats_test_chi_sq_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn stats_test_chi_sq_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn stats_test_chi_sq_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn stats_test_chi_sq_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  @_common.sqrt(stats_test_chi_sq_mse(pred, labels))
}

pub fn stats_test_chi_sq_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn stats_test_chi_sq_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = stats_test_chi_sq_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn stats_test_chi_sq_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn stats_test_chi_sq_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn stats_test_chi_sq_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = stats_test_chi_sq_precision(pred, labels, pos); let r = stats_test_chi_sq_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn stats_test_chi_sq_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn stats_test_chi_sq_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = stats_test_chi_sq_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn stats_test_chi_sq_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn stats_test_chi_sq_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn stats_test_chi_sq_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = stats_test_chi_sq_gcd(a, b)
    (a / g) * b
  }
}

pub fn stats_test_chi_sq_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn stats_test_chi_sq_fibonacci(n : Int) -> Int {
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

pub fn stats_test_chi_sq_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = stats_test_chi_sq_min(data); let mx = stats_test_chi_sq_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn stats_test_chi_sq_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = stats_test_chi_sq_mean(data); let sd = stats_test_chi_sq_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn stats_test_chi_sq_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn stats_test_chi_sq_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn stats_test_chi_sq_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn stats_test_chi_sq_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn stats_test_chi_sq_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn stats_test_chi_sq_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

pub(all) struct StatstestchisqFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_chi_sq_frame_make(size : Int) -> StatstestchisqFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_chi_sq_frame_len(s : StatstestchisqFrame) -> Int { s.size }

pub fn stats_test_chi_sq_frame_get(s : StatstestchisqFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_chi_sq_frame_set(s : StatstestchisqFrame, i : Int, v : Double) -> StatstestchisqFrame {
  let result = stats_test_chi_sq_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_test_chi_sq_frame_sum(s : StatstestchisqFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_test_chi_sq_frame_mean(s : StatstestchisqFrame) -> Double {
  if s.size == 0 { 0.0 } else { stats_test_chi_sq_frame_sum(s) / s.size.to_double() }
}

pub fn stats_test_chi_sq_frame_scale(s : StatstestchisqFrame, f : Double) -> StatstestchisqFrame {
  let result = stats_test_chi_sq_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_test_chi_sq_frame_add(a : StatstestchisqFrame, b : StatstestchisqFrame) -> StatstestchisqFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_test_chi_sq_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_test_chi_sq_frame_copy(s : StatstestchisqFrame) -> StatstestchisqFrame {
  let result = stats_test_chi_sq_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_test_chi_sq_frame_fill(s : StatstestchisqFrame, v : Double) -> StatstestchisqFrame {
  let result = stats_test_chi_sq_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_test_chi_sq_frame_min(s : StatstestchisqFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_chi_sq_frame_max(s : StatstestchisqFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_chi_sq_frame_to_string(s : StatstestchisqFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestchisqTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_chi_sq_table_make(size : Int) -> StatstestchisqTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_chi_sq_table_len(s : StatstestchisqTable) -> Int { s.size }

pub fn stats_test_chi_sq_table_get(s : StatstestchisqTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_chi_sq_table_set(s : StatstestchisqTable, i : Int, v : Double) -> StatstestchisqTable {
  let result = stats_test_chi_sq_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_test_chi_sq_table_sum(s : StatstestchisqTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_test_chi_sq_table_mean(s : StatstestchisqTable) -> Double {
  if s.size == 0 { 0.0 } else { stats_test_chi_sq_table_sum(s) / s.size.to_double() }
}

pub fn stats_test_chi_sq_table_scale(s : StatstestchisqTable, f : Double) -> StatstestchisqTable {
  let result = stats_test_chi_sq_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_test_chi_sq_table_add(a : StatstestchisqTable, b : StatstestchisqTable) -> StatstestchisqTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_test_chi_sq_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_test_chi_sq_table_copy(s : StatstestchisqTable) -> StatstestchisqTable {
  let result = stats_test_chi_sq_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_test_chi_sq_table_fill(s : StatstestchisqTable, v : Double) -> StatstestchisqTable {
  let result = stats_test_chi_sq_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_test_chi_sq_table_min(s : StatstestchisqTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_chi_sq_table_max(s : StatstestchisqTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_chi_sq_table_to_string(s : StatstestchisqTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestchisqGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_chi_sq_graphn_make(size : Int) -> StatstestchisqGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_chi_sq_graphn_len(s : StatstestchisqGraphN) -> Int { s.size }

pub fn stats_test_chi_sq_graphn_get(s : StatstestchisqGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_chi_sq_graphn_set(s : StatstestchisqGraphN, i : Int, v : Double) -> StatstestchisqGraphN {
  let result = stats_test_chi_sq_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_test_chi_sq_graphn_sum(s : StatstestchisqGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_test_chi_sq_graphn_mean(s : StatstestchisqGraphN) -> Double {
  if s.size == 0 { 0.0 } else { stats_test_chi_sq_graphn_sum(s) / s.size.to_double() }
}

pub fn stats_test_chi_sq_graphn_scale(s : StatstestchisqGraphN, f : Double) -> StatstestchisqGraphN {
  let result = stats_test_chi_sq_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_test_chi_sq_graphn_add(a : StatstestchisqGraphN, b : StatstestchisqGraphN) -> StatstestchisqGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_test_chi_sq_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_test_chi_sq_graphn_copy(s : StatstestchisqGraphN) -> StatstestchisqGraphN {
  let result = stats_test_chi_sq_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_test_chi_sq_graphn_fill(s : StatstestchisqGraphN, v : Double) -> StatstestchisqGraphN {
  let result = stats_test_chi_sq_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_test_chi_sq_graphn_min(s : StatstestchisqGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_chi_sq_graphn_max(s : StatstestchisqGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_chi_sq_graphn_to_string(s : StatstestchisqGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestchisqNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_chi_sq_node_make(size : Int) -> StatstestchisqNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_chi_sq_node_len(s : StatstestchisqNode) -> Int { s.size }

pub fn stats_test_chi_sq_node_get(s : StatstestchisqNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_chi_sq_node_set(s : StatstestchisqNode, i : Int, v : Double) -> StatstestchisqNode {
  let result = stats_test_chi_sq_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_test_chi_sq_node_sum(s : StatstestchisqNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_test_chi_sq_node_mean(s : StatstestchisqNode) -> Double {
  if s.size == 0 { 0.0 } else { stats_test_chi_sq_node_sum(s) / s.size.to_double() }
}

pub fn stats_test_chi_sq_node_scale(s : StatstestchisqNode, f : Double) -> StatstestchisqNode {
  let result = stats_test_chi_sq_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_test_chi_sq_node_add(a : StatstestchisqNode, b : StatstestchisqNode) -> StatstestchisqNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_test_chi_sq_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_test_chi_sq_node_copy(s : StatstestchisqNode) -> StatstestchisqNode {
  let result = stats_test_chi_sq_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_test_chi_sq_node_fill(s : StatstestchisqNode, v : Double) -> StatstestchisqNode {
  let result = stats_test_chi_sq_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_test_chi_sq_node_min(s : StatstestchisqNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_chi_sq_node_max(s : StatstestchisqNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_chi_sq_node_to_string(s : StatstestchisqNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestchisqEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_chi_sq_edge_make(size : Int) -> StatstestchisqEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_chi_sq_edge_len(s : StatstestchisqEdge) -> Int { s.size }

pub fn stats_test_chi_sq_edge_get(s : StatstestchisqEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_chi_sq_edge_set(s : StatstestchisqEdge, i : Int, v : Double) -> StatstestchisqEdge {
  let result = stats_test_chi_sq_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_test_chi_sq_edge_sum(s : StatstestchisqEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_test_chi_sq_edge_mean(s : StatstestchisqEdge) -> Double {
  if s.size == 0 { 0.0 } else { stats_test_chi_sq_edge_sum(s) / s.size.to_double() }
}

pub fn stats_test_chi_sq_edge_scale(s : StatstestchisqEdge, f : Double) -> StatstestchisqEdge {
  let result = stats_test_chi_sq_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_test_chi_sq_edge_add(a : StatstestchisqEdge, b : StatstestchisqEdge) -> StatstestchisqEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_test_chi_sq_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_test_chi_sq_edge_copy(s : StatstestchisqEdge) -> StatstestchisqEdge {
  let result = stats_test_chi_sq_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_test_chi_sq_edge_fill(s : StatstestchisqEdge, v : Double) -> StatstestchisqEdge {
  let result = stats_test_chi_sq_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_test_chi_sq_edge_min(s : StatstestchisqEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_chi_sq_edge_max(s : StatstestchisqEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_chi_sq_edge_to_string(s : StatstestchisqEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestchisqPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_chi_sq_path_make(size : Int) -> StatstestchisqPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_chi_sq_path_len(s : StatstestchisqPath) -> Int { s.size }

pub fn stats_test_chi_sq_path_get(s : StatstestchisqPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_chi_sq_path_set(s : StatstestchisqPath, i : Int, v : Double) -> StatstestchisqPath {
  let result = stats_test_chi_sq_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_test_chi_sq_path_sum(s : StatstestchisqPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_test_chi_sq_path_mean(s : StatstestchisqPath) -> Double {
  if s.size == 0 { 0.0 } else { stats_test_chi_sq_path_sum(s) / s.size.to_double() }
}

pub fn stats_test_chi_sq_path_scale(s : StatstestchisqPath, f : Double) -> StatstestchisqPath {
  let result = stats_test_chi_sq_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_test_chi_sq_path_add(a : StatstestchisqPath, b : StatstestchisqPath) -> StatstestchisqPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_test_chi_sq_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_test_chi_sq_path_copy(s : StatstestchisqPath) -> StatstestchisqPath {
  let result = stats_test_chi_sq_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_test_chi_sq_path_fill(s : StatstestchisqPath, v : Double) -> StatstestchisqPath {
  let result = stats_test_chi_sq_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_test_chi_sq_path_min(s : StatstestchisqPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_chi_sq_path_max(s : StatstestchisqPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_chi_sq_path_to_string(s : StatstestchisqPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestchisqCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_chi_sq_cluster_make(size : Int) -> StatstestchisqCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_chi_sq_cluster_len(s : StatstestchisqCluster) -> Int { s.size }

pub fn stats_test_chi_sq_cluster_get(s : StatstestchisqCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_chi_sq_cluster_set(s : StatstestchisqCluster, i : Int, v : Double) -> StatstestchisqCluster {
  let result = stats_test_chi_sq_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_test_chi_sq_cluster_sum(s : StatstestchisqCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_test_chi_sq_cluster_mean(s : StatstestchisqCluster) -> Double {
  if s.size == 0 { 0.0 } else { stats_test_chi_sq_cluster_sum(s) / s.size.to_double() }
}

pub fn stats_test_chi_sq_cluster_scale(s : StatstestchisqCluster, f : Double) -> StatstestchisqCluster {
  let result = stats_test_chi_sq_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_test_chi_sq_cluster_add(a : StatstestchisqCluster, b : StatstestchisqCluster) -> StatstestchisqCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_test_chi_sq_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_test_chi_sq_cluster_copy(s : StatstestchisqCluster) -> StatstestchisqCluster {
  let result = stats_test_chi_sq_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_test_chi_sq_cluster_fill(s : StatstestchisqCluster, v : Double) -> StatstestchisqCluster {
  let result = stats_test_chi_sq_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_test_chi_sq_cluster_min(s : StatstestchisqCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_chi_sq_cluster_max(s : StatstestchisqCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_chi_sq_cluster_to_string(s : StatstestchisqCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestchisqModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_chi_sq_model_make(size : Int) -> StatstestchisqModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_chi_sq_model_len(s : StatstestchisqModel) -> Int { s.size }

pub fn stats_test_chi_sq_model_get(s : StatstestchisqModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_chi_sq_model_set(s : StatstestchisqModel, i : Int, v : Double) -> StatstestchisqModel {
  let result = stats_test_chi_sq_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_test_chi_sq_model_sum(s : StatstestchisqModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_test_chi_sq_model_mean(s : StatstestchisqModel) -> Double {
  if s.size == 0 { 0.0 } else { stats_test_chi_sq_model_sum(s) / s.size.to_double() }
}

pub fn stats_test_chi_sq_model_scale(s : StatstestchisqModel, f : Double) -> StatstestchisqModel {
  let result = stats_test_chi_sq_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_test_chi_sq_model_add(a : StatstestchisqModel, b : StatstestchisqModel) -> StatstestchisqModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_test_chi_sq_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_test_chi_sq_model_copy(s : StatstestchisqModel) -> StatstestchisqModel {
  let result = stats_test_chi_sq_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_test_chi_sq_model_fill(s : StatstestchisqModel, v : Double) -> StatstestchisqModel {
  let result = stats_test_chi_sq_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_test_chi_sq_model_min(s : StatstestchisqModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_chi_sq_model_max(s : StatstestchisqModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_chi_sq_model_to_string(s : StatstestchisqModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestchisqLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_chi_sq_layer_make(size : Int) -> StatstestchisqLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_chi_sq_layer_len(s : StatstestchisqLayer) -> Int { s.size }

pub fn stats_test_chi_sq_layer_get(s : StatstestchisqLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_chi_sq_layer_set(s : StatstestchisqLayer, i : Int, v : Double) -> StatstestchisqLayer {
  let result = stats_test_chi_sq_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_test_chi_sq_layer_sum(s : StatstestchisqLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_test_chi_sq_layer_mean(s : StatstestchisqLayer) -> Double {
  if s.size == 0 { 0.0 } else { stats_test_chi_sq_layer_sum(s) / s.size.to_double() }
}

pub fn stats_test_chi_sq_layer_scale(s : StatstestchisqLayer, f : Double) -> StatstestchisqLayer {
  let result = stats_test_chi_sq_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_test_chi_sq_layer_add(a : StatstestchisqLayer, b : StatstestchisqLayer) -> StatstestchisqLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_test_chi_sq_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_test_chi_sq_layer_copy(s : StatstestchisqLayer) -> StatstestchisqLayer {
  let result = stats_test_chi_sq_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_test_chi_sq_layer_fill(s : StatstestchisqLayer, v : Double) -> StatstestchisqLayer {
  let result = stats_test_chi_sq_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_test_chi_sq_layer_min(s : StatstestchisqLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_chi_sq_layer_max(s : StatstestchisqLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_chi_sq_layer_to_string(s : StatstestchisqLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestchisqBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_chi_sq_buffer_make(size : Int) -> StatstestchisqBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_chi_sq_buffer_len(s : StatstestchisqBuffer) -> Int { s.size }

pub fn stats_test_chi_sq_buffer_get(s : StatstestchisqBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_chi_sq_buffer_set(s : StatstestchisqBuffer, i : Int, v : Double) -> StatstestchisqBuffer {
  let result = stats_test_chi_sq_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_test_chi_sq_buffer_sum(s : StatstestchisqBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_test_chi_sq_buffer_mean(s : StatstestchisqBuffer) -> Double {
  if s.size == 0 { 0.0 } else { stats_test_chi_sq_buffer_sum(s) / s.size.to_double() }
}

pub fn stats_test_chi_sq_buffer_scale(s : StatstestchisqBuffer, f : Double) -> StatstestchisqBuffer {
  let result = stats_test_chi_sq_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_test_chi_sq_buffer_add(a : StatstestchisqBuffer, b : StatstestchisqBuffer) -> StatstestchisqBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_test_chi_sq_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_test_chi_sq_buffer_copy(s : StatstestchisqBuffer) -> StatstestchisqBuffer {
  let result = stats_test_chi_sq_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_test_chi_sq_buffer_fill(s : StatstestchisqBuffer, v : Double) -> StatstestchisqBuffer {
  let result = stats_test_chi_sq_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_test_chi_sq_buffer_min(s : StatstestchisqBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_chi_sq_buffer_max(s : StatstestchisqBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_chi_sq_buffer_to_string(s : StatstestchisqBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestchisqCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_chi_sq_cursor_make(size : Int) -> StatstestchisqCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_chi_sq_cursor_len(s : StatstestchisqCursor) -> Int { s.size }

pub fn stats_test_chi_sq_cursor_get(s : StatstestchisqCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_chi_sq_cursor_set(s : StatstestchisqCursor, i : Int, v : Double) -> StatstestchisqCursor {
  let result = stats_test_chi_sq_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_test_chi_sq_cursor_sum(s : StatstestchisqCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_test_chi_sq_cursor_mean(s : StatstestchisqCursor) -> Double {
  if s.size == 0 { 0.0 } else { stats_test_chi_sq_cursor_sum(s) / s.size.to_double() }
}

pub fn stats_test_chi_sq_cursor_scale(s : StatstestchisqCursor, f : Double) -> StatstestchisqCursor {
  let result = stats_test_chi_sq_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_test_chi_sq_cursor_add(a : StatstestchisqCursor, b : StatstestchisqCursor) -> StatstestchisqCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_test_chi_sq_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_test_chi_sq_cursor_copy(s : StatstestchisqCursor) -> StatstestchisqCursor {
  let result = stats_test_chi_sq_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_test_chi_sq_cursor_fill(s : StatstestchisqCursor, v : Double) -> StatstestchisqCursor {
  let result = stats_test_chi_sq_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_test_chi_sq_cursor_min(s : StatstestchisqCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_chi_sq_cursor_max(s : StatstestchisqCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_chi_sq_cursor_to_string(s : StatstestchisqCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestchisqView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_chi_sq_view_make(size : Int) -> StatstestchisqView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_chi_sq_view_len(s : StatstestchisqView) -> Int { s.size }

pub fn stats_test_chi_sq_view_get(s : StatstestchisqView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_chi_sq_view_set(s : StatstestchisqView, i : Int, v : Double) -> StatstestchisqView {
  let result = stats_test_chi_sq_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_test_chi_sq_view_sum(s : StatstestchisqView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_test_chi_sq_view_mean(s : StatstestchisqView) -> Double {
  if s.size == 0 { 0.0 } else { stats_test_chi_sq_view_sum(s) / s.size.to_double() }
}

pub fn stats_test_chi_sq_view_scale(s : StatstestchisqView, f : Double) -> StatstestchisqView {
  let result = stats_test_chi_sq_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_test_chi_sq_view_add(a : StatstestchisqView, b : StatstestchisqView) -> StatstestchisqView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_test_chi_sq_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_test_chi_sq_view_copy(s : StatstestchisqView) -> StatstestchisqView {
  let result = stats_test_chi_sq_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_test_chi_sq_view_fill(s : StatstestchisqView, v : Double) -> StatstestchisqView {
  let result = stats_test_chi_sq_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_test_chi_sq_view_min(s : StatstestchisqView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_chi_sq_view_max(s : StatstestchisqView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_chi_sq_view_to_string(s : StatstestchisqView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestchisqRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_chi_sq_range_make(size : Int) -> StatstestchisqRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_chi_sq_range_len(s : StatstestchisqRange) -> Int { s.size }

pub fn stats_test_chi_sq_range_get(s : StatstestchisqRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_chi_sq_range_set(s : StatstestchisqRange, i : Int, v : Double) -> StatstestchisqRange {
  let result = stats_test_chi_sq_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_test_chi_sq_range_sum(s : StatstestchisqRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_test_chi_sq_range_mean(s : StatstestchisqRange) -> Double {
  if s.size == 0 { 0.0 } else { stats_test_chi_sq_range_sum(s) / s.size.to_double() }
}

pub fn stats_test_chi_sq_range_scale(s : StatstestchisqRange, f : Double) -> StatstestchisqRange {
  let result = stats_test_chi_sq_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_test_chi_sq_range_add(a : StatstestchisqRange, b : StatstestchisqRange) -> StatstestchisqRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_test_chi_sq_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_test_chi_sq_range_copy(s : StatstestchisqRange) -> StatstestchisqRange {
  let result = stats_test_chi_sq_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_test_chi_sq_range_fill(s : StatstestchisqRange, v : Double) -> StatstestchisqRange {
  let result = stats_test_chi_sq_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_test_chi_sq_range_min(s : StatstestchisqRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_chi_sq_range_max(s : StatstestchisqRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_chi_sq_range_to_string(s : StatstestchisqRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestchisqSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_chi_sq_slice_make(size : Int) -> StatstestchisqSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_chi_sq_slice_len(s : StatstestchisqSlice) -> Int { s.size }

pub fn stats_test_chi_sq_slice_get(s : StatstestchisqSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_chi_sq_slice_set(s : StatstestchisqSlice, i : Int, v : Double) -> StatstestchisqSlice {
  let result = stats_test_chi_sq_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_test_chi_sq_slice_sum(s : StatstestchisqSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_test_chi_sq_slice_mean(s : StatstestchisqSlice) -> Double {
  if s.size == 0 { 0.0 } else { stats_test_chi_sq_slice_sum(s) / s.size.to_double() }
}

pub fn stats_test_chi_sq_slice_scale(s : StatstestchisqSlice, f : Double) -> StatstestchisqSlice {
  let result = stats_test_chi_sq_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_test_chi_sq_slice_add(a : StatstestchisqSlice, b : StatstestchisqSlice) -> StatstestchisqSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_test_chi_sq_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_test_chi_sq_slice_copy(s : StatstestchisqSlice) -> StatstestchisqSlice {
  let result = stats_test_chi_sq_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_test_chi_sq_slice_fill(s : StatstestchisqSlice, v : Double) -> StatstestchisqSlice {
  let result = stats_test_chi_sq_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_test_chi_sq_slice_min(s : StatstestchisqSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_chi_sq_slice_max(s : StatstestchisqSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_chi_sq_slice_to_string(s : StatstestchisqSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

