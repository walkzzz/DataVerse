///===
/// extcore/ml_cluster_dbscan

pub(all) struct MlclusterdbscanPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_cluster_dbscan_make_point(x : Double, y : Double) -> MlclusterdbscanPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_cluster_dbscan_make_point3(x : Double, y : Double, z : Double) -> MlclusterdbscanPoint {
  { x, y, z, label: 0 }
}

pub fn ml_cluster_dbscan_point_x(pt : MlclusterdbscanPoint) -> Double { pt.x }

pub fn ml_cluster_dbscan_point_y(pt : MlclusterdbscanPoint) -> Double { pt.y }

pub fn ml_cluster_dbscan_point_z(pt : MlclusterdbscanPoint) -> Double { pt.z }

pub fn ml_cluster_dbscan_point_label(pt : MlclusterdbscanPoint) -> Int { pt.label }

pub fn ml_cluster_dbscan_point_dist(a : MlclusterdbscanPoint, b : MlclusterdbscanPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ml_cluster_dbscan_point_add(a : MlclusterdbscanPoint, b : MlclusterdbscanPoint) -> MlclusterdbscanPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn ml_cluster_dbscan_point_sub(a : MlclusterdbscanPoint, b : MlclusterdbscanPoint) -> MlclusterdbscanPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn ml_cluster_dbscan_point_scale(pt : MlclusterdbscanPoint, s : Double) -> MlclusterdbscanPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn ml_cluster_dbscan_point_dot(a : MlclusterdbscanPoint, b : MlclusterdbscanPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn ml_cluster_dbscan_point_cross(a : MlclusterdbscanPoint, b : MlclusterdbscanPoint) -> MlclusterdbscanPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn ml_cluster_dbscan_point_norm(pt : MlclusterdbscanPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn ml_cluster_dbscan_point_normalize(pt : MlclusterdbscanPoint) -> MlclusterdbscanPoint {
  let n = ml_cluster_dbscan_point_norm(pt)
  if n < 0.0000001 { pt } else { ml_cluster_dbscan_point_scale(pt, 1.0 / n) }
}

pub fn ml_cluster_dbscan_point_negate(pt : MlclusterdbscanPoint) -> MlclusterdbscanPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn ml_cluster_dbscan_point_mid(a : MlclusterdbscanPoint, b : MlclusterdbscanPoint) -> MlclusterdbscanPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn ml_cluster_dbscan_point_lerp(a : MlclusterdbscanPoint, b : MlclusterdbscanPoint, t : Double) -> MlclusterdbscanPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn ml_cluster_dbscan_point_to_string(pt : MlclusterdbscanPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct MlclusterdbscanSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_cluster_dbscan_make_series(vals : Array[Double], name : String) -> MlclusterdbscanSeries {
  { vals, name, meta: 0 }
}

pub fn ml_cluster_dbscan_series_len(s : MlclusterdbscanSeries) -> Int { s.vals.length() }

pub fn ml_cluster_dbscan_series_sum(s : MlclusterdbscanSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn ml_cluster_dbscan_series_mean(s : MlclusterdbscanSeries) -> Double {
  let n = ml_cluster_dbscan_series_len(s)
  if n == 0 { 0.0 } else { ml_cluster_dbscan_series_sum(s) / n.to_double() }
}

pub fn ml_cluster_dbscan_series_min(s : MlclusterdbscanSeries) -> Double {
  let n = ml_cluster_dbscan_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn ml_cluster_dbscan_series_max(s : MlclusterdbscanSeries) -> Double {
  let n = ml_cluster_dbscan_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn ml_cluster_dbscan_series_range(s : MlclusterdbscanSeries) -> Double {
  ml_cluster_dbscan_series_max(s) - ml_cluster_dbscan_series_min(s)
}

pub fn ml_cluster_dbscan_series_var(s : MlclusterdbscanSeries) -> Double {
  let n = ml_cluster_dbscan_series_len(s)
  if n == 0 { 0.0 } else {
    let m = ml_cluster_dbscan_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn ml_cluster_dbscan_series_std(s : MlclusterdbscanSeries) -> Double { @_common.sqrt(ml_cluster_dbscan_series_var(s)) }

pub fn ml_cluster_dbscan_series_median(s : MlclusterdbscanSeries) -> Double {
  let n = ml_cluster_dbscan_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = ml_cluster_dbscan_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn ml_cluster_dbscan_series_scale(s : MlclusterdbscanSeries, f : Double) -> MlclusterdbscanSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn ml_cluster_dbscan_series_add(a : MlclusterdbscanSeries, b : MlclusterdbscanSeries) -> MlclusterdbscanSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn ml_cluster_dbscan_series_sub(a : MlclusterdbscanSeries, b : MlclusterdbscanSeries) -> MlclusterdbscanSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn ml_cluster_dbscan_series_normalize(s : MlclusterdbscanSeries) -> MlclusterdbscanSeries {
  let mn = ml_cluster_dbscan_series_min(s)
  let mx = ml_cluster_dbscan_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn ml_cluster_dbscan_series_cumsum(s : MlclusterdbscanSeries) -> MlclusterdbscanSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn ml_cluster_dbscan_series_to_string(s : MlclusterdbscanSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlclusterdbscanMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_cluster_dbscan_make_matrix(rows : Int, cols : Int, val : Double) -> MlclusterdbscanMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_cluster_dbscan_matrix_identity(n : Int) -> MlclusterdbscanMatrix {
  let m = ml_cluster_dbscan_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ml_cluster_dbscan_matrix_get(m : MlclusterdbscanMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn ml_cluster_dbscan_matrix_transpose(m : MlclusterdbscanMatrix) -> MlclusterdbscanMatrix {
  let result = ml_cluster_dbscan_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn ml_cluster_dbscan_matrix_add(a : MlclusterdbscanMatrix, b : MlclusterdbscanMatrix) -> MlclusterdbscanMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = ml_cluster_dbscan_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn ml_cluster_dbscan_matrix_scale(m : MlclusterdbscanMatrix, s : Double) -> MlclusterdbscanMatrix {
  let result = ml_cluster_dbscan_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn ml_cluster_dbscan_matrix_multiply(a : MlclusterdbscanMatrix, b : MlclusterdbscanMatrix) -> MlclusterdbscanMatrix {
  if a.cols != b.rows { return ml_cluster_dbscan_make_matrix(a.rows, b.cols, 0.0) }
  let result = ml_cluster_dbscan_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ml_cluster_dbscan_matrix_trace(m : MlclusterdbscanMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn ml_cluster_dbscan_matrix_det(m : MlclusterdbscanMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ml_cluster_dbscan_matrix_norm(m : MlclusterdbscanMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ml_cluster_dbscan_matrix_to_string(m : MlclusterdbscanMatrix) -> String {
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

pub(all) struct MlclusterdbscanVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_cluster_dbscan_make_vector(comps : Array[Double]) -> MlclusterdbscanVector {
  { comps, dim: comps.length() }
}

pub fn ml_cluster_dbscan_vector_zero(dim : Int) -> MlclusterdbscanVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ml_cluster_dbscan_vector_add(a : MlclusterdbscanVector, b : MlclusterdbscanVector) -> MlclusterdbscanVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ml_cluster_dbscan_vector_sub(a : MlclusterdbscanVector, b : MlclusterdbscanVector) -> MlclusterdbscanVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ml_cluster_dbscan_vector_scale(v : MlclusterdbscanVector, s : Double) -> MlclusterdbscanVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn ml_cluster_dbscan_vector_dot(a : MlclusterdbscanVector, b : MlclusterdbscanVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn ml_cluster_dbscan_vector_norm(v : MlclusterdbscanVector) -> Double { @_common.sqrt(ml_cluster_dbscan_vector_dot(v, v)) }

pub fn ml_cluster_dbscan_vector_normalize(v : MlclusterdbscanVector) -> MlclusterdbscanVector {
  let n = ml_cluster_dbscan_vector_norm(v)
  if n < 0.0000001 { v } else { ml_cluster_dbscan_vector_scale(v, 1.0 / n) }
}

pub fn ml_cluster_dbscan_vector_dist(a : MlclusterdbscanVector, b : MlclusterdbscanVector) -> Double {
  ml_cluster_dbscan_vector_norm(ml_cluster_dbscan_vector_sub(a, b))
}

pub fn ml_cluster_dbscan_vector_to_string(v : MlclusterdbscanVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ml_cluster_dbscan_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn ml_cluster_dbscan_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = ml_cluster_dbscan_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn ml_cluster_dbscan_std(data : Array[Double]) -> Double { @_common.sqrt(ml_cluster_dbscan_var(data)) }

pub fn ml_cluster_dbscan_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = ml_cluster_dbscan_mean(a); let mb = ml_cluster_dbscan_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn ml_cluster_dbscan_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = ml_cluster_dbscan_std(a); let sb = ml_cluster_dbscan_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { ml_cluster_dbscan_cov(a, b) / (sa * sb) }
}

pub fn ml_cluster_dbscan_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = ml_cluster_dbscan_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn ml_cluster_dbscan_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn ml_cluster_dbscan_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn ml_cluster_dbscan_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  @_common.sqrt(ml_cluster_dbscan_mse(pred, labels))
}

pub fn ml_cluster_dbscan_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn ml_cluster_dbscan_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = ml_cluster_dbscan_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn ml_cluster_dbscan_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn ml_cluster_dbscan_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn ml_cluster_dbscan_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = ml_cluster_dbscan_precision(pred, labels, pos); let r = ml_cluster_dbscan_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn ml_cluster_dbscan_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn ml_cluster_dbscan_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = ml_cluster_dbscan_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn ml_cluster_dbscan_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn ml_cluster_dbscan_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn ml_cluster_dbscan_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = ml_cluster_dbscan_gcd(a, b)
    (a / g) * b
  }
}

pub fn ml_cluster_dbscan_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn ml_cluster_dbscan_fibonacci(n : Int) -> Int {
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

pub fn ml_cluster_dbscan_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = ml_cluster_dbscan_min(data); let mx = ml_cluster_dbscan_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn ml_cluster_dbscan_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = ml_cluster_dbscan_mean(data); let sd = ml_cluster_dbscan_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn ml_cluster_dbscan_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn ml_cluster_dbscan_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn ml_cluster_dbscan_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn ml_cluster_dbscan_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn ml_cluster_dbscan_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn ml_cluster_dbscan_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

pub(all) struct MlclusterdbscanFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_dbscan_frame_make(size : Int) -> MlclusterdbscanFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_dbscan_frame_len(s : MlclusterdbscanFrame) -> Int { s.size }

pub fn ml_cluster_dbscan_frame_get(s : MlclusterdbscanFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_dbscan_frame_set(s : MlclusterdbscanFrame, i : Int, v : Double) -> MlclusterdbscanFrame {
  let result = ml_cluster_dbscan_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_dbscan_frame_sum(s : MlclusterdbscanFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_cluster_dbscan_frame_mean(s : MlclusterdbscanFrame) -> Double {
  if s.size == 0 { 0.0 } else { ml_cluster_dbscan_frame_sum(s) / s.size.to_double() }
}

pub fn ml_cluster_dbscan_frame_scale(s : MlclusterdbscanFrame, f : Double) -> MlclusterdbscanFrame {
  let result = ml_cluster_dbscan_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_cluster_dbscan_frame_add(a : MlclusterdbscanFrame, b : MlclusterdbscanFrame) -> MlclusterdbscanFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_cluster_dbscan_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_cluster_dbscan_frame_copy(s : MlclusterdbscanFrame) -> MlclusterdbscanFrame {
  let result = ml_cluster_dbscan_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_cluster_dbscan_frame_fill(s : MlclusterdbscanFrame, v : Double) -> MlclusterdbscanFrame {
  let result = ml_cluster_dbscan_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_dbscan_frame_min(s : MlclusterdbscanFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_dbscan_frame_max(s : MlclusterdbscanFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_dbscan_frame_to_string(s : MlclusterdbscanFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusterdbscanTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_dbscan_table_make(size : Int) -> MlclusterdbscanTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_dbscan_table_len(s : MlclusterdbscanTable) -> Int { s.size }

pub fn ml_cluster_dbscan_table_get(s : MlclusterdbscanTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_dbscan_table_set(s : MlclusterdbscanTable, i : Int, v : Double) -> MlclusterdbscanTable {
  let result = ml_cluster_dbscan_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_dbscan_table_sum(s : MlclusterdbscanTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_cluster_dbscan_table_mean(s : MlclusterdbscanTable) -> Double {
  if s.size == 0 { 0.0 } else { ml_cluster_dbscan_table_sum(s) / s.size.to_double() }
}

pub fn ml_cluster_dbscan_table_scale(s : MlclusterdbscanTable, f : Double) -> MlclusterdbscanTable {
  let result = ml_cluster_dbscan_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_cluster_dbscan_table_add(a : MlclusterdbscanTable, b : MlclusterdbscanTable) -> MlclusterdbscanTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_cluster_dbscan_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_cluster_dbscan_table_copy(s : MlclusterdbscanTable) -> MlclusterdbscanTable {
  let result = ml_cluster_dbscan_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_cluster_dbscan_table_fill(s : MlclusterdbscanTable, v : Double) -> MlclusterdbscanTable {
  let result = ml_cluster_dbscan_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_dbscan_table_min(s : MlclusterdbscanTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_dbscan_table_max(s : MlclusterdbscanTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_dbscan_table_to_string(s : MlclusterdbscanTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusterdbscanGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_dbscan_graphn_make(size : Int) -> MlclusterdbscanGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_dbscan_graphn_len(s : MlclusterdbscanGraphN) -> Int { s.size }

pub fn ml_cluster_dbscan_graphn_get(s : MlclusterdbscanGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_dbscan_graphn_set(s : MlclusterdbscanGraphN, i : Int, v : Double) -> MlclusterdbscanGraphN {
  let result = ml_cluster_dbscan_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_dbscan_graphn_sum(s : MlclusterdbscanGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_cluster_dbscan_graphn_mean(s : MlclusterdbscanGraphN) -> Double {
  if s.size == 0 { 0.0 } else { ml_cluster_dbscan_graphn_sum(s) / s.size.to_double() }
}

pub fn ml_cluster_dbscan_graphn_scale(s : MlclusterdbscanGraphN, f : Double) -> MlclusterdbscanGraphN {
  let result = ml_cluster_dbscan_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_cluster_dbscan_graphn_add(a : MlclusterdbscanGraphN, b : MlclusterdbscanGraphN) -> MlclusterdbscanGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_cluster_dbscan_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_cluster_dbscan_graphn_copy(s : MlclusterdbscanGraphN) -> MlclusterdbscanGraphN {
  let result = ml_cluster_dbscan_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_cluster_dbscan_graphn_fill(s : MlclusterdbscanGraphN, v : Double) -> MlclusterdbscanGraphN {
  let result = ml_cluster_dbscan_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_dbscan_graphn_min(s : MlclusterdbscanGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_dbscan_graphn_max(s : MlclusterdbscanGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_dbscan_graphn_to_string(s : MlclusterdbscanGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusterdbscanNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_dbscan_node_make(size : Int) -> MlclusterdbscanNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_dbscan_node_len(s : MlclusterdbscanNode) -> Int { s.size }

pub fn ml_cluster_dbscan_node_get(s : MlclusterdbscanNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_dbscan_node_set(s : MlclusterdbscanNode, i : Int, v : Double) -> MlclusterdbscanNode {
  let result = ml_cluster_dbscan_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_dbscan_node_sum(s : MlclusterdbscanNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_cluster_dbscan_node_mean(s : MlclusterdbscanNode) -> Double {
  if s.size == 0 { 0.0 } else { ml_cluster_dbscan_node_sum(s) / s.size.to_double() }
}

pub fn ml_cluster_dbscan_node_scale(s : MlclusterdbscanNode, f : Double) -> MlclusterdbscanNode {
  let result = ml_cluster_dbscan_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_cluster_dbscan_node_add(a : MlclusterdbscanNode, b : MlclusterdbscanNode) -> MlclusterdbscanNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_cluster_dbscan_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_cluster_dbscan_node_copy(s : MlclusterdbscanNode) -> MlclusterdbscanNode {
  let result = ml_cluster_dbscan_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_cluster_dbscan_node_fill(s : MlclusterdbscanNode, v : Double) -> MlclusterdbscanNode {
  let result = ml_cluster_dbscan_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_dbscan_node_min(s : MlclusterdbscanNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_dbscan_node_max(s : MlclusterdbscanNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_dbscan_node_to_string(s : MlclusterdbscanNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusterdbscanEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_dbscan_edge_make(size : Int) -> MlclusterdbscanEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_dbscan_edge_len(s : MlclusterdbscanEdge) -> Int { s.size }

pub fn ml_cluster_dbscan_edge_get(s : MlclusterdbscanEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_dbscan_edge_set(s : MlclusterdbscanEdge, i : Int, v : Double) -> MlclusterdbscanEdge {
  let result = ml_cluster_dbscan_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_dbscan_edge_sum(s : MlclusterdbscanEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_cluster_dbscan_edge_mean(s : MlclusterdbscanEdge) -> Double {
  if s.size == 0 { 0.0 } else { ml_cluster_dbscan_edge_sum(s) / s.size.to_double() }
}

pub fn ml_cluster_dbscan_edge_scale(s : MlclusterdbscanEdge, f : Double) -> MlclusterdbscanEdge {
  let result = ml_cluster_dbscan_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_cluster_dbscan_edge_add(a : MlclusterdbscanEdge, b : MlclusterdbscanEdge) -> MlclusterdbscanEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_cluster_dbscan_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_cluster_dbscan_edge_copy(s : MlclusterdbscanEdge) -> MlclusterdbscanEdge {
  let result = ml_cluster_dbscan_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_cluster_dbscan_edge_fill(s : MlclusterdbscanEdge, v : Double) -> MlclusterdbscanEdge {
  let result = ml_cluster_dbscan_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_dbscan_edge_min(s : MlclusterdbscanEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_dbscan_edge_max(s : MlclusterdbscanEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_dbscan_edge_to_string(s : MlclusterdbscanEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusterdbscanPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_dbscan_path_make(size : Int) -> MlclusterdbscanPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_dbscan_path_len(s : MlclusterdbscanPath) -> Int { s.size }

pub fn ml_cluster_dbscan_path_get(s : MlclusterdbscanPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_dbscan_path_set(s : MlclusterdbscanPath, i : Int, v : Double) -> MlclusterdbscanPath {
  let result = ml_cluster_dbscan_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_dbscan_path_sum(s : MlclusterdbscanPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_cluster_dbscan_path_mean(s : MlclusterdbscanPath) -> Double {
  if s.size == 0 { 0.0 } else { ml_cluster_dbscan_path_sum(s) / s.size.to_double() }
}

pub fn ml_cluster_dbscan_path_scale(s : MlclusterdbscanPath, f : Double) -> MlclusterdbscanPath {
  let result = ml_cluster_dbscan_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_cluster_dbscan_path_add(a : MlclusterdbscanPath, b : MlclusterdbscanPath) -> MlclusterdbscanPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_cluster_dbscan_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_cluster_dbscan_path_copy(s : MlclusterdbscanPath) -> MlclusterdbscanPath {
  let result = ml_cluster_dbscan_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_cluster_dbscan_path_fill(s : MlclusterdbscanPath, v : Double) -> MlclusterdbscanPath {
  let result = ml_cluster_dbscan_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_dbscan_path_min(s : MlclusterdbscanPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_dbscan_path_max(s : MlclusterdbscanPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_dbscan_path_to_string(s : MlclusterdbscanPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusterdbscanCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_dbscan_cluster_make(size : Int) -> MlclusterdbscanCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_dbscan_cluster_len(s : MlclusterdbscanCluster) -> Int { s.size }

pub fn ml_cluster_dbscan_cluster_get(s : MlclusterdbscanCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_dbscan_cluster_set(s : MlclusterdbscanCluster, i : Int, v : Double) -> MlclusterdbscanCluster {
  let result = ml_cluster_dbscan_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_dbscan_cluster_sum(s : MlclusterdbscanCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_cluster_dbscan_cluster_mean(s : MlclusterdbscanCluster) -> Double {
  if s.size == 0 { 0.0 } else { ml_cluster_dbscan_cluster_sum(s) / s.size.to_double() }
}

pub fn ml_cluster_dbscan_cluster_scale(s : MlclusterdbscanCluster, f : Double) -> MlclusterdbscanCluster {
  let result = ml_cluster_dbscan_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_cluster_dbscan_cluster_add(a : MlclusterdbscanCluster, b : MlclusterdbscanCluster) -> MlclusterdbscanCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_cluster_dbscan_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_cluster_dbscan_cluster_copy(s : MlclusterdbscanCluster) -> MlclusterdbscanCluster {
  let result = ml_cluster_dbscan_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_cluster_dbscan_cluster_fill(s : MlclusterdbscanCluster, v : Double) -> MlclusterdbscanCluster {
  let result = ml_cluster_dbscan_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_dbscan_cluster_min(s : MlclusterdbscanCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_dbscan_cluster_max(s : MlclusterdbscanCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_dbscan_cluster_to_string(s : MlclusterdbscanCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusterdbscanModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_dbscan_model_make(size : Int) -> MlclusterdbscanModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_dbscan_model_len(s : MlclusterdbscanModel) -> Int { s.size }

pub fn ml_cluster_dbscan_model_get(s : MlclusterdbscanModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_dbscan_model_set(s : MlclusterdbscanModel, i : Int, v : Double) -> MlclusterdbscanModel {
  let result = ml_cluster_dbscan_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_dbscan_model_sum(s : MlclusterdbscanModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_cluster_dbscan_model_mean(s : MlclusterdbscanModel) -> Double {
  if s.size == 0 { 0.0 } else { ml_cluster_dbscan_model_sum(s) / s.size.to_double() }
}

pub fn ml_cluster_dbscan_model_scale(s : MlclusterdbscanModel, f : Double) -> MlclusterdbscanModel {
  let result = ml_cluster_dbscan_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_cluster_dbscan_model_add(a : MlclusterdbscanModel, b : MlclusterdbscanModel) -> MlclusterdbscanModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_cluster_dbscan_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_cluster_dbscan_model_copy(s : MlclusterdbscanModel) -> MlclusterdbscanModel {
  let result = ml_cluster_dbscan_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_cluster_dbscan_model_fill(s : MlclusterdbscanModel, v : Double) -> MlclusterdbscanModel {
  let result = ml_cluster_dbscan_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_dbscan_model_min(s : MlclusterdbscanModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_dbscan_model_max(s : MlclusterdbscanModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_dbscan_model_to_string(s : MlclusterdbscanModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusterdbscanLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_dbscan_layer_make(size : Int) -> MlclusterdbscanLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_dbscan_layer_len(s : MlclusterdbscanLayer) -> Int { s.size }

pub fn ml_cluster_dbscan_layer_get(s : MlclusterdbscanLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_dbscan_layer_set(s : MlclusterdbscanLayer, i : Int, v : Double) -> MlclusterdbscanLayer {
  let result = ml_cluster_dbscan_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_dbscan_layer_sum(s : MlclusterdbscanLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_cluster_dbscan_layer_mean(s : MlclusterdbscanLayer) -> Double {
  if s.size == 0 { 0.0 } else { ml_cluster_dbscan_layer_sum(s) / s.size.to_double() }
}

pub fn ml_cluster_dbscan_layer_scale(s : MlclusterdbscanLayer, f : Double) -> MlclusterdbscanLayer {
  let result = ml_cluster_dbscan_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_cluster_dbscan_layer_add(a : MlclusterdbscanLayer, b : MlclusterdbscanLayer) -> MlclusterdbscanLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_cluster_dbscan_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_cluster_dbscan_layer_copy(s : MlclusterdbscanLayer) -> MlclusterdbscanLayer {
  let result = ml_cluster_dbscan_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_cluster_dbscan_layer_fill(s : MlclusterdbscanLayer, v : Double) -> MlclusterdbscanLayer {
  let result = ml_cluster_dbscan_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_dbscan_layer_min(s : MlclusterdbscanLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_dbscan_layer_max(s : MlclusterdbscanLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_dbscan_layer_to_string(s : MlclusterdbscanLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusterdbscanBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_dbscan_buffer_make(size : Int) -> MlclusterdbscanBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_dbscan_buffer_len(s : MlclusterdbscanBuffer) -> Int { s.size }

pub fn ml_cluster_dbscan_buffer_get(s : MlclusterdbscanBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_dbscan_buffer_set(s : MlclusterdbscanBuffer, i : Int, v : Double) -> MlclusterdbscanBuffer {
  let result = ml_cluster_dbscan_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_dbscan_buffer_sum(s : MlclusterdbscanBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_cluster_dbscan_buffer_mean(s : MlclusterdbscanBuffer) -> Double {
  if s.size == 0 { 0.0 } else { ml_cluster_dbscan_buffer_sum(s) / s.size.to_double() }
}

pub fn ml_cluster_dbscan_buffer_scale(s : MlclusterdbscanBuffer, f : Double) -> MlclusterdbscanBuffer {
  let result = ml_cluster_dbscan_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_cluster_dbscan_buffer_add(a : MlclusterdbscanBuffer, b : MlclusterdbscanBuffer) -> MlclusterdbscanBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_cluster_dbscan_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_cluster_dbscan_buffer_copy(s : MlclusterdbscanBuffer) -> MlclusterdbscanBuffer {
  let result = ml_cluster_dbscan_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_cluster_dbscan_buffer_fill(s : MlclusterdbscanBuffer, v : Double) -> MlclusterdbscanBuffer {
  let result = ml_cluster_dbscan_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_dbscan_buffer_min(s : MlclusterdbscanBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_dbscan_buffer_max(s : MlclusterdbscanBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_dbscan_buffer_to_string(s : MlclusterdbscanBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusterdbscanCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_dbscan_cursor_make(size : Int) -> MlclusterdbscanCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_dbscan_cursor_len(s : MlclusterdbscanCursor) -> Int { s.size }

pub fn ml_cluster_dbscan_cursor_get(s : MlclusterdbscanCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_dbscan_cursor_set(s : MlclusterdbscanCursor, i : Int, v : Double) -> MlclusterdbscanCursor {
  let result = ml_cluster_dbscan_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_dbscan_cursor_sum(s : MlclusterdbscanCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_cluster_dbscan_cursor_mean(s : MlclusterdbscanCursor) -> Double {
  if s.size == 0 { 0.0 } else { ml_cluster_dbscan_cursor_sum(s) / s.size.to_double() }
}

pub fn ml_cluster_dbscan_cursor_scale(s : MlclusterdbscanCursor, f : Double) -> MlclusterdbscanCursor {
  let result = ml_cluster_dbscan_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_cluster_dbscan_cursor_add(a : MlclusterdbscanCursor, b : MlclusterdbscanCursor) -> MlclusterdbscanCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_cluster_dbscan_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_cluster_dbscan_cursor_copy(s : MlclusterdbscanCursor) -> MlclusterdbscanCursor {
  let result = ml_cluster_dbscan_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_cluster_dbscan_cursor_fill(s : MlclusterdbscanCursor, v : Double) -> MlclusterdbscanCursor {
  let result = ml_cluster_dbscan_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_dbscan_cursor_min(s : MlclusterdbscanCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_dbscan_cursor_max(s : MlclusterdbscanCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_dbscan_cursor_to_string(s : MlclusterdbscanCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusterdbscanView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_dbscan_view_make(size : Int) -> MlclusterdbscanView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_dbscan_view_len(s : MlclusterdbscanView) -> Int { s.size }

pub fn ml_cluster_dbscan_view_get(s : MlclusterdbscanView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_dbscan_view_set(s : MlclusterdbscanView, i : Int, v : Double) -> MlclusterdbscanView {
  let result = ml_cluster_dbscan_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_dbscan_view_sum(s : MlclusterdbscanView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_cluster_dbscan_view_mean(s : MlclusterdbscanView) -> Double {
  if s.size == 0 { 0.0 } else { ml_cluster_dbscan_view_sum(s) / s.size.to_double() }
}

pub fn ml_cluster_dbscan_view_scale(s : MlclusterdbscanView, f : Double) -> MlclusterdbscanView {
  let result = ml_cluster_dbscan_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_cluster_dbscan_view_add(a : MlclusterdbscanView, b : MlclusterdbscanView) -> MlclusterdbscanView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_cluster_dbscan_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_cluster_dbscan_view_copy(s : MlclusterdbscanView) -> MlclusterdbscanView {
  let result = ml_cluster_dbscan_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_cluster_dbscan_view_fill(s : MlclusterdbscanView, v : Double) -> MlclusterdbscanView {
  let result = ml_cluster_dbscan_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_dbscan_view_min(s : MlclusterdbscanView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_dbscan_view_max(s : MlclusterdbscanView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_dbscan_view_to_string(s : MlclusterdbscanView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusterdbscanRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_dbscan_range_make(size : Int) -> MlclusterdbscanRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_dbscan_range_len(s : MlclusterdbscanRange) -> Int { s.size }

pub fn ml_cluster_dbscan_range_get(s : MlclusterdbscanRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_dbscan_range_set(s : MlclusterdbscanRange, i : Int, v : Double) -> MlclusterdbscanRange {
  let result = ml_cluster_dbscan_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_dbscan_range_sum(s : MlclusterdbscanRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_cluster_dbscan_range_mean(s : MlclusterdbscanRange) -> Double {
  if s.size == 0 { 0.0 } else { ml_cluster_dbscan_range_sum(s) / s.size.to_double() }
}

pub fn ml_cluster_dbscan_range_scale(s : MlclusterdbscanRange, f : Double) -> MlclusterdbscanRange {
  let result = ml_cluster_dbscan_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_cluster_dbscan_range_add(a : MlclusterdbscanRange, b : MlclusterdbscanRange) -> MlclusterdbscanRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_cluster_dbscan_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_cluster_dbscan_range_copy(s : MlclusterdbscanRange) -> MlclusterdbscanRange {
  let result = ml_cluster_dbscan_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_cluster_dbscan_range_fill(s : MlclusterdbscanRange, v : Double) -> MlclusterdbscanRange {
  let result = ml_cluster_dbscan_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_dbscan_range_min(s : MlclusterdbscanRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_dbscan_range_max(s : MlclusterdbscanRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_dbscan_range_to_string(s : MlclusterdbscanRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusterdbscanSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_dbscan_slice_make(size : Int) -> MlclusterdbscanSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_dbscan_slice_len(s : MlclusterdbscanSlice) -> Int { s.size }

pub fn ml_cluster_dbscan_slice_get(s : MlclusterdbscanSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_dbscan_slice_set(s : MlclusterdbscanSlice, i : Int, v : Double) -> MlclusterdbscanSlice {
  let result = ml_cluster_dbscan_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_dbscan_slice_sum(s : MlclusterdbscanSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_cluster_dbscan_slice_mean(s : MlclusterdbscanSlice) -> Double {
  if s.size == 0 { 0.0 } else { ml_cluster_dbscan_slice_sum(s) / s.size.to_double() }
}

pub fn ml_cluster_dbscan_slice_scale(s : MlclusterdbscanSlice, f : Double) -> MlclusterdbscanSlice {
  let result = ml_cluster_dbscan_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_cluster_dbscan_slice_add(a : MlclusterdbscanSlice, b : MlclusterdbscanSlice) -> MlclusterdbscanSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_cluster_dbscan_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_cluster_dbscan_slice_copy(s : MlclusterdbscanSlice) -> MlclusterdbscanSlice {
  let result = ml_cluster_dbscan_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_cluster_dbscan_slice_fill(s : MlclusterdbscanSlice, v : Double) -> MlclusterdbscanSlice {
  let result = ml_cluster_dbscan_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_dbscan_slice_min(s : MlclusterdbscanSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_dbscan_slice_max(s : MlclusterdbscanSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_dbscan_slice_to_string(s : MlclusterdbscanSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

