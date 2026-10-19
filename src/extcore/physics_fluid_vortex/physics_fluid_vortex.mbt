///===
/// extcore/physics_fluid_vortex

pub(all) struct PhysicsfluidvortexPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn physics_fluid_vortex_make_point(x : Double, y : Double) -> PhysicsfluidvortexPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn physics_fluid_vortex_make_point3(x : Double, y : Double, z : Double) -> PhysicsfluidvortexPoint {
  { x, y, z, label: 0 }
}

pub fn physics_fluid_vortex_point_x(pt : PhysicsfluidvortexPoint) -> Double { pt.x }

pub fn physics_fluid_vortex_point_y(pt : PhysicsfluidvortexPoint) -> Double { pt.y }

pub fn physics_fluid_vortex_point_z(pt : PhysicsfluidvortexPoint) -> Double { pt.z }

pub fn physics_fluid_vortex_point_label(pt : PhysicsfluidvortexPoint) -> Int { pt.label }

pub fn physics_fluid_vortex_point_dist(a : PhysicsfluidvortexPoint, b : PhysicsfluidvortexPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn physics_fluid_vortex_point_add(a : PhysicsfluidvortexPoint, b : PhysicsfluidvortexPoint) -> PhysicsfluidvortexPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn physics_fluid_vortex_point_sub(a : PhysicsfluidvortexPoint, b : PhysicsfluidvortexPoint) -> PhysicsfluidvortexPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn physics_fluid_vortex_point_scale(pt : PhysicsfluidvortexPoint, s : Double) -> PhysicsfluidvortexPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn physics_fluid_vortex_point_dot(a : PhysicsfluidvortexPoint, b : PhysicsfluidvortexPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn physics_fluid_vortex_point_cross(a : PhysicsfluidvortexPoint, b : PhysicsfluidvortexPoint) -> PhysicsfluidvortexPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn physics_fluid_vortex_point_norm(pt : PhysicsfluidvortexPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn physics_fluid_vortex_point_normalize(pt : PhysicsfluidvortexPoint) -> PhysicsfluidvortexPoint {
  let n = physics_fluid_vortex_point_norm(pt)
  if n < 0.0000001 { pt } else { physics_fluid_vortex_point_scale(pt, 1.0 / n) }
}

pub fn physics_fluid_vortex_point_negate(pt : PhysicsfluidvortexPoint) -> PhysicsfluidvortexPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn physics_fluid_vortex_point_mid(a : PhysicsfluidvortexPoint, b : PhysicsfluidvortexPoint) -> PhysicsfluidvortexPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn physics_fluid_vortex_point_lerp(a : PhysicsfluidvortexPoint, b : PhysicsfluidvortexPoint, t : Double) -> PhysicsfluidvortexPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn physics_fluid_vortex_point_to_string(pt : PhysicsfluidvortexPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct PhysicsfluidvortexSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn physics_fluid_vortex_make_series(vals : Array[Double], name : String) -> PhysicsfluidvortexSeries {
  { vals, name, meta: 0 }
}

pub fn physics_fluid_vortex_series_len(s : PhysicsfluidvortexSeries) -> Int { s.vals.length() }

pub fn physics_fluid_vortex_series_sum(s : PhysicsfluidvortexSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn physics_fluid_vortex_series_mean(s : PhysicsfluidvortexSeries) -> Double {
  let n = physics_fluid_vortex_series_len(s)
  if n == 0 { 0.0 } else { physics_fluid_vortex_series_sum(s) / n.to_double() }
}

pub fn physics_fluid_vortex_series_min(s : PhysicsfluidvortexSeries) -> Double {
  let n = physics_fluid_vortex_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn physics_fluid_vortex_series_max(s : PhysicsfluidvortexSeries) -> Double {
  let n = physics_fluid_vortex_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn physics_fluid_vortex_series_range(s : PhysicsfluidvortexSeries) -> Double {
  physics_fluid_vortex_series_max(s) - physics_fluid_vortex_series_min(s)
}

pub fn physics_fluid_vortex_series_var(s : PhysicsfluidvortexSeries) -> Double {
  let n = physics_fluid_vortex_series_len(s)
  if n == 0 { 0.0 } else {
    let m = physics_fluid_vortex_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn physics_fluid_vortex_series_std(s : PhysicsfluidvortexSeries) -> Double { @_common.sqrt(physics_fluid_vortex_series_var(s)) }

pub fn physics_fluid_vortex_series_median(s : PhysicsfluidvortexSeries) -> Double {
  let n = physics_fluid_vortex_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = physics_fluid_vortex_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn physics_fluid_vortex_series_scale(s : PhysicsfluidvortexSeries, f : Double) -> PhysicsfluidvortexSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn physics_fluid_vortex_series_add(a : PhysicsfluidvortexSeries, b : PhysicsfluidvortexSeries) -> PhysicsfluidvortexSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn physics_fluid_vortex_series_sub(a : PhysicsfluidvortexSeries, b : PhysicsfluidvortexSeries) -> PhysicsfluidvortexSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn physics_fluid_vortex_series_normalize(s : PhysicsfluidvortexSeries) -> PhysicsfluidvortexSeries {
  let mn = physics_fluid_vortex_series_min(s)
  let mx = physics_fluid_vortex_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn physics_fluid_vortex_series_cumsum(s : PhysicsfluidvortexSeries) -> PhysicsfluidvortexSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn physics_fluid_vortex_series_to_string(s : PhysicsfluidvortexSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct PhysicsfluidvortexMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn physics_fluid_vortex_make_matrix(rows : Int, cols : Int, val : Double) -> PhysicsfluidvortexMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn physics_fluid_vortex_matrix_identity(n : Int) -> PhysicsfluidvortexMatrix {
  let m = physics_fluid_vortex_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn physics_fluid_vortex_matrix_get(m : PhysicsfluidvortexMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn physics_fluid_vortex_matrix_transpose(m : PhysicsfluidvortexMatrix) -> PhysicsfluidvortexMatrix {
  let result = physics_fluid_vortex_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn physics_fluid_vortex_matrix_add(a : PhysicsfluidvortexMatrix, b : PhysicsfluidvortexMatrix) -> PhysicsfluidvortexMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = physics_fluid_vortex_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn physics_fluid_vortex_matrix_scale(m : PhysicsfluidvortexMatrix, s : Double) -> PhysicsfluidvortexMatrix {
  let result = physics_fluid_vortex_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn physics_fluid_vortex_matrix_multiply(a : PhysicsfluidvortexMatrix, b : PhysicsfluidvortexMatrix) -> PhysicsfluidvortexMatrix {
  if a.cols != b.rows { return physics_fluid_vortex_make_matrix(a.rows, b.cols, 0.0) }
  let result = physics_fluid_vortex_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn physics_fluid_vortex_matrix_trace(m : PhysicsfluidvortexMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn physics_fluid_vortex_matrix_det(m : PhysicsfluidvortexMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn physics_fluid_vortex_matrix_norm(m : PhysicsfluidvortexMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn physics_fluid_vortex_matrix_to_string(m : PhysicsfluidvortexMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + @_common.dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct PhysicsfluidvortexVector {
  comps : Array[Double]
  dim : Int
}

pub fn physics_fluid_vortex_make_vector(comps : Array[Double]) -> PhysicsfluidvortexVector {
  { comps, dim: comps.length() }
}

pub fn physics_fluid_vortex_vector_zero(dim : Int) -> PhysicsfluidvortexVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn physics_fluid_vortex_vector_add(a : PhysicsfluidvortexVector, b : PhysicsfluidvortexVector) -> PhysicsfluidvortexVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn physics_fluid_vortex_vector_sub(a : PhysicsfluidvortexVector, b : PhysicsfluidvortexVector) -> PhysicsfluidvortexVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn physics_fluid_vortex_vector_scale(v : PhysicsfluidvortexVector, s : Double) -> PhysicsfluidvortexVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn physics_fluid_vortex_vector_dot(a : PhysicsfluidvortexVector, b : PhysicsfluidvortexVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn physics_fluid_vortex_vector_norm(v : PhysicsfluidvortexVector) -> Double { @_common.sqrt(physics_fluid_vortex_vector_dot(v, v)) }

pub fn physics_fluid_vortex_vector_normalize(v : PhysicsfluidvortexVector) -> PhysicsfluidvortexVector {
  let n = physics_fluid_vortex_vector_norm(v)
  if n < 0.0000001 { v } else { physics_fluid_vortex_vector_scale(v, 1.0 / n) }
}

pub fn physics_fluid_vortex_vector_dist(a : PhysicsfluidvortexVector, b : PhysicsfluidvortexVector) -> Double {
  physics_fluid_vortex_vector_norm(physics_fluid_vortex_vector_sub(a, b))
}

pub fn physics_fluid_vortex_vector_to_string(v : PhysicsfluidvortexVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn physics_fluid_vortex_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn physics_fluid_vortex_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = physics_fluid_vortex_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn physics_fluid_vortex_std(data : Array[Double]) -> Double { @_common.sqrt(physics_fluid_vortex_var(data)) }

pub fn physics_fluid_vortex_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = physics_fluid_vortex_mean(a); let mb = physics_fluid_vortex_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn physics_fluid_vortex_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = physics_fluid_vortex_std(a); let sb = physics_fluid_vortex_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { physics_fluid_vortex_cov(a, b) / (sa * sb) }
}

pub fn physics_fluid_vortex_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = physics_fluid_vortex_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn physics_fluid_vortex_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn physics_fluid_vortex_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn physics_fluid_vortex_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  @_common.sqrt(physics_fluid_vortex_mse(pred, labels))
}

pub fn physics_fluid_vortex_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn physics_fluid_vortex_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = physics_fluid_vortex_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn physics_fluid_vortex_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn physics_fluid_vortex_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn physics_fluid_vortex_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = physics_fluid_vortex_precision(pred, labels, pos); let r = physics_fluid_vortex_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn physics_fluid_vortex_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn physics_fluid_vortex_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = physics_fluid_vortex_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn physics_fluid_vortex_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn physics_fluid_vortex_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn physics_fluid_vortex_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = physics_fluid_vortex_gcd(a, b)
    (a / g) * b
  }
}

pub fn physics_fluid_vortex_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn physics_fluid_vortex_fibonacci(n : Int) -> Int {
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

pub fn physics_fluid_vortex_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = physics_fluid_vortex_min(data); let mx = physics_fluid_vortex_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn physics_fluid_vortex_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = physics_fluid_vortex_mean(data); let sd = physics_fluid_vortex_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn physics_fluid_vortex_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn physics_fluid_vortex_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn physics_fluid_vortex_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn physics_fluid_vortex_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn physics_fluid_vortex_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn physics_fluid_vortex_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

pub(all) struct PhysicsfluidvortexFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_vortex_frame_make(size : Int) -> PhysicsfluidvortexFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_vortex_frame_len(s : PhysicsfluidvortexFrame) -> Int { s.size }

pub fn physics_fluid_vortex_frame_get(s : PhysicsfluidvortexFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_vortex_frame_set(s : PhysicsfluidvortexFrame, i : Int, v : Double) -> PhysicsfluidvortexFrame {
  let result = physics_fluid_vortex_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_vortex_frame_sum(s : PhysicsfluidvortexFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_fluid_vortex_frame_mean(s : PhysicsfluidvortexFrame) -> Double {
  if s.size == 0 { 0.0 } else { physics_fluid_vortex_frame_sum(s) / s.size.to_double() }
}

pub fn physics_fluid_vortex_frame_scale(s : PhysicsfluidvortexFrame, f : Double) -> PhysicsfluidvortexFrame {
  let result = physics_fluid_vortex_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_fluid_vortex_frame_add(a : PhysicsfluidvortexFrame, b : PhysicsfluidvortexFrame) -> PhysicsfluidvortexFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_fluid_vortex_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_fluid_vortex_frame_copy(s : PhysicsfluidvortexFrame) -> PhysicsfluidvortexFrame {
  let result = physics_fluid_vortex_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_fluid_vortex_frame_fill(s : PhysicsfluidvortexFrame, v : Double) -> PhysicsfluidvortexFrame {
  let result = physics_fluid_vortex_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_vortex_frame_min(s : PhysicsfluidvortexFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_vortex_frame_max(s : PhysicsfluidvortexFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_vortex_frame_to_string(s : PhysicsfluidvortexFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidvortexTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_vortex_table_make(size : Int) -> PhysicsfluidvortexTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_vortex_table_len(s : PhysicsfluidvortexTable) -> Int { s.size }

pub fn physics_fluid_vortex_table_get(s : PhysicsfluidvortexTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_vortex_table_set(s : PhysicsfluidvortexTable, i : Int, v : Double) -> PhysicsfluidvortexTable {
  let result = physics_fluid_vortex_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_vortex_table_sum(s : PhysicsfluidvortexTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_fluid_vortex_table_mean(s : PhysicsfluidvortexTable) -> Double {
  if s.size == 0 { 0.0 } else { physics_fluid_vortex_table_sum(s) / s.size.to_double() }
}

pub fn physics_fluid_vortex_table_scale(s : PhysicsfluidvortexTable, f : Double) -> PhysicsfluidvortexTable {
  let result = physics_fluid_vortex_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_fluid_vortex_table_add(a : PhysicsfluidvortexTable, b : PhysicsfluidvortexTable) -> PhysicsfluidvortexTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_fluid_vortex_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_fluid_vortex_table_copy(s : PhysicsfluidvortexTable) -> PhysicsfluidvortexTable {
  let result = physics_fluid_vortex_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_fluid_vortex_table_fill(s : PhysicsfluidvortexTable, v : Double) -> PhysicsfluidvortexTable {
  let result = physics_fluid_vortex_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_vortex_table_min(s : PhysicsfluidvortexTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_vortex_table_max(s : PhysicsfluidvortexTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_vortex_table_to_string(s : PhysicsfluidvortexTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidvortexGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_vortex_graphn_make(size : Int) -> PhysicsfluidvortexGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_vortex_graphn_len(s : PhysicsfluidvortexGraphN) -> Int { s.size }

pub fn physics_fluid_vortex_graphn_get(s : PhysicsfluidvortexGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_vortex_graphn_set(s : PhysicsfluidvortexGraphN, i : Int, v : Double) -> PhysicsfluidvortexGraphN {
  let result = physics_fluid_vortex_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_vortex_graphn_sum(s : PhysicsfluidvortexGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_fluid_vortex_graphn_mean(s : PhysicsfluidvortexGraphN) -> Double {
  if s.size == 0 { 0.0 } else { physics_fluid_vortex_graphn_sum(s) / s.size.to_double() }
}

pub fn physics_fluid_vortex_graphn_scale(s : PhysicsfluidvortexGraphN, f : Double) -> PhysicsfluidvortexGraphN {
  let result = physics_fluid_vortex_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_fluid_vortex_graphn_add(a : PhysicsfluidvortexGraphN, b : PhysicsfluidvortexGraphN) -> PhysicsfluidvortexGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_fluid_vortex_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_fluid_vortex_graphn_copy(s : PhysicsfluidvortexGraphN) -> PhysicsfluidvortexGraphN {
  let result = physics_fluid_vortex_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_fluid_vortex_graphn_fill(s : PhysicsfluidvortexGraphN, v : Double) -> PhysicsfluidvortexGraphN {
  let result = physics_fluid_vortex_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_vortex_graphn_min(s : PhysicsfluidvortexGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_vortex_graphn_max(s : PhysicsfluidvortexGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_vortex_graphn_to_string(s : PhysicsfluidvortexGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidvortexNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_vortex_node_make(size : Int) -> PhysicsfluidvortexNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_vortex_node_len(s : PhysicsfluidvortexNode) -> Int { s.size }

pub fn physics_fluid_vortex_node_get(s : PhysicsfluidvortexNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_vortex_node_set(s : PhysicsfluidvortexNode, i : Int, v : Double) -> PhysicsfluidvortexNode {
  let result = physics_fluid_vortex_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_vortex_node_sum(s : PhysicsfluidvortexNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_fluid_vortex_node_mean(s : PhysicsfluidvortexNode) -> Double {
  if s.size == 0 { 0.0 } else { physics_fluid_vortex_node_sum(s) / s.size.to_double() }
}

pub fn physics_fluid_vortex_node_scale(s : PhysicsfluidvortexNode, f : Double) -> PhysicsfluidvortexNode {
  let result = physics_fluid_vortex_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_fluid_vortex_node_add(a : PhysicsfluidvortexNode, b : PhysicsfluidvortexNode) -> PhysicsfluidvortexNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_fluid_vortex_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_fluid_vortex_node_copy(s : PhysicsfluidvortexNode) -> PhysicsfluidvortexNode {
  let result = physics_fluid_vortex_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_fluid_vortex_node_fill(s : PhysicsfluidvortexNode, v : Double) -> PhysicsfluidvortexNode {
  let result = physics_fluid_vortex_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_vortex_node_min(s : PhysicsfluidvortexNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_vortex_node_max(s : PhysicsfluidvortexNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_vortex_node_to_string(s : PhysicsfluidvortexNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidvortexEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_vortex_edge_make(size : Int) -> PhysicsfluidvortexEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_vortex_edge_len(s : PhysicsfluidvortexEdge) -> Int { s.size }

pub fn physics_fluid_vortex_edge_get(s : PhysicsfluidvortexEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_vortex_edge_set(s : PhysicsfluidvortexEdge, i : Int, v : Double) -> PhysicsfluidvortexEdge {
  let result = physics_fluid_vortex_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_vortex_edge_sum(s : PhysicsfluidvortexEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_fluid_vortex_edge_mean(s : PhysicsfluidvortexEdge) -> Double {
  if s.size == 0 { 0.0 } else { physics_fluid_vortex_edge_sum(s) / s.size.to_double() }
}

pub fn physics_fluid_vortex_edge_scale(s : PhysicsfluidvortexEdge, f : Double) -> PhysicsfluidvortexEdge {
  let result = physics_fluid_vortex_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_fluid_vortex_edge_add(a : PhysicsfluidvortexEdge, b : PhysicsfluidvortexEdge) -> PhysicsfluidvortexEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_fluid_vortex_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_fluid_vortex_edge_copy(s : PhysicsfluidvortexEdge) -> PhysicsfluidvortexEdge {
  let result = physics_fluid_vortex_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_fluid_vortex_edge_fill(s : PhysicsfluidvortexEdge, v : Double) -> PhysicsfluidvortexEdge {
  let result = physics_fluid_vortex_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_vortex_edge_min(s : PhysicsfluidvortexEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_vortex_edge_max(s : PhysicsfluidvortexEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_vortex_edge_to_string(s : PhysicsfluidvortexEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidvortexPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_vortex_path_make(size : Int) -> PhysicsfluidvortexPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_vortex_path_len(s : PhysicsfluidvortexPath) -> Int { s.size }

pub fn physics_fluid_vortex_path_get(s : PhysicsfluidvortexPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_vortex_path_set(s : PhysicsfluidvortexPath, i : Int, v : Double) -> PhysicsfluidvortexPath {
  let result = physics_fluid_vortex_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_vortex_path_sum(s : PhysicsfluidvortexPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_fluid_vortex_path_mean(s : PhysicsfluidvortexPath) -> Double {
  if s.size == 0 { 0.0 } else { physics_fluid_vortex_path_sum(s) / s.size.to_double() }
}

pub fn physics_fluid_vortex_path_scale(s : PhysicsfluidvortexPath, f : Double) -> PhysicsfluidvortexPath {
  let result = physics_fluid_vortex_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_fluid_vortex_path_add(a : PhysicsfluidvortexPath, b : PhysicsfluidvortexPath) -> PhysicsfluidvortexPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_fluid_vortex_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_fluid_vortex_path_copy(s : PhysicsfluidvortexPath) -> PhysicsfluidvortexPath {
  let result = physics_fluid_vortex_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_fluid_vortex_path_fill(s : PhysicsfluidvortexPath, v : Double) -> PhysicsfluidvortexPath {
  let result = physics_fluid_vortex_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_vortex_path_min(s : PhysicsfluidvortexPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_vortex_path_max(s : PhysicsfluidvortexPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_vortex_path_to_string(s : PhysicsfluidvortexPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidvortexCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_vortex_cluster_make(size : Int) -> PhysicsfluidvortexCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_vortex_cluster_len(s : PhysicsfluidvortexCluster) -> Int { s.size }

pub fn physics_fluid_vortex_cluster_get(s : PhysicsfluidvortexCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_vortex_cluster_set(s : PhysicsfluidvortexCluster, i : Int, v : Double) -> PhysicsfluidvortexCluster {
  let result = physics_fluid_vortex_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_vortex_cluster_sum(s : PhysicsfluidvortexCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_fluid_vortex_cluster_mean(s : PhysicsfluidvortexCluster) -> Double {
  if s.size == 0 { 0.0 } else { physics_fluid_vortex_cluster_sum(s) / s.size.to_double() }
}

pub fn physics_fluid_vortex_cluster_scale(s : PhysicsfluidvortexCluster, f : Double) -> PhysicsfluidvortexCluster {
  let result = physics_fluid_vortex_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_fluid_vortex_cluster_add(a : PhysicsfluidvortexCluster, b : PhysicsfluidvortexCluster) -> PhysicsfluidvortexCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_fluid_vortex_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_fluid_vortex_cluster_copy(s : PhysicsfluidvortexCluster) -> PhysicsfluidvortexCluster {
  let result = physics_fluid_vortex_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_fluid_vortex_cluster_fill(s : PhysicsfluidvortexCluster, v : Double) -> PhysicsfluidvortexCluster {
  let result = physics_fluid_vortex_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_vortex_cluster_min(s : PhysicsfluidvortexCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_vortex_cluster_max(s : PhysicsfluidvortexCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_vortex_cluster_to_string(s : PhysicsfluidvortexCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidvortexModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_vortex_model_make(size : Int) -> PhysicsfluidvortexModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_vortex_model_len(s : PhysicsfluidvortexModel) -> Int { s.size }

pub fn physics_fluid_vortex_model_get(s : PhysicsfluidvortexModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_vortex_model_set(s : PhysicsfluidvortexModel, i : Int, v : Double) -> PhysicsfluidvortexModel {
  let result = physics_fluid_vortex_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_vortex_model_sum(s : PhysicsfluidvortexModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_fluid_vortex_model_mean(s : PhysicsfluidvortexModel) -> Double {
  if s.size == 0 { 0.0 } else { physics_fluid_vortex_model_sum(s) / s.size.to_double() }
}

pub fn physics_fluid_vortex_model_scale(s : PhysicsfluidvortexModel, f : Double) -> PhysicsfluidvortexModel {
  let result = physics_fluid_vortex_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_fluid_vortex_model_add(a : PhysicsfluidvortexModel, b : PhysicsfluidvortexModel) -> PhysicsfluidvortexModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_fluid_vortex_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_fluid_vortex_model_copy(s : PhysicsfluidvortexModel) -> PhysicsfluidvortexModel {
  let result = physics_fluid_vortex_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_fluid_vortex_model_fill(s : PhysicsfluidvortexModel, v : Double) -> PhysicsfluidvortexModel {
  let result = physics_fluid_vortex_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_vortex_model_min(s : PhysicsfluidvortexModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_vortex_model_max(s : PhysicsfluidvortexModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_vortex_model_to_string(s : PhysicsfluidvortexModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidvortexLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_vortex_layer_make(size : Int) -> PhysicsfluidvortexLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_vortex_layer_len(s : PhysicsfluidvortexLayer) -> Int { s.size }

pub fn physics_fluid_vortex_layer_get(s : PhysicsfluidvortexLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_vortex_layer_set(s : PhysicsfluidvortexLayer, i : Int, v : Double) -> PhysicsfluidvortexLayer {
  let result = physics_fluid_vortex_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_vortex_layer_sum(s : PhysicsfluidvortexLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_fluid_vortex_layer_mean(s : PhysicsfluidvortexLayer) -> Double {
  if s.size == 0 { 0.0 } else { physics_fluid_vortex_layer_sum(s) / s.size.to_double() }
}

pub fn physics_fluid_vortex_layer_scale(s : PhysicsfluidvortexLayer, f : Double) -> PhysicsfluidvortexLayer {
  let result = physics_fluid_vortex_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_fluid_vortex_layer_add(a : PhysicsfluidvortexLayer, b : PhysicsfluidvortexLayer) -> PhysicsfluidvortexLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_fluid_vortex_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_fluid_vortex_layer_copy(s : PhysicsfluidvortexLayer) -> PhysicsfluidvortexLayer {
  let result = physics_fluid_vortex_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_fluid_vortex_layer_fill(s : PhysicsfluidvortexLayer, v : Double) -> PhysicsfluidvortexLayer {
  let result = physics_fluid_vortex_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_vortex_layer_min(s : PhysicsfluidvortexLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_vortex_layer_max(s : PhysicsfluidvortexLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_vortex_layer_to_string(s : PhysicsfluidvortexLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidvortexBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_vortex_buffer_make(size : Int) -> PhysicsfluidvortexBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_vortex_buffer_len(s : PhysicsfluidvortexBuffer) -> Int { s.size }

pub fn physics_fluid_vortex_buffer_get(s : PhysicsfluidvortexBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_vortex_buffer_set(s : PhysicsfluidvortexBuffer, i : Int, v : Double) -> PhysicsfluidvortexBuffer {
  let result = physics_fluid_vortex_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_vortex_buffer_sum(s : PhysicsfluidvortexBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_fluid_vortex_buffer_mean(s : PhysicsfluidvortexBuffer) -> Double {
  if s.size == 0 { 0.0 } else { physics_fluid_vortex_buffer_sum(s) / s.size.to_double() }
}

pub fn physics_fluid_vortex_buffer_scale(s : PhysicsfluidvortexBuffer, f : Double) -> PhysicsfluidvortexBuffer {
  let result = physics_fluid_vortex_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_fluid_vortex_buffer_add(a : PhysicsfluidvortexBuffer, b : PhysicsfluidvortexBuffer) -> PhysicsfluidvortexBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_fluid_vortex_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_fluid_vortex_buffer_copy(s : PhysicsfluidvortexBuffer) -> PhysicsfluidvortexBuffer {
  let result = physics_fluid_vortex_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_fluid_vortex_buffer_fill(s : PhysicsfluidvortexBuffer, v : Double) -> PhysicsfluidvortexBuffer {
  let result = physics_fluid_vortex_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_vortex_buffer_min(s : PhysicsfluidvortexBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_vortex_buffer_max(s : PhysicsfluidvortexBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_vortex_buffer_to_string(s : PhysicsfluidvortexBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidvortexCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_vortex_cursor_make(size : Int) -> PhysicsfluidvortexCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_vortex_cursor_len(s : PhysicsfluidvortexCursor) -> Int { s.size }

pub fn physics_fluid_vortex_cursor_get(s : PhysicsfluidvortexCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_vortex_cursor_set(s : PhysicsfluidvortexCursor, i : Int, v : Double) -> PhysicsfluidvortexCursor {
  let result = physics_fluid_vortex_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_vortex_cursor_sum(s : PhysicsfluidvortexCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_fluid_vortex_cursor_mean(s : PhysicsfluidvortexCursor) -> Double {
  if s.size == 0 { 0.0 } else { physics_fluid_vortex_cursor_sum(s) / s.size.to_double() }
}

pub fn physics_fluid_vortex_cursor_scale(s : PhysicsfluidvortexCursor, f : Double) -> PhysicsfluidvortexCursor {
  let result = physics_fluid_vortex_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_fluid_vortex_cursor_add(a : PhysicsfluidvortexCursor, b : PhysicsfluidvortexCursor) -> PhysicsfluidvortexCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_fluid_vortex_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_fluid_vortex_cursor_copy(s : PhysicsfluidvortexCursor) -> PhysicsfluidvortexCursor {
  let result = physics_fluid_vortex_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_fluid_vortex_cursor_fill(s : PhysicsfluidvortexCursor, v : Double) -> PhysicsfluidvortexCursor {
  let result = physics_fluid_vortex_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_vortex_cursor_min(s : PhysicsfluidvortexCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_vortex_cursor_max(s : PhysicsfluidvortexCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_vortex_cursor_to_string(s : PhysicsfluidvortexCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidvortexView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_vortex_view_make(size : Int) -> PhysicsfluidvortexView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_vortex_view_len(s : PhysicsfluidvortexView) -> Int { s.size }

pub fn physics_fluid_vortex_view_get(s : PhysicsfluidvortexView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_vortex_view_set(s : PhysicsfluidvortexView, i : Int, v : Double) -> PhysicsfluidvortexView {
  let result = physics_fluid_vortex_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_vortex_view_sum(s : PhysicsfluidvortexView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_fluid_vortex_view_mean(s : PhysicsfluidvortexView) -> Double {
  if s.size == 0 { 0.0 } else { physics_fluid_vortex_view_sum(s) / s.size.to_double() }
}

pub fn physics_fluid_vortex_view_scale(s : PhysicsfluidvortexView, f : Double) -> PhysicsfluidvortexView {
  let result = physics_fluid_vortex_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_fluid_vortex_view_add(a : PhysicsfluidvortexView, b : PhysicsfluidvortexView) -> PhysicsfluidvortexView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_fluid_vortex_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_fluid_vortex_view_copy(s : PhysicsfluidvortexView) -> PhysicsfluidvortexView {
  let result = physics_fluid_vortex_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_fluid_vortex_view_fill(s : PhysicsfluidvortexView, v : Double) -> PhysicsfluidvortexView {
  let result = physics_fluid_vortex_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_vortex_view_min(s : PhysicsfluidvortexView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_vortex_view_max(s : PhysicsfluidvortexView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_vortex_view_to_string(s : PhysicsfluidvortexView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidvortexRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_vortex_range_make(size : Int) -> PhysicsfluidvortexRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_vortex_range_len(s : PhysicsfluidvortexRange) -> Int { s.size }

pub fn physics_fluid_vortex_range_get(s : PhysicsfluidvortexRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_vortex_range_set(s : PhysicsfluidvortexRange, i : Int, v : Double) -> PhysicsfluidvortexRange {
  let result = physics_fluid_vortex_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_vortex_range_sum(s : PhysicsfluidvortexRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_fluid_vortex_range_mean(s : PhysicsfluidvortexRange) -> Double {
  if s.size == 0 { 0.0 } else { physics_fluid_vortex_range_sum(s) / s.size.to_double() }
}

pub fn physics_fluid_vortex_range_scale(s : PhysicsfluidvortexRange, f : Double) -> PhysicsfluidvortexRange {
  let result = physics_fluid_vortex_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_fluid_vortex_range_add(a : PhysicsfluidvortexRange, b : PhysicsfluidvortexRange) -> PhysicsfluidvortexRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_fluid_vortex_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_fluid_vortex_range_copy(s : PhysicsfluidvortexRange) -> PhysicsfluidvortexRange {
  let result = physics_fluid_vortex_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_fluid_vortex_range_fill(s : PhysicsfluidvortexRange, v : Double) -> PhysicsfluidvortexRange {
  let result = physics_fluid_vortex_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_vortex_range_min(s : PhysicsfluidvortexRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_vortex_range_max(s : PhysicsfluidvortexRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_vortex_range_to_string(s : PhysicsfluidvortexRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidvortexSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_vortex_slice_make(size : Int) -> PhysicsfluidvortexSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_vortex_slice_len(s : PhysicsfluidvortexSlice) -> Int { s.size }

pub fn physics_fluid_vortex_slice_get(s : PhysicsfluidvortexSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_vortex_slice_set(s : PhysicsfluidvortexSlice, i : Int, v : Double) -> PhysicsfluidvortexSlice {
  let result = physics_fluid_vortex_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_vortex_slice_sum(s : PhysicsfluidvortexSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_fluid_vortex_slice_mean(s : PhysicsfluidvortexSlice) -> Double {
  if s.size == 0 { 0.0 } else { physics_fluid_vortex_slice_sum(s) / s.size.to_double() }
}

pub fn physics_fluid_vortex_slice_scale(s : PhysicsfluidvortexSlice, f : Double) -> PhysicsfluidvortexSlice {
  let result = physics_fluid_vortex_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_fluid_vortex_slice_add(a : PhysicsfluidvortexSlice, b : PhysicsfluidvortexSlice) -> PhysicsfluidvortexSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_fluid_vortex_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_fluid_vortex_slice_copy(s : PhysicsfluidvortexSlice) -> PhysicsfluidvortexSlice {
  let result = physics_fluid_vortex_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_fluid_vortex_slice_fill(s : PhysicsfluidvortexSlice, v : Double) -> PhysicsfluidvortexSlice {
  let result = physics_fluid_vortex_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_vortex_slice_min(s : PhysicsfluidvortexSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_vortex_slice_max(s : PhysicsfluidvortexSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_vortex_slice_to_string(s : PhysicsfluidvortexSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

