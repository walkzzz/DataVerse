///===
/// extcore/physics_heat_diffusion

pub(all) struct PhysicsheatdiffusionPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn physics_heat_diffusion_make_point(x : Double, y : Double) -> PhysicsheatdiffusionPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn physics_heat_diffusion_make_point3(x : Double, y : Double, z : Double) -> PhysicsheatdiffusionPoint {
  { x, y, z, label: 0 }
}

pub fn physics_heat_diffusion_point_x(pt : PhysicsheatdiffusionPoint) -> Double { pt.x }

pub fn physics_heat_diffusion_point_y(pt : PhysicsheatdiffusionPoint) -> Double { pt.y }

pub fn physics_heat_diffusion_point_z(pt : PhysicsheatdiffusionPoint) -> Double { pt.z }

pub fn physics_heat_diffusion_point_label(pt : PhysicsheatdiffusionPoint) -> Int { pt.label }

pub fn physics_heat_diffusion_point_dist(a : PhysicsheatdiffusionPoint, b : PhysicsheatdiffusionPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  physics_heat_diffusion_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn physics_heat_diffusion_point_add(a : PhysicsheatdiffusionPoint, b : PhysicsheatdiffusionPoint) -> PhysicsheatdiffusionPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn physics_heat_diffusion_point_sub(a : PhysicsheatdiffusionPoint, b : PhysicsheatdiffusionPoint) -> PhysicsheatdiffusionPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn physics_heat_diffusion_point_scale(pt : PhysicsheatdiffusionPoint, s : Double) -> PhysicsheatdiffusionPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn physics_heat_diffusion_point_dot(a : PhysicsheatdiffusionPoint, b : PhysicsheatdiffusionPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn physics_heat_diffusion_point_cross(a : PhysicsheatdiffusionPoint, b : PhysicsheatdiffusionPoint) -> PhysicsheatdiffusionPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn physics_heat_diffusion_point_norm(pt : PhysicsheatdiffusionPoint) -> Double {
  physics_heat_diffusion_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn physics_heat_diffusion_point_normalize(pt : PhysicsheatdiffusionPoint) -> PhysicsheatdiffusionPoint {
  let n = physics_heat_diffusion_point_norm(pt)
  if n < 0.0000001 { pt } else { physics_heat_diffusion_point_scale(pt, 1.0 / n) }
}

pub fn physics_heat_diffusion_point_negate(pt : PhysicsheatdiffusionPoint) -> PhysicsheatdiffusionPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn physics_heat_diffusion_point_mid(a : PhysicsheatdiffusionPoint, b : PhysicsheatdiffusionPoint) -> PhysicsheatdiffusionPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn physics_heat_diffusion_point_lerp(a : PhysicsheatdiffusionPoint, b : PhysicsheatdiffusionPoint, t : Double) -> PhysicsheatdiffusionPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn physics_heat_diffusion_point_to_string(pt : PhysicsheatdiffusionPoint) -> String {
  "(" + physics_heat_diffusion_dbl(pt.x) + ", " + physics_heat_diffusion_dbl(pt.y) + ", " + physics_heat_diffusion_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct PhysicsheatdiffusionSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn physics_heat_diffusion_make_series(vals : Array[Double], name : String) -> PhysicsheatdiffusionSeries {
  { vals, name, meta: 0 }
}

pub fn physics_heat_diffusion_series_len(s : PhysicsheatdiffusionSeries) -> Int { s.vals.length() }

pub fn physics_heat_diffusion_series_sum(s : PhysicsheatdiffusionSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn physics_heat_diffusion_series_mean(s : PhysicsheatdiffusionSeries) -> Double {
  let n = physics_heat_diffusion_series_len(s)
  if n == 0 { 0.0 } else { physics_heat_diffusion_series_sum(s) / n.to_double() }
}

pub fn physics_heat_diffusion_series_min(s : PhysicsheatdiffusionSeries) -> Double {
  let n = physics_heat_diffusion_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn physics_heat_diffusion_series_max(s : PhysicsheatdiffusionSeries) -> Double {
  let n = physics_heat_diffusion_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn physics_heat_diffusion_series_range(s : PhysicsheatdiffusionSeries) -> Double {
  physics_heat_diffusion_series_max(s) - physics_heat_diffusion_series_min(s)
}

pub fn physics_heat_diffusion_series_var(s : PhysicsheatdiffusionSeries) -> Double {
  let n = physics_heat_diffusion_series_len(s)
  if n == 0 { 0.0 } else {
    let m = physics_heat_diffusion_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn physics_heat_diffusion_series_std(s : PhysicsheatdiffusionSeries) -> Double { physics_heat_diffusion_sqrt(physics_heat_diffusion_series_var(s)) }

pub fn physics_heat_diffusion_series_median(s : PhysicsheatdiffusionSeries) -> Double {
  let n = physics_heat_diffusion_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = physics_heat_diffusion_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn physics_heat_diffusion_series_scale(s : PhysicsheatdiffusionSeries, f : Double) -> PhysicsheatdiffusionSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = physics_heat_diffusion_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn physics_heat_diffusion_series_add(a : PhysicsheatdiffusionSeries, b : PhysicsheatdiffusionSeries) -> PhysicsheatdiffusionSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = physics_heat_diffusion_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn physics_heat_diffusion_series_sub(a : PhysicsheatdiffusionSeries, b : PhysicsheatdiffusionSeries) -> PhysicsheatdiffusionSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = physics_heat_diffusion_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn physics_heat_diffusion_series_normalize(s : PhysicsheatdiffusionSeries) -> PhysicsheatdiffusionSeries {
  let mn = physics_heat_diffusion_series_min(s)
  let mx = physics_heat_diffusion_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = physics_heat_diffusion_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn physics_heat_diffusion_series_cumsum(s : PhysicsheatdiffusionSeries) -> PhysicsheatdiffusionSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = physics_heat_diffusion_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn physics_heat_diffusion_series_to_string(s : PhysicsheatdiffusionSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + physics_heat_diffusion_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct PhysicsheatdiffusionMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn physics_heat_diffusion_make_matrix(rows : Int, cols : Int, val : Double) -> PhysicsheatdiffusionMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn physics_heat_diffusion_matrix_identity(n : Int) -> PhysicsheatdiffusionMatrix {
  let m = physics_heat_diffusion_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn physics_heat_diffusion_matrix_get(m : PhysicsheatdiffusionMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn physics_heat_diffusion_matrix_transpose(m : PhysicsheatdiffusionMatrix) -> PhysicsheatdiffusionMatrix {
  let result = physics_heat_diffusion_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn physics_heat_diffusion_matrix_add(a : PhysicsheatdiffusionMatrix, b : PhysicsheatdiffusionMatrix) -> PhysicsheatdiffusionMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = physics_heat_diffusion_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn physics_heat_diffusion_matrix_scale(m : PhysicsheatdiffusionMatrix, s : Double) -> PhysicsheatdiffusionMatrix {
  let result = physics_heat_diffusion_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn physics_heat_diffusion_matrix_multiply(a : PhysicsheatdiffusionMatrix, b : PhysicsheatdiffusionMatrix) -> PhysicsheatdiffusionMatrix {
  if a.cols != b.rows { return physics_heat_diffusion_make_matrix(a.rows, b.cols, 0.0) }
  let result = physics_heat_diffusion_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn physics_heat_diffusion_matrix_trace(m : PhysicsheatdiffusionMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn physics_heat_diffusion_matrix_det(m : PhysicsheatdiffusionMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn physics_heat_diffusion_matrix_norm(m : PhysicsheatdiffusionMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  physics_heat_diffusion_sqrt(sum)
}

pub fn physics_heat_diffusion_matrix_to_string(m : PhysicsheatdiffusionMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + physics_heat_diffusion_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct PhysicsheatdiffusionVector {
  comps : Array[Double]
  dim : Int
}

pub fn physics_heat_diffusion_make_vector(comps : Array[Double]) -> PhysicsheatdiffusionVector {
  { comps, dim: comps.length() }
}

pub fn physics_heat_diffusion_vector_zero(dim : Int) -> PhysicsheatdiffusionVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn physics_heat_diffusion_vector_add(a : PhysicsheatdiffusionVector, b : PhysicsheatdiffusionVector) -> PhysicsheatdiffusionVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = physics_heat_diffusion_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn physics_heat_diffusion_vector_sub(a : PhysicsheatdiffusionVector, b : PhysicsheatdiffusionVector) -> PhysicsheatdiffusionVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = physics_heat_diffusion_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn physics_heat_diffusion_vector_scale(v : PhysicsheatdiffusionVector, s : Double) -> PhysicsheatdiffusionVector {
  let mut result = []
  for i in 0..<v.dim { result = physics_heat_diffusion_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn physics_heat_diffusion_vector_dot(a : PhysicsheatdiffusionVector, b : PhysicsheatdiffusionVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn physics_heat_diffusion_vector_norm(v : PhysicsheatdiffusionVector) -> Double { physics_heat_diffusion_sqrt(physics_heat_diffusion_vector_dot(v, v)) }

pub fn physics_heat_diffusion_vector_normalize(v : PhysicsheatdiffusionVector) -> PhysicsheatdiffusionVector {
  let n = physics_heat_diffusion_vector_norm(v)
  if n < 0.0000001 { v } else { physics_heat_diffusion_vector_scale(v, 1.0 / n) }
}

pub fn physics_heat_diffusion_vector_dist(a : PhysicsheatdiffusionVector, b : PhysicsheatdiffusionVector) -> Double {
  physics_heat_diffusion_vector_norm(physics_heat_diffusion_vector_sub(a, b))
}

pub fn physics_heat_diffusion_vector_to_string(v : PhysicsheatdiffusionVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + physics_heat_diffusion_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn physics_heat_diffusion_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn physics_heat_diffusion_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = physics_heat_diffusion_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn physics_heat_diffusion_std(data : Array[Double]) -> Double { physics_heat_diffusion_sqrt(physics_heat_diffusion_var(data)) }

pub fn physics_heat_diffusion_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = physics_heat_diffusion_mean(a); let mb = physics_heat_diffusion_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn physics_heat_diffusion_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = physics_heat_diffusion_std(a); let sb = physics_heat_diffusion_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { physics_heat_diffusion_cov(a, b) / (sa * sb) }
}

pub fn physics_heat_diffusion_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = physics_heat_diffusion_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn physics_heat_diffusion_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn physics_heat_diffusion_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn physics_heat_diffusion_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  physics_heat_diffusion_sqrt(physics_heat_diffusion_mse(pred, labels))
}

pub fn physics_heat_diffusion_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + physics_heat_diffusion_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn physics_heat_diffusion_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = physics_heat_diffusion_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn physics_heat_diffusion_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn physics_heat_diffusion_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn physics_heat_diffusion_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = physics_heat_diffusion_precision(pred, labels, pos); let r = physics_heat_diffusion_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn physics_heat_diffusion_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn physics_heat_diffusion_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = physics_heat_diffusion_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn physics_heat_diffusion_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn physics_heat_diffusion_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn physics_heat_diffusion_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = physics_heat_diffusion_gcd(a, b)
    (a / g) * b
  }
}

pub fn physics_heat_diffusion_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn physics_heat_diffusion_fibonacci(n : Int) -> Int {
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

pub fn physics_heat_diffusion_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = physics_heat_diffusion_min(data); let mx = physics_heat_diffusion_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn physics_heat_diffusion_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = physics_heat_diffusion_mean(data); let sd = physics_heat_diffusion_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn physics_heat_diffusion_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn physics_heat_diffusion_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn physics_heat_diffusion_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn physics_heat_diffusion_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn physics_heat_diffusion_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn physics_heat_diffusion_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn physics_heat_diffusion_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn physics_heat_diffusion_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn physics_heat_diffusion_dbl(x : Double) -> String {
  let i = if x >= 0.0 { physics_heat_diffusion_int(x) } else { -physics_heat_diffusion_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { physics_heat_diffusion_int(f * 1000000.0) } else { physics_heat_diffusion_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn physics_heat_diffusion_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn physics_heat_diffusion_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct PhysicsheatdiffusionFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_diffusion_frame_make(size : Int) -> PhysicsheatdiffusionFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_diffusion_frame_len(s : PhysicsheatdiffusionFrame) -> Int { s.size }

pub fn physics_heat_diffusion_frame_get(s : PhysicsheatdiffusionFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_diffusion_frame_set(s : PhysicsheatdiffusionFrame, i : Int, v : Double) -> PhysicsheatdiffusionFrame {
  let result = physics_heat_diffusion_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_heat_diffusion_frame_sum(s : PhysicsheatdiffusionFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_heat_diffusion_frame_mean(s : PhysicsheatdiffusionFrame) -> Double {
  if s.size == 0 { 0.0 } else { physics_heat_diffusion_frame_sum(s) / s.size.to_double() }
}

pub fn physics_heat_diffusion_frame_scale(s : PhysicsheatdiffusionFrame, f : Double) -> PhysicsheatdiffusionFrame {
  let result = physics_heat_diffusion_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_heat_diffusion_frame_add(a : PhysicsheatdiffusionFrame, b : PhysicsheatdiffusionFrame) -> PhysicsheatdiffusionFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_heat_diffusion_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_heat_diffusion_frame_copy(s : PhysicsheatdiffusionFrame) -> PhysicsheatdiffusionFrame {
  let result = physics_heat_diffusion_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_heat_diffusion_frame_fill(s : PhysicsheatdiffusionFrame, v : Double) -> PhysicsheatdiffusionFrame {
  let result = physics_heat_diffusion_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_heat_diffusion_frame_min(s : PhysicsheatdiffusionFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_heat_diffusion_frame_max(s : PhysicsheatdiffusionFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_heat_diffusion_frame_to_string(s : PhysicsheatdiffusionFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatdiffusionTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_diffusion_table_make(size : Int) -> PhysicsheatdiffusionTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_diffusion_table_len(s : PhysicsheatdiffusionTable) -> Int { s.size }

pub fn physics_heat_diffusion_table_get(s : PhysicsheatdiffusionTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_diffusion_table_set(s : PhysicsheatdiffusionTable, i : Int, v : Double) -> PhysicsheatdiffusionTable {
  let result = physics_heat_diffusion_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_heat_diffusion_table_sum(s : PhysicsheatdiffusionTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_heat_diffusion_table_mean(s : PhysicsheatdiffusionTable) -> Double {
  if s.size == 0 { 0.0 } else { physics_heat_diffusion_table_sum(s) / s.size.to_double() }
}

pub fn physics_heat_diffusion_table_scale(s : PhysicsheatdiffusionTable, f : Double) -> PhysicsheatdiffusionTable {
  let result = physics_heat_diffusion_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_heat_diffusion_table_add(a : PhysicsheatdiffusionTable, b : PhysicsheatdiffusionTable) -> PhysicsheatdiffusionTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_heat_diffusion_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_heat_diffusion_table_copy(s : PhysicsheatdiffusionTable) -> PhysicsheatdiffusionTable {
  let result = physics_heat_diffusion_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_heat_diffusion_table_fill(s : PhysicsheatdiffusionTable, v : Double) -> PhysicsheatdiffusionTable {
  let result = physics_heat_diffusion_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_heat_diffusion_table_min(s : PhysicsheatdiffusionTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_heat_diffusion_table_max(s : PhysicsheatdiffusionTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_heat_diffusion_table_to_string(s : PhysicsheatdiffusionTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatdiffusionGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_diffusion_graphn_make(size : Int) -> PhysicsheatdiffusionGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_diffusion_graphn_len(s : PhysicsheatdiffusionGraphN) -> Int { s.size }

pub fn physics_heat_diffusion_graphn_get(s : PhysicsheatdiffusionGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_diffusion_graphn_set(s : PhysicsheatdiffusionGraphN, i : Int, v : Double) -> PhysicsheatdiffusionGraphN {
  let result = physics_heat_diffusion_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_heat_diffusion_graphn_sum(s : PhysicsheatdiffusionGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_heat_diffusion_graphn_mean(s : PhysicsheatdiffusionGraphN) -> Double {
  if s.size == 0 { 0.0 } else { physics_heat_diffusion_graphn_sum(s) / s.size.to_double() }
}

pub fn physics_heat_diffusion_graphn_scale(s : PhysicsheatdiffusionGraphN, f : Double) -> PhysicsheatdiffusionGraphN {
  let result = physics_heat_diffusion_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_heat_diffusion_graphn_add(a : PhysicsheatdiffusionGraphN, b : PhysicsheatdiffusionGraphN) -> PhysicsheatdiffusionGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_heat_diffusion_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_heat_diffusion_graphn_copy(s : PhysicsheatdiffusionGraphN) -> PhysicsheatdiffusionGraphN {
  let result = physics_heat_diffusion_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_heat_diffusion_graphn_fill(s : PhysicsheatdiffusionGraphN, v : Double) -> PhysicsheatdiffusionGraphN {
  let result = physics_heat_diffusion_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_heat_diffusion_graphn_min(s : PhysicsheatdiffusionGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_heat_diffusion_graphn_max(s : PhysicsheatdiffusionGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_heat_diffusion_graphn_to_string(s : PhysicsheatdiffusionGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatdiffusionNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_diffusion_node_make(size : Int) -> PhysicsheatdiffusionNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_diffusion_node_len(s : PhysicsheatdiffusionNode) -> Int { s.size }

pub fn physics_heat_diffusion_node_get(s : PhysicsheatdiffusionNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_diffusion_node_set(s : PhysicsheatdiffusionNode, i : Int, v : Double) -> PhysicsheatdiffusionNode {
  let result = physics_heat_diffusion_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_heat_diffusion_node_sum(s : PhysicsheatdiffusionNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_heat_diffusion_node_mean(s : PhysicsheatdiffusionNode) -> Double {
  if s.size == 0 { 0.0 } else { physics_heat_diffusion_node_sum(s) / s.size.to_double() }
}

pub fn physics_heat_diffusion_node_scale(s : PhysicsheatdiffusionNode, f : Double) -> PhysicsheatdiffusionNode {
  let result = physics_heat_diffusion_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_heat_diffusion_node_add(a : PhysicsheatdiffusionNode, b : PhysicsheatdiffusionNode) -> PhysicsheatdiffusionNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_heat_diffusion_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_heat_diffusion_node_copy(s : PhysicsheatdiffusionNode) -> PhysicsheatdiffusionNode {
  let result = physics_heat_diffusion_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_heat_diffusion_node_fill(s : PhysicsheatdiffusionNode, v : Double) -> PhysicsheatdiffusionNode {
  let result = physics_heat_diffusion_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_heat_diffusion_node_min(s : PhysicsheatdiffusionNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_heat_diffusion_node_max(s : PhysicsheatdiffusionNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_heat_diffusion_node_to_string(s : PhysicsheatdiffusionNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatdiffusionEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_diffusion_edge_make(size : Int) -> PhysicsheatdiffusionEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_diffusion_edge_len(s : PhysicsheatdiffusionEdge) -> Int { s.size }

pub fn physics_heat_diffusion_edge_get(s : PhysicsheatdiffusionEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_diffusion_edge_set(s : PhysicsheatdiffusionEdge, i : Int, v : Double) -> PhysicsheatdiffusionEdge {
  let result = physics_heat_diffusion_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_heat_diffusion_edge_sum(s : PhysicsheatdiffusionEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_heat_diffusion_edge_mean(s : PhysicsheatdiffusionEdge) -> Double {
  if s.size == 0 { 0.0 } else { physics_heat_diffusion_edge_sum(s) / s.size.to_double() }
}

pub fn physics_heat_diffusion_edge_scale(s : PhysicsheatdiffusionEdge, f : Double) -> PhysicsheatdiffusionEdge {
  let result = physics_heat_diffusion_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_heat_diffusion_edge_add(a : PhysicsheatdiffusionEdge, b : PhysicsheatdiffusionEdge) -> PhysicsheatdiffusionEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_heat_diffusion_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_heat_diffusion_edge_copy(s : PhysicsheatdiffusionEdge) -> PhysicsheatdiffusionEdge {
  let result = physics_heat_diffusion_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_heat_diffusion_edge_fill(s : PhysicsheatdiffusionEdge, v : Double) -> PhysicsheatdiffusionEdge {
  let result = physics_heat_diffusion_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_heat_diffusion_edge_min(s : PhysicsheatdiffusionEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_heat_diffusion_edge_max(s : PhysicsheatdiffusionEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_heat_diffusion_edge_to_string(s : PhysicsheatdiffusionEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatdiffusionPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_diffusion_path_make(size : Int) -> PhysicsheatdiffusionPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_diffusion_path_len(s : PhysicsheatdiffusionPath) -> Int { s.size }

pub fn physics_heat_diffusion_path_get(s : PhysicsheatdiffusionPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_diffusion_path_set(s : PhysicsheatdiffusionPath, i : Int, v : Double) -> PhysicsheatdiffusionPath {
  let result = physics_heat_diffusion_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_heat_diffusion_path_sum(s : PhysicsheatdiffusionPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_heat_diffusion_path_mean(s : PhysicsheatdiffusionPath) -> Double {
  if s.size == 0 { 0.0 } else { physics_heat_diffusion_path_sum(s) / s.size.to_double() }
}

pub fn physics_heat_diffusion_path_scale(s : PhysicsheatdiffusionPath, f : Double) -> PhysicsheatdiffusionPath {
  let result = physics_heat_diffusion_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_heat_diffusion_path_add(a : PhysicsheatdiffusionPath, b : PhysicsheatdiffusionPath) -> PhysicsheatdiffusionPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_heat_diffusion_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_heat_diffusion_path_copy(s : PhysicsheatdiffusionPath) -> PhysicsheatdiffusionPath {
  let result = physics_heat_diffusion_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_heat_diffusion_path_fill(s : PhysicsheatdiffusionPath, v : Double) -> PhysicsheatdiffusionPath {
  let result = physics_heat_diffusion_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_heat_diffusion_path_min(s : PhysicsheatdiffusionPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_heat_diffusion_path_max(s : PhysicsheatdiffusionPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_heat_diffusion_path_to_string(s : PhysicsheatdiffusionPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatdiffusionCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_diffusion_cluster_make(size : Int) -> PhysicsheatdiffusionCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_diffusion_cluster_len(s : PhysicsheatdiffusionCluster) -> Int { s.size }

pub fn physics_heat_diffusion_cluster_get(s : PhysicsheatdiffusionCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_diffusion_cluster_set(s : PhysicsheatdiffusionCluster, i : Int, v : Double) -> PhysicsheatdiffusionCluster {
  let result = physics_heat_diffusion_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_heat_diffusion_cluster_sum(s : PhysicsheatdiffusionCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_heat_diffusion_cluster_mean(s : PhysicsheatdiffusionCluster) -> Double {
  if s.size == 0 { 0.0 } else { physics_heat_diffusion_cluster_sum(s) / s.size.to_double() }
}

pub fn physics_heat_diffusion_cluster_scale(s : PhysicsheatdiffusionCluster, f : Double) -> PhysicsheatdiffusionCluster {
  let result = physics_heat_diffusion_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_heat_diffusion_cluster_add(a : PhysicsheatdiffusionCluster, b : PhysicsheatdiffusionCluster) -> PhysicsheatdiffusionCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_heat_diffusion_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_heat_diffusion_cluster_copy(s : PhysicsheatdiffusionCluster) -> PhysicsheatdiffusionCluster {
  let result = physics_heat_diffusion_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_heat_diffusion_cluster_fill(s : PhysicsheatdiffusionCluster, v : Double) -> PhysicsheatdiffusionCluster {
  let result = physics_heat_diffusion_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_heat_diffusion_cluster_min(s : PhysicsheatdiffusionCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_heat_diffusion_cluster_max(s : PhysicsheatdiffusionCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_heat_diffusion_cluster_to_string(s : PhysicsheatdiffusionCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatdiffusionModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_diffusion_model_make(size : Int) -> PhysicsheatdiffusionModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_diffusion_model_len(s : PhysicsheatdiffusionModel) -> Int { s.size }

pub fn physics_heat_diffusion_model_get(s : PhysicsheatdiffusionModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_diffusion_model_set(s : PhysicsheatdiffusionModel, i : Int, v : Double) -> PhysicsheatdiffusionModel {
  let result = physics_heat_diffusion_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_heat_diffusion_model_sum(s : PhysicsheatdiffusionModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_heat_diffusion_model_mean(s : PhysicsheatdiffusionModel) -> Double {
  if s.size == 0 { 0.0 } else { physics_heat_diffusion_model_sum(s) / s.size.to_double() }
}

pub fn physics_heat_diffusion_model_scale(s : PhysicsheatdiffusionModel, f : Double) -> PhysicsheatdiffusionModel {
  let result = physics_heat_diffusion_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_heat_diffusion_model_add(a : PhysicsheatdiffusionModel, b : PhysicsheatdiffusionModel) -> PhysicsheatdiffusionModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_heat_diffusion_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_heat_diffusion_model_copy(s : PhysicsheatdiffusionModel) -> PhysicsheatdiffusionModel {
  let result = physics_heat_diffusion_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_heat_diffusion_model_fill(s : PhysicsheatdiffusionModel, v : Double) -> PhysicsheatdiffusionModel {
  let result = physics_heat_diffusion_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_heat_diffusion_model_min(s : PhysicsheatdiffusionModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_heat_diffusion_model_max(s : PhysicsheatdiffusionModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_heat_diffusion_model_to_string(s : PhysicsheatdiffusionModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatdiffusionLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_diffusion_layer_make(size : Int) -> PhysicsheatdiffusionLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_diffusion_layer_len(s : PhysicsheatdiffusionLayer) -> Int { s.size }

pub fn physics_heat_diffusion_layer_get(s : PhysicsheatdiffusionLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_diffusion_layer_set(s : PhysicsheatdiffusionLayer, i : Int, v : Double) -> PhysicsheatdiffusionLayer {
  let result = physics_heat_diffusion_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_heat_diffusion_layer_sum(s : PhysicsheatdiffusionLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_heat_diffusion_layer_mean(s : PhysicsheatdiffusionLayer) -> Double {
  if s.size == 0 { 0.0 } else { physics_heat_diffusion_layer_sum(s) / s.size.to_double() }
}

pub fn physics_heat_diffusion_layer_scale(s : PhysicsheatdiffusionLayer, f : Double) -> PhysicsheatdiffusionLayer {
  let result = physics_heat_diffusion_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_heat_diffusion_layer_add(a : PhysicsheatdiffusionLayer, b : PhysicsheatdiffusionLayer) -> PhysicsheatdiffusionLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_heat_diffusion_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_heat_diffusion_layer_copy(s : PhysicsheatdiffusionLayer) -> PhysicsheatdiffusionLayer {
  let result = physics_heat_diffusion_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_heat_diffusion_layer_fill(s : PhysicsheatdiffusionLayer, v : Double) -> PhysicsheatdiffusionLayer {
  let result = physics_heat_diffusion_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_heat_diffusion_layer_min(s : PhysicsheatdiffusionLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_heat_diffusion_layer_max(s : PhysicsheatdiffusionLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_heat_diffusion_layer_to_string(s : PhysicsheatdiffusionLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatdiffusionBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_diffusion_buffer_make(size : Int) -> PhysicsheatdiffusionBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_diffusion_buffer_len(s : PhysicsheatdiffusionBuffer) -> Int { s.size }

pub fn physics_heat_diffusion_buffer_get(s : PhysicsheatdiffusionBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_diffusion_buffer_set(s : PhysicsheatdiffusionBuffer, i : Int, v : Double) -> PhysicsheatdiffusionBuffer {
  let result = physics_heat_diffusion_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_heat_diffusion_buffer_sum(s : PhysicsheatdiffusionBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_heat_diffusion_buffer_mean(s : PhysicsheatdiffusionBuffer) -> Double {
  if s.size == 0 { 0.0 } else { physics_heat_diffusion_buffer_sum(s) / s.size.to_double() }
}

pub fn physics_heat_diffusion_buffer_scale(s : PhysicsheatdiffusionBuffer, f : Double) -> PhysicsheatdiffusionBuffer {
  let result = physics_heat_diffusion_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_heat_diffusion_buffer_add(a : PhysicsheatdiffusionBuffer, b : PhysicsheatdiffusionBuffer) -> PhysicsheatdiffusionBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_heat_diffusion_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_heat_diffusion_buffer_copy(s : PhysicsheatdiffusionBuffer) -> PhysicsheatdiffusionBuffer {
  let result = physics_heat_diffusion_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_heat_diffusion_buffer_fill(s : PhysicsheatdiffusionBuffer, v : Double) -> PhysicsheatdiffusionBuffer {
  let result = physics_heat_diffusion_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_heat_diffusion_buffer_min(s : PhysicsheatdiffusionBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_heat_diffusion_buffer_max(s : PhysicsheatdiffusionBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_heat_diffusion_buffer_to_string(s : PhysicsheatdiffusionBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatdiffusionCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_diffusion_cursor_make(size : Int) -> PhysicsheatdiffusionCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_diffusion_cursor_len(s : PhysicsheatdiffusionCursor) -> Int { s.size }

pub fn physics_heat_diffusion_cursor_get(s : PhysicsheatdiffusionCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_diffusion_cursor_set(s : PhysicsheatdiffusionCursor, i : Int, v : Double) -> PhysicsheatdiffusionCursor {
  let result = physics_heat_diffusion_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_heat_diffusion_cursor_sum(s : PhysicsheatdiffusionCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_heat_diffusion_cursor_mean(s : PhysicsheatdiffusionCursor) -> Double {
  if s.size == 0 { 0.0 } else { physics_heat_diffusion_cursor_sum(s) / s.size.to_double() }
}

pub fn physics_heat_diffusion_cursor_scale(s : PhysicsheatdiffusionCursor, f : Double) -> PhysicsheatdiffusionCursor {
  let result = physics_heat_diffusion_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_heat_diffusion_cursor_add(a : PhysicsheatdiffusionCursor, b : PhysicsheatdiffusionCursor) -> PhysicsheatdiffusionCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_heat_diffusion_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_heat_diffusion_cursor_copy(s : PhysicsheatdiffusionCursor) -> PhysicsheatdiffusionCursor {
  let result = physics_heat_diffusion_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_heat_diffusion_cursor_fill(s : PhysicsheatdiffusionCursor, v : Double) -> PhysicsheatdiffusionCursor {
  let result = physics_heat_diffusion_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_heat_diffusion_cursor_min(s : PhysicsheatdiffusionCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_heat_diffusion_cursor_max(s : PhysicsheatdiffusionCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_heat_diffusion_cursor_to_string(s : PhysicsheatdiffusionCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatdiffusionView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_diffusion_view_make(size : Int) -> PhysicsheatdiffusionView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_diffusion_view_len(s : PhysicsheatdiffusionView) -> Int { s.size }

pub fn physics_heat_diffusion_view_get(s : PhysicsheatdiffusionView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_diffusion_view_set(s : PhysicsheatdiffusionView, i : Int, v : Double) -> PhysicsheatdiffusionView {
  let result = physics_heat_diffusion_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_heat_diffusion_view_sum(s : PhysicsheatdiffusionView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_heat_diffusion_view_mean(s : PhysicsheatdiffusionView) -> Double {
  if s.size == 0 { 0.0 } else { physics_heat_diffusion_view_sum(s) / s.size.to_double() }
}

pub fn physics_heat_diffusion_view_scale(s : PhysicsheatdiffusionView, f : Double) -> PhysicsheatdiffusionView {
  let result = physics_heat_diffusion_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_heat_diffusion_view_add(a : PhysicsheatdiffusionView, b : PhysicsheatdiffusionView) -> PhysicsheatdiffusionView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_heat_diffusion_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_heat_diffusion_view_copy(s : PhysicsheatdiffusionView) -> PhysicsheatdiffusionView {
  let result = physics_heat_diffusion_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_heat_diffusion_view_fill(s : PhysicsheatdiffusionView, v : Double) -> PhysicsheatdiffusionView {
  let result = physics_heat_diffusion_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_heat_diffusion_view_min(s : PhysicsheatdiffusionView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_heat_diffusion_view_max(s : PhysicsheatdiffusionView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_heat_diffusion_view_to_string(s : PhysicsheatdiffusionView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatdiffusionRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_diffusion_range_make(size : Int) -> PhysicsheatdiffusionRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_diffusion_range_len(s : PhysicsheatdiffusionRange) -> Int { s.size }

pub fn physics_heat_diffusion_range_get(s : PhysicsheatdiffusionRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_diffusion_range_set(s : PhysicsheatdiffusionRange, i : Int, v : Double) -> PhysicsheatdiffusionRange {
  let result = physics_heat_diffusion_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_heat_diffusion_range_sum(s : PhysicsheatdiffusionRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_heat_diffusion_range_mean(s : PhysicsheatdiffusionRange) -> Double {
  if s.size == 0 { 0.0 } else { physics_heat_diffusion_range_sum(s) / s.size.to_double() }
}

pub fn physics_heat_diffusion_range_scale(s : PhysicsheatdiffusionRange, f : Double) -> PhysicsheatdiffusionRange {
  let result = physics_heat_diffusion_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_heat_diffusion_range_add(a : PhysicsheatdiffusionRange, b : PhysicsheatdiffusionRange) -> PhysicsheatdiffusionRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_heat_diffusion_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_heat_diffusion_range_copy(s : PhysicsheatdiffusionRange) -> PhysicsheatdiffusionRange {
  let result = physics_heat_diffusion_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_heat_diffusion_range_fill(s : PhysicsheatdiffusionRange, v : Double) -> PhysicsheatdiffusionRange {
  let result = physics_heat_diffusion_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_heat_diffusion_range_min(s : PhysicsheatdiffusionRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_heat_diffusion_range_max(s : PhysicsheatdiffusionRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_heat_diffusion_range_to_string(s : PhysicsheatdiffusionRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatdiffusionSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_diffusion_slice_make(size : Int) -> PhysicsheatdiffusionSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_diffusion_slice_len(s : PhysicsheatdiffusionSlice) -> Int { s.size }

pub fn physics_heat_diffusion_slice_get(s : PhysicsheatdiffusionSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_diffusion_slice_set(s : PhysicsheatdiffusionSlice, i : Int, v : Double) -> PhysicsheatdiffusionSlice {
  let result = physics_heat_diffusion_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_heat_diffusion_slice_sum(s : PhysicsheatdiffusionSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_heat_diffusion_slice_mean(s : PhysicsheatdiffusionSlice) -> Double {
  if s.size == 0 { 0.0 } else { physics_heat_diffusion_slice_sum(s) / s.size.to_double() }
}

pub fn physics_heat_diffusion_slice_scale(s : PhysicsheatdiffusionSlice, f : Double) -> PhysicsheatdiffusionSlice {
  let result = physics_heat_diffusion_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_heat_diffusion_slice_add(a : PhysicsheatdiffusionSlice, b : PhysicsheatdiffusionSlice) -> PhysicsheatdiffusionSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_heat_diffusion_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_heat_diffusion_slice_copy(s : PhysicsheatdiffusionSlice) -> PhysicsheatdiffusionSlice {
  let result = physics_heat_diffusion_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_heat_diffusion_slice_fill(s : PhysicsheatdiffusionSlice, v : Double) -> PhysicsheatdiffusionSlice {
  let result = physics_heat_diffusion_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_heat_diffusion_slice_min(s : PhysicsheatdiffusionSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_heat_diffusion_slice_max(s : PhysicsheatdiffusionSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_heat_diffusion_slice_to_string(s : PhysicsheatdiffusionSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn physics_heat_diffusion_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_heat_diffusion_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_heat_diffusion_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_heat_diffusion_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_heat_diffusion_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_heat_diffusion_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_heat_diffusion_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_heat_diffusion_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_heat_diffusion_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_heat_diffusion_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_heat_diffusion_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_heat_diffusion_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_heat_diffusion_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_heat_diffusion_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_heat_diffusion_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_heat_diffusion_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_heat_diffusion_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_heat_diffusion_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_heat_diffusion_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_heat_diffusion_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_heat_diffusion_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_heat_diffusion_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_heat_diffusion_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_heat_diffusion_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_heat_diffusion_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

