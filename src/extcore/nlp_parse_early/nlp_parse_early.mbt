///===
/// extcore/nlp_parse_early

pub(all) struct NlpparseearlyPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn nlp_parse_early_make_point(x : Double, y : Double) -> NlpparseearlyPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn nlp_parse_early_make_point3(x : Double, y : Double, z : Double) -> NlpparseearlyPoint {
  { x, y, z, label: 0 }
}

pub fn nlp_parse_early_point_x(pt : NlpparseearlyPoint) -> Double { pt.x }

pub fn nlp_parse_early_point_y(pt : NlpparseearlyPoint) -> Double { pt.y }

pub fn nlp_parse_early_point_z(pt : NlpparseearlyPoint) -> Double { pt.z }

pub fn nlp_parse_early_point_label(pt : NlpparseearlyPoint) -> Int { pt.label }

pub fn nlp_parse_early_point_dist(a : NlpparseearlyPoint, b : NlpparseearlyPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn nlp_parse_early_point_add(a : NlpparseearlyPoint, b : NlpparseearlyPoint) -> NlpparseearlyPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn nlp_parse_early_point_sub(a : NlpparseearlyPoint, b : NlpparseearlyPoint) -> NlpparseearlyPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn nlp_parse_early_point_scale(pt : NlpparseearlyPoint, s : Double) -> NlpparseearlyPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn nlp_parse_early_point_dot(a : NlpparseearlyPoint, b : NlpparseearlyPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn nlp_parse_early_point_cross(a : NlpparseearlyPoint, b : NlpparseearlyPoint) -> NlpparseearlyPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn nlp_parse_early_point_norm(pt : NlpparseearlyPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn nlp_parse_early_point_normalize(pt : NlpparseearlyPoint) -> NlpparseearlyPoint {
  let n = nlp_parse_early_point_norm(pt)
  if n < 0.0000001 { pt } else { nlp_parse_early_point_scale(pt, 1.0 / n) }
}

pub fn nlp_parse_early_point_negate(pt : NlpparseearlyPoint) -> NlpparseearlyPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn nlp_parse_early_point_mid(a : NlpparseearlyPoint, b : NlpparseearlyPoint) -> NlpparseearlyPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn nlp_parse_early_point_lerp(a : NlpparseearlyPoint, b : NlpparseearlyPoint, t : Double) -> NlpparseearlyPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn nlp_parse_early_point_to_string(pt : NlpparseearlyPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct NlpparseearlySeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn nlp_parse_early_make_series(vals : Array[Double], name : String) -> NlpparseearlySeries {
  { vals, name, meta: 0 }
}

pub fn nlp_parse_early_series_len(s : NlpparseearlySeries) -> Int { s.vals.length() }

pub fn nlp_parse_early_series_sum(s : NlpparseearlySeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn nlp_parse_early_series_mean(s : NlpparseearlySeries) -> Double {
  let n = nlp_parse_early_series_len(s)
  if n == 0 { 0.0 } else { nlp_parse_early_series_sum(s) / n.to_double() }
}

pub fn nlp_parse_early_series_min(s : NlpparseearlySeries) -> Double {
  let n = nlp_parse_early_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn nlp_parse_early_series_max(s : NlpparseearlySeries) -> Double {
  let n = nlp_parse_early_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn nlp_parse_early_series_range(s : NlpparseearlySeries) -> Double {
  nlp_parse_early_series_max(s) - nlp_parse_early_series_min(s)
}

pub fn nlp_parse_early_series_var(s : NlpparseearlySeries) -> Double {
  let n = nlp_parse_early_series_len(s)
  if n == 0 { 0.0 } else {
    let m = nlp_parse_early_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn nlp_parse_early_series_std(s : NlpparseearlySeries) -> Double { @_common.sqrt(nlp_parse_early_series_var(s)) }

pub fn nlp_parse_early_series_median(s : NlpparseearlySeries) -> Double {
  let n = nlp_parse_early_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = nlp_parse_early_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn nlp_parse_early_series_scale(s : NlpparseearlySeries, f : Double) -> NlpparseearlySeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn nlp_parse_early_series_add(a : NlpparseearlySeries, b : NlpparseearlySeries) -> NlpparseearlySeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn nlp_parse_early_series_sub(a : NlpparseearlySeries, b : NlpparseearlySeries) -> NlpparseearlySeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn nlp_parse_early_series_normalize(s : NlpparseearlySeries) -> NlpparseearlySeries {
  let mn = nlp_parse_early_series_min(s)
  let mx = nlp_parse_early_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn nlp_parse_early_series_cumsum(s : NlpparseearlySeries) -> NlpparseearlySeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn nlp_parse_early_series_to_string(s : NlpparseearlySeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NlpparseearlyMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn nlp_parse_early_make_matrix(rows : Int, cols : Int, val : Double) -> NlpparseearlyMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn nlp_parse_early_matrix_identity(n : Int) -> NlpparseearlyMatrix {
  let m = nlp_parse_early_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn nlp_parse_early_matrix_get(m : NlpparseearlyMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn nlp_parse_early_matrix_transpose(m : NlpparseearlyMatrix) -> NlpparseearlyMatrix {
  let result = nlp_parse_early_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn nlp_parse_early_matrix_add(a : NlpparseearlyMatrix, b : NlpparseearlyMatrix) -> NlpparseearlyMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = nlp_parse_early_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn nlp_parse_early_matrix_scale(m : NlpparseearlyMatrix, s : Double) -> NlpparseearlyMatrix {
  let result = nlp_parse_early_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn nlp_parse_early_matrix_multiply(a : NlpparseearlyMatrix, b : NlpparseearlyMatrix) -> NlpparseearlyMatrix {
  if a.cols != b.rows { return nlp_parse_early_make_matrix(a.rows, b.cols, 0.0) }
  let result = nlp_parse_early_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn nlp_parse_early_matrix_trace(m : NlpparseearlyMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn nlp_parse_early_matrix_det(m : NlpparseearlyMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn nlp_parse_early_matrix_norm(m : NlpparseearlyMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn nlp_parse_early_matrix_to_string(m : NlpparseearlyMatrix) -> String {
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

pub(all) struct NlpparseearlyVector {
  comps : Array[Double]
  dim : Int
}

pub fn nlp_parse_early_make_vector(comps : Array[Double]) -> NlpparseearlyVector {
  { comps, dim: comps.length() }
}

pub fn nlp_parse_early_vector_zero(dim : Int) -> NlpparseearlyVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn nlp_parse_early_vector_add(a : NlpparseearlyVector, b : NlpparseearlyVector) -> NlpparseearlyVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn nlp_parse_early_vector_sub(a : NlpparseearlyVector, b : NlpparseearlyVector) -> NlpparseearlyVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn nlp_parse_early_vector_scale(v : NlpparseearlyVector, s : Double) -> NlpparseearlyVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn nlp_parse_early_vector_dot(a : NlpparseearlyVector, b : NlpparseearlyVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn nlp_parse_early_vector_norm(v : NlpparseearlyVector) -> Double { @_common.sqrt(nlp_parse_early_vector_dot(v, v)) }

pub fn nlp_parse_early_vector_normalize(v : NlpparseearlyVector) -> NlpparseearlyVector {
  let n = nlp_parse_early_vector_norm(v)
  if n < 0.0000001 { v } else { nlp_parse_early_vector_scale(v, 1.0 / n) }
}

pub fn nlp_parse_early_vector_dist(a : NlpparseearlyVector, b : NlpparseearlyVector) -> Double {
  nlp_parse_early_vector_norm(nlp_parse_early_vector_sub(a, b))
}

pub fn nlp_parse_early_vector_to_string(v : NlpparseearlyVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn nlp_parse_early_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn nlp_parse_early_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = nlp_parse_early_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn nlp_parse_early_std(data : Array[Double]) -> Double { @_common.sqrt(nlp_parse_early_var(data)) }

pub fn nlp_parse_early_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = nlp_parse_early_mean(a); let mb = nlp_parse_early_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn nlp_parse_early_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = nlp_parse_early_std(a); let sb = nlp_parse_early_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { nlp_parse_early_cov(a, b) / (sa * sb) }
}

pub fn nlp_parse_early_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = nlp_parse_early_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn nlp_parse_early_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn nlp_parse_early_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn nlp_parse_early_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  @_common.sqrt(nlp_parse_early_mse(pred, labels))
}

pub fn nlp_parse_early_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn nlp_parse_early_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = nlp_parse_early_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn nlp_parse_early_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn nlp_parse_early_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn nlp_parse_early_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = nlp_parse_early_precision(pred, labels, pos); let r = nlp_parse_early_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn nlp_parse_early_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn nlp_parse_early_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = nlp_parse_early_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn nlp_parse_early_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn nlp_parse_early_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn nlp_parse_early_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = nlp_parse_early_gcd(a, b)
    (a / g) * b
  }
}

pub fn nlp_parse_early_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn nlp_parse_early_fibonacci(n : Int) -> Int {
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

pub fn nlp_parse_early_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = nlp_parse_early_min(data); let mx = nlp_parse_early_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn nlp_parse_early_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = nlp_parse_early_mean(data); let sd = nlp_parse_early_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn nlp_parse_early_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn nlp_parse_early_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn nlp_parse_early_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn nlp_parse_early_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn nlp_parse_early_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn nlp_parse_early_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

pub(all) struct NlpparseearlyFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_early_frame_make(size : Int) -> NlpparseearlyFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_early_frame_len(s : NlpparseearlyFrame) -> Int { s.size }

pub fn nlp_parse_early_frame_get(s : NlpparseearlyFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_early_frame_set(s : NlpparseearlyFrame, i : Int, v : Double) -> NlpparseearlyFrame {
  let result = nlp_parse_early_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_early_frame_sum(s : NlpparseearlyFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_parse_early_frame_mean(s : NlpparseearlyFrame) -> Double {
  if s.size == 0 { 0.0 } else { nlp_parse_early_frame_sum(s) / s.size.to_double() }
}

pub fn nlp_parse_early_frame_scale(s : NlpparseearlyFrame, f : Double) -> NlpparseearlyFrame {
  let result = nlp_parse_early_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_parse_early_frame_add(a : NlpparseearlyFrame, b : NlpparseearlyFrame) -> NlpparseearlyFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_parse_early_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_parse_early_frame_copy(s : NlpparseearlyFrame) -> NlpparseearlyFrame {
  let result = nlp_parse_early_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_parse_early_frame_fill(s : NlpparseearlyFrame, v : Double) -> NlpparseearlyFrame {
  let result = nlp_parse_early_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_early_frame_min(s : NlpparseearlyFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_early_frame_max(s : NlpparseearlyFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_early_frame_to_string(s : NlpparseearlyFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparseearlyTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_early_table_make(size : Int) -> NlpparseearlyTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_early_table_len(s : NlpparseearlyTable) -> Int { s.size }

pub fn nlp_parse_early_table_get(s : NlpparseearlyTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_early_table_set(s : NlpparseearlyTable, i : Int, v : Double) -> NlpparseearlyTable {
  let result = nlp_parse_early_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_early_table_sum(s : NlpparseearlyTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_parse_early_table_mean(s : NlpparseearlyTable) -> Double {
  if s.size == 0 { 0.0 } else { nlp_parse_early_table_sum(s) / s.size.to_double() }
}

pub fn nlp_parse_early_table_scale(s : NlpparseearlyTable, f : Double) -> NlpparseearlyTable {
  let result = nlp_parse_early_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_parse_early_table_add(a : NlpparseearlyTable, b : NlpparseearlyTable) -> NlpparseearlyTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_parse_early_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_parse_early_table_copy(s : NlpparseearlyTable) -> NlpparseearlyTable {
  let result = nlp_parse_early_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_parse_early_table_fill(s : NlpparseearlyTable, v : Double) -> NlpparseearlyTable {
  let result = nlp_parse_early_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_early_table_min(s : NlpparseearlyTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_early_table_max(s : NlpparseearlyTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_early_table_to_string(s : NlpparseearlyTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparseearlyGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_early_graphn_make(size : Int) -> NlpparseearlyGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_early_graphn_len(s : NlpparseearlyGraphN) -> Int { s.size }

pub fn nlp_parse_early_graphn_get(s : NlpparseearlyGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_early_graphn_set(s : NlpparseearlyGraphN, i : Int, v : Double) -> NlpparseearlyGraphN {
  let result = nlp_parse_early_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_early_graphn_sum(s : NlpparseearlyGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_parse_early_graphn_mean(s : NlpparseearlyGraphN) -> Double {
  if s.size == 0 { 0.0 } else { nlp_parse_early_graphn_sum(s) / s.size.to_double() }
}

pub fn nlp_parse_early_graphn_scale(s : NlpparseearlyGraphN, f : Double) -> NlpparseearlyGraphN {
  let result = nlp_parse_early_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_parse_early_graphn_add(a : NlpparseearlyGraphN, b : NlpparseearlyGraphN) -> NlpparseearlyGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_parse_early_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_parse_early_graphn_copy(s : NlpparseearlyGraphN) -> NlpparseearlyGraphN {
  let result = nlp_parse_early_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_parse_early_graphn_fill(s : NlpparseearlyGraphN, v : Double) -> NlpparseearlyGraphN {
  let result = nlp_parse_early_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_early_graphn_min(s : NlpparseearlyGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_early_graphn_max(s : NlpparseearlyGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_early_graphn_to_string(s : NlpparseearlyGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparseearlyNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_early_node_make(size : Int) -> NlpparseearlyNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_early_node_len(s : NlpparseearlyNode) -> Int { s.size }

pub fn nlp_parse_early_node_get(s : NlpparseearlyNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_early_node_set(s : NlpparseearlyNode, i : Int, v : Double) -> NlpparseearlyNode {
  let result = nlp_parse_early_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_early_node_sum(s : NlpparseearlyNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_parse_early_node_mean(s : NlpparseearlyNode) -> Double {
  if s.size == 0 { 0.0 } else { nlp_parse_early_node_sum(s) / s.size.to_double() }
}

pub fn nlp_parse_early_node_scale(s : NlpparseearlyNode, f : Double) -> NlpparseearlyNode {
  let result = nlp_parse_early_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_parse_early_node_add(a : NlpparseearlyNode, b : NlpparseearlyNode) -> NlpparseearlyNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_parse_early_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_parse_early_node_copy(s : NlpparseearlyNode) -> NlpparseearlyNode {
  let result = nlp_parse_early_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_parse_early_node_fill(s : NlpparseearlyNode, v : Double) -> NlpparseearlyNode {
  let result = nlp_parse_early_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_early_node_min(s : NlpparseearlyNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_early_node_max(s : NlpparseearlyNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_early_node_to_string(s : NlpparseearlyNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparseearlyEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_early_edge_make(size : Int) -> NlpparseearlyEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_early_edge_len(s : NlpparseearlyEdge) -> Int { s.size }

pub fn nlp_parse_early_edge_get(s : NlpparseearlyEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_early_edge_set(s : NlpparseearlyEdge, i : Int, v : Double) -> NlpparseearlyEdge {
  let result = nlp_parse_early_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_early_edge_sum(s : NlpparseearlyEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_parse_early_edge_mean(s : NlpparseearlyEdge) -> Double {
  if s.size == 0 { 0.0 } else { nlp_parse_early_edge_sum(s) / s.size.to_double() }
}

pub fn nlp_parse_early_edge_scale(s : NlpparseearlyEdge, f : Double) -> NlpparseearlyEdge {
  let result = nlp_parse_early_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_parse_early_edge_add(a : NlpparseearlyEdge, b : NlpparseearlyEdge) -> NlpparseearlyEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_parse_early_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_parse_early_edge_copy(s : NlpparseearlyEdge) -> NlpparseearlyEdge {
  let result = nlp_parse_early_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_parse_early_edge_fill(s : NlpparseearlyEdge, v : Double) -> NlpparseearlyEdge {
  let result = nlp_parse_early_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_early_edge_min(s : NlpparseearlyEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_early_edge_max(s : NlpparseearlyEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_early_edge_to_string(s : NlpparseearlyEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparseearlyPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_early_path_make(size : Int) -> NlpparseearlyPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_early_path_len(s : NlpparseearlyPath) -> Int { s.size }

pub fn nlp_parse_early_path_get(s : NlpparseearlyPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_early_path_set(s : NlpparseearlyPath, i : Int, v : Double) -> NlpparseearlyPath {
  let result = nlp_parse_early_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_early_path_sum(s : NlpparseearlyPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_parse_early_path_mean(s : NlpparseearlyPath) -> Double {
  if s.size == 0 { 0.0 } else { nlp_parse_early_path_sum(s) / s.size.to_double() }
}

pub fn nlp_parse_early_path_scale(s : NlpparseearlyPath, f : Double) -> NlpparseearlyPath {
  let result = nlp_parse_early_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_parse_early_path_add(a : NlpparseearlyPath, b : NlpparseearlyPath) -> NlpparseearlyPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_parse_early_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_parse_early_path_copy(s : NlpparseearlyPath) -> NlpparseearlyPath {
  let result = nlp_parse_early_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_parse_early_path_fill(s : NlpparseearlyPath, v : Double) -> NlpparseearlyPath {
  let result = nlp_parse_early_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_early_path_min(s : NlpparseearlyPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_early_path_max(s : NlpparseearlyPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_early_path_to_string(s : NlpparseearlyPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparseearlyCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_early_cluster_make(size : Int) -> NlpparseearlyCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_early_cluster_len(s : NlpparseearlyCluster) -> Int { s.size }

pub fn nlp_parse_early_cluster_get(s : NlpparseearlyCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_early_cluster_set(s : NlpparseearlyCluster, i : Int, v : Double) -> NlpparseearlyCluster {
  let result = nlp_parse_early_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_early_cluster_sum(s : NlpparseearlyCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_parse_early_cluster_mean(s : NlpparseearlyCluster) -> Double {
  if s.size == 0 { 0.0 } else { nlp_parse_early_cluster_sum(s) / s.size.to_double() }
}

pub fn nlp_parse_early_cluster_scale(s : NlpparseearlyCluster, f : Double) -> NlpparseearlyCluster {
  let result = nlp_parse_early_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_parse_early_cluster_add(a : NlpparseearlyCluster, b : NlpparseearlyCluster) -> NlpparseearlyCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_parse_early_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_parse_early_cluster_copy(s : NlpparseearlyCluster) -> NlpparseearlyCluster {
  let result = nlp_parse_early_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_parse_early_cluster_fill(s : NlpparseearlyCluster, v : Double) -> NlpparseearlyCluster {
  let result = nlp_parse_early_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_early_cluster_min(s : NlpparseearlyCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_early_cluster_max(s : NlpparseearlyCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_early_cluster_to_string(s : NlpparseearlyCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparseearlyModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_early_model_make(size : Int) -> NlpparseearlyModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_early_model_len(s : NlpparseearlyModel) -> Int { s.size }

pub fn nlp_parse_early_model_get(s : NlpparseearlyModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_early_model_set(s : NlpparseearlyModel, i : Int, v : Double) -> NlpparseearlyModel {
  let result = nlp_parse_early_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_early_model_sum(s : NlpparseearlyModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_parse_early_model_mean(s : NlpparseearlyModel) -> Double {
  if s.size == 0 { 0.0 } else { nlp_parse_early_model_sum(s) / s.size.to_double() }
}

pub fn nlp_parse_early_model_scale(s : NlpparseearlyModel, f : Double) -> NlpparseearlyModel {
  let result = nlp_parse_early_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_parse_early_model_add(a : NlpparseearlyModel, b : NlpparseearlyModel) -> NlpparseearlyModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_parse_early_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_parse_early_model_copy(s : NlpparseearlyModel) -> NlpparseearlyModel {
  let result = nlp_parse_early_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_parse_early_model_fill(s : NlpparseearlyModel, v : Double) -> NlpparseearlyModel {
  let result = nlp_parse_early_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_early_model_min(s : NlpparseearlyModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_early_model_max(s : NlpparseearlyModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_early_model_to_string(s : NlpparseearlyModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparseearlyLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_early_layer_make(size : Int) -> NlpparseearlyLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_early_layer_len(s : NlpparseearlyLayer) -> Int { s.size }

pub fn nlp_parse_early_layer_get(s : NlpparseearlyLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_early_layer_set(s : NlpparseearlyLayer, i : Int, v : Double) -> NlpparseearlyLayer {
  let result = nlp_parse_early_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_early_layer_sum(s : NlpparseearlyLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_parse_early_layer_mean(s : NlpparseearlyLayer) -> Double {
  if s.size == 0 { 0.0 } else { nlp_parse_early_layer_sum(s) / s.size.to_double() }
}

pub fn nlp_parse_early_layer_scale(s : NlpparseearlyLayer, f : Double) -> NlpparseearlyLayer {
  let result = nlp_parse_early_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_parse_early_layer_add(a : NlpparseearlyLayer, b : NlpparseearlyLayer) -> NlpparseearlyLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_parse_early_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_parse_early_layer_copy(s : NlpparseearlyLayer) -> NlpparseearlyLayer {
  let result = nlp_parse_early_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_parse_early_layer_fill(s : NlpparseearlyLayer, v : Double) -> NlpparseearlyLayer {
  let result = nlp_parse_early_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_early_layer_min(s : NlpparseearlyLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_early_layer_max(s : NlpparseearlyLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_early_layer_to_string(s : NlpparseearlyLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparseearlyBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_early_buffer_make(size : Int) -> NlpparseearlyBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_early_buffer_len(s : NlpparseearlyBuffer) -> Int { s.size }

pub fn nlp_parse_early_buffer_get(s : NlpparseearlyBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_early_buffer_set(s : NlpparseearlyBuffer, i : Int, v : Double) -> NlpparseearlyBuffer {
  let result = nlp_parse_early_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_early_buffer_sum(s : NlpparseearlyBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_parse_early_buffer_mean(s : NlpparseearlyBuffer) -> Double {
  if s.size == 0 { 0.0 } else { nlp_parse_early_buffer_sum(s) / s.size.to_double() }
}

pub fn nlp_parse_early_buffer_scale(s : NlpparseearlyBuffer, f : Double) -> NlpparseearlyBuffer {
  let result = nlp_parse_early_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_parse_early_buffer_add(a : NlpparseearlyBuffer, b : NlpparseearlyBuffer) -> NlpparseearlyBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_parse_early_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_parse_early_buffer_copy(s : NlpparseearlyBuffer) -> NlpparseearlyBuffer {
  let result = nlp_parse_early_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_parse_early_buffer_fill(s : NlpparseearlyBuffer, v : Double) -> NlpparseearlyBuffer {
  let result = nlp_parse_early_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_early_buffer_min(s : NlpparseearlyBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_early_buffer_max(s : NlpparseearlyBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_early_buffer_to_string(s : NlpparseearlyBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparseearlyCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_early_cursor_make(size : Int) -> NlpparseearlyCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_early_cursor_len(s : NlpparseearlyCursor) -> Int { s.size }

pub fn nlp_parse_early_cursor_get(s : NlpparseearlyCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_early_cursor_set(s : NlpparseearlyCursor, i : Int, v : Double) -> NlpparseearlyCursor {
  let result = nlp_parse_early_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_early_cursor_sum(s : NlpparseearlyCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_parse_early_cursor_mean(s : NlpparseearlyCursor) -> Double {
  if s.size == 0 { 0.0 } else { nlp_parse_early_cursor_sum(s) / s.size.to_double() }
}

pub fn nlp_parse_early_cursor_scale(s : NlpparseearlyCursor, f : Double) -> NlpparseearlyCursor {
  let result = nlp_parse_early_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_parse_early_cursor_add(a : NlpparseearlyCursor, b : NlpparseearlyCursor) -> NlpparseearlyCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_parse_early_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_parse_early_cursor_copy(s : NlpparseearlyCursor) -> NlpparseearlyCursor {
  let result = nlp_parse_early_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_parse_early_cursor_fill(s : NlpparseearlyCursor, v : Double) -> NlpparseearlyCursor {
  let result = nlp_parse_early_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_early_cursor_min(s : NlpparseearlyCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_early_cursor_max(s : NlpparseearlyCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_early_cursor_to_string(s : NlpparseearlyCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparseearlyView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_early_view_make(size : Int) -> NlpparseearlyView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_early_view_len(s : NlpparseearlyView) -> Int { s.size }

pub fn nlp_parse_early_view_get(s : NlpparseearlyView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_early_view_set(s : NlpparseearlyView, i : Int, v : Double) -> NlpparseearlyView {
  let result = nlp_parse_early_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_early_view_sum(s : NlpparseearlyView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_parse_early_view_mean(s : NlpparseearlyView) -> Double {
  if s.size == 0 { 0.0 } else { nlp_parse_early_view_sum(s) / s.size.to_double() }
}

pub fn nlp_parse_early_view_scale(s : NlpparseearlyView, f : Double) -> NlpparseearlyView {
  let result = nlp_parse_early_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_parse_early_view_add(a : NlpparseearlyView, b : NlpparseearlyView) -> NlpparseearlyView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_parse_early_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_parse_early_view_copy(s : NlpparseearlyView) -> NlpparseearlyView {
  let result = nlp_parse_early_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_parse_early_view_fill(s : NlpparseearlyView, v : Double) -> NlpparseearlyView {
  let result = nlp_parse_early_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_early_view_min(s : NlpparseearlyView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_early_view_max(s : NlpparseearlyView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_early_view_to_string(s : NlpparseearlyView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparseearlyRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_early_range_make(size : Int) -> NlpparseearlyRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_early_range_len(s : NlpparseearlyRange) -> Int { s.size }

pub fn nlp_parse_early_range_get(s : NlpparseearlyRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_early_range_set(s : NlpparseearlyRange, i : Int, v : Double) -> NlpparseearlyRange {
  let result = nlp_parse_early_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_early_range_sum(s : NlpparseearlyRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_parse_early_range_mean(s : NlpparseearlyRange) -> Double {
  if s.size == 0 { 0.0 } else { nlp_parse_early_range_sum(s) / s.size.to_double() }
}

pub fn nlp_parse_early_range_scale(s : NlpparseearlyRange, f : Double) -> NlpparseearlyRange {
  let result = nlp_parse_early_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_parse_early_range_add(a : NlpparseearlyRange, b : NlpparseearlyRange) -> NlpparseearlyRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_parse_early_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_parse_early_range_copy(s : NlpparseearlyRange) -> NlpparseearlyRange {
  let result = nlp_parse_early_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_parse_early_range_fill(s : NlpparseearlyRange, v : Double) -> NlpparseearlyRange {
  let result = nlp_parse_early_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_early_range_min(s : NlpparseearlyRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_early_range_max(s : NlpparseearlyRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_early_range_to_string(s : NlpparseearlyRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparseearlySlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_early_slice_make(size : Int) -> NlpparseearlySlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_early_slice_len(s : NlpparseearlySlice) -> Int { s.size }

pub fn nlp_parse_early_slice_get(s : NlpparseearlySlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_early_slice_set(s : NlpparseearlySlice, i : Int, v : Double) -> NlpparseearlySlice {
  let result = nlp_parse_early_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_early_slice_sum(s : NlpparseearlySlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_parse_early_slice_mean(s : NlpparseearlySlice) -> Double {
  if s.size == 0 { 0.0 } else { nlp_parse_early_slice_sum(s) / s.size.to_double() }
}

pub fn nlp_parse_early_slice_scale(s : NlpparseearlySlice, f : Double) -> NlpparseearlySlice {
  let result = nlp_parse_early_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_parse_early_slice_add(a : NlpparseearlySlice, b : NlpparseearlySlice) -> NlpparseearlySlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_parse_early_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_parse_early_slice_copy(s : NlpparseearlySlice) -> NlpparseearlySlice {
  let result = nlp_parse_early_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_parse_early_slice_fill(s : NlpparseearlySlice, v : Double) -> NlpparseearlySlice {
  let result = nlp_parse_early_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_early_slice_min(s : NlpparseearlySlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_early_slice_max(s : NlpparseearlySlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_early_slice_to_string(s : NlpparseearlySlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

