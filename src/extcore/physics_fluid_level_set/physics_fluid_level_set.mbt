///===
/// extcore/physics_fluid_level_set

pub(all) struct PhysicsfluidlevelsetPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn physics_fluid_level_set_make_point(x : Double, y : Double) -> PhysicsfluidlevelsetPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn physics_fluid_level_set_make_point3(x : Double, y : Double, z : Double) -> PhysicsfluidlevelsetPoint {
  { x, y, z, label: 0 }
}

pub fn physics_fluid_level_set_point_x(pt : PhysicsfluidlevelsetPoint) -> Double { pt.x }

pub fn physics_fluid_level_set_point_y(pt : PhysicsfluidlevelsetPoint) -> Double { pt.y }

pub fn physics_fluid_level_set_point_z(pt : PhysicsfluidlevelsetPoint) -> Double { pt.z }

pub fn physics_fluid_level_set_point_label(pt : PhysicsfluidlevelsetPoint) -> Int { pt.label }

pub fn physics_fluid_level_set_point_dist(a : PhysicsfluidlevelsetPoint, b : PhysicsfluidlevelsetPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn physics_fluid_level_set_point_add(a : PhysicsfluidlevelsetPoint, b : PhysicsfluidlevelsetPoint) -> PhysicsfluidlevelsetPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn physics_fluid_level_set_point_sub(a : PhysicsfluidlevelsetPoint, b : PhysicsfluidlevelsetPoint) -> PhysicsfluidlevelsetPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn physics_fluid_level_set_point_scale(pt : PhysicsfluidlevelsetPoint, s : Double) -> PhysicsfluidlevelsetPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn physics_fluid_level_set_point_dot(a : PhysicsfluidlevelsetPoint, b : PhysicsfluidlevelsetPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn physics_fluid_level_set_point_cross(a : PhysicsfluidlevelsetPoint, b : PhysicsfluidlevelsetPoint) -> PhysicsfluidlevelsetPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn physics_fluid_level_set_point_norm(pt : PhysicsfluidlevelsetPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn physics_fluid_level_set_point_normalize(pt : PhysicsfluidlevelsetPoint) -> PhysicsfluidlevelsetPoint {
  let n = physics_fluid_level_set_point_norm(pt)
  if n < 0.0000001 { pt } else { physics_fluid_level_set_point_scale(pt, 1.0 / n) }
}

pub fn physics_fluid_level_set_point_negate(pt : PhysicsfluidlevelsetPoint) -> PhysicsfluidlevelsetPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn physics_fluid_level_set_point_mid(a : PhysicsfluidlevelsetPoint, b : PhysicsfluidlevelsetPoint) -> PhysicsfluidlevelsetPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn physics_fluid_level_set_point_lerp(a : PhysicsfluidlevelsetPoint, b : PhysicsfluidlevelsetPoint, t : Double) -> PhysicsfluidlevelsetPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn physics_fluid_level_set_point_to_string(pt : PhysicsfluidlevelsetPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct PhysicsfluidlevelsetSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn physics_fluid_level_set_make_series(vals : Array[Double], name : String) -> PhysicsfluidlevelsetSeries {
  { vals, name, meta: 0 }
}

pub fn physics_fluid_level_set_series_len(s : PhysicsfluidlevelsetSeries) -> Int { s.vals.length() }

pub fn physics_fluid_level_set_series_sum(s : PhysicsfluidlevelsetSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn physics_fluid_level_set_series_mean(s : PhysicsfluidlevelsetSeries) -> Double {
  let n = physics_fluid_level_set_series_len(s)
  if n == 0 { 0.0 } else { physics_fluid_level_set_series_sum(s) / n.to_double() }
}

pub fn physics_fluid_level_set_series_min(s : PhysicsfluidlevelsetSeries) -> Double {
  let n = physics_fluid_level_set_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn physics_fluid_level_set_series_max(s : PhysicsfluidlevelsetSeries) -> Double {
  let n = physics_fluid_level_set_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn physics_fluid_level_set_series_range(s : PhysicsfluidlevelsetSeries) -> Double {
  physics_fluid_level_set_series_max(s) - physics_fluid_level_set_series_min(s)
}

pub fn physics_fluid_level_set_series_var(s : PhysicsfluidlevelsetSeries) -> Double {
  let n = physics_fluid_level_set_series_len(s)
  if n == 0 { 0.0 } else {
    let m = physics_fluid_level_set_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn physics_fluid_level_set_series_std(s : PhysicsfluidlevelsetSeries) -> Double { @_common.sqrt(physics_fluid_level_set_series_var(s)) }

pub fn physics_fluid_level_set_series_median(s : PhysicsfluidlevelsetSeries) -> Double {
  let n = physics_fluid_level_set_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = physics_fluid_level_set_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn physics_fluid_level_set_series_scale(s : PhysicsfluidlevelsetSeries, f : Double) -> PhysicsfluidlevelsetSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn physics_fluid_level_set_series_add(a : PhysicsfluidlevelsetSeries, b : PhysicsfluidlevelsetSeries) -> PhysicsfluidlevelsetSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn physics_fluid_level_set_series_sub(a : PhysicsfluidlevelsetSeries, b : PhysicsfluidlevelsetSeries) -> PhysicsfluidlevelsetSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn physics_fluid_level_set_series_normalize(s : PhysicsfluidlevelsetSeries) -> PhysicsfluidlevelsetSeries {
  let mn = physics_fluid_level_set_series_min(s)
  let mx = physics_fluid_level_set_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn physics_fluid_level_set_series_cumsum(s : PhysicsfluidlevelsetSeries) -> PhysicsfluidlevelsetSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn physics_fluid_level_set_series_to_string(s : PhysicsfluidlevelsetSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct PhysicsfluidlevelsetMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn physics_fluid_level_set_make_matrix(rows : Int, cols : Int, val : Double) -> PhysicsfluidlevelsetMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn physics_fluid_level_set_matrix_identity(n : Int) -> PhysicsfluidlevelsetMatrix {
  let m = physics_fluid_level_set_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn physics_fluid_level_set_matrix_get(m : PhysicsfluidlevelsetMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn physics_fluid_level_set_matrix_transpose(m : PhysicsfluidlevelsetMatrix) -> PhysicsfluidlevelsetMatrix {
  let result = physics_fluid_level_set_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn physics_fluid_level_set_matrix_add(a : PhysicsfluidlevelsetMatrix, b : PhysicsfluidlevelsetMatrix) -> PhysicsfluidlevelsetMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = physics_fluid_level_set_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn physics_fluid_level_set_matrix_scale(m : PhysicsfluidlevelsetMatrix, s : Double) -> PhysicsfluidlevelsetMatrix {
  let result = physics_fluid_level_set_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn physics_fluid_level_set_matrix_multiply(a : PhysicsfluidlevelsetMatrix, b : PhysicsfluidlevelsetMatrix) -> PhysicsfluidlevelsetMatrix {
  if a.cols != b.rows { return physics_fluid_level_set_make_matrix(a.rows, b.cols, 0.0) }
  let result = physics_fluid_level_set_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn physics_fluid_level_set_matrix_trace(m : PhysicsfluidlevelsetMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn physics_fluid_level_set_matrix_det(m : PhysicsfluidlevelsetMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn physics_fluid_level_set_matrix_norm(m : PhysicsfluidlevelsetMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn physics_fluid_level_set_matrix_to_string(m : PhysicsfluidlevelsetMatrix) -> String {
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

pub(all) struct PhysicsfluidlevelsetVector {
  comps : Array[Double]
  dim : Int
}

pub fn physics_fluid_level_set_make_vector(comps : Array[Double]) -> PhysicsfluidlevelsetVector {
  { comps, dim: comps.length() }
}

pub fn physics_fluid_level_set_vector_zero(dim : Int) -> PhysicsfluidlevelsetVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn physics_fluid_level_set_vector_add(a : PhysicsfluidlevelsetVector, b : PhysicsfluidlevelsetVector) -> PhysicsfluidlevelsetVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn physics_fluid_level_set_vector_sub(a : PhysicsfluidlevelsetVector, b : PhysicsfluidlevelsetVector) -> PhysicsfluidlevelsetVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn physics_fluid_level_set_vector_scale(v : PhysicsfluidlevelsetVector, s : Double) -> PhysicsfluidlevelsetVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn physics_fluid_level_set_vector_dot(a : PhysicsfluidlevelsetVector, b : PhysicsfluidlevelsetVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn physics_fluid_level_set_vector_norm(v : PhysicsfluidlevelsetVector) -> Double { @_common.sqrt(physics_fluid_level_set_vector_dot(v, v)) }

pub fn physics_fluid_level_set_vector_normalize(v : PhysicsfluidlevelsetVector) -> PhysicsfluidlevelsetVector {
  let n = physics_fluid_level_set_vector_norm(v)
  if n < 0.0000001 { v } else { physics_fluid_level_set_vector_scale(v, 1.0 / n) }
}

pub fn physics_fluid_level_set_vector_dist(a : PhysicsfluidlevelsetVector, b : PhysicsfluidlevelsetVector) -> Double {
  physics_fluid_level_set_vector_norm(physics_fluid_level_set_vector_sub(a, b))
}

pub fn physics_fluid_level_set_vector_to_string(v : PhysicsfluidlevelsetVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn physics_fluid_level_set_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn physics_fluid_level_set_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = physics_fluid_level_set_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn physics_fluid_level_set_std(data : Array[Double]) -> Double { @_common.sqrt(physics_fluid_level_set_var(data)) }

pub fn physics_fluid_level_set_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = physics_fluid_level_set_mean(a); let mb = physics_fluid_level_set_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn physics_fluid_level_set_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = physics_fluid_level_set_std(a); let sb = physics_fluid_level_set_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { physics_fluid_level_set_cov(a, b) / (sa * sb) }
}

pub fn physics_fluid_level_set_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = physics_fluid_level_set_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn physics_fluid_level_set_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn physics_fluid_level_set_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn physics_fluid_level_set_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  @_common.sqrt(physics_fluid_level_set_mse(pred, labels))
}

pub fn physics_fluid_level_set_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn physics_fluid_level_set_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = physics_fluid_level_set_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn physics_fluid_level_set_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn physics_fluid_level_set_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn physics_fluid_level_set_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = physics_fluid_level_set_precision(pred, labels, pos); let r = physics_fluid_level_set_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn physics_fluid_level_set_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn physics_fluid_level_set_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = physics_fluid_level_set_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn physics_fluid_level_set_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn physics_fluid_level_set_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn physics_fluid_level_set_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = physics_fluid_level_set_gcd(a, b)
    (a / g) * b
  }
}

pub fn physics_fluid_level_set_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn physics_fluid_level_set_fibonacci(n : Int) -> Int {
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

pub fn physics_fluid_level_set_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = physics_fluid_level_set_min(data); let mx = physics_fluid_level_set_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn physics_fluid_level_set_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = physics_fluid_level_set_mean(data); let sd = physics_fluid_level_set_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn physics_fluid_level_set_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn physics_fluid_level_set_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn physics_fluid_level_set_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn physics_fluid_level_set_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn physics_fluid_level_set_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn physics_fluid_level_set_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

pub(all) struct PhysicsfluidlevelsetFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_level_set_frame_make(size : Int) -> PhysicsfluidlevelsetFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_level_set_frame_len(s : PhysicsfluidlevelsetFrame) -> Int { s.size }

pub fn physics_fluid_level_set_frame_get(s : PhysicsfluidlevelsetFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_level_set_frame_set(s : PhysicsfluidlevelsetFrame, i : Int, v : Double) -> PhysicsfluidlevelsetFrame {
  let result = physics_fluid_level_set_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_level_set_frame_sum(s : PhysicsfluidlevelsetFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_fluid_level_set_frame_mean(s : PhysicsfluidlevelsetFrame) -> Double {
  if s.size == 0 { 0.0 } else { physics_fluid_level_set_frame_sum(s) / s.size.to_double() }
}

pub fn physics_fluid_level_set_frame_scale(s : PhysicsfluidlevelsetFrame, f : Double) -> PhysicsfluidlevelsetFrame {
  let result = physics_fluid_level_set_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_fluid_level_set_frame_add(a : PhysicsfluidlevelsetFrame, b : PhysicsfluidlevelsetFrame) -> PhysicsfluidlevelsetFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_fluid_level_set_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_fluid_level_set_frame_copy(s : PhysicsfluidlevelsetFrame) -> PhysicsfluidlevelsetFrame {
  let result = physics_fluid_level_set_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_fluid_level_set_frame_fill(s : PhysicsfluidlevelsetFrame, v : Double) -> PhysicsfluidlevelsetFrame {
  let result = physics_fluid_level_set_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_level_set_frame_min(s : PhysicsfluidlevelsetFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_level_set_frame_max(s : PhysicsfluidlevelsetFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_level_set_frame_to_string(s : PhysicsfluidlevelsetFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidlevelsetTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_level_set_table_make(size : Int) -> PhysicsfluidlevelsetTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_level_set_table_len(s : PhysicsfluidlevelsetTable) -> Int { s.size }

pub fn physics_fluid_level_set_table_get(s : PhysicsfluidlevelsetTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_level_set_table_set(s : PhysicsfluidlevelsetTable, i : Int, v : Double) -> PhysicsfluidlevelsetTable {
  let result = physics_fluid_level_set_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_level_set_table_sum(s : PhysicsfluidlevelsetTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_fluid_level_set_table_mean(s : PhysicsfluidlevelsetTable) -> Double {
  if s.size == 0 { 0.0 } else { physics_fluid_level_set_table_sum(s) / s.size.to_double() }
}

pub fn physics_fluid_level_set_table_scale(s : PhysicsfluidlevelsetTable, f : Double) -> PhysicsfluidlevelsetTable {
  let result = physics_fluid_level_set_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_fluid_level_set_table_add(a : PhysicsfluidlevelsetTable, b : PhysicsfluidlevelsetTable) -> PhysicsfluidlevelsetTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_fluid_level_set_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_fluid_level_set_table_copy(s : PhysicsfluidlevelsetTable) -> PhysicsfluidlevelsetTable {
  let result = physics_fluid_level_set_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_fluid_level_set_table_fill(s : PhysicsfluidlevelsetTable, v : Double) -> PhysicsfluidlevelsetTable {
  let result = physics_fluid_level_set_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_level_set_table_min(s : PhysicsfluidlevelsetTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_level_set_table_max(s : PhysicsfluidlevelsetTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_level_set_table_to_string(s : PhysicsfluidlevelsetTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidlevelsetGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_level_set_graphn_make(size : Int) -> PhysicsfluidlevelsetGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_level_set_graphn_len(s : PhysicsfluidlevelsetGraphN) -> Int { s.size }

pub fn physics_fluid_level_set_graphn_get(s : PhysicsfluidlevelsetGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_level_set_graphn_set(s : PhysicsfluidlevelsetGraphN, i : Int, v : Double) -> PhysicsfluidlevelsetGraphN {
  let result = physics_fluid_level_set_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_level_set_graphn_sum(s : PhysicsfluidlevelsetGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_fluid_level_set_graphn_mean(s : PhysicsfluidlevelsetGraphN) -> Double {
  if s.size == 0 { 0.0 } else { physics_fluid_level_set_graphn_sum(s) / s.size.to_double() }
}

pub fn physics_fluid_level_set_graphn_scale(s : PhysicsfluidlevelsetGraphN, f : Double) -> PhysicsfluidlevelsetGraphN {
  let result = physics_fluid_level_set_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_fluid_level_set_graphn_add(a : PhysicsfluidlevelsetGraphN, b : PhysicsfluidlevelsetGraphN) -> PhysicsfluidlevelsetGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_fluid_level_set_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_fluid_level_set_graphn_copy(s : PhysicsfluidlevelsetGraphN) -> PhysicsfluidlevelsetGraphN {
  let result = physics_fluid_level_set_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_fluid_level_set_graphn_fill(s : PhysicsfluidlevelsetGraphN, v : Double) -> PhysicsfluidlevelsetGraphN {
  let result = physics_fluid_level_set_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_level_set_graphn_min(s : PhysicsfluidlevelsetGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_level_set_graphn_max(s : PhysicsfluidlevelsetGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_level_set_graphn_to_string(s : PhysicsfluidlevelsetGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidlevelsetNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_level_set_node_make(size : Int) -> PhysicsfluidlevelsetNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_level_set_node_len(s : PhysicsfluidlevelsetNode) -> Int { s.size }

pub fn physics_fluid_level_set_node_get(s : PhysicsfluidlevelsetNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_level_set_node_set(s : PhysicsfluidlevelsetNode, i : Int, v : Double) -> PhysicsfluidlevelsetNode {
  let result = physics_fluid_level_set_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_level_set_node_sum(s : PhysicsfluidlevelsetNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_fluid_level_set_node_mean(s : PhysicsfluidlevelsetNode) -> Double {
  if s.size == 0 { 0.0 } else { physics_fluid_level_set_node_sum(s) / s.size.to_double() }
}

pub fn physics_fluid_level_set_node_scale(s : PhysicsfluidlevelsetNode, f : Double) -> PhysicsfluidlevelsetNode {
  let result = physics_fluid_level_set_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_fluid_level_set_node_add(a : PhysicsfluidlevelsetNode, b : PhysicsfluidlevelsetNode) -> PhysicsfluidlevelsetNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_fluid_level_set_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_fluid_level_set_node_copy(s : PhysicsfluidlevelsetNode) -> PhysicsfluidlevelsetNode {
  let result = physics_fluid_level_set_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_fluid_level_set_node_fill(s : PhysicsfluidlevelsetNode, v : Double) -> PhysicsfluidlevelsetNode {
  let result = physics_fluid_level_set_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_level_set_node_min(s : PhysicsfluidlevelsetNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_level_set_node_max(s : PhysicsfluidlevelsetNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_level_set_node_to_string(s : PhysicsfluidlevelsetNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidlevelsetEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_level_set_edge_make(size : Int) -> PhysicsfluidlevelsetEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_level_set_edge_len(s : PhysicsfluidlevelsetEdge) -> Int { s.size }

pub fn physics_fluid_level_set_edge_get(s : PhysicsfluidlevelsetEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_level_set_edge_set(s : PhysicsfluidlevelsetEdge, i : Int, v : Double) -> PhysicsfluidlevelsetEdge {
  let result = physics_fluid_level_set_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_level_set_edge_sum(s : PhysicsfluidlevelsetEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_fluid_level_set_edge_mean(s : PhysicsfluidlevelsetEdge) -> Double {
  if s.size == 0 { 0.0 } else { physics_fluid_level_set_edge_sum(s) / s.size.to_double() }
}

pub fn physics_fluid_level_set_edge_scale(s : PhysicsfluidlevelsetEdge, f : Double) -> PhysicsfluidlevelsetEdge {
  let result = physics_fluid_level_set_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_fluid_level_set_edge_add(a : PhysicsfluidlevelsetEdge, b : PhysicsfluidlevelsetEdge) -> PhysicsfluidlevelsetEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_fluid_level_set_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_fluid_level_set_edge_copy(s : PhysicsfluidlevelsetEdge) -> PhysicsfluidlevelsetEdge {
  let result = physics_fluid_level_set_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_fluid_level_set_edge_fill(s : PhysicsfluidlevelsetEdge, v : Double) -> PhysicsfluidlevelsetEdge {
  let result = physics_fluid_level_set_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_level_set_edge_min(s : PhysicsfluidlevelsetEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_level_set_edge_max(s : PhysicsfluidlevelsetEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_level_set_edge_to_string(s : PhysicsfluidlevelsetEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidlevelsetPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_level_set_path_make(size : Int) -> PhysicsfluidlevelsetPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_level_set_path_len(s : PhysicsfluidlevelsetPath) -> Int { s.size }

pub fn physics_fluid_level_set_path_get(s : PhysicsfluidlevelsetPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_level_set_path_set(s : PhysicsfluidlevelsetPath, i : Int, v : Double) -> PhysicsfluidlevelsetPath {
  let result = physics_fluid_level_set_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_level_set_path_sum(s : PhysicsfluidlevelsetPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_fluid_level_set_path_mean(s : PhysicsfluidlevelsetPath) -> Double {
  if s.size == 0 { 0.0 } else { physics_fluid_level_set_path_sum(s) / s.size.to_double() }
}

pub fn physics_fluid_level_set_path_scale(s : PhysicsfluidlevelsetPath, f : Double) -> PhysicsfluidlevelsetPath {
  let result = physics_fluid_level_set_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_fluid_level_set_path_add(a : PhysicsfluidlevelsetPath, b : PhysicsfluidlevelsetPath) -> PhysicsfluidlevelsetPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_fluid_level_set_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_fluid_level_set_path_copy(s : PhysicsfluidlevelsetPath) -> PhysicsfluidlevelsetPath {
  let result = physics_fluid_level_set_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_fluid_level_set_path_fill(s : PhysicsfluidlevelsetPath, v : Double) -> PhysicsfluidlevelsetPath {
  let result = physics_fluid_level_set_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_level_set_path_min(s : PhysicsfluidlevelsetPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_level_set_path_max(s : PhysicsfluidlevelsetPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_level_set_path_to_string(s : PhysicsfluidlevelsetPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidlevelsetCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_level_set_cluster_make(size : Int) -> PhysicsfluidlevelsetCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_level_set_cluster_len(s : PhysicsfluidlevelsetCluster) -> Int { s.size }

pub fn physics_fluid_level_set_cluster_get(s : PhysicsfluidlevelsetCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_level_set_cluster_set(s : PhysicsfluidlevelsetCluster, i : Int, v : Double) -> PhysicsfluidlevelsetCluster {
  let result = physics_fluid_level_set_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_level_set_cluster_sum(s : PhysicsfluidlevelsetCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_fluid_level_set_cluster_mean(s : PhysicsfluidlevelsetCluster) -> Double {
  if s.size == 0 { 0.0 } else { physics_fluid_level_set_cluster_sum(s) / s.size.to_double() }
}

pub fn physics_fluid_level_set_cluster_scale(s : PhysicsfluidlevelsetCluster, f : Double) -> PhysicsfluidlevelsetCluster {
  let result = physics_fluid_level_set_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_fluid_level_set_cluster_add(a : PhysicsfluidlevelsetCluster, b : PhysicsfluidlevelsetCluster) -> PhysicsfluidlevelsetCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_fluid_level_set_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_fluid_level_set_cluster_copy(s : PhysicsfluidlevelsetCluster) -> PhysicsfluidlevelsetCluster {
  let result = physics_fluid_level_set_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_fluid_level_set_cluster_fill(s : PhysicsfluidlevelsetCluster, v : Double) -> PhysicsfluidlevelsetCluster {
  let result = physics_fluid_level_set_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_level_set_cluster_min(s : PhysicsfluidlevelsetCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_level_set_cluster_max(s : PhysicsfluidlevelsetCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_level_set_cluster_to_string(s : PhysicsfluidlevelsetCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidlevelsetModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_level_set_model_make(size : Int) -> PhysicsfluidlevelsetModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_level_set_model_len(s : PhysicsfluidlevelsetModel) -> Int { s.size }

pub fn physics_fluid_level_set_model_get(s : PhysicsfluidlevelsetModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_level_set_model_set(s : PhysicsfluidlevelsetModel, i : Int, v : Double) -> PhysicsfluidlevelsetModel {
  let result = physics_fluid_level_set_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_level_set_model_sum(s : PhysicsfluidlevelsetModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_fluid_level_set_model_mean(s : PhysicsfluidlevelsetModel) -> Double {
  if s.size == 0 { 0.0 } else { physics_fluid_level_set_model_sum(s) / s.size.to_double() }
}

pub fn physics_fluid_level_set_model_scale(s : PhysicsfluidlevelsetModel, f : Double) -> PhysicsfluidlevelsetModel {
  let result = physics_fluid_level_set_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_fluid_level_set_model_add(a : PhysicsfluidlevelsetModel, b : PhysicsfluidlevelsetModel) -> PhysicsfluidlevelsetModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_fluid_level_set_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_fluid_level_set_model_copy(s : PhysicsfluidlevelsetModel) -> PhysicsfluidlevelsetModel {
  let result = physics_fluid_level_set_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_fluid_level_set_model_fill(s : PhysicsfluidlevelsetModel, v : Double) -> PhysicsfluidlevelsetModel {
  let result = physics_fluid_level_set_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_level_set_model_min(s : PhysicsfluidlevelsetModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_level_set_model_max(s : PhysicsfluidlevelsetModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_level_set_model_to_string(s : PhysicsfluidlevelsetModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidlevelsetLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_level_set_layer_make(size : Int) -> PhysicsfluidlevelsetLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_level_set_layer_len(s : PhysicsfluidlevelsetLayer) -> Int { s.size }

pub fn physics_fluid_level_set_layer_get(s : PhysicsfluidlevelsetLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_level_set_layer_set(s : PhysicsfluidlevelsetLayer, i : Int, v : Double) -> PhysicsfluidlevelsetLayer {
  let result = physics_fluid_level_set_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_level_set_layer_sum(s : PhysicsfluidlevelsetLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_fluid_level_set_layer_mean(s : PhysicsfluidlevelsetLayer) -> Double {
  if s.size == 0 { 0.0 } else { physics_fluid_level_set_layer_sum(s) / s.size.to_double() }
}

pub fn physics_fluid_level_set_layer_scale(s : PhysicsfluidlevelsetLayer, f : Double) -> PhysicsfluidlevelsetLayer {
  let result = physics_fluid_level_set_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_fluid_level_set_layer_add(a : PhysicsfluidlevelsetLayer, b : PhysicsfluidlevelsetLayer) -> PhysicsfluidlevelsetLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_fluid_level_set_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_fluid_level_set_layer_copy(s : PhysicsfluidlevelsetLayer) -> PhysicsfluidlevelsetLayer {
  let result = physics_fluid_level_set_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_fluid_level_set_layer_fill(s : PhysicsfluidlevelsetLayer, v : Double) -> PhysicsfluidlevelsetLayer {
  let result = physics_fluid_level_set_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_level_set_layer_min(s : PhysicsfluidlevelsetLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_level_set_layer_max(s : PhysicsfluidlevelsetLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_level_set_layer_to_string(s : PhysicsfluidlevelsetLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidlevelsetBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_level_set_buffer_make(size : Int) -> PhysicsfluidlevelsetBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_level_set_buffer_len(s : PhysicsfluidlevelsetBuffer) -> Int { s.size }

pub fn physics_fluid_level_set_buffer_get(s : PhysicsfluidlevelsetBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_level_set_buffer_set(s : PhysicsfluidlevelsetBuffer, i : Int, v : Double) -> PhysicsfluidlevelsetBuffer {
  let result = physics_fluid_level_set_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_level_set_buffer_sum(s : PhysicsfluidlevelsetBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_fluid_level_set_buffer_mean(s : PhysicsfluidlevelsetBuffer) -> Double {
  if s.size == 0 { 0.0 } else { physics_fluid_level_set_buffer_sum(s) / s.size.to_double() }
}

pub fn physics_fluid_level_set_buffer_scale(s : PhysicsfluidlevelsetBuffer, f : Double) -> PhysicsfluidlevelsetBuffer {
  let result = physics_fluid_level_set_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_fluid_level_set_buffer_add(a : PhysicsfluidlevelsetBuffer, b : PhysicsfluidlevelsetBuffer) -> PhysicsfluidlevelsetBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_fluid_level_set_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_fluid_level_set_buffer_copy(s : PhysicsfluidlevelsetBuffer) -> PhysicsfluidlevelsetBuffer {
  let result = physics_fluid_level_set_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_fluid_level_set_buffer_fill(s : PhysicsfluidlevelsetBuffer, v : Double) -> PhysicsfluidlevelsetBuffer {
  let result = physics_fluid_level_set_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_level_set_buffer_min(s : PhysicsfluidlevelsetBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_level_set_buffer_max(s : PhysicsfluidlevelsetBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_level_set_buffer_to_string(s : PhysicsfluidlevelsetBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidlevelsetCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_level_set_cursor_make(size : Int) -> PhysicsfluidlevelsetCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_level_set_cursor_len(s : PhysicsfluidlevelsetCursor) -> Int { s.size }

pub fn physics_fluid_level_set_cursor_get(s : PhysicsfluidlevelsetCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_level_set_cursor_set(s : PhysicsfluidlevelsetCursor, i : Int, v : Double) -> PhysicsfluidlevelsetCursor {
  let result = physics_fluid_level_set_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_level_set_cursor_sum(s : PhysicsfluidlevelsetCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_fluid_level_set_cursor_mean(s : PhysicsfluidlevelsetCursor) -> Double {
  if s.size == 0 { 0.0 } else { physics_fluid_level_set_cursor_sum(s) / s.size.to_double() }
}

pub fn physics_fluid_level_set_cursor_scale(s : PhysicsfluidlevelsetCursor, f : Double) -> PhysicsfluidlevelsetCursor {
  let result = physics_fluid_level_set_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_fluid_level_set_cursor_add(a : PhysicsfluidlevelsetCursor, b : PhysicsfluidlevelsetCursor) -> PhysicsfluidlevelsetCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_fluid_level_set_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_fluid_level_set_cursor_copy(s : PhysicsfluidlevelsetCursor) -> PhysicsfluidlevelsetCursor {
  let result = physics_fluid_level_set_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_fluid_level_set_cursor_fill(s : PhysicsfluidlevelsetCursor, v : Double) -> PhysicsfluidlevelsetCursor {
  let result = physics_fluid_level_set_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_level_set_cursor_min(s : PhysicsfluidlevelsetCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_level_set_cursor_max(s : PhysicsfluidlevelsetCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_level_set_cursor_to_string(s : PhysicsfluidlevelsetCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidlevelsetView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_level_set_view_make(size : Int) -> PhysicsfluidlevelsetView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_level_set_view_len(s : PhysicsfluidlevelsetView) -> Int { s.size }

pub fn physics_fluid_level_set_view_get(s : PhysicsfluidlevelsetView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_level_set_view_set(s : PhysicsfluidlevelsetView, i : Int, v : Double) -> PhysicsfluidlevelsetView {
  let result = physics_fluid_level_set_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_level_set_view_sum(s : PhysicsfluidlevelsetView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_fluid_level_set_view_mean(s : PhysicsfluidlevelsetView) -> Double {
  if s.size == 0 { 0.0 } else { physics_fluid_level_set_view_sum(s) / s.size.to_double() }
}

pub fn physics_fluid_level_set_view_scale(s : PhysicsfluidlevelsetView, f : Double) -> PhysicsfluidlevelsetView {
  let result = physics_fluid_level_set_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_fluid_level_set_view_add(a : PhysicsfluidlevelsetView, b : PhysicsfluidlevelsetView) -> PhysicsfluidlevelsetView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_fluid_level_set_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_fluid_level_set_view_copy(s : PhysicsfluidlevelsetView) -> PhysicsfluidlevelsetView {
  let result = physics_fluid_level_set_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_fluid_level_set_view_fill(s : PhysicsfluidlevelsetView, v : Double) -> PhysicsfluidlevelsetView {
  let result = physics_fluid_level_set_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_level_set_view_min(s : PhysicsfluidlevelsetView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_level_set_view_max(s : PhysicsfluidlevelsetView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_level_set_view_to_string(s : PhysicsfluidlevelsetView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidlevelsetRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_level_set_range_make(size : Int) -> PhysicsfluidlevelsetRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_level_set_range_len(s : PhysicsfluidlevelsetRange) -> Int { s.size }

pub fn physics_fluid_level_set_range_get(s : PhysicsfluidlevelsetRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_level_set_range_set(s : PhysicsfluidlevelsetRange, i : Int, v : Double) -> PhysicsfluidlevelsetRange {
  let result = physics_fluid_level_set_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_level_set_range_sum(s : PhysicsfluidlevelsetRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_fluid_level_set_range_mean(s : PhysicsfluidlevelsetRange) -> Double {
  if s.size == 0 { 0.0 } else { physics_fluid_level_set_range_sum(s) / s.size.to_double() }
}

pub fn physics_fluid_level_set_range_scale(s : PhysicsfluidlevelsetRange, f : Double) -> PhysicsfluidlevelsetRange {
  let result = physics_fluid_level_set_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_fluid_level_set_range_add(a : PhysicsfluidlevelsetRange, b : PhysicsfluidlevelsetRange) -> PhysicsfluidlevelsetRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_fluid_level_set_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_fluid_level_set_range_copy(s : PhysicsfluidlevelsetRange) -> PhysicsfluidlevelsetRange {
  let result = physics_fluid_level_set_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_fluid_level_set_range_fill(s : PhysicsfluidlevelsetRange, v : Double) -> PhysicsfluidlevelsetRange {
  let result = physics_fluid_level_set_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_level_set_range_min(s : PhysicsfluidlevelsetRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_level_set_range_max(s : PhysicsfluidlevelsetRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_level_set_range_to_string(s : PhysicsfluidlevelsetRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidlevelsetSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_level_set_slice_make(size : Int) -> PhysicsfluidlevelsetSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_level_set_slice_len(s : PhysicsfluidlevelsetSlice) -> Int { s.size }

pub fn physics_fluid_level_set_slice_get(s : PhysicsfluidlevelsetSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_level_set_slice_set(s : PhysicsfluidlevelsetSlice, i : Int, v : Double) -> PhysicsfluidlevelsetSlice {
  let result = physics_fluid_level_set_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_level_set_slice_sum(s : PhysicsfluidlevelsetSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_fluid_level_set_slice_mean(s : PhysicsfluidlevelsetSlice) -> Double {
  if s.size == 0 { 0.0 } else { physics_fluid_level_set_slice_sum(s) / s.size.to_double() }
}

pub fn physics_fluid_level_set_slice_scale(s : PhysicsfluidlevelsetSlice, f : Double) -> PhysicsfluidlevelsetSlice {
  let result = physics_fluid_level_set_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_fluid_level_set_slice_add(a : PhysicsfluidlevelsetSlice, b : PhysicsfluidlevelsetSlice) -> PhysicsfluidlevelsetSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_fluid_level_set_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_fluid_level_set_slice_copy(s : PhysicsfluidlevelsetSlice) -> PhysicsfluidlevelsetSlice {
  let result = physics_fluid_level_set_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_fluid_level_set_slice_fill(s : PhysicsfluidlevelsetSlice, v : Double) -> PhysicsfluidlevelsetSlice {
  let result = physics_fluid_level_set_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_level_set_slice_min(s : PhysicsfluidlevelsetSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_level_set_slice_max(s : PhysicsfluidlevelsetSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_level_set_slice_to_string(s : PhysicsfluidlevelsetSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

