///===
/// extcore/math_special_laguerre

pub(all) struct MathspeciallaguerrePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn math_special_laguerre_make_point(x : Double, y : Double) -> MathspeciallaguerrePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn math_special_laguerre_make_point3(x : Double, y : Double, z : Double) -> MathspeciallaguerrePoint {
  { x, y, z, label: 0 }
}

pub fn math_special_laguerre_point_x(pt : MathspeciallaguerrePoint) -> Double { pt.x }

pub fn math_special_laguerre_point_y(pt : MathspeciallaguerrePoint) -> Double { pt.y }

pub fn math_special_laguerre_point_z(pt : MathspeciallaguerrePoint) -> Double { pt.z }

pub fn math_special_laguerre_point_label(pt : MathspeciallaguerrePoint) -> Int { pt.label }

pub fn math_special_laguerre_point_dist(a : MathspeciallaguerrePoint, b : MathspeciallaguerrePoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn math_special_laguerre_point_add(a : MathspeciallaguerrePoint, b : MathspeciallaguerrePoint) -> MathspeciallaguerrePoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn math_special_laguerre_point_sub(a : MathspeciallaguerrePoint, b : MathspeciallaguerrePoint) -> MathspeciallaguerrePoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn math_special_laguerre_point_scale(pt : MathspeciallaguerrePoint, s : Double) -> MathspeciallaguerrePoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn math_special_laguerre_point_dot(a : MathspeciallaguerrePoint, b : MathspeciallaguerrePoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn math_special_laguerre_point_cross(a : MathspeciallaguerrePoint, b : MathspeciallaguerrePoint) -> MathspeciallaguerrePoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn math_special_laguerre_point_norm(pt : MathspeciallaguerrePoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn math_special_laguerre_point_normalize(pt : MathspeciallaguerrePoint) -> MathspeciallaguerrePoint {
  let n = math_special_laguerre_point_norm(pt)
  if n < 0.0000001 { pt } else { math_special_laguerre_point_scale(pt, 1.0 / n) }
}

pub fn math_special_laguerre_point_negate(pt : MathspeciallaguerrePoint) -> MathspeciallaguerrePoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn math_special_laguerre_point_mid(a : MathspeciallaguerrePoint, b : MathspeciallaguerrePoint) -> MathspeciallaguerrePoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn math_special_laguerre_point_lerp(a : MathspeciallaguerrePoint, b : MathspeciallaguerrePoint, t : Double) -> MathspeciallaguerrePoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn math_special_laguerre_point_to_string(pt : MathspeciallaguerrePoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct MathspeciallaguerreSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn math_special_laguerre_make_series(vals : Array[Double], name : String) -> MathspeciallaguerreSeries {
  { vals, name, meta: 0 }
}

pub fn math_special_laguerre_series_len(s : MathspeciallaguerreSeries) -> Int { s.vals.length() }

pub fn math_special_laguerre_series_sum(s : MathspeciallaguerreSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn math_special_laguerre_series_mean(s : MathspeciallaguerreSeries) -> Double {
  let n = math_special_laguerre_series_len(s)
  if n == 0 { 0.0 } else { math_special_laguerre_series_sum(s) / n.to_double() }
}

pub fn math_special_laguerre_series_min(s : MathspeciallaguerreSeries) -> Double {
  let n = math_special_laguerre_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn math_special_laguerre_series_max(s : MathspeciallaguerreSeries) -> Double {
  let n = math_special_laguerre_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn math_special_laguerre_series_range(s : MathspeciallaguerreSeries) -> Double {
  math_special_laguerre_series_max(s) - math_special_laguerre_series_min(s)
}

pub fn math_special_laguerre_series_var(s : MathspeciallaguerreSeries) -> Double {
  let n = math_special_laguerre_series_len(s)
  if n == 0 { 0.0 } else {
    let m = math_special_laguerre_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn math_special_laguerre_series_std(s : MathspeciallaguerreSeries) -> Double { @_common.sqrt(math_special_laguerre_series_var(s)) }

pub fn math_special_laguerre_series_median(s : MathspeciallaguerreSeries) -> Double {
  let n = math_special_laguerre_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = math_special_laguerre_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn math_special_laguerre_series_scale(s : MathspeciallaguerreSeries, f : Double) -> MathspeciallaguerreSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn math_special_laguerre_series_add(a : MathspeciallaguerreSeries, b : MathspeciallaguerreSeries) -> MathspeciallaguerreSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn math_special_laguerre_series_sub(a : MathspeciallaguerreSeries, b : MathspeciallaguerreSeries) -> MathspeciallaguerreSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn math_special_laguerre_series_normalize(s : MathspeciallaguerreSeries) -> MathspeciallaguerreSeries {
  let mn = math_special_laguerre_series_min(s)
  let mx = math_special_laguerre_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn math_special_laguerre_series_cumsum(s : MathspeciallaguerreSeries) -> MathspeciallaguerreSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn math_special_laguerre_series_to_string(s : MathspeciallaguerreSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MathspeciallaguerreMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn math_special_laguerre_make_matrix(rows : Int, cols : Int, val : Double) -> MathspeciallaguerreMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn math_special_laguerre_matrix_identity(n : Int) -> MathspeciallaguerreMatrix {
  let m = math_special_laguerre_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn math_special_laguerre_matrix_get(m : MathspeciallaguerreMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn math_special_laguerre_matrix_transpose(m : MathspeciallaguerreMatrix) -> MathspeciallaguerreMatrix {
  let result = math_special_laguerre_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn math_special_laguerre_matrix_add(a : MathspeciallaguerreMatrix, b : MathspeciallaguerreMatrix) -> MathspeciallaguerreMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = math_special_laguerre_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn math_special_laguerre_matrix_scale(m : MathspeciallaguerreMatrix, s : Double) -> MathspeciallaguerreMatrix {
  let result = math_special_laguerre_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn math_special_laguerre_matrix_multiply(a : MathspeciallaguerreMatrix, b : MathspeciallaguerreMatrix) -> MathspeciallaguerreMatrix {
  if a.cols != b.rows { return math_special_laguerre_make_matrix(a.rows, b.cols, 0.0) }
  let result = math_special_laguerre_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn math_special_laguerre_matrix_trace(m : MathspeciallaguerreMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn math_special_laguerre_matrix_det(m : MathspeciallaguerreMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn math_special_laguerre_matrix_norm(m : MathspeciallaguerreMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn math_special_laguerre_matrix_to_string(m : MathspeciallaguerreMatrix) -> String {
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

pub(all) struct MathspeciallaguerreVector {
  comps : Array[Double]
  dim : Int
}

pub fn math_special_laguerre_make_vector(comps : Array[Double]) -> MathspeciallaguerreVector {
  { comps, dim: comps.length() }
}

pub fn math_special_laguerre_vector_zero(dim : Int) -> MathspeciallaguerreVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn math_special_laguerre_vector_add(a : MathspeciallaguerreVector, b : MathspeciallaguerreVector) -> MathspeciallaguerreVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn math_special_laguerre_vector_sub(a : MathspeciallaguerreVector, b : MathspeciallaguerreVector) -> MathspeciallaguerreVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn math_special_laguerre_vector_scale(v : MathspeciallaguerreVector, s : Double) -> MathspeciallaguerreVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn math_special_laguerre_vector_dot(a : MathspeciallaguerreVector, b : MathspeciallaguerreVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn math_special_laguerre_vector_norm(v : MathspeciallaguerreVector) -> Double { @_common.sqrt(math_special_laguerre_vector_dot(v, v)) }

pub fn math_special_laguerre_vector_normalize(v : MathspeciallaguerreVector) -> MathspeciallaguerreVector {
  let n = math_special_laguerre_vector_norm(v)
  if n < 0.0000001 { v } else { math_special_laguerre_vector_scale(v, 1.0 / n) }
}

pub fn math_special_laguerre_vector_dist(a : MathspeciallaguerreVector, b : MathspeciallaguerreVector) -> Double {
  math_special_laguerre_vector_norm(math_special_laguerre_vector_sub(a, b))
}

pub fn math_special_laguerre_vector_to_string(v : MathspeciallaguerreVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn math_special_laguerre_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn math_special_laguerre_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = math_special_laguerre_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn math_special_laguerre_std(data : Array[Double]) -> Double { @_common.sqrt(math_special_laguerre_var(data)) }

pub fn math_special_laguerre_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = math_special_laguerre_mean(a); let mb = math_special_laguerre_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn math_special_laguerre_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = math_special_laguerre_std(a); let sb = math_special_laguerre_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { math_special_laguerre_cov(a, b) / (sa * sb) }
}

pub fn math_special_laguerre_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = math_special_laguerre_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn math_special_laguerre_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn math_special_laguerre_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn math_special_laguerre_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  @_common.sqrt(math_special_laguerre_mse(pred, labels))
}

pub fn math_special_laguerre_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn math_special_laguerre_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = math_special_laguerre_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn math_special_laguerre_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn math_special_laguerre_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn math_special_laguerre_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = math_special_laguerre_precision(pred, labels, pos); let r = math_special_laguerre_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn math_special_laguerre_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn math_special_laguerre_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = math_special_laguerre_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn math_special_laguerre_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn math_special_laguerre_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn math_special_laguerre_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = math_special_laguerre_gcd(a, b)
    (a / g) * b
  }
}

pub fn math_special_laguerre_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn math_special_laguerre_fibonacci(n : Int) -> Int {
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

pub fn math_special_laguerre_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = math_special_laguerre_min(data); let mx = math_special_laguerre_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn math_special_laguerre_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = math_special_laguerre_mean(data); let sd = math_special_laguerre_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn math_special_laguerre_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn math_special_laguerre_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn math_special_laguerre_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn math_special_laguerre_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn math_special_laguerre_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn math_special_laguerre_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

pub(all) struct MathspeciallaguerreFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_laguerre_frame_make(size : Int) -> MathspeciallaguerreFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_laguerre_frame_len(s : MathspeciallaguerreFrame) -> Int { s.size }

pub fn math_special_laguerre_frame_get(s : MathspeciallaguerreFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_laguerre_frame_set(s : MathspeciallaguerreFrame, i : Int, v : Double) -> MathspeciallaguerreFrame {
  let result = math_special_laguerre_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_special_laguerre_frame_sum(s : MathspeciallaguerreFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_special_laguerre_frame_mean(s : MathspeciallaguerreFrame) -> Double {
  if s.size == 0 { 0.0 } else { math_special_laguerre_frame_sum(s) / s.size.to_double() }
}

pub fn math_special_laguerre_frame_scale(s : MathspeciallaguerreFrame, f : Double) -> MathspeciallaguerreFrame {
  let result = math_special_laguerre_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_special_laguerre_frame_add(a : MathspeciallaguerreFrame, b : MathspeciallaguerreFrame) -> MathspeciallaguerreFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_special_laguerre_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_special_laguerre_frame_copy(s : MathspeciallaguerreFrame) -> MathspeciallaguerreFrame {
  let result = math_special_laguerre_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_special_laguerre_frame_fill(s : MathspeciallaguerreFrame, v : Double) -> MathspeciallaguerreFrame {
  let result = math_special_laguerre_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_special_laguerre_frame_min(s : MathspeciallaguerreFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_special_laguerre_frame_max(s : MathspeciallaguerreFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_special_laguerre_frame_to_string(s : MathspeciallaguerreFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspeciallaguerreTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_laguerre_table_make(size : Int) -> MathspeciallaguerreTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_laguerre_table_len(s : MathspeciallaguerreTable) -> Int { s.size }

pub fn math_special_laguerre_table_get(s : MathspeciallaguerreTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_laguerre_table_set(s : MathspeciallaguerreTable, i : Int, v : Double) -> MathspeciallaguerreTable {
  let result = math_special_laguerre_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_special_laguerre_table_sum(s : MathspeciallaguerreTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_special_laguerre_table_mean(s : MathspeciallaguerreTable) -> Double {
  if s.size == 0 { 0.0 } else { math_special_laguerre_table_sum(s) / s.size.to_double() }
}

pub fn math_special_laguerre_table_scale(s : MathspeciallaguerreTable, f : Double) -> MathspeciallaguerreTable {
  let result = math_special_laguerre_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_special_laguerre_table_add(a : MathspeciallaguerreTable, b : MathspeciallaguerreTable) -> MathspeciallaguerreTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_special_laguerre_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_special_laguerre_table_copy(s : MathspeciallaguerreTable) -> MathspeciallaguerreTable {
  let result = math_special_laguerre_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_special_laguerre_table_fill(s : MathspeciallaguerreTable, v : Double) -> MathspeciallaguerreTable {
  let result = math_special_laguerre_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_special_laguerre_table_min(s : MathspeciallaguerreTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_special_laguerre_table_max(s : MathspeciallaguerreTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_special_laguerre_table_to_string(s : MathspeciallaguerreTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspeciallaguerreGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_laguerre_graphn_make(size : Int) -> MathspeciallaguerreGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_laguerre_graphn_len(s : MathspeciallaguerreGraphN) -> Int { s.size }

pub fn math_special_laguerre_graphn_get(s : MathspeciallaguerreGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_laguerre_graphn_set(s : MathspeciallaguerreGraphN, i : Int, v : Double) -> MathspeciallaguerreGraphN {
  let result = math_special_laguerre_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_special_laguerre_graphn_sum(s : MathspeciallaguerreGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_special_laguerre_graphn_mean(s : MathspeciallaguerreGraphN) -> Double {
  if s.size == 0 { 0.0 } else { math_special_laguerre_graphn_sum(s) / s.size.to_double() }
}

pub fn math_special_laguerre_graphn_scale(s : MathspeciallaguerreGraphN, f : Double) -> MathspeciallaguerreGraphN {
  let result = math_special_laguerre_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_special_laguerre_graphn_add(a : MathspeciallaguerreGraphN, b : MathspeciallaguerreGraphN) -> MathspeciallaguerreGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_special_laguerre_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_special_laguerre_graphn_copy(s : MathspeciallaguerreGraphN) -> MathspeciallaguerreGraphN {
  let result = math_special_laguerre_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_special_laguerre_graphn_fill(s : MathspeciallaguerreGraphN, v : Double) -> MathspeciallaguerreGraphN {
  let result = math_special_laguerre_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_special_laguerre_graphn_min(s : MathspeciallaguerreGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_special_laguerre_graphn_max(s : MathspeciallaguerreGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_special_laguerre_graphn_to_string(s : MathspeciallaguerreGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspeciallaguerreNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_laguerre_node_make(size : Int) -> MathspeciallaguerreNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_laguerre_node_len(s : MathspeciallaguerreNode) -> Int { s.size }

pub fn math_special_laguerre_node_get(s : MathspeciallaguerreNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_laguerre_node_set(s : MathspeciallaguerreNode, i : Int, v : Double) -> MathspeciallaguerreNode {
  let result = math_special_laguerre_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_special_laguerre_node_sum(s : MathspeciallaguerreNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_special_laguerre_node_mean(s : MathspeciallaguerreNode) -> Double {
  if s.size == 0 { 0.0 } else { math_special_laguerre_node_sum(s) / s.size.to_double() }
}

pub fn math_special_laguerre_node_scale(s : MathspeciallaguerreNode, f : Double) -> MathspeciallaguerreNode {
  let result = math_special_laguerre_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_special_laguerre_node_add(a : MathspeciallaguerreNode, b : MathspeciallaguerreNode) -> MathspeciallaguerreNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_special_laguerre_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_special_laguerre_node_copy(s : MathspeciallaguerreNode) -> MathspeciallaguerreNode {
  let result = math_special_laguerre_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_special_laguerre_node_fill(s : MathspeciallaguerreNode, v : Double) -> MathspeciallaguerreNode {
  let result = math_special_laguerre_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_special_laguerre_node_min(s : MathspeciallaguerreNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_special_laguerre_node_max(s : MathspeciallaguerreNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_special_laguerre_node_to_string(s : MathspeciallaguerreNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspeciallaguerreEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_laguerre_edge_make(size : Int) -> MathspeciallaguerreEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_laguerre_edge_len(s : MathspeciallaguerreEdge) -> Int { s.size }

pub fn math_special_laguerre_edge_get(s : MathspeciallaguerreEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_laguerre_edge_set(s : MathspeciallaguerreEdge, i : Int, v : Double) -> MathspeciallaguerreEdge {
  let result = math_special_laguerre_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_special_laguerre_edge_sum(s : MathspeciallaguerreEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_special_laguerre_edge_mean(s : MathspeciallaguerreEdge) -> Double {
  if s.size == 0 { 0.0 } else { math_special_laguerre_edge_sum(s) / s.size.to_double() }
}

pub fn math_special_laguerre_edge_scale(s : MathspeciallaguerreEdge, f : Double) -> MathspeciallaguerreEdge {
  let result = math_special_laguerre_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_special_laguerre_edge_add(a : MathspeciallaguerreEdge, b : MathspeciallaguerreEdge) -> MathspeciallaguerreEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_special_laguerre_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_special_laguerre_edge_copy(s : MathspeciallaguerreEdge) -> MathspeciallaguerreEdge {
  let result = math_special_laguerre_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_special_laguerre_edge_fill(s : MathspeciallaguerreEdge, v : Double) -> MathspeciallaguerreEdge {
  let result = math_special_laguerre_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_special_laguerre_edge_min(s : MathspeciallaguerreEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_special_laguerre_edge_max(s : MathspeciallaguerreEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_special_laguerre_edge_to_string(s : MathspeciallaguerreEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspeciallaguerrePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_laguerre_path_make(size : Int) -> MathspeciallaguerrePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_laguerre_path_len(s : MathspeciallaguerrePath) -> Int { s.size }

pub fn math_special_laguerre_path_get(s : MathspeciallaguerrePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_laguerre_path_set(s : MathspeciallaguerrePath, i : Int, v : Double) -> MathspeciallaguerrePath {
  let result = math_special_laguerre_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_special_laguerre_path_sum(s : MathspeciallaguerrePath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_special_laguerre_path_mean(s : MathspeciallaguerrePath) -> Double {
  if s.size == 0 { 0.0 } else { math_special_laguerre_path_sum(s) / s.size.to_double() }
}

pub fn math_special_laguerre_path_scale(s : MathspeciallaguerrePath, f : Double) -> MathspeciallaguerrePath {
  let result = math_special_laguerre_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_special_laguerre_path_add(a : MathspeciallaguerrePath, b : MathspeciallaguerrePath) -> MathspeciallaguerrePath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_special_laguerre_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_special_laguerre_path_copy(s : MathspeciallaguerrePath) -> MathspeciallaguerrePath {
  let result = math_special_laguerre_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_special_laguerre_path_fill(s : MathspeciallaguerrePath, v : Double) -> MathspeciallaguerrePath {
  let result = math_special_laguerre_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_special_laguerre_path_min(s : MathspeciallaguerrePath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_special_laguerre_path_max(s : MathspeciallaguerrePath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_special_laguerre_path_to_string(s : MathspeciallaguerrePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspeciallaguerreCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_laguerre_cluster_make(size : Int) -> MathspeciallaguerreCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_laguerre_cluster_len(s : MathspeciallaguerreCluster) -> Int { s.size }

pub fn math_special_laguerre_cluster_get(s : MathspeciallaguerreCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_laguerre_cluster_set(s : MathspeciallaguerreCluster, i : Int, v : Double) -> MathspeciallaguerreCluster {
  let result = math_special_laguerre_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_special_laguerre_cluster_sum(s : MathspeciallaguerreCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_special_laguerre_cluster_mean(s : MathspeciallaguerreCluster) -> Double {
  if s.size == 0 { 0.0 } else { math_special_laguerre_cluster_sum(s) / s.size.to_double() }
}

pub fn math_special_laguerre_cluster_scale(s : MathspeciallaguerreCluster, f : Double) -> MathspeciallaguerreCluster {
  let result = math_special_laguerre_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_special_laguerre_cluster_add(a : MathspeciallaguerreCluster, b : MathspeciallaguerreCluster) -> MathspeciallaguerreCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_special_laguerre_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_special_laguerre_cluster_copy(s : MathspeciallaguerreCluster) -> MathspeciallaguerreCluster {
  let result = math_special_laguerre_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_special_laguerre_cluster_fill(s : MathspeciallaguerreCluster, v : Double) -> MathspeciallaguerreCluster {
  let result = math_special_laguerre_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_special_laguerre_cluster_min(s : MathspeciallaguerreCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_special_laguerre_cluster_max(s : MathspeciallaguerreCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_special_laguerre_cluster_to_string(s : MathspeciallaguerreCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspeciallaguerreModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_laguerre_model_make(size : Int) -> MathspeciallaguerreModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_laguerre_model_len(s : MathspeciallaguerreModel) -> Int { s.size }

pub fn math_special_laguerre_model_get(s : MathspeciallaguerreModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_laguerre_model_set(s : MathspeciallaguerreModel, i : Int, v : Double) -> MathspeciallaguerreModel {
  let result = math_special_laguerre_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_special_laguerre_model_sum(s : MathspeciallaguerreModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_special_laguerre_model_mean(s : MathspeciallaguerreModel) -> Double {
  if s.size == 0 { 0.0 } else { math_special_laguerre_model_sum(s) / s.size.to_double() }
}

pub fn math_special_laguerre_model_scale(s : MathspeciallaguerreModel, f : Double) -> MathspeciallaguerreModel {
  let result = math_special_laguerre_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_special_laguerre_model_add(a : MathspeciallaguerreModel, b : MathspeciallaguerreModel) -> MathspeciallaguerreModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_special_laguerre_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_special_laguerre_model_copy(s : MathspeciallaguerreModel) -> MathspeciallaguerreModel {
  let result = math_special_laguerre_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_special_laguerre_model_fill(s : MathspeciallaguerreModel, v : Double) -> MathspeciallaguerreModel {
  let result = math_special_laguerre_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_special_laguerre_model_min(s : MathspeciallaguerreModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_special_laguerre_model_max(s : MathspeciallaguerreModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_special_laguerre_model_to_string(s : MathspeciallaguerreModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspeciallaguerreLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_laguerre_layer_make(size : Int) -> MathspeciallaguerreLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_laguerre_layer_len(s : MathspeciallaguerreLayer) -> Int { s.size }

pub fn math_special_laguerre_layer_get(s : MathspeciallaguerreLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_laguerre_layer_set(s : MathspeciallaguerreLayer, i : Int, v : Double) -> MathspeciallaguerreLayer {
  let result = math_special_laguerre_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_special_laguerre_layer_sum(s : MathspeciallaguerreLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_special_laguerre_layer_mean(s : MathspeciallaguerreLayer) -> Double {
  if s.size == 0 { 0.0 } else { math_special_laguerre_layer_sum(s) / s.size.to_double() }
}

pub fn math_special_laguerre_layer_scale(s : MathspeciallaguerreLayer, f : Double) -> MathspeciallaguerreLayer {
  let result = math_special_laguerre_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_special_laguerre_layer_add(a : MathspeciallaguerreLayer, b : MathspeciallaguerreLayer) -> MathspeciallaguerreLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_special_laguerre_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_special_laguerre_layer_copy(s : MathspeciallaguerreLayer) -> MathspeciallaguerreLayer {
  let result = math_special_laguerre_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_special_laguerre_layer_fill(s : MathspeciallaguerreLayer, v : Double) -> MathspeciallaguerreLayer {
  let result = math_special_laguerre_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_special_laguerre_layer_min(s : MathspeciallaguerreLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_special_laguerre_layer_max(s : MathspeciallaguerreLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_special_laguerre_layer_to_string(s : MathspeciallaguerreLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspeciallaguerreBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_laguerre_buffer_make(size : Int) -> MathspeciallaguerreBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_laguerre_buffer_len(s : MathspeciallaguerreBuffer) -> Int { s.size }

pub fn math_special_laguerre_buffer_get(s : MathspeciallaguerreBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_laguerre_buffer_set(s : MathspeciallaguerreBuffer, i : Int, v : Double) -> MathspeciallaguerreBuffer {
  let result = math_special_laguerre_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_special_laguerre_buffer_sum(s : MathspeciallaguerreBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_special_laguerre_buffer_mean(s : MathspeciallaguerreBuffer) -> Double {
  if s.size == 0 { 0.0 } else { math_special_laguerre_buffer_sum(s) / s.size.to_double() }
}

pub fn math_special_laguerre_buffer_scale(s : MathspeciallaguerreBuffer, f : Double) -> MathspeciallaguerreBuffer {
  let result = math_special_laguerre_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_special_laguerre_buffer_add(a : MathspeciallaguerreBuffer, b : MathspeciallaguerreBuffer) -> MathspeciallaguerreBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_special_laguerre_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_special_laguerre_buffer_copy(s : MathspeciallaguerreBuffer) -> MathspeciallaguerreBuffer {
  let result = math_special_laguerre_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_special_laguerre_buffer_fill(s : MathspeciallaguerreBuffer, v : Double) -> MathspeciallaguerreBuffer {
  let result = math_special_laguerre_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_special_laguerre_buffer_min(s : MathspeciallaguerreBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_special_laguerre_buffer_max(s : MathspeciallaguerreBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_special_laguerre_buffer_to_string(s : MathspeciallaguerreBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspeciallaguerreCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_laguerre_cursor_make(size : Int) -> MathspeciallaguerreCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_laguerre_cursor_len(s : MathspeciallaguerreCursor) -> Int { s.size }

pub fn math_special_laguerre_cursor_get(s : MathspeciallaguerreCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_laguerre_cursor_set(s : MathspeciallaguerreCursor, i : Int, v : Double) -> MathspeciallaguerreCursor {
  let result = math_special_laguerre_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_special_laguerre_cursor_sum(s : MathspeciallaguerreCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_special_laguerre_cursor_mean(s : MathspeciallaguerreCursor) -> Double {
  if s.size == 0 { 0.0 } else { math_special_laguerre_cursor_sum(s) / s.size.to_double() }
}

pub fn math_special_laguerre_cursor_scale(s : MathspeciallaguerreCursor, f : Double) -> MathspeciallaguerreCursor {
  let result = math_special_laguerre_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_special_laguerre_cursor_add(a : MathspeciallaguerreCursor, b : MathspeciallaguerreCursor) -> MathspeciallaguerreCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_special_laguerre_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_special_laguerre_cursor_copy(s : MathspeciallaguerreCursor) -> MathspeciallaguerreCursor {
  let result = math_special_laguerre_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_special_laguerre_cursor_fill(s : MathspeciallaguerreCursor, v : Double) -> MathspeciallaguerreCursor {
  let result = math_special_laguerre_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_special_laguerre_cursor_min(s : MathspeciallaguerreCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_special_laguerre_cursor_max(s : MathspeciallaguerreCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_special_laguerre_cursor_to_string(s : MathspeciallaguerreCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspeciallaguerreView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_laguerre_view_make(size : Int) -> MathspeciallaguerreView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_laguerre_view_len(s : MathspeciallaguerreView) -> Int { s.size }

pub fn math_special_laguerre_view_get(s : MathspeciallaguerreView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_laguerre_view_set(s : MathspeciallaguerreView, i : Int, v : Double) -> MathspeciallaguerreView {
  let result = math_special_laguerre_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_special_laguerre_view_sum(s : MathspeciallaguerreView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_special_laguerre_view_mean(s : MathspeciallaguerreView) -> Double {
  if s.size == 0 { 0.0 } else { math_special_laguerre_view_sum(s) / s.size.to_double() }
}

pub fn math_special_laguerre_view_scale(s : MathspeciallaguerreView, f : Double) -> MathspeciallaguerreView {
  let result = math_special_laguerre_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_special_laguerre_view_add(a : MathspeciallaguerreView, b : MathspeciallaguerreView) -> MathspeciallaguerreView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_special_laguerre_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_special_laguerre_view_copy(s : MathspeciallaguerreView) -> MathspeciallaguerreView {
  let result = math_special_laguerre_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_special_laguerre_view_fill(s : MathspeciallaguerreView, v : Double) -> MathspeciallaguerreView {
  let result = math_special_laguerre_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_special_laguerre_view_min(s : MathspeciallaguerreView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_special_laguerre_view_max(s : MathspeciallaguerreView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_special_laguerre_view_to_string(s : MathspeciallaguerreView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspeciallaguerreRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_laguerre_range_make(size : Int) -> MathspeciallaguerreRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_laguerre_range_len(s : MathspeciallaguerreRange) -> Int { s.size }

pub fn math_special_laguerre_range_get(s : MathspeciallaguerreRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_laguerre_range_set(s : MathspeciallaguerreRange, i : Int, v : Double) -> MathspeciallaguerreRange {
  let result = math_special_laguerre_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_special_laguerre_range_sum(s : MathspeciallaguerreRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_special_laguerre_range_mean(s : MathspeciallaguerreRange) -> Double {
  if s.size == 0 { 0.0 } else { math_special_laguerre_range_sum(s) / s.size.to_double() }
}

pub fn math_special_laguerre_range_scale(s : MathspeciallaguerreRange, f : Double) -> MathspeciallaguerreRange {
  let result = math_special_laguerre_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_special_laguerre_range_add(a : MathspeciallaguerreRange, b : MathspeciallaguerreRange) -> MathspeciallaguerreRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_special_laguerre_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_special_laguerre_range_copy(s : MathspeciallaguerreRange) -> MathspeciallaguerreRange {
  let result = math_special_laguerre_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_special_laguerre_range_fill(s : MathspeciallaguerreRange, v : Double) -> MathspeciallaguerreRange {
  let result = math_special_laguerre_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_special_laguerre_range_min(s : MathspeciallaguerreRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_special_laguerre_range_max(s : MathspeciallaguerreRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_special_laguerre_range_to_string(s : MathspeciallaguerreRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspeciallaguerreSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_laguerre_slice_make(size : Int) -> MathspeciallaguerreSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_laguerre_slice_len(s : MathspeciallaguerreSlice) -> Int { s.size }

pub fn math_special_laguerre_slice_get(s : MathspeciallaguerreSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_laguerre_slice_set(s : MathspeciallaguerreSlice, i : Int, v : Double) -> MathspeciallaguerreSlice {
  let result = math_special_laguerre_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_special_laguerre_slice_sum(s : MathspeciallaguerreSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_special_laguerre_slice_mean(s : MathspeciallaguerreSlice) -> Double {
  if s.size == 0 { 0.0 } else { math_special_laguerre_slice_sum(s) / s.size.to_double() }
}

pub fn math_special_laguerre_slice_scale(s : MathspeciallaguerreSlice, f : Double) -> MathspeciallaguerreSlice {
  let result = math_special_laguerre_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_special_laguerre_slice_add(a : MathspeciallaguerreSlice, b : MathspeciallaguerreSlice) -> MathspeciallaguerreSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_special_laguerre_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_special_laguerre_slice_copy(s : MathspeciallaguerreSlice) -> MathspeciallaguerreSlice {
  let result = math_special_laguerre_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_special_laguerre_slice_fill(s : MathspeciallaguerreSlice, v : Double) -> MathspeciallaguerreSlice {
  let result = math_special_laguerre_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_special_laguerre_slice_min(s : MathspeciallaguerreSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_special_laguerre_slice_max(s : MathspeciallaguerreSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_special_laguerre_slice_to_string(s : MathspeciallaguerreSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

