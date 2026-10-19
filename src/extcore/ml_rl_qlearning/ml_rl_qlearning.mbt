///===
/// extcore/ml_rl_qlearning

pub(all) struct MlrlqlearningPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_rl_qlearning_make_point(x : Double, y : Double) -> MlrlqlearningPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_rl_qlearning_make_point3(x : Double, y : Double, z : Double) -> MlrlqlearningPoint {
  { x, y, z, label: 0 }
}

pub fn ml_rl_qlearning_point_x(pt : MlrlqlearningPoint) -> Double { pt.x }

pub fn ml_rl_qlearning_point_y(pt : MlrlqlearningPoint) -> Double { pt.y }

pub fn ml_rl_qlearning_point_z(pt : MlrlqlearningPoint) -> Double { pt.z }

pub fn ml_rl_qlearning_point_label(pt : MlrlqlearningPoint) -> Int { pt.label }

pub fn ml_rl_qlearning_point_dist(a : MlrlqlearningPoint, b : MlrlqlearningPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  ml_rl_qlearning_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ml_rl_qlearning_point_add(a : MlrlqlearningPoint, b : MlrlqlearningPoint) -> MlrlqlearningPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn ml_rl_qlearning_point_sub(a : MlrlqlearningPoint, b : MlrlqlearningPoint) -> MlrlqlearningPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn ml_rl_qlearning_point_scale(pt : MlrlqlearningPoint, s : Double) -> MlrlqlearningPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn ml_rl_qlearning_point_dot(a : MlrlqlearningPoint, b : MlrlqlearningPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn ml_rl_qlearning_point_cross(a : MlrlqlearningPoint, b : MlrlqlearningPoint) -> MlrlqlearningPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn ml_rl_qlearning_point_norm(pt : MlrlqlearningPoint) -> Double {
  ml_rl_qlearning_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn ml_rl_qlearning_point_normalize(pt : MlrlqlearningPoint) -> MlrlqlearningPoint {
  let n = ml_rl_qlearning_point_norm(pt)
  if n < 0.0000001 { pt } else { ml_rl_qlearning_point_scale(pt, 1.0 / n) }
}

pub fn ml_rl_qlearning_point_negate(pt : MlrlqlearningPoint) -> MlrlqlearningPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn ml_rl_qlearning_point_mid(a : MlrlqlearningPoint, b : MlrlqlearningPoint) -> MlrlqlearningPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn ml_rl_qlearning_point_lerp(a : MlrlqlearningPoint, b : MlrlqlearningPoint, t : Double) -> MlrlqlearningPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn ml_rl_qlearning_point_to_string(pt : MlrlqlearningPoint) -> String {
  "(" + ml_rl_qlearning_dbl(pt.x) + ", " + ml_rl_qlearning_dbl(pt.y) + ", " + ml_rl_qlearning_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct MlrlqlearningSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_rl_qlearning_make_series(vals : Array[Double], name : String) -> MlrlqlearningSeries {
  { vals, name, meta: 0 }
}

pub fn ml_rl_qlearning_series_len(s : MlrlqlearningSeries) -> Int { s.vals.length() }

pub fn ml_rl_qlearning_series_sum(s : MlrlqlearningSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn ml_rl_qlearning_series_mean(s : MlrlqlearningSeries) -> Double {
  let n = ml_rl_qlearning_series_len(s)
  if n == 0 { 0.0 } else { ml_rl_qlearning_series_sum(s) / n.to_double() }
}

pub fn ml_rl_qlearning_series_min(s : MlrlqlearningSeries) -> Double {
  let n = ml_rl_qlearning_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn ml_rl_qlearning_series_max(s : MlrlqlearningSeries) -> Double {
  let n = ml_rl_qlearning_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn ml_rl_qlearning_series_range(s : MlrlqlearningSeries) -> Double {
  ml_rl_qlearning_series_max(s) - ml_rl_qlearning_series_min(s)
}

pub fn ml_rl_qlearning_series_var(s : MlrlqlearningSeries) -> Double {
  let n = ml_rl_qlearning_series_len(s)
  if n == 0 { 0.0 } else {
    let m = ml_rl_qlearning_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn ml_rl_qlearning_series_std(s : MlrlqlearningSeries) -> Double { ml_rl_qlearning_sqrt(ml_rl_qlearning_series_var(s)) }

pub fn ml_rl_qlearning_series_median(s : MlrlqlearningSeries) -> Double {
  let n = ml_rl_qlearning_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = ml_rl_qlearning_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn ml_rl_qlearning_series_scale(s : MlrlqlearningSeries, f : Double) -> MlrlqlearningSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = ml_rl_qlearning_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn ml_rl_qlearning_series_add(a : MlrlqlearningSeries, b : MlrlqlearningSeries) -> MlrlqlearningSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = ml_rl_qlearning_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn ml_rl_qlearning_series_sub(a : MlrlqlearningSeries, b : MlrlqlearningSeries) -> MlrlqlearningSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = ml_rl_qlearning_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn ml_rl_qlearning_series_normalize(s : MlrlqlearningSeries) -> MlrlqlearningSeries {
  let mn = ml_rl_qlearning_series_min(s)
  let mx = ml_rl_qlearning_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = ml_rl_qlearning_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn ml_rl_qlearning_series_cumsum(s : MlrlqlearningSeries) -> MlrlqlearningSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = ml_rl_qlearning_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn ml_rl_qlearning_series_to_string(s : MlrlqlearningSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + ml_rl_qlearning_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlrlqlearningMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_rl_qlearning_make_matrix(rows : Int, cols : Int, val : Double) -> MlrlqlearningMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_rl_qlearning_matrix_identity(n : Int) -> MlrlqlearningMatrix {
  let m = ml_rl_qlearning_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ml_rl_qlearning_matrix_get(m : MlrlqlearningMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn ml_rl_qlearning_matrix_transpose(m : MlrlqlearningMatrix) -> MlrlqlearningMatrix {
  let result = ml_rl_qlearning_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn ml_rl_qlearning_matrix_add(a : MlrlqlearningMatrix, b : MlrlqlearningMatrix) -> MlrlqlearningMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = ml_rl_qlearning_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn ml_rl_qlearning_matrix_scale(m : MlrlqlearningMatrix, s : Double) -> MlrlqlearningMatrix {
  let result = ml_rl_qlearning_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn ml_rl_qlearning_matrix_multiply(a : MlrlqlearningMatrix, b : MlrlqlearningMatrix) -> MlrlqlearningMatrix {
  if a.cols != b.rows { return ml_rl_qlearning_make_matrix(a.rows, b.cols, 0.0) }
  let result = ml_rl_qlearning_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ml_rl_qlearning_matrix_trace(m : MlrlqlearningMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn ml_rl_qlearning_matrix_det(m : MlrlqlearningMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ml_rl_qlearning_matrix_norm(m : MlrlqlearningMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  ml_rl_qlearning_sqrt(sum)
}

pub fn ml_rl_qlearning_matrix_to_string(m : MlrlqlearningMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + ml_rl_qlearning_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct MlrlqlearningVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_rl_qlearning_make_vector(comps : Array[Double]) -> MlrlqlearningVector {
  { comps, dim: comps.length() }
}

pub fn ml_rl_qlearning_vector_zero(dim : Int) -> MlrlqlearningVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ml_rl_qlearning_vector_add(a : MlrlqlearningVector, b : MlrlqlearningVector) -> MlrlqlearningVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = ml_rl_qlearning_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ml_rl_qlearning_vector_sub(a : MlrlqlearningVector, b : MlrlqlearningVector) -> MlrlqlearningVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = ml_rl_qlearning_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ml_rl_qlearning_vector_scale(v : MlrlqlearningVector, s : Double) -> MlrlqlearningVector {
  let mut result = []
  for i in 0..<v.dim { result = ml_rl_qlearning_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn ml_rl_qlearning_vector_dot(a : MlrlqlearningVector, b : MlrlqlearningVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn ml_rl_qlearning_vector_norm(v : MlrlqlearningVector) -> Double { ml_rl_qlearning_sqrt(ml_rl_qlearning_vector_dot(v, v)) }

pub fn ml_rl_qlearning_vector_normalize(v : MlrlqlearningVector) -> MlrlqlearningVector {
  let n = ml_rl_qlearning_vector_norm(v)
  if n < 0.0000001 { v } else { ml_rl_qlearning_vector_scale(v, 1.0 / n) }
}

pub fn ml_rl_qlearning_vector_dist(a : MlrlqlearningVector, b : MlrlqlearningVector) -> Double {
  ml_rl_qlearning_vector_norm(ml_rl_qlearning_vector_sub(a, b))
}

pub fn ml_rl_qlearning_vector_to_string(v : MlrlqlearningVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + ml_rl_qlearning_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ml_rl_qlearning_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn ml_rl_qlearning_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = ml_rl_qlearning_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn ml_rl_qlearning_std(data : Array[Double]) -> Double { ml_rl_qlearning_sqrt(ml_rl_qlearning_var(data)) }

pub fn ml_rl_qlearning_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = ml_rl_qlearning_mean(a); let mb = ml_rl_qlearning_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn ml_rl_qlearning_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = ml_rl_qlearning_std(a); let sb = ml_rl_qlearning_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { ml_rl_qlearning_cov(a, b) / (sa * sb) }
}

pub fn ml_rl_qlearning_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = ml_rl_qlearning_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn ml_rl_qlearning_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn ml_rl_qlearning_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn ml_rl_qlearning_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  ml_rl_qlearning_sqrt(ml_rl_qlearning_mse(pred, labels))
}

pub fn ml_rl_qlearning_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + ml_rl_qlearning_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn ml_rl_qlearning_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = ml_rl_qlearning_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn ml_rl_qlearning_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn ml_rl_qlearning_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn ml_rl_qlearning_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = ml_rl_qlearning_precision(pred, labels, pos); let r = ml_rl_qlearning_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn ml_rl_qlearning_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn ml_rl_qlearning_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = ml_rl_qlearning_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn ml_rl_qlearning_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn ml_rl_qlearning_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn ml_rl_qlearning_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = ml_rl_qlearning_gcd(a, b)
    (a / g) * b
  }
}

pub fn ml_rl_qlearning_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn ml_rl_qlearning_fibonacci(n : Int) -> Int {
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

pub fn ml_rl_qlearning_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = ml_rl_qlearning_min(data); let mx = ml_rl_qlearning_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn ml_rl_qlearning_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = ml_rl_qlearning_mean(data); let sd = ml_rl_qlearning_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn ml_rl_qlearning_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn ml_rl_qlearning_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn ml_rl_qlearning_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn ml_rl_qlearning_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn ml_rl_qlearning_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn ml_rl_qlearning_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn ml_rl_qlearning_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn ml_rl_qlearning_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn ml_rl_qlearning_dbl(x : Double) -> String {
  let i = if x >= 0.0 { ml_rl_qlearning_int(x) } else { -ml_rl_qlearning_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { ml_rl_qlearning_int(f * 1000000.0) } else { ml_rl_qlearning_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn ml_rl_qlearning_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn ml_rl_qlearning_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct MlrlqlearningFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_qlearning_frame_make(size : Int) -> MlrlqlearningFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_qlearning_frame_len(s : MlrlqlearningFrame) -> Int { s.size }

pub fn ml_rl_qlearning_frame_get(s : MlrlqlearningFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_qlearning_frame_set(s : MlrlqlearningFrame, i : Int, v : Double) -> MlrlqlearningFrame {
  let result = ml_rl_qlearning_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_rl_qlearning_frame_sum(s : MlrlqlearningFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_rl_qlearning_frame_mean(s : MlrlqlearningFrame) -> Double {
  if s.size == 0 { 0.0 } else { ml_rl_qlearning_frame_sum(s) / s.size.to_double() }
}

pub fn ml_rl_qlearning_frame_scale(s : MlrlqlearningFrame, f : Double) -> MlrlqlearningFrame {
  let result = ml_rl_qlearning_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_rl_qlearning_frame_add(a : MlrlqlearningFrame, b : MlrlqlearningFrame) -> MlrlqlearningFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_rl_qlearning_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_rl_qlearning_frame_copy(s : MlrlqlearningFrame) -> MlrlqlearningFrame {
  let result = ml_rl_qlearning_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_rl_qlearning_frame_fill(s : MlrlqlearningFrame, v : Double) -> MlrlqlearningFrame {
  let result = ml_rl_qlearning_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_rl_qlearning_frame_min(s : MlrlqlearningFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_rl_qlearning_frame_max(s : MlrlqlearningFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_rl_qlearning_frame_to_string(s : MlrlqlearningFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlqlearningTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_qlearning_table_make(size : Int) -> MlrlqlearningTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_qlearning_table_len(s : MlrlqlearningTable) -> Int { s.size }

pub fn ml_rl_qlearning_table_get(s : MlrlqlearningTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_qlearning_table_set(s : MlrlqlearningTable, i : Int, v : Double) -> MlrlqlearningTable {
  let result = ml_rl_qlearning_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_rl_qlearning_table_sum(s : MlrlqlearningTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_rl_qlearning_table_mean(s : MlrlqlearningTable) -> Double {
  if s.size == 0 { 0.0 } else { ml_rl_qlearning_table_sum(s) / s.size.to_double() }
}

pub fn ml_rl_qlearning_table_scale(s : MlrlqlearningTable, f : Double) -> MlrlqlearningTable {
  let result = ml_rl_qlearning_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_rl_qlearning_table_add(a : MlrlqlearningTable, b : MlrlqlearningTable) -> MlrlqlearningTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_rl_qlearning_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_rl_qlearning_table_copy(s : MlrlqlearningTable) -> MlrlqlearningTable {
  let result = ml_rl_qlearning_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_rl_qlearning_table_fill(s : MlrlqlearningTable, v : Double) -> MlrlqlearningTable {
  let result = ml_rl_qlearning_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_rl_qlearning_table_min(s : MlrlqlearningTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_rl_qlearning_table_max(s : MlrlqlearningTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_rl_qlearning_table_to_string(s : MlrlqlearningTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlqlearningGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_qlearning_graphn_make(size : Int) -> MlrlqlearningGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_qlearning_graphn_len(s : MlrlqlearningGraphN) -> Int { s.size }

pub fn ml_rl_qlearning_graphn_get(s : MlrlqlearningGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_qlearning_graphn_set(s : MlrlqlearningGraphN, i : Int, v : Double) -> MlrlqlearningGraphN {
  let result = ml_rl_qlearning_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_rl_qlearning_graphn_sum(s : MlrlqlearningGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_rl_qlearning_graphn_mean(s : MlrlqlearningGraphN) -> Double {
  if s.size == 0 { 0.0 } else { ml_rl_qlearning_graphn_sum(s) / s.size.to_double() }
}

pub fn ml_rl_qlearning_graphn_scale(s : MlrlqlearningGraphN, f : Double) -> MlrlqlearningGraphN {
  let result = ml_rl_qlearning_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_rl_qlearning_graphn_add(a : MlrlqlearningGraphN, b : MlrlqlearningGraphN) -> MlrlqlearningGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_rl_qlearning_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_rl_qlearning_graphn_copy(s : MlrlqlearningGraphN) -> MlrlqlearningGraphN {
  let result = ml_rl_qlearning_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_rl_qlearning_graphn_fill(s : MlrlqlearningGraphN, v : Double) -> MlrlqlearningGraphN {
  let result = ml_rl_qlearning_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_rl_qlearning_graphn_min(s : MlrlqlearningGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_rl_qlearning_graphn_max(s : MlrlqlearningGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_rl_qlearning_graphn_to_string(s : MlrlqlearningGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlqlearningNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_qlearning_node_make(size : Int) -> MlrlqlearningNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_qlearning_node_len(s : MlrlqlearningNode) -> Int { s.size }

pub fn ml_rl_qlearning_node_get(s : MlrlqlearningNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_qlearning_node_set(s : MlrlqlearningNode, i : Int, v : Double) -> MlrlqlearningNode {
  let result = ml_rl_qlearning_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_rl_qlearning_node_sum(s : MlrlqlearningNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_rl_qlearning_node_mean(s : MlrlqlearningNode) -> Double {
  if s.size == 0 { 0.0 } else { ml_rl_qlearning_node_sum(s) / s.size.to_double() }
}

pub fn ml_rl_qlearning_node_scale(s : MlrlqlearningNode, f : Double) -> MlrlqlearningNode {
  let result = ml_rl_qlearning_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_rl_qlearning_node_add(a : MlrlqlearningNode, b : MlrlqlearningNode) -> MlrlqlearningNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_rl_qlearning_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_rl_qlearning_node_copy(s : MlrlqlearningNode) -> MlrlqlearningNode {
  let result = ml_rl_qlearning_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_rl_qlearning_node_fill(s : MlrlqlearningNode, v : Double) -> MlrlqlearningNode {
  let result = ml_rl_qlearning_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_rl_qlearning_node_min(s : MlrlqlearningNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_rl_qlearning_node_max(s : MlrlqlearningNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_rl_qlearning_node_to_string(s : MlrlqlearningNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlqlearningEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_qlearning_edge_make(size : Int) -> MlrlqlearningEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_qlearning_edge_len(s : MlrlqlearningEdge) -> Int { s.size }

pub fn ml_rl_qlearning_edge_get(s : MlrlqlearningEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_qlearning_edge_set(s : MlrlqlearningEdge, i : Int, v : Double) -> MlrlqlearningEdge {
  let result = ml_rl_qlearning_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_rl_qlearning_edge_sum(s : MlrlqlearningEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_rl_qlearning_edge_mean(s : MlrlqlearningEdge) -> Double {
  if s.size == 0 { 0.0 } else { ml_rl_qlearning_edge_sum(s) / s.size.to_double() }
}

pub fn ml_rl_qlearning_edge_scale(s : MlrlqlearningEdge, f : Double) -> MlrlqlearningEdge {
  let result = ml_rl_qlearning_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_rl_qlearning_edge_add(a : MlrlqlearningEdge, b : MlrlqlearningEdge) -> MlrlqlearningEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_rl_qlearning_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_rl_qlearning_edge_copy(s : MlrlqlearningEdge) -> MlrlqlearningEdge {
  let result = ml_rl_qlearning_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_rl_qlearning_edge_fill(s : MlrlqlearningEdge, v : Double) -> MlrlqlearningEdge {
  let result = ml_rl_qlearning_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_rl_qlearning_edge_min(s : MlrlqlearningEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_rl_qlearning_edge_max(s : MlrlqlearningEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_rl_qlearning_edge_to_string(s : MlrlqlearningEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlqlearningPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_qlearning_path_make(size : Int) -> MlrlqlearningPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_qlearning_path_len(s : MlrlqlearningPath) -> Int { s.size }

pub fn ml_rl_qlearning_path_get(s : MlrlqlearningPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_qlearning_path_set(s : MlrlqlearningPath, i : Int, v : Double) -> MlrlqlearningPath {
  let result = ml_rl_qlearning_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_rl_qlearning_path_sum(s : MlrlqlearningPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_rl_qlearning_path_mean(s : MlrlqlearningPath) -> Double {
  if s.size == 0 { 0.0 } else { ml_rl_qlearning_path_sum(s) / s.size.to_double() }
}

pub fn ml_rl_qlearning_path_scale(s : MlrlqlearningPath, f : Double) -> MlrlqlearningPath {
  let result = ml_rl_qlearning_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_rl_qlearning_path_add(a : MlrlqlearningPath, b : MlrlqlearningPath) -> MlrlqlearningPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_rl_qlearning_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_rl_qlearning_path_copy(s : MlrlqlearningPath) -> MlrlqlearningPath {
  let result = ml_rl_qlearning_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_rl_qlearning_path_fill(s : MlrlqlearningPath, v : Double) -> MlrlqlearningPath {
  let result = ml_rl_qlearning_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_rl_qlearning_path_min(s : MlrlqlearningPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_rl_qlearning_path_max(s : MlrlqlearningPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_rl_qlearning_path_to_string(s : MlrlqlearningPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlqlearningCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_qlearning_cluster_make(size : Int) -> MlrlqlearningCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_qlearning_cluster_len(s : MlrlqlearningCluster) -> Int { s.size }

pub fn ml_rl_qlearning_cluster_get(s : MlrlqlearningCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_qlearning_cluster_set(s : MlrlqlearningCluster, i : Int, v : Double) -> MlrlqlearningCluster {
  let result = ml_rl_qlearning_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_rl_qlearning_cluster_sum(s : MlrlqlearningCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_rl_qlearning_cluster_mean(s : MlrlqlearningCluster) -> Double {
  if s.size == 0 { 0.0 } else { ml_rl_qlearning_cluster_sum(s) / s.size.to_double() }
}

pub fn ml_rl_qlearning_cluster_scale(s : MlrlqlearningCluster, f : Double) -> MlrlqlearningCluster {
  let result = ml_rl_qlearning_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_rl_qlearning_cluster_add(a : MlrlqlearningCluster, b : MlrlqlearningCluster) -> MlrlqlearningCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_rl_qlearning_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_rl_qlearning_cluster_copy(s : MlrlqlearningCluster) -> MlrlqlearningCluster {
  let result = ml_rl_qlearning_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_rl_qlearning_cluster_fill(s : MlrlqlearningCluster, v : Double) -> MlrlqlearningCluster {
  let result = ml_rl_qlearning_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_rl_qlearning_cluster_min(s : MlrlqlearningCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_rl_qlearning_cluster_max(s : MlrlqlearningCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_rl_qlearning_cluster_to_string(s : MlrlqlearningCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlqlearningModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_qlearning_model_make(size : Int) -> MlrlqlearningModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_qlearning_model_len(s : MlrlqlearningModel) -> Int { s.size }

pub fn ml_rl_qlearning_model_get(s : MlrlqlearningModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_qlearning_model_set(s : MlrlqlearningModel, i : Int, v : Double) -> MlrlqlearningModel {
  let result = ml_rl_qlearning_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_rl_qlearning_model_sum(s : MlrlqlearningModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_rl_qlearning_model_mean(s : MlrlqlearningModel) -> Double {
  if s.size == 0 { 0.0 } else { ml_rl_qlearning_model_sum(s) / s.size.to_double() }
}

pub fn ml_rl_qlearning_model_scale(s : MlrlqlearningModel, f : Double) -> MlrlqlearningModel {
  let result = ml_rl_qlearning_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_rl_qlearning_model_add(a : MlrlqlearningModel, b : MlrlqlearningModel) -> MlrlqlearningModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_rl_qlearning_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_rl_qlearning_model_copy(s : MlrlqlearningModel) -> MlrlqlearningModel {
  let result = ml_rl_qlearning_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_rl_qlearning_model_fill(s : MlrlqlearningModel, v : Double) -> MlrlqlearningModel {
  let result = ml_rl_qlearning_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_rl_qlearning_model_min(s : MlrlqlearningModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_rl_qlearning_model_max(s : MlrlqlearningModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_rl_qlearning_model_to_string(s : MlrlqlearningModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlqlearningLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_qlearning_layer_make(size : Int) -> MlrlqlearningLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_qlearning_layer_len(s : MlrlqlearningLayer) -> Int { s.size }

pub fn ml_rl_qlearning_layer_get(s : MlrlqlearningLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_qlearning_layer_set(s : MlrlqlearningLayer, i : Int, v : Double) -> MlrlqlearningLayer {
  let result = ml_rl_qlearning_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_rl_qlearning_layer_sum(s : MlrlqlearningLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_rl_qlearning_layer_mean(s : MlrlqlearningLayer) -> Double {
  if s.size == 0 { 0.0 } else { ml_rl_qlearning_layer_sum(s) / s.size.to_double() }
}

pub fn ml_rl_qlearning_layer_scale(s : MlrlqlearningLayer, f : Double) -> MlrlqlearningLayer {
  let result = ml_rl_qlearning_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_rl_qlearning_layer_add(a : MlrlqlearningLayer, b : MlrlqlearningLayer) -> MlrlqlearningLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_rl_qlearning_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_rl_qlearning_layer_copy(s : MlrlqlearningLayer) -> MlrlqlearningLayer {
  let result = ml_rl_qlearning_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_rl_qlearning_layer_fill(s : MlrlqlearningLayer, v : Double) -> MlrlqlearningLayer {
  let result = ml_rl_qlearning_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_rl_qlearning_layer_min(s : MlrlqlearningLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_rl_qlearning_layer_max(s : MlrlqlearningLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_rl_qlearning_layer_to_string(s : MlrlqlearningLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlqlearningBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_qlearning_buffer_make(size : Int) -> MlrlqlearningBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_qlearning_buffer_len(s : MlrlqlearningBuffer) -> Int { s.size }

pub fn ml_rl_qlearning_buffer_get(s : MlrlqlearningBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_qlearning_buffer_set(s : MlrlqlearningBuffer, i : Int, v : Double) -> MlrlqlearningBuffer {
  let result = ml_rl_qlearning_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_rl_qlearning_buffer_sum(s : MlrlqlearningBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_rl_qlearning_buffer_mean(s : MlrlqlearningBuffer) -> Double {
  if s.size == 0 { 0.0 } else { ml_rl_qlearning_buffer_sum(s) / s.size.to_double() }
}

pub fn ml_rl_qlearning_buffer_scale(s : MlrlqlearningBuffer, f : Double) -> MlrlqlearningBuffer {
  let result = ml_rl_qlearning_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_rl_qlearning_buffer_add(a : MlrlqlearningBuffer, b : MlrlqlearningBuffer) -> MlrlqlearningBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_rl_qlearning_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_rl_qlearning_buffer_copy(s : MlrlqlearningBuffer) -> MlrlqlearningBuffer {
  let result = ml_rl_qlearning_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_rl_qlearning_buffer_fill(s : MlrlqlearningBuffer, v : Double) -> MlrlqlearningBuffer {
  let result = ml_rl_qlearning_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_rl_qlearning_buffer_min(s : MlrlqlearningBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_rl_qlearning_buffer_max(s : MlrlqlearningBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_rl_qlearning_buffer_to_string(s : MlrlqlearningBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlqlearningCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_qlearning_cursor_make(size : Int) -> MlrlqlearningCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_qlearning_cursor_len(s : MlrlqlearningCursor) -> Int { s.size }

pub fn ml_rl_qlearning_cursor_get(s : MlrlqlearningCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_qlearning_cursor_set(s : MlrlqlearningCursor, i : Int, v : Double) -> MlrlqlearningCursor {
  let result = ml_rl_qlearning_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_rl_qlearning_cursor_sum(s : MlrlqlearningCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_rl_qlearning_cursor_mean(s : MlrlqlearningCursor) -> Double {
  if s.size == 0 { 0.0 } else { ml_rl_qlearning_cursor_sum(s) / s.size.to_double() }
}

pub fn ml_rl_qlearning_cursor_scale(s : MlrlqlearningCursor, f : Double) -> MlrlqlearningCursor {
  let result = ml_rl_qlearning_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_rl_qlearning_cursor_add(a : MlrlqlearningCursor, b : MlrlqlearningCursor) -> MlrlqlearningCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_rl_qlearning_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_rl_qlearning_cursor_copy(s : MlrlqlearningCursor) -> MlrlqlearningCursor {
  let result = ml_rl_qlearning_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_rl_qlearning_cursor_fill(s : MlrlqlearningCursor, v : Double) -> MlrlqlearningCursor {
  let result = ml_rl_qlearning_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_rl_qlearning_cursor_min(s : MlrlqlearningCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_rl_qlearning_cursor_max(s : MlrlqlearningCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_rl_qlearning_cursor_to_string(s : MlrlqlearningCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlqlearningView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_qlearning_view_make(size : Int) -> MlrlqlearningView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_qlearning_view_len(s : MlrlqlearningView) -> Int { s.size }

pub fn ml_rl_qlearning_view_get(s : MlrlqlearningView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_qlearning_view_set(s : MlrlqlearningView, i : Int, v : Double) -> MlrlqlearningView {
  let result = ml_rl_qlearning_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_rl_qlearning_view_sum(s : MlrlqlearningView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_rl_qlearning_view_mean(s : MlrlqlearningView) -> Double {
  if s.size == 0 { 0.0 } else { ml_rl_qlearning_view_sum(s) / s.size.to_double() }
}

pub fn ml_rl_qlearning_view_scale(s : MlrlqlearningView, f : Double) -> MlrlqlearningView {
  let result = ml_rl_qlearning_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_rl_qlearning_view_add(a : MlrlqlearningView, b : MlrlqlearningView) -> MlrlqlearningView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_rl_qlearning_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_rl_qlearning_view_copy(s : MlrlqlearningView) -> MlrlqlearningView {
  let result = ml_rl_qlearning_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_rl_qlearning_view_fill(s : MlrlqlearningView, v : Double) -> MlrlqlearningView {
  let result = ml_rl_qlearning_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_rl_qlearning_view_min(s : MlrlqlearningView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_rl_qlearning_view_max(s : MlrlqlearningView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_rl_qlearning_view_to_string(s : MlrlqlearningView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlqlearningRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_qlearning_range_make(size : Int) -> MlrlqlearningRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_qlearning_range_len(s : MlrlqlearningRange) -> Int { s.size }

pub fn ml_rl_qlearning_range_get(s : MlrlqlearningRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_qlearning_range_set(s : MlrlqlearningRange, i : Int, v : Double) -> MlrlqlearningRange {
  let result = ml_rl_qlearning_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_rl_qlearning_range_sum(s : MlrlqlearningRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_rl_qlearning_range_mean(s : MlrlqlearningRange) -> Double {
  if s.size == 0 { 0.0 } else { ml_rl_qlearning_range_sum(s) / s.size.to_double() }
}

pub fn ml_rl_qlearning_range_scale(s : MlrlqlearningRange, f : Double) -> MlrlqlearningRange {
  let result = ml_rl_qlearning_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_rl_qlearning_range_add(a : MlrlqlearningRange, b : MlrlqlearningRange) -> MlrlqlearningRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_rl_qlearning_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_rl_qlearning_range_copy(s : MlrlqlearningRange) -> MlrlqlearningRange {
  let result = ml_rl_qlearning_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_rl_qlearning_range_fill(s : MlrlqlearningRange, v : Double) -> MlrlqlearningRange {
  let result = ml_rl_qlearning_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_rl_qlearning_range_min(s : MlrlqlearningRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_rl_qlearning_range_max(s : MlrlqlearningRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_rl_qlearning_range_to_string(s : MlrlqlearningRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlqlearningSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_qlearning_slice_make(size : Int) -> MlrlqlearningSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_qlearning_slice_len(s : MlrlqlearningSlice) -> Int { s.size }

pub fn ml_rl_qlearning_slice_get(s : MlrlqlearningSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_qlearning_slice_set(s : MlrlqlearningSlice, i : Int, v : Double) -> MlrlqlearningSlice {
  let result = ml_rl_qlearning_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_rl_qlearning_slice_sum(s : MlrlqlearningSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_rl_qlearning_slice_mean(s : MlrlqlearningSlice) -> Double {
  if s.size == 0 { 0.0 } else { ml_rl_qlearning_slice_sum(s) / s.size.to_double() }
}

pub fn ml_rl_qlearning_slice_scale(s : MlrlqlearningSlice, f : Double) -> MlrlqlearningSlice {
  let result = ml_rl_qlearning_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_rl_qlearning_slice_add(a : MlrlqlearningSlice, b : MlrlqlearningSlice) -> MlrlqlearningSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_rl_qlearning_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_rl_qlearning_slice_copy(s : MlrlqlearningSlice) -> MlrlqlearningSlice {
  let result = ml_rl_qlearning_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_rl_qlearning_slice_fill(s : MlrlqlearningSlice, v : Double) -> MlrlqlearningSlice {
  let result = ml_rl_qlearning_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_rl_qlearning_slice_min(s : MlrlqlearningSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_rl_qlearning_slice_max(s : MlrlqlearningSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_rl_qlearning_slice_to_string(s : MlrlqlearningSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn ml_rl_qlearning_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_rl_qlearning_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_rl_qlearning_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_rl_qlearning_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_rl_qlearning_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_rl_qlearning_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_rl_qlearning_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_rl_qlearning_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_rl_qlearning_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_rl_qlearning_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_rl_qlearning_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_rl_qlearning_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_rl_qlearning_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_rl_qlearning_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_rl_qlearning_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_rl_qlearning_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_rl_qlearning_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_rl_qlearning_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_rl_qlearning_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_rl_qlearning_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_rl_qlearning_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_rl_qlearning_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_rl_qlearning_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_rl_qlearning_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_rl_qlearning_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

