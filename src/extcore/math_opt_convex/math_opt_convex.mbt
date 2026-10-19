///===
/// extcore/math_opt_convex

pub(all) struct MathoptconvexPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn math_opt_convex_make_point(x : Double, y : Double) -> MathoptconvexPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn math_opt_convex_make_point3(x : Double, y : Double, z : Double) -> MathoptconvexPoint {
  { x, y, z, label: 0 }
}

pub fn math_opt_convex_point_x(pt : MathoptconvexPoint) -> Double { pt.x }

pub fn math_opt_convex_point_y(pt : MathoptconvexPoint) -> Double { pt.y }

pub fn math_opt_convex_point_z(pt : MathoptconvexPoint) -> Double { pt.z }

pub fn math_opt_convex_point_label(pt : MathoptconvexPoint) -> Int { pt.label }

pub fn math_opt_convex_point_dist(a : MathoptconvexPoint, b : MathoptconvexPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  math_opt_convex_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn math_opt_convex_point_add(a : MathoptconvexPoint, b : MathoptconvexPoint) -> MathoptconvexPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn math_opt_convex_point_sub(a : MathoptconvexPoint, b : MathoptconvexPoint) -> MathoptconvexPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn math_opt_convex_point_scale(pt : MathoptconvexPoint, s : Double) -> MathoptconvexPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn math_opt_convex_point_dot(a : MathoptconvexPoint, b : MathoptconvexPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn math_opt_convex_point_cross(a : MathoptconvexPoint, b : MathoptconvexPoint) -> MathoptconvexPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn math_opt_convex_point_norm(pt : MathoptconvexPoint) -> Double {
  math_opt_convex_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn math_opt_convex_point_normalize(pt : MathoptconvexPoint) -> MathoptconvexPoint {
  let n = math_opt_convex_point_norm(pt)
  if n < 0.0000001 { pt } else { math_opt_convex_point_scale(pt, 1.0 / n) }
}

pub fn math_opt_convex_point_negate(pt : MathoptconvexPoint) -> MathoptconvexPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn math_opt_convex_point_mid(a : MathoptconvexPoint, b : MathoptconvexPoint) -> MathoptconvexPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn math_opt_convex_point_lerp(a : MathoptconvexPoint, b : MathoptconvexPoint, t : Double) -> MathoptconvexPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn math_opt_convex_point_to_string(pt : MathoptconvexPoint) -> String {
  "(" + math_opt_convex_dbl(pt.x) + ", " + math_opt_convex_dbl(pt.y) + ", " + math_opt_convex_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct MathoptconvexSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn math_opt_convex_make_series(vals : Array[Double], name : String) -> MathoptconvexSeries {
  { vals, name, meta: 0 }
}

pub fn math_opt_convex_series_len(s : MathoptconvexSeries) -> Int { s.vals.length() }

pub fn math_opt_convex_series_sum(s : MathoptconvexSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn math_opt_convex_series_mean(s : MathoptconvexSeries) -> Double {
  let n = math_opt_convex_series_len(s)
  if n == 0 { 0.0 } else { math_opt_convex_series_sum(s) / n.to_double() }
}

pub fn math_opt_convex_series_min(s : MathoptconvexSeries) -> Double {
  let n = math_opt_convex_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn math_opt_convex_series_max(s : MathoptconvexSeries) -> Double {
  let n = math_opt_convex_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn math_opt_convex_series_range(s : MathoptconvexSeries) -> Double {
  math_opt_convex_series_max(s) - math_opt_convex_series_min(s)
}

pub fn math_opt_convex_series_var(s : MathoptconvexSeries) -> Double {
  let n = math_opt_convex_series_len(s)
  if n == 0 { 0.0 } else {
    let m = math_opt_convex_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn math_opt_convex_series_std(s : MathoptconvexSeries) -> Double { math_opt_convex_sqrt(math_opt_convex_series_var(s)) }

pub fn math_opt_convex_series_median(s : MathoptconvexSeries) -> Double {
  let n = math_opt_convex_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = math_opt_convex_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn math_opt_convex_series_scale(s : MathoptconvexSeries, f : Double) -> MathoptconvexSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = math_opt_convex_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn math_opt_convex_series_add(a : MathoptconvexSeries, b : MathoptconvexSeries) -> MathoptconvexSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = math_opt_convex_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn math_opt_convex_series_sub(a : MathoptconvexSeries, b : MathoptconvexSeries) -> MathoptconvexSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = math_opt_convex_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn math_opt_convex_series_normalize(s : MathoptconvexSeries) -> MathoptconvexSeries {
  let mn = math_opt_convex_series_min(s)
  let mx = math_opt_convex_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = math_opt_convex_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn math_opt_convex_series_cumsum(s : MathoptconvexSeries) -> MathoptconvexSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = math_opt_convex_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn math_opt_convex_series_to_string(s : MathoptconvexSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + math_opt_convex_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MathoptconvexMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn math_opt_convex_make_matrix(rows : Int, cols : Int, val : Double) -> MathoptconvexMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn math_opt_convex_matrix_identity(n : Int) -> MathoptconvexMatrix {
  let m = math_opt_convex_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn math_opt_convex_matrix_get(m : MathoptconvexMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn math_opt_convex_matrix_transpose(m : MathoptconvexMatrix) -> MathoptconvexMatrix {
  let result = math_opt_convex_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn math_opt_convex_matrix_add(a : MathoptconvexMatrix, b : MathoptconvexMatrix) -> MathoptconvexMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = math_opt_convex_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn math_opt_convex_matrix_scale(m : MathoptconvexMatrix, s : Double) -> MathoptconvexMatrix {
  let result = math_opt_convex_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn math_opt_convex_matrix_multiply(a : MathoptconvexMatrix, b : MathoptconvexMatrix) -> MathoptconvexMatrix {
  if a.cols != b.rows { return math_opt_convex_make_matrix(a.rows, b.cols, 0.0) }
  let result = math_opt_convex_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn math_opt_convex_matrix_trace(m : MathoptconvexMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn math_opt_convex_matrix_det(m : MathoptconvexMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn math_opt_convex_matrix_norm(m : MathoptconvexMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  math_opt_convex_sqrt(sum)
}

pub fn math_opt_convex_matrix_to_string(m : MathoptconvexMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + math_opt_convex_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct MathoptconvexVector {
  comps : Array[Double]
  dim : Int
}

pub fn math_opt_convex_make_vector(comps : Array[Double]) -> MathoptconvexVector {
  { comps, dim: comps.length() }
}

pub fn math_opt_convex_vector_zero(dim : Int) -> MathoptconvexVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn math_opt_convex_vector_add(a : MathoptconvexVector, b : MathoptconvexVector) -> MathoptconvexVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = math_opt_convex_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn math_opt_convex_vector_sub(a : MathoptconvexVector, b : MathoptconvexVector) -> MathoptconvexVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = math_opt_convex_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn math_opt_convex_vector_scale(v : MathoptconvexVector, s : Double) -> MathoptconvexVector {
  let mut result = []
  for i in 0..<v.dim { result = math_opt_convex_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn math_opt_convex_vector_dot(a : MathoptconvexVector, b : MathoptconvexVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn math_opt_convex_vector_norm(v : MathoptconvexVector) -> Double { math_opt_convex_sqrt(math_opt_convex_vector_dot(v, v)) }

pub fn math_opt_convex_vector_normalize(v : MathoptconvexVector) -> MathoptconvexVector {
  let n = math_opt_convex_vector_norm(v)
  if n < 0.0000001 { v } else { math_opt_convex_vector_scale(v, 1.0 / n) }
}

pub fn math_opt_convex_vector_dist(a : MathoptconvexVector, b : MathoptconvexVector) -> Double {
  math_opt_convex_vector_norm(math_opt_convex_vector_sub(a, b))
}

pub fn math_opt_convex_vector_to_string(v : MathoptconvexVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + math_opt_convex_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn math_opt_convex_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn math_opt_convex_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = math_opt_convex_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn math_opt_convex_std(data : Array[Double]) -> Double { math_opt_convex_sqrt(math_opt_convex_var(data)) }

pub fn math_opt_convex_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = math_opt_convex_mean(a); let mb = math_opt_convex_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn math_opt_convex_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = math_opt_convex_std(a); let sb = math_opt_convex_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { math_opt_convex_cov(a, b) / (sa * sb) }
}

pub fn math_opt_convex_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = math_opt_convex_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn math_opt_convex_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn math_opt_convex_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn math_opt_convex_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  math_opt_convex_sqrt(math_opt_convex_mse(pred, labels))
}

pub fn math_opt_convex_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + math_opt_convex_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn math_opt_convex_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = math_opt_convex_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn math_opt_convex_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn math_opt_convex_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn math_opt_convex_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = math_opt_convex_precision(pred, labels, pos); let r = math_opt_convex_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn math_opt_convex_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn math_opt_convex_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = math_opt_convex_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn math_opt_convex_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn math_opt_convex_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn math_opt_convex_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = math_opt_convex_gcd(a, b)
    (a / g) * b
  }
}

pub fn math_opt_convex_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn math_opt_convex_fibonacci(n : Int) -> Int {
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

pub fn math_opt_convex_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = math_opt_convex_min(data); let mx = math_opt_convex_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn math_opt_convex_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = math_opt_convex_mean(data); let sd = math_opt_convex_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn math_opt_convex_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn math_opt_convex_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn math_opt_convex_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn math_opt_convex_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn math_opt_convex_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn math_opt_convex_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn math_opt_convex_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn math_opt_convex_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn math_opt_convex_dbl(x : Double) -> String {
  let i = if x >= 0.0 { math_opt_convex_int(x) } else { -math_opt_convex_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { math_opt_convex_int(f * 1000000.0) } else { math_opt_convex_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn math_opt_convex_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn math_opt_convex_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct MathoptconvexFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_opt_convex_frame_make(size : Int) -> MathoptconvexFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_opt_convex_frame_len(s : MathoptconvexFrame) -> Int { s.size }

pub fn math_opt_convex_frame_get(s : MathoptconvexFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_opt_convex_frame_set(s : MathoptconvexFrame, i : Int, v : Double) -> MathoptconvexFrame {
  let result = math_opt_convex_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_opt_convex_frame_sum(s : MathoptconvexFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_opt_convex_frame_mean(s : MathoptconvexFrame) -> Double {
  if s.size == 0 { 0.0 } else { math_opt_convex_frame_sum(s) / s.size.to_double() }
}

pub fn math_opt_convex_frame_scale(s : MathoptconvexFrame, f : Double) -> MathoptconvexFrame {
  let result = math_opt_convex_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_opt_convex_frame_add(a : MathoptconvexFrame, b : MathoptconvexFrame) -> MathoptconvexFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_opt_convex_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_opt_convex_frame_copy(s : MathoptconvexFrame) -> MathoptconvexFrame {
  let result = math_opt_convex_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_opt_convex_frame_fill(s : MathoptconvexFrame, v : Double) -> MathoptconvexFrame {
  let result = math_opt_convex_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_opt_convex_frame_min(s : MathoptconvexFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_opt_convex_frame_max(s : MathoptconvexFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_opt_convex_frame_to_string(s : MathoptconvexFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathoptconvexTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_opt_convex_table_make(size : Int) -> MathoptconvexTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_opt_convex_table_len(s : MathoptconvexTable) -> Int { s.size }

pub fn math_opt_convex_table_get(s : MathoptconvexTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_opt_convex_table_set(s : MathoptconvexTable, i : Int, v : Double) -> MathoptconvexTable {
  let result = math_opt_convex_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_opt_convex_table_sum(s : MathoptconvexTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_opt_convex_table_mean(s : MathoptconvexTable) -> Double {
  if s.size == 0 { 0.0 } else { math_opt_convex_table_sum(s) / s.size.to_double() }
}

pub fn math_opt_convex_table_scale(s : MathoptconvexTable, f : Double) -> MathoptconvexTable {
  let result = math_opt_convex_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_opt_convex_table_add(a : MathoptconvexTable, b : MathoptconvexTable) -> MathoptconvexTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_opt_convex_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_opt_convex_table_copy(s : MathoptconvexTable) -> MathoptconvexTable {
  let result = math_opt_convex_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_opt_convex_table_fill(s : MathoptconvexTable, v : Double) -> MathoptconvexTable {
  let result = math_opt_convex_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_opt_convex_table_min(s : MathoptconvexTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_opt_convex_table_max(s : MathoptconvexTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_opt_convex_table_to_string(s : MathoptconvexTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathoptconvexGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_opt_convex_graphn_make(size : Int) -> MathoptconvexGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_opt_convex_graphn_len(s : MathoptconvexGraphN) -> Int { s.size }

pub fn math_opt_convex_graphn_get(s : MathoptconvexGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_opt_convex_graphn_set(s : MathoptconvexGraphN, i : Int, v : Double) -> MathoptconvexGraphN {
  let result = math_opt_convex_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_opt_convex_graphn_sum(s : MathoptconvexGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_opt_convex_graphn_mean(s : MathoptconvexGraphN) -> Double {
  if s.size == 0 { 0.0 } else { math_opt_convex_graphn_sum(s) / s.size.to_double() }
}

pub fn math_opt_convex_graphn_scale(s : MathoptconvexGraphN, f : Double) -> MathoptconvexGraphN {
  let result = math_opt_convex_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_opt_convex_graphn_add(a : MathoptconvexGraphN, b : MathoptconvexGraphN) -> MathoptconvexGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_opt_convex_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_opt_convex_graphn_copy(s : MathoptconvexGraphN) -> MathoptconvexGraphN {
  let result = math_opt_convex_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_opt_convex_graphn_fill(s : MathoptconvexGraphN, v : Double) -> MathoptconvexGraphN {
  let result = math_opt_convex_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_opt_convex_graphn_min(s : MathoptconvexGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_opt_convex_graphn_max(s : MathoptconvexGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_opt_convex_graphn_to_string(s : MathoptconvexGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathoptconvexNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_opt_convex_node_make(size : Int) -> MathoptconvexNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_opt_convex_node_len(s : MathoptconvexNode) -> Int { s.size }

pub fn math_opt_convex_node_get(s : MathoptconvexNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_opt_convex_node_set(s : MathoptconvexNode, i : Int, v : Double) -> MathoptconvexNode {
  let result = math_opt_convex_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_opt_convex_node_sum(s : MathoptconvexNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_opt_convex_node_mean(s : MathoptconvexNode) -> Double {
  if s.size == 0 { 0.0 } else { math_opt_convex_node_sum(s) / s.size.to_double() }
}

pub fn math_opt_convex_node_scale(s : MathoptconvexNode, f : Double) -> MathoptconvexNode {
  let result = math_opt_convex_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_opt_convex_node_add(a : MathoptconvexNode, b : MathoptconvexNode) -> MathoptconvexNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_opt_convex_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_opt_convex_node_copy(s : MathoptconvexNode) -> MathoptconvexNode {
  let result = math_opt_convex_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_opt_convex_node_fill(s : MathoptconvexNode, v : Double) -> MathoptconvexNode {
  let result = math_opt_convex_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_opt_convex_node_min(s : MathoptconvexNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_opt_convex_node_max(s : MathoptconvexNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_opt_convex_node_to_string(s : MathoptconvexNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathoptconvexEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_opt_convex_edge_make(size : Int) -> MathoptconvexEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_opt_convex_edge_len(s : MathoptconvexEdge) -> Int { s.size }

pub fn math_opt_convex_edge_get(s : MathoptconvexEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_opt_convex_edge_set(s : MathoptconvexEdge, i : Int, v : Double) -> MathoptconvexEdge {
  let result = math_opt_convex_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_opt_convex_edge_sum(s : MathoptconvexEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_opt_convex_edge_mean(s : MathoptconvexEdge) -> Double {
  if s.size == 0 { 0.0 } else { math_opt_convex_edge_sum(s) / s.size.to_double() }
}

pub fn math_opt_convex_edge_scale(s : MathoptconvexEdge, f : Double) -> MathoptconvexEdge {
  let result = math_opt_convex_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_opt_convex_edge_add(a : MathoptconvexEdge, b : MathoptconvexEdge) -> MathoptconvexEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_opt_convex_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_opt_convex_edge_copy(s : MathoptconvexEdge) -> MathoptconvexEdge {
  let result = math_opt_convex_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_opt_convex_edge_fill(s : MathoptconvexEdge, v : Double) -> MathoptconvexEdge {
  let result = math_opt_convex_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_opt_convex_edge_min(s : MathoptconvexEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_opt_convex_edge_max(s : MathoptconvexEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_opt_convex_edge_to_string(s : MathoptconvexEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathoptconvexPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_opt_convex_path_make(size : Int) -> MathoptconvexPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_opt_convex_path_len(s : MathoptconvexPath) -> Int { s.size }

pub fn math_opt_convex_path_get(s : MathoptconvexPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_opt_convex_path_set(s : MathoptconvexPath, i : Int, v : Double) -> MathoptconvexPath {
  let result = math_opt_convex_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_opt_convex_path_sum(s : MathoptconvexPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_opt_convex_path_mean(s : MathoptconvexPath) -> Double {
  if s.size == 0 { 0.0 } else { math_opt_convex_path_sum(s) / s.size.to_double() }
}

pub fn math_opt_convex_path_scale(s : MathoptconvexPath, f : Double) -> MathoptconvexPath {
  let result = math_opt_convex_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_opt_convex_path_add(a : MathoptconvexPath, b : MathoptconvexPath) -> MathoptconvexPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_opt_convex_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_opt_convex_path_copy(s : MathoptconvexPath) -> MathoptconvexPath {
  let result = math_opt_convex_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_opt_convex_path_fill(s : MathoptconvexPath, v : Double) -> MathoptconvexPath {
  let result = math_opt_convex_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_opt_convex_path_min(s : MathoptconvexPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_opt_convex_path_max(s : MathoptconvexPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_opt_convex_path_to_string(s : MathoptconvexPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathoptconvexCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_opt_convex_cluster_make(size : Int) -> MathoptconvexCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_opt_convex_cluster_len(s : MathoptconvexCluster) -> Int { s.size }

pub fn math_opt_convex_cluster_get(s : MathoptconvexCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_opt_convex_cluster_set(s : MathoptconvexCluster, i : Int, v : Double) -> MathoptconvexCluster {
  let result = math_opt_convex_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_opt_convex_cluster_sum(s : MathoptconvexCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_opt_convex_cluster_mean(s : MathoptconvexCluster) -> Double {
  if s.size == 0 { 0.0 } else { math_opt_convex_cluster_sum(s) / s.size.to_double() }
}

pub fn math_opt_convex_cluster_scale(s : MathoptconvexCluster, f : Double) -> MathoptconvexCluster {
  let result = math_opt_convex_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_opt_convex_cluster_add(a : MathoptconvexCluster, b : MathoptconvexCluster) -> MathoptconvexCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_opt_convex_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_opt_convex_cluster_copy(s : MathoptconvexCluster) -> MathoptconvexCluster {
  let result = math_opt_convex_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_opt_convex_cluster_fill(s : MathoptconvexCluster, v : Double) -> MathoptconvexCluster {
  let result = math_opt_convex_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_opt_convex_cluster_min(s : MathoptconvexCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_opt_convex_cluster_max(s : MathoptconvexCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_opt_convex_cluster_to_string(s : MathoptconvexCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathoptconvexModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_opt_convex_model_make(size : Int) -> MathoptconvexModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_opt_convex_model_len(s : MathoptconvexModel) -> Int { s.size }

pub fn math_opt_convex_model_get(s : MathoptconvexModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_opt_convex_model_set(s : MathoptconvexModel, i : Int, v : Double) -> MathoptconvexModel {
  let result = math_opt_convex_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_opt_convex_model_sum(s : MathoptconvexModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_opt_convex_model_mean(s : MathoptconvexModel) -> Double {
  if s.size == 0 { 0.0 } else { math_opt_convex_model_sum(s) / s.size.to_double() }
}

pub fn math_opt_convex_model_scale(s : MathoptconvexModel, f : Double) -> MathoptconvexModel {
  let result = math_opt_convex_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_opt_convex_model_add(a : MathoptconvexModel, b : MathoptconvexModel) -> MathoptconvexModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_opt_convex_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_opt_convex_model_copy(s : MathoptconvexModel) -> MathoptconvexModel {
  let result = math_opt_convex_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_opt_convex_model_fill(s : MathoptconvexModel, v : Double) -> MathoptconvexModel {
  let result = math_opt_convex_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_opt_convex_model_min(s : MathoptconvexModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_opt_convex_model_max(s : MathoptconvexModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_opt_convex_model_to_string(s : MathoptconvexModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathoptconvexLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_opt_convex_layer_make(size : Int) -> MathoptconvexLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_opt_convex_layer_len(s : MathoptconvexLayer) -> Int { s.size }

pub fn math_opt_convex_layer_get(s : MathoptconvexLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_opt_convex_layer_set(s : MathoptconvexLayer, i : Int, v : Double) -> MathoptconvexLayer {
  let result = math_opt_convex_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_opt_convex_layer_sum(s : MathoptconvexLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_opt_convex_layer_mean(s : MathoptconvexLayer) -> Double {
  if s.size == 0 { 0.0 } else { math_opt_convex_layer_sum(s) / s.size.to_double() }
}

pub fn math_opt_convex_layer_scale(s : MathoptconvexLayer, f : Double) -> MathoptconvexLayer {
  let result = math_opt_convex_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_opt_convex_layer_add(a : MathoptconvexLayer, b : MathoptconvexLayer) -> MathoptconvexLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_opt_convex_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_opt_convex_layer_copy(s : MathoptconvexLayer) -> MathoptconvexLayer {
  let result = math_opt_convex_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_opt_convex_layer_fill(s : MathoptconvexLayer, v : Double) -> MathoptconvexLayer {
  let result = math_opt_convex_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_opt_convex_layer_min(s : MathoptconvexLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_opt_convex_layer_max(s : MathoptconvexLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_opt_convex_layer_to_string(s : MathoptconvexLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathoptconvexBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_opt_convex_buffer_make(size : Int) -> MathoptconvexBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_opt_convex_buffer_len(s : MathoptconvexBuffer) -> Int { s.size }

pub fn math_opt_convex_buffer_get(s : MathoptconvexBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_opt_convex_buffer_set(s : MathoptconvexBuffer, i : Int, v : Double) -> MathoptconvexBuffer {
  let result = math_opt_convex_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_opt_convex_buffer_sum(s : MathoptconvexBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_opt_convex_buffer_mean(s : MathoptconvexBuffer) -> Double {
  if s.size == 0 { 0.0 } else { math_opt_convex_buffer_sum(s) / s.size.to_double() }
}

pub fn math_opt_convex_buffer_scale(s : MathoptconvexBuffer, f : Double) -> MathoptconvexBuffer {
  let result = math_opt_convex_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_opt_convex_buffer_add(a : MathoptconvexBuffer, b : MathoptconvexBuffer) -> MathoptconvexBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_opt_convex_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_opt_convex_buffer_copy(s : MathoptconvexBuffer) -> MathoptconvexBuffer {
  let result = math_opt_convex_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_opt_convex_buffer_fill(s : MathoptconvexBuffer, v : Double) -> MathoptconvexBuffer {
  let result = math_opt_convex_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_opt_convex_buffer_min(s : MathoptconvexBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_opt_convex_buffer_max(s : MathoptconvexBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_opt_convex_buffer_to_string(s : MathoptconvexBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathoptconvexCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_opt_convex_cursor_make(size : Int) -> MathoptconvexCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_opt_convex_cursor_len(s : MathoptconvexCursor) -> Int { s.size }

pub fn math_opt_convex_cursor_get(s : MathoptconvexCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_opt_convex_cursor_set(s : MathoptconvexCursor, i : Int, v : Double) -> MathoptconvexCursor {
  let result = math_opt_convex_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_opt_convex_cursor_sum(s : MathoptconvexCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_opt_convex_cursor_mean(s : MathoptconvexCursor) -> Double {
  if s.size == 0 { 0.0 } else { math_opt_convex_cursor_sum(s) / s.size.to_double() }
}

pub fn math_opt_convex_cursor_scale(s : MathoptconvexCursor, f : Double) -> MathoptconvexCursor {
  let result = math_opt_convex_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_opt_convex_cursor_add(a : MathoptconvexCursor, b : MathoptconvexCursor) -> MathoptconvexCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_opt_convex_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_opt_convex_cursor_copy(s : MathoptconvexCursor) -> MathoptconvexCursor {
  let result = math_opt_convex_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_opt_convex_cursor_fill(s : MathoptconvexCursor, v : Double) -> MathoptconvexCursor {
  let result = math_opt_convex_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_opt_convex_cursor_min(s : MathoptconvexCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_opt_convex_cursor_max(s : MathoptconvexCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_opt_convex_cursor_to_string(s : MathoptconvexCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathoptconvexView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_opt_convex_view_make(size : Int) -> MathoptconvexView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_opt_convex_view_len(s : MathoptconvexView) -> Int { s.size }

pub fn math_opt_convex_view_get(s : MathoptconvexView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_opt_convex_view_set(s : MathoptconvexView, i : Int, v : Double) -> MathoptconvexView {
  let result = math_opt_convex_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_opt_convex_view_sum(s : MathoptconvexView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_opt_convex_view_mean(s : MathoptconvexView) -> Double {
  if s.size == 0 { 0.0 } else { math_opt_convex_view_sum(s) / s.size.to_double() }
}

pub fn math_opt_convex_view_scale(s : MathoptconvexView, f : Double) -> MathoptconvexView {
  let result = math_opt_convex_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_opt_convex_view_add(a : MathoptconvexView, b : MathoptconvexView) -> MathoptconvexView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_opt_convex_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_opt_convex_view_copy(s : MathoptconvexView) -> MathoptconvexView {
  let result = math_opt_convex_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_opt_convex_view_fill(s : MathoptconvexView, v : Double) -> MathoptconvexView {
  let result = math_opt_convex_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_opt_convex_view_min(s : MathoptconvexView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_opt_convex_view_max(s : MathoptconvexView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_opt_convex_view_to_string(s : MathoptconvexView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathoptconvexRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_opt_convex_range_make(size : Int) -> MathoptconvexRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_opt_convex_range_len(s : MathoptconvexRange) -> Int { s.size }

pub fn math_opt_convex_range_get(s : MathoptconvexRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_opt_convex_range_set(s : MathoptconvexRange, i : Int, v : Double) -> MathoptconvexRange {
  let result = math_opt_convex_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_opt_convex_range_sum(s : MathoptconvexRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_opt_convex_range_mean(s : MathoptconvexRange) -> Double {
  if s.size == 0 { 0.0 } else { math_opt_convex_range_sum(s) / s.size.to_double() }
}

pub fn math_opt_convex_range_scale(s : MathoptconvexRange, f : Double) -> MathoptconvexRange {
  let result = math_opt_convex_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_opt_convex_range_add(a : MathoptconvexRange, b : MathoptconvexRange) -> MathoptconvexRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_opt_convex_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_opt_convex_range_copy(s : MathoptconvexRange) -> MathoptconvexRange {
  let result = math_opt_convex_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_opt_convex_range_fill(s : MathoptconvexRange, v : Double) -> MathoptconvexRange {
  let result = math_opt_convex_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_opt_convex_range_min(s : MathoptconvexRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_opt_convex_range_max(s : MathoptconvexRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_opt_convex_range_to_string(s : MathoptconvexRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathoptconvexSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_opt_convex_slice_make(size : Int) -> MathoptconvexSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_opt_convex_slice_len(s : MathoptconvexSlice) -> Int { s.size }

pub fn math_opt_convex_slice_get(s : MathoptconvexSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_opt_convex_slice_set(s : MathoptconvexSlice, i : Int, v : Double) -> MathoptconvexSlice {
  let result = math_opt_convex_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_opt_convex_slice_sum(s : MathoptconvexSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_opt_convex_slice_mean(s : MathoptconvexSlice) -> Double {
  if s.size == 0 { 0.0 } else { math_opt_convex_slice_sum(s) / s.size.to_double() }
}

pub fn math_opt_convex_slice_scale(s : MathoptconvexSlice, f : Double) -> MathoptconvexSlice {
  let result = math_opt_convex_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_opt_convex_slice_add(a : MathoptconvexSlice, b : MathoptconvexSlice) -> MathoptconvexSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_opt_convex_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_opt_convex_slice_copy(s : MathoptconvexSlice) -> MathoptconvexSlice {
  let result = math_opt_convex_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_opt_convex_slice_fill(s : MathoptconvexSlice, v : Double) -> MathoptconvexSlice {
  let result = math_opt_convex_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_opt_convex_slice_min(s : MathoptconvexSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_opt_convex_slice_max(s : MathoptconvexSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_opt_convex_slice_to_string(s : MathoptconvexSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn math_opt_convex_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_opt_convex_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_opt_convex_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_opt_convex_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_opt_convex_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_opt_convex_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_opt_convex_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_opt_convex_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_opt_convex_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_opt_convex_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_opt_convex_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_opt_convex_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_opt_convex_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_opt_convex_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_opt_convex_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_opt_convex_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_opt_convex_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_opt_convex_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_opt_convex_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_opt_convex_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_opt_convex_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_opt_convex_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_opt_convex_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_opt_convex_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_opt_convex_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

