///===
/// extcore/stats_dist_wishart

pub(all) struct StatsdistwishartPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn stats_dist_wishart_make_point(x : Double, y : Double) -> StatsdistwishartPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn stats_dist_wishart_make_point3(x : Double, y : Double, z : Double) -> StatsdistwishartPoint {
  { x, y, z, label: 0 }
}

pub fn stats_dist_wishart_point_x(pt : StatsdistwishartPoint) -> Double { pt.x }

pub fn stats_dist_wishart_point_y(pt : StatsdistwishartPoint) -> Double { pt.y }

pub fn stats_dist_wishart_point_z(pt : StatsdistwishartPoint) -> Double { pt.z }

pub fn stats_dist_wishart_point_label(pt : StatsdistwishartPoint) -> Int { pt.label }

pub fn stats_dist_wishart_point_dist(a : StatsdistwishartPoint, b : StatsdistwishartPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn stats_dist_wishart_point_add(a : StatsdistwishartPoint, b : StatsdistwishartPoint) -> StatsdistwishartPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn stats_dist_wishart_point_sub(a : StatsdistwishartPoint, b : StatsdistwishartPoint) -> StatsdistwishartPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn stats_dist_wishart_point_scale(pt : StatsdistwishartPoint, s : Double) -> StatsdistwishartPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn stats_dist_wishart_point_dot(a : StatsdistwishartPoint, b : StatsdistwishartPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn stats_dist_wishart_point_cross(a : StatsdistwishartPoint, b : StatsdistwishartPoint) -> StatsdistwishartPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn stats_dist_wishart_point_norm(pt : StatsdistwishartPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn stats_dist_wishart_point_normalize(pt : StatsdistwishartPoint) -> StatsdistwishartPoint {
  let n = stats_dist_wishart_point_norm(pt)
  if n < 0.0000001 { pt } else { stats_dist_wishart_point_scale(pt, 1.0 / n) }
}

pub fn stats_dist_wishart_point_negate(pt : StatsdistwishartPoint) -> StatsdistwishartPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn stats_dist_wishart_point_mid(a : StatsdistwishartPoint, b : StatsdistwishartPoint) -> StatsdistwishartPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn stats_dist_wishart_point_lerp(a : StatsdistwishartPoint, b : StatsdistwishartPoint, t : Double) -> StatsdistwishartPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn stats_dist_wishart_point_to_string(pt : StatsdistwishartPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct StatsdistwishartSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn stats_dist_wishart_make_series(vals : Array[Double], name : String) -> StatsdistwishartSeries {
  { vals, name, meta: 0 }
}

pub fn stats_dist_wishart_series_len(s : StatsdistwishartSeries) -> Int { s.vals.length() }

pub fn stats_dist_wishart_series_sum(s : StatsdistwishartSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn stats_dist_wishart_series_mean(s : StatsdistwishartSeries) -> Double {
  let n = stats_dist_wishart_series_len(s)
  if n == 0 { 0.0 } else { stats_dist_wishart_series_sum(s) / n.to_double() }
}

pub fn stats_dist_wishart_series_min(s : StatsdistwishartSeries) -> Double {
  let n = stats_dist_wishart_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn stats_dist_wishart_series_max(s : StatsdistwishartSeries) -> Double {
  let n = stats_dist_wishart_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn stats_dist_wishart_series_range(s : StatsdistwishartSeries) -> Double {
  stats_dist_wishart_series_max(s) - stats_dist_wishart_series_min(s)
}

pub fn stats_dist_wishart_series_var(s : StatsdistwishartSeries) -> Double {
  let n = stats_dist_wishart_series_len(s)
  if n == 0 { 0.0 } else {
    let m = stats_dist_wishart_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn stats_dist_wishart_series_std(s : StatsdistwishartSeries) -> Double { @_common.sqrt(stats_dist_wishart_series_var(s)) }

pub fn stats_dist_wishart_series_median(s : StatsdistwishartSeries) -> Double {
  let n = stats_dist_wishart_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = stats_dist_wishart_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn stats_dist_wishart_series_scale(s : StatsdistwishartSeries, f : Double) -> StatsdistwishartSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn stats_dist_wishart_series_add(a : StatsdistwishartSeries, b : StatsdistwishartSeries) -> StatsdistwishartSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn stats_dist_wishart_series_sub(a : StatsdistwishartSeries, b : StatsdistwishartSeries) -> StatsdistwishartSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn stats_dist_wishart_series_normalize(s : StatsdistwishartSeries) -> StatsdistwishartSeries {
  let mn = stats_dist_wishart_series_min(s)
  let mx = stats_dist_wishart_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn stats_dist_wishart_series_cumsum(s : StatsdistwishartSeries) -> StatsdistwishartSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn stats_dist_wishart_series_to_string(s : StatsdistwishartSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct StatsdistwishartMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn stats_dist_wishart_make_matrix(rows : Int, cols : Int, val : Double) -> StatsdistwishartMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn stats_dist_wishart_matrix_identity(n : Int) -> StatsdistwishartMatrix {
  let m = stats_dist_wishart_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn stats_dist_wishart_matrix_get(m : StatsdistwishartMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn stats_dist_wishart_matrix_transpose(m : StatsdistwishartMatrix) -> StatsdistwishartMatrix {
  let result = stats_dist_wishart_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn stats_dist_wishart_matrix_add(a : StatsdistwishartMatrix, b : StatsdistwishartMatrix) -> StatsdistwishartMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = stats_dist_wishart_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn stats_dist_wishart_matrix_scale(m : StatsdistwishartMatrix, s : Double) -> StatsdistwishartMatrix {
  let result = stats_dist_wishart_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn stats_dist_wishart_matrix_multiply(a : StatsdistwishartMatrix, b : StatsdistwishartMatrix) -> StatsdistwishartMatrix {
  if a.cols != b.rows { return stats_dist_wishart_make_matrix(a.rows, b.cols, 0.0) }
  let result = stats_dist_wishart_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn stats_dist_wishart_matrix_trace(m : StatsdistwishartMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn stats_dist_wishart_matrix_det(m : StatsdistwishartMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn stats_dist_wishart_matrix_norm(m : StatsdistwishartMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn stats_dist_wishart_matrix_to_string(m : StatsdistwishartMatrix) -> String {
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

pub(all) struct StatsdistwishartVector {
  comps : Array[Double]
  dim : Int
}

pub fn stats_dist_wishart_make_vector(comps : Array[Double]) -> StatsdistwishartVector {
  { comps, dim: comps.length() }
}

pub fn stats_dist_wishart_vector_zero(dim : Int) -> StatsdistwishartVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn stats_dist_wishart_vector_add(a : StatsdistwishartVector, b : StatsdistwishartVector) -> StatsdistwishartVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn stats_dist_wishart_vector_sub(a : StatsdistwishartVector, b : StatsdistwishartVector) -> StatsdistwishartVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn stats_dist_wishart_vector_scale(v : StatsdistwishartVector, s : Double) -> StatsdistwishartVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn stats_dist_wishart_vector_dot(a : StatsdistwishartVector, b : StatsdistwishartVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn stats_dist_wishart_vector_norm(v : StatsdistwishartVector) -> Double { @_common.sqrt(stats_dist_wishart_vector_dot(v, v)) }

pub fn stats_dist_wishart_vector_normalize(v : StatsdistwishartVector) -> StatsdistwishartVector {
  let n = stats_dist_wishart_vector_norm(v)
  if n < 0.0000001 { v } else { stats_dist_wishart_vector_scale(v, 1.0 / n) }
}

pub fn stats_dist_wishart_vector_dist(a : StatsdistwishartVector, b : StatsdistwishartVector) -> Double {
  stats_dist_wishart_vector_norm(stats_dist_wishart_vector_sub(a, b))
}

pub fn stats_dist_wishart_vector_to_string(v : StatsdistwishartVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn stats_dist_wishart_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn stats_dist_wishart_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = stats_dist_wishart_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn stats_dist_wishart_std(data : Array[Double]) -> Double { @_common.sqrt(stats_dist_wishart_var(data)) }

pub fn stats_dist_wishart_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = stats_dist_wishart_mean(a); let mb = stats_dist_wishart_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn stats_dist_wishart_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = stats_dist_wishart_std(a); let sb = stats_dist_wishart_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { stats_dist_wishart_cov(a, b) / (sa * sb) }
}

pub fn stats_dist_wishart_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = stats_dist_wishart_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn stats_dist_wishart_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn stats_dist_wishart_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn stats_dist_wishart_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  @_common.sqrt(stats_dist_wishart_mse(pred, labels))
}

pub fn stats_dist_wishart_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn stats_dist_wishart_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = stats_dist_wishart_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn stats_dist_wishart_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn stats_dist_wishart_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn stats_dist_wishart_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = stats_dist_wishart_precision(pred, labels, pos); let r = stats_dist_wishart_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn stats_dist_wishart_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn stats_dist_wishart_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = stats_dist_wishart_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn stats_dist_wishart_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn stats_dist_wishart_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn stats_dist_wishart_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = stats_dist_wishart_gcd(a, b)
    (a / g) * b
  }
}

pub fn stats_dist_wishart_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn stats_dist_wishart_fibonacci(n : Int) -> Int {
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

pub fn stats_dist_wishart_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = stats_dist_wishart_min(data); let mx = stats_dist_wishart_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn stats_dist_wishart_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = stats_dist_wishart_mean(data); let sd = stats_dist_wishart_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn stats_dist_wishart_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn stats_dist_wishart_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn stats_dist_wishart_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn stats_dist_wishart_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn stats_dist_wishart_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn stats_dist_wishart_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

pub(all) struct StatsdistwishartFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_wishart_frame_make(size : Int) -> StatsdistwishartFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_wishart_frame_len(s : StatsdistwishartFrame) -> Int { s.size }

pub fn stats_dist_wishart_frame_get(s : StatsdistwishartFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_wishart_frame_set(s : StatsdistwishartFrame, i : Int, v : Double) -> StatsdistwishartFrame {
  let result = stats_dist_wishart_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_wishart_frame_sum(s : StatsdistwishartFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_wishart_frame_mean(s : StatsdistwishartFrame) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_wishart_frame_sum(s) / s.size.to_double() }
}

pub fn stats_dist_wishart_frame_scale(s : StatsdistwishartFrame, f : Double) -> StatsdistwishartFrame {
  let result = stats_dist_wishart_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_wishart_frame_add(a : StatsdistwishartFrame, b : StatsdistwishartFrame) -> StatsdistwishartFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_wishart_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_wishart_frame_copy(s : StatsdistwishartFrame) -> StatsdistwishartFrame {
  let result = stats_dist_wishart_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_wishart_frame_fill(s : StatsdistwishartFrame, v : Double) -> StatsdistwishartFrame {
  let result = stats_dist_wishart_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_wishart_frame_min(s : StatsdistwishartFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_wishart_frame_max(s : StatsdistwishartFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_wishart_frame_to_string(s : StatsdistwishartFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistwishartTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_wishart_table_make(size : Int) -> StatsdistwishartTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_wishart_table_len(s : StatsdistwishartTable) -> Int { s.size }

pub fn stats_dist_wishart_table_get(s : StatsdistwishartTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_wishart_table_set(s : StatsdistwishartTable, i : Int, v : Double) -> StatsdistwishartTable {
  let result = stats_dist_wishart_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_wishart_table_sum(s : StatsdistwishartTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_wishart_table_mean(s : StatsdistwishartTable) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_wishart_table_sum(s) / s.size.to_double() }
}

pub fn stats_dist_wishart_table_scale(s : StatsdistwishartTable, f : Double) -> StatsdistwishartTable {
  let result = stats_dist_wishart_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_wishart_table_add(a : StatsdistwishartTable, b : StatsdistwishartTable) -> StatsdistwishartTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_wishart_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_wishart_table_copy(s : StatsdistwishartTable) -> StatsdistwishartTable {
  let result = stats_dist_wishart_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_wishart_table_fill(s : StatsdistwishartTable, v : Double) -> StatsdistwishartTable {
  let result = stats_dist_wishart_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_wishart_table_min(s : StatsdistwishartTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_wishart_table_max(s : StatsdistwishartTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_wishart_table_to_string(s : StatsdistwishartTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistwishartGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_wishart_graphn_make(size : Int) -> StatsdistwishartGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_wishart_graphn_len(s : StatsdistwishartGraphN) -> Int { s.size }

pub fn stats_dist_wishart_graphn_get(s : StatsdistwishartGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_wishart_graphn_set(s : StatsdistwishartGraphN, i : Int, v : Double) -> StatsdistwishartGraphN {
  let result = stats_dist_wishart_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_wishart_graphn_sum(s : StatsdistwishartGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_wishart_graphn_mean(s : StatsdistwishartGraphN) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_wishart_graphn_sum(s) / s.size.to_double() }
}

pub fn stats_dist_wishart_graphn_scale(s : StatsdistwishartGraphN, f : Double) -> StatsdistwishartGraphN {
  let result = stats_dist_wishart_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_wishart_graphn_add(a : StatsdistwishartGraphN, b : StatsdistwishartGraphN) -> StatsdistwishartGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_wishart_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_wishart_graphn_copy(s : StatsdistwishartGraphN) -> StatsdistwishartGraphN {
  let result = stats_dist_wishart_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_wishart_graphn_fill(s : StatsdistwishartGraphN, v : Double) -> StatsdistwishartGraphN {
  let result = stats_dist_wishart_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_wishart_graphn_min(s : StatsdistwishartGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_wishart_graphn_max(s : StatsdistwishartGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_wishart_graphn_to_string(s : StatsdistwishartGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistwishartNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_wishart_node_make(size : Int) -> StatsdistwishartNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_wishart_node_len(s : StatsdistwishartNode) -> Int { s.size }

pub fn stats_dist_wishart_node_get(s : StatsdistwishartNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_wishart_node_set(s : StatsdistwishartNode, i : Int, v : Double) -> StatsdistwishartNode {
  let result = stats_dist_wishart_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_wishart_node_sum(s : StatsdistwishartNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_wishart_node_mean(s : StatsdistwishartNode) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_wishart_node_sum(s) / s.size.to_double() }
}

pub fn stats_dist_wishart_node_scale(s : StatsdistwishartNode, f : Double) -> StatsdistwishartNode {
  let result = stats_dist_wishart_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_wishart_node_add(a : StatsdistwishartNode, b : StatsdistwishartNode) -> StatsdistwishartNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_wishart_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_wishart_node_copy(s : StatsdistwishartNode) -> StatsdistwishartNode {
  let result = stats_dist_wishart_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_wishart_node_fill(s : StatsdistwishartNode, v : Double) -> StatsdistwishartNode {
  let result = stats_dist_wishart_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_wishart_node_min(s : StatsdistwishartNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_wishart_node_max(s : StatsdistwishartNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_wishart_node_to_string(s : StatsdistwishartNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistwishartEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_wishart_edge_make(size : Int) -> StatsdistwishartEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_wishart_edge_len(s : StatsdistwishartEdge) -> Int { s.size }

pub fn stats_dist_wishart_edge_get(s : StatsdistwishartEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_wishart_edge_set(s : StatsdistwishartEdge, i : Int, v : Double) -> StatsdistwishartEdge {
  let result = stats_dist_wishart_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_wishart_edge_sum(s : StatsdistwishartEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_wishart_edge_mean(s : StatsdistwishartEdge) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_wishart_edge_sum(s) / s.size.to_double() }
}

pub fn stats_dist_wishart_edge_scale(s : StatsdistwishartEdge, f : Double) -> StatsdistwishartEdge {
  let result = stats_dist_wishart_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_wishart_edge_add(a : StatsdistwishartEdge, b : StatsdistwishartEdge) -> StatsdistwishartEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_wishart_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_wishart_edge_copy(s : StatsdistwishartEdge) -> StatsdistwishartEdge {
  let result = stats_dist_wishart_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_wishart_edge_fill(s : StatsdistwishartEdge, v : Double) -> StatsdistwishartEdge {
  let result = stats_dist_wishart_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_wishart_edge_min(s : StatsdistwishartEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_wishart_edge_max(s : StatsdistwishartEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_wishart_edge_to_string(s : StatsdistwishartEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistwishartPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_wishart_path_make(size : Int) -> StatsdistwishartPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_wishart_path_len(s : StatsdistwishartPath) -> Int { s.size }

pub fn stats_dist_wishart_path_get(s : StatsdistwishartPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_wishart_path_set(s : StatsdistwishartPath, i : Int, v : Double) -> StatsdistwishartPath {
  let result = stats_dist_wishart_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_wishart_path_sum(s : StatsdistwishartPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_wishart_path_mean(s : StatsdistwishartPath) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_wishart_path_sum(s) / s.size.to_double() }
}

pub fn stats_dist_wishart_path_scale(s : StatsdistwishartPath, f : Double) -> StatsdistwishartPath {
  let result = stats_dist_wishart_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_wishart_path_add(a : StatsdistwishartPath, b : StatsdistwishartPath) -> StatsdistwishartPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_wishart_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_wishart_path_copy(s : StatsdistwishartPath) -> StatsdistwishartPath {
  let result = stats_dist_wishart_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_wishart_path_fill(s : StatsdistwishartPath, v : Double) -> StatsdistwishartPath {
  let result = stats_dist_wishart_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_wishart_path_min(s : StatsdistwishartPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_wishart_path_max(s : StatsdistwishartPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_wishart_path_to_string(s : StatsdistwishartPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistwishartCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_wishart_cluster_make(size : Int) -> StatsdistwishartCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_wishart_cluster_len(s : StatsdistwishartCluster) -> Int { s.size }

pub fn stats_dist_wishart_cluster_get(s : StatsdistwishartCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_wishart_cluster_set(s : StatsdistwishartCluster, i : Int, v : Double) -> StatsdistwishartCluster {
  let result = stats_dist_wishart_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_wishart_cluster_sum(s : StatsdistwishartCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_wishart_cluster_mean(s : StatsdistwishartCluster) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_wishart_cluster_sum(s) / s.size.to_double() }
}

pub fn stats_dist_wishart_cluster_scale(s : StatsdistwishartCluster, f : Double) -> StatsdistwishartCluster {
  let result = stats_dist_wishart_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_wishart_cluster_add(a : StatsdistwishartCluster, b : StatsdistwishartCluster) -> StatsdistwishartCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_wishart_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_wishart_cluster_copy(s : StatsdistwishartCluster) -> StatsdistwishartCluster {
  let result = stats_dist_wishart_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_wishart_cluster_fill(s : StatsdistwishartCluster, v : Double) -> StatsdistwishartCluster {
  let result = stats_dist_wishart_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_wishart_cluster_min(s : StatsdistwishartCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_wishart_cluster_max(s : StatsdistwishartCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_wishart_cluster_to_string(s : StatsdistwishartCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistwishartModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_wishart_model_make(size : Int) -> StatsdistwishartModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_wishart_model_len(s : StatsdistwishartModel) -> Int { s.size }

pub fn stats_dist_wishart_model_get(s : StatsdistwishartModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_wishart_model_set(s : StatsdistwishartModel, i : Int, v : Double) -> StatsdistwishartModel {
  let result = stats_dist_wishart_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_wishart_model_sum(s : StatsdistwishartModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_wishart_model_mean(s : StatsdistwishartModel) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_wishart_model_sum(s) / s.size.to_double() }
}

pub fn stats_dist_wishart_model_scale(s : StatsdistwishartModel, f : Double) -> StatsdistwishartModel {
  let result = stats_dist_wishart_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_wishart_model_add(a : StatsdistwishartModel, b : StatsdistwishartModel) -> StatsdistwishartModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_wishart_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_wishart_model_copy(s : StatsdistwishartModel) -> StatsdistwishartModel {
  let result = stats_dist_wishart_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_wishart_model_fill(s : StatsdistwishartModel, v : Double) -> StatsdistwishartModel {
  let result = stats_dist_wishart_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_wishart_model_min(s : StatsdistwishartModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_wishart_model_max(s : StatsdistwishartModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_wishart_model_to_string(s : StatsdistwishartModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistwishartLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_wishart_layer_make(size : Int) -> StatsdistwishartLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_wishart_layer_len(s : StatsdistwishartLayer) -> Int { s.size }

pub fn stats_dist_wishart_layer_get(s : StatsdistwishartLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_wishart_layer_set(s : StatsdistwishartLayer, i : Int, v : Double) -> StatsdistwishartLayer {
  let result = stats_dist_wishart_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_wishart_layer_sum(s : StatsdistwishartLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_wishart_layer_mean(s : StatsdistwishartLayer) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_wishart_layer_sum(s) / s.size.to_double() }
}

pub fn stats_dist_wishart_layer_scale(s : StatsdistwishartLayer, f : Double) -> StatsdistwishartLayer {
  let result = stats_dist_wishart_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_wishart_layer_add(a : StatsdistwishartLayer, b : StatsdistwishartLayer) -> StatsdistwishartLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_wishart_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_wishart_layer_copy(s : StatsdistwishartLayer) -> StatsdistwishartLayer {
  let result = stats_dist_wishart_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_wishart_layer_fill(s : StatsdistwishartLayer, v : Double) -> StatsdistwishartLayer {
  let result = stats_dist_wishart_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_wishart_layer_min(s : StatsdistwishartLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_wishart_layer_max(s : StatsdistwishartLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_wishart_layer_to_string(s : StatsdistwishartLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistwishartBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_wishart_buffer_make(size : Int) -> StatsdistwishartBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_wishart_buffer_len(s : StatsdistwishartBuffer) -> Int { s.size }

pub fn stats_dist_wishart_buffer_get(s : StatsdistwishartBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_wishart_buffer_set(s : StatsdistwishartBuffer, i : Int, v : Double) -> StatsdistwishartBuffer {
  let result = stats_dist_wishart_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_wishart_buffer_sum(s : StatsdistwishartBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_wishart_buffer_mean(s : StatsdistwishartBuffer) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_wishart_buffer_sum(s) / s.size.to_double() }
}

pub fn stats_dist_wishart_buffer_scale(s : StatsdistwishartBuffer, f : Double) -> StatsdistwishartBuffer {
  let result = stats_dist_wishart_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_wishart_buffer_add(a : StatsdistwishartBuffer, b : StatsdistwishartBuffer) -> StatsdistwishartBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_wishart_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_wishart_buffer_copy(s : StatsdistwishartBuffer) -> StatsdistwishartBuffer {
  let result = stats_dist_wishart_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_wishart_buffer_fill(s : StatsdistwishartBuffer, v : Double) -> StatsdistwishartBuffer {
  let result = stats_dist_wishart_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_wishart_buffer_min(s : StatsdistwishartBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_wishart_buffer_max(s : StatsdistwishartBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_wishart_buffer_to_string(s : StatsdistwishartBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistwishartCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_wishart_cursor_make(size : Int) -> StatsdistwishartCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_wishart_cursor_len(s : StatsdistwishartCursor) -> Int { s.size }

pub fn stats_dist_wishart_cursor_get(s : StatsdistwishartCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_wishart_cursor_set(s : StatsdistwishartCursor, i : Int, v : Double) -> StatsdistwishartCursor {
  let result = stats_dist_wishart_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_wishart_cursor_sum(s : StatsdistwishartCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_wishart_cursor_mean(s : StatsdistwishartCursor) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_wishart_cursor_sum(s) / s.size.to_double() }
}

pub fn stats_dist_wishart_cursor_scale(s : StatsdistwishartCursor, f : Double) -> StatsdistwishartCursor {
  let result = stats_dist_wishart_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_wishart_cursor_add(a : StatsdistwishartCursor, b : StatsdistwishartCursor) -> StatsdistwishartCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_wishart_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_wishart_cursor_copy(s : StatsdistwishartCursor) -> StatsdistwishartCursor {
  let result = stats_dist_wishart_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_wishart_cursor_fill(s : StatsdistwishartCursor, v : Double) -> StatsdistwishartCursor {
  let result = stats_dist_wishart_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_wishart_cursor_min(s : StatsdistwishartCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_wishart_cursor_max(s : StatsdistwishartCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_wishart_cursor_to_string(s : StatsdistwishartCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistwishartView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_wishart_view_make(size : Int) -> StatsdistwishartView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_wishart_view_len(s : StatsdistwishartView) -> Int { s.size }

pub fn stats_dist_wishart_view_get(s : StatsdistwishartView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_wishart_view_set(s : StatsdistwishartView, i : Int, v : Double) -> StatsdistwishartView {
  let result = stats_dist_wishart_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_wishart_view_sum(s : StatsdistwishartView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_wishart_view_mean(s : StatsdistwishartView) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_wishart_view_sum(s) / s.size.to_double() }
}

pub fn stats_dist_wishart_view_scale(s : StatsdistwishartView, f : Double) -> StatsdistwishartView {
  let result = stats_dist_wishart_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_wishart_view_add(a : StatsdistwishartView, b : StatsdistwishartView) -> StatsdistwishartView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_wishart_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_wishart_view_copy(s : StatsdistwishartView) -> StatsdistwishartView {
  let result = stats_dist_wishart_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_wishart_view_fill(s : StatsdistwishartView, v : Double) -> StatsdistwishartView {
  let result = stats_dist_wishart_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_wishart_view_min(s : StatsdistwishartView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_wishart_view_max(s : StatsdistwishartView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_wishart_view_to_string(s : StatsdistwishartView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistwishartRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_wishart_range_make(size : Int) -> StatsdistwishartRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_wishart_range_len(s : StatsdistwishartRange) -> Int { s.size }

pub fn stats_dist_wishart_range_get(s : StatsdistwishartRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_wishart_range_set(s : StatsdistwishartRange, i : Int, v : Double) -> StatsdistwishartRange {
  let result = stats_dist_wishart_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_wishart_range_sum(s : StatsdistwishartRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_wishart_range_mean(s : StatsdistwishartRange) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_wishart_range_sum(s) / s.size.to_double() }
}

pub fn stats_dist_wishart_range_scale(s : StatsdistwishartRange, f : Double) -> StatsdistwishartRange {
  let result = stats_dist_wishart_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_wishart_range_add(a : StatsdistwishartRange, b : StatsdistwishartRange) -> StatsdistwishartRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_wishart_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_wishart_range_copy(s : StatsdistwishartRange) -> StatsdistwishartRange {
  let result = stats_dist_wishart_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_wishart_range_fill(s : StatsdistwishartRange, v : Double) -> StatsdistwishartRange {
  let result = stats_dist_wishart_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_wishart_range_min(s : StatsdistwishartRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_wishart_range_max(s : StatsdistwishartRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_wishart_range_to_string(s : StatsdistwishartRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistwishartSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_wishart_slice_make(size : Int) -> StatsdistwishartSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_wishart_slice_len(s : StatsdistwishartSlice) -> Int { s.size }

pub fn stats_dist_wishart_slice_get(s : StatsdistwishartSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_wishart_slice_set(s : StatsdistwishartSlice, i : Int, v : Double) -> StatsdistwishartSlice {
  let result = stats_dist_wishart_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_wishart_slice_sum(s : StatsdistwishartSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_wishart_slice_mean(s : StatsdistwishartSlice) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_wishart_slice_sum(s) / s.size.to_double() }
}

pub fn stats_dist_wishart_slice_scale(s : StatsdistwishartSlice, f : Double) -> StatsdistwishartSlice {
  let result = stats_dist_wishart_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_wishart_slice_add(a : StatsdistwishartSlice, b : StatsdistwishartSlice) -> StatsdistwishartSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_wishart_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_wishart_slice_copy(s : StatsdistwishartSlice) -> StatsdistwishartSlice {
  let result = stats_dist_wishart_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_wishart_slice_fill(s : StatsdistwishartSlice, v : Double) -> StatsdistwishartSlice {
  let result = stats_dist_wishart_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_wishart_slice_min(s : StatsdistwishartSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_wishart_slice_max(s : StatsdistwishartSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_wishart_slice_to_string(s : StatsdistwishartSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

