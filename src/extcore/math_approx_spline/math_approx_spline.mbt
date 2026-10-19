///===
/// extcore/math_approx_spline

pub(all) struct MathapproxsplinePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn math_approx_spline_make_point(x : Double, y : Double) -> MathapproxsplinePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn math_approx_spline_make_point3(x : Double, y : Double, z : Double) -> MathapproxsplinePoint {
  { x, y, z, label: 0 }
}

pub fn math_approx_spline_point_x(pt : MathapproxsplinePoint) -> Double { pt.x }

pub fn math_approx_spline_point_y(pt : MathapproxsplinePoint) -> Double { pt.y }

pub fn math_approx_spline_point_z(pt : MathapproxsplinePoint) -> Double { pt.z }

pub fn math_approx_spline_point_label(pt : MathapproxsplinePoint) -> Int { pt.label }

pub fn math_approx_spline_point_dist(a : MathapproxsplinePoint, b : MathapproxsplinePoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  math_approx_spline_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn math_approx_spline_point_add(a : MathapproxsplinePoint, b : MathapproxsplinePoint) -> MathapproxsplinePoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn math_approx_spline_point_sub(a : MathapproxsplinePoint, b : MathapproxsplinePoint) -> MathapproxsplinePoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn math_approx_spline_point_scale(pt : MathapproxsplinePoint, s : Double) -> MathapproxsplinePoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn math_approx_spline_point_dot(a : MathapproxsplinePoint, b : MathapproxsplinePoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn math_approx_spline_point_cross(a : MathapproxsplinePoint, b : MathapproxsplinePoint) -> MathapproxsplinePoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn math_approx_spline_point_norm(pt : MathapproxsplinePoint) -> Double {
  math_approx_spline_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn math_approx_spline_point_normalize(pt : MathapproxsplinePoint) -> MathapproxsplinePoint {
  let n = math_approx_spline_point_norm(pt)
  if n < 0.0000001 { pt } else { math_approx_spline_point_scale(pt, 1.0 / n) }
}

pub fn math_approx_spline_point_negate(pt : MathapproxsplinePoint) -> MathapproxsplinePoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn math_approx_spline_point_mid(a : MathapproxsplinePoint, b : MathapproxsplinePoint) -> MathapproxsplinePoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn math_approx_spline_point_lerp(a : MathapproxsplinePoint, b : MathapproxsplinePoint, t : Double) -> MathapproxsplinePoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn math_approx_spline_point_to_string(pt : MathapproxsplinePoint) -> String {
  "(" + math_approx_spline_dbl(pt.x) + ", " + math_approx_spline_dbl(pt.y) + ", " + math_approx_spline_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct MathapproxsplineSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn math_approx_spline_make_series(vals : Array[Double], name : String) -> MathapproxsplineSeries {
  { vals, name, meta: 0 }
}

pub fn math_approx_spline_series_len(s : MathapproxsplineSeries) -> Int { s.vals.length() }

pub fn math_approx_spline_series_sum(s : MathapproxsplineSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn math_approx_spline_series_mean(s : MathapproxsplineSeries) -> Double {
  let n = math_approx_spline_series_len(s)
  if n == 0 { 0.0 } else { math_approx_spline_series_sum(s) / n.to_double() }
}

pub fn math_approx_spline_series_min(s : MathapproxsplineSeries) -> Double {
  let n = math_approx_spline_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn math_approx_spline_series_max(s : MathapproxsplineSeries) -> Double {
  let n = math_approx_spline_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn math_approx_spline_series_range(s : MathapproxsplineSeries) -> Double {
  math_approx_spline_series_max(s) - math_approx_spline_series_min(s)
}

pub fn math_approx_spline_series_var(s : MathapproxsplineSeries) -> Double {
  let n = math_approx_spline_series_len(s)
  if n == 0 { 0.0 } else {
    let m = math_approx_spline_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn math_approx_spline_series_std(s : MathapproxsplineSeries) -> Double { math_approx_spline_sqrt(math_approx_spline_series_var(s)) }

pub fn math_approx_spline_series_median(s : MathapproxsplineSeries) -> Double {
  let n = math_approx_spline_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = math_approx_spline_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn math_approx_spline_series_scale(s : MathapproxsplineSeries, f : Double) -> MathapproxsplineSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = math_approx_spline_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn math_approx_spline_series_add(a : MathapproxsplineSeries, b : MathapproxsplineSeries) -> MathapproxsplineSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = math_approx_spline_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn math_approx_spline_series_sub(a : MathapproxsplineSeries, b : MathapproxsplineSeries) -> MathapproxsplineSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = math_approx_spline_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn math_approx_spline_series_normalize(s : MathapproxsplineSeries) -> MathapproxsplineSeries {
  let mn = math_approx_spline_series_min(s)
  let mx = math_approx_spline_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = math_approx_spline_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn math_approx_spline_series_cumsum(s : MathapproxsplineSeries) -> MathapproxsplineSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = math_approx_spline_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn math_approx_spline_series_to_string(s : MathapproxsplineSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + math_approx_spline_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MathapproxsplineMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn math_approx_spline_make_matrix(rows : Int, cols : Int, val : Double) -> MathapproxsplineMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn math_approx_spline_matrix_identity(n : Int) -> MathapproxsplineMatrix {
  let m = math_approx_spline_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn math_approx_spline_matrix_get(m : MathapproxsplineMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn math_approx_spline_matrix_transpose(m : MathapproxsplineMatrix) -> MathapproxsplineMatrix {
  let result = math_approx_spline_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn math_approx_spline_matrix_add(a : MathapproxsplineMatrix, b : MathapproxsplineMatrix) -> MathapproxsplineMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = math_approx_spline_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn math_approx_spline_matrix_scale(m : MathapproxsplineMatrix, s : Double) -> MathapproxsplineMatrix {
  let result = math_approx_spline_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn math_approx_spline_matrix_multiply(a : MathapproxsplineMatrix, b : MathapproxsplineMatrix) -> MathapproxsplineMatrix {
  if a.cols != b.rows { return math_approx_spline_make_matrix(a.rows, b.cols, 0.0) }
  let result = math_approx_spline_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn math_approx_spline_matrix_trace(m : MathapproxsplineMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn math_approx_spline_matrix_det(m : MathapproxsplineMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn math_approx_spline_matrix_norm(m : MathapproxsplineMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  math_approx_spline_sqrt(sum)
}

pub fn math_approx_spline_matrix_to_string(m : MathapproxsplineMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + math_approx_spline_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct MathapproxsplineVector {
  comps : Array[Double]
  dim : Int
}

pub fn math_approx_spline_make_vector(comps : Array[Double]) -> MathapproxsplineVector {
  { comps, dim: comps.length() }
}

pub fn math_approx_spline_vector_zero(dim : Int) -> MathapproxsplineVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn math_approx_spline_vector_add(a : MathapproxsplineVector, b : MathapproxsplineVector) -> MathapproxsplineVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = math_approx_spline_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn math_approx_spline_vector_sub(a : MathapproxsplineVector, b : MathapproxsplineVector) -> MathapproxsplineVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = math_approx_spline_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn math_approx_spline_vector_scale(v : MathapproxsplineVector, s : Double) -> MathapproxsplineVector {
  let mut result = []
  for i in 0..<v.dim { result = math_approx_spline_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn math_approx_spline_vector_dot(a : MathapproxsplineVector, b : MathapproxsplineVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn math_approx_spline_vector_norm(v : MathapproxsplineVector) -> Double { math_approx_spline_sqrt(math_approx_spline_vector_dot(v, v)) }

pub fn math_approx_spline_vector_normalize(v : MathapproxsplineVector) -> MathapproxsplineVector {
  let n = math_approx_spline_vector_norm(v)
  if n < 0.0000001 { v } else { math_approx_spline_vector_scale(v, 1.0 / n) }
}

pub fn math_approx_spline_vector_dist(a : MathapproxsplineVector, b : MathapproxsplineVector) -> Double {
  math_approx_spline_vector_norm(math_approx_spline_vector_sub(a, b))
}

pub fn math_approx_spline_vector_to_string(v : MathapproxsplineVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + math_approx_spline_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn math_approx_spline_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn math_approx_spline_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = math_approx_spline_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn math_approx_spline_std(data : Array[Double]) -> Double { math_approx_spline_sqrt(math_approx_spline_var(data)) }

pub fn math_approx_spline_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = math_approx_spline_mean(a); let mb = math_approx_spline_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn math_approx_spline_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = math_approx_spline_std(a); let sb = math_approx_spline_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { math_approx_spline_cov(a, b) / (sa * sb) }
}

pub fn math_approx_spline_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = math_approx_spline_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn math_approx_spline_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn math_approx_spline_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn math_approx_spline_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  math_approx_spline_sqrt(math_approx_spline_mse(pred, labels))
}

pub fn math_approx_spline_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + math_approx_spline_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn math_approx_spline_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = math_approx_spline_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn math_approx_spline_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn math_approx_spline_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn math_approx_spline_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = math_approx_spline_precision(pred, labels, pos); let r = math_approx_spline_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn math_approx_spline_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn math_approx_spline_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = math_approx_spline_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn math_approx_spline_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn math_approx_spline_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn math_approx_spline_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = math_approx_spline_gcd(a, b)
    (a / g) * b
  }
}

pub fn math_approx_spline_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn math_approx_spline_fibonacci(n : Int) -> Int {
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

pub fn math_approx_spline_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = math_approx_spline_min(data); let mx = math_approx_spline_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn math_approx_spline_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = math_approx_spline_mean(data); let sd = math_approx_spline_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn math_approx_spline_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn math_approx_spline_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn math_approx_spline_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn math_approx_spline_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn math_approx_spline_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn math_approx_spline_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn math_approx_spline_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn math_approx_spline_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn math_approx_spline_dbl(x : Double) -> String {
  let i = if x >= 0.0 { math_approx_spline_int(x) } else { -math_approx_spline_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { math_approx_spline_int(f * 1000000.0) } else { math_approx_spline_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn math_approx_spline_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn math_approx_spline_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct MathapproxsplineFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_spline_frame_make(size : Int) -> MathapproxsplineFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_spline_frame_len(s : MathapproxsplineFrame) -> Int { s.size }

pub fn math_approx_spline_frame_get(s : MathapproxsplineFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_spline_frame_set(s : MathapproxsplineFrame, i : Int, v : Double) -> MathapproxsplineFrame {
  let result = math_approx_spline_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_approx_spline_frame_sum(s : MathapproxsplineFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_approx_spline_frame_mean(s : MathapproxsplineFrame) -> Double {
  if s.size == 0 { 0.0 } else { math_approx_spline_frame_sum(s) / s.size.to_double() }
}

pub fn math_approx_spline_frame_scale(s : MathapproxsplineFrame, f : Double) -> MathapproxsplineFrame {
  let result = math_approx_spline_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_approx_spline_frame_add(a : MathapproxsplineFrame, b : MathapproxsplineFrame) -> MathapproxsplineFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_approx_spline_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_approx_spline_frame_copy(s : MathapproxsplineFrame) -> MathapproxsplineFrame {
  let result = math_approx_spline_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_approx_spline_frame_fill(s : MathapproxsplineFrame, v : Double) -> MathapproxsplineFrame {
  let result = math_approx_spline_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_approx_spline_frame_min(s : MathapproxsplineFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_spline_frame_max(s : MathapproxsplineFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_spline_frame_to_string(s : MathapproxsplineFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxsplineTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_spline_table_make(size : Int) -> MathapproxsplineTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_spline_table_len(s : MathapproxsplineTable) -> Int { s.size }

pub fn math_approx_spline_table_get(s : MathapproxsplineTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_spline_table_set(s : MathapproxsplineTable, i : Int, v : Double) -> MathapproxsplineTable {
  let result = math_approx_spline_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_approx_spline_table_sum(s : MathapproxsplineTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_approx_spline_table_mean(s : MathapproxsplineTable) -> Double {
  if s.size == 0 { 0.0 } else { math_approx_spline_table_sum(s) / s.size.to_double() }
}

pub fn math_approx_spline_table_scale(s : MathapproxsplineTable, f : Double) -> MathapproxsplineTable {
  let result = math_approx_spline_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_approx_spline_table_add(a : MathapproxsplineTable, b : MathapproxsplineTable) -> MathapproxsplineTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_approx_spline_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_approx_spline_table_copy(s : MathapproxsplineTable) -> MathapproxsplineTable {
  let result = math_approx_spline_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_approx_spline_table_fill(s : MathapproxsplineTable, v : Double) -> MathapproxsplineTable {
  let result = math_approx_spline_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_approx_spline_table_min(s : MathapproxsplineTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_spline_table_max(s : MathapproxsplineTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_spline_table_to_string(s : MathapproxsplineTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxsplineGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_spline_graphn_make(size : Int) -> MathapproxsplineGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_spline_graphn_len(s : MathapproxsplineGraphN) -> Int { s.size }

pub fn math_approx_spline_graphn_get(s : MathapproxsplineGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_spline_graphn_set(s : MathapproxsplineGraphN, i : Int, v : Double) -> MathapproxsplineGraphN {
  let result = math_approx_spline_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_approx_spline_graphn_sum(s : MathapproxsplineGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_approx_spline_graphn_mean(s : MathapproxsplineGraphN) -> Double {
  if s.size == 0 { 0.0 } else { math_approx_spline_graphn_sum(s) / s.size.to_double() }
}

pub fn math_approx_spline_graphn_scale(s : MathapproxsplineGraphN, f : Double) -> MathapproxsplineGraphN {
  let result = math_approx_spline_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_approx_spline_graphn_add(a : MathapproxsplineGraphN, b : MathapproxsplineGraphN) -> MathapproxsplineGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_approx_spline_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_approx_spline_graphn_copy(s : MathapproxsplineGraphN) -> MathapproxsplineGraphN {
  let result = math_approx_spline_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_approx_spline_graphn_fill(s : MathapproxsplineGraphN, v : Double) -> MathapproxsplineGraphN {
  let result = math_approx_spline_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_approx_spline_graphn_min(s : MathapproxsplineGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_spline_graphn_max(s : MathapproxsplineGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_spline_graphn_to_string(s : MathapproxsplineGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxsplineNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_spline_node_make(size : Int) -> MathapproxsplineNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_spline_node_len(s : MathapproxsplineNode) -> Int { s.size }

pub fn math_approx_spline_node_get(s : MathapproxsplineNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_spline_node_set(s : MathapproxsplineNode, i : Int, v : Double) -> MathapproxsplineNode {
  let result = math_approx_spline_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_approx_spline_node_sum(s : MathapproxsplineNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_approx_spline_node_mean(s : MathapproxsplineNode) -> Double {
  if s.size == 0 { 0.0 } else { math_approx_spline_node_sum(s) / s.size.to_double() }
}

pub fn math_approx_spline_node_scale(s : MathapproxsplineNode, f : Double) -> MathapproxsplineNode {
  let result = math_approx_spline_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_approx_spline_node_add(a : MathapproxsplineNode, b : MathapproxsplineNode) -> MathapproxsplineNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_approx_spline_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_approx_spline_node_copy(s : MathapproxsplineNode) -> MathapproxsplineNode {
  let result = math_approx_spline_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_approx_spline_node_fill(s : MathapproxsplineNode, v : Double) -> MathapproxsplineNode {
  let result = math_approx_spline_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_approx_spline_node_min(s : MathapproxsplineNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_spline_node_max(s : MathapproxsplineNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_spline_node_to_string(s : MathapproxsplineNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxsplineEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_spline_edge_make(size : Int) -> MathapproxsplineEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_spline_edge_len(s : MathapproxsplineEdge) -> Int { s.size }

pub fn math_approx_spline_edge_get(s : MathapproxsplineEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_spline_edge_set(s : MathapproxsplineEdge, i : Int, v : Double) -> MathapproxsplineEdge {
  let result = math_approx_spline_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_approx_spline_edge_sum(s : MathapproxsplineEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_approx_spline_edge_mean(s : MathapproxsplineEdge) -> Double {
  if s.size == 0 { 0.0 } else { math_approx_spline_edge_sum(s) / s.size.to_double() }
}

pub fn math_approx_spline_edge_scale(s : MathapproxsplineEdge, f : Double) -> MathapproxsplineEdge {
  let result = math_approx_spline_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_approx_spline_edge_add(a : MathapproxsplineEdge, b : MathapproxsplineEdge) -> MathapproxsplineEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_approx_spline_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_approx_spline_edge_copy(s : MathapproxsplineEdge) -> MathapproxsplineEdge {
  let result = math_approx_spline_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_approx_spline_edge_fill(s : MathapproxsplineEdge, v : Double) -> MathapproxsplineEdge {
  let result = math_approx_spline_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_approx_spline_edge_min(s : MathapproxsplineEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_spline_edge_max(s : MathapproxsplineEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_spline_edge_to_string(s : MathapproxsplineEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxsplinePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_spline_path_make(size : Int) -> MathapproxsplinePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_spline_path_len(s : MathapproxsplinePath) -> Int { s.size }

pub fn math_approx_spline_path_get(s : MathapproxsplinePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_spline_path_set(s : MathapproxsplinePath, i : Int, v : Double) -> MathapproxsplinePath {
  let result = math_approx_spline_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_approx_spline_path_sum(s : MathapproxsplinePath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_approx_spline_path_mean(s : MathapproxsplinePath) -> Double {
  if s.size == 0 { 0.0 } else { math_approx_spline_path_sum(s) / s.size.to_double() }
}

pub fn math_approx_spline_path_scale(s : MathapproxsplinePath, f : Double) -> MathapproxsplinePath {
  let result = math_approx_spline_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_approx_spline_path_add(a : MathapproxsplinePath, b : MathapproxsplinePath) -> MathapproxsplinePath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_approx_spline_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_approx_spline_path_copy(s : MathapproxsplinePath) -> MathapproxsplinePath {
  let result = math_approx_spline_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_approx_spline_path_fill(s : MathapproxsplinePath, v : Double) -> MathapproxsplinePath {
  let result = math_approx_spline_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_approx_spline_path_min(s : MathapproxsplinePath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_spline_path_max(s : MathapproxsplinePath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_spline_path_to_string(s : MathapproxsplinePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxsplineCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_spline_cluster_make(size : Int) -> MathapproxsplineCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_spline_cluster_len(s : MathapproxsplineCluster) -> Int { s.size }

pub fn math_approx_spline_cluster_get(s : MathapproxsplineCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_spline_cluster_set(s : MathapproxsplineCluster, i : Int, v : Double) -> MathapproxsplineCluster {
  let result = math_approx_spline_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_approx_spline_cluster_sum(s : MathapproxsplineCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_approx_spline_cluster_mean(s : MathapproxsplineCluster) -> Double {
  if s.size == 0 { 0.0 } else { math_approx_spline_cluster_sum(s) / s.size.to_double() }
}

pub fn math_approx_spline_cluster_scale(s : MathapproxsplineCluster, f : Double) -> MathapproxsplineCluster {
  let result = math_approx_spline_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_approx_spline_cluster_add(a : MathapproxsplineCluster, b : MathapproxsplineCluster) -> MathapproxsplineCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_approx_spline_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_approx_spline_cluster_copy(s : MathapproxsplineCluster) -> MathapproxsplineCluster {
  let result = math_approx_spline_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_approx_spline_cluster_fill(s : MathapproxsplineCluster, v : Double) -> MathapproxsplineCluster {
  let result = math_approx_spline_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_approx_spline_cluster_min(s : MathapproxsplineCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_spline_cluster_max(s : MathapproxsplineCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_spline_cluster_to_string(s : MathapproxsplineCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxsplineModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_spline_model_make(size : Int) -> MathapproxsplineModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_spline_model_len(s : MathapproxsplineModel) -> Int { s.size }

pub fn math_approx_spline_model_get(s : MathapproxsplineModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_spline_model_set(s : MathapproxsplineModel, i : Int, v : Double) -> MathapproxsplineModel {
  let result = math_approx_spline_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_approx_spline_model_sum(s : MathapproxsplineModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_approx_spline_model_mean(s : MathapproxsplineModel) -> Double {
  if s.size == 0 { 0.0 } else { math_approx_spline_model_sum(s) / s.size.to_double() }
}

pub fn math_approx_spline_model_scale(s : MathapproxsplineModel, f : Double) -> MathapproxsplineModel {
  let result = math_approx_spline_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_approx_spline_model_add(a : MathapproxsplineModel, b : MathapproxsplineModel) -> MathapproxsplineModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_approx_spline_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_approx_spline_model_copy(s : MathapproxsplineModel) -> MathapproxsplineModel {
  let result = math_approx_spline_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_approx_spline_model_fill(s : MathapproxsplineModel, v : Double) -> MathapproxsplineModel {
  let result = math_approx_spline_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_approx_spline_model_min(s : MathapproxsplineModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_spline_model_max(s : MathapproxsplineModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_spline_model_to_string(s : MathapproxsplineModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxsplineLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_spline_layer_make(size : Int) -> MathapproxsplineLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_spline_layer_len(s : MathapproxsplineLayer) -> Int { s.size }

pub fn math_approx_spline_layer_get(s : MathapproxsplineLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_spline_layer_set(s : MathapproxsplineLayer, i : Int, v : Double) -> MathapproxsplineLayer {
  let result = math_approx_spline_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_approx_spline_layer_sum(s : MathapproxsplineLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_approx_spline_layer_mean(s : MathapproxsplineLayer) -> Double {
  if s.size == 0 { 0.0 } else { math_approx_spline_layer_sum(s) / s.size.to_double() }
}

pub fn math_approx_spline_layer_scale(s : MathapproxsplineLayer, f : Double) -> MathapproxsplineLayer {
  let result = math_approx_spline_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_approx_spline_layer_add(a : MathapproxsplineLayer, b : MathapproxsplineLayer) -> MathapproxsplineLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_approx_spline_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_approx_spline_layer_copy(s : MathapproxsplineLayer) -> MathapproxsplineLayer {
  let result = math_approx_spline_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_approx_spline_layer_fill(s : MathapproxsplineLayer, v : Double) -> MathapproxsplineLayer {
  let result = math_approx_spline_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_approx_spline_layer_min(s : MathapproxsplineLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_spline_layer_max(s : MathapproxsplineLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_spline_layer_to_string(s : MathapproxsplineLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxsplineBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_spline_buffer_make(size : Int) -> MathapproxsplineBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_spline_buffer_len(s : MathapproxsplineBuffer) -> Int { s.size }

pub fn math_approx_spline_buffer_get(s : MathapproxsplineBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_spline_buffer_set(s : MathapproxsplineBuffer, i : Int, v : Double) -> MathapproxsplineBuffer {
  let result = math_approx_spline_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_approx_spline_buffer_sum(s : MathapproxsplineBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_approx_spline_buffer_mean(s : MathapproxsplineBuffer) -> Double {
  if s.size == 0 { 0.0 } else { math_approx_spline_buffer_sum(s) / s.size.to_double() }
}

pub fn math_approx_spline_buffer_scale(s : MathapproxsplineBuffer, f : Double) -> MathapproxsplineBuffer {
  let result = math_approx_spline_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_approx_spline_buffer_add(a : MathapproxsplineBuffer, b : MathapproxsplineBuffer) -> MathapproxsplineBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_approx_spline_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_approx_spline_buffer_copy(s : MathapproxsplineBuffer) -> MathapproxsplineBuffer {
  let result = math_approx_spline_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_approx_spline_buffer_fill(s : MathapproxsplineBuffer, v : Double) -> MathapproxsplineBuffer {
  let result = math_approx_spline_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_approx_spline_buffer_min(s : MathapproxsplineBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_spline_buffer_max(s : MathapproxsplineBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_spline_buffer_to_string(s : MathapproxsplineBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxsplineCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_spline_cursor_make(size : Int) -> MathapproxsplineCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_spline_cursor_len(s : MathapproxsplineCursor) -> Int { s.size }

pub fn math_approx_spline_cursor_get(s : MathapproxsplineCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_spline_cursor_set(s : MathapproxsplineCursor, i : Int, v : Double) -> MathapproxsplineCursor {
  let result = math_approx_spline_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_approx_spline_cursor_sum(s : MathapproxsplineCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_approx_spline_cursor_mean(s : MathapproxsplineCursor) -> Double {
  if s.size == 0 { 0.0 } else { math_approx_spline_cursor_sum(s) / s.size.to_double() }
}

pub fn math_approx_spline_cursor_scale(s : MathapproxsplineCursor, f : Double) -> MathapproxsplineCursor {
  let result = math_approx_spline_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_approx_spline_cursor_add(a : MathapproxsplineCursor, b : MathapproxsplineCursor) -> MathapproxsplineCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_approx_spline_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_approx_spline_cursor_copy(s : MathapproxsplineCursor) -> MathapproxsplineCursor {
  let result = math_approx_spline_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_approx_spline_cursor_fill(s : MathapproxsplineCursor, v : Double) -> MathapproxsplineCursor {
  let result = math_approx_spline_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_approx_spline_cursor_min(s : MathapproxsplineCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_spline_cursor_max(s : MathapproxsplineCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_spline_cursor_to_string(s : MathapproxsplineCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxsplineView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_spline_view_make(size : Int) -> MathapproxsplineView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_spline_view_len(s : MathapproxsplineView) -> Int { s.size }

pub fn math_approx_spline_view_get(s : MathapproxsplineView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_spline_view_set(s : MathapproxsplineView, i : Int, v : Double) -> MathapproxsplineView {
  let result = math_approx_spline_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_approx_spline_view_sum(s : MathapproxsplineView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_approx_spline_view_mean(s : MathapproxsplineView) -> Double {
  if s.size == 0 { 0.0 } else { math_approx_spline_view_sum(s) / s.size.to_double() }
}

pub fn math_approx_spline_view_scale(s : MathapproxsplineView, f : Double) -> MathapproxsplineView {
  let result = math_approx_spline_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_approx_spline_view_add(a : MathapproxsplineView, b : MathapproxsplineView) -> MathapproxsplineView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_approx_spline_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_approx_spline_view_copy(s : MathapproxsplineView) -> MathapproxsplineView {
  let result = math_approx_spline_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_approx_spline_view_fill(s : MathapproxsplineView, v : Double) -> MathapproxsplineView {
  let result = math_approx_spline_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_approx_spline_view_min(s : MathapproxsplineView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_spline_view_max(s : MathapproxsplineView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_spline_view_to_string(s : MathapproxsplineView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxsplineRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_spline_range_make(size : Int) -> MathapproxsplineRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_spline_range_len(s : MathapproxsplineRange) -> Int { s.size }

pub fn math_approx_spline_range_get(s : MathapproxsplineRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_spline_range_set(s : MathapproxsplineRange, i : Int, v : Double) -> MathapproxsplineRange {
  let result = math_approx_spline_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_approx_spline_range_sum(s : MathapproxsplineRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_approx_spline_range_mean(s : MathapproxsplineRange) -> Double {
  if s.size == 0 { 0.0 } else { math_approx_spline_range_sum(s) / s.size.to_double() }
}

pub fn math_approx_spline_range_scale(s : MathapproxsplineRange, f : Double) -> MathapproxsplineRange {
  let result = math_approx_spline_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_approx_spline_range_add(a : MathapproxsplineRange, b : MathapproxsplineRange) -> MathapproxsplineRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_approx_spline_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_approx_spline_range_copy(s : MathapproxsplineRange) -> MathapproxsplineRange {
  let result = math_approx_spline_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_approx_spline_range_fill(s : MathapproxsplineRange, v : Double) -> MathapproxsplineRange {
  let result = math_approx_spline_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_approx_spline_range_min(s : MathapproxsplineRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_spline_range_max(s : MathapproxsplineRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_spline_range_to_string(s : MathapproxsplineRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxsplineSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_spline_slice_make(size : Int) -> MathapproxsplineSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_spline_slice_len(s : MathapproxsplineSlice) -> Int { s.size }

pub fn math_approx_spline_slice_get(s : MathapproxsplineSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_spline_slice_set(s : MathapproxsplineSlice, i : Int, v : Double) -> MathapproxsplineSlice {
  let result = math_approx_spline_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_approx_spline_slice_sum(s : MathapproxsplineSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_approx_spline_slice_mean(s : MathapproxsplineSlice) -> Double {
  if s.size == 0 { 0.0 } else { math_approx_spline_slice_sum(s) / s.size.to_double() }
}

pub fn math_approx_spline_slice_scale(s : MathapproxsplineSlice, f : Double) -> MathapproxsplineSlice {
  let result = math_approx_spline_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_approx_spline_slice_add(a : MathapproxsplineSlice, b : MathapproxsplineSlice) -> MathapproxsplineSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_approx_spline_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_approx_spline_slice_copy(s : MathapproxsplineSlice) -> MathapproxsplineSlice {
  let result = math_approx_spline_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_approx_spline_slice_fill(s : MathapproxsplineSlice, v : Double) -> MathapproxsplineSlice {
  let result = math_approx_spline_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_approx_spline_slice_min(s : MathapproxsplineSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_spline_slice_max(s : MathapproxsplineSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_spline_slice_to_string(s : MathapproxsplineSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn math_approx_spline_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_approx_spline_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_approx_spline_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_approx_spline_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_approx_spline_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_approx_spline_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_approx_spline_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_approx_spline_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_approx_spline_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_approx_spline_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_approx_spline_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_approx_spline_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_approx_spline_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_approx_spline_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_approx_spline_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_approx_spline_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_approx_spline_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_approx_spline_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_approx_spline_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_approx_spline_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_approx_spline_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_approx_spline_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_approx_spline_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_approx_spline_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_approx_spline_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

