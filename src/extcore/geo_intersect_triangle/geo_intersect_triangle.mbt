///===
/// extcore/geo_intersect_triangle

pub(all) struct GeointersecttrianglePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn geo_intersect_triangle_make_point(x : Double, y : Double) -> GeointersecttrianglePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn geo_intersect_triangle_make_point3(x : Double, y : Double, z : Double) -> GeointersecttrianglePoint {
  { x, y, z, label: 0 }
}

pub fn geo_intersect_triangle_point_x(pt : GeointersecttrianglePoint) -> Double { pt.x }

pub fn geo_intersect_triangle_point_y(pt : GeointersecttrianglePoint) -> Double { pt.y }

pub fn geo_intersect_triangle_point_z(pt : GeointersecttrianglePoint) -> Double { pt.z }

pub fn geo_intersect_triangle_point_label(pt : GeointersecttrianglePoint) -> Int { pt.label }

pub fn geo_intersect_triangle_point_dist(a : GeointersecttrianglePoint, b : GeointersecttrianglePoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  geo_intersect_triangle_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn geo_intersect_triangle_point_add(a : GeointersecttrianglePoint, b : GeointersecttrianglePoint) -> GeointersecttrianglePoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn geo_intersect_triangle_point_sub(a : GeointersecttrianglePoint, b : GeointersecttrianglePoint) -> GeointersecttrianglePoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn geo_intersect_triangle_point_scale(pt : GeointersecttrianglePoint, s : Double) -> GeointersecttrianglePoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn geo_intersect_triangle_point_dot(a : GeointersecttrianglePoint, b : GeointersecttrianglePoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn geo_intersect_triangle_point_cross(a : GeointersecttrianglePoint, b : GeointersecttrianglePoint) -> GeointersecttrianglePoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn geo_intersect_triangle_point_norm(pt : GeointersecttrianglePoint) -> Double {
  geo_intersect_triangle_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn geo_intersect_triangle_point_normalize(pt : GeointersecttrianglePoint) -> GeointersecttrianglePoint {
  let n = geo_intersect_triangle_point_norm(pt)
  if n < 0.0000001 { pt } else { geo_intersect_triangle_point_scale(pt, 1.0 / n) }
}

pub fn geo_intersect_triangle_point_negate(pt : GeointersecttrianglePoint) -> GeointersecttrianglePoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn geo_intersect_triangle_point_mid(a : GeointersecttrianglePoint, b : GeointersecttrianglePoint) -> GeointersecttrianglePoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn geo_intersect_triangle_point_lerp(a : GeointersecttrianglePoint, b : GeointersecttrianglePoint, t : Double) -> GeointersecttrianglePoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn geo_intersect_triangle_point_to_string(pt : GeointersecttrianglePoint) -> String {
  "(" + geo_intersect_triangle_dbl(pt.x) + ", " + geo_intersect_triangle_dbl(pt.y) + ", " + geo_intersect_triangle_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct GeointersecttriangleSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn geo_intersect_triangle_make_series(vals : Array[Double], name : String) -> GeointersecttriangleSeries {
  { vals, name, meta: 0 }
}

pub fn geo_intersect_triangle_series_len(s : GeointersecttriangleSeries) -> Int { s.vals.length() }

pub fn geo_intersect_triangle_series_sum(s : GeointersecttriangleSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn geo_intersect_triangle_series_mean(s : GeointersecttriangleSeries) -> Double {
  let n = geo_intersect_triangle_series_len(s)
  if n == 0 { 0.0 } else { geo_intersect_triangle_series_sum(s) / n.to_double() }
}

pub fn geo_intersect_triangle_series_min(s : GeointersecttriangleSeries) -> Double {
  let n = geo_intersect_triangle_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn geo_intersect_triangle_series_max(s : GeointersecttriangleSeries) -> Double {
  let n = geo_intersect_triangle_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn geo_intersect_triangle_series_range(s : GeointersecttriangleSeries) -> Double {
  geo_intersect_triangle_series_max(s) - geo_intersect_triangle_series_min(s)
}

pub fn geo_intersect_triangle_series_var(s : GeointersecttriangleSeries) -> Double {
  let n = geo_intersect_triangle_series_len(s)
  if n == 0 { 0.0 } else {
    let m = geo_intersect_triangle_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn geo_intersect_triangle_series_std(s : GeointersecttriangleSeries) -> Double { geo_intersect_triangle_sqrt(geo_intersect_triangle_series_var(s)) }

pub fn geo_intersect_triangle_series_median(s : GeointersecttriangleSeries) -> Double {
  let n = geo_intersect_triangle_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = geo_intersect_triangle_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn geo_intersect_triangle_series_scale(s : GeointersecttriangleSeries, f : Double) -> GeointersecttriangleSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = geo_intersect_triangle_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn geo_intersect_triangle_series_add(a : GeointersecttriangleSeries, b : GeointersecttriangleSeries) -> GeointersecttriangleSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = geo_intersect_triangle_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn geo_intersect_triangle_series_sub(a : GeointersecttriangleSeries, b : GeointersecttriangleSeries) -> GeointersecttriangleSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = geo_intersect_triangle_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn geo_intersect_triangle_series_normalize(s : GeointersecttriangleSeries) -> GeointersecttriangleSeries {
  let mn = geo_intersect_triangle_series_min(s)
  let mx = geo_intersect_triangle_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = geo_intersect_triangle_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn geo_intersect_triangle_series_cumsum(s : GeointersecttriangleSeries) -> GeointersecttriangleSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = geo_intersect_triangle_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn geo_intersect_triangle_series_to_string(s : GeointersecttriangleSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + geo_intersect_triangle_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GeointersecttriangleMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn geo_intersect_triangle_make_matrix(rows : Int, cols : Int, val : Double) -> GeointersecttriangleMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn geo_intersect_triangle_matrix_identity(n : Int) -> GeointersecttriangleMatrix {
  let m = geo_intersect_triangle_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn geo_intersect_triangle_matrix_get(m : GeointersecttriangleMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn geo_intersect_triangle_matrix_transpose(m : GeointersecttriangleMatrix) -> GeointersecttriangleMatrix {
  let result = geo_intersect_triangle_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn geo_intersect_triangle_matrix_add(a : GeointersecttriangleMatrix, b : GeointersecttriangleMatrix) -> GeointersecttriangleMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = geo_intersect_triangle_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn geo_intersect_triangle_matrix_scale(m : GeointersecttriangleMatrix, s : Double) -> GeointersecttriangleMatrix {
  let result = geo_intersect_triangle_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn geo_intersect_triangle_matrix_multiply(a : GeointersecttriangleMatrix, b : GeointersecttriangleMatrix) -> GeointersecttriangleMatrix {
  if a.cols != b.rows { return geo_intersect_triangle_make_matrix(a.rows, b.cols, 0.0) }
  let result = geo_intersect_triangle_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn geo_intersect_triangle_matrix_trace(m : GeointersecttriangleMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn geo_intersect_triangle_matrix_det(m : GeointersecttriangleMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn geo_intersect_triangle_matrix_norm(m : GeointersecttriangleMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  geo_intersect_triangle_sqrt(sum)
}

pub fn geo_intersect_triangle_matrix_to_string(m : GeointersecttriangleMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + geo_intersect_triangle_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct GeointersecttriangleVector {
  comps : Array[Double]
  dim : Int
}

pub fn geo_intersect_triangle_make_vector(comps : Array[Double]) -> GeointersecttriangleVector {
  { comps, dim: comps.length() }
}

pub fn geo_intersect_triangle_vector_zero(dim : Int) -> GeointersecttriangleVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn geo_intersect_triangle_vector_add(a : GeointersecttriangleVector, b : GeointersecttriangleVector) -> GeointersecttriangleVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = geo_intersect_triangle_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn geo_intersect_triangle_vector_sub(a : GeointersecttriangleVector, b : GeointersecttriangleVector) -> GeointersecttriangleVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = geo_intersect_triangle_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn geo_intersect_triangle_vector_scale(v : GeointersecttriangleVector, s : Double) -> GeointersecttriangleVector {
  let mut result = []
  for i in 0..<v.dim { result = geo_intersect_triangle_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn geo_intersect_triangle_vector_dot(a : GeointersecttriangleVector, b : GeointersecttriangleVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn geo_intersect_triangle_vector_norm(v : GeointersecttriangleVector) -> Double { geo_intersect_triangle_sqrt(geo_intersect_triangle_vector_dot(v, v)) }

pub fn geo_intersect_triangle_vector_normalize(v : GeointersecttriangleVector) -> GeointersecttriangleVector {
  let n = geo_intersect_triangle_vector_norm(v)
  if n < 0.0000001 { v } else { geo_intersect_triangle_vector_scale(v, 1.0 / n) }
}

pub fn geo_intersect_triangle_vector_dist(a : GeointersecttriangleVector, b : GeointersecttriangleVector) -> Double {
  geo_intersect_triangle_vector_norm(geo_intersect_triangle_vector_sub(a, b))
}

pub fn geo_intersect_triangle_vector_to_string(v : GeointersecttriangleVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + geo_intersect_triangle_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn geo_intersect_triangle_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn geo_intersect_triangle_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = geo_intersect_triangle_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn geo_intersect_triangle_std(data : Array[Double]) -> Double { geo_intersect_triangle_sqrt(geo_intersect_triangle_var(data)) }

pub fn geo_intersect_triangle_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = geo_intersect_triangle_mean(a); let mb = geo_intersect_triangle_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn geo_intersect_triangle_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = geo_intersect_triangle_std(a); let sb = geo_intersect_triangle_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { geo_intersect_triangle_cov(a, b) / (sa * sb) }
}

pub fn geo_intersect_triangle_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = geo_intersect_triangle_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn geo_intersect_triangle_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn geo_intersect_triangle_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn geo_intersect_triangle_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  geo_intersect_triangle_sqrt(geo_intersect_triangle_mse(pred, labels))
}

pub fn geo_intersect_triangle_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + geo_intersect_triangle_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn geo_intersect_triangle_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = geo_intersect_triangle_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn geo_intersect_triangle_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn geo_intersect_triangle_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn geo_intersect_triangle_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = geo_intersect_triangle_precision(pred, labels, pos); let r = geo_intersect_triangle_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn geo_intersect_triangle_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn geo_intersect_triangle_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = geo_intersect_triangle_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn geo_intersect_triangle_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn geo_intersect_triangle_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn geo_intersect_triangle_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = geo_intersect_triangle_gcd(a, b)
    (a / g) * b
  }
}

pub fn geo_intersect_triangle_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn geo_intersect_triangle_fibonacci(n : Int) -> Int {
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

pub fn geo_intersect_triangle_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = geo_intersect_triangle_min(data); let mx = geo_intersect_triangle_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn geo_intersect_triangle_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = geo_intersect_triangle_mean(data); let sd = geo_intersect_triangle_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn geo_intersect_triangle_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn geo_intersect_triangle_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn geo_intersect_triangle_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn geo_intersect_triangle_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn geo_intersect_triangle_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn geo_intersect_triangle_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn geo_intersect_triangle_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn geo_intersect_triangle_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn geo_intersect_triangle_dbl(x : Double) -> String {
  let i = if x >= 0.0 { geo_intersect_triangle_int(x) } else { -geo_intersect_triangle_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { geo_intersect_triangle_int(f * 1000000.0) } else { geo_intersect_triangle_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn geo_intersect_triangle_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn geo_intersect_triangle_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct GeointersecttriangleFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_triangle_frame_make(size : Int) -> GeointersecttriangleFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_triangle_frame_len(s : GeointersecttriangleFrame) -> Int { s.size }

pub fn geo_intersect_triangle_frame_get(s : GeointersecttriangleFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_triangle_frame_set(s : GeointersecttriangleFrame, i : Int, v : Double) -> GeointersecttriangleFrame {
  let result = geo_intersect_triangle_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_triangle_frame_sum(s : GeointersecttriangleFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_intersect_triangle_frame_mean(s : GeointersecttriangleFrame) -> Double {
  if s.size == 0 { 0.0 } else { geo_intersect_triangle_frame_sum(s) / s.size.to_double() }
}

pub fn geo_intersect_triangle_frame_scale(s : GeointersecttriangleFrame, f : Double) -> GeointersecttriangleFrame {
  let result = geo_intersect_triangle_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_intersect_triangle_frame_add(a : GeointersecttriangleFrame, b : GeointersecttriangleFrame) -> GeointersecttriangleFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_intersect_triangle_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_intersect_triangle_frame_copy(s : GeointersecttriangleFrame) -> GeointersecttriangleFrame {
  let result = geo_intersect_triangle_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_intersect_triangle_frame_fill(s : GeointersecttriangleFrame, v : Double) -> GeointersecttriangleFrame {
  let result = geo_intersect_triangle_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_triangle_frame_min(s : GeointersecttriangleFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_triangle_frame_max(s : GeointersecttriangleFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_triangle_frame_to_string(s : GeointersecttriangleFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersecttriangleTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_triangle_table_make(size : Int) -> GeointersecttriangleTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_triangle_table_len(s : GeointersecttriangleTable) -> Int { s.size }

pub fn geo_intersect_triangle_table_get(s : GeointersecttriangleTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_triangle_table_set(s : GeointersecttriangleTable, i : Int, v : Double) -> GeointersecttriangleTable {
  let result = geo_intersect_triangle_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_triangle_table_sum(s : GeointersecttriangleTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_intersect_triangle_table_mean(s : GeointersecttriangleTable) -> Double {
  if s.size == 0 { 0.0 } else { geo_intersect_triangle_table_sum(s) / s.size.to_double() }
}

pub fn geo_intersect_triangle_table_scale(s : GeointersecttriangleTable, f : Double) -> GeointersecttriangleTable {
  let result = geo_intersect_triangle_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_intersect_triangle_table_add(a : GeointersecttriangleTable, b : GeointersecttriangleTable) -> GeointersecttriangleTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_intersect_triangle_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_intersect_triangle_table_copy(s : GeointersecttriangleTable) -> GeointersecttriangleTable {
  let result = geo_intersect_triangle_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_intersect_triangle_table_fill(s : GeointersecttriangleTable, v : Double) -> GeointersecttriangleTable {
  let result = geo_intersect_triangle_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_triangle_table_min(s : GeointersecttriangleTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_triangle_table_max(s : GeointersecttriangleTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_triangle_table_to_string(s : GeointersecttriangleTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersecttriangleGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_triangle_graphn_make(size : Int) -> GeointersecttriangleGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_triangle_graphn_len(s : GeointersecttriangleGraphN) -> Int { s.size }

pub fn geo_intersect_triangle_graphn_get(s : GeointersecttriangleGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_triangle_graphn_set(s : GeointersecttriangleGraphN, i : Int, v : Double) -> GeointersecttriangleGraphN {
  let result = geo_intersect_triangle_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_triangle_graphn_sum(s : GeointersecttriangleGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_intersect_triangle_graphn_mean(s : GeointersecttriangleGraphN) -> Double {
  if s.size == 0 { 0.0 } else { geo_intersect_triangle_graphn_sum(s) / s.size.to_double() }
}

pub fn geo_intersect_triangle_graphn_scale(s : GeointersecttriangleGraphN, f : Double) -> GeointersecttriangleGraphN {
  let result = geo_intersect_triangle_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_intersect_triangle_graphn_add(a : GeointersecttriangleGraphN, b : GeointersecttriangleGraphN) -> GeointersecttriangleGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_intersect_triangle_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_intersect_triangle_graphn_copy(s : GeointersecttriangleGraphN) -> GeointersecttriangleGraphN {
  let result = geo_intersect_triangle_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_intersect_triangle_graphn_fill(s : GeointersecttriangleGraphN, v : Double) -> GeointersecttriangleGraphN {
  let result = geo_intersect_triangle_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_triangle_graphn_min(s : GeointersecttriangleGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_triangle_graphn_max(s : GeointersecttriangleGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_triangle_graphn_to_string(s : GeointersecttriangleGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersecttriangleNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_triangle_node_make(size : Int) -> GeointersecttriangleNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_triangle_node_len(s : GeointersecttriangleNode) -> Int { s.size }

pub fn geo_intersect_triangle_node_get(s : GeointersecttriangleNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_triangle_node_set(s : GeointersecttriangleNode, i : Int, v : Double) -> GeointersecttriangleNode {
  let result = geo_intersect_triangle_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_triangle_node_sum(s : GeointersecttriangleNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_intersect_triangle_node_mean(s : GeointersecttriangleNode) -> Double {
  if s.size == 0 { 0.0 } else { geo_intersect_triangle_node_sum(s) / s.size.to_double() }
}

pub fn geo_intersect_triangle_node_scale(s : GeointersecttriangleNode, f : Double) -> GeointersecttriangleNode {
  let result = geo_intersect_triangle_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_intersect_triangle_node_add(a : GeointersecttriangleNode, b : GeointersecttriangleNode) -> GeointersecttriangleNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_intersect_triangle_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_intersect_triangle_node_copy(s : GeointersecttriangleNode) -> GeointersecttriangleNode {
  let result = geo_intersect_triangle_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_intersect_triangle_node_fill(s : GeointersecttriangleNode, v : Double) -> GeointersecttriangleNode {
  let result = geo_intersect_triangle_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_triangle_node_min(s : GeointersecttriangleNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_triangle_node_max(s : GeointersecttriangleNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_triangle_node_to_string(s : GeointersecttriangleNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersecttriangleEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_triangle_edge_make(size : Int) -> GeointersecttriangleEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_triangle_edge_len(s : GeointersecttriangleEdge) -> Int { s.size }

pub fn geo_intersect_triangle_edge_get(s : GeointersecttriangleEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_triangle_edge_set(s : GeointersecttriangleEdge, i : Int, v : Double) -> GeointersecttriangleEdge {
  let result = geo_intersect_triangle_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_triangle_edge_sum(s : GeointersecttriangleEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_intersect_triangle_edge_mean(s : GeointersecttriangleEdge) -> Double {
  if s.size == 0 { 0.0 } else { geo_intersect_triangle_edge_sum(s) / s.size.to_double() }
}

pub fn geo_intersect_triangle_edge_scale(s : GeointersecttriangleEdge, f : Double) -> GeointersecttriangleEdge {
  let result = geo_intersect_triangle_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_intersect_triangle_edge_add(a : GeointersecttriangleEdge, b : GeointersecttriangleEdge) -> GeointersecttriangleEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_intersect_triangle_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_intersect_triangle_edge_copy(s : GeointersecttriangleEdge) -> GeointersecttriangleEdge {
  let result = geo_intersect_triangle_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_intersect_triangle_edge_fill(s : GeointersecttriangleEdge, v : Double) -> GeointersecttriangleEdge {
  let result = geo_intersect_triangle_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_triangle_edge_min(s : GeointersecttriangleEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_triangle_edge_max(s : GeointersecttriangleEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_triangle_edge_to_string(s : GeointersecttriangleEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersecttrianglePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_triangle_path_make(size : Int) -> GeointersecttrianglePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_triangle_path_len(s : GeointersecttrianglePath) -> Int { s.size }

pub fn geo_intersect_triangle_path_get(s : GeointersecttrianglePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_triangle_path_set(s : GeointersecttrianglePath, i : Int, v : Double) -> GeointersecttrianglePath {
  let result = geo_intersect_triangle_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_triangle_path_sum(s : GeointersecttrianglePath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_intersect_triangle_path_mean(s : GeointersecttrianglePath) -> Double {
  if s.size == 0 { 0.0 } else { geo_intersect_triangle_path_sum(s) / s.size.to_double() }
}

pub fn geo_intersect_triangle_path_scale(s : GeointersecttrianglePath, f : Double) -> GeointersecttrianglePath {
  let result = geo_intersect_triangle_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_intersect_triangle_path_add(a : GeointersecttrianglePath, b : GeointersecttrianglePath) -> GeointersecttrianglePath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_intersect_triangle_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_intersect_triangle_path_copy(s : GeointersecttrianglePath) -> GeointersecttrianglePath {
  let result = geo_intersect_triangle_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_intersect_triangle_path_fill(s : GeointersecttrianglePath, v : Double) -> GeointersecttrianglePath {
  let result = geo_intersect_triangle_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_triangle_path_min(s : GeointersecttrianglePath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_triangle_path_max(s : GeointersecttrianglePath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_triangle_path_to_string(s : GeointersecttrianglePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersecttriangleCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_triangle_cluster_make(size : Int) -> GeointersecttriangleCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_triangle_cluster_len(s : GeointersecttriangleCluster) -> Int { s.size }

pub fn geo_intersect_triangle_cluster_get(s : GeointersecttriangleCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_triangle_cluster_set(s : GeointersecttriangleCluster, i : Int, v : Double) -> GeointersecttriangleCluster {
  let result = geo_intersect_triangle_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_triangle_cluster_sum(s : GeointersecttriangleCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_intersect_triangle_cluster_mean(s : GeointersecttriangleCluster) -> Double {
  if s.size == 0 { 0.0 } else { geo_intersect_triangle_cluster_sum(s) / s.size.to_double() }
}

pub fn geo_intersect_triangle_cluster_scale(s : GeointersecttriangleCluster, f : Double) -> GeointersecttriangleCluster {
  let result = geo_intersect_triangle_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_intersect_triangle_cluster_add(a : GeointersecttriangleCluster, b : GeointersecttriangleCluster) -> GeointersecttriangleCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_intersect_triangle_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_intersect_triangle_cluster_copy(s : GeointersecttriangleCluster) -> GeointersecttriangleCluster {
  let result = geo_intersect_triangle_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_intersect_triangle_cluster_fill(s : GeointersecttriangleCluster, v : Double) -> GeointersecttriangleCluster {
  let result = geo_intersect_triangle_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_triangle_cluster_min(s : GeointersecttriangleCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_triangle_cluster_max(s : GeointersecttriangleCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_triangle_cluster_to_string(s : GeointersecttriangleCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersecttriangleModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_triangle_model_make(size : Int) -> GeointersecttriangleModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_triangle_model_len(s : GeointersecttriangleModel) -> Int { s.size }

pub fn geo_intersect_triangle_model_get(s : GeointersecttriangleModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_triangle_model_set(s : GeointersecttriangleModel, i : Int, v : Double) -> GeointersecttriangleModel {
  let result = geo_intersect_triangle_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_triangle_model_sum(s : GeointersecttriangleModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_intersect_triangle_model_mean(s : GeointersecttriangleModel) -> Double {
  if s.size == 0 { 0.0 } else { geo_intersect_triangle_model_sum(s) / s.size.to_double() }
}

pub fn geo_intersect_triangle_model_scale(s : GeointersecttriangleModel, f : Double) -> GeointersecttriangleModel {
  let result = geo_intersect_triangle_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_intersect_triangle_model_add(a : GeointersecttriangleModel, b : GeointersecttriangleModel) -> GeointersecttriangleModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_intersect_triangle_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_intersect_triangle_model_copy(s : GeointersecttriangleModel) -> GeointersecttriangleModel {
  let result = geo_intersect_triangle_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_intersect_triangle_model_fill(s : GeointersecttriangleModel, v : Double) -> GeointersecttriangleModel {
  let result = geo_intersect_triangle_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_triangle_model_min(s : GeointersecttriangleModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_triangle_model_max(s : GeointersecttriangleModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_triangle_model_to_string(s : GeointersecttriangleModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersecttriangleLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_triangle_layer_make(size : Int) -> GeointersecttriangleLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_triangle_layer_len(s : GeointersecttriangleLayer) -> Int { s.size }

pub fn geo_intersect_triangle_layer_get(s : GeointersecttriangleLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_triangle_layer_set(s : GeointersecttriangleLayer, i : Int, v : Double) -> GeointersecttriangleLayer {
  let result = geo_intersect_triangle_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_triangle_layer_sum(s : GeointersecttriangleLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_intersect_triangle_layer_mean(s : GeointersecttriangleLayer) -> Double {
  if s.size == 0 { 0.0 } else { geo_intersect_triangle_layer_sum(s) / s.size.to_double() }
}

pub fn geo_intersect_triangle_layer_scale(s : GeointersecttriangleLayer, f : Double) -> GeointersecttriangleLayer {
  let result = geo_intersect_triangle_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_intersect_triangle_layer_add(a : GeointersecttriangleLayer, b : GeointersecttriangleLayer) -> GeointersecttriangleLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_intersect_triangle_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_intersect_triangle_layer_copy(s : GeointersecttriangleLayer) -> GeointersecttriangleLayer {
  let result = geo_intersect_triangle_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_intersect_triangle_layer_fill(s : GeointersecttriangleLayer, v : Double) -> GeointersecttriangleLayer {
  let result = geo_intersect_triangle_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_triangle_layer_min(s : GeointersecttriangleLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_triangle_layer_max(s : GeointersecttriangleLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_triangle_layer_to_string(s : GeointersecttriangleLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersecttriangleBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_triangle_buffer_make(size : Int) -> GeointersecttriangleBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_triangle_buffer_len(s : GeointersecttriangleBuffer) -> Int { s.size }

pub fn geo_intersect_triangle_buffer_get(s : GeointersecttriangleBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_triangle_buffer_set(s : GeointersecttriangleBuffer, i : Int, v : Double) -> GeointersecttriangleBuffer {
  let result = geo_intersect_triangle_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_triangle_buffer_sum(s : GeointersecttriangleBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_intersect_triangle_buffer_mean(s : GeointersecttriangleBuffer) -> Double {
  if s.size == 0 { 0.0 } else { geo_intersect_triangle_buffer_sum(s) / s.size.to_double() }
}

pub fn geo_intersect_triangle_buffer_scale(s : GeointersecttriangleBuffer, f : Double) -> GeointersecttriangleBuffer {
  let result = geo_intersect_triangle_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_intersect_triangle_buffer_add(a : GeointersecttriangleBuffer, b : GeointersecttriangleBuffer) -> GeointersecttriangleBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_intersect_triangle_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_intersect_triangle_buffer_copy(s : GeointersecttriangleBuffer) -> GeointersecttriangleBuffer {
  let result = geo_intersect_triangle_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_intersect_triangle_buffer_fill(s : GeointersecttriangleBuffer, v : Double) -> GeointersecttriangleBuffer {
  let result = geo_intersect_triangle_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_triangle_buffer_min(s : GeointersecttriangleBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_triangle_buffer_max(s : GeointersecttriangleBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_triangle_buffer_to_string(s : GeointersecttriangleBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersecttriangleCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_triangle_cursor_make(size : Int) -> GeointersecttriangleCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_triangle_cursor_len(s : GeointersecttriangleCursor) -> Int { s.size }

pub fn geo_intersect_triangle_cursor_get(s : GeointersecttriangleCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_triangle_cursor_set(s : GeointersecttriangleCursor, i : Int, v : Double) -> GeointersecttriangleCursor {
  let result = geo_intersect_triangle_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_triangle_cursor_sum(s : GeointersecttriangleCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_intersect_triangle_cursor_mean(s : GeointersecttriangleCursor) -> Double {
  if s.size == 0 { 0.0 } else { geo_intersect_triangle_cursor_sum(s) / s.size.to_double() }
}

pub fn geo_intersect_triangle_cursor_scale(s : GeointersecttriangleCursor, f : Double) -> GeointersecttriangleCursor {
  let result = geo_intersect_triangle_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_intersect_triangle_cursor_add(a : GeointersecttriangleCursor, b : GeointersecttriangleCursor) -> GeointersecttriangleCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_intersect_triangle_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_intersect_triangle_cursor_copy(s : GeointersecttriangleCursor) -> GeointersecttriangleCursor {
  let result = geo_intersect_triangle_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_intersect_triangle_cursor_fill(s : GeointersecttriangleCursor, v : Double) -> GeointersecttriangleCursor {
  let result = geo_intersect_triangle_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_triangle_cursor_min(s : GeointersecttriangleCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_triangle_cursor_max(s : GeointersecttriangleCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_triangle_cursor_to_string(s : GeointersecttriangleCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersecttriangleView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_triangle_view_make(size : Int) -> GeointersecttriangleView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_triangle_view_len(s : GeointersecttriangleView) -> Int { s.size }

pub fn geo_intersect_triangle_view_get(s : GeointersecttriangleView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_triangle_view_set(s : GeointersecttriangleView, i : Int, v : Double) -> GeointersecttriangleView {
  let result = geo_intersect_triangle_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_triangle_view_sum(s : GeointersecttriangleView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_intersect_triangle_view_mean(s : GeointersecttriangleView) -> Double {
  if s.size == 0 { 0.0 } else { geo_intersect_triangle_view_sum(s) / s.size.to_double() }
}

pub fn geo_intersect_triangle_view_scale(s : GeointersecttriangleView, f : Double) -> GeointersecttriangleView {
  let result = geo_intersect_triangle_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_intersect_triangle_view_add(a : GeointersecttriangleView, b : GeointersecttriangleView) -> GeointersecttriangleView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_intersect_triangle_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_intersect_triangle_view_copy(s : GeointersecttriangleView) -> GeointersecttriangleView {
  let result = geo_intersect_triangle_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_intersect_triangle_view_fill(s : GeointersecttriangleView, v : Double) -> GeointersecttriangleView {
  let result = geo_intersect_triangle_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_triangle_view_min(s : GeointersecttriangleView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_triangle_view_max(s : GeointersecttriangleView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_triangle_view_to_string(s : GeointersecttriangleView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersecttriangleRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_triangle_range_make(size : Int) -> GeointersecttriangleRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_triangle_range_len(s : GeointersecttriangleRange) -> Int { s.size }

pub fn geo_intersect_triangle_range_get(s : GeointersecttriangleRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_triangle_range_set(s : GeointersecttriangleRange, i : Int, v : Double) -> GeointersecttriangleRange {
  let result = geo_intersect_triangle_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_triangle_range_sum(s : GeointersecttriangleRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_intersect_triangle_range_mean(s : GeointersecttriangleRange) -> Double {
  if s.size == 0 { 0.0 } else { geo_intersect_triangle_range_sum(s) / s.size.to_double() }
}

pub fn geo_intersect_triangle_range_scale(s : GeointersecttriangleRange, f : Double) -> GeointersecttriangleRange {
  let result = geo_intersect_triangle_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_intersect_triangle_range_add(a : GeointersecttriangleRange, b : GeointersecttriangleRange) -> GeointersecttriangleRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_intersect_triangle_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_intersect_triangle_range_copy(s : GeointersecttriangleRange) -> GeointersecttriangleRange {
  let result = geo_intersect_triangle_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_intersect_triangle_range_fill(s : GeointersecttriangleRange, v : Double) -> GeointersecttriangleRange {
  let result = geo_intersect_triangle_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_triangle_range_min(s : GeointersecttriangleRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_triangle_range_max(s : GeointersecttriangleRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_triangle_range_to_string(s : GeointersecttriangleRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersecttriangleSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_triangle_slice_make(size : Int) -> GeointersecttriangleSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_triangle_slice_len(s : GeointersecttriangleSlice) -> Int { s.size }

pub fn geo_intersect_triangle_slice_get(s : GeointersecttriangleSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_triangle_slice_set(s : GeointersecttriangleSlice, i : Int, v : Double) -> GeointersecttriangleSlice {
  let result = geo_intersect_triangle_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_triangle_slice_sum(s : GeointersecttriangleSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_intersect_triangle_slice_mean(s : GeointersecttriangleSlice) -> Double {
  if s.size == 0 { 0.0 } else { geo_intersect_triangle_slice_sum(s) / s.size.to_double() }
}

pub fn geo_intersect_triangle_slice_scale(s : GeointersecttriangleSlice, f : Double) -> GeointersecttriangleSlice {
  let result = geo_intersect_triangle_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_intersect_triangle_slice_add(a : GeointersecttriangleSlice, b : GeointersecttriangleSlice) -> GeointersecttriangleSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_intersect_triangle_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_intersect_triangle_slice_copy(s : GeointersecttriangleSlice) -> GeointersecttriangleSlice {
  let result = geo_intersect_triangle_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_intersect_triangle_slice_fill(s : GeointersecttriangleSlice, v : Double) -> GeointersecttriangleSlice {
  let result = geo_intersect_triangle_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_triangle_slice_min(s : GeointersecttriangleSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_triangle_slice_max(s : GeointersecttriangleSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_triangle_slice_to_string(s : GeointersecttriangleSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn geo_intersect_triangle_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_intersect_triangle_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_intersect_triangle_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_intersect_triangle_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_intersect_triangle_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_intersect_triangle_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_intersect_triangle_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_intersect_triangle_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_intersect_triangle_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_intersect_triangle_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_intersect_triangle_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_intersect_triangle_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_intersect_triangle_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_intersect_triangle_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_intersect_triangle_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_intersect_triangle_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_intersect_triangle_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_intersect_triangle_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_intersect_triangle_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_intersect_triangle_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_intersect_triangle_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_intersect_triangle_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_intersect_triangle_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_intersect_triangle_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_intersect_triangle_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

