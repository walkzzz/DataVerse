///===
/// extcore/physics_heat_conduction

pub(all) struct PhysicsheatconductionPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn physics_heat_conduction_make_point(x : Double, y : Double) -> PhysicsheatconductionPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn physics_heat_conduction_make_point3(x : Double, y : Double, z : Double) -> PhysicsheatconductionPoint {
  { x, y, z, label: 0 }
}

pub fn physics_heat_conduction_point_x(pt : PhysicsheatconductionPoint) -> Double { pt.x }

pub fn physics_heat_conduction_point_y(pt : PhysicsheatconductionPoint) -> Double { pt.y }

pub fn physics_heat_conduction_point_z(pt : PhysicsheatconductionPoint) -> Double { pt.z }

pub fn physics_heat_conduction_point_label(pt : PhysicsheatconductionPoint) -> Int { pt.label }

pub fn physics_heat_conduction_point_dist(a : PhysicsheatconductionPoint, b : PhysicsheatconductionPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  physics_heat_conduction_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn physics_heat_conduction_point_add(a : PhysicsheatconductionPoint, b : PhysicsheatconductionPoint) -> PhysicsheatconductionPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn physics_heat_conduction_point_sub(a : PhysicsheatconductionPoint, b : PhysicsheatconductionPoint) -> PhysicsheatconductionPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn physics_heat_conduction_point_scale(pt : PhysicsheatconductionPoint, s : Double) -> PhysicsheatconductionPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn physics_heat_conduction_point_dot(a : PhysicsheatconductionPoint, b : PhysicsheatconductionPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn physics_heat_conduction_point_cross(a : PhysicsheatconductionPoint, b : PhysicsheatconductionPoint) -> PhysicsheatconductionPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn physics_heat_conduction_point_norm(pt : PhysicsheatconductionPoint) -> Double {
  physics_heat_conduction_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn physics_heat_conduction_point_normalize(pt : PhysicsheatconductionPoint) -> PhysicsheatconductionPoint {
  let n = physics_heat_conduction_point_norm(pt)
  if n < 0.0000001 { pt } else { physics_heat_conduction_point_scale(pt, 1.0 / n) }
}

pub fn physics_heat_conduction_point_negate(pt : PhysicsheatconductionPoint) -> PhysicsheatconductionPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn physics_heat_conduction_point_mid(a : PhysicsheatconductionPoint, b : PhysicsheatconductionPoint) -> PhysicsheatconductionPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn physics_heat_conduction_point_lerp(a : PhysicsheatconductionPoint, b : PhysicsheatconductionPoint, t : Double) -> PhysicsheatconductionPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn physics_heat_conduction_point_to_string(pt : PhysicsheatconductionPoint) -> String {
  "(" + physics_heat_conduction_dbl(pt.x) + ", " + physics_heat_conduction_dbl(pt.y) + ", " + physics_heat_conduction_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct PhysicsheatconductionSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn physics_heat_conduction_make_series(vals : Array[Double], name : String) -> PhysicsheatconductionSeries {
  { vals, name, meta: 0 }
}

pub fn physics_heat_conduction_series_len(s : PhysicsheatconductionSeries) -> Int { s.vals.length() }

pub fn physics_heat_conduction_series_sum(s : PhysicsheatconductionSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn physics_heat_conduction_series_mean(s : PhysicsheatconductionSeries) -> Double {
  let n = physics_heat_conduction_series_len(s)
  if n == 0 { 0.0 } else { physics_heat_conduction_series_sum(s) / n.to_double() }
}

pub fn physics_heat_conduction_series_min(s : PhysicsheatconductionSeries) -> Double {
  let n = physics_heat_conduction_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn physics_heat_conduction_series_max(s : PhysicsheatconductionSeries) -> Double {
  let n = physics_heat_conduction_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn physics_heat_conduction_series_range(s : PhysicsheatconductionSeries) -> Double {
  physics_heat_conduction_series_max(s) - physics_heat_conduction_series_min(s)
}

pub fn physics_heat_conduction_series_var(s : PhysicsheatconductionSeries) -> Double {
  let n = physics_heat_conduction_series_len(s)
  if n == 0 { 0.0 } else {
    let m = physics_heat_conduction_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn physics_heat_conduction_series_std(s : PhysicsheatconductionSeries) -> Double { physics_heat_conduction_sqrt(physics_heat_conduction_series_var(s)) }

pub fn physics_heat_conduction_series_median(s : PhysicsheatconductionSeries) -> Double {
  let n = physics_heat_conduction_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = physics_heat_conduction_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn physics_heat_conduction_series_scale(s : PhysicsheatconductionSeries, f : Double) -> PhysicsheatconductionSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = physics_heat_conduction_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn physics_heat_conduction_series_add(a : PhysicsheatconductionSeries, b : PhysicsheatconductionSeries) -> PhysicsheatconductionSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = physics_heat_conduction_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn physics_heat_conduction_series_sub(a : PhysicsheatconductionSeries, b : PhysicsheatconductionSeries) -> PhysicsheatconductionSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = physics_heat_conduction_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn physics_heat_conduction_series_normalize(s : PhysicsheatconductionSeries) -> PhysicsheatconductionSeries {
  let mn = physics_heat_conduction_series_min(s)
  let mx = physics_heat_conduction_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = physics_heat_conduction_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn physics_heat_conduction_series_cumsum(s : PhysicsheatconductionSeries) -> PhysicsheatconductionSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = physics_heat_conduction_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn physics_heat_conduction_series_to_string(s : PhysicsheatconductionSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + physics_heat_conduction_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct PhysicsheatconductionMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn physics_heat_conduction_make_matrix(rows : Int, cols : Int, val : Double) -> PhysicsheatconductionMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn physics_heat_conduction_matrix_identity(n : Int) -> PhysicsheatconductionMatrix {
  let m = physics_heat_conduction_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn physics_heat_conduction_matrix_get(m : PhysicsheatconductionMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn physics_heat_conduction_matrix_transpose(m : PhysicsheatconductionMatrix) -> PhysicsheatconductionMatrix {
  let result = physics_heat_conduction_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn physics_heat_conduction_matrix_add(a : PhysicsheatconductionMatrix, b : PhysicsheatconductionMatrix) -> PhysicsheatconductionMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = physics_heat_conduction_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn physics_heat_conduction_matrix_scale(m : PhysicsheatconductionMatrix, s : Double) -> PhysicsheatconductionMatrix {
  let result = physics_heat_conduction_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn physics_heat_conduction_matrix_multiply(a : PhysicsheatconductionMatrix, b : PhysicsheatconductionMatrix) -> PhysicsheatconductionMatrix {
  if a.cols != b.rows { return physics_heat_conduction_make_matrix(a.rows, b.cols, 0.0) }
  let result = physics_heat_conduction_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn physics_heat_conduction_matrix_trace(m : PhysicsheatconductionMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn physics_heat_conduction_matrix_det(m : PhysicsheatconductionMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn physics_heat_conduction_matrix_norm(m : PhysicsheatconductionMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  physics_heat_conduction_sqrt(sum)
}

pub fn physics_heat_conduction_matrix_to_string(m : PhysicsheatconductionMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + physics_heat_conduction_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct PhysicsheatconductionVector {
  comps : Array[Double]
  dim : Int
}

pub fn physics_heat_conduction_make_vector(comps : Array[Double]) -> PhysicsheatconductionVector {
  { comps, dim: comps.length() }
}

pub fn physics_heat_conduction_vector_zero(dim : Int) -> PhysicsheatconductionVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn physics_heat_conduction_vector_add(a : PhysicsheatconductionVector, b : PhysicsheatconductionVector) -> PhysicsheatconductionVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = physics_heat_conduction_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn physics_heat_conduction_vector_sub(a : PhysicsheatconductionVector, b : PhysicsheatconductionVector) -> PhysicsheatconductionVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = physics_heat_conduction_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn physics_heat_conduction_vector_scale(v : PhysicsheatconductionVector, s : Double) -> PhysicsheatconductionVector {
  let mut result = []
  for i in 0..<v.dim { result = physics_heat_conduction_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn physics_heat_conduction_vector_dot(a : PhysicsheatconductionVector, b : PhysicsheatconductionVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn physics_heat_conduction_vector_norm(v : PhysicsheatconductionVector) -> Double { physics_heat_conduction_sqrt(physics_heat_conduction_vector_dot(v, v)) }

pub fn physics_heat_conduction_vector_normalize(v : PhysicsheatconductionVector) -> PhysicsheatconductionVector {
  let n = physics_heat_conduction_vector_norm(v)
  if n < 0.0000001 { v } else { physics_heat_conduction_vector_scale(v, 1.0 / n) }
}

pub fn physics_heat_conduction_vector_dist(a : PhysicsheatconductionVector, b : PhysicsheatconductionVector) -> Double {
  physics_heat_conduction_vector_norm(physics_heat_conduction_vector_sub(a, b))
}

pub fn physics_heat_conduction_vector_to_string(v : PhysicsheatconductionVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + physics_heat_conduction_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn physics_heat_conduction_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn physics_heat_conduction_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = physics_heat_conduction_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn physics_heat_conduction_std(data : Array[Double]) -> Double { physics_heat_conduction_sqrt(physics_heat_conduction_var(data)) }

pub fn physics_heat_conduction_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = physics_heat_conduction_mean(a); let mb = physics_heat_conduction_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn physics_heat_conduction_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = physics_heat_conduction_std(a); let sb = physics_heat_conduction_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { physics_heat_conduction_cov(a, b) / (sa * sb) }
}

pub fn physics_heat_conduction_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = physics_heat_conduction_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn physics_heat_conduction_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn physics_heat_conduction_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn physics_heat_conduction_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  physics_heat_conduction_sqrt(physics_heat_conduction_mse(pred, labels))
}

pub fn physics_heat_conduction_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + physics_heat_conduction_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn physics_heat_conduction_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = physics_heat_conduction_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn physics_heat_conduction_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn physics_heat_conduction_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn physics_heat_conduction_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = physics_heat_conduction_precision(pred, labels, pos); let r = physics_heat_conduction_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn physics_heat_conduction_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn physics_heat_conduction_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = physics_heat_conduction_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn physics_heat_conduction_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn physics_heat_conduction_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn physics_heat_conduction_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = physics_heat_conduction_gcd(a, b)
    (a / g) * b
  }
}

pub fn physics_heat_conduction_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn physics_heat_conduction_fibonacci(n : Int) -> Int {
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

pub fn physics_heat_conduction_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = physics_heat_conduction_min(data); let mx = physics_heat_conduction_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn physics_heat_conduction_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = physics_heat_conduction_mean(data); let sd = physics_heat_conduction_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn physics_heat_conduction_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn physics_heat_conduction_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn physics_heat_conduction_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn physics_heat_conduction_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn physics_heat_conduction_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn physics_heat_conduction_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn physics_heat_conduction_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn physics_heat_conduction_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn physics_heat_conduction_dbl(x : Double) -> String {
  let i = if x >= 0.0 { physics_heat_conduction_int(x) } else { -physics_heat_conduction_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { physics_heat_conduction_int(f * 1000000.0) } else { physics_heat_conduction_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn physics_heat_conduction_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn physics_heat_conduction_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct PhysicsheatconductionFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_conduction_frame_make(size : Int) -> PhysicsheatconductionFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_conduction_frame_len(s : PhysicsheatconductionFrame) -> Int { s.size }

pub fn physics_heat_conduction_frame_get(s : PhysicsheatconductionFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_conduction_frame_set(s : PhysicsheatconductionFrame, i : Int, v : Double) -> PhysicsheatconductionFrame {
  let result = physics_heat_conduction_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_heat_conduction_frame_sum(s : PhysicsheatconductionFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_heat_conduction_frame_mean(s : PhysicsheatconductionFrame) -> Double {
  if s.size == 0 { 0.0 } else { physics_heat_conduction_frame_sum(s) / s.size.to_double() }
}

pub fn physics_heat_conduction_frame_scale(s : PhysicsheatconductionFrame, f : Double) -> PhysicsheatconductionFrame {
  let result = physics_heat_conduction_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_heat_conduction_frame_add(a : PhysicsheatconductionFrame, b : PhysicsheatconductionFrame) -> PhysicsheatconductionFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_heat_conduction_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_heat_conduction_frame_copy(s : PhysicsheatconductionFrame) -> PhysicsheatconductionFrame {
  let result = physics_heat_conduction_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_heat_conduction_frame_fill(s : PhysicsheatconductionFrame, v : Double) -> PhysicsheatconductionFrame {
  let result = physics_heat_conduction_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_heat_conduction_frame_min(s : PhysicsheatconductionFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_heat_conduction_frame_max(s : PhysicsheatconductionFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_heat_conduction_frame_to_string(s : PhysicsheatconductionFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatconductionTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_conduction_table_make(size : Int) -> PhysicsheatconductionTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_conduction_table_len(s : PhysicsheatconductionTable) -> Int { s.size }

pub fn physics_heat_conduction_table_get(s : PhysicsheatconductionTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_conduction_table_set(s : PhysicsheatconductionTable, i : Int, v : Double) -> PhysicsheatconductionTable {
  let result = physics_heat_conduction_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_heat_conduction_table_sum(s : PhysicsheatconductionTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_heat_conduction_table_mean(s : PhysicsheatconductionTable) -> Double {
  if s.size == 0 { 0.0 } else { physics_heat_conduction_table_sum(s) / s.size.to_double() }
}

pub fn physics_heat_conduction_table_scale(s : PhysicsheatconductionTable, f : Double) -> PhysicsheatconductionTable {
  let result = physics_heat_conduction_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_heat_conduction_table_add(a : PhysicsheatconductionTable, b : PhysicsheatconductionTable) -> PhysicsheatconductionTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_heat_conduction_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_heat_conduction_table_copy(s : PhysicsheatconductionTable) -> PhysicsheatconductionTable {
  let result = physics_heat_conduction_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_heat_conduction_table_fill(s : PhysicsheatconductionTable, v : Double) -> PhysicsheatconductionTable {
  let result = physics_heat_conduction_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_heat_conduction_table_min(s : PhysicsheatconductionTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_heat_conduction_table_max(s : PhysicsheatconductionTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_heat_conduction_table_to_string(s : PhysicsheatconductionTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatconductionGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_conduction_graphn_make(size : Int) -> PhysicsheatconductionGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_conduction_graphn_len(s : PhysicsheatconductionGraphN) -> Int { s.size }

pub fn physics_heat_conduction_graphn_get(s : PhysicsheatconductionGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_conduction_graphn_set(s : PhysicsheatconductionGraphN, i : Int, v : Double) -> PhysicsheatconductionGraphN {
  let result = physics_heat_conduction_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_heat_conduction_graphn_sum(s : PhysicsheatconductionGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_heat_conduction_graphn_mean(s : PhysicsheatconductionGraphN) -> Double {
  if s.size == 0 { 0.0 } else { physics_heat_conduction_graphn_sum(s) / s.size.to_double() }
}

pub fn physics_heat_conduction_graphn_scale(s : PhysicsheatconductionGraphN, f : Double) -> PhysicsheatconductionGraphN {
  let result = physics_heat_conduction_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_heat_conduction_graphn_add(a : PhysicsheatconductionGraphN, b : PhysicsheatconductionGraphN) -> PhysicsheatconductionGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_heat_conduction_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_heat_conduction_graphn_copy(s : PhysicsheatconductionGraphN) -> PhysicsheatconductionGraphN {
  let result = physics_heat_conduction_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_heat_conduction_graphn_fill(s : PhysicsheatconductionGraphN, v : Double) -> PhysicsheatconductionGraphN {
  let result = physics_heat_conduction_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_heat_conduction_graphn_min(s : PhysicsheatconductionGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_heat_conduction_graphn_max(s : PhysicsheatconductionGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_heat_conduction_graphn_to_string(s : PhysicsheatconductionGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatconductionNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_conduction_node_make(size : Int) -> PhysicsheatconductionNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_conduction_node_len(s : PhysicsheatconductionNode) -> Int { s.size }

pub fn physics_heat_conduction_node_get(s : PhysicsheatconductionNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_conduction_node_set(s : PhysicsheatconductionNode, i : Int, v : Double) -> PhysicsheatconductionNode {
  let result = physics_heat_conduction_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_heat_conduction_node_sum(s : PhysicsheatconductionNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_heat_conduction_node_mean(s : PhysicsheatconductionNode) -> Double {
  if s.size == 0 { 0.0 } else { physics_heat_conduction_node_sum(s) / s.size.to_double() }
}

pub fn physics_heat_conduction_node_scale(s : PhysicsheatconductionNode, f : Double) -> PhysicsheatconductionNode {
  let result = physics_heat_conduction_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_heat_conduction_node_add(a : PhysicsheatconductionNode, b : PhysicsheatconductionNode) -> PhysicsheatconductionNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_heat_conduction_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_heat_conduction_node_copy(s : PhysicsheatconductionNode) -> PhysicsheatconductionNode {
  let result = physics_heat_conduction_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_heat_conduction_node_fill(s : PhysicsheatconductionNode, v : Double) -> PhysicsheatconductionNode {
  let result = physics_heat_conduction_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_heat_conduction_node_min(s : PhysicsheatconductionNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_heat_conduction_node_max(s : PhysicsheatconductionNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_heat_conduction_node_to_string(s : PhysicsheatconductionNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatconductionEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_conduction_edge_make(size : Int) -> PhysicsheatconductionEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_conduction_edge_len(s : PhysicsheatconductionEdge) -> Int { s.size }

pub fn physics_heat_conduction_edge_get(s : PhysicsheatconductionEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_conduction_edge_set(s : PhysicsheatconductionEdge, i : Int, v : Double) -> PhysicsheatconductionEdge {
  let result = physics_heat_conduction_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_heat_conduction_edge_sum(s : PhysicsheatconductionEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_heat_conduction_edge_mean(s : PhysicsheatconductionEdge) -> Double {
  if s.size == 0 { 0.0 } else { physics_heat_conduction_edge_sum(s) / s.size.to_double() }
}

pub fn physics_heat_conduction_edge_scale(s : PhysicsheatconductionEdge, f : Double) -> PhysicsheatconductionEdge {
  let result = physics_heat_conduction_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_heat_conduction_edge_add(a : PhysicsheatconductionEdge, b : PhysicsheatconductionEdge) -> PhysicsheatconductionEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_heat_conduction_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_heat_conduction_edge_copy(s : PhysicsheatconductionEdge) -> PhysicsheatconductionEdge {
  let result = physics_heat_conduction_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_heat_conduction_edge_fill(s : PhysicsheatconductionEdge, v : Double) -> PhysicsheatconductionEdge {
  let result = physics_heat_conduction_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_heat_conduction_edge_min(s : PhysicsheatconductionEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_heat_conduction_edge_max(s : PhysicsheatconductionEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_heat_conduction_edge_to_string(s : PhysicsheatconductionEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatconductionPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_conduction_path_make(size : Int) -> PhysicsheatconductionPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_conduction_path_len(s : PhysicsheatconductionPath) -> Int { s.size }

pub fn physics_heat_conduction_path_get(s : PhysicsheatconductionPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_conduction_path_set(s : PhysicsheatconductionPath, i : Int, v : Double) -> PhysicsheatconductionPath {
  let result = physics_heat_conduction_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_heat_conduction_path_sum(s : PhysicsheatconductionPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_heat_conduction_path_mean(s : PhysicsheatconductionPath) -> Double {
  if s.size == 0 { 0.0 } else { physics_heat_conduction_path_sum(s) / s.size.to_double() }
}

pub fn physics_heat_conduction_path_scale(s : PhysicsheatconductionPath, f : Double) -> PhysicsheatconductionPath {
  let result = physics_heat_conduction_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_heat_conduction_path_add(a : PhysicsheatconductionPath, b : PhysicsheatconductionPath) -> PhysicsheatconductionPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_heat_conduction_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_heat_conduction_path_copy(s : PhysicsheatconductionPath) -> PhysicsheatconductionPath {
  let result = physics_heat_conduction_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_heat_conduction_path_fill(s : PhysicsheatconductionPath, v : Double) -> PhysicsheatconductionPath {
  let result = physics_heat_conduction_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_heat_conduction_path_min(s : PhysicsheatconductionPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_heat_conduction_path_max(s : PhysicsheatconductionPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_heat_conduction_path_to_string(s : PhysicsheatconductionPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatconductionCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_conduction_cluster_make(size : Int) -> PhysicsheatconductionCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_conduction_cluster_len(s : PhysicsheatconductionCluster) -> Int { s.size }

pub fn physics_heat_conduction_cluster_get(s : PhysicsheatconductionCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_conduction_cluster_set(s : PhysicsheatconductionCluster, i : Int, v : Double) -> PhysicsheatconductionCluster {
  let result = physics_heat_conduction_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_heat_conduction_cluster_sum(s : PhysicsheatconductionCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_heat_conduction_cluster_mean(s : PhysicsheatconductionCluster) -> Double {
  if s.size == 0 { 0.0 } else { physics_heat_conduction_cluster_sum(s) / s.size.to_double() }
}

pub fn physics_heat_conduction_cluster_scale(s : PhysicsheatconductionCluster, f : Double) -> PhysicsheatconductionCluster {
  let result = physics_heat_conduction_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_heat_conduction_cluster_add(a : PhysicsheatconductionCluster, b : PhysicsheatconductionCluster) -> PhysicsheatconductionCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_heat_conduction_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_heat_conduction_cluster_copy(s : PhysicsheatconductionCluster) -> PhysicsheatconductionCluster {
  let result = physics_heat_conduction_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_heat_conduction_cluster_fill(s : PhysicsheatconductionCluster, v : Double) -> PhysicsheatconductionCluster {
  let result = physics_heat_conduction_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_heat_conduction_cluster_min(s : PhysicsheatconductionCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_heat_conduction_cluster_max(s : PhysicsheatconductionCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_heat_conduction_cluster_to_string(s : PhysicsheatconductionCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatconductionModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_conduction_model_make(size : Int) -> PhysicsheatconductionModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_conduction_model_len(s : PhysicsheatconductionModel) -> Int { s.size }

pub fn physics_heat_conduction_model_get(s : PhysicsheatconductionModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_conduction_model_set(s : PhysicsheatconductionModel, i : Int, v : Double) -> PhysicsheatconductionModel {
  let result = physics_heat_conduction_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_heat_conduction_model_sum(s : PhysicsheatconductionModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_heat_conduction_model_mean(s : PhysicsheatconductionModel) -> Double {
  if s.size == 0 { 0.0 } else { physics_heat_conduction_model_sum(s) / s.size.to_double() }
}

pub fn physics_heat_conduction_model_scale(s : PhysicsheatconductionModel, f : Double) -> PhysicsheatconductionModel {
  let result = physics_heat_conduction_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_heat_conduction_model_add(a : PhysicsheatconductionModel, b : PhysicsheatconductionModel) -> PhysicsheatconductionModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_heat_conduction_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_heat_conduction_model_copy(s : PhysicsheatconductionModel) -> PhysicsheatconductionModel {
  let result = physics_heat_conduction_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_heat_conduction_model_fill(s : PhysicsheatconductionModel, v : Double) -> PhysicsheatconductionModel {
  let result = physics_heat_conduction_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_heat_conduction_model_min(s : PhysicsheatconductionModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_heat_conduction_model_max(s : PhysicsheatconductionModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_heat_conduction_model_to_string(s : PhysicsheatconductionModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatconductionLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_conduction_layer_make(size : Int) -> PhysicsheatconductionLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_conduction_layer_len(s : PhysicsheatconductionLayer) -> Int { s.size }

pub fn physics_heat_conduction_layer_get(s : PhysicsheatconductionLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_conduction_layer_set(s : PhysicsheatconductionLayer, i : Int, v : Double) -> PhysicsheatconductionLayer {
  let result = physics_heat_conduction_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_heat_conduction_layer_sum(s : PhysicsheatconductionLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_heat_conduction_layer_mean(s : PhysicsheatconductionLayer) -> Double {
  if s.size == 0 { 0.0 } else { physics_heat_conduction_layer_sum(s) / s.size.to_double() }
}

pub fn physics_heat_conduction_layer_scale(s : PhysicsheatconductionLayer, f : Double) -> PhysicsheatconductionLayer {
  let result = physics_heat_conduction_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_heat_conduction_layer_add(a : PhysicsheatconductionLayer, b : PhysicsheatconductionLayer) -> PhysicsheatconductionLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_heat_conduction_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_heat_conduction_layer_copy(s : PhysicsheatconductionLayer) -> PhysicsheatconductionLayer {
  let result = physics_heat_conduction_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_heat_conduction_layer_fill(s : PhysicsheatconductionLayer, v : Double) -> PhysicsheatconductionLayer {
  let result = physics_heat_conduction_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_heat_conduction_layer_min(s : PhysicsheatconductionLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_heat_conduction_layer_max(s : PhysicsheatconductionLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_heat_conduction_layer_to_string(s : PhysicsheatconductionLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatconductionBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_conduction_buffer_make(size : Int) -> PhysicsheatconductionBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_conduction_buffer_len(s : PhysicsheatconductionBuffer) -> Int { s.size }

pub fn physics_heat_conduction_buffer_get(s : PhysicsheatconductionBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_conduction_buffer_set(s : PhysicsheatconductionBuffer, i : Int, v : Double) -> PhysicsheatconductionBuffer {
  let result = physics_heat_conduction_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_heat_conduction_buffer_sum(s : PhysicsheatconductionBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_heat_conduction_buffer_mean(s : PhysicsheatconductionBuffer) -> Double {
  if s.size == 0 { 0.0 } else { physics_heat_conduction_buffer_sum(s) / s.size.to_double() }
}

pub fn physics_heat_conduction_buffer_scale(s : PhysicsheatconductionBuffer, f : Double) -> PhysicsheatconductionBuffer {
  let result = physics_heat_conduction_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_heat_conduction_buffer_add(a : PhysicsheatconductionBuffer, b : PhysicsheatconductionBuffer) -> PhysicsheatconductionBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_heat_conduction_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_heat_conduction_buffer_copy(s : PhysicsheatconductionBuffer) -> PhysicsheatconductionBuffer {
  let result = physics_heat_conduction_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_heat_conduction_buffer_fill(s : PhysicsheatconductionBuffer, v : Double) -> PhysicsheatconductionBuffer {
  let result = physics_heat_conduction_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_heat_conduction_buffer_min(s : PhysicsheatconductionBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_heat_conduction_buffer_max(s : PhysicsheatconductionBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_heat_conduction_buffer_to_string(s : PhysicsheatconductionBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatconductionCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_conduction_cursor_make(size : Int) -> PhysicsheatconductionCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_conduction_cursor_len(s : PhysicsheatconductionCursor) -> Int { s.size }

pub fn physics_heat_conduction_cursor_get(s : PhysicsheatconductionCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_conduction_cursor_set(s : PhysicsheatconductionCursor, i : Int, v : Double) -> PhysicsheatconductionCursor {
  let result = physics_heat_conduction_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_heat_conduction_cursor_sum(s : PhysicsheatconductionCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_heat_conduction_cursor_mean(s : PhysicsheatconductionCursor) -> Double {
  if s.size == 0 { 0.0 } else { physics_heat_conduction_cursor_sum(s) / s.size.to_double() }
}

pub fn physics_heat_conduction_cursor_scale(s : PhysicsheatconductionCursor, f : Double) -> PhysicsheatconductionCursor {
  let result = physics_heat_conduction_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_heat_conduction_cursor_add(a : PhysicsheatconductionCursor, b : PhysicsheatconductionCursor) -> PhysicsheatconductionCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_heat_conduction_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_heat_conduction_cursor_copy(s : PhysicsheatconductionCursor) -> PhysicsheatconductionCursor {
  let result = physics_heat_conduction_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_heat_conduction_cursor_fill(s : PhysicsheatconductionCursor, v : Double) -> PhysicsheatconductionCursor {
  let result = physics_heat_conduction_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_heat_conduction_cursor_min(s : PhysicsheatconductionCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_heat_conduction_cursor_max(s : PhysicsheatconductionCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_heat_conduction_cursor_to_string(s : PhysicsheatconductionCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatconductionView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_conduction_view_make(size : Int) -> PhysicsheatconductionView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_conduction_view_len(s : PhysicsheatconductionView) -> Int { s.size }

pub fn physics_heat_conduction_view_get(s : PhysicsheatconductionView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_conduction_view_set(s : PhysicsheatconductionView, i : Int, v : Double) -> PhysicsheatconductionView {
  let result = physics_heat_conduction_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_heat_conduction_view_sum(s : PhysicsheatconductionView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_heat_conduction_view_mean(s : PhysicsheatconductionView) -> Double {
  if s.size == 0 { 0.0 } else { physics_heat_conduction_view_sum(s) / s.size.to_double() }
}

pub fn physics_heat_conduction_view_scale(s : PhysicsheatconductionView, f : Double) -> PhysicsheatconductionView {
  let result = physics_heat_conduction_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_heat_conduction_view_add(a : PhysicsheatconductionView, b : PhysicsheatconductionView) -> PhysicsheatconductionView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_heat_conduction_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_heat_conduction_view_copy(s : PhysicsheatconductionView) -> PhysicsheatconductionView {
  let result = physics_heat_conduction_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_heat_conduction_view_fill(s : PhysicsheatconductionView, v : Double) -> PhysicsheatconductionView {
  let result = physics_heat_conduction_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_heat_conduction_view_min(s : PhysicsheatconductionView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_heat_conduction_view_max(s : PhysicsheatconductionView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_heat_conduction_view_to_string(s : PhysicsheatconductionView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatconductionRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_conduction_range_make(size : Int) -> PhysicsheatconductionRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_conduction_range_len(s : PhysicsheatconductionRange) -> Int { s.size }

pub fn physics_heat_conduction_range_get(s : PhysicsheatconductionRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_conduction_range_set(s : PhysicsheatconductionRange, i : Int, v : Double) -> PhysicsheatconductionRange {
  let result = physics_heat_conduction_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_heat_conduction_range_sum(s : PhysicsheatconductionRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_heat_conduction_range_mean(s : PhysicsheatconductionRange) -> Double {
  if s.size == 0 { 0.0 } else { physics_heat_conduction_range_sum(s) / s.size.to_double() }
}

pub fn physics_heat_conduction_range_scale(s : PhysicsheatconductionRange, f : Double) -> PhysicsheatconductionRange {
  let result = physics_heat_conduction_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_heat_conduction_range_add(a : PhysicsheatconductionRange, b : PhysicsheatconductionRange) -> PhysicsheatconductionRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_heat_conduction_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_heat_conduction_range_copy(s : PhysicsheatconductionRange) -> PhysicsheatconductionRange {
  let result = physics_heat_conduction_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_heat_conduction_range_fill(s : PhysicsheatconductionRange, v : Double) -> PhysicsheatconductionRange {
  let result = physics_heat_conduction_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_heat_conduction_range_min(s : PhysicsheatconductionRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_heat_conduction_range_max(s : PhysicsheatconductionRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_heat_conduction_range_to_string(s : PhysicsheatconductionRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatconductionSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_conduction_slice_make(size : Int) -> PhysicsheatconductionSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_conduction_slice_len(s : PhysicsheatconductionSlice) -> Int { s.size }

pub fn physics_heat_conduction_slice_get(s : PhysicsheatconductionSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_conduction_slice_set(s : PhysicsheatconductionSlice, i : Int, v : Double) -> PhysicsheatconductionSlice {
  let result = physics_heat_conduction_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_heat_conduction_slice_sum(s : PhysicsheatconductionSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_heat_conduction_slice_mean(s : PhysicsheatconductionSlice) -> Double {
  if s.size == 0 { 0.0 } else { physics_heat_conduction_slice_sum(s) / s.size.to_double() }
}

pub fn physics_heat_conduction_slice_scale(s : PhysicsheatconductionSlice, f : Double) -> PhysicsheatconductionSlice {
  let result = physics_heat_conduction_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_heat_conduction_slice_add(a : PhysicsheatconductionSlice, b : PhysicsheatconductionSlice) -> PhysicsheatconductionSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_heat_conduction_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_heat_conduction_slice_copy(s : PhysicsheatconductionSlice) -> PhysicsheatconductionSlice {
  let result = physics_heat_conduction_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_heat_conduction_slice_fill(s : PhysicsheatconductionSlice, v : Double) -> PhysicsheatconductionSlice {
  let result = physics_heat_conduction_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_heat_conduction_slice_min(s : PhysicsheatconductionSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_heat_conduction_slice_max(s : PhysicsheatconductionSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_heat_conduction_slice_to_string(s : PhysicsheatconductionSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn physics_heat_conduction_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_heat_conduction_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_heat_conduction_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_heat_conduction_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_heat_conduction_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_heat_conduction_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_heat_conduction_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_heat_conduction_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_heat_conduction_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_heat_conduction_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_heat_conduction_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_heat_conduction_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_heat_conduction_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_heat_conduction_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_heat_conduction_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_heat_conduction_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_heat_conduction_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_heat_conduction_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_heat_conduction_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_heat_conduction_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_heat_conduction_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_heat_conduction_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_heat_conduction_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_heat_conduction_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_heat_conduction_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

