///===
/// extcore/physics_em_magnetostatic

pub(all) struct PhysicsemmagnetostaticPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn physics_em_magnetostatic_make_point(x : Double, y : Double) -> PhysicsemmagnetostaticPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn physics_em_magnetostatic_make_point3(x : Double, y : Double, z : Double) -> PhysicsemmagnetostaticPoint {
  { x, y, z, label: 0 }
}

pub fn physics_em_magnetostatic_point_x(pt : PhysicsemmagnetostaticPoint) -> Double { pt.x }

pub fn physics_em_magnetostatic_point_y(pt : PhysicsemmagnetostaticPoint) -> Double { pt.y }

pub fn physics_em_magnetostatic_point_z(pt : PhysicsemmagnetostaticPoint) -> Double { pt.z }

pub fn physics_em_magnetostatic_point_label(pt : PhysicsemmagnetostaticPoint) -> Int { pt.label }

pub fn physics_em_magnetostatic_point_dist(a : PhysicsemmagnetostaticPoint, b : PhysicsemmagnetostaticPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  physics_em_magnetostatic_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn physics_em_magnetostatic_point_add(a : PhysicsemmagnetostaticPoint, b : PhysicsemmagnetostaticPoint) -> PhysicsemmagnetostaticPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn physics_em_magnetostatic_point_sub(a : PhysicsemmagnetostaticPoint, b : PhysicsemmagnetostaticPoint) -> PhysicsemmagnetostaticPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn physics_em_magnetostatic_point_scale(pt : PhysicsemmagnetostaticPoint, s : Double) -> PhysicsemmagnetostaticPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn physics_em_magnetostatic_point_dot(a : PhysicsemmagnetostaticPoint, b : PhysicsemmagnetostaticPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn physics_em_magnetostatic_point_cross(a : PhysicsemmagnetostaticPoint, b : PhysicsemmagnetostaticPoint) -> PhysicsemmagnetostaticPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn physics_em_magnetostatic_point_norm(pt : PhysicsemmagnetostaticPoint) -> Double {
  physics_em_magnetostatic_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn physics_em_magnetostatic_point_normalize(pt : PhysicsemmagnetostaticPoint) -> PhysicsemmagnetostaticPoint {
  let n = physics_em_magnetostatic_point_norm(pt)
  if n < 0.0000001 { pt } else { physics_em_magnetostatic_point_scale(pt, 1.0 / n) }
}

pub fn physics_em_magnetostatic_point_negate(pt : PhysicsemmagnetostaticPoint) -> PhysicsemmagnetostaticPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn physics_em_magnetostatic_point_mid(a : PhysicsemmagnetostaticPoint, b : PhysicsemmagnetostaticPoint) -> PhysicsemmagnetostaticPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn physics_em_magnetostatic_point_lerp(a : PhysicsemmagnetostaticPoint, b : PhysicsemmagnetostaticPoint, t : Double) -> PhysicsemmagnetostaticPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn physics_em_magnetostatic_point_to_string(pt : PhysicsemmagnetostaticPoint) -> String {
  "(" + physics_em_magnetostatic_dbl(pt.x) + ", " + physics_em_magnetostatic_dbl(pt.y) + ", " + physics_em_magnetostatic_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct PhysicsemmagnetostaticSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn physics_em_magnetostatic_make_series(vals : Array[Double], name : String) -> PhysicsemmagnetostaticSeries {
  { vals, name, meta: 0 }
}

pub fn physics_em_magnetostatic_series_len(s : PhysicsemmagnetostaticSeries) -> Int { s.vals.length() }

pub fn physics_em_magnetostatic_series_sum(s : PhysicsemmagnetostaticSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn physics_em_magnetostatic_series_mean(s : PhysicsemmagnetostaticSeries) -> Double {
  let n = physics_em_magnetostatic_series_len(s)
  if n == 0 { 0.0 } else { physics_em_magnetostatic_series_sum(s) / n.to_double() }
}

pub fn physics_em_magnetostatic_series_min(s : PhysicsemmagnetostaticSeries) -> Double {
  let n = physics_em_magnetostatic_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn physics_em_magnetostatic_series_max(s : PhysicsemmagnetostaticSeries) -> Double {
  let n = physics_em_magnetostatic_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn physics_em_magnetostatic_series_range(s : PhysicsemmagnetostaticSeries) -> Double {
  physics_em_magnetostatic_series_max(s) - physics_em_magnetostatic_series_min(s)
}

pub fn physics_em_magnetostatic_series_var(s : PhysicsemmagnetostaticSeries) -> Double {
  let n = physics_em_magnetostatic_series_len(s)
  if n == 0 { 0.0 } else {
    let m = physics_em_magnetostatic_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn physics_em_magnetostatic_series_std(s : PhysicsemmagnetostaticSeries) -> Double { physics_em_magnetostatic_sqrt(physics_em_magnetostatic_series_var(s)) }

pub fn physics_em_magnetostatic_series_median(s : PhysicsemmagnetostaticSeries) -> Double {
  let n = physics_em_magnetostatic_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = physics_em_magnetostatic_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn physics_em_magnetostatic_series_scale(s : PhysicsemmagnetostaticSeries, f : Double) -> PhysicsemmagnetostaticSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = physics_em_magnetostatic_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn physics_em_magnetostatic_series_add(a : PhysicsemmagnetostaticSeries, b : PhysicsemmagnetostaticSeries) -> PhysicsemmagnetostaticSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = physics_em_magnetostatic_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn physics_em_magnetostatic_series_sub(a : PhysicsemmagnetostaticSeries, b : PhysicsemmagnetostaticSeries) -> PhysicsemmagnetostaticSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = physics_em_magnetostatic_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn physics_em_magnetostatic_series_normalize(s : PhysicsemmagnetostaticSeries) -> PhysicsemmagnetostaticSeries {
  let mn = physics_em_magnetostatic_series_min(s)
  let mx = physics_em_magnetostatic_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = physics_em_magnetostatic_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn physics_em_magnetostatic_series_cumsum(s : PhysicsemmagnetostaticSeries) -> PhysicsemmagnetostaticSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = physics_em_magnetostatic_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn physics_em_magnetostatic_series_to_string(s : PhysicsemmagnetostaticSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + physics_em_magnetostatic_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct PhysicsemmagnetostaticMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn physics_em_magnetostatic_make_matrix(rows : Int, cols : Int, val : Double) -> PhysicsemmagnetostaticMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn physics_em_magnetostatic_matrix_identity(n : Int) -> PhysicsemmagnetostaticMatrix {
  let m = physics_em_magnetostatic_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn physics_em_magnetostatic_matrix_get(m : PhysicsemmagnetostaticMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn physics_em_magnetostatic_matrix_transpose(m : PhysicsemmagnetostaticMatrix) -> PhysicsemmagnetostaticMatrix {
  let result = physics_em_magnetostatic_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn physics_em_magnetostatic_matrix_add(a : PhysicsemmagnetostaticMatrix, b : PhysicsemmagnetostaticMatrix) -> PhysicsemmagnetostaticMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = physics_em_magnetostatic_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn physics_em_magnetostatic_matrix_scale(m : PhysicsemmagnetostaticMatrix, s : Double) -> PhysicsemmagnetostaticMatrix {
  let result = physics_em_magnetostatic_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn physics_em_magnetostatic_matrix_multiply(a : PhysicsemmagnetostaticMatrix, b : PhysicsemmagnetostaticMatrix) -> PhysicsemmagnetostaticMatrix {
  if a.cols != b.rows { return physics_em_magnetostatic_make_matrix(a.rows, b.cols, 0.0) }
  let result = physics_em_magnetostatic_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn physics_em_magnetostatic_matrix_trace(m : PhysicsemmagnetostaticMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn physics_em_magnetostatic_matrix_det(m : PhysicsemmagnetostaticMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn physics_em_magnetostatic_matrix_norm(m : PhysicsemmagnetostaticMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  physics_em_magnetostatic_sqrt(sum)
}

pub fn physics_em_magnetostatic_matrix_to_string(m : PhysicsemmagnetostaticMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + physics_em_magnetostatic_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct PhysicsemmagnetostaticVector {
  comps : Array[Double]
  dim : Int
}

pub fn physics_em_magnetostatic_make_vector(comps : Array[Double]) -> PhysicsemmagnetostaticVector {
  { comps, dim: comps.length() }
}

pub fn physics_em_magnetostatic_vector_zero(dim : Int) -> PhysicsemmagnetostaticVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn physics_em_magnetostatic_vector_add(a : PhysicsemmagnetostaticVector, b : PhysicsemmagnetostaticVector) -> PhysicsemmagnetostaticVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = physics_em_magnetostatic_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn physics_em_magnetostatic_vector_sub(a : PhysicsemmagnetostaticVector, b : PhysicsemmagnetostaticVector) -> PhysicsemmagnetostaticVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = physics_em_magnetostatic_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn physics_em_magnetostatic_vector_scale(v : PhysicsemmagnetostaticVector, s : Double) -> PhysicsemmagnetostaticVector {
  let mut result = []
  for i in 0..<v.dim { result = physics_em_magnetostatic_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn physics_em_magnetostatic_vector_dot(a : PhysicsemmagnetostaticVector, b : PhysicsemmagnetostaticVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn physics_em_magnetostatic_vector_norm(v : PhysicsemmagnetostaticVector) -> Double { physics_em_magnetostatic_sqrt(physics_em_magnetostatic_vector_dot(v, v)) }

pub fn physics_em_magnetostatic_vector_normalize(v : PhysicsemmagnetostaticVector) -> PhysicsemmagnetostaticVector {
  let n = physics_em_magnetostatic_vector_norm(v)
  if n < 0.0000001 { v } else { physics_em_magnetostatic_vector_scale(v, 1.0 / n) }
}

pub fn physics_em_magnetostatic_vector_dist(a : PhysicsemmagnetostaticVector, b : PhysicsemmagnetostaticVector) -> Double {
  physics_em_magnetostatic_vector_norm(physics_em_magnetostatic_vector_sub(a, b))
}

pub fn physics_em_magnetostatic_vector_to_string(v : PhysicsemmagnetostaticVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + physics_em_magnetostatic_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn physics_em_magnetostatic_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn physics_em_magnetostatic_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = physics_em_magnetostatic_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn physics_em_magnetostatic_std(data : Array[Double]) -> Double { physics_em_magnetostatic_sqrt(physics_em_magnetostatic_var(data)) }

pub fn physics_em_magnetostatic_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = physics_em_magnetostatic_mean(a); let mb = physics_em_magnetostatic_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn physics_em_magnetostatic_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = physics_em_magnetostatic_std(a); let sb = physics_em_magnetostatic_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { physics_em_magnetostatic_cov(a, b) / (sa * sb) }
}

pub fn physics_em_magnetostatic_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = physics_em_magnetostatic_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn physics_em_magnetostatic_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn physics_em_magnetostatic_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn physics_em_magnetostatic_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  physics_em_magnetostatic_sqrt(physics_em_magnetostatic_mse(pred, labels))
}

pub fn physics_em_magnetostatic_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + physics_em_magnetostatic_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn physics_em_magnetostatic_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = physics_em_magnetostatic_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn physics_em_magnetostatic_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn physics_em_magnetostatic_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn physics_em_magnetostatic_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = physics_em_magnetostatic_precision(pred, labels, pos); let r = physics_em_magnetostatic_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn physics_em_magnetostatic_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn physics_em_magnetostatic_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = physics_em_magnetostatic_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn physics_em_magnetostatic_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn physics_em_magnetostatic_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn physics_em_magnetostatic_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = physics_em_magnetostatic_gcd(a, b)
    (a / g) * b
  }
}

pub fn physics_em_magnetostatic_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn physics_em_magnetostatic_fibonacci(n : Int) -> Int {
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

pub fn physics_em_magnetostatic_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = physics_em_magnetostatic_min(data); let mx = physics_em_magnetostatic_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn physics_em_magnetostatic_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = physics_em_magnetostatic_mean(data); let sd = physics_em_magnetostatic_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn physics_em_magnetostatic_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn physics_em_magnetostatic_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn physics_em_magnetostatic_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn physics_em_magnetostatic_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn physics_em_magnetostatic_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn physics_em_magnetostatic_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn physics_em_magnetostatic_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn physics_em_magnetostatic_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn physics_em_magnetostatic_dbl(x : Double) -> String {
  let i = if x >= 0.0 { physics_em_magnetostatic_int(x) } else { -physics_em_magnetostatic_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { physics_em_magnetostatic_int(f * 1000000.0) } else { physics_em_magnetostatic_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn physics_em_magnetostatic_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn physics_em_magnetostatic_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct PhysicsemmagnetostaticFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_magnetostatic_frame_make(size : Int) -> PhysicsemmagnetostaticFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_magnetostatic_frame_len(s : PhysicsemmagnetostaticFrame) -> Int { s.size }

pub fn physics_em_magnetostatic_frame_get(s : PhysicsemmagnetostaticFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_magnetostatic_frame_set(s : PhysicsemmagnetostaticFrame, i : Int, v : Double) -> PhysicsemmagnetostaticFrame {
  let result = physics_em_magnetostatic_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_em_magnetostatic_frame_sum(s : PhysicsemmagnetostaticFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_em_magnetostatic_frame_mean(s : PhysicsemmagnetostaticFrame) -> Double {
  if s.size == 0 { 0.0 } else { physics_em_magnetostatic_frame_sum(s) / s.size.to_double() }
}

pub fn physics_em_magnetostatic_frame_scale(s : PhysicsemmagnetostaticFrame, f : Double) -> PhysicsemmagnetostaticFrame {
  let result = physics_em_magnetostatic_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_em_magnetostatic_frame_add(a : PhysicsemmagnetostaticFrame, b : PhysicsemmagnetostaticFrame) -> PhysicsemmagnetostaticFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_em_magnetostatic_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_em_magnetostatic_frame_copy(s : PhysicsemmagnetostaticFrame) -> PhysicsemmagnetostaticFrame {
  let result = physics_em_magnetostatic_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_em_magnetostatic_frame_fill(s : PhysicsemmagnetostaticFrame, v : Double) -> PhysicsemmagnetostaticFrame {
  let result = physics_em_magnetostatic_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_em_magnetostatic_frame_min(s : PhysicsemmagnetostaticFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_em_magnetostatic_frame_max(s : PhysicsemmagnetostaticFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_em_magnetostatic_frame_to_string(s : PhysicsemmagnetostaticFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemmagnetostaticTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_magnetostatic_table_make(size : Int) -> PhysicsemmagnetostaticTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_magnetostatic_table_len(s : PhysicsemmagnetostaticTable) -> Int { s.size }

pub fn physics_em_magnetostatic_table_get(s : PhysicsemmagnetostaticTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_magnetostatic_table_set(s : PhysicsemmagnetostaticTable, i : Int, v : Double) -> PhysicsemmagnetostaticTable {
  let result = physics_em_magnetostatic_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_em_magnetostatic_table_sum(s : PhysicsemmagnetostaticTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_em_magnetostatic_table_mean(s : PhysicsemmagnetostaticTable) -> Double {
  if s.size == 0 { 0.0 } else { physics_em_magnetostatic_table_sum(s) / s.size.to_double() }
}

pub fn physics_em_magnetostatic_table_scale(s : PhysicsemmagnetostaticTable, f : Double) -> PhysicsemmagnetostaticTable {
  let result = physics_em_magnetostatic_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_em_magnetostatic_table_add(a : PhysicsemmagnetostaticTable, b : PhysicsemmagnetostaticTable) -> PhysicsemmagnetostaticTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_em_magnetostatic_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_em_magnetostatic_table_copy(s : PhysicsemmagnetostaticTable) -> PhysicsemmagnetostaticTable {
  let result = physics_em_magnetostatic_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_em_magnetostatic_table_fill(s : PhysicsemmagnetostaticTable, v : Double) -> PhysicsemmagnetostaticTable {
  let result = physics_em_magnetostatic_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_em_magnetostatic_table_min(s : PhysicsemmagnetostaticTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_em_magnetostatic_table_max(s : PhysicsemmagnetostaticTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_em_magnetostatic_table_to_string(s : PhysicsemmagnetostaticTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemmagnetostaticGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_magnetostatic_graphn_make(size : Int) -> PhysicsemmagnetostaticGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_magnetostatic_graphn_len(s : PhysicsemmagnetostaticGraphN) -> Int { s.size }

pub fn physics_em_magnetostatic_graphn_get(s : PhysicsemmagnetostaticGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_magnetostatic_graphn_set(s : PhysicsemmagnetostaticGraphN, i : Int, v : Double) -> PhysicsemmagnetostaticGraphN {
  let result = physics_em_magnetostatic_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_em_magnetostatic_graphn_sum(s : PhysicsemmagnetostaticGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_em_magnetostatic_graphn_mean(s : PhysicsemmagnetostaticGraphN) -> Double {
  if s.size == 0 { 0.0 } else { physics_em_magnetostatic_graphn_sum(s) / s.size.to_double() }
}

pub fn physics_em_magnetostatic_graphn_scale(s : PhysicsemmagnetostaticGraphN, f : Double) -> PhysicsemmagnetostaticGraphN {
  let result = physics_em_magnetostatic_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_em_magnetostatic_graphn_add(a : PhysicsemmagnetostaticGraphN, b : PhysicsemmagnetostaticGraphN) -> PhysicsemmagnetostaticGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_em_magnetostatic_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_em_magnetostatic_graphn_copy(s : PhysicsemmagnetostaticGraphN) -> PhysicsemmagnetostaticGraphN {
  let result = physics_em_magnetostatic_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_em_magnetostatic_graphn_fill(s : PhysicsemmagnetostaticGraphN, v : Double) -> PhysicsemmagnetostaticGraphN {
  let result = physics_em_magnetostatic_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_em_magnetostatic_graphn_min(s : PhysicsemmagnetostaticGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_em_magnetostatic_graphn_max(s : PhysicsemmagnetostaticGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_em_magnetostatic_graphn_to_string(s : PhysicsemmagnetostaticGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemmagnetostaticNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_magnetostatic_node_make(size : Int) -> PhysicsemmagnetostaticNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_magnetostatic_node_len(s : PhysicsemmagnetostaticNode) -> Int { s.size }

pub fn physics_em_magnetostatic_node_get(s : PhysicsemmagnetostaticNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_magnetostatic_node_set(s : PhysicsemmagnetostaticNode, i : Int, v : Double) -> PhysicsemmagnetostaticNode {
  let result = physics_em_magnetostatic_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_em_magnetostatic_node_sum(s : PhysicsemmagnetostaticNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_em_magnetostatic_node_mean(s : PhysicsemmagnetostaticNode) -> Double {
  if s.size == 0 { 0.0 } else { physics_em_magnetostatic_node_sum(s) / s.size.to_double() }
}

pub fn physics_em_magnetostatic_node_scale(s : PhysicsemmagnetostaticNode, f : Double) -> PhysicsemmagnetostaticNode {
  let result = physics_em_magnetostatic_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_em_magnetostatic_node_add(a : PhysicsemmagnetostaticNode, b : PhysicsemmagnetostaticNode) -> PhysicsemmagnetostaticNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_em_magnetostatic_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_em_magnetostatic_node_copy(s : PhysicsemmagnetostaticNode) -> PhysicsemmagnetostaticNode {
  let result = physics_em_magnetostatic_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_em_magnetostatic_node_fill(s : PhysicsemmagnetostaticNode, v : Double) -> PhysicsemmagnetostaticNode {
  let result = physics_em_magnetostatic_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_em_magnetostatic_node_min(s : PhysicsemmagnetostaticNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_em_magnetostatic_node_max(s : PhysicsemmagnetostaticNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_em_magnetostatic_node_to_string(s : PhysicsemmagnetostaticNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemmagnetostaticEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_magnetostatic_edge_make(size : Int) -> PhysicsemmagnetostaticEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_magnetostatic_edge_len(s : PhysicsemmagnetostaticEdge) -> Int { s.size }

pub fn physics_em_magnetostatic_edge_get(s : PhysicsemmagnetostaticEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_magnetostatic_edge_set(s : PhysicsemmagnetostaticEdge, i : Int, v : Double) -> PhysicsemmagnetostaticEdge {
  let result = physics_em_magnetostatic_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_em_magnetostatic_edge_sum(s : PhysicsemmagnetostaticEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_em_magnetostatic_edge_mean(s : PhysicsemmagnetostaticEdge) -> Double {
  if s.size == 0 { 0.0 } else { physics_em_magnetostatic_edge_sum(s) / s.size.to_double() }
}

pub fn physics_em_magnetostatic_edge_scale(s : PhysicsemmagnetostaticEdge, f : Double) -> PhysicsemmagnetostaticEdge {
  let result = physics_em_magnetostatic_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_em_magnetostatic_edge_add(a : PhysicsemmagnetostaticEdge, b : PhysicsemmagnetostaticEdge) -> PhysicsemmagnetostaticEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_em_magnetostatic_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_em_magnetostatic_edge_copy(s : PhysicsemmagnetostaticEdge) -> PhysicsemmagnetostaticEdge {
  let result = physics_em_magnetostatic_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_em_magnetostatic_edge_fill(s : PhysicsemmagnetostaticEdge, v : Double) -> PhysicsemmagnetostaticEdge {
  let result = physics_em_magnetostatic_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_em_magnetostatic_edge_min(s : PhysicsemmagnetostaticEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_em_magnetostatic_edge_max(s : PhysicsemmagnetostaticEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_em_magnetostatic_edge_to_string(s : PhysicsemmagnetostaticEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemmagnetostaticPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_magnetostatic_path_make(size : Int) -> PhysicsemmagnetostaticPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_magnetostatic_path_len(s : PhysicsemmagnetostaticPath) -> Int { s.size }

pub fn physics_em_magnetostatic_path_get(s : PhysicsemmagnetostaticPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_magnetostatic_path_set(s : PhysicsemmagnetostaticPath, i : Int, v : Double) -> PhysicsemmagnetostaticPath {
  let result = physics_em_magnetostatic_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_em_magnetostatic_path_sum(s : PhysicsemmagnetostaticPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_em_magnetostatic_path_mean(s : PhysicsemmagnetostaticPath) -> Double {
  if s.size == 0 { 0.0 } else { physics_em_magnetostatic_path_sum(s) / s.size.to_double() }
}

pub fn physics_em_magnetostatic_path_scale(s : PhysicsemmagnetostaticPath, f : Double) -> PhysicsemmagnetostaticPath {
  let result = physics_em_magnetostatic_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_em_magnetostatic_path_add(a : PhysicsemmagnetostaticPath, b : PhysicsemmagnetostaticPath) -> PhysicsemmagnetostaticPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_em_magnetostatic_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_em_magnetostatic_path_copy(s : PhysicsemmagnetostaticPath) -> PhysicsemmagnetostaticPath {
  let result = physics_em_magnetostatic_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_em_magnetostatic_path_fill(s : PhysicsemmagnetostaticPath, v : Double) -> PhysicsemmagnetostaticPath {
  let result = physics_em_magnetostatic_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_em_magnetostatic_path_min(s : PhysicsemmagnetostaticPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_em_magnetostatic_path_max(s : PhysicsemmagnetostaticPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_em_magnetostatic_path_to_string(s : PhysicsemmagnetostaticPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemmagnetostaticCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_magnetostatic_cluster_make(size : Int) -> PhysicsemmagnetostaticCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_magnetostatic_cluster_len(s : PhysicsemmagnetostaticCluster) -> Int { s.size }

pub fn physics_em_magnetostatic_cluster_get(s : PhysicsemmagnetostaticCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_magnetostatic_cluster_set(s : PhysicsemmagnetostaticCluster, i : Int, v : Double) -> PhysicsemmagnetostaticCluster {
  let result = physics_em_magnetostatic_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_em_magnetostatic_cluster_sum(s : PhysicsemmagnetostaticCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_em_magnetostatic_cluster_mean(s : PhysicsemmagnetostaticCluster) -> Double {
  if s.size == 0 { 0.0 } else { physics_em_magnetostatic_cluster_sum(s) / s.size.to_double() }
}

pub fn physics_em_magnetostatic_cluster_scale(s : PhysicsemmagnetostaticCluster, f : Double) -> PhysicsemmagnetostaticCluster {
  let result = physics_em_magnetostatic_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_em_magnetostatic_cluster_add(a : PhysicsemmagnetostaticCluster, b : PhysicsemmagnetostaticCluster) -> PhysicsemmagnetostaticCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_em_magnetostatic_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_em_magnetostatic_cluster_copy(s : PhysicsemmagnetostaticCluster) -> PhysicsemmagnetostaticCluster {
  let result = physics_em_magnetostatic_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_em_magnetostatic_cluster_fill(s : PhysicsemmagnetostaticCluster, v : Double) -> PhysicsemmagnetostaticCluster {
  let result = physics_em_magnetostatic_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_em_magnetostatic_cluster_min(s : PhysicsemmagnetostaticCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_em_magnetostatic_cluster_max(s : PhysicsemmagnetostaticCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_em_magnetostatic_cluster_to_string(s : PhysicsemmagnetostaticCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemmagnetostaticModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_magnetostatic_model_make(size : Int) -> PhysicsemmagnetostaticModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_magnetostatic_model_len(s : PhysicsemmagnetostaticModel) -> Int { s.size }

pub fn physics_em_magnetostatic_model_get(s : PhysicsemmagnetostaticModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_magnetostatic_model_set(s : PhysicsemmagnetostaticModel, i : Int, v : Double) -> PhysicsemmagnetostaticModel {
  let result = physics_em_magnetostatic_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_em_magnetostatic_model_sum(s : PhysicsemmagnetostaticModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_em_magnetostatic_model_mean(s : PhysicsemmagnetostaticModel) -> Double {
  if s.size == 0 { 0.0 } else { physics_em_magnetostatic_model_sum(s) / s.size.to_double() }
}

pub fn physics_em_magnetostatic_model_scale(s : PhysicsemmagnetostaticModel, f : Double) -> PhysicsemmagnetostaticModel {
  let result = physics_em_magnetostatic_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_em_magnetostatic_model_add(a : PhysicsemmagnetostaticModel, b : PhysicsemmagnetostaticModel) -> PhysicsemmagnetostaticModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_em_magnetostatic_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_em_magnetostatic_model_copy(s : PhysicsemmagnetostaticModel) -> PhysicsemmagnetostaticModel {
  let result = physics_em_magnetostatic_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_em_magnetostatic_model_fill(s : PhysicsemmagnetostaticModel, v : Double) -> PhysicsemmagnetostaticModel {
  let result = physics_em_magnetostatic_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_em_magnetostatic_model_min(s : PhysicsemmagnetostaticModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_em_magnetostatic_model_max(s : PhysicsemmagnetostaticModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_em_magnetostatic_model_to_string(s : PhysicsemmagnetostaticModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemmagnetostaticLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_magnetostatic_layer_make(size : Int) -> PhysicsemmagnetostaticLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_magnetostatic_layer_len(s : PhysicsemmagnetostaticLayer) -> Int { s.size }

pub fn physics_em_magnetostatic_layer_get(s : PhysicsemmagnetostaticLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_magnetostatic_layer_set(s : PhysicsemmagnetostaticLayer, i : Int, v : Double) -> PhysicsemmagnetostaticLayer {
  let result = physics_em_magnetostatic_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_em_magnetostatic_layer_sum(s : PhysicsemmagnetostaticLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_em_magnetostatic_layer_mean(s : PhysicsemmagnetostaticLayer) -> Double {
  if s.size == 0 { 0.0 } else { physics_em_magnetostatic_layer_sum(s) / s.size.to_double() }
}

pub fn physics_em_magnetostatic_layer_scale(s : PhysicsemmagnetostaticLayer, f : Double) -> PhysicsemmagnetostaticLayer {
  let result = physics_em_magnetostatic_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_em_magnetostatic_layer_add(a : PhysicsemmagnetostaticLayer, b : PhysicsemmagnetostaticLayer) -> PhysicsemmagnetostaticLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_em_magnetostatic_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_em_magnetostatic_layer_copy(s : PhysicsemmagnetostaticLayer) -> PhysicsemmagnetostaticLayer {
  let result = physics_em_magnetostatic_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_em_magnetostatic_layer_fill(s : PhysicsemmagnetostaticLayer, v : Double) -> PhysicsemmagnetostaticLayer {
  let result = physics_em_magnetostatic_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_em_magnetostatic_layer_min(s : PhysicsemmagnetostaticLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_em_magnetostatic_layer_max(s : PhysicsemmagnetostaticLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_em_magnetostatic_layer_to_string(s : PhysicsemmagnetostaticLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemmagnetostaticBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_magnetostatic_buffer_make(size : Int) -> PhysicsemmagnetostaticBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_magnetostatic_buffer_len(s : PhysicsemmagnetostaticBuffer) -> Int { s.size }

pub fn physics_em_magnetostatic_buffer_get(s : PhysicsemmagnetostaticBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_magnetostatic_buffer_set(s : PhysicsemmagnetostaticBuffer, i : Int, v : Double) -> PhysicsemmagnetostaticBuffer {
  let result = physics_em_magnetostatic_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_em_magnetostatic_buffer_sum(s : PhysicsemmagnetostaticBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_em_magnetostatic_buffer_mean(s : PhysicsemmagnetostaticBuffer) -> Double {
  if s.size == 0 { 0.0 } else { physics_em_magnetostatic_buffer_sum(s) / s.size.to_double() }
}

pub fn physics_em_magnetostatic_buffer_scale(s : PhysicsemmagnetostaticBuffer, f : Double) -> PhysicsemmagnetostaticBuffer {
  let result = physics_em_magnetostatic_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_em_magnetostatic_buffer_add(a : PhysicsemmagnetostaticBuffer, b : PhysicsemmagnetostaticBuffer) -> PhysicsemmagnetostaticBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_em_magnetostatic_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_em_magnetostatic_buffer_copy(s : PhysicsemmagnetostaticBuffer) -> PhysicsemmagnetostaticBuffer {
  let result = physics_em_magnetostatic_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_em_magnetostatic_buffer_fill(s : PhysicsemmagnetostaticBuffer, v : Double) -> PhysicsemmagnetostaticBuffer {
  let result = physics_em_magnetostatic_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_em_magnetostatic_buffer_min(s : PhysicsemmagnetostaticBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_em_magnetostatic_buffer_max(s : PhysicsemmagnetostaticBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_em_magnetostatic_buffer_to_string(s : PhysicsemmagnetostaticBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemmagnetostaticCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_magnetostatic_cursor_make(size : Int) -> PhysicsemmagnetostaticCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_magnetostatic_cursor_len(s : PhysicsemmagnetostaticCursor) -> Int { s.size }

pub fn physics_em_magnetostatic_cursor_get(s : PhysicsemmagnetostaticCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_magnetostatic_cursor_set(s : PhysicsemmagnetostaticCursor, i : Int, v : Double) -> PhysicsemmagnetostaticCursor {
  let result = physics_em_magnetostatic_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_em_magnetostatic_cursor_sum(s : PhysicsemmagnetostaticCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_em_magnetostatic_cursor_mean(s : PhysicsemmagnetostaticCursor) -> Double {
  if s.size == 0 { 0.0 } else { physics_em_magnetostatic_cursor_sum(s) / s.size.to_double() }
}

pub fn physics_em_magnetostatic_cursor_scale(s : PhysicsemmagnetostaticCursor, f : Double) -> PhysicsemmagnetostaticCursor {
  let result = physics_em_magnetostatic_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_em_magnetostatic_cursor_add(a : PhysicsemmagnetostaticCursor, b : PhysicsemmagnetostaticCursor) -> PhysicsemmagnetostaticCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_em_magnetostatic_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_em_magnetostatic_cursor_copy(s : PhysicsemmagnetostaticCursor) -> PhysicsemmagnetostaticCursor {
  let result = physics_em_magnetostatic_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_em_magnetostatic_cursor_fill(s : PhysicsemmagnetostaticCursor, v : Double) -> PhysicsemmagnetostaticCursor {
  let result = physics_em_magnetostatic_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_em_magnetostatic_cursor_min(s : PhysicsemmagnetostaticCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_em_magnetostatic_cursor_max(s : PhysicsemmagnetostaticCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_em_magnetostatic_cursor_to_string(s : PhysicsemmagnetostaticCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemmagnetostaticView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_magnetostatic_view_make(size : Int) -> PhysicsemmagnetostaticView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_magnetostatic_view_len(s : PhysicsemmagnetostaticView) -> Int { s.size }

pub fn physics_em_magnetostatic_view_get(s : PhysicsemmagnetostaticView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_magnetostatic_view_set(s : PhysicsemmagnetostaticView, i : Int, v : Double) -> PhysicsemmagnetostaticView {
  let result = physics_em_magnetostatic_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_em_magnetostatic_view_sum(s : PhysicsemmagnetostaticView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_em_magnetostatic_view_mean(s : PhysicsemmagnetostaticView) -> Double {
  if s.size == 0 { 0.0 } else { physics_em_magnetostatic_view_sum(s) / s.size.to_double() }
}

pub fn physics_em_magnetostatic_view_scale(s : PhysicsemmagnetostaticView, f : Double) -> PhysicsemmagnetostaticView {
  let result = physics_em_magnetostatic_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_em_magnetostatic_view_add(a : PhysicsemmagnetostaticView, b : PhysicsemmagnetostaticView) -> PhysicsemmagnetostaticView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_em_magnetostatic_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_em_magnetostatic_view_copy(s : PhysicsemmagnetostaticView) -> PhysicsemmagnetostaticView {
  let result = physics_em_magnetostatic_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_em_magnetostatic_view_fill(s : PhysicsemmagnetostaticView, v : Double) -> PhysicsemmagnetostaticView {
  let result = physics_em_magnetostatic_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_em_magnetostatic_view_min(s : PhysicsemmagnetostaticView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_em_magnetostatic_view_max(s : PhysicsemmagnetostaticView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_em_magnetostatic_view_to_string(s : PhysicsemmagnetostaticView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemmagnetostaticRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_magnetostatic_range_make(size : Int) -> PhysicsemmagnetostaticRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_magnetostatic_range_len(s : PhysicsemmagnetostaticRange) -> Int { s.size }

pub fn physics_em_magnetostatic_range_get(s : PhysicsemmagnetostaticRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_magnetostatic_range_set(s : PhysicsemmagnetostaticRange, i : Int, v : Double) -> PhysicsemmagnetostaticRange {
  let result = physics_em_magnetostatic_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_em_magnetostatic_range_sum(s : PhysicsemmagnetostaticRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_em_magnetostatic_range_mean(s : PhysicsemmagnetostaticRange) -> Double {
  if s.size == 0 { 0.0 } else { physics_em_magnetostatic_range_sum(s) / s.size.to_double() }
}

pub fn physics_em_magnetostatic_range_scale(s : PhysicsemmagnetostaticRange, f : Double) -> PhysicsemmagnetostaticRange {
  let result = physics_em_magnetostatic_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_em_magnetostatic_range_add(a : PhysicsemmagnetostaticRange, b : PhysicsemmagnetostaticRange) -> PhysicsemmagnetostaticRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_em_magnetostatic_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_em_magnetostatic_range_copy(s : PhysicsemmagnetostaticRange) -> PhysicsemmagnetostaticRange {
  let result = physics_em_magnetostatic_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_em_magnetostatic_range_fill(s : PhysicsemmagnetostaticRange, v : Double) -> PhysicsemmagnetostaticRange {
  let result = physics_em_magnetostatic_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_em_magnetostatic_range_min(s : PhysicsemmagnetostaticRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_em_magnetostatic_range_max(s : PhysicsemmagnetostaticRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_em_magnetostatic_range_to_string(s : PhysicsemmagnetostaticRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemmagnetostaticSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_magnetostatic_slice_make(size : Int) -> PhysicsemmagnetostaticSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_magnetostatic_slice_len(s : PhysicsemmagnetostaticSlice) -> Int { s.size }

pub fn physics_em_magnetostatic_slice_get(s : PhysicsemmagnetostaticSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_magnetostatic_slice_set(s : PhysicsemmagnetostaticSlice, i : Int, v : Double) -> PhysicsemmagnetostaticSlice {
  let result = physics_em_magnetostatic_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_em_magnetostatic_slice_sum(s : PhysicsemmagnetostaticSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_em_magnetostatic_slice_mean(s : PhysicsemmagnetostaticSlice) -> Double {
  if s.size == 0 { 0.0 } else { physics_em_magnetostatic_slice_sum(s) / s.size.to_double() }
}

pub fn physics_em_magnetostatic_slice_scale(s : PhysicsemmagnetostaticSlice, f : Double) -> PhysicsemmagnetostaticSlice {
  let result = physics_em_magnetostatic_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_em_magnetostatic_slice_add(a : PhysicsemmagnetostaticSlice, b : PhysicsemmagnetostaticSlice) -> PhysicsemmagnetostaticSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_em_magnetostatic_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_em_magnetostatic_slice_copy(s : PhysicsemmagnetostaticSlice) -> PhysicsemmagnetostaticSlice {
  let result = physics_em_magnetostatic_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_em_magnetostatic_slice_fill(s : PhysicsemmagnetostaticSlice, v : Double) -> PhysicsemmagnetostaticSlice {
  let result = physics_em_magnetostatic_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_em_magnetostatic_slice_min(s : PhysicsemmagnetostaticSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_em_magnetostatic_slice_max(s : PhysicsemmagnetostaticSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_em_magnetostatic_slice_to_string(s : PhysicsemmagnetostaticSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn physics_em_magnetostatic_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_em_magnetostatic_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_em_magnetostatic_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_em_magnetostatic_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_em_magnetostatic_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_em_magnetostatic_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_em_magnetostatic_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_em_magnetostatic_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_em_magnetostatic_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_em_magnetostatic_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_em_magnetostatic_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_em_magnetostatic_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_em_magnetostatic_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_em_magnetostatic_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_em_magnetostatic_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_em_magnetostatic_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_em_magnetostatic_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_em_magnetostatic_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_em_magnetostatic_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_em_magnetostatic_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_em_magnetostatic_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_em_magnetostatic_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_em_magnetostatic_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_em_magnetostatic_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn physics_em_magnetostatic_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

