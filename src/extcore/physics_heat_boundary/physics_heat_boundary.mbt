///===
/// extcore/physics_heat_boundary

pub(all) struct PhysicsheatboundaryPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn physics_heat_boundary_make_point(x : Double, y : Double) -> PhysicsheatboundaryPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn physics_heat_boundary_make_point3(x : Double, y : Double, z : Double) -> PhysicsheatboundaryPoint {
  { x, y, z, label: 0 }
}

pub fn physics_heat_boundary_point_x(pt : PhysicsheatboundaryPoint) -> Double { pt.x }

pub fn physics_heat_boundary_point_y(pt : PhysicsheatboundaryPoint) -> Double { pt.y }

pub fn physics_heat_boundary_point_z(pt : PhysicsheatboundaryPoint) -> Double { pt.z }

pub fn physics_heat_boundary_point_label(pt : PhysicsheatboundaryPoint) -> Int { pt.label }

pub fn physics_heat_boundary_point_dist(a : PhysicsheatboundaryPoint, b : PhysicsheatboundaryPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  physics_heat_boundary_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn physics_heat_boundary_point_add(a : PhysicsheatboundaryPoint, b : PhysicsheatboundaryPoint) -> PhysicsheatboundaryPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn physics_heat_boundary_point_sub(a : PhysicsheatboundaryPoint, b : PhysicsheatboundaryPoint) -> PhysicsheatboundaryPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn physics_heat_boundary_point_scale(pt : PhysicsheatboundaryPoint, s : Double) -> PhysicsheatboundaryPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn physics_heat_boundary_point_dot(a : PhysicsheatboundaryPoint, b : PhysicsheatboundaryPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn physics_heat_boundary_point_cross(a : PhysicsheatboundaryPoint, b : PhysicsheatboundaryPoint) -> PhysicsheatboundaryPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn physics_heat_boundary_point_norm(pt : PhysicsheatboundaryPoint) -> Double {
  physics_heat_boundary_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn physics_heat_boundary_point_normalize(pt : PhysicsheatboundaryPoint) -> PhysicsheatboundaryPoint {
  let n = physics_heat_boundary_point_norm(pt)
  if n < 0.0000001 { pt } else { physics_heat_boundary_point_scale(pt, 1.0 / n) }
}

pub fn physics_heat_boundary_point_negate(pt : PhysicsheatboundaryPoint) -> PhysicsheatboundaryPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn physics_heat_boundary_point_mid(a : PhysicsheatboundaryPoint, b : PhysicsheatboundaryPoint) -> PhysicsheatboundaryPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn physics_heat_boundary_point_lerp(a : PhysicsheatboundaryPoint, b : PhysicsheatboundaryPoint, t : Double) -> PhysicsheatboundaryPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn physics_heat_boundary_point_to_string(pt : PhysicsheatboundaryPoint) -> String {
  "(" + physics_heat_boundary_dbl(pt.x) + ", " + physics_heat_boundary_dbl(pt.y) + ", " + physics_heat_boundary_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct PhysicsheatboundarySeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn physics_heat_boundary_make_series(vals : Array[Double], name : String) -> PhysicsheatboundarySeries {
  { vals, name, meta: 0 }
}

pub fn physics_heat_boundary_series_len(s : PhysicsheatboundarySeries) -> Int { s.vals.length() }

pub fn physics_heat_boundary_series_sum(s : PhysicsheatboundarySeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn physics_heat_boundary_series_mean(s : PhysicsheatboundarySeries) -> Double {
  let n = physics_heat_boundary_series_len(s)
  if n == 0 { 0.0 } else { physics_heat_boundary_series_sum(s) / n.to_double() }
}

pub fn physics_heat_boundary_series_min(s : PhysicsheatboundarySeries) -> Double {
  let n = physics_heat_boundary_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn physics_heat_boundary_series_max(s : PhysicsheatboundarySeries) -> Double {
  let n = physics_heat_boundary_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn physics_heat_boundary_series_range(s : PhysicsheatboundarySeries) -> Double {
  physics_heat_boundary_series_max(s) - physics_heat_boundary_series_min(s)
}

pub fn physics_heat_boundary_series_var(s : PhysicsheatboundarySeries) -> Double {
  let n = physics_heat_boundary_series_len(s)
  if n == 0 { 0.0 } else {
    let m = physics_heat_boundary_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn physics_heat_boundary_series_std(s : PhysicsheatboundarySeries) -> Double { physics_heat_boundary_sqrt(physics_heat_boundary_series_var(s)) }

pub fn physics_heat_boundary_series_median(s : PhysicsheatboundarySeries) -> Double {
  let n = physics_heat_boundary_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = physics_heat_boundary_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn physics_heat_boundary_series_scale(s : PhysicsheatboundarySeries, f : Double) -> PhysicsheatboundarySeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = physics_heat_boundary_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn physics_heat_boundary_series_add(a : PhysicsheatboundarySeries, b : PhysicsheatboundarySeries) -> PhysicsheatboundarySeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = physics_heat_boundary_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn physics_heat_boundary_series_sub(a : PhysicsheatboundarySeries, b : PhysicsheatboundarySeries) -> PhysicsheatboundarySeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = physics_heat_boundary_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn physics_heat_boundary_series_normalize(s : PhysicsheatboundarySeries) -> PhysicsheatboundarySeries {
  let mn = physics_heat_boundary_series_min(s)
  let mx = physics_heat_boundary_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = physics_heat_boundary_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn physics_heat_boundary_series_cumsum(s : PhysicsheatboundarySeries) -> PhysicsheatboundarySeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = physics_heat_boundary_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn physics_heat_boundary_series_to_string(s : PhysicsheatboundarySeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + physics_heat_boundary_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct PhysicsheatboundaryMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn physics_heat_boundary_make_matrix(rows : Int, cols : Int, val : Double) -> PhysicsheatboundaryMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn physics_heat_boundary_matrix_identity(n : Int) -> PhysicsheatboundaryMatrix {
  let m = physics_heat_boundary_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn physics_heat_boundary_matrix_get(m : PhysicsheatboundaryMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn physics_heat_boundary_matrix_transpose(m : PhysicsheatboundaryMatrix) -> PhysicsheatboundaryMatrix {
  let result = physics_heat_boundary_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn physics_heat_boundary_matrix_add(a : PhysicsheatboundaryMatrix, b : PhysicsheatboundaryMatrix) -> PhysicsheatboundaryMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = physics_heat_boundary_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn physics_heat_boundary_matrix_scale(m : PhysicsheatboundaryMatrix, s : Double) -> PhysicsheatboundaryMatrix {
  let result = physics_heat_boundary_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn physics_heat_boundary_matrix_multiply(a : PhysicsheatboundaryMatrix, b : PhysicsheatboundaryMatrix) -> PhysicsheatboundaryMatrix {
  if a.cols != b.rows { return physics_heat_boundary_make_matrix(a.rows, b.cols, 0.0) }
  let result = physics_heat_boundary_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn physics_heat_boundary_matrix_trace(m : PhysicsheatboundaryMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn physics_heat_boundary_matrix_det(m : PhysicsheatboundaryMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn physics_heat_boundary_matrix_norm(m : PhysicsheatboundaryMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  physics_heat_boundary_sqrt(sum)
}

pub fn physics_heat_boundary_matrix_to_string(m : PhysicsheatboundaryMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + physics_heat_boundary_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct PhysicsheatboundaryVector {
  comps : Array[Double]
  dim : Int
}

pub fn physics_heat_boundary_make_vector(comps : Array[Double]) -> PhysicsheatboundaryVector {
  { comps, dim: comps.length() }
}

pub fn physics_heat_boundary_vector_zero(dim : Int) -> PhysicsheatboundaryVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn physics_heat_boundary_vector_add(a : PhysicsheatboundaryVector, b : PhysicsheatboundaryVector) -> PhysicsheatboundaryVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = physics_heat_boundary_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn physics_heat_boundary_vector_sub(a : PhysicsheatboundaryVector, b : PhysicsheatboundaryVector) -> PhysicsheatboundaryVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = physics_heat_boundary_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn physics_heat_boundary_vector_scale(v : PhysicsheatboundaryVector, s : Double) -> PhysicsheatboundaryVector {
  let mut result = []
  for i in 0..<v.dim { result = physics_heat_boundary_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn physics_heat_boundary_vector_dot(a : PhysicsheatboundaryVector, b : PhysicsheatboundaryVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn physics_heat_boundary_vector_norm(v : PhysicsheatboundaryVector) -> Double { physics_heat_boundary_sqrt(physics_heat_boundary_vector_dot(v, v)) }

pub fn physics_heat_boundary_vector_normalize(v : PhysicsheatboundaryVector) -> PhysicsheatboundaryVector {
  let n = physics_heat_boundary_vector_norm(v)
  if n < 0.0000001 { v } else { physics_heat_boundary_vector_scale(v, 1.0 / n) }
}

pub fn physics_heat_boundary_vector_dist(a : PhysicsheatboundaryVector, b : PhysicsheatboundaryVector) -> Double {
  physics_heat_boundary_vector_norm(physics_heat_boundary_vector_sub(a, b))
}

pub fn physics_heat_boundary_vector_to_string(v : PhysicsheatboundaryVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + physics_heat_boundary_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn physics_heat_boundary_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn physics_heat_boundary_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = physics_heat_boundary_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn physics_heat_boundary_std(data : Array[Double]) -> Double { physics_heat_boundary_sqrt(physics_heat_boundary_var(data)) }

pub fn physics_heat_boundary_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = physics_heat_boundary_mean(a); let mb = physics_heat_boundary_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn physics_heat_boundary_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = physics_heat_boundary_std(a); let sb = physics_heat_boundary_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { physics_heat_boundary_cov(a, b) / (sa * sb) }
}

pub fn physics_heat_boundary_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = physics_heat_boundary_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn physics_heat_boundary_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn physics_heat_boundary_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn physics_heat_boundary_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  physics_heat_boundary_sqrt(physics_heat_boundary_mse(pred, labels))
}

pub fn physics_heat_boundary_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + physics_heat_boundary_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn physics_heat_boundary_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = physics_heat_boundary_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn physics_heat_boundary_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn physics_heat_boundary_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn physics_heat_boundary_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = physics_heat_boundary_precision(pred, labels, pos); let r = physics_heat_boundary_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn physics_heat_boundary_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn physics_heat_boundary_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = physics_heat_boundary_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn physics_heat_boundary_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn physics_heat_boundary_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn physics_heat_boundary_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = physics_heat_boundary_gcd(a, b)
    (a / g) * b
  }
}

pub fn physics_heat_boundary_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn physics_heat_boundary_fibonacci(n : Int) -> Int {
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

pub fn physics_heat_boundary_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = physics_heat_boundary_min(data); let mx = physics_heat_boundary_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn physics_heat_boundary_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = physics_heat_boundary_mean(data); let sd = physics_heat_boundary_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn physics_heat_boundary_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn physics_heat_boundary_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn physics_heat_boundary_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn physics_heat_boundary_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn physics_heat_boundary_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn physics_heat_boundary_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn physics_heat_boundary_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn physics_heat_boundary_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn physics_heat_boundary_dbl(x : Double) -> String {
  let i = if x >= 0.0 { physics_heat_boundary_int(x) } else { -physics_heat_boundary_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { physics_heat_boundary_int(f * 1000000.0) } else { physics_heat_boundary_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn physics_heat_boundary_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn physics_heat_boundary_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct PhysicsheatboundaryFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_boundary_frame_make(size : Int) -> PhysicsheatboundaryFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_boundary_frame_len(s : PhysicsheatboundaryFrame) -> Int { s.size }

pub fn physics_heat_boundary_frame_get(s : PhysicsheatboundaryFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_boundary_frame_set(s : PhysicsheatboundaryFrame, i : Int, v : Double) -> PhysicsheatboundaryFrame {
  let result = physics_heat_boundary_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_heat_boundary_frame_sum(s : PhysicsheatboundaryFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_heat_boundary_frame_mean(s : PhysicsheatboundaryFrame) -> Double {
  if s.size == 0 { 0.0 } else { physics_heat_boundary_frame_sum(s) / s.size.to_double() }
}

pub fn physics_heat_boundary_frame_scale(s : PhysicsheatboundaryFrame, f : Double) -> PhysicsheatboundaryFrame {
  let result = physics_heat_boundary_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_heat_boundary_frame_add(a : PhysicsheatboundaryFrame, b : PhysicsheatboundaryFrame) -> PhysicsheatboundaryFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_heat_boundary_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_heat_boundary_frame_copy(s : PhysicsheatboundaryFrame) -> PhysicsheatboundaryFrame {
  let result = physics_heat_boundary_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_heat_boundary_frame_fill(s : PhysicsheatboundaryFrame, v : Double) -> PhysicsheatboundaryFrame {
  let result = physics_heat_boundary_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_heat_boundary_frame_min(s : PhysicsheatboundaryFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_heat_boundary_frame_max(s : PhysicsheatboundaryFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_heat_boundary_frame_to_string(s : PhysicsheatboundaryFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatboundaryTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_boundary_table_make(size : Int) -> PhysicsheatboundaryTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_boundary_table_len(s : PhysicsheatboundaryTable) -> Int { s.size }

pub fn physics_heat_boundary_table_get(s : PhysicsheatboundaryTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_boundary_table_set(s : PhysicsheatboundaryTable, i : Int, v : Double) -> PhysicsheatboundaryTable {
  let result = physics_heat_boundary_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_heat_boundary_table_sum(s : PhysicsheatboundaryTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_heat_boundary_table_mean(s : PhysicsheatboundaryTable) -> Double {
  if s.size == 0 { 0.0 } else { physics_heat_boundary_table_sum(s) / s.size.to_double() }
}

pub fn physics_heat_boundary_table_scale(s : PhysicsheatboundaryTable, f : Double) -> PhysicsheatboundaryTable {
  let result = physics_heat_boundary_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_heat_boundary_table_add(a : PhysicsheatboundaryTable, b : PhysicsheatboundaryTable) -> PhysicsheatboundaryTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_heat_boundary_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_heat_boundary_table_copy(s : PhysicsheatboundaryTable) -> PhysicsheatboundaryTable {
  let result = physics_heat_boundary_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_heat_boundary_table_fill(s : PhysicsheatboundaryTable, v : Double) -> PhysicsheatboundaryTable {
  let result = physics_heat_boundary_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_heat_boundary_table_min(s : PhysicsheatboundaryTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_heat_boundary_table_max(s : PhysicsheatboundaryTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_heat_boundary_table_to_string(s : PhysicsheatboundaryTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatboundaryGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_boundary_graphn_make(size : Int) -> PhysicsheatboundaryGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_boundary_graphn_len(s : PhysicsheatboundaryGraphN) -> Int { s.size }

pub fn physics_heat_boundary_graphn_get(s : PhysicsheatboundaryGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_boundary_graphn_set(s : PhysicsheatboundaryGraphN, i : Int, v : Double) -> PhysicsheatboundaryGraphN {
  let result = physics_heat_boundary_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_heat_boundary_graphn_sum(s : PhysicsheatboundaryGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_heat_boundary_graphn_mean(s : PhysicsheatboundaryGraphN) -> Double {
  if s.size == 0 { 0.0 } else { physics_heat_boundary_graphn_sum(s) / s.size.to_double() }
}

pub fn physics_heat_boundary_graphn_scale(s : PhysicsheatboundaryGraphN, f : Double) -> PhysicsheatboundaryGraphN {
  let result = physics_heat_boundary_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_heat_boundary_graphn_add(a : PhysicsheatboundaryGraphN, b : PhysicsheatboundaryGraphN) -> PhysicsheatboundaryGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_heat_boundary_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_heat_boundary_graphn_copy(s : PhysicsheatboundaryGraphN) -> PhysicsheatboundaryGraphN {
  let result = physics_heat_boundary_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_heat_boundary_graphn_fill(s : PhysicsheatboundaryGraphN, v : Double) -> PhysicsheatboundaryGraphN {
  let result = physics_heat_boundary_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_heat_boundary_graphn_min(s : PhysicsheatboundaryGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_heat_boundary_graphn_max(s : PhysicsheatboundaryGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_heat_boundary_graphn_to_string(s : PhysicsheatboundaryGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatboundaryNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_boundary_node_make(size : Int) -> PhysicsheatboundaryNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_boundary_node_len(s : PhysicsheatboundaryNode) -> Int { s.size }

pub fn physics_heat_boundary_node_get(s : PhysicsheatboundaryNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_boundary_node_set(s : PhysicsheatboundaryNode, i : Int, v : Double) -> PhysicsheatboundaryNode {
  let result = physics_heat_boundary_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_heat_boundary_node_sum(s : PhysicsheatboundaryNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_heat_boundary_node_mean(s : PhysicsheatboundaryNode) -> Double {
  if s.size == 0 { 0.0 } else { physics_heat_boundary_node_sum(s) / s.size.to_double() }
}

pub fn physics_heat_boundary_node_scale(s : PhysicsheatboundaryNode, f : Double) -> PhysicsheatboundaryNode {
  let result = physics_heat_boundary_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_heat_boundary_node_add(a : PhysicsheatboundaryNode, b : PhysicsheatboundaryNode) -> PhysicsheatboundaryNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_heat_boundary_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_heat_boundary_node_copy(s : PhysicsheatboundaryNode) -> PhysicsheatboundaryNode {
  let result = physics_heat_boundary_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_heat_boundary_node_fill(s : PhysicsheatboundaryNode, v : Double) -> PhysicsheatboundaryNode {
  let result = physics_heat_boundary_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_heat_boundary_node_min(s : PhysicsheatboundaryNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_heat_boundary_node_max(s : PhysicsheatboundaryNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_heat_boundary_node_to_string(s : PhysicsheatboundaryNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatboundaryEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_boundary_edge_make(size : Int) -> PhysicsheatboundaryEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_boundary_edge_len(s : PhysicsheatboundaryEdge) -> Int { s.size }

pub fn physics_heat_boundary_edge_get(s : PhysicsheatboundaryEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_boundary_edge_set(s : PhysicsheatboundaryEdge, i : Int, v : Double) -> PhysicsheatboundaryEdge {
  let result = physics_heat_boundary_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_heat_boundary_edge_sum(s : PhysicsheatboundaryEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_heat_boundary_edge_mean(s : PhysicsheatboundaryEdge) -> Double {
  if s.size == 0 { 0.0 } else { physics_heat_boundary_edge_sum(s) / s.size.to_double() }
}

pub fn physics_heat_boundary_edge_scale(s : PhysicsheatboundaryEdge, f : Double) -> PhysicsheatboundaryEdge {
  let result = physics_heat_boundary_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_heat_boundary_edge_add(a : PhysicsheatboundaryEdge, b : PhysicsheatboundaryEdge) -> PhysicsheatboundaryEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_heat_boundary_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_heat_boundary_edge_copy(s : PhysicsheatboundaryEdge) -> PhysicsheatboundaryEdge {
  let result = physics_heat_boundary_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_heat_boundary_edge_fill(s : PhysicsheatboundaryEdge, v : Double) -> PhysicsheatboundaryEdge {
  let result = physics_heat_boundary_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_heat_boundary_edge_min(s : PhysicsheatboundaryEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_heat_boundary_edge_max(s : PhysicsheatboundaryEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_heat_boundary_edge_to_string(s : PhysicsheatboundaryEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatboundaryPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_boundary_path_make(size : Int) -> PhysicsheatboundaryPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_boundary_path_len(s : PhysicsheatboundaryPath) -> Int { s.size }

pub fn physics_heat_boundary_path_get(s : PhysicsheatboundaryPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_boundary_path_set(s : PhysicsheatboundaryPath, i : Int, v : Double) -> PhysicsheatboundaryPath {
  let result = physics_heat_boundary_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_heat_boundary_path_sum(s : PhysicsheatboundaryPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_heat_boundary_path_mean(s : PhysicsheatboundaryPath) -> Double {
  if s.size == 0 { 0.0 } else { physics_heat_boundary_path_sum(s) / s.size.to_double() }
}

pub fn physics_heat_boundary_path_scale(s : PhysicsheatboundaryPath, f : Double) -> PhysicsheatboundaryPath {
  let result = physics_heat_boundary_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_heat_boundary_path_add(a : PhysicsheatboundaryPath, b : PhysicsheatboundaryPath) -> PhysicsheatboundaryPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_heat_boundary_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_heat_boundary_path_copy(s : PhysicsheatboundaryPath) -> PhysicsheatboundaryPath {
  let result = physics_heat_boundary_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_heat_boundary_path_fill(s : PhysicsheatboundaryPath, v : Double) -> PhysicsheatboundaryPath {
  let result = physics_heat_boundary_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_heat_boundary_path_min(s : PhysicsheatboundaryPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_heat_boundary_path_max(s : PhysicsheatboundaryPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_heat_boundary_path_to_string(s : PhysicsheatboundaryPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatboundaryCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_boundary_cluster_make(size : Int) -> PhysicsheatboundaryCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_boundary_cluster_len(s : PhysicsheatboundaryCluster) -> Int { s.size }

pub fn physics_heat_boundary_cluster_get(s : PhysicsheatboundaryCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_boundary_cluster_set(s : PhysicsheatboundaryCluster, i : Int, v : Double) -> PhysicsheatboundaryCluster {
  let result = physics_heat_boundary_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_heat_boundary_cluster_sum(s : PhysicsheatboundaryCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_heat_boundary_cluster_mean(s : PhysicsheatboundaryCluster) -> Double {
  if s.size == 0 { 0.0 } else { physics_heat_boundary_cluster_sum(s) / s.size.to_double() }
}

pub fn physics_heat_boundary_cluster_scale(s : PhysicsheatboundaryCluster, f : Double) -> PhysicsheatboundaryCluster {
  let result = physics_heat_boundary_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_heat_boundary_cluster_add(a : PhysicsheatboundaryCluster, b : PhysicsheatboundaryCluster) -> PhysicsheatboundaryCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_heat_boundary_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_heat_boundary_cluster_copy(s : PhysicsheatboundaryCluster) -> PhysicsheatboundaryCluster {
  let result = physics_heat_boundary_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_heat_boundary_cluster_fill(s : PhysicsheatboundaryCluster, v : Double) -> PhysicsheatboundaryCluster {
  let result = physics_heat_boundary_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_heat_boundary_cluster_min(s : PhysicsheatboundaryCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_heat_boundary_cluster_max(s : PhysicsheatboundaryCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_heat_boundary_cluster_to_string(s : PhysicsheatboundaryCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatboundaryModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_boundary_model_make(size : Int) -> PhysicsheatboundaryModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_boundary_model_len(s : PhysicsheatboundaryModel) -> Int { s.size }

pub fn physics_heat_boundary_model_get(s : PhysicsheatboundaryModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_boundary_model_set(s : PhysicsheatboundaryModel, i : Int, v : Double) -> PhysicsheatboundaryModel {
  let result = physics_heat_boundary_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_heat_boundary_model_sum(s : PhysicsheatboundaryModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_heat_boundary_model_mean(s : PhysicsheatboundaryModel) -> Double {
  if s.size == 0 { 0.0 } else { physics_heat_boundary_model_sum(s) / s.size.to_double() }
}

pub fn physics_heat_boundary_model_scale(s : PhysicsheatboundaryModel, f : Double) -> PhysicsheatboundaryModel {
  let result = physics_heat_boundary_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_heat_boundary_model_add(a : PhysicsheatboundaryModel, b : PhysicsheatboundaryModel) -> PhysicsheatboundaryModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_heat_boundary_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_heat_boundary_model_copy(s : PhysicsheatboundaryModel) -> PhysicsheatboundaryModel {
  let result = physics_heat_boundary_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_heat_boundary_model_fill(s : PhysicsheatboundaryModel, v : Double) -> PhysicsheatboundaryModel {
  let result = physics_heat_boundary_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_heat_boundary_model_min(s : PhysicsheatboundaryModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_heat_boundary_model_max(s : PhysicsheatboundaryModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_heat_boundary_model_to_string(s : PhysicsheatboundaryModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatboundaryLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_boundary_layer_make(size : Int) -> PhysicsheatboundaryLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_boundary_layer_len(s : PhysicsheatboundaryLayer) -> Int { s.size }

pub fn physics_heat_boundary_layer_get(s : PhysicsheatboundaryLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_boundary_layer_set(s : PhysicsheatboundaryLayer, i : Int, v : Double) -> PhysicsheatboundaryLayer {
  let result = physics_heat_boundary_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_heat_boundary_layer_sum(s : PhysicsheatboundaryLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_heat_boundary_layer_mean(s : PhysicsheatboundaryLayer) -> Double {
  if s.size == 0 { 0.0 } else { physics_heat_boundary_layer_sum(s) / s.size.to_double() }
}

pub fn physics_heat_boundary_layer_scale(s : PhysicsheatboundaryLayer, f : Double) -> PhysicsheatboundaryLayer {
  let result = physics_heat_boundary_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_heat_boundary_layer_add(a : PhysicsheatboundaryLayer, b : PhysicsheatboundaryLayer) -> PhysicsheatboundaryLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_heat_boundary_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_heat_boundary_layer_copy(s : PhysicsheatboundaryLayer) -> PhysicsheatboundaryLayer {
  let result = physics_heat_boundary_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_heat_boundary_layer_fill(s : PhysicsheatboundaryLayer, v : Double) -> PhysicsheatboundaryLayer {
  let result = physics_heat_boundary_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_heat_boundary_layer_min(s : PhysicsheatboundaryLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_heat_boundary_layer_max(s : PhysicsheatboundaryLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_heat_boundary_layer_to_string(s : PhysicsheatboundaryLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatboundaryBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_boundary_buffer_make(size : Int) -> PhysicsheatboundaryBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_boundary_buffer_len(s : PhysicsheatboundaryBuffer) -> Int { s.size }

pub fn physics_heat_boundary_buffer_get(s : PhysicsheatboundaryBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_boundary_buffer_set(s : PhysicsheatboundaryBuffer, i : Int, v : Double) -> PhysicsheatboundaryBuffer {
  let result = physics_heat_boundary_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_heat_boundary_buffer_sum(s : PhysicsheatboundaryBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_heat_boundary_buffer_mean(s : PhysicsheatboundaryBuffer) -> Double {
  if s.size == 0 { 0.0 } else { physics_heat_boundary_buffer_sum(s) / s.size.to_double() }
}

pub fn physics_heat_boundary_buffer_scale(s : PhysicsheatboundaryBuffer, f : Double) -> PhysicsheatboundaryBuffer {
  let result = physics_heat_boundary_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_heat_boundary_buffer_add(a : PhysicsheatboundaryBuffer, b : PhysicsheatboundaryBuffer) -> PhysicsheatboundaryBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_heat_boundary_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_heat_boundary_buffer_copy(s : PhysicsheatboundaryBuffer) -> PhysicsheatboundaryBuffer {
  let result = physics_heat_boundary_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_heat_boundary_buffer_fill(s : PhysicsheatboundaryBuffer, v : Double) -> PhysicsheatboundaryBuffer {
  let result = physics_heat_boundary_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_heat_boundary_buffer_min(s : PhysicsheatboundaryBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_heat_boundary_buffer_max(s : PhysicsheatboundaryBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_heat_boundary_buffer_to_string(s : PhysicsheatboundaryBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatboundaryCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_boundary_cursor_make(size : Int) -> PhysicsheatboundaryCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_boundary_cursor_len(s : PhysicsheatboundaryCursor) -> Int { s.size }

pub fn physics_heat_boundary_cursor_get(s : PhysicsheatboundaryCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_boundary_cursor_set(s : PhysicsheatboundaryCursor, i : Int, v : Double) -> PhysicsheatboundaryCursor {
  let result = physics_heat_boundary_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_heat_boundary_cursor_sum(s : PhysicsheatboundaryCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_heat_boundary_cursor_mean(s : PhysicsheatboundaryCursor) -> Double {
  if s.size == 0 { 0.0 } else { physics_heat_boundary_cursor_sum(s) / s.size.to_double() }
}

pub fn physics_heat_boundary_cursor_scale(s : PhysicsheatboundaryCursor, f : Double) -> PhysicsheatboundaryCursor {
  let result = physics_heat_boundary_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_heat_boundary_cursor_add(a : PhysicsheatboundaryCursor, b : PhysicsheatboundaryCursor) -> PhysicsheatboundaryCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_heat_boundary_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_heat_boundary_cursor_copy(s : PhysicsheatboundaryCursor) -> PhysicsheatboundaryCursor {
  let result = physics_heat_boundary_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_heat_boundary_cursor_fill(s : PhysicsheatboundaryCursor, v : Double) -> PhysicsheatboundaryCursor {
  let result = physics_heat_boundary_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_heat_boundary_cursor_min(s : PhysicsheatboundaryCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_heat_boundary_cursor_max(s : PhysicsheatboundaryCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_heat_boundary_cursor_to_string(s : PhysicsheatboundaryCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatboundaryView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_boundary_view_make(size : Int) -> PhysicsheatboundaryView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_boundary_view_len(s : PhysicsheatboundaryView) -> Int { s.size }

pub fn physics_heat_boundary_view_get(s : PhysicsheatboundaryView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_boundary_view_set(s : PhysicsheatboundaryView, i : Int, v : Double) -> PhysicsheatboundaryView {
  let result = physics_heat_boundary_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_heat_boundary_view_sum(s : PhysicsheatboundaryView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_heat_boundary_view_mean(s : PhysicsheatboundaryView) -> Double {
  if s.size == 0 { 0.0 } else { physics_heat_boundary_view_sum(s) / s.size.to_double() }
}

pub fn physics_heat_boundary_view_scale(s : PhysicsheatboundaryView, f : Double) -> PhysicsheatboundaryView {
  let result = physics_heat_boundary_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_heat_boundary_view_add(a : PhysicsheatboundaryView, b : PhysicsheatboundaryView) -> PhysicsheatboundaryView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_heat_boundary_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_heat_boundary_view_copy(s : PhysicsheatboundaryView) -> PhysicsheatboundaryView {
  let result = physics_heat_boundary_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_heat_boundary_view_fill(s : PhysicsheatboundaryView, v : Double) -> PhysicsheatboundaryView {
  let result = physics_heat_boundary_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_heat_boundary_view_min(s : PhysicsheatboundaryView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_heat_boundary_view_max(s : PhysicsheatboundaryView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_heat_boundary_view_to_string(s : PhysicsheatboundaryView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatboundaryRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_boundary_range_make(size : Int) -> PhysicsheatboundaryRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_boundary_range_len(s : PhysicsheatboundaryRange) -> Int { s.size }

pub fn physics_heat_boundary_range_get(s : PhysicsheatboundaryRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_boundary_range_set(s : PhysicsheatboundaryRange, i : Int, v : Double) -> PhysicsheatboundaryRange {
  let result = physics_heat_boundary_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_heat_boundary_range_sum(s : PhysicsheatboundaryRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_heat_boundary_range_mean(s : PhysicsheatboundaryRange) -> Double {
  if s.size == 0 { 0.0 } else { physics_heat_boundary_range_sum(s) / s.size.to_double() }
}

pub fn physics_heat_boundary_range_scale(s : PhysicsheatboundaryRange, f : Double) -> PhysicsheatboundaryRange {
  let result = physics_heat_boundary_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_heat_boundary_range_add(a : PhysicsheatboundaryRange, b : PhysicsheatboundaryRange) -> PhysicsheatboundaryRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_heat_boundary_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_heat_boundary_range_copy(s : PhysicsheatboundaryRange) -> PhysicsheatboundaryRange {
  let result = physics_heat_boundary_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_heat_boundary_range_fill(s : PhysicsheatboundaryRange, v : Double) -> PhysicsheatboundaryRange {
  let result = physics_heat_boundary_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_heat_boundary_range_min(s : PhysicsheatboundaryRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_heat_boundary_range_max(s : PhysicsheatboundaryRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_heat_boundary_range_to_string(s : PhysicsheatboundaryRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatboundarySlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_boundary_slice_make(size : Int) -> PhysicsheatboundarySlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_boundary_slice_len(s : PhysicsheatboundarySlice) -> Int { s.size }

pub fn physics_heat_boundary_slice_get(s : PhysicsheatboundarySlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_boundary_slice_set(s : PhysicsheatboundarySlice, i : Int, v : Double) -> PhysicsheatboundarySlice {
  let result = physics_heat_boundary_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_heat_boundary_slice_sum(s : PhysicsheatboundarySlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_heat_boundary_slice_mean(s : PhysicsheatboundarySlice) -> Double {
  if s.size == 0 { 0.0 } else { physics_heat_boundary_slice_sum(s) / s.size.to_double() }
}

pub fn physics_heat_boundary_slice_scale(s : PhysicsheatboundarySlice, f : Double) -> PhysicsheatboundarySlice {
  let result = physics_heat_boundary_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_heat_boundary_slice_add(a : PhysicsheatboundarySlice, b : PhysicsheatboundarySlice) -> PhysicsheatboundarySlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_heat_boundary_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_heat_boundary_slice_copy(s : PhysicsheatboundarySlice) -> PhysicsheatboundarySlice {
  let result = physics_heat_boundary_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_heat_boundary_slice_fill(s : PhysicsheatboundarySlice, v : Double) -> PhysicsheatboundarySlice {
  let result = physics_heat_boundary_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_heat_boundary_slice_min(s : PhysicsheatboundarySlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_heat_boundary_slice_max(s : PhysicsheatboundarySlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_heat_boundary_slice_to_string(s : PhysicsheatboundarySlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn physics_heat_boundary_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_heat_boundary_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_heat_boundary_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_heat_boundary_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_heat_boundary_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_heat_boundary_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_heat_boundary_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_heat_boundary_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_heat_boundary_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_heat_boundary_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_heat_boundary_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_heat_boundary_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_heat_boundary_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_heat_boundary_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_heat_boundary_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_heat_boundary_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_heat_boundary_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_heat_boundary_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_heat_boundary_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_heat_boundary_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_heat_boundary_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_heat_boundary_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_heat_boundary_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_heat_boundary_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_heat_boundary_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

