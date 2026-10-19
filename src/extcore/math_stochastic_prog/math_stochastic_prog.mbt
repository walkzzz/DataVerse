///===
/// extcore/math_stochastic_prog

pub(all) struct MathstochasticprogPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn math_stochastic_prog_make_point(x : Double, y : Double) -> MathstochasticprogPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn math_stochastic_prog_make_point3(x : Double, y : Double, z : Double) -> MathstochasticprogPoint {
  { x, y, z, label: 0 }
}

pub fn math_stochastic_prog_point_x(pt : MathstochasticprogPoint) -> Double { pt.x }

pub fn math_stochastic_prog_point_y(pt : MathstochasticprogPoint) -> Double { pt.y }

pub fn math_stochastic_prog_point_z(pt : MathstochasticprogPoint) -> Double { pt.z }

pub fn math_stochastic_prog_point_label(pt : MathstochasticprogPoint) -> Int { pt.label }

pub fn math_stochastic_prog_point_dist(a : MathstochasticprogPoint, b : MathstochasticprogPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn math_stochastic_prog_point_add(a : MathstochasticprogPoint, b : MathstochasticprogPoint) -> MathstochasticprogPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn math_stochastic_prog_point_sub(a : MathstochasticprogPoint, b : MathstochasticprogPoint) -> MathstochasticprogPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn math_stochastic_prog_point_scale(pt : MathstochasticprogPoint, s : Double) -> MathstochasticprogPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn math_stochastic_prog_point_dot(a : MathstochasticprogPoint, b : MathstochasticprogPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn math_stochastic_prog_point_cross(a : MathstochasticprogPoint, b : MathstochasticprogPoint) -> MathstochasticprogPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn math_stochastic_prog_point_norm(pt : MathstochasticprogPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn math_stochastic_prog_point_normalize(pt : MathstochasticprogPoint) -> MathstochasticprogPoint {
  let n = math_stochastic_prog_point_norm(pt)
  if n < 0.0000001 { pt } else { math_stochastic_prog_point_scale(pt, 1.0 / n) }
}

pub fn math_stochastic_prog_point_negate(pt : MathstochasticprogPoint) -> MathstochasticprogPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn math_stochastic_prog_point_mid(a : MathstochasticprogPoint, b : MathstochasticprogPoint) -> MathstochasticprogPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn math_stochastic_prog_point_lerp(a : MathstochasticprogPoint, b : MathstochasticprogPoint, t : Double) -> MathstochasticprogPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn math_stochastic_prog_point_to_string(pt : MathstochasticprogPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct MathstochasticprogSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn math_stochastic_prog_make_series(vals : Array[Double], name : String) -> MathstochasticprogSeries {
  { vals, name, meta: 0 }
}

pub fn math_stochastic_prog_series_len(s : MathstochasticprogSeries) -> Int { s.vals.length() }

pub fn math_stochastic_prog_series_sum(s : MathstochasticprogSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn math_stochastic_prog_series_mean(s : MathstochasticprogSeries) -> Double {
  let n = math_stochastic_prog_series_len(s)
  if n == 0 { 0.0 } else { math_stochastic_prog_series_sum(s) / n.to_double() }
}

pub fn math_stochastic_prog_series_min(s : MathstochasticprogSeries) -> Double {
  let n = math_stochastic_prog_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn math_stochastic_prog_series_max(s : MathstochasticprogSeries) -> Double {
  let n = math_stochastic_prog_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn math_stochastic_prog_series_range(s : MathstochasticprogSeries) -> Double {
  math_stochastic_prog_series_max(s) - math_stochastic_prog_series_min(s)
}

pub fn math_stochastic_prog_series_var(s : MathstochasticprogSeries) -> Double {
  let n = math_stochastic_prog_series_len(s)
  if n == 0 { 0.0 } else {
    let m = math_stochastic_prog_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn math_stochastic_prog_series_std(s : MathstochasticprogSeries) -> Double { @_common.sqrt(math_stochastic_prog_series_var(s)) }

pub fn math_stochastic_prog_series_median(s : MathstochasticprogSeries) -> Double {
  let n = math_stochastic_prog_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = math_stochastic_prog_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn math_stochastic_prog_series_scale(s : MathstochasticprogSeries, f : Double) -> MathstochasticprogSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn math_stochastic_prog_series_add(a : MathstochasticprogSeries, b : MathstochasticprogSeries) -> MathstochasticprogSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn math_stochastic_prog_series_sub(a : MathstochasticprogSeries, b : MathstochasticprogSeries) -> MathstochasticprogSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn math_stochastic_prog_series_normalize(s : MathstochasticprogSeries) -> MathstochasticprogSeries {
  let mn = math_stochastic_prog_series_min(s)
  let mx = math_stochastic_prog_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn math_stochastic_prog_series_cumsum(s : MathstochasticprogSeries) -> MathstochasticprogSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn math_stochastic_prog_series_to_string(s : MathstochasticprogSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MathstochasticprogMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn math_stochastic_prog_make_matrix(rows : Int, cols : Int, val : Double) -> MathstochasticprogMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn math_stochastic_prog_matrix_identity(n : Int) -> MathstochasticprogMatrix {
  let m = math_stochastic_prog_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn math_stochastic_prog_matrix_get(m : MathstochasticprogMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn math_stochastic_prog_matrix_transpose(m : MathstochasticprogMatrix) -> MathstochasticprogMatrix {
  let result = math_stochastic_prog_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn math_stochastic_prog_matrix_add(a : MathstochasticprogMatrix, b : MathstochasticprogMatrix) -> MathstochasticprogMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = math_stochastic_prog_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn math_stochastic_prog_matrix_scale(m : MathstochasticprogMatrix, s : Double) -> MathstochasticprogMatrix {
  let result = math_stochastic_prog_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn math_stochastic_prog_matrix_multiply(a : MathstochasticprogMatrix, b : MathstochasticprogMatrix) -> MathstochasticprogMatrix {
  if a.cols != b.rows { return math_stochastic_prog_make_matrix(a.rows, b.cols, 0.0) }
  let result = math_stochastic_prog_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn math_stochastic_prog_matrix_trace(m : MathstochasticprogMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn math_stochastic_prog_matrix_det(m : MathstochasticprogMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn math_stochastic_prog_matrix_norm(m : MathstochasticprogMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn math_stochastic_prog_matrix_to_string(m : MathstochasticprogMatrix) -> String {
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

pub(all) struct MathstochasticprogVector {
  comps : Array[Double]
  dim : Int
}

pub fn math_stochastic_prog_make_vector(comps : Array[Double]) -> MathstochasticprogVector {
  { comps, dim: comps.length() }
}

pub fn math_stochastic_prog_vector_zero(dim : Int) -> MathstochasticprogVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn math_stochastic_prog_vector_add(a : MathstochasticprogVector, b : MathstochasticprogVector) -> MathstochasticprogVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn math_stochastic_prog_vector_sub(a : MathstochasticprogVector, b : MathstochasticprogVector) -> MathstochasticprogVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn math_stochastic_prog_vector_scale(v : MathstochasticprogVector, s : Double) -> MathstochasticprogVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn math_stochastic_prog_vector_dot(a : MathstochasticprogVector, b : MathstochasticprogVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn math_stochastic_prog_vector_norm(v : MathstochasticprogVector) -> Double { @_common.sqrt(math_stochastic_prog_vector_dot(v, v)) }

pub fn math_stochastic_prog_vector_normalize(v : MathstochasticprogVector) -> MathstochasticprogVector {
  let n = math_stochastic_prog_vector_norm(v)
  if n < 0.0000001 { v } else { math_stochastic_prog_vector_scale(v, 1.0 / n) }
}

pub fn math_stochastic_prog_vector_dist(a : MathstochasticprogVector, b : MathstochasticprogVector) -> Double {
  math_stochastic_prog_vector_norm(math_stochastic_prog_vector_sub(a, b))
}

pub fn math_stochastic_prog_vector_to_string(v : MathstochasticprogVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn math_stochastic_prog_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn math_stochastic_prog_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = math_stochastic_prog_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn math_stochastic_prog_std(data : Array[Double]) -> Double { @_common.sqrt(math_stochastic_prog_var(data)) }

pub fn math_stochastic_prog_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = math_stochastic_prog_mean(a); let mb = math_stochastic_prog_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn math_stochastic_prog_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = math_stochastic_prog_std(a); let sb = math_stochastic_prog_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { math_stochastic_prog_cov(a, b) / (sa * sb) }
}

pub fn math_stochastic_prog_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = math_stochastic_prog_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn math_stochastic_prog_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn math_stochastic_prog_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn math_stochastic_prog_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  @_common.sqrt(math_stochastic_prog_mse(pred, labels))
}

pub fn math_stochastic_prog_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn math_stochastic_prog_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = math_stochastic_prog_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn math_stochastic_prog_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn math_stochastic_prog_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn math_stochastic_prog_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = math_stochastic_prog_precision(pred, labels, pos); let r = math_stochastic_prog_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn math_stochastic_prog_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn math_stochastic_prog_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = math_stochastic_prog_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn math_stochastic_prog_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn math_stochastic_prog_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn math_stochastic_prog_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = math_stochastic_prog_gcd(a, b)
    (a / g) * b
  }
}

pub fn math_stochastic_prog_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn math_stochastic_prog_fibonacci(n : Int) -> Int {
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

pub fn math_stochastic_prog_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = math_stochastic_prog_min(data); let mx = math_stochastic_prog_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn math_stochastic_prog_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = math_stochastic_prog_mean(data); let sd = math_stochastic_prog_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn math_stochastic_prog_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn math_stochastic_prog_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn math_stochastic_prog_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn math_stochastic_prog_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn math_stochastic_prog_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn math_stochastic_prog_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

pub(all) struct MathstochasticprogFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_stochastic_prog_frame_make(size : Int) -> MathstochasticprogFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_stochastic_prog_frame_len(s : MathstochasticprogFrame) -> Int { s.size }

pub fn math_stochastic_prog_frame_get(s : MathstochasticprogFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_stochastic_prog_frame_set(s : MathstochasticprogFrame, i : Int, v : Double) -> MathstochasticprogFrame {
  let result = math_stochastic_prog_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_stochastic_prog_frame_sum(s : MathstochasticprogFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_stochastic_prog_frame_mean(s : MathstochasticprogFrame) -> Double {
  if s.size == 0 { 0.0 } else { math_stochastic_prog_frame_sum(s) / s.size.to_double() }
}

pub fn math_stochastic_prog_frame_scale(s : MathstochasticprogFrame, f : Double) -> MathstochasticprogFrame {
  let result = math_stochastic_prog_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_stochastic_prog_frame_add(a : MathstochasticprogFrame, b : MathstochasticprogFrame) -> MathstochasticprogFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_stochastic_prog_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_stochastic_prog_frame_copy(s : MathstochasticprogFrame) -> MathstochasticprogFrame {
  let result = math_stochastic_prog_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_stochastic_prog_frame_fill(s : MathstochasticprogFrame, v : Double) -> MathstochasticprogFrame {
  let result = math_stochastic_prog_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_stochastic_prog_frame_min(s : MathstochasticprogFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_stochastic_prog_frame_max(s : MathstochasticprogFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_stochastic_prog_frame_to_string(s : MathstochasticprogFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathstochasticprogTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_stochastic_prog_table_make(size : Int) -> MathstochasticprogTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_stochastic_prog_table_len(s : MathstochasticprogTable) -> Int { s.size }

pub fn math_stochastic_prog_table_get(s : MathstochasticprogTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_stochastic_prog_table_set(s : MathstochasticprogTable, i : Int, v : Double) -> MathstochasticprogTable {
  let result = math_stochastic_prog_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_stochastic_prog_table_sum(s : MathstochasticprogTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_stochastic_prog_table_mean(s : MathstochasticprogTable) -> Double {
  if s.size == 0 { 0.0 } else { math_stochastic_prog_table_sum(s) / s.size.to_double() }
}

pub fn math_stochastic_prog_table_scale(s : MathstochasticprogTable, f : Double) -> MathstochasticprogTable {
  let result = math_stochastic_prog_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_stochastic_prog_table_add(a : MathstochasticprogTable, b : MathstochasticprogTable) -> MathstochasticprogTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_stochastic_prog_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_stochastic_prog_table_copy(s : MathstochasticprogTable) -> MathstochasticprogTable {
  let result = math_stochastic_prog_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_stochastic_prog_table_fill(s : MathstochasticprogTable, v : Double) -> MathstochasticprogTable {
  let result = math_stochastic_prog_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_stochastic_prog_table_min(s : MathstochasticprogTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_stochastic_prog_table_max(s : MathstochasticprogTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_stochastic_prog_table_to_string(s : MathstochasticprogTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathstochasticprogGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_stochastic_prog_graphn_make(size : Int) -> MathstochasticprogGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_stochastic_prog_graphn_len(s : MathstochasticprogGraphN) -> Int { s.size }

pub fn math_stochastic_prog_graphn_get(s : MathstochasticprogGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_stochastic_prog_graphn_set(s : MathstochasticprogGraphN, i : Int, v : Double) -> MathstochasticprogGraphN {
  let result = math_stochastic_prog_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_stochastic_prog_graphn_sum(s : MathstochasticprogGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_stochastic_prog_graphn_mean(s : MathstochasticprogGraphN) -> Double {
  if s.size == 0 { 0.0 } else { math_stochastic_prog_graphn_sum(s) / s.size.to_double() }
}

pub fn math_stochastic_prog_graphn_scale(s : MathstochasticprogGraphN, f : Double) -> MathstochasticprogGraphN {
  let result = math_stochastic_prog_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_stochastic_prog_graphn_add(a : MathstochasticprogGraphN, b : MathstochasticprogGraphN) -> MathstochasticprogGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_stochastic_prog_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_stochastic_prog_graphn_copy(s : MathstochasticprogGraphN) -> MathstochasticprogGraphN {
  let result = math_stochastic_prog_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_stochastic_prog_graphn_fill(s : MathstochasticprogGraphN, v : Double) -> MathstochasticprogGraphN {
  let result = math_stochastic_prog_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_stochastic_prog_graphn_min(s : MathstochasticprogGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_stochastic_prog_graphn_max(s : MathstochasticprogGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_stochastic_prog_graphn_to_string(s : MathstochasticprogGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathstochasticprogNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_stochastic_prog_node_make(size : Int) -> MathstochasticprogNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_stochastic_prog_node_len(s : MathstochasticprogNode) -> Int { s.size }

pub fn math_stochastic_prog_node_get(s : MathstochasticprogNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_stochastic_prog_node_set(s : MathstochasticprogNode, i : Int, v : Double) -> MathstochasticprogNode {
  let result = math_stochastic_prog_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_stochastic_prog_node_sum(s : MathstochasticprogNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_stochastic_prog_node_mean(s : MathstochasticprogNode) -> Double {
  if s.size == 0 { 0.0 } else { math_stochastic_prog_node_sum(s) / s.size.to_double() }
}

pub fn math_stochastic_prog_node_scale(s : MathstochasticprogNode, f : Double) -> MathstochasticprogNode {
  let result = math_stochastic_prog_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_stochastic_prog_node_add(a : MathstochasticprogNode, b : MathstochasticprogNode) -> MathstochasticprogNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_stochastic_prog_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_stochastic_prog_node_copy(s : MathstochasticprogNode) -> MathstochasticprogNode {
  let result = math_stochastic_prog_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_stochastic_prog_node_fill(s : MathstochasticprogNode, v : Double) -> MathstochasticprogNode {
  let result = math_stochastic_prog_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_stochastic_prog_node_min(s : MathstochasticprogNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_stochastic_prog_node_max(s : MathstochasticprogNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_stochastic_prog_node_to_string(s : MathstochasticprogNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathstochasticprogEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_stochastic_prog_edge_make(size : Int) -> MathstochasticprogEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_stochastic_prog_edge_len(s : MathstochasticprogEdge) -> Int { s.size }

pub fn math_stochastic_prog_edge_get(s : MathstochasticprogEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_stochastic_prog_edge_set(s : MathstochasticprogEdge, i : Int, v : Double) -> MathstochasticprogEdge {
  let result = math_stochastic_prog_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_stochastic_prog_edge_sum(s : MathstochasticprogEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_stochastic_prog_edge_mean(s : MathstochasticprogEdge) -> Double {
  if s.size == 0 { 0.0 } else { math_stochastic_prog_edge_sum(s) / s.size.to_double() }
}

pub fn math_stochastic_prog_edge_scale(s : MathstochasticprogEdge, f : Double) -> MathstochasticprogEdge {
  let result = math_stochastic_prog_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_stochastic_prog_edge_add(a : MathstochasticprogEdge, b : MathstochasticprogEdge) -> MathstochasticprogEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_stochastic_prog_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_stochastic_prog_edge_copy(s : MathstochasticprogEdge) -> MathstochasticprogEdge {
  let result = math_stochastic_prog_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_stochastic_prog_edge_fill(s : MathstochasticprogEdge, v : Double) -> MathstochasticprogEdge {
  let result = math_stochastic_prog_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_stochastic_prog_edge_min(s : MathstochasticprogEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_stochastic_prog_edge_max(s : MathstochasticprogEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_stochastic_prog_edge_to_string(s : MathstochasticprogEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathstochasticprogPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_stochastic_prog_path_make(size : Int) -> MathstochasticprogPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_stochastic_prog_path_len(s : MathstochasticprogPath) -> Int { s.size }

pub fn math_stochastic_prog_path_get(s : MathstochasticprogPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_stochastic_prog_path_set(s : MathstochasticprogPath, i : Int, v : Double) -> MathstochasticprogPath {
  let result = math_stochastic_prog_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_stochastic_prog_path_sum(s : MathstochasticprogPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_stochastic_prog_path_mean(s : MathstochasticprogPath) -> Double {
  if s.size == 0 { 0.0 } else { math_stochastic_prog_path_sum(s) / s.size.to_double() }
}

pub fn math_stochastic_prog_path_scale(s : MathstochasticprogPath, f : Double) -> MathstochasticprogPath {
  let result = math_stochastic_prog_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_stochastic_prog_path_add(a : MathstochasticprogPath, b : MathstochasticprogPath) -> MathstochasticprogPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_stochastic_prog_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_stochastic_prog_path_copy(s : MathstochasticprogPath) -> MathstochasticprogPath {
  let result = math_stochastic_prog_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_stochastic_prog_path_fill(s : MathstochasticprogPath, v : Double) -> MathstochasticprogPath {
  let result = math_stochastic_prog_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_stochastic_prog_path_min(s : MathstochasticprogPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_stochastic_prog_path_max(s : MathstochasticprogPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_stochastic_prog_path_to_string(s : MathstochasticprogPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathstochasticprogCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_stochastic_prog_cluster_make(size : Int) -> MathstochasticprogCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_stochastic_prog_cluster_len(s : MathstochasticprogCluster) -> Int { s.size }

pub fn math_stochastic_prog_cluster_get(s : MathstochasticprogCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_stochastic_prog_cluster_set(s : MathstochasticprogCluster, i : Int, v : Double) -> MathstochasticprogCluster {
  let result = math_stochastic_prog_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_stochastic_prog_cluster_sum(s : MathstochasticprogCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_stochastic_prog_cluster_mean(s : MathstochasticprogCluster) -> Double {
  if s.size == 0 { 0.0 } else { math_stochastic_prog_cluster_sum(s) / s.size.to_double() }
}

pub fn math_stochastic_prog_cluster_scale(s : MathstochasticprogCluster, f : Double) -> MathstochasticprogCluster {
  let result = math_stochastic_prog_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_stochastic_prog_cluster_add(a : MathstochasticprogCluster, b : MathstochasticprogCluster) -> MathstochasticprogCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_stochastic_prog_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_stochastic_prog_cluster_copy(s : MathstochasticprogCluster) -> MathstochasticprogCluster {
  let result = math_stochastic_prog_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_stochastic_prog_cluster_fill(s : MathstochasticprogCluster, v : Double) -> MathstochasticprogCluster {
  let result = math_stochastic_prog_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_stochastic_prog_cluster_min(s : MathstochasticprogCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_stochastic_prog_cluster_max(s : MathstochasticprogCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_stochastic_prog_cluster_to_string(s : MathstochasticprogCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathstochasticprogModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_stochastic_prog_model_make(size : Int) -> MathstochasticprogModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_stochastic_prog_model_len(s : MathstochasticprogModel) -> Int { s.size }

pub fn math_stochastic_prog_model_get(s : MathstochasticprogModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_stochastic_prog_model_set(s : MathstochasticprogModel, i : Int, v : Double) -> MathstochasticprogModel {
  let result = math_stochastic_prog_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_stochastic_prog_model_sum(s : MathstochasticprogModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_stochastic_prog_model_mean(s : MathstochasticprogModel) -> Double {
  if s.size == 0 { 0.0 } else { math_stochastic_prog_model_sum(s) / s.size.to_double() }
}

pub fn math_stochastic_prog_model_scale(s : MathstochasticprogModel, f : Double) -> MathstochasticprogModel {
  let result = math_stochastic_prog_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_stochastic_prog_model_add(a : MathstochasticprogModel, b : MathstochasticprogModel) -> MathstochasticprogModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_stochastic_prog_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_stochastic_prog_model_copy(s : MathstochasticprogModel) -> MathstochasticprogModel {
  let result = math_stochastic_prog_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_stochastic_prog_model_fill(s : MathstochasticprogModel, v : Double) -> MathstochasticprogModel {
  let result = math_stochastic_prog_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_stochastic_prog_model_min(s : MathstochasticprogModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_stochastic_prog_model_max(s : MathstochasticprogModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_stochastic_prog_model_to_string(s : MathstochasticprogModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathstochasticprogLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_stochastic_prog_layer_make(size : Int) -> MathstochasticprogLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_stochastic_prog_layer_len(s : MathstochasticprogLayer) -> Int { s.size }

pub fn math_stochastic_prog_layer_get(s : MathstochasticprogLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_stochastic_prog_layer_set(s : MathstochasticprogLayer, i : Int, v : Double) -> MathstochasticprogLayer {
  let result = math_stochastic_prog_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_stochastic_prog_layer_sum(s : MathstochasticprogLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_stochastic_prog_layer_mean(s : MathstochasticprogLayer) -> Double {
  if s.size == 0 { 0.0 } else { math_stochastic_prog_layer_sum(s) / s.size.to_double() }
}

pub fn math_stochastic_prog_layer_scale(s : MathstochasticprogLayer, f : Double) -> MathstochasticprogLayer {
  let result = math_stochastic_prog_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_stochastic_prog_layer_add(a : MathstochasticprogLayer, b : MathstochasticprogLayer) -> MathstochasticprogLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_stochastic_prog_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_stochastic_prog_layer_copy(s : MathstochasticprogLayer) -> MathstochasticprogLayer {
  let result = math_stochastic_prog_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_stochastic_prog_layer_fill(s : MathstochasticprogLayer, v : Double) -> MathstochasticprogLayer {
  let result = math_stochastic_prog_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_stochastic_prog_layer_min(s : MathstochasticprogLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_stochastic_prog_layer_max(s : MathstochasticprogLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_stochastic_prog_layer_to_string(s : MathstochasticprogLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathstochasticprogBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_stochastic_prog_buffer_make(size : Int) -> MathstochasticprogBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_stochastic_prog_buffer_len(s : MathstochasticprogBuffer) -> Int { s.size }

pub fn math_stochastic_prog_buffer_get(s : MathstochasticprogBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_stochastic_prog_buffer_set(s : MathstochasticprogBuffer, i : Int, v : Double) -> MathstochasticprogBuffer {
  let result = math_stochastic_prog_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_stochastic_prog_buffer_sum(s : MathstochasticprogBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_stochastic_prog_buffer_mean(s : MathstochasticprogBuffer) -> Double {
  if s.size == 0 { 0.0 } else { math_stochastic_prog_buffer_sum(s) / s.size.to_double() }
}

pub fn math_stochastic_prog_buffer_scale(s : MathstochasticprogBuffer, f : Double) -> MathstochasticprogBuffer {
  let result = math_stochastic_prog_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_stochastic_prog_buffer_add(a : MathstochasticprogBuffer, b : MathstochasticprogBuffer) -> MathstochasticprogBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_stochastic_prog_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_stochastic_prog_buffer_copy(s : MathstochasticprogBuffer) -> MathstochasticprogBuffer {
  let result = math_stochastic_prog_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_stochastic_prog_buffer_fill(s : MathstochasticprogBuffer, v : Double) -> MathstochasticprogBuffer {
  let result = math_stochastic_prog_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_stochastic_prog_buffer_min(s : MathstochasticprogBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_stochastic_prog_buffer_max(s : MathstochasticprogBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_stochastic_prog_buffer_to_string(s : MathstochasticprogBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathstochasticprogCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_stochastic_prog_cursor_make(size : Int) -> MathstochasticprogCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_stochastic_prog_cursor_len(s : MathstochasticprogCursor) -> Int { s.size }

pub fn math_stochastic_prog_cursor_get(s : MathstochasticprogCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_stochastic_prog_cursor_set(s : MathstochasticprogCursor, i : Int, v : Double) -> MathstochasticprogCursor {
  let result = math_stochastic_prog_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_stochastic_prog_cursor_sum(s : MathstochasticprogCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_stochastic_prog_cursor_mean(s : MathstochasticprogCursor) -> Double {
  if s.size == 0 { 0.0 } else { math_stochastic_prog_cursor_sum(s) / s.size.to_double() }
}

pub fn math_stochastic_prog_cursor_scale(s : MathstochasticprogCursor, f : Double) -> MathstochasticprogCursor {
  let result = math_stochastic_prog_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_stochastic_prog_cursor_add(a : MathstochasticprogCursor, b : MathstochasticprogCursor) -> MathstochasticprogCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_stochastic_prog_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_stochastic_prog_cursor_copy(s : MathstochasticprogCursor) -> MathstochasticprogCursor {
  let result = math_stochastic_prog_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_stochastic_prog_cursor_fill(s : MathstochasticprogCursor, v : Double) -> MathstochasticprogCursor {
  let result = math_stochastic_prog_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_stochastic_prog_cursor_min(s : MathstochasticprogCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_stochastic_prog_cursor_max(s : MathstochasticprogCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_stochastic_prog_cursor_to_string(s : MathstochasticprogCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathstochasticprogView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_stochastic_prog_view_make(size : Int) -> MathstochasticprogView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_stochastic_prog_view_len(s : MathstochasticprogView) -> Int { s.size }

pub fn math_stochastic_prog_view_get(s : MathstochasticprogView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_stochastic_prog_view_set(s : MathstochasticprogView, i : Int, v : Double) -> MathstochasticprogView {
  let result = math_stochastic_prog_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_stochastic_prog_view_sum(s : MathstochasticprogView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_stochastic_prog_view_mean(s : MathstochasticprogView) -> Double {
  if s.size == 0 { 0.0 } else { math_stochastic_prog_view_sum(s) / s.size.to_double() }
}

pub fn math_stochastic_prog_view_scale(s : MathstochasticprogView, f : Double) -> MathstochasticprogView {
  let result = math_stochastic_prog_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_stochastic_prog_view_add(a : MathstochasticprogView, b : MathstochasticprogView) -> MathstochasticprogView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_stochastic_prog_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_stochastic_prog_view_copy(s : MathstochasticprogView) -> MathstochasticprogView {
  let result = math_stochastic_prog_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_stochastic_prog_view_fill(s : MathstochasticprogView, v : Double) -> MathstochasticprogView {
  let result = math_stochastic_prog_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_stochastic_prog_view_min(s : MathstochasticprogView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_stochastic_prog_view_max(s : MathstochasticprogView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_stochastic_prog_view_to_string(s : MathstochasticprogView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathstochasticprogRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_stochastic_prog_range_make(size : Int) -> MathstochasticprogRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_stochastic_prog_range_len(s : MathstochasticprogRange) -> Int { s.size }

pub fn math_stochastic_prog_range_get(s : MathstochasticprogRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_stochastic_prog_range_set(s : MathstochasticprogRange, i : Int, v : Double) -> MathstochasticprogRange {
  let result = math_stochastic_prog_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_stochastic_prog_range_sum(s : MathstochasticprogRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_stochastic_prog_range_mean(s : MathstochasticprogRange) -> Double {
  if s.size == 0 { 0.0 } else { math_stochastic_prog_range_sum(s) / s.size.to_double() }
}

pub fn math_stochastic_prog_range_scale(s : MathstochasticprogRange, f : Double) -> MathstochasticprogRange {
  let result = math_stochastic_prog_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_stochastic_prog_range_add(a : MathstochasticprogRange, b : MathstochasticprogRange) -> MathstochasticprogRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_stochastic_prog_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_stochastic_prog_range_copy(s : MathstochasticprogRange) -> MathstochasticprogRange {
  let result = math_stochastic_prog_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_stochastic_prog_range_fill(s : MathstochasticprogRange, v : Double) -> MathstochasticprogRange {
  let result = math_stochastic_prog_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_stochastic_prog_range_min(s : MathstochasticprogRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_stochastic_prog_range_max(s : MathstochasticprogRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_stochastic_prog_range_to_string(s : MathstochasticprogRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathstochasticprogSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_stochastic_prog_slice_make(size : Int) -> MathstochasticprogSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_stochastic_prog_slice_len(s : MathstochasticprogSlice) -> Int { s.size }

pub fn math_stochastic_prog_slice_get(s : MathstochasticprogSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_stochastic_prog_slice_set(s : MathstochasticprogSlice, i : Int, v : Double) -> MathstochasticprogSlice {
  let result = math_stochastic_prog_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_stochastic_prog_slice_sum(s : MathstochasticprogSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_stochastic_prog_slice_mean(s : MathstochasticprogSlice) -> Double {
  if s.size == 0 { 0.0 } else { math_stochastic_prog_slice_sum(s) / s.size.to_double() }
}

pub fn math_stochastic_prog_slice_scale(s : MathstochasticprogSlice, f : Double) -> MathstochasticprogSlice {
  let result = math_stochastic_prog_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_stochastic_prog_slice_add(a : MathstochasticprogSlice, b : MathstochasticprogSlice) -> MathstochasticprogSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_stochastic_prog_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_stochastic_prog_slice_copy(s : MathstochasticprogSlice) -> MathstochasticprogSlice {
  let result = math_stochastic_prog_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_stochastic_prog_slice_fill(s : MathstochasticprogSlice, v : Double) -> MathstochasticprogSlice {
  let result = math_stochastic_prog_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_stochastic_prog_slice_min(s : MathstochasticprogSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_stochastic_prog_slice_max(s : MathstochasticprogSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_stochastic_prog_slice_to_string(s : MathstochasticprogSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

