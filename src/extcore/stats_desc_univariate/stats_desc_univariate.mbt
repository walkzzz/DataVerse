///===
/// extcore/stats_desc_univariate

pub(all) struct StatsdescunivariatePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn stats_desc_univariate_make_point(x : Double, y : Double) -> StatsdescunivariatePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn stats_desc_univariate_make_point3(x : Double, y : Double, z : Double) -> StatsdescunivariatePoint {
  { x, y, z, label: 0 }
}

pub fn stats_desc_univariate_point_x(pt : StatsdescunivariatePoint) -> Double { pt.x }

pub fn stats_desc_univariate_point_y(pt : StatsdescunivariatePoint) -> Double { pt.y }

pub fn stats_desc_univariate_point_z(pt : StatsdescunivariatePoint) -> Double { pt.z }

pub fn stats_desc_univariate_point_label(pt : StatsdescunivariatePoint) -> Int { pt.label }

pub fn stats_desc_univariate_point_dist(a : StatsdescunivariatePoint, b : StatsdescunivariatePoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn stats_desc_univariate_point_add(a : StatsdescunivariatePoint, b : StatsdescunivariatePoint) -> StatsdescunivariatePoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn stats_desc_univariate_point_sub(a : StatsdescunivariatePoint, b : StatsdescunivariatePoint) -> StatsdescunivariatePoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn stats_desc_univariate_point_scale(pt : StatsdescunivariatePoint, s : Double) -> StatsdescunivariatePoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn stats_desc_univariate_point_dot(a : StatsdescunivariatePoint, b : StatsdescunivariatePoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn stats_desc_univariate_point_cross(a : StatsdescunivariatePoint, b : StatsdescunivariatePoint) -> StatsdescunivariatePoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn stats_desc_univariate_point_norm(pt : StatsdescunivariatePoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn stats_desc_univariate_point_normalize(pt : StatsdescunivariatePoint) -> StatsdescunivariatePoint {
  let n = stats_desc_univariate_point_norm(pt)
  if n < 0.0000001 { pt } else { stats_desc_univariate_point_scale(pt, 1.0 / n) }
}

pub fn stats_desc_univariate_point_negate(pt : StatsdescunivariatePoint) -> StatsdescunivariatePoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn stats_desc_univariate_point_mid(a : StatsdescunivariatePoint, b : StatsdescunivariatePoint) -> StatsdescunivariatePoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn stats_desc_univariate_point_lerp(a : StatsdescunivariatePoint, b : StatsdescunivariatePoint, t : Double) -> StatsdescunivariatePoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn stats_desc_univariate_point_to_string(pt : StatsdescunivariatePoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct StatsdescunivariateSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn stats_desc_univariate_make_series(vals : Array[Double], name : String) -> StatsdescunivariateSeries {
  { vals, name, meta: 0 }
}

pub fn stats_desc_univariate_series_len(s : StatsdescunivariateSeries) -> Int { s.vals.length() }

pub fn stats_desc_univariate_series_sum(s : StatsdescunivariateSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn stats_desc_univariate_series_mean(s : StatsdescunivariateSeries) -> Double {
  let n = stats_desc_univariate_series_len(s)
  if n == 0 { 0.0 } else { stats_desc_univariate_series_sum(s) / n.to_double() }
}

pub fn stats_desc_univariate_series_min(s : StatsdescunivariateSeries) -> Double {
  let n = stats_desc_univariate_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn stats_desc_univariate_series_max(s : StatsdescunivariateSeries) -> Double {
  let n = stats_desc_univariate_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn stats_desc_univariate_series_range(s : StatsdescunivariateSeries) -> Double {
  stats_desc_univariate_series_max(s) - stats_desc_univariate_series_min(s)
}

pub fn stats_desc_univariate_series_var(s : StatsdescunivariateSeries) -> Double {
  let n = stats_desc_univariate_series_len(s)
  if n == 0 { 0.0 } else {
    let m = stats_desc_univariate_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn stats_desc_univariate_series_std(s : StatsdescunivariateSeries) -> Double { @_common.sqrt(stats_desc_univariate_series_var(s)) }

pub fn stats_desc_univariate_series_median(s : StatsdescunivariateSeries) -> Double {
  let n = stats_desc_univariate_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = stats_desc_univariate_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn stats_desc_univariate_series_scale(s : StatsdescunivariateSeries, f : Double) -> StatsdescunivariateSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn stats_desc_univariate_series_add(a : StatsdescunivariateSeries, b : StatsdescunivariateSeries) -> StatsdescunivariateSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn stats_desc_univariate_series_sub(a : StatsdescunivariateSeries, b : StatsdescunivariateSeries) -> StatsdescunivariateSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn stats_desc_univariate_series_normalize(s : StatsdescunivariateSeries) -> StatsdescunivariateSeries {
  let mn = stats_desc_univariate_series_min(s)
  let mx = stats_desc_univariate_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn stats_desc_univariate_series_cumsum(s : StatsdescunivariateSeries) -> StatsdescunivariateSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn stats_desc_univariate_series_to_string(s : StatsdescunivariateSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct StatsdescunivariateMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn stats_desc_univariate_make_matrix(rows : Int, cols : Int, val : Double) -> StatsdescunivariateMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn stats_desc_univariate_matrix_identity(n : Int) -> StatsdescunivariateMatrix {
  let m = stats_desc_univariate_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn stats_desc_univariate_matrix_get(m : StatsdescunivariateMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn stats_desc_univariate_matrix_transpose(m : StatsdescunivariateMatrix) -> StatsdescunivariateMatrix {
  let result = stats_desc_univariate_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn stats_desc_univariate_matrix_add(a : StatsdescunivariateMatrix, b : StatsdescunivariateMatrix) -> StatsdescunivariateMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = stats_desc_univariate_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn stats_desc_univariate_matrix_scale(m : StatsdescunivariateMatrix, s : Double) -> StatsdescunivariateMatrix {
  let result = stats_desc_univariate_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn stats_desc_univariate_matrix_multiply(a : StatsdescunivariateMatrix, b : StatsdescunivariateMatrix) -> StatsdescunivariateMatrix {
  if a.cols != b.rows { return stats_desc_univariate_make_matrix(a.rows, b.cols, 0.0) }
  let result = stats_desc_univariate_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn stats_desc_univariate_matrix_trace(m : StatsdescunivariateMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn stats_desc_univariate_matrix_det(m : StatsdescunivariateMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn stats_desc_univariate_matrix_norm(m : StatsdescunivariateMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn stats_desc_univariate_matrix_to_string(m : StatsdescunivariateMatrix) -> String {
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

pub(all) struct StatsdescunivariateVector {
  comps : Array[Double]
  dim : Int
}

pub fn stats_desc_univariate_make_vector(comps : Array[Double]) -> StatsdescunivariateVector {
  { comps, dim: comps.length() }
}

pub fn stats_desc_univariate_vector_zero(dim : Int) -> StatsdescunivariateVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn stats_desc_univariate_vector_add(a : StatsdescunivariateVector, b : StatsdescunivariateVector) -> StatsdescunivariateVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn stats_desc_univariate_vector_sub(a : StatsdescunivariateVector, b : StatsdescunivariateVector) -> StatsdescunivariateVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn stats_desc_univariate_vector_scale(v : StatsdescunivariateVector, s : Double) -> StatsdescunivariateVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn stats_desc_univariate_vector_dot(a : StatsdescunivariateVector, b : StatsdescunivariateVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn stats_desc_univariate_vector_norm(v : StatsdescunivariateVector) -> Double { @_common.sqrt(stats_desc_univariate_vector_dot(v, v)) }

pub fn stats_desc_univariate_vector_normalize(v : StatsdescunivariateVector) -> StatsdescunivariateVector {
  let n = stats_desc_univariate_vector_norm(v)
  if n < 0.0000001 { v } else { stats_desc_univariate_vector_scale(v, 1.0 / n) }
}

pub fn stats_desc_univariate_vector_dist(a : StatsdescunivariateVector, b : StatsdescunivariateVector) -> Double {
  stats_desc_univariate_vector_norm(stats_desc_univariate_vector_sub(a, b))
}

pub fn stats_desc_univariate_vector_to_string(v : StatsdescunivariateVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn stats_desc_univariate_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn stats_desc_univariate_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = stats_desc_univariate_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn stats_desc_univariate_std(data : Array[Double]) -> Double { @_common.sqrt(stats_desc_univariate_var(data)) }

pub fn stats_desc_univariate_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = stats_desc_univariate_mean(a); let mb = stats_desc_univariate_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn stats_desc_univariate_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = stats_desc_univariate_std(a); let sb = stats_desc_univariate_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { stats_desc_univariate_cov(a, b) / (sa * sb) }
}

pub fn stats_desc_univariate_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = stats_desc_univariate_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn stats_desc_univariate_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn stats_desc_univariate_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn stats_desc_univariate_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  @_common.sqrt(stats_desc_univariate_mse(pred, labels))
}

pub fn stats_desc_univariate_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn stats_desc_univariate_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = stats_desc_univariate_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn stats_desc_univariate_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn stats_desc_univariate_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn stats_desc_univariate_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = stats_desc_univariate_precision(pred, labels, pos); let r = stats_desc_univariate_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn stats_desc_univariate_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn stats_desc_univariate_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = stats_desc_univariate_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn stats_desc_univariate_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn stats_desc_univariate_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn stats_desc_univariate_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = stats_desc_univariate_gcd(a, b)
    (a / g) * b
  }
}

pub fn stats_desc_univariate_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn stats_desc_univariate_fibonacci(n : Int) -> Int {
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

pub fn stats_desc_univariate_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = stats_desc_univariate_min(data); let mx = stats_desc_univariate_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn stats_desc_univariate_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = stats_desc_univariate_mean(data); let sd = stats_desc_univariate_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn stats_desc_univariate_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn stats_desc_univariate_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn stats_desc_univariate_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn stats_desc_univariate_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn stats_desc_univariate_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn stats_desc_univariate_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

pub(all) struct StatsdescunivariateFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_univariate_frame_make(size : Int) -> StatsdescunivariateFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_desc_univariate_frame_len(s : StatsdescunivariateFrame) -> Int { s.size }

pub fn stats_desc_univariate_frame_get(s : StatsdescunivariateFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_desc_univariate_frame_set(s : StatsdescunivariateFrame, i : Int, v : Double) -> StatsdescunivariateFrame {
  let result = stats_desc_univariate_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_desc_univariate_frame_sum(s : StatsdescunivariateFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_desc_univariate_frame_mean(s : StatsdescunivariateFrame) -> Double {
  if s.size == 0 { 0.0 } else { stats_desc_univariate_frame_sum(s) / s.size.to_double() }
}

pub fn stats_desc_univariate_frame_scale(s : StatsdescunivariateFrame, f : Double) -> StatsdescunivariateFrame {
  let result = stats_desc_univariate_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_desc_univariate_frame_add(a : StatsdescunivariateFrame, b : StatsdescunivariateFrame) -> StatsdescunivariateFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_desc_univariate_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_desc_univariate_frame_copy(s : StatsdescunivariateFrame) -> StatsdescunivariateFrame {
  let result = stats_desc_univariate_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_desc_univariate_frame_fill(s : StatsdescunivariateFrame, v : Double) -> StatsdescunivariateFrame {
  let result = stats_desc_univariate_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_desc_univariate_frame_min(s : StatsdescunivariateFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_desc_univariate_frame_max(s : StatsdescunivariateFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_desc_univariate_frame_to_string(s : StatsdescunivariateFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdescunivariateTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_univariate_table_make(size : Int) -> StatsdescunivariateTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_desc_univariate_table_len(s : StatsdescunivariateTable) -> Int { s.size }

pub fn stats_desc_univariate_table_get(s : StatsdescunivariateTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_desc_univariate_table_set(s : StatsdescunivariateTable, i : Int, v : Double) -> StatsdescunivariateTable {
  let result = stats_desc_univariate_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_desc_univariate_table_sum(s : StatsdescunivariateTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_desc_univariate_table_mean(s : StatsdescunivariateTable) -> Double {
  if s.size == 0 { 0.0 } else { stats_desc_univariate_table_sum(s) / s.size.to_double() }
}

pub fn stats_desc_univariate_table_scale(s : StatsdescunivariateTable, f : Double) -> StatsdescunivariateTable {
  let result = stats_desc_univariate_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_desc_univariate_table_add(a : StatsdescunivariateTable, b : StatsdescunivariateTable) -> StatsdescunivariateTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_desc_univariate_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_desc_univariate_table_copy(s : StatsdescunivariateTable) -> StatsdescunivariateTable {
  let result = stats_desc_univariate_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_desc_univariate_table_fill(s : StatsdescunivariateTable, v : Double) -> StatsdescunivariateTable {
  let result = stats_desc_univariate_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_desc_univariate_table_min(s : StatsdescunivariateTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_desc_univariate_table_max(s : StatsdescunivariateTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_desc_univariate_table_to_string(s : StatsdescunivariateTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdescunivariateGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_univariate_graphn_make(size : Int) -> StatsdescunivariateGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_desc_univariate_graphn_len(s : StatsdescunivariateGraphN) -> Int { s.size }

pub fn stats_desc_univariate_graphn_get(s : StatsdescunivariateGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_desc_univariate_graphn_set(s : StatsdescunivariateGraphN, i : Int, v : Double) -> StatsdescunivariateGraphN {
  let result = stats_desc_univariate_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_desc_univariate_graphn_sum(s : StatsdescunivariateGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_desc_univariate_graphn_mean(s : StatsdescunivariateGraphN) -> Double {
  if s.size == 0 { 0.0 } else { stats_desc_univariate_graphn_sum(s) / s.size.to_double() }
}

pub fn stats_desc_univariate_graphn_scale(s : StatsdescunivariateGraphN, f : Double) -> StatsdescunivariateGraphN {
  let result = stats_desc_univariate_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_desc_univariate_graphn_add(a : StatsdescunivariateGraphN, b : StatsdescunivariateGraphN) -> StatsdescunivariateGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_desc_univariate_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_desc_univariate_graphn_copy(s : StatsdescunivariateGraphN) -> StatsdescunivariateGraphN {
  let result = stats_desc_univariate_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_desc_univariate_graphn_fill(s : StatsdescunivariateGraphN, v : Double) -> StatsdescunivariateGraphN {
  let result = stats_desc_univariate_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_desc_univariate_graphn_min(s : StatsdescunivariateGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_desc_univariate_graphn_max(s : StatsdescunivariateGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_desc_univariate_graphn_to_string(s : StatsdescunivariateGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdescunivariateNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_univariate_node_make(size : Int) -> StatsdescunivariateNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_desc_univariate_node_len(s : StatsdescunivariateNode) -> Int { s.size }

pub fn stats_desc_univariate_node_get(s : StatsdescunivariateNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_desc_univariate_node_set(s : StatsdescunivariateNode, i : Int, v : Double) -> StatsdescunivariateNode {
  let result = stats_desc_univariate_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_desc_univariate_node_sum(s : StatsdescunivariateNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_desc_univariate_node_mean(s : StatsdescunivariateNode) -> Double {
  if s.size == 0 { 0.0 } else { stats_desc_univariate_node_sum(s) / s.size.to_double() }
}

pub fn stats_desc_univariate_node_scale(s : StatsdescunivariateNode, f : Double) -> StatsdescunivariateNode {
  let result = stats_desc_univariate_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_desc_univariate_node_add(a : StatsdescunivariateNode, b : StatsdescunivariateNode) -> StatsdescunivariateNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_desc_univariate_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_desc_univariate_node_copy(s : StatsdescunivariateNode) -> StatsdescunivariateNode {
  let result = stats_desc_univariate_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_desc_univariate_node_fill(s : StatsdescunivariateNode, v : Double) -> StatsdescunivariateNode {
  let result = stats_desc_univariate_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_desc_univariate_node_min(s : StatsdescunivariateNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_desc_univariate_node_max(s : StatsdescunivariateNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_desc_univariate_node_to_string(s : StatsdescunivariateNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdescunivariateEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_univariate_edge_make(size : Int) -> StatsdescunivariateEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_desc_univariate_edge_len(s : StatsdescunivariateEdge) -> Int { s.size }

pub fn stats_desc_univariate_edge_get(s : StatsdescunivariateEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_desc_univariate_edge_set(s : StatsdescunivariateEdge, i : Int, v : Double) -> StatsdescunivariateEdge {
  let result = stats_desc_univariate_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_desc_univariate_edge_sum(s : StatsdescunivariateEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_desc_univariate_edge_mean(s : StatsdescunivariateEdge) -> Double {
  if s.size == 0 { 0.0 } else { stats_desc_univariate_edge_sum(s) / s.size.to_double() }
}

pub fn stats_desc_univariate_edge_scale(s : StatsdescunivariateEdge, f : Double) -> StatsdescunivariateEdge {
  let result = stats_desc_univariate_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_desc_univariate_edge_add(a : StatsdescunivariateEdge, b : StatsdescunivariateEdge) -> StatsdescunivariateEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_desc_univariate_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_desc_univariate_edge_copy(s : StatsdescunivariateEdge) -> StatsdescunivariateEdge {
  let result = stats_desc_univariate_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_desc_univariate_edge_fill(s : StatsdescunivariateEdge, v : Double) -> StatsdescunivariateEdge {
  let result = stats_desc_univariate_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_desc_univariate_edge_min(s : StatsdescunivariateEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_desc_univariate_edge_max(s : StatsdescunivariateEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_desc_univariate_edge_to_string(s : StatsdescunivariateEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdescunivariatePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_univariate_path_make(size : Int) -> StatsdescunivariatePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_desc_univariate_path_len(s : StatsdescunivariatePath) -> Int { s.size }

pub fn stats_desc_univariate_path_get(s : StatsdescunivariatePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_desc_univariate_path_set(s : StatsdescunivariatePath, i : Int, v : Double) -> StatsdescunivariatePath {
  let result = stats_desc_univariate_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_desc_univariate_path_sum(s : StatsdescunivariatePath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_desc_univariate_path_mean(s : StatsdescunivariatePath) -> Double {
  if s.size == 0 { 0.0 } else { stats_desc_univariate_path_sum(s) / s.size.to_double() }
}

pub fn stats_desc_univariate_path_scale(s : StatsdescunivariatePath, f : Double) -> StatsdescunivariatePath {
  let result = stats_desc_univariate_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_desc_univariate_path_add(a : StatsdescunivariatePath, b : StatsdescunivariatePath) -> StatsdescunivariatePath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_desc_univariate_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_desc_univariate_path_copy(s : StatsdescunivariatePath) -> StatsdescunivariatePath {
  let result = stats_desc_univariate_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_desc_univariate_path_fill(s : StatsdescunivariatePath, v : Double) -> StatsdescunivariatePath {
  let result = stats_desc_univariate_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_desc_univariate_path_min(s : StatsdescunivariatePath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_desc_univariate_path_max(s : StatsdescunivariatePath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_desc_univariate_path_to_string(s : StatsdescunivariatePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdescunivariateCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_univariate_cluster_make(size : Int) -> StatsdescunivariateCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_desc_univariate_cluster_len(s : StatsdescunivariateCluster) -> Int { s.size }

pub fn stats_desc_univariate_cluster_get(s : StatsdescunivariateCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_desc_univariate_cluster_set(s : StatsdescunivariateCluster, i : Int, v : Double) -> StatsdescunivariateCluster {
  let result = stats_desc_univariate_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_desc_univariate_cluster_sum(s : StatsdescunivariateCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_desc_univariate_cluster_mean(s : StatsdescunivariateCluster) -> Double {
  if s.size == 0 { 0.0 } else { stats_desc_univariate_cluster_sum(s) / s.size.to_double() }
}

pub fn stats_desc_univariate_cluster_scale(s : StatsdescunivariateCluster, f : Double) -> StatsdescunivariateCluster {
  let result = stats_desc_univariate_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_desc_univariate_cluster_add(a : StatsdescunivariateCluster, b : StatsdescunivariateCluster) -> StatsdescunivariateCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_desc_univariate_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_desc_univariate_cluster_copy(s : StatsdescunivariateCluster) -> StatsdescunivariateCluster {
  let result = stats_desc_univariate_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_desc_univariate_cluster_fill(s : StatsdescunivariateCluster, v : Double) -> StatsdescunivariateCluster {
  let result = stats_desc_univariate_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_desc_univariate_cluster_min(s : StatsdescunivariateCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_desc_univariate_cluster_max(s : StatsdescunivariateCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_desc_univariate_cluster_to_string(s : StatsdescunivariateCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdescunivariateModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_univariate_model_make(size : Int) -> StatsdescunivariateModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_desc_univariate_model_len(s : StatsdescunivariateModel) -> Int { s.size }

pub fn stats_desc_univariate_model_get(s : StatsdescunivariateModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_desc_univariate_model_set(s : StatsdescunivariateModel, i : Int, v : Double) -> StatsdescunivariateModel {
  let result = stats_desc_univariate_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_desc_univariate_model_sum(s : StatsdescunivariateModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_desc_univariate_model_mean(s : StatsdescunivariateModel) -> Double {
  if s.size == 0 { 0.0 } else { stats_desc_univariate_model_sum(s) / s.size.to_double() }
}

pub fn stats_desc_univariate_model_scale(s : StatsdescunivariateModel, f : Double) -> StatsdescunivariateModel {
  let result = stats_desc_univariate_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_desc_univariate_model_add(a : StatsdescunivariateModel, b : StatsdescunivariateModel) -> StatsdescunivariateModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_desc_univariate_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_desc_univariate_model_copy(s : StatsdescunivariateModel) -> StatsdescunivariateModel {
  let result = stats_desc_univariate_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_desc_univariate_model_fill(s : StatsdescunivariateModel, v : Double) -> StatsdescunivariateModel {
  let result = stats_desc_univariate_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_desc_univariate_model_min(s : StatsdescunivariateModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_desc_univariate_model_max(s : StatsdescunivariateModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_desc_univariate_model_to_string(s : StatsdescunivariateModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdescunivariateLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_univariate_layer_make(size : Int) -> StatsdescunivariateLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_desc_univariate_layer_len(s : StatsdescunivariateLayer) -> Int { s.size }

pub fn stats_desc_univariate_layer_get(s : StatsdescunivariateLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_desc_univariate_layer_set(s : StatsdescunivariateLayer, i : Int, v : Double) -> StatsdescunivariateLayer {
  let result = stats_desc_univariate_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_desc_univariate_layer_sum(s : StatsdescunivariateLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_desc_univariate_layer_mean(s : StatsdescunivariateLayer) -> Double {
  if s.size == 0 { 0.0 } else { stats_desc_univariate_layer_sum(s) / s.size.to_double() }
}

pub fn stats_desc_univariate_layer_scale(s : StatsdescunivariateLayer, f : Double) -> StatsdescunivariateLayer {
  let result = stats_desc_univariate_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_desc_univariate_layer_add(a : StatsdescunivariateLayer, b : StatsdescunivariateLayer) -> StatsdescunivariateLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_desc_univariate_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_desc_univariate_layer_copy(s : StatsdescunivariateLayer) -> StatsdescunivariateLayer {
  let result = stats_desc_univariate_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_desc_univariate_layer_fill(s : StatsdescunivariateLayer, v : Double) -> StatsdescunivariateLayer {
  let result = stats_desc_univariate_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_desc_univariate_layer_min(s : StatsdescunivariateLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_desc_univariate_layer_max(s : StatsdescunivariateLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_desc_univariate_layer_to_string(s : StatsdescunivariateLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdescunivariateBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_univariate_buffer_make(size : Int) -> StatsdescunivariateBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_desc_univariate_buffer_len(s : StatsdescunivariateBuffer) -> Int { s.size }

pub fn stats_desc_univariate_buffer_get(s : StatsdescunivariateBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_desc_univariate_buffer_set(s : StatsdescunivariateBuffer, i : Int, v : Double) -> StatsdescunivariateBuffer {
  let result = stats_desc_univariate_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_desc_univariate_buffer_sum(s : StatsdescunivariateBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_desc_univariate_buffer_mean(s : StatsdescunivariateBuffer) -> Double {
  if s.size == 0 { 0.0 } else { stats_desc_univariate_buffer_sum(s) / s.size.to_double() }
}

pub fn stats_desc_univariate_buffer_scale(s : StatsdescunivariateBuffer, f : Double) -> StatsdescunivariateBuffer {
  let result = stats_desc_univariate_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_desc_univariate_buffer_add(a : StatsdescunivariateBuffer, b : StatsdescunivariateBuffer) -> StatsdescunivariateBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_desc_univariate_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_desc_univariate_buffer_copy(s : StatsdescunivariateBuffer) -> StatsdescunivariateBuffer {
  let result = stats_desc_univariate_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_desc_univariate_buffer_fill(s : StatsdescunivariateBuffer, v : Double) -> StatsdescunivariateBuffer {
  let result = stats_desc_univariate_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_desc_univariate_buffer_min(s : StatsdescunivariateBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_desc_univariate_buffer_max(s : StatsdescunivariateBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_desc_univariate_buffer_to_string(s : StatsdescunivariateBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdescunivariateCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_univariate_cursor_make(size : Int) -> StatsdescunivariateCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_desc_univariate_cursor_len(s : StatsdescunivariateCursor) -> Int { s.size }

pub fn stats_desc_univariate_cursor_get(s : StatsdescunivariateCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_desc_univariate_cursor_set(s : StatsdescunivariateCursor, i : Int, v : Double) -> StatsdescunivariateCursor {
  let result = stats_desc_univariate_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_desc_univariate_cursor_sum(s : StatsdescunivariateCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_desc_univariate_cursor_mean(s : StatsdescunivariateCursor) -> Double {
  if s.size == 0 { 0.0 } else { stats_desc_univariate_cursor_sum(s) / s.size.to_double() }
}

pub fn stats_desc_univariate_cursor_scale(s : StatsdescunivariateCursor, f : Double) -> StatsdescunivariateCursor {
  let result = stats_desc_univariate_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_desc_univariate_cursor_add(a : StatsdescunivariateCursor, b : StatsdescunivariateCursor) -> StatsdescunivariateCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_desc_univariate_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_desc_univariate_cursor_copy(s : StatsdescunivariateCursor) -> StatsdescunivariateCursor {
  let result = stats_desc_univariate_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_desc_univariate_cursor_fill(s : StatsdescunivariateCursor, v : Double) -> StatsdescunivariateCursor {
  let result = stats_desc_univariate_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_desc_univariate_cursor_min(s : StatsdescunivariateCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_desc_univariate_cursor_max(s : StatsdescunivariateCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_desc_univariate_cursor_to_string(s : StatsdescunivariateCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdescunivariateView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_univariate_view_make(size : Int) -> StatsdescunivariateView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_desc_univariate_view_len(s : StatsdescunivariateView) -> Int { s.size }

pub fn stats_desc_univariate_view_get(s : StatsdescunivariateView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_desc_univariate_view_set(s : StatsdescunivariateView, i : Int, v : Double) -> StatsdescunivariateView {
  let result = stats_desc_univariate_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_desc_univariate_view_sum(s : StatsdescunivariateView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_desc_univariate_view_mean(s : StatsdescunivariateView) -> Double {
  if s.size == 0 { 0.0 } else { stats_desc_univariate_view_sum(s) / s.size.to_double() }
}

pub fn stats_desc_univariate_view_scale(s : StatsdescunivariateView, f : Double) -> StatsdescunivariateView {
  let result = stats_desc_univariate_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_desc_univariate_view_add(a : StatsdescunivariateView, b : StatsdescunivariateView) -> StatsdescunivariateView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_desc_univariate_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_desc_univariate_view_copy(s : StatsdescunivariateView) -> StatsdescunivariateView {
  let result = stats_desc_univariate_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_desc_univariate_view_fill(s : StatsdescunivariateView, v : Double) -> StatsdescunivariateView {
  let result = stats_desc_univariate_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_desc_univariate_view_min(s : StatsdescunivariateView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_desc_univariate_view_max(s : StatsdescunivariateView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_desc_univariate_view_to_string(s : StatsdescunivariateView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdescunivariateRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_univariate_range_make(size : Int) -> StatsdescunivariateRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_desc_univariate_range_len(s : StatsdescunivariateRange) -> Int { s.size }

pub fn stats_desc_univariate_range_get(s : StatsdescunivariateRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_desc_univariate_range_set(s : StatsdescunivariateRange, i : Int, v : Double) -> StatsdescunivariateRange {
  let result = stats_desc_univariate_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_desc_univariate_range_sum(s : StatsdescunivariateRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_desc_univariate_range_mean(s : StatsdescunivariateRange) -> Double {
  if s.size == 0 { 0.0 } else { stats_desc_univariate_range_sum(s) / s.size.to_double() }
}

pub fn stats_desc_univariate_range_scale(s : StatsdescunivariateRange, f : Double) -> StatsdescunivariateRange {
  let result = stats_desc_univariate_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_desc_univariate_range_add(a : StatsdescunivariateRange, b : StatsdescunivariateRange) -> StatsdescunivariateRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_desc_univariate_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_desc_univariate_range_copy(s : StatsdescunivariateRange) -> StatsdescunivariateRange {
  let result = stats_desc_univariate_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_desc_univariate_range_fill(s : StatsdescunivariateRange, v : Double) -> StatsdescunivariateRange {
  let result = stats_desc_univariate_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_desc_univariate_range_min(s : StatsdescunivariateRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_desc_univariate_range_max(s : StatsdescunivariateRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_desc_univariate_range_to_string(s : StatsdescunivariateRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdescunivariateSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_univariate_slice_make(size : Int) -> StatsdescunivariateSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_desc_univariate_slice_len(s : StatsdescunivariateSlice) -> Int { s.size }

pub fn stats_desc_univariate_slice_get(s : StatsdescunivariateSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_desc_univariate_slice_set(s : StatsdescunivariateSlice, i : Int, v : Double) -> StatsdescunivariateSlice {
  let result = stats_desc_univariate_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_desc_univariate_slice_sum(s : StatsdescunivariateSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_desc_univariate_slice_mean(s : StatsdescunivariateSlice) -> Double {
  if s.size == 0 { 0.0 } else { stats_desc_univariate_slice_sum(s) / s.size.to_double() }
}

pub fn stats_desc_univariate_slice_scale(s : StatsdescunivariateSlice, f : Double) -> StatsdescunivariateSlice {
  let result = stats_desc_univariate_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_desc_univariate_slice_add(a : StatsdescunivariateSlice, b : StatsdescunivariateSlice) -> StatsdescunivariateSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_desc_univariate_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_desc_univariate_slice_copy(s : StatsdescunivariateSlice) -> StatsdescunivariateSlice {
  let result = stats_desc_univariate_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_desc_univariate_slice_fill(s : StatsdescunivariateSlice, v : Double) -> StatsdescunivariateSlice {
  let result = stats_desc_univariate_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_desc_univariate_slice_min(s : StatsdescunivariateSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_desc_univariate_slice_max(s : StatsdescunivariateSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_desc_univariate_slice_to_string(s : StatsdescunivariateSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

