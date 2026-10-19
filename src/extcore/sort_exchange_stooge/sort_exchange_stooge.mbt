///===
/// extcore/sort_exchange_stooge

pub(all) struct SortexchangestoogePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn sort_exchange_stooge_make_point(x : Double, y : Double) -> SortexchangestoogePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn sort_exchange_stooge_make_point3(x : Double, y : Double, z : Double) -> SortexchangestoogePoint {
  { x, y, z, label: 0 }
}

pub fn sort_exchange_stooge_point_x(pt : SortexchangestoogePoint) -> Double { pt.x }

pub fn sort_exchange_stooge_point_y(pt : SortexchangestoogePoint) -> Double { pt.y }

pub fn sort_exchange_stooge_point_z(pt : SortexchangestoogePoint) -> Double { pt.z }

pub fn sort_exchange_stooge_point_label(pt : SortexchangestoogePoint) -> Int { pt.label }

pub fn sort_exchange_stooge_point_dist(a : SortexchangestoogePoint, b : SortexchangestoogePoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn sort_exchange_stooge_point_add(a : SortexchangestoogePoint, b : SortexchangestoogePoint) -> SortexchangestoogePoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn sort_exchange_stooge_point_sub(a : SortexchangestoogePoint, b : SortexchangestoogePoint) -> SortexchangestoogePoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn sort_exchange_stooge_point_scale(pt : SortexchangestoogePoint, s : Double) -> SortexchangestoogePoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn sort_exchange_stooge_point_dot(a : SortexchangestoogePoint, b : SortexchangestoogePoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn sort_exchange_stooge_point_cross(a : SortexchangestoogePoint, b : SortexchangestoogePoint) -> SortexchangestoogePoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn sort_exchange_stooge_point_norm(pt : SortexchangestoogePoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn sort_exchange_stooge_point_normalize(pt : SortexchangestoogePoint) -> SortexchangestoogePoint {
  let n = sort_exchange_stooge_point_norm(pt)
  if n < 0.0000001 { pt } else { sort_exchange_stooge_point_scale(pt, 1.0 / n) }
}

pub fn sort_exchange_stooge_point_negate(pt : SortexchangestoogePoint) -> SortexchangestoogePoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn sort_exchange_stooge_point_mid(a : SortexchangestoogePoint, b : SortexchangestoogePoint) -> SortexchangestoogePoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn sort_exchange_stooge_point_lerp(a : SortexchangestoogePoint, b : SortexchangestoogePoint, t : Double) -> SortexchangestoogePoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn sort_exchange_stooge_point_to_string(pt : SortexchangestoogePoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct SortexchangestoogeSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn sort_exchange_stooge_make_series(vals : Array[Double], name : String) -> SortexchangestoogeSeries {
  { vals, name, meta: 0 }
}

pub fn sort_exchange_stooge_series_len(s : SortexchangestoogeSeries) -> Int { s.vals.length() }

pub fn sort_exchange_stooge_series_sum(s : SortexchangestoogeSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn sort_exchange_stooge_series_mean(s : SortexchangestoogeSeries) -> Double {
  let n = sort_exchange_stooge_series_len(s)
  if n == 0 { 0.0 } else { sort_exchange_stooge_series_sum(s) / n.to_double() }
}

pub fn sort_exchange_stooge_series_min(s : SortexchangestoogeSeries) -> Double {
  let n = sort_exchange_stooge_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn sort_exchange_stooge_series_max(s : SortexchangestoogeSeries) -> Double {
  let n = sort_exchange_stooge_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn sort_exchange_stooge_series_range(s : SortexchangestoogeSeries) -> Double {
  sort_exchange_stooge_series_max(s) - sort_exchange_stooge_series_min(s)
}

pub fn sort_exchange_stooge_series_var(s : SortexchangestoogeSeries) -> Double {
  let n = sort_exchange_stooge_series_len(s)
  if n == 0 { 0.0 } else {
    let m = sort_exchange_stooge_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn sort_exchange_stooge_series_std(s : SortexchangestoogeSeries) -> Double { @_common.sqrt(sort_exchange_stooge_series_var(s)) }

pub fn sort_exchange_stooge_series_median(s : SortexchangestoogeSeries) -> Double {
  let n = sort_exchange_stooge_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = sort_exchange_stooge_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn sort_exchange_stooge_series_scale(s : SortexchangestoogeSeries, f : Double) -> SortexchangestoogeSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn sort_exchange_stooge_series_add(a : SortexchangestoogeSeries, b : SortexchangestoogeSeries) -> SortexchangestoogeSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn sort_exchange_stooge_series_sub(a : SortexchangestoogeSeries, b : SortexchangestoogeSeries) -> SortexchangestoogeSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn sort_exchange_stooge_series_normalize(s : SortexchangestoogeSeries) -> SortexchangestoogeSeries {
  let mn = sort_exchange_stooge_series_min(s)
  let mx = sort_exchange_stooge_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn sort_exchange_stooge_series_cumsum(s : SortexchangestoogeSeries) -> SortexchangestoogeSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn sort_exchange_stooge_series_to_string(s : SortexchangestoogeSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SortexchangestoogeMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn sort_exchange_stooge_make_matrix(rows : Int, cols : Int, val : Double) -> SortexchangestoogeMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn sort_exchange_stooge_matrix_identity(n : Int) -> SortexchangestoogeMatrix {
  let m = sort_exchange_stooge_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn sort_exchange_stooge_matrix_get(m : SortexchangestoogeMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn sort_exchange_stooge_matrix_transpose(m : SortexchangestoogeMatrix) -> SortexchangestoogeMatrix {
  let result = sort_exchange_stooge_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn sort_exchange_stooge_matrix_add(a : SortexchangestoogeMatrix, b : SortexchangestoogeMatrix) -> SortexchangestoogeMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = sort_exchange_stooge_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn sort_exchange_stooge_matrix_scale(m : SortexchangestoogeMatrix, s : Double) -> SortexchangestoogeMatrix {
  let result = sort_exchange_stooge_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn sort_exchange_stooge_matrix_multiply(a : SortexchangestoogeMatrix, b : SortexchangestoogeMatrix) -> SortexchangestoogeMatrix {
  if a.cols != b.rows { return sort_exchange_stooge_make_matrix(a.rows, b.cols, 0.0) }
  let result = sort_exchange_stooge_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn sort_exchange_stooge_matrix_trace(m : SortexchangestoogeMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn sort_exchange_stooge_matrix_det(m : SortexchangestoogeMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn sort_exchange_stooge_matrix_norm(m : SortexchangestoogeMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn sort_exchange_stooge_matrix_to_string(m : SortexchangestoogeMatrix) -> String {
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

pub(all) struct SortexchangestoogeVector {
  comps : Array[Double]
  dim : Int
}

pub fn sort_exchange_stooge_make_vector(comps : Array[Double]) -> SortexchangestoogeVector {
  { comps, dim: comps.length() }
}

pub fn sort_exchange_stooge_vector_zero(dim : Int) -> SortexchangestoogeVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn sort_exchange_stooge_vector_add(a : SortexchangestoogeVector, b : SortexchangestoogeVector) -> SortexchangestoogeVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn sort_exchange_stooge_vector_sub(a : SortexchangestoogeVector, b : SortexchangestoogeVector) -> SortexchangestoogeVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn sort_exchange_stooge_vector_scale(v : SortexchangestoogeVector, s : Double) -> SortexchangestoogeVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn sort_exchange_stooge_vector_dot(a : SortexchangestoogeVector, b : SortexchangestoogeVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn sort_exchange_stooge_vector_norm(v : SortexchangestoogeVector) -> Double { @_common.sqrt(sort_exchange_stooge_vector_dot(v, v)) }

pub fn sort_exchange_stooge_vector_normalize(v : SortexchangestoogeVector) -> SortexchangestoogeVector {
  let n = sort_exchange_stooge_vector_norm(v)
  if n < 0.0000001 { v } else { sort_exchange_stooge_vector_scale(v, 1.0 / n) }
}

pub fn sort_exchange_stooge_vector_dist(a : SortexchangestoogeVector, b : SortexchangestoogeVector) -> Double {
  sort_exchange_stooge_vector_norm(sort_exchange_stooge_vector_sub(a, b))
}

pub fn sort_exchange_stooge_vector_to_string(v : SortexchangestoogeVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn sort_exchange_stooge_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn sort_exchange_stooge_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = sort_exchange_stooge_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn sort_exchange_stooge_std(data : Array[Double]) -> Double { @_common.sqrt(sort_exchange_stooge_var(data)) }

pub fn sort_exchange_stooge_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = sort_exchange_stooge_mean(a); let mb = sort_exchange_stooge_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn sort_exchange_stooge_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = sort_exchange_stooge_std(a); let sb = sort_exchange_stooge_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { sort_exchange_stooge_cov(a, b) / (sa * sb) }
}

pub fn sort_exchange_stooge_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = sort_exchange_stooge_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn sort_exchange_stooge_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn sort_exchange_stooge_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn sort_exchange_stooge_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  @_common.sqrt(sort_exchange_stooge_mse(pred, labels))
}

pub fn sort_exchange_stooge_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn sort_exchange_stooge_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = sort_exchange_stooge_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn sort_exchange_stooge_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn sort_exchange_stooge_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn sort_exchange_stooge_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = sort_exchange_stooge_precision(pred, labels, pos); let r = sort_exchange_stooge_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn sort_exchange_stooge_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn sort_exchange_stooge_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = sort_exchange_stooge_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn sort_exchange_stooge_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn sort_exchange_stooge_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn sort_exchange_stooge_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = sort_exchange_stooge_gcd(a, b)
    (a / g) * b
  }
}

pub fn sort_exchange_stooge_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn sort_exchange_stooge_fibonacci(n : Int) -> Int {
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

pub fn sort_exchange_stooge_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = sort_exchange_stooge_min(data); let mx = sort_exchange_stooge_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn sort_exchange_stooge_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = sort_exchange_stooge_mean(data); let sd = sort_exchange_stooge_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn sort_exchange_stooge_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn sort_exchange_stooge_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn sort_exchange_stooge_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn sort_exchange_stooge_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn sort_exchange_stooge_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn sort_exchange_stooge_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

pub(all) struct SortexchangestoogeFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_stooge_frame_make(size : Int) -> SortexchangestoogeFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_stooge_frame_len(s : SortexchangestoogeFrame) -> Int { s.size }

pub fn sort_exchange_stooge_frame_get(s : SortexchangestoogeFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_stooge_frame_set(s : SortexchangestoogeFrame, i : Int, v : Double) -> SortexchangestoogeFrame {
  let result = sort_exchange_stooge_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_stooge_frame_sum(s : SortexchangestoogeFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_exchange_stooge_frame_mean(s : SortexchangestoogeFrame) -> Double {
  if s.size == 0 { 0.0 } else { sort_exchange_stooge_frame_sum(s) / s.size.to_double() }
}

pub fn sort_exchange_stooge_frame_scale(s : SortexchangestoogeFrame, f : Double) -> SortexchangestoogeFrame {
  let result = sort_exchange_stooge_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_exchange_stooge_frame_add(a : SortexchangestoogeFrame, b : SortexchangestoogeFrame) -> SortexchangestoogeFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_exchange_stooge_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_exchange_stooge_frame_copy(s : SortexchangestoogeFrame) -> SortexchangestoogeFrame {
  let result = sort_exchange_stooge_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_exchange_stooge_frame_fill(s : SortexchangestoogeFrame, v : Double) -> SortexchangestoogeFrame {
  let result = sort_exchange_stooge_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_stooge_frame_min(s : SortexchangestoogeFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_stooge_frame_max(s : SortexchangestoogeFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_stooge_frame_to_string(s : SortexchangestoogeFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangestoogeTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_stooge_table_make(size : Int) -> SortexchangestoogeTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_stooge_table_len(s : SortexchangestoogeTable) -> Int { s.size }

pub fn sort_exchange_stooge_table_get(s : SortexchangestoogeTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_stooge_table_set(s : SortexchangestoogeTable, i : Int, v : Double) -> SortexchangestoogeTable {
  let result = sort_exchange_stooge_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_stooge_table_sum(s : SortexchangestoogeTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_exchange_stooge_table_mean(s : SortexchangestoogeTable) -> Double {
  if s.size == 0 { 0.0 } else { sort_exchange_stooge_table_sum(s) / s.size.to_double() }
}

pub fn sort_exchange_stooge_table_scale(s : SortexchangestoogeTable, f : Double) -> SortexchangestoogeTable {
  let result = sort_exchange_stooge_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_exchange_stooge_table_add(a : SortexchangestoogeTable, b : SortexchangestoogeTable) -> SortexchangestoogeTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_exchange_stooge_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_exchange_stooge_table_copy(s : SortexchangestoogeTable) -> SortexchangestoogeTable {
  let result = sort_exchange_stooge_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_exchange_stooge_table_fill(s : SortexchangestoogeTable, v : Double) -> SortexchangestoogeTable {
  let result = sort_exchange_stooge_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_stooge_table_min(s : SortexchangestoogeTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_stooge_table_max(s : SortexchangestoogeTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_stooge_table_to_string(s : SortexchangestoogeTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangestoogeGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_stooge_graphn_make(size : Int) -> SortexchangestoogeGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_stooge_graphn_len(s : SortexchangestoogeGraphN) -> Int { s.size }

pub fn sort_exchange_stooge_graphn_get(s : SortexchangestoogeGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_stooge_graphn_set(s : SortexchangestoogeGraphN, i : Int, v : Double) -> SortexchangestoogeGraphN {
  let result = sort_exchange_stooge_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_stooge_graphn_sum(s : SortexchangestoogeGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_exchange_stooge_graphn_mean(s : SortexchangestoogeGraphN) -> Double {
  if s.size == 0 { 0.0 } else { sort_exchange_stooge_graphn_sum(s) / s.size.to_double() }
}

pub fn sort_exchange_stooge_graphn_scale(s : SortexchangestoogeGraphN, f : Double) -> SortexchangestoogeGraphN {
  let result = sort_exchange_stooge_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_exchange_stooge_graphn_add(a : SortexchangestoogeGraphN, b : SortexchangestoogeGraphN) -> SortexchangestoogeGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_exchange_stooge_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_exchange_stooge_graphn_copy(s : SortexchangestoogeGraphN) -> SortexchangestoogeGraphN {
  let result = sort_exchange_stooge_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_exchange_stooge_graphn_fill(s : SortexchangestoogeGraphN, v : Double) -> SortexchangestoogeGraphN {
  let result = sort_exchange_stooge_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_stooge_graphn_min(s : SortexchangestoogeGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_stooge_graphn_max(s : SortexchangestoogeGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_stooge_graphn_to_string(s : SortexchangestoogeGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangestoogeNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_stooge_node_make(size : Int) -> SortexchangestoogeNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_stooge_node_len(s : SortexchangestoogeNode) -> Int { s.size }

pub fn sort_exchange_stooge_node_get(s : SortexchangestoogeNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_stooge_node_set(s : SortexchangestoogeNode, i : Int, v : Double) -> SortexchangestoogeNode {
  let result = sort_exchange_stooge_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_stooge_node_sum(s : SortexchangestoogeNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_exchange_stooge_node_mean(s : SortexchangestoogeNode) -> Double {
  if s.size == 0 { 0.0 } else { sort_exchange_stooge_node_sum(s) / s.size.to_double() }
}

pub fn sort_exchange_stooge_node_scale(s : SortexchangestoogeNode, f : Double) -> SortexchangestoogeNode {
  let result = sort_exchange_stooge_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_exchange_stooge_node_add(a : SortexchangestoogeNode, b : SortexchangestoogeNode) -> SortexchangestoogeNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_exchange_stooge_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_exchange_stooge_node_copy(s : SortexchangestoogeNode) -> SortexchangestoogeNode {
  let result = sort_exchange_stooge_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_exchange_stooge_node_fill(s : SortexchangestoogeNode, v : Double) -> SortexchangestoogeNode {
  let result = sort_exchange_stooge_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_stooge_node_min(s : SortexchangestoogeNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_stooge_node_max(s : SortexchangestoogeNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_stooge_node_to_string(s : SortexchangestoogeNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangestoogeEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_stooge_edge_make(size : Int) -> SortexchangestoogeEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_stooge_edge_len(s : SortexchangestoogeEdge) -> Int { s.size }

pub fn sort_exchange_stooge_edge_get(s : SortexchangestoogeEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_stooge_edge_set(s : SortexchangestoogeEdge, i : Int, v : Double) -> SortexchangestoogeEdge {
  let result = sort_exchange_stooge_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_stooge_edge_sum(s : SortexchangestoogeEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_exchange_stooge_edge_mean(s : SortexchangestoogeEdge) -> Double {
  if s.size == 0 { 0.0 } else { sort_exchange_stooge_edge_sum(s) / s.size.to_double() }
}

pub fn sort_exchange_stooge_edge_scale(s : SortexchangestoogeEdge, f : Double) -> SortexchangestoogeEdge {
  let result = sort_exchange_stooge_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_exchange_stooge_edge_add(a : SortexchangestoogeEdge, b : SortexchangestoogeEdge) -> SortexchangestoogeEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_exchange_stooge_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_exchange_stooge_edge_copy(s : SortexchangestoogeEdge) -> SortexchangestoogeEdge {
  let result = sort_exchange_stooge_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_exchange_stooge_edge_fill(s : SortexchangestoogeEdge, v : Double) -> SortexchangestoogeEdge {
  let result = sort_exchange_stooge_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_stooge_edge_min(s : SortexchangestoogeEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_stooge_edge_max(s : SortexchangestoogeEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_stooge_edge_to_string(s : SortexchangestoogeEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangestoogePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_stooge_path_make(size : Int) -> SortexchangestoogePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_stooge_path_len(s : SortexchangestoogePath) -> Int { s.size }

pub fn sort_exchange_stooge_path_get(s : SortexchangestoogePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_stooge_path_set(s : SortexchangestoogePath, i : Int, v : Double) -> SortexchangestoogePath {
  let result = sort_exchange_stooge_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_stooge_path_sum(s : SortexchangestoogePath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_exchange_stooge_path_mean(s : SortexchangestoogePath) -> Double {
  if s.size == 0 { 0.0 } else { sort_exchange_stooge_path_sum(s) / s.size.to_double() }
}

pub fn sort_exchange_stooge_path_scale(s : SortexchangestoogePath, f : Double) -> SortexchangestoogePath {
  let result = sort_exchange_stooge_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_exchange_stooge_path_add(a : SortexchangestoogePath, b : SortexchangestoogePath) -> SortexchangestoogePath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_exchange_stooge_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_exchange_stooge_path_copy(s : SortexchangestoogePath) -> SortexchangestoogePath {
  let result = sort_exchange_stooge_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_exchange_stooge_path_fill(s : SortexchangestoogePath, v : Double) -> SortexchangestoogePath {
  let result = sort_exchange_stooge_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_stooge_path_min(s : SortexchangestoogePath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_stooge_path_max(s : SortexchangestoogePath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_stooge_path_to_string(s : SortexchangestoogePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangestoogeCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_stooge_cluster_make(size : Int) -> SortexchangestoogeCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_stooge_cluster_len(s : SortexchangestoogeCluster) -> Int { s.size }

pub fn sort_exchange_stooge_cluster_get(s : SortexchangestoogeCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_stooge_cluster_set(s : SortexchangestoogeCluster, i : Int, v : Double) -> SortexchangestoogeCluster {
  let result = sort_exchange_stooge_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_stooge_cluster_sum(s : SortexchangestoogeCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_exchange_stooge_cluster_mean(s : SortexchangestoogeCluster) -> Double {
  if s.size == 0 { 0.0 } else { sort_exchange_stooge_cluster_sum(s) / s.size.to_double() }
}

pub fn sort_exchange_stooge_cluster_scale(s : SortexchangestoogeCluster, f : Double) -> SortexchangestoogeCluster {
  let result = sort_exchange_stooge_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_exchange_stooge_cluster_add(a : SortexchangestoogeCluster, b : SortexchangestoogeCluster) -> SortexchangestoogeCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_exchange_stooge_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_exchange_stooge_cluster_copy(s : SortexchangestoogeCluster) -> SortexchangestoogeCluster {
  let result = sort_exchange_stooge_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_exchange_stooge_cluster_fill(s : SortexchangestoogeCluster, v : Double) -> SortexchangestoogeCluster {
  let result = sort_exchange_stooge_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_stooge_cluster_min(s : SortexchangestoogeCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_stooge_cluster_max(s : SortexchangestoogeCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_stooge_cluster_to_string(s : SortexchangestoogeCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangestoogeModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_stooge_model_make(size : Int) -> SortexchangestoogeModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_stooge_model_len(s : SortexchangestoogeModel) -> Int { s.size }

pub fn sort_exchange_stooge_model_get(s : SortexchangestoogeModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_stooge_model_set(s : SortexchangestoogeModel, i : Int, v : Double) -> SortexchangestoogeModel {
  let result = sort_exchange_stooge_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_stooge_model_sum(s : SortexchangestoogeModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_exchange_stooge_model_mean(s : SortexchangestoogeModel) -> Double {
  if s.size == 0 { 0.0 } else { sort_exchange_stooge_model_sum(s) / s.size.to_double() }
}

pub fn sort_exchange_stooge_model_scale(s : SortexchangestoogeModel, f : Double) -> SortexchangestoogeModel {
  let result = sort_exchange_stooge_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_exchange_stooge_model_add(a : SortexchangestoogeModel, b : SortexchangestoogeModel) -> SortexchangestoogeModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_exchange_stooge_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_exchange_stooge_model_copy(s : SortexchangestoogeModel) -> SortexchangestoogeModel {
  let result = sort_exchange_stooge_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_exchange_stooge_model_fill(s : SortexchangestoogeModel, v : Double) -> SortexchangestoogeModel {
  let result = sort_exchange_stooge_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_stooge_model_min(s : SortexchangestoogeModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_stooge_model_max(s : SortexchangestoogeModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_stooge_model_to_string(s : SortexchangestoogeModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangestoogeLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_stooge_layer_make(size : Int) -> SortexchangestoogeLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_stooge_layer_len(s : SortexchangestoogeLayer) -> Int { s.size }

pub fn sort_exchange_stooge_layer_get(s : SortexchangestoogeLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_stooge_layer_set(s : SortexchangestoogeLayer, i : Int, v : Double) -> SortexchangestoogeLayer {
  let result = sort_exchange_stooge_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_stooge_layer_sum(s : SortexchangestoogeLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_exchange_stooge_layer_mean(s : SortexchangestoogeLayer) -> Double {
  if s.size == 0 { 0.0 } else { sort_exchange_stooge_layer_sum(s) / s.size.to_double() }
}

pub fn sort_exchange_stooge_layer_scale(s : SortexchangestoogeLayer, f : Double) -> SortexchangestoogeLayer {
  let result = sort_exchange_stooge_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_exchange_stooge_layer_add(a : SortexchangestoogeLayer, b : SortexchangestoogeLayer) -> SortexchangestoogeLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_exchange_stooge_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_exchange_stooge_layer_copy(s : SortexchangestoogeLayer) -> SortexchangestoogeLayer {
  let result = sort_exchange_stooge_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_exchange_stooge_layer_fill(s : SortexchangestoogeLayer, v : Double) -> SortexchangestoogeLayer {
  let result = sort_exchange_stooge_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_stooge_layer_min(s : SortexchangestoogeLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_stooge_layer_max(s : SortexchangestoogeLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_stooge_layer_to_string(s : SortexchangestoogeLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangestoogeBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_stooge_buffer_make(size : Int) -> SortexchangestoogeBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_stooge_buffer_len(s : SortexchangestoogeBuffer) -> Int { s.size }

pub fn sort_exchange_stooge_buffer_get(s : SortexchangestoogeBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_stooge_buffer_set(s : SortexchangestoogeBuffer, i : Int, v : Double) -> SortexchangestoogeBuffer {
  let result = sort_exchange_stooge_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_stooge_buffer_sum(s : SortexchangestoogeBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_exchange_stooge_buffer_mean(s : SortexchangestoogeBuffer) -> Double {
  if s.size == 0 { 0.0 } else { sort_exchange_stooge_buffer_sum(s) / s.size.to_double() }
}

pub fn sort_exchange_stooge_buffer_scale(s : SortexchangestoogeBuffer, f : Double) -> SortexchangestoogeBuffer {
  let result = sort_exchange_stooge_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_exchange_stooge_buffer_add(a : SortexchangestoogeBuffer, b : SortexchangestoogeBuffer) -> SortexchangestoogeBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_exchange_stooge_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_exchange_stooge_buffer_copy(s : SortexchangestoogeBuffer) -> SortexchangestoogeBuffer {
  let result = sort_exchange_stooge_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_exchange_stooge_buffer_fill(s : SortexchangestoogeBuffer, v : Double) -> SortexchangestoogeBuffer {
  let result = sort_exchange_stooge_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_stooge_buffer_min(s : SortexchangestoogeBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_stooge_buffer_max(s : SortexchangestoogeBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_stooge_buffer_to_string(s : SortexchangestoogeBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangestoogeCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_stooge_cursor_make(size : Int) -> SortexchangestoogeCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_stooge_cursor_len(s : SortexchangestoogeCursor) -> Int { s.size }

pub fn sort_exchange_stooge_cursor_get(s : SortexchangestoogeCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_stooge_cursor_set(s : SortexchangestoogeCursor, i : Int, v : Double) -> SortexchangestoogeCursor {
  let result = sort_exchange_stooge_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_stooge_cursor_sum(s : SortexchangestoogeCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_exchange_stooge_cursor_mean(s : SortexchangestoogeCursor) -> Double {
  if s.size == 0 { 0.0 } else { sort_exchange_stooge_cursor_sum(s) / s.size.to_double() }
}

pub fn sort_exchange_stooge_cursor_scale(s : SortexchangestoogeCursor, f : Double) -> SortexchangestoogeCursor {
  let result = sort_exchange_stooge_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_exchange_stooge_cursor_add(a : SortexchangestoogeCursor, b : SortexchangestoogeCursor) -> SortexchangestoogeCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_exchange_stooge_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_exchange_stooge_cursor_copy(s : SortexchangestoogeCursor) -> SortexchangestoogeCursor {
  let result = sort_exchange_stooge_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_exchange_stooge_cursor_fill(s : SortexchangestoogeCursor, v : Double) -> SortexchangestoogeCursor {
  let result = sort_exchange_stooge_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_stooge_cursor_min(s : SortexchangestoogeCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_stooge_cursor_max(s : SortexchangestoogeCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_stooge_cursor_to_string(s : SortexchangestoogeCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangestoogeView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_stooge_view_make(size : Int) -> SortexchangestoogeView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_stooge_view_len(s : SortexchangestoogeView) -> Int { s.size }

pub fn sort_exchange_stooge_view_get(s : SortexchangestoogeView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_stooge_view_set(s : SortexchangestoogeView, i : Int, v : Double) -> SortexchangestoogeView {
  let result = sort_exchange_stooge_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_stooge_view_sum(s : SortexchangestoogeView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_exchange_stooge_view_mean(s : SortexchangestoogeView) -> Double {
  if s.size == 0 { 0.0 } else { sort_exchange_stooge_view_sum(s) / s.size.to_double() }
}

pub fn sort_exchange_stooge_view_scale(s : SortexchangestoogeView, f : Double) -> SortexchangestoogeView {
  let result = sort_exchange_stooge_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_exchange_stooge_view_add(a : SortexchangestoogeView, b : SortexchangestoogeView) -> SortexchangestoogeView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_exchange_stooge_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_exchange_stooge_view_copy(s : SortexchangestoogeView) -> SortexchangestoogeView {
  let result = sort_exchange_stooge_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_exchange_stooge_view_fill(s : SortexchangestoogeView, v : Double) -> SortexchangestoogeView {
  let result = sort_exchange_stooge_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_stooge_view_min(s : SortexchangestoogeView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_stooge_view_max(s : SortexchangestoogeView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_stooge_view_to_string(s : SortexchangestoogeView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangestoogeRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_stooge_range_make(size : Int) -> SortexchangestoogeRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_stooge_range_len(s : SortexchangestoogeRange) -> Int { s.size }

pub fn sort_exchange_stooge_range_get(s : SortexchangestoogeRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_stooge_range_set(s : SortexchangestoogeRange, i : Int, v : Double) -> SortexchangestoogeRange {
  let result = sort_exchange_stooge_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_stooge_range_sum(s : SortexchangestoogeRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_exchange_stooge_range_mean(s : SortexchangestoogeRange) -> Double {
  if s.size == 0 { 0.0 } else { sort_exchange_stooge_range_sum(s) / s.size.to_double() }
}

pub fn sort_exchange_stooge_range_scale(s : SortexchangestoogeRange, f : Double) -> SortexchangestoogeRange {
  let result = sort_exchange_stooge_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_exchange_stooge_range_add(a : SortexchangestoogeRange, b : SortexchangestoogeRange) -> SortexchangestoogeRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_exchange_stooge_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_exchange_stooge_range_copy(s : SortexchangestoogeRange) -> SortexchangestoogeRange {
  let result = sort_exchange_stooge_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_exchange_stooge_range_fill(s : SortexchangestoogeRange, v : Double) -> SortexchangestoogeRange {
  let result = sort_exchange_stooge_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_stooge_range_min(s : SortexchangestoogeRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_stooge_range_max(s : SortexchangestoogeRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_stooge_range_to_string(s : SortexchangestoogeRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangestoogeSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_stooge_slice_make(size : Int) -> SortexchangestoogeSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_stooge_slice_len(s : SortexchangestoogeSlice) -> Int { s.size }

pub fn sort_exchange_stooge_slice_get(s : SortexchangestoogeSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_stooge_slice_set(s : SortexchangestoogeSlice, i : Int, v : Double) -> SortexchangestoogeSlice {
  let result = sort_exchange_stooge_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_stooge_slice_sum(s : SortexchangestoogeSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_exchange_stooge_slice_mean(s : SortexchangestoogeSlice) -> Double {
  if s.size == 0 { 0.0 } else { sort_exchange_stooge_slice_sum(s) / s.size.to_double() }
}

pub fn sort_exchange_stooge_slice_scale(s : SortexchangestoogeSlice, f : Double) -> SortexchangestoogeSlice {
  let result = sort_exchange_stooge_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_exchange_stooge_slice_add(a : SortexchangestoogeSlice, b : SortexchangestoogeSlice) -> SortexchangestoogeSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_exchange_stooge_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_exchange_stooge_slice_copy(s : SortexchangestoogeSlice) -> SortexchangestoogeSlice {
  let result = sort_exchange_stooge_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_exchange_stooge_slice_fill(s : SortexchangestoogeSlice, v : Double) -> SortexchangestoogeSlice {
  let result = sort_exchange_stooge_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_stooge_slice_min(s : SortexchangestoogeSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_stooge_slice_max(s : SortexchangestoogeSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_stooge_slice_to_string(s : SortexchangestoogeSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

