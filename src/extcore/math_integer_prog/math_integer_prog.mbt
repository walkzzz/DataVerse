///===
/// extcore/math_integer_prog

pub(all) struct MathintegerprogPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn math_integer_prog_make_point(x : Double, y : Double) -> MathintegerprogPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn math_integer_prog_make_point3(x : Double, y : Double, z : Double) -> MathintegerprogPoint {
  { x, y, z, label: 0 }
}

pub fn math_integer_prog_point_x(pt : MathintegerprogPoint) -> Double { pt.x }

pub fn math_integer_prog_point_y(pt : MathintegerprogPoint) -> Double { pt.y }

pub fn math_integer_prog_point_z(pt : MathintegerprogPoint) -> Double { pt.z }

pub fn math_integer_prog_point_label(pt : MathintegerprogPoint) -> Int { pt.label }

pub fn math_integer_prog_point_dist(a : MathintegerprogPoint, b : MathintegerprogPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  math_integer_prog_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn math_integer_prog_point_add(a : MathintegerprogPoint, b : MathintegerprogPoint) -> MathintegerprogPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn math_integer_prog_point_sub(a : MathintegerprogPoint, b : MathintegerprogPoint) -> MathintegerprogPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn math_integer_prog_point_scale(pt : MathintegerprogPoint, s : Double) -> MathintegerprogPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn math_integer_prog_point_dot(a : MathintegerprogPoint, b : MathintegerprogPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn math_integer_prog_point_cross(a : MathintegerprogPoint, b : MathintegerprogPoint) -> MathintegerprogPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn math_integer_prog_point_norm(pt : MathintegerprogPoint) -> Double {
  math_integer_prog_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn math_integer_prog_point_normalize(pt : MathintegerprogPoint) -> MathintegerprogPoint {
  let n = math_integer_prog_point_norm(pt)
  if n < 0.0000001 { pt } else { math_integer_prog_point_scale(pt, 1.0 / n) }
}

pub fn math_integer_prog_point_negate(pt : MathintegerprogPoint) -> MathintegerprogPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn math_integer_prog_point_mid(a : MathintegerprogPoint, b : MathintegerprogPoint) -> MathintegerprogPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn math_integer_prog_point_lerp(a : MathintegerprogPoint, b : MathintegerprogPoint, t : Double) -> MathintegerprogPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn math_integer_prog_point_to_string(pt : MathintegerprogPoint) -> String {
  "(" + math_integer_prog_dbl(pt.x) + ", " + math_integer_prog_dbl(pt.y) + ", " + math_integer_prog_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct MathintegerprogSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn math_integer_prog_make_series(vals : Array[Double], name : String) -> MathintegerprogSeries {
  { vals, name, meta: 0 }
}

pub fn math_integer_prog_series_len(s : MathintegerprogSeries) -> Int { s.vals.length() }

pub fn math_integer_prog_series_sum(s : MathintegerprogSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn math_integer_prog_series_mean(s : MathintegerprogSeries) -> Double {
  let n = math_integer_prog_series_len(s)
  if n == 0 { 0.0 } else { math_integer_prog_series_sum(s) / n.to_double() }
}

pub fn math_integer_prog_series_min(s : MathintegerprogSeries) -> Double {
  let n = math_integer_prog_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn math_integer_prog_series_max(s : MathintegerprogSeries) -> Double {
  let n = math_integer_prog_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn math_integer_prog_series_range(s : MathintegerprogSeries) -> Double {
  math_integer_prog_series_max(s) - math_integer_prog_series_min(s)
}

pub fn math_integer_prog_series_var(s : MathintegerprogSeries) -> Double {
  let n = math_integer_prog_series_len(s)
  if n == 0 { 0.0 } else {
    let m = math_integer_prog_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn math_integer_prog_series_std(s : MathintegerprogSeries) -> Double { math_integer_prog_sqrt(math_integer_prog_series_var(s)) }

pub fn math_integer_prog_series_median(s : MathintegerprogSeries) -> Double {
  let n = math_integer_prog_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = math_integer_prog_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn math_integer_prog_series_scale(s : MathintegerprogSeries, f : Double) -> MathintegerprogSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = math_integer_prog_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn math_integer_prog_series_add(a : MathintegerprogSeries, b : MathintegerprogSeries) -> MathintegerprogSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = math_integer_prog_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn math_integer_prog_series_sub(a : MathintegerprogSeries, b : MathintegerprogSeries) -> MathintegerprogSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = math_integer_prog_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn math_integer_prog_series_normalize(s : MathintegerprogSeries) -> MathintegerprogSeries {
  let mn = math_integer_prog_series_min(s)
  let mx = math_integer_prog_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = math_integer_prog_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn math_integer_prog_series_cumsum(s : MathintegerprogSeries) -> MathintegerprogSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = math_integer_prog_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn math_integer_prog_series_to_string(s : MathintegerprogSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + math_integer_prog_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MathintegerprogMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn math_integer_prog_make_matrix(rows : Int, cols : Int, val : Double) -> MathintegerprogMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn math_integer_prog_matrix_identity(n : Int) -> MathintegerprogMatrix {
  let m = math_integer_prog_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn math_integer_prog_matrix_get(m : MathintegerprogMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn math_integer_prog_matrix_transpose(m : MathintegerprogMatrix) -> MathintegerprogMatrix {
  let result = math_integer_prog_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn math_integer_prog_matrix_add(a : MathintegerprogMatrix, b : MathintegerprogMatrix) -> MathintegerprogMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = math_integer_prog_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn math_integer_prog_matrix_scale(m : MathintegerprogMatrix, s : Double) -> MathintegerprogMatrix {
  let result = math_integer_prog_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn math_integer_prog_matrix_multiply(a : MathintegerprogMatrix, b : MathintegerprogMatrix) -> MathintegerprogMatrix {
  if a.cols != b.rows { return math_integer_prog_make_matrix(a.rows, b.cols, 0.0) }
  let result = math_integer_prog_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn math_integer_prog_matrix_trace(m : MathintegerprogMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn math_integer_prog_matrix_det(m : MathintegerprogMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn math_integer_prog_matrix_norm(m : MathintegerprogMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  math_integer_prog_sqrt(sum)
}

pub fn math_integer_prog_matrix_to_string(m : MathintegerprogMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + math_integer_prog_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct MathintegerprogVector {
  comps : Array[Double]
  dim : Int
}

pub fn math_integer_prog_make_vector(comps : Array[Double]) -> MathintegerprogVector {
  { comps, dim: comps.length() }
}

pub fn math_integer_prog_vector_zero(dim : Int) -> MathintegerprogVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn math_integer_prog_vector_add(a : MathintegerprogVector, b : MathintegerprogVector) -> MathintegerprogVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = math_integer_prog_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn math_integer_prog_vector_sub(a : MathintegerprogVector, b : MathintegerprogVector) -> MathintegerprogVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = math_integer_prog_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn math_integer_prog_vector_scale(v : MathintegerprogVector, s : Double) -> MathintegerprogVector {
  let mut result = []
  for i in 0..<v.dim { result = math_integer_prog_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn math_integer_prog_vector_dot(a : MathintegerprogVector, b : MathintegerprogVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn math_integer_prog_vector_norm(v : MathintegerprogVector) -> Double { math_integer_prog_sqrt(math_integer_prog_vector_dot(v, v)) }

pub fn math_integer_prog_vector_normalize(v : MathintegerprogVector) -> MathintegerprogVector {
  let n = math_integer_prog_vector_norm(v)
  if n < 0.0000001 { v } else { math_integer_prog_vector_scale(v, 1.0 / n) }
}

pub fn math_integer_prog_vector_dist(a : MathintegerprogVector, b : MathintegerprogVector) -> Double {
  math_integer_prog_vector_norm(math_integer_prog_vector_sub(a, b))
}

pub fn math_integer_prog_vector_to_string(v : MathintegerprogVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + math_integer_prog_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn math_integer_prog_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn math_integer_prog_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = math_integer_prog_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn math_integer_prog_std(data : Array[Double]) -> Double { math_integer_prog_sqrt(math_integer_prog_var(data)) }

pub fn math_integer_prog_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = math_integer_prog_mean(a); let mb = math_integer_prog_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn math_integer_prog_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = math_integer_prog_std(a); let sb = math_integer_prog_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { math_integer_prog_cov(a, b) / (sa * sb) }
}

pub fn math_integer_prog_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = math_integer_prog_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn math_integer_prog_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn math_integer_prog_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn math_integer_prog_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  math_integer_prog_sqrt(math_integer_prog_mse(pred, labels))
}

pub fn math_integer_prog_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + math_integer_prog_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn math_integer_prog_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = math_integer_prog_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn math_integer_prog_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn math_integer_prog_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn math_integer_prog_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = math_integer_prog_precision(pred, labels, pos); let r = math_integer_prog_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn math_integer_prog_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn math_integer_prog_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = math_integer_prog_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn math_integer_prog_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn math_integer_prog_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn math_integer_prog_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = math_integer_prog_gcd(a, b)
    (a / g) * b
  }
}

pub fn math_integer_prog_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn math_integer_prog_fibonacci(n : Int) -> Int {
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

pub fn math_integer_prog_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = math_integer_prog_min(data); let mx = math_integer_prog_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn math_integer_prog_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = math_integer_prog_mean(data); let sd = math_integer_prog_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn math_integer_prog_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn math_integer_prog_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn math_integer_prog_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn math_integer_prog_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn math_integer_prog_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn math_integer_prog_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn math_integer_prog_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn math_integer_prog_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn math_integer_prog_dbl(x : Double) -> String {
  let i = if x >= 0.0 { math_integer_prog_int(x) } else { -math_integer_prog_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { math_integer_prog_int(f * 1000000.0) } else { math_integer_prog_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn math_integer_prog_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn math_integer_prog_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct MathintegerprogFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_integer_prog_frame_make(size : Int) -> MathintegerprogFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_integer_prog_frame_len(s : MathintegerprogFrame) -> Int { s.size }

pub fn math_integer_prog_frame_get(s : MathintegerprogFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_integer_prog_frame_set(s : MathintegerprogFrame, i : Int, v : Double) -> MathintegerprogFrame {
  let result = math_integer_prog_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_integer_prog_frame_sum(s : MathintegerprogFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_integer_prog_frame_mean(s : MathintegerprogFrame) -> Double {
  if s.size == 0 { 0.0 } else { math_integer_prog_frame_sum(s) / s.size.to_double() }
}

pub fn math_integer_prog_frame_scale(s : MathintegerprogFrame, f : Double) -> MathintegerprogFrame {
  let result = math_integer_prog_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_integer_prog_frame_add(a : MathintegerprogFrame, b : MathintegerprogFrame) -> MathintegerprogFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_integer_prog_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_integer_prog_frame_copy(s : MathintegerprogFrame) -> MathintegerprogFrame {
  let result = math_integer_prog_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_integer_prog_frame_fill(s : MathintegerprogFrame, v : Double) -> MathintegerprogFrame {
  let result = math_integer_prog_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_integer_prog_frame_min(s : MathintegerprogFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_integer_prog_frame_max(s : MathintegerprogFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_integer_prog_frame_to_string(s : MathintegerprogFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathintegerprogTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_integer_prog_table_make(size : Int) -> MathintegerprogTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_integer_prog_table_len(s : MathintegerprogTable) -> Int { s.size }

pub fn math_integer_prog_table_get(s : MathintegerprogTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_integer_prog_table_set(s : MathintegerprogTable, i : Int, v : Double) -> MathintegerprogTable {
  let result = math_integer_prog_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_integer_prog_table_sum(s : MathintegerprogTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_integer_prog_table_mean(s : MathintegerprogTable) -> Double {
  if s.size == 0 { 0.0 } else { math_integer_prog_table_sum(s) / s.size.to_double() }
}

pub fn math_integer_prog_table_scale(s : MathintegerprogTable, f : Double) -> MathintegerprogTable {
  let result = math_integer_prog_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_integer_prog_table_add(a : MathintegerprogTable, b : MathintegerprogTable) -> MathintegerprogTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_integer_prog_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_integer_prog_table_copy(s : MathintegerprogTable) -> MathintegerprogTable {
  let result = math_integer_prog_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_integer_prog_table_fill(s : MathintegerprogTable, v : Double) -> MathintegerprogTable {
  let result = math_integer_prog_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_integer_prog_table_min(s : MathintegerprogTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_integer_prog_table_max(s : MathintegerprogTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_integer_prog_table_to_string(s : MathintegerprogTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathintegerprogGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_integer_prog_graphn_make(size : Int) -> MathintegerprogGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_integer_prog_graphn_len(s : MathintegerprogGraphN) -> Int { s.size }

pub fn math_integer_prog_graphn_get(s : MathintegerprogGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_integer_prog_graphn_set(s : MathintegerprogGraphN, i : Int, v : Double) -> MathintegerprogGraphN {
  let result = math_integer_prog_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_integer_prog_graphn_sum(s : MathintegerprogGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_integer_prog_graphn_mean(s : MathintegerprogGraphN) -> Double {
  if s.size == 0 { 0.0 } else { math_integer_prog_graphn_sum(s) / s.size.to_double() }
}

pub fn math_integer_prog_graphn_scale(s : MathintegerprogGraphN, f : Double) -> MathintegerprogGraphN {
  let result = math_integer_prog_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_integer_prog_graphn_add(a : MathintegerprogGraphN, b : MathintegerprogGraphN) -> MathintegerprogGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_integer_prog_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_integer_prog_graphn_copy(s : MathintegerprogGraphN) -> MathintegerprogGraphN {
  let result = math_integer_prog_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_integer_prog_graphn_fill(s : MathintegerprogGraphN, v : Double) -> MathintegerprogGraphN {
  let result = math_integer_prog_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_integer_prog_graphn_min(s : MathintegerprogGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_integer_prog_graphn_max(s : MathintegerprogGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_integer_prog_graphn_to_string(s : MathintegerprogGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathintegerprogNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_integer_prog_node_make(size : Int) -> MathintegerprogNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_integer_prog_node_len(s : MathintegerprogNode) -> Int { s.size }

pub fn math_integer_prog_node_get(s : MathintegerprogNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_integer_prog_node_set(s : MathintegerprogNode, i : Int, v : Double) -> MathintegerprogNode {
  let result = math_integer_prog_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_integer_prog_node_sum(s : MathintegerprogNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_integer_prog_node_mean(s : MathintegerprogNode) -> Double {
  if s.size == 0 { 0.0 } else { math_integer_prog_node_sum(s) / s.size.to_double() }
}

pub fn math_integer_prog_node_scale(s : MathintegerprogNode, f : Double) -> MathintegerprogNode {
  let result = math_integer_prog_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_integer_prog_node_add(a : MathintegerprogNode, b : MathintegerprogNode) -> MathintegerprogNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_integer_prog_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_integer_prog_node_copy(s : MathintegerprogNode) -> MathintegerprogNode {
  let result = math_integer_prog_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_integer_prog_node_fill(s : MathintegerprogNode, v : Double) -> MathintegerprogNode {
  let result = math_integer_prog_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_integer_prog_node_min(s : MathintegerprogNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_integer_prog_node_max(s : MathintegerprogNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_integer_prog_node_to_string(s : MathintegerprogNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathintegerprogEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_integer_prog_edge_make(size : Int) -> MathintegerprogEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_integer_prog_edge_len(s : MathintegerprogEdge) -> Int { s.size }

pub fn math_integer_prog_edge_get(s : MathintegerprogEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_integer_prog_edge_set(s : MathintegerprogEdge, i : Int, v : Double) -> MathintegerprogEdge {
  let result = math_integer_prog_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_integer_prog_edge_sum(s : MathintegerprogEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_integer_prog_edge_mean(s : MathintegerprogEdge) -> Double {
  if s.size == 0 { 0.0 } else { math_integer_prog_edge_sum(s) / s.size.to_double() }
}

pub fn math_integer_prog_edge_scale(s : MathintegerprogEdge, f : Double) -> MathintegerprogEdge {
  let result = math_integer_prog_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_integer_prog_edge_add(a : MathintegerprogEdge, b : MathintegerprogEdge) -> MathintegerprogEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_integer_prog_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_integer_prog_edge_copy(s : MathintegerprogEdge) -> MathintegerprogEdge {
  let result = math_integer_prog_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_integer_prog_edge_fill(s : MathintegerprogEdge, v : Double) -> MathintegerprogEdge {
  let result = math_integer_prog_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_integer_prog_edge_min(s : MathintegerprogEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_integer_prog_edge_max(s : MathintegerprogEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_integer_prog_edge_to_string(s : MathintegerprogEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathintegerprogPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_integer_prog_path_make(size : Int) -> MathintegerprogPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_integer_prog_path_len(s : MathintegerprogPath) -> Int { s.size }

pub fn math_integer_prog_path_get(s : MathintegerprogPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_integer_prog_path_set(s : MathintegerprogPath, i : Int, v : Double) -> MathintegerprogPath {
  let result = math_integer_prog_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_integer_prog_path_sum(s : MathintegerprogPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_integer_prog_path_mean(s : MathintegerprogPath) -> Double {
  if s.size == 0 { 0.0 } else { math_integer_prog_path_sum(s) / s.size.to_double() }
}

pub fn math_integer_prog_path_scale(s : MathintegerprogPath, f : Double) -> MathintegerprogPath {
  let result = math_integer_prog_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_integer_prog_path_add(a : MathintegerprogPath, b : MathintegerprogPath) -> MathintegerprogPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_integer_prog_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_integer_prog_path_copy(s : MathintegerprogPath) -> MathintegerprogPath {
  let result = math_integer_prog_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_integer_prog_path_fill(s : MathintegerprogPath, v : Double) -> MathintegerprogPath {
  let result = math_integer_prog_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_integer_prog_path_min(s : MathintegerprogPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_integer_prog_path_max(s : MathintegerprogPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_integer_prog_path_to_string(s : MathintegerprogPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathintegerprogCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_integer_prog_cluster_make(size : Int) -> MathintegerprogCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_integer_prog_cluster_len(s : MathintegerprogCluster) -> Int { s.size }

pub fn math_integer_prog_cluster_get(s : MathintegerprogCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_integer_prog_cluster_set(s : MathintegerprogCluster, i : Int, v : Double) -> MathintegerprogCluster {
  let result = math_integer_prog_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_integer_prog_cluster_sum(s : MathintegerprogCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_integer_prog_cluster_mean(s : MathintegerprogCluster) -> Double {
  if s.size == 0 { 0.0 } else { math_integer_prog_cluster_sum(s) / s.size.to_double() }
}

pub fn math_integer_prog_cluster_scale(s : MathintegerprogCluster, f : Double) -> MathintegerprogCluster {
  let result = math_integer_prog_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_integer_prog_cluster_add(a : MathintegerprogCluster, b : MathintegerprogCluster) -> MathintegerprogCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_integer_prog_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_integer_prog_cluster_copy(s : MathintegerprogCluster) -> MathintegerprogCluster {
  let result = math_integer_prog_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_integer_prog_cluster_fill(s : MathintegerprogCluster, v : Double) -> MathintegerprogCluster {
  let result = math_integer_prog_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_integer_prog_cluster_min(s : MathintegerprogCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_integer_prog_cluster_max(s : MathintegerprogCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_integer_prog_cluster_to_string(s : MathintegerprogCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathintegerprogModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_integer_prog_model_make(size : Int) -> MathintegerprogModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_integer_prog_model_len(s : MathintegerprogModel) -> Int { s.size }

pub fn math_integer_prog_model_get(s : MathintegerprogModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_integer_prog_model_set(s : MathintegerprogModel, i : Int, v : Double) -> MathintegerprogModel {
  let result = math_integer_prog_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_integer_prog_model_sum(s : MathintegerprogModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_integer_prog_model_mean(s : MathintegerprogModel) -> Double {
  if s.size == 0 { 0.0 } else { math_integer_prog_model_sum(s) / s.size.to_double() }
}

pub fn math_integer_prog_model_scale(s : MathintegerprogModel, f : Double) -> MathintegerprogModel {
  let result = math_integer_prog_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_integer_prog_model_add(a : MathintegerprogModel, b : MathintegerprogModel) -> MathintegerprogModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_integer_prog_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_integer_prog_model_copy(s : MathintegerprogModel) -> MathintegerprogModel {
  let result = math_integer_prog_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_integer_prog_model_fill(s : MathintegerprogModel, v : Double) -> MathintegerprogModel {
  let result = math_integer_prog_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_integer_prog_model_min(s : MathintegerprogModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_integer_prog_model_max(s : MathintegerprogModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_integer_prog_model_to_string(s : MathintegerprogModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathintegerprogLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_integer_prog_layer_make(size : Int) -> MathintegerprogLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_integer_prog_layer_len(s : MathintegerprogLayer) -> Int { s.size }

pub fn math_integer_prog_layer_get(s : MathintegerprogLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_integer_prog_layer_set(s : MathintegerprogLayer, i : Int, v : Double) -> MathintegerprogLayer {
  let result = math_integer_prog_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_integer_prog_layer_sum(s : MathintegerprogLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_integer_prog_layer_mean(s : MathintegerprogLayer) -> Double {
  if s.size == 0 { 0.0 } else { math_integer_prog_layer_sum(s) / s.size.to_double() }
}

pub fn math_integer_prog_layer_scale(s : MathintegerprogLayer, f : Double) -> MathintegerprogLayer {
  let result = math_integer_prog_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_integer_prog_layer_add(a : MathintegerprogLayer, b : MathintegerprogLayer) -> MathintegerprogLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_integer_prog_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_integer_prog_layer_copy(s : MathintegerprogLayer) -> MathintegerprogLayer {
  let result = math_integer_prog_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_integer_prog_layer_fill(s : MathintegerprogLayer, v : Double) -> MathintegerprogLayer {
  let result = math_integer_prog_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_integer_prog_layer_min(s : MathintegerprogLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_integer_prog_layer_max(s : MathintegerprogLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_integer_prog_layer_to_string(s : MathintegerprogLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathintegerprogBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_integer_prog_buffer_make(size : Int) -> MathintegerprogBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_integer_prog_buffer_len(s : MathintegerprogBuffer) -> Int { s.size }

pub fn math_integer_prog_buffer_get(s : MathintegerprogBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_integer_prog_buffer_set(s : MathintegerprogBuffer, i : Int, v : Double) -> MathintegerprogBuffer {
  let result = math_integer_prog_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_integer_prog_buffer_sum(s : MathintegerprogBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_integer_prog_buffer_mean(s : MathintegerprogBuffer) -> Double {
  if s.size == 0 { 0.0 } else { math_integer_prog_buffer_sum(s) / s.size.to_double() }
}

pub fn math_integer_prog_buffer_scale(s : MathintegerprogBuffer, f : Double) -> MathintegerprogBuffer {
  let result = math_integer_prog_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_integer_prog_buffer_add(a : MathintegerprogBuffer, b : MathintegerprogBuffer) -> MathintegerprogBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_integer_prog_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_integer_prog_buffer_copy(s : MathintegerprogBuffer) -> MathintegerprogBuffer {
  let result = math_integer_prog_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_integer_prog_buffer_fill(s : MathintegerprogBuffer, v : Double) -> MathintegerprogBuffer {
  let result = math_integer_prog_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_integer_prog_buffer_min(s : MathintegerprogBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_integer_prog_buffer_max(s : MathintegerprogBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_integer_prog_buffer_to_string(s : MathintegerprogBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathintegerprogCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_integer_prog_cursor_make(size : Int) -> MathintegerprogCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_integer_prog_cursor_len(s : MathintegerprogCursor) -> Int { s.size }

pub fn math_integer_prog_cursor_get(s : MathintegerprogCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_integer_prog_cursor_set(s : MathintegerprogCursor, i : Int, v : Double) -> MathintegerprogCursor {
  let result = math_integer_prog_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_integer_prog_cursor_sum(s : MathintegerprogCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_integer_prog_cursor_mean(s : MathintegerprogCursor) -> Double {
  if s.size == 0 { 0.0 } else { math_integer_prog_cursor_sum(s) / s.size.to_double() }
}

pub fn math_integer_prog_cursor_scale(s : MathintegerprogCursor, f : Double) -> MathintegerprogCursor {
  let result = math_integer_prog_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_integer_prog_cursor_add(a : MathintegerprogCursor, b : MathintegerprogCursor) -> MathintegerprogCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_integer_prog_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_integer_prog_cursor_copy(s : MathintegerprogCursor) -> MathintegerprogCursor {
  let result = math_integer_prog_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_integer_prog_cursor_fill(s : MathintegerprogCursor, v : Double) -> MathintegerprogCursor {
  let result = math_integer_prog_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_integer_prog_cursor_min(s : MathintegerprogCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_integer_prog_cursor_max(s : MathintegerprogCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_integer_prog_cursor_to_string(s : MathintegerprogCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathintegerprogView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_integer_prog_view_make(size : Int) -> MathintegerprogView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_integer_prog_view_len(s : MathintegerprogView) -> Int { s.size }

pub fn math_integer_prog_view_get(s : MathintegerprogView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_integer_prog_view_set(s : MathintegerprogView, i : Int, v : Double) -> MathintegerprogView {
  let result = math_integer_prog_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_integer_prog_view_sum(s : MathintegerprogView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_integer_prog_view_mean(s : MathintegerprogView) -> Double {
  if s.size == 0 { 0.0 } else { math_integer_prog_view_sum(s) / s.size.to_double() }
}

pub fn math_integer_prog_view_scale(s : MathintegerprogView, f : Double) -> MathintegerprogView {
  let result = math_integer_prog_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_integer_prog_view_add(a : MathintegerprogView, b : MathintegerprogView) -> MathintegerprogView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_integer_prog_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_integer_prog_view_copy(s : MathintegerprogView) -> MathintegerprogView {
  let result = math_integer_prog_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_integer_prog_view_fill(s : MathintegerprogView, v : Double) -> MathintegerprogView {
  let result = math_integer_prog_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_integer_prog_view_min(s : MathintegerprogView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_integer_prog_view_max(s : MathintegerprogView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_integer_prog_view_to_string(s : MathintegerprogView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathintegerprogRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_integer_prog_range_make(size : Int) -> MathintegerprogRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_integer_prog_range_len(s : MathintegerprogRange) -> Int { s.size }

pub fn math_integer_prog_range_get(s : MathintegerprogRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_integer_prog_range_set(s : MathintegerprogRange, i : Int, v : Double) -> MathintegerprogRange {
  let result = math_integer_prog_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_integer_prog_range_sum(s : MathintegerprogRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_integer_prog_range_mean(s : MathintegerprogRange) -> Double {
  if s.size == 0 { 0.0 } else { math_integer_prog_range_sum(s) / s.size.to_double() }
}

pub fn math_integer_prog_range_scale(s : MathintegerprogRange, f : Double) -> MathintegerprogRange {
  let result = math_integer_prog_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_integer_prog_range_add(a : MathintegerprogRange, b : MathintegerprogRange) -> MathintegerprogRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_integer_prog_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_integer_prog_range_copy(s : MathintegerprogRange) -> MathintegerprogRange {
  let result = math_integer_prog_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_integer_prog_range_fill(s : MathintegerprogRange, v : Double) -> MathintegerprogRange {
  let result = math_integer_prog_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_integer_prog_range_min(s : MathintegerprogRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_integer_prog_range_max(s : MathintegerprogRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_integer_prog_range_to_string(s : MathintegerprogRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathintegerprogSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_integer_prog_slice_make(size : Int) -> MathintegerprogSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_integer_prog_slice_len(s : MathintegerprogSlice) -> Int { s.size }

pub fn math_integer_prog_slice_get(s : MathintegerprogSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_integer_prog_slice_set(s : MathintegerprogSlice, i : Int, v : Double) -> MathintegerprogSlice {
  let result = math_integer_prog_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_integer_prog_slice_sum(s : MathintegerprogSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_integer_prog_slice_mean(s : MathintegerprogSlice) -> Double {
  if s.size == 0 { 0.0 } else { math_integer_prog_slice_sum(s) / s.size.to_double() }
}

pub fn math_integer_prog_slice_scale(s : MathintegerprogSlice, f : Double) -> MathintegerprogSlice {
  let result = math_integer_prog_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_integer_prog_slice_add(a : MathintegerprogSlice, b : MathintegerprogSlice) -> MathintegerprogSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_integer_prog_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_integer_prog_slice_copy(s : MathintegerprogSlice) -> MathintegerprogSlice {
  let result = math_integer_prog_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_integer_prog_slice_fill(s : MathintegerprogSlice, v : Double) -> MathintegerprogSlice {
  let result = math_integer_prog_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_integer_prog_slice_min(s : MathintegerprogSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_integer_prog_slice_max(s : MathintegerprogSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_integer_prog_slice_to_string(s : MathintegerprogSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn math_integer_prog_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_integer_prog_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_integer_prog_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_integer_prog_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_integer_prog_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_integer_prog_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_integer_prog_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_integer_prog_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_integer_prog_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_integer_prog_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_integer_prog_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_integer_prog_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_integer_prog_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_integer_prog_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_integer_prog_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_integer_prog_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_integer_prog_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_integer_prog_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_integer_prog_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_integer_prog_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_integer_prog_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_integer_prog_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_integer_prog_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_integer_prog_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_integer_prog_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

