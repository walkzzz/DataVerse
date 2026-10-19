///===
/// extcore/math_nonlinear_prog

pub(all) struct MathnonlinearprogPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn math_nonlinear_prog_make_point(x : Double, y : Double) -> MathnonlinearprogPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn math_nonlinear_prog_make_point3(x : Double, y : Double, z : Double) -> MathnonlinearprogPoint {
  { x, y, z, label: 0 }
}

pub fn math_nonlinear_prog_point_x(pt : MathnonlinearprogPoint) -> Double { pt.x }

pub fn math_nonlinear_prog_point_y(pt : MathnonlinearprogPoint) -> Double { pt.y }

pub fn math_nonlinear_prog_point_z(pt : MathnonlinearprogPoint) -> Double { pt.z }

pub fn math_nonlinear_prog_point_label(pt : MathnonlinearprogPoint) -> Int { pt.label }

pub fn math_nonlinear_prog_point_dist(a : MathnonlinearprogPoint, b : MathnonlinearprogPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  math_nonlinear_prog_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn math_nonlinear_prog_point_add(a : MathnonlinearprogPoint, b : MathnonlinearprogPoint) -> MathnonlinearprogPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn math_nonlinear_prog_point_sub(a : MathnonlinearprogPoint, b : MathnonlinearprogPoint) -> MathnonlinearprogPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn math_nonlinear_prog_point_scale(pt : MathnonlinearprogPoint, s : Double) -> MathnonlinearprogPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn math_nonlinear_prog_point_dot(a : MathnonlinearprogPoint, b : MathnonlinearprogPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn math_nonlinear_prog_point_cross(a : MathnonlinearprogPoint, b : MathnonlinearprogPoint) -> MathnonlinearprogPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn math_nonlinear_prog_point_norm(pt : MathnonlinearprogPoint) -> Double {
  math_nonlinear_prog_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn math_nonlinear_prog_point_normalize(pt : MathnonlinearprogPoint) -> MathnonlinearprogPoint {
  let n = math_nonlinear_prog_point_norm(pt)
  if n < 0.0000001 { pt } else { math_nonlinear_prog_point_scale(pt, 1.0 / n) }
}

pub fn math_nonlinear_prog_point_negate(pt : MathnonlinearprogPoint) -> MathnonlinearprogPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn math_nonlinear_prog_point_mid(a : MathnonlinearprogPoint, b : MathnonlinearprogPoint) -> MathnonlinearprogPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn math_nonlinear_prog_point_lerp(a : MathnonlinearprogPoint, b : MathnonlinearprogPoint, t : Double) -> MathnonlinearprogPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn math_nonlinear_prog_point_to_string(pt : MathnonlinearprogPoint) -> String {
  "(" + math_nonlinear_prog_dbl(pt.x) + ", " + math_nonlinear_prog_dbl(pt.y) + ", " + math_nonlinear_prog_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct MathnonlinearprogSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn math_nonlinear_prog_make_series(vals : Array[Double], name : String) -> MathnonlinearprogSeries {
  { vals, name, meta: 0 }
}

pub fn math_nonlinear_prog_series_len(s : MathnonlinearprogSeries) -> Int { s.vals.length() }

pub fn math_nonlinear_prog_series_sum(s : MathnonlinearprogSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn math_nonlinear_prog_series_mean(s : MathnonlinearprogSeries) -> Double {
  let n = math_nonlinear_prog_series_len(s)
  if n == 0 { 0.0 } else { math_nonlinear_prog_series_sum(s) / n.to_double() }
}

pub fn math_nonlinear_prog_series_min(s : MathnonlinearprogSeries) -> Double {
  let n = math_nonlinear_prog_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn math_nonlinear_prog_series_max(s : MathnonlinearprogSeries) -> Double {
  let n = math_nonlinear_prog_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn math_nonlinear_prog_series_range(s : MathnonlinearprogSeries) -> Double {
  math_nonlinear_prog_series_max(s) - math_nonlinear_prog_series_min(s)
}

pub fn math_nonlinear_prog_series_var(s : MathnonlinearprogSeries) -> Double {
  let n = math_nonlinear_prog_series_len(s)
  if n == 0 { 0.0 } else {
    let m = math_nonlinear_prog_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn math_nonlinear_prog_series_std(s : MathnonlinearprogSeries) -> Double { math_nonlinear_prog_sqrt(math_nonlinear_prog_series_var(s)) }

pub fn math_nonlinear_prog_series_median(s : MathnonlinearprogSeries) -> Double {
  let n = math_nonlinear_prog_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = math_nonlinear_prog_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn math_nonlinear_prog_series_scale(s : MathnonlinearprogSeries, f : Double) -> MathnonlinearprogSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = math_nonlinear_prog_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn math_nonlinear_prog_series_add(a : MathnonlinearprogSeries, b : MathnonlinearprogSeries) -> MathnonlinearprogSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = math_nonlinear_prog_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn math_nonlinear_prog_series_sub(a : MathnonlinearprogSeries, b : MathnonlinearprogSeries) -> MathnonlinearprogSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = math_nonlinear_prog_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn math_nonlinear_prog_series_normalize(s : MathnonlinearprogSeries) -> MathnonlinearprogSeries {
  let mn = math_nonlinear_prog_series_min(s)
  let mx = math_nonlinear_prog_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = math_nonlinear_prog_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn math_nonlinear_prog_series_cumsum(s : MathnonlinearprogSeries) -> MathnonlinearprogSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = math_nonlinear_prog_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn math_nonlinear_prog_series_to_string(s : MathnonlinearprogSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + math_nonlinear_prog_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MathnonlinearprogMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn math_nonlinear_prog_make_matrix(rows : Int, cols : Int, val : Double) -> MathnonlinearprogMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn math_nonlinear_prog_matrix_identity(n : Int) -> MathnonlinearprogMatrix {
  let m = math_nonlinear_prog_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn math_nonlinear_prog_matrix_get(m : MathnonlinearprogMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn math_nonlinear_prog_matrix_transpose(m : MathnonlinearprogMatrix) -> MathnonlinearprogMatrix {
  let result = math_nonlinear_prog_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn math_nonlinear_prog_matrix_add(a : MathnonlinearprogMatrix, b : MathnonlinearprogMatrix) -> MathnonlinearprogMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = math_nonlinear_prog_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn math_nonlinear_prog_matrix_scale(m : MathnonlinearprogMatrix, s : Double) -> MathnonlinearprogMatrix {
  let result = math_nonlinear_prog_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn math_nonlinear_prog_matrix_multiply(a : MathnonlinearprogMatrix, b : MathnonlinearprogMatrix) -> MathnonlinearprogMatrix {
  if a.cols != b.rows { return math_nonlinear_prog_make_matrix(a.rows, b.cols, 0.0) }
  let result = math_nonlinear_prog_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn math_nonlinear_prog_matrix_trace(m : MathnonlinearprogMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn math_nonlinear_prog_matrix_det(m : MathnonlinearprogMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn math_nonlinear_prog_matrix_norm(m : MathnonlinearprogMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  math_nonlinear_prog_sqrt(sum)
}

pub fn math_nonlinear_prog_matrix_to_string(m : MathnonlinearprogMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + math_nonlinear_prog_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct MathnonlinearprogVector {
  comps : Array[Double]
  dim : Int
}

pub fn math_nonlinear_prog_make_vector(comps : Array[Double]) -> MathnonlinearprogVector {
  { comps, dim: comps.length() }
}

pub fn math_nonlinear_prog_vector_zero(dim : Int) -> MathnonlinearprogVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn math_nonlinear_prog_vector_add(a : MathnonlinearprogVector, b : MathnonlinearprogVector) -> MathnonlinearprogVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = math_nonlinear_prog_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn math_nonlinear_prog_vector_sub(a : MathnonlinearprogVector, b : MathnonlinearprogVector) -> MathnonlinearprogVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = math_nonlinear_prog_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn math_nonlinear_prog_vector_scale(v : MathnonlinearprogVector, s : Double) -> MathnonlinearprogVector {
  let mut result = []
  for i in 0..<v.dim { result = math_nonlinear_prog_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn math_nonlinear_prog_vector_dot(a : MathnonlinearprogVector, b : MathnonlinearprogVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn math_nonlinear_prog_vector_norm(v : MathnonlinearprogVector) -> Double { math_nonlinear_prog_sqrt(math_nonlinear_prog_vector_dot(v, v)) }

pub fn math_nonlinear_prog_vector_normalize(v : MathnonlinearprogVector) -> MathnonlinearprogVector {
  let n = math_nonlinear_prog_vector_norm(v)
  if n < 0.0000001 { v } else { math_nonlinear_prog_vector_scale(v, 1.0 / n) }
}

pub fn math_nonlinear_prog_vector_dist(a : MathnonlinearprogVector, b : MathnonlinearprogVector) -> Double {
  math_nonlinear_prog_vector_norm(math_nonlinear_prog_vector_sub(a, b))
}

pub fn math_nonlinear_prog_vector_to_string(v : MathnonlinearprogVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + math_nonlinear_prog_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn math_nonlinear_prog_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn math_nonlinear_prog_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = math_nonlinear_prog_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn math_nonlinear_prog_std(data : Array[Double]) -> Double { math_nonlinear_prog_sqrt(math_nonlinear_prog_var(data)) }

pub fn math_nonlinear_prog_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = math_nonlinear_prog_mean(a); let mb = math_nonlinear_prog_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn math_nonlinear_prog_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = math_nonlinear_prog_std(a); let sb = math_nonlinear_prog_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { math_nonlinear_prog_cov(a, b) / (sa * sb) }
}

pub fn math_nonlinear_prog_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = math_nonlinear_prog_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn math_nonlinear_prog_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn math_nonlinear_prog_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn math_nonlinear_prog_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  math_nonlinear_prog_sqrt(math_nonlinear_prog_mse(pred, labels))
}

pub fn math_nonlinear_prog_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + math_nonlinear_prog_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn math_nonlinear_prog_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = math_nonlinear_prog_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn math_nonlinear_prog_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn math_nonlinear_prog_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn math_nonlinear_prog_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = math_nonlinear_prog_precision(pred, labels, pos); let r = math_nonlinear_prog_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn math_nonlinear_prog_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn math_nonlinear_prog_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = math_nonlinear_prog_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn math_nonlinear_prog_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn math_nonlinear_prog_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn math_nonlinear_prog_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = math_nonlinear_prog_gcd(a, b)
    (a / g) * b
  }
}

pub fn math_nonlinear_prog_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn math_nonlinear_prog_fibonacci(n : Int) -> Int {
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

pub fn math_nonlinear_prog_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = math_nonlinear_prog_min(data); let mx = math_nonlinear_prog_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn math_nonlinear_prog_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = math_nonlinear_prog_mean(data); let sd = math_nonlinear_prog_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn math_nonlinear_prog_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn math_nonlinear_prog_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn math_nonlinear_prog_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn math_nonlinear_prog_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn math_nonlinear_prog_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn math_nonlinear_prog_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn math_nonlinear_prog_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn math_nonlinear_prog_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn math_nonlinear_prog_dbl(x : Double) -> String {
  let i = if x >= 0.0 { math_nonlinear_prog_int(x) } else { -math_nonlinear_prog_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { math_nonlinear_prog_int(f * 1000000.0) } else { math_nonlinear_prog_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn math_nonlinear_prog_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn math_nonlinear_prog_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct MathnonlinearprogFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_nonlinear_prog_frame_make(size : Int) -> MathnonlinearprogFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_nonlinear_prog_frame_len(s : MathnonlinearprogFrame) -> Int { s.size }

pub fn math_nonlinear_prog_frame_get(s : MathnonlinearprogFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_nonlinear_prog_frame_set(s : MathnonlinearprogFrame, i : Int, v : Double) -> MathnonlinearprogFrame {
  let result = math_nonlinear_prog_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_nonlinear_prog_frame_sum(s : MathnonlinearprogFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_nonlinear_prog_frame_mean(s : MathnonlinearprogFrame) -> Double {
  if s.size == 0 { 0.0 } else { math_nonlinear_prog_frame_sum(s) / s.size.to_double() }
}

pub fn math_nonlinear_prog_frame_scale(s : MathnonlinearprogFrame, f : Double) -> MathnonlinearprogFrame {
  let result = math_nonlinear_prog_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_nonlinear_prog_frame_add(a : MathnonlinearprogFrame, b : MathnonlinearprogFrame) -> MathnonlinearprogFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_nonlinear_prog_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_nonlinear_prog_frame_copy(s : MathnonlinearprogFrame) -> MathnonlinearprogFrame {
  let result = math_nonlinear_prog_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_nonlinear_prog_frame_fill(s : MathnonlinearprogFrame, v : Double) -> MathnonlinearprogFrame {
  let result = math_nonlinear_prog_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_nonlinear_prog_frame_min(s : MathnonlinearprogFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_nonlinear_prog_frame_max(s : MathnonlinearprogFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_nonlinear_prog_frame_to_string(s : MathnonlinearprogFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathnonlinearprogTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_nonlinear_prog_table_make(size : Int) -> MathnonlinearprogTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_nonlinear_prog_table_len(s : MathnonlinearprogTable) -> Int { s.size }

pub fn math_nonlinear_prog_table_get(s : MathnonlinearprogTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_nonlinear_prog_table_set(s : MathnonlinearprogTable, i : Int, v : Double) -> MathnonlinearprogTable {
  let result = math_nonlinear_prog_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_nonlinear_prog_table_sum(s : MathnonlinearprogTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_nonlinear_prog_table_mean(s : MathnonlinearprogTable) -> Double {
  if s.size == 0 { 0.0 } else { math_nonlinear_prog_table_sum(s) / s.size.to_double() }
}

pub fn math_nonlinear_prog_table_scale(s : MathnonlinearprogTable, f : Double) -> MathnonlinearprogTable {
  let result = math_nonlinear_prog_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_nonlinear_prog_table_add(a : MathnonlinearprogTable, b : MathnonlinearprogTable) -> MathnonlinearprogTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_nonlinear_prog_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_nonlinear_prog_table_copy(s : MathnonlinearprogTable) -> MathnonlinearprogTable {
  let result = math_nonlinear_prog_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_nonlinear_prog_table_fill(s : MathnonlinearprogTable, v : Double) -> MathnonlinearprogTable {
  let result = math_nonlinear_prog_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_nonlinear_prog_table_min(s : MathnonlinearprogTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_nonlinear_prog_table_max(s : MathnonlinearprogTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_nonlinear_prog_table_to_string(s : MathnonlinearprogTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathnonlinearprogGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_nonlinear_prog_graphn_make(size : Int) -> MathnonlinearprogGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_nonlinear_prog_graphn_len(s : MathnonlinearprogGraphN) -> Int { s.size }

pub fn math_nonlinear_prog_graphn_get(s : MathnonlinearprogGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_nonlinear_prog_graphn_set(s : MathnonlinearprogGraphN, i : Int, v : Double) -> MathnonlinearprogGraphN {
  let result = math_nonlinear_prog_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_nonlinear_prog_graphn_sum(s : MathnonlinearprogGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_nonlinear_prog_graphn_mean(s : MathnonlinearprogGraphN) -> Double {
  if s.size == 0 { 0.0 } else { math_nonlinear_prog_graphn_sum(s) / s.size.to_double() }
}

pub fn math_nonlinear_prog_graphn_scale(s : MathnonlinearprogGraphN, f : Double) -> MathnonlinearprogGraphN {
  let result = math_nonlinear_prog_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_nonlinear_prog_graphn_add(a : MathnonlinearprogGraphN, b : MathnonlinearprogGraphN) -> MathnonlinearprogGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_nonlinear_prog_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_nonlinear_prog_graphn_copy(s : MathnonlinearprogGraphN) -> MathnonlinearprogGraphN {
  let result = math_nonlinear_prog_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_nonlinear_prog_graphn_fill(s : MathnonlinearprogGraphN, v : Double) -> MathnonlinearprogGraphN {
  let result = math_nonlinear_prog_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_nonlinear_prog_graphn_min(s : MathnonlinearprogGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_nonlinear_prog_graphn_max(s : MathnonlinearprogGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_nonlinear_prog_graphn_to_string(s : MathnonlinearprogGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathnonlinearprogNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_nonlinear_prog_node_make(size : Int) -> MathnonlinearprogNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_nonlinear_prog_node_len(s : MathnonlinearprogNode) -> Int { s.size }

pub fn math_nonlinear_prog_node_get(s : MathnonlinearprogNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_nonlinear_prog_node_set(s : MathnonlinearprogNode, i : Int, v : Double) -> MathnonlinearprogNode {
  let result = math_nonlinear_prog_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_nonlinear_prog_node_sum(s : MathnonlinearprogNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_nonlinear_prog_node_mean(s : MathnonlinearprogNode) -> Double {
  if s.size == 0 { 0.0 } else { math_nonlinear_prog_node_sum(s) / s.size.to_double() }
}

pub fn math_nonlinear_prog_node_scale(s : MathnonlinearprogNode, f : Double) -> MathnonlinearprogNode {
  let result = math_nonlinear_prog_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_nonlinear_prog_node_add(a : MathnonlinearprogNode, b : MathnonlinearprogNode) -> MathnonlinearprogNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_nonlinear_prog_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_nonlinear_prog_node_copy(s : MathnonlinearprogNode) -> MathnonlinearprogNode {
  let result = math_nonlinear_prog_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_nonlinear_prog_node_fill(s : MathnonlinearprogNode, v : Double) -> MathnonlinearprogNode {
  let result = math_nonlinear_prog_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_nonlinear_prog_node_min(s : MathnonlinearprogNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_nonlinear_prog_node_max(s : MathnonlinearprogNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_nonlinear_prog_node_to_string(s : MathnonlinearprogNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathnonlinearprogEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_nonlinear_prog_edge_make(size : Int) -> MathnonlinearprogEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_nonlinear_prog_edge_len(s : MathnonlinearprogEdge) -> Int { s.size }

pub fn math_nonlinear_prog_edge_get(s : MathnonlinearprogEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_nonlinear_prog_edge_set(s : MathnonlinearprogEdge, i : Int, v : Double) -> MathnonlinearprogEdge {
  let result = math_nonlinear_prog_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_nonlinear_prog_edge_sum(s : MathnonlinearprogEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_nonlinear_prog_edge_mean(s : MathnonlinearprogEdge) -> Double {
  if s.size == 0 { 0.0 } else { math_nonlinear_prog_edge_sum(s) / s.size.to_double() }
}

pub fn math_nonlinear_prog_edge_scale(s : MathnonlinearprogEdge, f : Double) -> MathnonlinearprogEdge {
  let result = math_nonlinear_prog_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_nonlinear_prog_edge_add(a : MathnonlinearprogEdge, b : MathnonlinearprogEdge) -> MathnonlinearprogEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_nonlinear_prog_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_nonlinear_prog_edge_copy(s : MathnonlinearprogEdge) -> MathnonlinearprogEdge {
  let result = math_nonlinear_prog_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_nonlinear_prog_edge_fill(s : MathnonlinearprogEdge, v : Double) -> MathnonlinearprogEdge {
  let result = math_nonlinear_prog_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_nonlinear_prog_edge_min(s : MathnonlinearprogEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_nonlinear_prog_edge_max(s : MathnonlinearprogEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_nonlinear_prog_edge_to_string(s : MathnonlinearprogEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathnonlinearprogPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_nonlinear_prog_path_make(size : Int) -> MathnonlinearprogPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_nonlinear_prog_path_len(s : MathnonlinearprogPath) -> Int { s.size }

pub fn math_nonlinear_prog_path_get(s : MathnonlinearprogPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_nonlinear_prog_path_set(s : MathnonlinearprogPath, i : Int, v : Double) -> MathnonlinearprogPath {
  let result = math_nonlinear_prog_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_nonlinear_prog_path_sum(s : MathnonlinearprogPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_nonlinear_prog_path_mean(s : MathnonlinearprogPath) -> Double {
  if s.size == 0 { 0.0 } else { math_nonlinear_prog_path_sum(s) / s.size.to_double() }
}

pub fn math_nonlinear_prog_path_scale(s : MathnonlinearprogPath, f : Double) -> MathnonlinearprogPath {
  let result = math_nonlinear_prog_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_nonlinear_prog_path_add(a : MathnonlinearprogPath, b : MathnonlinearprogPath) -> MathnonlinearprogPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_nonlinear_prog_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_nonlinear_prog_path_copy(s : MathnonlinearprogPath) -> MathnonlinearprogPath {
  let result = math_nonlinear_prog_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_nonlinear_prog_path_fill(s : MathnonlinearprogPath, v : Double) -> MathnonlinearprogPath {
  let result = math_nonlinear_prog_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_nonlinear_prog_path_min(s : MathnonlinearprogPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_nonlinear_prog_path_max(s : MathnonlinearprogPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_nonlinear_prog_path_to_string(s : MathnonlinearprogPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathnonlinearprogCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_nonlinear_prog_cluster_make(size : Int) -> MathnonlinearprogCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_nonlinear_prog_cluster_len(s : MathnonlinearprogCluster) -> Int { s.size }

pub fn math_nonlinear_prog_cluster_get(s : MathnonlinearprogCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_nonlinear_prog_cluster_set(s : MathnonlinearprogCluster, i : Int, v : Double) -> MathnonlinearprogCluster {
  let result = math_nonlinear_prog_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_nonlinear_prog_cluster_sum(s : MathnonlinearprogCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_nonlinear_prog_cluster_mean(s : MathnonlinearprogCluster) -> Double {
  if s.size == 0 { 0.0 } else { math_nonlinear_prog_cluster_sum(s) / s.size.to_double() }
}

pub fn math_nonlinear_prog_cluster_scale(s : MathnonlinearprogCluster, f : Double) -> MathnonlinearprogCluster {
  let result = math_nonlinear_prog_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_nonlinear_prog_cluster_add(a : MathnonlinearprogCluster, b : MathnonlinearprogCluster) -> MathnonlinearprogCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_nonlinear_prog_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_nonlinear_prog_cluster_copy(s : MathnonlinearprogCluster) -> MathnonlinearprogCluster {
  let result = math_nonlinear_prog_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_nonlinear_prog_cluster_fill(s : MathnonlinearprogCluster, v : Double) -> MathnonlinearprogCluster {
  let result = math_nonlinear_prog_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_nonlinear_prog_cluster_min(s : MathnonlinearprogCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_nonlinear_prog_cluster_max(s : MathnonlinearprogCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_nonlinear_prog_cluster_to_string(s : MathnonlinearprogCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathnonlinearprogModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_nonlinear_prog_model_make(size : Int) -> MathnonlinearprogModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_nonlinear_prog_model_len(s : MathnonlinearprogModel) -> Int { s.size }

pub fn math_nonlinear_prog_model_get(s : MathnonlinearprogModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_nonlinear_prog_model_set(s : MathnonlinearprogModel, i : Int, v : Double) -> MathnonlinearprogModel {
  let result = math_nonlinear_prog_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_nonlinear_prog_model_sum(s : MathnonlinearprogModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_nonlinear_prog_model_mean(s : MathnonlinearprogModel) -> Double {
  if s.size == 0 { 0.0 } else { math_nonlinear_prog_model_sum(s) / s.size.to_double() }
}

pub fn math_nonlinear_prog_model_scale(s : MathnonlinearprogModel, f : Double) -> MathnonlinearprogModel {
  let result = math_nonlinear_prog_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_nonlinear_prog_model_add(a : MathnonlinearprogModel, b : MathnonlinearprogModel) -> MathnonlinearprogModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_nonlinear_prog_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_nonlinear_prog_model_copy(s : MathnonlinearprogModel) -> MathnonlinearprogModel {
  let result = math_nonlinear_prog_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_nonlinear_prog_model_fill(s : MathnonlinearprogModel, v : Double) -> MathnonlinearprogModel {
  let result = math_nonlinear_prog_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_nonlinear_prog_model_min(s : MathnonlinearprogModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_nonlinear_prog_model_max(s : MathnonlinearprogModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_nonlinear_prog_model_to_string(s : MathnonlinearprogModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathnonlinearprogLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_nonlinear_prog_layer_make(size : Int) -> MathnonlinearprogLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_nonlinear_prog_layer_len(s : MathnonlinearprogLayer) -> Int { s.size }

pub fn math_nonlinear_prog_layer_get(s : MathnonlinearprogLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_nonlinear_prog_layer_set(s : MathnonlinearprogLayer, i : Int, v : Double) -> MathnonlinearprogLayer {
  let result = math_nonlinear_prog_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_nonlinear_prog_layer_sum(s : MathnonlinearprogLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_nonlinear_prog_layer_mean(s : MathnonlinearprogLayer) -> Double {
  if s.size == 0 { 0.0 } else { math_nonlinear_prog_layer_sum(s) / s.size.to_double() }
}

pub fn math_nonlinear_prog_layer_scale(s : MathnonlinearprogLayer, f : Double) -> MathnonlinearprogLayer {
  let result = math_nonlinear_prog_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_nonlinear_prog_layer_add(a : MathnonlinearprogLayer, b : MathnonlinearprogLayer) -> MathnonlinearprogLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_nonlinear_prog_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_nonlinear_prog_layer_copy(s : MathnonlinearprogLayer) -> MathnonlinearprogLayer {
  let result = math_nonlinear_prog_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_nonlinear_prog_layer_fill(s : MathnonlinearprogLayer, v : Double) -> MathnonlinearprogLayer {
  let result = math_nonlinear_prog_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_nonlinear_prog_layer_min(s : MathnonlinearprogLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_nonlinear_prog_layer_max(s : MathnonlinearprogLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_nonlinear_prog_layer_to_string(s : MathnonlinearprogLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathnonlinearprogBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_nonlinear_prog_buffer_make(size : Int) -> MathnonlinearprogBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_nonlinear_prog_buffer_len(s : MathnonlinearprogBuffer) -> Int { s.size }

pub fn math_nonlinear_prog_buffer_get(s : MathnonlinearprogBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_nonlinear_prog_buffer_set(s : MathnonlinearprogBuffer, i : Int, v : Double) -> MathnonlinearprogBuffer {
  let result = math_nonlinear_prog_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_nonlinear_prog_buffer_sum(s : MathnonlinearprogBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_nonlinear_prog_buffer_mean(s : MathnonlinearprogBuffer) -> Double {
  if s.size == 0 { 0.0 } else { math_nonlinear_prog_buffer_sum(s) / s.size.to_double() }
}

pub fn math_nonlinear_prog_buffer_scale(s : MathnonlinearprogBuffer, f : Double) -> MathnonlinearprogBuffer {
  let result = math_nonlinear_prog_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_nonlinear_prog_buffer_add(a : MathnonlinearprogBuffer, b : MathnonlinearprogBuffer) -> MathnonlinearprogBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_nonlinear_prog_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_nonlinear_prog_buffer_copy(s : MathnonlinearprogBuffer) -> MathnonlinearprogBuffer {
  let result = math_nonlinear_prog_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_nonlinear_prog_buffer_fill(s : MathnonlinearprogBuffer, v : Double) -> MathnonlinearprogBuffer {
  let result = math_nonlinear_prog_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_nonlinear_prog_buffer_min(s : MathnonlinearprogBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_nonlinear_prog_buffer_max(s : MathnonlinearprogBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_nonlinear_prog_buffer_to_string(s : MathnonlinearprogBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathnonlinearprogCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_nonlinear_prog_cursor_make(size : Int) -> MathnonlinearprogCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_nonlinear_prog_cursor_len(s : MathnonlinearprogCursor) -> Int { s.size }

pub fn math_nonlinear_prog_cursor_get(s : MathnonlinearprogCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_nonlinear_prog_cursor_set(s : MathnonlinearprogCursor, i : Int, v : Double) -> MathnonlinearprogCursor {
  let result = math_nonlinear_prog_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_nonlinear_prog_cursor_sum(s : MathnonlinearprogCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_nonlinear_prog_cursor_mean(s : MathnonlinearprogCursor) -> Double {
  if s.size == 0 { 0.0 } else { math_nonlinear_prog_cursor_sum(s) / s.size.to_double() }
}

pub fn math_nonlinear_prog_cursor_scale(s : MathnonlinearprogCursor, f : Double) -> MathnonlinearprogCursor {
  let result = math_nonlinear_prog_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_nonlinear_prog_cursor_add(a : MathnonlinearprogCursor, b : MathnonlinearprogCursor) -> MathnonlinearprogCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_nonlinear_prog_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_nonlinear_prog_cursor_copy(s : MathnonlinearprogCursor) -> MathnonlinearprogCursor {
  let result = math_nonlinear_prog_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_nonlinear_prog_cursor_fill(s : MathnonlinearprogCursor, v : Double) -> MathnonlinearprogCursor {
  let result = math_nonlinear_prog_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_nonlinear_prog_cursor_min(s : MathnonlinearprogCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_nonlinear_prog_cursor_max(s : MathnonlinearprogCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_nonlinear_prog_cursor_to_string(s : MathnonlinearprogCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathnonlinearprogView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_nonlinear_prog_view_make(size : Int) -> MathnonlinearprogView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_nonlinear_prog_view_len(s : MathnonlinearprogView) -> Int { s.size }

pub fn math_nonlinear_prog_view_get(s : MathnonlinearprogView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_nonlinear_prog_view_set(s : MathnonlinearprogView, i : Int, v : Double) -> MathnonlinearprogView {
  let result = math_nonlinear_prog_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_nonlinear_prog_view_sum(s : MathnonlinearprogView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_nonlinear_prog_view_mean(s : MathnonlinearprogView) -> Double {
  if s.size == 0 { 0.0 } else { math_nonlinear_prog_view_sum(s) / s.size.to_double() }
}

pub fn math_nonlinear_prog_view_scale(s : MathnonlinearprogView, f : Double) -> MathnonlinearprogView {
  let result = math_nonlinear_prog_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_nonlinear_prog_view_add(a : MathnonlinearprogView, b : MathnonlinearprogView) -> MathnonlinearprogView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_nonlinear_prog_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_nonlinear_prog_view_copy(s : MathnonlinearprogView) -> MathnonlinearprogView {
  let result = math_nonlinear_prog_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_nonlinear_prog_view_fill(s : MathnonlinearprogView, v : Double) -> MathnonlinearprogView {
  let result = math_nonlinear_prog_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_nonlinear_prog_view_min(s : MathnonlinearprogView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_nonlinear_prog_view_max(s : MathnonlinearprogView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_nonlinear_prog_view_to_string(s : MathnonlinearprogView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathnonlinearprogRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_nonlinear_prog_range_make(size : Int) -> MathnonlinearprogRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_nonlinear_prog_range_len(s : MathnonlinearprogRange) -> Int { s.size }

pub fn math_nonlinear_prog_range_get(s : MathnonlinearprogRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_nonlinear_prog_range_set(s : MathnonlinearprogRange, i : Int, v : Double) -> MathnonlinearprogRange {
  let result = math_nonlinear_prog_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_nonlinear_prog_range_sum(s : MathnonlinearprogRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_nonlinear_prog_range_mean(s : MathnonlinearprogRange) -> Double {
  if s.size == 0 { 0.0 } else { math_nonlinear_prog_range_sum(s) / s.size.to_double() }
}

pub fn math_nonlinear_prog_range_scale(s : MathnonlinearprogRange, f : Double) -> MathnonlinearprogRange {
  let result = math_nonlinear_prog_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_nonlinear_prog_range_add(a : MathnonlinearprogRange, b : MathnonlinearprogRange) -> MathnonlinearprogRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_nonlinear_prog_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_nonlinear_prog_range_copy(s : MathnonlinearprogRange) -> MathnonlinearprogRange {
  let result = math_nonlinear_prog_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_nonlinear_prog_range_fill(s : MathnonlinearprogRange, v : Double) -> MathnonlinearprogRange {
  let result = math_nonlinear_prog_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_nonlinear_prog_range_min(s : MathnonlinearprogRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_nonlinear_prog_range_max(s : MathnonlinearprogRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_nonlinear_prog_range_to_string(s : MathnonlinearprogRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathnonlinearprogSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_nonlinear_prog_slice_make(size : Int) -> MathnonlinearprogSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_nonlinear_prog_slice_len(s : MathnonlinearprogSlice) -> Int { s.size }

pub fn math_nonlinear_prog_slice_get(s : MathnonlinearprogSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_nonlinear_prog_slice_set(s : MathnonlinearprogSlice, i : Int, v : Double) -> MathnonlinearprogSlice {
  let result = math_nonlinear_prog_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_nonlinear_prog_slice_sum(s : MathnonlinearprogSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_nonlinear_prog_slice_mean(s : MathnonlinearprogSlice) -> Double {
  if s.size == 0 { 0.0 } else { math_nonlinear_prog_slice_sum(s) / s.size.to_double() }
}

pub fn math_nonlinear_prog_slice_scale(s : MathnonlinearprogSlice, f : Double) -> MathnonlinearprogSlice {
  let result = math_nonlinear_prog_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_nonlinear_prog_slice_add(a : MathnonlinearprogSlice, b : MathnonlinearprogSlice) -> MathnonlinearprogSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_nonlinear_prog_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_nonlinear_prog_slice_copy(s : MathnonlinearprogSlice) -> MathnonlinearprogSlice {
  let result = math_nonlinear_prog_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_nonlinear_prog_slice_fill(s : MathnonlinearprogSlice, v : Double) -> MathnonlinearprogSlice {
  let result = math_nonlinear_prog_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_nonlinear_prog_slice_min(s : MathnonlinearprogSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_nonlinear_prog_slice_max(s : MathnonlinearprogSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_nonlinear_prog_slice_to_string(s : MathnonlinearprogSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn math_nonlinear_prog_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_nonlinear_prog_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_nonlinear_prog_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_nonlinear_prog_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_nonlinear_prog_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_nonlinear_prog_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_nonlinear_prog_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_nonlinear_prog_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_nonlinear_prog_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_nonlinear_prog_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_nonlinear_prog_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_nonlinear_prog_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_nonlinear_prog_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_nonlinear_prog_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_nonlinear_prog_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_nonlinear_prog_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_nonlinear_prog_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_nonlinear_prog_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_nonlinear_prog_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_nonlinear_prog_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_nonlinear_prog_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_nonlinear_prog_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_nonlinear_prog_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_nonlinear_prog_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_nonlinear_prog_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

