///===
/// extcore/math_special_bessel

pub(all) struct MathspecialbesselPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn math_special_bessel_make_point(x : Double, y : Double) -> MathspecialbesselPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn math_special_bessel_make_point3(x : Double, y : Double, z : Double) -> MathspecialbesselPoint {
  { x, y, z, label: 0 }
}

pub fn math_special_bessel_point_x(pt : MathspecialbesselPoint) -> Double { pt.x }

pub fn math_special_bessel_point_y(pt : MathspecialbesselPoint) -> Double { pt.y }

pub fn math_special_bessel_point_z(pt : MathspecialbesselPoint) -> Double { pt.z }

pub fn math_special_bessel_point_label(pt : MathspecialbesselPoint) -> Int { pt.label }

pub fn math_special_bessel_point_dist(a : MathspecialbesselPoint, b : MathspecialbesselPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  math_special_bessel_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn math_special_bessel_point_add(a : MathspecialbesselPoint, b : MathspecialbesselPoint) -> MathspecialbesselPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn math_special_bessel_point_sub(a : MathspecialbesselPoint, b : MathspecialbesselPoint) -> MathspecialbesselPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn math_special_bessel_point_scale(pt : MathspecialbesselPoint, s : Double) -> MathspecialbesselPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn math_special_bessel_point_dot(a : MathspecialbesselPoint, b : MathspecialbesselPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn math_special_bessel_point_cross(a : MathspecialbesselPoint, b : MathspecialbesselPoint) -> MathspecialbesselPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn math_special_bessel_point_norm(pt : MathspecialbesselPoint) -> Double {
  math_special_bessel_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn math_special_bessel_point_normalize(pt : MathspecialbesselPoint) -> MathspecialbesselPoint {
  let n = math_special_bessel_point_norm(pt)
  if n < 0.0000001 { pt } else { math_special_bessel_point_scale(pt, 1.0 / n) }
}

pub fn math_special_bessel_point_negate(pt : MathspecialbesselPoint) -> MathspecialbesselPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn math_special_bessel_point_mid(a : MathspecialbesselPoint, b : MathspecialbesselPoint) -> MathspecialbesselPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn math_special_bessel_point_lerp(a : MathspecialbesselPoint, b : MathspecialbesselPoint, t : Double) -> MathspecialbesselPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn math_special_bessel_point_to_string(pt : MathspecialbesselPoint) -> String {
  "(" + math_special_bessel_dbl(pt.x) + ", " + math_special_bessel_dbl(pt.y) + ", " + math_special_bessel_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct MathspecialbesselSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn math_special_bessel_make_series(vals : Array[Double], name : String) -> MathspecialbesselSeries {
  { vals, name, meta: 0 }
}

pub fn math_special_bessel_series_len(s : MathspecialbesselSeries) -> Int { s.vals.length() }

pub fn math_special_bessel_series_sum(s : MathspecialbesselSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn math_special_bessel_series_mean(s : MathspecialbesselSeries) -> Double {
  let n = math_special_bessel_series_len(s)
  if n == 0 { 0.0 } else { math_special_bessel_series_sum(s) / n.to_double() }
}

pub fn math_special_bessel_series_min(s : MathspecialbesselSeries) -> Double {
  let n = math_special_bessel_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn math_special_bessel_series_max(s : MathspecialbesselSeries) -> Double {
  let n = math_special_bessel_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn math_special_bessel_series_range(s : MathspecialbesselSeries) -> Double {
  math_special_bessel_series_max(s) - math_special_bessel_series_min(s)
}

pub fn math_special_bessel_series_var(s : MathspecialbesselSeries) -> Double {
  let n = math_special_bessel_series_len(s)
  if n == 0 { 0.0 } else {
    let m = math_special_bessel_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn math_special_bessel_series_std(s : MathspecialbesselSeries) -> Double { math_special_bessel_sqrt(math_special_bessel_series_var(s)) }

pub fn math_special_bessel_series_median(s : MathspecialbesselSeries) -> Double {
  let n = math_special_bessel_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = math_special_bessel_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn math_special_bessel_series_scale(s : MathspecialbesselSeries, f : Double) -> MathspecialbesselSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = math_special_bessel_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn math_special_bessel_series_add(a : MathspecialbesselSeries, b : MathspecialbesselSeries) -> MathspecialbesselSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = math_special_bessel_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn math_special_bessel_series_sub(a : MathspecialbesselSeries, b : MathspecialbesselSeries) -> MathspecialbesselSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = math_special_bessel_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn math_special_bessel_series_normalize(s : MathspecialbesselSeries) -> MathspecialbesselSeries {
  let mn = math_special_bessel_series_min(s)
  let mx = math_special_bessel_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = math_special_bessel_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn math_special_bessel_series_cumsum(s : MathspecialbesselSeries) -> MathspecialbesselSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = math_special_bessel_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn math_special_bessel_series_to_string(s : MathspecialbesselSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + math_special_bessel_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MathspecialbesselMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn math_special_bessel_make_matrix(rows : Int, cols : Int, val : Double) -> MathspecialbesselMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn math_special_bessel_matrix_identity(n : Int) -> MathspecialbesselMatrix {
  let m = math_special_bessel_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn math_special_bessel_matrix_get(m : MathspecialbesselMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn math_special_bessel_matrix_transpose(m : MathspecialbesselMatrix) -> MathspecialbesselMatrix {
  let result = math_special_bessel_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn math_special_bessel_matrix_add(a : MathspecialbesselMatrix, b : MathspecialbesselMatrix) -> MathspecialbesselMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = math_special_bessel_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn math_special_bessel_matrix_scale(m : MathspecialbesselMatrix, s : Double) -> MathspecialbesselMatrix {
  let result = math_special_bessel_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn math_special_bessel_matrix_multiply(a : MathspecialbesselMatrix, b : MathspecialbesselMatrix) -> MathspecialbesselMatrix {
  if a.cols != b.rows { return math_special_bessel_make_matrix(a.rows, b.cols, 0.0) }
  let result = math_special_bessel_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn math_special_bessel_matrix_trace(m : MathspecialbesselMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn math_special_bessel_matrix_det(m : MathspecialbesselMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn math_special_bessel_matrix_norm(m : MathspecialbesselMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  math_special_bessel_sqrt(sum)
}

pub fn math_special_bessel_matrix_to_string(m : MathspecialbesselMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + math_special_bessel_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct MathspecialbesselVector {
  comps : Array[Double]
  dim : Int
}

pub fn math_special_bessel_make_vector(comps : Array[Double]) -> MathspecialbesselVector {
  { comps, dim: comps.length() }
}

pub fn math_special_bessel_vector_zero(dim : Int) -> MathspecialbesselVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn math_special_bessel_vector_add(a : MathspecialbesselVector, b : MathspecialbesselVector) -> MathspecialbesselVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = math_special_bessel_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn math_special_bessel_vector_sub(a : MathspecialbesselVector, b : MathspecialbesselVector) -> MathspecialbesselVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = math_special_bessel_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn math_special_bessel_vector_scale(v : MathspecialbesselVector, s : Double) -> MathspecialbesselVector {
  let mut result = []
  for i in 0..<v.dim { result = math_special_bessel_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn math_special_bessel_vector_dot(a : MathspecialbesselVector, b : MathspecialbesselVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn math_special_bessel_vector_norm(v : MathspecialbesselVector) -> Double { math_special_bessel_sqrt(math_special_bessel_vector_dot(v, v)) }

pub fn math_special_bessel_vector_normalize(v : MathspecialbesselVector) -> MathspecialbesselVector {
  let n = math_special_bessel_vector_norm(v)
  if n < 0.0000001 { v } else { math_special_bessel_vector_scale(v, 1.0 / n) }
}

pub fn math_special_bessel_vector_dist(a : MathspecialbesselVector, b : MathspecialbesselVector) -> Double {
  math_special_bessel_vector_norm(math_special_bessel_vector_sub(a, b))
}

pub fn math_special_bessel_vector_to_string(v : MathspecialbesselVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + math_special_bessel_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn math_special_bessel_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn math_special_bessel_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = math_special_bessel_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn math_special_bessel_std(data : Array[Double]) -> Double { math_special_bessel_sqrt(math_special_bessel_var(data)) }

pub fn math_special_bessel_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = math_special_bessel_mean(a); let mb = math_special_bessel_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn math_special_bessel_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = math_special_bessel_std(a); let sb = math_special_bessel_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { math_special_bessel_cov(a, b) / (sa * sb) }
}

pub fn math_special_bessel_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = math_special_bessel_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn math_special_bessel_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn math_special_bessel_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn math_special_bessel_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  math_special_bessel_sqrt(math_special_bessel_mse(pred, labels))
}

pub fn math_special_bessel_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + math_special_bessel_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn math_special_bessel_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = math_special_bessel_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn math_special_bessel_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn math_special_bessel_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn math_special_bessel_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = math_special_bessel_precision(pred, labels, pos); let r = math_special_bessel_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn math_special_bessel_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn math_special_bessel_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = math_special_bessel_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn math_special_bessel_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn math_special_bessel_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn math_special_bessel_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = math_special_bessel_gcd(a, b)
    (a / g) * b
  }
}

pub fn math_special_bessel_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn math_special_bessel_fibonacci(n : Int) -> Int {
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

pub fn math_special_bessel_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = math_special_bessel_min(data); let mx = math_special_bessel_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn math_special_bessel_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = math_special_bessel_mean(data); let sd = math_special_bessel_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn math_special_bessel_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn math_special_bessel_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn math_special_bessel_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn math_special_bessel_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn math_special_bessel_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn math_special_bessel_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn math_special_bessel_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn math_special_bessel_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn math_special_bessel_dbl(x : Double) -> String {
  let i = if x >= 0.0 { math_special_bessel_int(x) } else { -math_special_bessel_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { math_special_bessel_int(f * 1000000.0) } else { math_special_bessel_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn math_special_bessel_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn math_special_bessel_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct MathspecialbesselFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_bessel_frame_make(size : Int) -> MathspecialbesselFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_bessel_frame_len(s : MathspecialbesselFrame) -> Int { s.size }

pub fn math_special_bessel_frame_get(s : MathspecialbesselFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_bessel_frame_set(s : MathspecialbesselFrame, i : Int, v : Double) -> MathspecialbesselFrame {
  let result = math_special_bessel_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_special_bessel_frame_sum(s : MathspecialbesselFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_special_bessel_frame_mean(s : MathspecialbesselFrame) -> Double {
  if s.size == 0 { 0.0 } else { math_special_bessel_frame_sum(s) / s.size.to_double() }
}

pub fn math_special_bessel_frame_scale(s : MathspecialbesselFrame, f : Double) -> MathspecialbesselFrame {
  let result = math_special_bessel_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_special_bessel_frame_add(a : MathspecialbesselFrame, b : MathspecialbesselFrame) -> MathspecialbesselFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_special_bessel_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_special_bessel_frame_copy(s : MathspecialbesselFrame) -> MathspecialbesselFrame {
  let result = math_special_bessel_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_special_bessel_frame_fill(s : MathspecialbesselFrame, v : Double) -> MathspecialbesselFrame {
  let result = math_special_bessel_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_special_bessel_frame_min(s : MathspecialbesselFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_special_bessel_frame_max(s : MathspecialbesselFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_special_bessel_frame_to_string(s : MathspecialbesselFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialbesselTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_bessel_table_make(size : Int) -> MathspecialbesselTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_bessel_table_len(s : MathspecialbesselTable) -> Int { s.size }

pub fn math_special_bessel_table_get(s : MathspecialbesselTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_bessel_table_set(s : MathspecialbesselTable, i : Int, v : Double) -> MathspecialbesselTable {
  let result = math_special_bessel_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_special_bessel_table_sum(s : MathspecialbesselTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_special_bessel_table_mean(s : MathspecialbesselTable) -> Double {
  if s.size == 0 { 0.0 } else { math_special_bessel_table_sum(s) / s.size.to_double() }
}

pub fn math_special_bessel_table_scale(s : MathspecialbesselTable, f : Double) -> MathspecialbesselTable {
  let result = math_special_bessel_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_special_bessel_table_add(a : MathspecialbesselTable, b : MathspecialbesselTable) -> MathspecialbesselTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_special_bessel_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_special_bessel_table_copy(s : MathspecialbesselTable) -> MathspecialbesselTable {
  let result = math_special_bessel_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_special_bessel_table_fill(s : MathspecialbesselTable, v : Double) -> MathspecialbesselTable {
  let result = math_special_bessel_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_special_bessel_table_min(s : MathspecialbesselTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_special_bessel_table_max(s : MathspecialbesselTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_special_bessel_table_to_string(s : MathspecialbesselTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialbesselGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_bessel_graphn_make(size : Int) -> MathspecialbesselGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_bessel_graphn_len(s : MathspecialbesselGraphN) -> Int { s.size }

pub fn math_special_bessel_graphn_get(s : MathspecialbesselGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_bessel_graphn_set(s : MathspecialbesselGraphN, i : Int, v : Double) -> MathspecialbesselGraphN {
  let result = math_special_bessel_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_special_bessel_graphn_sum(s : MathspecialbesselGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_special_bessel_graphn_mean(s : MathspecialbesselGraphN) -> Double {
  if s.size == 0 { 0.0 } else { math_special_bessel_graphn_sum(s) / s.size.to_double() }
}

pub fn math_special_bessel_graphn_scale(s : MathspecialbesselGraphN, f : Double) -> MathspecialbesselGraphN {
  let result = math_special_bessel_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_special_bessel_graphn_add(a : MathspecialbesselGraphN, b : MathspecialbesselGraphN) -> MathspecialbesselGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_special_bessel_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_special_bessel_graphn_copy(s : MathspecialbesselGraphN) -> MathspecialbesselGraphN {
  let result = math_special_bessel_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_special_bessel_graphn_fill(s : MathspecialbesselGraphN, v : Double) -> MathspecialbesselGraphN {
  let result = math_special_bessel_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_special_bessel_graphn_min(s : MathspecialbesselGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_special_bessel_graphn_max(s : MathspecialbesselGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_special_bessel_graphn_to_string(s : MathspecialbesselGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialbesselNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_bessel_node_make(size : Int) -> MathspecialbesselNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_bessel_node_len(s : MathspecialbesselNode) -> Int { s.size }

pub fn math_special_bessel_node_get(s : MathspecialbesselNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_bessel_node_set(s : MathspecialbesselNode, i : Int, v : Double) -> MathspecialbesselNode {
  let result = math_special_bessel_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_special_bessel_node_sum(s : MathspecialbesselNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_special_bessel_node_mean(s : MathspecialbesselNode) -> Double {
  if s.size == 0 { 0.0 } else { math_special_bessel_node_sum(s) / s.size.to_double() }
}

pub fn math_special_bessel_node_scale(s : MathspecialbesselNode, f : Double) -> MathspecialbesselNode {
  let result = math_special_bessel_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_special_bessel_node_add(a : MathspecialbesselNode, b : MathspecialbesselNode) -> MathspecialbesselNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_special_bessel_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_special_bessel_node_copy(s : MathspecialbesselNode) -> MathspecialbesselNode {
  let result = math_special_bessel_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_special_bessel_node_fill(s : MathspecialbesselNode, v : Double) -> MathspecialbesselNode {
  let result = math_special_bessel_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_special_bessel_node_min(s : MathspecialbesselNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_special_bessel_node_max(s : MathspecialbesselNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_special_bessel_node_to_string(s : MathspecialbesselNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialbesselEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_bessel_edge_make(size : Int) -> MathspecialbesselEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_bessel_edge_len(s : MathspecialbesselEdge) -> Int { s.size }

pub fn math_special_bessel_edge_get(s : MathspecialbesselEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_bessel_edge_set(s : MathspecialbesselEdge, i : Int, v : Double) -> MathspecialbesselEdge {
  let result = math_special_bessel_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_special_bessel_edge_sum(s : MathspecialbesselEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_special_bessel_edge_mean(s : MathspecialbesselEdge) -> Double {
  if s.size == 0 { 0.0 } else { math_special_bessel_edge_sum(s) / s.size.to_double() }
}

pub fn math_special_bessel_edge_scale(s : MathspecialbesselEdge, f : Double) -> MathspecialbesselEdge {
  let result = math_special_bessel_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_special_bessel_edge_add(a : MathspecialbesselEdge, b : MathspecialbesselEdge) -> MathspecialbesselEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_special_bessel_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_special_bessel_edge_copy(s : MathspecialbesselEdge) -> MathspecialbesselEdge {
  let result = math_special_bessel_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_special_bessel_edge_fill(s : MathspecialbesselEdge, v : Double) -> MathspecialbesselEdge {
  let result = math_special_bessel_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_special_bessel_edge_min(s : MathspecialbesselEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_special_bessel_edge_max(s : MathspecialbesselEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_special_bessel_edge_to_string(s : MathspecialbesselEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialbesselPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_bessel_path_make(size : Int) -> MathspecialbesselPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_bessel_path_len(s : MathspecialbesselPath) -> Int { s.size }

pub fn math_special_bessel_path_get(s : MathspecialbesselPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_bessel_path_set(s : MathspecialbesselPath, i : Int, v : Double) -> MathspecialbesselPath {
  let result = math_special_bessel_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_special_bessel_path_sum(s : MathspecialbesselPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_special_bessel_path_mean(s : MathspecialbesselPath) -> Double {
  if s.size == 0 { 0.0 } else { math_special_bessel_path_sum(s) / s.size.to_double() }
}

pub fn math_special_bessel_path_scale(s : MathspecialbesselPath, f : Double) -> MathspecialbesselPath {
  let result = math_special_bessel_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_special_bessel_path_add(a : MathspecialbesselPath, b : MathspecialbesselPath) -> MathspecialbesselPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_special_bessel_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_special_bessel_path_copy(s : MathspecialbesselPath) -> MathspecialbesselPath {
  let result = math_special_bessel_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_special_bessel_path_fill(s : MathspecialbesselPath, v : Double) -> MathspecialbesselPath {
  let result = math_special_bessel_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_special_bessel_path_min(s : MathspecialbesselPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_special_bessel_path_max(s : MathspecialbesselPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_special_bessel_path_to_string(s : MathspecialbesselPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialbesselCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_bessel_cluster_make(size : Int) -> MathspecialbesselCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_bessel_cluster_len(s : MathspecialbesselCluster) -> Int { s.size }

pub fn math_special_bessel_cluster_get(s : MathspecialbesselCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_bessel_cluster_set(s : MathspecialbesselCluster, i : Int, v : Double) -> MathspecialbesselCluster {
  let result = math_special_bessel_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_special_bessel_cluster_sum(s : MathspecialbesselCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_special_bessel_cluster_mean(s : MathspecialbesselCluster) -> Double {
  if s.size == 0 { 0.0 } else { math_special_bessel_cluster_sum(s) / s.size.to_double() }
}

pub fn math_special_bessel_cluster_scale(s : MathspecialbesselCluster, f : Double) -> MathspecialbesselCluster {
  let result = math_special_bessel_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_special_bessel_cluster_add(a : MathspecialbesselCluster, b : MathspecialbesselCluster) -> MathspecialbesselCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_special_bessel_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_special_bessel_cluster_copy(s : MathspecialbesselCluster) -> MathspecialbesselCluster {
  let result = math_special_bessel_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_special_bessel_cluster_fill(s : MathspecialbesselCluster, v : Double) -> MathspecialbesselCluster {
  let result = math_special_bessel_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_special_bessel_cluster_min(s : MathspecialbesselCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_special_bessel_cluster_max(s : MathspecialbesselCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_special_bessel_cluster_to_string(s : MathspecialbesselCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialbesselModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_bessel_model_make(size : Int) -> MathspecialbesselModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_bessel_model_len(s : MathspecialbesselModel) -> Int { s.size }

pub fn math_special_bessel_model_get(s : MathspecialbesselModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_bessel_model_set(s : MathspecialbesselModel, i : Int, v : Double) -> MathspecialbesselModel {
  let result = math_special_bessel_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_special_bessel_model_sum(s : MathspecialbesselModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_special_bessel_model_mean(s : MathspecialbesselModel) -> Double {
  if s.size == 0 { 0.0 } else { math_special_bessel_model_sum(s) / s.size.to_double() }
}

pub fn math_special_bessel_model_scale(s : MathspecialbesselModel, f : Double) -> MathspecialbesselModel {
  let result = math_special_bessel_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_special_bessel_model_add(a : MathspecialbesselModel, b : MathspecialbesselModel) -> MathspecialbesselModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_special_bessel_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_special_bessel_model_copy(s : MathspecialbesselModel) -> MathspecialbesselModel {
  let result = math_special_bessel_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_special_bessel_model_fill(s : MathspecialbesselModel, v : Double) -> MathspecialbesselModel {
  let result = math_special_bessel_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_special_bessel_model_min(s : MathspecialbesselModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_special_bessel_model_max(s : MathspecialbesselModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_special_bessel_model_to_string(s : MathspecialbesselModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialbesselLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_bessel_layer_make(size : Int) -> MathspecialbesselLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_bessel_layer_len(s : MathspecialbesselLayer) -> Int { s.size }

pub fn math_special_bessel_layer_get(s : MathspecialbesselLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_bessel_layer_set(s : MathspecialbesselLayer, i : Int, v : Double) -> MathspecialbesselLayer {
  let result = math_special_bessel_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_special_bessel_layer_sum(s : MathspecialbesselLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_special_bessel_layer_mean(s : MathspecialbesselLayer) -> Double {
  if s.size == 0 { 0.0 } else { math_special_bessel_layer_sum(s) / s.size.to_double() }
}

pub fn math_special_bessel_layer_scale(s : MathspecialbesselLayer, f : Double) -> MathspecialbesselLayer {
  let result = math_special_bessel_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_special_bessel_layer_add(a : MathspecialbesselLayer, b : MathspecialbesselLayer) -> MathspecialbesselLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_special_bessel_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_special_bessel_layer_copy(s : MathspecialbesselLayer) -> MathspecialbesselLayer {
  let result = math_special_bessel_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_special_bessel_layer_fill(s : MathspecialbesselLayer, v : Double) -> MathspecialbesselLayer {
  let result = math_special_bessel_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_special_bessel_layer_min(s : MathspecialbesselLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_special_bessel_layer_max(s : MathspecialbesselLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_special_bessel_layer_to_string(s : MathspecialbesselLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialbesselBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_bessel_buffer_make(size : Int) -> MathspecialbesselBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_bessel_buffer_len(s : MathspecialbesselBuffer) -> Int { s.size }

pub fn math_special_bessel_buffer_get(s : MathspecialbesselBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_bessel_buffer_set(s : MathspecialbesselBuffer, i : Int, v : Double) -> MathspecialbesselBuffer {
  let result = math_special_bessel_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_special_bessel_buffer_sum(s : MathspecialbesselBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_special_bessel_buffer_mean(s : MathspecialbesselBuffer) -> Double {
  if s.size == 0 { 0.0 } else { math_special_bessel_buffer_sum(s) / s.size.to_double() }
}

pub fn math_special_bessel_buffer_scale(s : MathspecialbesselBuffer, f : Double) -> MathspecialbesselBuffer {
  let result = math_special_bessel_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_special_bessel_buffer_add(a : MathspecialbesselBuffer, b : MathspecialbesselBuffer) -> MathspecialbesselBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_special_bessel_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_special_bessel_buffer_copy(s : MathspecialbesselBuffer) -> MathspecialbesselBuffer {
  let result = math_special_bessel_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_special_bessel_buffer_fill(s : MathspecialbesselBuffer, v : Double) -> MathspecialbesselBuffer {
  let result = math_special_bessel_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_special_bessel_buffer_min(s : MathspecialbesselBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_special_bessel_buffer_max(s : MathspecialbesselBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_special_bessel_buffer_to_string(s : MathspecialbesselBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialbesselCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_bessel_cursor_make(size : Int) -> MathspecialbesselCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_bessel_cursor_len(s : MathspecialbesselCursor) -> Int { s.size }

pub fn math_special_bessel_cursor_get(s : MathspecialbesselCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_bessel_cursor_set(s : MathspecialbesselCursor, i : Int, v : Double) -> MathspecialbesselCursor {
  let result = math_special_bessel_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_special_bessel_cursor_sum(s : MathspecialbesselCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_special_bessel_cursor_mean(s : MathspecialbesselCursor) -> Double {
  if s.size == 0 { 0.0 } else { math_special_bessel_cursor_sum(s) / s.size.to_double() }
}

pub fn math_special_bessel_cursor_scale(s : MathspecialbesselCursor, f : Double) -> MathspecialbesselCursor {
  let result = math_special_bessel_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_special_bessel_cursor_add(a : MathspecialbesselCursor, b : MathspecialbesselCursor) -> MathspecialbesselCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_special_bessel_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_special_bessel_cursor_copy(s : MathspecialbesselCursor) -> MathspecialbesselCursor {
  let result = math_special_bessel_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_special_bessel_cursor_fill(s : MathspecialbesselCursor, v : Double) -> MathspecialbesselCursor {
  let result = math_special_bessel_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_special_bessel_cursor_min(s : MathspecialbesselCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_special_bessel_cursor_max(s : MathspecialbesselCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_special_bessel_cursor_to_string(s : MathspecialbesselCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialbesselView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_bessel_view_make(size : Int) -> MathspecialbesselView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_bessel_view_len(s : MathspecialbesselView) -> Int { s.size }

pub fn math_special_bessel_view_get(s : MathspecialbesselView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_bessel_view_set(s : MathspecialbesselView, i : Int, v : Double) -> MathspecialbesselView {
  let result = math_special_bessel_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_special_bessel_view_sum(s : MathspecialbesselView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_special_bessel_view_mean(s : MathspecialbesselView) -> Double {
  if s.size == 0 { 0.0 } else { math_special_bessel_view_sum(s) / s.size.to_double() }
}

pub fn math_special_bessel_view_scale(s : MathspecialbesselView, f : Double) -> MathspecialbesselView {
  let result = math_special_bessel_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_special_bessel_view_add(a : MathspecialbesselView, b : MathspecialbesselView) -> MathspecialbesselView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_special_bessel_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_special_bessel_view_copy(s : MathspecialbesselView) -> MathspecialbesselView {
  let result = math_special_bessel_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_special_bessel_view_fill(s : MathspecialbesselView, v : Double) -> MathspecialbesselView {
  let result = math_special_bessel_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_special_bessel_view_min(s : MathspecialbesselView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_special_bessel_view_max(s : MathspecialbesselView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_special_bessel_view_to_string(s : MathspecialbesselView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialbesselRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_bessel_range_make(size : Int) -> MathspecialbesselRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_bessel_range_len(s : MathspecialbesselRange) -> Int { s.size }

pub fn math_special_bessel_range_get(s : MathspecialbesselRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_bessel_range_set(s : MathspecialbesselRange, i : Int, v : Double) -> MathspecialbesselRange {
  let result = math_special_bessel_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_special_bessel_range_sum(s : MathspecialbesselRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_special_bessel_range_mean(s : MathspecialbesselRange) -> Double {
  if s.size == 0 { 0.0 } else { math_special_bessel_range_sum(s) / s.size.to_double() }
}

pub fn math_special_bessel_range_scale(s : MathspecialbesselRange, f : Double) -> MathspecialbesselRange {
  let result = math_special_bessel_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_special_bessel_range_add(a : MathspecialbesselRange, b : MathspecialbesselRange) -> MathspecialbesselRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_special_bessel_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_special_bessel_range_copy(s : MathspecialbesselRange) -> MathspecialbesselRange {
  let result = math_special_bessel_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_special_bessel_range_fill(s : MathspecialbesselRange, v : Double) -> MathspecialbesselRange {
  let result = math_special_bessel_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_special_bessel_range_min(s : MathspecialbesselRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_special_bessel_range_max(s : MathspecialbesselRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_special_bessel_range_to_string(s : MathspecialbesselRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialbesselSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_bessel_slice_make(size : Int) -> MathspecialbesselSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_bessel_slice_len(s : MathspecialbesselSlice) -> Int { s.size }

pub fn math_special_bessel_slice_get(s : MathspecialbesselSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_bessel_slice_set(s : MathspecialbesselSlice, i : Int, v : Double) -> MathspecialbesselSlice {
  let result = math_special_bessel_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_special_bessel_slice_sum(s : MathspecialbesselSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_special_bessel_slice_mean(s : MathspecialbesselSlice) -> Double {
  if s.size == 0 { 0.0 } else { math_special_bessel_slice_sum(s) / s.size.to_double() }
}

pub fn math_special_bessel_slice_scale(s : MathspecialbesselSlice, f : Double) -> MathspecialbesselSlice {
  let result = math_special_bessel_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_special_bessel_slice_add(a : MathspecialbesselSlice, b : MathspecialbesselSlice) -> MathspecialbesselSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_special_bessel_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_special_bessel_slice_copy(s : MathspecialbesselSlice) -> MathspecialbesselSlice {
  let result = math_special_bessel_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_special_bessel_slice_fill(s : MathspecialbesselSlice, v : Double) -> MathspecialbesselSlice {
  let result = math_special_bessel_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_special_bessel_slice_min(s : MathspecialbesselSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_special_bessel_slice_max(s : MathspecialbesselSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_special_bessel_slice_to_string(s : MathspecialbesselSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn math_special_bessel_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_special_bessel_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_special_bessel_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_special_bessel_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_special_bessel_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_special_bessel_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_special_bessel_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_special_bessel_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_special_bessel_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_special_bessel_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_special_bessel_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_special_bessel_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_special_bessel_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_special_bessel_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_special_bessel_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_special_bessel_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_special_bessel_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_special_bessel_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_special_bessel_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_special_bessel_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_special_bessel_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_special_bessel_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_special_bessel_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_special_bessel_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_special_bessel_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

