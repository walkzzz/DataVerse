///===
/// extcore/math_approx_wavelet

pub(all) struct MathapproxwaveletPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn math_approx_wavelet_make_point(x : Double, y : Double) -> MathapproxwaveletPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn math_approx_wavelet_make_point3(x : Double, y : Double, z : Double) -> MathapproxwaveletPoint {
  { x, y, z, label: 0 }
}

pub fn math_approx_wavelet_point_x(pt : MathapproxwaveletPoint) -> Double { pt.x }

pub fn math_approx_wavelet_point_y(pt : MathapproxwaveletPoint) -> Double { pt.y }

pub fn math_approx_wavelet_point_z(pt : MathapproxwaveletPoint) -> Double { pt.z }

pub fn math_approx_wavelet_point_label(pt : MathapproxwaveletPoint) -> Int { pt.label }

pub fn math_approx_wavelet_point_dist(a : MathapproxwaveletPoint, b : MathapproxwaveletPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  math_approx_wavelet_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn math_approx_wavelet_point_add(a : MathapproxwaveletPoint, b : MathapproxwaveletPoint) -> MathapproxwaveletPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn math_approx_wavelet_point_sub(a : MathapproxwaveletPoint, b : MathapproxwaveletPoint) -> MathapproxwaveletPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn math_approx_wavelet_point_scale(pt : MathapproxwaveletPoint, s : Double) -> MathapproxwaveletPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn math_approx_wavelet_point_dot(a : MathapproxwaveletPoint, b : MathapproxwaveletPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn math_approx_wavelet_point_cross(a : MathapproxwaveletPoint, b : MathapproxwaveletPoint) -> MathapproxwaveletPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn math_approx_wavelet_point_norm(pt : MathapproxwaveletPoint) -> Double {
  math_approx_wavelet_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn math_approx_wavelet_point_normalize(pt : MathapproxwaveletPoint) -> MathapproxwaveletPoint {
  let n = math_approx_wavelet_point_norm(pt)
  if n < 0.0000001 { pt } else { math_approx_wavelet_point_scale(pt, 1.0 / n) }
}

pub fn math_approx_wavelet_point_negate(pt : MathapproxwaveletPoint) -> MathapproxwaveletPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn math_approx_wavelet_point_mid(a : MathapproxwaveletPoint, b : MathapproxwaveletPoint) -> MathapproxwaveletPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn math_approx_wavelet_point_lerp(a : MathapproxwaveletPoint, b : MathapproxwaveletPoint, t : Double) -> MathapproxwaveletPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn math_approx_wavelet_point_to_string(pt : MathapproxwaveletPoint) -> String {
  "(" + math_approx_wavelet_dbl(pt.x) + ", " + math_approx_wavelet_dbl(pt.y) + ", " + math_approx_wavelet_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct MathapproxwaveletSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn math_approx_wavelet_make_series(vals : Array[Double], name : String) -> MathapproxwaveletSeries {
  { vals, name, meta: 0 }
}

pub fn math_approx_wavelet_series_len(s : MathapproxwaveletSeries) -> Int { s.vals.length() }

pub fn math_approx_wavelet_series_sum(s : MathapproxwaveletSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn math_approx_wavelet_series_mean(s : MathapproxwaveletSeries) -> Double {
  let n = math_approx_wavelet_series_len(s)
  if n == 0 { 0.0 } else { math_approx_wavelet_series_sum(s) / n.to_double() }
}

pub fn math_approx_wavelet_series_min(s : MathapproxwaveletSeries) -> Double {
  let n = math_approx_wavelet_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn math_approx_wavelet_series_max(s : MathapproxwaveletSeries) -> Double {
  let n = math_approx_wavelet_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn math_approx_wavelet_series_range(s : MathapproxwaveletSeries) -> Double {
  math_approx_wavelet_series_max(s) - math_approx_wavelet_series_min(s)
}

pub fn math_approx_wavelet_series_var(s : MathapproxwaveletSeries) -> Double {
  let n = math_approx_wavelet_series_len(s)
  if n == 0 { 0.0 } else {
    let m = math_approx_wavelet_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn math_approx_wavelet_series_std(s : MathapproxwaveletSeries) -> Double { math_approx_wavelet_sqrt(math_approx_wavelet_series_var(s)) }

pub fn math_approx_wavelet_series_median(s : MathapproxwaveletSeries) -> Double {
  let n = math_approx_wavelet_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = math_approx_wavelet_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn math_approx_wavelet_series_scale(s : MathapproxwaveletSeries, f : Double) -> MathapproxwaveletSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = math_approx_wavelet_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn math_approx_wavelet_series_add(a : MathapproxwaveletSeries, b : MathapproxwaveletSeries) -> MathapproxwaveletSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = math_approx_wavelet_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn math_approx_wavelet_series_sub(a : MathapproxwaveletSeries, b : MathapproxwaveletSeries) -> MathapproxwaveletSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = math_approx_wavelet_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn math_approx_wavelet_series_normalize(s : MathapproxwaveletSeries) -> MathapproxwaveletSeries {
  let mn = math_approx_wavelet_series_min(s)
  let mx = math_approx_wavelet_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = math_approx_wavelet_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn math_approx_wavelet_series_cumsum(s : MathapproxwaveletSeries) -> MathapproxwaveletSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = math_approx_wavelet_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn math_approx_wavelet_series_to_string(s : MathapproxwaveletSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + math_approx_wavelet_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MathapproxwaveletMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn math_approx_wavelet_make_matrix(rows : Int, cols : Int, val : Double) -> MathapproxwaveletMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn math_approx_wavelet_matrix_identity(n : Int) -> MathapproxwaveletMatrix {
  let m = math_approx_wavelet_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn math_approx_wavelet_matrix_get(m : MathapproxwaveletMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn math_approx_wavelet_matrix_transpose(m : MathapproxwaveletMatrix) -> MathapproxwaveletMatrix {
  let result = math_approx_wavelet_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn math_approx_wavelet_matrix_add(a : MathapproxwaveletMatrix, b : MathapproxwaveletMatrix) -> MathapproxwaveletMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = math_approx_wavelet_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn math_approx_wavelet_matrix_scale(m : MathapproxwaveletMatrix, s : Double) -> MathapproxwaveletMatrix {
  let result = math_approx_wavelet_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn math_approx_wavelet_matrix_multiply(a : MathapproxwaveletMatrix, b : MathapproxwaveletMatrix) -> MathapproxwaveletMatrix {
  if a.cols != b.rows { return math_approx_wavelet_make_matrix(a.rows, b.cols, 0.0) }
  let result = math_approx_wavelet_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn math_approx_wavelet_matrix_trace(m : MathapproxwaveletMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn math_approx_wavelet_matrix_det(m : MathapproxwaveletMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn math_approx_wavelet_matrix_norm(m : MathapproxwaveletMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  math_approx_wavelet_sqrt(sum)
}

pub fn math_approx_wavelet_matrix_to_string(m : MathapproxwaveletMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + math_approx_wavelet_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct MathapproxwaveletVector {
  comps : Array[Double]
  dim : Int
}

pub fn math_approx_wavelet_make_vector(comps : Array[Double]) -> MathapproxwaveletVector {
  { comps, dim: comps.length() }
}

pub fn math_approx_wavelet_vector_zero(dim : Int) -> MathapproxwaveletVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn math_approx_wavelet_vector_add(a : MathapproxwaveletVector, b : MathapproxwaveletVector) -> MathapproxwaveletVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = math_approx_wavelet_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn math_approx_wavelet_vector_sub(a : MathapproxwaveletVector, b : MathapproxwaveletVector) -> MathapproxwaveletVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = math_approx_wavelet_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn math_approx_wavelet_vector_scale(v : MathapproxwaveletVector, s : Double) -> MathapproxwaveletVector {
  let mut result = []
  for i in 0..<v.dim { result = math_approx_wavelet_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn math_approx_wavelet_vector_dot(a : MathapproxwaveletVector, b : MathapproxwaveletVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn math_approx_wavelet_vector_norm(v : MathapproxwaveletVector) -> Double { math_approx_wavelet_sqrt(math_approx_wavelet_vector_dot(v, v)) }

pub fn math_approx_wavelet_vector_normalize(v : MathapproxwaveletVector) -> MathapproxwaveletVector {
  let n = math_approx_wavelet_vector_norm(v)
  if n < 0.0000001 { v } else { math_approx_wavelet_vector_scale(v, 1.0 / n) }
}

pub fn math_approx_wavelet_vector_dist(a : MathapproxwaveletVector, b : MathapproxwaveletVector) -> Double {
  math_approx_wavelet_vector_norm(math_approx_wavelet_vector_sub(a, b))
}

pub fn math_approx_wavelet_vector_to_string(v : MathapproxwaveletVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + math_approx_wavelet_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn math_approx_wavelet_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn math_approx_wavelet_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = math_approx_wavelet_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn math_approx_wavelet_std(data : Array[Double]) -> Double { math_approx_wavelet_sqrt(math_approx_wavelet_var(data)) }

pub fn math_approx_wavelet_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = math_approx_wavelet_mean(a); let mb = math_approx_wavelet_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn math_approx_wavelet_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = math_approx_wavelet_std(a); let sb = math_approx_wavelet_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { math_approx_wavelet_cov(a, b) / (sa * sb) }
}

pub fn math_approx_wavelet_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = math_approx_wavelet_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn math_approx_wavelet_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn math_approx_wavelet_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn math_approx_wavelet_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  math_approx_wavelet_sqrt(math_approx_wavelet_mse(pred, labels))
}

pub fn math_approx_wavelet_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + math_approx_wavelet_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn math_approx_wavelet_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = math_approx_wavelet_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn math_approx_wavelet_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn math_approx_wavelet_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn math_approx_wavelet_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = math_approx_wavelet_precision(pred, labels, pos); let r = math_approx_wavelet_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn math_approx_wavelet_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn math_approx_wavelet_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = math_approx_wavelet_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn math_approx_wavelet_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn math_approx_wavelet_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn math_approx_wavelet_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = math_approx_wavelet_gcd(a, b)
    (a / g) * b
  }
}

pub fn math_approx_wavelet_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn math_approx_wavelet_fibonacci(n : Int) -> Int {
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

pub fn math_approx_wavelet_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = math_approx_wavelet_min(data); let mx = math_approx_wavelet_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn math_approx_wavelet_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = math_approx_wavelet_mean(data); let sd = math_approx_wavelet_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn math_approx_wavelet_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn math_approx_wavelet_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn math_approx_wavelet_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn math_approx_wavelet_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn math_approx_wavelet_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn math_approx_wavelet_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn math_approx_wavelet_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn math_approx_wavelet_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn math_approx_wavelet_dbl(x : Double) -> String {
  let i = if x >= 0.0 { math_approx_wavelet_int(x) } else { -math_approx_wavelet_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { math_approx_wavelet_int(f * 1000000.0) } else { math_approx_wavelet_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn math_approx_wavelet_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn math_approx_wavelet_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct MathapproxwaveletFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_wavelet_frame_make(size : Int) -> MathapproxwaveletFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_wavelet_frame_len(s : MathapproxwaveletFrame) -> Int { s.size }

pub fn math_approx_wavelet_frame_get(s : MathapproxwaveletFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_wavelet_frame_set(s : MathapproxwaveletFrame, i : Int, v : Double) -> MathapproxwaveletFrame {
  let result = math_approx_wavelet_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_approx_wavelet_frame_sum(s : MathapproxwaveletFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_approx_wavelet_frame_mean(s : MathapproxwaveletFrame) -> Double {
  if s.size == 0 { 0.0 } else { math_approx_wavelet_frame_sum(s) / s.size.to_double() }
}

pub fn math_approx_wavelet_frame_scale(s : MathapproxwaveletFrame, f : Double) -> MathapproxwaveletFrame {
  let result = math_approx_wavelet_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_approx_wavelet_frame_add(a : MathapproxwaveletFrame, b : MathapproxwaveletFrame) -> MathapproxwaveletFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_approx_wavelet_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_approx_wavelet_frame_copy(s : MathapproxwaveletFrame) -> MathapproxwaveletFrame {
  let result = math_approx_wavelet_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_approx_wavelet_frame_fill(s : MathapproxwaveletFrame, v : Double) -> MathapproxwaveletFrame {
  let result = math_approx_wavelet_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_approx_wavelet_frame_min(s : MathapproxwaveletFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_wavelet_frame_max(s : MathapproxwaveletFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_wavelet_frame_to_string(s : MathapproxwaveletFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxwaveletTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_wavelet_table_make(size : Int) -> MathapproxwaveletTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_wavelet_table_len(s : MathapproxwaveletTable) -> Int { s.size }

pub fn math_approx_wavelet_table_get(s : MathapproxwaveletTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_wavelet_table_set(s : MathapproxwaveletTable, i : Int, v : Double) -> MathapproxwaveletTable {
  let result = math_approx_wavelet_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_approx_wavelet_table_sum(s : MathapproxwaveletTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_approx_wavelet_table_mean(s : MathapproxwaveletTable) -> Double {
  if s.size == 0 { 0.0 } else { math_approx_wavelet_table_sum(s) / s.size.to_double() }
}

pub fn math_approx_wavelet_table_scale(s : MathapproxwaveletTable, f : Double) -> MathapproxwaveletTable {
  let result = math_approx_wavelet_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_approx_wavelet_table_add(a : MathapproxwaveletTable, b : MathapproxwaveletTable) -> MathapproxwaveletTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_approx_wavelet_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_approx_wavelet_table_copy(s : MathapproxwaveletTable) -> MathapproxwaveletTable {
  let result = math_approx_wavelet_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_approx_wavelet_table_fill(s : MathapproxwaveletTable, v : Double) -> MathapproxwaveletTable {
  let result = math_approx_wavelet_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_approx_wavelet_table_min(s : MathapproxwaveletTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_wavelet_table_max(s : MathapproxwaveletTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_wavelet_table_to_string(s : MathapproxwaveletTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxwaveletGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_wavelet_graphn_make(size : Int) -> MathapproxwaveletGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_wavelet_graphn_len(s : MathapproxwaveletGraphN) -> Int { s.size }

pub fn math_approx_wavelet_graphn_get(s : MathapproxwaveletGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_wavelet_graphn_set(s : MathapproxwaveletGraphN, i : Int, v : Double) -> MathapproxwaveletGraphN {
  let result = math_approx_wavelet_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_approx_wavelet_graphn_sum(s : MathapproxwaveletGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_approx_wavelet_graphn_mean(s : MathapproxwaveletGraphN) -> Double {
  if s.size == 0 { 0.0 } else { math_approx_wavelet_graphn_sum(s) / s.size.to_double() }
}

pub fn math_approx_wavelet_graphn_scale(s : MathapproxwaveletGraphN, f : Double) -> MathapproxwaveletGraphN {
  let result = math_approx_wavelet_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_approx_wavelet_graphn_add(a : MathapproxwaveletGraphN, b : MathapproxwaveletGraphN) -> MathapproxwaveletGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_approx_wavelet_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_approx_wavelet_graphn_copy(s : MathapproxwaveletGraphN) -> MathapproxwaveletGraphN {
  let result = math_approx_wavelet_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_approx_wavelet_graphn_fill(s : MathapproxwaveletGraphN, v : Double) -> MathapproxwaveletGraphN {
  let result = math_approx_wavelet_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_approx_wavelet_graphn_min(s : MathapproxwaveletGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_wavelet_graphn_max(s : MathapproxwaveletGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_wavelet_graphn_to_string(s : MathapproxwaveletGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxwaveletNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_wavelet_node_make(size : Int) -> MathapproxwaveletNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_wavelet_node_len(s : MathapproxwaveletNode) -> Int { s.size }

pub fn math_approx_wavelet_node_get(s : MathapproxwaveletNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_wavelet_node_set(s : MathapproxwaveletNode, i : Int, v : Double) -> MathapproxwaveletNode {
  let result = math_approx_wavelet_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_approx_wavelet_node_sum(s : MathapproxwaveletNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_approx_wavelet_node_mean(s : MathapproxwaveletNode) -> Double {
  if s.size == 0 { 0.0 } else { math_approx_wavelet_node_sum(s) / s.size.to_double() }
}

pub fn math_approx_wavelet_node_scale(s : MathapproxwaveletNode, f : Double) -> MathapproxwaveletNode {
  let result = math_approx_wavelet_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_approx_wavelet_node_add(a : MathapproxwaveletNode, b : MathapproxwaveletNode) -> MathapproxwaveletNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_approx_wavelet_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_approx_wavelet_node_copy(s : MathapproxwaveletNode) -> MathapproxwaveletNode {
  let result = math_approx_wavelet_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_approx_wavelet_node_fill(s : MathapproxwaveletNode, v : Double) -> MathapproxwaveletNode {
  let result = math_approx_wavelet_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_approx_wavelet_node_min(s : MathapproxwaveletNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_wavelet_node_max(s : MathapproxwaveletNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_wavelet_node_to_string(s : MathapproxwaveletNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxwaveletEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_wavelet_edge_make(size : Int) -> MathapproxwaveletEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_wavelet_edge_len(s : MathapproxwaveletEdge) -> Int { s.size }

pub fn math_approx_wavelet_edge_get(s : MathapproxwaveletEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_wavelet_edge_set(s : MathapproxwaveletEdge, i : Int, v : Double) -> MathapproxwaveletEdge {
  let result = math_approx_wavelet_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_approx_wavelet_edge_sum(s : MathapproxwaveletEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_approx_wavelet_edge_mean(s : MathapproxwaveletEdge) -> Double {
  if s.size == 0 { 0.0 } else { math_approx_wavelet_edge_sum(s) / s.size.to_double() }
}

pub fn math_approx_wavelet_edge_scale(s : MathapproxwaveletEdge, f : Double) -> MathapproxwaveletEdge {
  let result = math_approx_wavelet_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_approx_wavelet_edge_add(a : MathapproxwaveletEdge, b : MathapproxwaveletEdge) -> MathapproxwaveletEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_approx_wavelet_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_approx_wavelet_edge_copy(s : MathapproxwaveletEdge) -> MathapproxwaveletEdge {
  let result = math_approx_wavelet_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_approx_wavelet_edge_fill(s : MathapproxwaveletEdge, v : Double) -> MathapproxwaveletEdge {
  let result = math_approx_wavelet_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_approx_wavelet_edge_min(s : MathapproxwaveletEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_wavelet_edge_max(s : MathapproxwaveletEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_wavelet_edge_to_string(s : MathapproxwaveletEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxwaveletPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_wavelet_path_make(size : Int) -> MathapproxwaveletPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_wavelet_path_len(s : MathapproxwaveletPath) -> Int { s.size }

pub fn math_approx_wavelet_path_get(s : MathapproxwaveletPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_wavelet_path_set(s : MathapproxwaveletPath, i : Int, v : Double) -> MathapproxwaveletPath {
  let result = math_approx_wavelet_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_approx_wavelet_path_sum(s : MathapproxwaveletPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_approx_wavelet_path_mean(s : MathapproxwaveletPath) -> Double {
  if s.size == 0 { 0.0 } else { math_approx_wavelet_path_sum(s) / s.size.to_double() }
}

pub fn math_approx_wavelet_path_scale(s : MathapproxwaveletPath, f : Double) -> MathapproxwaveletPath {
  let result = math_approx_wavelet_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_approx_wavelet_path_add(a : MathapproxwaveletPath, b : MathapproxwaveletPath) -> MathapproxwaveletPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_approx_wavelet_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_approx_wavelet_path_copy(s : MathapproxwaveletPath) -> MathapproxwaveletPath {
  let result = math_approx_wavelet_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_approx_wavelet_path_fill(s : MathapproxwaveletPath, v : Double) -> MathapproxwaveletPath {
  let result = math_approx_wavelet_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_approx_wavelet_path_min(s : MathapproxwaveletPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_wavelet_path_max(s : MathapproxwaveletPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_wavelet_path_to_string(s : MathapproxwaveletPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxwaveletCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_wavelet_cluster_make(size : Int) -> MathapproxwaveletCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_wavelet_cluster_len(s : MathapproxwaveletCluster) -> Int { s.size }

pub fn math_approx_wavelet_cluster_get(s : MathapproxwaveletCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_wavelet_cluster_set(s : MathapproxwaveletCluster, i : Int, v : Double) -> MathapproxwaveletCluster {
  let result = math_approx_wavelet_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_approx_wavelet_cluster_sum(s : MathapproxwaveletCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_approx_wavelet_cluster_mean(s : MathapproxwaveletCluster) -> Double {
  if s.size == 0 { 0.0 } else { math_approx_wavelet_cluster_sum(s) / s.size.to_double() }
}

pub fn math_approx_wavelet_cluster_scale(s : MathapproxwaveletCluster, f : Double) -> MathapproxwaveletCluster {
  let result = math_approx_wavelet_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_approx_wavelet_cluster_add(a : MathapproxwaveletCluster, b : MathapproxwaveletCluster) -> MathapproxwaveletCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_approx_wavelet_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_approx_wavelet_cluster_copy(s : MathapproxwaveletCluster) -> MathapproxwaveletCluster {
  let result = math_approx_wavelet_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_approx_wavelet_cluster_fill(s : MathapproxwaveletCluster, v : Double) -> MathapproxwaveletCluster {
  let result = math_approx_wavelet_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_approx_wavelet_cluster_min(s : MathapproxwaveletCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_wavelet_cluster_max(s : MathapproxwaveletCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_wavelet_cluster_to_string(s : MathapproxwaveletCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxwaveletModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_wavelet_model_make(size : Int) -> MathapproxwaveletModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_wavelet_model_len(s : MathapproxwaveletModel) -> Int { s.size }

pub fn math_approx_wavelet_model_get(s : MathapproxwaveletModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_wavelet_model_set(s : MathapproxwaveletModel, i : Int, v : Double) -> MathapproxwaveletModel {
  let result = math_approx_wavelet_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_approx_wavelet_model_sum(s : MathapproxwaveletModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_approx_wavelet_model_mean(s : MathapproxwaveletModel) -> Double {
  if s.size == 0 { 0.0 } else { math_approx_wavelet_model_sum(s) / s.size.to_double() }
}

pub fn math_approx_wavelet_model_scale(s : MathapproxwaveletModel, f : Double) -> MathapproxwaveletModel {
  let result = math_approx_wavelet_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_approx_wavelet_model_add(a : MathapproxwaveletModel, b : MathapproxwaveletModel) -> MathapproxwaveletModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_approx_wavelet_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_approx_wavelet_model_copy(s : MathapproxwaveletModel) -> MathapproxwaveletModel {
  let result = math_approx_wavelet_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_approx_wavelet_model_fill(s : MathapproxwaveletModel, v : Double) -> MathapproxwaveletModel {
  let result = math_approx_wavelet_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_approx_wavelet_model_min(s : MathapproxwaveletModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_wavelet_model_max(s : MathapproxwaveletModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_wavelet_model_to_string(s : MathapproxwaveletModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxwaveletLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_wavelet_layer_make(size : Int) -> MathapproxwaveletLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_wavelet_layer_len(s : MathapproxwaveletLayer) -> Int { s.size }

pub fn math_approx_wavelet_layer_get(s : MathapproxwaveletLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_wavelet_layer_set(s : MathapproxwaveletLayer, i : Int, v : Double) -> MathapproxwaveletLayer {
  let result = math_approx_wavelet_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_approx_wavelet_layer_sum(s : MathapproxwaveletLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_approx_wavelet_layer_mean(s : MathapproxwaveletLayer) -> Double {
  if s.size == 0 { 0.0 } else { math_approx_wavelet_layer_sum(s) / s.size.to_double() }
}

pub fn math_approx_wavelet_layer_scale(s : MathapproxwaveletLayer, f : Double) -> MathapproxwaveletLayer {
  let result = math_approx_wavelet_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_approx_wavelet_layer_add(a : MathapproxwaveletLayer, b : MathapproxwaveletLayer) -> MathapproxwaveletLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_approx_wavelet_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_approx_wavelet_layer_copy(s : MathapproxwaveletLayer) -> MathapproxwaveletLayer {
  let result = math_approx_wavelet_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_approx_wavelet_layer_fill(s : MathapproxwaveletLayer, v : Double) -> MathapproxwaveletLayer {
  let result = math_approx_wavelet_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_approx_wavelet_layer_min(s : MathapproxwaveletLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_wavelet_layer_max(s : MathapproxwaveletLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_wavelet_layer_to_string(s : MathapproxwaveletLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxwaveletBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_wavelet_buffer_make(size : Int) -> MathapproxwaveletBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_wavelet_buffer_len(s : MathapproxwaveletBuffer) -> Int { s.size }

pub fn math_approx_wavelet_buffer_get(s : MathapproxwaveletBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_wavelet_buffer_set(s : MathapproxwaveletBuffer, i : Int, v : Double) -> MathapproxwaveletBuffer {
  let result = math_approx_wavelet_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_approx_wavelet_buffer_sum(s : MathapproxwaveletBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_approx_wavelet_buffer_mean(s : MathapproxwaveletBuffer) -> Double {
  if s.size == 0 { 0.0 } else { math_approx_wavelet_buffer_sum(s) / s.size.to_double() }
}

pub fn math_approx_wavelet_buffer_scale(s : MathapproxwaveletBuffer, f : Double) -> MathapproxwaveletBuffer {
  let result = math_approx_wavelet_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_approx_wavelet_buffer_add(a : MathapproxwaveletBuffer, b : MathapproxwaveletBuffer) -> MathapproxwaveletBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_approx_wavelet_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_approx_wavelet_buffer_copy(s : MathapproxwaveletBuffer) -> MathapproxwaveletBuffer {
  let result = math_approx_wavelet_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_approx_wavelet_buffer_fill(s : MathapproxwaveletBuffer, v : Double) -> MathapproxwaveletBuffer {
  let result = math_approx_wavelet_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_approx_wavelet_buffer_min(s : MathapproxwaveletBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_wavelet_buffer_max(s : MathapproxwaveletBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_wavelet_buffer_to_string(s : MathapproxwaveletBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxwaveletCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_wavelet_cursor_make(size : Int) -> MathapproxwaveletCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_wavelet_cursor_len(s : MathapproxwaveletCursor) -> Int { s.size }

pub fn math_approx_wavelet_cursor_get(s : MathapproxwaveletCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_wavelet_cursor_set(s : MathapproxwaveletCursor, i : Int, v : Double) -> MathapproxwaveletCursor {
  let result = math_approx_wavelet_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_approx_wavelet_cursor_sum(s : MathapproxwaveletCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_approx_wavelet_cursor_mean(s : MathapproxwaveletCursor) -> Double {
  if s.size == 0 { 0.0 } else { math_approx_wavelet_cursor_sum(s) / s.size.to_double() }
}

pub fn math_approx_wavelet_cursor_scale(s : MathapproxwaveletCursor, f : Double) -> MathapproxwaveletCursor {
  let result = math_approx_wavelet_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_approx_wavelet_cursor_add(a : MathapproxwaveletCursor, b : MathapproxwaveletCursor) -> MathapproxwaveletCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_approx_wavelet_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_approx_wavelet_cursor_copy(s : MathapproxwaveletCursor) -> MathapproxwaveletCursor {
  let result = math_approx_wavelet_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_approx_wavelet_cursor_fill(s : MathapproxwaveletCursor, v : Double) -> MathapproxwaveletCursor {
  let result = math_approx_wavelet_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_approx_wavelet_cursor_min(s : MathapproxwaveletCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_wavelet_cursor_max(s : MathapproxwaveletCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_wavelet_cursor_to_string(s : MathapproxwaveletCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxwaveletView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_wavelet_view_make(size : Int) -> MathapproxwaveletView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_wavelet_view_len(s : MathapproxwaveletView) -> Int { s.size }

pub fn math_approx_wavelet_view_get(s : MathapproxwaveletView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_wavelet_view_set(s : MathapproxwaveletView, i : Int, v : Double) -> MathapproxwaveletView {
  let result = math_approx_wavelet_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_approx_wavelet_view_sum(s : MathapproxwaveletView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_approx_wavelet_view_mean(s : MathapproxwaveletView) -> Double {
  if s.size == 0 { 0.0 } else { math_approx_wavelet_view_sum(s) / s.size.to_double() }
}

pub fn math_approx_wavelet_view_scale(s : MathapproxwaveletView, f : Double) -> MathapproxwaveletView {
  let result = math_approx_wavelet_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_approx_wavelet_view_add(a : MathapproxwaveletView, b : MathapproxwaveletView) -> MathapproxwaveletView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_approx_wavelet_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_approx_wavelet_view_copy(s : MathapproxwaveletView) -> MathapproxwaveletView {
  let result = math_approx_wavelet_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_approx_wavelet_view_fill(s : MathapproxwaveletView, v : Double) -> MathapproxwaveletView {
  let result = math_approx_wavelet_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_approx_wavelet_view_min(s : MathapproxwaveletView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_wavelet_view_max(s : MathapproxwaveletView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_wavelet_view_to_string(s : MathapproxwaveletView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxwaveletRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_wavelet_range_make(size : Int) -> MathapproxwaveletRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_wavelet_range_len(s : MathapproxwaveletRange) -> Int { s.size }

pub fn math_approx_wavelet_range_get(s : MathapproxwaveletRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_wavelet_range_set(s : MathapproxwaveletRange, i : Int, v : Double) -> MathapproxwaveletRange {
  let result = math_approx_wavelet_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_approx_wavelet_range_sum(s : MathapproxwaveletRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_approx_wavelet_range_mean(s : MathapproxwaveletRange) -> Double {
  if s.size == 0 { 0.0 } else { math_approx_wavelet_range_sum(s) / s.size.to_double() }
}

pub fn math_approx_wavelet_range_scale(s : MathapproxwaveletRange, f : Double) -> MathapproxwaveletRange {
  let result = math_approx_wavelet_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_approx_wavelet_range_add(a : MathapproxwaveletRange, b : MathapproxwaveletRange) -> MathapproxwaveletRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_approx_wavelet_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_approx_wavelet_range_copy(s : MathapproxwaveletRange) -> MathapproxwaveletRange {
  let result = math_approx_wavelet_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_approx_wavelet_range_fill(s : MathapproxwaveletRange, v : Double) -> MathapproxwaveletRange {
  let result = math_approx_wavelet_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_approx_wavelet_range_min(s : MathapproxwaveletRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_wavelet_range_max(s : MathapproxwaveletRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_wavelet_range_to_string(s : MathapproxwaveletRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxwaveletSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_wavelet_slice_make(size : Int) -> MathapproxwaveletSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_wavelet_slice_len(s : MathapproxwaveletSlice) -> Int { s.size }

pub fn math_approx_wavelet_slice_get(s : MathapproxwaveletSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_wavelet_slice_set(s : MathapproxwaveletSlice, i : Int, v : Double) -> MathapproxwaveletSlice {
  let result = math_approx_wavelet_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_approx_wavelet_slice_sum(s : MathapproxwaveletSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_approx_wavelet_slice_mean(s : MathapproxwaveletSlice) -> Double {
  if s.size == 0 { 0.0 } else { math_approx_wavelet_slice_sum(s) / s.size.to_double() }
}

pub fn math_approx_wavelet_slice_scale(s : MathapproxwaveletSlice, f : Double) -> MathapproxwaveletSlice {
  let result = math_approx_wavelet_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_approx_wavelet_slice_add(a : MathapproxwaveletSlice, b : MathapproxwaveletSlice) -> MathapproxwaveletSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_approx_wavelet_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_approx_wavelet_slice_copy(s : MathapproxwaveletSlice) -> MathapproxwaveletSlice {
  let result = math_approx_wavelet_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_approx_wavelet_slice_fill(s : MathapproxwaveletSlice, v : Double) -> MathapproxwaveletSlice {
  let result = math_approx_wavelet_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_approx_wavelet_slice_min(s : MathapproxwaveletSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_wavelet_slice_max(s : MathapproxwaveletSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_wavelet_slice_to_string(s : MathapproxwaveletSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn math_approx_wavelet_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_approx_wavelet_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_approx_wavelet_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_approx_wavelet_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_approx_wavelet_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_approx_wavelet_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_approx_wavelet_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_approx_wavelet_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_approx_wavelet_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_approx_wavelet_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_approx_wavelet_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_approx_wavelet_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_approx_wavelet_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_approx_wavelet_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_approx_wavelet_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_approx_wavelet_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_approx_wavelet_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_approx_wavelet_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_approx_wavelet_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_approx_wavelet_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_approx_wavelet_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_approx_wavelet_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_approx_wavelet_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_approx_wavelet_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_approx_wavelet_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

