///===
/// extcore/physics_fluid_turbulence

pub(all) struct PhysicsfluidturbulencePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn physics_fluid_turbulence_make_point(x : Double, y : Double) -> PhysicsfluidturbulencePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn physics_fluid_turbulence_make_point3(x : Double, y : Double, z : Double) -> PhysicsfluidturbulencePoint {
  { x, y, z, label: 0 }
}

pub fn physics_fluid_turbulence_point_x(pt : PhysicsfluidturbulencePoint) -> Double { pt.x }

pub fn physics_fluid_turbulence_point_y(pt : PhysicsfluidturbulencePoint) -> Double { pt.y }

pub fn physics_fluid_turbulence_point_z(pt : PhysicsfluidturbulencePoint) -> Double { pt.z }

pub fn physics_fluid_turbulence_point_label(pt : PhysicsfluidturbulencePoint) -> Int { pt.label }

pub fn physics_fluid_turbulence_point_dist(a : PhysicsfluidturbulencePoint, b : PhysicsfluidturbulencePoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  physics_fluid_turbulence_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn physics_fluid_turbulence_point_add(a : PhysicsfluidturbulencePoint, b : PhysicsfluidturbulencePoint) -> PhysicsfluidturbulencePoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn physics_fluid_turbulence_point_sub(a : PhysicsfluidturbulencePoint, b : PhysicsfluidturbulencePoint) -> PhysicsfluidturbulencePoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn physics_fluid_turbulence_point_scale(pt : PhysicsfluidturbulencePoint, s : Double) -> PhysicsfluidturbulencePoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn physics_fluid_turbulence_point_dot(a : PhysicsfluidturbulencePoint, b : PhysicsfluidturbulencePoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn physics_fluid_turbulence_point_cross(a : PhysicsfluidturbulencePoint, b : PhysicsfluidturbulencePoint) -> PhysicsfluidturbulencePoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn physics_fluid_turbulence_point_norm(pt : PhysicsfluidturbulencePoint) -> Double {
  physics_fluid_turbulence_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn physics_fluid_turbulence_point_normalize(pt : PhysicsfluidturbulencePoint) -> PhysicsfluidturbulencePoint {
  let n = physics_fluid_turbulence_point_norm(pt)
  if n < 0.0000001 { pt } else { physics_fluid_turbulence_point_scale(pt, 1.0 / n) }
}

pub fn physics_fluid_turbulence_point_negate(pt : PhysicsfluidturbulencePoint) -> PhysicsfluidturbulencePoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn physics_fluid_turbulence_point_mid(a : PhysicsfluidturbulencePoint, b : PhysicsfluidturbulencePoint) -> PhysicsfluidturbulencePoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn physics_fluid_turbulence_point_lerp(a : PhysicsfluidturbulencePoint, b : PhysicsfluidturbulencePoint, t : Double) -> PhysicsfluidturbulencePoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn physics_fluid_turbulence_point_to_string(pt : PhysicsfluidturbulencePoint) -> String {
  "(" + physics_fluid_turbulence_dbl(pt.x) + ", " + physics_fluid_turbulence_dbl(pt.y) + ", " + physics_fluid_turbulence_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct PhysicsfluidturbulenceSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn physics_fluid_turbulence_make_series(vals : Array[Double], name : String) -> PhysicsfluidturbulenceSeries {
  { vals, name, meta: 0 }
}

pub fn physics_fluid_turbulence_series_len(s : PhysicsfluidturbulenceSeries) -> Int { s.vals.length() }

pub fn physics_fluid_turbulence_series_sum(s : PhysicsfluidturbulenceSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn physics_fluid_turbulence_series_mean(s : PhysicsfluidturbulenceSeries) -> Double {
  let n = physics_fluid_turbulence_series_len(s)
  if n == 0 { 0.0 } else { physics_fluid_turbulence_series_sum(s) / n.to_double() }
}

pub fn physics_fluid_turbulence_series_min(s : PhysicsfluidturbulenceSeries) -> Double {
  let n = physics_fluid_turbulence_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn physics_fluid_turbulence_series_max(s : PhysicsfluidturbulenceSeries) -> Double {
  let n = physics_fluid_turbulence_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn physics_fluid_turbulence_series_range(s : PhysicsfluidturbulenceSeries) -> Double {
  physics_fluid_turbulence_series_max(s) - physics_fluid_turbulence_series_min(s)
}

pub fn physics_fluid_turbulence_series_var(s : PhysicsfluidturbulenceSeries) -> Double {
  let n = physics_fluid_turbulence_series_len(s)
  if n == 0 { 0.0 } else {
    let m = physics_fluid_turbulence_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn physics_fluid_turbulence_series_std(s : PhysicsfluidturbulenceSeries) -> Double { physics_fluid_turbulence_sqrt(physics_fluid_turbulence_series_var(s)) }

pub fn physics_fluid_turbulence_series_median(s : PhysicsfluidturbulenceSeries) -> Double {
  let n = physics_fluid_turbulence_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = physics_fluid_turbulence_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn physics_fluid_turbulence_series_scale(s : PhysicsfluidturbulenceSeries, f : Double) -> PhysicsfluidturbulenceSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = physics_fluid_turbulence_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn physics_fluid_turbulence_series_add(a : PhysicsfluidturbulenceSeries, b : PhysicsfluidturbulenceSeries) -> PhysicsfluidturbulenceSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = physics_fluid_turbulence_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn physics_fluid_turbulence_series_sub(a : PhysicsfluidturbulenceSeries, b : PhysicsfluidturbulenceSeries) -> PhysicsfluidturbulenceSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = physics_fluid_turbulence_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn physics_fluid_turbulence_series_normalize(s : PhysicsfluidturbulenceSeries) -> PhysicsfluidturbulenceSeries {
  let mn = physics_fluid_turbulence_series_min(s)
  let mx = physics_fluid_turbulence_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = physics_fluid_turbulence_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn physics_fluid_turbulence_series_cumsum(s : PhysicsfluidturbulenceSeries) -> PhysicsfluidturbulenceSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = physics_fluid_turbulence_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn physics_fluid_turbulence_series_to_string(s : PhysicsfluidturbulenceSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + physics_fluid_turbulence_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct PhysicsfluidturbulenceMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn physics_fluid_turbulence_make_matrix(rows : Int, cols : Int, val : Double) -> PhysicsfluidturbulenceMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn physics_fluid_turbulence_matrix_identity(n : Int) -> PhysicsfluidturbulenceMatrix {
  let m = physics_fluid_turbulence_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn physics_fluid_turbulence_matrix_get(m : PhysicsfluidturbulenceMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn physics_fluid_turbulence_matrix_transpose(m : PhysicsfluidturbulenceMatrix) -> PhysicsfluidturbulenceMatrix {
  let result = physics_fluid_turbulence_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn physics_fluid_turbulence_matrix_add(a : PhysicsfluidturbulenceMatrix, b : PhysicsfluidturbulenceMatrix) -> PhysicsfluidturbulenceMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = physics_fluid_turbulence_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn physics_fluid_turbulence_matrix_scale(m : PhysicsfluidturbulenceMatrix, s : Double) -> PhysicsfluidturbulenceMatrix {
  let result = physics_fluid_turbulence_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn physics_fluid_turbulence_matrix_multiply(a : PhysicsfluidturbulenceMatrix, b : PhysicsfluidturbulenceMatrix) -> PhysicsfluidturbulenceMatrix {
  if a.cols != b.rows { return physics_fluid_turbulence_make_matrix(a.rows, b.cols, 0.0) }
  let result = physics_fluid_turbulence_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn physics_fluid_turbulence_matrix_trace(m : PhysicsfluidturbulenceMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn physics_fluid_turbulence_matrix_det(m : PhysicsfluidturbulenceMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn physics_fluid_turbulence_matrix_norm(m : PhysicsfluidturbulenceMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  physics_fluid_turbulence_sqrt(sum)
}

pub fn physics_fluid_turbulence_matrix_to_string(m : PhysicsfluidturbulenceMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + physics_fluid_turbulence_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct PhysicsfluidturbulenceVector {
  comps : Array[Double]
  dim : Int
}

pub fn physics_fluid_turbulence_make_vector(comps : Array[Double]) -> PhysicsfluidturbulenceVector {
  { comps, dim: comps.length() }
}

pub fn physics_fluid_turbulence_vector_zero(dim : Int) -> PhysicsfluidturbulenceVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn physics_fluid_turbulence_vector_add(a : PhysicsfluidturbulenceVector, b : PhysicsfluidturbulenceVector) -> PhysicsfluidturbulenceVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = physics_fluid_turbulence_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn physics_fluid_turbulence_vector_sub(a : PhysicsfluidturbulenceVector, b : PhysicsfluidturbulenceVector) -> PhysicsfluidturbulenceVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = physics_fluid_turbulence_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn physics_fluid_turbulence_vector_scale(v : PhysicsfluidturbulenceVector, s : Double) -> PhysicsfluidturbulenceVector {
  let mut result = []
  for i in 0..<v.dim { result = physics_fluid_turbulence_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn physics_fluid_turbulence_vector_dot(a : PhysicsfluidturbulenceVector, b : PhysicsfluidturbulenceVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn physics_fluid_turbulence_vector_norm(v : PhysicsfluidturbulenceVector) -> Double { physics_fluid_turbulence_sqrt(physics_fluid_turbulence_vector_dot(v, v)) }

pub fn physics_fluid_turbulence_vector_normalize(v : PhysicsfluidturbulenceVector) -> PhysicsfluidturbulenceVector {
  let n = physics_fluid_turbulence_vector_norm(v)
  if n < 0.0000001 { v } else { physics_fluid_turbulence_vector_scale(v, 1.0 / n) }
}

pub fn physics_fluid_turbulence_vector_dist(a : PhysicsfluidturbulenceVector, b : PhysicsfluidturbulenceVector) -> Double {
  physics_fluid_turbulence_vector_norm(physics_fluid_turbulence_vector_sub(a, b))
}

pub fn physics_fluid_turbulence_vector_to_string(v : PhysicsfluidturbulenceVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + physics_fluid_turbulence_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn physics_fluid_turbulence_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn physics_fluid_turbulence_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = physics_fluid_turbulence_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn physics_fluid_turbulence_std(data : Array[Double]) -> Double { physics_fluid_turbulence_sqrt(physics_fluid_turbulence_var(data)) }

pub fn physics_fluid_turbulence_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = physics_fluid_turbulence_mean(a); let mb = physics_fluid_turbulence_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn physics_fluid_turbulence_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = physics_fluid_turbulence_std(a); let sb = physics_fluid_turbulence_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { physics_fluid_turbulence_cov(a, b) / (sa * sb) }
}

pub fn physics_fluid_turbulence_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = physics_fluid_turbulence_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn physics_fluid_turbulence_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn physics_fluid_turbulence_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn physics_fluid_turbulence_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  physics_fluid_turbulence_sqrt(physics_fluid_turbulence_mse(pred, labels))
}

pub fn physics_fluid_turbulence_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + physics_fluid_turbulence_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn physics_fluid_turbulence_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = physics_fluid_turbulence_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn physics_fluid_turbulence_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn physics_fluid_turbulence_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn physics_fluid_turbulence_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = physics_fluid_turbulence_precision(pred, labels, pos); let r = physics_fluid_turbulence_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn physics_fluid_turbulence_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn physics_fluid_turbulence_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = physics_fluid_turbulence_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn physics_fluid_turbulence_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn physics_fluid_turbulence_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn physics_fluid_turbulence_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = physics_fluid_turbulence_gcd(a, b)
    (a / g) * b
  }
}

pub fn physics_fluid_turbulence_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn physics_fluid_turbulence_fibonacci(n : Int) -> Int {
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

pub fn physics_fluid_turbulence_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = physics_fluid_turbulence_min(data); let mx = physics_fluid_turbulence_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn physics_fluid_turbulence_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = physics_fluid_turbulence_mean(data); let sd = physics_fluid_turbulence_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn physics_fluid_turbulence_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn physics_fluid_turbulence_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn physics_fluid_turbulence_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn physics_fluid_turbulence_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn physics_fluid_turbulence_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn physics_fluid_turbulence_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn physics_fluid_turbulence_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn physics_fluid_turbulence_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn physics_fluid_turbulence_dbl(x : Double) -> String {
  let i = if x >= 0.0 { physics_fluid_turbulence_int(x) } else { -physics_fluid_turbulence_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { physics_fluid_turbulence_int(f * 1000000.0) } else { physics_fluid_turbulence_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn physics_fluid_turbulence_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn physics_fluid_turbulence_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct PhysicsfluidturbulenceFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_turbulence_frame_make(size : Int) -> PhysicsfluidturbulenceFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_turbulence_frame_len(s : PhysicsfluidturbulenceFrame) -> Int { s.size }

pub fn physics_fluid_turbulence_frame_get(s : PhysicsfluidturbulenceFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_turbulence_frame_set(s : PhysicsfluidturbulenceFrame, i : Int, v : Double) -> PhysicsfluidturbulenceFrame {
  let result = physics_fluid_turbulence_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_turbulence_frame_sum(s : PhysicsfluidturbulenceFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_fluid_turbulence_frame_mean(s : PhysicsfluidturbulenceFrame) -> Double {
  if s.size == 0 { 0.0 } else { physics_fluid_turbulence_frame_sum(s) / s.size.to_double() }
}

pub fn physics_fluid_turbulence_frame_scale(s : PhysicsfluidturbulenceFrame, f : Double) -> PhysicsfluidturbulenceFrame {
  let result = physics_fluid_turbulence_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_fluid_turbulence_frame_add(a : PhysicsfluidturbulenceFrame, b : PhysicsfluidturbulenceFrame) -> PhysicsfluidturbulenceFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_fluid_turbulence_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_fluid_turbulence_frame_copy(s : PhysicsfluidturbulenceFrame) -> PhysicsfluidturbulenceFrame {
  let result = physics_fluid_turbulence_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_fluid_turbulence_frame_fill(s : PhysicsfluidturbulenceFrame, v : Double) -> PhysicsfluidturbulenceFrame {
  let result = physics_fluid_turbulence_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_turbulence_frame_min(s : PhysicsfluidturbulenceFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_turbulence_frame_max(s : PhysicsfluidturbulenceFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_turbulence_frame_to_string(s : PhysicsfluidturbulenceFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidturbulenceTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_turbulence_table_make(size : Int) -> PhysicsfluidturbulenceTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_turbulence_table_len(s : PhysicsfluidturbulenceTable) -> Int { s.size }

pub fn physics_fluid_turbulence_table_get(s : PhysicsfluidturbulenceTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_turbulence_table_set(s : PhysicsfluidturbulenceTable, i : Int, v : Double) -> PhysicsfluidturbulenceTable {
  let result = physics_fluid_turbulence_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_turbulence_table_sum(s : PhysicsfluidturbulenceTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_fluid_turbulence_table_mean(s : PhysicsfluidturbulenceTable) -> Double {
  if s.size == 0 { 0.0 } else { physics_fluid_turbulence_table_sum(s) / s.size.to_double() }
}

pub fn physics_fluid_turbulence_table_scale(s : PhysicsfluidturbulenceTable, f : Double) -> PhysicsfluidturbulenceTable {
  let result = physics_fluid_turbulence_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_fluid_turbulence_table_add(a : PhysicsfluidturbulenceTable, b : PhysicsfluidturbulenceTable) -> PhysicsfluidturbulenceTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_fluid_turbulence_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_fluid_turbulence_table_copy(s : PhysicsfluidturbulenceTable) -> PhysicsfluidturbulenceTable {
  let result = physics_fluid_turbulence_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_fluid_turbulence_table_fill(s : PhysicsfluidturbulenceTable, v : Double) -> PhysicsfluidturbulenceTable {
  let result = physics_fluid_turbulence_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_turbulence_table_min(s : PhysicsfluidturbulenceTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_turbulence_table_max(s : PhysicsfluidturbulenceTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_turbulence_table_to_string(s : PhysicsfluidturbulenceTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidturbulenceGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_turbulence_graphn_make(size : Int) -> PhysicsfluidturbulenceGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_turbulence_graphn_len(s : PhysicsfluidturbulenceGraphN) -> Int { s.size }

pub fn physics_fluid_turbulence_graphn_get(s : PhysicsfluidturbulenceGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_turbulence_graphn_set(s : PhysicsfluidturbulenceGraphN, i : Int, v : Double) -> PhysicsfluidturbulenceGraphN {
  let result = physics_fluid_turbulence_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_turbulence_graphn_sum(s : PhysicsfluidturbulenceGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_fluid_turbulence_graphn_mean(s : PhysicsfluidturbulenceGraphN) -> Double {
  if s.size == 0 { 0.0 } else { physics_fluid_turbulence_graphn_sum(s) / s.size.to_double() }
}

pub fn physics_fluid_turbulence_graphn_scale(s : PhysicsfluidturbulenceGraphN, f : Double) -> PhysicsfluidturbulenceGraphN {
  let result = physics_fluid_turbulence_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_fluid_turbulence_graphn_add(a : PhysicsfluidturbulenceGraphN, b : PhysicsfluidturbulenceGraphN) -> PhysicsfluidturbulenceGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_fluid_turbulence_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_fluid_turbulence_graphn_copy(s : PhysicsfluidturbulenceGraphN) -> PhysicsfluidturbulenceGraphN {
  let result = physics_fluid_turbulence_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_fluid_turbulence_graphn_fill(s : PhysicsfluidturbulenceGraphN, v : Double) -> PhysicsfluidturbulenceGraphN {
  let result = physics_fluid_turbulence_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_turbulence_graphn_min(s : PhysicsfluidturbulenceGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_turbulence_graphn_max(s : PhysicsfluidturbulenceGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_turbulence_graphn_to_string(s : PhysicsfluidturbulenceGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidturbulenceNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_turbulence_node_make(size : Int) -> PhysicsfluidturbulenceNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_turbulence_node_len(s : PhysicsfluidturbulenceNode) -> Int { s.size }

pub fn physics_fluid_turbulence_node_get(s : PhysicsfluidturbulenceNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_turbulence_node_set(s : PhysicsfluidturbulenceNode, i : Int, v : Double) -> PhysicsfluidturbulenceNode {
  let result = physics_fluid_turbulence_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_turbulence_node_sum(s : PhysicsfluidturbulenceNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_fluid_turbulence_node_mean(s : PhysicsfluidturbulenceNode) -> Double {
  if s.size == 0 { 0.0 } else { physics_fluid_turbulence_node_sum(s) / s.size.to_double() }
}

pub fn physics_fluid_turbulence_node_scale(s : PhysicsfluidturbulenceNode, f : Double) -> PhysicsfluidturbulenceNode {
  let result = physics_fluid_turbulence_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_fluid_turbulence_node_add(a : PhysicsfluidturbulenceNode, b : PhysicsfluidturbulenceNode) -> PhysicsfluidturbulenceNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_fluid_turbulence_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_fluid_turbulence_node_copy(s : PhysicsfluidturbulenceNode) -> PhysicsfluidturbulenceNode {
  let result = physics_fluid_turbulence_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_fluid_turbulence_node_fill(s : PhysicsfluidturbulenceNode, v : Double) -> PhysicsfluidturbulenceNode {
  let result = physics_fluid_turbulence_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_turbulence_node_min(s : PhysicsfluidturbulenceNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_turbulence_node_max(s : PhysicsfluidturbulenceNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_turbulence_node_to_string(s : PhysicsfluidturbulenceNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidturbulenceEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_turbulence_edge_make(size : Int) -> PhysicsfluidturbulenceEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_turbulence_edge_len(s : PhysicsfluidturbulenceEdge) -> Int { s.size }

pub fn physics_fluid_turbulence_edge_get(s : PhysicsfluidturbulenceEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_turbulence_edge_set(s : PhysicsfluidturbulenceEdge, i : Int, v : Double) -> PhysicsfluidturbulenceEdge {
  let result = physics_fluid_turbulence_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_turbulence_edge_sum(s : PhysicsfluidturbulenceEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_fluid_turbulence_edge_mean(s : PhysicsfluidturbulenceEdge) -> Double {
  if s.size == 0 { 0.0 } else { physics_fluid_turbulence_edge_sum(s) / s.size.to_double() }
}

pub fn physics_fluid_turbulence_edge_scale(s : PhysicsfluidturbulenceEdge, f : Double) -> PhysicsfluidturbulenceEdge {
  let result = physics_fluid_turbulence_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_fluid_turbulence_edge_add(a : PhysicsfluidturbulenceEdge, b : PhysicsfluidturbulenceEdge) -> PhysicsfluidturbulenceEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_fluid_turbulence_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_fluid_turbulence_edge_copy(s : PhysicsfluidturbulenceEdge) -> PhysicsfluidturbulenceEdge {
  let result = physics_fluid_turbulence_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_fluid_turbulence_edge_fill(s : PhysicsfluidturbulenceEdge, v : Double) -> PhysicsfluidturbulenceEdge {
  let result = physics_fluid_turbulence_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_turbulence_edge_min(s : PhysicsfluidturbulenceEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_turbulence_edge_max(s : PhysicsfluidturbulenceEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_turbulence_edge_to_string(s : PhysicsfluidturbulenceEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidturbulencePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_turbulence_path_make(size : Int) -> PhysicsfluidturbulencePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_turbulence_path_len(s : PhysicsfluidturbulencePath) -> Int { s.size }

pub fn physics_fluid_turbulence_path_get(s : PhysicsfluidturbulencePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_turbulence_path_set(s : PhysicsfluidturbulencePath, i : Int, v : Double) -> PhysicsfluidturbulencePath {
  let result = physics_fluid_turbulence_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_turbulence_path_sum(s : PhysicsfluidturbulencePath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_fluid_turbulence_path_mean(s : PhysicsfluidturbulencePath) -> Double {
  if s.size == 0 { 0.0 } else { physics_fluid_turbulence_path_sum(s) / s.size.to_double() }
}

pub fn physics_fluid_turbulence_path_scale(s : PhysicsfluidturbulencePath, f : Double) -> PhysicsfluidturbulencePath {
  let result = physics_fluid_turbulence_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_fluid_turbulence_path_add(a : PhysicsfluidturbulencePath, b : PhysicsfluidturbulencePath) -> PhysicsfluidturbulencePath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_fluid_turbulence_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_fluid_turbulence_path_copy(s : PhysicsfluidturbulencePath) -> PhysicsfluidturbulencePath {
  let result = physics_fluid_turbulence_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_fluid_turbulence_path_fill(s : PhysicsfluidturbulencePath, v : Double) -> PhysicsfluidturbulencePath {
  let result = physics_fluid_turbulence_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_turbulence_path_min(s : PhysicsfluidturbulencePath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_turbulence_path_max(s : PhysicsfluidturbulencePath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_turbulence_path_to_string(s : PhysicsfluidturbulencePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidturbulenceCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_turbulence_cluster_make(size : Int) -> PhysicsfluidturbulenceCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_turbulence_cluster_len(s : PhysicsfluidturbulenceCluster) -> Int { s.size }

pub fn physics_fluid_turbulence_cluster_get(s : PhysicsfluidturbulenceCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_turbulence_cluster_set(s : PhysicsfluidturbulenceCluster, i : Int, v : Double) -> PhysicsfluidturbulenceCluster {
  let result = physics_fluid_turbulence_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_turbulence_cluster_sum(s : PhysicsfluidturbulenceCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_fluid_turbulence_cluster_mean(s : PhysicsfluidturbulenceCluster) -> Double {
  if s.size == 0 { 0.0 } else { physics_fluid_turbulence_cluster_sum(s) / s.size.to_double() }
}

pub fn physics_fluid_turbulence_cluster_scale(s : PhysicsfluidturbulenceCluster, f : Double) -> PhysicsfluidturbulenceCluster {
  let result = physics_fluid_turbulence_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_fluid_turbulence_cluster_add(a : PhysicsfluidturbulenceCluster, b : PhysicsfluidturbulenceCluster) -> PhysicsfluidturbulenceCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_fluid_turbulence_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_fluid_turbulence_cluster_copy(s : PhysicsfluidturbulenceCluster) -> PhysicsfluidturbulenceCluster {
  let result = physics_fluid_turbulence_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_fluid_turbulence_cluster_fill(s : PhysicsfluidturbulenceCluster, v : Double) -> PhysicsfluidturbulenceCluster {
  let result = physics_fluid_turbulence_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_turbulence_cluster_min(s : PhysicsfluidturbulenceCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_turbulence_cluster_max(s : PhysicsfluidturbulenceCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_turbulence_cluster_to_string(s : PhysicsfluidturbulenceCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidturbulenceModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_turbulence_model_make(size : Int) -> PhysicsfluidturbulenceModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_turbulence_model_len(s : PhysicsfluidturbulenceModel) -> Int { s.size }

pub fn physics_fluid_turbulence_model_get(s : PhysicsfluidturbulenceModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_turbulence_model_set(s : PhysicsfluidturbulenceModel, i : Int, v : Double) -> PhysicsfluidturbulenceModel {
  let result = physics_fluid_turbulence_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_turbulence_model_sum(s : PhysicsfluidturbulenceModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_fluid_turbulence_model_mean(s : PhysicsfluidturbulenceModel) -> Double {
  if s.size == 0 { 0.0 } else { physics_fluid_turbulence_model_sum(s) / s.size.to_double() }
}

pub fn physics_fluid_turbulence_model_scale(s : PhysicsfluidturbulenceModel, f : Double) -> PhysicsfluidturbulenceModel {
  let result = physics_fluid_turbulence_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_fluid_turbulence_model_add(a : PhysicsfluidturbulenceModel, b : PhysicsfluidturbulenceModel) -> PhysicsfluidturbulenceModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_fluid_turbulence_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_fluid_turbulence_model_copy(s : PhysicsfluidturbulenceModel) -> PhysicsfluidturbulenceModel {
  let result = physics_fluid_turbulence_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_fluid_turbulence_model_fill(s : PhysicsfluidturbulenceModel, v : Double) -> PhysicsfluidturbulenceModel {
  let result = physics_fluid_turbulence_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_turbulence_model_min(s : PhysicsfluidturbulenceModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_turbulence_model_max(s : PhysicsfluidturbulenceModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_turbulence_model_to_string(s : PhysicsfluidturbulenceModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidturbulenceLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_turbulence_layer_make(size : Int) -> PhysicsfluidturbulenceLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_turbulence_layer_len(s : PhysicsfluidturbulenceLayer) -> Int { s.size }

pub fn physics_fluid_turbulence_layer_get(s : PhysicsfluidturbulenceLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_turbulence_layer_set(s : PhysicsfluidturbulenceLayer, i : Int, v : Double) -> PhysicsfluidturbulenceLayer {
  let result = physics_fluid_turbulence_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_turbulence_layer_sum(s : PhysicsfluidturbulenceLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_fluid_turbulence_layer_mean(s : PhysicsfluidturbulenceLayer) -> Double {
  if s.size == 0 { 0.0 } else { physics_fluid_turbulence_layer_sum(s) / s.size.to_double() }
}

pub fn physics_fluid_turbulence_layer_scale(s : PhysicsfluidturbulenceLayer, f : Double) -> PhysicsfluidturbulenceLayer {
  let result = physics_fluid_turbulence_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_fluid_turbulence_layer_add(a : PhysicsfluidturbulenceLayer, b : PhysicsfluidturbulenceLayer) -> PhysicsfluidturbulenceLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_fluid_turbulence_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_fluid_turbulence_layer_copy(s : PhysicsfluidturbulenceLayer) -> PhysicsfluidturbulenceLayer {
  let result = physics_fluid_turbulence_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_fluid_turbulence_layer_fill(s : PhysicsfluidturbulenceLayer, v : Double) -> PhysicsfluidturbulenceLayer {
  let result = physics_fluid_turbulence_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_turbulence_layer_min(s : PhysicsfluidturbulenceLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_turbulence_layer_max(s : PhysicsfluidturbulenceLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_turbulence_layer_to_string(s : PhysicsfluidturbulenceLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidturbulenceBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_turbulence_buffer_make(size : Int) -> PhysicsfluidturbulenceBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_turbulence_buffer_len(s : PhysicsfluidturbulenceBuffer) -> Int { s.size }

pub fn physics_fluid_turbulence_buffer_get(s : PhysicsfluidturbulenceBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_turbulence_buffer_set(s : PhysicsfluidturbulenceBuffer, i : Int, v : Double) -> PhysicsfluidturbulenceBuffer {
  let result = physics_fluid_turbulence_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_turbulence_buffer_sum(s : PhysicsfluidturbulenceBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_fluid_turbulence_buffer_mean(s : PhysicsfluidturbulenceBuffer) -> Double {
  if s.size == 0 { 0.0 } else { physics_fluid_turbulence_buffer_sum(s) / s.size.to_double() }
}

pub fn physics_fluid_turbulence_buffer_scale(s : PhysicsfluidturbulenceBuffer, f : Double) -> PhysicsfluidturbulenceBuffer {
  let result = physics_fluid_turbulence_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_fluid_turbulence_buffer_add(a : PhysicsfluidturbulenceBuffer, b : PhysicsfluidturbulenceBuffer) -> PhysicsfluidturbulenceBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_fluid_turbulence_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_fluid_turbulence_buffer_copy(s : PhysicsfluidturbulenceBuffer) -> PhysicsfluidturbulenceBuffer {
  let result = physics_fluid_turbulence_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_fluid_turbulence_buffer_fill(s : PhysicsfluidturbulenceBuffer, v : Double) -> PhysicsfluidturbulenceBuffer {
  let result = physics_fluid_turbulence_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_turbulence_buffer_min(s : PhysicsfluidturbulenceBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_turbulence_buffer_max(s : PhysicsfluidturbulenceBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_turbulence_buffer_to_string(s : PhysicsfluidturbulenceBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidturbulenceCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_turbulence_cursor_make(size : Int) -> PhysicsfluidturbulenceCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_turbulence_cursor_len(s : PhysicsfluidturbulenceCursor) -> Int { s.size }

pub fn physics_fluid_turbulence_cursor_get(s : PhysicsfluidturbulenceCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_turbulence_cursor_set(s : PhysicsfluidturbulenceCursor, i : Int, v : Double) -> PhysicsfluidturbulenceCursor {
  let result = physics_fluid_turbulence_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_turbulence_cursor_sum(s : PhysicsfluidturbulenceCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_fluid_turbulence_cursor_mean(s : PhysicsfluidturbulenceCursor) -> Double {
  if s.size == 0 { 0.0 } else { physics_fluid_turbulence_cursor_sum(s) / s.size.to_double() }
}

pub fn physics_fluid_turbulence_cursor_scale(s : PhysicsfluidturbulenceCursor, f : Double) -> PhysicsfluidturbulenceCursor {
  let result = physics_fluid_turbulence_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_fluid_turbulence_cursor_add(a : PhysicsfluidturbulenceCursor, b : PhysicsfluidturbulenceCursor) -> PhysicsfluidturbulenceCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_fluid_turbulence_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_fluid_turbulence_cursor_copy(s : PhysicsfluidturbulenceCursor) -> PhysicsfluidturbulenceCursor {
  let result = physics_fluid_turbulence_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_fluid_turbulence_cursor_fill(s : PhysicsfluidturbulenceCursor, v : Double) -> PhysicsfluidturbulenceCursor {
  let result = physics_fluid_turbulence_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_turbulence_cursor_min(s : PhysicsfluidturbulenceCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_turbulence_cursor_max(s : PhysicsfluidturbulenceCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_turbulence_cursor_to_string(s : PhysicsfluidturbulenceCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidturbulenceView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_turbulence_view_make(size : Int) -> PhysicsfluidturbulenceView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_turbulence_view_len(s : PhysicsfluidturbulenceView) -> Int { s.size }

pub fn physics_fluid_turbulence_view_get(s : PhysicsfluidturbulenceView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_turbulence_view_set(s : PhysicsfluidturbulenceView, i : Int, v : Double) -> PhysicsfluidturbulenceView {
  let result = physics_fluid_turbulence_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_turbulence_view_sum(s : PhysicsfluidturbulenceView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_fluid_turbulence_view_mean(s : PhysicsfluidturbulenceView) -> Double {
  if s.size == 0 { 0.0 } else { physics_fluid_turbulence_view_sum(s) / s.size.to_double() }
}

pub fn physics_fluid_turbulence_view_scale(s : PhysicsfluidturbulenceView, f : Double) -> PhysicsfluidturbulenceView {
  let result = physics_fluid_turbulence_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_fluid_turbulence_view_add(a : PhysicsfluidturbulenceView, b : PhysicsfluidturbulenceView) -> PhysicsfluidturbulenceView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_fluid_turbulence_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_fluid_turbulence_view_copy(s : PhysicsfluidturbulenceView) -> PhysicsfluidturbulenceView {
  let result = physics_fluid_turbulence_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_fluid_turbulence_view_fill(s : PhysicsfluidturbulenceView, v : Double) -> PhysicsfluidturbulenceView {
  let result = physics_fluid_turbulence_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_turbulence_view_min(s : PhysicsfluidturbulenceView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_turbulence_view_max(s : PhysicsfluidturbulenceView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_turbulence_view_to_string(s : PhysicsfluidturbulenceView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidturbulenceRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_turbulence_range_make(size : Int) -> PhysicsfluidturbulenceRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_turbulence_range_len(s : PhysicsfluidturbulenceRange) -> Int { s.size }

pub fn physics_fluid_turbulence_range_get(s : PhysicsfluidturbulenceRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_turbulence_range_set(s : PhysicsfluidturbulenceRange, i : Int, v : Double) -> PhysicsfluidturbulenceRange {
  let result = physics_fluid_turbulence_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_turbulence_range_sum(s : PhysicsfluidturbulenceRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_fluid_turbulence_range_mean(s : PhysicsfluidturbulenceRange) -> Double {
  if s.size == 0 { 0.0 } else { physics_fluid_turbulence_range_sum(s) / s.size.to_double() }
}

pub fn physics_fluid_turbulence_range_scale(s : PhysicsfluidturbulenceRange, f : Double) -> PhysicsfluidturbulenceRange {
  let result = physics_fluid_turbulence_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_fluid_turbulence_range_add(a : PhysicsfluidturbulenceRange, b : PhysicsfluidturbulenceRange) -> PhysicsfluidturbulenceRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_fluid_turbulence_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_fluid_turbulence_range_copy(s : PhysicsfluidturbulenceRange) -> PhysicsfluidturbulenceRange {
  let result = physics_fluid_turbulence_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_fluid_turbulence_range_fill(s : PhysicsfluidturbulenceRange, v : Double) -> PhysicsfluidturbulenceRange {
  let result = physics_fluid_turbulence_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_turbulence_range_min(s : PhysicsfluidturbulenceRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_turbulence_range_max(s : PhysicsfluidturbulenceRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_turbulence_range_to_string(s : PhysicsfluidturbulenceRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidturbulenceSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_turbulence_slice_make(size : Int) -> PhysicsfluidturbulenceSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_turbulence_slice_len(s : PhysicsfluidturbulenceSlice) -> Int { s.size }

pub fn physics_fluid_turbulence_slice_get(s : PhysicsfluidturbulenceSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_turbulence_slice_set(s : PhysicsfluidturbulenceSlice, i : Int, v : Double) -> PhysicsfluidturbulenceSlice {
  let result = physics_fluid_turbulence_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_turbulence_slice_sum(s : PhysicsfluidturbulenceSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_fluid_turbulence_slice_mean(s : PhysicsfluidturbulenceSlice) -> Double {
  if s.size == 0 { 0.0 } else { physics_fluid_turbulence_slice_sum(s) / s.size.to_double() }
}

pub fn physics_fluid_turbulence_slice_scale(s : PhysicsfluidturbulenceSlice, f : Double) -> PhysicsfluidturbulenceSlice {
  let result = physics_fluid_turbulence_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_fluid_turbulence_slice_add(a : PhysicsfluidturbulenceSlice, b : PhysicsfluidturbulenceSlice) -> PhysicsfluidturbulenceSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_fluid_turbulence_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_fluid_turbulence_slice_copy(s : PhysicsfluidturbulenceSlice) -> PhysicsfluidturbulenceSlice {
  let result = physics_fluid_turbulence_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_fluid_turbulence_slice_fill(s : PhysicsfluidturbulenceSlice, v : Double) -> PhysicsfluidturbulenceSlice {
  let result = physics_fluid_turbulence_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_turbulence_slice_min(s : PhysicsfluidturbulenceSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_turbulence_slice_max(s : PhysicsfluidturbulenceSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_turbulence_slice_to_string(s : PhysicsfluidturbulenceSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn physics_fluid_turbulence_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_fluid_turbulence_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_fluid_turbulence_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_fluid_turbulence_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_fluid_turbulence_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_fluid_turbulence_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_fluid_turbulence_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_fluid_turbulence_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_fluid_turbulence_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_fluid_turbulence_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_fluid_turbulence_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_fluid_turbulence_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_fluid_turbulence_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_fluid_turbulence_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_fluid_turbulence_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_fluid_turbulence_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_fluid_turbulence_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_fluid_turbulence_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_fluid_turbulence_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_fluid_turbulence_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_fluid_turbulence_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_fluid_turbulence_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_fluid_turbulence_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_fluid_turbulence_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_fluid_turbulence_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

