///===
/// extcore/geo_dist_vincenty

pub(all) struct GeodistvincentyPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn geo_dist_vincenty_make_point(x : Double, y : Double) -> GeodistvincentyPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn geo_dist_vincenty_make_point3(x : Double, y : Double, z : Double) -> GeodistvincentyPoint {
  { x, y, z, label: 0 }
}

pub fn geo_dist_vincenty_point_x(pt : GeodistvincentyPoint) -> Double { pt.x }

pub fn geo_dist_vincenty_point_y(pt : GeodistvincentyPoint) -> Double { pt.y }

pub fn geo_dist_vincenty_point_z(pt : GeodistvincentyPoint) -> Double { pt.z }

pub fn geo_dist_vincenty_point_label(pt : GeodistvincentyPoint) -> Int { pt.label }

pub fn geo_dist_vincenty_point_dist(a : GeodistvincentyPoint, b : GeodistvincentyPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  geo_dist_vincenty_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn geo_dist_vincenty_point_add(a : GeodistvincentyPoint, b : GeodistvincentyPoint) -> GeodistvincentyPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn geo_dist_vincenty_point_sub(a : GeodistvincentyPoint, b : GeodistvincentyPoint) -> GeodistvincentyPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn geo_dist_vincenty_point_scale(pt : GeodistvincentyPoint, s : Double) -> GeodistvincentyPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn geo_dist_vincenty_point_dot(a : GeodistvincentyPoint, b : GeodistvincentyPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn geo_dist_vincenty_point_cross(a : GeodistvincentyPoint, b : GeodistvincentyPoint) -> GeodistvincentyPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn geo_dist_vincenty_point_norm(pt : GeodistvincentyPoint) -> Double {
  geo_dist_vincenty_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn geo_dist_vincenty_point_normalize(pt : GeodistvincentyPoint) -> GeodistvincentyPoint {
  let n = geo_dist_vincenty_point_norm(pt)
  if n < 0.0000001 { pt } else { geo_dist_vincenty_point_scale(pt, 1.0 / n) }
}

pub fn geo_dist_vincenty_point_negate(pt : GeodistvincentyPoint) -> GeodistvincentyPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn geo_dist_vincenty_point_mid(a : GeodistvincentyPoint, b : GeodistvincentyPoint) -> GeodistvincentyPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn geo_dist_vincenty_point_lerp(a : GeodistvincentyPoint, b : GeodistvincentyPoint, t : Double) -> GeodistvincentyPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn geo_dist_vincenty_point_to_string(pt : GeodistvincentyPoint) -> String {
  "(" + geo_dist_vincenty_dbl(pt.x) + ", " + geo_dist_vincenty_dbl(pt.y) + ", " + geo_dist_vincenty_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct GeodistvincentySeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn geo_dist_vincenty_make_series(vals : Array[Double], name : String) -> GeodistvincentySeries {
  { vals, name, meta: 0 }
}

pub fn geo_dist_vincenty_series_len(s : GeodistvincentySeries) -> Int { s.vals.length() }

pub fn geo_dist_vincenty_series_sum(s : GeodistvincentySeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn geo_dist_vincenty_series_mean(s : GeodistvincentySeries) -> Double {
  let n = geo_dist_vincenty_series_len(s)
  if n == 0 { 0.0 } else { geo_dist_vincenty_series_sum(s) / n.to_double() }
}

pub fn geo_dist_vincenty_series_min(s : GeodistvincentySeries) -> Double {
  let n = geo_dist_vincenty_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn geo_dist_vincenty_series_max(s : GeodistvincentySeries) -> Double {
  let n = geo_dist_vincenty_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn geo_dist_vincenty_series_range(s : GeodistvincentySeries) -> Double {
  geo_dist_vincenty_series_max(s) - geo_dist_vincenty_series_min(s)
}

pub fn geo_dist_vincenty_series_var(s : GeodistvincentySeries) -> Double {
  let n = geo_dist_vincenty_series_len(s)
  if n == 0 { 0.0 } else {
    let m = geo_dist_vincenty_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn geo_dist_vincenty_series_std(s : GeodistvincentySeries) -> Double { geo_dist_vincenty_sqrt(geo_dist_vincenty_series_var(s)) }

pub fn geo_dist_vincenty_series_median(s : GeodistvincentySeries) -> Double {
  let n = geo_dist_vincenty_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = geo_dist_vincenty_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn geo_dist_vincenty_series_scale(s : GeodistvincentySeries, f : Double) -> GeodistvincentySeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = geo_dist_vincenty_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn geo_dist_vincenty_series_add(a : GeodistvincentySeries, b : GeodistvincentySeries) -> GeodistvincentySeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = geo_dist_vincenty_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn geo_dist_vincenty_series_sub(a : GeodistvincentySeries, b : GeodistvincentySeries) -> GeodistvincentySeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = geo_dist_vincenty_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn geo_dist_vincenty_series_normalize(s : GeodistvincentySeries) -> GeodistvincentySeries {
  let mn = geo_dist_vincenty_series_min(s)
  let mx = geo_dist_vincenty_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = geo_dist_vincenty_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn geo_dist_vincenty_series_cumsum(s : GeodistvincentySeries) -> GeodistvincentySeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = geo_dist_vincenty_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn geo_dist_vincenty_series_to_string(s : GeodistvincentySeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + geo_dist_vincenty_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GeodistvincentyMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn geo_dist_vincenty_make_matrix(rows : Int, cols : Int, val : Double) -> GeodistvincentyMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn geo_dist_vincenty_matrix_identity(n : Int) -> GeodistvincentyMatrix {
  let m = geo_dist_vincenty_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn geo_dist_vincenty_matrix_get(m : GeodistvincentyMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn geo_dist_vincenty_matrix_transpose(m : GeodistvincentyMatrix) -> GeodistvincentyMatrix {
  let result = geo_dist_vincenty_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn geo_dist_vincenty_matrix_add(a : GeodistvincentyMatrix, b : GeodistvincentyMatrix) -> GeodistvincentyMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = geo_dist_vincenty_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn geo_dist_vincenty_matrix_scale(m : GeodistvincentyMatrix, s : Double) -> GeodistvincentyMatrix {
  let result = geo_dist_vincenty_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn geo_dist_vincenty_matrix_multiply(a : GeodistvincentyMatrix, b : GeodistvincentyMatrix) -> GeodistvincentyMatrix {
  if a.cols != b.rows { return geo_dist_vincenty_make_matrix(a.rows, b.cols, 0.0) }
  let result = geo_dist_vincenty_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn geo_dist_vincenty_matrix_trace(m : GeodistvincentyMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn geo_dist_vincenty_matrix_det(m : GeodistvincentyMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn geo_dist_vincenty_matrix_norm(m : GeodistvincentyMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  geo_dist_vincenty_sqrt(sum)
}

pub fn geo_dist_vincenty_matrix_to_string(m : GeodistvincentyMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + geo_dist_vincenty_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct GeodistvincentyVector {
  comps : Array[Double]
  dim : Int
}

pub fn geo_dist_vincenty_make_vector(comps : Array[Double]) -> GeodistvincentyVector {
  { comps, dim: comps.length() }
}

pub fn geo_dist_vincenty_vector_zero(dim : Int) -> GeodistvincentyVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn geo_dist_vincenty_vector_add(a : GeodistvincentyVector, b : GeodistvincentyVector) -> GeodistvincentyVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = geo_dist_vincenty_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn geo_dist_vincenty_vector_sub(a : GeodistvincentyVector, b : GeodistvincentyVector) -> GeodistvincentyVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = geo_dist_vincenty_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn geo_dist_vincenty_vector_scale(v : GeodistvincentyVector, s : Double) -> GeodistvincentyVector {
  let mut result = []
  for i in 0..<v.dim { result = geo_dist_vincenty_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn geo_dist_vincenty_vector_dot(a : GeodistvincentyVector, b : GeodistvincentyVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn geo_dist_vincenty_vector_norm(v : GeodistvincentyVector) -> Double { geo_dist_vincenty_sqrt(geo_dist_vincenty_vector_dot(v, v)) }

pub fn geo_dist_vincenty_vector_normalize(v : GeodistvincentyVector) -> GeodistvincentyVector {
  let n = geo_dist_vincenty_vector_norm(v)
  if n < 0.0000001 { v } else { geo_dist_vincenty_vector_scale(v, 1.0 / n) }
}

pub fn geo_dist_vincenty_vector_dist(a : GeodistvincentyVector, b : GeodistvincentyVector) -> Double {
  geo_dist_vincenty_vector_norm(geo_dist_vincenty_vector_sub(a, b))
}

pub fn geo_dist_vincenty_vector_to_string(v : GeodistvincentyVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + geo_dist_vincenty_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn geo_dist_vincenty_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn geo_dist_vincenty_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = geo_dist_vincenty_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn geo_dist_vincenty_std(data : Array[Double]) -> Double { geo_dist_vincenty_sqrt(geo_dist_vincenty_var(data)) }

pub fn geo_dist_vincenty_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = geo_dist_vincenty_mean(a); let mb = geo_dist_vincenty_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn geo_dist_vincenty_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = geo_dist_vincenty_std(a); let sb = geo_dist_vincenty_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { geo_dist_vincenty_cov(a, b) / (sa * sb) }
}

pub fn geo_dist_vincenty_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = geo_dist_vincenty_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn geo_dist_vincenty_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn geo_dist_vincenty_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn geo_dist_vincenty_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  geo_dist_vincenty_sqrt(geo_dist_vincenty_mse(pred, labels))
}

pub fn geo_dist_vincenty_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + geo_dist_vincenty_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn geo_dist_vincenty_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = geo_dist_vincenty_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn geo_dist_vincenty_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn geo_dist_vincenty_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn geo_dist_vincenty_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = geo_dist_vincenty_precision(pred, labels, pos); let r = geo_dist_vincenty_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn geo_dist_vincenty_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn geo_dist_vincenty_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = geo_dist_vincenty_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn geo_dist_vincenty_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn geo_dist_vincenty_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn geo_dist_vincenty_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = geo_dist_vincenty_gcd(a, b)
    (a / g) * b
  }
}

pub fn geo_dist_vincenty_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn geo_dist_vincenty_fibonacci(n : Int) -> Int {
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

pub fn geo_dist_vincenty_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = geo_dist_vincenty_min(data); let mx = geo_dist_vincenty_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn geo_dist_vincenty_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = geo_dist_vincenty_mean(data); let sd = geo_dist_vincenty_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn geo_dist_vincenty_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn geo_dist_vincenty_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn geo_dist_vincenty_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn geo_dist_vincenty_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn geo_dist_vincenty_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn geo_dist_vincenty_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn geo_dist_vincenty_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn geo_dist_vincenty_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn geo_dist_vincenty_dbl(x : Double) -> String {
  let i = if x >= 0.0 { geo_dist_vincenty_int(x) } else { -geo_dist_vincenty_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { geo_dist_vincenty_int(f * 1000000.0) } else { geo_dist_vincenty_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn geo_dist_vincenty_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn geo_dist_vincenty_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct GeodistvincentyFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_vincenty_frame_make(size : Int) -> GeodistvincentyFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_vincenty_frame_len(s : GeodistvincentyFrame) -> Int { s.size }

pub fn geo_dist_vincenty_frame_get(s : GeodistvincentyFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_vincenty_frame_set(s : GeodistvincentyFrame, i : Int, v : Double) -> GeodistvincentyFrame {
  let result = geo_dist_vincenty_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_dist_vincenty_frame_sum(s : GeodistvincentyFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_dist_vincenty_frame_mean(s : GeodistvincentyFrame) -> Double {
  if s.size == 0 { 0.0 } else { geo_dist_vincenty_frame_sum(s) / s.size.to_double() }
}

pub fn geo_dist_vincenty_frame_scale(s : GeodistvincentyFrame, f : Double) -> GeodistvincentyFrame {
  let result = geo_dist_vincenty_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_dist_vincenty_frame_add(a : GeodistvincentyFrame, b : GeodistvincentyFrame) -> GeodistvincentyFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_dist_vincenty_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_dist_vincenty_frame_copy(s : GeodistvincentyFrame) -> GeodistvincentyFrame {
  let result = geo_dist_vincenty_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_dist_vincenty_frame_fill(s : GeodistvincentyFrame, v : Double) -> GeodistvincentyFrame {
  let result = geo_dist_vincenty_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_dist_vincenty_frame_min(s : GeodistvincentyFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_vincenty_frame_max(s : GeodistvincentyFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_vincenty_frame_to_string(s : GeodistvincentyFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistvincentyTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_vincenty_table_make(size : Int) -> GeodistvincentyTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_vincenty_table_len(s : GeodistvincentyTable) -> Int { s.size }

pub fn geo_dist_vincenty_table_get(s : GeodistvincentyTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_vincenty_table_set(s : GeodistvincentyTable, i : Int, v : Double) -> GeodistvincentyTable {
  let result = geo_dist_vincenty_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_dist_vincenty_table_sum(s : GeodistvincentyTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_dist_vincenty_table_mean(s : GeodistvincentyTable) -> Double {
  if s.size == 0 { 0.0 } else { geo_dist_vincenty_table_sum(s) / s.size.to_double() }
}

pub fn geo_dist_vincenty_table_scale(s : GeodistvincentyTable, f : Double) -> GeodistvincentyTable {
  let result = geo_dist_vincenty_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_dist_vincenty_table_add(a : GeodistvincentyTable, b : GeodistvincentyTable) -> GeodistvincentyTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_dist_vincenty_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_dist_vincenty_table_copy(s : GeodistvincentyTable) -> GeodistvincentyTable {
  let result = geo_dist_vincenty_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_dist_vincenty_table_fill(s : GeodistvincentyTable, v : Double) -> GeodistvincentyTable {
  let result = geo_dist_vincenty_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_dist_vincenty_table_min(s : GeodistvincentyTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_vincenty_table_max(s : GeodistvincentyTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_vincenty_table_to_string(s : GeodistvincentyTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistvincentyGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_vincenty_graphn_make(size : Int) -> GeodistvincentyGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_vincenty_graphn_len(s : GeodistvincentyGraphN) -> Int { s.size }

pub fn geo_dist_vincenty_graphn_get(s : GeodistvincentyGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_vincenty_graphn_set(s : GeodistvincentyGraphN, i : Int, v : Double) -> GeodistvincentyGraphN {
  let result = geo_dist_vincenty_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_dist_vincenty_graphn_sum(s : GeodistvincentyGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_dist_vincenty_graphn_mean(s : GeodistvincentyGraphN) -> Double {
  if s.size == 0 { 0.0 } else { geo_dist_vincenty_graphn_sum(s) / s.size.to_double() }
}

pub fn geo_dist_vincenty_graphn_scale(s : GeodistvincentyGraphN, f : Double) -> GeodistvincentyGraphN {
  let result = geo_dist_vincenty_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_dist_vincenty_graphn_add(a : GeodistvincentyGraphN, b : GeodistvincentyGraphN) -> GeodistvincentyGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_dist_vincenty_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_dist_vincenty_graphn_copy(s : GeodistvincentyGraphN) -> GeodistvincentyGraphN {
  let result = geo_dist_vincenty_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_dist_vincenty_graphn_fill(s : GeodistvincentyGraphN, v : Double) -> GeodistvincentyGraphN {
  let result = geo_dist_vincenty_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_dist_vincenty_graphn_min(s : GeodistvincentyGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_vincenty_graphn_max(s : GeodistvincentyGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_vincenty_graphn_to_string(s : GeodistvincentyGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistvincentyNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_vincenty_node_make(size : Int) -> GeodistvincentyNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_vincenty_node_len(s : GeodistvincentyNode) -> Int { s.size }

pub fn geo_dist_vincenty_node_get(s : GeodistvincentyNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_vincenty_node_set(s : GeodistvincentyNode, i : Int, v : Double) -> GeodistvincentyNode {
  let result = geo_dist_vincenty_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_dist_vincenty_node_sum(s : GeodistvincentyNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_dist_vincenty_node_mean(s : GeodistvincentyNode) -> Double {
  if s.size == 0 { 0.0 } else { geo_dist_vincenty_node_sum(s) / s.size.to_double() }
}

pub fn geo_dist_vincenty_node_scale(s : GeodistvincentyNode, f : Double) -> GeodistvincentyNode {
  let result = geo_dist_vincenty_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_dist_vincenty_node_add(a : GeodistvincentyNode, b : GeodistvincentyNode) -> GeodistvincentyNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_dist_vincenty_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_dist_vincenty_node_copy(s : GeodistvincentyNode) -> GeodistvincentyNode {
  let result = geo_dist_vincenty_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_dist_vincenty_node_fill(s : GeodistvincentyNode, v : Double) -> GeodistvincentyNode {
  let result = geo_dist_vincenty_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_dist_vincenty_node_min(s : GeodistvincentyNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_vincenty_node_max(s : GeodistvincentyNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_vincenty_node_to_string(s : GeodistvincentyNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistvincentyEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_vincenty_edge_make(size : Int) -> GeodistvincentyEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_vincenty_edge_len(s : GeodistvincentyEdge) -> Int { s.size }

pub fn geo_dist_vincenty_edge_get(s : GeodistvincentyEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_vincenty_edge_set(s : GeodistvincentyEdge, i : Int, v : Double) -> GeodistvincentyEdge {
  let result = geo_dist_vincenty_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_dist_vincenty_edge_sum(s : GeodistvincentyEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_dist_vincenty_edge_mean(s : GeodistvincentyEdge) -> Double {
  if s.size == 0 { 0.0 } else { geo_dist_vincenty_edge_sum(s) / s.size.to_double() }
}

pub fn geo_dist_vincenty_edge_scale(s : GeodistvincentyEdge, f : Double) -> GeodistvincentyEdge {
  let result = geo_dist_vincenty_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_dist_vincenty_edge_add(a : GeodistvincentyEdge, b : GeodistvincentyEdge) -> GeodistvincentyEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_dist_vincenty_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_dist_vincenty_edge_copy(s : GeodistvincentyEdge) -> GeodistvincentyEdge {
  let result = geo_dist_vincenty_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_dist_vincenty_edge_fill(s : GeodistvincentyEdge, v : Double) -> GeodistvincentyEdge {
  let result = geo_dist_vincenty_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_dist_vincenty_edge_min(s : GeodistvincentyEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_vincenty_edge_max(s : GeodistvincentyEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_vincenty_edge_to_string(s : GeodistvincentyEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistvincentyPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_vincenty_path_make(size : Int) -> GeodistvincentyPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_vincenty_path_len(s : GeodistvincentyPath) -> Int { s.size }

pub fn geo_dist_vincenty_path_get(s : GeodistvincentyPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_vincenty_path_set(s : GeodistvincentyPath, i : Int, v : Double) -> GeodistvincentyPath {
  let result = geo_dist_vincenty_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_dist_vincenty_path_sum(s : GeodistvincentyPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_dist_vincenty_path_mean(s : GeodistvincentyPath) -> Double {
  if s.size == 0 { 0.0 } else { geo_dist_vincenty_path_sum(s) / s.size.to_double() }
}

pub fn geo_dist_vincenty_path_scale(s : GeodistvincentyPath, f : Double) -> GeodistvincentyPath {
  let result = geo_dist_vincenty_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_dist_vincenty_path_add(a : GeodistvincentyPath, b : GeodistvincentyPath) -> GeodistvincentyPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_dist_vincenty_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_dist_vincenty_path_copy(s : GeodistvincentyPath) -> GeodistvincentyPath {
  let result = geo_dist_vincenty_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_dist_vincenty_path_fill(s : GeodistvincentyPath, v : Double) -> GeodistvincentyPath {
  let result = geo_dist_vincenty_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_dist_vincenty_path_min(s : GeodistvincentyPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_vincenty_path_max(s : GeodistvincentyPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_vincenty_path_to_string(s : GeodistvincentyPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistvincentyCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_vincenty_cluster_make(size : Int) -> GeodistvincentyCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_vincenty_cluster_len(s : GeodistvincentyCluster) -> Int { s.size }

pub fn geo_dist_vincenty_cluster_get(s : GeodistvincentyCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_vincenty_cluster_set(s : GeodistvincentyCluster, i : Int, v : Double) -> GeodistvincentyCluster {
  let result = geo_dist_vincenty_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_dist_vincenty_cluster_sum(s : GeodistvincentyCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_dist_vincenty_cluster_mean(s : GeodistvincentyCluster) -> Double {
  if s.size == 0 { 0.0 } else { geo_dist_vincenty_cluster_sum(s) / s.size.to_double() }
}

pub fn geo_dist_vincenty_cluster_scale(s : GeodistvincentyCluster, f : Double) -> GeodistvincentyCluster {
  let result = geo_dist_vincenty_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_dist_vincenty_cluster_add(a : GeodistvincentyCluster, b : GeodistvincentyCluster) -> GeodistvincentyCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_dist_vincenty_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_dist_vincenty_cluster_copy(s : GeodistvincentyCluster) -> GeodistvincentyCluster {
  let result = geo_dist_vincenty_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_dist_vincenty_cluster_fill(s : GeodistvincentyCluster, v : Double) -> GeodistvincentyCluster {
  let result = geo_dist_vincenty_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_dist_vincenty_cluster_min(s : GeodistvincentyCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_vincenty_cluster_max(s : GeodistvincentyCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_vincenty_cluster_to_string(s : GeodistvincentyCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistvincentyModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_vincenty_model_make(size : Int) -> GeodistvincentyModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_vincenty_model_len(s : GeodistvincentyModel) -> Int { s.size }

pub fn geo_dist_vincenty_model_get(s : GeodistvincentyModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_vincenty_model_set(s : GeodistvincentyModel, i : Int, v : Double) -> GeodistvincentyModel {
  let result = geo_dist_vincenty_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_dist_vincenty_model_sum(s : GeodistvincentyModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_dist_vincenty_model_mean(s : GeodistvincentyModel) -> Double {
  if s.size == 0 { 0.0 } else { geo_dist_vincenty_model_sum(s) / s.size.to_double() }
}

pub fn geo_dist_vincenty_model_scale(s : GeodistvincentyModel, f : Double) -> GeodistvincentyModel {
  let result = geo_dist_vincenty_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_dist_vincenty_model_add(a : GeodistvincentyModel, b : GeodistvincentyModel) -> GeodistvincentyModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_dist_vincenty_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_dist_vincenty_model_copy(s : GeodistvincentyModel) -> GeodistvincentyModel {
  let result = geo_dist_vincenty_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_dist_vincenty_model_fill(s : GeodistvincentyModel, v : Double) -> GeodistvincentyModel {
  let result = geo_dist_vincenty_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_dist_vincenty_model_min(s : GeodistvincentyModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_vincenty_model_max(s : GeodistvincentyModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_vincenty_model_to_string(s : GeodistvincentyModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistvincentyLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_vincenty_layer_make(size : Int) -> GeodistvincentyLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_vincenty_layer_len(s : GeodistvincentyLayer) -> Int { s.size }

pub fn geo_dist_vincenty_layer_get(s : GeodistvincentyLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_vincenty_layer_set(s : GeodistvincentyLayer, i : Int, v : Double) -> GeodistvincentyLayer {
  let result = geo_dist_vincenty_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_dist_vincenty_layer_sum(s : GeodistvincentyLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_dist_vincenty_layer_mean(s : GeodistvincentyLayer) -> Double {
  if s.size == 0 { 0.0 } else { geo_dist_vincenty_layer_sum(s) / s.size.to_double() }
}

pub fn geo_dist_vincenty_layer_scale(s : GeodistvincentyLayer, f : Double) -> GeodistvincentyLayer {
  let result = geo_dist_vincenty_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_dist_vincenty_layer_add(a : GeodistvincentyLayer, b : GeodistvincentyLayer) -> GeodistvincentyLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_dist_vincenty_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_dist_vincenty_layer_copy(s : GeodistvincentyLayer) -> GeodistvincentyLayer {
  let result = geo_dist_vincenty_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_dist_vincenty_layer_fill(s : GeodistvincentyLayer, v : Double) -> GeodistvincentyLayer {
  let result = geo_dist_vincenty_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_dist_vincenty_layer_min(s : GeodistvincentyLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_vincenty_layer_max(s : GeodistvincentyLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_vincenty_layer_to_string(s : GeodistvincentyLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistvincentyBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_vincenty_buffer_make(size : Int) -> GeodistvincentyBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_vincenty_buffer_len(s : GeodistvincentyBuffer) -> Int { s.size }

pub fn geo_dist_vincenty_buffer_get(s : GeodistvincentyBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_vincenty_buffer_set(s : GeodistvincentyBuffer, i : Int, v : Double) -> GeodistvincentyBuffer {
  let result = geo_dist_vincenty_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_dist_vincenty_buffer_sum(s : GeodistvincentyBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_dist_vincenty_buffer_mean(s : GeodistvincentyBuffer) -> Double {
  if s.size == 0 { 0.0 } else { geo_dist_vincenty_buffer_sum(s) / s.size.to_double() }
}

pub fn geo_dist_vincenty_buffer_scale(s : GeodistvincentyBuffer, f : Double) -> GeodistvincentyBuffer {
  let result = geo_dist_vincenty_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_dist_vincenty_buffer_add(a : GeodistvincentyBuffer, b : GeodistvincentyBuffer) -> GeodistvincentyBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_dist_vincenty_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_dist_vincenty_buffer_copy(s : GeodistvincentyBuffer) -> GeodistvincentyBuffer {
  let result = geo_dist_vincenty_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_dist_vincenty_buffer_fill(s : GeodistvincentyBuffer, v : Double) -> GeodistvincentyBuffer {
  let result = geo_dist_vincenty_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_dist_vincenty_buffer_min(s : GeodistvincentyBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_vincenty_buffer_max(s : GeodistvincentyBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_vincenty_buffer_to_string(s : GeodistvincentyBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistvincentyCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_vincenty_cursor_make(size : Int) -> GeodistvincentyCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_vincenty_cursor_len(s : GeodistvincentyCursor) -> Int { s.size }

pub fn geo_dist_vincenty_cursor_get(s : GeodistvincentyCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_vincenty_cursor_set(s : GeodistvincentyCursor, i : Int, v : Double) -> GeodistvincentyCursor {
  let result = geo_dist_vincenty_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_dist_vincenty_cursor_sum(s : GeodistvincentyCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_dist_vincenty_cursor_mean(s : GeodistvincentyCursor) -> Double {
  if s.size == 0 { 0.0 } else { geo_dist_vincenty_cursor_sum(s) / s.size.to_double() }
}

pub fn geo_dist_vincenty_cursor_scale(s : GeodistvincentyCursor, f : Double) -> GeodistvincentyCursor {
  let result = geo_dist_vincenty_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_dist_vincenty_cursor_add(a : GeodistvincentyCursor, b : GeodistvincentyCursor) -> GeodistvincentyCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_dist_vincenty_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_dist_vincenty_cursor_copy(s : GeodistvincentyCursor) -> GeodistvincentyCursor {
  let result = geo_dist_vincenty_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_dist_vincenty_cursor_fill(s : GeodistvincentyCursor, v : Double) -> GeodistvincentyCursor {
  let result = geo_dist_vincenty_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_dist_vincenty_cursor_min(s : GeodistvincentyCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_vincenty_cursor_max(s : GeodistvincentyCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_vincenty_cursor_to_string(s : GeodistvincentyCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistvincentyView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_vincenty_view_make(size : Int) -> GeodistvincentyView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_vincenty_view_len(s : GeodistvincentyView) -> Int { s.size }

pub fn geo_dist_vincenty_view_get(s : GeodistvincentyView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_vincenty_view_set(s : GeodistvincentyView, i : Int, v : Double) -> GeodistvincentyView {
  let result = geo_dist_vincenty_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_dist_vincenty_view_sum(s : GeodistvincentyView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_dist_vincenty_view_mean(s : GeodistvincentyView) -> Double {
  if s.size == 0 { 0.0 } else { geo_dist_vincenty_view_sum(s) / s.size.to_double() }
}

pub fn geo_dist_vincenty_view_scale(s : GeodistvincentyView, f : Double) -> GeodistvincentyView {
  let result = geo_dist_vincenty_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_dist_vincenty_view_add(a : GeodistvincentyView, b : GeodistvincentyView) -> GeodistvincentyView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_dist_vincenty_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_dist_vincenty_view_copy(s : GeodistvincentyView) -> GeodistvincentyView {
  let result = geo_dist_vincenty_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_dist_vincenty_view_fill(s : GeodistvincentyView, v : Double) -> GeodistvincentyView {
  let result = geo_dist_vincenty_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_dist_vincenty_view_min(s : GeodistvincentyView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_vincenty_view_max(s : GeodistvincentyView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_vincenty_view_to_string(s : GeodistvincentyView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistvincentyRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_vincenty_range_make(size : Int) -> GeodistvincentyRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_vincenty_range_len(s : GeodistvincentyRange) -> Int { s.size }

pub fn geo_dist_vincenty_range_get(s : GeodistvincentyRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_vincenty_range_set(s : GeodistvincentyRange, i : Int, v : Double) -> GeodistvincentyRange {
  let result = geo_dist_vincenty_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_dist_vincenty_range_sum(s : GeodistvincentyRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_dist_vincenty_range_mean(s : GeodistvincentyRange) -> Double {
  if s.size == 0 { 0.0 } else { geo_dist_vincenty_range_sum(s) / s.size.to_double() }
}

pub fn geo_dist_vincenty_range_scale(s : GeodistvincentyRange, f : Double) -> GeodistvincentyRange {
  let result = geo_dist_vincenty_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_dist_vincenty_range_add(a : GeodistvincentyRange, b : GeodistvincentyRange) -> GeodistvincentyRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_dist_vincenty_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_dist_vincenty_range_copy(s : GeodistvincentyRange) -> GeodistvincentyRange {
  let result = geo_dist_vincenty_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_dist_vincenty_range_fill(s : GeodistvincentyRange, v : Double) -> GeodistvincentyRange {
  let result = geo_dist_vincenty_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_dist_vincenty_range_min(s : GeodistvincentyRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_vincenty_range_max(s : GeodistvincentyRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_vincenty_range_to_string(s : GeodistvincentyRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistvincentySlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_vincenty_slice_make(size : Int) -> GeodistvincentySlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_vincenty_slice_len(s : GeodistvincentySlice) -> Int { s.size }

pub fn geo_dist_vincenty_slice_get(s : GeodistvincentySlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_vincenty_slice_set(s : GeodistvincentySlice, i : Int, v : Double) -> GeodistvincentySlice {
  let result = geo_dist_vincenty_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_dist_vincenty_slice_sum(s : GeodistvincentySlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_dist_vincenty_slice_mean(s : GeodistvincentySlice) -> Double {
  if s.size == 0 { 0.0 } else { geo_dist_vincenty_slice_sum(s) / s.size.to_double() }
}

pub fn geo_dist_vincenty_slice_scale(s : GeodistvincentySlice, f : Double) -> GeodistvincentySlice {
  let result = geo_dist_vincenty_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_dist_vincenty_slice_add(a : GeodistvincentySlice, b : GeodistvincentySlice) -> GeodistvincentySlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_dist_vincenty_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_dist_vincenty_slice_copy(s : GeodistvincentySlice) -> GeodistvincentySlice {
  let result = geo_dist_vincenty_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_dist_vincenty_slice_fill(s : GeodistvincentySlice, v : Double) -> GeodistvincentySlice {
  let result = geo_dist_vincenty_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_dist_vincenty_slice_min(s : GeodistvincentySlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_vincenty_slice_max(s : GeodistvincentySlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_vincenty_slice_to_string(s : GeodistvincentySlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn geo_dist_vincenty_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_dist_vincenty_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_dist_vincenty_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_dist_vincenty_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_dist_vincenty_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_dist_vincenty_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_dist_vincenty_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_dist_vincenty_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_dist_vincenty_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_dist_vincenty_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_dist_vincenty_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_dist_vincenty_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_dist_vincenty_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_dist_vincenty_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_dist_vincenty_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_dist_vincenty_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_dist_vincenty_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_dist_vincenty_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_dist_vincenty_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_dist_vincenty_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_dist_vincenty_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_dist_vincenty_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_dist_vincenty_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_dist_vincenty_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_dist_vincenty_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

