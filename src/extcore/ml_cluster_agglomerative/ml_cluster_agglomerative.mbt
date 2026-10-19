///===
/// extcore/ml_cluster_agglomerative

pub(all) struct MlclusteragglomerativePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_cluster_agglomerative_make_point(x : Double, y : Double) -> MlclusteragglomerativePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_cluster_agglomerative_make_point3(x : Double, y : Double, z : Double) -> MlclusteragglomerativePoint {
  { x, y, z, label: 0 }
}

pub fn ml_cluster_agglomerative_point_x(pt : MlclusteragglomerativePoint) -> Double { pt.x }

pub fn ml_cluster_agglomerative_point_y(pt : MlclusteragglomerativePoint) -> Double { pt.y }

pub fn ml_cluster_agglomerative_point_z(pt : MlclusteragglomerativePoint) -> Double { pt.z }

pub fn ml_cluster_agglomerative_point_label(pt : MlclusteragglomerativePoint) -> Int { pt.label }

pub fn ml_cluster_agglomerative_point_dist(a : MlclusteragglomerativePoint, b : MlclusteragglomerativePoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ml_cluster_agglomerative_point_add(a : MlclusteragglomerativePoint, b : MlclusteragglomerativePoint) -> MlclusteragglomerativePoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn ml_cluster_agglomerative_point_sub(a : MlclusteragglomerativePoint, b : MlclusteragglomerativePoint) -> MlclusteragglomerativePoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn ml_cluster_agglomerative_point_scale(pt : MlclusteragglomerativePoint, s : Double) -> MlclusteragglomerativePoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn ml_cluster_agglomerative_point_dot(a : MlclusteragglomerativePoint, b : MlclusteragglomerativePoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn ml_cluster_agglomerative_point_cross(a : MlclusteragglomerativePoint, b : MlclusteragglomerativePoint) -> MlclusteragglomerativePoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn ml_cluster_agglomerative_point_norm(pt : MlclusteragglomerativePoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn ml_cluster_agglomerative_point_normalize(pt : MlclusteragglomerativePoint) -> MlclusteragglomerativePoint {
  let n = ml_cluster_agglomerative_point_norm(pt)
  if n < 0.0000001 { pt } else { ml_cluster_agglomerative_point_scale(pt, 1.0 / n) }
}

pub fn ml_cluster_agglomerative_point_negate(pt : MlclusteragglomerativePoint) -> MlclusteragglomerativePoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn ml_cluster_agglomerative_point_mid(a : MlclusteragglomerativePoint, b : MlclusteragglomerativePoint) -> MlclusteragglomerativePoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn ml_cluster_agglomerative_point_lerp(a : MlclusteragglomerativePoint, b : MlclusteragglomerativePoint, t : Double) -> MlclusteragglomerativePoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn ml_cluster_agglomerative_point_to_string(pt : MlclusteragglomerativePoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct MlclusteragglomerativeSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_cluster_agglomerative_make_series(vals : Array[Double], name : String) -> MlclusteragglomerativeSeries {
  { vals, name, meta: 0 }
}

pub fn ml_cluster_agglomerative_series_len(s : MlclusteragglomerativeSeries) -> Int { s.vals.length() }

pub fn ml_cluster_agglomerative_series_sum(s : MlclusteragglomerativeSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn ml_cluster_agglomerative_series_mean(s : MlclusteragglomerativeSeries) -> Double {
  let n = ml_cluster_agglomerative_series_len(s)
  if n == 0 { 0.0 } else { ml_cluster_agglomerative_series_sum(s) / n.to_double() }
}

pub fn ml_cluster_agglomerative_series_min(s : MlclusteragglomerativeSeries) -> Double {
  let n = ml_cluster_agglomerative_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn ml_cluster_agglomerative_series_max(s : MlclusteragglomerativeSeries) -> Double {
  let n = ml_cluster_agglomerative_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn ml_cluster_agglomerative_series_range(s : MlclusteragglomerativeSeries) -> Double {
  ml_cluster_agglomerative_series_max(s) - ml_cluster_agglomerative_series_min(s)
}

pub fn ml_cluster_agglomerative_series_var(s : MlclusteragglomerativeSeries) -> Double {
  let n = ml_cluster_agglomerative_series_len(s)
  if n == 0 { 0.0 } else {
    let m = ml_cluster_agglomerative_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn ml_cluster_agglomerative_series_std(s : MlclusteragglomerativeSeries) -> Double { @_common.sqrt(ml_cluster_agglomerative_series_var(s)) }

pub fn ml_cluster_agglomerative_series_median(s : MlclusteragglomerativeSeries) -> Double {
  let n = ml_cluster_agglomerative_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = ml_cluster_agglomerative_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn ml_cluster_agglomerative_series_scale(s : MlclusteragglomerativeSeries, f : Double) -> MlclusteragglomerativeSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn ml_cluster_agglomerative_series_add(a : MlclusteragglomerativeSeries, b : MlclusteragglomerativeSeries) -> MlclusteragglomerativeSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn ml_cluster_agglomerative_series_sub(a : MlclusteragglomerativeSeries, b : MlclusteragglomerativeSeries) -> MlclusteragglomerativeSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn ml_cluster_agglomerative_series_normalize(s : MlclusteragglomerativeSeries) -> MlclusteragglomerativeSeries {
  let mn = ml_cluster_agglomerative_series_min(s)
  let mx = ml_cluster_agglomerative_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn ml_cluster_agglomerative_series_cumsum(s : MlclusteragglomerativeSeries) -> MlclusteragglomerativeSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn ml_cluster_agglomerative_series_to_string(s : MlclusteragglomerativeSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlclusteragglomerativeMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_cluster_agglomerative_make_matrix(rows : Int, cols : Int, val : Double) -> MlclusteragglomerativeMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_cluster_agglomerative_matrix_identity(n : Int) -> MlclusteragglomerativeMatrix {
  let m = ml_cluster_agglomerative_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ml_cluster_agglomerative_matrix_get(m : MlclusteragglomerativeMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn ml_cluster_agglomerative_matrix_transpose(m : MlclusteragglomerativeMatrix) -> MlclusteragglomerativeMatrix {
  let result = ml_cluster_agglomerative_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn ml_cluster_agglomerative_matrix_add(a : MlclusteragglomerativeMatrix, b : MlclusteragglomerativeMatrix) -> MlclusteragglomerativeMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = ml_cluster_agglomerative_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn ml_cluster_agglomerative_matrix_scale(m : MlclusteragglomerativeMatrix, s : Double) -> MlclusteragglomerativeMatrix {
  let result = ml_cluster_agglomerative_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn ml_cluster_agglomerative_matrix_multiply(a : MlclusteragglomerativeMatrix, b : MlclusteragglomerativeMatrix) -> MlclusteragglomerativeMatrix {
  if a.cols != b.rows { return ml_cluster_agglomerative_make_matrix(a.rows, b.cols, 0.0) }
  let result = ml_cluster_agglomerative_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ml_cluster_agglomerative_matrix_trace(m : MlclusteragglomerativeMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn ml_cluster_agglomerative_matrix_det(m : MlclusteragglomerativeMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ml_cluster_agglomerative_matrix_norm(m : MlclusteragglomerativeMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ml_cluster_agglomerative_matrix_to_string(m : MlclusteragglomerativeMatrix) -> String {
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

pub(all) struct MlclusteragglomerativeVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_cluster_agglomerative_make_vector(comps : Array[Double]) -> MlclusteragglomerativeVector {
  { comps, dim: comps.length() }
}

pub fn ml_cluster_agglomerative_vector_zero(dim : Int) -> MlclusteragglomerativeVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ml_cluster_agglomerative_vector_add(a : MlclusteragglomerativeVector, b : MlclusteragglomerativeVector) -> MlclusteragglomerativeVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ml_cluster_agglomerative_vector_sub(a : MlclusteragglomerativeVector, b : MlclusteragglomerativeVector) -> MlclusteragglomerativeVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ml_cluster_agglomerative_vector_scale(v : MlclusteragglomerativeVector, s : Double) -> MlclusteragglomerativeVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn ml_cluster_agglomerative_vector_dot(a : MlclusteragglomerativeVector, b : MlclusteragglomerativeVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn ml_cluster_agglomerative_vector_norm(v : MlclusteragglomerativeVector) -> Double { @_common.sqrt(ml_cluster_agglomerative_vector_dot(v, v)) }

pub fn ml_cluster_agglomerative_vector_normalize(v : MlclusteragglomerativeVector) -> MlclusteragglomerativeVector {
  let n = ml_cluster_agglomerative_vector_norm(v)
  if n < 0.0000001 { v } else { ml_cluster_agglomerative_vector_scale(v, 1.0 / n) }
}

pub fn ml_cluster_agglomerative_vector_dist(a : MlclusteragglomerativeVector, b : MlclusteragglomerativeVector) -> Double {
  ml_cluster_agglomerative_vector_norm(ml_cluster_agglomerative_vector_sub(a, b))
}

pub fn ml_cluster_agglomerative_vector_to_string(v : MlclusteragglomerativeVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ml_cluster_agglomerative_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn ml_cluster_agglomerative_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = ml_cluster_agglomerative_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn ml_cluster_agglomerative_std(data : Array[Double]) -> Double { @_common.sqrt(ml_cluster_agglomerative_var(data)) }

pub fn ml_cluster_agglomerative_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = ml_cluster_agglomerative_mean(a); let mb = ml_cluster_agglomerative_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn ml_cluster_agglomerative_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = ml_cluster_agglomerative_std(a); let sb = ml_cluster_agglomerative_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { ml_cluster_agglomerative_cov(a, b) / (sa * sb) }
}

pub fn ml_cluster_agglomerative_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = ml_cluster_agglomerative_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn ml_cluster_agglomerative_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn ml_cluster_agglomerative_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn ml_cluster_agglomerative_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  @_common.sqrt(ml_cluster_agglomerative_mse(pred, labels))
}

pub fn ml_cluster_agglomerative_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn ml_cluster_agglomerative_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = ml_cluster_agglomerative_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn ml_cluster_agglomerative_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn ml_cluster_agglomerative_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn ml_cluster_agglomerative_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = ml_cluster_agglomerative_precision(pred, labels, pos); let r = ml_cluster_agglomerative_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn ml_cluster_agglomerative_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn ml_cluster_agglomerative_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = ml_cluster_agglomerative_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn ml_cluster_agglomerative_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn ml_cluster_agglomerative_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn ml_cluster_agglomerative_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = ml_cluster_agglomerative_gcd(a, b)
    (a / g) * b
  }
}

pub fn ml_cluster_agglomerative_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn ml_cluster_agglomerative_fibonacci(n : Int) -> Int {
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

pub fn ml_cluster_agglomerative_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = ml_cluster_agglomerative_min(data); let mx = ml_cluster_agglomerative_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn ml_cluster_agglomerative_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = ml_cluster_agglomerative_mean(data); let sd = ml_cluster_agglomerative_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn ml_cluster_agglomerative_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn ml_cluster_agglomerative_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn ml_cluster_agglomerative_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn ml_cluster_agglomerative_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn ml_cluster_agglomerative_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn ml_cluster_agglomerative_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

pub(all) struct MlclusteragglomerativeFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_agglomerative_frame_make(size : Int) -> MlclusteragglomerativeFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_agglomerative_frame_len(s : MlclusteragglomerativeFrame) -> Int { s.size }

pub fn ml_cluster_agglomerative_frame_get(s : MlclusteragglomerativeFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_agglomerative_frame_set(s : MlclusteragglomerativeFrame, i : Int, v : Double) -> MlclusteragglomerativeFrame {
  let result = ml_cluster_agglomerative_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_agglomerative_frame_sum(s : MlclusteragglomerativeFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_cluster_agglomerative_frame_mean(s : MlclusteragglomerativeFrame) -> Double {
  if s.size == 0 { 0.0 } else { ml_cluster_agglomerative_frame_sum(s) / s.size.to_double() }
}

pub fn ml_cluster_agglomerative_frame_scale(s : MlclusteragglomerativeFrame, f : Double) -> MlclusteragglomerativeFrame {
  let result = ml_cluster_agglomerative_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_cluster_agglomerative_frame_add(a : MlclusteragglomerativeFrame, b : MlclusteragglomerativeFrame) -> MlclusteragglomerativeFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_cluster_agglomerative_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_cluster_agglomerative_frame_copy(s : MlclusteragglomerativeFrame) -> MlclusteragglomerativeFrame {
  let result = ml_cluster_agglomerative_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_cluster_agglomerative_frame_fill(s : MlclusteragglomerativeFrame, v : Double) -> MlclusteragglomerativeFrame {
  let result = ml_cluster_agglomerative_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_agglomerative_frame_min(s : MlclusteragglomerativeFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_agglomerative_frame_max(s : MlclusteragglomerativeFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_agglomerative_frame_to_string(s : MlclusteragglomerativeFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusteragglomerativeTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_agglomerative_table_make(size : Int) -> MlclusteragglomerativeTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_agglomerative_table_len(s : MlclusteragglomerativeTable) -> Int { s.size }

pub fn ml_cluster_agglomerative_table_get(s : MlclusteragglomerativeTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_agglomerative_table_set(s : MlclusteragglomerativeTable, i : Int, v : Double) -> MlclusteragglomerativeTable {
  let result = ml_cluster_agglomerative_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_agglomerative_table_sum(s : MlclusteragglomerativeTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_cluster_agglomerative_table_mean(s : MlclusteragglomerativeTable) -> Double {
  if s.size == 0 { 0.0 } else { ml_cluster_agglomerative_table_sum(s) / s.size.to_double() }
}

pub fn ml_cluster_agglomerative_table_scale(s : MlclusteragglomerativeTable, f : Double) -> MlclusteragglomerativeTable {
  let result = ml_cluster_agglomerative_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_cluster_agglomerative_table_add(a : MlclusteragglomerativeTable, b : MlclusteragglomerativeTable) -> MlclusteragglomerativeTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_cluster_agglomerative_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_cluster_agglomerative_table_copy(s : MlclusteragglomerativeTable) -> MlclusteragglomerativeTable {
  let result = ml_cluster_agglomerative_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_cluster_agglomerative_table_fill(s : MlclusteragglomerativeTable, v : Double) -> MlclusteragglomerativeTable {
  let result = ml_cluster_agglomerative_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_agglomerative_table_min(s : MlclusteragglomerativeTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_agglomerative_table_max(s : MlclusteragglomerativeTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_agglomerative_table_to_string(s : MlclusteragglomerativeTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusteragglomerativeGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_agglomerative_graphn_make(size : Int) -> MlclusteragglomerativeGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_agglomerative_graphn_len(s : MlclusteragglomerativeGraphN) -> Int { s.size }

pub fn ml_cluster_agglomerative_graphn_get(s : MlclusteragglomerativeGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_agglomerative_graphn_set(s : MlclusteragglomerativeGraphN, i : Int, v : Double) -> MlclusteragglomerativeGraphN {
  let result = ml_cluster_agglomerative_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_agglomerative_graphn_sum(s : MlclusteragglomerativeGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_cluster_agglomerative_graphn_mean(s : MlclusteragglomerativeGraphN) -> Double {
  if s.size == 0 { 0.0 } else { ml_cluster_agglomerative_graphn_sum(s) / s.size.to_double() }
}

pub fn ml_cluster_agglomerative_graphn_scale(s : MlclusteragglomerativeGraphN, f : Double) -> MlclusteragglomerativeGraphN {
  let result = ml_cluster_agglomerative_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_cluster_agglomerative_graphn_add(a : MlclusteragglomerativeGraphN, b : MlclusteragglomerativeGraphN) -> MlclusteragglomerativeGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_cluster_agglomerative_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_cluster_agglomerative_graphn_copy(s : MlclusteragglomerativeGraphN) -> MlclusteragglomerativeGraphN {
  let result = ml_cluster_agglomerative_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_cluster_agglomerative_graphn_fill(s : MlclusteragglomerativeGraphN, v : Double) -> MlclusteragglomerativeGraphN {
  let result = ml_cluster_agglomerative_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_agglomerative_graphn_min(s : MlclusteragglomerativeGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_agglomerative_graphn_max(s : MlclusteragglomerativeGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_agglomerative_graphn_to_string(s : MlclusteragglomerativeGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusteragglomerativeNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_agglomerative_node_make(size : Int) -> MlclusteragglomerativeNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_agglomerative_node_len(s : MlclusteragglomerativeNode) -> Int { s.size }

pub fn ml_cluster_agglomerative_node_get(s : MlclusteragglomerativeNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_agglomerative_node_set(s : MlclusteragglomerativeNode, i : Int, v : Double) -> MlclusteragglomerativeNode {
  let result = ml_cluster_agglomerative_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_agglomerative_node_sum(s : MlclusteragglomerativeNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_cluster_agglomerative_node_mean(s : MlclusteragglomerativeNode) -> Double {
  if s.size == 0 { 0.0 } else { ml_cluster_agglomerative_node_sum(s) / s.size.to_double() }
}

pub fn ml_cluster_agglomerative_node_scale(s : MlclusteragglomerativeNode, f : Double) -> MlclusteragglomerativeNode {
  let result = ml_cluster_agglomerative_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_cluster_agglomerative_node_add(a : MlclusteragglomerativeNode, b : MlclusteragglomerativeNode) -> MlclusteragglomerativeNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_cluster_agglomerative_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_cluster_agglomerative_node_copy(s : MlclusteragglomerativeNode) -> MlclusteragglomerativeNode {
  let result = ml_cluster_agglomerative_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_cluster_agglomerative_node_fill(s : MlclusteragglomerativeNode, v : Double) -> MlclusteragglomerativeNode {
  let result = ml_cluster_agglomerative_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_agglomerative_node_min(s : MlclusteragglomerativeNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_agglomerative_node_max(s : MlclusteragglomerativeNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_agglomerative_node_to_string(s : MlclusteragglomerativeNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusteragglomerativeEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_agglomerative_edge_make(size : Int) -> MlclusteragglomerativeEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_agglomerative_edge_len(s : MlclusteragglomerativeEdge) -> Int { s.size }

pub fn ml_cluster_agglomerative_edge_get(s : MlclusteragglomerativeEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_agglomerative_edge_set(s : MlclusteragglomerativeEdge, i : Int, v : Double) -> MlclusteragglomerativeEdge {
  let result = ml_cluster_agglomerative_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_agglomerative_edge_sum(s : MlclusteragglomerativeEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_cluster_agglomerative_edge_mean(s : MlclusteragglomerativeEdge) -> Double {
  if s.size == 0 { 0.0 } else { ml_cluster_agglomerative_edge_sum(s) / s.size.to_double() }
}

pub fn ml_cluster_agglomerative_edge_scale(s : MlclusteragglomerativeEdge, f : Double) -> MlclusteragglomerativeEdge {
  let result = ml_cluster_agglomerative_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_cluster_agglomerative_edge_add(a : MlclusteragglomerativeEdge, b : MlclusteragglomerativeEdge) -> MlclusteragglomerativeEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_cluster_agglomerative_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_cluster_agglomerative_edge_copy(s : MlclusteragglomerativeEdge) -> MlclusteragglomerativeEdge {
  let result = ml_cluster_agglomerative_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_cluster_agglomerative_edge_fill(s : MlclusteragglomerativeEdge, v : Double) -> MlclusteragglomerativeEdge {
  let result = ml_cluster_agglomerative_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_agglomerative_edge_min(s : MlclusteragglomerativeEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_agglomerative_edge_max(s : MlclusteragglomerativeEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_agglomerative_edge_to_string(s : MlclusteragglomerativeEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusteragglomerativePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_agglomerative_path_make(size : Int) -> MlclusteragglomerativePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_agglomerative_path_len(s : MlclusteragglomerativePath) -> Int { s.size }

pub fn ml_cluster_agglomerative_path_get(s : MlclusteragglomerativePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_agglomerative_path_set(s : MlclusteragglomerativePath, i : Int, v : Double) -> MlclusteragglomerativePath {
  let result = ml_cluster_agglomerative_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_agglomerative_path_sum(s : MlclusteragglomerativePath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_cluster_agglomerative_path_mean(s : MlclusteragglomerativePath) -> Double {
  if s.size == 0 { 0.0 } else { ml_cluster_agglomerative_path_sum(s) / s.size.to_double() }
}

pub fn ml_cluster_agglomerative_path_scale(s : MlclusteragglomerativePath, f : Double) -> MlclusteragglomerativePath {
  let result = ml_cluster_agglomerative_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_cluster_agglomerative_path_add(a : MlclusteragglomerativePath, b : MlclusteragglomerativePath) -> MlclusteragglomerativePath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_cluster_agglomerative_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_cluster_agglomerative_path_copy(s : MlclusteragglomerativePath) -> MlclusteragglomerativePath {
  let result = ml_cluster_agglomerative_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_cluster_agglomerative_path_fill(s : MlclusteragglomerativePath, v : Double) -> MlclusteragglomerativePath {
  let result = ml_cluster_agglomerative_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_agglomerative_path_min(s : MlclusteragglomerativePath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_agglomerative_path_max(s : MlclusteragglomerativePath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_agglomerative_path_to_string(s : MlclusteragglomerativePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusteragglomerativeCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_agglomerative_cluster_make(size : Int) -> MlclusteragglomerativeCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_agglomerative_cluster_len(s : MlclusteragglomerativeCluster) -> Int { s.size }

pub fn ml_cluster_agglomerative_cluster_get(s : MlclusteragglomerativeCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_agglomerative_cluster_set(s : MlclusteragglomerativeCluster, i : Int, v : Double) -> MlclusteragglomerativeCluster {
  let result = ml_cluster_agglomerative_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_agglomerative_cluster_sum(s : MlclusteragglomerativeCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_cluster_agglomerative_cluster_mean(s : MlclusteragglomerativeCluster) -> Double {
  if s.size == 0 { 0.0 } else { ml_cluster_agglomerative_cluster_sum(s) / s.size.to_double() }
}

pub fn ml_cluster_agglomerative_cluster_scale(s : MlclusteragglomerativeCluster, f : Double) -> MlclusteragglomerativeCluster {
  let result = ml_cluster_agglomerative_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_cluster_agglomerative_cluster_add(a : MlclusteragglomerativeCluster, b : MlclusteragglomerativeCluster) -> MlclusteragglomerativeCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_cluster_agglomerative_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_cluster_agglomerative_cluster_copy(s : MlclusteragglomerativeCluster) -> MlclusteragglomerativeCluster {
  let result = ml_cluster_agglomerative_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_cluster_agglomerative_cluster_fill(s : MlclusteragglomerativeCluster, v : Double) -> MlclusteragglomerativeCluster {
  let result = ml_cluster_agglomerative_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_agglomerative_cluster_min(s : MlclusteragglomerativeCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_agglomerative_cluster_max(s : MlclusteragglomerativeCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_agglomerative_cluster_to_string(s : MlclusteragglomerativeCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusteragglomerativeModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_agglomerative_model_make(size : Int) -> MlclusteragglomerativeModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_agglomerative_model_len(s : MlclusteragglomerativeModel) -> Int { s.size }

pub fn ml_cluster_agglomerative_model_get(s : MlclusteragglomerativeModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_agglomerative_model_set(s : MlclusteragglomerativeModel, i : Int, v : Double) -> MlclusteragglomerativeModel {
  let result = ml_cluster_agglomerative_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_agglomerative_model_sum(s : MlclusteragglomerativeModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_cluster_agglomerative_model_mean(s : MlclusteragglomerativeModel) -> Double {
  if s.size == 0 { 0.0 } else { ml_cluster_agglomerative_model_sum(s) / s.size.to_double() }
}

pub fn ml_cluster_agglomerative_model_scale(s : MlclusteragglomerativeModel, f : Double) -> MlclusteragglomerativeModel {
  let result = ml_cluster_agglomerative_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_cluster_agglomerative_model_add(a : MlclusteragglomerativeModel, b : MlclusteragglomerativeModel) -> MlclusteragglomerativeModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_cluster_agglomerative_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_cluster_agglomerative_model_copy(s : MlclusteragglomerativeModel) -> MlclusteragglomerativeModel {
  let result = ml_cluster_agglomerative_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_cluster_agglomerative_model_fill(s : MlclusteragglomerativeModel, v : Double) -> MlclusteragglomerativeModel {
  let result = ml_cluster_agglomerative_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_agglomerative_model_min(s : MlclusteragglomerativeModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_agglomerative_model_max(s : MlclusteragglomerativeModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_agglomerative_model_to_string(s : MlclusteragglomerativeModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusteragglomerativeLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_agglomerative_layer_make(size : Int) -> MlclusteragglomerativeLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_agglomerative_layer_len(s : MlclusteragglomerativeLayer) -> Int { s.size }

pub fn ml_cluster_agglomerative_layer_get(s : MlclusteragglomerativeLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_agglomerative_layer_set(s : MlclusteragglomerativeLayer, i : Int, v : Double) -> MlclusteragglomerativeLayer {
  let result = ml_cluster_agglomerative_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_agglomerative_layer_sum(s : MlclusteragglomerativeLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_cluster_agglomerative_layer_mean(s : MlclusteragglomerativeLayer) -> Double {
  if s.size == 0 { 0.0 } else { ml_cluster_agglomerative_layer_sum(s) / s.size.to_double() }
}

pub fn ml_cluster_agglomerative_layer_scale(s : MlclusteragglomerativeLayer, f : Double) -> MlclusteragglomerativeLayer {
  let result = ml_cluster_agglomerative_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_cluster_agglomerative_layer_add(a : MlclusteragglomerativeLayer, b : MlclusteragglomerativeLayer) -> MlclusteragglomerativeLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_cluster_agglomerative_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_cluster_agglomerative_layer_copy(s : MlclusteragglomerativeLayer) -> MlclusteragglomerativeLayer {
  let result = ml_cluster_agglomerative_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_cluster_agglomerative_layer_fill(s : MlclusteragglomerativeLayer, v : Double) -> MlclusteragglomerativeLayer {
  let result = ml_cluster_agglomerative_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_agglomerative_layer_min(s : MlclusteragglomerativeLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_agglomerative_layer_max(s : MlclusteragglomerativeLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_agglomerative_layer_to_string(s : MlclusteragglomerativeLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusteragglomerativeBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_agglomerative_buffer_make(size : Int) -> MlclusteragglomerativeBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_agglomerative_buffer_len(s : MlclusteragglomerativeBuffer) -> Int { s.size }

pub fn ml_cluster_agglomerative_buffer_get(s : MlclusteragglomerativeBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_agglomerative_buffer_set(s : MlclusteragglomerativeBuffer, i : Int, v : Double) -> MlclusteragglomerativeBuffer {
  let result = ml_cluster_agglomerative_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_agglomerative_buffer_sum(s : MlclusteragglomerativeBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_cluster_agglomerative_buffer_mean(s : MlclusteragglomerativeBuffer) -> Double {
  if s.size == 0 { 0.0 } else { ml_cluster_agglomerative_buffer_sum(s) / s.size.to_double() }
}

pub fn ml_cluster_agglomerative_buffer_scale(s : MlclusteragglomerativeBuffer, f : Double) -> MlclusteragglomerativeBuffer {
  let result = ml_cluster_agglomerative_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_cluster_agglomerative_buffer_add(a : MlclusteragglomerativeBuffer, b : MlclusteragglomerativeBuffer) -> MlclusteragglomerativeBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_cluster_agglomerative_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_cluster_agglomerative_buffer_copy(s : MlclusteragglomerativeBuffer) -> MlclusteragglomerativeBuffer {
  let result = ml_cluster_agglomerative_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_cluster_agglomerative_buffer_fill(s : MlclusteragglomerativeBuffer, v : Double) -> MlclusteragglomerativeBuffer {
  let result = ml_cluster_agglomerative_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_agglomerative_buffer_min(s : MlclusteragglomerativeBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_agglomerative_buffer_max(s : MlclusteragglomerativeBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_agglomerative_buffer_to_string(s : MlclusteragglomerativeBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusteragglomerativeCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_agglomerative_cursor_make(size : Int) -> MlclusteragglomerativeCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_agglomerative_cursor_len(s : MlclusteragglomerativeCursor) -> Int { s.size }

pub fn ml_cluster_agglomerative_cursor_get(s : MlclusteragglomerativeCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_agglomerative_cursor_set(s : MlclusteragglomerativeCursor, i : Int, v : Double) -> MlclusteragglomerativeCursor {
  let result = ml_cluster_agglomerative_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_agglomerative_cursor_sum(s : MlclusteragglomerativeCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_cluster_agglomerative_cursor_mean(s : MlclusteragglomerativeCursor) -> Double {
  if s.size == 0 { 0.0 } else { ml_cluster_agglomerative_cursor_sum(s) / s.size.to_double() }
}

pub fn ml_cluster_agglomerative_cursor_scale(s : MlclusteragglomerativeCursor, f : Double) -> MlclusteragglomerativeCursor {
  let result = ml_cluster_agglomerative_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_cluster_agglomerative_cursor_add(a : MlclusteragglomerativeCursor, b : MlclusteragglomerativeCursor) -> MlclusteragglomerativeCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_cluster_agglomerative_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_cluster_agglomerative_cursor_copy(s : MlclusteragglomerativeCursor) -> MlclusteragglomerativeCursor {
  let result = ml_cluster_agglomerative_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_cluster_agglomerative_cursor_fill(s : MlclusteragglomerativeCursor, v : Double) -> MlclusteragglomerativeCursor {
  let result = ml_cluster_agglomerative_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_agglomerative_cursor_min(s : MlclusteragglomerativeCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_agglomerative_cursor_max(s : MlclusteragglomerativeCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_agglomerative_cursor_to_string(s : MlclusteragglomerativeCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusteragglomerativeView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_agglomerative_view_make(size : Int) -> MlclusteragglomerativeView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_agglomerative_view_len(s : MlclusteragglomerativeView) -> Int { s.size }

pub fn ml_cluster_agglomerative_view_get(s : MlclusteragglomerativeView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_agglomerative_view_set(s : MlclusteragglomerativeView, i : Int, v : Double) -> MlclusteragglomerativeView {
  let result = ml_cluster_agglomerative_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_agglomerative_view_sum(s : MlclusteragglomerativeView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_cluster_agglomerative_view_mean(s : MlclusteragglomerativeView) -> Double {
  if s.size == 0 { 0.0 } else { ml_cluster_agglomerative_view_sum(s) / s.size.to_double() }
}

pub fn ml_cluster_agglomerative_view_scale(s : MlclusteragglomerativeView, f : Double) -> MlclusteragglomerativeView {
  let result = ml_cluster_agglomerative_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_cluster_agglomerative_view_add(a : MlclusteragglomerativeView, b : MlclusteragglomerativeView) -> MlclusteragglomerativeView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_cluster_agglomerative_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_cluster_agglomerative_view_copy(s : MlclusteragglomerativeView) -> MlclusteragglomerativeView {
  let result = ml_cluster_agglomerative_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_cluster_agglomerative_view_fill(s : MlclusteragglomerativeView, v : Double) -> MlclusteragglomerativeView {
  let result = ml_cluster_agglomerative_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_agglomerative_view_min(s : MlclusteragglomerativeView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_agglomerative_view_max(s : MlclusteragglomerativeView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_agglomerative_view_to_string(s : MlclusteragglomerativeView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusteragglomerativeRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_agglomerative_range_make(size : Int) -> MlclusteragglomerativeRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_agglomerative_range_len(s : MlclusteragglomerativeRange) -> Int { s.size }

pub fn ml_cluster_agglomerative_range_get(s : MlclusteragglomerativeRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_agglomerative_range_set(s : MlclusteragglomerativeRange, i : Int, v : Double) -> MlclusteragglomerativeRange {
  let result = ml_cluster_agglomerative_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_agglomerative_range_sum(s : MlclusteragglomerativeRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_cluster_agglomerative_range_mean(s : MlclusteragglomerativeRange) -> Double {
  if s.size == 0 { 0.0 } else { ml_cluster_agglomerative_range_sum(s) / s.size.to_double() }
}

pub fn ml_cluster_agglomerative_range_scale(s : MlclusteragglomerativeRange, f : Double) -> MlclusteragglomerativeRange {
  let result = ml_cluster_agglomerative_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_cluster_agglomerative_range_add(a : MlclusteragglomerativeRange, b : MlclusteragglomerativeRange) -> MlclusteragglomerativeRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_cluster_agglomerative_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_cluster_agglomerative_range_copy(s : MlclusteragglomerativeRange) -> MlclusteragglomerativeRange {
  let result = ml_cluster_agglomerative_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_cluster_agglomerative_range_fill(s : MlclusteragglomerativeRange, v : Double) -> MlclusteragglomerativeRange {
  let result = ml_cluster_agglomerative_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_agglomerative_range_min(s : MlclusteragglomerativeRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_agglomerative_range_max(s : MlclusteragglomerativeRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_agglomerative_range_to_string(s : MlclusteragglomerativeRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusteragglomerativeSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_agglomerative_slice_make(size : Int) -> MlclusteragglomerativeSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_agglomerative_slice_len(s : MlclusteragglomerativeSlice) -> Int { s.size }

pub fn ml_cluster_agglomerative_slice_get(s : MlclusteragglomerativeSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_agglomerative_slice_set(s : MlclusteragglomerativeSlice, i : Int, v : Double) -> MlclusteragglomerativeSlice {
  let result = ml_cluster_agglomerative_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_agglomerative_slice_sum(s : MlclusteragglomerativeSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_cluster_agglomerative_slice_mean(s : MlclusteragglomerativeSlice) -> Double {
  if s.size == 0 { 0.0 } else { ml_cluster_agglomerative_slice_sum(s) / s.size.to_double() }
}

pub fn ml_cluster_agglomerative_slice_scale(s : MlclusteragglomerativeSlice, f : Double) -> MlclusteragglomerativeSlice {
  let result = ml_cluster_agglomerative_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_cluster_agglomerative_slice_add(a : MlclusteragglomerativeSlice, b : MlclusteragglomerativeSlice) -> MlclusteragglomerativeSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_cluster_agglomerative_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_cluster_agglomerative_slice_copy(s : MlclusteragglomerativeSlice) -> MlclusteragglomerativeSlice {
  let result = ml_cluster_agglomerative_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_cluster_agglomerative_slice_fill(s : MlclusteragglomerativeSlice, v : Double) -> MlclusteragglomerativeSlice {
  let result = ml_cluster_agglomerative_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_agglomerative_slice_min(s : MlclusteragglomerativeSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_agglomerative_slice_max(s : MlclusteragglomerativeSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_agglomerative_slice_to_string(s : MlclusteragglomerativeSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

