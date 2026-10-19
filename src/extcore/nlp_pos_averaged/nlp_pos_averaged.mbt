///===
/// extcore/nlp_pos_averaged

pub(all) struct NlpposaveragedPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn nlp_pos_averaged_make_point(x : Double, y : Double) -> NlpposaveragedPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn nlp_pos_averaged_make_point3(x : Double, y : Double, z : Double) -> NlpposaveragedPoint {
  { x, y, z, label: 0 }
}

pub fn nlp_pos_averaged_point_x(pt : NlpposaveragedPoint) -> Double { pt.x }

pub fn nlp_pos_averaged_point_y(pt : NlpposaveragedPoint) -> Double { pt.y }

pub fn nlp_pos_averaged_point_z(pt : NlpposaveragedPoint) -> Double { pt.z }

pub fn nlp_pos_averaged_point_label(pt : NlpposaveragedPoint) -> Int { pt.label }

pub fn nlp_pos_averaged_point_dist(a : NlpposaveragedPoint, b : NlpposaveragedPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  nlp_pos_averaged_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn nlp_pos_averaged_point_add(a : NlpposaveragedPoint, b : NlpposaveragedPoint) -> NlpposaveragedPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn nlp_pos_averaged_point_sub(a : NlpposaveragedPoint, b : NlpposaveragedPoint) -> NlpposaveragedPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn nlp_pos_averaged_point_scale(pt : NlpposaveragedPoint, s : Double) -> NlpposaveragedPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn nlp_pos_averaged_point_dot(a : NlpposaveragedPoint, b : NlpposaveragedPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn nlp_pos_averaged_point_cross(a : NlpposaveragedPoint, b : NlpposaveragedPoint) -> NlpposaveragedPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn nlp_pos_averaged_point_norm(pt : NlpposaveragedPoint) -> Double {
  nlp_pos_averaged_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn nlp_pos_averaged_point_normalize(pt : NlpposaveragedPoint) -> NlpposaveragedPoint {
  let n = nlp_pos_averaged_point_norm(pt)
  if n < 0.0000001 { pt } else { nlp_pos_averaged_point_scale(pt, 1.0 / n) }
}

pub fn nlp_pos_averaged_point_negate(pt : NlpposaveragedPoint) -> NlpposaveragedPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn nlp_pos_averaged_point_mid(a : NlpposaveragedPoint, b : NlpposaveragedPoint) -> NlpposaveragedPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn nlp_pos_averaged_point_lerp(a : NlpposaveragedPoint, b : NlpposaveragedPoint, t : Double) -> NlpposaveragedPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn nlp_pos_averaged_point_to_string(pt : NlpposaveragedPoint) -> String {
  "(" + nlp_pos_averaged_dbl(pt.x) + ", " + nlp_pos_averaged_dbl(pt.y) + ", " + nlp_pos_averaged_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct NlpposaveragedSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn nlp_pos_averaged_make_series(vals : Array[Double], name : String) -> NlpposaveragedSeries {
  { vals, name, meta: 0 }
}

pub fn nlp_pos_averaged_series_len(s : NlpposaveragedSeries) -> Int { s.vals.length() }

pub fn nlp_pos_averaged_series_sum(s : NlpposaveragedSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn nlp_pos_averaged_series_mean(s : NlpposaveragedSeries) -> Double {
  let n = nlp_pos_averaged_series_len(s)
  if n == 0 { 0.0 } else { nlp_pos_averaged_series_sum(s) / n.to_double() }
}

pub fn nlp_pos_averaged_series_min(s : NlpposaveragedSeries) -> Double {
  let n = nlp_pos_averaged_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn nlp_pos_averaged_series_max(s : NlpposaveragedSeries) -> Double {
  let n = nlp_pos_averaged_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn nlp_pos_averaged_series_range(s : NlpposaveragedSeries) -> Double {
  nlp_pos_averaged_series_max(s) - nlp_pos_averaged_series_min(s)
}

pub fn nlp_pos_averaged_series_var(s : NlpposaveragedSeries) -> Double {
  let n = nlp_pos_averaged_series_len(s)
  if n == 0 { 0.0 } else {
    let m = nlp_pos_averaged_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn nlp_pos_averaged_series_std(s : NlpposaveragedSeries) -> Double { nlp_pos_averaged_sqrt(nlp_pos_averaged_series_var(s)) }

pub fn nlp_pos_averaged_series_median(s : NlpposaveragedSeries) -> Double {
  let n = nlp_pos_averaged_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = nlp_pos_averaged_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn nlp_pos_averaged_series_scale(s : NlpposaveragedSeries, f : Double) -> NlpposaveragedSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = nlp_pos_averaged_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn nlp_pos_averaged_series_add(a : NlpposaveragedSeries, b : NlpposaveragedSeries) -> NlpposaveragedSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = nlp_pos_averaged_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn nlp_pos_averaged_series_sub(a : NlpposaveragedSeries, b : NlpposaveragedSeries) -> NlpposaveragedSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = nlp_pos_averaged_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn nlp_pos_averaged_series_normalize(s : NlpposaveragedSeries) -> NlpposaveragedSeries {
  let mn = nlp_pos_averaged_series_min(s)
  let mx = nlp_pos_averaged_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = nlp_pos_averaged_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn nlp_pos_averaged_series_cumsum(s : NlpposaveragedSeries) -> NlpposaveragedSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = nlp_pos_averaged_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn nlp_pos_averaged_series_to_string(s : NlpposaveragedSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + nlp_pos_averaged_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NlpposaveragedMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn nlp_pos_averaged_make_matrix(rows : Int, cols : Int, val : Double) -> NlpposaveragedMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn nlp_pos_averaged_matrix_identity(n : Int) -> NlpposaveragedMatrix {
  let m = nlp_pos_averaged_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn nlp_pos_averaged_matrix_get(m : NlpposaveragedMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn nlp_pos_averaged_matrix_transpose(m : NlpposaveragedMatrix) -> NlpposaveragedMatrix {
  let result = nlp_pos_averaged_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn nlp_pos_averaged_matrix_add(a : NlpposaveragedMatrix, b : NlpposaveragedMatrix) -> NlpposaveragedMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = nlp_pos_averaged_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn nlp_pos_averaged_matrix_scale(m : NlpposaveragedMatrix, s : Double) -> NlpposaveragedMatrix {
  let result = nlp_pos_averaged_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn nlp_pos_averaged_matrix_multiply(a : NlpposaveragedMatrix, b : NlpposaveragedMatrix) -> NlpposaveragedMatrix {
  if a.cols != b.rows { return nlp_pos_averaged_make_matrix(a.rows, b.cols, 0.0) }
  let result = nlp_pos_averaged_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn nlp_pos_averaged_matrix_trace(m : NlpposaveragedMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn nlp_pos_averaged_matrix_det(m : NlpposaveragedMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn nlp_pos_averaged_matrix_norm(m : NlpposaveragedMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  nlp_pos_averaged_sqrt(sum)
}

pub fn nlp_pos_averaged_matrix_to_string(m : NlpposaveragedMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + nlp_pos_averaged_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct NlpposaveragedVector {
  comps : Array[Double]
  dim : Int
}

pub fn nlp_pos_averaged_make_vector(comps : Array[Double]) -> NlpposaveragedVector {
  { comps, dim: comps.length() }
}

pub fn nlp_pos_averaged_vector_zero(dim : Int) -> NlpposaveragedVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn nlp_pos_averaged_vector_add(a : NlpposaveragedVector, b : NlpposaveragedVector) -> NlpposaveragedVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = nlp_pos_averaged_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn nlp_pos_averaged_vector_sub(a : NlpposaveragedVector, b : NlpposaveragedVector) -> NlpposaveragedVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = nlp_pos_averaged_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn nlp_pos_averaged_vector_scale(v : NlpposaveragedVector, s : Double) -> NlpposaveragedVector {
  let mut result = []
  for i in 0..<v.dim { result = nlp_pos_averaged_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn nlp_pos_averaged_vector_dot(a : NlpposaveragedVector, b : NlpposaveragedVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn nlp_pos_averaged_vector_norm(v : NlpposaveragedVector) -> Double { nlp_pos_averaged_sqrt(nlp_pos_averaged_vector_dot(v, v)) }

pub fn nlp_pos_averaged_vector_normalize(v : NlpposaveragedVector) -> NlpposaveragedVector {
  let n = nlp_pos_averaged_vector_norm(v)
  if n < 0.0000001 { v } else { nlp_pos_averaged_vector_scale(v, 1.0 / n) }
}

pub fn nlp_pos_averaged_vector_dist(a : NlpposaveragedVector, b : NlpposaveragedVector) -> Double {
  nlp_pos_averaged_vector_norm(nlp_pos_averaged_vector_sub(a, b))
}

pub fn nlp_pos_averaged_vector_to_string(v : NlpposaveragedVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + nlp_pos_averaged_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn nlp_pos_averaged_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn nlp_pos_averaged_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = nlp_pos_averaged_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn nlp_pos_averaged_std(data : Array[Double]) -> Double { nlp_pos_averaged_sqrt(nlp_pos_averaged_var(data)) }

pub fn nlp_pos_averaged_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = nlp_pos_averaged_mean(a); let mb = nlp_pos_averaged_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn nlp_pos_averaged_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = nlp_pos_averaged_std(a); let sb = nlp_pos_averaged_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { nlp_pos_averaged_cov(a, b) / (sa * sb) }
}

pub fn nlp_pos_averaged_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = nlp_pos_averaged_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn nlp_pos_averaged_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn nlp_pos_averaged_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn nlp_pos_averaged_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  nlp_pos_averaged_sqrt(nlp_pos_averaged_mse(pred, labels))
}

pub fn nlp_pos_averaged_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + nlp_pos_averaged_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn nlp_pos_averaged_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = nlp_pos_averaged_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn nlp_pos_averaged_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn nlp_pos_averaged_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn nlp_pos_averaged_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = nlp_pos_averaged_precision(pred, labels, pos); let r = nlp_pos_averaged_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn nlp_pos_averaged_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn nlp_pos_averaged_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = nlp_pos_averaged_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn nlp_pos_averaged_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn nlp_pos_averaged_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn nlp_pos_averaged_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = nlp_pos_averaged_gcd(a, b)
    (a / g) * b
  }
}

pub fn nlp_pos_averaged_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn nlp_pos_averaged_fibonacci(n : Int) -> Int {
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

pub fn nlp_pos_averaged_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = nlp_pos_averaged_min(data); let mx = nlp_pos_averaged_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn nlp_pos_averaged_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = nlp_pos_averaged_mean(data); let sd = nlp_pos_averaged_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn nlp_pos_averaged_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn nlp_pos_averaged_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn nlp_pos_averaged_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn nlp_pos_averaged_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn nlp_pos_averaged_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn nlp_pos_averaged_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn nlp_pos_averaged_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn nlp_pos_averaged_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn nlp_pos_averaged_dbl(x : Double) -> String {
  let i = if x >= 0.0 { nlp_pos_averaged_int(x) } else { -nlp_pos_averaged_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { nlp_pos_averaged_int(f * 1000000.0) } else { nlp_pos_averaged_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn nlp_pos_averaged_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn nlp_pos_averaged_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct NlpposaveragedFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_averaged_frame_make(size : Int) -> NlpposaveragedFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_averaged_frame_len(s : NlpposaveragedFrame) -> Int { s.size }

pub fn nlp_pos_averaged_frame_get(s : NlpposaveragedFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_averaged_frame_set(s : NlpposaveragedFrame, i : Int, v : Double) -> NlpposaveragedFrame {
  let result = nlp_pos_averaged_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_averaged_frame_sum(s : NlpposaveragedFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_pos_averaged_frame_mean(s : NlpposaveragedFrame) -> Double {
  if s.size == 0 { 0.0 } else { nlp_pos_averaged_frame_sum(s) / s.size.to_double() }
}

pub fn nlp_pos_averaged_frame_scale(s : NlpposaveragedFrame, f : Double) -> NlpposaveragedFrame {
  let result = nlp_pos_averaged_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_pos_averaged_frame_add(a : NlpposaveragedFrame, b : NlpposaveragedFrame) -> NlpposaveragedFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_pos_averaged_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_pos_averaged_frame_copy(s : NlpposaveragedFrame) -> NlpposaveragedFrame {
  let result = nlp_pos_averaged_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_pos_averaged_frame_fill(s : NlpposaveragedFrame, v : Double) -> NlpposaveragedFrame {
  let result = nlp_pos_averaged_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_averaged_frame_min(s : NlpposaveragedFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_averaged_frame_max(s : NlpposaveragedFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_averaged_frame_to_string(s : NlpposaveragedFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpposaveragedTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_averaged_table_make(size : Int) -> NlpposaveragedTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_averaged_table_len(s : NlpposaveragedTable) -> Int { s.size }

pub fn nlp_pos_averaged_table_get(s : NlpposaveragedTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_averaged_table_set(s : NlpposaveragedTable, i : Int, v : Double) -> NlpposaveragedTable {
  let result = nlp_pos_averaged_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_averaged_table_sum(s : NlpposaveragedTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_pos_averaged_table_mean(s : NlpposaveragedTable) -> Double {
  if s.size == 0 { 0.0 } else { nlp_pos_averaged_table_sum(s) / s.size.to_double() }
}

pub fn nlp_pos_averaged_table_scale(s : NlpposaveragedTable, f : Double) -> NlpposaveragedTable {
  let result = nlp_pos_averaged_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_pos_averaged_table_add(a : NlpposaveragedTable, b : NlpposaveragedTable) -> NlpposaveragedTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_pos_averaged_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_pos_averaged_table_copy(s : NlpposaveragedTable) -> NlpposaveragedTable {
  let result = nlp_pos_averaged_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_pos_averaged_table_fill(s : NlpposaveragedTable, v : Double) -> NlpposaveragedTable {
  let result = nlp_pos_averaged_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_averaged_table_min(s : NlpposaveragedTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_averaged_table_max(s : NlpposaveragedTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_averaged_table_to_string(s : NlpposaveragedTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpposaveragedGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_averaged_graphn_make(size : Int) -> NlpposaveragedGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_averaged_graphn_len(s : NlpposaveragedGraphN) -> Int { s.size }

pub fn nlp_pos_averaged_graphn_get(s : NlpposaveragedGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_averaged_graphn_set(s : NlpposaveragedGraphN, i : Int, v : Double) -> NlpposaveragedGraphN {
  let result = nlp_pos_averaged_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_averaged_graphn_sum(s : NlpposaveragedGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_pos_averaged_graphn_mean(s : NlpposaveragedGraphN) -> Double {
  if s.size == 0 { 0.0 } else { nlp_pos_averaged_graphn_sum(s) / s.size.to_double() }
}

pub fn nlp_pos_averaged_graphn_scale(s : NlpposaveragedGraphN, f : Double) -> NlpposaveragedGraphN {
  let result = nlp_pos_averaged_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_pos_averaged_graphn_add(a : NlpposaveragedGraphN, b : NlpposaveragedGraphN) -> NlpposaveragedGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_pos_averaged_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_pos_averaged_graphn_copy(s : NlpposaveragedGraphN) -> NlpposaveragedGraphN {
  let result = nlp_pos_averaged_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_pos_averaged_graphn_fill(s : NlpposaveragedGraphN, v : Double) -> NlpposaveragedGraphN {
  let result = nlp_pos_averaged_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_averaged_graphn_min(s : NlpposaveragedGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_averaged_graphn_max(s : NlpposaveragedGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_averaged_graphn_to_string(s : NlpposaveragedGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpposaveragedNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_averaged_node_make(size : Int) -> NlpposaveragedNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_averaged_node_len(s : NlpposaveragedNode) -> Int { s.size }

pub fn nlp_pos_averaged_node_get(s : NlpposaveragedNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_averaged_node_set(s : NlpposaveragedNode, i : Int, v : Double) -> NlpposaveragedNode {
  let result = nlp_pos_averaged_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_averaged_node_sum(s : NlpposaveragedNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_pos_averaged_node_mean(s : NlpposaveragedNode) -> Double {
  if s.size == 0 { 0.0 } else { nlp_pos_averaged_node_sum(s) / s.size.to_double() }
}

pub fn nlp_pos_averaged_node_scale(s : NlpposaveragedNode, f : Double) -> NlpposaveragedNode {
  let result = nlp_pos_averaged_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_pos_averaged_node_add(a : NlpposaveragedNode, b : NlpposaveragedNode) -> NlpposaveragedNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_pos_averaged_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_pos_averaged_node_copy(s : NlpposaveragedNode) -> NlpposaveragedNode {
  let result = nlp_pos_averaged_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_pos_averaged_node_fill(s : NlpposaveragedNode, v : Double) -> NlpposaveragedNode {
  let result = nlp_pos_averaged_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_averaged_node_min(s : NlpposaveragedNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_averaged_node_max(s : NlpposaveragedNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_averaged_node_to_string(s : NlpposaveragedNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpposaveragedEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_averaged_edge_make(size : Int) -> NlpposaveragedEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_averaged_edge_len(s : NlpposaveragedEdge) -> Int { s.size }

pub fn nlp_pos_averaged_edge_get(s : NlpposaveragedEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_averaged_edge_set(s : NlpposaveragedEdge, i : Int, v : Double) -> NlpposaveragedEdge {
  let result = nlp_pos_averaged_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_averaged_edge_sum(s : NlpposaveragedEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_pos_averaged_edge_mean(s : NlpposaveragedEdge) -> Double {
  if s.size == 0 { 0.0 } else { nlp_pos_averaged_edge_sum(s) / s.size.to_double() }
}

pub fn nlp_pos_averaged_edge_scale(s : NlpposaveragedEdge, f : Double) -> NlpposaveragedEdge {
  let result = nlp_pos_averaged_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_pos_averaged_edge_add(a : NlpposaveragedEdge, b : NlpposaveragedEdge) -> NlpposaveragedEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_pos_averaged_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_pos_averaged_edge_copy(s : NlpposaveragedEdge) -> NlpposaveragedEdge {
  let result = nlp_pos_averaged_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_pos_averaged_edge_fill(s : NlpposaveragedEdge, v : Double) -> NlpposaveragedEdge {
  let result = nlp_pos_averaged_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_averaged_edge_min(s : NlpposaveragedEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_averaged_edge_max(s : NlpposaveragedEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_averaged_edge_to_string(s : NlpposaveragedEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpposaveragedPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_averaged_path_make(size : Int) -> NlpposaveragedPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_averaged_path_len(s : NlpposaveragedPath) -> Int { s.size }

pub fn nlp_pos_averaged_path_get(s : NlpposaveragedPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_averaged_path_set(s : NlpposaveragedPath, i : Int, v : Double) -> NlpposaveragedPath {
  let result = nlp_pos_averaged_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_averaged_path_sum(s : NlpposaveragedPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_pos_averaged_path_mean(s : NlpposaveragedPath) -> Double {
  if s.size == 0 { 0.0 } else { nlp_pos_averaged_path_sum(s) / s.size.to_double() }
}

pub fn nlp_pos_averaged_path_scale(s : NlpposaveragedPath, f : Double) -> NlpposaveragedPath {
  let result = nlp_pos_averaged_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_pos_averaged_path_add(a : NlpposaveragedPath, b : NlpposaveragedPath) -> NlpposaveragedPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_pos_averaged_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_pos_averaged_path_copy(s : NlpposaveragedPath) -> NlpposaveragedPath {
  let result = nlp_pos_averaged_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_pos_averaged_path_fill(s : NlpposaveragedPath, v : Double) -> NlpposaveragedPath {
  let result = nlp_pos_averaged_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_averaged_path_min(s : NlpposaveragedPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_averaged_path_max(s : NlpposaveragedPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_averaged_path_to_string(s : NlpposaveragedPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpposaveragedCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_averaged_cluster_make(size : Int) -> NlpposaveragedCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_averaged_cluster_len(s : NlpposaveragedCluster) -> Int { s.size }

pub fn nlp_pos_averaged_cluster_get(s : NlpposaveragedCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_averaged_cluster_set(s : NlpposaveragedCluster, i : Int, v : Double) -> NlpposaveragedCluster {
  let result = nlp_pos_averaged_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_averaged_cluster_sum(s : NlpposaveragedCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_pos_averaged_cluster_mean(s : NlpposaveragedCluster) -> Double {
  if s.size == 0 { 0.0 } else { nlp_pos_averaged_cluster_sum(s) / s.size.to_double() }
}

pub fn nlp_pos_averaged_cluster_scale(s : NlpposaveragedCluster, f : Double) -> NlpposaveragedCluster {
  let result = nlp_pos_averaged_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_pos_averaged_cluster_add(a : NlpposaveragedCluster, b : NlpposaveragedCluster) -> NlpposaveragedCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_pos_averaged_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_pos_averaged_cluster_copy(s : NlpposaveragedCluster) -> NlpposaveragedCluster {
  let result = nlp_pos_averaged_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_pos_averaged_cluster_fill(s : NlpposaveragedCluster, v : Double) -> NlpposaveragedCluster {
  let result = nlp_pos_averaged_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_averaged_cluster_min(s : NlpposaveragedCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_averaged_cluster_max(s : NlpposaveragedCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_averaged_cluster_to_string(s : NlpposaveragedCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpposaveragedModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_averaged_model_make(size : Int) -> NlpposaveragedModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_averaged_model_len(s : NlpposaveragedModel) -> Int { s.size }

pub fn nlp_pos_averaged_model_get(s : NlpposaveragedModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_averaged_model_set(s : NlpposaveragedModel, i : Int, v : Double) -> NlpposaveragedModel {
  let result = nlp_pos_averaged_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_averaged_model_sum(s : NlpposaveragedModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_pos_averaged_model_mean(s : NlpposaveragedModel) -> Double {
  if s.size == 0 { 0.0 } else { nlp_pos_averaged_model_sum(s) / s.size.to_double() }
}

pub fn nlp_pos_averaged_model_scale(s : NlpposaveragedModel, f : Double) -> NlpposaveragedModel {
  let result = nlp_pos_averaged_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_pos_averaged_model_add(a : NlpposaveragedModel, b : NlpposaveragedModel) -> NlpposaveragedModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_pos_averaged_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_pos_averaged_model_copy(s : NlpposaveragedModel) -> NlpposaveragedModel {
  let result = nlp_pos_averaged_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_pos_averaged_model_fill(s : NlpposaveragedModel, v : Double) -> NlpposaveragedModel {
  let result = nlp_pos_averaged_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_averaged_model_min(s : NlpposaveragedModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_averaged_model_max(s : NlpposaveragedModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_averaged_model_to_string(s : NlpposaveragedModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpposaveragedLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_averaged_layer_make(size : Int) -> NlpposaveragedLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_averaged_layer_len(s : NlpposaveragedLayer) -> Int { s.size }

pub fn nlp_pos_averaged_layer_get(s : NlpposaveragedLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_averaged_layer_set(s : NlpposaveragedLayer, i : Int, v : Double) -> NlpposaveragedLayer {
  let result = nlp_pos_averaged_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_averaged_layer_sum(s : NlpposaveragedLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_pos_averaged_layer_mean(s : NlpposaveragedLayer) -> Double {
  if s.size == 0 { 0.0 } else { nlp_pos_averaged_layer_sum(s) / s.size.to_double() }
}

pub fn nlp_pos_averaged_layer_scale(s : NlpposaveragedLayer, f : Double) -> NlpposaveragedLayer {
  let result = nlp_pos_averaged_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_pos_averaged_layer_add(a : NlpposaveragedLayer, b : NlpposaveragedLayer) -> NlpposaveragedLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_pos_averaged_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_pos_averaged_layer_copy(s : NlpposaveragedLayer) -> NlpposaveragedLayer {
  let result = nlp_pos_averaged_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_pos_averaged_layer_fill(s : NlpposaveragedLayer, v : Double) -> NlpposaveragedLayer {
  let result = nlp_pos_averaged_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_averaged_layer_min(s : NlpposaveragedLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_averaged_layer_max(s : NlpposaveragedLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_averaged_layer_to_string(s : NlpposaveragedLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpposaveragedBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_averaged_buffer_make(size : Int) -> NlpposaveragedBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_averaged_buffer_len(s : NlpposaveragedBuffer) -> Int { s.size }

pub fn nlp_pos_averaged_buffer_get(s : NlpposaveragedBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_averaged_buffer_set(s : NlpposaveragedBuffer, i : Int, v : Double) -> NlpposaveragedBuffer {
  let result = nlp_pos_averaged_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_averaged_buffer_sum(s : NlpposaveragedBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_pos_averaged_buffer_mean(s : NlpposaveragedBuffer) -> Double {
  if s.size == 0 { 0.0 } else { nlp_pos_averaged_buffer_sum(s) / s.size.to_double() }
}

pub fn nlp_pos_averaged_buffer_scale(s : NlpposaveragedBuffer, f : Double) -> NlpposaveragedBuffer {
  let result = nlp_pos_averaged_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_pos_averaged_buffer_add(a : NlpposaveragedBuffer, b : NlpposaveragedBuffer) -> NlpposaveragedBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_pos_averaged_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_pos_averaged_buffer_copy(s : NlpposaveragedBuffer) -> NlpposaveragedBuffer {
  let result = nlp_pos_averaged_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_pos_averaged_buffer_fill(s : NlpposaveragedBuffer, v : Double) -> NlpposaveragedBuffer {
  let result = nlp_pos_averaged_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_averaged_buffer_min(s : NlpposaveragedBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_averaged_buffer_max(s : NlpposaveragedBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_averaged_buffer_to_string(s : NlpposaveragedBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpposaveragedCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_averaged_cursor_make(size : Int) -> NlpposaveragedCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_averaged_cursor_len(s : NlpposaveragedCursor) -> Int { s.size }

pub fn nlp_pos_averaged_cursor_get(s : NlpposaveragedCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_averaged_cursor_set(s : NlpposaveragedCursor, i : Int, v : Double) -> NlpposaveragedCursor {
  let result = nlp_pos_averaged_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_averaged_cursor_sum(s : NlpposaveragedCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_pos_averaged_cursor_mean(s : NlpposaveragedCursor) -> Double {
  if s.size == 0 { 0.0 } else { nlp_pos_averaged_cursor_sum(s) / s.size.to_double() }
}

pub fn nlp_pos_averaged_cursor_scale(s : NlpposaveragedCursor, f : Double) -> NlpposaveragedCursor {
  let result = nlp_pos_averaged_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_pos_averaged_cursor_add(a : NlpposaveragedCursor, b : NlpposaveragedCursor) -> NlpposaveragedCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_pos_averaged_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_pos_averaged_cursor_copy(s : NlpposaveragedCursor) -> NlpposaveragedCursor {
  let result = nlp_pos_averaged_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_pos_averaged_cursor_fill(s : NlpposaveragedCursor, v : Double) -> NlpposaveragedCursor {
  let result = nlp_pos_averaged_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_averaged_cursor_min(s : NlpposaveragedCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_averaged_cursor_max(s : NlpposaveragedCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_averaged_cursor_to_string(s : NlpposaveragedCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpposaveragedView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_averaged_view_make(size : Int) -> NlpposaveragedView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_averaged_view_len(s : NlpposaveragedView) -> Int { s.size }

pub fn nlp_pos_averaged_view_get(s : NlpposaveragedView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_averaged_view_set(s : NlpposaveragedView, i : Int, v : Double) -> NlpposaveragedView {
  let result = nlp_pos_averaged_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_averaged_view_sum(s : NlpposaveragedView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_pos_averaged_view_mean(s : NlpposaveragedView) -> Double {
  if s.size == 0 { 0.0 } else { nlp_pos_averaged_view_sum(s) / s.size.to_double() }
}

pub fn nlp_pos_averaged_view_scale(s : NlpposaveragedView, f : Double) -> NlpposaveragedView {
  let result = nlp_pos_averaged_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_pos_averaged_view_add(a : NlpposaveragedView, b : NlpposaveragedView) -> NlpposaveragedView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_pos_averaged_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_pos_averaged_view_copy(s : NlpposaveragedView) -> NlpposaveragedView {
  let result = nlp_pos_averaged_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_pos_averaged_view_fill(s : NlpposaveragedView, v : Double) -> NlpposaveragedView {
  let result = nlp_pos_averaged_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_averaged_view_min(s : NlpposaveragedView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_averaged_view_max(s : NlpposaveragedView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_averaged_view_to_string(s : NlpposaveragedView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpposaveragedRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_averaged_range_make(size : Int) -> NlpposaveragedRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_averaged_range_len(s : NlpposaveragedRange) -> Int { s.size }

pub fn nlp_pos_averaged_range_get(s : NlpposaveragedRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_averaged_range_set(s : NlpposaveragedRange, i : Int, v : Double) -> NlpposaveragedRange {
  let result = nlp_pos_averaged_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_averaged_range_sum(s : NlpposaveragedRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_pos_averaged_range_mean(s : NlpposaveragedRange) -> Double {
  if s.size == 0 { 0.0 } else { nlp_pos_averaged_range_sum(s) / s.size.to_double() }
}

pub fn nlp_pos_averaged_range_scale(s : NlpposaveragedRange, f : Double) -> NlpposaveragedRange {
  let result = nlp_pos_averaged_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_pos_averaged_range_add(a : NlpposaveragedRange, b : NlpposaveragedRange) -> NlpposaveragedRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_pos_averaged_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_pos_averaged_range_copy(s : NlpposaveragedRange) -> NlpposaveragedRange {
  let result = nlp_pos_averaged_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_pos_averaged_range_fill(s : NlpposaveragedRange, v : Double) -> NlpposaveragedRange {
  let result = nlp_pos_averaged_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_averaged_range_min(s : NlpposaveragedRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_averaged_range_max(s : NlpposaveragedRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_averaged_range_to_string(s : NlpposaveragedRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpposaveragedSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_averaged_slice_make(size : Int) -> NlpposaveragedSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_averaged_slice_len(s : NlpposaveragedSlice) -> Int { s.size }

pub fn nlp_pos_averaged_slice_get(s : NlpposaveragedSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_averaged_slice_set(s : NlpposaveragedSlice, i : Int, v : Double) -> NlpposaveragedSlice {
  let result = nlp_pos_averaged_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_averaged_slice_sum(s : NlpposaveragedSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_pos_averaged_slice_mean(s : NlpposaveragedSlice) -> Double {
  if s.size == 0 { 0.0 } else { nlp_pos_averaged_slice_sum(s) / s.size.to_double() }
}

pub fn nlp_pos_averaged_slice_scale(s : NlpposaveragedSlice, f : Double) -> NlpposaveragedSlice {
  let result = nlp_pos_averaged_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_pos_averaged_slice_add(a : NlpposaveragedSlice, b : NlpposaveragedSlice) -> NlpposaveragedSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_pos_averaged_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_pos_averaged_slice_copy(s : NlpposaveragedSlice) -> NlpposaveragedSlice {
  let result = nlp_pos_averaged_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_pos_averaged_slice_fill(s : NlpposaveragedSlice, v : Double) -> NlpposaveragedSlice {
  let result = nlp_pos_averaged_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_averaged_slice_min(s : NlpposaveragedSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_averaged_slice_max(s : NlpposaveragedSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_averaged_slice_to_string(s : NlpposaveragedSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn nlp_pos_averaged_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_pos_averaged_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_pos_averaged_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_pos_averaged_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_pos_averaged_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_pos_averaged_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_pos_averaged_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_pos_averaged_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_pos_averaged_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_pos_averaged_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_pos_averaged_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_pos_averaged_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_pos_averaged_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_pos_averaged_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_pos_averaged_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_pos_averaged_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_pos_averaged_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_pos_averaged_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_pos_averaged_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_pos_averaged_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_pos_averaged_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_pos_averaged_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_pos_averaged_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_pos_averaged_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_pos_averaged_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

