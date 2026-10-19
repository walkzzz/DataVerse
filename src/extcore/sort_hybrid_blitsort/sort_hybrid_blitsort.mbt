///===
/// extcore/sort_hybrid_blitsort

pub(all) struct SorthybridblitsortPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn sort_hybrid_blitsort_make_point(x : Double, y : Double) -> SorthybridblitsortPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn sort_hybrid_blitsort_make_point3(x : Double, y : Double, z : Double) -> SorthybridblitsortPoint {
  { x, y, z, label: 0 }
}

pub fn sort_hybrid_blitsort_point_x(pt : SorthybridblitsortPoint) -> Double { pt.x }

pub fn sort_hybrid_blitsort_point_y(pt : SorthybridblitsortPoint) -> Double { pt.y }

pub fn sort_hybrid_blitsort_point_z(pt : SorthybridblitsortPoint) -> Double { pt.z }

pub fn sort_hybrid_blitsort_point_label(pt : SorthybridblitsortPoint) -> Int { pt.label }

pub fn sort_hybrid_blitsort_point_dist(a : SorthybridblitsortPoint, b : SorthybridblitsortPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn sort_hybrid_blitsort_point_add(a : SorthybridblitsortPoint, b : SorthybridblitsortPoint) -> SorthybridblitsortPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn sort_hybrid_blitsort_point_sub(a : SorthybridblitsortPoint, b : SorthybridblitsortPoint) -> SorthybridblitsortPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn sort_hybrid_blitsort_point_scale(pt : SorthybridblitsortPoint, s : Double) -> SorthybridblitsortPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn sort_hybrid_blitsort_point_dot(a : SorthybridblitsortPoint, b : SorthybridblitsortPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn sort_hybrid_blitsort_point_cross(a : SorthybridblitsortPoint, b : SorthybridblitsortPoint) -> SorthybridblitsortPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn sort_hybrid_blitsort_point_norm(pt : SorthybridblitsortPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn sort_hybrid_blitsort_point_normalize(pt : SorthybridblitsortPoint) -> SorthybridblitsortPoint {
  let n = sort_hybrid_blitsort_point_norm(pt)
  if n < 0.0000001 { pt } else { sort_hybrid_blitsort_point_scale(pt, 1.0 / n) }
}

pub fn sort_hybrid_blitsort_point_negate(pt : SorthybridblitsortPoint) -> SorthybridblitsortPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn sort_hybrid_blitsort_point_mid(a : SorthybridblitsortPoint, b : SorthybridblitsortPoint) -> SorthybridblitsortPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn sort_hybrid_blitsort_point_lerp(a : SorthybridblitsortPoint, b : SorthybridblitsortPoint, t : Double) -> SorthybridblitsortPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn sort_hybrid_blitsort_point_to_string(pt : SorthybridblitsortPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct SorthybridblitsortSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn sort_hybrid_blitsort_make_series(vals : Array[Double], name : String) -> SorthybridblitsortSeries {
  { vals, name, meta: 0 }
}

pub fn sort_hybrid_blitsort_series_len(s : SorthybridblitsortSeries) -> Int { s.vals.length() }

pub fn sort_hybrid_blitsort_series_sum(s : SorthybridblitsortSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn sort_hybrid_blitsort_series_mean(s : SorthybridblitsortSeries) -> Double {
  let n = sort_hybrid_blitsort_series_len(s)
  if n == 0 { 0.0 } else { sort_hybrid_blitsort_series_sum(s) / n.to_double() }
}

pub fn sort_hybrid_blitsort_series_min(s : SorthybridblitsortSeries) -> Double {
  let n = sort_hybrid_blitsort_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn sort_hybrid_blitsort_series_max(s : SorthybridblitsortSeries) -> Double {
  let n = sort_hybrid_blitsort_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn sort_hybrid_blitsort_series_range(s : SorthybridblitsortSeries) -> Double {
  sort_hybrid_blitsort_series_max(s) - sort_hybrid_blitsort_series_min(s)
}

pub fn sort_hybrid_blitsort_series_var(s : SorthybridblitsortSeries) -> Double {
  let n = sort_hybrid_blitsort_series_len(s)
  if n == 0 { 0.0 } else {
    let m = sort_hybrid_blitsort_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn sort_hybrid_blitsort_series_std(s : SorthybridblitsortSeries) -> Double { @_common.sqrt(sort_hybrid_blitsort_series_var(s)) }

pub fn sort_hybrid_blitsort_series_median(s : SorthybridblitsortSeries) -> Double {
  let n = sort_hybrid_blitsort_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = sort_hybrid_blitsort_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn sort_hybrid_blitsort_series_scale(s : SorthybridblitsortSeries, f : Double) -> SorthybridblitsortSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn sort_hybrid_blitsort_series_add(a : SorthybridblitsortSeries, b : SorthybridblitsortSeries) -> SorthybridblitsortSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn sort_hybrid_blitsort_series_sub(a : SorthybridblitsortSeries, b : SorthybridblitsortSeries) -> SorthybridblitsortSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn sort_hybrid_blitsort_series_normalize(s : SorthybridblitsortSeries) -> SorthybridblitsortSeries {
  let mn = sort_hybrid_blitsort_series_min(s)
  let mx = sort_hybrid_blitsort_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn sort_hybrid_blitsort_series_cumsum(s : SorthybridblitsortSeries) -> SorthybridblitsortSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn sort_hybrid_blitsort_series_to_string(s : SorthybridblitsortSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SorthybridblitsortMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn sort_hybrid_blitsort_make_matrix(rows : Int, cols : Int, val : Double) -> SorthybridblitsortMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn sort_hybrid_blitsort_matrix_identity(n : Int) -> SorthybridblitsortMatrix {
  let m = sort_hybrid_blitsort_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn sort_hybrid_blitsort_matrix_get(m : SorthybridblitsortMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn sort_hybrid_blitsort_matrix_transpose(m : SorthybridblitsortMatrix) -> SorthybridblitsortMatrix {
  let result = sort_hybrid_blitsort_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn sort_hybrid_blitsort_matrix_add(a : SorthybridblitsortMatrix, b : SorthybridblitsortMatrix) -> SorthybridblitsortMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = sort_hybrid_blitsort_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn sort_hybrid_blitsort_matrix_scale(m : SorthybridblitsortMatrix, s : Double) -> SorthybridblitsortMatrix {
  let result = sort_hybrid_blitsort_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn sort_hybrid_blitsort_matrix_multiply(a : SorthybridblitsortMatrix, b : SorthybridblitsortMatrix) -> SorthybridblitsortMatrix {
  if a.cols != b.rows { return sort_hybrid_blitsort_make_matrix(a.rows, b.cols, 0.0) }
  let result = sort_hybrid_blitsort_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn sort_hybrid_blitsort_matrix_trace(m : SorthybridblitsortMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn sort_hybrid_blitsort_matrix_det(m : SorthybridblitsortMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn sort_hybrid_blitsort_matrix_norm(m : SorthybridblitsortMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn sort_hybrid_blitsort_matrix_to_string(m : SorthybridblitsortMatrix) -> String {
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

pub(all) struct SorthybridblitsortVector {
  comps : Array[Double]
  dim : Int
}

pub fn sort_hybrid_blitsort_make_vector(comps : Array[Double]) -> SorthybridblitsortVector {
  { comps, dim: comps.length() }
}

pub fn sort_hybrid_blitsort_vector_zero(dim : Int) -> SorthybridblitsortVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn sort_hybrid_blitsort_vector_add(a : SorthybridblitsortVector, b : SorthybridblitsortVector) -> SorthybridblitsortVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn sort_hybrid_blitsort_vector_sub(a : SorthybridblitsortVector, b : SorthybridblitsortVector) -> SorthybridblitsortVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn sort_hybrid_blitsort_vector_scale(v : SorthybridblitsortVector, s : Double) -> SorthybridblitsortVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn sort_hybrid_blitsort_vector_dot(a : SorthybridblitsortVector, b : SorthybridblitsortVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn sort_hybrid_blitsort_vector_norm(v : SorthybridblitsortVector) -> Double { @_common.sqrt(sort_hybrid_blitsort_vector_dot(v, v)) }

pub fn sort_hybrid_blitsort_vector_normalize(v : SorthybridblitsortVector) -> SorthybridblitsortVector {
  let n = sort_hybrid_blitsort_vector_norm(v)
  if n < 0.0000001 { v } else { sort_hybrid_blitsort_vector_scale(v, 1.0 / n) }
}

pub fn sort_hybrid_blitsort_vector_dist(a : SorthybridblitsortVector, b : SorthybridblitsortVector) -> Double {
  sort_hybrid_blitsort_vector_norm(sort_hybrid_blitsort_vector_sub(a, b))
}

pub fn sort_hybrid_blitsort_vector_to_string(v : SorthybridblitsortVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn sort_hybrid_blitsort_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn sort_hybrid_blitsort_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = sort_hybrid_blitsort_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn sort_hybrid_blitsort_std(data : Array[Double]) -> Double { @_common.sqrt(sort_hybrid_blitsort_var(data)) }

pub fn sort_hybrid_blitsort_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = sort_hybrid_blitsort_mean(a); let mb = sort_hybrid_blitsort_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn sort_hybrid_blitsort_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = sort_hybrid_blitsort_std(a); let sb = sort_hybrid_blitsort_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { sort_hybrid_blitsort_cov(a, b) / (sa * sb) }
}

pub fn sort_hybrid_blitsort_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = sort_hybrid_blitsort_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn sort_hybrid_blitsort_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn sort_hybrid_blitsort_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn sort_hybrid_blitsort_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  @_common.sqrt(sort_hybrid_blitsort_mse(pred, labels))
}

pub fn sort_hybrid_blitsort_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn sort_hybrid_blitsort_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = sort_hybrid_blitsort_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn sort_hybrid_blitsort_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn sort_hybrid_blitsort_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn sort_hybrid_blitsort_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = sort_hybrid_blitsort_precision(pred, labels, pos); let r = sort_hybrid_blitsort_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn sort_hybrid_blitsort_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn sort_hybrid_blitsort_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = sort_hybrid_blitsort_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn sort_hybrid_blitsort_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn sort_hybrid_blitsort_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn sort_hybrid_blitsort_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = sort_hybrid_blitsort_gcd(a, b)
    (a / g) * b
  }
}

pub fn sort_hybrid_blitsort_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn sort_hybrid_blitsort_fibonacci(n : Int) -> Int {
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

pub fn sort_hybrid_blitsort_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = sort_hybrid_blitsort_min(data); let mx = sort_hybrid_blitsort_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn sort_hybrid_blitsort_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = sort_hybrid_blitsort_mean(data); let sd = sort_hybrid_blitsort_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn sort_hybrid_blitsort_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn sort_hybrid_blitsort_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn sort_hybrid_blitsort_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn sort_hybrid_blitsort_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn sort_hybrid_blitsort_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn sort_hybrid_blitsort_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

pub(all) struct SorthybridblitsortFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_blitsort_frame_make(size : Int) -> SorthybridblitsortFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_blitsort_frame_len(s : SorthybridblitsortFrame) -> Int { s.size }

pub fn sort_hybrid_blitsort_frame_get(s : SorthybridblitsortFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_blitsort_frame_set(s : SorthybridblitsortFrame, i : Int, v : Double) -> SorthybridblitsortFrame {
  let result = sort_hybrid_blitsort_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_hybrid_blitsort_frame_sum(s : SorthybridblitsortFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_hybrid_blitsort_frame_mean(s : SorthybridblitsortFrame) -> Double {
  if s.size == 0 { 0.0 } else { sort_hybrid_blitsort_frame_sum(s) / s.size.to_double() }
}

pub fn sort_hybrid_blitsort_frame_scale(s : SorthybridblitsortFrame, f : Double) -> SorthybridblitsortFrame {
  let result = sort_hybrid_blitsort_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_hybrid_blitsort_frame_add(a : SorthybridblitsortFrame, b : SorthybridblitsortFrame) -> SorthybridblitsortFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_hybrid_blitsort_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_hybrid_blitsort_frame_copy(s : SorthybridblitsortFrame) -> SorthybridblitsortFrame {
  let result = sort_hybrid_blitsort_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_hybrid_blitsort_frame_fill(s : SorthybridblitsortFrame, v : Double) -> SorthybridblitsortFrame {
  let result = sort_hybrid_blitsort_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_hybrid_blitsort_frame_min(s : SorthybridblitsortFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_hybrid_blitsort_frame_max(s : SorthybridblitsortFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_hybrid_blitsort_frame_to_string(s : SorthybridblitsortFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridblitsortTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_blitsort_table_make(size : Int) -> SorthybridblitsortTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_blitsort_table_len(s : SorthybridblitsortTable) -> Int { s.size }

pub fn sort_hybrid_blitsort_table_get(s : SorthybridblitsortTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_blitsort_table_set(s : SorthybridblitsortTable, i : Int, v : Double) -> SorthybridblitsortTable {
  let result = sort_hybrid_blitsort_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_hybrid_blitsort_table_sum(s : SorthybridblitsortTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_hybrid_blitsort_table_mean(s : SorthybridblitsortTable) -> Double {
  if s.size == 0 { 0.0 } else { sort_hybrid_blitsort_table_sum(s) / s.size.to_double() }
}

pub fn sort_hybrid_blitsort_table_scale(s : SorthybridblitsortTable, f : Double) -> SorthybridblitsortTable {
  let result = sort_hybrid_blitsort_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_hybrid_blitsort_table_add(a : SorthybridblitsortTable, b : SorthybridblitsortTable) -> SorthybridblitsortTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_hybrid_blitsort_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_hybrid_blitsort_table_copy(s : SorthybridblitsortTable) -> SorthybridblitsortTable {
  let result = sort_hybrid_blitsort_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_hybrid_blitsort_table_fill(s : SorthybridblitsortTable, v : Double) -> SorthybridblitsortTable {
  let result = sort_hybrid_blitsort_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_hybrid_blitsort_table_min(s : SorthybridblitsortTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_hybrid_blitsort_table_max(s : SorthybridblitsortTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_hybrid_blitsort_table_to_string(s : SorthybridblitsortTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridblitsortGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_blitsort_graphn_make(size : Int) -> SorthybridblitsortGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_blitsort_graphn_len(s : SorthybridblitsortGraphN) -> Int { s.size }

pub fn sort_hybrid_blitsort_graphn_get(s : SorthybridblitsortGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_blitsort_graphn_set(s : SorthybridblitsortGraphN, i : Int, v : Double) -> SorthybridblitsortGraphN {
  let result = sort_hybrid_blitsort_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_hybrid_blitsort_graphn_sum(s : SorthybridblitsortGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_hybrid_blitsort_graphn_mean(s : SorthybridblitsortGraphN) -> Double {
  if s.size == 0 { 0.0 } else { sort_hybrid_blitsort_graphn_sum(s) / s.size.to_double() }
}

pub fn sort_hybrid_blitsort_graphn_scale(s : SorthybridblitsortGraphN, f : Double) -> SorthybridblitsortGraphN {
  let result = sort_hybrid_blitsort_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_hybrid_blitsort_graphn_add(a : SorthybridblitsortGraphN, b : SorthybridblitsortGraphN) -> SorthybridblitsortGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_hybrid_blitsort_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_hybrid_blitsort_graphn_copy(s : SorthybridblitsortGraphN) -> SorthybridblitsortGraphN {
  let result = sort_hybrid_blitsort_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_hybrid_blitsort_graphn_fill(s : SorthybridblitsortGraphN, v : Double) -> SorthybridblitsortGraphN {
  let result = sort_hybrid_blitsort_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_hybrid_blitsort_graphn_min(s : SorthybridblitsortGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_hybrid_blitsort_graphn_max(s : SorthybridblitsortGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_hybrid_blitsort_graphn_to_string(s : SorthybridblitsortGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridblitsortNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_blitsort_node_make(size : Int) -> SorthybridblitsortNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_blitsort_node_len(s : SorthybridblitsortNode) -> Int { s.size }

pub fn sort_hybrid_blitsort_node_get(s : SorthybridblitsortNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_blitsort_node_set(s : SorthybridblitsortNode, i : Int, v : Double) -> SorthybridblitsortNode {
  let result = sort_hybrid_blitsort_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_hybrid_blitsort_node_sum(s : SorthybridblitsortNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_hybrid_blitsort_node_mean(s : SorthybridblitsortNode) -> Double {
  if s.size == 0 { 0.0 } else { sort_hybrid_blitsort_node_sum(s) / s.size.to_double() }
}

pub fn sort_hybrid_blitsort_node_scale(s : SorthybridblitsortNode, f : Double) -> SorthybridblitsortNode {
  let result = sort_hybrid_blitsort_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_hybrid_blitsort_node_add(a : SorthybridblitsortNode, b : SorthybridblitsortNode) -> SorthybridblitsortNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_hybrid_blitsort_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_hybrid_blitsort_node_copy(s : SorthybridblitsortNode) -> SorthybridblitsortNode {
  let result = sort_hybrid_blitsort_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_hybrid_blitsort_node_fill(s : SorthybridblitsortNode, v : Double) -> SorthybridblitsortNode {
  let result = sort_hybrid_blitsort_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_hybrid_blitsort_node_min(s : SorthybridblitsortNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_hybrid_blitsort_node_max(s : SorthybridblitsortNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_hybrid_blitsort_node_to_string(s : SorthybridblitsortNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridblitsortEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_blitsort_edge_make(size : Int) -> SorthybridblitsortEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_blitsort_edge_len(s : SorthybridblitsortEdge) -> Int { s.size }

pub fn sort_hybrid_blitsort_edge_get(s : SorthybridblitsortEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_blitsort_edge_set(s : SorthybridblitsortEdge, i : Int, v : Double) -> SorthybridblitsortEdge {
  let result = sort_hybrid_blitsort_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_hybrid_blitsort_edge_sum(s : SorthybridblitsortEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_hybrid_blitsort_edge_mean(s : SorthybridblitsortEdge) -> Double {
  if s.size == 0 { 0.0 } else { sort_hybrid_blitsort_edge_sum(s) / s.size.to_double() }
}

pub fn sort_hybrid_blitsort_edge_scale(s : SorthybridblitsortEdge, f : Double) -> SorthybridblitsortEdge {
  let result = sort_hybrid_blitsort_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_hybrid_blitsort_edge_add(a : SorthybridblitsortEdge, b : SorthybridblitsortEdge) -> SorthybridblitsortEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_hybrid_blitsort_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_hybrid_blitsort_edge_copy(s : SorthybridblitsortEdge) -> SorthybridblitsortEdge {
  let result = sort_hybrid_blitsort_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_hybrid_blitsort_edge_fill(s : SorthybridblitsortEdge, v : Double) -> SorthybridblitsortEdge {
  let result = sort_hybrid_blitsort_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_hybrid_blitsort_edge_min(s : SorthybridblitsortEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_hybrid_blitsort_edge_max(s : SorthybridblitsortEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_hybrid_blitsort_edge_to_string(s : SorthybridblitsortEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridblitsortPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_blitsort_path_make(size : Int) -> SorthybridblitsortPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_blitsort_path_len(s : SorthybridblitsortPath) -> Int { s.size }

pub fn sort_hybrid_blitsort_path_get(s : SorthybridblitsortPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_blitsort_path_set(s : SorthybridblitsortPath, i : Int, v : Double) -> SorthybridblitsortPath {
  let result = sort_hybrid_blitsort_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_hybrid_blitsort_path_sum(s : SorthybridblitsortPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_hybrid_blitsort_path_mean(s : SorthybridblitsortPath) -> Double {
  if s.size == 0 { 0.0 } else { sort_hybrid_blitsort_path_sum(s) / s.size.to_double() }
}

pub fn sort_hybrid_blitsort_path_scale(s : SorthybridblitsortPath, f : Double) -> SorthybridblitsortPath {
  let result = sort_hybrid_blitsort_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_hybrid_blitsort_path_add(a : SorthybridblitsortPath, b : SorthybridblitsortPath) -> SorthybridblitsortPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_hybrid_blitsort_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_hybrid_blitsort_path_copy(s : SorthybridblitsortPath) -> SorthybridblitsortPath {
  let result = sort_hybrid_blitsort_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_hybrid_blitsort_path_fill(s : SorthybridblitsortPath, v : Double) -> SorthybridblitsortPath {
  let result = sort_hybrid_blitsort_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_hybrid_blitsort_path_min(s : SorthybridblitsortPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_hybrid_blitsort_path_max(s : SorthybridblitsortPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_hybrid_blitsort_path_to_string(s : SorthybridblitsortPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridblitsortCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_blitsort_cluster_make(size : Int) -> SorthybridblitsortCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_blitsort_cluster_len(s : SorthybridblitsortCluster) -> Int { s.size }

pub fn sort_hybrid_blitsort_cluster_get(s : SorthybridblitsortCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_blitsort_cluster_set(s : SorthybridblitsortCluster, i : Int, v : Double) -> SorthybridblitsortCluster {
  let result = sort_hybrid_blitsort_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_hybrid_blitsort_cluster_sum(s : SorthybridblitsortCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_hybrid_blitsort_cluster_mean(s : SorthybridblitsortCluster) -> Double {
  if s.size == 0 { 0.0 } else { sort_hybrid_blitsort_cluster_sum(s) / s.size.to_double() }
}

pub fn sort_hybrid_blitsort_cluster_scale(s : SorthybridblitsortCluster, f : Double) -> SorthybridblitsortCluster {
  let result = sort_hybrid_blitsort_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_hybrid_blitsort_cluster_add(a : SorthybridblitsortCluster, b : SorthybridblitsortCluster) -> SorthybridblitsortCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_hybrid_blitsort_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_hybrid_blitsort_cluster_copy(s : SorthybridblitsortCluster) -> SorthybridblitsortCluster {
  let result = sort_hybrid_blitsort_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_hybrid_blitsort_cluster_fill(s : SorthybridblitsortCluster, v : Double) -> SorthybridblitsortCluster {
  let result = sort_hybrid_blitsort_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_hybrid_blitsort_cluster_min(s : SorthybridblitsortCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_hybrid_blitsort_cluster_max(s : SorthybridblitsortCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_hybrid_blitsort_cluster_to_string(s : SorthybridblitsortCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridblitsortModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_blitsort_model_make(size : Int) -> SorthybridblitsortModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_blitsort_model_len(s : SorthybridblitsortModel) -> Int { s.size }

pub fn sort_hybrid_blitsort_model_get(s : SorthybridblitsortModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_blitsort_model_set(s : SorthybridblitsortModel, i : Int, v : Double) -> SorthybridblitsortModel {
  let result = sort_hybrid_blitsort_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_hybrid_blitsort_model_sum(s : SorthybridblitsortModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_hybrid_blitsort_model_mean(s : SorthybridblitsortModel) -> Double {
  if s.size == 0 { 0.0 } else { sort_hybrid_blitsort_model_sum(s) / s.size.to_double() }
}

pub fn sort_hybrid_blitsort_model_scale(s : SorthybridblitsortModel, f : Double) -> SorthybridblitsortModel {
  let result = sort_hybrid_blitsort_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_hybrid_blitsort_model_add(a : SorthybridblitsortModel, b : SorthybridblitsortModel) -> SorthybridblitsortModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_hybrid_blitsort_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_hybrid_blitsort_model_copy(s : SorthybridblitsortModel) -> SorthybridblitsortModel {
  let result = sort_hybrid_blitsort_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_hybrid_blitsort_model_fill(s : SorthybridblitsortModel, v : Double) -> SorthybridblitsortModel {
  let result = sort_hybrid_blitsort_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_hybrid_blitsort_model_min(s : SorthybridblitsortModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_hybrid_blitsort_model_max(s : SorthybridblitsortModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_hybrid_blitsort_model_to_string(s : SorthybridblitsortModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridblitsortLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_blitsort_layer_make(size : Int) -> SorthybridblitsortLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_blitsort_layer_len(s : SorthybridblitsortLayer) -> Int { s.size }

pub fn sort_hybrid_blitsort_layer_get(s : SorthybridblitsortLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_blitsort_layer_set(s : SorthybridblitsortLayer, i : Int, v : Double) -> SorthybridblitsortLayer {
  let result = sort_hybrid_blitsort_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_hybrid_blitsort_layer_sum(s : SorthybridblitsortLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_hybrid_blitsort_layer_mean(s : SorthybridblitsortLayer) -> Double {
  if s.size == 0 { 0.0 } else { sort_hybrid_blitsort_layer_sum(s) / s.size.to_double() }
}

pub fn sort_hybrid_blitsort_layer_scale(s : SorthybridblitsortLayer, f : Double) -> SorthybridblitsortLayer {
  let result = sort_hybrid_blitsort_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_hybrid_blitsort_layer_add(a : SorthybridblitsortLayer, b : SorthybridblitsortLayer) -> SorthybridblitsortLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_hybrid_blitsort_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_hybrid_blitsort_layer_copy(s : SorthybridblitsortLayer) -> SorthybridblitsortLayer {
  let result = sort_hybrid_blitsort_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_hybrid_blitsort_layer_fill(s : SorthybridblitsortLayer, v : Double) -> SorthybridblitsortLayer {
  let result = sort_hybrid_blitsort_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_hybrid_blitsort_layer_min(s : SorthybridblitsortLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_hybrid_blitsort_layer_max(s : SorthybridblitsortLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_hybrid_blitsort_layer_to_string(s : SorthybridblitsortLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridblitsortBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_blitsort_buffer_make(size : Int) -> SorthybridblitsortBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_blitsort_buffer_len(s : SorthybridblitsortBuffer) -> Int { s.size }

pub fn sort_hybrid_blitsort_buffer_get(s : SorthybridblitsortBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_blitsort_buffer_set(s : SorthybridblitsortBuffer, i : Int, v : Double) -> SorthybridblitsortBuffer {
  let result = sort_hybrid_blitsort_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_hybrid_blitsort_buffer_sum(s : SorthybridblitsortBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_hybrid_blitsort_buffer_mean(s : SorthybridblitsortBuffer) -> Double {
  if s.size == 0 { 0.0 } else { sort_hybrid_blitsort_buffer_sum(s) / s.size.to_double() }
}

pub fn sort_hybrid_blitsort_buffer_scale(s : SorthybridblitsortBuffer, f : Double) -> SorthybridblitsortBuffer {
  let result = sort_hybrid_blitsort_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_hybrid_blitsort_buffer_add(a : SorthybridblitsortBuffer, b : SorthybridblitsortBuffer) -> SorthybridblitsortBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_hybrid_blitsort_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_hybrid_blitsort_buffer_copy(s : SorthybridblitsortBuffer) -> SorthybridblitsortBuffer {
  let result = sort_hybrid_blitsort_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_hybrid_blitsort_buffer_fill(s : SorthybridblitsortBuffer, v : Double) -> SorthybridblitsortBuffer {
  let result = sort_hybrid_blitsort_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_hybrid_blitsort_buffer_min(s : SorthybridblitsortBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_hybrid_blitsort_buffer_max(s : SorthybridblitsortBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_hybrid_blitsort_buffer_to_string(s : SorthybridblitsortBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridblitsortCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_blitsort_cursor_make(size : Int) -> SorthybridblitsortCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_blitsort_cursor_len(s : SorthybridblitsortCursor) -> Int { s.size }

pub fn sort_hybrid_blitsort_cursor_get(s : SorthybridblitsortCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_blitsort_cursor_set(s : SorthybridblitsortCursor, i : Int, v : Double) -> SorthybridblitsortCursor {
  let result = sort_hybrid_blitsort_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_hybrid_blitsort_cursor_sum(s : SorthybridblitsortCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_hybrid_blitsort_cursor_mean(s : SorthybridblitsortCursor) -> Double {
  if s.size == 0 { 0.0 } else { sort_hybrid_blitsort_cursor_sum(s) / s.size.to_double() }
}

pub fn sort_hybrid_blitsort_cursor_scale(s : SorthybridblitsortCursor, f : Double) -> SorthybridblitsortCursor {
  let result = sort_hybrid_blitsort_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_hybrid_blitsort_cursor_add(a : SorthybridblitsortCursor, b : SorthybridblitsortCursor) -> SorthybridblitsortCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_hybrid_blitsort_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_hybrid_blitsort_cursor_copy(s : SorthybridblitsortCursor) -> SorthybridblitsortCursor {
  let result = sort_hybrid_blitsort_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_hybrid_blitsort_cursor_fill(s : SorthybridblitsortCursor, v : Double) -> SorthybridblitsortCursor {
  let result = sort_hybrid_blitsort_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_hybrid_blitsort_cursor_min(s : SorthybridblitsortCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_hybrid_blitsort_cursor_max(s : SorthybridblitsortCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_hybrid_blitsort_cursor_to_string(s : SorthybridblitsortCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridblitsortView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_blitsort_view_make(size : Int) -> SorthybridblitsortView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_blitsort_view_len(s : SorthybridblitsortView) -> Int { s.size }

pub fn sort_hybrid_blitsort_view_get(s : SorthybridblitsortView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_blitsort_view_set(s : SorthybridblitsortView, i : Int, v : Double) -> SorthybridblitsortView {
  let result = sort_hybrid_blitsort_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_hybrid_blitsort_view_sum(s : SorthybridblitsortView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_hybrid_blitsort_view_mean(s : SorthybridblitsortView) -> Double {
  if s.size == 0 { 0.0 } else { sort_hybrid_blitsort_view_sum(s) / s.size.to_double() }
}

pub fn sort_hybrid_blitsort_view_scale(s : SorthybridblitsortView, f : Double) -> SorthybridblitsortView {
  let result = sort_hybrid_blitsort_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_hybrid_blitsort_view_add(a : SorthybridblitsortView, b : SorthybridblitsortView) -> SorthybridblitsortView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_hybrid_blitsort_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_hybrid_blitsort_view_copy(s : SorthybridblitsortView) -> SorthybridblitsortView {
  let result = sort_hybrid_blitsort_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_hybrid_blitsort_view_fill(s : SorthybridblitsortView, v : Double) -> SorthybridblitsortView {
  let result = sort_hybrid_blitsort_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_hybrid_blitsort_view_min(s : SorthybridblitsortView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_hybrid_blitsort_view_max(s : SorthybridblitsortView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_hybrid_blitsort_view_to_string(s : SorthybridblitsortView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridblitsortRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_blitsort_range_make(size : Int) -> SorthybridblitsortRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_blitsort_range_len(s : SorthybridblitsortRange) -> Int { s.size }

pub fn sort_hybrid_blitsort_range_get(s : SorthybridblitsortRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_blitsort_range_set(s : SorthybridblitsortRange, i : Int, v : Double) -> SorthybridblitsortRange {
  let result = sort_hybrid_blitsort_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_hybrid_blitsort_range_sum(s : SorthybridblitsortRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_hybrid_blitsort_range_mean(s : SorthybridblitsortRange) -> Double {
  if s.size == 0 { 0.0 } else { sort_hybrid_blitsort_range_sum(s) / s.size.to_double() }
}

pub fn sort_hybrid_blitsort_range_scale(s : SorthybridblitsortRange, f : Double) -> SorthybridblitsortRange {
  let result = sort_hybrid_blitsort_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_hybrid_blitsort_range_add(a : SorthybridblitsortRange, b : SorthybridblitsortRange) -> SorthybridblitsortRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_hybrid_blitsort_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_hybrid_blitsort_range_copy(s : SorthybridblitsortRange) -> SorthybridblitsortRange {
  let result = sort_hybrid_blitsort_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_hybrid_blitsort_range_fill(s : SorthybridblitsortRange, v : Double) -> SorthybridblitsortRange {
  let result = sort_hybrid_blitsort_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_hybrid_blitsort_range_min(s : SorthybridblitsortRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_hybrid_blitsort_range_max(s : SorthybridblitsortRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_hybrid_blitsort_range_to_string(s : SorthybridblitsortRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridblitsortSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_blitsort_slice_make(size : Int) -> SorthybridblitsortSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_blitsort_slice_len(s : SorthybridblitsortSlice) -> Int { s.size }

pub fn sort_hybrid_blitsort_slice_get(s : SorthybridblitsortSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_blitsort_slice_set(s : SorthybridblitsortSlice, i : Int, v : Double) -> SorthybridblitsortSlice {
  let result = sort_hybrid_blitsort_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_hybrid_blitsort_slice_sum(s : SorthybridblitsortSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_hybrid_blitsort_slice_mean(s : SorthybridblitsortSlice) -> Double {
  if s.size == 0 { 0.0 } else { sort_hybrid_blitsort_slice_sum(s) / s.size.to_double() }
}

pub fn sort_hybrid_blitsort_slice_scale(s : SorthybridblitsortSlice, f : Double) -> SorthybridblitsortSlice {
  let result = sort_hybrid_blitsort_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_hybrid_blitsort_slice_add(a : SorthybridblitsortSlice, b : SorthybridblitsortSlice) -> SorthybridblitsortSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_hybrid_blitsort_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_hybrid_blitsort_slice_copy(s : SorthybridblitsortSlice) -> SorthybridblitsortSlice {
  let result = sort_hybrid_blitsort_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_hybrid_blitsort_slice_fill(s : SorthybridblitsortSlice, v : Double) -> SorthybridblitsortSlice {
  let result = sort_hybrid_blitsort_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_hybrid_blitsort_slice_min(s : SorthybridblitsortSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_hybrid_blitsort_slice_max(s : SorthybridblitsortSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_hybrid_blitsort_slice_to_string(s : SorthybridblitsortSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

