///===
/// extcore/nlp_tokenize_word

pub(all) struct NlptokenizewordPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn nlp_tokenize_word_make_point(x : Double, y : Double) -> NlptokenizewordPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn nlp_tokenize_word_make_point3(x : Double, y : Double, z : Double) -> NlptokenizewordPoint {
  { x, y, z, label: 0 }
}

pub fn nlp_tokenize_word_point_x(pt : NlptokenizewordPoint) -> Double { pt.x }

pub fn nlp_tokenize_word_point_y(pt : NlptokenizewordPoint) -> Double { pt.y }

pub fn nlp_tokenize_word_point_z(pt : NlptokenizewordPoint) -> Double { pt.z }

pub fn nlp_tokenize_word_point_label(pt : NlptokenizewordPoint) -> Int { pt.label }

pub fn nlp_tokenize_word_point_dist(a : NlptokenizewordPoint, b : NlptokenizewordPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  nlp_tokenize_word_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn nlp_tokenize_word_point_add(a : NlptokenizewordPoint, b : NlptokenizewordPoint) -> NlptokenizewordPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn nlp_tokenize_word_point_sub(a : NlptokenizewordPoint, b : NlptokenizewordPoint) -> NlptokenizewordPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn nlp_tokenize_word_point_scale(pt : NlptokenizewordPoint, s : Double) -> NlptokenizewordPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn nlp_tokenize_word_point_dot(a : NlptokenizewordPoint, b : NlptokenizewordPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn nlp_tokenize_word_point_cross(a : NlptokenizewordPoint, b : NlptokenizewordPoint) -> NlptokenizewordPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn nlp_tokenize_word_point_norm(pt : NlptokenizewordPoint) -> Double {
  nlp_tokenize_word_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn nlp_tokenize_word_point_normalize(pt : NlptokenizewordPoint) -> NlptokenizewordPoint {
  let n = nlp_tokenize_word_point_norm(pt)
  if n < 0.0000001 { pt } else { nlp_tokenize_word_point_scale(pt, 1.0 / n) }
}

pub fn nlp_tokenize_word_point_negate(pt : NlptokenizewordPoint) -> NlptokenizewordPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn nlp_tokenize_word_point_mid(a : NlptokenizewordPoint, b : NlptokenizewordPoint) -> NlptokenizewordPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn nlp_tokenize_word_point_lerp(a : NlptokenizewordPoint, b : NlptokenizewordPoint, t : Double) -> NlptokenizewordPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn nlp_tokenize_word_point_to_string(pt : NlptokenizewordPoint) -> String {
  "(" + nlp_tokenize_word_dbl(pt.x) + ", " + nlp_tokenize_word_dbl(pt.y) + ", " + nlp_tokenize_word_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct NlptokenizewordSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn nlp_tokenize_word_make_series(vals : Array[Double], name : String) -> NlptokenizewordSeries {
  { vals, name, meta: 0 }
}

pub fn nlp_tokenize_word_series_len(s : NlptokenizewordSeries) -> Int { s.vals.length() }

pub fn nlp_tokenize_word_series_sum(s : NlptokenizewordSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn nlp_tokenize_word_series_mean(s : NlptokenizewordSeries) -> Double {
  let n = nlp_tokenize_word_series_len(s)
  if n == 0 { 0.0 } else { nlp_tokenize_word_series_sum(s) / n.to_double() }
}

pub fn nlp_tokenize_word_series_min(s : NlptokenizewordSeries) -> Double {
  let n = nlp_tokenize_word_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn nlp_tokenize_word_series_max(s : NlptokenizewordSeries) -> Double {
  let n = nlp_tokenize_word_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn nlp_tokenize_word_series_range(s : NlptokenizewordSeries) -> Double {
  nlp_tokenize_word_series_max(s) - nlp_tokenize_word_series_min(s)
}

pub fn nlp_tokenize_word_series_var(s : NlptokenizewordSeries) -> Double {
  let n = nlp_tokenize_word_series_len(s)
  if n == 0 { 0.0 } else {
    let m = nlp_tokenize_word_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn nlp_tokenize_word_series_std(s : NlptokenizewordSeries) -> Double { nlp_tokenize_word_sqrt(nlp_tokenize_word_series_var(s)) }

pub fn nlp_tokenize_word_series_median(s : NlptokenizewordSeries) -> Double {
  let n = nlp_tokenize_word_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = nlp_tokenize_word_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn nlp_tokenize_word_series_scale(s : NlptokenizewordSeries, f : Double) -> NlptokenizewordSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = nlp_tokenize_word_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn nlp_tokenize_word_series_add(a : NlptokenizewordSeries, b : NlptokenizewordSeries) -> NlptokenizewordSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = nlp_tokenize_word_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn nlp_tokenize_word_series_sub(a : NlptokenizewordSeries, b : NlptokenizewordSeries) -> NlptokenizewordSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = nlp_tokenize_word_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn nlp_tokenize_word_series_normalize(s : NlptokenizewordSeries) -> NlptokenizewordSeries {
  let mn = nlp_tokenize_word_series_min(s)
  let mx = nlp_tokenize_word_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = nlp_tokenize_word_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn nlp_tokenize_word_series_cumsum(s : NlptokenizewordSeries) -> NlptokenizewordSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = nlp_tokenize_word_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn nlp_tokenize_word_series_to_string(s : NlptokenizewordSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + nlp_tokenize_word_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NlptokenizewordMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn nlp_tokenize_word_make_matrix(rows : Int, cols : Int, val : Double) -> NlptokenizewordMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn nlp_tokenize_word_matrix_identity(n : Int) -> NlptokenizewordMatrix {
  let m = nlp_tokenize_word_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn nlp_tokenize_word_matrix_get(m : NlptokenizewordMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn nlp_tokenize_word_matrix_transpose(m : NlptokenizewordMatrix) -> NlptokenizewordMatrix {
  let result = nlp_tokenize_word_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn nlp_tokenize_word_matrix_add(a : NlptokenizewordMatrix, b : NlptokenizewordMatrix) -> NlptokenizewordMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = nlp_tokenize_word_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn nlp_tokenize_word_matrix_scale(m : NlptokenizewordMatrix, s : Double) -> NlptokenizewordMatrix {
  let result = nlp_tokenize_word_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn nlp_tokenize_word_matrix_multiply(a : NlptokenizewordMatrix, b : NlptokenizewordMatrix) -> NlptokenizewordMatrix {
  if a.cols != b.rows { return nlp_tokenize_word_make_matrix(a.rows, b.cols, 0.0) }
  let result = nlp_tokenize_word_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn nlp_tokenize_word_matrix_trace(m : NlptokenizewordMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn nlp_tokenize_word_matrix_det(m : NlptokenizewordMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn nlp_tokenize_word_matrix_norm(m : NlptokenizewordMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  nlp_tokenize_word_sqrt(sum)
}

pub fn nlp_tokenize_word_matrix_to_string(m : NlptokenizewordMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + nlp_tokenize_word_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct NlptokenizewordVector {
  comps : Array[Double]
  dim : Int
}

pub fn nlp_tokenize_word_make_vector(comps : Array[Double]) -> NlptokenizewordVector {
  { comps, dim: comps.length() }
}

pub fn nlp_tokenize_word_vector_zero(dim : Int) -> NlptokenizewordVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn nlp_tokenize_word_vector_add(a : NlptokenizewordVector, b : NlptokenizewordVector) -> NlptokenizewordVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = nlp_tokenize_word_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn nlp_tokenize_word_vector_sub(a : NlptokenizewordVector, b : NlptokenizewordVector) -> NlptokenizewordVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = nlp_tokenize_word_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn nlp_tokenize_word_vector_scale(v : NlptokenizewordVector, s : Double) -> NlptokenizewordVector {
  let mut result = []
  for i in 0..<v.dim { result = nlp_tokenize_word_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn nlp_tokenize_word_vector_dot(a : NlptokenizewordVector, b : NlptokenizewordVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn nlp_tokenize_word_vector_norm(v : NlptokenizewordVector) -> Double { nlp_tokenize_word_sqrt(nlp_tokenize_word_vector_dot(v, v)) }

pub fn nlp_tokenize_word_vector_normalize(v : NlptokenizewordVector) -> NlptokenizewordVector {
  let n = nlp_tokenize_word_vector_norm(v)
  if n < 0.0000001 { v } else { nlp_tokenize_word_vector_scale(v, 1.0 / n) }
}

pub fn nlp_tokenize_word_vector_dist(a : NlptokenizewordVector, b : NlptokenizewordVector) -> Double {
  nlp_tokenize_word_vector_norm(nlp_tokenize_word_vector_sub(a, b))
}

pub fn nlp_tokenize_word_vector_to_string(v : NlptokenizewordVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + nlp_tokenize_word_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn nlp_tokenize_word_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn nlp_tokenize_word_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = nlp_tokenize_word_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn nlp_tokenize_word_std(data : Array[Double]) -> Double { nlp_tokenize_word_sqrt(nlp_tokenize_word_var(data)) }

pub fn nlp_tokenize_word_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = nlp_tokenize_word_mean(a); let mb = nlp_tokenize_word_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn nlp_tokenize_word_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = nlp_tokenize_word_std(a); let sb = nlp_tokenize_word_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { nlp_tokenize_word_cov(a, b) / (sa * sb) }
}

pub fn nlp_tokenize_word_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = nlp_tokenize_word_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn nlp_tokenize_word_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn nlp_tokenize_word_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn nlp_tokenize_word_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  nlp_tokenize_word_sqrt(nlp_tokenize_word_mse(pred, labels))
}

pub fn nlp_tokenize_word_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + nlp_tokenize_word_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn nlp_tokenize_word_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = nlp_tokenize_word_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn nlp_tokenize_word_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn nlp_tokenize_word_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn nlp_tokenize_word_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = nlp_tokenize_word_precision(pred, labels, pos); let r = nlp_tokenize_word_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn nlp_tokenize_word_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn nlp_tokenize_word_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = nlp_tokenize_word_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn nlp_tokenize_word_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn nlp_tokenize_word_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn nlp_tokenize_word_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = nlp_tokenize_word_gcd(a, b)
    (a / g) * b
  }
}

pub fn nlp_tokenize_word_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn nlp_tokenize_word_fibonacci(n : Int) -> Int {
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

pub fn nlp_tokenize_word_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = nlp_tokenize_word_min(data); let mx = nlp_tokenize_word_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn nlp_tokenize_word_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = nlp_tokenize_word_mean(data); let sd = nlp_tokenize_word_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn nlp_tokenize_word_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn nlp_tokenize_word_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn nlp_tokenize_word_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn nlp_tokenize_word_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn nlp_tokenize_word_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn nlp_tokenize_word_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn nlp_tokenize_word_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn nlp_tokenize_word_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn nlp_tokenize_word_dbl(x : Double) -> String {
  let i = if x >= 0.0 { nlp_tokenize_word_int(x) } else { -nlp_tokenize_word_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { nlp_tokenize_word_int(f * 1000000.0) } else { nlp_tokenize_word_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn nlp_tokenize_word_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn nlp_tokenize_word_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct NlptokenizewordFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_word_frame_make(size : Int) -> NlptokenizewordFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_word_frame_len(s : NlptokenizewordFrame) -> Int { s.size }

pub fn nlp_tokenize_word_frame_get(s : NlptokenizewordFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_word_frame_set(s : NlptokenizewordFrame, i : Int, v : Double) -> NlptokenizewordFrame {
  let result = nlp_tokenize_word_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_word_frame_sum(s : NlptokenizewordFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_tokenize_word_frame_mean(s : NlptokenizewordFrame) -> Double {
  if s.size == 0 { 0.0 } else { nlp_tokenize_word_frame_sum(s) / s.size.to_double() }
}

pub fn nlp_tokenize_word_frame_scale(s : NlptokenizewordFrame, f : Double) -> NlptokenizewordFrame {
  let result = nlp_tokenize_word_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_tokenize_word_frame_add(a : NlptokenizewordFrame, b : NlptokenizewordFrame) -> NlptokenizewordFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_tokenize_word_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_tokenize_word_frame_copy(s : NlptokenizewordFrame) -> NlptokenizewordFrame {
  let result = nlp_tokenize_word_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_tokenize_word_frame_fill(s : NlptokenizewordFrame, v : Double) -> NlptokenizewordFrame {
  let result = nlp_tokenize_word_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_word_frame_min(s : NlptokenizewordFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_tokenize_word_frame_max(s : NlptokenizewordFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_tokenize_word_frame_to_string(s : NlptokenizewordFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizewordTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_word_table_make(size : Int) -> NlptokenizewordTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_word_table_len(s : NlptokenizewordTable) -> Int { s.size }

pub fn nlp_tokenize_word_table_get(s : NlptokenizewordTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_word_table_set(s : NlptokenizewordTable, i : Int, v : Double) -> NlptokenizewordTable {
  let result = nlp_tokenize_word_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_word_table_sum(s : NlptokenizewordTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_tokenize_word_table_mean(s : NlptokenizewordTable) -> Double {
  if s.size == 0 { 0.0 } else { nlp_tokenize_word_table_sum(s) / s.size.to_double() }
}

pub fn nlp_tokenize_word_table_scale(s : NlptokenizewordTable, f : Double) -> NlptokenizewordTable {
  let result = nlp_tokenize_word_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_tokenize_word_table_add(a : NlptokenizewordTable, b : NlptokenizewordTable) -> NlptokenizewordTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_tokenize_word_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_tokenize_word_table_copy(s : NlptokenizewordTable) -> NlptokenizewordTable {
  let result = nlp_tokenize_word_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_tokenize_word_table_fill(s : NlptokenizewordTable, v : Double) -> NlptokenizewordTable {
  let result = nlp_tokenize_word_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_word_table_min(s : NlptokenizewordTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_tokenize_word_table_max(s : NlptokenizewordTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_tokenize_word_table_to_string(s : NlptokenizewordTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizewordGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_word_graphn_make(size : Int) -> NlptokenizewordGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_word_graphn_len(s : NlptokenizewordGraphN) -> Int { s.size }

pub fn nlp_tokenize_word_graphn_get(s : NlptokenizewordGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_word_graphn_set(s : NlptokenizewordGraphN, i : Int, v : Double) -> NlptokenizewordGraphN {
  let result = nlp_tokenize_word_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_word_graphn_sum(s : NlptokenizewordGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_tokenize_word_graphn_mean(s : NlptokenizewordGraphN) -> Double {
  if s.size == 0 { 0.0 } else { nlp_tokenize_word_graphn_sum(s) / s.size.to_double() }
}

pub fn nlp_tokenize_word_graphn_scale(s : NlptokenizewordGraphN, f : Double) -> NlptokenizewordGraphN {
  let result = nlp_tokenize_word_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_tokenize_word_graphn_add(a : NlptokenizewordGraphN, b : NlptokenizewordGraphN) -> NlptokenizewordGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_tokenize_word_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_tokenize_word_graphn_copy(s : NlptokenizewordGraphN) -> NlptokenizewordGraphN {
  let result = nlp_tokenize_word_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_tokenize_word_graphn_fill(s : NlptokenizewordGraphN, v : Double) -> NlptokenizewordGraphN {
  let result = nlp_tokenize_word_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_word_graphn_min(s : NlptokenizewordGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_tokenize_word_graphn_max(s : NlptokenizewordGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_tokenize_word_graphn_to_string(s : NlptokenizewordGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizewordNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_word_node_make(size : Int) -> NlptokenizewordNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_word_node_len(s : NlptokenizewordNode) -> Int { s.size }

pub fn nlp_tokenize_word_node_get(s : NlptokenizewordNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_word_node_set(s : NlptokenizewordNode, i : Int, v : Double) -> NlptokenizewordNode {
  let result = nlp_tokenize_word_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_word_node_sum(s : NlptokenizewordNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_tokenize_word_node_mean(s : NlptokenizewordNode) -> Double {
  if s.size == 0 { 0.0 } else { nlp_tokenize_word_node_sum(s) / s.size.to_double() }
}

pub fn nlp_tokenize_word_node_scale(s : NlptokenizewordNode, f : Double) -> NlptokenizewordNode {
  let result = nlp_tokenize_word_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_tokenize_word_node_add(a : NlptokenizewordNode, b : NlptokenizewordNode) -> NlptokenizewordNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_tokenize_word_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_tokenize_word_node_copy(s : NlptokenizewordNode) -> NlptokenizewordNode {
  let result = nlp_tokenize_word_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_tokenize_word_node_fill(s : NlptokenizewordNode, v : Double) -> NlptokenizewordNode {
  let result = nlp_tokenize_word_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_word_node_min(s : NlptokenizewordNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_tokenize_word_node_max(s : NlptokenizewordNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_tokenize_word_node_to_string(s : NlptokenizewordNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizewordEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_word_edge_make(size : Int) -> NlptokenizewordEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_word_edge_len(s : NlptokenizewordEdge) -> Int { s.size }

pub fn nlp_tokenize_word_edge_get(s : NlptokenizewordEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_word_edge_set(s : NlptokenizewordEdge, i : Int, v : Double) -> NlptokenizewordEdge {
  let result = nlp_tokenize_word_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_word_edge_sum(s : NlptokenizewordEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_tokenize_word_edge_mean(s : NlptokenizewordEdge) -> Double {
  if s.size == 0 { 0.0 } else { nlp_tokenize_word_edge_sum(s) / s.size.to_double() }
}

pub fn nlp_tokenize_word_edge_scale(s : NlptokenizewordEdge, f : Double) -> NlptokenizewordEdge {
  let result = nlp_tokenize_word_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_tokenize_word_edge_add(a : NlptokenizewordEdge, b : NlptokenizewordEdge) -> NlptokenizewordEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_tokenize_word_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_tokenize_word_edge_copy(s : NlptokenizewordEdge) -> NlptokenizewordEdge {
  let result = nlp_tokenize_word_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_tokenize_word_edge_fill(s : NlptokenizewordEdge, v : Double) -> NlptokenizewordEdge {
  let result = nlp_tokenize_word_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_word_edge_min(s : NlptokenizewordEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_tokenize_word_edge_max(s : NlptokenizewordEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_tokenize_word_edge_to_string(s : NlptokenizewordEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizewordPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_word_path_make(size : Int) -> NlptokenizewordPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_word_path_len(s : NlptokenizewordPath) -> Int { s.size }

pub fn nlp_tokenize_word_path_get(s : NlptokenizewordPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_word_path_set(s : NlptokenizewordPath, i : Int, v : Double) -> NlptokenizewordPath {
  let result = nlp_tokenize_word_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_word_path_sum(s : NlptokenizewordPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_tokenize_word_path_mean(s : NlptokenizewordPath) -> Double {
  if s.size == 0 { 0.0 } else { nlp_tokenize_word_path_sum(s) / s.size.to_double() }
}

pub fn nlp_tokenize_word_path_scale(s : NlptokenizewordPath, f : Double) -> NlptokenizewordPath {
  let result = nlp_tokenize_word_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_tokenize_word_path_add(a : NlptokenizewordPath, b : NlptokenizewordPath) -> NlptokenizewordPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_tokenize_word_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_tokenize_word_path_copy(s : NlptokenizewordPath) -> NlptokenizewordPath {
  let result = nlp_tokenize_word_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_tokenize_word_path_fill(s : NlptokenizewordPath, v : Double) -> NlptokenizewordPath {
  let result = nlp_tokenize_word_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_word_path_min(s : NlptokenizewordPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_tokenize_word_path_max(s : NlptokenizewordPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_tokenize_word_path_to_string(s : NlptokenizewordPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizewordCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_word_cluster_make(size : Int) -> NlptokenizewordCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_word_cluster_len(s : NlptokenizewordCluster) -> Int { s.size }

pub fn nlp_tokenize_word_cluster_get(s : NlptokenizewordCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_word_cluster_set(s : NlptokenizewordCluster, i : Int, v : Double) -> NlptokenizewordCluster {
  let result = nlp_tokenize_word_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_word_cluster_sum(s : NlptokenizewordCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_tokenize_word_cluster_mean(s : NlptokenizewordCluster) -> Double {
  if s.size == 0 { 0.0 } else { nlp_tokenize_word_cluster_sum(s) / s.size.to_double() }
}

pub fn nlp_tokenize_word_cluster_scale(s : NlptokenizewordCluster, f : Double) -> NlptokenizewordCluster {
  let result = nlp_tokenize_word_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_tokenize_word_cluster_add(a : NlptokenizewordCluster, b : NlptokenizewordCluster) -> NlptokenizewordCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_tokenize_word_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_tokenize_word_cluster_copy(s : NlptokenizewordCluster) -> NlptokenizewordCluster {
  let result = nlp_tokenize_word_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_tokenize_word_cluster_fill(s : NlptokenizewordCluster, v : Double) -> NlptokenizewordCluster {
  let result = nlp_tokenize_word_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_word_cluster_min(s : NlptokenizewordCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_tokenize_word_cluster_max(s : NlptokenizewordCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_tokenize_word_cluster_to_string(s : NlptokenizewordCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizewordModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_word_model_make(size : Int) -> NlptokenizewordModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_word_model_len(s : NlptokenizewordModel) -> Int { s.size }

pub fn nlp_tokenize_word_model_get(s : NlptokenizewordModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_word_model_set(s : NlptokenizewordModel, i : Int, v : Double) -> NlptokenizewordModel {
  let result = nlp_tokenize_word_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_word_model_sum(s : NlptokenizewordModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_tokenize_word_model_mean(s : NlptokenizewordModel) -> Double {
  if s.size == 0 { 0.0 } else { nlp_tokenize_word_model_sum(s) / s.size.to_double() }
}

pub fn nlp_tokenize_word_model_scale(s : NlptokenizewordModel, f : Double) -> NlptokenizewordModel {
  let result = nlp_tokenize_word_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_tokenize_word_model_add(a : NlptokenizewordModel, b : NlptokenizewordModel) -> NlptokenizewordModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_tokenize_word_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_tokenize_word_model_copy(s : NlptokenizewordModel) -> NlptokenizewordModel {
  let result = nlp_tokenize_word_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_tokenize_word_model_fill(s : NlptokenizewordModel, v : Double) -> NlptokenizewordModel {
  let result = nlp_tokenize_word_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_word_model_min(s : NlptokenizewordModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_tokenize_word_model_max(s : NlptokenizewordModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_tokenize_word_model_to_string(s : NlptokenizewordModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizewordLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_word_layer_make(size : Int) -> NlptokenizewordLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_word_layer_len(s : NlptokenizewordLayer) -> Int { s.size }

pub fn nlp_tokenize_word_layer_get(s : NlptokenizewordLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_word_layer_set(s : NlptokenizewordLayer, i : Int, v : Double) -> NlptokenizewordLayer {
  let result = nlp_tokenize_word_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_word_layer_sum(s : NlptokenizewordLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_tokenize_word_layer_mean(s : NlptokenizewordLayer) -> Double {
  if s.size == 0 { 0.0 } else { nlp_tokenize_word_layer_sum(s) / s.size.to_double() }
}

pub fn nlp_tokenize_word_layer_scale(s : NlptokenizewordLayer, f : Double) -> NlptokenizewordLayer {
  let result = nlp_tokenize_word_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_tokenize_word_layer_add(a : NlptokenizewordLayer, b : NlptokenizewordLayer) -> NlptokenizewordLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_tokenize_word_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_tokenize_word_layer_copy(s : NlptokenizewordLayer) -> NlptokenizewordLayer {
  let result = nlp_tokenize_word_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_tokenize_word_layer_fill(s : NlptokenizewordLayer, v : Double) -> NlptokenizewordLayer {
  let result = nlp_tokenize_word_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_word_layer_min(s : NlptokenizewordLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_tokenize_word_layer_max(s : NlptokenizewordLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_tokenize_word_layer_to_string(s : NlptokenizewordLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizewordBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_word_buffer_make(size : Int) -> NlptokenizewordBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_word_buffer_len(s : NlptokenizewordBuffer) -> Int { s.size }

pub fn nlp_tokenize_word_buffer_get(s : NlptokenizewordBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_word_buffer_set(s : NlptokenizewordBuffer, i : Int, v : Double) -> NlptokenizewordBuffer {
  let result = nlp_tokenize_word_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_word_buffer_sum(s : NlptokenizewordBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_tokenize_word_buffer_mean(s : NlptokenizewordBuffer) -> Double {
  if s.size == 0 { 0.0 } else { nlp_tokenize_word_buffer_sum(s) / s.size.to_double() }
}

pub fn nlp_tokenize_word_buffer_scale(s : NlptokenizewordBuffer, f : Double) -> NlptokenizewordBuffer {
  let result = nlp_tokenize_word_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_tokenize_word_buffer_add(a : NlptokenizewordBuffer, b : NlptokenizewordBuffer) -> NlptokenizewordBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_tokenize_word_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_tokenize_word_buffer_copy(s : NlptokenizewordBuffer) -> NlptokenizewordBuffer {
  let result = nlp_tokenize_word_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_tokenize_word_buffer_fill(s : NlptokenizewordBuffer, v : Double) -> NlptokenizewordBuffer {
  let result = nlp_tokenize_word_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_word_buffer_min(s : NlptokenizewordBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_tokenize_word_buffer_max(s : NlptokenizewordBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_tokenize_word_buffer_to_string(s : NlptokenizewordBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizewordCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_word_cursor_make(size : Int) -> NlptokenizewordCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_word_cursor_len(s : NlptokenizewordCursor) -> Int { s.size }

pub fn nlp_tokenize_word_cursor_get(s : NlptokenizewordCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_word_cursor_set(s : NlptokenizewordCursor, i : Int, v : Double) -> NlptokenizewordCursor {
  let result = nlp_tokenize_word_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_word_cursor_sum(s : NlptokenizewordCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_tokenize_word_cursor_mean(s : NlptokenizewordCursor) -> Double {
  if s.size == 0 { 0.0 } else { nlp_tokenize_word_cursor_sum(s) / s.size.to_double() }
}

pub fn nlp_tokenize_word_cursor_scale(s : NlptokenizewordCursor, f : Double) -> NlptokenizewordCursor {
  let result = nlp_tokenize_word_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_tokenize_word_cursor_add(a : NlptokenizewordCursor, b : NlptokenizewordCursor) -> NlptokenizewordCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_tokenize_word_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_tokenize_word_cursor_copy(s : NlptokenizewordCursor) -> NlptokenizewordCursor {
  let result = nlp_tokenize_word_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_tokenize_word_cursor_fill(s : NlptokenizewordCursor, v : Double) -> NlptokenizewordCursor {
  let result = nlp_tokenize_word_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_word_cursor_min(s : NlptokenizewordCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_tokenize_word_cursor_max(s : NlptokenizewordCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_tokenize_word_cursor_to_string(s : NlptokenizewordCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizewordView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_word_view_make(size : Int) -> NlptokenizewordView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_word_view_len(s : NlptokenizewordView) -> Int { s.size }

pub fn nlp_tokenize_word_view_get(s : NlptokenizewordView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_word_view_set(s : NlptokenizewordView, i : Int, v : Double) -> NlptokenizewordView {
  let result = nlp_tokenize_word_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_word_view_sum(s : NlptokenizewordView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_tokenize_word_view_mean(s : NlptokenizewordView) -> Double {
  if s.size == 0 { 0.0 } else { nlp_tokenize_word_view_sum(s) / s.size.to_double() }
}

pub fn nlp_tokenize_word_view_scale(s : NlptokenizewordView, f : Double) -> NlptokenizewordView {
  let result = nlp_tokenize_word_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_tokenize_word_view_add(a : NlptokenizewordView, b : NlptokenizewordView) -> NlptokenizewordView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_tokenize_word_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_tokenize_word_view_copy(s : NlptokenizewordView) -> NlptokenizewordView {
  let result = nlp_tokenize_word_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_tokenize_word_view_fill(s : NlptokenizewordView, v : Double) -> NlptokenizewordView {
  let result = nlp_tokenize_word_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_word_view_min(s : NlptokenizewordView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_tokenize_word_view_max(s : NlptokenizewordView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_tokenize_word_view_to_string(s : NlptokenizewordView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizewordRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_word_range_make(size : Int) -> NlptokenizewordRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_word_range_len(s : NlptokenizewordRange) -> Int { s.size }

pub fn nlp_tokenize_word_range_get(s : NlptokenizewordRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_word_range_set(s : NlptokenizewordRange, i : Int, v : Double) -> NlptokenizewordRange {
  let result = nlp_tokenize_word_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_word_range_sum(s : NlptokenizewordRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_tokenize_word_range_mean(s : NlptokenizewordRange) -> Double {
  if s.size == 0 { 0.0 } else { nlp_tokenize_word_range_sum(s) / s.size.to_double() }
}

pub fn nlp_tokenize_word_range_scale(s : NlptokenizewordRange, f : Double) -> NlptokenizewordRange {
  let result = nlp_tokenize_word_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_tokenize_word_range_add(a : NlptokenizewordRange, b : NlptokenizewordRange) -> NlptokenizewordRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_tokenize_word_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_tokenize_word_range_copy(s : NlptokenizewordRange) -> NlptokenizewordRange {
  let result = nlp_tokenize_word_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_tokenize_word_range_fill(s : NlptokenizewordRange, v : Double) -> NlptokenizewordRange {
  let result = nlp_tokenize_word_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_word_range_min(s : NlptokenizewordRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_tokenize_word_range_max(s : NlptokenizewordRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_tokenize_word_range_to_string(s : NlptokenizewordRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizewordSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_word_slice_make(size : Int) -> NlptokenizewordSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_word_slice_len(s : NlptokenizewordSlice) -> Int { s.size }

pub fn nlp_tokenize_word_slice_get(s : NlptokenizewordSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_word_slice_set(s : NlptokenizewordSlice, i : Int, v : Double) -> NlptokenizewordSlice {
  let result = nlp_tokenize_word_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_word_slice_sum(s : NlptokenizewordSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_tokenize_word_slice_mean(s : NlptokenizewordSlice) -> Double {
  if s.size == 0 { 0.0 } else { nlp_tokenize_word_slice_sum(s) / s.size.to_double() }
}

pub fn nlp_tokenize_word_slice_scale(s : NlptokenizewordSlice, f : Double) -> NlptokenizewordSlice {
  let result = nlp_tokenize_word_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_tokenize_word_slice_add(a : NlptokenizewordSlice, b : NlptokenizewordSlice) -> NlptokenizewordSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_tokenize_word_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_tokenize_word_slice_copy(s : NlptokenizewordSlice) -> NlptokenizewordSlice {
  let result = nlp_tokenize_word_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_tokenize_word_slice_fill(s : NlptokenizewordSlice, v : Double) -> NlptokenizewordSlice {
  let result = nlp_tokenize_word_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_word_slice_min(s : NlptokenizewordSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_tokenize_word_slice_max(s : NlptokenizewordSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_tokenize_word_slice_to_string(s : NlptokenizewordSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn nlp_tokenize_word_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_tokenize_word_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_tokenize_word_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_tokenize_word_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_tokenize_word_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_tokenize_word_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_tokenize_word_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_tokenize_word_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_tokenize_word_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_tokenize_word_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_tokenize_word_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_tokenize_word_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_tokenize_word_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_tokenize_word_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_tokenize_word_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_tokenize_word_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_tokenize_word_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_tokenize_word_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_tokenize_word_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_tokenize_word_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_tokenize_word_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_tokenize_word_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_tokenize_word_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_tokenize_word_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_tokenize_word_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

