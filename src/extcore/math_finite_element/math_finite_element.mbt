///===
/// extcore/math_finite_element

pub(all) struct MathfiniteelementPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn math_finite_element_make_point(x : Double, y : Double) -> MathfiniteelementPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn math_finite_element_make_point3(x : Double, y : Double, z : Double) -> MathfiniteelementPoint {
  { x, y, z, label: 0 }
}

pub fn math_finite_element_point_x(pt : MathfiniteelementPoint) -> Double { pt.x }

pub fn math_finite_element_point_y(pt : MathfiniteelementPoint) -> Double { pt.y }

pub fn math_finite_element_point_z(pt : MathfiniteelementPoint) -> Double { pt.z }

pub fn math_finite_element_point_label(pt : MathfiniteelementPoint) -> Int { pt.label }

pub fn math_finite_element_point_dist(a : MathfiniteelementPoint, b : MathfiniteelementPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn math_finite_element_point_add(a : MathfiniteelementPoint, b : MathfiniteelementPoint) -> MathfiniteelementPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn math_finite_element_point_sub(a : MathfiniteelementPoint, b : MathfiniteelementPoint) -> MathfiniteelementPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn math_finite_element_point_scale(pt : MathfiniteelementPoint, s : Double) -> MathfiniteelementPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn math_finite_element_point_dot(a : MathfiniteelementPoint, b : MathfiniteelementPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn math_finite_element_point_cross(a : MathfiniteelementPoint, b : MathfiniteelementPoint) -> MathfiniteelementPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn math_finite_element_point_norm(pt : MathfiniteelementPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn math_finite_element_point_normalize(pt : MathfiniteelementPoint) -> MathfiniteelementPoint {
  let n = math_finite_element_point_norm(pt)
  if n < 0.0000001 { pt } else { math_finite_element_point_scale(pt, 1.0 / n) }
}

pub fn math_finite_element_point_negate(pt : MathfiniteelementPoint) -> MathfiniteelementPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn math_finite_element_point_mid(a : MathfiniteelementPoint, b : MathfiniteelementPoint) -> MathfiniteelementPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn math_finite_element_point_lerp(a : MathfiniteelementPoint, b : MathfiniteelementPoint, t : Double) -> MathfiniteelementPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn math_finite_element_point_to_string(pt : MathfiniteelementPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct MathfiniteelementSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn math_finite_element_make_series(vals : Array[Double], name : String) -> MathfiniteelementSeries {
  { vals, name, meta: 0 }
}

pub fn math_finite_element_series_len(s : MathfiniteelementSeries) -> Int { s.vals.length() }

pub fn math_finite_element_series_sum(s : MathfiniteelementSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn math_finite_element_series_mean(s : MathfiniteelementSeries) -> Double {
  let n = math_finite_element_series_len(s)
  if n == 0 { 0.0 } else { math_finite_element_series_sum(s) / n.to_double() }
}

pub fn math_finite_element_series_min(s : MathfiniteelementSeries) -> Double {
  let n = math_finite_element_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn math_finite_element_series_max(s : MathfiniteelementSeries) -> Double {
  let n = math_finite_element_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn math_finite_element_series_range(s : MathfiniteelementSeries) -> Double {
  math_finite_element_series_max(s) - math_finite_element_series_min(s)
}

pub fn math_finite_element_series_var(s : MathfiniteelementSeries) -> Double {
  let n = math_finite_element_series_len(s)
  if n == 0 { 0.0 } else {
    let m = math_finite_element_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn math_finite_element_series_std(s : MathfiniteelementSeries) -> Double { @_common.sqrt(math_finite_element_series_var(s)) }

pub fn math_finite_element_series_median(s : MathfiniteelementSeries) -> Double {
  let n = math_finite_element_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = math_finite_element_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn math_finite_element_series_scale(s : MathfiniteelementSeries, f : Double) -> MathfiniteelementSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn math_finite_element_series_add(a : MathfiniteelementSeries, b : MathfiniteelementSeries) -> MathfiniteelementSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn math_finite_element_series_sub(a : MathfiniteelementSeries, b : MathfiniteelementSeries) -> MathfiniteelementSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn math_finite_element_series_normalize(s : MathfiniteelementSeries) -> MathfiniteelementSeries {
  let mn = math_finite_element_series_min(s)
  let mx = math_finite_element_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn math_finite_element_series_cumsum(s : MathfiniteelementSeries) -> MathfiniteelementSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn math_finite_element_series_to_string(s : MathfiniteelementSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MathfiniteelementMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn math_finite_element_make_matrix(rows : Int, cols : Int, val : Double) -> MathfiniteelementMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn math_finite_element_matrix_identity(n : Int) -> MathfiniteelementMatrix {
  let m = math_finite_element_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn math_finite_element_matrix_get(m : MathfiniteelementMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn math_finite_element_matrix_transpose(m : MathfiniteelementMatrix) -> MathfiniteelementMatrix {
  let result = math_finite_element_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn math_finite_element_matrix_add(a : MathfiniteelementMatrix, b : MathfiniteelementMatrix) -> MathfiniteelementMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = math_finite_element_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn math_finite_element_matrix_scale(m : MathfiniteelementMatrix, s : Double) -> MathfiniteelementMatrix {
  let result = math_finite_element_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn math_finite_element_matrix_multiply(a : MathfiniteelementMatrix, b : MathfiniteelementMatrix) -> MathfiniteelementMatrix {
  if a.cols != b.rows { return math_finite_element_make_matrix(a.rows, b.cols, 0.0) }
  let result = math_finite_element_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn math_finite_element_matrix_trace(m : MathfiniteelementMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn math_finite_element_matrix_det(m : MathfiniteelementMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn math_finite_element_matrix_norm(m : MathfiniteelementMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn math_finite_element_matrix_to_string(m : MathfiniteelementMatrix) -> String {
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

pub(all) struct MathfiniteelementVector {
  comps : Array[Double]
  dim : Int
}

pub fn math_finite_element_make_vector(comps : Array[Double]) -> MathfiniteelementVector {
  { comps, dim: comps.length() }
}

pub fn math_finite_element_vector_zero(dim : Int) -> MathfiniteelementVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn math_finite_element_vector_add(a : MathfiniteelementVector, b : MathfiniteelementVector) -> MathfiniteelementVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn math_finite_element_vector_sub(a : MathfiniteelementVector, b : MathfiniteelementVector) -> MathfiniteelementVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn math_finite_element_vector_scale(v : MathfiniteelementVector, s : Double) -> MathfiniteelementVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn math_finite_element_vector_dot(a : MathfiniteelementVector, b : MathfiniteelementVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn math_finite_element_vector_norm(v : MathfiniteelementVector) -> Double { @_common.sqrt(math_finite_element_vector_dot(v, v)) }

pub fn math_finite_element_vector_normalize(v : MathfiniteelementVector) -> MathfiniteelementVector {
  let n = math_finite_element_vector_norm(v)
  if n < 0.0000001 { v } else { math_finite_element_vector_scale(v, 1.0 / n) }
}

pub fn math_finite_element_vector_dist(a : MathfiniteelementVector, b : MathfiniteelementVector) -> Double {
  math_finite_element_vector_norm(math_finite_element_vector_sub(a, b))
}

pub fn math_finite_element_vector_to_string(v : MathfiniteelementVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn math_finite_element_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn math_finite_element_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = math_finite_element_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn math_finite_element_std(data : Array[Double]) -> Double { @_common.sqrt(math_finite_element_var(data)) }

pub fn math_finite_element_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = math_finite_element_mean(a); let mb = math_finite_element_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn math_finite_element_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = math_finite_element_std(a); let sb = math_finite_element_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { math_finite_element_cov(a, b) / (sa * sb) }
}

pub fn math_finite_element_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = math_finite_element_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn math_finite_element_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn math_finite_element_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn math_finite_element_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  @_common.sqrt(math_finite_element_mse(pred, labels))
}

pub fn math_finite_element_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn math_finite_element_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = math_finite_element_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn math_finite_element_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn math_finite_element_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn math_finite_element_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = math_finite_element_precision(pred, labels, pos); let r = math_finite_element_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn math_finite_element_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn math_finite_element_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = math_finite_element_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn math_finite_element_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn math_finite_element_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn math_finite_element_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = math_finite_element_gcd(a, b)
    (a / g) * b
  }
}

pub fn math_finite_element_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn math_finite_element_fibonacci(n : Int) -> Int {
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

pub fn math_finite_element_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = math_finite_element_min(data); let mx = math_finite_element_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn math_finite_element_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = math_finite_element_mean(data); let sd = math_finite_element_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn math_finite_element_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn math_finite_element_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn math_finite_element_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn math_finite_element_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn math_finite_element_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn math_finite_element_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

pub(all) struct MathfiniteelementFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_finite_element_frame_make(size : Int) -> MathfiniteelementFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_finite_element_frame_len(s : MathfiniteelementFrame) -> Int { s.size }

pub fn math_finite_element_frame_get(s : MathfiniteelementFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_finite_element_frame_set(s : MathfiniteelementFrame, i : Int, v : Double) -> MathfiniteelementFrame {
  let result = math_finite_element_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_finite_element_frame_sum(s : MathfiniteelementFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_finite_element_frame_mean(s : MathfiniteelementFrame) -> Double {
  if s.size == 0 { 0.0 } else { math_finite_element_frame_sum(s) / s.size.to_double() }
}

pub fn math_finite_element_frame_scale(s : MathfiniteelementFrame, f : Double) -> MathfiniteelementFrame {
  let result = math_finite_element_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_finite_element_frame_add(a : MathfiniteelementFrame, b : MathfiniteelementFrame) -> MathfiniteelementFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_finite_element_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_finite_element_frame_copy(s : MathfiniteelementFrame) -> MathfiniteelementFrame {
  let result = math_finite_element_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_finite_element_frame_fill(s : MathfiniteelementFrame, v : Double) -> MathfiniteelementFrame {
  let result = math_finite_element_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_finite_element_frame_min(s : MathfiniteelementFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_finite_element_frame_max(s : MathfiniteelementFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_finite_element_frame_to_string(s : MathfiniteelementFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathfiniteelementTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_finite_element_table_make(size : Int) -> MathfiniteelementTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_finite_element_table_len(s : MathfiniteelementTable) -> Int { s.size }

pub fn math_finite_element_table_get(s : MathfiniteelementTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_finite_element_table_set(s : MathfiniteelementTable, i : Int, v : Double) -> MathfiniteelementTable {
  let result = math_finite_element_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_finite_element_table_sum(s : MathfiniteelementTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_finite_element_table_mean(s : MathfiniteelementTable) -> Double {
  if s.size == 0 { 0.0 } else { math_finite_element_table_sum(s) / s.size.to_double() }
}

pub fn math_finite_element_table_scale(s : MathfiniteelementTable, f : Double) -> MathfiniteelementTable {
  let result = math_finite_element_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_finite_element_table_add(a : MathfiniteelementTable, b : MathfiniteelementTable) -> MathfiniteelementTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_finite_element_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_finite_element_table_copy(s : MathfiniteelementTable) -> MathfiniteelementTable {
  let result = math_finite_element_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_finite_element_table_fill(s : MathfiniteelementTable, v : Double) -> MathfiniteelementTable {
  let result = math_finite_element_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_finite_element_table_min(s : MathfiniteelementTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_finite_element_table_max(s : MathfiniteelementTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_finite_element_table_to_string(s : MathfiniteelementTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathfiniteelementGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_finite_element_graphn_make(size : Int) -> MathfiniteelementGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_finite_element_graphn_len(s : MathfiniteelementGraphN) -> Int { s.size }

pub fn math_finite_element_graphn_get(s : MathfiniteelementGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_finite_element_graphn_set(s : MathfiniteelementGraphN, i : Int, v : Double) -> MathfiniteelementGraphN {
  let result = math_finite_element_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_finite_element_graphn_sum(s : MathfiniteelementGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_finite_element_graphn_mean(s : MathfiniteelementGraphN) -> Double {
  if s.size == 0 { 0.0 } else { math_finite_element_graphn_sum(s) / s.size.to_double() }
}

pub fn math_finite_element_graphn_scale(s : MathfiniteelementGraphN, f : Double) -> MathfiniteelementGraphN {
  let result = math_finite_element_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_finite_element_graphn_add(a : MathfiniteelementGraphN, b : MathfiniteelementGraphN) -> MathfiniteelementGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_finite_element_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_finite_element_graphn_copy(s : MathfiniteelementGraphN) -> MathfiniteelementGraphN {
  let result = math_finite_element_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_finite_element_graphn_fill(s : MathfiniteelementGraphN, v : Double) -> MathfiniteelementGraphN {
  let result = math_finite_element_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_finite_element_graphn_min(s : MathfiniteelementGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_finite_element_graphn_max(s : MathfiniteelementGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_finite_element_graphn_to_string(s : MathfiniteelementGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathfiniteelementNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_finite_element_node_make(size : Int) -> MathfiniteelementNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_finite_element_node_len(s : MathfiniteelementNode) -> Int { s.size }

pub fn math_finite_element_node_get(s : MathfiniteelementNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_finite_element_node_set(s : MathfiniteelementNode, i : Int, v : Double) -> MathfiniteelementNode {
  let result = math_finite_element_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_finite_element_node_sum(s : MathfiniteelementNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_finite_element_node_mean(s : MathfiniteelementNode) -> Double {
  if s.size == 0 { 0.0 } else { math_finite_element_node_sum(s) / s.size.to_double() }
}

pub fn math_finite_element_node_scale(s : MathfiniteelementNode, f : Double) -> MathfiniteelementNode {
  let result = math_finite_element_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_finite_element_node_add(a : MathfiniteelementNode, b : MathfiniteelementNode) -> MathfiniteelementNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_finite_element_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_finite_element_node_copy(s : MathfiniteelementNode) -> MathfiniteelementNode {
  let result = math_finite_element_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_finite_element_node_fill(s : MathfiniteelementNode, v : Double) -> MathfiniteelementNode {
  let result = math_finite_element_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_finite_element_node_min(s : MathfiniteelementNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_finite_element_node_max(s : MathfiniteelementNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_finite_element_node_to_string(s : MathfiniteelementNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathfiniteelementEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_finite_element_edge_make(size : Int) -> MathfiniteelementEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_finite_element_edge_len(s : MathfiniteelementEdge) -> Int { s.size }

pub fn math_finite_element_edge_get(s : MathfiniteelementEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_finite_element_edge_set(s : MathfiniteelementEdge, i : Int, v : Double) -> MathfiniteelementEdge {
  let result = math_finite_element_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_finite_element_edge_sum(s : MathfiniteelementEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_finite_element_edge_mean(s : MathfiniteelementEdge) -> Double {
  if s.size == 0 { 0.0 } else { math_finite_element_edge_sum(s) / s.size.to_double() }
}

pub fn math_finite_element_edge_scale(s : MathfiniteelementEdge, f : Double) -> MathfiniteelementEdge {
  let result = math_finite_element_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_finite_element_edge_add(a : MathfiniteelementEdge, b : MathfiniteelementEdge) -> MathfiniteelementEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_finite_element_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_finite_element_edge_copy(s : MathfiniteelementEdge) -> MathfiniteelementEdge {
  let result = math_finite_element_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_finite_element_edge_fill(s : MathfiniteelementEdge, v : Double) -> MathfiniteelementEdge {
  let result = math_finite_element_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_finite_element_edge_min(s : MathfiniteelementEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_finite_element_edge_max(s : MathfiniteelementEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_finite_element_edge_to_string(s : MathfiniteelementEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathfiniteelementPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_finite_element_path_make(size : Int) -> MathfiniteelementPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_finite_element_path_len(s : MathfiniteelementPath) -> Int { s.size }

pub fn math_finite_element_path_get(s : MathfiniteelementPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_finite_element_path_set(s : MathfiniteelementPath, i : Int, v : Double) -> MathfiniteelementPath {
  let result = math_finite_element_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_finite_element_path_sum(s : MathfiniteelementPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_finite_element_path_mean(s : MathfiniteelementPath) -> Double {
  if s.size == 0 { 0.0 } else { math_finite_element_path_sum(s) / s.size.to_double() }
}

pub fn math_finite_element_path_scale(s : MathfiniteelementPath, f : Double) -> MathfiniteelementPath {
  let result = math_finite_element_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_finite_element_path_add(a : MathfiniteelementPath, b : MathfiniteelementPath) -> MathfiniteelementPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_finite_element_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_finite_element_path_copy(s : MathfiniteelementPath) -> MathfiniteelementPath {
  let result = math_finite_element_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_finite_element_path_fill(s : MathfiniteelementPath, v : Double) -> MathfiniteelementPath {
  let result = math_finite_element_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_finite_element_path_min(s : MathfiniteelementPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_finite_element_path_max(s : MathfiniteelementPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_finite_element_path_to_string(s : MathfiniteelementPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathfiniteelementCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_finite_element_cluster_make(size : Int) -> MathfiniteelementCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_finite_element_cluster_len(s : MathfiniteelementCluster) -> Int { s.size }

pub fn math_finite_element_cluster_get(s : MathfiniteelementCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_finite_element_cluster_set(s : MathfiniteelementCluster, i : Int, v : Double) -> MathfiniteelementCluster {
  let result = math_finite_element_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_finite_element_cluster_sum(s : MathfiniteelementCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_finite_element_cluster_mean(s : MathfiniteelementCluster) -> Double {
  if s.size == 0 { 0.0 } else { math_finite_element_cluster_sum(s) / s.size.to_double() }
}

pub fn math_finite_element_cluster_scale(s : MathfiniteelementCluster, f : Double) -> MathfiniteelementCluster {
  let result = math_finite_element_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_finite_element_cluster_add(a : MathfiniteelementCluster, b : MathfiniteelementCluster) -> MathfiniteelementCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_finite_element_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_finite_element_cluster_copy(s : MathfiniteelementCluster) -> MathfiniteelementCluster {
  let result = math_finite_element_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_finite_element_cluster_fill(s : MathfiniteelementCluster, v : Double) -> MathfiniteelementCluster {
  let result = math_finite_element_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_finite_element_cluster_min(s : MathfiniteelementCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_finite_element_cluster_max(s : MathfiniteelementCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_finite_element_cluster_to_string(s : MathfiniteelementCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathfiniteelementModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_finite_element_model_make(size : Int) -> MathfiniteelementModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_finite_element_model_len(s : MathfiniteelementModel) -> Int { s.size }

pub fn math_finite_element_model_get(s : MathfiniteelementModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_finite_element_model_set(s : MathfiniteelementModel, i : Int, v : Double) -> MathfiniteelementModel {
  let result = math_finite_element_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_finite_element_model_sum(s : MathfiniteelementModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_finite_element_model_mean(s : MathfiniteelementModel) -> Double {
  if s.size == 0 { 0.0 } else { math_finite_element_model_sum(s) / s.size.to_double() }
}

pub fn math_finite_element_model_scale(s : MathfiniteelementModel, f : Double) -> MathfiniteelementModel {
  let result = math_finite_element_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_finite_element_model_add(a : MathfiniteelementModel, b : MathfiniteelementModel) -> MathfiniteelementModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_finite_element_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_finite_element_model_copy(s : MathfiniteelementModel) -> MathfiniteelementModel {
  let result = math_finite_element_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_finite_element_model_fill(s : MathfiniteelementModel, v : Double) -> MathfiniteelementModel {
  let result = math_finite_element_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_finite_element_model_min(s : MathfiniteelementModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_finite_element_model_max(s : MathfiniteelementModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_finite_element_model_to_string(s : MathfiniteelementModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathfiniteelementLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_finite_element_layer_make(size : Int) -> MathfiniteelementLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_finite_element_layer_len(s : MathfiniteelementLayer) -> Int { s.size }

pub fn math_finite_element_layer_get(s : MathfiniteelementLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_finite_element_layer_set(s : MathfiniteelementLayer, i : Int, v : Double) -> MathfiniteelementLayer {
  let result = math_finite_element_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_finite_element_layer_sum(s : MathfiniteelementLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_finite_element_layer_mean(s : MathfiniteelementLayer) -> Double {
  if s.size == 0 { 0.0 } else { math_finite_element_layer_sum(s) / s.size.to_double() }
}

pub fn math_finite_element_layer_scale(s : MathfiniteelementLayer, f : Double) -> MathfiniteelementLayer {
  let result = math_finite_element_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_finite_element_layer_add(a : MathfiniteelementLayer, b : MathfiniteelementLayer) -> MathfiniteelementLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_finite_element_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_finite_element_layer_copy(s : MathfiniteelementLayer) -> MathfiniteelementLayer {
  let result = math_finite_element_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_finite_element_layer_fill(s : MathfiniteelementLayer, v : Double) -> MathfiniteelementLayer {
  let result = math_finite_element_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_finite_element_layer_min(s : MathfiniteelementLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_finite_element_layer_max(s : MathfiniteelementLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_finite_element_layer_to_string(s : MathfiniteelementLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathfiniteelementBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_finite_element_buffer_make(size : Int) -> MathfiniteelementBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_finite_element_buffer_len(s : MathfiniteelementBuffer) -> Int { s.size }

pub fn math_finite_element_buffer_get(s : MathfiniteelementBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_finite_element_buffer_set(s : MathfiniteelementBuffer, i : Int, v : Double) -> MathfiniteelementBuffer {
  let result = math_finite_element_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_finite_element_buffer_sum(s : MathfiniteelementBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_finite_element_buffer_mean(s : MathfiniteelementBuffer) -> Double {
  if s.size == 0 { 0.0 } else { math_finite_element_buffer_sum(s) / s.size.to_double() }
}

pub fn math_finite_element_buffer_scale(s : MathfiniteelementBuffer, f : Double) -> MathfiniteelementBuffer {
  let result = math_finite_element_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_finite_element_buffer_add(a : MathfiniteelementBuffer, b : MathfiniteelementBuffer) -> MathfiniteelementBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_finite_element_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_finite_element_buffer_copy(s : MathfiniteelementBuffer) -> MathfiniteelementBuffer {
  let result = math_finite_element_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_finite_element_buffer_fill(s : MathfiniteelementBuffer, v : Double) -> MathfiniteelementBuffer {
  let result = math_finite_element_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_finite_element_buffer_min(s : MathfiniteelementBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_finite_element_buffer_max(s : MathfiniteelementBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_finite_element_buffer_to_string(s : MathfiniteelementBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathfiniteelementCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_finite_element_cursor_make(size : Int) -> MathfiniteelementCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_finite_element_cursor_len(s : MathfiniteelementCursor) -> Int { s.size }

pub fn math_finite_element_cursor_get(s : MathfiniteelementCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_finite_element_cursor_set(s : MathfiniteelementCursor, i : Int, v : Double) -> MathfiniteelementCursor {
  let result = math_finite_element_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_finite_element_cursor_sum(s : MathfiniteelementCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_finite_element_cursor_mean(s : MathfiniteelementCursor) -> Double {
  if s.size == 0 { 0.0 } else { math_finite_element_cursor_sum(s) / s.size.to_double() }
}

pub fn math_finite_element_cursor_scale(s : MathfiniteelementCursor, f : Double) -> MathfiniteelementCursor {
  let result = math_finite_element_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_finite_element_cursor_add(a : MathfiniteelementCursor, b : MathfiniteelementCursor) -> MathfiniteelementCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_finite_element_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_finite_element_cursor_copy(s : MathfiniteelementCursor) -> MathfiniteelementCursor {
  let result = math_finite_element_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_finite_element_cursor_fill(s : MathfiniteelementCursor, v : Double) -> MathfiniteelementCursor {
  let result = math_finite_element_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_finite_element_cursor_min(s : MathfiniteelementCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_finite_element_cursor_max(s : MathfiniteelementCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_finite_element_cursor_to_string(s : MathfiniteelementCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathfiniteelementView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_finite_element_view_make(size : Int) -> MathfiniteelementView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_finite_element_view_len(s : MathfiniteelementView) -> Int { s.size }

pub fn math_finite_element_view_get(s : MathfiniteelementView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_finite_element_view_set(s : MathfiniteelementView, i : Int, v : Double) -> MathfiniteelementView {
  let result = math_finite_element_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_finite_element_view_sum(s : MathfiniteelementView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_finite_element_view_mean(s : MathfiniteelementView) -> Double {
  if s.size == 0 { 0.0 } else { math_finite_element_view_sum(s) / s.size.to_double() }
}

pub fn math_finite_element_view_scale(s : MathfiniteelementView, f : Double) -> MathfiniteelementView {
  let result = math_finite_element_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_finite_element_view_add(a : MathfiniteelementView, b : MathfiniteelementView) -> MathfiniteelementView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_finite_element_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_finite_element_view_copy(s : MathfiniteelementView) -> MathfiniteelementView {
  let result = math_finite_element_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_finite_element_view_fill(s : MathfiniteelementView, v : Double) -> MathfiniteelementView {
  let result = math_finite_element_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_finite_element_view_min(s : MathfiniteelementView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_finite_element_view_max(s : MathfiniteelementView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_finite_element_view_to_string(s : MathfiniteelementView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathfiniteelementRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_finite_element_range_make(size : Int) -> MathfiniteelementRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_finite_element_range_len(s : MathfiniteelementRange) -> Int { s.size }

pub fn math_finite_element_range_get(s : MathfiniteelementRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_finite_element_range_set(s : MathfiniteelementRange, i : Int, v : Double) -> MathfiniteelementRange {
  let result = math_finite_element_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_finite_element_range_sum(s : MathfiniteelementRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_finite_element_range_mean(s : MathfiniteelementRange) -> Double {
  if s.size == 0 { 0.0 } else { math_finite_element_range_sum(s) / s.size.to_double() }
}

pub fn math_finite_element_range_scale(s : MathfiniteelementRange, f : Double) -> MathfiniteelementRange {
  let result = math_finite_element_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_finite_element_range_add(a : MathfiniteelementRange, b : MathfiniteelementRange) -> MathfiniteelementRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_finite_element_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_finite_element_range_copy(s : MathfiniteelementRange) -> MathfiniteelementRange {
  let result = math_finite_element_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_finite_element_range_fill(s : MathfiniteelementRange, v : Double) -> MathfiniteelementRange {
  let result = math_finite_element_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_finite_element_range_min(s : MathfiniteelementRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_finite_element_range_max(s : MathfiniteelementRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_finite_element_range_to_string(s : MathfiniteelementRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathfiniteelementSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_finite_element_slice_make(size : Int) -> MathfiniteelementSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_finite_element_slice_len(s : MathfiniteelementSlice) -> Int { s.size }

pub fn math_finite_element_slice_get(s : MathfiniteelementSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_finite_element_slice_set(s : MathfiniteelementSlice, i : Int, v : Double) -> MathfiniteelementSlice {
  let result = math_finite_element_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_finite_element_slice_sum(s : MathfiniteelementSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_finite_element_slice_mean(s : MathfiniteelementSlice) -> Double {
  if s.size == 0 { 0.0 } else { math_finite_element_slice_sum(s) / s.size.to_double() }
}

pub fn math_finite_element_slice_scale(s : MathfiniteelementSlice, f : Double) -> MathfiniteelementSlice {
  let result = math_finite_element_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_finite_element_slice_add(a : MathfiniteelementSlice, b : MathfiniteelementSlice) -> MathfiniteelementSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_finite_element_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_finite_element_slice_copy(s : MathfiniteelementSlice) -> MathfiniteelementSlice {
  let result = math_finite_element_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_finite_element_slice_fill(s : MathfiniteelementSlice, v : Double) -> MathfiniteelementSlice {
  let result = math_finite_element_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_finite_element_slice_min(s : MathfiniteelementSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_finite_element_slice_max(s : MathfiniteelementSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_finite_element_slice_to_string(s : MathfiniteelementSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

