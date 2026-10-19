///===
/// extcore/ml_cluster_gmm

pub(all) struct MlclustergmmPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_cluster_gmm_make_point(x : Double, y : Double) -> MlclustergmmPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_cluster_gmm_make_point3(x : Double, y : Double, z : Double) -> MlclustergmmPoint {
  { x, y, z, label: 0 }
}

pub fn ml_cluster_gmm_point_x(pt : MlclustergmmPoint) -> Double { pt.x }

pub fn ml_cluster_gmm_point_y(pt : MlclustergmmPoint) -> Double { pt.y }

pub fn ml_cluster_gmm_point_z(pt : MlclustergmmPoint) -> Double { pt.z }

pub fn ml_cluster_gmm_point_label(pt : MlclustergmmPoint) -> Int { pt.label }

pub fn ml_cluster_gmm_point_dist(a : MlclustergmmPoint, b : MlclustergmmPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ml_cluster_gmm_point_add(a : MlclustergmmPoint, b : MlclustergmmPoint) -> MlclustergmmPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn ml_cluster_gmm_point_sub(a : MlclustergmmPoint, b : MlclustergmmPoint) -> MlclustergmmPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn ml_cluster_gmm_point_scale(pt : MlclustergmmPoint, s : Double) -> MlclustergmmPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn ml_cluster_gmm_point_dot(a : MlclustergmmPoint, b : MlclustergmmPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn ml_cluster_gmm_point_cross(a : MlclustergmmPoint, b : MlclustergmmPoint) -> MlclustergmmPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn ml_cluster_gmm_point_norm(pt : MlclustergmmPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn ml_cluster_gmm_point_normalize(pt : MlclustergmmPoint) -> MlclustergmmPoint {
  let n = ml_cluster_gmm_point_norm(pt)
  if n < 0.0000001 { pt } else { ml_cluster_gmm_point_scale(pt, 1.0 / n) }
}

pub fn ml_cluster_gmm_point_negate(pt : MlclustergmmPoint) -> MlclustergmmPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn ml_cluster_gmm_point_mid(a : MlclustergmmPoint, b : MlclustergmmPoint) -> MlclustergmmPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn ml_cluster_gmm_point_lerp(a : MlclustergmmPoint, b : MlclustergmmPoint, t : Double) -> MlclustergmmPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn ml_cluster_gmm_point_to_string(pt : MlclustergmmPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct MlclustergmmSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_cluster_gmm_make_series(vals : Array[Double], name : String) -> MlclustergmmSeries {
  { vals, name, meta: 0 }
}

pub fn ml_cluster_gmm_series_len(s : MlclustergmmSeries) -> Int { s.vals.length() }

pub fn ml_cluster_gmm_series_sum(s : MlclustergmmSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn ml_cluster_gmm_series_mean(s : MlclustergmmSeries) -> Double {
  let n = ml_cluster_gmm_series_len(s)
  if n == 0 { 0.0 } else { ml_cluster_gmm_series_sum(s) / n.to_double() }
}

pub fn ml_cluster_gmm_series_min(s : MlclustergmmSeries) -> Double {
  let n = ml_cluster_gmm_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn ml_cluster_gmm_series_max(s : MlclustergmmSeries) -> Double {
  let n = ml_cluster_gmm_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn ml_cluster_gmm_series_range(s : MlclustergmmSeries) -> Double {
  ml_cluster_gmm_series_max(s) - ml_cluster_gmm_series_min(s)
}

pub fn ml_cluster_gmm_series_var(s : MlclustergmmSeries) -> Double {
  let n = ml_cluster_gmm_series_len(s)
  if n == 0 { 0.0 } else {
    let m = ml_cluster_gmm_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn ml_cluster_gmm_series_std(s : MlclustergmmSeries) -> Double { @_common.sqrt(ml_cluster_gmm_series_var(s)) }

pub fn ml_cluster_gmm_series_median(s : MlclustergmmSeries) -> Double {
  let n = ml_cluster_gmm_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = ml_cluster_gmm_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn ml_cluster_gmm_series_scale(s : MlclustergmmSeries, f : Double) -> MlclustergmmSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn ml_cluster_gmm_series_add(a : MlclustergmmSeries, b : MlclustergmmSeries) -> MlclustergmmSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn ml_cluster_gmm_series_sub(a : MlclustergmmSeries, b : MlclustergmmSeries) -> MlclustergmmSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn ml_cluster_gmm_series_normalize(s : MlclustergmmSeries) -> MlclustergmmSeries {
  let mn = ml_cluster_gmm_series_min(s)
  let mx = ml_cluster_gmm_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn ml_cluster_gmm_series_cumsum(s : MlclustergmmSeries) -> MlclustergmmSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn ml_cluster_gmm_series_to_string(s : MlclustergmmSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlclustergmmMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_cluster_gmm_make_matrix(rows : Int, cols : Int, val : Double) -> MlclustergmmMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_cluster_gmm_matrix_identity(n : Int) -> MlclustergmmMatrix {
  let m = ml_cluster_gmm_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ml_cluster_gmm_matrix_get(m : MlclustergmmMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn ml_cluster_gmm_matrix_transpose(m : MlclustergmmMatrix) -> MlclustergmmMatrix {
  let result = ml_cluster_gmm_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn ml_cluster_gmm_matrix_add(a : MlclustergmmMatrix, b : MlclustergmmMatrix) -> MlclustergmmMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = ml_cluster_gmm_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn ml_cluster_gmm_matrix_scale(m : MlclustergmmMatrix, s : Double) -> MlclustergmmMatrix {
  let result = ml_cluster_gmm_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn ml_cluster_gmm_matrix_multiply(a : MlclustergmmMatrix, b : MlclustergmmMatrix) -> MlclustergmmMatrix {
  if a.cols != b.rows { return ml_cluster_gmm_make_matrix(a.rows, b.cols, 0.0) }
  let result = ml_cluster_gmm_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ml_cluster_gmm_matrix_trace(m : MlclustergmmMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn ml_cluster_gmm_matrix_det(m : MlclustergmmMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ml_cluster_gmm_matrix_norm(m : MlclustergmmMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ml_cluster_gmm_matrix_to_string(m : MlclustergmmMatrix) -> String {
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

pub(all) struct MlclustergmmVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_cluster_gmm_make_vector(comps : Array[Double]) -> MlclustergmmVector {
  { comps, dim: comps.length() }
}

pub fn ml_cluster_gmm_vector_zero(dim : Int) -> MlclustergmmVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ml_cluster_gmm_vector_add(a : MlclustergmmVector, b : MlclustergmmVector) -> MlclustergmmVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ml_cluster_gmm_vector_sub(a : MlclustergmmVector, b : MlclustergmmVector) -> MlclustergmmVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ml_cluster_gmm_vector_scale(v : MlclustergmmVector, s : Double) -> MlclustergmmVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn ml_cluster_gmm_vector_dot(a : MlclustergmmVector, b : MlclustergmmVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn ml_cluster_gmm_vector_norm(v : MlclustergmmVector) -> Double { @_common.sqrt(ml_cluster_gmm_vector_dot(v, v)) }

pub fn ml_cluster_gmm_vector_normalize(v : MlclustergmmVector) -> MlclustergmmVector {
  let n = ml_cluster_gmm_vector_norm(v)
  if n < 0.0000001 { v } else { ml_cluster_gmm_vector_scale(v, 1.0 / n) }
}

pub fn ml_cluster_gmm_vector_dist(a : MlclustergmmVector, b : MlclustergmmVector) -> Double {
  ml_cluster_gmm_vector_norm(ml_cluster_gmm_vector_sub(a, b))
}

pub fn ml_cluster_gmm_vector_to_string(v : MlclustergmmVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ml_cluster_gmm_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn ml_cluster_gmm_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = ml_cluster_gmm_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn ml_cluster_gmm_std(data : Array[Double]) -> Double { @_common.sqrt(ml_cluster_gmm_var(data)) }

pub fn ml_cluster_gmm_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = ml_cluster_gmm_mean(a); let mb = ml_cluster_gmm_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn ml_cluster_gmm_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = ml_cluster_gmm_std(a); let sb = ml_cluster_gmm_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { ml_cluster_gmm_cov(a, b) / (sa * sb) }
}

pub fn ml_cluster_gmm_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = ml_cluster_gmm_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn ml_cluster_gmm_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn ml_cluster_gmm_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn ml_cluster_gmm_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  @_common.sqrt(ml_cluster_gmm_mse(pred, labels))
}

pub fn ml_cluster_gmm_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn ml_cluster_gmm_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = ml_cluster_gmm_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn ml_cluster_gmm_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn ml_cluster_gmm_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn ml_cluster_gmm_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = ml_cluster_gmm_precision(pred, labels, pos); let r = ml_cluster_gmm_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn ml_cluster_gmm_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn ml_cluster_gmm_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = ml_cluster_gmm_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn ml_cluster_gmm_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn ml_cluster_gmm_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn ml_cluster_gmm_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = ml_cluster_gmm_gcd(a, b)
    (a / g) * b
  }
}

pub fn ml_cluster_gmm_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn ml_cluster_gmm_fibonacci(n : Int) -> Int {
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

pub fn ml_cluster_gmm_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = ml_cluster_gmm_min(data); let mx = ml_cluster_gmm_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn ml_cluster_gmm_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = ml_cluster_gmm_mean(data); let sd = ml_cluster_gmm_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn ml_cluster_gmm_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn ml_cluster_gmm_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn ml_cluster_gmm_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn ml_cluster_gmm_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn ml_cluster_gmm_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn ml_cluster_gmm_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

pub(all) struct MlclustergmmFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_gmm_frame_make(size : Int) -> MlclustergmmFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_gmm_frame_len(s : MlclustergmmFrame) -> Int { s.size }

pub fn ml_cluster_gmm_frame_get(s : MlclustergmmFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_gmm_frame_set(s : MlclustergmmFrame, i : Int, v : Double) -> MlclustergmmFrame {
  let result = ml_cluster_gmm_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_gmm_frame_sum(s : MlclustergmmFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_cluster_gmm_frame_mean(s : MlclustergmmFrame) -> Double {
  if s.size == 0 { 0.0 } else { ml_cluster_gmm_frame_sum(s) / s.size.to_double() }
}

pub fn ml_cluster_gmm_frame_scale(s : MlclustergmmFrame, f : Double) -> MlclustergmmFrame {
  let result = ml_cluster_gmm_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_cluster_gmm_frame_add(a : MlclustergmmFrame, b : MlclustergmmFrame) -> MlclustergmmFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_cluster_gmm_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_cluster_gmm_frame_copy(s : MlclustergmmFrame) -> MlclustergmmFrame {
  let result = ml_cluster_gmm_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_cluster_gmm_frame_fill(s : MlclustergmmFrame, v : Double) -> MlclustergmmFrame {
  let result = ml_cluster_gmm_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_gmm_frame_min(s : MlclustergmmFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_gmm_frame_max(s : MlclustergmmFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_gmm_frame_to_string(s : MlclustergmmFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclustergmmTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_gmm_table_make(size : Int) -> MlclustergmmTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_gmm_table_len(s : MlclustergmmTable) -> Int { s.size }

pub fn ml_cluster_gmm_table_get(s : MlclustergmmTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_gmm_table_set(s : MlclustergmmTable, i : Int, v : Double) -> MlclustergmmTable {
  let result = ml_cluster_gmm_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_gmm_table_sum(s : MlclustergmmTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_cluster_gmm_table_mean(s : MlclustergmmTable) -> Double {
  if s.size == 0 { 0.0 } else { ml_cluster_gmm_table_sum(s) / s.size.to_double() }
}

pub fn ml_cluster_gmm_table_scale(s : MlclustergmmTable, f : Double) -> MlclustergmmTable {
  let result = ml_cluster_gmm_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_cluster_gmm_table_add(a : MlclustergmmTable, b : MlclustergmmTable) -> MlclustergmmTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_cluster_gmm_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_cluster_gmm_table_copy(s : MlclustergmmTable) -> MlclustergmmTable {
  let result = ml_cluster_gmm_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_cluster_gmm_table_fill(s : MlclustergmmTable, v : Double) -> MlclustergmmTable {
  let result = ml_cluster_gmm_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_gmm_table_min(s : MlclustergmmTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_gmm_table_max(s : MlclustergmmTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_gmm_table_to_string(s : MlclustergmmTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclustergmmGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_gmm_graphn_make(size : Int) -> MlclustergmmGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_gmm_graphn_len(s : MlclustergmmGraphN) -> Int { s.size }

pub fn ml_cluster_gmm_graphn_get(s : MlclustergmmGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_gmm_graphn_set(s : MlclustergmmGraphN, i : Int, v : Double) -> MlclustergmmGraphN {
  let result = ml_cluster_gmm_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_gmm_graphn_sum(s : MlclustergmmGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_cluster_gmm_graphn_mean(s : MlclustergmmGraphN) -> Double {
  if s.size == 0 { 0.0 } else { ml_cluster_gmm_graphn_sum(s) / s.size.to_double() }
}

pub fn ml_cluster_gmm_graphn_scale(s : MlclustergmmGraphN, f : Double) -> MlclustergmmGraphN {
  let result = ml_cluster_gmm_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_cluster_gmm_graphn_add(a : MlclustergmmGraphN, b : MlclustergmmGraphN) -> MlclustergmmGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_cluster_gmm_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_cluster_gmm_graphn_copy(s : MlclustergmmGraphN) -> MlclustergmmGraphN {
  let result = ml_cluster_gmm_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_cluster_gmm_graphn_fill(s : MlclustergmmGraphN, v : Double) -> MlclustergmmGraphN {
  let result = ml_cluster_gmm_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_gmm_graphn_min(s : MlclustergmmGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_gmm_graphn_max(s : MlclustergmmGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_gmm_graphn_to_string(s : MlclustergmmGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclustergmmNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_gmm_node_make(size : Int) -> MlclustergmmNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_gmm_node_len(s : MlclustergmmNode) -> Int { s.size }

pub fn ml_cluster_gmm_node_get(s : MlclustergmmNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_gmm_node_set(s : MlclustergmmNode, i : Int, v : Double) -> MlclustergmmNode {
  let result = ml_cluster_gmm_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_gmm_node_sum(s : MlclustergmmNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_cluster_gmm_node_mean(s : MlclustergmmNode) -> Double {
  if s.size == 0 { 0.0 } else { ml_cluster_gmm_node_sum(s) / s.size.to_double() }
}

pub fn ml_cluster_gmm_node_scale(s : MlclustergmmNode, f : Double) -> MlclustergmmNode {
  let result = ml_cluster_gmm_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_cluster_gmm_node_add(a : MlclustergmmNode, b : MlclustergmmNode) -> MlclustergmmNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_cluster_gmm_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_cluster_gmm_node_copy(s : MlclustergmmNode) -> MlclustergmmNode {
  let result = ml_cluster_gmm_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_cluster_gmm_node_fill(s : MlclustergmmNode, v : Double) -> MlclustergmmNode {
  let result = ml_cluster_gmm_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_gmm_node_min(s : MlclustergmmNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_gmm_node_max(s : MlclustergmmNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_gmm_node_to_string(s : MlclustergmmNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclustergmmEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_gmm_edge_make(size : Int) -> MlclustergmmEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_gmm_edge_len(s : MlclustergmmEdge) -> Int { s.size }

pub fn ml_cluster_gmm_edge_get(s : MlclustergmmEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_gmm_edge_set(s : MlclustergmmEdge, i : Int, v : Double) -> MlclustergmmEdge {
  let result = ml_cluster_gmm_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_gmm_edge_sum(s : MlclustergmmEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_cluster_gmm_edge_mean(s : MlclustergmmEdge) -> Double {
  if s.size == 0 { 0.0 } else { ml_cluster_gmm_edge_sum(s) / s.size.to_double() }
}

pub fn ml_cluster_gmm_edge_scale(s : MlclustergmmEdge, f : Double) -> MlclustergmmEdge {
  let result = ml_cluster_gmm_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_cluster_gmm_edge_add(a : MlclustergmmEdge, b : MlclustergmmEdge) -> MlclustergmmEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_cluster_gmm_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_cluster_gmm_edge_copy(s : MlclustergmmEdge) -> MlclustergmmEdge {
  let result = ml_cluster_gmm_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_cluster_gmm_edge_fill(s : MlclustergmmEdge, v : Double) -> MlclustergmmEdge {
  let result = ml_cluster_gmm_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_gmm_edge_min(s : MlclustergmmEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_gmm_edge_max(s : MlclustergmmEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_gmm_edge_to_string(s : MlclustergmmEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclustergmmPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_gmm_path_make(size : Int) -> MlclustergmmPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_gmm_path_len(s : MlclustergmmPath) -> Int { s.size }

pub fn ml_cluster_gmm_path_get(s : MlclustergmmPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_gmm_path_set(s : MlclustergmmPath, i : Int, v : Double) -> MlclustergmmPath {
  let result = ml_cluster_gmm_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_gmm_path_sum(s : MlclustergmmPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_cluster_gmm_path_mean(s : MlclustergmmPath) -> Double {
  if s.size == 0 { 0.0 } else { ml_cluster_gmm_path_sum(s) / s.size.to_double() }
}

pub fn ml_cluster_gmm_path_scale(s : MlclustergmmPath, f : Double) -> MlclustergmmPath {
  let result = ml_cluster_gmm_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_cluster_gmm_path_add(a : MlclustergmmPath, b : MlclustergmmPath) -> MlclustergmmPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_cluster_gmm_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_cluster_gmm_path_copy(s : MlclustergmmPath) -> MlclustergmmPath {
  let result = ml_cluster_gmm_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_cluster_gmm_path_fill(s : MlclustergmmPath, v : Double) -> MlclustergmmPath {
  let result = ml_cluster_gmm_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_gmm_path_min(s : MlclustergmmPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_gmm_path_max(s : MlclustergmmPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_gmm_path_to_string(s : MlclustergmmPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclustergmmCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_gmm_cluster_make(size : Int) -> MlclustergmmCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_gmm_cluster_len(s : MlclustergmmCluster) -> Int { s.size }

pub fn ml_cluster_gmm_cluster_get(s : MlclustergmmCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_gmm_cluster_set(s : MlclustergmmCluster, i : Int, v : Double) -> MlclustergmmCluster {
  let result = ml_cluster_gmm_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_gmm_cluster_sum(s : MlclustergmmCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_cluster_gmm_cluster_mean(s : MlclustergmmCluster) -> Double {
  if s.size == 0 { 0.0 } else { ml_cluster_gmm_cluster_sum(s) / s.size.to_double() }
}

pub fn ml_cluster_gmm_cluster_scale(s : MlclustergmmCluster, f : Double) -> MlclustergmmCluster {
  let result = ml_cluster_gmm_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_cluster_gmm_cluster_add(a : MlclustergmmCluster, b : MlclustergmmCluster) -> MlclustergmmCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_cluster_gmm_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_cluster_gmm_cluster_copy(s : MlclustergmmCluster) -> MlclustergmmCluster {
  let result = ml_cluster_gmm_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_cluster_gmm_cluster_fill(s : MlclustergmmCluster, v : Double) -> MlclustergmmCluster {
  let result = ml_cluster_gmm_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_gmm_cluster_min(s : MlclustergmmCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_gmm_cluster_max(s : MlclustergmmCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_gmm_cluster_to_string(s : MlclustergmmCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclustergmmModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_gmm_model_make(size : Int) -> MlclustergmmModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_gmm_model_len(s : MlclustergmmModel) -> Int { s.size }

pub fn ml_cluster_gmm_model_get(s : MlclustergmmModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_gmm_model_set(s : MlclustergmmModel, i : Int, v : Double) -> MlclustergmmModel {
  let result = ml_cluster_gmm_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_gmm_model_sum(s : MlclustergmmModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_cluster_gmm_model_mean(s : MlclustergmmModel) -> Double {
  if s.size == 0 { 0.0 } else { ml_cluster_gmm_model_sum(s) / s.size.to_double() }
}

pub fn ml_cluster_gmm_model_scale(s : MlclustergmmModel, f : Double) -> MlclustergmmModel {
  let result = ml_cluster_gmm_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_cluster_gmm_model_add(a : MlclustergmmModel, b : MlclustergmmModel) -> MlclustergmmModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_cluster_gmm_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_cluster_gmm_model_copy(s : MlclustergmmModel) -> MlclustergmmModel {
  let result = ml_cluster_gmm_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_cluster_gmm_model_fill(s : MlclustergmmModel, v : Double) -> MlclustergmmModel {
  let result = ml_cluster_gmm_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_gmm_model_min(s : MlclustergmmModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_gmm_model_max(s : MlclustergmmModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_gmm_model_to_string(s : MlclustergmmModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclustergmmLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_gmm_layer_make(size : Int) -> MlclustergmmLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_gmm_layer_len(s : MlclustergmmLayer) -> Int { s.size }

pub fn ml_cluster_gmm_layer_get(s : MlclustergmmLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_gmm_layer_set(s : MlclustergmmLayer, i : Int, v : Double) -> MlclustergmmLayer {
  let result = ml_cluster_gmm_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_gmm_layer_sum(s : MlclustergmmLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_cluster_gmm_layer_mean(s : MlclustergmmLayer) -> Double {
  if s.size == 0 { 0.0 } else { ml_cluster_gmm_layer_sum(s) / s.size.to_double() }
}

pub fn ml_cluster_gmm_layer_scale(s : MlclustergmmLayer, f : Double) -> MlclustergmmLayer {
  let result = ml_cluster_gmm_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_cluster_gmm_layer_add(a : MlclustergmmLayer, b : MlclustergmmLayer) -> MlclustergmmLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_cluster_gmm_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_cluster_gmm_layer_copy(s : MlclustergmmLayer) -> MlclustergmmLayer {
  let result = ml_cluster_gmm_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_cluster_gmm_layer_fill(s : MlclustergmmLayer, v : Double) -> MlclustergmmLayer {
  let result = ml_cluster_gmm_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_gmm_layer_min(s : MlclustergmmLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_gmm_layer_max(s : MlclustergmmLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_gmm_layer_to_string(s : MlclustergmmLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclustergmmBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_gmm_buffer_make(size : Int) -> MlclustergmmBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_gmm_buffer_len(s : MlclustergmmBuffer) -> Int { s.size }

pub fn ml_cluster_gmm_buffer_get(s : MlclustergmmBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_gmm_buffer_set(s : MlclustergmmBuffer, i : Int, v : Double) -> MlclustergmmBuffer {
  let result = ml_cluster_gmm_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_gmm_buffer_sum(s : MlclustergmmBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_cluster_gmm_buffer_mean(s : MlclustergmmBuffer) -> Double {
  if s.size == 0 { 0.0 } else { ml_cluster_gmm_buffer_sum(s) / s.size.to_double() }
}

pub fn ml_cluster_gmm_buffer_scale(s : MlclustergmmBuffer, f : Double) -> MlclustergmmBuffer {
  let result = ml_cluster_gmm_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_cluster_gmm_buffer_add(a : MlclustergmmBuffer, b : MlclustergmmBuffer) -> MlclustergmmBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_cluster_gmm_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_cluster_gmm_buffer_copy(s : MlclustergmmBuffer) -> MlclustergmmBuffer {
  let result = ml_cluster_gmm_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_cluster_gmm_buffer_fill(s : MlclustergmmBuffer, v : Double) -> MlclustergmmBuffer {
  let result = ml_cluster_gmm_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_gmm_buffer_min(s : MlclustergmmBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_gmm_buffer_max(s : MlclustergmmBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_gmm_buffer_to_string(s : MlclustergmmBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclustergmmCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_gmm_cursor_make(size : Int) -> MlclustergmmCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_gmm_cursor_len(s : MlclustergmmCursor) -> Int { s.size }

pub fn ml_cluster_gmm_cursor_get(s : MlclustergmmCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_gmm_cursor_set(s : MlclustergmmCursor, i : Int, v : Double) -> MlclustergmmCursor {
  let result = ml_cluster_gmm_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_gmm_cursor_sum(s : MlclustergmmCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_cluster_gmm_cursor_mean(s : MlclustergmmCursor) -> Double {
  if s.size == 0 { 0.0 } else { ml_cluster_gmm_cursor_sum(s) / s.size.to_double() }
}

pub fn ml_cluster_gmm_cursor_scale(s : MlclustergmmCursor, f : Double) -> MlclustergmmCursor {
  let result = ml_cluster_gmm_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_cluster_gmm_cursor_add(a : MlclustergmmCursor, b : MlclustergmmCursor) -> MlclustergmmCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_cluster_gmm_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_cluster_gmm_cursor_copy(s : MlclustergmmCursor) -> MlclustergmmCursor {
  let result = ml_cluster_gmm_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_cluster_gmm_cursor_fill(s : MlclustergmmCursor, v : Double) -> MlclustergmmCursor {
  let result = ml_cluster_gmm_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_gmm_cursor_min(s : MlclustergmmCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_gmm_cursor_max(s : MlclustergmmCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_gmm_cursor_to_string(s : MlclustergmmCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclustergmmView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_gmm_view_make(size : Int) -> MlclustergmmView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_gmm_view_len(s : MlclustergmmView) -> Int { s.size }

pub fn ml_cluster_gmm_view_get(s : MlclustergmmView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_gmm_view_set(s : MlclustergmmView, i : Int, v : Double) -> MlclustergmmView {
  let result = ml_cluster_gmm_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_gmm_view_sum(s : MlclustergmmView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_cluster_gmm_view_mean(s : MlclustergmmView) -> Double {
  if s.size == 0 { 0.0 } else { ml_cluster_gmm_view_sum(s) / s.size.to_double() }
}

pub fn ml_cluster_gmm_view_scale(s : MlclustergmmView, f : Double) -> MlclustergmmView {
  let result = ml_cluster_gmm_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_cluster_gmm_view_add(a : MlclustergmmView, b : MlclustergmmView) -> MlclustergmmView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_cluster_gmm_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_cluster_gmm_view_copy(s : MlclustergmmView) -> MlclustergmmView {
  let result = ml_cluster_gmm_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_cluster_gmm_view_fill(s : MlclustergmmView, v : Double) -> MlclustergmmView {
  let result = ml_cluster_gmm_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_gmm_view_min(s : MlclustergmmView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_gmm_view_max(s : MlclustergmmView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_gmm_view_to_string(s : MlclustergmmView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclustergmmRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_gmm_range_make(size : Int) -> MlclustergmmRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_gmm_range_len(s : MlclustergmmRange) -> Int { s.size }

pub fn ml_cluster_gmm_range_get(s : MlclustergmmRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_gmm_range_set(s : MlclustergmmRange, i : Int, v : Double) -> MlclustergmmRange {
  let result = ml_cluster_gmm_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_gmm_range_sum(s : MlclustergmmRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_cluster_gmm_range_mean(s : MlclustergmmRange) -> Double {
  if s.size == 0 { 0.0 } else { ml_cluster_gmm_range_sum(s) / s.size.to_double() }
}

pub fn ml_cluster_gmm_range_scale(s : MlclustergmmRange, f : Double) -> MlclustergmmRange {
  let result = ml_cluster_gmm_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_cluster_gmm_range_add(a : MlclustergmmRange, b : MlclustergmmRange) -> MlclustergmmRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_cluster_gmm_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_cluster_gmm_range_copy(s : MlclustergmmRange) -> MlclustergmmRange {
  let result = ml_cluster_gmm_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_cluster_gmm_range_fill(s : MlclustergmmRange, v : Double) -> MlclustergmmRange {
  let result = ml_cluster_gmm_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_gmm_range_min(s : MlclustergmmRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_gmm_range_max(s : MlclustergmmRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_gmm_range_to_string(s : MlclustergmmRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclustergmmSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_gmm_slice_make(size : Int) -> MlclustergmmSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_gmm_slice_len(s : MlclustergmmSlice) -> Int { s.size }

pub fn ml_cluster_gmm_slice_get(s : MlclustergmmSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_gmm_slice_set(s : MlclustergmmSlice, i : Int, v : Double) -> MlclustergmmSlice {
  let result = ml_cluster_gmm_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_gmm_slice_sum(s : MlclustergmmSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_cluster_gmm_slice_mean(s : MlclustergmmSlice) -> Double {
  if s.size == 0 { 0.0 } else { ml_cluster_gmm_slice_sum(s) / s.size.to_double() }
}

pub fn ml_cluster_gmm_slice_scale(s : MlclustergmmSlice, f : Double) -> MlclustergmmSlice {
  let result = ml_cluster_gmm_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_cluster_gmm_slice_add(a : MlclustergmmSlice, b : MlclustergmmSlice) -> MlclustergmmSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_cluster_gmm_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_cluster_gmm_slice_copy(s : MlclustergmmSlice) -> MlclustergmmSlice {
  let result = ml_cluster_gmm_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_cluster_gmm_slice_fill(s : MlclustergmmSlice, v : Double) -> MlclustergmmSlice {
  let result = ml_cluster_gmm_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_gmm_slice_min(s : MlclustergmmSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_gmm_slice_max(s : MlclustergmmSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_gmm_slice_to_string(s : MlclustergmmSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

