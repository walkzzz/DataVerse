///===
/// extcore/ml_neural_rnn

pub(all) struct MlneuralrnnPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_neural_rnn_make_point(x : Double, y : Double) -> MlneuralrnnPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_neural_rnn_make_point3(x : Double, y : Double, z : Double) -> MlneuralrnnPoint {
  { x, y, z, label: 0 }
}

pub fn ml_neural_rnn_point_x(pt : MlneuralrnnPoint) -> Double { pt.x }

pub fn ml_neural_rnn_point_y(pt : MlneuralrnnPoint) -> Double { pt.y }

pub fn ml_neural_rnn_point_z(pt : MlneuralrnnPoint) -> Double { pt.z }

pub fn ml_neural_rnn_point_label(pt : MlneuralrnnPoint) -> Int { pt.label }

pub fn ml_neural_rnn_point_dist(a : MlneuralrnnPoint, b : MlneuralrnnPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  ml_neural_rnn_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ml_neural_rnn_point_add(a : MlneuralrnnPoint, b : MlneuralrnnPoint) -> MlneuralrnnPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn ml_neural_rnn_point_sub(a : MlneuralrnnPoint, b : MlneuralrnnPoint) -> MlneuralrnnPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn ml_neural_rnn_point_scale(pt : MlneuralrnnPoint, s : Double) -> MlneuralrnnPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn ml_neural_rnn_point_dot(a : MlneuralrnnPoint, b : MlneuralrnnPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn ml_neural_rnn_point_cross(a : MlneuralrnnPoint, b : MlneuralrnnPoint) -> MlneuralrnnPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn ml_neural_rnn_point_norm(pt : MlneuralrnnPoint) -> Double {
  ml_neural_rnn_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn ml_neural_rnn_point_normalize(pt : MlneuralrnnPoint) -> MlneuralrnnPoint {
  let n = ml_neural_rnn_point_norm(pt)
  if n < 0.0000001 { pt } else { ml_neural_rnn_point_scale(pt, 1.0 / n) }
}

pub fn ml_neural_rnn_point_negate(pt : MlneuralrnnPoint) -> MlneuralrnnPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn ml_neural_rnn_point_mid(a : MlneuralrnnPoint, b : MlneuralrnnPoint) -> MlneuralrnnPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn ml_neural_rnn_point_lerp(a : MlneuralrnnPoint, b : MlneuralrnnPoint, t : Double) -> MlneuralrnnPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn ml_neural_rnn_point_to_string(pt : MlneuralrnnPoint) -> String {
  "(" + ml_neural_rnn_dbl(pt.x) + ", " + ml_neural_rnn_dbl(pt.y) + ", " + ml_neural_rnn_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct MlneuralrnnSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_neural_rnn_make_series(vals : Array[Double], name : String) -> MlneuralrnnSeries {
  { vals, name, meta: 0 }
}

pub fn ml_neural_rnn_series_len(s : MlneuralrnnSeries) -> Int { s.vals.length() }

pub fn ml_neural_rnn_series_sum(s : MlneuralrnnSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn ml_neural_rnn_series_mean(s : MlneuralrnnSeries) -> Double {
  let n = ml_neural_rnn_series_len(s)
  if n == 0 { 0.0 } else { ml_neural_rnn_series_sum(s) / n.to_double() }
}

pub fn ml_neural_rnn_series_min(s : MlneuralrnnSeries) -> Double {
  let n = ml_neural_rnn_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn ml_neural_rnn_series_max(s : MlneuralrnnSeries) -> Double {
  let n = ml_neural_rnn_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn ml_neural_rnn_series_range(s : MlneuralrnnSeries) -> Double {
  ml_neural_rnn_series_max(s) - ml_neural_rnn_series_min(s)
}

pub fn ml_neural_rnn_series_var(s : MlneuralrnnSeries) -> Double {
  let n = ml_neural_rnn_series_len(s)
  if n == 0 { 0.0 } else {
    let m = ml_neural_rnn_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn ml_neural_rnn_series_std(s : MlneuralrnnSeries) -> Double { ml_neural_rnn_sqrt(ml_neural_rnn_series_var(s)) }

pub fn ml_neural_rnn_series_median(s : MlneuralrnnSeries) -> Double {
  let n = ml_neural_rnn_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = ml_neural_rnn_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn ml_neural_rnn_series_scale(s : MlneuralrnnSeries, f : Double) -> MlneuralrnnSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = ml_neural_rnn_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn ml_neural_rnn_series_add(a : MlneuralrnnSeries, b : MlneuralrnnSeries) -> MlneuralrnnSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = ml_neural_rnn_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn ml_neural_rnn_series_sub(a : MlneuralrnnSeries, b : MlneuralrnnSeries) -> MlneuralrnnSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = ml_neural_rnn_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn ml_neural_rnn_series_normalize(s : MlneuralrnnSeries) -> MlneuralrnnSeries {
  let mn = ml_neural_rnn_series_min(s)
  let mx = ml_neural_rnn_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = ml_neural_rnn_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn ml_neural_rnn_series_cumsum(s : MlneuralrnnSeries) -> MlneuralrnnSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = ml_neural_rnn_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn ml_neural_rnn_series_to_string(s : MlneuralrnnSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + ml_neural_rnn_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlneuralrnnMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_neural_rnn_make_matrix(rows : Int, cols : Int, val : Double) -> MlneuralrnnMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_neural_rnn_matrix_identity(n : Int) -> MlneuralrnnMatrix {
  let m = ml_neural_rnn_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ml_neural_rnn_matrix_get(m : MlneuralrnnMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn ml_neural_rnn_matrix_transpose(m : MlneuralrnnMatrix) -> MlneuralrnnMatrix {
  let result = ml_neural_rnn_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn ml_neural_rnn_matrix_add(a : MlneuralrnnMatrix, b : MlneuralrnnMatrix) -> MlneuralrnnMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = ml_neural_rnn_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn ml_neural_rnn_matrix_scale(m : MlneuralrnnMatrix, s : Double) -> MlneuralrnnMatrix {
  let result = ml_neural_rnn_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn ml_neural_rnn_matrix_multiply(a : MlneuralrnnMatrix, b : MlneuralrnnMatrix) -> MlneuralrnnMatrix {
  if a.cols != b.rows { return ml_neural_rnn_make_matrix(a.rows, b.cols, 0.0) }
  let result = ml_neural_rnn_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ml_neural_rnn_matrix_trace(m : MlneuralrnnMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn ml_neural_rnn_matrix_det(m : MlneuralrnnMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ml_neural_rnn_matrix_norm(m : MlneuralrnnMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  ml_neural_rnn_sqrt(sum)
}

pub fn ml_neural_rnn_matrix_to_string(m : MlneuralrnnMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + ml_neural_rnn_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct MlneuralrnnVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_neural_rnn_make_vector(comps : Array[Double]) -> MlneuralrnnVector {
  { comps, dim: comps.length() }
}

pub fn ml_neural_rnn_vector_zero(dim : Int) -> MlneuralrnnVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ml_neural_rnn_vector_add(a : MlneuralrnnVector, b : MlneuralrnnVector) -> MlneuralrnnVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = ml_neural_rnn_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ml_neural_rnn_vector_sub(a : MlneuralrnnVector, b : MlneuralrnnVector) -> MlneuralrnnVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = ml_neural_rnn_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ml_neural_rnn_vector_scale(v : MlneuralrnnVector, s : Double) -> MlneuralrnnVector {
  let mut result = []
  for i in 0..<v.dim { result = ml_neural_rnn_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn ml_neural_rnn_vector_dot(a : MlneuralrnnVector, b : MlneuralrnnVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn ml_neural_rnn_vector_norm(v : MlneuralrnnVector) -> Double { ml_neural_rnn_sqrt(ml_neural_rnn_vector_dot(v, v)) }

pub fn ml_neural_rnn_vector_normalize(v : MlneuralrnnVector) -> MlneuralrnnVector {
  let n = ml_neural_rnn_vector_norm(v)
  if n < 0.0000001 { v } else { ml_neural_rnn_vector_scale(v, 1.0 / n) }
}

pub fn ml_neural_rnn_vector_dist(a : MlneuralrnnVector, b : MlneuralrnnVector) -> Double {
  ml_neural_rnn_vector_norm(ml_neural_rnn_vector_sub(a, b))
}

pub fn ml_neural_rnn_vector_to_string(v : MlneuralrnnVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + ml_neural_rnn_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ml_neural_rnn_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn ml_neural_rnn_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = ml_neural_rnn_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn ml_neural_rnn_std(data : Array[Double]) -> Double { ml_neural_rnn_sqrt(ml_neural_rnn_var(data)) }

pub fn ml_neural_rnn_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = ml_neural_rnn_mean(a); let mb = ml_neural_rnn_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn ml_neural_rnn_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = ml_neural_rnn_std(a); let sb = ml_neural_rnn_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { ml_neural_rnn_cov(a, b) / (sa * sb) }
}

pub fn ml_neural_rnn_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = ml_neural_rnn_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn ml_neural_rnn_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn ml_neural_rnn_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn ml_neural_rnn_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  ml_neural_rnn_sqrt(ml_neural_rnn_mse(pred, labels))
}

pub fn ml_neural_rnn_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + ml_neural_rnn_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn ml_neural_rnn_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = ml_neural_rnn_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn ml_neural_rnn_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn ml_neural_rnn_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn ml_neural_rnn_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = ml_neural_rnn_precision(pred, labels, pos); let r = ml_neural_rnn_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn ml_neural_rnn_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn ml_neural_rnn_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = ml_neural_rnn_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn ml_neural_rnn_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn ml_neural_rnn_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn ml_neural_rnn_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = ml_neural_rnn_gcd(a, b)
    (a / g) * b
  }
}

pub fn ml_neural_rnn_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn ml_neural_rnn_fibonacci(n : Int) -> Int {
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

pub fn ml_neural_rnn_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = ml_neural_rnn_min(data); let mx = ml_neural_rnn_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn ml_neural_rnn_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = ml_neural_rnn_mean(data); let sd = ml_neural_rnn_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn ml_neural_rnn_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn ml_neural_rnn_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn ml_neural_rnn_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn ml_neural_rnn_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn ml_neural_rnn_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn ml_neural_rnn_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn ml_neural_rnn_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn ml_neural_rnn_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn ml_neural_rnn_dbl(x : Double) -> String {
  let i = if x >= 0.0 { ml_neural_rnn_int(x) } else { -ml_neural_rnn_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { ml_neural_rnn_int(f * 1000000.0) } else { ml_neural_rnn_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn ml_neural_rnn_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn ml_neural_rnn_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct MlneuralrnnFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_rnn_frame_make(size : Int) -> MlneuralrnnFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_rnn_frame_len(s : MlneuralrnnFrame) -> Int { s.size }

pub fn ml_neural_rnn_frame_get(s : MlneuralrnnFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_rnn_frame_set(s : MlneuralrnnFrame, i : Int, v : Double) -> MlneuralrnnFrame {
  let result = ml_neural_rnn_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_neural_rnn_frame_sum(s : MlneuralrnnFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_neural_rnn_frame_mean(s : MlneuralrnnFrame) -> Double {
  if s.size == 0 { 0.0 } else { ml_neural_rnn_frame_sum(s) / s.size.to_double() }
}

pub fn ml_neural_rnn_frame_scale(s : MlneuralrnnFrame, f : Double) -> MlneuralrnnFrame {
  let result = ml_neural_rnn_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_neural_rnn_frame_add(a : MlneuralrnnFrame, b : MlneuralrnnFrame) -> MlneuralrnnFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_neural_rnn_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_neural_rnn_frame_copy(s : MlneuralrnnFrame) -> MlneuralrnnFrame {
  let result = ml_neural_rnn_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_neural_rnn_frame_fill(s : MlneuralrnnFrame, v : Double) -> MlneuralrnnFrame {
  let result = ml_neural_rnn_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_neural_rnn_frame_min(s : MlneuralrnnFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_neural_rnn_frame_max(s : MlneuralrnnFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_neural_rnn_frame_to_string(s : MlneuralrnnFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuralrnnTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_rnn_table_make(size : Int) -> MlneuralrnnTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_rnn_table_len(s : MlneuralrnnTable) -> Int { s.size }

pub fn ml_neural_rnn_table_get(s : MlneuralrnnTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_rnn_table_set(s : MlneuralrnnTable, i : Int, v : Double) -> MlneuralrnnTable {
  let result = ml_neural_rnn_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_neural_rnn_table_sum(s : MlneuralrnnTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_neural_rnn_table_mean(s : MlneuralrnnTable) -> Double {
  if s.size == 0 { 0.0 } else { ml_neural_rnn_table_sum(s) / s.size.to_double() }
}

pub fn ml_neural_rnn_table_scale(s : MlneuralrnnTable, f : Double) -> MlneuralrnnTable {
  let result = ml_neural_rnn_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_neural_rnn_table_add(a : MlneuralrnnTable, b : MlneuralrnnTable) -> MlneuralrnnTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_neural_rnn_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_neural_rnn_table_copy(s : MlneuralrnnTable) -> MlneuralrnnTable {
  let result = ml_neural_rnn_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_neural_rnn_table_fill(s : MlneuralrnnTable, v : Double) -> MlneuralrnnTable {
  let result = ml_neural_rnn_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_neural_rnn_table_min(s : MlneuralrnnTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_neural_rnn_table_max(s : MlneuralrnnTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_neural_rnn_table_to_string(s : MlneuralrnnTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuralrnnGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_rnn_graphn_make(size : Int) -> MlneuralrnnGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_rnn_graphn_len(s : MlneuralrnnGraphN) -> Int { s.size }

pub fn ml_neural_rnn_graphn_get(s : MlneuralrnnGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_rnn_graphn_set(s : MlneuralrnnGraphN, i : Int, v : Double) -> MlneuralrnnGraphN {
  let result = ml_neural_rnn_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_neural_rnn_graphn_sum(s : MlneuralrnnGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_neural_rnn_graphn_mean(s : MlneuralrnnGraphN) -> Double {
  if s.size == 0 { 0.0 } else { ml_neural_rnn_graphn_sum(s) / s.size.to_double() }
}

pub fn ml_neural_rnn_graphn_scale(s : MlneuralrnnGraphN, f : Double) -> MlneuralrnnGraphN {
  let result = ml_neural_rnn_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_neural_rnn_graphn_add(a : MlneuralrnnGraphN, b : MlneuralrnnGraphN) -> MlneuralrnnGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_neural_rnn_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_neural_rnn_graphn_copy(s : MlneuralrnnGraphN) -> MlneuralrnnGraphN {
  let result = ml_neural_rnn_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_neural_rnn_graphn_fill(s : MlneuralrnnGraphN, v : Double) -> MlneuralrnnGraphN {
  let result = ml_neural_rnn_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_neural_rnn_graphn_min(s : MlneuralrnnGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_neural_rnn_graphn_max(s : MlneuralrnnGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_neural_rnn_graphn_to_string(s : MlneuralrnnGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuralrnnNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_rnn_node_make(size : Int) -> MlneuralrnnNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_rnn_node_len(s : MlneuralrnnNode) -> Int { s.size }

pub fn ml_neural_rnn_node_get(s : MlneuralrnnNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_rnn_node_set(s : MlneuralrnnNode, i : Int, v : Double) -> MlneuralrnnNode {
  let result = ml_neural_rnn_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_neural_rnn_node_sum(s : MlneuralrnnNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_neural_rnn_node_mean(s : MlneuralrnnNode) -> Double {
  if s.size == 0 { 0.0 } else { ml_neural_rnn_node_sum(s) / s.size.to_double() }
}

pub fn ml_neural_rnn_node_scale(s : MlneuralrnnNode, f : Double) -> MlneuralrnnNode {
  let result = ml_neural_rnn_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_neural_rnn_node_add(a : MlneuralrnnNode, b : MlneuralrnnNode) -> MlneuralrnnNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_neural_rnn_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_neural_rnn_node_copy(s : MlneuralrnnNode) -> MlneuralrnnNode {
  let result = ml_neural_rnn_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_neural_rnn_node_fill(s : MlneuralrnnNode, v : Double) -> MlneuralrnnNode {
  let result = ml_neural_rnn_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_neural_rnn_node_min(s : MlneuralrnnNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_neural_rnn_node_max(s : MlneuralrnnNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_neural_rnn_node_to_string(s : MlneuralrnnNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuralrnnEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_rnn_edge_make(size : Int) -> MlneuralrnnEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_rnn_edge_len(s : MlneuralrnnEdge) -> Int { s.size }

pub fn ml_neural_rnn_edge_get(s : MlneuralrnnEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_rnn_edge_set(s : MlneuralrnnEdge, i : Int, v : Double) -> MlneuralrnnEdge {
  let result = ml_neural_rnn_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_neural_rnn_edge_sum(s : MlneuralrnnEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_neural_rnn_edge_mean(s : MlneuralrnnEdge) -> Double {
  if s.size == 0 { 0.0 } else { ml_neural_rnn_edge_sum(s) / s.size.to_double() }
}

pub fn ml_neural_rnn_edge_scale(s : MlneuralrnnEdge, f : Double) -> MlneuralrnnEdge {
  let result = ml_neural_rnn_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_neural_rnn_edge_add(a : MlneuralrnnEdge, b : MlneuralrnnEdge) -> MlneuralrnnEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_neural_rnn_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_neural_rnn_edge_copy(s : MlneuralrnnEdge) -> MlneuralrnnEdge {
  let result = ml_neural_rnn_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_neural_rnn_edge_fill(s : MlneuralrnnEdge, v : Double) -> MlneuralrnnEdge {
  let result = ml_neural_rnn_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_neural_rnn_edge_min(s : MlneuralrnnEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_neural_rnn_edge_max(s : MlneuralrnnEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_neural_rnn_edge_to_string(s : MlneuralrnnEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuralrnnPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_rnn_path_make(size : Int) -> MlneuralrnnPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_rnn_path_len(s : MlneuralrnnPath) -> Int { s.size }

pub fn ml_neural_rnn_path_get(s : MlneuralrnnPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_rnn_path_set(s : MlneuralrnnPath, i : Int, v : Double) -> MlneuralrnnPath {
  let result = ml_neural_rnn_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_neural_rnn_path_sum(s : MlneuralrnnPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_neural_rnn_path_mean(s : MlneuralrnnPath) -> Double {
  if s.size == 0 { 0.0 } else { ml_neural_rnn_path_sum(s) / s.size.to_double() }
}

pub fn ml_neural_rnn_path_scale(s : MlneuralrnnPath, f : Double) -> MlneuralrnnPath {
  let result = ml_neural_rnn_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_neural_rnn_path_add(a : MlneuralrnnPath, b : MlneuralrnnPath) -> MlneuralrnnPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_neural_rnn_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_neural_rnn_path_copy(s : MlneuralrnnPath) -> MlneuralrnnPath {
  let result = ml_neural_rnn_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_neural_rnn_path_fill(s : MlneuralrnnPath, v : Double) -> MlneuralrnnPath {
  let result = ml_neural_rnn_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_neural_rnn_path_min(s : MlneuralrnnPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_neural_rnn_path_max(s : MlneuralrnnPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_neural_rnn_path_to_string(s : MlneuralrnnPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuralrnnCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_rnn_cluster_make(size : Int) -> MlneuralrnnCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_rnn_cluster_len(s : MlneuralrnnCluster) -> Int { s.size }

pub fn ml_neural_rnn_cluster_get(s : MlneuralrnnCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_rnn_cluster_set(s : MlneuralrnnCluster, i : Int, v : Double) -> MlneuralrnnCluster {
  let result = ml_neural_rnn_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_neural_rnn_cluster_sum(s : MlneuralrnnCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_neural_rnn_cluster_mean(s : MlneuralrnnCluster) -> Double {
  if s.size == 0 { 0.0 } else { ml_neural_rnn_cluster_sum(s) / s.size.to_double() }
}

pub fn ml_neural_rnn_cluster_scale(s : MlneuralrnnCluster, f : Double) -> MlneuralrnnCluster {
  let result = ml_neural_rnn_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_neural_rnn_cluster_add(a : MlneuralrnnCluster, b : MlneuralrnnCluster) -> MlneuralrnnCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_neural_rnn_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_neural_rnn_cluster_copy(s : MlneuralrnnCluster) -> MlneuralrnnCluster {
  let result = ml_neural_rnn_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_neural_rnn_cluster_fill(s : MlneuralrnnCluster, v : Double) -> MlneuralrnnCluster {
  let result = ml_neural_rnn_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_neural_rnn_cluster_min(s : MlneuralrnnCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_neural_rnn_cluster_max(s : MlneuralrnnCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_neural_rnn_cluster_to_string(s : MlneuralrnnCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuralrnnModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_rnn_model_make(size : Int) -> MlneuralrnnModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_rnn_model_len(s : MlneuralrnnModel) -> Int { s.size }

pub fn ml_neural_rnn_model_get(s : MlneuralrnnModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_rnn_model_set(s : MlneuralrnnModel, i : Int, v : Double) -> MlneuralrnnModel {
  let result = ml_neural_rnn_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_neural_rnn_model_sum(s : MlneuralrnnModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_neural_rnn_model_mean(s : MlneuralrnnModel) -> Double {
  if s.size == 0 { 0.0 } else { ml_neural_rnn_model_sum(s) / s.size.to_double() }
}

pub fn ml_neural_rnn_model_scale(s : MlneuralrnnModel, f : Double) -> MlneuralrnnModel {
  let result = ml_neural_rnn_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_neural_rnn_model_add(a : MlneuralrnnModel, b : MlneuralrnnModel) -> MlneuralrnnModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_neural_rnn_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_neural_rnn_model_copy(s : MlneuralrnnModel) -> MlneuralrnnModel {
  let result = ml_neural_rnn_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_neural_rnn_model_fill(s : MlneuralrnnModel, v : Double) -> MlneuralrnnModel {
  let result = ml_neural_rnn_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_neural_rnn_model_min(s : MlneuralrnnModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_neural_rnn_model_max(s : MlneuralrnnModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_neural_rnn_model_to_string(s : MlneuralrnnModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuralrnnLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_rnn_layer_make(size : Int) -> MlneuralrnnLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_rnn_layer_len(s : MlneuralrnnLayer) -> Int { s.size }

pub fn ml_neural_rnn_layer_get(s : MlneuralrnnLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_rnn_layer_set(s : MlneuralrnnLayer, i : Int, v : Double) -> MlneuralrnnLayer {
  let result = ml_neural_rnn_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_neural_rnn_layer_sum(s : MlneuralrnnLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_neural_rnn_layer_mean(s : MlneuralrnnLayer) -> Double {
  if s.size == 0 { 0.0 } else { ml_neural_rnn_layer_sum(s) / s.size.to_double() }
}

pub fn ml_neural_rnn_layer_scale(s : MlneuralrnnLayer, f : Double) -> MlneuralrnnLayer {
  let result = ml_neural_rnn_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_neural_rnn_layer_add(a : MlneuralrnnLayer, b : MlneuralrnnLayer) -> MlneuralrnnLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_neural_rnn_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_neural_rnn_layer_copy(s : MlneuralrnnLayer) -> MlneuralrnnLayer {
  let result = ml_neural_rnn_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_neural_rnn_layer_fill(s : MlneuralrnnLayer, v : Double) -> MlneuralrnnLayer {
  let result = ml_neural_rnn_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_neural_rnn_layer_min(s : MlneuralrnnLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_neural_rnn_layer_max(s : MlneuralrnnLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_neural_rnn_layer_to_string(s : MlneuralrnnLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuralrnnBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_rnn_buffer_make(size : Int) -> MlneuralrnnBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_rnn_buffer_len(s : MlneuralrnnBuffer) -> Int { s.size }

pub fn ml_neural_rnn_buffer_get(s : MlneuralrnnBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_rnn_buffer_set(s : MlneuralrnnBuffer, i : Int, v : Double) -> MlneuralrnnBuffer {
  let result = ml_neural_rnn_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_neural_rnn_buffer_sum(s : MlneuralrnnBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_neural_rnn_buffer_mean(s : MlneuralrnnBuffer) -> Double {
  if s.size == 0 { 0.0 } else { ml_neural_rnn_buffer_sum(s) / s.size.to_double() }
}

pub fn ml_neural_rnn_buffer_scale(s : MlneuralrnnBuffer, f : Double) -> MlneuralrnnBuffer {
  let result = ml_neural_rnn_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_neural_rnn_buffer_add(a : MlneuralrnnBuffer, b : MlneuralrnnBuffer) -> MlneuralrnnBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_neural_rnn_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_neural_rnn_buffer_copy(s : MlneuralrnnBuffer) -> MlneuralrnnBuffer {
  let result = ml_neural_rnn_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_neural_rnn_buffer_fill(s : MlneuralrnnBuffer, v : Double) -> MlneuralrnnBuffer {
  let result = ml_neural_rnn_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_neural_rnn_buffer_min(s : MlneuralrnnBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_neural_rnn_buffer_max(s : MlneuralrnnBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_neural_rnn_buffer_to_string(s : MlneuralrnnBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuralrnnCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_rnn_cursor_make(size : Int) -> MlneuralrnnCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_rnn_cursor_len(s : MlneuralrnnCursor) -> Int { s.size }

pub fn ml_neural_rnn_cursor_get(s : MlneuralrnnCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_rnn_cursor_set(s : MlneuralrnnCursor, i : Int, v : Double) -> MlneuralrnnCursor {
  let result = ml_neural_rnn_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_neural_rnn_cursor_sum(s : MlneuralrnnCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_neural_rnn_cursor_mean(s : MlneuralrnnCursor) -> Double {
  if s.size == 0 { 0.0 } else { ml_neural_rnn_cursor_sum(s) / s.size.to_double() }
}

pub fn ml_neural_rnn_cursor_scale(s : MlneuralrnnCursor, f : Double) -> MlneuralrnnCursor {
  let result = ml_neural_rnn_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_neural_rnn_cursor_add(a : MlneuralrnnCursor, b : MlneuralrnnCursor) -> MlneuralrnnCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_neural_rnn_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_neural_rnn_cursor_copy(s : MlneuralrnnCursor) -> MlneuralrnnCursor {
  let result = ml_neural_rnn_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_neural_rnn_cursor_fill(s : MlneuralrnnCursor, v : Double) -> MlneuralrnnCursor {
  let result = ml_neural_rnn_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_neural_rnn_cursor_min(s : MlneuralrnnCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_neural_rnn_cursor_max(s : MlneuralrnnCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_neural_rnn_cursor_to_string(s : MlneuralrnnCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuralrnnView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_rnn_view_make(size : Int) -> MlneuralrnnView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_rnn_view_len(s : MlneuralrnnView) -> Int { s.size }

pub fn ml_neural_rnn_view_get(s : MlneuralrnnView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_rnn_view_set(s : MlneuralrnnView, i : Int, v : Double) -> MlneuralrnnView {
  let result = ml_neural_rnn_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_neural_rnn_view_sum(s : MlneuralrnnView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_neural_rnn_view_mean(s : MlneuralrnnView) -> Double {
  if s.size == 0 { 0.0 } else { ml_neural_rnn_view_sum(s) / s.size.to_double() }
}

pub fn ml_neural_rnn_view_scale(s : MlneuralrnnView, f : Double) -> MlneuralrnnView {
  let result = ml_neural_rnn_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_neural_rnn_view_add(a : MlneuralrnnView, b : MlneuralrnnView) -> MlneuralrnnView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_neural_rnn_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_neural_rnn_view_copy(s : MlneuralrnnView) -> MlneuralrnnView {
  let result = ml_neural_rnn_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_neural_rnn_view_fill(s : MlneuralrnnView, v : Double) -> MlneuralrnnView {
  let result = ml_neural_rnn_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_neural_rnn_view_min(s : MlneuralrnnView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_neural_rnn_view_max(s : MlneuralrnnView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_neural_rnn_view_to_string(s : MlneuralrnnView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuralrnnRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_rnn_range_make(size : Int) -> MlneuralrnnRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_rnn_range_len(s : MlneuralrnnRange) -> Int { s.size }

pub fn ml_neural_rnn_range_get(s : MlneuralrnnRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_rnn_range_set(s : MlneuralrnnRange, i : Int, v : Double) -> MlneuralrnnRange {
  let result = ml_neural_rnn_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_neural_rnn_range_sum(s : MlneuralrnnRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_neural_rnn_range_mean(s : MlneuralrnnRange) -> Double {
  if s.size == 0 { 0.0 } else { ml_neural_rnn_range_sum(s) / s.size.to_double() }
}

pub fn ml_neural_rnn_range_scale(s : MlneuralrnnRange, f : Double) -> MlneuralrnnRange {
  let result = ml_neural_rnn_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_neural_rnn_range_add(a : MlneuralrnnRange, b : MlneuralrnnRange) -> MlneuralrnnRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_neural_rnn_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_neural_rnn_range_copy(s : MlneuralrnnRange) -> MlneuralrnnRange {
  let result = ml_neural_rnn_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_neural_rnn_range_fill(s : MlneuralrnnRange, v : Double) -> MlneuralrnnRange {
  let result = ml_neural_rnn_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_neural_rnn_range_min(s : MlneuralrnnRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_neural_rnn_range_max(s : MlneuralrnnRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_neural_rnn_range_to_string(s : MlneuralrnnRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuralrnnSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_rnn_slice_make(size : Int) -> MlneuralrnnSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_rnn_slice_len(s : MlneuralrnnSlice) -> Int { s.size }

pub fn ml_neural_rnn_slice_get(s : MlneuralrnnSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_rnn_slice_set(s : MlneuralrnnSlice, i : Int, v : Double) -> MlneuralrnnSlice {
  let result = ml_neural_rnn_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_neural_rnn_slice_sum(s : MlneuralrnnSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_neural_rnn_slice_mean(s : MlneuralrnnSlice) -> Double {
  if s.size == 0 { 0.0 } else { ml_neural_rnn_slice_sum(s) / s.size.to_double() }
}

pub fn ml_neural_rnn_slice_scale(s : MlneuralrnnSlice, f : Double) -> MlneuralrnnSlice {
  let result = ml_neural_rnn_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_neural_rnn_slice_add(a : MlneuralrnnSlice, b : MlneuralrnnSlice) -> MlneuralrnnSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_neural_rnn_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_neural_rnn_slice_copy(s : MlneuralrnnSlice) -> MlneuralrnnSlice {
  let result = ml_neural_rnn_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_neural_rnn_slice_fill(s : MlneuralrnnSlice, v : Double) -> MlneuralrnnSlice {
  let result = ml_neural_rnn_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_neural_rnn_slice_min(s : MlneuralrnnSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_neural_rnn_slice_max(s : MlneuralrnnSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_neural_rnn_slice_to_string(s : MlneuralrnnSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn ml_neural_rnn_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_neural_rnn_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_neural_rnn_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_neural_rnn_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_neural_rnn_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_neural_rnn_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_neural_rnn_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_neural_rnn_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_neural_rnn_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_neural_rnn_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_neural_rnn_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_neural_rnn_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_neural_rnn_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_neural_rnn_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_neural_rnn_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_neural_rnn_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_neural_rnn_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_neural_rnn_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_neural_rnn_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_neural_rnn_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_neural_rnn_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_neural_rnn_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_neural_rnn_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_neural_rnn_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_neural_rnn_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

