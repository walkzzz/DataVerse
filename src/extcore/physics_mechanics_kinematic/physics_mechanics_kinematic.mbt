///===
/// extcore/physics_mechanics_kinematic

pub(all) struct PhysicsmechanicskinematicPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn physics_mechanics_kinematic_make_point(x : Double, y : Double) -> PhysicsmechanicskinematicPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn physics_mechanics_kinematic_make_point3(x : Double, y : Double, z : Double) -> PhysicsmechanicskinematicPoint {
  { x, y, z, label: 0 }
}

pub fn physics_mechanics_kinematic_point_x(pt : PhysicsmechanicskinematicPoint) -> Double { pt.x }

pub fn physics_mechanics_kinematic_point_y(pt : PhysicsmechanicskinematicPoint) -> Double { pt.y }

pub fn physics_mechanics_kinematic_point_z(pt : PhysicsmechanicskinematicPoint) -> Double { pt.z }

pub fn physics_mechanics_kinematic_point_label(pt : PhysicsmechanicskinematicPoint) -> Int { pt.label }

pub fn physics_mechanics_kinematic_point_dist(a : PhysicsmechanicskinematicPoint, b : PhysicsmechanicskinematicPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  physics_mechanics_kinematic_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn physics_mechanics_kinematic_point_add(a : PhysicsmechanicskinematicPoint, b : PhysicsmechanicskinematicPoint) -> PhysicsmechanicskinematicPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn physics_mechanics_kinematic_point_sub(a : PhysicsmechanicskinematicPoint, b : PhysicsmechanicskinematicPoint) -> PhysicsmechanicskinematicPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn physics_mechanics_kinematic_point_scale(pt : PhysicsmechanicskinematicPoint, s : Double) -> PhysicsmechanicskinematicPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn physics_mechanics_kinematic_point_dot(a : PhysicsmechanicskinematicPoint, b : PhysicsmechanicskinematicPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn physics_mechanics_kinematic_point_cross(a : PhysicsmechanicskinematicPoint, b : PhysicsmechanicskinematicPoint) -> PhysicsmechanicskinematicPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn physics_mechanics_kinematic_point_norm(pt : PhysicsmechanicskinematicPoint) -> Double {
  physics_mechanics_kinematic_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn physics_mechanics_kinematic_point_normalize(pt : PhysicsmechanicskinematicPoint) -> PhysicsmechanicskinematicPoint {
  let n = physics_mechanics_kinematic_point_norm(pt)
  if n < 0.0000001 { pt } else { physics_mechanics_kinematic_point_scale(pt, 1.0 / n) }
}

pub fn physics_mechanics_kinematic_point_negate(pt : PhysicsmechanicskinematicPoint) -> PhysicsmechanicskinematicPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn physics_mechanics_kinematic_point_mid(a : PhysicsmechanicskinematicPoint, b : PhysicsmechanicskinematicPoint) -> PhysicsmechanicskinematicPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn physics_mechanics_kinematic_point_lerp(a : PhysicsmechanicskinematicPoint, b : PhysicsmechanicskinematicPoint, t : Double) -> PhysicsmechanicskinematicPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn physics_mechanics_kinematic_point_to_string(pt : PhysicsmechanicskinematicPoint) -> String {
  "(" + physics_mechanics_kinematic_dbl(pt.x) + ", " + physics_mechanics_kinematic_dbl(pt.y) + ", " + physics_mechanics_kinematic_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct PhysicsmechanicskinematicSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn physics_mechanics_kinematic_make_series(vals : Array[Double], name : String) -> PhysicsmechanicskinematicSeries {
  { vals, name, meta: 0 }
}

pub fn physics_mechanics_kinematic_series_len(s : PhysicsmechanicskinematicSeries) -> Int { s.vals.length() }

pub fn physics_mechanics_kinematic_series_sum(s : PhysicsmechanicskinematicSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn physics_mechanics_kinematic_series_mean(s : PhysicsmechanicskinematicSeries) -> Double {
  let n = physics_mechanics_kinematic_series_len(s)
  if n == 0 { 0.0 } else { physics_mechanics_kinematic_series_sum(s) / n.to_double() }
}

pub fn physics_mechanics_kinematic_series_min(s : PhysicsmechanicskinematicSeries) -> Double {
  let n = physics_mechanics_kinematic_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn physics_mechanics_kinematic_series_max(s : PhysicsmechanicskinematicSeries) -> Double {
  let n = physics_mechanics_kinematic_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn physics_mechanics_kinematic_series_range(s : PhysicsmechanicskinematicSeries) -> Double {
  physics_mechanics_kinematic_series_max(s) - physics_mechanics_kinematic_series_min(s)
}

pub fn physics_mechanics_kinematic_series_var(s : PhysicsmechanicskinematicSeries) -> Double {
  let n = physics_mechanics_kinematic_series_len(s)
  if n == 0 { 0.0 } else {
    let m = physics_mechanics_kinematic_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn physics_mechanics_kinematic_series_std(s : PhysicsmechanicskinematicSeries) -> Double { physics_mechanics_kinematic_sqrt(physics_mechanics_kinematic_series_var(s)) }

pub fn physics_mechanics_kinematic_series_median(s : PhysicsmechanicskinematicSeries) -> Double {
  let n = physics_mechanics_kinematic_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = physics_mechanics_kinematic_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn physics_mechanics_kinematic_series_scale(s : PhysicsmechanicskinematicSeries, f : Double) -> PhysicsmechanicskinematicSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = physics_mechanics_kinematic_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn physics_mechanics_kinematic_series_add(a : PhysicsmechanicskinematicSeries, b : PhysicsmechanicskinematicSeries) -> PhysicsmechanicskinematicSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = physics_mechanics_kinematic_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn physics_mechanics_kinematic_series_sub(a : PhysicsmechanicskinematicSeries, b : PhysicsmechanicskinematicSeries) -> PhysicsmechanicskinematicSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = physics_mechanics_kinematic_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn physics_mechanics_kinematic_series_normalize(s : PhysicsmechanicskinematicSeries) -> PhysicsmechanicskinematicSeries {
  let mn = physics_mechanics_kinematic_series_min(s)
  let mx = physics_mechanics_kinematic_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = physics_mechanics_kinematic_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn physics_mechanics_kinematic_series_cumsum(s : PhysicsmechanicskinematicSeries) -> PhysicsmechanicskinematicSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = physics_mechanics_kinematic_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn physics_mechanics_kinematic_series_to_string(s : PhysicsmechanicskinematicSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + physics_mechanics_kinematic_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct PhysicsmechanicskinematicMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn physics_mechanics_kinematic_make_matrix(rows : Int, cols : Int, val : Double) -> PhysicsmechanicskinematicMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn physics_mechanics_kinematic_matrix_identity(n : Int) -> PhysicsmechanicskinematicMatrix {
  let m = physics_mechanics_kinematic_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn physics_mechanics_kinematic_matrix_get(m : PhysicsmechanicskinematicMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn physics_mechanics_kinematic_matrix_transpose(m : PhysicsmechanicskinematicMatrix) -> PhysicsmechanicskinematicMatrix {
  let result = physics_mechanics_kinematic_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn physics_mechanics_kinematic_matrix_add(a : PhysicsmechanicskinematicMatrix, b : PhysicsmechanicskinematicMatrix) -> PhysicsmechanicskinematicMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = physics_mechanics_kinematic_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn physics_mechanics_kinematic_matrix_scale(m : PhysicsmechanicskinematicMatrix, s : Double) -> PhysicsmechanicskinematicMatrix {
  let result = physics_mechanics_kinematic_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn physics_mechanics_kinematic_matrix_multiply(a : PhysicsmechanicskinematicMatrix, b : PhysicsmechanicskinematicMatrix) -> PhysicsmechanicskinematicMatrix {
  if a.cols != b.rows { return physics_mechanics_kinematic_make_matrix(a.rows, b.cols, 0.0) }
  let result = physics_mechanics_kinematic_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn physics_mechanics_kinematic_matrix_trace(m : PhysicsmechanicskinematicMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn physics_mechanics_kinematic_matrix_det(m : PhysicsmechanicskinematicMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn physics_mechanics_kinematic_matrix_norm(m : PhysicsmechanicskinematicMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  physics_mechanics_kinematic_sqrt(sum)
}

pub fn physics_mechanics_kinematic_matrix_to_string(m : PhysicsmechanicskinematicMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + physics_mechanics_kinematic_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct PhysicsmechanicskinematicVector {
  comps : Array[Double]
  dim : Int
}

pub fn physics_mechanics_kinematic_make_vector(comps : Array[Double]) -> PhysicsmechanicskinematicVector {
  { comps, dim: comps.length() }
}

pub fn physics_mechanics_kinematic_vector_zero(dim : Int) -> PhysicsmechanicskinematicVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn physics_mechanics_kinematic_vector_add(a : PhysicsmechanicskinematicVector, b : PhysicsmechanicskinematicVector) -> PhysicsmechanicskinematicVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = physics_mechanics_kinematic_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn physics_mechanics_kinematic_vector_sub(a : PhysicsmechanicskinematicVector, b : PhysicsmechanicskinematicVector) -> PhysicsmechanicskinematicVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = physics_mechanics_kinematic_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn physics_mechanics_kinematic_vector_scale(v : PhysicsmechanicskinematicVector, s : Double) -> PhysicsmechanicskinematicVector {
  let mut result = []
  for i in 0..<v.dim { result = physics_mechanics_kinematic_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn physics_mechanics_kinematic_vector_dot(a : PhysicsmechanicskinematicVector, b : PhysicsmechanicskinematicVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn physics_mechanics_kinematic_vector_norm(v : PhysicsmechanicskinematicVector) -> Double { physics_mechanics_kinematic_sqrt(physics_mechanics_kinematic_vector_dot(v, v)) }

pub fn physics_mechanics_kinematic_vector_normalize(v : PhysicsmechanicskinematicVector) -> PhysicsmechanicskinematicVector {
  let n = physics_mechanics_kinematic_vector_norm(v)
  if n < 0.0000001 { v } else { physics_mechanics_kinematic_vector_scale(v, 1.0 / n) }
}

pub fn physics_mechanics_kinematic_vector_dist(a : PhysicsmechanicskinematicVector, b : PhysicsmechanicskinematicVector) -> Double {
  physics_mechanics_kinematic_vector_norm(physics_mechanics_kinematic_vector_sub(a, b))
}

pub fn physics_mechanics_kinematic_vector_to_string(v : PhysicsmechanicskinematicVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + physics_mechanics_kinematic_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn physics_mechanics_kinematic_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn physics_mechanics_kinematic_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = physics_mechanics_kinematic_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn physics_mechanics_kinematic_std(data : Array[Double]) -> Double { physics_mechanics_kinematic_sqrt(physics_mechanics_kinematic_var(data)) }

pub fn physics_mechanics_kinematic_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = physics_mechanics_kinematic_mean(a); let mb = physics_mechanics_kinematic_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn physics_mechanics_kinematic_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = physics_mechanics_kinematic_std(a); let sb = physics_mechanics_kinematic_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { physics_mechanics_kinematic_cov(a, b) / (sa * sb) }
}

pub fn physics_mechanics_kinematic_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = physics_mechanics_kinematic_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn physics_mechanics_kinematic_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn physics_mechanics_kinematic_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn physics_mechanics_kinematic_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  physics_mechanics_kinematic_sqrt(physics_mechanics_kinematic_mse(pred, labels))
}

pub fn physics_mechanics_kinematic_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + physics_mechanics_kinematic_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn physics_mechanics_kinematic_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = physics_mechanics_kinematic_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn physics_mechanics_kinematic_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn physics_mechanics_kinematic_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn physics_mechanics_kinematic_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = physics_mechanics_kinematic_precision(pred, labels, pos); let r = physics_mechanics_kinematic_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn physics_mechanics_kinematic_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn physics_mechanics_kinematic_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = physics_mechanics_kinematic_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn physics_mechanics_kinematic_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn physics_mechanics_kinematic_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn physics_mechanics_kinematic_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = physics_mechanics_kinematic_gcd(a, b)
    (a / g) * b
  }
}

pub fn physics_mechanics_kinematic_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn physics_mechanics_kinematic_fibonacci(n : Int) -> Int {
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

pub fn physics_mechanics_kinematic_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = physics_mechanics_kinematic_min(data); let mx = physics_mechanics_kinematic_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn physics_mechanics_kinematic_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = physics_mechanics_kinematic_mean(data); let sd = physics_mechanics_kinematic_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn physics_mechanics_kinematic_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn physics_mechanics_kinematic_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn physics_mechanics_kinematic_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn physics_mechanics_kinematic_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn physics_mechanics_kinematic_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn physics_mechanics_kinematic_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn physics_mechanics_kinematic_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn physics_mechanics_kinematic_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn physics_mechanics_kinematic_dbl(x : Double) -> String {
  let i = if x >= 0.0 { physics_mechanics_kinematic_int(x) } else { -physics_mechanics_kinematic_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { physics_mechanics_kinematic_int(f * 1000000.0) } else { physics_mechanics_kinematic_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn physics_mechanics_kinematic_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn physics_mechanics_kinematic_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct PhysicsmechanicskinematicFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_kinematic_frame_make(size : Int) -> PhysicsmechanicskinematicFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_kinematic_frame_len(s : PhysicsmechanicskinematicFrame) -> Int { s.size }

pub fn physics_mechanics_kinematic_frame_get(s : PhysicsmechanicskinematicFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_kinematic_frame_set(s : PhysicsmechanicskinematicFrame, i : Int, v : Double) -> PhysicsmechanicskinematicFrame {
  let result = physics_mechanics_kinematic_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_kinematic_frame_sum(s : PhysicsmechanicskinematicFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_mechanics_kinematic_frame_mean(s : PhysicsmechanicskinematicFrame) -> Double {
  if s.size == 0 { 0.0 } else { physics_mechanics_kinematic_frame_sum(s) / s.size.to_double() }
}

pub fn physics_mechanics_kinematic_frame_scale(s : PhysicsmechanicskinematicFrame, f : Double) -> PhysicsmechanicskinematicFrame {
  let result = physics_mechanics_kinematic_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_mechanics_kinematic_frame_add(a : PhysicsmechanicskinematicFrame, b : PhysicsmechanicskinematicFrame) -> PhysicsmechanicskinematicFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_mechanics_kinematic_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_mechanics_kinematic_frame_copy(s : PhysicsmechanicskinematicFrame) -> PhysicsmechanicskinematicFrame {
  let result = physics_mechanics_kinematic_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_mechanics_kinematic_frame_fill(s : PhysicsmechanicskinematicFrame, v : Double) -> PhysicsmechanicskinematicFrame {
  let result = physics_mechanics_kinematic_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_kinematic_frame_min(s : PhysicsmechanicskinematicFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_kinematic_frame_max(s : PhysicsmechanicskinematicFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_kinematic_frame_to_string(s : PhysicsmechanicskinematicFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicskinematicTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_kinematic_table_make(size : Int) -> PhysicsmechanicskinematicTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_kinematic_table_len(s : PhysicsmechanicskinematicTable) -> Int { s.size }

pub fn physics_mechanics_kinematic_table_get(s : PhysicsmechanicskinematicTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_kinematic_table_set(s : PhysicsmechanicskinematicTable, i : Int, v : Double) -> PhysicsmechanicskinematicTable {
  let result = physics_mechanics_kinematic_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_kinematic_table_sum(s : PhysicsmechanicskinematicTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_mechanics_kinematic_table_mean(s : PhysicsmechanicskinematicTable) -> Double {
  if s.size == 0 { 0.0 } else { physics_mechanics_kinematic_table_sum(s) / s.size.to_double() }
}

pub fn physics_mechanics_kinematic_table_scale(s : PhysicsmechanicskinematicTable, f : Double) -> PhysicsmechanicskinematicTable {
  let result = physics_mechanics_kinematic_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_mechanics_kinematic_table_add(a : PhysicsmechanicskinematicTable, b : PhysicsmechanicskinematicTable) -> PhysicsmechanicskinematicTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_mechanics_kinematic_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_mechanics_kinematic_table_copy(s : PhysicsmechanicskinematicTable) -> PhysicsmechanicskinematicTable {
  let result = physics_mechanics_kinematic_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_mechanics_kinematic_table_fill(s : PhysicsmechanicskinematicTable, v : Double) -> PhysicsmechanicskinematicTable {
  let result = physics_mechanics_kinematic_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_kinematic_table_min(s : PhysicsmechanicskinematicTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_kinematic_table_max(s : PhysicsmechanicskinematicTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_kinematic_table_to_string(s : PhysicsmechanicskinematicTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicskinematicGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_kinematic_graphn_make(size : Int) -> PhysicsmechanicskinematicGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_kinematic_graphn_len(s : PhysicsmechanicskinematicGraphN) -> Int { s.size }

pub fn physics_mechanics_kinematic_graphn_get(s : PhysicsmechanicskinematicGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_kinematic_graphn_set(s : PhysicsmechanicskinematicGraphN, i : Int, v : Double) -> PhysicsmechanicskinematicGraphN {
  let result = physics_mechanics_kinematic_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_kinematic_graphn_sum(s : PhysicsmechanicskinematicGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_mechanics_kinematic_graphn_mean(s : PhysicsmechanicskinematicGraphN) -> Double {
  if s.size == 0 { 0.0 } else { physics_mechanics_kinematic_graphn_sum(s) / s.size.to_double() }
}

pub fn physics_mechanics_kinematic_graphn_scale(s : PhysicsmechanicskinematicGraphN, f : Double) -> PhysicsmechanicskinematicGraphN {
  let result = physics_mechanics_kinematic_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_mechanics_kinematic_graphn_add(a : PhysicsmechanicskinematicGraphN, b : PhysicsmechanicskinematicGraphN) -> PhysicsmechanicskinematicGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_mechanics_kinematic_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_mechanics_kinematic_graphn_copy(s : PhysicsmechanicskinematicGraphN) -> PhysicsmechanicskinematicGraphN {
  let result = physics_mechanics_kinematic_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_mechanics_kinematic_graphn_fill(s : PhysicsmechanicskinematicGraphN, v : Double) -> PhysicsmechanicskinematicGraphN {
  let result = physics_mechanics_kinematic_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_kinematic_graphn_min(s : PhysicsmechanicskinematicGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_kinematic_graphn_max(s : PhysicsmechanicskinematicGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_kinematic_graphn_to_string(s : PhysicsmechanicskinematicGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicskinematicNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_kinematic_node_make(size : Int) -> PhysicsmechanicskinematicNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_kinematic_node_len(s : PhysicsmechanicskinematicNode) -> Int { s.size }

pub fn physics_mechanics_kinematic_node_get(s : PhysicsmechanicskinematicNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_kinematic_node_set(s : PhysicsmechanicskinematicNode, i : Int, v : Double) -> PhysicsmechanicskinematicNode {
  let result = physics_mechanics_kinematic_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_kinematic_node_sum(s : PhysicsmechanicskinematicNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_mechanics_kinematic_node_mean(s : PhysicsmechanicskinematicNode) -> Double {
  if s.size == 0 { 0.0 } else { physics_mechanics_kinematic_node_sum(s) / s.size.to_double() }
}

pub fn physics_mechanics_kinematic_node_scale(s : PhysicsmechanicskinematicNode, f : Double) -> PhysicsmechanicskinematicNode {
  let result = physics_mechanics_kinematic_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_mechanics_kinematic_node_add(a : PhysicsmechanicskinematicNode, b : PhysicsmechanicskinematicNode) -> PhysicsmechanicskinematicNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_mechanics_kinematic_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_mechanics_kinematic_node_copy(s : PhysicsmechanicskinematicNode) -> PhysicsmechanicskinematicNode {
  let result = physics_mechanics_kinematic_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_mechanics_kinematic_node_fill(s : PhysicsmechanicskinematicNode, v : Double) -> PhysicsmechanicskinematicNode {
  let result = physics_mechanics_kinematic_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_kinematic_node_min(s : PhysicsmechanicskinematicNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_kinematic_node_max(s : PhysicsmechanicskinematicNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_kinematic_node_to_string(s : PhysicsmechanicskinematicNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicskinematicEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_kinematic_edge_make(size : Int) -> PhysicsmechanicskinematicEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_kinematic_edge_len(s : PhysicsmechanicskinematicEdge) -> Int { s.size }

pub fn physics_mechanics_kinematic_edge_get(s : PhysicsmechanicskinematicEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_kinematic_edge_set(s : PhysicsmechanicskinematicEdge, i : Int, v : Double) -> PhysicsmechanicskinematicEdge {
  let result = physics_mechanics_kinematic_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_kinematic_edge_sum(s : PhysicsmechanicskinematicEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_mechanics_kinematic_edge_mean(s : PhysicsmechanicskinematicEdge) -> Double {
  if s.size == 0 { 0.0 } else { physics_mechanics_kinematic_edge_sum(s) / s.size.to_double() }
}

pub fn physics_mechanics_kinematic_edge_scale(s : PhysicsmechanicskinematicEdge, f : Double) -> PhysicsmechanicskinematicEdge {
  let result = physics_mechanics_kinematic_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_mechanics_kinematic_edge_add(a : PhysicsmechanicskinematicEdge, b : PhysicsmechanicskinematicEdge) -> PhysicsmechanicskinematicEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_mechanics_kinematic_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_mechanics_kinematic_edge_copy(s : PhysicsmechanicskinematicEdge) -> PhysicsmechanicskinematicEdge {
  let result = physics_mechanics_kinematic_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_mechanics_kinematic_edge_fill(s : PhysicsmechanicskinematicEdge, v : Double) -> PhysicsmechanicskinematicEdge {
  let result = physics_mechanics_kinematic_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_kinematic_edge_min(s : PhysicsmechanicskinematicEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_kinematic_edge_max(s : PhysicsmechanicskinematicEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_kinematic_edge_to_string(s : PhysicsmechanicskinematicEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicskinematicPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_kinematic_path_make(size : Int) -> PhysicsmechanicskinematicPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_kinematic_path_len(s : PhysicsmechanicskinematicPath) -> Int { s.size }

pub fn physics_mechanics_kinematic_path_get(s : PhysicsmechanicskinematicPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_kinematic_path_set(s : PhysicsmechanicskinematicPath, i : Int, v : Double) -> PhysicsmechanicskinematicPath {
  let result = physics_mechanics_kinematic_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_kinematic_path_sum(s : PhysicsmechanicskinematicPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_mechanics_kinematic_path_mean(s : PhysicsmechanicskinematicPath) -> Double {
  if s.size == 0 { 0.0 } else { physics_mechanics_kinematic_path_sum(s) / s.size.to_double() }
}

pub fn physics_mechanics_kinematic_path_scale(s : PhysicsmechanicskinematicPath, f : Double) -> PhysicsmechanicskinematicPath {
  let result = physics_mechanics_kinematic_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_mechanics_kinematic_path_add(a : PhysicsmechanicskinematicPath, b : PhysicsmechanicskinematicPath) -> PhysicsmechanicskinematicPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_mechanics_kinematic_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_mechanics_kinematic_path_copy(s : PhysicsmechanicskinematicPath) -> PhysicsmechanicskinematicPath {
  let result = physics_mechanics_kinematic_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_mechanics_kinematic_path_fill(s : PhysicsmechanicskinematicPath, v : Double) -> PhysicsmechanicskinematicPath {
  let result = physics_mechanics_kinematic_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_kinematic_path_min(s : PhysicsmechanicskinematicPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_kinematic_path_max(s : PhysicsmechanicskinematicPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_kinematic_path_to_string(s : PhysicsmechanicskinematicPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicskinematicCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_kinematic_cluster_make(size : Int) -> PhysicsmechanicskinematicCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_kinematic_cluster_len(s : PhysicsmechanicskinematicCluster) -> Int { s.size }

pub fn physics_mechanics_kinematic_cluster_get(s : PhysicsmechanicskinematicCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_kinematic_cluster_set(s : PhysicsmechanicskinematicCluster, i : Int, v : Double) -> PhysicsmechanicskinematicCluster {
  let result = physics_mechanics_kinematic_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_kinematic_cluster_sum(s : PhysicsmechanicskinematicCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_mechanics_kinematic_cluster_mean(s : PhysicsmechanicskinematicCluster) -> Double {
  if s.size == 0 { 0.0 } else { physics_mechanics_kinematic_cluster_sum(s) / s.size.to_double() }
}

pub fn physics_mechanics_kinematic_cluster_scale(s : PhysicsmechanicskinematicCluster, f : Double) -> PhysicsmechanicskinematicCluster {
  let result = physics_mechanics_kinematic_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_mechanics_kinematic_cluster_add(a : PhysicsmechanicskinematicCluster, b : PhysicsmechanicskinematicCluster) -> PhysicsmechanicskinematicCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_mechanics_kinematic_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_mechanics_kinematic_cluster_copy(s : PhysicsmechanicskinematicCluster) -> PhysicsmechanicskinematicCluster {
  let result = physics_mechanics_kinematic_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_mechanics_kinematic_cluster_fill(s : PhysicsmechanicskinematicCluster, v : Double) -> PhysicsmechanicskinematicCluster {
  let result = physics_mechanics_kinematic_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_kinematic_cluster_min(s : PhysicsmechanicskinematicCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_kinematic_cluster_max(s : PhysicsmechanicskinematicCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_kinematic_cluster_to_string(s : PhysicsmechanicskinematicCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicskinematicModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_kinematic_model_make(size : Int) -> PhysicsmechanicskinematicModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_kinematic_model_len(s : PhysicsmechanicskinematicModel) -> Int { s.size }

pub fn physics_mechanics_kinematic_model_get(s : PhysicsmechanicskinematicModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_kinematic_model_set(s : PhysicsmechanicskinematicModel, i : Int, v : Double) -> PhysicsmechanicskinematicModel {
  let result = physics_mechanics_kinematic_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_kinematic_model_sum(s : PhysicsmechanicskinematicModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_mechanics_kinematic_model_mean(s : PhysicsmechanicskinematicModel) -> Double {
  if s.size == 0 { 0.0 } else { physics_mechanics_kinematic_model_sum(s) / s.size.to_double() }
}

pub fn physics_mechanics_kinematic_model_scale(s : PhysicsmechanicskinematicModel, f : Double) -> PhysicsmechanicskinematicModel {
  let result = physics_mechanics_kinematic_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_mechanics_kinematic_model_add(a : PhysicsmechanicskinematicModel, b : PhysicsmechanicskinematicModel) -> PhysicsmechanicskinematicModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_mechanics_kinematic_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_mechanics_kinematic_model_copy(s : PhysicsmechanicskinematicModel) -> PhysicsmechanicskinematicModel {
  let result = physics_mechanics_kinematic_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_mechanics_kinematic_model_fill(s : PhysicsmechanicskinematicModel, v : Double) -> PhysicsmechanicskinematicModel {
  let result = physics_mechanics_kinematic_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_kinematic_model_min(s : PhysicsmechanicskinematicModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_kinematic_model_max(s : PhysicsmechanicskinematicModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_kinematic_model_to_string(s : PhysicsmechanicskinematicModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicskinematicLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_kinematic_layer_make(size : Int) -> PhysicsmechanicskinematicLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_kinematic_layer_len(s : PhysicsmechanicskinematicLayer) -> Int { s.size }

pub fn physics_mechanics_kinematic_layer_get(s : PhysicsmechanicskinematicLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_kinematic_layer_set(s : PhysicsmechanicskinematicLayer, i : Int, v : Double) -> PhysicsmechanicskinematicLayer {
  let result = physics_mechanics_kinematic_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_kinematic_layer_sum(s : PhysicsmechanicskinematicLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_mechanics_kinematic_layer_mean(s : PhysicsmechanicskinematicLayer) -> Double {
  if s.size == 0 { 0.0 } else { physics_mechanics_kinematic_layer_sum(s) / s.size.to_double() }
}

pub fn physics_mechanics_kinematic_layer_scale(s : PhysicsmechanicskinematicLayer, f : Double) -> PhysicsmechanicskinematicLayer {
  let result = physics_mechanics_kinematic_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_mechanics_kinematic_layer_add(a : PhysicsmechanicskinematicLayer, b : PhysicsmechanicskinematicLayer) -> PhysicsmechanicskinematicLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_mechanics_kinematic_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_mechanics_kinematic_layer_copy(s : PhysicsmechanicskinematicLayer) -> PhysicsmechanicskinematicLayer {
  let result = physics_mechanics_kinematic_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_mechanics_kinematic_layer_fill(s : PhysicsmechanicskinematicLayer, v : Double) -> PhysicsmechanicskinematicLayer {
  let result = physics_mechanics_kinematic_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_kinematic_layer_min(s : PhysicsmechanicskinematicLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_kinematic_layer_max(s : PhysicsmechanicskinematicLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_kinematic_layer_to_string(s : PhysicsmechanicskinematicLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicskinematicBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_kinematic_buffer_make(size : Int) -> PhysicsmechanicskinematicBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_kinematic_buffer_len(s : PhysicsmechanicskinematicBuffer) -> Int { s.size }

pub fn physics_mechanics_kinematic_buffer_get(s : PhysicsmechanicskinematicBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_kinematic_buffer_set(s : PhysicsmechanicskinematicBuffer, i : Int, v : Double) -> PhysicsmechanicskinematicBuffer {
  let result = physics_mechanics_kinematic_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_kinematic_buffer_sum(s : PhysicsmechanicskinematicBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_mechanics_kinematic_buffer_mean(s : PhysicsmechanicskinematicBuffer) -> Double {
  if s.size == 0 { 0.0 } else { physics_mechanics_kinematic_buffer_sum(s) / s.size.to_double() }
}

pub fn physics_mechanics_kinematic_buffer_scale(s : PhysicsmechanicskinematicBuffer, f : Double) -> PhysicsmechanicskinematicBuffer {
  let result = physics_mechanics_kinematic_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_mechanics_kinematic_buffer_add(a : PhysicsmechanicskinematicBuffer, b : PhysicsmechanicskinematicBuffer) -> PhysicsmechanicskinematicBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_mechanics_kinematic_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_mechanics_kinematic_buffer_copy(s : PhysicsmechanicskinematicBuffer) -> PhysicsmechanicskinematicBuffer {
  let result = physics_mechanics_kinematic_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_mechanics_kinematic_buffer_fill(s : PhysicsmechanicskinematicBuffer, v : Double) -> PhysicsmechanicskinematicBuffer {
  let result = physics_mechanics_kinematic_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_kinematic_buffer_min(s : PhysicsmechanicskinematicBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_kinematic_buffer_max(s : PhysicsmechanicskinematicBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_kinematic_buffer_to_string(s : PhysicsmechanicskinematicBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicskinematicCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_kinematic_cursor_make(size : Int) -> PhysicsmechanicskinematicCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_kinematic_cursor_len(s : PhysicsmechanicskinematicCursor) -> Int { s.size }

pub fn physics_mechanics_kinematic_cursor_get(s : PhysicsmechanicskinematicCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_kinematic_cursor_set(s : PhysicsmechanicskinematicCursor, i : Int, v : Double) -> PhysicsmechanicskinematicCursor {
  let result = physics_mechanics_kinematic_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_kinematic_cursor_sum(s : PhysicsmechanicskinematicCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_mechanics_kinematic_cursor_mean(s : PhysicsmechanicskinematicCursor) -> Double {
  if s.size == 0 { 0.0 } else { physics_mechanics_kinematic_cursor_sum(s) / s.size.to_double() }
}

pub fn physics_mechanics_kinematic_cursor_scale(s : PhysicsmechanicskinematicCursor, f : Double) -> PhysicsmechanicskinematicCursor {
  let result = physics_mechanics_kinematic_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_mechanics_kinematic_cursor_add(a : PhysicsmechanicskinematicCursor, b : PhysicsmechanicskinematicCursor) -> PhysicsmechanicskinematicCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_mechanics_kinematic_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_mechanics_kinematic_cursor_copy(s : PhysicsmechanicskinematicCursor) -> PhysicsmechanicskinematicCursor {
  let result = physics_mechanics_kinematic_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_mechanics_kinematic_cursor_fill(s : PhysicsmechanicskinematicCursor, v : Double) -> PhysicsmechanicskinematicCursor {
  let result = physics_mechanics_kinematic_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_kinematic_cursor_min(s : PhysicsmechanicskinematicCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_kinematic_cursor_max(s : PhysicsmechanicskinematicCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_kinematic_cursor_to_string(s : PhysicsmechanicskinematicCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicskinematicView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_kinematic_view_make(size : Int) -> PhysicsmechanicskinematicView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_kinematic_view_len(s : PhysicsmechanicskinematicView) -> Int { s.size }

pub fn physics_mechanics_kinematic_view_get(s : PhysicsmechanicskinematicView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_kinematic_view_set(s : PhysicsmechanicskinematicView, i : Int, v : Double) -> PhysicsmechanicskinematicView {
  let result = physics_mechanics_kinematic_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_kinematic_view_sum(s : PhysicsmechanicskinematicView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_mechanics_kinematic_view_mean(s : PhysicsmechanicskinematicView) -> Double {
  if s.size == 0 { 0.0 } else { physics_mechanics_kinematic_view_sum(s) / s.size.to_double() }
}

pub fn physics_mechanics_kinematic_view_scale(s : PhysicsmechanicskinematicView, f : Double) -> PhysicsmechanicskinematicView {
  let result = physics_mechanics_kinematic_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_mechanics_kinematic_view_add(a : PhysicsmechanicskinematicView, b : PhysicsmechanicskinematicView) -> PhysicsmechanicskinematicView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_mechanics_kinematic_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_mechanics_kinematic_view_copy(s : PhysicsmechanicskinematicView) -> PhysicsmechanicskinematicView {
  let result = physics_mechanics_kinematic_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_mechanics_kinematic_view_fill(s : PhysicsmechanicskinematicView, v : Double) -> PhysicsmechanicskinematicView {
  let result = physics_mechanics_kinematic_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_kinematic_view_min(s : PhysicsmechanicskinematicView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_kinematic_view_max(s : PhysicsmechanicskinematicView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_kinematic_view_to_string(s : PhysicsmechanicskinematicView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicskinematicRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_kinematic_range_make(size : Int) -> PhysicsmechanicskinematicRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_kinematic_range_len(s : PhysicsmechanicskinematicRange) -> Int { s.size }

pub fn physics_mechanics_kinematic_range_get(s : PhysicsmechanicskinematicRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_kinematic_range_set(s : PhysicsmechanicskinematicRange, i : Int, v : Double) -> PhysicsmechanicskinematicRange {
  let result = physics_mechanics_kinematic_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_kinematic_range_sum(s : PhysicsmechanicskinematicRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_mechanics_kinematic_range_mean(s : PhysicsmechanicskinematicRange) -> Double {
  if s.size == 0 { 0.0 } else { physics_mechanics_kinematic_range_sum(s) / s.size.to_double() }
}

pub fn physics_mechanics_kinematic_range_scale(s : PhysicsmechanicskinematicRange, f : Double) -> PhysicsmechanicskinematicRange {
  let result = physics_mechanics_kinematic_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_mechanics_kinematic_range_add(a : PhysicsmechanicskinematicRange, b : PhysicsmechanicskinematicRange) -> PhysicsmechanicskinematicRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_mechanics_kinematic_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_mechanics_kinematic_range_copy(s : PhysicsmechanicskinematicRange) -> PhysicsmechanicskinematicRange {
  let result = physics_mechanics_kinematic_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_mechanics_kinematic_range_fill(s : PhysicsmechanicskinematicRange, v : Double) -> PhysicsmechanicskinematicRange {
  let result = physics_mechanics_kinematic_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_kinematic_range_min(s : PhysicsmechanicskinematicRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_kinematic_range_max(s : PhysicsmechanicskinematicRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_kinematic_range_to_string(s : PhysicsmechanicskinematicRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicskinematicSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_kinematic_slice_make(size : Int) -> PhysicsmechanicskinematicSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_kinematic_slice_len(s : PhysicsmechanicskinematicSlice) -> Int { s.size }

pub fn physics_mechanics_kinematic_slice_get(s : PhysicsmechanicskinematicSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_kinematic_slice_set(s : PhysicsmechanicskinematicSlice, i : Int, v : Double) -> PhysicsmechanicskinematicSlice {
  let result = physics_mechanics_kinematic_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_kinematic_slice_sum(s : PhysicsmechanicskinematicSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_mechanics_kinematic_slice_mean(s : PhysicsmechanicskinematicSlice) -> Double {
  if s.size == 0 { 0.0 } else { physics_mechanics_kinematic_slice_sum(s) / s.size.to_double() }
}

pub fn physics_mechanics_kinematic_slice_scale(s : PhysicsmechanicskinematicSlice, f : Double) -> PhysicsmechanicskinematicSlice {
  let result = physics_mechanics_kinematic_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_mechanics_kinematic_slice_add(a : PhysicsmechanicskinematicSlice, b : PhysicsmechanicskinematicSlice) -> PhysicsmechanicskinematicSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_mechanics_kinematic_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_mechanics_kinematic_slice_copy(s : PhysicsmechanicskinematicSlice) -> PhysicsmechanicskinematicSlice {
  let result = physics_mechanics_kinematic_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_mechanics_kinematic_slice_fill(s : PhysicsmechanicskinematicSlice, v : Double) -> PhysicsmechanicskinematicSlice {
  let result = physics_mechanics_kinematic_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_kinematic_slice_min(s : PhysicsmechanicskinematicSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_kinematic_slice_max(s : PhysicsmechanicskinematicSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_kinematic_slice_to_string(s : PhysicsmechanicskinematicSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn physics_mechanics_kinematic_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_mechanics_kinematic_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_mechanics_kinematic_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_mechanics_kinematic_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_mechanics_kinematic_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_mechanics_kinematic_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_mechanics_kinematic_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_mechanics_kinematic_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_mechanics_kinematic_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_mechanics_kinematic_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_mechanics_kinematic_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_mechanics_kinematic_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_mechanics_kinematic_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_mechanics_kinematic_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_mechanics_kinematic_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_mechanics_kinematic_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_mechanics_kinematic_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_mechanics_kinematic_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_mechanics_kinematic_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_mechanics_kinematic_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_mechanics_kinematic_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_mechanics_kinematic_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_mechanics_kinematic_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_mechanics_kinematic_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_mechanics_kinematic_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

