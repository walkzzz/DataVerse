///===
/// extcore/stats_dist_neg_binomial

pub(all) struct StatsdistnegbinomialPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn stats_dist_neg_binomial_make_point(x : Double, y : Double) -> StatsdistnegbinomialPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn stats_dist_neg_binomial_make_point3(x : Double, y : Double, z : Double) -> StatsdistnegbinomialPoint {
  { x, y, z, label: 0 }
}

pub fn stats_dist_neg_binomial_point_x(pt : StatsdistnegbinomialPoint) -> Double { pt.x }

pub fn stats_dist_neg_binomial_point_y(pt : StatsdistnegbinomialPoint) -> Double { pt.y }

pub fn stats_dist_neg_binomial_point_z(pt : StatsdistnegbinomialPoint) -> Double { pt.z }

pub fn stats_dist_neg_binomial_point_label(pt : StatsdistnegbinomialPoint) -> Int { pt.label }

pub fn stats_dist_neg_binomial_point_dist(a : StatsdistnegbinomialPoint, b : StatsdistnegbinomialPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn stats_dist_neg_binomial_point_add(a : StatsdistnegbinomialPoint, b : StatsdistnegbinomialPoint) -> StatsdistnegbinomialPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn stats_dist_neg_binomial_point_sub(a : StatsdistnegbinomialPoint, b : StatsdistnegbinomialPoint) -> StatsdistnegbinomialPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn stats_dist_neg_binomial_point_scale(pt : StatsdistnegbinomialPoint, s : Double) -> StatsdistnegbinomialPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn stats_dist_neg_binomial_point_dot(a : StatsdistnegbinomialPoint, b : StatsdistnegbinomialPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn stats_dist_neg_binomial_point_cross(a : StatsdistnegbinomialPoint, b : StatsdistnegbinomialPoint) -> StatsdistnegbinomialPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn stats_dist_neg_binomial_point_norm(pt : StatsdistnegbinomialPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn stats_dist_neg_binomial_point_normalize(pt : StatsdistnegbinomialPoint) -> StatsdistnegbinomialPoint {
  let n = stats_dist_neg_binomial_point_norm(pt)
  if n < 0.0000001 { pt } else { stats_dist_neg_binomial_point_scale(pt, 1.0 / n) }
}

pub fn stats_dist_neg_binomial_point_negate(pt : StatsdistnegbinomialPoint) -> StatsdistnegbinomialPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn stats_dist_neg_binomial_point_mid(a : StatsdistnegbinomialPoint, b : StatsdistnegbinomialPoint) -> StatsdistnegbinomialPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn stats_dist_neg_binomial_point_lerp(a : StatsdistnegbinomialPoint, b : StatsdistnegbinomialPoint, t : Double) -> StatsdistnegbinomialPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn stats_dist_neg_binomial_point_to_string(pt : StatsdistnegbinomialPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct StatsdistnegbinomialSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn stats_dist_neg_binomial_make_series(vals : Array[Double], name : String) -> StatsdistnegbinomialSeries {
  { vals, name, meta: 0 }
}

pub fn stats_dist_neg_binomial_series_len(s : StatsdistnegbinomialSeries) -> Int { s.vals.length() }

pub fn stats_dist_neg_binomial_series_sum(s : StatsdistnegbinomialSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn stats_dist_neg_binomial_series_mean(s : StatsdistnegbinomialSeries) -> Double {
  let n = stats_dist_neg_binomial_series_len(s)
  if n == 0 { 0.0 } else { stats_dist_neg_binomial_series_sum(s) / n.to_double() }
}

pub fn stats_dist_neg_binomial_series_min(s : StatsdistnegbinomialSeries) -> Double {
  let n = stats_dist_neg_binomial_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn stats_dist_neg_binomial_series_max(s : StatsdistnegbinomialSeries) -> Double {
  let n = stats_dist_neg_binomial_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn stats_dist_neg_binomial_series_range(s : StatsdistnegbinomialSeries) -> Double {
  stats_dist_neg_binomial_series_max(s) - stats_dist_neg_binomial_series_min(s)
}

pub fn stats_dist_neg_binomial_series_var(s : StatsdistnegbinomialSeries) -> Double {
  let n = stats_dist_neg_binomial_series_len(s)
  if n == 0 { 0.0 } else {
    let m = stats_dist_neg_binomial_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn stats_dist_neg_binomial_series_std(s : StatsdistnegbinomialSeries) -> Double { @_common.sqrt(stats_dist_neg_binomial_series_var(s)) }

pub fn stats_dist_neg_binomial_series_median(s : StatsdistnegbinomialSeries) -> Double {
  let n = stats_dist_neg_binomial_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = stats_dist_neg_binomial_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn stats_dist_neg_binomial_series_scale(s : StatsdistnegbinomialSeries, f : Double) -> StatsdistnegbinomialSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn stats_dist_neg_binomial_series_add(a : StatsdistnegbinomialSeries, b : StatsdistnegbinomialSeries) -> StatsdistnegbinomialSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn stats_dist_neg_binomial_series_sub(a : StatsdistnegbinomialSeries, b : StatsdistnegbinomialSeries) -> StatsdistnegbinomialSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn stats_dist_neg_binomial_series_normalize(s : StatsdistnegbinomialSeries) -> StatsdistnegbinomialSeries {
  let mn = stats_dist_neg_binomial_series_min(s)
  let mx = stats_dist_neg_binomial_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn stats_dist_neg_binomial_series_cumsum(s : StatsdistnegbinomialSeries) -> StatsdistnegbinomialSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn stats_dist_neg_binomial_series_to_string(s : StatsdistnegbinomialSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct StatsdistnegbinomialMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn stats_dist_neg_binomial_make_matrix(rows : Int, cols : Int, val : Double) -> StatsdistnegbinomialMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn stats_dist_neg_binomial_matrix_identity(n : Int) -> StatsdistnegbinomialMatrix {
  let m = stats_dist_neg_binomial_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn stats_dist_neg_binomial_matrix_get(m : StatsdistnegbinomialMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn stats_dist_neg_binomial_matrix_transpose(m : StatsdistnegbinomialMatrix) -> StatsdistnegbinomialMatrix {
  let result = stats_dist_neg_binomial_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn stats_dist_neg_binomial_matrix_add(a : StatsdistnegbinomialMatrix, b : StatsdistnegbinomialMatrix) -> StatsdistnegbinomialMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = stats_dist_neg_binomial_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn stats_dist_neg_binomial_matrix_scale(m : StatsdistnegbinomialMatrix, s : Double) -> StatsdistnegbinomialMatrix {
  let result = stats_dist_neg_binomial_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn stats_dist_neg_binomial_matrix_multiply(a : StatsdistnegbinomialMatrix, b : StatsdistnegbinomialMatrix) -> StatsdistnegbinomialMatrix {
  if a.cols != b.rows { return stats_dist_neg_binomial_make_matrix(a.rows, b.cols, 0.0) }
  let result = stats_dist_neg_binomial_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn stats_dist_neg_binomial_matrix_trace(m : StatsdistnegbinomialMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn stats_dist_neg_binomial_matrix_det(m : StatsdistnegbinomialMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn stats_dist_neg_binomial_matrix_norm(m : StatsdistnegbinomialMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn stats_dist_neg_binomial_matrix_to_string(m : StatsdistnegbinomialMatrix) -> String {
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

pub(all) struct StatsdistnegbinomialVector {
  comps : Array[Double]
  dim : Int
}

pub fn stats_dist_neg_binomial_make_vector(comps : Array[Double]) -> StatsdistnegbinomialVector {
  { comps, dim: comps.length() }
}

pub fn stats_dist_neg_binomial_vector_zero(dim : Int) -> StatsdistnegbinomialVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn stats_dist_neg_binomial_vector_add(a : StatsdistnegbinomialVector, b : StatsdistnegbinomialVector) -> StatsdistnegbinomialVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn stats_dist_neg_binomial_vector_sub(a : StatsdistnegbinomialVector, b : StatsdistnegbinomialVector) -> StatsdistnegbinomialVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn stats_dist_neg_binomial_vector_scale(v : StatsdistnegbinomialVector, s : Double) -> StatsdistnegbinomialVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn stats_dist_neg_binomial_vector_dot(a : StatsdistnegbinomialVector, b : StatsdistnegbinomialVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn stats_dist_neg_binomial_vector_norm(v : StatsdistnegbinomialVector) -> Double { @_common.sqrt(stats_dist_neg_binomial_vector_dot(v, v)) }

pub fn stats_dist_neg_binomial_vector_normalize(v : StatsdistnegbinomialVector) -> StatsdistnegbinomialVector {
  let n = stats_dist_neg_binomial_vector_norm(v)
  if n < 0.0000001 { v } else { stats_dist_neg_binomial_vector_scale(v, 1.0 / n) }
}

pub fn stats_dist_neg_binomial_vector_dist(a : StatsdistnegbinomialVector, b : StatsdistnegbinomialVector) -> Double {
  stats_dist_neg_binomial_vector_norm(stats_dist_neg_binomial_vector_sub(a, b))
}

pub fn stats_dist_neg_binomial_vector_to_string(v : StatsdistnegbinomialVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn stats_dist_neg_binomial_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn stats_dist_neg_binomial_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = stats_dist_neg_binomial_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn stats_dist_neg_binomial_std(data : Array[Double]) -> Double { @_common.sqrt(stats_dist_neg_binomial_var(data)) }

pub fn stats_dist_neg_binomial_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = stats_dist_neg_binomial_mean(a); let mb = stats_dist_neg_binomial_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn stats_dist_neg_binomial_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = stats_dist_neg_binomial_std(a); let sb = stats_dist_neg_binomial_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { stats_dist_neg_binomial_cov(a, b) / (sa * sb) }
}

pub fn stats_dist_neg_binomial_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = stats_dist_neg_binomial_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn stats_dist_neg_binomial_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn stats_dist_neg_binomial_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn stats_dist_neg_binomial_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  @_common.sqrt(stats_dist_neg_binomial_mse(pred, labels))
}

pub fn stats_dist_neg_binomial_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn stats_dist_neg_binomial_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = stats_dist_neg_binomial_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn stats_dist_neg_binomial_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn stats_dist_neg_binomial_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn stats_dist_neg_binomial_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = stats_dist_neg_binomial_precision(pred, labels, pos); let r = stats_dist_neg_binomial_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn stats_dist_neg_binomial_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn stats_dist_neg_binomial_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = stats_dist_neg_binomial_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn stats_dist_neg_binomial_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn stats_dist_neg_binomial_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn stats_dist_neg_binomial_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = stats_dist_neg_binomial_gcd(a, b)
    (a / g) * b
  }
}

pub fn stats_dist_neg_binomial_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn stats_dist_neg_binomial_fibonacci(n : Int) -> Int {
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

pub fn stats_dist_neg_binomial_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = stats_dist_neg_binomial_min(data); let mx = stats_dist_neg_binomial_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn stats_dist_neg_binomial_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = stats_dist_neg_binomial_mean(data); let sd = stats_dist_neg_binomial_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn stats_dist_neg_binomial_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn stats_dist_neg_binomial_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn stats_dist_neg_binomial_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn stats_dist_neg_binomial_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn stats_dist_neg_binomial_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn stats_dist_neg_binomial_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

pub(all) struct StatsdistnegbinomialFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_neg_binomial_frame_make(size : Int) -> StatsdistnegbinomialFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_neg_binomial_frame_len(s : StatsdistnegbinomialFrame) -> Int { s.size }

pub fn stats_dist_neg_binomial_frame_get(s : StatsdistnegbinomialFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_neg_binomial_frame_set(s : StatsdistnegbinomialFrame, i : Int, v : Double) -> StatsdistnegbinomialFrame {
  let result = stats_dist_neg_binomial_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_neg_binomial_frame_sum(s : StatsdistnegbinomialFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_neg_binomial_frame_mean(s : StatsdistnegbinomialFrame) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_neg_binomial_frame_sum(s) / s.size.to_double() }
}

pub fn stats_dist_neg_binomial_frame_scale(s : StatsdistnegbinomialFrame, f : Double) -> StatsdistnegbinomialFrame {
  let result = stats_dist_neg_binomial_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_neg_binomial_frame_add(a : StatsdistnegbinomialFrame, b : StatsdistnegbinomialFrame) -> StatsdistnegbinomialFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_neg_binomial_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_neg_binomial_frame_copy(s : StatsdistnegbinomialFrame) -> StatsdistnegbinomialFrame {
  let result = stats_dist_neg_binomial_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_neg_binomial_frame_fill(s : StatsdistnegbinomialFrame, v : Double) -> StatsdistnegbinomialFrame {
  let result = stats_dist_neg_binomial_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_neg_binomial_frame_min(s : StatsdistnegbinomialFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_neg_binomial_frame_max(s : StatsdistnegbinomialFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_neg_binomial_frame_to_string(s : StatsdistnegbinomialFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistnegbinomialTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_neg_binomial_table_make(size : Int) -> StatsdistnegbinomialTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_neg_binomial_table_len(s : StatsdistnegbinomialTable) -> Int { s.size }

pub fn stats_dist_neg_binomial_table_get(s : StatsdistnegbinomialTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_neg_binomial_table_set(s : StatsdistnegbinomialTable, i : Int, v : Double) -> StatsdistnegbinomialTable {
  let result = stats_dist_neg_binomial_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_neg_binomial_table_sum(s : StatsdistnegbinomialTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_neg_binomial_table_mean(s : StatsdistnegbinomialTable) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_neg_binomial_table_sum(s) / s.size.to_double() }
}

pub fn stats_dist_neg_binomial_table_scale(s : StatsdistnegbinomialTable, f : Double) -> StatsdistnegbinomialTable {
  let result = stats_dist_neg_binomial_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_neg_binomial_table_add(a : StatsdistnegbinomialTable, b : StatsdistnegbinomialTable) -> StatsdistnegbinomialTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_neg_binomial_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_neg_binomial_table_copy(s : StatsdistnegbinomialTable) -> StatsdistnegbinomialTable {
  let result = stats_dist_neg_binomial_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_neg_binomial_table_fill(s : StatsdistnegbinomialTable, v : Double) -> StatsdistnegbinomialTable {
  let result = stats_dist_neg_binomial_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_neg_binomial_table_min(s : StatsdistnegbinomialTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_neg_binomial_table_max(s : StatsdistnegbinomialTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_neg_binomial_table_to_string(s : StatsdistnegbinomialTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistnegbinomialGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_neg_binomial_graphn_make(size : Int) -> StatsdistnegbinomialGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_neg_binomial_graphn_len(s : StatsdistnegbinomialGraphN) -> Int { s.size }

pub fn stats_dist_neg_binomial_graphn_get(s : StatsdistnegbinomialGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_neg_binomial_graphn_set(s : StatsdistnegbinomialGraphN, i : Int, v : Double) -> StatsdistnegbinomialGraphN {
  let result = stats_dist_neg_binomial_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_neg_binomial_graphn_sum(s : StatsdistnegbinomialGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_neg_binomial_graphn_mean(s : StatsdistnegbinomialGraphN) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_neg_binomial_graphn_sum(s) / s.size.to_double() }
}

pub fn stats_dist_neg_binomial_graphn_scale(s : StatsdistnegbinomialGraphN, f : Double) -> StatsdistnegbinomialGraphN {
  let result = stats_dist_neg_binomial_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_neg_binomial_graphn_add(a : StatsdistnegbinomialGraphN, b : StatsdistnegbinomialGraphN) -> StatsdistnegbinomialGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_neg_binomial_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_neg_binomial_graphn_copy(s : StatsdistnegbinomialGraphN) -> StatsdistnegbinomialGraphN {
  let result = stats_dist_neg_binomial_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_neg_binomial_graphn_fill(s : StatsdistnegbinomialGraphN, v : Double) -> StatsdistnegbinomialGraphN {
  let result = stats_dist_neg_binomial_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_neg_binomial_graphn_min(s : StatsdistnegbinomialGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_neg_binomial_graphn_max(s : StatsdistnegbinomialGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_neg_binomial_graphn_to_string(s : StatsdistnegbinomialGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistnegbinomialNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_neg_binomial_node_make(size : Int) -> StatsdistnegbinomialNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_neg_binomial_node_len(s : StatsdistnegbinomialNode) -> Int { s.size }

pub fn stats_dist_neg_binomial_node_get(s : StatsdistnegbinomialNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_neg_binomial_node_set(s : StatsdistnegbinomialNode, i : Int, v : Double) -> StatsdistnegbinomialNode {
  let result = stats_dist_neg_binomial_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_neg_binomial_node_sum(s : StatsdistnegbinomialNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_neg_binomial_node_mean(s : StatsdistnegbinomialNode) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_neg_binomial_node_sum(s) / s.size.to_double() }
}

pub fn stats_dist_neg_binomial_node_scale(s : StatsdistnegbinomialNode, f : Double) -> StatsdistnegbinomialNode {
  let result = stats_dist_neg_binomial_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_neg_binomial_node_add(a : StatsdistnegbinomialNode, b : StatsdistnegbinomialNode) -> StatsdistnegbinomialNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_neg_binomial_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_neg_binomial_node_copy(s : StatsdistnegbinomialNode) -> StatsdistnegbinomialNode {
  let result = stats_dist_neg_binomial_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_neg_binomial_node_fill(s : StatsdistnegbinomialNode, v : Double) -> StatsdistnegbinomialNode {
  let result = stats_dist_neg_binomial_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_neg_binomial_node_min(s : StatsdistnegbinomialNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_neg_binomial_node_max(s : StatsdistnegbinomialNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_neg_binomial_node_to_string(s : StatsdistnegbinomialNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistnegbinomialEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_neg_binomial_edge_make(size : Int) -> StatsdistnegbinomialEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_neg_binomial_edge_len(s : StatsdistnegbinomialEdge) -> Int { s.size }

pub fn stats_dist_neg_binomial_edge_get(s : StatsdistnegbinomialEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_neg_binomial_edge_set(s : StatsdistnegbinomialEdge, i : Int, v : Double) -> StatsdistnegbinomialEdge {
  let result = stats_dist_neg_binomial_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_neg_binomial_edge_sum(s : StatsdistnegbinomialEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_neg_binomial_edge_mean(s : StatsdistnegbinomialEdge) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_neg_binomial_edge_sum(s) / s.size.to_double() }
}

pub fn stats_dist_neg_binomial_edge_scale(s : StatsdistnegbinomialEdge, f : Double) -> StatsdistnegbinomialEdge {
  let result = stats_dist_neg_binomial_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_neg_binomial_edge_add(a : StatsdistnegbinomialEdge, b : StatsdistnegbinomialEdge) -> StatsdistnegbinomialEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_neg_binomial_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_neg_binomial_edge_copy(s : StatsdistnegbinomialEdge) -> StatsdistnegbinomialEdge {
  let result = stats_dist_neg_binomial_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_neg_binomial_edge_fill(s : StatsdistnegbinomialEdge, v : Double) -> StatsdistnegbinomialEdge {
  let result = stats_dist_neg_binomial_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_neg_binomial_edge_min(s : StatsdistnegbinomialEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_neg_binomial_edge_max(s : StatsdistnegbinomialEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_neg_binomial_edge_to_string(s : StatsdistnegbinomialEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistnegbinomialPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_neg_binomial_path_make(size : Int) -> StatsdistnegbinomialPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_neg_binomial_path_len(s : StatsdistnegbinomialPath) -> Int { s.size }

pub fn stats_dist_neg_binomial_path_get(s : StatsdistnegbinomialPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_neg_binomial_path_set(s : StatsdistnegbinomialPath, i : Int, v : Double) -> StatsdistnegbinomialPath {
  let result = stats_dist_neg_binomial_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_neg_binomial_path_sum(s : StatsdistnegbinomialPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_neg_binomial_path_mean(s : StatsdistnegbinomialPath) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_neg_binomial_path_sum(s) / s.size.to_double() }
}

pub fn stats_dist_neg_binomial_path_scale(s : StatsdistnegbinomialPath, f : Double) -> StatsdistnegbinomialPath {
  let result = stats_dist_neg_binomial_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_neg_binomial_path_add(a : StatsdistnegbinomialPath, b : StatsdistnegbinomialPath) -> StatsdistnegbinomialPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_neg_binomial_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_neg_binomial_path_copy(s : StatsdistnegbinomialPath) -> StatsdistnegbinomialPath {
  let result = stats_dist_neg_binomial_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_neg_binomial_path_fill(s : StatsdistnegbinomialPath, v : Double) -> StatsdistnegbinomialPath {
  let result = stats_dist_neg_binomial_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_neg_binomial_path_min(s : StatsdistnegbinomialPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_neg_binomial_path_max(s : StatsdistnegbinomialPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_neg_binomial_path_to_string(s : StatsdistnegbinomialPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistnegbinomialCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_neg_binomial_cluster_make(size : Int) -> StatsdistnegbinomialCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_neg_binomial_cluster_len(s : StatsdistnegbinomialCluster) -> Int { s.size }

pub fn stats_dist_neg_binomial_cluster_get(s : StatsdistnegbinomialCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_neg_binomial_cluster_set(s : StatsdistnegbinomialCluster, i : Int, v : Double) -> StatsdistnegbinomialCluster {
  let result = stats_dist_neg_binomial_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_neg_binomial_cluster_sum(s : StatsdistnegbinomialCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_neg_binomial_cluster_mean(s : StatsdistnegbinomialCluster) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_neg_binomial_cluster_sum(s) / s.size.to_double() }
}

pub fn stats_dist_neg_binomial_cluster_scale(s : StatsdistnegbinomialCluster, f : Double) -> StatsdistnegbinomialCluster {
  let result = stats_dist_neg_binomial_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_neg_binomial_cluster_add(a : StatsdistnegbinomialCluster, b : StatsdistnegbinomialCluster) -> StatsdistnegbinomialCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_neg_binomial_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_neg_binomial_cluster_copy(s : StatsdistnegbinomialCluster) -> StatsdistnegbinomialCluster {
  let result = stats_dist_neg_binomial_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_neg_binomial_cluster_fill(s : StatsdistnegbinomialCluster, v : Double) -> StatsdistnegbinomialCluster {
  let result = stats_dist_neg_binomial_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_neg_binomial_cluster_min(s : StatsdistnegbinomialCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_neg_binomial_cluster_max(s : StatsdistnegbinomialCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_neg_binomial_cluster_to_string(s : StatsdistnegbinomialCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistnegbinomialModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_neg_binomial_model_make(size : Int) -> StatsdistnegbinomialModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_neg_binomial_model_len(s : StatsdistnegbinomialModel) -> Int { s.size }

pub fn stats_dist_neg_binomial_model_get(s : StatsdistnegbinomialModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_neg_binomial_model_set(s : StatsdistnegbinomialModel, i : Int, v : Double) -> StatsdistnegbinomialModel {
  let result = stats_dist_neg_binomial_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_neg_binomial_model_sum(s : StatsdistnegbinomialModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_neg_binomial_model_mean(s : StatsdistnegbinomialModel) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_neg_binomial_model_sum(s) / s.size.to_double() }
}

pub fn stats_dist_neg_binomial_model_scale(s : StatsdistnegbinomialModel, f : Double) -> StatsdistnegbinomialModel {
  let result = stats_dist_neg_binomial_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_neg_binomial_model_add(a : StatsdistnegbinomialModel, b : StatsdistnegbinomialModel) -> StatsdistnegbinomialModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_neg_binomial_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_neg_binomial_model_copy(s : StatsdistnegbinomialModel) -> StatsdistnegbinomialModel {
  let result = stats_dist_neg_binomial_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_neg_binomial_model_fill(s : StatsdistnegbinomialModel, v : Double) -> StatsdistnegbinomialModel {
  let result = stats_dist_neg_binomial_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_neg_binomial_model_min(s : StatsdistnegbinomialModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_neg_binomial_model_max(s : StatsdistnegbinomialModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_neg_binomial_model_to_string(s : StatsdistnegbinomialModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistnegbinomialLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_neg_binomial_layer_make(size : Int) -> StatsdistnegbinomialLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_neg_binomial_layer_len(s : StatsdistnegbinomialLayer) -> Int { s.size }

pub fn stats_dist_neg_binomial_layer_get(s : StatsdistnegbinomialLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_neg_binomial_layer_set(s : StatsdistnegbinomialLayer, i : Int, v : Double) -> StatsdistnegbinomialLayer {
  let result = stats_dist_neg_binomial_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_neg_binomial_layer_sum(s : StatsdistnegbinomialLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_neg_binomial_layer_mean(s : StatsdistnegbinomialLayer) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_neg_binomial_layer_sum(s) / s.size.to_double() }
}

pub fn stats_dist_neg_binomial_layer_scale(s : StatsdistnegbinomialLayer, f : Double) -> StatsdistnegbinomialLayer {
  let result = stats_dist_neg_binomial_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_neg_binomial_layer_add(a : StatsdistnegbinomialLayer, b : StatsdistnegbinomialLayer) -> StatsdistnegbinomialLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_neg_binomial_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_neg_binomial_layer_copy(s : StatsdistnegbinomialLayer) -> StatsdistnegbinomialLayer {
  let result = stats_dist_neg_binomial_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_neg_binomial_layer_fill(s : StatsdistnegbinomialLayer, v : Double) -> StatsdistnegbinomialLayer {
  let result = stats_dist_neg_binomial_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_neg_binomial_layer_min(s : StatsdistnegbinomialLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_neg_binomial_layer_max(s : StatsdistnegbinomialLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_neg_binomial_layer_to_string(s : StatsdistnegbinomialLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistnegbinomialBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_neg_binomial_buffer_make(size : Int) -> StatsdistnegbinomialBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_neg_binomial_buffer_len(s : StatsdistnegbinomialBuffer) -> Int { s.size }

pub fn stats_dist_neg_binomial_buffer_get(s : StatsdistnegbinomialBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_neg_binomial_buffer_set(s : StatsdistnegbinomialBuffer, i : Int, v : Double) -> StatsdistnegbinomialBuffer {
  let result = stats_dist_neg_binomial_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_neg_binomial_buffer_sum(s : StatsdistnegbinomialBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_neg_binomial_buffer_mean(s : StatsdistnegbinomialBuffer) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_neg_binomial_buffer_sum(s) / s.size.to_double() }
}

pub fn stats_dist_neg_binomial_buffer_scale(s : StatsdistnegbinomialBuffer, f : Double) -> StatsdistnegbinomialBuffer {
  let result = stats_dist_neg_binomial_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_neg_binomial_buffer_add(a : StatsdistnegbinomialBuffer, b : StatsdistnegbinomialBuffer) -> StatsdistnegbinomialBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_neg_binomial_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_neg_binomial_buffer_copy(s : StatsdistnegbinomialBuffer) -> StatsdistnegbinomialBuffer {
  let result = stats_dist_neg_binomial_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_neg_binomial_buffer_fill(s : StatsdistnegbinomialBuffer, v : Double) -> StatsdistnegbinomialBuffer {
  let result = stats_dist_neg_binomial_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_neg_binomial_buffer_min(s : StatsdistnegbinomialBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_neg_binomial_buffer_max(s : StatsdistnegbinomialBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_neg_binomial_buffer_to_string(s : StatsdistnegbinomialBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistnegbinomialCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_neg_binomial_cursor_make(size : Int) -> StatsdistnegbinomialCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_neg_binomial_cursor_len(s : StatsdistnegbinomialCursor) -> Int { s.size }

pub fn stats_dist_neg_binomial_cursor_get(s : StatsdistnegbinomialCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_neg_binomial_cursor_set(s : StatsdistnegbinomialCursor, i : Int, v : Double) -> StatsdistnegbinomialCursor {
  let result = stats_dist_neg_binomial_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_neg_binomial_cursor_sum(s : StatsdistnegbinomialCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_neg_binomial_cursor_mean(s : StatsdistnegbinomialCursor) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_neg_binomial_cursor_sum(s) / s.size.to_double() }
}

pub fn stats_dist_neg_binomial_cursor_scale(s : StatsdistnegbinomialCursor, f : Double) -> StatsdistnegbinomialCursor {
  let result = stats_dist_neg_binomial_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_neg_binomial_cursor_add(a : StatsdistnegbinomialCursor, b : StatsdistnegbinomialCursor) -> StatsdistnegbinomialCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_neg_binomial_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_neg_binomial_cursor_copy(s : StatsdistnegbinomialCursor) -> StatsdistnegbinomialCursor {
  let result = stats_dist_neg_binomial_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_neg_binomial_cursor_fill(s : StatsdistnegbinomialCursor, v : Double) -> StatsdistnegbinomialCursor {
  let result = stats_dist_neg_binomial_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_neg_binomial_cursor_min(s : StatsdistnegbinomialCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_neg_binomial_cursor_max(s : StatsdistnegbinomialCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_neg_binomial_cursor_to_string(s : StatsdistnegbinomialCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistnegbinomialView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_neg_binomial_view_make(size : Int) -> StatsdistnegbinomialView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_neg_binomial_view_len(s : StatsdistnegbinomialView) -> Int { s.size }

pub fn stats_dist_neg_binomial_view_get(s : StatsdistnegbinomialView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_neg_binomial_view_set(s : StatsdistnegbinomialView, i : Int, v : Double) -> StatsdistnegbinomialView {
  let result = stats_dist_neg_binomial_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_neg_binomial_view_sum(s : StatsdistnegbinomialView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_neg_binomial_view_mean(s : StatsdistnegbinomialView) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_neg_binomial_view_sum(s) / s.size.to_double() }
}

pub fn stats_dist_neg_binomial_view_scale(s : StatsdistnegbinomialView, f : Double) -> StatsdistnegbinomialView {
  let result = stats_dist_neg_binomial_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_neg_binomial_view_add(a : StatsdistnegbinomialView, b : StatsdistnegbinomialView) -> StatsdistnegbinomialView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_neg_binomial_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_neg_binomial_view_copy(s : StatsdistnegbinomialView) -> StatsdistnegbinomialView {
  let result = stats_dist_neg_binomial_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_neg_binomial_view_fill(s : StatsdistnegbinomialView, v : Double) -> StatsdistnegbinomialView {
  let result = stats_dist_neg_binomial_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_neg_binomial_view_min(s : StatsdistnegbinomialView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_neg_binomial_view_max(s : StatsdistnegbinomialView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_neg_binomial_view_to_string(s : StatsdistnegbinomialView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistnegbinomialRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_neg_binomial_range_make(size : Int) -> StatsdistnegbinomialRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_neg_binomial_range_len(s : StatsdistnegbinomialRange) -> Int { s.size }

pub fn stats_dist_neg_binomial_range_get(s : StatsdistnegbinomialRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_neg_binomial_range_set(s : StatsdistnegbinomialRange, i : Int, v : Double) -> StatsdistnegbinomialRange {
  let result = stats_dist_neg_binomial_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_neg_binomial_range_sum(s : StatsdistnegbinomialRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_neg_binomial_range_mean(s : StatsdistnegbinomialRange) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_neg_binomial_range_sum(s) / s.size.to_double() }
}

pub fn stats_dist_neg_binomial_range_scale(s : StatsdistnegbinomialRange, f : Double) -> StatsdistnegbinomialRange {
  let result = stats_dist_neg_binomial_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_neg_binomial_range_add(a : StatsdistnegbinomialRange, b : StatsdistnegbinomialRange) -> StatsdistnegbinomialRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_neg_binomial_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_neg_binomial_range_copy(s : StatsdistnegbinomialRange) -> StatsdistnegbinomialRange {
  let result = stats_dist_neg_binomial_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_neg_binomial_range_fill(s : StatsdistnegbinomialRange, v : Double) -> StatsdistnegbinomialRange {
  let result = stats_dist_neg_binomial_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_neg_binomial_range_min(s : StatsdistnegbinomialRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_neg_binomial_range_max(s : StatsdistnegbinomialRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_neg_binomial_range_to_string(s : StatsdistnegbinomialRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistnegbinomialSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_neg_binomial_slice_make(size : Int) -> StatsdistnegbinomialSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_neg_binomial_slice_len(s : StatsdistnegbinomialSlice) -> Int { s.size }

pub fn stats_dist_neg_binomial_slice_get(s : StatsdistnegbinomialSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_neg_binomial_slice_set(s : StatsdistnegbinomialSlice, i : Int, v : Double) -> StatsdistnegbinomialSlice {
  let result = stats_dist_neg_binomial_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_neg_binomial_slice_sum(s : StatsdistnegbinomialSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_neg_binomial_slice_mean(s : StatsdistnegbinomialSlice) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_neg_binomial_slice_sum(s) / s.size.to_double() }
}

pub fn stats_dist_neg_binomial_slice_scale(s : StatsdistnegbinomialSlice, f : Double) -> StatsdistnegbinomialSlice {
  let result = stats_dist_neg_binomial_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_neg_binomial_slice_add(a : StatsdistnegbinomialSlice, b : StatsdistnegbinomialSlice) -> StatsdistnegbinomialSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_neg_binomial_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_neg_binomial_slice_copy(s : StatsdistnegbinomialSlice) -> StatsdistnegbinomialSlice {
  let result = stats_dist_neg_binomial_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_neg_binomial_slice_fill(s : StatsdistnegbinomialSlice, v : Double) -> StatsdistnegbinomialSlice {
  let result = stats_dist_neg_binomial_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_neg_binomial_slice_min(s : StatsdistnegbinomialSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_neg_binomial_slice_max(s : StatsdistnegbinomialSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_neg_binomial_slice_to_string(s : StatsdistnegbinomialSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

