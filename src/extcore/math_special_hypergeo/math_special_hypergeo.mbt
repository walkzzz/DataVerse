///===
/// extcore/math_special_hypergeo

pub(all) struct MathspecialhypergeoPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn math_special_hypergeo_make_point(x : Double, y : Double) -> MathspecialhypergeoPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn math_special_hypergeo_make_point3(x : Double, y : Double, z : Double) -> MathspecialhypergeoPoint {
  { x, y, z, label: 0 }
}

pub fn math_special_hypergeo_point_x(pt : MathspecialhypergeoPoint) -> Double { pt.x }

pub fn math_special_hypergeo_point_y(pt : MathspecialhypergeoPoint) -> Double { pt.y }

pub fn math_special_hypergeo_point_z(pt : MathspecialhypergeoPoint) -> Double { pt.z }

pub fn math_special_hypergeo_point_label(pt : MathspecialhypergeoPoint) -> Int { pt.label }

pub fn math_special_hypergeo_point_dist(a : MathspecialhypergeoPoint, b : MathspecialhypergeoPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn math_special_hypergeo_point_add(a : MathspecialhypergeoPoint, b : MathspecialhypergeoPoint) -> MathspecialhypergeoPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn math_special_hypergeo_point_sub(a : MathspecialhypergeoPoint, b : MathspecialhypergeoPoint) -> MathspecialhypergeoPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn math_special_hypergeo_point_scale(pt : MathspecialhypergeoPoint, s : Double) -> MathspecialhypergeoPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn math_special_hypergeo_point_dot(a : MathspecialhypergeoPoint, b : MathspecialhypergeoPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn math_special_hypergeo_point_cross(a : MathspecialhypergeoPoint, b : MathspecialhypergeoPoint) -> MathspecialhypergeoPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn math_special_hypergeo_point_norm(pt : MathspecialhypergeoPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn math_special_hypergeo_point_normalize(pt : MathspecialhypergeoPoint) -> MathspecialhypergeoPoint {
  let n = math_special_hypergeo_point_norm(pt)
  if n < 0.0000001 { pt } else { math_special_hypergeo_point_scale(pt, 1.0 / n) }
}

pub fn math_special_hypergeo_point_negate(pt : MathspecialhypergeoPoint) -> MathspecialhypergeoPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn math_special_hypergeo_point_mid(a : MathspecialhypergeoPoint, b : MathspecialhypergeoPoint) -> MathspecialhypergeoPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn math_special_hypergeo_point_lerp(a : MathspecialhypergeoPoint, b : MathspecialhypergeoPoint, t : Double) -> MathspecialhypergeoPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn math_special_hypergeo_point_to_string(pt : MathspecialhypergeoPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct MathspecialhypergeoSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn math_special_hypergeo_make_series(vals : Array[Double], name : String) -> MathspecialhypergeoSeries {
  { vals, name, meta: 0 }
}

pub fn math_special_hypergeo_series_len(s : MathspecialhypergeoSeries) -> Int { s.vals.length() }

pub fn math_special_hypergeo_series_sum(s : MathspecialhypergeoSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn math_special_hypergeo_series_mean(s : MathspecialhypergeoSeries) -> Double {
  let n = math_special_hypergeo_series_len(s)
  if n == 0 { 0.0 } else { math_special_hypergeo_series_sum(s) / n.to_double() }
}

pub fn math_special_hypergeo_series_min(s : MathspecialhypergeoSeries) -> Double {
  let n = math_special_hypergeo_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn math_special_hypergeo_series_max(s : MathspecialhypergeoSeries) -> Double {
  let n = math_special_hypergeo_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn math_special_hypergeo_series_range(s : MathspecialhypergeoSeries) -> Double {
  math_special_hypergeo_series_max(s) - math_special_hypergeo_series_min(s)
}

pub fn math_special_hypergeo_series_var(s : MathspecialhypergeoSeries) -> Double {
  let n = math_special_hypergeo_series_len(s)
  if n == 0 { 0.0 } else {
    let m = math_special_hypergeo_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn math_special_hypergeo_series_std(s : MathspecialhypergeoSeries) -> Double { @_common.sqrt(math_special_hypergeo_series_var(s)) }

pub fn math_special_hypergeo_series_median(s : MathspecialhypergeoSeries) -> Double {
  let n = math_special_hypergeo_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = math_special_hypergeo_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn math_special_hypergeo_series_scale(s : MathspecialhypergeoSeries, f : Double) -> MathspecialhypergeoSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn math_special_hypergeo_series_add(a : MathspecialhypergeoSeries, b : MathspecialhypergeoSeries) -> MathspecialhypergeoSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn math_special_hypergeo_series_sub(a : MathspecialhypergeoSeries, b : MathspecialhypergeoSeries) -> MathspecialhypergeoSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn math_special_hypergeo_series_normalize(s : MathspecialhypergeoSeries) -> MathspecialhypergeoSeries {
  let mn = math_special_hypergeo_series_min(s)
  let mx = math_special_hypergeo_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn math_special_hypergeo_series_cumsum(s : MathspecialhypergeoSeries) -> MathspecialhypergeoSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn math_special_hypergeo_series_to_string(s : MathspecialhypergeoSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MathspecialhypergeoMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn math_special_hypergeo_make_matrix(rows : Int, cols : Int, val : Double) -> MathspecialhypergeoMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn math_special_hypergeo_matrix_identity(n : Int) -> MathspecialhypergeoMatrix {
  let m = math_special_hypergeo_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn math_special_hypergeo_matrix_get(m : MathspecialhypergeoMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn math_special_hypergeo_matrix_transpose(m : MathspecialhypergeoMatrix) -> MathspecialhypergeoMatrix {
  let result = math_special_hypergeo_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn math_special_hypergeo_matrix_add(a : MathspecialhypergeoMatrix, b : MathspecialhypergeoMatrix) -> MathspecialhypergeoMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = math_special_hypergeo_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn math_special_hypergeo_matrix_scale(m : MathspecialhypergeoMatrix, s : Double) -> MathspecialhypergeoMatrix {
  let result = math_special_hypergeo_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn math_special_hypergeo_matrix_multiply(a : MathspecialhypergeoMatrix, b : MathspecialhypergeoMatrix) -> MathspecialhypergeoMatrix {
  if a.cols != b.rows { return math_special_hypergeo_make_matrix(a.rows, b.cols, 0.0) }
  let result = math_special_hypergeo_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn math_special_hypergeo_matrix_trace(m : MathspecialhypergeoMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn math_special_hypergeo_matrix_det(m : MathspecialhypergeoMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn math_special_hypergeo_matrix_norm(m : MathspecialhypergeoMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn math_special_hypergeo_matrix_to_string(m : MathspecialhypergeoMatrix) -> String {
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

pub(all) struct MathspecialhypergeoVector {
  comps : Array[Double]
  dim : Int
}

pub fn math_special_hypergeo_make_vector(comps : Array[Double]) -> MathspecialhypergeoVector {
  { comps, dim: comps.length() }
}

pub fn math_special_hypergeo_vector_zero(dim : Int) -> MathspecialhypergeoVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn math_special_hypergeo_vector_add(a : MathspecialhypergeoVector, b : MathspecialhypergeoVector) -> MathspecialhypergeoVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn math_special_hypergeo_vector_sub(a : MathspecialhypergeoVector, b : MathspecialhypergeoVector) -> MathspecialhypergeoVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn math_special_hypergeo_vector_scale(v : MathspecialhypergeoVector, s : Double) -> MathspecialhypergeoVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn math_special_hypergeo_vector_dot(a : MathspecialhypergeoVector, b : MathspecialhypergeoVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn math_special_hypergeo_vector_norm(v : MathspecialhypergeoVector) -> Double { @_common.sqrt(math_special_hypergeo_vector_dot(v, v)) }

pub fn math_special_hypergeo_vector_normalize(v : MathspecialhypergeoVector) -> MathspecialhypergeoVector {
  let n = math_special_hypergeo_vector_norm(v)
  if n < 0.0000001 { v } else { math_special_hypergeo_vector_scale(v, 1.0 / n) }
}

pub fn math_special_hypergeo_vector_dist(a : MathspecialhypergeoVector, b : MathspecialhypergeoVector) -> Double {
  math_special_hypergeo_vector_norm(math_special_hypergeo_vector_sub(a, b))
}

pub fn math_special_hypergeo_vector_to_string(v : MathspecialhypergeoVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn math_special_hypergeo_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn math_special_hypergeo_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = math_special_hypergeo_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn math_special_hypergeo_std(data : Array[Double]) -> Double { @_common.sqrt(math_special_hypergeo_var(data)) }

pub fn math_special_hypergeo_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = math_special_hypergeo_mean(a); let mb = math_special_hypergeo_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn math_special_hypergeo_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = math_special_hypergeo_std(a); let sb = math_special_hypergeo_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { math_special_hypergeo_cov(a, b) / (sa * sb) }
}

pub fn math_special_hypergeo_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = math_special_hypergeo_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn math_special_hypergeo_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn math_special_hypergeo_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn math_special_hypergeo_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  @_common.sqrt(math_special_hypergeo_mse(pred, labels))
}

pub fn math_special_hypergeo_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn math_special_hypergeo_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = math_special_hypergeo_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn math_special_hypergeo_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn math_special_hypergeo_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn math_special_hypergeo_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = math_special_hypergeo_precision(pred, labels, pos); let r = math_special_hypergeo_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn math_special_hypergeo_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn math_special_hypergeo_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = math_special_hypergeo_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn math_special_hypergeo_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn math_special_hypergeo_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn math_special_hypergeo_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = math_special_hypergeo_gcd(a, b)
    (a / g) * b
  }
}

pub fn math_special_hypergeo_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn math_special_hypergeo_fibonacci(n : Int) -> Int {
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

pub fn math_special_hypergeo_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = math_special_hypergeo_min(data); let mx = math_special_hypergeo_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn math_special_hypergeo_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = math_special_hypergeo_mean(data); let sd = math_special_hypergeo_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn math_special_hypergeo_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn math_special_hypergeo_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn math_special_hypergeo_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn math_special_hypergeo_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn math_special_hypergeo_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn math_special_hypergeo_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

pub(all) struct MathspecialhypergeoFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_hypergeo_frame_make(size : Int) -> MathspecialhypergeoFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_hypergeo_frame_len(s : MathspecialhypergeoFrame) -> Int { s.size }

pub fn math_special_hypergeo_frame_get(s : MathspecialhypergeoFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_hypergeo_frame_set(s : MathspecialhypergeoFrame, i : Int, v : Double) -> MathspecialhypergeoFrame {
  let result = math_special_hypergeo_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_special_hypergeo_frame_sum(s : MathspecialhypergeoFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_special_hypergeo_frame_mean(s : MathspecialhypergeoFrame) -> Double {
  if s.size == 0 { 0.0 } else { math_special_hypergeo_frame_sum(s) / s.size.to_double() }
}

pub fn math_special_hypergeo_frame_scale(s : MathspecialhypergeoFrame, f : Double) -> MathspecialhypergeoFrame {
  let result = math_special_hypergeo_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_special_hypergeo_frame_add(a : MathspecialhypergeoFrame, b : MathspecialhypergeoFrame) -> MathspecialhypergeoFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_special_hypergeo_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_special_hypergeo_frame_copy(s : MathspecialhypergeoFrame) -> MathspecialhypergeoFrame {
  let result = math_special_hypergeo_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_special_hypergeo_frame_fill(s : MathspecialhypergeoFrame, v : Double) -> MathspecialhypergeoFrame {
  let result = math_special_hypergeo_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_special_hypergeo_frame_min(s : MathspecialhypergeoFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_special_hypergeo_frame_max(s : MathspecialhypergeoFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_special_hypergeo_frame_to_string(s : MathspecialhypergeoFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialhypergeoTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_hypergeo_table_make(size : Int) -> MathspecialhypergeoTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_hypergeo_table_len(s : MathspecialhypergeoTable) -> Int { s.size }

pub fn math_special_hypergeo_table_get(s : MathspecialhypergeoTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_hypergeo_table_set(s : MathspecialhypergeoTable, i : Int, v : Double) -> MathspecialhypergeoTable {
  let result = math_special_hypergeo_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_special_hypergeo_table_sum(s : MathspecialhypergeoTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_special_hypergeo_table_mean(s : MathspecialhypergeoTable) -> Double {
  if s.size == 0 { 0.0 } else { math_special_hypergeo_table_sum(s) / s.size.to_double() }
}

pub fn math_special_hypergeo_table_scale(s : MathspecialhypergeoTable, f : Double) -> MathspecialhypergeoTable {
  let result = math_special_hypergeo_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_special_hypergeo_table_add(a : MathspecialhypergeoTable, b : MathspecialhypergeoTable) -> MathspecialhypergeoTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_special_hypergeo_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_special_hypergeo_table_copy(s : MathspecialhypergeoTable) -> MathspecialhypergeoTable {
  let result = math_special_hypergeo_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_special_hypergeo_table_fill(s : MathspecialhypergeoTable, v : Double) -> MathspecialhypergeoTable {
  let result = math_special_hypergeo_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_special_hypergeo_table_min(s : MathspecialhypergeoTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_special_hypergeo_table_max(s : MathspecialhypergeoTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_special_hypergeo_table_to_string(s : MathspecialhypergeoTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialhypergeoGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_hypergeo_graphn_make(size : Int) -> MathspecialhypergeoGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_hypergeo_graphn_len(s : MathspecialhypergeoGraphN) -> Int { s.size }

pub fn math_special_hypergeo_graphn_get(s : MathspecialhypergeoGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_hypergeo_graphn_set(s : MathspecialhypergeoGraphN, i : Int, v : Double) -> MathspecialhypergeoGraphN {
  let result = math_special_hypergeo_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_special_hypergeo_graphn_sum(s : MathspecialhypergeoGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_special_hypergeo_graphn_mean(s : MathspecialhypergeoGraphN) -> Double {
  if s.size == 0 { 0.0 } else { math_special_hypergeo_graphn_sum(s) / s.size.to_double() }
}

pub fn math_special_hypergeo_graphn_scale(s : MathspecialhypergeoGraphN, f : Double) -> MathspecialhypergeoGraphN {
  let result = math_special_hypergeo_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_special_hypergeo_graphn_add(a : MathspecialhypergeoGraphN, b : MathspecialhypergeoGraphN) -> MathspecialhypergeoGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_special_hypergeo_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_special_hypergeo_graphn_copy(s : MathspecialhypergeoGraphN) -> MathspecialhypergeoGraphN {
  let result = math_special_hypergeo_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_special_hypergeo_graphn_fill(s : MathspecialhypergeoGraphN, v : Double) -> MathspecialhypergeoGraphN {
  let result = math_special_hypergeo_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_special_hypergeo_graphn_min(s : MathspecialhypergeoGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_special_hypergeo_graphn_max(s : MathspecialhypergeoGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_special_hypergeo_graphn_to_string(s : MathspecialhypergeoGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialhypergeoNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_hypergeo_node_make(size : Int) -> MathspecialhypergeoNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_hypergeo_node_len(s : MathspecialhypergeoNode) -> Int { s.size }

pub fn math_special_hypergeo_node_get(s : MathspecialhypergeoNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_hypergeo_node_set(s : MathspecialhypergeoNode, i : Int, v : Double) -> MathspecialhypergeoNode {
  let result = math_special_hypergeo_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_special_hypergeo_node_sum(s : MathspecialhypergeoNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_special_hypergeo_node_mean(s : MathspecialhypergeoNode) -> Double {
  if s.size == 0 { 0.0 } else { math_special_hypergeo_node_sum(s) / s.size.to_double() }
}

pub fn math_special_hypergeo_node_scale(s : MathspecialhypergeoNode, f : Double) -> MathspecialhypergeoNode {
  let result = math_special_hypergeo_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_special_hypergeo_node_add(a : MathspecialhypergeoNode, b : MathspecialhypergeoNode) -> MathspecialhypergeoNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_special_hypergeo_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_special_hypergeo_node_copy(s : MathspecialhypergeoNode) -> MathspecialhypergeoNode {
  let result = math_special_hypergeo_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_special_hypergeo_node_fill(s : MathspecialhypergeoNode, v : Double) -> MathspecialhypergeoNode {
  let result = math_special_hypergeo_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_special_hypergeo_node_min(s : MathspecialhypergeoNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_special_hypergeo_node_max(s : MathspecialhypergeoNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_special_hypergeo_node_to_string(s : MathspecialhypergeoNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialhypergeoEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_hypergeo_edge_make(size : Int) -> MathspecialhypergeoEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_hypergeo_edge_len(s : MathspecialhypergeoEdge) -> Int { s.size }

pub fn math_special_hypergeo_edge_get(s : MathspecialhypergeoEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_hypergeo_edge_set(s : MathspecialhypergeoEdge, i : Int, v : Double) -> MathspecialhypergeoEdge {
  let result = math_special_hypergeo_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_special_hypergeo_edge_sum(s : MathspecialhypergeoEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_special_hypergeo_edge_mean(s : MathspecialhypergeoEdge) -> Double {
  if s.size == 0 { 0.0 } else { math_special_hypergeo_edge_sum(s) / s.size.to_double() }
}

pub fn math_special_hypergeo_edge_scale(s : MathspecialhypergeoEdge, f : Double) -> MathspecialhypergeoEdge {
  let result = math_special_hypergeo_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_special_hypergeo_edge_add(a : MathspecialhypergeoEdge, b : MathspecialhypergeoEdge) -> MathspecialhypergeoEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_special_hypergeo_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_special_hypergeo_edge_copy(s : MathspecialhypergeoEdge) -> MathspecialhypergeoEdge {
  let result = math_special_hypergeo_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_special_hypergeo_edge_fill(s : MathspecialhypergeoEdge, v : Double) -> MathspecialhypergeoEdge {
  let result = math_special_hypergeo_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_special_hypergeo_edge_min(s : MathspecialhypergeoEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_special_hypergeo_edge_max(s : MathspecialhypergeoEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_special_hypergeo_edge_to_string(s : MathspecialhypergeoEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialhypergeoPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_hypergeo_path_make(size : Int) -> MathspecialhypergeoPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_hypergeo_path_len(s : MathspecialhypergeoPath) -> Int { s.size }

pub fn math_special_hypergeo_path_get(s : MathspecialhypergeoPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_hypergeo_path_set(s : MathspecialhypergeoPath, i : Int, v : Double) -> MathspecialhypergeoPath {
  let result = math_special_hypergeo_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_special_hypergeo_path_sum(s : MathspecialhypergeoPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_special_hypergeo_path_mean(s : MathspecialhypergeoPath) -> Double {
  if s.size == 0 { 0.0 } else { math_special_hypergeo_path_sum(s) / s.size.to_double() }
}

pub fn math_special_hypergeo_path_scale(s : MathspecialhypergeoPath, f : Double) -> MathspecialhypergeoPath {
  let result = math_special_hypergeo_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_special_hypergeo_path_add(a : MathspecialhypergeoPath, b : MathspecialhypergeoPath) -> MathspecialhypergeoPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_special_hypergeo_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_special_hypergeo_path_copy(s : MathspecialhypergeoPath) -> MathspecialhypergeoPath {
  let result = math_special_hypergeo_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_special_hypergeo_path_fill(s : MathspecialhypergeoPath, v : Double) -> MathspecialhypergeoPath {
  let result = math_special_hypergeo_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_special_hypergeo_path_min(s : MathspecialhypergeoPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_special_hypergeo_path_max(s : MathspecialhypergeoPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_special_hypergeo_path_to_string(s : MathspecialhypergeoPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialhypergeoCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_hypergeo_cluster_make(size : Int) -> MathspecialhypergeoCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_hypergeo_cluster_len(s : MathspecialhypergeoCluster) -> Int { s.size }

pub fn math_special_hypergeo_cluster_get(s : MathspecialhypergeoCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_hypergeo_cluster_set(s : MathspecialhypergeoCluster, i : Int, v : Double) -> MathspecialhypergeoCluster {
  let result = math_special_hypergeo_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_special_hypergeo_cluster_sum(s : MathspecialhypergeoCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_special_hypergeo_cluster_mean(s : MathspecialhypergeoCluster) -> Double {
  if s.size == 0 { 0.0 } else { math_special_hypergeo_cluster_sum(s) / s.size.to_double() }
}

pub fn math_special_hypergeo_cluster_scale(s : MathspecialhypergeoCluster, f : Double) -> MathspecialhypergeoCluster {
  let result = math_special_hypergeo_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_special_hypergeo_cluster_add(a : MathspecialhypergeoCluster, b : MathspecialhypergeoCluster) -> MathspecialhypergeoCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_special_hypergeo_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_special_hypergeo_cluster_copy(s : MathspecialhypergeoCluster) -> MathspecialhypergeoCluster {
  let result = math_special_hypergeo_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_special_hypergeo_cluster_fill(s : MathspecialhypergeoCluster, v : Double) -> MathspecialhypergeoCluster {
  let result = math_special_hypergeo_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_special_hypergeo_cluster_min(s : MathspecialhypergeoCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_special_hypergeo_cluster_max(s : MathspecialhypergeoCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_special_hypergeo_cluster_to_string(s : MathspecialhypergeoCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialhypergeoModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_hypergeo_model_make(size : Int) -> MathspecialhypergeoModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_hypergeo_model_len(s : MathspecialhypergeoModel) -> Int { s.size }

pub fn math_special_hypergeo_model_get(s : MathspecialhypergeoModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_hypergeo_model_set(s : MathspecialhypergeoModel, i : Int, v : Double) -> MathspecialhypergeoModel {
  let result = math_special_hypergeo_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_special_hypergeo_model_sum(s : MathspecialhypergeoModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_special_hypergeo_model_mean(s : MathspecialhypergeoModel) -> Double {
  if s.size == 0 { 0.0 } else { math_special_hypergeo_model_sum(s) / s.size.to_double() }
}

pub fn math_special_hypergeo_model_scale(s : MathspecialhypergeoModel, f : Double) -> MathspecialhypergeoModel {
  let result = math_special_hypergeo_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_special_hypergeo_model_add(a : MathspecialhypergeoModel, b : MathspecialhypergeoModel) -> MathspecialhypergeoModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_special_hypergeo_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_special_hypergeo_model_copy(s : MathspecialhypergeoModel) -> MathspecialhypergeoModel {
  let result = math_special_hypergeo_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_special_hypergeo_model_fill(s : MathspecialhypergeoModel, v : Double) -> MathspecialhypergeoModel {
  let result = math_special_hypergeo_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_special_hypergeo_model_min(s : MathspecialhypergeoModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_special_hypergeo_model_max(s : MathspecialhypergeoModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_special_hypergeo_model_to_string(s : MathspecialhypergeoModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialhypergeoLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_hypergeo_layer_make(size : Int) -> MathspecialhypergeoLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_hypergeo_layer_len(s : MathspecialhypergeoLayer) -> Int { s.size }

pub fn math_special_hypergeo_layer_get(s : MathspecialhypergeoLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_hypergeo_layer_set(s : MathspecialhypergeoLayer, i : Int, v : Double) -> MathspecialhypergeoLayer {
  let result = math_special_hypergeo_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_special_hypergeo_layer_sum(s : MathspecialhypergeoLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_special_hypergeo_layer_mean(s : MathspecialhypergeoLayer) -> Double {
  if s.size == 0 { 0.0 } else { math_special_hypergeo_layer_sum(s) / s.size.to_double() }
}

pub fn math_special_hypergeo_layer_scale(s : MathspecialhypergeoLayer, f : Double) -> MathspecialhypergeoLayer {
  let result = math_special_hypergeo_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_special_hypergeo_layer_add(a : MathspecialhypergeoLayer, b : MathspecialhypergeoLayer) -> MathspecialhypergeoLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_special_hypergeo_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_special_hypergeo_layer_copy(s : MathspecialhypergeoLayer) -> MathspecialhypergeoLayer {
  let result = math_special_hypergeo_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_special_hypergeo_layer_fill(s : MathspecialhypergeoLayer, v : Double) -> MathspecialhypergeoLayer {
  let result = math_special_hypergeo_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_special_hypergeo_layer_min(s : MathspecialhypergeoLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_special_hypergeo_layer_max(s : MathspecialhypergeoLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_special_hypergeo_layer_to_string(s : MathspecialhypergeoLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialhypergeoBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_hypergeo_buffer_make(size : Int) -> MathspecialhypergeoBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_hypergeo_buffer_len(s : MathspecialhypergeoBuffer) -> Int { s.size }

pub fn math_special_hypergeo_buffer_get(s : MathspecialhypergeoBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_hypergeo_buffer_set(s : MathspecialhypergeoBuffer, i : Int, v : Double) -> MathspecialhypergeoBuffer {
  let result = math_special_hypergeo_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_special_hypergeo_buffer_sum(s : MathspecialhypergeoBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_special_hypergeo_buffer_mean(s : MathspecialhypergeoBuffer) -> Double {
  if s.size == 0 { 0.0 } else { math_special_hypergeo_buffer_sum(s) / s.size.to_double() }
}

pub fn math_special_hypergeo_buffer_scale(s : MathspecialhypergeoBuffer, f : Double) -> MathspecialhypergeoBuffer {
  let result = math_special_hypergeo_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_special_hypergeo_buffer_add(a : MathspecialhypergeoBuffer, b : MathspecialhypergeoBuffer) -> MathspecialhypergeoBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_special_hypergeo_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_special_hypergeo_buffer_copy(s : MathspecialhypergeoBuffer) -> MathspecialhypergeoBuffer {
  let result = math_special_hypergeo_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_special_hypergeo_buffer_fill(s : MathspecialhypergeoBuffer, v : Double) -> MathspecialhypergeoBuffer {
  let result = math_special_hypergeo_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_special_hypergeo_buffer_min(s : MathspecialhypergeoBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_special_hypergeo_buffer_max(s : MathspecialhypergeoBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_special_hypergeo_buffer_to_string(s : MathspecialhypergeoBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialhypergeoCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_hypergeo_cursor_make(size : Int) -> MathspecialhypergeoCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_hypergeo_cursor_len(s : MathspecialhypergeoCursor) -> Int { s.size }

pub fn math_special_hypergeo_cursor_get(s : MathspecialhypergeoCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_hypergeo_cursor_set(s : MathspecialhypergeoCursor, i : Int, v : Double) -> MathspecialhypergeoCursor {
  let result = math_special_hypergeo_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_special_hypergeo_cursor_sum(s : MathspecialhypergeoCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_special_hypergeo_cursor_mean(s : MathspecialhypergeoCursor) -> Double {
  if s.size == 0 { 0.0 } else { math_special_hypergeo_cursor_sum(s) / s.size.to_double() }
}

pub fn math_special_hypergeo_cursor_scale(s : MathspecialhypergeoCursor, f : Double) -> MathspecialhypergeoCursor {
  let result = math_special_hypergeo_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_special_hypergeo_cursor_add(a : MathspecialhypergeoCursor, b : MathspecialhypergeoCursor) -> MathspecialhypergeoCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_special_hypergeo_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_special_hypergeo_cursor_copy(s : MathspecialhypergeoCursor) -> MathspecialhypergeoCursor {
  let result = math_special_hypergeo_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_special_hypergeo_cursor_fill(s : MathspecialhypergeoCursor, v : Double) -> MathspecialhypergeoCursor {
  let result = math_special_hypergeo_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_special_hypergeo_cursor_min(s : MathspecialhypergeoCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_special_hypergeo_cursor_max(s : MathspecialhypergeoCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_special_hypergeo_cursor_to_string(s : MathspecialhypergeoCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialhypergeoView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_hypergeo_view_make(size : Int) -> MathspecialhypergeoView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_hypergeo_view_len(s : MathspecialhypergeoView) -> Int { s.size }

pub fn math_special_hypergeo_view_get(s : MathspecialhypergeoView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_hypergeo_view_set(s : MathspecialhypergeoView, i : Int, v : Double) -> MathspecialhypergeoView {
  let result = math_special_hypergeo_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_special_hypergeo_view_sum(s : MathspecialhypergeoView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_special_hypergeo_view_mean(s : MathspecialhypergeoView) -> Double {
  if s.size == 0 { 0.0 } else { math_special_hypergeo_view_sum(s) / s.size.to_double() }
}

pub fn math_special_hypergeo_view_scale(s : MathspecialhypergeoView, f : Double) -> MathspecialhypergeoView {
  let result = math_special_hypergeo_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_special_hypergeo_view_add(a : MathspecialhypergeoView, b : MathspecialhypergeoView) -> MathspecialhypergeoView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_special_hypergeo_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_special_hypergeo_view_copy(s : MathspecialhypergeoView) -> MathspecialhypergeoView {
  let result = math_special_hypergeo_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_special_hypergeo_view_fill(s : MathspecialhypergeoView, v : Double) -> MathspecialhypergeoView {
  let result = math_special_hypergeo_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_special_hypergeo_view_min(s : MathspecialhypergeoView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_special_hypergeo_view_max(s : MathspecialhypergeoView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_special_hypergeo_view_to_string(s : MathspecialhypergeoView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialhypergeoRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_hypergeo_range_make(size : Int) -> MathspecialhypergeoRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_hypergeo_range_len(s : MathspecialhypergeoRange) -> Int { s.size }

pub fn math_special_hypergeo_range_get(s : MathspecialhypergeoRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_hypergeo_range_set(s : MathspecialhypergeoRange, i : Int, v : Double) -> MathspecialhypergeoRange {
  let result = math_special_hypergeo_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_special_hypergeo_range_sum(s : MathspecialhypergeoRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_special_hypergeo_range_mean(s : MathspecialhypergeoRange) -> Double {
  if s.size == 0 { 0.0 } else { math_special_hypergeo_range_sum(s) / s.size.to_double() }
}

pub fn math_special_hypergeo_range_scale(s : MathspecialhypergeoRange, f : Double) -> MathspecialhypergeoRange {
  let result = math_special_hypergeo_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_special_hypergeo_range_add(a : MathspecialhypergeoRange, b : MathspecialhypergeoRange) -> MathspecialhypergeoRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_special_hypergeo_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_special_hypergeo_range_copy(s : MathspecialhypergeoRange) -> MathspecialhypergeoRange {
  let result = math_special_hypergeo_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_special_hypergeo_range_fill(s : MathspecialhypergeoRange, v : Double) -> MathspecialhypergeoRange {
  let result = math_special_hypergeo_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_special_hypergeo_range_min(s : MathspecialhypergeoRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_special_hypergeo_range_max(s : MathspecialhypergeoRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_special_hypergeo_range_to_string(s : MathspecialhypergeoRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialhypergeoSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_hypergeo_slice_make(size : Int) -> MathspecialhypergeoSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_hypergeo_slice_len(s : MathspecialhypergeoSlice) -> Int { s.size }

pub fn math_special_hypergeo_slice_get(s : MathspecialhypergeoSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_hypergeo_slice_set(s : MathspecialhypergeoSlice, i : Int, v : Double) -> MathspecialhypergeoSlice {
  let result = math_special_hypergeo_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_special_hypergeo_slice_sum(s : MathspecialhypergeoSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_special_hypergeo_slice_mean(s : MathspecialhypergeoSlice) -> Double {
  if s.size == 0 { 0.0 } else { math_special_hypergeo_slice_sum(s) / s.size.to_double() }
}

pub fn math_special_hypergeo_slice_scale(s : MathspecialhypergeoSlice, f : Double) -> MathspecialhypergeoSlice {
  let result = math_special_hypergeo_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_special_hypergeo_slice_add(a : MathspecialhypergeoSlice, b : MathspecialhypergeoSlice) -> MathspecialhypergeoSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_special_hypergeo_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_special_hypergeo_slice_copy(s : MathspecialhypergeoSlice) -> MathspecialhypergeoSlice {
  let result = math_special_hypergeo_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_special_hypergeo_slice_fill(s : MathspecialhypergeoSlice, v : Double) -> MathspecialhypergeoSlice {
  let result = math_special_hypergeo_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_special_hypergeo_slice_min(s : MathspecialhypergeoSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_special_hypergeo_slice_max(s : MathspecialhypergeoSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_special_hypergeo_slice_to_string(s : MathspecialhypergeoSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

