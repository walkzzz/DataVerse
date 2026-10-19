///===
/// extcore/physics_mechanics_dynamic

pub(all) struct PhysicsmechanicsdynamicPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn physics_mechanics_dynamic_make_point(x : Double, y : Double) -> PhysicsmechanicsdynamicPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn physics_mechanics_dynamic_make_point3(x : Double, y : Double, z : Double) -> PhysicsmechanicsdynamicPoint {
  { x, y, z, label: 0 }
}

pub fn physics_mechanics_dynamic_point_x(pt : PhysicsmechanicsdynamicPoint) -> Double { pt.x }

pub fn physics_mechanics_dynamic_point_y(pt : PhysicsmechanicsdynamicPoint) -> Double { pt.y }

pub fn physics_mechanics_dynamic_point_z(pt : PhysicsmechanicsdynamicPoint) -> Double { pt.z }

pub fn physics_mechanics_dynamic_point_label(pt : PhysicsmechanicsdynamicPoint) -> Int { pt.label }

pub fn physics_mechanics_dynamic_point_dist(a : PhysicsmechanicsdynamicPoint, b : PhysicsmechanicsdynamicPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  physics_mechanics_dynamic_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn physics_mechanics_dynamic_point_add(a : PhysicsmechanicsdynamicPoint, b : PhysicsmechanicsdynamicPoint) -> PhysicsmechanicsdynamicPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn physics_mechanics_dynamic_point_sub(a : PhysicsmechanicsdynamicPoint, b : PhysicsmechanicsdynamicPoint) -> PhysicsmechanicsdynamicPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn physics_mechanics_dynamic_point_scale(pt : PhysicsmechanicsdynamicPoint, s : Double) -> PhysicsmechanicsdynamicPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn physics_mechanics_dynamic_point_dot(a : PhysicsmechanicsdynamicPoint, b : PhysicsmechanicsdynamicPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn physics_mechanics_dynamic_point_cross(a : PhysicsmechanicsdynamicPoint, b : PhysicsmechanicsdynamicPoint) -> PhysicsmechanicsdynamicPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn physics_mechanics_dynamic_point_norm(pt : PhysicsmechanicsdynamicPoint) -> Double {
  physics_mechanics_dynamic_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn physics_mechanics_dynamic_point_normalize(pt : PhysicsmechanicsdynamicPoint) -> PhysicsmechanicsdynamicPoint {
  let n = physics_mechanics_dynamic_point_norm(pt)
  if n < 0.0000001 { pt } else { physics_mechanics_dynamic_point_scale(pt, 1.0 / n) }
}

pub fn physics_mechanics_dynamic_point_negate(pt : PhysicsmechanicsdynamicPoint) -> PhysicsmechanicsdynamicPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn physics_mechanics_dynamic_point_mid(a : PhysicsmechanicsdynamicPoint, b : PhysicsmechanicsdynamicPoint) -> PhysicsmechanicsdynamicPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn physics_mechanics_dynamic_point_lerp(a : PhysicsmechanicsdynamicPoint, b : PhysicsmechanicsdynamicPoint, t : Double) -> PhysicsmechanicsdynamicPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn physics_mechanics_dynamic_point_to_string(pt : PhysicsmechanicsdynamicPoint) -> String {
  "(" + physics_mechanics_dynamic_dbl(pt.x) + ", " + physics_mechanics_dynamic_dbl(pt.y) + ", " + physics_mechanics_dynamic_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct PhysicsmechanicsdynamicSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn physics_mechanics_dynamic_make_series(vals : Array[Double], name : String) -> PhysicsmechanicsdynamicSeries {
  { vals, name, meta: 0 }
}

pub fn physics_mechanics_dynamic_series_len(s : PhysicsmechanicsdynamicSeries) -> Int { s.vals.length() }

pub fn physics_mechanics_dynamic_series_sum(s : PhysicsmechanicsdynamicSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn physics_mechanics_dynamic_series_mean(s : PhysicsmechanicsdynamicSeries) -> Double {
  let n = physics_mechanics_dynamic_series_len(s)
  if n == 0 { 0.0 } else { physics_mechanics_dynamic_series_sum(s) / n.to_double() }
}

pub fn physics_mechanics_dynamic_series_min(s : PhysicsmechanicsdynamicSeries) -> Double {
  let n = physics_mechanics_dynamic_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn physics_mechanics_dynamic_series_max(s : PhysicsmechanicsdynamicSeries) -> Double {
  let n = physics_mechanics_dynamic_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn physics_mechanics_dynamic_series_range(s : PhysicsmechanicsdynamicSeries) -> Double {
  physics_mechanics_dynamic_series_max(s) - physics_mechanics_dynamic_series_min(s)
}

pub fn physics_mechanics_dynamic_series_var(s : PhysicsmechanicsdynamicSeries) -> Double {
  let n = physics_mechanics_dynamic_series_len(s)
  if n == 0 { 0.0 } else {
    let m = physics_mechanics_dynamic_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn physics_mechanics_dynamic_series_std(s : PhysicsmechanicsdynamicSeries) -> Double { physics_mechanics_dynamic_sqrt(physics_mechanics_dynamic_series_var(s)) }

pub fn physics_mechanics_dynamic_series_median(s : PhysicsmechanicsdynamicSeries) -> Double {
  let n = physics_mechanics_dynamic_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = physics_mechanics_dynamic_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn physics_mechanics_dynamic_series_scale(s : PhysicsmechanicsdynamicSeries, f : Double) -> PhysicsmechanicsdynamicSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = physics_mechanics_dynamic_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn physics_mechanics_dynamic_series_add(a : PhysicsmechanicsdynamicSeries, b : PhysicsmechanicsdynamicSeries) -> PhysicsmechanicsdynamicSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = physics_mechanics_dynamic_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn physics_mechanics_dynamic_series_sub(a : PhysicsmechanicsdynamicSeries, b : PhysicsmechanicsdynamicSeries) -> PhysicsmechanicsdynamicSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = physics_mechanics_dynamic_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn physics_mechanics_dynamic_series_normalize(s : PhysicsmechanicsdynamicSeries) -> PhysicsmechanicsdynamicSeries {
  let mn = physics_mechanics_dynamic_series_min(s)
  let mx = physics_mechanics_dynamic_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = physics_mechanics_dynamic_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn physics_mechanics_dynamic_series_cumsum(s : PhysicsmechanicsdynamicSeries) -> PhysicsmechanicsdynamicSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = physics_mechanics_dynamic_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn physics_mechanics_dynamic_series_to_string(s : PhysicsmechanicsdynamicSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + physics_mechanics_dynamic_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct PhysicsmechanicsdynamicMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn physics_mechanics_dynamic_make_matrix(rows : Int, cols : Int, val : Double) -> PhysicsmechanicsdynamicMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn physics_mechanics_dynamic_matrix_identity(n : Int) -> PhysicsmechanicsdynamicMatrix {
  let m = physics_mechanics_dynamic_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn physics_mechanics_dynamic_matrix_get(m : PhysicsmechanicsdynamicMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn physics_mechanics_dynamic_matrix_transpose(m : PhysicsmechanicsdynamicMatrix) -> PhysicsmechanicsdynamicMatrix {
  let result = physics_mechanics_dynamic_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn physics_mechanics_dynamic_matrix_add(a : PhysicsmechanicsdynamicMatrix, b : PhysicsmechanicsdynamicMatrix) -> PhysicsmechanicsdynamicMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = physics_mechanics_dynamic_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn physics_mechanics_dynamic_matrix_scale(m : PhysicsmechanicsdynamicMatrix, s : Double) -> PhysicsmechanicsdynamicMatrix {
  let result = physics_mechanics_dynamic_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn physics_mechanics_dynamic_matrix_multiply(a : PhysicsmechanicsdynamicMatrix, b : PhysicsmechanicsdynamicMatrix) -> PhysicsmechanicsdynamicMatrix {
  if a.cols != b.rows { return physics_mechanics_dynamic_make_matrix(a.rows, b.cols, 0.0) }
  let result = physics_mechanics_dynamic_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn physics_mechanics_dynamic_matrix_trace(m : PhysicsmechanicsdynamicMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn physics_mechanics_dynamic_matrix_det(m : PhysicsmechanicsdynamicMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn physics_mechanics_dynamic_matrix_norm(m : PhysicsmechanicsdynamicMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  physics_mechanics_dynamic_sqrt(sum)
}

pub fn physics_mechanics_dynamic_matrix_to_string(m : PhysicsmechanicsdynamicMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + physics_mechanics_dynamic_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct PhysicsmechanicsdynamicVector {
  comps : Array[Double]
  dim : Int
}

pub fn physics_mechanics_dynamic_make_vector(comps : Array[Double]) -> PhysicsmechanicsdynamicVector {
  { comps, dim: comps.length() }
}

pub fn physics_mechanics_dynamic_vector_zero(dim : Int) -> PhysicsmechanicsdynamicVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn physics_mechanics_dynamic_vector_add(a : PhysicsmechanicsdynamicVector, b : PhysicsmechanicsdynamicVector) -> PhysicsmechanicsdynamicVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = physics_mechanics_dynamic_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn physics_mechanics_dynamic_vector_sub(a : PhysicsmechanicsdynamicVector, b : PhysicsmechanicsdynamicVector) -> PhysicsmechanicsdynamicVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = physics_mechanics_dynamic_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn physics_mechanics_dynamic_vector_scale(v : PhysicsmechanicsdynamicVector, s : Double) -> PhysicsmechanicsdynamicVector {
  let mut result = []
  for i in 0..<v.dim { result = physics_mechanics_dynamic_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn physics_mechanics_dynamic_vector_dot(a : PhysicsmechanicsdynamicVector, b : PhysicsmechanicsdynamicVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn physics_mechanics_dynamic_vector_norm(v : PhysicsmechanicsdynamicVector) -> Double { physics_mechanics_dynamic_sqrt(physics_mechanics_dynamic_vector_dot(v, v)) }

pub fn physics_mechanics_dynamic_vector_normalize(v : PhysicsmechanicsdynamicVector) -> PhysicsmechanicsdynamicVector {
  let n = physics_mechanics_dynamic_vector_norm(v)
  if n < 0.0000001 { v } else { physics_mechanics_dynamic_vector_scale(v, 1.0 / n) }
}

pub fn physics_mechanics_dynamic_vector_dist(a : PhysicsmechanicsdynamicVector, b : PhysicsmechanicsdynamicVector) -> Double {
  physics_mechanics_dynamic_vector_norm(physics_mechanics_dynamic_vector_sub(a, b))
}

pub fn physics_mechanics_dynamic_vector_to_string(v : PhysicsmechanicsdynamicVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + physics_mechanics_dynamic_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn physics_mechanics_dynamic_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn physics_mechanics_dynamic_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = physics_mechanics_dynamic_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn physics_mechanics_dynamic_std(data : Array[Double]) -> Double { physics_mechanics_dynamic_sqrt(physics_mechanics_dynamic_var(data)) }

pub fn physics_mechanics_dynamic_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = physics_mechanics_dynamic_mean(a); let mb = physics_mechanics_dynamic_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn physics_mechanics_dynamic_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = physics_mechanics_dynamic_std(a); let sb = physics_mechanics_dynamic_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { physics_mechanics_dynamic_cov(a, b) / (sa * sb) }
}

pub fn physics_mechanics_dynamic_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = physics_mechanics_dynamic_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn physics_mechanics_dynamic_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn physics_mechanics_dynamic_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn physics_mechanics_dynamic_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  physics_mechanics_dynamic_sqrt(physics_mechanics_dynamic_mse(pred, labels))
}

pub fn physics_mechanics_dynamic_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + physics_mechanics_dynamic_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn physics_mechanics_dynamic_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = physics_mechanics_dynamic_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn physics_mechanics_dynamic_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn physics_mechanics_dynamic_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn physics_mechanics_dynamic_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = physics_mechanics_dynamic_precision(pred, labels, pos); let r = physics_mechanics_dynamic_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn physics_mechanics_dynamic_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn physics_mechanics_dynamic_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = physics_mechanics_dynamic_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn physics_mechanics_dynamic_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn physics_mechanics_dynamic_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn physics_mechanics_dynamic_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = physics_mechanics_dynamic_gcd(a, b)
    (a / g) * b
  }
}

pub fn physics_mechanics_dynamic_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn physics_mechanics_dynamic_fibonacci(n : Int) -> Int {
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

pub fn physics_mechanics_dynamic_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = physics_mechanics_dynamic_min(data); let mx = physics_mechanics_dynamic_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn physics_mechanics_dynamic_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = physics_mechanics_dynamic_mean(data); let sd = physics_mechanics_dynamic_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn physics_mechanics_dynamic_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn physics_mechanics_dynamic_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn physics_mechanics_dynamic_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn physics_mechanics_dynamic_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn physics_mechanics_dynamic_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn physics_mechanics_dynamic_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn physics_mechanics_dynamic_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn physics_mechanics_dynamic_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn physics_mechanics_dynamic_dbl(x : Double) -> String {
  let i = if x >= 0.0 { physics_mechanics_dynamic_int(x) } else { -physics_mechanics_dynamic_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { physics_mechanics_dynamic_int(f * 1000000.0) } else { physics_mechanics_dynamic_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn physics_mechanics_dynamic_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn physics_mechanics_dynamic_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct PhysicsmechanicsdynamicFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_dynamic_frame_make(size : Int) -> PhysicsmechanicsdynamicFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_dynamic_frame_len(s : PhysicsmechanicsdynamicFrame) -> Int { s.size }

pub fn physics_mechanics_dynamic_frame_get(s : PhysicsmechanicsdynamicFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_dynamic_frame_set(s : PhysicsmechanicsdynamicFrame, i : Int, v : Double) -> PhysicsmechanicsdynamicFrame {
  let result = physics_mechanics_dynamic_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_dynamic_frame_sum(s : PhysicsmechanicsdynamicFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_mechanics_dynamic_frame_mean(s : PhysicsmechanicsdynamicFrame) -> Double {
  if s.size == 0 { 0.0 } else { physics_mechanics_dynamic_frame_sum(s) / s.size.to_double() }
}

pub fn physics_mechanics_dynamic_frame_scale(s : PhysicsmechanicsdynamicFrame, f : Double) -> PhysicsmechanicsdynamicFrame {
  let result = physics_mechanics_dynamic_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_mechanics_dynamic_frame_add(a : PhysicsmechanicsdynamicFrame, b : PhysicsmechanicsdynamicFrame) -> PhysicsmechanicsdynamicFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_mechanics_dynamic_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_mechanics_dynamic_frame_copy(s : PhysicsmechanicsdynamicFrame) -> PhysicsmechanicsdynamicFrame {
  let result = physics_mechanics_dynamic_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_mechanics_dynamic_frame_fill(s : PhysicsmechanicsdynamicFrame, v : Double) -> PhysicsmechanicsdynamicFrame {
  let result = physics_mechanics_dynamic_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_dynamic_frame_min(s : PhysicsmechanicsdynamicFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_dynamic_frame_max(s : PhysicsmechanicsdynamicFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_dynamic_frame_to_string(s : PhysicsmechanicsdynamicFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsdynamicTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_dynamic_table_make(size : Int) -> PhysicsmechanicsdynamicTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_dynamic_table_len(s : PhysicsmechanicsdynamicTable) -> Int { s.size }

pub fn physics_mechanics_dynamic_table_get(s : PhysicsmechanicsdynamicTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_dynamic_table_set(s : PhysicsmechanicsdynamicTable, i : Int, v : Double) -> PhysicsmechanicsdynamicTable {
  let result = physics_mechanics_dynamic_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_dynamic_table_sum(s : PhysicsmechanicsdynamicTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_mechanics_dynamic_table_mean(s : PhysicsmechanicsdynamicTable) -> Double {
  if s.size == 0 { 0.0 } else { physics_mechanics_dynamic_table_sum(s) / s.size.to_double() }
}

pub fn physics_mechanics_dynamic_table_scale(s : PhysicsmechanicsdynamicTable, f : Double) -> PhysicsmechanicsdynamicTable {
  let result = physics_mechanics_dynamic_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_mechanics_dynamic_table_add(a : PhysicsmechanicsdynamicTable, b : PhysicsmechanicsdynamicTable) -> PhysicsmechanicsdynamicTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_mechanics_dynamic_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_mechanics_dynamic_table_copy(s : PhysicsmechanicsdynamicTable) -> PhysicsmechanicsdynamicTable {
  let result = physics_mechanics_dynamic_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_mechanics_dynamic_table_fill(s : PhysicsmechanicsdynamicTable, v : Double) -> PhysicsmechanicsdynamicTable {
  let result = physics_mechanics_dynamic_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_dynamic_table_min(s : PhysicsmechanicsdynamicTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_dynamic_table_max(s : PhysicsmechanicsdynamicTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_dynamic_table_to_string(s : PhysicsmechanicsdynamicTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsdynamicGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_dynamic_graphn_make(size : Int) -> PhysicsmechanicsdynamicGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_dynamic_graphn_len(s : PhysicsmechanicsdynamicGraphN) -> Int { s.size }

pub fn physics_mechanics_dynamic_graphn_get(s : PhysicsmechanicsdynamicGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_dynamic_graphn_set(s : PhysicsmechanicsdynamicGraphN, i : Int, v : Double) -> PhysicsmechanicsdynamicGraphN {
  let result = physics_mechanics_dynamic_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_dynamic_graphn_sum(s : PhysicsmechanicsdynamicGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_mechanics_dynamic_graphn_mean(s : PhysicsmechanicsdynamicGraphN) -> Double {
  if s.size == 0 { 0.0 } else { physics_mechanics_dynamic_graphn_sum(s) / s.size.to_double() }
}

pub fn physics_mechanics_dynamic_graphn_scale(s : PhysicsmechanicsdynamicGraphN, f : Double) -> PhysicsmechanicsdynamicGraphN {
  let result = physics_mechanics_dynamic_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_mechanics_dynamic_graphn_add(a : PhysicsmechanicsdynamicGraphN, b : PhysicsmechanicsdynamicGraphN) -> PhysicsmechanicsdynamicGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_mechanics_dynamic_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_mechanics_dynamic_graphn_copy(s : PhysicsmechanicsdynamicGraphN) -> PhysicsmechanicsdynamicGraphN {
  let result = physics_mechanics_dynamic_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_mechanics_dynamic_graphn_fill(s : PhysicsmechanicsdynamicGraphN, v : Double) -> PhysicsmechanicsdynamicGraphN {
  let result = physics_mechanics_dynamic_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_dynamic_graphn_min(s : PhysicsmechanicsdynamicGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_dynamic_graphn_max(s : PhysicsmechanicsdynamicGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_dynamic_graphn_to_string(s : PhysicsmechanicsdynamicGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsdynamicNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_dynamic_node_make(size : Int) -> PhysicsmechanicsdynamicNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_dynamic_node_len(s : PhysicsmechanicsdynamicNode) -> Int { s.size }

pub fn physics_mechanics_dynamic_node_get(s : PhysicsmechanicsdynamicNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_dynamic_node_set(s : PhysicsmechanicsdynamicNode, i : Int, v : Double) -> PhysicsmechanicsdynamicNode {
  let result = physics_mechanics_dynamic_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_dynamic_node_sum(s : PhysicsmechanicsdynamicNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_mechanics_dynamic_node_mean(s : PhysicsmechanicsdynamicNode) -> Double {
  if s.size == 0 { 0.0 } else { physics_mechanics_dynamic_node_sum(s) / s.size.to_double() }
}

pub fn physics_mechanics_dynamic_node_scale(s : PhysicsmechanicsdynamicNode, f : Double) -> PhysicsmechanicsdynamicNode {
  let result = physics_mechanics_dynamic_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_mechanics_dynamic_node_add(a : PhysicsmechanicsdynamicNode, b : PhysicsmechanicsdynamicNode) -> PhysicsmechanicsdynamicNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_mechanics_dynamic_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_mechanics_dynamic_node_copy(s : PhysicsmechanicsdynamicNode) -> PhysicsmechanicsdynamicNode {
  let result = physics_mechanics_dynamic_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_mechanics_dynamic_node_fill(s : PhysicsmechanicsdynamicNode, v : Double) -> PhysicsmechanicsdynamicNode {
  let result = physics_mechanics_dynamic_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_dynamic_node_min(s : PhysicsmechanicsdynamicNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_dynamic_node_max(s : PhysicsmechanicsdynamicNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_dynamic_node_to_string(s : PhysicsmechanicsdynamicNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsdynamicEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_dynamic_edge_make(size : Int) -> PhysicsmechanicsdynamicEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_dynamic_edge_len(s : PhysicsmechanicsdynamicEdge) -> Int { s.size }

pub fn physics_mechanics_dynamic_edge_get(s : PhysicsmechanicsdynamicEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_dynamic_edge_set(s : PhysicsmechanicsdynamicEdge, i : Int, v : Double) -> PhysicsmechanicsdynamicEdge {
  let result = physics_mechanics_dynamic_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_dynamic_edge_sum(s : PhysicsmechanicsdynamicEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_mechanics_dynamic_edge_mean(s : PhysicsmechanicsdynamicEdge) -> Double {
  if s.size == 0 { 0.0 } else { physics_mechanics_dynamic_edge_sum(s) / s.size.to_double() }
}

pub fn physics_mechanics_dynamic_edge_scale(s : PhysicsmechanicsdynamicEdge, f : Double) -> PhysicsmechanicsdynamicEdge {
  let result = physics_mechanics_dynamic_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_mechanics_dynamic_edge_add(a : PhysicsmechanicsdynamicEdge, b : PhysicsmechanicsdynamicEdge) -> PhysicsmechanicsdynamicEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_mechanics_dynamic_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_mechanics_dynamic_edge_copy(s : PhysicsmechanicsdynamicEdge) -> PhysicsmechanicsdynamicEdge {
  let result = physics_mechanics_dynamic_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_mechanics_dynamic_edge_fill(s : PhysicsmechanicsdynamicEdge, v : Double) -> PhysicsmechanicsdynamicEdge {
  let result = physics_mechanics_dynamic_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_dynamic_edge_min(s : PhysicsmechanicsdynamicEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_dynamic_edge_max(s : PhysicsmechanicsdynamicEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_dynamic_edge_to_string(s : PhysicsmechanicsdynamicEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsdynamicPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_dynamic_path_make(size : Int) -> PhysicsmechanicsdynamicPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_dynamic_path_len(s : PhysicsmechanicsdynamicPath) -> Int { s.size }

pub fn physics_mechanics_dynamic_path_get(s : PhysicsmechanicsdynamicPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_dynamic_path_set(s : PhysicsmechanicsdynamicPath, i : Int, v : Double) -> PhysicsmechanicsdynamicPath {
  let result = physics_mechanics_dynamic_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_dynamic_path_sum(s : PhysicsmechanicsdynamicPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_mechanics_dynamic_path_mean(s : PhysicsmechanicsdynamicPath) -> Double {
  if s.size == 0 { 0.0 } else { physics_mechanics_dynamic_path_sum(s) / s.size.to_double() }
}

pub fn physics_mechanics_dynamic_path_scale(s : PhysicsmechanicsdynamicPath, f : Double) -> PhysicsmechanicsdynamicPath {
  let result = physics_mechanics_dynamic_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_mechanics_dynamic_path_add(a : PhysicsmechanicsdynamicPath, b : PhysicsmechanicsdynamicPath) -> PhysicsmechanicsdynamicPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_mechanics_dynamic_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_mechanics_dynamic_path_copy(s : PhysicsmechanicsdynamicPath) -> PhysicsmechanicsdynamicPath {
  let result = physics_mechanics_dynamic_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_mechanics_dynamic_path_fill(s : PhysicsmechanicsdynamicPath, v : Double) -> PhysicsmechanicsdynamicPath {
  let result = physics_mechanics_dynamic_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_dynamic_path_min(s : PhysicsmechanicsdynamicPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_dynamic_path_max(s : PhysicsmechanicsdynamicPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_dynamic_path_to_string(s : PhysicsmechanicsdynamicPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsdynamicCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_dynamic_cluster_make(size : Int) -> PhysicsmechanicsdynamicCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_dynamic_cluster_len(s : PhysicsmechanicsdynamicCluster) -> Int { s.size }

pub fn physics_mechanics_dynamic_cluster_get(s : PhysicsmechanicsdynamicCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_dynamic_cluster_set(s : PhysicsmechanicsdynamicCluster, i : Int, v : Double) -> PhysicsmechanicsdynamicCluster {
  let result = physics_mechanics_dynamic_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_dynamic_cluster_sum(s : PhysicsmechanicsdynamicCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_mechanics_dynamic_cluster_mean(s : PhysicsmechanicsdynamicCluster) -> Double {
  if s.size == 0 { 0.0 } else { physics_mechanics_dynamic_cluster_sum(s) / s.size.to_double() }
}

pub fn physics_mechanics_dynamic_cluster_scale(s : PhysicsmechanicsdynamicCluster, f : Double) -> PhysicsmechanicsdynamicCluster {
  let result = physics_mechanics_dynamic_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_mechanics_dynamic_cluster_add(a : PhysicsmechanicsdynamicCluster, b : PhysicsmechanicsdynamicCluster) -> PhysicsmechanicsdynamicCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_mechanics_dynamic_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_mechanics_dynamic_cluster_copy(s : PhysicsmechanicsdynamicCluster) -> PhysicsmechanicsdynamicCluster {
  let result = physics_mechanics_dynamic_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_mechanics_dynamic_cluster_fill(s : PhysicsmechanicsdynamicCluster, v : Double) -> PhysicsmechanicsdynamicCluster {
  let result = physics_mechanics_dynamic_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_dynamic_cluster_min(s : PhysicsmechanicsdynamicCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_dynamic_cluster_max(s : PhysicsmechanicsdynamicCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_dynamic_cluster_to_string(s : PhysicsmechanicsdynamicCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsdynamicModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_dynamic_model_make(size : Int) -> PhysicsmechanicsdynamicModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_dynamic_model_len(s : PhysicsmechanicsdynamicModel) -> Int { s.size }

pub fn physics_mechanics_dynamic_model_get(s : PhysicsmechanicsdynamicModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_dynamic_model_set(s : PhysicsmechanicsdynamicModel, i : Int, v : Double) -> PhysicsmechanicsdynamicModel {
  let result = physics_mechanics_dynamic_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_dynamic_model_sum(s : PhysicsmechanicsdynamicModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_mechanics_dynamic_model_mean(s : PhysicsmechanicsdynamicModel) -> Double {
  if s.size == 0 { 0.0 } else { physics_mechanics_dynamic_model_sum(s) / s.size.to_double() }
}

pub fn physics_mechanics_dynamic_model_scale(s : PhysicsmechanicsdynamicModel, f : Double) -> PhysicsmechanicsdynamicModel {
  let result = physics_mechanics_dynamic_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_mechanics_dynamic_model_add(a : PhysicsmechanicsdynamicModel, b : PhysicsmechanicsdynamicModel) -> PhysicsmechanicsdynamicModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_mechanics_dynamic_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_mechanics_dynamic_model_copy(s : PhysicsmechanicsdynamicModel) -> PhysicsmechanicsdynamicModel {
  let result = physics_mechanics_dynamic_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_mechanics_dynamic_model_fill(s : PhysicsmechanicsdynamicModel, v : Double) -> PhysicsmechanicsdynamicModel {
  let result = physics_mechanics_dynamic_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_dynamic_model_min(s : PhysicsmechanicsdynamicModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_dynamic_model_max(s : PhysicsmechanicsdynamicModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_dynamic_model_to_string(s : PhysicsmechanicsdynamicModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsdynamicLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_dynamic_layer_make(size : Int) -> PhysicsmechanicsdynamicLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_dynamic_layer_len(s : PhysicsmechanicsdynamicLayer) -> Int { s.size }

pub fn physics_mechanics_dynamic_layer_get(s : PhysicsmechanicsdynamicLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_dynamic_layer_set(s : PhysicsmechanicsdynamicLayer, i : Int, v : Double) -> PhysicsmechanicsdynamicLayer {
  let result = physics_mechanics_dynamic_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_dynamic_layer_sum(s : PhysicsmechanicsdynamicLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_mechanics_dynamic_layer_mean(s : PhysicsmechanicsdynamicLayer) -> Double {
  if s.size == 0 { 0.0 } else { physics_mechanics_dynamic_layer_sum(s) / s.size.to_double() }
}

pub fn physics_mechanics_dynamic_layer_scale(s : PhysicsmechanicsdynamicLayer, f : Double) -> PhysicsmechanicsdynamicLayer {
  let result = physics_mechanics_dynamic_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_mechanics_dynamic_layer_add(a : PhysicsmechanicsdynamicLayer, b : PhysicsmechanicsdynamicLayer) -> PhysicsmechanicsdynamicLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_mechanics_dynamic_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_mechanics_dynamic_layer_copy(s : PhysicsmechanicsdynamicLayer) -> PhysicsmechanicsdynamicLayer {
  let result = physics_mechanics_dynamic_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_mechanics_dynamic_layer_fill(s : PhysicsmechanicsdynamicLayer, v : Double) -> PhysicsmechanicsdynamicLayer {
  let result = physics_mechanics_dynamic_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_dynamic_layer_min(s : PhysicsmechanicsdynamicLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_dynamic_layer_max(s : PhysicsmechanicsdynamicLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_dynamic_layer_to_string(s : PhysicsmechanicsdynamicLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsdynamicBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_dynamic_buffer_make(size : Int) -> PhysicsmechanicsdynamicBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_dynamic_buffer_len(s : PhysicsmechanicsdynamicBuffer) -> Int { s.size }

pub fn physics_mechanics_dynamic_buffer_get(s : PhysicsmechanicsdynamicBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_dynamic_buffer_set(s : PhysicsmechanicsdynamicBuffer, i : Int, v : Double) -> PhysicsmechanicsdynamicBuffer {
  let result = physics_mechanics_dynamic_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_dynamic_buffer_sum(s : PhysicsmechanicsdynamicBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_mechanics_dynamic_buffer_mean(s : PhysicsmechanicsdynamicBuffer) -> Double {
  if s.size == 0 { 0.0 } else { physics_mechanics_dynamic_buffer_sum(s) / s.size.to_double() }
}

pub fn physics_mechanics_dynamic_buffer_scale(s : PhysicsmechanicsdynamicBuffer, f : Double) -> PhysicsmechanicsdynamicBuffer {
  let result = physics_mechanics_dynamic_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_mechanics_dynamic_buffer_add(a : PhysicsmechanicsdynamicBuffer, b : PhysicsmechanicsdynamicBuffer) -> PhysicsmechanicsdynamicBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_mechanics_dynamic_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_mechanics_dynamic_buffer_copy(s : PhysicsmechanicsdynamicBuffer) -> PhysicsmechanicsdynamicBuffer {
  let result = physics_mechanics_dynamic_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_mechanics_dynamic_buffer_fill(s : PhysicsmechanicsdynamicBuffer, v : Double) -> PhysicsmechanicsdynamicBuffer {
  let result = physics_mechanics_dynamic_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_dynamic_buffer_min(s : PhysicsmechanicsdynamicBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_dynamic_buffer_max(s : PhysicsmechanicsdynamicBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_dynamic_buffer_to_string(s : PhysicsmechanicsdynamicBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsdynamicCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_dynamic_cursor_make(size : Int) -> PhysicsmechanicsdynamicCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_dynamic_cursor_len(s : PhysicsmechanicsdynamicCursor) -> Int { s.size }

pub fn physics_mechanics_dynamic_cursor_get(s : PhysicsmechanicsdynamicCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_dynamic_cursor_set(s : PhysicsmechanicsdynamicCursor, i : Int, v : Double) -> PhysicsmechanicsdynamicCursor {
  let result = physics_mechanics_dynamic_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_dynamic_cursor_sum(s : PhysicsmechanicsdynamicCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_mechanics_dynamic_cursor_mean(s : PhysicsmechanicsdynamicCursor) -> Double {
  if s.size == 0 { 0.0 } else { physics_mechanics_dynamic_cursor_sum(s) / s.size.to_double() }
}

pub fn physics_mechanics_dynamic_cursor_scale(s : PhysicsmechanicsdynamicCursor, f : Double) -> PhysicsmechanicsdynamicCursor {
  let result = physics_mechanics_dynamic_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_mechanics_dynamic_cursor_add(a : PhysicsmechanicsdynamicCursor, b : PhysicsmechanicsdynamicCursor) -> PhysicsmechanicsdynamicCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_mechanics_dynamic_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_mechanics_dynamic_cursor_copy(s : PhysicsmechanicsdynamicCursor) -> PhysicsmechanicsdynamicCursor {
  let result = physics_mechanics_dynamic_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_mechanics_dynamic_cursor_fill(s : PhysicsmechanicsdynamicCursor, v : Double) -> PhysicsmechanicsdynamicCursor {
  let result = physics_mechanics_dynamic_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_dynamic_cursor_min(s : PhysicsmechanicsdynamicCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_dynamic_cursor_max(s : PhysicsmechanicsdynamicCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_dynamic_cursor_to_string(s : PhysicsmechanicsdynamicCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsdynamicView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_dynamic_view_make(size : Int) -> PhysicsmechanicsdynamicView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_dynamic_view_len(s : PhysicsmechanicsdynamicView) -> Int { s.size }

pub fn physics_mechanics_dynamic_view_get(s : PhysicsmechanicsdynamicView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_dynamic_view_set(s : PhysicsmechanicsdynamicView, i : Int, v : Double) -> PhysicsmechanicsdynamicView {
  let result = physics_mechanics_dynamic_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_dynamic_view_sum(s : PhysicsmechanicsdynamicView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_mechanics_dynamic_view_mean(s : PhysicsmechanicsdynamicView) -> Double {
  if s.size == 0 { 0.0 } else { physics_mechanics_dynamic_view_sum(s) / s.size.to_double() }
}

pub fn physics_mechanics_dynamic_view_scale(s : PhysicsmechanicsdynamicView, f : Double) -> PhysicsmechanicsdynamicView {
  let result = physics_mechanics_dynamic_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_mechanics_dynamic_view_add(a : PhysicsmechanicsdynamicView, b : PhysicsmechanicsdynamicView) -> PhysicsmechanicsdynamicView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_mechanics_dynamic_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_mechanics_dynamic_view_copy(s : PhysicsmechanicsdynamicView) -> PhysicsmechanicsdynamicView {
  let result = physics_mechanics_dynamic_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_mechanics_dynamic_view_fill(s : PhysicsmechanicsdynamicView, v : Double) -> PhysicsmechanicsdynamicView {
  let result = physics_mechanics_dynamic_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_dynamic_view_min(s : PhysicsmechanicsdynamicView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_dynamic_view_max(s : PhysicsmechanicsdynamicView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_dynamic_view_to_string(s : PhysicsmechanicsdynamicView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsdynamicRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_dynamic_range_make(size : Int) -> PhysicsmechanicsdynamicRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_dynamic_range_len(s : PhysicsmechanicsdynamicRange) -> Int { s.size }

pub fn physics_mechanics_dynamic_range_get(s : PhysicsmechanicsdynamicRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_dynamic_range_set(s : PhysicsmechanicsdynamicRange, i : Int, v : Double) -> PhysicsmechanicsdynamicRange {
  let result = physics_mechanics_dynamic_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_dynamic_range_sum(s : PhysicsmechanicsdynamicRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_mechanics_dynamic_range_mean(s : PhysicsmechanicsdynamicRange) -> Double {
  if s.size == 0 { 0.0 } else { physics_mechanics_dynamic_range_sum(s) / s.size.to_double() }
}

pub fn physics_mechanics_dynamic_range_scale(s : PhysicsmechanicsdynamicRange, f : Double) -> PhysicsmechanicsdynamicRange {
  let result = physics_mechanics_dynamic_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_mechanics_dynamic_range_add(a : PhysicsmechanicsdynamicRange, b : PhysicsmechanicsdynamicRange) -> PhysicsmechanicsdynamicRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_mechanics_dynamic_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_mechanics_dynamic_range_copy(s : PhysicsmechanicsdynamicRange) -> PhysicsmechanicsdynamicRange {
  let result = physics_mechanics_dynamic_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_mechanics_dynamic_range_fill(s : PhysicsmechanicsdynamicRange, v : Double) -> PhysicsmechanicsdynamicRange {
  let result = physics_mechanics_dynamic_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_dynamic_range_min(s : PhysicsmechanicsdynamicRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_dynamic_range_max(s : PhysicsmechanicsdynamicRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_dynamic_range_to_string(s : PhysicsmechanicsdynamicRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsdynamicSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_dynamic_slice_make(size : Int) -> PhysicsmechanicsdynamicSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_dynamic_slice_len(s : PhysicsmechanicsdynamicSlice) -> Int { s.size }

pub fn physics_mechanics_dynamic_slice_get(s : PhysicsmechanicsdynamicSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_dynamic_slice_set(s : PhysicsmechanicsdynamicSlice, i : Int, v : Double) -> PhysicsmechanicsdynamicSlice {
  let result = physics_mechanics_dynamic_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_dynamic_slice_sum(s : PhysicsmechanicsdynamicSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_mechanics_dynamic_slice_mean(s : PhysicsmechanicsdynamicSlice) -> Double {
  if s.size == 0 { 0.0 } else { physics_mechanics_dynamic_slice_sum(s) / s.size.to_double() }
}

pub fn physics_mechanics_dynamic_slice_scale(s : PhysicsmechanicsdynamicSlice, f : Double) -> PhysicsmechanicsdynamicSlice {
  let result = physics_mechanics_dynamic_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_mechanics_dynamic_slice_add(a : PhysicsmechanicsdynamicSlice, b : PhysicsmechanicsdynamicSlice) -> PhysicsmechanicsdynamicSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_mechanics_dynamic_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_mechanics_dynamic_slice_copy(s : PhysicsmechanicsdynamicSlice) -> PhysicsmechanicsdynamicSlice {
  let result = physics_mechanics_dynamic_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_mechanics_dynamic_slice_fill(s : PhysicsmechanicsdynamicSlice, v : Double) -> PhysicsmechanicsdynamicSlice {
  let result = physics_mechanics_dynamic_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_dynamic_slice_min(s : PhysicsmechanicsdynamicSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_dynamic_slice_max(s : PhysicsmechanicsdynamicSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_dynamic_slice_to_string(s : PhysicsmechanicsdynamicSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn physics_mechanics_dynamic_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_mechanics_dynamic_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_mechanics_dynamic_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_mechanics_dynamic_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_mechanics_dynamic_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_mechanics_dynamic_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_mechanics_dynamic_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_mechanics_dynamic_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_mechanics_dynamic_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_mechanics_dynamic_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_mechanics_dynamic_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_mechanics_dynamic_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_mechanics_dynamic_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_mechanics_dynamic_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_mechanics_dynamic_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_mechanics_dynamic_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_mechanics_dynamic_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_mechanics_dynamic_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_mechanics_dynamic_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_mechanics_dynamic_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_mechanics_dynamic_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_mechanics_dynamic_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_mechanics_dynamic_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_mechanics_dynamic_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_mechanics_dynamic_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

