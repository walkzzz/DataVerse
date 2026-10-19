///===
/// extcore/nlp_parse_cky

pub(all) struct NlpparseckyPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn nlp_parse_cky_make_point(x : Double, y : Double) -> NlpparseckyPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn nlp_parse_cky_make_point3(x : Double, y : Double, z : Double) -> NlpparseckyPoint {
  { x, y, z, label: 0 }
}

pub fn nlp_parse_cky_point_x(pt : NlpparseckyPoint) -> Double { pt.x }

pub fn nlp_parse_cky_point_y(pt : NlpparseckyPoint) -> Double { pt.y }

pub fn nlp_parse_cky_point_z(pt : NlpparseckyPoint) -> Double { pt.z }

pub fn nlp_parse_cky_point_label(pt : NlpparseckyPoint) -> Int { pt.label }

pub fn nlp_parse_cky_point_dist(a : NlpparseckyPoint, b : NlpparseckyPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn nlp_parse_cky_point_add(a : NlpparseckyPoint, b : NlpparseckyPoint) -> NlpparseckyPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn nlp_parse_cky_point_sub(a : NlpparseckyPoint, b : NlpparseckyPoint) -> NlpparseckyPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn nlp_parse_cky_point_scale(pt : NlpparseckyPoint, s : Double) -> NlpparseckyPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn nlp_parse_cky_point_dot(a : NlpparseckyPoint, b : NlpparseckyPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn nlp_parse_cky_point_cross(a : NlpparseckyPoint, b : NlpparseckyPoint) -> NlpparseckyPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn nlp_parse_cky_point_norm(pt : NlpparseckyPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn nlp_parse_cky_point_normalize(pt : NlpparseckyPoint) -> NlpparseckyPoint {
  let n = nlp_parse_cky_point_norm(pt)
  if n < 0.0000001 { pt } else { nlp_parse_cky_point_scale(pt, 1.0 / n) }
}

pub fn nlp_parse_cky_point_negate(pt : NlpparseckyPoint) -> NlpparseckyPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn nlp_parse_cky_point_mid(a : NlpparseckyPoint, b : NlpparseckyPoint) -> NlpparseckyPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn nlp_parse_cky_point_lerp(a : NlpparseckyPoint, b : NlpparseckyPoint, t : Double) -> NlpparseckyPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn nlp_parse_cky_point_to_string(pt : NlpparseckyPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct NlpparseckySeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn nlp_parse_cky_make_series(vals : Array[Double], name : String) -> NlpparseckySeries {
  { vals, name, meta: 0 }
}

pub fn nlp_parse_cky_series_len(s : NlpparseckySeries) -> Int { s.vals.length() }

pub fn nlp_parse_cky_series_sum(s : NlpparseckySeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn nlp_parse_cky_series_mean(s : NlpparseckySeries) -> Double {
  let n = nlp_parse_cky_series_len(s)
  if n == 0 { 0.0 } else { nlp_parse_cky_series_sum(s) / n.to_double() }
}

pub fn nlp_parse_cky_series_min(s : NlpparseckySeries) -> Double {
  let n = nlp_parse_cky_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn nlp_parse_cky_series_max(s : NlpparseckySeries) -> Double {
  let n = nlp_parse_cky_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn nlp_parse_cky_series_range(s : NlpparseckySeries) -> Double {
  nlp_parse_cky_series_max(s) - nlp_parse_cky_series_min(s)
}

pub fn nlp_parse_cky_series_var(s : NlpparseckySeries) -> Double {
  let n = nlp_parse_cky_series_len(s)
  if n == 0 { 0.0 } else {
    let m = nlp_parse_cky_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn nlp_parse_cky_series_std(s : NlpparseckySeries) -> Double { @_common.sqrt(nlp_parse_cky_series_var(s)) }

pub fn nlp_parse_cky_series_median(s : NlpparseckySeries) -> Double {
  let n = nlp_parse_cky_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = nlp_parse_cky_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn nlp_parse_cky_series_scale(s : NlpparseckySeries, f : Double) -> NlpparseckySeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn nlp_parse_cky_series_add(a : NlpparseckySeries, b : NlpparseckySeries) -> NlpparseckySeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn nlp_parse_cky_series_sub(a : NlpparseckySeries, b : NlpparseckySeries) -> NlpparseckySeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn nlp_parse_cky_series_normalize(s : NlpparseckySeries) -> NlpparseckySeries {
  let mn = nlp_parse_cky_series_min(s)
  let mx = nlp_parse_cky_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn nlp_parse_cky_series_cumsum(s : NlpparseckySeries) -> NlpparseckySeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn nlp_parse_cky_series_to_string(s : NlpparseckySeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NlpparseckyMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn nlp_parse_cky_make_matrix(rows : Int, cols : Int, val : Double) -> NlpparseckyMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn nlp_parse_cky_matrix_identity(n : Int) -> NlpparseckyMatrix {
  let m = nlp_parse_cky_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn nlp_parse_cky_matrix_get(m : NlpparseckyMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn nlp_parse_cky_matrix_transpose(m : NlpparseckyMatrix) -> NlpparseckyMatrix {
  let result = nlp_parse_cky_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn nlp_parse_cky_matrix_add(a : NlpparseckyMatrix, b : NlpparseckyMatrix) -> NlpparseckyMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = nlp_parse_cky_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn nlp_parse_cky_matrix_scale(m : NlpparseckyMatrix, s : Double) -> NlpparseckyMatrix {
  let result = nlp_parse_cky_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn nlp_parse_cky_matrix_multiply(a : NlpparseckyMatrix, b : NlpparseckyMatrix) -> NlpparseckyMatrix {
  if a.cols != b.rows { return nlp_parse_cky_make_matrix(a.rows, b.cols, 0.0) }
  let result = nlp_parse_cky_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn nlp_parse_cky_matrix_trace(m : NlpparseckyMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn nlp_parse_cky_matrix_det(m : NlpparseckyMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn nlp_parse_cky_matrix_norm(m : NlpparseckyMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn nlp_parse_cky_matrix_to_string(m : NlpparseckyMatrix) -> String {
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

pub(all) struct NlpparseckyVector {
  comps : Array[Double]
  dim : Int
}

pub fn nlp_parse_cky_make_vector(comps : Array[Double]) -> NlpparseckyVector {
  { comps, dim: comps.length() }
}

pub fn nlp_parse_cky_vector_zero(dim : Int) -> NlpparseckyVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn nlp_parse_cky_vector_add(a : NlpparseckyVector, b : NlpparseckyVector) -> NlpparseckyVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn nlp_parse_cky_vector_sub(a : NlpparseckyVector, b : NlpparseckyVector) -> NlpparseckyVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn nlp_parse_cky_vector_scale(v : NlpparseckyVector, s : Double) -> NlpparseckyVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn nlp_parse_cky_vector_dot(a : NlpparseckyVector, b : NlpparseckyVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn nlp_parse_cky_vector_norm(v : NlpparseckyVector) -> Double { @_common.sqrt(nlp_parse_cky_vector_dot(v, v)) }

pub fn nlp_parse_cky_vector_normalize(v : NlpparseckyVector) -> NlpparseckyVector {
  let n = nlp_parse_cky_vector_norm(v)
  if n < 0.0000001 { v } else { nlp_parse_cky_vector_scale(v, 1.0 / n) }
}

pub fn nlp_parse_cky_vector_dist(a : NlpparseckyVector, b : NlpparseckyVector) -> Double {
  nlp_parse_cky_vector_norm(nlp_parse_cky_vector_sub(a, b))
}

pub fn nlp_parse_cky_vector_to_string(v : NlpparseckyVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn nlp_parse_cky_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn nlp_parse_cky_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = nlp_parse_cky_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn nlp_parse_cky_std(data : Array[Double]) -> Double { @_common.sqrt(nlp_parse_cky_var(data)) }

pub fn nlp_parse_cky_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = nlp_parse_cky_mean(a); let mb = nlp_parse_cky_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn nlp_parse_cky_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = nlp_parse_cky_std(a); let sb = nlp_parse_cky_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { nlp_parse_cky_cov(a, b) / (sa * sb) }
}

pub fn nlp_parse_cky_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = nlp_parse_cky_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn nlp_parse_cky_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn nlp_parse_cky_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn nlp_parse_cky_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  @_common.sqrt(nlp_parse_cky_mse(pred, labels))
}

pub fn nlp_parse_cky_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn nlp_parse_cky_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = nlp_parse_cky_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn nlp_parse_cky_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn nlp_parse_cky_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn nlp_parse_cky_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = nlp_parse_cky_precision(pred, labels, pos); let r = nlp_parse_cky_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn nlp_parse_cky_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn nlp_parse_cky_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = nlp_parse_cky_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn nlp_parse_cky_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn nlp_parse_cky_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn nlp_parse_cky_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = nlp_parse_cky_gcd(a, b)
    (a / g) * b
  }
}

pub fn nlp_parse_cky_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn nlp_parse_cky_fibonacci(n : Int) -> Int {
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

pub fn nlp_parse_cky_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = nlp_parse_cky_min(data); let mx = nlp_parse_cky_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn nlp_parse_cky_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = nlp_parse_cky_mean(data); let sd = nlp_parse_cky_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn nlp_parse_cky_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn nlp_parse_cky_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn nlp_parse_cky_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn nlp_parse_cky_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn nlp_parse_cky_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn nlp_parse_cky_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

pub(all) struct NlpparseckyFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_cky_frame_make(size : Int) -> NlpparseckyFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_cky_frame_len(s : NlpparseckyFrame) -> Int { s.size }

pub fn nlp_parse_cky_frame_get(s : NlpparseckyFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_cky_frame_set(s : NlpparseckyFrame, i : Int, v : Double) -> NlpparseckyFrame {
  let result = nlp_parse_cky_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_cky_frame_sum(s : NlpparseckyFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_parse_cky_frame_mean(s : NlpparseckyFrame) -> Double {
  if s.size == 0 { 0.0 } else { nlp_parse_cky_frame_sum(s) / s.size.to_double() }
}

pub fn nlp_parse_cky_frame_scale(s : NlpparseckyFrame, f : Double) -> NlpparseckyFrame {
  let result = nlp_parse_cky_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_parse_cky_frame_add(a : NlpparseckyFrame, b : NlpparseckyFrame) -> NlpparseckyFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_parse_cky_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_parse_cky_frame_copy(s : NlpparseckyFrame) -> NlpparseckyFrame {
  let result = nlp_parse_cky_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_parse_cky_frame_fill(s : NlpparseckyFrame, v : Double) -> NlpparseckyFrame {
  let result = nlp_parse_cky_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_cky_frame_min(s : NlpparseckyFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_cky_frame_max(s : NlpparseckyFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_cky_frame_to_string(s : NlpparseckyFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparseckyTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_cky_table_make(size : Int) -> NlpparseckyTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_cky_table_len(s : NlpparseckyTable) -> Int { s.size }

pub fn nlp_parse_cky_table_get(s : NlpparseckyTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_cky_table_set(s : NlpparseckyTable, i : Int, v : Double) -> NlpparseckyTable {
  let result = nlp_parse_cky_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_cky_table_sum(s : NlpparseckyTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_parse_cky_table_mean(s : NlpparseckyTable) -> Double {
  if s.size == 0 { 0.0 } else { nlp_parse_cky_table_sum(s) / s.size.to_double() }
}

pub fn nlp_parse_cky_table_scale(s : NlpparseckyTable, f : Double) -> NlpparseckyTable {
  let result = nlp_parse_cky_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_parse_cky_table_add(a : NlpparseckyTable, b : NlpparseckyTable) -> NlpparseckyTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_parse_cky_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_parse_cky_table_copy(s : NlpparseckyTable) -> NlpparseckyTable {
  let result = nlp_parse_cky_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_parse_cky_table_fill(s : NlpparseckyTable, v : Double) -> NlpparseckyTable {
  let result = nlp_parse_cky_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_cky_table_min(s : NlpparseckyTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_cky_table_max(s : NlpparseckyTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_cky_table_to_string(s : NlpparseckyTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparseckyGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_cky_graphn_make(size : Int) -> NlpparseckyGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_cky_graphn_len(s : NlpparseckyGraphN) -> Int { s.size }

pub fn nlp_parse_cky_graphn_get(s : NlpparseckyGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_cky_graphn_set(s : NlpparseckyGraphN, i : Int, v : Double) -> NlpparseckyGraphN {
  let result = nlp_parse_cky_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_cky_graphn_sum(s : NlpparseckyGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_parse_cky_graphn_mean(s : NlpparseckyGraphN) -> Double {
  if s.size == 0 { 0.0 } else { nlp_parse_cky_graphn_sum(s) / s.size.to_double() }
}

pub fn nlp_parse_cky_graphn_scale(s : NlpparseckyGraphN, f : Double) -> NlpparseckyGraphN {
  let result = nlp_parse_cky_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_parse_cky_graphn_add(a : NlpparseckyGraphN, b : NlpparseckyGraphN) -> NlpparseckyGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_parse_cky_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_parse_cky_graphn_copy(s : NlpparseckyGraphN) -> NlpparseckyGraphN {
  let result = nlp_parse_cky_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_parse_cky_graphn_fill(s : NlpparseckyGraphN, v : Double) -> NlpparseckyGraphN {
  let result = nlp_parse_cky_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_cky_graphn_min(s : NlpparseckyGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_cky_graphn_max(s : NlpparseckyGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_cky_graphn_to_string(s : NlpparseckyGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparseckyNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_cky_node_make(size : Int) -> NlpparseckyNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_cky_node_len(s : NlpparseckyNode) -> Int { s.size }

pub fn nlp_parse_cky_node_get(s : NlpparseckyNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_cky_node_set(s : NlpparseckyNode, i : Int, v : Double) -> NlpparseckyNode {
  let result = nlp_parse_cky_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_cky_node_sum(s : NlpparseckyNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_parse_cky_node_mean(s : NlpparseckyNode) -> Double {
  if s.size == 0 { 0.0 } else { nlp_parse_cky_node_sum(s) / s.size.to_double() }
}

pub fn nlp_parse_cky_node_scale(s : NlpparseckyNode, f : Double) -> NlpparseckyNode {
  let result = nlp_parse_cky_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_parse_cky_node_add(a : NlpparseckyNode, b : NlpparseckyNode) -> NlpparseckyNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_parse_cky_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_parse_cky_node_copy(s : NlpparseckyNode) -> NlpparseckyNode {
  let result = nlp_parse_cky_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_parse_cky_node_fill(s : NlpparseckyNode, v : Double) -> NlpparseckyNode {
  let result = nlp_parse_cky_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_cky_node_min(s : NlpparseckyNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_cky_node_max(s : NlpparseckyNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_cky_node_to_string(s : NlpparseckyNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparseckyEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_cky_edge_make(size : Int) -> NlpparseckyEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_cky_edge_len(s : NlpparseckyEdge) -> Int { s.size }

pub fn nlp_parse_cky_edge_get(s : NlpparseckyEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_cky_edge_set(s : NlpparseckyEdge, i : Int, v : Double) -> NlpparseckyEdge {
  let result = nlp_parse_cky_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_cky_edge_sum(s : NlpparseckyEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_parse_cky_edge_mean(s : NlpparseckyEdge) -> Double {
  if s.size == 0 { 0.0 } else { nlp_parse_cky_edge_sum(s) / s.size.to_double() }
}

pub fn nlp_parse_cky_edge_scale(s : NlpparseckyEdge, f : Double) -> NlpparseckyEdge {
  let result = nlp_parse_cky_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_parse_cky_edge_add(a : NlpparseckyEdge, b : NlpparseckyEdge) -> NlpparseckyEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_parse_cky_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_parse_cky_edge_copy(s : NlpparseckyEdge) -> NlpparseckyEdge {
  let result = nlp_parse_cky_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_parse_cky_edge_fill(s : NlpparseckyEdge, v : Double) -> NlpparseckyEdge {
  let result = nlp_parse_cky_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_cky_edge_min(s : NlpparseckyEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_cky_edge_max(s : NlpparseckyEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_cky_edge_to_string(s : NlpparseckyEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparseckyPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_cky_path_make(size : Int) -> NlpparseckyPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_cky_path_len(s : NlpparseckyPath) -> Int { s.size }

pub fn nlp_parse_cky_path_get(s : NlpparseckyPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_cky_path_set(s : NlpparseckyPath, i : Int, v : Double) -> NlpparseckyPath {
  let result = nlp_parse_cky_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_cky_path_sum(s : NlpparseckyPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_parse_cky_path_mean(s : NlpparseckyPath) -> Double {
  if s.size == 0 { 0.0 } else { nlp_parse_cky_path_sum(s) / s.size.to_double() }
}

pub fn nlp_parse_cky_path_scale(s : NlpparseckyPath, f : Double) -> NlpparseckyPath {
  let result = nlp_parse_cky_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_parse_cky_path_add(a : NlpparseckyPath, b : NlpparseckyPath) -> NlpparseckyPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_parse_cky_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_parse_cky_path_copy(s : NlpparseckyPath) -> NlpparseckyPath {
  let result = nlp_parse_cky_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_parse_cky_path_fill(s : NlpparseckyPath, v : Double) -> NlpparseckyPath {
  let result = nlp_parse_cky_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_cky_path_min(s : NlpparseckyPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_cky_path_max(s : NlpparseckyPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_cky_path_to_string(s : NlpparseckyPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparseckyCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_cky_cluster_make(size : Int) -> NlpparseckyCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_cky_cluster_len(s : NlpparseckyCluster) -> Int { s.size }

pub fn nlp_parse_cky_cluster_get(s : NlpparseckyCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_cky_cluster_set(s : NlpparseckyCluster, i : Int, v : Double) -> NlpparseckyCluster {
  let result = nlp_parse_cky_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_cky_cluster_sum(s : NlpparseckyCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_parse_cky_cluster_mean(s : NlpparseckyCluster) -> Double {
  if s.size == 0 { 0.0 } else { nlp_parse_cky_cluster_sum(s) / s.size.to_double() }
}

pub fn nlp_parse_cky_cluster_scale(s : NlpparseckyCluster, f : Double) -> NlpparseckyCluster {
  let result = nlp_parse_cky_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_parse_cky_cluster_add(a : NlpparseckyCluster, b : NlpparseckyCluster) -> NlpparseckyCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_parse_cky_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_parse_cky_cluster_copy(s : NlpparseckyCluster) -> NlpparseckyCluster {
  let result = nlp_parse_cky_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_parse_cky_cluster_fill(s : NlpparseckyCluster, v : Double) -> NlpparseckyCluster {
  let result = nlp_parse_cky_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_cky_cluster_min(s : NlpparseckyCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_cky_cluster_max(s : NlpparseckyCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_cky_cluster_to_string(s : NlpparseckyCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparseckyModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_cky_model_make(size : Int) -> NlpparseckyModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_cky_model_len(s : NlpparseckyModel) -> Int { s.size }

pub fn nlp_parse_cky_model_get(s : NlpparseckyModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_cky_model_set(s : NlpparseckyModel, i : Int, v : Double) -> NlpparseckyModel {
  let result = nlp_parse_cky_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_cky_model_sum(s : NlpparseckyModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_parse_cky_model_mean(s : NlpparseckyModel) -> Double {
  if s.size == 0 { 0.0 } else { nlp_parse_cky_model_sum(s) / s.size.to_double() }
}

pub fn nlp_parse_cky_model_scale(s : NlpparseckyModel, f : Double) -> NlpparseckyModel {
  let result = nlp_parse_cky_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_parse_cky_model_add(a : NlpparseckyModel, b : NlpparseckyModel) -> NlpparseckyModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_parse_cky_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_parse_cky_model_copy(s : NlpparseckyModel) -> NlpparseckyModel {
  let result = nlp_parse_cky_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_parse_cky_model_fill(s : NlpparseckyModel, v : Double) -> NlpparseckyModel {
  let result = nlp_parse_cky_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_cky_model_min(s : NlpparseckyModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_cky_model_max(s : NlpparseckyModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_cky_model_to_string(s : NlpparseckyModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparseckyLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_cky_layer_make(size : Int) -> NlpparseckyLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_cky_layer_len(s : NlpparseckyLayer) -> Int { s.size }

pub fn nlp_parse_cky_layer_get(s : NlpparseckyLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_cky_layer_set(s : NlpparseckyLayer, i : Int, v : Double) -> NlpparseckyLayer {
  let result = nlp_parse_cky_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_cky_layer_sum(s : NlpparseckyLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_parse_cky_layer_mean(s : NlpparseckyLayer) -> Double {
  if s.size == 0 { 0.0 } else { nlp_parse_cky_layer_sum(s) / s.size.to_double() }
}

pub fn nlp_parse_cky_layer_scale(s : NlpparseckyLayer, f : Double) -> NlpparseckyLayer {
  let result = nlp_parse_cky_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_parse_cky_layer_add(a : NlpparseckyLayer, b : NlpparseckyLayer) -> NlpparseckyLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_parse_cky_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_parse_cky_layer_copy(s : NlpparseckyLayer) -> NlpparseckyLayer {
  let result = nlp_parse_cky_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_parse_cky_layer_fill(s : NlpparseckyLayer, v : Double) -> NlpparseckyLayer {
  let result = nlp_parse_cky_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_cky_layer_min(s : NlpparseckyLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_cky_layer_max(s : NlpparseckyLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_cky_layer_to_string(s : NlpparseckyLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparseckyBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_cky_buffer_make(size : Int) -> NlpparseckyBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_cky_buffer_len(s : NlpparseckyBuffer) -> Int { s.size }

pub fn nlp_parse_cky_buffer_get(s : NlpparseckyBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_cky_buffer_set(s : NlpparseckyBuffer, i : Int, v : Double) -> NlpparseckyBuffer {
  let result = nlp_parse_cky_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_cky_buffer_sum(s : NlpparseckyBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_parse_cky_buffer_mean(s : NlpparseckyBuffer) -> Double {
  if s.size == 0 { 0.0 } else { nlp_parse_cky_buffer_sum(s) / s.size.to_double() }
}

pub fn nlp_parse_cky_buffer_scale(s : NlpparseckyBuffer, f : Double) -> NlpparseckyBuffer {
  let result = nlp_parse_cky_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_parse_cky_buffer_add(a : NlpparseckyBuffer, b : NlpparseckyBuffer) -> NlpparseckyBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_parse_cky_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_parse_cky_buffer_copy(s : NlpparseckyBuffer) -> NlpparseckyBuffer {
  let result = nlp_parse_cky_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_parse_cky_buffer_fill(s : NlpparseckyBuffer, v : Double) -> NlpparseckyBuffer {
  let result = nlp_parse_cky_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_cky_buffer_min(s : NlpparseckyBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_cky_buffer_max(s : NlpparseckyBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_cky_buffer_to_string(s : NlpparseckyBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparseckyCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_cky_cursor_make(size : Int) -> NlpparseckyCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_cky_cursor_len(s : NlpparseckyCursor) -> Int { s.size }

pub fn nlp_parse_cky_cursor_get(s : NlpparseckyCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_cky_cursor_set(s : NlpparseckyCursor, i : Int, v : Double) -> NlpparseckyCursor {
  let result = nlp_parse_cky_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_cky_cursor_sum(s : NlpparseckyCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_parse_cky_cursor_mean(s : NlpparseckyCursor) -> Double {
  if s.size == 0 { 0.0 } else { nlp_parse_cky_cursor_sum(s) / s.size.to_double() }
}

pub fn nlp_parse_cky_cursor_scale(s : NlpparseckyCursor, f : Double) -> NlpparseckyCursor {
  let result = nlp_parse_cky_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_parse_cky_cursor_add(a : NlpparseckyCursor, b : NlpparseckyCursor) -> NlpparseckyCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_parse_cky_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_parse_cky_cursor_copy(s : NlpparseckyCursor) -> NlpparseckyCursor {
  let result = nlp_parse_cky_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_parse_cky_cursor_fill(s : NlpparseckyCursor, v : Double) -> NlpparseckyCursor {
  let result = nlp_parse_cky_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_cky_cursor_min(s : NlpparseckyCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_cky_cursor_max(s : NlpparseckyCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_cky_cursor_to_string(s : NlpparseckyCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparseckyView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_cky_view_make(size : Int) -> NlpparseckyView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_cky_view_len(s : NlpparseckyView) -> Int { s.size }

pub fn nlp_parse_cky_view_get(s : NlpparseckyView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_cky_view_set(s : NlpparseckyView, i : Int, v : Double) -> NlpparseckyView {
  let result = nlp_parse_cky_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_cky_view_sum(s : NlpparseckyView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_parse_cky_view_mean(s : NlpparseckyView) -> Double {
  if s.size == 0 { 0.0 } else { nlp_parse_cky_view_sum(s) / s.size.to_double() }
}

pub fn nlp_parse_cky_view_scale(s : NlpparseckyView, f : Double) -> NlpparseckyView {
  let result = nlp_parse_cky_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_parse_cky_view_add(a : NlpparseckyView, b : NlpparseckyView) -> NlpparseckyView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_parse_cky_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_parse_cky_view_copy(s : NlpparseckyView) -> NlpparseckyView {
  let result = nlp_parse_cky_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_parse_cky_view_fill(s : NlpparseckyView, v : Double) -> NlpparseckyView {
  let result = nlp_parse_cky_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_cky_view_min(s : NlpparseckyView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_cky_view_max(s : NlpparseckyView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_cky_view_to_string(s : NlpparseckyView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparseckyRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_cky_range_make(size : Int) -> NlpparseckyRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_cky_range_len(s : NlpparseckyRange) -> Int { s.size }

pub fn nlp_parse_cky_range_get(s : NlpparseckyRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_cky_range_set(s : NlpparseckyRange, i : Int, v : Double) -> NlpparseckyRange {
  let result = nlp_parse_cky_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_cky_range_sum(s : NlpparseckyRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_parse_cky_range_mean(s : NlpparseckyRange) -> Double {
  if s.size == 0 { 0.0 } else { nlp_parse_cky_range_sum(s) / s.size.to_double() }
}

pub fn nlp_parse_cky_range_scale(s : NlpparseckyRange, f : Double) -> NlpparseckyRange {
  let result = nlp_parse_cky_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_parse_cky_range_add(a : NlpparseckyRange, b : NlpparseckyRange) -> NlpparseckyRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_parse_cky_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_parse_cky_range_copy(s : NlpparseckyRange) -> NlpparseckyRange {
  let result = nlp_parse_cky_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_parse_cky_range_fill(s : NlpparseckyRange, v : Double) -> NlpparseckyRange {
  let result = nlp_parse_cky_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_cky_range_min(s : NlpparseckyRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_cky_range_max(s : NlpparseckyRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_cky_range_to_string(s : NlpparseckyRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparseckySlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_cky_slice_make(size : Int) -> NlpparseckySlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_cky_slice_len(s : NlpparseckySlice) -> Int { s.size }

pub fn nlp_parse_cky_slice_get(s : NlpparseckySlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_cky_slice_set(s : NlpparseckySlice, i : Int, v : Double) -> NlpparseckySlice {
  let result = nlp_parse_cky_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_cky_slice_sum(s : NlpparseckySlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_parse_cky_slice_mean(s : NlpparseckySlice) -> Double {
  if s.size == 0 { 0.0 } else { nlp_parse_cky_slice_sum(s) / s.size.to_double() }
}

pub fn nlp_parse_cky_slice_scale(s : NlpparseckySlice, f : Double) -> NlpparseckySlice {
  let result = nlp_parse_cky_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_parse_cky_slice_add(a : NlpparseckySlice, b : NlpparseckySlice) -> NlpparseckySlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_parse_cky_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_parse_cky_slice_copy(s : NlpparseckySlice) -> NlpparseckySlice {
  let result = nlp_parse_cky_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_parse_cky_slice_fill(s : NlpparseckySlice, v : Double) -> NlpparseckySlice {
  let result = nlp_parse_cky_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_cky_slice_min(s : NlpparseckySlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_cky_slice_max(s : NlpparseckySlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_cky_slice_to_string(s : NlpparseckySlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

