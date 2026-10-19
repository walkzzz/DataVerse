///===
/// extcore/geo_dist_great_circle

pub(all) struct GeodistgreatcirclePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn geo_dist_great_circle_make_point(x : Double, y : Double) -> GeodistgreatcirclePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn geo_dist_great_circle_make_point3(x : Double, y : Double, z : Double) -> GeodistgreatcirclePoint {
  { x, y, z, label: 0 }
}

pub fn geo_dist_great_circle_point_x(pt : GeodistgreatcirclePoint) -> Double { pt.x }

pub fn geo_dist_great_circle_point_y(pt : GeodistgreatcirclePoint) -> Double { pt.y }

pub fn geo_dist_great_circle_point_z(pt : GeodistgreatcirclePoint) -> Double { pt.z }

pub fn geo_dist_great_circle_point_label(pt : GeodistgreatcirclePoint) -> Int { pt.label }

pub fn geo_dist_great_circle_point_dist(a : GeodistgreatcirclePoint, b : GeodistgreatcirclePoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  geo_dist_great_circle_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn geo_dist_great_circle_point_add(a : GeodistgreatcirclePoint, b : GeodistgreatcirclePoint) -> GeodistgreatcirclePoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn geo_dist_great_circle_point_sub(a : GeodistgreatcirclePoint, b : GeodistgreatcirclePoint) -> GeodistgreatcirclePoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn geo_dist_great_circle_point_scale(pt : GeodistgreatcirclePoint, s : Double) -> GeodistgreatcirclePoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn geo_dist_great_circle_point_dot(a : GeodistgreatcirclePoint, b : GeodistgreatcirclePoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn geo_dist_great_circle_point_cross(a : GeodistgreatcirclePoint, b : GeodistgreatcirclePoint) -> GeodistgreatcirclePoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn geo_dist_great_circle_point_norm(pt : GeodistgreatcirclePoint) -> Double {
  geo_dist_great_circle_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn geo_dist_great_circle_point_normalize(pt : GeodistgreatcirclePoint) -> GeodistgreatcirclePoint {
  let n = geo_dist_great_circle_point_norm(pt)
  if n < 0.0000001 { pt } else { geo_dist_great_circle_point_scale(pt, 1.0 / n) }
}

pub fn geo_dist_great_circle_point_negate(pt : GeodistgreatcirclePoint) -> GeodistgreatcirclePoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn geo_dist_great_circle_point_mid(a : GeodistgreatcirclePoint, b : GeodistgreatcirclePoint) -> GeodistgreatcirclePoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn geo_dist_great_circle_point_lerp(a : GeodistgreatcirclePoint, b : GeodistgreatcirclePoint, t : Double) -> GeodistgreatcirclePoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn geo_dist_great_circle_point_to_string(pt : GeodistgreatcirclePoint) -> String {
  "(" + geo_dist_great_circle_dbl(pt.x) + ", " + geo_dist_great_circle_dbl(pt.y) + ", " + geo_dist_great_circle_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct GeodistgreatcircleSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn geo_dist_great_circle_make_series(vals : Array[Double], name : String) -> GeodistgreatcircleSeries {
  { vals, name, meta: 0 }
}

pub fn geo_dist_great_circle_series_len(s : GeodistgreatcircleSeries) -> Int { s.vals.length() }

pub fn geo_dist_great_circle_series_sum(s : GeodistgreatcircleSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn geo_dist_great_circle_series_mean(s : GeodistgreatcircleSeries) -> Double {
  let n = geo_dist_great_circle_series_len(s)
  if n == 0 { 0.0 } else { geo_dist_great_circle_series_sum(s) / n.to_double() }
}

pub fn geo_dist_great_circle_series_min(s : GeodistgreatcircleSeries) -> Double {
  let n = geo_dist_great_circle_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn geo_dist_great_circle_series_max(s : GeodistgreatcircleSeries) -> Double {
  let n = geo_dist_great_circle_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn geo_dist_great_circle_series_range(s : GeodistgreatcircleSeries) -> Double {
  geo_dist_great_circle_series_max(s) - geo_dist_great_circle_series_min(s)
}

pub fn geo_dist_great_circle_series_var(s : GeodistgreatcircleSeries) -> Double {
  let n = geo_dist_great_circle_series_len(s)
  if n == 0 { 0.0 } else {
    let m = geo_dist_great_circle_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn geo_dist_great_circle_series_std(s : GeodistgreatcircleSeries) -> Double { geo_dist_great_circle_sqrt(geo_dist_great_circle_series_var(s)) }

pub fn geo_dist_great_circle_series_median(s : GeodistgreatcircleSeries) -> Double {
  let n = geo_dist_great_circle_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = geo_dist_great_circle_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn geo_dist_great_circle_series_scale(s : GeodistgreatcircleSeries, f : Double) -> GeodistgreatcircleSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = geo_dist_great_circle_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn geo_dist_great_circle_series_add(a : GeodistgreatcircleSeries, b : GeodistgreatcircleSeries) -> GeodistgreatcircleSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = geo_dist_great_circle_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn geo_dist_great_circle_series_sub(a : GeodistgreatcircleSeries, b : GeodistgreatcircleSeries) -> GeodistgreatcircleSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = geo_dist_great_circle_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn geo_dist_great_circle_series_normalize(s : GeodistgreatcircleSeries) -> GeodistgreatcircleSeries {
  let mn = geo_dist_great_circle_series_min(s)
  let mx = geo_dist_great_circle_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = geo_dist_great_circle_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn geo_dist_great_circle_series_cumsum(s : GeodistgreatcircleSeries) -> GeodistgreatcircleSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = geo_dist_great_circle_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn geo_dist_great_circle_series_to_string(s : GeodistgreatcircleSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + geo_dist_great_circle_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GeodistgreatcircleMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn geo_dist_great_circle_make_matrix(rows : Int, cols : Int, val : Double) -> GeodistgreatcircleMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn geo_dist_great_circle_matrix_identity(n : Int) -> GeodistgreatcircleMatrix {
  let m = geo_dist_great_circle_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn geo_dist_great_circle_matrix_get(m : GeodistgreatcircleMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn geo_dist_great_circle_matrix_transpose(m : GeodistgreatcircleMatrix) -> GeodistgreatcircleMatrix {
  let result = geo_dist_great_circle_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn geo_dist_great_circle_matrix_add(a : GeodistgreatcircleMatrix, b : GeodistgreatcircleMatrix) -> GeodistgreatcircleMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = geo_dist_great_circle_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn geo_dist_great_circle_matrix_scale(m : GeodistgreatcircleMatrix, s : Double) -> GeodistgreatcircleMatrix {
  let result = geo_dist_great_circle_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn geo_dist_great_circle_matrix_multiply(a : GeodistgreatcircleMatrix, b : GeodistgreatcircleMatrix) -> GeodistgreatcircleMatrix {
  if a.cols != b.rows { return geo_dist_great_circle_make_matrix(a.rows, b.cols, 0.0) }
  let result = geo_dist_great_circle_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn geo_dist_great_circle_matrix_trace(m : GeodistgreatcircleMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn geo_dist_great_circle_matrix_det(m : GeodistgreatcircleMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn geo_dist_great_circle_matrix_norm(m : GeodistgreatcircleMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  geo_dist_great_circle_sqrt(sum)
}

pub fn geo_dist_great_circle_matrix_to_string(m : GeodistgreatcircleMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + geo_dist_great_circle_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct GeodistgreatcircleVector {
  comps : Array[Double]
  dim : Int
}

pub fn geo_dist_great_circle_make_vector(comps : Array[Double]) -> GeodistgreatcircleVector {
  { comps, dim: comps.length() }
}

pub fn geo_dist_great_circle_vector_zero(dim : Int) -> GeodistgreatcircleVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn geo_dist_great_circle_vector_add(a : GeodistgreatcircleVector, b : GeodistgreatcircleVector) -> GeodistgreatcircleVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = geo_dist_great_circle_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn geo_dist_great_circle_vector_sub(a : GeodistgreatcircleVector, b : GeodistgreatcircleVector) -> GeodistgreatcircleVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = geo_dist_great_circle_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn geo_dist_great_circle_vector_scale(v : GeodistgreatcircleVector, s : Double) -> GeodistgreatcircleVector {
  let mut result = []
  for i in 0..<v.dim { result = geo_dist_great_circle_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn geo_dist_great_circle_vector_dot(a : GeodistgreatcircleVector, b : GeodistgreatcircleVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn geo_dist_great_circle_vector_norm(v : GeodistgreatcircleVector) -> Double { geo_dist_great_circle_sqrt(geo_dist_great_circle_vector_dot(v, v)) }

pub fn geo_dist_great_circle_vector_normalize(v : GeodistgreatcircleVector) -> GeodistgreatcircleVector {
  let n = geo_dist_great_circle_vector_norm(v)
  if n < 0.0000001 { v } else { geo_dist_great_circle_vector_scale(v, 1.0 / n) }
}

pub fn geo_dist_great_circle_vector_dist(a : GeodistgreatcircleVector, b : GeodistgreatcircleVector) -> Double {
  geo_dist_great_circle_vector_norm(geo_dist_great_circle_vector_sub(a, b))
}

pub fn geo_dist_great_circle_vector_to_string(v : GeodistgreatcircleVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + geo_dist_great_circle_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn geo_dist_great_circle_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn geo_dist_great_circle_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = geo_dist_great_circle_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn geo_dist_great_circle_std(data : Array[Double]) -> Double { geo_dist_great_circle_sqrt(geo_dist_great_circle_var(data)) }

pub fn geo_dist_great_circle_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = geo_dist_great_circle_mean(a); let mb = geo_dist_great_circle_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn geo_dist_great_circle_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = geo_dist_great_circle_std(a); let sb = geo_dist_great_circle_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { geo_dist_great_circle_cov(a, b) / (sa * sb) }
}

pub fn geo_dist_great_circle_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = geo_dist_great_circle_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn geo_dist_great_circle_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn geo_dist_great_circle_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn geo_dist_great_circle_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  geo_dist_great_circle_sqrt(geo_dist_great_circle_mse(pred, labels))
}

pub fn geo_dist_great_circle_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + geo_dist_great_circle_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn geo_dist_great_circle_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = geo_dist_great_circle_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn geo_dist_great_circle_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn geo_dist_great_circle_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn geo_dist_great_circle_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = geo_dist_great_circle_precision(pred, labels, pos); let r = geo_dist_great_circle_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn geo_dist_great_circle_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn geo_dist_great_circle_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = geo_dist_great_circle_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn geo_dist_great_circle_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn geo_dist_great_circle_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn geo_dist_great_circle_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = geo_dist_great_circle_gcd(a, b)
    (a / g) * b
  }
}

pub fn geo_dist_great_circle_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn geo_dist_great_circle_fibonacci(n : Int) -> Int {
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

pub fn geo_dist_great_circle_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = geo_dist_great_circle_min(data); let mx = geo_dist_great_circle_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn geo_dist_great_circle_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = geo_dist_great_circle_mean(data); let sd = geo_dist_great_circle_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn geo_dist_great_circle_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn geo_dist_great_circle_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn geo_dist_great_circle_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn geo_dist_great_circle_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn geo_dist_great_circle_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn geo_dist_great_circle_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn geo_dist_great_circle_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn geo_dist_great_circle_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn geo_dist_great_circle_dbl(x : Double) -> String {
  let i = if x >= 0.0 { geo_dist_great_circle_int(x) } else { -geo_dist_great_circle_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { geo_dist_great_circle_int(f * 1000000.0) } else { geo_dist_great_circle_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn geo_dist_great_circle_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn geo_dist_great_circle_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct GeodistgreatcircleFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_great_circle_frame_make(size : Int) -> GeodistgreatcircleFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_great_circle_frame_len(s : GeodistgreatcircleFrame) -> Int { s.size }

pub fn geo_dist_great_circle_frame_get(s : GeodistgreatcircleFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_great_circle_frame_set(s : GeodistgreatcircleFrame, i : Int, v : Double) -> GeodistgreatcircleFrame {
  let result = geo_dist_great_circle_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_dist_great_circle_frame_sum(s : GeodistgreatcircleFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_dist_great_circle_frame_mean(s : GeodistgreatcircleFrame) -> Double {
  if s.size == 0 { 0.0 } else { geo_dist_great_circle_frame_sum(s) / s.size.to_double() }
}

pub fn geo_dist_great_circle_frame_scale(s : GeodistgreatcircleFrame, f : Double) -> GeodistgreatcircleFrame {
  let result = geo_dist_great_circle_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_dist_great_circle_frame_add(a : GeodistgreatcircleFrame, b : GeodistgreatcircleFrame) -> GeodistgreatcircleFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_dist_great_circle_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_dist_great_circle_frame_copy(s : GeodistgreatcircleFrame) -> GeodistgreatcircleFrame {
  let result = geo_dist_great_circle_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_dist_great_circle_frame_fill(s : GeodistgreatcircleFrame, v : Double) -> GeodistgreatcircleFrame {
  let result = geo_dist_great_circle_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_dist_great_circle_frame_min(s : GeodistgreatcircleFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_great_circle_frame_max(s : GeodistgreatcircleFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_great_circle_frame_to_string(s : GeodistgreatcircleFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistgreatcircleTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_great_circle_table_make(size : Int) -> GeodistgreatcircleTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_great_circle_table_len(s : GeodistgreatcircleTable) -> Int { s.size }

pub fn geo_dist_great_circle_table_get(s : GeodistgreatcircleTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_great_circle_table_set(s : GeodistgreatcircleTable, i : Int, v : Double) -> GeodistgreatcircleTable {
  let result = geo_dist_great_circle_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_dist_great_circle_table_sum(s : GeodistgreatcircleTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_dist_great_circle_table_mean(s : GeodistgreatcircleTable) -> Double {
  if s.size == 0 { 0.0 } else { geo_dist_great_circle_table_sum(s) / s.size.to_double() }
}

pub fn geo_dist_great_circle_table_scale(s : GeodistgreatcircleTable, f : Double) -> GeodistgreatcircleTable {
  let result = geo_dist_great_circle_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_dist_great_circle_table_add(a : GeodistgreatcircleTable, b : GeodistgreatcircleTable) -> GeodistgreatcircleTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_dist_great_circle_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_dist_great_circle_table_copy(s : GeodistgreatcircleTable) -> GeodistgreatcircleTable {
  let result = geo_dist_great_circle_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_dist_great_circle_table_fill(s : GeodistgreatcircleTable, v : Double) -> GeodistgreatcircleTable {
  let result = geo_dist_great_circle_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_dist_great_circle_table_min(s : GeodistgreatcircleTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_great_circle_table_max(s : GeodistgreatcircleTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_great_circle_table_to_string(s : GeodistgreatcircleTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistgreatcircleGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_great_circle_graphn_make(size : Int) -> GeodistgreatcircleGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_great_circle_graphn_len(s : GeodistgreatcircleGraphN) -> Int { s.size }

pub fn geo_dist_great_circle_graphn_get(s : GeodistgreatcircleGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_great_circle_graphn_set(s : GeodistgreatcircleGraphN, i : Int, v : Double) -> GeodistgreatcircleGraphN {
  let result = geo_dist_great_circle_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_dist_great_circle_graphn_sum(s : GeodistgreatcircleGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_dist_great_circle_graphn_mean(s : GeodistgreatcircleGraphN) -> Double {
  if s.size == 0 { 0.0 } else { geo_dist_great_circle_graphn_sum(s) / s.size.to_double() }
}

pub fn geo_dist_great_circle_graphn_scale(s : GeodistgreatcircleGraphN, f : Double) -> GeodistgreatcircleGraphN {
  let result = geo_dist_great_circle_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_dist_great_circle_graphn_add(a : GeodistgreatcircleGraphN, b : GeodistgreatcircleGraphN) -> GeodistgreatcircleGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_dist_great_circle_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_dist_great_circle_graphn_copy(s : GeodistgreatcircleGraphN) -> GeodistgreatcircleGraphN {
  let result = geo_dist_great_circle_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_dist_great_circle_graphn_fill(s : GeodistgreatcircleGraphN, v : Double) -> GeodistgreatcircleGraphN {
  let result = geo_dist_great_circle_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_dist_great_circle_graphn_min(s : GeodistgreatcircleGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_great_circle_graphn_max(s : GeodistgreatcircleGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_great_circle_graphn_to_string(s : GeodistgreatcircleGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistgreatcircleNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_great_circle_node_make(size : Int) -> GeodistgreatcircleNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_great_circle_node_len(s : GeodistgreatcircleNode) -> Int { s.size }

pub fn geo_dist_great_circle_node_get(s : GeodistgreatcircleNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_great_circle_node_set(s : GeodistgreatcircleNode, i : Int, v : Double) -> GeodistgreatcircleNode {
  let result = geo_dist_great_circle_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_dist_great_circle_node_sum(s : GeodistgreatcircleNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_dist_great_circle_node_mean(s : GeodistgreatcircleNode) -> Double {
  if s.size == 0 { 0.0 } else { geo_dist_great_circle_node_sum(s) / s.size.to_double() }
}

pub fn geo_dist_great_circle_node_scale(s : GeodistgreatcircleNode, f : Double) -> GeodistgreatcircleNode {
  let result = geo_dist_great_circle_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_dist_great_circle_node_add(a : GeodistgreatcircleNode, b : GeodistgreatcircleNode) -> GeodistgreatcircleNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_dist_great_circle_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_dist_great_circle_node_copy(s : GeodistgreatcircleNode) -> GeodistgreatcircleNode {
  let result = geo_dist_great_circle_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_dist_great_circle_node_fill(s : GeodistgreatcircleNode, v : Double) -> GeodistgreatcircleNode {
  let result = geo_dist_great_circle_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_dist_great_circle_node_min(s : GeodistgreatcircleNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_great_circle_node_max(s : GeodistgreatcircleNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_great_circle_node_to_string(s : GeodistgreatcircleNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistgreatcircleEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_great_circle_edge_make(size : Int) -> GeodistgreatcircleEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_great_circle_edge_len(s : GeodistgreatcircleEdge) -> Int { s.size }

pub fn geo_dist_great_circle_edge_get(s : GeodistgreatcircleEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_great_circle_edge_set(s : GeodistgreatcircleEdge, i : Int, v : Double) -> GeodistgreatcircleEdge {
  let result = geo_dist_great_circle_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_dist_great_circle_edge_sum(s : GeodistgreatcircleEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_dist_great_circle_edge_mean(s : GeodistgreatcircleEdge) -> Double {
  if s.size == 0 { 0.0 } else { geo_dist_great_circle_edge_sum(s) / s.size.to_double() }
}

pub fn geo_dist_great_circle_edge_scale(s : GeodistgreatcircleEdge, f : Double) -> GeodistgreatcircleEdge {
  let result = geo_dist_great_circle_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_dist_great_circle_edge_add(a : GeodistgreatcircleEdge, b : GeodistgreatcircleEdge) -> GeodistgreatcircleEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_dist_great_circle_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_dist_great_circle_edge_copy(s : GeodistgreatcircleEdge) -> GeodistgreatcircleEdge {
  let result = geo_dist_great_circle_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_dist_great_circle_edge_fill(s : GeodistgreatcircleEdge, v : Double) -> GeodistgreatcircleEdge {
  let result = geo_dist_great_circle_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_dist_great_circle_edge_min(s : GeodistgreatcircleEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_great_circle_edge_max(s : GeodistgreatcircleEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_great_circle_edge_to_string(s : GeodistgreatcircleEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistgreatcirclePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_great_circle_path_make(size : Int) -> GeodistgreatcirclePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_great_circle_path_len(s : GeodistgreatcirclePath) -> Int { s.size }

pub fn geo_dist_great_circle_path_get(s : GeodistgreatcirclePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_great_circle_path_set(s : GeodistgreatcirclePath, i : Int, v : Double) -> GeodistgreatcirclePath {
  let result = geo_dist_great_circle_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_dist_great_circle_path_sum(s : GeodistgreatcirclePath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_dist_great_circle_path_mean(s : GeodistgreatcirclePath) -> Double {
  if s.size == 0 { 0.0 } else { geo_dist_great_circle_path_sum(s) / s.size.to_double() }
}

pub fn geo_dist_great_circle_path_scale(s : GeodistgreatcirclePath, f : Double) -> GeodistgreatcirclePath {
  let result = geo_dist_great_circle_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_dist_great_circle_path_add(a : GeodistgreatcirclePath, b : GeodistgreatcirclePath) -> GeodistgreatcirclePath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_dist_great_circle_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_dist_great_circle_path_copy(s : GeodistgreatcirclePath) -> GeodistgreatcirclePath {
  let result = geo_dist_great_circle_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_dist_great_circle_path_fill(s : GeodistgreatcirclePath, v : Double) -> GeodistgreatcirclePath {
  let result = geo_dist_great_circle_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_dist_great_circle_path_min(s : GeodistgreatcirclePath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_great_circle_path_max(s : GeodistgreatcirclePath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_great_circle_path_to_string(s : GeodistgreatcirclePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistgreatcircleCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_great_circle_cluster_make(size : Int) -> GeodistgreatcircleCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_great_circle_cluster_len(s : GeodistgreatcircleCluster) -> Int { s.size }

pub fn geo_dist_great_circle_cluster_get(s : GeodistgreatcircleCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_great_circle_cluster_set(s : GeodistgreatcircleCluster, i : Int, v : Double) -> GeodistgreatcircleCluster {
  let result = geo_dist_great_circle_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_dist_great_circle_cluster_sum(s : GeodistgreatcircleCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_dist_great_circle_cluster_mean(s : GeodistgreatcircleCluster) -> Double {
  if s.size == 0 { 0.0 } else { geo_dist_great_circle_cluster_sum(s) / s.size.to_double() }
}

pub fn geo_dist_great_circle_cluster_scale(s : GeodistgreatcircleCluster, f : Double) -> GeodistgreatcircleCluster {
  let result = geo_dist_great_circle_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_dist_great_circle_cluster_add(a : GeodistgreatcircleCluster, b : GeodistgreatcircleCluster) -> GeodistgreatcircleCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_dist_great_circle_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_dist_great_circle_cluster_copy(s : GeodistgreatcircleCluster) -> GeodistgreatcircleCluster {
  let result = geo_dist_great_circle_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_dist_great_circle_cluster_fill(s : GeodistgreatcircleCluster, v : Double) -> GeodistgreatcircleCluster {
  let result = geo_dist_great_circle_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_dist_great_circle_cluster_min(s : GeodistgreatcircleCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_great_circle_cluster_max(s : GeodistgreatcircleCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_great_circle_cluster_to_string(s : GeodistgreatcircleCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistgreatcircleModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_great_circle_model_make(size : Int) -> GeodistgreatcircleModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_great_circle_model_len(s : GeodistgreatcircleModel) -> Int { s.size }

pub fn geo_dist_great_circle_model_get(s : GeodistgreatcircleModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_great_circle_model_set(s : GeodistgreatcircleModel, i : Int, v : Double) -> GeodistgreatcircleModel {
  let result = geo_dist_great_circle_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_dist_great_circle_model_sum(s : GeodistgreatcircleModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_dist_great_circle_model_mean(s : GeodistgreatcircleModel) -> Double {
  if s.size == 0 { 0.0 } else { geo_dist_great_circle_model_sum(s) / s.size.to_double() }
}

pub fn geo_dist_great_circle_model_scale(s : GeodistgreatcircleModel, f : Double) -> GeodistgreatcircleModel {
  let result = geo_dist_great_circle_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_dist_great_circle_model_add(a : GeodistgreatcircleModel, b : GeodistgreatcircleModel) -> GeodistgreatcircleModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_dist_great_circle_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_dist_great_circle_model_copy(s : GeodistgreatcircleModel) -> GeodistgreatcircleModel {
  let result = geo_dist_great_circle_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_dist_great_circle_model_fill(s : GeodistgreatcircleModel, v : Double) -> GeodistgreatcircleModel {
  let result = geo_dist_great_circle_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_dist_great_circle_model_min(s : GeodistgreatcircleModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_great_circle_model_max(s : GeodistgreatcircleModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_great_circle_model_to_string(s : GeodistgreatcircleModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistgreatcircleLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_great_circle_layer_make(size : Int) -> GeodistgreatcircleLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_great_circle_layer_len(s : GeodistgreatcircleLayer) -> Int { s.size }

pub fn geo_dist_great_circle_layer_get(s : GeodistgreatcircleLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_great_circle_layer_set(s : GeodistgreatcircleLayer, i : Int, v : Double) -> GeodistgreatcircleLayer {
  let result = geo_dist_great_circle_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_dist_great_circle_layer_sum(s : GeodistgreatcircleLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_dist_great_circle_layer_mean(s : GeodistgreatcircleLayer) -> Double {
  if s.size == 0 { 0.0 } else { geo_dist_great_circle_layer_sum(s) / s.size.to_double() }
}

pub fn geo_dist_great_circle_layer_scale(s : GeodistgreatcircleLayer, f : Double) -> GeodistgreatcircleLayer {
  let result = geo_dist_great_circle_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_dist_great_circle_layer_add(a : GeodistgreatcircleLayer, b : GeodistgreatcircleLayer) -> GeodistgreatcircleLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_dist_great_circle_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_dist_great_circle_layer_copy(s : GeodistgreatcircleLayer) -> GeodistgreatcircleLayer {
  let result = geo_dist_great_circle_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_dist_great_circle_layer_fill(s : GeodistgreatcircleLayer, v : Double) -> GeodistgreatcircleLayer {
  let result = geo_dist_great_circle_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_dist_great_circle_layer_min(s : GeodistgreatcircleLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_great_circle_layer_max(s : GeodistgreatcircleLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_great_circle_layer_to_string(s : GeodistgreatcircleLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistgreatcircleBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_great_circle_buffer_make(size : Int) -> GeodistgreatcircleBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_great_circle_buffer_len(s : GeodistgreatcircleBuffer) -> Int { s.size }

pub fn geo_dist_great_circle_buffer_get(s : GeodistgreatcircleBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_great_circle_buffer_set(s : GeodistgreatcircleBuffer, i : Int, v : Double) -> GeodistgreatcircleBuffer {
  let result = geo_dist_great_circle_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_dist_great_circle_buffer_sum(s : GeodistgreatcircleBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_dist_great_circle_buffer_mean(s : GeodistgreatcircleBuffer) -> Double {
  if s.size == 0 { 0.0 } else { geo_dist_great_circle_buffer_sum(s) / s.size.to_double() }
}

pub fn geo_dist_great_circle_buffer_scale(s : GeodistgreatcircleBuffer, f : Double) -> GeodistgreatcircleBuffer {
  let result = geo_dist_great_circle_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_dist_great_circle_buffer_add(a : GeodistgreatcircleBuffer, b : GeodistgreatcircleBuffer) -> GeodistgreatcircleBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_dist_great_circle_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_dist_great_circle_buffer_copy(s : GeodistgreatcircleBuffer) -> GeodistgreatcircleBuffer {
  let result = geo_dist_great_circle_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_dist_great_circle_buffer_fill(s : GeodistgreatcircleBuffer, v : Double) -> GeodistgreatcircleBuffer {
  let result = geo_dist_great_circle_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_dist_great_circle_buffer_min(s : GeodistgreatcircleBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_great_circle_buffer_max(s : GeodistgreatcircleBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_great_circle_buffer_to_string(s : GeodistgreatcircleBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistgreatcircleCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_great_circle_cursor_make(size : Int) -> GeodistgreatcircleCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_great_circle_cursor_len(s : GeodistgreatcircleCursor) -> Int { s.size }

pub fn geo_dist_great_circle_cursor_get(s : GeodistgreatcircleCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_great_circle_cursor_set(s : GeodistgreatcircleCursor, i : Int, v : Double) -> GeodistgreatcircleCursor {
  let result = geo_dist_great_circle_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_dist_great_circle_cursor_sum(s : GeodistgreatcircleCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_dist_great_circle_cursor_mean(s : GeodistgreatcircleCursor) -> Double {
  if s.size == 0 { 0.0 } else { geo_dist_great_circle_cursor_sum(s) / s.size.to_double() }
}

pub fn geo_dist_great_circle_cursor_scale(s : GeodistgreatcircleCursor, f : Double) -> GeodistgreatcircleCursor {
  let result = geo_dist_great_circle_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_dist_great_circle_cursor_add(a : GeodistgreatcircleCursor, b : GeodistgreatcircleCursor) -> GeodistgreatcircleCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_dist_great_circle_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_dist_great_circle_cursor_copy(s : GeodistgreatcircleCursor) -> GeodistgreatcircleCursor {
  let result = geo_dist_great_circle_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_dist_great_circle_cursor_fill(s : GeodistgreatcircleCursor, v : Double) -> GeodistgreatcircleCursor {
  let result = geo_dist_great_circle_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_dist_great_circle_cursor_min(s : GeodistgreatcircleCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_great_circle_cursor_max(s : GeodistgreatcircleCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_great_circle_cursor_to_string(s : GeodistgreatcircleCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistgreatcircleView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_great_circle_view_make(size : Int) -> GeodistgreatcircleView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_great_circle_view_len(s : GeodistgreatcircleView) -> Int { s.size }

pub fn geo_dist_great_circle_view_get(s : GeodistgreatcircleView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_great_circle_view_set(s : GeodistgreatcircleView, i : Int, v : Double) -> GeodistgreatcircleView {
  let result = geo_dist_great_circle_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_dist_great_circle_view_sum(s : GeodistgreatcircleView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_dist_great_circle_view_mean(s : GeodistgreatcircleView) -> Double {
  if s.size == 0 { 0.0 } else { geo_dist_great_circle_view_sum(s) / s.size.to_double() }
}

pub fn geo_dist_great_circle_view_scale(s : GeodistgreatcircleView, f : Double) -> GeodistgreatcircleView {
  let result = geo_dist_great_circle_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_dist_great_circle_view_add(a : GeodistgreatcircleView, b : GeodistgreatcircleView) -> GeodistgreatcircleView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_dist_great_circle_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_dist_great_circle_view_copy(s : GeodistgreatcircleView) -> GeodistgreatcircleView {
  let result = geo_dist_great_circle_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_dist_great_circle_view_fill(s : GeodistgreatcircleView, v : Double) -> GeodistgreatcircleView {
  let result = geo_dist_great_circle_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_dist_great_circle_view_min(s : GeodistgreatcircleView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_great_circle_view_max(s : GeodistgreatcircleView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_great_circle_view_to_string(s : GeodistgreatcircleView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistgreatcircleRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_great_circle_range_make(size : Int) -> GeodistgreatcircleRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_great_circle_range_len(s : GeodistgreatcircleRange) -> Int { s.size }

pub fn geo_dist_great_circle_range_get(s : GeodistgreatcircleRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_great_circle_range_set(s : GeodistgreatcircleRange, i : Int, v : Double) -> GeodistgreatcircleRange {
  let result = geo_dist_great_circle_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_dist_great_circle_range_sum(s : GeodistgreatcircleRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_dist_great_circle_range_mean(s : GeodistgreatcircleRange) -> Double {
  if s.size == 0 { 0.0 } else { geo_dist_great_circle_range_sum(s) / s.size.to_double() }
}

pub fn geo_dist_great_circle_range_scale(s : GeodistgreatcircleRange, f : Double) -> GeodistgreatcircleRange {
  let result = geo_dist_great_circle_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_dist_great_circle_range_add(a : GeodistgreatcircleRange, b : GeodistgreatcircleRange) -> GeodistgreatcircleRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_dist_great_circle_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_dist_great_circle_range_copy(s : GeodistgreatcircleRange) -> GeodistgreatcircleRange {
  let result = geo_dist_great_circle_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_dist_great_circle_range_fill(s : GeodistgreatcircleRange, v : Double) -> GeodistgreatcircleRange {
  let result = geo_dist_great_circle_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_dist_great_circle_range_min(s : GeodistgreatcircleRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_great_circle_range_max(s : GeodistgreatcircleRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_great_circle_range_to_string(s : GeodistgreatcircleRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistgreatcircleSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_great_circle_slice_make(size : Int) -> GeodistgreatcircleSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_great_circle_slice_len(s : GeodistgreatcircleSlice) -> Int { s.size }

pub fn geo_dist_great_circle_slice_get(s : GeodistgreatcircleSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_great_circle_slice_set(s : GeodistgreatcircleSlice, i : Int, v : Double) -> GeodistgreatcircleSlice {
  let result = geo_dist_great_circle_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_dist_great_circle_slice_sum(s : GeodistgreatcircleSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_dist_great_circle_slice_mean(s : GeodistgreatcircleSlice) -> Double {
  if s.size == 0 { 0.0 } else { geo_dist_great_circle_slice_sum(s) / s.size.to_double() }
}

pub fn geo_dist_great_circle_slice_scale(s : GeodistgreatcircleSlice, f : Double) -> GeodistgreatcircleSlice {
  let result = geo_dist_great_circle_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_dist_great_circle_slice_add(a : GeodistgreatcircleSlice, b : GeodistgreatcircleSlice) -> GeodistgreatcircleSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_dist_great_circle_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_dist_great_circle_slice_copy(s : GeodistgreatcircleSlice) -> GeodistgreatcircleSlice {
  let result = geo_dist_great_circle_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_dist_great_circle_slice_fill(s : GeodistgreatcircleSlice, v : Double) -> GeodistgreatcircleSlice {
  let result = geo_dist_great_circle_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_dist_great_circle_slice_min(s : GeodistgreatcircleSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_great_circle_slice_max(s : GeodistgreatcircleSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_great_circle_slice_to_string(s : GeodistgreatcircleSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn geo_dist_great_circle_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_dist_great_circle_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_dist_great_circle_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_dist_great_circle_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_dist_great_circle_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_dist_great_circle_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_dist_great_circle_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_dist_great_circle_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_dist_great_circle_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_dist_great_circle_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_dist_great_circle_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_dist_great_circle_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_dist_great_circle_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_dist_great_circle_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_dist_great_circle_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_dist_great_circle_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_dist_great_circle_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_dist_great_circle_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_dist_great_circle_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_dist_great_circle_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_dist_great_circle_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_dist_great_circle_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_dist_great_circle_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_dist_great_circle_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_dist_great_circle_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

