///===
/// extcore/geo_dist_geodesic

pub(all) struct GeodistgeodesicPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn geo_dist_geodesic_make_point(x : Double, y : Double) -> GeodistgeodesicPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn geo_dist_geodesic_make_point3(x : Double, y : Double, z : Double) -> GeodistgeodesicPoint {
  { x, y, z, label: 0 }
}

pub fn geo_dist_geodesic_point_x(pt : GeodistgeodesicPoint) -> Double { pt.x }

pub fn geo_dist_geodesic_point_y(pt : GeodistgeodesicPoint) -> Double { pt.y }

pub fn geo_dist_geodesic_point_z(pt : GeodistgeodesicPoint) -> Double { pt.z }

pub fn geo_dist_geodesic_point_label(pt : GeodistgeodesicPoint) -> Int { pt.label }

pub fn geo_dist_geodesic_point_dist(a : GeodistgeodesicPoint, b : GeodistgeodesicPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  geo_dist_geodesic_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn geo_dist_geodesic_point_add(a : GeodistgeodesicPoint, b : GeodistgeodesicPoint) -> GeodistgeodesicPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn geo_dist_geodesic_point_sub(a : GeodistgeodesicPoint, b : GeodistgeodesicPoint) -> GeodistgeodesicPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn geo_dist_geodesic_point_scale(pt : GeodistgeodesicPoint, s : Double) -> GeodistgeodesicPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn geo_dist_geodesic_point_dot(a : GeodistgeodesicPoint, b : GeodistgeodesicPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn geo_dist_geodesic_point_cross(a : GeodistgeodesicPoint, b : GeodistgeodesicPoint) -> GeodistgeodesicPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn geo_dist_geodesic_point_norm(pt : GeodistgeodesicPoint) -> Double {
  geo_dist_geodesic_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn geo_dist_geodesic_point_normalize(pt : GeodistgeodesicPoint) -> GeodistgeodesicPoint {
  let n = geo_dist_geodesic_point_norm(pt)
  if n < 0.0000001 { pt } else { geo_dist_geodesic_point_scale(pt, 1.0 / n) }
}

pub fn geo_dist_geodesic_point_negate(pt : GeodistgeodesicPoint) -> GeodistgeodesicPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn geo_dist_geodesic_point_mid(a : GeodistgeodesicPoint, b : GeodistgeodesicPoint) -> GeodistgeodesicPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn geo_dist_geodesic_point_lerp(a : GeodistgeodesicPoint, b : GeodistgeodesicPoint, t : Double) -> GeodistgeodesicPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn geo_dist_geodesic_point_to_string(pt : GeodistgeodesicPoint) -> String {
  "(" + geo_dist_geodesic_dbl(pt.x) + ", " + geo_dist_geodesic_dbl(pt.y) + ", " + geo_dist_geodesic_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct GeodistgeodesicSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn geo_dist_geodesic_make_series(vals : Array[Double], name : String) -> GeodistgeodesicSeries {
  { vals, name, meta: 0 }
}

pub fn geo_dist_geodesic_series_len(s : GeodistgeodesicSeries) -> Int { s.vals.length() }

pub fn geo_dist_geodesic_series_sum(s : GeodistgeodesicSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn geo_dist_geodesic_series_mean(s : GeodistgeodesicSeries) -> Double {
  let n = geo_dist_geodesic_series_len(s)
  if n == 0 { 0.0 } else { geo_dist_geodesic_series_sum(s) / n.to_double() }
}

pub fn geo_dist_geodesic_series_min(s : GeodistgeodesicSeries) -> Double {
  let n = geo_dist_geodesic_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn geo_dist_geodesic_series_max(s : GeodistgeodesicSeries) -> Double {
  let n = geo_dist_geodesic_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn geo_dist_geodesic_series_range(s : GeodistgeodesicSeries) -> Double {
  geo_dist_geodesic_series_max(s) - geo_dist_geodesic_series_min(s)
}

pub fn geo_dist_geodesic_series_var(s : GeodistgeodesicSeries) -> Double {
  let n = geo_dist_geodesic_series_len(s)
  if n == 0 { 0.0 } else {
    let m = geo_dist_geodesic_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn geo_dist_geodesic_series_std(s : GeodistgeodesicSeries) -> Double { geo_dist_geodesic_sqrt(geo_dist_geodesic_series_var(s)) }

pub fn geo_dist_geodesic_series_median(s : GeodistgeodesicSeries) -> Double {
  let n = geo_dist_geodesic_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = geo_dist_geodesic_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn geo_dist_geodesic_series_scale(s : GeodistgeodesicSeries, f : Double) -> GeodistgeodesicSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = geo_dist_geodesic_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn geo_dist_geodesic_series_add(a : GeodistgeodesicSeries, b : GeodistgeodesicSeries) -> GeodistgeodesicSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = geo_dist_geodesic_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn geo_dist_geodesic_series_sub(a : GeodistgeodesicSeries, b : GeodistgeodesicSeries) -> GeodistgeodesicSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = geo_dist_geodesic_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn geo_dist_geodesic_series_normalize(s : GeodistgeodesicSeries) -> GeodistgeodesicSeries {
  let mn = geo_dist_geodesic_series_min(s)
  let mx = geo_dist_geodesic_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = geo_dist_geodesic_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn geo_dist_geodesic_series_cumsum(s : GeodistgeodesicSeries) -> GeodistgeodesicSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = geo_dist_geodesic_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn geo_dist_geodesic_series_to_string(s : GeodistgeodesicSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + geo_dist_geodesic_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GeodistgeodesicMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn geo_dist_geodesic_make_matrix(rows : Int, cols : Int, val : Double) -> GeodistgeodesicMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn geo_dist_geodesic_matrix_identity(n : Int) -> GeodistgeodesicMatrix {
  let m = geo_dist_geodesic_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn geo_dist_geodesic_matrix_get(m : GeodistgeodesicMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn geo_dist_geodesic_matrix_transpose(m : GeodistgeodesicMatrix) -> GeodistgeodesicMatrix {
  let result = geo_dist_geodesic_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn geo_dist_geodesic_matrix_add(a : GeodistgeodesicMatrix, b : GeodistgeodesicMatrix) -> GeodistgeodesicMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = geo_dist_geodesic_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn geo_dist_geodesic_matrix_scale(m : GeodistgeodesicMatrix, s : Double) -> GeodistgeodesicMatrix {
  let result = geo_dist_geodesic_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn geo_dist_geodesic_matrix_multiply(a : GeodistgeodesicMatrix, b : GeodistgeodesicMatrix) -> GeodistgeodesicMatrix {
  if a.cols != b.rows { return geo_dist_geodesic_make_matrix(a.rows, b.cols, 0.0) }
  let result = geo_dist_geodesic_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn geo_dist_geodesic_matrix_trace(m : GeodistgeodesicMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn geo_dist_geodesic_matrix_det(m : GeodistgeodesicMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn geo_dist_geodesic_matrix_norm(m : GeodistgeodesicMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  geo_dist_geodesic_sqrt(sum)
}

pub fn geo_dist_geodesic_matrix_to_string(m : GeodistgeodesicMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + geo_dist_geodesic_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct GeodistgeodesicVector {
  comps : Array[Double]
  dim : Int
}

pub fn geo_dist_geodesic_make_vector(comps : Array[Double]) -> GeodistgeodesicVector {
  { comps, dim: comps.length() }
}

pub fn geo_dist_geodesic_vector_zero(dim : Int) -> GeodistgeodesicVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn geo_dist_geodesic_vector_add(a : GeodistgeodesicVector, b : GeodistgeodesicVector) -> GeodistgeodesicVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = geo_dist_geodesic_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn geo_dist_geodesic_vector_sub(a : GeodistgeodesicVector, b : GeodistgeodesicVector) -> GeodistgeodesicVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = geo_dist_geodesic_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn geo_dist_geodesic_vector_scale(v : GeodistgeodesicVector, s : Double) -> GeodistgeodesicVector {
  let mut result = []
  for i in 0..<v.dim { result = geo_dist_geodesic_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn geo_dist_geodesic_vector_dot(a : GeodistgeodesicVector, b : GeodistgeodesicVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn geo_dist_geodesic_vector_norm(v : GeodistgeodesicVector) -> Double { geo_dist_geodesic_sqrt(geo_dist_geodesic_vector_dot(v, v)) }

pub fn geo_dist_geodesic_vector_normalize(v : GeodistgeodesicVector) -> GeodistgeodesicVector {
  let n = geo_dist_geodesic_vector_norm(v)
  if n < 0.0000001 { v } else { geo_dist_geodesic_vector_scale(v, 1.0 / n) }
}

pub fn geo_dist_geodesic_vector_dist(a : GeodistgeodesicVector, b : GeodistgeodesicVector) -> Double {
  geo_dist_geodesic_vector_norm(geo_dist_geodesic_vector_sub(a, b))
}

pub fn geo_dist_geodesic_vector_to_string(v : GeodistgeodesicVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + geo_dist_geodesic_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn geo_dist_geodesic_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn geo_dist_geodesic_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = geo_dist_geodesic_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn geo_dist_geodesic_std(data : Array[Double]) -> Double { geo_dist_geodesic_sqrt(geo_dist_geodesic_var(data)) }

pub fn geo_dist_geodesic_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = geo_dist_geodesic_mean(a); let mb = geo_dist_geodesic_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn geo_dist_geodesic_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = geo_dist_geodesic_std(a); let sb = geo_dist_geodesic_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { geo_dist_geodesic_cov(a, b) / (sa * sb) }
}

pub fn geo_dist_geodesic_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = geo_dist_geodesic_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn geo_dist_geodesic_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn geo_dist_geodesic_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn geo_dist_geodesic_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  geo_dist_geodesic_sqrt(geo_dist_geodesic_mse(pred, labels))
}

pub fn geo_dist_geodesic_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + geo_dist_geodesic_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn geo_dist_geodesic_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = geo_dist_geodesic_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn geo_dist_geodesic_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn geo_dist_geodesic_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn geo_dist_geodesic_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = geo_dist_geodesic_precision(pred, labels, pos); let r = geo_dist_geodesic_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn geo_dist_geodesic_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn geo_dist_geodesic_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = geo_dist_geodesic_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn geo_dist_geodesic_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn geo_dist_geodesic_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn geo_dist_geodesic_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = geo_dist_geodesic_gcd(a, b)
    (a / g) * b
  }
}

pub fn geo_dist_geodesic_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn geo_dist_geodesic_fibonacci(n : Int) -> Int {
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

pub fn geo_dist_geodesic_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = geo_dist_geodesic_min(data); let mx = geo_dist_geodesic_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn geo_dist_geodesic_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = geo_dist_geodesic_mean(data); let sd = geo_dist_geodesic_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn geo_dist_geodesic_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn geo_dist_geodesic_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn geo_dist_geodesic_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn geo_dist_geodesic_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn geo_dist_geodesic_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn geo_dist_geodesic_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn geo_dist_geodesic_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn geo_dist_geodesic_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn geo_dist_geodesic_dbl(x : Double) -> String {
  let i = if x >= 0.0 { geo_dist_geodesic_int(x) } else { -geo_dist_geodesic_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { geo_dist_geodesic_int(f * 1000000.0) } else { geo_dist_geodesic_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn geo_dist_geodesic_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn geo_dist_geodesic_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct GeodistgeodesicFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_geodesic_frame_make(size : Int) -> GeodistgeodesicFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_geodesic_frame_len(s : GeodistgeodesicFrame) -> Int { s.size }

pub fn geo_dist_geodesic_frame_get(s : GeodistgeodesicFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_geodesic_frame_set(s : GeodistgeodesicFrame, i : Int, v : Double) -> GeodistgeodesicFrame {
  let result = geo_dist_geodesic_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_dist_geodesic_frame_sum(s : GeodistgeodesicFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_dist_geodesic_frame_mean(s : GeodistgeodesicFrame) -> Double {
  if s.size == 0 { 0.0 } else { geo_dist_geodesic_frame_sum(s) / s.size.to_double() }
}

pub fn geo_dist_geodesic_frame_scale(s : GeodistgeodesicFrame, f : Double) -> GeodistgeodesicFrame {
  let result = geo_dist_geodesic_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_dist_geodesic_frame_add(a : GeodistgeodesicFrame, b : GeodistgeodesicFrame) -> GeodistgeodesicFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_dist_geodesic_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_dist_geodesic_frame_copy(s : GeodistgeodesicFrame) -> GeodistgeodesicFrame {
  let result = geo_dist_geodesic_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_dist_geodesic_frame_fill(s : GeodistgeodesicFrame, v : Double) -> GeodistgeodesicFrame {
  let result = geo_dist_geodesic_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_dist_geodesic_frame_min(s : GeodistgeodesicFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_geodesic_frame_max(s : GeodistgeodesicFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_geodesic_frame_to_string(s : GeodistgeodesicFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistgeodesicTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_geodesic_table_make(size : Int) -> GeodistgeodesicTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_geodesic_table_len(s : GeodistgeodesicTable) -> Int { s.size }

pub fn geo_dist_geodesic_table_get(s : GeodistgeodesicTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_geodesic_table_set(s : GeodistgeodesicTable, i : Int, v : Double) -> GeodistgeodesicTable {
  let result = geo_dist_geodesic_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_dist_geodesic_table_sum(s : GeodistgeodesicTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_dist_geodesic_table_mean(s : GeodistgeodesicTable) -> Double {
  if s.size == 0 { 0.0 } else { geo_dist_geodesic_table_sum(s) / s.size.to_double() }
}

pub fn geo_dist_geodesic_table_scale(s : GeodistgeodesicTable, f : Double) -> GeodistgeodesicTable {
  let result = geo_dist_geodesic_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_dist_geodesic_table_add(a : GeodistgeodesicTable, b : GeodistgeodesicTable) -> GeodistgeodesicTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_dist_geodesic_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_dist_geodesic_table_copy(s : GeodistgeodesicTable) -> GeodistgeodesicTable {
  let result = geo_dist_geodesic_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_dist_geodesic_table_fill(s : GeodistgeodesicTable, v : Double) -> GeodistgeodesicTable {
  let result = geo_dist_geodesic_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_dist_geodesic_table_min(s : GeodistgeodesicTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_geodesic_table_max(s : GeodistgeodesicTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_geodesic_table_to_string(s : GeodistgeodesicTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistgeodesicGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_geodesic_graphn_make(size : Int) -> GeodistgeodesicGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_geodesic_graphn_len(s : GeodistgeodesicGraphN) -> Int { s.size }

pub fn geo_dist_geodesic_graphn_get(s : GeodistgeodesicGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_geodesic_graphn_set(s : GeodistgeodesicGraphN, i : Int, v : Double) -> GeodistgeodesicGraphN {
  let result = geo_dist_geodesic_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_dist_geodesic_graphn_sum(s : GeodistgeodesicGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_dist_geodesic_graphn_mean(s : GeodistgeodesicGraphN) -> Double {
  if s.size == 0 { 0.0 } else { geo_dist_geodesic_graphn_sum(s) / s.size.to_double() }
}

pub fn geo_dist_geodesic_graphn_scale(s : GeodistgeodesicGraphN, f : Double) -> GeodistgeodesicGraphN {
  let result = geo_dist_geodesic_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_dist_geodesic_graphn_add(a : GeodistgeodesicGraphN, b : GeodistgeodesicGraphN) -> GeodistgeodesicGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_dist_geodesic_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_dist_geodesic_graphn_copy(s : GeodistgeodesicGraphN) -> GeodistgeodesicGraphN {
  let result = geo_dist_geodesic_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_dist_geodesic_graphn_fill(s : GeodistgeodesicGraphN, v : Double) -> GeodistgeodesicGraphN {
  let result = geo_dist_geodesic_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_dist_geodesic_graphn_min(s : GeodistgeodesicGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_geodesic_graphn_max(s : GeodistgeodesicGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_geodesic_graphn_to_string(s : GeodistgeodesicGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistgeodesicNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_geodesic_node_make(size : Int) -> GeodistgeodesicNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_geodesic_node_len(s : GeodistgeodesicNode) -> Int { s.size }

pub fn geo_dist_geodesic_node_get(s : GeodistgeodesicNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_geodesic_node_set(s : GeodistgeodesicNode, i : Int, v : Double) -> GeodistgeodesicNode {
  let result = geo_dist_geodesic_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_dist_geodesic_node_sum(s : GeodistgeodesicNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_dist_geodesic_node_mean(s : GeodistgeodesicNode) -> Double {
  if s.size == 0 { 0.0 } else { geo_dist_geodesic_node_sum(s) / s.size.to_double() }
}

pub fn geo_dist_geodesic_node_scale(s : GeodistgeodesicNode, f : Double) -> GeodistgeodesicNode {
  let result = geo_dist_geodesic_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_dist_geodesic_node_add(a : GeodistgeodesicNode, b : GeodistgeodesicNode) -> GeodistgeodesicNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_dist_geodesic_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_dist_geodesic_node_copy(s : GeodistgeodesicNode) -> GeodistgeodesicNode {
  let result = geo_dist_geodesic_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_dist_geodesic_node_fill(s : GeodistgeodesicNode, v : Double) -> GeodistgeodesicNode {
  let result = geo_dist_geodesic_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_dist_geodesic_node_min(s : GeodistgeodesicNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_geodesic_node_max(s : GeodistgeodesicNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_geodesic_node_to_string(s : GeodistgeodesicNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistgeodesicEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_geodesic_edge_make(size : Int) -> GeodistgeodesicEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_geodesic_edge_len(s : GeodistgeodesicEdge) -> Int { s.size }

pub fn geo_dist_geodesic_edge_get(s : GeodistgeodesicEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_geodesic_edge_set(s : GeodistgeodesicEdge, i : Int, v : Double) -> GeodistgeodesicEdge {
  let result = geo_dist_geodesic_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_dist_geodesic_edge_sum(s : GeodistgeodesicEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_dist_geodesic_edge_mean(s : GeodistgeodesicEdge) -> Double {
  if s.size == 0 { 0.0 } else { geo_dist_geodesic_edge_sum(s) / s.size.to_double() }
}

pub fn geo_dist_geodesic_edge_scale(s : GeodistgeodesicEdge, f : Double) -> GeodistgeodesicEdge {
  let result = geo_dist_geodesic_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_dist_geodesic_edge_add(a : GeodistgeodesicEdge, b : GeodistgeodesicEdge) -> GeodistgeodesicEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_dist_geodesic_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_dist_geodesic_edge_copy(s : GeodistgeodesicEdge) -> GeodistgeodesicEdge {
  let result = geo_dist_geodesic_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_dist_geodesic_edge_fill(s : GeodistgeodesicEdge, v : Double) -> GeodistgeodesicEdge {
  let result = geo_dist_geodesic_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_dist_geodesic_edge_min(s : GeodistgeodesicEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_geodesic_edge_max(s : GeodistgeodesicEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_geodesic_edge_to_string(s : GeodistgeodesicEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistgeodesicPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_geodesic_path_make(size : Int) -> GeodistgeodesicPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_geodesic_path_len(s : GeodistgeodesicPath) -> Int { s.size }

pub fn geo_dist_geodesic_path_get(s : GeodistgeodesicPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_geodesic_path_set(s : GeodistgeodesicPath, i : Int, v : Double) -> GeodistgeodesicPath {
  let result = geo_dist_geodesic_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_dist_geodesic_path_sum(s : GeodistgeodesicPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_dist_geodesic_path_mean(s : GeodistgeodesicPath) -> Double {
  if s.size == 0 { 0.0 } else { geo_dist_geodesic_path_sum(s) / s.size.to_double() }
}

pub fn geo_dist_geodesic_path_scale(s : GeodistgeodesicPath, f : Double) -> GeodistgeodesicPath {
  let result = geo_dist_geodesic_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_dist_geodesic_path_add(a : GeodistgeodesicPath, b : GeodistgeodesicPath) -> GeodistgeodesicPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_dist_geodesic_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_dist_geodesic_path_copy(s : GeodistgeodesicPath) -> GeodistgeodesicPath {
  let result = geo_dist_geodesic_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_dist_geodesic_path_fill(s : GeodistgeodesicPath, v : Double) -> GeodistgeodesicPath {
  let result = geo_dist_geodesic_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_dist_geodesic_path_min(s : GeodistgeodesicPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_geodesic_path_max(s : GeodistgeodesicPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_geodesic_path_to_string(s : GeodistgeodesicPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistgeodesicCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_geodesic_cluster_make(size : Int) -> GeodistgeodesicCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_geodesic_cluster_len(s : GeodistgeodesicCluster) -> Int { s.size }

pub fn geo_dist_geodesic_cluster_get(s : GeodistgeodesicCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_geodesic_cluster_set(s : GeodistgeodesicCluster, i : Int, v : Double) -> GeodistgeodesicCluster {
  let result = geo_dist_geodesic_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_dist_geodesic_cluster_sum(s : GeodistgeodesicCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_dist_geodesic_cluster_mean(s : GeodistgeodesicCluster) -> Double {
  if s.size == 0 { 0.0 } else { geo_dist_geodesic_cluster_sum(s) / s.size.to_double() }
}

pub fn geo_dist_geodesic_cluster_scale(s : GeodistgeodesicCluster, f : Double) -> GeodistgeodesicCluster {
  let result = geo_dist_geodesic_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_dist_geodesic_cluster_add(a : GeodistgeodesicCluster, b : GeodistgeodesicCluster) -> GeodistgeodesicCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_dist_geodesic_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_dist_geodesic_cluster_copy(s : GeodistgeodesicCluster) -> GeodistgeodesicCluster {
  let result = geo_dist_geodesic_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_dist_geodesic_cluster_fill(s : GeodistgeodesicCluster, v : Double) -> GeodistgeodesicCluster {
  let result = geo_dist_geodesic_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_dist_geodesic_cluster_min(s : GeodistgeodesicCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_geodesic_cluster_max(s : GeodistgeodesicCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_geodesic_cluster_to_string(s : GeodistgeodesicCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistgeodesicModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_geodesic_model_make(size : Int) -> GeodistgeodesicModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_geodesic_model_len(s : GeodistgeodesicModel) -> Int { s.size }

pub fn geo_dist_geodesic_model_get(s : GeodistgeodesicModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_geodesic_model_set(s : GeodistgeodesicModel, i : Int, v : Double) -> GeodistgeodesicModel {
  let result = geo_dist_geodesic_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_dist_geodesic_model_sum(s : GeodistgeodesicModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_dist_geodesic_model_mean(s : GeodistgeodesicModel) -> Double {
  if s.size == 0 { 0.0 } else { geo_dist_geodesic_model_sum(s) / s.size.to_double() }
}

pub fn geo_dist_geodesic_model_scale(s : GeodistgeodesicModel, f : Double) -> GeodistgeodesicModel {
  let result = geo_dist_geodesic_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_dist_geodesic_model_add(a : GeodistgeodesicModel, b : GeodistgeodesicModel) -> GeodistgeodesicModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_dist_geodesic_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_dist_geodesic_model_copy(s : GeodistgeodesicModel) -> GeodistgeodesicModel {
  let result = geo_dist_geodesic_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_dist_geodesic_model_fill(s : GeodistgeodesicModel, v : Double) -> GeodistgeodesicModel {
  let result = geo_dist_geodesic_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_dist_geodesic_model_min(s : GeodistgeodesicModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_geodesic_model_max(s : GeodistgeodesicModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_geodesic_model_to_string(s : GeodistgeodesicModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistgeodesicLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_geodesic_layer_make(size : Int) -> GeodistgeodesicLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_geodesic_layer_len(s : GeodistgeodesicLayer) -> Int { s.size }

pub fn geo_dist_geodesic_layer_get(s : GeodistgeodesicLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_geodesic_layer_set(s : GeodistgeodesicLayer, i : Int, v : Double) -> GeodistgeodesicLayer {
  let result = geo_dist_geodesic_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_dist_geodesic_layer_sum(s : GeodistgeodesicLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_dist_geodesic_layer_mean(s : GeodistgeodesicLayer) -> Double {
  if s.size == 0 { 0.0 } else { geo_dist_geodesic_layer_sum(s) / s.size.to_double() }
}

pub fn geo_dist_geodesic_layer_scale(s : GeodistgeodesicLayer, f : Double) -> GeodistgeodesicLayer {
  let result = geo_dist_geodesic_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_dist_geodesic_layer_add(a : GeodistgeodesicLayer, b : GeodistgeodesicLayer) -> GeodistgeodesicLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_dist_geodesic_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_dist_geodesic_layer_copy(s : GeodistgeodesicLayer) -> GeodistgeodesicLayer {
  let result = geo_dist_geodesic_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_dist_geodesic_layer_fill(s : GeodistgeodesicLayer, v : Double) -> GeodistgeodesicLayer {
  let result = geo_dist_geodesic_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_dist_geodesic_layer_min(s : GeodistgeodesicLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_geodesic_layer_max(s : GeodistgeodesicLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_geodesic_layer_to_string(s : GeodistgeodesicLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistgeodesicBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_geodesic_buffer_make(size : Int) -> GeodistgeodesicBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_geodesic_buffer_len(s : GeodistgeodesicBuffer) -> Int { s.size }

pub fn geo_dist_geodesic_buffer_get(s : GeodistgeodesicBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_geodesic_buffer_set(s : GeodistgeodesicBuffer, i : Int, v : Double) -> GeodistgeodesicBuffer {
  let result = geo_dist_geodesic_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_dist_geodesic_buffer_sum(s : GeodistgeodesicBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_dist_geodesic_buffer_mean(s : GeodistgeodesicBuffer) -> Double {
  if s.size == 0 { 0.0 } else { geo_dist_geodesic_buffer_sum(s) / s.size.to_double() }
}

pub fn geo_dist_geodesic_buffer_scale(s : GeodistgeodesicBuffer, f : Double) -> GeodistgeodesicBuffer {
  let result = geo_dist_geodesic_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_dist_geodesic_buffer_add(a : GeodistgeodesicBuffer, b : GeodistgeodesicBuffer) -> GeodistgeodesicBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_dist_geodesic_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_dist_geodesic_buffer_copy(s : GeodistgeodesicBuffer) -> GeodistgeodesicBuffer {
  let result = geo_dist_geodesic_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_dist_geodesic_buffer_fill(s : GeodistgeodesicBuffer, v : Double) -> GeodistgeodesicBuffer {
  let result = geo_dist_geodesic_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_dist_geodesic_buffer_min(s : GeodistgeodesicBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_geodesic_buffer_max(s : GeodistgeodesicBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_geodesic_buffer_to_string(s : GeodistgeodesicBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistgeodesicCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_geodesic_cursor_make(size : Int) -> GeodistgeodesicCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_geodesic_cursor_len(s : GeodistgeodesicCursor) -> Int { s.size }

pub fn geo_dist_geodesic_cursor_get(s : GeodistgeodesicCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_geodesic_cursor_set(s : GeodistgeodesicCursor, i : Int, v : Double) -> GeodistgeodesicCursor {
  let result = geo_dist_geodesic_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_dist_geodesic_cursor_sum(s : GeodistgeodesicCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_dist_geodesic_cursor_mean(s : GeodistgeodesicCursor) -> Double {
  if s.size == 0 { 0.0 } else { geo_dist_geodesic_cursor_sum(s) / s.size.to_double() }
}

pub fn geo_dist_geodesic_cursor_scale(s : GeodistgeodesicCursor, f : Double) -> GeodistgeodesicCursor {
  let result = geo_dist_geodesic_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_dist_geodesic_cursor_add(a : GeodistgeodesicCursor, b : GeodistgeodesicCursor) -> GeodistgeodesicCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_dist_geodesic_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_dist_geodesic_cursor_copy(s : GeodistgeodesicCursor) -> GeodistgeodesicCursor {
  let result = geo_dist_geodesic_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_dist_geodesic_cursor_fill(s : GeodistgeodesicCursor, v : Double) -> GeodistgeodesicCursor {
  let result = geo_dist_geodesic_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_dist_geodesic_cursor_min(s : GeodistgeodesicCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_geodesic_cursor_max(s : GeodistgeodesicCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_geodesic_cursor_to_string(s : GeodistgeodesicCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistgeodesicView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_geodesic_view_make(size : Int) -> GeodistgeodesicView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_geodesic_view_len(s : GeodistgeodesicView) -> Int { s.size }

pub fn geo_dist_geodesic_view_get(s : GeodistgeodesicView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_geodesic_view_set(s : GeodistgeodesicView, i : Int, v : Double) -> GeodistgeodesicView {
  let result = geo_dist_geodesic_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_dist_geodesic_view_sum(s : GeodistgeodesicView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_dist_geodesic_view_mean(s : GeodistgeodesicView) -> Double {
  if s.size == 0 { 0.0 } else { geo_dist_geodesic_view_sum(s) / s.size.to_double() }
}

pub fn geo_dist_geodesic_view_scale(s : GeodistgeodesicView, f : Double) -> GeodistgeodesicView {
  let result = geo_dist_geodesic_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_dist_geodesic_view_add(a : GeodistgeodesicView, b : GeodistgeodesicView) -> GeodistgeodesicView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_dist_geodesic_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_dist_geodesic_view_copy(s : GeodistgeodesicView) -> GeodistgeodesicView {
  let result = geo_dist_geodesic_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_dist_geodesic_view_fill(s : GeodistgeodesicView, v : Double) -> GeodistgeodesicView {
  let result = geo_dist_geodesic_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_dist_geodesic_view_min(s : GeodistgeodesicView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_geodesic_view_max(s : GeodistgeodesicView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_geodesic_view_to_string(s : GeodistgeodesicView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistgeodesicRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_geodesic_range_make(size : Int) -> GeodistgeodesicRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_geodesic_range_len(s : GeodistgeodesicRange) -> Int { s.size }

pub fn geo_dist_geodesic_range_get(s : GeodistgeodesicRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_geodesic_range_set(s : GeodistgeodesicRange, i : Int, v : Double) -> GeodistgeodesicRange {
  let result = geo_dist_geodesic_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_dist_geodesic_range_sum(s : GeodistgeodesicRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_dist_geodesic_range_mean(s : GeodistgeodesicRange) -> Double {
  if s.size == 0 { 0.0 } else { geo_dist_geodesic_range_sum(s) / s.size.to_double() }
}

pub fn geo_dist_geodesic_range_scale(s : GeodistgeodesicRange, f : Double) -> GeodistgeodesicRange {
  let result = geo_dist_geodesic_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_dist_geodesic_range_add(a : GeodistgeodesicRange, b : GeodistgeodesicRange) -> GeodistgeodesicRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_dist_geodesic_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_dist_geodesic_range_copy(s : GeodistgeodesicRange) -> GeodistgeodesicRange {
  let result = geo_dist_geodesic_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_dist_geodesic_range_fill(s : GeodistgeodesicRange, v : Double) -> GeodistgeodesicRange {
  let result = geo_dist_geodesic_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_dist_geodesic_range_min(s : GeodistgeodesicRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_geodesic_range_max(s : GeodistgeodesicRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_geodesic_range_to_string(s : GeodistgeodesicRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistgeodesicSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_geodesic_slice_make(size : Int) -> GeodistgeodesicSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_geodesic_slice_len(s : GeodistgeodesicSlice) -> Int { s.size }

pub fn geo_dist_geodesic_slice_get(s : GeodistgeodesicSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_geodesic_slice_set(s : GeodistgeodesicSlice, i : Int, v : Double) -> GeodistgeodesicSlice {
  let result = geo_dist_geodesic_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_dist_geodesic_slice_sum(s : GeodistgeodesicSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_dist_geodesic_slice_mean(s : GeodistgeodesicSlice) -> Double {
  if s.size == 0 { 0.0 } else { geo_dist_geodesic_slice_sum(s) / s.size.to_double() }
}

pub fn geo_dist_geodesic_slice_scale(s : GeodistgeodesicSlice, f : Double) -> GeodistgeodesicSlice {
  let result = geo_dist_geodesic_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_dist_geodesic_slice_add(a : GeodistgeodesicSlice, b : GeodistgeodesicSlice) -> GeodistgeodesicSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_dist_geodesic_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_dist_geodesic_slice_copy(s : GeodistgeodesicSlice) -> GeodistgeodesicSlice {
  let result = geo_dist_geodesic_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_dist_geodesic_slice_fill(s : GeodistgeodesicSlice, v : Double) -> GeodistgeodesicSlice {
  let result = geo_dist_geodesic_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_dist_geodesic_slice_min(s : GeodistgeodesicSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_geodesic_slice_max(s : GeodistgeodesicSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_geodesic_slice_to_string(s : GeodistgeodesicSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn geo_dist_geodesic_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_dist_geodesic_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_dist_geodesic_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_dist_geodesic_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_dist_geodesic_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_dist_geodesic_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_dist_geodesic_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_dist_geodesic_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_dist_geodesic_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_dist_geodesic_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_dist_geodesic_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_dist_geodesic_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_dist_geodesic_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_dist_geodesic_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_dist_geodesic_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_dist_geodesic_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_dist_geodesic_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_dist_geodesic_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_dist_geodesic_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_dist_geodesic_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_dist_geodesic_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_dist_geodesic_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_dist_geodesic_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_dist_geodesic_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_dist_geodesic_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

