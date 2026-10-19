///===
/// extcore/ml_metric_calibration

pub(all) struct MlmetriccalibrationPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_metric_calibration_make_point(x : Double, y : Double) -> MlmetriccalibrationPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_metric_calibration_make_point3(x : Double, y : Double, z : Double) -> MlmetriccalibrationPoint {
  { x, y, z, label: 0 }
}

pub fn ml_metric_calibration_point_x(pt : MlmetriccalibrationPoint) -> Double { pt.x }

pub fn ml_metric_calibration_point_y(pt : MlmetriccalibrationPoint) -> Double { pt.y }

pub fn ml_metric_calibration_point_z(pt : MlmetriccalibrationPoint) -> Double { pt.z }

pub fn ml_metric_calibration_point_label(pt : MlmetriccalibrationPoint) -> Int { pt.label }

pub fn ml_metric_calibration_point_dist(a : MlmetriccalibrationPoint, b : MlmetriccalibrationPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ml_metric_calibration_point_add(a : MlmetriccalibrationPoint, b : MlmetriccalibrationPoint) -> MlmetriccalibrationPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn ml_metric_calibration_point_sub(a : MlmetriccalibrationPoint, b : MlmetriccalibrationPoint) -> MlmetriccalibrationPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn ml_metric_calibration_point_scale(pt : MlmetriccalibrationPoint, s : Double) -> MlmetriccalibrationPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn ml_metric_calibration_point_dot(a : MlmetriccalibrationPoint, b : MlmetriccalibrationPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn ml_metric_calibration_point_cross(a : MlmetriccalibrationPoint, b : MlmetriccalibrationPoint) -> MlmetriccalibrationPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn ml_metric_calibration_point_norm(pt : MlmetriccalibrationPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn ml_metric_calibration_point_normalize(pt : MlmetriccalibrationPoint) -> MlmetriccalibrationPoint {
  let n = ml_metric_calibration_point_norm(pt)
  if n < 0.0000001 { pt } else { ml_metric_calibration_point_scale(pt, 1.0 / n) }
}

pub fn ml_metric_calibration_point_negate(pt : MlmetriccalibrationPoint) -> MlmetriccalibrationPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn ml_metric_calibration_point_mid(a : MlmetriccalibrationPoint, b : MlmetriccalibrationPoint) -> MlmetriccalibrationPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn ml_metric_calibration_point_lerp(a : MlmetriccalibrationPoint, b : MlmetriccalibrationPoint, t : Double) -> MlmetriccalibrationPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn ml_metric_calibration_point_to_string(pt : MlmetriccalibrationPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct MlmetriccalibrationSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_metric_calibration_make_series(vals : Array[Double], name : String) -> MlmetriccalibrationSeries {
  { vals, name, meta: 0 }
}

pub fn ml_metric_calibration_series_len(s : MlmetriccalibrationSeries) -> Int { s.vals.length() }

pub fn ml_metric_calibration_series_sum(s : MlmetriccalibrationSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn ml_metric_calibration_series_mean(s : MlmetriccalibrationSeries) -> Double {
  let n = ml_metric_calibration_series_len(s)
  if n == 0 { 0.0 } else { ml_metric_calibration_series_sum(s) / n.to_double() }
}

pub fn ml_metric_calibration_series_min(s : MlmetriccalibrationSeries) -> Double {
  let n = ml_metric_calibration_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn ml_metric_calibration_series_max(s : MlmetriccalibrationSeries) -> Double {
  let n = ml_metric_calibration_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn ml_metric_calibration_series_range(s : MlmetriccalibrationSeries) -> Double {
  ml_metric_calibration_series_max(s) - ml_metric_calibration_series_min(s)
}

pub fn ml_metric_calibration_series_var(s : MlmetriccalibrationSeries) -> Double {
  let n = ml_metric_calibration_series_len(s)
  if n == 0 { 0.0 } else {
    let m = ml_metric_calibration_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn ml_metric_calibration_series_std(s : MlmetriccalibrationSeries) -> Double { @_common.sqrt(ml_metric_calibration_series_var(s)) }

pub fn ml_metric_calibration_series_median(s : MlmetriccalibrationSeries) -> Double {
  let n = ml_metric_calibration_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = ml_metric_calibration_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn ml_metric_calibration_series_scale(s : MlmetriccalibrationSeries, f : Double) -> MlmetriccalibrationSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn ml_metric_calibration_series_add(a : MlmetriccalibrationSeries, b : MlmetriccalibrationSeries) -> MlmetriccalibrationSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn ml_metric_calibration_series_sub(a : MlmetriccalibrationSeries, b : MlmetriccalibrationSeries) -> MlmetriccalibrationSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn ml_metric_calibration_series_normalize(s : MlmetriccalibrationSeries) -> MlmetriccalibrationSeries {
  let mn = ml_metric_calibration_series_min(s)
  let mx = ml_metric_calibration_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn ml_metric_calibration_series_cumsum(s : MlmetriccalibrationSeries) -> MlmetriccalibrationSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn ml_metric_calibration_series_to_string(s : MlmetriccalibrationSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlmetriccalibrationMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_metric_calibration_make_matrix(rows : Int, cols : Int, val : Double) -> MlmetriccalibrationMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_metric_calibration_matrix_identity(n : Int) -> MlmetriccalibrationMatrix {
  let m = ml_metric_calibration_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ml_metric_calibration_matrix_get(m : MlmetriccalibrationMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn ml_metric_calibration_matrix_transpose(m : MlmetriccalibrationMatrix) -> MlmetriccalibrationMatrix {
  let result = ml_metric_calibration_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn ml_metric_calibration_matrix_add(a : MlmetriccalibrationMatrix, b : MlmetriccalibrationMatrix) -> MlmetriccalibrationMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = ml_metric_calibration_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn ml_metric_calibration_matrix_scale(m : MlmetriccalibrationMatrix, s : Double) -> MlmetriccalibrationMatrix {
  let result = ml_metric_calibration_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn ml_metric_calibration_matrix_multiply(a : MlmetriccalibrationMatrix, b : MlmetriccalibrationMatrix) -> MlmetriccalibrationMatrix {
  if a.cols != b.rows { return ml_metric_calibration_make_matrix(a.rows, b.cols, 0.0) }
  let result = ml_metric_calibration_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ml_metric_calibration_matrix_trace(m : MlmetriccalibrationMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn ml_metric_calibration_matrix_det(m : MlmetriccalibrationMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ml_metric_calibration_matrix_norm(m : MlmetriccalibrationMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ml_metric_calibration_matrix_to_string(m : MlmetriccalibrationMatrix) -> String {
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

pub(all) struct MlmetriccalibrationVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_metric_calibration_make_vector(comps : Array[Double]) -> MlmetriccalibrationVector {
  { comps, dim: comps.length() }
}

pub fn ml_metric_calibration_vector_zero(dim : Int) -> MlmetriccalibrationVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ml_metric_calibration_vector_add(a : MlmetriccalibrationVector, b : MlmetriccalibrationVector) -> MlmetriccalibrationVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ml_metric_calibration_vector_sub(a : MlmetriccalibrationVector, b : MlmetriccalibrationVector) -> MlmetriccalibrationVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ml_metric_calibration_vector_scale(v : MlmetriccalibrationVector, s : Double) -> MlmetriccalibrationVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn ml_metric_calibration_vector_dot(a : MlmetriccalibrationVector, b : MlmetriccalibrationVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn ml_metric_calibration_vector_norm(v : MlmetriccalibrationVector) -> Double { @_common.sqrt(ml_metric_calibration_vector_dot(v, v)) }

pub fn ml_metric_calibration_vector_normalize(v : MlmetriccalibrationVector) -> MlmetriccalibrationVector {
  let n = ml_metric_calibration_vector_norm(v)
  if n < 0.0000001 { v } else { ml_metric_calibration_vector_scale(v, 1.0 / n) }
}

pub fn ml_metric_calibration_vector_dist(a : MlmetriccalibrationVector, b : MlmetriccalibrationVector) -> Double {
  ml_metric_calibration_vector_norm(ml_metric_calibration_vector_sub(a, b))
}

pub fn ml_metric_calibration_vector_to_string(v : MlmetriccalibrationVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ml_metric_calibration_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn ml_metric_calibration_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = ml_metric_calibration_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn ml_metric_calibration_std(data : Array[Double]) -> Double { @_common.sqrt(ml_metric_calibration_var(data)) }

pub fn ml_metric_calibration_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = ml_metric_calibration_mean(a); let mb = ml_metric_calibration_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn ml_metric_calibration_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = ml_metric_calibration_std(a); let sb = ml_metric_calibration_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { ml_metric_calibration_cov(a, b) / (sa * sb) }
}

pub fn ml_metric_calibration_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = ml_metric_calibration_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn ml_metric_calibration_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn ml_metric_calibration_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn ml_metric_calibration_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  @_common.sqrt(ml_metric_calibration_mse(pred, labels))
}

pub fn ml_metric_calibration_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn ml_metric_calibration_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = ml_metric_calibration_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn ml_metric_calibration_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn ml_metric_calibration_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn ml_metric_calibration_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = ml_metric_calibration_precision(pred, labels, pos); let r = ml_metric_calibration_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn ml_metric_calibration_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn ml_metric_calibration_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = ml_metric_calibration_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn ml_metric_calibration_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn ml_metric_calibration_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn ml_metric_calibration_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = ml_metric_calibration_gcd(a, b)
    (a / g) * b
  }
}

pub fn ml_metric_calibration_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn ml_metric_calibration_fibonacci(n : Int) -> Int {
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

pub fn ml_metric_calibration_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = ml_metric_calibration_min(data); let mx = ml_metric_calibration_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn ml_metric_calibration_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = ml_metric_calibration_mean(data); let sd = ml_metric_calibration_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn ml_metric_calibration_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn ml_metric_calibration_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn ml_metric_calibration_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn ml_metric_calibration_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn ml_metric_calibration_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn ml_metric_calibration_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

pub(all) struct MlmetriccalibrationFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_calibration_frame_make(size : Int) -> MlmetriccalibrationFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_calibration_frame_len(s : MlmetriccalibrationFrame) -> Int { s.size }

pub fn ml_metric_calibration_frame_get(s : MlmetriccalibrationFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_calibration_frame_set(s : MlmetriccalibrationFrame, i : Int, v : Double) -> MlmetriccalibrationFrame {
  let result = ml_metric_calibration_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_metric_calibration_frame_sum(s : MlmetriccalibrationFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_metric_calibration_frame_mean(s : MlmetriccalibrationFrame) -> Double {
  if s.size == 0 { 0.0 } else { ml_metric_calibration_frame_sum(s) / s.size.to_double() }
}

pub fn ml_metric_calibration_frame_scale(s : MlmetriccalibrationFrame, f : Double) -> MlmetriccalibrationFrame {
  let result = ml_metric_calibration_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_metric_calibration_frame_add(a : MlmetriccalibrationFrame, b : MlmetriccalibrationFrame) -> MlmetriccalibrationFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_metric_calibration_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_metric_calibration_frame_copy(s : MlmetriccalibrationFrame) -> MlmetriccalibrationFrame {
  let result = ml_metric_calibration_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_metric_calibration_frame_fill(s : MlmetriccalibrationFrame, v : Double) -> MlmetriccalibrationFrame {
  let result = ml_metric_calibration_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_metric_calibration_frame_min(s : MlmetriccalibrationFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_calibration_frame_max(s : MlmetriccalibrationFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_calibration_frame_to_string(s : MlmetriccalibrationFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetriccalibrationTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_calibration_table_make(size : Int) -> MlmetriccalibrationTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_calibration_table_len(s : MlmetriccalibrationTable) -> Int { s.size }

pub fn ml_metric_calibration_table_get(s : MlmetriccalibrationTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_calibration_table_set(s : MlmetriccalibrationTable, i : Int, v : Double) -> MlmetriccalibrationTable {
  let result = ml_metric_calibration_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_metric_calibration_table_sum(s : MlmetriccalibrationTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_metric_calibration_table_mean(s : MlmetriccalibrationTable) -> Double {
  if s.size == 0 { 0.0 } else { ml_metric_calibration_table_sum(s) / s.size.to_double() }
}

pub fn ml_metric_calibration_table_scale(s : MlmetriccalibrationTable, f : Double) -> MlmetriccalibrationTable {
  let result = ml_metric_calibration_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_metric_calibration_table_add(a : MlmetriccalibrationTable, b : MlmetriccalibrationTable) -> MlmetriccalibrationTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_metric_calibration_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_metric_calibration_table_copy(s : MlmetriccalibrationTable) -> MlmetriccalibrationTable {
  let result = ml_metric_calibration_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_metric_calibration_table_fill(s : MlmetriccalibrationTable, v : Double) -> MlmetriccalibrationTable {
  let result = ml_metric_calibration_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_metric_calibration_table_min(s : MlmetriccalibrationTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_calibration_table_max(s : MlmetriccalibrationTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_calibration_table_to_string(s : MlmetriccalibrationTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetriccalibrationGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_calibration_graphn_make(size : Int) -> MlmetriccalibrationGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_calibration_graphn_len(s : MlmetriccalibrationGraphN) -> Int { s.size }

pub fn ml_metric_calibration_graphn_get(s : MlmetriccalibrationGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_calibration_graphn_set(s : MlmetriccalibrationGraphN, i : Int, v : Double) -> MlmetriccalibrationGraphN {
  let result = ml_metric_calibration_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_metric_calibration_graphn_sum(s : MlmetriccalibrationGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_metric_calibration_graphn_mean(s : MlmetriccalibrationGraphN) -> Double {
  if s.size == 0 { 0.0 } else { ml_metric_calibration_graphn_sum(s) / s.size.to_double() }
}

pub fn ml_metric_calibration_graphn_scale(s : MlmetriccalibrationGraphN, f : Double) -> MlmetriccalibrationGraphN {
  let result = ml_metric_calibration_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_metric_calibration_graphn_add(a : MlmetriccalibrationGraphN, b : MlmetriccalibrationGraphN) -> MlmetriccalibrationGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_metric_calibration_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_metric_calibration_graphn_copy(s : MlmetriccalibrationGraphN) -> MlmetriccalibrationGraphN {
  let result = ml_metric_calibration_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_metric_calibration_graphn_fill(s : MlmetriccalibrationGraphN, v : Double) -> MlmetriccalibrationGraphN {
  let result = ml_metric_calibration_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_metric_calibration_graphn_min(s : MlmetriccalibrationGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_calibration_graphn_max(s : MlmetriccalibrationGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_calibration_graphn_to_string(s : MlmetriccalibrationGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetriccalibrationNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_calibration_node_make(size : Int) -> MlmetriccalibrationNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_calibration_node_len(s : MlmetriccalibrationNode) -> Int { s.size }

pub fn ml_metric_calibration_node_get(s : MlmetriccalibrationNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_calibration_node_set(s : MlmetriccalibrationNode, i : Int, v : Double) -> MlmetriccalibrationNode {
  let result = ml_metric_calibration_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_metric_calibration_node_sum(s : MlmetriccalibrationNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_metric_calibration_node_mean(s : MlmetriccalibrationNode) -> Double {
  if s.size == 0 { 0.0 } else { ml_metric_calibration_node_sum(s) / s.size.to_double() }
}

pub fn ml_metric_calibration_node_scale(s : MlmetriccalibrationNode, f : Double) -> MlmetriccalibrationNode {
  let result = ml_metric_calibration_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_metric_calibration_node_add(a : MlmetriccalibrationNode, b : MlmetriccalibrationNode) -> MlmetriccalibrationNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_metric_calibration_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_metric_calibration_node_copy(s : MlmetriccalibrationNode) -> MlmetriccalibrationNode {
  let result = ml_metric_calibration_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_metric_calibration_node_fill(s : MlmetriccalibrationNode, v : Double) -> MlmetriccalibrationNode {
  let result = ml_metric_calibration_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_metric_calibration_node_min(s : MlmetriccalibrationNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_calibration_node_max(s : MlmetriccalibrationNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_calibration_node_to_string(s : MlmetriccalibrationNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetriccalibrationEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_calibration_edge_make(size : Int) -> MlmetriccalibrationEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_calibration_edge_len(s : MlmetriccalibrationEdge) -> Int { s.size }

pub fn ml_metric_calibration_edge_get(s : MlmetriccalibrationEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_calibration_edge_set(s : MlmetriccalibrationEdge, i : Int, v : Double) -> MlmetriccalibrationEdge {
  let result = ml_metric_calibration_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_metric_calibration_edge_sum(s : MlmetriccalibrationEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_metric_calibration_edge_mean(s : MlmetriccalibrationEdge) -> Double {
  if s.size == 0 { 0.0 } else { ml_metric_calibration_edge_sum(s) / s.size.to_double() }
}

pub fn ml_metric_calibration_edge_scale(s : MlmetriccalibrationEdge, f : Double) -> MlmetriccalibrationEdge {
  let result = ml_metric_calibration_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_metric_calibration_edge_add(a : MlmetriccalibrationEdge, b : MlmetriccalibrationEdge) -> MlmetriccalibrationEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_metric_calibration_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_metric_calibration_edge_copy(s : MlmetriccalibrationEdge) -> MlmetriccalibrationEdge {
  let result = ml_metric_calibration_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_metric_calibration_edge_fill(s : MlmetriccalibrationEdge, v : Double) -> MlmetriccalibrationEdge {
  let result = ml_metric_calibration_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_metric_calibration_edge_min(s : MlmetriccalibrationEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_calibration_edge_max(s : MlmetriccalibrationEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_calibration_edge_to_string(s : MlmetriccalibrationEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetriccalibrationPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_calibration_path_make(size : Int) -> MlmetriccalibrationPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_calibration_path_len(s : MlmetriccalibrationPath) -> Int { s.size }

pub fn ml_metric_calibration_path_get(s : MlmetriccalibrationPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_calibration_path_set(s : MlmetriccalibrationPath, i : Int, v : Double) -> MlmetriccalibrationPath {
  let result = ml_metric_calibration_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_metric_calibration_path_sum(s : MlmetriccalibrationPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_metric_calibration_path_mean(s : MlmetriccalibrationPath) -> Double {
  if s.size == 0 { 0.0 } else { ml_metric_calibration_path_sum(s) / s.size.to_double() }
}

pub fn ml_metric_calibration_path_scale(s : MlmetriccalibrationPath, f : Double) -> MlmetriccalibrationPath {
  let result = ml_metric_calibration_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_metric_calibration_path_add(a : MlmetriccalibrationPath, b : MlmetriccalibrationPath) -> MlmetriccalibrationPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_metric_calibration_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_metric_calibration_path_copy(s : MlmetriccalibrationPath) -> MlmetriccalibrationPath {
  let result = ml_metric_calibration_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_metric_calibration_path_fill(s : MlmetriccalibrationPath, v : Double) -> MlmetriccalibrationPath {
  let result = ml_metric_calibration_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_metric_calibration_path_min(s : MlmetriccalibrationPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_calibration_path_max(s : MlmetriccalibrationPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_calibration_path_to_string(s : MlmetriccalibrationPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetriccalibrationCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_calibration_cluster_make(size : Int) -> MlmetriccalibrationCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_calibration_cluster_len(s : MlmetriccalibrationCluster) -> Int { s.size }

pub fn ml_metric_calibration_cluster_get(s : MlmetriccalibrationCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_calibration_cluster_set(s : MlmetriccalibrationCluster, i : Int, v : Double) -> MlmetriccalibrationCluster {
  let result = ml_metric_calibration_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_metric_calibration_cluster_sum(s : MlmetriccalibrationCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_metric_calibration_cluster_mean(s : MlmetriccalibrationCluster) -> Double {
  if s.size == 0 { 0.0 } else { ml_metric_calibration_cluster_sum(s) / s.size.to_double() }
}

pub fn ml_metric_calibration_cluster_scale(s : MlmetriccalibrationCluster, f : Double) -> MlmetriccalibrationCluster {
  let result = ml_metric_calibration_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_metric_calibration_cluster_add(a : MlmetriccalibrationCluster, b : MlmetriccalibrationCluster) -> MlmetriccalibrationCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_metric_calibration_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_metric_calibration_cluster_copy(s : MlmetriccalibrationCluster) -> MlmetriccalibrationCluster {
  let result = ml_metric_calibration_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_metric_calibration_cluster_fill(s : MlmetriccalibrationCluster, v : Double) -> MlmetriccalibrationCluster {
  let result = ml_metric_calibration_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_metric_calibration_cluster_min(s : MlmetriccalibrationCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_calibration_cluster_max(s : MlmetriccalibrationCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_calibration_cluster_to_string(s : MlmetriccalibrationCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetriccalibrationModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_calibration_model_make(size : Int) -> MlmetriccalibrationModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_calibration_model_len(s : MlmetriccalibrationModel) -> Int { s.size }

pub fn ml_metric_calibration_model_get(s : MlmetriccalibrationModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_calibration_model_set(s : MlmetriccalibrationModel, i : Int, v : Double) -> MlmetriccalibrationModel {
  let result = ml_metric_calibration_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_metric_calibration_model_sum(s : MlmetriccalibrationModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_metric_calibration_model_mean(s : MlmetriccalibrationModel) -> Double {
  if s.size == 0 { 0.0 } else { ml_metric_calibration_model_sum(s) / s.size.to_double() }
}

pub fn ml_metric_calibration_model_scale(s : MlmetriccalibrationModel, f : Double) -> MlmetriccalibrationModel {
  let result = ml_metric_calibration_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_metric_calibration_model_add(a : MlmetriccalibrationModel, b : MlmetriccalibrationModel) -> MlmetriccalibrationModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_metric_calibration_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_metric_calibration_model_copy(s : MlmetriccalibrationModel) -> MlmetriccalibrationModel {
  let result = ml_metric_calibration_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_metric_calibration_model_fill(s : MlmetriccalibrationModel, v : Double) -> MlmetriccalibrationModel {
  let result = ml_metric_calibration_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_metric_calibration_model_min(s : MlmetriccalibrationModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_calibration_model_max(s : MlmetriccalibrationModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_calibration_model_to_string(s : MlmetriccalibrationModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetriccalibrationLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_calibration_layer_make(size : Int) -> MlmetriccalibrationLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_calibration_layer_len(s : MlmetriccalibrationLayer) -> Int { s.size }

pub fn ml_metric_calibration_layer_get(s : MlmetriccalibrationLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_calibration_layer_set(s : MlmetriccalibrationLayer, i : Int, v : Double) -> MlmetriccalibrationLayer {
  let result = ml_metric_calibration_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_metric_calibration_layer_sum(s : MlmetriccalibrationLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_metric_calibration_layer_mean(s : MlmetriccalibrationLayer) -> Double {
  if s.size == 0 { 0.0 } else { ml_metric_calibration_layer_sum(s) / s.size.to_double() }
}

pub fn ml_metric_calibration_layer_scale(s : MlmetriccalibrationLayer, f : Double) -> MlmetriccalibrationLayer {
  let result = ml_metric_calibration_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_metric_calibration_layer_add(a : MlmetriccalibrationLayer, b : MlmetriccalibrationLayer) -> MlmetriccalibrationLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_metric_calibration_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_metric_calibration_layer_copy(s : MlmetriccalibrationLayer) -> MlmetriccalibrationLayer {
  let result = ml_metric_calibration_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_metric_calibration_layer_fill(s : MlmetriccalibrationLayer, v : Double) -> MlmetriccalibrationLayer {
  let result = ml_metric_calibration_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_metric_calibration_layer_min(s : MlmetriccalibrationLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_calibration_layer_max(s : MlmetriccalibrationLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_calibration_layer_to_string(s : MlmetriccalibrationLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetriccalibrationBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_calibration_buffer_make(size : Int) -> MlmetriccalibrationBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_calibration_buffer_len(s : MlmetriccalibrationBuffer) -> Int { s.size }

pub fn ml_metric_calibration_buffer_get(s : MlmetriccalibrationBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_calibration_buffer_set(s : MlmetriccalibrationBuffer, i : Int, v : Double) -> MlmetriccalibrationBuffer {
  let result = ml_metric_calibration_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_metric_calibration_buffer_sum(s : MlmetriccalibrationBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_metric_calibration_buffer_mean(s : MlmetriccalibrationBuffer) -> Double {
  if s.size == 0 { 0.0 } else { ml_metric_calibration_buffer_sum(s) / s.size.to_double() }
}

pub fn ml_metric_calibration_buffer_scale(s : MlmetriccalibrationBuffer, f : Double) -> MlmetriccalibrationBuffer {
  let result = ml_metric_calibration_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_metric_calibration_buffer_add(a : MlmetriccalibrationBuffer, b : MlmetriccalibrationBuffer) -> MlmetriccalibrationBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_metric_calibration_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_metric_calibration_buffer_copy(s : MlmetriccalibrationBuffer) -> MlmetriccalibrationBuffer {
  let result = ml_metric_calibration_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_metric_calibration_buffer_fill(s : MlmetriccalibrationBuffer, v : Double) -> MlmetriccalibrationBuffer {
  let result = ml_metric_calibration_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_metric_calibration_buffer_min(s : MlmetriccalibrationBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_calibration_buffer_max(s : MlmetriccalibrationBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_calibration_buffer_to_string(s : MlmetriccalibrationBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetriccalibrationCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_calibration_cursor_make(size : Int) -> MlmetriccalibrationCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_calibration_cursor_len(s : MlmetriccalibrationCursor) -> Int { s.size }

pub fn ml_metric_calibration_cursor_get(s : MlmetriccalibrationCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_calibration_cursor_set(s : MlmetriccalibrationCursor, i : Int, v : Double) -> MlmetriccalibrationCursor {
  let result = ml_metric_calibration_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_metric_calibration_cursor_sum(s : MlmetriccalibrationCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_metric_calibration_cursor_mean(s : MlmetriccalibrationCursor) -> Double {
  if s.size == 0 { 0.0 } else { ml_metric_calibration_cursor_sum(s) / s.size.to_double() }
}

pub fn ml_metric_calibration_cursor_scale(s : MlmetriccalibrationCursor, f : Double) -> MlmetriccalibrationCursor {
  let result = ml_metric_calibration_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_metric_calibration_cursor_add(a : MlmetriccalibrationCursor, b : MlmetriccalibrationCursor) -> MlmetriccalibrationCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_metric_calibration_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_metric_calibration_cursor_copy(s : MlmetriccalibrationCursor) -> MlmetriccalibrationCursor {
  let result = ml_metric_calibration_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_metric_calibration_cursor_fill(s : MlmetriccalibrationCursor, v : Double) -> MlmetriccalibrationCursor {
  let result = ml_metric_calibration_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_metric_calibration_cursor_min(s : MlmetriccalibrationCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_calibration_cursor_max(s : MlmetriccalibrationCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_calibration_cursor_to_string(s : MlmetriccalibrationCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetriccalibrationView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_calibration_view_make(size : Int) -> MlmetriccalibrationView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_calibration_view_len(s : MlmetriccalibrationView) -> Int { s.size }

pub fn ml_metric_calibration_view_get(s : MlmetriccalibrationView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_calibration_view_set(s : MlmetriccalibrationView, i : Int, v : Double) -> MlmetriccalibrationView {
  let result = ml_metric_calibration_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_metric_calibration_view_sum(s : MlmetriccalibrationView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_metric_calibration_view_mean(s : MlmetriccalibrationView) -> Double {
  if s.size == 0 { 0.0 } else { ml_metric_calibration_view_sum(s) / s.size.to_double() }
}

pub fn ml_metric_calibration_view_scale(s : MlmetriccalibrationView, f : Double) -> MlmetriccalibrationView {
  let result = ml_metric_calibration_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_metric_calibration_view_add(a : MlmetriccalibrationView, b : MlmetriccalibrationView) -> MlmetriccalibrationView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_metric_calibration_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_metric_calibration_view_copy(s : MlmetriccalibrationView) -> MlmetriccalibrationView {
  let result = ml_metric_calibration_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_metric_calibration_view_fill(s : MlmetriccalibrationView, v : Double) -> MlmetriccalibrationView {
  let result = ml_metric_calibration_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_metric_calibration_view_min(s : MlmetriccalibrationView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_calibration_view_max(s : MlmetriccalibrationView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_calibration_view_to_string(s : MlmetriccalibrationView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetriccalibrationRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_calibration_range_make(size : Int) -> MlmetriccalibrationRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_calibration_range_len(s : MlmetriccalibrationRange) -> Int { s.size }

pub fn ml_metric_calibration_range_get(s : MlmetriccalibrationRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_calibration_range_set(s : MlmetriccalibrationRange, i : Int, v : Double) -> MlmetriccalibrationRange {
  let result = ml_metric_calibration_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_metric_calibration_range_sum(s : MlmetriccalibrationRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_metric_calibration_range_mean(s : MlmetriccalibrationRange) -> Double {
  if s.size == 0 { 0.0 } else { ml_metric_calibration_range_sum(s) / s.size.to_double() }
}

pub fn ml_metric_calibration_range_scale(s : MlmetriccalibrationRange, f : Double) -> MlmetriccalibrationRange {
  let result = ml_metric_calibration_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_metric_calibration_range_add(a : MlmetriccalibrationRange, b : MlmetriccalibrationRange) -> MlmetriccalibrationRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_metric_calibration_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_metric_calibration_range_copy(s : MlmetriccalibrationRange) -> MlmetriccalibrationRange {
  let result = ml_metric_calibration_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_metric_calibration_range_fill(s : MlmetriccalibrationRange, v : Double) -> MlmetriccalibrationRange {
  let result = ml_metric_calibration_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_metric_calibration_range_min(s : MlmetriccalibrationRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_calibration_range_max(s : MlmetriccalibrationRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_calibration_range_to_string(s : MlmetriccalibrationRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetriccalibrationSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_calibration_slice_make(size : Int) -> MlmetriccalibrationSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_calibration_slice_len(s : MlmetriccalibrationSlice) -> Int { s.size }

pub fn ml_metric_calibration_slice_get(s : MlmetriccalibrationSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_calibration_slice_set(s : MlmetriccalibrationSlice, i : Int, v : Double) -> MlmetriccalibrationSlice {
  let result = ml_metric_calibration_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_metric_calibration_slice_sum(s : MlmetriccalibrationSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_metric_calibration_slice_mean(s : MlmetriccalibrationSlice) -> Double {
  if s.size == 0 { 0.0 } else { ml_metric_calibration_slice_sum(s) / s.size.to_double() }
}

pub fn ml_metric_calibration_slice_scale(s : MlmetriccalibrationSlice, f : Double) -> MlmetriccalibrationSlice {
  let result = ml_metric_calibration_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_metric_calibration_slice_add(a : MlmetriccalibrationSlice, b : MlmetriccalibrationSlice) -> MlmetriccalibrationSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_metric_calibration_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_metric_calibration_slice_copy(s : MlmetriccalibrationSlice) -> MlmetriccalibrationSlice {
  let result = ml_metric_calibration_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_metric_calibration_slice_fill(s : MlmetriccalibrationSlice, v : Double) -> MlmetriccalibrationSlice {
  let result = ml_metric_calibration_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_metric_calibration_slice_min(s : MlmetriccalibrationSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_calibration_slice_max(s : MlmetriccalibrationSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_calibration_slice_to_string(s : MlmetriccalibrationSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

