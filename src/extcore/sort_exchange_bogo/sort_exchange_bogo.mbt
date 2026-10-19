///===
/// extcore/sort_exchange_bogo

pub(all) struct SortexchangebogoPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn sort_exchange_bogo_make_point(x : Double, y : Double) -> SortexchangebogoPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn sort_exchange_bogo_make_point3(x : Double, y : Double, z : Double) -> SortexchangebogoPoint {
  { x, y, z, label: 0 }
}

pub fn sort_exchange_bogo_point_x(pt : SortexchangebogoPoint) -> Double { pt.x }

pub fn sort_exchange_bogo_point_y(pt : SortexchangebogoPoint) -> Double { pt.y }

pub fn sort_exchange_bogo_point_z(pt : SortexchangebogoPoint) -> Double { pt.z }

pub fn sort_exchange_bogo_point_label(pt : SortexchangebogoPoint) -> Int { pt.label }

pub fn sort_exchange_bogo_point_dist(a : SortexchangebogoPoint, b : SortexchangebogoPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn sort_exchange_bogo_point_add(a : SortexchangebogoPoint, b : SortexchangebogoPoint) -> SortexchangebogoPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn sort_exchange_bogo_point_sub(a : SortexchangebogoPoint, b : SortexchangebogoPoint) -> SortexchangebogoPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn sort_exchange_bogo_point_scale(pt : SortexchangebogoPoint, s : Double) -> SortexchangebogoPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn sort_exchange_bogo_point_dot(a : SortexchangebogoPoint, b : SortexchangebogoPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn sort_exchange_bogo_point_cross(a : SortexchangebogoPoint, b : SortexchangebogoPoint) -> SortexchangebogoPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn sort_exchange_bogo_point_norm(pt : SortexchangebogoPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn sort_exchange_bogo_point_normalize(pt : SortexchangebogoPoint) -> SortexchangebogoPoint {
  let n = sort_exchange_bogo_point_norm(pt)
  if n < 0.0000001 { pt } else { sort_exchange_bogo_point_scale(pt, 1.0 / n) }
}

pub fn sort_exchange_bogo_point_negate(pt : SortexchangebogoPoint) -> SortexchangebogoPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn sort_exchange_bogo_point_mid(a : SortexchangebogoPoint, b : SortexchangebogoPoint) -> SortexchangebogoPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn sort_exchange_bogo_point_lerp(a : SortexchangebogoPoint, b : SortexchangebogoPoint, t : Double) -> SortexchangebogoPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn sort_exchange_bogo_point_to_string(pt : SortexchangebogoPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct SortexchangebogoSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn sort_exchange_bogo_make_series(vals : Array[Double], name : String) -> SortexchangebogoSeries {
  { vals, name, meta: 0 }
}

pub fn sort_exchange_bogo_series_len(s : SortexchangebogoSeries) -> Int { s.vals.length() }

pub fn sort_exchange_bogo_series_sum(s : SortexchangebogoSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn sort_exchange_bogo_series_mean(s : SortexchangebogoSeries) -> Double {
  let n = sort_exchange_bogo_series_len(s)
  if n == 0 { 0.0 } else { sort_exchange_bogo_series_sum(s) / n.to_double() }
}

pub fn sort_exchange_bogo_series_min(s : SortexchangebogoSeries) -> Double {
  let n = sort_exchange_bogo_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn sort_exchange_bogo_series_max(s : SortexchangebogoSeries) -> Double {
  let n = sort_exchange_bogo_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn sort_exchange_bogo_series_range(s : SortexchangebogoSeries) -> Double {
  sort_exchange_bogo_series_max(s) - sort_exchange_bogo_series_min(s)
}

pub fn sort_exchange_bogo_series_var(s : SortexchangebogoSeries) -> Double {
  let n = sort_exchange_bogo_series_len(s)
  if n == 0 { 0.0 } else {
    let m = sort_exchange_bogo_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn sort_exchange_bogo_series_std(s : SortexchangebogoSeries) -> Double { @_common.sqrt(sort_exchange_bogo_series_var(s)) }

pub fn sort_exchange_bogo_series_median(s : SortexchangebogoSeries) -> Double {
  let n = sort_exchange_bogo_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = sort_exchange_bogo_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn sort_exchange_bogo_series_scale(s : SortexchangebogoSeries, f : Double) -> SortexchangebogoSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn sort_exchange_bogo_series_add(a : SortexchangebogoSeries, b : SortexchangebogoSeries) -> SortexchangebogoSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn sort_exchange_bogo_series_sub(a : SortexchangebogoSeries, b : SortexchangebogoSeries) -> SortexchangebogoSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn sort_exchange_bogo_series_normalize(s : SortexchangebogoSeries) -> SortexchangebogoSeries {
  let mn = sort_exchange_bogo_series_min(s)
  let mx = sort_exchange_bogo_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn sort_exchange_bogo_series_cumsum(s : SortexchangebogoSeries) -> SortexchangebogoSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn sort_exchange_bogo_series_to_string(s : SortexchangebogoSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SortexchangebogoMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn sort_exchange_bogo_make_matrix(rows : Int, cols : Int, val : Double) -> SortexchangebogoMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn sort_exchange_bogo_matrix_identity(n : Int) -> SortexchangebogoMatrix {
  let m = sort_exchange_bogo_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn sort_exchange_bogo_matrix_get(m : SortexchangebogoMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn sort_exchange_bogo_matrix_transpose(m : SortexchangebogoMatrix) -> SortexchangebogoMatrix {
  let result = sort_exchange_bogo_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn sort_exchange_bogo_matrix_add(a : SortexchangebogoMatrix, b : SortexchangebogoMatrix) -> SortexchangebogoMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = sort_exchange_bogo_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn sort_exchange_bogo_matrix_scale(m : SortexchangebogoMatrix, s : Double) -> SortexchangebogoMatrix {
  let result = sort_exchange_bogo_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn sort_exchange_bogo_matrix_multiply(a : SortexchangebogoMatrix, b : SortexchangebogoMatrix) -> SortexchangebogoMatrix {
  if a.cols != b.rows { return sort_exchange_bogo_make_matrix(a.rows, b.cols, 0.0) }
  let result = sort_exchange_bogo_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn sort_exchange_bogo_matrix_trace(m : SortexchangebogoMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn sort_exchange_bogo_matrix_det(m : SortexchangebogoMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn sort_exchange_bogo_matrix_norm(m : SortexchangebogoMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn sort_exchange_bogo_matrix_to_string(m : SortexchangebogoMatrix) -> String {
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

pub(all) struct SortexchangebogoVector {
  comps : Array[Double]
  dim : Int
}

pub fn sort_exchange_bogo_make_vector(comps : Array[Double]) -> SortexchangebogoVector {
  { comps, dim: comps.length() }
}

pub fn sort_exchange_bogo_vector_zero(dim : Int) -> SortexchangebogoVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn sort_exchange_bogo_vector_add(a : SortexchangebogoVector, b : SortexchangebogoVector) -> SortexchangebogoVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn sort_exchange_bogo_vector_sub(a : SortexchangebogoVector, b : SortexchangebogoVector) -> SortexchangebogoVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn sort_exchange_bogo_vector_scale(v : SortexchangebogoVector, s : Double) -> SortexchangebogoVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn sort_exchange_bogo_vector_dot(a : SortexchangebogoVector, b : SortexchangebogoVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn sort_exchange_bogo_vector_norm(v : SortexchangebogoVector) -> Double { @_common.sqrt(sort_exchange_bogo_vector_dot(v, v)) }

pub fn sort_exchange_bogo_vector_normalize(v : SortexchangebogoVector) -> SortexchangebogoVector {
  let n = sort_exchange_bogo_vector_norm(v)
  if n < 0.0000001 { v } else { sort_exchange_bogo_vector_scale(v, 1.0 / n) }
}

pub fn sort_exchange_bogo_vector_dist(a : SortexchangebogoVector, b : SortexchangebogoVector) -> Double {
  sort_exchange_bogo_vector_norm(sort_exchange_bogo_vector_sub(a, b))
}

pub fn sort_exchange_bogo_vector_to_string(v : SortexchangebogoVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn sort_exchange_bogo_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn sort_exchange_bogo_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = sort_exchange_bogo_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn sort_exchange_bogo_std(data : Array[Double]) -> Double { @_common.sqrt(sort_exchange_bogo_var(data)) }

pub fn sort_exchange_bogo_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = sort_exchange_bogo_mean(a); let mb = sort_exchange_bogo_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn sort_exchange_bogo_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = sort_exchange_bogo_std(a); let sb = sort_exchange_bogo_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { sort_exchange_bogo_cov(a, b) / (sa * sb) }
}

pub fn sort_exchange_bogo_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = sort_exchange_bogo_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn sort_exchange_bogo_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn sort_exchange_bogo_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn sort_exchange_bogo_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  @_common.sqrt(sort_exchange_bogo_mse(pred, labels))
}

pub fn sort_exchange_bogo_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn sort_exchange_bogo_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = sort_exchange_bogo_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn sort_exchange_bogo_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn sort_exchange_bogo_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn sort_exchange_bogo_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = sort_exchange_bogo_precision(pred, labels, pos); let r = sort_exchange_bogo_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn sort_exchange_bogo_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn sort_exchange_bogo_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = sort_exchange_bogo_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn sort_exchange_bogo_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn sort_exchange_bogo_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn sort_exchange_bogo_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = sort_exchange_bogo_gcd(a, b)
    (a / g) * b
  }
}

pub fn sort_exchange_bogo_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn sort_exchange_bogo_fibonacci(n : Int) -> Int {
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

pub fn sort_exchange_bogo_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = sort_exchange_bogo_min(data); let mx = sort_exchange_bogo_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn sort_exchange_bogo_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = sort_exchange_bogo_mean(data); let sd = sort_exchange_bogo_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn sort_exchange_bogo_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn sort_exchange_bogo_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn sort_exchange_bogo_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn sort_exchange_bogo_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn sort_exchange_bogo_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn sort_exchange_bogo_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

pub(all) struct SortexchangebogoFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_bogo_frame_make(size : Int) -> SortexchangebogoFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_bogo_frame_len(s : SortexchangebogoFrame) -> Int { s.size }

pub fn sort_exchange_bogo_frame_get(s : SortexchangebogoFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_bogo_frame_set(s : SortexchangebogoFrame, i : Int, v : Double) -> SortexchangebogoFrame {
  let result = sort_exchange_bogo_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_bogo_frame_sum(s : SortexchangebogoFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_exchange_bogo_frame_mean(s : SortexchangebogoFrame) -> Double {
  if s.size == 0 { 0.0 } else { sort_exchange_bogo_frame_sum(s) / s.size.to_double() }
}

pub fn sort_exchange_bogo_frame_scale(s : SortexchangebogoFrame, f : Double) -> SortexchangebogoFrame {
  let result = sort_exchange_bogo_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_exchange_bogo_frame_add(a : SortexchangebogoFrame, b : SortexchangebogoFrame) -> SortexchangebogoFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_exchange_bogo_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_exchange_bogo_frame_copy(s : SortexchangebogoFrame) -> SortexchangebogoFrame {
  let result = sort_exchange_bogo_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_exchange_bogo_frame_fill(s : SortexchangebogoFrame, v : Double) -> SortexchangebogoFrame {
  let result = sort_exchange_bogo_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_bogo_frame_min(s : SortexchangebogoFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_bogo_frame_max(s : SortexchangebogoFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_bogo_frame_to_string(s : SortexchangebogoFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangebogoTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_bogo_table_make(size : Int) -> SortexchangebogoTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_bogo_table_len(s : SortexchangebogoTable) -> Int { s.size }

pub fn sort_exchange_bogo_table_get(s : SortexchangebogoTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_bogo_table_set(s : SortexchangebogoTable, i : Int, v : Double) -> SortexchangebogoTable {
  let result = sort_exchange_bogo_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_bogo_table_sum(s : SortexchangebogoTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_exchange_bogo_table_mean(s : SortexchangebogoTable) -> Double {
  if s.size == 0 { 0.0 } else { sort_exchange_bogo_table_sum(s) / s.size.to_double() }
}

pub fn sort_exchange_bogo_table_scale(s : SortexchangebogoTable, f : Double) -> SortexchangebogoTable {
  let result = sort_exchange_bogo_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_exchange_bogo_table_add(a : SortexchangebogoTable, b : SortexchangebogoTable) -> SortexchangebogoTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_exchange_bogo_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_exchange_bogo_table_copy(s : SortexchangebogoTable) -> SortexchangebogoTable {
  let result = sort_exchange_bogo_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_exchange_bogo_table_fill(s : SortexchangebogoTable, v : Double) -> SortexchangebogoTable {
  let result = sort_exchange_bogo_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_bogo_table_min(s : SortexchangebogoTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_bogo_table_max(s : SortexchangebogoTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_bogo_table_to_string(s : SortexchangebogoTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangebogoGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_bogo_graphn_make(size : Int) -> SortexchangebogoGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_bogo_graphn_len(s : SortexchangebogoGraphN) -> Int { s.size }

pub fn sort_exchange_bogo_graphn_get(s : SortexchangebogoGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_bogo_graphn_set(s : SortexchangebogoGraphN, i : Int, v : Double) -> SortexchangebogoGraphN {
  let result = sort_exchange_bogo_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_bogo_graphn_sum(s : SortexchangebogoGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_exchange_bogo_graphn_mean(s : SortexchangebogoGraphN) -> Double {
  if s.size == 0 { 0.0 } else { sort_exchange_bogo_graphn_sum(s) / s.size.to_double() }
}

pub fn sort_exchange_bogo_graphn_scale(s : SortexchangebogoGraphN, f : Double) -> SortexchangebogoGraphN {
  let result = sort_exchange_bogo_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_exchange_bogo_graphn_add(a : SortexchangebogoGraphN, b : SortexchangebogoGraphN) -> SortexchangebogoGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_exchange_bogo_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_exchange_bogo_graphn_copy(s : SortexchangebogoGraphN) -> SortexchangebogoGraphN {
  let result = sort_exchange_bogo_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_exchange_bogo_graphn_fill(s : SortexchangebogoGraphN, v : Double) -> SortexchangebogoGraphN {
  let result = sort_exchange_bogo_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_bogo_graphn_min(s : SortexchangebogoGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_bogo_graphn_max(s : SortexchangebogoGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_bogo_graphn_to_string(s : SortexchangebogoGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangebogoNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_bogo_node_make(size : Int) -> SortexchangebogoNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_bogo_node_len(s : SortexchangebogoNode) -> Int { s.size }

pub fn sort_exchange_bogo_node_get(s : SortexchangebogoNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_bogo_node_set(s : SortexchangebogoNode, i : Int, v : Double) -> SortexchangebogoNode {
  let result = sort_exchange_bogo_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_bogo_node_sum(s : SortexchangebogoNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_exchange_bogo_node_mean(s : SortexchangebogoNode) -> Double {
  if s.size == 0 { 0.0 } else { sort_exchange_bogo_node_sum(s) / s.size.to_double() }
}

pub fn sort_exchange_bogo_node_scale(s : SortexchangebogoNode, f : Double) -> SortexchangebogoNode {
  let result = sort_exchange_bogo_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_exchange_bogo_node_add(a : SortexchangebogoNode, b : SortexchangebogoNode) -> SortexchangebogoNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_exchange_bogo_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_exchange_bogo_node_copy(s : SortexchangebogoNode) -> SortexchangebogoNode {
  let result = sort_exchange_bogo_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_exchange_bogo_node_fill(s : SortexchangebogoNode, v : Double) -> SortexchangebogoNode {
  let result = sort_exchange_bogo_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_bogo_node_min(s : SortexchangebogoNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_bogo_node_max(s : SortexchangebogoNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_bogo_node_to_string(s : SortexchangebogoNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangebogoEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_bogo_edge_make(size : Int) -> SortexchangebogoEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_bogo_edge_len(s : SortexchangebogoEdge) -> Int { s.size }

pub fn sort_exchange_bogo_edge_get(s : SortexchangebogoEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_bogo_edge_set(s : SortexchangebogoEdge, i : Int, v : Double) -> SortexchangebogoEdge {
  let result = sort_exchange_bogo_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_bogo_edge_sum(s : SortexchangebogoEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_exchange_bogo_edge_mean(s : SortexchangebogoEdge) -> Double {
  if s.size == 0 { 0.0 } else { sort_exchange_bogo_edge_sum(s) / s.size.to_double() }
}

pub fn sort_exchange_bogo_edge_scale(s : SortexchangebogoEdge, f : Double) -> SortexchangebogoEdge {
  let result = sort_exchange_bogo_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_exchange_bogo_edge_add(a : SortexchangebogoEdge, b : SortexchangebogoEdge) -> SortexchangebogoEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_exchange_bogo_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_exchange_bogo_edge_copy(s : SortexchangebogoEdge) -> SortexchangebogoEdge {
  let result = sort_exchange_bogo_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_exchange_bogo_edge_fill(s : SortexchangebogoEdge, v : Double) -> SortexchangebogoEdge {
  let result = sort_exchange_bogo_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_bogo_edge_min(s : SortexchangebogoEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_bogo_edge_max(s : SortexchangebogoEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_bogo_edge_to_string(s : SortexchangebogoEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangebogoPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_bogo_path_make(size : Int) -> SortexchangebogoPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_bogo_path_len(s : SortexchangebogoPath) -> Int { s.size }

pub fn sort_exchange_bogo_path_get(s : SortexchangebogoPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_bogo_path_set(s : SortexchangebogoPath, i : Int, v : Double) -> SortexchangebogoPath {
  let result = sort_exchange_bogo_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_bogo_path_sum(s : SortexchangebogoPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_exchange_bogo_path_mean(s : SortexchangebogoPath) -> Double {
  if s.size == 0 { 0.0 } else { sort_exchange_bogo_path_sum(s) / s.size.to_double() }
}

pub fn sort_exchange_bogo_path_scale(s : SortexchangebogoPath, f : Double) -> SortexchangebogoPath {
  let result = sort_exchange_bogo_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_exchange_bogo_path_add(a : SortexchangebogoPath, b : SortexchangebogoPath) -> SortexchangebogoPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_exchange_bogo_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_exchange_bogo_path_copy(s : SortexchangebogoPath) -> SortexchangebogoPath {
  let result = sort_exchange_bogo_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_exchange_bogo_path_fill(s : SortexchangebogoPath, v : Double) -> SortexchangebogoPath {
  let result = sort_exchange_bogo_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_bogo_path_min(s : SortexchangebogoPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_bogo_path_max(s : SortexchangebogoPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_bogo_path_to_string(s : SortexchangebogoPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangebogoCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_bogo_cluster_make(size : Int) -> SortexchangebogoCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_bogo_cluster_len(s : SortexchangebogoCluster) -> Int { s.size }

pub fn sort_exchange_bogo_cluster_get(s : SortexchangebogoCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_bogo_cluster_set(s : SortexchangebogoCluster, i : Int, v : Double) -> SortexchangebogoCluster {
  let result = sort_exchange_bogo_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_bogo_cluster_sum(s : SortexchangebogoCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_exchange_bogo_cluster_mean(s : SortexchangebogoCluster) -> Double {
  if s.size == 0 { 0.0 } else { sort_exchange_bogo_cluster_sum(s) / s.size.to_double() }
}

pub fn sort_exchange_bogo_cluster_scale(s : SortexchangebogoCluster, f : Double) -> SortexchangebogoCluster {
  let result = sort_exchange_bogo_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_exchange_bogo_cluster_add(a : SortexchangebogoCluster, b : SortexchangebogoCluster) -> SortexchangebogoCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_exchange_bogo_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_exchange_bogo_cluster_copy(s : SortexchangebogoCluster) -> SortexchangebogoCluster {
  let result = sort_exchange_bogo_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_exchange_bogo_cluster_fill(s : SortexchangebogoCluster, v : Double) -> SortexchangebogoCluster {
  let result = sort_exchange_bogo_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_bogo_cluster_min(s : SortexchangebogoCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_bogo_cluster_max(s : SortexchangebogoCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_bogo_cluster_to_string(s : SortexchangebogoCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangebogoModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_bogo_model_make(size : Int) -> SortexchangebogoModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_bogo_model_len(s : SortexchangebogoModel) -> Int { s.size }

pub fn sort_exchange_bogo_model_get(s : SortexchangebogoModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_bogo_model_set(s : SortexchangebogoModel, i : Int, v : Double) -> SortexchangebogoModel {
  let result = sort_exchange_bogo_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_bogo_model_sum(s : SortexchangebogoModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_exchange_bogo_model_mean(s : SortexchangebogoModel) -> Double {
  if s.size == 0 { 0.0 } else { sort_exchange_bogo_model_sum(s) / s.size.to_double() }
}

pub fn sort_exchange_bogo_model_scale(s : SortexchangebogoModel, f : Double) -> SortexchangebogoModel {
  let result = sort_exchange_bogo_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_exchange_bogo_model_add(a : SortexchangebogoModel, b : SortexchangebogoModel) -> SortexchangebogoModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_exchange_bogo_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_exchange_bogo_model_copy(s : SortexchangebogoModel) -> SortexchangebogoModel {
  let result = sort_exchange_bogo_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_exchange_bogo_model_fill(s : SortexchangebogoModel, v : Double) -> SortexchangebogoModel {
  let result = sort_exchange_bogo_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_bogo_model_min(s : SortexchangebogoModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_bogo_model_max(s : SortexchangebogoModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_bogo_model_to_string(s : SortexchangebogoModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangebogoLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_bogo_layer_make(size : Int) -> SortexchangebogoLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_bogo_layer_len(s : SortexchangebogoLayer) -> Int { s.size }

pub fn sort_exchange_bogo_layer_get(s : SortexchangebogoLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_bogo_layer_set(s : SortexchangebogoLayer, i : Int, v : Double) -> SortexchangebogoLayer {
  let result = sort_exchange_bogo_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_bogo_layer_sum(s : SortexchangebogoLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_exchange_bogo_layer_mean(s : SortexchangebogoLayer) -> Double {
  if s.size == 0 { 0.0 } else { sort_exchange_bogo_layer_sum(s) / s.size.to_double() }
}

pub fn sort_exchange_bogo_layer_scale(s : SortexchangebogoLayer, f : Double) -> SortexchangebogoLayer {
  let result = sort_exchange_bogo_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_exchange_bogo_layer_add(a : SortexchangebogoLayer, b : SortexchangebogoLayer) -> SortexchangebogoLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_exchange_bogo_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_exchange_bogo_layer_copy(s : SortexchangebogoLayer) -> SortexchangebogoLayer {
  let result = sort_exchange_bogo_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_exchange_bogo_layer_fill(s : SortexchangebogoLayer, v : Double) -> SortexchangebogoLayer {
  let result = sort_exchange_bogo_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_bogo_layer_min(s : SortexchangebogoLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_bogo_layer_max(s : SortexchangebogoLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_bogo_layer_to_string(s : SortexchangebogoLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangebogoBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_bogo_buffer_make(size : Int) -> SortexchangebogoBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_bogo_buffer_len(s : SortexchangebogoBuffer) -> Int { s.size }

pub fn sort_exchange_bogo_buffer_get(s : SortexchangebogoBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_bogo_buffer_set(s : SortexchangebogoBuffer, i : Int, v : Double) -> SortexchangebogoBuffer {
  let result = sort_exchange_bogo_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_bogo_buffer_sum(s : SortexchangebogoBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_exchange_bogo_buffer_mean(s : SortexchangebogoBuffer) -> Double {
  if s.size == 0 { 0.0 } else { sort_exchange_bogo_buffer_sum(s) / s.size.to_double() }
}

pub fn sort_exchange_bogo_buffer_scale(s : SortexchangebogoBuffer, f : Double) -> SortexchangebogoBuffer {
  let result = sort_exchange_bogo_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_exchange_bogo_buffer_add(a : SortexchangebogoBuffer, b : SortexchangebogoBuffer) -> SortexchangebogoBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_exchange_bogo_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_exchange_bogo_buffer_copy(s : SortexchangebogoBuffer) -> SortexchangebogoBuffer {
  let result = sort_exchange_bogo_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_exchange_bogo_buffer_fill(s : SortexchangebogoBuffer, v : Double) -> SortexchangebogoBuffer {
  let result = sort_exchange_bogo_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_bogo_buffer_min(s : SortexchangebogoBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_bogo_buffer_max(s : SortexchangebogoBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_bogo_buffer_to_string(s : SortexchangebogoBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangebogoCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_bogo_cursor_make(size : Int) -> SortexchangebogoCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_bogo_cursor_len(s : SortexchangebogoCursor) -> Int { s.size }

pub fn sort_exchange_bogo_cursor_get(s : SortexchangebogoCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_bogo_cursor_set(s : SortexchangebogoCursor, i : Int, v : Double) -> SortexchangebogoCursor {
  let result = sort_exchange_bogo_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_bogo_cursor_sum(s : SortexchangebogoCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_exchange_bogo_cursor_mean(s : SortexchangebogoCursor) -> Double {
  if s.size == 0 { 0.0 } else { sort_exchange_bogo_cursor_sum(s) / s.size.to_double() }
}

pub fn sort_exchange_bogo_cursor_scale(s : SortexchangebogoCursor, f : Double) -> SortexchangebogoCursor {
  let result = sort_exchange_bogo_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_exchange_bogo_cursor_add(a : SortexchangebogoCursor, b : SortexchangebogoCursor) -> SortexchangebogoCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_exchange_bogo_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_exchange_bogo_cursor_copy(s : SortexchangebogoCursor) -> SortexchangebogoCursor {
  let result = sort_exchange_bogo_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_exchange_bogo_cursor_fill(s : SortexchangebogoCursor, v : Double) -> SortexchangebogoCursor {
  let result = sort_exchange_bogo_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_bogo_cursor_min(s : SortexchangebogoCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_bogo_cursor_max(s : SortexchangebogoCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_bogo_cursor_to_string(s : SortexchangebogoCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangebogoView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_bogo_view_make(size : Int) -> SortexchangebogoView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_bogo_view_len(s : SortexchangebogoView) -> Int { s.size }

pub fn sort_exchange_bogo_view_get(s : SortexchangebogoView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_bogo_view_set(s : SortexchangebogoView, i : Int, v : Double) -> SortexchangebogoView {
  let result = sort_exchange_bogo_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_bogo_view_sum(s : SortexchangebogoView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_exchange_bogo_view_mean(s : SortexchangebogoView) -> Double {
  if s.size == 0 { 0.0 } else { sort_exchange_bogo_view_sum(s) / s.size.to_double() }
}

pub fn sort_exchange_bogo_view_scale(s : SortexchangebogoView, f : Double) -> SortexchangebogoView {
  let result = sort_exchange_bogo_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_exchange_bogo_view_add(a : SortexchangebogoView, b : SortexchangebogoView) -> SortexchangebogoView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_exchange_bogo_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_exchange_bogo_view_copy(s : SortexchangebogoView) -> SortexchangebogoView {
  let result = sort_exchange_bogo_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_exchange_bogo_view_fill(s : SortexchangebogoView, v : Double) -> SortexchangebogoView {
  let result = sort_exchange_bogo_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_bogo_view_min(s : SortexchangebogoView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_bogo_view_max(s : SortexchangebogoView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_bogo_view_to_string(s : SortexchangebogoView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangebogoRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_bogo_range_make(size : Int) -> SortexchangebogoRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_bogo_range_len(s : SortexchangebogoRange) -> Int { s.size }

pub fn sort_exchange_bogo_range_get(s : SortexchangebogoRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_bogo_range_set(s : SortexchangebogoRange, i : Int, v : Double) -> SortexchangebogoRange {
  let result = sort_exchange_bogo_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_bogo_range_sum(s : SortexchangebogoRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_exchange_bogo_range_mean(s : SortexchangebogoRange) -> Double {
  if s.size == 0 { 0.0 } else { sort_exchange_bogo_range_sum(s) / s.size.to_double() }
}

pub fn sort_exchange_bogo_range_scale(s : SortexchangebogoRange, f : Double) -> SortexchangebogoRange {
  let result = sort_exchange_bogo_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_exchange_bogo_range_add(a : SortexchangebogoRange, b : SortexchangebogoRange) -> SortexchangebogoRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_exchange_bogo_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_exchange_bogo_range_copy(s : SortexchangebogoRange) -> SortexchangebogoRange {
  let result = sort_exchange_bogo_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_exchange_bogo_range_fill(s : SortexchangebogoRange, v : Double) -> SortexchangebogoRange {
  let result = sort_exchange_bogo_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_bogo_range_min(s : SortexchangebogoRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_bogo_range_max(s : SortexchangebogoRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_bogo_range_to_string(s : SortexchangebogoRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangebogoSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_bogo_slice_make(size : Int) -> SortexchangebogoSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_bogo_slice_len(s : SortexchangebogoSlice) -> Int { s.size }

pub fn sort_exchange_bogo_slice_get(s : SortexchangebogoSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_bogo_slice_set(s : SortexchangebogoSlice, i : Int, v : Double) -> SortexchangebogoSlice {
  let result = sort_exchange_bogo_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_bogo_slice_sum(s : SortexchangebogoSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_exchange_bogo_slice_mean(s : SortexchangebogoSlice) -> Double {
  if s.size == 0 { 0.0 } else { sort_exchange_bogo_slice_sum(s) / s.size.to_double() }
}

pub fn sort_exchange_bogo_slice_scale(s : SortexchangebogoSlice, f : Double) -> SortexchangebogoSlice {
  let result = sort_exchange_bogo_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_exchange_bogo_slice_add(a : SortexchangebogoSlice, b : SortexchangebogoSlice) -> SortexchangebogoSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_exchange_bogo_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_exchange_bogo_slice_copy(s : SortexchangebogoSlice) -> SortexchangebogoSlice {
  let result = sort_exchange_bogo_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_exchange_bogo_slice_fill(s : SortexchangebogoSlice, v : Double) -> SortexchangebogoSlice {
  let result = sort_exchange_bogo_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_bogo_slice_min(s : SortexchangebogoSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_bogo_slice_max(s : SortexchangebogoSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_bogo_slice_to_string(s : SortexchangebogoSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

