///===
/// extcore/geo_dist_projected

pub(all) struct GeodistprojectedPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn geo_dist_projected_make_point(x : Double, y : Double) -> GeodistprojectedPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn geo_dist_projected_make_point3(x : Double, y : Double, z : Double) -> GeodistprojectedPoint {
  { x, y, z, label: 0 }
}

pub fn geo_dist_projected_point_x(pt : GeodistprojectedPoint) -> Double { pt.x }

pub fn geo_dist_projected_point_y(pt : GeodistprojectedPoint) -> Double { pt.y }

pub fn geo_dist_projected_point_z(pt : GeodistprojectedPoint) -> Double { pt.z }

pub fn geo_dist_projected_point_label(pt : GeodistprojectedPoint) -> Int { pt.label }

pub fn geo_dist_projected_point_dist(a : GeodistprojectedPoint, b : GeodistprojectedPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  geo_dist_projected_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn geo_dist_projected_point_add(a : GeodistprojectedPoint, b : GeodistprojectedPoint) -> GeodistprojectedPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn geo_dist_projected_point_sub(a : GeodistprojectedPoint, b : GeodistprojectedPoint) -> GeodistprojectedPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn geo_dist_projected_point_scale(pt : GeodistprojectedPoint, s : Double) -> GeodistprojectedPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn geo_dist_projected_point_dot(a : GeodistprojectedPoint, b : GeodistprojectedPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn geo_dist_projected_point_cross(a : GeodistprojectedPoint, b : GeodistprojectedPoint) -> GeodistprojectedPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn geo_dist_projected_point_norm(pt : GeodistprojectedPoint) -> Double {
  geo_dist_projected_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn geo_dist_projected_point_normalize(pt : GeodistprojectedPoint) -> GeodistprojectedPoint {
  let n = geo_dist_projected_point_norm(pt)
  if n < 0.0000001 { pt } else { geo_dist_projected_point_scale(pt, 1.0 / n) }
}

pub fn geo_dist_projected_point_negate(pt : GeodistprojectedPoint) -> GeodistprojectedPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn geo_dist_projected_point_mid(a : GeodistprojectedPoint, b : GeodistprojectedPoint) -> GeodistprojectedPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn geo_dist_projected_point_lerp(a : GeodistprojectedPoint, b : GeodistprojectedPoint, t : Double) -> GeodistprojectedPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn geo_dist_projected_point_to_string(pt : GeodistprojectedPoint) -> String {
  "(" + geo_dist_projected_dbl(pt.x) + ", " + geo_dist_projected_dbl(pt.y) + ", " + geo_dist_projected_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct GeodistprojectedSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn geo_dist_projected_make_series(vals : Array[Double], name : String) -> GeodistprojectedSeries {
  { vals, name, meta: 0 }
}

pub fn geo_dist_projected_series_len(s : GeodistprojectedSeries) -> Int { s.vals.length() }

pub fn geo_dist_projected_series_sum(s : GeodistprojectedSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn geo_dist_projected_series_mean(s : GeodistprojectedSeries) -> Double {
  let n = geo_dist_projected_series_len(s)
  if n == 0 { 0.0 } else { geo_dist_projected_series_sum(s) / n.to_double() }
}

pub fn geo_dist_projected_series_min(s : GeodistprojectedSeries) -> Double {
  let n = geo_dist_projected_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn geo_dist_projected_series_max(s : GeodistprojectedSeries) -> Double {
  let n = geo_dist_projected_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn geo_dist_projected_series_range(s : GeodistprojectedSeries) -> Double {
  geo_dist_projected_series_max(s) - geo_dist_projected_series_min(s)
}

pub fn geo_dist_projected_series_var(s : GeodistprojectedSeries) -> Double {
  let n = geo_dist_projected_series_len(s)
  if n == 0 { 0.0 } else {
    let m = geo_dist_projected_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn geo_dist_projected_series_std(s : GeodistprojectedSeries) -> Double { geo_dist_projected_sqrt(geo_dist_projected_series_var(s)) }

pub fn geo_dist_projected_series_median(s : GeodistprojectedSeries) -> Double {
  let n = geo_dist_projected_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = geo_dist_projected_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn geo_dist_projected_series_scale(s : GeodistprojectedSeries, f : Double) -> GeodistprojectedSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = geo_dist_projected_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn geo_dist_projected_series_add(a : GeodistprojectedSeries, b : GeodistprojectedSeries) -> GeodistprojectedSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = geo_dist_projected_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn geo_dist_projected_series_sub(a : GeodistprojectedSeries, b : GeodistprojectedSeries) -> GeodistprojectedSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = geo_dist_projected_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn geo_dist_projected_series_normalize(s : GeodistprojectedSeries) -> GeodistprojectedSeries {
  let mn = geo_dist_projected_series_min(s)
  let mx = geo_dist_projected_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = geo_dist_projected_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn geo_dist_projected_series_cumsum(s : GeodistprojectedSeries) -> GeodistprojectedSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = geo_dist_projected_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn geo_dist_projected_series_to_string(s : GeodistprojectedSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + geo_dist_projected_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GeodistprojectedMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn geo_dist_projected_make_matrix(rows : Int, cols : Int, val : Double) -> GeodistprojectedMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn geo_dist_projected_matrix_identity(n : Int) -> GeodistprojectedMatrix {
  let m = geo_dist_projected_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn geo_dist_projected_matrix_get(m : GeodistprojectedMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn geo_dist_projected_matrix_transpose(m : GeodistprojectedMatrix) -> GeodistprojectedMatrix {
  let result = geo_dist_projected_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn geo_dist_projected_matrix_add(a : GeodistprojectedMatrix, b : GeodistprojectedMatrix) -> GeodistprojectedMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = geo_dist_projected_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn geo_dist_projected_matrix_scale(m : GeodistprojectedMatrix, s : Double) -> GeodistprojectedMatrix {
  let result = geo_dist_projected_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn geo_dist_projected_matrix_multiply(a : GeodistprojectedMatrix, b : GeodistprojectedMatrix) -> GeodistprojectedMatrix {
  if a.cols != b.rows { return geo_dist_projected_make_matrix(a.rows, b.cols, 0.0) }
  let result = geo_dist_projected_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn geo_dist_projected_matrix_trace(m : GeodistprojectedMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn geo_dist_projected_matrix_det(m : GeodistprojectedMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn geo_dist_projected_matrix_norm(m : GeodistprojectedMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  geo_dist_projected_sqrt(sum)
}

pub fn geo_dist_projected_matrix_to_string(m : GeodistprojectedMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + geo_dist_projected_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct GeodistprojectedVector {
  comps : Array[Double]
  dim : Int
}

pub fn geo_dist_projected_make_vector(comps : Array[Double]) -> GeodistprojectedVector {
  { comps, dim: comps.length() }
}

pub fn geo_dist_projected_vector_zero(dim : Int) -> GeodistprojectedVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn geo_dist_projected_vector_add(a : GeodistprojectedVector, b : GeodistprojectedVector) -> GeodistprojectedVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = geo_dist_projected_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn geo_dist_projected_vector_sub(a : GeodistprojectedVector, b : GeodistprojectedVector) -> GeodistprojectedVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = geo_dist_projected_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn geo_dist_projected_vector_scale(v : GeodistprojectedVector, s : Double) -> GeodistprojectedVector {
  let mut result = []
  for i in 0..<v.dim { result = geo_dist_projected_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn geo_dist_projected_vector_dot(a : GeodistprojectedVector, b : GeodistprojectedVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn geo_dist_projected_vector_norm(v : GeodistprojectedVector) -> Double { geo_dist_projected_sqrt(geo_dist_projected_vector_dot(v, v)) }

pub fn geo_dist_projected_vector_normalize(v : GeodistprojectedVector) -> GeodistprojectedVector {
  let n = geo_dist_projected_vector_norm(v)
  if n < 0.0000001 { v } else { geo_dist_projected_vector_scale(v, 1.0 / n) }
}

pub fn geo_dist_projected_vector_dist(a : GeodistprojectedVector, b : GeodistprojectedVector) -> Double {
  geo_dist_projected_vector_norm(geo_dist_projected_vector_sub(a, b))
}

pub fn geo_dist_projected_vector_to_string(v : GeodistprojectedVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + geo_dist_projected_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn geo_dist_projected_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn geo_dist_projected_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = geo_dist_projected_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn geo_dist_projected_std(data : Array[Double]) -> Double { geo_dist_projected_sqrt(geo_dist_projected_var(data)) }

pub fn geo_dist_projected_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = geo_dist_projected_mean(a); let mb = geo_dist_projected_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn geo_dist_projected_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = geo_dist_projected_std(a); let sb = geo_dist_projected_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { geo_dist_projected_cov(a, b) / (sa * sb) }
}

pub fn geo_dist_projected_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = geo_dist_projected_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn geo_dist_projected_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn geo_dist_projected_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn geo_dist_projected_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  geo_dist_projected_sqrt(geo_dist_projected_mse(pred, labels))
}

pub fn geo_dist_projected_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + geo_dist_projected_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn geo_dist_projected_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = geo_dist_projected_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn geo_dist_projected_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn geo_dist_projected_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn geo_dist_projected_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = geo_dist_projected_precision(pred, labels, pos); let r = geo_dist_projected_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn geo_dist_projected_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn geo_dist_projected_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = geo_dist_projected_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn geo_dist_projected_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn geo_dist_projected_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn geo_dist_projected_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = geo_dist_projected_gcd(a, b)
    (a / g) * b
  }
}

pub fn geo_dist_projected_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn geo_dist_projected_fibonacci(n : Int) -> Int {
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

pub fn geo_dist_projected_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = geo_dist_projected_min(data); let mx = geo_dist_projected_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn geo_dist_projected_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = geo_dist_projected_mean(data); let sd = geo_dist_projected_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn geo_dist_projected_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn geo_dist_projected_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn geo_dist_projected_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn geo_dist_projected_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn geo_dist_projected_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn geo_dist_projected_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn geo_dist_projected_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn geo_dist_projected_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn geo_dist_projected_dbl(x : Double) -> String {
  let i = if x >= 0.0 { geo_dist_projected_int(x) } else { -geo_dist_projected_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { geo_dist_projected_int(f * 1000000.0) } else { geo_dist_projected_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn geo_dist_projected_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn geo_dist_projected_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct GeodistprojectedFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_projected_frame_make(size : Int) -> GeodistprojectedFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_projected_frame_len(s : GeodistprojectedFrame) -> Int { s.size }

pub fn geo_dist_projected_frame_get(s : GeodistprojectedFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_projected_frame_set(s : GeodistprojectedFrame, i : Int, v : Double) -> GeodistprojectedFrame {
  let result = geo_dist_projected_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_dist_projected_frame_sum(s : GeodistprojectedFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_dist_projected_frame_mean(s : GeodistprojectedFrame) -> Double {
  if s.size == 0 { 0.0 } else { geo_dist_projected_frame_sum(s) / s.size.to_double() }
}

pub fn geo_dist_projected_frame_scale(s : GeodistprojectedFrame, f : Double) -> GeodistprojectedFrame {
  let result = geo_dist_projected_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_dist_projected_frame_add(a : GeodistprojectedFrame, b : GeodistprojectedFrame) -> GeodistprojectedFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_dist_projected_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_dist_projected_frame_copy(s : GeodistprojectedFrame) -> GeodistprojectedFrame {
  let result = geo_dist_projected_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_dist_projected_frame_fill(s : GeodistprojectedFrame, v : Double) -> GeodistprojectedFrame {
  let result = geo_dist_projected_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_dist_projected_frame_min(s : GeodistprojectedFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_projected_frame_max(s : GeodistprojectedFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_projected_frame_to_string(s : GeodistprojectedFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistprojectedTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_projected_table_make(size : Int) -> GeodistprojectedTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_projected_table_len(s : GeodistprojectedTable) -> Int { s.size }

pub fn geo_dist_projected_table_get(s : GeodistprojectedTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_projected_table_set(s : GeodistprojectedTable, i : Int, v : Double) -> GeodistprojectedTable {
  let result = geo_dist_projected_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_dist_projected_table_sum(s : GeodistprojectedTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_dist_projected_table_mean(s : GeodistprojectedTable) -> Double {
  if s.size == 0 { 0.0 } else { geo_dist_projected_table_sum(s) / s.size.to_double() }
}

pub fn geo_dist_projected_table_scale(s : GeodistprojectedTable, f : Double) -> GeodistprojectedTable {
  let result = geo_dist_projected_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_dist_projected_table_add(a : GeodistprojectedTable, b : GeodistprojectedTable) -> GeodistprojectedTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_dist_projected_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_dist_projected_table_copy(s : GeodistprojectedTable) -> GeodistprojectedTable {
  let result = geo_dist_projected_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_dist_projected_table_fill(s : GeodistprojectedTable, v : Double) -> GeodistprojectedTable {
  let result = geo_dist_projected_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_dist_projected_table_min(s : GeodistprojectedTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_projected_table_max(s : GeodistprojectedTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_projected_table_to_string(s : GeodistprojectedTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistprojectedGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_projected_graphn_make(size : Int) -> GeodistprojectedGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_projected_graphn_len(s : GeodistprojectedGraphN) -> Int { s.size }

pub fn geo_dist_projected_graphn_get(s : GeodistprojectedGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_projected_graphn_set(s : GeodistprojectedGraphN, i : Int, v : Double) -> GeodistprojectedGraphN {
  let result = geo_dist_projected_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_dist_projected_graphn_sum(s : GeodistprojectedGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_dist_projected_graphn_mean(s : GeodistprojectedGraphN) -> Double {
  if s.size == 0 { 0.0 } else { geo_dist_projected_graphn_sum(s) / s.size.to_double() }
}

pub fn geo_dist_projected_graphn_scale(s : GeodistprojectedGraphN, f : Double) -> GeodistprojectedGraphN {
  let result = geo_dist_projected_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_dist_projected_graphn_add(a : GeodistprojectedGraphN, b : GeodistprojectedGraphN) -> GeodistprojectedGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_dist_projected_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_dist_projected_graphn_copy(s : GeodistprojectedGraphN) -> GeodistprojectedGraphN {
  let result = geo_dist_projected_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_dist_projected_graphn_fill(s : GeodistprojectedGraphN, v : Double) -> GeodistprojectedGraphN {
  let result = geo_dist_projected_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_dist_projected_graphn_min(s : GeodistprojectedGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_projected_graphn_max(s : GeodistprojectedGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_projected_graphn_to_string(s : GeodistprojectedGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistprojectedNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_projected_node_make(size : Int) -> GeodistprojectedNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_projected_node_len(s : GeodistprojectedNode) -> Int { s.size }

pub fn geo_dist_projected_node_get(s : GeodistprojectedNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_projected_node_set(s : GeodistprojectedNode, i : Int, v : Double) -> GeodistprojectedNode {
  let result = geo_dist_projected_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_dist_projected_node_sum(s : GeodistprojectedNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_dist_projected_node_mean(s : GeodistprojectedNode) -> Double {
  if s.size == 0 { 0.0 } else { geo_dist_projected_node_sum(s) / s.size.to_double() }
}

pub fn geo_dist_projected_node_scale(s : GeodistprojectedNode, f : Double) -> GeodistprojectedNode {
  let result = geo_dist_projected_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_dist_projected_node_add(a : GeodistprojectedNode, b : GeodistprojectedNode) -> GeodistprojectedNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_dist_projected_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_dist_projected_node_copy(s : GeodistprojectedNode) -> GeodistprojectedNode {
  let result = geo_dist_projected_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_dist_projected_node_fill(s : GeodistprojectedNode, v : Double) -> GeodistprojectedNode {
  let result = geo_dist_projected_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_dist_projected_node_min(s : GeodistprojectedNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_projected_node_max(s : GeodistprojectedNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_projected_node_to_string(s : GeodistprojectedNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistprojectedEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_projected_edge_make(size : Int) -> GeodistprojectedEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_projected_edge_len(s : GeodistprojectedEdge) -> Int { s.size }

pub fn geo_dist_projected_edge_get(s : GeodistprojectedEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_projected_edge_set(s : GeodistprojectedEdge, i : Int, v : Double) -> GeodistprojectedEdge {
  let result = geo_dist_projected_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_dist_projected_edge_sum(s : GeodistprojectedEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_dist_projected_edge_mean(s : GeodistprojectedEdge) -> Double {
  if s.size == 0 { 0.0 } else { geo_dist_projected_edge_sum(s) / s.size.to_double() }
}

pub fn geo_dist_projected_edge_scale(s : GeodistprojectedEdge, f : Double) -> GeodistprojectedEdge {
  let result = geo_dist_projected_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_dist_projected_edge_add(a : GeodistprojectedEdge, b : GeodistprojectedEdge) -> GeodistprojectedEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_dist_projected_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_dist_projected_edge_copy(s : GeodistprojectedEdge) -> GeodistprojectedEdge {
  let result = geo_dist_projected_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_dist_projected_edge_fill(s : GeodistprojectedEdge, v : Double) -> GeodistprojectedEdge {
  let result = geo_dist_projected_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_dist_projected_edge_min(s : GeodistprojectedEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_projected_edge_max(s : GeodistprojectedEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_projected_edge_to_string(s : GeodistprojectedEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistprojectedPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_projected_path_make(size : Int) -> GeodistprojectedPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_projected_path_len(s : GeodistprojectedPath) -> Int { s.size }

pub fn geo_dist_projected_path_get(s : GeodistprojectedPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_projected_path_set(s : GeodistprojectedPath, i : Int, v : Double) -> GeodistprojectedPath {
  let result = geo_dist_projected_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_dist_projected_path_sum(s : GeodistprojectedPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_dist_projected_path_mean(s : GeodistprojectedPath) -> Double {
  if s.size == 0 { 0.0 } else { geo_dist_projected_path_sum(s) / s.size.to_double() }
}

pub fn geo_dist_projected_path_scale(s : GeodistprojectedPath, f : Double) -> GeodistprojectedPath {
  let result = geo_dist_projected_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_dist_projected_path_add(a : GeodistprojectedPath, b : GeodistprojectedPath) -> GeodistprojectedPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_dist_projected_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_dist_projected_path_copy(s : GeodistprojectedPath) -> GeodistprojectedPath {
  let result = geo_dist_projected_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_dist_projected_path_fill(s : GeodistprojectedPath, v : Double) -> GeodistprojectedPath {
  let result = geo_dist_projected_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_dist_projected_path_min(s : GeodistprojectedPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_projected_path_max(s : GeodistprojectedPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_projected_path_to_string(s : GeodistprojectedPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistprojectedCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_projected_cluster_make(size : Int) -> GeodistprojectedCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_projected_cluster_len(s : GeodistprojectedCluster) -> Int { s.size }

pub fn geo_dist_projected_cluster_get(s : GeodistprojectedCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_projected_cluster_set(s : GeodistprojectedCluster, i : Int, v : Double) -> GeodistprojectedCluster {
  let result = geo_dist_projected_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_dist_projected_cluster_sum(s : GeodistprojectedCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_dist_projected_cluster_mean(s : GeodistprojectedCluster) -> Double {
  if s.size == 0 { 0.0 } else { geo_dist_projected_cluster_sum(s) / s.size.to_double() }
}

pub fn geo_dist_projected_cluster_scale(s : GeodistprojectedCluster, f : Double) -> GeodistprojectedCluster {
  let result = geo_dist_projected_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_dist_projected_cluster_add(a : GeodistprojectedCluster, b : GeodistprojectedCluster) -> GeodistprojectedCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_dist_projected_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_dist_projected_cluster_copy(s : GeodistprojectedCluster) -> GeodistprojectedCluster {
  let result = geo_dist_projected_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_dist_projected_cluster_fill(s : GeodistprojectedCluster, v : Double) -> GeodistprojectedCluster {
  let result = geo_dist_projected_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_dist_projected_cluster_min(s : GeodistprojectedCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_projected_cluster_max(s : GeodistprojectedCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_projected_cluster_to_string(s : GeodistprojectedCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistprojectedModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_projected_model_make(size : Int) -> GeodistprojectedModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_projected_model_len(s : GeodistprojectedModel) -> Int { s.size }

pub fn geo_dist_projected_model_get(s : GeodistprojectedModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_projected_model_set(s : GeodistprojectedModel, i : Int, v : Double) -> GeodistprojectedModel {
  let result = geo_dist_projected_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_dist_projected_model_sum(s : GeodistprojectedModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_dist_projected_model_mean(s : GeodistprojectedModel) -> Double {
  if s.size == 0 { 0.0 } else { geo_dist_projected_model_sum(s) / s.size.to_double() }
}

pub fn geo_dist_projected_model_scale(s : GeodistprojectedModel, f : Double) -> GeodistprojectedModel {
  let result = geo_dist_projected_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_dist_projected_model_add(a : GeodistprojectedModel, b : GeodistprojectedModel) -> GeodistprojectedModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_dist_projected_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_dist_projected_model_copy(s : GeodistprojectedModel) -> GeodistprojectedModel {
  let result = geo_dist_projected_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_dist_projected_model_fill(s : GeodistprojectedModel, v : Double) -> GeodistprojectedModel {
  let result = geo_dist_projected_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_dist_projected_model_min(s : GeodistprojectedModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_projected_model_max(s : GeodistprojectedModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_projected_model_to_string(s : GeodistprojectedModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistprojectedLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_projected_layer_make(size : Int) -> GeodistprojectedLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_projected_layer_len(s : GeodistprojectedLayer) -> Int { s.size }

pub fn geo_dist_projected_layer_get(s : GeodistprojectedLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_projected_layer_set(s : GeodistprojectedLayer, i : Int, v : Double) -> GeodistprojectedLayer {
  let result = geo_dist_projected_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_dist_projected_layer_sum(s : GeodistprojectedLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_dist_projected_layer_mean(s : GeodistprojectedLayer) -> Double {
  if s.size == 0 { 0.0 } else { geo_dist_projected_layer_sum(s) / s.size.to_double() }
}

pub fn geo_dist_projected_layer_scale(s : GeodistprojectedLayer, f : Double) -> GeodistprojectedLayer {
  let result = geo_dist_projected_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_dist_projected_layer_add(a : GeodistprojectedLayer, b : GeodistprojectedLayer) -> GeodistprojectedLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_dist_projected_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_dist_projected_layer_copy(s : GeodistprojectedLayer) -> GeodistprojectedLayer {
  let result = geo_dist_projected_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_dist_projected_layer_fill(s : GeodistprojectedLayer, v : Double) -> GeodistprojectedLayer {
  let result = geo_dist_projected_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_dist_projected_layer_min(s : GeodistprojectedLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_projected_layer_max(s : GeodistprojectedLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_projected_layer_to_string(s : GeodistprojectedLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistprojectedBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_projected_buffer_make(size : Int) -> GeodistprojectedBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_projected_buffer_len(s : GeodistprojectedBuffer) -> Int { s.size }

pub fn geo_dist_projected_buffer_get(s : GeodistprojectedBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_projected_buffer_set(s : GeodistprojectedBuffer, i : Int, v : Double) -> GeodistprojectedBuffer {
  let result = geo_dist_projected_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_dist_projected_buffer_sum(s : GeodistprojectedBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_dist_projected_buffer_mean(s : GeodistprojectedBuffer) -> Double {
  if s.size == 0 { 0.0 } else { geo_dist_projected_buffer_sum(s) / s.size.to_double() }
}

pub fn geo_dist_projected_buffer_scale(s : GeodistprojectedBuffer, f : Double) -> GeodistprojectedBuffer {
  let result = geo_dist_projected_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_dist_projected_buffer_add(a : GeodistprojectedBuffer, b : GeodistprojectedBuffer) -> GeodistprojectedBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_dist_projected_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_dist_projected_buffer_copy(s : GeodistprojectedBuffer) -> GeodistprojectedBuffer {
  let result = geo_dist_projected_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_dist_projected_buffer_fill(s : GeodistprojectedBuffer, v : Double) -> GeodistprojectedBuffer {
  let result = geo_dist_projected_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_dist_projected_buffer_min(s : GeodistprojectedBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_projected_buffer_max(s : GeodistprojectedBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_projected_buffer_to_string(s : GeodistprojectedBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistprojectedCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_projected_cursor_make(size : Int) -> GeodistprojectedCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_projected_cursor_len(s : GeodistprojectedCursor) -> Int { s.size }

pub fn geo_dist_projected_cursor_get(s : GeodistprojectedCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_projected_cursor_set(s : GeodistprojectedCursor, i : Int, v : Double) -> GeodistprojectedCursor {
  let result = geo_dist_projected_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_dist_projected_cursor_sum(s : GeodistprojectedCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_dist_projected_cursor_mean(s : GeodistprojectedCursor) -> Double {
  if s.size == 0 { 0.0 } else { geo_dist_projected_cursor_sum(s) / s.size.to_double() }
}

pub fn geo_dist_projected_cursor_scale(s : GeodistprojectedCursor, f : Double) -> GeodistprojectedCursor {
  let result = geo_dist_projected_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_dist_projected_cursor_add(a : GeodistprojectedCursor, b : GeodistprojectedCursor) -> GeodistprojectedCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_dist_projected_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_dist_projected_cursor_copy(s : GeodistprojectedCursor) -> GeodistprojectedCursor {
  let result = geo_dist_projected_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_dist_projected_cursor_fill(s : GeodistprojectedCursor, v : Double) -> GeodistprojectedCursor {
  let result = geo_dist_projected_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_dist_projected_cursor_min(s : GeodistprojectedCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_projected_cursor_max(s : GeodistprojectedCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_projected_cursor_to_string(s : GeodistprojectedCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistprojectedView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_projected_view_make(size : Int) -> GeodistprojectedView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_projected_view_len(s : GeodistprojectedView) -> Int { s.size }

pub fn geo_dist_projected_view_get(s : GeodistprojectedView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_projected_view_set(s : GeodistprojectedView, i : Int, v : Double) -> GeodistprojectedView {
  let result = geo_dist_projected_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_dist_projected_view_sum(s : GeodistprojectedView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_dist_projected_view_mean(s : GeodistprojectedView) -> Double {
  if s.size == 0 { 0.0 } else { geo_dist_projected_view_sum(s) / s.size.to_double() }
}

pub fn geo_dist_projected_view_scale(s : GeodistprojectedView, f : Double) -> GeodistprojectedView {
  let result = geo_dist_projected_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_dist_projected_view_add(a : GeodistprojectedView, b : GeodistprojectedView) -> GeodistprojectedView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_dist_projected_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_dist_projected_view_copy(s : GeodistprojectedView) -> GeodistprojectedView {
  let result = geo_dist_projected_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_dist_projected_view_fill(s : GeodistprojectedView, v : Double) -> GeodistprojectedView {
  let result = geo_dist_projected_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_dist_projected_view_min(s : GeodistprojectedView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_projected_view_max(s : GeodistprojectedView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_projected_view_to_string(s : GeodistprojectedView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistprojectedRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_projected_range_make(size : Int) -> GeodistprojectedRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_projected_range_len(s : GeodistprojectedRange) -> Int { s.size }

pub fn geo_dist_projected_range_get(s : GeodistprojectedRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_projected_range_set(s : GeodistprojectedRange, i : Int, v : Double) -> GeodistprojectedRange {
  let result = geo_dist_projected_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_dist_projected_range_sum(s : GeodistprojectedRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_dist_projected_range_mean(s : GeodistprojectedRange) -> Double {
  if s.size == 0 { 0.0 } else { geo_dist_projected_range_sum(s) / s.size.to_double() }
}

pub fn geo_dist_projected_range_scale(s : GeodistprojectedRange, f : Double) -> GeodistprojectedRange {
  let result = geo_dist_projected_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_dist_projected_range_add(a : GeodistprojectedRange, b : GeodistprojectedRange) -> GeodistprojectedRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_dist_projected_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_dist_projected_range_copy(s : GeodistprojectedRange) -> GeodistprojectedRange {
  let result = geo_dist_projected_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_dist_projected_range_fill(s : GeodistprojectedRange, v : Double) -> GeodistprojectedRange {
  let result = geo_dist_projected_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_dist_projected_range_min(s : GeodistprojectedRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_projected_range_max(s : GeodistprojectedRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_projected_range_to_string(s : GeodistprojectedRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistprojectedSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_projected_slice_make(size : Int) -> GeodistprojectedSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_projected_slice_len(s : GeodistprojectedSlice) -> Int { s.size }

pub fn geo_dist_projected_slice_get(s : GeodistprojectedSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_projected_slice_set(s : GeodistprojectedSlice, i : Int, v : Double) -> GeodistprojectedSlice {
  let result = geo_dist_projected_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_dist_projected_slice_sum(s : GeodistprojectedSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_dist_projected_slice_mean(s : GeodistprojectedSlice) -> Double {
  if s.size == 0 { 0.0 } else { geo_dist_projected_slice_sum(s) / s.size.to_double() }
}

pub fn geo_dist_projected_slice_scale(s : GeodistprojectedSlice, f : Double) -> GeodistprojectedSlice {
  let result = geo_dist_projected_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_dist_projected_slice_add(a : GeodistprojectedSlice, b : GeodistprojectedSlice) -> GeodistprojectedSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_dist_projected_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_dist_projected_slice_copy(s : GeodistprojectedSlice) -> GeodistprojectedSlice {
  let result = geo_dist_projected_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_dist_projected_slice_fill(s : GeodistprojectedSlice, v : Double) -> GeodistprojectedSlice {
  let result = geo_dist_projected_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_dist_projected_slice_min(s : GeodistprojectedSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_projected_slice_max(s : GeodistprojectedSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_projected_slice_to_string(s : GeodistprojectedSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn geo_dist_projected_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_dist_projected_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_dist_projected_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_dist_projected_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_dist_projected_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_dist_projected_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_dist_projected_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_dist_projected_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_dist_projected_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_dist_projected_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_dist_projected_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_dist_projected_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_dist_projected_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_dist_projected_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_dist_projected_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_dist_projected_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_dist_projected_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_dist_projected_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_dist_projected_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_dist_projected_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_dist_projected_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_dist_projected_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_dist_projected_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_dist_projected_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_dist_projected_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

