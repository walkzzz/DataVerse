///===
/// extcore/opt_convex_line_search

pub(all) struct OptconvexlinesearchPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn opt_convex_line_search_make_point(x : Double, y : Double) -> OptconvexlinesearchPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn opt_convex_line_search_make_point3(x : Double, y : Double, z : Double) -> OptconvexlinesearchPoint {
  { x, y, z, label: 0 }
}

pub fn opt_convex_line_search_point_x(pt : OptconvexlinesearchPoint) -> Double { pt.x }

pub fn opt_convex_line_search_point_y(pt : OptconvexlinesearchPoint) -> Double { pt.y }

pub fn opt_convex_line_search_point_z(pt : OptconvexlinesearchPoint) -> Double { pt.z }

pub fn opt_convex_line_search_point_label(pt : OptconvexlinesearchPoint) -> Int { pt.label }

pub fn opt_convex_line_search_point_dist(a : OptconvexlinesearchPoint, b : OptconvexlinesearchPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  opt_convex_line_search_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn opt_convex_line_search_point_add(a : OptconvexlinesearchPoint, b : OptconvexlinesearchPoint) -> OptconvexlinesearchPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn opt_convex_line_search_point_sub(a : OptconvexlinesearchPoint, b : OptconvexlinesearchPoint) -> OptconvexlinesearchPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn opt_convex_line_search_point_scale(pt : OptconvexlinesearchPoint, s : Double) -> OptconvexlinesearchPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn opt_convex_line_search_point_dot(a : OptconvexlinesearchPoint, b : OptconvexlinesearchPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn opt_convex_line_search_point_cross(a : OptconvexlinesearchPoint, b : OptconvexlinesearchPoint) -> OptconvexlinesearchPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn opt_convex_line_search_point_norm(pt : OptconvexlinesearchPoint) -> Double {
  opt_convex_line_search_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn opt_convex_line_search_point_normalize(pt : OptconvexlinesearchPoint) -> OptconvexlinesearchPoint {
  let n = opt_convex_line_search_point_norm(pt)
  if n < 0.0000001 { pt } else { opt_convex_line_search_point_scale(pt, 1.0 / n) }
}

pub fn opt_convex_line_search_point_negate(pt : OptconvexlinesearchPoint) -> OptconvexlinesearchPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn opt_convex_line_search_point_mid(a : OptconvexlinesearchPoint, b : OptconvexlinesearchPoint) -> OptconvexlinesearchPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn opt_convex_line_search_point_lerp(a : OptconvexlinesearchPoint, b : OptconvexlinesearchPoint, t : Double) -> OptconvexlinesearchPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn opt_convex_line_search_point_to_string(pt : OptconvexlinesearchPoint) -> String {
  "(" + opt_convex_line_search_dbl(pt.x) + ", " + opt_convex_line_search_dbl(pt.y) + ", " + opt_convex_line_search_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct OptconvexlinesearchSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn opt_convex_line_search_make_series(vals : Array[Double], name : String) -> OptconvexlinesearchSeries {
  { vals, name, meta: 0 }
}

pub fn opt_convex_line_search_series_len(s : OptconvexlinesearchSeries) -> Int { s.vals.length() }

pub fn opt_convex_line_search_series_sum(s : OptconvexlinesearchSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn opt_convex_line_search_series_mean(s : OptconvexlinesearchSeries) -> Double {
  let n = opt_convex_line_search_series_len(s)
  if n == 0 { 0.0 } else { opt_convex_line_search_series_sum(s) / n.to_double() }
}

pub fn opt_convex_line_search_series_min(s : OptconvexlinesearchSeries) -> Double {
  let n = opt_convex_line_search_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn opt_convex_line_search_series_max(s : OptconvexlinesearchSeries) -> Double {
  let n = opt_convex_line_search_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn opt_convex_line_search_series_range(s : OptconvexlinesearchSeries) -> Double {
  opt_convex_line_search_series_max(s) - opt_convex_line_search_series_min(s)
}

pub fn opt_convex_line_search_series_var(s : OptconvexlinesearchSeries) -> Double {
  let n = opt_convex_line_search_series_len(s)
  if n == 0 { 0.0 } else {
    let m = opt_convex_line_search_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn opt_convex_line_search_series_std(s : OptconvexlinesearchSeries) -> Double { opt_convex_line_search_sqrt(opt_convex_line_search_series_var(s)) }

pub fn opt_convex_line_search_series_median(s : OptconvexlinesearchSeries) -> Double {
  let n = opt_convex_line_search_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = opt_convex_line_search_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn opt_convex_line_search_series_scale(s : OptconvexlinesearchSeries, f : Double) -> OptconvexlinesearchSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = opt_convex_line_search_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn opt_convex_line_search_series_add(a : OptconvexlinesearchSeries, b : OptconvexlinesearchSeries) -> OptconvexlinesearchSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = opt_convex_line_search_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn opt_convex_line_search_series_sub(a : OptconvexlinesearchSeries, b : OptconvexlinesearchSeries) -> OptconvexlinesearchSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = opt_convex_line_search_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn opt_convex_line_search_series_normalize(s : OptconvexlinesearchSeries) -> OptconvexlinesearchSeries {
  let mn = opt_convex_line_search_series_min(s)
  let mx = opt_convex_line_search_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = opt_convex_line_search_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn opt_convex_line_search_series_cumsum(s : OptconvexlinesearchSeries) -> OptconvexlinesearchSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = opt_convex_line_search_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn opt_convex_line_search_series_to_string(s : OptconvexlinesearchSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + opt_convex_line_search_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct OptconvexlinesearchMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn opt_convex_line_search_make_matrix(rows : Int, cols : Int, val : Double) -> OptconvexlinesearchMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn opt_convex_line_search_matrix_identity(n : Int) -> OptconvexlinesearchMatrix {
  let m = opt_convex_line_search_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn opt_convex_line_search_matrix_get(m : OptconvexlinesearchMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn opt_convex_line_search_matrix_transpose(m : OptconvexlinesearchMatrix) -> OptconvexlinesearchMatrix {
  let result = opt_convex_line_search_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn opt_convex_line_search_matrix_add(a : OptconvexlinesearchMatrix, b : OptconvexlinesearchMatrix) -> OptconvexlinesearchMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = opt_convex_line_search_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn opt_convex_line_search_matrix_scale(m : OptconvexlinesearchMatrix, s : Double) -> OptconvexlinesearchMatrix {
  let result = opt_convex_line_search_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn opt_convex_line_search_matrix_multiply(a : OptconvexlinesearchMatrix, b : OptconvexlinesearchMatrix) -> OptconvexlinesearchMatrix {
  if a.cols != b.rows { return opt_convex_line_search_make_matrix(a.rows, b.cols, 0.0) }
  let result = opt_convex_line_search_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn opt_convex_line_search_matrix_trace(m : OptconvexlinesearchMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn opt_convex_line_search_matrix_det(m : OptconvexlinesearchMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn opt_convex_line_search_matrix_norm(m : OptconvexlinesearchMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  opt_convex_line_search_sqrt(sum)
}

pub fn opt_convex_line_search_matrix_to_string(m : OptconvexlinesearchMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + opt_convex_line_search_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct OptconvexlinesearchVector {
  comps : Array[Double]
  dim : Int
}

pub fn opt_convex_line_search_make_vector(comps : Array[Double]) -> OptconvexlinesearchVector {
  { comps, dim: comps.length() }
}

pub fn opt_convex_line_search_vector_zero(dim : Int) -> OptconvexlinesearchVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn opt_convex_line_search_vector_add(a : OptconvexlinesearchVector, b : OptconvexlinesearchVector) -> OptconvexlinesearchVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = opt_convex_line_search_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn opt_convex_line_search_vector_sub(a : OptconvexlinesearchVector, b : OptconvexlinesearchVector) -> OptconvexlinesearchVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = opt_convex_line_search_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn opt_convex_line_search_vector_scale(v : OptconvexlinesearchVector, s : Double) -> OptconvexlinesearchVector {
  let mut result = []
  for i in 0..<v.dim { result = opt_convex_line_search_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn opt_convex_line_search_vector_dot(a : OptconvexlinesearchVector, b : OptconvexlinesearchVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn opt_convex_line_search_vector_norm(v : OptconvexlinesearchVector) -> Double { opt_convex_line_search_sqrt(opt_convex_line_search_vector_dot(v, v)) }

pub fn opt_convex_line_search_vector_normalize(v : OptconvexlinesearchVector) -> OptconvexlinesearchVector {
  let n = opt_convex_line_search_vector_norm(v)
  if n < 0.0000001 { v } else { opt_convex_line_search_vector_scale(v, 1.0 / n) }
}

pub fn opt_convex_line_search_vector_dist(a : OptconvexlinesearchVector, b : OptconvexlinesearchVector) -> Double {
  opt_convex_line_search_vector_norm(opt_convex_line_search_vector_sub(a, b))
}

pub fn opt_convex_line_search_vector_to_string(v : OptconvexlinesearchVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + opt_convex_line_search_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn opt_convex_line_search_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn opt_convex_line_search_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = opt_convex_line_search_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn opt_convex_line_search_std(data : Array[Double]) -> Double { opt_convex_line_search_sqrt(opt_convex_line_search_var(data)) }

pub fn opt_convex_line_search_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = opt_convex_line_search_mean(a); let mb = opt_convex_line_search_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn opt_convex_line_search_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = opt_convex_line_search_std(a); let sb = opt_convex_line_search_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { opt_convex_line_search_cov(a, b) / (sa * sb) }
}

pub fn opt_convex_line_search_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = opt_convex_line_search_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn opt_convex_line_search_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn opt_convex_line_search_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn opt_convex_line_search_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  opt_convex_line_search_sqrt(opt_convex_line_search_mse(pred, labels))
}

pub fn opt_convex_line_search_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + opt_convex_line_search_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn opt_convex_line_search_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = opt_convex_line_search_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn opt_convex_line_search_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn opt_convex_line_search_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn opt_convex_line_search_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = opt_convex_line_search_precision(pred, labels, pos); let r = opt_convex_line_search_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn opt_convex_line_search_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn opt_convex_line_search_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = opt_convex_line_search_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn opt_convex_line_search_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn opt_convex_line_search_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn opt_convex_line_search_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = opt_convex_line_search_gcd(a, b)
    (a / g) * b
  }
}

pub fn opt_convex_line_search_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn opt_convex_line_search_fibonacci(n : Int) -> Int {
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

pub fn opt_convex_line_search_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = opt_convex_line_search_min(data); let mx = opt_convex_line_search_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn opt_convex_line_search_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = opt_convex_line_search_mean(data); let sd = opt_convex_line_search_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn opt_convex_line_search_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn opt_convex_line_search_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn opt_convex_line_search_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn opt_convex_line_search_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn opt_convex_line_search_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn opt_convex_line_search_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn opt_convex_line_search_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn opt_convex_line_search_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn opt_convex_line_search_dbl(x : Double) -> String {
  let i = if x >= 0.0 { opt_convex_line_search_int(x) } else { -opt_convex_line_search_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { opt_convex_line_search_int(f * 1000000.0) } else { opt_convex_line_search_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn opt_convex_line_search_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn opt_convex_line_search_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct OptconvexlinesearchFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_line_search_frame_make(size : Int) -> OptconvexlinesearchFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_line_search_frame_len(s : OptconvexlinesearchFrame) -> Int { s.size }

pub fn opt_convex_line_search_frame_get(s : OptconvexlinesearchFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_line_search_frame_set(s : OptconvexlinesearchFrame, i : Int, v : Double) -> OptconvexlinesearchFrame {
  let result = opt_convex_line_search_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_convex_line_search_frame_sum(s : OptconvexlinesearchFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_convex_line_search_frame_mean(s : OptconvexlinesearchFrame) -> Double {
  if s.size == 0 { 0.0 } else { opt_convex_line_search_frame_sum(s) / s.size.to_double() }
}

pub fn opt_convex_line_search_frame_scale(s : OptconvexlinesearchFrame, f : Double) -> OptconvexlinesearchFrame {
  let result = opt_convex_line_search_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_convex_line_search_frame_add(a : OptconvexlinesearchFrame, b : OptconvexlinesearchFrame) -> OptconvexlinesearchFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_convex_line_search_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_convex_line_search_frame_copy(s : OptconvexlinesearchFrame) -> OptconvexlinesearchFrame {
  let result = opt_convex_line_search_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_convex_line_search_frame_fill(s : OptconvexlinesearchFrame, v : Double) -> OptconvexlinesearchFrame {
  let result = opt_convex_line_search_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_convex_line_search_frame_min(s : OptconvexlinesearchFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_line_search_frame_max(s : OptconvexlinesearchFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_line_search_frame_to_string(s : OptconvexlinesearchFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexlinesearchTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_line_search_table_make(size : Int) -> OptconvexlinesearchTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_line_search_table_len(s : OptconvexlinesearchTable) -> Int { s.size }

pub fn opt_convex_line_search_table_get(s : OptconvexlinesearchTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_line_search_table_set(s : OptconvexlinesearchTable, i : Int, v : Double) -> OptconvexlinesearchTable {
  let result = opt_convex_line_search_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_convex_line_search_table_sum(s : OptconvexlinesearchTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_convex_line_search_table_mean(s : OptconvexlinesearchTable) -> Double {
  if s.size == 0 { 0.0 } else { opt_convex_line_search_table_sum(s) / s.size.to_double() }
}

pub fn opt_convex_line_search_table_scale(s : OptconvexlinesearchTable, f : Double) -> OptconvexlinesearchTable {
  let result = opt_convex_line_search_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_convex_line_search_table_add(a : OptconvexlinesearchTable, b : OptconvexlinesearchTable) -> OptconvexlinesearchTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_convex_line_search_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_convex_line_search_table_copy(s : OptconvexlinesearchTable) -> OptconvexlinesearchTable {
  let result = opt_convex_line_search_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_convex_line_search_table_fill(s : OptconvexlinesearchTable, v : Double) -> OptconvexlinesearchTable {
  let result = opt_convex_line_search_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_convex_line_search_table_min(s : OptconvexlinesearchTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_line_search_table_max(s : OptconvexlinesearchTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_line_search_table_to_string(s : OptconvexlinesearchTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexlinesearchGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_line_search_graphn_make(size : Int) -> OptconvexlinesearchGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_line_search_graphn_len(s : OptconvexlinesearchGraphN) -> Int { s.size }

pub fn opt_convex_line_search_graphn_get(s : OptconvexlinesearchGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_line_search_graphn_set(s : OptconvexlinesearchGraphN, i : Int, v : Double) -> OptconvexlinesearchGraphN {
  let result = opt_convex_line_search_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_convex_line_search_graphn_sum(s : OptconvexlinesearchGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_convex_line_search_graphn_mean(s : OptconvexlinesearchGraphN) -> Double {
  if s.size == 0 { 0.0 } else { opt_convex_line_search_graphn_sum(s) / s.size.to_double() }
}

pub fn opt_convex_line_search_graphn_scale(s : OptconvexlinesearchGraphN, f : Double) -> OptconvexlinesearchGraphN {
  let result = opt_convex_line_search_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_convex_line_search_graphn_add(a : OptconvexlinesearchGraphN, b : OptconvexlinesearchGraphN) -> OptconvexlinesearchGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_convex_line_search_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_convex_line_search_graphn_copy(s : OptconvexlinesearchGraphN) -> OptconvexlinesearchGraphN {
  let result = opt_convex_line_search_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_convex_line_search_graphn_fill(s : OptconvexlinesearchGraphN, v : Double) -> OptconvexlinesearchGraphN {
  let result = opt_convex_line_search_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_convex_line_search_graphn_min(s : OptconvexlinesearchGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_line_search_graphn_max(s : OptconvexlinesearchGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_line_search_graphn_to_string(s : OptconvexlinesearchGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexlinesearchNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_line_search_node_make(size : Int) -> OptconvexlinesearchNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_line_search_node_len(s : OptconvexlinesearchNode) -> Int { s.size }

pub fn opt_convex_line_search_node_get(s : OptconvexlinesearchNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_line_search_node_set(s : OptconvexlinesearchNode, i : Int, v : Double) -> OptconvexlinesearchNode {
  let result = opt_convex_line_search_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_convex_line_search_node_sum(s : OptconvexlinesearchNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_convex_line_search_node_mean(s : OptconvexlinesearchNode) -> Double {
  if s.size == 0 { 0.0 } else { opt_convex_line_search_node_sum(s) / s.size.to_double() }
}

pub fn opt_convex_line_search_node_scale(s : OptconvexlinesearchNode, f : Double) -> OptconvexlinesearchNode {
  let result = opt_convex_line_search_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_convex_line_search_node_add(a : OptconvexlinesearchNode, b : OptconvexlinesearchNode) -> OptconvexlinesearchNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_convex_line_search_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_convex_line_search_node_copy(s : OptconvexlinesearchNode) -> OptconvexlinesearchNode {
  let result = opt_convex_line_search_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_convex_line_search_node_fill(s : OptconvexlinesearchNode, v : Double) -> OptconvexlinesearchNode {
  let result = opt_convex_line_search_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_convex_line_search_node_min(s : OptconvexlinesearchNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_line_search_node_max(s : OptconvexlinesearchNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_line_search_node_to_string(s : OptconvexlinesearchNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexlinesearchEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_line_search_edge_make(size : Int) -> OptconvexlinesearchEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_line_search_edge_len(s : OptconvexlinesearchEdge) -> Int { s.size }

pub fn opt_convex_line_search_edge_get(s : OptconvexlinesearchEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_line_search_edge_set(s : OptconvexlinesearchEdge, i : Int, v : Double) -> OptconvexlinesearchEdge {
  let result = opt_convex_line_search_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_convex_line_search_edge_sum(s : OptconvexlinesearchEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_convex_line_search_edge_mean(s : OptconvexlinesearchEdge) -> Double {
  if s.size == 0 { 0.0 } else { opt_convex_line_search_edge_sum(s) / s.size.to_double() }
}

pub fn opt_convex_line_search_edge_scale(s : OptconvexlinesearchEdge, f : Double) -> OptconvexlinesearchEdge {
  let result = opt_convex_line_search_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_convex_line_search_edge_add(a : OptconvexlinesearchEdge, b : OptconvexlinesearchEdge) -> OptconvexlinesearchEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_convex_line_search_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_convex_line_search_edge_copy(s : OptconvexlinesearchEdge) -> OptconvexlinesearchEdge {
  let result = opt_convex_line_search_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_convex_line_search_edge_fill(s : OptconvexlinesearchEdge, v : Double) -> OptconvexlinesearchEdge {
  let result = opt_convex_line_search_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_convex_line_search_edge_min(s : OptconvexlinesearchEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_line_search_edge_max(s : OptconvexlinesearchEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_line_search_edge_to_string(s : OptconvexlinesearchEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexlinesearchPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_line_search_path_make(size : Int) -> OptconvexlinesearchPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_line_search_path_len(s : OptconvexlinesearchPath) -> Int { s.size }

pub fn opt_convex_line_search_path_get(s : OptconvexlinesearchPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_line_search_path_set(s : OptconvexlinesearchPath, i : Int, v : Double) -> OptconvexlinesearchPath {
  let result = opt_convex_line_search_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_convex_line_search_path_sum(s : OptconvexlinesearchPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_convex_line_search_path_mean(s : OptconvexlinesearchPath) -> Double {
  if s.size == 0 { 0.0 } else { opt_convex_line_search_path_sum(s) / s.size.to_double() }
}

pub fn opt_convex_line_search_path_scale(s : OptconvexlinesearchPath, f : Double) -> OptconvexlinesearchPath {
  let result = opt_convex_line_search_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_convex_line_search_path_add(a : OptconvexlinesearchPath, b : OptconvexlinesearchPath) -> OptconvexlinesearchPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_convex_line_search_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_convex_line_search_path_copy(s : OptconvexlinesearchPath) -> OptconvexlinesearchPath {
  let result = opt_convex_line_search_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_convex_line_search_path_fill(s : OptconvexlinesearchPath, v : Double) -> OptconvexlinesearchPath {
  let result = opt_convex_line_search_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_convex_line_search_path_min(s : OptconvexlinesearchPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_line_search_path_max(s : OptconvexlinesearchPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_line_search_path_to_string(s : OptconvexlinesearchPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexlinesearchCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_line_search_cluster_make(size : Int) -> OptconvexlinesearchCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_line_search_cluster_len(s : OptconvexlinesearchCluster) -> Int { s.size }

pub fn opt_convex_line_search_cluster_get(s : OptconvexlinesearchCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_line_search_cluster_set(s : OptconvexlinesearchCluster, i : Int, v : Double) -> OptconvexlinesearchCluster {
  let result = opt_convex_line_search_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_convex_line_search_cluster_sum(s : OptconvexlinesearchCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_convex_line_search_cluster_mean(s : OptconvexlinesearchCluster) -> Double {
  if s.size == 0 { 0.0 } else { opt_convex_line_search_cluster_sum(s) / s.size.to_double() }
}

pub fn opt_convex_line_search_cluster_scale(s : OptconvexlinesearchCluster, f : Double) -> OptconvexlinesearchCluster {
  let result = opt_convex_line_search_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_convex_line_search_cluster_add(a : OptconvexlinesearchCluster, b : OptconvexlinesearchCluster) -> OptconvexlinesearchCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_convex_line_search_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_convex_line_search_cluster_copy(s : OptconvexlinesearchCluster) -> OptconvexlinesearchCluster {
  let result = opt_convex_line_search_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_convex_line_search_cluster_fill(s : OptconvexlinesearchCluster, v : Double) -> OptconvexlinesearchCluster {
  let result = opt_convex_line_search_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_convex_line_search_cluster_min(s : OptconvexlinesearchCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_line_search_cluster_max(s : OptconvexlinesearchCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_line_search_cluster_to_string(s : OptconvexlinesearchCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexlinesearchModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_line_search_model_make(size : Int) -> OptconvexlinesearchModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_line_search_model_len(s : OptconvexlinesearchModel) -> Int { s.size }

pub fn opt_convex_line_search_model_get(s : OptconvexlinesearchModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_line_search_model_set(s : OptconvexlinesearchModel, i : Int, v : Double) -> OptconvexlinesearchModel {
  let result = opt_convex_line_search_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_convex_line_search_model_sum(s : OptconvexlinesearchModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_convex_line_search_model_mean(s : OptconvexlinesearchModel) -> Double {
  if s.size == 0 { 0.0 } else { opt_convex_line_search_model_sum(s) / s.size.to_double() }
}

pub fn opt_convex_line_search_model_scale(s : OptconvexlinesearchModel, f : Double) -> OptconvexlinesearchModel {
  let result = opt_convex_line_search_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_convex_line_search_model_add(a : OptconvexlinesearchModel, b : OptconvexlinesearchModel) -> OptconvexlinesearchModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_convex_line_search_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_convex_line_search_model_copy(s : OptconvexlinesearchModel) -> OptconvexlinesearchModel {
  let result = opt_convex_line_search_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_convex_line_search_model_fill(s : OptconvexlinesearchModel, v : Double) -> OptconvexlinesearchModel {
  let result = opt_convex_line_search_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_convex_line_search_model_min(s : OptconvexlinesearchModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_line_search_model_max(s : OptconvexlinesearchModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_line_search_model_to_string(s : OptconvexlinesearchModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexlinesearchLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_line_search_layer_make(size : Int) -> OptconvexlinesearchLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_line_search_layer_len(s : OptconvexlinesearchLayer) -> Int { s.size }

pub fn opt_convex_line_search_layer_get(s : OptconvexlinesearchLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_line_search_layer_set(s : OptconvexlinesearchLayer, i : Int, v : Double) -> OptconvexlinesearchLayer {
  let result = opt_convex_line_search_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_convex_line_search_layer_sum(s : OptconvexlinesearchLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_convex_line_search_layer_mean(s : OptconvexlinesearchLayer) -> Double {
  if s.size == 0 { 0.0 } else { opt_convex_line_search_layer_sum(s) / s.size.to_double() }
}

pub fn opt_convex_line_search_layer_scale(s : OptconvexlinesearchLayer, f : Double) -> OptconvexlinesearchLayer {
  let result = opt_convex_line_search_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_convex_line_search_layer_add(a : OptconvexlinesearchLayer, b : OptconvexlinesearchLayer) -> OptconvexlinesearchLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_convex_line_search_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_convex_line_search_layer_copy(s : OptconvexlinesearchLayer) -> OptconvexlinesearchLayer {
  let result = opt_convex_line_search_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_convex_line_search_layer_fill(s : OptconvexlinesearchLayer, v : Double) -> OptconvexlinesearchLayer {
  let result = opt_convex_line_search_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_convex_line_search_layer_min(s : OptconvexlinesearchLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_line_search_layer_max(s : OptconvexlinesearchLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_line_search_layer_to_string(s : OptconvexlinesearchLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexlinesearchBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_line_search_buffer_make(size : Int) -> OptconvexlinesearchBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_line_search_buffer_len(s : OptconvexlinesearchBuffer) -> Int { s.size }

pub fn opt_convex_line_search_buffer_get(s : OptconvexlinesearchBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_line_search_buffer_set(s : OptconvexlinesearchBuffer, i : Int, v : Double) -> OptconvexlinesearchBuffer {
  let result = opt_convex_line_search_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_convex_line_search_buffer_sum(s : OptconvexlinesearchBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_convex_line_search_buffer_mean(s : OptconvexlinesearchBuffer) -> Double {
  if s.size == 0 { 0.0 } else { opt_convex_line_search_buffer_sum(s) / s.size.to_double() }
}

pub fn opt_convex_line_search_buffer_scale(s : OptconvexlinesearchBuffer, f : Double) -> OptconvexlinesearchBuffer {
  let result = opt_convex_line_search_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_convex_line_search_buffer_add(a : OptconvexlinesearchBuffer, b : OptconvexlinesearchBuffer) -> OptconvexlinesearchBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_convex_line_search_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_convex_line_search_buffer_copy(s : OptconvexlinesearchBuffer) -> OptconvexlinesearchBuffer {
  let result = opt_convex_line_search_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_convex_line_search_buffer_fill(s : OptconvexlinesearchBuffer, v : Double) -> OptconvexlinesearchBuffer {
  let result = opt_convex_line_search_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_convex_line_search_buffer_min(s : OptconvexlinesearchBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_line_search_buffer_max(s : OptconvexlinesearchBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_line_search_buffer_to_string(s : OptconvexlinesearchBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexlinesearchCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_line_search_cursor_make(size : Int) -> OptconvexlinesearchCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_line_search_cursor_len(s : OptconvexlinesearchCursor) -> Int { s.size }

pub fn opt_convex_line_search_cursor_get(s : OptconvexlinesearchCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_line_search_cursor_set(s : OptconvexlinesearchCursor, i : Int, v : Double) -> OptconvexlinesearchCursor {
  let result = opt_convex_line_search_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_convex_line_search_cursor_sum(s : OptconvexlinesearchCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_convex_line_search_cursor_mean(s : OptconvexlinesearchCursor) -> Double {
  if s.size == 0 { 0.0 } else { opt_convex_line_search_cursor_sum(s) / s.size.to_double() }
}

pub fn opt_convex_line_search_cursor_scale(s : OptconvexlinesearchCursor, f : Double) -> OptconvexlinesearchCursor {
  let result = opt_convex_line_search_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_convex_line_search_cursor_add(a : OptconvexlinesearchCursor, b : OptconvexlinesearchCursor) -> OptconvexlinesearchCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_convex_line_search_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_convex_line_search_cursor_copy(s : OptconvexlinesearchCursor) -> OptconvexlinesearchCursor {
  let result = opt_convex_line_search_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_convex_line_search_cursor_fill(s : OptconvexlinesearchCursor, v : Double) -> OptconvexlinesearchCursor {
  let result = opt_convex_line_search_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_convex_line_search_cursor_min(s : OptconvexlinesearchCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_line_search_cursor_max(s : OptconvexlinesearchCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_line_search_cursor_to_string(s : OptconvexlinesearchCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexlinesearchView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_line_search_view_make(size : Int) -> OptconvexlinesearchView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_line_search_view_len(s : OptconvexlinesearchView) -> Int { s.size }

pub fn opt_convex_line_search_view_get(s : OptconvexlinesearchView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_line_search_view_set(s : OptconvexlinesearchView, i : Int, v : Double) -> OptconvexlinesearchView {
  let result = opt_convex_line_search_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_convex_line_search_view_sum(s : OptconvexlinesearchView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_convex_line_search_view_mean(s : OptconvexlinesearchView) -> Double {
  if s.size == 0 { 0.0 } else { opt_convex_line_search_view_sum(s) / s.size.to_double() }
}

pub fn opt_convex_line_search_view_scale(s : OptconvexlinesearchView, f : Double) -> OptconvexlinesearchView {
  let result = opt_convex_line_search_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_convex_line_search_view_add(a : OptconvexlinesearchView, b : OptconvexlinesearchView) -> OptconvexlinesearchView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_convex_line_search_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_convex_line_search_view_copy(s : OptconvexlinesearchView) -> OptconvexlinesearchView {
  let result = opt_convex_line_search_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_convex_line_search_view_fill(s : OptconvexlinesearchView, v : Double) -> OptconvexlinesearchView {
  let result = opt_convex_line_search_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_convex_line_search_view_min(s : OptconvexlinesearchView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_line_search_view_max(s : OptconvexlinesearchView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_line_search_view_to_string(s : OptconvexlinesearchView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexlinesearchRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_line_search_range_make(size : Int) -> OptconvexlinesearchRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_line_search_range_len(s : OptconvexlinesearchRange) -> Int { s.size }

pub fn opt_convex_line_search_range_get(s : OptconvexlinesearchRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_line_search_range_set(s : OptconvexlinesearchRange, i : Int, v : Double) -> OptconvexlinesearchRange {
  let result = opt_convex_line_search_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_convex_line_search_range_sum(s : OptconvexlinesearchRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_convex_line_search_range_mean(s : OptconvexlinesearchRange) -> Double {
  if s.size == 0 { 0.0 } else { opt_convex_line_search_range_sum(s) / s.size.to_double() }
}

pub fn opt_convex_line_search_range_scale(s : OptconvexlinesearchRange, f : Double) -> OptconvexlinesearchRange {
  let result = opt_convex_line_search_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_convex_line_search_range_add(a : OptconvexlinesearchRange, b : OptconvexlinesearchRange) -> OptconvexlinesearchRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_convex_line_search_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_convex_line_search_range_copy(s : OptconvexlinesearchRange) -> OptconvexlinesearchRange {
  let result = opt_convex_line_search_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_convex_line_search_range_fill(s : OptconvexlinesearchRange, v : Double) -> OptconvexlinesearchRange {
  let result = opt_convex_line_search_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_convex_line_search_range_min(s : OptconvexlinesearchRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_line_search_range_max(s : OptconvexlinesearchRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_line_search_range_to_string(s : OptconvexlinesearchRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexlinesearchSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_line_search_slice_make(size : Int) -> OptconvexlinesearchSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_line_search_slice_len(s : OptconvexlinesearchSlice) -> Int { s.size }

pub fn opt_convex_line_search_slice_get(s : OptconvexlinesearchSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_line_search_slice_set(s : OptconvexlinesearchSlice, i : Int, v : Double) -> OptconvexlinesearchSlice {
  let result = opt_convex_line_search_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_convex_line_search_slice_sum(s : OptconvexlinesearchSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_convex_line_search_slice_mean(s : OptconvexlinesearchSlice) -> Double {
  if s.size == 0 { 0.0 } else { opt_convex_line_search_slice_sum(s) / s.size.to_double() }
}

pub fn opt_convex_line_search_slice_scale(s : OptconvexlinesearchSlice, f : Double) -> OptconvexlinesearchSlice {
  let result = opt_convex_line_search_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_convex_line_search_slice_add(a : OptconvexlinesearchSlice, b : OptconvexlinesearchSlice) -> OptconvexlinesearchSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_convex_line_search_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_convex_line_search_slice_copy(s : OptconvexlinesearchSlice) -> OptconvexlinesearchSlice {
  let result = opt_convex_line_search_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_convex_line_search_slice_fill(s : OptconvexlinesearchSlice, v : Double) -> OptconvexlinesearchSlice {
  let result = opt_convex_line_search_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_convex_line_search_slice_min(s : OptconvexlinesearchSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_line_search_slice_max(s : OptconvexlinesearchSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_line_search_slice_to_string(s : OptconvexlinesearchSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn opt_convex_line_search_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_convex_line_search_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_convex_line_search_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_convex_line_search_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_convex_line_search_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_convex_line_search_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_convex_line_search_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_convex_line_search_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_convex_line_search_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_convex_line_search_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_convex_line_search_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_convex_line_search_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_convex_line_search_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_convex_line_search_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_convex_line_search_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_convex_line_search_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_convex_line_search_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_convex_line_search_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_convex_line_search_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_convex_line_search_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_convex_line_search_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_convex_line_search_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_convex_line_search_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_convex_line_search_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_convex_line_search_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

