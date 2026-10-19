///===
/// extcore/physics_heat_radiation

pub(all) struct PhysicsheatradiationPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn physics_heat_radiation_make_point(x : Double, y : Double) -> PhysicsheatradiationPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn physics_heat_radiation_make_point3(x : Double, y : Double, z : Double) -> PhysicsheatradiationPoint {
  { x, y, z, label: 0 }
}

pub fn physics_heat_radiation_point_x(pt : PhysicsheatradiationPoint) -> Double { pt.x }

pub fn physics_heat_radiation_point_y(pt : PhysicsheatradiationPoint) -> Double { pt.y }

pub fn physics_heat_radiation_point_z(pt : PhysicsheatradiationPoint) -> Double { pt.z }

pub fn physics_heat_radiation_point_label(pt : PhysicsheatradiationPoint) -> Int { pt.label }

pub fn physics_heat_radiation_point_dist(a : PhysicsheatradiationPoint, b : PhysicsheatradiationPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  physics_heat_radiation_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn physics_heat_radiation_point_add(a : PhysicsheatradiationPoint, b : PhysicsheatradiationPoint) -> PhysicsheatradiationPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn physics_heat_radiation_point_sub(a : PhysicsheatradiationPoint, b : PhysicsheatradiationPoint) -> PhysicsheatradiationPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn physics_heat_radiation_point_scale(pt : PhysicsheatradiationPoint, s : Double) -> PhysicsheatradiationPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn physics_heat_radiation_point_dot(a : PhysicsheatradiationPoint, b : PhysicsheatradiationPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn physics_heat_radiation_point_cross(a : PhysicsheatradiationPoint, b : PhysicsheatradiationPoint) -> PhysicsheatradiationPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn physics_heat_radiation_point_norm(pt : PhysicsheatradiationPoint) -> Double {
  physics_heat_radiation_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn physics_heat_radiation_point_normalize(pt : PhysicsheatradiationPoint) -> PhysicsheatradiationPoint {
  let n = physics_heat_radiation_point_norm(pt)
  if n < 0.0000001 { pt } else { physics_heat_radiation_point_scale(pt, 1.0 / n) }
}

pub fn physics_heat_radiation_point_negate(pt : PhysicsheatradiationPoint) -> PhysicsheatradiationPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn physics_heat_radiation_point_mid(a : PhysicsheatradiationPoint, b : PhysicsheatradiationPoint) -> PhysicsheatradiationPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn physics_heat_radiation_point_lerp(a : PhysicsheatradiationPoint, b : PhysicsheatradiationPoint, t : Double) -> PhysicsheatradiationPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn physics_heat_radiation_point_to_string(pt : PhysicsheatradiationPoint) -> String {
  "(" + physics_heat_radiation_dbl(pt.x) + ", " + physics_heat_radiation_dbl(pt.y) + ", " + physics_heat_radiation_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct PhysicsheatradiationSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn physics_heat_radiation_make_series(vals : Array[Double], name : String) -> PhysicsheatradiationSeries {
  { vals, name, meta: 0 }
}

pub fn physics_heat_radiation_series_len(s : PhysicsheatradiationSeries) -> Int { s.vals.length() }

pub fn physics_heat_radiation_series_sum(s : PhysicsheatradiationSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn physics_heat_radiation_series_mean(s : PhysicsheatradiationSeries) -> Double {
  let n = physics_heat_radiation_series_len(s)
  if n == 0 { 0.0 } else { physics_heat_radiation_series_sum(s) / n.to_double() }
}

pub fn physics_heat_radiation_series_min(s : PhysicsheatradiationSeries) -> Double {
  let n = physics_heat_radiation_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn physics_heat_radiation_series_max(s : PhysicsheatradiationSeries) -> Double {
  let n = physics_heat_radiation_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn physics_heat_radiation_series_range(s : PhysicsheatradiationSeries) -> Double {
  physics_heat_radiation_series_max(s) - physics_heat_radiation_series_min(s)
}

pub fn physics_heat_radiation_series_var(s : PhysicsheatradiationSeries) -> Double {
  let n = physics_heat_radiation_series_len(s)
  if n == 0 { 0.0 } else {
    let m = physics_heat_radiation_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn physics_heat_radiation_series_std(s : PhysicsheatradiationSeries) -> Double { physics_heat_radiation_sqrt(physics_heat_radiation_series_var(s)) }

pub fn physics_heat_radiation_series_median(s : PhysicsheatradiationSeries) -> Double {
  let n = physics_heat_radiation_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = physics_heat_radiation_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn physics_heat_radiation_series_scale(s : PhysicsheatradiationSeries, f : Double) -> PhysicsheatradiationSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = physics_heat_radiation_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn physics_heat_radiation_series_add(a : PhysicsheatradiationSeries, b : PhysicsheatradiationSeries) -> PhysicsheatradiationSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = physics_heat_radiation_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn physics_heat_radiation_series_sub(a : PhysicsheatradiationSeries, b : PhysicsheatradiationSeries) -> PhysicsheatradiationSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = physics_heat_radiation_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn physics_heat_radiation_series_normalize(s : PhysicsheatradiationSeries) -> PhysicsheatradiationSeries {
  let mn = physics_heat_radiation_series_min(s)
  let mx = physics_heat_radiation_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = physics_heat_radiation_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn physics_heat_radiation_series_cumsum(s : PhysicsheatradiationSeries) -> PhysicsheatradiationSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = physics_heat_radiation_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn physics_heat_radiation_series_to_string(s : PhysicsheatradiationSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + physics_heat_radiation_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct PhysicsheatradiationMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn physics_heat_radiation_make_matrix(rows : Int, cols : Int, val : Double) -> PhysicsheatradiationMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn physics_heat_radiation_matrix_identity(n : Int) -> PhysicsheatradiationMatrix {
  let m = physics_heat_radiation_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn physics_heat_radiation_matrix_get(m : PhysicsheatradiationMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn physics_heat_radiation_matrix_transpose(m : PhysicsheatradiationMatrix) -> PhysicsheatradiationMatrix {
  let result = physics_heat_radiation_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn physics_heat_radiation_matrix_add(a : PhysicsheatradiationMatrix, b : PhysicsheatradiationMatrix) -> PhysicsheatradiationMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = physics_heat_radiation_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn physics_heat_radiation_matrix_scale(m : PhysicsheatradiationMatrix, s : Double) -> PhysicsheatradiationMatrix {
  let result = physics_heat_radiation_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn physics_heat_radiation_matrix_multiply(a : PhysicsheatradiationMatrix, b : PhysicsheatradiationMatrix) -> PhysicsheatradiationMatrix {
  if a.cols != b.rows { return physics_heat_radiation_make_matrix(a.rows, b.cols, 0.0) }
  let result = physics_heat_radiation_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn physics_heat_radiation_matrix_trace(m : PhysicsheatradiationMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn physics_heat_radiation_matrix_det(m : PhysicsheatradiationMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn physics_heat_radiation_matrix_norm(m : PhysicsheatradiationMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  physics_heat_radiation_sqrt(sum)
}

pub fn physics_heat_radiation_matrix_to_string(m : PhysicsheatradiationMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + physics_heat_radiation_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct PhysicsheatradiationVector {
  comps : Array[Double]
  dim : Int
}

pub fn physics_heat_radiation_make_vector(comps : Array[Double]) -> PhysicsheatradiationVector {
  { comps, dim: comps.length() }
}

pub fn physics_heat_radiation_vector_zero(dim : Int) -> PhysicsheatradiationVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn physics_heat_radiation_vector_add(a : PhysicsheatradiationVector, b : PhysicsheatradiationVector) -> PhysicsheatradiationVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = physics_heat_radiation_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn physics_heat_radiation_vector_sub(a : PhysicsheatradiationVector, b : PhysicsheatradiationVector) -> PhysicsheatradiationVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = physics_heat_radiation_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn physics_heat_radiation_vector_scale(v : PhysicsheatradiationVector, s : Double) -> PhysicsheatradiationVector {
  let mut result = []
  for i in 0..<v.dim { result = physics_heat_radiation_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn physics_heat_radiation_vector_dot(a : PhysicsheatradiationVector, b : PhysicsheatradiationVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn physics_heat_radiation_vector_norm(v : PhysicsheatradiationVector) -> Double { physics_heat_radiation_sqrt(physics_heat_radiation_vector_dot(v, v)) }

pub fn physics_heat_radiation_vector_normalize(v : PhysicsheatradiationVector) -> PhysicsheatradiationVector {
  let n = physics_heat_radiation_vector_norm(v)
  if n < 0.0000001 { v } else { physics_heat_radiation_vector_scale(v, 1.0 / n) }
}

pub fn physics_heat_radiation_vector_dist(a : PhysicsheatradiationVector, b : PhysicsheatradiationVector) -> Double {
  physics_heat_radiation_vector_norm(physics_heat_radiation_vector_sub(a, b))
}

pub fn physics_heat_radiation_vector_to_string(v : PhysicsheatradiationVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + physics_heat_radiation_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn physics_heat_radiation_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn physics_heat_radiation_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = physics_heat_radiation_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn physics_heat_radiation_std(data : Array[Double]) -> Double { physics_heat_radiation_sqrt(physics_heat_radiation_var(data)) }

pub fn physics_heat_radiation_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = physics_heat_radiation_mean(a); let mb = physics_heat_radiation_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn physics_heat_radiation_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = physics_heat_radiation_std(a); let sb = physics_heat_radiation_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { physics_heat_radiation_cov(a, b) / (sa * sb) }
}

pub fn physics_heat_radiation_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = physics_heat_radiation_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn physics_heat_radiation_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn physics_heat_radiation_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn physics_heat_radiation_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  physics_heat_radiation_sqrt(physics_heat_radiation_mse(pred, labels))
}

pub fn physics_heat_radiation_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + physics_heat_radiation_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn physics_heat_radiation_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = physics_heat_radiation_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn physics_heat_radiation_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn physics_heat_radiation_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn physics_heat_radiation_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = physics_heat_radiation_precision(pred, labels, pos); let r = physics_heat_radiation_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn physics_heat_radiation_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn physics_heat_radiation_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = physics_heat_radiation_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn physics_heat_radiation_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn physics_heat_radiation_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn physics_heat_radiation_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = physics_heat_radiation_gcd(a, b)
    (a / g) * b
  }
}

pub fn physics_heat_radiation_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn physics_heat_radiation_fibonacci(n : Int) -> Int {
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

pub fn physics_heat_radiation_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = physics_heat_radiation_min(data); let mx = physics_heat_radiation_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn physics_heat_radiation_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = physics_heat_radiation_mean(data); let sd = physics_heat_radiation_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn physics_heat_radiation_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn physics_heat_radiation_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn physics_heat_radiation_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn physics_heat_radiation_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn physics_heat_radiation_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn physics_heat_radiation_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn physics_heat_radiation_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn physics_heat_radiation_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn physics_heat_radiation_dbl(x : Double) -> String {
  let i = if x >= 0.0 { physics_heat_radiation_int(x) } else { -physics_heat_radiation_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { physics_heat_radiation_int(f * 1000000.0) } else { physics_heat_radiation_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn physics_heat_radiation_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn physics_heat_radiation_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct PhysicsheatradiationFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_radiation_frame_make(size : Int) -> PhysicsheatradiationFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_radiation_frame_len(s : PhysicsheatradiationFrame) -> Int { s.size }

pub fn physics_heat_radiation_frame_get(s : PhysicsheatradiationFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_radiation_frame_set(s : PhysicsheatradiationFrame, i : Int, v : Double) -> PhysicsheatradiationFrame {
  let result = physics_heat_radiation_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_heat_radiation_frame_sum(s : PhysicsheatradiationFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_heat_radiation_frame_mean(s : PhysicsheatradiationFrame) -> Double {
  if s.size == 0 { 0.0 } else { physics_heat_radiation_frame_sum(s) / s.size.to_double() }
}

pub fn physics_heat_radiation_frame_scale(s : PhysicsheatradiationFrame, f : Double) -> PhysicsheatradiationFrame {
  let result = physics_heat_radiation_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_heat_radiation_frame_add(a : PhysicsheatradiationFrame, b : PhysicsheatradiationFrame) -> PhysicsheatradiationFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_heat_radiation_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_heat_radiation_frame_copy(s : PhysicsheatradiationFrame) -> PhysicsheatradiationFrame {
  let result = physics_heat_radiation_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_heat_radiation_frame_fill(s : PhysicsheatradiationFrame, v : Double) -> PhysicsheatradiationFrame {
  let result = physics_heat_radiation_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_heat_radiation_frame_min(s : PhysicsheatradiationFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_heat_radiation_frame_max(s : PhysicsheatradiationFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_heat_radiation_frame_to_string(s : PhysicsheatradiationFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatradiationTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_radiation_table_make(size : Int) -> PhysicsheatradiationTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_radiation_table_len(s : PhysicsheatradiationTable) -> Int { s.size }

pub fn physics_heat_radiation_table_get(s : PhysicsheatradiationTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_radiation_table_set(s : PhysicsheatradiationTable, i : Int, v : Double) -> PhysicsheatradiationTable {
  let result = physics_heat_radiation_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_heat_radiation_table_sum(s : PhysicsheatradiationTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_heat_radiation_table_mean(s : PhysicsheatradiationTable) -> Double {
  if s.size == 0 { 0.0 } else { physics_heat_radiation_table_sum(s) / s.size.to_double() }
}

pub fn physics_heat_radiation_table_scale(s : PhysicsheatradiationTable, f : Double) -> PhysicsheatradiationTable {
  let result = physics_heat_radiation_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_heat_radiation_table_add(a : PhysicsheatradiationTable, b : PhysicsheatradiationTable) -> PhysicsheatradiationTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_heat_radiation_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_heat_radiation_table_copy(s : PhysicsheatradiationTable) -> PhysicsheatradiationTable {
  let result = physics_heat_radiation_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_heat_radiation_table_fill(s : PhysicsheatradiationTable, v : Double) -> PhysicsheatradiationTable {
  let result = physics_heat_radiation_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_heat_radiation_table_min(s : PhysicsheatradiationTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_heat_radiation_table_max(s : PhysicsheatradiationTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_heat_radiation_table_to_string(s : PhysicsheatradiationTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatradiationGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_radiation_graphn_make(size : Int) -> PhysicsheatradiationGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_radiation_graphn_len(s : PhysicsheatradiationGraphN) -> Int { s.size }

pub fn physics_heat_radiation_graphn_get(s : PhysicsheatradiationGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_radiation_graphn_set(s : PhysicsheatradiationGraphN, i : Int, v : Double) -> PhysicsheatradiationGraphN {
  let result = physics_heat_radiation_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_heat_radiation_graphn_sum(s : PhysicsheatradiationGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_heat_radiation_graphn_mean(s : PhysicsheatradiationGraphN) -> Double {
  if s.size == 0 { 0.0 } else { physics_heat_radiation_graphn_sum(s) / s.size.to_double() }
}

pub fn physics_heat_radiation_graphn_scale(s : PhysicsheatradiationGraphN, f : Double) -> PhysicsheatradiationGraphN {
  let result = physics_heat_radiation_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_heat_radiation_graphn_add(a : PhysicsheatradiationGraphN, b : PhysicsheatradiationGraphN) -> PhysicsheatradiationGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_heat_radiation_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_heat_radiation_graphn_copy(s : PhysicsheatradiationGraphN) -> PhysicsheatradiationGraphN {
  let result = physics_heat_radiation_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_heat_radiation_graphn_fill(s : PhysicsheatradiationGraphN, v : Double) -> PhysicsheatradiationGraphN {
  let result = physics_heat_radiation_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_heat_radiation_graphn_min(s : PhysicsheatradiationGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_heat_radiation_graphn_max(s : PhysicsheatradiationGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_heat_radiation_graphn_to_string(s : PhysicsheatradiationGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatradiationNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_radiation_node_make(size : Int) -> PhysicsheatradiationNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_radiation_node_len(s : PhysicsheatradiationNode) -> Int { s.size }

pub fn physics_heat_radiation_node_get(s : PhysicsheatradiationNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_radiation_node_set(s : PhysicsheatradiationNode, i : Int, v : Double) -> PhysicsheatradiationNode {
  let result = physics_heat_radiation_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_heat_radiation_node_sum(s : PhysicsheatradiationNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_heat_radiation_node_mean(s : PhysicsheatradiationNode) -> Double {
  if s.size == 0 { 0.0 } else { physics_heat_radiation_node_sum(s) / s.size.to_double() }
}

pub fn physics_heat_radiation_node_scale(s : PhysicsheatradiationNode, f : Double) -> PhysicsheatradiationNode {
  let result = physics_heat_radiation_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_heat_radiation_node_add(a : PhysicsheatradiationNode, b : PhysicsheatradiationNode) -> PhysicsheatradiationNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_heat_radiation_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_heat_radiation_node_copy(s : PhysicsheatradiationNode) -> PhysicsheatradiationNode {
  let result = physics_heat_radiation_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_heat_radiation_node_fill(s : PhysicsheatradiationNode, v : Double) -> PhysicsheatradiationNode {
  let result = physics_heat_radiation_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_heat_radiation_node_min(s : PhysicsheatradiationNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_heat_radiation_node_max(s : PhysicsheatradiationNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_heat_radiation_node_to_string(s : PhysicsheatradiationNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatradiationEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_radiation_edge_make(size : Int) -> PhysicsheatradiationEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_radiation_edge_len(s : PhysicsheatradiationEdge) -> Int { s.size }

pub fn physics_heat_radiation_edge_get(s : PhysicsheatradiationEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_radiation_edge_set(s : PhysicsheatradiationEdge, i : Int, v : Double) -> PhysicsheatradiationEdge {
  let result = physics_heat_radiation_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_heat_radiation_edge_sum(s : PhysicsheatradiationEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_heat_radiation_edge_mean(s : PhysicsheatradiationEdge) -> Double {
  if s.size == 0 { 0.0 } else { physics_heat_radiation_edge_sum(s) / s.size.to_double() }
}

pub fn physics_heat_radiation_edge_scale(s : PhysicsheatradiationEdge, f : Double) -> PhysicsheatradiationEdge {
  let result = physics_heat_radiation_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_heat_radiation_edge_add(a : PhysicsheatradiationEdge, b : PhysicsheatradiationEdge) -> PhysicsheatradiationEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_heat_radiation_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_heat_radiation_edge_copy(s : PhysicsheatradiationEdge) -> PhysicsheatradiationEdge {
  let result = physics_heat_radiation_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_heat_radiation_edge_fill(s : PhysicsheatradiationEdge, v : Double) -> PhysicsheatradiationEdge {
  let result = physics_heat_radiation_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_heat_radiation_edge_min(s : PhysicsheatradiationEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_heat_radiation_edge_max(s : PhysicsheatradiationEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_heat_radiation_edge_to_string(s : PhysicsheatradiationEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatradiationPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_radiation_path_make(size : Int) -> PhysicsheatradiationPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_radiation_path_len(s : PhysicsheatradiationPath) -> Int { s.size }

pub fn physics_heat_radiation_path_get(s : PhysicsheatradiationPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_radiation_path_set(s : PhysicsheatradiationPath, i : Int, v : Double) -> PhysicsheatradiationPath {
  let result = physics_heat_radiation_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_heat_radiation_path_sum(s : PhysicsheatradiationPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_heat_radiation_path_mean(s : PhysicsheatradiationPath) -> Double {
  if s.size == 0 { 0.0 } else { physics_heat_radiation_path_sum(s) / s.size.to_double() }
}

pub fn physics_heat_radiation_path_scale(s : PhysicsheatradiationPath, f : Double) -> PhysicsheatradiationPath {
  let result = physics_heat_radiation_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_heat_radiation_path_add(a : PhysicsheatradiationPath, b : PhysicsheatradiationPath) -> PhysicsheatradiationPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_heat_radiation_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_heat_radiation_path_copy(s : PhysicsheatradiationPath) -> PhysicsheatradiationPath {
  let result = physics_heat_radiation_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_heat_radiation_path_fill(s : PhysicsheatradiationPath, v : Double) -> PhysicsheatradiationPath {
  let result = physics_heat_radiation_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_heat_radiation_path_min(s : PhysicsheatradiationPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_heat_radiation_path_max(s : PhysicsheatradiationPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_heat_radiation_path_to_string(s : PhysicsheatradiationPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatradiationCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_radiation_cluster_make(size : Int) -> PhysicsheatradiationCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_radiation_cluster_len(s : PhysicsheatradiationCluster) -> Int { s.size }

pub fn physics_heat_radiation_cluster_get(s : PhysicsheatradiationCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_radiation_cluster_set(s : PhysicsheatradiationCluster, i : Int, v : Double) -> PhysicsheatradiationCluster {
  let result = physics_heat_radiation_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_heat_radiation_cluster_sum(s : PhysicsheatradiationCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_heat_radiation_cluster_mean(s : PhysicsheatradiationCluster) -> Double {
  if s.size == 0 { 0.0 } else { physics_heat_radiation_cluster_sum(s) / s.size.to_double() }
}

pub fn physics_heat_radiation_cluster_scale(s : PhysicsheatradiationCluster, f : Double) -> PhysicsheatradiationCluster {
  let result = physics_heat_radiation_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_heat_radiation_cluster_add(a : PhysicsheatradiationCluster, b : PhysicsheatradiationCluster) -> PhysicsheatradiationCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_heat_radiation_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_heat_radiation_cluster_copy(s : PhysicsheatradiationCluster) -> PhysicsheatradiationCluster {
  let result = physics_heat_radiation_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_heat_radiation_cluster_fill(s : PhysicsheatradiationCluster, v : Double) -> PhysicsheatradiationCluster {
  let result = physics_heat_radiation_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_heat_radiation_cluster_min(s : PhysicsheatradiationCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_heat_radiation_cluster_max(s : PhysicsheatradiationCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_heat_radiation_cluster_to_string(s : PhysicsheatradiationCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatradiationModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_radiation_model_make(size : Int) -> PhysicsheatradiationModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_radiation_model_len(s : PhysicsheatradiationModel) -> Int { s.size }

pub fn physics_heat_radiation_model_get(s : PhysicsheatradiationModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_radiation_model_set(s : PhysicsheatradiationModel, i : Int, v : Double) -> PhysicsheatradiationModel {
  let result = physics_heat_radiation_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_heat_radiation_model_sum(s : PhysicsheatradiationModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_heat_radiation_model_mean(s : PhysicsheatradiationModel) -> Double {
  if s.size == 0 { 0.0 } else { physics_heat_radiation_model_sum(s) / s.size.to_double() }
}

pub fn physics_heat_radiation_model_scale(s : PhysicsheatradiationModel, f : Double) -> PhysicsheatradiationModel {
  let result = physics_heat_radiation_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_heat_radiation_model_add(a : PhysicsheatradiationModel, b : PhysicsheatradiationModel) -> PhysicsheatradiationModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_heat_radiation_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_heat_radiation_model_copy(s : PhysicsheatradiationModel) -> PhysicsheatradiationModel {
  let result = physics_heat_radiation_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_heat_radiation_model_fill(s : PhysicsheatradiationModel, v : Double) -> PhysicsheatradiationModel {
  let result = physics_heat_radiation_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_heat_radiation_model_min(s : PhysicsheatradiationModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_heat_radiation_model_max(s : PhysicsheatradiationModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_heat_radiation_model_to_string(s : PhysicsheatradiationModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatradiationLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_radiation_layer_make(size : Int) -> PhysicsheatradiationLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_radiation_layer_len(s : PhysicsheatradiationLayer) -> Int { s.size }

pub fn physics_heat_radiation_layer_get(s : PhysicsheatradiationLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_radiation_layer_set(s : PhysicsheatradiationLayer, i : Int, v : Double) -> PhysicsheatradiationLayer {
  let result = physics_heat_radiation_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_heat_radiation_layer_sum(s : PhysicsheatradiationLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_heat_radiation_layer_mean(s : PhysicsheatradiationLayer) -> Double {
  if s.size == 0 { 0.0 } else { physics_heat_radiation_layer_sum(s) / s.size.to_double() }
}

pub fn physics_heat_radiation_layer_scale(s : PhysicsheatradiationLayer, f : Double) -> PhysicsheatradiationLayer {
  let result = physics_heat_radiation_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_heat_radiation_layer_add(a : PhysicsheatradiationLayer, b : PhysicsheatradiationLayer) -> PhysicsheatradiationLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_heat_radiation_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_heat_radiation_layer_copy(s : PhysicsheatradiationLayer) -> PhysicsheatradiationLayer {
  let result = physics_heat_radiation_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_heat_radiation_layer_fill(s : PhysicsheatradiationLayer, v : Double) -> PhysicsheatradiationLayer {
  let result = physics_heat_radiation_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_heat_radiation_layer_min(s : PhysicsheatradiationLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_heat_radiation_layer_max(s : PhysicsheatradiationLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_heat_radiation_layer_to_string(s : PhysicsheatradiationLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatradiationBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_radiation_buffer_make(size : Int) -> PhysicsheatradiationBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_radiation_buffer_len(s : PhysicsheatradiationBuffer) -> Int { s.size }

pub fn physics_heat_radiation_buffer_get(s : PhysicsheatradiationBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_radiation_buffer_set(s : PhysicsheatradiationBuffer, i : Int, v : Double) -> PhysicsheatradiationBuffer {
  let result = physics_heat_radiation_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_heat_radiation_buffer_sum(s : PhysicsheatradiationBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_heat_radiation_buffer_mean(s : PhysicsheatradiationBuffer) -> Double {
  if s.size == 0 { 0.0 } else { physics_heat_radiation_buffer_sum(s) / s.size.to_double() }
}

pub fn physics_heat_radiation_buffer_scale(s : PhysicsheatradiationBuffer, f : Double) -> PhysicsheatradiationBuffer {
  let result = physics_heat_radiation_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_heat_radiation_buffer_add(a : PhysicsheatradiationBuffer, b : PhysicsheatradiationBuffer) -> PhysicsheatradiationBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_heat_radiation_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_heat_radiation_buffer_copy(s : PhysicsheatradiationBuffer) -> PhysicsheatradiationBuffer {
  let result = physics_heat_radiation_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_heat_radiation_buffer_fill(s : PhysicsheatradiationBuffer, v : Double) -> PhysicsheatradiationBuffer {
  let result = physics_heat_radiation_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_heat_radiation_buffer_min(s : PhysicsheatradiationBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_heat_radiation_buffer_max(s : PhysicsheatradiationBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_heat_radiation_buffer_to_string(s : PhysicsheatradiationBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatradiationCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_radiation_cursor_make(size : Int) -> PhysicsheatradiationCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_radiation_cursor_len(s : PhysicsheatradiationCursor) -> Int { s.size }

pub fn physics_heat_radiation_cursor_get(s : PhysicsheatradiationCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_radiation_cursor_set(s : PhysicsheatradiationCursor, i : Int, v : Double) -> PhysicsheatradiationCursor {
  let result = physics_heat_radiation_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_heat_radiation_cursor_sum(s : PhysicsheatradiationCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_heat_radiation_cursor_mean(s : PhysicsheatradiationCursor) -> Double {
  if s.size == 0 { 0.0 } else { physics_heat_radiation_cursor_sum(s) / s.size.to_double() }
}

pub fn physics_heat_radiation_cursor_scale(s : PhysicsheatradiationCursor, f : Double) -> PhysicsheatradiationCursor {
  let result = physics_heat_radiation_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_heat_radiation_cursor_add(a : PhysicsheatradiationCursor, b : PhysicsheatradiationCursor) -> PhysicsheatradiationCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_heat_radiation_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_heat_radiation_cursor_copy(s : PhysicsheatradiationCursor) -> PhysicsheatradiationCursor {
  let result = physics_heat_radiation_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_heat_radiation_cursor_fill(s : PhysicsheatradiationCursor, v : Double) -> PhysicsheatradiationCursor {
  let result = physics_heat_radiation_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_heat_radiation_cursor_min(s : PhysicsheatradiationCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_heat_radiation_cursor_max(s : PhysicsheatradiationCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_heat_radiation_cursor_to_string(s : PhysicsheatradiationCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatradiationView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_radiation_view_make(size : Int) -> PhysicsheatradiationView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_radiation_view_len(s : PhysicsheatradiationView) -> Int { s.size }

pub fn physics_heat_radiation_view_get(s : PhysicsheatradiationView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_radiation_view_set(s : PhysicsheatradiationView, i : Int, v : Double) -> PhysicsheatradiationView {
  let result = physics_heat_radiation_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_heat_radiation_view_sum(s : PhysicsheatradiationView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_heat_radiation_view_mean(s : PhysicsheatradiationView) -> Double {
  if s.size == 0 { 0.0 } else { physics_heat_radiation_view_sum(s) / s.size.to_double() }
}

pub fn physics_heat_radiation_view_scale(s : PhysicsheatradiationView, f : Double) -> PhysicsheatradiationView {
  let result = physics_heat_radiation_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_heat_radiation_view_add(a : PhysicsheatradiationView, b : PhysicsheatradiationView) -> PhysicsheatradiationView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_heat_radiation_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_heat_radiation_view_copy(s : PhysicsheatradiationView) -> PhysicsheatradiationView {
  let result = physics_heat_radiation_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_heat_radiation_view_fill(s : PhysicsheatradiationView, v : Double) -> PhysicsheatradiationView {
  let result = physics_heat_radiation_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_heat_radiation_view_min(s : PhysicsheatradiationView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_heat_radiation_view_max(s : PhysicsheatradiationView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_heat_radiation_view_to_string(s : PhysicsheatradiationView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatradiationRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_radiation_range_make(size : Int) -> PhysicsheatradiationRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_radiation_range_len(s : PhysicsheatradiationRange) -> Int { s.size }

pub fn physics_heat_radiation_range_get(s : PhysicsheatradiationRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_radiation_range_set(s : PhysicsheatradiationRange, i : Int, v : Double) -> PhysicsheatradiationRange {
  let result = physics_heat_radiation_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_heat_radiation_range_sum(s : PhysicsheatradiationRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_heat_radiation_range_mean(s : PhysicsheatradiationRange) -> Double {
  if s.size == 0 { 0.0 } else { physics_heat_radiation_range_sum(s) / s.size.to_double() }
}

pub fn physics_heat_radiation_range_scale(s : PhysicsheatradiationRange, f : Double) -> PhysicsheatradiationRange {
  let result = physics_heat_radiation_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_heat_radiation_range_add(a : PhysicsheatradiationRange, b : PhysicsheatradiationRange) -> PhysicsheatradiationRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_heat_radiation_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_heat_radiation_range_copy(s : PhysicsheatradiationRange) -> PhysicsheatradiationRange {
  let result = physics_heat_radiation_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_heat_radiation_range_fill(s : PhysicsheatradiationRange, v : Double) -> PhysicsheatradiationRange {
  let result = physics_heat_radiation_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_heat_radiation_range_min(s : PhysicsheatradiationRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_heat_radiation_range_max(s : PhysicsheatradiationRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_heat_radiation_range_to_string(s : PhysicsheatradiationRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatradiationSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_radiation_slice_make(size : Int) -> PhysicsheatradiationSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_radiation_slice_len(s : PhysicsheatradiationSlice) -> Int { s.size }

pub fn physics_heat_radiation_slice_get(s : PhysicsheatradiationSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_radiation_slice_set(s : PhysicsheatradiationSlice, i : Int, v : Double) -> PhysicsheatradiationSlice {
  let result = physics_heat_radiation_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_heat_radiation_slice_sum(s : PhysicsheatradiationSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_heat_radiation_slice_mean(s : PhysicsheatradiationSlice) -> Double {
  if s.size == 0 { 0.0 } else { physics_heat_radiation_slice_sum(s) / s.size.to_double() }
}

pub fn physics_heat_radiation_slice_scale(s : PhysicsheatradiationSlice, f : Double) -> PhysicsheatradiationSlice {
  let result = physics_heat_radiation_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_heat_radiation_slice_add(a : PhysicsheatradiationSlice, b : PhysicsheatradiationSlice) -> PhysicsheatradiationSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_heat_radiation_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_heat_radiation_slice_copy(s : PhysicsheatradiationSlice) -> PhysicsheatradiationSlice {
  let result = physics_heat_radiation_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_heat_radiation_slice_fill(s : PhysicsheatradiationSlice, v : Double) -> PhysicsheatradiationSlice {
  let result = physics_heat_radiation_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_heat_radiation_slice_min(s : PhysicsheatradiationSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_heat_radiation_slice_max(s : PhysicsheatradiationSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_heat_radiation_slice_to_string(s : PhysicsheatradiationSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn physics_heat_radiation_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_heat_radiation_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_heat_radiation_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_heat_radiation_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_heat_radiation_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_heat_radiation_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_heat_radiation_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_heat_radiation_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_heat_radiation_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_heat_radiation_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_heat_radiation_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_heat_radiation_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_heat_radiation_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_heat_radiation_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_heat_radiation_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_heat_radiation_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_heat_radiation_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_heat_radiation_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_heat_radiation_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_heat_radiation_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_heat_radiation_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_heat_radiation_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_heat_radiation_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_heat_radiation_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_heat_radiation_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

