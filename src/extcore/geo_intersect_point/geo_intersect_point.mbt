///===
/// extcore/geo_intersect_point

pub(all) struct GeointersectpointPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn geo_intersect_point_make_point(x : Double, y : Double) -> GeointersectpointPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn geo_intersect_point_make_point3(x : Double, y : Double, z : Double) -> GeointersectpointPoint {
  { x, y, z, label: 0 }
}

pub fn geo_intersect_point_point_x(pt : GeointersectpointPoint) -> Double { pt.x }

pub fn geo_intersect_point_point_y(pt : GeointersectpointPoint) -> Double { pt.y }

pub fn geo_intersect_point_point_z(pt : GeointersectpointPoint) -> Double { pt.z }

pub fn geo_intersect_point_point_label(pt : GeointersectpointPoint) -> Int { pt.label }

pub fn geo_intersect_point_point_dist(a : GeointersectpointPoint, b : GeointersectpointPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  geo_intersect_point_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn geo_intersect_point_point_add(a : GeointersectpointPoint, b : GeointersectpointPoint) -> GeointersectpointPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn geo_intersect_point_point_sub(a : GeointersectpointPoint, b : GeointersectpointPoint) -> GeointersectpointPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn geo_intersect_point_point_scale(pt : GeointersectpointPoint, s : Double) -> GeointersectpointPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn geo_intersect_point_point_dot(a : GeointersectpointPoint, b : GeointersectpointPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn geo_intersect_point_point_cross(a : GeointersectpointPoint, b : GeointersectpointPoint) -> GeointersectpointPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn geo_intersect_point_point_norm(pt : GeointersectpointPoint) -> Double {
  geo_intersect_point_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn geo_intersect_point_point_normalize(pt : GeointersectpointPoint) -> GeointersectpointPoint {
  let n = geo_intersect_point_point_norm(pt)
  if n < 0.0000001 { pt } else { geo_intersect_point_point_scale(pt, 1.0 / n) }
}

pub fn geo_intersect_point_point_negate(pt : GeointersectpointPoint) -> GeointersectpointPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn geo_intersect_point_point_mid(a : GeointersectpointPoint, b : GeointersectpointPoint) -> GeointersectpointPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn geo_intersect_point_point_lerp(a : GeointersectpointPoint, b : GeointersectpointPoint, t : Double) -> GeointersectpointPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn geo_intersect_point_point_to_string(pt : GeointersectpointPoint) -> String {
  "(" + geo_intersect_point_dbl(pt.x) + ", " + geo_intersect_point_dbl(pt.y) + ", " + geo_intersect_point_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct GeointersectpointSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn geo_intersect_point_make_series(vals : Array[Double], name : String) -> GeointersectpointSeries {
  { vals, name, meta: 0 }
}

pub fn geo_intersect_point_series_len(s : GeointersectpointSeries) -> Int { s.vals.length() }

pub fn geo_intersect_point_series_sum(s : GeointersectpointSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn geo_intersect_point_series_mean(s : GeointersectpointSeries) -> Double {
  let n = geo_intersect_point_series_len(s)
  if n == 0 { 0.0 } else { geo_intersect_point_series_sum(s) / n.to_double() }
}

pub fn geo_intersect_point_series_min(s : GeointersectpointSeries) -> Double {
  let n = geo_intersect_point_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn geo_intersect_point_series_max(s : GeointersectpointSeries) -> Double {
  let n = geo_intersect_point_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn geo_intersect_point_series_range(s : GeointersectpointSeries) -> Double {
  geo_intersect_point_series_max(s) - geo_intersect_point_series_min(s)
}

pub fn geo_intersect_point_series_var(s : GeointersectpointSeries) -> Double {
  let n = geo_intersect_point_series_len(s)
  if n == 0 { 0.0 } else {
    let m = geo_intersect_point_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn geo_intersect_point_series_std(s : GeointersectpointSeries) -> Double { geo_intersect_point_sqrt(geo_intersect_point_series_var(s)) }

pub fn geo_intersect_point_series_median(s : GeointersectpointSeries) -> Double {
  let n = geo_intersect_point_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = geo_intersect_point_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn geo_intersect_point_series_scale(s : GeointersectpointSeries, f : Double) -> GeointersectpointSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = geo_intersect_point_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn geo_intersect_point_series_add(a : GeointersectpointSeries, b : GeointersectpointSeries) -> GeointersectpointSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = geo_intersect_point_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn geo_intersect_point_series_sub(a : GeointersectpointSeries, b : GeointersectpointSeries) -> GeointersectpointSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = geo_intersect_point_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn geo_intersect_point_series_normalize(s : GeointersectpointSeries) -> GeointersectpointSeries {
  let mn = geo_intersect_point_series_min(s)
  let mx = geo_intersect_point_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = geo_intersect_point_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn geo_intersect_point_series_cumsum(s : GeointersectpointSeries) -> GeointersectpointSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = geo_intersect_point_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn geo_intersect_point_series_to_string(s : GeointersectpointSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + geo_intersect_point_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GeointersectpointMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn geo_intersect_point_make_matrix(rows : Int, cols : Int, val : Double) -> GeointersectpointMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn geo_intersect_point_matrix_identity(n : Int) -> GeointersectpointMatrix {
  let m = geo_intersect_point_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn geo_intersect_point_matrix_get(m : GeointersectpointMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn geo_intersect_point_matrix_transpose(m : GeointersectpointMatrix) -> GeointersectpointMatrix {
  let result = geo_intersect_point_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn geo_intersect_point_matrix_add(a : GeointersectpointMatrix, b : GeointersectpointMatrix) -> GeointersectpointMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = geo_intersect_point_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn geo_intersect_point_matrix_scale(m : GeointersectpointMatrix, s : Double) -> GeointersectpointMatrix {
  let result = geo_intersect_point_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn geo_intersect_point_matrix_multiply(a : GeointersectpointMatrix, b : GeointersectpointMatrix) -> GeointersectpointMatrix {
  if a.cols != b.rows { return geo_intersect_point_make_matrix(a.rows, b.cols, 0.0) }
  let result = geo_intersect_point_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn geo_intersect_point_matrix_trace(m : GeointersectpointMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn geo_intersect_point_matrix_det(m : GeointersectpointMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn geo_intersect_point_matrix_norm(m : GeointersectpointMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  geo_intersect_point_sqrt(sum)
}

pub fn geo_intersect_point_matrix_to_string(m : GeointersectpointMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + geo_intersect_point_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct GeointersectpointVector {
  comps : Array[Double]
  dim : Int
}

pub fn geo_intersect_point_make_vector(comps : Array[Double]) -> GeointersectpointVector {
  { comps, dim: comps.length() }
}

pub fn geo_intersect_point_vector_zero(dim : Int) -> GeointersectpointVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn geo_intersect_point_vector_add(a : GeointersectpointVector, b : GeointersectpointVector) -> GeointersectpointVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = geo_intersect_point_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn geo_intersect_point_vector_sub(a : GeointersectpointVector, b : GeointersectpointVector) -> GeointersectpointVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = geo_intersect_point_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn geo_intersect_point_vector_scale(v : GeointersectpointVector, s : Double) -> GeointersectpointVector {
  let mut result = []
  for i in 0..<v.dim { result = geo_intersect_point_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn geo_intersect_point_vector_dot(a : GeointersectpointVector, b : GeointersectpointVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn geo_intersect_point_vector_norm(v : GeointersectpointVector) -> Double { geo_intersect_point_sqrt(geo_intersect_point_vector_dot(v, v)) }

pub fn geo_intersect_point_vector_normalize(v : GeointersectpointVector) -> GeointersectpointVector {
  let n = geo_intersect_point_vector_norm(v)
  if n < 0.0000001 { v } else { geo_intersect_point_vector_scale(v, 1.0 / n) }
}

pub fn geo_intersect_point_vector_dist(a : GeointersectpointVector, b : GeointersectpointVector) -> Double {
  geo_intersect_point_vector_norm(geo_intersect_point_vector_sub(a, b))
}

pub fn geo_intersect_point_vector_to_string(v : GeointersectpointVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + geo_intersect_point_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn geo_intersect_point_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn geo_intersect_point_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = geo_intersect_point_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn geo_intersect_point_std(data : Array[Double]) -> Double { geo_intersect_point_sqrt(geo_intersect_point_var(data)) }

pub fn geo_intersect_point_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = geo_intersect_point_mean(a); let mb = geo_intersect_point_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn geo_intersect_point_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = geo_intersect_point_std(a); let sb = geo_intersect_point_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { geo_intersect_point_cov(a, b) / (sa * sb) }
}

pub fn geo_intersect_point_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = geo_intersect_point_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn geo_intersect_point_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn geo_intersect_point_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn geo_intersect_point_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  geo_intersect_point_sqrt(geo_intersect_point_mse(pred, labels))
}

pub fn geo_intersect_point_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + geo_intersect_point_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn geo_intersect_point_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = geo_intersect_point_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn geo_intersect_point_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn geo_intersect_point_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn geo_intersect_point_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = geo_intersect_point_precision(pred, labels, pos); let r = geo_intersect_point_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn geo_intersect_point_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn geo_intersect_point_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = geo_intersect_point_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn geo_intersect_point_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn geo_intersect_point_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn geo_intersect_point_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = geo_intersect_point_gcd(a, b)
    (a / g) * b
  }
}

pub fn geo_intersect_point_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn geo_intersect_point_fibonacci(n : Int) -> Int {
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

pub fn geo_intersect_point_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = geo_intersect_point_min(data); let mx = geo_intersect_point_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn geo_intersect_point_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = geo_intersect_point_mean(data); let sd = geo_intersect_point_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn geo_intersect_point_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn geo_intersect_point_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn geo_intersect_point_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn geo_intersect_point_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn geo_intersect_point_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn geo_intersect_point_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn geo_intersect_point_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn geo_intersect_point_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn geo_intersect_point_dbl(x : Double) -> String {
  let i = if x >= 0.0 { geo_intersect_point_int(x) } else { -geo_intersect_point_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { geo_intersect_point_int(f * 1000000.0) } else { geo_intersect_point_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn geo_intersect_point_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn geo_intersect_point_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct GeointersectpointFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_point_frame_make(size : Int) -> GeointersectpointFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_point_frame_len(s : GeointersectpointFrame) -> Int { s.size }

pub fn geo_intersect_point_frame_get(s : GeointersectpointFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_point_frame_set(s : GeointersectpointFrame, i : Int, v : Double) -> GeointersectpointFrame {
  let result = geo_intersect_point_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_point_frame_sum(s : GeointersectpointFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_intersect_point_frame_mean(s : GeointersectpointFrame) -> Double {
  if s.size == 0 { 0.0 } else { geo_intersect_point_frame_sum(s) / s.size.to_double() }
}

pub fn geo_intersect_point_frame_scale(s : GeointersectpointFrame, f : Double) -> GeointersectpointFrame {
  let result = geo_intersect_point_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_intersect_point_frame_add(a : GeointersectpointFrame, b : GeointersectpointFrame) -> GeointersectpointFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_intersect_point_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_intersect_point_frame_copy(s : GeointersectpointFrame) -> GeointersectpointFrame {
  let result = geo_intersect_point_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_intersect_point_frame_fill(s : GeointersectpointFrame, v : Double) -> GeointersectpointFrame {
  let result = geo_intersect_point_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_point_frame_min(s : GeointersectpointFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_point_frame_max(s : GeointersectpointFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_point_frame_to_string(s : GeointersectpointFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectpointTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_point_table_make(size : Int) -> GeointersectpointTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_point_table_len(s : GeointersectpointTable) -> Int { s.size }

pub fn geo_intersect_point_table_get(s : GeointersectpointTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_point_table_set(s : GeointersectpointTable, i : Int, v : Double) -> GeointersectpointTable {
  let result = geo_intersect_point_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_point_table_sum(s : GeointersectpointTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_intersect_point_table_mean(s : GeointersectpointTable) -> Double {
  if s.size == 0 { 0.0 } else { geo_intersect_point_table_sum(s) / s.size.to_double() }
}

pub fn geo_intersect_point_table_scale(s : GeointersectpointTable, f : Double) -> GeointersectpointTable {
  let result = geo_intersect_point_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_intersect_point_table_add(a : GeointersectpointTable, b : GeointersectpointTable) -> GeointersectpointTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_intersect_point_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_intersect_point_table_copy(s : GeointersectpointTable) -> GeointersectpointTable {
  let result = geo_intersect_point_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_intersect_point_table_fill(s : GeointersectpointTable, v : Double) -> GeointersectpointTable {
  let result = geo_intersect_point_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_point_table_min(s : GeointersectpointTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_point_table_max(s : GeointersectpointTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_point_table_to_string(s : GeointersectpointTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectpointGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_point_graphn_make(size : Int) -> GeointersectpointGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_point_graphn_len(s : GeointersectpointGraphN) -> Int { s.size }

pub fn geo_intersect_point_graphn_get(s : GeointersectpointGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_point_graphn_set(s : GeointersectpointGraphN, i : Int, v : Double) -> GeointersectpointGraphN {
  let result = geo_intersect_point_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_point_graphn_sum(s : GeointersectpointGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_intersect_point_graphn_mean(s : GeointersectpointGraphN) -> Double {
  if s.size == 0 { 0.0 } else { geo_intersect_point_graphn_sum(s) / s.size.to_double() }
}

pub fn geo_intersect_point_graphn_scale(s : GeointersectpointGraphN, f : Double) -> GeointersectpointGraphN {
  let result = geo_intersect_point_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_intersect_point_graphn_add(a : GeointersectpointGraphN, b : GeointersectpointGraphN) -> GeointersectpointGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_intersect_point_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_intersect_point_graphn_copy(s : GeointersectpointGraphN) -> GeointersectpointGraphN {
  let result = geo_intersect_point_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_intersect_point_graphn_fill(s : GeointersectpointGraphN, v : Double) -> GeointersectpointGraphN {
  let result = geo_intersect_point_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_point_graphn_min(s : GeointersectpointGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_point_graphn_max(s : GeointersectpointGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_point_graphn_to_string(s : GeointersectpointGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectpointNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_point_node_make(size : Int) -> GeointersectpointNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_point_node_len(s : GeointersectpointNode) -> Int { s.size }

pub fn geo_intersect_point_node_get(s : GeointersectpointNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_point_node_set(s : GeointersectpointNode, i : Int, v : Double) -> GeointersectpointNode {
  let result = geo_intersect_point_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_point_node_sum(s : GeointersectpointNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_intersect_point_node_mean(s : GeointersectpointNode) -> Double {
  if s.size == 0 { 0.0 } else { geo_intersect_point_node_sum(s) / s.size.to_double() }
}

pub fn geo_intersect_point_node_scale(s : GeointersectpointNode, f : Double) -> GeointersectpointNode {
  let result = geo_intersect_point_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_intersect_point_node_add(a : GeointersectpointNode, b : GeointersectpointNode) -> GeointersectpointNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_intersect_point_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_intersect_point_node_copy(s : GeointersectpointNode) -> GeointersectpointNode {
  let result = geo_intersect_point_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_intersect_point_node_fill(s : GeointersectpointNode, v : Double) -> GeointersectpointNode {
  let result = geo_intersect_point_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_point_node_min(s : GeointersectpointNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_point_node_max(s : GeointersectpointNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_point_node_to_string(s : GeointersectpointNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectpointEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_point_edge_make(size : Int) -> GeointersectpointEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_point_edge_len(s : GeointersectpointEdge) -> Int { s.size }

pub fn geo_intersect_point_edge_get(s : GeointersectpointEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_point_edge_set(s : GeointersectpointEdge, i : Int, v : Double) -> GeointersectpointEdge {
  let result = geo_intersect_point_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_point_edge_sum(s : GeointersectpointEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_intersect_point_edge_mean(s : GeointersectpointEdge) -> Double {
  if s.size == 0 { 0.0 } else { geo_intersect_point_edge_sum(s) / s.size.to_double() }
}

pub fn geo_intersect_point_edge_scale(s : GeointersectpointEdge, f : Double) -> GeointersectpointEdge {
  let result = geo_intersect_point_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_intersect_point_edge_add(a : GeointersectpointEdge, b : GeointersectpointEdge) -> GeointersectpointEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_intersect_point_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_intersect_point_edge_copy(s : GeointersectpointEdge) -> GeointersectpointEdge {
  let result = geo_intersect_point_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_intersect_point_edge_fill(s : GeointersectpointEdge, v : Double) -> GeointersectpointEdge {
  let result = geo_intersect_point_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_point_edge_min(s : GeointersectpointEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_point_edge_max(s : GeointersectpointEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_point_edge_to_string(s : GeointersectpointEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectpointPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_point_path_make(size : Int) -> GeointersectpointPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_point_path_len(s : GeointersectpointPath) -> Int { s.size }

pub fn geo_intersect_point_path_get(s : GeointersectpointPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_point_path_set(s : GeointersectpointPath, i : Int, v : Double) -> GeointersectpointPath {
  let result = geo_intersect_point_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_point_path_sum(s : GeointersectpointPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_intersect_point_path_mean(s : GeointersectpointPath) -> Double {
  if s.size == 0 { 0.0 } else { geo_intersect_point_path_sum(s) / s.size.to_double() }
}

pub fn geo_intersect_point_path_scale(s : GeointersectpointPath, f : Double) -> GeointersectpointPath {
  let result = geo_intersect_point_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_intersect_point_path_add(a : GeointersectpointPath, b : GeointersectpointPath) -> GeointersectpointPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_intersect_point_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_intersect_point_path_copy(s : GeointersectpointPath) -> GeointersectpointPath {
  let result = geo_intersect_point_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_intersect_point_path_fill(s : GeointersectpointPath, v : Double) -> GeointersectpointPath {
  let result = geo_intersect_point_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_point_path_min(s : GeointersectpointPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_point_path_max(s : GeointersectpointPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_point_path_to_string(s : GeointersectpointPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectpointCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_point_cluster_make(size : Int) -> GeointersectpointCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_point_cluster_len(s : GeointersectpointCluster) -> Int { s.size }

pub fn geo_intersect_point_cluster_get(s : GeointersectpointCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_point_cluster_set(s : GeointersectpointCluster, i : Int, v : Double) -> GeointersectpointCluster {
  let result = geo_intersect_point_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_point_cluster_sum(s : GeointersectpointCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_intersect_point_cluster_mean(s : GeointersectpointCluster) -> Double {
  if s.size == 0 { 0.0 } else { geo_intersect_point_cluster_sum(s) / s.size.to_double() }
}

pub fn geo_intersect_point_cluster_scale(s : GeointersectpointCluster, f : Double) -> GeointersectpointCluster {
  let result = geo_intersect_point_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_intersect_point_cluster_add(a : GeointersectpointCluster, b : GeointersectpointCluster) -> GeointersectpointCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_intersect_point_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_intersect_point_cluster_copy(s : GeointersectpointCluster) -> GeointersectpointCluster {
  let result = geo_intersect_point_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_intersect_point_cluster_fill(s : GeointersectpointCluster, v : Double) -> GeointersectpointCluster {
  let result = geo_intersect_point_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_point_cluster_min(s : GeointersectpointCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_point_cluster_max(s : GeointersectpointCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_point_cluster_to_string(s : GeointersectpointCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectpointModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_point_model_make(size : Int) -> GeointersectpointModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_point_model_len(s : GeointersectpointModel) -> Int { s.size }

pub fn geo_intersect_point_model_get(s : GeointersectpointModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_point_model_set(s : GeointersectpointModel, i : Int, v : Double) -> GeointersectpointModel {
  let result = geo_intersect_point_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_point_model_sum(s : GeointersectpointModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_intersect_point_model_mean(s : GeointersectpointModel) -> Double {
  if s.size == 0 { 0.0 } else { geo_intersect_point_model_sum(s) / s.size.to_double() }
}

pub fn geo_intersect_point_model_scale(s : GeointersectpointModel, f : Double) -> GeointersectpointModel {
  let result = geo_intersect_point_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_intersect_point_model_add(a : GeointersectpointModel, b : GeointersectpointModel) -> GeointersectpointModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_intersect_point_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_intersect_point_model_copy(s : GeointersectpointModel) -> GeointersectpointModel {
  let result = geo_intersect_point_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_intersect_point_model_fill(s : GeointersectpointModel, v : Double) -> GeointersectpointModel {
  let result = geo_intersect_point_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_point_model_min(s : GeointersectpointModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_point_model_max(s : GeointersectpointModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_point_model_to_string(s : GeointersectpointModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectpointLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_point_layer_make(size : Int) -> GeointersectpointLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_point_layer_len(s : GeointersectpointLayer) -> Int { s.size }

pub fn geo_intersect_point_layer_get(s : GeointersectpointLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_point_layer_set(s : GeointersectpointLayer, i : Int, v : Double) -> GeointersectpointLayer {
  let result = geo_intersect_point_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_point_layer_sum(s : GeointersectpointLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_intersect_point_layer_mean(s : GeointersectpointLayer) -> Double {
  if s.size == 0 { 0.0 } else { geo_intersect_point_layer_sum(s) / s.size.to_double() }
}

pub fn geo_intersect_point_layer_scale(s : GeointersectpointLayer, f : Double) -> GeointersectpointLayer {
  let result = geo_intersect_point_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_intersect_point_layer_add(a : GeointersectpointLayer, b : GeointersectpointLayer) -> GeointersectpointLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_intersect_point_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_intersect_point_layer_copy(s : GeointersectpointLayer) -> GeointersectpointLayer {
  let result = geo_intersect_point_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_intersect_point_layer_fill(s : GeointersectpointLayer, v : Double) -> GeointersectpointLayer {
  let result = geo_intersect_point_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_point_layer_min(s : GeointersectpointLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_point_layer_max(s : GeointersectpointLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_point_layer_to_string(s : GeointersectpointLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectpointBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_point_buffer_make(size : Int) -> GeointersectpointBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_point_buffer_len(s : GeointersectpointBuffer) -> Int { s.size }

pub fn geo_intersect_point_buffer_get(s : GeointersectpointBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_point_buffer_set(s : GeointersectpointBuffer, i : Int, v : Double) -> GeointersectpointBuffer {
  let result = geo_intersect_point_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_point_buffer_sum(s : GeointersectpointBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_intersect_point_buffer_mean(s : GeointersectpointBuffer) -> Double {
  if s.size == 0 { 0.0 } else { geo_intersect_point_buffer_sum(s) / s.size.to_double() }
}

pub fn geo_intersect_point_buffer_scale(s : GeointersectpointBuffer, f : Double) -> GeointersectpointBuffer {
  let result = geo_intersect_point_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_intersect_point_buffer_add(a : GeointersectpointBuffer, b : GeointersectpointBuffer) -> GeointersectpointBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_intersect_point_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_intersect_point_buffer_copy(s : GeointersectpointBuffer) -> GeointersectpointBuffer {
  let result = geo_intersect_point_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_intersect_point_buffer_fill(s : GeointersectpointBuffer, v : Double) -> GeointersectpointBuffer {
  let result = geo_intersect_point_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_point_buffer_min(s : GeointersectpointBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_point_buffer_max(s : GeointersectpointBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_point_buffer_to_string(s : GeointersectpointBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectpointCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_point_cursor_make(size : Int) -> GeointersectpointCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_point_cursor_len(s : GeointersectpointCursor) -> Int { s.size }

pub fn geo_intersect_point_cursor_get(s : GeointersectpointCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_point_cursor_set(s : GeointersectpointCursor, i : Int, v : Double) -> GeointersectpointCursor {
  let result = geo_intersect_point_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_point_cursor_sum(s : GeointersectpointCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_intersect_point_cursor_mean(s : GeointersectpointCursor) -> Double {
  if s.size == 0 { 0.0 } else { geo_intersect_point_cursor_sum(s) / s.size.to_double() }
}

pub fn geo_intersect_point_cursor_scale(s : GeointersectpointCursor, f : Double) -> GeointersectpointCursor {
  let result = geo_intersect_point_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_intersect_point_cursor_add(a : GeointersectpointCursor, b : GeointersectpointCursor) -> GeointersectpointCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_intersect_point_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_intersect_point_cursor_copy(s : GeointersectpointCursor) -> GeointersectpointCursor {
  let result = geo_intersect_point_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_intersect_point_cursor_fill(s : GeointersectpointCursor, v : Double) -> GeointersectpointCursor {
  let result = geo_intersect_point_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_point_cursor_min(s : GeointersectpointCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_point_cursor_max(s : GeointersectpointCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_point_cursor_to_string(s : GeointersectpointCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectpointView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_point_view_make(size : Int) -> GeointersectpointView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_point_view_len(s : GeointersectpointView) -> Int { s.size }

pub fn geo_intersect_point_view_get(s : GeointersectpointView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_point_view_set(s : GeointersectpointView, i : Int, v : Double) -> GeointersectpointView {
  let result = geo_intersect_point_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_point_view_sum(s : GeointersectpointView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_intersect_point_view_mean(s : GeointersectpointView) -> Double {
  if s.size == 0 { 0.0 } else { geo_intersect_point_view_sum(s) / s.size.to_double() }
}

pub fn geo_intersect_point_view_scale(s : GeointersectpointView, f : Double) -> GeointersectpointView {
  let result = geo_intersect_point_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_intersect_point_view_add(a : GeointersectpointView, b : GeointersectpointView) -> GeointersectpointView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_intersect_point_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_intersect_point_view_copy(s : GeointersectpointView) -> GeointersectpointView {
  let result = geo_intersect_point_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_intersect_point_view_fill(s : GeointersectpointView, v : Double) -> GeointersectpointView {
  let result = geo_intersect_point_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_point_view_min(s : GeointersectpointView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_point_view_max(s : GeointersectpointView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_point_view_to_string(s : GeointersectpointView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectpointRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_point_range_make(size : Int) -> GeointersectpointRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_point_range_len(s : GeointersectpointRange) -> Int { s.size }

pub fn geo_intersect_point_range_get(s : GeointersectpointRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_point_range_set(s : GeointersectpointRange, i : Int, v : Double) -> GeointersectpointRange {
  let result = geo_intersect_point_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_point_range_sum(s : GeointersectpointRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_intersect_point_range_mean(s : GeointersectpointRange) -> Double {
  if s.size == 0 { 0.0 } else { geo_intersect_point_range_sum(s) / s.size.to_double() }
}

pub fn geo_intersect_point_range_scale(s : GeointersectpointRange, f : Double) -> GeointersectpointRange {
  let result = geo_intersect_point_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_intersect_point_range_add(a : GeointersectpointRange, b : GeointersectpointRange) -> GeointersectpointRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_intersect_point_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_intersect_point_range_copy(s : GeointersectpointRange) -> GeointersectpointRange {
  let result = geo_intersect_point_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_intersect_point_range_fill(s : GeointersectpointRange, v : Double) -> GeointersectpointRange {
  let result = geo_intersect_point_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_point_range_min(s : GeointersectpointRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_point_range_max(s : GeointersectpointRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_point_range_to_string(s : GeointersectpointRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectpointSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_point_slice_make(size : Int) -> GeointersectpointSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_point_slice_len(s : GeointersectpointSlice) -> Int { s.size }

pub fn geo_intersect_point_slice_get(s : GeointersectpointSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_point_slice_set(s : GeointersectpointSlice, i : Int, v : Double) -> GeointersectpointSlice {
  let result = geo_intersect_point_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_point_slice_sum(s : GeointersectpointSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_intersect_point_slice_mean(s : GeointersectpointSlice) -> Double {
  if s.size == 0 { 0.0 } else { geo_intersect_point_slice_sum(s) / s.size.to_double() }
}

pub fn geo_intersect_point_slice_scale(s : GeointersectpointSlice, f : Double) -> GeointersectpointSlice {
  let result = geo_intersect_point_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_intersect_point_slice_add(a : GeointersectpointSlice, b : GeointersectpointSlice) -> GeointersectpointSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_intersect_point_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_intersect_point_slice_copy(s : GeointersectpointSlice) -> GeointersectpointSlice {
  let result = geo_intersect_point_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_intersect_point_slice_fill(s : GeointersectpointSlice, v : Double) -> GeointersectpointSlice {
  let result = geo_intersect_point_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_point_slice_min(s : GeointersectpointSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_point_slice_max(s : GeointersectpointSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_point_slice_to_string(s : GeointersectpointSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn geo_intersect_point_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_intersect_point_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_intersect_point_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_intersect_point_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_intersect_point_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_intersect_point_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_intersect_point_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_intersect_point_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_intersect_point_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_intersect_point_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_intersect_point_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_intersect_point_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_intersect_point_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_intersect_point_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_intersect_point_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_intersect_point_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_intersect_point_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_intersect_point_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_intersect_point_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_intersect_point_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_intersect_point_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_intersect_point_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_intersect_point_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_intersect_point_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_intersect_point_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

