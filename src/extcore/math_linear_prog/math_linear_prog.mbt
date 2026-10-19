///===
/// extcore/math_linear_prog

pub(all) struct MathlinearprogPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn math_linear_prog_make_point(x : Double, y : Double) -> MathlinearprogPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn math_linear_prog_make_point3(x : Double, y : Double, z : Double) -> MathlinearprogPoint {
  { x, y, z, label: 0 }
}

pub fn math_linear_prog_point_x(pt : MathlinearprogPoint) -> Double { pt.x }

pub fn math_linear_prog_point_y(pt : MathlinearprogPoint) -> Double { pt.y }

pub fn math_linear_prog_point_z(pt : MathlinearprogPoint) -> Double { pt.z }

pub fn math_linear_prog_point_label(pt : MathlinearprogPoint) -> Int { pt.label }

pub fn math_linear_prog_point_dist(a : MathlinearprogPoint, b : MathlinearprogPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  math_linear_prog_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn math_linear_prog_point_add(a : MathlinearprogPoint, b : MathlinearprogPoint) -> MathlinearprogPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn math_linear_prog_point_sub(a : MathlinearprogPoint, b : MathlinearprogPoint) -> MathlinearprogPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn math_linear_prog_point_scale(pt : MathlinearprogPoint, s : Double) -> MathlinearprogPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn math_linear_prog_point_dot(a : MathlinearprogPoint, b : MathlinearprogPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn math_linear_prog_point_cross(a : MathlinearprogPoint, b : MathlinearprogPoint) -> MathlinearprogPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn math_linear_prog_point_norm(pt : MathlinearprogPoint) -> Double {
  math_linear_prog_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn math_linear_prog_point_normalize(pt : MathlinearprogPoint) -> MathlinearprogPoint {
  let n = math_linear_prog_point_norm(pt)
  if n < 0.0000001 { pt } else { math_linear_prog_point_scale(pt, 1.0 / n) }
}

pub fn math_linear_prog_point_negate(pt : MathlinearprogPoint) -> MathlinearprogPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn math_linear_prog_point_mid(a : MathlinearprogPoint, b : MathlinearprogPoint) -> MathlinearprogPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn math_linear_prog_point_lerp(a : MathlinearprogPoint, b : MathlinearprogPoint, t : Double) -> MathlinearprogPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn math_linear_prog_point_to_string(pt : MathlinearprogPoint) -> String {
  "(" + math_linear_prog_dbl(pt.x) + ", " + math_linear_prog_dbl(pt.y) + ", " + math_linear_prog_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct MathlinearprogSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn math_linear_prog_make_series(vals : Array[Double], name : String) -> MathlinearprogSeries {
  { vals, name, meta: 0 }
}

pub fn math_linear_prog_series_len(s : MathlinearprogSeries) -> Int { s.vals.length() }

pub fn math_linear_prog_series_sum(s : MathlinearprogSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn math_linear_prog_series_mean(s : MathlinearprogSeries) -> Double {
  let n = math_linear_prog_series_len(s)
  if n == 0 { 0.0 } else { math_linear_prog_series_sum(s) / n.to_double() }
}

pub fn math_linear_prog_series_min(s : MathlinearprogSeries) -> Double {
  let n = math_linear_prog_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn math_linear_prog_series_max(s : MathlinearprogSeries) -> Double {
  let n = math_linear_prog_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn math_linear_prog_series_range(s : MathlinearprogSeries) -> Double {
  math_linear_prog_series_max(s) - math_linear_prog_series_min(s)
}

pub fn math_linear_prog_series_var(s : MathlinearprogSeries) -> Double {
  let n = math_linear_prog_series_len(s)
  if n == 0 { 0.0 } else {
    let m = math_linear_prog_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn math_linear_prog_series_std(s : MathlinearprogSeries) -> Double { math_linear_prog_sqrt(math_linear_prog_series_var(s)) }

pub fn math_linear_prog_series_median(s : MathlinearprogSeries) -> Double {
  let n = math_linear_prog_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = math_linear_prog_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn math_linear_prog_series_scale(s : MathlinearprogSeries, f : Double) -> MathlinearprogSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = math_linear_prog_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn math_linear_prog_series_add(a : MathlinearprogSeries, b : MathlinearprogSeries) -> MathlinearprogSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = math_linear_prog_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn math_linear_prog_series_sub(a : MathlinearprogSeries, b : MathlinearprogSeries) -> MathlinearprogSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = math_linear_prog_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn math_linear_prog_series_normalize(s : MathlinearprogSeries) -> MathlinearprogSeries {
  let mn = math_linear_prog_series_min(s)
  let mx = math_linear_prog_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = math_linear_prog_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn math_linear_prog_series_cumsum(s : MathlinearprogSeries) -> MathlinearprogSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = math_linear_prog_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn math_linear_prog_series_to_string(s : MathlinearprogSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + math_linear_prog_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MathlinearprogMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn math_linear_prog_make_matrix(rows : Int, cols : Int, val : Double) -> MathlinearprogMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn math_linear_prog_matrix_identity(n : Int) -> MathlinearprogMatrix {
  let m = math_linear_prog_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn math_linear_prog_matrix_get(m : MathlinearprogMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn math_linear_prog_matrix_transpose(m : MathlinearprogMatrix) -> MathlinearprogMatrix {
  let result = math_linear_prog_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn math_linear_prog_matrix_add(a : MathlinearprogMatrix, b : MathlinearprogMatrix) -> MathlinearprogMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = math_linear_prog_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn math_linear_prog_matrix_scale(m : MathlinearprogMatrix, s : Double) -> MathlinearprogMatrix {
  let result = math_linear_prog_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn math_linear_prog_matrix_multiply(a : MathlinearprogMatrix, b : MathlinearprogMatrix) -> MathlinearprogMatrix {
  if a.cols != b.rows { return math_linear_prog_make_matrix(a.rows, b.cols, 0.0) }
  let result = math_linear_prog_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn math_linear_prog_matrix_trace(m : MathlinearprogMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn math_linear_prog_matrix_det(m : MathlinearprogMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn math_linear_prog_matrix_norm(m : MathlinearprogMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  math_linear_prog_sqrt(sum)
}

pub fn math_linear_prog_matrix_to_string(m : MathlinearprogMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + math_linear_prog_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct MathlinearprogVector {
  comps : Array[Double]
  dim : Int
}

pub fn math_linear_prog_make_vector(comps : Array[Double]) -> MathlinearprogVector {
  { comps, dim: comps.length() }
}

pub fn math_linear_prog_vector_zero(dim : Int) -> MathlinearprogVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn math_linear_prog_vector_add(a : MathlinearprogVector, b : MathlinearprogVector) -> MathlinearprogVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = math_linear_prog_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn math_linear_prog_vector_sub(a : MathlinearprogVector, b : MathlinearprogVector) -> MathlinearprogVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = math_linear_prog_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn math_linear_prog_vector_scale(v : MathlinearprogVector, s : Double) -> MathlinearprogVector {
  let mut result = []
  for i in 0..<v.dim { result = math_linear_prog_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn math_linear_prog_vector_dot(a : MathlinearprogVector, b : MathlinearprogVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn math_linear_prog_vector_norm(v : MathlinearprogVector) -> Double { math_linear_prog_sqrt(math_linear_prog_vector_dot(v, v)) }

pub fn math_linear_prog_vector_normalize(v : MathlinearprogVector) -> MathlinearprogVector {
  let n = math_linear_prog_vector_norm(v)
  if n < 0.0000001 { v } else { math_linear_prog_vector_scale(v, 1.0 / n) }
}

pub fn math_linear_prog_vector_dist(a : MathlinearprogVector, b : MathlinearprogVector) -> Double {
  math_linear_prog_vector_norm(math_linear_prog_vector_sub(a, b))
}

pub fn math_linear_prog_vector_to_string(v : MathlinearprogVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + math_linear_prog_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn math_linear_prog_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn math_linear_prog_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = math_linear_prog_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn math_linear_prog_std(data : Array[Double]) -> Double { math_linear_prog_sqrt(math_linear_prog_var(data)) }

pub fn math_linear_prog_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = math_linear_prog_mean(a); let mb = math_linear_prog_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn math_linear_prog_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = math_linear_prog_std(a); let sb = math_linear_prog_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { math_linear_prog_cov(a, b) / (sa * sb) }
}

pub fn math_linear_prog_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = math_linear_prog_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn math_linear_prog_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn math_linear_prog_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn math_linear_prog_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  math_linear_prog_sqrt(math_linear_prog_mse(pred, labels))
}

pub fn math_linear_prog_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + math_linear_prog_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn math_linear_prog_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = math_linear_prog_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn math_linear_prog_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn math_linear_prog_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn math_linear_prog_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = math_linear_prog_precision(pred, labels, pos); let r = math_linear_prog_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn math_linear_prog_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn math_linear_prog_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = math_linear_prog_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn math_linear_prog_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn math_linear_prog_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn math_linear_prog_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = math_linear_prog_gcd(a, b)
    (a / g) * b
  }
}

pub fn math_linear_prog_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn math_linear_prog_fibonacci(n : Int) -> Int {
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

pub fn math_linear_prog_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = math_linear_prog_min(data); let mx = math_linear_prog_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn math_linear_prog_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = math_linear_prog_mean(data); let sd = math_linear_prog_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn math_linear_prog_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn math_linear_prog_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn math_linear_prog_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn math_linear_prog_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn math_linear_prog_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn math_linear_prog_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn math_linear_prog_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn math_linear_prog_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn math_linear_prog_dbl(x : Double) -> String {
  let i = if x >= 0.0 { math_linear_prog_int(x) } else { -math_linear_prog_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { math_linear_prog_int(f * 1000000.0) } else { math_linear_prog_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn math_linear_prog_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn math_linear_prog_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct MathlinearprogFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_linear_prog_frame_make(size : Int) -> MathlinearprogFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_linear_prog_frame_len(s : MathlinearprogFrame) -> Int { s.size }

pub fn math_linear_prog_frame_get(s : MathlinearprogFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_linear_prog_frame_set(s : MathlinearprogFrame, i : Int, v : Double) -> MathlinearprogFrame {
  let result = math_linear_prog_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_linear_prog_frame_sum(s : MathlinearprogFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_linear_prog_frame_mean(s : MathlinearprogFrame) -> Double {
  if s.size == 0 { 0.0 } else { math_linear_prog_frame_sum(s) / s.size.to_double() }
}

pub fn math_linear_prog_frame_scale(s : MathlinearprogFrame, f : Double) -> MathlinearprogFrame {
  let result = math_linear_prog_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_linear_prog_frame_add(a : MathlinearprogFrame, b : MathlinearprogFrame) -> MathlinearprogFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_linear_prog_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_linear_prog_frame_copy(s : MathlinearprogFrame) -> MathlinearprogFrame {
  let result = math_linear_prog_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_linear_prog_frame_fill(s : MathlinearprogFrame, v : Double) -> MathlinearprogFrame {
  let result = math_linear_prog_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_linear_prog_frame_min(s : MathlinearprogFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_linear_prog_frame_max(s : MathlinearprogFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_linear_prog_frame_to_string(s : MathlinearprogFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathlinearprogTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_linear_prog_table_make(size : Int) -> MathlinearprogTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_linear_prog_table_len(s : MathlinearprogTable) -> Int { s.size }

pub fn math_linear_prog_table_get(s : MathlinearprogTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_linear_prog_table_set(s : MathlinearprogTable, i : Int, v : Double) -> MathlinearprogTable {
  let result = math_linear_prog_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_linear_prog_table_sum(s : MathlinearprogTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_linear_prog_table_mean(s : MathlinearprogTable) -> Double {
  if s.size == 0 { 0.0 } else { math_linear_prog_table_sum(s) / s.size.to_double() }
}

pub fn math_linear_prog_table_scale(s : MathlinearprogTable, f : Double) -> MathlinearprogTable {
  let result = math_linear_prog_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_linear_prog_table_add(a : MathlinearprogTable, b : MathlinearprogTable) -> MathlinearprogTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_linear_prog_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_linear_prog_table_copy(s : MathlinearprogTable) -> MathlinearprogTable {
  let result = math_linear_prog_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_linear_prog_table_fill(s : MathlinearprogTable, v : Double) -> MathlinearprogTable {
  let result = math_linear_prog_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_linear_prog_table_min(s : MathlinearprogTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_linear_prog_table_max(s : MathlinearprogTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_linear_prog_table_to_string(s : MathlinearprogTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathlinearprogGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_linear_prog_graphn_make(size : Int) -> MathlinearprogGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_linear_prog_graphn_len(s : MathlinearprogGraphN) -> Int { s.size }

pub fn math_linear_prog_graphn_get(s : MathlinearprogGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_linear_prog_graphn_set(s : MathlinearprogGraphN, i : Int, v : Double) -> MathlinearprogGraphN {
  let result = math_linear_prog_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_linear_prog_graphn_sum(s : MathlinearprogGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_linear_prog_graphn_mean(s : MathlinearprogGraphN) -> Double {
  if s.size == 0 { 0.0 } else { math_linear_prog_graphn_sum(s) / s.size.to_double() }
}

pub fn math_linear_prog_graphn_scale(s : MathlinearprogGraphN, f : Double) -> MathlinearprogGraphN {
  let result = math_linear_prog_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_linear_prog_graphn_add(a : MathlinearprogGraphN, b : MathlinearprogGraphN) -> MathlinearprogGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_linear_prog_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_linear_prog_graphn_copy(s : MathlinearprogGraphN) -> MathlinearprogGraphN {
  let result = math_linear_prog_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_linear_prog_graphn_fill(s : MathlinearprogGraphN, v : Double) -> MathlinearprogGraphN {
  let result = math_linear_prog_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_linear_prog_graphn_min(s : MathlinearprogGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_linear_prog_graphn_max(s : MathlinearprogGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_linear_prog_graphn_to_string(s : MathlinearprogGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathlinearprogNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_linear_prog_node_make(size : Int) -> MathlinearprogNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_linear_prog_node_len(s : MathlinearprogNode) -> Int { s.size }

pub fn math_linear_prog_node_get(s : MathlinearprogNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_linear_prog_node_set(s : MathlinearprogNode, i : Int, v : Double) -> MathlinearprogNode {
  let result = math_linear_prog_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_linear_prog_node_sum(s : MathlinearprogNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_linear_prog_node_mean(s : MathlinearprogNode) -> Double {
  if s.size == 0 { 0.0 } else { math_linear_prog_node_sum(s) / s.size.to_double() }
}

pub fn math_linear_prog_node_scale(s : MathlinearprogNode, f : Double) -> MathlinearprogNode {
  let result = math_linear_prog_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_linear_prog_node_add(a : MathlinearprogNode, b : MathlinearprogNode) -> MathlinearprogNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_linear_prog_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_linear_prog_node_copy(s : MathlinearprogNode) -> MathlinearprogNode {
  let result = math_linear_prog_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_linear_prog_node_fill(s : MathlinearprogNode, v : Double) -> MathlinearprogNode {
  let result = math_linear_prog_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_linear_prog_node_min(s : MathlinearprogNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_linear_prog_node_max(s : MathlinearprogNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_linear_prog_node_to_string(s : MathlinearprogNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathlinearprogEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_linear_prog_edge_make(size : Int) -> MathlinearprogEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_linear_prog_edge_len(s : MathlinearprogEdge) -> Int { s.size }

pub fn math_linear_prog_edge_get(s : MathlinearprogEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_linear_prog_edge_set(s : MathlinearprogEdge, i : Int, v : Double) -> MathlinearprogEdge {
  let result = math_linear_prog_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_linear_prog_edge_sum(s : MathlinearprogEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_linear_prog_edge_mean(s : MathlinearprogEdge) -> Double {
  if s.size == 0 { 0.0 } else { math_linear_prog_edge_sum(s) / s.size.to_double() }
}

pub fn math_linear_prog_edge_scale(s : MathlinearprogEdge, f : Double) -> MathlinearprogEdge {
  let result = math_linear_prog_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_linear_prog_edge_add(a : MathlinearprogEdge, b : MathlinearprogEdge) -> MathlinearprogEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_linear_prog_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_linear_prog_edge_copy(s : MathlinearprogEdge) -> MathlinearprogEdge {
  let result = math_linear_prog_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_linear_prog_edge_fill(s : MathlinearprogEdge, v : Double) -> MathlinearprogEdge {
  let result = math_linear_prog_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_linear_prog_edge_min(s : MathlinearprogEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_linear_prog_edge_max(s : MathlinearprogEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_linear_prog_edge_to_string(s : MathlinearprogEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathlinearprogPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_linear_prog_path_make(size : Int) -> MathlinearprogPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_linear_prog_path_len(s : MathlinearprogPath) -> Int { s.size }

pub fn math_linear_prog_path_get(s : MathlinearprogPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_linear_prog_path_set(s : MathlinearprogPath, i : Int, v : Double) -> MathlinearprogPath {
  let result = math_linear_prog_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_linear_prog_path_sum(s : MathlinearprogPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_linear_prog_path_mean(s : MathlinearprogPath) -> Double {
  if s.size == 0 { 0.0 } else { math_linear_prog_path_sum(s) / s.size.to_double() }
}

pub fn math_linear_prog_path_scale(s : MathlinearprogPath, f : Double) -> MathlinearprogPath {
  let result = math_linear_prog_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_linear_prog_path_add(a : MathlinearprogPath, b : MathlinearprogPath) -> MathlinearprogPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_linear_prog_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_linear_prog_path_copy(s : MathlinearprogPath) -> MathlinearprogPath {
  let result = math_linear_prog_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_linear_prog_path_fill(s : MathlinearprogPath, v : Double) -> MathlinearprogPath {
  let result = math_linear_prog_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_linear_prog_path_min(s : MathlinearprogPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_linear_prog_path_max(s : MathlinearprogPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_linear_prog_path_to_string(s : MathlinearprogPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathlinearprogCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_linear_prog_cluster_make(size : Int) -> MathlinearprogCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_linear_prog_cluster_len(s : MathlinearprogCluster) -> Int { s.size }

pub fn math_linear_prog_cluster_get(s : MathlinearprogCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_linear_prog_cluster_set(s : MathlinearprogCluster, i : Int, v : Double) -> MathlinearprogCluster {
  let result = math_linear_prog_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_linear_prog_cluster_sum(s : MathlinearprogCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_linear_prog_cluster_mean(s : MathlinearprogCluster) -> Double {
  if s.size == 0 { 0.0 } else { math_linear_prog_cluster_sum(s) / s.size.to_double() }
}

pub fn math_linear_prog_cluster_scale(s : MathlinearprogCluster, f : Double) -> MathlinearprogCluster {
  let result = math_linear_prog_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_linear_prog_cluster_add(a : MathlinearprogCluster, b : MathlinearprogCluster) -> MathlinearprogCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_linear_prog_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_linear_prog_cluster_copy(s : MathlinearprogCluster) -> MathlinearprogCluster {
  let result = math_linear_prog_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_linear_prog_cluster_fill(s : MathlinearprogCluster, v : Double) -> MathlinearprogCluster {
  let result = math_linear_prog_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_linear_prog_cluster_min(s : MathlinearprogCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_linear_prog_cluster_max(s : MathlinearprogCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_linear_prog_cluster_to_string(s : MathlinearprogCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathlinearprogModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_linear_prog_model_make(size : Int) -> MathlinearprogModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_linear_prog_model_len(s : MathlinearprogModel) -> Int { s.size }

pub fn math_linear_prog_model_get(s : MathlinearprogModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_linear_prog_model_set(s : MathlinearprogModel, i : Int, v : Double) -> MathlinearprogModel {
  let result = math_linear_prog_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_linear_prog_model_sum(s : MathlinearprogModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_linear_prog_model_mean(s : MathlinearprogModel) -> Double {
  if s.size == 0 { 0.0 } else { math_linear_prog_model_sum(s) / s.size.to_double() }
}

pub fn math_linear_prog_model_scale(s : MathlinearprogModel, f : Double) -> MathlinearprogModel {
  let result = math_linear_prog_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_linear_prog_model_add(a : MathlinearprogModel, b : MathlinearprogModel) -> MathlinearprogModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_linear_prog_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_linear_prog_model_copy(s : MathlinearprogModel) -> MathlinearprogModel {
  let result = math_linear_prog_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_linear_prog_model_fill(s : MathlinearprogModel, v : Double) -> MathlinearprogModel {
  let result = math_linear_prog_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_linear_prog_model_min(s : MathlinearprogModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_linear_prog_model_max(s : MathlinearprogModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_linear_prog_model_to_string(s : MathlinearprogModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathlinearprogLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_linear_prog_layer_make(size : Int) -> MathlinearprogLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_linear_prog_layer_len(s : MathlinearprogLayer) -> Int { s.size }

pub fn math_linear_prog_layer_get(s : MathlinearprogLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_linear_prog_layer_set(s : MathlinearprogLayer, i : Int, v : Double) -> MathlinearprogLayer {
  let result = math_linear_prog_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_linear_prog_layer_sum(s : MathlinearprogLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_linear_prog_layer_mean(s : MathlinearprogLayer) -> Double {
  if s.size == 0 { 0.0 } else { math_linear_prog_layer_sum(s) / s.size.to_double() }
}

pub fn math_linear_prog_layer_scale(s : MathlinearprogLayer, f : Double) -> MathlinearprogLayer {
  let result = math_linear_prog_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_linear_prog_layer_add(a : MathlinearprogLayer, b : MathlinearprogLayer) -> MathlinearprogLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_linear_prog_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_linear_prog_layer_copy(s : MathlinearprogLayer) -> MathlinearprogLayer {
  let result = math_linear_prog_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_linear_prog_layer_fill(s : MathlinearprogLayer, v : Double) -> MathlinearprogLayer {
  let result = math_linear_prog_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_linear_prog_layer_min(s : MathlinearprogLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_linear_prog_layer_max(s : MathlinearprogLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_linear_prog_layer_to_string(s : MathlinearprogLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathlinearprogBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_linear_prog_buffer_make(size : Int) -> MathlinearprogBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_linear_prog_buffer_len(s : MathlinearprogBuffer) -> Int { s.size }

pub fn math_linear_prog_buffer_get(s : MathlinearprogBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_linear_prog_buffer_set(s : MathlinearprogBuffer, i : Int, v : Double) -> MathlinearprogBuffer {
  let result = math_linear_prog_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_linear_prog_buffer_sum(s : MathlinearprogBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_linear_prog_buffer_mean(s : MathlinearprogBuffer) -> Double {
  if s.size == 0 { 0.0 } else { math_linear_prog_buffer_sum(s) / s.size.to_double() }
}

pub fn math_linear_prog_buffer_scale(s : MathlinearprogBuffer, f : Double) -> MathlinearprogBuffer {
  let result = math_linear_prog_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_linear_prog_buffer_add(a : MathlinearprogBuffer, b : MathlinearprogBuffer) -> MathlinearprogBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_linear_prog_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_linear_prog_buffer_copy(s : MathlinearprogBuffer) -> MathlinearprogBuffer {
  let result = math_linear_prog_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_linear_prog_buffer_fill(s : MathlinearprogBuffer, v : Double) -> MathlinearprogBuffer {
  let result = math_linear_prog_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_linear_prog_buffer_min(s : MathlinearprogBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_linear_prog_buffer_max(s : MathlinearprogBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_linear_prog_buffer_to_string(s : MathlinearprogBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathlinearprogCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_linear_prog_cursor_make(size : Int) -> MathlinearprogCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_linear_prog_cursor_len(s : MathlinearprogCursor) -> Int { s.size }

pub fn math_linear_prog_cursor_get(s : MathlinearprogCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_linear_prog_cursor_set(s : MathlinearprogCursor, i : Int, v : Double) -> MathlinearprogCursor {
  let result = math_linear_prog_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_linear_prog_cursor_sum(s : MathlinearprogCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_linear_prog_cursor_mean(s : MathlinearprogCursor) -> Double {
  if s.size == 0 { 0.0 } else { math_linear_prog_cursor_sum(s) / s.size.to_double() }
}

pub fn math_linear_prog_cursor_scale(s : MathlinearprogCursor, f : Double) -> MathlinearprogCursor {
  let result = math_linear_prog_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_linear_prog_cursor_add(a : MathlinearprogCursor, b : MathlinearprogCursor) -> MathlinearprogCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_linear_prog_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_linear_prog_cursor_copy(s : MathlinearprogCursor) -> MathlinearprogCursor {
  let result = math_linear_prog_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_linear_prog_cursor_fill(s : MathlinearprogCursor, v : Double) -> MathlinearprogCursor {
  let result = math_linear_prog_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_linear_prog_cursor_min(s : MathlinearprogCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_linear_prog_cursor_max(s : MathlinearprogCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_linear_prog_cursor_to_string(s : MathlinearprogCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathlinearprogView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_linear_prog_view_make(size : Int) -> MathlinearprogView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_linear_prog_view_len(s : MathlinearprogView) -> Int { s.size }

pub fn math_linear_prog_view_get(s : MathlinearprogView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_linear_prog_view_set(s : MathlinearprogView, i : Int, v : Double) -> MathlinearprogView {
  let result = math_linear_prog_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_linear_prog_view_sum(s : MathlinearprogView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_linear_prog_view_mean(s : MathlinearprogView) -> Double {
  if s.size == 0 { 0.0 } else { math_linear_prog_view_sum(s) / s.size.to_double() }
}

pub fn math_linear_prog_view_scale(s : MathlinearprogView, f : Double) -> MathlinearprogView {
  let result = math_linear_prog_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_linear_prog_view_add(a : MathlinearprogView, b : MathlinearprogView) -> MathlinearprogView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_linear_prog_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_linear_prog_view_copy(s : MathlinearprogView) -> MathlinearprogView {
  let result = math_linear_prog_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_linear_prog_view_fill(s : MathlinearprogView, v : Double) -> MathlinearprogView {
  let result = math_linear_prog_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_linear_prog_view_min(s : MathlinearprogView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_linear_prog_view_max(s : MathlinearprogView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_linear_prog_view_to_string(s : MathlinearprogView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathlinearprogRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_linear_prog_range_make(size : Int) -> MathlinearprogRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_linear_prog_range_len(s : MathlinearprogRange) -> Int { s.size }

pub fn math_linear_prog_range_get(s : MathlinearprogRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_linear_prog_range_set(s : MathlinearprogRange, i : Int, v : Double) -> MathlinearprogRange {
  let result = math_linear_prog_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_linear_prog_range_sum(s : MathlinearprogRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_linear_prog_range_mean(s : MathlinearprogRange) -> Double {
  if s.size == 0 { 0.0 } else { math_linear_prog_range_sum(s) / s.size.to_double() }
}

pub fn math_linear_prog_range_scale(s : MathlinearprogRange, f : Double) -> MathlinearprogRange {
  let result = math_linear_prog_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_linear_prog_range_add(a : MathlinearprogRange, b : MathlinearprogRange) -> MathlinearprogRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_linear_prog_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_linear_prog_range_copy(s : MathlinearprogRange) -> MathlinearprogRange {
  let result = math_linear_prog_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_linear_prog_range_fill(s : MathlinearprogRange, v : Double) -> MathlinearprogRange {
  let result = math_linear_prog_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_linear_prog_range_min(s : MathlinearprogRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_linear_prog_range_max(s : MathlinearprogRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_linear_prog_range_to_string(s : MathlinearprogRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathlinearprogSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_linear_prog_slice_make(size : Int) -> MathlinearprogSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_linear_prog_slice_len(s : MathlinearprogSlice) -> Int { s.size }

pub fn math_linear_prog_slice_get(s : MathlinearprogSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_linear_prog_slice_set(s : MathlinearprogSlice, i : Int, v : Double) -> MathlinearprogSlice {
  let result = math_linear_prog_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_linear_prog_slice_sum(s : MathlinearprogSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_linear_prog_slice_mean(s : MathlinearprogSlice) -> Double {
  if s.size == 0 { 0.0 } else { math_linear_prog_slice_sum(s) / s.size.to_double() }
}

pub fn math_linear_prog_slice_scale(s : MathlinearprogSlice, f : Double) -> MathlinearprogSlice {
  let result = math_linear_prog_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_linear_prog_slice_add(a : MathlinearprogSlice, b : MathlinearprogSlice) -> MathlinearprogSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_linear_prog_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_linear_prog_slice_copy(s : MathlinearprogSlice) -> MathlinearprogSlice {
  let result = math_linear_prog_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_linear_prog_slice_fill(s : MathlinearprogSlice, v : Double) -> MathlinearprogSlice {
  let result = math_linear_prog_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_linear_prog_slice_min(s : MathlinearprogSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_linear_prog_slice_max(s : MathlinearprogSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_linear_prog_slice_to_string(s : MathlinearprogSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn math_linear_prog_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_linear_prog_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_linear_prog_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_linear_prog_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_linear_prog_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_linear_prog_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_linear_prog_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_linear_prog_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_linear_prog_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_linear_prog_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_linear_prog_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_linear_prog_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_linear_prog_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_linear_prog_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_linear_prog_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_linear_prog_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_linear_prog_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_linear_prog_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_linear_prog_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_linear_prog_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_linear_prog_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_linear_prog_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_linear_prog_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_linear_prog_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_linear_prog_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

