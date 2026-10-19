///===
/// extcore/ml_neural_attention

pub(all) struct MlneuralattentionPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_neural_attention_make_point(x : Double, y : Double) -> MlneuralattentionPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_neural_attention_make_point3(x : Double, y : Double, z : Double) -> MlneuralattentionPoint {
  { x, y, z, label: 0 }
}

pub fn ml_neural_attention_point_x(pt : MlneuralattentionPoint) -> Double { pt.x }

pub fn ml_neural_attention_point_y(pt : MlneuralattentionPoint) -> Double { pt.y }

pub fn ml_neural_attention_point_z(pt : MlneuralattentionPoint) -> Double { pt.z }

pub fn ml_neural_attention_point_label(pt : MlneuralattentionPoint) -> Int { pt.label }

pub fn ml_neural_attention_point_dist(a : MlneuralattentionPoint, b : MlneuralattentionPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  ml_neural_attention_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ml_neural_attention_point_add(a : MlneuralattentionPoint, b : MlneuralattentionPoint) -> MlneuralattentionPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn ml_neural_attention_point_sub(a : MlneuralattentionPoint, b : MlneuralattentionPoint) -> MlneuralattentionPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn ml_neural_attention_point_scale(pt : MlneuralattentionPoint, s : Double) -> MlneuralattentionPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn ml_neural_attention_point_dot(a : MlneuralattentionPoint, b : MlneuralattentionPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn ml_neural_attention_point_cross(a : MlneuralattentionPoint, b : MlneuralattentionPoint) -> MlneuralattentionPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn ml_neural_attention_point_norm(pt : MlneuralattentionPoint) -> Double {
  ml_neural_attention_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn ml_neural_attention_point_normalize(pt : MlneuralattentionPoint) -> MlneuralattentionPoint {
  let n = ml_neural_attention_point_norm(pt)
  if n < 0.0000001 { pt } else { ml_neural_attention_point_scale(pt, 1.0 / n) }
}

pub fn ml_neural_attention_point_negate(pt : MlneuralattentionPoint) -> MlneuralattentionPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn ml_neural_attention_point_mid(a : MlneuralattentionPoint, b : MlneuralattentionPoint) -> MlneuralattentionPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn ml_neural_attention_point_lerp(a : MlneuralattentionPoint, b : MlneuralattentionPoint, t : Double) -> MlneuralattentionPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn ml_neural_attention_point_to_string(pt : MlneuralattentionPoint) -> String {
  "(" + ml_neural_attention_dbl(pt.x) + ", " + ml_neural_attention_dbl(pt.y) + ", " + ml_neural_attention_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct MlneuralattentionSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_neural_attention_make_series(vals : Array[Double], name : String) -> MlneuralattentionSeries {
  { vals, name, meta: 0 }
}

pub fn ml_neural_attention_series_len(s : MlneuralattentionSeries) -> Int { s.vals.length() }

pub fn ml_neural_attention_series_sum(s : MlneuralattentionSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn ml_neural_attention_series_mean(s : MlneuralattentionSeries) -> Double {
  let n = ml_neural_attention_series_len(s)
  if n == 0 { 0.0 } else { ml_neural_attention_series_sum(s) / n.to_double() }
}

pub fn ml_neural_attention_series_min(s : MlneuralattentionSeries) -> Double {
  let n = ml_neural_attention_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn ml_neural_attention_series_max(s : MlneuralattentionSeries) -> Double {
  let n = ml_neural_attention_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn ml_neural_attention_series_range(s : MlneuralattentionSeries) -> Double {
  ml_neural_attention_series_max(s) - ml_neural_attention_series_min(s)
}

pub fn ml_neural_attention_series_var(s : MlneuralattentionSeries) -> Double {
  let n = ml_neural_attention_series_len(s)
  if n == 0 { 0.0 } else {
    let m = ml_neural_attention_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn ml_neural_attention_series_std(s : MlneuralattentionSeries) -> Double { ml_neural_attention_sqrt(ml_neural_attention_series_var(s)) }

pub fn ml_neural_attention_series_median(s : MlneuralattentionSeries) -> Double {
  let n = ml_neural_attention_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = ml_neural_attention_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn ml_neural_attention_series_scale(s : MlneuralattentionSeries, f : Double) -> MlneuralattentionSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = ml_neural_attention_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn ml_neural_attention_series_add(a : MlneuralattentionSeries, b : MlneuralattentionSeries) -> MlneuralattentionSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = ml_neural_attention_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn ml_neural_attention_series_sub(a : MlneuralattentionSeries, b : MlneuralattentionSeries) -> MlneuralattentionSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = ml_neural_attention_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn ml_neural_attention_series_normalize(s : MlneuralattentionSeries) -> MlneuralattentionSeries {
  let mn = ml_neural_attention_series_min(s)
  let mx = ml_neural_attention_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = ml_neural_attention_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn ml_neural_attention_series_cumsum(s : MlneuralattentionSeries) -> MlneuralattentionSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = ml_neural_attention_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn ml_neural_attention_series_to_string(s : MlneuralattentionSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + ml_neural_attention_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlneuralattentionMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_neural_attention_make_matrix(rows : Int, cols : Int, val : Double) -> MlneuralattentionMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_neural_attention_matrix_identity(n : Int) -> MlneuralattentionMatrix {
  let m = ml_neural_attention_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ml_neural_attention_matrix_get(m : MlneuralattentionMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn ml_neural_attention_matrix_transpose(m : MlneuralattentionMatrix) -> MlneuralattentionMatrix {
  let result = ml_neural_attention_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn ml_neural_attention_matrix_add(a : MlneuralattentionMatrix, b : MlneuralattentionMatrix) -> MlneuralattentionMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = ml_neural_attention_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn ml_neural_attention_matrix_scale(m : MlneuralattentionMatrix, s : Double) -> MlneuralattentionMatrix {
  let result = ml_neural_attention_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn ml_neural_attention_matrix_multiply(a : MlneuralattentionMatrix, b : MlneuralattentionMatrix) -> MlneuralattentionMatrix {
  if a.cols != b.rows { return ml_neural_attention_make_matrix(a.rows, b.cols, 0.0) }
  let result = ml_neural_attention_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ml_neural_attention_matrix_trace(m : MlneuralattentionMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn ml_neural_attention_matrix_det(m : MlneuralattentionMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ml_neural_attention_matrix_norm(m : MlneuralattentionMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  ml_neural_attention_sqrt(sum)
}

pub fn ml_neural_attention_matrix_to_string(m : MlneuralattentionMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + ml_neural_attention_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct MlneuralattentionVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_neural_attention_make_vector(comps : Array[Double]) -> MlneuralattentionVector {
  { comps, dim: comps.length() }
}

pub fn ml_neural_attention_vector_zero(dim : Int) -> MlneuralattentionVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ml_neural_attention_vector_add(a : MlneuralattentionVector, b : MlneuralattentionVector) -> MlneuralattentionVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = ml_neural_attention_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ml_neural_attention_vector_sub(a : MlneuralattentionVector, b : MlneuralattentionVector) -> MlneuralattentionVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = ml_neural_attention_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ml_neural_attention_vector_scale(v : MlneuralattentionVector, s : Double) -> MlneuralattentionVector {
  let mut result = []
  for i in 0..<v.dim { result = ml_neural_attention_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn ml_neural_attention_vector_dot(a : MlneuralattentionVector, b : MlneuralattentionVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn ml_neural_attention_vector_norm(v : MlneuralattentionVector) -> Double { ml_neural_attention_sqrt(ml_neural_attention_vector_dot(v, v)) }

pub fn ml_neural_attention_vector_normalize(v : MlneuralattentionVector) -> MlneuralattentionVector {
  let n = ml_neural_attention_vector_norm(v)
  if n < 0.0000001 { v } else { ml_neural_attention_vector_scale(v, 1.0 / n) }
}

pub fn ml_neural_attention_vector_dist(a : MlneuralattentionVector, b : MlneuralattentionVector) -> Double {
  ml_neural_attention_vector_norm(ml_neural_attention_vector_sub(a, b))
}

pub fn ml_neural_attention_vector_to_string(v : MlneuralattentionVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + ml_neural_attention_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ml_neural_attention_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn ml_neural_attention_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = ml_neural_attention_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn ml_neural_attention_std(data : Array[Double]) -> Double { ml_neural_attention_sqrt(ml_neural_attention_var(data)) }

pub fn ml_neural_attention_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = ml_neural_attention_mean(a); let mb = ml_neural_attention_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn ml_neural_attention_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = ml_neural_attention_std(a); let sb = ml_neural_attention_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { ml_neural_attention_cov(a, b) / (sa * sb) }
}

pub fn ml_neural_attention_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = ml_neural_attention_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn ml_neural_attention_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn ml_neural_attention_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn ml_neural_attention_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  ml_neural_attention_sqrt(ml_neural_attention_mse(pred, labels))
}

pub fn ml_neural_attention_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + ml_neural_attention_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn ml_neural_attention_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = ml_neural_attention_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn ml_neural_attention_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn ml_neural_attention_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn ml_neural_attention_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = ml_neural_attention_precision(pred, labels, pos); let r = ml_neural_attention_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn ml_neural_attention_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn ml_neural_attention_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = ml_neural_attention_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn ml_neural_attention_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn ml_neural_attention_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn ml_neural_attention_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = ml_neural_attention_gcd(a, b)
    (a / g) * b
  }
}

pub fn ml_neural_attention_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn ml_neural_attention_fibonacci(n : Int) -> Int {
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

pub fn ml_neural_attention_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = ml_neural_attention_min(data); let mx = ml_neural_attention_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn ml_neural_attention_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = ml_neural_attention_mean(data); let sd = ml_neural_attention_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn ml_neural_attention_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn ml_neural_attention_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn ml_neural_attention_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn ml_neural_attention_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn ml_neural_attention_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn ml_neural_attention_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn ml_neural_attention_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn ml_neural_attention_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn ml_neural_attention_dbl(x : Double) -> String {
  let i = if x >= 0.0 { ml_neural_attention_int(x) } else { -ml_neural_attention_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { ml_neural_attention_int(f * 1000000.0) } else { ml_neural_attention_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn ml_neural_attention_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn ml_neural_attention_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct MlneuralattentionFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_attention_frame_make(size : Int) -> MlneuralattentionFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_attention_frame_len(s : MlneuralattentionFrame) -> Int { s.size }

pub fn ml_neural_attention_frame_get(s : MlneuralattentionFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_attention_frame_set(s : MlneuralattentionFrame, i : Int, v : Double) -> MlneuralattentionFrame {
  let result = ml_neural_attention_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_neural_attention_frame_sum(s : MlneuralattentionFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_neural_attention_frame_mean(s : MlneuralattentionFrame) -> Double {
  if s.size == 0 { 0.0 } else { ml_neural_attention_frame_sum(s) / s.size.to_double() }
}

pub fn ml_neural_attention_frame_scale(s : MlneuralattentionFrame, f : Double) -> MlneuralattentionFrame {
  let result = ml_neural_attention_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_neural_attention_frame_add(a : MlneuralattentionFrame, b : MlneuralattentionFrame) -> MlneuralattentionFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_neural_attention_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_neural_attention_frame_copy(s : MlneuralattentionFrame) -> MlneuralattentionFrame {
  let result = ml_neural_attention_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_neural_attention_frame_fill(s : MlneuralattentionFrame, v : Double) -> MlneuralattentionFrame {
  let result = ml_neural_attention_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_neural_attention_frame_min(s : MlneuralattentionFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_neural_attention_frame_max(s : MlneuralattentionFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_neural_attention_frame_to_string(s : MlneuralattentionFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuralattentionTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_attention_table_make(size : Int) -> MlneuralattentionTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_attention_table_len(s : MlneuralattentionTable) -> Int { s.size }

pub fn ml_neural_attention_table_get(s : MlneuralattentionTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_attention_table_set(s : MlneuralattentionTable, i : Int, v : Double) -> MlneuralattentionTable {
  let result = ml_neural_attention_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_neural_attention_table_sum(s : MlneuralattentionTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_neural_attention_table_mean(s : MlneuralattentionTable) -> Double {
  if s.size == 0 { 0.0 } else { ml_neural_attention_table_sum(s) / s.size.to_double() }
}

pub fn ml_neural_attention_table_scale(s : MlneuralattentionTable, f : Double) -> MlneuralattentionTable {
  let result = ml_neural_attention_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_neural_attention_table_add(a : MlneuralattentionTable, b : MlneuralattentionTable) -> MlneuralattentionTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_neural_attention_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_neural_attention_table_copy(s : MlneuralattentionTable) -> MlneuralattentionTable {
  let result = ml_neural_attention_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_neural_attention_table_fill(s : MlneuralattentionTable, v : Double) -> MlneuralattentionTable {
  let result = ml_neural_attention_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_neural_attention_table_min(s : MlneuralattentionTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_neural_attention_table_max(s : MlneuralattentionTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_neural_attention_table_to_string(s : MlneuralattentionTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuralattentionGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_attention_graphn_make(size : Int) -> MlneuralattentionGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_attention_graphn_len(s : MlneuralattentionGraphN) -> Int { s.size }

pub fn ml_neural_attention_graphn_get(s : MlneuralattentionGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_attention_graphn_set(s : MlneuralattentionGraphN, i : Int, v : Double) -> MlneuralattentionGraphN {
  let result = ml_neural_attention_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_neural_attention_graphn_sum(s : MlneuralattentionGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_neural_attention_graphn_mean(s : MlneuralattentionGraphN) -> Double {
  if s.size == 0 { 0.0 } else { ml_neural_attention_graphn_sum(s) / s.size.to_double() }
}

pub fn ml_neural_attention_graphn_scale(s : MlneuralattentionGraphN, f : Double) -> MlneuralattentionGraphN {
  let result = ml_neural_attention_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_neural_attention_graphn_add(a : MlneuralattentionGraphN, b : MlneuralattentionGraphN) -> MlneuralattentionGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_neural_attention_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_neural_attention_graphn_copy(s : MlneuralattentionGraphN) -> MlneuralattentionGraphN {
  let result = ml_neural_attention_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_neural_attention_graphn_fill(s : MlneuralattentionGraphN, v : Double) -> MlneuralattentionGraphN {
  let result = ml_neural_attention_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_neural_attention_graphn_min(s : MlneuralattentionGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_neural_attention_graphn_max(s : MlneuralattentionGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_neural_attention_graphn_to_string(s : MlneuralattentionGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuralattentionNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_attention_node_make(size : Int) -> MlneuralattentionNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_attention_node_len(s : MlneuralattentionNode) -> Int { s.size }

pub fn ml_neural_attention_node_get(s : MlneuralattentionNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_attention_node_set(s : MlneuralattentionNode, i : Int, v : Double) -> MlneuralattentionNode {
  let result = ml_neural_attention_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_neural_attention_node_sum(s : MlneuralattentionNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_neural_attention_node_mean(s : MlneuralattentionNode) -> Double {
  if s.size == 0 { 0.0 } else { ml_neural_attention_node_sum(s) / s.size.to_double() }
}

pub fn ml_neural_attention_node_scale(s : MlneuralattentionNode, f : Double) -> MlneuralattentionNode {
  let result = ml_neural_attention_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_neural_attention_node_add(a : MlneuralattentionNode, b : MlneuralattentionNode) -> MlneuralattentionNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_neural_attention_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_neural_attention_node_copy(s : MlneuralattentionNode) -> MlneuralattentionNode {
  let result = ml_neural_attention_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_neural_attention_node_fill(s : MlneuralattentionNode, v : Double) -> MlneuralattentionNode {
  let result = ml_neural_attention_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_neural_attention_node_min(s : MlneuralattentionNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_neural_attention_node_max(s : MlneuralattentionNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_neural_attention_node_to_string(s : MlneuralattentionNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuralattentionEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_attention_edge_make(size : Int) -> MlneuralattentionEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_attention_edge_len(s : MlneuralattentionEdge) -> Int { s.size }

pub fn ml_neural_attention_edge_get(s : MlneuralattentionEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_attention_edge_set(s : MlneuralattentionEdge, i : Int, v : Double) -> MlneuralattentionEdge {
  let result = ml_neural_attention_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_neural_attention_edge_sum(s : MlneuralattentionEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_neural_attention_edge_mean(s : MlneuralattentionEdge) -> Double {
  if s.size == 0 { 0.0 } else { ml_neural_attention_edge_sum(s) / s.size.to_double() }
}

pub fn ml_neural_attention_edge_scale(s : MlneuralattentionEdge, f : Double) -> MlneuralattentionEdge {
  let result = ml_neural_attention_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_neural_attention_edge_add(a : MlneuralattentionEdge, b : MlneuralattentionEdge) -> MlneuralattentionEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_neural_attention_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_neural_attention_edge_copy(s : MlneuralattentionEdge) -> MlneuralattentionEdge {
  let result = ml_neural_attention_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_neural_attention_edge_fill(s : MlneuralattentionEdge, v : Double) -> MlneuralattentionEdge {
  let result = ml_neural_attention_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_neural_attention_edge_min(s : MlneuralattentionEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_neural_attention_edge_max(s : MlneuralattentionEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_neural_attention_edge_to_string(s : MlneuralattentionEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuralattentionPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_attention_path_make(size : Int) -> MlneuralattentionPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_attention_path_len(s : MlneuralattentionPath) -> Int { s.size }

pub fn ml_neural_attention_path_get(s : MlneuralattentionPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_attention_path_set(s : MlneuralattentionPath, i : Int, v : Double) -> MlneuralattentionPath {
  let result = ml_neural_attention_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_neural_attention_path_sum(s : MlneuralattentionPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_neural_attention_path_mean(s : MlneuralattentionPath) -> Double {
  if s.size == 0 { 0.0 } else { ml_neural_attention_path_sum(s) / s.size.to_double() }
}

pub fn ml_neural_attention_path_scale(s : MlneuralattentionPath, f : Double) -> MlneuralattentionPath {
  let result = ml_neural_attention_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_neural_attention_path_add(a : MlneuralattentionPath, b : MlneuralattentionPath) -> MlneuralattentionPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_neural_attention_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_neural_attention_path_copy(s : MlneuralattentionPath) -> MlneuralattentionPath {
  let result = ml_neural_attention_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_neural_attention_path_fill(s : MlneuralattentionPath, v : Double) -> MlneuralattentionPath {
  let result = ml_neural_attention_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_neural_attention_path_min(s : MlneuralattentionPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_neural_attention_path_max(s : MlneuralattentionPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_neural_attention_path_to_string(s : MlneuralattentionPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuralattentionCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_attention_cluster_make(size : Int) -> MlneuralattentionCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_attention_cluster_len(s : MlneuralattentionCluster) -> Int { s.size }

pub fn ml_neural_attention_cluster_get(s : MlneuralattentionCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_attention_cluster_set(s : MlneuralattentionCluster, i : Int, v : Double) -> MlneuralattentionCluster {
  let result = ml_neural_attention_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_neural_attention_cluster_sum(s : MlneuralattentionCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_neural_attention_cluster_mean(s : MlneuralattentionCluster) -> Double {
  if s.size == 0 { 0.0 } else { ml_neural_attention_cluster_sum(s) / s.size.to_double() }
}

pub fn ml_neural_attention_cluster_scale(s : MlneuralattentionCluster, f : Double) -> MlneuralattentionCluster {
  let result = ml_neural_attention_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_neural_attention_cluster_add(a : MlneuralattentionCluster, b : MlneuralattentionCluster) -> MlneuralattentionCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_neural_attention_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_neural_attention_cluster_copy(s : MlneuralattentionCluster) -> MlneuralattentionCluster {
  let result = ml_neural_attention_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_neural_attention_cluster_fill(s : MlneuralattentionCluster, v : Double) -> MlneuralattentionCluster {
  let result = ml_neural_attention_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_neural_attention_cluster_min(s : MlneuralattentionCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_neural_attention_cluster_max(s : MlneuralattentionCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_neural_attention_cluster_to_string(s : MlneuralattentionCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuralattentionModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_attention_model_make(size : Int) -> MlneuralattentionModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_attention_model_len(s : MlneuralattentionModel) -> Int { s.size }

pub fn ml_neural_attention_model_get(s : MlneuralattentionModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_attention_model_set(s : MlneuralattentionModel, i : Int, v : Double) -> MlneuralattentionModel {
  let result = ml_neural_attention_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_neural_attention_model_sum(s : MlneuralattentionModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_neural_attention_model_mean(s : MlneuralattentionModel) -> Double {
  if s.size == 0 { 0.0 } else { ml_neural_attention_model_sum(s) / s.size.to_double() }
}

pub fn ml_neural_attention_model_scale(s : MlneuralattentionModel, f : Double) -> MlneuralattentionModel {
  let result = ml_neural_attention_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_neural_attention_model_add(a : MlneuralattentionModel, b : MlneuralattentionModel) -> MlneuralattentionModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_neural_attention_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_neural_attention_model_copy(s : MlneuralattentionModel) -> MlneuralattentionModel {
  let result = ml_neural_attention_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_neural_attention_model_fill(s : MlneuralattentionModel, v : Double) -> MlneuralattentionModel {
  let result = ml_neural_attention_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_neural_attention_model_min(s : MlneuralattentionModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_neural_attention_model_max(s : MlneuralattentionModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_neural_attention_model_to_string(s : MlneuralattentionModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuralattentionLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_attention_layer_make(size : Int) -> MlneuralattentionLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_attention_layer_len(s : MlneuralattentionLayer) -> Int { s.size }

pub fn ml_neural_attention_layer_get(s : MlneuralattentionLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_attention_layer_set(s : MlneuralattentionLayer, i : Int, v : Double) -> MlneuralattentionLayer {
  let result = ml_neural_attention_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_neural_attention_layer_sum(s : MlneuralattentionLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_neural_attention_layer_mean(s : MlneuralattentionLayer) -> Double {
  if s.size == 0 { 0.0 } else { ml_neural_attention_layer_sum(s) / s.size.to_double() }
}

pub fn ml_neural_attention_layer_scale(s : MlneuralattentionLayer, f : Double) -> MlneuralattentionLayer {
  let result = ml_neural_attention_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_neural_attention_layer_add(a : MlneuralattentionLayer, b : MlneuralattentionLayer) -> MlneuralattentionLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_neural_attention_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_neural_attention_layer_copy(s : MlneuralattentionLayer) -> MlneuralattentionLayer {
  let result = ml_neural_attention_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_neural_attention_layer_fill(s : MlneuralattentionLayer, v : Double) -> MlneuralattentionLayer {
  let result = ml_neural_attention_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_neural_attention_layer_min(s : MlneuralattentionLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_neural_attention_layer_max(s : MlneuralattentionLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_neural_attention_layer_to_string(s : MlneuralattentionLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuralattentionBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_attention_buffer_make(size : Int) -> MlneuralattentionBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_attention_buffer_len(s : MlneuralattentionBuffer) -> Int { s.size }

pub fn ml_neural_attention_buffer_get(s : MlneuralattentionBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_attention_buffer_set(s : MlneuralattentionBuffer, i : Int, v : Double) -> MlneuralattentionBuffer {
  let result = ml_neural_attention_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_neural_attention_buffer_sum(s : MlneuralattentionBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_neural_attention_buffer_mean(s : MlneuralattentionBuffer) -> Double {
  if s.size == 0 { 0.0 } else { ml_neural_attention_buffer_sum(s) / s.size.to_double() }
}

pub fn ml_neural_attention_buffer_scale(s : MlneuralattentionBuffer, f : Double) -> MlneuralattentionBuffer {
  let result = ml_neural_attention_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_neural_attention_buffer_add(a : MlneuralattentionBuffer, b : MlneuralattentionBuffer) -> MlneuralattentionBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_neural_attention_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_neural_attention_buffer_copy(s : MlneuralattentionBuffer) -> MlneuralattentionBuffer {
  let result = ml_neural_attention_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_neural_attention_buffer_fill(s : MlneuralattentionBuffer, v : Double) -> MlneuralattentionBuffer {
  let result = ml_neural_attention_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_neural_attention_buffer_min(s : MlneuralattentionBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_neural_attention_buffer_max(s : MlneuralattentionBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_neural_attention_buffer_to_string(s : MlneuralattentionBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuralattentionCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_attention_cursor_make(size : Int) -> MlneuralattentionCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_attention_cursor_len(s : MlneuralattentionCursor) -> Int { s.size }

pub fn ml_neural_attention_cursor_get(s : MlneuralattentionCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_attention_cursor_set(s : MlneuralattentionCursor, i : Int, v : Double) -> MlneuralattentionCursor {
  let result = ml_neural_attention_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_neural_attention_cursor_sum(s : MlneuralattentionCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_neural_attention_cursor_mean(s : MlneuralattentionCursor) -> Double {
  if s.size == 0 { 0.0 } else { ml_neural_attention_cursor_sum(s) / s.size.to_double() }
}

pub fn ml_neural_attention_cursor_scale(s : MlneuralattentionCursor, f : Double) -> MlneuralattentionCursor {
  let result = ml_neural_attention_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_neural_attention_cursor_add(a : MlneuralattentionCursor, b : MlneuralattentionCursor) -> MlneuralattentionCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_neural_attention_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_neural_attention_cursor_copy(s : MlneuralattentionCursor) -> MlneuralattentionCursor {
  let result = ml_neural_attention_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_neural_attention_cursor_fill(s : MlneuralattentionCursor, v : Double) -> MlneuralattentionCursor {
  let result = ml_neural_attention_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_neural_attention_cursor_min(s : MlneuralattentionCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_neural_attention_cursor_max(s : MlneuralattentionCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_neural_attention_cursor_to_string(s : MlneuralattentionCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuralattentionView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_attention_view_make(size : Int) -> MlneuralattentionView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_attention_view_len(s : MlneuralattentionView) -> Int { s.size }

pub fn ml_neural_attention_view_get(s : MlneuralattentionView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_attention_view_set(s : MlneuralattentionView, i : Int, v : Double) -> MlneuralattentionView {
  let result = ml_neural_attention_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_neural_attention_view_sum(s : MlneuralattentionView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_neural_attention_view_mean(s : MlneuralattentionView) -> Double {
  if s.size == 0 { 0.0 } else { ml_neural_attention_view_sum(s) / s.size.to_double() }
}

pub fn ml_neural_attention_view_scale(s : MlneuralattentionView, f : Double) -> MlneuralattentionView {
  let result = ml_neural_attention_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_neural_attention_view_add(a : MlneuralattentionView, b : MlneuralattentionView) -> MlneuralattentionView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_neural_attention_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_neural_attention_view_copy(s : MlneuralattentionView) -> MlneuralattentionView {
  let result = ml_neural_attention_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_neural_attention_view_fill(s : MlneuralattentionView, v : Double) -> MlneuralattentionView {
  let result = ml_neural_attention_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_neural_attention_view_min(s : MlneuralattentionView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_neural_attention_view_max(s : MlneuralattentionView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_neural_attention_view_to_string(s : MlneuralattentionView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuralattentionRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_attention_range_make(size : Int) -> MlneuralattentionRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_attention_range_len(s : MlneuralattentionRange) -> Int { s.size }

pub fn ml_neural_attention_range_get(s : MlneuralattentionRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_attention_range_set(s : MlneuralattentionRange, i : Int, v : Double) -> MlneuralattentionRange {
  let result = ml_neural_attention_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_neural_attention_range_sum(s : MlneuralattentionRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_neural_attention_range_mean(s : MlneuralattentionRange) -> Double {
  if s.size == 0 { 0.0 } else { ml_neural_attention_range_sum(s) / s.size.to_double() }
}

pub fn ml_neural_attention_range_scale(s : MlneuralattentionRange, f : Double) -> MlneuralattentionRange {
  let result = ml_neural_attention_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_neural_attention_range_add(a : MlneuralattentionRange, b : MlneuralattentionRange) -> MlneuralattentionRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_neural_attention_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_neural_attention_range_copy(s : MlneuralattentionRange) -> MlneuralattentionRange {
  let result = ml_neural_attention_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_neural_attention_range_fill(s : MlneuralattentionRange, v : Double) -> MlneuralattentionRange {
  let result = ml_neural_attention_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_neural_attention_range_min(s : MlneuralattentionRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_neural_attention_range_max(s : MlneuralattentionRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_neural_attention_range_to_string(s : MlneuralattentionRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuralattentionSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_attention_slice_make(size : Int) -> MlneuralattentionSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_attention_slice_len(s : MlneuralattentionSlice) -> Int { s.size }

pub fn ml_neural_attention_slice_get(s : MlneuralattentionSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_attention_slice_set(s : MlneuralattentionSlice, i : Int, v : Double) -> MlneuralattentionSlice {
  let result = ml_neural_attention_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_neural_attention_slice_sum(s : MlneuralattentionSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_neural_attention_slice_mean(s : MlneuralattentionSlice) -> Double {
  if s.size == 0 { 0.0 } else { ml_neural_attention_slice_sum(s) / s.size.to_double() }
}

pub fn ml_neural_attention_slice_scale(s : MlneuralattentionSlice, f : Double) -> MlneuralattentionSlice {
  let result = ml_neural_attention_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_neural_attention_slice_add(a : MlneuralattentionSlice, b : MlneuralattentionSlice) -> MlneuralattentionSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_neural_attention_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_neural_attention_slice_copy(s : MlneuralattentionSlice) -> MlneuralattentionSlice {
  let result = ml_neural_attention_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_neural_attention_slice_fill(s : MlneuralattentionSlice, v : Double) -> MlneuralattentionSlice {
  let result = ml_neural_attention_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_neural_attention_slice_min(s : MlneuralattentionSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_neural_attention_slice_max(s : MlneuralattentionSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_neural_attention_slice_to_string(s : MlneuralattentionSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn ml_neural_attention_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_neural_attention_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_neural_attention_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_neural_attention_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_neural_attention_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_neural_attention_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_neural_attention_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_neural_attention_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_neural_attention_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_neural_attention_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_neural_attention_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_neural_attention_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_neural_attention_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_neural_attention_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_neural_attention_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_neural_attention_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_neural_attention_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_neural_attention_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_neural_attention_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_neural_attention_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_neural_attention_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_neural_attention_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_neural_attention_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_neural_attention_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_neural_attention_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

