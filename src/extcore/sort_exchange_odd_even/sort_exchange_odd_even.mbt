///===
/// extcore/sort_exchange_odd_even

pub(all) struct SortexchangeoddevenPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn sort_exchange_odd_even_make_point(x : Double, y : Double) -> SortexchangeoddevenPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn sort_exchange_odd_even_make_point3(x : Double, y : Double, z : Double) -> SortexchangeoddevenPoint {
  { x, y, z, label: 0 }
}

pub fn sort_exchange_odd_even_point_x(pt : SortexchangeoddevenPoint) -> Double { pt.x }

pub fn sort_exchange_odd_even_point_y(pt : SortexchangeoddevenPoint) -> Double { pt.y }

pub fn sort_exchange_odd_even_point_z(pt : SortexchangeoddevenPoint) -> Double { pt.z }

pub fn sort_exchange_odd_even_point_label(pt : SortexchangeoddevenPoint) -> Int { pt.label }

pub fn sort_exchange_odd_even_point_dist(a : SortexchangeoddevenPoint, b : SortexchangeoddevenPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn sort_exchange_odd_even_point_add(a : SortexchangeoddevenPoint, b : SortexchangeoddevenPoint) -> SortexchangeoddevenPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn sort_exchange_odd_even_point_sub(a : SortexchangeoddevenPoint, b : SortexchangeoddevenPoint) -> SortexchangeoddevenPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn sort_exchange_odd_even_point_scale(pt : SortexchangeoddevenPoint, s : Double) -> SortexchangeoddevenPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn sort_exchange_odd_even_point_dot(a : SortexchangeoddevenPoint, b : SortexchangeoddevenPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn sort_exchange_odd_even_point_cross(a : SortexchangeoddevenPoint, b : SortexchangeoddevenPoint) -> SortexchangeoddevenPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn sort_exchange_odd_even_point_norm(pt : SortexchangeoddevenPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn sort_exchange_odd_even_point_normalize(pt : SortexchangeoddevenPoint) -> SortexchangeoddevenPoint {
  let n = sort_exchange_odd_even_point_norm(pt)
  if n < 0.0000001 { pt } else { sort_exchange_odd_even_point_scale(pt, 1.0 / n) }
}

pub fn sort_exchange_odd_even_point_negate(pt : SortexchangeoddevenPoint) -> SortexchangeoddevenPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn sort_exchange_odd_even_point_mid(a : SortexchangeoddevenPoint, b : SortexchangeoddevenPoint) -> SortexchangeoddevenPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn sort_exchange_odd_even_point_lerp(a : SortexchangeoddevenPoint, b : SortexchangeoddevenPoint, t : Double) -> SortexchangeoddevenPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn sort_exchange_odd_even_point_to_string(pt : SortexchangeoddevenPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct SortexchangeoddevenSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn sort_exchange_odd_even_make_series(vals : Array[Double], name : String) -> SortexchangeoddevenSeries {
  { vals, name, meta: 0 }
}

pub fn sort_exchange_odd_even_series_len(s : SortexchangeoddevenSeries) -> Int { s.vals.length() }

pub fn sort_exchange_odd_even_series_sum(s : SortexchangeoddevenSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn sort_exchange_odd_even_series_mean(s : SortexchangeoddevenSeries) -> Double {
  let n = sort_exchange_odd_even_series_len(s)
  if n == 0 { 0.0 } else { sort_exchange_odd_even_series_sum(s) / n.to_double() }
}

pub fn sort_exchange_odd_even_series_min(s : SortexchangeoddevenSeries) -> Double {
  let n = sort_exchange_odd_even_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn sort_exchange_odd_even_series_max(s : SortexchangeoddevenSeries) -> Double {
  let n = sort_exchange_odd_even_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn sort_exchange_odd_even_series_range(s : SortexchangeoddevenSeries) -> Double {
  sort_exchange_odd_even_series_max(s) - sort_exchange_odd_even_series_min(s)
}

pub fn sort_exchange_odd_even_series_var(s : SortexchangeoddevenSeries) -> Double {
  let n = sort_exchange_odd_even_series_len(s)
  if n == 0 { 0.0 } else {
    let m = sort_exchange_odd_even_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn sort_exchange_odd_even_series_std(s : SortexchangeoddevenSeries) -> Double { @_common.sqrt(sort_exchange_odd_even_series_var(s)) }

pub fn sort_exchange_odd_even_series_median(s : SortexchangeoddevenSeries) -> Double {
  let n = sort_exchange_odd_even_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = sort_exchange_odd_even_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn sort_exchange_odd_even_series_scale(s : SortexchangeoddevenSeries, f : Double) -> SortexchangeoddevenSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn sort_exchange_odd_even_series_add(a : SortexchangeoddevenSeries, b : SortexchangeoddevenSeries) -> SortexchangeoddevenSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn sort_exchange_odd_even_series_sub(a : SortexchangeoddevenSeries, b : SortexchangeoddevenSeries) -> SortexchangeoddevenSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn sort_exchange_odd_even_series_normalize(s : SortexchangeoddevenSeries) -> SortexchangeoddevenSeries {
  let mn = sort_exchange_odd_even_series_min(s)
  let mx = sort_exchange_odd_even_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn sort_exchange_odd_even_series_cumsum(s : SortexchangeoddevenSeries) -> SortexchangeoddevenSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn sort_exchange_odd_even_series_to_string(s : SortexchangeoddevenSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SortexchangeoddevenMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn sort_exchange_odd_even_make_matrix(rows : Int, cols : Int, val : Double) -> SortexchangeoddevenMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn sort_exchange_odd_even_matrix_identity(n : Int) -> SortexchangeoddevenMatrix {
  let m = sort_exchange_odd_even_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn sort_exchange_odd_even_matrix_get(m : SortexchangeoddevenMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn sort_exchange_odd_even_matrix_transpose(m : SortexchangeoddevenMatrix) -> SortexchangeoddevenMatrix {
  let result = sort_exchange_odd_even_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn sort_exchange_odd_even_matrix_add(a : SortexchangeoddevenMatrix, b : SortexchangeoddevenMatrix) -> SortexchangeoddevenMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = sort_exchange_odd_even_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn sort_exchange_odd_even_matrix_scale(m : SortexchangeoddevenMatrix, s : Double) -> SortexchangeoddevenMatrix {
  let result = sort_exchange_odd_even_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn sort_exchange_odd_even_matrix_multiply(a : SortexchangeoddevenMatrix, b : SortexchangeoddevenMatrix) -> SortexchangeoddevenMatrix {
  if a.cols != b.rows { return sort_exchange_odd_even_make_matrix(a.rows, b.cols, 0.0) }
  let result = sort_exchange_odd_even_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn sort_exchange_odd_even_matrix_trace(m : SortexchangeoddevenMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn sort_exchange_odd_even_matrix_det(m : SortexchangeoddevenMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn sort_exchange_odd_even_matrix_norm(m : SortexchangeoddevenMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn sort_exchange_odd_even_matrix_to_string(m : SortexchangeoddevenMatrix) -> String {
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

pub(all) struct SortexchangeoddevenVector {
  comps : Array[Double]
  dim : Int
}

pub fn sort_exchange_odd_even_make_vector(comps : Array[Double]) -> SortexchangeoddevenVector {
  { comps, dim: comps.length() }
}

pub fn sort_exchange_odd_even_vector_zero(dim : Int) -> SortexchangeoddevenVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn sort_exchange_odd_even_vector_add(a : SortexchangeoddevenVector, b : SortexchangeoddevenVector) -> SortexchangeoddevenVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn sort_exchange_odd_even_vector_sub(a : SortexchangeoddevenVector, b : SortexchangeoddevenVector) -> SortexchangeoddevenVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn sort_exchange_odd_even_vector_scale(v : SortexchangeoddevenVector, s : Double) -> SortexchangeoddevenVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn sort_exchange_odd_even_vector_dot(a : SortexchangeoddevenVector, b : SortexchangeoddevenVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn sort_exchange_odd_even_vector_norm(v : SortexchangeoddevenVector) -> Double { @_common.sqrt(sort_exchange_odd_even_vector_dot(v, v)) }

pub fn sort_exchange_odd_even_vector_normalize(v : SortexchangeoddevenVector) -> SortexchangeoddevenVector {
  let n = sort_exchange_odd_even_vector_norm(v)
  if n < 0.0000001 { v } else { sort_exchange_odd_even_vector_scale(v, 1.0 / n) }
}

pub fn sort_exchange_odd_even_vector_dist(a : SortexchangeoddevenVector, b : SortexchangeoddevenVector) -> Double {
  sort_exchange_odd_even_vector_norm(sort_exchange_odd_even_vector_sub(a, b))
}

pub fn sort_exchange_odd_even_vector_to_string(v : SortexchangeoddevenVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn sort_exchange_odd_even_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn sort_exchange_odd_even_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = sort_exchange_odd_even_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn sort_exchange_odd_even_std(data : Array[Double]) -> Double { @_common.sqrt(sort_exchange_odd_even_var(data)) }

pub fn sort_exchange_odd_even_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = sort_exchange_odd_even_mean(a); let mb = sort_exchange_odd_even_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn sort_exchange_odd_even_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = sort_exchange_odd_even_std(a); let sb = sort_exchange_odd_even_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { sort_exchange_odd_even_cov(a, b) / (sa * sb) }
}

pub fn sort_exchange_odd_even_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = sort_exchange_odd_even_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn sort_exchange_odd_even_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn sort_exchange_odd_even_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn sort_exchange_odd_even_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  @_common.sqrt(sort_exchange_odd_even_mse(pred, labels))
}

pub fn sort_exchange_odd_even_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn sort_exchange_odd_even_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = sort_exchange_odd_even_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn sort_exchange_odd_even_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn sort_exchange_odd_even_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn sort_exchange_odd_even_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = sort_exchange_odd_even_precision(pred, labels, pos); let r = sort_exchange_odd_even_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn sort_exchange_odd_even_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn sort_exchange_odd_even_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = sort_exchange_odd_even_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn sort_exchange_odd_even_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn sort_exchange_odd_even_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn sort_exchange_odd_even_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = sort_exchange_odd_even_gcd(a, b)
    (a / g) * b
  }
}

pub fn sort_exchange_odd_even_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn sort_exchange_odd_even_fibonacci(n : Int) -> Int {
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

pub fn sort_exchange_odd_even_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = sort_exchange_odd_even_min(data); let mx = sort_exchange_odd_even_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn sort_exchange_odd_even_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = sort_exchange_odd_even_mean(data); let sd = sort_exchange_odd_even_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn sort_exchange_odd_even_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn sort_exchange_odd_even_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn sort_exchange_odd_even_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn sort_exchange_odd_even_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn sort_exchange_odd_even_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn sort_exchange_odd_even_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

pub(all) struct SortexchangeoddevenFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_odd_even_frame_make(size : Int) -> SortexchangeoddevenFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_odd_even_frame_len(s : SortexchangeoddevenFrame) -> Int { s.size }

pub fn sort_exchange_odd_even_frame_get(s : SortexchangeoddevenFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_odd_even_frame_set(s : SortexchangeoddevenFrame, i : Int, v : Double) -> SortexchangeoddevenFrame {
  let result = sort_exchange_odd_even_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_odd_even_frame_sum(s : SortexchangeoddevenFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_exchange_odd_even_frame_mean(s : SortexchangeoddevenFrame) -> Double {
  if s.size == 0 { 0.0 } else { sort_exchange_odd_even_frame_sum(s) / s.size.to_double() }
}

pub fn sort_exchange_odd_even_frame_scale(s : SortexchangeoddevenFrame, f : Double) -> SortexchangeoddevenFrame {
  let result = sort_exchange_odd_even_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_exchange_odd_even_frame_add(a : SortexchangeoddevenFrame, b : SortexchangeoddevenFrame) -> SortexchangeoddevenFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_exchange_odd_even_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_exchange_odd_even_frame_copy(s : SortexchangeoddevenFrame) -> SortexchangeoddevenFrame {
  let result = sort_exchange_odd_even_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_exchange_odd_even_frame_fill(s : SortexchangeoddevenFrame, v : Double) -> SortexchangeoddevenFrame {
  let result = sort_exchange_odd_even_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_odd_even_frame_min(s : SortexchangeoddevenFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_odd_even_frame_max(s : SortexchangeoddevenFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_odd_even_frame_to_string(s : SortexchangeoddevenFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangeoddevenTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_odd_even_table_make(size : Int) -> SortexchangeoddevenTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_odd_even_table_len(s : SortexchangeoddevenTable) -> Int { s.size }

pub fn sort_exchange_odd_even_table_get(s : SortexchangeoddevenTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_odd_even_table_set(s : SortexchangeoddevenTable, i : Int, v : Double) -> SortexchangeoddevenTable {
  let result = sort_exchange_odd_even_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_odd_even_table_sum(s : SortexchangeoddevenTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_exchange_odd_even_table_mean(s : SortexchangeoddevenTable) -> Double {
  if s.size == 0 { 0.0 } else { sort_exchange_odd_even_table_sum(s) / s.size.to_double() }
}

pub fn sort_exchange_odd_even_table_scale(s : SortexchangeoddevenTable, f : Double) -> SortexchangeoddevenTable {
  let result = sort_exchange_odd_even_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_exchange_odd_even_table_add(a : SortexchangeoddevenTable, b : SortexchangeoddevenTable) -> SortexchangeoddevenTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_exchange_odd_even_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_exchange_odd_even_table_copy(s : SortexchangeoddevenTable) -> SortexchangeoddevenTable {
  let result = sort_exchange_odd_even_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_exchange_odd_even_table_fill(s : SortexchangeoddevenTable, v : Double) -> SortexchangeoddevenTable {
  let result = sort_exchange_odd_even_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_odd_even_table_min(s : SortexchangeoddevenTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_odd_even_table_max(s : SortexchangeoddevenTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_odd_even_table_to_string(s : SortexchangeoddevenTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangeoddevenGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_odd_even_graphn_make(size : Int) -> SortexchangeoddevenGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_odd_even_graphn_len(s : SortexchangeoddevenGraphN) -> Int { s.size }

pub fn sort_exchange_odd_even_graphn_get(s : SortexchangeoddevenGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_odd_even_graphn_set(s : SortexchangeoddevenGraphN, i : Int, v : Double) -> SortexchangeoddevenGraphN {
  let result = sort_exchange_odd_even_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_odd_even_graphn_sum(s : SortexchangeoddevenGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_exchange_odd_even_graphn_mean(s : SortexchangeoddevenGraphN) -> Double {
  if s.size == 0 { 0.0 } else { sort_exchange_odd_even_graphn_sum(s) / s.size.to_double() }
}

pub fn sort_exchange_odd_even_graphn_scale(s : SortexchangeoddevenGraphN, f : Double) -> SortexchangeoddevenGraphN {
  let result = sort_exchange_odd_even_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_exchange_odd_even_graphn_add(a : SortexchangeoddevenGraphN, b : SortexchangeoddevenGraphN) -> SortexchangeoddevenGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_exchange_odd_even_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_exchange_odd_even_graphn_copy(s : SortexchangeoddevenGraphN) -> SortexchangeoddevenGraphN {
  let result = sort_exchange_odd_even_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_exchange_odd_even_graphn_fill(s : SortexchangeoddevenGraphN, v : Double) -> SortexchangeoddevenGraphN {
  let result = sort_exchange_odd_even_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_odd_even_graphn_min(s : SortexchangeoddevenGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_odd_even_graphn_max(s : SortexchangeoddevenGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_odd_even_graphn_to_string(s : SortexchangeoddevenGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangeoddevenNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_odd_even_node_make(size : Int) -> SortexchangeoddevenNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_odd_even_node_len(s : SortexchangeoddevenNode) -> Int { s.size }

pub fn sort_exchange_odd_even_node_get(s : SortexchangeoddevenNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_odd_even_node_set(s : SortexchangeoddevenNode, i : Int, v : Double) -> SortexchangeoddevenNode {
  let result = sort_exchange_odd_even_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_odd_even_node_sum(s : SortexchangeoddevenNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_exchange_odd_even_node_mean(s : SortexchangeoddevenNode) -> Double {
  if s.size == 0 { 0.0 } else { sort_exchange_odd_even_node_sum(s) / s.size.to_double() }
}

pub fn sort_exchange_odd_even_node_scale(s : SortexchangeoddevenNode, f : Double) -> SortexchangeoddevenNode {
  let result = sort_exchange_odd_even_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_exchange_odd_even_node_add(a : SortexchangeoddevenNode, b : SortexchangeoddevenNode) -> SortexchangeoddevenNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_exchange_odd_even_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_exchange_odd_even_node_copy(s : SortexchangeoddevenNode) -> SortexchangeoddevenNode {
  let result = sort_exchange_odd_even_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_exchange_odd_even_node_fill(s : SortexchangeoddevenNode, v : Double) -> SortexchangeoddevenNode {
  let result = sort_exchange_odd_even_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_odd_even_node_min(s : SortexchangeoddevenNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_odd_even_node_max(s : SortexchangeoddevenNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_odd_even_node_to_string(s : SortexchangeoddevenNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangeoddevenEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_odd_even_edge_make(size : Int) -> SortexchangeoddevenEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_odd_even_edge_len(s : SortexchangeoddevenEdge) -> Int { s.size }

pub fn sort_exchange_odd_even_edge_get(s : SortexchangeoddevenEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_odd_even_edge_set(s : SortexchangeoddevenEdge, i : Int, v : Double) -> SortexchangeoddevenEdge {
  let result = sort_exchange_odd_even_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_odd_even_edge_sum(s : SortexchangeoddevenEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_exchange_odd_even_edge_mean(s : SortexchangeoddevenEdge) -> Double {
  if s.size == 0 { 0.0 } else { sort_exchange_odd_even_edge_sum(s) / s.size.to_double() }
}

pub fn sort_exchange_odd_even_edge_scale(s : SortexchangeoddevenEdge, f : Double) -> SortexchangeoddevenEdge {
  let result = sort_exchange_odd_even_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_exchange_odd_even_edge_add(a : SortexchangeoddevenEdge, b : SortexchangeoddevenEdge) -> SortexchangeoddevenEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_exchange_odd_even_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_exchange_odd_even_edge_copy(s : SortexchangeoddevenEdge) -> SortexchangeoddevenEdge {
  let result = sort_exchange_odd_even_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_exchange_odd_even_edge_fill(s : SortexchangeoddevenEdge, v : Double) -> SortexchangeoddevenEdge {
  let result = sort_exchange_odd_even_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_odd_even_edge_min(s : SortexchangeoddevenEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_odd_even_edge_max(s : SortexchangeoddevenEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_odd_even_edge_to_string(s : SortexchangeoddevenEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangeoddevenPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_odd_even_path_make(size : Int) -> SortexchangeoddevenPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_odd_even_path_len(s : SortexchangeoddevenPath) -> Int { s.size }

pub fn sort_exchange_odd_even_path_get(s : SortexchangeoddevenPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_odd_even_path_set(s : SortexchangeoddevenPath, i : Int, v : Double) -> SortexchangeoddevenPath {
  let result = sort_exchange_odd_even_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_odd_even_path_sum(s : SortexchangeoddevenPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_exchange_odd_even_path_mean(s : SortexchangeoddevenPath) -> Double {
  if s.size == 0 { 0.0 } else { sort_exchange_odd_even_path_sum(s) / s.size.to_double() }
}

pub fn sort_exchange_odd_even_path_scale(s : SortexchangeoddevenPath, f : Double) -> SortexchangeoddevenPath {
  let result = sort_exchange_odd_even_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_exchange_odd_even_path_add(a : SortexchangeoddevenPath, b : SortexchangeoddevenPath) -> SortexchangeoddevenPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_exchange_odd_even_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_exchange_odd_even_path_copy(s : SortexchangeoddevenPath) -> SortexchangeoddevenPath {
  let result = sort_exchange_odd_even_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_exchange_odd_even_path_fill(s : SortexchangeoddevenPath, v : Double) -> SortexchangeoddevenPath {
  let result = sort_exchange_odd_even_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_odd_even_path_min(s : SortexchangeoddevenPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_odd_even_path_max(s : SortexchangeoddevenPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_odd_even_path_to_string(s : SortexchangeoddevenPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangeoddevenCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_odd_even_cluster_make(size : Int) -> SortexchangeoddevenCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_odd_even_cluster_len(s : SortexchangeoddevenCluster) -> Int { s.size }

pub fn sort_exchange_odd_even_cluster_get(s : SortexchangeoddevenCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_odd_even_cluster_set(s : SortexchangeoddevenCluster, i : Int, v : Double) -> SortexchangeoddevenCluster {
  let result = sort_exchange_odd_even_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_odd_even_cluster_sum(s : SortexchangeoddevenCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_exchange_odd_even_cluster_mean(s : SortexchangeoddevenCluster) -> Double {
  if s.size == 0 { 0.0 } else { sort_exchange_odd_even_cluster_sum(s) / s.size.to_double() }
}

pub fn sort_exchange_odd_even_cluster_scale(s : SortexchangeoddevenCluster, f : Double) -> SortexchangeoddevenCluster {
  let result = sort_exchange_odd_even_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_exchange_odd_even_cluster_add(a : SortexchangeoddevenCluster, b : SortexchangeoddevenCluster) -> SortexchangeoddevenCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_exchange_odd_even_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_exchange_odd_even_cluster_copy(s : SortexchangeoddevenCluster) -> SortexchangeoddevenCluster {
  let result = sort_exchange_odd_even_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_exchange_odd_even_cluster_fill(s : SortexchangeoddevenCluster, v : Double) -> SortexchangeoddevenCluster {
  let result = sort_exchange_odd_even_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_odd_even_cluster_min(s : SortexchangeoddevenCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_odd_even_cluster_max(s : SortexchangeoddevenCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_odd_even_cluster_to_string(s : SortexchangeoddevenCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangeoddevenModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_odd_even_model_make(size : Int) -> SortexchangeoddevenModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_odd_even_model_len(s : SortexchangeoddevenModel) -> Int { s.size }

pub fn sort_exchange_odd_even_model_get(s : SortexchangeoddevenModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_odd_even_model_set(s : SortexchangeoddevenModel, i : Int, v : Double) -> SortexchangeoddevenModel {
  let result = sort_exchange_odd_even_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_odd_even_model_sum(s : SortexchangeoddevenModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_exchange_odd_even_model_mean(s : SortexchangeoddevenModel) -> Double {
  if s.size == 0 { 0.0 } else { sort_exchange_odd_even_model_sum(s) / s.size.to_double() }
}

pub fn sort_exchange_odd_even_model_scale(s : SortexchangeoddevenModel, f : Double) -> SortexchangeoddevenModel {
  let result = sort_exchange_odd_even_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_exchange_odd_even_model_add(a : SortexchangeoddevenModel, b : SortexchangeoddevenModel) -> SortexchangeoddevenModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_exchange_odd_even_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_exchange_odd_even_model_copy(s : SortexchangeoddevenModel) -> SortexchangeoddevenModel {
  let result = sort_exchange_odd_even_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_exchange_odd_even_model_fill(s : SortexchangeoddevenModel, v : Double) -> SortexchangeoddevenModel {
  let result = sort_exchange_odd_even_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_odd_even_model_min(s : SortexchangeoddevenModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_odd_even_model_max(s : SortexchangeoddevenModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_odd_even_model_to_string(s : SortexchangeoddevenModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangeoddevenLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_odd_even_layer_make(size : Int) -> SortexchangeoddevenLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_odd_even_layer_len(s : SortexchangeoddevenLayer) -> Int { s.size }

pub fn sort_exchange_odd_even_layer_get(s : SortexchangeoddevenLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_odd_even_layer_set(s : SortexchangeoddevenLayer, i : Int, v : Double) -> SortexchangeoddevenLayer {
  let result = sort_exchange_odd_even_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_odd_even_layer_sum(s : SortexchangeoddevenLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_exchange_odd_even_layer_mean(s : SortexchangeoddevenLayer) -> Double {
  if s.size == 0 { 0.0 } else { sort_exchange_odd_even_layer_sum(s) / s.size.to_double() }
}

pub fn sort_exchange_odd_even_layer_scale(s : SortexchangeoddevenLayer, f : Double) -> SortexchangeoddevenLayer {
  let result = sort_exchange_odd_even_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_exchange_odd_even_layer_add(a : SortexchangeoddevenLayer, b : SortexchangeoddevenLayer) -> SortexchangeoddevenLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_exchange_odd_even_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_exchange_odd_even_layer_copy(s : SortexchangeoddevenLayer) -> SortexchangeoddevenLayer {
  let result = sort_exchange_odd_even_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_exchange_odd_even_layer_fill(s : SortexchangeoddevenLayer, v : Double) -> SortexchangeoddevenLayer {
  let result = sort_exchange_odd_even_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_odd_even_layer_min(s : SortexchangeoddevenLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_odd_even_layer_max(s : SortexchangeoddevenLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_odd_even_layer_to_string(s : SortexchangeoddevenLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangeoddevenBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_odd_even_buffer_make(size : Int) -> SortexchangeoddevenBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_odd_even_buffer_len(s : SortexchangeoddevenBuffer) -> Int { s.size }

pub fn sort_exchange_odd_even_buffer_get(s : SortexchangeoddevenBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_odd_even_buffer_set(s : SortexchangeoddevenBuffer, i : Int, v : Double) -> SortexchangeoddevenBuffer {
  let result = sort_exchange_odd_even_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_odd_even_buffer_sum(s : SortexchangeoddevenBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_exchange_odd_even_buffer_mean(s : SortexchangeoddevenBuffer) -> Double {
  if s.size == 0 { 0.0 } else { sort_exchange_odd_even_buffer_sum(s) / s.size.to_double() }
}

pub fn sort_exchange_odd_even_buffer_scale(s : SortexchangeoddevenBuffer, f : Double) -> SortexchangeoddevenBuffer {
  let result = sort_exchange_odd_even_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_exchange_odd_even_buffer_add(a : SortexchangeoddevenBuffer, b : SortexchangeoddevenBuffer) -> SortexchangeoddevenBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_exchange_odd_even_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_exchange_odd_even_buffer_copy(s : SortexchangeoddevenBuffer) -> SortexchangeoddevenBuffer {
  let result = sort_exchange_odd_even_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_exchange_odd_even_buffer_fill(s : SortexchangeoddevenBuffer, v : Double) -> SortexchangeoddevenBuffer {
  let result = sort_exchange_odd_even_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_odd_even_buffer_min(s : SortexchangeoddevenBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_odd_even_buffer_max(s : SortexchangeoddevenBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_odd_even_buffer_to_string(s : SortexchangeoddevenBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangeoddevenCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_odd_even_cursor_make(size : Int) -> SortexchangeoddevenCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_odd_even_cursor_len(s : SortexchangeoddevenCursor) -> Int { s.size }

pub fn sort_exchange_odd_even_cursor_get(s : SortexchangeoddevenCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_odd_even_cursor_set(s : SortexchangeoddevenCursor, i : Int, v : Double) -> SortexchangeoddevenCursor {
  let result = sort_exchange_odd_even_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_odd_even_cursor_sum(s : SortexchangeoddevenCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_exchange_odd_even_cursor_mean(s : SortexchangeoddevenCursor) -> Double {
  if s.size == 0 { 0.0 } else { sort_exchange_odd_even_cursor_sum(s) / s.size.to_double() }
}

pub fn sort_exchange_odd_even_cursor_scale(s : SortexchangeoddevenCursor, f : Double) -> SortexchangeoddevenCursor {
  let result = sort_exchange_odd_even_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_exchange_odd_even_cursor_add(a : SortexchangeoddevenCursor, b : SortexchangeoddevenCursor) -> SortexchangeoddevenCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_exchange_odd_even_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_exchange_odd_even_cursor_copy(s : SortexchangeoddevenCursor) -> SortexchangeoddevenCursor {
  let result = sort_exchange_odd_even_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_exchange_odd_even_cursor_fill(s : SortexchangeoddevenCursor, v : Double) -> SortexchangeoddevenCursor {
  let result = sort_exchange_odd_even_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_odd_even_cursor_min(s : SortexchangeoddevenCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_odd_even_cursor_max(s : SortexchangeoddevenCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_odd_even_cursor_to_string(s : SortexchangeoddevenCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangeoddevenView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_odd_even_view_make(size : Int) -> SortexchangeoddevenView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_odd_even_view_len(s : SortexchangeoddevenView) -> Int { s.size }

pub fn sort_exchange_odd_even_view_get(s : SortexchangeoddevenView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_odd_even_view_set(s : SortexchangeoddevenView, i : Int, v : Double) -> SortexchangeoddevenView {
  let result = sort_exchange_odd_even_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_odd_even_view_sum(s : SortexchangeoddevenView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_exchange_odd_even_view_mean(s : SortexchangeoddevenView) -> Double {
  if s.size == 0 { 0.0 } else { sort_exchange_odd_even_view_sum(s) / s.size.to_double() }
}

pub fn sort_exchange_odd_even_view_scale(s : SortexchangeoddevenView, f : Double) -> SortexchangeoddevenView {
  let result = sort_exchange_odd_even_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_exchange_odd_even_view_add(a : SortexchangeoddevenView, b : SortexchangeoddevenView) -> SortexchangeoddevenView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_exchange_odd_even_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_exchange_odd_even_view_copy(s : SortexchangeoddevenView) -> SortexchangeoddevenView {
  let result = sort_exchange_odd_even_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_exchange_odd_even_view_fill(s : SortexchangeoddevenView, v : Double) -> SortexchangeoddevenView {
  let result = sort_exchange_odd_even_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_odd_even_view_min(s : SortexchangeoddevenView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_odd_even_view_max(s : SortexchangeoddevenView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_odd_even_view_to_string(s : SortexchangeoddevenView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangeoddevenRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_odd_even_range_make(size : Int) -> SortexchangeoddevenRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_odd_even_range_len(s : SortexchangeoddevenRange) -> Int { s.size }

pub fn sort_exchange_odd_even_range_get(s : SortexchangeoddevenRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_odd_even_range_set(s : SortexchangeoddevenRange, i : Int, v : Double) -> SortexchangeoddevenRange {
  let result = sort_exchange_odd_even_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_odd_even_range_sum(s : SortexchangeoddevenRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_exchange_odd_even_range_mean(s : SortexchangeoddevenRange) -> Double {
  if s.size == 0 { 0.0 } else { sort_exchange_odd_even_range_sum(s) / s.size.to_double() }
}

pub fn sort_exchange_odd_even_range_scale(s : SortexchangeoddevenRange, f : Double) -> SortexchangeoddevenRange {
  let result = sort_exchange_odd_even_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_exchange_odd_even_range_add(a : SortexchangeoddevenRange, b : SortexchangeoddevenRange) -> SortexchangeoddevenRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_exchange_odd_even_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_exchange_odd_even_range_copy(s : SortexchangeoddevenRange) -> SortexchangeoddevenRange {
  let result = sort_exchange_odd_even_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_exchange_odd_even_range_fill(s : SortexchangeoddevenRange, v : Double) -> SortexchangeoddevenRange {
  let result = sort_exchange_odd_even_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_odd_even_range_min(s : SortexchangeoddevenRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_odd_even_range_max(s : SortexchangeoddevenRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_odd_even_range_to_string(s : SortexchangeoddevenRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangeoddevenSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_odd_even_slice_make(size : Int) -> SortexchangeoddevenSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_odd_even_slice_len(s : SortexchangeoddevenSlice) -> Int { s.size }

pub fn sort_exchange_odd_even_slice_get(s : SortexchangeoddevenSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_odd_even_slice_set(s : SortexchangeoddevenSlice, i : Int, v : Double) -> SortexchangeoddevenSlice {
  let result = sort_exchange_odd_even_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_odd_even_slice_sum(s : SortexchangeoddevenSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_exchange_odd_even_slice_mean(s : SortexchangeoddevenSlice) -> Double {
  if s.size == 0 { 0.0 } else { sort_exchange_odd_even_slice_sum(s) / s.size.to_double() }
}

pub fn sort_exchange_odd_even_slice_scale(s : SortexchangeoddevenSlice, f : Double) -> SortexchangeoddevenSlice {
  let result = sort_exchange_odd_even_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_exchange_odd_even_slice_add(a : SortexchangeoddevenSlice, b : SortexchangeoddevenSlice) -> SortexchangeoddevenSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_exchange_odd_even_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_exchange_odd_even_slice_copy(s : SortexchangeoddevenSlice) -> SortexchangeoddevenSlice {
  let result = sort_exchange_odd_even_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_exchange_odd_even_slice_fill(s : SortexchangeoddevenSlice, v : Double) -> SortexchangeoddevenSlice {
  let result = sort_exchange_odd_even_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_odd_even_slice_min(s : SortexchangeoddevenSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_odd_even_slice_max(s : SortexchangeoddevenSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_odd_even_slice_to_string(s : SortexchangeoddevenSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

