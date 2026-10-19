///===
/// extcore/physics_fluid_stokes

pub(all) struct PhysicsfluidstokesPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn physics_fluid_stokes_make_point(x : Double, y : Double) -> PhysicsfluidstokesPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn physics_fluid_stokes_make_point3(x : Double, y : Double, z : Double) -> PhysicsfluidstokesPoint {
  { x, y, z, label: 0 }
}

pub fn physics_fluid_stokes_point_x(pt : PhysicsfluidstokesPoint) -> Double { pt.x }

pub fn physics_fluid_stokes_point_y(pt : PhysicsfluidstokesPoint) -> Double { pt.y }

pub fn physics_fluid_stokes_point_z(pt : PhysicsfluidstokesPoint) -> Double { pt.z }

pub fn physics_fluid_stokes_point_label(pt : PhysicsfluidstokesPoint) -> Int { pt.label }

pub fn physics_fluid_stokes_point_dist(a : PhysicsfluidstokesPoint, b : PhysicsfluidstokesPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn physics_fluid_stokes_point_add(a : PhysicsfluidstokesPoint, b : PhysicsfluidstokesPoint) -> PhysicsfluidstokesPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn physics_fluid_stokes_point_sub(a : PhysicsfluidstokesPoint, b : PhysicsfluidstokesPoint) -> PhysicsfluidstokesPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn physics_fluid_stokes_point_scale(pt : PhysicsfluidstokesPoint, s : Double) -> PhysicsfluidstokesPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn physics_fluid_stokes_point_dot(a : PhysicsfluidstokesPoint, b : PhysicsfluidstokesPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn physics_fluid_stokes_point_cross(a : PhysicsfluidstokesPoint, b : PhysicsfluidstokesPoint) -> PhysicsfluidstokesPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn physics_fluid_stokes_point_norm(pt : PhysicsfluidstokesPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn physics_fluid_stokes_point_normalize(pt : PhysicsfluidstokesPoint) -> PhysicsfluidstokesPoint {
  let n = physics_fluid_stokes_point_norm(pt)
  if n < 0.0000001 { pt } else { physics_fluid_stokes_point_scale(pt, 1.0 / n) }
}

pub fn physics_fluid_stokes_point_negate(pt : PhysicsfluidstokesPoint) -> PhysicsfluidstokesPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn physics_fluid_stokes_point_mid(a : PhysicsfluidstokesPoint, b : PhysicsfluidstokesPoint) -> PhysicsfluidstokesPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn physics_fluid_stokes_point_lerp(a : PhysicsfluidstokesPoint, b : PhysicsfluidstokesPoint, t : Double) -> PhysicsfluidstokesPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn physics_fluid_stokes_point_to_string(pt : PhysicsfluidstokesPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct PhysicsfluidstokesSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn physics_fluid_stokes_make_series(vals : Array[Double], name : String) -> PhysicsfluidstokesSeries {
  { vals, name, meta: 0 }
}

pub fn physics_fluid_stokes_series_len(s : PhysicsfluidstokesSeries) -> Int { s.vals.length() }

pub fn physics_fluid_stokes_series_sum(s : PhysicsfluidstokesSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn physics_fluid_stokes_series_mean(s : PhysicsfluidstokesSeries) -> Double {
  let n = physics_fluid_stokes_series_len(s)
  if n == 0 { 0.0 } else { physics_fluid_stokes_series_sum(s) / n.to_double() }
}

pub fn physics_fluid_stokes_series_min(s : PhysicsfluidstokesSeries) -> Double {
  let n = physics_fluid_stokes_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn physics_fluid_stokes_series_max(s : PhysicsfluidstokesSeries) -> Double {
  let n = physics_fluid_stokes_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn physics_fluid_stokes_series_range(s : PhysicsfluidstokesSeries) -> Double {
  physics_fluid_stokes_series_max(s) - physics_fluid_stokes_series_min(s)
}

pub fn physics_fluid_stokes_series_var(s : PhysicsfluidstokesSeries) -> Double {
  let n = physics_fluid_stokes_series_len(s)
  if n == 0 { 0.0 } else {
    let m = physics_fluid_stokes_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn physics_fluid_stokes_series_std(s : PhysicsfluidstokesSeries) -> Double { @_common.sqrt(physics_fluid_stokes_series_var(s)) }

pub fn physics_fluid_stokes_series_median(s : PhysicsfluidstokesSeries) -> Double {
  let n = physics_fluid_stokes_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = physics_fluid_stokes_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn physics_fluid_stokes_series_scale(s : PhysicsfluidstokesSeries, f : Double) -> PhysicsfluidstokesSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn physics_fluid_stokes_series_add(a : PhysicsfluidstokesSeries, b : PhysicsfluidstokesSeries) -> PhysicsfluidstokesSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn physics_fluid_stokes_series_sub(a : PhysicsfluidstokesSeries, b : PhysicsfluidstokesSeries) -> PhysicsfluidstokesSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn physics_fluid_stokes_series_normalize(s : PhysicsfluidstokesSeries) -> PhysicsfluidstokesSeries {
  let mn = physics_fluid_stokes_series_min(s)
  let mx = physics_fluid_stokes_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn physics_fluid_stokes_series_cumsum(s : PhysicsfluidstokesSeries) -> PhysicsfluidstokesSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn physics_fluid_stokes_series_to_string(s : PhysicsfluidstokesSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct PhysicsfluidstokesMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn physics_fluid_stokes_make_matrix(rows : Int, cols : Int, val : Double) -> PhysicsfluidstokesMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn physics_fluid_stokes_matrix_identity(n : Int) -> PhysicsfluidstokesMatrix {
  let m = physics_fluid_stokes_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn physics_fluid_stokes_matrix_get(m : PhysicsfluidstokesMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn physics_fluid_stokes_matrix_transpose(m : PhysicsfluidstokesMatrix) -> PhysicsfluidstokesMatrix {
  let result = physics_fluid_stokes_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn physics_fluid_stokes_matrix_add(a : PhysicsfluidstokesMatrix, b : PhysicsfluidstokesMatrix) -> PhysicsfluidstokesMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = physics_fluid_stokes_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn physics_fluid_stokes_matrix_scale(m : PhysicsfluidstokesMatrix, s : Double) -> PhysicsfluidstokesMatrix {
  let result = physics_fluid_stokes_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn physics_fluid_stokes_matrix_multiply(a : PhysicsfluidstokesMatrix, b : PhysicsfluidstokesMatrix) -> PhysicsfluidstokesMatrix {
  if a.cols != b.rows { return physics_fluid_stokes_make_matrix(a.rows, b.cols, 0.0) }
  let result = physics_fluid_stokes_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn physics_fluid_stokes_matrix_trace(m : PhysicsfluidstokesMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn physics_fluid_stokes_matrix_det(m : PhysicsfluidstokesMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn physics_fluid_stokes_matrix_norm(m : PhysicsfluidstokesMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn physics_fluid_stokes_matrix_to_string(m : PhysicsfluidstokesMatrix) -> String {
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

pub(all) struct PhysicsfluidstokesVector {
  comps : Array[Double]
  dim : Int
}

pub fn physics_fluid_stokes_make_vector(comps : Array[Double]) -> PhysicsfluidstokesVector {
  { comps, dim: comps.length() }
}

pub fn physics_fluid_stokes_vector_zero(dim : Int) -> PhysicsfluidstokesVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn physics_fluid_stokes_vector_add(a : PhysicsfluidstokesVector, b : PhysicsfluidstokesVector) -> PhysicsfluidstokesVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn physics_fluid_stokes_vector_sub(a : PhysicsfluidstokesVector, b : PhysicsfluidstokesVector) -> PhysicsfluidstokesVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn physics_fluid_stokes_vector_scale(v : PhysicsfluidstokesVector, s : Double) -> PhysicsfluidstokesVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn physics_fluid_stokes_vector_dot(a : PhysicsfluidstokesVector, b : PhysicsfluidstokesVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn physics_fluid_stokes_vector_norm(v : PhysicsfluidstokesVector) -> Double { @_common.sqrt(physics_fluid_stokes_vector_dot(v, v)) }

pub fn physics_fluid_stokes_vector_normalize(v : PhysicsfluidstokesVector) -> PhysicsfluidstokesVector {
  let n = physics_fluid_stokes_vector_norm(v)
  if n < 0.0000001 { v } else { physics_fluid_stokes_vector_scale(v, 1.0 / n) }
}

pub fn physics_fluid_stokes_vector_dist(a : PhysicsfluidstokesVector, b : PhysicsfluidstokesVector) -> Double {
  physics_fluid_stokes_vector_norm(physics_fluid_stokes_vector_sub(a, b))
}

pub fn physics_fluid_stokes_vector_to_string(v : PhysicsfluidstokesVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn physics_fluid_stokes_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn physics_fluid_stokes_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = physics_fluid_stokes_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn physics_fluid_stokes_std(data : Array[Double]) -> Double { @_common.sqrt(physics_fluid_stokes_var(data)) }

pub fn physics_fluid_stokes_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = physics_fluid_stokes_mean(a); let mb = physics_fluid_stokes_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn physics_fluid_stokes_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = physics_fluid_stokes_std(a); let sb = physics_fluid_stokes_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { physics_fluid_stokes_cov(a, b) / (sa * sb) }
}

pub fn physics_fluid_stokes_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = physics_fluid_stokes_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn physics_fluid_stokes_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn physics_fluid_stokes_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn physics_fluid_stokes_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  @_common.sqrt(physics_fluid_stokes_mse(pred, labels))
}

pub fn physics_fluid_stokes_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn physics_fluid_stokes_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = physics_fluid_stokes_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn physics_fluid_stokes_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn physics_fluid_stokes_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn physics_fluid_stokes_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = physics_fluid_stokes_precision(pred, labels, pos); let r = physics_fluid_stokes_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn physics_fluid_stokes_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn physics_fluid_stokes_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = physics_fluid_stokes_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn physics_fluid_stokes_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn physics_fluid_stokes_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn physics_fluid_stokes_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = physics_fluid_stokes_gcd(a, b)
    (a / g) * b
  }
}

pub fn physics_fluid_stokes_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn physics_fluid_stokes_fibonacci(n : Int) -> Int {
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

pub fn physics_fluid_stokes_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = physics_fluid_stokes_min(data); let mx = physics_fluid_stokes_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn physics_fluid_stokes_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = physics_fluid_stokes_mean(data); let sd = physics_fluid_stokes_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn physics_fluid_stokes_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn physics_fluid_stokes_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn physics_fluid_stokes_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn physics_fluid_stokes_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn physics_fluid_stokes_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn physics_fluid_stokes_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

pub(all) struct PhysicsfluidstokesFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_stokes_frame_make(size : Int) -> PhysicsfluidstokesFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_stokes_frame_len(s : PhysicsfluidstokesFrame) -> Int { s.size }

pub fn physics_fluid_stokes_frame_get(s : PhysicsfluidstokesFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_stokes_frame_set(s : PhysicsfluidstokesFrame, i : Int, v : Double) -> PhysicsfluidstokesFrame {
  let result = physics_fluid_stokes_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_stokes_frame_sum(s : PhysicsfluidstokesFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_fluid_stokes_frame_mean(s : PhysicsfluidstokesFrame) -> Double {
  if s.size == 0 { 0.0 } else { physics_fluid_stokes_frame_sum(s) / s.size.to_double() }
}

pub fn physics_fluid_stokes_frame_scale(s : PhysicsfluidstokesFrame, f : Double) -> PhysicsfluidstokesFrame {
  let result = physics_fluid_stokes_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_fluid_stokes_frame_add(a : PhysicsfluidstokesFrame, b : PhysicsfluidstokesFrame) -> PhysicsfluidstokesFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_fluid_stokes_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_fluid_stokes_frame_copy(s : PhysicsfluidstokesFrame) -> PhysicsfluidstokesFrame {
  let result = physics_fluid_stokes_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_fluid_stokes_frame_fill(s : PhysicsfluidstokesFrame, v : Double) -> PhysicsfluidstokesFrame {
  let result = physics_fluid_stokes_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_stokes_frame_min(s : PhysicsfluidstokesFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_stokes_frame_max(s : PhysicsfluidstokesFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_stokes_frame_to_string(s : PhysicsfluidstokesFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidstokesTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_stokes_table_make(size : Int) -> PhysicsfluidstokesTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_stokes_table_len(s : PhysicsfluidstokesTable) -> Int { s.size }

pub fn physics_fluid_stokes_table_get(s : PhysicsfluidstokesTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_stokes_table_set(s : PhysicsfluidstokesTable, i : Int, v : Double) -> PhysicsfluidstokesTable {
  let result = physics_fluid_stokes_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_stokes_table_sum(s : PhysicsfluidstokesTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_fluid_stokes_table_mean(s : PhysicsfluidstokesTable) -> Double {
  if s.size == 0 { 0.0 } else { physics_fluid_stokes_table_sum(s) / s.size.to_double() }
}

pub fn physics_fluid_stokes_table_scale(s : PhysicsfluidstokesTable, f : Double) -> PhysicsfluidstokesTable {
  let result = physics_fluid_stokes_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_fluid_stokes_table_add(a : PhysicsfluidstokesTable, b : PhysicsfluidstokesTable) -> PhysicsfluidstokesTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_fluid_stokes_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_fluid_stokes_table_copy(s : PhysicsfluidstokesTable) -> PhysicsfluidstokesTable {
  let result = physics_fluid_stokes_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_fluid_stokes_table_fill(s : PhysicsfluidstokesTable, v : Double) -> PhysicsfluidstokesTable {
  let result = physics_fluid_stokes_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_stokes_table_min(s : PhysicsfluidstokesTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_stokes_table_max(s : PhysicsfluidstokesTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_stokes_table_to_string(s : PhysicsfluidstokesTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidstokesGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_stokes_graphn_make(size : Int) -> PhysicsfluidstokesGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_stokes_graphn_len(s : PhysicsfluidstokesGraphN) -> Int { s.size }

pub fn physics_fluid_stokes_graphn_get(s : PhysicsfluidstokesGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_stokes_graphn_set(s : PhysicsfluidstokesGraphN, i : Int, v : Double) -> PhysicsfluidstokesGraphN {
  let result = physics_fluid_stokes_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_stokes_graphn_sum(s : PhysicsfluidstokesGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_fluid_stokes_graphn_mean(s : PhysicsfluidstokesGraphN) -> Double {
  if s.size == 0 { 0.0 } else { physics_fluid_stokes_graphn_sum(s) / s.size.to_double() }
}

pub fn physics_fluid_stokes_graphn_scale(s : PhysicsfluidstokesGraphN, f : Double) -> PhysicsfluidstokesGraphN {
  let result = physics_fluid_stokes_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_fluid_stokes_graphn_add(a : PhysicsfluidstokesGraphN, b : PhysicsfluidstokesGraphN) -> PhysicsfluidstokesGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_fluid_stokes_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_fluid_stokes_graphn_copy(s : PhysicsfluidstokesGraphN) -> PhysicsfluidstokesGraphN {
  let result = physics_fluid_stokes_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_fluid_stokes_graphn_fill(s : PhysicsfluidstokesGraphN, v : Double) -> PhysicsfluidstokesGraphN {
  let result = physics_fluid_stokes_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_stokes_graphn_min(s : PhysicsfluidstokesGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_stokes_graphn_max(s : PhysicsfluidstokesGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_stokes_graphn_to_string(s : PhysicsfluidstokesGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidstokesNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_stokes_node_make(size : Int) -> PhysicsfluidstokesNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_stokes_node_len(s : PhysicsfluidstokesNode) -> Int { s.size }

pub fn physics_fluid_stokes_node_get(s : PhysicsfluidstokesNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_stokes_node_set(s : PhysicsfluidstokesNode, i : Int, v : Double) -> PhysicsfluidstokesNode {
  let result = physics_fluid_stokes_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_stokes_node_sum(s : PhysicsfluidstokesNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_fluid_stokes_node_mean(s : PhysicsfluidstokesNode) -> Double {
  if s.size == 0 { 0.0 } else { physics_fluid_stokes_node_sum(s) / s.size.to_double() }
}

pub fn physics_fluid_stokes_node_scale(s : PhysicsfluidstokesNode, f : Double) -> PhysicsfluidstokesNode {
  let result = physics_fluid_stokes_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_fluid_stokes_node_add(a : PhysicsfluidstokesNode, b : PhysicsfluidstokesNode) -> PhysicsfluidstokesNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_fluid_stokes_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_fluid_stokes_node_copy(s : PhysicsfluidstokesNode) -> PhysicsfluidstokesNode {
  let result = physics_fluid_stokes_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_fluid_stokes_node_fill(s : PhysicsfluidstokesNode, v : Double) -> PhysicsfluidstokesNode {
  let result = physics_fluid_stokes_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_stokes_node_min(s : PhysicsfluidstokesNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_stokes_node_max(s : PhysicsfluidstokesNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_stokes_node_to_string(s : PhysicsfluidstokesNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidstokesEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_stokes_edge_make(size : Int) -> PhysicsfluidstokesEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_stokes_edge_len(s : PhysicsfluidstokesEdge) -> Int { s.size }

pub fn physics_fluid_stokes_edge_get(s : PhysicsfluidstokesEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_stokes_edge_set(s : PhysicsfluidstokesEdge, i : Int, v : Double) -> PhysicsfluidstokesEdge {
  let result = physics_fluid_stokes_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_stokes_edge_sum(s : PhysicsfluidstokesEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_fluid_stokes_edge_mean(s : PhysicsfluidstokesEdge) -> Double {
  if s.size == 0 { 0.0 } else { physics_fluid_stokes_edge_sum(s) / s.size.to_double() }
}

pub fn physics_fluid_stokes_edge_scale(s : PhysicsfluidstokesEdge, f : Double) -> PhysicsfluidstokesEdge {
  let result = physics_fluid_stokes_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_fluid_stokes_edge_add(a : PhysicsfluidstokesEdge, b : PhysicsfluidstokesEdge) -> PhysicsfluidstokesEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_fluid_stokes_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_fluid_stokes_edge_copy(s : PhysicsfluidstokesEdge) -> PhysicsfluidstokesEdge {
  let result = physics_fluid_stokes_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_fluid_stokes_edge_fill(s : PhysicsfluidstokesEdge, v : Double) -> PhysicsfluidstokesEdge {
  let result = physics_fluid_stokes_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_stokes_edge_min(s : PhysicsfluidstokesEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_stokes_edge_max(s : PhysicsfluidstokesEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_stokes_edge_to_string(s : PhysicsfluidstokesEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidstokesPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_stokes_path_make(size : Int) -> PhysicsfluidstokesPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_stokes_path_len(s : PhysicsfluidstokesPath) -> Int { s.size }

pub fn physics_fluid_stokes_path_get(s : PhysicsfluidstokesPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_stokes_path_set(s : PhysicsfluidstokesPath, i : Int, v : Double) -> PhysicsfluidstokesPath {
  let result = physics_fluid_stokes_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_stokes_path_sum(s : PhysicsfluidstokesPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_fluid_stokes_path_mean(s : PhysicsfluidstokesPath) -> Double {
  if s.size == 0 { 0.0 } else { physics_fluid_stokes_path_sum(s) / s.size.to_double() }
}

pub fn physics_fluid_stokes_path_scale(s : PhysicsfluidstokesPath, f : Double) -> PhysicsfluidstokesPath {
  let result = physics_fluid_stokes_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_fluid_stokes_path_add(a : PhysicsfluidstokesPath, b : PhysicsfluidstokesPath) -> PhysicsfluidstokesPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_fluid_stokes_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_fluid_stokes_path_copy(s : PhysicsfluidstokesPath) -> PhysicsfluidstokesPath {
  let result = physics_fluid_stokes_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_fluid_stokes_path_fill(s : PhysicsfluidstokesPath, v : Double) -> PhysicsfluidstokesPath {
  let result = physics_fluid_stokes_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_stokes_path_min(s : PhysicsfluidstokesPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_stokes_path_max(s : PhysicsfluidstokesPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_stokes_path_to_string(s : PhysicsfluidstokesPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidstokesCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_stokes_cluster_make(size : Int) -> PhysicsfluidstokesCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_stokes_cluster_len(s : PhysicsfluidstokesCluster) -> Int { s.size }

pub fn physics_fluid_stokes_cluster_get(s : PhysicsfluidstokesCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_stokes_cluster_set(s : PhysicsfluidstokesCluster, i : Int, v : Double) -> PhysicsfluidstokesCluster {
  let result = physics_fluid_stokes_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_stokes_cluster_sum(s : PhysicsfluidstokesCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_fluid_stokes_cluster_mean(s : PhysicsfluidstokesCluster) -> Double {
  if s.size == 0 { 0.0 } else { physics_fluid_stokes_cluster_sum(s) / s.size.to_double() }
}

pub fn physics_fluid_stokes_cluster_scale(s : PhysicsfluidstokesCluster, f : Double) -> PhysicsfluidstokesCluster {
  let result = physics_fluid_stokes_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_fluid_stokes_cluster_add(a : PhysicsfluidstokesCluster, b : PhysicsfluidstokesCluster) -> PhysicsfluidstokesCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_fluid_stokes_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_fluid_stokes_cluster_copy(s : PhysicsfluidstokesCluster) -> PhysicsfluidstokesCluster {
  let result = physics_fluid_stokes_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_fluid_stokes_cluster_fill(s : PhysicsfluidstokesCluster, v : Double) -> PhysicsfluidstokesCluster {
  let result = physics_fluid_stokes_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_stokes_cluster_min(s : PhysicsfluidstokesCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_stokes_cluster_max(s : PhysicsfluidstokesCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_stokes_cluster_to_string(s : PhysicsfluidstokesCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidstokesModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_stokes_model_make(size : Int) -> PhysicsfluidstokesModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_stokes_model_len(s : PhysicsfluidstokesModel) -> Int { s.size }

pub fn physics_fluid_stokes_model_get(s : PhysicsfluidstokesModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_stokes_model_set(s : PhysicsfluidstokesModel, i : Int, v : Double) -> PhysicsfluidstokesModel {
  let result = physics_fluid_stokes_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_stokes_model_sum(s : PhysicsfluidstokesModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_fluid_stokes_model_mean(s : PhysicsfluidstokesModel) -> Double {
  if s.size == 0 { 0.0 } else { physics_fluid_stokes_model_sum(s) / s.size.to_double() }
}

pub fn physics_fluid_stokes_model_scale(s : PhysicsfluidstokesModel, f : Double) -> PhysicsfluidstokesModel {
  let result = physics_fluid_stokes_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_fluid_stokes_model_add(a : PhysicsfluidstokesModel, b : PhysicsfluidstokesModel) -> PhysicsfluidstokesModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_fluid_stokes_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_fluid_stokes_model_copy(s : PhysicsfluidstokesModel) -> PhysicsfluidstokesModel {
  let result = physics_fluid_stokes_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_fluid_stokes_model_fill(s : PhysicsfluidstokesModel, v : Double) -> PhysicsfluidstokesModel {
  let result = physics_fluid_stokes_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_stokes_model_min(s : PhysicsfluidstokesModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_stokes_model_max(s : PhysicsfluidstokesModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_stokes_model_to_string(s : PhysicsfluidstokesModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidstokesLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_stokes_layer_make(size : Int) -> PhysicsfluidstokesLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_stokes_layer_len(s : PhysicsfluidstokesLayer) -> Int { s.size }

pub fn physics_fluid_stokes_layer_get(s : PhysicsfluidstokesLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_stokes_layer_set(s : PhysicsfluidstokesLayer, i : Int, v : Double) -> PhysicsfluidstokesLayer {
  let result = physics_fluid_stokes_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_stokes_layer_sum(s : PhysicsfluidstokesLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_fluid_stokes_layer_mean(s : PhysicsfluidstokesLayer) -> Double {
  if s.size == 0 { 0.0 } else { physics_fluid_stokes_layer_sum(s) / s.size.to_double() }
}

pub fn physics_fluid_stokes_layer_scale(s : PhysicsfluidstokesLayer, f : Double) -> PhysicsfluidstokesLayer {
  let result = physics_fluid_stokes_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_fluid_stokes_layer_add(a : PhysicsfluidstokesLayer, b : PhysicsfluidstokesLayer) -> PhysicsfluidstokesLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_fluid_stokes_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_fluid_stokes_layer_copy(s : PhysicsfluidstokesLayer) -> PhysicsfluidstokesLayer {
  let result = physics_fluid_stokes_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_fluid_stokes_layer_fill(s : PhysicsfluidstokesLayer, v : Double) -> PhysicsfluidstokesLayer {
  let result = physics_fluid_stokes_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_stokes_layer_min(s : PhysicsfluidstokesLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_stokes_layer_max(s : PhysicsfluidstokesLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_stokes_layer_to_string(s : PhysicsfluidstokesLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidstokesBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_stokes_buffer_make(size : Int) -> PhysicsfluidstokesBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_stokes_buffer_len(s : PhysicsfluidstokesBuffer) -> Int { s.size }

pub fn physics_fluid_stokes_buffer_get(s : PhysicsfluidstokesBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_stokes_buffer_set(s : PhysicsfluidstokesBuffer, i : Int, v : Double) -> PhysicsfluidstokesBuffer {
  let result = physics_fluid_stokes_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_stokes_buffer_sum(s : PhysicsfluidstokesBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_fluid_stokes_buffer_mean(s : PhysicsfluidstokesBuffer) -> Double {
  if s.size == 0 { 0.0 } else { physics_fluid_stokes_buffer_sum(s) / s.size.to_double() }
}

pub fn physics_fluid_stokes_buffer_scale(s : PhysicsfluidstokesBuffer, f : Double) -> PhysicsfluidstokesBuffer {
  let result = physics_fluid_stokes_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_fluid_stokes_buffer_add(a : PhysicsfluidstokesBuffer, b : PhysicsfluidstokesBuffer) -> PhysicsfluidstokesBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_fluid_stokes_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_fluid_stokes_buffer_copy(s : PhysicsfluidstokesBuffer) -> PhysicsfluidstokesBuffer {
  let result = physics_fluid_stokes_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_fluid_stokes_buffer_fill(s : PhysicsfluidstokesBuffer, v : Double) -> PhysicsfluidstokesBuffer {
  let result = physics_fluid_stokes_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_stokes_buffer_min(s : PhysicsfluidstokesBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_stokes_buffer_max(s : PhysicsfluidstokesBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_stokes_buffer_to_string(s : PhysicsfluidstokesBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidstokesCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_stokes_cursor_make(size : Int) -> PhysicsfluidstokesCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_stokes_cursor_len(s : PhysicsfluidstokesCursor) -> Int { s.size }

pub fn physics_fluid_stokes_cursor_get(s : PhysicsfluidstokesCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_stokes_cursor_set(s : PhysicsfluidstokesCursor, i : Int, v : Double) -> PhysicsfluidstokesCursor {
  let result = physics_fluid_stokes_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_stokes_cursor_sum(s : PhysicsfluidstokesCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_fluid_stokes_cursor_mean(s : PhysicsfluidstokesCursor) -> Double {
  if s.size == 0 { 0.0 } else { physics_fluid_stokes_cursor_sum(s) / s.size.to_double() }
}

pub fn physics_fluid_stokes_cursor_scale(s : PhysicsfluidstokesCursor, f : Double) -> PhysicsfluidstokesCursor {
  let result = physics_fluid_stokes_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_fluid_stokes_cursor_add(a : PhysicsfluidstokesCursor, b : PhysicsfluidstokesCursor) -> PhysicsfluidstokesCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_fluid_stokes_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_fluid_stokes_cursor_copy(s : PhysicsfluidstokesCursor) -> PhysicsfluidstokesCursor {
  let result = physics_fluid_stokes_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_fluid_stokes_cursor_fill(s : PhysicsfluidstokesCursor, v : Double) -> PhysicsfluidstokesCursor {
  let result = physics_fluid_stokes_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_stokes_cursor_min(s : PhysicsfluidstokesCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_stokes_cursor_max(s : PhysicsfluidstokesCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_stokes_cursor_to_string(s : PhysicsfluidstokesCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidstokesView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_stokes_view_make(size : Int) -> PhysicsfluidstokesView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_stokes_view_len(s : PhysicsfluidstokesView) -> Int { s.size }

pub fn physics_fluid_stokes_view_get(s : PhysicsfluidstokesView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_stokes_view_set(s : PhysicsfluidstokesView, i : Int, v : Double) -> PhysicsfluidstokesView {
  let result = physics_fluid_stokes_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_stokes_view_sum(s : PhysicsfluidstokesView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_fluid_stokes_view_mean(s : PhysicsfluidstokesView) -> Double {
  if s.size == 0 { 0.0 } else { physics_fluid_stokes_view_sum(s) / s.size.to_double() }
}

pub fn physics_fluid_stokes_view_scale(s : PhysicsfluidstokesView, f : Double) -> PhysicsfluidstokesView {
  let result = physics_fluid_stokes_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_fluid_stokes_view_add(a : PhysicsfluidstokesView, b : PhysicsfluidstokesView) -> PhysicsfluidstokesView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_fluid_stokes_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_fluid_stokes_view_copy(s : PhysicsfluidstokesView) -> PhysicsfluidstokesView {
  let result = physics_fluid_stokes_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_fluid_stokes_view_fill(s : PhysicsfluidstokesView, v : Double) -> PhysicsfluidstokesView {
  let result = physics_fluid_stokes_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_stokes_view_min(s : PhysicsfluidstokesView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_stokes_view_max(s : PhysicsfluidstokesView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_stokes_view_to_string(s : PhysicsfluidstokesView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidstokesRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_stokes_range_make(size : Int) -> PhysicsfluidstokesRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_stokes_range_len(s : PhysicsfluidstokesRange) -> Int { s.size }

pub fn physics_fluid_stokes_range_get(s : PhysicsfluidstokesRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_stokes_range_set(s : PhysicsfluidstokesRange, i : Int, v : Double) -> PhysicsfluidstokesRange {
  let result = physics_fluid_stokes_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_stokes_range_sum(s : PhysicsfluidstokesRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_fluid_stokes_range_mean(s : PhysicsfluidstokesRange) -> Double {
  if s.size == 0 { 0.0 } else { physics_fluid_stokes_range_sum(s) / s.size.to_double() }
}

pub fn physics_fluid_stokes_range_scale(s : PhysicsfluidstokesRange, f : Double) -> PhysicsfluidstokesRange {
  let result = physics_fluid_stokes_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_fluid_stokes_range_add(a : PhysicsfluidstokesRange, b : PhysicsfluidstokesRange) -> PhysicsfluidstokesRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_fluid_stokes_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_fluid_stokes_range_copy(s : PhysicsfluidstokesRange) -> PhysicsfluidstokesRange {
  let result = physics_fluid_stokes_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_fluid_stokes_range_fill(s : PhysicsfluidstokesRange, v : Double) -> PhysicsfluidstokesRange {
  let result = physics_fluid_stokes_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_stokes_range_min(s : PhysicsfluidstokesRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_stokes_range_max(s : PhysicsfluidstokesRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_stokes_range_to_string(s : PhysicsfluidstokesRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidstokesSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_stokes_slice_make(size : Int) -> PhysicsfluidstokesSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_stokes_slice_len(s : PhysicsfluidstokesSlice) -> Int { s.size }

pub fn physics_fluid_stokes_slice_get(s : PhysicsfluidstokesSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_stokes_slice_set(s : PhysicsfluidstokesSlice, i : Int, v : Double) -> PhysicsfluidstokesSlice {
  let result = physics_fluid_stokes_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_stokes_slice_sum(s : PhysicsfluidstokesSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_fluid_stokes_slice_mean(s : PhysicsfluidstokesSlice) -> Double {
  if s.size == 0 { 0.0 } else { physics_fluid_stokes_slice_sum(s) / s.size.to_double() }
}

pub fn physics_fluid_stokes_slice_scale(s : PhysicsfluidstokesSlice, f : Double) -> PhysicsfluidstokesSlice {
  let result = physics_fluid_stokes_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_fluid_stokes_slice_add(a : PhysicsfluidstokesSlice, b : PhysicsfluidstokesSlice) -> PhysicsfluidstokesSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_fluid_stokes_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_fluid_stokes_slice_copy(s : PhysicsfluidstokesSlice) -> PhysicsfluidstokesSlice {
  let result = physics_fluid_stokes_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_fluid_stokes_slice_fill(s : PhysicsfluidstokesSlice, v : Double) -> PhysicsfluidstokesSlice {
  let result = physics_fluid_stokes_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_stokes_slice_min(s : PhysicsfluidstokesSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_stokes_slice_max(s : PhysicsfluidstokesSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_stokes_slice_to_string(s : PhysicsfluidstokesSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

