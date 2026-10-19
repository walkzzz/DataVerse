///===
/// extcore/nlp_pos_svm

pub(all) struct NlppossvmPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn nlp_pos_svm_make_point(x : Double, y : Double) -> NlppossvmPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn nlp_pos_svm_make_point3(x : Double, y : Double, z : Double) -> NlppossvmPoint {
  { x, y, z, label: 0 }
}

pub fn nlp_pos_svm_point_x(pt : NlppossvmPoint) -> Double { pt.x }

pub fn nlp_pos_svm_point_y(pt : NlppossvmPoint) -> Double { pt.y }

pub fn nlp_pos_svm_point_z(pt : NlppossvmPoint) -> Double { pt.z }

pub fn nlp_pos_svm_point_label(pt : NlppossvmPoint) -> Int { pt.label }

pub fn nlp_pos_svm_point_dist(a : NlppossvmPoint, b : NlppossvmPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn nlp_pos_svm_point_add(a : NlppossvmPoint, b : NlppossvmPoint) -> NlppossvmPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn nlp_pos_svm_point_sub(a : NlppossvmPoint, b : NlppossvmPoint) -> NlppossvmPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn nlp_pos_svm_point_scale(pt : NlppossvmPoint, s : Double) -> NlppossvmPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn nlp_pos_svm_point_dot(a : NlppossvmPoint, b : NlppossvmPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn nlp_pos_svm_point_cross(a : NlppossvmPoint, b : NlppossvmPoint) -> NlppossvmPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn nlp_pos_svm_point_norm(pt : NlppossvmPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn nlp_pos_svm_point_normalize(pt : NlppossvmPoint) -> NlppossvmPoint {
  let n = nlp_pos_svm_point_norm(pt)
  if n < 0.0000001 { pt } else { nlp_pos_svm_point_scale(pt, 1.0 / n) }
}

pub fn nlp_pos_svm_point_negate(pt : NlppossvmPoint) -> NlppossvmPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn nlp_pos_svm_point_mid(a : NlppossvmPoint, b : NlppossvmPoint) -> NlppossvmPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn nlp_pos_svm_point_lerp(a : NlppossvmPoint, b : NlppossvmPoint, t : Double) -> NlppossvmPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn nlp_pos_svm_point_to_string(pt : NlppossvmPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct NlppossvmSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn nlp_pos_svm_make_series(vals : Array[Double], name : String) -> NlppossvmSeries {
  { vals, name, meta: 0 }
}

pub fn nlp_pos_svm_series_len(s : NlppossvmSeries) -> Int { s.vals.length() }

pub fn nlp_pos_svm_series_sum(s : NlppossvmSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn nlp_pos_svm_series_mean(s : NlppossvmSeries) -> Double {
  let n = nlp_pos_svm_series_len(s)
  if n == 0 { 0.0 } else { nlp_pos_svm_series_sum(s) / n.to_double() }
}

pub fn nlp_pos_svm_series_min(s : NlppossvmSeries) -> Double {
  let n = nlp_pos_svm_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn nlp_pos_svm_series_max(s : NlppossvmSeries) -> Double {
  let n = nlp_pos_svm_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn nlp_pos_svm_series_range(s : NlppossvmSeries) -> Double {
  nlp_pos_svm_series_max(s) - nlp_pos_svm_series_min(s)
}

pub fn nlp_pos_svm_series_var(s : NlppossvmSeries) -> Double {
  let n = nlp_pos_svm_series_len(s)
  if n == 0 { 0.0 } else {
    let m = nlp_pos_svm_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn nlp_pos_svm_series_std(s : NlppossvmSeries) -> Double { @_common.sqrt(nlp_pos_svm_series_var(s)) }

pub fn nlp_pos_svm_series_median(s : NlppossvmSeries) -> Double {
  let n = nlp_pos_svm_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = nlp_pos_svm_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn nlp_pos_svm_series_scale(s : NlppossvmSeries, f : Double) -> NlppossvmSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn nlp_pos_svm_series_add(a : NlppossvmSeries, b : NlppossvmSeries) -> NlppossvmSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn nlp_pos_svm_series_sub(a : NlppossvmSeries, b : NlppossvmSeries) -> NlppossvmSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn nlp_pos_svm_series_normalize(s : NlppossvmSeries) -> NlppossvmSeries {
  let mn = nlp_pos_svm_series_min(s)
  let mx = nlp_pos_svm_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn nlp_pos_svm_series_cumsum(s : NlppossvmSeries) -> NlppossvmSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn nlp_pos_svm_series_to_string(s : NlppossvmSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NlppossvmMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn nlp_pos_svm_make_matrix(rows : Int, cols : Int, val : Double) -> NlppossvmMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn nlp_pos_svm_matrix_identity(n : Int) -> NlppossvmMatrix {
  let m = nlp_pos_svm_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn nlp_pos_svm_matrix_get(m : NlppossvmMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn nlp_pos_svm_matrix_transpose(m : NlppossvmMatrix) -> NlppossvmMatrix {
  let result = nlp_pos_svm_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn nlp_pos_svm_matrix_add(a : NlppossvmMatrix, b : NlppossvmMatrix) -> NlppossvmMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = nlp_pos_svm_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn nlp_pos_svm_matrix_scale(m : NlppossvmMatrix, s : Double) -> NlppossvmMatrix {
  let result = nlp_pos_svm_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn nlp_pos_svm_matrix_multiply(a : NlppossvmMatrix, b : NlppossvmMatrix) -> NlppossvmMatrix {
  if a.cols != b.rows { return nlp_pos_svm_make_matrix(a.rows, b.cols, 0.0) }
  let result = nlp_pos_svm_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn nlp_pos_svm_matrix_trace(m : NlppossvmMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn nlp_pos_svm_matrix_det(m : NlppossvmMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn nlp_pos_svm_matrix_norm(m : NlppossvmMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn nlp_pos_svm_matrix_to_string(m : NlppossvmMatrix) -> String {
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

pub(all) struct NlppossvmVector {
  comps : Array[Double]
  dim : Int
}

pub fn nlp_pos_svm_make_vector(comps : Array[Double]) -> NlppossvmVector {
  { comps, dim: comps.length() }
}

pub fn nlp_pos_svm_vector_zero(dim : Int) -> NlppossvmVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn nlp_pos_svm_vector_add(a : NlppossvmVector, b : NlppossvmVector) -> NlppossvmVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn nlp_pos_svm_vector_sub(a : NlppossvmVector, b : NlppossvmVector) -> NlppossvmVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn nlp_pos_svm_vector_scale(v : NlppossvmVector, s : Double) -> NlppossvmVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn nlp_pos_svm_vector_dot(a : NlppossvmVector, b : NlppossvmVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn nlp_pos_svm_vector_norm(v : NlppossvmVector) -> Double { @_common.sqrt(nlp_pos_svm_vector_dot(v, v)) }

pub fn nlp_pos_svm_vector_normalize(v : NlppossvmVector) -> NlppossvmVector {
  let n = nlp_pos_svm_vector_norm(v)
  if n < 0.0000001 { v } else { nlp_pos_svm_vector_scale(v, 1.0 / n) }
}

pub fn nlp_pos_svm_vector_dist(a : NlppossvmVector, b : NlppossvmVector) -> Double {
  nlp_pos_svm_vector_norm(nlp_pos_svm_vector_sub(a, b))
}

pub fn nlp_pos_svm_vector_to_string(v : NlppossvmVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn nlp_pos_svm_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn nlp_pos_svm_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = nlp_pos_svm_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn nlp_pos_svm_std(data : Array[Double]) -> Double { @_common.sqrt(nlp_pos_svm_var(data)) }

pub fn nlp_pos_svm_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = nlp_pos_svm_mean(a); let mb = nlp_pos_svm_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn nlp_pos_svm_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = nlp_pos_svm_std(a); let sb = nlp_pos_svm_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { nlp_pos_svm_cov(a, b) / (sa * sb) }
}

pub fn nlp_pos_svm_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = nlp_pos_svm_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn nlp_pos_svm_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn nlp_pos_svm_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn nlp_pos_svm_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  @_common.sqrt(nlp_pos_svm_mse(pred, labels))
}

pub fn nlp_pos_svm_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn nlp_pos_svm_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = nlp_pos_svm_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn nlp_pos_svm_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn nlp_pos_svm_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn nlp_pos_svm_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = nlp_pos_svm_precision(pred, labels, pos); let r = nlp_pos_svm_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn nlp_pos_svm_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn nlp_pos_svm_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = nlp_pos_svm_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn nlp_pos_svm_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn nlp_pos_svm_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn nlp_pos_svm_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = nlp_pos_svm_gcd(a, b)
    (a / g) * b
  }
}

pub fn nlp_pos_svm_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn nlp_pos_svm_fibonacci(n : Int) -> Int {
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

pub fn nlp_pos_svm_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = nlp_pos_svm_min(data); let mx = nlp_pos_svm_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn nlp_pos_svm_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = nlp_pos_svm_mean(data); let sd = nlp_pos_svm_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn nlp_pos_svm_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn nlp_pos_svm_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn nlp_pos_svm_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn nlp_pos_svm_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn nlp_pos_svm_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn nlp_pos_svm_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

pub(all) struct NlppossvmFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_svm_frame_make(size : Int) -> NlppossvmFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_svm_frame_len(s : NlppossvmFrame) -> Int { s.size }

pub fn nlp_pos_svm_frame_get(s : NlppossvmFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_svm_frame_set(s : NlppossvmFrame, i : Int, v : Double) -> NlppossvmFrame {
  let result = nlp_pos_svm_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_svm_frame_sum(s : NlppossvmFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_pos_svm_frame_mean(s : NlppossvmFrame) -> Double {
  if s.size == 0 { 0.0 } else { nlp_pos_svm_frame_sum(s) / s.size.to_double() }
}

pub fn nlp_pos_svm_frame_scale(s : NlppossvmFrame, f : Double) -> NlppossvmFrame {
  let result = nlp_pos_svm_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_pos_svm_frame_add(a : NlppossvmFrame, b : NlppossvmFrame) -> NlppossvmFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_pos_svm_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_pos_svm_frame_copy(s : NlppossvmFrame) -> NlppossvmFrame {
  let result = nlp_pos_svm_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_pos_svm_frame_fill(s : NlppossvmFrame, v : Double) -> NlppossvmFrame {
  let result = nlp_pos_svm_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_svm_frame_min(s : NlppossvmFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_svm_frame_max(s : NlppossvmFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_svm_frame_to_string(s : NlppossvmFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlppossvmTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_svm_table_make(size : Int) -> NlppossvmTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_svm_table_len(s : NlppossvmTable) -> Int { s.size }

pub fn nlp_pos_svm_table_get(s : NlppossvmTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_svm_table_set(s : NlppossvmTable, i : Int, v : Double) -> NlppossvmTable {
  let result = nlp_pos_svm_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_svm_table_sum(s : NlppossvmTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_pos_svm_table_mean(s : NlppossvmTable) -> Double {
  if s.size == 0 { 0.0 } else { nlp_pos_svm_table_sum(s) / s.size.to_double() }
}

pub fn nlp_pos_svm_table_scale(s : NlppossvmTable, f : Double) -> NlppossvmTable {
  let result = nlp_pos_svm_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_pos_svm_table_add(a : NlppossvmTable, b : NlppossvmTable) -> NlppossvmTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_pos_svm_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_pos_svm_table_copy(s : NlppossvmTable) -> NlppossvmTable {
  let result = nlp_pos_svm_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_pos_svm_table_fill(s : NlppossvmTable, v : Double) -> NlppossvmTable {
  let result = nlp_pos_svm_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_svm_table_min(s : NlppossvmTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_svm_table_max(s : NlppossvmTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_svm_table_to_string(s : NlppossvmTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlppossvmGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_svm_graphn_make(size : Int) -> NlppossvmGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_svm_graphn_len(s : NlppossvmGraphN) -> Int { s.size }

pub fn nlp_pos_svm_graphn_get(s : NlppossvmGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_svm_graphn_set(s : NlppossvmGraphN, i : Int, v : Double) -> NlppossvmGraphN {
  let result = nlp_pos_svm_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_svm_graphn_sum(s : NlppossvmGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_pos_svm_graphn_mean(s : NlppossvmGraphN) -> Double {
  if s.size == 0 { 0.0 } else { nlp_pos_svm_graphn_sum(s) / s.size.to_double() }
}

pub fn nlp_pos_svm_graphn_scale(s : NlppossvmGraphN, f : Double) -> NlppossvmGraphN {
  let result = nlp_pos_svm_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_pos_svm_graphn_add(a : NlppossvmGraphN, b : NlppossvmGraphN) -> NlppossvmGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_pos_svm_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_pos_svm_graphn_copy(s : NlppossvmGraphN) -> NlppossvmGraphN {
  let result = nlp_pos_svm_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_pos_svm_graphn_fill(s : NlppossvmGraphN, v : Double) -> NlppossvmGraphN {
  let result = nlp_pos_svm_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_svm_graphn_min(s : NlppossvmGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_svm_graphn_max(s : NlppossvmGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_svm_graphn_to_string(s : NlppossvmGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlppossvmNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_svm_node_make(size : Int) -> NlppossvmNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_svm_node_len(s : NlppossvmNode) -> Int { s.size }

pub fn nlp_pos_svm_node_get(s : NlppossvmNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_svm_node_set(s : NlppossvmNode, i : Int, v : Double) -> NlppossvmNode {
  let result = nlp_pos_svm_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_svm_node_sum(s : NlppossvmNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_pos_svm_node_mean(s : NlppossvmNode) -> Double {
  if s.size == 0 { 0.0 } else { nlp_pos_svm_node_sum(s) / s.size.to_double() }
}

pub fn nlp_pos_svm_node_scale(s : NlppossvmNode, f : Double) -> NlppossvmNode {
  let result = nlp_pos_svm_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_pos_svm_node_add(a : NlppossvmNode, b : NlppossvmNode) -> NlppossvmNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_pos_svm_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_pos_svm_node_copy(s : NlppossvmNode) -> NlppossvmNode {
  let result = nlp_pos_svm_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_pos_svm_node_fill(s : NlppossvmNode, v : Double) -> NlppossvmNode {
  let result = nlp_pos_svm_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_svm_node_min(s : NlppossvmNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_svm_node_max(s : NlppossvmNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_svm_node_to_string(s : NlppossvmNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlppossvmEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_svm_edge_make(size : Int) -> NlppossvmEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_svm_edge_len(s : NlppossvmEdge) -> Int { s.size }

pub fn nlp_pos_svm_edge_get(s : NlppossvmEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_svm_edge_set(s : NlppossvmEdge, i : Int, v : Double) -> NlppossvmEdge {
  let result = nlp_pos_svm_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_svm_edge_sum(s : NlppossvmEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_pos_svm_edge_mean(s : NlppossvmEdge) -> Double {
  if s.size == 0 { 0.0 } else { nlp_pos_svm_edge_sum(s) / s.size.to_double() }
}

pub fn nlp_pos_svm_edge_scale(s : NlppossvmEdge, f : Double) -> NlppossvmEdge {
  let result = nlp_pos_svm_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_pos_svm_edge_add(a : NlppossvmEdge, b : NlppossvmEdge) -> NlppossvmEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_pos_svm_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_pos_svm_edge_copy(s : NlppossvmEdge) -> NlppossvmEdge {
  let result = nlp_pos_svm_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_pos_svm_edge_fill(s : NlppossvmEdge, v : Double) -> NlppossvmEdge {
  let result = nlp_pos_svm_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_svm_edge_min(s : NlppossvmEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_svm_edge_max(s : NlppossvmEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_svm_edge_to_string(s : NlppossvmEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlppossvmPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_svm_path_make(size : Int) -> NlppossvmPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_svm_path_len(s : NlppossvmPath) -> Int { s.size }

pub fn nlp_pos_svm_path_get(s : NlppossvmPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_svm_path_set(s : NlppossvmPath, i : Int, v : Double) -> NlppossvmPath {
  let result = nlp_pos_svm_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_svm_path_sum(s : NlppossvmPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_pos_svm_path_mean(s : NlppossvmPath) -> Double {
  if s.size == 0 { 0.0 } else { nlp_pos_svm_path_sum(s) / s.size.to_double() }
}

pub fn nlp_pos_svm_path_scale(s : NlppossvmPath, f : Double) -> NlppossvmPath {
  let result = nlp_pos_svm_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_pos_svm_path_add(a : NlppossvmPath, b : NlppossvmPath) -> NlppossvmPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_pos_svm_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_pos_svm_path_copy(s : NlppossvmPath) -> NlppossvmPath {
  let result = nlp_pos_svm_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_pos_svm_path_fill(s : NlppossvmPath, v : Double) -> NlppossvmPath {
  let result = nlp_pos_svm_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_svm_path_min(s : NlppossvmPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_svm_path_max(s : NlppossvmPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_svm_path_to_string(s : NlppossvmPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlppossvmCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_svm_cluster_make(size : Int) -> NlppossvmCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_svm_cluster_len(s : NlppossvmCluster) -> Int { s.size }

pub fn nlp_pos_svm_cluster_get(s : NlppossvmCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_svm_cluster_set(s : NlppossvmCluster, i : Int, v : Double) -> NlppossvmCluster {
  let result = nlp_pos_svm_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_svm_cluster_sum(s : NlppossvmCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_pos_svm_cluster_mean(s : NlppossvmCluster) -> Double {
  if s.size == 0 { 0.0 } else { nlp_pos_svm_cluster_sum(s) / s.size.to_double() }
}

pub fn nlp_pos_svm_cluster_scale(s : NlppossvmCluster, f : Double) -> NlppossvmCluster {
  let result = nlp_pos_svm_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_pos_svm_cluster_add(a : NlppossvmCluster, b : NlppossvmCluster) -> NlppossvmCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_pos_svm_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_pos_svm_cluster_copy(s : NlppossvmCluster) -> NlppossvmCluster {
  let result = nlp_pos_svm_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_pos_svm_cluster_fill(s : NlppossvmCluster, v : Double) -> NlppossvmCluster {
  let result = nlp_pos_svm_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_svm_cluster_min(s : NlppossvmCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_svm_cluster_max(s : NlppossvmCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_svm_cluster_to_string(s : NlppossvmCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlppossvmModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_svm_model_make(size : Int) -> NlppossvmModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_svm_model_len(s : NlppossvmModel) -> Int { s.size }

pub fn nlp_pos_svm_model_get(s : NlppossvmModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_svm_model_set(s : NlppossvmModel, i : Int, v : Double) -> NlppossvmModel {
  let result = nlp_pos_svm_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_svm_model_sum(s : NlppossvmModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_pos_svm_model_mean(s : NlppossvmModel) -> Double {
  if s.size == 0 { 0.0 } else { nlp_pos_svm_model_sum(s) / s.size.to_double() }
}

pub fn nlp_pos_svm_model_scale(s : NlppossvmModel, f : Double) -> NlppossvmModel {
  let result = nlp_pos_svm_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_pos_svm_model_add(a : NlppossvmModel, b : NlppossvmModel) -> NlppossvmModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_pos_svm_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_pos_svm_model_copy(s : NlppossvmModel) -> NlppossvmModel {
  let result = nlp_pos_svm_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_pos_svm_model_fill(s : NlppossvmModel, v : Double) -> NlppossvmModel {
  let result = nlp_pos_svm_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_svm_model_min(s : NlppossvmModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_svm_model_max(s : NlppossvmModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_svm_model_to_string(s : NlppossvmModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlppossvmLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_svm_layer_make(size : Int) -> NlppossvmLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_svm_layer_len(s : NlppossvmLayer) -> Int { s.size }

pub fn nlp_pos_svm_layer_get(s : NlppossvmLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_svm_layer_set(s : NlppossvmLayer, i : Int, v : Double) -> NlppossvmLayer {
  let result = nlp_pos_svm_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_svm_layer_sum(s : NlppossvmLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_pos_svm_layer_mean(s : NlppossvmLayer) -> Double {
  if s.size == 0 { 0.0 } else { nlp_pos_svm_layer_sum(s) / s.size.to_double() }
}

pub fn nlp_pos_svm_layer_scale(s : NlppossvmLayer, f : Double) -> NlppossvmLayer {
  let result = nlp_pos_svm_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_pos_svm_layer_add(a : NlppossvmLayer, b : NlppossvmLayer) -> NlppossvmLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_pos_svm_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_pos_svm_layer_copy(s : NlppossvmLayer) -> NlppossvmLayer {
  let result = nlp_pos_svm_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_pos_svm_layer_fill(s : NlppossvmLayer, v : Double) -> NlppossvmLayer {
  let result = nlp_pos_svm_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_svm_layer_min(s : NlppossvmLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_svm_layer_max(s : NlppossvmLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_svm_layer_to_string(s : NlppossvmLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlppossvmBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_svm_buffer_make(size : Int) -> NlppossvmBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_svm_buffer_len(s : NlppossvmBuffer) -> Int { s.size }

pub fn nlp_pos_svm_buffer_get(s : NlppossvmBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_svm_buffer_set(s : NlppossvmBuffer, i : Int, v : Double) -> NlppossvmBuffer {
  let result = nlp_pos_svm_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_svm_buffer_sum(s : NlppossvmBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_pos_svm_buffer_mean(s : NlppossvmBuffer) -> Double {
  if s.size == 0 { 0.0 } else { nlp_pos_svm_buffer_sum(s) / s.size.to_double() }
}

pub fn nlp_pos_svm_buffer_scale(s : NlppossvmBuffer, f : Double) -> NlppossvmBuffer {
  let result = nlp_pos_svm_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_pos_svm_buffer_add(a : NlppossvmBuffer, b : NlppossvmBuffer) -> NlppossvmBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_pos_svm_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_pos_svm_buffer_copy(s : NlppossvmBuffer) -> NlppossvmBuffer {
  let result = nlp_pos_svm_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_pos_svm_buffer_fill(s : NlppossvmBuffer, v : Double) -> NlppossvmBuffer {
  let result = nlp_pos_svm_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_svm_buffer_min(s : NlppossvmBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_svm_buffer_max(s : NlppossvmBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_svm_buffer_to_string(s : NlppossvmBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlppossvmCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_svm_cursor_make(size : Int) -> NlppossvmCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_svm_cursor_len(s : NlppossvmCursor) -> Int { s.size }

pub fn nlp_pos_svm_cursor_get(s : NlppossvmCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_svm_cursor_set(s : NlppossvmCursor, i : Int, v : Double) -> NlppossvmCursor {
  let result = nlp_pos_svm_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_svm_cursor_sum(s : NlppossvmCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_pos_svm_cursor_mean(s : NlppossvmCursor) -> Double {
  if s.size == 0 { 0.0 } else { nlp_pos_svm_cursor_sum(s) / s.size.to_double() }
}

pub fn nlp_pos_svm_cursor_scale(s : NlppossvmCursor, f : Double) -> NlppossvmCursor {
  let result = nlp_pos_svm_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_pos_svm_cursor_add(a : NlppossvmCursor, b : NlppossvmCursor) -> NlppossvmCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_pos_svm_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_pos_svm_cursor_copy(s : NlppossvmCursor) -> NlppossvmCursor {
  let result = nlp_pos_svm_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_pos_svm_cursor_fill(s : NlppossvmCursor, v : Double) -> NlppossvmCursor {
  let result = nlp_pos_svm_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_svm_cursor_min(s : NlppossvmCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_svm_cursor_max(s : NlppossvmCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_svm_cursor_to_string(s : NlppossvmCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlppossvmView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_svm_view_make(size : Int) -> NlppossvmView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_svm_view_len(s : NlppossvmView) -> Int { s.size }

pub fn nlp_pos_svm_view_get(s : NlppossvmView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_svm_view_set(s : NlppossvmView, i : Int, v : Double) -> NlppossvmView {
  let result = nlp_pos_svm_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_svm_view_sum(s : NlppossvmView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_pos_svm_view_mean(s : NlppossvmView) -> Double {
  if s.size == 0 { 0.0 } else { nlp_pos_svm_view_sum(s) / s.size.to_double() }
}

pub fn nlp_pos_svm_view_scale(s : NlppossvmView, f : Double) -> NlppossvmView {
  let result = nlp_pos_svm_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_pos_svm_view_add(a : NlppossvmView, b : NlppossvmView) -> NlppossvmView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_pos_svm_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_pos_svm_view_copy(s : NlppossvmView) -> NlppossvmView {
  let result = nlp_pos_svm_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_pos_svm_view_fill(s : NlppossvmView, v : Double) -> NlppossvmView {
  let result = nlp_pos_svm_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_svm_view_min(s : NlppossvmView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_svm_view_max(s : NlppossvmView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_svm_view_to_string(s : NlppossvmView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlppossvmRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_svm_range_make(size : Int) -> NlppossvmRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_svm_range_len(s : NlppossvmRange) -> Int { s.size }

pub fn nlp_pos_svm_range_get(s : NlppossvmRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_svm_range_set(s : NlppossvmRange, i : Int, v : Double) -> NlppossvmRange {
  let result = nlp_pos_svm_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_svm_range_sum(s : NlppossvmRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_pos_svm_range_mean(s : NlppossvmRange) -> Double {
  if s.size == 0 { 0.0 } else { nlp_pos_svm_range_sum(s) / s.size.to_double() }
}

pub fn nlp_pos_svm_range_scale(s : NlppossvmRange, f : Double) -> NlppossvmRange {
  let result = nlp_pos_svm_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_pos_svm_range_add(a : NlppossvmRange, b : NlppossvmRange) -> NlppossvmRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_pos_svm_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_pos_svm_range_copy(s : NlppossvmRange) -> NlppossvmRange {
  let result = nlp_pos_svm_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_pos_svm_range_fill(s : NlppossvmRange, v : Double) -> NlppossvmRange {
  let result = nlp_pos_svm_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_svm_range_min(s : NlppossvmRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_svm_range_max(s : NlppossvmRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_svm_range_to_string(s : NlppossvmRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlppossvmSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_svm_slice_make(size : Int) -> NlppossvmSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_svm_slice_len(s : NlppossvmSlice) -> Int { s.size }

pub fn nlp_pos_svm_slice_get(s : NlppossvmSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_svm_slice_set(s : NlppossvmSlice, i : Int, v : Double) -> NlppossvmSlice {
  let result = nlp_pos_svm_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_svm_slice_sum(s : NlppossvmSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_pos_svm_slice_mean(s : NlppossvmSlice) -> Double {
  if s.size == 0 { 0.0 } else { nlp_pos_svm_slice_sum(s) / s.size.to_double() }
}

pub fn nlp_pos_svm_slice_scale(s : NlppossvmSlice, f : Double) -> NlppossvmSlice {
  let result = nlp_pos_svm_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_pos_svm_slice_add(a : NlppossvmSlice, b : NlppossvmSlice) -> NlppossvmSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_pos_svm_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_pos_svm_slice_copy(s : NlppossvmSlice) -> NlppossvmSlice {
  let result = nlp_pos_svm_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_pos_svm_slice_fill(s : NlppossvmSlice, v : Double) -> NlppossvmSlice {
  let result = nlp_pos_svm_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_svm_slice_min(s : NlppossvmSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_svm_slice_max(s : NlppossvmSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_svm_slice_to_string(s : NlppossvmSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

