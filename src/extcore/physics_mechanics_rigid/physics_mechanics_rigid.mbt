///===
/// extcore/physics_mechanics_rigid

pub(all) struct PhysicsmechanicsrigidPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn physics_mechanics_rigid_make_point(x : Double, y : Double) -> PhysicsmechanicsrigidPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn physics_mechanics_rigid_make_point3(x : Double, y : Double, z : Double) -> PhysicsmechanicsrigidPoint {
  { x, y, z, label: 0 }
}

pub fn physics_mechanics_rigid_point_x(pt : PhysicsmechanicsrigidPoint) -> Double { pt.x }

pub fn physics_mechanics_rigid_point_y(pt : PhysicsmechanicsrigidPoint) -> Double { pt.y }

pub fn physics_mechanics_rigid_point_z(pt : PhysicsmechanicsrigidPoint) -> Double { pt.z }

pub fn physics_mechanics_rigid_point_label(pt : PhysicsmechanicsrigidPoint) -> Int { pt.label }

pub fn physics_mechanics_rigid_point_dist(a : PhysicsmechanicsrigidPoint, b : PhysicsmechanicsrigidPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  physics_mechanics_rigid_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn physics_mechanics_rigid_point_add(a : PhysicsmechanicsrigidPoint, b : PhysicsmechanicsrigidPoint) -> PhysicsmechanicsrigidPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn physics_mechanics_rigid_point_sub(a : PhysicsmechanicsrigidPoint, b : PhysicsmechanicsrigidPoint) -> PhysicsmechanicsrigidPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn physics_mechanics_rigid_point_scale(pt : PhysicsmechanicsrigidPoint, s : Double) -> PhysicsmechanicsrigidPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn physics_mechanics_rigid_point_dot(a : PhysicsmechanicsrigidPoint, b : PhysicsmechanicsrigidPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn physics_mechanics_rigid_point_cross(a : PhysicsmechanicsrigidPoint, b : PhysicsmechanicsrigidPoint) -> PhysicsmechanicsrigidPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn physics_mechanics_rigid_point_norm(pt : PhysicsmechanicsrigidPoint) -> Double {
  physics_mechanics_rigid_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn physics_mechanics_rigid_point_normalize(pt : PhysicsmechanicsrigidPoint) -> PhysicsmechanicsrigidPoint {
  let n = physics_mechanics_rigid_point_norm(pt)
  if n < 0.0000001 { pt } else { physics_mechanics_rigid_point_scale(pt, 1.0 / n) }
}

pub fn physics_mechanics_rigid_point_negate(pt : PhysicsmechanicsrigidPoint) -> PhysicsmechanicsrigidPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn physics_mechanics_rigid_point_mid(a : PhysicsmechanicsrigidPoint, b : PhysicsmechanicsrigidPoint) -> PhysicsmechanicsrigidPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn physics_mechanics_rigid_point_lerp(a : PhysicsmechanicsrigidPoint, b : PhysicsmechanicsrigidPoint, t : Double) -> PhysicsmechanicsrigidPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn physics_mechanics_rigid_point_to_string(pt : PhysicsmechanicsrigidPoint) -> String {
  "(" + physics_mechanics_rigid_dbl(pt.x) + ", " + physics_mechanics_rigid_dbl(pt.y) + ", " + physics_mechanics_rigid_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct PhysicsmechanicsrigidSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn physics_mechanics_rigid_make_series(vals : Array[Double], name : String) -> PhysicsmechanicsrigidSeries {
  { vals, name, meta: 0 }
}

pub fn physics_mechanics_rigid_series_len(s : PhysicsmechanicsrigidSeries) -> Int { s.vals.length() }

pub fn physics_mechanics_rigid_series_sum(s : PhysicsmechanicsrigidSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn physics_mechanics_rigid_series_mean(s : PhysicsmechanicsrigidSeries) -> Double {
  let n = physics_mechanics_rigid_series_len(s)
  if n == 0 { 0.0 } else { physics_mechanics_rigid_series_sum(s) / n.to_double() }
}

pub fn physics_mechanics_rigid_series_min(s : PhysicsmechanicsrigidSeries) -> Double {
  let n = physics_mechanics_rigid_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn physics_mechanics_rigid_series_max(s : PhysicsmechanicsrigidSeries) -> Double {
  let n = physics_mechanics_rigid_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn physics_mechanics_rigid_series_range(s : PhysicsmechanicsrigidSeries) -> Double {
  physics_mechanics_rigid_series_max(s) - physics_mechanics_rigid_series_min(s)
}

pub fn physics_mechanics_rigid_series_var(s : PhysicsmechanicsrigidSeries) -> Double {
  let n = physics_mechanics_rigid_series_len(s)
  if n == 0 { 0.0 } else {
    let m = physics_mechanics_rigid_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn physics_mechanics_rigid_series_std(s : PhysicsmechanicsrigidSeries) -> Double { physics_mechanics_rigid_sqrt(physics_mechanics_rigid_series_var(s)) }

pub fn physics_mechanics_rigid_series_median(s : PhysicsmechanicsrigidSeries) -> Double {
  let n = physics_mechanics_rigid_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = physics_mechanics_rigid_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn physics_mechanics_rigid_series_scale(s : PhysicsmechanicsrigidSeries, f : Double) -> PhysicsmechanicsrigidSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = physics_mechanics_rigid_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn physics_mechanics_rigid_series_add(a : PhysicsmechanicsrigidSeries, b : PhysicsmechanicsrigidSeries) -> PhysicsmechanicsrigidSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = physics_mechanics_rigid_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn physics_mechanics_rigid_series_sub(a : PhysicsmechanicsrigidSeries, b : PhysicsmechanicsrigidSeries) -> PhysicsmechanicsrigidSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = physics_mechanics_rigid_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn physics_mechanics_rigid_series_normalize(s : PhysicsmechanicsrigidSeries) -> PhysicsmechanicsrigidSeries {
  let mn = physics_mechanics_rigid_series_min(s)
  let mx = physics_mechanics_rigid_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = physics_mechanics_rigid_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn physics_mechanics_rigid_series_cumsum(s : PhysicsmechanicsrigidSeries) -> PhysicsmechanicsrigidSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = physics_mechanics_rigid_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn physics_mechanics_rigid_series_to_string(s : PhysicsmechanicsrigidSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + physics_mechanics_rigid_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct PhysicsmechanicsrigidMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn physics_mechanics_rigid_make_matrix(rows : Int, cols : Int, val : Double) -> PhysicsmechanicsrigidMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn physics_mechanics_rigid_matrix_identity(n : Int) -> PhysicsmechanicsrigidMatrix {
  let m = physics_mechanics_rigid_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn physics_mechanics_rigid_matrix_get(m : PhysicsmechanicsrigidMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn physics_mechanics_rigid_matrix_transpose(m : PhysicsmechanicsrigidMatrix) -> PhysicsmechanicsrigidMatrix {
  let result = physics_mechanics_rigid_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn physics_mechanics_rigid_matrix_add(a : PhysicsmechanicsrigidMatrix, b : PhysicsmechanicsrigidMatrix) -> PhysicsmechanicsrigidMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = physics_mechanics_rigid_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn physics_mechanics_rigid_matrix_scale(m : PhysicsmechanicsrigidMatrix, s : Double) -> PhysicsmechanicsrigidMatrix {
  let result = physics_mechanics_rigid_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn physics_mechanics_rigid_matrix_multiply(a : PhysicsmechanicsrigidMatrix, b : PhysicsmechanicsrigidMatrix) -> PhysicsmechanicsrigidMatrix {
  if a.cols != b.rows { return physics_mechanics_rigid_make_matrix(a.rows, b.cols, 0.0) }
  let result = physics_mechanics_rigid_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn physics_mechanics_rigid_matrix_trace(m : PhysicsmechanicsrigidMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn physics_mechanics_rigid_matrix_det(m : PhysicsmechanicsrigidMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn physics_mechanics_rigid_matrix_norm(m : PhysicsmechanicsrigidMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  physics_mechanics_rigid_sqrt(sum)
}

pub fn physics_mechanics_rigid_matrix_to_string(m : PhysicsmechanicsrigidMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + physics_mechanics_rigid_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct PhysicsmechanicsrigidVector {
  comps : Array[Double]
  dim : Int
}

pub fn physics_mechanics_rigid_make_vector(comps : Array[Double]) -> PhysicsmechanicsrigidVector {
  { comps, dim: comps.length() }
}

pub fn physics_mechanics_rigid_vector_zero(dim : Int) -> PhysicsmechanicsrigidVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn physics_mechanics_rigid_vector_add(a : PhysicsmechanicsrigidVector, b : PhysicsmechanicsrigidVector) -> PhysicsmechanicsrigidVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = physics_mechanics_rigid_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn physics_mechanics_rigid_vector_sub(a : PhysicsmechanicsrigidVector, b : PhysicsmechanicsrigidVector) -> PhysicsmechanicsrigidVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = physics_mechanics_rigid_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn physics_mechanics_rigid_vector_scale(v : PhysicsmechanicsrigidVector, s : Double) -> PhysicsmechanicsrigidVector {
  let mut result = []
  for i in 0..<v.dim { result = physics_mechanics_rigid_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn physics_mechanics_rigid_vector_dot(a : PhysicsmechanicsrigidVector, b : PhysicsmechanicsrigidVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn physics_mechanics_rigid_vector_norm(v : PhysicsmechanicsrigidVector) -> Double { physics_mechanics_rigid_sqrt(physics_mechanics_rigid_vector_dot(v, v)) }

pub fn physics_mechanics_rigid_vector_normalize(v : PhysicsmechanicsrigidVector) -> PhysicsmechanicsrigidVector {
  let n = physics_mechanics_rigid_vector_norm(v)
  if n < 0.0000001 { v } else { physics_mechanics_rigid_vector_scale(v, 1.0 / n) }
}

pub fn physics_mechanics_rigid_vector_dist(a : PhysicsmechanicsrigidVector, b : PhysicsmechanicsrigidVector) -> Double {
  physics_mechanics_rigid_vector_norm(physics_mechanics_rigid_vector_sub(a, b))
}

pub fn physics_mechanics_rigid_vector_to_string(v : PhysicsmechanicsrigidVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + physics_mechanics_rigid_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn physics_mechanics_rigid_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn physics_mechanics_rigid_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = physics_mechanics_rigid_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn physics_mechanics_rigid_std(data : Array[Double]) -> Double { physics_mechanics_rigid_sqrt(physics_mechanics_rigid_var(data)) }

pub fn physics_mechanics_rigid_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = physics_mechanics_rigid_mean(a); let mb = physics_mechanics_rigid_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn physics_mechanics_rigid_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = physics_mechanics_rigid_std(a); let sb = physics_mechanics_rigid_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { physics_mechanics_rigid_cov(a, b) / (sa * sb) }
}

pub fn physics_mechanics_rigid_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = physics_mechanics_rigid_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn physics_mechanics_rigid_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn physics_mechanics_rigid_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn physics_mechanics_rigid_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  physics_mechanics_rigid_sqrt(physics_mechanics_rigid_mse(pred, labels))
}

pub fn physics_mechanics_rigid_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + physics_mechanics_rigid_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn physics_mechanics_rigid_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = physics_mechanics_rigid_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn physics_mechanics_rigid_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn physics_mechanics_rigid_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn physics_mechanics_rigid_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = physics_mechanics_rigid_precision(pred, labels, pos); let r = physics_mechanics_rigid_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn physics_mechanics_rigid_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn physics_mechanics_rigid_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = physics_mechanics_rigid_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn physics_mechanics_rigid_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn physics_mechanics_rigid_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn physics_mechanics_rigid_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = physics_mechanics_rigid_gcd(a, b)
    (a / g) * b
  }
}

pub fn physics_mechanics_rigid_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn physics_mechanics_rigid_fibonacci(n : Int) -> Int {
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

pub fn physics_mechanics_rigid_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = physics_mechanics_rigid_min(data); let mx = physics_mechanics_rigid_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn physics_mechanics_rigid_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = physics_mechanics_rigid_mean(data); let sd = physics_mechanics_rigid_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn physics_mechanics_rigid_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn physics_mechanics_rigid_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn physics_mechanics_rigid_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn physics_mechanics_rigid_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn physics_mechanics_rigid_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn physics_mechanics_rigid_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn physics_mechanics_rigid_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn physics_mechanics_rigid_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn physics_mechanics_rigid_dbl(x : Double) -> String {
  let i = if x >= 0.0 { physics_mechanics_rigid_int(x) } else { -physics_mechanics_rigid_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { physics_mechanics_rigid_int(f * 1000000.0) } else { physics_mechanics_rigid_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn physics_mechanics_rigid_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn physics_mechanics_rigid_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct PhysicsmechanicsrigidFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_rigid_frame_make(size : Int) -> PhysicsmechanicsrigidFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_rigid_frame_len(s : PhysicsmechanicsrigidFrame) -> Int { s.size }

pub fn physics_mechanics_rigid_frame_get(s : PhysicsmechanicsrigidFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_rigid_frame_set(s : PhysicsmechanicsrigidFrame, i : Int, v : Double) -> PhysicsmechanicsrigidFrame {
  let result = physics_mechanics_rigid_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_rigid_frame_sum(s : PhysicsmechanicsrigidFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_mechanics_rigid_frame_mean(s : PhysicsmechanicsrigidFrame) -> Double {
  if s.size == 0 { 0.0 } else { physics_mechanics_rigid_frame_sum(s) / s.size.to_double() }
}

pub fn physics_mechanics_rigid_frame_scale(s : PhysicsmechanicsrigidFrame, f : Double) -> PhysicsmechanicsrigidFrame {
  let result = physics_mechanics_rigid_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_mechanics_rigid_frame_add(a : PhysicsmechanicsrigidFrame, b : PhysicsmechanicsrigidFrame) -> PhysicsmechanicsrigidFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_mechanics_rigid_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_mechanics_rigid_frame_copy(s : PhysicsmechanicsrigidFrame) -> PhysicsmechanicsrigidFrame {
  let result = physics_mechanics_rigid_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_mechanics_rigid_frame_fill(s : PhysicsmechanicsrigidFrame, v : Double) -> PhysicsmechanicsrigidFrame {
  let result = physics_mechanics_rigid_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_rigid_frame_min(s : PhysicsmechanicsrigidFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_rigid_frame_max(s : PhysicsmechanicsrigidFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_rigid_frame_to_string(s : PhysicsmechanicsrigidFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsrigidTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_rigid_table_make(size : Int) -> PhysicsmechanicsrigidTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_rigid_table_len(s : PhysicsmechanicsrigidTable) -> Int { s.size }

pub fn physics_mechanics_rigid_table_get(s : PhysicsmechanicsrigidTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_rigid_table_set(s : PhysicsmechanicsrigidTable, i : Int, v : Double) -> PhysicsmechanicsrigidTable {
  let result = physics_mechanics_rigid_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_rigid_table_sum(s : PhysicsmechanicsrigidTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_mechanics_rigid_table_mean(s : PhysicsmechanicsrigidTable) -> Double {
  if s.size == 0 { 0.0 } else { physics_mechanics_rigid_table_sum(s) / s.size.to_double() }
}

pub fn physics_mechanics_rigid_table_scale(s : PhysicsmechanicsrigidTable, f : Double) -> PhysicsmechanicsrigidTable {
  let result = physics_mechanics_rigid_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_mechanics_rigid_table_add(a : PhysicsmechanicsrigidTable, b : PhysicsmechanicsrigidTable) -> PhysicsmechanicsrigidTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_mechanics_rigid_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_mechanics_rigid_table_copy(s : PhysicsmechanicsrigidTable) -> PhysicsmechanicsrigidTable {
  let result = physics_mechanics_rigid_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_mechanics_rigid_table_fill(s : PhysicsmechanicsrigidTable, v : Double) -> PhysicsmechanicsrigidTable {
  let result = physics_mechanics_rigid_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_rigid_table_min(s : PhysicsmechanicsrigidTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_rigid_table_max(s : PhysicsmechanicsrigidTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_rigid_table_to_string(s : PhysicsmechanicsrigidTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsrigidGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_rigid_graphn_make(size : Int) -> PhysicsmechanicsrigidGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_rigid_graphn_len(s : PhysicsmechanicsrigidGraphN) -> Int { s.size }

pub fn physics_mechanics_rigid_graphn_get(s : PhysicsmechanicsrigidGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_rigid_graphn_set(s : PhysicsmechanicsrigidGraphN, i : Int, v : Double) -> PhysicsmechanicsrigidGraphN {
  let result = physics_mechanics_rigid_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_rigid_graphn_sum(s : PhysicsmechanicsrigidGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_mechanics_rigid_graphn_mean(s : PhysicsmechanicsrigidGraphN) -> Double {
  if s.size == 0 { 0.0 } else { physics_mechanics_rigid_graphn_sum(s) / s.size.to_double() }
}

pub fn physics_mechanics_rigid_graphn_scale(s : PhysicsmechanicsrigidGraphN, f : Double) -> PhysicsmechanicsrigidGraphN {
  let result = physics_mechanics_rigid_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_mechanics_rigid_graphn_add(a : PhysicsmechanicsrigidGraphN, b : PhysicsmechanicsrigidGraphN) -> PhysicsmechanicsrigidGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_mechanics_rigid_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_mechanics_rigid_graphn_copy(s : PhysicsmechanicsrigidGraphN) -> PhysicsmechanicsrigidGraphN {
  let result = physics_mechanics_rigid_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_mechanics_rigid_graphn_fill(s : PhysicsmechanicsrigidGraphN, v : Double) -> PhysicsmechanicsrigidGraphN {
  let result = physics_mechanics_rigid_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_rigid_graphn_min(s : PhysicsmechanicsrigidGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_rigid_graphn_max(s : PhysicsmechanicsrigidGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_rigid_graphn_to_string(s : PhysicsmechanicsrigidGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsrigidNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_rigid_node_make(size : Int) -> PhysicsmechanicsrigidNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_rigid_node_len(s : PhysicsmechanicsrigidNode) -> Int { s.size }

pub fn physics_mechanics_rigid_node_get(s : PhysicsmechanicsrigidNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_rigid_node_set(s : PhysicsmechanicsrigidNode, i : Int, v : Double) -> PhysicsmechanicsrigidNode {
  let result = physics_mechanics_rigid_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_rigid_node_sum(s : PhysicsmechanicsrigidNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_mechanics_rigid_node_mean(s : PhysicsmechanicsrigidNode) -> Double {
  if s.size == 0 { 0.0 } else { physics_mechanics_rigid_node_sum(s) / s.size.to_double() }
}

pub fn physics_mechanics_rigid_node_scale(s : PhysicsmechanicsrigidNode, f : Double) -> PhysicsmechanicsrigidNode {
  let result = physics_mechanics_rigid_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_mechanics_rigid_node_add(a : PhysicsmechanicsrigidNode, b : PhysicsmechanicsrigidNode) -> PhysicsmechanicsrigidNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_mechanics_rigid_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_mechanics_rigid_node_copy(s : PhysicsmechanicsrigidNode) -> PhysicsmechanicsrigidNode {
  let result = physics_mechanics_rigid_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_mechanics_rigid_node_fill(s : PhysicsmechanicsrigidNode, v : Double) -> PhysicsmechanicsrigidNode {
  let result = physics_mechanics_rigid_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_rigid_node_min(s : PhysicsmechanicsrigidNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_rigid_node_max(s : PhysicsmechanicsrigidNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_rigid_node_to_string(s : PhysicsmechanicsrigidNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsrigidEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_rigid_edge_make(size : Int) -> PhysicsmechanicsrigidEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_rigid_edge_len(s : PhysicsmechanicsrigidEdge) -> Int { s.size }

pub fn physics_mechanics_rigid_edge_get(s : PhysicsmechanicsrigidEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_rigid_edge_set(s : PhysicsmechanicsrigidEdge, i : Int, v : Double) -> PhysicsmechanicsrigidEdge {
  let result = physics_mechanics_rigid_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_rigid_edge_sum(s : PhysicsmechanicsrigidEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_mechanics_rigid_edge_mean(s : PhysicsmechanicsrigidEdge) -> Double {
  if s.size == 0 { 0.0 } else { physics_mechanics_rigid_edge_sum(s) / s.size.to_double() }
}

pub fn physics_mechanics_rigid_edge_scale(s : PhysicsmechanicsrigidEdge, f : Double) -> PhysicsmechanicsrigidEdge {
  let result = physics_mechanics_rigid_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_mechanics_rigid_edge_add(a : PhysicsmechanicsrigidEdge, b : PhysicsmechanicsrigidEdge) -> PhysicsmechanicsrigidEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_mechanics_rigid_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_mechanics_rigid_edge_copy(s : PhysicsmechanicsrigidEdge) -> PhysicsmechanicsrigidEdge {
  let result = physics_mechanics_rigid_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_mechanics_rigid_edge_fill(s : PhysicsmechanicsrigidEdge, v : Double) -> PhysicsmechanicsrigidEdge {
  let result = physics_mechanics_rigid_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_rigid_edge_min(s : PhysicsmechanicsrigidEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_rigid_edge_max(s : PhysicsmechanicsrigidEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_rigid_edge_to_string(s : PhysicsmechanicsrigidEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsrigidPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_rigid_path_make(size : Int) -> PhysicsmechanicsrigidPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_rigid_path_len(s : PhysicsmechanicsrigidPath) -> Int { s.size }

pub fn physics_mechanics_rigid_path_get(s : PhysicsmechanicsrigidPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_rigid_path_set(s : PhysicsmechanicsrigidPath, i : Int, v : Double) -> PhysicsmechanicsrigidPath {
  let result = physics_mechanics_rigid_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_rigid_path_sum(s : PhysicsmechanicsrigidPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_mechanics_rigid_path_mean(s : PhysicsmechanicsrigidPath) -> Double {
  if s.size == 0 { 0.0 } else { physics_mechanics_rigid_path_sum(s) / s.size.to_double() }
}

pub fn physics_mechanics_rigid_path_scale(s : PhysicsmechanicsrigidPath, f : Double) -> PhysicsmechanicsrigidPath {
  let result = physics_mechanics_rigid_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_mechanics_rigid_path_add(a : PhysicsmechanicsrigidPath, b : PhysicsmechanicsrigidPath) -> PhysicsmechanicsrigidPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_mechanics_rigid_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_mechanics_rigid_path_copy(s : PhysicsmechanicsrigidPath) -> PhysicsmechanicsrigidPath {
  let result = physics_mechanics_rigid_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_mechanics_rigid_path_fill(s : PhysicsmechanicsrigidPath, v : Double) -> PhysicsmechanicsrigidPath {
  let result = physics_mechanics_rigid_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_rigid_path_min(s : PhysicsmechanicsrigidPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_rigid_path_max(s : PhysicsmechanicsrigidPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_rigid_path_to_string(s : PhysicsmechanicsrigidPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsrigidCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_rigid_cluster_make(size : Int) -> PhysicsmechanicsrigidCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_rigid_cluster_len(s : PhysicsmechanicsrigidCluster) -> Int { s.size }

pub fn physics_mechanics_rigid_cluster_get(s : PhysicsmechanicsrigidCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_rigid_cluster_set(s : PhysicsmechanicsrigidCluster, i : Int, v : Double) -> PhysicsmechanicsrigidCluster {
  let result = physics_mechanics_rigid_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_rigid_cluster_sum(s : PhysicsmechanicsrigidCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_mechanics_rigid_cluster_mean(s : PhysicsmechanicsrigidCluster) -> Double {
  if s.size == 0 { 0.0 } else { physics_mechanics_rigid_cluster_sum(s) / s.size.to_double() }
}

pub fn physics_mechanics_rigid_cluster_scale(s : PhysicsmechanicsrigidCluster, f : Double) -> PhysicsmechanicsrigidCluster {
  let result = physics_mechanics_rigid_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_mechanics_rigid_cluster_add(a : PhysicsmechanicsrigidCluster, b : PhysicsmechanicsrigidCluster) -> PhysicsmechanicsrigidCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_mechanics_rigid_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_mechanics_rigid_cluster_copy(s : PhysicsmechanicsrigidCluster) -> PhysicsmechanicsrigidCluster {
  let result = physics_mechanics_rigid_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_mechanics_rigid_cluster_fill(s : PhysicsmechanicsrigidCluster, v : Double) -> PhysicsmechanicsrigidCluster {
  let result = physics_mechanics_rigid_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_rigid_cluster_min(s : PhysicsmechanicsrigidCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_rigid_cluster_max(s : PhysicsmechanicsrigidCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_rigid_cluster_to_string(s : PhysicsmechanicsrigidCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsrigidModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_rigid_model_make(size : Int) -> PhysicsmechanicsrigidModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_rigid_model_len(s : PhysicsmechanicsrigidModel) -> Int { s.size }

pub fn physics_mechanics_rigid_model_get(s : PhysicsmechanicsrigidModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_rigid_model_set(s : PhysicsmechanicsrigidModel, i : Int, v : Double) -> PhysicsmechanicsrigidModel {
  let result = physics_mechanics_rigid_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_rigid_model_sum(s : PhysicsmechanicsrigidModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_mechanics_rigid_model_mean(s : PhysicsmechanicsrigidModel) -> Double {
  if s.size == 0 { 0.0 } else { physics_mechanics_rigid_model_sum(s) / s.size.to_double() }
}

pub fn physics_mechanics_rigid_model_scale(s : PhysicsmechanicsrigidModel, f : Double) -> PhysicsmechanicsrigidModel {
  let result = physics_mechanics_rigid_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_mechanics_rigid_model_add(a : PhysicsmechanicsrigidModel, b : PhysicsmechanicsrigidModel) -> PhysicsmechanicsrigidModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_mechanics_rigid_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_mechanics_rigid_model_copy(s : PhysicsmechanicsrigidModel) -> PhysicsmechanicsrigidModel {
  let result = physics_mechanics_rigid_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_mechanics_rigid_model_fill(s : PhysicsmechanicsrigidModel, v : Double) -> PhysicsmechanicsrigidModel {
  let result = physics_mechanics_rigid_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_rigid_model_min(s : PhysicsmechanicsrigidModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_rigid_model_max(s : PhysicsmechanicsrigidModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_rigid_model_to_string(s : PhysicsmechanicsrigidModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsrigidLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_rigid_layer_make(size : Int) -> PhysicsmechanicsrigidLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_rigid_layer_len(s : PhysicsmechanicsrigidLayer) -> Int { s.size }

pub fn physics_mechanics_rigid_layer_get(s : PhysicsmechanicsrigidLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_rigid_layer_set(s : PhysicsmechanicsrigidLayer, i : Int, v : Double) -> PhysicsmechanicsrigidLayer {
  let result = physics_mechanics_rigid_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_rigid_layer_sum(s : PhysicsmechanicsrigidLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_mechanics_rigid_layer_mean(s : PhysicsmechanicsrigidLayer) -> Double {
  if s.size == 0 { 0.0 } else { physics_mechanics_rigid_layer_sum(s) / s.size.to_double() }
}

pub fn physics_mechanics_rigid_layer_scale(s : PhysicsmechanicsrigidLayer, f : Double) -> PhysicsmechanicsrigidLayer {
  let result = physics_mechanics_rigid_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_mechanics_rigid_layer_add(a : PhysicsmechanicsrigidLayer, b : PhysicsmechanicsrigidLayer) -> PhysicsmechanicsrigidLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_mechanics_rigid_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_mechanics_rigid_layer_copy(s : PhysicsmechanicsrigidLayer) -> PhysicsmechanicsrigidLayer {
  let result = physics_mechanics_rigid_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_mechanics_rigid_layer_fill(s : PhysicsmechanicsrigidLayer, v : Double) -> PhysicsmechanicsrigidLayer {
  let result = physics_mechanics_rigid_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_rigid_layer_min(s : PhysicsmechanicsrigidLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_rigid_layer_max(s : PhysicsmechanicsrigidLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_rigid_layer_to_string(s : PhysicsmechanicsrigidLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsrigidBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_rigid_buffer_make(size : Int) -> PhysicsmechanicsrigidBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_rigid_buffer_len(s : PhysicsmechanicsrigidBuffer) -> Int { s.size }

pub fn physics_mechanics_rigid_buffer_get(s : PhysicsmechanicsrigidBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_rigid_buffer_set(s : PhysicsmechanicsrigidBuffer, i : Int, v : Double) -> PhysicsmechanicsrigidBuffer {
  let result = physics_mechanics_rigid_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_rigid_buffer_sum(s : PhysicsmechanicsrigidBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_mechanics_rigid_buffer_mean(s : PhysicsmechanicsrigidBuffer) -> Double {
  if s.size == 0 { 0.0 } else { physics_mechanics_rigid_buffer_sum(s) / s.size.to_double() }
}

pub fn physics_mechanics_rigid_buffer_scale(s : PhysicsmechanicsrigidBuffer, f : Double) -> PhysicsmechanicsrigidBuffer {
  let result = physics_mechanics_rigid_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_mechanics_rigid_buffer_add(a : PhysicsmechanicsrigidBuffer, b : PhysicsmechanicsrigidBuffer) -> PhysicsmechanicsrigidBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_mechanics_rigid_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_mechanics_rigid_buffer_copy(s : PhysicsmechanicsrigidBuffer) -> PhysicsmechanicsrigidBuffer {
  let result = physics_mechanics_rigid_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_mechanics_rigid_buffer_fill(s : PhysicsmechanicsrigidBuffer, v : Double) -> PhysicsmechanicsrigidBuffer {
  let result = physics_mechanics_rigid_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_rigid_buffer_min(s : PhysicsmechanicsrigidBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_rigid_buffer_max(s : PhysicsmechanicsrigidBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_rigid_buffer_to_string(s : PhysicsmechanicsrigidBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsrigidCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_rigid_cursor_make(size : Int) -> PhysicsmechanicsrigidCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_rigid_cursor_len(s : PhysicsmechanicsrigidCursor) -> Int { s.size }

pub fn physics_mechanics_rigid_cursor_get(s : PhysicsmechanicsrigidCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_rigid_cursor_set(s : PhysicsmechanicsrigidCursor, i : Int, v : Double) -> PhysicsmechanicsrigidCursor {
  let result = physics_mechanics_rigid_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_rigid_cursor_sum(s : PhysicsmechanicsrigidCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_mechanics_rigid_cursor_mean(s : PhysicsmechanicsrigidCursor) -> Double {
  if s.size == 0 { 0.0 } else { physics_mechanics_rigid_cursor_sum(s) / s.size.to_double() }
}

pub fn physics_mechanics_rigid_cursor_scale(s : PhysicsmechanicsrigidCursor, f : Double) -> PhysicsmechanicsrigidCursor {
  let result = physics_mechanics_rigid_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_mechanics_rigid_cursor_add(a : PhysicsmechanicsrigidCursor, b : PhysicsmechanicsrigidCursor) -> PhysicsmechanicsrigidCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_mechanics_rigid_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_mechanics_rigid_cursor_copy(s : PhysicsmechanicsrigidCursor) -> PhysicsmechanicsrigidCursor {
  let result = physics_mechanics_rigid_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_mechanics_rigid_cursor_fill(s : PhysicsmechanicsrigidCursor, v : Double) -> PhysicsmechanicsrigidCursor {
  let result = physics_mechanics_rigid_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_rigid_cursor_min(s : PhysicsmechanicsrigidCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_rigid_cursor_max(s : PhysicsmechanicsrigidCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_rigid_cursor_to_string(s : PhysicsmechanicsrigidCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsrigidView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_rigid_view_make(size : Int) -> PhysicsmechanicsrigidView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_rigid_view_len(s : PhysicsmechanicsrigidView) -> Int { s.size }

pub fn physics_mechanics_rigid_view_get(s : PhysicsmechanicsrigidView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_rigid_view_set(s : PhysicsmechanicsrigidView, i : Int, v : Double) -> PhysicsmechanicsrigidView {
  let result = physics_mechanics_rigid_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_rigid_view_sum(s : PhysicsmechanicsrigidView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_mechanics_rigid_view_mean(s : PhysicsmechanicsrigidView) -> Double {
  if s.size == 0 { 0.0 } else { physics_mechanics_rigid_view_sum(s) / s.size.to_double() }
}

pub fn physics_mechanics_rigid_view_scale(s : PhysicsmechanicsrigidView, f : Double) -> PhysicsmechanicsrigidView {
  let result = physics_mechanics_rigid_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_mechanics_rigid_view_add(a : PhysicsmechanicsrigidView, b : PhysicsmechanicsrigidView) -> PhysicsmechanicsrigidView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_mechanics_rigid_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_mechanics_rigid_view_copy(s : PhysicsmechanicsrigidView) -> PhysicsmechanicsrigidView {
  let result = physics_mechanics_rigid_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_mechanics_rigid_view_fill(s : PhysicsmechanicsrigidView, v : Double) -> PhysicsmechanicsrigidView {
  let result = physics_mechanics_rigid_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_rigid_view_min(s : PhysicsmechanicsrigidView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_rigid_view_max(s : PhysicsmechanicsrigidView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_rigid_view_to_string(s : PhysicsmechanicsrigidView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsrigidRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_rigid_range_make(size : Int) -> PhysicsmechanicsrigidRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_rigid_range_len(s : PhysicsmechanicsrigidRange) -> Int { s.size }

pub fn physics_mechanics_rigid_range_get(s : PhysicsmechanicsrigidRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_rigid_range_set(s : PhysicsmechanicsrigidRange, i : Int, v : Double) -> PhysicsmechanicsrigidRange {
  let result = physics_mechanics_rigid_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_rigid_range_sum(s : PhysicsmechanicsrigidRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_mechanics_rigid_range_mean(s : PhysicsmechanicsrigidRange) -> Double {
  if s.size == 0 { 0.0 } else { physics_mechanics_rigid_range_sum(s) / s.size.to_double() }
}

pub fn physics_mechanics_rigid_range_scale(s : PhysicsmechanicsrigidRange, f : Double) -> PhysicsmechanicsrigidRange {
  let result = physics_mechanics_rigid_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_mechanics_rigid_range_add(a : PhysicsmechanicsrigidRange, b : PhysicsmechanicsrigidRange) -> PhysicsmechanicsrigidRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_mechanics_rigid_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_mechanics_rigid_range_copy(s : PhysicsmechanicsrigidRange) -> PhysicsmechanicsrigidRange {
  let result = physics_mechanics_rigid_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_mechanics_rigid_range_fill(s : PhysicsmechanicsrigidRange, v : Double) -> PhysicsmechanicsrigidRange {
  let result = physics_mechanics_rigid_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_rigid_range_min(s : PhysicsmechanicsrigidRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_rigid_range_max(s : PhysicsmechanicsrigidRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_rigid_range_to_string(s : PhysicsmechanicsrigidRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsrigidSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_rigid_slice_make(size : Int) -> PhysicsmechanicsrigidSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_rigid_slice_len(s : PhysicsmechanicsrigidSlice) -> Int { s.size }

pub fn physics_mechanics_rigid_slice_get(s : PhysicsmechanicsrigidSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_rigid_slice_set(s : PhysicsmechanicsrigidSlice, i : Int, v : Double) -> PhysicsmechanicsrigidSlice {
  let result = physics_mechanics_rigid_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_rigid_slice_sum(s : PhysicsmechanicsrigidSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_mechanics_rigid_slice_mean(s : PhysicsmechanicsrigidSlice) -> Double {
  if s.size == 0 { 0.0 } else { physics_mechanics_rigid_slice_sum(s) / s.size.to_double() }
}

pub fn physics_mechanics_rigid_slice_scale(s : PhysicsmechanicsrigidSlice, f : Double) -> PhysicsmechanicsrigidSlice {
  let result = physics_mechanics_rigid_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_mechanics_rigid_slice_add(a : PhysicsmechanicsrigidSlice, b : PhysicsmechanicsrigidSlice) -> PhysicsmechanicsrigidSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_mechanics_rigid_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_mechanics_rigid_slice_copy(s : PhysicsmechanicsrigidSlice) -> PhysicsmechanicsrigidSlice {
  let result = physics_mechanics_rigid_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_mechanics_rigid_slice_fill(s : PhysicsmechanicsrigidSlice, v : Double) -> PhysicsmechanicsrigidSlice {
  let result = physics_mechanics_rigid_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_rigid_slice_min(s : PhysicsmechanicsrigidSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_rigid_slice_max(s : PhysicsmechanicsrigidSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_rigid_slice_to_string(s : PhysicsmechanicsrigidSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn physics_mechanics_rigid_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_mechanics_rigid_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_mechanics_rigid_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_mechanics_rigid_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_mechanics_rigid_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_mechanics_rigid_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_mechanics_rigid_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_mechanics_rigid_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_mechanics_rigid_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_mechanics_rigid_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_mechanics_rigid_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_mechanics_rigid_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_mechanics_rigid_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_mechanics_rigid_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_mechanics_rigid_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_mechanics_rigid_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_mechanics_rigid_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_mechanics_rigid_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_mechanics_rigid_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_mechanics_rigid_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_mechanics_rigid_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_mechanics_rigid_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_mechanics_rigid_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_mechanics_rigid_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_mechanics_rigid_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

