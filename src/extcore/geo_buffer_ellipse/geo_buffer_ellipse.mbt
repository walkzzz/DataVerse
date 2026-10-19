///===
/// extcore/geo_buffer_ellipse

pub(all) struct GeobufferellipsePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn geo_buffer_ellipse_make_point(x : Double, y : Double) -> GeobufferellipsePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn geo_buffer_ellipse_make_point3(x : Double, y : Double, z : Double) -> GeobufferellipsePoint {
  { x, y, z, label: 0 }
}

pub fn geo_buffer_ellipse_point_x(pt : GeobufferellipsePoint) -> Double { pt.x }

pub fn geo_buffer_ellipse_point_y(pt : GeobufferellipsePoint) -> Double { pt.y }

pub fn geo_buffer_ellipse_point_z(pt : GeobufferellipsePoint) -> Double { pt.z }

pub fn geo_buffer_ellipse_point_label(pt : GeobufferellipsePoint) -> Int { pt.label }

pub fn geo_buffer_ellipse_point_dist(a : GeobufferellipsePoint, b : GeobufferellipsePoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  geo_buffer_ellipse_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn geo_buffer_ellipse_point_add(a : GeobufferellipsePoint, b : GeobufferellipsePoint) -> GeobufferellipsePoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn geo_buffer_ellipse_point_sub(a : GeobufferellipsePoint, b : GeobufferellipsePoint) -> GeobufferellipsePoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn geo_buffer_ellipse_point_scale(pt : GeobufferellipsePoint, s : Double) -> GeobufferellipsePoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn geo_buffer_ellipse_point_dot(a : GeobufferellipsePoint, b : GeobufferellipsePoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn geo_buffer_ellipse_point_cross(a : GeobufferellipsePoint, b : GeobufferellipsePoint) -> GeobufferellipsePoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn geo_buffer_ellipse_point_norm(pt : GeobufferellipsePoint) -> Double {
  geo_buffer_ellipse_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn geo_buffer_ellipse_point_normalize(pt : GeobufferellipsePoint) -> GeobufferellipsePoint {
  let n = geo_buffer_ellipse_point_norm(pt)
  if n < 0.0000001 { pt } else { geo_buffer_ellipse_point_scale(pt, 1.0 / n) }
}

pub fn geo_buffer_ellipse_point_negate(pt : GeobufferellipsePoint) -> GeobufferellipsePoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn geo_buffer_ellipse_point_mid(a : GeobufferellipsePoint, b : GeobufferellipsePoint) -> GeobufferellipsePoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn geo_buffer_ellipse_point_lerp(a : GeobufferellipsePoint, b : GeobufferellipsePoint, t : Double) -> GeobufferellipsePoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn geo_buffer_ellipse_point_to_string(pt : GeobufferellipsePoint) -> String {
  "(" + geo_buffer_ellipse_dbl(pt.x) + ", " + geo_buffer_ellipse_dbl(pt.y) + ", " + geo_buffer_ellipse_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct GeobufferellipseSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn geo_buffer_ellipse_make_series(vals : Array[Double], name : String) -> GeobufferellipseSeries {
  { vals, name, meta: 0 }
}

pub fn geo_buffer_ellipse_series_len(s : GeobufferellipseSeries) -> Int { s.vals.length() }

pub fn geo_buffer_ellipse_series_sum(s : GeobufferellipseSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn geo_buffer_ellipse_series_mean(s : GeobufferellipseSeries) -> Double {
  let n = geo_buffer_ellipse_series_len(s)
  if n == 0 { 0.0 } else { geo_buffer_ellipse_series_sum(s) / n.to_double() }
}

pub fn geo_buffer_ellipse_series_min(s : GeobufferellipseSeries) -> Double {
  let n = geo_buffer_ellipse_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn geo_buffer_ellipse_series_max(s : GeobufferellipseSeries) -> Double {
  let n = geo_buffer_ellipse_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn geo_buffer_ellipse_series_range(s : GeobufferellipseSeries) -> Double {
  geo_buffer_ellipse_series_max(s) - geo_buffer_ellipse_series_min(s)
}

pub fn geo_buffer_ellipse_series_var(s : GeobufferellipseSeries) -> Double {
  let n = geo_buffer_ellipse_series_len(s)
  if n == 0 { 0.0 } else {
    let m = geo_buffer_ellipse_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn geo_buffer_ellipse_series_std(s : GeobufferellipseSeries) -> Double { geo_buffer_ellipse_sqrt(geo_buffer_ellipse_series_var(s)) }

pub fn geo_buffer_ellipse_series_median(s : GeobufferellipseSeries) -> Double {
  let n = geo_buffer_ellipse_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = geo_buffer_ellipse_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn geo_buffer_ellipse_series_scale(s : GeobufferellipseSeries, f : Double) -> GeobufferellipseSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = geo_buffer_ellipse_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn geo_buffer_ellipse_series_add(a : GeobufferellipseSeries, b : GeobufferellipseSeries) -> GeobufferellipseSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = geo_buffer_ellipse_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn geo_buffer_ellipse_series_sub(a : GeobufferellipseSeries, b : GeobufferellipseSeries) -> GeobufferellipseSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = geo_buffer_ellipse_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn geo_buffer_ellipse_series_normalize(s : GeobufferellipseSeries) -> GeobufferellipseSeries {
  let mn = geo_buffer_ellipse_series_min(s)
  let mx = geo_buffer_ellipse_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = geo_buffer_ellipse_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn geo_buffer_ellipse_series_cumsum(s : GeobufferellipseSeries) -> GeobufferellipseSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = geo_buffer_ellipse_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn geo_buffer_ellipse_series_to_string(s : GeobufferellipseSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + geo_buffer_ellipse_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GeobufferellipseMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn geo_buffer_ellipse_make_matrix(rows : Int, cols : Int, val : Double) -> GeobufferellipseMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn geo_buffer_ellipse_matrix_identity(n : Int) -> GeobufferellipseMatrix {
  let m = geo_buffer_ellipse_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn geo_buffer_ellipse_matrix_get(m : GeobufferellipseMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn geo_buffer_ellipse_matrix_transpose(m : GeobufferellipseMatrix) -> GeobufferellipseMatrix {
  let result = geo_buffer_ellipse_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn geo_buffer_ellipse_matrix_add(a : GeobufferellipseMatrix, b : GeobufferellipseMatrix) -> GeobufferellipseMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = geo_buffer_ellipse_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn geo_buffer_ellipse_matrix_scale(m : GeobufferellipseMatrix, s : Double) -> GeobufferellipseMatrix {
  let result = geo_buffer_ellipse_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn geo_buffer_ellipse_matrix_multiply(a : GeobufferellipseMatrix, b : GeobufferellipseMatrix) -> GeobufferellipseMatrix {
  if a.cols != b.rows { return geo_buffer_ellipse_make_matrix(a.rows, b.cols, 0.0) }
  let result = geo_buffer_ellipse_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn geo_buffer_ellipse_matrix_trace(m : GeobufferellipseMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn geo_buffer_ellipse_matrix_det(m : GeobufferellipseMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn geo_buffer_ellipse_matrix_norm(m : GeobufferellipseMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  geo_buffer_ellipse_sqrt(sum)
}

pub fn geo_buffer_ellipse_matrix_to_string(m : GeobufferellipseMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + geo_buffer_ellipse_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct GeobufferellipseVector {
  comps : Array[Double]
  dim : Int
}

pub fn geo_buffer_ellipse_make_vector(comps : Array[Double]) -> GeobufferellipseVector {
  { comps, dim: comps.length() }
}

pub fn geo_buffer_ellipse_vector_zero(dim : Int) -> GeobufferellipseVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn geo_buffer_ellipse_vector_add(a : GeobufferellipseVector, b : GeobufferellipseVector) -> GeobufferellipseVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = geo_buffer_ellipse_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn geo_buffer_ellipse_vector_sub(a : GeobufferellipseVector, b : GeobufferellipseVector) -> GeobufferellipseVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = geo_buffer_ellipse_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn geo_buffer_ellipse_vector_scale(v : GeobufferellipseVector, s : Double) -> GeobufferellipseVector {
  let mut result = []
  for i in 0..<v.dim { result = geo_buffer_ellipse_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn geo_buffer_ellipse_vector_dot(a : GeobufferellipseVector, b : GeobufferellipseVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn geo_buffer_ellipse_vector_norm(v : GeobufferellipseVector) -> Double { geo_buffer_ellipse_sqrt(geo_buffer_ellipse_vector_dot(v, v)) }

pub fn geo_buffer_ellipse_vector_normalize(v : GeobufferellipseVector) -> GeobufferellipseVector {
  let n = geo_buffer_ellipse_vector_norm(v)
  if n < 0.0000001 { v } else { geo_buffer_ellipse_vector_scale(v, 1.0 / n) }
}

pub fn geo_buffer_ellipse_vector_dist(a : GeobufferellipseVector, b : GeobufferellipseVector) -> Double {
  geo_buffer_ellipse_vector_norm(geo_buffer_ellipse_vector_sub(a, b))
}

pub fn geo_buffer_ellipse_vector_to_string(v : GeobufferellipseVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + geo_buffer_ellipse_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn geo_buffer_ellipse_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn geo_buffer_ellipse_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = geo_buffer_ellipse_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn geo_buffer_ellipse_std(data : Array[Double]) -> Double { geo_buffer_ellipse_sqrt(geo_buffer_ellipse_var(data)) }

pub fn geo_buffer_ellipse_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = geo_buffer_ellipse_mean(a); let mb = geo_buffer_ellipse_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn geo_buffer_ellipse_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = geo_buffer_ellipse_std(a); let sb = geo_buffer_ellipse_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { geo_buffer_ellipse_cov(a, b) / (sa * sb) }
}

pub fn geo_buffer_ellipse_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = geo_buffer_ellipse_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn geo_buffer_ellipse_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn geo_buffer_ellipse_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn geo_buffer_ellipse_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  geo_buffer_ellipse_sqrt(geo_buffer_ellipse_mse(pred, labels))
}

pub fn geo_buffer_ellipse_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + geo_buffer_ellipse_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn geo_buffer_ellipse_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = geo_buffer_ellipse_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn geo_buffer_ellipse_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn geo_buffer_ellipse_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn geo_buffer_ellipse_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = geo_buffer_ellipse_precision(pred, labels, pos); let r = geo_buffer_ellipse_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn geo_buffer_ellipse_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn geo_buffer_ellipse_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = geo_buffer_ellipse_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn geo_buffer_ellipse_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn geo_buffer_ellipse_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn geo_buffer_ellipse_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = geo_buffer_ellipse_gcd(a, b)
    (a / g) * b
  }
}

pub fn geo_buffer_ellipse_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn geo_buffer_ellipse_fibonacci(n : Int) -> Int {
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

pub fn geo_buffer_ellipse_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = geo_buffer_ellipse_min(data); let mx = geo_buffer_ellipse_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn geo_buffer_ellipse_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = geo_buffer_ellipse_mean(data); let sd = geo_buffer_ellipse_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn geo_buffer_ellipse_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn geo_buffer_ellipse_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn geo_buffer_ellipse_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn geo_buffer_ellipse_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn geo_buffer_ellipse_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn geo_buffer_ellipse_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn geo_buffer_ellipse_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn geo_buffer_ellipse_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn geo_buffer_ellipse_dbl(x : Double) -> String {
  let i = if x >= 0.0 { geo_buffer_ellipse_int(x) } else { -geo_buffer_ellipse_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { geo_buffer_ellipse_int(f * 1000000.0) } else { geo_buffer_ellipse_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn geo_buffer_ellipse_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn geo_buffer_ellipse_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct GeobufferellipseFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_ellipse_frame_make(size : Int) -> GeobufferellipseFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_ellipse_frame_len(s : GeobufferellipseFrame) -> Int { s.size }

pub fn geo_buffer_ellipse_frame_get(s : GeobufferellipseFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_ellipse_frame_set(s : GeobufferellipseFrame, i : Int, v : Double) -> GeobufferellipseFrame {
  let result = geo_buffer_ellipse_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_buffer_ellipse_frame_sum(s : GeobufferellipseFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_buffer_ellipse_frame_mean(s : GeobufferellipseFrame) -> Double {
  if s.size == 0 { 0.0 } else { geo_buffer_ellipse_frame_sum(s) / s.size.to_double() }
}

pub fn geo_buffer_ellipse_frame_scale(s : GeobufferellipseFrame, f : Double) -> GeobufferellipseFrame {
  let result = geo_buffer_ellipse_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_buffer_ellipse_frame_add(a : GeobufferellipseFrame, b : GeobufferellipseFrame) -> GeobufferellipseFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_buffer_ellipse_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_buffer_ellipse_frame_copy(s : GeobufferellipseFrame) -> GeobufferellipseFrame {
  let result = geo_buffer_ellipse_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_buffer_ellipse_frame_fill(s : GeobufferellipseFrame, v : Double) -> GeobufferellipseFrame {
  let result = geo_buffer_ellipse_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_buffer_ellipse_frame_min(s : GeobufferellipseFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_buffer_ellipse_frame_max(s : GeobufferellipseFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_buffer_ellipse_frame_to_string(s : GeobufferellipseFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobufferellipseTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_ellipse_table_make(size : Int) -> GeobufferellipseTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_ellipse_table_len(s : GeobufferellipseTable) -> Int { s.size }

pub fn geo_buffer_ellipse_table_get(s : GeobufferellipseTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_ellipse_table_set(s : GeobufferellipseTable, i : Int, v : Double) -> GeobufferellipseTable {
  let result = geo_buffer_ellipse_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_buffer_ellipse_table_sum(s : GeobufferellipseTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_buffer_ellipse_table_mean(s : GeobufferellipseTable) -> Double {
  if s.size == 0 { 0.0 } else { geo_buffer_ellipse_table_sum(s) / s.size.to_double() }
}

pub fn geo_buffer_ellipse_table_scale(s : GeobufferellipseTable, f : Double) -> GeobufferellipseTable {
  let result = geo_buffer_ellipse_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_buffer_ellipse_table_add(a : GeobufferellipseTable, b : GeobufferellipseTable) -> GeobufferellipseTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_buffer_ellipse_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_buffer_ellipse_table_copy(s : GeobufferellipseTable) -> GeobufferellipseTable {
  let result = geo_buffer_ellipse_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_buffer_ellipse_table_fill(s : GeobufferellipseTable, v : Double) -> GeobufferellipseTable {
  let result = geo_buffer_ellipse_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_buffer_ellipse_table_min(s : GeobufferellipseTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_buffer_ellipse_table_max(s : GeobufferellipseTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_buffer_ellipse_table_to_string(s : GeobufferellipseTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobufferellipseGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_ellipse_graphn_make(size : Int) -> GeobufferellipseGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_ellipse_graphn_len(s : GeobufferellipseGraphN) -> Int { s.size }

pub fn geo_buffer_ellipse_graphn_get(s : GeobufferellipseGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_ellipse_graphn_set(s : GeobufferellipseGraphN, i : Int, v : Double) -> GeobufferellipseGraphN {
  let result = geo_buffer_ellipse_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_buffer_ellipse_graphn_sum(s : GeobufferellipseGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_buffer_ellipse_graphn_mean(s : GeobufferellipseGraphN) -> Double {
  if s.size == 0 { 0.0 } else { geo_buffer_ellipse_graphn_sum(s) / s.size.to_double() }
}

pub fn geo_buffer_ellipse_graphn_scale(s : GeobufferellipseGraphN, f : Double) -> GeobufferellipseGraphN {
  let result = geo_buffer_ellipse_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_buffer_ellipse_graphn_add(a : GeobufferellipseGraphN, b : GeobufferellipseGraphN) -> GeobufferellipseGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_buffer_ellipse_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_buffer_ellipse_graphn_copy(s : GeobufferellipseGraphN) -> GeobufferellipseGraphN {
  let result = geo_buffer_ellipse_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_buffer_ellipse_graphn_fill(s : GeobufferellipseGraphN, v : Double) -> GeobufferellipseGraphN {
  let result = geo_buffer_ellipse_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_buffer_ellipse_graphn_min(s : GeobufferellipseGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_buffer_ellipse_graphn_max(s : GeobufferellipseGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_buffer_ellipse_graphn_to_string(s : GeobufferellipseGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobufferellipseNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_ellipse_node_make(size : Int) -> GeobufferellipseNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_ellipse_node_len(s : GeobufferellipseNode) -> Int { s.size }

pub fn geo_buffer_ellipse_node_get(s : GeobufferellipseNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_ellipse_node_set(s : GeobufferellipseNode, i : Int, v : Double) -> GeobufferellipseNode {
  let result = geo_buffer_ellipse_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_buffer_ellipse_node_sum(s : GeobufferellipseNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_buffer_ellipse_node_mean(s : GeobufferellipseNode) -> Double {
  if s.size == 0 { 0.0 } else { geo_buffer_ellipse_node_sum(s) / s.size.to_double() }
}

pub fn geo_buffer_ellipse_node_scale(s : GeobufferellipseNode, f : Double) -> GeobufferellipseNode {
  let result = geo_buffer_ellipse_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_buffer_ellipse_node_add(a : GeobufferellipseNode, b : GeobufferellipseNode) -> GeobufferellipseNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_buffer_ellipse_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_buffer_ellipse_node_copy(s : GeobufferellipseNode) -> GeobufferellipseNode {
  let result = geo_buffer_ellipse_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_buffer_ellipse_node_fill(s : GeobufferellipseNode, v : Double) -> GeobufferellipseNode {
  let result = geo_buffer_ellipse_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_buffer_ellipse_node_min(s : GeobufferellipseNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_buffer_ellipse_node_max(s : GeobufferellipseNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_buffer_ellipse_node_to_string(s : GeobufferellipseNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobufferellipseEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_ellipse_edge_make(size : Int) -> GeobufferellipseEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_ellipse_edge_len(s : GeobufferellipseEdge) -> Int { s.size }

pub fn geo_buffer_ellipse_edge_get(s : GeobufferellipseEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_ellipse_edge_set(s : GeobufferellipseEdge, i : Int, v : Double) -> GeobufferellipseEdge {
  let result = geo_buffer_ellipse_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_buffer_ellipse_edge_sum(s : GeobufferellipseEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_buffer_ellipse_edge_mean(s : GeobufferellipseEdge) -> Double {
  if s.size == 0 { 0.0 } else { geo_buffer_ellipse_edge_sum(s) / s.size.to_double() }
}

pub fn geo_buffer_ellipse_edge_scale(s : GeobufferellipseEdge, f : Double) -> GeobufferellipseEdge {
  let result = geo_buffer_ellipse_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_buffer_ellipse_edge_add(a : GeobufferellipseEdge, b : GeobufferellipseEdge) -> GeobufferellipseEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_buffer_ellipse_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_buffer_ellipse_edge_copy(s : GeobufferellipseEdge) -> GeobufferellipseEdge {
  let result = geo_buffer_ellipse_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_buffer_ellipse_edge_fill(s : GeobufferellipseEdge, v : Double) -> GeobufferellipseEdge {
  let result = geo_buffer_ellipse_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_buffer_ellipse_edge_min(s : GeobufferellipseEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_buffer_ellipse_edge_max(s : GeobufferellipseEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_buffer_ellipse_edge_to_string(s : GeobufferellipseEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobufferellipsePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_ellipse_path_make(size : Int) -> GeobufferellipsePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_ellipse_path_len(s : GeobufferellipsePath) -> Int { s.size }

pub fn geo_buffer_ellipse_path_get(s : GeobufferellipsePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_ellipse_path_set(s : GeobufferellipsePath, i : Int, v : Double) -> GeobufferellipsePath {
  let result = geo_buffer_ellipse_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_buffer_ellipse_path_sum(s : GeobufferellipsePath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_buffer_ellipse_path_mean(s : GeobufferellipsePath) -> Double {
  if s.size == 0 { 0.0 } else { geo_buffer_ellipse_path_sum(s) / s.size.to_double() }
}

pub fn geo_buffer_ellipse_path_scale(s : GeobufferellipsePath, f : Double) -> GeobufferellipsePath {
  let result = geo_buffer_ellipse_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_buffer_ellipse_path_add(a : GeobufferellipsePath, b : GeobufferellipsePath) -> GeobufferellipsePath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_buffer_ellipse_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_buffer_ellipse_path_copy(s : GeobufferellipsePath) -> GeobufferellipsePath {
  let result = geo_buffer_ellipse_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_buffer_ellipse_path_fill(s : GeobufferellipsePath, v : Double) -> GeobufferellipsePath {
  let result = geo_buffer_ellipse_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_buffer_ellipse_path_min(s : GeobufferellipsePath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_buffer_ellipse_path_max(s : GeobufferellipsePath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_buffer_ellipse_path_to_string(s : GeobufferellipsePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobufferellipseCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_ellipse_cluster_make(size : Int) -> GeobufferellipseCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_ellipse_cluster_len(s : GeobufferellipseCluster) -> Int { s.size }

pub fn geo_buffer_ellipse_cluster_get(s : GeobufferellipseCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_ellipse_cluster_set(s : GeobufferellipseCluster, i : Int, v : Double) -> GeobufferellipseCluster {
  let result = geo_buffer_ellipse_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_buffer_ellipse_cluster_sum(s : GeobufferellipseCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_buffer_ellipse_cluster_mean(s : GeobufferellipseCluster) -> Double {
  if s.size == 0 { 0.0 } else { geo_buffer_ellipse_cluster_sum(s) / s.size.to_double() }
}

pub fn geo_buffer_ellipse_cluster_scale(s : GeobufferellipseCluster, f : Double) -> GeobufferellipseCluster {
  let result = geo_buffer_ellipse_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_buffer_ellipse_cluster_add(a : GeobufferellipseCluster, b : GeobufferellipseCluster) -> GeobufferellipseCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_buffer_ellipse_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_buffer_ellipse_cluster_copy(s : GeobufferellipseCluster) -> GeobufferellipseCluster {
  let result = geo_buffer_ellipse_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_buffer_ellipse_cluster_fill(s : GeobufferellipseCluster, v : Double) -> GeobufferellipseCluster {
  let result = geo_buffer_ellipse_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_buffer_ellipse_cluster_min(s : GeobufferellipseCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_buffer_ellipse_cluster_max(s : GeobufferellipseCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_buffer_ellipse_cluster_to_string(s : GeobufferellipseCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobufferellipseModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_ellipse_model_make(size : Int) -> GeobufferellipseModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_ellipse_model_len(s : GeobufferellipseModel) -> Int { s.size }

pub fn geo_buffer_ellipse_model_get(s : GeobufferellipseModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_ellipse_model_set(s : GeobufferellipseModel, i : Int, v : Double) -> GeobufferellipseModel {
  let result = geo_buffer_ellipse_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_buffer_ellipse_model_sum(s : GeobufferellipseModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_buffer_ellipse_model_mean(s : GeobufferellipseModel) -> Double {
  if s.size == 0 { 0.0 } else { geo_buffer_ellipse_model_sum(s) / s.size.to_double() }
}

pub fn geo_buffer_ellipse_model_scale(s : GeobufferellipseModel, f : Double) -> GeobufferellipseModel {
  let result = geo_buffer_ellipse_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_buffer_ellipse_model_add(a : GeobufferellipseModel, b : GeobufferellipseModel) -> GeobufferellipseModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_buffer_ellipse_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_buffer_ellipse_model_copy(s : GeobufferellipseModel) -> GeobufferellipseModel {
  let result = geo_buffer_ellipse_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_buffer_ellipse_model_fill(s : GeobufferellipseModel, v : Double) -> GeobufferellipseModel {
  let result = geo_buffer_ellipse_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_buffer_ellipse_model_min(s : GeobufferellipseModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_buffer_ellipse_model_max(s : GeobufferellipseModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_buffer_ellipse_model_to_string(s : GeobufferellipseModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobufferellipseLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_ellipse_layer_make(size : Int) -> GeobufferellipseLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_ellipse_layer_len(s : GeobufferellipseLayer) -> Int { s.size }

pub fn geo_buffer_ellipse_layer_get(s : GeobufferellipseLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_ellipse_layer_set(s : GeobufferellipseLayer, i : Int, v : Double) -> GeobufferellipseLayer {
  let result = geo_buffer_ellipse_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_buffer_ellipse_layer_sum(s : GeobufferellipseLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_buffer_ellipse_layer_mean(s : GeobufferellipseLayer) -> Double {
  if s.size == 0 { 0.0 } else { geo_buffer_ellipse_layer_sum(s) / s.size.to_double() }
}

pub fn geo_buffer_ellipse_layer_scale(s : GeobufferellipseLayer, f : Double) -> GeobufferellipseLayer {
  let result = geo_buffer_ellipse_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_buffer_ellipse_layer_add(a : GeobufferellipseLayer, b : GeobufferellipseLayer) -> GeobufferellipseLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_buffer_ellipse_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_buffer_ellipse_layer_copy(s : GeobufferellipseLayer) -> GeobufferellipseLayer {
  let result = geo_buffer_ellipse_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_buffer_ellipse_layer_fill(s : GeobufferellipseLayer, v : Double) -> GeobufferellipseLayer {
  let result = geo_buffer_ellipse_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_buffer_ellipse_layer_min(s : GeobufferellipseLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_buffer_ellipse_layer_max(s : GeobufferellipseLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_buffer_ellipse_layer_to_string(s : GeobufferellipseLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobufferellipseBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_ellipse_buffer_make(size : Int) -> GeobufferellipseBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_ellipse_buffer_len(s : GeobufferellipseBuffer) -> Int { s.size }

pub fn geo_buffer_ellipse_buffer_get(s : GeobufferellipseBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_ellipse_buffer_set(s : GeobufferellipseBuffer, i : Int, v : Double) -> GeobufferellipseBuffer {
  let result = geo_buffer_ellipse_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_buffer_ellipse_buffer_sum(s : GeobufferellipseBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_buffer_ellipse_buffer_mean(s : GeobufferellipseBuffer) -> Double {
  if s.size == 0 { 0.0 } else { geo_buffer_ellipse_buffer_sum(s) / s.size.to_double() }
}

pub fn geo_buffer_ellipse_buffer_scale(s : GeobufferellipseBuffer, f : Double) -> GeobufferellipseBuffer {
  let result = geo_buffer_ellipse_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_buffer_ellipse_buffer_add(a : GeobufferellipseBuffer, b : GeobufferellipseBuffer) -> GeobufferellipseBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_buffer_ellipse_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_buffer_ellipse_buffer_copy(s : GeobufferellipseBuffer) -> GeobufferellipseBuffer {
  let result = geo_buffer_ellipse_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_buffer_ellipse_buffer_fill(s : GeobufferellipseBuffer, v : Double) -> GeobufferellipseBuffer {
  let result = geo_buffer_ellipse_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_buffer_ellipse_buffer_min(s : GeobufferellipseBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_buffer_ellipse_buffer_max(s : GeobufferellipseBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_buffer_ellipse_buffer_to_string(s : GeobufferellipseBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobufferellipseCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_ellipse_cursor_make(size : Int) -> GeobufferellipseCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_ellipse_cursor_len(s : GeobufferellipseCursor) -> Int { s.size }

pub fn geo_buffer_ellipse_cursor_get(s : GeobufferellipseCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_ellipse_cursor_set(s : GeobufferellipseCursor, i : Int, v : Double) -> GeobufferellipseCursor {
  let result = geo_buffer_ellipse_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_buffer_ellipse_cursor_sum(s : GeobufferellipseCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_buffer_ellipse_cursor_mean(s : GeobufferellipseCursor) -> Double {
  if s.size == 0 { 0.0 } else { geo_buffer_ellipse_cursor_sum(s) / s.size.to_double() }
}

pub fn geo_buffer_ellipse_cursor_scale(s : GeobufferellipseCursor, f : Double) -> GeobufferellipseCursor {
  let result = geo_buffer_ellipse_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_buffer_ellipse_cursor_add(a : GeobufferellipseCursor, b : GeobufferellipseCursor) -> GeobufferellipseCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_buffer_ellipse_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_buffer_ellipse_cursor_copy(s : GeobufferellipseCursor) -> GeobufferellipseCursor {
  let result = geo_buffer_ellipse_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_buffer_ellipse_cursor_fill(s : GeobufferellipseCursor, v : Double) -> GeobufferellipseCursor {
  let result = geo_buffer_ellipse_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_buffer_ellipse_cursor_min(s : GeobufferellipseCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_buffer_ellipse_cursor_max(s : GeobufferellipseCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_buffer_ellipse_cursor_to_string(s : GeobufferellipseCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobufferellipseView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_ellipse_view_make(size : Int) -> GeobufferellipseView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_ellipse_view_len(s : GeobufferellipseView) -> Int { s.size }

pub fn geo_buffer_ellipse_view_get(s : GeobufferellipseView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_ellipse_view_set(s : GeobufferellipseView, i : Int, v : Double) -> GeobufferellipseView {
  let result = geo_buffer_ellipse_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_buffer_ellipse_view_sum(s : GeobufferellipseView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_buffer_ellipse_view_mean(s : GeobufferellipseView) -> Double {
  if s.size == 0 { 0.0 } else { geo_buffer_ellipse_view_sum(s) / s.size.to_double() }
}

pub fn geo_buffer_ellipse_view_scale(s : GeobufferellipseView, f : Double) -> GeobufferellipseView {
  let result = geo_buffer_ellipse_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_buffer_ellipse_view_add(a : GeobufferellipseView, b : GeobufferellipseView) -> GeobufferellipseView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_buffer_ellipse_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_buffer_ellipse_view_copy(s : GeobufferellipseView) -> GeobufferellipseView {
  let result = geo_buffer_ellipse_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_buffer_ellipse_view_fill(s : GeobufferellipseView, v : Double) -> GeobufferellipseView {
  let result = geo_buffer_ellipse_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_buffer_ellipse_view_min(s : GeobufferellipseView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_buffer_ellipse_view_max(s : GeobufferellipseView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_buffer_ellipse_view_to_string(s : GeobufferellipseView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobufferellipseRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_ellipse_range_make(size : Int) -> GeobufferellipseRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_ellipse_range_len(s : GeobufferellipseRange) -> Int { s.size }

pub fn geo_buffer_ellipse_range_get(s : GeobufferellipseRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_ellipse_range_set(s : GeobufferellipseRange, i : Int, v : Double) -> GeobufferellipseRange {
  let result = geo_buffer_ellipse_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_buffer_ellipse_range_sum(s : GeobufferellipseRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_buffer_ellipse_range_mean(s : GeobufferellipseRange) -> Double {
  if s.size == 0 { 0.0 } else { geo_buffer_ellipse_range_sum(s) / s.size.to_double() }
}

pub fn geo_buffer_ellipse_range_scale(s : GeobufferellipseRange, f : Double) -> GeobufferellipseRange {
  let result = geo_buffer_ellipse_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_buffer_ellipse_range_add(a : GeobufferellipseRange, b : GeobufferellipseRange) -> GeobufferellipseRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_buffer_ellipse_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_buffer_ellipse_range_copy(s : GeobufferellipseRange) -> GeobufferellipseRange {
  let result = geo_buffer_ellipse_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_buffer_ellipse_range_fill(s : GeobufferellipseRange, v : Double) -> GeobufferellipseRange {
  let result = geo_buffer_ellipse_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_buffer_ellipse_range_min(s : GeobufferellipseRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_buffer_ellipse_range_max(s : GeobufferellipseRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_buffer_ellipse_range_to_string(s : GeobufferellipseRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobufferellipseSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_ellipse_slice_make(size : Int) -> GeobufferellipseSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_ellipse_slice_len(s : GeobufferellipseSlice) -> Int { s.size }

pub fn geo_buffer_ellipse_slice_get(s : GeobufferellipseSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_ellipse_slice_set(s : GeobufferellipseSlice, i : Int, v : Double) -> GeobufferellipseSlice {
  let result = geo_buffer_ellipse_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_buffer_ellipse_slice_sum(s : GeobufferellipseSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_buffer_ellipse_slice_mean(s : GeobufferellipseSlice) -> Double {
  if s.size == 0 { 0.0 } else { geo_buffer_ellipse_slice_sum(s) / s.size.to_double() }
}

pub fn geo_buffer_ellipse_slice_scale(s : GeobufferellipseSlice, f : Double) -> GeobufferellipseSlice {
  let result = geo_buffer_ellipse_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_buffer_ellipse_slice_add(a : GeobufferellipseSlice, b : GeobufferellipseSlice) -> GeobufferellipseSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_buffer_ellipse_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_buffer_ellipse_slice_copy(s : GeobufferellipseSlice) -> GeobufferellipseSlice {
  let result = geo_buffer_ellipse_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_buffer_ellipse_slice_fill(s : GeobufferellipseSlice, v : Double) -> GeobufferellipseSlice {
  let result = geo_buffer_ellipse_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_buffer_ellipse_slice_min(s : GeobufferellipseSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_buffer_ellipse_slice_max(s : GeobufferellipseSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_buffer_ellipse_slice_to_string(s : GeobufferellipseSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn geo_buffer_ellipse_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_buffer_ellipse_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_buffer_ellipse_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_buffer_ellipse_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_buffer_ellipse_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_buffer_ellipse_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_buffer_ellipse_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_buffer_ellipse_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_buffer_ellipse_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_buffer_ellipse_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_buffer_ellipse_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_buffer_ellipse_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_buffer_ellipse_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_buffer_ellipse_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_buffer_ellipse_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_buffer_ellipse_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_buffer_ellipse_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_buffer_ellipse_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_buffer_ellipse_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_buffer_ellipse_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_buffer_ellipse_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_buffer_ellipse_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_buffer_ellipse_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_buffer_ellipse_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_buffer_ellipse_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

