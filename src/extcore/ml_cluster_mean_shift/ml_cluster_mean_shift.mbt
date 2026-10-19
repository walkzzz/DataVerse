///===
/// extcore/ml_cluster_mean_shift

pub(all) struct MlclustermeanshiftPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_cluster_mean_shift_make_point(x : Double, y : Double) -> MlclustermeanshiftPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_cluster_mean_shift_make_point3(x : Double, y : Double, z : Double) -> MlclustermeanshiftPoint {
  { x, y, z, label: 0 }
}

pub fn ml_cluster_mean_shift_point_x(pt : MlclustermeanshiftPoint) -> Double { pt.x }

pub fn ml_cluster_mean_shift_point_y(pt : MlclustermeanshiftPoint) -> Double { pt.y }

pub fn ml_cluster_mean_shift_point_z(pt : MlclustermeanshiftPoint) -> Double { pt.z }

pub fn ml_cluster_mean_shift_point_label(pt : MlclustermeanshiftPoint) -> Int { pt.label }

pub fn ml_cluster_mean_shift_point_dist(a : MlclustermeanshiftPoint, b : MlclustermeanshiftPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ml_cluster_mean_shift_point_add(a : MlclustermeanshiftPoint, b : MlclustermeanshiftPoint) -> MlclustermeanshiftPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn ml_cluster_mean_shift_point_sub(a : MlclustermeanshiftPoint, b : MlclustermeanshiftPoint) -> MlclustermeanshiftPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn ml_cluster_mean_shift_point_scale(pt : MlclustermeanshiftPoint, s : Double) -> MlclustermeanshiftPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn ml_cluster_mean_shift_point_dot(a : MlclustermeanshiftPoint, b : MlclustermeanshiftPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn ml_cluster_mean_shift_point_cross(a : MlclustermeanshiftPoint, b : MlclustermeanshiftPoint) -> MlclustermeanshiftPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn ml_cluster_mean_shift_point_norm(pt : MlclustermeanshiftPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn ml_cluster_mean_shift_point_normalize(pt : MlclustermeanshiftPoint) -> MlclustermeanshiftPoint {
  let n = ml_cluster_mean_shift_point_norm(pt)
  if n < 0.0000001 { pt } else { ml_cluster_mean_shift_point_scale(pt, 1.0 / n) }
}

pub fn ml_cluster_mean_shift_point_negate(pt : MlclustermeanshiftPoint) -> MlclustermeanshiftPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn ml_cluster_mean_shift_point_mid(a : MlclustermeanshiftPoint, b : MlclustermeanshiftPoint) -> MlclustermeanshiftPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn ml_cluster_mean_shift_point_lerp(a : MlclustermeanshiftPoint, b : MlclustermeanshiftPoint, t : Double) -> MlclustermeanshiftPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn ml_cluster_mean_shift_point_to_string(pt : MlclustermeanshiftPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct MlclustermeanshiftSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_cluster_mean_shift_make_series(vals : Array[Double], name : String) -> MlclustermeanshiftSeries {
  { vals, name, meta: 0 }
}

pub fn ml_cluster_mean_shift_series_len(s : MlclustermeanshiftSeries) -> Int { s.vals.length() }

pub fn ml_cluster_mean_shift_series_sum(s : MlclustermeanshiftSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn ml_cluster_mean_shift_series_mean(s : MlclustermeanshiftSeries) -> Double {
  let n = ml_cluster_mean_shift_series_len(s)
  if n == 0 { 0.0 } else { ml_cluster_mean_shift_series_sum(s) / n.to_double() }
}

pub fn ml_cluster_mean_shift_series_min(s : MlclustermeanshiftSeries) -> Double {
  let n = ml_cluster_mean_shift_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn ml_cluster_mean_shift_series_max(s : MlclustermeanshiftSeries) -> Double {
  let n = ml_cluster_mean_shift_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn ml_cluster_mean_shift_series_range(s : MlclustermeanshiftSeries) -> Double {
  ml_cluster_mean_shift_series_max(s) - ml_cluster_mean_shift_series_min(s)
}

pub fn ml_cluster_mean_shift_series_var(s : MlclustermeanshiftSeries) -> Double {
  let n = ml_cluster_mean_shift_series_len(s)
  if n == 0 { 0.0 } else {
    let m = ml_cluster_mean_shift_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn ml_cluster_mean_shift_series_std(s : MlclustermeanshiftSeries) -> Double { @_common.sqrt(ml_cluster_mean_shift_series_var(s)) }

pub fn ml_cluster_mean_shift_series_median(s : MlclustermeanshiftSeries) -> Double {
  let n = ml_cluster_mean_shift_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = ml_cluster_mean_shift_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn ml_cluster_mean_shift_series_scale(s : MlclustermeanshiftSeries, f : Double) -> MlclustermeanshiftSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn ml_cluster_mean_shift_series_add(a : MlclustermeanshiftSeries, b : MlclustermeanshiftSeries) -> MlclustermeanshiftSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn ml_cluster_mean_shift_series_sub(a : MlclustermeanshiftSeries, b : MlclustermeanshiftSeries) -> MlclustermeanshiftSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn ml_cluster_mean_shift_series_normalize(s : MlclustermeanshiftSeries) -> MlclustermeanshiftSeries {
  let mn = ml_cluster_mean_shift_series_min(s)
  let mx = ml_cluster_mean_shift_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn ml_cluster_mean_shift_series_cumsum(s : MlclustermeanshiftSeries) -> MlclustermeanshiftSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn ml_cluster_mean_shift_series_to_string(s : MlclustermeanshiftSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlclustermeanshiftMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_cluster_mean_shift_make_matrix(rows : Int, cols : Int, val : Double) -> MlclustermeanshiftMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_cluster_mean_shift_matrix_identity(n : Int) -> MlclustermeanshiftMatrix {
  let m = ml_cluster_mean_shift_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ml_cluster_mean_shift_matrix_get(m : MlclustermeanshiftMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn ml_cluster_mean_shift_matrix_transpose(m : MlclustermeanshiftMatrix) -> MlclustermeanshiftMatrix {
  let result = ml_cluster_mean_shift_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn ml_cluster_mean_shift_matrix_add(a : MlclustermeanshiftMatrix, b : MlclustermeanshiftMatrix) -> MlclustermeanshiftMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = ml_cluster_mean_shift_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn ml_cluster_mean_shift_matrix_scale(m : MlclustermeanshiftMatrix, s : Double) -> MlclustermeanshiftMatrix {
  let result = ml_cluster_mean_shift_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn ml_cluster_mean_shift_matrix_multiply(a : MlclustermeanshiftMatrix, b : MlclustermeanshiftMatrix) -> MlclustermeanshiftMatrix {
  if a.cols != b.rows { return ml_cluster_mean_shift_make_matrix(a.rows, b.cols, 0.0) }
  let result = ml_cluster_mean_shift_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ml_cluster_mean_shift_matrix_trace(m : MlclustermeanshiftMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn ml_cluster_mean_shift_matrix_det(m : MlclustermeanshiftMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ml_cluster_mean_shift_matrix_norm(m : MlclustermeanshiftMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ml_cluster_mean_shift_matrix_to_string(m : MlclustermeanshiftMatrix) -> String {
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

pub(all) struct MlclustermeanshiftVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_cluster_mean_shift_make_vector(comps : Array[Double]) -> MlclustermeanshiftVector {
  { comps, dim: comps.length() }
}

pub fn ml_cluster_mean_shift_vector_zero(dim : Int) -> MlclustermeanshiftVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ml_cluster_mean_shift_vector_add(a : MlclustermeanshiftVector, b : MlclustermeanshiftVector) -> MlclustermeanshiftVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ml_cluster_mean_shift_vector_sub(a : MlclustermeanshiftVector, b : MlclustermeanshiftVector) -> MlclustermeanshiftVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ml_cluster_mean_shift_vector_scale(v : MlclustermeanshiftVector, s : Double) -> MlclustermeanshiftVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn ml_cluster_mean_shift_vector_dot(a : MlclustermeanshiftVector, b : MlclustermeanshiftVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn ml_cluster_mean_shift_vector_norm(v : MlclustermeanshiftVector) -> Double { @_common.sqrt(ml_cluster_mean_shift_vector_dot(v, v)) }

pub fn ml_cluster_mean_shift_vector_normalize(v : MlclustermeanshiftVector) -> MlclustermeanshiftVector {
  let n = ml_cluster_mean_shift_vector_norm(v)
  if n < 0.0000001 { v } else { ml_cluster_mean_shift_vector_scale(v, 1.0 / n) }
}

pub fn ml_cluster_mean_shift_vector_dist(a : MlclustermeanshiftVector, b : MlclustermeanshiftVector) -> Double {
  ml_cluster_mean_shift_vector_norm(ml_cluster_mean_shift_vector_sub(a, b))
}

pub fn ml_cluster_mean_shift_vector_to_string(v : MlclustermeanshiftVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ml_cluster_mean_shift_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn ml_cluster_mean_shift_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = ml_cluster_mean_shift_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn ml_cluster_mean_shift_std(data : Array[Double]) -> Double { @_common.sqrt(ml_cluster_mean_shift_var(data)) }

pub fn ml_cluster_mean_shift_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = ml_cluster_mean_shift_mean(a); let mb = ml_cluster_mean_shift_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn ml_cluster_mean_shift_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = ml_cluster_mean_shift_std(a); let sb = ml_cluster_mean_shift_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { ml_cluster_mean_shift_cov(a, b) / (sa * sb) }
}

pub fn ml_cluster_mean_shift_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = ml_cluster_mean_shift_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn ml_cluster_mean_shift_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn ml_cluster_mean_shift_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn ml_cluster_mean_shift_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  @_common.sqrt(ml_cluster_mean_shift_mse(pred, labels))
}

pub fn ml_cluster_mean_shift_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn ml_cluster_mean_shift_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = ml_cluster_mean_shift_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn ml_cluster_mean_shift_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn ml_cluster_mean_shift_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn ml_cluster_mean_shift_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = ml_cluster_mean_shift_precision(pred, labels, pos); let r = ml_cluster_mean_shift_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn ml_cluster_mean_shift_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn ml_cluster_mean_shift_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = ml_cluster_mean_shift_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn ml_cluster_mean_shift_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn ml_cluster_mean_shift_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn ml_cluster_mean_shift_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = ml_cluster_mean_shift_gcd(a, b)
    (a / g) * b
  }
}

pub fn ml_cluster_mean_shift_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn ml_cluster_mean_shift_fibonacci(n : Int) -> Int {
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

pub fn ml_cluster_mean_shift_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = ml_cluster_mean_shift_min(data); let mx = ml_cluster_mean_shift_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn ml_cluster_mean_shift_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = ml_cluster_mean_shift_mean(data); let sd = ml_cluster_mean_shift_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn ml_cluster_mean_shift_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn ml_cluster_mean_shift_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn ml_cluster_mean_shift_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn ml_cluster_mean_shift_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn ml_cluster_mean_shift_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn ml_cluster_mean_shift_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

pub(all) struct MlclustermeanshiftFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_mean_shift_frame_make(size : Int) -> MlclustermeanshiftFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_mean_shift_frame_len(s : MlclustermeanshiftFrame) -> Int { s.size }

pub fn ml_cluster_mean_shift_frame_get(s : MlclustermeanshiftFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_mean_shift_frame_set(s : MlclustermeanshiftFrame, i : Int, v : Double) -> MlclustermeanshiftFrame {
  let result = ml_cluster_mean_shift_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_mean_shift_frame_sum(s : MlclustermeanshiftFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_cluster_mean_shift_frame_mean(s : MlclustermeanshiftFrame) -> Double {
  if s.size == 0 { 0.0 } else { ml_cluster_mean_shift_frame_sum(s) / s.size.to_double() }
}

pub fn ml_cluster_mean_shift_frame_scale(s : MlclustermeanshiftFrame, f : Double) -> MlclustermeanshiftFrame {
  let result = ml_cluster_mean_shift_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_cluster_mean_shift_frame_add(a : MlclustermeanshiftFrame, b : MlclustermeanshiftFrame) -> MlclustermeanshiftFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_cluster_mean_shift_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_cluster_mean_shift_frame_copy(s : MlclustermeanshiftFrame) -> MlclustermeanshiftFrame {
  let result = ml_cluster_mean_shift_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_cluster_mean_shift_frame_fill(s : MlclustermeanshiftFrame, v : Double) -> MlclustermeanshiftFrame {
  let result = ml_cluster_mean_shift_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_mean_shift_frame_min(s : MlclustermeanshiftFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_mean_shift_frame_max(s : MlclustermeanshiftFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_mean_shift_frame_to_string(s : MlclustermeanshiftFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclustermeanshiftTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_mean_shift_table_make(size : Int) -> MlclustermeanshiftTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_mean_shift_table_len(s : MlclustermeanshiftTable) -> Int { s.size }

pub fn ml_cluster_mean_shift_table_get(s : MlclustermeanshiftTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_mean_shift_table_set(s : MlclustermeanshiftTable, i : Int, v : Double) -> MlclustermeanshiftTable {
  let result = ml_cluster_mean_shift_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_mean_shift_table_sum(s : MlclustermeanshiftTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_cluster_mean_shift_table_mean(s : MlclustermeanshiftTable) -> Double {
  if s.size == 0 { 0.0 } else { ml_cluster_mean_shift_table_sum(s) / s.size.to_double() }
}

pub fn ml_cluster_mean_shift_table_scale(s : MlclustermeanshiftTable, f : Double) -> MlclustermeanshiftTable {
  let result = ml_cluster_mean_shift_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_cluster_mean_shift_table_add(a : MlclustermeanshiftTable, b : MlclustermeanshiftTable) -> MlclustermeanshiftTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_cluster_mean_shift_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_cluster_mean_shift_table_copy(s : MlclustermeanshiftTable) -> MlclustermeanshiftTable {
  let result = ml_cluster_mean_shift_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_cluster_mean_shift_table_fill(s : MlclustermeanshiftTable, v : Double) -> MlclustermeanshiftTable {
  let result = ml_cluster_mean_shift_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_mean_shift_table_min(s : MlclustermeanshiftTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_mean_shift_table_max(s : MlclustermeanshiftTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_mean_shift_table_to_string(s : MlclustermeanshiftTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclustermeanshiftGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_mean_shift_graphn_make(size : Int) -> MlclustermeanshiftGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_mean_shift_graphn_len(s : MlclustermeanshiftGraphN) -> Int { s.size }

pub fn ml_cluster_mean_shift_graphn_get(s : MlclustermeanshiftGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_mean_shift_graphn_set(s : MlclustermeanshiftGraphN, i : Int, v : Double) -> MlclustermeanshiftGraphN {
  let result = ml_cluster_mean_shift_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_mean_shift_graphn_sum(s : MlclustermeanshiftGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_cluster_mean_shift_graphn_mean(s : MlclustermeanshiftGraphN) -> Double {
  if s.size == 0 { 0.0 } else { ml_cluster_mean_shift_graphn_sum(s) / s.size.to_double() }
}

pub fn ml_cluster_mean_shift_graphn_scale(s : MlclustermeanshiftGraphN, f : Double) -> MlclustermeanshiftGraphN {
  let result = ml_cluster_mean_shift_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_cluster_mean_shift_graphn_add(a : MlclustermeanshiftGraphN, b : MlclustermeanshiftGraphN) -> MlclustermeanshiftGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_cluster_mean_shift_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_cluster_mean_shift_graphn_copy(s : MlclustermeanshiftGraphN) -> MlclustermeanshiftGraphN {
  let result = ml_cluster_mean_shift_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_cluster_mean_shift_graphn_fill(s : MlclustermeanshiftGraphN, v : Double) -> MlclustermeanshiftGraphN {
  let result = ml_cluster_mean_shift_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_mean_shift_graphn_min(s : MlclustermeanshiftGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_mean_shift_graphn_max(s : MlclustermeanshiftGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_mean_shift_graphn_to_string(s : MlclustermeanshiftGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclustermeanshiftNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_mean_shift_node_make(size : Int) -> MlclustermeanshiftNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_mean_shift_node_len(s : MlclustermeanshiftNode) -> Int { s.size }

pub fn ml_cluster_mean_shift_node_get(s : MlclustermeanshiftNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_mean_shift_node_set(s : MlclustermeanshiftNode, i : Int, v : Double) -> MlclustermeanshiftNode {
  let result = ml_cluster_mean_shift_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_mean_shift_node_sum(s : MlclustermeanshiftNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_cluster_mean_shift_node_mean(s : MlclustermeanshiftNode) -> Double {
  if s.size == 0 { 0.0 } else { ml_cluster_mean_shift_node_sum(s) / s.size.to_double() }
}

pub fn ml_cluster_mean_shift_node_scale(s : MlclustermeanshiftNode, f : Double) -> MlclustermeanshiftNode {
  let result = ml_cluster_mean_shift_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_cluster_mean_shift_node_add(a : MlclustermeanshiftNode, b : MlclustermeanshiftNode) -> MlclustermeanshiftNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_cluster_mean_shift_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_cluster_mean_shift_node_copy(s : MlclustermeanshiftNode) -> MlclustermeanshiftNode {
  let result = ml_cluster_mean_shift_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_cluster_mean_shift_node_fill(s : MlclustermeanshiftNode, v : Double) -> MlclustermeanshiftNode {
  let result = ml_cluster_mean_shift_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_mean_shift_node_min(s : MlclustermeanshiftNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_mean_shift_node_max(s : MlclustermeanshiftNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_mean_shift_node_to_string(s : MlclustermeanshiftNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclustermeanshiftEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_mean_shift_edge_make(size : Int) -> MlclustermeanshiftEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_mean_shift_edge_len(s : MlclustermeanshiftEdge) -> Int { s.size }

pub fn ml_cluster_mean_shift_edge_get(s : MlclustermeanshiftEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_mean_shift_edge_set(s : MlclustermeanshiftEdge, i : Int, v : Double) -> MlclustermeanshiftEdge {
  let result = ml_cluster_mean_shift_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_mean_shift_edge_sum(s : MlclustermeanshiftEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_cluster_mean_shift_edge_mean(s : MlclustermeanshiftEdge) -> Double {
  if s.size == 0 { 0.0 } else { ml_cluster_mean_shift_edge_sum(s) / s.size.to_double() }
}

pub fn ml_cluster_mean_shift_edge_scale(s : MlclustermeanshiftEdge, f : Double) -> MlclustermeanshiftEdge {
  let result = ml_cluster_mean_shift_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_cluster_mean_shift_edge_add(a : MlclustermeanshiftEdge, b : MlclustermeanshiftEdge) -> MlclustermeanshiftEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_cluster_mean_shift_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_cluster_mean_shift_edge_copy(s : MlclustermeanshiftEdge) -> MlclustermeanshiftEdge {
  let result = ml_cluster_mean_shift_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_cluster_mean_shift_edge_fill(s : MlclustermeanshiftEdge, v : Double) -> MlclustermeanshiftEdge {
  let result = ml_cluster_mean_shift_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_mean_shift_edge_min(s : MlclustermeanshiftEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_mean_shift_edge_max(s : MlclustermeanshiftEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_mean_shift_edge_to_string(s : MlclustermeanshiftEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclustermeanshiftPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_mean_shift_path_make(size : Int) -> MlclustermeanshiftPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_mean_shift_path_len(s : MlclustermeanshiftPath) -> Int { s.size }

pub fn ml_cluster_mean_shift_path_get(s : MlclustermeanshiftPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_mean_shift_path_set(s : MlclustermeanshiftPath, i : Int, v : Double) -> MlclustermeanshiftPath {
  let result = ml_cluster_mean_shift_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_mean_shift_path_sum(s : MlclustermeanshiftPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_cluster_mean_shift_path_mean(s : MlclustermeanshiftPath) -> Double {
  if s.size == 0 { 0.0 } else { ml_cluster_mean_shift_path_sum(s) / s.size.to_double() }
}

pub fn ml_cluster_mean_shift_path_scale(s : MlclustermeanshiftPath, f : Double) -> MlclustermeanshiftPath {
  let result = ml_cluster_mean_shift_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_cluster_mean_shift_path_add(a : MlclustermeanshiftPath, b : MlclustermeanshiftPath) -> MlclustermeanshiftPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_cluster_mean_shift_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_cluster_mean_shift_path_copy(s : MlclustermeanshiftPath) -> MlclustermeanshiftPath {
  let result = ml_cluster_mean_shift_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_cluster_mean_shift_path_fill(s : MlclustermeanshiftPath, v : Double) -> MlclustermeanshiftPath {
  let result = ml_cluster_mean_shift_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_mean_shift_path_min(s : MlclustermeanshiftPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_mean_shift_path_max(s : MlclustermeanshiftPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_mean_shift_path_to_string(s : MlclustermeanshiftPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclustermeanshiftCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_mean_shift_cluster_make(size : Int) -> MlclustermeanshiftCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_mean_shift_cluster_len(s : MlclustermeanshiftCluster) -> Int { s.size }

pub fn ml_cluster_mean_shift_cluster_get(s : MlclustermeanshiftCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_mean_shift_cluster_set(s : MlclustermeanshiftCluster, i : Int, v : Double) -> MlclustermeanshiftCluster {
  let result = ml_cluster_mean_shift_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_mean_shift_cluster_sum(s : MlclustermeanshiftCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_cluster_mean_shift_cluster_mean(s : MlclustermeanshiftCluster) -> Double {
  if s.size == 0 { 0.0 } else { ml_cluster_mean_shift_cluster_sum(s) / s.size.to_double() }
}

pub fn ml_cluster_mean_shift_cluster_scale(s : MlclustermeanshiftCluster, f : Double) -> MlclustermeanshiftCluster {
  let result = ml_cluster_mean_shift_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_cluster_mean_shift_cluster_add(a : MlclustermeanshiftCluster, b : MlclustermeanshiftCluster) -> MlclustermeanshiftCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_cluster_mean_shift_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_cluster_mean_shift_cluster_copy(s : MlclustermeanshiftCluster) -> MlclustermeanshiftCluster {
  let result = ml_cluster_mean_shift_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_cluster_mean_shift_cluster_fill(s : MlclustermeanshiftCluster, v : Double) -> MlclustermeanshiftCluster {
  let result = ml_cluster_mean_shift_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_mean_shift_cluster_min(s : MlclustermeanshiftCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_mean_shift_cluster_max(s : MlclustermeanshiftCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_mean_shift_cluster_to_string(s : MlclustermeanshiftCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclustermeanshiftModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_mean_shift_model_make(size : Int) -> MlclustermeanshiftModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_mean_shift_model_len(s : MlclustermeanshiftModel) -> Int { s.size }

pub fn ml_cluster_mean_shift_model_get(s : MlclustermeanshiftModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_mean_shift_model_set(s : MlclustermeanshiftModel, i : Int, v : Double) -> MlclustermeanshiftModel {
  let result = ml_cluster_mean_shift_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_mean_shift_model_sum(s : MlclustermeanshiftModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_cluster_mean_shift_model_mean(s : MlclustermeanshiftModel) -> Double {
  if s.size == 0 { 0.0 } else { ml_cluster_mean_shift_model_sum(s) / s.size.to_double() }
}

pub fn ml_cluster_mean_shift_model_scale(s : MlclustermeanshiftModel, f : Double) -> MlclustermeanshiftModel {
  let result = ml_cluster_mean_shift_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_cluster_mean_shift_model_add(a : MlclustermeanshiftModel, b : MlclustermeanshiftModel) -> MlclustermeanshiftModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_cluster_mean_shift_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_cluster_mean_shift_model_copy(s : MlclustermeanshiftModel) -> MlclustermeanshiftModel {
  let result = ml_cluster_mean_shift_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_cluster_mean_shift_model_fill(s : MlclustermeanshiftModel, v : Double) -> MlclustermeanshiftModel {
  let result = ml_cluster_mean_shift_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_mean_shift_model_min(s : MlclustermeanshiftModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_mean_shift_model_max(s : MlclustermeanshiftModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_mean_shift_model_to_string(s : MlclustermeanshiftModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclustermeanshiftLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_mean_shift_layer_make(size : Int) -> MlclustermeanshiftLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_mean_shift_layer_len(s : MlclustermeanshiftLayer) -> Int { s.size }

pub fn ml_cluster_mean_shift_layer_get(s : MlclustermeanshiftLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_mean_shift_layer_set(s : MlclustermeanshiftLayer, i : Int, v : Double) -> MlclustermeanshiftLayer {
  let result = ml_cluster_mean_shift_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_mean_shift_layer_sum(s : MlclustermeanshiftLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_cluster_mean_shift_layer_mean(s : MlclustermeanshiftLayer) -> Double {
  if s.size == 0 { 0.0 } else { ml_cluster_mean_shift_layer_sum(s) / s.size.to_double() }
}

pub fn ml_cluster_mean_shift_layer_scale(s : MlclustermeanshiftLayer, f : Double) -> MlclustermeanshiftLayer {
  let result = ml_cluster_mean_shift_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_cluster_mean_shift_layer_add(a : MlclustermeanshiftLayer, b : MlclustermeanshiftLayer) -> MlclustermeanshiftLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_cluster_mean_shift_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_cluster_mean_shift_layer_copy(s : MlclustermeanshiftLayer) -> MlclustermeanshiftLayer {
  let result = ml_cluster_mean_shift_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_cluster_mean_shift_layer_fill(s : MlclustermeanshiftLayer, v : Double) -> MlclustermeanshiftLayer {
  let result = ml_cluster_mean_shift_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_mean_shift_layer_min(s : MlclustermeanshiftLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_mean_shift_layer_max(s : MlclustermeanshiftLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_mean_shift_layer_to_string(s : MlclustermeanshiftLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclustermeanshiftBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_mean_shift_buffer_make(size : Int) -> MlclustermeanshiftBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_mean_shift_buffer_len(s : MlclustermeanshiftBuffer) -> Int { s.size }

pub fn ml_cluster_mean_shift_buffer_get(s : MlclustermeanshiftBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_mean_shift_buffer_set(s : MlclustermeanshiftBuffer, i : Int, v : Double) -> MlclustermeanshiftBuffer {
  let result = ml_cluster_mean_shift_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_mean_shift_buffer_sum(s : MlclustermeanshiftBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_cluster_mean_shift_buffer_mean(s : MlclustermeanshiftBuffer) -> Double {
  if s.size == 0 { 0.0 } else { ml_cluster_mean_shift_buffer_sum(s) / s.size.to_double() }
}

pub fn ml_cluster_mean_shift_buffer_scale(s : MlclustermeanshiftBuffer, f : Double) -> MlclustermeanshiftBuffer {
  let result = ml_cluster_mean_shift_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_cluster_mean_shift_buffer_add(a : MlclustermeanshiftBuffer, b : MlclustermeanshiftBuffer) -> MlclustermeanshiftBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_cluster_mean_shift_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_cluster_mean_shift_buffer_copy(s : MlclustermeanshiftBuffer) -> MlclustermeanshiftBuffer {
  let result = ml_cluster_mean_shift_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_cluster_mean_shift_buffer_fill(s : MlclustermeanshiftBuffer, v : Double) -> MlclustermeanshiftBuffer {
  let result = ml_cluster_mean_shift_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_mean_shift_buffer_min(s : MlclustermeanshiftBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_mean_shift_buffer_max(s : MlclustermeanshiftBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_mean_shift_buffer_to_string(s : MlclustermeanshiftBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclustermeanshiftCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_mean_shift_cursor_make(size : Int) -> MlclustermeanshiftCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_mean_shift_cursor_len(s : MlclustermeanshiftCursor) -> Int { s.size }

pub fn ml_cluster_mean_shift_cursor_get(s : MlclustermeanshiftCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_mean_shift_cursor_set(s : MlclustermeanshiftCursor, i : Int, v : Double) -> MlclustermeanshiftCursor {
  let result = ml_cluster_mean_shift_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_mean_shift_cursor_sum(s : MlclustermeanshiftCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_cluster_mean_shift_cursor_mean(s : MlclustermeanshiftCursor) -> Double {
  if s.size == 0 { 0.0 } else { ml_cluster_mean_shift_cursor_sum(s) / s.size.to_double() }
}

pub fn ml_cluster_mean_shift_cursor_scale(s : MlclustermeanshiftCursor, f : Double) -> MlclustermeanshiftCursor {
  let result = ml_cluster_mean_shift_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_cluster_mean_shift_cursor_add(a : MlclustermeanshiftCursor, b : MlclustermeanshiftCursor) -> MlclustermeanshiftCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_cluster_mean_shift_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_cluster_mean_shift_cursor_copy(s : MlclustermeanshiftCursor) -> MlclustermeanshiftCursor {
  let result = ml_cluster_mean_shift_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_cluster_mean_shift_cursor_fill(s : MlclustermeanshiftCursor, v : Double) -> MlclustermeanshiftCursor {
  let result = ml_cluster_mean_shift_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_mean_shift_cursor_min(s : MlclustermeanshiftCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_mean_shift_cursor_max(s : MlclustermeanshiftCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_mean_shift_cursor_to_string(s : MlclustermeanshiftCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclustermeanshiftView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_mean_shift_view_make(size : Int) -> MlclustermeanshiftView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_mean_shift_view_len(s : MlclustermeanshiftView) -> Int { s.size }

pub fn ml_cluster_mean_shift_view_get(s : MlclustermeanshiftView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_mean_shift_view_set(s : MlclustermeanshiftView, i : Int, v : Double) -> MlclustermeanshiftView {
  let result = ml_cluster_mean_shift_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_mean_shift_view_sum(s : MlclustermeanshiftView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_cluster_mean_shift_view_mean(s : MlclustermeanshiftView) -> Double {
  if s.size == 0 { 0.0 } else { ml_cluster_mean_shift_view_sum(s) / s.size.to_double() }
}

pub fn ml_cluster_mean_shift_view_scale(s : MlclustermeanshiftView, f : Double) -> MlclustermeanshiftView {
  let result = ml_cluster_mean_shift_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_cluster_mean_shift_view_add(a : MlclustermeanshiftView, b : MlclustermeanshiftView) -> MlclustermeanshiftView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_cluster_mean_shift_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_cluster_mean_shift_view_copy(s : MlclustermeanshiftView) -> MlclustermeanshiftView {
  let result = ml_cluster_mean_shift_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_cluster_mean_shift_view_fill(s : MlclustermeanshiftView, v : Double) -> MlclustermeanshiftView {
  let result = ml_cluster_mean_shift_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_mean_shift_view_min(s : MlclustermeanshiftView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_mean_shift_view_max(s : MlclustermeanshiftView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_mean_shift_view_to_string(s : MlclustermeanshiftView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclustermeanshiftRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_mean_shift_range_make(size : Int) -> MlclustermeanshiftRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_mean_shift_range_len(s : MlclustermeanshiftRange) -> Int { s.size }

pub fn ml_cluster_mean_shift_range_get(s : MlclustermeanshiftRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_mean_shift_range_set(s : MlclustermeanshiftRange, i : Int, v : Double) -> MlclustermeanshiftRange {
  let result = ml_cluster_mean_shift_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_mean_shift_range_sum(s : MlclustermeanshiftRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_cluster_mean_shift_range_mean(s : MlclustermeanshiftRange) -> Double {
  if s.size == 0 { 0.0 } else { ml_cluster_mean_shift_range_sum(s) / s.size.to_double() }
}

pub fn ml_cluster_mean_shift_range_scale(s : MlclustermeanshiftRange, f : Double) -> MlclustermeanshiftRange {
  let result = ml_cluster_mean_shift_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_cluster_mean_shift_range_add(a : MlclustermeanshiftRange, b : MlclustermeanshiftRange) -> MlclustermeanshiftRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_cluster_mean_shift_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_cluster_mean_shift_range_copy(s : MlclustermeanshiftRange) -> MlclustermeanshiftRange {
  let result = ml_cluster_mean_shift_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_cluster_mean_shift_range_fill(s : MlclustermeanshiftRange, v : Double) -> MlclustermeanshiftRange {
  let result = ml_cluster_mean_shift_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_mean_shift_range_min(s : MlclustermeanshiftRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_mean_shift_range_max(s : MlclustermeanshiftRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_mean_shift_range_to_string(s : MlclustermeanshiftRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclustermeanshiftSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_mean_shift_slice_make(size : Int) -> MlclustermeanshiftSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_mean_shift_slice_len(s : MlclustermeanshiftSlice) -> Int { s.size }

pub fn ml_cluster_mean_shift_slice_get(s : MlclustermeanshiftSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_mean_shift_slice_set(s : MlclustermeanshiftSlice, i : Int, v : Double) -> MlclustermeanshiftSlice {
  let result = ml_cluster_mean_shift_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_mean_shift_slice_sum(s : MlclustermeanshiftSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_cluster_mean_shift_slice_mean(s : MlclustermeanshiftSlice) -> Double {
  if s.size == 0 { 0.0 } else { ml_cluster_mean_shift_slice_sum(s) / s.size.to_double() }
}

pub fn ml_cluster_mean_shift_slice_scale(s : MlclustermeanshiftSlice, f : Double) -> MlclustermeanshiftSlice {
  let result = ml_cluster_mean_shift_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_cluster_mean_shift_slice_add(a : MlclustermeanshiftSlice, b : MlclustermeanshiftSlice) -> MlclustermeanshiftSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_cluster_mean_shift_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_cluster_mean_shift_slice_copy(s : MlclustermeanshiftSlice) -> MlclustermeanshiftSlice {
  let result = ml_cluster_mean_shift_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_cluster_mean_shift_slice_fill(s : MlclustermeanshiftSlice, v : Double) -> MlclustermeanshiftSlice {
  let result = ml_cluster_mean_shift_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_mean_shift_slice_min(s : MlclustermeanshiftSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_mean_shift_slice_max(s : MlclustermeanshiftSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_mean_shift_slice_to_string(s : MlclustermeanshiftSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

