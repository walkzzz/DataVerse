///===
/// extcore/geo_intersect_ray

pub(all) struct GeointersectrayPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn geo_intersect_ray_make_point(x : Double, y : Double) -> GeointersectrayPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn geo_intersect_ray_make_point3(x : Double, y : Double, z : Double) -> GeointersectrayPoint {
  { x, y, z, label: 0 }
}

pub fn geo_intersect_ray_point_x(pt : GeointersectrayPoint) -> Double { pt.x }

pub fn geo_intersect_ray_point_y(pt : GeointersectrayPoint) -> Double { pt.y }

pub fn geo_intersect_ray_point_z(pt : GeointersectrayPoint) -> Double { pt.z }

pub fn geo_intersect_ray_point_label(pt : GeointersectrayPoint) -> Int { pt.label }

pub fn geo_intersect_ray_point_dist(a : GeointersectrayPoint, b : GeointersectrayPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  geo_intersect_ray_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn geo_intersect_ray_point_add(a : GeointersectrayPoint, b : GeointersectrayPoint) -> GeointersectrayPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn geo_intersect_ray_point_sub(a : GeointersectrayPoint, b : GeointersectrayPoint) -> GeointersectrayPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn geo_intersect_ray_point_scale(pt : GeointersectrayPoint, s : Double) -> GeointersectrayPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn geo_intersect_ray_point_dot(a : GeointersectrayPoint, b : GeointersectrayPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn geo_intersect_ray_point_cross(a : GeointersectrayPoint, b : GeointersectrayPoint) -> GeointersectrayPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn geo_intersect_ray_point_norm(pt : GeointersectrayPoint) -> Double {
  geo_intersect_ray_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn geo_intersect_ray_point_normalize(pt : GeointersectrayPoint) -> GeointersectrayPoint {
  let n = geo_intersect_ray_point_norm(pt)
  if n < 0.0000001 { pt } else { geo_intersect_ray_point_scale(pt, 1.0 / n) }
}

pub fn geo_intersect_ray_point_negate(pt : GeointersectrayPoint) -> GeointersectrayPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn geo_intersect_ray_point_mid(a : GeointersectrayPoint, b : GeointersectrayPoint) -> GeointersectrayPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn geo_intersect_ray_point_lerp(a : GeointersectrayPoint, b : GeointersectrayPoint, t : Double) -> GeointersectrayPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn geo_intersect_ray_point_to_string(pt : GeointersectrayPoint) -> String {
  "(" + geo_intersect_ray_dbl(pt.x) + ", " + geo_intersect_ray_dbl(pt.y) + ", " + geo_intersect_ray_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct GeointersectraySeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn geo_intersect_ray_make_series(vals : Array[Double], name : String) -> GeointersectraySeries {
  { vals, name, meta: 0 }
}

pub fn geo_intersect_ray_series_len(s : GeointersectraySeries) -> Int { s.vals.length() }

pub fn geo_intersect_ray_series_sum(s : GeointersectraySeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn geo_intersect_ray_series_mean(s : GeointersectraySeries) -> Double {
  let n = geo_intersect_ray_series_len(s)
  if n == 0 { 0.0 } else { geo_intersect_ray_series_sum(s) / n.to_double() }
}

pub fn geo_intersect_ray_series_min(s : GeointersectraySeries) -> Double {
  let n = geo_intersect_ray_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn geo_intersect_ray_series_max(s : GeointersectraySeries) -> Double {
  let n = geo_intersect_ray_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn geo_intersect_ray_series_range(s : GeointersectraySeries) -> Double {
  geo_intersect_ray_series_max(s) - geo_intersect_ray_series_min(s)
}

pub fn geo_intersect_ray_series_var(s : GeointersectraySeries) -> Double {
  let n = geo_intersect_ray_series_len(s)
  if n == 0 { 0.0 } else {
    let m = geo_intersect_ray_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn geo_intersect_ray_series_std(s : GeointersectraySeries) -> Double { geo_intersect_ray_sqrt(geo_intersect_ray_series_var(s)) }

pub fn geo_intersect_ray_series_median(s : GeointersectraySeries) -> Double {
  let n = geo_intersect_ray_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = geo_intersect_ray_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn geo_intersect_ray_series_scale(s : GeointersectraySeries, f : Double) -> GeointersectraySeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = geo_intersect_ray_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn geo_intersect_ray_series_add(a : GeointersectraySeries, b : GeointersectraySeries) -> GeointersectraySeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = geo_intersect_ray_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn geo_intersect_ray_series_sub(a : GeointersectraySeries, b : GeointersectraySeries) -> GeointersectraySeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = geo_intersect_ray_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn geo_intersect_ray_series_normalize(s : GeointersectraySeries) -> GeointersectraySeries {
  let mn = geo_intersect_ray_series_min(s)
  let mx = geo_intersect_ray_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = geo_intersect_ray_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn geo_intersect_ray_series_cumsum(s : GeointersectraySeries) -> GeointersectraySeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = geo_intersect_ray_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn geo_intersect_ray_series_to_string(s : GeointersectraySeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + geo_intersect_ray_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GeointersectrayMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn geo_intersect_ray_make_matrix(rows : Int, cols : Int, val : Double) -> GeointersectrayMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn geo_intersect_ray_matrix_identity(n : Int) -> GeointersectrayMatrix {
  let m = geo_intersect_ray_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn geo_intersect_ray_matrix_get(m : GeointersectrayMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn geo_intersect_ray_matrix_transpose(m : GeointersectrayMatrix) -> GeointersectrayMatrix {
  let result = geo_intersect_ray_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn geo_intersect_ray_matrix_add(a : GeointersectrayMatrix, b : GeointersectrayMatrix) -> GeointersectrayMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = geo_intersect_ray_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn geo_intersect_ray_matrix_scale(m : GeointersectrayMatrix, s : Double) -> GeointersectrayMatrix {
  let result = geo_intersect_ray_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn geo_intersect_ray_matrix_multiply(a : GeointersectrayMatrix, b : GeointersectrayMatrix) -> GeointersectrayMatrix {
  if a.cols != b.rows { return geo_intersect_ray_make_matrix(a.rows, b.cols, 0.0) }
  let result = geo_intersect_ray_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn geo_intersect_ray_matrix_trace(m : GeointersectrayMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn geo_intersect_ray_matrix_det(m : GeointersectrayMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn geo_intersect_ray_matrix_norm(m : GeointersectrayMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  geo_intersect_ray_sqrt(sum)
}

pub fn geo_intersect_ray_matrix_to_string(m : GeointersectrayMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + geo_intersect_ray_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct GeointersectrayVector {
  comps : Array[Double]
  dim : Int
}

pub fn geo_intersect_ray_make_vector(comps : Array[Double]) -> GeointersectrayVector {
  { comps, dim: comps.length() }
}

pub fn geo_intersect_ray_vector_zero(dim : Int) -> GeointersectrayVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn geo_intersect_ray_vector_add(a : GeointersectrayVector, b : GeointersectrayVector) -> GeointersectrayVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = geo_intersect_ray_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn geo_intersect_ray_vector_sub(a : GeointersectrayVector, b : GeointersectrayVector) -> GeointersectrayVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = geo_intersect_ray_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn geo_intersect_ray_vector_scale(v : GeointersectrayVector, s : Double) -> GeointersectrayVector {
  let mut result = []
  for i in 0..<v.dim { result = geo_intersect_ray_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn geo_intersect_ray_vector_dot(a : GeointersectrayVector, b : GeointersectrayVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn geo_intersect_ray_vector_norm(v : GeointersectrayVector) -> Double { geo_intersect_ray_sqrt(geo_intersect_ray_vector_dot(v, v)) }

pub fn geo_intersect_ray_vector_normalize(v : GeointersectrayVector) -> GeointersectrayVector {
  let n = geo_intersect_ray_vector_norm(v)
  if n < 0.0000001 { v } else { geo_intersect_ray_vector_scale(v, 1.0 / n) }
}

pub fn geo_intersect_ray_vector_dist(a : GeointersectrayVector, b : GeointersectrayVector) -> Double {
  geo_intersect_ray_vector_norm(geo_intersect_ray_vector_sub(a, b))
}

pub fn geo_intersect_ray_vector_to_string(v : GeointersectrayVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + geo_intersect_ray_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn geo_intersect_ray_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn geo_intersect_ray_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = geo_intersect_ray_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn geo_intersect_ray_std(data : Array[Double]) -> Double { geo_intersect_ray_sqrt(geo_intersect_ray_var(data)) }

pub fn geo_intersect_ray_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = geo_intersect_ray_mean(a); let mb = geo_intersect_ray_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn geo_intersect_ray_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = geo_intersect_ray_std(a); let sb = geo_intersect_ray_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { geo_intersect_ray_cov(a, b) / (sa * sb) }
}

pub fn geo_intersect_ray_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = geo_intersect_ray_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn geo_intersect_ray_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn geo_intersect_ray_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn geo_intersect_ray_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  geo_intersect_ray_sqrt(geo_intersect_ray_mse(pred, labels))
}

pub fn geo_intersect_ray_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + geo_intersect_ray_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn geo_intersect_ray_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = geo_intersect_ray_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn geo_intersect_ray_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn geo_intersect_ray_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn geo_intersect_ray_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = geo_intersect_ray_precision(pred, labels, pos); let r = geo_intersect_ray_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn geo_intersect_ray_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn geo_intersect_ray_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = geo_intersect_ray_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn geo_intersect_ray_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn geo_intersect_ray_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn geo_intersect_ray_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = geo_intersect_ray_gcd(a, b)
    (a / g) * b
  }
}

pub fn geo_intersect_ray_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn geo_intersect_ray_fibonacci(n : Int) -> Int {
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

pub fn geo_intersect_ray_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = geo_intersect_ray_min(data); let mx = geo_intersect_ray_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn geo_intersect_ray_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = geo_intersect_ray_mean(data); let sd = geo_intersect_ray_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn geo_intersect_ray_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn geo_intersect_ray_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn geo_intersect_ray_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn geo_intersect_ray_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn geo_intersect_ray_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn geo_intersect_ray_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn geo_intersect_ray_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn geo_intersect_ray_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn geo_intersect_ray_dbl(x : Double) -> String {
  let i = if x >= 0.0 { geo_intersect_ray_int(x) } else { -geo_intersect_ray_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { geo_intersect_ray_int(f * 1000000.0) } else { geo_intersect_ray_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn geo_intersect_ray_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn geo_intersect_ray_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct GeointersectrayFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_ray_frame_make(size : Int) -> GeointersectrayFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_ray_frame_len(s : GeointersectrayFrame) -> Int { s.size }

pub fn geo_intersect_ray_frame_get(s : GeointersectrayFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_ray_frame_set(s : GeointersectrayFrame, i : Int, v : Double) -> GeointersectrayFrame {
  let result = geo_intersect_ray_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_ray_frame_sum(s : GeointersectrayFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_intersect_ray_frame_mean(s : GeointersectrayFrame) -> Double {
  if s.size == 0 { 0.0 } else { geo_intersect_ray_frame_sum(s) / s.size.to_double() }
}

pub fn geo_intersect_ray_frame_scale(s : GeointersectrayFrame, f : Double) -> GeointersectrayFrame {
  let result = geo_intersect_ray_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_intersect_ray_frame_add(a : GeointersectrayFrame, b : GeointersectrayFrame) -> GeointersectrayFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_intersect_ray_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_intersect_ray_frame_copy(s : GeointersectrayFrame) -> GeointersectrayFrame {
  let result = geo_intersect_ray_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_intersect_ray_frame_fill(s : GeointersectrayFrame, v : Double) -> GeointersectrayFrame {
  let result = geo_intersect_ray_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_ray_frame_min(s : GeointersectrayFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_ray_frame_max(s : GeointersectrayFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_ray_frame_to_string(s : GeointersectrayFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectrayTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_ray_table_make(size : Int) -> GeointersectrayTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_ray_table_len(s : GeointersectrayTable) -> Int { s.size }

pub fn geo_intersect_ray_table_get(s : GeointersectrayTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_ray_table_set(s : GeointersectrayTable, i : Int, v : Double) -> GeointersectrayTable {
  let result = geo_intersect_ray_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_ray_table_sum(s : GeointersectrayTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_intersect_ray_table_mean(s : GeointersectrayTable) -> Double {
  if s.size == 0 { 0.0 } else { geo_intersect_ray_table_sum(s) / s.size.to_double() }
}

pub fn geo_intersect_ray_table_scale(s : GeointersectrayTable, f : Double) -> GeointersectrayTable {
  let result = geo_intersect_ray_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_intersect_ray_table_add(a : GeointersectrayTable, b : GeointersectrayTable) -> GeointersectrayTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_intersect_ray_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_intersect_ray_table_copy(s : GeointersectrayTable) -> GeointersectrayTable {
  let result = geo_intersect_ray_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_intersect_ray_table_fill(s : GeointersectrayTable, v : Double) -> GeointersectrayTable {
  let result = geo_intersect_ray_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_ray_table_min(s : GeointersectrayTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_ray_table_max(s : GeointersectrayTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_ray_table_to_string(s : GeointersectrayTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectrayGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_ray_graphn_make(size : Int) -> GeointersectrayGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_ray_graphn_len(s : GeointersectrayGraphN) -> Int { s.size }

pub fn geo_intersect_ray_graphn_get(s : GeointersectrayGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_ray_graphn_set(s : GeointersectrayGraphN, i : Int, v : Double) -> GeointersectrayGraphN {
  let result = geo_intersect_ray_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_ray_graphn_sum(s : GeointersectrayGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_intersect_ray_graphn_mean(s : GeointersectrayGraphN) -> Double {
  if s.size == 0 { 0.0 } else { geo_intersect_ray_graphn_sum(s) / s.size.to_double() }
}

pub fn geo_intersect_ray_graphn_scale(s : GeointersectrayGraphN, f : Double) -> GeointersectrayGraphN {
  let result = geo_intersect_ray_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_intersect_ray_graphn_add(a : GeointersectrayGraphN, b : GeointersectrayGraphN) -> GeointersectrayGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_intersect_ray_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_intersect_ray_graphn_copy(s : GeointersectrayGraphN) -> GeointersectrayGraphN {
  let result = geo_intersect_ray_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_intersect_ray_graphn_fill(s : GeointersectrayGraphN, v : Double) -> GeointersectrayGraphN {
  let result = geo_intersect_ray_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_ray_graphn_min(s : GeointersectrayGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_ray_graphn_max(s : GeointersectrayGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_ray_graphn_to_string(s : GeointersectrayGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectrayNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_ray_node_make(size : Int) -> GeointersectrayNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_ray_node_len(s : GeointersectrayNode) -> Int { s.size }

pub fn geo_intersect_ray_node_get(s : GeointersectrayNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_ray_node_set(s : GeointersectrayNode, i : Int, v : Double) -> GeointersectrayNode {
  let result = geo_intersect_ray_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_ray_node_sum(s : GeointersectrayNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_intersect_ray_node_mean(s : GeointersectrayNode) -> Double {
  if s.size == 0 { 0.0 } else { geo_intersect_ray_node_sum(s) / s.size.to_double() }
}

pub fn geo_intersect_ray_node_scale(s : GeointersectrayNode, f : Double) -> GeointersectrayNode {
  let result = geo_intersect_ray_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_intersect_ray_node_add(a : GeointersectrayNode, b : GeointersectrayNode) -> GeointersectrayNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_intersect_ray_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_intersect_ray_node_copy(s : GeointersectrayNode) -> GeointersectrayNode {
  let result = geo_intersect_ray_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_intersect_ray_node_fill(s : GeointersectrayNode, v : Double) -> GeointersectrayNode {
  let result = geo_intersect_ray_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_ray_node_min(s : GeointersectrayNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_ray_node_max(s : GeointersectrayNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_ray_node_to_string(s : GeointersectrayNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectrayEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_ray_edge_make(size : Int) -> GeointersectrayEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_ray_edge_len(s : GeointersectrayEdge) -> Int { s.size }

pub fn geo_intersect_ray_edge_get(s : GeointersectrayEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_ray_edge_set(s : GeointersectrayEdge, i : Int, v : Double) -> GeointersectrayEdge {
  let result = geo_intersect_ray_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_ray_edge_sum(s : GeointersectrayEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_intersect_ray_edge_mean(s : GeointersectrayEdge) -> Double {
  if s.size == 0 { 0.0 } else { geo_intersect_ray_edge_sum(s) / s.size.to_double() }
}

pub fn geo_intersect_ray_edge_scale(s : GeointersectrayEdge, f : Double) -> GeointersectrayEdge {
  let result = geo_intersect_ray_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_intersect_ray_edge_add(a : GeointersectrayEdge, b : GeointersectrayEdge) -> GeointersectrayEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_intersect_ray_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_intersect_ray_edge_copy(s : GeointersectrayEdge) -> GeointersectrayEdge {
  let result = geo_intersect_ray_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_intersect_ray_edge_fill(s : GeointersectrayEdge, v : Double) -> GeointersectrayEdge {
  let result = geo_intersect_ray_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_ray_edge_min(s : GeointersectrayEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_ray_edge_max(s : GeointersectrayEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_ray_edge_to_string(s : GeointersectrayEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectrayPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_ray_path_make(size : Int) -> GeointersectrayPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_ray_path_len(s : GeointersectrayPath) -> Int { s.size }

pub fn geo_intersect_ray_path_get(s : GeointersectrayPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_ray_path_set(s : GeointersectrayPath, i : Int, v : Double) -> GeointersectrayPath {
  let result = geo_intersect_ray_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_ray_path_sum(s : GeointersectrayPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_intersect_ray_path_mean(s : GeointersectrayPath) -> Double {
  if s.size == 0 { 0.0 } else { geo_intersect_ray_path_sum(s) / s.size.to_double() }
}

pub fn geo_intersect_ray_path_scale(s : GeointersectrayPath, f : Double) -> GeointersectrayPath {
  let result = geo_intersect_ray_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_intersect_ray_path_add(a : GeointersectrayPath, b : GeointersectrayPath) -> GeointersectrayPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_intersect_ray_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_intersect_ray_path_copy(s : GeointersectrayPath) -> GeointersectrayPath {
  let result = geo_intersect_ray_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_intersect_ray_path_fill(s : GeointersectrayPath, v : Double) -> GeointersectrayPath {
  let result = geo_intersect_ray_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_ray_path_min(s : GeointersectrayPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_ray_path_max(s : GeointersectrayPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_ray_path_to_string(s : GeointersectrayPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectrayCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_ray_cluster_make(size : Int) -> GeointersectrayCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_ray_cluster_len(s : GeointersectrayCluster) -> Int { s.size }

pub fn geo_intersect_ray_cluster_get(s : GeointersectrayCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_ray_cluster_set(s : GeointersectrayCluster, i : Int, v : Double) -> GeointersectrayCluster {
  let result = geo_intersect_ray_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_ray_cluster_sum(s : GeointersectrayCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_intersect_ray_cluster_mean(s : GeointersectrayCluster) -> Double {
  if s.size == 0 { 0.0 } else { geo_intersect_ray_cluster_sum(s) / s.size.to_double() }
}

pub fn geo_intersect_ray_cluster_scale(s : GeointersectrayCluster, f : Double) -> GeointersectrayCluster {
  let result = geo_intersect_ray_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_intersect_ray_cluster_add(a : GeointersectrayCluster, b : GeointersectrayCluster) -> GeointersectrayCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_intersect_ray_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_intersect_ray_cluster_copy(s : GeointersectrayCluster) -> GeointersectrayCluster {
  let result = geo_intersect_ray_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_intersect_ray_cluster_fill(s : GeointersectrayCluster, v : Double) -> GeointersectrayCluster {
  let result = geo_intersect_ray_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_ray_cluster_min(s : GeointersectrayCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_ray_cluster_max(s : GeointersectrayCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_ray_cluster_to_string(s : GeointersectrayCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectrayModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_ray_model_make(size : Int) -> GeointersectrayModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_ray_model_len(s : GeointersectrayModel) -> Int { s.size }

pub fn geo_intersect_ray_model_get(s : GeointersectrayModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_ray_model_set(s : GeointersectrayModel, i : Int, v : Double) -> GeointersectrayModel {
  let result = geo_intersect_ray_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_ray_model_sum(s : GeointersectrayModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_intersect_ray_model_mean(s : GeointersectrayModel) -> Double {
  if s.size == 0 { 0.0 } else { geo_intersect_ray_model_sum(s) / s.size.to_double() }
}

pub fn geo_intersect_ray_model_scale(s : GeointersectrayModel, f : Double) -> GeointersectrayModel {
  let result = geo_intersect_ray_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_intersect_ray_model_add(a : GeointersectrayModel, b : GeointersectrayModel) -> GeointersectrayModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_intersect_ray_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_intersect_ray_model_copy(s : GeointersectrayModel) -> GeointersectrayModel {
  let result = geo_intersect_ray_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_intersect_ray_model_fill(s : GeointersectrayModel, v : Double) -> GeointersectrayModel {
  let result = geo_intersect_ray_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_ray_model_min(s : GeointersectrayModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_ray_model_max(s : GeointersectrayModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_ray_model_to_string(s : GeointersectrayModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectrayLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_ray_layer_make(size : Int) -> GeointersectrayLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_ray_layer_len(s : GeointersectrayLayer) -> Int { s.size }

pub fn geo_intersect_ray_layer_get(s : GeointersectrayLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_ray_layer_set(s : GeointersectrayLayer, i : Int, v : Double) -> GeointersectrayLayer {
  let result = geo_intersect_ray_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_ray_layer_sum(s : GeointersectrayLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_intersect_ray_layer_mean(s : GeointersectrayLayer) -> Double {
  if s.size == 0 { 0.0 } else { geo_intersect_ray_layer_sum(s) / s.size.to_double() }
}

pub fn geo_intersect_ray_layer_scale(s : GeointersectrayLayer, f : Double) -> GeointersectrayLayer {
  let result = geo_intersect_ray_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_intersect_ray_layer_add(a : GeointersectrayLayer, b : GeointersectrayLayer) -> GeointersectrayLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_intersect_ray_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_intersect_ray_layer_copy(s : GeointersectrayLayer) -> GeointersectrayLayer {
  let result = geo_intersect_ray_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_intersect_ray_layer_fill(s : GeointersectrayLayer, v : Double) -> GeointersectrayLayer {
  let result = geo_intersect_ray_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_ray_layer_min(s : GeointersectrayLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_ray_layer_max(s : GeointersectrayLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_ray_layer_to_string(s : GeointersectrayLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectrayBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_ray_buffer_make(size : Int) -> GeointersectrayBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_ray_buffer_len(s : GeointersectrayBuffer) -> Int { s.size }

pub fn geo_intersect_ray_buffer_get(s : GeointersectrayBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_ray_buffer_set(s : GeointersectrayBuffer, i : Int, v : Double) -> GeointersectrayBuffer {
  let result = geo_intersect_ray_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_ray_buffer_sum(s : GeointersectrayBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_intersect_ray_buffer_mean(s : GeointersectrayBuffer) -> Double {
  if s.size == 0 { 0.0 } else { geo_intersect_ray_buffer_sum(s) / s.size.to_double() }
}

pub fn geo_intersect_ray_buffer_scale(s : GeointersectrayBuffer, f : Double) -> GeointersectrayBuffer {
  let result = geo_intersect_ray_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_intersect_ray_buffer_add(a : GeointersectrayBuffer, b : GeointersectrayBuffer) -> GeointersectrayBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_intersect_ray_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_intersect_ray_buffer_copy(s : GeointersectrayBuffer) -> GeointersectrayBuffer {
  let result = geo_intersect_ray_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_intersect_ray_buffer_fill(s : GeointersectrayBuffer, v : Double) -> GeointersectrayBuffer {
  let result = geo_intersect_ray_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_ray_buffer_min(s : GeointersectrayBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_ray_buffer_max(s : GeointersectrayBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_ray_buffer_to_string(s : GeointersectrayBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectrayCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_ray_cursor_make(size : Int) -> GeointersectrayCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_ray_cursor_len(s : GeointersectrayCursor) -> Int { s.size }

pub fn geo_intersect_ray_cursor_get(s : GeointersectrayCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_ray_cursor_set(s : GeointersectrayCursor, i : Int, v : Double) -> GeointersectrayCursor {
  let result = geo_intersect_ray_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_ray_cursor_sum(s : GeointersectrayCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_intersect_ray_cursor_mean(s : GeointersectrayCursor) -> Double {
  if s.size == 0 { 0.0 } else { geo_intersect_ray_cursor_sum(s) / s.size.to_double() }
}

pub fn geo_intersect_ray_cursor_scale(s : GeointersectrayCursor, f : Double) -> GeointersectrayCursor {
  let result = geo_intersect_ray_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_intersect_ray_cursor_add(a : GeointersectrayCursor, b : GeointersectrayCursor) -> GeointersectrayCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_intersect_ray_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_intersect_ray_cursor_copy(s : GeointersectrayCursor) -> GeointersectrayCursor {
  let result = geo_intersect_ray_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_intersect_ray_cursor_fill(s : GeointersectrayCursor, v : Double) -> GeointersectrayCursor {
  let result = geo_intersect_ray_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_ray_cursor_min(s : GeointersectrayCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_ray_cursor_max(s : GeointersectrayCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_ray_cursor_to_string(s : GeointersectrayCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectrayView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_ray_view_make(size : Int) -> GeointersectrayView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_ray_view_len(s : GeointersectrayView) -> Int { s.size }

pub fn geo_intersect_ray_view_get(s : GeointersectrayView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_ray_view_set(s : GeointersectrayView, i : Int, v : Double) -> GeointersectrayView {
  let result = geo_intersect_ray_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_ray_view_sum(s : GeointersectrayView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_intersect_ray_view_mean(s : GeointersectrayView) -> Double {
  if s.size == 0 { 0.0 } else { geo_intersect_ray_view_sum(s) / s.size.to_double() }
}

pub fn geo_intersect_ray_view_scale(s : GeointersectrayView, f : Double) -> GeointersectrayView {
  let result = geo_intersect_ray_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_intersect_ray_view_add(a : GeointersectrayView, b : GeointersectrayView) -> GeointersectrayView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_intersect_ray_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_intersect_ray_view_copy(s : GeointersectrayView) -> GeointersectrayView {
  let result = geo_intersect_ray_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_intersect_ray_view_fill(s : GeointersectrayView, v : Double) -> GeointersectrayView {
  let result = geo_intersect_ray_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_ray_view_min(s : GeointersectrayView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_ray_view_max(s : GeointersectrayView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_ray_view_to_string(s : GeointersectrayView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectrayRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_ray_range_make(size : Int) -> GeointersectrayRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_ray_range_len(s : GeointersectrayRange) -> Int { s.size }

pub fn geo_intersect_ray_range_get(s : GeointersectrayRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_ray_range_set(s : GeointersectrayRange, i : Int, v : Double) -> GeointersectrayRange {
  let result = geo_intersect_ray_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_ray_range_sum(s : GeointersectrayRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_intersect_ray_range_mean(s : GeointersectrayRange) -> Double {
  if s.size == 0 { 0.0 } else { geo_intersect_ray_range_sum(s) / s.size.to_double() }
}

pub fn geo_intersect_ray_range_scale(s : GeointersectrayRange, f : Double) -> GeointersectrayRange {
  let result = geo_intersect_ray_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_intersect_ray_range_add(a : GeointersectrayRange, b : GeointersectrayRange) -> GeointersectrayRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_intersect_ray_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_intersect_ray_range_copy(s : GeointersectrayRange) -> GeointersectrayRange {
  let result = geo_intersect_ray_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_intersect_ray_range_fill(s : GeointersectrayRange, v : Double) -> GeointersectrayRange {
  let result = geo_intersect_ray_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_ray_range_min(s : GeointersectrayRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_ray_range_max(s : GeointersectrayRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_ray_range_to_string(s : GeointersectrayRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectraySlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_ray_slice_make(size : Int) -> GeointersectraySlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_ray_slice_len(s : GeointersectraySlice) -> Int { s.size }

pub fn geo_intersect_ray_slice_get(s : GeointersectraySlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_ray_slice_set(s : GeointersectraySlice, i : Int, v : Double) -> GeointersectraySlice {
  let result = geo_intersect_ray_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_ray_slice_sum(s : GeointersectraySlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_intersect_ray_slice_mean(s : GeointersectraySlice) -> Double {
  if s.size == 0 { 0.0 } else { geo_intersect_ray_slice_sum(s) / s.size.to_double() }
}

pub fn geo_intersect_ray_slice_scale(s : GeointersectraySlice, f : Double) -> GeointersectraySlice {
  let result = geo_intersect_ray_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_intersect_ray_slice_add(a : GeointersectraySlice, b : GeointersectraySlice) -> GeointersectraySlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_intersect_ray_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_intersect_ray_slice_copy(s : GeointersectraySlice) -> GeointersectraySlice {
  let result = geo_intersect_ray_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_intersect_ray_slice_fill(s : GeointersectraySlice, v : Double) -> GeointersectraySlice {
  let result = geo_intersect_ray_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_ray_slice_min(s : GeointersectraySlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_ray_slice_max(s : GeointersectraySlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_ray_slice_to_string(s : GeointersectraySlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn geo_intersect_ray_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_intersect_ray_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_intersect_ray_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_intersect_ray_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_intersect_ray_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_intersect_ray_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_intersect_ray_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_intersect_ray_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_intersect_ray_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_intersect_ray_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_intersect_ray_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_intersect_ray_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_intersect_ray_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_intersect_ray_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_intersect_ray_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_intersect_ray_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_intersect_ray_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_intersect_ray_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_intersect_ray_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_intersect_ray_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_intersect_ray_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_intersect_ray_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_intersect_ray_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_intersect_ray_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_intersect_ray_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

