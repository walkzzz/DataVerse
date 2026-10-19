///===
/// extcore/math_galerkin

pub(all) struct MathgalerkinPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn math_galerkin_make_point(x : Double, y : Double) -> MathgalerkinPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn math_galerkin_make_point3(x : Double, y : Double, z : Double) -> MathgalerkinPoint {
  { x, y, z, label: 0 }
}

pub fn math_galerkin_point_x(pt : MathgalerkinPoint) -> Double { pt.x }

pub fn math_galerkin_point_y(pt : MathgalerkinPoint) -> Double { pt.y }

pub fn math_galerkin_point_z(pt : MathgalerkinPoint) -> Double { pt.z }

pub fn math_galerkin_point_label(pt : MathgalerkinPoint) -> Int { pt.label }

pub fn math_galerkin_point_dist(a : MathgalerkinPoint, b : MathgalerkinPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  math_galerkin_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn math_galerkin_point_add(a : MathgalerkinPoint, b : MathgalerkinPoint) -> MathgalerkinPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn math_galerkin_point_sub(a : MathgalerkinPoint, b : MathgalerkinPoint) -> MathgalerkinPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn math_galerkin_point_scale(pt : MathgalerkinPoint, s : Double) -> MathgalerkinPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn math_galerkin_point_dot(a : MathgalerkinPoint, b : MathgalerkinPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn math_galerkin_point_cross(a : MathgalerkinPoint, b : MathgalerkinPoint) -> MathgalerkinPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn math_galerkin_point_norm(pt : MathgalerkinPoint) -> Double {
  math_galerkin_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn math_galerkin_point_normalize(pt : MathgalerkinPoint) -> MathgalerkinPoint {
  let n = math_galerkin_point_norm(pt)
  if n < 0.0000001 { pt } else { math_galerkin_point_scale(pt, 1.0 / n) }
}

pub fn math_galerkin_point_negate(pt : MathgalerkinPoint) -> MathgalerkinPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn math_galerkin_point_mid(a : MathgalerkinPoint, b : MathgalerkinPoint) -> MathgalerkinPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn math_galerkin_point_lerp(a : MathgalerkinPoint, b : MathgalerkinPoint, t : Double) -> MathgalerkinPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn math_galerkin_point_to_string(pt : MathgalerkinPoint) -> String {
  "(" + math_galerkin_dbl(pt.x) + ", " + math_galerkin_dbl(pt.y) + ", " + math_galerkin_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct MathgalerkinSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn math_galerkin_make_series(vals : Array[Double], name : String) -> MathgalerkinSeries {
  { vals, name, meta: 0 }
}

pub fn math_galerkin_series_len(s : MathgalerkinSeries) -> Int { s.vals.length() }

pub fn math_galerkin_series_sum(s : MathgalerkinSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn math_galerkin_series_mean(s : MathgalerkinSeries) -> Double {
  let n = math_galerkin_series_len(s)
  if n == 0 { 0.0 } else { math_galerkin_series_sum(s) / n.to_double() }
}

pub fn math_galerkin_series_min(s : MathgalerkinSeries) -> Double {
  let n = math_galerkin_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn math_galerkin_series_max(s : MathgalerkinSeries) -> Double {
  let n = math_galerkin_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn math_galerkin_series_range(s : MathgalerkinSeries) -> Double {
  math_galerkin_series_max(s) - math_galerkin_series_min(s)
}

pub fn math_galerkin_series_var(s : MathgalerkinSeries) -> Double {
  let n = math_galerkin_series_len(s)
  if n == 0 { 0.0 } else {
    let m = math_galerkin_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn math_galerkin_series_std(s : MathgalerkinSeries) -> Double { math_galerkin_sqrt(math_galerkin_series_var(s)) }

pub fn math_galerkin_series_median(s : MathgalerkinSeries) -> Double {
  let n = math_galerkin_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = math_galerkin_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn math_galerkin_series_scale(s : MathgalerkinSeries, f : Double) -> MathgalerkinSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = math_galerkin_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn math_galerkin_series_add(a : MathgalerkinSeries, b : MathgalerkinSeries) -> MathgalerkinSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = math_galerkin_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn math_galerkin_series_sub(a : MathgalerkinSeries, b : MathgalerkinSeries) -> MathgalerkinSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = math_galerkin_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn math_galerkin_series_normalize(s : MathgalerkinSeries) -> MathgalerkinSeries {
  let mn = math_galerkin_series_min(s)
  let mx = math_galerkin_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = math_galerkin_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn math_galerkin_series_cumsum(s : MathgalerkinSeries) -> MathgalerkinSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = math_galerkin_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn math_galerkin_series_to_string(s : MathgalerkinSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + math_galerkin_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MathgalerkinMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn math_galerkin_make_matrix(rows : Int, cols : Int, val : Double) -> MathgalerkinMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn math_galerkin_matrix_identity(n : Int) -> MathgalerkinMatrix {
  let m = math_galerkin_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn math_galerkin_matrix_get(m : MathgalerkinMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn math_galerkin_matrix_transpose(m : MathgalerkinMatrix) -> MathgalerkinMatrix {
  let result = math_galerkin_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn math_galerkin_matrix_add(a : MathgalerkinMatrix, b : MathgalerkinMatrix) -> MathgalerkinMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = math_galerkin_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn math_galerkin_matrix_scale(m : MathgalerkinMatrix, s : Double) -> MathgalerkinMatrix {
  let result = math_galerkin_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn math_galerkin_matrix_multiply(a : MathgalerkinMatrix, b : MathgalerkinMatrix) -> MathgalerkinMatrix {
  if a.cols != b.rows { return math_galerkin_make_matrix(a.rows, b.cols, 0.0) }
  let result = math_galerkin_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn math_galerkin_matrix_trace(m : MathgalerkinMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn math_galerkin_matrix_det(m : MathgalerkinMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn math_galerkin_matrix_norm(m : MathgalerkinMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  math_galerkin_sqrt(sum)
}

pub fn math_galerkin_matrix_to_string(m : MathgalerkinMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + math_galerkin_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct MathgalerkinVector {
  comps : Array[Double]
  dim : Int
}

pub fn math_galerkin_make_vector(comps : Array[Double]) -> MathgalerkinVector {
  { comps, dim: comps.length() }
}

pub fn math_galerkin_vector_zero(dim : Int) -> MathgalerkinVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn math_galerkin_vector_add(a : MathgalerkinVector, b : MathgalerkinVector) -> MathgalerkinVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = math_galerkin_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn math_galerkin_vector_sub(a : MathgalerkinVector, b : MathgalerkinVector) -> MathgalerkinVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = math_galerkin_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn math_galerkin_vector_scale(v : MathgalerkinVector, s : Double) -> MathgalerkinVector {
  let mut result = []
  for i in 0..<v.dim { result = math_galerkin_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn math_galerkin_vector_dot(a : MathgalerkinVector, b : MathgalerkinVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn math_galerkin_vector_norm(v : MathgalerkinVector) -> Double { math_galerkin_sqrt(math_galerkin_vector_dot(v, v)) }

pub fn math_galerkin_vector_normalize(v : MathgalerkinVector) -> MathgalerkinVector {
  let n = math_galerkin_vector_norm(v)
  if n < 0.0000001 { v } else { math_galerkin_vector_scale(v, 1.0 / n) }
}

pub fn math_galerkin_vector_dist(a : MathgalerkinVector, b : MathgalerkinVector) -> Double {
  math_galerkin_vector_norm(math_galerkin_vector_sub(a, b))
}

pub fn math_galerkin_vector_to_string(v : MathgalerkinVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + math_galerkin_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn math_galerkin_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn math_galerkin_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = math_galerkin_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn math_galerkin_std(data : Array[Double]) -> Double { math_galerkin_sqrt(math_galerkin_var(data)) }

pub fn math_galerkin_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = math_galerkin_mean(a); let mb = math_galerkin_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn math_galerkin_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = math_galerkin_std(a); let sb = math_galerkin_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { math_galerkin_cov(a, b) / (sa * sb) }
}

pub fn math_galerkin_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = math_galerkin_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn math_galerkin_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn math_galerkin_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn math_galerkin_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  math_galerkin_sqrt(math_galerkin_mse(pred, labels))
}

pub fn math_galerkin_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + math_galerkin_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn math_galerkin_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = math_galerkin_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn math_galerkin_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn math_galerkin_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn math_galerkin_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = math_galerkin_precision(pred, labels, pos); let r = math_galerkin_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn math_galerkin_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn math_galerkin_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = math_galerkin_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn math_galerkin_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn math_galerkin_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn math_galerkin_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = math_galerkin_gcd(a, b)
    (a / g) * b
  }
}

pub fn math_galerkin_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn math_galerkin_fibonacci(n : Int) -> Int {
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

pub fn math_galerkin_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = math_galerkin_min(data); let mx = math_galerkin_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn math_galerkin_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = math_galerkin_mean(data); let sd = math_galerkin_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn math_galerkin_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn math_galerkin_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn math_galerkin_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn math_galerkin_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn math_galerkin_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn math_galerkin_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn math_galerkin_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn math_galerkin_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn math_galerkin_dbl(x : Double) -> String {
  let i = if x >= 0.0 { math_galerkin_int(x) } else { -math_galerkin_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { math_galerkin_int(f * 1000000.0) } else { math_galerkin_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn math_galerkin_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn math_galerkin_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct MathgalerkinFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_galerkin_frame_make(size : Int) -> MathgalerkinFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_galerkin_frame_len(s : MathgalerkinFrame) -> Int { s.size }

pub fn math_galerkin_frame_get(s : MathgalerkinFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_galerkin_frame_set(s : MathgalerkinFrame, i : Int, v : Double) -> MathgalerkinFrame {
  let result = math_galerkin_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_galerkin_frame_sum(s : MathgalerkinFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_galerkin_frame_mean(s : MathgalerkinFrame) -> Double {
  if s.size == 0 { 0.0 } else { math_galerkin_frame_sum(s) / s.size.to_double() }
}

pub fn math_galerkin_frame_scale(s : MathgalerkinFrame, f : Double) -> MathgalerkinFrame {
  let result = math_galerkin_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_galerkin_frame_add(a : MathgalerkinFrame, b : MathgalerkinFrame) -> MathgalerkinFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_galerkin_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_galerkin_frame_copy(s : MathgalerkinFrame) -> MathgalerkinFrame {
  let result = math_galerkin_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_galerkin_frame_fill(s : MathgalerkinFrame, v : Double) -> MathgalerkinFrame {
  let result = math_galerkin_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_galerkin_frame_min(s : MathgalerkinFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_galerkin_frame_max(s : MathgalerkinFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_galerkin_frame_to_string(s : MathgalerkinFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathgalerkinTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_galerkin_table_make(size : Int) -> MathgalerkinTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_galerkin_table_len(s : MathgalerkinTable) -> Int { s.size }

pub fn math_galerkin_table_get(s : MathgalerkinTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_galerkin_table_set(s : MathgalerkinTable, i : Int, v : Double) -> MathgalerkinTable {
  let result = math_galerkin_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_galerkin_table_sum(s : MathgalerkinTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_galerkin_table_mean(s : MathgalerkinTable) -> Double {
  if s.size == 0 { 0.0 } else { math_galerkin_table_sum(s) / s.size.to_double() }
}

pub fn math_galerkin_table_scale(s : MathgalerkinTable, f : Double) -> MathgalerkinTable {
  let result = math_galerkin_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_galerkin_table_add(a : MathgalerkinTable, b : MathgalerkinTable) -> MathgalerkinTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_galerkin_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_galerkin_table_copy(s : MathgalerkinTable) -> MathgalerkinTable {
  let result = math_galerkin_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_galerkin_table_fill(s : MathgalerkinTable, v : Double) -> MathgalerkinTable {
  let result = math_galerkin_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_galerkin_table_min(s : MathgalerkinTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_galerkin_table_max(s : MathgalerkinTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_galerkin_table_to_string(s : MathgalerkinTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathgalerkinGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_galerkin_graphn_make(size : Int) -> MathgalerkinGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_galerkin_graphn_len(s : MathgalerkinGraphN) -> Int { s.size }

pub fn math_galerkin_graphn_get(s : MathgalerkinGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_galerkin_graphn_set(s : MathgalerkinGraphN, i : Int, v : Double) -> MathgalerkinGraphN {
  let result = math_galerkin_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_galerkin_graphn_sum(s : MathgalerkinGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_galerkin_graphn_mean(s : MathgalerkinGraphN) -> Double {
  if s.size == 0 { 0.0 } else { math_galerkin_graphn_sum(s) / s.size.to_double() }
}

pub fn math_galerkin_graphn_scale(s : MathgalerkinGraphN, f : Double) -> MathgalerkinGraphN {
  let result = math_galerkin_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_galerkin_graphn_add(a : MathgalerkinGraphN, b : MathgalerkinGraphN) -> MathgalerkinGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_galerkin_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_galerkin_graphn_copy(s : MathgalerkinGraphN) -> MathgalerkinGraphN {
  let result = math_galerkin_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_galerkin_graphn_fill(s : MathgalerkinGraphN, v : Double) -> MathgalerkinGraphN {
  let result = math_galerkin_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_galerkin_graphn_min(s : MathgalerkinGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_galerkin_graphn_max(s : MathgalerkinGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_galerkin_graphn_to_string(s : MathgalerkinGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathgalerkinNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_galerkin_node_make(size : Int) -> MathgalerkinNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_galerkin_node_len(s : MathgalerkinNode) -> Int { s.size }

pub fn math_galerkin_node_get(s : MathgalerkinNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_galerkin_node_set(s : MathgalerkinNode, i : Int, v : Double) -> MathgalerkinNode {
  let result = math_galerkin_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_galerkin_node_sum(s : MathgalerkinNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_galerkin_node_mean(s : MathgalerkinNode) -> Double {
  if s.size == 0 { 0.0 } else { math_galerkin_node_sum(s) / s.size.to_double() }
}

pub fn math_galerkin_node_scale(s : MathgalerkinNode, f : Double) -> MathgalerkinNode {
  let result = math_galerkin_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_galerkin_node_add(a : MathgalerkinNode, b : MathgalerkinNode) -> MathgalerkinNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_galerkin_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_galerkin_node_copy(s : MathgalerkinNode) -> MathgalerkinNode {
  let result = math_galerkin_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_galerkin_node_fill(s : MathgalerkinNode, v : Double) -> MathgalerkinNode {
  let result = math_galerkin_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_galerkin_node_min(s : MathgalerkinNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_galerkin_node_max(s : MathgalerkinNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_galerkin_node_to_string(s : MathgalerkinNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathgalerkinEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_galerkin_edge_make(size : Int) -> MathgalerkinEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_galerkin_edge_len(s : MathgalerkinEdge) -> Int { s.size }

pub fn math_galerkin_edge_get(s : MathgalerkinEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_galerkin_edge_set(s : MathgalerkinEdge, i : Int, v : Double) -> MathgalerkinEdge {
  let result = math_galerkin_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_galerkin_edge_sum(s : MathgalerkinEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_galerkin_edge_mean(s : MathgalerkinEdge) -> Double {
  if s.size == 0 { 0.0 } else { math_galerkin_edge_sum(s) / s.size.to_double() }
}

pub fn math_galerkin_edge_scale(s : MathgalerkinEdge, f : Double) -> MathgalerkinEdge {
  let result = math_galerkin_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_galerkin_edge_add(a : MathgalerkinEdge, b : MathgalerkinEdge) -> MathgalerkinEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_galerkin_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_galerkin_edge_copy(s : MathgalerkinEdge) -> MathgalerkinEdge {
  let result = math_galerkin_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_galerkin_edge_fill(s : MathgalerkinEdge, v : Double) -> MathgalerkinEdge {
  let result = math_galerkin_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_galerkin_edge_min(s : MathgalerkinEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_galerkin_edge_max(s : MathgalerkinEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_galerkin_edge_to_string(s : MathgalerkinEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathgalerkinPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_galerkin_path_make(size : Int) -> MathgalerkinPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_galerkin_path_len(s : MathgalerkinPath) -> Int { s.size }

pub fn math_galerkin_path_get(s : MathgalerkinPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_galerkin_path_set(s : MathgalerkinPath, i : Int, v : Double) -> MathgalerkinPath {
  let result = math_galerkin_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_galerkin_path_sum(s : MathgalerkinPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_galerkin_path_mean(s : MathgalerkinPath) -> Double {
  if s.size == 0 { 0.0 } else { math_galerkin_path_sum(s) / s.size.to_double() }
}

pub fn math_galerkin_path_scale(s : MathgalerkinPath, f : Double) -> MathgalerkinPath {
  let result = math_galerkin_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_galerkin_path_add(a : MathgalerkinPath, b : MathgalerkinPath) -> MathgalerkinPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_galerkin_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_galerkin_path_copy(s : MathgalerkinPath) -> MathgalerkinPath {
  let result = math_galerkin_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_galerkin_path_fill(s : MathgalerkinPath, v : Double) -> MathgalerkinPath {
  let result = math_galerkin_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_galerkin_path_min(s : MathgalerkinPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_galerkin_path_max(s : MathgalerkinPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_galerkin_path_to_string(s : MathgalerkinPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathgalerkinCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_galerkin_cluster_make(size : Int) -> MathgalerkinCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_galerkin_cluster_len(s : MathgalerkinCluster) -> Int { s.size }

pub fn math_galerkin_cluster_get(s : MathgalerkinCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_galerkin_cluster_set(s : MathgalerkinCluster, i : Int, v : Double) -> MathgalerkinCluster {
  let result = math_galerkin_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_galerkin_cluster_sum(s : MathgalerkinCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_galerkin_cluster_mean(s : MathgalerkinCluster) -> Double {
  if s.size == 0 { 0.0 } else { math_galerkin_cluster_sum(s) / s.size.to_double() }
}

pub fn math_galerkin_cluster_scale(s : MathgalerkinCluster, f : Double) -> MathgalerkinCluster {
  let result = math_galerkin_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_galerkin_cluster_add(a : MathgalerkinCluster, b : MathgalerkinCluster) -> MathgalerkinCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_galerkin_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_galerkin_cluster_copy(s : MathgalerkinCluster) -> MathgalerkinCluster {
  let result = math_galerkin_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_galerkin_cluster_fill(s : MathgalerkinCluster, v : Double) -> MathgalerkinCluster {
  let result = math_galerkin_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_galerkin_cluster_min(s : MathgalerkinCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_galerkin_cluster_max(s : MathgalerkinCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_galerkin_cluster_to_string(s : MathgalerkinCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathgalerkinModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_galerkin_model_make(size : Int) -> MathgalerkinModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_galerkin_model_len(s : MathgalerkinModel) -> Int { s.size }

pub fn math_galerkin_model_get(s : MathgalerkinModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_galerkin_model_set(s : MathgalerkinModel, i : Int, v : Double) -> MathgalerkinModel {
  let result = math_galerkin_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_galerkin_model_sum(s : MathgalerkinModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_galerkin_model_mean(s : MathgalerkinModel) -> Double {
  if s.size == 0 { 0.0 } else { math_galerkin_model_sum(s) / s.size.to_double() }
}

pub fn math_galerkin_model_scale(s : MathgalerkinModel, f : Double) -> MathgalerkinModel {
  let result = math_galerkin_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_galerkin_model_add(a : MathgalerkinModel, b : MathgalerkinModel) -> MathgalerkinModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_galerkin_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_galerkin_model_copy(s : MathgalerkinModel) -> MathgalerkinModel {
  let result = math_galerkin_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_galerkin_model_fill(s : MathgalerkinModel, v : Double) -> MathgalerkinModel {
  let result = math_galerkin_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_galerkin_model_min(s : MathgalerkinModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_galerkin_model_max(s : MathgalerkinModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_galerkin_model_to_string(s : MathgalerkinModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathgalerkinLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_galerkin_layer_make(size : Int) -> MathgalerkinLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_galerkin_layer_len(s : MathgalerkinLayer) -> Int { s.size }

pub fn math_galerkin_layer_get(s : MathgalerkinLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_galerkin_layer_set(s : MathgalerkinLayer, i : Int, v : Double) -> MathgalerkinLayer {
  let result = math_galerkin_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_galerkin_layer_sum(s : MathgalerkinLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_galerkin_layer_mean(s : MathgalerkinLayer) -> Double {
  if s.size == 0 { 0.0 } else { math_galerkin_layer_sum(s) / s.size.to_double() }
}

pub fn math_galerkin_layer_scale(s : MathgalerkinLayer, f : Double) -> MathgalerkinLayer {
  let result = math_galerkin_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_galerkin_layer_add(a : MathgalerkinLayer, b : MathgalerkinLayer) -> MathgalerkinLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_galerkin_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_galerkin_layer_copy(s : MathgalerkinLayer) -> MathgalerkinLayer {
  let result = math_galerkin_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_galerkin_layer_fill(s : MathgalerkinLayer, v : Double) -> MathgalerkinLayer {
  let result = math_galerkin_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_galerkin_layer_min(s : MathgalerkinLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_galerkin_layer_max(s : MathgalerkinLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_galerkin_layer_to_string(s : MathgalerkinLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathgalerkinBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_galerkin_buffer_make(size : Int) -> MathgalerkinBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_galerkin_buffer_len(s : MathgalerkinBuffer) -> Int { s.size }

pub fn math_galerkin_buffer_get(s : MathgalerkinBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_galerkin_buffer_set(s : MathgalerkinBuffer, i : Int, v : Double) -> MathgalerkinBuffer {
  let result = math_galerkin_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_galerkin_buffer_sum(s : MathgalerkinBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_galerkin_buffer_mean(s : MathgalerkinBuffer) -> Double {
  if s.size == 0 { 0.0 } else { math_galerkin_buffer_sum(s) / s.size.to_double() }
}

pub fn math_galerkin_buffer_scale(s : MathgalerkinBuffer, f : Double) -> MathgalerkinBuffer {
  let result = math_galerkin_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_galerkin_buffer_add(a : MathgalerkinBuffer, b : MathgalerkinBuffer) -> MathgalerkinBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_galerkin_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_galerkin_buffer_copy(s : MathgalerkinBuffer) -> MathgalerkinBuffer {
  let result = math_galerkin_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_galerkin_buffer_fill(s : MathgalerkinBuffer, v : Double) -> MathgalerkinBuffer {
  let result = math_galerkin_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_galerkin_buffer_min(s : MathgalerkinBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_galerkin_buffer_max(s : MathgalerkinBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_galerkin_buffer_to_string(s : MathgalerkinBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathgalerkinCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_galerkin_cursor_make(size : Int) -> MathgalerkinCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_galerkin_cursor_len(s : MathgalerkinCursor) -> Int { s.size }

pub fn math_galerkin_cursor_get(s : MathgalerkinCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_galerkin_cursor_set(s : MathgalerkinCursor, i : Int, v : Double) -> MathgalerkinCursor {
  let result = math_galerkin_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_galerkin_cursor_sum(s : MathgalerkinCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_galerkin_cursor_mean(s : MathgalerkinCursor) -> Double {
  if s.size == 0 { 0.0 } else { math_galerkin_cursor_sum(s) / s.size.to_double() }
}

pub fn math_galerkin_cursor_scale(s : MathgalerkinCursor, f : Double) -> MathgalerkinCursor {
  let result = math_galerkin_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_galerkin_cursor_add(a : MathgalerkinCursor, b : MathgalerkinCursor) -> MathgalerkinCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_galerkin_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_galerkin_cursor_copy(s : MathgalerkinCursor) -> MathgalerkinCursor {
  let result = math_galerkin_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_galerkin_cursor_fill(s : MathgalerkinCursor, v : Double) -> MathgalerkinCursor {
  let result = math_galerkin_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_galerkin_cursor_min(s : MathgalerkinCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_galerkin_cursor_max(s : MathgalerkinCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_galerkin_cursor_to_string(s : MathgalerkinCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathgalerkinView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_galerkin_view_make(size : Int) -> MathgalerkinView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_galerkin_view_len(s : MathgalerkinView) -> Int { s.size }

pub fn math_galerkin_view_get(s : MathgalerkinView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_galerkin_view_set(s : MathgalerkinView, i : Int, v : Double) -> MathgalerkinView {
  let result = math_galerkin_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_galerkin_view_sum(s : MathgalerkinView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_galerkin_view_mean(s : MathgalerkinView) -> Double {
  if s.size == 0 { 0.0 } else { math_galerkin_view_sum(s) / s.size.to_double() }
}

pub fn math_galerkin_view_scale(s : MathgalerkinView, f : Double) -> MathgalerkinView {
  let result = math_galerkin_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_galerkin_view_add(a : MathgalerkinView, b : MathgalerkinView) -> MathgalerkinView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_galerkin_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_galerkin_view_copy(s : MathgalerkinView) -> MathgalerkinView {
  let result = math_galerkin_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_galerkin_view_fill(s : MathgalerkinView, v : Double) -> MathgalerkinView {
  let result = math_galerkin_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_galerkin_view_min(s : MathgalerkinView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_galerkin_view_max(s : MathgalerkinView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_galerkin_view_to_string(s : MathgalerkinView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathgalerkinRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_galerkin_range_make(size : Int) -> MathgalerkinRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_galerkin_range_len(s : MathgalerkinRange) -> Int { s.size }

pub fn math_galerkin_range_get(s : MathgalerkinRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_galerkin_range_set(s : MathgalerkinRange, i : Int, v : Double) -> MathgalerkinRange {
  let result = math_galerkin_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_galerkin_range_sum(s : MathgalerkinRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_galerkin_range_mean(s : MathgalerkinRange) -> Double {
  if s.size == 0 { 0.0 } else { math_galerkin_range_sum(s) / s.size.to_double() }
}

pub fn math_galerkin_range_scale(s : MathgalerkinRange, f : Double) -> MathgalerkinRange {
  let result = math_galerkin_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_galerkin_range_add(a : MathgalerkinRange, b : MathgalerkinRange) -> MathgalerkinRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_galerkin_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_galerkin_range_copy(s : MathgalerkinRange) -> MathgalerkinRange {
  let result = math_galerkin_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_galerkin_range_fill(s : MathgalerkinRange, v : Double) -> MathgalerkinRange {
  let result = math_galerkin_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_galerkin_range_min(s : MathgalerkinRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_galerkin_range_max(s : MathgalerkinRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_galerkin_range_to_string(s : MathgalerkinRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathgalerkinSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_galerkin_slice_make(size : Int) -> MathgalerkinSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_galerkin_slice_len(s : MathgalerkinSlice) -> Int { s.size }

pub fn math_galerkin_slice_get(s : MathgalerkinSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_galerkin_slice_set(s : MathgalerkinSlice, i : Int, v : Double) -> MathgalerkinSlice {
  let result = math_galerkin_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_galerkin_slice_sum(s : MathgalerkinSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_galerkin_slice_mean(s : MathgalerkinSlice) -> Double {
  if s.size == 0 { 0.0 } else { math_galerkin_slice_sum(s) / s.size.to_double() }
}

pub fn math_galerkin_slice_scale(s : MathgalerkinSlice, f : Double) -> MathgalerkinSlice {
  let result = math_galerkin_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_galerkin_slice_add(a : MathgalerkinSlice, b : MathgalerkinSlice) -> MathgalerkinSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_galerkin_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_galerkin_slice_copy(s : MathgalerkinSlice) -> MathgalerkinSlice {
  let result = math_galerkin_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_galerkin_slice_fill(s : MathgalerkinSlice, v : Double) -> MathgalerkinSlice {
  let result = math_galerkin_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_galerkin_slice_min(s : MathgalerkinSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_galerkin_slice_max(s : MathgalerkinSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_galerkin_slice_to_string(s : MathgalerkinSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn math_galerkin_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_galerkin_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_galerkin_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_galerkin_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_galerkin_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_galerkin_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_galerkin_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_galerkin_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_galerkin_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_galerkin_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_galerkin_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_galerkin_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_galerkin_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_galerkin_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_galerkin_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_galerkin_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_galerkin_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_galerkin_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_galerkin_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_galerkin_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_galerkin_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_galerkin_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_galerkin_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_galerkin_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_galerkin_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

