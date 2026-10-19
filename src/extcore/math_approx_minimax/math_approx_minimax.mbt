///===
/// extcore/math_approx_minimax

pub(all) struct MathapproxminimaxPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn math_approx_minimax_make_point(x : Double, y : Double) -> MathapproxminimaxPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn math_approx_minimax_make_point3(x : Double, y : Double, z : Double) -> MathapproxminimaxPoint {
  { x, y, z, label: 0 }
}

pub fn math_approx_minimax_point_x(pt : MathapproxminimaxPoint) -> Double { pt.x }

pub fn math_approx_minimax_point_y(pt : MathapproxminimaxPoint) -> Double { pt.y }

pub fn math_approx_minimax_point_z(pt : MathapproxminimaxPoint) -> Double { pt.z }

pub fn math_approx_minimax_point_label(pt : MathapproxminimaxPoint) -> Int { pt.label }

pub fn math_approx_minimax_point_dist(a : MathapproxminimaxPoint, b : MathapproxminimaxPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  math_approx_minimax_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn math_approx_minimax_point_add(a : MathapproxminimaxPoint, b : MathapproxminimaxPoint) -> MathapproxminimaxPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn math_approx_minimax_point_sub(a : MathapproxminimaxPoint, b : MathapproxminimaxPoint) -> MathapproxminimaxPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn math_approx_minimax_point_scale(pt : MathapproxminimaxPoint, s : Double) -> MathapproxminimaxPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn math_approx_minimax_point_dot(a : MathapproxminimaxPoint, b : MathapproxminimaxPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn math_approx_minimax_point_cross(a : MathapproxminimaxPoint, b : MathapproxminimaxPoint) -> MathapproxminimaxPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn math_approx_minimax_point_norm(pt : MathapproxminimaxPoint) -> Double {
  math_approx_minimax_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn math_approx_minimax_point_normalize(pt : MathapproxminimaxPoint) -> MathapproxminimaxPoint {
  let n = math_approx_minimax_point_norm(pt)
  if n < 0.0000001 { pt } else { math_approx_minimax_point_scale(pt, 1.0 / n) }
}

pub fn math_approx_minimax_point_negate(pt : MathapproxminimaxPoint) -> MathapproxminimaxPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn math_approx_minimax_point_mid(a : MathapproxminimaxPoint, b : MathapproxminimaxPoint) -> MathapproxminimaxPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn math_approx_minimax_point_lerp(a : MathapproxminimaxPoint, b : MathapproxminimaxPoint, t : Double) -> MathapproxminimaxPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn math_approx_minimax_point_to_string(pt : MathapproxminimaxPoint) -> String {
  "(" + math_approx_minimax_dbl(pt.x) + ", " + math_approx_minimax_dbl(pt.y) + ", " + math_approx_minimax_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct MathapproxminimaxSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn math_approx_minimax_make_series(vals : Array[Double], name : String) -> MathapproxminimaxSeries {
  { vals, name, meta: 0 }
}

pub fn math_approx_minimax_series_len(s : MathapproxminimaxSeries) -> Int { s.vals.length() }

pub fn math_approx_minimax_series_sum(s : MathapproxminimaxSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn math_approx_minimax_series_mean(s : MathapproxminimaxSeries) -> Double {
  let n = math_approx_minimax_series_len(s)
  if n == 0 { 0.0 } else { math_approx_minimax_series_sum(s) / n.to_double() }
}

pub fn math_approx_minimax_series_min(s : MathapproxminimaxSeries) -> Double {
  let n = math_approx_minimax_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn math_approx_minimax_series_max(s : MathapproxminimaxSeries) -> Double {
  let n = math_approx_minimax_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn math_approx_minimax_series_range(s : MathapproxminimaxSeries) -> Double {
  math_approx_minimax_series_max(s) - math_approx_minimax_series_min(s)
}

pub fn math_approx_minimax_series_var(s : MathapproxminimaxSeries) -> Double {
  let n = math_approx_minimax_series_len(s)
  if n == 0 { 0.0 } else {
    let m = math_approx_minimax_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn math_approx_minimax_series_std(s : MathapproxminimaxSeries) -> Double { math_approx_minimax_sqrt(math_approx_minimax_series_var(s)) }

pub fn math_approx_minimax_series_median(s : MathapproxminimaxSeries) -> Double {
  let n = math_approx_minimax_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = math_approx_minimax_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn math_approx_minimax_series_scale(s : MathapproxminimaxSeries, f : Double) -> MathapproxminimaxSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = math_approx_minimax_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn math_approx_minimax_series_add(a : MathapproxminimaxSeries, b : MathapproxminimaxSeries) -> MathapproxminimaxSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = math_approx_minimax_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn math_approx_minimax_series_sub(a : MathapproxminimaxSeries, b : MathapproxminimaxSeries) -> MathapproxminimaxSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = math_approx_minimax_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn math_approx_minimax_series_normalize(s : MathapproxminimaxSeries) -> MathapproxminimaxSeries {
  let mn = math_approx_minimax_series_min(s)
  let mx = math_approx_minimax_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = math_approx_minimax_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn math_approx_minimax_series_cumsum(s : MathapproxminimaxSeries) -> MathapproxminimaxSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = math_approx_minimax_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn math_approx_minimax_series_to_string(s : MathapproxminimaxSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + math_approx_minimax_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MathapproxminimaxMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn math_approx_minimax_make_matrix(rows : Int, cols : Int, val : Double) -> MathapproxminimaxMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn math_approx_minimax_matrix_identity(n : Int) -> MathapproxminimaxMatrix {
  let m = math_approx_minimax_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn math_approx_minimax_matrix_get(m : MathapproxminimaxMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn math_approx_minimax_matrix_transpose(m : MathapproxminimaxMatrix) -> MathapproxminimaxMatrix {
  let result = math_approx_minimax_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn math_approx_minimax_matrix_add(a : MathapproxminimaxMatrix, b : MathapproxminimaxMatrix) -> MathapproxminimaxMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = math_approx_minimax_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn math_approx_minimax_matrix_scale(m : MathapproxminimaxMatrix, s : Double) -> MathapproxminimaxMatrix {
  let result = math_approx_minimax_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn math_approx_minimax_matrix_multiply(a : MathapproxminimaxMatrix, b : MathapproxminimaxMatrix) -> MathapproxminimaxMatrix {
  if a.cols != b.rows { return math_approx_minimax_make_matrix(a.rows, b.cols, 0.0) }
  let result = math_approx_minimax_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn math_approx_minimax_matrix_trace(m : MathapproxminimaxMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn math_approx_minimax_matrix_det(m : MathapproxminimaxMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn math_approx_minimax_matrix_norm(m : MathapproxminimaxMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  math_approx_minimax_sqrt(sum)
}

pub fn math_approx_minimax_matrix_to_string(m : MathapproxminimaxMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + math_approx_minimax_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct MathapproxminimaxVector {
  comps : Array[Double]
  dim : Int
}

pub fn math_approx_minimax_make_vector(comps : Array[Double]) -> MathapproxminimaxVector {
  { comps, dim: comps.length() }
}

pub fn math_approx_minimax_vector_zero(dim : Int) -> MathapproxminimaxVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn math_approx_minimax_vector_add(a : MathapproxminimaxVector, b : MathapproxminimaxVector) -> MathapproxminimaxVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = math_approx_minimax_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn math_approx_minimax_vector_sub(a : MathapproxminimaxVector, b : MathapproxminimaxVector) -> MathapproxminimaxVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = math_approx_minimax_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn math_approx_minimax_vector_scale(v : MathapproxminimaxVector, s : Double) -> MathapproxminimaxVector {
  let mut result = []
  for i in 0..<v.dim { result = math_approx_minimax_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn math_approx_minimax_vector_dot(a : MathapproxminimaxVector, b : MathapproxminimaxVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn math_approx_minimax_vector_norm(v : MathapproxminimaxVector) -> Double { math_approx_minimax_sqrt(math_approx_minimax_vector_dot(v, v)) }

pub fn math_approx_minimax_vector_normalize(v : MathapproxminimaxVector) -> MathapproxminimaxVector {
  let n = math_approx_minimax_vector_norm(v)
  if n < 0.0000001 { v } else { math_approx_minimax_vector_scale(v, 1.0 / n) }
}

pub fn math_approx_minimax_vector_dist(a : MathapproxminimaxVector, b : MathapproxminimaxVector) -> Double {
  math_approx_minimax_vector_norm(math_approx_minimax_vector_sub(a, b))
}

pub fn math_approx_minimax_vector_to_string(v : MathapproxminimaxVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + math_approx_minimax_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn math_approx_minimax_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn math_approx_minimax_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = math_approx_minimax_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn math_approx_minimax_std(data : Array[Double]) -> Double { math_approx_minimax_sqrt(math_approx_minimax_var(data)) }

pub fn math_approx_minimax_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = math_approx_minimax_mean(a); let mb = math_approx_minimax_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn math_approx_minimax_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = math_approx_minimax_std(a); let sb = math_approx_minimax_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { math_approx_minimax_cov(a, b) / (sa * sb) }
}

pub fn math_approx_minimax_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = math_approx_minimax_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn math_approx_minimax_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn math_approx_minimax_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn math_approx_minimax_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  math_approx_minimax_sqrt(math_approx_minimax_mse(pred, labels))
}

pub fn math_approx_minimax_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + math_approx_minimax_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn math_approx_minimax_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = math_approx_minimax_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn math_approx_minimax_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn math_approx_minimax_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn math_approx_minimax_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = math_approx_minimax_precision(pred, labels, pos); let r = math_approx_minimax_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn math_approx_minimax_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn math_approx_minimax_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = math_approx_minimax_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn math_approx_minimax_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn math_approx_minimax_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn math_approx_minimax_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = math_approx_minimax_gcd(a, b)
    (a / g) * b
  }
}

pub fn math_approx_minimax_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn math_approx_minimax_fibonacci(n : Int) -> Int {
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

pub fn math_approx_minimax_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = math_approx_minimax_min(data); let mx = math_approx_minimax_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn math_approx_minimax_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = math_approx_minimax_mean(data); let sd = math_approx_minimax_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn math_approx_minimax_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn math_approx_minimax_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn math_approx_minimax_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn math_approx_minimax_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn math_approx_minimax_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn math_approx_minimax_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn math_approx_minimax_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn math_approx_minimax_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn math_approx_minimax_dbl(x : Double) -> String {
  let i = if x >= 0.0 { math_approx_minimax_int(x) } else { -math_approx_minimax_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { math_approx_minimax_int(f * 1000000.0) } else { math_approx_minimax_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn math_approx_minimax_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn math_approx_minimax_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct MathapproxminimaxFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_minimax_frame_make(size : Int) -> MathapproxminimaxFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_minimax_frame_len(s : MathapproxminimaxFrame) -> Int { s.size }

pub fn math_approx_minimax_frame_get(s : MathapproxminimaxFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_minimax_frame_set(s : MathapproxminimaxFrame, i : Int, v : Double) -> MathapproxminimaxFrame {
  let result = math_approx_minimax_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_approx_minimax_frame_sum(s : MathapproxminimaxFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_approx_minimax_frame_mean(s : MathapproxminimaxFrame) -> Double {
  if s.size == 0 { 0.0 } else { math_approx_minimax_frame_sum(s) / s.size.to_double() }
}

pub fn math_approx_minimax_frame_scale(s : MathapproxminimaxFrame, f : Double) -> MathapproxminimaxFrame {
  let result = math_approx_minimax_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_approx_minimax_frame_add(a : MathapproxminimaxFrame, b : MathapproxminimaxFrame) -> MathapproxminimaxFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_approx_minimax_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_approx_minimax_frame_copy(s : MathapproxminimaxFrame) -> MathapproxminimaxFrame {
  let result = math_approx_minimax_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_approx_minimax_frame_fill(s : MathapproxminimaxFrame, v : Double) -> MathapproxminimaxFrame {
  let result = math_approx_minimax_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_approx_minimax_frame_min(s : MathapproxminimaxFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_minimax_frame_max(s : MathapproxminimaxFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_minimax_frame_to_string(s : MathapproxminimaxFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxminimaxTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_minimax_table_make(size : Int) -> MathapproxminimaxTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_minimax_table_len(s : MathapproxminimaxTable) -> Int { s.size }

pub fn math_approx_minimax_table_get(s : MathapproxminimaxTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_minimax_table_set(s : MathapproxminimaxTable, i : Int, v : Double) -> MathapproxminimaxTable {
  let result = math_approx_minimax_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_approx_minimax_table_sum(s : MathapproxminimaxTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_approx_minimax_table_mean(s : MathapproxminimaxTable) -> Double {
  if s.size == 0 { 0.0 } else { math_approx_minimax_table_sum(s) / s.size.to_double() }
}

pub fn math_approx_minimax_table_scale(s : MathapproxminimaxTable, f : Double) -> MathapproxminimaxTable {
  let result = math_approx_minimax_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_approx_minimax_table_add(a : MathapproxminimaxTable, b : MathapproxminimaxTable) -> MathapproxminimaxTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_approx_minimax_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_approx_minimax_table_copy(s : MathapproxminimaxTable) -> MathapproxminimaxTable {
  let result = math_approx_minimax_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_approx_minimax_table_fill(s : MathapproxminimaxTable, v : Double) -> MathapproxminimaxTable {
  let result = math_approx_minimax_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_approx_minimax_table_min(s : MathapproxminimaxTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_minimax_table_max(s : MathapproxminimaxTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_minimax_table_to_string(s : MathapproxminimaxTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxminimaxGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_minimax_graphn_make(size : Int) -> MathapproxminimaxGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_minimax_graphn_len(s : MathapproxminimaxGraphN) -> Int { s.size }

pub fn math_approx_minimax_graphn_get(s : MathapproxminimaxGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_minimax_graphn_set(s : MathapproxminimaxGraphN, i : Int, v : Double) -> MathapproxminimaxGraphN {
  let result = math_approx_minimax_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_approx_minimax_graphn_sum(s : MathapproxminimaxGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_approx_minimax_graphn_mean(s : MathapproxminimaxGraphN) -> Double {
  if s.size == 0 { 0.0 } else { math_approx_minimax_graphn_sum(s) / s.size.to_double() }
}

pub fn math_approx_minimax_graphn_scale(s : MathapproxminimaxGraphN, f : Double) -> MathapproxminimaxGraphN {
  let result = math_approx_minimax_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_approx_minimax_graphn_add(a : MathapproxminimaxGraphN, b : MathapproxminimaxGraphN) -> MathapproxminimaxGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_approx_minimax_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_approx_minimax_graphn_copy(s : MathapproxminimaxGraphN) -> MathapproxminimaxGraphN {
  let result = math_approx_minimax_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_approx_minimax_graphn_fill(s : MathapproxminimaxGraphN, v : Double) -> MathapproxminimaxGraphN {
  let result = math_approx_minimax_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_approx_minimax_graphn_min(s : MathapproxminimaxGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_minimax_graphn_max(s : MathapproxminimaxGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_minimax_graphn_to_string(s : MathapproxminimaxGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxminimaxNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_minimax_node_make(size : Int) -> MathapproxminimaxNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_minimax_node_len(s : MathapproxminimaxNode) -> Int { s.size }

pub fn math_approx_minimax_node_get(s : MathapproxminimaxNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_minimax_node_set(s : MathapproxminimaxNode, i : Int, v : Double) -> MathapproxminimaxNode {
  let result = math_approx_minimax_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_approx_minimax_node_sum(s : MathapproxminimaxNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_approx_minimax_node_mean(s : MathapproxminimaxNode) -> Double {
  if s.size == 0 { 0.0 } else { math_approx_minimax_node_sum(s) / s.size.to_double() }
}

pub fn math_approx_minimax_node_scale(s : MathapproxminimaxNode, f : Double) -> MathapproxminimaxNode {
  let result = math_approx_minimax_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_approx_minimax_node_add(a : MathapproxminimaxNode, b : MathapproxminimaxNode) -> MathapproxminimaxNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_approx_minimax_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_approx_minimax_node_copy(s : MathapproxminimaxNode) -> MathapproxminimaxNode {
  let result = math_approx_minimax_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_approx_minimax_node_fill(s : MathapproxminimaxNode, v : Double) -> MathapproxminimaxNode {
  let result = math_approx_minimax_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_approx_minimax_node_min(s : MathapproxminimaxNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_minimax_node_max(s : MathapproxminimaxNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_minimax_node_to_string(s : MathapproxminimaxNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxminimaxEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_minimax_edge_make(size : Int) -> MathapproxminimaxEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_minimax_edge_len(s : MathapproxminimaxEdge) -> Int { s.size }

pub fn math_approx_minimax_edge_get(s : MathapproxminimaxEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_minimax_edge_set(s : MathapproxminimaxEdge, i : Int, v : Double) -> MathapproxminimaxEdge {
  let result = math_approx_minimax_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_approx_minimax_edge_sum(s : MathapproxminimaxEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_approx_minimax_edge_mean(s : MathapproxminimaxEdge) -> Double {
  if s.size == 0 { 0.0 } else { math_approx_minimax_edge_sum(s) / s.size.to_double() }
}

pub fn math_approx_minimax_edge_scale(s : MathapproxminimaxEdge, f : Double) -> MathapproxminimaxEdge {
  let result = math_approx_minimax_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_approx_minimax_edge_add(a : MathapproxminimaxEdge, b : MathapproxminimaxEdge) -> MathapproxminimaxEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_approx_minimax_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_approx_minimax_edge_copy(s : MathapproxminimaxEdge) -> MathapproxminimaxEdge {
  let result = math_approx_minimax_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_approx_minimax_edge_fill(s : MathapproxminimaxEdge, v : Double) -> MathapproxminimaxEdge {
  let result = math_approx_minimax_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_approx_minimax_edge_min(s : MathapproxminimaxEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_minimax_edge_max(s : MathapproxminimaxEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_minimax_edge_to_string(s : MathapproxminimaxEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxminimaxPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_minimax_path_make(size : Int) -> MathapproxminimaxPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_minimax_path_len(s : MathapproxminimaxPath) -> Int { s.size }

pub fn math_approx_minimax_path_get(s : MathapproxminimaxPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_minimax_path_set(s : MathapproxminimaxPath, i : Int, v : Double) -> MathapproxminimaxPath {
  let result = math_approx_minimax_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_approx_minimax_path_sum(s : MathapproxminimaxPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_approx_minimax_path_mean(s : MathapproxminimaxPath) -> Double {
  if s.size == 0 { 0.0 } else { math_approx_minimax_path_sum(s) / s.size.to_double() }
}

pub fn math_approx_minimax_path_scale(s : MathapproxminimaxPath, f : Double) -> MathapproxminimaxPath {
  let result = math_approx_minimax_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_approx_minimax_path_add(a : MathapproxminimaxPath, b : MathapproxminimaxPath) -> MathapproxminimaxPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_approx_minimax_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_approx_minimax_path_copy(s : MathapproxminimaxPath) -> MathapproxminimaxPath {
  let result = math_approx_minimax_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_approx_minimax_path_fill(s : MathapproxminimaxPath, v : Double) -> MathapproxminimaxPath {
  let result = math_approx_minimax_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_approx_minimax_path_min(s : MathapproxminimaxPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_minimax_path_max(s : MathapproxminimaxPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_minimax_path_to_string(s : MathapproxminimaxPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxminimaxCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_minimax_cluster_make(size : Int) -> MathapproxminimaxCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_minimax_cluster_len(s : MathapproxminimaxCluster) -> Int { s.size }

pub fn math_approx_minimax_cluster_get(s : MathapproxminimaxCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_minimax_cluster_set(s : MathapproxminimaxCluster, i : Int, v : Double) -> MathapproxminimaxCluster {
  let result = math_approx_minimax_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_approx_minimax_cluster_sum(s : MathapproxminimaxCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_approx_minimax_cluster_mean(s : MathapproxminimaxCluster) -> Double {
  if s.size == 0 { 0.0 } else { math_approx_minimax_cluster_sum(s) / s.size.to_double() }
}

pub fn math_approx_minimax_cluster_scale(s : MathapproxminimaxCluster, f : Double) -> MathapproxminimaxCluster {
  let result = math_approx_minimax_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_approx_minimax_cluster_add(a : MathapproxminimaxCluster, b : MathapproxminimaxCluster) -> MathapproxminimaxCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_approx_minimax_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_approx_minimax_cluster_copy(s : MathapproxminimaxCluster) -> MathapproxminimaxCluster {
  let result = math_approx_minimax_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_approx_minimax_cluster_fill(s : MathapproxminimaxCluster, v : Double) -> MathapproxminimaxCluster {
  let result = math_approx_minimax_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_approx_minimax_cluster_min(s : MathapproxminimaxCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_minimax_cluster_max(s : MathapproxminimaxCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_minimax_cluster_to_string(s : MathapproxminimaxCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxminimaxModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_minimax_model_make(size : Int) -> MathapproxminimaxModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_minimax_model_len(s : MathapproxminimaxModel) -> Int { s.size }

pub fn math_approx_minimax_model_get(s : MathapproxminimaxModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_minimax_model_set(s : MathapproxminimaxModel, i : Int, v : Double) -> MathapproxminimaxModel {
  let result = math_approx_minimax_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_approx_minimax_model_sum(s : MathapproxminimaxModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_approx_minimax_model_mean(s : MathapproxminimaxModel) -> Double {
  if s.size == 0 { 0.0 } else { math_approx_minimax_model_sum(s) / s.size.to_double() }
}

pub fn math_approx_minimax_model_scale(s : MathapproxminimaxModel, f : Double) -> MathapproxminimaxModel {
  let result = math_approx_minimax_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_approx_minimax_model_add(a : MathapproxminimaxModel, b : MathapproxminimaxModel) -> MathapproxminimaxModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_approx_minimax_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_approx_minimax_model_copy(s : MathapproxminimaxModel) -> MathapproxminimaxModel {
  let result = math_approx_minimax_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_approx_minimax_model_fill(s : MathapproxminimaxModel, v : Double) -> MathapproxminimaxModel {
  let result = math_approx_minimax_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_approx_minimax_model_min(s : MathapproxminimaxModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_minimax_model_max(s : MathapproxminimaxModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_minimax_model_to_string(s : MathapproxminimaxModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxminimaxLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_minimax_layer_make(size : Int) -> MathapproxminimaxLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_minimax_layer_len(s : MathapproxminimaxLayer) -> Int { s.size }

pub fn math_approx_minimax_layer_get(s : MathapproxminimaxLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_minimax_layer_set(s : MathapproxminimaxLayer, i : Int, v : Double) -> MathapproxminimaxLayer {
  let result = math_approx_minimax_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_approx_minimax_layer_sum(s : MathapproxminimaxLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_approx_minimax_layer_mean(s : MathapproxminimaxLayer) -> Double {
  if s.size == 0 { 0.0 } else { math_approx_minimax_layer_sum(s) / s.size.to_double() }
}

pub fn math_approx_minimax_layer_scale(s : MathapproxminimaxLayer, f : Double) -> MathapproxminimaxLayer {
  let result = math_approx_minimax_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_approx_minimax_layer_add(a : MathapproxminimaxLayer, b : MathapproxminimaxLayer) -> MathapproxminimaxLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_approx_minimax_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_approx_minimax_layer_copy(s : MathapproxminimaxLayer) -> MathapproxminimaxLayer {
  let result = math_approx_minimax_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_approx_minimax_layer_fill(s : MathapproxminimaxLayer, v : Double) -> MathapproxminimaxLayer {
  let result = math_approx_minimax_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_approx_minimax_layer_min(s : MathapproxminimaxLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_minimax_layer_max(s : MathapproxminimaxLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_minimax_layer_to_string(s : MathapproxminimaxLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxminimaxBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_minimax_buffer_make(size : Int) -> MathapproxminimaxBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_minimax_buffer_len(s : MathapproxminimaxBuffer) -> Int { s.size }

pub fn math_approx_minimax_buffer_get(s : MathapproxminimaxBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_minimax_buffer_set(s : MathapproxminimaxBuffer, i : Int, v : Double) -> MathapproxminimaxBuffer {
  let result = math_approx_minimax_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_approx_minimax_buffer_sum(s : MathapproxminimaxBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_approx_minimax_buffer_mean(s : MathapproxminimaxBuffer) -> Double {
  if s.size == 0 { 0.0 } else { math_approx_minimax_buffer_sum(s) / s.size.to_double() }
}

pub fn math_approx_minimax_buffer_scale(s : MathapproxminimaxBuffer, f : Double) -> MathapproxminimaxBuffer {
  let result = math_approx_minimax_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_approx_minimax_buffer_add(a : MathapproxminimaxBuffer, b : MathapproxminimaxBuffer) -> MathapproxminimaxBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_approx_minimax_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_approx_minimax_buffer_copy(s : MathapproxminimaxBuffer) -> MathapproxminimaxBuffer {
  let result = math_approx_minimax_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_approx_minimax_buffer_fill(s : MathapproxminimaxBuffer, v : Double) -> MathapproxminimaxBuffer {
  let result = math_approx_minimax_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_approx_minimax_buffer_min(s : MathapproxminimaxBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_minimax_buffer_max(s : MathapproxminimaxBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_minimax_buffer_to_string(s : MathapproxminimaxBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxminimaxCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_minimax_cursor_make(size : Int) -> MathapproxminimaxCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_minimax_cursor_len(s : MathapproxminimaxCursor) -> Int { s.size }

pub fn math_approx_minimax_cursor_get(s : MathapproxminimaxCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_minimax_cursor_set(s : MathapproxminimaxCursor, i : Int, v : Double) -> MathapproxminimaxCursor {
  let result = math_approx_minimax_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_approx_minimax_cursor_sum(s : MathapproxminimaxCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_approx_minimax_cursor_mean(s : MathapproxminimaxCursor) -> Double {
  if s.size == 0 { 0.0 } else { math_approx_minimax_cursor_sum(s) / s.size.to_double() }
}

pub fn math_approx_minimax_cursor_scale(s : MathapproxminimaxCursor, f : Double) -> MathapproxminimaxCursor {
  let result = math_approx_minimax_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_approx_minimax_cursor_add(a : MathapproxminimaxCursor, b : MathapproxminimaxCursor) -> MathapproxminimaxCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_approx_minimax_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_approx_minimax_cursor_copy(s : MathapproxminimaxCursor) -> MathapproxminimaxCursor {
  let result = math_approx_minimax_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_approx_minimax_cursor_fill(s : MathapproxminimaxCursor, v : Double) -> MathapproxminimaxCursor {
  let result = math_approx_minimax_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_approx_minimax_cursor_min(s : MathapproxminimaxCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_minimax_cursor_max(s : MathapproxminimaxCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_minimax_cursor_to_string(s : MathapproxminimaxCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxminimaxView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_minimax_view_make(size : Int) -> MathapproxminimaxView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_minimax_view_len(s : MathapproxminimaxView) -> Int { s.size }

pub fn math_approx_minimax_view_get(s : MathapproxminimaxView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_minimax_view_set(s : MathapproxminimaxView, i : Int, v : Double) -> MathapproxminimaxView {
  let result = math_approx_minimax_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_approx_minimax_view_sum(s : MathapproxminimaxView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_approx_minimax_view_mean(s : MathapproxminimaxView) -> Double {
  if s.size == 0 { 0.0 } else { math_approx_minimax_view_sum(s) / s.size.to_double() }
}

pub fn math_approx_minimax_view_scale(s : MathapproxminimaxView, f : Double) -> MathapproxminimaxView {
  let result = math_approx_minimax_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_approx_minimax_view_add(a : MathapproxminimaxView, b : MathapproxminimaxView) -> MathapproxminimaxView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_approx_minimax_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_approx_minimax_view_copy(s : MathapproxminimaxView) -> MathapproxminimaxView {
  let result = math_approx_minimax_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_approx_minimax_view_fill(s : MathapproxminimaxView, v : Double) -> MathapproxminimaxView {
  let result = math_approx_minimax_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_approx_minimax_view_min(s : MathapproxminimaxView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_minimax_view_max(s : MathapproxminimaxView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_minimax_view_to_string(s : MathapproxminimaxView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxminimaxRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_minimax_range_make(size : Int) -> MathapproxminimaxRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_minimax_range_len(s : MathapproxminimaxRange) -> Int { s.size }

pub fn math_approx_minimax_range_get(s : MathapproxminimaxRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_minimax_range_set(s : MathapproxminimaxRange, i : Int, v : Double) -> MathapproxminimaxRange {
  let result = math_approx_minimax_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_approx_minimax_range_sum(s : MathapproxminimaxRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_approx_minimax_range_mean(s : MathapproxminimaxRange) -> Double {
  if s.size == 0 { 0.0 } else { math_approx_minimax_range_sum(s) / s.size.to_double() }
}

pub fn math_approx_minimax_range_scale(s : MathapproxminimaxRange, f : Double) -> MathapproxminimaxRange {
  let result = math_approx_minimax_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_approx_minimax_range_add(a : MathapproxminimaxRange, b : MathapproxminimaxRange) -> MathapproxminimaxRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_approx_minimax_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_approx_minimax_range_copy(s : MathapproxminimaxRange) -> MathapproxminimaxRange {
  let result = math_approx_minimax_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_approx_minimax_range_fill(s : MathapproxminimaxRange, v : Double) -> MathapproxminimaxRange {
  let result = math_approx_minimax_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_approx_minimax_range_min(s : MathapproxminimaxRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_minimax_range_max(s : MathapproxminimaxRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_minimax_range_to_string(s : MathapproxminimaxRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxminimaxSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_minimax_slice_make(size : Int) -> MathapproxminimaxSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_minimax_slice_len(s : MathapproxminimaxSlice) -> Int { s.size }

pub fn math_approx_minimax_slice_get(s : MathapproxminimaxSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_minimax_slice_set(s : MathapproxminimaxSlice, i : Int, v : Double) -> MathapproxminimaxSlice {
  let result = math_approx_minimax_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_approx_minimax_slice_sum(s : MathapproxminimaxSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_approx_minimax_slice_mean(s : MathapproxminimaxSlice) -> Double {
  if s.size == 0 { 0.0 } else { math_approx_minimax_slice_sum(s) / s.size.to_double() }
}

pub fn math_approx_minimax_slice_scale(s : MathapproxminimaxSlice, f : Double) -> MathapproxminimaxSlice {
  let result = math_approx_minimax_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_approx_minimax_slice_add(a : MathapproxminimaxSlice, b : MathapproxminimaxSlice) -> MathapproxminimaxSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_approx_minimax_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_approx_minimax_slice_copy(s : MathapproxminimaxSlice) -> MathapproxminimaxSlice {
  let result = math_approx_minimax_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_approx_minimax_slice_fill(s : MathapproxminimaxSlice, v : Double) -> MathapproxminimaxSlice {
  let result = math_approx_minimax_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_approx_minimax_slice_min(s : MathapproxminimaxSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_minimax_slice_max(s : MathapproxminimaxSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_minimax_slice_to_string(s : MathapproxminimaxSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn math_approx_minimax_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_approx_minimax_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_approx_minimax_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_approx_minimax_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_approx_minimax_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_approx_minimax_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_approx_minimax_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_approx_minimax_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_approx_minimax_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_approx_minimax_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_approx_minimax_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_approx_minimax_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_approx_minimax_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_approx_minimax_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_approx_minimax_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_approx_minimax_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_approx_minimax_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_approx_minimax_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_approx_minimax_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_approx_minimax_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_approx_minimax_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_approx_minimax_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_approx_minimax_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_approx_minimax_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_approx_minimax_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

