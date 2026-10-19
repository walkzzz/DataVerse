///===
/// extcore/nlp_parse_dependency

pub(all) struct NlpparsedependencyPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn nlp_parse_dependency_make_point(x : Double, y : Double) -> NlpparsedependencyPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn nlp_parse_dependency_make_point3(x : Double, y : Double, z : Double) -> NlpparsedependencyPoint {
  { x, y, z, label: 0 }
}

pub fn nlp_parse_dependency_point_x(pt : NlpparsedependencyPoint) -> Double { pt.x }

pub fn nlp_parse_dependency_point_y(pt : NlpparsedependencyPoint) -> Double { pt.y }

pub fn nlp_parse_dependency_point_z(pt : NlpparsedependencyPoint) -> Double { pt.z }

pub fn nlp_parse_dependency_point_label(pt : NlpparsedependencyPoint) -> Int { pt.label }

pub fn nlp_parse_dependency_point_dist(a : NlpparsedependencyPoint, b : NlpparsedependencyPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  nlp_parse_dependency_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn nlp_parse_dependency_point_add(a : NlpparsedependencyPoint, b : NlpparsedependencyPoint) -> NlpparsedependencyPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn nlp_parse_dependency_point_sub(a : NlpparsedependencyPoint, b : NlpparsedependencyPoint) -> NlpparsedependencyPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn nlp_parse_dependency_point_scale(pt : NlpparsedependencyPoint, s : Double) -> NlpparsedependencyPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn nlp_parse_dependency_point_dot(a : NlpparsedependencyPoint, b : NlpparsedependencyPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn nlp_parse_dependency_point_cross(a : NlpparsedependencyPoint, b : NlpparsedependencyPoint) -> NlpparsedependencyPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn nlp_parse_dependency_point_norm(pt : NlpparsedependencyPoint) -> Double {
  nlp_parse_dependency_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn nlp_parse_dependency_point_normalize(pt : NlpparsedependencyPoint) -> NlpparsedependencyPoint {
  let n = nlp_parse_dependency_point_norm(pt)
  if n < 0.0000001 { pt } else { nlp_parse_dependency_point_scale(pt, 1.0 / n) }
}

pub fn nlp_parse_dependency_point_negate(pt : NlpparsedependencyPoint) -> NlpparsedependencyPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn nlp_parse_dependency_point_mid(a : NlpparsedependencyPoint, b : NlpparsedependencyPoint) -> NlpparsedependencyPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn nlp_parse_dependency_point_lerp(a : NlpparsedependencyPoint, b : NlpparsedependencyPoint, t : Double) -> NlpparsedependencyPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn nlp_parse_dependency_point_to_string(pt : NlpparsedependencyPoint) -> String {
  "(" + nlp_parse_dependency_dbl(pt.x) + ", " + nlp_parse_dependency_dbl(pt.y) + ", " + nlp_parse_dependency_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct NlpparsedependencySeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn nlp_parse_dependency_make_series(vals : Array[Double], name : String) -> NlpparsedependencySeries {
  { vals, name, meta: 0 }
}

pub fn nlp_parse_dependency_series_len(s : NlpparsedependencySeries) -> Int { s.vals.length() }

pub fn nlp_parse_dependency_series_sum(s : NlpparsedependencySeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn nlp_parse_dependency_series_mean(s : NlpparsedependencySeries) -> Double {
  let n = nlp_parse_dependency_series_len(s)
  if n == 0 { 0.0 } else { nlp_parse_dependency_series_sum(s) / n.to_double() }
}

pub fn nlp_parse_dependency_series_min(s : NlpparsedependencySeries) -> Double {
  let n = nlp_parse_dependency_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn nlp_parse_dependency_series_max(s : NlpparsedependencySeries) -> Double {
  let n = nlp_parse_dependency_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn nlp_parse_dependency_series_range(s : NlpparsedependencySeries) -> Double {
  nlp_parse_dependency_series_max(s) - nlp_parse_dependency_series_min(s)
}

pub fn nlp_parse_dependency_series_var(s : NlpparsedependencySeries) -> Double {
  let n = nlp_parse_dependency_series_len(s)
  if n == 0 { 0.0 } else {
    let m = nlp_parse_dependency_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn nlp_parse_dependency_series_std(s : NlpparsedependencySeries) -> Double { nlp_parse_dependency_sqrt(nlp_parse_dependency_series_var(s)) }

pub fn nlp_parse_dependency_series_median(s : NlpparsedependencySeries) -> Double {
  let n = nlp_parse_dependency_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = nlp_parse_dependency_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn nlp_parse_dependency_series_scale(s : NlpparsedependencySeries, f : Double) -> NlpparsedependencySeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = nlp_parse_dependency_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn nlp_parse_dependency_series_add(a : NlpparsedependencySeries, b : NlpparsedependencySeries) -> NlpparsedependencySeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = nlp_parse_dependency_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn nlp_parse_dependency_series_sub(a : NlpparsedependencySeries, b : NlpparsedependencySeries) -> NlpparsedependencySeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = nlp_parse_dependency_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn nlp_parse_dependency_series_normalize(s : NlpparsedependencySeries) -> NlpparsedependencySeries {
  let mn = nlp_parse_dependency_series_min(s)
  let mx = nlp_parse_dependency_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = nlp_parse_dependency_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn nlp_parse_dependency_series_cumsum(s : NlpparsedependencySeries) -> NlpparsedependencySeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = nlp_parse_dependency_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn nlp_parse_dependency_series_to_string(s : NlpparsedependencySeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + nlp_parse_dependency_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NlpparsedependencyMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn nlp_parse_dependency_make_matrix(rows : Int, cols : Int, val : Double) -> NlpparsedependencyMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn nlp_parse_dependency_matrix_identity(n : Int) -> NlpparsedependencyMatrix {
  let m = nlp_parse_dependency_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn nlp_parse_dependency_matrix_get(m : NlpparsedependencyMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn nlp_parse_dependency_matrix_transpose(m : NlpparsedependencyMatrix) -> NlpparsedependencyMatrix {
  let result = nlp_parse_dependency_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn nlp_parse_dependency_matrix_add(a : NlpparsedependencyMatrix, b : NlpparsedependencyMatrix) -> NlpparsedependencyMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = nlp_parse_dependency_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn nlp_parse_dependency_matrix_scale(m : NlpparsedependencyMatrix, s : Double) -> NlpparsedependencyMatrix {
  let result = nlp_parse_dependency_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn nlp_parse_dependency_matrix_multiply(a : NlpparsedependencyMatrix, b : NlpparsedependencyMatrix) -> NlpparsedependencyMatrix {
  if a.cols != b.rows { return nlp_parse_dependency_make_matrix(a.rows, b.cols, 0.0) }
  let result = nlp_parse_dependency_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn nlp_parse_dependency_matrix_trace(m : NlpparsedependencyMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn nlp_parse_dependency_matrix_det(m : NlpparsedependencyMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn nlp_parse_dependency_matrix_norm(m : NlpparsedependencyMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  nlp_parse_dependency_sqrt(sum)
}

pub fn nlp_parse_dependency_matrix_to_string(m : NlpparsedependencyMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + nlp_parse_dependency_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct NlpparsedependencyVector {
  comps : Array[Double]
  dim : Int
}

pub fn nlp_parse_dependency_make_vector(comps : Array[Double]) -> NlpparsedependencyVector {
  { comps, dim: comps.length() }
}

pub fn nlp_parse_dependency_vector_zero(dim : Int) -> NlpparsedependencyVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn nlp_parse_dependency_vector_add(a : NlpparsedependencyVector, b : NlpparsedependencyVector) -> NlpparsedependencyVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = nlp_parse_dependency_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn nlp_parse_dependency_vector_sub(a : NlpparsedependencyVector, b : NlpparsedependencyVector) -> NlpparsedependencyVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = nlp_parse_dependency_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn nlp_parse_dependency_vector_scale(v : NlpparsedependencyVector, s : Double) -> NlpparsedependencyVector {
  let mut result = []
  for i in 0..<v.dim { result = nlp_parse_dependency_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn nlp_parse_dependency_vector_dot(a : NlpparsedependencyVector, b : NlpparsedependencyVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn nlp_parse_dependency_vector_norm(v : NlpparsedependencyVector) -> Double { nlp_parse_dependency_sqrt(nlp_parse_dependency_vector_dot(v, v)) }

pub fn nlp_parse_dependency_vector_normalize(v : NlpparsedependencyVector) -> NlpparsedependencyVector {
  let n = nlp_parse_dependency_vector_norm(v)
  if n < 0.0000001 { v } else { nlp_parse_dependency_vector_scale(v, 1.0 / n) }
}

pub fn nlp_parse_dependency_vector_dist(a : NlpparsedependencyVector, b : NlpparsedependencyVector) -> Double {
  nlp_parse_dependency_vector_norm(nlp_parse_dependency_vector_sub(a, b))
}

pub fn nlp_parse_dependency_vector_to_string(v : NlpparsedependencyVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + nlp_parse_dependency_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn nlp_parse_dependency_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn nlp_parse_dependency_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = nlp_parse_dependency_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn nlp_parse_dependency_std(data : Array[Double]) -> Double { nlp_parse_dependency_sqrt(nlp_parse_dependency_var(data)) }

pub fn nlp_parse_dependency_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = nlp_parse_dependency_mean(a); let mb = nlp_parse_dependency_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn nlp_parse_dependency_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = nlp_parse_dependency_std(a); let sb = nlp_parse_dependency_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { nlp_parse_dependency_cov(a, b) / (sa * sb) }
}

pub fn nlp_parse_dependency_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = nlp_parse_dependency_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn nlp_parse_dependency_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn nlp_parse_dependency_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn nlp_parse_dependency_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  nlp_parse_dependency_sqrt(nlp_parse_dependency_mse(pred, labels))
}

pub fn nlp_parse_dependency_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + nlp_parse_dependency_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn nlp_parse_dependency_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = nlp_parse_dependency_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn nlp_parse_dependency_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn nlp_parse_dependency_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn nlp_parse_dependency_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = nlp_parse_dependency_precision(pred, labels, pos); let r = nlp_parse_dependency_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn nlp_parse_dependency_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn nlp_parse_dependency_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = nlp_parse_dependency_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn nlp_parse_dependency_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn nlp_parse_dependency_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn nlp_parse_dependency_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = nlp_parse_dependency_gcd(a, b)
    (a / g) * b
  }
}

pub fn nlp_parse_dependency_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn nlp_parse_dependency_fibonacci(n : Int) -> Int {
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

pub fn nlp_parse_dependency_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = nlp_parse_dependency_min(data); let mx = nlp_parse_dependency_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn nlp_parse_dependency_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = nlp_parse_dependency_mean(data); let sd = nlp_parse_dependency_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn nlp_parse_dependency_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn nlp_parse_dependency_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn nlp_parse_dependency_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn nlp_parse_dependency_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn nlp_parse_dependency_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn nlp_parse_dependency_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn nlp_parse_dependency_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn nlp_parse_dependency_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn nlp_parse_dependency_dbl(x : Double) -> String {
  let i = if x >= 0.0 { nlp_parse_dependency_int(x) } else { -nlp_parse_dependency_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { nlp_parse_dependency_int(f * 1000000.0) } else { nlp_parse_dependency_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn nlp_parse_dependency_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn nlp_parse_dependency_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct NlpparsedependencyFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_dependency_frame_make(size : Int) -> NlpparsedependencyFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_dependency_frame_len(s : NlpparsedependencyFrame) -> Int { s.size }

pub fn nlp_parse_dependency_frame_get(s : NlpparsedependencyFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_dependency_frame_set(s : NlpparsedependencyFrame, i : Int, v : Double) -> NlpparsedependencyFrame {
  let result = nlp_parse_dependency_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_dependency_frame_sum(s : NlpparsedependencyFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_parse_dependency_frame_mean(s : NlpparsedependencyFrame) -> Double {
  if s.size == 0 { 0.0 } else { nlp_parse_dependency_frame_sum(s) / s.size.to_double() }
}

pub fn nlp_parse_dependency_frame_scale(s : NlpparsedependencyFrame, f : Double) -> NlpparsedependencyFrame {
  let result = nlp_parse_dependency_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_parse_dependency_frame_add(a : NlpparsedependencyFrame, b : NlpparsedependencyFrame) -> NlpparsedependencyFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_parse_dependency_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_parse_dependency_frame_copy(s : NlpparsedependencyFrame) -> NlpparsedependencyFrame {
  let result = nlp_parse_dependency_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_parse_dependency_frame_fill(s : NlpparsedependencyFrame, v : Double) -> NlpparsedependencyFrame {
  let result = nlp_parse_dependency_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_dependency_frame_min(s : NlpparsedependencyFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_dependency_frame_max(s : NlpparsedependencyFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_dependency_frame_to_string(s : NlpparsedependencyFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparsedependencyTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_dependency_table_make(size : Int) -> NlpparsedependencyTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_dependency_table_len(s : NlpparsedependencyTable) -> Int { s.size }

pub fn nlp_parse_dependency_table_get(s : NlpparsedependencyTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_dependency_table_set(s : NlpparsedependencyTable, i : Int, v : Double) -> NlpparsedependencyTable {
  let result = nlp_parse_dependency_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_dependency_table_sum(s : NlpparsedependencyTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_parse_dependency_table_mean(s : NlpparsedependencyTable) -> Double {
  if s.size == 0 { 0.0 } else { nlp_parse_dependency_table_sum(s) / s.size.to_double() }
}

pub fn nlp_parse_dependency_table_scale(s : NlpparsedependencyTable, f : Double) -> NlpparsedependencyTable {
  let result = nlp_parse_dependency_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_parse_dependency_table_add(a : NlpparsedependencyTable, b : NlpparsedependencyTable) -> NlpparsedependencyTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_parse_dependency_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_parse_dependency_table_copy(s : NlpparsedependencyTable) -> NlpparsedependencyTable {
  let result = nlp_parse_dependency_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_parse_dependency_table_fill(s : NlpparsedependencyTable, v : Double) -> NlpparsedependencyTable {
  let result = nlp_parse_dependency_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_dependency_table_min(s : NlpparsedependencyTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_dependency_table_max(s : NlpparsedependencyTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_dependency_table_to_string(s : NlpparsedependencyTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparsedependencyGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_dependency_graphn_make(size : Int) -> NlpparsedependencyGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_dependency_graphn_len(s : NlpparsedependencyGraphN) -> Int { s.size }

pub fn nlp_parse_dependency_graphn_get(s : NlpparsedependencyGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_dependency_graphn_set(s : NlpparsedependencyGraphN, i : Int, v : Double) -> NlpparsedependencyGraphN {
  let result = nlp_parse_dependency_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_dependency_graphn_sum(s : NlpparsedependencyGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_parse_dependency_graphn_mean(s : NlpparsedependencyGraphN) -> Double {
  if s.size == 0 { 0.0 } else { nlp_parse_dependency_graphn_sum(s) / s.size.to_double() }
}

pub fn nlp_parse_dependency_graphn_scale(s : NlpparsedependencyGraphN, f : Double) -> NlpparsedependencyGraphN {
  let result = nlp_parse_dependency_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_parse_dependency_graphn_add(a : NlpparsedependencyGraphN, b : NlpparsedependencyGraphN) -> NlpparsedependencyGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_parse_dependency_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_parse_dependency_graphn_copy(s : NlpparsedependencyGraphN) -> NlpparsedependencyGraphN {
  let result = nlp_parse_dependency_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_parse_dependency_graphn_fill(s : NlpparsedependencyGraphN, v : Double) -> NlpparsedependencyGraphN {
  let result = nlp_parse_dependency_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_dependency_graphn_min(s : NlpparsedependencyGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_dependency_graphn_max(s : NlpparsedependencyGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_dependency_graphn_to_string(s : NlpparsedependencyGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparsedependencyNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_dependency_node_make(size : Int) -> NlpparsedependencyNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_dependency_node_len(s : NlpparsedependencyNode) -> Int { s.size }

pub fn nlp_parse_dependency_node_get(s : NlpparsedependencyNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_dependency_node_set(s : NlpparsedependencyNode, i : Int, v : Double) -> NlpparsedependencyNode {
  let result = nlp_parse_dependency_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_dependency_node_sum(s : NlpparsedependencyNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_parse_dependency_node_mean(s : NlpparsedependencyNode) -> Double {
  if s.size == 0 { 0.0 } else { nlp_parse_dependency_node_sum(s) / s.size.to_double() }
}

pub fn nlp_parse_dependency_node_scale(s : NlpparsedependencyNode, f : Double) -> NlpparsedependencyNode {
  let result = nlp_parse_dependency_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_parse_dependency_node_add(a : NlpparsedependencyNode, b : NlpparsedependencyNode) -> NlpparsedependencyNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_parse_dependency_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_parse_dependency_node_copy(s : NlpparsedependencyNode) -> NlpparsedependencyNode {
  let result = nlp_parse_dependency_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_parse_dependency_node_fill(s : NlpparsedependencyNode, v : Double) -> NlpparsedependencyNode {
  let result = nlp_parse_dependency_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_dependency_node_min(s : NlpparsedependencyNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_dependency_node_max(s : NlpparsedependencyNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_dependency_node_to_string(s : NlpparsedependencyNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparsedependencyEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_dependency_edge_make(size : Int) -> NlpparsedependencyEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_dependency_edge_len(s : NlpparsedependencyEdge) -> Int { s.size }

pub fn nlp_parse_dependency_edge_get(s : NlpparsedependencyEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_dependency_edge_set(s : NlpparsedependencyEdge, i : Int, v : Double) -> NlpparsedependencyEdge {
  let result = nlp_parse_dependency_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_dependency_edge_sum(s : NlpparsedependencyEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_parse_dependency_edge_mean(s : NlpparsedependencyEdge) -> Double {
  if s.size == 0 { 0.0 } else { nlp_parse_dependency_edge_sum(s) / s.size.to_double() }
}

pub fn nlp_parse_dependency_edge_scale(s : NlpparsedependencyEdge, f : Double) -> NlpparsedependencyEdge {
  let result = nlp_parse_dependency_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_parse_dependency_edge_add(a : NlpparsedependencyEdge, b : NlpparsedependencyEdge) -> NlpparsedependencyEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_parse_dependency_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_parse_dependency_edge_copy(s : NlpparsedependencyEdge) -> NlpparsedependencyEdge {
  let result = nlp_parse_dependency_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_parse_dependency_edge_fill(s : NlpparsedependencyEdge, v : Double) -> NlpparsedependencyEdge {
  let result = nlp_parse_dependency_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_dependency_edge_min(s : NlpparsedependencyEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_dependency_edge_max(s : NlpparsedependencyEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_dependency_edge_to_string(s : NlpparsedependencyEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparsedependencyPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_dependency_path_make(size : Int) -> NlpparsedependencyPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_dependency_path_len(s : NlpparsedependencyPath) -> Int { s.size }

pub fn nlp_parse_dependency_path_get(s : NlpparsedependencyPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_dependency_path_set(s : NlpparsedependencyPath, i : Int, v : Double) -> NlpparsedependencyPath {
  let result = nlp_parse_dependency_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_dependency_path_sum(s : NlpparsedependencyPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_parse_dependency_path_mean(s : NlpparsedependencyPath) -> Double {
  if s.size == 0 { 0.0 } else { nlp_parse_dependency_path_sum(s) / s.size.to_double() }
}

pub fn nlp_parse_dependency_path_scale(s : NlpparsedependencyPath, f : Double) -> NlpparsedependencyPath {
  let result = nlp_parse_dependency_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_parse_dependency_path_add(a : NlpparsedependencyPath, b : NlpparsedependencyPath) -> NlpparsedependencyPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_parse_dependency_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_parse_dependency_path_copy(s : NlpparsedependencyPath) -> NlpparsedependencyPath {
  let result = nlp_parse_dependency_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_parse_dependency_path_fill(s : NlpparsedependencyPath, v : Double) -> NlpparsedependencyPath {
  let result = nlp_parse_dependency_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_dependency_path_min(s : NlpparsedependencyPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_dependency_path_max(s : NlpparsedependencyPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_dependency_path_to_string(s : NlpparsedependencyPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparsedependencyCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_dependency_cluster_make(size : Int) -> NlpparsedependencyCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_dependency_cluster_len(s : NlpparsedependencyCluster) -> Int { s.size }

pub fn nlp_parse_dependency_cluster_get(s : NlpparsedependencyCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_dependency_cluster_set(s : NlpparsedependencyCluster, i : Int, v : Double) -> NlpparsedependencyCluster {
  let result = nlp_parse_dependency_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_dependency_cluster_sum(s : NlpparsedependencyCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_parse_dependency_cluster_mean(s : NlpparsedependencyCluster) -> Double {
  if s.size == 0 { 0.0 } else { nlp_parse_dependency_cluster_sum(s) / s.size.to_double() }
}

pub fn nlp_parse_dependency_cluster_scale(s : NlpparsedependencyCluster, f : Double) -> NlpparsedependencyCluster {
  let result = nlp_parse_dependency_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_parse_dependency_cluster_add(a : NlpparsedependencyCluster, b : NlpparsedependencyCluster) -> NlpparsedependencyCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_parse_dependency_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_parse_dependency_cluster_copy(s : NlpparsedependencyCluster) -> NlpparsedependencyCluster {
  let result = nlp_parse_dependency_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_parse_dependency_cluster_fill(s : NlpparsedependencyCluster, v : Double) -> NlpparsedependencyCluster {
  let result = nlp_parse_dependency_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_dependency_cluster_min(s : NlpparsedependencyCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_dependency_cluster_max(s : NlpparsedependencyCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_dependency_cluster_to_string(s : NlpparsedependencyCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparsedependencyModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_dependency_model_make(size : Int) -> NlpparsedependencyModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_dependency_model_len(s : NlpparsedependencyModel) -> Int { s.size }

pub fn nlp_parse_dependency_model_get(s : NlpparsedependencyModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_dependency_model_set(s : NlpparsedependencyModel, i : Int, v : Double) -> NlpparsedependencyModel {
  let result = nlp_parse_dependency_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_dependency_model_sum(s : NlpparsedependencyModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_parse_dependency_model_mean(s : NlpparsedependencyModel) -> Double {
  if s.size == 0 { 0.0 } else { nlp_parse_dependency_model_sum(s) / s.size.to_double() }
}

pub fn nlp_parse_dependency_model_scale(s : NlpparsedependencyModel, f : Double) -> NlpparsedependencyModel {
  let result = nlp_parse_dependency_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_parse_dependency_model_add(a : NlpparsedependencyModel, b : NlpparsedependencyModel) -> NlpparsedependencyModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_parse_dependency_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_parse_dependency_model_copy(s : NlpparsedependencyModel) -> NlpparsedependencyModel {
  let result = nlp_parse_dependency_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_parse_dependency_model_fill(s : NlpparsedependencyModel, v : Double) -> NlpparsedependencyModel {
  let result = nlp_parse_dependency_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_dependency_model_min(s : NlpparsedependencyModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_dependency_model_max(s : NlpparsedependencyModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_dependency_model_to_string(s : NlpparsedependencyModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparsedependencyLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_dependency_layer_make(size : Int) -> NlpparsedependencyLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_dependency_layer_len(s : NlpparsedependencyLayer) -> Int { s.size }

pub fn nlp_parse_dependency_layer_get(s : NlpparsedependencyLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_dependency_layer_set(s : NlpparsedependencyLayer, i : Int, v : Double) -> NlpparsedependencyLayer {
  let result = nlp_parse_dependency_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_dependency_layer_sum(s : NlpparsedependencyLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_parse_dependency_layer_mean(s : NlpparsedependencyLayer) -> Double {
  if s.size == 0 { 0.0 } else { nlp_parse_dependency_layer_sum(s) / s.size.to_double() }
}

pub fn nlp_parse_dependency_layer_scale(s : NlpparsedependencyLayer, f : Double) -> NlpparsedependencyLayer {
  let result = nlp_parse_dependency_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_parse_dependency_layer_add(a : NlpparsedependencyLayer, b : NlpparsedependencyLayer) -> NlpparsedependencyLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_parse_dependency_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_parse_dependency_layer_copy(s : NlpparsedependencyLayer) -> NlpparsedependencyLayer {
  let result = nlp_parse_dependency_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_parse_dependency_layer_fill(s : NlpparsedependencyLayer, v : Double) -> NlpparsedependencyLayer {
  let result = nlp_parse_dependency_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_dependency_layer_min(s : NlpparsedependencyLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_dependency_layer_max(s : NlpparsedependencyLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_dependency_layer_to_string(s : NlpparsedependencyLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparsedependencyBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_dependency_buffer_make(size : Int) -> NlpparsedependencyBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_dependency_buffer_len(s : NlpparsedependencyBuffer) -> Int { s.size }

pub fn nlp_parse_dependency_buffer_get(s : NlpparsedependencyBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_dependency_buffer_set(s : NlpparsedependencyBuffer, i : Int, v : Double) -> NlpparsedependencyBuffer {
  let result = nlp_parse_dependency_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_dependency_buffer_sum(s : NlpparsedependencyBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_parse_dependency_buffer_mean(s : NlpparsedependencyBuffer) -> Double {
  if s.size == 0 { 0.0 } else { nlp_parse_dependency_buffer_sum(s) / s.size.to_double() }
}

pub fn nlp_parse_dependency_buffer_scale(s : NlpparsedependencyBuffer, f : Double) -> NlpparsedependencyBuffer {
  let result = nlp_parse_dependency_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_parse_dependency_buffer_add(a : NlpparsedependencyBuffer, b : NlpparsedependencyBuffer) -> NlpparsedependencyBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_parse_dependency_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_parse_dependency_buffer_copy(s : NlpparsedependencyBuffer) -> NlpparsedependencyBuffer {
  let result = nlp_parse_dependency_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_parse_dependency_buffer_fill(s : NlpparsedependencyBuffer, v : Double) -> NlpparsedependencyBuffer {
  let result = nlp_parse_dependency_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_dependency_buffer_min(s : NlpparsedependencyBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_dependency_buffer_max(s : NlpparsedependencyBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_dependency_buffer_to_string(s : NlpparsedependencyBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparsedependencyCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_dependency_cursor_make(size : Int) -> NlpparsedependencyCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_dependency_cursor_len(s : NlpparsedependencyCursor) -> Int { s.size }

pub fn nlp_parse_dependency_cursor_get(s : NlpparsedependencyCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_dependency_cursor_set(s : NlpparsedependencyCursor, i : Int, v : Double) -> NlpparsedependencyCursor {
  let result = nlp_parse_dependency_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_dependency_cursor_sum(s : NlpparsedependencyCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_parse_dependency_cursor_mean(s : NlpparsedependencyCursor) -> Double {
  if s.size == 0 { 0.0 } else { nlp_parse_dependency_cursor_sum(s) / s.size.to_double() }
}

pub fn nlp_parse_dependency_cursor_scale(s : NlpparsedependencyCursor, f : Double) -> NlpparsedependencyCursor {
  let result = nlp_parse_dependency_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_parse_dependency_cursor_add(a : NlpparsedependencyCursor, b : NlpparsedependencyCursor) -> NlpparsedependencyCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_parse_dependency_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_parse_dependency_cursor_copy(s : NlpparsedependencyCursor) -> NlpparsedependencyCursor {
  let result = nlp_parse_dependency_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_parse_dependency_cursor_fill(s : NlpparsedependencyCursor, v : Double) -> NlpparsedependencyCursor {
  let result = nlp_parse_dependency_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_dependency_cursor_min(s : NlpparsedependencyCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_dependency_cursor_max(s : NlpparsedependencyCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_dependency_cursor_to_string(s : NlpparsedependencyCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparsedependencyView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_dependency_view_make(size : Int) -> NlpparsedependencyView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_dependency_view_len(s : NlpparsedependencyView) -> Int { s.size }

pub fn nlp_parse_dependency_view_get(s : NlpparsedependencyView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_dependency_view_set(s : NlpparsedependencyView, i : Int, v : Double) -> NlpparsedependencyView {
  let result = nlp_parse_dependency_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_dependency_view_sum(s : NlpparsedependencyView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_parse_dependency_view_mean(s : NlpparsedependencyView) -> Double {
  if s.size == 0 { 0.0 } else { nlp_parse_dependency_view_sum(s) / s.size.to_double() }
}

pub fn nlp_parse_dependency_view_scale(s : NlpparsedependencyView, f : Double) -> NlpparsedependencyView {
  let result = nlp_parse_dependency_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_parse_dependency_view_add(a : NlpparsedependencyView, b : NlpparsedependencyView) -> NlpparsedependencyView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_parse_dependency_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_parse_dependency_view_copy(s : NlpparsedependencyView) -> NlpparsedependencyView {
  let result = nlp_parse_dependency_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_parse_dependency_view_fill(s : NlpparsedependencyView, v : Double) -> NlpparsedependencyView {
  let result = nlp_parse_dependency_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_dependency_view_min(s : NlpparsedependencyView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_dependency_view_max(s : NlpparsedependencyView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_dependency_view_to_string(s : NlpparsedependencyView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparsedependencyRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_dependency_range_make(size : Int) -> NlpparsedependencyRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_dependency_range_len(s : NlpparsedependencyRange) -> Int { s.size }

pub fn nlp_parse_dependency_range_get(s : NlpparsedependencyRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_dependency_range_set(s : NlpparsedependencyRange, i : Int, v : Double) -> NlpparsedependencyRange {
  let result = nlp_parse_dependency_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_dependency_range_sum(s : NlpparsedependencyRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_parse_dependency_range_mean(s : NlpparsedependencyRange) -> Double {
  if s.size == 0 { 0.0 } else { nlp_parse_dependency_range_sum(s) / s.size.to_double() }
}

pub fn nlp_parse_dependency_range_scale(s : NlpparsedependencyRange, f : Double) -> NlpparsedependencyRange {
  let result = nlp_parse_dependency_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_parse_dependency_range_add(a : NlpparsedependencyRange, b : NlpparsedependencyRange) -> NlpparsedependencyRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_parse_dependency_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_parse_dependency_range_copy(s : NlpparsedependencyRange) -> NlpparsedependencyRange {
  let result = nlp_parse_dependency_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_parse_dependency_range_fill(s : NlpparsedependencyRange, v : Double) -> NlpparsedependencyRange {
  let result = nlp_parse_dependency_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_dependency_range_min(s : NlpparsedependencyRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_dependency_range_max(s : NlpparsedependencyRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_dependency_range_to_string(s : NlpparsedependencyRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparsedependencySlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_dependency_slice_make(size : Int) -> NlpparsedependencySlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_dependency_slice_len(s : NlpparsedependencySlice) -> Int { s.size }

pub fn nlp_parse_dependency_slice_get(s : NlpparsedependencySlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_dependency_slice_set(s : NlpparsedependencySlice, i : Int, v : Double) -> NlpparsedependencySlice {
  let result = nlp_parse_dependency_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_dependency_slice_sum(s : NlpparsedependencySlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_parse_dependency_slice_mean(s : NlpparsedependencySlice) -> Double {
  if s.size == 0 { 0.0 } else { nlp_parse_dependency_slice_sum(s) / s.size.to_double() }
}

pub fn nlp_parse_dependency_slice_scale(s : NlpparsedependencySlice, f : Double) -> NlpparsedependencySlice {
  let result = nlp_parse_dependency_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_parse_dependency_slice_add(a : NlpparsedependencySlice, b : NlpparsedependencySlice) -> NlpparsedependencySlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_parse_dependency_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_parse_dependency_slice_copy(s : NlpparsedependencySlice) -> NlpparsedependencySlice {
  let result = nlp_parse_dependency_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_parse_dependency_slice_fill(s : NlpparsedependencySlice, v : Double) -> NlpparsedependencySlice {
  let result = nlp_parse_dependency_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_dependency_slice_min(s : NlpparsedependencySlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_dependency_slice_max(s : NlpparsedependencySlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_dependency_slice_to_string(s : NlpparsedependencySlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn nlp_parse_dependency_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_parse_dependency_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_parse_dependency_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_parse_dependency_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_parse_dependency_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_parse_dependency_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_parse_dependency_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_parse_dependency_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_parse_dependency_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_parse_dependency_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_parse_dependency_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_parse_dependency_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_parse_dependency_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_parse_dependency_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_parse_dependency_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_parse_dependency_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_parse_dependency_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_parse_dependency_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_parse_dependency_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_parse_dependency_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_parse_dependency_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_parse_dependency_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_parse_dependency_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_parse_dependency_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_parse_dependency_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

