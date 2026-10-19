///===
/// extcore/math_boundary_value

pub(all) struct MathboundaryvaluePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn math_boundary_value_make_point(x : Double, y : Double) -> MathboundaryvaluePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn math_boundary_value_make_point3(x : Double, y : Double, z : Double) -> MathboundaryvaluePoint {
  { x, y, z, label: 0 }
}

pub fn math_boundary_value_point_x(pt : MathboundaryvaluePoint) -> Double { pt.x }

pub fn math_boundary_value_point_y(pt : MathboundaryvaluePoint) -> Double { pt.y }

pub fn math_boundary_value_point_z(pt : MathboundaryvaluePoint) -> Double { pt.z }

pub fn math_boundary_value_point_label(pt : MathboundaryvaluePoint) -> Int { pt.label }

pub fn math_boundary_value_point_dist(a : MathboundaryvaluePoint, b : MathboundaryvaluePoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  math_boundary_value_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn math_boundary_value_point_add(a : MathboundaryvaluePoint, b : MathboundaryvaluePoint) -> MathboundaryvaluePoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn math_boundary_value_point_sub(a : MathboundaryvaluePoint, b : MathboundaryvaluePoint) -> MathboundaryvaluePoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn math_boundary_value_point_scale(pt : MathboundaryvaluePoint, s : Double) -> MathboundaryvaluePoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn math_boundary_value_point_dot(a : MathboundaryvaluePoint, b : MathboundaryvaluePoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn math_boundary_value_point_cross(a : MathboundaryvaluePoint, b : MathboundaryvaluePoint) -> MathboundaryvaluePoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn math_boundary_value_point_norm(pt : MathboundaryvaluePoint) -> Double {
  math_boundary_value_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn math_boundary_value_point_normalize(pt : MathboundaryvaluePoint) -> MathboundaryvaluePoint {
  let n = math_boundary_value_point_norm(pt)
  if n < 0.0000001 { pt } else { math_boundary_value_point_scale(pt, 1.0 / n) }
}

pub fn math_boundary_value_point_negate(pt : MathboundaryvaluePoint) -> MathboundaryvaluePoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn math_boundary_value_point_mid(a : MathboundaryvaluePoint, b : MathboundaryvaluePoint) -> MathboundaryvaluePoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn math_boundary_value_point_lerp(a : MathboundaryvaluePoint, b : MathboundaryvaluePoint, t : Double) -> MathboundaryvaluePoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn math_boundary_value_point_to_string(pt : MathboundaryvaluePoint) -> String {
  "(" + math_boundary_value_dbl(pt.x) + ", " + math_boundary_value_dbl(pt.y) + ", " + math_boundary_value_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct MathboundaryvalueSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn math_boundary_value_make_series(vals : Array[Double], name : String) -> MathboundaryvalueSeries {
  { vals, name, meta: 0 }
}

pub fn math_boundary_value_series_len(s : MathboundaryvalueSeries) -> Int { s.vals.length() }

pub fn math_boundary_value_series_sum(s : MathboundaryvalueSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn math_boundary_value_series_mean(s : MathboundaryvalueSeries) -> Double {
  let n = math_boundary_value_series_len(s)
  if n == 0 { 0.0 } else { math_boundary_value_series_sum(s) / n.to_double() }
}

pub fn math_boundary_value_series_min(s : MathboundaryvalueSeries) -> Double {
  let n = math_boundary_value_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn math_boundary_value_series_max(s : MathboundaryvalueSeries) -> Double {
  let n = math_boundary_value_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn math_boundary_value_series_range(s : MathboundaryvalueSeries) -> Double {
  math_boundary_value_series_max(s) - math_boundary_value_series_min(s)
}

pub fn math_boundary_value_series_var(s : MathboundaryvalueSeries) -> Double {
  let n = math_boundary_value_series_len(s)
  if n == 0 { 0.0 } else {
    let m = math_boundary_value_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn math_boundary_value_series_std(s : MathboundaryvalueSeries) -> Double { math_boundary_value_sqrt(math_boundary_value_series_var(s)) }

pub fn math_boundary_value_series_median(s : MathboundaryvalueSeries) -> Double {
  let n = math_boundary_value_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = math_boundary_value_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn math_boundary_value_series_scale(s : MathboundaryvalueSeries, f : Double) -> MathboundaryvalueSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = math_boundary_value_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn math_boundary_value_series_add(a : MathboundaryvalueSeries, b : MathboundaryvalueSeries) -> MathboundaryvalueSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = math_boundary_value_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn math_boundary_value_series_sub(a : MathboundaryvalueSeries, b : MathboundaryvalueSeries) -> MathboundaryvalueSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = math_boundary_value_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn math_boundary_value_series_normalize(s : MathboundaryvalueSeries) -> MathboundaryvalueSeries {
  let mn = math_boundary_value_series_min(s)
  let mx = math_boundary_value_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = math_boundary_value_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn math_boundary_value_series_cumsum(s : MathboundaryvalueSeries) -> MathboundaryvalueSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = math_boundary_value_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn math_boundary_value_series_to_string(s : MathboundaryvalueSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + math_boundary_value_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MathboundaryvalueMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn math_boundary_value_make_matrix(rows : Int, cols : Int, val : Double) -> MathboundaryvalueMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn math_boundary_value_matrix_identity(n : Int) -> MathboundaryvalueMatrix {
  let m = math_boundary_value_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn math_boundary_value_matrix_get(m : MathboundaryvalueMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn math_boundary_value_matrix_transpose(m : MathboundaryvalueMatrix) -> MathboundaryvalueMatrix {
  let result = math_boundary_value_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn math_boundary_value_matrix_add(a : MathboundaryvalueMatrix, b : MathboundaryvalueMatrix) -> MathboundaryvalueMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = math_boundary_value_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn math_boundary_value_matrix_scale(m : MathboundaryvalueMatrix, s : Double) -> MathboundaryvalueMatrix {
  let result = math_boundary_value_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn math_boundary_value_matrix_multiply(a : MathboundaryvalueMatrix, b : MathboundaryvalueMatrix) -> MathboundaryvalueMatrix {
  if a.cols != b.rows { return math_boundary_value_make_matrix(a.rows, b.cols, 0.0) }
  let result = math_boundary_value_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn math_boundary_value_matrix_trace(m : MathboundaryvalueMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn math_boundary_value_matrix_det(m : MathboundaryvalueMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn math_boundary_value_matrix_norm(m : MathboundaryvalueMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  math_boundary_value_sqrt(sum)
}

pub fn math_boundary_value_matrix_to_string(m : MathboundaryvalueMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + math_boundary_value_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct MathboundaryvalueVector {
  comps : Array[Double]
  dim : Int
}

pub fn math_boundary_value_make_vector(comps : Array[Double]) -> MathboundaryvalueVector {
  { comps, dim: comps.length() }
}

pub fn math_boundary_value_vector_zero(dim : Int) -> MathboundaryvalueVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn math_boundary_value_vector_add(a : MathboundaryvalueVector, b : MathboundaryvalueVector) -> MathboundaryvalueVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = math_boundary_value_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn math_boundary_value_vector_sub(a : MathboundaryvalueVector, b : MathboundaryvalueVector) -> MathboundaryvalueVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = math_boundary_value_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn math_boundary_value_vector_scale(v : MathboundaryvalueVector, s : Double) -> MathboundaryvalueVector {
  let mut result = []
  for i in 0..<v.dim { result = math_boundary_value_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn math_boundary_value_vector_dot(a : MathboundaryvalueVector, b : MathboundaryvalueVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn math_boundary_value_vector_norm(v : MathboundaryvalueVector) -> Double { math_boundary_value_sqrt(math_boundary_value_vector_dot(v, v)) }

pub fn math_boundary_value_vector_normalize(v : MathboundaryvalueVector) -> MathboundaryvalueVector {
  let n = math_boundary_value_vector_norm(v)
  if n < 0.0000001 { v } else { math_boundary_value_vector_scale(v, 1.0 / n) }
}

pub fn math_boundary_value_vector_dist(a : MathboundaryvalueVector, b : MathboundaryvalueVector) -> Double {
  math_boundary_value_vector_norm(math_boundary_value_vector_sub(a, b))
}

pub fn math_boundary_value_vector_to_string(v : MathboundaryvalueVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + math_boundary_value_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn math_boundary_value_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn math_boundary_value_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = math_boundary_value_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn math_boundary_value_std(data : Array[Double]) -> Double { math_boundary_value_sqrt(math_boundary_value_var(data)) }

pub fn math_boundary_value_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = math_boundary_value_mean(a); let mb = math_boundary_value_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn math_boundary_value_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = math_boundary_value_std(a); let sb = math_boundary_value_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { math_boundary_value_cov(a, b) / (sa * sb) }
}

pub fn math_boundary_value_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = math_boundary_value_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn math_boundary_value_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn math_boundary_value_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn math_boundary_value_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  math_boundary_value_sqrt(math_boundary_value_mse(pred, labels))
}

pub fn math_boundary_value_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + math_boundary_value_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn math_boundary_value_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = math_boundary_value_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn math_boundary_value_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn math_boundary_value_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn math_boundary_value_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = math_boundary_value_precision(pred, labels, pos); let r = math_boundary_value_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn math_boundary_value_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn math_boundary_value_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = math_boundary_value_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn math_boundary_value_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn math_boundary_value_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn math_boundary_value_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = math_boundary_value_gcd(a, b)
    (a / g) * b
  }
}

pub fn math_boundary_value_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn math_boundary_value_fibonacci(n : Int) -> Int {
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

pub fn math_boundary_value_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = math_boundary_value_min(data); let mx = math_boundary_value_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn math_boundary_value_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = math_boundary_value_mean(data); let sd = math_boundary_value_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn math_boundary_value_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn math_boundary_value_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn math_boundary_value_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn math_boundary_value_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn math_boundary_value_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn math_boundary_value_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn math_boundary_value_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn math_boundary_value_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn math_boundary_value_dbl(x : Double) -> String {
  let i = if x >= 0.0 { math_boundary_value_int(x) } else { -math_boundary_value_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { math_boundary_value_int(f * 1000000.0) } else { math_boundary_value_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn math_boundary_value_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn math_boundary_value_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct MathboundaryvalueFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_boundary_value_frame_make(size : Int) -> MathboundaryvalueFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_boundary_value_frame_len(s : MathboundaryvalueFrame) -> Int { s.size }

pub fn math_boundary_value_frame_get(s : MathboundaryvalueFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_boundary_value_frame_set(s : MathboundaryvalueFrame, i : Int, v : Double) -> MathboundaryvalueFrame {
  let result = math_boundary_value_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_boundary_value_frame_sum(s : MathboundaryvalueFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_boundary_value_frame_mean(s : MathboundaryvalueFrame) -> Double {
  if s.size == 0 { 0.0 } else { math_boundary_value_frame_sum(s) / s.size.to_double() }
}

pub fn math_boundary_value_frame_scale(s : MathboundaryvalueFrame, f : Double) -> MathboundaryvalueFrame {
  let result = math_boundary_value_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_boundary_value_frame_add(a : MathboundaryvalueFrame, b : MathboundaryvalueFrame) -> MathboundaryvalueFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_boundary_value_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_boundary_value_frame_copy(s : MathboundaryvalueFrame) -> MathboundaryvalueFrame {
  let result = math_boundary_value_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_boundary_value_frame_fill(s : MathboundaryvalueFrame, v : Double) -> MathboundaryvalueFrame {
  let result = math_boundary_value_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_boundary_value_frame_min(s : MathboundaryvalueFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_boundary_value_frame_max(s : MathboundaryvalueFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_boundary_value_frame_to_string(s : MathboundaryvalueFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathboundaryvalueTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_boundary_value_table_make(size : Int) -> MathboundaryvalueTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_boundary_value_table_len(s : MathboundaryvalueTable) -> Int { s.size }

pub fn math_boundary_value_table_get(s : MathboundaryvalueTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_boundary_value_table_set(s : MathboundaryvalueTable, i : Int, v : Double) -> MathboundaryvalueTable {
  let result = math_boundary_value_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_boundary_value_table_sum(s : MathboundaryvalueTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_boundary_value_table_mean(s : MathboundaryvalueTable) -> Double {
  if s.size == 0 { 0.0 } else { math_boundary_value_table_sum(s) / s.size.to_double() }
}

pub fn math_boundary_value_table_scale(s : MathboundaryvalueTable, f : Double) -> MathboundaryvalueTable {
  let result = math_boundary_value_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_boundary_value_table_add(a : MathboundaryvalueTable, b : MathboundaryvalueTable) -> MathboundaryvalueTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_boundary_value_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_boundary_value_table_copy(s : MathboundaryvalueTable) -> MathboundaryvalueTable {
  let result = math_boundary_value_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_boundary_value_table_fill(s : MathboundaryvalueTable, v : Double) -> MathboundaryvalueTable {
  let result = math_boundary_value_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_boundary_value_table_min(s : MathboundaryvalueTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_boundary_value_table_max(s : MathboundaryvalueTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_boundary_value_table_to_string(s : MathboundaryvalueTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathboundaryvalueGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_boundary_value_graphn_make(size : Int) -> MathboundaryvalueGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_boundary_value_graphn_len(s : MathboundaryvalueGraphN) -> Int { s.size }

pub fn math_boundary_value_graphn_get(s : MathboundaryvalueGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_boundary_value_graphn_set(s : MathboundaryvalueGraphN, i : Int, v : Double) -> MathboundaryvalueGraphN {
  let result = math_boundary_value_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_boundary_value_graphn_sum(s : MathboundaryvalueGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_boundary_value_graphn_mean(s : MathboundaryvalueGraphN) -> Double {
  if s.size == 0 { 0.0 } else { math_boundary_value_graphn_sum(s) / s.size.to_double() }
}

pub fn math_boundary_value_graphn_scale(s : MathboundaryvalueGraphN, f : Double) -> MathboundaryvalueGraphN {
  let result = math_boundary_value_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_boundary_value_graphn_add(a : MathboundaryvalueGraphN, b : MathboundaryvalueGraphN) -> MathboundaryvalueGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_boundary_value_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_boundary_value_graphn_copy(s : MathboundaryvalueGraphN) -> MathboundaryvalueGraphN {
  let result = math_boundary_value_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_boundary_value_graphn_fill(s : MathboundaryvalueGraphN, v : Double) -> MathboundaryvalueGraphN {
  let result = math_boundary_value_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_boundary_value_graphn_min(s : MathboundaryvalueGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_boundary_value_graphn_max(s : MathboundaryvalueGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_boundary_value_graphn_to_string(s : MathboundaryvalueGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathboundaryvalueNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_boundary_value_node_make(size : Int) -> MathboundaryvalueNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_boundary_value_node_len(s : MathboundaryvalueNode) -> Int { s.size }

pub fn math_boundary_value_node_get(s : MathboundaryvalueNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_boundary_value_node_set(s : MathboundaryvalueNode, i : Int, v : Double) -> MathboundaryvalueNode {
  let result = math_boundary_value_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_boundary_value_node_sum(s : MathboundaryvalueNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_boundary_value_node_mean(s : MathboundaryvalueNode) -> Double {
  if s.size == 0 { 0.0 } else { math_boundary_value_node_sum(s) / s.size.to_double() }
}

pub fn math_boundary_value_node_scale(s : MathboundaryvalueNode, f : Double) -> MathboundaryvalueNode {
  let result = math_boundary_value_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_boundary_value_node_add(a : MathboundaryvalueNode, b : MathboundaryvalueNode) -> MathboundaryvalueNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_boundary_value_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_boundary_value_node_copy(s : MathboundaryvalueNode) -> MathboundaryvalueNode {
  let result = math_boundary_value_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_boundary_value_node_fill(s : MathboundaryvalueNode, v : Double) -> MathboundaryvalueNode {
  let result = math_boundary_value_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_boundary_value_node_min(s : MathboundaryvalueNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_boundary_value_node_max(s : MathboundaryvalueNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_boundary_value_node_to_string(s : MathboundaryvalueNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathboundaryvalueEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_boundary_value_edge_make(size : Int) -> MathboundaryvalueEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_boundary_value_edge_len(s : MathboundaryvalueEdge) -> Int { s.size }

pub fn math_boundary_value_edge_get(s : MathboundaryvalueEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_boundary_value_edge_set(s : MathboundaryvalueEdge, i : Int, v : Double) -> MathboundaryvalueEdge {
  let result = math_boundary_value_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_boundary_value_edge_sum(s : MathboundaryvalueEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_boundary_value_edge_mean(s : MathboundaryvalueEdge) -> Double {
  if s.size == 0 { 0.0 } else { math_boundary_value_edge_sum(s) / s.size.to_double() }
}

pub fn math_boundary_value_edge_scale(s : MathboundaryvalueEdge, f : Double) -> MathboundaryvalueEdge {
  let result = math_boundary_value_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_boundary_value_edge_add(a : MathboundaryvalueEdge, b : MathboundaryvalueEdge) -> MathboundaryvalueEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_boundary_value_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_boundary_value_edge_copy(s : MathboundaryvalueEdge) -> MathboundaryvalueEdge {
  let result = math_boundary_value_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_boundary_value_edge_fill(s : MathboundaryvalueEdge, v : Double) -> MathboundaryvalueEdge {
  let result = math_boundary_value_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_boundary_value_edge_min(s : MathboundaryvalueEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_boundary_value_edge_max(s : MathboundaryvalueEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_boundary_value_edge_to_string(s : MathboundaryvalueEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathboundaryvaluePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_boundary_value_path_make(size : Int) -> MathboundaryvaluePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_boundary_value_path_len(s : MathboundaryvaluePath) -> Int { s.size }

pub fn math_boundary_value_path_get(s : MathboundaryvaluePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_boundary_value_path_set(s : MathboundaryvaluePath, i : Int, v : Double) -> MathboundaryvaluePath {
  let result = math_boundary_value_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_boundary_value_path_sum(s : MathboundaryvaluePath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_boundary_value_path_mean(s : MathboundaryvaluePath) -> Double {
  if s.size == 0 { 0.0 } else { math_boundary_value_path_sum(s) / s.size.to_double() }
}

pub fn math_boundary_value_path_scale(s : MathboundaryvaluePath, f : Double) -> MathboundaryvaluePath {
  let result = math_boundary_value_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_boundary_value_path_add(a : MathboundaryvaluePath, b : MathboundaryvaluePath) -> MathboundaryvaluePath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_boundary_value_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_boundary_value_path_copy(s : MathboundaryvaluePath) -> MathboundaryvaluePath {
  let result = math_boundary_value_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_boundary_value_path_fill(s : MathboundaryvaluePath, v : Double) -> MathboundaryvaluePath {
  let result = math_boundary_value_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_boundary_value_path_min(s : MathboundaryvaluePath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_boundary_value_path_max(s : MathboundaryvaluePath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_boundary_value_path_to_string(s : MathboundaryvaluePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathboundaryvalueCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_boundary_value_cluster_make(size : Int) -> MathboundaryvalueCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_boundary_value_cluster_len(s : MathboundaryvalueCluster) -> Int { s.size }

pub fn math_boundary_value_cluster_get(s : MathboundaryvalueCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_boundary_value_cluster_set(s : MathboundaryvalueCluster, i : Int, v : Double) -> MathboundaryvalueCluster {
  let result = math_boundary_value_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_boundary_value_cluster_sum(s : MathboundaryvalueCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_boundary_value_cluster_mean(s : MathboundaryvalueCluster) -> Double {
  if s.size == 0 { 0.0 } else { math_boundary_value_cluster_sum(s) / s.size.to_double() }
}

pub fn math_boundary_value_cluster_scale(s : MathboundaryvalueCluster, f : Double) -> MathboundaryvalueCluster {
  let result = math_boundary_value_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_boundary_value_cluster_add(a : MathboundaryvalueCluster, b : MathboundaryvalueCluster) -> MathboundaryvalueCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_boundary_value_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_boundary_value_cluster_copy(s : MathboundaryvalueCluster) -> MathboundaryvalueCluster {
  let result = math_boundary_value_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_boundary_value_cluster_fill(s : MathboundaryvalueCluster, v : Double) -> MathboundaryvalueCluster {
  let result = math_boundary_value_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_boundary_value_cluster_min(s : MathboundaryvalueCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_boundary_value_cluster_max(s : MathboundaryvalueCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_boundary_value_cluster_to_string(s : MathboundaryvalueCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathboundaryvalueModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_boundary_value_model_make(size : Int) -> MathboundaryvalueModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_boundary_value_model_len(s : MathboundaryvalueModel) -> Int { s.size }

pub fn math_boundary_value_model_get(s : MathboundaryvalueModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_boundary_value_model_set(s : MathboundaryvalueModel, i : Int, v : Double) -> MathboundaryvalueModel {
  let result = math_boundary_value_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_boundary_value_model_sum(s : MathboundaryvalueModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_boundary_value_model_mean(s : MathboundaryvalueModel) -> Double {
  if s.size == 0 { 0.0 } else { math_boundary_value_model_sum(s) / s.size.to_double() }
}

pub fn math_boundary_value_model_scale(s : MathboundaryvalueModel, f : Double) -> MathboundaryvalueModel {
  let result = math_boundary_value_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_boundary_value_model_add(a : MathboundaryvalueModel, b : MathboundaryvalueModel) -> MathboundaryvalueModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_boundary_value_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_boundary_value_model_copy(s : MathboundaryvalueModel) -> MathboundaryvalueModel {
  let result = math_boundary_value_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_boundary_value_model_fill(s : MathboundaryvalueModel, v : Double) -> MathboundaryvalueModel {
  let result = math_boundary_value_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_boundary_value_model_min(s : MathboundaryvalueModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_boundary_value_model_max(s : MathboundaryvalueModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_boundary_value_model_to_string(s : MathboundaryvalueModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathboundaryvalueLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_boundary_value_layer_make(size : Int) -> MathboundaryvalueLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_boundary_value_layer_len(s : MathboundaryvalueLayer) -> Int { s.size }

pub fn math_boundary_value_layer_get(s : MathboundaryvalueLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_boundary_value_layer_set(s : MathboundaryvalueLayer, i : Int, v : Double) -> MathboundaryvalueLayer {
  let result = math_boundary_value_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_boundary_value_layer_sum(s : MathboundaryvalueLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_boundary_value_layer_mean(s : MathboundaryvalueLayer) -> Double {
  if s.size == 0 { 0.0 } else { math_boundary_value_layer_sum(s) / s.size.to_double() }
}

pub fn math_boundary_value_layer_scale(s : MathboundaryvalueLayer, f : Double) -> MathboundaryvalueLayer {
  let result = math_boundary_value_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_boundary_value_layer_add(a : MathboundaryvalueLayer, b : MathboundaryvalueLayer) -> MathboundaryvalueLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_boundary_value_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_boundary_value_layer_copy(s : MathboundaryvalueLayer) -> MathboundaryvalueLayer {
  let result = math_boundary_value_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_boundary_value_layer_fill(s : MathboundaryvalueLayer, v : Double) -> MathboundaryvalueLayer {
  let result = math_boundary_value_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_boundary_value_layer_min(s : MathboundaryvalueLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_boundary_value_layer_max(s : MathboundaryvalueLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_boundary_value_layer_to_string(s : MathboundaryvalueLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathboundaryvalueBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_boundary_value_buffer_make(size : Int) -> MathboundaryvalueBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_boundary_value_buffer_len(s : MathboundaryvalueBuffer) -> Int { s.size }

pub fn math_boundary_value_buffer_get(s : MathboundaryvalueBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_boundary_value_buffer_set(s : MathboundaryvalueBuffer, i : Int, v : Double) -> MathboundaryvalueBuffer {
  let result = math_boundary_value_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_boundary_value_buffer_sum(s : MathboundaryvalueBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_boundary_value_buffer_mean(s : MathboundaryvalueBuffer) -> Double {
  if s.size == 0 { 0.0 } else { math_boundary_value_buffer_sum(s) / s.size.to_double() }
}

pub fn math_boundary_value_buffer_scale(s : MathboundaryvalueBuffer, f : Double) -> MathboundaryvalueBuffer {
  let result = math_boundary_value_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_boundary_value_buffer_add(a : MathboundaryvalueBuffer, b : MathboundaryvalueBuffer) -> MathboundaryvalueBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_boundary_value_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_boundary_value_buffer_copy(s : MathboundaryvalueBuffer) -> MathboundaryvalueBuffer {
  let result = math_boundary_value_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_boundary_value_buffer_fill(s : MathboundaryvalueBuffer, v : Double) -> MathboundaryvalueBuffer {
  let result = math_boundary_value_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_boundary_value_buffer_min(s : MathboundaryvalueBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_boundary_value_buffer_max(s : MathboundaryvalueBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_boundary_value_buffer_to_string(s : MathboundaryvalueBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathboundaryvalueCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_boundary_value_cursor_make(size : Int) -> MathboundaryvalueCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_boundary_value_cursor_len(s : MathboundaryvalueCursor) -> Int { s.size }

pub fn math_boundary_value_cursor_get(s : MathboundaryvalueCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_boundary_value_cursor_set(s : MathboundaryvalueCursor, i : Int, v : Double) -> MathboundaryvalueCursor {
  let result = math_boundary_value_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_boundary_value_cursor_sum(s : MathboundaryvalueCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_boundary_value_cursor_mean(s : MathboundaryvalueCursor) -> Double {
  if s.size == 0 { 0.0 } else { math_boundary_value_cursor_sum(s) / s.size.to_double() }
}

pub fn math_boundary_value_cursor_scale(s : MathboundaryvalueCursor, f : Double) -> MathboundaryvalueCursor {
  let result = math_boundary_value_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_boundary_value_cursor_add(a : MathboundaryvalueCursor, b : MathboundaryvalueCursor) -> MathboundaryvalueCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_boundary_value_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_boundary_value_cursor_copy(s : MathboundaryvalueCursor) -> MathboundaryvalueCursor {
  let result = math_boundary_value_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_boundary_value_cursor_fill(s : MathboundaryvalueCursor, v : Double) -> MathboundaryvalueCursor {
  let result = math_boundary_value_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_boundary_value_cursor_min(s : MathboundaryvalueCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_boundary_value_cursor_max(s : MathboundaryvalueCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_boundary_value_cursor_to_string(s : MathboundaryvalueCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathboundaryvalueView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_boundary_value_view_make(size : Int) -> MathboundaryvalueView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_boundary_value_view_len(s : MathboundaryvalueView) -> Int { s.size }

pub fn math_boundary_value_view_get(s : MathboundaryvalueView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_boundary_value_view_set(s : MathboundaryvalueView, i : Int, v : Double) -> MathboundaryvalueView {
  let result = math_boundary_value_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_boundary_value_view_sum(s : MathboundaryvalueView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_boundary_value_view_mean(s : MathboundaryvalueView) -> Double {
  if s.size == 0 { 0.0 } else { math_boundary_value_view_sum(s) / s.size.to_double() }
}

pub fn math_boundary_value_view_scale(s : MathboundaryvalueView, f : Double) -> MathboundaryvalueView {
  let result = math_boundary_value_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_boundary_value_view_add(a : MathboundaryvalueView, b : MathboundaryvalueView) -> MathboundaryvalueView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_boundary_value_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_boundary_value_view_copy(s : MathboundaryvalueView) -> MathboundaryvalueView {
  let result = math_boundary_value_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_boundary_value_view_fill(s : MathboundaryvalueView, v : Double) -> MathboundaryvalueView {
  let result = math_boundary_value_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_boundary_value_view_min(s : MathboundaryvalueView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_boundary_value_view_max(s : MathboundaryvalueView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_boundary_value_view_to_string(s : MathboundaryvalueView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathboundaryvalueRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_boundary_value_range_make(size : Int) -> MathboundaryvalueRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_boundary_value_range_len(s : MathboundaryvalueRange) -> Int { s.size }

pub fn math_boundary_value_range_get(s : MathboundaryvalueRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_boundary_value_range_set(s : MathboundaryvalueRange, i : Int, v : Double) -> MathboundaryvalueRange {
  let result = math_boundary_value_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_boundary_value_range_sum(s : MathboundaryvalueRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_boundary_value_range_mean(s : MathboundaryvalueRange) -> Double {
  if s.size == 0 { 0.0 } else { math_boundary_value_range_sum(s) / s.size.to_double() }
}

pub fn math_boundary_value_range_scale(s : MathboundaryvalueRange, f : Double) -> MathboundaryvalueRange {
  let result = math_boundary_value_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_boundary_value_range_add(a : MathboundaryvalueRange, b : MathboundaryvalueRange) -> MathboundaryvalueRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_boundary_value_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_boundary_value_range_copy(s : MathboundaryvalueRange) -> MathboundaryvalueRange {
  let result = math_boundary_value_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_boundary_value_range_fill(s : MathboundaryvalueRange, v : Double) -> MathboundaryvalueRange {
  let result = math_boundary_value_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_boundary_value_range_min(s : MathboundaryvalueRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_boundary_value_range_max(s : MathboundaryvalueRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_boundary_value_range_to_string(s : MathboundaryvalueRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathboundaryvalueSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_boundary_value_slice_make(size : Int) -> MathboundaryvalueSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_boundary_value_slice_len(s : MathboundaryvalueSlice) -> Int { s.size }

pub fn math_boundary_value_slice_get(s : MathboundaryvalueSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_boundary_value_slice_set(s : MathboundaryvalueSlice, i : Int, v : Double) -> MathboundaryvalueSlice {
  let result = math_boundary_value_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_boundary_value_slice_sum(s : MathboundaryvalueSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_boundary_value_slice_mean(s : MathboundaryvalueSlice) -> Double {
  if s.size == 0 { 0.0 } else { math_boundary_value_slice_sum(s) / s.size.to_double() }
}

pub fn math_boundary_value_slice_scale(s : MathboundaryvalueSlice, f : Double) -> MathboundaryvalueSlice {
  let result = math_boundary_value_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_boundary_value_slice_add(a : MathboundaryvalueSlice, b : MathboundaryvalueSlice) -> MathboundaryvalueSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_boundary_value_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_boundary_value_slice_copy(s : MathboundaryvalueSlice) -> MathboundaryvalueSlice {
  let result = math_boundary_value_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_boundary_value_slice_fill(s : MathboundaryvalueSlice, v : Double) -> MathboundaryvalueSlice {
  let result = math_boundary_value_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_boundary_value_slice_min(s : MathboundaryvalueSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_boundary_value_slice_max(s : MathboundaryvalueSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_boundary_value_slice_to_string(s : MathboundaryvalueSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn math_boundary_value_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_boundary_value_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_boundary_value_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_boundary_value_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_boundary_value_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_boundary_value_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_boundary_value_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_boundary_value_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_boundary_value_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_boundary_value_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_boundary_value_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_boundary_value_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_boundary_value_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_boundary_value_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_boundary_value_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_boundary_value_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_boundary_value_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_boundary_value_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_boundary_value_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_boundary_value_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_boundary_value_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_boundary_value_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_boundary_value_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_boundary_value_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_boundary_value_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

