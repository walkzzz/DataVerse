///===
/// extcore/stats_model_mixed

pub(all) struct StatsmodelmixedPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn stats_model_mixed_make_point(x : Double, y : Double) -> StatsmodelmixedPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn stats_model_mixed_make_point3(x : Double, y : Double, z : Double) -> StatsmodelmixedPoint {
  { x, y, z, label: 0 }
}

pub fn stats_model_mixed_point_x(pt : StatsmodelmixedPoint) -> Double { pt.x }

pub fn stats_model_mixed_point_y(pt : StatsmodelmixedPoint) -> Double { pt.y }

pub fn stats_model_mixed_point_z(pt : StatsmodelmixedPoint) -> Double { pt.z }

pub fn stats_model_mixed_point_label(pt : StatsmodelmixedPoint) -> Int { pt.label }

pub fn stats_model_mixed_point_dist(a : StatsmodelmixedPoint, b : StatsmodelmixedPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  stats_model_mixed_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn stats_model_mixed_point_add(a : StatsmodelmixedPoint, b : StatsmodelmixedPoint) -> StatsmodelmixedPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn stats_model_mixed_point_sub(a : StatsmodelmixedPoint, b : StatsmodelmixedPoint) -> StatsmodelmixedPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn stats_model_mixed_point_scale(pt : StatsmodelmixedPoint, s : Double) -> StatsmodelmixedPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn stats_model_mixed_point_dot(a : StatsmodelmixedPoint, b : StatsmodelmixedPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn stats_model_mixed_point_cross(a : StatsmodelmixedPoint, b : StatsmodelmixedPoint) -> StatsmodelmixedPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn stats_model_mixed_point_norm(pt : StatsmodelmixedPoint) -> Double {
  stats_model_mixed_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn stats_model_mixed_point_normalize(pt : StatsmodelmixedPoint) -> StatsmodelmixedPoint {
  let n = stats_model_mixed_point_norm(pt)
  if n < 0.0000001 { pt } else { stats_model_mixed_point_scale(pt, 1.0 / n) }
}

pub fn stats_model_mixed_point_negate(pt : StatsmodelmixedPoint) -> StatsmodelmixedPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn stats_model_mixed_point_mid(a : StatsmodelmixedPoint, b : StatsmodelmixedPoint) -> StatsmodelmixedPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn stats_model_mixed_point_lerp(a : StatsmodelmixedPoint, b : StatsmodelmixedPoint, t : Double) -> StatsmodelmixedPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn stats_model_mixed_point_to_string(pt : StatsmodelmixedPoint) -> String {
  "(" + stats_model_mixed_dbl(pt.x) + ", " + stats_model_mixed_dbl(pt.y) + ", " + stats_model_mixed_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct StatsmodelmixedSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn stats_model_mixed_make_series(vals : Array[Double], name : String) -> StatsmodelmixedSeries {
  { vals, name, meta: 0 }
}

pub fn stats_model_mixed_series_len(s : StatsmodelmixedSeries) -> Int { s.vals.length() }

pub fn stats_model_mixed_series_sum(s : StatsmodelmixedSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn stats_model_mixed_series_mean(s : StatsmodelmixedSeries) -> Double {
  let n = stats_model_mixed_series_len(s)
  if n == 0 { 0.0 } else { stats_model_mixed_series_sum(s) / n.to_double() }
}

pub fn stats_model_mixed_series_min(s : StatsmodelmixedSeries) -> Double {
  let n = stats_model_mixed_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn stats_model_mixed_series_max(s : StatsmodelmixedSeries) -> Double {
  let n = stats_model_mixed_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn stats_model_mixed_series_range(s : StatsmodelmixedSeries) -> Double {
  stats_model_mixed_series_max(s) - stats_model_mixed_series_min(s)
}

pub fn stats_model_mixed_series_var(s : StatsmodelmixedSeries) -> Double {
  let n = stats_model_mixed_series_len(s)
  if n == 0 { 0.0 } else {
    let m = stats_model_mixed_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn stats_model_mixed_series_std(s : StatsmodelmixedSeries) -> Double { stats_model_mixed_sqrt(stats_model_mixed_series_var(s)) }

pub fn stats_model_mixed_series_median(s : StatsmodelmixedSeries) -> Double {
  let n = stats_model_mixed_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = stats_model_mixed_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn stats_model_mixed_series_scale(s : StatsmodelmixedSeries, f : Double) -> StatsmodelmixedSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = stats_model_mixed_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn stats_model_mixed_series_add(a : StatsmodelmixedSeries, b : StatsmodelmixedSeries) -> StatsmodelmixedSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = stats_model_mixed_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn stats_model_mixed_series_sub(a : StatsmodelmixedSeries, b : StatsmodelmixedSeries) -> StatsmodelmixedSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = stats_model_mixed_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn stats_model_mixed_series_normalize(s : StatsmodelmixedSeries) -> StatsmodelmixedSeries {
  let mn = stats_model_mixed_series_min(s)
  let mx = stats_model_mixed_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = stats_model_mixed_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn stats_model_mixed_series_cumsum(s : StatsmodelmixedSeries) -> StatsmodelmixedSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = stats_model_mixed_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn stats_model_mixed_series_to_string(s : StatsmodelmixedSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + stats_model_mixed_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct StatsmodelmixedMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn stats_model_mixed_make_matrix(rows : Int, cols : Int, val : Double) -> StatsmodelmixedMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn stats_model_mixed_matrix_identity(n : Int) -> StatsmodelmixedMatrix {
  let m = stats_model_mixed_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn stats_model_mixed_matrix_get(m : StatsmodelmixedMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn stats_model_mixed_matrix_transpose(m : StatsmodelmixedMatrix) -> StatsmodelmixedMatrix {
  let result = stats_model_mixed_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn stats_model_mixed_matrix_add(a : StatsmodelmixedMatrix, b : StatsmodelmixedMatrix) -> StatsmodelmixedMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = stats_model_mixed_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn stats_model_mixed_matrix_scale(m : StatsmodelmixedMatrix, s : Double) -> StatsmodelmixedMatrix {
  let result = stats_model_mixed_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn stats_model_mixed_matrix_multiply(a : StatsmodelmixedMatrix, b : StatsmodelmixedMatrix) -> StatsmodelmixedMatrix {
  if a.cols != b.rows { return stats_model_mixed_make_matrix(a.rows, b.cols, 0.0) }
  let result = stats_model_mixed_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn stats_model_mixed_matrix_trace(m : StatsmodelmixedMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn stats_model_mixed_matrix_det(m : StatsmodelmixedMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn stats_model_mixed_matrix_norm(m : StatsmodelmixedMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  stats_model_mixed_sqrt(sum)
}

pub fn stats_model_mixed_matrix_to_string(m : StatsmodelmixedMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + stats_model_mixed_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct StatsmodelmixedVector {
  comps : Array[Double]
  dim : Int
}

pub fn stats_model_mixed_make_vector(comps : Array[Double]) -> StatsmodelmixedVector {
  { comps, dim: comps.length() }
}

pub fn stats_model_mixed_vector_zero(dim : Int) -> StatsmodelmixedVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn stats_model_mixed_vector_add(a : StatsmodelmixedVector, b : StatsmodelmixedVector) -> StatsmodelmixedVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = stats_model_mixed_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn stats_model_mixed_vector_sub(a : StatsmodelmixedVector, b : StatsmodelmixedVector) -> StatsmodelmixedVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = stats_model_mixed_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn stats_model_mixed_vector_scale(v : StatsmodelmixedVector, s : Double) -> StatsmodelmixedVector {
  let mut result = []
  for i in 0..<v.dim { result = stats_model_mixed_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn stats_model_mixed_vector_dot(a : StatsmodelmixedVector, b : StatsmodelmixedVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn stats_model_mixed_vector_norm(v : StatsmodelmixedVector) -> Double { stats_model_mixed_sqrt(stats_model_mixed_vector_dot(v, v)) }

pub fn stats_model_mixed_vector_normalize(v : StatsmodelmixedVector) -> StatsmodelmixedVector {
  let n = stats_model_mixed_vector_norm(v)
  if n < 0.0000001 { v } else { stats_model_mixed_vector_scale(v, 1.0 / n) }
}

pub fn stats_model_mixed_vector_dist(a : StatsmodelmixedVector, b : StatsmodelmixedVector) -> Double {
  stats_model_mixed_vector_norm(stats_model_mixed_vector_sub(a, b))
}

pub fn stats_model_mixed_vector_to_string(v : StatsmodelmixedVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + stats_model_mixed_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn stats_model_mixed_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn stats_model_mixed_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = stats_model_mixed_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn stats_model_mixed_std(data : Array[Double]) -> Double { stats_model_mixed_sqrt(stats_model_mixed_var(data)) }

pub fn stats_model_mixed_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = stats_model_mixed_mean(a); let mb = stats_model_mixed_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn stats_model_mixed_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = stats_model_mixed_std(a); let sb = stats_model_mixed_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { stats_model_mixed_cov(a, b) / (sa * sb) }
}

pub fn stats_model_mixed_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = stats_model_mixed_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn stats_model_mixed_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn stats_model_mixed_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn stats_model_mixed_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  stats_model_mixed_sqrt(stats_model_mixed_mse(pred, labels))
}

pub fn stats_model_mixed_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + stats_model_mixed_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn stats_model_mixed_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = stats_model_mixed_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn stats_model_mixed_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn stats_model_mixed_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn stats_model_mixed_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = stats_model_mixed_precision(pred, labels, pos); let r = stats_model_mixed_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn stats_model_mixed_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn stats_model_mixed_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = stats_model_mixed_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn stats_model_mixed_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn stats_model_mixed_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn stats_model_mixed_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = stats_model_mixed_gcd(a, b)
    (a / g) * b
  }
}

pub fn stats_model_mixed_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn stats_model_mixed_fibonacci(n : Int) -> Int {
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

pub fn stats_model_mixed_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = stats_model_mixed_min(data); let mx = stats_model_mixed_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn stats_model_mixed_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = stats_model_mixed_mean(data); let sd = stats_model_mixed_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn stats_model_mixed_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn stats_model_mixed_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn stats_model_mixed_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn stats_model_mixed_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn stats_model_mixed_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn stats_model_mixed_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn stats_model_mixed_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn stats_model_mixed_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn stats_model_mixed_dbl(x : Double) -> String {
  let i = if x >= 0.0 { stats_model_mixed_int(x) } else { -stats_model_mixed_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { stats_model_mixed_int(f * 1000000.0) } else { stats_model_mixed_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn stats_model_mixed_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn stats_model_mixed_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct StatsmodelmixedFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_mixed_frame_make(size : Int) -> StatsmodelmixedFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_model_mixed_frame_len(s : StatsmodelmixedFrame) -> Int { s.size }

pub fn stats_model_mixed_frame_get(s : StatsmodelmixedFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_model_mixed_frame_set(s : StatsmodelmixedFrame, i : Int, v : Double) -> StatsmodelmixedFrame {
  let result = stats_model_mixed_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_model_mixed_frame_sum(s : StatsmodelmixedFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_model_mixed_frame_mean(s : StatsmodelmixedFrame) -> Double {
  if s.size == 0 { 0.0 } else { stats_model_mixed_frame_sum(s) / s.size.to_double() }
}

pub fn stats_model_mixed_frame_scale(s : StatsmodelmixedFrame, f : Double) -> StatsmodelmixedFrame {
  let result = stats_model_mixed_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_model_mixed_frame_add(a : StatsmodelmixedFrame, b : StatsmodelmixedFrame) -> StatsmodelmixedFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_model_mixed_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_model_mixed_frame_copy(s : StatsmodelmixedFrame) -> StatsmodelmixedFrame {
  let result = stats_model_mixed_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_model_mixed_frame_fill(s : StatsmodelmixedFrame, v : Double) -> StatsmodelmixedFrame {
  let result = stats_model_mixed_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_model_mixed_frame_min(s : StatsmodelmixedFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_model_mixed_frame_max(s : StatsmodelmixedFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_model_mixed_frame_to_string(s : StatsmodelmixedFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsmodelmixedTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_mixed_table_make(size : Int) -> StatsmodelmixedTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_model_mixed_table_len(s : StatsmodelmixedTable) -> Int { s.size }

pub fn stats_model_mixed_table_get(s : StatsmodelmixedTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_model_mixed_table_set(s : StatsmodelmixedTable, i : Int, v : Double) -> StatsmodelmixedTable {
  let result = stats_model_mixed_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_model_mixed_table_sum(s : StatsmodelmixedTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_model_mixed_table_mean(s : StatsmodelmixedTable) -> Double {
  if s.size == 0 { 0.0 } else { stats_model_mixed_table_sum(s) / s.size.to_double() }
}

pub fn stats_model_mixed_table_scale(s : StatsmodelmixedTable, f : Double) -> StatsmodelmixedTable {
  let result = stats_model_mixed_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_model_mixed_table_add(a : StatsmodelmixedTable, b : StatsmodelmixedTable) -> StatsmodelmixedTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_model_mixed_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_model_mixed_table_copy(s : StatsmodelmixedTable) -> StatsmodelmixedTable {
  let result = stats_model_mixed_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_model_mixed_table_fill(s : StatsmodelmixedTable, v : Double) -> StatsmodelmixedTable {
  let result = stats_model_mixed_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_model_mixed_table_min(s : StatsmodelmixedTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_model_mixed_table_max(s : StatsmodelmixedTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_model_mixed_table_to_string(s : StatsmodelmixedTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsmodelmixedGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_mixed_graphn_make(size : Int) -> StatsmodelmixedGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_model_mixed_graphn_len(s : StatsmodelmixedGraphN) -> Int { s.size }

pub fn stats_model_mixed_graphn_get(s : StatsmodelmixedGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_model_mixed_graphn_set(s : StatsmodelmixedGraphN, i : Int, v : Double) -> StatsmodelmixedGraphN {
  let result = stats_model_mixed_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_model_mixed_graphn_sum(s : StatsmodelmixedGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_model_mixed_graphn_mean(s : StatsmodelmixedGraphN) -> Double {
  if s.size == 0 { 0.0 } else { stats_model_mixed_graphn_sum(s) / s.size.to_double() }
}

pub fn stats_model_mixed_graphn_scale(s : StatsmodelmixedGraphN, f : Double) -> StatsmodelmixedGraphN {
  let result = stats_model_mixed_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_model_mixed_graphn_add(a : StatsmodelmixedGraphN, b : StatsmodelmixedGraphN) -> StatsmodelmixedGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_model_mixed_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_model_mixed_graphn_copy(s : StatsmodelmixedGraphN) -> StatsmodelmixedGraphN {
  let result = stats_model_mixed_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_model_mixed_graphn_fill(s : StatsmodelmixedGraphN, v : Double) -> StatsmodelmixedGraphN {
  let result = stats_model_mixed_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_model_mixed_graphn_min(s : StatsmodelmixedGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_model_mixed_graphn_max(s : StatsmodelmixedGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_model_mixed_graphn_to_string(s : StatsmodelmixedGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsmodelmixedNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_mixed_node_make(size : Int) -> StatsmodelmixedNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_model_mixed_node_len(s : StatsmodelmixedNode) -> Int { s.size }

pub fn stats_model_mixed_node_get(s : StatsmodelmixedNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_model_mixed_node_set(s : StatsmodelmixedNode, i : Int, v : Double) -> StatsmodelmixedNode {
  let result = stats_model_mixed_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_model_mixed_node_sum(s : StatsmodelmixedNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_model_mixed_node_mean(s : StatsmodelmixedNode) -> Double {
  if s.size == 0 { 0.0 } else { stats_model_mixed_node_sum(s) / s.size.to_double() }
}

pub fn stats_model_mixed_node_scale(s : StatsmodelmixedNode, f : Double) -> StatsmodelmixedNode {
  let result = stats_model_mixed_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_model_mixed_node_add(a : StatsmodelmixedNode, b : StatsmodelmixedNode) -> StatsmodelmixedNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_model_mixed_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_model_mixed_node_copy(s : StatsmodelmixedNode) -> StatsmodelmixedNode {
  let result = stats_model_mixed_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_model_mixed_node_fill(s : StatsmodelmixedNode, v : Double) -> StatsmodelmixedNode {
  let result = stats_model_mixed_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_model_mixed_node_min(s : StatsmodelmixedNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_model_mixed_node_max(s : StatsmodelmixedNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_model_mixed_node_to_string(s : StatsmodelmixedNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsmodelmixedEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_mixed_edge_make(size : Int) -> StatsmodelmixedEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_model_mixed_edge_len(s : StatsmodelmixedEdge) -> Int { s.size }

pub fn stats_model_mixed_edge_get(s : StatsmodelmixedEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_model_mixed_edge_set(s : StatsmodelmixedEdge, i : Int, v : Double) -> StatsmodelmixedEdge {
  let result = stats_model_mixed_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_model_mixed_edge_sum(s : StatsmodelmixedEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_model_mixed_edge_mean(s : StatsmodelmixedEdge) -> Double {
  if s.size == 0 { 0.0 } else { stats_model_mixed_edge_sum(s) / s.size.to_double() }
}

pub fn stats_model_mixed_edge_scale(s : StatsmodelmixedEdge, f : Double) -> StatsmodelmixedEdge {
  let result = stats_model_mixed_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_model_mixed_edge_add(a : StatsmodelmixedEdge, b : StatsmodelmixedEdge) -> StatsmodelmixedEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_model_mixed_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_model_mixed_edge_copy(s : StatsmodelmixedEdge) -> StatsmodelmixedEdge {
  let result = stats_model_mixed_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_model_mixed_edge_fill(s : StatsmodelmixedEdge, v : Double) -> StatsmodelmixedEdge {
  let result = stats_model_mixed_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_model_mixed_edge_min(s : StatsmodelmixedEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_model_mixed_edge_max(s : StatsmodelmixedEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_model_mixed_edge_to_string(s : StatsmodelmixedEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsmodelmixedPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_mixed_path_make(size : Int) -> StatsmodelmixedPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_model_mixed_path_len(s : StatsmodelmixedPath) -> Int { s.size }

pub fn stats_model_mixed_path_get(s : StatsmodelmixedPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_model_mixed_path_set(s : StatsmodelmixedPath, i : Int, v : Double) -> StatsmodelmixedPath {
  let result = stats_model_mixed_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_model_mixed_path_sum(s : StatsmodelmixedPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_model_mixed_path_mean(s : StatsmodelmixedPath) -> Double {
  if s.size == 0 { 0.0 } else { stats_model_mixed_path_sum(s) / s.size.to_double() }
}

pub fn stats_model_mixed_path_scale(s : StatsmodelmixedPath, f : Double) -> StatsmodelmixedPath {
  let result = stats_model_mixed_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_model_mixed_path_add(a : StatsmodelmixedPath, b : StatsmodelmixedPath) -> StatsmodelmixedPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_model_mixed_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_model_mixed_path_copy(s : StatsmodelmixedPath) -> StatsmodelmixedPath {
  let result = stats_model_mixed_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_model_mixed_path_fill(s : StatsmodelmixedPath, v : Double) -> StatsmodelmixedPath {
  let result = stats_model_mixed_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_model_mixed_path_min(s : StatsmodelmixedPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_model_mixed_path_max(s : StatsmodelmixedPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_model_mixed_path_to_string(s : StatsmodelmixedPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsmodelmixedCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_mixed_cluster_make(size : Int) -> StatsmodelmixedCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_model_mixed_cluster_len(s : StatsmodelmixedCluster) -> Int { s.size }

pub fn stats_model_mixed_cluster_get(s : StatsmodelmixedCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_model_mixed_cluster_set(s : StatsmodelmixedCluster, i : Int, v : Double) -> StatsmodelmixedCluster {
  let result = stats_model_mixed_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_model_mixed_cluster_sum(s : StatsmodelmixedCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_model_mixed_cluster_mean(s : StatsmodelmixedCluster) -> Double {
  if s.size == 0 { 0.0 } else { stats_model_mixed_cluster_sum(s) / s.size.to_double() }
}

pub fn stats_model_mixed_cluster_scale(s : StatsmodelmixedCluster, f : Double) -> StatsmodelmixedCluster {
  let result = stats_model_mixed_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_model_mixed_cluster_add(a : StatsmodelmixedCluster, b : StatsmodelmixedCluster) -> StatsmodelmixedCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_model_mixed_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_model_mixed_cluster_copy(s : StatsmodelmixedCluster) -> StatsmodelmixedCluster {
  let result = stats_model_mixed_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_model_mixed_cluster_fill(s : StatsmodelmixedCluster, v : Double) -> StatsmodelmixedCluster {
  let result = stats_model_mixed_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_model_mixed_cluster_min(s : StatsmodelmixedCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_model_mixed_cluster_max(s : StatsmodelmixedCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_model_mixed_cluster_to_string(s : StatsmodelmixedCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsmodelmixedModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_mixed_model_make(size : Int) -> StatsmodelmixedModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_model_mixed_model_len(s : StatsmodelmixedModel) -> Int { s.size }

pub fn stats_model_mixed_model_get(s : StatsmodelmixedModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_model_mixed_model_set(s : StatsmodelmixedModel, i : Int, v : Double) -> StatsmodelmixedModel {
  let result = stats_model_mixed_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_model_mixed_model_sum(s : StatsmodelmixedModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_model_mixed_model_mean(s : StatsmodelmixedModel) -> Double {
  if s.size == 0 { 0.0 } else { stats_model_mixed_model_sum(s) / s.size.to_double() }
}

pub fn stats_model_mixed_model_scale(s : StatsmodelmixedModel, f : Double) -> StatsmodelmixedModel {
  let result = stats_model_mixed_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_model_mixed_model_add(a : StatsmodelmixedModel, b : StatsmodelmixedModel) -> StatsmodelmixedModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_model_mixed_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_model_mixed_model_copy(s : StatsmodelmixedModel) -> StatsmodelmixedModel {
  let result = stats_model_mixed_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_model_mixed_model_fill(s : StatsmodelmixedModel, v : Double) -> StatsmodelmixedModel {
  let result = stats_model_mixed_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_model_mixed_model_min(s : StatsmodelmixedModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_model_mixed_model_max(s : StatsmodelmixedModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_model_mixed_model_to_string(s : StatsmodelmixedModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsmodelmixedLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_mixed_layer_make(size : Int) -> StatsmodelmixedLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_model_mixed_layer_len(s : StatsmodelmixedLayer) -> Int { s.size }

pub fn stats_model_mixed_layer_get(s : StatsmodelmixedLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_model_mixed_layer_set(s : StatsmodelmixedLayer, i : Int, v : Double) -> StatsmodelmixedLayer {
  let result = stats_model_mixed_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_model_mixed_layer_sum(s : StatsmodelmixedLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_model_mixed_layer_mean(s : StatsmodelmixedLayer) -> Double {
  if s.size == 0 { 0.0 } else { stats_model_mixed_layer_sum(s) / s.size.to_double() }
}

pub fn stats_model_mixed_layer_scale(s : StatsmodelmixedLayer, f : Double) -> StatsmodelmixedLayer {
  let result = stats_model_mixed_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_model_mixed_layer_add(a : StatsmodelmixedLayer, b : StatsmodelmixedLayer) -> StatsmodelmixedLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_model_mixed_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_model_mixed_layer_copy(s : StatsmodelmixedLayer) -> StatsmodelmixedLayer {
  let result = stats_model_mixed_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_model_mixed_layer_fill(s : StatsmodelmixedLayer, v : Double) -> StatsmodelmixedLayer {
  let result = stats_model_mixed_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_model_mixed_layer_min(s : StatsmodelmixedLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_model_mixed_layer_max(s : StatsmodelmixedLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_model_mixed_layer_to_string(s : StatsmodelmixedLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsmodelmixedBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_mixed_buffer_make(size : Int) -> StatsmodelmixedBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_model_mixed_buffer_len(s : StatsmodelmixedBuffer) -> Int { s.size }

pub fn stats_model_mixed_buffer_get(s : StatsmodelmixedBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_model_mixed_buffer_set(s : StatsmodelmixedBuffer, i : Int, v : Double) -> StatsmodelmixedBuffer {
  let result = stats_model_mixed_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_model_mixed_buffer_sum(s : StatsmodelmixedBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_model_mixed_buffer_mean(s : StatsmodelmixedBuffer) -> Double {
  if s.size == 0 { 0.0 } else { stats_model_mixed_buffer_sum(s) / s.size.to_double() }
}

pub fn stats_model_mixed_buffer_scale(s : StatsmodelmixedBuffer, f : Double) -> StatsmodelmixedBuffer {
  let result = stats_model_mixed_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_model_mixed_buffer_add(a : StatsmodelmixedBuffer, b : StatsmodelmixedBuffer) -> StatsmodelmixedBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_model_mixed_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_model_mixed_buffer_copy(s : StatsmodelmixedBuffer) -> StatsmodelmixedBuffer {
  let result = stats_model_mixed_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_model_mixed_buffer_fill(s : StatsmodelmixedBuffer, v : Double) -> StatsmodelmixedBuffer {
  let result = stats_model_mixed_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_model_mixed_buffer_min(s : StatsmodelmixedBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_model_mixed_buffer_max(s : StatsmodelmixedBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_model_mixed_buffer_to_string(s : StatsmodelmixedBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsmodelmixedCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_mixed_cursor_make(size : Int) -> StatsmodelmixedCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_model_mixed_cursor_len(s : StatsmodelmixedCursor) -> Int { s.size }

pub fn stats_model_mixed_cursor_get(s : StatsmodelmixedCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_model_mixed_cursor_set(s : StatsmodelmixedCursor, i : Int, v : Double) -> StatsmodelmixedCursor {
  let result = stats_model_mixed_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_model_mixed_cursor_sum(s : StatsmodelmixedCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_model_mixed_cursor_mean(s : StatsmodelmixedCursor) -> Double {
  if s.size == 0 { 0.0 } else { stats_model_mixed_cursor_sum(s) / s.size.to_double() }
}

pub fn stats_model_mixed_cursor_scale(s : StatsmodelmixedCursor, f : Double) -> StatsmodelmixedCursor {
  let result = stats_model_mixed_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_model_mixed_cursor_add(a : StatsmodelmixedCursor, b : StatsmodelmixedCursor) -> StatsmodelmixedCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_model_mixed_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_model_mixed_cursor_copy(s : StatsmodelmixedCursor) -> StatsmodelmixedCursor {
  let result = stats_model_mixed_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_model_mixed_cursor_fill(s : StatsmodelmixedCursor, v : Double) -> StatsmodelmixedCursor {
  let result = stats_model_mixed_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_model_mixed_cursor_min(s : StatsmodelmixedCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_model_mixed_cursor_max(s : StatsmodelmixedCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_model_mixed_cursor_to_string(s : StatsmodelmixedCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsmodelmixedView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_mixed_view_make(size : Int) -> StatsmodelmixedView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_model_mixed_view_len(s : StatsmodelmixedView) -> Int { s.size }

pub fn stats_model_mixed_view_get(s : StatsmodelmixedView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_model_mixed_view_set(s : StatsmodelmixedView, i : Int, v : Double) -> StatsmodelmixedView {
  let result = stats_model_mixed_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_model_mixed_view_sum(s : StatsmodelmixedView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_model_mixed_view_mean(s : StatsmodelmixedView) -> Double {
  if s.size == 0 { 0.0 } else { stats_model_mixed_view_sum(s) / s.size.to_double() }
}

pub fn stats_model_mixed_view_scale(s : StatsmodelmixedView, f : Double) -> StatsmodelmixedView {
  let result = stats_model_mixed_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_model_mixed_view_add(a : StatsmodelmixedView, b : StatsmodelmixedView) -> StatsmodelmixedView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_model_mixed_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_model_mixed_view_copy(s : StatsmodelmixedView) -> StatsmodelmixedView {
  let result = stats_model_mixed_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_model_mixed_view_fill(s : StatsmodelmixedView, v : Double) -> StatsmodelmixedView {
  let result = stats_model_mixed_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_model_mixed_view_min(s : StatsmodelmixedView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_model_mixed_view_max(s : StatsmodelmixedView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_model_mixed_view_to_string(s : StatsmodelmixedView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsmodelmixedRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_mixed_range_make(size : Int) -> StatsmodelmixedRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_model_mixed_range_len(s : StatsmodelmixedRange) -> Int { s.size }

pub fn stats_model_mixed_range_get(s : StatsmodelmixedRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_model_mixed_range_set(s : StatsmodelmixedRange, i : Int, v : Double) -> StatsmodelmixedRange {
  let result = stats_model_mixed_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_model_mixed_range_sum(s : StatsmodelmixedRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_model_mixed_range_mean(s : StatsmodelmixedRange) -> Double {
  if s.size == 0 { 0.0 } else { stats_model_mixed_range_sum(s) / s.size.to_double() }
}

pub fn stats_model_mixed_range_scale(s : StatsmodelmixedRange, f : Double) -> StatsmodelmixedRange {
  let result = stats_model_mixed_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_model_mixed_range_add(a : StatsmodelmixedRange, b : StatsmodelmixedRange) -> StatsmodelmixedRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_model_mixed_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_model_mixed_range_copy(s : StatsmodelmixedRange) -> StatsmodelmixedRange {
  let result = stats_model_mixed_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_model_mixed_range_fill(s : StatsmodelmixedRange, v : Double) -> StatsmodelmixedRange {
  let result = stats_model_mixed_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_model_mixed_range_min(s : StatsmodelmixedRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_model_mixed_range_max(s : StatsmodelmixedRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_model_mixed_range_to_string(s : StatsmodelmixedRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsmodelmixedSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_mixed_slice_make(size : Int) -> StatsmodelmixedSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_model_mixed_slice_len(s : StatsmodelmixedSlice) -> Int { s.size }

pub fn stats_model_mixed_slice_get(s : StatsmodelmixedSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_model_mixed_slice_set(s : StatsmodelmixedSlice, i : Int, v : Double) -> StatsmodelmixedSlice {
  let result = stats_model_mixed_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_model_mixed_slice_sum(s : StatsmodelmixedSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_model_mixed_slice_mean(s : StatsmodelmixedSlice) -> Double {
  if s.size == 0 { 0.0 } else { stats_model_mixed_slice_sum(s) / s.size.to_double() }
}

pub fn stats_model_mixed_slice_scale(s : StatsmodelmixedSlice, f : Double) -> StatsmodelmixedSlice {
  let result = stats_model_mixed_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_model_mixed_slice_add(a : StatsmodelmixedSlice, b : StatsmodelmixedSlice) -> StatsmodelmixedSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_model_mixed_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_model_mixed_slice_copy(s : StatsmodelmixedSlice) -> StatsmodelmixedSlice {
  let result = stats_model_mixed_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_model_mixed_slice_fill(s : StatsmodelmixedSlice, v : Double) -> StatsmodelmixedSlice {
  let result = stats_model_mixed_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_model_mixed_slice_min(s : StatsmodelmixedSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_model_mixed_slice_max(s : StatsmodelmixedSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_model_mixed_slice_to_string(s : StatsmodelmixedSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn stats_model_mixed_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_model_mixed_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_model_mixed_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_model_mixed_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_model_mixed_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_model_mixed_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_model_mixed_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_model_mixed_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_model_mixed_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_model_mixed_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_model_mixed_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_model_mixed_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_model_mixed_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_model_mixed_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_model_mixed_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_model_mixed_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_model_mixed_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_model_mixed_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_model_mixed_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_model_mixed_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_model_mixed_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_model_mixed_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_model_mixed_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_model_mixed_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_model_mixed_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

