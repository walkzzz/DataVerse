///===
/// extcore/ml_neural_vae

pub(all) struct MlneuralvaePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_neural_vae_make_point(x : Double, y : Double) -> MlneuralvaePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_neural_vae_make_point3(x : Double, y : Double, z : Double) -> MlneuralvaePoint {
  { x, y, z, label: 0 }
}

pub fn ml_neural_vae_point_x(pt : MlneuralvaePoint) -> Double { pt.x }

pub fn ml_neural_vae_point_y(pt : MlneuralvaePoint) -> Double { pt.y }

pub fn ml_neural_vae_point_z(pt : MlneuralvaePoint) -> Double { pt.z }

pub fn ml_neural_vae_point_label(pt : MlneuralvaePoint) -> Int { pt.label }

pub fn ml_neural_vae_point_dist(a : MlneuralvaePoint, b : MlneuralvaePoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  ml_neural_vae_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ml_neural_vae_point_add(a : MlneuralvaePoint, b : MlneuralvaePoint) -> MlneuralvaePoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn ml_neural_vae_point_sub(a : MlneuralvaePoint, b : MlneuralvaePoint) -> MlneuralvaePoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn ml_neural_vae_point_scale(pt : MlneuralvaePoint, s : Double) -> MlneuralvaePoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn ml_neural_vae_point_dot(a : MlneuralvaePoint, b : MlneuralvaePoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn ml_neural_vae_point_cross(a : MlneuralvaePoint, b : MlneuralvaePoint) -> MlneuralvaePoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn ml_neural_vae_point_norm(pt : MlneuralvaePoint) -> Double {
  ml_neural_vae_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn ml_neural_vae_point_normalize(pt : MlneuralvaePoint) -> MlneuralvaePoint {
  let n = ml_neural_vae_point_norm(pt)
  if n < 0.0000001 { pt } else { ml_neural_vae_point_scale(pt, 1.0 / n) }
}

pub fn ml_neural_vae_point_negate(pt : MlneuralvaePoint) -> MlneuralvaePoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn ml_neural_vae_point_mid(a : MlneuralvaePoint, b : MlneuralvaePoint) -> MlneuralvaePoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn ml_neural_vae_point_lerp(a : MlneuralvaePoint, b : MlneuralvaePoint, t : Double) -> MlneuralvaePoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn ml_neural_vae_point_to_string(pt : MlneuralvaePoint) -> String {
  "(" + ml_neural_vae_dbl(pt.x) + ", " + ml_neural_vae_dbl(pt.y) + ", " + ml_neural_vae_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct MlneuralvaeSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_neural_vae_make_series(vals : Array[Double], name : String) -> MlneuralvaeSeries {
  { vals, name, meta: 0 }
}

pub fn ml_neural_vae_series_len(s : MlneuralvaeSeries) -> Int { s.vals.length() }

pub fn ml_neural_vae_series_sum(s : MlneuralvaeSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn ml_neural_vae_series_mean(s : MlneuralvaeSeries) -> Double {
  let n = ml_neural_vae_series_len(s)
  if n == 0 { 0.0 } else { ml_neural_vae_series_sum(s) / n.to_double() }
}

pub fn ml_neural_vae_series_min(s : MlneuralvaeSeries) -> Double {
  let n = ml_neural_vae_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn ml_neural_vae_series_max(s : MlneuralvaeSeries) -> Double {
  let n = ml_neural_vae_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn ml_neural_vae_series_range(s : MlneuralvaeSeries) -> Double {
  ml_neural_vae_series_max(s) - ml_neural_vae_series_min(s)
}

pub fn ml_neural_vae_series_var(s : MlneuralvaeSeries) -> Double {
  let n = ml_neural_vae_series_len(s)
  if n == 0 { 0.0 } else {
    let m = ml_neural_vae_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn ml_neural_vae_series_std(s : MlneuralvaeSeries) -> Double { ml_neural_vae_sqrt(ml_neural_vae_series_var(s)) }

pub fn ml_neural_vae_series_median(s : MlneuralvaeSeries) -> Double {
  let n = ml_neural_vae_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = ml_neural_vae_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn ml_neural_vae_series_scale(s : MlneuralvaeSeries, f : Double) -> MlneuralvaeSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = ml_neural_vae_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn ml_neural_vae_series_add(a : MlneuralvaeSeries, b : MlneuralvaeSeries) -> MlneuralvaeSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = ml_neural_vae_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn ml_neural_vae_series_sub(a : MlneuralvaeSeries, b : MlneuralvaeSeries) -> MlneuralvaeSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = ml_neural_vae_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn ml_neural_vae_series_normalize(s : MlneuralvaeSeries) -> MlneuralvaeSeries {
  let mn = ml_neural_vae_series_min(s)
  let mx = ml_neural_vae_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = ml_neural_vae_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn ml_neural_vae_series_cumsum(s : MlneuralvaeSeries) -> MlneuralvaeSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = ml_neural_vae_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn ml_neural_vae_series_to_string(s : MlneuralvaeSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + ml_neural_vae_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlneuralvaeMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_neural_vae_make_matrix(rows : Int, cols : Int, val : Double) -> MlneuralvaeMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_neural_vae_matrix_identity(n : Int) -> MlneuralvaeMatrix {
  let m = ml_neural_vae_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ml_neural_vae_matrix_get(m : MlneuralvaeMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn ml_neural_vae_matrix_transpose(m : MlneuralvaeMatrix) -> MlneuralvaeMatrix {
  let result = ml_neural_vae_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn ml_neural_vae_matrix_add(a : MlneuralvaeMatrix, b : MlneuralvaeMatrix) -> MlneuralvaeMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = ml_neural_vae_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn ml_neural_vae_matrix_scale(m : MlneuralvaeMatrix, s : Double) -> MlneuralvaeMatrix {
  let result = ml_neural_vae_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn ml_neural_vae_matrix_multiply(a : MlneuralvaeMatrix, b : MlneuralvaeMatrix) -> MlneuralvaeMatrix {
  if a.cols != b.rows { return ml_neural_vae_make_matrix(a.rows, b.cols, 0.0) }
  let result = ml_neural_vae_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ml_neural_vae_matrix_trace(m : MlneuralvaeMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn ml_neural_vae_matrix_det(m : MlneuralvaeMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ml_neural_vae_matrix_norm(m : MlneuralvaeMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  ml_neural_vae_sqrt(sum)
}

pub fn ml_neural_vae_matrix_to_string(m : MlneuralvaeMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + ml_neural_vae_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct MlneuralvaeVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_neural_vae_make_vector(comps : Array[Double]) -> MlneuralvaeVector {
  { comps, dim: comps.length() }
}

pub fn ml_neural_vae_vector_zero(dim : Int) -> MlneuralvaeVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ml_neural_vae_vector_add(a : MlneuralvaeVector, b : MlneuralvaeVector) -> MlneuralvaeVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = ml_neural_vae_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ml_neural_vae_vector_sub(a : MlneuralvaeVector, b : MlneuralvaeVector) -> MlneuralvaeVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = ml_neural_vae_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ml_neural_vae_vector_scale(v : MlneuralvaeVector, s : Double) -> MlneuralvaeVector {
  let mut result = []
  for i in 0..<v.dim { result = ml_neural_vae_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn ml_neural_vae_vector_dot(a : MlneuralvaeVector, b : MlneuralvaeVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn ml_neural_vae_vector_norm(v : MlneuralvaeVector) -> Double { ml_neural_vae_sqrt(ml_neural_vae_vector_dot(v, v)) }

pub fn ml_neural_vae_vector_normalize(v : MlneuralvaeVector) -> MlneuralvaeVector {
  let n = ml_neural_vae_vector_norm(v)
  if n < 0.0000001 { v } else { ml_neural_vae_vector_scale(v, 1.0 / n) }
}

pub fn ml_neural_vae_vector_dist(a : MlneuralvaeVector, b : MlneuralvaeVector) -> Double {
  ml_neural_vae_vector_norm(ml_neural_vae_vector_sub(a, b))
}

pub fn ml_neural_vae_vector_to_string(v : MlneuralvaeVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + ml_neural_vae_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ml_neural_vae_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn ml_neural_vae_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = ml_neural_vae_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn ml_neural_vae_std(data : Array[Double]) -> Double { ml_neural_vae_sqrt(ml_neural_vae_var(data)) }

pub fn ml_neural_vae_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = ml_neural_vae_mean(a); let mb = ml_neural_vae_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn ml_neural_vae_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = ml_neural_vae_std(a); let sb = ml_neural_vae_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { ml_neural_vae_cov(a, b) / (sa * sb) }
}

pub fn ml_neural_vae_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = ml_neural_vae_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn ml_neural_vae_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn ml_neural_vae_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn ml_neural_vae_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  ml_neural_vae_sqrt(ml_neural_vae_mse(pred, labels))
}

pub fn ml_neural_vae_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + ml_neural_vae_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn ml_neural_vae_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = ml_neural_vae_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn ml_neural_vae_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn ml_neural_vae_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn ml_neural_vae_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = ml_neural_vae_precision(pred, labels, pos); let r = ml_neural_vae_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn ml_neural_vae_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn ml_neural_vae_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = ml_neural_vae_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn ml_neural_vae_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn ml_neural_vae_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn ml_neural_vae_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = ml_neural_vae_gcd(a, b)
    (a / g) * b
  }
}

pub fn ml_neural_vae_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn ml_neural_vae_fibonacci(n : Int) -> Int {
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

pub fn ml_neural_vae_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = ml_neural_vae_min(data); let mx = ml_neural_vae_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn ml_neural_vae_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = ml_neural_vae_mean(data); let sd = ml_neural_vae_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn ml_neural_vae_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn ml_neural_vae_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn ml_neural_vae_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn ml_neural_vae_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn ml_neural_vae_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn ml_neural_vae_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn ml_neural_vae_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn ml_neural_vae_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn ml_neural_vae_dbl(x : Double) -> String {
  let i = if x >= 0.0 { ml_neural_vae_int(x) } else { -ml_neural_vae_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { ml_neural_vae_int(f * 1000000.0) } else { ml_neural_vae_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn ml_neural_vae_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn ml_neural_vae_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct MlneuralvaeFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_vae_frame_make(size : Int) -> MlneuralvaeFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_vae_frame_len(s : MlneuralvaeFrame) -> Int { s.size }

pub fn ml_neural_vae_frame_get(s : MlneuralvaeFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_vae_frame_set(s : MlneuralvaeFrame, i : Int, v : Double) -> MlneuralvaeFrame {
  let result = ml_neural_vae_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_neural_vae_frame_sum(s : MlneuralvaeFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_neural_vae_frame_mean(s : MlneuralvaeFrame) -> Double {
  if s.size == 0 { 0.0 } else { ml_neural_vae_frame_sum(s) / s.size.to_double() }
}

pub fn ml_neural_vae_frame_scale(s : MlneuralvaeFrame, f : Double) -> MlneuralvaeFrame {
  let result = ml_neural_vae_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_neural_vae_frame_add(a : MlneuralvaeFrame, b : MlneuralvaeFrame) -> MlneuralvaeFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_neural_vae_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_neural_vae_frame_copy(s : MlneuralvaeFrame) -> MlneuralvaeFrame {
  let result = ml_neural_vae_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_neural_vae_frame_fill(s : MlneuralvaeFrame, v : Double) -> MlneuralvaeFrame {
  let result = ml_neural_vae_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_neural_vae_frame_min(s : MlneuralvaeFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_neural_vae_frame_max(s : MlneuralvaeFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_neural_vae_frame_to_string(s : MlneuralvaeFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuralvaeTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_vae_table_make(size : Int) -> MlneuralvaeTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_vae_table_len(s : MlneuralvaeTable) -> Int { s.size }

pub fn ml_neural_vae_table_get(s : MlneuralvaeTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_vae_table_set(s : MlneuralvaeTable, i : Int, v : Double) -> MlneuralvaeTable {
  let result = ml_neural_vae_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_neural_vae_table_sum(s : MlneuralvaeTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_neural_vae_table_mean(s : MlneuralvaeTable) -> Double {
  if s.size == 0 { 0.0 } else { ml_neural_vae_table_sum(s) / s.size.to_double() }
}

pub fn ml_neural_vae_table_scale(s : MlneuralvaeTable, f : Double) -> MlneuralvaeTable {
  let result = ml_neural_vae_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_neural_vae_table_add(a : MlneuralvaeTable, b : MlneuralvaeTable) -> MlneuralvaeTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_neural_vae_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_neural_vae_table_copy(s : MlneuralvaeTable) -> MlneuralvaeTable {
  let result = ml_neural_vae_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_neural_vae_table_fill(s : MlneuralvaeTable, v : Double) -> MlneuralvaeTable {
  let result = ml_neural_vae_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_neural_vae_table_min(s : MlneuralvaeTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_neural_vae_table_max(s : MlneuralvaeTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_neural_vae_table_to_string(s : MlneuralvaeTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuralvaeGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_vae_graphn_make(size : Int) -> MlneuralvaeGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_vae_graphn_len(s : MlneuralvaeGraphN) -> Int { s.size }

pub fn ml_neural_vae_graphn_get(s : MlneuralvaeGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_vae_graphn_set(s : MlneuralvaeGraphN, i : Int, v : Double) -> MlneuralvaeGraphN {
  let result = ml_neural_vae_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_neural_vae_graphn_sum(s : MlneuralvaeGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_neural_vae_graphn_mean(s : MlneuralvaeGraphN) -> Double {
  if s.size == 0 { 0.0 } else { ml_neural_vae_graphn_sum(s) / s.size.to_double() }
}

pub fn ml_neural_vae_graphn_scale(s : MlneuralvaeGraphN, f : Double) -> MlneuralvaeGraphN {
  let result = ml_neural_vae_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_neural_vae_graphn_add(a : MlneuralvaeGraphN, b : MlneuralvaeGraphN) -> MlneuralvaeGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_neural_vae_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_neural_vae_graphn_copy(s : MlneuralvaeGraphN) -> MlneuralvaeGraphN {
  let result = ml_neural_vae_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_neural_vae_graphn_fill(s : MlneuralvaeGraphN, v : Double) -> MlneuralvaeGraphN {
  let result = ml_neural_vae_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_neural_vae_graphn_min(s : MlneuralvaeGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_neural_vae_graphn_max(s : MlneuralvaeGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_neural_vae_graphn_to_string(s : MlneuralvaeGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuralvaeNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_vae_node_make(size : Int) -> MlneuralvaeNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_vae_node_len(s : MlneuralvaeNode) -> Int { s.size }

pub fn ml_neural_vae_node_get(s : MlneuralvaeNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_vae_node_set(s : MlneuralvaeNode, i : Int, v : Double) -> MlneuralvaeNode {
  let result = ml_neural_vae_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_neural_vae_node_sum(s : MlneuralvaeNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_neural_vae_node_mean(s : MlneuralvaeNode) -> Double {
  if s.size == 0 { 0.0 } else { ml_neural_vae_node_sum(s) / s.size.to_double() }
}

pub fn ml_neural_vae_node_scale(s : MlneuralvaeNode, f : Double) -> MlneuralvaeNode {
  let result = ml_neural_vae_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_neural_vae_node_add(a : MlneuralvaeNode, b : MlneuralvaeNode) -> MlneuralvaeNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_neural_vae_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_neural_vae_node_copy(s : MlneuralvaeNode) -> MlneuralvaeNode {
  let result = ml_neural_vae_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_neural_vae_node_fill(s : MlneuralvaeNode, v : Double) -> MlneuralvaeNode {
  let result = ml_neural_vae_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_neural_vae_node_min(s : MlneuralvaeNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_neural_vae_node_max(s : MlneuralvaeNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_neural_vae_node_to_string(s : MlneuralvaeNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuralvaeEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_vae_edge_make(size : Int) -> MlneuralvaeEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_vae_edge_len(s : MlneuralvaeEdge) -> Int { s.size }

pub fn ml_neural_vae_edge_get(s : MlneuralvaeEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_vae_edge_set(s : MlneuralvaeEdge, i : Int, v : Double) -> MlneuralvaeEdge {
  let result = ml_neural_vae_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_neural_vae_edge_sum(s : MlneuralvaeEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_neural_vae_edge_mean(s : MlneuralvaeEdge) -> Double {
  if s.size == 0 { 0.0 } else { ml_neural_vae_edge_sum(s) / s.size.to_double() }
}

pub fn ml_neural_vae_edge_scale(s : MlneuralvaeEdge, f : Double) -> MlneuralvaeEdge {
  let result = ml_neural_vae_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_neural_vae_edge_add(a : MlneuralvaeEdge, b : MlneuralvaeEdge) -> MlneuralvaeEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_neural_vae_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_neural_vae_edge_copy(s : MlneuralvaeEdge) -> MlneuralvaeEdge {
  let result = ml_neural_vae_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_neural_vae_edge_fill(s : MlneuralvaeEdge, v : Double) -> MlneuralvaeEdge {
  let result = ml_neural_vae_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_neural_vae_edge_min(s : MlneuralvaeEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_neural_vae_edge_max(s : MlneuralvaeEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_neural_vae_edge_to_string(s : MlneuralvaeEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuralvaePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_vae_path_make(size : Int) -> MlneuralvaePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_vae_path_len(s : MlneuralvaePath) -> Int { s.size }

pub fn ml_neural_vae_path_get(s : MlneuralvaePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_vae_path_set(s : MlneuralvaePath, i : Int, v : Double) -> MlneuralvaePath {
  let result = ml_neural_vae_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_neural_vae_path_sum(s : MlneuralvaePath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_neural_vae_path_mean(s : MlneuralvaePath) -> Double {
  if s.size == 0 { 0.0 } else { ml_neural_vae_path_sum(s) / s.size.to_double() }
}

pub fn ml_neural_vae_path_scale(s : MlneuralvaePath, f : Double) -> MlneuralvaePath {
  let result = ml_neural_vae_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_neural_vae_path_add(a : MlneuralvaePath, b : MlneuralvaePath) -> MlneuralvaePath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_neural_vae_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_neural_vae_path_copy(s : MlneuralvaePath) -> MlneuralvaePath {
  let result = ml_neural_vae_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_neural_vae_path_fill(s : MlneuralvaePath, v : Double) -> MlneuralvaePath {
  let result = ml_neural_vae_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_neural_vae_path_min(s : MlneuralvaePath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_neural_vae_path_max(s : MlneuralvaePath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_neural_vae_path_to_string(s : MlneuralvaePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuralvaeCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_vae_cluster_make(size : Int) -> MlneuralvaeCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_vae_cluster_len(s : MlneuralvaeCluster) -> Int { s.size }

pub fn ml_neural_vae_cluster_get(s : MlneuralvaeCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_vae_cluster_set(s : MlneuralvaeCluster, i : Int, v : Double) -> MlneuralvaeCluster {
  let result = ml_neural_vae_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_neural_vae_cluster_sum(s : MlneuralvaeCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_neural_vae_cluster_mean(s : MlneuralvaeCluster) -> Double {
  if s.size == 0 { 0.0 } else { ml_neural_vae_cluster_sum(s) / s.size.to_double() }
}

pub fn ml_neural_vae_cluster_scale(s : MlneuralvaeCluster, f : Double) -> MlneuralvaeCluster {
  let result = ml_neural_vae_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_neural_vae_cluster_add(a : MlneuralvaeCluster, b : MlneuralvaeCluster) -> MlneuralvaeCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_neural_vae_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_neural_vae_cluster_copy(s : MlneuralvaeCluster) -> MlneuralvaeCluster {
  let result = ml_neural_vae_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_neural_vae_cluster_fill(s : MlneuralvaeCluster, v : Double) -> MlneuralvaeCluster {
  let result = ml_neural_vae_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_neural_vae_cluster_min(s : MlneuralvaeCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_neural_vae_cluster_max(s : MlneuralvaeCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_neural_vae_cluster_to_string(s : MlneuralvaeCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuralvaeModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_vae_model_make(size : Int) -> MlneuralvaeModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_vae_model_len(s : MlneuralvaeModel) -> Int { s.size }

pub fn ml_neural_vae_model_get(s : MlneuralvaeModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_vae_model_set(s : MlneuralvaeModel, i : Int, v : Double) -> MlneuralvaeModel {
  let result = ml_neural_vae_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_neural_vae_model_sum(s : MlneuralvaeModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_neural_vae_model_mean(s : MlneuralvaeModel) -> Double {
  if s.size == 0 { 0.0 } else { ml_neural_vae_model_sum(s) / s.size.to_double() }
}

pub fn ml_neural_vae_model_scale(s : MlneuralvaeModel, f : Double) -> MlneuralvaeModel {
  let result = ml_neural_vae_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_neural_vae_model_add(a : MlneuralvaeModel, b : MlneuralvaeModel) -> MlneuralvaeModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_neural_vae_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_neural_vae_model_copy(s : MlneuralvaeModel) -> MlneuralvaeModel {
  let result = ml_neural_vae_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_neural_vae_model_fill(s : MlneuralvaeModel, v : Double) -> MlneuralvaeModel {
  let result = ml_neural_vae_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_neural_vae_model_min(s : MlneuralvaeModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_neural_vae_model_max(s : MlneuralvaeModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_neural_vae_model_to_string(s : MlneuralvaeModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuralvaeLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_vae_layer_make(size : Int) -> MlneuralvaeLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_vae_layer_len(s : MlneuralvaeLayer) -> Int { s.size }

pub fn ml_neural_vae_layer_get(s : MlneuralvaeLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_vae_layer_set(s : MlneuralvaeLayer, i : Int, v : Double) -> MlneuralvaeLayer {
  let result = ml_neural_vae_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_neural_vae_layer_sum(s : MlneuralvaeLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_neural_vae_layer_mean(s : MlneuralvaeLayer) -> Double {
  if s.size == 0 { 0.0 } else { ml_neural_vae_layer_sum(s) / s.size.to_double() }
}

pub fn ml_neural_vae_layer_scale(s : MlneuralvaeLayer, f : Double) -> MlneuralvaeLayer {
  let result = ml_neural_vae_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_neural_vae_layer_add(a : MlneuralvaeLayer, b : MlneuralvaeLayer) -> MlneuralvaeLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_neural_vae_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_neural_vae_layer_copy(s : MlneuralvaeLayer) -> MlneuralvaeLayer {
  let result = ml_neural_vae_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_neural_vae_layer_fill(s : MlneuralvaeLayer, v : Double) -> MlneuralvaeLayer {
  let result = ml_neural_vae_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_neural_vae_layer_min(s : MlneuralvaeLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_neural_vae_layer_max(s : MlneuralvaeLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_neural_vae_layer_to_string(s : MlneuralvaeLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuralvaeBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_vae_buffer_make(size : Int) -> MlneuralvaeBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_vae_buffer_len(s : MlneuralvaeBuffer) -> Int { s.size }

pub fn ml_neural_vae_buffer_get(s : MlneuralvaeBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_vae_buffer_set(s : MlneuralvaeBuffer, i : Int, v : Double) -> MlneuralvaeBuffer {
  let result = ml_neural_vae_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_neural_vae_buffer_sum(s : MlneuralvaeBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_neural_vae_buffer_mean(s : MlneuralvaeBuffer) -> Double {
  if s.size == 0 { 0.0 } else { ml_neural_vae_buffer_sum(s) / s.size.to_double() }
}

pub fn ml_neural_vae_buffer_scale(s : MlneuralvaeBuffer, f : Double) -> MlneuralvaeBuffer {
  let result = ml_neural_vae_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_neural_vae_buffer_add(a : MlneuralvaeBuffer, b : MlneuralvaeBuffer) -> MlneuralvaeBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_neural_vae_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_neural_vae_buffer_copy(s : MlneuralvaeBuffer) -> MlneuralvaeBuffer {
  let result = ml_neural_vae_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_neural_vae_buffer_fill(s : MlneuralvaeBuffer, v : Double) -> MlneuralvaeBuffer {
  let result = ml_neural_vae_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_neural_vae_buffer_min(s : MlneuralvaeBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_neural_vae_buffer_max(s : MlneuralvaeBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_neural_vae_buffer_to_string(s : MlneuralvaeBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuralvaeCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_vae_cursor_make(size : Int) -> MlneuralvaeCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_vae_cursor_len(s : MlneuralvaeCursor) -> Int { s.size }

pub fn ml_neural_vae_cursor_get(s : MlneuralvaeCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_vae_cursor_set(s : MlneuralvaeCursor, i : Int, v : Double) -> MlneuralvaeCursor {
  let result = ml_neural_vae_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_neural_vae_cursor_sum(s : MlneuralvaeCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_neural_vae_cursor_mean(s : MlneuralvaeCursor) -> Double {
  if s.size == 0 { 0.0 } else { ml_neural_vae_cursor_sum(s) / s.size.to_double() }
}

pub fn ml_neural_vae_cursor_scale(s : MlneuralvaeCursor, f : Double) -> MlneuralvaeCursor {
  let result = ml_neural_vae_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_neural_vae_cursor_add(a : MlneuralvaeCursor, b : MlneuralvaeCursor) -> MlneuralvaeCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_neural_vae_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_neural_vae_cursor_copy(s : MlneuralvaeCursor) -> MlneuralvaeCursor {
  let result = ml_neural_vae_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_neural_vae_cursor_fill(s : MlneuralvaeCursor, v : Double) -> MlneuralvaeCursor {
  let result = ml_neural_vae_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_neural_vae_cursor_min(s : MlneuralvaeCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_neural_vae_cursor_max(s : MlneuralvaeCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_neural_vae_cursor_to_string(s : MlneuralvaeCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuralvaeView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_vae_view_make(size : Int) -> MlneuralvaeView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_vae_view_len(s : MlneuralvaeView) -> Int { s.size }

pub fn ml_neural_vae_view_get(s : MlneuralvaeView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_vae_view_set(s : MlneuralvaeView, i : Int, v : Double) -> MlneuralvaeView {
  let result = ml_neural_vae_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_neural_vae_view_sum(s : MlneuralvaeView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_neural_vae_view_mean(s : MlneuralvaeView) -> Double {
  if s.size == 0 { 0.0 } else { ml_neural_vae_view_sum(s) / s.size.to_double() }
}

pub fn ml_neural_vae_view_scale(s : MlneuralvaeView, f : Double) -> MlneuralvaeView {
  let result = ml_neural_vae_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_neural_vae_view_add(a : MlneuralvaeView, b : MlneuralvaeView) -> MlneuralvaeView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_neural_vae_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_neural_vae_view_copy(s : MlneuralvaeView) -> MlneuralvaeView {
  let result = ml_neural_vae_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_neural_vae_view_fill(s : MlneuralvaeView, v : Double) -> MlneuralvaeView {
  let result = ml_neural_vae_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_neural_vae_view_min(s : MlneuralvaeView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_neural_vae_view_max(s : MlneuralvaeView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_neural_vae_view_to_string(s : MlneuralvaeView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuralvaeRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_vae_range_make(size : Int) -> MlneuralvaeRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_vae_range_len(s : MlneuralvaeRange) -> Int { s.size }

pub fn ml_neural_vae_range_get(s : MlneuralvaeRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_vae_range_set(s : MlneuralvaeRange, i : Int, v : Double) -> MlneuralvaeRange {
  let result = ml_neural_vae_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_neural_vae_range_sum(s : MlneuralvaeRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_neural_vae_range_mean(s : MlneuralvaeRange) -> Double {
  if s.size == 0 { 0.0 } else { ml_neural_vae_range_sum(s) / s.size.to_double() }
}

pub fn ml_neural_vae_range_scale(s : MlneuralvaeRange, f : Double) -> MlneuralvaeRange {
  let result = ml_neural_vae_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_neural_vae_range_add(a : MlneuralvaeRange, b : MlneuralvaeRange) -> MlneuralvaeRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_neural_vae_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_neural_vae_range_copy(s : MlneuralvaeRange) -> MlneuralvaeRange {
  let result = ml_neural_vae_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_neural_vae_range_fill(s : MlneuralvaeRange, v : Double) -> MlneuralvaeRange {
  let result = ml_neural_vae_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_neural_vae_range_min(s : MlneuralvaeRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_neural_vae_range_max(s : MlneuralvaeRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_neural_vae_range_to_string(s : MlneuralvaeRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuralvaeSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_vae_slice_make(size : Int) -> MlneuralvaeSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_vae_slice_len(s : MlneuralvaeSlice) -> Int { s.size }

pub fn ml_neural_vae_slice_get(s : MlneuralvaeSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_vae_slice_set(s : MlneuralvaeSlice, i : Int, v : Double) -> MlneuralvaeSlice {
  let result = ml_neural_vae_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_neural_vae_slice_sum(s : MlneuralvaeSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_neural_vae_slice_mean(s : MlneuralvaeSlice) -> Double {
  if s.size == 0 { 0.0 } else { ml_neural_vae_slice_sum(s) / s.size.to_double() }
}

pub fn ml_neural_vae_slice_scale(s : MlneuralvaeSlice, f : Double) -> MlneuralvaeSlice {
  let result = ml_neural_vae_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_neural_vae_slice_add(a : MlneuralvaeSlice, b : MlneuralvaeSlice) -> MlneuralvaeSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_neural_vae_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_neural_vae_slice_copy(s : MlneuralvaeSlice) -> MlneuralvaeSlice {
  let result = ml_neural_vae_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_neural_vae_slice_fill(s : MlneuralvaeSlice, v : Double) -> MlneuralvaeSlice {
  let result = ml_neural_vae_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_neural_vae_slice_min(s : MlneuralvaeSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_neural_vae_slice_max(s : MlneuralvaeSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_neural_vae_slice_to_string(s : MlneuralvaeSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn ml_neural_vae_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_neural_vae_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_neural_vae_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_neural_vae_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_neural_vae_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_neural_vae_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_neural_vae_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_neural_vae_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_neural_vae_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_neural_vae_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_neural_vae_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_neural_vae_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_neural_vae_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_neural_vae_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_neural_vae_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_neural_vae_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_neural_vae_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_neural_vae_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_neural_vae_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_neural_vae_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_neural_vae_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_neural_vae_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_neural_vae_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_neural_vae_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_neural_vae_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

