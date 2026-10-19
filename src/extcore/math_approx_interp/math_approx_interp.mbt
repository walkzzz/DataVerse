///===
/// extcore/math_approx_interp

pub(all) struct MathapproxinterpPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn math_approx_interp_make_point(x : Double, y : Double) -> MathapproxinterpPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn math_approx_interp_make_point3(x : Double, y : Double, z : Double) -> MathapproxinterpPoint {
  { x, y, z, label: 0 }
}

pub fn math_approx_interp_point_x(pt : MathapproxinterpPoint) -> Double { pt.x }

pub fn math_approx_interp_point_y(pt : MathapproxinterpPoint) -> Double { pt.y }

pub fn math_approx_interp_point_z(pt : MathapproxinterpPoint) -> Double { pt.z }

pub fn math_approx_interp_point_label(pt : MathapproxinterpPoint) -> Int { pt.label }

pub fn math_approx_interp_point_dist(a : MathapproxinterpPoint, b : MathapproxinterpPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  math_approx_interp_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn math_approx_interp_point_add(a : MathapproxinterpPoint, b : MathapproxinterpPoint) -> MathapproxinterpPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn math_approx_interp_point_sub(a : MathapproxinterpPoint, b : MathapproxinterpPoint) -> MathapproxinterpPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn math_approx_interp_point_scale(pt : MathapproxinterpPoint, s : Double) -> MathapproxinterpPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn math_approx_interp_point_dot(a : MathapproxinterpPoint, b : MathapproxinterpPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn math_approx_interp_point_cross(a : MathapproxinterpPoint, b : MathapproxinterpPoint) -> MathapproxinterpPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn math_approx_interp_point_norm(pt : MathapproxinterpPoint) -> Double {
  math_approx_interp_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn math_approx_interp_point_normalize(pt : MathapproxinterpPoint) -> MathapproxinterpPoint {
  let n = math_approx_interp_point_norm(pt)
  if n < 0.0000001 { pt } else { math_approx_interp_point_scale(pt, 1.0 / n) }
}

pub fn math_approx_interp_point_negate(pt : MathapproxinterpPoint) -> MathapproxinterpPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn math_approx_interp_point_mid(a : MathapproxinterpPoint, b : MathapproxinterpPoint) -> MathapproxinterpPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn math_approx_interp_point_lerp(a : MathapproxinterpPoint, b : MathapproxinterpPoint, t : Double) -> MathapproxinterpPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn math_approx_interp_point_to_string(pt : MathapproxinterpPoint) -> String {
  "(" + math_approx_interp_dbl(pt.x) + ", " + math_approx_interp_dbl(pt.y) + ", " + math_approx_interp_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct MathapproxinterpSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn math_approx_interp_make_series(vals : Array[Double], name : String) -> MathapproxinterpSeries {
  { vals, name, meta: 0 }
}

pub fn math_approx_interp_series_len(s : MathapproxinterpSeries) -> Int { s.vals.length() }

pub fn math_approx_interp_series_sum(s : MathapproxinterpSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn math_approx_interp_series_mean(s : MathapproxinterpSeries) -> Double {
  let n = math_approx_interp_series_len(s)
  if n == 0 { 0.0 } else { math_approx_interp_series_sum(s) / n.to_double() }
}

pub fn math_approx_interp_series_min(s : MathapproxinterpSeries) -> Double {
  let n = math_approx_interp_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn math_approx_interp_series_max(s : MathapproxinterpSeries) -> Double {
  let n = math_approx_interp_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn math_approx_interp_series_range(s : MathapproxinterpSeries) -> Double {
  math_approx_interp_series_max(s) - math_approx_interp_series_min(s)
}

pub fn math_approx_interp_series_var(s : MathapproxinterpSeries) -> Double {
  let n = math_approx_interp_series_len(s)
  if n == 0 { 0.0 } else {
    let m = math_approx_interp_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn math_approx_interp_series_std(s : MathapproxinterpSeries) -> Double { math_approx_interp_sqrt(math_approx_interp_series_var(s)) }

pub fn math_approx_interp_series_median(s : MathapproxinterpSeries) -> Double {
  let n = math_approx_interp_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = math_approx_interp_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn math_approx_interp_series_scale(s : MathapproxinterpSeries, f : Double) -> MathapproxinterpSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = math_approx_interp_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn math_approx_interp_series_add(a : MathapproxinterpSeries, b : MathapproxinterpSeries) -> MathapproxinterpSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = math_approx_interp_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn math_approx_interp_series_sub(a : MathapproxinterpSeries, b : MathapproxinterpSeries) -> MathapproxinterpSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = math_approx_interp_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn math_approx_interp_series_normalize(s : MathapproxinterpSeries) -> MathapproxinterpSeries {
  let mn = math_approx_interp_series_min(s)
  let mx = math_approx_interp_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = math_approx_interp_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn math_approx_interp_series_cumsum(s : MathapproxinterpSeries) -> MathapproxinterpSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = math_approx_interp_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn math_approx_interp_series_to_string(s : MathapproxinterpSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + math_approx_interp_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MathapproxinterpMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn math_approx_interp_make_matrix(rows : Int, cols : Int, val : Double) -> MathapproxinterpMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn math_approx_interp_matrix_identity(n : Int) -> MathapproxinterpMatrix {
  let m = math_approx_interp_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn math_approx_interp_matrix_get(m : MathapproxinterpMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn math_approx_interp_matrix_transpose(m : MathapproxinterpMatrix) -> MathapproxinterpMatrix {
  let result = math_approx_interp_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn math_approx_interp_matrix_add(a : MathapproxinterpMatrix, b : MathapproxinterpMatrix) -> MathapproxinterpMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = math_approx_interp_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn math_approx_interp_matrix_scale(m : MathapproxinterpMatrix, s : Double) -> MathapproxinterpMatrix {
  let result = math_approx_interp_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn math_approx_interp_matrix_multiply(a : MathapproxinterpMatrix, b : MathapproxinterpMatrix) -> MathapproxinterpMatrix {
  if a.cols != b.rows { return math_approx_interp_make_matrix(a.rows, b.cols, 0.0) }
  let result = math_approx_interp_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn math_approx_interp_matrix_trace(m : MathapproxinterpMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn math_approx_interp_matrix_det(m : MathapproxinterpMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn math_approx_interp_matrix_norm(m : MathapproxinterpMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  math_approx_interp_sqrt(sum)
}

pub fn math_approx_interp_matrix_to_string(m : MathapproxinterpMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + math_approx_interp_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct MathapproxinterpVector {
  comps : Array[Double]
  dim : Int
}

pub fn math_approx_interp_make_vector(comps : Array[Double]) -> MathapproxinterpVector {
  { comps, dim: comps.length() }
}

pub fn math_approx_interp_vector_zero(dim : Int) -> MathapproxinterpVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn math_approx_interp_vector_add(a : MathapproxinterpVector, b : MathapproxinterpVector) -> MathapproxinterpVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = math_approx_interp_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn math_approx_interp_vector_sub(a : MathapproxinterpVector, b : MathapproxinterpVector) -> MathapproxinterpVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = math_approx_interp_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn math_approx_interp_vector_scale(v : MathapproxinterpVector, s : Double) -> MathapproxinterpVector {
  let mut result = []
  for i in 0..<v.dim { result = math_approx_interp_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn math_approx_interp_vector_dot(a : MathapproxinterpVector, b : MathapproxinterpVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn math_approx_interp_vector_norm(v : MathapproxinterpVector) -> Double { math_approx_interp_sqrt(math_approx_interp_vector_dot(v, v)) }

pub fn math_approx_interp_vector_normalize(v : MathapproxinterpVector) -> MathapproxinterpVector {
  let n = math_approx_interp_vector_norm(v)
  if n < 0.0000001 { v } else { math_approx_interp_vector_scale(v, 1.0 / n) }
}

pub fn math_approx_interp_vector_dist(a : MathapproxinterpVector, b : MathapproxinterpVector) -> Double {
  math_approx_interp_vector_norm(math_approx_interp_vector_sub(a, b))
}

pub fn math_approx_interp_vector_to_string(v : MathapproxinterpVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + math_approx_interp_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn math_approx_interp_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn math_approx_interp_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = math_approx_interp_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn math_approx_interp_std(data : Array[Double]) -> Double { math_approx_interp_sqrt(math_approx_interp_var(data)) }

pub fn math_approx_interp_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = math_approx_interp_mean(a); let mb = math_approx_interp_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn math_approx_interp_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = math_approx_interp_std(a); let sb = math_approx_interp_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { math_approx_interp_cov(a, b) / (sa * sb) }
}

pub fn math_approx_interp_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = math_approx_interp_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn math_approx_interp_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn math_approx_interp_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn math_approx_interp_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  math_approx_interp_sqrt(math_approx_interp_mse(pred, labels))
}

pub fn math_approx_interp_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + math_approx_interp_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn math_approx_interp_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = math_approx_interp_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn math_approx_interp_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn math_approx_interp_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn math_approx_interp_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = math_approx_interp_precision(pred, labels, pos); let r = math_approx_interp_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn math_approx_interp_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn math_approx_interp_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = math_approx_interp_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn math_approx_interp_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn math_approx_interp_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn math_approx_interp_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = math_approx_interp_gcd(a, b)
    (a / g) * b
  }
}

pub fn math_approx_interp_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn math_approx_interp_fibonacci(n : Int) -> Int {
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

pub fn math_approx_interp_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = math_approx_interp_min(data); let mx = math_approx_interp_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn math_approx_interp_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = math_approx_interp_mean(data); let sd = math_approx_interp_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn math_approx_interp_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn math_approx_interp_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn math_approx_interp_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn math_approx_interp_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn math_approx_interp_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn math_approx_interp_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn math_approx_interp_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn math_approx_interp_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn math_approx_interp_dbl(x : Double) -> String {
  let i = if x >= 0.0 { math_approx_interp_int(x) } else { -math_approx_interp_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { math_approx_interp_int(f * 1000000.0) } else { math_approx_interp_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn math_approx_interp_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn math_approx_interp_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct MathapproxinterpFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_interp_frame_make(size : Int) -> MathapproxinterpFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_interp_frame_len(s : MathapproxinterpFrame) -> Int { s.size }

pub fn math_approx_interp_frame_get(s : MathapproxinterpFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_interp_frame_set(s : MathapproxinterpFrame, i : Int, v : Double) -> MathapproxinterpFrame {
  let result = math_approx_interp_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_approx_interp_frame_sum(s : MathapproxinterpFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_approx_interp_frame_mean(s : MathapproxinterpFrame) -> Double {
  if s.size == 0 { 0.0 } else { math_approx_interp_frame_sum(s) / s.size.to_double() }
}

pub fn math_approx_interp_frame_scale(s : MathapproxinterpFrame, f : Double) -> MathapproxinterpFrame {
  let result = math_approx_interp_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_approx_interp_frame_add(a : MathapproxinterpFrame, b : MathapproxinterpFrame) -> MathapproxinterpFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_approx_interp_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_approx_interp_frame_copy(s : MathapproxinterpFrame) -> MathapproxinterpFrame {
  let result = math_approx_interp_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_approx_interp_frame_fill(s : MathapproxinterpFrame, v : Double) -> MathapproxinterpFrame {
  let result = math_approx_interp_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_approx_interp_frame_min(s : MathapproxinterpFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_interp_frame_max(s : MathapproxinterpFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_interp_frame_to_string(s : MathapproxinterpFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxinterpTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_interp_table_make(size : Int) -> MathapproxinterpTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_interp_table_len(s : MathapproxinterpTable) -> Int { s.size }

pub fn math_approx_interp_table_get(s : MathapproxinterpTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_interp_table_set(s : MathapproxinterpTable, i : Int, v : Double) -> MathapproxinterpTable {
  let result = math_approx_interp_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_approx_interp_table_sum(s : MathapproxinterpTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_approx_interp_table_mean(s : MathapproxinterpTable) -> Double {
  if s.size == 0 { 0.0 } else { math_approx_interp_table_sum(s) / s.size.to_double() }
}

pub fn math_approx_interp_table_scale(s : MathapproxinterpTable, f : Double) -> MathapproxinterpTable {
  let result = math_approx_interp_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_approx_interp_table_add(a : MathapproxinterpTable, b : MathapproxinterpTable) -> MathapproxinterpTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_approx_interp_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_approx_interp_table_copy(s : MathapproxinterpTable) -> MathapproxinterpTable {
  let result = math_approx_interp_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_approx_interp_table_fill(s : MathapproxinterpTable, v : Double) -> MathapproxinterpTable {
  let result = math_approx_interp_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_approx_interp_table_min(s : MathapproxinterpTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_interp_table_max(s : MathapproxinterpTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_interp_table_to_string(s : MathapproxinterpTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxinterpGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_interp_graphn_make(size : Int) -> MathapproxinterpGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_interp_graphn_len(s : MathapproxinterpGraphN) -> Int { s.size }

pub fn math_approx_interp_graphn_get(s : MathapproxinterpGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_interp_graphn_set(s : MathapproxinterpGraphN, i : Int, v : Double) -> MathapproxinterpGraphN {
  let result = math_approx_interp_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_approx_interp_graphn_sum(s : MathapproxinterpGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_approx_interp_graphn_mean(s : MathapproxinterpGraphN) -> Double {
  if s.size == 0 { 0.0 } else { math_approx_interp_graphn_sum(s) / s.size.to_double() }
}

pub fn math_approx_interp_graphn_scale(s : MathapproxinterpGraphN, f : Double) -> MathapproxinterpGraphN {
  let result = math_approx_interp_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_approx_interp_graphn_add(a : MathapproxinterpGraphN, b : MathapproxinterpGraphN) -> MathapproxinterpGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_approx_interp_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_approx_interp_graphn_copy(s : MathapproxinterpGraphN) -> MathapproxinterpGraphN {
  let result = math_approx_interp_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_approx_interp_graphn_fill(s : MathapproxinterpGraphN, v : Double) -> MathapproxinterpGraphN {
  let result = math_approx_interp_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_approx_interp_graphn_min(s : MathapproxinterpGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_interp_graphn_max(s : MathapproxinterpGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_interp_graphn_to_string(s : MathapproxinterpGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxinterpNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_interp_node_make(size : Int) -> MathapproxinterpNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_interp_node_len(s : MathapproxinterpNode) -> Int { s.size }

pub fn math_approx_interp_node_get(s : MathapproxinterpNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_interp_node_set(s : MathapproxinterpNode, i : Int, v : Double) -> MathapproxinterpNode {
  let result = math_approx_interp_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_approx_interp_node_sum(s : MathapproxinterpNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_approx_interp_node_mean(s : MathapproxinterpNode) -> Double {
  if s.size == 0 { 0.0 } else { math_approx_interp_node_sum(s) / s.size.to_double() }
}

pub fn math_approx_interp_node_scale(s : MathapproxinterpNode, f : Double) -> MathapproxinterpNode {
  let result = math_approx_interp_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_approx_interp_node_add(a : MathapproxinterpNode, b : MathapproxinterpNode) -> MathapproxinterpNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_approx_interp_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_approx_interp_node_copy(s : MathapproxinterpNode) -> MathapproxinterpNode {
  let result = math_approx_interp_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_approx_interp_node_fill(s : MathapproxinterpNode, v : Double) -> MathapproxinterpNode {
  let result = math_approx_interp_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_approx_interp_node_min(s : MathapproxinterpNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_interp_node_max(s : MathapproxinterpNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_interp_node_to_string(s : MathapproxinterpNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxinterpEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_interp_edge_make(size : Int) -> MathapproxinterpEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_interp_edge_len(s : MathapproxinterpEdge) -> Int { s.size }

pub fn math_approx_interp_edge_get(s : MathapproxinterpEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_interp_edge_set(s : MathapproxinterpEdge, i : Int, v : Double) -> MathapproxinterpEdge {
  let result = math_approx_interp_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_approx_interp_edge_sum(s : MathapproxinterpEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_approx_interp_edge_mean(s : MathapproxinterpEdge) -> Double {
  if s.size == 0 { 0.0 } else { math_approx_interp_edge_sum(s) / s.size.to_double() }
}

pub fn math_approx_interp_edge_scale(s : MathapproxinterpEdge, f : Double) -> MathapproxinterpEdge {
  let result = math_approx_interp_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_approx_interp_edge_add(a : MathapproxinterpEdge, b : MathapproxinterpEdge) -> MathapproxinterpEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_approx_interp_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_approx_interp_edge_copy(s : MathapproxinterpEdge) -> MathapproxinterpEdge {
  let result = math_approx_interp_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_approx_interp_edge_fill(s : MathapproxinterpEdge, v : Double) -> MathapproxinterpEdge {
  let result = math_approx_interp_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_approx_interp_edge_min(s : MathapproxinterpEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_interp_edge_max(s : MathapproxinterpEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_interp_edge_to_string(s : MathapproxinterpEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxinterpPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_interp_path_make(size : Int) -> MathapproxinterpPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_interp_path_len(s : MathapproxinterpPath) -> Int { s.size }

pub fn math_approx_interp_path_get(s : MathapproxinterpPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_interp_path_set(s : MathapproxinterpPath, i : Int, v : Double) -> MathapproxinterpPath {
  let result = math_approx_interp_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_approx_interp_path_sum(s : MathapproxinterpPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_approx_interp_path_mean(s : MathapproxinterpPath) -> Double {
  if s.size == 0 { 0.0 } else { math_approx_interp_path_sum(s) / s.size.to_double() }
}

pub fn math_approx_interp_path_scale(s : MathapproxinterpPath, f : Double) -> MathapproxinterpPath {
  let result = math_approx_interp_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_approx_interp_path_add(a : MathapproxinterpPath, b : MathapproxinterpPath) -> MathapproxinterpPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_approx_interp_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_approx_interp_path_copy(s : MathapproxinterpPath) -> MathapproxinterpPath {
  let result = math_approx_interp_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_approx_interp_path_fill(s : MathapproxinterpPath, v : Double) -> MathapproxinterpPath {
  let result = math_approx_interp_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_approx_interp_path_min(s : MathapproxinterpPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_interp_path_max(s : MathapproxinterpPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_interp_path_to_string(s : MathapproxinterpPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxinterpCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_interp_cluster_make(size : Int) -> MathapproxinterpCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_interp_cluster_len(s : MathapproxinterpCluster) -> Int { s.size }

pub fn math_approx_interp_cluster_get(s : MathapproxinterpCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_interp_cluster_set(s : MathapproxinterpCluster, i : Int, v : Double) -> MathapproxinterpCluster {
  let result = math_approx_interp_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_approx_interp_cluster_sum(s : MathapproxinterpCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_approx_interp_cluster_mean(s : MathapproxinterpCluster) -> Double {
  if s.size == 0 { 0.0 } else { math_approx_interp_cluster_sum(s) / s.size.to_double() }
}

pub fn math_approx_interp_cluster_scale(s : MathapproxinterpCluster, f : Double) -> MathapproxinterpCluster {
  let result = math_approx_interp_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_approx_interp_cluster_add(a : MathapproxinterpCluster, b : MathapproxinterpCluster) -> MathapproxinterpCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_approx_interp_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_approx_interp_cluster_copy(s : MathapproxinterpCluster) -> MathapproxinterpCluster {
  let result = math_approx_interp_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_approx_interp_cluster_fill(s : MathapproxinterpCluster, v : Double) -> MathapproxinterpCluster {
  let result = math_approx_interp_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_approx_interp_cluster_min(s : MathapproxinterpCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_interp_cluster_max(s : MathapproxinterpCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_interp_cluster_to_string(s : MathapproxinterpCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxinterpModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_interp_model_make(size : Int) -> MathapproxinterpModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_interp_model_len(s : MathapproxinterpModel) -> Int { s.size }

pub fn math_approx_interp_model_get(s : MathapproxinterpModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_interp_model_set(s : MathapproxinterpModel, i : Int, v : Double) -> MathapproxinterpModel {
  let result = math_approx_interp_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_approx_interp_model_sum(s : MathapproxinterpModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_approx_interp_model_mean(s : MathapproxinterpModel) -> Double {
  if s.size == 0 { 0.0 } else { math_approx_interp_model_sum(s) / s.size.to_double() }
}

pub fn math_approx_interp_model_scale(s : MathapproxinterpModel, f : Double) -> MathapproxinterpModel {
  let result = math_approx_interp_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_approx_interp_model_add(a : MathapproxinterpModel, b : MathapproxinterpModel) -> MathapproxinterpModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_approx_interp_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_approx_interp_model_copy(s : MathapproxinterpModel) -> MathapproxinterpModel {
  let result = math_approx_interp_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_approx_interp_model_fill(s : MathapproxinterpModel, v : Double) -> MathapproxinterpModel {
  let result = math_approx_interp_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_approx_interp_model_min(s : MathapproxinterpModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_interp_model_max(s : MathapproxinterpModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_interp_model_to_string(s : MathapproxinterpModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxinterpLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_interp_layer_make(size : Int) -> MathapproxinterpLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_interp_layer_len(s : MathapproxinterpLayer) -> Int { s.size }

pub fn math_approx_interp_layer_get(s : MathapproxinterpLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_interp_layer_set(s : MathapproxinterpLayer, i : Int, v : Double) -> MathapproxinterpLayer {
  let result = math_approx_interp_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_approx_interp_layer_sum(s : MathapproxinterpLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_approx_interp_layer_mean(s : MathapproxinterpLayer) -> Double {
  if s.size == 0 { 0.0 } else { math_approx_interp_layer_sum(s) / s.size.to_double() }
}

pub fn math_approx_interp_layer_scale(s : MathapproxinterpLayer, f : Double) -> MathapproxinterpLayer {
  let result = math_approx_interp_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_approx_interp_layer_add(a : MathapproxinterpLayer, b : MathapproxinterpLayer) -> MathapproxinterpLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_approx_interp_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_approx_interp_layer_copy(s : MathapproxinterpLayer) -> MathapproxinterpLayer {
  let result = math_approx_interp_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_approx_interp_layer_fill(s : MathapproxinterpLayer, v : Double) -> MathapproxinterpLayer {
  let result = math_approx_interp_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_approx_interp_layer_min(s : MathapproxinterpLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_interp_layer_max(s : MathapproxinterpLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_interp_layer_to_string(s : MathapproxinterpLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxinterpBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_interp_buffer_make(size : Int) -> MathapproxinterpBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_interp_buffer_len(s : MathapproxinterpBuffer) -> Int { s.size }

pub fn math_approx_interp_buffer_get(s : MathapproxinterpBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_interp_buffer_set(s : MathapproxinterpBuffer, i : Int, v : Double) -> MathapproxinterpBuffer {
  let result = math_approx_interp_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_approx_interp_buffer_sum(s : MathapproxinterpBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_approx_interp_buffer_mean(s : MathapproxinterpBuffer) -> Double {
  if s.size == 0 { 0.0 } else { math_approx_interp_buffer_sum(s) / s.size.to_double() }
}

pub fn math_approx_interp_buffer_scale(s : MathapproxinterpBuffer, f : Double) -> MathapproxinterpBuffer {
  let result = math_approx_interp_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_approx_interp_buffer_add(a : MathapproxinterpBuffer, b : MathapproxinterpBuffer) -> MathapproxinterpBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_approx_interp_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_approx_interp_buffer_copy(s : MathapproxinterpBuffer) -> MathapproxinterpBuffer {
  let result = math_approx_interp_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_approx_interp_buffer_fill(s : MathapproxinterpBuffer, v : Double) -> MathapproxinterpBuffer {
  let result = math_approx_interp_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_approx_interp_buffer_min(s : MathapproxinterpBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_interp_buffer_max(s : MathapproxinterpBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_interp_buffer_to_string(s : MathapproxinterpBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxinterpCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_interp_cursor_make(size : Int) -> MathapproxinterpCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_interp_cursor_len(s : MathapproxinterpCursor) -> Int { s.size }

pub fn math_approx_interp_cursor_get(s : MathapproxinterpCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_interp_cursor_set(s : MathapproxinterpCursor, i : Int, v : Double) -> MathapproxinterpCursor {
  let result = math_approx_interp_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_approx_interp_cursor_sum(s : MathapproxinterpCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_approx_interp_cursor_mean(s : MathapproxinterpCursor) -> Double {
  if s.size == 0 { 0.0 } else { math_approx_interp_cursor_sum(s) / s.size.to_double() }
}

pub fn math_approx_interp_cursor_scale(s : MathapproxinterpCursor, f : Double) -> MathapproxinterpCursor {
  let result = math_approx_interp_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_approx_interp_cursor_add(a : MathapproxinterpCursor, b : MathapproxinterpCursor) -> MathapproxinterpCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_approx_interp_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_approx_interp_cursor_copy(s : MathapproxinterpCursor) -> MathapproxinterpCursor {
  let result = math_approx_interp_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_approx_interp_cursor_fill(s : MathapproxinterpCursor, v : Double) -> MathapproxinterpCursor {
  let result = math_approx_interp_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_approx_interp_cursor_min(s : MathapproxinterpCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_interp_cursor_max(s : MathapproxinterpCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_interp_cursor_to_string(s : MathapproxinterpCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxinterpView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_interp_view_make(size : Int) -> MathapproxinterpView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_interp_view_len(s : MathapproxinterpView) -> Int { s.size }

pub fn math_approx_interp_view_get(s : MathapproxinterpView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_interp_view_set(s : MathapproxinterpView, i : Int, v : Double) -> MathapproxinterpView {
  let result = math_approx_interp_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_approx_interp_view_sum(s : MathapproxinterpView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_approx_interp_view_mean(s : MathapproxinterpView) -> Double {
  if s.size == 0 { 0.0 } else { math_approx_interp_view_sum(s) / s.size.to_double() }
}

pub fn math_approx_interp_view_scale(s : MathapproxinterpView, f : Double) -> MathapproxinterpView {
  let result = math_approx_interp_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_approx_interp_view_add(a : MathapproxinterpView, b : MathapproxinterpView) -> MathapproxinterpView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_approx_interp_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_approx_interp_view_copy(s : MathapproxinterpView) -> MathapproxinterpView {
  let result = math_approx_interp_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_approx_interp_view_fill(s : MathapproxinterpView, v : Double) -> MathapproxinterpView {
  let result = math_approx_interp_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_approx_interp_view_min(s : MathapproxinterpView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_interp_view_max(s : MathapproxinterpView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_interp_view_to_string(s : MathapproxinterpView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxinterpRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_interp_range_make(size : Int) -> MathapproxinterpRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_interp_range_len(s : MathapproxinterpRange) -> Int { s.size }

pub fn math_approx_interp_range_get(s : MathapproxinterpRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_interp_range_set(s : MathapproxinterpRange, i : Int, v : Double) -> MathapproxinterpRange {
  let result = math_approx_interp_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_approx_interp_range_sum(s : MathapproxinterpRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_approx_interp_range_mean(s : MathapproxinterpRange) -> Double {
  if s.size == 0 { 0.0 } else { math_approx_interp_range_sum(s) / s.size.to_double() }
}

pub fn math_approx_interp_range_scale(s : MathapproxinterpRange, f : Double) -> MathapproxinterpRange {
  let result = math_approx_interp_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_approx_interp_range_add(a : MathapproxinterpRange, b : MathapproxinterpRange) -> MathapproxinterpRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_approx_interp_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_approx_interp_range_copy(s : MathapproxinterpRange) -> MathapproxinterpRange {
  let result = math_approx_interp_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_approx_interp_range_fill(s : MathapproxinterpRange, v : Double) -> MathapproxinterpRange {
  let result = math_approx_interp_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_approx_interp_range_min(s : MathapproxinterpRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_interp_range_max(s : MathapproxinterpRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_interp_range_to_string(s : MathapproxinterpRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxinterpSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_interp_slice_make(size : Int) -> MathapproxinterpSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_interp_slice_len(s : MathapproxinterpSlice) -> Int { s.size }

pub fn math_approx_interp_slice_get(s : MathapproxinterpSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_interp_slice_set(s : MathapproxinterpSlice, i : Int, v : Double) -> MathapproxinterpSlice {
  let result = math_approx_interp_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_approx_interp_slice_sum(s : MathapproxinterpSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_approx_interp_slice_mean(s : MathapproxinterpSlice) -> Double {
  if s.size == 0 { 0.0 } else { math_approx_interp_slice_sum(s) / s.size.to_double() }
}

pub fn math_approx_interp_slice_scale(s : MathapproxinterpSlice, f : Double) -> MathapproxinterpSlice {
  let result = math_approx_interp_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_approx_interp_slice_add(a : MathapproxinterpSlice, b : MathapproxinterpSlice) -> MathapproxinterpSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_approx_interp_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_approx_interp_slice_copy(s : MathapproxinterpSlice) -> MathapproxinterpSlice {
  let result = math_approx_interp_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_approx_interp_slice_fill(s : MathapproxinterpSlice, v : Double) -> MathapproxinterpSlice {
  let result = math_approx_interp_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_approx_interp_slice_min(s : MathapproxinterpSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_interp_slice_max(s : MathapproxinterpSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_interp_slice_to_string(s : MathapproxinterpSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn math_approx_interp_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_approx_interp_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_approx_interp_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_approx_interp_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_approx_interp_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_approx_interp_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_approx_interp_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_approx_interp_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_approx_interp_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_approx_interp_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_approx_interp_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_approx_interp_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_approx_interp_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_approx_interp_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_approx_interp_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_approx_interp_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_approx_interp_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_approx_interp_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_approx_interp_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_approx_interp_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_approx_interp_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_approx_interp_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_approx_interp_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_approx_interp_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_approx_interp_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

