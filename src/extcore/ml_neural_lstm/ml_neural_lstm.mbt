///===
/// extcore/ml_neural_lstm

pub(all) struct MlneurallstmPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_neural_lstm_make_point(x : Double, y : Double) -> MlneurallstmPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_neural_lstm_make_point3(x : Double, y : Double, z : Double) -> MlneurallstmPoint {
  { x, y, z, label: 0 }
}

pub fn ml_neural_lstm_point_x(pt : MlneurallstmPoint) -> Double { pt.x }

pub fn ml_neural_lstm_point_y(pt : MlneurallstmPoint) -> Double { pt.y }

pub fn ml_neural_lstm_point_z(pt : MlneurallstmPoint) -> Double { pt.z }

pub fn ml_neural_lstm_point_label(pt : MlneurallstmPoint) -> Int { pt.label }

pub fn ml_neural_lstm_point_dist(a : MlneurallstmPoint, b : MlneurallstmPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  ml_neural_lstm_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ml_neural_lstm_point_add(a : MlneurallstmPoint, b : MlneurallstmPoint) -> MlneurallstmPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn ml_neural_lstm_point_sub(a : MlneurallstmPoint, b : MlneurallstmPoint) -> MlneurallstmPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn ml_neural_lstm_point_scale(pt : MlneurallstmPoint, s : Double) -> MlneurallstmPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn ml_neural_lstm_point_dot(a : MlneurallstmPoint, b : MlneurallstmPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn ml_neural_lstm_point_cross(a : MlneurallstmPoint, b : MlneurallstmPoint) -> MlneurallstmPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn ml_neural_lstm_point_norm(pt : MlneurallstmPoint) -> Double {
  ml_neural_lstm_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn ml_neural_lstm_point_normalize(pt : MlneurallstmPoint) -> MlneurallstmPoint {
  let n = ml_neural_lstm_point_norm(pt)
  if n < 0.0000001 { pt } else { ml_neural_lstm_point_scale(pt, 1.0 / n) }
}

pub fn ml_neural_lstm_point_negate(pt : MlneurallstmPoint) -> MlneurallstmPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn ml_neural_lstm_point_mid(a : MlneurallstmPoint, b : MlneurallstmPoint) -> MlneurallstmPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn ml_neural_lstm_point_lerp(a : MlneurallstmPoint, b : MlneurallstmPoint, t : Double) -> MlneurallstmPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn ml_neural_lstm_point_to_string(pt : MlneurallstmPoint) -> String {
  "(" + ml_neural_lstm_dbl(pt.x) + ", " + ml_neural_lstm_dbl(pt.y) + ", " + ml_neural_lstm_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct MlneurallstmSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_neural_lstm_make_series(vals : Array[Double], name : String) -> MlneurallstmSeries {
  { vals, name, meta: 0 }
}

pub fn ml_neural_lstm_series_len(s : MlneurallstmSeries) -> Int { s.vals.length() }

pub fn ml_neural_lstm_series_sum(s : MlneurallstmSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn ml_neural_lstm_series_mean(s : MlneurallstmSeries) -> Double {
  let n = ml_neural_lstm_series_len(s)
  if n == 0 { 0.0 } else { ml_neural_lstm_series_sum(s) / n.to_double() }
}

pub fn ml_neural_lstm_series_min(s : MlneurallstmSeries) -> Double {
  let n = ml_neural_lstm_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn ml_neural_lstm_series_max(s : MlneurallstmSeries) -> Double {
  let n = ml_neural_lstm_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn ml_neural_lstm_series_range(s : MlneurallstmSeries) -> Double {
  ml_neural_lstm_series_max(s) - ml_neural_lstm_series_min(s)
}

pub fn ml_neural_lstm_series_var(s : MlneurallstmSeries) -> Double {
  let n = ml_neural_lstm_series_len(s)
  if n == 0 { 0.0 } else {
    let m = ml_neural_lstm_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn ml_neural_lstm_series_std(s : MlneurallstmSeries) -> Double { ml_neural_lstm_sqrt(ml_neural_lstm_series_var(s)) }

pub fn ml_neural_lstm_series_median(s : MlneurallstmSeries) -> Double {
  let n = ml_neural_lstm_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = ml_neural_lstm_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn ml_neural_lstm_series_scale(s : MlneurallstmSeries, f : Double) -> MlneurallstmSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = ml_neural_lstm_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn ml_neural_lstm_series_add(a : MlneurallstmSeries, b : MlneurallstmSeries) -> MlneurallstmSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = ml_neural_lstm_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn ml_neural_lstm_series_sub(a : MlneurallstmSeries, b : MlneurallstmSeries) -> MlneurallstmSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = ml_neural_lstm_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn ml_neural_lstm_series_normalize(s : MlneurallstmSeries) -> MlneurallstmSeries {
  let mn = ml_neural_lstm_series_min(s)
  let mx = ml_neural_lstm_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = ml_neural_lstm_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn ml_neural_lstm_series_cumsum(s : MlneurallstmSeries) -> MlneurallstmSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = ml_neural_lstm_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn ml_neural_lstm_series_to_string(s : MlneurallstmSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + ml_neural_lstm_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlneurallstmMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_neural_lstm_make_matrix(rows : Int, cols : Int, val : Double) -> MlneurallstmMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_neural_lstm_matrix_identity(n : Int) -> MlneurallstmMatrix {
  let m = ml_neural_lstm_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ml_neural_lstm_matrix_get(m : MlneurallstmMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn ml_neural_lstm_matrix_transpose(m : MlneurallstmMatrix) -> MlneurallstmMatrix {
  let result = ml_neural_lstm_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn ml_neural_lstm_matrix_add(a : MlneurallstmMatrix, b : MlneurallstmMatrix) -> MlneurallstmMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = ml_neural_lstm_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn ml_neural_lstm_matrix_scale(m : MlneurallstmMatrix, s : Double) -> MlneurallstmMatrix {
  let result = ml_neural_lstm_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn ml_neural_lstm_matrix_multiply(a : MlneurallstmMatrix, b : MlneurallstmMatrix) -> MlneurallstmMatrix {
  if a.cols != b.rows { return ml_neural_lstm_make_matrix(a.rows, b.cols, 0.0) }
  let result = ml_neural_lstm_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ml_neural_lstm_matrix_trace(m : MlneurallstmMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn ml_neural_lstm_matrix_det(m : MlneurallstmMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ml_neural_lstm_matrix_norm(m : MlneurallstmMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  ml_neural_lstm_sqrt(sum)
}

pub fn ml_neural_lstm_matrix_to_string(m : MlneurallstmMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + ml_neural_lstm_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct MlneurallstmVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_neural_lstm_make_vector(comps : Array[Double]) -> MlneurallstmVector {
  { comps, dim: comps.length() }
}

pub fn ml_neural_lstm_vector_zero(dim : Int) -> MlneurallstmVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ml_neural_lstm_vector_add(a : MlneurallstmVector, b : MlneurallstmVector) -> MlneurallstmVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = ml_neural_lstm_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ml_neural_lstm_vector_sub(a : MlneurallstmVector, b : MlneurallstmVector) -> MlneurallstmVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = ml_neural_lstm_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ml_neural_lstm_vector_scale(v : MlneurallstmVector, s : Double) -> MlneurallstmVector {
  let mut result = []
  for i in 0..<v.dim { result = ml_neural_lstm_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn ml_neural_lstm_vector_dot(a : MlneurallstmVector, b : MlneurallstmVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn ml_neural_lstm_vector_norm(v : MlneurallstmVector) -> Double { ml_neural_lstm_sqrt(ml_neural_lstm_vector_dot(v, v)) }

pub fn ml_neural_lstm_vector_normalize(v : MlneurallstmVector) -> MlneurallstmVector {
  let n = ml_neural_lstm_vector_norm(v)
  if n < 0.0000001 { v } else { ml_neural_lstm_vector_scale(v, 1.0 / n) }
}

pub fn ml_neural_lstm_vector_dist(a : MlneurallstmVector, b : MlneurallstmVector) -> Double {
  ml_neural_lstm_vector_norm(ml_neural_lstm_vector_sub(a, b))
}

pub fn ml_neural_lstm_vector_to_string(v : MlneurallstmVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + ml_neural_lstm_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ml_neural_lstm_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn ml_neural_lstm_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = ml_neural_lstm_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn ml_neural_lstm_std(data : Array[Double]) -> Double { ml_neural_lstm_sqrt(ml_neural_lstm_var(data)) }

pub fn ml_neural_lstm_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = ml_neural_lstm_mean(a); let mb = ml_neural_lstm_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn ml_neural_lstm_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = ml_neural_lstm_std(a); let sb = ml_neural_lstm_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { ml_neural_lstm_cov(a, b) / (sa * sb) }
}

pub fn ml_neural_lstm_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = ml_neural_lstm_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn ml_neural_lstm_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn ml_neural_lstm_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn ml_neural_lstm_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  ml_neural_lstm_sqrt(ml_neural_lstm_mse(pred, labels))
}

pub fn ml_neural_lstm_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + ml_neural_lstm_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn ml_neural_lstm_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = ml_neural_lstm_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn ml_neural_lstm_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn ml_neural_lstm_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn ml_neural_lstm_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = ml_neural_lstm_precision(pred, labels, pos); let r = ml_neural_lstm_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn ml_neural_lstm_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn ml_neural_lstm_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = ml_neural_lstm_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn ml_neural_lstm_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn ml_neural_lstm_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn ml_neural_lstm_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = ml_neural_lstm_gcd(a, b)
    (a / g) * b
  }
}

pub fn ml_neural_lstm_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn ml_neural_lstm_fibonacci(n : Int) -> Int {
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

pub fn ml_neural_lstm_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = ml_neural_lstm_min(data); let mx = ml_neural_lstm_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn ml_neural_lstm_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = ml_neural_lstm_mean(data); let sd = ml_neural_lstm_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn ml_neural_lstm_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn ml_neural_lstm_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn ml_neural_lstm_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn ml_neural_lstm_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn ml_neural_lstm_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn ml_neural_lstm_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn ml_neural_lstm_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn ml_neural_lstm_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn ml_neural_lstm_dbl(x : Double) -> String {
  let i = if x >= 0.0 { ml_neural_lstm_int(x) } else { -ml_neural_lstm_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { ml_neural_lstm_int(f * 1000000.0) } else { ml_neural_lstm_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn ml_neural_lstm_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn ml_neural_lstm_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct MlneurallstmFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_lstm_frame_make(size : Int) -> MlneurallstmFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_lstm_frame_len(s : MlneurallstmFrame) -> Int { s.size }

pub fn ml_neural_lstm_frame_get(s : MlneurallstmFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_lstm_frame_set(s : MlneurallstmFrame, i : Int, v : Double) -> MlneurallstmFrame {
  let result = ml_neural_lstm_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_neural_lstm_frame_sum(s : MlneurallstmFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_neural_lstm_frame_mean(s : MlneurallstmFrame) -> Double {
  if s.size == 0 { 0.0 } else { ml_neural_lstm_frame_sum(s) / s.size.to_double() }
}

pub fn ml_neural_lstm_frame_scale(s : MlneurallstmFrame, f : Double) -> MlneurallstmFrame {
  let result = ml_neural_lstm_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_neural_lstm_frame_add(a : MlneurallstmFrame, b : MlneurallstmFrame) -> MlneurallstmFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_neural_lstm_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_neural_lstm_frame_copy(s : MlneurallstmFrame) -> MlneurallstmFrame {
  let result = ml_neural_lstm_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_neural_lstm_frame_fill(s : MlneurallstmFrame, v : Double) -> MlneurallstmFrame {
  let result = ml_neural_lstm_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_neural_lstm_frame_min(s : MlneurallstmFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_neural_lstm_frame_max(s : MlneurallstmFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_neural_lstm_frame_to_string(s : MlneurallstmFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneurallstmTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_lstm_table_make(size : Int) -> MlneurallstmTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_lstm_table_len(s : MlneurallstmTable) -> Int { s.size }

pub fn ml_neural_lstm_table_get(s : MlneurallstmTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_lstm_table_set(s : MlneurallstmTable, i : Int, v : Double) -> MlneurallstmTable {
  let result = ml_neural_lstm_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_neural_lstm_table_sum(s : MlneurallstmTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_neural_lstm_table_mean(s : MlneurallstmTable) -> Double {
  if s.size == 0 { 0.0 } else { ml_neural_lstm_table_sum(s) / s.size.to_double() }
}

pub fn ml_neural_lstm_table_scale(s : MlneurallstmTable, f : Double) -> MlneurallstmTable {
  let result = ml_neural_lstm_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_neural_lstm_table_add(a : MlneurallstmTable, b : MlneurallstmTable) -> MlneurallstmTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_neural_lstm_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_neural_lstm_table_copy(s : MlneurallstmTable) -> MlneurallstmTable {
  let result = ml_neural_lstm_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_neural_lstm_table_fill(s : MlneurallstmTable, v : Double) -> MlneurallstmTable {
  let result = ml_neural_lstm_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_neural_lstm_table_min(s : MlneurallstmTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_neural_lstm_table_max(s : MlneurallstmTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_neural_lstm_table_to_string(s : MlneurallstmTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneurallstmGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_lstm_graphn_make(size : Int) -> MlneurallstmGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_lstm_graphn_len(s : MlneurallstmGraphN) -> Int { s.size }

pub fn ml_neural_lstm_graphn_get(s : MlneurallstmGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_lstm_graphn_set(s : MlneurallstmGraphN, i : Int, v : Double) -> MlneurallstmGraphN {
  let result = ml_neural_lstm_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_neural_lstm_graphn_sum(s : MlneurallstmGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_neural_lstm_graphn_mean(s : MlneurallstmGraphN) -> Double {
  if s.size == 0 { 0.0 } else { ml_neural_lstm_graphn_sum(s) / s.size.to_double() }
}

pub fn ml_neural_lstm_graphn_scale(s : MlneurallstmGraphN, f : Double) -> MlneurallstmGraphN {
  let result = ml_neural_lstm_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_neural_lstm_graphn_add(a : MlneurallstmGraphN, b : MlneurallstmGraphN) -> MlneurallstmGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_neural_lstm_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_neural_lstm_graphn_copy(s : MlneurallstmGraphN) -> MlneurallstmGraphN {
  let result = ml_neural_lstm_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_neural_lstm_graphn_fill(s : MlneurallstmGraphN, v : Double) -> MlneurallstmGraphN {
  let result = ml_neural_lstm_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_neural_lstm_graphn_min(s : MlneurallstmGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_neural_lstm_graphn_max(s : MlneurallstmGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_neural_lstm_graphn_to_string(s : MlneurallstmGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneurallstmNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_lstm_node_make(size : Int) -> MlneurallstmNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_lstm_node_len(s : MlneurallstmNode) -> Int { s.size }

pub fn ml_neural_lstm_node_get(s : MlneurallstmNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_lstm_node_set(s : MlneurallstmNode, i : Int, v : Double) -> MlneurallstmNode {
  let result = ml_neural_lstm_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_neural_lstm_node_sum(s : MlneurallstmNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_neural_lstm_node_mean(s : MlneurallstmNode) -> Double {
  if s.size == 0 { 0.0 } else { ml_neural_lstm_node_sum(s) / s.size.to_double() }
}

pub fn ml_neural_lstm_node_scale(s : MlneurallstmNode, f : Double) -> MlneurallstmNode {
  let result = ml_neural_lstm_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_neural_lstm_node_add(a : MlneurallstmNode, b : MlneurallstmNode) -> MlneurallstmNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_neural_lstm_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_neural_lstm_node_copy(s : MlneurallstmNode) -> MlneurallstmNode {
  let result = ml_neural_lstm_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_neural_lstm_node_fill(s : MlneurallstmNode, v : Double) -> MlneurallstmNode {
  let result = ml_neural_lstm_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_neural_lstm_node_min(s : MlneurallstmNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_neural_lstm_node_max(s : MlneurallstmNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_neural_lstm_node_to_string(s : MlneurallstmNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneurallstmEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_lstm_edge_make(size : Int) -> MlneurallstmEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_lstm_edge_len(s : MlneurallstmEdge) -> Int { s.size }

pub fn ml_neural_lstm_edge_get(s : MlneurallstmEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_lstm_edge_set(s : MlneurallstmEdge, i : Int, v : Double) -> MlneurallstmEdge {
  let result = ml_neural_lstm_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_neural_lstm_edge_sum(s : MlneurallstmEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_neural_lstm_edge_mean(s : MlneurallstmEdge) -> Double {
  if s.size == 0 { 0.0 } else { ml_neural_lstm_edge_sum(s) / s.size.to_double() }
}

pub fn ml_neural_lstm_edge_scale(s : MlneurallstmEdge, f : Double) -> MlneurallstmEdge {
  let result = ml_neural_lstm_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_neural_lstm_edge_add(a : MlneurallstmEdge, b : MlneurallstmEdge) -> MlneurallstmEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_neural_lstm_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_neural_lstm_edge_copy(s : MlneurallstmEdge) -> MlneurallstmEdge {
  let result = ml_neural_lstm_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_neural_lstm_edge_fill(s : MlneurallstmEdge, v : Double) -> MlneurallstmEdge {
  let result = ml_neural_lstm_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_neural_lstm_edge_min(s : MlneurallstmEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_neural_lstm_edge_max(s : MlneurallstmEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_neural_lstm_edge_to_string(s : MlneurallstmEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneurallstmPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_lstm_path_make(size : Int) -> MlneurallstmPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_lstm_path_len(s : MlneurallstmPath) -> Int { s.size }

pub fn ml_neural_lstm_path_get(s : MlneurallstmPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_lstm_path_set(s : MlneurallstmPath, i : Int, v : Double) -> MlneurallstmPath {
  let result = ml_neural_lstm_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_neural_lstm_path_sum(s : MlneurallstmPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_neural_lstm_path_mean(s : MlneurallstmPath) -> Double {
  if s.size == 0 { 0.0 } else { ml_neural_lstm_path_sum(s) / s.size.to_double() }
}

pub fn ml_neural_lstm_path_scale(s : MlneurallstmPath, f : Double) -> MlneurallstmPath {
  let result = ml_neural_lstm_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_neural_lstm_path_add(a : MlneurallstmPath, b : MlneurallstmPath) -> MlneurallstmPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_neural_lstm_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_neural_lstm_path_copy(s : MlneurallstmPath) -> MlneurallstmPath {
  let result = ml_neural_lstm_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_neural_lstm_path_fill(s : MlneurallstmPath, v : Double) -> MlneurallstmPath {
  let result = ml_neural_lstm_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_neural_lstm_path_min(s : MlneurallstmPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_neural_lstm_path_max(s : MlneurallstmPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_neural_lstm_path_to_string(s : MlneurallstmPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneurallstmCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_lstm_cluster_make(size : Int) -> MlneurallstmCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_lstm_cluster_len(s : MlneurallstmCluster) -> Int { s.size }

pub fn ml_neural_lstm_cluster_get(s : MlneurallstmCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_lstm_cluster_set(s : MlneurallstmCluster, i : Int, v : Double) -> MlneurallstmCluster {
  let result = ml_neural_lstm_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_neural_lstm_cluster_sum(s : MlneurallstmCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_neural_lstm_cluster_mean(s : MlneurallstmCluster) -> Double {
  if s.size == 0 { 0.0 } else { ml_neural_lstm_cluster_sum(s) / s.size.to_double() }
}

pub fn ml_neural_lstm_cluster_scale(s : MlneurallstmCluster, f : Double) -> MlneurallstmCluster {
  let result = ml_neural_lstm_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_neural_lstm_cluster_add(a : MlneurallstmCluster, b : MlneurallstmCluster) -> MlneurallstmCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_neural_lstm_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_neural_lstm_cluster_copy(s : MlneurallstmCluster) -> MlneurallstmCluster {
  let result = ml_neural_lstm_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_neural_lstm_cluster_fill(s : MlneurallstmCluster, v : Double) -> MlneurallstmCluster {
  let result = ml_neural_lstm_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_neural_lstm_cluster_min(s : MlneurallstmCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_neural_lstm_cluster_max(s : MlneurallstmCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_neural_lstm_cluster_to_string(s : MlneurallstmCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneurallstmModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_lstm_model_make(size : Int) -> MlneurallstmModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_lstm_model_len(s : MlneurallstmModel) -> Int { s.size }

pub fn ml_neural_lstm_model_get(s : MlneurallstmModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_lstm_model_set(s : MlneurallstmModel, i : Int, v : Double) -> MlneurallstmModel {
  let result = ml_neural_lstm_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_neural_lstm_model_sum(s : MlneurallstmModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_neural_lstm_model_mean(s : MlneurallstmModel) -> Double {
  if s.size == 0 { 0.0 } else { ml_neural_lstm_model_sum(s) / s.size.to_double() }
}

pub fn ml_neural_lstm_model_scale(s : MlneurallstmModel, f : Double) -> MlneurallstmModel {
  let result = ml_neural_lstm_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_neural_lstm_model_add(a : MlneurallstmModel, b : MlneurallstmModel) -> MlneurallstmModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_neural_lstm_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_neural_lstm_model_copy(s : MlneurallstmModel) -> MlneurallstmModel {
  let result = ml_neural_lstm_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_neural_lstm_model_fill(s : MlneurallstmModel, v : Double) -> MlneurallstmModel {
  let result = ml_neural_lstm_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_neural_lstm_model_min(s : MlneurallstmModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_neural_lstm_model_max(s : MlneurallstmModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_neural_lstm_model_to_string(s : MlneurallstmModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneurallstmLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_lstm_layer_make(size : Int) -> MlneurallstmLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_lstm_layer_len(s : MlneurallstmLayer) -> Int { s.size }

pub fn ml_neural_lstm_layer_get(s : MlneurallstmLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_lstm_layer_set(s : MlneurallstmLayer, i : Int, v : Double) -> MlneurallstmLayer {
  let result = ml_neural_lstm_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_neural_lstm_layer_sum(s : MlneurallstmLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_neural_lstm_layer_mean(s : MlneurallstmLayer) -> Double {
  if s.size == 0 { 0.0 } else { ml_neural_lstm_layer_sum(s) / s.size.to_double() }
}

pub fn ml_neural_lstm_layer_scale(s : MlneurallstmLayer, f : Double) -> MlneurallstmLayer {
  let result = ml_neural_lstm_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_neural_lstm_layer_add(a : MlneurallstmLayer, b : MlneurallstmLayer) -> MlneurallstmLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_neural_lstm_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_neural_lstm_layer_copy(s : MlneurallstmLayer) -> MlneurallstmLayer {
  let result = ml_neural_lstm_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_neural_lstm_layer_fill(s : MlneurallstmLayer, v : Double) -> MlneurallstmLayer {
  let result = ml_neural_lstm_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_neural_lstm_layer_min(s : MlneurallstmLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_neural_lstm_layer_max(s : MlneurallstmLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_neural_lstm_layer_to_string(s : MlneurallstmLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneurallstmBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_lstm_buffer_make(size : Int) -> MlneurallstmBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_lstm_buffer_len(s : MlneurallstmBuffer) -> Int { s.size }

pub fn ml_neural_lstm_buffer_get(s : MlneurallstmBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_lstm_buffer_set(s : MlneurallstmBuffer, i : Int, v : Double) -> MlneurallstmBuffer {
  let result = ml_neural_lstm_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_neural_lstm_buffer_sum(s : MlneurallstmBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_neural_lstm_buffer_mean(s : MlneurallstmBuffer) -> Double {
  if s.size == 0 { 0.0 } else { ml_neural_lstm_buffer_sum(s) / s.size.to_double() }
}

pub fn ml_neural_lstm_buffer_scale(s : MlneurallstmBuffer, f : Double) -> MlneurallstmBuffer {
  let result = ml_neural_lstm_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_neural_lstm_buffer_add(a : MlneurallstmBuffer, b : MlneurallstmBuffer) -> MlneurallstmBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_neural_lstm_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_neural_lstm_buffer_copy(s : MlneurallstmBuffer) -> MlneurallstmBuffer {
  let result = ml_neural_lstm_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_neural_lstm_buffer_fill(s : MlneurallstmBuffer, v : Double) -> MlneurallstmBuffer {
  let result = ml_neural_lstm_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_neural_lstm_buffer_min(s : MlneurallstmBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_neural_lstm_buffer_max(s : MlneurallstmBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_neural_lstm_buffer_to_string(s : MlneurallstmBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneurallstmCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_lstm_cursor_make(size : Int) -> MlneurallstmCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_lstm_cursor_len(s : MlneurallstmCursor) -> Int { s.size }

pub fn ml_neural_lstm_cursor_get(s : MlneurallstmCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_lstm_cursor_set(s : MlneurallstmCursor, i : Int, v : Double) -> MlneurallstmCursor {
  let result = ml_neural_lstm_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_neural_lstm_cursor_sum(s : MlneurallstmCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_neural_lstm_cursor_mean(s : MlneurallstmCursor) -> Double {
  if s.size == 0 { 0.0 } else { ml_neural_lstm_cursor_sum(s) / s.size.to_double() }
}

pub fn ml_neural_lstm_cursor_scale(s : MlneurallstmCursor, f : Double) -> MlneurallstmCursor {
  let result = ml_neural_lstm_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_neural_lstm_cursor_add(a : MlneurallstmCursor, b : MlneurallstmCursor) -> MlneurallstmCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_neural_lstm_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_neural_lstm_cursor_copy(s : MlneurallstmCursor) -> MlneurallstmCursor {
  let result = ml_neural_lstm_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_neural_lstm_cursor_fill(s : MlneurallstmCursor, v : Double) -> MlneurallstmCursor {
  let result = ml_neural_lstm_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_neural_lstm_cursor_min(s : MlneurallstmCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_neural_lstm_cursor_max(s : MlneurallstmCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_neural_lstm_cursor_to_string(s : MlneurallstmCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneurallstmView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_lstm_view_make(size : Int) -> MlneurallstmView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_lstm_view_len(s : MlneurallstmView) -> Int { s.size }

pub fn ml_neural_lstm_view_get(s : MlneurallstmView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_lstm_view_set(s : MlneurallstmView, i : Int, v : Double) -> MlneurallstmView {
  let result = ml_neural_lstm_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_neural_lstm_view_sum(s : MlneurallstmView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_neural_lstm_view_mean(s : MlneurallstmView) -> Double {
  if s.size == 0 { 0.0 } else { ml_neural_lstm_view_sum(s) / s.size.to_double() }
}

pub fn ml_neural_lstm_view_scale(s : MlneurallstmView, f : Double) -> MlneurallstmView {
  let result = ml_neural_lstm_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_neural_lstm_view_add(a : MlneurallstmView, b : MlneurallstmView) -> MlneurallstmView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_neural_lstm_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_neural_lstm_view_copy(s : MlneurallstmView) -> MlneurallstmView {
  let result = ml_neural_lstm_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_neural_lstm_view_fill(s : MlneurallstmView, v : Double) -> MlneurallstmView {
  let result = ml_neural_lstm_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_neural_lstm_view_min(s : MlneurallstmView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_neural_lstm_view_max(s : MlneurallstmView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_neural_lstm_view_to_string(s : MlneurallstmView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneurallstmRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_lstm_range_make(size : Int) -> MlneurallstmRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_lstm_range_len(s : MlneurallstmRange) -> Int { s.size }

pub fn ml_neural_lstm_range_get(s : MlneurallstmRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_lstm_range_set(s : MlneurallstmRange, i : Int, v : Double) -> MlneurallstmRange {
  let result = ml_neural_lstm_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_neural_lstm_range_sum(s : MlneurallstmRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_neural_lstm_range_mean(s : MlneurallstmRange) -> Double {
  if s.size == 0 { 0.0 } else { ml_neural_lstm_range_sum(s) / s.size.to_double() }
}

pub fn ml_neural_lstm_range_scale(s : MlneurallstmRange, f : Double) -> MlneurallstmRange {
  let result = ml_neural_lstm_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_neural_lstm_range_add(a : MlneurallstmRange, b : MlneurallstmRange) -> MlneurallstmRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_neural_lstm_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_neural_lstm_range_copy(s : MlneurallstmRange) -> MlneurallstmRange {
  let result = ml_neural_lstm_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_neural_lstm_range_fill(s : MlneurallstmRange, v : Double) -> MlneurallstmRange {
  let result = ml_neural_lstm_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_neural_lstm_range_min(s : MlneurallstmRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_neural_lstm_range_max(s : MlneurallstmRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_neural_lstm_range_to_string(s : MlneurallstmRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneurallstmSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_lstm_slice_make(size : Int) -> MlneurallstmSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_lstm_slice_len(s : MlneurallstmSlice) -> Int { s.size }

pub fn ml_neural_lstm_slice_get(s : MlneurallstmSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_lstm_slice_set(s : MlneurallstmSlice, i : Int, v : Double) -> MlneurallstmSlice {
  let result = ml_neural_lstm_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_neural_lstm_slice_sum(s : MlneurallstmSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_neural_lstm_slice_mean(s : MlneurallstmSlice) -> Double {
  if s.size == 0 { 0.0 } else { ml_neural_lstm_slice_sum(s) / s.size.to_double() }
}

pub fn ml_neural_lstm_slice_scale(s : MlneurallstmSlice, f : Double) -> MlneurallstmSlice {
  let result = ml_neural_lstm_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_neural_lstm_slice_add(a : MlneurallstmSlice, b : MlneurallstmSlice) -> MlneurallstmSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_neural_lstm_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_neural_lstm_slice_copy(s : MlneurallstmSlice) -> MlneurallstmSlice {
  let result = ml_neural_lstm_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_neural_lstm_slice_fill(s : MlneurallstmSlice, v : Double) -> MlneurallstmSlice {
  let result = ml_neural_lstm_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_neural_lstm_slice_min(s : MlneurallstmSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_neural_lstm_slice_max(s : MlneurallstmSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_neural_lstm_slice_to_string(s : MlneurallstmSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn ml_neural_lstm_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_neural_lstm_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_neural_lstm_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_neural_lstm_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_neural_lstm_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_neural_lstm_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_neural_lstm_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_neural_lstm_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_neural_lstm_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_neural_lstm_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_neural_lstm_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_neural_lstm_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_neural_lstm_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_neural_lstm_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_neural_lstm_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_neural_lstm_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_neural_lstm_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_neural_lstm_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_neural_lstm_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_neural_lstm_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_neural_lstm_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_neural_lstm_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_neural_lstm_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_neural_lstm_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_neural_lstm_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

