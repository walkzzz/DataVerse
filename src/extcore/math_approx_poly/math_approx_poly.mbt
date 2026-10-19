///===
/// extcore/math_approx_poly

pub(all) struct MathapproxpolyPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn math_approx_poly_make_point(x : Double, y : Double) -> MathapproxpolyPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn math_approx_poly_make_point3(x : Double, y : Double, z : Double) -> MathapproxpolyPoint {
  { x, y, z, label: 0 }
}

pub fn math_approx_poly_point_x(pt : MathapproxpolyPoint) -> Double { pt.x }

pub fn math_approx_poly_point_y(pt : MathapproxpolyPoint) -> Double { pt.y }

pub fn math_approx_poly_point_z(pt : MathapproxpolyPoint) -> Double { pt.z }

pub fn math_approx_poly_point_label(pt : MathapproxpolyPoint) -> Int { pt.label }

pub fn math_approx_poly_point_dist(a : MathapproxpolyPoint, b : MathapproxpolyPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  math_approx_poly_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn math_approx_poly_point_add(a : MathapproxpolyPoint, b : MathapproxpolyPoint) -> MathapproxpolyPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn math_approx_poly_point_sub(a : MathapproxpolyPoint, b : MathapproxpolyPoint) -> MathapproxpolyPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn math_approx_poly_point_scale(pt : MathapproxpolyPoint, s : Double) -> MathapproxpolyPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn math_approx_poly_point_dot(a : MathapproxpolyPoint, b : MathapproxpolyPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn math_approx_poly_point_cross(a : MathapproxpolyPoint, b : MathapproxpolyPoint) -> MathapproxpolyPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn math_approx_poly_point_norm(pt : MathapproxpolyPoint) -> Double {
  math_approx_poly_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn math_approx_poly_point_normalize(pt : MathapproxpolyPoint) -> MathapproxpolyPoint {
  let n = math_approx_poly_point_norm(pt)
  if n < 0.0000001 { pt } else { math_approx_poly_point_scale(pt, 1.0 / n) }
}

pub fn math_approx_poly_point_negate(pt : MathapproxpolyPoint) -> MathapproxpolyPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn math_approx_poly_point_mid(a : MathapproxpolyPoint, b : MathapproxpolyPoint) -> MathapproxpolyPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn math_approx_poly_point_lerp(a : MathapproxpolyPoint, b : MathapproxpolyPoint, t : Double) -> MathapproxpolyPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn math_approx_poly_point_to_string(pt : MathapproxpolyPoint) -> String {
  "(" + math_approx_poly_dbl(pt.x) + ", " + math_approx_poly_dbl(pt.y) + ", " + math_approx_poly_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct MathapproxpolySeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn math_approx_poly_make_series(vals : Array[Double], name : String) -> MathapproxpolySeries {
  { vals, name, meta: 0 }
}

pub fn math_approx_poly_series_len(s : MathapproxpolySeries) -> Int { s.vals.length() }

pub fn math_approx_poly_series_sum(s : MathapproxpolySeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn math_approx_poly_series_mean(s : MathapproxpolySeries) -> Double {
  let n = math_approx_poly_series_len(s)
  if n == 0 { 0.0 } else { math_approx_poly_series_sum(s) / n.to_double() }
}

pub fn math_approx_poly_series_min(s : MathapproxpolySeries) -> Double {
  let n = math_approx_poly_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn math_approx_poly_series_max(s : MathapproxpolySeries) -> Double {
  let n = math_approx_poly_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn math_approx_poly_series_range(s : MathapproxpolySeries) -> Double {
  math_approx_poly_series_max(s) - math_approx_poly_series_min(s)
}

pub fn math_approx_poly_series_var(s : MathapproxpolySeries) -> Double {
  let n = math_approx_poly_series_len(s)
  if n == 0 { 0.0 } else {
    let m = math_approx_poly_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn math_approx_poly_series_std(s : MathapproxpolySeries) -> Double { math_approx_poly_sqrt(math_approx_poly_series_var(s)) }

pub fn math_approx_poly_series_median(s : MathapproxpolySeries) -> Double {
  let n = math_approx_poly_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = math_approx_poly_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn math_approx_poly_series_scale(s : MathapproxpolySeries, f : Double) -> MathapproxpolySeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = math_approx_poly_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn math_approx_poly_series_add(a : MathapproxpolySeries, b : MathapproxpolySeries) -> MathapproxpolySeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = math_approx_poly_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn math_approx_poly_series_sub(a : MathapproxpolySeries, b : MathapproxpolySeries) -> MathapproxpolySeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = math_approx_poly_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn math_approx_poly_series_normalize(s : MathapproxpolySeries) -> MathapproxpolySeries {
  let mn = math_approx_poly_series_min(s)
  let mx = math_approx_poly_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = math_approx_poly_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn math_approx_poly_series_cumsum(s : MathapproxpolySeries) -> MathapproxpolySeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = math_approx_poly_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn math_approx_poly_series_to_string(s : MathapproxpolySeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + math_approx_poly_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MathapproxpolyMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn math_approx_poly_make_matrix(rows : Int, cols : Int, val : Double) -> MathapproxpolyMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn math_approx_poly_matrix_identity(n : Int) -> MathapproxpolyMatrix {
  let m = math_approx_poly_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn math_approx_poly_matrix_get(m : MathapproxpolyMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn math_approx_poly_matrix_transpose(m : MathapproxpolyMatrix) -> MathapproxpolyMatrix {
  let result = math_approx_poly_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn math_approx_poly_matrix_add(a : MathapproxpolyMatrix, b : MathapproxpolyMatrix) -> MathapproxpolyMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = math_approx_poly_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn math_approx_poly_matrix_scale(m : MathapproxpolyMatrix, s : Double) -> MathapproxpolyMatrix {
  let result = math_approx_poly_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn math_approx_poly_matrix_multiply(a : MathapproxpolyMatrix, b : MathapproxpolyMatrix) -> MathapproxpolyMatrix {
  if a.cols != b.rows { return math_approx_poly_make_matrix(a.rows, b.cols, 0.0) }
  let result = math_approx_poly_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn math_approx_poly_matrix_trace(m : MathapproxpolyMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn math_approx_poly_matrix_det(m : MathapproxpolyMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn math_approx_poly_matrix_norm(m : MathapproxpolyMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  math_approx_poly_sqrt(sum)
}

pub fn math_approx_poly_matrix_to_string(m : MathapproxpolyMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + math_approx_poly_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct MathapproxpolyVector {
  comps : Array[Double]
  dim : Int
}

pub fn math_approx_poly_make_vector(comps : Array[Double]) -> MathapproxpolyVector {
  { comps, dim: comps.length() }
}

pub fn math_approx_poly_vector_zero(dim : Int) -> MathapproxpolyVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn math_approx_poly_vector_add(a : MathapproxpolyVector, b : MathapproxpolyVector) -> MathapproxpolyVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = math_approx_poly_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn math_approx_poly_vector_sub(a : MathapproxpolyVector, b : MathapproxpolyVector) -> MathapproxpolyVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = math_approx_poly_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn math_approx_poly_vector_scale(v : MathapproxpolyVector, s : Double) -> MathapproxpolyVector {
  let mut result = []
  for i in 0..<v.dim { result = math_approx_poly_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn math_approx_poly_vector_dot(a : MathapproxpolyVector, b : MathapproxpolyVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn math_approx_poly_vector_norm(v : MathapproxpolyVector) -> Double { math_approx_poly_sqrt(math_approx_poly_vector_dot(v, v)) }

pub fn math_approx_poly_vector_normalize(v : MathapproxpolyVector) -> MathapproxpolyVector {
  let n = math_approx_poly_vector_norm(v)
  if n < 0.0000001 { v } else { math_approx_poly_vector_scale(v, 1.0 / n) }
}

pub fn math_approx_poly_vector_dist(a : MathapproxpolyVector, b : MathapproxpolyVector) -> Double {
  math_approx_poly_vector_norm(math_approx_poly_vector_sub(a, b))
}

pub fn math_approx_poly_vector_to_string(v : MathapproxpolyVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + math_approx_poly_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn math_approx_poly_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn math_approx_poly_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = math_approx_poly_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn math_approx_poly_std(data : Array[Double]) -> Double { math_approx_poly_sqrt(math_approx_poly_var(data)) }

pub fn math_approx_poly_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = math_approx_poly_mean(a); let mb = math_approx_poly_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn math_approx_poly_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = math_approx_poly_std(a); let sb = math_approx_poly_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { math_approx_poly_cov(a, b) / (sa * sb) }
}

pub fn math_approx_poly_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = math_approx_poly_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn math_approx_poly_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn math_approx_poly_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn math_approx_poly_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  math_approx_poly_sqrt(math_approx_poly_mse(pred, labels))
}

pub fn math_approx_poly_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + math_approx_poly_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn math_approx_poly_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = math_approx_poly_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn math_approx_poly_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn math_approx_poly_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn math_approx_poly_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = math_approx_poly_precision(pred, labels, pos); let r = math_approx_poly_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn math_approx_poly_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn math_approx_poly_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = math_approx_poly_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn math_approx_poly_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn math_approx_poly_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn math_approx_poly_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = math_approx_poly_gcd(a, b)
    (a / g) * b
  }
}

pub fn math_approx_poly_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn math_approx_poly_fibonacci(n : Int) -> Int {
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

pub fn math_approx_poly_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = math_approx_poly_min(data); let mx = math_approx_poly_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn math_approx_poly_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = math_approx_poly_mean(data); let sd = math_approx_poly_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn math_approx_poly_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn math_approx_poly_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn math_approx_poly_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn math_approx_poly_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn math_approx_poly_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn math_approx_poly_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn math_approx_poly_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn math_approx_poly_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn math_approx_poly_dbl(x : Double) -> String {
  let i = if x >= 0.0 { math_approx_poly_int(x) } else { -math_approx_poly_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { math_approx_poly_int(f * 1000000.0) } else { math_approx_poly_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn math_approx_poly_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn math_approx_poly_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct MathapproxpolyFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_poly_frame_make(size : Int) -> MathapproxpolyFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_poly_frame_len(s : MathapproxpolyFrame) -> Int { s.size }

pub fn math_approx_poly_frame_get(s : MathapproxpolyFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_poly_frame_set(s : MathapproxpolyFrame, i : Int, v : Double) -> MathapproxpolyFrame {
  let result = math_approx_poly_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_approx_poly_frame_sum(s : MathapproxpolyFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_approx_poly_frame_mean(s : MathapproxpolyFrame) -> Double {
  if s.size == 0 { 0.0 } else { math_approx_poly_frame_sum(s) / s.size.to_double() }
}

pub fn math_approx_poly_frame_scale(s : MathapproxpolyFrame, f : Double) -> MathapproxpolyFrame {
  let result = math_approx_poly_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_approx_poly_frame_add(a : MathapproxpolyFrame, b : MathapproxpolyFrame) -> MathapproxpolyFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_approx_poly_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_approx_poly_frame_copy(s : MathapproxpolyFrame) -> MathapproxpolyFrame {
  let result = math_approx_poly_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_approx_poly_frame_fill(s : MathapproxpolyFrame, v : Double) -> MathapproxpolyFrame {
  let result = math_approx_poly_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_approx_poly_frame_min(s : MathapproxpolyFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_poly_frame_max(s : MathapproxpolyFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_poly_frame_to_string(s : MathapproxpolyFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxpolyTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_poly_table_make(size : Int) -> MathapproxpolyTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_poly_table_len(s : MathapproxpolyTable) -> Int { s.size }

pub fn math_approx_poly_table_get(s : MathapproxpolyTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_poly_table_set(s : MathapproxpolyTable, i : Int, v : Double) -> MathapproxpolyTable {
  let result = math_approx_poly_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_approx_poly_table_sum(s : MathapproxpolyTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_approx_poly_table_mean(s : MathapproxpolyTable) -> Double {
  if s.size == 0 { 0.0 } else { math_approx_poly_table_sum(s) / s.size.to_double() }
}

pub fn math_approx_poly_table_scale(s : MathapproxpolyTable, f : Double) -> MathapproxpolyTable {
  let result = math_approx_poly_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_approx_poly_table_add(a : MathapproxpolyTable, b : MathapproxpolyTable) -> MathapproxpolyTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_approx_poly_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_approx_poly_table_copy(s : MathapproxpolyTable) -> MathapproxpolyTable {
  let result = math_approx_poly_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_approx_poly_table_fill(s : MathapproxpolyTable, v : Double) -> MathapproxpolyTable {
  let result = math_approx_poly_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_approx_poly_table_min(s : MathapproxpolyTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_poly_table_max(s : MathapproxpolyTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_poly_table_to_string(s : MathapproxpolyTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxpolyGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_poly_graphn_make(size : Int) -> MathapproxpolyGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_poly_graphn_len(s : MathapproxpolyGraphN) -> Int { s.size }

pub fn math_approx_poly_graphn_get(s : MathapproxpolyGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_poly_graphn_set(s : MathapproxpolyGraphN, i : Int, v : Double) -> MathapproxpolyGraphN {
  let result = math_approx_poly_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_approx_poly_graphn_sum(s : MathapproxpolyGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_approx_poly_graphn_mean(s : MathapproxpolyGraphN) -> Double {
  if s.size == 0 { 0.0 } else { math_approx_poly_graphn_sum(s) / s.size.to_double() }
}

pub fn math_approx_poly_graphn_scale(s : MathapproxpolyGraphN, f : Double) -> MathapproxpolyGraphN {
  let result = math_approx_poly_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_approx_poly_graphn_add(a : MathapproxpolyGraphN, b : MathapproxpolyGraphN) -> MathapproxpolyGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_approx_poly_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_approx_poly_graphn_copy(s : MathapproxpolyGraphN) -> MathapproxpolyGraphN {
  let result = math_approx_poly_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_approx_poly_graphn_fill(s : MathapproxpolyGraphN, v : Double) -> MathapproxpolyGraphN {
  let result = math_approx_poly_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_approx_poly_graphn_min(s : MathapproxpolyGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_poly_graphn_max(s : MathapproxpolyGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_poly_graphn_to_string(s : MathapproxpolyGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxpolyNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_poly_node_make(size : Int) -> MathapproxpolyNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_poly_node_len(s : MathapproxpolyNode) -> Int { s.size }

pub fn math_approx_poly_node_get(s : MathapproxpolyNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_poly_node_set(s : MathapproxpolyNode, i : Int, v : Double) -> MathapproxpolyNode {
  let result = math_approx_poly_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_approx_poly_node_sum(s : MathapproxpolyNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_approx_poly_node_mean(s : MathapproxpolyNode) -> Double {
  if s.size == 0 { 0.0 } else { math_approx_poly_node_sum(s) / s.size.to_double() }
}

pub fn math_approx_poly_node_scale(s : MathapproxpolyNode, f : Double) -> MathapproxpolyNode {
  let result = math_approx_poly_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_approx_poly_node_add(a : MathapproxpolyNode, b : MathapproxpolyNode) -> MathapproxpolyNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_approx_poly_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_approx_poly_node_copy(s : MathapproxpolyNode) -> MathapproxpolyNode {
  let result = math_approx_poly_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_approx_poly_node_fill(s : MathapproxpolyNode, v : Double) -> MathapproxpolyNode {
  let result = math_approx_poly_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_approx_poly_node_min(s : MathapproxpolyNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_poly_node_max(s : MathapproxpolyNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_poly_node_to_string(s : MathapproxpolyNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxpolyEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_poly_edge_make(size : Int) -> MathapproxpolyEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_poly_edge_len(s : MathapproxpolyEdge) -> Int { s.size }

pub fn math_approx_poly_edge_get(s : MathapproxpolyEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_poly_edge_set(s : MathapproxpolyEdge, i : Int, v : Double) -> MathapproxpolyEdge {
  let result = math_approx_poly_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_approx_poly_edge_sum(s : MathapproxpolyEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_approx_poly_edge_mean(s : MathapproxpolyEdge) -> Double {
  if s.size == 0 { 0.0 } else { math_approx_poly_edge_sum(s) / s.size.to_double() }
}

pub fn math_approx_poly_edge_scale(s : MathapproxpolyEdge, f : Double) -> MathapproxpolyEdge {
  let result = math_approx_poly_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_approx_poly_edge_add(a : MathapproxpolyEdge, b : MathapproxpolyEdge) -> MathapproxpolyEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_approx_poly_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_approx_poly_edge_copy(s : MathapproxpolyEdge) -> MathapproxpolyEdge {
  let result = math_approx_poly_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_approx_poly_edge_fill(s : MathapproxpolyEdge, v : Double) -> MathapproxpolyEdge {
  let result = math_approx_poly_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_approx_poly_edge_min(s : MathapproxpolyEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_poly_edge_max(s : MathapproxpolyEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_poly_edge_to_string(s : MathapproxpolyEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxpolyPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_poly_path_make(size : Int) -> MathapproxpolyPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_poly_path_len(s : MathapproxpolyPath) -> Int { s.size }

pub fn math_approx_poly_path_get(s : MathapproxpolyPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_poly_path_set(s : MathapproxpolyPath, i : Int, v : Double) -> MathapproxpolyPath {
  let result = math_approx_poly_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_approx_poly_path_sum(s : MathapproxpolyPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_approx_poly_path_mean(s : MathapproxpolyPath) -> Double {
  if s.size == 0 { 0.0 } else { math_approx_poly_path_sum(s) / s.size.to_double() }
}

pub fn math_approx_poly_path_scale(s : MathapproxpolyPath, f : Double) -> MathapproxpolyPath {
  let result = math_approx_poly_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_approx_poly_path_add(a : MathapproxpolyPath, b : MathapproxpolyPath) -> MathapproxpolyPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_approx_poly_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_approx_poly_path_copy(s : MathapproxpolyPath) -> MathapproxpolyPath {
  let result = math_approx_poly_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_approx_poly_path_fill(s : MathapproxpolyPath, v : Double) -> MathapproxpolyPath {
  let result = math_approx_poly_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_approx_poly_path_min(s : MathapproxpolyPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_poly_path_max(s : MathapproxpolyPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_poly_path_to_string(s : MathapproxpolyPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxpolyCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_poly_cluster_make(size : Int) -> MathapproxpolyCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_poly_cluster_len(s : MathapproxpolyCluster) -> Int { s.size }

pub fn math_approx_poly_cluster_get(s : MathapproxpolyCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_poly_cluster_set(s : MathapproxpolyCluster, i : Int, v : Double) -> MathapproxpolyCluster {
  let result = math_approx_poly_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_approx_poly_cluster_sum(s : MathapproxpolyCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_approx_poly_cluster_mean(s : MathapproxpolyCluster) -> Double {
  if s.size == 0 { 0.0 } else { math_approx_poly_cluster_sum(s) / s.size.to_double() }
}

pub fn math_approx_poly_cluster_scale(s : MathapproxpolyCluster, f : Double) -> MathapproxpolyCluster {
  let result = math_approx_poly_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_approx_poly_cluster_add(a : MathapproxpolyCluster, b : MathapproxpolyCluster) -> MathapproxpolyCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_approx_poly_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_approx_poly_cluster_copy(s : MathapproxpolyCluster) -> MathapproxpolyCluster {
  let result = math_approx_poly_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_approx_poly_cluster_fill(s : MathapproxpolyCluster, v : Double) -> MathapproxpolyCluster {
  let result = math_approx_poly_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_approx_poly_cluster_min(s : MathapproxpolyCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_poly_cluster_max(s : MathapproxpolyCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_poly_cluster_to_string(s : MathapproxpolyCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxpolyModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_poly_model_make(size : Int) -> MathapproxpolyModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_poly_model_len(s : MathapproxpolyModel) -> Int { s.size }

pub fn math_approx_poly_model_get(s : MathapproxpolyModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_poly_model_set(s : MathapproxpolyModel, i : Int, v : Double) -> MathapproxpolyModel {
  let result = math_approx_poly_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_approx_poly_model_sum(s : MathapproxpolyModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_approx_poly_model_mean(s : MathapproxpolyModel) -> Double {
  if s.size == 0 { 0.0 } else { math_approx_poly_model_sum(s) / s.size.to_double() }
}

pub fn math_approx_poly_model_scale(s : MathapproxpolyModel, f : Double) -> MathapproxpolyModel {
  let result = math_approx_poly_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_approx_poly_model_add(a : MathapproxpolyModel, b : MathapproxpolyModel) -> MathapproxpolyModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_approx_poly_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_approx_poly_model_copy(s : MathapproxpolyModel) -> MathapproxpolyModel {
  let result = math_approx_poly_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_approx_poly_model_fill(s : MathapproxpolyModel, v : Double) -> MathapproxpolyModel {
  let result = math_approx_poly_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_approx_poly_model_min(s : MathapproxpolyModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_poly_model_max(s : MathapproxpolyModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_poly_model_to_string(s : MathapproxpolyModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxpolyLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_poly_layer_make(size : Int) -> MathapproxpolyLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_poly_layer_len(s : MathapproxpolyLayer) -> Int { s.size }

pub fn math_approx_poly_layer_get(s : MathapproxpolyLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_poly_layer_set(s : MathapproxpolyLayer, i : Int, v : Double) -> MathapproxpolyLayer {
  let result = math_approx_poly_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_approx_poly_layer_sum(s : MathapproxpolyLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_approx_poly_layer_mean(s : MathapproxpolyLayer) -> Double {
  if s.size == 0 { 0.0 } else { math_approx_poly_layer_sum(s) / s.size.to_double() }
}

pub fn math_approx_poly_layer_scale(s : MathapproxpolyLayer, f : Double) -> MathapproxpolyLayer {
  let result = math_approx_poly_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_approx_poly_layer_add(a : MathapproxpolyLayer, b : MathapproxpolyLayer) -> MathapproxpolyLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_approx_poly_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_approx_poly_layer_copy(s : MathapproxpolyLayer) -> MathapproxpolyLayer {
  let result = math_approx_poly_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_approx_poly_layer_fill(s : MathapproxpolyLayer, v : Double) -> MathapproxpolyLayer {
  let result = math_approx_poly_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_approx_poly_layer_min(s : MathapproxpolyLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_poly_layer_max(s : MathapproxpolyLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_poly_layer_to_string(s : MathapproxpolyLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxpolyBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_poly_buffer_make(size : Int) -> MathapproxpolyBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_poly_buffer_len(s : MathapproxpolyBuffer) -> Int { s.size }

pub fn math_approx_poly_buffer_get(s : MathapproxpolyBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_poly_buffer_set(s : MathapproxpolyBuffer, i : Int, v : Double) -> MathapproxpolyBuffer {
  let result = math_approx_poly_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_approx_poly_buffer_sum(s : MathapproxpolyBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_approx_poly_buffer_mean(s : MathapproxpolyBuffer) -> Double {
  if s.size == 0 { 0.0 } else { math_approx_poly_buffer_sum(s) / s.size.to_double() }
}

pub fn math_approx_poly_buffer_scale(s : MathapproxpolyBuffer, f : Double) -> MathapproxpolyBuffer {
  let result = math_approx_poly_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_approx_poly_buffer_add(a : MathapproxpolyBuffer, b : MathapproxpolyBuffer) -> MathapproxpolyBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_approx_poly_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_approx_poly_buffer_copy(s : MathapproxpolyBuffer) -> MathapproxpolyBuffer {
  let result = math_approx_poly_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_approx_poly_buffer_fill(s : MathapproxpolyBuffer, v : Double) -> MathapproxpolyBuffer {
  let result = math_approx_poly_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_approx_poly_buffer_min(s : MathapproxpolyBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_poly_buffer_max(s : MathapproxpolyBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_poly_buffer_to_string(s : MathapproxpolyBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxpolyCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_poly_cursor_make(size : Int) -> MathapproxpolyCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_poly_cursor_len(s : MathapproxpolyCursor) -> Int { s.size }

pub fn math_approx_poly_cursor_get(s : MathapproxpolyCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_poly_cursor_set(s : MathapproxpolyCursor, i : Int, v : Double) -> MathapproxpolyCursor {
  let result = math_approx_poly_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_approx_poly_cursor_sum(s : MathapproxpolyCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_approx_poly_cursor_mean(s : MathapproxpolyCursor) -> Double {
  if s.size == 0 { 0.0 } else { math_approx_poly_cursor_sum(s) / s.size.to_double() }
}

pub fn math_approx_poly_cursor_scale(s : MathapproxpolyCursor, f : Double) -> MathapproxpolyCursor {
  let result = math_approx_poly_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_approx_poly_cursor_add(a : MathapproxpolyCursor, b : MathapproxpolyCursor) -> MathapproxpolyCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_approx_poly_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_approx_poly_cursor_copy(s : MathapproxpolyCursor) -> MathapproxpolyCursor {
  let result = math_approx_poly_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_approx_poly_cursor_fill(s : MathapproxpolyCursor, v : Double) -> MathapproxpolyCursor {
  let result = math_approx_poly_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_approx_poly_cursor_min(s : MathapproxpolyCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_poly_cursor_max(s : MathapproxpolyCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_poly_cursor_to_string(s : MathapproxpolyCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxpolyView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_poly_view_make(size : Int) -> MathapproxpolyView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_poly_view_len(s : MathapproxpolyView) -> Int { s.size }

pub fn math_approx_poly_view_get(s : MathapproxpolyView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_poly_view_set(s : MathapproxpolyView, i : Int, v : Double) -> MathapproxpolyView {
  let result = math_approx_poly_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_approx_poly_view_sum(s : MathapproxpolyView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_approx_poly_view_mean(s : MathapproxpolyView) -> Double {
  if s.size == 0 { 0.0 } else { math_approx_poly_view_sum(s) / s.size.to_double() }
}

pub fn math_approx_poly_view_scale(s : MathapproxpolyView, f : Double) -> MathapproxpolyView {
  let result = math_approx_poly_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_approx_poly_view_add(a : MathapproxpolyView, b : MathapproxpolyView) -> MathapproxpolyView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_approx_poly_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_approx_poly_view_copy(s : MathapproxpolyView) -> MathapproxpolyView {
  let result = math_approx_poly_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_approx_poly_view_fill(s : MathapproxpolyView, v : Double) -> MathapproxpolyView {
  let result = math_approx_poly_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_approx_poly_view_min(s : MathapproxpolyView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_poly_view_max(s : MathapproxpolyView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_poly_view_to_string(s : MathapproxpolyView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxpolyRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_poly_range_make(size : Int) -> MathapproxpolyRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_poly_range_len(s : MathapproxpolyRange) -> Int { s.size }

pub fn math_approx_poly_range_get(s : MathapproxpolyRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_poly_range_set(s : MathapproxpolyRange, i : Int, v : Double) -> MathapproxpolyRange {
  let result = math_approx_poly_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_approx_poly_range_sum(s : MathapproxpolyRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_approx_poly_range_mean(s : MathapproxpolyRange) -> Double {
  if s.size == 0 { 0.0 } else { math_approx_poly_range_sum(s) / s.size.to_double() }
}

pub fn math_approx_poly_range_scale(s : MathapproxpolyRange, f : Double) -> MathapproxpolyRange {
  let result = math_approx_poly_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_approx_poly_range_add(a : MathapproxpolyRange, b : MathapproxpolyRange) -> MathapproxpolyRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_approx_poly_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_approx_poly_range_copy(s : MathapproxpolyRange) -> MathapproxpolyRange {
  let result = math_approx_poly_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_approx_poly_range_fill(s : MathapproxpolyRange, v : Double) -> MathapproxpolyRange {
  let result = math_approx_poly_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_approx_poly_range_min(s : MathapproxpolyRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_poly_range_max(s : MathapproxpolyRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_poly_range_to_string(s : MathapproxpolyRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxpolySlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_poly_slice_make(size : Int) -> MathapproxpolySlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_poly_slice_len(s : MathapproxpolySlice) -> Int { s.size }

pub fn math_approx_poly_slice_get(s : MathapproxpolySlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_poly_slice_set(s : MathapproxpolySlice, i : Int, v : Double) -> MathapproxpolySlice {
  let result = math_approx_poly_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_approx_poly_slice_sum(s : MathapproxpolySlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_approx_poly_slice_mean(s : MathapproxpolySlice) -> Double {
  if s.size == 0 { 0.0 } else { math_approx_poly_slice_sum(s) / s.size.to_double() }
}

pub fn math_approx_poly_slice_scale(s : MathapproxpolySlice, f : Double) -> MathapproxpolySlice {
  let result = math_approx_poly_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_approx_poly_slice_add(a : MathapproxpolySlice, b : MathapproxpolySlice) -> MathapproxpolySlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_approx_poly_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_approx_poly_slice_copy(s : MathapproxpolySlice) -> MathapproxpolySlice {
  let result = math_approx_poly_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_approx_poly_slice_fill(s : MathapproxpolySlice, v : Double) -> MathapproxpolySlice {
  let result = math_approx_poly_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_approx_poly_slice_min(s : MathapproxpolySlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_poly_slice_max(s : MathapproxpolySlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_poly_slice_to_string(s : MathapproxpolySlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn math_approx_poly_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_approx_poly_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_approx_poly_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_approx_poly_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_approx_poly_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_approx_poly_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_approx_poly_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_approx_poly_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_approx_poly_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_approx_poly_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_approx_poly_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_approx_poly_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_approx_poly_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_approx_poly_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_approx_poly_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_approx_poly_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_approx_poly_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_approx_poly_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_approx_poly_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_approx_poly_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_approx_poly_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_approx_poly_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_approx_poly_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_approx_poly_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_approx_poly_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

