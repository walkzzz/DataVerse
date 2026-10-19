///===
/// extcore/nlp_pos_perceptron

pub(all) struct NlpposperceptronPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn nlp_pos_perceptron_make_point(x : Double, y : Double) -> NlpposperceptronPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn nlp_pos_perceptron_make_point3(x : Double, y : Double, z : Double) -> NlpposperceptronPoint {
  { x, y, z, label: 0 }
}

pub fn nlp_pos_perceptron_point_x(pt : NlpposperceptronPoint) -> Double { pt.x }

pub fn nlp_pos_perceptron_point_y(pt : NlpposperceptronPoint) -> Double { pt.y }

pub fn nlp_pos_perceptron_point_z(pt : NlpposperceptronPoint) -> Double { pt.z }

pub fn nlp_pos_perceptron_point_label(pt : NlpposperceptronPoint) -> Int { pt.label }

pub fn nlp_pos_perceptron_point_dist(a : NlpposperceptronPoint, b : NlpposperceptronPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  nlp_pos_perceptron_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn nlp_pos_perceptron_point_add(a : NlpposperceptronPoint, b : NlpposperceptronPoint) -> NlpposperceptronPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn nlp_pos_perceptron_point_sub(a : NlpposperceptronPoint, b : NlpposperceptronPoint) -> NlpposperceptronPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn nlp_pos_perceptron_point_scale(pt : NlpposperceptronPoint, s : Double) -> NlpposperceptronPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn nlp_pos_perceptron_point_dot(a : NlpposperceptronPoint, b : NlpposperceptronPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn nlp_pos_perceptron_point_cross(a : NlpposperceptronPoint, b : NlpposperceptronPoint) -> NlpposperceptronPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn nlp_pos_perceptron_point_norm(pt : NlpposperceptronPoint) -> Double {
  nlp_pos_perceptron_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn nlp_pos_perceptron_point_normalize(pt : NlpposperceptronPoint) -> NlpposperceptronPoint {
  let n = nlp_pos_perceptron_point_norm(pt)
  if n < 0.0000001 { pt } else { nlp_pos_perceptron_point_scale(pt, 1.0 / n) }
}

pub fn nlp_pos_perceptron_point_negate(pt : NlpposperceptronPoint) -> NlpposperceptronPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn nlp_pos_perceptron_point_mid(a : NlpposperceptronPoint, b : NlpposperceptronPoint) -> NlpposperceptronPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn nlp_pos_perceptron_point_lerp(a : NlpposperceptronPoint, b : NlpposperceptronPoint, t : Double) -> NlpposperceptronPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn nlp_pos_perceptron_point_to_string(pt : NlpposperceptronPoint) -> String {
  "(" + nlp_pos_perceptron_dbl(pt.x) + ", " + nlp_pos_perceptron_dbl(pt.y) + ", " + nlp_pos_perceptron_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct NlpposperceptronSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn nlp_pos_perceptron_make_series(vals : Array[Double], name : String) -> NlpposperceptronSeries {
  { vals, name, meta: 0 }
}

pub fn nlp_pos_perceptron_series_len(s : NlpposperceptronSeries) -> Int { s.vals.length() }

pub fn nlp_pos_perceptron_series_sum(s : NlpposperceptronSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn nlp_pos_perceptron_series_mean(s : NlpposperceptronSeries) -> Double {
  let n = nlp_pos_perceptron_series_len(s)
  if n == 0 { 0.0 } else { nlp_pos_perceptron_series_sum(s) / n.to_double() }
}

pub fn nlp_pos_perceptron_series_min(s : NlpposperceptronSeries) -> Double {
  let n = nlp_pos_perceptron_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn nlp_pos_perceptron_series_max(s : NlpposperceptronSeries) -> Double {
  let n = nlp_pos_perceptron_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn nlp_pos_perceptron_series_range(s : NlpposperceptronSeries) -> Double {
  nlp_pos_perceptron_series_max(s) - nlp_pos_perceptron_series_min(s)
}

pub fn nlp_pos_perceptron_series_var(s : NlpposperceptronSeries) -> Double {
  let n = nlp_pos_perceptron_series_len(s)
  if n == 0 { 0.0 } else {
    let m = nlp_pos_perceptron_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn nlp_pos_perceptron_series_std(s : NlpposperceptronSeries) -> Double { nlp_pos_perceptron_sqrt(nlp_pos_perceptron_series_var(s)) }

pub fn nlp_pos_perceptron_series_median(s : NlpposperceptronSeries) -> Double {
  let n = nlp_pos_perceptron_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = nlp_pos_perceptron_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn nlp_pos_perceptron_series_scale(s : NlpposperceptronSeries, f : Double) -> NlpposperceptronSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = nlp_pos_perceptron_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn nlp_pos_perceptron_series_add(a : NlpposperceptronSeries, b : NlpposperceptronSeries) -> NlpposperceptronSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = nlp_pos_perceptron_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn nlp_pos_perceptron_series_sub(a : NlpposperceptronSeries, b : NlpposperceptronSeries) -> NlpposperceptronSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = nlp_pos_perceptron_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn nlp_pos_perceptron_series_normalize(s : NlpposperceptronSeries) -> NlpposperceptronSeries {
  let mn = nlp_pos_perceptron_series_min(s)
  let mx = nlp_pos_perceptron_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = nlp_pos_perceptron_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn nlp_pos_perceptron_series_cumsum(s : NlpposperceptronSeries) -> NlpposperceptronSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = nlp_pos_perceptron_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn nlp_pos_perceptron_series_to_string(s : NlpposperceptronSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + nlp_pos_perceptron_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NlpposperceptronMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn nlp_pos_perceptron_make_matrix(rows : Int, cols : Int, val : Double) -> NlpposperceptronMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn nlp_pos_perceptron_matrix_identity(n : Int) -> NlpposperceptronMatrix {
  let m = nlp_pos_perceptron_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn nlp_pos_perceptron_matrix_get(m : NlpposperceptronMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn nlp_pos_perceptron_matrix_transpose(m : NlpposperceptronMatrix) -> NlpposperceptronMatrix {
  let result = nlp_pos_perceptron_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn nlp_pos_perceptron_matrix_add(a : NlpposperceptronMatrix, b : NlpposperceptronMatrix) -> NlpposperceptronMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = nlp_pos_perceptron_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn nlp_pos_perceptron_matrix_scale(m : NlpposperceptronMatrix, s : Double) -> NlpposperceptronMatrix {
  let result = nlp_pos_perceptron_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn nlp_pos_perceptron_matrix_multiply(a : NlpposperceptronMatrix, b : NlpposperceptronMatrix) -> NlpposperceptronMatrix {
  if a.cols != b.rows { return nlp_pos_perceptron_make_matrix(a.rows, b.cols, 0.0) }
  let result = nlp_pos_perceptron_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn nlp_pos_perceptron_matrix_trace(m : NlpposperceptronMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn nlp_pos_perceptron_matrix_det(m : NlpposperceptronMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn nlp_pos_perceptron_matrix_norm(m : NlpposperceptronMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  nlp_pos_perceptron_sqrt(sum)
}

pub fn nlp_pos_perceptron_matrix_to_string(m : NlpposperceptronMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + nlp_pos_perceptron_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct NlpposperceptronVector {
  comps : Array[Double]
  dim : Int
}

pub fn nlp_pos_perceptron_make_vector(comps : Array[Double]) -> NlpposperceptronVector {
  { comps, dim: comps.length() }
}

pub fn nlp_pos_perceptron_vector_zero(dim : Int) -> NlpposperceptronVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn nlp_pos_perceptron_vector_add(a : NlpposperceptronVector, b : NlpposperceptronVector) -> NlpposperceptronVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = nlp_pos_perceptron_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn nlp_pos_perceptron_vector_sub(a : NlpposperceptronVector, b : NlpposperceptronVector) -> NlpposperceptronVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = nlp_pos_perceptron_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn nlp_pos_perceptron_vector_scale(v : NlpposperceptronVector, s : Double) -> NlpposperceptronVector {
  let mut result = []
  for i in 0..<v.dim { result = nlp_pos_perceptron_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn nlp_pos_perceptron_vector_dot(a : NlpposperceptronVector, b : NlpposperceptronVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn nlp_pos_perceptron_vector_norm(v : NlpposperceptronVector) -> Double { nlp_pos_perceptron_sqrt(nlp_pos_perceptron_vector_dot(v, v)) }

pub fn nlp_pos_perceptron_vector_normalize(v : NlpposperceptronVector) -> NlpposperceptronVector {
  let n = nlp_pos_perceptron_vector_norm(v)
  if n < 0.0000001 { v } else { nlp_pos_perceptron_vector_scale(v, 1.0 / n) }
}

pub fn nlp_pos_perceptron_vector_dist(a : NlpposperceptronVector, b : NlpposperceptronVector) -> Double {
  nlp_pos_perceptron_vector_norm(nlp_pos_perceptron_vector_sub(a, b))
}

pub fn nlp_pos_perceptron_vector_to_string(v : NlpposperceptronVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + nlp_pos_perceptron_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn nlp_pos_perceptron_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn nlp_pos_perceptron_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = nlp_pos_perceptron_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn nlp_pos_perceptron_std(data : Array[Double]) -> Double { nlp_pos_perceptron_sqrt(nlp_pos_perceptron_var(data)) }

pub fn nlp_pos_perceptron_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = nlp_pos_perceptron_mean(a); let mb = nlp_pos_perceptron_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn nlp_pos_perceptron_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = nlp_pos_perceptron_std(a); let sb = nlp_pos_perceptron_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { nlp_pos_perceptron_cov(a, b) / (sa * sb) }
}

pub fn nlp_pos_perceptron_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = nlp_pos_perceptron_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn nlp_pos_perceptron_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn nlp_pos_perceptron_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn nlp_pos_perceptron_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  nlp_pos_perceptron_sqrt(nlp_pos_perceptron_mse(pred, labels))
}

pub fn nlp_pos_perceptron_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + nlp_pos_perceptron_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn nlp_pos_perceptron_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = nlp_pos_perceptron_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn nlp_pos_perceptron_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn nlp_pos_perceptron_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn nlp_pos_perceptron_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = nlp_pos_perceptron_precision(pred, labels, pos); let r = nlp_pos_perceptron_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn nlp_pos_perceptron_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn nlp_pos_perceptron_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = nlp_pos_perceptron_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn nlp_pos_perceptron_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn nlp_pos_perceptron_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn nlp_pos_perceptron_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = nlp_pos_perceptron_gcd(a, b)
    (a / g) * b
  }
}

pub fn nlp_pos_perceptron_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn nlp_pos_perceptron_fibonacci(n : Int) -> Int {
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

pub fn nlp_pos_perceptron_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = nlp_pos_perceptron_min(data); let mx = nlp_pos_perceptron_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn nlp_pos_perceptron_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = nlp_pos_perceptron_mean(data); let sd = nlp_pos_perceptron_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn nlp_pos_perceptron_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn nlp_pos_perceptron_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn nlp_pos_perceptron_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn nlp_pos_perceptron_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn nlp_pos_perceptron_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn nlp_pos_perceptron_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn nlp_pos_perceptron_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn nlp_pos_perceptron_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn nlp_pos_perceptron_dbl(x : Double) -> String {
  let i = if x >= 0.0 { nlp_pos_perceptron_int(x) } else { -nlp_pos_perceptron_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { nlp_pos_perceptron_int(f * 1000000.0) } else { nlp_pos_perceptron_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn nlp_pos_perceptron_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn nlp_pos_perceptron_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct NlpposperceptronFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_perceptron_frame_make(size : Int) -> NlpposperceptronFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_perceptron_frame_len(s : NlpposperceptronFrame) -> Int { s.size }

pub fn nlp_pos_perceptron_frame_get(s : NlpposperceptronFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_perceptron_frame_set(s : NlpposperceptronFrame, i : Int, v : Double) -> NlpposperceptronFrame {
  let result = nlp_pos_perceptron_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_perceptron_frame_sum(s : NlpposperceptronFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_pos_perceptron_frame_mean(s : NlpposperceptronFrame) -> Double {
  if s.size == 0 { 0.0 } else { nlp_pos_perceptron_frame_sum(s) / s.size.to_double() }
}

pub fn nlp_pos_perceptron_frame_scale(s : NlpposperceptronFrame, f : Double) -> NlpposperceptronFrame {
  let result = nlp_pos_perceptron_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_pos_perceptron_frame_add(a : NlpposperceptronFrame, b : NlpposperceptronFrame) -> NlpposperceptronFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_pos_perceptron_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_pos_perceptron_frame_copy(s : NlpposperceptronFrame) -> NlpposperceptronFrame {
  let result = nlp_pos_perceptron_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_pos_perceptron_frame_fill(s : NlpposperceptronFrame, v : Double) -> NlpposperceptronFrame {
  let result = nlp_pos_perceptron_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_perceptron_frame_min(s : NlpposperceptronFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_perceptron_frame_max(s : NlpposperceptronFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_perceptron_frame_to_string(s : NlpposperceptronFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpposperceptronTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_perceptron_table_make(size : Int) -> NlpposperceptronTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_perceptron_table_len(s : NlpposperceptronTable) -> Int { s.size }

pub fn nlp_pos_perceptron_table_get(s : NlpposperceptronTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_perceptron_table_set(s : NlpposperceptronTable, i : Int, v : Double) -> NlpposperceptronTable {
  let result = nlp_pos_perceptron_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_perceptron_table_sum(s : NlpposperceptronTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_pos_perceptron_table_mean(s : NlpposperceptronTable) -> Double {
  if s.size == 0 { 0.0 } else { nlp_pos_perceptron_table_sum(s) / s.size.to_double() }
}

pub fn nlp_pos_perceptron_table_scale(s : NlpposperceptronTable, f : Double) -> NlpposperceptronTable {
  let result = nlp_pos_perceptron_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_pos_perceptron_table_add(a : NlpposperceptronTable, b : NlpposperceptronTable) -> NlpposperceptronTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_pos_perceptron_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_pos_perceptron_table_copy(s : NlpposperceptronTable) -> NlpposperceptronTable {
  let result = nlp_pos_perceptron_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_pos_perceptron_table_fill(s : NlpposperceptronTable, v : Double) -> NlpposperceptronTable {
  let result = nlp_pos_perceptron_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_perceptron_table_min(s : NlpposperceptronTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_perceptron_table_max(s : NlpposperceptronTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_perceptron_table_to_string(s : NlpposperceptronTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpposperceptronGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_perceptron_graphn_make(size : Int) -> NlpposperceptronGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_perceptron_graphn_len(s : NlpposperceptronGraphN) -> Int { s.size }

pub fn nlp_pos_perceptron_graphn_get(s : NlpposperceptronGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_perceptron_graphn_set(s : NlpposperceptronGraphN, i : Int, v : Double) -> NlpposperceptronGraphN {
  let result = nlp_pos_perceptron_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_perceptron_graphn_sum(s : NlpposperceptronGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_pos_perceptron_graphn_mean(s : NlpposperceptronGraphN) -> Double {
  if s.size == 0 { 0.0 } else { nlp_pos_perceptron_graphn_sum(s) / s.size.to_double() }
}

pub fn nlp_pos_perceptron_graphn_scale(s : NlpposperceptronGraphN, f : Double) -> NlpposperceptronGraphN {
  let result = nlp_pos_perceptron_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_pos_perceptron_graphn_add(a : NlpposperceptronGraphN, b : NlpposperceptronGraphN) -> NlpposperceptronGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_pos_perceptron_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_pos_perceptron_graphn_copy(s : NlpposperceptronGraphN) -> NlpposperceptronGraphN {
  let result = nlp_pos_perceptron_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_pos_perceptron_graphn_fill(s : NlpposperceptronGraphN, v : Double) -> NlpposperceptronGraphN {
  let result = nlp_pos_perceptron_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_perceptron_graphn_min(s : NlpposperceptronGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_perceptron_graphn_max(s : NlpposperceptronGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_perceptron_graphn_to_string(s : NlpposperceptronGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpposperceptronNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_perceptron_node_make(size : Int) -> NlpposperceptronNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_perceptron_node_len(s : NlpposperceptronNode) -> Int { s.size }

pub fn nlp_pos_perceptron_node_get(s : NlpposperceptronNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_perceptron_node_set(s : NlpposperceptronNode, i : Int, v : Double) -> NlpposperceptronNode {
  let result = nlp_pos_perceptron_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_perceptron_node_sum(s : NlpposperceptronNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_pos_perceptron_node_mean(s : NlpposperceptronNode) -> Double {
  if s.size == 0 { 0.0 } else { nlp_pos_perceptron_node_sum(s) / s.size.to_double() }
}

pub fn nlp_pos_perceptron_node_scale(s : NlpposperceptronNode, f : Double) -> NlpposperceptronNode {
  let result = nlp_pos_perceptron_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_pos_perceptron_node_add(a : NlpposperceptronNode, b : NlpposperceptronNode) -> NlpposperceptronNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_pos_perceptron_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_pos_perceptron_node_copy(s : NlpposperceptronNode) -> NlpposperceptronNode {
  let result = nlp_pos_perceptron_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_pos_perceptron_node_fill(s : NlpposperceptronNode, v : Double) -> NlpposperceptronNode {
  let result = nlp_pos_perceptron_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_perceptron_node_min(s : NlpposperceptronNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_perceptron_node_max(s : NlpposperceptronNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_perceptron_node_to_string(s : NlpposperceptronNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpposperceptronEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_perceptron_edge_make(size : Int) -> NlpposperceptronEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_perceptron_edge_len(s : NlpposperceptronEdge) -> Int { s.size }

pub fn nlp_pos_perceptron_edge_get(s : NlpposperceptronEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_perceptron_edge_set(s : NlpposperceptronEdge, i : Int, v : Double) -> NlpposperceptronEdge {
  let result = nlp_pos_perceptron_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_perceptron_edge_sum(s : NlpposperceptronEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_pos_perceptron_edge_mean(s : NlpposperceptronEdge) -> Double {
  if s.size == 0 { 0.0 } else { nlp_pos_perceptron_edge_sum(s) / s.size.to_double() }
}

pub fn nlp_pos_perceptron_edge_scale(s : NlpposperceptronEdge, f : Double) -> NlpposperceptronEdge {
  let result = nlp_pos_perceptron_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_pos_perceptron_edge_add(a : NlpposperceptronEdge, b : NlpposperceptronEdge) -> NlpposperceptronEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_pos_perceptron_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_pos_perceptron_edge_copy(s : NlpposperceptronEdge) -> NlpposperceptronEdge {
  let result = nlp_pos_perceptron_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_pos_perceptron_edge_fill(s : NlpposperceptronEdge, v : Double) -> NlpposperceptronEdge {
  let result = nlp_pos_perceptron_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_perceptron_edge_min(s : NlpposperceptronEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_perceptron_edge_max(s : NlpposperceptronEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_perceptron_edge_to_string(s : NlpposperceptronEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpposperceptronPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_perceptron_path_make(size : Int) -> NlpposperceptronPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_perceptron_path_len(s : NlpposperceptronPath) -> Int { s.size }

pub fn nlp_pos_perceptron_path_get(s : NlpposperceptronPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_perceptron_path_set(s : NlpposperceptronPath, i : Int, v : Double) -> NlpposperceptronPath {
  let result = nlp_pos_perceptron_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_perceptron_path_sum(s : NlpposperceptronPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_pos_perceptron_path_mean(s : NlpposperceptronPath) -> Double {
  if s.size == 0 { 0.0 } else { nlp_pos_perceptron_path_sum(s) / s.size.to_double() }
}

pub fn nlp_pos_perceptron_path_scale(s : NlpposperceptronPath, f : Double) -> NlpposperceptronPath {
  let result = nlp_pos_perceptron_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_pos_perceptron_path_add(a : NlpposperceptronPath, b : NlpposperceptronPath) -> NlpposperceptronPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_pos_perceptron_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_pos_perceptron_path_copy(s : NlpposperceptronPath) -> NlpposperceptronPath {
  let result = nlp_pos_perceptron_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_pos_perceptron_path_fill(s : NlpposperceptronPath, v : Double) -> NlpposperceptronPath {
  let result = nlp_pos_perceptron_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_perceptron_path_min(s : NlpposperceptronPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_perceptron_path_max(s : NlpposperceptronPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_perceptron_path_to_string(s : NlpposperceptronPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpposperceptronCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_perceptron_cluster_make(size : Int) -> NlpposperceptronCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_perceptron_cluster_len(s : NlpposperceptronCluster) -> Int { s.size }

pub fn nlp_pos_perceptron_cluster_get(s : NlpposperceptronCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_perceptron_cluster_set(s : NlpposperceptronCluster, i : Int, v : Double) -> NlpposperceptronCluster {
  let result = nlp_pos_perceptron_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_perceptron_cluster_sum(s : NlpposperceptronCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_pos_perceptron_cluster_mean(s : NlpposperceptronCluster) -> Double {
  if s.size == 0 { 0.0 } else { nlp_pos_perceptron_cluster_sum(s) / s.size.to_double() }
}

pub fn nlp_pos_perceptron_cluster_scale(s : NlpposperceptronCluster, f : Double) -> NlpposperceptronCluster {
  let result = nlp_pos_perceptron_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_pos_perceptron_cluster_add(a : NlpposperceptronCluster, b : NlpposperceptronCluster) -> NlpposperceptronCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_pos_perceptron_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_pos_perceptron_cluster_copy(s : NlpposperceptronCluster) -> NlpposperceptronCluster {
  let result = nlp_pos_perceptron_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_pos_perceptron_cluster_fill(s : NlpposperceptronCluster, v : Double) -> NlpposperceptronCluster {
  let result = nlp_pos_perceptron_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_perceptron_cluster_min(s : NlpposperceptronCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_perceptron_cluster_max(s : NlpposperceptronCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_perceptron_cluster_to_string(s : NlpposperceptronCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpposperceptronModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_perceptron_model_make(size : Int) -> NlpposperceptronModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_perceptron_model_len(s : NlpposperceptronModel) -> Int { s.size }

pub fn nlp_pos_perceptron_model_get(s : NlpposperceptronModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_perceptron_model_set(s : NlpposperceptronModel, i : Int, v : Double) -> NlpposperceptronModel {
  let result = nlp_pos_perceptron_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_perceptron_model_sum(s : NlpposperceptronModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_pos_perceptron_model_mean(s : NlpposperceptronModel) -> Double {
  if s.size == 0 { 0.0 } else { nlp_pos_perceptron_model_sum(s) / s.size.to_double() }
}

pub fn nlp_pos_perceptron_model_scale(s : NlpposperceptronModel, f : Double) -> NlpposperceptronModel {
  let result = nlp_pos_perceptron_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_pos_perceptron_model_add(a : NlpposperceptronModel, b : NlpposperceptronModel) -> NlpposperceptronModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_pos_perceptron_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_pos_perceptron_model_copy(s : NlpposperceptronModel) -> NlpposperceptronModel {
  let result = nlp_pos_perceptron_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_pos_perceptron_model_fill(s : NlpposperceptronModel, v : Double) -> NlpposperceptronModel {
  let result = nlp_pos_perceptron_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_perceptron_model_min(s : NlpposperceptronModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_perceptron_model_max(s : NlpposperceptronModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_perceptron_model_to_string(s : NlpposperceptronModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpposperceptronLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_perceptron_layer_make(size : Int) -> NlpposperceptronLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_perceptron_layer_len(s : NlpposperceptronLayer) -> Int { s.size }

pub fn nlp_pos_perceptron_layer_get(s : NlpposperceptronLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_perceptron_layer_set(s : NlpposperceptronLayer, i : Int, v : Double) -> NlpposperceptronLayer {
  let result = nlp_pos_perceptron_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_perceptron_layer_sum(s : NlpposperceptronLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_pos_perceptron_layer_mean(s : NlpposperceptronLayer) -> Double {
  if s.size == 0 { 0.0 } else { nlp_pos_perceptron_layer_sum(s) / s.size.to_double() }
}

pub fn nlp_pos_perceptron_layer_scale(s : NlpposperceptronLayer, f : Double) -> NlpposperceptronLayer {
  let result = nlp_pos_perceptron_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_pos_perceptron_layer_add(a : NlpposperceptronLayer, b : NlpposperceptronLayer) -> NlpposperceptronLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_pos_perceptron_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_pos_perceptron_layer_copy(s : NlpposperceptronLayer) -> NlpposperceptronLayer {
  let result = nlp_pos_perceptron_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_pos_perceptron_layer_fill(s : NlpposperceptronLayer, v : Double) -> NlpposperceptronLayer {
  let result = nlp_pos_perceptron_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_perceptron_layer_min(s : NlpposperceptronLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_perceptron_layer_max(s : NlpposperceptronLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_perceptron_layer_to_string(s : NlpposperceptronLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpposperceptronBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_perceptron_buffer_make(size : Int) -> NlpposperceptronBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_perceptron_buffer_len(s : NlpposperceptronBuffer) -> Int { s.size }

pub fn nlp_pos_perceptron_buffer_get(s : NlpposperceptronBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_perceptron_buffer_set(s : NlpposperceptronBuffer, i : Int, v : Double) -> NlpposperceptronBuffer {
  let result = nlp_pos_perceptron_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_perceptron_buffer_sum(s : NlpposperceptronBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_pos_perceptron_buffer_mean(s : NlpposperceptronBuffer) -> Double {
  if s.size == 0 { 0.0 } else { nlp_pos_perceptron_buffer_sum(s) / s.size.to_double() }
}

pub fn nlp_pos_perceptron_buffer_scale(s : NlpposperceptronBuffer, f : Double) -> NlpposperceptronBuffer {
  let result = nlp_pos_perceptron_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_pos_perceptron_buffer_add(a : NlpposperceptronBuffer, b : NlpposperceptronBuffer) -> NlpposperceptronBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_pos_perceptron_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_pos_perceptron_buffer_copy(s : NlpposperceptronBuffer) -> NlpposperceptronBuffer {
  let result = nlp_pos_perceptron_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_pos_perceptron_buffer_fill(s : NlpposperceptronBuffer, v : Double) -> NlpposperceptronBuffer {
  let result = nlp_pos_perceptron_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_perceptron_buffer_min(s : NlpposperceptronBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_perceptron_buffer_max(s : NlpposperceptronBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_perceptron_buffer_to_string(s : NlpposperceptronBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpposperceptronCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_perceptron_cursor_make(size : Int) -> NlpposperceptronCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_perceptron_cursor_len(s : NlpposperceptronCursor) -> Int { s.size }

pub fn nlp_pos_perceptron_cursor_get(s : NlpposperceptronCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_perceptron_cursor_set(s : NlpposperceptronCursor, i : Int, v : Double) -> NlpposperceptronCursor {
  let result = nlp_pos_perceptron_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_perceptron_cursor_sum(s : NlpposperceptronCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_pos_perceptron_cursor_mean(s : NlpposperceptronCursor) -> Double {
  if s.size == 0 { 0.0 } else { nlp_pos_perceptron_cursor_sum(s) / s.size.to_double() }
}

pub fn nlp_pos_perceptron_cursor_scale(s : NlpposperceptronCursor, f : Double) -> NlpposperceptronCursor {
  let result = nlp_pos_perceptron_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_pos_perceptron_cursor_add(a : NlpposperceptronCursor, b : NlpposperceptronCursor) -> NlpposperceptronCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_pos_perceptron_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_pos_perceptron_cursor_copy(s : NlpposperceptronCursor) -> NlpposperceptronCursor {
  let result = nlp_pos_perceptron_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_pos_perceptron_cursor_fill(s : NlpposperceptronCursor, v : Double) -> NlpposperceptronCursor {
  let result = nlp_pos_perceptron_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_perceptron_cursor_min(s : NlpposperceptronCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_perceptron_cursor_max(s : NlpposperceptronCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_perceptron_cursor_to_string(s : NlpposperceptronCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpposperceptronView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_perceptron_view_make(size : Int) -> NlpposperceptronView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_perceptron_view_len(s : NlpposperceptronView) -> Int { s.size }

pub fn nlp_pos_perceptron_view_get(s : NlpposperceptronView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_perceptron_view_set(s : NlpposperceptronView, i : Int, v : Double) -> NlpposperceptronView {
  let result = nlp_pos_perceptron_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_perceptron_view_sum(s : NlpposperceptronView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_pos_perceptron_view_mean(s : NlpposperceptronView) -> Double {
  if s.size == 0 { 0.0 } else { nlp_pos_perceptron_view_sum(s) / s.size.to_double() }
}

pub fn nlp_pos_perceptron_view_scale(s : NlpposperceptronView, f : Double) -> NlpposperceptronView {
  let result = nlp_pos_perceptron_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_pos_perceptron_view_add(a : NlpposperceptronView, b : NlpposperceptronView) -> NlpposperceptronView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_pos_perceptron_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_pos_perceptron_view_copy(s : NlpposperceptronView) -> NlpposperceptronView {
  let result = nlp_pos_perceptron_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_pos_perceptron_view_fill(s : NlpposperceptronView, v : Double) -> NlpposperceptronView {
  let result = nlp_pos_perceptron_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_perceptron_view_min(s : NlpposperceptronView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_perceptron_view_max(s : NlpposperceptronView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_perceptron_view_to_string(s : NlpposperceptronView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpposperceptronRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_perceptron_range_make(size : Int) -> NlpposperceptronRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_perceptron_range_len(s : NlpposperceptronRange) -> Int { s.size }

pub fn nlp_pos_perceptron_range_get(s : NlpposperceptronRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_perceptron_range_set(s : NlpposperceptronRange, i : Int, v : Double) -> NlpposperceptronRange {
  let result = nlp_pos_perceptron_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_perceptron_range_sum(s : NlpposperceptronRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_pos_perceptron_range_mean(s : NlpposperceptronRange) -> Double {
  if s.size == 0 { 0.0 } else { nlp_pos_perceptron_range_sum(s) / s.size.to_double() }
}

pub fn nlp_pos_perceptron_range_scale(s : NlpposperceptronRange, f : Double) -> NlpposperceptronRange {
  let result = nlp_pos_perceptron_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_pos_perceptron_range_add(a : NlpposperceptronRange, b : NlpposperceptronRange) -> NlpposperceptronRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_pos_perceptron_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_pos_perceptron_range_copy(s : NlpposperceptronRange) -> NlpposperceptronRange {
  let result = nlp_pos_perceptron_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_pos_perceptron_range_fill(s : NlpposperceptronRange, v : Double) -> NlpposperceptronRange {
  let result = nlp_pos_perceptron_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_perceptron_range_min(s : NlpposperceptronRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_perceptron_range_max(s : NlpposperceptronRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_perceptron_range_to_string(s : NlpposperceptronRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpposperceptronSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_perceptron_slice_make(size : Int) -> NlpposperceptronSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_perceptron_slice_len(s : NlpposperceptronSlice) -> Int { s.size }

pub fn nlp_pos_perceptron_slice_get(s : NlpposperceptronSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_perceptron_slice_set(s : NlpposperceptronSlice, i : Int, v : Double) -> NlpposperceptronSlice {
  let result = nlp_pos_perceptron_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_perceptron_slice_sum(s : NlpposperceptronSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_pos_perceptron_slice_mean(s : NlpposperceptronSlice) -> Double {
  if s.size == 0 { 0.0 } else { nlp_pos_perceptron_slice_sum(s) / s.size.to_double() }
}

pub fn nlp_pos_perceptron_slice_scale(s : NlpposperceptronSlice, f : Double) -> NlpposperceptronSlice {
  let result = nlp_pos_perceptron_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_pos_perceptron_slice_add(a : NlpposperceptronSlice, b : NlpposperceptronSlice) -> NlpposperceptronSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_pos_perceptron_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_pos_perceptron_slice_copy(s : NlpposperceptronSlice) -> NlpposperceptronSlice {
  let result = nlp_pos_perceptron_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_pos_perceptron_slice_fill(s : NlpposperceptronSlice, v : Double) -> NlpposperceptronSlice {
  let result = nlp_pos_perceptron_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_perceptron_slice_min(s : NlpposperceptronSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_perceptron_slice_max(s : NlpposperceptronSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_perceptron_slice_to_string(s : NlpposperceptronSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn nlp_pos_perceptron_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_pos_perceptron_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_pos_perceptron_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_pos_perceptron_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_pos_perceptron_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_pos_perceptron_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_pos_perceptron_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_pos_perceptron_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_pos_perceptron_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_pos_perceptron_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_pos_perceptron_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_pos_perceptron_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_pos_perceptron_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_pos_perceptron_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_pos_perceptron_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_pos_perceptron_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_pos_perceptron_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_pos_perceptron_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_pos_perceptron_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_pos_perceptron_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_pos_perceptron_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_pos_perceptron_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_pos_perceptron_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_pos_perceptron_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_pos_perceptron_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

