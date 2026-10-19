///===
/// extcore/physics_mechanics_soft

pub(all) struct PhysicsmechanicssoftPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn physics_mechanics_soft_make_point(x : Double, y : Double) -> PhysicsmechanicssoftPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn physics_mechanics_soft_make_point3(x : Double, y : Double, z : Double) -> PhysicsmechanicssoftPoint {
  { x, y, z, label: 0 }
}

pub fn physics_mechanics_soft_point_x(pt : PhysicsmechanicssoftPoint) -> Double { pt.x }

pub fn physics_mechanics_soft_point_y(pt : PhysicsmechanicssoftPoint) -> Double { pt.y }

pub fn physics_mechanics_soft_point_z(pt : PhysicsmechanicssoftPoint) -> Double { pt.z }

pub fn physics_mechanics_soft_point_label(pt : PhysicsmechanicssoftPoint) -> Int { pt.label }

pub fn physics_mechanics_soft_point_dist(a : PhysicsmechanicssoftPoint, b : PhysicsmechanicssoftPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn physics_mechanics_soft_point_add(a : PhysicsmechanicssoftPoint, b : PhysicsmechanicssoftPoint) -> PhysicsmechanicssoftPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn physics_mechanics_soft_point_sub(a : PhysicsmechanicssoftPoint, b : PhysicsmechanicssoftPoint) -> PhysicsmechanicssoftPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn physics_mechanics_soft_point_scale(pt : PhysicsmechanicssoftPoint, s : Double) -> PhysicsmechanicssoftPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn physics_mechanics_soft_point_dot(a : PhysicsmechanicssoftPoint, b : PhysicsmechanicssoftPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn physics_mechanics_soft_point_cross(a : PhysicsmechanicssoftPoint, b : PhysicsmechanicssoftPoint) -> PhysicsmechanicssoftPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn physics_mechanics_soft_point_norm(pt : PhysicsmechanicssoftPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn physics_mechanics_soft_point_normalize(pt : PhysicsmechanicssoftPoint) -> PhysicsmechanicssoftPoint {
  let n = physics_mechanics_soft_point_norm(pt)
  if n < 0.0000001 { pt } else { physics_mechanics_soft_point_scale(pt, 1.0 / n) }
}

pub fn physics_mechanics_soft_point_negate(pt : PhysicsmechanicssoftPoint) -> PhysicsmechanicssoftPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn physics_mechanics_soft_point_mid(a : PhysicsmechanicssoftPoint, b : PhysicsmechanicssoftPoint) -> PhysicsmechanicssoftPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn physics_mechanics_soft_point_lerp(a : PhysicsmechanicssoftPoint, b : PhysicsmechanicssoftPoint, t : Double) -> PhysicsmechanicssoftPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn physics_mechanics_soft_point_to_string(pt : PhysicsmechanicssoftPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct PhysicsmechanicssoftSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn physics_mechanics_soft_make_series(vals : Array[Double], name : String) -> PhysicsmechanicssoftSeries {
  { vals, name, meta: 0 }
}

pub fn physics_mechanics_soft_series_len(s : PhysicsmechanicssoftSeries) -> Int { s.vals.length() }

pub fn physics_mechanics_soft_series_sum(s : PhysicsmechanicssoftSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn physics_mechanics_soft_series_mean(s : PhysicsmechanicssoftSeries) -> Double {
  let n = physics_mechanics_soft_series_len(s)
  if n == 0 { 0.0 } else { physics_mechanics_soft_series_sum(s) / n.to_double() }
}

pub fn physics_mechanics_soft_series_min(s : PhysicsmechanicssoftSeries) -> Double {
  let n = physics_mechanics_soft_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn physics_mechanics_soft_series_max(s : PhysicsmechanicssoftSeries) -> Double {
  let n = physics_mechanics_soft_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn physics_mechanics_soft_series_range(s : PhysicsmechanicssoftSeries) -> Double {
  physics_mechanics_soft_series_max(s) - physics_mechanics_soft_series_min(s)
}

pub fn physics_mechanics_soft_series_var(s : PhysicsmechanicssoftSeries) -> Double {
  let n = physics_mechanics_soft_series_len(s)
  if n == 0 { 0.0 } else {
    let m = physics_mechanics_soft_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn physics_mechanics_soft_series_std(s : PhysicsmechanicssoftSeries) -> Double { @_common.sqrt(physics_mechanics_soft_series_var(s)) }

pub fn physics_mechanics_soft_series_median(s : PhysicsmechanicssoftSeries) -> Double {
  let n = physics_mechanics_soft_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = physics_mechanics_soft_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn physics_mechanics_soft_series_scale(s : PhysicsmechanicssoftSeries, f : Double) -> PhysicsmechanicssoftSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn physics_mechanics_soft_series_add(a : PhysicsmechanicssoftSeries, b : PhysicsmechanicssoftSeries) -> PhysicsmechanicssoftSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn physics_mechanics_soft_series_sub(a : PhysicsmechanicssoftSeries, b : PhysicsmechanicssoftSeries) -> PhysicsmechanicssoftSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn physics_mechanics_soft_series_normalize(s : PhysicsmechanicssoftSeries) -> PhysicsmechanicssoftSeries {
  let mn = physics_mechanics_soft_series_min(s)
  let mx = physics_mechanics_soft_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn physics_mechanics_soft_series_cumsum(s : PhysicsmechanicssoftSeries) -> PhysicsmechanicssoftSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn physics_mechanics_soft_series_to_string(s : PhysicsmechanicssoftSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct PhysicsmechanicssoftMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn physics_mechanics_soft_make_matrix(rows : Int, cols : Int, val : Double) -> PhysicsmechanicssoftMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn physics_mechanics_soft_matrix_identity(n : Int) -> PhysicsmechanicssoftMatrix {
  let m = physics_mechanics_soft_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn physics_mechanics_soft_matrix_get(m : PhysicsmechanicssoftMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn physics_mechanics_soft_matrix_transpose(m : PhysicsmechanicssoftMatrix) -> PhysicsmechanicssoftMatrix {
  let result = physics_mechanics_soft_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn physics_mechanics_soft_matrix_add(a : PhysicsmechanicssoftMatrix, b : PhysicsmechanicssoftMatrix) -> PhysicsmechanicssoftMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = physics_mechanics_soft_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn physics_mechanics_soft_matrix_scale(m : PhysicsmechanicssoftMatrix, s : Double) -> PhysicsmechanicssoftMatrix {
  let result = physics_mechanics_soft_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn physics_mechanics_soft_matrix_multiply(a : PhysicsmechanicssoftMatrix, b : PhysicsmechanicssoftMatrix) -> PhysicsmechanicssoftMatrix {
  if a.cols != b.rows { return physics_mechanics_soft_make_matrix(a.rows, b.cols, 0.0) }
  let result = physics_mechanics_soft_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn physics_mechanics_soft_matrix_trace(m : PhysicsmechanicssoftMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn physics_mechanics_soft_matrix_det(m : PhysicsmechanicssoftMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn physics_mechanics_soft_matrix_norm(m : PhysicsmechanicssoftMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn physics_mechanics_soft_matrix_to_string(m : PhysicsmechanicssoftMatrix) -> String {
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

pub(all) struct PhysicsmechanicssoftVector {
  comps : Array[Double]
  dim : Int
}

pub fn physics_mechanics_soft_make_vector(comps : Array[Double]) -> PhysicsmechanicssoftVector {
  { comps, dim: comps.length() }
}

pub fn physics_mechanics_soft_vector_zero(dim : Int) -> PhysicsmechanicssoftVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn physics_mechanics_soft_vector_add(a : PhysicsmechanicssoftVector, b : PhysicsmechanicssoftVector) -> PhysicsmechanicssoftVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn physics_mechanics_soft_vector_sub(a : PhysicsmechanicssoftVector, b : PhysicsmechanicssoftVector) -> PhysicsmechanicssoftVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn physics_mechanics_soft_vector_scale(v : PhysicsmechanicssoftVector, s : Double) -> PhysicsmechanicssoftVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn physics_mechanics_soft_vector_dot(a : PhysicsmechanicssoftVector, b : PhysicsmechanicssoftVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn physics_mechanics_soft_vector_norm(v : PhysicsmechanicssoftVector) -> Double { @_common.sqrt(physics_mechanics_soft_vector_dot(v, v)) }

pub fn physics_mechanics_soft_vector_normalize(v : PhysicsmechanicssoftVector) -> PhysicsmechanicssoftVector {
  let n = physics_mechanics_soft_vector_norm(v)
  if n < 0.0000001 { v } else { physics_mechanics_soft_vector_scale(v, 1.0 / n) }
}

pub fn physics_mechanics_soft_vector_dist(a : PhysicsmechanicssoftVector, b : PhysicsmechanicssoftVector) -> Double {
  physics_mechanics_soft_vector_norm(physics_mechanics_soft_vector_sub(a, b))
}

pub fn physics_mechanics_soft_vector_to_string(v : PhysicsmechanicssoftVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn physics_mechanics_soft_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn physics_mechanics_soft_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = physics_mechanics_soft_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn physics_mechanics_soft_std(data : Array[Double]) -> Double { @_common.sqrt(physics_mechanics_soft_var(data)) }

pub fn physics_mechanics_soft_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = physics_mechanics_soft_mean(a); let mb = physics_mechanics_soft_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn physics_mechanics_soft_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = physics_mechanics_soft_std(a); let sb = physics_mechanics_soft_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { physics_mechanics_soft_cov(a, b) / (sa * sb) }
}

pub fn physics_mechanics_soft_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = physics_mechanics_soft_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn physics_mechanics_soft_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn physics_mechanics_soft_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn physics_mechanics_soft_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  @_common.sqrt(physics_mechanics_soft_mse(pred, labels))
}

pub fn physics_mechanics_soft_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn physics_mechanics_soft_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = physics_mechanics_soft_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn physics_mechanics_soft_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn physics_mechanics_soft_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn physics_mechanics_soft_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = physics_mechanics_soft_precision(pred, labels, pos); let r = physics_mechanics_soft_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn physics_mechanics_soft_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn physics_mechanics_soft_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = physics_mechanics_soft_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn physics_mechanics_soft_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn physics_mechanics_soft_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn physics_mechanics_soft_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = physics_mechanics_soft_gcd(a, b)
    (a / g) * b
  }
}

pub fn physics_mechanics_soft_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn physics_mechanics_soft_fibonacci(n : Int) -> Int {
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

pub fn physics_mechanics_soft_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = physics_mechanics_soft_min(data); let mx = physics_mechanics_soft_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn physics_mechanics_soft_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = physics_mechanics_soft_mean(data); let sd = physics_mechanics_soft_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn physics_mechanics_soft_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn physics_mechanics_soft_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn physics_mechanics_soft_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn physics_mechanics_soft_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn physics_mechanics_soft_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn physics_mechanics_soft_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

pub(all) struct PhysicsmechanicssoftFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_soft_frame_make(size : Int) -> PhysicsmechanicssoftFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_soft_frame_len(s : PhysicsmechanicssoftFrame) -> Int { s.size }

pub fn physics_mechanics_soft_frame_get(s : PhysicsmechanicssoftFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_soft_frame_set(s : PhysicsmechanicssoftFrame, i : Int, v : Double) -> PhysicsmechanicssoftFrame {
  let result = physics_mechanics_soft_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_soft_frame_sum(s : PhysicsmechanicssoftFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_mechanics_soft_frame_mean(s : PhysicsmechanicssoftFrame) -> Double {
  if s.size == 0 { 0.0 } else { physics_mechanics_soft_frame_sum(s) / s.size.to_double() }
}

pub fn physics_mechanics_soft_frame_scale(s : PhysicsmechanicssoftFrame, f : Double) -> PhysicsmechanicssoftFrame {
  let result = physics_mechanics_soft_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_mechanics_soft_frame_add(a : PhysicsmechanicssoftFrame, b : PhysicsmechanicssoftFrame) -> PhysicsmechanicssoftFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_mechanics_soft_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_mechanics_soft_frame_copy(s : PhysicsmechanicssoftFrame) -> PhysicsmechanicssoftFrame {
  let result = physics_mechanics_soft_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_mechanics_soft_frame_fill(s : PhysicsmechanicssoftFrame, v : Double) -> PhysicsmechanicssoftFrame {
  let result = physics_mechanics_soft_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_soft_frame_min(s : PhysicsmechanicssoftFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_soft_frame_max(s : PhysicsmechanicssoftFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_soft_frame_to_string(s : PhysicsmechanicssoftFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicssoftTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_soft_table_make(size : Int) -> PhysicsmechanicssoftTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_soft_table_len(s : PhysicsmechanicssoftTable) -> Int { s.size }

pub fn physics_mechanics_soft_table_get(s : PhysicsmechanicssoftTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_soft_table_set(s : PhysicsmechanicssoftTable, i : Int, v : Double) -> PhysicsmechanicssoftTable {
  let result = physics_mechanics_soft_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_soft_table_sum(s : PhysicsmechanicssoftTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_mechanics_soft_table_mean(s : PhysicsmechanicssoftTable) -> Double {
  if s.size == 0 { 0.0 } else { physics_mechanics_soft_table_sum(s) / s.size.to_double() }
}

pub fn physics_mechanics_soft_table_scale(s : PhysicsmechanicssoftTable, f : Double) -> PhysicsmechanicssoftTable {
  let result = physics_mechanics_soft_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_mechanics_soft_table_add(a : PhysicsmechanicssoftTable, b : PhysicsmechanicssoftTable) -> PhysicsmechanicssoftTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_mechanics_soft_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_mechanics_soft_table_copy(s : PhysicsmechanicssoftTable) -> PhysicsmechanicssoftTable {
  let result = physics_mechanics_soft_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_mechanics_soft_table_fill(s : PhysicsmechanicssoftTable, v : Double) -> PhysicsmechanicssoftTable {
  let result = physics_mechanics_soft_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_soft_table_min(s : PhysicsmechanicssoftTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_soft_table_max(s : PhysicsmechanicssoftTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_soft_table_to_string(s : PhysicsmechanicssoftTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicssoftGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_soft_graphn_make(size : Int) -> PhysicsmechanicssoftGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_soft_graphn_len(s : PhysicsmechanicssoftGraphN) -> Int { s.size }

pub fn physics_mechanics_soft_graphn_get(s : PhysicsmechanicssoftGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_soft_graphn_set(s : PhysicsmechanicssoftGraphN, i : Int, v : Double) -> PhysicsmechanicssoftGraphN {
  let result = physics_mechanics_soft_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_soft_graphn_sum(s : PhysicsmechanicssoftGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_mechanics_soft_graphn_mean(s : PhysicsmechanicssoftGraphN) -> Double {
  if s.size == 0 { 0.0 } else { physics_mechanics_soft_graphn_sum(s) / s.size.to_double() }
}

pub fn physics_mechanics_soft_graphn_scale(s : PhysicsmechanicssoftGraphN, f : Double) -> PhysicsmechanicssoftGraphN {
  let result = physics_mechanics_soft_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_mechanics_soft_graphn_add(a : PhysicsmechanicssoftGraphN, b : PhysicsmechanicssoftGraphN) -> PhysicsmechanicssoftGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_mechanics_soft_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_mechanics_soft_graphn_copy(s : PhysicsmechanicssoftGraphN) -> PhysicsmechanicssoftGraphN {
  let result = physics_mechanics_soft_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_mechanics_soft_graphn_fill(s : PhysicsmechanicssoftGraphN, v : Double) -> PhysicsmechanicssoftGraphN {
  let result = physics_mechanics_soft_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_soft_graphn_min(s : PhysicsmechanicssoftGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_soft_graphn_max(s : PhysicsmechanicssoftGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_soft_graphn_to_string(s : PhysicsmechanicssoftGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicssoftNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_soft_node_make(size : Int) -> PhysicsmechanicssoftNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_soft_node_len(s : PhysicsmechanicssoftNode) -> Int { s.size }

pub fn physics_mechanics_soft_node_get(s : PhysicsmechanicssoftNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_soft_node_set(s : PhysicsmechanicssoftNode, i : Int, v : Double) -> PhysicsmechanicssoftNode {
  let result = physics_mechanics_soft_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_soft_node_sum(s : PhysicsmechanicssoftNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_mechanics_soft_node_mean(s : PhysicsmechanicssoftNode) -> Double {
  if s.size == 0 { 0.0 } else { physics_mechanics_soft_node_sum(s) / s.size.to_double() }
}

pub fn physics_mechanics_soft_node_scale(s : PhysicsmechanicssoftNode, f : Double) -> PhysicsmechanicssoftNode {
  let result = physics_mechanics_soft_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_mechanics_soft_node_add(a : PhysicsmechanicssoftNode, b : PhysicsmechanicssoftNode) -> PhysicsmechanicssoftNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_mechanics_soft_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_mechanics_soft_node_copy(s : PhysicsmechanicssoftNode) -> PhysicsmechanicssoftNode {
  let result = physics_mechanics_soft_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_mechanics_soft_node_fill(s : PhysicsmechanicssoftNode, v : Double) -> PhysicsmechanicssoftNode {
  let result = physics_mechanics_soft_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_soft_node_min(s : PhysicsmechanicssoftNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_soft_node_max(s : PhysicsmechanicssoftNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_soft_node_to_string(s : PhysicsmechanicssoftNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicssoftEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_soft_edge_make(size : Int) -> PhysicsmechanicssoftEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_soft_edge_len(s : PhysicsmechanicssoftEdge) -> Int { s.size }

pub fn physics_mechanics_soft_edge_get(s : PhysicsmechanicssoftEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_soft_edge_set(s : PhysicsmechanicssoftEdge, i : Int, v : Double) -> PhysicsmechanicssoftEdge {
  let result = physics_mechanics_soft_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_soft_edge_sum(s : PhysicsmechanicssoftEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_mechanics_soft_edge_mean(s : PhysicsmechanicssoftEdge) -> Double {
  if s.size == 0 { 0.0 } else { physics_mechanics_soft_edge_sum(s) / s.size.to_double() }
}

pub fn physics_mechanics_soft_edge_scale(s : PhysicsmechanicssoftEdge, f : Double) -> PhysicsmechanicssoftEdge {
  let result = physics_mechanics_soft_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_mechanics_soft_edge_add(a : PhysicsmechanicssoftEdge, b : PhysicsmechanicssoftEdge) -> PhysicsmechanicssoftEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_mechanics_soft_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_mechanics_soft_edge_copy(s : PhysicsmechanicssoftEdge) -> PhysicsmechanicssoftEdge {
  let result = physics_mechanics_soft_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_mechanics_soft_edge_fill(s : PhysicsmechanicssoftEdge, v : Double) -> PhysicsmechanicssoftEdge {
  let result = physics_mechanics_soft_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_soft_edge_min(s : PhysicsmechanicssoftEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_soft_edge_max(s : PhysicsmechanicssoftEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_soft_edge_to_string(s : PhysicsmechanicssoftEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicssoftPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_soft_path_make(size : Int) -> PhysicsmechanicssoftPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_soft_path_len(s : PhysicsmechanicssoftPath) -> Int { s.size }

pub fn physics_mechanics_soft_path_get(s : PhysicsmechanicssoftPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_soft_path_set(s : PhysicsmechanicssoftPath, i : Int, v : Double) -> PhysicsmechanicssoftPath {
  let result = physics_mechanics_soft_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_soft_path_sum(s : PhysicsmechanicssoftPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_mechanics_soft_path_mean(s : PhysicsmechanicssoftPath) -> Double {
  if s.size == 0 { 0.0 } else { physics_mechanics_soft_path_sum(s) / s.size.to_double() }
}

pub fn physics_mechanics_soft_path_scale(s : PhysicsmechanicssoftPath, f : Double) -> PhysicsmechanicssoftPath {
  let result = physics_mechanics_soft_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_mechanics_soft_path_add(a : PhysicsmechanicssoftPath, b : PhysicsmechanicssoftPath) -> PhysicsmechanicssoftPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_mechanics_soft_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_mechanics_soft_path_copy(s : PhysicsmechanicssoftPath) -> PhysicsmechanicssoftPath {
  let result = physics_mechanics_soft_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_mechanics_soft_path_fill(s : PhysicsmechanicssoftPath, v : Double) -> PhysicsmechanicssoftPath {
  let result = physics_mechanics_soft_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_soft_path_min(s : PhysicsmechanicssoftPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_soft_path_max(s : PhysicsmechanicssoftPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_soft_path_to_string(s : PhysicsmechanicssoftPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicssoftCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_soft_cluster_make(size : Int) -> PhysicsmechanicssoftCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_soft_cluster_len(s : PhysicsmechanicssoftCluster) -> Int { s.size }

pub fn physics_mechanics_soft_cluster_get(s : PhysicsmechanicssoftCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_soft_cluster_set(s : PhysicsmechanicssoftCluster, i : Int, v : Double) -> PhysicsmechanicssoftCluster {
  let result = physics_mechanics_soft_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_soft_cluster_sum(s : PhysicsmechanicssoftCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_mechanics_soft_cluster_mean(s : PhysicsmechanicssoftCluster) -> Double {
  if s.size == 0 { 0.0 } else { physics_mechanics_soft_cluster_sum(s) / s.size.to_double() }
}

pub fn physics_mechanics_soft_cluster_scale(s : PhysicsmechanicssoftCluster, f : Double) -> PhysicsmechanicssoftCluster {
  let result = physics_mechanics_soft_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_mechanics_soft_cluster_add(a : PhysicsmechanicssoftCluster, b : PhysicsmechanicssoftCluster) -> PhysicsmechanicssoftCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_mechanics_soft_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_mechanics_soft_cluster_copy(s : PhysicsmechanicssoftCluster) -> PhysicsmechanicssoftCluster {
  let result = physics_mechanics_soft_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_mechanics_soft_cluster_fill(s : PhysicsmechanicssoftCluster, v : Double) -> PhysicsmechanicssoftCluster {
  let result = physics_mechanics_soft_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_soft_cluster_min(s : PhysicsmechanicssoftCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_soft_cluster_max(s : PhysicsmechanicssoftCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_soft_cluster_to_string(s : PhysicsmechanicssoftCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicssoftModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_soft_model_make(size : Int) -> PhysicsmechanicssoftModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_soft_model_len(s : PhysicsmechanicssoftModel) -> Int { s.size }

pub fn physics_mechanics_soft_model_get(s : PhysicsmechanicssoftModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_soft_model_set(s : PhysicsmechanicssoftModel, i : Int, v : Double) -> PhysicsmechanicssoftModel {
  let result = physics_mechanics_soft_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_soft_model_sum(s : PhysicsmechanicssoftModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_mechanics_soft_model_mean(s : PhysicsmechanicssoftModel) -> Double {
  if s.size == 0 { 0.0 } else { physics_mechanics_soft_model_sum(s) / s.size.to_double() }
}

pub fn physics_mechanics_soft_model_scale(s : PhysicsmechanicssoftModel, f : Double) -> PhysicsmechanicssoftModel {
  let result = physics_mechanics_soft_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_mechanics_soft_model_add(a : PhysicsmechanicssoftModel, b : PhysicsmechanicssoftModel) -> PhysicsmechanicssoftModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_mechanics_soft_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_mechanics_soft_model_copy(s : PhysicsmechanicssoftModel) -> PhysicsmechanicssoftModel {
  let result = physics_mechanics_soft_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_mechanics_soft_model_fill(s : PhysicsmechanicssoftModel, v : Double) -> PhysicsmechanicssoftModel {
  let result = physics_mechanics_soft_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_soft_model_min(s : PhysicsmechanicssoftModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_soft_model_max(s : PhysicsmechanicssoftModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_soft_model_to_string(s : PhysicsmechanicssoftModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicssoftLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_soft_layer_make(size : Int) -> PhysicsmechanicssoftLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_soft_layer_len(s : PhysicsmechanicssoftLayer) -> Int { s.size }

pub fn physics_mechanics_soft_layer_get(s : PhysicsmechanicssoftLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_soft_layer_set(s : PhysicsmechanicssoftLayer, i : Int, v : Double) -> PhysicsmechanicssoftLayer {
  let result = physics_mechanics_soft_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_soft_layer_sum(s : PhysicsmechanicssoftLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_mechanics_soft_layer_mean(s : PhysicsmechanicssoftLayer) -> Double {
  if s.size == 0 { 0.0 } else { physics_mechanics_soft_layer_sum(s) / s.size.to_double() }
}

pub fn physics_mechanics_soft_layer_scale(s : PhysicsmechanicssoftLayer, f : Double) -> PhysicsmechanicssoftLayer {
  let result = physics_mechanics_soft_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_mechanics_soft_layer_add(a : PhysicsmechanicssoftLayer, b : PhysicsmechanicssoftLayer) -> PhysicsmechanicssoftLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_mechanics_soft_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_mechanics_soft_layer_copy(s : PhysicsmechanicssoftLayer) -> PhysicsmechanicssoftLayer {
  let result = physics_mechanics_soft_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_mechanics_soft_layer_fill(s : PhysicsmechanicssoftLayer, v : Double) -> PhysicsmechanicssoftLayer {
  let result = physics_mechanics_soft_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_soft_layer_min(s : PhysicsmechanicssoftLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_soft_layer_max(s : PhysicsmechanicssoftLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_soft_layer_to_string(s : PhysicsmechanicssoftLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicssoftBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_soft_buffer_make(size : Int) -> PhysicsmechanicssoftBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_soft_buffer_len(s : PhysicsmechanicssoftBuffer) -> Int { s.size }

pub fn physics_mechanics_soft_buffer_get(s : PhysicsmechanicssoftBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_soft_buffer_set(s : PhysicsmechanicssoftBuffer, i : Int, v : Double) -> PhysicsmechanicssoftBuffer {
  let result = physics_mechanics_soft_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_soft_buffer_sum(s : PhysicsmechanicssoftBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_mechanics_soft_buffer_mean(s : PhysicsmechanicssoftBuffer) -> Double {
  if s.size == 0 { 0.0 } else { physics_mechanics_soft_buffer_sum(s) / s.size.to_double() }
}

pub fn physics_mechanics_soft_buffer_scale(s : PhysicsmechanicssoftBuffer, f : Double) -> PhysicsmechanicssoftBuffer {
  let result = physics_mechanics_soft_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_mechanics_soft_buffer_add(a : PhysicsmechanicssoftBuffer, b : PhysicsmechanicssoftBuffer) -> PhysicsmechanicssoftBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_mechanics_soft_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_mechanics_soft_buffer_copy(s : PhysicsmechanicssoftBuffer) -> PhysicsmechanicssoftBuffer {
  let result = physics_mechanics_soft_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_mechanics_soft_buffer_fill(s : PhysicsmechanicssoftBuffer, v : Double) -> PhysicsmechanicssoftBuffer {
  let result = physics_mechanics_soft_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_soft_buffer_min(s : PhysicsmechanicssoftBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_soft_buffer_max(s : PhysicsmechanicssoftBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_soft_buffer_to_string(s : PhysicsmechanicssoftBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicssoftCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_soft_cursor_make(size : Int) -> PhysicsmechanicssoftCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_soft_cursor_len(s : PhysicsmechanicssoftCursor) -> Int { s.size }

pub fn physics_mechanics_soft_cursor_get(s : PhysicsmechanicssoftCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_soft_cursor_set(s : PhysicsmechanicssoftCursor, i : Int, v : Double) -> PhysicsmechanicssoftCursor {
  let result = physics_mechanics_soft_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_soft_cursor_sum(s : PhysicsmechanicssoftCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_mechanics_soft_cursor_mean(s : PhysicsmechanicssoftCursor) -> Double {
  if s.size == 0 { 0.0 } else { physics_mechanics_soft_cursor_sum(s) / s.size.to_double() }
}

pub fn physics_mechanics_soft_cursor_scale(s : PhysicsmechanicssoftCursor, f : Double) -> PhysicsmechanicssoftCursor {
  let result = physics_mechanics_soft_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_mechanics_soft_cursor_add(a : PhysicsmechanicssoftCursor, b : PhysicsmechanicssoftCursor) -> PhysicsmechanicssoftCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_mechanics_soft_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_mechanics_soft_cursor_copy(s : PhysicsmechanicssoftCursor) -> PhysicsmechanicssoftCursor {
  let result = physics_mechanics_soft_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_mechanics_soft_cursor_fill(s : PhysicsmechanicssoftCursor, v : Double) -> PhysicsmechanicssoftCursor {
  let result = physics_mechanics_soft_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_soft_cursor_min(s : PhysicsmechanicssoftCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_soft_cursor_max(s : PhysicsmechanicssoftCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_soft_cursor_to_string(s : PhysicsmechanicssoftCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicssoftView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_soft_view_make(size : Int) -> PhysicsmechanicssoftView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_soft_view_len(s : PhysicsmechanicssoftView) -> Int { s.size }

pub fn physics_mechanics_soft_view_get(s : PhysicsmechanicssoftView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_soft_view_set(s : PhysicsmechanicssoftView, i : Int, v : Double) -> PhysicsmechanicssoftView {
  let result = physics_mechanics_soft_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_soft_view_sum(s : PhysicsmechanicssoftView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_mechanics_soft_view_mean(s : PhysicsmechanicssoftView) -> Double {
  if s.size == 0 { 0.0 } else { physics_mechanics_soft_view_sum(s) / s.size.to_double() }
}

pub fn physics_mechanics_soft_view_scale(s : PhysicsmechanicssoftView, f : Double) -> PhysicsmechanicssoftView {
  let result = physics_mechanics_soft_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_mechanics_soft_view_add(a : PhysicsmechanicssoftView, b : PhysicsmechanicssoftView) -> PhysicsmechanicssoftView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_mechanics_soft_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_mechanics_soft_view_copy(s : PhysicsmechanicssoftView) -> PhysicsmechanicssoftView {
  let result = physics_mechanics_soft_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_mechanics_soft_view_fill(s : PhysicsmechanicssoftView, v : Double) -> PhysicsmechanicssoftView {
  let result = physics_mechanics_soft_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_soft_view_min(s : PhysicsmechanicssoftView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_soft_view_max(s : PhysicsmechanicssoftView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_soft_view_to_string(s : PhysicsmechanicssoftView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicssoftRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_soft_range_make(size : Int) -> PhysicsmechanicssoftRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_soft_range_len(s : PhysicsmechanicssoftRange) -> Int { s.size }

pub fn physics_mechanics_soft_range_get(s : PhysicsmechanicssoftRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_soft_range_set(s : PhysicsmechanicssoftRange, i : Int, v : Double) -> PhysicsmechanicssoftRange {
  let result = physics_mechanics_soft_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_soft_range_sum(s : PhysicsmechanicssoftRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_mechanics_soft_range_mean(s : PhysicsmechanicssoftRange) -> Double {
  if s.size == 0 { 0.0 } else { physics_mechanics_soft_range_sum(s) / s.size.to_double() }
}

pub fn physics_mechanics_soft_range_scale(s : PhysicsmechanicssoftRange, f : Double) -> PhysicsmechanicssoftRange {
  let result = physics_mechanics_soft_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_mechanics_soft_range_add(a : PhysicsmechanicssoftRange, b : PhysicsmechanicssoftRange) -> PhysicsmechanicssoftRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_mechanics_soft_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_mechanics_soft_range_copy(s : PhysicsmechanicssoftRange) -> PhysicsmechanicssoftRange {
  let result = physics_mechanics_soft_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_mechanics_soft_range_fill(s : PhysicsmechanicssoftRange, v : Double) -> PhysicsmechanicssoftRange {
  let result = physics_mechanics_soft_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_soft_range_min(s : PhysicsmechanicssoftRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_soft_range_max(s : PhysicsmechanicssoftRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_soft_range_to_string(s : PhysicsmechanicssoftRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicssoftSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_soft_slice_make(size : Int) -> PhysicsmechanicssoftSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_soft_slice_len(s : PhysicsmechanicssoftSlice) -> Int { s.size }

pub fn physics_mechanics_soft_slice_get(s : PhysicsmechanicssoftSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_soft_slice_set(s : PhysicsmechanicssoftSlice, i : Int, v : Double) -> PhysicsmechanicssoftSlice {
  let result = physics_mechanics_soft_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_soft_slice_sum(s : PhysicsmechanicssoftSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_mechanics_soft_slice_mean(s : PhysicsmechanicssoftSlice) -> Double {
  if s.size == 0 { 0.0 } else { physics_mechanics_soft_slice_sum(s) / s.size.to_double() }
}

pub fn physics_mechanics_soft_slice_scale(s : PhysicsmechanicssoftSlice, f : Double) -> PhysicsmechanicssoftSlice {
  let result = physics_mechanics_soft_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_mechanics_soft_slice_add(a : PhysicsmechanicssoftSlice, b : PhysicsmechanicssoftSlice) -> PhysicsmechanicssoftSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_mechanics_soft_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_mechanics_soft_slice_copy(s : PhysicsmechanicssoftSlice) -> PhysicsmechanicssoftSlice {
  let result = physics_mechanics_soft_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_mechanics_soft_slice_fill(s : PhysicsmechanicssoftSlice, v : Double) -> PhysicsmechanicssoftSlice {
  let result = physics_mechanics_soft_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_soft_slice_min(s : PhysicsmechanicssoftSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_soft_slice_max(s : PhysicsmechanicssoftSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_soft_slice_to_string(s : PhysicsmechanicssoftSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

