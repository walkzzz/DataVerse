///===
/// extcore/stats_dist_laplace

pub(all) struct StatsdistlaplacePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn stats_dist_laplace_make_point(x : Double, y : Double) -> StatsdistlaplacePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn stats_dist_laplace_make_point3(x : Double, y : Double, z : Double) -> StatsdistlaplacePoint {
  { x, y, z, label: 0 }
}

pub fn stats_dist_laplace_point_x(pt : StatsdistlaplacePoint) -> Double { pt.x }

pub fn stats_dist_laplace_point_y(pt : StatsdistlaplacePoint) -> Double { pt.y }

pub fn stats_dist_laplace_point_z(pt : StatsdistlaplacePoint) -> Double { pt.z }

pub fn stats_dist_laplace_point_label(pt : StatsdistlaplacePoint) -> Int { pt.label }

pub fn stats_dist_laplace_point_dist(a : StatsdistlaplacePoint, b : StatsdistlaplacePoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  stats_dist_laplace_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn stats_dist_laplace_point_add(a : StatsdistlaplacePoint, b : StatsdistlaplacePoint) -> StatsdistlaplacePoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn stats_dist_laplace_point_sub(a : StatsdistlaplacePoint, b : StatsdistlaplacePoint) -> StatsdistlaplacePoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn stats_dist_laplace_point_scale(pt : StatsdistlaplacePoint, s : Double) -> StatsdistlaplacePoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn stats_dist_laplace_point_dot(a : StatsdistlaplacePoint, b : StatsdistlaplacePoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn stats_dist_laplace_point_cross(a : StatsdistlaplacePoint, b : StatsdistlaplacePoint) -> StatsdistlaplacePoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn stats_dist_laplace_point_norm(pt : StatsdistlaplacePoint) -> Double {
  stats_dist_laplace_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn stats_dist_laplace_point_normalize(pt : StatsdistlaplacePoint) -> StatsdistlaplacePoint {
  let n = stats_dist_laplace_point_norm(pt)
  if n < 0.0000001 { pt } else { stats_dist_laplace_point_scale(pt, 1.0 / n) }
}

pub fn stats_dist_laplace_point_negate(pt : StatsdistlaplacePoint) -> StatsdistlaplacePoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn stats_dist_laplace_point_mid(a : StatsdistlaplacePoint, b : StatsdistlaplacePoint) -> StatsdistlaplacePoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn stats_dist_laplace_point_lerp(a : StatsdistlaplacePoint, b : StatsdistlaplacePoint, t : Double) -> StatsdistlaplacePoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn stats_dist_laplace_point_to_string(pt : StatsdistlaplacePoint) -> String {
  "(" + stats_dist_laplace_dbl(pt.x) + ", " + stats_dist_laplace_dbl(pt.y) + ", " + stats_dist_laplace_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct StatsdistlaplaceSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn stats_dist_laplace_make_series(vals : Array[Double], name : String) -> StatsdistlaplaceSeries {
  { vals, name, meta: 0 }
}

pub fn stats_dist_laplace_series_len(s : StatsdistlaplaceSeries) -> Int { s.vals.length() }

pub fn stats_dist_laplace_series_sum(s : StatsdistlaplaceSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn stats_dist_laplace_series_mean(s : StatsdistlaplaceSeries) -> Double {
  let n = stats_dist_laplace_series_len(s)
  if n == 0 { 0.0 } else { stats_dist_laplace_series_sum(s) / n.to_double() }
}

pub fn stats_dist_laplace_series_min(s : StatsdistlaplaceSeries) -> Double {
  let n = stats_dist_laplace_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn stats_dist_laplace_series_max(s : StatsdistlaplaceSeries) -> Double {
  let n = stats_dist_laplace_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn stats_dist_laplace_series_range(s : StatsdistlaplaceSeries) -> Double {
  stats_dist_laplace_series_max(s) - stats_dist_laplace_series_min(s)
}

pub fn stats_dist_laplace_series_var(s : StatsdistlaplaceSeries) -> Double {
  let n = stats_dist_laplace_series_len(s)
  if n == 0 { 0.0 } else {
    let m = stats_dist_laplace_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn stats_dist_laplace_series_std(s : StatsdistlaplaceSeries) -> Double { stats_dist_laplace_sqrt(stats_dist_laplace_series_var(s)) }

pub fn stats_dist_laplace_series_median(s : StatsdistlaplaceSeries) -> Double {
  let n = stats_dist_laplace_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = stats_dist_laplace_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn stats_dist_laplace_series_scale(s : StatsdistlaplaceSeries, f : Double) -> StatsdistlaplaceSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = stats_dist_laplace_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn stats_dist_laplace_series_add(a : StatsdistlaplaceSeries, b : StatsdistlaplaceSeries) -> StatsdistlaplaceSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = stats_dist_laplace_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn stats_dist_laplace_series_sub(a : StatsdistlaplaceSeries, b : StatsdistlaplaceSeries) -> StatsdistlaplaceSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = stats_dist_laplace_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn stats_dist_laplace_series_normalize(s : StatsdistlaplaceSeries) -> StatsdistlaplaceSeries {
  let mn = stats_dist_laplace_series_min(s)
  let mx = stats_dist_laplace_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = stats_dist_laplace_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn stats_dist_laplace_series_cumsum(s : StatsdistlaplaceSeries) -> StatsdistlaplaceSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = stats_dist_laplace_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn stats_dist_laplace_series_to_string(s : StatsdistlaplaceSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + stats_dist_laplace_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct StatsdistlaplaceMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn stats_dist_laplace_make_matrix(rows : Int, cols : Int, val : Double) -> StatsdistlaplaceMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn stats_dist_laplace_matrix_identity(n : Int) -> StatsdistlaplaceMatrix {
  let m = stats_dist_laplace_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn stats_dist_laplace_matrix_get(m : StatsdistlaplaceMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn stats_dist_laplace_matrix_transpose(m : StatsdistlaplaceMatrix) -> StatsdistlaplaceMatrix {
  let result = stats_dist_laplace_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn stats_dist_laplace_matrix_add(a : StatsdistlaplaceMatrix, b : StatsdistlaplaceMatrix) -> StatsdistlaplaceMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = stats_dist_laplace_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn stats_dist_laplace_matrix_scale(m : StatsdistlaplaceMatrix, s : Double) -> StatsdistlaplaceMatrix {
  let result = stats_dist_laplace_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn stats_dist_laplace_matrix_multiply(a : StatsdistlaplaceMatrix, b : StatsdistlaplaceMatrix) -> StatsdistlaplaceMatrix {
  if a.cols != b.rows { return stats_dist_laplace_make_matrix(a.rows, b.cols, 0.0) }
  let result = stats_dist_laplace_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn stats_dist_laplace_matrix_trace(m : StatsdistlaplaceMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn stats_dist_laplace_matrix_det(m : StatsdistlaplaceMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn stats_dist_laplace_matrix_norm(m : StatsdistlaplaceMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  stats_dist_laplace_sqrt(sum)
}

pub fn stats_dist_laplace_matrix_to_string(m : StatsdistlaplaceMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + stats_dist_laplace_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct StatsdistlaplaceVector {
  comps : Array[Double]
  dim : Int
}

pub fn stats_dist_laplace_make_vector(comps : Array[Double]) -> StatsdistlaplaceVector {
  { comps, dim: comps.length() }
}

pub fn stats_dist_laplace_vector_zero(dim : Int) -> StatsdistlaplaceVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn stats_dist_laplace_vector_add(a : StatsdistlaplaceVector, b : StatsdistlaplaceVector) -> StatsdistlaplaceVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = stats_dist_laplace_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn stats_dist_laplace_vector_sub(a : StatsdistlaplaceVector, b : StatsdistlaplaceVector) -> StatsdistlaplaceVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = stats_dist_laplace_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn stats_dist_laplace_vector_scale(v : StatsdistlaplaceVector, s : Double) -> StatsdistlaplaceVector {
  let mut result = []
  for i in 0..<v.dim { result = stats_dist_laplace_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn stats_dist_laplace_vector_dot(a : StatsdistlaplaceVector, b : StatsdistlaplaceVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn stats_dist_laplace_vector_norm(v : StatsdistlaplaceVector) -> Double { stats_dist_laplace_sqrt(stats_dist_laplace_vector_dot(v, v)) }

pub fn stats_dist_laplace_vector_normalize(v : StatsdistlaplaceVector) -> StatsdistlaplaceVector {
  let n = stats_dist_laplace_vector_norm(v)
  if n < 0.0000001 { v } else { stats_dist_laplace_vector_scale(v, 1.0 / n) }
}

pub fn stats_dist_laplace_vector_dist(a : StatsdistlaplaceVector, b : StatsdistlaplaceVector) -> Double {
  stats_dist_laplace_vector_norm(stats_dist_laplace_vector_sub(a, b))
}

pub fn stats_dist_laplace_vector_to_string(v : StatsdistlaplaceVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + stats_dist_laplace_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn stats_dist_laplace_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn stats_dist_laplace_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = stats_dist_laplace_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn stats_dist_laplace_std(data : Array[Double]) -> Double { stats_dist_laplace_sqrt(stats_dist_laplace_var(data)) }

pub fn stats_dist_laplace_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = stats_dist_laplace_mean(a); let mb = stats_dist_laplace_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn stats_dist_laplace_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = stats_dist_laplace_std(a); let sb = stats_dist_laplace_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { stats_dist_laplace_cov(a, b) / (sa * sb) }
}

pub fn stats_dist_laplace_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = stats_dist_laplace_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn stats_dist_laplace_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn stats_dist_laplace_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn stats_dist_laplace_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  stats_dist_laplace_sqrt(stats_dist_laplace_mse(pred, labels))
}

pub fn stats_dist_laplace_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + stats_dist_laplace_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn stats_dist_laplace_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = stats_dist_laplace_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn stats_dist_laplace_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn stats_dist_laplace_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn stats_dist_laplace_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = stats_dist_laplace_precision(pred, labels, pos); let r = stats_dist_laplace_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn stats_dist_laplace_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn stats_dist_laplace_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = stats_dist_laplace_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn stats_dist_laplace_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn stats_dist_laplace_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn stats_dist_laplace_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = stats_dist_laplace_gcd(a, b)
    (a / g) * b
  }
}

pub fn stats_dist_laplace_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn stats_dist_laplace_fibonacci(n : Int) -> Int {
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

pub fn stats_dist_laplace_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = stats_dist_laplace_min(data); let mx = stats_dist_laplace_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn stats_dist_laplace_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = stats_dist_laplace_mean(data); let sd = stats_dist_laplace_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn stats_dist_laplace_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn stats_dist_laplace_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn stats_dist_laplace_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn stats_dist_laplace_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn stats_dist_laplace_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn stats_dist_laplace_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn stats_dist_laplace_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn stats_dist_laplace_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn stats_dist_laplace_dbl(x : Double) -> String {
  let i = if x >= 0.0 { stats_dist_laplace_int(x) } else { -stats_dist_laplace_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { stats_dist_laplace_int(f * 1000000.0) } else { stats_dist_laplace_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn stats_dist_laplace_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn stats_dist_laplace_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct StatsdistlaplaceFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_laplace_frame_make(size : Int) -> StatsdistlaplaceFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_laplace_frame_len(s : StatsdistlaplaceFrame) -> Int { s.size }

pub fn stats_dist_laplace_frame_get(s : StatsdistlaplaceFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_laplace_frame_set(s : StatsdistlaplaceFrame, i : Int, v : Double) -> StatsdistlaplaceFrame {
  let result = stats_dist_laplace_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_laplace_frame_sum(s : StatsdistlaplaceFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_laplace_frame_mean(s : StatsdistlaplaceFrame) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_laplace_frame_sum(s) / s.size.to_double() }
}

pub fn stats_dist_laplace_frame_scale(s : StatsdistlaplaceFrame, f : Double) -> StatsdistlaplaceFrame {
  let result = stats_dist_laplace_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_laplace_frame_add(a : StatsdistlaplaceFrame, b : StatsdistlaplaceFrame) -> StatsdistlaplaceFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_laplace_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_laplace_frame_copy(s : StatsdistlaplaceFrame) -> StatsdistlaplaceFrame {
  let result = stats_dist_laplace_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_laplace_frame_fill(s : StatsdistlaplaceFrame, v : Double) -> StatsdistlaplaceFrame {
  let result = stats_dist_laplace_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_laplace_frame_min(s : StatsdistlaplaceFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_laplace_frame_max(s : StatsdistlaplaceFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_laplace_frame_to_string(s : StatsdistlaplaceFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistlaplaceTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_laplace_table_make(size : Int) -> StatsdistlaplaceTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_laplace_table_len(s : StatsdistlaplaceTable) -> Int { s.size }

pub fn stats_dist_laplace_table_get(s : StatsdistlaplaceTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_laplace_table_set(s : StatsdistlaplaceTable, i : Int, v : Double) -> StatsdistlaplaceTable {
  let result = stats_dist_laplace_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_laplace_table_sum(s : StatsdistlaplaceTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_laplace_table_mean(s : StatsdistlaplaceTable) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_laplace_table_sum(s) / s.size.to_double() }
}

pub fn stats_dist_laplace_table_scale(s : StatsdistlaplaceTable, f : Double) -> StatsdistlaplaceTable {
  let result = stats_dist_laplace_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_laplace_table_add(a : StatsdistlaplaceTable, b : StatsdistlaplaceTable) -> StatsdistlaplaceTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_laplace_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_laplace_table_copy(s : StatsdistlaplaceTable) -> StatsdistlaplaceTable {
  let result = stats_dist_laplace_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_laplace_table_fill(s : StatsdistlaplaceTable, v : Double) -> StatsdistlaplaceTable {
  let result = stats_dist_laplace_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_laplace_table_min(s : StatsdistlaplaceTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_laplace_table_max(s : StatsdistlaplaceTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_laplace_table_to_string(s : StatsdistlaplaceTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistlaplaceGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_laplace_graphn_make(size : Int) -> StatsdistlaplaceGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_laplace_graphn_len(s : StatsdistlaplaceGraphN) -> Int { s.size }

pub fn stats_dist_laplace_graphn_get(s : StatsdistlaplaceGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_laplace_graphn_set(s : StatsdistlaplaceGraphN, i : Int, v : Double) -> StatsdistlaplaceGraphN {
  let result = stats_dist_laplace_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_laplace_graphn_sum(s : StatsdistlaplaceGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_laplace_graphn_mean(s : StatsdistlaplaceGraphN) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_laplace_graphn_sum(s) / s.size.to_double() }
}

pub fn stats_dist_laplace_graphn_scale(s : StatsdistlaplaceGraphN, f : Double) -> StatsdistlaplaceGraphN {
  let result = stats_dist_laplace_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_laplace_graphn_add(a : StatsdistlaplaceGraphN, b : StatsdistlaplaceGraphN) -> StatsdistlaplaceGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_laplace_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_laplace_graphn_copy(s : StatsdistlaplaceGraphN) -> StatsdistlaplaceGraphN {
  let result = stats_dist_laplace_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_laplace_graphn_fill(s : StatsdistlaplaceGraphN, v : Double) -> StatsdistlaplaceGraphN {
  let result = stats_dist_laplace_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_laplace_graphn_min(s : StatsdistlaplaceGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_laplace_graphn_max(s : StatsdistlaplaceGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_laplace_graphn_to_string(s : StatsdistlaplaceGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistlaplaceNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_laplace_node_make(size : Int) -> StatsdistlaplaceNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_laplace_node_len(s : StatsdistlaplaceNode) -> Int { s.size }

pub fn stats_dist_laplace_node_get(s : StatsdistlaplaceNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_laplace_node_set(s : StatsdistlaplaceNode, i : Int, v : Double) -> StatsdistlaplaceNode {
  let result = stats_dist_laplace_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_laplace_node_sum(s : StatsdistlaplaceNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_laplace_node_mean(s : StatsdistlaplaceNode) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_laplace_node_sum(s) / s.size.to_double() }
}

pub fn stats_dist_laplace_node_scale(s : StatsdistlaplaceNode, f : Double) -> StatsdistlaplaceNode {
  let result = stats_dist_laplace_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_laplace_node_add(a : StatsdistlaplaceNode, b : StatsdistlaplaceNode) -> StatsdistlaplaceNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_laplace_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_laplace_node_copy(s : StatsdistlaplaceNode) -> StatsdistlaplaceNode {
  let result = stats_dist_laplace_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_laplace_node_fill(s : StatsdistlaplaceNode, v : Double) -> StatsdistlaplaceNode {
  let result = stats_dist_laplace_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_laplace_node_min(s : StatsdistlaplaceNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_laplace_node_max(s : StatsdistlaplaceNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_laplace_node_to_string(s : StatsdistlaplaceNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistlaplaceEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_laplace_edge_make(size : Int) -> StatsdistlaplaceEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_laplace_edge_len(s : StatsdistlaplaceEdge) -> Int { s.size }

pub fn stats_dist_laplace_edge_get(s : StatsdistlaplaceEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_laplace_edge_set(s : StatsdistlaplaceEdge, i : Int, v : Double) -> StatsdistlaplaceEdge {
  let result = stats_dist_laplace_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_laplace_edge_sum(s : StatsdistlaplaceEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_laplace_edge_mean(s : StatsdistlaplaceEdge) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_laplace_edge_sum(s) / s.size.to_double() }
}

pub fn stats_dist_laplace_edge_scale(s : StatsdistlaplaceEdge, f : Double) -> StatsdistlaplaceEdge {
  let result = stats_dist_laplace_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_laplace_edge_add(a : StatsdistlaplaceEdge, b : StatsdistlaplaceEdge) -> StatsdistlaplaceEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_laplace_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_laplace_edge_copy(s : StatsdistlaplaceEdge) -> StatsdistlaplaceEdge {
  let result = stats_dist_laplace_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_laplace_edge_fill(s : StatsdistlaplaceEdge, v : Double) -> StatsdistlaplaceEdge {
  let result = stats_dist_laplace_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_laplace_edge_min(s : StatsdistlaplaceEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_laplace_edge_max(s : StatsdistlaplaceEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_laplace_edge_to_string(s : StatsdistlaplaceEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistlaplacePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_laplace_path_make(size : Int) -> StatsdistlaplacePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_laplace_path_len(s : StatsdistlaplacePath) -> Int { s.size }

pub fn stats_dist_laplace_path_get(s : StatsdistlaplacePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_laplace_path_set(s : StatsdistlaplacePath, i : Int, v : Double) -> StatsdistlaplacePath {
  let result = stats_dist_laplace_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_laplace_path_sum(s : StatsdistlaplacePath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_laplace_path_mean(s : StatsdistlaplacePath) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_laplace_path_sum(s) / s.size.to_double() }
}

pub fn stats_dist_laplace_path_scale(s : StatsdistlaplacePath, f : Double) -> StatsdistlaplacePath {
  let result = stats_dist_laplace_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_laplace_path_add(a : StatsdistlaplacePath, b : StatsdistlaplacePath) -> StatsdistlaplacePath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_laplace_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_laplace_path_copy(s : StatsdistlaplacePath) -> StatsdistlaplacePath {
  let result = stats_dist_laplace_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_laplace_path_fill(s : StatsdistlaplacePath, v : Double) -> StatsdistlaplacePath {
  let result = stats_dist_laplace_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_laplace_path_min(s : StatsdistlaplacePath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_laplace_path_max(s : StatsdistlaplacePath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_laplace_path_to_string(s : StatsdistlaplacePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistlaplaceCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_laplace_cluster_make(size : Int) -> StatsdistlaplaceCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_laplace_cluster_len(s : StatsdistlaplaceCluster) -> Int { s.size }

pub fn stats_dist_laplace_cluster_get(s : StatsdistlaplaceCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_laplace_cluster_set(s : StatsdistlaplaceCluster, i : Int, v : Double) -> StatsdistlaplaceCluster {
  let result = stats_dist_laplace_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_laplace_cluster_sum(s : StatsdistlaplaceCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_laplace_cluster_mean(s : StatsdistlaplaceCluster) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_laplace_cluster_sum(s) / s.size.to_double() }
}

pub fn stats_dist_laplace_cluster_scale(s : StatsdistlaplaceCluster, f : Double) -> StatsdistlaplaceCluster {
  let result = stats_dist_laplace_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_laplace_cluster_add(a : StatsdistlaplaceCluster, b : StatsdistlaplaceCluster) -> StatsdistlaplaceCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_laplace_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_laplace_cluster_copy(s : StatsdistlaplaceCluster) -> StatsdistlaplaceCluster {
  let result = stats_dist_laplace_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_laplace_cluster_fill(s : StatsdistlaplaceCluster, v : Double) -> StatsdistlaplaceCluster {
  let result = stats_dist_laplace_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_laplace_cluster_min(s : StatsdistlaplaceCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_laplace_cluster_max(s : StatsdistlaplaceCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_laplace_cluster_to_string(s : StatsdistlaplaceCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistlaplaceModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_laplace_model_make(size : Int) -> StatsdistlaplaceModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_laplace_model_len(s : StatsdistlaplaceModel) -> Int { s.size }

pub fn stats_dist_laplace_model_get(s : StatsdistlaplaceModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_laplace_model_set(s : StatsdistlaplaceModel, i : Int, v : Double) -> StatsdistlaplaceModel {
  let result = stats_dist_laplace_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_laplace_model_sum(s : StatsdistlaplaceModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_laplace_model_mean(s : StatsdistlaplaceModel) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_laplace_model_sum(s) / s.size.to_double() }
}

pub fn stats_dist_laplace_model_scale(s : StatsdistlaplaceModel, f : Double) -> StatsdistlaplaceModel {
  let result = stats_dist_laplace_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_laplace_model_add(a : StatsdistlaplaceModel, b : StatsdistlaplaceModel) -> StatsdistlaplaceModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_laplace_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_laplace_model_copy(s : StatsdistlaplaceModel) -> StatsdistlaplaceModel {
  let result = stats_dist_laplace_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_laplace_model_fill(s : StatsdistlaplaceModel, v : Double) -> StatsdistlaplaceModel {
  let result = stats_dist_laplace_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_laplace_model_min(s : StatsdistlaplaceModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_laplace_model_max(s : StatsdistlaplaceModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_laplace_model_to_string(s : StatsdistlaplaceModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistlaplaceLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_laplace_layer_make(size : Int) -> StatsdistlaplaceLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_laplace_layer_len(s : StatsdistlaplaceLayer) -> Int { s.size }

pub fn stats_dist_laplace_layer_get(s : StatsdistlaplaceLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_laplace_layer_set(s : StatsdistlaplaceLayer, i : Int, v : Double) -> StatsdistlaplaceLayer {
  let result = stats_dist_laplace_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_laplace_layer_sum(s : StatsdistlaplaceLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_laplace_layer_mean(s : StatsdistlaplaceLayer) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_laplace_layer_sum(s) / s.size.to_double() }
}

pub fn stats_dist_laplace_layer_scale(s : StatsdistlaplaceLayer, f : Double) -> StatsdistlaplaceLayer {
  let result = stats_dist_laplace_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_laplace_layer_add(a : StatsdistlaplaceLayer, b : StatsdistlaplaceLayer) -> StatsdistlaplaceLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_laplace_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_laplace_layer_copy(s : StatsdistlaplaceLayer) -> StatsdistlaplaceLayer {
  let result = stats_dist_laplace_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_laplace_layer_fill(s : StatsdistlaplaceLayer, v : Double) -> StatsdistlaplaceLayer {
  let result = stats_dist_laplace_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_laplace_layer_min(s : StatsdistlaplaceLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_laplace_layer_max(s : StatsdistlaplaceLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_laplace_layer_to_string(s : StatsdistlaplaceLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistlaplaceBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_laplace_buffer_make(size : Int) -> StatsdistlaplaceBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_laplace_buffer_len(s : StatsdistlaplaceBuffer) -> Int { s.size }

pub fn stats_dist_laplace_buffer_get(s : StatsdistlaplaceBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_laplace_buffer_set(s : StatsdistlaplaceBuffer, i : Int, v : Double) -> StatsdistlaplaceBuffer {
  let result = stats_dist_laplace_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_laplace_buffer_sum(s : StatsdistlaplaceBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_laplace_buffer_mean(s : StatsdistlaplaceBuffer) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_laplace_buffer_sum(s) / s.size.to_double() }
}

pub fn stats_dist_laplace_buffer_scale(s : StatsdistlaplaceBuffer, f : Double) -> StatsdistlaplaceBuffer {
  let result = stats_dist_laplace_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_laplace_buffer_add(a : StatsdistlaplaceBuffer, b : StatsdistlaplaceBuffer) -> StatsdistlaplaceBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_laplace_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_laplace_buffer_copy(s : StatsdistlaplaceBuffer) -> StatsdistlaplaceBuffer {
  let result = stats_dist_laplace_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_laplace_buffer_fill(s : StatsdistlaplaceBuffer, v : Double) -> StatsdistlaplaceBuffer {
  let result = stats_dist_laplace_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_laplace_buffer_min(s : StatsdistlaplaceBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_laplace_buffer_max(s : StatsdistlaplaceBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_laplace_buffer_to_string(s : StatsdistlaplaceBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistlaplaceCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_laplace_cursor_make(size : Int) -> StatsdistlaplaceCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_laplace_cursor_len(s : StatsdistlaplaceCursor) -> Int { s.size }

pub fn stats_dist_laplace_cursor_get(s : StatsdistlaplaceCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_laplace_cursor_set(s : StatsdistlaplaceCursor, i : Int, v : Double) -> StatsdistlaplaceCursor {
  let result = stats_dist_laplace_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_laplace_cursor_sum(s : StatsdistlaplaceCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_laplace_cursor_mean(s : StatsdistlaplaceCursor) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_laplace_cursor_sum(s) / s.size.to_double() }
}

pub fn stats_dist_laplace_cursor_scale(s : StatsdistlaplaceCursor, f : Double) -> StatsdistlaplaceCursor {
  let result = stats_dist_laplace_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_laplace_cursor_add(a : StatsdistlaplaceCursor, b : StatsdistlaplaceCursor) -> StatsdistlaplaceCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_laplace_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_laplace_cursor_copy(s : StatsdistlaplaceCursor) -> StatsdistlaplaceCursor {
  let result = stats_dist_laplace_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_laplace_cursor_fill(s : StatsdistlaplaceCursor, v : Double) -> StatsdistlaplaceCursor {
  let result = stats_dist_laplace_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_laplace_cursor_min(s : StatsdistlaplaceCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_laplace_cursor_max(s : StatsdistlaplaceCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_laplace_cursor_to_string(s : StatsdistlaplaceCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistlaplaceView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_laplace_view_make(size : Int) -> StatsdistlaplaceView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_laplace_view_len(s : StatsdistlaplaceView) -> Int { s.size }

pub fn stats_dist_laplace_view_get(s : StatsdistlaplaceView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_laplace_view_set(s : StatsdistlaplaceView, i : Int, v : Double) -> StatsdistlaplaceView {
  let result = stats_dist_laplace_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_laplace_view_sum(s : StatsdistlaplaceView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_laplace_view_mean(s : StatsdistlaplaceView) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_laplace_view_sum(s) / s.size.to_double() }
}

pub fn stats_dist_laplace_view_scale(s : StatsdistlaplaceView, f : Double) -> StatsdistlaplaceView {
  let result = stats_dist_laplace_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_laplace_view_add(a : StatsdistlaplaceView, b : StatsdistlaplaceView) -> StatsdistlaplaceView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_laplace_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_laplace_view_copy(s : StatsdistlaplaceView) -> StatsdistlaplaceView {
  let result = stats_dist_laplace_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_laplace_view_fill(s : StatsdistlaplaceView, v : Double) -> StatsdistlaplaceView {
  let result = stats_dist_laplace_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_laplace_view_min(s : StatsdistlaplaceView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_laplace_view_max(s : StatsdistlaplaceView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_laplace_view_to_string(s : StatsdistlaplaceView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistlaplaceRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_laplace_range_make(size : Int) -> StatsdistlaplaceRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_laplace_range_len(s : StatsdistlaplaceRange) -> Int { s.size }

pub fn stats_dist_laplace_range_get(s : StatsdistlaplaceRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_laplace_range_set(s : StatsdistlaplaceRange, i : Int, v : Double) -> StatsdistlaplaceRange {
  let result = stats_dist_laplace_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_laplace_range_sum(s : StatsdistlaplaceRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_laplace_range_mean(s : StatsdistlaplaceRange) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_laplace_range_sum(s) / s.size.to_double() }
}

pub fn stats_dist_laplace_range_scale(s : StatsdistlaplaceRange, f : Double) -> StatsdistlaplaceRange {
  let result = stats_dist_laplace_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_laplace_range_add(a : StatsdistlaplaceRange, b : StatsdistlaplaceRange) -> StatsdistlaplaceRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_laplace_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_laplace_range_copy(s : StatsdistlaplaceRange) -> StatsdistlaplaceRange {
  let result = stats_dist_laplace_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_laplace_range_fill(s : StatsdistlaplaceRange, v : Double) -> StatsdistlaplaceRange {
  let result = stats_dist_laplace_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_laplace_range_min(s : StatsdistlaplaceRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_laplace_range_max(s : StatsdistlaplaceRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_laplace_range_to_string(s : StatsdistlaplaceRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistlaplaceSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_laplace_slice_make(size : Int) -> StatsdistlaplaceSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_laplace_slice_len(s : StatsdistlaplaceSlice) -> Int { s.size }

pub fn stats_dist_laplace_slice_get(s : StatsdistlaplaceSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_laplace_slice_set(s : StatsdistlaplaceSlice, i : Int, v : Double) -> StatsdistlaplaceSlice {
  let result = stats_dist_laplace_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_laplace_slice_sum(s : StatsdistlaplaceSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_laplace_slice_mean(s : StatsdistlaplaceSlice) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_laplace_slice_sum(s) / s.size.to_double() }
}

pub fn stats_dist_laplace_slice_scale(s : StatsdistlaplaceSlice, f : Double) -> StatsdistlaplaceSlice {
  let result = stats_dist_laplace_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_laplace_slice_add(a : StatsdistlaplaceSlice, b : StatsdistlaplaceSlice) -> StatsdistlaplaceSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_laplace_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_laplace_slice_copy(s : StatsdistlaplaceSlice) -> StatsdistlaplaceSlice {
  let result = stats_dist_laplace_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_laplace_slice_fill(s : StatsdistlaplaceSlice, v : Double) -> StatsdistlaplaceSlice {
  let result = stats_dist_laplace_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_laplace_slice_min(s : StatsdistlaplaceSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_laplace_slice_max(s : StatsdistlaplaceSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_laplace_slice_to_string(s : StatsdistlaplaceSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn stats_dist_laplace_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_dist_laplace_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_dist_laplace_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_dist_laplace_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_dist_laplace_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_dist_laplace_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_dist_laplace_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_dist_laplace_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_dist_laplace_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_dist_laplace_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_dist_laplace_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_dist_laplace_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_dist_laplace_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_dist_laplace_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_dist_laplace_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_dist_laplace_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_dist_laplace_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_dist_laplace_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_dist_laplace_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_dist_laplace_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_dist_laplace_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_dist_laplace_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_dist_laplace_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_dist_laplace_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_dist_laplace_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

