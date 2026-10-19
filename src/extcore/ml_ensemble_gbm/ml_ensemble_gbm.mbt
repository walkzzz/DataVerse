///===
/// extcore/ml_ensemble_gbm

pub(all) struct MlensemblegbmPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_ensemble_gbm_make_point(x : Double, y : Double) -> MlensemblegbmPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_ensemble_gbm_make_point3(x : Double, y : Double, z : Double) -> MlensemblegbmPoint {
  { x, y, z, label: 0 }
}

pub fn ml_ensemble_gbm_point_x(pt : MlensemblegbmPoint) -> Double { pt.x }

pub fn ml_ensemble_gbm_point_y(pt : MlensemblegbmPoint) -> Double { pt.y }

pub fn ml_ensemble_gbm_point_z(pt : MlensemblegbmPoint) -> Double { pt.z }

pub fn ml_ensemble_gbm_point_label(pt : MlensemblegbmPoint) -> Int { pt.label }

pub fn ml_ensemble_gbm_point_dist(a : MlensemblegbmPoint, b : MlensemblegbmPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  ml_ensemble_gbm_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ml_ensemble_gbm_point_add(a : MlensemblegbmPoint, b : MlensemblegbmPoint) -> MlensemblegbmPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn ml_ensemble_gbm_point_sub(a : MlensemblegbmPoint, b : MlensemblegbmPoint) -> MlensemblegbmPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn ml_ensemble_gbm_point_scale(pt : MlensemblegbmPoint, s : Double) -> MlensemblegbmPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn ml_ensemble_gbm_point_dot(a : MlensemblegbmPoint, b : MlensemblegbmPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn ml_ensemble_gbm_point_cross(a : MlensemblegbmPoint, b : MlensemblegbmPoint) -> MlensemblegbmPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn ml_ensemble_gbm_point_norm(pt : MlensemblegbmPoint) -> Double {
  ml_ensemble_gbm_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn ml_ensemble_gbm_point_normalize(pt : MlensemblegbmPoint) -> MlensemblegbmPoint {
  let n = ml_ensemble_gbm_point_norm(pt)
  if n < 0.0000001 { pt } else { ml_ensemble_gbm_point_scale(pt, 1.0 / n) }
}

pub fn ml_ensemble_gbm_point_negate(pt : MlensemblegbmPoint) -> MlensemblegbmPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn ml_ensemble_gbm_point_mid(a : MlensemblegbmPoint, b : MlensemblegbmPoint) -> MlensemblegbmPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn ml_ensemble_gbm_point_lerp(a : MlensemblegbmPoint, b : MlensemblegbmPoint, t : Double) -> MlensemblegbmPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn ml_ensemble_gbm_point_to_string(pt : MlensemblegbmPoint) -> String {
  "(" + ml_ensemble_gbm_dbl(pt.x) + ", " + ml_ensemble_gbm_dbl(pt.y) + ", " + ml_ensemble_gbm_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct MlensemblegbmSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_ensemble_gbm_make_series(vals : Array[Double], name : String) -> MlensemblegbmSeries {
  { vals, name, meta: 0 }
}

pub fn ml_ensemble_gbm_series_len(s : MlensemblegbmSeries) -> Int { s.vals.length() }

pub fn ml_ensemble_gbm_series_sum(s : MlensemblegbmSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn ml_ensemble_gbm_series_mean(s : MlensemblegbmSeries) -> Double {
  let n = ml_ensemble_gbm_series_len(s)
  if n == 0 { 0.0 } else { ml_ensemble_gbm_series_sum(s) / n.to_double() }
}

pub fn ml_ensemble_gbm_series_min(s : MlensemblegbmSeries) -> Double {
  let n = ml_ensemble_gbm_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn ml_ensemble_gbm_series_max(s : MlensemblegbmSeries) -> Double {
  let n = ml_ensemble_gbm_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn ml_ensemble_gbm_series_range(s : MlensemblegbmSeries) -> Double {
  ml_ensemble_gbm_series_max(s) - ml_ensemble_gbm_series_min(s)
}

pub fn ml_ensemble_gbm_series_var(s : MlensemblegbmSeries) -> Double {
  let n = ml_ensemble_gbm_series_len(s)
  if n == 0 { 0.0 } else {
    let m = ml_ensemble_gbm_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn ml_ensemble_gbm_series_std(s : MlensemblegbmSeries) -> Double { ml_ensemble_gbm_sqrt(ml_ensemble_gbm_series_var(s)) }

pub fn ml_ensemble_gbm_series_median(s : MlensemblegbmSeries) -> Double {
  let n = ml_ensemble_gbm_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = ml_ensemble_gbm_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn ml_ensemble_gbm_series_scale(s : MlensemblegbmSeries, f : Double) -> MlensemblegbmSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = ml_ensemble_gbm_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn ml_ensemble_gbm_series_add(a : MlensemblegbmSeries, b : MlensemblegbmSeries) -> MlensemblegbmSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = ml_ensemble_gbm_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn ml_ensemble_gbm_series_sub(a : MlensemblegbmSeries, b : MlensemblegbmSeries) -> MlensemblegbmSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = ml_ensemble_gbm_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn ml_ensemble_gbm_series_normalize(s : MlensemblegbmSeries) -> MlensemblegbmSeries {
  let mn = ml_ensemble_gbm_series_min(s)
  let mx = ml_ensemble_gbm_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = ml_ensemble_gbm_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn ml_ensemble_gbm_series_cumsum(s : MlensemblegbmSeries) -> MlensemblegbmSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = ml_ensemble_gbm_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn ml_ensemble_gbm_series_to_string(s : MlensemblegbmSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + ml_ensemble_gbm_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlensemblegbmMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_ensemble_gbm_make_matrix(rows : Int, cols : Int, val : Double) -> MlensemblegbmMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_ensemble_gbm_matrix_identity(n : Int) -> MlensemblegbmMatrix {
  let m = ml_ensemble_gbm_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ml_ensemble_gbm_matrix_get(m : MlensemblegbmMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn ml_ensemble_gbm_matrix_transpose(m : MlensemblegbmMatrix) -> MlensemblegbmMatrix {
  let result = ml_ensemble_gbm_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn ml_ensemble_gbm_matrix_add(a : MlensemblegbmMatrix, b : MlensemblegbmMatrix) -> MlensemblegbmMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = ml_ensemble_gbm_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn ml_ensemble_gbm_matrix_scale(m : MlensemblegbmMatrix, s : Double) -> MlensemblegbmMatrix {
  let result = ml_ensemble_gbm_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn ml_ensemble_gbm_matrix_multiply(a : MlensemblegbmMatrix, b : MlensemblegbmMatrix) -> MlensemblegbmMatrix {
  if a.cols != b.rows { return ml_ensemble_gbm_make_matrix(a.rows, b.cols, 0.0) }
  let result = ml_ensemble_gbm_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ml_ensemble_gbm_matrix_trace(m : MlensemblegbmMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn ml_ensemble_gbm_matrix_det(m : MlensemblegbmMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ml_ensemble_gbm_matrix_norm(m : MlensemblegbmMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  ml_ensemble_gbm_sqrt(sum)
}

pub fn ml_ensemble_gbm_matrix_to_string(m : MlensemblegbmMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + ml_ensemble_gbm_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct MlensemblegbmVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_ensemble_gbm_make_vector(comps : Array[Double]) -> MlensemblegbmVector {
  { comps, dim: comps.length() }
}

pub fn ml_ensemble_gbm_vector_zero(dim : Int) -> MlensemblegbmVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ml_ensemble_gbm_vector_add(a : MlensemblegbmVector, b : MlensemblegbmVector) -> MlensemblegbmVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = ml_ensemble_gbm_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ml_ensemble_gbm_vector_sub(a : MlensemblegbmVector, b : MlensemblegbmVector) -> MlensemblegbmVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = ml_ensemble_gbm_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ml_ensemble_gbm_vector_scale(v : MlensemblegbmVector, s : Double) -> MlensemblegbmVector {
  let mut result = []
  for i in 0..<v.dim { result = ml_ensemble_gbm_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn ml_ensemble_gbm_vector_dot(a : MlensemblegbmVector, b : MlensemblegbmVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn ml_ensemble_gbm_vector_norm(v : MlensemblegbmVector) -> Double { ml_ensemble_gbm_sqrt(ml_ensemble_gbm_vector_dot(v, v)) }

pub fn ml_ensemble_gbm_vector_normalize(v : MlensemblegbmVector) -> MlensemblegbmVector {
  let n = ml_ensemble_gbm_vector_norm(v)
  if n < 0.0000001 { v } else { ml_ensemble_gbm_vector_scale(v, 1.0 / n) }
}

pub fn ml_ensemble_gbm_vector_dist(a : MlensemblegbmVector, b : MlensemblegbmVector) -> Double {
  ml_ensemble_gbm_vector_norm(ml_ensemble_gbm_vector_sub(a, b))
}

pub fn ml_ensemble_gbm_vector_to_string(v : MlensemblegbmVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + ml_ensemble_gbm_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ml_ensemble_gbm_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn ml_ensemble_gbm_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = ml_ensemble_gbm_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn ml_ensemble_gbm_std(data : Array[Double]) -> Double { ml_ensemble_gbm_sqrt(ml_ensemble_gbm_var(data)) }

pub fn ml_ensemble_gbm_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = ml_ensemble_gbm_mean(a); let mb = ml_ensemble_gbm_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn ml_ensemble_gbm_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = ml_ensemble_gbm_std(a); let sb = ml_ensemble_gbm_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { ml_ensemble_gbm_cov(a, b) / (sa * sb) }
}

pub fn ml_ensemble_gbm_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = ml_ensemble_gbm_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn ml_ensemble_gbm_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn ml_ensemble_gbm_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn ml_ensemble_gbm_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  ml_ensemble_gbm_sqrt(ml_ensemble_gbm_mse(pred, labels))
}

pub fn ml_ensemble_gbm_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + ml_ensemble_gbm_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn ml_ensemble_gbm_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = ml_ensemble_gbm_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn ml_ensemble_gbm_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn ml_ensemble_gbm_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn ml_ensemble_gbm_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = ml_ensemble_gbm_precision(pred, labels, pos); let r = ml_ensemble_gbm_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn ml_ensemble_gbm_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn ml_ensemble_gbm_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = ml_ensemble_gbm_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn ml_ensemble_gbm_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn ml_ensemble_gbm_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn ml_ensemble_gbm_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = ml_ensemble_gbm_gcd(a, b)
    (a / g) * b
  }
}

pub fn ml_ensemble_gbm_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn ml_ensemble_gbm_fibonacci(n : Int) -> Int {
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

pub fn ml_ensemble_gbm_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = ml_ensemble_gbm_min(data); let mx = ml_ensemble_gbm_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn ml_ensemble_gbm_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = ml_ensemble_gbm_mean(data); let sd = ml_ensemble_gbm_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn ml_ensemble_gbm_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn ml_ensemble_gbm_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn ml_ensemble_gbm_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn ml_ensemble_gbm_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn ml_ensemble_gbm_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn ml_ensemble_gbm_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn ml_ensemble_gbm_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn ml_ensemble_gbm_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn ml_ensemble_gbm_dbl(x : Double) -> String {
  let i = if x >= 0.0 { ml_ensemble_gbm_int(x) } else { -ml_ensemble_gbm_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { ml_ensemble_gbm_int(f * 1000000.0) } else { ml_ensemble_gbm_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn ml_ensemble_gbm_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn ml_ensemble_gbm_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct MlensemblegbmFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_gbm_frame_make(size : Int) -> MlensemblegbmFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_gbm_frame_len(s : MlensemblegbmFrame) -> Int { s.size }

pub fn ml_ensemble_gbm_frame_get(s : MlensemblegbmFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_gbm_frame_set(s : MlensemblegbmFrame, i : Int, v : Double) -> MlensemblegbmFrame {
  let result = ml_ensemble_gbm_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_gbm_frame_sum(s : MlensemblegbmFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_ensemble_gbm_frame_mean(s : MlensemblegbmFrame) -> Double {
  if s.size == 0 { 0.0 } else { ml_ensemble_gbm_frame_sum(s) / s.size.to_double() }
}

pub fn ml_ensemble_gbm_frame_scale(s : MlensemblegbmFrame, f : Double) -> MlensemblegbmFrame {
  let result = ml_ensemble_gbm_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_ensemble_gbm_frame_add(a : MlensemblegbmFrame, b : MlensemblegbmFrame) -> MlensemblegbmFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_ensemble_gbm_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_ensemble_gbm_frame_copy(s : MlensemblegbmFrame) -> MlensemblegbmFrame {
  let result = ml_ensemble_gbm_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_ensemble_gbm_frame_fill(s : MlensemblegbmFrame, v : Double) -> MlensemblegbmFrame {
  let result = ml_ensemble_gbm_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_gbm_frame_min(s : MlensemblegbmFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_gbm_frame_max(s : MlensemblegbmFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_gbm_frame_to_string(s : MlensemblegbmFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblegbmTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_gbm_table_make(size : Int) -> MlensemblegbmTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_gbm_table_len(s : MlensemblegbmTable) -> Int { s.size }

pub fn ml_ensemble_gbm_table_get(s : MlensemblegbmTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_gbm_table_set(s : MlensemblegbmTable, i : Int, v : Double) -> MlensemblegbmTable {
  let result = ml_ensemble_gbm_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_gbm_table_sum(s : MlensemblegbmTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_ensemble_gbm_table_mean(s : MlensemblegbmTable) -> Double {
  if s.size == 0 { 0.0 } else { ml_ensemble_gbm_table_sum(s) / s.size.to_double() }
}

pub fn ml_ensemble_gbm_table_scale(s : MlensemblegbmTable, f : Double) -> MlensemblegbmTable {
  let result = ml_ensemble_gbm_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_ensemble_gbm_table_add(a : MlensemblegbmTable, b : MlensemblegbmTable) -> MlensemblegbmTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_ensemble_gbm_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_ensemble_gbm_table_copy(s : MlensemblegbmTable) -> MlensemblegbmTable {
  let result = ml_ensemble_gbm_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_ensemble_gbm_table_fill(s : MlensemblegbmTable, v : Double) -> MlensemblegbmTable {
  let result = ml_ensemble_gbm_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_gbm_table_min(s : MlensemblegbmTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_gbm_table_max(s : MlensemblegbmTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_gbm_table_to_string(s : MlensemblegbmTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblegbmGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_gbm_graphn_make(size : Int) -> MlensemblegbmGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_gbm_graphn_len(s : MlensemblegbmGraphN) -> Int { s.size }

pub fn ml_ensemble_gbm_graphn_get(s : MlensemblegbmGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_gbm_graphn_set(s : MlensemblegbmGraphN, i : Int, v : Double) -> MlensemblegbmGraphN {
  let result = ml_ensemble_gbm_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_gbm_graphn_sum(s : MlensemblegbmGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_ensemble_gbm_graphn_mean(s : MlensemblegbmGraphN) -> Double {
  if s.size == 0 { 0.0 } else { ml_ensemble_gbm_graphn_sum(s) / s.size.to_double() }
}

pub fn ml_ensemble_gbm_graphn_scale(s : MlensemblegbmGraphN, f : Double) -> MlensemblegbmGraphN {
  let result = ml_ensemble_gbm_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_ensemble_gbm_graphn_add(a : MlensemblegbmGraphN, b : MlensemblegbmGraphN) -> MlensemblegbmGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_ensemble_gbm_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_ensemble_gbm_graphn_copy(s : MlensemblegbmGraphN) -> MlensemblegbmGraphN {
  let result = ml_ensemble_gbm_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_ensemble_gbm_graphn_fill(s : MlensemblegbmGraphN, v : Double) -> MlensemblegbmGraphN {
  let result = ml_ensemble_gbm_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_gbm_graphn_min(s : MlensemblegbmGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_gbm_graphn_max(s : MlensemblegbmGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_gbm_graphn_to_string(s : MlensemblegbmGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblegbmNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_gbm_node_make(size : Int) -> MlensemblegbmNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_gbm_node_len(s : MlensemblegbmNode) -> Int { s.size }

pub fn ml_ensemble_gbm_node_get(s : MlensemblegbmNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_gbm_node_set(s : MlensemblegbmNode, i : Int, v : Double) -> MlensemblegbmNode {
  let result = ml_ensemble_gbm_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_gbm_node_sum(s : MlensemblegbmNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_ensemble_gbm_node_mean(s : MlensemblegbmNode) -> Double {
  if s.size == 0 { 0.0 } else { ml_ensemble_gbm_node_sum(s) / s.size.to_double() }
}

pub fn ml_ensemble_gbm_node_scale(s : MlensemblegbmNode, f : Double) -> MlensemblegbmNode {
  let result = ml_ensemble_gbm_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_ensemble_gbm_node_add(a : MlensemblegbmNode, b : MlensemblegbmNode) -> MlensemblegbmNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_ensemble_gbm_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_ensemble_gbm_node_copy(s : MlensemblegbmNode) -> MlensemblegbmNode {
  let result = ml_ensemble_gbm_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_ensemble_gbm_node_fill(s : MlensemblegbmNode, v : Double) -> MlensemblegbmNode {
  let result = ml_ensemble_gbm_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_gbm_node_min(s : MlensemblegbmNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_gbm_node_max(s : MlensemblegbmNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_gbm_node_to_string(s : MlensemblegbmNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblegbmEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_gbm_edge_make(size : Int) -> MlensemblegbmEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_gbm_edge_len(s : MlensemblegbmEdge) -> Int { s.size }

pub fn ml_ensemble_gbm_edge_get(s : MlensemblegbmEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_gbm_edge_set(s : MlensemblegbmEdge, i : Int, v : Double) -> MlensemblegbmEdge {
  let result = ml_ensemble_gbm_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_gbm_edge_sum(s : MlensemblegbmEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_ensemble_gbm_edge_mean(s : MlensemblegbmEdge) -> Double {
  if s.size == 0 { 0.0 } else { ml_ensemble_gbm_edge_sum(s) / s.size.to_double() }
}

pub fn ml_ensemble_gbm_edge_scale(s : MlensemblegbmEdge, f : Double) -> MlensemblegbmEdge {
  let result = ml_ensemble_gbm_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_ensemble_gbm_edge_add(a : MlensemblegbmEdge, b : MlensemblegbmEdge) -> MlensemblegbmEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_ensemble_gbm_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_ensemble_gbm_edge_copy(s : MlensemblegbmEdge) -> MlensemblegbmEdge {
  let result = ml_ensemble_gbm_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_ensemble_gbm_edge_fill(s : MlensemblegbmEdge, v : Double) -> MlensemblegbmEdge {
  let result = ml_ensemble_gbm_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_gbm_edge_min(s : MlensemblegbmEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_gbm_edge_max(s : MlensemblegbmEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_gbm_edge_to_string(s : MlensemblegbmEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblegbmPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_gbm_path_make(size : Int) -> MlensemblegbmPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_gbm_path_len(s : MlensemblegbmPath) -> Int { s.size }

pub fn ml_ensemble_gbm_path_get(s : MlensemblegbmPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_gbm_path_set(s : MlensemblegbmPath, i : Int, v : Double) -> MlensemblegbmPath {
  let result = ml_ensemble_gbm_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_gbm_path_sum(s : MlensemblegbmPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_ensemble_gbm_path_mean(s : MlensemblegbmPath) -> Double {
  if s.size == 0 { 0.0 } else { ml_ensemble_gbm_path_sum(s) / s.size.to_double() }
}

pub fn ml_ensemble_gbm_path_scale(s : MlensemblegbmPath, f : Double) -> MlensemblegbmPath {
  let result = ml_ensemble_gbm_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_ensemble_gbm_path_add(a : MlensemblegbmPath, b : MlensemblegbmPath) -> MlensemblegbmPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_ensemble_gbm_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_ensemble_gbm_path_copy(s : MlensemblegbmPath) -> MlensemblegbmPath {
  let result = ml_ensemble_gbm_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_ensemble_gbm_path_fill(s : MlensemblegbmPath, v : Double) -> MlensemblegbmPath {
  let result = ml_ensemble_gbm_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_gbm_path_min(s : MlensemblegbmPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_gbm_path_max(s : MlensemblegbmPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_gbm_path_to_string(s : MlensemblegbmPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblegbmCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_gbm_cluster_make(size : Int) -> MlensemblegbmCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_gbm_cluster_len(s : MlensemblegbmCluster) -> Int { s.size }

pub fn ml_ensemble_gbm_cluster_get(s : MlensemblegbmCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_gbm_cluster_set(s : MlensemblegbmCluster, i : Int, v : Double) -> MlensemblegbmCluster {
  let result = ml_ensemble_gbm_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_gbm_cluster_sum(s : MlensemblegbmCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_ensemble_gbm_cluster_mean(s : MlensemblegbmCluster) -> Double {
  if s.size == 0 { 0.0 } else { ml_ensemble_gbm_cluster_sum(s) / s.size.to_double() }
}

pub fn ml_ensemble_gbm_cluster_scale(s : MlensemblegbmCluster, f : Double) -> MlensemblegbmCluster {
  let result = ml_ensemble_gbm_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_ensemble_gbm_cluster_add(a : MlensemblegbmCluster, b : MlensemblegbmCluster) -> MlensemblegbmCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_ensemble_gbm_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_ensemble_gbm_cluster_copy(s : MlensemblegbmCluster) -> MlensemblegbmCluster {
  let result = ml_ensemble_gbm_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_ensemble_gbm_cluster_fill(s : MlensemblegbmCluster, v : Double) -> MlensemblegbmCluster {
  let result = ml_ensemble_gbm_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_gbm_cluster_min(s : MlensemblegbmCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_gbm_cluster_max(s : MlensemblegbmCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_gbm_cluster_to_string(s : MlensemblegbmCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblegbmModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_gbm_model_make(size : Int) -> MlensemblegbmModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_gbm_model_len(s : MlensemblegbmModel) -> Int { s.size }

pub fn ml_ensemble_gbm_model_get(s : MlensemblegbmModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_gbm_model_set(s : MlensemblegbmModel, i : Int, v : Double) -> MlensemblegbmModel {
  let result = ml_ensemble_gbm_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_gbm_model_sum(s : MlensemblegbmModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_ensemble_gbm_model_mean(s : MlensemblegbmModel) -> Double {
  if s.size == 0 { 0.0 } else { ml_ensemble_gbm_model_sum(s) / s.size.to_double() }
}

pub fn ml_ensemble_gbm_model_scale(s : MlensemblegbmModel, f : Double) -> MlensemblegbmModel {
  let result = ml_ensemble_gbm_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_ensemble_gbm_model_add(a : MlensemblegbmModel, b : MlensemblegbmModel) -> MlensemblegbmModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_ensemble_gbm_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_ensemble_gbm_model_copy(s : MlensemblegbmModel) -> MlensemblegbmModel {
  let result = ml_ensemble_gbm_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_ensemble_gbm_model_fill(s : MlensemblegbmModel, v : Double) -> MlensemblegbmModel {
  let result = ml_ensemble_gbm_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_gbm_model_min(s : MlensemblegbmModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_gbm_model_max(s : MlensemblegbmModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_gbm_model_to_string(s : MlensemblegbmModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblegbmLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_gbm_layer_make(size : Int) -> MlensemblegbmLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_gbm_layer_len(s : MlensemblegbmLayer) -> Int { s.size }

pub fn ml_ensemble_gbm_layer_get(s : MlensemblegbmLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_gbm_layer_set(s : MlensemblegbmLayer, i : Int, v : Double) -> MlensemblegbmLayer {
  let result = ml_ensemble_gbm_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_gbm_layer_sum(s : MlensemblegbmLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_ensemble_gbm_layer_mean(s : MlensemblegbmLayer) -> Double {
  if s.size == 0 { 0.0 } else { ml_ensemble_gbm_layer_sum(s) / s.size.to_double() }
}

pub fn ml_ensemble_gbm_layer_scale(s : MlensemblegbmLayer, f : Double) -> MlensemblegbmLayer {
  let result = ml_ensemble_gbm_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_ensemble_gbm_layer_add(a : MlensemblegbmLayer, b : MlensemblegbmLayer) -> MlensemblegbmLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_ensemble_gbm_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_ensemble_gbm_layer_copy(s : MlensemblegbmLayer) -> MlensemblegbmLayer {
  let result = ml_ensemble_gbm_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_ensemble_gbm_layer_fill(s : MlensemblegbmLayer, v : Double) -> MlensemblegbmLayer {
  let result = ml_ensemble_gbm_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_gbm_layer_min(s : MlensemblegbmLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_gbm_layer_max(s : MlensemblegbmLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_gbm_layer_to_string(s : MlensemblegbmLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblegbmBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_gbm_buffer_make(size : Int) -> MlensemblegbmBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_gbm_buffer_len(s : MlensemblegbmBuffer) -> Int { s.size }

pub fn ml_ensemble_gbm_buffer_get(s : MlensemblegbmBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_gbm_buffer_set(s : MlensemblegbmBuffer, i : Int, v : Double) -> MlensemblegbmBuffer {
  let result = ml_ensemble_gbm_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_gbm_buffer_sum(s : MlensemblegbmBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_ensemble_gbm_buffer_mean(s : MlensemblegbmBuffer) -> Double {
  if s.size == 0 { 0.0 } else { ml_ensemble_gbm_buffer_sum(s) / s.size.to_double() }
}

pub fn ml_ensemble_gbm_buffer_scale(s : MlensemblegbmBuffer, f : Double) -> MlensemblegbmBuffer {
  let result = ml_ensemble_gbm_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_ensemble_gbm_buffer_add(a : MlensemblegbmBuffer, b : MlensemblegbmBuffer) -> MlensemblegbmBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_ensemble_gbm_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_ensemble_gbm_buffer_copy(s : MlensemblegbmBuffer) -> MlensemblegbmBuffer {
  let result = ml_ensemble_gbm_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_ensemble_gbm_buffer_fill(s : MlensemblegbmBuffer, v : Double) -> MlensemblegbmBuffer {
  let result = ml_ensemble_gbm_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_gbm_buffer_min(s : MlensemblegbmBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_gbm_buffer_max(s : MlensemblegbmBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_gbm_buffer_to_string(s : MlensemblegbmBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblegbmCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_gbm_cursor_make(size : Int) -> MlensemblegbmCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_gbm_cursor_len(s : MlensemblegbmCursor) -> Int { s.size }

pub fn ml_ensemble_gbm_cursor_get(s : MlensemblegbmCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_gbm_cursor_set(s : MlensemblegbmCursor, i : Int, v : Double) -> MlensemblegbmCursor {
  let result = ml_ensemble_gbm_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_gbm_cursor_sum(s : MlensemblegbmCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_ensemble_gbm_cursor_mean(s : MlensemblegbmCursor) -> Double {
  if s.size == 0 { 0.0 } else { ml_ensemble_gbm_cursor_sum(s) / s.size.to_double() }
}

pub fn ml_ensemble_gbm_cursor_scale(s : MlensemblegbmCursor, f : Double) -> MlensemblegbmCursor {
  let result = ml_ensemble_gbm_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_ensemble_gbm_cursor_add(a : MlensemblegbmCursor, b : MlensemblegbmCursor) -> MlensemblegbmCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_ensemble_gbm_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_ensemble_gbm_cursor_copy(s : MlensemblegbmCursor) -> MlensemblegbmCursor {
  let result = ml_ensemble_gbm_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_ensemble_gbm_cursor_fill(s : MlensemblegbmCursor, v : Double) -> MlensemblegbmCursor {
  let result = ml_ensemble_gbm_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_gbm_cursor_min(s : MlensemblegbmCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_gbm_cursor_max(s : MlensemblegbmCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_gbm_cursor_to_string(s : MlensemblegbmCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblegbmView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_gbm_view_make(size : Int) -> MlensemblegbmView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_gbm_view_len(s : MlensemblegbmView) -> Int { s.size }

pub fn ml_ensemble_gbm_view_get(s : MlensemblegbmView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_gbm_view_set(s : MlensemblegbmView, i : Int, v : Double) -> MlensemblegbmView {
  let result = ml_ensemble_gbm_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_gbm_view_sum(s : MlensemblegbmView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_ensemble_gbm_view_mean(s : MlensemblegbmView) -> Double {
  if s.size == 0 { 0.0 } else { ml_ensemble_gbm_view_sum(s) / s.size.to_double() }
}

pub fn ml_ensemble_gbm_view_scale(s : MlensemblegbmView, f : Double) -> MlensemblegbmView {
  let result = ml_ensemble_gbm_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_ensemble_gbm_view_add(a : MlensemblegbmView, b : MlensemblegbmView) -> MlensemblegbmView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_ensemble_gbm_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_ensemble_gbm_view_copy(s : MlensemblegbmView) -> MlensemblegbmView {
  let result = ml_ensemble_gbm_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_ensemble_gbm_view_fill(s : MlensemblegbmView, v : Double) -> MlensemblegbmView {
  let result = ml_ensemble_gbm_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_gbm_view_min(s : MlensemblegbmView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_gbm_view_max(s : MlensemblegbmView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_gbm_view_to_string(s : MlensemblegbmView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblegbmRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_gbm_range_make(size : Int) -> MlensemblegbmRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_gbm_range_len(s : MlensemblegbmRange) -> Int { s.size }

pub fn ml_ensemble_gbm_range_get(s : MlensemblegbmRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_gbm_range_set(s : MlensemblegbmRange, i : Int, v : Double) -> MlensemblegbmRange {
  let result = ml_ensemble_gbm_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_gbm_range_sum(s : MlensemblegbmRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_ensemble_gbm_range_mean(s : MlensemblegbmRange) -> Double {
  if s.size == 0 { 0.0 } else { ml_ensemble_gbm_range_sum(s) / s.size.to_double() }
}

pub fn ml_ensemble_gbm_range_scale(s : MlensemblegbmRange, f : Double) -> MlensemblegbmRange {
  let result = ml_ensemble_gbm_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_ensemble_gbm_range_add(a : MlensemblegbmRange, b : MlensemblegbmRange) -> MlensemblegbmRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_ensemble_gbm_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_ensemble_gbm_range_copy(s : MlensemblegbmRange) -> MlensemblegbmRange {
  let result = ml_ensemble_gbm_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_ensemble_gbm_range_fill(s : MlensemblegbmRange, v : Double) -> MlensemblegbmRange {
  let result = ml_ensemble_gbm_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_gbm_range_min(s : MlensemblegbmRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_gbm_range_max(s : MlensemblegbmRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_gbm_range_to_string(s : MlensemblegbmRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblegbmSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_gbm_slice_make(size : Int) -> MlensemblegbmSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_gbm_slice_len(s : MlensemblegbmSlice) -> Int { s.size }

pub fn ml_ensemble_gbm_slice_get(s : MlensemblegbmSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_gbm_slice_set(s : MlensemblegbmSlice, i : Int, v : Double) -> MlensemblegbmSlice {
  let result = ml_ensemble_gbm_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_gbm_slice_sum(s : MlensemblegbmSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_ensemble_gbm_slice_mean(s : MlensemblegbmSlice) -> Double {
  if s.size == 0 { 0.0 } else { ml_ensemble_gbm_slice_sum(s) / s.size.to_double() }
}

pub fn ml_ensemble_gbm_slice_scale(s : MlensemblegbmSlice, f : Double) -> MlensemblegbmSlice {
  let result = ml_ensemble_gbm_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_ensemble_gbm_slice_add(a : MlensemblegbmSlice, b : MlensemblegbmSlice) -> MlensemblegbmSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_ensemble_gbm_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_ensemble_gbm_slice_copy(s : MlensemblegbmSlice) -> MlensemblegbmSlice {
  let result = ml_ensemble_gbm_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_ensemble_gbm_slice_fill(s : MlensemblegbmSlice, v : Double) -> MlensemblegbmSlice {
  let result = ml_ensemble_gbm_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_gbm_slice_min(s : MlensemblegbmSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_gbm_slice_max(s : MlensemblegbmSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_gbm_slice_to_string(s : MlensemblegbmSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn ml_ensemble_gbm_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_ensemble_gbm_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_ensemble_gbm_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_ensemble_gbm_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_ensemble_gbm_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_ensemble_gbm_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_ensemble_gbm_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_ensemble_gbm_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_ensemble_gbm_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_ensemble_gbm_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_ensemble_gbm_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_ensemble_gbm_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_ensemble_gbm_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_ensemble_gbm_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_ensemble_gbm_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_ensemble_gbm_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_ensemble_gbm_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_ensemble_gbm_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_ensemble_gbm_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_ensemble_gbm_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_ensemble_gbm_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_ensemble_gbm_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_ensemble_gbm_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_ensemble_gbm_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_ensemble_gbm_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

