///===
/// extcore/ml_regress_ridge

pub(all) struct MlregressridgePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_regress_ridge_make_point(x : Double, y : Double) -> MlregressridgePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_regress_ridge_make_point3(x : Double, y : Double, z : Double) -> MlregressridgePoint {
  { x, y, z, label: 0 }
}

pub fn ml_regress_ridge_point_x(pt : MlregressridgePoint) -> Double { pt.x }

pub fn ml_regress_ridge_point_y(pt : MlregressridgePoint) -> Double { pt.y }

pub fn ml_regress_ridge_point_z(pt : MlregressridgePoint) -> Double { pt.z }

pub fn ml_regress_ridge_point_label(pt : MlregressridgePoint) -> Int { pt.label }

pub fn ml_regress_ridge_point_dist(a : MlregressridgePoint, b : MlregressridgePoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  ml_regress_ridge_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ml_regress_ridge_point_add(a : MlregressridgePoint, b : MlregressridgePoint) -> MlregressridgePoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn ml_regress_ridge_point_sub(a : MlregressridgePoint, b : MlregressridgePoint) -> MlregressridgePoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn ml_regress_ridge_point_scale(pt : MlregressridgePoint, s : Double) -> MlregressridgePoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn ml_regress_ridge_point_dot(a : MlregressridgePoint, b : MlregressridgePoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn ml_regress_ridge_point_cross(a : MlregressridgePoint, b : MlregressridgePoint) -> MlregressridgePoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn ml_regress_ridge_point_norm(pt : MlregressridgePoint) -> Double {
  ml_regress_ridge_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn ml_regress_ridge_point_normalize(pt : MlregressridgePoint) -> MlregressridgePoint {
  let n = ml_regress_ridge_point_norm(pt)
  if n < 0.0000001 { pt } else { ml_regress_ridge_point_scale(pt, 1.0 / n) }
}

pub fn ml_regress_ridge_point_negate(pt : MlregressridgePoint) -> MlregressridgePoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn ml_regress_ridge_point_mid(a : MlregressridgePoint, b : MlregressridgePoint) -> MlregressridgePoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn ml_regress_ridge_point_lerp(a : MlregressridgePoint, b : MlregressridgePoint, t : Double) -> MlregressridgePoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn ml_regress_ridge_point_to_string(pt : MlregressridgePoint) -> String {
  "(" + ml_regress_ridge_dbl(pt.x) + ", " + ml_regress_ridge_dbl(pt.y) + ", " + ml_regress_ridge_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct MlregressridgeSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_regress_ridge_make_series(vals : Array[Double], name : String) -> MlregressridgeSeries {
  { vals, name, meta: 0 }
}

pub fn ml_regress_ridge_series_len(s : MlregressridgeSeries) -> Int { s.vals.length() }

pub fn ml_regress_ridge_series_sum(s : MlregressridgeSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn ml_regress_ridge_series_mean(s : MlregressridgeSeries) -> Double {
  let n = ml_regress_ridge_series_len(s)
  if n == 0 { 0.0 } else { ml_regress_ridge_series_sum(s) / n.to_double() }
}

pub fn ml_regress_ridge_series_min(s : MlregressridgeSeries) -> Double {
  let n = ml_regress_ridge_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn ml_regress_ridge_series_max(s : MlregressridgeSeries) -> Double {
  let n = ml_regress_ridge_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn ml_regress_ridge_series_range(s : MlregressridgeSeries) -> Double {
  ml_regress_ridge_series_max(s) - ml_regress_ridge_series_min(s)
}

pub fn ml_regress_ridge_series_var(s : MlregressridgeSeries) -> Double {
  let n = ml_regress_ridge_series_len(s)
  if n == 0 { 0.0 } else {
    let m = ml_regress_ridge_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn ml_regress_ridge_series_std(s : MlregressridgeSeries) -> Double { ml_regress_ridge_sqrt(ml_regress_ridge_series_var(s)) }

pub fn ml_regress_ridge_series_median(s : MlregressridgeSeries) -> Double {
  let n = ml_regress_ridge_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = ml_regress_ridge_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn ml_regress_ridge_series_scale(s : MlregressridgeSeries, f : Double) -> MlregressridgeSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = ml_regress_ridge_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn ml_regress_ridge_series_add(a : MlregressridgeSeries, b : MlregressridgeSeries) -> MlregressridgeSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = ml_regress_ridge_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn ml_regress_ridge_series_sub(a : MlregressridgeSeries, b : MlregressridgeSeries) -> MlregressridgeSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = ml_regress_ridge_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn ml_regress_ridge_series_normalize(s : MlregressridgeSeries) -> MlregressridgeSeries {
  let mn = ml_regress_ridge_series_min(s)
  let mx = ml_regress_ridge_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = ml_regress_ridge_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn ml_regress_ridge_series_cumsum(s : MlregressridgeSeries) -> MlregressridgeSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = ml_regress_ridge_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn ml_regress_ridge_series_to_string(s : MlregressridgeSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + ml_regress_ridge_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlregressridgeMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_regress_ridge_make_matrix(rows : Int, cols : Int, val : Double) -> MlregressridgeMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_regress_ridge_matrix_identity(n : Int) -> MlregressridgeMatrix {
  let m = ml_regress_ridge_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ml_regress_ridge_matrix_get(m : MlregressridgeMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn ml_regress_ridge_matrix_transpose(m : MlregressridgeMatrix) -> MlregressridgeMatrix {
  let result = ml_regress_ridge_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn ml_regress_ridge_matrix_add(a : MlregressridgeMatrix, b : MlregressridgeMatrix) -> MlregressridgeMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = ml_regress_ridge_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn ml_regress_ridge_matrix_scale(m : MlregressridgeMatrix, s : Double) -> MlregressridgeMatrix {
  let result = ml_regress_ridge_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn ml_regress_ridge_matrix_multiply(a : MlregressridgeMatrix, b : MlregressridgeMatrix) -> MlregressridgeMatrix {
  if a.cols != b.rows { return ml_regress_ridge_make_matrix(a.rows, b.cols, 0.0) }
  let result = ml_regress_ridge_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ml_regress_ridge_matrix_trace(m : MlregressridgeMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn ml_regress_ridge_matrix_det(m : MlregressridgeMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ml_regress_ridge_matrix_norm(m : MlregressridgeMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  ml_regress_ridge_sqrt(sum)
}

pub fn ml_regress_ridge_matrix_to_string(m : MlregressridgeMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + ml_regress_ridge_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct MlregressridgeVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_regress_ridge_make_vector(comps : Array[Double]) -> MlregressridgeVector {
  { comps, dim: comps.length() }
}

pub fn ml_regress_ridge_vector_zero(dim : Int) -> MlregressridgeVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ml_regress_ridge_vector_add(a : MlregressridgeVector, b : MlregressridgeVector) -> MlregressridgeVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = ml_regress_ridge_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ml_regress_ridge_vector_sub(a : MlregressridgeVector, b : MlregressridgeVector) -> MlregressridgeVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = ml_regress_ridge_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ml_regress_ridge_vector_scale(v : MlregressridgeVector, s : Double) -> MlregressridgeVector {
  let mut result = []
  for i in 0..<v.dim { result = ml_regress_ridge_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn ml_regress_ridge_vector_dot(a : MlregressridgeVector, b : MlregressridgeVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn ml_regress_ridge_vector_norm(v : MlregressridgeVector) -> Double { ml_regress_ridge_sqrt(ml_regress_ridge_vector_dot(v, v)) }

pub fn ml_regress_ridge_vector_normalize(v : MlregressridgeVector) -> MlregressridgeVector {
  let n = ml_regress_ridge_vector_norm(v)
  if n < 0.0000001 { v } else { ml_regress_ridge_vector_scale(v, 1.0 / n) }
}

pub fn ml_regress_ridge_vector_dist(a : MlregressridgeVector, b : MlregressridgeVector) -> Double {
  ml_regress_ridge_vector_norm(ml_regress_ridge_vector_sub(a, b))
}

pub fn ml_regress_ridge_vector_to_string(v : MlregressridgeVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + ml_regress_ridge_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ml_regress_ridge_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn ml_regress_ridge_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = ml_regress_ridge_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn ml_regress_ridge_std(data : Array[Double]) -> Double { ml_regress_ridge_sqrt(ml_regress_ridge_var(data)) }

pub fn ml_regress_ridge_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = ml_regress_ridge_mean(a); let mb = ml_regress_ridge_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn ml_regress_ridge_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = ml_regress_ridge_std(a); let sb = ml_regress_ridge_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { ml_regress_ridge_cov(a, b) / (sa * sb) }
}

pub fn ml_regress_ridge_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = ml_regress_ridge_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn ml_regress_ridge_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn ml_regress_ridge_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn ml_regress_ridge_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  ml_regress_ridge_sqrt(ml_regress_ridge_mse(pred, labels))
}

pub fn ml_regress_ridge_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + ml_regress_ridge_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn ml_regress_ridge_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = ml_regress_ridge_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn ml_regress_ridge_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn ml_regress_ridge_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn ml_regress_ridge_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = ml_regress_ridge_precision(pred, labels, pos); let r = ml_regress_ridge_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn ml_regress_ridge_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn ml_regress_ridge_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = ml_regress_ridge_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn ml_regress_ridge_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn ml_regress_ridge_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn ml_regress_ridge_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = ml_regress_ridge_gcd(a, b)
    (a / g) * b
  }
}

pub fn ml_regress_ridge_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn ml_regress_ridge_fibonacci(n : Int) -> Int {
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

pub fn ml_regress_ridge_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = ml_regress_ridge_min(data); let mx = ml_regress_ridge_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn ml_regress_ridge_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = ml_regress_ridge_mean(data); let sd = ml_regress_ridge_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn ml_regress_ridge_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn ml_regress_ridge_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn ml_regress_ridge_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn ml_regress_ridge_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn ml_regress_ridge_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn ml_regress_ridge_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn ml_regress_ridge_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn ml_regress_ridge_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn ml_regress_ridge_dbl(x : Double) -> String {
  let i = if x >= 0.0 { ml_regress_ridge_int(x) } else { -ml_regress_ridge_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { ml_regress_ridge_int(f * 1000000.0) } else { ml_regress_ridge_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn ml_regress_ridge_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn ml_regress_ridge_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct MlregressridgeFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_ridge_frame_make(size : Int) -> MlregressridgeFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_ridge_frame_len(s : MlregressridgeFrame) -> Int { s.size }

pub fn ml_regress_ridge_frame_get(s : MlregressridgeFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_ridge_frame_set(s : MlregressridgeFrame, i : Int, v : Double) -> MlregressridgeFrame {
  let result = ml_regress_ridge_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_regress_ridge_frame_sum(s : MlregressridgeFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_regress_ridge_frame_mean(s : MlregressridgeFrame) -> Double {
  if s.size == 0 { 0.0 } else { ml_regress_ridge_frame_sum(s) / s.size.to_double() }
}

pub fn ml_regress_ridge_frame_scale(s : MlregressridgeFrame, f : Double) -> MlregressridgeFrame {
  let result = ml_regress_ridge_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_regress_ridge_frame_add(a : MlregressridgeFrame, b : MlregressridgeFrame) -> MlregressridgeFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_regress_ridge_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_regress_ridge_frame_copy(s : MlregressridgeFrame) -> MlregressridgeFrame {
  let result = ml_regress_ridge_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_regress_ridge_frame_fill(s : MlregressridgeFrame, v : Double) -> MlregressridgeFrame {
  let result = ml_regress_ridge_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_regress_ridge_frame_min(s : MlregressridgeFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_regress_ridge_frame_max(s : MlregressridgeFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_regress_ridge_frame_to_string(s : MlregressridgeFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregressridgeTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_ridge_table_make(size : Int) -> MlregressridgeTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_ridge_table_len(s : MlregressridgeTable) -> Int { s.size }

pub fn ml_regress_ridge_table_get(s : MlregressridgeTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_ridge_table_set(s : MlregressridgeTable, i : Int, v : Double) -> MlregressridgeTable {
  let result = ml_regress_ridge_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_regress_ridge_table_sum(s : MlregressridgeTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_regress_ridge_table_mean(s : MlregressridgeTable) -> Double {
  if s.size == 0 { 0.0 } else { ml_regress_ridge_table_sum(s) / s.size.to_double() }
}

pub fn ml_regress_ridge_table_scale(s : MlregressridgeTable, f : Double) -> MlregressridgeTable {
  let result = ml_regress_ridge_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_regress_ridge_table_add(a : MlregressridgeTable, b : MlregressridgeTable) -> MlregressridgeTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_regress_ridge_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_regress_ridge_table_copy(s : MlregressridgeTable) -> MlregressridgeTable {
  let result = ml_regress_ridge_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_regress_ridge_table_fill(s : MlregressridgeTable, v : Double) -> MlregressridgeTable {
  let result = ml_regress_ridge_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_regress_ridge_table_min(s : MlregressridgeTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_regress_ridge_table_max(s : MlregressridgeTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_regress_ridge_table_to_string(s : MlregressridgeTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregressridgeGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_ridge_graphn_make(size : Int) -> MlregressridgeGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_ridge_graphn_len(s : MlregressridgeGraphN) -> Int { s.size }

pub fn ml_regress_ridge_graphn_get(s : MlregressridgeGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_ridge_graphn_set(s : MlregressridgeGraphN, i : Int, v : Double) -> MlregressridgeGraphN {
  let result = ml_regress_ridge_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_regress_ridge_graphn_sum(s : MlregressridgeGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_regress_ridge_graphn_mean(s : MlregressridgeGraphN) -> Double {
  if s.size == 0 { 0.0 } else { ml_regress_ridge_graphn_sum(s) / s.size.to_double() }
}

pub fn ml_regress_ridge_graphn_scale(s : MlregressridgeGraphN, f : Double) -> MlregressridgeGraphN {
  let result = ml_regress_ridge_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_regress_ridge_graphn_add(a : MlregressridgeGraphN, b : MlregressridgeGraphN) -> MlregressridgeGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_regress_ridge_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_regress_ridge_graphn_copy(s : MlregressridgeGraphN) -> MlregressridgeGraphN {
  let result = ml_regress_ridge_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_regress_ridge_graphn_fill(s : MlregressridgeGraphN, v : Double) -> MlregressridgeGraphN {
  let result = ml_regress_ridge_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_regress_ridge_graphn_min(s : MlregressridgeGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_regress_ridge_graphn_max(s : MlregressridgeGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_regress_ridge_graphn_to_string(s : MlregressridgeGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregressridgeNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_ridge_node_make(size : Int) -> MlregressridgeNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_ridge_node_len(s : MlregressridgeNode) -> Int { s.size }

pub fn ml_regress_ridge_node_get(s : MlregressridgeNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_ridge_node_set(s : MlregressridgeNode, i : Int, v : Double) -> MlregressridgeNode {
  let result = ml_regress_ridge_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_regress_ridge_node_sum(s : MlregressridgeNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_regress_ridge_node_mean(s : MlregressridgeNode) -> Double {
  if s.size == 0 { 0.0 } else { ml_regress_ridge_node_sum(s) / s.size.to_double() }
}

pub fn ml_regress_ridge_node_scale(s : MlregressridgeNode, f : Double) -> MlregressridgeNode {
  let result = ml_regress_ridge_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_regress_ridge_node_add(a : MlregressridgeNode, b : MlregressridgeNode) -> MlregressridgeNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_regress_ridge_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_regress_ridge_node_copy(s : MlregressridgeNode) -> MlregressridgeNode {
  let result = ml_regress_ridge_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_regress_ridge_node_fill(s : MlregressridgeNode, v : Double) -> MlregressridgeNode {
  let result = ml_regress_ridge_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_regress_ridge_node_min(s : MlregressridgeNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_regress_ridge_node_max(s : MlregressridgeNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_regress_ridge_node_to_string(s : MlregressridgeNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregressridgeEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_ridge_edge_make(size : Int) -> MlregressridgeEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_ridge_edge_len(s : MlregressridgeEdge) -> Int { s.size }

pub fn ml_regress_ridge_edge_get(s : MlregressridgeEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_ridge_edge_set(s : MlregressridgeEdge, i : Int, v : Double) -> MlregressridgeEdge {
  let result = ml_regress_ridge_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_regress_ridge_edge_sum(s : MlregressridgeEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_regress_ridge_edge_mean(s : MlregressridgeEdge) -> Double {
  if s.size == 0 { 0.0 } else { ml_regress_ridge_edge_sum(s) / s.size.to_double() }
}

pub fn ml_regress_ridge_edge_scale(s : MlregressridgeEdge, f : Double) -> MlregressridgeEdge {
  let result = ml_regress_ridge_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_regress_ridge_edge_add(a : MlregressridgeEdge, b : MlregressridgeEdge) -> MlregressridgeEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_regress_ridge_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_regress_ridge_edge_copy(s : MlregressridgeEdge) -> MlregressridgeEdge {
  let result = ml_regress_ridge_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_regress_ridge_edge_fill(s : MlregressridgeEdge, v : Double) -> MlregressridgeEdge {
  let result = ml_regress_ridge_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_regress_ridge_edge_min(s : MlregressridgeEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_regress_ridge_edge_max(s : MlregressridgeEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_regress_ridge_edge_to_string(s : MlregressridgeEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregressridgePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_ridge_path_make(size : Int) -> MlregressridgePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_ridge_path_len(s : MlregressridgePath) -> Int { s.size }

pub fn ml_regress_ridge_path_get(s : MlregressridgePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_ridge_path_set(s : MlregressridgePath, i : Int, v : Double) -> MlregressridgePath {
  let result = ml_regress_ridge_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_regress_ridge_path_sum(s : MlregressridgePath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_regress_ridge_path_mean(s : MlregressridgePath) -> Double {
  if s.size == 0 { 0.0 } else { ml_regress_ridge_path_sum(s) / s.size.to_double() }
}

pub fn ml_regress_ridge_path_scale(s : MlregressridgePath, f : Double) -> MlregressridgePath {
  let result = ml_regress_ridge_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_regress_ridge_path_add(a : MlregressridgePath, b : MlregressridgePath) -> MlregressridgePath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_regress_ridge_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_regress_ridge_path_copy(s : MlregressridgePath) -> MlregressridgePath {
  let result = ml_regress_ridge_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_regress_ridge_path_fill(s : MlregressridgePath, v : Double) -> MlregressridgePath {
  let result = ml_regress_ridge_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_regress_ridge_path_min(s : MlregressridgePath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_regress_ridge_path_max(s : MlregressridgePath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_regress_ridge_path_to_string(s : MlregressridgePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregressridgeCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_ridge_cluster_make(size : Int) -> MlregressridgeCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_ridge_cluster_len(s : MlregressridgeCluster) -> Int { s.size }

pub fn ml_regress_ridge_cluster_get(s : MlregressridgeCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_ridge_cluster_set(s : MlregressridgeCluster, i : Int, v : Double) -> MlregressridgeCluster {
  let result = ml_regress_ridge_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_regress_ridge_cluster_sum(s : MlregressridgeCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_regress_ridge_cluster_mean(s : MlregressridgeCluster) -> Double {
  if s.size == 0 { 0.0 } else { ml_regress_ridge_cluster_sum(s) / s.size.to_double() }
}

pub fn ml_regress_ridge_cluster_scale(s : MlregressridgeCluster, f : Double) -> MlregressridgeCluster {
  let result = ml_regress_ridge_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_regress_ridge_cluster_add(a : MlregressridgeCluster, b : MlregressridgeCluster) -> MlregressridgeCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_regress_ridge_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_regress_ridge_cluster_copy(s : MlregressridgeCluster) -> MlregressridgeCluster {
  let result = ml_regress_ridge_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_regress_ridge_cluster_fill(s : MlregressridgeCluster, v : Double) -> MlregressridgeCluster {
  let result = ml_regress_ridge_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_regress_ridge_cluster_min(s : MlregressridgeCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_regress_ridge_cluster_max(s : MlregressridgeCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_regress_ridge_cluster_to_string(s : MlregressridgeCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregressridgeModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_ridge_model_make(size : Int) -> MlregressridgeModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_ridge_model_len(s : MlregressridgeModel) -> Int { s.size }

pub fn ml_regress_ridge_model_get(s : MlregressridgeModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_ridge_model_set(s : MlregressridgeModel, i : Int, v : Double) -> MlregressridgeModel {
  let result = ml_regress_ridge_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_regress_ridge_model_sum(s : MlregressridgeModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_regress_ridge_model_mean(s : MlregressridgeModel) -> Double {
  if s.size == 0 { 0.0 } else { ml_regress_ridge_model_sum(s) / s.size.to_double() }
}

pub fn ml_regress_ridge_model_scale(s : MlregressridgeModel, f : Double) -> MlregressridgeModel {
  let result = ml_regress_ridge_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_regress_ridge_model_add(a : MlregressridgeModel, b : MlregressridgeModel) -> MlregressridgeModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_regress_ridge_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_regress_ridge_model_copy(s : MlregressridgeModel) -> MlregressridgeModel {
  let result = ml_regress_ridge_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_regress_ridge_model_fill(s : MlregressridgeModel, v : Double) -> MlregressridgeModel {
  let result = ml_regress_ridge_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_regress_ridge_model_min(s : MlregressridgeModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_regress_ridge_model_max(s : MlregressridgeModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_regress_ridge_model_to_string(s : MlregressridgeModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregressridgeLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_ridge_layer_make(size : Int) -> MlregressridgeLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_ridge_layer_len(s : MlregressridgeLayer) -> Int { s.size }

pub fn ml_regress_ridge_layer_get(s : MlregressridgeLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_ridge_layer_set(s : MlregressridgeLayer, i : Int, v : Double) -> MlregressridgeLayer {
  let result = ml_regress_ridge_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_regress_ridge_layer_sum(s : MlregressridgeLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_regress_ridge_layer_mean(s : MlregressridgeLayer) -> Double {
  if s.size == 0 { 0.0 } else { ml_regress_ridge_layer_sum(s) / s.size.to_double() }
}

pub fn ml_regress_ridge_layer_scale(s : MlregressridgeLayer, f : Double) -> MlregressridgeLayer {
  let result = ml_regress_ridge_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_regress_ridge_layer_add(a : MlregressridgeLayer, b : MlregressridgeLayer) -> MlregressridgeLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_regress_ridge_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_regress_ridge_layer_copy(s : MlregressridgeLayer) -> MlregressridgeLayer {
  let result = ml_regress_ridge_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_regress_ridge_layer_fill(s : MlregressridgeLayer, v : Double) -> MlregressridgeLayer {
  let result = ml_regress_ridge_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_regress_ridge_layer_min(s : MlregressridgeLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_regress_ridge_layer_max(s : MlregressridgeLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_regress_ridge_layer_to_string(s : MlregressridgeLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregressridgeBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_ridge_buffer_make(size : Int) -> MlregressridgeBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_ridge_buffer_len(s : MlregressridgeBuffer) -> Int { s.size }

pub fn ml_regress_ridge_buffer_get(s : MlregressridgeBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_ridge_buffer_set(s : MlregressridgeBuffer, i : Int, v : Double) -> MlregressridgeBuffer {
  let result = ml_regress_ridge_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_regress_ridge_buffer_sum(s : MlregressridgeBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_regress_ridge_buffer_mean(s : MlregressridgeBuffer) -> Double {
  if s.size == 0 { 0.0 } else { ml_regress_ridge_buffer_sum(s) / s.size.to_double() }
}

pub fn ml_regress_ridge_buffer_scale(s : MlregressridgeBuffer, f : Double) -> MlregressridgeBuffer {
  let result = ml_regress_ridge_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_regress_ridge_buffer_add(a : MlregressridgeBuffer, b : MlregressridgeBuffer) -> MlregressridgeBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_regress_ridge_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_regress_ridge_buffer_copy(s : MlregressridgeBuffer) -> MlregressridgeBuffer {
  let result = ml_regress_ridge_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_regress_ridge_buffer_fill(s : MlregressridgeBuffer, v : Double) -> MlregressridgeBuffer {
  let result = ml_regress_ridge_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_regress_ridge_buffer_min(s : MlregressridgeBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_regress_ridge_buffer_max(s : MlregressridgeBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_regress_ridge_buffer_to_string(s : MlregressridgeBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregressridgeCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_ridge_cursor_make(size : Int) -> MlregressridgeCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_ridge_cursor_len(s : MlregressridgeCursor) -> Int { s.size }

pub fn ml_regress_ridge_cursor_get(s : MlregressridgeCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_ridge_cursor_set(s : MlregressridgeCursor, i : Int, v : Double) -> MlregressridgeCursor {
  let result = ml_regress_ridge_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_regress_ridge_cursor_sum(s : MlregressridgeCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_regress_ridge_cursor_mean(s : MlregressridgeCursor) -> Double {
  if s.size == 0 { 0.0 } else { ml_regress_ridge_cursor_sum(s) / s.size.to_double() }
}

pub fn ml_regress_ridge_cursor_scale(s : MlregressridgeCursor, f : Double) -> MlregressridgeCursor {
  let result = ml_regress_ridge_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_regress_ridge_cursor_add(a : MlregressridgeCursor, b : MlregressridgeCursor) -> MlregressridgeCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_regress_ridge_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_regress_ridge_cursor_copy(s : MlregressridgeCursor) -> MlregressridgeCursor {
  let result = ml_regress_ridge_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_regress_ridge_cursor_fill(s : MlregressridgeCursor, v : Double) -> MlregressridgeCursor {
  let result = ml_regress_ridge_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_regress_ridge_cursor_min(s : MlregressridgeCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_regress_ridge_cursor_max(s : MlregressridgeCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_regress_ridge_cursor_to_string(s : MlregressridgeCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregressridgeView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_ridge_view_make(size : Int) -> MlregressridgeView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_ridge_view_len(s : MlregressridgeView) -> Int { s.size }

pub fn ml_regress_ridge_view_get(s : MlregressridgeView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_ridge_view_set(s : MlregressridgeView, i : Int, v : Double) -> MlregressridgeView {
  let result = ml_regress_ridge_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_regress_ridge_view_sum(s : MlregressridgeView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_regress_ridge_view_mean(s : MlregressridgeView) -> Double {
  if s.size == 0 { 0.0 } else { ml_regress_ridge_view_sum(s) / s.size.to_double() }
}

pub fn ml_regress_ridge_view_scale(s : MlregressridgeView, f : Double) -> MlregressridgeView {
  let result = ml_regress_ridge_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_regress_ridge_view_add(a : MlregressridgeView, b : MlregressridgeView) -> MlregressridgeView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_regress_ridge_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_regress_ridge_view_copy(s : MlregressridgeView) -> MlregressridgeView {
  let result = ml_regress_ridge_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_regress_ridge_view_fill(s : MlregressridgeView, v : Double) -> MlregressridgeView {
  let result = ml_regress_ridge_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_regress_ridge_view_min(s : MlregressridgeView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_regress_ridge_view_max(s : MlregressridgeView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_regress_ridge_view_to_string(s : MlregressridgeView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregressridgeRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_ridge_range_make(size : Int) -> MlregressridgeRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_ridge_range_len(s : MlregressridgeRange) -> Int { s.size }

pub fn ml_regress_ridge_range_get(s : MlregressridgeRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_ridge_range_set(s : MlregressridgeRange, i : Int, v : Double) -> MlregressridgeRange {
  let result = ml_regress_ridge_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_regress_ridge_range_sum(s : MlregressridgeRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_regress_ridge_range_mean(s : MlregressridgeRange) -> Double {
  if s.size == 0 { 0.0 } else { ml_regress_ridge_range_sum(s) / s.size.to_double() }
}

pub fn ml_regress_ridge_range_scale(s : MlregressridgeRange, f : Double) -> MlregressridgeRange {
  let result = ml_regress_ridge_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_regress_ridge_range_add(a : MlregressridgeRange, b : MlregressridgeRange) -> MlregressridgeRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_regress_ridge_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_regress_ridge_range_copy(s : MlregressridgeRange) -> MlregressridgeRange {
  let result = ml_regress_ridge_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_regress_ridge_range_fill(s : MlregressridgeRange, v : Double) -> MlregressridgeRange {
  let result = ml_regress_ridge_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_regress_ridge_range_min(s : MlregressridgeRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_regress_ridge_range_max(s : MlregressridgeRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_regress_ridge_range_to_string(s : MlregressridgeRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregressridgeSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_ridge_slice_make(size : Int) -> MlregressridgeSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_ridge_slice_len(s : MlregressridgeSlice) -> Int { s.size }

pub fn ml_regress_ridge_slice_get(s : MlregressridgeSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_ridge_slice_set(s : MlregressridgeSlice, i : Int, v : Double) -> MlregressridgeSlice {
  let result = ml_regress_ridge_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_regress_ridge_slice_sum(s : MlregressridgeSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_regress_ridge_slice_mean(s : MlregressridgeSlice) -> Double {
  if s.size == 0 { 0.0 } else { ml_regress_ridge_slice_sum(s) / s.size.to_double() }
}

pub fn ml_regress_ridge_slice_scale(s : MlregressridgeSlice, f : Double) -> MlregressridgeSlice {
  let result = ml_regress_ridge_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_regress_ridge_slice_add(a : MlregressridgeSlice, b : MlregressridgeSlice) -> MlregressridgeSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_regress_ridge_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_regress_ridge_slice_copy(s : MlregressridgeSlice) -> MlregressridgeSlice {
  let result = ml_regress_ridge_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_regress_ridge_slice_fill(s : MlregressridgeSlice, v : Double) -> MlregressridgeSlice {
  let result = ml_regress_ridge_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_regress_ridge_slice_min(s : MlregressridgeSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_regress_ridge_slice_max(s : MlregressridgeSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_regress_ridge_slice_to_string(s : MlregressridgeSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn ml_regress_ridge_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_regress_ridge_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_regress_ridge_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_regress_ridge_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_regress_ridge_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_regress_ridge_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_regress_ridge_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_regress_ridge_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_regress_ridge_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_regress_ridge_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_regress_ridge_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_regress_ridge_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_regress_ridge_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_regress_ridge_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_regress_ridge_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_regress_ridge_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_regress_ridge_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_regress_ridge_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_regress_ridge_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_regress_ridge_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_regress_ridge_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_regress_ridge_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_regress_ridge_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_regress_ridge_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_regress_ridge_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

