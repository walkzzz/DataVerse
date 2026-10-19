///===
/// extcore/geo_dist_spherical

pub(all) struct GeodistsphericalPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn geo_dist_spherical_make_point(x : Double, y : Double) -> GeodistsphericalPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn geo_dist_spherical_make_point3(x : Double, y : Double, z : Double) -> GeodistsphericalPoint {
  { x, y, z, label: 0 }
}

pub fn geo_dist_spherical_point_x(pt : GeodistsphericalPoint) -> Double { pt.x }

pub fn geo_dist_spherical_point_y(pt : GeodistsphericalPoint) -> Double { pt.y }

pub fn geo_dist_spherical_point_z(pt : GeodistsphericalPoint) -> Double { pt.z }

pub fn geo_dist_spherical_point_label(pt : GeodistsphericalPoint) -> Int { pt.label }

pub fn geo_dist_spherical_point_dist(a : GeodistsphericalPoint, b : GeodistsphericalPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  geo_dist_spherical_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn geo_dist_spherical_point_add(a : GeodistsphericalPoint, b : GeodistsphericalPoint) -> GeodistsphericalPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn geo_dist_spherical_point_sub(a : GeodistsphericalPoint, b : GeodistsphericalPoint) -> GeodistsphericalPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn geo_dist_spherical_point_scale(pt : GeodistsphericalPoint, s : Double) -> GeodistsphericalPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn geo_dist_spherical_point_dot(a : GeodistsphericalPoint, b : GeodistsphericalPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn geo_dist_spherical_point_cross(a : GeodistsphericalPoint, b : GeodistsphericalPoint) -> GeodistsphericalPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn geo_dist_spherical_point_norm(pt : GeodistsphericalPoint) -> Double {
  geo_dist_spherical_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn geo_dist_spherical_point_normalize(pt : GeodistsphericalPoint) -> GeodistsphericalPoint {
  let n = geo_dist_spherical_point_norm(pt)
  if n < 0.0000001 { pt } else { geo_dist_spherical_point_scale(pt, 1.0 / n) }
}

pub fn geo_dist_spherical_point_negate(pt : GeodistsphericalPoint) -> GeodistsphericalPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn geo_dist_spherical_point_mid(a : GeodistsphericalPoint, b : GeodistsphericalPoint) -> GeodistsphericalPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn geo_dist_spherical_point_lerp(a : GeodistsphericalPoint, b : GeodistsphericalPoint, t : Double) -> GeodistsphericalPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn geo_dist_spherical_point_to_string(pt : GeodistsphericalPoint) -> String {
  "(" + geo_dist_spherical_dbl(pt.x) + ", " + geo_dist_spherical_dbl(pt.y) + ", " + geo_dist_spherical_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct GeodistsphericalSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn geo_dist_spherical_make_series(vals : Array[Double], name : String) -> GeodistsphericalSeries {
  { vals, name, meta: 0 }
}

pub fn geo_dist_spherical_series_len(s : GeodistsphericalSeries) -> Int { s.vals.length() }

pub fn geo_dist_spherical_series_sum(s : GeodistsphericalSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn geo_dist_spherical_series_mean(s : GeodistsphericalSeries) -> Double {
  let n = geo_dist_spherical_series_len(s)
  if n == 0 { 0.0 } else { geo_dist_spherical_series_sum(s) / n.to_double() }
}

pub fn geo_dist_spherical_series_min(s : GeodistsphericalSeries) -> Double {
  let n = geo_dist_spherical_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn geo_dist_spherical_series_max(s : GeodistsphericalSeries) -> Double {
  let n = geo_dist_spherical_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn geo_dist_spherical_series_range(s : GeodistsphericalSeries) -> Double {
  geo_dist_spherical_series_max(s) - geo_dist_spherical_series_min(s)
}

pub fn geo_dist_spherical_series_var(s : GeodistsphericalSeries) -> Double {
  let n = geo_dist_spherical_series_len(s)
  if n == 0 { 0.0 } else {
    let m = geo_dist_spherical_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn geo_dist_spherical_series_std(s : GeodistsphericalSeries) -> Double { geo_dist_spherical_sqrt(geo_dist_spherical_series_var(s)) }

pub fn geo_dist_spherical_series_median(s : GeodistsphericalSeries) -> Double {
  let n = geo_dist_spherical_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = geo_dist_spherical_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn geo_dist_spherical_series_scale(s : GeodistsphericalSeries, f : Double) -> GeodistsphericalSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = geo_dist_spherical_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn geo_dist_spherical_series_add(a : GeodistsphericalSeries, b : GeodistsphericalSeries) -> GeodistsphericalSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = geo_dist_spherical_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn geo_dist_spherical_series_sub(a : GeodistsphericalSeries, b : GeodistsphericalSeries) -> GeodistsphericalSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = geo_dist_spherical_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn geo_dist_spherical_series_normalize(s : GeodistsphericalSeries) -> GeodistsphericalSeries {
  let mn = geo_dist_spherical_series_min(s)
  let mx = geo_dist_spherical_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = geo_dist_spherical_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn geo_dist_spherical_series_cumsum(s : GeodistsphericalSeries) -> GeodistsphericalSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = geo_dist_spherical_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn geo_dist_spherical_series_to_string(s : GeodistsphericalSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + geo_dist_spherical_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GeodistsphericalMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn geo_dist_spherical_make_matrix(rows : Int, cols : Int, val : Double) -> GeodistsphericalMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn geo_dist_spherical_matrix_identity(n : Int) -> GeodistsphericalMatrix {
  let m = geo_dist_spherical_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn geo_dist_spherical_matrix_get(m : GeodistsphericalMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn geo_dist_spherical_matrix_transpose(m : GeodistsphericalMatrix) -> GeodistsphericalMatrix {
  let result = geo_dist_spherical_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn geo_dist_spherical_matrix_add(a : GeodistsphericalMatrix, b : GeodistsphericalMatrix) -> GeodistsphericalMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = geo_dist_spherical_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn geo_dist_spherical_matrix_scale(m : GeodistsphericalMatrix, s : Double) -> GeodistsphericalMatrix {
  let result = geo_dist_spherical_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn geo_dist_spherical_matrix_multiply(a : GeodistsphericalMatrix, b : GeodistsphericalMatrix) -> GeodistsphericalMatrix {
  if a.cols != b.rows { return geo_dist_spherical_make_matrix(a.rows, b.cols, 0.0) }
  let result = geo_dist_spherical_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn geo_dist_spherical_matrix_trace(m : GeodistsphericalMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn geo_dist_spherical_matrix_det(m : GeodistsphericalMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn geo_dist_spherical_matrix_norm(m : GeodistsphericalMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  geo_dist_spherical_sqrt(sum)
}

pub fn geo_dist_spherical_matrix_to_string(m : GeodistsphericalMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + geo_dist_spherical_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct GeodistsphericalVector {
  comps : Array[Double]
  dim : Int
}

pub fn geo_dist_spherical_make_vector(comps : Array[Double]) -> GeodistsphericalVector {
  { comps, dim: comps.length() }
}

pub fn geo_dist_spherical_vector_zero(dim : Int) -> GeodistsphericalVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn geo_dist_spherical_vector_add(a : GeodistsphericalVector, b : GeodistsphericalVector) -> GeodistsphericalVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = geo_dist_spherical_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn geo_dist_spherical_vector_sub(a : GeodistsphericalVector, b : GeodistsphericalVector) -> GeodistsphericalVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = geo_dist_spherical_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn geo_dist_spherical_vector_scale(v : GeodistsphericalVector, s : Double) -> GeodistsphericalVector {
  let mut result = []
  for i in 0..<v.dim { result = geo_dist_spherical_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn geo_dist_spherical_vector_dot(a : GeodistsphericalVector, b : GeodistsphericalVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn geo_dist_spherical_vector_norm(v : GeodistsphericalVector) -> Double { geo_dist_spherical_sqrt(geo_dist_spherical_vector_dot(v, v)) }

pub fn geo_dist_spherical_vector_normalize(v : GeodistsphericalVector) -> GeodistsphericalVector {
  let n = geo_dist_spherical_vector_norm(v)
  if n < 0.0000001 { v } else { geo_dist_spherical_vector_scale(v, 1.0 / n) }
}

pub fn geo_dist_spherical_vector_dist(a : GeodistsphericalVector, b : GeodistsphericalVector) -> Double {
  geo_dist_spherical_vector_norm(geo_dist_spherical_vector_sub(a, b))
}

pub fn geo_dist_spherical_vector_to_string(v : GeodistsphericalVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + geo_dist_spherical_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn geo_dist_spherical_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn geo_dist_spherical_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = geo_dist_spherical_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn geo_dist_spherical_std(data : Array[Double]) -> Double { geo_dist_spherical_sqrt(geo_dist_spherical_var(data)) }

pub fn geo_dist_spherical_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = geo_dist_spherical_mean(a); let mb = geo_dist_spherical_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn geo_dist_spherical_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = geo_dist_spherical_std(a); let sb = geo_dist_spherical_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { geo_dist_spherical_cov(a, b) / (sa * sb) }
}

pub fn geo_dist_spherical_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = geo_dist_spherical_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn geo_dist_spherical_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn geo_dist_spherical_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn geo_dist_spherical_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  geo_dist_spherical_sqrt(geo_dist_spherical_mse(pred, labels))
}

pub fn geo_dist_spherical_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + geo_dist_spherical_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn geo_dist_spherical_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = geo_dist_spherical_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn geo_dist_spherical_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn geo_dist_spherical_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn geo_dist_spherical_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = geo_dist_spherical_precision(pred, labels, pos); let r = geo_dist_spherical_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn geo_dist_spherical_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn geo_dist_spherical_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = geo_dist_spherical_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn geo_dist_spherical_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn geo_dist_spherical_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn geo_dist_spherical_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = geo_dist_spherical_gcd(a, b)
    (a / g) * b
  }
}

pub fn geo_dist_spherical_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn geo_dist_spherical_fibonacci(n : Int) -> Int {
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

pub fn geo_dist_spherical_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = geo_dist_spherical_min(data); let mx = geo_dist_spherical_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn geo_dist_spherical_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = geo_dist_spherical_mean(data); let sd = geo_dist_spherical_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn geo_dist_spherical_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn geo_dist_spherical_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn geo_dist_spherical_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn geo_dist_spherical_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn geo_dist_spherical_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn geo_dist_spherical_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn geo_dist_spherical_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn geo_dist_spherical_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn geo_dist_spherical_dbl(x : Double) -> String {
  let i = if x >= 0.0 { geo_dist_spherical_int(x) } else { -geo_dist_spherical_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { geo_dist_spherical_int(f * 1000000.0) } else { geo_dist_spherical_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn geo_dist_spherical_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn geo_dist_spherical_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct GeodistsphericalFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_spherical_frame_make(size : Int) -> GeodistsphericalFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_spherical_frame_len(s : GeodistsphericalFrame) -> Int { s.size }

pub fn geo_dist_spherical_frame_get(s : GeodistsphericalFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_spherical_frame_set(s : GeodistsphericalFrame, i : Int, v : Double) -> GeodistsphericalFrame {
  let result = geo_dist_spherical_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_dist_spherical_frame_sum(s : GeodistsphericalFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_dist_spherical_frame_mean(s : GeodistsphericalFrame) -> Double {
  if s.size == 0 { 0.0 } else { geo_dist_spherical_frame_sum(s) / s.size.to_double() }
}

pub fn geo_dist_spherical_frame_scale(s : GeodistsphericalFrame, f : Double) -> GeodistsphericalFrame {
  let result = geo_dist_spherical_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_dist_spherical_frame_add(a : GeodistsphericalFrame, b : GeodistsphericalFrame) -> GeodistsphericalFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_dist_spherical_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_dist_spherical_frame_copy(s : GeodistsphericalFrame) -> GeodistsphericalFrame {
  let result = geo_dist_spherical_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_dist_spherical_frame_fill(s : GeodistsphericalFrame, v : Double) -> GeodistsphericalFrame {
  let result = geo_dist_spherical_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_dist_spherical_frame_min(s : GeodistsphericalFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_spherical_frame_max(s : GeodistsphericalFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_spherical_frame_to_string(s : GeodistsphericalFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistsphericalTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_spherical_table_make(size : Int) -> GeodistsphericalTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_spherical_table_len(s : GeodistsphericalTable) -> Int { s.size }

pub fn geo_dist_spherical_table_get(s : GeodistsphericalTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_spherical_table_set(s : GeodistsphericalTable, i : Int, v : Double) -> GeodistsphericalTable {
  let result = geo_dist_spherical_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_dist_spherical_table_sum(s : GeodistsphericalTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_dist_spherical_table_mean(s : GeodistsphericalTable) -> Double {
  if s.size == 0 { 0.0 } else { geo_dist_spherical_table_sum(s) / s.size.to_double() }
}

pub fn geo_dist_spherical_table_scale(s : GeodistsphericalTable, f : Double) -> GeodistsphericalTable {
  let result = geo_dist_spherical_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_dist_spherical_table_add(a : GeodistsphericalTable, b : GeodistsphericalTable) -> GeodistsphericalTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_dist_spherical_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_dist_spherical_table_copy(s : GeodistsphericalTable) -> GeodistsphericalTable {
  let result = geo_dist_spherical_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_dist_spherical_table_fill(s : GeodistsphericalTable, v : Double) -> GeodistsphericalTable {
  let result = geo_dist_spherical_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_dist_spherical_table_min(s : GeodistsphericalTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_spherical_table_max(s : GeodistsphericalTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_spherical_table_to_string(s : GeodistsphericalTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistsphericalGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_spherical_graphn_make(size : Int) -> GeodistsphericalGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_spherical_graphn_len(s : GeodistsphericalGraphN) -> Int { s.size }

pub fn geo_dist_spherical_graphn_get(s : GeodistsphericalGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_spherical_graphn_set(s : GeodistsphericalGraphN, i : Int, v : Double) -> GeodistsphericalGraphN {
  let result = geo_dist_spherical_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_dist_spherical_graphn_sum(s : GeodistsphericalGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_dist_spherical_graphn_mean(s : GeodistsphericalGraphN) -> Double {
  if s.size == 0 { 0.0 } else { geo_dist_spherical_graphn_sum(s) / s.size.to_double() }
}

pub fn geo_dist_spherical_graphn_scale(s : GeodistsphericalGraphN, f : Double) -> GeodistsphericalGraphN {
  let result = geo_dist_spherical_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_dist_spherical_graphn_add(a : GeodistsphericalGraphN, b : GeodistsphericalGraphN) -> GeodistsphericalGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_dist_spherical_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_dist_spherical_graphn_copy(s : GeodistsphericalGraphN) -> GeodistsphericalGraphN {
  let result = geo_dist_spherical_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_dist_spherical_graphn_fill(s : GeodistsphericalGraphN, v : Double) -> GeodistsphericalGraphN {
  let result = geo_dist_spherical_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_dist_spherical_graphn_min(s : GeodistsphericalGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_spherical_graphn_max(s : GeodistsphericalGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_spherical_graphn_to_string(s : GeodistsphericalGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistsphericalNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_spherical_node_make(size : Int) -> GeodistsphericalNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_spherical_node_len(s : GeodistsphericalNode) -> Int { s.size }

pub fn geo_dist_spherical_node_get(s : GeodistsphericalNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_spherical_node_set(s : GeodistsphericalNode, i : Int, v : Double) -> GeodistsphericalNode {
  let result = geo_dist_spherical_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_dist_spherical_node_sum(s : GeodistsphericalNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_dist_spherical_node_mean(s : GeodistsphericalNode) -> Double {
  if s.size == 0 { 0.0 } else { geo_dist_spherical_node_sum(s) / s.size.to_double() }
}

pub fn geo_dist_spherical_node_scale(s : GeodistsphericalNode, f : Double) -> GeodistsphericalNode {
  let result = geo_dist_spherical_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_dist_spherical_node_add(a : GeodistsphericalNode, b : GeodistsphericalNode) -> GeodistsphericalNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_dist_spherical_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_dist_spherical_node_copy(s : GeodistsphericalNode) -> GeodistsphericalNode {
  let result = geo_dist_spherical_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_dist_spherical_node_fill(s : GeodistsphericalNode, v : Double) -> GeodistsphericalNode {
  let result = geo_dist_spherical_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_dist_spherical_node_min(s : GeodistsphericalNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_spherical_node_max(s : GeodistsphericalNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_spherical_node_to_string(s : GeodistsphericalNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistsphericalEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_spherical_edge_make(size : Int) -> GeodistsphericalEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_spherical_edge_len(s : GeodistsphericalEdge) -> Int { s.size }

pub fn geo_dist_spherical_edge_get(s : GeodistsphericalEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_spherical_edge_set(s : GeodistsphericalEdge, i : Int, v : Double) -> GeodistsphericalEdge {
  let result = geo_dist_spherical_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_dist_spherical_edge_sum(s : GeodistsphericalEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_dist_spherical_edge_mean(s : GeodistsphericalEdge) -> Double {
  if s.size == 0 { 0.0 } else { geo_dist_spherical_edge_sum(s) / s.size.to_double() }
}

pub fn geo_dist_spherical_edge_scale(s : GeodistsphericalEdge, f : Double) -> GeodistsphericalEdge {
  let result = geo_dist_spherical_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_dist_spherical_edge_add(a : GeodistsphericalEdge, b : GeodistsphericalEdge) -> GeodistsphericalEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_dist_spherical_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_dist_spherical_edge_copy(s : GeodistsphericalEdge) -> GeodistsphericalEdge {
  let result = geo_dist_spherical_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_dist_spherical_edge_fill(s : GeodistsphericalEdge, v : Double) -> GeodistsphericalEdge {
  let result = geo_dist_spherical_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_dist_spherical_edge_min(s : GeodistsphericalEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_spherical_edge_max(s : GeodistsphericalEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_spherical_edge_to_string(s : GeodistsphericalEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistsphericalPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_spherical_path_make(size : Int) -> GeodistsphericalPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_spherical_path_len(s : GeodistsphericalPath) -> Int { s.size }

pub fn geo_dist_spherical_path_get(s : GeodistsphericalPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_spherical_path_set(s : GeodistsphericalPath, i : Int, v : Double) -> GeodistsphericalPath {
  let result = geo_dist_spherical_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_dist_spherical_path_sum(s : GeodistsphericalPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_dist_spherical_path_mean(s : GeodistsphericalPath) -> Double {
  if s.size == 0 { 0.0 } else { geo_dist_spherical_path_sum(s) / s.size.to_double() }
}

pub fn geo_dist_spherical_path_scale(s : GeodistsphericalPath, f : Double) -> GeodistsphericalPath {
  let result = geo_dist_spherical_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_dist_spherical_path_add(a : GeodistsphericalPath, b : GeodistsphericalPath) -> GeodistsphericalPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_dist_spherical_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_dist_spherical_path_copy(s : GeodistsphericalPath) -> GeodistsphericalPath {
  let result = geo_dist_spherical_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_dist_spherical_path_fill(s : GeodistsphericalPath, v : Double) -> GeodistsphericalPath {
  let result = geo_dist_spherical_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_dist_spherical_path_min(s : GeodistsphericalPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_spherical_path_max(s : GeodistsphericalPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_spherical_path_to_string(s : GeodistsphericalPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistsphericalCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_spherical_cluster_make(size : Int) -> GeodistsphericalCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_spherical_cluster_len(s : GeodistsphericalCluster) -> Int { s.size }

pub fn geo_dist_spherical_cluster_get(s : GeodistsphericalCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_spherical_cluster_set(s : GeodistsphericalCluster, i : Int, v : Double) -> GeodistsphericalCluster {
  let result = geo_dist_spherical_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_dist_spherical_cluster_sum(s : GeodistsphericalCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_dist_spherical_cluster_mean(s : GeodistsphericalCluster) -> Double {
  if s.size == 0 { 0.0 } else { geo_dist_spherical_cluster_sum(s) / s.size.to_double() }
}

pub fn geo_dist_spherical_cluster_scale(s : GeodistsphericalCluster, f : Double) -> GeodistsphericalCluster {
  let result = geo_dist_spherical_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_dist_spherical_cluster_add(a : GeodistsphericalCluster, b : GeodistsphericalCluster) -> GeodistsphericalCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_dist_spherical_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_dist_spherical_cluster_copy(s : GeodistsphericalCluster) -> GeodistsphericalCluster {
  let result = geo_dist_spherical_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_dist_spherical_cluster_fill(s : GeodistsphericalCluster, v : Double) -> GeodistsphericalCluster {
  let result = geo_dist_spherical_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_dist_spherical_cluster_min(s : GeodistsphericalCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_spherical_cluster_max(s : GeodistsphericalCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_spherical_cluster_to_string(s : GeodistsphericalCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistsphericalModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_spherical_model_make(size : Int) -> GeodistsphericalModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_spherical_model_len(s : GeodistsphericalModel) -> Int { s.size }

pub fn geo_dist_spherical_model_get(s : GeodistsphericalModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_spherical_model_set(s : GeodistsphericalModel, i : Int, v : Double) -> GeodistsphericalModel {
  let result = geo_dist_spherical_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_dist_spherical_model_sum(s : GeodistsphericalModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_dist_spherical_model_mean(s : GeodistsphericalModel) -> Double {
  if s.size == 0 { 0.0 } else { geo_dist_spherical_model_sum(s) / s.size.to_double() }
}

pub fn geo_dist_spherical_model_scale(s : GeodistsphericalModel, f : Double) -> GeodistsphericalModel {
  let result = geo_dist_spherical_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_dist_spherical_model_add(a : GeodistsphericalModel, b : GeodistsphericalModel) -> GeodistsphericalModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_dist_spherical_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_dist_spherical_model_copy(s : GeodistsphericalModel) -> GeodistsphericalModel {
  let result = geo_dist_spherical_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_dist_spherical_model_fill(s : GeodistsphericalModel, v : Double) -> GeodistsphericalModel {
  let result = geo_dist_spherical_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_dist_spherical_model_min(s : GeodistsphericalModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_spherical_model_max(s : GeodistsphericalModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_spherical_model_to_string(s : GeodistsphericalModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistsphericalLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_spherical_layer_make(size : Int) -> GeodistsphericalLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_spherical_layer_len(s : GeodistsphericalLayer) -> Int { s.size }

pub fn geo_dist_spherical_layer_get(s : GeodistsphericalLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_spherical_layer_set(s : GeodistsphericalLayer, i : Int, v : Double) -> GeodistsphericalLayer {
  let result = geo_dist_spherical_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_dist_spherical_layer_sum(s : GeodistsphericalLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_dist_spherical_layer_mean(s : GeodistsphericalLayer) -> Double {
  if s.size == 0 { 0.0 } else { geo_dist_spherical_layer_sum(s) / s.size.to_double() }
}

pub fn geo_dist_spherical_layer_scale(s : GeodistsphericalLayer, f : Double) -> GeodistsphericalLayer {
  let result = geo_dist_spherical_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_dist_spherical_layer_add(a : GeodistsphericalLayer, b : GeodistsphericalLayer) -> GeodistsphericalLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_dist_spherical_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_dist_spherical_layer_copy(s : GeodistsphericalLayer) -> GeodistsphericalLayer {
  let result = geo_dist_spherical_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_dist_spherical_layer_fill(s : GeodistsphericalLayer, v : Double) -> GeodistsphericalLayer {
  let result = geo_dist_spherical_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_dist_spherical_layer_min(s : GeodistsphericalLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_spherical_layer_max(s : GeodistsphericalLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_spherical_layer_to_string(s : GeodistsphericalLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistsphericalBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_spherical_buffer_make(size : Int) -> GeodistsphericalBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_spherical_buffer_len(s : GeodistsphericalBuffer) -> Int { s.size }

pub fn geo_dist_spherical_buffer_get(s : GeodistsphericalBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_spherical_buffer_set(s : GeodistsphericalBuffer, i : Int, v : Double) -> GeodistsphericalBuffer {
  let result = geo_dist_spherical_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_dist_spherical_buffer_sum(s : GeodistsphericalBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_dist_spherical_buffer_mean(s : GeodistsphericalBuffer) -> Double {
  if s.size == 0 { 0.0 } else { geo_dist_spherical_buffer_sum(s) / s.size.to_double() }
}

pub fn geo_dist_spherical_buffer_scale(s : GeodistsphericalBuffer, f : Double) -> GeodistsphericalBuffer {
  let result = geo_dist_spherical_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_dist_spherical_buffer_add(a : GeodistsphericalBuffer, b : GeodistsphericalBuffer) -> GeodistsphericalBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_dist_spherical_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_dist_spherical_buffer_copy(s : GeodistsphericalBuffer) -> GeodistsphericalBuffer {
  let result = geo_dist_spherical_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_dist_spherical_buffer_fill(s : GeodistsphericalBuffer, v : Double) -> GeodistsphericalBuffer {
  let result = geo_dist_spherical_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_dist_spherical_buffer_min(s : GeodistsphericalBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_spherical_buffer_max(s : GeodistsphericalBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_spherical_buffer_to_string(s : GeodistsphericalBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistsphericalCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_spherical_cursor_make(size : Int) -> GeodistsphericalCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_spherical_cursor_len(s : GeodistsphericalCursor) -> Int { s.size }

pub fn geo_dist_spherical_cursor_get(s : GeodistsphericalCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_spherical_cursor_set(s : GeodistsphericalCursor, i : Int, v : Double) -> GeodistsphericalCursor {
  let result = geo_dist_spherical_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_dist_spherical_cursor_sum(s : GeodistsphericalCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_dist_spherical_cursor_mean(s : GeodistsphericalCursor) -> Double {
  if s.size == 0 { 0.0 } else { geo_dist_spherical_cursor_sum(s) / s.size.to_double() }
}

pub fn geo_dist_spherical_cursor_scale(s : GeodistsphericalCursor, f : Double) -> GeodistsphericalCursor {
  let result = geo_dist_spherical_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_dist_spherical_cursor_add(a : GeodistsphericalCursor, b : GeodistsphericalCursor) -> GeodistsphericalCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_dist_spherical_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_dist_spherical_cursor_copy(s : GeodistsphericalCursor) -> GeodistsphericalCursor {
  let result = geo_dist_spherical_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_dist_spherical_cursor_fill(s : GeodistsphericalCursor, v : Double) -> GeodistsphericalCursor {
  let result = geo_dist_spherical_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_dist_spherical_cursor_min(s : GeodistsphericalCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_spherical_cursor_max(s : GeodistsphericalCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_spherical_cursor_to_string(s : GeodistsphericalCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistsphericalView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_spherical_view_make(size : Int) -> GeodistsphericalView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_spherical_view_len(s : GeodistsphericalView) -> Int { s.size }

pub fn geo_dist_spherical_view_get(s : GeodistsphericalView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_spherical_view_set(s : GeodistsphericalView, i : Int, v : Double) -> GeodistsphericalView {
  let result = geo_dist_spherical_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_dist_spherical_view_sum(s : GeodistsphericalView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_dist_spherical_view_mean(s : GeodistsphericalView) -> Double {
  if s.size == 0 { 0.0 } else { geo_dist_spherical_view_sum(s) / s.size.to_double() }
}

pub fn geo_dist_spherical_view_scale(s : GeodistsphericalView, f : Double) -> GeodistsphericalView {
  let result = geo_dist_spherical_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_dist_spherical_view_add(a : GeodistsphericalView, b : GeodistsphericalView) -> GeodistsphericalView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_dist_spherical_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_dist_spherical_view_copy(s : GeodistsphericalView) -> GeodistsphericalView {
  let result = geo_dist_spherical_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_dist_spherical_view_fill(s : GeodistsphericalView, v : Double) -> GeodistsphericalView {
  let result = geo_dist_spherical_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_dist_spherical_view_min(s : GeodistsphericalView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_spherical_view_max(s : GeodistsphericalView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_spherical_view_to_string(s : GeodistsphericalView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistsphericalRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_spherical_range_make(size : Int) -> GeodistsphericalRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_spherical_range_len(s : GeodistsphericalRange) -> Int { s.size }

pub fn geo_dist_spherical_range_get(s : GeodistsphericalRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_spherical_range_set(s : GeodistsphericalRange, i : Int, v : Double) -> GeodistsphericalRange {
  let result = geo_dist_spherical_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_dist_spherical_range_sum(s : GeodistsphericalRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_dist_spherical_range_mean(s : GeodistsphericalRange) -> Double {
  if s.size == 0 { 0.0 } else { geo_dist_spherical_range_sum(s) / s.size.to_double() }
}

pub fn geo_dist_spherical_range_scale(s : GeodistsphericalRange, f : Double) -> GeodistsphericalRange {
  let result = geo_dist_spherical_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_dist_spherical_range_add(a : GeodistsphericalRange, b : GeodistsphericalRange) -> GeodistsphericalRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_dist_spherical_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_dist_spherical_range_copy(s : GeodistsphericalRange) -> GeodistsphericalRange {
  let result = geo_dist_spherical_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_dist_spherical_range_fill(s : GeodistsphericalRange, v : Double) -> GeodistsphericalRange {
  let result = geo_dist_spherical_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_dist_spherical_range_min(s : GeodistsphericalRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_spherical_range_max(s : GeodistsphericalRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_spherical_range_to_string(s : GeodistsphericalRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistsphericalSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_spherical_slice_make(size : Int) -> GeodistsphericalSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_spherical_slice_len(s : GeodistsphericalSlice) -> Int { s.size }

pub fn geo_dist_spherical_slice_get(s : GeodistsphericalSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_spherical_slice_set(s : GeodistsphericalSlice, i : Int, v : Double) -> GeodistsphericalSlice {
  let result = geo_dist_spherical_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_dist_spherical_slice_sum(s : GeodistsphericalSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_dist_spherical_slice_mean(s : GeodistsphericalSlice) -> Double {
  if s.size == 0 { 0.0 } else { geo_dist_spherical_slice_sum(s) / s.size.to_double() }
}

pub fn geo_dist_spherical_slice_scale(s : GeodistsphericalSlice, f : Double) -> GeodistsphericalSlice {
  let result = geo_dist_spherical_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_dist_spherical_slice_add(a : GeodistsphericalSlice, b : GeodistsphericalSlice) -> GeodistsphericalSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_dist_spherical_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_dist_spherical_slice_copy(s : GeodistsphericalSlice) -> GeodistsphericalSlice {
  let result = geo_dist_spherical_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_dist_spherical_slice_fill(s : GeodistsphericalSlice, v : Double) -> GeodistsphericalSlice {
  let result = geo_dist_spherical_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_dist_spherical_slice_min(s : GeodistsphericalSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_spherical_slice_max(s : GeodistsphericalSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_spherical_slice_to_string(s : GeodistsphericalSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn geo_dist_spherical_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_dist_spherical_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_dist_spherical_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_dist_spherical_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_dist_spherical_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_dist_spherical_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_dist_spherical_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_dist_spherical_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_dist_spherical_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_dist_spherical_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_dist_spherical_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_dist_spherical_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_dist_spherical_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_dist_spherical_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_dist_spherical_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_dist_spherical_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_dist_spherical_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_dist_spherical_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_dist_spherical_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_dist_spherical_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_dist_spherical_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_dist_spherical_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_dist_spherical_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_dist_spherical_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_dist_spherical_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

