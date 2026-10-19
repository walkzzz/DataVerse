///===
/// extcore/sort_dist_radix

pub(all) struct SortdistradixPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn sort_dist_radix_make_point(x : Double, y : Double) -> SortdistradixPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn sort_dist_radix_make_point3(x : Double, y : Double, z : Double) -> SortdistradixPoint {
  { x, y, z, label: 0 }
}

pub fn sort_dist_radix_point_x(pt : SortdistradixPoint) -> Double { pt.x }

pub fn sort_dist_radix_point_y(pt : SortdistradixPoint) -> Double { pt.y }

pub fn sort_dist_radix_point_z(pt : SortdistradixPoint) -> Double { pt.z }

pub fn sort_dist_radix_point_label(pt : SortdistradixPoint) -> Int { pt.label }

pub fn sort_dist_radix_point_dist(a : SortdistradixPoint, b : SortdistradixPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn sort_dist_radix_point_add(a : SortdistradixPoint, b : SortdistradixPoint) -> SortdistradixPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn sort_dist_radix_point_sub(a : SortdistradixPoint, b : SortdistradixPoint) -> SortdistradixPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn sort_dist_radix_point_scale(pt : SortdistradixPoint, s : Double) -> SortdistradixPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn sort_dist_radix_point_dot(a : SortdistradixPoint, b : SortdistradixPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn sort_dist_radix_point_cross(a : SortdistradixPoint, b : SortdistradixPoint) -> SortdistradixPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn sort_dist_radix_point_norm(pt : SortdistradixPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn sort_dist_radix_point_normalize(pt : SortdistradixPoint) -> SortdistradixPoint {
  let n = sort_dist_radix_point_norm(pt)
  if n < 0.0000001 { pt } else { sort_dist_radix_point_scale(pt, 1.0 / n) }
}

pub fn sort_dist_radix_point_negate(pt : SortdistradixPoint) -> SortdistradixPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn sort_dist_radix_point_mid(a : SortdistradixPoint, b : SortdistradixPoint) -> SortdistradixPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn sort_dist_radix_point_lerp(a : SortdistradixPoint, b : SortdistradixPoint, t : Double) -> SortdistradixPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn sort_dist_radix_point_to_string(pt : SortdistradixPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct SortdistradixSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn sort_dist_radix_make_series(vals : Array[Double], name : String) -> SortdistradixSeries {
  { vals, name, meta: 0 }
}

pub fn sort_dist_radix_series_len(s : SortdistradixSeries) -> Int { s.vals.length() }

pub fn sort_dist_radix_series_sum(s : SortdistradixSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn sort_dist_radix_series_mean(s : SortdistradixSeries) -> Double {
  let n = sort_dist_radix_series_len(s)
  if n == 0 { 0.0 } else { sort_dist_radix_series_sum(s) / n.to_double() }
}

pub fn sort_dist_radix_series_min(s : SortdistradixSeries) -> Double {
  let n = sort_dist_radix_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn sort_dist_radix_series_max(s : SortdistradixSeries) -> Double {
  let n = sort_dist_radix_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn sort_dist_radix_series_range(s : SortdistradixSeries) -> Double {
  sort_dist_radix_series_max(s) - sort_dist_radix_series_min(s)
}

pub fn sort_dist_radix_series_var(s : SortdistradixSeries) -> Double {
  let n = sort_dist_radix_series_len(s)
  if n == 0 { 0.0 } else {
    let m = sort_dist_radix_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn sort_dist_radix_series_std(s : SortdistradixSeries) -> Double { @_common.sqrt(sort_dist_radix_series_var(s)) }

pub fn sort_dist_radix_series_median(s : SortdistradixSeries) -> Double {
  let n = sort_dist_radix_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = sort_dist_radix_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn sort_dist_radix_series_scale(s : SortdistradixSeries, f : Double) -> SortdistradixSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn sort_dist_radix_series_add(a : SortdistradixSeries, b : SortdistradixSeries) -> SortdistradixSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn sort_dist_radix_series_sub(a : SortdistradixSeries, b : SortdistradixSeries) -> SortdistradixSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn sort_dist_radix_series_normalize(s : SortdistradixSeries) -> SortdistradixSeries {
  let mn = sort_dist_radix_series_min(s)
  let mx = sort_dist_radix_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn sort_dist_radix_series_cumsum(s : SortdistradixSeries) -> SortdistradixSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn sort_dist_radix_series_to_string(s : SortdistradixSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SortdistradixMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn sort_dist_radix_make_matrix(rows : Int, cols : Int, val : Double) -> SortdistradixMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn sort_dist_radix_matrix_identity(n : Int) -> SortdistradixMatrix {
  let m = sort_dist_radix_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn sort_dist_radix_matrix_get(m : SortdistradixMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn sort_dist_radix_matrix_transpose(m : SortdistradixMatrix) -> SortdistradixMatrix {
  let result = sort_dist_radix_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn sort_dist_radix_matrix_add(a : SortdistradixMatrix, b : SortdistradixMatrix) -> SortdistradixMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = sort_dist_radix_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn sort_dist_radix_matrix_scale(m : SortdistradixMatrix, s : Double) -> SortdistradixMatrix {
  let result = sort_dist_radix_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn sort_dist_radix_matrix_multiply(a : SortdistradixMatrix, b : SortdistradixMatrix) -> SortdistradixMatrix {
  if a.cols != b.rows { return sort_dist_radix_make_matrix(a.rows, b.cols, 0.0) }
  let result = sort_dist_radix_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn sort_dist_radix_matrix_trace(m : SortdistradixMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn sort_dist_radix_matrix_det(m : SortdistradixMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn sort_dist_radix_matrix_norm(m : SortdistradixMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn sort_dist_radix_matrix_to_string(m : SortdistradixMatrix) -> String {
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

pub(all) struct SortdistradixVector {
  comps : Array[Double]
  dim : Int
}

pub fn sort_dist_radix_make_vector(comps : Array[Double]) -> SortdistradixVector {
  { comps, dim: comps.length() }
}

pub fn sort_dist_radix_vector_zero(dim : Int) -> SortdistradixVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn sort_dist_radix_vector_add(a : SortdistradixVector, b : SortdistradixVector) -> SortdistradixVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn sort_dist_radix_vector_sub(a : SortdistradixVector, b : SortdistradixVector) -> SortdistradixVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn sort_dist_radix_vector_scale(v : SortdistradixVector, s : Double) -> SortdistradixVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn sort_dist_radix_vector_dot(a : SortdistradixVector, b : SortdistradixVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn sort_dist_radix_vector_norm(v : SortdistradixVector) -> Double { @_common.sqrt(sort_dist_radix_vector_dot(v, v)) }

pub fn sort_dist_radix_vector_normalize(v : SortdistradixVector) -> SortdistradixVector {
  let n = sort_dist_radix_vector_norm(v)
  if n < 0.0000001 { v } else { sort_dist_radix_vector_scale(v, 1.0 / n) }
}

pub fn sort_dist_radix_vector_dist(a : SortdistradixVector, b : SortdistradixVector) -> Double {
  sort_dist_radix_vector_norm(sort_dist_radix_vector_sub(a, b))
}

pub fn sort_dist_radix_vector_to_string(v : SortdistradixVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn sort_dist_radix_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn sort_dist_radix_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = sort_dist_radix_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn sort_dist_radix_std(data : Array[Double]) -> Double { @_common.sqrt(sort_dist_radix_var(data)) }

pub fn sort_dist_radix_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = sort_dist_radix_mean(a); let mb = sort_dist_radix_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn sort_dist_radix_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = sort_dist_radix_std(a); let sb = sort_dist_radix_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { sort_dist_radix_cov(a, b) / (sa * sb) }
}

pub fn sort_dist_radix_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = sort_dist_radix_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn sort_dist_radix_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn sort_dist_radix_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn sort_dist_radix_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  @_common.sqrt(sort_dist_radix_mse(pred, labels))
}

pub fn sort_dist_radix_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn sort_dist_radix_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = sort_dist_radix_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn sort_dist_radix_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn sort_dist_radix_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn sort_dist_radix_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = sort_dist_radix_precision(pred, labels, pos); let r = sort_dist_radix_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn sort_dist_radix_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn sort_dist_radix_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = sort_dist_radix_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn sort_dist_radix_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn sort_dist_radix_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn sort_dist_radix_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = sort_dist_radix_gcd(a, b)
    (a / g) * b
  }
}

pub fn sort_dist_radix_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn sort_dist_radix_fibonacci(n : Int) -> Int {
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

pub fn sort_dist_radix_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = sort_dist_radix_min(data); let mx = sort_dist_radix_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn sort_dist_radix_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = sort_dist_radix_mean(data); let sd = sort_dist_radix_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn sort_dist_radix_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn sort_dist_radix_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn sort_dist_radix_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn sort_dist_radix_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn sort_dist_radix_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn sort_dist_radix_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

pub(all) struct SortdistradixFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_radix_frame_make(size : Int) -> SortdistradixFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_radix_frame_len(s : SortdistradixFrame) -> Int { s.size }

pub fn sort_dist_radix_frame_get(s : SortdistradixFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_radix_frame_set(s : SortdistradixFrame, i : Int, v : Double) -> SortdistradixFrame {
  let result = sort_dist_radix_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_dist_radix_frame_sum(s : SortdistradixFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_dist_radix_frame_mean(s : SortdistradixFrame) -> Double {
  if s.size == 0 { 0.0 } else { sort_dist_radix_frame_sum(s) / s.size.to_double() }
}

pub fn sort_dist_radix_frame_scale(s : SortdistradixFrame, f : Double) -> SortdistradixFrame {
  let result = sort_dist_radix_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_dist_radix_frame_add(a : SortdistradixFrame, b : SortdistradixFrame) -> SortdistradixFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_dist_radix_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_dist_radix_frame_copy(s : SortdistradixFrame) -> SortdistradixFrame {
  let result = sort_dist_radix_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_dist_radix_frame_fill(s : SortdistradixFrame, v : Double) -> SortdistradixFrame {
  let result = sort_dist_radix_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_dist_radix_frame_min(s : SortdistradixFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_radix_frame_max(s : SortdistradixFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_radix_frame_to_string(s : SortdistradixFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistradixTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_radix_table_make(size : Int) -> SortdistradixTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_radix_table_len(s : SortdistradixTable) -> Int { s.size }

pub fn sort_dist_radix_table_get(s : SortdistradixTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_radix_table_set(s : SortdistradixTable, i : Int, v : Double) -> SortdistradixTable {
  let result = sort_dist_radix_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_dist_radix_table_sum(s : SortdistradixTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_dist_radix_table_mean(s : SortdistradixTable) -> Double {
  if s.size == 0 { 0.0 } else { sort_dist_radix_table_sum(s) / s.size.to_double() }
}

pub fn sort_dist_radix_table_scale(s : SortdistradixTable, f : Double) -> SortdistradixTable {
  let result = sort_dist_radix_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_dist_radix_table_add(a : SortdistradixTable, b : SortdistradixTable) -> SortdistradixTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_dist_radix_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_dist_radix_table_copy(s : SortdistradixTable) -> SortdistradixTable {
  let result = sort_dist_radix_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_dist_radix_table_fill(s : SortdistradixTable, v : Double) -> SortdistradixTable {
  let result = sort_dist_radix_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_dist_radix_table_min(s : SortdistradixTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_radix_table_max(s : SortdistradixTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_radix_table_to_string(s : SortdistradixTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistradixGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_radix_graphn_make(size : Int) -> SortdistradixGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_radix_graphn_len(s : SortdistradixGraphN) -> Int { s.size }

pub fn sort_dist_radix_graphn_get(s : SortdistradixGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_radix_graphn_set(s : SortdistradixGraphN, i : Int, v : Double) -> SortdistradixGraphN {
  let result = sort_dist_radix_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_dist_radix_graphn_sum(s : SortdistradixGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_dist_radix_graphn_mean(s : SortdistradixGraphN) -> Double {
  if s.size == 0 { 0.0 } else { sort_dist_radix_graphn_sum(s) / s.size.to_double() }
}

pub fn sort_dist_radix_graphn_scale(s : SortdistradixGraphN, f : Double) -> SortdistradixGraphN {
  let result = sort_dist_radix_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_dist_radix_graphn_add(a : SortdistradixGraphN, b : SortdistradixGraphN) -> SortdistradixGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_dist_radix_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_dist_radix_graphn_copy(s : SortdistradixGraphN) -> SortdistradixGraphN {
  let result = sort_dist_radix_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_dist_radix_graphn_fill(s : SortdistradixGraphN, v : Double) -> SortdistradixGraphN {
  let result = sort_dist_radix_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_dist_radix_graphn_min(s : SortdistradixGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_radix_graphn_max(s : SortdistradixGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_radix_graphn_to_string(s : SortdistradixGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistradixNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_radix_node_make(size : Int) -> SortdistradixNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_radix_node_len(s : SortdistradixNode) -> Int { s.size }

pub fn sort_dist_radix_node_get(s : SortdistradixNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_radix_node_set(s : SortdistradixNode, i : Int, v : Double) -> SortdistradixNode {
  let result = sort_dist_radix_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_dist_radix_node_sum(s : SortdistradixNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_dist_radix_node_mean(s : SortdistradixNode) -> Double {
  if s.size == 0 { 0.0 } else { sort_dist_radix_node_sum(s) / s.size.to_double() }
}

pub fn sort_dist_radix_node_scale(s : SortdistradixNode, f : Double) -> SortdistradixNode {
  let result = sort_dist_radix_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_dist_radix_node_add(a : SortdistradixNode, b : SortdistradixNode) -> SortdistradixNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_dist_radix_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_dist_radix_node_copy(s : SortdistradixNode) -> SortdistradixNode {
  let result = sort_dist_radix_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_dist_radix_node_fill(s : SortdistradixNode, v : Double) -> SortdistradixNode {
  let result = sort_dist_radix_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_dist_radix_node_min(s : SortdistradixNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_radix_node_max(s : SortdistradixNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_radix_node_to_string(s : SortdistradixNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistradixEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_radix_edge_make(size : Int) -> SortdistradixEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_radix_edge_len(s : SortdistradixEdge) -> Int { s.size }

pub fn sort_dist_radix_edge_get(s : SortdistradixEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_radix_edge_set(s : SortdistradixEdge, i : Int, v : Double) -> SortdistradixEdge {
  let result = sort_dist_radix_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_dist_radix_edge_sum(s : SortdistradixEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_dist_radix_edge_mean(s : SortdistradixEdge) -> Double {
  if s.size == 0 { 0.0 } else { sort_dist_radix_edge_sum(s) / s.size.to_double() }
}

pub fn sort_dist_radix_edge_scale(s : SortdistradixEdge, f : Double) -> SortdistradixEdge {
  let result = sort_dist_radix_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_dist_radix_edge_add(a : SortdistradixEdge, b : SortdistradixEdge) -> SortdistradixEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_dist_radix_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_dist_radix_edge_copy(s : SortdistradixEdge) -> SortdistradixEdge {
  let result = sort_dist_radix_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_dist_radix_edge_fill(s : SortdistradixEdge, v : Double) -> SortdistradixEdge {
  let result = sort_dist_radix_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_dist_radix_edge_min(s : SortdistradixEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_radix_edge_max(s : SortdistradixEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_radix_edge_to_string(s : SortdistradixEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistradixPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_radix_path_make(size : Int) -> SortdistradixPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_radix_path_len(s : SortdistradixPath) -> Int { s.size }

pub fn sort_dist_radix_path_get(s : SortdistradixPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_radix_path_set(s : SortdistradixPath, i : Int, v : Double) -> SortdistradixPath {
  let result = sort_dist_radix_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_dist_radix_path_sum(s : SortdistradixPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_dist_radix_path_mean(s : SortdistradixPath) -> Double {
  if s.size == 0 { 0.0 } else { sort_dist_radix_path_sum(s) / s.size.to_double() }
}

pub fn sort_dist_radix_path_scale(s : SortdistradixPath, f : Double) -> SortdistradixPath {
  let result = sort_dist_radix_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_dist_radix_path_add(a : SortdistradixPath, b : SortdistradixPath) -> SortdistradixPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_dist_radix_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_dist_radix_path_copy(s : SortdistradixPath) -> SortdistradixPath {
  let result = sort_dist_radix_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_dist_radix_path_fill(s : SortdistradixPath, v : Double) -> SortdistradixPath {
  let result = sort_dist_radix_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_dist_radix_path_min(s : SortdistradixPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_radix_path_max(s : SortdistradixPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_radix_path_to_string(s : SortdistradixPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistradixCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_radix_cluster_make(size : Int) -> SortdistradixCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_radix_cluster_len(s : SortdistradixCluster) -> Int { s.size }

pub fn sort_dist_radix_cluster_get(s : SortdistradixCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_radix_cluster_set(s : SortdistradixCluster, i : Int, v : Double) -> SortdistradixCluster {
  let result = sort_dist_radix_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_dist_radix_cluster_sum(s : SortdistradixCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_dist_radix_cluster_mean(s : SortdistradixCluster) -> Double {
  if s.size == 0 { 0.0 } else { sort_dist_radix_cluster_sum(s) / s.size.to_double() }
}

pub fn sort_dist_radix_cluster_scale(s : SortdistradixCluster, f : Double) -> SortdistradixCluster {
  let result = sort_dist_radix_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_dist_radix_cluster_add(a : SortdistradixCluster, b : SortdistradixCluster) -> SortdistradixCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_dist_radix_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_dist_radix_cluster_copy(s : SortdistradixCluster) -> SortdistradixCluster {
  let result = sort_dist_radix_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_dist_radix_cluster_fill(s : SortdistradixCluster, v : Double) -> SortdistradixCluster {
  let result = sort_dist_radix_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_dist_radix_cluster_min(s : SortdistradixCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_radix_cluster_max(s : SortdistradixCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_radix_cluster_to_string(s : SortdistradixCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistradixModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_radix_model_make(size : Int) -> SortdistradixModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_radix_model_len(s : SortdistradixModel) -> Int { s.size }

pub fn sort_dist_radix_model_get(s : SortdistradixModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_radix_model_set(s : SortdistradixModel, i : Int, v : Double) -> SortdistradixModel {
  let result = sort_dist_radix_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_dist_radix_model_sum(s : SortdistradixModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_dist_radix_model_mean(s : SortdistradixModel) -> Double {
  if s.size == 0 { 0.0 } else { sort_dist_radix_model_sum(s) / s.size.to_double() }
}

pub fn sort_dist_radix_model_scale(s : SortdistradixModel, f : Double) -> SortdistradixModel {
  let result = sort_dist_radix_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_dist_radix_model_add(a : SortdistradixModel, b : SortdistradixModel) -> SortdistradixModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_dist_radix_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_dist_radix_model_copy(s : SortdistradixModel) -> SortdistradixModel {
  let result = sort_dist_radix_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_dist_radix_model_fill(s : SortdistradixModel, v : Double) -> SortdistradixModel {
  let result = sort_dist_radix_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_dist_radix_model_min(s : SortdistradixModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_radix_model_max(s : SortdistradixModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_radix_model_to_string(s : SortdistradixModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistradixLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_radix_layer_make(size : Int) -> SortdistradixLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_radix_layer_len(s : SortdistradixLayer) -> Int { s.size }

pub fn sort_dist_radix_layer_get(s : SortdistradixLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_radix_layer_set(s : SortdistradixLayer, i : Int, v : Double) -> SortdistradixLayer {
  let result = sort_dist_radix_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_dist_radix_layer_sum(s : SortdistradixLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_dist_radix_layer_mean(s : SortdistradixLayer) -> Double {
  if s.size == 0 { 0.0 } else { sort_dist_radix_layer_sum(s) / s.size.to_double() }
}

pub fn sort_dist_radix_layer_scale(s : SortdistradixLayer, f : Double) -> SortdistradixLayer {
  let result = sort_dist_radix_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_dist_radix_layer_add(a : SortdistradixLayer, b : SortdistradixLayer) -> SortdistradixLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_dist_radix_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_dist_radix_layer_copy(s : SortdistradixLayer) -> SortdistradixLayer {
  let result = sort_dist_radix_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_dist_radix_layer_fill(s : SortdistradixLayer, v : Double) -> SortdistradixLayer {
  let result = sort_dist_radix_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_dist_radix_layer_min(s : SortdistradixLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_radix_layer_max(s : SortdistradixLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_radix_layer_to_string(s : SortdistradixLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistradixBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_radix_buffer_make(size : Int) -> SortdistradixBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_radix_buffer_len(s : SortdistradixBuffer) -> Int { s.size }

pub fn sort_dist_radix_buffer_get(s : SortdistradixBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_radix_buffer_set(s : SortdistradixBuffer, i : Int, v : Double) -> SortdistradixBuffer {
  let result = sort_dist_radix_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_dist_radix_buffer_sum(s : SortdistradixBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_dist_radix_buffer_mean(s : SortdistradixBuffer) -> Double {
  if s.size == 0 { 0.0 } else { sort_dist_radix_buffer_sum(s) / s.size.to_double() }
}

pub fn sort_dist_radix_buffer_scale(s : SortdistradixBuffer, f : Double) -> SortdistradixBuffer {
  let result = sort_dist_radix_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_dist_radix_buffer_add(a : SortdistradixBuffer, b : SortdistradixBuffer) -> SortdistradixBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_dist_radix_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_dist_radix_buffer_copy(s : SortdistradixBuffer) -> SortdistradixBuffer {
  let result = sort_dist_radix_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_dist_radix_buffer_fill(s : SortdistradixBuffer, v : Double) -> SortdistradixBuffer {
  let result = sort_dist_radix_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_dist_radix_buffer_min(s : SortdistradixBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_radix_buffer_max(s : SortdistradixBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_radix_buffer_to_string(s : SortdistradixBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistradixCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_radix_cursor_make(size : Int) -> SortdistradixCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_radix_cursor_len(s : SortdistradixCursor) -> Int { s.size }

pub fn sort_dist_radix_cursor_get(s : SortdistradixCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_radix_cursor_set(s : SortdistradixCursor, i : Int, v : Double) -> SortdistradixCursor {
  let result = sort_dist_radix_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_dist_radix_cursor_sum(s : SortdistradixCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_dist_radix_cursor_mean(s : SortdistradixCursor) -> Double {
  if s.size == 0 { 0.0 } else { sort_dist_radix_cursor_sum(s) / s.size.to_double() }
}

pub fn sort_dist_radix_cursor_scale(s : SortdistradixCursor, f : Double) -> SortdistradixCursor {
  let result = sort_dist_radix_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_dist_radix_cursor_add(a : SortdistradixCursor, b : SortdistradixCursor) -> SortdistradixCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_dist_radix_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_dist_radix_cursor_copy(s : SortdistradixCursor) -> SortdistradixCursor {
  let result = sort_dist_radix_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_dist_radix_cursor_fill(s : SortdistradixCursor, v : Double) -> SortdistradixCursor {
  let result = sort_dist_radix_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_dist_radix_cursor_min(s : SortdistradixCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_radix_cursor_max(s : SortdistradixCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_radix_cursor_to_string(s : SortdistradixCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistradixView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_radix_view_make(size : Int) -> SortdistradixView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_radix_view_len(s : SortdistradixView) -> Int { s.size }

pub fn sort_dist_radix_view_get(s : SortdistradixView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_radix_view_set(s : SortdistradixView, i : Int, v : Double) -> SortdistradixView {
  let result = sort_dist_radix_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_dist_radix_view_sum(s : SortdistradixView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_dist_radix_view_mean(s : SortdistradixView) -> Double {
  if s.size == 0 { 0.0 } else { sort_dist_radix_view_sum(s) / s.size.to_double() }
}

pub fn sort_dist_radix_view_scale(s : SortdistradixView, f : Double) -> SortdistradixView {
  let result = sort_dist_radix_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_dist_radix_view_add(a : SortdistradixView, b : SortdistradixView) -> SortdistradixView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_dist_radix_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_dist_radix_view_copy(s : SortdistradixView) -> SortdistradixView {
  let result = sort_dist_radix_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_dist_radix_view_fill(s : SortdistradixView, v : Double) -> SortdistradixView {
  let result = sort_dist_radix_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_dist_radix_view_min(s : SortdistradixView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_radix_view_max(s : SortdistradixView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_radix_view_to_string(s : SortdistradixView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistradixRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_radix_range_make(size : Int) -> SortdistradixRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_radix_range_len(s : SortdistradixRange) -> Int { s.size }

pub fn sort_dist_radix_range_get(s : SortdistradixRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_radix_range_set(s : SortdistradixRange, i : Int, v : Double) -> SortdistradixRange {
  let result = sort_dist_radix_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_dist_radix_range_sum(s : SortdistradixRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_dist_radix_range_mean(s : SortdistradixRange) -> Double {
  if s.size == 0 { 0.0 } else { sort_dist_radix_range_sum(s) / s.size.to_double() }
}

pub fn sort_dist_radix_range_scale(s : SortdistradixRange, f : Double) -> SortdistradixRange {
  let result = sort_dist_radix_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_dist_radix_range_add(a : SortdistradixRange, b : SortdistradixRange) -> SortdistradixRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_dist_radix_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_dist_radix_range_copy(s : SortdistradixRange) -> SortdistradixRange {
  let result = sort_dist_radix_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_dist_radix_range_fill(s : SortdistradixRange, v : Double) -> SortdistradixRange {
  let result = sort_dist_radix_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_dist_radix_range_min(s : SortdistradixRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_radix_range_max(s : SortdistradixRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_radix_range_to_string(s : SortdistradixRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistradixSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_radix_slice_make(size : Int) -> SortdistradixSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_radix_slice_len(s : SortdistradixSlice) -> Int { s.size }

pub fn sort_dist_radix_slice_get(s : SortdistradixSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_radix_slice_set(s : SortdistradixSlice, i : Int, v : Double) -> SortdistradixSlice {
  let result = sort_dist_radix_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_dist_radix_slice_sum(s : SortdistradixSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_dist_radix_slice_mean(s : SortdistradixSlice) -> Double {
  if s.size == 0 { 0.0 } else { sort_dist_radix_slice_sum(s) / s.size.to_double() }
}

pub fn sort_dist_radix_slice_scale(s : SortdistradixSlice, f : Double) -> SortdistradixSlice {
  let result = sort_dist_radix_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_dist_radix_slice_add(a : SortdistradixSlice, b : SortdistradixSlice) -> SortdistradixSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_dist_radix_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_dist_radix_slice_copy(s : SortdistradixSlice) -> SortdistradixSlice {
  let result = sort_dist_radix_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_dist_radix_slice_fill(s : SortdistradixSlice, v : Double) -> SortdistradixSlice {
  let result = sort_dist_radix_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_dist_radix_slice_min(s : SortdistradixSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_radix_slice_max(s : SortdistradixSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_radix_slice_to_string(s : SortdistradixSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

