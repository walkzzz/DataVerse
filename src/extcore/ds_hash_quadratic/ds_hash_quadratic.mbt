///===
/// extcore/ds_hash_quadratic

pub(all) struct DshashquadraticPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ds_hash_quadratic_make_point(x : Double, y : Double) -> DshashquadraticPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ds_hash_quadratic_make_point3(x : Double, y : Double, z : Double) -> DshashquadraticPoint {
  { x, y, z, label: 0 }
}

pub fn ds_hash_quadratic_point_x(pt : DshashquadraticPoint) -> Double { pt.x }

pub fn ds_hash_quadratic_point_y(pt : DshashquadraticPoint) -> Double { pt.y }

pub fn ds_hash_quadratic_point_z(pt : DshashquadraticPoint) -> Double { pt.z }

pub fn ds_hash_quadratic_point_label(pt : DshashquadraticPoint) -> Int { pt.label }

pub fn ds_hash_quadratic_point_dist(a : DshashquadraticPoint, b : DshashquadraticPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  ds_hash_quadratic_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ds_hash_quadratic_point_add(a : DshashquadraticPoint, b : DshashquadraticPoint) -> DshashquadraticPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn ds_hash_quadratic_point_sub(a : DshashquadraticPoint, b : DshashquadraticPoint) -> DshashquadraticPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn ds_hash_quadratic_point_scale(pt : DshashquadraticPoint, s : Double) -> DshashquadraticPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn ds_hash_quadratic_point_dot(a : DshashquadraticPoint, b : DshashquadraticPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn ds_hash_quadratic_point_cross(a : DshashquadraticPoint, b : DshashquadraticPoint) -> DshashquadraticPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn ds_hash_quadratic_point_norm(pt : DshashquadraticPoint) -> Double {
  ds_hash_quadratic_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn ds_hash_quadratic_point_normalize(pt : DshashquadraticPoint) -> DshashquadraticPoint {
  let n = ds_hash_quadratic_point_norm(pt)
  if n < 0.0000001 { pt } else { ds_hash_quadratic_point_scale(pt, 1.0 / n) }
}

pub fn ds_hash_quadratic_point_negate(pt : DshashquadraticPoint) -> DshashquadraticPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn ds_hash_quadratic_point_mid(a : DshashquadraticPoint, b : DshashquadraticPoint) -> DshashquadraticPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn ds_hash_quadratic_point_lerp(a : DshashquadraticPoint, b : DshashquadraticPoint, t : Double) -> DshashquadraticPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn ds_hash_quadratic_point_to_string(pt : DshashquadraticPoint) -> String {
  "(" + ds_hash_quadratic_dbl(pt.x) + ", " + ds_hash_quadratic_dbl(pt.y) + ", " + ds_hash_quadratic_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct DshashquadraticSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ds_hash_quadratic_make_series(vals : Array[Double], name : String) -> DshashquadraticSeries {
  { vals, name, meta: 0 }
}

pub fn ds_hash_quadratic_series_len(s : DshashquadraticSeries) -> Int { s.vals.length() }

pub fn ds_hash_quadratic_series_sum(s : DshashquadraticSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn ds_hash_quadratic_series_mean(s : DshashquadraticSeries) -> Double {
  let n = ds_hash_quadratic_series_len(s)
  if n == 0 { 0.0 } else { ds_hash_quadratic_series_sum(s) / n.to_double() }
}

pub fn ds_hash_quadratic_series_min(s : DshashquadraticSeries) -> Double {
  let n = ds_hash_quadratic_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn ds_hash_quadratic_series_max(s : DshashquadraticSeries) -> Double {
  let n = ds_hash_quadratic_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn ds_hash_quadratic_series_range(s : DshashquadraticSeries) -> Double {
  ds_hash_quadratic_series_max(s) - ds_hash_quadratic_series_min(s)
}

pub fn ds_hash_quadratic_series_var(s : DshashquadraticSeries) -> Double {
  let n = ds_hash_quadratic_series_len(s)
  if n == 0 { 0.0 } else {
    let m = ds_hash_quadratic_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn ds_hash_quadratic_series_std(s : DshashquadraticSeries) -> Double { ds_hash_quadratic_sqrt(ds_hash_quadratic_series_var(s)) }

pub fn ds_hash_quadratic_series_median(s : DshashquadraticSeries) -> Double {
  let n = ds_hash_quadratic_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = ds_hash_quadratic_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn ds_hash_quadratic_series_scale(s : DshashquadraticSeries, f : Double) -> DshashquadraticSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = ds_hash_quadratic_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn ds_hash_quadratic_series_add(a : DshashquadraticSeries, b : DshashquadraticSeries) -> DshashquadraticSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = ds_hash_quadratic_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn ds_hash_quadratic_series_sub(a : DshashquadraticSeries, b : DshashquadraticSeries) -> DshashquadraticSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = ds_hash_quadratic_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn ds_hash_quadratic_series_normalize(s : DshashquadraticSeries) -> DshashquadraticSeries {
  let mn = ds_hash_quadratic_series_min(s)
  let mx = ds_hash_quadratic_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = ds_hash_quadratic_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn ds_hash_quadratic_series_cumsum(s : DshashquadraticSeries) -> DshashquadraticSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = ds_hash_quadratic_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn ds_hash_quadratic_series_to_string(s : DshashquadraticSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + ds_hash_quadratic_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DshashquadraticMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ds_hash_quadratic_make_matrix(rows : Int, cols : Int, val : Double) -> DshashquadraticMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ds_hash_quadratic_matrix_identity(n : Int) -> DshashquadraticMatrix {
  let m = ds_hash_quadratic_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ds_hash_quadratic_matrix_get(m : DshashquadraticMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn ds_hash_quadratic_matrix_transpose(m : DshashquadraticMatrix) -> DshashquadraticMatrix {
  let result = ds_hash_quadratic_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn ds_hash_quadratic_matrix_add(a : DshashquadraticMatrix, b : DshashquadraticMatrix) -> DshashquadraticMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = ds_hash_quadratic_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn ds_hash_quadratic_matrix_scale(m : DshashquadraticMatrix, s : Double) -> DshashquadraticMatrix {
  let result = ds_hash_quadratic_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn ds_hash_quadratic_matrix_multiply(a : DshashquadraticMatrix, b : DshashquadraticMatrix) -> DshashquadraticMatrix {
  if a.cols != b.rows { return ds_hash_quadratic_make_matrix(a.rows, b.cols, 0.0) }
  let result = ds_hash_quadratic_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ds_hash_quadratic_matrix_trace(m : DshashquadraticMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn ds_hash_quadratic_matrix_det(m : DshashquadraticMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ds_hash_quadratic_matrix_norm(m : DshashquadraticMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  ds_hash_quadratic_sqrt(sum)
}

pub fn ds_hash_quadratic_matrix_to_string(m : DshashquadraticMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + ds_hash_quadratic_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct DshashquadraticVector {
  comps : Array[Double]
  dim : Int
}

pub fn ds_hash_quadratic_make_vector(comps : Array[Double]) -> DshashquadraticVector {
  { comps, dim: comps.length() }
}

pub fn ds_hash_quadratic_vector_zero(dim : Int) -> DshashquadraticVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ds_hash_quadratic_vector_add(a : DshashquadraticVector, b : DshashquadraticVector) -> DshashquadraticVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = ds_hash_quadratic_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ds_hash_quadratic_vector_sub(a : DshashquadraticVector, b : DshashquadraticVector) -> DshashquadraticVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = ds_hash_quadratic_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ds_hash_quadratic_vector_scale(v : DshashquadraticVector, s : Double) -> DshashquadraticVector {
  let mut result = []
  for i in 0..<v.dim { result = ds_hash_quadratic_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn ds_hash_quadratic_vector_dot(a : DshashquadraticVector, b : DshashquadraticVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn ds_hash_quadratic_vector_norm(v : DshashquadraticVector) -> Double { ds_hash_quadratic_sqrt(ds_hash_quadratic_vector_dot(v, v)) }

pub fn ds_hash_quadratic_vector_normalize(v : DshashquadraticVector) -> DshashquadraticVector {
  let n = ds_hash_quadratic_vector_norm(v)
  if n < 0.0000001 { v } else { ds_hash_quadratic_vector_scale(v, 1.0 / n) }
}

pub fn ds_hash_quadratic_vector_dist(a : DshashquadraticVector, b : DshashquadraticVector) -> Double {
  ds_hash_quadratic_vector_norm(ds_hash_quadratic_vector_sub(a, b))
}

pub fn ds_hash_quadratic_vector_to_string(v : DshashquadraticVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + ds_hash_quadratic_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ds_hash_quadratic_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn ds_hash_quadratic_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = ds_hash_quadratic_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn ds_hash_quadratic_std(data : Array[Double]) -> Double { ds_hash_quadratic_sqrt(ds_hash_quadratic_var(data)) }

pub fn ds_hash_quadratic_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = ds_hash_quadratic_mean(a); let mb = ds_hash_quadratic_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn ds_hash_quadratic_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = ds_hash_quadratic_std(a); let sb = ds_hash_quadratic_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { ds_hash_quadratic_cov(a, b) / (sa * sb) }
}

pub fn ds_hash_quadratic_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = ds_hash_quadratic_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn ds_hash_quadratic_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn ds_hash_quadratic_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn ds_hash_quadratic_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  ds_hash_quadratic_sqrt(ds_hash_quadratic_mse(pred, labels))
}

pub fn ds_hash_quadratic_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + ds_hash_quadratic_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn ds_hash_quadratic_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = ds_hash_quadratic_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn ds_hash_quadratic_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn ds_hash_quadratic_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn ds_hash_quadratic_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = ds_hash_quadratic_precision(pred, labels, pos); let r = ds_hash_quadratic_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn ds_hash_quadratic_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn ds_hash_quadratic_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = ds_hash_quadratic_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn ds_hash_quadratic_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn ds_hash_quadratic_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn ds_hash_quadratic_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = ds_hash_quadratic_gcd(a, b)
    (a / g) * b
  }
}

pub fn ds_hash_quadratic_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn ds_hash_quadratic_fibonacci(n : Int) -> Int {
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

pub fn ds_hash_quadratic_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = ds_hash_quadratic_min(data); let mx = ds_hash_quadratic_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn ds_hash_quadratic_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = ds_hash_quadratic_mean(data); let sd = ds_hash_quadratic_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn ds_hash_quadratic_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn ds_hash_quadratic_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn ds_hash_quadratic_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn ds_hash_quadratic_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn ds_hash_quadratic_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn ds_hash_quadratic_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn ds_hash_quadratic_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn ds_hash_quadratic_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn ds_hash_quadratic_dbl(x : Double) -> String {
  let i = if x >= 0.0 { ds_hash_quadratic_int(x) } else { -ds_hash_quadratic_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { ds_hash_quadratic_int(f * 1000000.0) } else { ds_hash_quadratic_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn ds_hash_quadratic_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn ds_hash_quadratic_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct DshashquadraticFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_quadratic_frame_make(size : Int) -> DshashquadraticFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_quadratic_frame_len(s : DshashquadraticFrame) -> Int { s.size }

pub fn ds_hash_quadratic_frame_get(s : DshashquadraticFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_quadratic_frame_set(s : DshashquadraticFrame, i : Int, v : Double) -> DshashquadraticFrame {
  let result = ds_hash_quadratic_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_hash_quadratic_frame_sum(s : DshashquadraticFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_hash_quadratic_frame_mean(s : DshashquadraticFrame) -> Double {
  if s.size == 0 { 0.0 } else { ds_hash_quadratic_frame_sum(s) / s.size.to_double() }
}

pub fn ds_hash_quadratic_frame_scale(s : DshashquadraticFrame, f : Double) -> DshashquadraticFrame {
  let result = ds_hash_quadratic_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_hash_quadratic_frame_add(a : DshashquadraticFrame, b : DshashquadraticFrame) -> DshashquadraticFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_hash_quadratic_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_hash_quadratic_frame_copy(s : DshashquadraticFrame) -> DshashquadraticFrame {
  let result = ds_hash_quadratic_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_hash_quadratic_frame_fill(s : DshashquadraticFrame, v : Double) -> DshashquadraticFrame {
  let result = ds_hash_quadratic_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_hash_quadratic_frame_min(s : DshashquadraticFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_quadratic_frame_max(s : DshashquadraticFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_quadratic_frame_to_string(s : DshashquadraticFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashquadraticTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_quadratic_table_make(size : Int) -> DshashquadraticTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_quadratic_table_len(s : DshashquadraticTable) -> Int { s.size }

pub fn ds_hash_quadratic_table_get(s : DshashquadraticTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_quadratic_table_set(s : DshashquadraticTable, i : Int, v : Double) -> DshashquadraticTable {
  let result = ds_hash_quadratic_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_hash_quadratic_table_sum(s : DshashquadraticTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_hash_quadratic_table_mean(s : DshashquadraticTable) -> Double {
  if s.size == 0 { 0.0 } else { ds_hash_quadratic_table_sum(s) / s.size.to_double() }
}

pub fn ds_hash_quadratic_table_scale(s : DshashquadraticTable, f : Double) -> DshashquadraticTable {
  let result = ds_hash_quadratic_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_hash_quadratic_table_add(a : DshashquadraticTable, b : DshashquadraticTable) -> DshashquadraticTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_hash_quadratic_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_hash_quadratic_table_copy(s : DshashquadraticTable) -> DshashquadraticTable {
  let result = ds_hash_quadratic_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_hash_quadratic_table_fill(s : DshashquadraticTable, v : Double) -> DshashquadraticTable {
  let result = ds_hash_quadratic_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_hash_quadratic_table_min(s : DshashquadraticTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_quadratic_table_max(s : DshashquadraticTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_quadratic_table_to_string(s : DshashquadraticTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashquadraticGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_quadratic_graphn_make(size : Int) -> DshashquadraticGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_quadratic_graphn_len(s : DshashquadraticGraphN) -> Int { s.size }

pub fn ds_hash_quadratic_graphn_get(s : DshashquadraticGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_quadratic_graphn_set(s : DshashquadraticGraphN, i : Int, v : Double) -> DshashquadraticGraphN {
  let result = ds_hash_quadratic_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_hash_quadratic_graphn_sum(s : DshashquadraticGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_hash_quadratic_graphn_mean(s : DshashquadraticGraphN) -> Double {
  if s.size == 0 { 0.0 } else { ds_hash_quadratic_graphn_sum(s) / s.size.to_double() }
}

pub fn ds_hash_quadratic_graphn_scale(s : DshashquadraticGraphN, f : Double) -> DshashquadraticGraphN {
  let result = ds_hash_quadratic_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_hash_quadratic_graphn_add(a : DshashquadraticGraphN, b : DshashquadraticGraphN) -> DshashquadraticGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_hash_quadratic_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_hash_quadratic_graphn_copy(s : DshashquadraticGraphN) -> DshashquadraticGraphN {
  let result = ds_hash_quadratic_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_hash_quadratic_graphn_fill(s : DshashquadraticGraphN, v : Double) -> DshashquadraticGraphN {
  let result = ds_hash_quadratic_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_hash_quadratic_graphn_min(s : DshashquadraticGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_quadratic_graphn_max(s : DshashquadraticGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_quadratic_graphn_to_string(s : DshashquadraticGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashquadraticNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_quadratic_node_make(size : Int) -> DshashquadraticNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_quadratic_node_len(s : DshashquadraticNode) -> Int { s.size }

pub fn ds_hash_quadratic_node_get(s : DshashquadraticNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_quadratic_node_set(s : DshashquadraticNode, i : Int, v : Double) -> DshashquadraticNode {
  let result = ds_hash_quadratic_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_hash_quadratic_node_sum(s : DshashquadraticNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_hash_quadratic_node_mean(s : DshashquadraticNode) -> Double {
  if s.size == 0 { 0.0 } else { ds_hash_quadratic_node_sum(s) / s.size.to_double() }
}

pub fn ds_hash_quadratic_node_scale(s : DshashquadraticNode, f : Double) -> DshashquadraticNode {
  let result = ds_hash_quadratic_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_hash_quadratic_node_add(a : DshashquadraticNode, b : DshashquadraticNode) -> DshashquadraticNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_hash_quadratic_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_hash_quadratic_node_copy(s : DshashquadraticNode) -> DshashquadraticNode {
  let result = ds_hash_quadratic_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_hash_quadratic_node_fill(s : DshashquadraticNode, v : Double) -> DshashquadraticNode {
  let result = ds_hash_quadratic_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_hash_quadratic_node_min(s : DshashquadraticNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_quadratic_node_max(s : DshashquadraticNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_quadratic_node_to_string(s : DshashquadraticNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashquadraticEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_quadratic_edge_make(size : Int) -> DshashquadraticEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_quadratic_edge_len(s : DshashquadraticEdge) -> Int { s.size }

pub fn ds_hash_quadratic_edge_get(s : DshashquadraticEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_quadratic_edge_set(s : DshashquadraticEdge, i : Int, v : Double) -> DshashquadraticEdge {
  let result = ds_hash_quadratic_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_hash_quadratic_edge_sum(s : DshashquadraticEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_hash_quadratic_edge_mean(s : DshashquadraticEdge) -> Double {
  if s.size == 0 { 0.0 } else { ds_hash_quadratic_edge_sum(s) / s.size.to_double() }
}

pub fn ds_hash_quadratic_edge_scale(s : DshashquadraticEdge, f : Double) -> DshashquadraticEdge {
  let result = ds_hash_quadratic_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_hash_quadratic_edge_add(a : DshashquadraticEdge, b : DshashquadraticEdge) -> DshashquadraticEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_hash_quadratic_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_hash_quadratic_edge_copy(s : DshashquadraticEdge) -> DshashquadraticEdge {
  let result = ds_hash_quadratic_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_hash_quadratic_edge_fill(s : DshashquadraticEdge, v : Double) -> DshashquadraticEdge {
  let result = ds_hash_quadratic_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_hash_quadratic_edge_min(s : DshashquadraticEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_quadratic_edge_max(s : DshashquadraticEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_quadratic_edge_to_string(s : DshashquadraticEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashquadraticPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_quadratic_path_make(size : Int) -> DshashquadraticPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_quadratic_path_len(s : DshashquadraticPath) -> Int { s.size }

pub fn ds_hash_quadratic_path_get(s : DshashquadraticPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_quadratic_path_set(s : DshashquadraticPath, i : Int, v : Double) -> DshashquadraticPath {
  let result = ds_hash_quadratic_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_hash_quadratic_path_sum(s : DshashquadraticPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_hash_quadratic_path_mean(s : DshashquadraticPath) -> Double {
  if s.size == 0 { 0.0 } else { ds_hash_quadratic_path_sum(s) / s.size.to_double() }
}

pub fn ds_hash_quadratic_path_scale(s : DshashquadraticPath, f : Double) -> DshashquadraticPath {
  let result = ds_hash_quadratic_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_hash_quadratic_path_add(a : DshashquadraticPath, b : DshashquadraticPath) -> DshashquadraticPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_hash_quadratic_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_hash_quadratic_path_copy(s : DshashquadraticPath) -> DshashquadraticPath {
  let result = ds_hash_quadratic_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_hash_quadratic_path_fill(s : DshashquadraticPath, v : Double) -> DshashquadraticPath {
  let result = ds_hash_quadratic_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_hash_quadratic_path_min(s : DshashquadraticPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_quadratic_path_max(s : DshashquadraticPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_quadratic_path_to_string(s : DshashquadraticPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashquadraticCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_quadratic_cluster_make(size : Int) -> DshashquadraticCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_quadratic_cluster_len(s : DshashquadraticCluster) -> Int { s.size }

pub fn ds_hash_quadratic_cluster_get(s : DshashquadraticCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_quadratic_cluster_set(s : DshashquadraticCluster, i : Int, v : Double) -> DshashquadraticCluster {
  let result = ds_hash_quadratic_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_hash_quadratic_cluster_sum(s : DshashquadraticCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_hash_quadratic_cluster_mean(s : DshashquadraticCluster) -> Double {
  if s.size == 0 { 0.0 } else { ds_hash_quadratic_cluster_sum(s) / s.size.to_double() }
}

pub fn ds_hash_quadratic_cluster_scale(s : DshashquadraticCluster, f : Double) -> DshashquadraticCluster {
  let result = ds_hash_quadratic_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_hash_quadratic_cluster_add(a : DshashquadraticCluster, b : DshashquadraticCluster) -> DshashquadraticCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_hash_quadratic_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_hash_quadratic_cluster_copy(s : DshashquadraticCluster) -> DshashquadraticCluster {
  let result = ds_hash_quadratic_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_hash_quadratic_cluster_fill(s : DshashquadraticCluster, v : Double) -> DshashquadraticCluster {
  let result = ds_hash_quadratic_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_hash_quadratic_cluster_min(s : DshashquadraticCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_quadratic_cluster_max(s : DshashquadraticCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_quadratic_cluster_to_string(s : DshashquadraticCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashquadraticModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_quadratic_model_make(size : Int) -> DshashquadraticModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_quadratic_model_len(s : DshashquadraticModel) -> Int { s.size }

pub fn ds_hash_quadratic_model_get(s : DshashquadraticModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_quadratic_model_set(s : DshashquadraticModel, i : Int, v : Double) -> DshashquadraticModel {
  let result = ds_hash_quadratic_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_hash_quadratic_model_sum(s : DshashquadraticModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_hash_quadratic_model_mean(s : DshashquadraticModel) -> Double {
  if s.size == 0 { 0.0 } else { ds_hash_quadratic_model_sum(s) / s.size.to_double() }
}

pub fn ds_hash_quadratic_model_scale(s : DshashquadraticModel, f : Double) -> DshashquadraticModel {
  let result = ds_hash_quadratic_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_hash_quadratic_model_add(a : DshashquadraticModel, b : DshashquadraticModel) -> DshashquadraticModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_hash_quadratic_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_hash_quadratic_model_copy(s : DshashquadraticModel) -> DshashquadraticModel {
  let result = ds_hash_quadratic_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_hash_quadratic_model_fill(s : DshashquadraticModel, v : Double) -> DshashquadraticModel {
  let result = ds_hash_quadratic_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_hash_quadratic_model_min(s : DshashquadraticModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_quadratic_model_max(s : DshashquadraticModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_quadratic_model_to_string(s : DshashquadraticModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashquadraticLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_quadratic_layer_make(size : Int) -> DshashquadraticLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_quadratic_layer_len(s : DshashquadraticLayer) -> Int { s.size }

pub fn ds_hash_quadratic_layer_get(s : DshashquadraticLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_quadratic_layer_set(s : DshashquadraticLayer, i : Int, v : Double) -> DshashquadraticLayer {
  let result = ds_hash_quadratic_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_hash_quadratic_layer_sum(s : DshashquadraticLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_hash_quadratic_layer_mean(s : DshashquadraticLayer) -> Double {
  if s.size == 0 { 0.0 } else { ds_hash_quadratic_layer_sum(s) / s.size.to_double() }
}

pub fn ds_hash_quadratic_layer_scale(s : DshashquadraticLayer, f : Double) -> DshashquadraticLayer {
  let result = ds_hash_quadratic_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_hash_quadratic_layer_add(a : DshashquadraticLayer, b : DshashquadraticLayer) -> DshashquadraticLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_hash_quadratic_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_hash_quadratic_layer_copy(s : DshashquadraticLayer) -> DshashquadraticLayer {
  let result = ds_hash_quadratic_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_hash_quadratic_layer_fill(s : DshashquadraticLayer, v : Double) -> DshashquadraticLayer {
  let result = ds_hash_quadratic_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_hash_quadratic_layer_min(s : DshashquadraticLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_quadratic_layer_max(s : DshashquadraticLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_quadratic_layer_to_string(s : DshashquadraticLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashquadraticBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_quadratic_buffer_make(size : Int) -> DshashquadraticBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_quadratic_buffer_len(s : DshashquadraticBuffer) -> Int { s.size }

pub fn ds_hash_quadratic_buffer_get(s : DshashquadraticBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_quadratic_buffer_set(s : DshashquadraticBuffer, i : Int, v : Double) -> DshashquadraticBuffer {
  let result = ds_hash_quadratic_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_hash_quadratic_buffer_sum(s : DshashquadraticBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_hash_quadratic_buffer_mean(s : DshashquadraticBuffer) -> Double {
  if s.size == 0 { 0.0 } else { ds_hash_quadratic_buffer_sum(s) / s.size.to_double() }
}

pub fn ds_hash_quadratic_buffer_scale(s : DshashquadraticBuffer, f : Double) -> DshashquadraticBuffer {
  let result = ds_hash_quadratic_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_hash_quadratic_buffer_add(a : DshashquadraticBuffer, b : DshashquadraticBuffer) -> DshashquadraticBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_hash_quadratic_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_hash_quadratic_buffer_copy(s : DshashquadraticBuffer) -> DshashquadraticBuffer {
  let result = ds_hash_quadratic_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_hash_quadratic_buffer_fill(s : DshashquadraticBuffer, v : Double) -> DshashquadraticBuffer {
  let result = ds_hash_quadratic_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_hash_quadratic_buffer_min(s : DshashquadraticBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_quadratic_buffer_max(s : DshashquadraticBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_quadratic_buffer_to_string(s : DshashquadraticBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashquadraticCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_quadratic_cursor_make(size : Int) -> DshashquadraticCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_quadratic_cursor_len(s : DshashquadraticCursor) -> Int { s.size }

pub fn ds_hash_quadratic_cursor_get(s : DshashquadraticCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_quadratic_cursor_set(s : DshashquadraticCursor, i : Int, v : Double) -> DshashquadraticCursor {
  let result = ds_hash_quadratic_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_hash_quadratic_cursor_sum(s : DshashquadraticCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_hash_quadratic_cursor_mean(s : DshashquadraticCursor) -> Double {
  if s.size == 0 { 0.0 } else { ds_hash_quadratic_cursor_sum(s) / s.size.to_double() }
}

pub fn ds_hash_quadratic_cursor_scale(s : DshashquadraticCursor, f : Double) -> DshashquadraticCursor {
  let result = ds_hash_quadratic_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_hash_quadratic_cursor_add(a : DshashquadraticCursor, b : DshashquadraticCursor) -> DshashquadraticCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_hash_quadratic_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_hash_quadratic_cursor_copy(s : DshashquadraticCursor) -> DshashquadraticCursor {
  let result = ds_hash_quadratic_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_hash_quadratic_cursor_fill(s : DshashquadraticCursor, v : Double) -> DshashquadraticCursor {
  let result = ds_hash_quadratic_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_hash_quadratic_cursor_min(s : DshashquadraticCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_quadratic_cursor_max(s : DshashquadraticCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_quadratic_cursor_to_string(s : DshashquadraticCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashquadraticView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_quadratic_view_make(size : Int) -> DshashquadraticView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_quadratic_view_len(s : DshashquadraticView) -> Int { s.size }

pub fn ds_hash_quadratic_view_get(s : DshashquadraticView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_quadratic_view_set(s : DshashquadraticView, i : Int, v : Double) -> DshashquadraticView {
  let result = ds_hash_quadratic_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_hash_quadratic_view_sum(s : DshashquadraticView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_hash_quadratic_view_mean(s : DshashquadraticView) -> Double {
  if s.size == 0 { 0.0 } else { ds_hash_quadratic_view_sum(s) / s.size.to_double() }
}

pub fn ds_hash_quadratic_view_scale(s : DshashquadraticView, f : Double) -> DshashquadraticView {
  let result = ds_hash_quadratic_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_hash_quadratic_view_add(a : DshashquadraticView, b : DshashquadraticView) -> DshashquadraticView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_hash_quadratic_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_hash_quadratic_view_copy(s : DshashquadraticView) -> DshashquadraticView {
  let result = ds_hash_quadratic_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_hash_quadratic_view_fill(s : DshashquadraticView, v : Double) -> DshashquadraticView {
  let result = ds_hash_quadratic_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_hash_quadratic_view_min(s : DshashquadraticView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_quadratic_view_max(s : DshashquadraticView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_quadratic_view_to_string(s : DshashquadraticView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashquadraticRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_quadratic_range_make(size : Int) -> DshashquadraticRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_quadratic_range_len(s : DshashquadraticRange) -> Int { s.size }

pub fn ds_hash_quadratic_range_get(s : DshashquadraticRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_quadratic_range_set(s : DshashquadraticRange, i : Int, v : Double) -> DshashquadraticRange {
  let result = ds_hash_quadratic_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_hash_quadratic_range_sum(s : DshashquadraticRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_hash_quadratic_range_mean(s : DshashquadraticRange) -> Double {
  if s.size == 0 { 0.0 } else { ds_hash_quadratic_range_sum(s) / s.size.to_double() }
}

pub fn ds_hash_quadratic_range_scale(s : DshashquadraticRange, f : Double) -> DshashquadraticRange {
  let result = ds_hash_quadratic_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_hash_quadratic_range_add(a : DshashquadraticRange, b : DshashquadraticRange) -> DshashquadraticRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_hash_quadratic_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_hash_quadratic_range_copy(s : DshashquadraticRange) -> DshashquadraticRange {
  let result = ds_hash_quadratic_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_hash_quadratic_range_fill(s : DshashquadraticRange, v : Double) -> DshashquadraticRange {
  let result = ds_hash_quadratic_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_hash_quadratic_range_min(s : DshashquadraticRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_quadratic_range_max(s : DshashquadraticRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_quadratic_range_to_string(s : DshashquadraticRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashquadraticSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_quadratic_slice_make(size : Int) -> DshashquadraticSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_quadratic_slice_len(s : DshashquadraticSlice) -> Int { s.size }

pub fn ds_hash_quadratic_slice_get(s : DshashquadraticSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_quadratic_slice_set(s : DshashquadraticSlice, i : Int, v : Double) -> DshashquadraticSlice {
  let result = ds_hash_quadratic_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_hash_quadratic_slice_sum(s : DshashquadraticSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_hash_quadratic_slice_mean(s : DshashquadraticSlice) -> Double {
  if s.size == 0 { 0.0 } else { ds_hash_quadratic_slice_sum(s) / s.size.to_double() }
}

pub fn ds_hash_quadratic_slice_scale(s : DshashquadraticSlice, f : Double) -> DshashquadraticSlice {
  let result = ds_hash_quadratic_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_hash_quadratic_slice_add(a : DshashquadraticSlice, b : DshashquadraticSlice) -> DshashquadraticSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_hash_quadratic_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_hash_quadratic_slice_copy(s : DshashquadraticSlice) -> DshashquadraticSlice {
  let result = ds_hash_quadratic_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_hash_quadratic_slice_fill(s : DshashquadraticSlice, v : Double) -> DshashquadraticSlice {
  let result = ds_hash_quadratic_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_hash_quadratic_slice_min(s : DshashquadraticSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_quadratic_slice_max(s : DshashquadraticSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_quadratic_slice_to_string(s : DshashquadraticSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn ds_hash_quadratic_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_hash_quadratic_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_hash_quadratic_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_hash_quadratic_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_hash_quadratic_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_hash_quadratic_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_hash_quadratic_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_hash_quadratic_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_hash_quadratic_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_hash_quadratic_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_hash_quadratic_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_hash_quadratic_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_hash_quadratic_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_hash_quadratic_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_hash_quadratic_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_hash_quadratic_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_hash_quadratic_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_hash_quadratic_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_hash_quadratic_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_hash_quadratic_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_hash_quadratic_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_hash_quadratic_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_hash_quadratic_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_hash_quadratic_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_hash_quadratic_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

