///===
/// extcore/math_sparse_matrix

pub(all) struct MathsparsematrixPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn math_sparse_matrix_make_point(x : Double, y : Double) -> MathsparsematrixPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn math_sparse_matrix_make_point3(x : Double, y : Double, z : Double) -> MathsparsematrixPoint {
  { x, y, z, label: 0 }
}

pub fn math_sparse_matrix_point_x(pt : MathsparsematrixPoint) -> Double { pt.x }

pub fn math_sparse_matrix_point_y(pt : MathsparsematrixPoint) -> Double { pt.y }

pub fn math_sparse_matrix_point_z(pt : MathsparsematrixPoint) -> Double { pt.z }

pub fn math_sparse_matrix_point_label(pt : MathsparsematrixPoint) -> Int { pt.label }

pub fn math_sparse_matrix_point_dist(a : MathsparsematrixPoint, b : MathsparsematrixPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn math_sparse_matrix_point_add(a : MathsparsematrixPoint, b : MathsparsematrixPoint) -> MathsparsematrixPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn math_sparse_matrix_point_sub(a : MathsparsematrixPoint, b : MathsparsematrixPoint) -> MathsparsematrixPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn math_sparse_matrix_point_scale(pt : MathsparsematrixPoint, s : Double) -> MathsparsematrixPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn math_sparse_matrix_point_dot(a : MathsparsematrixPoint, b : MathsparsematrixPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn math_sparse_matrix_point_cross(a : MathsparsematrixPoint, b : MathsparsematrixPoint) -> MathsparsematrixPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn math_sparse_matrix_point_norm(pt : MathsparsematrixPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn math_sparse_matrix_point_normalize(pt : MathsparsematrixPoint) -> MathsparsematrixPoint {
  let n = math_sparse_matrix_point_norm(pt)
  if n < 0.0000001 { pt } else { math_sparse_matrix_point_scale(pt, 1.0 / n) }
}

pub fn math_sparse_matrix_point_negate(pt : MathsparsematrixPoint) -> MathsparsematrixPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn math_sparse_matrix_point_mid(a : MathsparsematrixPoint, b : MathsparsematrixPoint) -> MathsparsematrixPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn math_sparse_matrix_point_lerp(a : MathsparsematrixPoint, b : MathsparsematrixPoint, t : Double) -> MathsparsematrixPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn math_sparse_matrix_point_to_string(pt : MathsparsematrixPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct MathsparsematrixSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn math_sparse_matrix_make_series(vals : Array[Double], name : String) -> MathsparsematrixSeries {
  { vals, name, meta: 0 }
}

pub fn math_sparse_matrix_series_len(s : MathsparsematrixSeries) -> Int { s.vals.length() }

pub fn math_sparse_matrix_series_sum(s : MathsparsematrixSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn math_sparse_matrix_series_mean(s : MathsparsematrixSeries) -> Double {
  let n = math_sparse_matrix_series_len(s)
  if n == 0 { 0.0 } else { math_sparse_matrix_series_sum(s) / n.to_double() }
}

pub fn math_sparse_matrix_series_min(s : MathsparsematrixSeries) -> Double {
  let n = math_sparse_matrix_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn math_sparse_matrix_series_max(s : MathsparsematrixSeries) -> Double {
  let n = math_sparse_matrix_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn math_sparse_matrix_series_range(s : MathsparsematrixSeries) -> Double {
  math_sparse_matrix_series_max(s) - math_sparse_matrix_series_min(s)
}

pub fn math_sparse_matrix_series_var(s : MathsparsematrixSeries) -> Double {
  let n = math_sparse_matrix_series_len(s)
  if n == 0 { 0.0 } else {
    let m = math_sparse_matrix_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn math_sparse_matrix_series_std(s : MathsparsematrixSeries) -> Double { @_common.sqrt(math_sparse_matrix_series_var(s)) }

pub fn math_sparse_matrix_series_median(s : MathsparsematrixSeries) -> Double {
  let n = math_sparse_matrix_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = math_sparse_matrix_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn math_sparse_matrix_series_scale(s : MathsparsematrixSeries, f : Double) -> MathsparsematrixSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn math_sparse_matrix_series_add(a : MathsparsematrixSeries, b : MathsparsematrixSeries) -> MathsparsematrixSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn math_sparse_matrix_series_sub(a : MathsparsematrixSeries, b : MathsparsematrixSeries) -> MathsparsematrixSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn math_sparse_matrix_series_normalize(s : MathsparsematrixSeries) -> MathsparsematrixSeries {
  let mn = math_sparse_matrix_series_min(s)
  let mx = math_sparse_matrix_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn math_sparse_matrix_series_cumsum(s : MathsparsematrixSeries) -> MathsparsematrixSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn math_sparse_matrix_series_to_string(s : MathsparsematrixSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MathsparsematrixMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn math_sparse_matrix_make_matrix(rows : Int, cols : Int, val : Double) -> MathsparsematrixMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn math_sparse_matrix_matrix_identity(n : Int) -> MathsparsematrixMatrix {
  let m = math_sparse_matrix_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn math_sparse_matrix_matrix_get(m : MathsparsematrixMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn math_sparse_matrix_matrix_transpose(m : MathsparsematrixMatrix) -> MathsparsematrixMatrix {
  let result = math_sparse_matrix_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn math_sparse_matrix_matrix_add(a : MathsparsematrixMatrix, b : MathsparsematrixMatrix) -> MathsparsematrixMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = math_sparse_matrix_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn math_sparse_matrix_matrix_scale(m : MathsparsematrixMatrix, s : Double) -> MathsparsematrixMatrix {
  let result = math_sparse_matrix_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn math_sparse_matrix_matrix_multiply(a : MathsparsematrixMatrix, b : MathsparsematrixMatrix) -> MathsparsematrixMatrix {
  if a.cols != b.rows { return math_sparse_matrix_make_matrix(a.rows, b.cols, 0.0) }
  let result = math_sparse_matrix_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn math_sparse_matrix_matrix_trace(m : MathsparsematrixMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn math_sparse_matrix_matrix_det(m : MathsparsematrixMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn math_sparse_matrix_matrix_norm(m : MathsparsematrixMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn math_sparse_matrix_matrix_to_string(m : MathsparsematrixMatrix) -> String {
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

pub(all) struct MathsparsematrixVector {
  comps : Array[Double]
  dim : Int
}

pub fn math_sparse_matrix_make_vector(comps : Array[Double]) -> MathsparsematrixVector {
  { comps, dim: comps.length() }
}

pub fn math_sparse_matrix_vector_zero(dim : Int) -> MathsparsematrixVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn math_sparse_matrix_vector_add(a : MathsparsematrixVector, b : MathsparsematrixVector) -> MathsparsematrixVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn math_sparse_matrix_vector_sub(a : MathsparsematrixVector, b : MathsparsematrixVector) -> MathsparsematrixVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn math_sparse_matrix_vector_scale(v : MathsparsematrixVector, s : Double) -> MathsparsematrixVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn math_sparse_matrix_vector_dot(a : MathsparsematrixVector, b : MathsparsematrixVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn math_sparse_matrix_vector_norm(v : MathsparsematrixVector) -> Double { @_common.sqrt(math_sparse_matrix_vector_dot(v, v)) }

pub fn math_sparse_matrix_vector_normalize(v : MathsparsematrixVector) -> MathsparsematrixVector {
  let n = math_sparse_matrix_vector_norm(v)
  if n < 0.0000001 { v } else { math_sparse_matrix_vector_scale(v, 1.0 / n) }
}

pub fn math_sparse_matrix_vector_dist(a : MathsparsematrixVector, b : MathsparsematrixVector) -> Double {
  math_sparse_matrix_vector_norm(math_sparse_matrix_vector_sub(a, b))
}

pub fn math_sparse_matrix_vector_to_string(v : MathsparsematrixVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn math_sparse_matrix_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn math_sparse_matrix_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = math_sparse_matrix_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn math_sparse_matrix_std(data : Array[Double]) -> Double { @_common.sqrt(math_sparse_matrix_var(data)) }

pub fn math_sparse_matrix_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = math_sparse_matrix_mean(a); let mb = math_sparse_matrix_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn math_sparse_matrix_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = math_sparse_matrix_std(a); let sb = math_sparse_matrix_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { math_sparse_matrix_cov(a, b) / (sa * sb) }
}

pub fn math_sparse_matrix_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = math_sparse_matrix_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn math_sparse_matrix_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn math_sparse_matrix_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn math_sparse_matrix_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  @_common.sqrt(math_sparse_matrix_mse(pred, labels))
}

pub fn math_sparse_matrix_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn math_sparse_matrix_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = math_sparse_matrix_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn math_sparse_matrix_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn math_sparse_matrix_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn math_sparse_matrix_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = math_sparse_matrix_precision(pred, labels, pos); let r = math_sparse_matrix_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn math_sparse_matrix_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn math_sparse_matrix_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = math_sparse_matrix_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn math_sparse_matrix_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn math_sparse_matrix_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn math_sparse_matrix_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = math_sparse_matrix_gcd(a, b)
    (a / g) * b
  }
}

pub fn math_sparse_matrix_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn math_sparse_matrix_fibonacci(n : Int) -> Int {
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

pub fn math_sparse_matrix_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = math_sparse_matrix_min(data); let mx = math_sparse_matrix_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn math_sparse_matrix_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = math_sparse_matrix_mean(data); let sd = math_sparse_matrix_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn math_sparse_matrix_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn math_sparse_matrix_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn math_sparse_matrix_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn math_sparse_matrix_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn math_sparse_matrix_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn math_sparse_matrix_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

pub(all) struct MathsparsematrixFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_sparse_matrix_frame_make(size : Int) -> MathsparsematrixFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_sparse_matrix_frame_len(s : MathsparsematrixFrame) -> Int { s.size }

pub fn math_sparse_matrix_frame_get(s : MathsparsematrixFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_sparse_matrix_frame_set(s : MathsparsematrixFrame, i : Int, v : Double) -> MathsparsematrixFrame {
  let result = math_sparse_matrix_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_sparse_matrix_frame_sum(s : MathsparsematrixFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_sparse_matrix_frame_mean(s : MathsparsematrixFrame) -> Double {
  if s.size == 0 { 0.0 } else { math_sparse_matrix_frame_sum(s) / s.size.to_double() }
}

pub fn math_sparse_matrix_frame_scale(s : MathsparsematrixFrame, f : Double) -> MathsparsematrixFrame {
  let result = math_sparse_matrix_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_sparse_matrix_frame_add(a : MathsparsematrixFrame, b : MathsparsematrixFrame) -> MathsparsematrixFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_sparse_matrix_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_sparse_matrix_frame_copy(s : MathsparsematrixFrame) -> MathsparsematrixFrame {
  let result = math_sparse_matrix_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_sparse_matrix_frame_fill(s : MathsparsematrixFrame, v : Double) -> MathsparsematrixFrame {
  let result = math_sparse_matrix_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_sparse_matrix_frame_min(s : MathsparsematrixFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_sparse_matrix_frame_max(s : MathsparsematrixFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_sparse_matrix_frame_to_string(s : MathsparsematrixFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathsparsematrixTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_sparse_matrix_table_make(size : Int) -> MathsparsematrixTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_sparse_matrix_table_len(s : MathsparsematrixTable) -> Int { s.size }

pub fn math_sparse_matrix_table_get(s : MathsparsematrixTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_sparse_matrix_table_set(s : MathsparsematrixTable, i : Int, v : Double) -> MathsparsematrixTable {
  let result = math_sparse_matrix_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_sparse_matrix_table_sum(s : MathsparsematrixTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_sparse_matrix_table_mean(s : MathsparsematrixTable) -> Double {
  if s.size == 0 { 0.0 } else { math_sparse_matrix_table_sum(s) / s.size.to_double() }
}

pub fn math_sparse_matrix_table_scale(s : MathsparsematrixTable, f : Double) -> MathsparsematrixTable {
  let result = math_sparse_matrix_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_sparse_matrix_table_add(a : MathsparsematrixTable, b : MathsparsematrixTable) -> MathsparsematrixTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_sparse_matrix_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_sparse_matrix_table_copy(s : MathsparsematrixTable) -> MathsparsematrixTable {
  let result = math_sparse_matrix_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_sparse_matrix_table_fill(s : MathsparsematrixTable, v : Double) -> MathsparsematrixTable {
  let result = math_sparse_matrix_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_sparse_matrix_table_min(s : MathsparsematrixTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_sparse_matrix_table_max(s : MathsparsematrixTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_sparse_matrix_table_to_string(s : MathsparsematrixTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathsparsematrixGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_sparse_matrix_graphn_make(size : Int) -> MathsparsematrixGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_sparse_matrix_graphn_len(s : MathsparsematrixGraphN) -> Int { s.size }

pub fn math_sparse_matrix_graphn_get(s : MathsparsematrixGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_sparse_matrix_graphn_set(s : MathsparsematrixGraphN, i : Int, v : Double) -> MathsparsematrixGraphN {
  let result = math_sparse_matrix_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_sparse_matrix_graphn_sum(s : MathsparsematrixGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_sparse_matrix_graphn_mean(s : MathsparsematrixGraphN) -> Double {
  if s.size == 0 { 0.0 } else { math_sparse_matrix_graphn_sum(s) / s.size.to_double() }
}

pub fn math_sparse_matrix_graphn_scale(s : MathsparsematrixGraphN, f : Double) -> MathsparsematrixGraphN {
  let result = math_sparse_matrix_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_sparse_matrix_graphn_add(a : MathsparsematrixGraphN, b : MathsparsematrixGraphN) -> MathsparsematrixGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_sparse_matrix_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_sparse_matrix_graphn_copy(s : MathsparsematrixGraphN) -> MathsparsematrixGraphN {
  let result = math_sparse_matrix_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_sparse_matrix_graphn_fill(s : MathsparsematrixGraphN, v : Double) -> MathsparsematrixGraphN {
  let result = math_sparse_matrix_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_sparse_matrix_graphn_min(s : MathsparsematrixGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_sparse_matrix_graphn_max(s : MathsparsematrixGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_sparse_matrix_graphn_to_string(s : MathsparsematrixGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathsparsematrixNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_sparse_matrix_node_make(size : Int) -> MathsparsematrixNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_sparse_matrix_node_len(s : MathsparsematrixNode) -> Int { s.size }

pub fn math_sparse_matrix_node_get(s : MathsparsematrixNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_sparse_matrix_node_set(s : MathsparsematrixNode, i : Int, v : Double) -> MathsparsematrixNode {
  let result = math_sparse_matrix_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_sparse_matrix_node_sum(s : MathsparsematrixNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_sparse_matrix_node_mean(s : MathsparsematrixNode) -> Double {
  if s.size == 0 { 0.0 } else { math_sparse_matrix_node_sum(s) / s.size.to_double() }
}

pub fn math_sparse_matrix_node_scale(s : MathsparsematrixNode, f : Double) -> MathsparsematrixNode {
  let result = math_sparse_matrix_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_sparse_matrix_node_add(a : MathsparsematrixNode, b : MathsparsematrixNode) -> MathsparsematrixNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_sparse_matrix_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_sparse_matrix_node_copy(s : MathsparsematrixNode) -> MathsparsematrixNode {
  let result = math_sparse_matrix_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_sparse_matrix_node_fill(s : MathsparsematrixNode, v : Double) -> MathsparsematrixNode {
  let result = math_sparse_matrix_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_sparse_matrix_node_min(s : MathsparsematrixNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_sparse_matrix_node_max(s : MathsparsematrixNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_sparse_matrix_node_to_string(s : MathsparsematrixNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathsparsematrixEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_sparse_matrix_edge_make(size : Int) -> MathsparsematrixEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_sparse_matrix_edge_len(s : MathsparsematrixEdge) -> Int { s.size }

pub fn math_sparse_matrix_edge_get(s : MathsparsematrixEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_sparse_matrix_edge_set(s : MathsparsematrixEdge, i : Int, v : Double) -> MathsparsematrixEdge {
  let result = math_sparse_matrix_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_sparse_matrix_edge_sum(s : MathsparsematrixEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_sparse_matrix_edge_mean(s : MathsparsematrixEdge) -> Double {
  if s.size == 0 { 0.0 } else { math_sparse_matrix_edge_sum(s) / s.size.to_double() }
}

pub fn math_sparse_matrix_edge_scale(s : MathsparsematrixEdge, f : Double) -> MathsparsematrixEdge {
  let result = math_sparse_matrix_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_sparse_matrix_edge_add(a : MathsparsematrixEdge, b : MathsparsematrixEdge) -> MathsparsematrixEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_sparse_matrix_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_sparse_matrix_edge_copy(s : MathsparsematrixEdge) -> MathsparsematrixEdge {
  let result = math_sparse_matrix_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_sparse_matrix_edge_fill(s : MathsparsematrixEdge, v : Double) -> MathsparsematrixEdge {
  let result = math_sparse_matrix_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_sparse_matrix_edge_min(s : MathsparsematrixEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_sparse_matrix_edge_max(s : MathsparsematrixEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_sparse_matrix_edge_to_string(s : MathsparsematrixEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathsparsematrixPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_sparse_matrix_path_make(size : Int) -> MathsparsematrixPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_sparse_matrix_path_len(s : MathsparsematrixPath) -> Int { s.size }

pub fn math_sparse_matrix_path_get(s : MathsparsematrixPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_sparse_matrix_path_set(s : MathsparsematrixPath, i : Int, v : Double) -> MathsparsematrixPath {
  let result = math_sparse_matrix_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_sparse_matrix_path_sum(s : MathsparsematrixPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_sparse_matrix_path_mean(s : MathsparsematrixPath) -> Double {
  if s.size == 0 { 0.0 } else { math_sparse_matrix_path_sum(s) / s.size.to_double() }
}

pub fn math_sparse_matrix_path_scale(s : MathsparsematrixPath, f : Double) -> MathsparsematrixPath {
  let result = math_sparse_matrix_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_sparse_matrix_path_add(a : MathsparsematrixPath, b : MathsparsematrixPath) -> MathsparsematrixPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_sparse_matrix_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_sparse_matrix_path_copy(s : MathsparsematrixPath) -> MathsparsematrixPath {
  let result = math_sparse_matrix_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_sparse_matrix_path_fill(s : MathsparsematrixPath, v : Double) -> MathsparsematrixPath {
  let result = math_sparse_matrix_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_sparse_matrix_path_min(s : MathsparsematrixPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_sparse_matrix_path_max(s : MathsparsematrixPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_sparse_matrix_path_to_string(s : MathsparsematrixPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathsparsematrixCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_sparse_matrix_cluster_make(size : Int) -> MathsparsematrixCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_sparse_matrix_cluster_len(s : MathsparsematrixCluster) -> Int { s.size }

pub fn math_sparse_matrix_cluster_get(s : MathsparsematrixCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_sparse_matrix_cluster_set(s : MathsparsematrixCluster, i : Int, v : Double) -> MathsparsematrixCluster {
  let result = math_sparse_matrix_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_sparse_matrix_cluster_sum(s : MathsparsematrixCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_sparse_matrix_cluster_mean(s : MathsparsematrixCluster) -> Double {
  if s.size == 0 { 0.0 } else { math_sparse_matrix_cluster_sum(s) / s.size.to_double() }
}

pub fn math_sparse_matrix_cluster_scale(s : MathsparsematrixCluster, f : Double) -> MathsparsematrixCluster {
  let result = math_sparse_matrix_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_sparse_matrix_cluster_add(a : MathsparsematrixCluster, b : MathsparsematrixCluster) -> MathsparsematrixCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_sparse_matrix_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_sparse_matrix_cluster_copy(s : MathsparsematrixCluster) -> MathsparsematrixCluster {
  let result = math_sparse_matrix_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_sparse_matrix_cluster_fill(s : MathsparsematrixCluster, v : Double) -> MathsparsematrixCluster {
  let result = math_sparse_matrix_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_sparse_matrix_cluster_min(s : MathsparsematrixCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_sparse_matrix_cluster_max(s : MathsparsematrixCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_sparse_matrix_cluster_to_string(s : MathsparsematrixCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathsparsematrixModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_sparse_matrix_model_make(size : Int) -> MathsparsematrixModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_sparse_matrix_model_len(s : MathsparsematrixModel) -> Int { s.size }

pub fn math_sparse_matrix_model_get(s : MathsparsematrixModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_sparse_matrix_model_set(s : MathsparsematrixModel, i : Int, v : Double) -> MathsparsematrixModel {
  let result = math_sparse_matrix_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_sparse_matrix_model_sum(s : MathsparsematrixModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_sparse_matrix_model_mean(s : MathsparsematrixModel) -> Double {
  if s.size == 0 { 0.0 } else { math_sparse_matrix_model_sum(s) / s.size.to_double() }
}

pub fn math_sparse_matrix_model_scale(s : MathsparsematrixModel, f : Double) -> MathsparsematrixModel {
  let result = math_sparse_matrix_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_sparse_matrix_model_add(a : MathsparsematrixModel, b : MathsparsematrixModel) -> MathsparsematrixModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_sparse_matrix_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_sparse_matrix_model_copy(s : MathsparsematrixModel) -> MathsparsematrixModel {
  let result = math_sparse_matrix_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_sparse_matrix_model_fill(s : MathsparsematrixModel, v : Double) -> MathsparsematrixModel {
  let result = math_sparse_matrix_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_sparse_matrix_model_min(s : MathsparsematrixModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_sparse_matrix_model_max(s : MathsparsematrixModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_sparse_matrix_model_to_string(s : MathsparsematrixModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathsparsematrixLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_sparse_matrix_layer_make(size : Int) -> MathsparsematrixLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_sparse_matrix_layer_len(s : MathsparsematrixLayer) -> Int { s.size }

pub fn math_sparse_matrix_layer_get(s : MathsparsematrixLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_sparse_matrix_layer_set(s : MathsparsematrixLayer, i : Int, v : Double) -> MathsparsematrixLayer {
  let result = math_sparse_matrix_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_sparse_matrix_layer_sum(s : MathsparsematrixLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_sparse_matrix_layer_mean(s : MathsparsematrixLayer) -> Double {
  if s.size == 0 { 0.0 } else { math_sparse_matrix_layer_sum(s) / s.size.to_double() }
}

pub fn math_sparse_matrix_layer_scale(s : MathsparsematrixLayer, f : Double) -> MathsparsematrixLayer {
  let result = math_sparse_matrix_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_sparse_matrix_layer_add(a : MathsparsematrixLayer, b : MathsparsematrixLayer) -> MathsparsematrixLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_sparse_matrix_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_sparse_matrix_layer_copy(s : MathsparsematrixLayer) -> MathsparsematrixLayer {
  let result = math_sparse_matrix_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_sparse_matrix_layer_fill(s : MathsparsematrixLayer, v : Double) -> MathsparsematrixLayer {
  let result = math_sparse_matrix_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_sparse_matrix_layer_min(s : MathsparsematrixLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_sparse_matrix_layer_max(s : MathsparsematrixLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_sparse_matrix_layer_to_string(s : MathsparsematrixLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathsparsematrixBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_sparse_matrix_buffer_make(size : Int) -> MathsparsematrixBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_sparse_matrix_buffer_len(s : MathsparsematrixBuffer) -> Int { s.size }

pub fn math_sparse_matrix_buffer_get(s : MathsparsematrixBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_sparse_matrix_buffer_set(s : MathsparsematrixBuffer, i : Int, v : Double) -> MathsparsematrixBuffer {
  let result = math_sparse_matrix_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_sparse_matrix_buffer_sum(s : MathsparsematrixBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_sparse_matrix_buffer_mean(s : MathsparsematrixBuffer) -> Double {
  if s.size == 0 { 0.0 } else { math_sparse_matrix_buffer_sum(s) / s.size.to_double() }
}

pub fn math_sparse_matrix_buffer_scale(s : MathsparsematrixBuffer, f : Double) -> MathsparsematrixBuffer {
  let result = math_sparse_matrix_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_sparse_matrix_buffer_add(a : MathsparsematrixBuffer, b : MathsparsematrixBuffer) -> MathsparsematrixBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_sparse_matrix_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_sparse_matrix_buffer_copy(s : MathsparsematrixBuffer) -> MathsparsematrixBuffer {
  let result = math_sparse_matrix_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_sparse_matrix_buffer_fill(s : MathsparsematrixBuffer, v : Double) -> MathsparsematrixBuffer {
  let result = math_sparse_matrix_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_sparse_matrix_buffer_min(s : MathsparsematrixBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_sparse_matrix_buffer_max(s : MathsparsematrixBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_sparse_matrix_buffer_to_string(s : MathsparsematrixBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathsparsematrixCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_sparse_matrix_cursor_make(size : Int) -> MathsparsematrixCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_sparse_matrix_cursor_len(s : MathsparsematrixCursor) -> Int { s.size }

pub fn math_sparse_matrix_cursor_get(s : MathsparsematrixCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_sparse_matrix_cursor_set(s : MathsparsematrixCursor, i : Int, v : Double) -> MathsparsematrixCursor {
  let result = math_sparse_matrix_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_sparse_matrix_cursor_sum(s : MathsparsematrixCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_sparse_matrix_cursor_mean(s : MathsparsematrixCursor) -> Double {
  if s.size == 0 { 0.0 } else { math_sparse_matrix_cursor_sum(s) / s.size.to_double() }
}

pub fn math_sparse_matrix_cursor_scale(s : MathsparsematrixCursor, f : Double) -> MathsparsematrixCursor {
  let result = math_sparse_matrix_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_sparse_matrix_cursor_add(a : MathsparsematrixCursor, b : MathsparsematrixCursor) -> MathsparsematrixCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_sparse_matrix_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_sparse_matrix_cursor_copy(s : MathsparsematrixCursor) -> MathsparsematrixCursor {
  let result = math_sparse_matrix_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_sparse_matrix_cursor_fill(s : MathsparsematrixCursor, v : Double) -> MathsparsematrixCursor {
  let result = math_sparse_matrix_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_sparse_matrix_cursor_min(s : MathsparsematrixCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_sparse_matrix_cursor_max(s : MathsparsematrixCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_sparse_matrix_cursor_to_string(s : MathsparsematrixCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathsparsematrixView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_sparse_matrix_view_make(size : Int) -> MathsparsematrixView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_sparse_matrix_view_len(s : MathsparsematrixView) -> Int { s.size }

pub fn math_sparse_matrix_view_get(s : MathsparsematrixView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_sparse_matrix_view_set(s : MathsparsematrixView, i : Int, v : Double) -> MathsparsematrixView {
  let result = math_sparse_matrix_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_sparse_matrix_view_sum(s : MathsparsematrixView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_sparse_matrix_view_mean(s : MathsparsematrixView) -> Double {
  if s.size == 0 { 0.0 } else { math_sparse_matrix_view_sum(s) / s.size.to_double() }
}

pub fn math_sparse_matrix_view_scale(s : MathsparsematrixView, f : Double) -> MathsparsematrixView {
  let result = math_sparse_matrix_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_sparse_matrix_view_add(a : MathsparsematrixView, b : MathsparsematrixView) -> MathsparsematrixView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_sparse_matrix_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_sparse_matrix_view_copy(s : MathsparsematrixView) -> MathsparsematrixView {
  let result = math_sparse_matrix_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_sparse_matrix_view_fill(s : MathsparsematrixView, v : Double) -> MathsparsematrixView {
  let result = math_sparse_matrix_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_sparse_matrix_view_min(s : MathsparsematrixView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_sparse_matrix_view_max(s : MathsparsematrixView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_sparse_matrix_view_to_string(s : MathsparsematrixView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathsparsematrixRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_sparse_matrix_range_make(size : Int) -> MathsparsematrixRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_sparse_matrix_range_len(s : MathsparsematrixRange) -> Int { s.size }

pub fn math_sparse_matrix_range_get(s : MathsparsematrixRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_sparse_matrix_range_set(s : MathsparsematrixRange, i : Int, v : Double) -> MathsparsematrixRange {
  let result = math_sparse_matrix_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_sparse_matrix_range_sum(s : MathsparsematrixRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_sparse_matrix_range_mean(s : MathsparsematrixRange) -> Double {
  if s.size == 0 { 0.0 } else { math_sparse_matrix_range_sum(s) / s.size.to_double() }
}

pub fn math_sparse_matrix_range_scale(s : MathsparsematrixRange, f : Double) -> MathsparsematrixRange {
  let result = math_sparse_matrix_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_sparse_matrix_range_add(a : MathsparsematrixRange, b : MathsparsematrixRange) -> MathsparsematrixRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_sparse_matrix_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_sparse_matrix_range_copy(s : MathsparsematrixRange) -> MathsparsematrixRange {
  let result = math_sparse_matrix_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_sparse_matrix_range_fill(s : MathsparsematrixRange, v : Double) -> MathsparsematrixRange {
  let result = math_sparse_matrix_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_sparse_matrix_range_min(s : MathsparsematrixRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_sparse_matrix_range_max(s : MathsparsematrixRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_sparse_matrix_range_to_string(s : MathsparsematrixRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathsparsematrixSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_sparse_matrix_slice_make(size : Int) -> MathsparsematrixSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_sparse_matrix_slice_len(s : MathsparsematrixSlice) -> Int { s.size }

pub fn math_sparse_matrix_slice_get(s : MathsparsematrixSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_sparse_matrix_slice_set(s : MathsparsematrixSlice, i : Int, v : Double) -> MathsparsematrixSlice {
  let result = math_sparse_matrix_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_sparse_matrix_slice_sum(s : MathsparsematrixSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_sparse_matrix_slice_mean(s : MathsparsematrixSlice) -> Double {
  if s.size == 0 { 0.0 } else { math_sparse_matrix_slice_sum(s) / s.size.to_double() }
}

pub fn math_sparse_matrix_slice_scale(s : MathsparsematrixSlice, f : Double) -> MathsparsematrixSlice {
  let result = math_sparse_matrix_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_sparse_matrix_slice_add(a : MathsparsematrixSlice, b : MathsparsematrixSlice) -> MathsparsematrixSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_sparse_matrix_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_sparse_matrix_slice_copy(s : MathsparsematrixSlice) -> MathsparsematrixSlice {
  let result = math_sparse_matrix_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_sparse_matrix_slice_fill(s : MathsparsematrixSlice, v : Double) -> MathsparsematrixSlice {
  let result = math_sparse_matrix_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_sparse_matrix_slice_min(s : MathsparsematrixSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_sparse_matrix_slice_max(s : MathsparsematrixSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_sparse_matrix_slice_to_string(s : MathsparsematrixSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

