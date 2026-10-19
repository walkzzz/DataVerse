///===
/// extcore/geo_intersect_circle

pub(all) struct GeointersectcirclePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn geo_intersect_circle_make_point(x : Double, y : Double) -> GeointersectcirclePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn geo_intersect_circle_make_point3(x : Double, y : Double, z : Double) -> GeointersectcirclePoint {
  { x, y, z, label: 0 }
}

pub fn geo_intersect_circle_point_x(pt : GeointersectcirclePoint) -> Double { pt.x }

pub fn geo_intersect_circle_point_y(pt : GeointersectcirclePoint) -> Double { pt.y }

pub fn geo_intersect_circle_point_z(pt : GeointersectcirclePoint) -> Double { pt.z }

pub fn geo_intersect_circle_point_label(pt : GeointersectcirclePoint) -> Int { pt.label }

pub fn geo_intersect_circle_point_dist(a : GeointersectcirclePoint, b : GeointersectcirclePoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn geo_intersect_circle_point_add(a : GeointersectcirclePoint, b : GeointersectcirclePoint) -> GeointersectcirclePoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn geo_intersect_circle_point_sub(a : GeointersectcirclePoint, b : GeointersectcirclePoint) -> GeointersectcirclePoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn geo_intersect_circle_point_scale(pt : GeointersectcirclePoint, s : Double) -> GeointersectcirclePoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn geo_intersect_circle_point_dot(a : GeointersectcirclePoint, b : GeointersectcirclePoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn geo_intersect_circle_point_cross(a : GeointersectcirclePoint, b : GeointersectcirclePoint) -> GeointersectcirclePoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn geo_intersect_circle_point_norm(pt : GeointersectcirclePoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn geo_intersect_circle_point_normalize(pt : GeointersectcirclePoint) -> GeointersectcirclePoint {
  let n = geo_intersect_circle_point_norm(pt)
  if n < 0.0000001 { pt } else { geo_intersect_circle_point_scale(pt, 1.0 / n) }
}

pub fn geo_intersect_circle_point_negate(pt : GeointersectcirclePoint) -> GeointersectcirclePoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn geo_intersect_circle_point_mid(a : GeointersectcirclePoint, b : GeointersectcirclePoint) -> GeointersectcirclePoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn geo_intersect_circle_point_lerp(a : GeointersectcirclePoint, b : GeointersectcirclePoint, t : Double) -> GeointersectcirclePoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn geo_intersect_circle_point_to_string(pt : GeointersectcirclePoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct GeointersectcircleSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn geo_intersect_circle_make_series(vals : Array[Double], name : String) -> GeointersectcircleSeries {
  { vals, name, meta: 0 }
}

pub fn geo_intersect_circle_series_len(s : GeointersectcircleSeries) -> Int { s.vals.length() }

pub fn geo_intersect_circle_series_sum(s : GeointersectcircleSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn geo_intersect_circle_series_mean(s : GeointersectcircleSeries) -> Double {
  let n = geo_intersect_circle_series_len(s)
  if n == 0 { 0.0 } else { geo_intersect_circle_series_sum(s) / n.to_double() }
}

pub fn geo_intersect_circle_series_min(s : GeointersectcircleSeries) -> Double {
  let n = geo_intersect_circle_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn geo_intersect_circle_series_max(s : GeointersectcircleSeries) -> Double {
  let n = geo_intersect_circle_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn geo_intersect_circle_series_range(s : GeointersectcircleSeries) -> Double {
  geo_intersect_circle_series_max(s) - geo_intersect_circle_series_min(s)
}

pub fn geo_intersect_circle_series_var(s : GeointersectcircleSeries) -> Double {
  let n = geo_intersect_circle_series_len(s)
  if n == 0 { 0.0 } else {
    let m = geo_intersect_circle_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn geo_intersect_circle_series_std(s : GeointersectcircleSeries) -> Double { @_common.sqrt(geo_intersect_circle_series_var(s)) }

pub fn geo_intersect_circle_series_median(s : GeointersectcircleSeries) -> Double {
  let n = geo_intersect_circle_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = geo_intersect_circle_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn geo_intersect_circle_series_scale(s : GeointersectcircleSeries, f : Double) -> GeointersectcircleSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn geo_intersect_circle_series_add(a : GeointersectcircleSeries, b : GeointersectcircleSeries) -> GeointersectcircleSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn geo_intersect_circle_series_sub(a : GeointersectcircleSeries, b : GeointersectcircleSeries) -> GeointersectcircleSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn geo_intersect_circle_series_normalize(s : GeointersectcircleSeries) -> GeointersectcircleSeries {
  let mn = geo_intersect_circle_series_min(s)
  let mx = geo_intersect_circle_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn geo_intersect_circle_series_cumsum(s : GeointersectcircleSeries) -> GeointersectcircleSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn geo_intersect_circle_series_to_string(s : GeointersectcircleSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GeointersectcircleMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn geo_intersect_circle_make_matrix(rows : Int, cols : Int, val : Double) -> GeointersectcircleMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn geo_intersect_circle_matrix_identity(n : Int) -> GeointersectcircleMatrix {
  let m = geo_intersect_circle_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn geo_intersect_circle_matrix_get(m : GeointersectcircleMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn geo_intersect_circle_matrix_transpose(m : GeointersectcircleMatrix) -> GeointersectcircleMatrix {
  let result = geo_intersect_circle_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn geo_intersect_circle_matrix_add(a : GeointersectcircleMatrix, b : GeointersectcircleMatrix) -> GeointersectcircleMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = geo_intersect_circle_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn geo_intersect_circle_matrix_scale(m : GeointersectcircleMatrix, s : Double) -> GeointersectcircleMatrix {
  let result = geo_intersect_circle_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn geo_intersect_circle_matrix_multiply(a : GeointersectcircleMatrix, b : GeointersectcircleMatrix) -> GeointersectcircleMatrix {
  if a.cols != b.rows { return geo_intersect_circle_make_matrix(a.rows, b.cols, 0.0) }
  let result = geo_intersect_circle_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn geo_intersect_circle_matrix_trace(m : GeointersectcircleMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn geo_intersect_circle_matrix_det(m : GeointersectcircleMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn geo_intersect_circle_matrix_norm(m : GeointersectcircleMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn geo_intersect_circle_matrix_to_string(m : GeointersectcircleMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + @_common.dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct GeointersectcircleVector {
  comps : Array[Double]
  dim : Int
}

pub fn geo_intersect_circle_make_vector(comps : Array[Double]) -> GeointersectcircleVector {
  { comps, dim: comps.length() }
}

pub fn geo_intersect_circle_vector_zero(dim : Int) -> GeointersectcircleVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn geo_intersect_circle_vector_add(a : GeointersectcircleVector, b : GeointersectcircleVector) -> GeointersectcircleVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn geo_intersect_circle_vector_sub(a : GeointersectcircleVector, b : GeointersectcircleVector) -> GeointersectcircleVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn geo_intersect_circle_vector_scale(v : GeointersectcircleVector, s : Double) -> GeointersectcircleVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn geo_intersect_circle_vector_dot(a : GeointersectcircleVector, b : GeointersectcircleVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn geo_intersect_circle_vector_norm(v : GeointersectcircleVector) -> Double { @_common.sqrt(geo_intersect_circle_vector_dot(v, v)) }

pub fn geo_intersect_circle_vector_normalize(v : GeointersectcircleVector) -> GeointersectcircleVector {
  let n = geo_intersect_circle_vector_norm(v)
  if n < 0.0000001 { v } else { geo_intersect_circle_vector_scale(v, 1.0 / n) }
}

pub fn geo_intersect_circle_vector_dist(a : GeointersectcircleVector, b : GeointersectcircleVector) -> Double {
  geo_intersect_circle_vector_norm(geo_intersect_circle_vector_sub(a, b))
}

pub fn geo_intersect_circle_vector_to_string(v : GeointersectcircleVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn geo_intersect_circle_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn geo_intersect_circle_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = geo_intersect_circle_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn geo_intersect_circle_std(data : Array[Double]) -> Double { @_common.sqrt(geo_intersect_circle_var(data)) }

pub fn geo_intersect_circle_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = geo_intersect_circle_mean(a); let mb = geo_intersect_circle_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn geo_intersect_circle_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = geo_intersect_circle_std(a); let sb = geo_intersect_circle_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { geo_intersect_circle_cov(a, b) / (sa * sb) }
}

pub fn geo_intersect_circle_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = geo_intersect_circle_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn geo_intersect_circle_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn geo_intersect_circle_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn geo_intersect_circle_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  @_common.sqrt(geo_intersect_circle_mse(pred, labels))
}

pub fn geo_intersect_circle_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn geo_intersect_circle_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = geo_intersect_circle_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn geo_intersect_circle_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn geo_intersect_circle_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn geo_intersect_circle_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = geo_intersect_circle_precision(pred, labels, pos); let r = geo_intersect_circle_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn geo_intersect_circle_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn geo_intersect_circle_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = geo_intersect_circle_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn geo_intersect_circle_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn geo_intersect_circle_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn geo_intersect_circle_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = geo_intersect_circle_gcd(a, b)
    (a / g) * b
  }
}

pub fn geo_intersect_circle_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn geo_intersect_circle_fibonacci(n : Int) -> Int {
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

pub fn geo_intersect_circle_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = geo_intersect_circle_min(data); let mx = geo_intersect_circle_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn geo_intersect_circle_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = geo_intersect_circle_mean(data); let sd = geo_intersect_circle_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn geo_intersect_circle_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn geo_intersect_circle_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn geo_intersect_circle_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn geo_intersect_circle_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn geo_intersect_circle_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn geo_intersect_circle_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

pub(all) struct GeointersectcircleFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_circle_frame_make(size : Int) -> GeointersectcircleFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_circle_frame_len(s : GeointersectcircleFrame) -> Int { s.size }

pub fn geo_intersect_circle_frame_get(s : GeointersectcircleFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_circle_frame_set(s : GeointersectcircleFrame, i : Int, v : Double) -> GeointersectcircleFrame {
  let result = geo_intersect_circle_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_circle_frame_sum(s : GeointersectcircleFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_intersect_circle_frame_mean(s : GeointersectcircleFrame) -> Double {
  if s.size == 0 { 0.0 } else { geo_intersect_circle_frame_sum(s) / s.size.to_double() }
}

pub fn geo_intersect_circle_frame_scale(s : GeointersectcircleFrame, f : Double) -> GeointersectcircleFrame {
  let result = geo_intersect_circle_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_intersect_circle_frame_add(a : GeointersectcircleFrame, b : GeointersectcircleFrame) -> GeointersectcircleFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_intersect_circle_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_intersect_circle_frame_copy(s : GeointersectcircleFrame) -> GeointersectcircleFrame {
  let result = geo_intersect_circle_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_intersect_circle_frame_fill(s : GeointersectcircleFrame, v : Double) -> GeointersectcircleFrame {
  let result = geo_intersect_circle_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_circle_frame_min(s : GeointersectcircleFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_circle_frame_max(s : GeointersectcircleFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_circle_frame_to_string(s : GeointersectcircleFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectcircleTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_circle_table_make(size : Int) -> GeointersectcircleTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_circle_table_len(s : GeointersectcircleTable) -> Int { s.size }

pub fn geo_intersect_circle_table_get(s : GeointersectcircleTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_circle_table_set(s : GeointersectcircleTable, i : Int, v : Double) -> GeointersectcircleTable {
  let result = geo_intersect_circle_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_circle_table_sum(s : GeointersectcircleTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_intersect_circle_table_mean(s : GeointersectcircleTable) -> Double {
  if s.size == 0 { 0.0 } else { geo_intersect_circle_table_sum(s) / s.size.to_double() }
}

pub fn geo_intersect_circle_table_scale(s : GeointersectcircleTable, f : Double) -> GeointersectcircleTable {
  let result = geo_intersect_circle_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_intersect_circle_table_add(a : GeointersectcircleTable, b : GeointersectcircleTable) -> GeointersectcircleTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_intersect_circle_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_intersect_circle_table_copy(s : GeointersectcircleTable) -> GeointersectcircleTable {
  let result = geo_intersect_circle_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_intersect_circle_table_fill(s : GeointersectcircleTable, v : Double) -> GeointersectcircleTable {
  let result = geo_intersect_circle_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_circle_table_min(s : GeointersectcircleTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_circle_table_max(s : GeointersectcircleTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_circle_table_to_string(s : GeointersectcircleTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectcircleGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_circle_graphn_make(size : Int) -> GeointersectcircleGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_circle_graphn_len(s : GeointersectcircleGraphN) -> Int { s.size }

pub fn geo_intersect_circle_graphn_get(s : GeointersectcircleGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_circle_graphn_set(s : GeointersectcircleGraphN, i : Int, v : Double) -> GeointersectcircleGraphN {
  let result = geo_intersect_circle_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_circle_graphn_sum(s : GeointersectcircleGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_intersect_circle_graphn_mean(s : GeointersectcircleGraphN) -> Double {
  if s.size == 0 { 0.0 } else { geo_intersect_circle_graphn_sum(s) / s.size.to_double() }
}

pub fn geo_intersect_circle_graphn_scale(s : GeointersectcircleGraphN, f : Double) -> GeointersectcircleGraphN {
  let result = geo_intersect_circle_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_intersect_circle_graphn_add(a : GeointersectcircleGraphN, b : GeointersectcircleGraphN) -> GeointersectcircleGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_intersect_circle_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_intersect_circle_graphn_copy(s : GeointersectcircleGraphN) -> GeointersectcircleGraphN {
  let result = geo_intersect_circle_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_intersect_circle_graphn_fill(s : GeointersectcircleGraphN, v : Double) -> GeointersectcircleGraphN {
  let result = geo_intersect_circle_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_circle_graphn_min(s : GeointersectcircleGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_circle_graphn_max(s : GeointersectcircleGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_circle_graphn_to_string(s : GeointersectcircleGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectcircleNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_circle_node_make(size : Int) -> GeointersectcircleNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_circle_node_len(s : GeointersectcircleNode) -> Int { s.size }

pub fn geo_intersect_circle_node_get(s : GeointersectcircleNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_circle_node_set(s : GeointersectcircleNode, i : Int, v : Double) -> GeointersectcircleNode {
  let result = geo_intersect_circle_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_circle_node_sum(s : GeointersectcircleNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_intersect_circle_node_mean(s : GeointersectcircleNode) -> Double {
  if s.size == 0 { 0.0 } else { geo_intersect_circle_node_sum(s) / s.size.to_double() }
}

pub fn geo_intersect_circle_node_scale(s : GeointersectcircleNode, f : Double) -> GeointersectcircleNode {
  let result = geo_intersect_circle_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_intersect_circle_node_add(a : GeointersectcircleNode, b : GeointersectcircleNode) -> GeointersectcircleNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_intersect_circle_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_intersect_circle_node_copy(s : GeointersectcircleNode) -> GeointersectcircleNode {
  let result = geo_intersect_circle_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_intersect_circle_node_fill(s : GeointersectcircleNode, v : Double) -> GeointersectcircleNode {
  let result = geo_intersect_circle_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_circle_node_min(s : GeointersectcircleNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_circle_node_max(s : GeointersectcircleNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_circle_node_to_string(s : GeointersectcircleNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectcircleEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_circle_edge_make(size : Int) -> GeointersectcircleEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_circle_edge_len(s : GeointersectcircleEdge) -> Int { s.size }

pub fn geo_intersect_circle_edge_get(s : GeointersectcircleEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_circle_edge_set(s : GeointersectcircleEdge, i : Int, v : Double) -> GeointersectcircleEdge {
  let result = geo_intersect_circle_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_circle_edge_sum(s : GeointersectcircleEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_intersect_circle_edge_mean(s : GeointersectcircleEdge) -> Double {
  if s.size == 0 { 0.0 } else { geo_intersect_circle_edge_sum(s) / s.size.to_double() }
}

pub fn geo_intersect_circle_edge_scale(s : GeointersectcircleEdge, f : Double) -> GeointersectcircleEdge {
  let result = geo_intersect_circle_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_intersect_circle_edge_add(a : GeointersectcircleEdge, b : GeointersectcircleEdge) -> GeointersectcircleEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_intersect_circle_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_intersect_circle_edge_copy(s : GeointersectcircleEdge) -> GeointersectcircleEdge {
  let result = geo_intersect_circle_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_intersect_circle_edge_fill(s : GeointersectcircleEdge, v : Double) -> GeointersectcircleEdge {
  let result = geo_intersect_circle_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_circle_edge_min(s : GeointersectcircleEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_circle_edge_max(s : GeointersectcircleEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_circle_edge_to_string(s : GeointersectcircleEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectcirclePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_circle_path_make(size : Int) -> GeointersectcirclePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_circle_path_len(s : GeointersectcirclePath) -> Int { s.size }

pub fn geo_intersect_circle_path_get(s : GeointersectcirclePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_circle_path_set(s : GeointersectcirclePath, i : Int, v : Double) -> GeointersectcirclePath {
  let result = geo_intersect_circle_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_circle_path_sum(s : GeointersectcirclePath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_intersect_circle_path_mean(s : GeointersectcirclePath) -> Double {
  if s.size == 0 { 0.0 } else { geo_intersect_circle_path_sum(s) / s.size.to_double() }
}

pub fn geo_intersect_circle_path_scale(s : GeointersectcirclePath, f : Double) -> GeointersectcirclePath {
  let result = geo_intersect_circle_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_intersect_circle_path_add(a : GeointersectcirclePath, b : GeointersectcirclePath) -> GeointersectcirclePath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_intersect_circle_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_intersect_circle_path_copy(s : GeointersectcirclePath) -> GeointersectcirclePath {
  let result = geo_intersect_circle_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_intersect_circle_path_fill(s : GeointersectcirclePath, v : Double) -> GeointersectcirclePath {
  let result = geo_intersect_circle_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_circle_path_min(s : GeointersectcirclePath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_circle_path_max(s : GeointersectcirclePath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_circle_path_to_string(s : GeointersectcirclePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectcircleCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_circle_cluster_make(size : Int) -> GeointersectcircleCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_circle_cluster_len(s : GeointersectcircleCluster) -> Int { s.size }

pub fn geo_intersect_circle_cluster_get(s : GeointersectcircleCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_circle_cluster_set(s : GeointersectcircleCluster, i : Int, v : Double) -> GeointersectcircleCluster {
  let result = geo_intersect_circle_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_circle_cluster_sum(s : GeointersectcircleCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_intersect_circle_cluster_mean(s : GeointersectcircleCluster) -> Double {
  if s.size == 0 { 0.0 } else { geo_intersect_circle_cluster_sum(s) / s.size.to_double() }
}

pub fn geo_intersect_circle_cluster_scale(s : GeointersectcircleCluster, f : Double) -> GeointersectcircleCluster {
  let result = geo_intersect_circle_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_intersect_circle_cluster_add(a : GeointersectcircleCluster, b : GeointersectcircleCluster) -> GeointersectcircleCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_intersect_circle_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_intersect_circle_cluster_copy(s : GeointersectcircleCluster) -> GeointersectcircleCluster {
  let result = geo_intersect_circle_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_intersect_circle_cluster_fill(s : GeointersectcircleCluster, v : Double) -> GeointersectcircleCluster {
  let result = geo_intersect_circle_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_circle_cluster_min(s : GeointersectcircleCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_circle_cluster_max(s : GeointersectcircleCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_circle_cluster_to_string(s : GeointersectcircleCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectcircleModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_circle_model_make(size : Int) -> GeointersectcircleModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_circle_model_len(s : GeointersectcircleModel) -> Int { s.size }

pub fn geo_intersect_circle_model_get(s : GeointersectcircleModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_circle_model_set(s : GeointersectcircleModel, i : Int, v : Double) -> GeointersectcircleModel {
  let result = geo_intersect_circle_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_circle_model_sum(s : GeointersectcircleModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_intersect_circle_model_mean(s : GeointersectcircleModel) -> Double {
  if s.size == 0 { 0.0 } else { geo_intersect_circle_model_sum(s) / s.size.to_double() }
}

pub fn geo_intersect_circle_model_scale(s : GeointersectcircleModel, f : Double) -> GeointersectcircleModel {
  let result = geo_intersect_circle_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_intersect_circle_model_add(a : GeointersectcircleModel, b : GeointersectcircleModel) -> GeointersectcircleModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_intersect_circle_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_intersect_circle_model_copy(s : GeointersectcircleModel) -> GeointersectcircleModel {
  let result = geo_intersect_circle_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_intersect_circle_model_fill(s : GeointersectcircleModel, v : Double) -> GeointersectcircleModel {
  let result = geo_intersect_circle_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_circle_model_min(s : GeointersectcircleModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_circle_model_max(s : GeointersectcircleModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_circle_model_to_string(s : GeointersectcircleModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectcircleLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_circle_layer_make(size : Int) -> GeointersectcircleLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_circle_layer_len(s : GeointersectcircleLayer) -> Int { s.size }

pub fn geo_intersect_circle_layer_get(s : GeointersectcircleLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_circle_layer_set(s : GeointersectcircleLayer, i : Int, v : Double) -> GeointersectcircleLayer {
  let result = geo_intersect_circle_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_circle_layer_sum(s : GeointersectcircleLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_intersect_circle_layer_mean(s : GeointersectcircleLayer) -> Double {
  if s.size == 0 { 0.0 } else { geo_intersect_circle_layer_sum(s) / s.size.to_double() }
}

pub fn geo_intersect_circle_layer_scale(s : GeointersectcircleLayer, f : Double) -> GeointersectcircleLayer {
  let result = geo_intersect_circle_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_intersect_circle_layer_add(a : GeointersectcircleLayer, b : GeointersectcircleLayer) -> GeointersectcircleLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_intersect_circle_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_intersect_circle_layer_copy(s : GeointersectcircleLayer) -> GeointersectcircleLayer {
  let result = geo_intersect_circle_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_intersect_circle_layer_fill(s : GeointersectcircleLayer, v : Double) -> GeointersectcircleLayer {
  let result = geo_intersect_circle_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_circle_layer_min(s : GeointersectcircleLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_circle_layer_max(s : GeointersectcircleLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_circle_layer_to_string(s : GeointersectcircleLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectcircleBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_circle_buffer_make(size : Int) -> GeointersectcircleBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_circle_buffer_len(s : GeointersectcircleBuffer) -> Int { s.size }

pub fn geo_intersect_circle_buffer_get(s : GeointersectcircleBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_circle_buffer_set(s : GeointersectcircleBuffer, i : Int, v : Double) -> GeointersectcircleBuffer {
  let result = geo_intersect_circle_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_circle_buffer_sum(s : GeointersectcircleBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_intersect_circle_buffer_mean(s : GeointersectcircleBuffer) -> Double {
  if s.size == 0 { 0.0 } else { geo_intersect_circle_buffer_sum(s) / s.size.to_double() }
}

pub fn geo_intersect_circle_buffer_scale(s : GeointersectcircleBuffer, f : Double) -> GeointersectcircleBuffer {
  let result = geo_intersect_circle_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_intersect_circle_buffer_add(a : GeointersectcircleBuffer, b : GeointersectcircleBuffer) -> GeointersectcircleBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_intersect_circle_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_intersect_circle_buffer_copy(s : GeointersectcircleBuffer) -> GeointersectcircleBuffer {
  let result = geo_intersect_circle_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_intersect_circle_buffer_fill(s : GeointersectcircleBuffer, v : Double) -> GeointersectcircleBuffer {
  let result = geo_intersect_circle_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_circle_buffer_min(s : GeointersectcircleBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_circle_buffer_max(s : GeointersectcircleBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_circle_buffer_to_string(s : GeointersectcircleBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectcircleCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_circle_cursor_make(size : Int) -> GeointersectcircleCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_circle_cursor_len(s : GeointersectcircleCursor) -> Int { s.size }

pub fn geo_intersect_circle_cursor_get(s : GeointersectcircleCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_circle_cursor_set(s : GeointersectcircleCursor, i : Int, v : Double) -> GeointersectcircleCursor {
  let result = geo_intersect_circle_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_circle_cursor_sum(s : GeointersectcircleCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_intersect_circle_cursor_mean(s : GeointersectcircleCursor) -> Double {
  if s.size == 0 { 0.0 } else { geo_intersect_circle_cursor_sum(s) / s.size.to_double() }
}

pub fn geo_intersect_circle_cursor_scale(s : GeointersectcircleCursor, f : Double) -> GeointersectcircleCursor {
  let result = geo_intersect_circle_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_intersect_circle_cursor_add(a : GeointersectcircleCursor, b : GeointersectcircleCursor) -> GeointersectcircleCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_intersect_circle_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_intersect_circle_cursor_copy(s : GeointersectcircleCursor) -> GeointersectcircleCursor {
  let result = geo_intersect_circle_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_intersect_circle_cursor_fill(s : GeointersectcircleCursor, v : Double) -> GeointersectcircleCursor {
  let result = geo_intersect_circle_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_circle_cursor_min(s : GeointersectcircleCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_circle_cursor_max(s : GeointersectcircleCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_circle_cursor_to_string(s : GeointersectcircleCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectcircleView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_circle_view_make(size : Int) -> GeointersectcircleView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_circle_view_len(s : GeointersectcircleView) -> Int { s.size }

pub fn geo_intersect_circle_view_get(s : GeointersectcircleView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_circle_view_set(s : GeointersectcircleView, i : Int, v : Double) -> GeointersectcircleView {
  let result = geo_intersect_circle_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_circle_view_sum(s : GeointersectcircleView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_intersect_circle_view_mean(s : GeointersectcircleView) -> Double {
  if s.size == 0 { 0.0 } else { geo_intersect_circle_view_sum(s) / s.size.to_double() }
}

pub fn geo_intersect_circle_view_scale(s : GeointersectcircleView, f : Double) -> GeointersectcircleView {
  let result = geo_intersect_circle_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_intersect_circle_view_add(a : GeointersectcircleView, b : GeointersectcircleView) -> GeointersectcircleView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_intersect_circle_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_intersect_circle_view_copy(s : GeointersectcircleView) -> GeointersectcircleView {
  let result = geo_intersect_circle_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_intersect_circle_view_fill(s : GeointersectcircleView, v : Double) -> GeointersectcircleView {
  let result = geo_intersect_circle_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_circle_view_min(s : GeointersectcircleView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_circle_view_max(s : GeointersectcircleView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_circle_view_to_string(s : GeointersectcircleView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectcircleRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_circle_range_make(size : Int) -> GeointersectcircleRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_circle_range_len(s : GeointersectcircleRange) -> Int { s.size }

pub fn geo_intersect_circle_range_get(s : GeointersectcircleRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_circle_range_set(s : GeointersectcircleRange, i : Int, v : Double) -> GeointersectcircleRange {
  let result = geo_intersect_circle_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_circle_range_sum(s : GeointersectcircleRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_intersect_circle_range_mean(s : GeointersectcircleRange) -> Double {
  if s.size == 0 { 0.0 } else { geo_intersect_circle_range_sum(s) / s.size.to_double() }
}

pub fn geo_intersect_circle_range_scale(s : GeointersectcircleRange, f : Double) -> GeointersectcircleRange {
  let result = geo_intersect_circle_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_intersect_circle_range_add(a : GeointersectcircleRange, b : GeointersectcircleRange) -> GeointersectcircleRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_intersect_circle_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_intersect_circle_range_copy(s : GeointersectcircleRange) -> GeointersectcircleRange {
  let result = geo_intersect_circle_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_intersect_circle_range_fill(s : GeointersectcircleRange, v : Double) -> GeointersectcircleRange {
  let result = geo_intersect_circle_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_circle_range_min(s : GeointersectcircleRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_circle_range_max(s : GeointersectcircleRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_circle_range_to_string(s : GeointersectcircleRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectcircleSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_circle_slice_make(size : Int) -> GeointersectcircleSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_circle_slice_len(s : GeointersectcircleSlice) -> Int { s.size }

pub fn geo_intersect_circle_slice_get(s : GeointersectcircleSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_circle_slice_set(s : GeointersectcircleSlice, i : Int, v : Double) -> GeointersectcircleSlice {
  let result = geo_intersect_circle_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_circle_slice_sum(s : GeointersectcircleSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_intersect_circle_slice_mean(s : GeointersectcircleSlice) -> Double {
  if s.size == 0 { 0.0 } else { geo_intersect_circle_slice_sum(s) / s.size.to_double() }
}

pub fn geo_intersect_circle_slice_scale(s : GeointersectcircleSlice, f : Double) -> GeointersectcircleSlice {
  let result = geo_intersect_circle_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_intersect_circle_slice_add(a : GeointersectcircleSlice, b : GeointersectcircleSlice) -> GeointersectcircleSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_intersect_circle_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_intersect_circle_slice_copy(s : GeointersectcircleSlice) -> GeointersectcircleSlice {
  let result = geo_intersect_circle_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_intersect_circle_slice_fill(s : GeointersectcircleSlice, v : Double) -> GeointersectcircleSlice {
  let result = geo_intersect_circle_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_circle_slice_min(s : GeointersectcircleSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_circle_slice_max(s : GeointersectcircleSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_circle_slice_to_string(s : GeointersectcircleSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

