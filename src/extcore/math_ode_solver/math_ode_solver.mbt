///===
/// extcore/math_ode_solver

pub(all) struct MathodesolverPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn math_ode_solver_make_point(x : Double, y : Double) -> MathodesolverPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn math_ode_solver_make_point3(x : Double, y : Double, z : Double) -> MathodesolverPoint {
  { x, y, z, label: 0 }
}

pub fn math_ode_solver_point_x(pt : MathodesolverPoint) -> Double { pt.x }

pub fn math_ode_solver_point_y(pt : MathodesolverPoint) -> Double { pt.y }

pub fn math_ode_solver_point_z(pt : MathodesolverPoint) -> Double { pt.z }

pub fn math_ode_solver_point_label(pt : MathodesolverPoint) -> Int { pt.label }

pub fn math_ode_solver_point_dist(a : MathodesolverPoint, b : MathodesolverPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  math_ode_solver_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn math_ode_solver_point_add(a : MathodesolverPoint, b : MathodesolverPoint) -> MathodesolverPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn math_ode_solver_point_sub(a : MathodesolverPoint, b : MathodesolverPoint) -> MathodesolverPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn math_ode_solver_point_scale(pt : MathodesolverPoint, s : Double) -> MathodesolverPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn math_ode_solver_point_dot(a : MathodesolverPoint, b : MathodesolverPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn math_ode_solver_point_cross(a : MathodesolverPoint, b : MathodesolverPoint) -> MathodesolverPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn math_ode_solver_point_norm(pt : MathodesolverPoint) -> Double {
  math_ode_solver_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn math_ode_solver_point_normalize(pt : MathodesolverPoint) -> MathodesolverPoint {
  let n = math_ode_solver_point_norm(pt)
  if n < 0.0000001 { pt } else { math_ode_solver_point_scale(pt, 1.0 / n) }
}

pub fn math_ode_solver_point_negate(pt : MathodesolverPoint) -> MathodesolverPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn math_ode_solver_point_mid(a : MathodesolverPoint, b : MathodesolverPoint) -> MathodesolverPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn math_ode_solver_point_lerp(a : MathodesolverPoint, b : MathodesolverPoint, t : Double) -> MathodesolverPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn math_ode_solver_point_to_string(pt : MathodesolverPoint) -> String {
  "(" + math_ode_solver_dbl(pt.x) + ", " + math_ode_solver_dbl(pt.y) + ", " + math_ode_solver_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct MathodesolverSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn math_ode_solver_make_series(vals : Array[Double], name : String) -> MathodesolverSeries {
  { vals, name, meta: 0 }
}

pub fn math_ode_solver_series_len(s : MathodesolverSeries) -> Int { s.vals.length() }

pub fn math_ode_solver_series_sum(s : MathodesolverSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn math_ode_solver_series_mean(s : MathodesolverSeries) -> Double {
  let n = math_ode_solver_series_len(s)
  if n == 0 { 0.0 } else { math_ode_solver_series_sum(s) / n.to_double() }
}

pub fn math_ode_solver_series_min(s : MathodesolverSeries) -> Double {
  let n = math_ode_solver_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn math_ode_solver_series_max(s : MathodesolverSeries) -> Double {
  let n = math_ode_solver_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn math_ode_solver_series_range(s : MathodesolverSeries) -> Double {
  math_ode_solver_series_max(s) - math_ode_solver_series_min(s)
}

pub fn math_ode_solver_series_var(s : MathodesolverSeries) -> Double {
  let n = math_ode_solver_series_len(s)
  if n == 0 { 0.0 } else {
    let m = math_ode_solver_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn math_ode_solver_series_std(s : MathodesolverSeries) -> Double { math_ode_solver_sqrt(math_ode_solver_series_var(s)) }

pub fn math_ode_solver_series_median(s : MathodesolverSeries) -> Double {
  let n = math_ode_solver_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = math_ode_solver_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn math_ode_solver_series_scale(s : MathodesolverSeries, f : Double) -> MathodesolverSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = math_ode_solver_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn math_ode_solver_series_add(a : MathodesolverSeries, b : MathodesolverSeries) -> MathodesolverSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = math_ode_solver_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn math_ode_solver_series_sub(a : MathodesolverSeries, b : MathodesolverSeries) -> MathodesolverSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = math_ode_solver_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn math_ode_solver_series_normalize(s : MathodesolverSeries) -> MathodesolverSeries {
  let mn = math_ode_solver_series_min(s)
  let mx = math_ode_solver_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = math_ode_solver_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn math_ode_solver_series_cumsum(s : MathodesolverSeries) -> MathodesolverSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = math_ode_solver_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn math_ode_solver_series_to_string(s : MathodesolverSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + math_ode_solver_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MathodesolverMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn math_ode_solver_make_matrix(rows : Int, cols : Int, val : Double) -> MathodesolverMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn math_ode_solver_matrix_identity(n : Int) -> MathodesolverMatrix {
  let m = math_ode_solver_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn math_ode_solver_matrix_get(m : MathodesolverMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn math_ode_solver_matrix_transpose(m : MathodesolverMatrix) -> MathodesolverMatrix {
  let result = math_ode_solver_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn math_ode_solver_matrix_add(a : MathodesolverMatrix, b : MathodesolverMatrix) -> MathodesolverMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = math_ode_solver_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn math_ode_solver_matrix_scale(m : MathodesolverMatrix, s : Double) -> MathodesolverMatrix {
  let result = math_ode_solver_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn math_ode_solver_matrix_multiply(a : MathodesolverMatrix, b : MathodesolverMatrix) -> MathodesolverMatrix {
  if a.cols != b.rows { return math_ode_solver_make_matrix(a.rows, b.cols, 0.0) }
  let result = math_ode_solver_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn math_ode_solver_matrix_trace(m : MathodesolverMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn math_ode_solver_matrix_det(m : MathodesolverMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn math_ode_solver_matrix_norm(m : MathodesolverMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  math_ode_solver_sqrt(sum)
}

pub fn math_ode_solver_matrix_to_string(m : MathodesolverMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + math_ode_solver_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct MathodesolverVector {
  comps : Array[Double]
  dim : Int
}

pub fn math_ode_solver_make_vector(comps : Array[Double]) -> MathodesolverVector {
  { comps, dim: comps.length() }
}

pub fn math_ode_solver_vector_zero(dim : Int) -> MathodesolverVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn math_ode_solver_vector_add(a : MathodesolverVector, b : MathodesolverVector) -> MathodesolverVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = math_ode_solver_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn math_ode_solver_vector_sub(a : MathodesolverVector, b : MathodesolverVector) -> MathodesolverVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = math_ode_solver_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn math_ode_solver_vector_scale(v : MathodesolverVector, s : Double) -> MathodesolverVector {
  let mut result = []
  for i in 0..<v.dim { result = math_ode_solver_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn math_ode_solver_vector_dot(a : MathodesolverVector, b : MathodesolverVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn math_ode_solver_vector_norm(v : MathodesolverVector) -> Double { math_ode_solver_sqrt(math_ode_solver_vector_dot(v, v)) }

pub fn math_ode_solver_vector_normalize(v : MathodesolverVector) -> MathodesolverVector {
  let n = math_ode_solver_vector_norm(v)
  if n < 0.0000001 { v } else { math_ode_solver_vector_scale(v, 1.0 / n) }
}

pub fn math_ode_solver_vector_dist(a : MathodesolverVector, b : MathodesolverVector) -> Double {
  math_ode_solver_vector_norm(math_ode_solver_vector_sub(a, b))
}

pub fn math_ode_solver_vector_to_string(v : MathodesolverVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + math_ode_solver_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn math_ode_solver_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn math_ode_solver_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = math_ode_solver_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn math_ode_solver_std(data : Array[Double]) -> Double { math_ode_solver_sqrt(math_ode_solver_var(data)) }

pub fn math_ode_solver_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = math_ode_solver_mean(a); let mb = math_ode_solver_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn math_ode_solver_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = math_ode_solver_std(a); let sb = math_ode_solver_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { math_ode_solver_cov(a, b) / (sa * sb) }
}

pub fn math_ode_solver_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = math_ode_solver_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn math_ode_solver_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn math_ode_solver_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn math_ode_solver_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  math_ode_solver_sqrt(math_ode_solver_mse(pred, labels))
}

pub fn math_ode_solver_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + math_ode_solver_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn math_ode_solver_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = math_ode_solver_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn math_ode_solver_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn math_ode_solver_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn math_ode_solver_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = math_ode_solver_precision(pred, labels, pos); let r = math_ode_solver_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn math_ode_solver_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn math_ode_solver_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = math_ode_solver_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn math_ode_solver_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn math_ode_solver_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn math_ode_solver_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = math_ode_solver_gcd(a, b)
    (a / g) * b
  }
}

pub fn math_ode_solver_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn math_ode_solver_fibonacci(n : Int) -> Int {
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

pub fn math_ode_solver_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = math_ode_solver_min(data); let mx = math_ode_solver_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn math_ode_solver_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = math_ode_solver_mean(data); let sd = math_ode_solver_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn math_ode_solver_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn math_ode_solver_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn math_ode_solver_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn math_ode_solver_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn math_ode_solver_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn math_ode_solver_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn math_ode_solver_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn math_ode_solver_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn math_ode_solver_dbl(x : Double) -> String {
  let i = if x >= 0.0 { math_ode_solver_int(x) } else { -math_ode_solver_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { math_ode_solver_int(f * 1000000.0) } else { math_ode_solver_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn math_ode_solver_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn math_ode_solver_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct MathodesolverFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_ode_solver_frame_make(size : Int) -> MathodesolverFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_ode_solver_frame_len(s : MathodesolverFrame) -> Int { s.size }

pub fn math_ode_solver_frame_get(s : MathodesolverFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_ode_solver_frame_set(s : MathodesolverFrame, i : Int, v : Double) -> MathodesolverFrame {
  let result = math_ode_solver_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_ode_solver_frame_sum(s : MathodesolverFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_ode_solver_frame_mean(s : MathodesolverFrame) -> Double {
  if s.size == 0 { 0.0 } else { math_ode_solver_frame_sum(s) / s.size.to_double() }
}

pub fn math_ode_solver_frame_scale(s : MathodesolverFrame, f : Double) -> MathodesolverFrame {
  let result = math_ode_solver_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_ode_solver_frame_add(a : MathodesolverFrame, b : MathodesolverFrame) -> MathodesolverFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_ode_solver_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_ode_solver_frame_copy(s : MathodesolverFrame) -> MathodesolverFrame {
  let result = math_ode_solver_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_ode_solver_frame_fill(s : MathodesolverFrame, v : Double) -> MathodesolverFrame {
  let result = math_ode_solver_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_ode_solver_frame_min(s : MathodesolverFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_ode_solver_frame_max(s : MathodesolverFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_ode_solver_frame_to_string(s : MathodesolverFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathodesolverTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_ode_solver_table_make(size : Int) -> MathodesolverTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_ode_solver_table_len(s : MathodesolverTable) -> Int { s.size }

pub fn math_ode_solver_table_get(s : MathodesolverTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_ode_solver_table_set(s : MathodesolverTable, i : Int, v : Double) -> MathodesolverTable {
  let result = math_ode_solver_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_ode_solver_table_sum(s : MathodesolverTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_ode_solver_table_mean(s : MathodesolverTable) -> Double {
  if s.size == 0 { 0.0 } else { math_ode_solver_table_sum(s) / s.size.to_double() }
}

pub fn math_ode_solver_table_scale(s : MathodesolverTable, f : Double) -> MathodesolverTable {
  let result = math_ode_solver_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_ode_solver_table_add(a : MathodesolverTable, b : MathodesolverTable) -> MathodesolverTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_ode_solver_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_ode_solver_table_copy(s : MathodesolverTable) -> MathodesolverTable {
  let result = math_ode_solver_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_ode_solver_table_fill(s : MathodesolverTable, v : Double) -> MathodesolverTable {
  let result = math_ode_solver_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_ode_solver_table_min(s : MathodesolverTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_ode_solver_table_max(s : MathodesolverTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_ode_solver_table_to_string(s : MathodesolverTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathodesolverGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_ode_solver_graphn_make(size : Int) -> MathodesolverGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_ode_solver_graphn_len(s : MathodesolverGraphN) -> Int { s.size }

pub fn math_ode_solver_graphn_get(s : MathodesolverGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_ode_solver_graphn_set(s : MathodesolverGraphN, i : Int, v : Double) -> MathodesolverGraphN {
  let result = math_ode_solver_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_ode_solver_graphn_sum(s : MathodesolverGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_ode_solver_graphn_mean(s : MathodesolverGraphN) -> Double {
  if s.size == 0 { 0.0 } else { math_ode_solver_graphn_sum(s) / s.size.to_double() }
}

pub fn math_ode_solver_graphn_scale(s : MathodesolverGraphN, f : Double) -> MathodesolverGraphN {
  let result = math_ode_solver_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_ode_solver_graphn_add(a : MathodesolverGraphN, b : MathodesolverGraphN) -> MathodesolverGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_ode_solver_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_ode_solver_graphn_copy(s : MathodesolverGraphN) -> MathodesolverGraphN {
  let result = math_ode_solver_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_ode_solver_graphn_fill(s : MathodesolverGraphN, v : Double) -> MathodesolverGraphN {
  let result = math_ode_solver_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_ode_solver_graphn_min(s : MathodesolverGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_ode_solver_graphn_max(s : MathodesolverGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_ode_solver_graphn_to_string(s : MathodesolverGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathodesolverNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_ode_solver_node_make(size : Int) -> MathodesolverNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_ode_solver_node_len(s : MathodesolverNode) -> Int { s.size }

pub fn math_ode_solver_node_get(s : MathodesolverNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_ode_solver_node_set(s : MathodesolverNode, i : Int, v : Double) -> MathodesolverNode {
  let result = math_ode_solver_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_ode_solver_node_sum(s : MathodesolverNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_ode_solver_node_mean(s : MathodesolverNode) -> Double {
  if s.size == 0 { 0.0 } else { math_ode_solver_node_sum(s) / s.size.to_double() }
}

pub fn math_ode_solver_node_scale(s : MathodesolverNode, f : Double) -> MathodesolverNode {
  let result = math_ode_solver_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_ode_solver_node_add(a : MathodesolverNode, b : MathodesolverNode) -> MathodesolverNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_ode_solver_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_ode_solver_node_copy(s : MathodesolverNode) -> MathodesolverNode {
  let result = math_ode_solver_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_ode_solver_node_fill(s : MathodesolverNode, v : Double) -> MathodesolverNode {
  let result = math_ode_solver_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_ode_solver_node_min(s : MathodesolverNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_ode_solver_node_max(s : MathodesolverNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_ode_solver_node_to_string(s : MathodesolverNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathodesolverEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_ode_solver_edge_make(size : Int) -> MathodesolverEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_ode_solver_edge_len(s : MathodesolverEdge) -> Int { s.size }

pub fn math_ode_solver_edge_get(s : MathodesolverEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_ode_solver_edge_set(s : MathodesolverEdge, i : Int, v : Double) -> MathodesolverEdge {
  let result = math_ode_solver_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_ode_solver_edge_sum(s : MathodesolverEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_ode_solver_edge_mean(s : MathodesolverEdge) -> Double {
  if s.size == 0 { 0.0 } else { math_ode_solver_edge_sum(s) / s.size.to_double() }
}

pub fn math_ode_solver_edge_scale(s : MathodesolverEdge, f : Double) -> MathodesolverEdge {
  let result = math_ode_solver_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_ode_solver_edge_add(a : MathodesolverEdge, b : MathodesolverEdge) -> MathodesolverEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_ode_solver_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_ode_solver_edge_copy(s : MathodesolverEdge) -> MathodesolverEdge {
  let result = math_ode_solver_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_ode_solver_edge_fill(s : MathodesolverEdge, v : Double) -> MathodesolverEdge {
  let result = math_ode_solver_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_ode_solver_edge_min(s : MathodesolverEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_ode_solver_edge_max(s : MathodesolverEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_ode_solver_edge_to_string(s : MathodesolverEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathodesolverPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_ode_solver_path_make(size : Int) -> MathodesolverPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_ode_solver_path_len(s : MathodesolverPath) -> Int { s.size }

pub fn math_ode_solver_path_get(s : MathodesolverPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_ode_solver_path_set(s : MathodesolverPath, i : Int, v : Double) -> MathodesolverPath {
  let result = math_ode_solver_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_ode_solver_path_sum(s : MathodesolverPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_ode_solver_path_mean(s : MathodesolverPath) -> Double {
  if s.size == 0 { 0.0 } else { math_ode_solver_path_sum(s) / s.size.to_double() }
}

pub fn math_ode_solver_path_scale(s : MathodesolverPath, f : Double) -> MathodesolverPath {
  let result = math_ode_solver_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_ode_solver_path_add(a : MathodesolverPath, b : MathodesolverPath) -> MathodesolverPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_ode_solver_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_ode_solver_path_copy(s : MathodesolverPath) -> MathodesolverPath {
  let result = math_ode_solver_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_ode_solver_path_fill(s : MathodesolverPath, v : Double) -> MathodesolverPath {
  let result = math_ode_solver_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_ode_solver_path_min(s : MathodesolverPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_ode_solver_path_max(s : MathodesolverPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_ode_solver_path_to_string(s : MathodesolverPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathodesolverCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_ode_solver_cluster_make(size : Int) -> MathodesolverCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_ode_solver_cluster_len(s : MathodesolverCluster) -> Int { s.size }

pub fn math_ode_solver_cluster_get(s : MathodesolverCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_ode_solver_cluster_set(s : MathodesolverCluster, i : Int, v : Double) -> MathodesolverCluster {
  let result = math_ode_solver_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_ode_solver_cluster_sum(s : MathodesolverCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_ode_solver_cluster_mean(s : MathodesolverCluster) -> Double {
  if s.size == 0 { 0.0 } else { math_ode_solver_cluster_sum(s) / s.size.to_double() }
}

pub fn math_ode_solver_cluster_scale(s : MathodesolverCluster, f : Double) -> MathodesolverCluster {
  let result = math_ode_solver_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_ode_solver_cluster_add(a : MathodesolverCluster, b : MathodesolverCluster) -> MathodesolverCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_ode_solver_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_ode_solver_cluster_copy(s : MathodesolverCluster) -> MathodesolverCluster {
  let result = math_ode_solver_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_ode_solver_cluster_fill(s : MathodesolverCluster, v : Double) -> MathodesolverCluster {
  let result = math_ode_solver_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_ode_solver_cluster_min(s : MathodesolverCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_ode_solver_cluster_max(s : MathodesolverCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_ode_solver_cluster_to_string(s : MathodesolverCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathodesolverModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_ode_solver_model_make(size : Int) -> MathodesolverModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_ode_solver_model_len(s : MathodesolverModel) -> Int { s.size }

pub fn math_ode_solver_model_get(s : MathodesolverModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_ode_solver_model_set(s : MathodesolverModel, i : Int, v : Double) -> MathodesolverModel {
  let result = math_ode_solver_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_ode_solver_model_sum(s : MathodesolverModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_ode_solver_model_mean(s : MathodesolverModel) -> Double {
  if s.size == 0 { 0.0 } else { math_ode_solver_model_sum(s) / s.size.to_double() }
}

pub fn math_ode_solver_model_scale(s : MathodesolverModel, f : Double) -> MathodesolverModel {
  let result = math_ode_solver_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_ode_solver_model_add(a : MathodesolverModel, b : MathodesolverModel) -> MathodesolverModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_ode_solver_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_ode_solver_model_copy(s : MathodesolverModel) -> MathodesolverModel {
  let result = math_ode_solver_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_ode_solver_model_fill(s : MathodesolverModel, v : Double) -> MathodesolverModel {
  let result = math_ode_solver_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_ode_solver_model_min(s : MathodesolverModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_ode_solver_model_max(s : MathodesolverModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_ode_solver_model_to_string(s : MathodesolverModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathodesolverLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_ode_solver_layer_make(size : Int) -> MathodesolverLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_ode_solver_layer_len(s : MathodesolverLayer) -> Int { s.size }

pub fn math_ode_solver_layer_get(s : MathodesolverLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_ode_solver_layer_set(s : MathodesolverLayer, i : Int, v : Double) -> MathodesolverLayer {
  let result = math_ode_solver_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_ode_solver_layer_sum(s : MathodesolverLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_ode_solver_layer_mean(s : MathodesolverLayer) -> Double {
  if s.size == 0 { 0.0 } else { math_ode_solver_layer_sum(s) / s.size.to_double() }
}

pub fn math_ode_solver_layer_scale(s : MathodesolverLayer, f : Double) -> MathodesolverLayer {
  let result = math_ode_solver_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_ode_solver_layer_add(a : MathodesolverLayer, b : MathodesolverLayer) -> MathodesolverLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_ode_solver_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_ode_solver_layer_copy(s : MathodesolverLayer) -> MathodesolverLayer {
  let result = math_ode_solver_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_ode_solver_layer_fill(s : MathodesolverLayer, v : Double) -> MathodesolverLayer {
  let result = math_ode_solver_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_ode_solver_layer_min(s : MathodesolverLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_ode_solver_layer_max(s : MathodesolverLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_ode_solver_layer_to_string(s : MathodesolverLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathodesolverBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_ode_solver_buffer_make(size : Int) -> MathodesolverBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_ode_solver_buffer_len(s : MathodesolverBuffer) -> Int { s.size }

pub fn math_ode_solver_buffer_get(s : MathodesolverBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_ode_solver_buffer_set(s : MathodesolverBuffer, i : Int, v : Double) -> MathodesolverBuffer {
  let result = math_ode_solver_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_ode_solver_buffer_sum(s : MathodesolverBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_ode_solver_buffer_mean(s : MathodesolverBuffer) -> Double {
  if s.size == 0 { 0.0 } else { math_ode_solver_buffer_sum(s) / s.size.to_double() }
}

pub fn math_ode_solver_buffer_scale(s : MathodesolverBuffer, f : Double) -> MathodesolverBuffer {
  let result = math_ode_solver_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_ode_solver_buffer_add(a : MathodesolverBuffer, b : MathodesolverBuffer) -> MathodesolverBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_ode_solver_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_ode_solver_buffer_copy(s : MathodesolverBuffer) -> MathodesolverBuffer {
  let result = math_ode_solver_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_ode_solver_buffer_fill(s : MathodesolverBuffer, v : Double) -> MathodesolverBuffer {
  let result = math_ode_solver_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_ode_solver_buffer_min(s : MathodesolverBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_ode_solver_buffer_max(s : MathodesolverBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_ode_solver_buffer_to_string(s : MathodesolverBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathodesolverCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_ode_solver_cursor_make(size : Int) -> MathodesolverCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_ode_solver_cursor_len(s : MathodesolverCursor) -> Int { s.size }

pub fn math_ode_solver_cursor_get(s : MathodesolverCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_ode_solver_cursor_set(s : MathodesolverCursor, i : Int, v : Double) -> MathodesolverCursor {
  let result = math_ode_solver_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_ode_solver_cursor_sum(s : MathodesolverCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_ode_solver_cursor_mean(s : MathodesolverCursor) -> Double {
  if s.size == 0 { 0.0 } else { math_ode_solver_cursor_sum(s) / s.size.to_double() }
}

pub fn math_ode_solver_cursor_scale(s : MathodesolverCursor, f : Double) -> MathodesolverCursor {
  let result = math_ode_solver_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_ode_solver_cursor_add(a : MathodesolverCursor, b : MathodesolverCursor) -> MathodesolverCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_ode_solver_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_ode_solver_cursor_copy(s : MathodesolverCursor) -> MathodesolverCursor {
  let result = math_ode_solver_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_ode_solver_cursor_fill(s : MathodesolverCursor, v : Double) -> MathodesolverCursor {
  let result = math_ode_solver_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_ode_solver_cursor_min(s : MathodesolverCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_ode_solver_cursor_max(s : MathodesolverCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_ode_solver_cursor_to_string(s : MathodesolverCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathodesolverView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_ode_solver_view_make(size : Int) -> MathodesolverView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_ode_solver_view_len(s : MathodesolverView) -> Int { s.size }

pub fn math_ode_solver_view_get(s : MathodesolverView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_ode_solver_view_set(s : MathodesolverView, i : Int, v : Double) -> MathodesolverView {
  let result = math_ode_solver_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_ode_solver_view_sum(s : MathodesolverView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_ode_solver_view_mean(s : MathodesolverView) -> Double {
  if s.size == 0 { 0.0 } else { math_ode_solver_view_sum(s) / s.size.to_double() }
}

pub fn math_ode_solver_view_scale(s : MathodesolverView, f : Double) -> MathodesolverView {
  let result = math_ode_solver_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_ode_solver_view_add(a : MathodesolverView, b : MathodesolverView) -> MathodesolverView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_ode_solver_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_ode_solver_view_copy(s : MathodesolverView) -> MathodesolverView {
  let result = math_ode_solver_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_ode_solver_view_fill(s : MathodesolverView, v : Double) -> MathodesolverView {
  let result = math_ode_solver_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_ode_solver_view_min(s : MathodesolverView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_ode_solver_view_max(s : MathodesolverView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_ode_solver_view_to_string(s : MathodesolverView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathodesolverRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_ode_solver_range_make(size : Int) -> MathodesolverRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_ode_solver_range_len(s : MathodesolverRange) -> Int { s.size }

pub fn math_ode_solver_range_get(s : MathodesolverRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_ode_solver_range_set(s : MathodesolverRange, i : Int, v : Double) -> MathodesolverRange {
  let result = math_ode_solver_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_ode_solver_range_sum(s : MathodesolverRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_ode_solver_range_mean(s : MathodesolverRange) -> Double {
  if s.size == 0 { 0.0 } else { math_ode_solver_range_sum(s) / s.size.to_double() }
}

pub fn math_ode_solver_range_scale(s : MathodesolverRange, f : Double) -> MathodesolverRange {
  let result = math_ode_solver_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_ode_solver_range_add(a : MathodesolverRange, b : MathodesolverRange) -> MathodesolverRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_ode_solver_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_ode_solver_range_copy(s : MathodesolverRange) -> MathodesolverRange {
  let result = math_ode_solver_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_ode_solver_range_fill(s : MathodesolverRange, v : Double) -> MathodesolverRange {
  let result = math_ode_solver_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_ode_solver_range_min(s : MathodesolverRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_ode_solver_range_max(s : MathodesolverRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_ode_solver_range_to_string(s : MathodesolverRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathodesolverSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_ode_solver_slice_make(size : Int) -> MathodesolverSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_ode_solver_slice_len(s : MathodesolverSlice) -> Int { s.size }

pub fn math_ode_solver_slice_get(s : MathodesolverSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_ode_solver_slice_set(s : MathodesolverSlice, i : Int, v : Double) -> MathodesolverSlice {
  let result = math_ode_solver_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_ode_solver_slice_sum(s : MathodesolverSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_ode_solver_slice_mean(s : MathodesolverSlice) -> Double {
  if s.size == 0 { 0.0 } else { math_ode_solver_slice_sum(s) / s.size.to_double() }
}

pub fn math_ode_solver_slice_scale(s : MathodesolverSlice, f : Double) -> MathodesolverSlice {
  let result = math_ode_solver_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_ode_solver_slice_add(a : MathodesolverSlice, b : MathodesolverSlice) -> MathodesolverSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_ode_solver_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_ode_solver_slice_copy(s : MathodesolverSlice) -> MathodesolverSlice {
  let result = math_ode_solver_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_ode_solver_slice_fill(s : MathodesolverSlice, v : Double) -> MathodesolverSlice {
  let result = math_ode_solver_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_ode_solver_slice_min(s : MathodesolverSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_ode_solver_slice_max(s : MathodesolverSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_ode_solver_slice_to_string(s : MathodesolverSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn math_ode_solver_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_ode_solver_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_ode_solver_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_ode_solver_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_ode_solver_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_ode_solver_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_ode_solver_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_ode_solver_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_ode_solver_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_ode_solver_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_ode_solver_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_ode_solver_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_ode_solver_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_ode_solver_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_ode_solver_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_ode_solver_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_ode_solver_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_ode_solver_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_ode_solver_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_ode_solver_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_ode_solver_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_ode_solver_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_ode_solver_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_ode_solver_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_ode_solver_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

