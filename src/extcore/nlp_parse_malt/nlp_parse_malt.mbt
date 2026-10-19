///===
/// extcore/nlp_parse_malt

pub(all) struct NlpparsemaltPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn nlp_parse_malt_make_point(x : Double, y : Double) -> NlpparsemaltPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn nlp_parse_malt_make_point3(x : Double, y : Double, z : Double) -> NlpparsemaltPoint {
  { x, y, z, label: 0 }
}

pub fn nlp_parse_malt_point_x(pt : NlpparsemaltPoint) -> Double { pt.x }

pub fn nlp_parse_malt_point_y(pt : NlpparsemaltPoint) -> Double { pt.y }

pub fn nlp_parse_malt_point_z(pt : NlpparsemaltPoint) -> Double { pt.z }

pub fn nlp_parse_malt_point_label(pt : NlpparsemaltPoint) -> Int { pt.label }

pub fn nlp_parse_malt_point_dist(a : NlpparsemaltPoint, b : NlpparsemaltPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  nlp_parse_malt_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn nlp_parse_malt_point_add(a : NlpparsemaltPoint, b : NlpparsemaltPoint) -> NlpparsemaltPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn nlp_parse_malt_point_sub(a : NlpparsemaltPoint, b : NlpparsemaltPoint) -> NlpparsemaltPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn nlp_parse_malt_point_scale(pt : NlpparsemaltPoint, s : Double) -> NlpparsemaltPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn nlp_parse_malt_point_dot(a : NlpparsemaltPoint, b : NlpparsemaltPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn nlp_parse_malt_point_cross(a : NlpparsemaltPoint, b : NlpparsemaltPoint) -> NlpparsemaltPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn nlp_parse_malt_point_norm(pt : NlpparsemaltPoint) -> Double {
  nlp_parse_malt_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn nlp_parse_malt_point_normalize(pt : NlpparsemaltPoint) -> NlpparsemaltPoint {
  let n = nlp_parse_malt_point_norm(pt)
  if n < 0.0000001 { pt } else { nlp_parse_malt_point_scale(pt, 1.0 / n) }
}

pub fn nlp_parse_malt_point_negate(pt : NlpparsemaltPoint) -> NlpparsemaltPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn nlp_parse_malt_point_mid(a : NlpparsemaltPoint, b : NlpparsemaltPoint) -> NlpparsemaltPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn nlp_parse_malt_point_lerp(a : NlpparsemaltPoint, b : NlpparsemaltPoint, t : Double) -> NlpparsemaltPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn nlp_parse_malt_point_to_string(pt : NlpparsemaltPoint) -> String {
  "(" + nlp_parse_malt_dbl(pt.x) + ", " + nlp_parse_malt_dbl(pt.y) + ", " + nlp_parse_malt_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct NlpparsemaltSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn nlp_parse_malt_make_series(vals : Array[Double], name : String) -> NlpparsemaltSeries {
  { vals, name, meta: 0 }
}

pub fn nlp_parse_malt_series_len(s : NlpparsemaltSeries) -> Int { s.vals.length() }

pub fn nlp_parse_malt_series_sum(s : NlpparsemaltSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn nlp_parse_malt_series_mean(s : NlpparsemaltSeries) -> Double {
  let n = nlp_parse_malt_series_len(s)
  if n == 0 { 0.0 } else { nlp_parse_malt_series_sum(s) / n.to_double() }
}

pub fn nlp_parse_malt_series_min(s : NlpparsemaltSeries) -> Double {
  let n = nlp_parse_malt_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn nlp_parse_malt_series_max(s : NlpparsemaltSeries) -> Double {
  let n = nlp_parse_malt_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn nlp_parse_malt_series_range(s : NlpparsemaltSeries) -> Double {
  nlp_parse_malt_series_max(s) - nlp_parse_malt_series_min(s)
}

pub fn nlp_parse_malt_series_var(s : NlpparsemaltSeries) -> Double {
  let n = nlp_parse_malt_series_len(s)
  if n == 0 { 0.0 } else {
    let m = nlp_parse_malt_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn nlp_parse_malt_series_std(s : NlpparsemaltSeries) -> Double { nlp_parse_malt_sqrt(nlp_parse_malt_series_var(s)) }

pub fn nlp_parse_malt_series_median(s : NlpparsemaltSeries) -> Double {
  let n = nlp_parse_malt_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = nlp_parse_malt_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn nlp_parse_malt_series_scale(s : NlpparsemaltSeries, f : Double) -> NlpparsemaltSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = nlp_parse_malt_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn nlp_parse_malt_series_add(a : NlpparsemaltSeries, b : NlpparsemaltSeries) -> NlpparsemaltSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = nlp_parse_malt_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn nlp_parse_malt_series_sub(a : NlpparsemaltSeries, b : NlpparsemaltSeries) -> NlpparsemaltSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = nlp_parse_malt_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn nlp_parse_malt_series_normalize(s : NlpparsemaltSeries) -> NlpparsemaltSeries {
  let mn = nlp_parse_malt_series_min(s)
  let mx = nlp_parse_malt_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = nlp_parse_malt_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn nlp_parse_malt_series_cumsum(s : NlpparsemaltSeries) -> NlpparsemaltSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = nlp_parse_malt_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn nlp_parse_malt_series_to_string(s : NlpparsemaltSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + nlp_parse_malt_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NlpparsemaltMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn nlp_parse_malt_make_matrix(rows : Int, cols : Int, val : Double) -> NlpparsemaltMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn nlp_parse_malt_matrix_identity(n : Int) -> NlpparsemaltMatrix {
  let m = nlp_parse_malt_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn nlp_parse_malt_matrix_get(m : NlpparsemaltMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn nlp_parse_malt_matrix_transpose(m : NlpparsemaltMatrix) -> NlpparsemaltMatrix {
  let result = nlp_parse_malt_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn nlp_parse_malt_matrix_add(a : NlpparsemaltMatrix, b : NlpparsemaltMatrix) -> NlpparsemaltMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = nlp_parse_malt_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn nlp_parse_malt_matrix_scale(m : NlpparsemaltMatrix, s : Double) -> NlpparsemaltMatrix {
  let result = nlp_parse_malt_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn nlp_parse_malt_matrix_multiply(a : NlpparsemaltMatrix, b : NlpparsemaltMatrix) -> NlpparsemaltMatrix {
  if a.cols != b.rows { return nlp_parse_malt_make_matrix(a.rows, b.cols, 0.0) }
  let result = nlp_parse_malt_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn nlp_parse_malt_matrix_trace(m : NlpparsemaltMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn nlp_parse_malt_matrix_det(m : NlpparsemaltMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn nlp_parse_malt_matrix_norm(m : NlpparsemaltMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  nlp_parse_malt_sqrt(sum)
}

pub fn nlp_parse_malt_matrix_to_string(m : NlpparsemaltMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + nlp_parse_malt_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct NlpparsemaltVector {
  comps : Array[Double]
  dim : Int
}

pub fn nlp_parse_malt_make_vector(comps : Array[Double]) -> NlpparsemaltVector {
  { comps, dim: comps.length() }
}

pub fn nlp_parse_malt_vector_zero(dim : Int) -> NlpparsemaltVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn nlp_parse_malt_vector_add(a : NlpparsemaltVector, b : NlpparsemaltVector) -> NlpparsemaltVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = nlp_parse_malt_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn nlp_parse_malt_vector_sub(a : NlpparsemaltVector, b : NlpparsemaltVector) -> NlpparsemaltVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = nlp_parse_malt_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn nlp_parse_malt_vector_scale(v : NlpparsemaltVector, s : Double) -> NlpparsemaltVector {
  let mut result = []
  for i in 0..<v.dim { result = nlp_parse_malt_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn nlp_parse_malt_vector_dot(a : NlpparsemaltVector, b : NlpparsemaltVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn nlp_parse_malt_vector_norm(v : NlpparsemaltVector) -> Double { nlp_parse_malt_sqrt(nlp_parse_malt_vector_dot(v, v)) }

pub fn nlp_parse_malt_vector_normalize(v : NlpparsemaltVector) -> NlpparsemaltVector {
  let n = nlp_parse_malt_vector_norm(v)
  if n < 0.0000001 { v } else { nlp_parse_malt_vector_scale(v, 1.0 / n) }
}

pub fn nlp_parse_malt_vector_dist(a : NlpparsemaltVector, b : NlpparsemaltVector) -> Double {
  nlp_parse_malt_vector_norm(nlp_parse_malt_vector_sub(a, b))
}

pub fn nlp_parse_malt_vector_to_string(v : NlpparsemaltVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + nlp_parse_malt_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn nlp_parse_malt_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn nlp_parse_malt_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = nlp_parse_malt_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn nlp_parse_malt_std(data : Array[Double]) -> Double { nlp_parse_malt_sqrt(nlp_parse_malt_var(data)) }

pub fn nlp_parse_malt_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = nlp_parse_malt_mean(a); let mb = nlp_parse_malt_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn nlp_parse_malt_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = nlp_parse_malt_std(a); let sb = nlp_parse_malt_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { nlp_parse_malt_cov(a, b) / (sa * sb) }
}

pub fn nlp_parse_malt_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = nlp_parse_malt_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn nlp_parse_malt_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn nlp_parse_malt_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn nlp_parse_malt_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  nlp_parse_malt_sqrt(nlp_parse_malt_mse(pred, labels))
}

pub fn nlp_parse_malt_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + nlp_parse_malt_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn nlp_parse_malt_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = nlp_parse_malt_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn nlp_parse_malt_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn nlp_parse_malt_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn nlp_parse_malt_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = nlp_parse_malt_precision(pred, labels, pos); let r = nlp_parse_malt_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn nlp_parse_malt_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn nlp_parse_malt_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = nlp_parse_malt_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn nlp_parse_malt_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn nlp_parse_malt_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn nlp_parse_malt_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = nlp_parse_malt_gcd(a, b)
    (a / g) * b
  }
}

pub fn nlp_parse_malt_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn nlp_parse_malt_fibonacci(n : Int) -> Int {
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

pub fn nlp_parse_malt_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = nlp_parse_malt_min(data); let mx = nlp_parse_malt_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn nlp_parse_malt_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = nlp_parse_malt_mean(data); let sd = nlp_parse_malt_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn nlp_parse_malt_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn nlp_parse_malt_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn nlp_parse_malt_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn nlp_parse_malt_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn nlp_parse_malt_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn nlp_parse_malt_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn nlp_parse_malt_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn nlp_parse_malt_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn nlp_parse_malt_dbl(x : Double) -> String {
  let i = if x >= 0.0 { nlp_parse_malt_int(x) } else { -nlp_parse_malt_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { nlp_parse_malt_int(f * 1000000.0) } else { nlp_parse_malt_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn nlp_parse_malt_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn nlp_parse_malt_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct NlpparsemaltFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_malt_frame_make(size : Int) -> NlpparsemaltFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_malt_frame_len(s : NlpparsemaltFrame) -> Int { s.size }

pub fn nlp_parse_malt_frame_get(s : NlpparsemaltFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_malt_frame_set(s : NlpparsemaltFrame, i : Int, v : Double) -> NlpparsemaltFrame {
  let result = nlp_parse_malt_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_malt_frame_sum(s : NlpparsemaltFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_parse_malt_frame_mean(s : NlpparsemaltFrame) -> Double {
  if s.size == 0 { 0.0 } else { nlp_parse_malt_frame_sum(s) / s.size.to_double() }
}

pub fn nlp_parse_malt_frame_scale(s : NlpparsemaltFrame, f : Double) -> NlpparsemaltFrame {
  let result = nlp_parse_malt_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_parse_malt_frame_add(a : NlpparsemaltFrame, b : NlpparsemaltFrame) -> NlpparsemaltFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_parse_malt_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_parse_malt_frame_copy(s : NlpparsemaltFrame) -> NlpparsemaltFrame {
  let result = nlp_parse_malt_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_parse_malt_frame_fill(s : NlpparsemaltFrame, v : Double) -> NlpparsemaltFrame {
  let result = nlp_parse_malt_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_malt_frame_min(s : NlpparsemaltFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_malt_frame_max(s : NlpparsemaltFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_malt_frame_to_string(s : NlpparsemaltFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparsemaltTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_malt_table_make(size : Int) -> NlpparsemaltTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_malt_table_len(s : NlpparsemaltTable) -> Int { s.size }

pub fn nlp_parse_malt_table_get(s : NlpparsemaltTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_malt_table_set(s : NlpparsemaltTable, i : Int, v : Double) -> NlpparsemaltTable {
  let result = nlp_parse_malt_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_malt_table_sum(s : NlpparsemaltTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_parse_malt_table_mean(s : NlpparsemaltTable) -> Double {
  if s.size == 0 { 0.0 } else { nlp_parse_malt_table_sum(s) / s.size.to_double() }
}

pub fn nlp_parse_malt_table_scale(s : NlpparsemaltTable, f : Double) -> NlpparsemaltTable {
  let result = nlp_parse_malt_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_parse_malt_table_add(a : NlpparsemaltTable, b : NlpparsemaltTable) -> NlpparsemaltTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_parse_malt_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_parse_malt_table_copy(s : NlpparsemaltTable) -> NlpparsemaltTable {
  let result = nlp_parse_malt_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_parse_malt_table_fill(s : NlpparsemaltTable, v : Double) -> NlpparsemaltTable {
  let result = nlp_parse_malt_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_malt_table_min(s : NlpparsemaltTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_malt_table_max(s : NlpparsemaltTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_malt_table_to_string(s : NlpparsemaltTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparsemaltGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_malt_graphn_make(size : Int) -> NlpparsemaltGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_malt_graphn_len(s : NlpparsemaltGraphN) -> Int { s.size }

pub fn nlp_parse_malt_graphn_get(s : NlpparsemaltGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_malt_graphn_set(s : NlpparsemaltGraphN, i : Int, v : Double) -> NlpparsemaltGraphN {
  let result = nlp_parse_malt_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_malt_graphn_sum(s : NlpparsemaltGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_parse_malt_graphn_mean(s : NlpparsemaltGraphN) -> Double {
  if s.size == 0 { 0.0 } else { nlp_parse_malt_graphn_sum(s) / s.size.to_double() }
}

pub fn nlp_parse_malt_graphn_scale(s : NlpparsemaltGraphN, f : Double) -> NlpparsemaltGraphN {
  let result = nlp_parse_malt_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_parse_malt_graphn_add(a : NlpparsemaltGraphN, b : NlpparsemaltGraphN) -> NlpparsemaltGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_parse_malt_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_parse_malt_graphn_copy(s : NlpparsemaltGraphN) -> NlpparsemaltGraphN {
  let result = nlp_parse_malt_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_parse_malt_graphn_fill(s : NlpparsemaltGraphN, v : Double) -> NlpparsemaltGraphN {
  let result = nlp_parse_malt_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_malt_graphn_min(s : NlpparsemaltGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_malt_graphn_max(s : NlpparsemaltGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_malt_graphn_to_string(s : NlpparsemaltGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparsemaltNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_malt_node_make(size : Int) -> NlpparsemaltNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_malt_node_len(s : NlpparsemaltNode) -> Int { s.size }

pub fn nlp_parse_malt_node_get(s : NlpparsemaltNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_malt_node_set(s : NlpparsemaltNode, i : Int, v : Double) -> NlpparsemaltNode {
  let result = nlp_parse_malt_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_malt_node_sum(s : NlpparsemaltNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_parse_malt_node_mean(s : NlpparsemaltNode) -> Double {
  if s.size == 0 { 0.0 } else { nlp_parse_malt_node_sum(s) / s.size.to_double() }
}

pub fn nlp_parse_malt_node_scale(s : NlpparsemaltNode, f : Double) -> NlpparsemaltNode {
  let result = nlp_parse_malt_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_parse_malt_node_add(a : NlpparsemaltNode, b : NlpparsemaltNode) -> NlpparsemaltNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_parse_malt_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_parse_malt_node_copy(s : NlpparsemaltNode) -> NlpparsemaltNode {
  let result = nlp_parse_malt_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_parse_malt_node_fill(s : NlpparsemaltNode, v : Double) -> NlpparsemaltNode {
  let result = nlp_parse_malt_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_malt_node_min(s : NlpparsemaltNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_malt_node_max(s : NlpparsemaltNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_malt_node_to_string(s : NlpparsemaltNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparsemaltEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_malt_edge_make(size : Int) -> NlpparsemaltEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_malt_edge_len(s : NlpparsemaltEdge) -> Int { s.size }

pub fn nlp_parse_malt_edge_get(s : NlpparsemaltEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_malt_edge_set(s : NlpparsemaltEdge, i : Int, v : Double) -> NlpparsemaltEdge {
  let result = nlp_parse_malt_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_malt_edge_sum(s : NlpparsemaltEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_parse_malt_edge_mean(s : NlpparsemaltEdge) -> Double {
  if s.size == 0 { 0.0 } else { nlp_parse_malt_edge_sum(s) / s.size.to_double() }
}

pub fn nlp_parse_malt_edge_scale(s : NlpparsemaltEdge, f : Double) -> NlpparsemaltEdge {
  let result = nlp_parse_malt_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_parse_malt_edge_add(a : NlpparsemaltEdge, b : NlpparsemaltEdge) -> NlpparsemaltEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_parse_malt_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_parse_malt_edge_copy(s : NlpparsemaltEdge) -> NlpparsemaltEdge {
  let result = nlp_parse_malt_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_parse_malt_edge_fill(s : NlpparsemaltEdge, v : Double) -> NlpparsemaltEdge {
  let result = nlp_parse_malt_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_malt_edge_min(s : NlpparsemaltEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_malt_edge_max(s : NlpparsemaltEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_malt_edge_to_string(s : NlpparsemaltEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparsemaltPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_malt_path_make(size : Int) -> NlpparsemaltPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_malt_path_len(s : NlpparsemaltPath) -> Int { s.size }

pub fn nlp_parse_malt_path_get(s : NlpparsemaltPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_malt_path_set(s : NlpparsemaltPath, i : Int, v : Double) -> NlpparsemaltPath {
  let result = nlp_parse_malt_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_malt_path_sum(s : NlpparsemaltPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_parse_malt_path_mean(s : NlpparsemaltPath) -> Double {
  if s.size == 0 { 0.0 } else { nlp_parse_malt_path_sum(s) / s.size.to_double() }
}

pub fn nlp_parse_malt_path_scale(s : NlpparsemaltPath, f : Double) -> NlpparsemaltPath {
  let result = nlp_parse_malt_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_parse_malt_path_add(a : NlpparsemaltPath, b : NlpparsemaltPath) -> NlpparsemaltPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_parse_malt_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_parse_malt_path_copy(s : NlpparsemaltPath) -> NlpparsemaltPath {
  let result = nlp_parse_malt_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_parse_malt_path_fill(s : NlpparsemaltPath, v : Double) -> NlpparsemaltPath {
  let result = nlp_parse_malt_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_malt_path_min(s : NlpparsemaltPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_malt_path_max(s : NlpparsemaltPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_malt_path_to_string(s : NlpparsemaltPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparsemaltCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_malt_cluster_make(size : Int) -> NlpparsemaltCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_malt_cluster_len(s : NlpparsemaltCluster) -> Int { s.size }

pub fn nlp_parse_malt_cluster_get(s : NlpparsemaltCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_malt_cluster_set(s : NlpparsemaltCluster, i : Int, v : Double) -> NlpparsemaltCluster {
  let result = nlp_parse_malt_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_malt_cluster_sum(s : NlpparsemaltCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_parse_malt_cluster_mean(s : NlpparsemaltCluster) -> Double {
  if s.size == 0 { 0.0 } else { nlp_parse_malt_cluster_sum(s) / s.size.to_double() }
}

pub fn nlp_parse_malt_cluster_scale(s : NlpparsemaltCluster, f : Double) -> NlpparsemaltCluster {
  let result = nlp_parse_malt_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_parse_malt_cluster_add(a : NlpparsemaltCluster, b : NlpparsemaltCluster) -> NlpparsemaltCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_parse_malt_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_parse_malt_cluster_copy(s : NlpparsemaltCluster) -> NlpparsemaltCluster {
  let result = nlp_parse_malt_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_parse_malt_cluster_fill(s : NlpparsemaltCluster, v : Double) -> NlpparsemaltCluster {
  let result = nlp_parse_malt_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_malt_cluster_min(s : NlpparsemaltCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_malt_cluster_max(s : NlpparsemaltCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_malt_cluster_to_string(s : NlpparsemaltCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparsemaltModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_malt_model_make(size : Int) -> NlpparsemaltModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_malt_model_len(s : NlpparsemaltModel) -> Int { s.size }

pub fn nlp_parse_malt_model_get(s : NlpparsemaltModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_malt_model_set(s : NlpparsemaltModel, i : Int, v : Double) -> NlpparsemaltModel {
  let result = nlp_parse_malt_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_malt_model_sum(s : NlpparsemaltModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_parse_malt_model_mean(s : NlpparsemaltModel) -> Double {
  if s.size == 0 { 0.0 } else { nlp_parse_malt_model_sum(s) / s.size.to_double() }
}

pub fn nlp_parse_malt_model_scale(s : NlpparsemaltModel, f : Double) -> NlpparsemaltModel {
  let result = nlp_parse_malt_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_parse_malt_model_add(a : NlpparsemaltModel, b : NlpparsemaltModel) -> NlpparsemaltModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_parse_malt_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_parse_malt_model_copy(s : NlpparsemaltModel) -> NlpparsemaltModel {
  let result = nlp_parse_malt_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_parse_malt_model_fill(s : NlpparsemaltModel, v : Double) -> NlpparsemaltModel {
  let result = nlp_parse_malt_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_malt_model_min(s : NlpparsemaltModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_malt_model_max(s : NlpparsemaltModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_malt_model_to_string(s : NlpparsemaltModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparsemaltLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_malt_layer_make(size : Int) -> NlpparsemaltLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_malt_layer_len(s : NlpparsemaltLayer) -> Int { s.size }

pub fn nlp_parse_malt_layer_get(s : NlpparsemaltLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_malt_layer_set(s : NlpparsemaltLayer, i : Int, v : Double) -> NlpparsemaltLayer {
  let result = nlp_parse_malt_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_malt_layer_sum(s : NlpparsemaltLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_parse_malt_layer_mean(s : NlpparsemaltLayer) -> Double {
  if s.size == 0 { 0.0 } else { nlp_parse_malt_layer_sum(s) / s.size.to_double() }
}

pub fn nlp_parse_malt_layer_scale(s : NlpparsemaltLayer, f : Double) -> NlpparsemaltLayer {
  let result = nlp_parse_malt_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_parse_malt_layer_add(a : NlpparsemaltLayer, b : NlpparsemaltLayer) -> NlpparsemaltLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_parse_malt_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_parse_malt_layer_copy(s : NlpparsemaltLayer) -> NlpparsemaltLayer {
  let result = nlp_parse_malt_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_parse_malt_layer_fill(s : NlpparsemaltLayer, v : Double) -> NlpparsemaltLayer {
  let result = nlp_parse_malt_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_malt_layer_min(s : NlpparsemaltLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_malt_layer_max(s : NlpparsemaltLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_malt_layer_to_string(s : NlpparsemaltLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparsemaltBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_malt_buffer_make(size : Int) -> NlpparsemaltBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_malt_buffer_len(s : NlpparsemaltBuffer) -> Int { s.size }

pub fn nlp_parse_malt_buffer_get(s : NlpparsemaltBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_malt_buffer_set(s : NlpparsemaltBuffer, i : Int, v : Double) -> NlpparsemaltBuffer {
  let result = nlp_parse_malt_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_malt_buffer_sum(s : NlpparsemaltBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_parse_malt_buffer_mean(s : NlpparsemaltBuffer) -> Double {
  if s.size == 0 { 0.0 } else { nlp_parse_malt_buffer_sum(s) / s.size.to_double() }
}

pub fn nlp_parse_malt_buffer_scale(s : NlpparsemaltBuffer, f : Double) -> NlpparsemaltBuffer {
  let result = nlp_parse_malt_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_parse_malt_buffer_add(a : NlpparsemaltBuffer, b : NlpparsemaltBuffer) -> NlpparsemaltBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_parse_malt_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_parse_malt_buffer_copy(s : NlpparsemaltBuffer) -> NlpparsemaltBuffer {
  let result = nlp_parse_malt_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_parse_malt_buffer_fill(s : NlpparsemaltBuffer, v : Double) -> NlpparsemaltBuffer {
  let result = nlp_parse_malt_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_malt_buffer_min(s : NlpparsemaltBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_malt_buffer_max(s : NlpparsemaltBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_malt_buffer_to_string(s : NlpparsemaltBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparsemaltCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_malt_cursor_make(size : Int) -> NlpparsemaltCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_malt_cursor_len(s : NlpparsemaltCursor) -> Int { s.size }

pub fn nlp_parse_malt_cursor_get(s : NlpparsemaltCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_malt_cursor_set(s : NlpparsemaltCursor, i : Int, v : Double) -> NlpparsemaltCursor {
  let result = nlp_parse_malt_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_malt_cursor_sum(s : NlpparsemaltCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_parse_malt_cursor_mean(s : NlpparsemaltCursor) -> Double {
  if s.size == 0 { 0.0 } else { nlp_parse_malt_cursor_sum(s) / s.size.to_double() }
}

pub fn nlp_parse_malt_cursor_scale(s : NlpparsemaltCursor, f : Double) -> NlpparsemaltCursor {
  let result = nlp_parse_malt_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_parse_malt_cursor_add(a : NlpparsemaltCursor, b : NlpparsemaltCursor) -> NlpparsemaltCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_parse_malt_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_parse_malt_cursor_copy(s : NlpparsemaltCursor) -> NlpparsemaltCursor {
  let result = nlp_parse_malt_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_parse_malt_cursor_fill(s : NlpparsemaltCursor, v : Double) -> NlpparsemaltCursor {
  let result = nlp_parse_malt_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_malt_cursor_min(s : NlpparsemaltCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_malt_cursor_max(s : NlpparsemaltCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_malt_cursor_to_string(s : NlpparsemaltCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparsemaltView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_malt_view_make(size : Int) -> NlpparsemaltView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_malt_view_len(s : NlpparsemaltView) -> Int { s.size }

pub fn nlp_parse_malt_view_get(s : NlpparsemaltView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_malt_view_set(s : NlpparsemaltView, i : Int, v : Double) -> NlpparsemaltView {
  let result = nlp_parse_malt_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_malt_view_sum(s : NlpparsemaltView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_parse_malt_view_mean(s : NlpparsemaltView) -> Double {
  if s.size == 0 { 0.0 } else { nlp_parse_malt_view_sum(s) / s.size.to_double() }
}

pub fn nlp_parse_malt_view_scale(s : NlpparsemaltView, f : Double) -> NlpparsemaltView {
  let result = nlp_parse_malt_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_parse_malt_view_add(a : NlpparsemaltView, b : NlpparsemaltView) -> NlpparsemaltView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_parse_malt_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_parse_malt_view_copy(s : NlpparsemaltView) -> NlpparsemaltView {
  let result = nlp_parse_malt_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_parse_malt_view_fill(s : NlpparsemaltView, v : Double) -> NlpparsemaltView {
  let result = nlp_parse_malt_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_malt_view_min(s : NlpparsemaltView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_malt_view_max(s : NlpparsemaltView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_malt_view_to_string(s : NlpparsemaltView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparsemaltRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_malt_range_make(size : Int) -> NlpparsemaltRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_malt_range_len(s : NlpparsemaltRange) -> Int { s.size }

pub fn nlp_parse_malt_range_get(s : NlpparsemaltRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_malt_range_set(s : NlpparsemaltRange, i : Int, v : Double) -> NlpparsemaltRange {
  let result = nlp_parse_malt_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_malt_range_sum(s : NlpparsemaltRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_parse_malt_range_mean(s : NlpparsemaltRange) -> Double {
  if s.size == 0 { 0.0 } else { nlp_parse_malt_range_sum(s) / s.size.to_double() }
}

pub fn nlp_parse_malt_range_scale(s : NlpparsemaltRange, f : Double) -> NlpparsemaltRange {
  let result = nlp_parse_malt_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_parse_malt_range_add(a : NlpparsemaltRange, b : NlpparsemaltRange) -> NlpparsemaltRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_parse_malt_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_parse_malt_range_copy(s : NlpparsemaltRange) -> NlpparsemaltRange {
  let result = nlp_parse_malt_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_parse_malt_range_fill(s : NlpparsemaltRange, v : Double) -> NlpparsemaltRange {
  let result = nlp_parse_malt_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_malt_range_min(s : NlpparsemaltRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_malt_range_max(s : NlpparsemaltRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_malt_range_to_string(s : NlpparsemaltRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparsemaltSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_malt_slice_make(size : Int) -> NlpparsemaltSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_malt_slice_len(s : NlpparsemaltSlice) -> Int { s.size }

pub fn nlp_parse_malt_slice_get(s : NlpparsemaltSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_malt_slice_set(s : NlpparsemaltSlice, i : Int, v : Double) -> NlpparsemaltSlice {
  let result = nlp_parse_malt_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_malt_slice_sum(s : NlpparsemaltSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_parse_malt_slice_mean(s : NlpparsemaltSlice) -> Double {
  if s.size == 0 { 0.0 } else { nlp_parse_malt_slice_sum(s) / s.size.to_double() }
}

pub fn nlp_parse_malt_slice_scale(s : NlpparsemaltSlice, f : Double) -> NlpparsemaltSlice {
  let result = nlp_parse_malt_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_parse_malt_slice_add(a : NlpparsemaltSlice, b : NlpparsemaltSlice) -> NlpparsemaltSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_parse_malt_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_parse_malt_slice_copy(s : NlpparsemaltSlice) -> NlpparsemaltSlice {
  let result = nlp_parse_malt_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_parse_malt_slice_fill(s : NlpparsemaltSlice, v : Double) -> NlpparsemaltSlice {
  let result = nlp_parse_malt_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_malt_slice_min(s : NlpparsemaltSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_malt_slice_max(s : NlpparsemaltSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_malt_slice_to_string(s : NlpparsemaltSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn nlp_parse_malt_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_parse_malt_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_parse_malt_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_parse_malt_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_parse_malt_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_parse_malt_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_parse_malt_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_parse_malt_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_parse_malt_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_parse_malt_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_parse_malt_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_parse_malt_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_parse_malt_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_parse_malt_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_parse_malt_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_parse_malt_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_parse_malt_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_parse_malt_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_parse_malt_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_parse_malt_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_parse_malt_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_parse_malt_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_parse_malt_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_parse_malt_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_parse_malt_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

