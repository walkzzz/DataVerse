///===
/// extcore/math_initial_value

pub(all) struct MathinitialvaluePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn math_initial_value_make_point(x : Double, y : Double) -> MathinitialvaluePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn math_initial_value_make_point3(x : Double, y : Double, z : Double) -> MathinitialvaluePoint {
  { x, y, z, label: 0 }
}

pub fn math_initial_value_point_x(pt : MathinitialvaluePoint) -> Double { pt.x }

pub fn math_initial_value_point_y(pt : MathinitialvaluePoint) -> Double { pt.y }

pub fn math_initial_value_point_z(pt : MathinitialvaluePoint) -> Double { pt.z }

pub fn math_initial_value_point_label(pt : MathinitialvaluePoint) -> Int { pt.label }

pub fn math_initial_value_point_dist(a : MathinitialvaluePoint, b : MathinitialvaluePoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  math_initial_value_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn math_initial_value_point_add(a : MathinitialvaluePoint, b : MathinitialvaluePoint) -> MathinitialvaluePoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn math_initial_value_point_sub(a : MathinitialvaluePoint, b : MathinitialvaluePoint) -> MathinitialvaluePoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn math_initial_value_point_scale(pt : MathinitialvaluePoint, s : Double) -> MathinitialvaluePoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn math_initial_value_point_dot(a : MathinitialvaluePoint, b : MathinitialvaluePoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn math_initial_value_point_cross(a : MathinitialvaluePoint, b : MathinitialvaluePoint) -> MathinitialvaluePoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn math_initial_value_point_norm(pt : MathinitialvaluePoint) -> Double {
  math_initial_value_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn math_initial_value_point_normalize(pt : MathinitialvaluePoint) -> MathinitialvaluePoint {
  let n = math_initial_value_point_norm(pt)
  if n < 0.0000001 { pt } else { math_initial_value_point_scale(pt, 1.0 / n) }
}

pub fn math_initial_value_point_negate(pt : MathinitialvaluePoint) -> MathinitialvaluePoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn math_initial_value_point_mid(a : MathinitialvaluePoint, b : MathinitialvaluePoint) -> MathinitialvaluePoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn math_initial_value_point_lerp(a : MathinitialvaluePoint, b : MathinitialvaluePoint, t : Double) -> MathinitialvaluePoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn math_initial_value_point_to_string(pt : MathinitialvaluePoint) -> String {
  "(" + math_initial_value_dbl(pt.x) + ", " + math_initial_value_dbl(pt.y) + ", " + math_initial_value_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct MathinitialvalueSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn math_initial_value_make_series(vals : Array[Double], name : String) -> MathinitialvalueSeries {
  { vals, name, meta: 0 }
}

pub fn math_initial_value_series_len(s : MathinitialvalueSeries) -> Int { s.vals.length() }

pub fn math_initial_value_series_sum(s : MathinitialvalueSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn math_initial_value_series_mean(s : MathinitialvalueSeries) -> Double {
  let n = math_initial_value_series_len(s)
  if n == 0 { 0.0 } else { math_initial_value_series_sum(s) / n.to_double() }
}

pub fn math_initial_value_series_min(s : MathinitialvalueSeries) -> Double {
  let n = math_initial_value_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn math_initial_value_series_max(s : MathinitialvalueSeries) -> Double {
  let n = math_initial_value_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn math_initial_value_series_range(s : MathinitialvalueSeries) -> Double {
  math_initial_value_series_max(s) - math_initial_value_series_min(s)
}

pub fn math_initial_value_series_var(s : MathinitialvalueSeries) -> Double {
  let n = math_initial_value_series_len(s)
  if n == 0 { 0.0 } else {
    let m = math_initial_value_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn math_initial_value_series_std(s : MathinitialvalueSeries) -> Double { math_initial_value_sqrt(math_initial_value_series_var(s)) }

pub fn math_initial_value_series_median(s : MathinitialvalueSeries) -> Double {
  let n = math_initial_value_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = math_initial_value_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn math_initial_value_series_scale(s : MathinitialvalueSeries, f : Double) -> MathinitialvalueSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = math_initial_value_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn math_initial_value_series_add(a : MathinitialvalueSeries, b : MathinitialvalueSeries) -> MathinitialvalueSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = math_initial_value_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn math_initial_value_series_sub(a : MathinitialvalueSeries, b : MathinitialvalueSeries) -> MathinitialvalueSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = math_initial_value_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn math_initial_value_series_normalize(s : MathinitialvalueSeries) -> MathinitialvalueSeries {
  let mn = math_initial_value_series_min(s)
  let mx = math_initial_value_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = math_initial_value_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn math_initial_value_series_cumsum(s : MathinitialvalueSeries) -> MathinitialvalueSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = math_initial_value_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn math_initial_value_series_to_string(s : MathinitialvalueSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + math_initial_value_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MathinitialvalueMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn math_initial_value_make_matrix(rows : Int, cols : Int, val : Double) -> MathinitialvalueMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn math_initial_value_matrix_identity(n : Int) -> MathinitialvalueMatrix {
  let m = math_initial_value_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn math_initial_value_matrix_get(m : MathinitialvalueMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn math_initial_value_matrix_transpose(m : MathinitialvalueMatrix) -> MathinitialvalueMatrix {
  let result = math_initial_value_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn math_initial_value_matrix_add(a : MathinitialvalueMatrix, b : MathinitialvalueMatrix) -> MathinitialvalueMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = math_initial_value_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn math_initial_value_matrix_scale(m : MathinitialvalueMatrix, s : Double) -> MathinitialvalueMatrix {
  let result = math_initial_value_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn math_initial_value_matrix_multiply(a : MathinitialvalueMatrix, b : MathinitialvalueMatrix) -> MathinitialvalueMatrix {
  if a.cols != b.rows { return math_initial_value_make_matrix(a.rows, b.cols, 0.0) }
  let result = math_initial_value_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn math_initial_value_matrix_trace(m : MathinitialvalueMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn math_initial_value_matrix_det(m : MathinitialvalueMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn math_initial_value_matrix_norm(m : MathinitialvalueMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  math_initial_value_sqrt(sum)
}

pub fn math_initial_value_matrix_to_string(m : MathinitialvalueMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + math_initial_value_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct MathinitialvalueVector {
  comps : Array[Double]
  dim : Int
}

pub fn math_initial_value_make_vector(comps : Array[Double]) -> MathinitialvalueVector {
  { comps, dim: comps.length() }
}

pub fn math_initial_value_vector_zero(dim : Int) -> MathinitialvalueVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn math_initial_value_vector_add(a : MathinitialvalueVector, b : MathinitialvalueVector) -> MathinitialvalueVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = math_initial_value_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn math_initial_value_vector_sub(a : MathinitialvalueVector, b : MathinitialvalueVector) -> MathinitialvalueVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = math_initial_value_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn math_initial_value_vector_scale(v : MathinitialvalueVector, s : Double) -> MathinitialvalueVector {
  let mut result = []
  for i in 0..<v.dim { result = math_initial_value_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn math_initial_value_vector_dot(a : MathinitialvalueVector, b : MathinitialvalueVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn math_initial_value_vector_norm(v : MathinitialvalueVector) -> Double { math_initial_value_sqrt(math_initial_value_vector_dot(v, v)) }

pub fn math_initial_value_vector_normalize(v : MathinitialvalueVector) -> MathinitialvalueVector {
  let n = math_initial_value_vector_norm(v)
  if n < 0.0000001 { v } else { math_initial_value_vector_scale(v, 1.0 / n) }
}

pub fn math_initial_value_vector_dist(a : MathinitialvalueVector, b : MathinitialvalueVector) -> Double {
  math_initial_value_vector_norm(math_initial_value_vector_sub(a, b))
}

pub fn math_initial_value_vector_to_string(v : MathinitialvalueVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + math_initial_value_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn math_initial_value_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn math_initial_value_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = math_initial_value_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn math_initial_value_std(data : Array[Double]) -> Double { math_initial_value_sqrt(math_initial_value_var(data)) }

pub fn math_initial_value_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = math_initial_value_mean(a); let mb = math_initial_value_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn math_initial_value_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = math_initial_value_std(a); let sb = math_initial_value_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { math_initial_value_cov(a, b) / (sa * sb) }
}

pub fn math_initial_value_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = math_initial_value_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn math_initial_value_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn math_initial_value_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn math_initial_value_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  math_initial_value_sqrt(math_initial_value_mse(pred, labels))
}

pub fn math_initial_value_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + math_initial_value_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn math_initial_value_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = math_initial_value_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn math_initial_value_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn math_initial_value_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn math_initial_value_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = math_initial_value_precision(pred, labels, pos); let r = math_initial_value_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn math_initial_value_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn math_initial_value_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = math_initial_value_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn math_initial_value_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn math_initial_value_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn math_initial_value_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = math_initial_value_gcd(a, b)
    (a / g) * b
  }
}

pub fn math_initial_value_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn math_initial_value_fibonacci(n : Int) -> Int {
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

pub fn math_initial_value_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = math_initial_value_min(data); let mx = math_initial_value_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn math_initial_value_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = math_initial_value_mean(data); let sd = math_initial_value_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn math_initial_value_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn math_initial_value_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn math_initial_value_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn math_initial_value_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn math_initial_value_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn math_initial_value_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn math_initial_value_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn math_initial_value_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn math_initial_value_dbl(x : Double) -> String {
  let i = if x >= 0.0 { math_initial_value_int(x) } else { -math_initial_value_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { math_initial_value_int(f * 1000000.0) } else { math_initial_value_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn math_initial_value_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn math_initial_value_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct MathinitialvalueFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_initial_value_frame_make(size : Int) -> MathinitialvalueFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_initial_value_frame_len(s : MathinitialvalueFrame) -> Int { s.size }

pub fn math_initial_value_frame_get(s : MathinitialvalueFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_initial_value_frame_set(s : MathinitialvalueFrame, i : Int, v : Double) -> MathinitialvalueFrame {
  let result = math_initial_value_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_initial_value_frame_sum(s : MathinitialvalueFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_initial_value_frame_mean(s : MathinitialvalueFrame) -> Double {
  if s.size == 0 { 0.0 } else { math_initial_value_frame_sum(s) / s.size.to_double() }
}

pub fn math_initial_value_frame_scale(s : MathinitialvalueFrame, f : Double) -> MathinitialvalueFrame {
  let result = math_initial_value_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_initial_value_frame_add(a : MathinitialvalueFrame, b : MathinitialvalueFrame) -> MathinitialvalueFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_initial_value_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_initial_value_frame_copy(s : MathinitialvalueFrame) -> MathinitialvalueFrame {
  let result = math_initial_value_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_initial_value_frame_fill(s : MathinitialvalueFrame, v : Double) -> MathinitialvalueFrame {
  let result = math_initial_value_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_initial_value_frame_min(s : MathinitialvalueFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_initial_value_frame_max(s : MathinitialvalueFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_initial_value_frame_to_string(s : MathinitialvalueFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathinitialvalueTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_initial_value_table_make(size : Int) -> MathinitialvalueTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_initial_value_table_len(s : MathinitialvalueTable) -> Int { s.size }

pub fn math_initial_value_table_get(s : MathinitialvalueTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_initial_value_table_set(s : MathinitialvalueTable, i : Int, v : Double) -> MathinitialvalueTable {
  let result = math_initial_value_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_initial_value_table_sum(s : MathinitialvalueTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_initial_value_table_mean(s : MathinitialvalueTable) -> Double {
  if s.size == 0 { 0.0 } else { math_initial_value_table_sum(s) / s.size.to_double() }
}

pub fn math_initial_value_table_scale(s : MathinitialvalueTable, f : Double) -> MathinitialvalueTable {
  let result = math_initial_value_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_initial_value_table_add(a : MathinitialvalueTable, b : MathinitialvalueTable) -> MathinitialvalueTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_initial_value_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_initial_value_table_copy(s : MathinitialvalueTable) -> MathinitialvalueTable {
  let result = math_initial_value_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_initial_value_table_fill(s : MathinitialvalueTable, v : Double) -> MathinitialvalueTable {
  let result = math_initial_value_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_initial_value_table_min(s : MathinitialvalueTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_initial_value_table_max(s : MathinitialvalueTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_initial_value_table_to_string(s : MathinitialvalueTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathinitialvalueGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_initial_value_graphn_make(size : Int) -> MathinitialvalueGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_initial_value_graphn_len(s : MathinitialvalueGraphN) -> Int { s.size }

pub fn math_initial_value_graphn_get(s : MathinitialvalueGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_initial_value_graphn_set(s : MathinitialvalueGraphN, i : Int, v : Double) -> MathinitialvalueGraphN {
  let result = math_initial_value_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_initial_value_graphn_sum(s : MathinitialvalueGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_initial_value_graphn_mean(s : MathinitialvalueGraphN) -> Double {
  if s.size == 0 { 0.0 } else { math_initial_value_graphn_sum(s) / s.size.to_double() }
}

pub fn math_initial_value_graphn_scale(s : MathinitialvalueGraphN, f : Double) -> MathinitialvalueGraphN {
  let result = math_initial_value_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_initial_value_graphn_add(a : MathinitialvalueGraphN, b : MathinitialvalueGraphN) -> MathinitialvalueGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_initial_value_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_initial_value_graphn_copy(s : MathinitialvalueGraphN) -> MathinitialvalueGraphN {
  let result = math_initial_value_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_initial_value_graphn_fill(s : MathinitialvalueGraphN, v : Double) -> MathinitialvalueGraphN {
  let result = math_initial_value_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_initial_value_graphn_min(s : MathinitialvalueGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_initial_value_graphn_max(s : MathinitialvalueGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_initial_value_graphn_to_string(s : MathinitialvalueGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathinitialvalueNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_initial_value_node_make(size : Int) -> MathinitialvalueNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_initial_value_node_len(s : MathinitialvalueNode) -> Int { s.size }

pub fn math_initial_value_node_get(s : MathinitialvalueNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_initial_value_node_set(s : MathinitialvalueNode, i : Int, v : Double) -> MathinitialvalueNode {
  let result = math_initial_value_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_initial_value_node_sum(s : MathinitialvalueNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_initial_value_node_mean(s : MathinitialvalueNode) -> Double {
  if s.size == 0 { 0.0 } else { math_initial_value_node_sum(s) / s.size.to_double() }
}

pub fn math_initial_value_node_scale(s : MathinitialvalueNode, f : Double) -> MathinitialvalueNode {
  let result = math_initial_value_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_initial_value_node_add(a : MathinitialvalueNode, b : MathinitialvalueNode) -> MathinitialvalueNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_initial_value_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_initial_value_node_copy(s : MathinitialvalueNode) -> MathinitialvalueNode {
  let result = math_initial_value_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_initial_value_node_fill(s : MathinitialvalueNode, v : Double) -> MathinitialvalueNode {
  let result = math_initial_value_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_initial_value_node_min(s : MathinitialvalueNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_initial_value_node_max(s : MathinitialvalueNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_initial_value_node_to_string(s : MathinitialvalueNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathinitialvalueEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_initial_value_edge_make(size : Int) -> MathinitialvalueEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_initial_value_edge_len(s : MathinitialvalueEdge) -> Int { s.size }

pub fn math_initial_value_edge_get(s : MathinitialvalueEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_initial_value_edge_set(s : MathinitialvalueEdge, i : Int, v : Double) -> MathinitialvalueEdge {
  let result = math_initial_value_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_initial_value_edge_sum(s : MathinitialvalueEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_initial_value_edge_mean(s : MathinitialvalueEdge) -> Double {
  if s.size == 0 { 0.0 } else { math_initial_value_edge_sum(s) / s.size.to_double() }
}

pub fn math_initial_value_edge_scale(s : MathinitialvalueEdge, f : Double) -> MathinitialvalueEdge {
  let result = math_initial_value_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_initial_value_edge_add(a : MathinitialvalueEdge, b : MathinitialvalueEdge) -> MathinitialvalueEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_initial_value_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_initial_value_edge_copy(s : MathinitialvalueEdge) -> MathinitialvalueEdge {
  let result = math_initial_value_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_initial_value_edge_fill(s : MathinitialvalueEdge, v : Double) -> MathinitialvalueEdge {
  let result = math_initial_value_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_initial_value_edge_min(s : MathinitialvalueEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_initial_value_edge_max(s : MathinitialvalueEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_initial_value_edge_to_string(s : MathinitialvalueEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathinitialvaluePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_initial_value_path_make(size : Int) -> MathinitialvaluePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_initial_value_path_len(s : MathinitialvaluePath) -> Int { s.size }

pub fn math_initial_value_path_get(s : MathinitialvaluePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_initial_value_path_set(s : MathinitialvaluePath, i : Int, v : Double) -> MathinitialvaluePath {
  let result = math_initial_value_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_initial_value_path_sum(s : MathinitialvaluePath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_initial_value_path_mean(s : MathinitialvaluePath) -> Double {
  if s.size == 0 { 0.0 } else { math_initial_value_path_sum(s) / s.size.to_double() }
}

pub fn math_initial_value_path_scale(s : MathinitialvaluePath, f : Double) -> MathinitialvaluePath {
  let result = math_initial_value_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_initial_value_path_add(a : MathinitialvaluePath, b : MathinitialvaluePath) -> MathinitialvaluePath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_initial_value_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_initial_value_path_copy(s : MathinitialvaluePath) -> MathinitialvaluePath {
  let result = math_initial_value_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_initial_value_path_fill(s : MathinitialvaluePath, v : Double) -> MathinitialvaluePath {
  let result = math_initial_value_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_initial_value_path_min(s : MathinitialvaluePath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_initial_value_path_max(s : MathinitialvaluePath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_initial_value_path_to_string(s : MathinitialvaluePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathinitialvalueCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_initial_value_cluster_make(size : Int) -> MathinitialvalueCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_initial_value_cluster_len(s : MathinitialvalueCluster) -> Int { s.size }

pub fn math_initial_value_cluster_get(s : MathinitialvalueCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_initial_value_cluster_set(s : MathinitialvalueCluster, i : Int, v : Double) -> MathinitialvalueCluster {
  let result = math_initial_value_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_initial_value_cluster_sum(s : MathinitialvalueCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_initial_value_cluster_mean(s : MathinitialvalueCluster) -> Double {
  if s.size == 0 { 0.0 } else { math_initial_value_cluster_sum(s) / s.size.to_double() }
}

pub fn math_initial_value_cluster_scale(s : MathinitialvalueCluster, f : Double) -> MathinitialvalueCluster {
  let result = math_initial_value_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_initial_value_cluster_add(a : MathinitialvalueCluster, b : MathinitialvalueCluster) -> MathinitialvalueCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_initial_value_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_initial_value_cluster_copy(s : MathinitialvalueCluster) -> MathinitialvalueCluster {
  let result = math_initial_value_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_initial_value_cluster_fill(s : MathinitialvalueCluster, v : Double) -> MathinitialvalueCluster {
  let result = math_initial_value_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_initial_value_cluster_min(s : MathinitialvalueCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_initial_value_cluster_max(s : MathinitialvalueCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_initial_value_cluster_to_string(s : MathinitialvalueCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathinitialvalueModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_initial_value_model_make(size : Int) -> MathinitialvalueModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_initial_value_model_len(s : MathinitialvalueModel) -> Int { s.size }

pub fn math_initial_value_model_get(s : MathinitialvalueModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_initial_value_model_set(s : MathinitialvalueModel, i : Int, v : Double) -> MathinitialvalueModel {
  let result = math_initial_value_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_initial_value_model_sum(s : MathinitialvalueModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_initial_value_model_mean(s : MathinitialvalueModel) -> Double {
  if s.size == 0 { 0.0 } else { math_initial_value_model_sum(s) / s.size.to_double() }
}

pub fn math_initial_value_model_scale(s : MathinitialvalueModel, f : Double) -> MathinitialvalueModel {
  let result = math_initial_value_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_initial_value_model_add(a : MathinitialvalueModel, b : MathinitialvalueModel) -> MathinitialvalueModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_initial_value_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_initial_value_model_copy(s : MathinitialvalueModel) -> MathinitialvalueModel {
  let result = math_initial_value_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_initial_value_model_fill(s : MathinitialvalueModel, v : Double) -> MathinitialvalueModel {
  let result = math_initial_value_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_initial_value_model_min(s : MathinitialvalueModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_initial_value_model_max(s : MathinitialvalueModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_initial_value_model_to_string(s : MathinitialvalueModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathinitialvalueLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_initial_value_layer_make(size : Int) -> MathinitialvalueLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_initial_value_layer_len(s : MathinitialvalueLayer) -> Int { s.size }

pub fn math_initial_value_layer_get(s : MathinitialvalueLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_initial_value_layer_set(s : MathinitialvalueLayer, i : Int, v : Double) -> MathinitialvalueLayer {
  let result = math_initial_value_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_initial_value_layer_sum(s : MathinitialvalueLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_initial_value_layer_mean(s : MathinitialvalueLayer) -> Double {
  if s.size == 0 { 0.0 } else { math_initial_value_layer_sum(s) / s.size.to_double() }
}

pub fn math_initial_value_layer_scale(s : MathinitialvalueLayer, f : Double) -> MathinitialvalueLayer {
  let result = math_initial_value_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_initial_value_layer_add(a : MathinitialvalueLayer, b : MathinitialvalueLayer) -> MathinitialvalueLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_initial_value_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_initial_value_layer_copy(s : MathinitialvalueLayer) -> MathinitialvalueLayer {
  let result = math_initial_value_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_initial_value_layer_fill(s : MathinitialvalueLayer, v : Double) -> MathinitialvalueLayer {
  let result = math_initial_value_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_initial_value_layer_min(s : MathinitialvalueLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_initial_value_layer_max(s : MathinitialvalueLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_initial_value_layer_to_string(s : MathinitialvalueLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathinitialvalueBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_initial_value_buffer_make(size : Int) -> MathinitialvalueBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_initial_value_buffer_len(s : MathinitialvalueBuffer) -> Int { s.size }

pub fn math_initial_value_buffer_get(s : MathinitialvalueBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_initial_value_buffer_set(s : MathinitialvalueBuffer, i : Int, v : Double) -> MathinitialvalueBuffer {
  let result = math_initial_value_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_initial_value_buffer_sum(s : MathinitialvalueBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_initial_value_buffer_mean(s : MathinitialvalueBuffer) -> Double {
  if s.size == 0 { 0.0 } else { math_initial_value_buffer_sum(s) / s.size.to_double() }
}

pub fn math_initial_value_buffer_scale(s : MathinitialvalueBuffer, f : Double) -> MathinitialvalueBuffer {
  let result = math_initial_value_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_initial_value_buffer_add(a : MathinitialvalueBuffer, b : MathinitialvalueBuffer) -> MathinitialvalueBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_initial_value_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_initial_value_buffer_copy(s : MathinitialvalueBuffer) -> MathinitialvalueBuffer {
  let result = math_initial_value_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_initial_value_buffer_fill(s : MathinitialvalueBuffer, v : Double) -> MathinitialvalueBuffer {
  let result = math_initial_value_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_initial_value_buffer_min(s : MathinitialvalueBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_initial_value_buffer_max(s : MathinitialvalueBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_initial_value_buffer_to_string(s : MathinitialvalueBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathinitialvalueCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_initial_value_cursor_make(size : Int) -> MathinitialvalueCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_initial_value_cursor_len(s : MathinitialvalueCursor) -> Int { s.size }

pub fn math_initial_value_cursor_get(s : MathinitialvalueCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_initial_value_cursor_set(s : MathinitialvalueCursor, i : Int, v : Double) -> MathinitialvalueCursor {
  let result = math_initial_value_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_initial_value_cursor_sum(s : MathinitialvalueCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_initial_value_cursor_mean(s : MathinitialvalueCursor) -> Double {
  if s.size == 0 { 0.0 } else { math_initial_value_cursor_sum(s) / s.size.to_double() }
}

pub fn math_initial_value_cursor_scale(s : MathinitialvalueCursor, f : Double) -> MathinitialvalueCursor {
  let result = math_initial_value_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_initial_value_cursor_add(a : MathinitialvalueCursor, b : MathinitialvalueCursor) -> MathinitialvalueCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_initial_value_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_initial_value_cursor_copy(s : MathinitialvalueCursor) -> MathinitialvalueCursor {
  let result = math_initial_value_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_initial_value_cursor_fill(s : MathinitialvalueCursor, v : Double) -> MathinitialvalueCursor {
  let result = math_initial_value_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_initial_value_cursor_min(s : MathinitialvalueCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_initial_value_cursor_max(s : MathinitialvalueCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_initial_value_cursor_to_string(s : MathinitialvalueCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathinitialvalueView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_initial_value_view_make(size : Int) -> MathinitialvalueView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_initial_value_view_len(s : MathinitialvalueView) -> Int { s.size }

pub fn math_initial_value_view_get(s : MathinitialvalueView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_initial_value_view_set(s : MathinitialvalueView, i : Int, v : Double) -> MathinitialvalueView {
  let result = math_initial_value_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_initial_value_view_sum(s : MathinitialvalueView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_initial_value_view_mean(s : MathinitialvalueView) -> Double {
  if s.size == 0 { 0.0 } else { math_initial_value_view_sum(s) / s.size.to_double() }
}

pub fn math_initial_value_view_scale(s : MathinitialvalueView, f : Double) -> MathinitialvalueView {
  let result = math_initial_value_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_initial_value_view_add(a : MathinitialvalueView, b : MathinitialvalueView) -> MathinitialvalueView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_initial_value_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_initial_value_view_copy(s : MathinitialvalueView) -> MathinitialvalueView {
  let result = math_initial_value_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_initial_value_view_fill(s : MathinitialvalueView, v : Double) -> MathinitialvalueView {
  let result = math_initial_value_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_initial_value_view_min(s : MathinitialvalueView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_initial_value_view_max(s : MathinitialvalueView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_initial_value_view_to_string(s : MathinitialvalueView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathinitialvalueRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_initial_value_range_make(size : Int) -> MathinitialvalueRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_initial_value_range_len(s : MathinitialvalueRange) -> Int { s.size }

pub fn math_initial_value_range_get(s : MathinitialvalueRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_initial_value_range_set(s : MathinitialvalueRange, i : Int, v : Double) -> MathinitialvalueRange {
  let result = math_initial_value_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_initial_value_range_sum(s : MathinitialvalueRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_initial_value_range_mean(s : MathinitialvalueRange) -> Double {
  if s.size == 0 { 0.0 } else { math_initial_value_range_sum(s) / s.size.to_double() }
}

pub fn math_initial_value_range_scale(s : MathinitialvalueRange, f : Double) -> MathinitialvalueRange {
  let result = math_initial_value_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_initial_value_range_add(a : MathinitialvalueRange, b : MathinitialvalueRange) -> MathinitialvalueRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_initial_value_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_initial_value_range_copy(s : MathinitialvalueRange) -> MathinitialvalueRange {
  let result = math_initial_value_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_initial_value_range_fill(s : MathinitialvalueRange, v : Double) -> MathinitialvalueRange {
  let result = math_initial_value_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_initial_value_range_min(s : MathinitialvalueRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_initial_value_range_max(s : MathinitialvalueRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_initial_value_range_to_string(s : MathinitialvalueRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathinitialvalueSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_initial_value_slice_make(size : Int) -> MathinitialvalueSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_initial_value_slice_len(s : MathinitialvalueSlice) -> Int { s.size }

pub fn math_initial_value_slice_get(s : MathinitialvalueSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_initial_value_slice_set(s : MathinitialvalueSlice, i : Int, v : Double) -> MathinitialvalueSlice {
  let result = math_initial_value_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_initial_value_slice_sum(s : MathinitialvalueSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_initial_value_slice_mean(s : MathinitialvalueSlice) -> Double {
  if s.size == 0 { 0.0 } else { math_initial_value_slice_sum(s) / s.size.to_double() }
}

pub fn math_initial_value_slice_scale(s : MathinitialvalueSlice, f : Double) -> MathinitialvalueSlice {
  let result = math_initial_value_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_initial_value_slice_add(a : MathinitialvalueSlice, b : MathinitialvalueSlice) -> MathinitialvalueSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_initial_value_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_initial_value_slice_copy(s : MathinitialvalueSlice) -> MathinitialvalueSlice {
  let result = math_initial_value_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_initial_value_slice_fill(s : MathinitialvalueSlice, v : Double) -> MathinitialvalueSlice {
  let result = math_initial_value_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_initial_value_slice_min(s : MathinitialvalueSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_initial_value_slice_max(s : MathinitialvalueSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_initial_value_slice_to_string(s : MathinitialvalueSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn math_initial_value_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_initial_value_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_initial_value_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_initial_value_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_initial_value_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_initial_value_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_initial_value_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_initial_value_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_initial_value_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_initial_value_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_initial_value_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_initial_value_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_initial_value_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_initial_value_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_initial_value_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_initial_value_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_initial_value_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_initial_value_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_initial_value_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_initial_value_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_initial_value_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_initial_value_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_initial_value_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_initial_value_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_initial_value_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

