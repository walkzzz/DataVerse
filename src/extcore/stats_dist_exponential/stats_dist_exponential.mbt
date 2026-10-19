///===
/// extcore/stats_dist_exponential

pub(all) struct StatsdistexponentialPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn stats_dist_exponential_make_point(x : Double, y : Double) -> StatsdistexponentialPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn stats_dist_exponential_make_point3(x : Double, y : Double, z : Double) -> StatsdistexponentialPoint {
  { x, y, z, label: 0 }
}

pub fn stats_dist_exponential_point_x(pt : StatsdistexponentialPoint) -> Double { pt.x }

pub fn stats_dist_exponential_point_y(pt : StatsdistexponentialPoint) -> Double { pt.y }

pub fn stats_dist_exponential_point_z(pt : StatsdistexponentialPoint) -> Double { pt.z }

pub fn stats_dist_exponential_point_label(pt : StatsdistexponentialPoint) -> Int { pt.label }

pub fn stats_dist_exponential_point_dist(a : StatsdistexponentialPoint, b : StatsdistexponentialPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn stats_dist_exponential_point_add(a : StatsdistexponentialPoint, b : StatsdistexponentialPoint) -> StatsdistexponentialPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn stats_dist_exponential_point_sub(a : StatsdistexponentialPoint, b : StatsdistexponentialPoint) -> StatsdistexponentialPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn stats_dist_exponential_point_scale(pt : StatsdistexponentialPoint, s : Double) -> StatsdistexponentialPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn stats_dist_exponential_point_dot(a : StatsdistexponentialPoint, b : StatsdistexponentialPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn stats_dist_exponential_point_cross(a : StatsdistexponentialPoint, b : StatsdistexponentialPoint) -> StatsdistexponentialPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn stats_dist_exponential_point_norm(pt : StatsdistexponentialPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn stats_dist_exponential_point_normalize(pt : StatsdistexponentialPoint) -> StatsdistexponentialPoint {
  let n = stats_dist_exponential_point_norm(pt)
  if n < 0.0000001 { pt } else { stats_dist_exponential_point_scale(pt, 1.0 / n) }
}

pub fn stats_dist_exponential_point_negate(pt : StatsdistexponentialPoint) -> StatsdistexponentialPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn stats_dist_exponential_point_mid(a : StatsdistexponentialPoint, b : StatsdistexponentialPoint) -> StatsdistexponentialPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn stats_dist_exponential_point_lerp(a : StatsdistexponentialPoint, b : StatsdistexponentialPoint, t : Double) -> StatsdistexponentialPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn stats_dist_exponential_point_to_string(pt : StatsdistexponentialPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct StatsdistexponentialSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn stats_dist_exponential_make_series(vals : Array[Double], name : String) -> StatsdistexponentialSeries {
  { vals, name, meta: 0 }
}

pub fn stats_dist_exponential_series_len(s : StatsdistexponentialSeries) -> Int { s.vals.length() }

pub fn stats_dist_exponential_series_sum(s : StatsdistexponentialSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn stats_dist_exponential_series_mean(s : StatsdistexponentialSeries) -> Double {
  let n = stats_dist_exponential_series_len(s)
  if n == 0 { 0.0 } else { stats_dist_exponential_series_sum(s) / n.to_double() }
}

pub fn stats_dist_exponential_series_min(s : StatsdistexponentialSeries) -> Double {
  let n = stats_dist_exponential_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn stats_dist_exponential_series_max(s : StatsdistexponentialSeries) -> Double {
  let n = stats_dist_exponential_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn stats_dist_exponential_series_range(s : StatsdistexponentialSeries) -> Double {
  stats_dist_exponential_series_max(s) - stats_dist_exponential_series_min(s)
}

pub fn stats_dist_exponential_series_var(s : StatsdistexponentialSeries) -> Double {
  let n = stats_dist_exponential_series_len(s)
  if n == 0 { 0.0 } else {
    let m = stats_dist_exponential_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn stats_dist_exponential_series_std(s : StatsdistexponentialSeries) -> Double { @_common.sqrt(stats_dist_exponential_series_var(s)) }

pub fn stats_dist_exponential_series_median(s : StatsdistexponentialSeries) -> Double {
  let n = stats_dist_exponential_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = stats_dist_exponential_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn stats_dist_exponential_series_scale(s : StatsdistexponentialSeries, f : Double) -> StatsdistexponentialSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn stats_dist_exponential_series_add(a : StatsdistexponentialSeries, b : StatsdistexponentialSeries) -> StatsdistexponentialSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn stats_dist_exponential_series_sub(a : StatsdistexponentialSeries, b : StatsdistexponentialSeries) -> StatsdistexponentialSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn stats_dist_exponential_series_normalize(s : StatsdistexponentialSeries) -> StatsdistexponentialSeries {
  let mn = stats_dist_exponential_series_min(s)
  let mx = stats_dist_exponential_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn stats_dist_exponential_series_cumsum(s : StatsdistexponentialSeries) -> StatsdistexponentialSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn stats_dist_exponential_series_to_string(s : StatsdistexponentialSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct StatsdistexponentialMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn stats_dist_exponential_make_matrix(rows : Int, cols : Int, val : Double) -> StatsdistexponentialMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn stats_dist_exponential_matrix_identity(n : Int) -> StatsdistexponentialMatrix {
  let m = stats_dist_exponential_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn stats_dist_exponential_matrix_get(m : StatsdistexponentialMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn stats_dist_exponential_matrix_transpose(m : StatsdistexponentialMatrix) -> StatsdistexponentialMatrix {
  let result = stats_dist_exponential_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn stats_dist_exponential_matrix_add(a : StatsdistexponentialMatrix, b : StatsdistexponentialMatrix) -> StatsdistexponentialMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = stats_dist_exponential_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn stats_dist_exponential_matrix_scale(m : StatsdistexponentialMatrix, s : Double) -> StatsdistexponentialMatrix {
  let result = stats_dist_exponential_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn stats_dist_exponential_matrix_multiply(a : StatsdistexponentialMatrix, b : StatsdistexponentialMatrix) -> StatsdistexponentialMatrix {
  if a.cols != b.rows { return stats_dist_exponential_make_matrix(a.rows, b.cols, 0.0) }
  let result = stats_dist_exponential_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn stats_dist_exponential_matrix_trace(m : StatsdistexponentialMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn stats_dist_exponential_matrix_det(m : StatsdistexponentialMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn stats_dist_exponential_matrix_norm(m : StatsdistexponentialMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn stats_dist_exponential_matrix_to_string(m : StatsdistexponentialMatrix) -> String {
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

pub(all) struct StatsdistexponentialVector {
  comps : Array[Double]
  dim : Int
}

pub fn stats_dist_exponential_make_vector(comps : Array[Double]) -> StatsdistexponentialVector {
  { comps, dim: comps.length() }
}

pub fn stats_dist_exponential_vector_zero(dim : Int) -> StatsdistexponentialVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn stats_dist_exponential_vector_add(a : StatsdistexponentialVector, b : StatsdistexponentialVector) -> StatsdistexponentialVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn stats_dist_exponential_vector_sub(a : StatsdistexponentialVector, b : StatsdistexponentialVector) -> StatsdistexponentialVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn stats_dist_exponential_vector_scale(v : StatsdistexponentialVector, s : Double) -> StatsdistexponentialVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn stats_dist_exponential_vector_dot(a : StatsdistexponentialVector, b : StatsdistexponentialVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn stats_dist_exponential_vector_norm(v : StatsdistexponentialVector) -> Double { @_common.sqrt(stats_dist_exponential_vector_dot(v, v)) }

pub fn stats_dist_exponential_vector_normalize(v : StatsdistexponentialVector) -> StatsdistexponentialVector {
  let n = stats_dist_exponential_vector_norm(v)
  if n < 0.0000001 { v } else { stats_dist_exponential_vector_scale(v, 1.0 / n) }
}

pub fn stats_dist_exponential_vector_dist(a : StatsdistexponentialVector, b : StatsdistexponentialVector) -> Double {
  stats_dist_exponential_vector_norm(stats_dist_exponential_vector_sub(a, b))
}

pub fn stats_dist_exponential_vector_to_string(v : StatsdistexponentialVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn stats_dist_exponential_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn stats_dist_exponential_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = stats_dist_exponential_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn stats_dist_exponential_std(data : Array[Double]) -> Double { @_common.sqrt(stats_dist_exponential_var(data)) }

pub fn stats_dist_exponential_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = stats_dist_exponential_mean(a); let mb = stats_dist_exponential_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn stats_dist_exponential_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = stats_dist_exponential_std(a); let sb = stats_dist_exponential_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { stats_dist_exponential_cov(a, b) / (sa * sb) }
}

pub fn stats_dist_exponential_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = stats_dist_exponential_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn stats_dist_exponential_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn stats_dist_exponential_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn stats_dist_exponential_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  @_common.sqrt(stats_dist_exponential_mse(pred, labels))
}

pub fn stats_dist_exponential_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn stats_dist_exponential_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = stats_dist_exponential_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn stats_dist_exponential_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn stats_dist_exponential_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn stats_dist_exponential_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = stats_dist_exponential_precision(pred, labels, pos); let r = stats_dist_exponential_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn stats_dist_exponential_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn stats_dist_exponential_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = stats_dist_exponential_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn stats_dist_exponential_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn stats_dist_exponential_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn stats_dist_exponential_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = stats_dist_exponential_gcd(a, b)
    (a / g) * b
  }
}

pub fn stats_dist_exponential_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn stats_dist_exponential_fibonacci(n : Int) -> Int {
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

pub fn stats_dist_exponential_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = stats_dist_exponential_min(data); let mx = stats_dist_exponential_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn stats_dist_exponential_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = stats_dist_exponential_mean(data); let sd = stats_dist_exponential_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn stats_dist_exponential_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn stats_dist_exponential_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn stats_dist_exponential_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn stats_dist_exponential_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn stats_dist_exponential_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn stats_dist_exponential_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

pub(all) struct StatsdistexponentialFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_exponential_frame_make(size : Int) -> StatsdistexponentialFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_exponential_frame_len(s : StatsdistexponentialFrame) -> Int { s.size }

pub fn stats_dist_exponential_frame_get(s : StatsdistexponentialFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_exponential_frame_set(s : StatsdistexponentialFrame, i : Int, v : Double) -> StatsdistexponentialFrame {
  let result = stats_dist_exponential_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_exponential_frame_sum(s : StatsdistexponentialFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_exponential_frame_mean(s : StatsdistexponentialFrame) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_exponential_frame_sum(s) / s.size.to_double() }
}

pub fn stats_dist_exponential_frame_scale(s : StatsdistexponentialFrame, f : Double) -> StatsdistexponentialFrame {
  let result = stats_dist_exponential_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_exponential_frame_add(a : StatsdistexponentialFrame, b : StatsdistexponentialFrame) -> StatsdistexponentialFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_exponential_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_exponential_frame_copy(s : StatsdistexponentialFrame) -> StatsdistexponentialFrame {
  let result = stats_dist_exponential_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_exponential_frame_fill(s : StatsdistexponentialFrame, v : Double) -> StatsdistexponentialFrame {
  let result = stats_dist_exponential_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_exponential_frame_min(s : StatsdistexponentialFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_exponential_frame_max(s : StatsdistexponentialFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_exponential_frame_to_string(s : StatsdistexponentialFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistexponentialTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_exponential_table_make(size : Int) -> StatsdistexponentialTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_exponential_table_len(s : StatsdistexponentialTable) -> Int { s.size }

pub fn stats_dist_exponential_table_get(s : StatsdistexponentialTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_exponential_table_set(s : StatsdistexponentialTable, i : Int, v : Double) -> StatsdistexponentialTable {
  let result = stats_dist_exponential_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_exponential_table_sum(s : StatsdistexponentialTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_exponential_table_mean(s : StatsdistexponentialTable) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_exponential_table_sum(s) / s.size.to_double() }
}

pub fn stats_dist_exponential_table_scale(s : StatsdistexponentialTable, f : Double) -> StatsdistexponentialTable {
  let result = stats_dist_exponential_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_exponential_table_add(a : StatsdistexponentialTable, b : StatsdistexponentialTable) -> StatsdistexponentialTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_exponential_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_exponential_table_copy(s : StatsdistexponentialTable) -> StatsdistexponentialTable {
  let result = stats_dist_exponential_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_exponential_table_fill(s : StatsdistexponentialTable, v : Double) -> StatsdistexponentialTable {
  let result = stats_dist_exponential_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_exponential_table_min(s : StatsdistexponentialTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_exponential_table_max(s : StatsdistexponentialTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_exponential_table_to_string(s : StatsdistexponentialTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistexponentialGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_exponential_graphn_make(size : Int) -> StatsdistexponentialGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_exponential_graphn_len(s : StatsdistexponentialGraphN) -> Int { s.size }

pub fn stats_dist_exponential_graphn_get(s : StatsdistexponentialGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_exponential_graphn_set(s : StatsdistexponentialGraphN, i : Int, v : Double) -> StatsdistexponentialGraphN {
  let result = stats_dist_exponential_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_exponential_graphn_sum(s : StatsdistexponentialGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_exponential_graphn_mean(s : StatsdistexponentialGraphN) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_exponential_graphn_sum(s) / s.size.to_double() }
}

pub fn stats_dist_exponential_graphn_scale(s : StatsdistexponentialGraphN, f : Double) -> StatsdistexponentialGraphN {
  let result = stats_dist_exponential_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_exponential_graphn_add(a : StatsdistexponentialGraphN, b : StatsdistexponentialGraphN) -> StatsdistexponentialGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_exponential_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_exponential_graphn_copy(s : StatsdistexponentialGraphN) -> StatsdistexponentialGraphN {
  let result = stats_dist_exponential_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_exponential_graphn_fill(s : StatsdistexponentialGraphN, v : Double) -> StatsdistexponentialGraphN {
  let result = stats_dist_exponential_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_exponential_graphn_min(s : StatsdistexponentialGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_exponential_graphn_max(s : StatsdistexponentialGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_exponential_graphn_to_string(s : StatsdistexponentialGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistexponentialNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_exponential_node_make(size : Int) -> StatsdistexponentialNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_exponential_node_len(s : StatsdistexponentialNode) -> Int { s.size }

pub fn stats_dist_exponential_node_get(s : StatsdistexponentialNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_exponential_node_set(s : StatsdistexponentialNode, i : Int, v : Double) -> StatsdistexponentialNode {
  let result = stats_dist_exponential_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_exponential_node_sum(s : StatsdistexponentialNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_exponential_node_mean(s : StatsdistexponentialNode) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_exponential_node_sum(s) / s.size.to_double() }
}

pub fn stats_dist_exponential_node_scale(s : StatsdistexponentialNode, f : Double) -> StatsdistexponentialNode {
  let result = stats_dist_exponential_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_exponential_node_add(a : StatsdistexponentialNode, b : StatsdistexponentialNode) -> StatsdistexponentialNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_exponential_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_exponential_node_copy(s : StatsdistexponentialNode) -> StatsdistexponentialNode {
  let result = stats_dist_exponential_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_exponential_node_fill(s : StatsdistexponentialNode, v : Double) -> StatsdistexponentialNode {
  let result = stats_dist_exponential_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_exponential_node_min(s : StatsdistexponentialNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_exponential_node_max(s : StatsdistexponentialNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_exponential_node_to_string(s : StatsdistexponentialNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistexponentialEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_exponential_edge_make(size : Int) -> StatsdistexponentialEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_exponential_edge_len(s : StatsdistexponentialEdge) -> Int { s.size }

pub fn stats_dist_exponential_edge_get(s : StatsdistexponentialEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_exponential_edge_set(s : StatsdistexponentialEdge, i : Int, v : Double) -> StatsdistexponentialEdge {
  let result = stats_dist_exponential_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_exponential_edge_sum(s : StatsdistexponentialEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_exponential_edge_mean(s : StatsdistexponentialEdge) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_exponential_edge_sum(s) / s.size.to_double() }
}

pub fn stats_dist_exponential_edge_scale(s : StatsdistexponentialEdge, f : Double) -> StatsdistexponentialEdge {
  let result = stats_dist_exponential_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_exponential_edge_add(a : StatsdistexponentialEdge, b : StatsdistexponentialEdge) -> StatsdistexponentialEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_exponential_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_exponential_edge_copy(s : StatsdistexponentialEdge) -> StatsdistexponentialEdge {
  let result = stats_dist_exponential_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_exponential_edge_fill(s : StatsdistexponentialEdge, v : Double) -> StatsdistexponentialEdge {
  let result = stats_dist_exponential_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_exponential_edge_min(s : StatsdistexponentialEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_exponential_edge_max(s : StatsdistexponentialEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_exponential_edge_to_string(s : StatsdistexponentialEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistexponentialPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_exponential_path_make(size : Int) -> StatsdistexponentialPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_exponential_path_len(s : StatsdistexponentialPath) -> Int { s.size }

pub fn stats_dist_exponential_path_get(s : StatsdistexponentialPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_exponential_path_set(s : StatsdistexponentialPath, i : Int, v : Double) -> StatsdistexponentialPath {
  let result = stats_dist_exponential_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_exponential_path_sum(s : StatsdistexponentialPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_exponential_path_mean(s : StatsdistexponentialPath) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_exponential_path_sum(s) / s.size.to_double() }
}

pub fn stats_dist_exponential_path_scale(s : StatsdistexponentialPath, f : Double) -> StatsdistexponentialPath {
  let result = stats_dist_exponential_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_exponential_path_add(a : StatsdistexponentialPath, b : StatsdistexponentialPath) -> StatsdistexponentialPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_exponential_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_exponential_path_copy(s : StatsdistexponentialPath) -> StatsdistexponentialPath {
  let result = stats_dist_exponential_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_exponential_path_fill(s : StatsdistexponentialPath, v : Double) -> StatsdistexponentialPath {
  let result = stats_dist_exponential_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_exponential_path_min(s : StatsdistexponentialPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_exponential_path_max(s : StatsdistexponentialPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_exponential_path_to_string(s : StatsdistexponentialPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistexponentialCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_exponential_cluster_make(size : Int) -> StatsdistexponentialCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_exponential_cluster_len(s : StatsdistexponentialCluster) -> Int { s.size }

pub fn stats_dist_exponential_cluster_get(s : StatsdistexponentialCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_exponential_cluster_set(s : StatsdistexponentialCluster, i : Int, v : Double) -> StatsdistexponentialCluster {
  let result = stats_dist_exponential_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_exponential_cluster_sum(s : StatsdistexponentialCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_exponential_cluster_mean(s : StatsdistexponentialCluster) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_exponential_cluster_sum(s) / s.size.to_double() }
}

pub fn stats_dist_exponential_cluster_scale(s : StatsdistexponentialCluster, f : Double) -> StatsdistexponentialCluster {
  let result = stats_dist_exponential_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_exponential_cluster_add(a : StatsdistexponentialCluster, b : StatsdistexponentialCluster) -> StatsdistexponentialCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_exponential_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_exponential_cluster_copy(s : StatsdistexponentialCluster) -> StatsdistexponentialCluster {
  let result = stats_dist_exponential_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_exponential_cluster_fill(s : StatsdistexponentialCluster, v : Double) -> StatsdistexponentialCluster {
  let result = stats_dist_exponential_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_exponential_cluster_min(s : StatsdistexponentialCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_exponential_cluster_max(s : StatsdistexponentialCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_exponential_cluster_to_string(s : StatsdistexponentialCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistexponentialModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_exponential_model_make(size : Int) -> StatsdistexponentialModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_exponential_model_len(s : StatsdistexponentialModel) -> Int { s.size }

pub fn stats_dist_exponential_model_get(s : StatsdistexponentialModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_exponential_model_set(s : StatsdistexponentialModel, i : Int, v : Double) -> StatsdistexponentialModel {
  let result = stats_dist_exponential_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_exponential_model_sum(s : StatsdistexponentialModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_exponential_model_mean(s : StatsdistexponentialModel) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_exponential_model_sum(s) / s.size.to_double() }
}

pub fn stats_dist_exponential_model_scale(s : StatsdistexponentialModel, f : Double) -> StatsdistexponentialModel {
  let result = stats_dist_exponential_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_exponential_model_add(a : StatsdistexponentialModel, b : StatsdistexponentialModel) -> StatsdistexponentialModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_exponential_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_exponential_model_copy(s : StatsdistexponentialModel) -> StatsdistexponentialModel {
  let result = stats_dist_exponential_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_exponential_model_fill(s : StatsdistexponentialModel, v : Double) -> StatsdistexponentialModel {
  let result = stats_dist_exponential_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_exponential_model_min(s : StatsdistexponentialModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_exponential_model_max(s : StatsdistexponentialModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_exponential_model_to_string(s : StatsdistexponentialModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistexponentialLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_exponential_layer_make(size : Int) -> StatsdistexponentialLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_exponential_layer_len(s : StatsdistexponentialLayer) -> Int { s.size }

pub fn stats_dist_exponential_layer_get(s : StatsdistexponentialLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_exponential_layer_set(s : StatsdistexponentialLayer, i : Int, v : Double) -> StatsdistexponentialLayer {
  let result = stats_dist_exponential_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_exponential_layer_sum(s : StatsdistexponentialLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_exponential_layer_mean(s : StatsdistexponentialLayer) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_exponential_layer_sum(s) / s.size.to_double() }
}

pub fn stats_dist_exponential_layer_scale(s : StatsdistexponentialLayer, f : Double) -> StatsdistexponentialLayer {
  let result = stats_dist_exponential_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_exponential_layer_add(a : StatsdistexponentialLayer, b : StatsdistexponentialLayer) -> StatsdistexponentialLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_exponential_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_exponential_layer_copy(s : StatsdistexponentialLayer) -> StatsdistexponentialLayer {
  let result = stats_dist_exponential_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_exponential_layer_fill(s : StatsdistexponentialLayer, v : Double) -> StatsdistexponentialLayer {
  let result = stats_dist_exponential_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_exponential_layer_min(s : StatsdistexponentialLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_exponential_layer_max(s : StatsdistexponentialLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_exponential_layer_to_string(s : StatsdistexponentialLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistexponentialBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_exponential_buffer_make(size : Int) -> StatsdistexponentialBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_exponential_buffer_len(s : StatsdistexponentialBuffer) -> Int { s.size }

pub fn stats_dist_exponential_buffer_get(s : StatsdistexponentialBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_exponential_buffer_set(s : StatsdistexponentialBuffer, i : Int, v : Double) -> StatsdistexponentialBuffer {
  let result = stats_dist_exponential_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_exponential_buffer_sum(s : StatsdistexponentialBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_exponential_buffer_mean(s : StatsdistexponentialBuffer) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_exponential_buffer_sum(s) / s.size.to_double() }
}

pub fn stats_dist_exponential_buffer_scale(s : StatsdistexponentialBuffer, f : Double) -> StatsdistexponentialBuffer {
  let result = stats_dist_exponential_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_exponential_buffer_add(a : StatsdistexponentialBuffer, b : StatsdistexponentialBuffer) -> StatsdistexponentialBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_exponential_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_exponential_buffer_copy(s : StatsdistexponentialBuffer) -> StatsdistexponentialBuffer {
  let result = stats_dist_exponential_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_exponential_buffer_fill(s : StatsdistexponentialBuffer, v : Double) -> StatsdistexponentialBuffer {
  let result = stats_dist_exponential_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_exponential_buffer_min(s : StatsdistexponentialBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_exponential_buffer_max(s : StatsdistexponentialBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_exponential_buffer_to_string(s : StatsdistexponentialBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistexponentialCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_exponential_cursor_make(size : Int) -> StatsdistexponentialCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_exponential_cursor_len(s : StatsdistexponentialCursor) -> Int { s.size }

pub fn stats_dist_exponential_cursor_get(s : StatsdistexponentialCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_exponential_cursor_set(s : StatsdistexponentialCursor, i : Int, v : Double) -> StatsdistexponentialCursor {
  let result = stats_dist_exponential_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_exponential_cursor_sum(s : StatsdistexponentialCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_exponential_cursor_mean(s : StatsdistexponentialCursor) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_exponential_cursor_sum(s) / s.size.to_double() }
}

pub fn stats_dist_exponential_cursor_scale(s : StatsdistexponentialCursor, f : Double) -> StatsdistexponentialCursor {
  let result = stats_dist_exponential_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_exponential_cursor_add(a : StatsdistexponentialCursor, b : StatsdistexponentialCursor) -> StatsdistexponentialCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_exponential_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_exponential_cursor_copy(s : StatsdistexponentialCursor) -> StatsdistexponentialCursor {
  let result = stats_dist_exponential_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_exponential_cursor_fill(s : StatsdistexponentialCursor, v : Double) -> StatsdistexponentialCursor {
  let result = stats_dist_exponential_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_exponential_cursor_min(s : StatsdistexponentialCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_exponential_cursor_max(s : StatsdistexponentialCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_exponential_cursor_to_string(s : StatsdistexponentialCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistexponentialView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_exponential_view_make(size : Int) -> StatsdistexponentialView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_exponential_view_len(s : StatsdistexponentialView) -> Int { s.size }

pub fn stats_dist_exponential_view_get(s : StatsdistexponentialView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_exponential_view_set(s : StatsdistexponentialView, i : Int, v : Double) -> StatsdistexponentialView {
  let result = stats_dist_exponential_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_exponential_view_sum(s : StatsdistexponentialView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_exponential_view_mean(s : StatsdistexponentialView) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_exponential_view_sum(s) / s.size.to_double() }
}

pub fn stats_dist_exponential_view_scale(s : StatsdistexponentialView, f : Double) -> StatsdistexponentialView {
  let result = stats_dist_exponential_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_exponential_view_add(a : StatsdistexponentialView, b : StatsdistexponentialView) -> StatsdistexponentialView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_exponential_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_exponential_view_copy(s : StatsdistexponentialView) -> StatsdistexponentialView {
  let result = stats_dist_exponential_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_exponential_view_fill(s : StatsdistexponentialView, v : Double) -> StatsdistexponentialView {
  let result = stats_dist_exponential_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_exponential_view_min(s : StatsdistexponentialView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_exponential_view_max(s : StatsdistexponentialView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_exponential_view_to_string(s : StatsdistexponentialView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistexponentialRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_exponential_range_make(size : Int) -> StatsdistexponentialRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_exponential_range_len(s : StatsdistexponentialRange) -> Int { s.size }

pub fn stats_dist_exponential_range_get(s : StatsdistexponentialRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_exponential_range_set(s : StatsdistexponentialRange, i : Int, v : Double) -> StatsdistexponentialRange {
  let result = stats_dist_exponential_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_exponential_range_sum(s : StatsdistexponentialRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_exponential_range_mean(s : StatsdistexponentialRange) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_exponential_range_sum(s) / s.size.to_double() }
}

pub fn stats_dist_exponential_range_scale(s : StatsdistexponentialRange, f : Double) -> StatsdistexponentialRange {
  let result = stats_dist_exponential_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_exponential_range_add(a : StatsdistexponentialRange, b : StatsdistexponentialRange) -> StatsdistexponentialRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_exponential_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_exponential_range_copy(s : StatsdistexponentialRange) -> StatsdistexponentialRange {
  let result = stats_dist_exponential_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_exponential_range_fill(s : StatsdistexponentialRange, v : Double) -> StatsdistexponentialRange {
  let result = stats_dist_exponential_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_exponential_range_min(s : StatsdistexponentialRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_exponential_range_max(s : StatsdistexponentialRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_exponential_range_to_string(s : StatsdistexponentialRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistexponentialSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_exponential_slice_make(size : Int) -> StatsdistexponentialSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_exponential_slice_len(s : StatsdistexponentialSlice) -> Int { s.size }

pub fn stats_dist_exponential_slice_get(s : StatsdistexponentialSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_exponential_slice_set(s : StatsdistexponentialSlice, i : Int, v : Double) -> StatsdistexponentialSlice {
  let result = stats_dist_exponential_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_exponential_slice_sum(s : StatsdistexponentialSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_exponential_slice_mean(s : StatsdistexponentialSlice) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_exponential_slice_sum(s) / s.size.to_double() }
}

pub fn stats_dist_exponential_slice_scale(s : StatsdistexponentialSlice, f : Double) -> StatsdistexponentialSlice {
  let result = stats_dist_exponential_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_exponential_slice_add(a : StatsdistexponentialSlice, b : StatsdistexponentialSlice) -> StatsdistexponentialSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_exponential_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_exponential_slice_copy(s : StatsdistexponentialSlice) -> StatsdistexponentialSlice {
  let result = stats_dist_exponential_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_exponential_slice_fill(s : StatsdistexponentialSlice, v : Double) -> StatsdistexponentialSlice {
  let result = stats_dist_exponential_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_exponential_slice_min(s : StatsdistexponentialSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_exponential_slice_max(s : StatsdistexponentialSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_exponential_slice_to_string(s : StatsdistexponentialSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

