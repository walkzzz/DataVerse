///===
/// extcore/geo_dist_euclidean

pub(all) struct GeodisteuclideanPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn geo_dist_euclidean_make_point(x : Double, y : Double) -> GeodisteuclideanPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn geo_dist_euclidean_make_point3(x : Double, y : Double, z : Double) -> GeodisteuclideanPoint {
  { x, y, z, label: 0 }
}

pub fn geo_dist_euclidean_point_x(pt : GeodisteuclideanPoint) -> Double { pt.x }

pub fn geo_dist_euclidean_point_y(pt : GeodisteuclideanPoint) -> Double { pt.y }

pub fn geo_dist_euclidean_point_z(pt : GeodisteuclideanPoint) -> Double { pt.z }

pub fn geo_dist_euclidean_point_label(pt : GeodisteuclideanPoint) -> Int { pt.label }

pub fn geo_dist_euclidean_point_dist(a : GeodisteuclideanPoint, b : GeodisteuclideanPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  geo_dist_euclidean_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn geo_dist_euclidean_point_add(a : GeodisteuclideanPoint, b : GeodisteuclideanPoint) -> GeodisteuclideanPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn geo_dist_euclidean_point_sub(a : GeodisteuclideanPoint, b : GeodisteuclideanPoint) -> GeodisteuclideanPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn geo_dist_euclidean_point_scale(pt : GeodisteuclideanPoint, s : Double) -> GeodisteuclideanPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn geo_dist_euclidean_point_dot(a : GeodisteuclideanPoint, b : GeodisteuclideanPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn geo_dist_euclidean_point_cross(a : GeodisteuclideanPoint, b : GeodisteuclideanPoint) -> GeodisteuclideanPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn geo_dist_euclidean_point_norm(pt : GeodisteuclideanPoint) -> Double {
  geo_dist_euclidean_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn geo_dist_euclidean_point_normalize(pt : GeodisteuclideanPoint) -> GeodisteuclideanPoint {
  let n = geo_dist_euclidean_point_norm(pt)
  if n < 0.0000001 { pt } else { geo_dist_euclidean_point_scale(pt, 1.0 / n) }
}

pub fn geo_dist_euclidean_point_negate(pt : GeodisteuclideanPoint) -> GeodisteuclideanPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn geo_dist_euclidean_point_mid(a : GeodisteuclideanPoint, b : GeodisteuclideanPoint) -> GeodisteuclideanPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn geo_dist_euclidean_point_lerp(a : GeodisteuclideanPoint, b : GeodisteuclideanPoint, t : Double) -> GeodisteuclideanPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn geo_dist_euclidean_point_to_string(pt : GeodisteuclideanPoint) -> String {
  "(" + geo_dist_euclidean_dbl(pt.x) + ", " + geo_dist_euclidean_dbl(pt.y) + ", " + geo_dist_euclidean_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct GeodisteuclideanSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn geo_dist_euclidean_make_series(vals : Array[Double], name : String) -> GeodisteuclideanSeries {
  { vals, name, meta: 0 }
}

pub fn geo_dist_euclidean_series_len(s : GeodisteuclideanSeries) -> Int { s.vals.length() }

pub fn geo_dist_euclidean_series_sum(s : GeodisteuclideanSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn geo_dist_euclidean_series_mean(s : GeodisteuclideanSeries) -> Double {
  let n = geo_dist_euclidean_series_len(s)
  if n == 0 { 0.0 } else { geo_dist_euclidean_series_sum(s) / n.to_double() }
}

pub fn geo_dist_euclidean_series_min(s : GeodisteuclideanSeries) -> Double {
  let n = geo_dist_euclidean_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn geo_dist_euclidean_series_max(s : GeodisteuclideanSeries) -> Double {
  let n = geo_dist_euclidean_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn geo_dist_euclidean_series_range(s : GeodisteuclideanSeries) -> Double {
  geo_dist_euclidean_series_max(s) - geo_dist_euclidean_series_min(s)
}

pub fn geo_dist_euclidean_series_var(s : GeodisteuclideanSeries) -> Double {
  let n = geo_dist_euclidean_series_len(s)
  if n == 0 { 0.0 } else {
    let m = geo_dist_euclidean_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn geo_dist_euclidean_series_std(s : GeodisteuclideanSeries) -> Double { geo_dist_euclidean_sqrt(geo_dist_euclidean_series_var(s)) }

pub fn geo_dist_euclidean_series_median(s : GeodisteuclideanSeries) -> Double {
  let n = geo_dist_euclidean_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = geo_dist_euclidean_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn geo_dist_euclidean_series_scale(s : GeodisteuclideanSeries, f : Double) -> GeodisteuclideanSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = geo_dist_euclidean_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn geo_dist_euclidean_series_add(a : GeodisteuclideanSeries, b : GeodisteuclideanSeries) -> GeodisteuclideanSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = geo_dist_euclidean_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn geo_dist_euclidean_series_sub(a : GeodisteuclideanSeries, b : GeodisteuclideanSeries) -> GeodisteuclideanSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = geo_dist_euclidean_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn geo_dist_euclidean_series_normalize(s : GeodisteuclideanSeries) -> GeodisteuclideanSeries {
  let mn = geo_dist_euclidean_series_min(s)
  let mx = geo_dist_euclidean_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = geo_dist_euclidean_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn geo_dist_euclidean_series_cumsum(s : GeodisteuclideanSeries) -> GeodisteuclideanSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = geo_dist_euclidean_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn geo_dist_euclidean_series_to_string(s : GeodisteuclideanSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + geo_dist_euclidean_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GeodisteuclideanMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn geo_dist_euclidean_make_matrix(rows : Int, cols : Int, val : Double) -> GeodisteuclideanMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn geo_dist_euclidean_matrix_identity(n : Int) -> GeodisteuclideanMatrix {
  let m = geo_dist_euclidean_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn geo_dist_euclidean_matrix_get(m : GeodisteuclideanMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn geo_dist_euclidean_matrix_transpose(m : GeodisteuclideanMatrix) -> GeodisteuclideanMatrix {
  let result = geo_dist_euclidean_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn geo_dist_euclidean_matrix_add(a : GeodisteuclideanMatrix, b : GeodisteuclideanMatrix) -> GeodisteuclideanMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = geo_dist_euclidean_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn geo_dist_euclidean_matrix_scale(m : GeodisteuclideanMatrix, s : Double) -> GeodisteuclideanMatrix {
  let result = geo_dist_euclidean_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn geo_dist_euclidean_matrix_multiply(a : GeodisteuclideanMatrix, b : GeodisteuclideanMatrix) -> GeodisteuclideanMatrix {
  if a.cols != b.rows { return geo_dist_euclidean_make_matrix(a.rows, b.cols, 0.0) }
  let result = geo_dist_euclidean_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn geo_dist_euclidean_matrix_trace(m : GeodisteuclideanMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn geo_dist_euclidean_matrix_det(m : GeodisteuclideanMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn geo_dist_euclidean_matrix_norm(m : GeodisteuclideanMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  geo_dist_euclidean_sqrt(sum)
}

pub fn geo_dist_euclidean_matrix_to_string(m : GeodisteuclideanMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + geo_dist_euclidean_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct GeodisteuclideanVector {
  comps : Array[Double]
  dim : Int
}

pub fn geo_dist_euclidean_make_vector(comps : Array[Double]) -> GeodisteuclideanVector {
  { comps, dim: comps.length() }
}

pub fn geo_dist_euclidean_vector_zero(dim : Int) -> GeodisteuclideanVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn geo_dist_euclidean_vector_add(a : GeodisteuclideanVector, b : GeodisteuclideanVector) -> GeodisteuclideanVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = geo_dist_euclidean_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn geo_dist_euclidean_vector_sub(a : GeodisteuclideanVector, b : GeodisteuclideanVector) -> GeodisteuclideanVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = geo_dist_euclidean_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn geo_dist_euclidean_vector_scale(v : GeodisteuclideanVector, s : Double) -> GeodisteuclideanVector {
  let mut result = []
  for i in 0..<v.dim { result = geo_dist_euclidean_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn geo_dist_euclidean_vector_dot(a : GeodisteuclideanVector, b : GeodisteuclideanVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn geo_dist_euclidean_vector_norm(v : GeodisteuclideanVector) -> Double { geo_dist_euclidean_sqrt(geo_dist_euclidean_vector_dot(v, v)) }

pub fn geo_dist_euclidean_vector_normalize(v : GeodisteuclideanVector) -> GeodisteuclideanVector {
  let n = geo_dist_euclidean_vector_norm(v)
  if n < 0.0000001 { v } else { geo_dist_euclidean_vector_scale(v, 1.0 / n) }
}

pub fn geo_dist_euclidean_vector_dist(a : GeodisteuclideanVector, b : GeodisteuclideanVector) -> Double {
  geo_dist_euclidean_vector_norm(geo_dist_euclidean_vector_sub(a, b))
}

pub fn geo_dist_euclidean_vector_to_string(v : GeodisteuclideanVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + geo_dist_euclidean_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn geo_dist_euclidean_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn geo_dist_euclidean_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = geo_dist_euclidean_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn geo_dist_euclidean_std(data : Array[Double]) -> Double { geo_dist_euclidean_sqrt(geo_dist_euclidean_var(data)) }

pub fn geo_dist_euclidean_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = geo_dist_euclidean_mean(a); let mb = geo_dist_euclidean_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn geo_dist_euclidean_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = geo_dist_euclidean_std(a); let sb = geo_dist_euclidean_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { geo_dist_euclidean_cov(a, b) / (sa * sb) }
}

pub fn geo_dist_euclidean_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = geo_dist_euclidean_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn geo_dist_euclidean_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn geo_dist_euclidean_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn geo_dist_euclidean_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  geo_dist_euclidean_sqrt(geo_dist_euclidean_mse(pred, labels))
}

pub fn geo_dist_euclidean_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + geo_dist_euclidean_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn geo_dist_euclidean_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = geo_dist_euclidean_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn geo_dist_euclidean_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn geo_dist_euclidean_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn geo_dist_euclidean_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = geo_dist_euclidean_precision(pred, labels, pos); let r = geo_dist_euclidean_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn geo_dist_euclidean_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn geo_dist_euclidean_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = geo_dist_euclidean_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn geo_dist_euclidean_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn geo_dist_euclidean_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn geo_dist_euclidean_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = geo_dist_euclidean_gcd(a, b)
    (a / g) * b
  }
}

pub fn geo_dist_euclidean_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn geo_dist_euclidean_fibonacci(n : Int) -> Int {
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

pub fn geo_dist_euclidean_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = geo_dist_euclidean_min(data); let mx = geo_dist_euclidean_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn geo_dist_euclidean_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = geo_dist_euclidean_mean(data); let sd = geo_dist_euclidean_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn geo_dist_euclidean_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn geo_dist_euclidean_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn geo_dist_euclidean_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn geo_dist_euclidean_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn geo_dist_euclidean_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn geo_dist_euclidean_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn geo_dist_euclidean_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn geo_dist_euclidean_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn geo_dist_euclidean_dbl(x : Double) -> String {
  let i = if x >= 0.0 { geo_dist_euclidean_int(x) } else { -geo_dist_euclidean_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { geo_dist_euclidean_int(f * 1000000.0) } else { geo_dist_euclidean_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn geo_dist_euclidean_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn geo_dist_euclidean_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct GeodisteuclideanFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_euclidean_frame_make(size : Int) -> GeodisteuclideanFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_euclidean_frame_len(s : GeodisteuclideanFrame) -> Int { s.size }

pub fn geo_dist_euclidean_frame_get(s : GeodisteuclideanFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_euclidean_frame_set(s : GeodisteuclideanFrame, i : Int, v : Double) -> GeodisteuclideanFrame {
  let result = geo_dist_euclidean_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_dist_euclidean_frame_sum(s : GeodisteuclideanFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_dist_euclidean_frame_mean(s : GeodisteuclideanFrame) -> Double {
  if s.size == 0 { 0.0 } else { geo_dist_euclidean_frame_sum(s) / s.size.to_double() }
}

pub fn geo_dist_euclidean_frame_scale(s : GeodisteuclideanFrame, f : Double) -> GeodisteuclideanFrame {
  let result = geo_dist_euclidean_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_dist_euclidean_frame_add(a : GeodisteuclideanFrame, b : GeodisteuclideanFrame) -> GeodisteuclideanFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_dist_euclidean_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_dist_euclidean_frame_copy(s : GeodisteuclideanFrame) -> GeodisteuclideanFrame {
  let result = geo_dist_euclidean_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_dist_euclidean_frame_fill(s : GeodisteuclideanFrame, v : Double) -> GeodisteuclideanFrame {
  let result = geo_dist_euclidean_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_dist_euclidean_frame_min(s : GeodisteuclideanFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_euclidean_frame_max(s : GeodisteuclideanFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_euclidean_frame_to_string(s : GeodisteuclideanFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodisteuclideanTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_euclidean_table_make(size : Int) -> GeodisteuclideanTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_euclidean_table_len(s : GeodisteuclideanTable) -> Int { s.size }

pub fn geo_dist_euclidean_table_get(s : GeodisteuclideanTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_euclidean_table_set(s : GeodisteuclideanTable, i : Int, v : Double) -> GeodisteuclideanTable {
  let result = geo_dist_euclidean_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_dist_euclidean_table_sum(s : GeodisteuclideanTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_dist_euclidean_table_mean(s : GeodisteuclideanTable) -> Double {
  if s.size == 0 { 0.0 } else { geo_dist_euclidean_table_sum(s) / s.size.to_double() }
}

pub fn geo_dist_euclidean_table_scale(s : GeodisteuclideanTable, f : Double) -> GeodisteuclideanTable {
  let result = geo_dist_euclidean_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_dist_euclidean_table_add(a : GeodisteuclideanTable, b : GeodisteuclideanTable) -> GeodisteuclideanTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_dist_euclidean_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_dist_euclidean_table_copy(s : GeodisteuclideanTable) -> GeodisteuclideanTable {
  let result = geo_dist_euclidean_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_dist_euclidean_table_fill(s : GeodisteuclideanTable, v : Double) -> GeodisteuclideanTable {
  let result = geo_dist_euclidean_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_dist_euclidean_table_min(s : GeodisteuclideanTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_euclidean_table_max(s : GeodisteuclideanTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_euclidean_table_to_string(s : GeodisteuclideanTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodisteuclideanGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_euclidean_graphn_make(size : Int) -> GeodisteuclideanGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_euclidean_graphn_len(s : GeodisteuclideanGraphN) -> Int { s.size }

pub fn geo_dist_euclidean_graphn_get(s : GeodisteuclideanGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_euclidean_graphn_set(s : GeodisteuclideanGraphN, i : Int, v : Double) -> GeodisteuclideanGraphN {
  let result = geo_dist_euclidean_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_dist_euclidean_graphn_sum(s : GeodisteuclideanGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_dist_euclidean_graphn_mean(s : GeodisteuclideanGraphN) -> Double {
  if s.size == 0 { 0.0 } else { geo_dist_euclidean_graphn_sum(s) / s.size.to_double() }
}

pub fn geo_dist_euclidean_graphn_scale(s : GeodisteuclideanGraphN, f : Double) -> GeodisteuclideanGraphN {
  let result = geo_dist_euclidean_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_dist_euclidean_graphn_add(a : GeodisteuclideanGraphN, b : GeodisteuclideanGraphN) -> GeodisteuclideanGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_dist_euclidean_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_dist_euclidean_graphn_copy(s : GeodisteuclideanGraphN) -> GeodisteuclideanGraphN {
  let result = geo_dist_euclidean_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_dist_euclidean_graphn_fill(s : GeodisteuclideanGraphN, v : Double) -> GeodisteuclideanGraphN {
  let result = geo_dist_euclidean_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_dist_euclidean_graphn_min(s : GeodisteuclideanGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_euclidean_graphn_max(s : GeodisteuclideanGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_euclidean_graphn_to_string(s : GeodisteuclideanGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodisteuclideanNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_euclidean_node_make(size : Int) -> GeodisteuclideanNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_euclidean_node_len(s : GeodisteuclideanNode) -> Int { s.size }

pub fn geo_dist_euclidean_node_get(s : GeodisteuclideanNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_euclidean_node_set(s : GeodisteuclideanNode, i : Int, v : Double) -> GeodisteuclideanNode {
  let result = geo_dist_euclidean_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_dist_euclidean_node_sum(s : GeodisteuclideanNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_dist_euclidean_node_mean(s : GeodisteuclideanNode) -> Double {
  if s.size == 0 { 0.0 } else { geo_dist_euclidean_node_sum(s) / s.size.to_double() }
}

pub fn geo_dist_euclidean_node_scale(s : GeodisteuclideanNode, f : Double) -> GeodisteuclideanNode {
  let result = geo_dist_euclidean_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_dist_euclidean_node_add(a : GeodisteuclideanNode, b : GeodisteuclideanNode) -> GeodisteuclideanNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_dist_euclidean_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_dist_euclidean_node_copy(s : GeodisteuclideanNode) -> GeodisteuclideanNode {
  let result = geo_dist_euclidean_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_dist_euclidean_node_fill(s : GeodisteuclideanNode, v : Double) -> GeodisteuclideanNode {
  let result = geo_dist_euclidean_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_dist_euclidean_node_min(s : GeodisteuclideanNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_euclidean_node_max(s : GeodisteuclideanNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_euclidean_node_to_string(s : GeodisteuclideanNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodisteuclideanEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_euclidean_edge_make(size : Int) -> GeodisteuclideanEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_euclidean_edge_len(s : GeodisteuclideanEdge) -> Int { s.size }

pub fn geo_dist_euclidean_edge_get(s : GeodisteuclideanEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_euclidean_edge_set(s : GeodisteuclideanEdge, i : Int, v : Double) -> GeodisteuclideanEdge {
  let result = geo_dist_euclidean_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_dist_euclidean_edge_sum(s : GeodisteuclideanEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_dist_euclidean_edge_mean(s : GeodisteuclideanEdge) -> Double {
  if s.size == 0 { 0.0 } else { geo_dist_euclidean_edge_sum(s) / s.size.to_double() }
}

pub fn geo_dist_euclidean_edge_scale(s : GeodisteuclideanEdge, f : Double) -> GeodisteuclideanEdge {
  let result = geo_dist_euclidean_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_dist_euclidean_edge_add(a : GeodisteuclideanEdge, b : GeodisteuclideanEdge) -> GeodisteuclideanEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_dist_euclidean_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_dist_euclidean_edge_copy(s : GeodisteuclideanEdge) -> GeodisteuclideanEdge {
  let result = geo_dist_euclidean_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_dist_euclidean_edge_fill(s : GeodisteuclideanEdge, v : Double) -> GeodisteuclideanEdge {
  let result = geo_dist_euclidean_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_dist_euclidean_edge_min(s : GeodisteuclideanEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_euclidean_edge_max(s : GeodisteuclideanEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_euclidean_edge_to_string(s : GeodisteuclideanEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodisteuclideanPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_euclidean_path_make(size : Int) -> GeodisteuclideanPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_euclidean_path_len(s : GeodisteuclideanPath) -> Int { s.size }

pub fn geo_dist_euclidean_path_get(s : GeodisteuclideanPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_euclidean_path_set(s : GeodisteuclideanPath, i : Int, v : Double) -> GeodisteuclideanPath {
  let result = geo_dist_euclidean_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_dist_euclidean_path_sum(s : GeodisteuclideanPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_dist_euclidean_path_mean(s : GeodisteuclideanPath) -> Double {
  if s.size == 0 { 0.0 } else { geo_dist_euclidean_path_sum(s) / s.size.to_double() }
}

pub fn geo_dist_euclidean_path_scale(s : GeodisteuclideanPath, f : Double) -> GeodisteuclideanPath {
  let result = geo_dist_euclidean_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_dist_euclidean_path_add(a : GeodisteuclideanPath, b : GeodisteuclideanPath) -> GeodisteuclideanPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_dist_euclidean_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_dist_euclidean_path_copy(s : GeodisteuclideanPath) -> GeodisteuclideanPath {
  let result = geo_dist_euclidean_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_dist_euclidean_path_fill(s : GeodisteuclideanPath, v : Double) -> GeodisteuclideanPath {
  let result = geo_dist_euclidean_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_dist_euclidean_path_min(s : GeodisteuclideanPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_euclidean_path_max(s : GeodisteuclideanPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_euclidean_path_to_string(s : GeodisteuclideanPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodisteuclideanCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_euclidean_cluster_make(size : Int) -> GeodisteuclideanCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_euclidean_cluster_len(s : GeodisteuclideanCluster) -> Int { s.size }

pub fn geo_dist_euclidean_cluster_get(s : GeodisteuclideanCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_euclidean_cluster_set(s : GeodisteuclideanCluster, i : Int, v : Double) -> GeodisteuclideanCluster {
  let result = geo_dist_euclidean_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_dist_euclidean_cluster_sum(s : GeodisteuclideanCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_dist_euclidean_cluster_mean(s : GeodisteuclideanCluster) -> Double {
  if s.size == 0 { 0.0 } else { geo_dist_euclidean_cluster_sum(s) / s.size.to_double() }
}

pub fn geo_dist_euclidean_cluster_scale(s : GeodisteuclideanCluster, f : Double) -> GeodisteuclideanCluster {
  let result = geo_dist_euclidean_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_dist_euclidean_cluster_add(a : GeodisteuclideanCluster, b : GeodisteuclideanCluster) -> GeodisteuclideanCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_dist_euclidean_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_dist_euclidean_cluster_copy(s : GeodisteuclideanCluster) -> GeodisteuclideanCluster {
  let result = geo_dist_euclidean_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_dist_euclidean_cluster_fill(s : GeodisteuclideanCluster, v : Double) -> GeodisteuclideanCluster {
  let result = geo_dist_euclidean_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_dist_euclidean_cluster_min(s : GeodisteuclideanCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_euclidean_cluster_max(s : GeodisteuclideanCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_euclidean_cluster_to_string(s : GeodisteuclideanCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodisteuclideanModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_euclidean_model_make(size : Int) -> GeodisteuclideanModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_euclidean_model_len(s : GeodisteuclideanModel) -> Int { s.size }

pub fn geo_dist_euclidean_model_get(s : GeodisteuclideanModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_euclidean_model_set(s : GeodisteuclideanModel, i : Int, v : Double) -> GeodisteuclideanModel {
  let result = geo_dist_euclidean_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_dist_euclidean_model_sum(s : GeodisteuclideanModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_dist_euclidean_model_mean(s : GeodisteuclideanModel) -> Double {
  if s.size == 0 { 0.0 } else { geo_dist_euclidean_model_sum(s) / s.size.to_double() }
}

pub fn geo_dist_euclidean_model_scale(s : GeodisteuclideanModel, f : Double) -> GeodisteuclideanModel {
  let result = geo_dist_euclidean_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_dist_euclidean_model_add(a : GeodisteuclideanModel, b : GeodisteuclideanModel) -> GeodisteuclideanModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_dist_euclidean_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_dist_euclidean_model_copy(s : GeodisteuclideanModel) -> GeodisteuclideanModel {
  let result = geo_dist_euclidean_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_dist_euclidean_model_fill(s : GeodisteuclideanModel, v : Double) -> GeodisteuclideanModel {
  let result = geo_dist_euclidean_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_dist_euclidean_model_min(s : GeodisteuclideanModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_euclidean_model_max(s : GeodisteuclideanModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_euclidean_model_to_string(s : GeodisteuclideanModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodisteuclideanLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_euclidean_layer_make(size : Int) -> GeodisteuclideanLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_euclidean_layer_len(s : GeodisteuclideanLayer) -> Int { s.size }

pub fn geo_dist_euclidean_layer_get(s : GeodisteuclideanLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_euclidean_layer_set(s : GeodisteuclideanLayer, i : Int, v : Double) -> GeodisteuclideanLayer {
  let result = geo_dist_euclidean_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_dist_euclidean_layer_sum(s : GeodisteuclideanLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_dist_euclidean_layer_mean(s : GeodisteuclideanLayer) -> Double {
  if s.size == 0 { 0.0 } else { geo_dist_euclidean_layer_sum(s) / s.size.to_double() }
}

pub fn geo_dist_euclidean_layer_scale(s : GeodisteuclideanLayer, f : Double) -> GeodisteuclideanLayer {
  let result = geo_dist_euclidean_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_dist_euclidean_layer_add(a : GeodisteuclideanLayer, b : GeodisteuclideanLayer) -> GeodisteuclideanLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_dist_euclidean_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_dist_euclidean_layer_copy(s : GeodisteuclideanLayer) -> GeodisteuclideanLayer {
  let result = geo_dist_euclidean_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_dist_euclidean_layer_fill(s : GeodisteuclideanLayer, v : Double) -> GeodisteuclideanLayer {
  let result = geo_dist_euclidean_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_dist_euclidean_layer_min(s : GeodisteuclideanLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_euclidean_layer_max(s : GeodisteuclideanLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_euclidean_layer_to_string(s : GeodisteuclideanLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodisteuclideanBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_euclidean_buffer_make(size : Int) -> GeodisteuclideanBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_euclidean_buffer_len(s : GeodisteuclideanBuffer) -> Int { s.size }

pub fn geo_dist_euclidean_buffer_get(s : GeodisteuclideanBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_euclidean_buffer_set(s : GeodisteuclideanBuffer, i : Int, v : Double) -> GeodisteuclideanBuffer {
  let result = geo_dist_euclidean_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_dist_euclidean_buffer_sum(s : GeodisteuclideanBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_dist_euclidean_buffer_mean(s : GeodisteuclideanBuffer) -> Double {
  if s.size == 0 { 0.0 } else { geo_dist_euclidean_buffer_sum(s) / s.size.to_double() }
}

pub fn geo_dist_euclidean_buffer_scale(s : GeodisteuclideanBuffer, f : Double) -> GeodisteuclideanBuffer {
  let result = geo_dist_euclidean_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_dist_euclidean_buffer_add(a : GeodisteuclideanBuffer, b : GeodisteuclideanBuffer) -> GeodisteuclideanBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_dist_euclidean_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_dist_euclidean_buffer_copy(s : GeodisteuclideanBuffer) -> GeodisteuclideanBuffer {
  let result = geo_dist_euclidean_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_dist_euclidean_buffer_fill(s : GeodisteuclideanBuffer, v : Double) -> GeodisteuclideanBuffer {
  let result = geo_dist_euclidean_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_dist_euclidean_buffer_min(s : GeodisteuclideanBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_euclidean_buffer_max(s : GeodisteuclideanBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_euclidean_buffer_to_string(s : GeodisteuclideanBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodisteuclideanCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_euclidean_cursor_make(size : Int) -> GeodisteuclideanCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_euclidean_cursor_len(s : GeodisteuclideanCursor) -> Int { s.size }

pub fn geo_dist_euclidean_cursor_get(s : GeodisteuclideanCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_euclidean_cursor_set(s : GeodisteuclideanCursor, i : Int, v : Double) -> GeodisteuclideanCursor {
  let result = geo_dist_euclidean_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_dist_euclidean_cursor_sum(s : GeodisteuclideanCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_dist_euclidean_cursor_mean(s : GeodisteuclideanCursor) -> Double {
  if s.size == 0 { 0.0 } else { geo_dist_euclidean_cursor_sum(s) / s.size.to_double() }
}

pub fn geo_dist_euclidean_cursor_scale(s : GeodisteuclideanCursor, f : Double) -> GeodisteuclideanCursor {
  let result = geo_dist_euclidean_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_dist_euclidean_cursor_add(a : GeodisteuclideanCursor, b : GeodisteuclideanCursor) -> GeodisteuclideanCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_dist_euclidean_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_dist_euclidean_cursor_copy(s : GeodisteuclideanCursor) -> GeodisteuclideanCursor {
  let result = geo_dist_euclidean_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_dist_euclidean_cursor_fill(s : GeodisteuclideanCursor, v : Double) -> GeodisteuclideanCursor {
  let result = geo_dist_euclidean_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_dist_euclidean_cursor_min(s : GeodisteuclideanCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_euclidean_cursor_max(s : GeodisteuclideanCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_euclidean_cursor_to_string(s : GeodisteuclideanCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodisteuclideanView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_euclidean_view_make(size : Int) -> GeodisteuclideanView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_euclidean_view_len(s : GeodisteuclideanView) -> Int { s.size }

pub fn geo_dist_euclidean_view_get(s : GeodisteuclideanView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_euclidean_view_set(s : GeodisteuclideanView, i : Int, v : Double) -> GeodisteuclideanView {
  let result = geo_dist_euclidean_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_dist_euclidean_view_sum(s : GeodisteuclideanView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_dist_euclidean_view_mean(s : GeodisteuclideanView) -> Double {
  if s.size == 0 { 0.0 } else { geo_dist_euclidean_view_sum(s) / s.size.to_double() }
}

pub fn geo_dist_euclidean_view_scale(s : GeodisteuclideanView, f : Double) -> GeodisteuclideanView {
  let result = geo_dist_euclidean_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_dist_euclidean_view_add(a : GeodisteuclideanView, b : GeodisteuclideanView) -> GeodisteuclideanView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_dist_euclidean_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_dist_euclidean_view_copy(s : GeodisteuclideanView) -> GeodisteuclideanView {
  let result = geo_dist_euclidean_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_dist_euclidean_view_fill(s : GeodisteuclideanView, v : Double) -> GeodisteuclideanView {
  let result = geo_dist_euclidean_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_dist_euclidean_view_min(s : GeodisteuclideanView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_euclidean_view_max(s : GeodisteuclideanView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_euclidean_view_to_string(s : GeodisteuclideanView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodisteuclideanRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_euclidean_range_make(size : Int) -> GeodisteuclideanRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_euclidean_range_len(s : GeodisteuclideanRange) -> Int { s.size }

pub fn geo_dist_euclidean_range_get(s : GeodisteuclideanRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_euclidean_range_set(s : GeodisteuclideanRange, i : Int, v : Double) -> GeodisteuclideanRange {
  let result = geo_dist_euclidean_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_dist_euclidean_range_sum(s : GeodisteuclideanRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_dist_euclidean_range_mean(s : GeodisteuclideanRange) -> Double {
  if s.size == 0 { 0.0 } else { geo_dist_euclidean_range_sum(s) / s.size.to_double() }
}

pub fn geo_dist_euclidean_range_scale(s : GeodisteuclideanRange, f : Double) -> GeodisteuclideanRange {
  let result = geo_dist_euclidean_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_dist_euclidean_range_add(a : GeodisteuclideanRange, b : GeodisteuclideanRange) -> GeodisteuclideanRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_dist_euclidean_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_dist_euclidean_range_copy(s : GeodisteuclideanRange) -> GeodisteuclideanRange {
  let result = geo_dist_euclidean_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_dist_euclidean_range_fill(s : GeodisteuclideanRange, v : Double) -> GeodisteuclideanRange {
  let result = geo_dist_euclidean_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_dist_euclidean_range_min(s : GeodisteuclideanRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_euclidean_range_max(s : GeodisteuclideanRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_euclidean_range_to_string(s : GeodisteuclideanRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodisteuclideanSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_euclidean_slice_make(size : Int) -> GeodisteuclideanSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_euclidean_slice_len(s : GeodisteuclideanSlice) -> Int { s.size }

pub fn geo_dist_euclidean_slice_get(s : GeodisteuclideanSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_euclidean_slice_set(s : GeodisteuclideanSlice, i : Int, v : Double) -> GeodisteuclideanSlice {
  let result = geo_dist_euclidean_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_dist_euclidean_slice_sum(s : GeodisteuclideanSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_dist_euclidean_slice_mean(s : GeodisteuclideanSlice) -> Double {
  if s.size == 0 { 0.0 } else { geo_dist_euclidean_slice_sum(s) / s.size.to_double() }
}

pub fn geo_dist_euclidean_slice_scale(s : GeodisteuclideanSlice, f : Double) -> GeodisteuclideanSlice {
  let result = geo_dist_euclidean_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_dist_euclidean_slice_add(a : GeodisteuclideanSlice, b : GeodisteuclideanSlice) -> GeodisteuclideanSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_dist_euclidean_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_dist_euclidean_slice_copy(s : GeodisteuclideanSlice) -> GeodisteuclideanSlice {
  let result = geo_dist_euclidean_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_dist_euclidean_slice_fill(s : GeodisteuclideanSlice, v : Double) -> GeodisteuclideanSlice {
  let result = geo_dist_euclidean_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_dist_euclidean_slice_min(s : GeodisteuclideanSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_euclidean_slice_max(s : GeodisteuclideanSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_euclidean_slice_to_string(s : GeodisteuclideanSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn geo_dist_euclidean_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_dist_euclidean_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_dist_euclidean_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_dist_euclidean_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_dist_euclidean_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_dist_euclidean_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_dist_euclidean_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_dist_euclidean_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_dist_euclidean_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_dist_euclidean_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_dist_euclidean_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_dist_euclidean_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_dist_euclidean_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_dist_euclidean_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_dist_euclidean_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_dist_euclidean_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_dist_euclidean_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_dist_euclidean_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_dist_euclidean_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_dist_euclidean_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_dist_euclidean_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_dist_euclidean_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_dist_euclidean_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_dist_euclidean_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_dist_euclidean_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

