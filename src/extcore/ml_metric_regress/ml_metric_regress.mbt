///===
/// extcore/ml_metric_regress

pub(all) struct MlmetricregressPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_metric_regress_make_point(x : Double, y : Double) -> MlmetricregressPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_metric_regress_make_point3(x : Double, y : Double, z : Double) -> MlmetricregressPoint {
  { x, y, z, label: 0 }
}

pub fn ml_metric_regress_point_x(pt : MlmetricregressPoint) -> Double { pt.x }

pub fn ml_metric_regress_point_y(pt : MlmetricregressPoint) -> Double { pt.y }

pub fn ml_metric_regress_point_z(pt : MlmetricregressPoint) -> Double { pt.z }

pub fn ml_metric_regress_point_label(pt : MlmetricregressPoint) -> Int { pt.label }

pub fn ml_metric_regress_point_dist(a : MlmetricregressPoint, b : MlmetricregressPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ml_metric_regress_point_add(a : MlmetricregressPoint, b : MlmetricregressPoint) -> MlmetricregressPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn ml_metric_regress_point_sub(a : MlmetricregressPoint, b : MlmetricregressPoint) -> MlmetricregressPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn ml_metric_regress_point_scale(pt : MlmetricregressPoint, s : Double) -> MlmetricregressPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn ml_metric_regress_point_dot(a : MlmetricregressPoint, b : MlmetricregressPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn ml_metric_regress_point_cross(a : MlmetricregressPoint, b : MlmetricregressPoint) -> MlmetricregressPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn ml_metric_regress_point_norm(pt : MlmetricregressPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn ml_metric_regress_point_normalize(pt : MlmetricregressPoint) -> MlmetricregressPoint {
  let n = ml_metric_regress_point_norm(pt)
  if n < 0.0000001 { pt } else { ml_metric_regress_point_scale(pt, 1.0 / n) }
}

pub fn ml_metric_regress_point_negate(pt : MlmetricregressPoint) -> MlmetricregressPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn ml_metric_regress_point_mid(a : MlmetricregressPoint, b : MlmetricregressPoint) -> MlmetricregressPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn ml_metric_regress_point_lerp(a : MlmetricregressPoint, b : MlmetricregressPoint, t : Double) -> MlmetricregressPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn ml_metric_regress_point_to_string(pt : MlmetricregressPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct MlmetricregressSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_metric_regress_make_series(vals : Array[Double], name : String) -> MlmetricregressSeries {
  { vals, name, meta: 0 }
}

pub fn ml_metric_regress_series_len(s : MlmetricregressSeries) -> Int { s.vals.length() }

pub fn ml_metric_regress_series_sum(s : MlmetricregressSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn ml_metric_regress_series_mean(s : MlmetricregressSeries) -> Double {
  let n = ml_metric_regress_series_len(s)
  if n == 0 { 0.0 } else { ml_metric_regress_series_sum(s) / n.to_double() }
}

pub fn ml_metric_regress_series_min(s : MlmetricregressSeries) -> Double {
  let n = ml_metric_regress_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn ml_metric_regress_series_max(s : MlmetricregressSeries) -> Double {
  let n = ml_metric_regress_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn ml_metric_regress_series_range(s : MlmetricregressSeries) -> Double {
  ml_metric_regress_series_max(s) - ml_metric_regress_series_min(s)
}

pub fn ml_metric_regress_series_var(s : MlmetricregressSeries) -> Double {
  let n = ml_metric_regress_series_len(s)
  if n == 0 { 0.0 } else {
    let m = ml_metric_regress_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn ml_metric_regress_series_std(s : MlmetricregressSeries) -> Double { @_common.sqrt(ml_metric_regress_series_var(s)) }

pub fn ml_metric_regress_series_median(s : MlmetricregressSeries) -> Double {
  let n = ml_metric_regress_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = ml_metric_regress_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn ml_metric_regress_series_scale(s : MlmetricregressSeries, f : Double) -> MlmetricregressSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn ml_metric_regress_series_add(a : MlmetricregressSeries, b : MlmetricregressSeries) -> MlmetricregressSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn ml_metric_regress_series_sub(a : MlmetricregressSeries, b : MlmetricregressSeries) -> MlmetricregressSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn ml_metric_regress_series_normalize(s : MlmetricregressSeries) -> MlmetricregressSeries {
  let mn = ml_metric_regress_series_min(s)
  let mx = ml_metric_regress_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn ml_metric_regress_series_cumsum(s : MlmetricregressSeries) -> MlmetricregressSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn ml_metric_regress_series_to_string(s : MlmetricregressSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlmetricregressMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_metric_regress_make_matrix(rows : Int, cols : Int, val : Double) -> MlmetricregressMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_metric_regress_matrix_identity(n : Int) -> MlmetricregressMatrix {
  let m = ml_metric_regress_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ml_metric_regress_matrix_get(m : MlmetricregressMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn ml_metric_regress_matrix_transpose(m : MlmetricregressMatrix) -> MlmetricregressMatrix {
  let result = ml_metric_regress_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn ml_metric_regress_matrix_add(a : MlmetricregressMatrix, b : MlmetricregressMatrix) -> MlmetricregressMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = ml_metric_regress_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn ml_metric_regress_matrix_scale(m : MlmetricregressMatrix, s : Double) -> MlmetricregressMatrix {
  let result = ml_metric_regress_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn ml_metric_regress_matrix_multiply(a : MlmetricregressMatrix, b : MlmetricregressMatrix) -> MlmetricregressMatrix {
  if a.cols != b.rows { return ml_metric_regress_make_matrix(a.rows, b.cols, 0.0) }
  let result = ml_metric_regress_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ml_metric_regress_matrix_trace(m : MlmetricregressMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn ml_metric_regress_matrix_det(m : MlmetricregressMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ml_metric_regress_matrix_norm(m : MlmetricregressMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ml_metric_regress_matrix_to_string(m : MlmetricregressMatrix) -> String {
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

pub(all) struct MlmetricregressVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_metric_regress_make_vector(comps : Array[Double]) -> MlmetricregressVector {
  { comps, dim: comps.length() }
}

pub fn ml_metric_regress_vector_zero(dim : Int) -> MlmetricregressVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ml_metric_regress_vector_add(a : MlmetricregressVector, b : MlmetricregressVector) -> MlmetricregressVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ml_metric_regress_vector_sub(a : MlmetricregressVector, b : MlmetricregressVector) -> MlmetricregressVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ml_metric_regress_vector_scale(v : MlmetricregressVector, s : Double) -> MlmetricregressVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn ml_metric_regress_vector_dot(a : MlmetricregressVector, b : MlmetricregressVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn ml_metric_regress_vector_norm(v : MlmetricregressVector) -> Double { @_common.sqrt(ml_metric_regress_vector_dot(v, v)) }

pub fn ml_metric_regress_vector_normalize(v : MlmetricregressVector) -> MlmetricregressVector {
  let n = ml_metric_regress_vector_norm(v)
  if n < 0.0000001 { v } else { ml_metric_regress_vector_scale(v, 1.0 / n) }
}

pub fn ml_metric_regress_vector_dist(a : MlmetricregressVector, b : MlmetricregressVector) -> Double {
  ml_metric_regress_vector_norm(ml_metric_regress_vector_sub(a, b))
}

pub fn ml_metric_regress_vector_to_string(v : MlmetricregressVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ml_metric_regress_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn ml_metric_regress_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = ml_metric_regress_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn ml_metric_regress_std(data : Array[Double]) -> Double { @_common.sqrt(ml_metric_regress_var(data)) }

pub fn ml_metric_regress_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = ml_metric_regress_mean(a); let mb = ml_metric_regress_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn ml_metric_regress_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = ml_metric_regress_std(a); let sb = ml_metric_regress_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { ml_metric_regress_cov(a, b) / (sa * sb) }
}

pub fn ml_metric_regress_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = ml_metric_regress_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn ml_metric_regress_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn ml_metric_regress_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn ml_metric_regress_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  @_common.sqrt(ml_metric_regress_mse(pred, labels))
}

pub fn ml_metric_regress_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn ml_metric_regress_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = ml_metric_regress_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn ml_metric_regress_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn ml_metric_regress_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn ml_metric_regress_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = ml_metric_regress_precision(pred, labels, pos); let r = ml_metric_regress_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn ml_metric_regress_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn ml_metric_regress_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = ml_metric_regress_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn ml_metric_regress_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn ml_metric_regress_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn ml_metric_regress_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = ml_metric_regress_gcd(a, b)
    (a / g) * b
  }
}

pub fn ml_metric_regress_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn ml_metric_regress_fibonacci(n : Int) -> Int {
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

pub fn ml_metric_regress_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = ml_metric_regress_min(data); let mx = ml_metric_regress_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn ml_metric_regress_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = ml_metric_regress_mean(data); let sd = ml_metric_regress_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn ml_metric_regress_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn ml_metric_regress_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn ml_metric_regress_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn ml_metric_regress_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn ml_metric_regress_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn ml_metric_regress_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

pub(all) struct MlmetricregressFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_regress_frame_make(size : Int) -> MlmetricregressFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_regress_frame_len(s : MlmetricregressFrame) -> Int { s.size }

pub fn ml_metric_regress_frame_get(s : MlmetricregressFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_regress_frame_set(s : MlmetricregressFrame, i : Int, v : Double) -> MlmetricregressFrame {
  let result = ml_metric_regress_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_metric_regress_frame_sum(s : MlmetricregressFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_metric_regress_frame_mean(s : MlmetricregressFrame) -> Double {
  if s.size == 0 { 0.0 } else { ml_metric_regress_frame_sum(s) / s.size.to_double() }
}

pub fn ml_metric_regress_frame_scale(s : MlmetricregressFrame, f : Double) -> MlmetricregressFrame {
  let result = ml_metric_regress_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_metric_regress_frame_add(a : MlmetricregressFrame, b : MlmetricregressFrame) -> MlmetricregressFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_metric_regress_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_metric_regress_frame_copy(s : MlmetricregressFrame) -> MlmetricregressFrame {
  let result = ml_metric_regress_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_metric_regress_frame_fill(s : MlmetricregressFrame, v : Double) -> MlmetricregressFrame {
  let result = ml_metric_regress_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_metric_regress_frame_min(s : MlmetricregressFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_regress_frame_max(s : MlmetricregressFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_regress_frame_to_string(s : MlmetricregressFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricregressTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_regress_table_make(size : Int) -> MlmetricregressTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_regress_table_len(s : MlmetricregressTable) -> Int { s.size }

pub fn ml_metric_regress_table_get(s : MlmetricregressTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_regress_table_set(s : MlmetricregressTable, i : Int, v : Double) -> MlmetricregressTable {
  let result = ml_metric_regress_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_metric_regress_table_sum(s : MlmetricregressTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_metric_regress_table_mean(s : MlmetricregressTable) -> Double {
  if s.size == 0 { 0.0 } else { ml_metric_regress_table_sum(s) / s.size.to_double() }
}

pub fn ml_metric_regress_table_scale(s : MlmetricregressTable, f : Double) -> MlmetricregressTable {
  let result = ml_metric_regress_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_metric_regress_table_add(a : MlmetricregressTable, b : MlmetricregressTable) -> MlmetricregressTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_metric_regress_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_metric_regress_table_copy(s : MlmetricregressTable) -> MlmetricregressTable {
  let result = ml_metric_regress_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_metric_regress_table_fill(s : MlmetricregressTable, v : Double) -> MlmetricregressTable {
  let result = ml_metric_regress_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_metric_regress_table_min(s : MlmetricregressTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_regress_table_max(s : MlmetricregressTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_regress_table_to_string(s : MlmetricregressTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricregressGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_regress_graphn_make(size : Int) -> MlmetricregressGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_regress_graphn_len(s : MlmetricregressGraphN) -> Int { s.size }

pub fn ml_metric_regress_graphn_get(s : MlmetricregressGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_regress_graphn_set(s : MlmetricregressGraphN, i : Int, v : Double) -> MlmetricregressGraphN {
  let result = ml_metric_regress_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_metric_regress_graphn_sum(s : MlmetricregressGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_metric_regress_graphn_mean(s : MlmetricregressGraphN) -> Double {
  if s.size == 0 { 0.0 } else { ml_metric_regress_graphn_sum(s) / s.size.to_double() }
}

pub fn ml_metric_regress_graphn_scale(s : MlmetricregressGraphN, f : Double) -> MlmetricregressGraphN {
  let result = ml_metric_regress_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_metric_regress_graphn_add(a : MlmetricregressGraphN, b : MlmetricregressGraphN) -> MlmetricregressGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_metric_regress_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_metric_regress_graphn_copy(s : MlmetricregressGraphN) -> MlmetricregressGraphN {
  let result = ml_metric_regress_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_metric_regress_graphn_fill(s : MlmetricregressGraphN, v : Double) -> MlmetricregressGraphN {
  let result = ml_metric_regress_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_metric_regress_graphn_min(s : MlmetricregressGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_regress_graphn_max(s : MlmetricregressGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_regress_graphn_to_string(s : MlmetricregressGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricregressNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_regress_node_make(size : Int) -> MlmetricregressNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_regress_node_len(s : MlmetricregressNode) -> Int { s.size }

pub fn ml_metric_regress_node_get(s : MlmetricregressNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_regress_node_set(s : MlmetricregressNode, i : Int, v : Double) -> MlmetricregressNode {
  let result = ml_metric_regress_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_metric_regress_node_sum(s : MlmetricregressNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_metric_regress_node_mean(s : MlmetricregressNode) -> Double {
  if s.size == 0 { 0.0 } else { ml_metric_regress_node_sum(s) / s.size.to_double() }
}

pub fn ml_metric_regress_node_scale(s : MlmetricregressNode, f : Double) -> MlmetricregressNode {
  let result = ml_metric_regress_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_metric_regress_node_add(a : MlmetricregressNode, b : MlmetricregressNode) -> MlmetricregressNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_metric_regress_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_metric_regress_node_copy(s : MlmetricregressNode) -> MlmetricregressNode {
  let result = ml_metric_regress_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_metric_regress_node_fill(s : MlmetricregressNode, v : Double) -> MlmetricregressNode {
  let result = ml_metric_regress_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_metric_regress_node_min(s : MlmetricregressNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_regress_node_max(s : MlmetricregressNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_regress_node_to_string(s : MlmetricregressNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricregressEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_regress_edge_make(size : Int) -> MlmetricregressEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_regress_edge_len(s : MlmetricregressEdge) -> Int { s.size }

pub fn ml_metric_regress_edge_get(s : MlmetricregressEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_regress_edge_set(s : MlmetricregressEdge, i : Int, v : Double) -> MlmetricregressEdge {
  let result = ml_metric_regress_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_metric_regress_edge_sum(s : MlmetricregressEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_metric_regress_edge_mean(s : MlmetricregressEdge) -> Double {
  if s.size == 0 { 0.0 } else { ml_metric_regress_edge_sum(s) / s.size.to_double() }
}

pub fn ml_metric_regress_edge_scale(s : MlmetricregressEdge, f : Double) -> MlmetricregressEdge {
  let result = ml_metric_regress_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_metric_regress_edge_add(a : MlmetricregressEdge, b : MlmetricregressEdge) -> MlmetricregressEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_metric_regress_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_metric_regress_edge_copy(s : MlmetricregressEdge) -> MlmetricregressEdge {
  let result = ml_metric_regress_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_metric_regress_edge_fill(s : MlmetricregressEdge, v : Double) -> MlmetricregressEdge {
  let result = ml_metric_regress_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_metric_regress_edge_min(s : MlmetricregressEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_regress_edge_max(s : MlmetricregressEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_regress_edge_to_string(s : MlmetricregressEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricregressPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_regress_path_make(size : Int) -> MlmetricregressPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_regress_path_len(s : MlmetricregressPath) -> Int { s.size }

pub fn ml_metric_regress_path_get(s : MlmetricregressPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_regress_path_set(s : MlmetricregressPath, i : Int, v : Double) -> MlmetricregressPath {
  let result = ml_metric_regress_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_metric_regress_path_sum(s : MlmetricregressPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_metric_regress_path_mean(s : MlmetricregressPath) -> Double {
  if s.size == 0 { 0.0 } else { ml_metric_regress_path_sum(s) / s.size.to_double() }
}

pub fn ml_metric_regress_path_scale(s : MlmetricregressPath, f : Double) -> MlmetricregressPath {
  let result = ml_metric_regress_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_metric_regress_path_add(a : MlmetricregressPath, b : MlmetricregressPath) -> MlmetricregressPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_metric_regress_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_metric_regress_path_copy(s : MlmetricregressPath) -> MlmetricregressPath {
  let result = ml_metric_regress_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_metric_regress_path_fill(s : MlmetricregressPath, v : Double) -> MlmetricregressPath {
  let result = ml_metric_regress_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_metric_regress_path_min(s : MlmetricregressPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_regress_path_max(s : MlmetricregressPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_regress_path_to_string(s : MlmetricregressPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricregressCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_regress_cluster_make(size : Int) -> MlmetricregressCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_regress_cluster_len(s : MlmetricregressCluster) -> Int { s.size }

pub fn ml_metric_regress_cluster_get(s : MlmetricregressCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_regress_cluster_set(s : MlmetricregressCluster, i : Int, v : Double) -> MlmetricregressCluster {
  let result = ml_metric_regress_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_metric_regress_cluster_sum(s : MlmetricregressCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_metric_regress_cluster_mean(s : MlmetricregressCluster) -> Double {
  if s.size == 0 { 0.0 } else { ml_metric_regress_cluster_sum(s) / s.size.to_double() }
}

pub fn ml_metric_regress_cluster_scale(s : MlmetricregressCluster, f : Double) -> MlmetricregressCluster {
  let result = ml_metric_regress_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_metric_regress_cluster_add(a : MlmetricregressCluster, b : MlmetricregressCluster) -> MlmetricregressCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_metric_regress_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_metric_regress_cluster_copy(s : MlmetricregressCluster) -> MlmetricregressCluster {
  let result = ml_metric_regress_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_metric_regress_cluster_fill(s : MlmetricregressCluster, v : Double) -> MlmetricregressCluster {
  let result = ml_metric_regress_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_metric_regress_cluster_min(s : MlmetricregressCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_regress_cluster_max(s : MlmetricregressCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_regress_cluster_to_string(s : MlmetricregressCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricregressModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_regress_model_make(size : Int) -> MlmetricregressModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_regress_model_len(s : MlmetricregressModel) -> Int { s.size }

pub fn ml_metric_regress_model_get(s : MlmetricregressModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_regress_model_set(s : MlmetricregressModel, i : Int, v : Double) -> MlmetricregressModel {
  let result = ml_metric_regress_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_metric_regress_model_sum(s : MlmetricregressModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_metric_regress_model_mean(s : MlmetricregressModel) -> Double {
  if s.size == 0 { 0.0 } else { ml_metric_regress_model_sum(s) / s.size.to_double() }
}

pub fn ml_metric_regress_model_scale(s : MlmetricregressModel, f : Double) -> MlmetricregressModel {
  let result = ml_metric_regress_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_metric_regress_model_add(a : MlmetricregressModel, b : MlmetricregressModel) -> MlmetricregressModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_metric_regress_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_metric_regress_model_copy(s : MlmetricregressModel) -> MlmetricregressModel {
  let result = ml_metric_regress_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_metric_regress_model_fill(s : MlmetricregressModel, v : Double) -> MlmetricregressModel {
  let result = ml_metric_regress_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_metric_regress_model_min(s : MlmetricregressModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_regress_model_max(s : MlmetricregressModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_regress_model_to_string(s : MlmetricregressModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricregressLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_regress_layer_make(size : Int) -> MlmetricregressLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_regress_layer_len(s : MlmetricregressLayer) -> Int { s.size }

pub fn ml_metric_regress_layer_get(s : MlmetricregressLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_regress_layer_set(s : MlmetricregressLayer, i : Int, v : Double) -> MlmetricregressLayer {
  let result = ml_metric_regress_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_metric_regress_layer_sum(s : MlmetricregressLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_metric_regress_layer_mean(s : MlmetricregressLayer) -> Double {
  if s.size == 0 { 0.0 } else { ml_metric_regress_layer_sum(s) / s.size.to_double() }
}

pub fn ml_metric_regress_layer_scale(s : MlmetricregressLayer, f : Double) -> MlmetricregressLayer {
  let result = ml_metric_regress_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_metric_regress_layer_add(a : MlmetricregressLayer, b : MlmetricregressLayer) -> MlmetricregressLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_metric_regress_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_metric_regress_layer_copy(s : MlmetricregressLayer) -> MlmetricregressLayer {
  let result = ml_metric_regress_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_metric_regress_layer_fill(s : MlmetricregressLayer, v : Double) -> MlmetricregressLayer {
  let result = ml_metric_regress_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_metric_regress_layer_min(s : MlmetricregressLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_regress_layer_max(s : MlmetricregressLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_regress_layer_to_string(s : MlmetricregressLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricregressBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_regress_buffer_make(size : Int) -> MlmetricregressBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_regress_buffer_len(s : MlmetricregressBuffer) -> Int { s.size }

pub fn ml_metric_regress_buffer_get(s : MlmetricregressBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_regress_buffer_set(s : MlmetricregressBuffer, i : Int, v : Double) -> MlmetricregressBuffer {
  let result = ml_metric_regress_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_metric_regress_buffer_sum(s : MlmetricregressBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_metric_regress_buffer_mean(s : MlmetricregressBuffer) -> Double {
  if s.size == 0 { 0.0 } else { ml_metric_regress_buffer_sum(s) / s.size.to_double() }
}

pub fn ml_metric_regress_buffer_scale(s : MlmetricregressBuffer, f : Double) -> MlmetricregressBuffer {
  let result = ml_metric_regress_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_metric_regress_buffer_add(a : MlmetricregressBuffer, b : MlmetricregressBuffer) -> MlmetricregressBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_metric_regress_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_metric_regress_buffer_copy(s : MlmetricregressBuffer) -> MlmetricregressBuffer {
  let result = ml_metric_regress_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_metric_regress_buffer_fill(s : MlmetricregressBuffer, v : Double) -> MlmetricregressBuffer {
  let result = ml_metric_regress_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_metric_regress_buffer_min(s : MlmetricregressBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_regress_buffer_max(s : MlmetricregressBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_regress_buffer_to_string(s : MlmetricregressBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricregressCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_regress_cursor_make(size : Int) -> MlmetricregressCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_regress_cursor_len(s : MlmetricregressCursor) -> Int { s.size }

pub fn ml_metric_regress_cursor_get(s : MlmetricregressCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_regress_cursor_set(s : MlmetricregressCursor, i : Int, v : Double) -> MlmetricregressCursor {
  let result = ml_metric_regress_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_metric_regress_cursor_sum(s : MlmetricregressCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_metric_regress_cursor_mean(s : MlmetricregressCursor) -> Double {
  if s.size == 0 { 0.0 } else { ml_metric_regress_cursor_sum(s) / s.size.to_double() }
}

pub fn ml_metric_regress_cursor_scale(s : MlmetricregressCursor, f : Double) -> MlmetricregressCursor {
  let result = ml_metric_regress_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_metric_regress_cursor_add(a : MlmetricregressCursor, b : MlmetricregressCursor) -> MlmetricregressCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_metric_regress_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_metric_regress_cursor_copy(s : MlmetricregressCursor) -> MlmetricregressCursor {
  let result = ml_metric_regress_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_metric_regress_cursor_fill(s : MlmetricregressCursor, v : Double) -> MlmetricregressCursor {
  let result = ml_metric_regress_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_metric_regress_cursor_min(s : MlmetricregressCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_regress_cursor_max(s : MlmetricregressCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_regress_cursor_to_string(s : MlmetricregressCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricregressView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_regress_view_make(size : Int) -> MlmetricregressView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_regress_view_len(s : MlmetricregressView) -> Int { s.size }

pub fn ml_metric_regress_view_get(s : MlmetricregressView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_regress_view_set(s : MlmetricregressView, i : Int, v : Double) -> MlmetricregressView {
  let result = ml_metric_regress_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_metric_regress_view_sum(s : MlmetricregressView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_metric_regress_view_mean(s : MlmetricregressView) -> Double {
  if s.size == 0 { 0.0 } else { ml_metric_regress_view_sum(s) / s.size.to_double() }
}

pub fn ml_metric_regress_view_scale(s : MlmetricregressView, f : Double) -> MlmetricregressView {
  let result = ml_metric_regress_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_metric_regress_view_add(a : MlmetricregressView, b : MlmetricregressView) -> MlmetricregressView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_metric_regress_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_metric_regress_view_copy(s : MlmetricregressView) -> MlmetricregressView {
  let result = ml_metric_regress_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_metric_regress_view_fill(s : MlmetricregressView, v : Double) -> MlmetricregressView {
  let result = ml_metric_regress_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_metric_regress_view_min(s : MlmetricregressView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_regress_view_max(s : MlmetricregressView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_regress_view_to_string(s : MlmetricregressView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricregressRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_regress_range_make(size : Int) -> MlmetricregressRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_regress_range_len(s : MlmetricregressRange) -> Int { s.size }

pub fn ml_metric_regress_range_get(s : MlmetricregressRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_regress_range_set(s : MlmetricregressRange, i : Int, v : Double) -> MlmetricregressRange {
  let result = ml_metric_regress_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_metric_regress_range_sum(s : MlmetricregressRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_metric_regress_range_mean(s : MlmetricregressRange) -> Double {
  if s.size == 0 { 0.0 } else { ml_metric_regress_range_sum(s) / s.size.to_double() }
}

pub fn ml_metric_regress_range_scale(s : MlmetricregressRange, f : Double) -> MlmetricregressRange {
  let result = ml_metric_regress_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_metric_regress_range_add(a : MlmetricregressRange, b : MlmetricregressRange) -> MlmetricregressRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_metric_regress_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_metric_regress_range_copy(s : MlmetricregressRange) -> MlmetricregressRange {
  let result = ml_metric_regress_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_metric_regress_range_fill(s : MlmetricregressRange, v : Double) -> MlmetricregressRange {
  let result = ml_metric_regress_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_metric_regress_range_min(s : MlmetricregressRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_regress_range_max(s : MlmetricregressRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_regress_range_to_string(s : MlmetricregressRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricregressSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_regress_slice_make(size : Int) -> MlmetricregressSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_regress_slice_len(s : MlmetricregressSlice) -> Int { s.size }

pub fn ml_metric_regress_slice_get(s : MlmetricregressSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_regress_slice_set(s : MlmetricregressSlice, i : Int, v : Double) -> MlmetricregressSlice {
  let result = ml_metric_regress_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_metric_regress_slice_sum(s : MlmetricregressSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_metric_regress_slice_mean(s : MlmetricregressSlice) -> Double {
  if s.size == 0 { 0.0 } else { ml_metric_regress_slice_sum(s) / s.size.to_double() }
}

pub fn ml_metric_regress_slice_scale(s : MlmetricregressSlice, f : Double) -> MlmetricregressSlice {
  let result = ml_metric_regress_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_metric_regress_slice_add(a : MlmetricregressSlice, b : MlmetricregressSlice) -> MlmetricregressSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_metric_regress_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_metric_regress_slice_copy(s : MlmetricregressSlice) -> MlmetricregressSlice {
  let result = ml_metric_regress_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_metric_regress_slice_fill(s : MlmetricregressSlice, v : Double) -> MlmetricregressSlice {
  let result = ml_metric_regress_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_metric_regress_slice_min(s : MlmetricregressSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_regress_slice_max(s : MlmetricregressSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_regress_slice_to_string(s : MlmetricregressSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

