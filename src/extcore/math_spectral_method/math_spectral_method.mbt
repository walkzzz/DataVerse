///===
/// extcore/math_spectral_method

pub(all) struct MathspectralmethodPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn math_spectral_method_make_point(x : Double, y : Double) -> MathspectralmethodPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn math_spectral_method_make_point3(x : Double, y : Double, z : Double) -> MathspectralmethodPoint {
  { x, y, z, label: 0 }
}

pub fn math_spectral_method_point_x(pt : MathspectralmethodPoint) -> Double { pt.x }

pub fn math_spectral_method_point_y(pt : MathspectralmethodPoint) -> Double { pt.y }

pub fn math_spectral_method_point_z(pt : MathspectralmethodPoint) -> Double { pt.z }

pub fn math_spectral_method_point_label(pt : MathspectralmethodPoint) -> Int { pt.label }

pub fn math_spectral_method_point_dist(a : MathspectralmethodPoint, b : MathspectralmethodPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  math_spectral_method_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn math_spectral_method_point_add(a : MathspectralmethodPoint, b : MathspectralmethodPoint) -> MathspectralmethodPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn math_spectral_method_point_sub(a : MathspectralmethodPoint, b : MathspectralmethodPoint) -> MathspectralmethodPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn math_spectral_method_point_scale(pt : MathspectralmethodPoint, s : Double) -> MathspectralmethodPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn math_spectral_method_point_dot(a : MathspectralmethodPoint, b : MathspectralmethodPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn math_spectral_method_point_cross(a : MathspectralmethodPoint, b : MathspectralmethodPoint) -> MathspectralmethodPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn math_spectral_method_point_norm(pt : MathspectralmethodPoint) -> Double {
  math_spectral_method_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn math_spectral_method_point_normalize(pt : MathspectralmethodPoint) -> MathspectralmethodPoint {
  let n = math_spectral_method_point_norm(pt)
  if n < 0.0000001 { pt } else { math_spectral_method_point_scale(pt, 1.0 / n) }
}

pub fn math_spectral_method_point_negate(pt : MathspectralmethodPoint) -> MathspectralmethodPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn math_spectral_method_point_mid(a : MathspectralmethodPoint, b : MathspectralmethodPoint) -> MathspectralmethodPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn math_spectral_method_point_lerp(a : MathspectralmethodPoint, b : MathspectralmethodPoint, t : Double) -> MathspectralmethodPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn math_spectral_method_point_to_string(pt : MathspectralmethodPoint) -> String {
  "(" + math_spectral_method_dbl(pt.x) + ", " + math_spectral_method_dbl(pt.y) + ", " + math_spectral_method_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct MathspectralmethodSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn math_spectral_method_make_series(vals : Array[Double], name : String) -> MathspectralmethodSeries {
  { vals, name, meta: 0 }
}

pub fn math_spectral_method_series_len(s : MathspectralmethodSeries) -> Int { s.vals.length() }

pub fn math_spectral_method_series_sum(s : MathspectralmethodSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn math_spectral_method_series_mean(s : MathspectralmethodSeries) -> Double {
  let n = math_spectral_method_series_len(s)
  if n == 0 { 0.0 } else { math_spectral_method_series_sum(s) / n.to_double() }
}

pub fn math_spectral_method_series_min(s : MathspectralmethodSeries) -> Double {
  let n = math_spectral_method_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn math_spectral_method_series_max(s : MathspectralmethodSeries) -> Double {
  let n = math_spectral_method_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn math_spectral_method_series_range(s : MathspectralmethodSeries) -> Double {
  math_spectral_method_series_max(s) - math_spectral_method_series_min(s)
}

pub fn math_spectral_method_series_var(s : MathspectralmethodSeries) -> Double {
  let n = math_spectral_method_series_len(s)
  if n == 0 { 0.0 } else {
    let m = math_spectral_method_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn math_spectral_method_series_std(s : MathspectralmethodSeries) -> Double { math_spectral_method_sqrt(math_spectral_method_series_var(s)) }

pub fn math_spectral_method_series_median(s : MathspectralmethodSeries) -> Double {
  let n = math_spectral_method_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = math_spectral_method_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn math_spectral_method_series_scale(s : MathspectralmethodSeries, f : Double) -> MathspectralmethodSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = math_spectral_method_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn math_spectral_method_series_add(a : MathspectralmethodSeries, b : MathspectralmethodSeries) -> MathspectralmethodSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = math_spectral_method_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn math_spectral_method_series_sub(a : MathspectralmethodSeries, b : MathspectralmethodSeries) -> MathspectralmethodSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = math_spectral_method_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn math_spectral_method_series_normalize(s : MathspectralmethodSeries) -> MathspectralmethodSeries {
  let mn = math_spectral_method_series_min(s)
  let mx = math_spectral_method_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = math_spectral_method_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn math_spectral_method_series_cumsum(s : MathspectralmethodSeries) -> MathspectralmethodSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = math_spectral_method_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn math_spectral_method_series_to_string(s : MathspectralmethodSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + math_spectral_method_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MathspectralmethodMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn math_spectral_method_make_matrix(rows : Int, cols : Int, val : Double) -> MathspectralmethodMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn math_spectral_method_matrix_identity(n : Int) -> MathspectralmethodMatrix {
  let m = math_spectral_method_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn math_spectral_method_matrix_get(m : MathspectralmethodMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn math_spectral_method_matrix_transpose(m : MathspectralmethodMatrix) -> MathspectralmethodMatrix {
  let result = math_spectral_method_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn math_spectral_method_matrix_add(a : MathspectralmethodMatrix, b : MathspectralmethodMatrix) -> MathspectralmethodMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = math_spectral_method_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn math_spectral_method_matrix_scale(m : MathspectralmethodMatrix, s : Double) -> MathspectralmethodMatrix {
  let result = math_spectral_method_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn math_spectral_method_matrix_multiply(a : MathspectralmethodMatrix, b : MathspectralmethodMatrix) -> MathspectralmethodMatrix {
  if a.cols != b.rows { return math_spectral_method_make_matrix(a.rows, b.cols, 0.0) }
  let result = math_spectral_method_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn math_spectral_method_matrix_trace(m : MathspectralmethodMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn math_spectral_method_matrix_det(m : MathspectralmethodMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn math_spectral_method_matrix_norm(m : MathspectralmethodMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  math_spectral_method_sqrt(sum)
}

pub fn math_spectral_method_matrix_to_string(m : MathspectralmethodMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + math_spectral_method_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct MathspectralmethodVector {
  comps : Array[Double]
  dim : Int
}

pub fn math_spectral_method_make_vector(comps : Array[Double]) -> MathspectralmethodVector {
  { comps, dim: comps.length() }
}

pub fn math_spectral_method_vector_zero(dim : Int) -> MathspectralmethodVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn math_spectral_method_vector_add(a : MathspectralmethodVector, b : MathspectralmethodVector) -> MathspectralmethodVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = math_spectral_method_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn math_spectral_method_vector_sub(a : MathspectralmethodVector, b : MathspectralmethodVector) -> MathspectralmethodVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = math_spectral_method_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn math_spectral_method_vector_scale(v : MathspectralmethodVector, s : Double) -> MathspectralmethodVector {
  let mut result = []
  for i in 0..<v.dim { result = math_spectral_method_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn math_spectral_method_vector_dot(a : MathspectralmethodVector, b : MathspectralmethodVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn math_spectral_method_vector_norm(v : MathspectralmethodVector) -> Double { math_spectral_method_sqrt(math_spectral_method_vector_dot(v, v)) }

pub fn math_spectral_method_vector_normalize(v : MathspectralmethodVector) -> MathspectralmethodVector {
  let n = math_spectral_method_vector_norm(v)
  if n < 0.0000001 { v } else { math_spectral_method_vector_scale(v, 1.0 / n) }
}

pub fn math_spectral_method_vector_dist(a : MathspectralmethodVector, b : MathspectralmethodVector) -> Double {
  math_spectral_method_vector_norm(math_spectral_method_vector_sub(a, b))
}

pub fn math_spectral_method_vector_to_string(v : MathspectralmethodVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + math_spectral_method_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn math_spectral_method_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn math_spectral_method_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = math_spectral_method_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn math_spectral_method_std(data : Array[Double]) -> Double { math_spectral_method_sqrt(math_spectral_method_var(data)) }

pub fn math_spectral_method_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = math_spectral_method_mean(a); let mb = math_spectral_method_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn math_spectral_method_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = math_spectral_method_std(a); let sb = math_spectral_method_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { math_spectral_method_cov(a, b) / (sa * sb) }
}

pub fn math_spectral_method_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = math_spectral_method_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn math_spectral_method_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn math_spectral_method_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn math_spectral_method_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  math_spectral_method_sqrt(math_spectral_method_mse(pred, labels))
}

pub fn math_spectral_method_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + math_spectral_method_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn math_spectral_method_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = math_spectral_method_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn math_spectral_method_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn math_spectral_method_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn math_spectral_method_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = math_spectral_method_precision(pred, labels, pos); let r = math_spectral_method_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn math_spectral_method_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn math_spectral_method_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = math_spectral_method_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn math_spectral_method_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn math_spectral_method_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn math_spectral_method_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = math_spectral_method_gcd(a, b)
    (a / g) * b
  }
}

pub fn math_spectral_method_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn math_spectral_method_fibonacci(n : Int) -> Int {
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

pub fn math_spectral_method_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = math_spectral_method_min(data); let mx = math_spectral_method_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn math_spectral_method_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = math_spectral_method_mean(data); let sd = math_spectral_method_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn math_spectral_method_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn math_spectral_method_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn math_spectral_method_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn math_spectral_method_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn math_spectral_method_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn math_spectral_method_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn math_spectral_method_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn math_spectral_method_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn math_spectral_method_dbl(x : Double) -> String {
  let i = if x >= 0.0 { math_spectral_method_int(x) } else { -math_spectral_method_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { math_spectral_method_int(f * 1000000.0) } else { math_spectral_method_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn math_spectral_method_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn math_spectral_method_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct MathspectralmethodFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_spectral_method_frame_make(size : Int) -> MathspectralmethodFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_spectral_method_frame_len(s : MathspectralmethodFrame) -> Int { s.size }

pub fn math_spectral_method_frame_get(s : MathspectralmethodFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_spectral_method_frame_set(s : MathspectralmethodFrame, i : Int, v : Double) -> MathspectralmethodFrame {
  let result = math_spectral_method_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_spectral_method_frame_sum(s : MathspectralmethodFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_spectral_method_frame_mean(s : MathspectralmethodFrame) -> Double {
  if s.size == 0 { 0.0 } else { math_spectral_method_frame_sum(s) / s.size.to_double() }
}

pub fn math_spectral_method_frame_scale(s : MathspectralmethodFrame, f : Double) -> MathspectralmethodFrame {
  let result = math_spectral_method_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_spectral_method_frame_add(a : MathspectralmethodFrame, b : MathspectralmethodFrame) -> MathspectralmethodFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_spectral_method_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_spectral_method_frame_copy(s : MathspectralmethodFrame) -> MathspectralmethodFrame {
  let result = math_spectral_method_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_spectral_method_frame_fill(s : MathspectralmethodFrame, v : Double) -> MathspectralmethodFrame {
  let result = math_spectral_method_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_spectral_method_frame_min(s : MathspectralmethodFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_spectral_method_frame_max(s : MathspectralmethodFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_spectral_method_frame_to_string(s : MathspectralmethodFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspectralmethodTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_spectral_method_table_make(size : Int) -> MathspectralmethodTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_spectral_method_table_len(s : MathspectralmethodTable) -> Int { s.size }

pub fn math_spectral_method_table_get(s : MathspectralmethodTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_spectral_method_table_set(s : MathspectralmethodTable, i : Int, v : Double) -> MathspectralmethodTable {
  let result = math_spectral_method_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_spectral_method_table_sum(s : MathspectralmethodTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_spectral_method_table_mean(s : MathspectralmethodTable) -> Double {
  if s.size == 0 { 0.0 } else { math_spectral_method_table_sum(s) / s.size.to_double() }
}

pub fn math_spectral_method_table_scale(s : MathspectralmethodTable, f : Double) -> MathspectralmethodTable {
  let result = math_spectral_method_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_spectral_method_table_add(a : MathspectralmethodTable, b : MathspectralmethodTable) -> MathspectralmethodTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_spectral_method_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_spectral_method_table_copy(s : MathspectralmethodTable) -> MathspectralmethodTable {
  let result = math_spectral_method_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_spectral_method_table_fill(s : MathspectralmethodTable, v : Double) -> MathspectralmethodTable {
  let result = math_spectral_method_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_spectral_method_table_min(s : MathspectralmethodTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_spectral_method_table_max(s : MathspectralmethodTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_spectral_method_table_to_string(s : MathspectralmethodTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspectralmethodGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_spectral_method_graphn_make(size : Int) -> MathspectralmethodGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_spectral_method_graphn_len(s : MathspectralmethodGraphN) -> Int { s.size }

pub fn math_spectral_method_graphn_get(s : MathspectralmethodGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_spectral_method_graphn_set(s : MathspectralmethodGraphN, i : Int, v : Double) -> MathspectralmethodGraphN {
  let result = math_spectral_method_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_spectral_method_graphn_sum(s : MathspectralmethodGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_spectral_method_graphn_mean(s : MathspectralmethodGraphN) -> Double {
  if s.size == 0 { 0.0 } else { math_spectral_method_graphn_sum(s) / s.size.to_double() }
}

pub fn math_spectral_method_graphn_scale(s : MathspectralmethodGraphN, f : Double) -> MathspectralmethodGraphN {
  let result = math_spectral_method_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_spectral_method_graphn_add(a : MathspectralmethodGraphN, b : MathspectralmethodGraphN) -> MathspectralmethodGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_spectral_method_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_spectral_method_graphn_copy(s : MathspectralmethodGraphN) -> MathspectralmethodGraphN {
  let result = math_spectral_method_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_spectral_method_graphn_fill(s : MathspectralmethodGraphN, v : Double) -> MathspectralmethodGraphN {
  let result = math_spectral_method_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_spectral_method_graphn_min(s : MathspectralmethodGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_spectral_method_graphn_max(s : MathspectralmethodGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_spectral_method_graphn_to_string(s : MathspectralmethodGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspectralmethodNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_spectral_method_node_make(size : Int) -> MathspectralmethodNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_spectral_method_node_len(s : MathspectralmethodNode) -> Int { s.size }

pub fn math_spectral_method_node_get(s : MathspectralmethodNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_spectral_method_node_set(s : MathspectralmethodNode, i : Int, v : Double) -> MathspectralmethodNode {
  let result = math_spectral_method_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_spectral_method_node_sum(s : MathspectralmethodNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_spectral_method_node_mean(s : MathspectralmethodNode) -> Double {
  if s.size == 0 { 0.0 } else { math_spectral_method_node_sum(s) / s.size.to_double() }
}

pub fn math_spectral_method_node_scale(s : MathspectralmethodNode, f : Double) -> MathspectralmethodNode {
  let result = math_spectral_method_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_spectral_method_node_add(a : MathspectralmethodNode, b : MathspectralmethodNode) -> MathspectralmethodNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_spectral_method_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_spectral_method_node_copy(s : MathspectralmethodNode) -> MathspectralmethodNode {
  let result = math_spectral_method_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_spectral_method_node_fill(s : MathspectralmethodNode, v : Double) -> MathspectralmethodNode {
  let result = math_spectral_method_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_spectral_method_node_min(s : MathspectralmethodNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_spectral_method_node_max(s : MathspectralmethodNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_spectral_method_node_to_string(s : MathspectralmethodNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspectralmethodEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_spectral_method_edge_make(size : Int) -> MathspectralmethodEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_spectral_method_edge_len(s : MathspectralmethodEdge) -> Int { s.size }

pub fn math_spectral_method_edge_get(s : MathspectralmethodEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_spectral_method_edge_set(s : MathspectralmethodEdge, i : Int, v : Double) -> MathspectralmethodEdge {
  let result = math_spectral_method_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_spectral_method_edge_sum(s : MathspectralmethodEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_spectral_method_edge_mean(s : MathspectralmethodEdge) -> Double {
  if s.size == 0 { 0.0 } else { math_spectral_method_edge_sum(s) / s.size.to_double() }
}

pub fn math_spectral_method_edge_scale(s : MathspectralmethodEdge, f : Double) -> MathspectralmethodEdge {
  let result = math_spectral_method_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_spectral_method_edge_add(a : MathspectralmethodEdge, b : MathspectralmethodEdge) -> MathspectralmethodEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_spectral_method_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_spectral_method_edge_copy(s : MathspectralmethodEdge) -> MathspectralmethodEdge {
  let result = math_spectral_method_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_spectral_method_edge_fill(s : MathspectralmethodEdge, v : Double) -> MathspectralmethodEdge {
  let result = math_spectral_method_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_spectral_method_edge_min(s : MathspectralmethodEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_spectral_method_edge_max(s : MathspectralmethodEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_spectral_method_edge_to_string(s : MathspectralmethodEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspectralmethodPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_spectral_method_path_make(size : Int) -> MathspectralmethodPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_spectral_method_path_len(s : MathspectralmethodPath) -> Int { s.size }

pub fn math_spectral_method_path_get(s : MathspectralmethodPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_spectral_method_path_set(s : MathspectralmethodPath, i : Int, v : Double) -> MathspectralmethodPath {
  let result = math_spectral_method_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_spectral_method_path_sum(s : MathspectralmethodPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_spectral_method_path_mean(s : MathspectralmethodPath) -> Double {
  if s.size == 0 { 0.0 } else { math_spectral_method_path_sum(s) / s.size.to_double() }
}

pub fn math_spectral_method_path_scale(s : MathspectralmethodPath, f : Double) -> MathspectralmethodPath {
  let result = math_spectral_method_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_spectral_method_path_add(a : MathspectralmethodPath, b : MathspectralmethodPath) -> MathspectralmethodPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_spectral_method_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_spectral_method_path_copy(s : MathspectralmethodPath) -> MathspectralmethodPath {
  let result = math_spectral_method_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_spectral_method_path_fill(s : MathspectralmethodPath, v : Double) -> MathspectralmethodPath {
  let result = math_spectral_method_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_spectral_method_path_min(s : MathspectralmethodPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_spectral_method_path_max(s : MathspectralmethodPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_spectral_method_path_to_string(s : MathspectralmethodPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspectralmethodCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_spectral_method_cluster_make(size : Int) -> MathspectralmethodCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_spectral_method_cluster_len(s : MathspectralmethodCluster) -> Int { s.size }

pub fn math_spectral_method_cluster_get(s : MathspectralmethodCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_spectral_method_cluster_set(s : MathspectralmethodCluster, i : Int, v : Double) -> MathspectralmethodCluster {
  let result = math_spectral_method_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_spectral_method_cluster_sum(s : MathspectralmethodCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_spectral_method_cluster_mean(s : MathspectralmethodCluster) -> Double {
  if s.size == 0 { 0.0 } else { math_spectral_method_cluster_sum(s) / s.size.to_double() }
}

pub fn math_spectral_method_cluster_scale(s : MathspectralmethodCluster, f : Double) -> MathspectralmethodCluster {
  let result = math_spectral_method_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_spectral_method_cluster_add(a : MathspectralmethodCluster, b : MathspectralmethodCluster) -> MathspectralmethodCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_spectral_method_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_spectral_method_cluster_copy(s : MathspectralmethodCluster) -> MathspectralmethodCluster {
  let result = math_spectral_method_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_spectral_method_cluster_fill(s : MathspectralmethodCluster, v : Double) -> MathspectralmethodCluster {
  let result = math_spectral_method_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_spectral_method_cluster_min(s : MathspectralmethodCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_spectral_method_cluster_max(s : MathspectralmethodCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_spectral_method_cluster_to_string(s : MathspectralmethodCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspectralmethodModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_spectral_method_model_make(size : Int) -> MathspectralmethodModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_spectral_method_model_len(s : MathspectralmethodModel) -> Int { s.size }

pub fn math_spectral_method_model_get(s : MathspectralmethodModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_spectral_method_model_set(s : MathspectralmethodModel, i : Int, v : Double) -> MathspectralmethodModel {
  let result = math_spectral_method_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_spectral_method_model_sum(s : MathspectralmethodModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_spectral_method_model_mean(s : MathspectralmethodModel) -> Double {
  if s.size == 0 { 0.0 } else { math_spectral_method_model_sum(s) / s.size.to_double() }
}

pub fn math_spectral_method_model_scale(s : MathspectralmethodModel, f : Double) -> MathspectralmethodModel {
  let result = math_spectral_method_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_spectral_method_model_add(a : MathspectralmethodModel, b : MathspectralmethodModel) -> MathspectralmethodModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_spectral_method_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_spectral_method_model_copy(s : MathspectralmethodModel) -> MathspectralmethodModel {
  let result = math_spectral_method_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_spectral_method_model_fill(s : MathspectralmethodModel, v : Double) -> MathspectralmethodModel {
  let result = math_spectral_method_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_spectral_method_model_min(s : MathspectralmethodModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_spectral_method_model_max(s : MathspectralmethodModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_spectral_method_model_to_string(s : MathspectralmethodModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspectralmethodLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_spectral_method_layer_make(size : Int) -> MathspectralmethodLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_spectral_method_layer_len(s : MathspectralmethodLayer) -> Int { s.size }

pub fn math_spectral_method_layer_get(s : MathspectralmethodLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_spectral_method_layer_set(s : MathspectralmethodLayer, i : Int, v : Double) -> MathspectralmethodLayer {
  let result = math_spectral_method_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_spectral_method_layer_sum(s : MathspectralmethodLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_spectral_method_layer_mean(s : MathspectralmethodLayer) -> Double {
  if s.size == 0 { 0.0 } else { math_spectral_method_layer_sum(s) / s.size.to_double() }
}

pub fn math_spectral_method_layer_scale(s : MathspectralmethodLayer, f : Double) -> MathspectralmethodLayer {
  let result = math_spectral_method_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_spectral_method_layer_add(a : MathspectralmethodLayer, b : MathspectralmethodLayer) -> MathspectralmethodLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_spectral_method_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_spectral_method_layer_copy(s : MathspectralmethodLayer) -> MathspectralmethodLayer {
  let result = math_spectral_method_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_spectral_method_layer_fill(s : MathspectralmethodLayer, v : Double) -> MathspectralmethodLayer {
  let result = math_spectral_method_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_spectral_method_layer_min(s : MathspectralmethodLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_spectral_method_layer_max(s : MathspectralmethodLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_spectral_method_layer_to_string(s : MathspectralmethodLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspectralmethodBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_spectral_method_buffer_make(size : Int) -> MathspectralmethodBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_spectral_method_buffer_len(s : MathspectralmethodBuffer) -> Int { s.size }

pub fn math_spectral_method_buffer_get(s : MathspectralmethodBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_spectral_method_buffer_set(s : MathspectralmethodBuffer, i : Int, v : Double) -> MathspectralmethodBuffer {
  let result = math_spectral_method_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_spectral_method_buffer_sum(s : MathspectralmethodBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_spectral_method_buffer_mean(s : MathspectralmethodBuffer) -> Double {
  if s.size == 0 { 0.0 } else { math_spectral_method_buffer_sum(s) / s.size.to_double() }
}

pub fn math_spectral_method_buffer_scale(s : MathspectralmethodBuffer, f : Double) -> MathspectralmethodBuffer {
  let result = math_spectral_method_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_spectral_method_buffer_add(a : MathspectralmethodBuffer, b : MathspectralmethodBuffer) -> MathspectralmethodBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_spectral_method_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_spectral_method_buffer_copy(s : MathspectralmethodBuffer) -> MathspectralmethodBuffer {
  let result = math_spectral_method_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_spectral_method_buffer_fill(s : MathspectralmethodBuffer, v : Double) -> MathspectralmethodBuffer {
  let result = math_spectral_method_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_spectral_method_buffer_min(s : MathspectralmethodBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_spectral_method_buffer_max(s : MathspectralmethodBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_spectral_method_buffer_to_string(s : MathspectralmethodBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspectralmethodCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_spectral_method_cursor_make(size : Int) -> MathspectralmethodCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_spectral_method_cursor_len(s : MathspectralmethodCursor) -> Int { s.size }

pub fn math_spectral_method_cursor_get(s : MathspectralmethodCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_spectral_method_cursor_set(s : MathspectralmethodCursor, i : Int, v : Double) -> MathspectralmethodCursor {
  let result = math_spectral_method_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_spectral_method_cursor_sum(s : MathspectralmethodCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_spectral_method_cursor_mean(s : MathspectralmethodCursor) -> Double {
  if s.size == 0 { 0.0 } else { math_spectral_method_cursor_sum(s) / s.size.to_double() }
}

pub fn math_spectral_method_cursor_scale(s : MathspectralmethodCursor, f : Double) -> MathspectralmethodCursor {
  let result = math_spectral_method_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_spectral_method_cursor_add(a : MathspectralmethodCursor, b : MathspectralmethodCursor) -> MathspectralmethodCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_spectral_method_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_spectral_method_cursor_copy(s : MathspectralmethodCursor) -> MathspectralmethodCursor {
  let result = math_spectral_method_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_spectral_method_cursor_fill(s : MathspectralmethodCursor, v : Double) -> MathspectralmethodCursor {
  let result = math_spectral_method_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_spectral_method_cursor_min(s : MathspectralmethodCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_spectral_method_cursor_max(s : MathspectralmethodCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_spectral_method_cursor_to_string(s : MathspectralmethodCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspectralmethodView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_spectral_method_view_make(size : Int) -> MathspectralmethodView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_spectral_method_view_len(s : MathspectralmethodView) -> Int { s.size }

pub fn math_spectral_method_view_get(s : MathspectralmethodView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_spectral_method_view_set(s : MathspectralmethodView, i : Int, v : Double) -> MathspectralmethodView {
  let result = math_spectral_method_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_spectral_method_view_sum(s : MathspectralmethodView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_spectral_method_view_mean(s : MathspectralmethodView) -> Double {
  if s.size == 0 { 0.0 } else { math_spectral_method_view_sum(s) / s.size.to_double() }
}

pub fn math_spectral_method_view_scale(s : MathspectralmethodView, f : Double) -> MathspectralmethodView {
  let result = math_spectral_method_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_spectral_method_view_add(a : MathspectralmethodView, b : MathspectralmethodView) -> MathspectralmethodView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_spectral_method_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_spectral_method_view_copy(s : MathspectralmethodView) -> MathspectralmethodView {
  let result = math_spectral_method_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_spectral_method_view_fill(s : MathspectralmethodView, v : Double) -> MathspectralmethodView {
  let result = math_spectral_method_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_spectral_method_view_min(s : MathspectralmethodView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_spectral_method_view_max(s : MathspectralmethodView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_spectral_method_view_to_string(s : MathspectralmethodView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspectralmethodRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_spectral_method_range_make(size : Int) -> MathspectralmethodRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_spectral_method_range_len(s : MathspectralmethodRange) -> Int { s.size }

pub fn math_spectral_method_range_get(s : MathspectralmethodRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_spectral_method_range_set(s : MathspectralmethodRange, i : Int, v : Double) -> MathspectralmethodRange {
  let result = math_spectral_method_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_spectral_method_range_sum(s : MathspectralmethodRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_spectral_method_range_mean(s : MathspectralmethodRange) -> Double {
  if s.size == 0 { 0.0 } else { math_spectral_method_range_sum(s) / s.size.to_double() }
}

pub fn math_spectral_method_range_scale(s : MathspectralmethodRange, f : Double) -> MathspectralmethodRange {
  let result = math_spectral_method_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_spectral_method_range_add(a : MathspectralmethodRange, b : MathspectralmethodRange) -> MathspectralmethodRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_spectral_method_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_spectral_method_range_copy(s : MathspectralmethodRange) -> MathspectralmethodRange {
  let result = math_spectral_method_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_spectral_method_range_fill(s : MathspectralmethodRange, v : Double) -> MathspectralmethodRange {
  let result = math_spectral_method_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_spectral_method_range_min(s : MathspectralmethodRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_spectral_method_range_max(s : MathspectralmethodRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_spectral_method_range_to_string(s : MathspectralmethodRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspectralmethodSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_spectral_method_slice_make(size : Int) -> MathspectralmethodSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_spectral_method_slice_len(s : MathspectralmethodSlice) -> Int { s.size }

pub fn math_spectral_method_slice_get(s : MathspectralmethodSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_spectral_method_slice_set(s : MathspectralmethodSlice, i : Int, v : Double) -> MathspectralmethodSlice {
  let result = math_spectral_method_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_spectral_method_slice_sum(s : MathspectralmethodSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_spectral_method_slice_mean(s : MathspectralmethodSlice) -> Double {
  if s.size == 0 { 0.0 } else { math_spectral_method_slice_sum(s) / s.size.to_double() }
}

pub fn math_spectral_method_slice_scale(s : MathspectralmethodSlice, f : Double) -> MathspectralmethodSlice {
  let result = math_spectral_method_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_spectral_method_slice_add(a : MathspectralmethodSlice, b : MathspectralmethodSlice) -> MathspectralmethodSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_spectral_method_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_spectral_method_slice_copy(s : MathspectralmethodSlice) -> MathspectralmethodSlice {
  let result = math_spectral_method_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_spectral_method_slice_fill(s : MathspectralmethodSlice, v : Double) -> MathspectralmethodSlice {
  let result = math_spectral_method_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_spectral_method_slice_min(s : MathspectralmethodSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_spectral_method_slice_max(s : MathspectralmethodSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_spectral_method_slice_to_string(s : MathspectralmethodSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn math_spectral_method_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_spectral_method_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_spectral_method_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_spectral_method_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_spectral_method_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_spectral_method_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_spectral_method_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_spectral_method_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_spectral_method_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_spectral_method_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_spectral_method_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_spectral_method_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_spectral_method_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_spectral_method_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_spectral_method_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_spectral_method_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_spectral_method_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_spectral_method_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_spectral_method_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_spectral_method_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_spectral_method_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_spectral_method_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_spectral_method_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_spectral_method_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_spectral_method_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

