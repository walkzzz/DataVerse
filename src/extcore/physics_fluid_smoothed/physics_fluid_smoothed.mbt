///===
/// extcore/physics_fluid_smoothed

pub(all) struct PhysicsfluidsmoothedPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn physics_fluid_smoothed_make_point(x : Double, y : Double) -> PhysicsfluidsmoothedPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn physics_fluid_smoothed_make_point3(x : Double, y : Double, z : Double) -> PhysicsfluidsmoothedPoint {
  { x, y, z, label: 0 }
}

pub fn physics_fluid_smoothed_point_x(pt : PhysicsfluidsmoothedPoint) -> Double { pt.x }

pub fn physics_fluid_smoothed_point_y(pt : PhysicsfluidsmoothedPoint) -> Double { pt.y }

pub fn physics_fluid_smoothed_point_z(pt : PhysicsfluidsmoothedPoint) -> Double { pt.z }

pub fn physics_fluid_smoothed_point_label(pt : PhysicsfluidsmoothedPoint) -> Int { pt.label }

pub fn physics_fluid_smoothed_point_dist(a : PhysicsfluidsmoothedPoint, b : PhysicsfluidsmoothedPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  physics_fluid_smoothed_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn physics_fluid_smoothed_point_add(a : PhysicsfluidsmoothedPoint, b : PhysicsfluidsmoothedPoint) -> PhysicsfluidsmoothedPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn physics_fluid_smoothed_point_sub(a : PhysicsfluidsmoothedPoint, b : PhysicsfluidsmoothedPoint) -> PhysicsfluidsmoothedPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn physics_fluid_smoothed_point_scale(pt : PhysicsfluidsmoothedPoint, s : Double) -> PhysicsfluidsmoothedPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn physics_fluid_smoothed_point_dot(a : PhysicsfluidsmoothedPoint, b : PhysicsfluidsmoothedPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn physics_fluid_smoothed_point_cross(a : PhysicsfluidsmoothedPoint, b : PhysicsfluidsmoothedPoint) -> PhysicsfluidsmoothedPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn physics_fluid_smoothed_point_norm(pt : PhysicsfluidsmoothedPoint) -> Double {
  physics_fluid_smoothed_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn physics_fluid_smoothed_point_normalize(pt : PhysicsfluidsmoothedPoint) -> PhysicsfluidsmoothedPoint {
  let n = physics_fluid_smoothed_point_norm(pt)
  if n < 0.0000001 { pt } else { physics_fluid_smoothed_point_scale(pt, 1.0 / n) }
}

pub fn physics_fluid_smoothed_point_negate(pt : PhysicsfluidsmoothedPoint) -> PhysicsfluidsmoothedPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn physics_fluid_smoothed_point_mid(a : PhysicsfluidsmoothedPoint, b : PhysicsfluidsmoothedPoint) -> PhysicsfluidsmoothedPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn physics_fluid_smoothed_point_lerp(a : PhysicsfluidsmoothedPoint, b : PhysicsfluidsmoothedPoint, t : Double) -> PhysicsfluidsmoothedPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn physics_fluid_smoothed_point_to_string(pt : PhysicsfluidsmoothedPoint) -> String {
  "(" + physics_fluid_smoothed_dbl(pt.x) + ", " + physics_fluid_smoothed_dbl(pt.y) + ", " + physics_fluid_smoothed_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct PhysicsfluidsmoothedSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn physics_fluid_smoothed_make_series(vals : Array[Double], name : String) -> PhysicsfluidsmoothedSeries {
  { vals, name, meta: 0 }
}

pub fn physics_fluid_smoothed_series_len(s : PhysicsfluidsmoothedSeries) -> Int { s.vals.length() }

pub fn physics_fluid_smoothed_series_sum(s : PhysicsfluidsmoothedSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn physics_fluid_smoothed_series_mean(s : PhysicsfluidsmoothedSeries) -> Double {
  let n = physics_fluid_smoothed_series_len(s)
  if n == 0 { 0.0 } else { physics_fluid_smoothed_series_sum(s) / n.to_double() }
}

pub fn physics_fluid_smoothed_series_min(s : PhysicsfluidsmoothedSeries) -> Double {
  let n = physics_fluid_smoothed_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn physics_fluid_smoothed_series_max(s : PhysicsfluidsmoothedSeries) -> Double {
  let n = physics_fluid_smoothed_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn physics_fluid_smoothed_series_range(s : PhysicsfluidsmoothedSeries) -> Double {
  physics_fluid_smoothed_series_max(s) - physics_fluid_smoothed_series_min(s)
}

pub fn physics_fluid_smoothed_series_var(s : PhysicsfluidsmoothedSeries) -> Double {
  let n = physics_fluid_smoothed_series_len(s)
  if n == 0 { 0.0 } else {
    let m = physics_fluid_smoothed_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn physics_fluid_smoothed_series_std(s : PhysicsfluidsmoothedSeries) -> Double { physics_fluid_smoothed_sqrt(physics_fluid_smoothed_series_var(s)) }

pub fn physics_fluid_smoothed_series_median(s : PhysicsfluidsmoothedSeries) -> Double {
  let n = physics_fluid_smoothed_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = physics_fluid_smoothed_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn physics_fluid_smoothed_series_scale(s : PhysicsfluidsmoothedSeries, f : Double) -> PhysicsfluidsmoothedSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = physics_fluid_smoothed_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn physics_fluid_smoothed_series_add(a : PhysicsfluidsmoothedSeries, b : PhysicsfluidsmoothedSeries) -> PhysicsfluidsmoothedSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = physics_fluid_smoothed_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn physics_fluid_smoothed_series_sub(a : PhysicsfluidsmoothedSeries, b : PhysicsfluidsmoothedSeries) -> PhysicsfluidsmoothedSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = physics_fluid_smoothed_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn physics_fluid_smoothed_series_normalize(s : PhysicsfluidsmoothedSeries) -> PhysicsfluidsmoothedSeries {
  let mn = physics_fluid_smoothed_series_min(s)
  let mx = physics_fluid_smoothed_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = physics_fluid_smoothed_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn physics_fluid_smoothed_series_cumsum(s : PhysicsfluidsmoothedSeries) -> PhysicsfluidsmoothedSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = physics_fluid_smoothed_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn physics_fluid_smoothed_series_to_string(s : PhysicsfluidsmoothedSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + physics_fluid_smoothed_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct PhysicsfluidsmoothedMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn physics_fluid_smoothed_make_matrix(rows : Int, cols : Int, val : Double) -> PhysicsfluidsmoothedMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn physics_fluid_smoothed_matrix_identity(n : Int) -> PhysicsfluidsmoothedMatrix {
  let m = physics_fluid_smoothed_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn physics_fluid_smoothed_matrix_get(m : PhysicsfluidsmoothedMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn physics_fluid_smoothed_matrix_transpose(m : PhysicsfluidsmoothedMatrix) -> PhysicsfluidsmoothedMatrix {
  let result = physics_fluid_smoothed_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn physics_fluid_smoothed_matrix_add(a : PhysicsfluidsmoothedMatrix, b : PhysicsfluidsmoothedMatrix) -> PhysicsfluidsmoothedMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = physics_fluid_smoothed_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn physics_fluid_smoothed_matrix_scale(m : PhysicsfluidsmoothedMatrix, s : Double) -> PhysicsfluidsmoothedMatrix {
  let result = physics_fluid_smoothed_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn physics_fluid_smoothed_matrix_multiply(a : PhysicsfluidsmoothedMatrix, b : PhysicsfluidsmoothedMatrix) -> PhysicsfluidsmoothedMatrix {
  if a.cols != b.rows { return physics_fluid_smoothed_make_matrix(a.rows, b.cols, 0.0) }
  let result = physics_fluid_smoothed_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn physics_fluid_smoothed_matrix_trace(m : PhysicsfluidsmoothedMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn physics_fluid_smoothed_matrix_det(m : PhysicsfluidsmoothedMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn physics_fluid_smoothed_matrix_norm(m : PhysicsfluidsmoothedMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  physics_fluid_smoothed_sqrt(sum)
}

pub fn physics_fluid_smoothed_matrix_to_string(m : PhysicsfluidsmoothedMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + physics_fluid_smoothed_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct PhysicsfluidsmoothedVector {
  comps : Array[Double]
  dim : Int
}

pub fn physics_fluid_smoothed_make_vector(comps : Array[Double]) -> PhysicsfluidsmoothedVector {
  { comps, dim: comps.length() }
}

pub fn physics_fluid_smoothed_vector_zero(dim : Int) -> PhysicsfluidsmoothedVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn physics_fluid_smoothed_vector_add(a : PhysicsfluidsmoothedVector, b : PhysicsfluidsmoothedVector) -> PhysicsfluidsmoothedVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = physics_fluid_smoothed_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn physics_fluid_smoothed_vector_sub(a : PhysicsfluidsmoothedVector, b : PhysicsfluidsmoothedVector) -> PhysicsfluidsmoothedVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = physics_fluid_smoothed_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn physics_fluid_smoothed_vector_scale(v : PhysicsfluidsmoothedVector, s : Double) -> PhysicsfluidsmoothedVector {
  let mut result = []
  for i in 0..<v.dim { result = physics_fluid_smoothed_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn physics_fluid_smoothed_vector_dot(a : PhysicsfluidsmoothedVector, b : PhysicsfluidsmoothedVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn physics_fluid_smoothed_vector_norm(v : PhysicsfluidsmoothedVector) -> Double { physics_fluid_smoothed_sqrt(physics_fluid_smoothed_vector_dot(v, v)) }

pub fn physics_fluid_smoothed_vector_normalize(v : PhysicsfluidsmoothedVector) -> PhysicsfluidsmoothedVector {
  let n = physics_fluid_smoothed_vector_norm(v)
  if n < 0.0000001 { v } else { physics_fluid_smoothed_vector_scale(v, 1.0 / n) }
}

pub fn physics_fluid_smoothed_vector_dist(a : PhysicsfluidsmoothedVector, b : PhysicsfluidsmoothedVector) -> Double {
  physics_fluid_smoothed_vector_norm(physics_fluid_smoothed_vector_sub(a, b))
}

pub fn physics_fluid_smoothed_vector_to_string(v : PhysicsfluidsmoothedVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + physics_fluid_smoothed_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn physics_fluid_smoothed_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn physics_fluid_smoothed_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = physics_fluid_smoothed_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn physics_fluid_smoothed_std(data : Array[Double]) -> Double { physics_fluid_smoothed_sqrt(physics_fluid_smoothed_var(data)) }

pub fn physics_fluid_smoothed_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = physics_fluid_smoothed_mean(a); let mb = physics_fluid_smoothed_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn physics_fluid_smoothed_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = physics_fluid_smoothed_std(a); let sb = physics_fluid_smoothed_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { physics_fluid_smoothed_cov(a, b) / (sa * sb) }
}

pub fn physics_fluid_smoothed_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = physics_fluid_smoothed_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn physics_fluid_smoothed_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn physics_fluid_smoothed_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn physics_fluid_smoothed_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  physics_fluid_smoothed_sqrt(physics_fluid_smoothed_mse(pred, labels))
}

pub fn physics_fluid_smoothed_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + physics_fluid_smoothed_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn physics_fluid_smoothed_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = physics_fluid_smoothed_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn physics_fluid_smoothed_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn physics_fluid_smoothed_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn physics_fluid_smoothed_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = physics_fluid_smoothed_precision(pred, labels, pos); let r = physics_fluid_smoothed_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn physics_fluid_smoothed_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn physics_fluid_smoothed_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = physics_fluid_smoothed_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn physics_fluid_smoothed_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn physics_fluid_smoothed_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn physics_fluid_smoothed_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = physics_fluid_smoothed_gcd(a, b)
    (a / g) * b
  }
}

pub fn physics_fluid_smoothed_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn physics_fluid_smoothed_fibonacci(n : Int) -> Int {
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

pub fn physics_fluid_smoothed_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = physics_fluid_smoothed_min(data); let mx = physics_fluid_smoothed_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn physics_fluid_smoothed_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = physics_fluid_smoothed_mean(data); let sd = physics_fluid_smoothed_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn physics_fluid_smoothed_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn physics_fluid_smoothed_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn physics_fluid_smoothed_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn physics_fluid_smoothed_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn physics_fluid_smoothed_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn physics_fluid_smoothed_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn physics_fluid_smoothed_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn physics_fluid_smoothed_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn physics_fluid_smoothed_dbl(x : Double) -> String {
  let i = if x >= 0.0 { physics_fluid_smoothed_int(x) } else { -physics_fluid_smoothed_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { physics_fluid_smoothed_int(f * 1000000.0) } else { physics_fluid_smoothed_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn physics_fluid_smoothed_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn physics_fluid_smoothed_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct PhysicsfluidsmoothedFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_smoothed_frame_make(size : Int) -> PhysicsfluidsmoothedFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_smoothed_frame_len(s : PhysicsfluidsmoothedFrame) -> Int { s.size }

pub fn physics_fluid_smoothed_frame_get(s : PhysicsfluidsmoothedFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_smoothed_frame_set(s : PhysicsfluidsmoothedFrame, i : Int, v : Double) -> PhysicsfluidsmoothedFrame {
  let result = physics_fluid_smoothed_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_smoothed_frame_sum(s : PhysicsfluidsmoothedFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_fluid_smoothed_frame_mean(s : PhysicsfluidsmoothedFrame) -> Double {
  if s.size == 0 { 0.0 } else { physics_fluid_smoothed_frame_sum(s) / s.size.to_double() }
}

pub fn physics_fluid_smoothed_frame_scale(s : PhysicsfluidsmoothedFrame, f : Double) -> PhysicsfluidsmoothedFrame {
  let result = physics_fluid_smoothed_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_fluid_smoothed_frame_add(a : PhysicsfluidsmoothedFrame, b : PhysicsfluidsmoothedFrame) -> PhysicsfluidsmoothedFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_fluid_smoothed_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_fluid_smoothed_frame_copy(s : PhysicsfluidsmoothedFrame) -> PhysicsfluidsmoothedFrame {
  let result = physics_fluid_smoothed_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_fluid_smoothed_frame_fill(s : PhysicsfluidsmoothedFrame, v : Double) -> PhysicsfluidsmoothedFrame {
  let result = physics_fluid_smoothed_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_smoothed_frame_min(s : PhysicsfluidsmoothedFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_smoothed_frame_max(s : PhysicsfluidsmoothedFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_smoothed_frame_to_string(s : PhysicsfluidsmoothedFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidsmoothedTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_smoothed_table_make(size : Int) -> PhysicsfluidsmoothedTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_smoothed_table_len(s : PhysicsfluidsmoothedTable) -> Int { s.size }

pub fn physics_fluid_smoothed_table_get(s : PhysicsfluidsmoothedTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_smoothed_table_set(s : PhysicsfluidsmoothedTable, i : Int, v : Double) -> PhysicsfluidsmoothedTable {
  let result = physics_fluid_smoothed_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_smoothed_table_sum(s : PhysicsfluidsmoothedTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_fluid_smoothed_table_mean(s : PhysicsfluidsmoothedTable) -> Double {
  if s.size == 0 { 0.0 } else { physics_fluid_smoothed_table_sum(s) / s.size.to_double() }
}

pub fn physics_fluid_smoothed_table_scale(s : PhysicsfluidsmoothedTable, f : Double) -> PhysicsfluidsmoothedTable {
  let result = physics_fluid_smoothed_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_fluid_smoothed_table_add(a : PhysicsfluidsmoothedTable, b : PhysicsfluidsmoothedTable) -> PhysicsfluidsmoothedTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_fluid_smoothed_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_fluid_smoothed_table_copy(s : PhysicsfluidsmoothedTable) -> PhysicsfluidsmoothedTable {
  let result = physics_fluid_smoothed_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_fluid_smoothed_table_fill(s : PhysicsfluidsmoothedTable, v : Double) -> PhysicsfluidsmoothedTable {
  let result = physics_fluid_smoothed_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_smoothed_table_min(s : PhysicsfluidsmoothedTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_smoothed_table_max(s : PhysicsfluidsmoothedTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_smoothed_table_to_string(s : PhysicsfluidsmoothedTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidsmoothedGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_smoothed_graphn_make(size : Int) -> PhysicsfluidsmoothedGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_smoothed_graphn_len(s : PhysicsfluidsmoothedGraphN) -> Int { s.size }

pub fn physics_fluid_smoothed_graphn_get(s : PhysicsfluidsmoothedGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_smoothed_graphn_set(s : PhysicsfluidsmoothedGraphN, i : Int, v : Double) -> PhysicsfluidsmoothedGraphN {
  let result = physics_fluid_smoothed_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_smoothed_graphn_sum(s : PhysicsfluidsmoothedGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_fluid_smoothed_graphn_mean(s : PhysicsfluidsmoothedGraphN) -> Double {
  if s.size == 0 { 0.0 } else { physics_fluid_smoothed_graphn_sum(s) / s.size.to_double() }
}

pub fn physics_fluid_smoothed_graphn_scale(s : PhysicsfluidsmoothedGraphN, f : Double) -> PhysicsfluidsmoothedGraphN {
  let result = physics_fluid_smoothed_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_fluid_smoothed_graphn_add(a : PhysicsfluidsmoothedGraphN, b : PhysicsfluidsmoothedGraphN) -> PhysicsfluidsmoothedGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_fluid_smoothed_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_fluid_smoothed_graphn_copy(s : PhysicsfluidsmoothedGraphN) -> PhysicsfluidsmoothedGraphN {
  let result = physics_fluid_smoothed_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_fluid_smoothed_graphn_fill(s : PhysicsfluidsmoothedGraphN, v : Double) -> PhysicsfluidsmoothedGraphN {
  let result = physics_fluid_smoothed_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_smoothed_graphn_min(s : PhysicsfluidsmoothedGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_smoothed_graphn_max(s : PhysicsfluidsmoothedGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_smoothed_graphn_to_string(s : PhysicsfluidsmoothedGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidsmoothedNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_smoothed_node_make(size : Int) -> PhysicsfluidsmoothedNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_smoothed_node_len(s : PhysicsfluidsmoothedNode) -> Int { s.size }

pub fn physics_fluid_smoothed_node_get(s : PhysicsfluidsmoothedNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_smoothed_node_set(s : PhysicsfluidsmoothedNode, i : Int, v : Double) -> PhysicsfluidsmoothedNode {
  let result = physics_fluid_smoothed_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_smoothed_node_sum(s : PhysicsfluidsmoothedNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_fluid_smoothed_node_mean(s : PhysicsfluidsmoothedNode) -> Double {
  if s.size == 0 { 0.0 } else { physics_fluid_smoothed_node_sum(s) / s.size.to_double() }
}

pub fn physics_fluid_smoothed_node_scale(s : PhysicsfluidsmoothedNode, f : Double) -> PhysicsfluidsmoothedNode {
  let result = physics_fluid_smoothed_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_fluid_smoothed_node_add(a : PhysicsfluidsmoothedNode, b : PhysicsfluidsmoothedNode) -> PhysicsfluidsmoothedNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_fluid_smoothed_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_fluid_smoothed_node_copy(s : PhysicsfluidsmoothedNode) -> PhysicsfluidsmoothedNode {
  let result = physics_fluid_smoothed_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_fluid_smoothed_node_fill(s : PhysicsfluidsmoothedNode, v : Double) -> PhysicsfluidsmoothedNode {
  let result = physics_fluid_smoothed_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_smoothed_node_min(s : PhysicsfluidsmoothedNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_smoothed_node_max(s : PhysicsfluidsmoothedNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_smoothed_node_to_string(s : PhysicsfluidsmoothedNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidsmoothedEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_smoothed_edge_make(size : Int) -> PhysicsfluidsmoothedEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_smoothed_edge_len(s : PhysicsfluidsmoothedEdge) -> Int { s.size }

pub fn physics_fluid_smoothed_edge_get(s : PhysicsfluidsmoothedEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_smoothed_edge_set(s : PhysicsfluidsmoothedEdge, i : Int, v : Double) -> PhysicsfluidsmoothedEdge {
  let result = physics_fluid_smoothed_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_smoothed_edge_sum(s : PhysicsfluidsmoothedEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_fluid_smoothed_edge_mean(s : PhysicsfluidsmoothedEdge) -> Double {
  if s.size == 0 { 0.0 } else { physics_fluid_smoothed_edge_sum(s) / s.size.to_double() }
}

pub fn physics_fluid_smoothed_edge_scale(s : PhysicsfluidsmoothedEdge, f : Double) -> PhysicsfluidsmoothedEdge {
  let result = physics_fluid_smoothed_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_fluid_smoothed_edge_add(a : PhysicsfluidsmoothedEdge, b : PhysicsfluidsmoothedEdge) -> PhysicsfluidsmoothedEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_fluid_smoothed_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_fluid_smoothed_edge_copy(s : PhysicsfluidsmoothedEdge) -> PhysicsfluidsmoothedEdge {
  let result = physics_fluid_smoothed_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_fluid_smoothed_edge_fill(s : PhysicsfluidsmoothedEdge, v : Double) -> PhysicsfluidsmoothedEdge {
  let result = physics_fluid_smoothed_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_smoothed_edge_min(s : PhysicsfluidsmoothedEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_smoothed_edge_max(s : PhysicsfluidsmoothedEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_smoothed_edge_to_string(s : PhysicsfluidsmoothedEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidsmoothedPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_smoothed_path_make(size : Int) -> PhysicsfluidsmoothedPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_smoothed_path_len(s : PhysicsfluidsmoothedPath) -> Int { s.size }

pub fn physics_fluid_smoothed_path_get(s : PhysicsfluidsmoothedPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_smoothed_path_set(s : PhysicsfluidsmoothedPath, i : Int, v : Double) -> PhysicsfluidsmoothedPath {
  let result = physics_fluid_smoothed_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_smoothed_path_sum(s : PhysicsfluidsmoothedPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_fluid_smoothed_path_mean(s : PhysicsfluidsmoothedPath) -> Double {
  if s.size == 0 { 0.0 } else { physics_fluid_smoothed_path_sum(s) / s.size.to_double() }
}

pub fn physics_fluid_smoothed_path_scale(s : PhysicsfluidsmoothedPath, f : Double) -> PhysicsfluidsmoothedPath {
  let result = physics_fluid_smoothed_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_fluid_smoothed_path_add(a : PhysicsfluidsmoothedPath, b : PhysicsfluidsmoothedPath) -> PhysicsfluidsmoothedPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_fluid_smoothed_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_fluid_smoothed_path_copy(s : PhysicsfluidsmoothedPath) -> PhysicsfluidsmoothedPath {
  let result = physics_fluid_smoothed_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_fluid_smoothed_path_fill(s : PhysicsfluidsmoothedPath, v : Double) -> PhysicsfluidsmoothedPath {
  let result = physics_fluid_smoothed_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_smoothed_path_min(s : PhysicsfluidsmoothedPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_smoothed_path_max(s : PhysicsfluidsmoothedPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_smoothed_path_to_string(s : PhysicsfluidsmoothedPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidsmoothedCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_smoothed_cluster_make(size : Int) -> PhysicsfluidsmoothedCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_smoothed_cluster_len(s : PhysicsfluidsmoothedCluster) -> Int { s.size }

pub fn physics_fluid_smoothed_cluster_get(s : PhysicsfluidsmoothedCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_smoothed_cluster_set(s : PhysicsfluidsmoothedCluster, i : Int, v : Double) -> PhysicsfluidsmoothedCluster {
  let result = physics_fluid_smoothed_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_smoothed_cluster_sum(s : PhysicsfluidsmoothedCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_fluid_smoothed_cluster_mean(s : PhysicsfluidsmoothedCluster) -> Double {
  if s.size == 0 { 0.0 } else { physics_fluid_smoothed_cluster_sum(s) / s.size.to_double() }
}

pub fn physics_fluid_smoothed_cluster_scale(s : PhysicsfluidsmoothedCluster, f : Double) -> PhysicsfluidsmoothedCluster {
  let result = physics_fluid_smoothed_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_fluid_smoothed_cluster_add(a : PhysicsfluidsmoothedCluster, b : PhysicsfluidsmoothedCluster) -> PhysicsfluidsmoothedCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_fluid_smoothed_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_fluid_smoothed_cluster_copy(s : PhysicsfluidsmoothedCluster) -> PhysicsfluidsmoothedCluster {
  let result = physics_fluid_smoothed_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_fluid_smoothed_cluster_fill(s : PhysicsfluidsmoothedCluster, v : Double) -> PhysicsfluidsmoothedCluster {
  let result = physics_fluid_smoothed_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_smoothed_cluster_min(s : PhysicsfluidsmoothedCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_smoothed_cluster_max(s : PhysicsfluidsmoothedCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_smoothed_cluster_to_string(s : PhysicsfluidsmoothedCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidsmoothedModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_smoothed_model_make(size : Int) -> PhysicsfluidsmoothedModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_smoothed_model_len(s : PhysicsfluidsmoothedModel) -> Int { s.size }

pub fn physics_fluid_smoothed_model_get(s : PhysicsfluidsmoothedModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_smoothed_model_set(s : PhysicsfluidsmoothedModel, i : Int, v : Double) -> PhysicsfluidsmoothedModel {
  let result = physics_fluid_smoothed_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_smoothed_model_sum(s : PhysicsfluidsmoothedModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_fluid_smoothed_model_mean(s : PhysicsfluidsmoothedModel) -> Double {
  if s.size == 0 { 0.0 } else { physics_fluid_smoothed_model_sum(s) / s.size.to_double() }
}

pub fn physics_fluid_smoothed_model_scale(s : PhysicsfluidsmoothedModel, f : Double) -> PhysicsfluidsmoothedModel {
  let result = physics_fluid_smoothed_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_fluid_smoothed_model_add(a : PhysicsfluidsmoothedModel, b : PhysicsfluidsmoothedModel) -> PhysicsfluidsmoothedModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_fluid_smoothed_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_fluid_smoothed_model_copy(s : PhysicsfluidsmoothedModel) -> PhysicsfluidsmoothedModel {
  let result = physics_fluid_smoothed_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_fluid_smoothed_model_fill(s : PhysicsfluidsmoothedModel, v : Double) -> PhysicsfluidsmoothedModel {
  let result = physics_fluid_smoothed_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_smoothed_model_min(s : PhysicsfluidsmoothedModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_smoothed_model_max(s : PhysicsfluidsmoothedModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_smoothed_model_to_string(s : PhysicsfluidsmoothedModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidsmoothedLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_smoothed_layer_make(size : Int) -> PhysicsfluidsmoothedLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_smoothed_layer_len(s : PhysicsfluidsmoothedLayer) -> Int { s.size }

pub fn physics_fluid_smoothed_layer_get(s : PhysicsfluidsmoothedLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_smoothed_layer_set(s : PhysicsfluidsmoothedLayer, i : Int, v : Double) -> PhysicsfluidsmoothedLayer {
  let result = physics_fluid_smoothed_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_smoothed_layer_sum(s : PhysicsfluidsmoothedLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_fluid_smoothed_layer_mean(s : PhysicsfluidsmoothedLayer) -> Double {
  if s.size == 0 { 0.0 } else { physics_fluid_smoothed_layer_sum(s) / s.size.to_double() }
}

pub fn physics_fluid_smoothed_layer_scale(s : PhysicsfluidsmoothedLayer, f : Double) -> PhysicsfluidsmoothedLayer {
  let result = physics_fluid_smoothed_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_fluid_smoothed_layer_add(a : PhysicsfluidsmoothedLayer, b : PhysicsfluidsmoothedLayer) -> PhysicsfluidsmoothedLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_fluid_smoothed_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_fluid_smoothed_layer_copy(s : PhysicsfluidsmoothedLayer) -> PhysicsfluidsmoothedLayer {
  let result = physics_fluid_smoothed_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_fluid_smoothed_layer_fill(s : PhysicsfluidsmoothedLayer, v : Double) -> PhysicsfluidsmoothedLayer {
  let result = physics_fluid_smoothed_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_smoothed_layer_min(s : PhysicsfluidsmoothedLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_smoothed_layer_max(s : PhysicsfluidsmoothedLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_smoothed_layer_to_string(s : PhysicsfluidsmoothedLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidsmoothedBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_smoothed_buffer_make(size : Int) -> PhysicsfluidsmoothedBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_smoothed_buffer_len(s : PhysicsfluidsmoothedBuffer) -> Int { s.size }

pub fn physics_fluid_smoothed_buffer_get(s : PhysicsfluidsmoothedBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_smoothed_buffer_set(s : PhysicsfluidsmoothedBuffer, i : Int, v : Double) -> PhysicsfluidsmoothedBuffer {
  let result = physics_fluid_smoothed_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_smoothed_buffer_sum(s : PhysicsfluidsmoothedBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_fluid_smoothed_buffer_mean(s : PhysicsfluidsmoothedBuffer) -> Double {
  if s.size == 0 { 0.0 } else { physics_fluid_smoothed_buffer_sum(s) / s.size.to_double() }
}

pub fn physics_fluid_smoothed_buffer_scale(s : PhysicsfluidsmoothedBuffer, f : Double) -> PhysicsfluidsmoothedBuffer {
  let result = physics_fluid_smoothed_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_fluid_smoothed_buffer_add(a : PhysicsfluidsmoothedBuffer, b : PhysicsfluidsmoothedBuffer) -> PhysicsfluidsmoothedBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_fluid_smoothed_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_fluid_smoothed_buffer_copy(s : PhysicsfluidsmoothedBuffer) -> PhysicsfluidsmoothedBuffer {
  let result = physics_fluid_smoothed_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_fluid_smoothed_buffer_fill(s : PhysicsfluidsmoothedBuffer, v : Double) -> PhysicsfluidsmoothedBuffer {
  let result = physics_fluid_smoothed_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_smoothed_buffer_min(s : PhysicsfluidsmoothedBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_smoothed_buffer_max(s : PhysicsfluidsmoothedBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_smoothed_buffer_to_string(s : PhysicsfluidsmoothedBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidsmoothedCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_smoothed_cursor_make(size : Int) -> PhysicsfluidsmoothedCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_smoothed_cursor_len(s : PhysicsfluidsmoothedCursor) -> Int { s.size }

pub fn physics_fluid_smoothed_cursor_get(s : PhysicsfluidsmoothedCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_smoothed_cursor_set(s : PhysicsfluidsmoothedCursor, i : Int, v : Double) -> PhysicsfluidsmoothedCursor {
  let result = physics_fluid_smoothed_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_smoothed_cursor_sum(s : PhysicsfluidsmoothedCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_fluid_smoothed_cursor_mean(s : PhysicsfluidsmoothedCursor) -> Double {
  if s.size == 0 { 0.0 } else { physics_fluid_smoothed_cursor_sum(s) / s.size.to_double() }
}

pub fn physics_fluid_smoothed_cursor_scale(s : PhysicsfluidsmoothedCursor, f : Double) -> PhysicsfluidsmoothedCursor {
  let result = physics_fluid_smoothed_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_fluid_smoothed_cursor_add(a : PhysicsfluidsmoothedCursor, b : PhysicsfluidsmoothedCursor) -> PhysicsfluidsmoothedCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_fluid_smoothed_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_fluid_smoothed_cursor_copy(s : PhysicsfluidsmoothedCursor) -> PhysicsfluidsmoothedCursor {
  let result = physics_fluid_smoothed_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_fluid_smoothed_cursor_fill(s : PhysicsfluidsmoothedCursor, v : Double) -> PhysicsfluidsmoothedCursor {
  let result = physics_fluid_smoothed_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_smoothed_cursor_min(s : PhysicsfluidsmoothedCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_smoothed_cursor_max(s : PhysicsfluidsmoothedCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_smoothed_cursor_to_string(s : PhysicsfluidsmoothedCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidsmoothedView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_smoothed_view_make(size : Int) -> PhysicsfluidsmoothedView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_smoothed_view_len(s : PhysicsfluidsmoothedView) -> Int { s.size }

pub fn physics_fluid_smoothed_view_get(s : PhysicsfluidsmoothedView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_smoothed_view_set(s : PhysicsfluidsmoothedView, i : Int, v : Double) -> PhysicsfluidsmoothedView {
  let result = physics_fluid_smoothed_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_smoothed_view_sum(s : PhysicsfluidsmoothedView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_fluid_smoothed_view_mean(s : PhysicsfluidsmoothedView) -> Double {
  if s.size == 0 { 0.0 } else { physics_fluid_smoothed_view_sum(s) / s.size.to_double() }
}

pub fn physics_fluid_smoothed_view_scale(s : PhysicsfluidsmoothedView, f : Double) -> PhysicsfluidsmoothedView {
  let result = physics_fluid_smoothed_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_fluid_smoothed_view_add(a : PhysicsfluidsmoothedView, b : PhysicsfluidsmoothedView) -> PhysicsfluidsmoothedView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_fluid_smoothed_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_fluid_smoothed_view_copy(s : PhysicsfluidsmoothedView) -> PhysicsfluidsmoothedView {
  let result = physics_fluid_smoothed_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_fluid_smoothed_view_fill(s : PhysicsfluidsmoothedView, v : Double) -> PhysicsfluidsmoothedView {
  let result = physics_fluid_smoothed_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_smoothed_view_min(s : PhysicsfluidsmoothedView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_smoothed_view_max(s : PhysicsfluidsmoothedView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_smoothed_view_to_string(s : PhysicsfluidsmoothedView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidsmoothedRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_smoothed_range_make(size : Int) -> PhysicsfluidsmoothedRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_smoothed_range_len(s : PhysicsfluidsmoothedRange) -> Int { s.size }

pub fn physics_fluid_smoothed_range_get(s : PhysicsfluidsmoothedRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_smoothed_range_set(s : PhysicsfluidsmoothedRange, i : Int, v : Double) -> PhysicsfluidsmoothedRange {
  let result = physics_fluid_smoothed_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_smoothed_range_sum(s : PhysicsfluidsmoothedRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_fluid_smoothed_range_mean(s : PhysicsfluidsmoothedRange) -> Double {
  if s.size == 0 { 0.0 } else { physics_fluid_smoothed_range_sum(s) / s.size.to_double() }
}

pub fn physics_fluid_smoothed_range_scale(s : PhysicsfluidsmoothedRange, f : Double) -> PhysicsfluidsmoothedRange {
  let result = physics_fluid_smoothed_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_fluid_smoothed_range_add(a : PhysicsfluidsmoothedRange, b : PhysicsfluidsmoothedRange) -> PhysicsfluidsmoothedRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_fluid_smoothed_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_fluid_smoothed_range_copy(s : PhysicsfluidsmoothedRange) -> PhysicsfluidsmoothedRange {
  let result = physics_fluid_smoothed_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_fluid_smoothed_range_fill(s : PhysicsfluidsmoothedRange, v : Double) -> PhysicsfluidsmoothedRange {
  let result = physics_fluid_smoothed_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_smoothed_range_min(s : PhysicsfluidsmoothedRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_smoothed_range_max(s : PhysicsfluidsmoothedRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_smoothed_range_to_string(s : PhysicsfluidsmoothedRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidsmoothedSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_smoothed_slice_make(size : Int) -> PhysicsfluidsmoothedSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_smoothed_slice_len(s : PhysicsfluidsmoothedSlice) -> Int { s.size }

pub fn physics_fluid_smoothed_slice_get(s : PhysicsfluidsmoothedSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_smoothed_slice_set(s : PhysicsfluidsmoothedSlice, i : Int, v : Double) -> PhysicsfluidsmoothedSlice {
  let result = physics_fluid_smoothed_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_smoothed_slice_sum(s : PhysicsfluidsmoothedSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_fluid_smoothed_slice_mean(s : PhysicsfluidsmoothedSlice) -> Double {
  if s.size == 0 { 0.0 } else { physics_fluid_smoothed_slice_sum(s) / s.size.to_double() }
}

pub fn physics_fluid_smoothed_slice_scale(s : PhysicsfluidsmoothedSlice, f : Double) -> PhysicsfluidsmoothedSlice {
  let result = physics_fluid_smoothed_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_fluid_smoothed_slice_add(a : PhysicsfluidsmoothedSlice, b : PhysicsfluidsmoothedSlice) -> PhysicsfluidsmoothedSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_fluid_smoothed_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_fluid_smoothed_slice_copy(s : PhysicsfluidsmoothedSlice) -> PhysicsfluidsmoothedSlice {
  let result = physics_fluid_smoothed_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_fluid_smoothed_slice_fill(s : PhysicsfluidsmoothedSlice, v : Double) -> PhysicsfluidsmoothedSlice {
  let result = physics_fluid_smoothed_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_smoothed_slice_min(s : PhysicsfluidsmoothedSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_smoothed_slice_max(s : PhysicsfluidsmoothedSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_smoothed_slice_to_string(s : PhysicsfluidsmoothedSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn physics_fluid_smoothed_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_fluid_smoothed_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_fluid_smoothed_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_fluid_smoothed_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_fluid_smoothed_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_fluid_smoothed_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_fluid_smoothed_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_fluid_smoothed_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_fluid_smoothed_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_fluid_smoothed_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_fluid_smoothed_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_fluid_smoothed_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_fluid_smoothed_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_fluid_smoothed_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_fluid_smoothed_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_fluid_smoothed_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_fluid_smoothed_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_fluid_smoothed_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_fluid_smoothed_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_fluid_smoothed_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_fluid_smoothed_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_fluid_smoothed_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_fluid_smoothed_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_fluid_smoothed_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_fluid_smoothed_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

