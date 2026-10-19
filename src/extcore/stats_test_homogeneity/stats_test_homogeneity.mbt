///===
/// extcore/stats_test_homogeneity

pub(all) struct StatstesthomogeneityPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn stats_test_homogeneity_make_point(x : Double, y : Double) -> StatstesthomogeneityPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn stats_test_homogeneity_make_point3(x : Double, y : Double, z : Double) -> StatstesthomogeneityPoint {
  { x, y, z, label: 0 }
}

pub fn stats_test_homogeneity_point_x(pt : StatstesthomogeneityPoint) -> Double { pt.x }

pub fn stats_test_homogeneity_point_y(pt : StatstesthomogeneityPoint) -> Double { pt.y }

pub fn stats_test_homogeneity_point_z(pt : StatstesthomogeneityPoint) -> Double { pt.z }

pub fn stats_test_homogeneity_point_label(pt : StatstesthomogeneityPoint) -> Int { pt.label }

pub fn stats_test_homogeneity_point_dist(a : StatstesthomogeneityPoint, b : StatstesthomogeneityPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  stats_test_homogeneity_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn stats_test_homogeneity_point_add(a : StatstesthomogeneityPoint, b : StatstesthomogeneityPoint) -> StatstesthomogeneityPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn stats_test_homogeneity_point_sub(a : StatstesthomogeneityPoint, b : StatstesthomogeneityPoint) -> StatstesthomogeneityPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn stats_test_homogeneity_point_scale(pt : StatstesthomogeneityPoint, s : Double) -> StatstesthomogeneityPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn stats_test_homogeneity_point_dot(a : StatstesthomogeneityPoint, b : StatstesthomogeneityPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn stats_test_homogeneity_point_cross(a : StatstesthomogeneityPoint, b : StatstesthomogeneityPoint) -> StatstesthomogeneityPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn stats_test_homogeneity_point_norm(pt : StatstesthomogeneityPoint) -> Double {
  stats_test_homogeneity_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn stats_test_homogeneity_point_normalize(pt : StatstesthomogeneityPoint) -> StatstesthomogeneityPoint {
  let n = stats_test_homogeneity_point_norm(pt)
  if n < 0.0000001 { pt } else { stats_test_homogeneity_point_scale(pt, 1.0 / n) }
}

pub fn stats_test_homogeneity_point_negate(pt : StatstesthomogeneityPoint) -> StatstesthomogeneityPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn stats_test_homogeneity_point_mid(a : StatstesthomogeneityPoint, b : StatstesthomogeneityPoint) -> StatstesthomogeneityPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn stats_test_homogeneity_point_lerp(a : StatstesthomogeneityPoint, b : StatstesthomogeneityPoint, t : Double) -> StatstesthomogeneityPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn stats_test_homogeneity_point_to_string(pt : StatstesthomogeneityPoint) -> String {
  "(" + stats_test_homogeneity_dbl(pt.x) + ", " + stats_test_homogeneity_dbl(pt.y) + ", " + stats_test_homogeneity_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct StatstesthomogeneitySeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn stats_test_homogeneity_make_series(vals : Array[Double], name : String) -> StatstesthomogeneitySeries {
  { vals, name, meta: 0 }
}

pub fn stats_test_homogeneity_series_len(s : StatstesthomogeneitySeries) -> Int { s.vals.length() }

pub fn stats_test_homogeneity_series_sum(s : StatstesthomogeneitySeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn stats_test_homogeneity_series_mean(s : StatstesthomogeneitySeries) -> Double {
  let n = stats_test_homogeneity_series_len(s)
  if n == 0 { 0.0 } else { stats_test_homogeneity_series_sum(s) / n.to_double() }
}

pub fn stats_test_homogeneity_series_min(s : StatstesthomogeneitySeries) -> Double {
  let n = stats_test_homogeneity_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn stats_test_homogeneity_series_max(s : StatstesthomogeneitySeries) -> Double {
  let n = stats_test_homogeneity_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn stats_test_homogeneity_series_range(s : StatstesthomogeneitySeries) -> Double {
  stats_test_homogeneity_series_max(s) - stats_test_homogeneity_series_min(s)
}

pub fn stats_test_homogeneity_series_var(s : StatstesthomogeneitySeries) -> Double {
  let n = stats_test_homogeneity_series_len(s)
  if n == 0 { 0.0 } else {
    let m = stats_test_homogeneity_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn stats_test_homogeneity_series_std(s : StatstesthomogeneitySeries) -> Double { stats_test_homogeneity_sqrt(stats_test_homogeneity_series_var(s)) }

pub fn stats_test_homogeneity_series_median(s : StatstesthomogeneitySeries) -> Double {
  let n = stats_test_homogeneity_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = stats_test_homogeneity_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn stats_test_homogeneity_series_scale(s : StatstesthomogeneitySeries, f : Double) -> StatstesthomogeneitySeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = stats_test_homogeneity_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn stats_test_homogeneity_series_add(a : StatstesthomogeneitySeries, b : StatstesthomogeneitySeries) -> StatstesthomogeneitySeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = stats_test_homogeneity_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn stats_test_homogeneity_series_sub(a : StatstesthomogeneitySeries, b : StatstesthomogeneitySeries) -> StatstesthomogeneitySeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = stats_test_homogeneity_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn stats_test_homogeneity_series_normalize(s : StatstesthomogeneitySeries) -> StatstesthomogeneitySeries {
  let mn = stats_test_homogeneity_series_min(s)
  let mx = stats_test_homogeneity_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = stats_test_homogeneity_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn stats_test_homogeneity_series_cumsum(s : StatstesthomogeneitySeries) -> StatstesthomogeneitySeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = stats_test_homogeneity_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn stats_test_homogeneity_series_to_string(s : StatstesthomogeneitySeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + stats_test_homogeneity_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct StatstesthomogeneityMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn stats_test_homogeneity_make_matrix(rows : Int, cols : Int, val : Double) -> StatstesthomogeneityMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn stats_test_homogeneity_matrix_identity(n : Int) -> StatstesthomogeneityMatrix {
  let m = stats_test_homogeneity_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn stats_test_homogeneity_matrix_get(m : StatstesthomogeneityMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn stats_test_homogeneity_matrix_transpose(m : StatstesthomogeneityMatrix) -> StatstesthomogeneityMatrix {
  let result = stats_test_homogeneity_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn stats_test_homogeneity_matrix_add(a : StatstesthomogeneityMatrix, b : StatstesthomogeneityMatrix) -> StatstesthomogeneityMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = stats_test_homogeneity_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn stats_test_homogeneity_matrix_scale(m : StatstesthomogeneityMatrix, s : Double) -> StatstesthomogeneityMatrix {
  let result = stats_test_homogeneity_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn stats_test_homogeneity_matrix_multiply(a : StatstesthomogeneityMatrix, b : StatstesthomogeneityMatrix) -> StatstesthomogeneityMatrix {
  if a.cols != b.rows { return stats_test_homogeneity_make_matrix(a.rows, b.cols, 0.0) }
  let result = stats_test_homogeneity_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn stats_test_homogeneity_matrix_trace(m : StatstesthomogeneityMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn stats_test_homogeneity_matrix_det(m : StatstesthomogeneityMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn stats_test_homogeneity_matrix_norm(m : StatstesthomogeneityMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  stats_test_homogeneity_sqrt(sum)
}

pub fn stats_test_homogeneity_matrix_to_string(m : StatstesthomogeneityMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + stats_test_homogeneity_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct StatstesthomogeneityVector {
  comps : Array[Double]
  dim : Int
}

pub fn stats_test_homogeneity_make_vector(comps : Array[Double]) -> StatstesthomogeneityVector {
  { comps, dim: comps.length() }
}

pub fn stats_test_homogeneity_vector_zero(dim : Int) -> StatstesthomogeneityVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn stats_test_homogeneity_vector_add(a : StatstesthomogeneityVector, b : StatstesthomogeneityVector) -> StatstesthomogeneityVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = stats_test_homogeneity_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn stats_test_homogeneity_vector_sub(a : StatstesthomogeneityVector, b : StatstesthomogeneityVector) -> StatstesthomogeneityVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = stats_test_homogeneity_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn stats_test_homogeneity_vector_scale(v : StatstesthomogeneityVector, s : Double) -> StatstesthomogeneityVector {
  let mut result = []
  for i in 0..<v.dim { result = stats_test_homogeneity_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn stats_test_homogeneity_vector_dot(a : StatstesthomogeneityVector, b : StatstesthomogeneityVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn stats_test_homogeneity_vector_norm(v : StatstesthomogeneityVector) -> Double { stats_test_homogeneity_sqrt(stats_test_homogeneity_vector_dot(v, v)) }

pub fn stats_test_homogeneity_vector_normalize(v : StatstesthomogeneityVector) -> StatstesthomogeneityVector {
  let n = stats_test_homogeneity_vector_norm(v)
  if n < 0.0000001 { v } else { stats_test_homogeneity_vector_scale(v, 1.0 / n) }
}

pub fn stats_test_homogeneity_vector_dist(a : StatstesthomogeneityVector, b : StatstesthomogeneityVector) -> Double {
  stats_test_homogeneity_vector_norm(stats_test_homogeneity_vector_sub(a, b))
}

pub fn stats_test_homogeneity_vector_to_string(v : StatstesthomogeneityVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + stats_test_homogeneity_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn stats_test_homogeneity_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn stats_test_homogeneity_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = stats_test_homogeneity_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn stats_test_homogeneity_std(data : Array[Double]) -> Double { stats_test_homogeneity_sqrt(stats_test_homogeneity_var(data)) }

pub fn stats_test_homogeneity_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = stats_test_homogeneity_mean(a); let mb = stats_test_homogeneity_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn stats_test_homogeneity_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = stats_test_homogeneity_std(a); let sb = stats_test_homogeneity_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { stats_test_homogeneity_cov(a, b) / (sa * sb) }
}

pub fn stats_test_homogeneity_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = stats_test_homogeneity_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn stats_test_homogeneity_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn stats_test_homogeneity_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn stats_test_homogeneity_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  stats_test_homogeneity_sqrt(stats_test_homogeneity_mse(pred, labels))
}

pub fn stats_test_homogeneity_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + stats_test_homogeneity_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn stats_test_homogeneity_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = stats_test_homogeneity_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn stats_test_homogeneity_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn stats_test_homogeneity_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn stats_test_homogeneity_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = stats_test_homogeneity_precision(pred, labels, pos); let r = stats_test_homogeneity_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn stats_test_homogeneity_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn stats_test_homogeneity_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = stats_test_homogeneity_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn stats_test_homogeneity_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn stats_test_homogeneity_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn stats_test_homogeneity_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = stats_test_homogeneity_gcd(a, b)
    (a / g) * b
  }
}

pub fn stats_test_homogeneity_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn stats_test_homogeneity_fibonacci(n : Int) -> Int {
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

pub fn stats_test_homogeneity_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = stats_test_homogeneity_min(data); let mx = stats_test_homogeneity_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn stats_test_homogeneity_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = stats_test_homogeneity_mean(data); let sd = stats_test_homogeneity_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn stats_test_homogeneity_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn stats_test_homogeneity_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn stats_test_homogeneity_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn stats_test_homogeneity_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn stats_test_homogeneity_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn stats_test_homogeneity_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn stats_test_homogeneity_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn stats_test_homogeneity_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn stats_test_homogeneity_dbl(x : Double) -> String {
  let i = if x >= 0.0 { stats_test_homogeneity_int(x) } else { -stats_test_homogeneity_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { stats_test_homogeneity_int(f * 1000000.0) } else { stats_test_homogeneity_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn stats_test_homogeneity_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn stats_test_homogeneity_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct StatstesthomogeneityFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_homogeneity_frame_make(size : Int) -> StatstesthomogeneityFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_homogeneity_frame_len(s : StatstesthomogeneityFrame) -> Int { s.size }

pub fn stats_test_homogeneity_frame_get(s : StatstesthomogeneityFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_homogeneity_frame_set(s : StatstesthomogeneityFrame, i : Int, v : Double) -> StatstesthomogeneityFrame {
  let result = stats_test_homogeneity_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_test_homogeneity_frame_sum(s : StatstesthomogeneityFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_test_homogeneity_frame_mean(s : StatstesthomogeneityFrame) -> Double {
  if s.size == 0 { 0.0 } else { stats_test_homogeneity_frame_sum(s) / s.size.to_double() }
}

pub fn stats_test_homogeneity_frame_scale(s : StatstesthomogeneityFrame, f : Double) -> StatstesthomogeneityFrame {
  let result = stats_test_homogeneity_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_test_homogeneity_frame_add(a : StatstesthomogeneityFrame, b : StatstesthomogeneityFrame) -> StatstesthomogeneityFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_test_homogeneity_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_test_homogeneity_frame_copy(s : StatstesthomogeneityFrame) -> StatstesthomogeneityFrame {
  let result = stats_test_homogeneity_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_test_homogeneity_frame_fill(s : StatstesthomogeneityFrame, v : Double) -> StatstesthomogeneityFrame {
  let result = stats_test_homogeneity_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_test_homogeneity_frame_min(s : StatstesthomogeneityFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_homogeneity_frame_max(s : StatstesthomogeneityFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_homogeneity_frame_to_string(s : StatstesthomogeneityFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstesthomogeneityTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_homogeneity_table_make(size : Int) -> StatstesthomogeneityTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_homogeneity_table_len(s : StatstesthomogeneityTable) -> Int { s.size }

pub fn stats_test_homogeneity_table_get(s : StatstesthomogeneityTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_homogeneity_table_set(s : StatstesthomogeneityTable, i : Int, v : Double) -> StatstesthomogeneityTable {
  let result = stats_test_homogeneity_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_test_homogeneity_table_sum(s : StatstesthomogeneityTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_test_homogeneity_table_mean(s : StatstesthomogeneityTable) -> Double {
  if s.size == 0 { 0.0 } else { stats_test_homogeneity_table_sum(s) / s.size.to_double() }
}

pub fn stats_test_homogeneity_table_scale(s : StatstesthomogeneityTable, f : Double) -> StatstesthomogeneityTable {
  let result = stats_test_homogeneity_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_test_homogeneity_table_add(a : StatstesthomogeneityTable, b : StatstesthomogeneityTable) -> StatstesthomogeneityTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_test_homogeneity_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_test_homogeneity_table_copy(s : StatstesthomogeneityTable) -> StatstesthomogeneityTable {
  let result = stats_test_homogeneity_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_test_homogeneity_table_fill(s : StatstesthomogeneityTable, v : Double) -> StatstesthomogeneityTable {
  let result = stats_test_homogeneity_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_test_homogeneity_table_min(s : StatstesthomogeneityTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_homogeneity_table_max(s : StatstesthomogeneityTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_homogeneity_table_to_string(s : StatstesthomogeneityTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstesthomogeneityGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_homogeneity_graphn_make(size : Int) -> StatstesthomogeneityGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_homogeneity_graphn_len(s : StatstesthomogeneityGraphN) -> Int { s.size }

pub fn stats_test_homogeneity_graphn_get(s : StatstesthomogeneityGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_homogeneity_graphn_set(s : StatstesthomogeneityGraphN, i : Int, v : Double) -> StatstesthomogeneityGraphN {
  let result = stats_test_homogeneity_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_test_homogeneity_graphn_sum(s : StatstesthomogeneityGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_test_homogeneity_graphn_mean(s : StatstesthomogeneityGraphN) -> Double {
  if s.size == 0 { 0.0 } else { stats_test_homogeneity_graphn_sum(s) / s.size.to_double() }
}

pub fn stats_test_homogeneity_graphn_scale(s : StatstesthomogeneityGraphN, f : Double) -> StatstesthomogeneityGraphN {
  let result = stats_test_homogeneity_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_test_homogeneity_graphn_add(a : StatstesthomogeneityGraphN, b : StatstesthomogeneityGraphN) -> StatstesthomogeneityGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_test_homogeneity_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_test_homogeneity_graphn_copy(s : StatstesthomogeneityGraphN) -> StatstesthomogeneityGraphN {
  let result = stats_test_homogeneity_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_test_homogeneity_graphn_fill(s : StatstesthomogeneityGraphN, v : Double) -> StatstesthomogeneityGraphN {
  let result = stats_test_homogeneity_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_test_homogeneity_graphn_min(s : StatstesthomogeneityGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_homogeneity_graphn_max(s : StatstesthomogeneityGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_homogeneity_graphn_to_string(s : StatstesthomogeneityGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstesthomogeneityNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_homogeneity_node_make(size : Int) -> StatstesthomogeneityNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_homogeneity_node_len(s : StatstesthomogeneityNode) -> Int { s.size }

pub fn stats_test_homogeneity_node_get(s : StatstesthomogeneityNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_homogeneity_node_set(s : StatstesthomogeneityNode, i : Int, v : Double) -> StatstesthomogeneityNode {
  let result = stats_test_homogeneity_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_test_homogeneity_node_sum(s : StatstesthomogeneityNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_test_homogeneity_node_mean(s : StatstesthomogeneityNode) -> Double {
  if s.size == 0 { 0.0 } else { stats_test_homogeneity_node_sum(s) / s.size.to_double() }
}

pub fn stats_test_homogeneity_node_scale(s : StatstesthomogeneityNode, f : Double) -> StatstesthomogeneityNode {
  let result = stats_test_homogeneity_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_test_homogeneity_node_add(a : StatstesthomogeneityNode, b : StatstesthomogeneityNode) -> StatstesthomogeneityNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_test_homogeneity_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_test_homogeneity_node_copy(s : StatstesthomogeneityNode) -> StatstesthomogeneityNode {
  let result = stats_test_homogeneity_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_test_homogeneity_node_fill(s : StatstesthomogeneityNode, v : Double) -> StatstesthomogeneityNode {
  let result = stats_test_homogeneity_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_test_homogeneity_node_min(s : StatstesthomogeneityNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_homogeneity_node_max(s : StatstesthomogeneityNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_homogeneity_node_to_string(s : StatstesthomogeneityNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstesthomogeneityEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_homogeneity_edge_make(size : Int) -> StatstesthomogeneityEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_homogeneity_edge_len(s : StatstesthomogeneityEdge) -> Int { s.size }

pub fn stats_test_homogeneity_edge_get(s : StatstesthomogeneityEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_homogeneity_edge_set(s : StatstesthomogeneityEdge, i : Int, v : Double) -> StatstesthomogeneityEdge {
  let result = stats_test_homogeneity_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_test_homogeneity_edge_sum(s : StatstesthomogeneityEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_test_homogeneity_edge_mean(s : StatstesthomogeneityEdge) -> Double {
  if s.size == 0 { 0.0 } else { stats_test_homogeneity_edge_sum(s) / s.size.to_double() }
}

pub fn stats_test_homogeneity_edge_scale(s : StatstesthomogeneityEdge, f : Double) -> StatstesthomogeneityEdge {
  let result = stats_test_homogeneity_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_test_homogeneity_edge_add(a : StatstesthomogeneityEdge, b : StatstesthomogeneityEdge) -> StatstesthomogeneityEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_test_homogeneity_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_test_homogeneity_edge_copy(s : StatstesthomogeneityEdge) -> StatstesthomogeneityEdge {
  let result = stats_test_homogeneity_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_test_homogeneity_edge_fill(s : StatstesthomogeneityEdge, v : Double) -> StatstesthomogeneityEdge {
  let result = stats_test_homogeneity_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_test_homogeneity_edge_min(s : StatstesthomogeneityEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_homogeneity_edge_max(s : StatstesthomogeneityEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_homogeneity_edge_to_string(s : StatstesthomogeneityEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstesthomogeneityPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_homogeneity_path_make(size : Int) -> StatstesthomogeneityPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_homogeneity_path_len(s : StatstesthomogeneityPath) -> Int { s.size }

pub fn stats_test_homogeneity_path_get(s : StatstesthomogeneityPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_homogeneity_path_set(s : StatstesthomogeneityPath, i : Int, v : Double) -> StatstesthomogeneityPath {
  let result = stats_test_homogeneity_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_test_homogeneity_path_sum(s : StatstesthomogeneityPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_test_homogeneity_path_mean(s : StatstesthomogeneityPath) -> Double {
  if s.size == 0 { 0.0 } else { stats_test_homogeneity_path_sum(s) / s.size.to_double() }
}

pub fn stats_test_homogeneity_path_scale(s : StatstesthomogeneityPath, f : Double) -> StatstesthomogeneityPath {
  let result = stats_test_homogeneity_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_test_homogeneity_path_add(a : StatstesthomogeneityPath, b : StatstesthomogeneityPath) -> StatstesthomogeneityPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_test_homogeneity_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_test_homogeneity_path_copy(s : StatstesthomogeneityPath) -> StatstesthomogeneityPath {
  let result = stats_test_homogeneity_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_test_homogeneity_path_fill(s : StatstesthomogeneityPath, v : Double) -> StatstesthomogeneityPath {
  let result = stats_test_homogeneity_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_test_homogeneity_path_min(s : StatstesthomogeneityPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_homogeneity_path_max(s : StatstesthomogeneityPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_homogeneity_path_to_string(s : StatstesthomogeneityPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstesthomogeneityCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_homogeneity_cluster_make(size : Int) -> StatstesthomogeneityCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_homogeneity_cluster_len(s : StatstesthomogeneityCluster) -> Int { s.size }

pub fn stats_test_homogeneity_cluster_get(s : StatstesthomogeneityCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_homogeneity_cluster_set(s : StatstesthomogeneityCluster, i : Int, v : Double) -> StatstesthomogeneityCluster {
  let result = stats_test_homogeneity_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_test_homogeneity_cluster_sum(s : StatstesthomogeneityCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_test_homogeneity_cluster_mean(s : StatstesthomogeneityCluster) -> Double {
  if s.size == 0 { 0.0 } else { stats_test_homogeneity_cluster_sum(s) / s.size.to_double() }
}

pub fn stats_test_homogeneity_cluster_scale(s : StatstesthomogeneityCluster, f : Double) -> StatstesthomogeneityCluster {
  let result = stats_test_homogeneity_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_test_homogeneity_cluster_add(a : StatstesthomogeneityCluster, b : StatstesthomogeneityCluster) -> StatstesthomogeneityCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_test_homogeneity_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_test_homogeneity_cluster_copy(s : StatstesthomogeneityCluster) -> StatstesthomogeneityCluster {
  let result = stats_test_homogeneity_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_test_homogeneity_cluster_fill(s : StatstesthomogeneityCluster, v : Double) -> StatstesthomogeneityCluster {
  let result = stats_test_homogeneity_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_test_homogeneity_cluster_min(s : StatstesthomogeneityCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_homogeneity_cluster_max(s : StatstesthomogeneityCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_homogeneity_cluster_to_string(s : StatstesthomogeneityCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstesthomogeneityModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_homogeneity_model_make(size : Int) -> StatstesthomogeneityModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_homogeneity_model_len(s : StatstesthomogeneityModel) -> Int { s.size }

pub fn stats_test_homogeneity_model_get(s : StatstesthomogeneityModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_homogeneity_model_set(s : StatstesthomogeneityModel, i : Int, v : Double) -> StatstesthomogeneityModel {
  let result = stats_test_homogeneity_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_test_homogeneity_model_sum(s : StatstesthomogeneityModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_test_homogeneity_model_mean(s : StatstesthomogeneityModel) -> Double {
  if s.size == 0 { 0.0 } else { stats_test_homogeneity_model_sum(s) / s.size.to_double() }
}

pub fn stats_test_homogeneity_model_scale(s : StatstesthomogeneityModel, f : Double) -> StatstesthomogeneityModel {
  let result = stats_test_homogeneity_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_test_homogeneity_model_add(a : StatstesthomogeneityModel, b : StatstesthomogeneityModel) -> StatstesthomogeneityModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_test_homogeneity_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_test_homogeneity_model_copy(s : StatstesthomogeneityModel) -> StatstesthomogeneityModel {
  let result = stats_test_homogeneity_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_test_homogeneity_model_fill(s : StatstesthomogeneityModel, v : Double) -> StatstesthomogeneityModel {
  let result = stats_test_homogeneity_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_test_homogeneity_model_min(s : StatstesthomogeneityModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_homogeneity_model_max(s : StatstesthomogeneityModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_homogeneity_model_to_string(s : StatstesthomogeneityModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstesthomogeneityLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_homogeneity_layer_make(size : Int) -> StatstesthomogeneityLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_homogeneity_layer_len(s : StatstesthomogeneityLayer) -> Int { s.size }

pub fn stats_test_homogeneity_layer_get(s : StatstesthomogeneityLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_homogeneity_layer_set(s : StatstesthomogeneityLayer, i : Int, v : Double) -> StatstesthomogeneityLayer {
  let result = stats_test_homogeneity_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_test_homogeneity_layer_sum(s : StatstesthomogeneityLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_test_homogeneity_layer_mean(s : StatstesthomogeneityLayer) -> Double {
  if s.size == 0 { 0.0 } else { stats_test_homogeneity_layer_sum(s) / s.size.to_double() }
}

pub fn stats_test_homogeneity_layer_scale(s : StatstesthomogeneityLayer, f : Double) -> StatstesthomogeneityLayer {
  let result = stats_test_homogeneity_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_test_homogeneity_layer_add(a : StatstesthomogeneityLayer, b : StatstesthomogeneityLayer) -> StatstesthomogeneityLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_test_homogeneity_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_test_homogeneity_layer_copy(s : StatstesthomogeneityLayer) -> StatstesthomogeneityLayer {
  let result = stats_test_homogeneity_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_test_homogeneity_layer_fill(s : StatstesthomogeneityLayer, v : Double) -> StatstesthomogeneityLayer {
  let result = stats_test_homogeneity_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_test_homogeneity_layer_min(s : StatstesthomogeneityLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_homogeneity_layer_max(s : StatstesthomogeneityLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_homogeneity_layer_to_string(s : StatstesthomogeneityLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstesthomogeneityBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_homogeneity_buffer_make(size : Int) -> StatstesthomogeneityBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_homogeneity_buffer_len(s : StatstesthomogeneityBuffer) -> Int { s.size }

pub fn stats_test_homogeneity_buffer_get(s : StatstesthomogeneityBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_homogeneity_buffer_set(s : StatstesthomogeneityBuffer, i : Int, v : Double) -> StatstesthomogeneityBuffer {
  let result = stats_test_homogeneity_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_test_homogeneity_buffer_sum(s : StatstesthomogeneityBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_test_homogeneity_buffer_mean(s : StatstesthomogeneityBuffer) -> Double {
  if s.size == 0 { 0.0 } else { stats_test_homogeneity_buffer_sum(s) / s.size.to_double() }
}

pub fn stats_test_homogeneity_buffer_scale(s : StatstesthomogeneityBuffer, f : Double) -> StatstesthomogeneityBuffer {
  let result = stats_test_homogeneity_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_test_homogeneity_buffer_add(a : StatstesthomogeneityBuffer, b : StatstesthomogeneityBuffer) -> StatstesthomogeneityBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_test_homogeneity_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_test_homogeneity_buffer_copy(s : StatstesthomogeneityBuffer) -> StatstesthomogeneityBuffer {
  let result = stats_test_homogeneity_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_test_homogeneity_buffer_fill(s : StatstesthomogeneityBuffer, v : Double) -> StatstesthomogeneityBuffer {
  let result = stats_test_homogeneity_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_test_homogeneity_buffer_min(s : StatstesthomogeneityBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_homogeneity_buffer_max(s : StatstesthomogeneityBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_homogeneity_buffer_to_string(s : StatstesthomogeneityBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstesthomogeneityCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_homogeneity_cursor_make(size : Int) -> StatstesthomogeneityCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_homogeneity_cursor_len(s : StatstesthomogeneityCursor) -> Int { s.size }

pub fn stats_test_homogeneity_cursor_get(s : StatstesthomogeneityCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_homogeneity_cursor_set(s : StatstesthomogeneityCursor, i : Int, v : Double) -> StatstesthomogeneityCursor {
  let result = stats_test_homogeneity_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_test_homogeneity_cursor_sum(s : StatstesthomogeneityCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_test_homogeneity_cursor_mean(s : StatstesthomogeneityCursor) -> Double {
  if s.size == 0 { 0.0 } else { stats_test_homogeneity_cursor_sum(s) / s.size.to_double() }
}

pub fn stats_test_homogeneity_cursor_scale(s : StatstesthomogeneityCursor, f : Double) -> StatstesthomogeneityCursor {
  let result = stats_test_homogeneity_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_test_homogeneity_cursor_add(a : StatstesthomogeneityCursor, b : StatstesthomogeneityCursor) -> StatstesthomogeneityCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_test_homogeneity_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_test_homogeneity_cursor_copy(s : StatstesthomogeneityCursor) -> StatstesthomogeneityCursor {
  let result = stats_test_homogeneity_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_test_homogeneity_cursor_fill(s : StatstesthomogeneityCursor, v : Double) -> StatstesthomogeneityCursor {
  let result = stats_test_homogeneity_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_test_homogeneity_cursor_min(s : StatstesthomogeneityCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_homogeneity_cursor_max(s : StatstesthomogeneityCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_homogeneity_cursor_to_string(s : StatstesthomogeneityCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstesthomogeneityView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_homogeneity_view_make(size : Int) -> StatstesthomogeneityView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_homogeneity_view_len(s : StatstesthomogeneityView) -> Int { s.size }

pub fn stats_test_homogeneity_view_get(s : StatstesthomogeneityView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_homogeneity_view_set(s : StatstesthomogeneityView, i : Int, v : Double) -> StatstesthomogeneityView {
  let result = stats_test_homogeneity_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_test_homogeneity_view_sum(s : StatstesthomogeneityView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_test_homogeneity_view_mean(s : StatstesthomogeneityView) -> Double {
  if s.size == 0 { 0.0 } else { stats_test_homogeneity_view_sum(s) / s.size.to_double() }
}

pub fn stats_test_homogeneity_view_scale(s : StatstesthomogeneityView, f : Double) -> StatstesthomogeneityView {
  let result = stats_test_homogeneity_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_test_homogeneity_view_add(a : StatstesthomogeneityView, b : StatstesthomogeneityView) -> StatstesthomogeneityView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_test_homogeneity_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_test_homogeneity_view_copy(s : StatstesthomogeneityView) -> StatstesthomogeneityView {
  let result = stats_test_homogeneity_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_test_homogeneity_view_fill(s : StatstesthomogeneityView, v : Double) -> StatstesthomogeneityView {
  let result = stats_test_homogeneity_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_test_homogeneity_view_min(s : StatstesthomogeneityView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_homogeneity_view_max(s : StatstesthomogeneityView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_homogeneity_view_to_string(s : StatstesthomogeneityView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstesthomogeneityRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_homogeneity_range_make(size : Int) -> StatstesthomogeneityRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_homogeneity_range_len(s : StatstesthomogeneityRange) -> Int { s.size }

pub fn stats_test_homogeneity_range_get(s : StatstesthomogeneityRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_homogeneity_range_set(s : StatstesthomogeneityRange, i : Int, v : Double) -> StatstesthomogeneityRange {
  let result = stats_test_homogeneity_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_test_homogeneity_range_sum(s : StatstesthomogeneityRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_test_homogeneity_range_mean(s : StatstesthomogeneityRange) -> Double {
  if s.size == 0 { 0.0 } else { stats_test_homogeneity_range_sum(s) / s.size.to_double() }
}

pub fn stats_test_homogeneity_range_scale(s : StatstesthomogeneityRange, f : Double) -> StatstesthomogeneityRange {
  let result = stats_test_homogeneity_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_test_homogeneity_range_add(a : StatstesthomogeneityRange, b : StatstesthomogeneityRange) -> StatstesthomogeneityRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_test_homogeneity_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_test_homogeneity_range_copy(s : StatstesthomogeneityRange) -> StatstesthomogeneityRange {
  let result = stats_test_homogeneity_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_test_homogeneity_range_fill(s : StatstesthomogeneityRange, v : Double) -> StatstesthomogeneityRange {
  let result = stats_test_homogeneity_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_test_homogeneity_range_min(s : StatstesthomogeneityRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_homogeneity_range_max(s : StatstesthomogeneityRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_homogeneity_range_to_string(s : StatstesthomogeneityRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstesthomogeneitySlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_homogeneity_slice_make(size : Int) -> StatstesthomogeneitySlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_homogeneity_slice_len(s : StatstesthomogeneitySlice) -> Int { s.size }

pub fn stats_test_homogeneity_slice_get(s : StatstesthomogeneitySlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_homogeneity_slice_set(s : StatstesthomogeneitySlice, i : Int, v : Double) -> StatstesthomogeneitySlice {
  let result = stats_test_homogeneity_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_test_homogeneity_slice_sum(s : StatstesthomogeneitySlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_test_homogeneity_slice_mean(s : StatstesthomogeneitySlice) -> Double {
  if s.size == 0 { 0.0 } else { stats_test_homogeneity_slice_sum(s) / s.size.to_double() }
}

pub fn stats_test_homogeneity_slice_scale(s : StatstesthomogeneitySlice, f : Double) -> StatstesthomogeneitySlice {
  let result = stats_test_homogeneity_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_test_homogeneity_slice_add(a : StatstesthomogeneitySlice, b : StatstesthomogeneitySlice) -> StatstesthomogeneitySlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_test_homogeneity_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_test_homogeneity_slice_copy(s : StatstesthomogeneitySlice) -> StatstesthomogeneitySlice {
  let result = stats_test_homogeneity_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_test_homogeneity_slice_fill(s : StatstesthomogeneitySlice, v : Double) -> StatstesthomogeneitySlice {
  let result = stats_test_homogeneity_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_test_homogeneity_slice_min(s : StatstesthomogeneitySlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_homogeneity_slice_max(s : StatstesthomogeneitySlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_homogeneity_slice_to_string(s : StatstesthomogeneitySlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn stats_test_homogeneity_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_test_homogeneity_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_test_homogeneity_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_test_homogeneity_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_test_homogeneity_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_test_homogeneity_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_test_homogeneity_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_test_homogeneity_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_test_homogeneity_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_test_homogeneity_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_test_homogeneity_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_test_homogeneity_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_test_homogeneity_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_test_homogeneity_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_test_homogeneity_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_test_homogeneity_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_test_homogeneity_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_test_homogeneity_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_test_homogeneity_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_test_homogeneity_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_test_homogeneity_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_test_homogeneity_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_test_homogeneity_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_test_homogeneity_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_test_homogeneity_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

