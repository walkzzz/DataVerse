///===
/// extcore/sort_dist_lsd

pub(all) struct SortdistlsdPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn sort_dist_lsd_make_point(x : Double, y : Double) -> SortdistlsdPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn sort_dist_lsd_make_point3(x : Double, y : Double, z : Double) -> SortdistlsdPoint {
  { x, y, z, label: 0 }
}

pub fn sort_dist_lsd_point_x(pt : SortdistlsdPoint) -> Double { pt.x }

pub fn sort_dist_lsd_point_y(pt : SortdistlsdPoint) -> Double { pt.y }

pub fn sort_dist_lsd_point_z(pt : SortdistlsdPoint) -> Double { pt.z }

pub fn sort_dist_lsd_point_label(pt : SortdistlsdPoint) -> Int { pt.label }

pub fn sort_dist_lsd_point_dist(a : SortdistlsdPoint, b : SortdistlsdPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn sort_dist_lsd_point_add(a : SortdistlsdPoint, b : SortdistlsdPoint) -> SortdistlsdPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn sort_dist_lsd_point_sub(a : SortdistlsdPoint, b : SortdistlsdPoint) -> SortdistlsdPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn sort_dist_lsd_point_scale(pt : SortdistlsdPoint, s : Double) -> SortdistlsdPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn sort_dist_lsd_point_dot(a : SortdistlsdPoint, b : SortdistlsdPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn sort_dist_lsd_point_cross(a : SortdistlsdPoint, b : SortdistlsdPoint) -> SortdistlsdPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn sort_dist_lsd_point_norm(pt : SortdistlsdPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn sort_dist_lsd_point_normalize(pt : SortdistlsdPoint) -> SortdistlsdPoint {
  let n = sort_dist_lsd_point_norm(pt)
  if n < 0.0000001 { pt } else { sort_dist_lsd_point_scale(pt, 1.0 / n) }
}

pub fn sort_dist_lsd_point_negate(pt : SortdistlsdPoint) -> SortdistlsdPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn sort_dist_lsd_point_mid(a : SortdistlsdPoint, b : SortdistlsdPoint) -> SortdistlsdPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn sort_dist_lsd_point_lerp(a : SortdistlsdPoint, b : SortdistlsdPoint, t : Double) -> SortdistlsdPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn sort_dist_lsd_point_to_string(pt : SortdistlsdPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct SortdistlsdSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn sort_dist_lsd_make_series(vals : Array[Double], name : String) -> SortdistlsdSeries {
  { vals, name, meta: 0 }
}

pub fn sort_dist_lsd_series_len(s : SortdistlsdSeries) -> Int { s.vals.length() }

pub fn sort_dist_lsd_series_sum(s : SortdistlsdSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn sort_dist_lsd_series_mean(s : SortdistlsdSeries) -> Double {
  let n = sort_dist_lsd_series_len(s)
  if n == 0 { 0.0 } else { sort_dist_lsd_series_sum(s) / n.to_double() }
}

pub fn sort_dist_lsd_series_min(s : SortdistlsdSeries) -> Double {
  let n = sort_dist_lsd_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn sort_dist_lsd_series_max(s : SortdistlsdSeries) -> Double {
  let n = sort_dist_lsd_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn sort_dist_lsd_series_range(s : SortdistlsdSeries) -> Double {
  sort_dist_lsd_series_max(s) - sort_dist_lsd_series_min(s)
}

pub fn sort_dist_lsd_series_var(s : SortdistlsdSeries) -> Double {
  let n = sort_dist_lsd_series_len(s)
  if n == 0 { 0.0 } else {
    let m = sort_dist_lsd_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn sort_dist_lsd_series_std(s : SortdistlsdSeries) -> Double { @_common.sqrt(sort_dist_lsd_series_var(s)) }

pub fn sort_dist_lsd_series_median(s : SortdistlsdSeries) -> Double {
  let n = sort_dist_lsd_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = sort_dist_lsd_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn sort_dist_lsd_series_scale(s : SortdistlsdSeries, f : Double) -> SortdistlsdSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn sort_dist_lsd_series_add(a : SortdistlsdSeries, b : SortdistlsdSeries) -> SortdistlsdSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn sort_dist_lsd_series_sub(a : SortdistlsdSeries, b : SortdistlsdSeries) -> SortdistlsdSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn sort_dist_lsd_series_normalize(s : SortdistlsdSeries) -> SortdistlsdSeries {
  let mn = sort_dist_lsd_series_min(s)
  let mx = sort_dist_lsd_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn sort_dist_lsd_series_cumsum(s : SortdistlsdSeries) -> SortdistlsdSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn sort_dist_lsd_series_to_string(s : SortdistlsdSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SortdistlsdMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn sort_dist_lsd_make_matrix(rows : Int, cols : Int, val : Double) -> SortdistlsdMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn sort_dist_lsd_matrix_identity(n : Int) -> SortdistlsdMatrix {
  let m = sort_dist_lsd_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn sort_dist_lsd_matrix_get(m : SortdistlsdMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn sort_dist_lsd_matrix_transpose(m : SortdistlsdMatrix) -> SortdistlsdMatrix {
  let result = sort_dist_lsd_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn sort_dist_lsd_matrix_add(a : SortdistlsdMatrix, b : SortdistlsdMatrix) -> SortdistlsdMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = sort_dist_lsd_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn sort_dist_lsd_matrix_scale(m : SortdistlsdMatrix, s : Double) -> SortdistlsdMatrix {
  let result = sort_dist_lsd_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn sort_dist_lsd_matrix_multiply(a : SortdistlsdMatrix, b : SortdistlsdMatrix) -> SortdistlsdMatrix {
  if a.cols != b.rows { return sort_dist_lsd_make_matrix(a.rows, b.cols, 0.0) }
  let result = sort_dist_lsd_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn sort_dist_lsd_matrix_trace(m : SortdistlsdMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn sort_dist_lsd_matrix_det(m : SortdistlsdMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn sort_dist_lsd_matrix_norm(m : SortdistlsdMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn sort_dist_lsd_matrix_to_string(m : SortdistlsdMatrix) -> String {
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

pub(all) struct SortdistlsdVector {
  comps : Array[Double]
  dim : Int
}

pub fn sort_dist_lsd_make_vector(comps : Array[Double]) -> SortdistlsdVector {
  { comps, dim: comps.length() }
}

pub fn sort_dist_lsd_vector_zero(dim : Int) -> SortdistlsdVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn sort_dist_lsd_vector_add(a : SortdistlsdVector, b : SortdistlsdVector) -> SortdistlsdVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn sort_dist_lsd_vector_sub(a : SortdistlsdVector, b : SortdistlsdVector) -> SortdistlsdVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn sort_dist_lsd_vector_scale(v : SortdistlsdVector, s : Double) -> SortdistlsdVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn sort_dist_lsd_vector_dot(a : SortdistlsdVector, b : SortdistlsdVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn sort_dist_lsd_vector_norm(v : SortdistlsdVector) -> Double { @_common.sqrt(sort_dist_lsd_vector_dot(v, v)) }

pub fn sort_dist_lsd_vector_normalize(v : SortdistlsdVector) -> SortdistlsdVector {
  let n = sort_dist_lsd_vector_norm(v)
  if n < 0.0000001 { v } else { sort_dist_lsd_vector_scale(v, 1.0 / n) }
}

pub fn sort_dist_lsd_vector_dist(a : SortdistlsdVector, b : SortdistlsdVector) -> Double {
  sort_dist_lsd_vector_norm(sort_dist_lsd_vector_sub(a, b))
}

pub fn sort_dist_lsd_vector_to_string(v : SortdistlsdVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn sort_dist_lsd_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn sort_dist_lsd_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = sort_dist_lsd_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn sort_dist_lsd_std(data : Array[Double]) -> Double { @_common.sqrt(sort_dist_lsd_var(data)) }

pub fn sort_dist_lsd_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = sort_dist_lsd_mean(a); let mb = sort_dist_lsd_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn sort_dist_lsd_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = sort_dist_lsd_std(a); let sb = sort_dist_lsd_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { sort_dist_lsd_cov(a, b) / (sa * sb) }
}

pub fn sort_dist_lsd_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = sort_dist_lsd_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn sort_dist_lsd_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn sort_dist_lsd_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn sort_dist_lsd_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  @_common.sqrt(sort_dist_lsd_mse(pred, labels))
}

pub fn sort_dist_lsd_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn sort_dist_lsd_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = sort_dist_lsd_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn sort_dist_lsd_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn sort_dist_lsd_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn sort_dist_lsd_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = sort_dist_lsd_precision(pred, labels, pos); let r = sort_dist_lsd_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn sort_dist_lsd_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn sort_dist_lsd_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = sort_dist_lsd_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn sort_dist_lsd_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn sort_dist_lsd_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn sort_dist_lsd_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = sort_dist_lsd_gcd(a, b)
    (a / g) * b
  }
}

pub fn sort_dist_lsd_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn sort_dist_lsd_fibonacci(n : Int) -> Int {
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

pub fn sort_dist_lsd_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = sort_dist_lsd_min(data); let mx = sort_dist_lsd_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn sort_dist_lsd_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = sort_dist_lsd_mean(data); let sd = sort_dist_lsd_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn sort_dist_lsd_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn sort_dist_lsd_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn sort_dist_lsd_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn sort_dist_lsd_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn sort_dist_lsd_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn sort_dist_lsd_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

pub(all) struct SortdistlsdFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_lsd_frame_make(size : Int) -> SortdistlsdFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_lsd_frame_len(s : SortdistlsdFrame) -> Int { s.size }

pub fn sort_dist_lsd_frame_get(s : SortdistlsdFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_lsd_frame_set(s : SortdistlsdFrame, i : Int, v : Double) -> SortdistlsdFrame {
  let result = sort_dist_lsd_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_dist_lsd_frame_sum(s : SortdistlsdFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_dist_lsd_frame_mean(s : SortdistlsdFrame) -> Double {
  if s.size == 0 { 0.0 } else { sort_dist_lsd_frame_sum(s) / s.size.to_double() }
}

pub fn sort_dist_lsd_frame_scale(s : SortdistlsdFrame, f : Double) -> SortdistlsdFrame {
  let result = sort_dist_lsd_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_dist_lsd_frame_add(a : SortdistlsdFrame, b : SortdistlsdFrame) -> SortdistlsdFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_dist_lsd_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_dist_lsd_frame_copy(s : SortdistlsdFrame) -> SortdistlsdFrame {
  let result = sort_dist_lsd_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_dist_lsd_frame_fill(s : SortdistlsdFrame, v : Double) -> SortdistlsdFrame {
  let result = sort_dist_lsd_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_dist_lsd_frame_min(s : SortdistlsdFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_lsd_frame_max(s : SortdistlsdFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_lsd_frame_to_string(s : SortdistlsdFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistlsdTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_lsd_table_make(size : Int) -> SortdistlsdTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_lsd_table_len(s : SortdistlsdTable) -> Int { s.size }

pub fn sort_dist_lsd_table_get(s : SortdistlsdTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_lsd_table_set(s : SortdistlsdTable, i : Int, v : Double) -> SortdistlsdTable {
  let result = sort_dist_lsd_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_dist_lsd_table_sum(s : SortdistlsdTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_dist_lsd_table_mean(s : SortdistlsdTable) -> Double {
  if s.size == 0 { 0.0 } else { sort_dist_lsd_table_sum(s) / s.size.to_double() }
}

pub fn sort_dist_lsd_table_scale(s : SortdistlsdTable, f : Double) -> SortdistlsdTable {
  let result = sort_dist_lsd_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_dist_lsd_table_add(a : SortdistlsdTable, b : SortdistlsdTable) -> SortdistlsdTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_dist_lsd_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_dist_lsd_table_copy(s : SortdistlsdTable) -> SortdistlsdTable {
  let result = sort_dist_lsd_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_dist_lsd_table_fill(s : SortdistlsdTable, v : Double) -> SortdistlsdTable {
  let result = sort_dist_lsd_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_dist_lsd_table_min(s : SortdistlsdTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_lsd_table_max(s : SortdistlsdTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_lsd_table_to_string(s : SortdistlsdTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistlsdGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_lsd_graphn_make(size : Int) -> SortdistlsdGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_lsd_graphn_len(s : SortdistlsdGraphN) -> Int { s.size }

pub fn sort_dist_lsd_graphn_get(s : SortdistlsdGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_lsd_graphn_set(s : SortdistlsdGraphN, i : Int, v : Double) -> SortdistlsdGraphN {
  let result = sort_dist_lsd_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_dist_lsd_graphn_sum(s : SortdistlsdGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_dist_lsd_graphn_mean(s : SortdistlsdGraphN) -> Double {
  if s.size == 0 { 0.0 } else { sort_dist_lsd_graphn_sum(s) / s.size.to_double() }
}

pub fn sort_dist_lsd_graphn_scale(s : SortdistlsdGraphN, f : Double) -> SortdistlsdGraphN {
  let result = sort_dist_lsd_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_dist_lsd_graphn_add(a : SortdistlsdGraphN, b : SortdistlsdGraphN) -> SortdistlsdGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_dist_lsd_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_dist_lsd_graphn_copy(s : SortdistlsdGraphN) -> SortdistlsdGraphN {
  let result = sort_dist_lsd_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_dist_lsd_graphn_fill(s : SortdistlsdGraphN, v : Double) -> SortdistlsdGraphN {
  let result = sort_dist_lsd_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_dist_lsd_graphn_min(s : SortdistlsdGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_lsd_graphn_max(s : SortdistlsdGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_lsd_graphn_to_string(s : SortdistlsdGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistlsdNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_lsd_node_make(size : Int) -> SortdistlsdNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_lsd_node_len(s : SortdistlsdNode) -> Int { s.size }

pub fn sort_dist_lsd_node_get(s : SortdistlsdNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_lsd_node_set(s : SortdistlsdNode, i : Int, v : Double) -> SortdistlsdNode {
  let result = sort_dist_lsd_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_dist_lsd_node_sum(s : SortdistlsdNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_dist_lsd_node_mean(s : SortdistlsdNode) -> Double {
  if s.size == 0 { 0.0 } else { sort_dist_lsd_node_sum(s) / s.size.to_double() }
}

pub fn sort_dist_lsd_node_scale(s : SortdistlsdNode, f : Double) -> SortdistlsdNode {
  let result = sort_dist_lsd_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_dist_lsd_node_add(a : SortdistlsdNode, b : SortdistlsdNode) -> SortdistlsdNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_dist_lsd_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_dist_lsd_node_copy(s : SortdistlsdNode) -> SortdistlsdNode {
  let result = sort_dist_lsd_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_dist_lsd_node_fill(s : SortdistlsdNode, v : Double) -> SortdistlsdNode {
  let result = sort_dist_lsd_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_dist_lsd_node_min(s : SortdistlsdNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_lsd_node_max(s : SortdistlsdNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_lsd_node_to_string(s : SortdistlsdNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistlsdEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_lsd_edge_make(size : Int) -> SortdistlsdEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_lsd_edge_len(s : SortdistlsdEdge) -> Int { s.size }

pub fn sort_dist_lsd_edge_get(s : SortdistlsdEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_lsd_edge_set(s : SortdistlsdEdge, i : Int, v : Double) -> SortdistlsdEdge {
  let result = sort_dist_lsd_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_dist_lsd_edge_sum(s : SortdistlsdEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_dist_lsd_edge_mean(s : SortdistlsdEdge) -> Double {
  if s.size == 0 { 0.0 } else { sort_dist_lsd_edge_sum(s) / s.size.to_double() }
}

pub fn sort_dist_lsd_edge_scale(s : SortdistlsdEdge, f : Double) -> SortdistlsdEdge {
  let result = sort_dist_lsd_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_dist_lsd_edge_add(a : SortdistlsdEdge, b : SortdistlsdEdge) -> SortdistlsdEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_dist_lsd_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_dist_lsd_edge_copy(s : SortdistlsdEdge) -> SortdistlsdEdge {
  let result = sort_dist_lsd_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_dist_lsd_edge_fill(s : SortdistlsdEdge, v : Double) -> SortdistlsdEdge {
  let result = sort_dist_lsd_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_dist_lsd_edge_min(s : SortdistlsdEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_lsd_edge_max(s : SortdistlsdEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_lsd_edge_to_string(s : SortdistlsdEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistlsdPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_lsd_path_make(size : Int) -> SortdistlsdPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_lsd_path_len(s : SortdistlsdPath) -> Int { s.size }

pub fn sort_dist_lsd_path_get(s : SortdistlsdPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_lsd_path_set(s : SortdistlsdPath, i : Int, v : Double) -> SortdistlsdPath {
  let result = sort_dist_lsd_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_dist_lsd_path_sum(s : SortdistlsdPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_dist_lsd_path_mean(s : SortdistlsdPath) -> Double {
  if s.size == 0 { 0.0 } else { sort_dist_lsd_path_sum(s) / s.size.to_double() }
}

pub fn sort_dist_lsd_path_scale(s : SortdistlsdPath, f : Double) -> SortdistlsdPath {
  let result = sort_dist_lsd_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_dist_lsd_path_add(a : SortdistlsdPath, b : SortdistlsdPath) -> SortdistlsdPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_dist_lsd_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_dist_lsd_path_copy(s : SortdistlsdPath) -> SortdistlsdPath {
  let result = sort_dist_lsd_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_dist_lsd_path_fill(s : SortdistlsdPath, v : Double) -> SortdistlsdPath {
  let result = sort_dist_lsd_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_dist_lsd_path_min(s : SortdistlsdPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_lsd_path_max(s : SortdistlsdPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_lsd_path_to_string(s : SortdistlsdPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistlsdCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_lsd_cluster_make(size : Int) -> SortdistlsdCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_lsd_cluster_len(s : SortdistlsdCluster) -> Int { s.size }

pub fn sort_dist_lsd_cluster_get(s : SortdistlsdCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_lsd_cluster_set(s : SortdistlsdCluster, i : Int, v : Double) -> SortdistlsdCluster {
  let result = sort_dist_lsd_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_dist_lsd_cluster_sum(s : SortdistlsdCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_dist_lsd_cluster_mean(s : SortdistlsdCluster) -> Double {
  if s.size == 0 { 0.0 } else { sort_dist_lsd_cluster_sum(s) / s.size.to_double() }
}

pub fn sort_dist_lsd_cluster_scale(s : SortdistlsdCluster, f : Double) -> SortdistlsdCluster {
  let result = sort_dist_lsd_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_dist_lsd_cluster_add(a : SortdistlsdCluster, b : SortdistlsdCluster) -> SortdistlsdCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_dist_lsd_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_dist_lsd_cluster_copy(s : SortdistlsdCluster) -> SortdistlsdCluster {
  let result = sort_dist_lsd_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_dist_lsd_cluster_fill(s : SortdistlsdCluster, v : Double) -> SortdistlsdCluster {
  let result = sort_dist_lsd_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_dist_lsd_cluster_min(s : SortdistlsdCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_lsd_cluster_max(s : SortdistlsdCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_lsd_cluster_to_string(s : SortdistlsdCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistlsdModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_lsd_model_make(size : Int) -> SortdistlsdModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_lsd_model_len(s : SortdistlsdModel) -> Int { s.size }

pub fn sort_dist_lsd_model_get(s : SortdistlsdModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_lsd_model_set(s : SortdistlsdModel, i : Int, v : Double) -> SortdistlsdModel {
  let result = sort_dist_lsd_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_dist_lsd_model_sum(s : SortdistlsdModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_dist_lsd_model_mean(s : SortdistlsdModel) -> Double {
  if s.size == 0 { 0.0 } else { sort_dist_lsd_model_sum(s) / s.size.to_double() }
}

pub fn sort_dist_lsd_model_scale(s : SortdistlsdModel, f : Double) -> SortdistlsdModel {
  let result = sort_dist_lsd_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_dist_lsd_model_add(a : SortdistlsdModel, b : SortdistlsdModel) -> SortdistlsdModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_dist_lsd_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_dist_lsd_model_copy(s : SortdistlsdModel) -> SortdistlsdModel {
  let result = sort_dist_lsd_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_dist_lsd_model_fill(s : SortdistlsdModel, v : Double) -> SortdistlsdModel {
  let result = sort_dist_lsd_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_dist_lsd_model_min(s : SortdistlsdModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_lsd_model_max(s : SortdistlsdModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_lsd_model_to_string(s : SortdistlsdModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistlsdLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_lsd_layer_make(size : Int) -> SortdistlsdLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_lsd_layer_len(s : SortdistlsdLayer) -> Int { s.size }

pub fn sort_dist_lsd_layer_get(s : SortdistlsdLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_lsd_layer_set(s : SortdistlsdLayer, i : Int, v : Double) -> SortdistlsdLayer {
  let result = sort_dist_lsd_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_dist_lsd_layer_sum(s : SortdistlsdLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_dist_lsd_layer_mean(s : SortdistlsdLayer) -> Double {
  if s.size == 0 { 0.0 } else { sort_dist_lsd_layer_sum(s) / s.size.to_double() }
}

pub fn sort_dist_lsd_layer_scale(s : SortdistlsdLayer, f : Double) -> SortdistlsdLayer {
  let result = sort_dist_lsd_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_dist_lsd_layer_add(a : SortdistlsdLayer, b : SortdistlsdLayer) -> SortdistlsdLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_dist_lsd_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_dist_lsd_layer_copy(s : SortdistlsdLayer) -> SortdistlsdLayer {
  let result = sort_dist_lsd_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_dist_lsd_layer_fill(s : SortdistlsdLayer, v : Double) -> SortdistlsdLayer {
  let result = sort_dist_lsd_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_dist_lsd_layer_min(s : SortdistlsdLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_lsd_layer_max(s : SortdistlsdLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_lsd_layer_to_string(s : SortdistlsdLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistlsdBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_lsd_buffer_make(size : Int) -> SortdistlsdBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_lsd_buffer_len(s : SortdistlsdBuffer) -> Int { s.size }

pub fn sort_dist_lsd_buffer_get(s : SortdistlsdBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_lsd_buffer_set(s : SortdistlsdBuffer, i : Int, v : Double) -> SortdistlsdBuffer {
  let result = sort_dist_lsd_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_dist_lsd_buffer_sum(s : SortdistlsdBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_dist_lsd_buffer_mean(s : SortdistlsdBuffer) -> Double {
  if s.size == 0 { 0.0 } else { sort_dist_lsd_buffer_sum(s) / s.size.to_double() }
}

pub fn sort_dist_lsd_buffer_scale(s : SortdistlsdBuffer, f : Double) -> SortdistlsdBuffer {
  let result = sort_dist_lsd_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_dist_lsd_buffer_add(a : SortdistlsdBuffer, b : SortdistlsdBuffer) -> SortdistlsdBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_dist_lsd_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_dist_lsd_buffer_copy(s : SortdistlsdBuffer) -> SortdistlsdBuffer {
  let result = sort_dist_lsd_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_dist_lsd_buffer_fill(s : SortdistlsdBuffer, v : Double) -> SortdistlsdBuffer {
  let result = sort_dist_lsd_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_dist_lsd_buffer_min(s : SortdistlsdBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_lsd_buffer_max(s : SortdistlsdBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_lsd_buffer_to_string(s : SortdistlsdBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistlsdCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_lsd_cursor_make(size : Int) -> SortdistlsdCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_lsd_cursor_len(s : SortdistlsdCursor) -> Int { s.size }

pub fn sort_dist_lsd_cursor_get(s : SortdistlsdCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_lsd_cursor_set(s : SortdistlsdCursor, i : Int, v : Double) -> SortdistlsdCursor {
  let result = sort_dist_lsd_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_dist_lsd_cursor_sum(s : SortdistlsdCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_dist_lsd_cursor_mean(s : SortdistlsdCursor) -> Double {
  if s.size == 0 { 0.0 } else { sort_dist_lsd_cursor_sum(s) / s.size.to_double() }
}

pub fn sort_dist_lsd_cursor_scale(s : SortdistlsdCursor, f : Double) -> SortdistlsdCursor {
  let result = sort_dist_lsd_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_dist_lsd_cursor_add(a : SortdistlsdCursor, b : SortdistlsdCursor) -> SortdistlsdCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_dist_lsd_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_dist_lsd_cursor_copy(s : SortdistlsdCursor) -> SortdistlsdCursor {
  let result = sort_dist_lsd_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_dist_lsd_cursor_fill(s : SortdistlsdCursor, v : Double) -> SortdistlsdCursor {
  let result = sort_dist_lsd_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_dist_lsd_cursor_min(s : SortdistlsdCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_lsd_cursor_max(s : SortdistlsdCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_lsd_cursor_to_string(s : SortdistlsdCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistlsdView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_lsd_view_make(size : Int) -> SortdistlsdView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_lsd_view_len(s : SortdistlsdView) -> Int { s.size }

pub fn sort_dist_lsd_view_get(s : SortdistlsdView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_lsd_view_set(s : SortdistlsdView, i : Int, v : Double) -> SortdistlsdView {
  let result = sort_dist_lsd_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_dist_lsd_view_sum(s : SortdistlsdView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_dist_lsd_view_mean(s : SortdistlsdView) -> Double {
  if s.size == 0 { 0.0 } else { sort_dist_lsd_view_sum(s) / s.size.to_double() }
}

pub fn sort_dist_lsd_view_scale(s : SortdistlsdView, f : Double) -> SortdistlsdView {
  let result = sort_dist_lsd_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_dist_lsd_view_add(a : SortdistlsdView, b : SortdistlsdView) -> SortdistlsdView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_dist_lsd_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_dist_lsd_view_copy(s : SortdistlsdView) -> SortdistlsdView {
  let result = sort_dist_lsd_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_dist_lsd_view_fill(s : SortdistlsdView, v : Double) -> SortdistlsdView {
  let result = sort_dist_lsd_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_dist_lsd_view_min(s : SortdistlsdView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_lsd_view_max(s : SortdistlsdView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_lsd_view_to_string(s : SortdistlsdView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistlsdRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_lsd_range_make(size : Int) -> SortdistlsdRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_lsd_range_len(s : SortdistlsdRange) -> Int { s.size }

pub fn sort_dist_lsd_range_get(s : SortdistlsdRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_lsd_range_set(s : SortdistlsdRange, i : Int, v : Double) -> SortdistlsdRange {
  let result = sort_dist_lsd_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_dist_lsd_range_sum(s : SortdistlsdRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_dist_lsd_range_mean(s : SortdistlsdRange) -> Double {
  if s.size == 0 { 0.0 } else { sort_dist_lsd_range_sum(s) / s.size.to_double() }
}

pub fn sort_dist_lsd_range_scale(s : SortdistlsdRange, f : Double) -> SortdistlsdRange {
  let result = sort_dist_lsd_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_dist_lsd_range_add(a : SortdistlsdRange, b : SortdistlsdRange) -> SortdistlsdRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_dist_lsd_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_dist_lsd_range_copy(s : SortdistlsdRange) -> SortdistlsdRange {
  let result = sort_dist_lsd_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_dist_lsd_range_fill(s : SortdistlsdRange, v : Double) -> SortdistlsdRange {
  let result = sort_dist_lsd_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_dist_lsd_range_min(s : SortdistlsdRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_lsd_range_max(s : SortdistlsdRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_lsd_range_to_string(s : SortdistlsdRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistlsdSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_lsd_slice_make(size : Int) -> SortdistlsdSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_lsd_slice_len(s : SortdistlsdSlice) -> Int { s.size }

pub fn sort_dist_lsd_slice_get(s : SortdistlsdSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_lsd_slice_set(s : SortdistlsdSlice, i : Int, v : Double) -> SortdistlsdSlice {
  let result = sort_dist_lsd_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_dist_lsd_slice_sum(s : SortdistlsdSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_dist_lsd_slice_mean(s : SortdistlsdSlice) -> Double {
  if s.size == 0 { 0.0 } else { sort_dist_lsd_slice_sum(s) / s.size.to_double() }
}

pub fn sort_dist_lsd_slice_scale(s : SortdistlsdSlice, f : Double) -> SortdistlsdSlice {
  let result = sort_dist_lsd_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_dist_lsd_slice_add(a : SortdistlsdSlice, b : SortdistlsdSlice) -> SortdistlsdSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_dist_lsd_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_dist_lsd_slice_copy(s : SortdistlsdSlice) -> SortdistlsdSlice {
  let result = sort_dist_lsd_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_dist_lsd_slice_fill(s : SortdistlsdSlice, v : Double) -> SortdistlsdSlice {
  let result = sort_dist_lsd_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_dist_lsd_slice_min(s : SortdistlsdSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_lsd_slice_max(s : SortdistlsdSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_lsd_slice_to_string(s : SortdistlsdSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

