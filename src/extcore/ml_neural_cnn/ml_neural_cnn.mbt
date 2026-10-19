///===
/// extcore/ml_neural_cnn

pub(all) struct MlneuralcnnPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_neural_cnn_make_point(x : Double, y : Double) -> MlneuralcnnPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_neural_cnn_make_point3(x : Double, y : Double, z : Double) -> MlneuralcnnPoint {
  { x, y, z, label: 0 }
}

pub fn ml_neural_cnn_point_x(pt : MlneuralcnnPoint) -> Double { pt.x }

pub fn ml_neural_cnn_point_y(pt : MlneuralcnnPoint) -> Double { pt.y }

pub fn ml_neural_cnn_point_z(pt : MlneuralcnnPoint) -> Double { pt.z }

pub fn ml_neural_cnn_point_label(pt : MlneuralcnnPoint) -> Int { pt.label }

pub fn ml_neural_cnn_point_dist(a : MlneuralcnnPoint, b : MlneuralcnnPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ml_neural_cnn_point_add(a : MlneuralcnnPoint, b : MlneuralcnnPoint) -> MlneuralcnnPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn ml_neural_cnn_point_sub(a : MlneuralcnnPoint, b : MlneuralcnnPoint) -> MlneuralcnnPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn ml_neural_cnn_point_scale(pt : MlneuralcnnPoint, s : Double) -> MlneuralcnnPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn ml_neural_cnn_point_dot(a : MlneuralcnnPoint, b : MlneuralcnnPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn ml_neural_cnn_point_cross(a : MlneuralcnnPoint, b : MlneuralcnnPoint) -> MlneuralcnnPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn ml_neural_cnn_point_norm(pt : MlneuralcnnPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn ml_neural_cnn_point_normalize(pt : MlneuralcnnPoint) -> MlneuralcnnPoint {
  let n = ml_neural_cnn_point_norm(pt)
  if n < 0.0000001 { pt } else { ml_neural_cnn_point_scale(pt, 1.0 / n) }
}

pub fn ml_neural_cnn_point_negate(pt : MlneuralcnnPoint) -> MlneuralcnnPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn ml_neural_cnn_point_mid(a : MlneuralcnnPoint, b : MlneuralcnnPoint) -> MlneuralcnnPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn ml_neural_cnn_point_lerp(a : MlneuralcnnPoint, b : MlneuralcnnPoint, t : Double) -> MlneuralcnnPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn ml_neural_cnn_point_to_string(pt : MlneuralcnnPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct MlneuralcnnSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_neural_cnn_make_series(vals : Array[Double], name : String) -> MlneuralcnnSeries {
  { vals, name, meta: 0 }
}

pub fn ml_neural_cnn_series_len(s : MlneuralcnnSeries) -> Int { s.vals.length() }

pub fn ml_neural_cnn_series_sum(s : MlneuralcnnSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn ml_neural_cnn_series_mean(s : MlneuralcnnSeries) -> Double {
  let n = ml_neural_cnn_series_len(s)
  if n == 0 { 0.0 } else { ml_neural_cnn_series_sum(s) / n.to_double() }
}

pub fn ml_neural_cnn_series_min(s : MlneuralcnnSeries) -> Double {
  let n = ml_neural_cnn_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn ml_neural_cnn_series_max(s : MlneuralcnnSeries) -> Double {
  let n = ml_neural_cnn_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn ml_neural_cnn_series_range(s : MlneuralcnnSeries) -> Double {
  ml_neural_cnn_series_max(s) - ml_neural_cnn_series_min(s)
}

pub fn ml_neural_cnn_series_var(s : MlneuralcnnSeries) -> Double {
  let n = ml_neural_cnn_series_len(s)
  if n == 0 { 0.0 } else {
    let m = ml_neural_cnn_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn ml_neural_cnn_series_std(s : MlneuralcnnSeries) -> Double { @_common.sqrt(ml_neural_cnn_series_var(s)) }

pub fn ml_neural_cnn_series_median(s : MlneuralcnnSeries) -> Double {
  let n = ml_neural_cnn_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = ml_neural_cnn_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn ml_neural_cnn_series_scale(s : MlneuralcnnSeries, f : Double) -> MlneuralcnnSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn ml_neural_cnn_series_add(a : MlneuralcnnSeries, b : MlneuralcnnSeries) -> MlneuralcnnSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn ml_neural_cnn_series_sub(a : MlneuralcnnSeries, b : MlneuralcnnSeries) -> MlneuralcnnSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn ml_neural_cnn_series_normalize(s : MlneuralcnnSeries) -> MlneuralcnnSeries {
  let mn = ml_neural_cnn_series_min(s)
  let mx = ml_neural_cnn_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn ml_neural_cnn_series_cumsum(s : MlneuralcnnSeries) -> MlneuralcnnSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn ml_neural_cnn_series_to_string(s : MlneuralcnnSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlneuralcnnMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_neural_cnn_make_matrix(rows : Int, cols : Int, val : Double) -> MlneuralcnnMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_neural_cnn_matrix_identity(n : Int) -> MlneuralcnnMatrix {
  let m = ml_neural_cnn_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ml_neural_cnn_matrix_get(m : MlneuralcnnMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn ml_neural_cnn_matrix_transpose(m : MlneuralcnnMatrix) -> MlneuralcnnMatrix {
  let result = ml_neural_cnn_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn ml_neural_cnn_matrix_add(a : MlneuralcnnMatrix, b : MlneuralcnnMatrix) -> MlneuralcnnMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = ml_neural_cnn_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn ml_neural_cnn_matrix_scale(m : MlneuralcnnMatrix, s : Double) -> MlneuralcnnMatrix {
  let result = ml_neural_cnn_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn ml_neural_cnn_matrix_multiply(a : MlneuralcnnMatrix, b : MlneuralcnnMatrix) -> MlneuralcnnMatrix {
  if a.cols != b.rows { return ml_neural_cnn_make_matrix(a.rows, b.cols, 0.0) }
  let result = ml_neural_cnn_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ml_neural_cnn_matrix_trace(m : MlneuralcnnMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn ml_neural_cnn_matrix_det(m : MlneuralcnnMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ml_neural_cnn_matrix_norm(m : MlneuralcnnMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ml_neural_cnn_matrix_to_string(m : MlneuralcnnMatrix) -> String {
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

pub(all) struct MlneuralcnnVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_neural_cnn_make_vector(comps : Array[Double]) -> MlneuralcnnVector {
  { comps, dim: comps.length() }
}

pub fn ml_neural_cnn_vector_zero(dim : Int) -> MlneuralcnnVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ml_neural_cnn_vector_add(a : MlneuralcnnVector, b : MlneuralcnnVector) -> MlneuralcnnVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ml_neural_cnn_vector_sub(a : MlneuralcnnVector, b : MlneuralcnnVector) -> MlneuralcnnVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ml_neural_cnn_vector_scale(v : MlneuralcnnVector, s : Double) -> MlneuralcnnVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn ml_neural_cnn_vector_dot(a : MlneuralcnnVector, b : MlneuralcnnVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn ml_neural_cnn_vector_norm(v : MlneuralcnnVector) -> Double { @_common.sqrt(ml_neural_cnn_vector_dot(v, v)) }

pub fn ml_neural_cnn_vector_normalize(v : MlneuralcnnVector) -> MlneuralcnnVector {
  let n = ml_neural_cnn_vector_norm(v)
  if n < 0.0000001 { v } else { ml_neural_cnn_vector_scale(v, 1.0 / n) }
}

pub fn ml_neural_cnn_vector_dist(a : MlneuralcnnVector, b : MlneuralcnnVector) -> Double {
  ml_neural_cnn_vector_norm(ml_neural_cnn_vector_sub(a, b))
}

pub fn ml_neural_cnn_vector_to_string(v : MlneuralcnnVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ml_neural_cnn_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn ml_neural_cnn_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = ml_neural_cnn_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn ml_neural_cnn_std(data : Array[Double]) -> Double { @_common.sqrt(ml_neural_cnn_var(data)) }

pub fn ml_neural_cnn_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = ml_neural_cnn_mean(a); let mb = ml_neural_cnn_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn ml_neural_cnn_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = ml_neural_cnn_std(a); let sb = ml_neural_cnn_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { ml_neural_cnn_cov(a, b) / (sa * sb) }
}

pub fn ml_neural_cnn_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = ml_neural_cnn_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn ml_neural_cnn_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn ml_neural_cnn_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn ml_neural_cnn_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  @_common.sqrt(ml_neural_cnn_mse(pred, labels))
}

pub fn ml_neural_cnn_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn ml_neural_cnn_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = ml_neural_cnn_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn ml_neural_cnn_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn ml_neural_cnn_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn ml_neural_cnn_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = ml_neural_cnn_precision(pred, labels, pos); let r = ml_neural_cnn_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn ml_neural_cnn_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn ml_neural_cnn_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = ml_neural_cnn_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn ml_neural_cnn_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn ml_neural_cnn_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn ml_neural_cnn_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = ml_neural_cnn_gcd(a, b)
    (a / g) * b
  }
}

pub fn ml_neural_cnn_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn ml_neural_cnn_fibonacci(n : Int) -> Int {
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

pub fn ml_neural_cnn_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = ml_neural_cnn_min(data); let mx = ml_neural_cnn_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn ml_neural_cnn_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = ml_neural_cnn_mean(data); let sd = ml_neural_cnn_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn ml_neural_cnn_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn ml_neural_cnn_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn ml_neural_cnn_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn ml_neural_cnn_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn ml_neural_cnn_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn ml_neural_cnn_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

pub(all) struct MlneuralcnnFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_cnn_frame_make(size : Int) -> MlneuralcnnFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_cnn_frame_len(s : MlneuralcnnFrame) -> Int { s.size }

pub fn ml_neural_cnn_frame_get(s : MlneuralcnnFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_cnn_frame_set(s : MlneuralcnnFrame, i : Int, v : Double) -> MlneuralcnnFrame {
  let result = ml_neural_cnn_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_neural_cnn_frame_sum(s : MlneuralcnnFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_neural_cnn_frame_mean(s : MlneuralcnnFrame) -> Double {
  if s.size == 0 { 0.0 } else { ml_neural_cnn_frame_sum(s) / s.size.to_double() }
}

pub fn ml_neural_cnn_frame_scale(s : MlneuralcnnFrame, f : Double) -> MlneuralcnnFrame {
  let result = ml_neural_cnn_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_neural_cnn_frame_add(a : MlneuralcnnFrame, b : MlneuralcnnFrame) -> MlneuralcnnFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_neural_cnn_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_neural_cnn_frame_copy(s : MlneuralcnnFrame) -> MlneuralcnnFrame {
  let result = ml_neural_cnn_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_neural_cnn_frame_fill(s : MlneuralcnnFrame, v : Double) -> MlneuralcnnFrame {
  let result = ml_neural_cnn_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_neural_cnn_frame_min(s : MlneuralcnnFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_neural_cnn_frame_max(s : MlneuralcnnFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_neural_cnn_frame_to_string(s : MlneuralcnnFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuralcnnTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_cnn_table_make(size : Int) -> MlneuralcnnTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_cnn_table_len(s : MlneuralcnnTable) -> Int { s.size }

pub fn ml_neural_cnn_table_get(s : MlneuralcnnTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_cnn_table_set(s : MlneuralcnnTable, i : Int, v : Double) -> MlneuralcnnTable {
  let result = ml_neural_cnn_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_neural_cnn_table_sum(s : MlneuralcnnTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_neural_cnn_table_mean(s : MlneuralcnnTable) -> Double {
  if s.size == 0 { 0.0 } else { ml_neural_cnn_table_sum(s) / s.size.to_double() }
}

pub fn ml_neural_cnn_table_scale(s : MlneuralcnnTable, f : Double) -> MlneuralcnnTable {
  let result = ml_neural_cnn_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_neural_cnn_table_add(a : MlneuralcnnTable, b : MlneuralcnnTable) -> MlneuralcnnTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_neural_cnn_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_neural_cnn_table_copy(s : MlneuralcnnTable) -> MlneuralcnnTable {
  let result = ml_neural_cnn_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_neural_cnn_table_fill(s : MlneuralcnnTable, v : Double) -> MlneuralcnnTable {
  let result = ml_neural_cnn_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_neural_cnn_table_min(s : MlneuralcnnTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_neural_cnn_table_max(s : MlneuralcnnTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_neural_cnn_table_to_string(s : MlneuralcnnTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuralcnnGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_cnn_graphn_make(size : Int) -> MlneuralcnnGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_cnn_graphn_len(s : MlneuralcnnGraphN) -> Int { s.size }

pub fn ml_neural_cnn_graphn_get(s : MlneuralcnnGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_cnn_graphn_set(s : MlneuralcnnGraphN, i : Int, v : Double) -> MlneuralcnnGraphN {
  let result = ml_neural_cnn_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_neural_cnn_graphn_sum(s : MlneuralcnnGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_neural_cnn_graphn_mean(s : MlneuralcnnGraphN) -> Double {
  if s.size == 0 { 0.0 } else { ml_neural_cnn_graphn_sum(s) / s.size.to_double() }
}

pub fn ml_neural_cnn_graphn_scale(s : MlneuralcnnGraphN, f : Double) -> MlneuralcnnGraphN {
  let result = ml_neural_cnn_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_neural_cnn_graphn_add(a : MlneuralcnnGraphN, b : MlneuralcnnGraphN) -> MlneuralcnnGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_neural_cnn_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_neural_cnn_graphn_copy(s : MlneuralcnnGraphN) -> MlneuralcnnGraphN {
  let result = ml_neural_cnn_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_neural_cnn_graphn_fill(s : MlneuralcnnGraphN, v : Double) -> MlneuralcnnGraphN {
  let result = ml_neural_cnn_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_neural_cnn_graphn_min(s : MlneuralcnnGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_neural_cnn_graphn_max(s : MlneuralcnnGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_neural_cnn_graphn_to_string(s : MlneuralcnnGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuralcnnNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_cnn_node_make(size : Int) -> MlneuralcnnNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_cnn_node_len(s : MlneuralcnnNode) -> Int { s.size }

pub fn ml_neural_cnn_node_get(s : MlneuralcnnNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_cnn_node_set(s : MlneuralcnnNode, i : Int, v : Double) -> MlneuralcnnNode {
  let result = ml_neural_cnn_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_neural_cnn_node_sum(s : MlneuralcnnNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_neural_cnn_node_mean(s : MlneuralcnnNode) -> Double {
  if s.size == 0 { 0.0 } else { ml_neural_cnn_node_sum(s) / s.size.to_double() }
}

pub fn ml_neural_cnn_node_scale(s : MlneuralcnnNode, f : Double) -> MlneuralcnnNode {
  let result = ml_neural_cnn_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_neural_cnn_node_add(a : MlneuralcnnNode, b : MlneuralcnnNode) -> MlneuralcnnNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_neural_cnn_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_neural_cnn_node_copy(s : MlneuralcnnNode) -> MlneuralcnnNode {
  let result = ml_neural_cnn_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_neural_cnn_node_fill(s : MlneuralcnnNode, v : Double) -> MlneuralcnnNode {
  let result = ml_neural_cnn_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_neural_cnn_node_min(s : MlneuralcnnNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_neural_cnn_node_max(s : MlneuralcnnNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_neural_cnn_node_to_string(s : MlneuralcnnNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuralcnnEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_cnn_edge_make(size : Int) -> MlneuralcnnEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_cnn_edge_len(s : MlneuralcnnEdge) -> Int { s.size }

pub fn ml_neural_cnn_edge_get(s : MlneuralcnnEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_cnn_edge_set(s : MlneuralcnnEdge, i : Int, v : Double) -> MlneuralcnnEdge {
  let result = ml_neural_cnn_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_neural_cnn_edge_sum(s : MlneuralcnnEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_neural_cnn_edge_mean(s : MlneuralcnnEdge) -> Double {
  if s.size == 0 { 0.0 } else { ml_neural_cnn_edge_sum(s) / s.size.to_double() }
}

pub fn ml_neural_cnn_edge_scale(s : MlneuralcnnEdge, f : Double) -> MlneuralcnnEdge {
  let result = ml_neural_cnn_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_neural_cnn_edge_add(a : MlneuralcnnEdge, b : MlneuralcnnEdge) -> MlneuralcnnEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_neural_cnn_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_neural_cnn_edge_copy(s : MlneuralcnnEdge) -> MlneuralcnnEdge {
  let result = ml_neural_cnn_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_neural_cnn_edge_fill(s : MlneuralcnnEdge, v : Double) -> MlneuralcnnEdge {
  let result = ml_neural_cnn_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_neural_cnn_edge_min(s : MlneuralcnnEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_neural_cnn_edge_max(s : MlneuralcnnEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_neural_cnn_edge_to_string(s : MlneuralcnnEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuralcnnPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_cnn_path_make(size : Int) -> MlneuralcnnPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_cnn_path_len(s : MlneuralcnnPath) -> Int { s.size }

pub fn ml_neural_cnn_path_get(s : MlneuralcnnPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_cnn_path_set(s : MlneuralcnnPath, i : Int, v : Double) -> MlneuralcnnPath {
  let result = ml_neural_cnn_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_neural_cnn_path_sum(s : MlneuralcnnPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_neural_cnn_path_mean(s : MlneuralcnnPath) -> Double {
  if s.size == 0 { 0.0 } else { ml_neural_cnn_path_sum(s) / s.size.to_double() }
}

pub fn ml_neural_cnn_path_scale(s : MlneuralcnnPath, f : Double) -> MlneuralcnnPath {
  let result = ml_neural_cnn_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_neural_cnn_path_add(a : MlneuralcnnPath, b : MlneuralcnnPath) -> MlneuralcnnPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_neural_cnn_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_neural_cnn_path_copy(s : MlneuralcnnPath) -> MlneuralcnnPath {
  let result = ml_neural_cnn_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_neural_cnn_path_fill(s : MlneuralcnnPath, v : Double) -> MlneuralcnnPath {
  let result = ml_neural_cnn_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_neural_cnn_path_min(s : MlneuralcnnPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_neural_cnn_path_max(s : MlneuralcnnPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_neural_cnn_path_to_string(s : MlneuralcnnPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuralcnnCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_cnn_cluster_make(size : Int) -> MlneuralcnnCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_cnn_cluster_len(s : MlneuralcnnCluster) -> Int { s.size }

pub fn ml_neural_cnn_cluster_get(s : MlneuralcnnCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_cnn_cluster_set(s : MlneuralcnnCluster, i : Int, v : Double) -> MlneuralcnnCluster {
  let result = ml_neural_cnn_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_neural_cnn_cluster_sum(s : MlneuralcnnCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_neural_cnn_cluster_mean(s : MlneuralcnnCluster) -> Double {
  if s.size == 0 { 0.0 } else { ml_neural_cnn_cluster_sum(s) / s.size.to_double() }
}

pub fn ml_neural_cnn_cluster_scale(s : MlneuralcnnCluster, f : Double) -> MlneuralcnnCluster {
  let result = ml_neural_cnn_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_neural_cnn_cluster_add(a : MlneuralcnnCluster, b : MlneuralcnnCluster) -> MlneuralcnnCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_neural_cnn_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_neural_cnn_cluster_copy(s : MlneuralcnnCluster) -> MlneuralcnnCluster {
  let result = ml_neural_cnn_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_neural_cnn_cluster_fill(s : MlneuralcnnCluster, v : Double) -> MlneuralcnnCluster {
  let result = ml_neural_cnn_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_neural_cnn_cluster_min(s : MlneuralcnnCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_neural_cnn_cluster_max(s : MlneuralcnnCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_neural_cnn_cluster_to_string(s : MlneuralcnnCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuralcnnModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_cnn_model_make(size : Int) -> MlneuralcnnModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_cnn_model_len(s : MlneuralcnnModel) -> Int { s.size }

pub fn ml_neural_cnn_model_get(s : MlneuralcnnModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_cnn_model_set(s : MlneuralcnnModel, i : Int, v : Double) -> MlneuralcnnModel {
  let result = ml_neural_cnn_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_neural_cnn_model_sum(s : MlneuralcnnModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_neural_cnn_model_mean(s : MlneuralcnnModel) -> Double {
  if s.size == 0 { 0.0 } else { ml_neural_cnn_model_sum(s) / s.size.to_double() }
}

pub fn ml_neural_cnn_model_scale(s : MlneuralcnnModel, f : Double) -> MlneuralcnnModel {
  let result = ml_neural_cnn_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_neural_cnn_model_add(a : MlneuralcnnModel, b : MlneuralcnnModel) -> MlneuralcnnModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_neural_cnn_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_neural_cnn_model_copy(s : MlneuralcnnModel) -> MlneuralcnnModel {
  let result = ml_neural_cnn_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_neural_cnn_model_fill(s : MlneuralcnnModel, v : Double) -> MlneuralcnnModel {
  let result = ml_neural_cnn_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_neural_cnn_model_min(s : MlneuralcnnModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_neural_cnn_model_max(s : MlneuralcnnModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_neural_cnn_model_to_string(s : MlneuralcnnModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuralcnnLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_cnn_layer_make(size : Int) -> MlneuralcnnLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_cnn_layer_len(s : MlneuralcnnLayer) -> Int { s.size }

pub fn ml_neural_cnn_layer_get(s : MlneuralcnnLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_cnn_layer_set(s : MlneuralcnnLayer, i : Int, v : Double) -> MlneuralcnnLayer {
  let result = ml_neural_cnn_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_neural_cnn_layer_sum(s : MlneuralcnnLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_neural_cnn_layer_mean(s : MlneuralcnnLayer) -> Double {
  if s.size == 0 { 0.0 } else { ml_neural_cnn_layer_sum(s) / s.size.to_double() }
}

pub fn ml_neural_cnn_layer_scale(s : MlneuralcnnLayer, f : Double) -> MlneuralcnnLayer {
  let result = ml_neural_cnn_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_neural_cnn_layer_add(a : MlneuralcnnLayer, b : MlneuralcnnLayer) -> MlneuralcnnLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_neural_cnn_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_neural_cnn_layer_copy(s : MlneuralcnnLayer) -> MlneuralcnnLayer {
  let result = ml_neural_cnn_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_neural_cnn_layer_fill(s : MlneuralcnnLayer, v : Double) -> MlneuralcnnLayer {
  let result = ml_neural_cnn_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_neural_cnn_layer_min(s : MlneuralcnnLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_neural_cnn_layer_max(s : MlneuralcnnLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_neural_cnn_layer_to_string(s : MlneuralcnnLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuralcnnBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_cnn_buffer_make(size : Int) -> MlneuralcnnBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_cnn_buffer_len(s : MlneuralcnnBuffer) -> Int { s.size }

pub fn ml_neural_cnn_buffer_get(s : MlneuralcnnBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_cnn_buffer_set(s : MlneuralcnnBuffer, i : Int, v : Double) -> MlneuralcnnBuffer {
  let result = ml_neural_cnn_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_neural_cnn_buffer_sum(s : MlneuralcnnBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_neural_cnn_buffer_mean(s : MlneuralcnnBuffer) -> Double {
  if s.size == 0 { 0.0 } else { ml_neural_cnn_buffer_sum(s) / s.size.to_double() }
}

pub fn ml_neural_cnn_buffer_scale(s : MlneuralcnnBuffer, f : Double) -> MlneuralcnnBuffer {
  let result = ml_neural_cnn_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_neural_cnn_buffer_add(a : MlneuralcnnBuffer, b : MlneuralcnnBuffer) -> MlneuralcnnBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_neural_cnn_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_neural_cnn_buffer_copy(s : MlneuralcnnBuffer) -> MlneuralcnnBuffer {
  let result = ml_neural_cnn_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_neural_cnn_buffer_fill(s : MlneuralcnnBuffer, v : Double) -> MlneuralcnnBuffer {
  let result = ml_neural_cnn_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_neural_cnn_buffer_min(s : MlneuralcnnBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_neural_cnn_buffer_max(s : MlneuralcnnBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_neural_cnn_buffer_to_string(s : MlneuralcnnBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuralcnnCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_cnn_cursor_make(size : Int) -> MlneuralcnnCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_cnn_cursor_len(s : MlneuralcnnCursor) -> Int { s.size }

pub fn ml_neural_cnn_cursor_get(s : MlneuralcnnCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_cnn_cursor_set(s : MlneuralcnnCursor, i : Int, v : Double) -> MlneuralcnnCursor {
  let result = ml_neural_cnn_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_neural_cnn_cursor_sum(s : MlneuralcnnCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_neural_cnn_cursor_mean(s : MlneuralcnnCursor) -> Double {
  if s.size == 0 { 0.0 } else { ml_neural_cnn_cursor_sum(s) / s.size.to_double() }
}

pub fn ml_neural_cnn_cursor_scale(s : MlneuralcnnCursor, f : Double) -> MlneuralcnnCursor {
  let result = ml_neural_cnn_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_neural_cnn_cursor_add(a : MlneuralcnnCursor, b : MlneuralcnnCursor) -> MlneuralcnnCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_neural_cnn_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_neural_cnn_cursor_copy(s : MlneuralcnnCursor) -> MlneuralcnnCursor {
  let result = ml_neural_cnn_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_neural_cnn_cursor_fill(s : MlneuralcnnCursor, v : Double) -> MlneuralcnnCursor {
  let result = ml_neural_cnn_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_neural_cnn_cursor_min(s : MlneuralcnnCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_neural_cnn_cursor_max(s : MlneuralcnnCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_neural_cnn_cursor_to_string(s : MlneuralcnnCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuralcnnView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_cnn_view_make(size : Int) -> MlneuralcnnView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_cnn_view_len(s : MlneuralcnnView) -> Int { s.size }

pub fn ml_neural_cnn_view_get(s : MlneuralcnnView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_cnn_view_set(s : MlneuralcnnView, i : Int, v : Double) -> MlneuralcnnView {
  let result = ml_neural_cnn_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_neural_cnn_view_sum(s : MlneuralcnnView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_neural_cnn_view_mean(s : MlneuralcnnView) -> Double {
  if s.size == 0 { 0.0 } else { ml_neural_cnn_view_sum(s) / s.size.to_double() }
}

pub fn ml_neural_cnn_view_scale(s : MlneuralcnnView, f : Double) -> MlneuralcnnView {
  let result = ml_neural_cnn_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_neural_cnn_view_add(a : MlneuralcnnView, b : MlneuralcnnView) -> MlneuralcnnView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_neural_cnn_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_neural_cnn_view_copy(s : MlneuralcnnView) -> MlneuralcnnView {
  let result = ml_neural_cnn_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_neural_cnn_view_fill(s : MlneuralcnnView, v : Double) -> MlneuralcnnView {
  let result = ml_neural_cnn_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_neural_cnn_view_min(s : MlneuralcnnView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_neural_cnn_view_max(s : MlneuralcnnView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_neural_cnn_view_to_string(s : MlneuralcnnView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuralcnnRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_cnn_range_make(size : Int) -> MlneuralcnnRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_cnn_range_len(s : MlneuralcnnRange) -> Int { s.size }

pub fn ml_neural_cnn_range_get(s : MlneuralcnnRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_cnn_range_set(s : MlneuralcnnRange, i : Int, v : Double) -> MlneuralcnnRange {
  let result = ml_neural_cnn_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_neural_cnn_range_sum(s : MlneuralcnnRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_neural_cnn_range_mean(s : MlneuralcnnRange) -> Double {
  if s.size == 0 { 0.0 } else { ml_neural_cnn_range_sum(s) / s.size.to_double() }
}

pub fn ml_neural_cnn_range_scale(s : MlneuralcnnRange, f : Double) -> MlneuralcnnRange {
  let result = ml_neural_cnn_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_neural_cnn_range_add(a : MlneuralcnnRange, b : MlneuralcnnRange) -> MlneuralcnnRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_neural_cnn_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_neural_cnn_range_copy(s : MlneuralcnnRange) -> MlneuralcnnRange {
  let result = ml_neural_cnn_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_neural_cnn_range_fill(s : MlneuralcnnRange, v : Double) -> MlneuralcnnRange {
  let result = ml_neural_cnn_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_neural_cnn_range_min(s : MlneuralcnnRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_neural_cnn_range_max(s : MlneuralcnnRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_neural_cnn_range_to_string(s : MlneuralcnnRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuralcnnSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_cnn_slice_make(size : Int) -> MlneuralcnnSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_cnn_slice_len(s : MlneuralcnnSlice) -> Int { s.size }

pub fn ml_neural_cnn_slice_get(s : MlneuralcnnSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_cnn_slice_set(s : MlneuralcnnSlice, i : Int, v : Double) -> MlneuralcnnSlice {
  let result = ml_neural_cnn_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_neural_cnn_slice_sum(s : MlneuralcnnSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_neural_cnn_slice_mean(s : MlneuralcnnSlice) -> Double {
  if s.size == 0 { 0.0 } else { ml_neural_cnn_slice_sum(s) / s.size.to_double() }
}

pub fn ml_neural_cnn_slice_scale(s : MlneuralcnnSlice, f : Double) -> MlneuralcnnSlice {
  let result = ml_neural_cnn_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_neural_cnn_slice_add(a : MlneuralcnnSlice, b : MlneuralcnnSlice) -> MlneuralcnnSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_neural_cnn_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_neural_cnn_slice_copy(s : MlneuralcnnSlice) -> MlneuralcnnSlice {
  let result = ml_neural_cnn_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_neural_cnn_slice_fill(s : MlneuralcnnSlice, v : Double) -> MlneuralcnnSlice {
  let result = ml_neural_cnn_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_neural_cnn_slice_min(s : MlneuralcnnSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_neural_cnn_slice_max(s : MlneuralcnnSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_neural_cnn_slice_to_string(s : MlneuralcnnSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

