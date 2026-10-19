///===
/// extcore/stats_dist_hypergeo

pub(all) struct StatsdisthypergeoPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn stats_dist_hypergeo_make_point(x : Double, y : Double) -> StatsdisthypergeoPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn stats_dist_hypergeo_make_point3(x : Double, y : Double, z : Double) -> StatsdisthypergeoPoint {
  { x, y, z, label: 0 }
}

pub fn stats_dist_hypergeo_point_x(pt : StatsdisthypergeoPoint) -> Double { pt.x }

pub fn stats_dist_hypergeo_point_y(pt : StatsdisthypergeoPoint) -> Double { pt.y }

pub fn stats_dist_hypergeo_point_z(pt : StatsdisthypergeoPoint) -> Double { pt.z }

pub fn stats_dist_hypergeo_point_label(pt : StatsdisthypergeoPoint) -> Int { pt.label }

pub fn stats_dist_hypergeo_point_dist(a : StatsdisthypergeoPoint, b : StatsdisthypergeoPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  stats_dist_hypergeo_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn stats_dist_hypergeo_point_add(a : StatsdisthypergeoPoint, b : StatsdisthypergeoPoint) -> StatsdisthypergeoPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn stats_dist_hypergeo_point_sub(a : StatsdisthypergeoPoint, b : StatsdisthypergeoPoint) -> StatsdisthypergeoPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn stats_dist_hypergeo_point_scale(pt : StatsdisthypergeoPoint, s : Double) -> StatsdisthypergeoPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn stats_dist_hypergeo_point_dot(a : StatsdisthypergeoPoint, b : StatsdisthypergeoPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn stats_dist_hypergeo_point_cross(a : StatsdisthypergeoPoint, b : StatsdisthypergeoPoint) -> StatsdisthypergeoPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn stats_dist_hypergeo_point_norm(pt : StatsdisthypergeoPoint) -> Double {
  stats_dist_hypergeo_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn stats_dist_hypergeo_point_normalize(pt : StatsdisthypergeoPoint) -> StatsdisthypergeoPoint {
  let n = stats_dist_hypergeo_point_norm(pt)
  if n < 0.0000001 { pt } else { stats_dist_hypergeo_point_scale(pt, 1.0 / n) }
}

pub fn stats_dist_hypergeo_point_negate(pt : StatsdisthypergeoPoint) -> StatsdisthypergeoPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn stats_dist_hypergeo_point_mid(a : StatsdisthypergeoPoint, b : StatsdisthypergeoPoint) -> StatsdisthypergeoPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn stats_dist_hypergeo_point_lerp(a : StatsdisthypergeoPoint, b : StatsdisthypergeoPoint, t : Double) -> StatsdisthypergeoPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn stats_dist_hypergeo_point_to_string(pt : StatsdisthypergeoPoint) -> String {
  "(" + stats_dist_hypergeo_dbl(pt.x) + ", " + stats_dist_hypergeo_dbl(pt.y) + ", " + stats_dist_hypergeo_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct StatsdisthypergeoSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn stats_dist_hypergeo_make_series(vals : Array[Double], name : String) -> StatsdisthypergeoSeries {
  { vals, name, meta: 0 }
}

pub fn stats_dist_hypergeo_series_len(s : StatsdisthypergeoSeries) -> Int { s.vals.length() }

pub fn stats_dist_hypergeo_series_sum(s : StatsdisthypergeoSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn stats_dist_hypergeo_series_mean(s : StatsdisthypergeoSeries) -> Double {
  let n = stats_dist_hypergeo_series_len(s)
  if n == 0 { 0.0 } else { stats_dist_hypergeo_series_sum(s) / n.to_double() }
}

pub fn stats_dist_hypergeo_series_min(s : StatsdisthypergeoSeries) -> Double {
  let n = stats_dist_hypergeo_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn stats_dist_hypergeo_series_max(s : StatsdisthypergeoSeries) -> Double {
  let n = stats_dist_hypergeo_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn stats_dist_hypergeo_series_range(s : StatsdisthypergeoSeries) -> Double {
  stats_dist_hypergeo_series_max(s) - stats_dist_hypergeo_series_min(s)
}

pub fn stats_dist_hypergeo_series_var(s : StatsdisthypergeoSeries) -> Double {
  let n = stats_dist_hypergeo_series_len(s)
  if n == 0 { 0.0 } else {
    let m = stats_dist_hypergeo_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn stats_dist_hypergeo_series_std(s : StatsdisthypergeoSeries) -> Double { stats_dist_hypergeo_sqrt(stats_dist_hypergeo_series_var(s)) }

pub fn stats_dist_hypergeo_series_median(s : StatsdisthypergeoSeries) -> Double {
  let n = stats_dist_hypergeo_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = stats_dist_hypergeo_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn stats_dist_hypergeo_series_scale(s : StatsdisthypergeoSeries, f : Double) -> StatsdisthypergeoSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = stats_dist_hypergeo_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn stats_dist_hypergeo_series_add(a : StatsdisthypergeoSeries, b : StatsdisthypergeoSeries) -> StatsdisthypergeoSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = stats_dist_hypergeo_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn stats_dist_hypergeo_series_sub(a : StatsdisthypergeoSeries, b : StatsdisthypergeoSeries) -> StatsdisthypergeoSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = stats_dist_hypergeo_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn stats_dist_hypergeo_series_normalize(s : StatsdisthypergeoSeries) -> StatsdisthypergeoSeries {
  let mn = stats_dist_hypergeo_series_min(s)
  let mx = stats_dist_hypergeo_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = stats_dist_hypergeo_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn stats_dist_hypergeo_series_cumsum(s : StatsdisthypergeoSeries) -> StatsdisthypergeoSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = stats_dist_hypergeo_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn stats_dist_hypergeo_series_to_string(s : StatsdisthypergeoSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + stats_dist_hypergeo_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct StatsdisthypergeoMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn stats_dist_hypergeo_make_matrix(rows : Int, cols : Int, val : Double) -> StatsdisthypergeoMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn stats_dist_hypergeo_matrix_identity(n : Int) -> StatsdisthypergeoMatrix {
  let m = stats_dist_hypergeo_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn stats_dist_hypergeo_matrix_get(m : StatsdisthypergeoMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn stats_dist_hypergeo_matrix_transpose(m : StatsdisthypergeoMatrix) -> StatsdisthypergeoMatrix {
  let result = stats_dist_hypergeo_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn stats_dist_hypergeo_matrix_add(a : StatsdisthypergeoMatrix, b : StatsdisthypergeoMatrix) -> StatsdisthypergeoMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = stats_dist_hypergeo_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn stats_dist_hypergeo_matrix_scale(m : StatsdisthypergeoMatrix, s : Double) -> StatsdisthypergeoMatrix {
  let result = stats_dist_hypergeo_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn stats_dist_hypergeo_matrix_multiply(a : StatsdisthypergeoMatrix, b : StatsdisthypergeoMatrix) -> StatsdisthypergeoMatrix {
  if a.cols != b.rows { return stats_dist_hypergeo_make_matrix(a.rows, b.cols, 0.0) }
  let result = stats_dist_hypergeo_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn stats_dist_hypergeo_matrix_trace(m : StatsdisthypergeoMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn stats_dist_hypergeo_matrix_det(m : StatsdisthypergeoMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn stats_dist_hypergeo_matrix_norm(m : StatsdisthypergeoMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  stats_dist_hypergeo_sqrt(sum)
}

pub fn stats_dist_hypergeo_matrix_to_string(m : StatsdisthypergeoMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + stats_dist_hypergeo_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct StatsdisthypergeoVector {
  comps : Array[Double]
  dim : Int
}

pub fn stats_dist_hypergeo_make_vector(comps : Array[Double]) -> StatsdisthypergeoVector {
  { comps, dim: comps.length() }
}

pub fn stats_dist_hypergeo_vector_zero(dim : Int) -> StatsdisthypergeoVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn stats_dist_hypergeo_vector_add(a : StatsdisthypergeoVector, b : StatsdisthypergeoVector) -> StatsdisthypergeoVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = stats_dist_hypergeo_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn stats_dist_hypergeo_vector_sub(a : StatsdisthypergeoVector, b : StatsdisthypergeoVector) -> StatsdisthypergeoVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = stats_dist_hypergeo_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn stats_dist_hypergeo_vector_scale(v : StatsdisthypergeoVector, s : Double) -> StatsdisthypergeoVector {
  let mut result = []
  for i in 0..<v.dim { result = stats_dist_hypergeo_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn stats_dist_hypergeo_vector_dot(a : StatsdisthypergeoVector, b : StatsdisthypergeoVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn stats_dist_hypergeo_vector_norm(v : StatsdisthypergeoVector) -> Double { stats_dist_hypergeo_sqrt(stats_dist_hypergeo_vector_dot(v, v)) }

pub fn stats_dist_hypergeo_vector_normalize(v : StatsdisthypergeoVector) -> StatsdisthypergeoVector {
  let n = stats_dist_hypergeo_vector_norm(v)
  if n < 0.0000001 { v } else { stats_dist_hypergeo_vector_scale(v, 1.0 / n) }
}

pub fn stats_dist_hypergeo_vector_dist(a : StatsdisthypergeoVector, b : StatsdisthypergeoVector) -> Double {
  stats_dist_hypergeo_vector_norm(stats_dist_hypergeo_vector_sub(a, b))
}

pub fn stats_dist_hypergeo_vector_to_string(v : StatsdisthypergeoVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + stats_dist_hypergeo_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn stats_dist_hypergeo_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn stats_dist_hypergeo_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = stats_dist_hypergeo_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn stats_dist_hypergeo_std(data : Array[Double]) -> Double { stats_dist_hypergeo_sqrt(stats_dist_hypergeo_var(data)) }

pub fn stats_dist_hypergeo_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = stats_dist_hypergeo_mean(a); let mb = stats_dist_hypergeo_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn stats_dist_hypergeo_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = stats_dist_hypergeo_std(a); let sb = stats_dist_hypergeo_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { stats_dist_hypergeo_cov(a, b) / (sa * sb) }
}

pub fn stats_dist_hypergeo_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = stats_dist_hypergeo_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn stats_dist_hypergeo_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn stats_dist_hypergeo_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn stats_dist_hypergeo_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  stats_dist_hypergeo_sqrt(stats_dist_hypergeo_mse(pred, labels))
}

pub fn stats_dist_hypergeo_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + stats_dist_hypergeo_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn stats_dist_hypergeo_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = stats_dist_hypergeo_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn stats_dist_hypergeo_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn stats_dist_hypergeo_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn stats_dist_hypergeo_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = stats_dist_hypergeo_precision(pred, labels, pos); let r = stats_dist_hypergeo_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn stats_dist_hypergeo_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn stats_dist_hypergeo_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = stats_dist_hypergeo_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn stats_dist_hypergeo_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn stats_dist_hypergeo_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn stats_dist_hypergeo_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = stats_dist_hypergeo_gcd(a, b)
    (a / g) * b
  }
}

pub fn stats_dist_hypergeo_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn stats_dist_hypergeo_fibonacci(n : Int) -> Int {
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

pub fn stats_dist_hypergeo_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = stats_dist_hypergeo_min(data); let mx = stats_dist_hypergeo_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn stats_dist_hypergeo_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = stats_dist_hypergeo_mean(data); let sd = stats_dist_hypergeo_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn stats_dist_hypergeo_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn stats_dist_hypergeo_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn stats_dist_hypergeo_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn stats_dist_hypergeo_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn stats_dist_hypergeo_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn stats_dist_hypergeo_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn stats_dist_hypergeo_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn stats_dist_hypergeo_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn stats_dist_hypergeo_dbl(x : Double) -> String {
  let i = if x >= 0.0 { stats_dist_hypergeo_int(x) } else { -stats_dist_hypergeo_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { stats_dist_hypergeo_int(f * 1000000.0) } else { stats_dist_hypergeo_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn stats_dist_hypergeo_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn stats_dist_hypergeo_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct StatsdisthypergeoFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_hypergeo_frame_make(size : Int) -> StatsdisthypergeoFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_hypergeo_frame_len(s : StatsdisthypergeoFrame) -> Int { s.size }

pub fn stats_dist_hypergeo_frame_get(s : StatsdisthypergeoFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_hypergeo_frame_set(s : StatsdisthypergeoFrame, i : Int, v : Double) -> StatsdisthypergeoFrame {
  let result = stats_dist_hypergeo_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_hypergeo_frame_sum(s : StatsdisthypergeoFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_hypergeo_frame_mean(s : StatsdisthypergeoFrame) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_hypergeo_frame_sum(s) / s.size.to_double() }
}

pub fn stats_dist_hypergeo_frame_scale(s : StatsdisthypergeoFrame, f : Double) -> StatsdisthypergeoFrame {
  let result = stats_dist_hypergeo_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_hypergeo_frame_add(a : StatsdisthypergeoFrame, b : StatsdisthypergeoFrame) -> StatsdisthypergeoFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_hypergeo_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_hypergeo_frame_copy(s : StatsdisthypergeoFrame) -> StatsdisthypergeoFrame {
  let result = stats_dist_hypergeo_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_hypergeo_frame_fill(s : StatsdisthypergeoFrame, v : Double) -> StatsdisthypergeoFrame {
  let result = stats_dist_hypergeo_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_hypergeo_frame_min(s : StatsdisthypergeoFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_hypergeo_frame_max(s : StatsdisthypergeoFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_hypergeo_frame_to_string(s : StatsdisthypergeoFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdisthypergeoTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_hypergeo_table_make(size : Int) -> StatsdisthypergeoTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_hypergeo_table_len(s : StatsdisthypergeoTable) -> Int { s.size }

pub fn stats_dist_hypergeo_table_get(s : StatsdisthypergeoTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_hypergeo_table_set(s : StatsdisthypergeoTable, i : Int, v : Double) -> StatsdisthypergeoTable {
  let result = stats_dist_hypergeo_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_hypergeo_table_sum(s : StatsdisthypergeoTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_hypergeo_table_mean(s : StatsdisthypergeoTable) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_hypergeo_table_sum(s) / s.size.to_double() }
}

pub fn stats_dist_hypergeo_table_scale(s : StatsdisthypergeoTable, f : Double) -> StatsdisthypergeoTable {
  let result = stats_dist_hypergeo_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_hypergeo_table_add(a : StatsdisthypergeoTable, b : StatsdisthypergeoTable) -> StatsdisthypergeoTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_hypergeo_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_hypergeo_table_copy(s : StatsdisthypergeoTable) -> StatsdisthypergeoTable {
  let result = stats_dist_hypergeo_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_hypergeo_table_fill(s : StatsdisthypergeoTable, v : Double) -> StatsdisthypergeoTable {
  let result = stats_dist_hypergeo_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_hypergeo_table_min(s : StatsdisthypergeoTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_hypergeo_table_max(s : StatsdisthypergeoTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_hypergeo_table_to_string(s : StatsdisthypergeoTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdisthypergeoGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_hypergeo_graphn_make(size : Int) -> StatsdisthypergeoGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_hypergeo_graphn_len(s : StatsdisthypergeoGraphN) -> Int { s.size }

pub fn stats_dist_hypergeo_graphn_get(s : StatsdisthypergeoGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_hypergeo_graphn_set(s : StatsdisthypergeoGraphN, i : Int, v : Double) -> StatsdisthypergeoGraphN {
  let result = stats_dist_hypergeo_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_hypergeo_graphn_sum(s : StatsdisthypergeoGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_hypergeo_graphn_mean(s : StatsdisthypergeoGraphN) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_hypergeo_graphn_sum(s) / s.size.to_double() }
}

pub fn stats_dist_hypergeo_graphn_scale(s : StatsdisthypergeoGraphN, f : Double) -> StatsdisthypergeoGraphN {
  let result = stats_dist_hypergeo_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_hypergeo_graphn_add(a : StatsdisthypergeoGraphN, b : StatsdisthypergeoGraphN) -> StatsdisthypergeoGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_hypergeo_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_hypergeo_graphn_copy(s : StatsdisthypergeoGraphN) -> StatsdisthypergeoGraphN {
  let result = stats_dist_hypergeo_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_hypergeo_graphn_fill(s : StatsdisthypergeoGraphN, v : Double) -> StatsdisthypergeoGraphN {
  let result = stats_dist_hypergeo_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_hypergeo_graphn_min(s : StatsdisthypergeoGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_hypergeo_graphn_max(s : StatsdisthypergeoGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_hypergeo_graphn_to_string(s : StatsdisthypergeoGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdisthypergeoNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_hypergeo_node_make(size : Int) -> StatsdisthypergeoNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_hypergeo_node_len(s : StatsdisthypergeoNode) -> Int { s.size }

pub fn stats_dist_hypergeo_node_get(s : StatsdisthypergeoNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_hypergeo_node_set(s : StatsdisthypergeoNode, i : Int, v : Double) -> StatsdisthypergeoNode {
  let result = stats_dist_hypergeo_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_hypergeo_node_sum(s : StatsdisthypergeoNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_hypergeo_node_mean(s : StatsdisthypergeoNode) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_hypergeo_node_sum(s) / s.size.to_double() }
}

pub fn stats_dist_hypergeo_node_scale(s : StatsdisthypergeoNode, f : Double) -> StatsdisthypergeoNode {
  let result = stats_dist_hypergeo_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_hypergeo_node_add(a : StatsdisthypergeoNode, b : StatsdisthypergeoNode) -> StatsdisthypergeoNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_hypergeo_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_hypergeo_node_copy(s : StatsdisthypergeoNode) -> StatsdisthypergeoNode {
  let result = stats_dist_hypergeo_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_hypergeo_node_fill(s : StatsdisthypergeoNode, v : Double) -> StatsdisthypergeoNode {
  let result = stats_dist_hypergeo_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_hypergeo_node_min(s : StatsdisthypergeoNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_hypergeo_node_max(s : StatsdisthypergeoNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_hypergeo_node_to_string(s : StatsdisthypergeoNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdisthypergeoEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_hypergeo_edge_make(size : Int) -> StatsdisthypergeoEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_hypergeo_edge_len(s : StatsdisthypergeoEdge) -> Int { s.size }

pub fn stats_dist_hypergeo_edge_get(s : StatsdisthypergeoEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_hypergeo_edge_set(s : StatsdisthypergeoEdge, i : Int, v : Double) -> StatsdisthypergeoEdge {
  let result = stats_dist_hypergeo_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_hypergeo_edge_sum(s : StatsdisthypergeoEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_hypergeo_edge_mean(s : StatsdisthypergeoEdge) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_hypergeo_edge_sum(s) / s.size.to_double() }
}

pub fn stats_dist_hypergeo_edge_scale(s : StatsdisthypergeoEdge, f : Double) -> StatsdisthypergeoEdge {
  let result = stats_dist_hypergeo_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_hypergeo_edge_add(a : StatsdisthypergeoEdge, b : StatsdisthypergeoEdge) -> StatsdisthypergeoEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_hypergeo_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_hypergeo_edge_copy(s : StatsdisthypergeoEdge) -> StatsdisthypergeoEdge {
  let result = stats_dist_hypergeo_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_hypergeo_edge_fill(s : StatsdisthypergeoEdge, v : Double) -> StatsdisthypergeoEdge {
  let result = stats_dist_hypergeo_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_hypergeo_edge_min(s : StatsdisthypergeoEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_hypergeo_edge_max(s : StatsdisthypergeoEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_hypergeo_edge_to_string(s : StatsdisthypergeoEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdisthypergeoPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_hypergeo_path_make(size : Int) -> StatsdisthypergeoPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_hypergeo_path_len(s : StatsdisthypergeoPath) -> Int { s.size }

pub fn stats_dist_hypergeo_path_get(s : StatsdisthypergeoPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_hypergeo_path_set(s : StatsdisthypergeoPath, i : Int, v : Double) -> StatsdisthypergeoPath {
  let result = stats_dist_hypergeo_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_hypergeo_path_sum(s : StatsdisthypergeoPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_hypergeo_path_mean(s : StatsdisthypergeoPath) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_hypergeo_path_sum(s) / s.size.to_double() }
}

pub fn stats_dist_hypergeo_path_scale(s : StatsdisthypergeoPath, f : Double) -> StatsdisthypergeoPath {
  let result = stats_dist_hypergeo_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_hypergeo_path_add(a : StatsdisthypergeoPath, b : StatsdisthypergeoPath) -> StatsdisthypergeoPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_hypergeo_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_hypergeo_path_copy(s : StatsdisthypergeoPath) -> StatsdisthypergeoPath {
  let result = stats_dist_hypergeo_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_hypergeo_path_fill(s : StatsdisthypergeoPath, v : Double) -> StatsdisthypergeoPath {
  let result = stats_dist_hypergeo_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_hypergeo_path_min(s : StatsdisthypergeoPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_hypergeo_path_max(s : StatsdisthypergeoPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_hypergeo_path_to_string(s : StatsdisthypergeoPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdisthypergeoCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_hypergeo_cluster_make(size : Int) -> StatsdisthypergeoCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_hypergeo_cluster_len(s : StatsdisthypergeoCluster) -> Int { s.size }

pub fn stats_dist_hypergeo_cluster_get(s : StatsdisthypergeoCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_hypergeo_cluster_set(s : StatsdisthypergeoCluster, i : Int, v : Double) -> StatsdisthypergeoCluster {
  let result = stats_dist_hypergeo_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_hypergeo_cluster_sum(s : StatsdisthypergeoCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_hypergeo_cluster_mean(s : StatsdisthypergeoCluster) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_hypergeo_cluster_sum(s) / s.size.to_double() }
}

pub fn stats_dist_hypergeo_cluster_scale(s : StatsdisthypergeoCluster, f : Double) -> StatsdisthypergeoCluster {
  let result = stats_dist_hypergeo_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_hypergeo_cluster_add(a : StatsdisthypergeoCluster, b : StatsdisthypergeoCluster) -> StatsdisthypergeoCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_hypergeo_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_hypergeo_cluster_copy(s : StatsdisthypergeoCluster) -> StatsdisthypergeoCluster {
  let result = stats_dist_hypergeo_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_hypergeo_cluster_fill(s : StatsdisthypergeoCluster, v : Double) -> StatsdisthypergeoCluster {
  let result = stats_dist_hypergeo_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_hypergeo_cluster_min(s : StatsdisthypergeoCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_hypergeo_cluster_max(s : StatsdisthypergeoCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_hypergeo_cluster_to_string(s : StatsdisthypergeoCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdisthypergeoModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_hypergeo_model_make(size : Int) -> StatsdisthypergeoModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_hypergeo_model_len(s : StatsdisthypergeoModel) -> Int { s.size }

pub fn stats_dist_hypergeo_model_get(s : StatsdisthypergeoModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_hypergeo_model_set(s : StatsdisthypergeoModel, i : Int, v : Double) -> StatsdisthypergeoModel {
  let result = stats_dist_hypergeo_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_hypergeo_model_sum(s : StatsdisthypergeoModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_hypergeo_model_mean(s : StatsdisthypergeoModel) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_hypergeo_model_sum(s) / s.size.to_double() }
}

pub fn stats_dist_hypergeo_model_scale(s : StatsdisthypergeoModel, f : Double) -> StatsdisthypergeoModel {
  let result = stats_dist_hypergeo_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_hypergeo_model_add(a : StatsdisthypergeoModel, b : StatsdisthypergeoModel) -> StatsdisthypergeoModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_hypergeo_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_hypergeo_model_copy(s : StatsdisthypergeoModel) -> StatsdisthypergeoModel {
  let result = stats_dist_hypergeo_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_hypergeo_model_fill(s : StatsdisthypergeoModel, v : Double) -> StatsdisthypergeoModel {
  let result = stats_dist_hypergeo_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_hypergeo_model_min(s : StatsdisthypergeoModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_hypergeo_model_max(s : StatsdisthypergeoModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_hypergeo_model_to_string(s : StatsdisthypergeoModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdisthypergeoLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_hypergeo_layer_make(size : Int) -> StatsdisthypergeoLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_hypergeo_layer_len(s : StatsdisthypergeoLayer) -> Int { s.size }

pub fn stats_dist_hypergeo_layer_get(s : StatsdisthypergeoLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_hypergeo_layer_set(s : StatsdisthypergeoLayer, i : Int, v : Double) -> StatsdisthypergeoLayer {
  let result = stats_dist_hypergeo_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_hypergeo_layer_sum(s : StatsdisthypergeoLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_hypergeo_layer_mean(s : StatsdisthypergeoLayer) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_hypergeo_layer_sum(s) / s.size.to_double() }
}

pub fn stats_dist_hypergeo_layer_scale(s : StatsdisthypergeoLayer, f : Double) -> StatsdisthypergeoLayer {
  let result = stats_dist_hypergeo_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_hypergeo_layer_add(a : StatsdisthypergeoLayer, b : StatsdisthypergeoLayer) -> StatsdisthypergeoLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_hypergeo_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_hypergeo_layer_copy(s : StatsdisthypergeoLayer) -> StatsdisthypergeoLayer {
  let result = stats_dist_hypergeo_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_hypergeo_layer_fill(s : StatsdisthypergeoLayer, v : Double) -> StatsdisthypergeoLayer {
  let result = stats_dist_hypergeo_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_hypergeo_layer_min(s : StatsdisthypergeoLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_hypergeo_layer_max(s : StatsdisthypergeoLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_hypergeo_layer_to_string(s : StatsdisthypergeoLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdisthypergeoBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_hypergeo_buffer_make(size : Int) -> StatsdisthypergeoBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_hypergeo_buffer_len(s : StatsdisthypergeoBuffer) -> Int { s.size }

pub fn stats_dist_hypergeo_buffer_get(s : StatsdisthypergeoBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_hypergeo_buffer_set(s : StatsdisthypergeoBuffer, i : Int, v : Double) -> StatsdisthypergeoBuffer {
  let result = stats_dist_hypergeo_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_hypergeo_buffer_sum(s : StatsdisthypergeoBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_hypergeo_buffer_mean(s : StatsdisthypergeoBuffer) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_hypergeo_buffer_sum(s) / s.size.to_double() }
}

pub fn stats_dist_hypergeo_buffer_scale(s : StatsdisthypergeoBuffer, f : Double) -> StatsdisthypergeoBuffer {
  let result = stats_dist_hypergeo_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_hypergeo_buffer_add(a : StatsdisthypergeoBuffer, b : StatsdisthypergeoBuffer) -> StatsdisthypergeoBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_hypergeo_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_hypergeo_buffer_copy(s : StatsdisthypergeoBuffer) -> StatsdisthypergeoBuffer {
  let result = stats_dist_hypergeo_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_hypergeo_buffer_fill(s : StatsdisthypergeoBuffer, v : Double) -> StatsdisthypergeoBuffer {
  let result = stats_dist_hypergeo_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_hypergeo_buffer_min(s : StatsdisthypergeoBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_hypergeo_buffer_max(s : StatsdisthypergeoBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_hypergeo_buffer_to_string(s : StatsdisthypergeoBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdisthypergeoCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_hypergeo_cursor_make(size : Int) -> StatsdisthypergeoCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_hypergeo_cursor_len(s : StatsdisthypergeoCursor) -> Int { s.size }

pub fn stats_dist_hypergeo_cursor_get(s : StatsdisthypergeoCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_hypergeo_cursor_set(s : StatsdisthypergeoCursor, i : Int, v : Double) -> StatsdisthypergeoCursor {
  let result = stats_dist_hypergeo_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_hypergeo_cursor_sum(s : StatsdisthypergeoCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_hypergeo_cursor_mean(s : StatsdisthypergeoCursor) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_hypergeo_cursor_sum(s) / s.size.to_double() }
}

pub fn stats_dist_hypergeo_cursor_scale(s : StatsdisthypergeoCursor, f : Double) -> StatsdisthypergeoCursor {
  let result = stats_dist_hypergeo_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_hypergeo_cursor_add(a : StatsdisthypergeoCursor, b : StatsdisthypergeoCursor) -> StatsdisthypergeoCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_hypergeo_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_hypergeo_cursor_copy(s : StatsdisthypergeoCursor) -> StatsdisthypergeoCursor {
  let result = stats_dist_hypergeo_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_hypergeo_cursor_fill(s : StatsdisthypergeoCursor, v : Double) -> StatsdisthypergeoCursor {
  let result = stats_dist_hypergeo_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_hypergeo_cursor_min(s : StatsdisthypergeoCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_hypergeo_cursor_max(s : StatsdisthypergeoCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_hypergeo_cursor_to_string(s : StatsdisthypergeoCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdisthypergeoView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_hypergeo_view_make(size : Int) -> StatsdisthypergeoView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_hypergeo_view_len(s : StatsdisthypergeoView) -> Int { s.size }

pub fn stats_dist_hypergeo_view_get(s : StatsdisthypergeoView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_hypergeo_view_set(s : StatsdisthypergeoView, i : Int, v : Double) -> StatsdisthypergeoView {
  let result = stats_dist_hypergeo_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_hypergeo_view_sum(s : StatsdisthypergeoView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_hypergeo_view_mean(s : StatsdisthypergeoView) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_hypergeo_view_sum(s) / s.size.to_double() }
}

pub fn stats_dist_hypergeo_view_scale(s : StatsdisthypergeoView, f : Double) -> StatsdisthypergeoView {
  let result = stats_dist_hypergeo_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_hypergeo_view_add(a : StatsdisthypergeoView, b : StatsdisthypergeoView) -> StatsdisthypergeoView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_hypergeo_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_hypergeo_view_copy(s : StatsdisthypergeoView) -> StatsdisthypergeoView {
  let result = stats_dist_hypergeo_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_hypergeo_view_fill(s : StatsdisthypergeoView, v : Double) -> StatsdisthypergeoView {
  let result = stats_dist_hypergeo_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_hypergeo_view_min(s : StatsdisthypergeoView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_hypergeo_view_max(s : StatsdisthypergeoView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_hypergeo_view_to_string(s : StatsdisthypergeoView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdisthypergeoRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_hypergeo_range_make(size : Int) -> StatsdisthypergeoRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_hypergeo_range_len(s : StatsdisthypergeoRange) -> Int { s.size }

pub fn stats_dist_hypergeo_range_get(s : StatsdisthypergeoRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_hypergeo_range_set(s : StatsdisthypergeoRange, i : Int, v : Double) -> StatsdisthypergeoRange {
  let result = stats_dist_hypergeo_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_hypergeo_range_sum(s : StatsdisthypergeoRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_hypergeo_range_mean(s : StatsdisthypergeoRange) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_hypergeo_range_sum(s) / s.size.to_double() }
}

pub fn stats_dist_hypergeo_range_scale(s : StatsdisthypergeoRange, f : Double) -> StatsdisthypergeoRange {
  let result = stats_dist_hypergeo_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_hypergeo_range_add(a : StatsdisthypergeoRange, b : StatsdisthypergeoRange) -> StatsdisthypergeoRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_hypergeo_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_hypergeo_range_copy(s : StatsdisthypergeoRange) -> StatsdisthypergeoRange {
  let result = stats_dist_hypergeo_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_hypergeo_range_fill(s : StatsdisthypergeoRange, v : Double) -> StatsdisthypergeoRange {
  let result = stats_dist_hypergeo_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_hypergeo_range_min(s : StatsdisthypergeoRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_hypergeo_range_max(s : StatsdisthypergeoRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_hypergeo_range_to_string(s : StatsdisthypergeoRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdisthypergeoSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_hypergeo_slice_make(size : Int) -> StatsdisthypergeoSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_hypergeo_slice_len(s : StatsdisthypergeoSlice) -> Int { s.size }

pub fn stats_dist_hypergeo_slice_get(s : StatsdisthypergeoSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_hypergeo_slice_set(s : StatsdisthypergeoSlice, i : Int, v : Double) -> StatsdisthypergeoSlice {
  let result = stats_dist_hypergeo_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_hypergeo_slice_sum(s : StatsdisthypergeoSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_hypergeo_slice_mean(s : StatsdisthypergeoSlice) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_hypergeo_slice_sum(s) / s.size.to_double() }
}

pub fn stats_dist_hypergeo_slice_scale(s : StatsdisthypergeoSlice, f : Double) -> StatsdisthypergeoSlice {
  let result = stats_dist_hypergeo_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_hypergeo_slice_add(a : StatsdisthypergeoSlice, b : StatsdisthypergeoSlice) -> StatsdisthypergeoSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_hypergeo_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_hypergeo_slice_copy(s : StatsdisthypergeoSlice) -> StatsdisthypergeoSlice {
  let result = stats_dist_hypergeo_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_hypergeo_slice_fill(s : StatsdisthypergeoSlice, v : Double) -> StatsdisthypergeoSlice {
  let result = stats_dist_hypergeo_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_hypergeo_slice_min(s : StatsdisthypergeoSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_hypergeo_slice_max(s : StatsdisthypergeoSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_hypergeo_slice_to_string(s : StatsdisthypergeoSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn stats_dist_hypergeo_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_dist_hypergeo_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_dist_hypergeo_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_dist_hypergeo_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_dist_hypergeo_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_dist_hypergeo_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_dist_hypergeo_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_dist_hypergeo_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_dist_hypergeo_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_dist_hypergeo_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_dist_hypergeo_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_dist_hypergeo_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_dist_hypergeo_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_dist_hypergeo_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_dist_hypergeo_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_dist_hypergeo_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_dist_hypergeo_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_dist_hypergeo_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_dist_hypergeo_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_dist_hypergeo_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_dist_hypergeo_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_dist_hypergeo_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_dist_hypergeo_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_dist_hypergeo_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_dist_hypergeo_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

