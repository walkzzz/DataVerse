///===
/// extcore/stats_infer_bayesian

pub(all) struct StatsinferbayesianPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn stats_infer_bayesian_make_point(x : Double, y : Double) -> StatsinferbayesianPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn stats_infer_bayesian_make_point3(x : Double, y : Double, z : Double) -> StatsinferbayesianPoint {
  { x, y, z, label: 0 }
}

pub fn stats_infer_bayesian_point_x(pt : StatsinferbayesianPoint) -> Double { pt.x }

pub fn stats_infer_bayesian_point_y(pt : StatsinferbayesianPoint) -> Double { pt.y }

pub fn stats_infer_bayesian_point_z(pt : StatsinferbayesianPoint) -> Double { pt.z }

pub fn stats_infer_bayesian_point_label(pt : StatsinferbayesianPoint) -> Int { pt.label }

pub fn stats_infer_bayesian_point_dist(a : StatsinferbayesianPoint, b : StatsinferbayesianPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn stats_infer_bayesian_point_add(a : StatsinferbayesianPoint, b : StatsinferbayesianPoint) -> StatsinferbayesianPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn stats_infer_bayesian_point_sub(a : StatsinferbayesianPoint, b : StatsinferbayesianPoint) -> StatsinferbayesianPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn stats_infer_bayesian_point_scale(pt : StatsinferbayesianPoint, s : Double) -> StatsinferbayesianPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn stats_infer_bayesian_point_dot(a : StatsinferbayesianPoint, b : StatsinferbayesianPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn stats_infer_bayesian_point_cross(a : StatsinferbayesianPoint, b : StatsinferbayesianPoint) -> StatsinferbayesianPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn stats_infer_bayesian_point_norm(pt : StatsinferbayesianPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn stats_infer_bayesian_point_normalize(pt : StatsinferbayesianPoint) -> StatsinferbayesianPoint {
  let n = stats_infer_bayesian_point_norm(pt)
  if n < 0.0000001 { pt } else { stats_infer_bayesian_point_scale(pt, 1.0 / n) }
}

pub fn stats_infer_bayesian_point_negate(pt : StatsinferbayesianPoint) -> StatsinferbayesianPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn stats_infer_bayesian_point_mid(a : StatsinferbayesianPoint, b : StatsinferbayesianPoint) -> StatsinferbayesianPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn stats_infer_bayesian_point_lerp(a : StatsinferbayesianPoint, b : StatsinferbayesianPoint, t : Double) -> StatsinferbayesianPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn stats_infer_bayesian_point_to_string(pt : StatsinferbayesianPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct StatsinferbayesianSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn stats_infer_bayesian_make_series(vals : Array[Double], name : String) -> StatsinferbayesianSeries {
  { vals, name, meta: 0 }
}

pub fn stats_infer_bayesian_series_len(s : StatsinferbayesianSeries) -> Int { s.vals.length() }

pub fn stats_infer_bayesian_series_sum(s : StatsinferbayesianSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn stats_infer_bayesian_series_mean(s : StatsinferbayesianSeries) -> Double {
  let n = stats_infer_bayesian_series_len(s)
  if n == 0 { 0.0 } else { stats_infer_bayesian_series_sum(s) / n.to_double() }
}

pub fn stats_infer_bayesian_series_min(s : StatsinferbayesianSeries) -> Double {
  let n = stats_infer_bayesian_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn stats_infer_bayesian_series_max(s : StatsinferbayesianSeries) -> Double {
  let n = stats_infer_bayesian_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn stats_infer_bayesian_series_range(s : StatsinferbayesianSeries) -> Double {
  stats_infer_bayesian_series_max(s) - stats_infer_bayesian_series_min(s)
}

pub fn stats_infer_bayesian_series_var(s : StatsinferbayesianSeries) -> Double {
  let n = stats_infer_bayesian_series_len(s)
  if n == 0 { 0.0 } else {
    let m = stats_infer_bayesian_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn stats_infer_bayesian_series_std(s : StatsinferbayesianSeries) -> Double { @_common.sqrt(stats_infer_bayesian_series_var(s)) }

pub fn stats_infer_bayesian_series_median(s : StatsinferbayesianSeries) -> Double {
  let n = stats_infer_bayesian_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = stats_infer_bayesian_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn stats_infer_bayesian_series_scale(s : StatsinferbayesianSeries, f : Double) -> StatsinferbayesianSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn stats_infer_bayesian_series_add(a : StatsinferbayesianSeries, b : StatsinferbayesianSeries) -> StatsinferbayesianSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn stats_infer_bayesian_series_sub(a : StatsinferbayesianSeries, b : StatsinferbayesianSeries) -> StatsinferbayesianSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn stats_infer_bayesian_series_normalize(s : StatsinferbayesianSeries) -> StatsinferbayesianSeries {
  let mn = stats_infer_bayesian_series_min(s)
  let mx = stats_infer_bayesian_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn stats_infer_bayesian_series_cumsum(s : StatsinferbayesianSeries) -> StatsinferbayesianSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn stats_infer_bayesian_series_to_string(s : StatsinferbayesianSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct StatsinferbayesianMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn stats_infer_bayesian_make_matrix(rows : Int, cols : Int, val : Double) -> StatsinferbayesianMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn stats_infer_bayesian_matrix_identity(n : Int) -> StatsinferbayesianMatrix {
  let m = stats_infer_bayesian_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn stats_infer_bayesian_matrix_get(m : StatsinferbayesianMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn stats_infer_bayesian_matrix_transpose(m : StatsinferbayesianMatrix) -> StatsinferbayesianMatrix {
  let result = stats_infer_bayesian_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn stats_infer_bayesian_matrix_add(a : StatsinferbayesianMatrix, b : StatsinferbayesianMatrix) -> StatsinferbayesianMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = stats_infer_bayesian_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn stats_infer_bayesian_matrix_scale(m : StatsinferbayesianMatrix, s : Double) -> StatsinferbayesianMatrix {
  let result = stats_infer_bayesian_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn stats_infer_bayesian_matrix_multiply(a : StatsinferbayesianMatrix, b : StatsinferbayesianMatrix) -> StatsinferbayesianMatrix {
  if a.cols != b.rows { return stats_infer_bayesian_make_matrix(a.rows, b.cols, 0.0) }
  let result = stats_infer_bayesian_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn stats_infer_bayesian_matrix_trace(m : StatsinferbayesianMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn stats_infer_bayesian_matrix_det(m : StatsinferbayesianMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn stats_infer_bayesian_matrix_norm(m : StatsinferbayesianMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn stats_infer_bayesian_matrix_to_string(m : StatsinferbayesianMatrix) -> String {
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

pub(all) struct StatsinferbayesianVector {
  comps : Array[Double]
  dim : Int
}

pub fn stats_infer_bayesian_make_vector(comps : Array[Double]) -> StatsinferbayesianVector {
  { comps, dim: comps.length() }
}

pub fn stats_infer_bayesian_vector_zero(dim : Int) -> StatsinferbayesianVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn stats_infer_bayesian_vector_add(a : StatsinferbayesianVector, b : StatsinferbayesianVector) -> StatsinferbayesianVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn stats_infer_bayesian_vector_sub(a : StatsinferbayesianVector, b : StatsinferbayesianVector) -> StatsinferbayesianVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn stats_infer_bayesian_vector_scale(v : StatsinferbayesianVector, s : Double) -> StatsinferbayesianVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn stats_infer_bayesian_vector_dot(a : StatsinferbayesianVector, b : StatsinferbayesianVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn stats_infer_bayesian_vector_norm(v : StatsinferbayesianVector) -> Double { @_common.sqrt(stats_infer_bayesian_vector_dot(v, v)) }

pub fn stats_infer_bayesian_vector_normalize(v : StatsinferbayesianVector) -> StatsinferbayesianVector {
  let n = stats_infer_bayesian_vector_norm(v)
  if n < 0.0000001 { v } else { stats_infer_bayesian_vector_scale(v, 1.0 / n) }
}

pub fn stats_infer_bayesian_vector_dist(a : StatsinferbayesianVector, b : StatsinferbayesianVector) -> Double {
  stats_infer_bayesian_vector_norm(stats_infer_bayesian_vector_sub(a, b))
}

pub fn stats_infer_bayesian_vector_to_string(v : StatsinferbayesianVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn stats_infer_bayesian_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn stats_infer_bayesian_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = stats_infer_bayesian_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn stats_infer_bayesian_std(data : Array[Double]) -> Double { @_common.sqrt(stats_infer_bayesian_var(data)) }

pub fn stats_infer_bayesian_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = stats_infer_bayesian_mean(a); let mb = stats_infer_bayesian_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn stats_infer_bayesian_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = stats_infer_bayesian_std(a); let sb = stats_infer_bayesian_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { stats_infer_bayesian_cov(a, b) / (sa * sb) }
}

pub fn stats_infer_bayesian_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = stats_infer_bayesian_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn stats_infer_bayesian_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn stats_infer_bayesian_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn stats_infer_bayesian_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  @_common.sqrt(stats_infer_bayesian_mse(pred, labels))
}

pub fn stats_infer_bayesian_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn stats_infer_bayesian_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = stats_infer_bayesian_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn stats_infer_bayesian_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn stats_infer_bayesian_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn stats_infer_bayesian_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = stats_infer_bayesian_precision(pred, labels, pos); let r = stats_infer_bayesian_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn stats_infer_bayesian_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn stats_infer_bayesian_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = stats_infer_bayesian_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn stats_infer_bayesian_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn stats_infer_bayesian_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn stats_infer_bayesian_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = stats_infer_bayesian_gcd(a, b)
    (a / g) * b
  }
}

pub fn stats_infer_bayesian_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn stats_infer_bayesian_fibonacci(n : Int) -> Int {
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

pub fn stats_infer_bayesian_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = stats_infer_bayesian_min(data); let mx = stats_infer_bayesian_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn stats_infer_bayesian_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = stats_infer_bayesian_mean(data); let sd = stats_infer_bayesian_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn stats_infer_bayesian_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn stats_infer_bayesian_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn stats_infer_bayesian_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn stats_infer_bayesian_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn stats_infer_bayesian_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn stats_infer_bayesian_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

pub(all) struct StatsinferbayesianFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_bayesian_frame_make(size : Int) -> StatsinferbayesianFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_infer_bayesian_frame_len(s : StatsinferbayesianFrame) -> Int { s.size }

pub fn stats_infer_bayesian_frame_get(s : StatsinferbayesianFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_infer_bayesian_frame_set(s : StatsinferbayesianFrame, i : Int, v : Double) -> StatsinferbayesianFrame {
  let result = stats_infer_bayesian_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_infer_bayesian_frame_sum(s : StatsinferbayesianFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_infer_bayesian_frame_mean(s : StatsinferbayesianFrame) -> Double {
  if s.size == 0 { 0.0 } else { stats_infer_bayesian_frame_sum(s) / s.size.to_double() }
}

pub fn stats_infer_bayesian_frame_scale(s : StatsinferbayesianFrame, f : Double) -> StatsinferbayesianFrame {
  let result = stats_infer_bayesian_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_infer_bayesian_frame_add(a : StatsinferbayesianFrame, b : StatsinferbayesianFrame) -> StatsinferbayesianFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_infer_bayesian_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_infer_bayesian_frame_copy(s : StatsinferbayesianFrame) -> StatsinferbayesianFrame {
  let result = stats_infer_bayesian_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_infer_bayesian_frame_fill(s : StatsinferbayesianFrame, v : Double) -> StatsinferbayesianFrame {
  let result = stats_infer_bayesian_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_infer_bayesian_frame_min(s : StatsinferbayesianFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_infer_bayesian_frame_max(s : StatsinferbayesianFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_infer_bayesian_frame_to_string(s : StatsinferbayesianFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsinferbayesianTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_bayesian_table_make(size : Int) -> StatsinferbayesianTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_infer_bayesian_table_len(s : StatsinferbayesianTable) -> Int { s.size }

pub fn stats_infer_bayesian_table_get(s : StatsinferbayesianTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_infer_bayesian_table_set(s : StatsinferbayesianTable, i : Int, v : Double) -> StatsinferbayesianTable {
  let result = stats_infer_bayesian_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_infer_bayesian_table_sum(s : StatsinferbayesianTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_infer_bayesian_table_mean(s : StatsinferbayesianTable) -> Double {
  if s.size == 0 { 0.0 } else { stats_infer_bayesian_table_sum(s) / s.size.to_double() }
}

pub fn stats_infer_bayesian_table_scale(s : StatsinferbayesianTable, f : Double) -> StatsinferbayesianTable {
  let result = stats_infer_bayesian_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_infer_bayesian_table_add(a : StatsinferbayesianTable, b : StatsinferbayesianTable) -> StatsinferbayesianTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_infer_bayesian_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_infer_bayesian_table_copy(s : StatsinferbayesianTable) -> StatsinferbayesianTable {
  let result = stats_infer_bayesian_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_infer_bayesian_table_fill(s : StatsinferbayesianTable, v : Double) -> StatsinferbayesianTable {
  let result = stats_infer_bayesian_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_infer_bayesian_table_min(s : StatsinferbayesianTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_infer_bayesian_table_max(s : StatsinferbayesianTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_infer_bayesian_table_to_string(s : StatsinferbayesianTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsinferbayesianGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_bayesian_graphn_make(size : Int) -> StatsinferbayesianGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_infer_bayesian_graphn_len(s : StatsinferbayesianGraphN) -> Int { s.size }

pub fn stats_infer_bayesian_graphn_get(s : StatsinferbayesianGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_infer_bayesian_graphn_set(s : StatsinferbayesianGraphN, i : Int, v : Double) -> StatsinferbayesianGraphN {
  let result = stats_infer_bayesian_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_infer_bayesian_graphn_sum(s : StatsinferbayesianGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_infer_bayesian_graphn_mean(s : StatsinferbayesianGraphN) -> Double {
  if s.size == 0 { 0.0 } else { stats_infer_bayesian_graphn_sum(s) / s.size.to_double() }
}

pub fn stats_infer_bayesian_graphn_scale(s : StatsinferbayesianGraphN, f : Double) -> StatsinferbayesianGraphN {
  let result = stats_infer_bayesian_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_infer_bayesian_graphn_add(a : StatsinferbayesianGraphN, b : StatsinferbayesianGraphN) -> StatsinferbayesianGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_infer_bayesian_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_infer_bayesian_graphn_copy(s : StatsinferbayesianGraphN) -> StatsinferbayesianGraphN {
  let result = stats_infer_bayesian_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_infer_bayesian_graphn_fill(s : StatsinferbayesianGraphN, v : Double) -> StatsinferbayesianGraphN {
  let result = stats_infer_bayesian_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_infer_bayesian_graphn_min(s : StatsinferbayesianGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_infer_bayesian_graphn_max(s : StatsinferbayesianGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_infer_bayesian_graphn_to_string(s : StatsinferbayesianGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsinferbayesianNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_bayesian_node_make(size : Int) -> StatsinferbayesianNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_infer_bayesian_node_len(s : StatsinferbayesianNode) -> Int { s.size }

pub fn stats_infer_bayesian_node_get(s : StatsinferbayesianNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_infer_bayesian_node_set(s : StatsinferbayesianNode, i : Int, v : Double) -> StatsinferbayesianNode {
  let result = stats_infer_bayesian_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_infer_bayesian_node_sum(s : StatsinferbayesianNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_infer_bayesian_node_mean(s : StatsinferbayesianNode) -> Double {
  if s.size == 0 { 0.0 } else { stats_infer_bayesian_node_sum(s) / s.size.to_double() }
}

pub fn stats_infer_bayesian_node_scale(s : StatsinferbayesianNode, f : Double) -> StatsinferbayesianNode {
  let result = stats_infer_bayesian_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_infer_bayesian_node_add(a : StatsinferbayesianNode, b : StatsinferbayesianNode) -> StatsinferbayesianNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_infer_bayesian_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_infer_bayesian_node_copy(s : StatsinferbayesianNode) -> StatsinferbayesianNode {
  let result = stats_infer_bayesian_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_infer_bayesian_node_fill(s : StatsinferbayesianNode, v : Double) -> StatsinferbayesianNode {
  let result = stats_infer_bayesian_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_infer_bayesian_node_min(s : StatsinferbayesianNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_infer_bayesian_node_max(s : StatsinferbayesianNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_infer_bayesian_node_to_string(s : StatsinferbayesianNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsinferbayesianEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_bayesian_edge_make(size : Int) -> StatsinferbayesianEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_infer_bayesian_edge_len(s : StatsinferbayesianEdge) -> Int { s.size }

pub fn stats_infer_bayesian_edge_get(s : StatsinferbayesianEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_infer_bayesian_edge_set(s : StatsinferbayesianEdge, i : Int, v : Double) -> StatsinferbayesianEdge {
  let result = stats_infer_bayesian_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_infer_bayesian_edge_sum(s : StatsinferbayesianEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_infer_bayesian_edge_mean(s : StatsinferbayesianEdge) -> Double {
  if s.size == 0 { 0.0 } else { stats_infer_bayesian_edge_sum(s) / s.size.to_double() }
}

pub fn stats_infer_bayesian_edge_scale(s : StatsinferbayesianEdge, f : Double) -> StatsinferbayesianEdge {
  let result = stats_infer_bayesian_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_infer_bayesian_edge_add(a : StatsinferbayesianEdge, b : StatsinferbayesianEdge) -> StatsinferbayesianEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_infer_bayesian_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_infer_bayesian_edge_copy(s : StatsinferbayesianEdge) -> StatsinferbayesianEdge {
  let result = stats_infer_bayesian_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_infer_bayesian_edge_fill(s : StatsinferbayesianEdge, v : Double) -> StatsinferbayesianEdge {
  let result = stats_infer_bayesian_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_infer_bayesian_edge_min(s : StatsinferbayesianEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_infer_bayesian_edge_max(s : StatsinferbayesianEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_infer_bayesian_edge_to_string(s : StatsinferbayesianEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsinferbayesianPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_bayesian_path_make(size : Int) -> StatsinferbayesianPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_infer_bayesian_path_len(s : StatsinferbayesianPath) -> Int { s.size }

pub fn stats_infer_bayesian_path_get(s : StatsinferbayesianPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_infer_bayesian_path_set(s : StatsinferbayesianPath, i : Int, v : Double) -> StatsinferbayesianPath {
  let result = stats_infer_bayesian_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_infer_bayesian_path_sum(s : StatsinferbayesianPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_infer_bayesian_path_mean(s : StatsinferbayesianPath) -> Double {
  if s.size == 0 { 0.0 } else { stats_infer_bayesian_path_sum(s) / s.size.to_double() }
}

pub fn stats_infer_bayesian_path_scale(s : StatsinferbayesianPath, f : Double) -> StatsinferbayesianPath {
  let result = stats_infer_bayesian_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_infer_bayesian_path_add(a : StatsinferbayesianPath, b : StatsinferbayesianPath) -> StatsinferbayesianPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_infer_bayesian_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_infer_bayesian_path_copy(s : StatsinferbayesianPath) -> StatsinferbayesianPath {
  let result = stats_infer_bayesian_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_infer_bayesian_path_fill(s : StatsinferbayesianPath, v : Double) -> StatsinferbayesianPath {
  let result = stats_infer_bayesian_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_infer_bayesian_path_min(s : StatsinferbayesianPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_infer_bayesian_path_max(s : StatsinferbayesianPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_infer_bayesian_path_to_string(s : StatsinferbayesianPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsinferbayesianCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_bayesian_cluster_make(size : Int) -> StatsinferbayesianCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_infer_bayesian_cluster_len(s : StatsinferbayesianCluster) -> Int { s.size }

pub fn stats_infer_bayesian_cluster_get(s : StatsinferbayesianCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_infer_bayesian_cluster_set(s : StatsinferbayesianCluster, i : Int, v : Double) -> StatsinferbayesianCluster {
  let result = stats_infer_bayesian_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_infer_bayesian_cluster_sum(s : StatsinferbayesianCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_infer_bayesian_cluster_mean(s : StatsinferbayesianCluster) -> Double {
  if s.size == 0 { 0.0 } else { stats_infer_bayesian_cluster_sum(s) / s.size.to_double() }
}

pub fn stats_infer_bayesian_cluster_scale(s : StatsinferbayesianCluster, f : Double) -> StatsinferbayesianCluster {
  let result = stats_infer_bayesian_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_infer_bayesian_cluster_add(a : StatsinferbayesianCluster, b : StatsinferbayesianCluster) -> StatsinferbayesianCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_infer_bayesian_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_infer_bayesian_cluster_copy(s : StatsinferbayesianCluster) -> StatsinferbayesianCluster {
  let result = stats_infer_bayesian_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_infer_bayesian_cluster_fill(s : StatsinferbayesianCluster, v : Double) -> StatsinferbayesianCluster {
  let result = stats_infer_bayesian_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_infer_bayesian_cluster_min(s : StatsinferbayesianCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_infer_bayesian_cluster_max(s : StatsinferbayesianCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_infer_bayesian_cluster_to_string(s : StatsinferbayesianCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsinferbayesianModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_bayesian_model_make(size : Int) -> StatsinferbayesianModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_infer_bayesian_model_len(s : StatsinferbayesianModel) -> Int { s.size }

pub fn stats_infer_bayesian_model_get(s : StatsinferbayesianModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_infer_bayesian_model_set(s : StatsinferbayesianModel, i : Int, v : Double) -> StatsinferbayesianModel {
  let result = stats_infer_bayesian_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_infer_bayesian_model_sum(s : StatsinferbayesianModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_infer_bayesian_model_mean(s : StatsinferbayesianModel) -> Double {
  if s.size == 0 { 0.0 } else { stats_infer_bayesian_model_sum(s) / s.size.to_double() }
}

pub fn stats_infer_bayesian_model_scale(s : StatsinferbayesianModel, f : Double) -> StatsinferbayesianModel {
  let result = stats_infer_bayesian_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_infer_bayesian_model_add(a : StatsinferbayesianModel, b : StatsinferbayesianModel) -> StatsinferbayesianModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_infer_bayesian_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_infer_bayesian_model_copy(s : StatsinferbayesianModel) -> StatsinferbayesianModel {
  let result = stats_infer_bayesian_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_infer_bayesian_model_fill(s : StatsinferbayesianModel, v : Double) -> StatsinferbayesianModel {
  let result = stats_infer_bayesian_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_infer_bayesian_model_min(s : StatsinferbayesianModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_infer_bayesian_model_max(s : StatsinferbayesianModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_infer_bayesian_model_to_string(s : StatsinferbayesianModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsinferbayesianLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_bayesian_layer_make(size : Int) -> StatsinferbayesianLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_infer_bayesian_layer_len(s : StatsinferbayesianLayer) -> Int { s.size }

pub fn stats_infer_bayesian_layer_get(s : StatsinferbayesianLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_infer_bayesian_layer_set(s : StatsinferbayesianLayer, i : Int, v : Double) -> StatsinferbayesianLayer {
  let result = stats_infer_bayesian_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_infer_bayesian_layer_sum(s : StatsinferbayesianLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_infer_bayesian_layer_mean(s : StatsinferbayesianLayer) -> Double {
  if s.size == 0 { 0.0 } else { stats_infer_bayesian_layer_sum(s) / s.size.to_double() }
}

pub fn stats_infer_bayesian_layer_scale(s : StatsinferbayesianLayer, f : Double) -> StatsinferbayesianLayer {
  let result = stats_infer_bayesian_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_infer_bayesian_layer_add(a : StatsinferbayesianLayer, b : StatsinferbayesianLayer) -> StatsinferbayesianLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_infer_bayesian_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_infer_bayesian_layer_copy(s : StatsinferbayesianLayer) -> StatsinferbayesianLayer {
  let result = stats_infer_bayesian_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_infer_bayesian_layer_fill(s : StatsinferbayesianLayer, v : Double) -> StatsinferbayesianLayer {
  let result = stats_infer_bayesian_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_infer_bayesian_layer_min(s : StatsinferbayesianLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_infer_bayesian_layer_max(s : StatsinferbayesianLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_infer_bayesian_layer_to_string(s : StatsinferbayesianLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsinferbayesianBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_bayesian_buffer_make(size : Int) -> StatsinferbayesianBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_infer_bayesian_buffer_len(s : StatsinferbayesianBuffer) -> Int { s.size }

pub fn stats_infer_bayesian_buffer_get(s : StatsinferbayesianBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_infer_bayesian_buffer_set(s : StatsinferbayesianBuffer, i : Int, v : Double) -> StatsinferbayesianBuffer {
  let result = stats_infer_bayesian_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_infer_bayesian_buffer_sum(s : StatsinferbayesianBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_infer_bayesian_buffer_mean(s : StatsinferbayesianBuffer) -> Double {
  if s.size == 0 { 0.0 } else { stats_infer_bayesian_buffer_sum(s) / s.size.to_double() }
}

pub fn stats_infer_bayesian_buffer_scale(s : StatsinferbayesianBuffer, f : Double) -> StatsinferbayesianBuffer {
  let result = stats_infer_bayesian_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_infer_bayesian_buffer_add(a : StatsinferbayesianBuffer, b : StatsinferbayesianBuffer) -> StatsinferbayesianBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_infer_bayesian_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_infer_bayesian_buffer_copy(s : StatsinferbayesianBuffer) -> StatsinferbayesianBuffer {
  let result = stats_infer_bayesian_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_infer_bayesian_buffer_fill(s : StatsinferbayesianBuffer, v : Double) -> StatsinferbayesianBuffer {
  let result = stats_infer_bayesian_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_infer_bayesian_buffer_min(s : StatsinferbayesianBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_infer_bayesian_buffer_max(s : StatsinferbayesianBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_infer_bayesian_buffer_to_string(s : StatsinferbayesianBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsinferbayesianCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_bayesian_cursor_make(size : Int) -> StatsinferbayesianCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_infer_bayesian_cursor_len(s : StatsinferbayesianCursor) -> Int { s.size }

pub fn stats_infer_bayesian_cursor_get(s : StatsinferbayesianCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_infer_bayesian_cursor_set(s : StatsinferbayesianCursor, i : Int, v : Double) -> StatsinferbayesianCursor {
  let result = stats_infer_bayesian_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_infer_bayesian_cursor_sum(s : StatsinferbayesianCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_infer_bayesian_cursor_mean(s : StatsinferbayesianCursor) -> Double {
  if s.size == 0 { 0.0 } else { stats_infer_bayesian_cursor_sum(s) / s.size.to_double() }
}

pub fn stats_infer_bayesian_cursor_scale(s : StatsinferbayesianCursor, f : Double) -> StatsinferbayesianCursor {
  let result = stats_infer_bayesian_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_infer_bayesian_cursor_add(a : StatsinferbayesianCursor, b : StatsinferbayesianCursor) -> StatsinferbayesianCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_infer_bayesian_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_infer_bayesian_cursor_copy(s : StatsinferbayesianCursor) -> StatsinferbayesianCursor {
  let result = stats_infer_bayesian_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_infer_bayesian_cursor_fill(s : StatsinferbayesianCursor, v : Double) -> StatsinferbayesianCursor {
  let result = stats_infer_bayesian_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_infer_bayesian_cursor_min(s : StatsinferbayesianCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_infer_bayesian_cursor_max(s : StatsinferbayesianCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_infer_bayesian_cursor_to_string(s : StatsinferbayesianCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsinferbayesianView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_bayesian_view_make(size : Int) -> StatsinferbayesianView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_infer_bayesian_view_len(s : StatsinferbayesianView) -> Int { s.size }

pub fn stats_infer_bayesian_view_get(s : StatsinferbayesianView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_infer_bayesian_view_set(s : StatsinferbayesianView, i : Int, v : Double) -> StatsinferbayesianView {
  let result = stats_infer_bayesian_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_infer_bayesian_view_sum(s : StatsinferbayesianView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_infer_bayesian_view_mean(s : StatsinferbayesianView) -> Double {
  if s.size == 0 { 0.0 } else { stats_infer_bayesian_view_sum(s) / s.size.to_double() }
}

pub fn stats_infer_bayesian_view_scale(s : StatsinferbayesianView, f : Double) -> StatsinferbayesianView {
  let result = stats_infer_bayesian_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_infer_bayesian_view_add(a : StatsinferbayesianView, b : StatsinferbayesianView) -> StatsinferbayesianView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_infer_bayesian_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_infer_bayesian_view_copy(s : StatsinferbayesianView) -> StatsinferbayesianView {
  let result = stats_infer_bayesian_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_infer_bayesian_view_fill(s : StatsinferbayesianView, v : Double) -> StatsinferbayesianView {
  let result = stats_infer_bayesian_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_infer_bayesian_view_min(s : StatsinferbayesianView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_infer_bayesian_view_max(s : StatsinferbayesianView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_infer_bayesian_view_to_string(s : StatsinferbayesianView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsinferbayesianRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_bayesian_range_make(size : Int) -> StatsinferbayesianRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_infer_bayesian_range_len(s : StatsinferbayesianRange) -> Int { s.size }

pub fn stats_infer_bayesian_range_get(s : StatsinferbayesianRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_infer_bayesian_range_set(s : StatsinferbayesianRange, i : Int, v : Double) -> StatsinferbayesianRange {
  let result = stats_infer_bayesian_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_infer_bayesian_range_sum(s : StatsinferbayesianRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_infer_bayesian_range_mean(s : StatsinferbayesianRange) -> Double {
  if s.size == 0 { 0.0 } else { stats_infer_bayesian_range_sum(s) / s.size.to_double() }
}

pub fn stats_infer_bayesian_range_scale(s : StatsinferbayesianRange, f : Double) -> StatsinferbayesianRange {
  let result = stats_infer_bayesian_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_infer_bayesian_range_add(a : StatsinferbayesianRange, b : StatsinferbayesianRange) -> StatsinferbayesianRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_infer_bayesian_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_infer_bayesian_range_copy(s : StatsinferbayesianRange) -> StatsinferbayesianRange {
  let result = stats_infer_bayesian_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_infer_bayesian_range_fill(s : StatsinferbayesianRange, v : Double) -> StatsinferbayesianRange {
  let result = stats_infer_bayesian_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_infer_bayesian_range_min(s : StatsinferbayesianRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_infer_bayesian_range_max(s : StatsinferbayesianRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_infer_bayesian_range_to_string(s : StatsinferbayesianRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsinferbayesianSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_bayesian_slice_make(size : Int) -> StatsinferbayesianSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_infer_bayesian_slice_len(s : StatsinferbayesianSlice) -> Int { s.size }

pub fn stats_infer_bayesian_slice_get(s : StatsinferbayesianSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_infer_bayesian_slice_set(s : StatsinferbayesianSlice, i : Int, v : Double) -> StatsinferbayesianSlice {
  let result = stats_infer_bayesian_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_infer_bayesian_slice_sum(s : StatsinferbayesianSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_infer_bayesian_slice_mean(s : StatsinferbayesianSlice) -> Double {
  if s.size == 0 { 0.0 } else { stats_infer_bayesian_slice_sum(s) / s.size.to_double() }
}

pub fn stats_infer_bayesian_slice_scale(s : StatsinferbayesianSlice, f : Double) -> StatsinferbayesianSlice {
  let result = stats_infer_bayesian_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_infer_bayesian_slice_add(a : StatsinferbayesianSlice, b : StatsinferbayesianSlice) -> StatsinferbayesianSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_infer_bayesian_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_infer_bayesian_slice_copy(s : StatsinferbayesianSlice) -> StatsinferbayesianSlice {
  let result = stats_infer_bayesian_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_infer_bayesian_slice_fill(s : StatsinferbayesianSlice, v : Double) -> StatsinferbayesianSlice {
  let result = stats_infer_bayesian_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_infer_bayesian_slice_min(s : StatsinferbayesianSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_infer_bayesian_slice_max(s : StatsinferbayesianSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_infer_bayesian_slice_to_string(s : StatsinferbayesianSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

