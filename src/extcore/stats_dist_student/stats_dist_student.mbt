///===
/// extcore/stats_dist_student

pub(all) struct StatsdiststudentPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn stats_dist_student_make_point(x : Double, y : Double) -> StatsdiststudentPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn stats_dist_student_make_point3(x : Double, y : Double, z : Double) -> StatsdiststudentPoint {
  { x, y, z, label: 0 }
}

pub fn stats_dist_student_point_x(pt : StatsdiststudentPoint) -> Double { pt.x }

pub fn stats_dist_student_point_y(pt : StatsdiststudentPoint) -> Double { pt.y }

pub fn stats_dist_student_point_z(pt : StatsdiststudentPoint) -> Double { pt.z }

pub fn stats_dist_student_point_label(pt : StatsdiststudentPoint) -> Int { pt.label }

pub fn stats_dist_student_point_dist(a : StatsdiststudentPoint, b : StatsdiststudentPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  stats_dist_student_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn stats_dist_student_point_add(a : StatsdiststudentPoint, b : StatsdiststudentPoint) -> StatsdiststudentPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn stats_dist_student_point_sub(a : StatsdiststudentPoint, b : StatsdiststudentPoint) -> StatsdiststudentPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn stats_dist_student_point_scale(pt : StatsdiststudentPoint, s : Double) -> StatsdiststudentPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn stats_dist_student_point_dot(a : StatsdiststudentPoint, b : StatsdiststudentPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn stats_dist_student_point_cross(a : StatsdiststudentPoint, b : StatsdiststudentPoint) -> StatsdiststudentPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn stats_dist_student_point_norm(pt : StatsdiststudentPoint) -> Double {
  stats_dist_student_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn stats_dist_student_point_normalize(pt : StatsdiststudentPoint) -> StatsdiststudentPoint {
  let n = stats_dist_student_point_norm(pt)
  if n < 0.0000001 { pt } else { stats_dist_student_point_scale(pt, 1.0 / n) }
}

pub fn stats_dist_student_point_negate(pt : StatsdiststudentPoint) -> StatsdiststudentPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn stats_dist_student_point_mid(a : StatsdiststudentPoint, b : StatsdiststudentPoint) -> StatsdiststudentPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn stats_dist_student_point_lerp(a : StatsdiststudentPoint, b : StatsdiststudentPoint, t : Double) -> StatsdiststudentPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn stats_dist_student_point_to_string(pt : StatsdiststudentPoint) -> String {
  "(" + stats_dist_student_dbl(pt.x) + ", " + stats_dist_student_dbl(pt.y) + ", " + stats_dist_student_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct StatsdiststudentSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn stats_dist_student_make_series(vals : Array[Double], name : String) -> StatsdiststudentSeries {
  { vals, name, meta: 0 }
}

pub fn stats_dist_student_series_len(s : StatsdiststudentSeries) -> Int { s.vals.length() }

pub fn stats_dist_student_series_sum(s : StatsdiststudentSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn stats_dist_student_series_mean(s : StatsdiststudentSeries) -> Double {
  let n = stats_dist_student_series_len(s)
  if n == 0 { 0.0 } else { stats_dist_student_series_sum(s) / n.to_double() }
}

pub fn stats_dist_student_series_min(s : StatsdiststudentSeries) -> Double {
  let n = stats_dist_student_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn stats_dist_student_series_max(s : StatsdiststudentSeries) -> Double {
  let n = stats_dist_student_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn stats_dist_student_series_range(s : StatsdiststudentSeries) -> Double {
  stats_dist_student_series_max(s) - stats_dist_student_series_min(s)
}

pub fn stats_dist_student_series_var(s : StatsdiststudentSeries) -> Double {
  let n = stats_dist_student_series_len(s)
  if n == 0 { 0.0 } else {
    let m = stats_dist_student_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn stats_dist_student_series_std(s : StatsdiststudentSeries) -> Double { stats_dist_student_sqrt(stats_dist_student_series_var(s)) }

pub fn stats_dist_student_series_median(s : StatsdiststudentSeries) -> Double {
  let n = stats_dist_student_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = stats_dist_student_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn stats_dist_student_series_scale(s : StatsdiststudentSeries, f : Double) -> StatsdiststudentSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = stats_dist_student_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn stats_dist_student_series_add(a : StatsdiststudentSeries, b : StatsdiststudentSeries) -> StatsdiststudentSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = stats_dist_student_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn stats_dist_student_series_sub(a : StatsdiststudentSeries, b : StatsdiststudentSeries) -> StatsdiststudentSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = stats_dist_student_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn stats_dist_student_series_normalize(s : StatsdiststudentSeries) -> StatsdiststudentSeries {
  let mn = stats_dist_student_series_min(s)
  let mx = stats_dist_student_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = stats_dist_student_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn stats_dist_student_series_cumsum(s : StatsdiststudentSeries) -> StatsdiststudentSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = stats_dist_student_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn stats_dist_student_series_to_string(s : StatsdiststudentSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + stats_dist_student_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct StatsdiststudentMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn stats_dist_student_make_matrix(rows : Int, cols : Int, val : Double) -> StatsdiststudentMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn stats_dist_student_matrix_identity(n : Int) -> StatsdiststudentMatrix {
  let m = stats_dist_student_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn stats_dist_student_matrix_get(m : StatsdiststudentMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn stats_dist_student_matrix_transpose(m : StatsdiststudentMatrix) -> StatsdiststudentMatrix {
  let result = stats_dist_student_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn stats_dist_student_matrix_add(a : StatsdiststudentMatrix, b : StatsdiststudentMatrix) -> StatsdiststudentMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = stats_dist_student_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn stats_dist_student_matrix_scale(m : StatsdiststudentMatrix, s : Double) -> StatsdiststudentMatrix {
  let result = stats_dist_student_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn stats_dist_student_matrix_multiply(a : StatsdiststudentMatrix, b : StatsdiststudentMatrix) -> StatsdiststudentMatrix {
  if a.cols != b.rows { return stats_dist_student_make_matrix(a.rows, b.cols, 0.0) }
  let result = stats_dist_student_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn stats_dist_student_matrix_trace(m : StatsdiststudentMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn stats_dist_student_matrix_det(m : StatsdiststudentMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn stats_dist_student_matrix_norm(m : StatsdiststudentMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  stats_dist_student_sqrt(sum)
}

pub fn stats_dist_student_matrix_to_string(m : StatsdiststudentMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + stats_dist_student_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct StatsdiststudentVector {
  comps : Array[Double]
  dim : Int
}

pub fn stats_dist_student_make_vector(comps : Array[Double]) -> StatsdiststudentVector {
  { comps, dim: comps.length() }
}

pub fn stats_dist_student_vector_zero(dim : Int) -> StatsdiststudentVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn stats_dist_student_vector_add(a : StatsdiststudentVector, b : StatsdiststudentVector) -> StatsdiststudentVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = stats_dist_student_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn stats_dist_student_vector_sub(a : StatsdiststudentVector, b : StatsdiststudentVector) -> StatsdiststudentVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = stats_dist_student_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn stats_dist_student_vector_scale(v : StatsdiststudentVector, s : Double) -> StatsdiststudentVector {
  let mut result = []
  for i in 0..<v.dim { result = stats_dist_student_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn stats_dist_student_vector_dot(a : StatsdiststudentVector, b : StatsdiststudentVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn stats_dist_student_vector_norm(v : StatsdiststudentVector) -> Double { stats_dist_student_sqrt(stats_dist_student_vector_dot(v, v)) }

pub fn stats_dist_student_vector_normalize(v : StatsdiststudentVector) -> StatsdiststudentVector {
  let n = stats_dist_student_vector_norm(v)
  if n < 0.0000001 { v } else { stats_dist_student_vector_scale(v, 1.0 / n) }
}

pub fn stats_dist_student_vector_dist(a : StatsdiststudentVector, b : StatsdiststudentVector) -> Double {
  stats_dist_student_vector_norm(stats_dist_student_vector_sub(a, b))
}

pub fn stats_dist_student_vector_to_string(v : StatsdiststudentVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + stats_dist_student_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn stats_dist_student_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn stats_dist_student_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = stats_dist_student_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn stats_dist_student_std(data : Array[Double]) -> Double { stats_dist_student_sqrt(stats_dist_student_var(data)) }

pub fn stats_dist_student_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = stats_dist_student_mean(a); let mb = stats_dist_student_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn stats_dist_student_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = stats_dist_student_std(a); let sb = stats_dist_student_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { stats_dist_student_cov(a, b) / (sa * sb) }
}

pub fn stats_dist_student_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = stats_dist_student_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn stats_dist_student_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn stats_dist_student_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn stats_dist_student_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  stats_dist_student_sqrt(stats_dist_student_mse(pred, labels))
}

pub fn stats_dist_student_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + stats_dist_student_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn stats_dist_student_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = stats_dist_student_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn stats_dist_student_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn stats_dist_student_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn stats_dist_student_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = stats_dist_student_precision(pred, labels, pos); let r = stats_dist_student_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn stats_dist_student_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn stats_dist_student_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = stats_dist_student_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn stats_dist_student_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn stats_dist_student_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn stats_dist_student_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = stats_dist_student_gcd(a, b)
    (a / g) * b
  }
}

pub fn stats_dist_student_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn stats_dist_student_fibonacci(n : Int) -> Int {
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

pub fn stats_dist_student_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = stats_dist_student_min(data); let mx = stats_dist_student_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn stats_dist_student_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = stats_dist_student_mean(data); let sd = stats_dist_student_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn stats_dist_student_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn stats_dist_student_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn stats_dist_student_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn stats_dist_student_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn stats_dist_student_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn stats_dist_student_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn stats_dist_student_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn stats_dist_student_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn stats_dist_student_dbl(x : Double) -> String {
  let i = if x >= 0.0 { stats_dist_student_int(x) } else { -stats_dist_student_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { stats_dist_student_int(f * 1000000.0) } else { stats_dist_student_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn stats_dist_student_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn stats_dist_student_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct StatsdiststudentFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_student_frame_make(size : Int) -> StatsdiststudentFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_student_frame_len(s : StatsdiststudentFrame) -> Int { s.size }

pub fn stats_dist_student_frame_get(s : StatsdiststudentFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_student_frame_set(s : StatsdiststudentFrame, i : Int, v : Double) -> StatsdiststudentFrame {
  let result = stats_dist_student_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_student_frame_sum(s : StatsdiststudentFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_student_frame_mean(s : StatsdiststudentFrame) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_student_frame_sum(s) / s.size.to_double() }
}

pub fn stats_dist_student_frame_scale(s : StatsdiststudentFrame, f : Double) -> StatsdiststudentFrame {
  let result = stats_dist_student_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_student_frame_add(a : StatsdiststudentFrame, b : StatsdiststudentFrame) -> StatsdiststudentFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_student_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_student_frame_copy(s : StatsdiststudentFrame) -> StatsdiststudentFrame {
  let result = stats_dist_student_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_student_frame_fill(s : StatsdiststudentFrame, v : Double) -> StatsdiststudentFrame {
  let result = stats_dist_student_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_student_frame_min(s : StatsdiststudentFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_student_frame_max(s : StatsdiststudentFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_student_frame_to_string(s : StatsdiststudentFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdiststudentTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_student_table_make(size : Int) -> StatsdiststudentTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_student_table_len(s : StatsdiststudentTable) -> Int { s.size }

pub fn stats_dist_student_table_get(s : StatsdiststudentTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_student_table_set(s : StatsdiststudentTable, i : Int, v : Double) -> StatsdiststudentTable {
  let result = stats_dist_student_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_student_table_sum(s : StatsdiststudentTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_student_table_mean(s : StatsdiststudentTable) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_student_table_sum(s) / s.size.to_double() }
}

pub fn stats_dist_student_table_scale(s : StatsdiststudentTable, f : Double) -> StatsdiststudentTable {
  let result = stats_dist_student_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_student_table_add(a : StatsdiststudentTable, b : StatsdiststudentTable) -> StatsdiststudentTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_student_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_student_table_copy(s : StatsdiststudentTable) -> StatsdiststudentTable {
  let result = stats_dist_student_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_student_table_fill(s : StatsdiststudentTable, v : Double) -> StatsdiststudentTable {
  let result = stats_dist_student_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_student_table_min(s : StatsdiststudentTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_student_table_max(s : StatsdiststudentTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_student_table_to_string(s : StatsdiststudentTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdiststudentGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_student_graphn_make(size : Int) -> StatsdiststudentGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_student_graphn_len(s : StatsdiststudentGraphN) -> Int { s.size }

pub fn stats_dist_student_graphn_get(s : StatsdiststudentGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_student_graphn_set(s : StatsdiststudentGraphN, i : Int, v : Double) -> StatsdiststudentGraphN {
  let result = stats_dist_student_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_student_graphn_sum(s : StatsdiststudentGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_student_graphn_mean(s : StatsdiststudentGraphN) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_student_graphn_sum(s) / s.size.to_double() }
}

pub fn stats_dist_student_graphn_scale(s : StatsdiststudentGraphN, f : Double) -> StatsdiststudentGraphN {
  let result = stats_dist_student_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_student_graphn_add(a : StatsdiststudentGraphN, b : StatsdiststudentGraphN) -> StatsdiststudentGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_student_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_student_graphn_copy(s : StatsdiststudentGraphN) -> StatsdiststudentGraphN {
  let result = stats_dist_student_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_student_graphn_fill(s : StatsdiststudentGraphN, v : Double) -> StatsdiststudentGraphN {
  let result = stats_dist_student_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_student_graphn_min(s : StatsdiststudentGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_student_graphn_max(s : StatsdiststudentGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_student_graphn_to_string(s : StatsdiststudentGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdiststudentNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_student_node_make(size : Int) -> StatsdiststudentNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_student_node_len(s : StatsdiststudentNode) -> Int { s.size }

pub fn stats_dist_student_node_get(s : StatsdiststudentNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_student_node_set(s : StatsdiststudentNode, i : Int, v : Double) -> StatsdiststudentNode {
  let result = stats_dist_student_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_student_node_sum(s : StatsdiststudentNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_student_node_mean(s : StatsdiststudentNode) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_student_node_sum(s) / s.size.to_double() }
}

pub fn stats_dist_student_node_scale(s : StatsdiststudentNode, f : Double) -> StatsdiststudentNode {
  let result = stats_dist_student_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_student_node_add(a : StatsdiststudentNode, b : StatsdiststudentNode) -> StatsdiststudentNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_student_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_student_node_copy(s : StatsdiststudentNode) -> StatsdiststudentNode {
  let result = stats_dist_student_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_student_node_fill(s : StatsdiststudentNode, v : Double) -> StatsdiststudentNode {
  let result = stats_dist_student_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_student_node_min(s : StatsdiststudentNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_student_node_max(s : StatsdiststudentNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_student_node_to_string(s : StatsdiststudentNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdiststudentEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_student_edge_make(size : Int) -> StatsdiststudentEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_student_edge_len(s : StatsdiststudentEdge) -> Int { s.size }

pub fn stats_dist_student_edge_get(s : StatsdiststudentEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_student_edge_set(s : StatsdiststudentEdge, i : Int, v : Double) -> StatsdiststudentEdge {
  let result = stats_dist_student_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_student_edge_sum(s : StatsdiststudentEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_student_edge_mean(s : StatsdiststudentEdge) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_student_edge_sum(s) / s.size.to_double() }
}

pub fn stats_dist_student_edge_scale(s : StatsdiststudentEdge, f : Double) -> StatsdiststudentEdge {
  let result = stats_dist_student_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_student_edge_add(a : StatsdiststudentEdge, b : StatsdiststudentEdge) -> StatsdiststudentEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_student_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_student_edge_copy(s : StatsdiststudentEdge) -> StatsdiststudentEdge {
  let result = stats_dist_student_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_student_edge_fill(s : StatsdiststudentEdge, v : Double) -> StatsdiststudentEdge {
  let result = stats_dist_student_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_student_edge_min(s : StatsdiststudentEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_student_edge_max(s : StatsdiststudentEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_student_edge_to_string(s : StatsdiststudentEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdiststudentPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_student_path_make(size : Int) -> StatsdiststudentPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_student_path_len(s : StatsdiststudentPath) -> Int { s.size }

pub fn stats_dist_student_path_get(s : StatsdiststudentPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_student_path_set(s : StatsdiststudentPath, i : Int, v : Double) -> StatsdiststudentPath {
  let result = stats_dist_student_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_student_path_sum(s : StatsdiststudentPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_student_path_mean(s : StatsdiststudentPath) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_student_path_sum(s) / s.size.to_double() }
}

pub fn stats_dist_student_path_scale(s : StatsdiststudentPath, f : Double) -> StatsdiststudentPath {
  let result = stats_dist_student_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_student_path_add(a : StatsdiststudentPath, b : StatsdiststudentPath) -> StatsdiststudentPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_student_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_student_path_copy(s : StatsdiststudentPath) -> StatsdiststudentPath {
  let result = stats_dist_student_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_student_path_fill(s : StatsdiststudentPath, v : Double) -> StatsdiststudentPath {
  let result = stats_dist_student_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_student_path_min(s : StatsdiststudentPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_student_path_max(s : StatsdiststudentPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_student_path_to_string(s : StatsdiststudentPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdiststudentCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_student_cluster_make(size : Int) -> StatsdiststudentCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_student_cluster_len(s : StatsdiststudentCluster) -> Int { s.size }

pub fn stats_dist_student_cluster_get(s : StatsdiststudentCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_student_cluster_set(s : StatsdiststudentCluster, i : Int, v : Double) -> StatsdiststudentCluster {
  let result = stats_dist_student_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_student_cluster_sum(s : StatsdiststudentCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_student_cluster_mean(s : StatsdiststudentCluster) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_student_cluster_sum(s) / s.size.to_double() }
}

pub fn stats_dist_student_cluster_scale(s : StatsdiststudentCluster, f : Double) -> StatsdiststudentCluster {
  let result = stats_dist_student_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_student_cluster_add(a : StatsdiststudentCluster, b : StatsdiststudentCluster) -> StatsdiststudentCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_student_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_student_cluster_copy(s : StatsdiststudentCluster) -> StatsdiststudentCluster {
  let result = stats_dist_student_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_student_cluster_fill(s : StatsdiststudentCluster, v : Double) -> StatsdiststudentCluster {
  let result = stats_dist_student_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_student_cluster_min(s : StatsdiststudentCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_student_cluster_max(s : StatsdiststudentCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_student_cluster_to_string(s : StatsdiststudentCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdiststudentModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_student_model_make(size : Int) -> StatsdiststudentModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_student_model_len(s : StatsdiststudentModel) -> Int { s.size }

pub fn stats_dist_student_model_get(s : StatsdiststudentModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_student_model_set(s : StatsdiststudentModel, i : Int, v : Double) -> StatsdiststudentModel {
  let result = stats_dist_student_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_student_model_sum(s : StatsdiststudentModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_student_model_mean(s : StatsdiststudentModel) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_student_model_sum(s) / s.size.to_double() }
}

pub fn stats_dist_student_model_scale(s : StatsdiststudentModel, f : Double) -> StatsdiststudentModel {
  let result = stats_dist_student_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_student_model_add(a : StatsdiststudentModel, b : StatsdiststudentModel) -> StatsdiststudentModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_student_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_student_model_copy(s : StatsdiststudentModel) -> StatsdiststudentModel {
  let result = stats_dist_student_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_student_model_fill(s : StatsdiststudentModel, v : Double) -> StatsdiststudentModel {
  let result = stats_dist_student_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_student_model_min(s : StatsdiststudentModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_student_model_max(s : StatsdiststudentModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_student_model_to_string(s : StatsdiststudentModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdiststudentLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_student_layer_make(size : Int) -> StatsdiststudentLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_student_layer_len(s : StatsdiststudentLayer) -> Int { s.size }

pub fn stats_dist_student_layer_get(s : StatsdiststudentLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_student_layer_set(s : StatsdiststudentLayer, i : Int, v : Double) -> StatsdiststudentLayer {
  let result = stats_dist_student_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_student_layer_sum(s : StatsdiststudentLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_student_layer_mean(s : StatsdiststudentLayer) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_student_layer_sum(s) / s.size.to_double() }
}

pub fn stats_dist_student_layer_scale(s : StatsdiststudentLayer, f : Double) -> StatsdiststudentLayer {
  let result = stats_dist_student_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_student_layer_add(a : StatsdiststudentLayer, b : StatsdiststudentLayer) -> StatsdiststudentLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_student_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_student_layer_copy(s : StatsdiststudentLayer) -> StatsdiststudentLayer {
  let result = stats_dist_student_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_student_layer_fill(s : StatsdiststudentLayer, v : Double) -> StatsdiststudentLayer {
  let result = stats_dist_student_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_student_layer_min(s : StatsdiststudentLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_student_layer_max(s : StatsdiststudentLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_student_layer_to_string(s : StatsdiststudentLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdiststudentBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_student_buffer_make(size : Int) -> StatsdiststudentBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_student_buffer_len(s : StatsdiststudentBuffer) -> Int { s.size }

pub fn stats_dist_student_buffer_get(s : StatsdiststudentBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_student_buffer_set(s : StatsdiststudentBuffer, i : Int, v : Double) -> StatsdiststudentBuffer {
  let result = stats_dist_student_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_student_buffer_sum(s : StatsdiststudentBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_student_buffer_mean(s : StatsdiststudentBuffer) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_student_buffer_sum(s) / s.size.to_double() }
}

pub fn stats_dist_student_buffer_scale(s : StatsdiststudentBuffer, f : Double) -> StatsdiststudentBuffer {
  let result = stats_dist_student_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_student_buffer_add(a : StatsdiststudentBuffer, b : StatsdiststudentBuffer) -> StatsdiststudentBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_student_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_student_buffer_copy(s : StatsdiststudentBuffer) -> StatsdiststudentBuffer {
  let result = stats_dist_student_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_student_buffer_fill(s : StatsdiststudentBuffer, v : Double) -> StatsdiststudentBuffer {
  let result = stats_dist_student_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_student_buffer_min(s : StatsdiststudentBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_student_buffer_max(s : StatsdiststudentBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_student_buffer_to_string(s : StatsdiststudentBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdiststudentCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_student_cursor_make(size : Int) -> StatsdiststudentCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_student_cursor_len(s : StatsdiststudentCursor) -> Int { s.size }

pub fn stats_dist_student_cursor_get(s : StatsdiststudentCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_student_cursor_set(s : StatsdiststudentCursor, i : Int, v : Double) -> StatsdiststudentCursor {
  let result = stats_dist_student_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_student_cursor_sum(s : StatsdiststudentCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_student_cursor_mean(s : StatsdiststudentCursor) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_student_cursor_sum(s) / s.size.to_double() }
}

pub fn stats_dist_student_cursor_scale(s : StatsdiststudentCursor, f : Double) -> StatsdiststudentCursor {
  let result = stats_dist_student_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_student_cursor_add(a : StatsdiststudentCursor, b : StatsdiststudentCursor) -> StatsdiststudentCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_student_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_student_cursor_copy(s : StatsdiststudentCursor) -> StatsdiststudentCursor {
  let result = stats_dist_student_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_student_cursor_fill(s : StatsdiststudentCursor, v : Double) -> StatsdiststudentCursor {
  let result = stats_dist_student_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_student_cursor_min(s : StatsdiststudentCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_student_cursor_max(s : StatsdiststudentCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_student_cursor_to_string(s : StatsdiststudentCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdiststudentView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_student_view_make(size : Int) -> StatsdiststudentView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_student_view_len(s : StatsdiststudentView) -> Int { s.size }

pub fn stats_dist_student_view_get(s : StatsdiststudentView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_student_view_set(s : StatsdiststudentView, i : Int, v : Double) -> StatsdiststudentView {
  let result = stats_dist_student_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_student_view_sum(s : StatsdiststudentView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_student_view_mean(s : StatsdiststudentView) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_student_view_sum(s) / s.size.to_double() }
}

pub fn stats_dist_student_view_scale(s : StatsdiststudentView, f : Double) -> StatsdiststudentView {
  let result = stats_dist_student_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_student_view_add(a : StatsdiststudentView, b : StatsdiststudentView) -> StatsdiststudentView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_student_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_student_view_copy(s : StatsdiststudentView) -> StatsdiststudentView {
  let result = stats_dist_student_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_student_view_fill(s : StatsdiststudentView, v : Double) -> StatsdiststudentView {
  let result = stats_dist_student_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_student_view_min(s : StatsdiststudentView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_student_view_max(s : StatsdiststudentView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_student_view_to_string(s : StatsdiststudentView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdiststudentRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_student_range_make(size : Int) -> StatsdiststudentRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_student_range_len(s : StatsdiststudentRange) -> Int { s.size }

pub fn stats_dist_student_range_get(s : StatsdiststudentRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_student_range_set(s : StatsdiststudentRange, i : Int, v : Double) -> StatsdiststudentRange {
  let result = stats_dist_student_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_student_range_sum(s : StatsdiststudentRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_student_range_mean(s : StatsdiststudentRange) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_student_range_sum(s) / s.size.to_double() }
}

pub fn stats_dist_student_range_scale(s : StatsdiststudentRange, f : Double) -> StatsdiststudentRange {
  let result = stats_dist_student_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_student_range_add(a : StatsdiststudentRange, b : StatsdiststudentRange) -> StatsdiststudentRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_student_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_student_range_copy(s : StatsdiststudentRange) -> StatsdiststudentRange {
  let result = stats_dist_student_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_student_range_fill(s : StatsdiststudentRange, v : Double) -> StatsdiststudentRange {
  let result = stats_dist_student_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_student_range_min(s : StatsdiststudentRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_student_range_max(s : StatsdiststudentRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_student_range_to_string(s : StatsdiststudentRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdiststudentSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_student_slice_make(size : Int) -> StatsdiststudentSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_student_slice_len(s : StatsdiststudentSlice) -> Int { s.size }

pub fn stats_dist_student_slice_get(s : StatsdiststudentSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_student_slice_set(s : StatsdiststudentSlice, i : Int, v : Double) -> StatsdiststudentSlice {
  let result = stats_dist_student_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_student_slice_sum(s : StatsdiststudentSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_student_slice_mean(s : StatsdiststudentSlice) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_student_slice_sum(s) / s.size.to_double() }
}

pub fn stats_dist_student_slice_scale(s : StatsdiststudentSlice, f : Double) -> StatsdiststudentSlice {
  let result = stats_dist_student_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_student_slice_add(a : StatsdiststudentSlice, b : StatsdiststudentSlice) -> StatsdiststudentSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_student_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_student_slice_copy(s : StatsdiststudentSlice) -> StatsdiststudentSlice {
  let result = stats_dist_student_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_student_slice_fill(s : StatsdiststudentSlice, v : Double) -> StatsdiststudentSlice {
  let result = stats_dist_student_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_student_slice_min(s : StatsdiststudentSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_student_slice_max(s : StatsdiststudentSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_student_slice_to_string(s : StatsdiststudentSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn stats_dist_student_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_dist_student_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_dist_student_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_dist_student_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_dist_student_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_dist_student_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_dist_student_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_dist_student_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_dist_student_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_dist_student_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_dist_student_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_dist_student_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_dist_student_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_dist_student_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_dist_student_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_dist_student_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_dist_student_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_dist_student_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_dist_student_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_dist_student_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_dist_student_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_dist_student_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_dist_student_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_dist_student_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_dist_student_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

