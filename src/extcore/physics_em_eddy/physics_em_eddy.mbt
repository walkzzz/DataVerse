///===
/// extcore/physics_em_eddy

pub(all) struct PhysicsemeddyPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn physics_em_eddy_make_point(x : Double, y : Double) -> PhysicsemeddyPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn physics_em_eddy_make_point3(x : Double, y : Double, z : Double) -> PhysicsemeddyPoint {
  { x, y, z, label: 0 }
}

pub fn physics_em_eddy_point_x(pt : PhysicsemeddyPoint) -> Double { pt.x }

pub fn physics_em_eddy_point_y(pt : PhysicsemeddyPoint) -> Double { pt.y }

pub fn physics_em_eddy_point_z(pt : PhysicsemeddyPoint) -> Double { pt.z }

pub fn physics_em_eddy_point_label(pt : PhysicsemeddyPoint) -> Int { pt.label }

pub fn physics_em_eddy_point_dist(a : PhysicsemeddyPoint, b : PhysicsemeddyPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn physics_em_eddy_point_add(a : PhysicsemeddyPoint, b : PhysicsemeddyPoint) -> PhysicsemeddyPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn physics_em_eddy_point_sub(a : PhysicsemeddyPoint, b : PhysicsemeddyPoint) -> PhysicsemeddyPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn physics_em_eddy_point_scale(pt : PhysicsemeddyPoint, s : Double) -> PhysicsemeddyPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn physics_em_eddy_point_dot(a : PhysicsemeddyPoint, b : PhysicsemeddyPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn physics_em_eddy_point_cross(a : PhysicsemeddyPoint, b : PhysicsemeddyPoint) -> PhysicsemeddyPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn physics_em_eddy_point_norm(pt : PhysicsemeddyPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn physics_em_eddy_point_normalize(pt : PhysicsemeddyPoint) -> PhysicsemeddyPoint {
  let n = physics_em_eddy_point_norm(pt)
  if n < 0.0000001 { pt } else { physics_em_eddy_point_scale(pt, 1.0 / n) }
}

pub fn physics_em_eddy_point_negate(pt : PhysicsemeddyPoint) -> PhysicsemeddyPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn physics_em_eddy_point_mid(a : PhysicsemeddyPoint, b : PhysicsemeddyPoint) -> PhysicsemeddyPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn physics_em_eddy_point_lerp(a : PhysicsemeddyPoint, b : PhysicsemeddyPoint, t : Double) -> PhysicsemeddyPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn physics_em_eddy_point_to_string(pt : PhysicsemeddyPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct PhysicsemeddySeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn physics_em_eddy_make_series(vals : Array[Double], name : String) -> PhysicsemeddySeries {
  { vals, name, meta: 0 }
}

pub fn physics_em_eddy_series_len(s : PhysicsemeddySeries) -> Int { s.vals.length() }

pub fn physics_em_eddy_series_sum(s : PhysicsemeddySeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn physics_em_eddy_series_mean(s : PhysicsemeddySeries) -> Double {
  let n = physics_em_eddy_series_len(s)
  if n == 0 { 0.0 } else { physics_em_eddy_series_sum(s) / n.to_double() }
}

pub fn physics_em_eddy_series_min(s : PhysicsemeddySeries) -> Double {
  let n = physics_em_eddy_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn physics_em_eddy_series_max(s : PhysicsemeddySeries) -> Double {
  let n = physics_em_eddy_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn physics_em_eddy_series_range(s : PhysicsemeddySeries) -> Double {
  physics_em_eddy_series_max(s) - physics_em_eddy_series_min(s)
}

pub fn physics_em_eddy_series_var(s : PhysicsemeddySeries) -> Double {
  let n = physics_em_eddy_series_len(s)
  if n == 0 { 0.0 } else {
    let m = physics_em_eddy_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn physics_em_eddy_series_std(s : PhysicsemeddySeries) -> Double { @_common.sqrt(physics_em_eddy_series_var(s)) }

pub fn physics_em_eddy_series_median(s : PhysicsemeddySeries) -> Double {
  let n = physics_em_eddy_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = physics_em_eddy_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn physics_em_eddy_series_scale(s : PhysicsemeddySeries, f : Double) -> PhysicsemeddySeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn physics_em_eddy_series_add(a : PhysicsemeddySeries, b : PhysicsemeddySeries) -> PhysicsemeddySeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn physics_em_eddy_series_sub(a : PhysicsemeddySeries, b : PhysicsemeddySeries) -> PhysicsemeddySeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn physics_em_eddy_series_normalize(s : PhysicsemeddySeries) -> PhysicsemeddySeries {
  let mn = physics_em_eddy_series_min(s)
  let mx = physics_em_eddy_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn physics_em_eddy_series_cumsum(s : PhysicsemeddySeries) -> PhysicsemeddySeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn physics_em_eddy_series_to_string(s : PhysicsemeddySeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct PhysicsemeddyMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn physics_em_eddy_make_matrix(rows : Int, cols : Int, val : Double) -> PhysicsemeddyMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn physics_em_eddy_matrix_identity(n : Int) -> PhysicsemeddyMatrix {
  let m = physics_em_eddy_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn physics_em_eddy_matrix_get(m : PhysicsemeddyMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn physics_em_eddy_matrix_transpose(m : PhysicsemeddyMatrix) -> PhysicsemeddyMatrix {
  let result = physics_em_eddy_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn physics_em_eddy_matrix_add(a : PhysicsemeddyMatrix, b : PhysicsemeddyMatrix) -> PhysicsemeddyMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = physics_em_eddy_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn physics_em_eddy_matrix_scale(m : PhysicsemeddyMatrix, s : Double) -> PhysicsemeddyMatrix {
  let result = physics_em_eddy_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn physics_em_eddy_matrix_multiply(a : PhysicsemeddyMatrix, b : PhysicsemeddyMatrix) -> PhysicsemeddyMatrix {
  if a.cols != b.rows { return physics_em_eddy_make_matrix(a.rows, b.cols, 0.0) }
  let result = physics_em_eddy_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn physics_em_eddy_matrix_trace(m : PhysicsemeddyMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn physics_em_eddy_matrix_det(m : PhysicsemeddyMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn physics_em_eddy_matrix_norm(m : PhysicsemeddyMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn physics_em_eddy_matrix_to_string(m : PhysicsemeddyMatrix) -> String {
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

pub(all) struct PhysicsemeddyVector {
  comps : Array[Double]
  dim : Int
}

pub fn physics_em_eddy_make_vector(comps : Array[Double]) -> PhysicsemeddyVector {
  { comps, dim: comps.length() }
}

pub fn physics_em_eddy_vector_zero(dim : Int) -> PhysicsemeddyVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn physics_em_eddy_vector_add(a : PhysicsemeddyVector, b : PhysicsemeddyVector) -> PhysicsemeddyVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn physics_em_eddy_vector_sub(a : PhysicsemeddyVector, b : PhysicsemeddyVector) -> PhysicsemeddyVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn physics_em_eddy_vector_scale(v : PhysicsemeddyVector, s : Double) -> PhysicsemeddyVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn physics_em_eddy_vector_dot(a : PhysicsemeddyVector, b : PhysicsemeddyVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn physics_em_eddy_vector_norm(v : PhysicsemeddyVector) -> Double { @_common.sqrt(physics_em_eddy_vector_dot(v, v)) }

pub fn physics_em_eddy_vector_normalize(v : PhysicsemeddyVector) -> PhysicsemeddyVector {
  let n = physics_em_eddy_vector_norm(v)
  if n < 0.0000001 { v } else { physics_em_eddy_vector_scale(v, 1.0 / n) }
}

pub fn physics_em_eddy_vector_dist(a : PhysicsemeddyVector, b : PhysicsemeddyVector) -> Double {
  physics_em_eddy_vector_norm(physics_em_eddy_vector_sub(a, b))
}

pub fn physics_em_eddy_vector_to_string(v : PhysicsemeddyVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn physics_em_eddy_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn physics_em_eddy_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = physics_em_eddy_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn physics_em_eddy_std(data : Array[Double]) -> Double { @_common.sqrt(physics_em_eddy_var(data)) }

pub fn physics_em_eddy_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = physics_em_eddy_mean(a); let mb = physics_em_eddy_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn physics_em_eddy_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = physics_em_eddy_std(a); let sb = physics_em_eddy_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { physics_em_eddy_cov(a, b) / (sa * sb) }
}

pub fn physics_em_eddy_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = physics_em_eddy_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn physics_em_eddy_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn physics_em_eddy_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn physics_em_eddy_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  @_common.sqrt(physics_em_eddy_mse(pred, labels))
}

pub fn physics_em_eddy_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn physics_em_eddy_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = physics_em_eddy_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn physics_em_eddy_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn physics_em_eddy_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn physics_em_eddy_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = physics_em_eddy_precision(pred, labels, pos); let r = physics_em_eddy_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn physics_em_eddy_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn physics_em_eddy_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = physics_em_eddy_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn physics_em_eddy_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn physics_em_eddy_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn physics_em_eddy_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = physics_em_eddy_gcd(a, b)
    (a / g) * b
  }
}

pub fn physics_em_eddy_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn physics_em_eddy_fibonacci(n : Int) -> Int {
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

pub fn physics_em_eddy_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = physics_em_eddy_min(data); let mx = physics_em_eddy_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn physics_em_eddy_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = physics_em_eddy_mean(data); let sd = physics_em_eddy_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn physics_em_eddy_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn physics_em_eddy_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn physics_em_eddy_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn physics_em_eddy_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn physics_em_eddy_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn physics_em_eddy_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

pub(all) struct PhysicsemeddyFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_eddy_frame_make(size : Int) -> PhysicsemeddyFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_eddy_frame_len(s : PhysicsemeddyFrame) -> Int { s.size }

pub fn physics_em_eddy_frame_get(s : PhysicsemeddyFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_eddy_frame_set(s : PhysicsemeddyFrame, i : Int, v : Double) -> PhysicsemeddyFrame {
  let result = physics_em_eddy_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_em_eddy_frame_sum(s : PhysicsemeddyFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_em_eddy_frame_mean(s : PhysicsemeddyFrame) -> Double {
  if s.size == 0 { 0.0 } else { physics_em_eddy_frame_sum(s) / s.size.to_double() }
}

pub fn physics_em_eddy_frame_scale(s : PhysicsemeddyFrame, f : Double) -> PhysicsemeddyFrame {
  let result = physics_em_eddy_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_em_eddy_frame_add(a : PhysicsemeddyFrame, b : PhysicsemeddyFrame) -> PhysicsemeddyFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_em_eddy_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_em_eddy_frame_copy(s : PhysicsemeddyFrame) -> PhysicsemeddyFrame {
  let result = physics_em_eddy_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_em_eddy_frame_fill(s : PhysicsemeddyFrame, v : Double) -> PhysicsemeddyFrame {
  let result = physics_em_eddy_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_em_eddy_frame_min(s : PhysicsemeddyFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_em_eddy_frame_max(s : PhysicsemeddyFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_em_eddy_frame_to_string(s : PhysicsemeddyFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemeddyTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_eddy_table_make(size : Int) -> PhysicsemeddyTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_eddy_table_len(s : PhysicsemeddyTable) -> Int { s.size }

pub fn physics_em_eddy_table_get(s : PhysicsemeddyTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_eddy_table_set(s : PhysicsemeddyTable, i : Int, v : Double) -> PhysicsemeddyTable {
  let result = physics_em_eddy_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_em_eddy_table_sum(s : PhysicsemeddyTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_em_eddy_table_mean(s : PhysicsemeddyTable) -> Double {
  if s.size == 0 { 0.0 } else { physics_em_eddy_table_sum(s) / s.size.to_double() }
}

pub fn physics_em_eddy_table_scale(s : PhysicsemeddyTable, f : Double) -> PhysicsemeddyTable {
  let result = physics_em_eddy_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_em_eddy_table_add(a : PhysicsemeddyTable, b : PhysicsemeddyTable) -> PhysicsemeddyTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_em_eddy_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_em_eddy_table_copy(s : PhysicsemeddyTable) -> PhysicsemeddyTable {
  let result = physics_em_eddy_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_em_eddy_table_fill(s : PhysicsemeddyTable, v : Double) -> PhysicsemeddyTable {
  let result = physics_em_eddy_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_em_eddy_table_min(s : PhysicsemeddyTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_em_eddy_table_max(s : PhysicsemeddyTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_em_eddy_table_to_string(s : PhysicsemeddyTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemeddyGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_eddy_graphn_make(size : Int) -> PhysicsemeddyGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_eddy_graphn_len(s : PhysicsemeddyGraphN) -> Int { s.size }

pub fn physics_em_eddy_graphn_get(s : PhysicsemeddyGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_eddy_graphn_set(s : PhysicsemeddyGraphN, i : Int, v : Double) -> PhysicsemeddyGraphN {
  let result = physics_em_eddy_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_em_eddy_graphn_sum(s : PhysicsemeddyGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_em_eddy_graphn_mean(s : PhysicsemeddyGraphN) -> Double {
  if s.size == 0 { 0.0 } else { physics_em_eddy_graphn_sum(s) / s.size.to_double() }
}

pub fn physics_em_eddy_graphn_scale(s : PhysicsemeddyGraphN, f : Double) -> PhysicsemeddyGraphN {
  let result = physics_em_eddy_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_em_eddy_graphn_add(a : PhysicsemeddyGraphN, b : PhysicsemeddyGraphN) -> PhysicsemeddyGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_em_eddy_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_em_eddy_graphn_copy(s : PhysicsemeddyGraphN) -> PhysicsemeddyGraphN {
  let result = physics_em_eddy_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_em_eddy_graphn_fill(s : PhysicsemeddyGraphN, v : Double) -> PhysicsemeddyGraphN {
  let result = physics_em_eddy_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_em_eddy_graphn_min(s : PhysicsemeddyGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_em_eddy_graphn_max(s : PhysicsemeddyGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_em_eddy_graphn_to_string(s : PhysicsemeddyGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemeddyNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_eddy_node_make(size : Int) -> PhysicsemeddyNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_eddy_node_len(s : PhysicsemeddyNode) -> Int { s.size }

pub fn physics_em_eddy_node_get(s : PhysicsemeddyNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_eddy_node_set(s : PhysicsemeddyNode, i : Int, v : Double) -> PhysicsemeddyNode {
  let result = physics_em_eddy_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_em_eddy_node_sum(s : PhysicsemeddyNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_em_eddy_node_mean(s : PhysicsemeddyNode) -> Double {
  if s.size == 0 { 0.0 } else { physics_em_eddy_node_sum(s) / s.size.to_double() }
}

pub fn physics_em_eddy_node_scale(s : PhysicsemeddyNode, f : Double) -> PhysicsemeddyNode {
  let result = physics_em_eddy_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_em_eddy_node_add(a : PhysicsemeddyNode, b : PhysicsemeddyNode) -> PhysicsemeddyNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_em_eddy_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_em_eddy_node_copy(s : PhysicsemeddyNode) -> PhysicsemeddyNode {
  let result = physics_em_eddy_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_em_eddy_node_fill(s : PhysicsemeddyNode, v : Double) -> PhysicsemeddyNode {
  let result = physics_em_eddy_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_em_eddy_node_min(s : PhysicsemeddyNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_em_eddy_node_max(s : PhysicsemeddyNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_em_eddy_node_to_string(s : PhysicsemeddyNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemeddyEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_eddy_edge_make(size : Int) -> PhysicsemeddyEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_eddy_edge_len(s : PhysicsemeddyEdge) -> Int { s.size }

pub fn physics_em_eddy_edge_get(s : PhysicsemeddyEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_eddy_edge_set(s : PhysicsemeddyEdge, i : Int, v : Double) -> PhysicsemeddyEdge {
  let result = physics_em_eddy_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_em_eddy_edge_sum(s : PhysicsemeddyEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_em_eddy_edge_mean(s : PhysicsemeddyEdge) -> Double {
  if s.size == 0 { 0.0 } else { physics_em_eddy_edge_sum(s) / s.size.to_double() }
}

pub fn physics_em_eddy_edge_scale(s : PhysicsemeddyEdge, f : Double) -> PhysicsemeddyEdge {
  let result = physics_em_eddy_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_em_eddy_edge_add(a : PhysicsemeddyEdge, b : PhysicsemeddyEdge) -> PhysicsemeddyEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_em_eddy_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_em_eddy_edge_copy(s : PhysicsemeddyEdge) -> PhysicsemeddyEdge {
  let result = physics_em_eddy_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_em_eddy_edge_fill(s : PhysicsemeddyEdge, v : Double) -> PhysicsemeddyEdge {
  let result = physics_em_eddy_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_em_eddy_edge_min(s : PhysicsemeddyEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_em_eddy_edge_max(s : PhysicsemeddyEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_em_eddy_edge_to_string(s : PhysicsemeddyEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemeddyPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_eddy_path_make(size : Int) -> PhysicsemeddyPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_eddy_path_len(s : PhysicsemeddyPath) -> Int { s.size }

pub fn physics_em_eddy_path_get(s : PhysicsemeddyPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_eddy_path_set(s : PhysicsemeddyPath, i : Int, v : Double) -> PhysicsemeddyPath {
  let result = physics_em_eddy_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_em_eddy_path_sum(s : PhysicsemeddyPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_em_eddy_path_mean(s : PhysicsemeddyPath) -> Double {
  if s.size == 0 { 0.0 } else { physics_em_eddy_path_sum(s) / s.size.to_double() }
}

pub fn physics_em_eddy_path_scale(s : PhysicsemeddyPath, f : Double) -> PhysicsemeddyPath {
  let result = physics_em_eddy_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_em_eddy_path_add(a : PhysicsemeddyPath, b : PhysicsemeddyPath) -> PhysicsemeddyPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_em_eddy_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_em_eddy_path_copy(s : PhysicsemeddyPath) -> PhysicsemeddyPath {
  let result = physics_em_eddy_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_em_eddy_path_fill(s : PhysicsemeddyPath, v : Double) -> PhysicsemeddyPath {
  let result = physics_em_eddy_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_em_eddy_path_min(s : PhysicsemeddyPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_em_eddy_path_max(s : PhysicsemeddyPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_em_eddy_path_to_string(s : PhysicsemeddyPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemeddyCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_eddy_cluster_make(size : Int) -> PhysicsemeddyCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_eddy_cluster_len(s : PhysicsemeddyCluster) -> Int { s.size }

pub fn physics_em_eddy_cluster_get(s : PhysicsemeddyCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_eddy_cluster_set(s : PhysicsemeddyCluster, i : Int, v : Double) -> PhysicsemeddyCluster {
  let result = physics_em_eddy_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_em_eddy_cluster_sum(s : PhysicsemeddyCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_em_eddy_cluster_mean(s : PhysicsemeddyCluster) -> Double {
  if s.size == 0 { 0.0 } else { physics_em_eddy_cluster_sum(s) / s.size.to_double() }
}

pub fn physics_em_eddy_cluster_scale(s : PhysicsemeddyCluster, f : Double) -> PhysicsemeddyCluster {
  let result = physics_em_eddy_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_em_eddy_cluster_add(a : PhysicsemeddyCluster, b : PhysicsemeddyCluster) -> PhysicsemeddyCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_em_eddy_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_em_eddy_cluster_copy(s : PhysicsemeddyCluster) -> PhysicsemeddyCluster {
  let result = physics_em_eddy_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_em_eddy_cluster_fill(s : PhysicsemeddyCluster, v : Double) -> PhysicsemeddyCluster {
  let result = physics_em_eddy_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_em_eddy_cluster_min(s : PhysicsemeddyCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_em_eddy_cluster_max(s : PhysicsemeddyCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_em_eddy_cluster_to_string(s : PhysicsemeddyCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemeddyModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_eddy_model_make(size : Int) -> PhysicsemeddyModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_eddy_model_len(s : PhysicsemeddyModel) -> Int { s.size }

pub fn physics_em_eddy_model_get(s : PhysicsemeddyModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_eddy_model_set(s : PhysicsemeddyModel, i : Int, v : Double) -> PhysicsemeddyModel {
  let result = physics_em_eddy_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_em_eddy_model_sum(s : PhysicsemeddyModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_em_eddy_model_mean(s : PhysicsemeddyModel) -> Double {
  if s.size == 0 { 0.0 } else { physics_em_eddy_model_sum(s) / s.size.to_double() }
}

pub fn physics_em_eddy_model_scale(s : PhysicsemeddyModel, f : Double) -> PhysicsemeddyModel {
  let result = physics_em_eddy_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_em_eddy_model_add(a : PhysicsemeddyModel, b : PhysicsemeddyModel) -> PhysicsemeddyModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_em_eddy_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_em_eddy_model_copy(s : PhysicsemeddyModel) -> PhysicsemeddyModel {
  let result = physics_em_eddy_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_em_eddy_model_fill(s : PhysicsemeddyModel, v : Double) -> PhysicsemeddyModel {
  let result = physics_em_eddy_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_em_eddy_model_min(s : PhysicsemeddyModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_em_eddy_model_max(s : PhysicsemeddyModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_em_eddy_model_to_string(s : PhysicsemeddyModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemeddyLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_eddy_layer_make(size : Int) -> PhysicsemeddyLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_eddy_layer_len(s : PhysicsemeddyLayer) -> Int { s.size }

pub fn physics_em_eddy_layer_get(s : PhysicsemeddyLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_eddy_layer_set(s : PhysicsemeddyLayer, i : Int, v : Double) -> PhysicsemeddyLayer {
  let result = physics_em_eddy_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_em_eddy_layer_sum(s : PhysicsemeddyLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_em_eddy_layer_mean(s : PhysicsemeddyLayer) -> Double {
  if s.size == 0 { 0.0 } else { physics_em_eddy_layer_sum(s) / s.size.to_double() }
}

pub fn physics_em_eddy_layer_scale(s : PhysicsemeddyLayer, f : Double) -> PhysicsemeddyLayer {
  let result = physics_em_eddy_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_em_eddy_layer_add(a : PhysicsemeddyLayer, b : PhysicsemeddyLayer) -> PhysicsemeddyLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_em_eddy_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_em_eddy_layer_copy(s : PhysicsemeddyLayer) -> PhysicsemeddyLayer {
  let result = physics_em_eddy_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_em_eddy_layer_fill(s : PhysicsemeddyLayer, v : Double) -> PhysicsemeddyLayer {
  let result = physics_em_eddy_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_em_eddy_layer_min(s : PhysicsemeddyLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_em_eddy_layer_max(s : PhysicsemeddyLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_em_eddy_layer_to_string(s : PhysicsemeddyLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemeddyBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_eddy_buffer_make(size : Int) -> PhysicsemeddyBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_eddy_buffer_len(s : PhysicsemeddyBuffer) -> Int { s.size }

pub fn physics_em_eddy_buffer_get(s : PhysicsemeddyBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_eddy_buffer_set(s : PhysicsemeddyBuffer, i : Int, v : Double) -> PhysicsemeddyBuffer {
  let result = physics_em_eddy_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_em_eddy_buffer_sum(s : PhysicsemeddyBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_em_eddy_buffer_mean(s : PhysicsemeddyBuffer) -> Double {
  if s.size == 0 { 0.0 } else { physics_em_eddy_buffer_sum(s) / s.size.to_double() }
}

pub fn physics_em_eddy_buffer_scale(s : PhysicsemeddyBuffer, f : Double) -> PhysicsemeddyBuffer {
  let result = physics_em_eddy_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_em_eddy_buffer_add(a : PhysicsemeddyBuffer, b : PhysicsemeddyBuffer) -> PhysicsemeddyBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_em_eddy_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_em_eddy_buffer_copy(s : PhysicsemeddyBuffer) -> PhysicsemeddyBuffer {
  let result = physics_em_eddy_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_em_eddy_buffer_fill(s : PhysicsemeddyBuffer, v : Double) -> PhysicsemeddyBuffer {
  let result = physics_em_eddy_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_em_eddy_buffer_min(s : PhysicsemeddyBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_em_eddy_buffer_max(s : PhysicsemeddyBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_em_eddy_buffer_to_string(s : PhysicsemeddyBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemeddyCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_eddy_cursor_make(size : Int) -> PhysicsemeddyCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_eddy_cursor_len(s : PhysicsemeddyCursor) -> Int { s.size }

pub fn physics_em_eddy_cursor_get(s : PhysicsemeddyCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_eddy_cursor_set(s : PhysicsemeddyCursor, i : Int, v : Double) -> PhysicsemeddyCursor {
  let result = physics_em_eddy_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_em_eddy_cursor_sum(s : PhysicsemeddyCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_em_eddy_cursor_mean(s : PhysicsemeddyCursor) -> Double {
  if s.size == 0 { 0.0 } else { physics_em_eddy_cursor_sum(s) / s.size.to_double() }
}

pub fn physics_em_eddy_cursor_scale(s : PhysicsemeddyCursor, f : Double) -> PhysicsemeddyCursor {
  let result = physics_em_eddy_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_em_eddy_cursor_add(a : PhysicsemeddyCursor, b : PhysicsemeddyCursor) -> PhysicsemeddyCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_em_eddy_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_em_eddy_cursor_copy(s : PhysicsemeddyCursor) -> PhysicsemeddyCursor {
  let result = physics_em_eddy_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_em_eddy_cursor_fill(s : PhysicsemeddyCursor, v : Double) -> PhysicsemeddyCursor {
  let result = physics_em_eddy_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_em_eddy_cursor_min(s : PhysicsemeddyCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_em_eddy_cursor_max(s : PhysicsemeddyCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_em_eddy_cursor_to_string(s : PhysicsemeddyCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemeddyView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_eddy_view_make(size : Int) -> PhysicsemeddyView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_eddy_view_len(s : PhysicsemeddyView) -> Int { s.size }

pub fn physics_em_eddy_view_get(s : PhysicsemeddyView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_eddy_view_set(s : PhysicsemeddyView, i : Int, v : Double) -> PhysicsemeddyView {
  let result = physics_em_eddy_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_em_eddy_view_sum(s : PhysicsemeddyView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_em_eddy_view_mean(s : PhysicsemeddyView) -> Double {
  if s.size == 0 { 0.0 } else { physics_em_eddy_view_sum(s) / s.size.to_double() }
}

pub fn physics_em_eddy_view_scale(s : PhysicsemeddyView, f : Double) -> PhysicsemeddyView {
  let result = physics_em_eddy_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_em_eddy_view_add(a : PhysicsemeddyView, b : PhysicsemeddyView) -> PhysicsemeddyView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_em_eddy_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_em_eddy_view_copy(s : PhysicsemeddyView) -> PhysicsemeddyView {
  let result = physics_em_eddy_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_em_eddy_view_fill(s : PhysicsemeddyView, v : Double) -> PhysicsemeddyView {
  let result = physics_em_eddy_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_em_eddy_view_min(s : PhysicsemeddyView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_em_eddy_view_max(s : PhysicsemeddyView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_em_eddy_view_to_string(s : PhysicsemeddyView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemeddyRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_eddy_range_make(size : Int) -> PhysicsemeddyRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_eddy_range_len(s : PhysicsemeddyRange) -> Int { s.size }

pub fn physics_em_eddy_range_get(s : PhysicsemeddyRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_eddy_range_set(s : PhysicsemeddyRange, i : Int, v : Double) -> PhysicsemeddyRange {
  let result = physics_em_eddy_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_em_eddy_range_sum(s : PhysicsemeddyRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_em_eddy_range_mean(s : PhysicsemeddyRange) -> Double {
  if s.size == 0 { 0.0 } else { physics_em_eddy_range_sum(s) / s.size.to_double() }
}

pub fn physics_em_eddy_range_scale(s : PhysicsemeddyRange, f : Double) -> PhysicsemeddyRange {
  let result = physics_em_eddy_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_em_eddy_range_add(a : PhysicsemeddyRange, b : PhysicsemeddyRange) -> PhysicsemeddyRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_em_eddy_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_em_eddy_range_copy(s : PhysicsemeddyRange) -> PhysicsemeddyRange {
  let result = physics_em_eddy_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_em_eddy_range_fill(s : PhysicsemeddyRange, v : Double) -> PhysicsemeddyRange {
  let result = physics_em_eddy_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_em_eddy_range_min(s : PhysicsemeddyRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_em_eddy_range_max(s : PhysicsemeddyRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_em_eddy_range_to_string(s : PhysicsemeddyRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemeddySlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_eddy_slice_make(size : Int) -> PhysicsemeddySlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_eddy_slice_len(s : PhysicsemeddySlice) -> Int { s.size }

pub fn physics_em_eddy_slice_get(s : PhysicsemeddySlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_eddy_slice_set(s : PhysicsemeddySlice, i : Int, v : Double) -> PhysicsemeddySlice {
  let result = physics_em_eddy_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_em_eddy_slice_sum(s : PhysicsemeddySlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_em_eddy_slice_mean(s : PhysicsemeddySlice) -> Double {
  if s.size == 0 { 0.0 } else { physics_em_eddy_slice_sum(s) / s.size.to_double() }
}

pub fn physics_em_eddy_slice_scale(s : PhysicsemeddySlice, f : Double) -> PhysicsemeddySlice {
  let result = physics_em_eddy_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_em_eddy_slice_add(a : PhysicsemeddySlice, b : PhysicsemeddySlice) -> PhysicsemeddySlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_em_eddy_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_em_eddy_slice_copy(s : PhysicsemeddySlice) -> PhysicsemeddySlice {
  let result = physics_em_eddy_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_em_eddy_slice_fill(s : PhysicsemeddySlice, v : Double) -> PhysicsemeddySlice {
  let result = physics_em_eddy_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_em_eddy_slice_min(s : PhysicsemeddySlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_em_eddy_slice_max(s : PhysicsemeddySlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_em_eddy_slice_to_string(s : PhysicsemeddySlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

