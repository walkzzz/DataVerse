///===
/// extcore/math_finite_diff

pub(all) struct MathfinitediffPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn math_finite_diff_make_point(x : Double, y : Double) -> MathfinitediffPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn math_finite_diff_make_point3(x : Double, y : Double, z : Double) -> MathfinitediffPoint {
  { x, y, z, label: 0 }
}

pub fn math_finite_diff_point_x(pt : MathfinitediffPoint) -> Double { pt.x }

pub fn math_finite_diff_point_y(pt : MathfinitediffPoint) -> Double { pt.y }

pub fn math_finite_diff_point_z(pt : MathfinitediffPoint) -> Double { pt.z }

pub fn math_finite_diff_point_label(pt : MathfinitediffPoint) -> Int { pt.label }

pub fn math_finite_diff_point_dist(a : MathfinitediffPoint, b : MathfinitediffPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  math_finite_diff_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn math_finite_diff_point_add(a : MathfinitediffPoint, b : MathfinitediffPoint) -> MathfinitediffPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn math_finite_diff_point_sub(a : MathfinitediffPoint, b : MathfinitediffPoint) -> MathfinitediffPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn math_finite_diff_point_scale(pt : MathfinitediffPoint, s : Double) -> MathfinitediffPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn math_finite_diff_point_dot(a : MathfinitediffPoint, b : MathfinitediffPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn math_finite_diff_point_cross(a : MathfinitediffPoint, b : MathfinitediffPoint) -> MathfinitediffPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn math_finite_diff_point_norm(pt : MathfinitediffPoint) -> Double {
  math_finite_diff_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn math_finite_diff_point_normalize(pt : MathfinitediffPoint) -> MathfinitediffPoint {
  let n = math_finite_diff_point_norm(pt)
  if n < 0.0000001 { pt } else { math_finite_diff_point_scale(pt, 1.0 / n) }
}

pub fn math_finite_diff_point_negate(pt : MathfinitediffPoint) -> MathfinitediffPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn math_finite_diff_point_mid(a : MathfinitediffPoint, b : MathfinitediffPoint) -> MathfinitediffPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn math_finite_diff_point_lerp(a : MathfinitediffPoint, b : MathfinitediffPoint, t : Double) -> MathfinitediffPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn math_finite_diff_point_to_string(pt : MathfinitediffPoint) -> String {
  "(" + math_finite_diff_dbl(pt.x) + ", " + math_finite_diff_dbl(pt.y) + ", " + math_finite_diff_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct MathfinitediffSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn math_finite_diff_make_series(vals : Array[Double], name : String) -> MathfinitediffSeries {
  { vals, name, meta: 0 }
}

pub fn math_finite_diff_series_len(s : MathfinitediffSeries) -> Int { s.vals.length() }

pub fn math_finite_diff_series_sum(s : MathfinitediffSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn math_finite_diff_series_mean(s : MathfinitediffSeries) -> Double {
  let n = math_finite_diff_series_len(s)
  if n == 0 { 0.0 } else { math_finite_diff_series_sum(s) / n.to_double() }
}

pub fn math_finite_diff_series_min(s : MathfinitediffSeries) -> Double {
  let n = math_finite_diff_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn math_finite_diff_series_max(s : MathfinitediffSeries) -> Double {
  let n = math_finite_diff_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn math_finite_diff_series_range(s : MathfinitediffSeries) -> Double {
  math_finite_diff_series_max(s) - math_finite_diff_series_min(s)
}

pub fn math_finite_diff_series_var(s : MathfinitediffSeries) -> Double {
  let n = math_finite_diff_series_len(s)
  if n == 0 { 0.0 } else {
    let m = math_finite_diff_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn math_finite_diff_series_std(s : MathfinitediffSeries) -> Double { math_finite_diff_sqrt(math_finite_diff_series_var(s)) }

pub fn math_finite_diff_series_median(s : MathfinitediffSeries) -> Double {
  let n = math_finite_diff_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = math_finite_diff_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn math_finite_diff_series_scale(s : MathfinitediffSeries, f : Double) -> MathfinitediffSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = math_finite_diff_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn math_finite_diff_series_add(a : MathfinitediffSeries, b : MathfinitediffSeries) -> MathfinitediffSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = math_finite_diff_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn math_finite_diff_series_sub(a : MathfinitediffSeries, b : MathfinitediffSeries) -> MathfinitediffSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = math_finite_diff_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn math_finite_diff_series_normalize(s : MathfinitediffSeries) -> MathfinitediffSeries {
  let mn = math_finite_diff_series_min(s)
  let mx = math_finite_diff_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = math_finite_diff_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn math_finite_diff_series_cumsum(s : MathfinitediffSeries) -> MathfinitediffSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = math_finite_diff_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn math_finite_diff_series_to_string(s : MathfinitediffSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + math_finite_diff_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MathfinitediffMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn math_finite_diff_make_matrix(rows : Int, cols : Int, val : Double) -> MathfinitediffMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn math_finite_diff_matrix_identity(n : Int) -> MathfinitediffMatrix {
  let m = math_finite_diff_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn math_finite_diff_matrix_get(m : MathfinitediffMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn math_finite_diff_matrix_transpose(m : MathfinitediffMatrix) -> MathfinitediffMatrix {
  let result = math_finite_diff_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn math_finite_diff_matrix_add(a : MathfinitediffMatrix, b : MathfinitediffMatrix) -> MathfinitediffMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = math_finite_diff_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn math_finite_diff_matrix_scale(m : MathfinitediffMatrix, s : Double) -> MathfinitediffMatrix {
  let result = math_finite_diff_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn math_finite_diff_matrix_multiply(a : MathfinitediffMatrix, b : MathfinitediffMatrix) -> MathfinitediffMatrix {
  if a.cols != b.rows { return math_finite_diff_make_matrix(a.rows, b.cols, 0.0) }
  let result = math_finite_diff_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn math_finite_diff_matrix_trace(m : MathfinitediffMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn math_finite_diff_matrix_det(m : MathfinitediffMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn math_finite_diff_matrix_norm(m : MathfinitediffMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  math_finite_diff_sqrt(sum)
}

pub fn math_finite_diff_matrix_to_string(m : MathfinitediffMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + math_finite_diff_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct MathfinitediffVector {
  comps : Array[Double]
  dim : Int
}

pub fn math_finite_diff_make_vector(comps : Array[Double]) -> MathfinitediffVector {
  { comps, dim: comps.length() }
}

pub fn math_finite_diff_vector_zero(dim : Int) -> MathfinitediffVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn math_finite_diff_vector_add(a : MathfinitediffVector, b : MathfinitediffVector) -> MathfinitediffVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = math_finite_diff_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn math_finite_diff_vector_sub(a : MathfinitediffVector, b : MathfinitediffVector) -> MathfinitediffVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = math_finite_diff_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn math_finite_diff_vector_scale(v : MathfinitediffVector, s : Double) -> MathfinitediffVector {
  let mut result = []
  for i in 0..<v.dim { result = math_finite_diff_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn math_finite_diff_vector_dot(a : MathfinitediffVector, b : MathfinitediffVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn math_finite_diff_vector_norm(v : MathfinitediffVector) -> Double { math_finite_diff_sqrt(math_finite_diff_vector_dot(v, v)) }

pub fn math_finite_diff_vector_normalize(v : MathfinitediffVector) -> MathfinitediffVector {
  let n = math_finite_diff_vector_norm(v)
  if n < 0.0000001 { v } else { math_finite_diff_vector_scale(v, 1.0 / n) }
}

pub fn math_finite_diff_vector_dist(a : MathfinitediffVector, b : MathfinitediffVector) -> Double {
  math_finite_diff_vector_norm(math_finite_diff_vector_sub(a, b))
}

pub fn math_finite_diff_vector_to_string(v : MathfinitediffVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + math_finite_diff_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn math_finite_diff_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn math_finite_diff_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = math_finite_diff_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn math_finite_diff_std(data : Array[Double]) -> Double { math_finite_diff_sqrt(math_finite_diff_var(data)) }

pub fn math_finite_diff_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = math_finite_diff_mean(a); let mb = math_finite_diff_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn math_finite_diff_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = math_finite_diff_std(a); let sb = math_finite_diff_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { math_finite_diff_cov(a, b) / (sa * sb) }
}

pub fn math_finite_diff_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = math_finite_diff_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn math_finite_diff_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn math_finite_diff_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn math_finite_diff_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  math_finite_diff_sqrt(math_finite_diff_mse(pred, labels))
}

pub fn math_finite_diff_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + math_finite_diff_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn math_finite_diff_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = math_finite_diff_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn math_finite_diff_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn math_finite_diff_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn math_finite_diff_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = math_finite_diff_precision(pred, labels, pos); let r = math_finite_diff_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn math_finite_diff_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn math_finite_diff_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = math_finite_diff_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn math_finite_diff_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn math_finite_diff_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn math_finite_diff_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = math_finite_diff_gcd(a, b)
    (a / g) * b
  }
}

pub fn math_finite_diff_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn math_finite_diff_fibonacci(n : Int) -> Int {
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

pub fn math_finite_diff_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = math_finite_diff_min(data); let mx = math_finite_diff_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn math_finite_diff_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = math_finite_diff_mean(data); let sd = math_finite_diff_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn math_finite_diff_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn math_finite_diff_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn math_finite_diff_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn math_finite_diff_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn math_finite_diff_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn math_finite_diff_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn math_finite_diff_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn math_finite_diff_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn math_finite_diff_dbl(x : Double) -> String {
  let i = if x >= 0.0 { math_finite_diff_int(x) } else { -math_finite_diff_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { math_finite_diff_int(f * 1000000.0) } else { math_finite_diff_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn math_finite_diff_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn math_finite_diff_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct MathfinitediffFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_finite_diff_frame_make(size : Int) -> MathfinitediffFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_finite_diff_frame_len(s : MathfinitediffFrame) -> Int { s.size }

pub fn math_finite_diff_frame_get(s : MathfinitediffFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_finite_diff_frame_set(s : MathfinitediffFrame, i : Int, v : Double) -> MathfinitediffFrame {
  let result = math_finite_diff_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_finite_diff_frame_sum(s : MathfinitediffFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_finite_diff_frame_mean(s : MathfinitediffFrame) -> Double {
  if s.size == 0 { 0.0 } else { math_finite_diff_frame_sum(s) / s.size.to_double() }
}

pub fn math_finite_diff_frame_scale(s : MathfinitediffFrame, f : Double) -> MathfinitediffFrame {
  let result = math_finite_diff_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_finite_diff_frame_add(a : MathfinitediffFrame, b : MathfinitediffFrame) -> MathfinitediffFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_finite_diff_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_finite_diff_frame_copy(s : MathfinitediffFrame) -> MathfinitediffFrame {
  let result = math_finite_diff_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_finite_diff_frame_fill(s : MathfinitediffFrame, v : Double) -> MathfinitediffFrame {
  let result = math_finite_diff_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_finite_diff_frame_min(s : MathfinitediffFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_finite_diff_frame_max(s : MathfinitediffFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_finite_diff_frame_to_string(s : MathfinitediffFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathfinitediffTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_finite_diff_table_make(size : Int) -> MathfinitediffTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_finite_diff_table_len(s : MathfinitediffTable) -> Int { s.size }

pub fn math_finite_diff_table_get(s : MathfinitediffTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_finite_diff_table_set(s : MathfinitediffTable, i : Int, v : Double) -> MathfinitediffTable {
  let result = math_finite_diff_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_finite_diff_table_sum(s : MathfinitediffTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_finite_diff_table_mean(s : MathfinitediffTable) -> Double {
  if s.size == 0 { 0.0 } else { math_finite_diff_table_sum(s) / s.size.to_double() }
}

pub fn math_finite_diff_table_scale(s : MathfinitediffTable, f : Double) -> MathfinitediffTable {
  let result = math_finite_diff_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_finite_diff_table_add(a : MathfinitediffTable, b : MathfinitediffTable) -> MathfinitediffTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_finite_diff_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_finite_diff_table_copy(s : MathfinitediffTable) -> MathfinitediffTable {
  let result = math_finite_diff_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_finite_diff_table_fill(s : MathfinitediffTable, v : Double) -> MathfinitediffTable {
  let result = math_finite_diff_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_finite_diff_table_min(s : MathfinitediffTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_finite_diff_table_max(s : MathfinitediffTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_finite_diff_table_to_string(s : MathfinitediffTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathfinitediffGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_finite_diff_graphn_make(size : Int) -> MathfinitediffGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_finite_diff_graphn_len(s : MathfinitediffGraphN) -> Int { s.size }

pub fn math_finite_diff_graphn_get(s : MathfinitediffGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_finite_diff_graphn_set(s : MathfinitediffGraphN, i : Int, v : Double) -> MathfinitediffGraphN {
  let result = math_finite_diff_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_finite_diff_graphn_sum(s : MathfinitediffGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_finite_diff_graphn_mean(s : MathfinitediffGraphN) -> Double {
  if s.size == 0 { 0.0 } else { math_finite_diff_graphn_sum(s) / s.size.to_double() }
}

pub fn math_finite_diff_graphn_scale(s : MathfinitediffGraphN, f : Double) -> MathfinitediffGraphN {
  let result = math_finite_diff_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_finite_diff_graphn_add(a : MathfinitediffGraphN, b : MathfinitediffGraphN) -> MathfinitediffGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_finite_diff_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_finite_diff_graphn_copy(s : MathfinitediffGraphN) -> MathfinitediffGraphN {
  let result = math_finite_diff_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_finite_diff_graphn_fill(s : MathfinitediffGraphN, v : Double) -> MathfinitediffGraphN {
  let result = math_finite_diff_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_finite_diff_graphn_min(s : MathfinitediffGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_finite_diff_graphn_max(s : MathfinitediffGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_finite_diff_graphn_to_string(s : MathfinitediffGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathfinitediffNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_finite_diff_node_make(size : Int) -> MathfinitediffNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_finite_diff_node_len(s : MathfinitediffNode) -> Int { s.size }

pub fn math_finite_diff_node_get(s : MathfinitediffNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_finite_diff_node_set(s : MathfinitediffNode, i : Int, v : Double) -> MathfinitediffNode {
  let result = math_finite_diff_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_finite_diff_node_sum(s : MathfinitediffNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_finite_diff_node_mean(s : MathfinitediffNode) -> Double {
  if s.size == 0 { 0.0 } else { math_finite_diff_node_sum(s) / s.size.to_double() }
}

pub fn math_finite_diff_node_scale(s : MathfinitediffNode, f : Double) -> MathfinitediffNode {
  let result = math_finite_diff_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_finite_diff_node_add(a : MathfinitediffNode, b : MathfinitediffNode) -> MathfinitediffNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_finite_diff_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_finite_diff_node_copy(s : MathfinitediffNode) -> MathfinitediffNode {
  let result = math_finite_diff_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_finite_diff_node_fill(s : MathfinitediffNode, v : Double) -> MathfinitediffNode {
  let result = math_finite_diff_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_finite_diff_node_min(s : MathfinitediffNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_finite_diff_node_max(s : MathfinitediffNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_finite_diff_node_to_string(s : MathfinitediffNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathfinitediffEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_finite_diff_edge_make(size : Int) -> MathfinitediffEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_finite_diff_edge_len(s : MathfinitediffEdge) -> Int { s.size }

pub fn math_finite_diff_edge_get(s : MathfinitediffEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_finite_diff_edge_set(s : MathfinitediffEdge, i : Int, v : Double) -> MathfinitediffEdge {
  let result = math_finite_diff_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_finite_diff_edge_sum(s : MathfinitediffEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_finite_diff_edge_mean(s : MathfinitediffEdge) -> Double {
  if s.size == 0 { 0.0 } else { math_finite_diff_edge_sum(s) / s.size.to_double() }
}

pub fn math_finite_diff_edge_scale(s : MathfinitediffEdge, f : Double) -> MathfinitediffEdge {
  let result = math_finite_diff_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_finite_diff_edge_add(a : MathfinitediffEdge, b : MathfinitediffEdge) -> MathfinitediffEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_finite_diff_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_finite_diff_edge_copy(s : MathfinitediffEdge) -> MathfinitediffEdge {
  let result = math_finite_diff_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_finite_diff_edge_fill(s : MathfinitediffEdge, v : Double) -> MathfinitediffEdge {
  let result = math_finite_diff_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_finite_diff_edge_min(s : MathfinitediffEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_finite_diff_edge_max(s : MathfinitediffEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_finite_diff_edge_to_string(s : MathfinitediffEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathfinitediffPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_finite_diff_path_make(size : Int) -> MathfinitediffPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_finite_diff_path_len(s : MathfinitediffPath) -> Int { s.size }

pub fn math_finite_diff_path_get(s : MathfinitediffPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_finite_diff_path_set(s : MathfinitediffPath, i : Int, v : Double) -> MathfinitediffPath {
  let result = math_finite_diff_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_finite_diff_path_sum(s : MathfinitediffPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_finite_diff_path_mean(s : MathfinitediffPath) -> Double {
  if s.size == 0 { 0.0 } else { math_finite_diff_path_sum(s) / s.size.to_double() }
}

pub fn math_finite_diff_path_scale(s : MathfinitediffPath, f : Double) -> MathfinitediffPath {
  let result = math_finite_diff_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_finite_diff_path_add(a : MathfinitediffPath, b : MathfinitediffPath) -> MathfinitediffPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_finite_diff_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_finite_diff_path_copy(s : MathfinitediffPath) -> MathfinitediffPath {
  let result = math_finite_diff_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_finite_diff_path_fill(s : MathfinitediffPath, v : Double) -> MathfinitediffPath {
  let result = math_finite_diff_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_finite_diff_path_min(s : MathfinitediffPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_finite_diff_path_max(s : MathfinitediffPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_finite_diff_path_to_string(s : MathfinitediffPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathfinitediffCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_finite_diff_cluster_make(size : Int) -> MathfinitediffCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_finite_diff_cluster_len(s : MathfinitediffCluster) -> Int { s.size }

pub fn math_finite_diff_cluster_get(s : MathfinitediffCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_finite_diff_cluster_set(s : MathfinitediffCluster, i : Int, v : Double) -> MathfinitediffCluster {
  let result = math_finite_diff_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_finite_diff_cluster_sum(s : MathfinitediffCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_finite_diff_cluster_mean(s : MathfinitediffCluster) -> Double {
  if s.size == 0 { 0.0 } else { math_finite_diff_cluster_sum(s) / s.size.to_double() }
}

pub fn math_finite_diff_cluster_scale(s : MathfinitediffCluster, f : Double) -> MathfinitediffCluster {
  let result = math_finite_diff_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_finite_diff_cluster_add(a : MathfinitediffCluster, b : MathfinitediffCluster) -> MathfinitediffCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_finite_diff_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_finite_diff_cluster_copy(s : MathfinitediffCluster) -> MathfinitediffCluster {
  let result = math_finite_diff_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_finite_diff_cluster_fill(s : MathfinitediffCluster, v : Double) -> MathfinitediffCluster {
  let result = math_finite_diff_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_finite_diff_cluster_min(s : MathfinitediffCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_finite_diff_cluster_max(s : MathfinitediffCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_finite_diff_cluster_to_string(s : MathfinitediffCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathfinitediffModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_finite_diff_model_make(size : Int) -> MathfinitediffModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_finite_diff_model_len(s : MathfinitediffModel) -> Int { s.size }

pub fn math_finite_diff_model_get(s : MathfinitediffModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_finite_diff_model_set(s : MathfinitediffModel, i : Int, v : Double) -> MathfinitediffModel {
  let result = math_finite_diff_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_finite_diff_model_sum(s : MathfinitediffModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_finite_diff_model_mean(s : MathfinitediffModel) -> Double {
  if s.size == 0 { 0.0 } else { math_finite_diff_model_sum(s) / s.size.to_double() }
}

pub fn math_finite_diff_model_scale(s : MathfinitediffModel, f : Double) -> MathfinitediffModel {
  let result = math_finite_diff_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_finite_diff_model_add(a : MathfinitediffModel, b : MathfinitediffModel) -> MathfinitediffModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_finite_diff_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_finite_diff_model_copy(s : MathfinitediffModel) -> MathfinitediffModel {
  let result = math_finite_diff_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_finite_diff_model_fill(s : MathfinitediffModel, v : Double) -> MathfinitediffModel {
  let result = math_finite_diff_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_finite_diff_model_min(s : MathfinitediffModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_finite_diff_model_max(s : MathfinitediffModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_finite_diff_model_to_string(s : MathfinitediffModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathfinitediffLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_finite_diff_layer_make(size : Int) -> MathfinitediffLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_finite_diff_layer_len(s : MathfinitediffLayer) -> Int { s.size }

pub fn math_finite_diff_layer_get(s : MathfinitediffLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_finite_diff_layer_set(s : MathfinitediffLayer, i : Int, v : Double) -> MathfinitediffLayer {
  let result = math_finite_diff_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_finite_diff_layer_sum(s : MathfinitediffLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_finite_diff_layer_mean(s : MathfinitediffLayer) -> Double {
  if s.size == 0 { 0.0 } else { math_finite_diff_layer_sum(s) / s.size.to_double() }
}

pub fn math_finite_diff_layer_scale(s : MathfinitediffLayer, f : Double) -> MathfinitediffLayer {
  let result = math_finite_diff_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_finite_diff_layer_add(a : MathfinitediffLayer, b : MathfinitediffLayer) -> MathfinitediffLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_finite_diff_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_finite_diff_layer_copy(s : MathfinitediffLayer) -> MathfinitediffLayer {
  let result = math_finite_diff_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_finite_diff_layer_fill(s : MathfinitediffLayer, v : Double) -> MathfinitediffLayer {
  let result = math_finite_diff_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_finite_diff_layer_min(s : MathfinitediffLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_finite_diff_layer_max(s : MathfinitediffLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_finite_diff_layer_to_string(s : MathfinitediffLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathfinitediffBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_finite_diff_buffer_make(size : Int) -> MathfinitediffBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_finite_diff_buffer_len(s : MathfinitediffBuffer) -> Int { s.size }

pub fn math_finite_diff_buffer_get(s : MathfinitediffBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_finite_diff_buffer_set(s : MathfinitediffBuffer, i : Int, v : Double) -> MathfinitediffBuffer {
  let result = math_finite_diff_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_finite_diff_buffer_sum(s : MathfinitediffBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_finite_diff_buffer_mean(s : MathfinitediffBuffer) -> Double {
  if s.size == 0 { 0.0 } else { math_finite_diff_buffer_sum(s) / s.size.to_double() }
}

pub fn math_finite_diff_buffer_scale(s : MathfinitediffBuffer, f : Double) -> MathfinitediffBuffer {
  let result = math_finite_diff_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_finite_diff_buffer_add(a : MathfinitediffBuffer, b : MathfinitediffBuffer) -> MathfinitediffBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_finite_diff_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_finite_diff_buffer_copy(s : MathfinitediffBuffer) -> MathfinitediffBuffer {
  let result = math_finite_diff_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_finite_diff_buffer_fill(s : MathfinitediffBuffer, v : Double) -> MathfinitediffBuffer {
  let result = math_finite_diff_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_finite_diff_buffer_min(s : MathfinitediffBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_finite_diff_buffer_max(s : MathfinitediffBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_finite_diff_buffer_to_string(s : MathfinitediffBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathfinitediffCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_finite_diff_cursor_make(size : Int) -> MathfinitediffCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_finite_diff_cursor_len(s : MathfinitediffCursor) -> Int { s.size }

pub fn math_finite_diff_cursor_get(s : MathfinitediffCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_finite_diff_cursor_set(s : MathfinitediffCursor, i : Int, v : Double) -> MathfinitediffCursor {
  let result = math_finite_diff_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_finite_diff_cursor_sum(s : MathfinitediffCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_finite_diff_cursor_mean(s : MathfinitediffCursor) -> Double {
  if s.size == 0 { 0.0 } else { math_finite_diff_cursor_sum(s) / s.size.to_double() }
}

pub fn math_finite_diff_cursor_scale(s : MathfinitediffCursor, f : Double) -> MathfinitediffCursor {
  let result = math_finite_diff_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_finite_diff_cursor_add(a : MathfinitediffCursor, b : MathfinitediffCursor) -> MathfinitediffCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_finite_diff_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_finite_diff_cursor_copy(s : MathfinitediffCursor) -> MathfinitediffCursor {
  let result = math_finite_diff_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_finite_diff_cursor_fill(s : MathfinitediffCursor, v : Double) -> MathfinitediffCursor {
  let result = math_finite_diff_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_finite_diff_cursor_min(s : MathfinitediffCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_finite_diff_cursor_max(s : MathfinitediffCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_finite_diff_cursor_to_string(s : MathfinitediffCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathfinitediffView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_finite_diff_view_make(size : Int) -> MathfinitediffView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_finite_diff_view_len(s : MathfinitediffView) -> Int { s.size }

pub fn math_finite_diff_view_get(s : MathfinitediffView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_finite_diff_view_set(s : MathfinitediffView, i : Int, v : Double) -> MathfinitediffView {
  let result = math_finite_diff_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_finite_diff_view_sum(s : MathfinitediffView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_finite_diff_view_mean(s : MathfinitediffView) -> Double {
  if s.size == 0 { 0.0 } else { math_finite_diff_view_sum(s) / s.size.to_double() }
}

pub fn math_finite_diff_view_scale(s : MathfinitediffView, f : Double) -> MathfinitediffView {
  let result = math_finite_diff_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_finite_diff_view_add(a : MathfinitediffView, b : MathfinitediffView) -> MathfinitediffView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_finite_diff_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_finite_diff_view_copy(s : MathfinitediffView) -> MathfinitediffView {
  let result = math_finite_diff_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_finite_diff_view_fill(s : MathfinitediffView, v : Double) -> MathfinitediffView {
  let result = math_finite_diff_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_finite_diff_view_min(s : MathfinitediffView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_finite_diff_view_max(s : MathfinitediffView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_finite_diff_view_to_string(s : MathfinitediffView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathfinitediffRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_finite_diff_range_make(size : Int) -> MathfinitediffRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_finite_diff_range_len(s : MathfinitediffRange) -> Int { s.size }

pub fn math_finite_diff_range_get(s : MathfinitediffRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_finite_diff_range_set(s : MathfinitediffRange, i : Int, v : Double) -> MathfinitediffRange {
  let result = math_finite_diff_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_finite_diff_range_sum(s : MathfinitediffRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_finite_diff_range_mean(s : MathfinitediffRange) -> Double {
  if s.size == 0 { 0.0 } else { math_finite_diff_range_sum(s) / s.size.to_double() }
}

pub fn math_finite_diff_range_scale(s : MathfinitediffRange, f : Double) -> MathfinitediffRange {
  let result = math_finite_diff_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_finite_diff_range_add(a : MathfinitediffRange, b : MathfinitediffRange) -> MathfinitediffRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_finite_diff_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_finite_diff_range_copy(s : MathfinitediffRange) -> MathfinitediffRange {
  let result = math_finite_diff_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_finite_diff_range_fill(s : MathfinitediffRange, v : Double) -> MathfinitediffRange {
  let result = math_finite_diff_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_finite_diff_range_min(s : MathfinitediffRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_finite_diff_range_max(s : MathfinitediffRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_finite_diff_range_to_string(s : MathfinitediffRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathfinitediffSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_finite_diff_slice_make(size : Int) -> MathfinitediffSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_finite_diff_slice_len(s : MathfinitediffSlice) -> Int { s.size }

pub fn math_finite_diff_slice_get(s : MathfinitediffSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_finite_diff_slice_set(s : MathfinitediffSlice, i : Int, v : Double) -> MathfinitediffSlice {
  let result = math_finite_diff_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_finite_diff_slice_sum(s : MathfinitediffSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_finite_diff_slice_mean(s : MathfinitediffSlice) -> Double {
  if s.size == 0 { 0.0 } else { math_finite_diff_slice_sum(s) / s.size.to_double() }
}

pub fn math_finite_diff_slice_scale(s : MathfinitediffSlice, f : Double) -> MathfinitediffSlice {
  let result = math_finite_diff_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_finite_diff_slice_add(a : MathfinitediffSlice, b : MathfinitediffSlice) -> MathfinitediffSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_finite_diff_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_finite_diff_slice_copy(s : MathfinitediffSlice) -> MathfinitediffSlice {
  let result = math_finite_diff_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_finite_diff_slice_fill(s : MathfinitediffSlice, v : Double) -> MathfinitediffSlice {
  let result = math_finite_diff_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_finite_diff_slice_min(s : MathfinitediffSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_finite_diff_slice_max(s : MathfinitediffSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_finite_diff_slice_to_string(s : MathfinitediffSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn math_finite_diff_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_finite_diff_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_finite_diff_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_finite_diff_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_finite_diff_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_finite_diff_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_finite_diff_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_finite_diff_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_finite_diff_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_finite_diff_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_finite_diff_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_finite_diff_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_finite_diff_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_finite_diff_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_finite_diff_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_finite_diff_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_finite_diff_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_finite_diff_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_finite_diff_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_finite_diff_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_finite_diff_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_finite_diff_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_finite_diff_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_finite_diff_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_finite_diff_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

