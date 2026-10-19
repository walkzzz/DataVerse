///===
/// extcore/physics_em_fem

pub(all) struct PhysicsemfemPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn physics_em_fem_make_point(x : Double, y : Double) -> PhysicsemfemPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn physics_em_fem_make_point3(x : Double, y : Double, z : Double) -> PhysicsemfemPoint {
  { x, y, z, label: 0 }
}

pub fn physics_em_fem_point_x(pt : PhysicsemfemPoint) -> Double { pt.x }

pub fn physics_em_fem_point_y(pt : PhysicsemfemPoint) -> Double { pt.y }

pub fn physics_em_fem_point_z(pt : PhysicsemfemPoint) -> Double { pt.z }

pub fn physics_em_fem_point_label(pt : PhysicsemfemPoint) -> Int { pt.label }

pub fn physics_em_fem_point_dist(a : PhysicsemfemPoint, b : PhysicsemfemPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  physics_em_fem_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn physics_em_fem_point_add(a : PhysicsemfemPoint, b : PhysicsemfemPoint) -> PhysicsemfemPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn physics_em_fem_point_sub(a : PhysicsemfemPoint, b : PhysicsemfemPoint) -> PhysicsemfemPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn physics_em_fem_point_scale(pt : PhysicsemfemPoint, s : Double) -> PhysicsemfemPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn physics_em_fem_point_dot(a : PhysicsemfemPoint, b : PhysicsemfemPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn physics_em_fem_point_cross(a : PhysicsemfemPoint, b : PhysicsemfemPoint) -> PhysicsemfemPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn physics_em_fem_point_norm(pt : PhysicsemfemPoint) -> Double {
  physics_em_fem_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn physics_em_fem_point_normalize(pt : PhysicsemfemPoint) -> PhysicsemfemPoint {
  let n = physics_em_fem_point_norm(pt)
  if n < 0.0000001 { pt } else { physics_em_fem_point_scale(pt, 1.0 / n) }
}

pub fn physics_em_fem_point_negate(pt : PhysicsemfemPoint) -> PhysicsemfemPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn physics_em_fem_point_mid(a : PhysicsemfemPoint, b : PhysicsemfemPoint) -> PhysicsemfemPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn physics_em_fem_point_lerp(a : PhysicsemfemPoint, b : PhysicsemfemPoint, t : Double) -> PhysicsemfemPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn physics_em_fem_point_to_string(pt : PhysicsemfemPoint) -> String {
  "(" + physics_em_fem_dbl(pt.x) + ", " + physics_em_fem_dbl(pt.y) + ", " + physics_em_fem_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct PhysicsemfemSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn physics_em_fem_make_series(vals : Array[Double], name : String) -> PhysicsemfemSeries {
  { vals, name, meta: 0 }
}

pub fn physics_em_fem_series_len(s : PhysicsemfemSeries) -> Int { s.vals.length() }

pub fn physics_em_fem_series_sum(s : PhysicsemfemSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn physics_em_fem_series_mean(s : PhysicsemfemSeries) -> Double {
  let n = physics_em_fem_series_len(s)
  if n == 0 { 0.0 } else { physics_em_fem_series_sum(s) / n.to_double() }
}

pub fn physics_em_fem_series_min(s : PhysicsemfemSeries) -> Double {
  let n = physics_em_fem_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn physics_em_fem_series_max(s : PhysicsemfemSeries) -> Double {
  let n = physics_em_fem_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn physics_em_fem_series_range(s : PhysicsemfemSeries) -> Double {
  physics_em_fem_series_max(s) - physics_em_fem_series_min(s)
}

pub fn physics_em_fem_series_var(s : PhysicsemfemSeries) -> Double {
  let n = physics_em_fem_series_len(s)
  if n == 0 { 0.0 } else {
    let m = physics_em_fem_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn physics_em_fem_series_std(s : PhysicsemfemSeries) -> Double { physics_em_fem_sqrt(physics_em_fem_series_var(s)) }

pub fn physics_em_fem_series_median(s : PhysicsemfemSeries) -> Double {
  let n = physics_em_fem_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = physics_em_fem_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn physics_em_fem_series_scale(s : PhysicsemfemSeries, f : Double) -> PhysicsemfemSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = physics_em_fem_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn physics_em_fem_series_add(a : PhysicsemfemSeries, b : PhysicsemfemSeries) -> PhysicsemfemSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = physics_em_fem_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn physics_em_fem_series_sub(a : PhysicsemfemSeries, b : PhysicsemfemSeries) -> PhysicsemfemSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = physics_em_fem_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn physics_em_fem_series_normalize(s : PhysicsemfemSeries) -> PhysicsemfemSeries {
  let mn = physics_em_fem_series_min(s)
  let mx = physics_em_fem_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = physics_em_fem_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn physics_em_fem_series_cumsum(s : PhysicsemfemSeries) -> PhysicsemfemSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = physics_em_fem_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn physics_em_fem_series_to_string(s : PhysicsemfemSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + physics_em_fem_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct PhysicsemfemMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn physics_em_fem_make_matrix(rows : Int, cols : Int, val : Double) -> PhysicsemfemMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn physics_em_fem_matrix_identity(n : Int) -> PhysicsemfemMatrix {
  let m = physics_em_fem_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn physics_em_fem_matrix_get(m : PhysicsemfemMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn physics_em_fem_matrix_transpose(m : PhysicsemfemMatrix) -> PhysicsemfemMatrix {
  let result = physics_em_fem_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn physics_em_fem_matrix_add(a : PhysicsemfemMatrix, b : PhysicsemfemMatrix) -> PhysicsemfemMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = physics_em_fem_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn physics_em_fem_matrix_scale(m : PhysicsemfemMatrix, s : Double) -> PhysicsemfemMatrix {
  let result = physics_em_fem_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn physics_em_fem_matrix_multiply(a : PhysicsemfemMatrix, b : PhysicsemfemMatrix) -> PhysicsemfemMatrix {
  if a.cols != b.rows { return physics_em_fem_make_matrix(a.rows, b.cols, 0.0) }
  let result = physics_em_fem_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn physics_em_fem_matrix_trace(m : PhysicsemfemMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn physics_em_fem_matrix_det(m : PhysicsemfemMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn physics_em_fem_matrix_norm(m : PhysicsemfemMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  physics_em_fem_sqrt(sum)
}

pub fn physics_em_fem_matrix_to_string(m : PhysicsemfemMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + physics_em_fem_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct PhysicsemfemVector {
  comps : Array[Double]
  dim : Int
}

pub fn physics_em_fem_make_vector(comps : Array[Double]) -> PhysicsemfemVector {
  { comps, dim: comps.length() }
}

pub fn physics_em_fem_vector_zero(dim : Int) -> PhysicsemfemVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn physics_em_fem_vector_add(a : PhysicsemfemVector, b : PhysicsemfemVector) -> PhysicsemfemVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = physics_em_fem_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn physics_em_fem_vector_sub(a : PhysicsemfemVector, b : PhysicsemfemVector) -> PhysicsemfemVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = physics_em_fem_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn physics_em_fem_vector_scale(v : PhysicsemfemVector, s : Double) -> PhysicsemfemVector {
  let mut result = []
  for i in 0..<v.dim { result = physics_em_fem_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn physics_em_fem_vector_dot(a : PhysicsemfemVector, b : PhysicsemfemVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn physics_em_fem_vector_norm(v : PhysicsemfemVector) -> Double { physics_em_fem_sqrt(physics_em_fem_vector_dot(v, v)) }

pub fn physics_em_fem_vector_normalize(v : PhysicsemfemVector) -> PhysicsemfemVector {
  let n = physics_em_fem_vector_norm(v)
  if n < 0.0000001 { v } else { physics_em_fem_vector_scale(v, 1.0 / n) }
}

pub fn physics_em_fem_vector_dist(a : PhysicsemfemVector, b : PhysicsemfemVector) -> Double {
  physics_em_fem_vector_norm(physics_em_fem_vector_sub(a, b))
}

pub fn physics_em_fem_vector_to_string(v : PhysicsemfemVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + physics_em_fem_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn physics_em_fem_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn physics_em_fem_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = physics_em_fem_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn physics_em_fem_std(data : Array[Double]) -> Double { physics_em_fem_sqrt(physics_em_fem_var(data)) }

pub fn physics_em_fem_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = physics_em_fem_mean(a); let mb = physics_em_fem_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn physics_em_fem_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = physics_em_fem_std(a); let sb = physics_em_fem_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { physics_em_fem_cov(a, b) / (sa * sb) }
}

pub fn physics_em_fem_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = physics_em_fem_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn physics_em_fem_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn physics_em_fem_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn physics_em_fem_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  physics_em_fem_sqrt(physics_em_fem_mse(pred, labels))
}

pub fn physics_em_fem_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + physics_em_fem_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn physics_em_fem_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = physics_em_fem_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn physics_em_fem_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn physics_em_fem_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn physics_em_fem_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = physics_em_fem_precision(pred, labels, pos); let r = physics_em_fem_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn physics_em_fem_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn physics_em_fem_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = physics_em_fem_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn physics_em_fem_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn physics_em_fem_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn physics_em_fem_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = physics_em_fem_gcd(a, b)
    (a / g) * b
  }
}

pub fn physics_em_fem_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn physics_em_fem_fibonacci(n : Int) -> Int {
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

pub fn physics_em_fem_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = physics_em_fem_min(data); let mx = physics_em_fem_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn physics_em_fem_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = physics_em_fem_mean(data); let sd = physics_em_fem_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn physics_em_fem_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn physics_em_fem_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn physics_em_fem_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn physics_em_fem_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn physics_em_fem_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn physics_em_fem_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn physics_em_fem_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn physics_em_fem_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn physics_em_fem_dbl(x : Double) -> String {
  let i = if x >= 0.0 { physics_em_fem_int(x) } else { -physics_em_fem_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { physics_em_fem_int(f * 1000000.0) } else { physics_em_fem_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn physics_em_fem_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn physics_em_fem_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct PhysicsemfemFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_fem_frame_make(size : Int) -> PhysicsemfemFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_fem_frame_len(s : PhysicsemfemFrame) -> Int { s.size }

pub fn physics_em_fem_frame_get(s : PhysicsemfemFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_fem_frame_set(s : PhysicsemfemFrame, i : Int, v : Double) -> PhysicsemfemFrame {
  let result = physics_em_fem_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_em_fem_frame_sum(s : PhysicsemfemFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_em_fem_frame_mean(s : PhysicsemfemFrame) -> Double {
  if s.size == 0 { 0.0 } else { physics_em_fem_frame_sum(s) / s.size.to_double() }
}

pub fn physics_em_fem_frame_scale(s : PhysicsemfemFrame, f : Double) -> PhysicsemfemFrame {
  let result = physics_em_fem_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_em_fem_frame_add(a : PhysicsemfemFrame, b : PhysicsemfemFrame) -> PhysicsemfemFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_em_fem_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_em_fem_frame_copy(s : PhysicsemfemFrame) -> PhysicsemfemFrame {
  let result = physics_em_fem_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_em_fem_frame_fill(s : PhysicsemfemFrame, v : Double) -> PhysicsemfemFrame {
  let result = physics_em_fem_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_em_fem_frame_min(s : PhysicsemfemFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_em_fem_frame_max(s : PhysicsemfemFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_em_fem_frame_to_string(s : PhysicsemfemFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemfemTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_fem_table_make(size : Int) -> PhysicsemfemTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_fem_table_len(s : PhysicsemfemTable) -> Int { s.size }

pub fn physics_em_fem_table_get(s : PhysicsemfemTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_fem_table_set(s : PhysicsemfemTable, i : Int, v : Double) -> PhysicsemfemTable {
  let result = physics_em_fem_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_em_fem_table_sum(s : PhysicsemfemTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_em_fem_table_mean(s : PhysicsemfemTable) -> Double {
  if s.size == 0 { 0.0 } else { physics_em_fem_table_sum(s) / s.size.to_double() }
}

pub fn physics_em_fem_table_scale(s : PhysicsemfemTable, f : Double) -> PhysicsemfemTable {
  let result = physics_em_fem_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_em_fem_table_add(a : PhysicsemfemTable, b : PhysicsemfemTable) -> PhysicsemfemTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_em_fem_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_em_fem_table_copy(s : PhysicsemfemTable) -> PhysicsemfemTable {
  let result = physics_em_fem_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_em_fem_table_fill(s : PhysicsemfemTable, v : Double) -> PhysicsemfemTable {
  let result = physics_em_fem_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_em_fem_table_min(s : PhysicsemfemTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_em_fem_table_max(s : PhysicsemfemTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_em_fem_table_to_string(s : PhysicsemfemTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemfemGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_fem_graphn_make(size : Int) -> PhysicsemfemGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_fem_graphn_len(s : PhysicsemfemGraphN) -> Int { s.size }

pub fn physics_em_fem_graphn_get(s : PhysicsemfemGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_fem_graphn_set(s : PhysicsemfemGraphN, i : Int, v : Double) -> PhysicsemfemGraphN {
  let result = physics_em_fem_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_em_fem_graphn_sum(s : PhysicsemfemGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_em_fem_graphn_mean(s : PhysicsemfemGraphN) -> Double {
  if s.size == 0 { 0.0 } else { physics_em_fem_graphn_sum(s) / s.size.to_double() }
}

pub fn physics_em_fem_graphn_scale(s : PhysicsemfemGraphN, f : Double) -> PhysicsemfemGraphN {
  let result = physics_em_fem_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_em_fem_graphn_add(a : PhysicsemfemGraphN, b : PhysicsemfemGraphN) -> PhysicsemfemGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_em_fem_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_em_fem_graphn_copy(s : PhysicsemfemGraphN) -> PhysicsemfemGraphN {
  let result = physics_em_fem_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_em_fem_graphn_fill(s : PhysicsemfemGraphN, v : Double) -> PhysicsemfemGraphN {
  let result = physics_em_fem_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_em_fem_graphn_min(s : PhysicsemfemGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_em_fem_graphn_max(s : PhysicsemfemGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_em_fem_graphn_to_string(s : PhysicsemfemGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemfemNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_fem_node_make(size : Int) -> PhysicsemfemNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_fem_node_len(s : PhysicsemfemNode) -> Int { s.size }

pub fn physics_em_fem_node_get(s : PhysicsemfemNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_fem_node_set(s : PhysicsemfemNode, i : Int, v : Double) -> PhysicsemfemNode {
  let result = physics_em_fem_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_em_fem_node_sum(s : PhysicsemfemNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_em_fem_node_mean(s : PhysicsemfemNode) -> Double {
  if s.size == 0 { 0.0 } else { physics_em_fem_node_sum(s) / s.size.to_double() }
}

pub fn physics_em_fem_node_scale(s : PhysicsemfemNode, f : Double) -> PhysicsemfemNode {
  let result = physics_em_fem_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_em_fem_node_add(a : PhysicsemfemNode, b : PhysicsemfemNode) -> PhysicsemfemNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_em_fem_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_em_fem_node_copy(s : PhysicsemfemNode) -> PhysicsemfemNode {
  let result = physics_em_fem_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_em_fem_node_fill(s : PhysicsemfemNode, v : Double) -> PhysicsemfemNode {
  let result = physics_em_fem_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_em_fem_node_min(s : PhysicsemfemNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_em_fem_node_max(s : PhysicsemfemNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_em_fem_node_to_string(s : PhysicsemfemNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemfemEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_fem_edge_make(size : Int) -> PhysicsemfemEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_fem_edge_len(s : PhysicsemfemEdge) -> Int { s.size }

pub fn physics_em_fem_edge_get(s : PhysicsemfemEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_fem_edge_set(s : PhysicsemfemEdge, i : Int, v : Double) -> PhysicsemfemEdge {
  let result = physics_em_fem_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_em_fem_edge_sum(s : PhysicsemfemEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_em_fem_edge_mean(s : PhysicsemfemEdge) -> Double {
  if s.size == 0 { 0.0 } else { physics_em_fem_edge_sum(s) / s.size.to_double() }
}

pub fn physics_em_fem_edge_scale(s : PhysicsemfemEdge, f : Double) -> PhysicsemfemEdge {
  let result = physics_em_fem_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_em_fem_edge_add(a : PhysicsemfemEdge, b : PhysicsemfemEdge) -> PhysicsemfemEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_em_fem_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_em_fem_edge_copy(s : PhysicsemfemEdge) -> PhysicsemfemEdge {
  let result = physics_em_fem_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_em_fem_edge_fill(s : PhysicsemfemEdge, v : Double) -> PhysicsemfemEdge {
  let result = physics_em_fem_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_em_fem_edge_min(s : PhysicsemfemEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_em_fem_edge_max(s : PhysicsemfemEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_em_fem_edge_to_string(s : PhysicsemfemEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemfemPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_fem_path_make(size : Int) -> PhysicsemfemPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_fem_path_len(s : PhysicsemfemPath) -> Int { s.size }

pub fn physics_em_fem_path_get(s : PhysicsemfemPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_fem_path_set(s : PhysicsemfemPath, i : Int, v : Double) -> PhysicsemfemPath {
  let result = physics_em_fem_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_em_fem_path_sum(s : PhysicsemfemPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_em_fem_path_mean(s : PhysicsemfemPath) -> Double {
  if s.size == 0 { 0.0 } else { physics_em_fem_path_sum(s) / s.size.to_double() }
}

pub fn physics_em_fem_path_scale(s : PhysicsemfemPath, f : Double) -> PhysicsemfemPath {
  let result = physics_em_fem_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_em_fem_path_add(a : PhysicsemfemPath, b : PhysicsemfemPath) -> PhysicsemfemPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_em_fem_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_em_fem_path_copy(s : PhysicsemfemPath) -> PhysicsemfemPath {
  let result = physics_em_fem_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_em_fem_path_fill(s : PhysicsemfemPath, v : Double) -> PhysicsemfemPath {
  let result = physics_em_fem_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_em_fem_path_min(s : PhysicsemfemPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_em_fem_path_max(s : PhysicsemfemPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_em_fem_path_to_string(s : PhysicsemfemPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemfemCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_fem_cluster_make(size : Int) -> PhysicsemfemCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_fem_cluster_len(s : PhysicsemfemCluster) -> Int { s.size }

pub fn physics_em_fem_cluster_get(s : PhysicsemfemCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_fem_cluster_set(s : PhysicsemfemCluster, i : Int, v : Double) -> PhysicsemfemCluster {
  let result = physics_em_fem_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_em_fem_cluster_sum(s : PhysicsemfemCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_em_fem_cluster_mean(s : PhysicsemfemCluster) -> Double {
  if s.size == 0 { 0.0 } else { physics_em_fem_cluster_sum(s) / s.size.to_double() }
}

pub fn physics_em_fem_cluster_scale(s : PhysicsemfemCluster, f : Double) -> PhysicsemfemCluster {
  let result = physics_em_fem_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_em_fem_cluster_add(a : PhysicsemfemCluster, b : PhysicsemfemCluster) -> PhysicsemfemCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_em_fem_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_em_fem_cluster_copy(s : PhysicsemfemCluster) -> PhysicsemfemCluster {
  let result = physics_em_fem_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_em_fem_cluster_fill(s : PhysicsemfemCluster, v : Double) -> PhysicsemfemCluster {
  let result = physics_em_fem_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_em_fem_cluster_min(s : PhysicsemfemCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_em_fem_cluster_max(s : PhysicsemfemCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_em_fem_cluster_to_string(s : PhysicsemfemCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemfemModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_fem_model_make(size : Int) -> PhysicsemfemModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_fem_model_len(s : PhysicsemfemModel) -> Int { s.size }

pub fn physics_em_fem_model_get(s : PhysicsemfemModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_fem_model_set(s : PhysicsemfemModel, i : Int, v : Double) -> PhysicsemfemModel {
  let result = physics_em_fem_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_em_fem_model_sum(s : PhysicsemfemModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_em_fem_model_mean(s : PhysicsemfemModel) -> Double {
  if s.size == 0 { 0.0 } else { physics_em_fem_model_sum(s) / s.size.to_double() }
}

pub fn physics_em_fem_model_scale(s : PhysicsemfemModel, f : Double) -> PhysicsemfemModel {
  let result = physics_em_fem_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_em_fem_model_add(a : PhysicsemfemModel, b : PhysicsemfemModel) -> PhysicsemfemModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_em_fem_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_em_fem_model_copy(s : PhysicsemfemModel) -> PhysicsemfemModel {
  let result = physics_em_fem_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_em_fem_model_fill(s : PhysicsemfemModel, v : Double) -> PhysicsemfemModel {
  let result = physics_em_fem_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_em_fem_model_min(s : PhysicsemfemModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_em_fem_model_max(s : PhysicsemfemModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_em_fem_model_to_string(s : PhysicsemfemModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemfemLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_fem_layer_make(size : Int) -> PhysicsemfemLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_fem_layer_len(s : PhysicsemfemLayer) -> Int { s.size }

pub fn physics_em_fem_layer_get(s : PhysicsemfemLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_fem_layer_set(s : PhysicsemfemLayer, i : Int, v : Double) -> PhysicsemfemLayer {
  let result = physics_em_fem_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_em_fem_layer_sum(s : PhysicsemfemLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_em_fem_layer_mean(s : PhysicsemfemLayer) -> Double {
  if s.size == 0 { 0.0 } else { physics_em_fem_layer_sum(s) / s.size.to_double() }
}

pub fn physics_em_fem_layer_scale(s : PhysicsemfemLayer, f : Double) -> PhysicsemfemLayer {
  let result = physics_em_fem_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_em_fem_layer_add(a : PhysicsemfemLayer, b : PhysicsemfemLayer) -> PhysicsemfemLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_em_fem_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_em_fem_layer_copy(s : PhysicsemfemLayer) -> PhysicsemfemLayer {
  let result = physics_em_fem_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_em_fem_layer_fill(s : PhysicsemfemLayer, v : Double) -> PhysicsemfemLayer {
  let result = physics_em_fem_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_em_fem_layer_min(s : PhysicsemfemLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_em_fem_layer_max(s : PhysicsemfemLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_em_fem_layer_to_string(s : PhysicsemfemLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemfemBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_fem_buffer_make(size : Int) -> PhysicsemfemBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_fem_buffer_len(s : PhysicsemfemBuffer) -> Int { s.size }

pub fn physics_em_fem_buffer_get(s : PhysicsemfemBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_fem_buffer_set(s : PhysicsemfemBuffer, i : Int, v : Double) -> PhysicsemfemBuffer {
  let result = physics_em_fem_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_em_fem_buffer_sum(s : PhysicsemfemBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_em_fem_buffer_mean(s : PhysicsemfemBuffer) -> Double {
  if s.size == 0 { 0.0 } else { physics_em_fem_buffer_sum(s) / s.size.to_double() }
}

pub fn physics_em_fem_buffer_scale(s : PhysicsemfemBuffer, f : Double) -> PhysicsemfemBuffer {
  let result = physics_em_fem_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_em_fem_buffer_add(a : PhysicsemfemBuffer, b : PhysicsemfemBuffer) -> PhysicsemfemBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_em_fem_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_em_fem_buffer_copy(s : PhysicsemfemBuffer) -> PhysicsemfemBuffer {
  let result = physics_em_fem_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_em_fem_buffer_fill(s : PhysicsemfemBuffer, v : Double) -> PhysicsemfemBuffer {
  let result = physics_em_fem_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_em_fem_buffer_min(s : PhysicsemfemBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_em_fem_buffer_max(s : PhysicsemfemBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_em_fem_buffer_to_string(s : PhysicsemfemBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemfemCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_fem_cursor_make(size : Int) -> PhysicsemfemCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_fem_cursor_len(s : PhysicsemfemCursor) -> Int { s.size }

pub fn physics_em_fem_cursor_get(s : PhysicsemfemCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_fem_cursor_set(s : PhysicsemfemCursor, i : Int, v : Double) -> PhysicsemfemCursor {
  let result = physics_em_fem_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_em_fem_cursor_sum(s : PhysicsemfemCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_em_fem_cursor_mean(s : PhysicsemfemCursor) -> Double {
  if s.size == 0 { 0.0 } else { physics_em_fem_cursor_sum(s) / s.size.to_double() }
}

pub fn physics_em_fem_cursor_scale(s : PhysicsemfemCursor, f : Double) -> PhysicsemfemCursor {
  let result = physics_em_fem_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_em_fem_cursor_add(a : PhysicsemfemCursor, b : PhysicsemfemCursor) -> PhysicsemfemCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_em_fem_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_em_fem_cursor_copy(s : PhysicsemfemCursor) -> PhysicsemfemCursor {
  let result = physics_em_fem_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_em_fem_cursor_fill(s : PhysicsemfemCursor, v : Double) -> PhysicsemfemCursor {
  let result = physics_em_fem_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_em_fem_cursor_min(s : PhysicsemfemCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_em_fem_cursor_max(s : PhysicsemfemCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_em_fem_cursor_to_string(s : PhysicsemfemCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemfemView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_fem_view_make(size : Int) -> PhysicsemfemView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_fem_view_len(s : PhysicsemfemView) -> Int { s.size }

pub fn physics_em_fem_view_get(s : PhysicsemfemView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_fem_view_set(s : PhysicsemfemView, i : Int, v : Double) -> PhysicsemfemView {
  let result = physics_em_fem_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_em_fem_view_sum(s : PhysicsemfemView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_em_fem_view_mean(s : PhysicsemfemView) -> Double {
  if s.size == 0 { 0.0 } else { physics_em_fem_view_sum(s) / s.size.to_double() }
}

pub fn physics_em_fem_view_scale(s : PhysicsemfemView, f : Double) -> PhysicsemfemView {
  let result = physics_em_fem_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_em_fem_view_add(a : PhysicsemfemView, b : PhysicsemfemView) -> PhysicsemfemView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_em_fem_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_em_fem_view_copy(s : PhysicsemfemView) -> PhysicsemfemView {
  let result = physics_em_fem_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_em_fem_view_fill(s : PhysicsemfemView, v : Double) -> PhysicsemfemView {
  let result = physics_em_fem_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_em_fem_view_min(s : PhysicsemfemView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_em_fem_view_max(s : PhysicsemfemView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_em_fem_view_to_string(s : PhysicsemfemView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemfemRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_fem_range_make(size : Int) -> PhysicsemfemRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_fem_range_len(s : PhysicsemfemRange) -> Int { s.size }

pub fn physics_em_fem_range_get(s : PhysicsemfemRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_fem_range_set(s : PhysicsemfemRange, i : Int, v : Double) -> PhysicsemfemRange {
  let result = physics_em_fem_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_em_fem_range_sum(s : PhysicsemfemRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_em_fem_range_mean(s : PhysicsemfemRange) -> Double {
  if s.size == 0 { 0.0 } else { physics_em_fem_range_sum(s) / s.size.to_double() }
}

pub fn physics_em_fem_range_scale(s : PhysicsemfemRange, f : Double) -> PhysicsemfemRange {
  let result = physics_em_fem_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_em_fem_range_add(a : PhysicsemfemRange, b : PhysicsemfemRange) -> PhysicsemfemRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_em_fem_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_em_fem_range_copy(s : PhysicsemfemRange) -> PhysicsemfemRange {
  let result = physics_em_fem_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_em_fem_range_fill(s : PhysicsemfemRange, v : Double) -> PhysicsemfemRange {
  let result = physics_em_fem_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_em_fem_range_min(s : PhysicsemfemRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_em_fem_range_max(s : PhysicsemfemRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_em_fem_range_to_string(s : PhysicsemfemRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemfemSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_fem_slice_make(size : Int) -> PhysicsemfemSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_fem_slice_len(s : PhysicsemfemSlice) -> Int { s.size }

pub fn physics_em_fem_slice_get(s : PhysicsemfemSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_fem_slice_set(s : PhysicsemfemSlice, i : Int, v : Double) -> PhysicsemfemSlice {
  let result = physics_em_fem_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_em_fem_slice_sum(s : PhysicsemfemSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_em_fem_slice_mean(s : PhysicsemfemSlice) -> Double {
  if s.size == 0 { 0.0 } else { physics_em_fem_slice_sum(s) / s.size.to_double() }
}

pub fn physics_em_fem_slice_scale(s : PhysicsemfemSlice, f : Double) -> PhysicsemfemSlice {
  let result = physics_em_fem_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_em_fem_slice_add(a : PhysicsemfemSlice, b : PhysicsemfemSlice) -> PhysicsemfemSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_em_fem_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_em_fem_slice_copy(s : PhysicsemfemSlice) -> PhysicsemfemSlice {
  let result = physics_em_fem_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_em_fem_slice_fill(s : PhysicsemfemSlice, v : Double) -> PhysicsemfemSlice {
  let result = physics_em_fem_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_em_fem_slice_min(s : PhysicsemfemSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_em_fem_slice_max(s : PhysicsemfemSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_em_fem_slice_to_string(s : PhysicsemfemSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn physics_em_fem_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_em_fem_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_em_fem_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_em_fem_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_em_fem_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_em_fem_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_em_fem_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_em_fem_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_em_fem_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_em_fem_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_em_fem_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_em_fem_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_em_fem_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_em_fem_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_em_fem_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_em_fem_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_em_fem_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_em_fem_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_em_fem_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_em_fem_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_em_fem_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_em_fem_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_em_fem_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_em_fem_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_em_fem_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

