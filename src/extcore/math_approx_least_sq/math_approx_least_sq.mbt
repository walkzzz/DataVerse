///===
/// extcore/math_approx_least_sq

pub(all) struct MathapproxleastsqPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn math_approx_least_sq_make_point(x : Double, y : Double) -> MathapproxleastsqPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn math_approx_least_sq_make_point3(x : Double, y : Double, z : Double) -> MathapproxleastsqPoint {
  { x, y, z, label: 0 }
}

pub fn math_approx_least_sq_point_x(pt : MathapproxleastsqPoint) -> Double { pt.x }

pub fn math_approx_least_sq_point_y(pt : MathapproxleastsqPoint) -> Double { pt.y }

pub fn math_approx_least_sq_point_z(pt : MathapproxleastsqPoint) -> Double { pt.z }

pub fn math_approx_least_sq_point_label(pt : MathapproxleastsqPoint) -> Int { pt.label }

pub fn math_approx_least_sq_point_dist(a : MathapproxleastsqPoint, b : MathapproxleastsqPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn math_approx_least_sq_point_add(a : MathapproxleastsqPoint, b : MathapproxleastsqPoint) -> MathapproxleastsqPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn math_approx_least_sq_point_sub(a : MathapproxleastsqPoint, b : MathapproxleastsqPoint) -> MathapproxleastsqPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn math_approx_least_sq_point_scale(pt : MathapproxleastsqPoint, s : Double) -> MathapproxleastsqPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn math_approx_least_sq_point_dot(a : MathapproxleastsqPoint, b : MathapproxleastsqPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn math_approx_least_sq_point_cross(a : MathapproxleastsqPoint, b : MathapproxleastsqPoint) -> MathapproxleastsqPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn math_approx_least_sq_point_norm(pt : MathapproxleastsqPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn math_approx_least_sq_point_normalize(pt : MathapproxleastsqPoint) -> MathapproxleastsqPoint {
  let n = math_approx_least_sq_point_norm(pt)
  if n < 0.0000001 { pt } else { math_approx_least_sq_point_scale(pt, 1.0 / n) }
}

pub fn math_approx_least_sq_point_negate(pt : MathapproxleastsqPoint) -> MathapproxleastsqPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn math_approx_least_sq_point_mid(a : MathapproxleastsqPoint, b : MathapproxleastsqPoint) -> MathapproxleastsqPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn math_approx_least_sq_point_lerp(a : MathapproxleastsqPoint, b : MathapproxleastsqPoint, t : Double) -> MathapproxleastsqPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn math_approx_least_sq_point_to_string(pt : MathapproxleastsqPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct MathapproxleastsqSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn math_approx_least_sq_make_series(vals : Array[Double], name : String) -> MathapproxleastsqSeries {
  { vals, name, meta: 0 }
}

pub fn math_approx_least_sq_series_len(s : MathapproxleastsqSeries) -> Int { s.vals.length() }

pub fn math_approx_least_sq_series_sum(s : MathapproxleastsqSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn math_approx_least_sq_series_mean(s : MathapproxleastsqSeries) -> Double {
  let n = math_approx_least_sq_series_len(s)
  if n == 0 { 0.0 } else { math_approx_least_sq_series_sum(s) / n.to_double() }
}

pub fn math_approx_least_sq_series_min(s : MathapproxleastsqSeries) -> Double {
  let n = math_approx_least_sq_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn math_approx_least_sq_series_max(s : MathapproxleastsqSeries) -> Double {
  let n = math_approx_least_sq_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn math_approx_least_sq_series_range(s : MathapproxleastsqSeries) -> Double {
  math_approx_least_sq_series_max(s) - math_approx_least_sq_series_min(s)
}

pub fn math_approx_least_sq_series_var(s : MathapproxleastsqSeries) -> Double {
  let n = math_approx_least_sq_series_len(s)
  if n == 0 { 0.0 } else {
    let m = math_approx_least_sq_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn math_approx_least_sq_series_std(s : MathapproxleastsqSeries) -> Double { @_common.sqrt(math_approx_least_sq_series_var(s)) }

pub fn math_approx_least_sq_series_median(s : MathapproxleastsqSeries) -> Double {
  let n = math_approx_least_sq_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = math_approx_least_sq_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn math_approx_least_sq_series_scale(s : MathapproxleastsqSeries, f : Double) -> MathapproxleastsqSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn math_approx_least_sq_series_add(a : MathapproxleastsqSeries, b : MathapproxleastsqSeries) -> MathapproxleastsqSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn math_approx_least_sq_series_sub(a : MathapproxleastsqSeries, b : MathapproxleastsqSeries) -> MathapproxleastsqSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn math_approx_least_sq_series_normalize(s : MathapproxleastsqSeries) -> MathapproxleastsqSeries {
  let mn = math_approx_least_sq_series_min(s)
  let mx = math_approx_least_sq_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn math_approx_least_sq_series_cumsum(s : MathapproxleastsqSeries) -> MathapproxleastsqSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn math_approx_least_sq_series_to_string(s : MathapproxleastsqSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MathapproxleastsqMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn math_approx_least_sq_make_matrix(rows : Int, cols : Int, val : Double) -> MathapproxleastsqMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn math_approx_least_sq_matrix_identity(n : Int) -> MathapproxleastsqMatrix {
  let m = math_approx_least_sq_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn math_approx_least_sq_matrix_get(m : MathapproxleastsqMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn math_approx_least_sq_matrix_transpose(m : MathapproxleastsqMatrix) -> MathapproxleastsqMatrix {
  let result = math_approx_least_sq_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn math_approx_least_sq_matrix_add(a : MathapproxleastsqMatrix, b : MathapproxleastsqMatrix) -> MathapproxleastsqMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = math_approx_least_sq_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn math_approx_least_sq_matrix_scale(m : MathapproxleastsqMatrix, s : Double) -> MathapproxleastsqMatrix {
  let result = math_approx_least_sq_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn math_approx_least_sq_matrix_multiply(a : MathapproxleastsqMatrix, b : MathapproxleastsqMatrix) -> MathapproxleastsqMatrix {
  if a.cols != b.rows { return math_approx_least_sq_make_matrix(a.rows, b.cols, 0.0) }
  let result = math_approx_least_sq_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn math_approx_least_sq_matrix_trace(m : MathapproxleastsqMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn math_approx_least_sq_matrix_det(m : MathapproxleastsqMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn math_approx_least_sq_matrix_norm(m : MathapproxleastsqMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn math_approx_least_sq_matrix_to_string(m : MathapproxleastsqMatrix) -> String {
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

pub(all) struct MathapproxleastsqVector {
  comps : Array[Double]
  dim : Int
}

pub fn math_approx_least_sq_make_vector(comps : Array[Double]) -> MathapproxleastsqVector {
  { comps, dim: comps.length() }
}

pub fn math_approx_least_sq_vector_zero(dim : Int) -> MathapproxleastsqVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn math_approx_least_sq_vector_add(a : MathapproxleastsqVector, b : MathapproxleastsqVector) -> MathapproxleastsqVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn math_approx_least_sq_vector_sub(a : MathapproxleastsqVector, b : MathapproxleastsqVector) -> MathapproxleastsqVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn math_approx_least_sq_vector_scale(v : MathapproxleastsqVector, s : Double) -> MathapproxleastsqVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn math_approx_least_sq_vector_dot(a : MathapproxleastsqVector, b : MathapproxleastsqVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn math_approx_least_sq_vector_norm(v : MathapproxleastsqVector) -> Double { @_common.sqrt(math_approx_least_sq_vector_dot(v, v)) }

pub fn math_approx_least_sq_vector_normalize(v : MathapproxleastsqVector) -> MathapproxleastsqVector {
  let n = math_approx_least_sq_vector_norm(v)
  if n < 0.0000001 { v } else { math_approx_least_sq_vector_scale(v, 1.0 / n) }
}

pub fn math_approx_least_sq_vector_dist(a : MathapproxleastsqVector, b : MathapproxleastsqVector) -> Double {
  math_approx_least_sq_vector_norm(math_approx_least_sq_vector_sub(a, b))
}

pub fn math_approx_least_sq_vector_to_string(v : MathapproxleastsqVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn math_approx_least_sq_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn math_approx_least_sq_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = math_approx_least_sq_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn math_approx_least_sq_std(data : Array[Double]) -> Double { @_common.sqrt(math_approx_least_sq_var(data)) }

pub fn math_approx_least_sq_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = math_approx_least_sq_mean(a); let mb = math_approx_least_sq_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn math_approx_least_sq_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = math_approx_least_sq_std(a); let sb = math_approx_least_sq_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { math_approx_least_sq_cov(a, b) / (sa * sb) }
}

pub fn math_approx_least_sq_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = math_approx_least_sq_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn math_approx_least_sq_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn math_approx_least_sq_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn math_approx_least_sq_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  @_common.sqrt(math_approx_least_sq_mse(pred, labels))
}

pub fn math_approx_least_sq_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn math_approx_least_sq_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = math_approx_least_sq_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn math_approx_least_sq_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn math_approx_least_sq_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn math_approx_least_sq_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = math_approx_least_sq_precision(pred, labels, pos); let r = math_approx_least_sq_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn math_approx_least_sq_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn math_approx_least_sq_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = math_approx_least_sq_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn math_approx_least_sq_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn math_approx_least_sq_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn math_approx_least_sq_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = math_approx_least_sq_gcd(a, b)
    (a / g) * b
  }
}

pub fn math_approx_least_sq_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn math_approx_least_sq_fibonacci(n : Int) -> Int {
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

pub fn math_approx_least_sq_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = math_approx_least_sq_min(data); let mx = math_approx_least_sq_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn math_approx_least_sq_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = math_approx_least_sq_mean(data); let sd = math_approx_least_sq_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn math_approx_least_sq_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn math_approx_least_sq_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn math_approx_least_sq_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn math_approx_least_sq_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn math_approx_least_sq_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn math_approx_least_sq_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

pub(all) struct MathapproxleastsqFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_least_sq_frame_make(size : Int) -> MathapproxleastsqFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_least_sq_frame_len(s : MathapproxleastsqFrame) -> Int { s.size }

pub fn math_approx_least_sq_frame_get(s : MathapproxleastsqFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_least_sq_frame_set(s : MathapproxleastsqFrame, i : Int, v : Double) -> MathapproxleastsqFrame {
  let result = math_approx_least_sq_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_approx_least_sq_frame_sum(s : MathapproxleastsqFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_approx_least_sq_frame_mean(s : MathapproxleastsqFrame) -> Double {
  if s.size == 0 { 0.0 } else { math_approx_least_sq_frame_sum(s) / s.size.to_double() }
}

pub fn math_approx_least_sq_frame_scale(s : MathapproxleastsqFrame, f : Double) -> MathapproxleastsqFrame {
  let result = math_approx_least_sq_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_approx_least_sq_frame_add(a : MathapproxleastsqFrame, b : MathapproxleastsqFrame) -> MathapproxleastsqFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_approx_least_sq_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_approx_least_sq_frame_copy(s : MathapproxleastsqFrame) -> MathapproxleastsqFrame {
  let result = math_approx_least_sq_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_approx_least_sq_frame_fill(s : MathapproxleastsqFrame, v : Double) -> MathapproxleastsqFrame {
  let result = math_approx_least_sq_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_approx_least_sq_frame_min(s : MathapproxleastsqFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_least_sq_frame_max(s : MathapproxleastsqFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_least_sq_frame_to_string(s : MathapproxleastsqFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxleastsqTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_least_sq_table_make(size : Int) -> MathapproxleastsqTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_least_sq_table_len(s : MathapproxleastsqTable) -> Int { s.size }

pub fn math_approx_least_sq_table_get(s : MathapproxleastsqTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_least_sq_table_set(s : MathapproxleastsqTable, i : Int, v : Double) -> MathapproxleastsqTable {
  let result = math_approx_least_sq_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_approx_least_sq_table_sum(s : MathapproxleastsqTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_approx_least_sq_table_mean(s : MathapproxleastsqTable) -> Double {
  if s.size == 0 { 0.0 } else { math_approx_least_sq_table_sum(s) / s.size.to_double() }
}

pub fn math_approx_least_sq_table_scale(s : MathapproxleastsqTable, f : Double) -> MathapproxleastsqTable {
  let result = math_approx_least_sq_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_approx_least_sq_table_add(a : MathapproxleastsqTable, b : MathapproxleastsqTable) -> MathapproxleastsqTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_approx_least_sq_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_approx_least_sq_table_copy(s : MathapproxleastsqTable) -> MathapproxleastsqTable {
  let result = math_approx_least_sq_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_approx_least_sq_table_fill(s : MathapproxleastsqTable, v : Double) -> MathapproxleastsqTable {
  let result = math_approx_least_sq_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_approx_least_sq_table_min(s : MathapproxleastsqTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_least_sq_table_max(s : MathapproxleastsqTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_least_sq_table_to_string(s : MathapproxleastsqTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxleastsqGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_least_sq_graphn_make(size : Int) -> MathapproxleastsqGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_least_sq_graphn_len(s : MathapproxleastsqGraphN) -> Int { s.size }

pub fn math_approx_least_sq_graphn_get(s : MathapproxleastsqGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_least_sq_graphn_set(s : MathapproxleastsqGraphN, i : Int, v : Double) -> MathapproxleastsqGraphN {
  let result = math_approx_least_sq_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_approx_least_sq_graphn_sum(s : MathapproxleastsqGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_approx_least_sq_graphn_mean(s : MathapproxleastsqGraphN) -> Double {
  if s.size == 0 { 0.0 } else { math_approx_least_sq_graphn_sum(s) / s.size.to_double() }
}

pub fn math_approx_least_sq_graphn_scale(s : MathapproxleastsqGraphN, f : Double) -> MathapproxleastsqGraphN {
  let result = math_approx_least_sq_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_approx_least_sq_graphn_add(a : MathapproxleastsqGraphN, b : MathapproxleastsqGraphN) -> MathapproxleastsqGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_approx_least_sq_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_approx_least_sq_graphn_copy(s : MathapproxleastsqGraphN) -> MathapproxleastsqGraphN {
  let result = math_approx_least_sq_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_approx_least_sq_graphn_fill(s : MathapproxleastsqGraphN, v : Double) -> MathapproxleastsqGraphN {
  let result = math_approx_least_sq_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_approx_least_sq_graphn_min(s : MathapproxleastsqGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_least_sq_graphn_max(s : MathapproxleastsqGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_least_sq_graphn_to_string(s : MathapproxleastsqGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxleastsqNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_least_sq_node_make(size : Int) -> MathapproxleastsqNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_least_sq_node_len(s : MathapproxleastsqNode) -> Int { s.size }

pub fn math_approx_least_sq_node_get(s : MathapproxleastsqNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_least_sq_node_set(s : MathapproxleastsqNode, i : Int, v : Double) -> MathapproxleastsqNode {
  let result = math_approx_least_sq_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_approx_least_sq_node_sum(s : MathapproxleastsqNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_approx_least_sq_node_mean(s : MathapproxleastsqNode) -> Double {
  if s.size == 0 { 0.0 } else { math_approx_least_sq_node_sum(s) / s.size.to_double() }
}

pub fn math_approx_least_sq_node_scale(s : MathapproxleastsqNode, f : Double) -> MathapproxleastsqNode {
  let result = math_approx_least_sq_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_approx_least_sq_node_add(a : MathapproxleastsqNode, b : MathapproxleastsqNode) -> MathapproxleastsqNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_approx_least_sq_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_approx_least_sq_node_copy(s : MathapproxleastsqNode) -> MathapproxleastsqNode {
  let result = math_approx_least_sq_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_approx_least_sq_node_fill(s : MathapproxleastsqNode, v : Double) -> MathapproxleastsqNode {
  let result = math_approx_least_sq_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_approx_least_sq_node_min(s : MathapproxleastsqNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_least_sq_node_max(s : MathapproxleastsqNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_least_sq_node_to_string(s : MathapproxleastsqNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxleastsqEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_least_sq_edge_make(size : Int) -> MathapproxleastsqEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_least_sq_edge_len(s : MathapproxleastsqEdge) -> Int { s.size }

pub fn math_approx_least_sq_edge_get(s : MathapproxleastsqEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_least_sq_edge_set(s : MathapproxleastsqEdge, i : Int, v : Double) -> MathapproxleastsqEdge {
  let result = math_approx_least_sq_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_approx_least_sq_edge_sum(s : MathapproxleastsqEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_approx_least_sq_edge_mean(s : MathapproxleastsqEdge) -> Double {
  if s.size == 0 { 0.0 } else { math_approx_least_sq_edge_sum(s) / s.size.to_double() }
}

pub fn math_approx_least_sq_edge_scale(s : MathapproxleastsqEdge, f : Double) -> MathapproxleastsqEdge {
  let result = math_approx_least_sq_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_approx_least_sq_edge_add(a : MathapproxleastsqEdge, b : MathapproxleastsqEdge) -> MathapproxleastsqEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_approx_least_sq_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_approx_least_sq_edge_copy(s : MathapproxleastsqEdge) -> MathapproxleastsqEdge {
  let result = math_approx_least_sq_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_approx_least_sq_edge_fill(s : MathapproxleastsqEdge, v : Double) -> MathapproxleastsqEdge {
  let result = math_approx_least_sq_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_approx_least_sq_edge_min(s : MathapproxleastsqEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_least_sq_edge_max(s : MathapproxleastsqEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_least_sq_edge_to_string(s : MathapproxleastsqEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxleastsqPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_least_sq_path_make(size : Int) -> MathapproxleastsqPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_least_sq_path_len(s : MathapproxleastsqPath) -> Int { s.size }

pub fn math_approx_least_sq_path_get(s : MathapproxleastsqPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_least_sq_path_set(s : MathapproxleastsqPath, i : Int, v : Double) -> MathapproxleastsqPath {
  let result = math_approx_least_sq_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_approx_least_sq_path_sum(s : MathapproxleastsqPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_approx_least_sq_path_mean(s : MathapproxleastsqPath) -> Double {
  if s.size == 0 { 0.0 } else { math_approx_least_sq_path_sum(s) / s.size.to_double() }
}

pub fn math_approx_least_sq_path_scale(s : MathapproxleastsqPath, f : Double) -> MathapproxleastsqPath {
  let result = math_approx_least_sq_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_approx_least_sq_path_add(a : MathapproxleastsqPath, b : MathapproxleastsqPath) -> MathapproxleastsqPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_approx_least_sq_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_approx_least_sq_path_copy(s : MathapproxleastsqPath) -> MathapproxleastsqPath {
  let result = math_approx_least_sq_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_approx_least_sq_path_fill(s : MathapproxleastsqPath, v : Double) -> MathapproxleastsqPath {
  let result = math_approx_least_sq_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_approx_least_sq_path_min(s : MathapproxleastsqPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_least_sq_path_max(s : MathapproxleastsqPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_least_sq_path_to_string(s : MathapproxleastsqPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxleastsqCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_least_sq_cluster_make(size : Int) -> MathapproxleastsqCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_least_sq_cluster_len(s : MathapproxleastsqCluster) -> Int { s.size }

pub fn math_approx_least_sq_cluster_get(s : MathapproxleastsqCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_least_sq_cluster_set(s : MathapproxleastsqCluster, i : Int, v : Double) -> MathapproxleastsqCluster {
  let result = math_approx_least_sq_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_approx_least_sq_cluster_sum(s : MathapproxleastsqCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_approx_least_sq_cluster_mean(s : MathapproxleastsqCluster) -> Double {
  if s.size == 0 { 0.0 } else { math_approx_least_sq_cluster_sum(s) / s.size.to_double() }
}

pub fn math_approx_least_sq_cluster_scale(s : MathapproxleastsqCluster, f : Double) -> MathapproxleastsqCluster {
  let result = math_approx_least_sq_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_approx_least_sq_cluster_add(a : MathapproxleastsqCluster, b : MathapproxleastsqCluster) -> MathapproxleastsqCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_approx_least_sq_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_approx_least_sq_cluster_copy(s : MathapproxleastsqCluster) -> MathapproxleastsqCluster {
  let result = math_approx_least_sq_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_approx_least_sq_cluster_fill(s : MathapproxleastsqCluster, v : Double) -> MathapproxleastsqCluster {
  let result = math_approx_least_sq_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_approx_least_sq_cluster_min(s : MathapproxleastsqCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_least_sq_cluster_max(s : MathapproxleastsqCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_least_sq_cluster_to_string(s : MathapproxleastsqCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxleastsqModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_least_sq_model_make(size : Int) -> MathapproxleastsqModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_least_sq_model_len(s : MathapproxleastsqModel) -> Int { s.size }

pub fn math_approx_least_sq_model_get(s : MathapproxleastsqModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_least_sq_model_set(s : MathapproxleastsqModel, i : Int, v : Double) -> MathapproxleastsqModel {
  let result = math_approx_least_sq_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_approx_least_sq_model_sum(s : MathapproxleastsqModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_approx_least_sq_model_mean(s : MathapproxleastsqModel) -> Double {
  if s.size == 0 { 0.0 } else { math_approx_least_sq_model_sum(s) / s.size.to_double() }
}

pub fn math_approx_least_sq_model_scale(s : MathapproxleastsqModel, f : Double) -> MathapproxleastsqModel {
  let result = math_approx_least_sq_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_approx_least_sq_model_add(a : MathapproxleastsqModel, b : MathapproxleastsqModel) -> MathapproxleastsqModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_approx_least_sq_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_approx_least_sq_model_copy(s : MathapproxleastsqModel) -> MathapproxleastsqModel {
  let result = math_approx_least_sq_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_approx_least_sq_model_fill(s : MathapproxleastsqModel, v : Double) -> MathapproxleastsqModel {
  let result = math_approx_least_sq_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_approx_least_sq_model_min(s : MathapproxleastsqModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_least_sq_model_max(s : MathapproxleastsqModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_least_sq_model_to_string(s : MathapproxleastsqModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxleastsqLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_least_sq_layer_make(size : Int) -> MathapproxleastsqLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_least_sq_layer_len(s : MathapproxleastsqLayer) -> Int { s.size }

pub fn math_approx_least_sq_layer_get(s : MathapproxleastsqLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_least_sq_layer_set(s : MathapproxleastsqLayer, i : Int, v : Double) -> MathapproxleastsqLayer {
  let result = math_approx_least_sq_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_approx_least_sq_layer_sum(s : MathapproxleastsqLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_approx_least_sq_layer_mean(s : MathapproxleastsqLayer) -> Double {
  if s.size == 0 { 0.0 } else { math_approx_least_sq_layer_sum(s) / s.size.to_double() }
}

pub fn math_approx_least_sq_layer_scale(s : MathapproxleastsqLayer, f : Double) -> MathapproxleastsqLayer {
  let result = math_approx_least_sq_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_approx_least_sq_layer_add(a : MathapproxleastsqLayer, b : MathapproxleastsqLayer) -> MathapproxleastsqLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_approx_least_sq_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_approx_least_sq_layer_copy(s : MathapproxleastsqLayer) -> MathapproxleastsqLayer {
  let result = math_approx_least_sq_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_approx_least_sq_layer_fill(s : MathapproxleastsqLayer, v : Double) -> MathapproxleastsqLayer {
  let result = math_approx_least_sq_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_approx_least_sq_layer_min(s : MathapproxleastsqLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_least_sq_layer_max(s : MathapproxleastsqLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_least_sq_layer_to_string(s : MathapproxleastsqLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxleastsqBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_least_sq_buffer_make(size : Int) -> MathapproxleastsqBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_least_sq_buffer_len(s : MathapproxleastsqBuffer) -> Int { s.size }

pub fn math_approx_least_sq_buffer_get(s : MathapproxleastsqBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_least_sq_buffer_set(s : MathapproxleastsqBuffer, i : Int, v : Double) -> MathapproxleastsqBuffer {
  let result = math_approx_least_sq_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_approx_least_sq_buffer_sum(s : MathapproxleastsqBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_approx_least_sq_buffer_mean(s : MathapproxleastsqBuffer) -> Double {
  if s.size == 0 { 0.0 } else { math_approx_least_sq_buffer_sum(s) / s.size.to_double() }
}

pub fn math_approx_least_sq_buffer_scale(s : MathapproxleastsqBuffer, f : Double) -> MathapproxleastsqBuffer {
  let result = math_approx_least_sq_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_approx_least_sq_buffer_add(a : MathapproxleastsqBuffer, b : MathapproxleastsqBuffer) -> MathapproxleastsqBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_approx_least_sq_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_approx_least_sq_buffer_copy(s : MathapproxleastsqBuffer) -> MathapproxleastsqBuffer {
  let result = math_approx_least_sq_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_approx_least_sq_buffer_fill(s : MathapproxleastsqBuffer, v : Double) -> MathapproxleastsqBuffer {
  let result = math_approx_least_sq_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_approx_least_sq_buffer_min(s : MathapproxleastsqBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_least_sq_buffer_max(s : MathapproxleastsqBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_least_sq_buffer_to_string(s : MathapproxleastsqBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxleastsqCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_least_sq_cursor_make(size : Int) -> MathapproxleastsqCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_least_sq_cursor_len(s : MathapproxleastsqCursor) -> Int { s.size }

pub fn math_approx_least_sq_cursor_get(s : MathapproxleastsqCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_least_sq_cursor_set(s : MathapproxleastsqCursor, i : Int, v : Double) -> MathapproxleastsqCursor {
  let result = math_approx_least_sq_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_approx_least_sq_cursor_sum(s : MathapproxleastsqCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_approx_least_sq_cursor_mean(s : MathapproxleastsqCursor) -> Double {
  if s.size == 0 { 0.0 } else { math_approx_least_sq_cursor_sum(s) / s.size.to_double() }
}

pub fn math_approx_least_sq_cursor_scale(s : MathapproxleastsqCursor, f : Double) -> MathapproxleastsqCursor {
  let result = math_approx_least_sq_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_approx_least_sq_cursor_add(a : MathapproxleastsqCursor, b : MathapproxleastsqCursor) -> MathapproxleastsqCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_approx_least_sq_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_approx_least_sq_cursor_copy(s : MathapproxleastsqCursor) -> MathapproxleastsqCursor {
  let result = math_approx_least_sq_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_approx_least_sq_cursor_fill(s : MathapproxleastsqCursor, v : Double) -> MathapproxleastsqCursor {
  let result = math_approx_least_sq_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_approx_least_sq_cursor_min(s : MathapproxleastsqCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_least_sq_cursor_max(s : MathapproxleastsqCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_least_sq_cursor_to_string(s : MathapproxleastsqCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxleastsqView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_least_sq_view_make(size : Int) -> MathapproxleastsqView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_least_sq_view_len(s : MathapproxleastsqView) -> Int { s.size }

pub fn math_approx_least_sq_view_get(s : MathapproxleastsqView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_least_sq_view_set(s : MathapproxleastsqView, i : Int, v : Double) -> MathapproxleastsqView {
  let result = math_approx_least_sq_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_approx_least_sq_view_sum(s : MathapproxleastsqView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_approx_least_sq_view_mean(s : MathapproxleastsqView) -> Double {
  if s.size == 0 { 0.0 } else { math_approx_least_sq_view_sum(s) / s.size.to_double() }
}

pub fn math_approx_least_sq_view_scale(s : MathapproxleastsqView, f : Double) -> MathapproxleastsqView {
  let result = math_approx_least_sq_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_approx_least_sq_view_add(a : MathapproxleastsqView, b : MathapproxleastsqView) -> MathapproxleastsqView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_approx_least_sq_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_approx_least_sq_view_copy(s : MathapproxleastsqView) -> MathapproxleastsqView {
  let result = math_approx_least_sq_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_approx_least_sq_view_fill(s : MathapproxleastsqView, v : Double) -> MathapproxleastsqView {
  let result = math_approx_least_sq_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_approx_least_sq_view_min(s : MathapproxleastsqView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_least_sq_view_max(s : MathapproxleastsqView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_least_sq_view_to_string(s : MathapproxleastsqView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxleastsqRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_least_sq_range_make(size : Int) -> MathapproxleastsqRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_least_sq_range_len(s : MathapproxleastsqRange) -> Int { s.size }

pub fn math_approx_least_sq_range_get(s : MathapproxleastsqRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_least_sq_range_set(s : MathapproxleastsqRange, i : Int, v : Double) -> MathapproxleastsqRange {
  let result = math_approx_least_sq_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_approx_least_sq_range_sum(s : MathapproxleastsqRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_approx_least_sq_range_mean(s : MathapproxleastsqRange) -> Double {
  if s.size == 0 { 0.0 } else { math_approx_least_sq_range_sum(s) / s.size.to_double() }
}

pub fn math_approx_least_sq_range_scale(s : MathapproxleastsqRange, f : Double) -> MathapproxleastsqRange {
  let result = math_approx_least_sq_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_approx_least_sq_range_add(a : MathapproxleastsqRange, b : MathapproxleastsqRange) -> MathapproxleastsqRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_approx_least_sq_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_approx_least_sq_range_copy(s : MathapproxleastsqRange) -> MathapproxleastsqRange {
  let result = math_approx_least_sq_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_approx_least_sq_range_fill(s : MathapproxleastsqRange, v : Double) -> MathapproxleastsqRange {
  let result = math_approx_least_sq_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_approx_least_sq_range_min(s : MathapproxleastsqRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_least_sq_range_max(s : MathapproxleastsqRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_least_sq_range_to_string(s : MathapproxleastsqRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxleastsqSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_least_sq_slice_make(size : Int) -> MathapproxleastsqSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_least_sq_slice_len(s : MathapproxleastsqSlice) -> Int { s.size }

pub fn math_approx_least_sq_slice_get(s : MathapproxleastsqSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_least_sq_slice_set(s : MathapproxleastsqSlice, i : Int, v : Double) -> MathapproxleastsqSlice {
  let result = math_approx_least_sq_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_approx_least_sq_slice_sum(s : MathapproxleastsqSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_approx_least_sq_slice_mean(s : MathapproxleastsqSlice) -> Double {
  if s.size == 0 { 0.0 } else { math_approx_least_sq_slice_sum(s) / s.size.to_double() }
}

pub fn math_approx_least_sq_slice_scale(s : MathapproxleastsqSlice, f : Double) -> MathapproxleastsqSlice {
  let result = math_approx_least_sq_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_approx_least_sq_slice_add(a : MathapproxleastsqSlice, b : MathapproxleastsqSlice) -> MathapproxleastsqSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_approx_least_sq_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_approx_least_sq_slice_copy(s : MathapproxleastsqSlice) -> MathapproxleastsqSlice {
  let result = math_approx_least_sq_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_approx_least_sq_slice_fill(s : MathapproxleastsqSlice, v : Double) -> MathapproxleastsqSlice {
  let result = math_approx_least_sq_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_approx_least_sq_slice_min(s : MathapproxleastsqSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_least_sq_slice_max(s : MathapproxleastsqSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_least_sq_slice_to_string(s : MathapproxleastsqSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

