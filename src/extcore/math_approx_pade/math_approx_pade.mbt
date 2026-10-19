///===
/// extcore/math_approx_pade

pub(all) struct MathapproxpadePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn math_approx_pade_make_point(x : Double, y : Double) -> MathapproxpadePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn math_approx_pade_make_point3(x : Double, y : Double, z : Double) -> MathapproxpadePoint {
  { x, y, z, label: 0 }
}

pub fn math_approx_pade_point_x(pt : MathapproxpadePoint) -> Double { pt.x }

pub fn math_approx_pade_point_y(pt : MathapproxpadePoint) -> Double { pt.y }

pub fn math_approx_pade_point_z(pt : MathapproxpadePoint) -> Double { pt.z }

pub fn math_approx_pade_point_label(pt : MathapproxpadePoint) -> Int { pt.label }

pub fn math_approx_pade_point_dist(a : MathapproxpadePoint, b : MathapproxpadePoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  math_approx_pade_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn math_approx_pade_point_add(a : MathapproxpadePoint, b : MathapproxpadePoint) -> MathapproxpadePoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn math_approx_pade_point_sub(a : MathapproxpadePoint, b : MathapproxpadePoint) -> MathapproxpadePoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn math_approx_pade_point_scale(pt : MathapproxpadePoint, s : Double) -> MathapproxpadePoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn math_approx_pade_point_dot(a : MathapproxpadePoint, b : MathapproxpadePoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn math_approx_pade_point_cross(a : MathapproxpadePoint, b : MathapproxpadePoint) -> MathapproxpadePoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn math_approx_pade_point_norm(pt : MathapproxpadePoint) -> Double {
  math_approx_pade_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn math_approx_pade_point_normalize(pt : MathapproxpadePoint) -> MathapproxpadePoint {
  let n = math_approx_pade_point_norm(pt)
  if n < 0.0000001 { pt } else { math_approx_pade_point_scale(pt, 1.0 / n) }
}

pub fn math_approx_pade_point_negate(pt : MathapproxpadePoint) -> MathapproxpadePoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn math_approx_pade_point_mid(a : MathapproxpadePoint, b : MathapproxpadePoint) -> MathapproxpadePoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn math_approx_pade_point_lerp(a : MathapproxpadePoint, b : MathapproxpadePoint, t : Double) -> MathapproxpadePoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn math_approx_pade_point_to_string(pt : MathapproxpadePoint) -> String {
  "(" + math_approx_pade_dbl(pt.x) + ", " + math_approx_pade_dbl(pt.y) + ", " + math_approx_pade_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct MathapproxpadeSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn math_approx_pade_make_series(vals : Array[Double], name : String) -> MathapproxpadeSeries {
  { vals, name, meta: 0 }
}

pub fn math_approx_pade_series_len(s : MathapproxpadeSeries) -> Int { s.vals.length() }

pub fn math_approx_pade_series_sum(s : MathapproxpadeSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn math_approx_pade_series_mean(s : MathapproxpadeSeries) -> Double {
  let n = math_approx_pade_series_len(s)
  if n == 0 { 0.0 } else { math_approx_pade_series_sum(s) / n.to_double() }
}

pub fn math_approx_pade_series_min(s : MathapproxpadeSeries) -> Double {
  let n = math_approx_pade_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn math_approx_pade_series_max(s : MathapproxpadeSeries) -> Double {
  let n = math_approx_pade_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn math_approx_pade_series_range(s : MathapproxpadeSeries) -> Double {
  math_approx_pade_series_max(s) - math_approx_pade_series_min(s)
}

pub fn math_approx_pade_series_var(s : MathapproxpadeSeries) -> Double {
  let n = math_approx_pade_series_len(s)
  if n == 0 { 0.0 } else {
    let m = math_approx_pade_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn math_approx_pade_series_std(s : MathapproxpadeSeries) -> Double { math_approx_pade_sqrt(math_approx_pade_series_var(s)) }

pub fn math_approx_pade_series_median(s : MathapproxpadeSeries) -> Double {
  let n = math_approx_pade_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = math_approx_pade_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn math_approx_pade_series_scale(s : MathapproxpadeSeries, f : Double) -> MathapproxpadeSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = math_approx_pade_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn math_approx_pade_series_add(a : MathapproxpadeSeries, b : MathapproxpadeSeries) -> MathapproxpadeSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = math_approx_pade_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn math_approx_pade_series_sub(a : MathapproxpadeSeries, b : MathapproxpadeSeries) -> MathapproxpadeSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = math_approx_pade_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn math_approx_pade_series_normalize(s : MathapproxpadeSeries) -> MathapproxpadeSeries {
  let mn = math_approx_pade_series_min(s)
  let mx = math_approx_pade_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = math_approx_pade_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn math_approx_pade_series_cumsum(s : MathapproxpadeSeries) -> MathapproxpadeSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = math_approx_pade_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn math_approx_pade_series_to_string(s : MathapproxpadeSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + math_approx_pade_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MathapproxpadeMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn math_approx_pade_make_matrix(rows : Int, cols : Int, val : Double) -> MathapproxpadeMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn math_approx_pade_matrix_identity(n : Int) -> MathapproxpadeMatrix {
  let m = math_approx_pade_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn math_approx_pade_matrix_get(m : MathapproxpadeMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn math_approx_pade_matrix_transpose(m : MathapproxpadeMatrix) -> MathapproxpadeMatrix {
  let result = math_approx_pade_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn math_approx_pade_matrix_add(a : MathapproxpadeMatrix, b : MathapproxpadeMatrix) -> MathapproxpadeMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = math_approx_pade_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn math_approx_pade_matrix_scale(m : MathapproxpadeMatrix, s : Double) -> MathapproxpadeMatrix {
  let result = math_approx_pade_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn math_approx_pade_matrix_multiply(a : MathapproxpadeMatrix, b : MathapproxpadeMatrix) -> MathapproxpadeMatrix {
  if a.cols != b.rows { return math_approx_pade_make_matrix(a.rows, b.cols, 0.0) }
  let result = math_approx_pade_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn math_approx_pade_matrix_trace(m : MathapproxpadeMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn math_approx_pade_matrix_det(m : MathapproxpadeMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn math_approx_pade_matrix_norm(m : MathapproxpadeMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  math_approx_pade_sqrt(sum)
}

pub fn math_approx_pade_matrix_to_string(m : MathapproxpadeMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + math_approx_pade_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct MathapproxpadeVector {
  comps : Array[Double]
  dim : Int
}

pub fn math_approx_pade_make_vector(comps : Array[Double]) -> MathapproxpadeVector {
  { comps, dim: comps.length() }
}

pub fn math_approx_pade_vector_zero(dim : Int) -> MathapproxpadeVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn math_approx_pade_vector_add(a : MathapproxpadeVector, b : MathapproxpadeVector) -> MathapproxpadeVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = math_approx_pade_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn math_approx_pade_vector_sub(a : MathapproxpadeVector, b : MathapproxpadeVector) -> MathapproxpadeVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = math_approx_pade_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn math_approx_pade_vector_scale(v : MathapproxpadeVector, s : Double) -> MathapproxpadeVector {
  let mut result = []
  for i in 0..<v.dim { result = math_approx_pade_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn math_approx_pade_vector_dot(a : MathapproxpadeVector, b : MathapproxpadeVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn math_approx_pade_vector_norm(v : MathapproxpadeVector) -> Double { math_approx_pade_sqrt(math_approx_pade_vector_dot(v, v)) }

pub fn math_approx_pade_vector_normalize(v : MathapproxpadeVector) -> MathapproxpadeVector {
  let n = math_approx_pade_vector_norm(v)
  if n < 0.0000001 { v } else { math_approx_pade_vector_scale(v, 1.0 / n) }
}

pub fn math_approx_pade_vector_dist(a : MathapproxpadeVector, b : MathapproxpadeVector) -> Double {
  math_approx_pade_vector_norm(math_approx_pade_vector_sub(a, b))
}

pub fn math_approx_pade_vector_to_string(v : MathapproxpadeVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + math_approx_pade_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn math_approx_pade_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn math_approx_pade_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = math_approx_pade_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn math_approx_pade_std(data : Array[Double]) -> Double { math_approx_pade_sqrt(math_approx_pade_var(data)) }

pub fn math_approx_pade_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = math_approx_pade_mean(a); let mb = math_approx_pade_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn math_approx_pade_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = math_approx_pade_std(a); let sb = math_approx_pade_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { math_approx_pade_cov(a, b) / (sa * sb) }
}

pub fn math_approx_pade_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = math_approx_pade_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn math_approx_pade_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn math_approx_pade_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn math_approx_pade_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  math_approx_pade_sqrt(math_approx_pade_mse(pred, labels))
}

pub fn math_approx_pade_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + math_approx_pade_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn math_approx_pade_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = math_approx_pade_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn math_approx_pade_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn math_approx_pade_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn math_approx_pade_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = math_approx_pade_precision(pred, labels, pos); let r = math_approx_pade_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn math_approx_pade_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn math_approx_pade_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = math_approx_pade_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn math_approx_pade_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn math_approx_pade_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn math_approx_pade_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = math_approx_pade_gcd(a, b)
    (a / g) * b
  }
}

pub fn math_approx_pade_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn math_approx_pade_fibonacci(n : Int) -> Int {
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

pub fn math_approx_pade_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = math_approx_pade_min(data); let mx = math_approx_pade_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn math_approx_pade_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = math_approx_pade_mean(data); let sd = math_approx_pade_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn math_approx_pade_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn math_approx_pade_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn math_approx_pade_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn math_approx_pade_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn math_approx_pade_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn math_approx_pade_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn math_approx_pade_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn math_approx_pade_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn math_approx_pade_dbl(x : Double) -> String {
  let i = if x >= 0.0 { math_approx_pade_int(x) } else { -math_approx_pade_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { math_approx_pade_int(f * 1000000.0) } else { math_approx_pade_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn math_approx_pade_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn math_approx_pade_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct MathapproxpadeFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_pade_frame_make(size : Int) -> MathapproxpadeFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_pade_frame_len(s : MathapproxpadeFrame) -> Int { s.size }

pub fn math_approx_pade_frame_get(s : MathapproxpadeFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_pade_frame_set(s : MathapproxpadeFrame, i : Int, v : Double) -> MathapproxpadeFrame {
  let result = math_approx_pade_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_approx_pade_frame_sum(s : MathapproxpadeFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_approx_pade_frame_mean(s : MathapproxpadeFrame) -> Double {
  if s.size == 0 { 0.0 } else { math_approx_pade_frame_sum(s) / s.size.to_double() }
}

pub fn math_approx_pade_frame_scale(s : MathapproxpadeFrame, f : Double) -> MathapproxpadeFrame {
  let result = math_approx_pade_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_approx_pade_frame_add(a : MathapproxpadeFrame, b : MathapproxpadeFrame) -> MathapproxpadeFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_approx_pade_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_approx_pade_frame_copy(s : MathapproxpadeFrame) -> MathapproxpadeFrame {
  let result = math_approx_pade_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_approx_pade_frame_fill(s : MathapproxpadeFrame, v : Double) -> MathapproxpadeFrame {
  let result = math_approx_pade_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_approx_pade_frame_min(s : MathapproxpadeFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_pade_frame_max(s : MathapproxpadeFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_pade_frame_to_string(s : MathapproxpadeFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxpadeTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_pade_table_make(size : Int) -> MathapproxpadeTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_pade_table_len(s : MathapproxpadeTable) -> Int { s.size }

pub fn math_approx_pade_table_get(s : MathapproxpadeTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_pade_table_set(s : MathapproxpadeTable, i : Int, v : Double) -> MathapproxpadeTable {
  let result = math_approx_pade_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_approx_pade_table_sum(s : MathapproxpadeTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_approx_pade_table_mean(s : MathapproxpadeTable) -> Double {
  if s.size == 0 { 0.0 } else { math_approx_pade_table_sum(s) / s.size.to_double() }
}

pub fn math_approx_pade_table_scale(s : MathapproxpadeTable, f : Double) -> MathapproxpadeTable {
  let result = math_approx_pade_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_approx_pade_table_add(a : MathapproxpadeTable, b : MathapproxpadeTable) -> MathapproxpadeTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_approx_pade_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_approx_pade_table_copy(s : MathapproxpadeTable) -> MathapproxpadeTable {
  let result = math_approx_pade_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_approx_pade_table_fill(s : MathapproxpadeTable, v : Double) -> MathapproxpadeTable {
  let result = math_approx_pade_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_approx_pade_table_min(s : MathapproxpadeTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_pade_table_max(s : MathapproxpadeTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_pade_table_to_string(s : MathapproxpadeTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxpadeGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_pade_graphn_make(size : Int) -> MathapproxpadeGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_pade_graphn_len(s : MathapproxpadeGraphN) -> Int { s.size }

pub fn math_approx_pade_graphn_get(s : MathapproxpadeGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_pade_graphn_set(s : MathapproxpadeGraphN, i : Int, v : Double) -> MathapproxpadeGraphN {
  let result = math_approx_pade_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_approx_pade_graphn_sum(s : MathapproxpadeGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_approx_pade_graphn_mean(s : MathapproxpadeGraphN) -> Double {
  if s.size == 0 { 0.0 } else { math_approx_pade_graphn_sum(s) / s.size.to_double() }
}

pub fn math_approx_pade_graphn_scale(s : MathapproxpadeGraphN, f : Double) -> MathapproxpadeGraphN {
  let result = math_approx_pade_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_approx_pade_graphn_add(a : MathapproxpadeGraphN, b : MathapproxpadeGraphN) -> MathapproxpadeGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_approx_pade_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_approx_pade_graphn_copy(s : MathapproxpadeGraphN) -> MathapproxpadeGraphN {
  let result = math_approx_pade_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_approx_pade_graphn_fill(s : MathapproxpadeGraphN, v : Double) -> MathapproxpadeGraphN {
  let result = math_approx_pade_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_approx_pade_graphn_min(s : MathapproxpadeGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_pade_graphn_max(s : MathapproxpadeGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_pade_graphn_to_string(s : MathapproxpadeGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxpadeNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_pade_node_make(size : Int) -> MathapproxpadeNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_pade_node_len(s : MathapproxpadeNode) -> Int { s.size }

pub fn math_approx_pade_node_get(s : MathapproxpadeNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_pade_node_set(s : MathapproxpadeNode, i : Int, v : Double) -> MathapproxpadeNode {
  let result = math_approx_pade_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_approx_pade_node_sum(s : MathapproxpadeNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_approx_pade_node_mean(s : MathapproxpadeNode) -> Double {
  if s.size == 0 { 0.0 } else { math_approx_pade_node_sum(s) / s.size.to_double() }
}

pub fn math_approx_pade_node_scale(s : MathapproxpadeNode, f : Double) -> MathapproxpadeNode {
  let result = math_approx_pade_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_approx_pade_node_add(a : MathapproxpadeNode, b : MathapproxpadeNode) -> MathapproxpadeNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_approx_pade_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_approx_pade_node_copy(s : MathapproxpadeNode) -> MathapproxpadeNode {
  let result = math_approx_pade_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_approx_pade_node_fill(s : MathapproxpadeNode, v : Double) -> MathapproxpadeNode {
  let result = math_approx_pade_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_approx_pade_node_min(s : MathapproxpadeNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_pade_node_max(s : MathapproxpadeNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_pade_node_to_string(s : MathapproxpadeNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxpadeEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_pade_edge_make(size : Int) -> MathapproxpadeEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_pade_edge_len(s : MathapproxpadeEdge) -> Int { s.size }

pub fn math_approx_pade_edge_get(s : MathapproxpadeEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_pade_edge_set(s : MathapproxpadeEdge, i : Int, v : Double) -> MathapproxpadeEdge {
  let result = math_approx_pade_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_approx_pade_edge_sum(s : MathapproxpadeEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_approx_pade_edge_mean(s : MathapproxpadeEdge) -> Double {
  if s.size == 0 { 0.0 } else { math_approx_pade_edge_sum(s) / s.size.to_double() }
}

pub fn math_approx_pade_edge_scale(s : MathapproxpadeEdge, f : Double) -> MathapproxpadeEdge {
  let result = math_approx_pade_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_approx_pade_edge_add(a : MathapproxpadeEdge, b : MathapproxpadeEdge) -> MathapproxpadeEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_approx_pade_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_approx_pade_edge_copy(s : MathapproxpadeEdge) -> MathapproxpadeEdge {
  let result = math_approx_pade_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_approx_pade_edge_fill(s : MathapproxpadeEdge, v : Double) -> MathapproxpadeEdge {
  let result = math_approx_pade_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_approx_pade_edge_min(s : MathapproxpadeEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_pade_edge_max(s : MathapproxpadeEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_pade_edge_to_string(s : MathapproxpadeEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxpadePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_pade_path_make(size : Int) -> MathapproxpadePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_pade_path_len(s : MathapproxpadePath) -> Int { s.size }

pub fn math_approx_pade_path_get(s : MathapproxpadePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_pade_path_set(s : MathapproxpadePath, i : Int, v : Double) -> MathapproxpadePath {
  let result = math_approx_pade_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_approx_pade_path_sum(s : MathapproxpadePath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_approx_pade_path_mean(s : MathapproxpadePath) -> Double {
  if s.size == 0 { 0.0 } else { math_approx_pade_path_sum(s) / s.size.to_double() }
}

pub fn math_approx_pade_path_scale(s : MathapproxpadePath, f : Double) -> MathapproxpadePath {
  let result = math_approx_pade_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_approx_pade_path_add(a : MathapproxpadePath, b : MathapproxpadePath) -> MathapproxpadePath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_approx_pade_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_approx_pade_path_copy(s : MathapproxpadePath) -> MathapproxpadePath {
  let result = math_approx_pade_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_approx_pade_path_fill(s : MathapproxpadePath, v : Double) -> MathapproxpadePath {
  let result = math_approx_pade_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_approx_pade_path_min(s : MathapproxpadePath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_pade_path_max(s : MathapproxpadePath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_pade_path_to_string(s : MathapproxpadePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxpadeCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_pade_cluster_make(size : Int) -> MathapproxpadeCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_pade_cluster_len(s : MathapproxpadeCluster) -> Int { s.size }

pub fn math_approx_pade_cluster_get(s : MathapproxpadeCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_pade_cluster_set(s : MathapproxpadeCluster, i : Int, v : Double) -> MathapproxpadeCluster {
  let result = math_approx_pade_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_approx_pade_cluster_sum(s : MathapproxpadeCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_approx_pade_cluster_mean(s : MathapproxpadeCluster) -> Double {
  if s.size == 0 { 0.0 } else { math_approx_pade_cluster_sum(s) / s.size.to_double() }
}

pub fn math_approx_pade_cluster_scale(s : MathapproxpadeCluster, f : Double) -> MathapproxpadeCluster {
  let result = math_approx_pade_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_approx_pade_cluster_add(a : MathapproxpadeCluster, b : MathapproxpadeCluster) -> MathapproxpadeCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_approx_pade_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_approx_pade_cluster_copy(s : MathapproxpadeCluster) -> MathapproxpadeCluster {
  let result = math_approx_pade_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_approx_pade_cluster_fill(s : MathapproxpadeCluster, v : Double) -> MathapproxpadeCluster {
  let result = math_approx_pade_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_approx_pade_cluster_min(s : MathapproxpadeCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_pade_cluster_max(s : MathapproxpadeCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_pade_cluster_to_string(s : MathapproxpadeCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxpadeModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_pade_model_make(size : Int) -> MathapproxpadeModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_pade_model_len(s : MathapproxpadeModel) -> Int { s.size }

pub fn math_approx_pade_model_get(s : MathapproxpadeModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_pade_model_set(s : MathapproxpadeModel, i : Int, v : Double) -> MathapproxpadeModel {
  let result = math_approx_pade_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_approx_pade_model_sum(s : MathapproxpadeModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_approx_pade_model_mean(s : MathapproxpadeModel) -> Double {
  if s.size == 0 { 0.0 } else { math_approx_pade_model_sum(s) / s.size.to_double() }
}

pub fn math_approx_pade_model_scale(s : MathapproxpadeModel, f : Double) -> MathapproxpadeModel {
  let result = math_approx_pade_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_approx_pade_model_add(a : MathapproxpadeModel, b : MathapproxpadeModel) -> MathapproxpadeModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_approx_pade_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_approx_pade_model_copy(s : MathapproxpadeModel) -> MathapproxpadeModel {
  let result = math_approx_pade_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_approx_pade_model_fill(s : MathapproxpadeModel, v : Double) -> MathapproxpadeModel {
  let result = math_approx_pade_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_approx_pade_model_min(s : MathapproxpadeModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_pade_model_max(s : MathapproxpadeModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_pade_model_to_string(s : MathapproxpadeModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxpadeLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_pade_layer_make(size : Int) -> MathapproxpadeLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_pade_layer_len(s : MathapproxpadeLayer) -> Int { s.size }

pub fn math_approx_pade_layer_get(s : MathapproxpadeLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_pade_layer_set(s : MathapproxpadeLayer, i : Int, v : Double) -> MathapproxpadeLayer {
  let result = math_approx_pade_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_approx_pade_layer_sum(s : MathapproxpadeLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_approx_pade_layer_mean(s : MathapproxpadeLayer) -> Double {
  if s.size == 0 { 0.0 } else { math_approx_pade_layer_sum(s) / s.size.to_double() }
}

pub fn math_approx_pade_layer_scale(s : MathapproxpadeLayer, f : Double) -> MathapproxpadeLayer {
  let result = math_approx_pade_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_approx_pade_layer_add(a : MathapproxpadeLayer, b : MathapproxpadeLayer) -> MathapproxpadeLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_approx_pade_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_approx_pade_layer_copy(s : MathapproxpadeLayer) -> MathapproxpadeLayer {
  let result = math_approx_pade_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_approx_pade_layer_fill(s : MathapproxpadeLayer, v : Double) -> MathapproxpadeLayer {
  let result = math_approx_pade_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_approx_pade_layer_min(s : MathapproxpadeLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_pade_layer_max(s : MathapproxpadeLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_pade_layer_to_string(s : MathapproxpadeLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxpadeBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_pade_buffer_make(size : Int) -> MathapproxpadeBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_pade_buffer_len(s : MathapproxpadeBuffer) -> Int { s.size }

pub fn math_approx_pade_buffer_get(s : MathapproxpadeBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_pade_buffer_set(s : MathapproxpadeBuffer, i : Int, v : Double) -> MathapproxpadeBuffer {
  let result = math_approx_pade_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_approx_pade_buffer_sum(s : MathapproxpadeBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_approx_pade_buffer_mean(s : MathapproxpadeBuffer) -> Double {
  if s.size == 0 { 0.0 } else { math_approx_pade_buffer_sum(s) / s.size.to_double() }
}

pub fn math_approx_pade_buffer_scale(s : MathapproxpadeBuffer, f : Double) -> MathapproxpadeBuffer {
  let result = math_approx_pade_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_approx_pade_buffer_add(a : MathapproxpadeBuffer, b : MathapproxpadeBuffer) -> MathapproxpadeBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_approx_pade_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_approx_pade_buffer_copy(s : MathapproxpadeBuffer) -> MathapproxpadeBuffer {
  let result = math_approx_pade_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_approx_pade_buffer_fill(s : MathapproxpadeBuffer, v : Double) -> MathapproxpadeBuffer {
  let result = math_approx_pade_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_approx_pade_buffer_min(s : MathapproxpadeBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_pade_buffer_max(s : MathapproxpadeBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_pade_buffer_to_string(s : MathapproxpadeBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxpadeCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_pade_cursor_make(size : Int) -> MathapproxpadeCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_pade_cursor_len(s : MathapproxpadeCursor) -> Int { s.size }

pub fn math_approx_pade_cursor_get(s : MathapproxpadeCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_pade_cursor_set(s : MathapproxpadeCursor, i : Int, v : Double) -> MathapproxpadeCursor {
  let result = math_approx_pade_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_approx_pade_cursor_sum(s : MathapproxpadeCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_approx_pade_cursor_mean(s : MathapproxpadeCursor) -> Double {
  if s.size == 0 { 0.0 } else { math_approx_pade_cursor_sum(s) / s.size.to_double() }
}

pub fn math_approx_pade_cursor_scale(s : MathapproxpadeCursor, f : Double) -> MathapproxpadeCursor {
  let result = math_approx_pade_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_approx_pade_cursor_add(a : MathapproxpadeCursor, b : MathapproxpadeCursor) -> MathapproxpadeCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_approx_pade_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_approx_pade_cursor_copy(s : MathapproxpadeCursor) -> MathapproxpadeCursor {
  let result = math_approx_pade_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_approx_pade_cursor_fill(s : MathapproxpadeCursor, v : Double) -> MathapproxpadeCursor {
  let result = math_approx_pade_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_approx_pade_cursor_min(s : MathapproxpadeCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_pade_cursor_max(s : MathapproxpadeCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_pade_cursor_to_string(s : MathapproxpadeCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxpadeView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_pade_view_make(size : Int) -> MathapproxpadeView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_pade_view_len(s : MathapproxpadeView) -> Int { s.size }

pub fn math_approx_pade_view_get(s : MathapproxpadeView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_pade_view_set(s : MathapproxpadeView, i : Int, v : Double) -> MathapproxpadeView {
  let result = math_approx_pade_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_approx_pade_view_sum(s : MathapproxpadeView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_approx_pade_view_mean(s : MathapproxpadeView) -> Double {
  if s.size == 0 { 0.0 } else { math_approx_pade_view_sum(s) / s.size.to_double() }
}

pub fn math_approx_pade_view_scale(s : MathapproxpadeView, f : Double) -> MathapproxpadeView {
  let result = math_approx_pade_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_approx_pade_view_add(a : MathapproxpadeView, b : MathapproxpadeView) -> MathapproxpadeView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_approx_pade_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_approx_pade_view_copy(s : MathapproxpadeView) -> MathapproxpadeView {
  let result = math_approx_pade_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_approx_pade_view_fill(s : MathapproxpadeView, v : Double) -> MathapproxpadeView {
  let result = math_approx_pade_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_approx_pade_view_min(s : MathapproxpadeView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_pade_view_max(s : MathapproxpadeView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_pade_view_to_string(s : MathapproxpadeView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxpadeRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_pade_range_make(size : Int) -> MathapproxpadeRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_pade_range_len(s : MathapproxpadeRange) -> Int { s.size }

pub fn math_approx_pade_range_get(s : MathapproxpadeRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_pade_range_set(s : MathapproxpadeRange, i : Int, v : Double) -> MathapproxpadeRange {
  let result = math_approx_pade_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_approx_pade_range_sum(s : MathapproxpadeRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_approx_pade_range_mean(s : MathapproxpadeRange) -> Double {
  if s.size == 0 { 0.0 } else { math_approx_pade_range_sum(s) / s.size.to_double() }
}

pub fn math_approx_pade_range_scale(s : MathapproxpadeRange, f : Double) -> MathapproxpadeRange {
  let result = math_approx_pade_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_approx_pade_range_add(a : MathapproxpadeRange, b : MathapproxpadeRange) -> MathapproxpadeRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_approx_pade_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_approx_pade_range_copy(s : MathapproxpadeRange) -> MathapproxpadeRange {
  let result = math_approx_pade_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_approx_pade_range_fill(s : MathapproxpadeRange, v : Double) -> MathapproxpadeRange {
  let result = math_approx_pade_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_approx_pade_range_min(s : MathapproxpadeRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_pade_range_max(s : MathapproxpadeRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_pade_range_to_string(s : MathapproxpadeRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxpadeSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_pade_slice_make(size : Int) -> MathapproxpadeSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_pade_slice_len(s : MathapproxpadeSlice) -> Int { s.size }

pub fn math_approx_pade_slice_get(s : MathapproxpadeSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_pade_slice_set(s : MathapproxpadeSlice, i : Int, v : Double) -> MathapproxpadeSlice {
  let result = math_approx_pade_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_approx_pade_slice_sum(s : MathapproxpadeSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_approx_pade_slice_mean(s : MathapproxpadeSlice) -> Double {
  if s.size == 0 { 0.0 } else { math_approx_pade_slice_sum(s) / s.size.to_double() }
}

pub fn math_approx_pade_slice_scale(s : MathapproxpadeSlice, f : Double) -> MathapproxpadeSlice {
  let result = math_approx_pade_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_approx_pade_slice_add(a : MathapproxpadeSlice, b : MathapproxpadeSlice) -> MathapproxpadeSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_approx_pade_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_approx_pade_slice_copy(s : MathapproxpadeSlice) -> MathapproxpadeSlice {
  let result = math_approx_pade_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_approx_pade_slice_fill(s : MathapproxpadeSlice, v : Double) -> MathapproxpadeSlice {
  let result = math_approx_pade_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_approx_pade_slice_min(s : MathapproxpadeSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_pade_slice_max(s : MathapproxpadeSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_pade_slice_to_string(s : MathapproxpadeSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn math_approx_pade_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_approx_pade_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_approx_pade_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_approx_pade_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_approx_pade_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_approx_pade_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_approx_pade_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_approx_pade_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_approx_pade_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_approx_pade_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_approx_pade_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_approx_pade_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_approx_pade_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_approx_pade_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_approx_pade_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_approx_pade_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_approx_pade_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_approx_pade_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_approx_pade_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_approx_pade_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_approx_pade_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_approx_pade_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_approx_pade_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_approx_pade_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_approx_pade_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

