///===
/// extcore/geo_intersect_bbox

pub(all) struct GeointersectbboxPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn geo_intersect_bbox_make_point(x : Double, y : Double) -> GeointersectbboxPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn geo_intersect_bbox_make_point3(x : Double, y : Double, z : Double) -> GeointersectbboxPoint {
  { x, y, z, label: 0 }
}

pub fn geo_intersect_bbox_point_x(pt : GeointersectbboxPoint) -> Double { pt.x }

pub fn geo_intersect_bbox_point_y(pt : GeointersectbboxPoint) -> Double { pt.y }

pub fn geo_intersect_bbox_point_z(pt : GeointersectbboxPoint) -> Double { pt.z }

pub fn geo_intersect_bbox_point_label(pt : GeointersectbboxPoint) -> Int { pt.label }

pub fn geo_intersect_bbox_point_dist(a : GeointersectbboxPoint, b : GeointersectbboxPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  geo_intersect_bbox_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn geo_intersect_bbox_point_add(a : GeointersectbboxPoint, b : GeointersectbboxPoint) -> GeointersectbboxPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn geo_intersect_bbox_point_sub(a : GeointersectbboxPoint, b : GeointersectbboxPoint) -> GeointersectbboxPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn geo_intersect_bbox_point_scale(pt : GeointersectbboxPoint, s : Double) -> GeointersectbboxPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn geo_intersect_bbox_point_dot(a : GeointersectbboxPoint, b : GeointersectbboxPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn geo_intersect_bbox_point_cross(a : GeointersectbboxPoint, b : GeointersectbboxPoint) -> GeointersectbboxPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn geo_intersect_bbox_point_norm(pt : GeointersectbboxPoint) -> Double {
  geo_intersect_bbox_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn geo_intersect_bbox_point_normalize(pt : GeointersectbboxPoint) -> GeointersectbboxPoint {
  let n = geo_intersect_bbox_point_norm(pt)
  if n < 0.0000001 { pt } else { geo_intersect_bbox_point_scale(pt, 1.0 / n) }
}

pub fn geo_intersect_bbox_point_negate(pt : GeointersectbboxPoint) -> GeointersectbboxPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn geo_intersect_bbox_point_mid(a : GeointersectbboxPoint, b : GeointersectbboxPoint) -> GeointersectbboxPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn geo_intersect_bbox_point_lerp(a : GeointersectbboxPoint, b : GeointersectbboxPoint, t : Double) -> GeointersectbboxPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn geo_intersect_bbox_point_to_string(pt : GeointersectbboxPoint) -> String {
  "(" + geo_intersect_bbox_dbl(pt.x) + ", " + geo_intersect_bbox_dbl(pt.y) + ", " + geo_intersect_bbox_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct GeointersectbboxSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn geo_intersect_bbox_make_series(vals : Array[Double], name : String) -> GeointersectbboxSeries {
  { vals, name, meta: 0 }
}

pub fn geo_intersect_bbox_series_len(s : GeointersectbboxSeries) -> Int { s.vals.length() }

pub fn geo_intersect_bbox_series_sum(s : GeointersectbboxSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn geo_intersect_bbox_series_mean(s : GeointersectbboxSeries) -> Double {
  let n = geo_intersect_bbox_series_len(s)
  if n == 0 { 0.0 } else { geo_intersect_bbox_series_sum(s) / n.to_double() }
}

pub fn geo_intersect_bbox_series_min(s : GeointersectbboxSeries) -> Double {
  let n = geo_intersect_bbox_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn geo_intersect_bbox_series_max(s : GeointersectbboxSeries) -> Double {
  let n = geo_intersect_bbox_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn geo_intersect_bbox_series_range(s : GeointersectbboxSeries) -> Double {
  geo_intersect_bbox_series_max(s) - geo_intersect_bbox_series_min(s)
}

pub fn geo_intersect_bbox_series_var(s : GeointersectbboxSeries) -> Double {
  let n = geo_intersect_bbox_series_len(s)
  if n == 0 { 0.0 } else {
    let m = geo_intersect_bbox_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn geo_intersect_bbox_series_std(s : GeointersectbboxSeries) -> Double { geo_intersect_bbox_sqrt(geo_intersect_bbox_series_var(s)) }

pub fn geo_intersect_bbox_series_median(s : GeointersectbboxSeries) -> Double {
  let n = geo_intersect_bbox_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = geo_intersect_bbox_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn geo_intersect_bbox_series_scale(s : GeointersectbboxSeries, f : Double) -> GeointersectbboxSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = geo_intersect_bbox_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn geo_intersect_bbox_series_add(a : GeointersectbboxSeries, b : GeointersectbboxSeries) -> GeointersectbboxSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = geo_intersect_bbox_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn geo_intersect_bbox_series_sub(a : GeointersectbboxSeries, b : GeointersectbboxSeries) -> GeointersectbboxSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = geo_intersect_bbox_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn geo_intersect_bbox_series_normalize(s : GeointersectbboxSeries) -> GeointersectbboxSeries {
  let mn = geo_intersect_bbox_series_min(s)
  let mx = geo_intersect_bbox_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = geo_intersect_bbox_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn geo_intersect_bbox_series_cumsum(s : GeointersectbboxSeries) -> GeointersectbboxSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = geo_intersect_bbox_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn geo_intersect_bbox_series_to_string(s : GeointersectbboxSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + geo_intersect_bbox_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GeointersectbboxMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn geo_intersect_bbox_make_matrix(rows : Int, cols : Int, val : Double) -> GeointersectbboxMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn geo_intersect_bbox_matrix_identity(n : Int) -> GeointersectbboxMatrix {
  let m = geo_intersect_bbox_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn geo_intersect_bbox_matrix_get(m : GeointersectbboxMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn geo_intersect_bbox_matrix_transpose(m : GeointersectbboxMatrix) -> GeointersectbboxMatrix {
  let result = geo_intersect_bbox_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn geo_intersect_bbox_matrix_add(a : GeointersectbboxMatrix, b : GeointersectbboxMatrix) -> GeointersectbboxMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = geo_intersect_bbox_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn geo_intersect_bbox_matrix_scale(m : GeointersectbboxMatrix, s : Double) -> GeointersectbboxMatrix {
  let result = geo_intersect_bbox_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn geo_intersect_bbox_matrix_multiply(a : GeointersectbboxMatrix, b : GeointersectbboxMatrix) -> GeointersectbboxMatrix {
  if a.cols != b.rows { return geo_intersect_bbox_make_matrix(a.rows, b.cols, 0.0) }
  let result = geo_intersect_bbox_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn geo_intersect_bbox_matrix_trace(m : GeointersectbboxMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn geo_intersect_bbox_matrix_det(m : GeointersectbboxMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn geo_intersect_bbox_matrix_norm(m : GeointersectbboxMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  geo_intersect_bbox_sqrt(sum)
}

pub fn geo_intersect_bbox_matrix_to_string(m : GeointersectbboxMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + geo_intersect_bbox_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct GeointersectbboxVector {
  comps : Array[Double]
  dim : Int
}

pub fn geo_intersect_bbox_make_vector(comps : Array[Double]) -> GeointersectbboxVector {
  { comps, dim: comps.length() }
}

pub fn geo_intersect_bbox_vector_zero(dim : Int) -> GeointersectbboxVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn geo_intersect_bbox_vector_add(a : GeointersectbboxVector, b : GeointersectbboxVector) -> GeointersectbboxVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = geo_intersect_bbox_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn geo_intersect_bbox_vector_sub(a : GeointersectbboxVector, b : GeointersectbboxVector) -> GeointersectbboxVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = geo_intersect_bbox_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn geo_intersect_bbox_vector_scale(v : GeointersectbboxVector, s : Double) -> GeointersectbboxVector {
  let mut result = []
  for i in 0..<v.dim { result = geo_intersect_bbox_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn geo_intersect_bbox_vector_dot(a : GeointersectbboxVector, b : GeointersectbboxVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn geo_intersect_bbox_vector_norm(v : GeointersectbboxVector) -> Double { geo_intersect_bbox_sqrt(geo_intersect_bbox_vector_dot(v, v)) }

pub fn geo_intersect_bbox_vector_normalize(v : GeointersectbboxVector) -> GeointersectbboxVector {
  let n = geo_intersect_bbox_vector_norm(v)
  if n < 0.0000001 { v } else { geo_intersect_bbox_vector_scale(v, 1.0 / n) }
}

pub fn geo_intersect_bbox_vector_dist(a : GeointersectbboxVector, b : GeointersectbboxVector) -> Double {
  geo_intersect_bbox_vector_norm(geo_intersect_bbox_vector_sub(a, b))
}

pub fn geo_intersect_bbox_vector_to_string(v : GeointersectbboxVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + geo_intersect_bbox_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn geo_intersect_bbox_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn geo_intersect_bbox_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = geo_intersect_bbox_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn geo_intersect_bbox_std(data : Array[Double]) -> Double { geo_intersect_bbox_sqrt(geo_intersect_bbox_var(data)) }

pub fn geo_intersect_bbox_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = geo_intersect_bbox_mean(a); let mb = geo_intersect_bbox_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn geo_intersect_bbox_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = geo_intersect_bbox_std(a); let sb = geo_intersect_bbox_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { geo_intersect_bbox_cov(a, b) / (sa * sb) }
}

pub fn geo_intersect_bbox_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = geo_intersect_bbox_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn geo_intersect_bbox_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn geo_intersect_bbox_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn geo_intersect_bbox_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  geo_intersect_bbox_sqrt(geo_intersect_bbox_mse(pred, labels))
}

pub fn geo_intersect_bbox_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + geo_intersect_bbox_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn geo_intersect_bbox_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = geo_intersect_bbox_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn geo_intersect_bbox_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn geo_intersect_bbox_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn geo_intersect_bbox_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = geo_intersect_bbox_precision(pred, labels, pos); let r = geo_intersect_bbox_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn geo_intersect_bbox_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn geo_intersect_bbox_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = geo_intersect_bbox_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn geo_intersect_bbox_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn geo_intersect_bbox_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn geo_intersect_bbox_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = geo_intersect_bbox_gcd(a, b)
    (a / g) * b
  }
}

pub fn geo_intersect_bbox_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn geo_intersect_bbox_fibonacci(n : Int) -> Int {
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

pub fn geo_intersect_bbox_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = geo_intersect_bbox_min(data); let mx = geo_intersect_bbox_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn geo_intersect_bbox_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = geo_intersect_bbox_mean(data); let sd = geo_intersect_bbox_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn geo_intersect_bbox_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn geo_intersect_bbox_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn geo_intersect_bbox_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn geo_intersect_bbox_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn geo_intersect_bbox_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn geo_intersect_bbox_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn geo_intersect_bbox_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn geo_intersect_bbox_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn geo_intersect_bbox_dbl(x : Double) -> String {
  let i = if x >= 0.0 { geo_intersect_bbox_int(x) } else { -geo_intersect_bbox_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { geo_intersect_bbox_int(f * 1000000.0) } else { geo_intersect_bbox_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn geo_intersect_bbox_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn geo_intersect_bbox_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct GeointersectbboxFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_bbox_frame_make(size : Int) -> GeointersectbboxFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_bbox_frame_len(s : GeointersectbboxFrame) -> Int { s.size }

pub fn geo_intersect_bbox_frame_get(s : GeointersectbboxFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_bbox_frame_set(s : GeointersectbboxFrame, i : Int, v : Double) -> GeointersectbboxFrame {
  let result = geo_intersect_bbox_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_bbox_frame_sum(s : GeointersectbboxFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_intersect_bbox_frame_mean(s : GeointersectbboxFrame) -> Double {
  if s.size == 0 { 0.0 } else { geo_intersect_bbox_frame_sum(s) / s.size.to_double() }
}

pub fn geo_intersect_bbox_frame_scale(s : GeointersectbboxFrame, f : Double) -> GeointersectbboxFrame {
  let result = geo_intersect_bbox_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_intersect_bbox_frame_add(a : GeointersectbboxFrame, b : GeointersectbboxFrame) -> GeointersectbboxFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_intersect_bbox_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_intersect_bbox_frame_copy(s : GeointersectbboxFrame) -> GeointersectbboxFrame {
  let result = geo_intersect_bbox_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_intersect_bbox_frame_fill(s : GeointersectbboxFrame, v : Double) -> GeointersectbboxFrame {
  let result = geo_intersect_bbox_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_bbox_frame_min(s : GeointersectbboxFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_bbox_frame_max(s : GeointersectbboxFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_bbox_frame_to_string(s : GeointersectbboxFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectbboxTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_bbox_table_make(size : Int) -> GeointersectbboxTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_bbox_table_len(s : GeointersectbboxTable) -> Int { s.size }

pub fn geo_intersect_bbox_table_get(s : GeointersectbboxTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_bbox_table_set(s : GeointersectbboxTable, i : Int, v : Double) -> GeointersectbboxTable {
  let result = geo_intersect_bbox_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_bbox_table_sum(s : GeointersectbboxTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_intersect_bbox_table_mean(s : GeointersectbboxTable) -> Double {
  if s.size == 0 { 0.0 } else { geo_intersect_bbox_table_sum(s) / s.size.to_double() }
}

pub fn geo_intersect_bbox_table_scale(s : GeointersectbboxTable, f : Double) -> GeointersectbboxTable {
  let result = geo_intersect_bbox_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_intersect_bbox_table_add(a : GeointersectbboxTable, b : GeointersectbboxTable) -> GeointersectbboxTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_intersect_bbox_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_intersect_bbox_table_copy(s : GeointersectbboxTable) -> GeointersectbboxTable {
  let result = geo_intersect_bbox_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_intersect_bbox_table_fill(s : GeointersectbboxTable, v : Double) -> GeointersectbboxTable {
  let result = geo_intersect_bbox_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_bbox_table_min(s : GeointersectbboxTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_bbox_table_max(s : GeointersectbboxTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_bbox_table_to_string(s : GeointersectbboxTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectbboxGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_bbox_graphn_make(size : Int) -> GeointersectbboxGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_bbox_graphn_len(s : GeointersectbboxGraphN) -> Int { s.size }

pub fn geo_intersect_bbox_graphn_get(s : GeointersectbboxGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_bbox_graphn_set(s : GeointersectbboxGraphN, i : Int, v : Double) -> GeointersectbboxGraphN {
  let result = geo_intersect_bbox_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_bbox_graphn_sum(s : GeointersectbboxGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_intersect_bbox_graphn_mean(s : GeointersectbboxGraphN) -> Double {
  if s.size == 0 { 0.0 } else { geo_intersect_bbox_graphn_sum(s) / s.size.to_double() }
}

pub fn geo_intersect_bbox_graphn_scale(s : GeointersectbboxGraphN, f : Double) -> GeointersectbboxGraphN {
  let result = geo_intersect_bbox_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_intersect_bbox_graphn_add(a : GeointersectbboxGraphN, b : GeointersectbboxGraphN) -> GeointersectbboxGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_intersect_bbox_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_intersect_bbox_graphn_copy(s : GeointersectbboxGraphN) -> GeointersectbboxGraphN {
  let result = geo_intersect_bbox_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_intersect_bbox_graphn_fill(s : GeointersectbboxGraphN, v : Double) -> GeointersectbboxGraphN {
  let result = geo_intersect_bbox_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_bbox_graphn_min(s : GeointersectbboxGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_bbox_graphn_max(s : GeointersectbboxGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_bbox_graphn_to_string(s : GeointersectbboxGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectbboxNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_bbox_node_make(size : Int) -> GeointersectbboxNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_bbox_node_len(s : GeointersectbboxNode) -> Int { s.size }

pub fn geo_intersect_bbox_node_get(s : GeointersectbboxNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_bbox_node_set(s : GeointersectbboxNode, i : Int, v : Double) -> GeointersectbboxNode {
  let result = geo_intersect_bbox_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_bbox_node_sum(s : GeointersectbboxNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_intersect_bbox_node_mean(s : GeointersectbboxNode) -> Double {
  if s.size == 0 { 0.0 } else { geo_intersect_bbox_node_sum(s) / s.size.to_double() }
}

pub fn geo_intersect_bbox_node_scale(s : GeointersectbboxNode, f : Double) -> GeointersectbboxNode {
  let result = geo_intersect_bbox_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_intersect_bbox_node_add(a : GeointersectbboxNode, b : GeointersectbboxNode) -> GeointersectbboxNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_intersect_bbox_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_intersect_bbox_node_copy(s : GeointersectbboxNode) -> GeointersectbboxNode {
  let result = geo_intersect_bbox_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_intersect_bbox_node_fill(s : GeointersectbboxNode, v : Double) -> GeointersectbboxNode {
  let result = geo_intersect_bbox_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_bbox_node_min(s : GeointersectbboxNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_bbox_node_max(s : GeointersectbboxNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_bbox_node_to_string(s : GeointersectbboxNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectbboxEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_bbox_edge_make(size : Int) -> GeointersectbboxEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_bbox_edge_len(s : GeointersectbboxEdge) -> Int { s.size }

pub fn geo_intersect_bbox_edge_get(s : GeointersectbboxEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_bbox_edge_set(s : GeointersectbboxEdge, i : Int, v : Double) -> GeointersectbboxEdge {
  let result = geo_intersect_bbox_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_bbox_edge_sum(s : GeointersectbboxEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_intersect_bbox_edge_mean(s : GeointersectbboxEdge) -> Double {
  if s.size == 0 { 0.0 } else { geo_intersect_bbox_edge_sum(s) / s.size.to_double() }
}

pub fn geo_intersect_bbox_edge_scale(s : GeointersectbboxEdge, f : Double) -> GeointersectbboxEdge {
  let result = geo_intersect_bbox_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_intersect_bbox_edge_add(a : GeointersectbboxEdge, b : GeointersectbboxEdge) -> GeointersectbboxEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_intersect_bbox_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_intersect_bbox_edge_copy(s : GeointersectbboxEdge) -> GeointersectbboxEdge {
  let result = geo_intersect_bbox_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_intersect_bbox_edge_fill(s : GeointersectbboxEdge, v : Double) -> GeointersectbboxEdge {
  let result = geo_intersect_bbox_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_bbox_edge_min(s : GeointersectbboxEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_bbox_edge_max(s : GeointersectbboxEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_bbox_edge_to_string(s : GeointersectbboxEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectbboxPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_bbox_path_make(size : Int) -> GeointersectbboxPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_bbox_path_len(s : GeointersectbboxPath) -> Int { s.size }

pub fn geo_intersect_bbox_path_get(s : GeointersectbboxPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_bbox_path_set(s : GeointersectbboxPath, i : Int, v : Double) -> GeointersectbboxPath {
  let result = geo_intersect_bbox_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_bbox_path_sum(s : GeointersectbboxPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_intersect_bbox_path_mean(s : GeointersectbboxPath) -> Double {
  if s.size == 0 { 0.0 } else { geo_intersect_bbox_path_sum(s) / s.size.to_double() }
}

pub fn geo_intersect_bbox_path_scale(s : GeointersectbboxPath, f : Double) -> GeointersectbboxPath {
  let result = geo_intersect_bbox_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_intersect_bbox_path_add(a : GeointersectbboxPath, b : GeointersectbboxPath) -> GeointersectbboxPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_intersect_bbox_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_intersect_bbox_path_copy(s : GeointersectbboxPath) -> GeointersectbboxPath {
  let result = geo_intersect_bbox_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_intersect_bbox_path_fill(s : GeointersectbboxPath, v : Double) -> GeointersectbboxPath {
  let result = geo_intersect_bbox_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_bbox_path_min(s : GeointersectbboxPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_bbox_path_max(s : GeointersectbboxPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_bbox_path_to_string(s : GeointersectbboxPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectbboxCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_bbox_cluster_make(size : Int) -> GeointersectbboxCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_bbox_cluster_len(s : GeointersectbboxCluster) -> Int { s.size }

pub fn geo_intersect_bbox_cluster_get(s : GeointersectbboxCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_bbox_cluster_set(s : GeointersectbboxCluster, i : Int, v : Double) -> GeointersectbboxCluster {
  let result = geo_intersect_bbox_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_bbox_cluster_sum(s : GeointersectbboxCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_intersect_bbox_cluster_mean(s : GeointersectbboxCluster) -> Double {
  if s.size == 0 { 0.0 } else { geo_intersect_bbox_cluster_sum(s) / s.size.to_double() }
}

pub fn geo_intersect_bbox_cluster_scale(s : GeointersectbboxCluster, f : Double) -> GeointersectbboxCluster {
  let result = geo_intersect_bbox_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_intersect_bbox_cluster_add(a : GeointersectbboxCluster, b : GeointersectbboxCluster) -> GeointersectbboxCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_intersect_bbox_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_intersect_bbox_cluster_copy(s : GeointersectbboxCluster) -> GeointersectbboxCluster {
  let result = geo_intersect_bbox_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_intersect_bbox_cluster_fill(s : GeointersectbboxCluster, v : Double) -> GeointersectbboxCluster {
  let result = geo_intersect_bbox_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_bbox_cluster_min(s : GeointersectbboxCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_bbox_cluster_max(s : GeointersectbboxCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_bbox_cluster_to_string(s : GeointersectbboxCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectbboxModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_bbox_model_make(size : Int) -> GeointersectbboxModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_bbox_model_len(s : GeointersectbboxModel) -> Int { s.size }

pub fn geo_intersect_bbox_model_get(s : GeointersectbboxModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_bbox_model_set(s : GeointersectbboxModel, i : Int, v : Double) -> GeointersectbboxModel {
  let result = geo_intersect_bbox_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_bbox_model_sum(s : GeointersectbboxModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_intersect_bbox_model_mean(s : GeointersectbboxModel) -> Double {
  if s.size == 0 { 0.0 } else { geo_intersect_bbox_model_sum(s) / s.size.to_double() }
}

pub fn geo_intersect_bbox_model_scale(s : GeointersectbboxModel, f : Double) -> GeointersectbboxModel {
  let result = geo_intersect_bbox_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_intersect_bbox_model_add(a : GeointersectbboxModel, b : GeointersectbboxModel) -> GeointersectbboxModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_intersect_bbox_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_intersect_bbox_model_copy(s : GeointersectbboxModel) -> GeointersectbboxModel {
  let result = geo_intersect_bbox_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_intersect_bbox_model_fill(s : GeointersectbboxModel, v : Double) -> GeointersectbboxModel {
  let result = geo_intersect_bbox_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_bbox_model_min(s : GeointersectbboxModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_bbox_model_max(s : GeointersectbboxModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_bbox_model_to_string(s : GeointersectbboxModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectbboxLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_bbox_layer_make(size : Int) -> GeointersectbboxLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_bbox_layer_len(s : GeointersectbboxLayer) -> Int { s.size }

pub fn geo_intersect_bbox_layer_get(s : GeointersectbboxLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_bbox_layer_set(s : GeointersectbboxLayer, i : Int, v : Double) -> GeointersectbboxLayer {
  let result = geo_intersect_bbox_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_bbox_layer_sum(s : GeointersectbboxLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_intersect_bbox_layer_mean(s : GeointersectbboxLayer) -> Double {
  if s.size == 0 { 0.0 } else { geo_intersect_bbox_layer_sum(s) / s.size.to_double() }
}

pub fn geo_intersect_bbox_layer_scale(s : GeointersectbboxLayer, f : Double) -> GeointersectbboxLayer {
  let result = geo_intersect_bbox_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_intersect_bbox_layer_add(a : GeointersectbboxLayer, b : GeointersectbboxLayer) -> GeointersectbboxLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_intersect_bbox_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_intersect_bbox_layer_copy(s : GeointersectbboxLayer) -> GeointersectbboxLayer {
  let result = geo_intersect_bbox_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_intersect_bbox_layer_fill(s : GeointersectbboxLayer, v : Double) -> GeointersectbboxLayer {
  let result = geo_intersect_bbox_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_bbox_layer_min(s : GeointersectbboxLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_bbox_layer_max(s : GeointersectbboxLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_bbox_layer_to_string(s : GeointersectbboxLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectbboxBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_bbox_buffer_make(size : Int) -> GeointersectbboxBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_bbox_buffer_len(s : GeointersectbboxBuffer) -> Int { s.size }

pub fn geo_intersect_bbox_buffer_get(s : GeointersectbboxBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_bbox_buffer_set(s : GeointersectbboxBuffer, i : Int, v : Double) -> GeointersectbboxBuffer {
  let result = geo_intersect_bbox_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_bbox_buffer_sum(s : GeointersectbboxBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_intersect_bbox_buffer_mean(s : GeointersectbboxBuffer) -> Double {
  if s.size == 0 { 0.0 } else { geo_intersect_bbox_buffer_sum(s) / s.size.to_double() }
}

pub fn geo_intersect_bbox_buffer_scale(s : GeointersectbboxBuffer, f : Double) -> GeointersectbboxBuffer {
  let result = geo_intersect_bbox_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_intersect_bbox_buffer_add(a : GeointersectbboxBuffer, b : GeointersectbboxBuffer) -> GeointersectbboxBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_intersect_bbox_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_intersect_bbox_buffer_copy(s : GeointersectbboxBuffer) -> GeointersectbboxBuffer {
  let result = geo_intersect_bbox_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_intersect_bbox_buffer_fill(s : GeointersectbboxBuffer, v : Double) -> GeointersectbboxBuffer {
  let result = geo_intersect_bbox_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_bbox_buffer_min(s : GeointersectbboxBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_bbox_buffer_max(s : GeointersectbboxBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_bbox_buffer_to_string(s : GeointersectbboxBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectbboxCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_bbox_cursor_make(size : Int) -> GeointersectbboxCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_bbox_cursor_len(s : GeointersectbboxCursor) -> Int { s.size }

pub fn geo_intersect_bbox_cursor_get(s : GeointersectbboxCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_bbox_cursor_set(s : GeointersectbboxCursor, i : Int, v : Double) -> GeointersectbboxCursor {
  let result = geo_intersect_bbox_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_bbox_cursor_sum(s : GeointersectbboxCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_intersect_bbox_cursor_mean(s : GeointersectbboxCursor) -> Double {
  if s.size == 0 { 0.0 } else { geo_intersect_bbox_cursor_sum(s) / s.size.to_double() }
}

pub fn geo_intersect_bbox_cursor_scale(s : GeointersectbboxCursor, f : Double) -> GeointersectbboxCursor {
  let result = geo_intersect_bbox_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_intersect_bbox_cursor_add(a : GeointersectbboxCursor, b : GeointersectbboxCursor) -> GeointersectbboxCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_intersect_bbox_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_intersect_bbox_cursor_copy(s : GeointersectbboxCursor) -> GeointersectbboxCursor {
  let result = geo_intersect_bbox_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_intersect_bbox_cursor_fill(s : GeointersectbboxCursor, v : Double) -> GeointersectbboxCursor {
  let result = geo_intersect_bbox_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_bbox_cursor_min(s : GeointersectbboxCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_bbox_cursor_max(s : GeointersectbboxCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_bbox_cursor_to_string(s : GeointersectbboxCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectbboxView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_bbox_view_make(size : Int) -> GeointersectbboxView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_bbox_view_len(s : GeointersectbboxView) -> Int { s.size }

pub fn geo_intersect_bbox_view_get(s : GeointersectbboxView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_bbox_view_set(s : GeointersectbboxView, i : Int, v : Double) -> GeointersectbboxView {
  let result = geo_intersect_bbox_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_bbox_view_sum(s : GeointersectbboxView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_intersect_bbox_view_mean(s : GeointersectbboxView) -> Double {
  if s.size == 0 { 0.0 } else { geo_intersect_bbox_view_sum(s) / s.size.to_double() }
}

pub fn geo_intersect_bbox_view_scale(s : GeointersectbboxView, f : Double) -> GeointersectbboxView {
  let result = geo_intersect_bbox_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_intersect_bbox_view_add(a : GeointersectbboxView, b : GeointersectbboxView) -> GeointersectbboxView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_intersect_bbox_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_intersect_bbox_view_copy(s : GeointersectbboxView) -> GeointersectbboxView {
  let result = geo_intersect_bbox_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_intersect_bbox_view_fill(s : GeointersectbboxView, v : Double) -> GeointersectbboxView {
  let result = geo_intersect_bbox_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_bbox_view_min(s : GeointersectbboxView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_bbox_view_max(s : GeointersectbboxView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_bbox_view_to_string(s : GeointersectbboxView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectbboxRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_bbox_range_make(size : Int) -> GeointersectbboxRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_bbox_range_len(s : GeointersectbboxRange) -> Int { s.size }

pub fn geo_intersect_bbox_range_get(s : GeointersectbboxRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_bbox_range_set(s : GeointersectbboxRange, i : Int, v : Double) -> GeointersectbboxRange {
  let result = geo_intersect_bbox_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_bbox_range_sum(s : GeointersectbboxRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_intersect_bbox_range_mean(s : GeointersectbboxRange) -> Double {
  if s.size == 0 { 0.0 } else { geo_intersect_bbox_range_sum(s) / s.size.to_double() }
}

pub fn geo_intersect_bbox_range_scale(s : GeointersectbboxRange, f : Double) -> GeointersectbboxRange {
  let result = geo_intersect_bbox_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_intersect_bbox_range_add(a : GeointersectbboxRange, b : GeointersectbboxRange) -> GeointersectbboxRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_intersect_bbox_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_intersect_bbox_range_copy(s : GeointersectbboxRange) -> GeointersectbboxRange {
  let result = geo_intersect_bbox_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_intersect_bbox_range_fill(s : GeointersectbboxRange, v : Double) -> GeointersectbboxRange {
  let result = geo_intersect_bbox_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_bbox_range_min(s : GeointersectbboxRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_bbox_range_max(s : GeointersectbboxRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_bbox_range_to_string(s : GeointersectbboxRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectbboxSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_bbox_slice_make(size : Int) -> GeointersectbboxSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_bbox_slice_len(s : GeointersectbboxSlice) -> Int { s.size }

pub fn geo_intersect_bbox_slice_get(s : GeointersectbboxSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_bbox_slice_set(s : GeointersectbboxSlice, i : Int, v : Double) -> GeointersectbboxSlice {
  let result = geo_intersect_bbox_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_bbox_slice_sum(s : GeointersectbboxSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_intersect_bbox_slice_mean(s : GeointersectbboxSlice) -> Double {
  if s.size == 0 { 0.0 } else { geo_intersect_bbox_slice_sum(s) / s.size.to_double() }
}

pub fn geo_intersect_bbox_slice_scale(s : GeointersectbboxSlice, f : Double) -> GeointersectbboxSlice {
  let result = geo_intersect_bbox_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_intersect_bbox_slice_add(a : GeointersectbboxSlice, b : GeointersectbboxSlice) -> GeointersectbboxSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_intersect_bbox_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_intersect_bbox_slice_copy(s : GeointersectbboxSlice) -> GeointersectbboxSlice {
  let result = geo_intersect_bbox_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_intersect_bbox_slice_fill(s : GeointersectbboxSlice, v : Double) -> GeointersectbboxSlice {
  let result = geo_intersect_bbox_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_bbox_slice_min(s : GeointersectbboxSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_bbox_slice_max(s : GeointersectbboxSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_bbox_slice_to_string(s : GeointersectbboxSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn geo_intersect_bbox_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_intersect_bbox_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_intersect_bbox_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_intersect_bbox_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_intersect_bbox_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_intersect_bbox_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_intersect_bbox_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_intersect_bbox_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_intersect_bbox_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_intersect_bbox_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_intersect_bbox_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_intersect_bbox_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_intersect_bbox_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_intersect_bbox_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_intersect_bbox_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_intersect_bbox_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_intersect_bbox_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_intersect_bbox_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_intersect_bbox_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_intersect_bbox_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_intersect_bbox_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_intersect_bbox_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_intersect_bbox_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_intersect_bbox_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_intersect_bbox_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

